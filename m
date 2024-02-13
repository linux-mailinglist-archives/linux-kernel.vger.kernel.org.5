Return-Path: <linux-kernel+bounces-64516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02074853FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3972B2C3EB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA3D63110;
	Tue, 13 Feb 2024 23:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnmwXUdx"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3657D629FE;
	Tue, 13 Feb 2024 23:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865973; cv=none; b=au2di7VOqpgjzhTt8p0w0iJzDfSeVx63pabnWo05OHRe95T1TIERUOCfNuB1vu+8dwG9lmqwmzcJiNRZJkxIjZsJW8Wf7XZRb3VLnIEQUQGs4FHRRZJwA5OdIO1hHh5/ekxLipWlAPRL0At8f2kZBkWW8TnDwEWCLriVJyHqKcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865973; c=relaxed/simple;
	bh=8rQNC90YLJ6mPkMgHfah2RqbvBJTFoAIxs1E3rKcUyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UV7IRizKUgXdjyzZG4WKccZ5DImtOf1ByymQeHpMD3recPgIbTI0VauWrFUcUqXweiLVNzmNMjVSb70rUETpLG8QRFEh/4n75187xuhth6OQ+BxkKP/lw8Glyw8oBp2dKYM9vS8eXXv/EtM6qiqkQx5Rt12eJV4Pu8OVZfHL8vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnmwXUdx; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e2dbf54b2eso2138665a34.0;
        Tue, 13 Feb 2024 15:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707865971; x=1708470771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bHG9YyBPcsLtS0YcHjWtqLib139ZwP3Viw+PP4q1yP8=;
        b=EnmwXUdxGeE/w7Die4WUbS+0dG3lfBPh3Enk4cFCLFH9t8LQjxO3QLgFRt4WZlCPzI
         3pqePdByyyA20xlCNMrex5ZQ0Z/qJs+6Z1//nZW14VYWtjg1MGHMZfa8ydI3FjDLU30Z
         3VUKluMRv/Cp5RYzIPcnc/WkVefRDW4uH3moBqpgisLX4FtGmd9xVewvxJG5watwSA0J
         ISeVFnHXChG4wlOlCNPnkYh3kWtVeMvrqkwn/rsd1Y2281zGcTeJkNrV6Zdhqh/kYs8k
         Xu1lKqwl4J3DlqJhz3csZBgT+mW4BfwvuxyGst6hw5reSkn0v3DLAbEvHcqyZkBkQEhp
         2jlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707865971; x=1708470771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHG9YyBPcsLtS0YcHjWtqLib139ZwP3Viw+PP4q1yP8=;
        b=lWiSzcYpVz1/TZ3VYPZAnmK6LxS7n4uTnGAoAy7plm5DEuI3wk+/6TzOKU4yBOGjG5
         ufuAR8mzWv/fC+hMwn6oVYMeBpcSNywYczOA8hLoK54hIrTNz094DUSiPHEkl+TZGD0N
         b6ivxGNjc41OUonjI/9rTMWHx2rmOCxQNmPfEZ2lKuCt/LBV/AMSA/xHvUZfGc66upeF
         EqV9yKzaibQckVu5XtQ46cUVZcR/IvLMslSRg/ywbvp6how874PXZpyN43LBl/28Ju40
         +KTBxhSGLYDUfUUua/KjP3dYpEhFTA3twjOWPu+EbcLVHVsYK/Zzq6eVBXYEF+ocDpvB
         u5hg==
X-Forwarded-Encrypted: i=1; AJvYcCUOfnXX2FP7l2MkGRc/1qAOrGLBITiNfLks5dOmaDJUFjOzw74ktw6/X+GH8Gtdw+u1r3O7gQUxbDAEta/I/JAqVX3xsFKeVA1lflbzqzSyC6+qHHzYcRmAapm4egu6Ym+O2r6B
X-Gm-Message-State: AOJu0YxqXnH4iIag+mgSHcm8fGqwNAlDzewfaQEgkfWl/UzsVHGWZEwY
	YylfrGshPN1qtDuWbN1LJW2fGRlIW541QkLXsppOHBC16d2kYM4T
X-Google-Smtp-Source: AGHT+IHnDm1Jo6c8Bq2LivfbPgff1GLSFA757Ll9Z/ptOLiHiNiH4h3uemeCCBSnF4RPvMWlr8E71Q==
X-Received: by 2002:a05:6830:c7:b0:6e2:e324:ebe2 with SMTP id x7-20020a05683000c700b006e2e324ebe2mr1077446oto.25.1707865971015;
        Tue, 13 Feb 2024 15:12:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWamcADRTVc2kJG6BUoiRo0EOP074D4iFnbO+Z0oaGw0cnCrJOwq+UPRVO+vJtevV6RVrMladCpy0LBK6WtAlThfzM6XSeI3xtsuhFK8ykbl5zSUMkPo/XrmxAiNE71FgRn4fJ/eEQvqrz0YUuLupCIT+dWuJOva4IxvLf6vXNEQqbNJ5noJNB2Bpw5s+Ybwd6+cTEkhS1fDa6k7n5bI5gEkQ4MvbEGb0Fi3/GBGYitbt7aRI/Plb5QeQ2Oq1voovITSb/riZIE7Q3LNkM7hBXwcqXMXze0mS87FBQBk6PZQ1jvDyeurPCkn7lQ2f+I4LpE/BnMmVvqMyWnx3651XcQViscrL18qt8tOrJPWkslp13qOgP64bwbq3pTsMF/umALgGlsdCQ2x68Bf0mvxqqASHfA7bAfXtxVeYru0WH8QdI=
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id a19-20020ac85b93000000b0042c792f3255sm1506491qta.15.2024.02.13.15.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 15:12:50 -0800 (PST)
Message-ID: <025914ff-723f-4a4f-bf51-93e881a58dd4@gmail.com>
Date: Tue, 13 Feb 2024 15:12:47 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 03/15] net: dsa: vsc73xx: use macros for rgmii
 recognition
Content-Language: en-US
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: linus.walleij@linaro.org, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org
References: <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-4-paweldembicki@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240213220331.239031-4-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 14:03, Pawel Dembicki wrote:
> It's preparation for future use. At this moment, the RGMII port is used
> only for a connection to the MAC interface, but in the future, someone
> could connect a PHY to it. Using the "phy_interface_mode_is_rgmii" macro
> allows for the proper recognition of all RGMII modes.
> 
> Suggested-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


