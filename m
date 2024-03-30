Return-Path: <linux-kernel+bounces-125588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E719E892911
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 04:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EBC1C20E1D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 03:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FE9AD58;
	Sat, 30 Mar 2024 03:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkYOBY3v"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D069455;
	Sat, 30 Mar 2024 03:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711770234; cv=none; b=mxdUVei0HogvU4R6K9vRjMwb8XrnxKwAdKb2lIF4Sbg1/ey2RZrykavqx7CiddqH0ozTpC5590eyfe8H6HKs7AuFCZRi/KF2jBJMbM/29tjkBBoa7bK7QATEYx78kPiySlA7iTffRyB9wmTkprrRinzao6RQ8ib3pFHNaRFtnJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711770234; c=relaxed/simple;
	bh=qLozHbcAxiS6RZfhOhBPNSqqZe1+087gnKzwu2ySWY0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=e5yrrLfHzDJTtYvKjFTO6RkI+/3wvtpNDXQxpKdGWFGnxVZvoUpv9lSsGOEmw7Lo99sVdekZ4WI2iIqEzPWr7C/+lXrFEuPdwv+tiB4e/pSNV4tjh7XdJS4bMSiO08IqK9lfsMXBOpEYPqGSWc4qC9ZVX8PqZnhCY6J1MPDWiHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkYOBY3v; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ce2aada130so1731482a12.1;
        Fri, 29 Mar 2024 20:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711770232; x=1712375032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V0aFrcvOdRrw2LJgpAl/GiSisiyVoUVqeJo5aYZMnaw=;
        b=lkYOBY3vDINB9zqPOrNAnSpo6iBQiNyL8P7Wsw2UHblaTEyQfbbvhv2AG6giZAmPqy
         9+eWTofqDgFBvEhF6go/yHdZWz5YRZXUqr1Mu12btRwa/kz88SQ813QFTqEaicQXINYV
         Fx4N1L6va/+SYlvg5s7yzaM4NWYp+zuIznTq7qFZm9rbYlYJwmN8zbzF5QvpGliqUsAr
         Ssq34Mo54o6qTROwyS/MLwT4MCUVNY9ZJPw/tPMOF01iIdOzhMC7WfXuWiWRlluJHCAx
         FPeJ5/LG7YCpk9xYmmrw+1wWn2ZrINXB81zNk3s0pFh7xQJqTKiQi59OhspWevioI8hx
         iQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711770232; x=1712375032;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0aFrcvOdRrw2LJgpAl/GiSisiyVoUVqeJo5aYZMnaw=;
        b=nujdMRGcH0ciXuS3HO4Xkbawg/8aBhpadyILv3Df8nF23KJ4DPphct2V3NNmAE3U9C
         HVCgow0GK2awJpUD39m3vIGLPvZ/7dL3OWYw0bb4ONehGIQT9B4GdZyg4JytY0iF2Xpu
         4yUMldyiAGz2EeF5pdYGq3uGXDDq8KZww2rtmz+7+ymAx5M9KEDC/5iwjlF313Kn1Phr
         N0R+WNFM6iGdiLJwfMmrK4TQk4y7DV96XKv5DONNmGRDYyM5HrDlimfrdqbzal6UiroM
         +T4qVRZ0cWSvFZ1xgbKOsaGJz0xqCOtfa4vxWSzJSga+d+GLzE0egUENuc58QUQMyc0Q
         hJfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3JVgGo/B+UOoTX+JxaF7LIQAqIcgjG+reQ5dgxIOXsDUdgKVuCs/Atc41cSLLzh6Jubhjr4HqlkQpaahadIwMeqtSIU05d8IoZpgwnMKC3BSBJ09B+R51Fb6U7ygM/S7M6Pp1IoaS
X-Gm-Message-State: AOJu0YxnBzpcvjHAcfMIrHx7BviaKXnV60XLwn3r+VeW92wFbf6um6kT
	ZlwQMIrdmyOGbj8DW6cAZmP5v+FhgE6q9YBD5HDKkRQL900hM/6X
X-Google-Smtp-Source: AGHT+IH1I2VMdPnsYtD9tov25rVkm+mJa2ZfdH4yku1Tg0bXJ/woN7EXx3vSJIIcX6Ip1X0R4t7pYg==
X-Received: by 2002:a05:6a21:6d8e:b0:1a5:6aad:2e9d with SMTP id wl14-20020a056a216d8e00b001a56aad2e9dmr3868848pzb.6.1711770232252;
        Fri, 29 Mar 2024 20:43:52 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:ba1:cc2b:c45f:1699:a1c3? ([2600:8802:b00:ba1:cc2b:c45f:1699:a1c3])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001e07fe2fc30sm4199380plg.272.2024.03.29.20.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 20:43:51 -0700 (PDT)
Message-ID: <f91d530e-585a-488d-b408-fabed884072c@gmail.com>
Date: Fri, 29 Mar 2024 20:43:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v2 4/5] clk: scmi: Add support for re-parenting restricted
 clocks
To: Cristian Marussi <cristian.marussi@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com,
 vincent.guittot@linaro.org, peng.fan@oss.nxp.com, michal.simek@amd.com,
 quic_sibis@quicinc.com, quic_nkela@quicinc.com, souvik.chakravarty@arm.com,
 mturquette@baylibre.com, sboyd@kernel.org
References: <20240325210025.1448717-1-cristian.marussi@arm.com>
 <20240325210025.1448717-5-cristian.marussi@arm.com>
Content-Language: en-US
In-Reply-To: <20240325210025.1448717-5-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/03/2024 14:00, Cristian Marussi wrote:
> Some exposed SCMI Clocks could be marked as non-supporting re-parenting
> changes.
> Configure a clk_ops descriptor which does not provide the re-parenting
> callbacks for such clocks when registering with CLK framework.
> 
> CC: Michael Turquette <mturquette@baylibre.com>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: linux-clk@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

