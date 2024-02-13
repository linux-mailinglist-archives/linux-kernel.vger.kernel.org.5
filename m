Return-Path: <linux-kernel+bounces-64524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82278853FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F25F1F291BD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF216310E;
	Tue, 13 Feb 2024 23:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UW3K4hOY"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDFE629FE;
	Tue, 13 Feb 2024 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866127; cv=none; b=sL/bTReMG/R2yITrk0yrZrG+e2cMISnm+olgmQ78VA1MgNmP0qRRUktdIwgis/LV//f2tNt9BDKSPH1+UmV5oFSb0lrvaY+gh4tx06J+zNkRRgkOFMZ+cvQIO0WH9iDcbE2VTu1CtfNtprCttqgG+S6D/fBNh4YWvuGFuWK/fqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866127; c=relaxed/simple;
	bh=PY3J4S6EauW8fj+XZZM1388/2+rRzvgMyh+ZjtX7LIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1Lmia/WNzcwCVuUoDhbMAcsNTpl4Oobcrnzs6t26bYHvGzT/Ne41SAI0Q7yNN/Bx8WMSr9d3JsduiIJPRu49yuLxEeso7mdSvC3Da9yr1gDHICVxzSAoIxerWLhrqr3CHXhaehYb1QXL6qIHPD7ApHSJ8UU7LKRueAy7KytbPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UW3K4hOY; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42a029c8e62so30226891cf.1;
        Tue, 13 Feb 2024 15:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707866125; x=1708470925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/1120jGKl7lOqTVBnO0qLaVIMGkbPiaJJif82Yqxng=;
        b=UW3K4hOYgbSutrFFlRK0Y2K0jihCy3vaQWDOC8DikeM7W14tnLXMZw0gpHOpKE+B/q
         yg2ZIO2ZNb3/oQ+71wmqZeWkGxRtQ63zL2h7/2hhBSrPDKm5iL22FuTy7dul4nF0ECPX
         Vuz8ZL+ueq2KibzZB8T7CAPKKUUO07/vTjKn5gyuDKqe3nGPAkQODf4I7UHneGGLPIDN
         umZnn8hsRABXxAG8Zq6+bTZs2SiaDEkykKoZokIYh/DLWwC0ZKr9Co7ElIASeFghYQGi
         X7zpcsPzT1ZmbNDdL0MbDowmrZiab+PDRkD7Ek34g9lKIR21cqbDVRC/1+SyK3rW31uR
         24Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866125; x=1708470925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/1120jGKl7lOqTVBnO0qLaVIMGkbPiaJJif82Yqxng=;
        b=CJ7bvK5pj+0y+u9JcamD6q+P/yHJ3LtiGNoJHzmd0fC/y1Lk3zfa/OyDjlKGHLYuDP
         Risbla+69lNvTFPPE14/wbdFxc564B/v+0Azw8LtYW/HS7b4NFJzsaI0y+7YIeHlPesN
         CRJ8a8etpipKRJirIyFggtOWsMRmyAVKbM2bjazYk3ksF82Ie5V6d0ep+iHS1ujUWTv6
         Z9zUG6VRrw72D2B6qWggZZXb/dgM9YC6r8K/M00PWXP+Ws1LUKCNCr+jRchALuIsKs+Q
         m6y06KrFXET74l0XxQKalUW4REuyK6G0WKx6Hlvahyc4Nnm/hYcC1EBMT9s9X2Z3UEkg
         uBWw==
X-Forwarded-Encrypted: i=1; AJvYcCUB+JbImeyc0r/g4//l2eY5YylpI3c+bCGpBWdXCsuF6prT49jaCcS0W+31Puf627iG6vWz06rgtfA3G/fEobWYlMIekN+/Zz5pmP7jj3lKC4zyv5MFQBGOaATW245PcR3ljaqZ
X-Gm-Message-State: AOJu0YyTHyGq3bfdzAtBrgoHuey33lv1B/9YnvHv6ApQS2f9MLoYRC3q
	N30s3XsV7wbN2t9c6YGwO/MFgsmGEzcE4wXi7h9yjUQGnKf/nFbh
X-Google-Smtp-Source: AGHT+IHTF5ytKfeTfWY/11zLegTWRXj/8zn7/xDF9rCiBm0rUi48SNifYniBXTiYie+T97TbF+lDew==
X-Received: by 2002:a05:6214:242f:b0:68c:92ef:e5a9 with SMTP id gy15-20020a056214242f00b0068c92efe5a9mr1215888qvb.10.1707866124802;
        Tue, 13 Feb 2024 15:15:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpBLEv9C0l6zJIu8rdrfRO9jegJacMd+SCtFgPVMWhoSGH7PLKfZkhxa+SQK7EeZlinLu8+Rl1ikqcp5Wa0yP0AnzEZRUaI4MXDJNaOm13dsQMW30+t+E83QYKIC4IFbxNeonLJH/97F1Byy8cHCFp3Y2p/Uqt6fNjBtB3z3R9/UkHqPPZSDJiWQncnLknXrG3wmGyKnvvF7mIH2xsC4oIY7xckONGWrJszqNH01ZczUrGdAlibkmB/JW8Eo0514UMIcNPDeyyJ6l6vPSg0KxUYII2779Bf0uk2rq8RzAxM+NQVOqNVH2LeDhT8e+qAGbMhCEuLw9u7YSRO0DY14QeeXwEpY7f+oFkvkY7XFXQ21DYwokq1DuLMVxIzmxViygLRDPYQkTN6EM6rtdS/AF1G6KWX9vtpBJckVuejmt8bYU=
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id lx15-20020a0562145f0f00b0068ee9aeacefsm919213qvb.146.2024.02.13.15.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 15:15:24 -0800 (PST)
Message-ID: <1e1bb7c0-0b83-49dd-a8fb-e5ba172e35c7@gmail.com>
Date: Tue, 13 Feb 2024 15:15:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 14/15] net: dsa: Define max num of bridges in
 tag8021q implementation
Content-Language: en-US
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: linus.walleij@linaro.org, Vladimir Oltean <olteanv@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
References: <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-15-paweldembicki@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240213220331.239031-15-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 14:03, Pawel Dembicki wrote:
> Max number of bridges in tag8021q implementation is strictly limited
> by VBID size: 3 bits. But zero is reserved and only 7 values can be used.
> 
> This patch adds define which describe maximum possible value.
> 
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


