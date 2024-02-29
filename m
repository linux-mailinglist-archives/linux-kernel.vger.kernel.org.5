Return-Path: <linux-kernel+bounces-87162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BF086D078
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD241C212FD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A119870ACD;
	Thu, 29 Feb 2024 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2BOQg0O"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637764AECF;
	Thu, 29 Feb 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227386; cv=none; b=IQwDqU11FIMj/nsIn/b8Q/DDMpm/3Tp7S9jD1ywJyS656Dc+Jw9wSo7+Gt3bMoOI2wIYa3/xVgx3h4c8tgkklSBYIXeaITYkKPHzelRF+WcezmuMWtTvS/2b7IJC72+YpYlKN0lrDe4w0sCTrwiTouBSTAIfD/usCQhIA3omzFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227386; c=relaxed/simple;
	bh=5nZwqA9tbOOr+DLByNR/d5dfwhDeaGca6ij6RK47SAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LfD9M1QEZJBxcIAHeGn3+ZbOQ13l0lvOMTVrM5ord4EvlZSine/2Falca9hmDT6SLkaON+CIne9X7mUSWlLNTgdWt0LuinGbbBdwBpkm4IntnwbL0lj9NCy83cBvheXOHU8LqSBe3xoHq4NX8dfIcPTKnqWgsh8cZFa9cm1a6M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2BOQg0O; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so8232185e9.1;
        Thu, 29 Feb 2024 09:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709227383; x=1709832183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bErguItfMvVUEbWhwhzZCYcvRJMN18OERsBymbfbLaM=;
        b=Y2BOQg0OhsAdjEXVOwq0hCPQk7IuaLvXDlnW5DwxA1n88Pku7C3ckedmNWtF4hnIkV
         5ilRUnwbBiZf8J3nH/oVJlyuT37v40cmDEewJSXZ2dFH1PYL960QVOgcXzKRvZCaWBCr
         +LZN/7Acw+LMqT5bRAQFlXQCS6JnwaFaKMn6OV9RrPOs6Ai8zVC9cxd+IUjXBEUf30lp
         /ej4tP4UigZQf7J2j4rI2XBF+lAnWmuiV0cedPs7yfTPgWba8u4mHi0DSJk+t9D1zS0X
         Nm1lREaB3QHPbwlfOwxSsJ8CIwgbIZKhtuMnlBWJ/gMftSPEown6iQTiIRBu9BWSzMgQ
         x7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709227383; x=1709832183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bErguItfMvVUEbWhwhzZCYcvRJMN18OERsBymbfbLaM=;
        b=Of9Gvk0TDYvhfbY6COnTUleXE2R6PQMUdKn4HmHCkEWUscMa+001vymh2MtU25dT6h
         rCfuElv8Jq/8eAaPxjzR+SCzvj99gxrBlvKoOr9TlWnAVq1gQRJTuGJTX6PqsKVBacdF
         XSIcrKbwhgysz467+IWHNjytemuA7dOJRadnhihNcdFNjiwtksbRKC1teeL8LYkXupEm
         p1cSC+hgpTo1JBMI7yM2wAJ+vl8vkyGfCxGCPfnAW77wjQg+Dcj8P1k1/GOAUJs6zI2Q
         Qi9ILQ1wOtHYZApGNWJmb3MP2YnU3ssHxPXES0xUEqnJMC3fRx3BuGFVsMaft18QeqsV
         GSbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5Tc54mXSDH5KhcztdRhj7kmm7aKoIjJQLgISzQs5dgVaVU4Xv924eDpjRR4MxTSXRqChgmEpn+ThsRa1tI19k5Q+wQh+Wy5ORSKiot/W2HA8uFPRy1cprgeqQc4j1EnCUbU5dsHy1Fg==
X-Gm-Message-State: AOJu0Yy6MQISASS0vGJNBwT62c8nm8D3yOLtPgrQN8ssdL9cnddl9ss6
	SIJoLIF0z0q1/NBJqu48+Oi9nKuxTL85g1PckS6ZXlqRQv6PO+5m
X-Google-Smtp-Source: AGHT+IGZRN4ap2o8wd40N+709S+xjf8UwMB/NxUn/8e2Adb62JephEiUJItk9npwpPGB/2e/RcRl2g==
X-Received: by 2002:a05:600c:3111:b0:412:b60b:96b2 with SMTP id g17-20020a05600c311100b00412b60b96b2mr2326997wmo.31.1709227382257;
        Thu, 29 Feb 2024 09:23:02 -0800 (PST)
Received: from [192.168.50.110] ([90.255.110.157])
        by smtp.gmail.com with ESMTPSA id je1-20020a05600c1f8100b004127ead18aasm2733244wmb.22.2024.02.29.09.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 09:23:01 -0800 (PST)
Message-ID: <8bbb2957-9452-424a-8e9f-4ddbd4f24722@gmail.com>
Date: Thu, 29 Feb 2024 17:23:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm: panel: st7701: Add Hardkernel ODROID-GO Ultra
 panel support
To: Jessica Zhang <quic_jesszhan@quicinc.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240221194528.1855714-1-greena88@gmail.com>
 <20240222164332.3864716-1-greena88@gmail.com>
 <20240222164332.3864716-2-greena88@gmail.com>
 <f9446923-acd3-41cf-92d4-676b946280c4@quicinc.com>
 <79a4b60e-24f3-47fd-b3b3-7d207cec1470@gmail.com>
 <a13eeb01-7df9-4577-975f-34b3aed8400f@quicinc.com>
Content-Language: en-GB
From: Adam Green <greena88@gmail.com>
In-Reply-To: <a13eeb01-7df9-4577-975f-34b3aed8400f@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/02/2024 21:29, Jessica Zhang wrote:
 > Got it. Was the shorter sleep time breaking the display and is it
 > required for the new panel to work?
 >
 > Thanks,
 >
 > Jessica Zhang

Hi Jessica,

I will be submitting a v3 shortly, the change to the sleep time was not 
necessary for the new panel
to work.

I have been able to re-use the gip sequence from the kd50t048a panel 
used in the Hardkernel Odroid
Go Super as I have been led to believe it is the same elida panel, 
unfortunately the same modes
used by that device do not work for the Odroid Go Ultra and so its still 
necessary to have the
patchset,

Best regards,

Adam

