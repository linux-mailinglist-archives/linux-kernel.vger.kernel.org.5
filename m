Return-Path: <linux-kernel+bounces-59067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7246684F0BA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F781C250C3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A36D657D3;
	Fri,  9 Feb 2024 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIsvn0/P"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70F4657B7;
	Fri,  9 Feb 2024 07:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707463502; cv=none; b=Qr0WIhq+6SVJshfdsdrfzk48QmSnrRhYERcWKSFfuoCDBjX6ZLvbPxs+TrpXnerOh7flN7MlcEItLjmBXKlQXuDCIzlzuIb3JTOx/Hcnav9s4RVrS9O4DHmXOmrYwnwm0etDAHhy2lKMPVfn2lplnILJGG9ecp4eyv3Tnib7s3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707463502; c=relaxed/simple;
	bh=rsmnzsz5GNmHcSYK3iHXVA/WXaZ8lTmW8zulPyJVVGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o2drAx3tAG6ByZJ7Ws0y9B+NpAGDXxBkCsxyDgH3YcryoZgrsjfh3v7+X116X5LdDDrJT9e0AWFiXvYG+K2JhnGqPf/SyNFzGDksrbelmK7b5zN5QXWBoYv5QiRbOfOCv90usHuZzMyMNcSSditCL5oFcoS5OLlPpHC8ccVcoBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIsvn0/P; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5116b540163so1014546e87.1;
        Thu, 08 Feb 2024 23:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707463498; x=1708068298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pdG3hSNGGNzr2pOTIyIMpLiclcO5pq5s1cnkvilc9io=;
        b=YIsvn0/PyPivVoKOpLN3vPf+532I11c3ka3S8BXtkAGHQ4/rGysDTBHjI4L/p3rPyb
         e1wjHHX/7c+G/q+oMsuUq/8TbSv3MXGbFZpf0G8ujCMowcFgon+GUzb2PywvVBz7wAOp
         DrMxTJlTUH2775e5/WtSHjceR99vus/OOLrzR4RTBr0OUOcscDMWur9g+2tG3I6Dl4kK
         ukoQe+8tbStfq++Q7UzsLTbtkyxfque/hduCjvlHafl9Ldc/QtA6E8FjdA8N8FWKw3Rq
         QqGtYP1Wp7dH+ozWqobxyjt7Pr5KoZKyYPRBvZKY+l9EETmo42+IivcI77pQho0GXaw3
         3dJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707463498; x=1708068298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdG3hSNGGNzr2pOTIyIMpLiclcO5pq5s1cnkvilc9io=;
        b=hfQ3SzBU2+aphW1S/6im6IkplwOj9HAc71kclbdbJEMkcoR5vxJKVlkHjMg66T8zz3
         LVIdrHlllI8YbJ4/ze+1ZquF8NFArneL47ZUbi0zWZ4/cqZ6q9lokl3VIrgxFkREFmev
         jVyM62BHY2TZfRAwLmTaxFV1PKC+ummtyWce7nhy39KxmyQEfNp30q9Qd+/6mXhh/lD3
         on6sJujLZPT5vDHCVSNLYfJn9vDBVSEuv7+I+z509FSokAIBsemfkRbnSdIXBqDfY74N
         uK9NQYnGt6OO9isoz7xCrQPoBILgRJjTWX40OJI5M4umG+sT2aU2wWwYvJsi/mCzPUYj
         VxMA==
X-Gm-Message-State: AOJu0Yx6RESia4VRi1pIXapAxF3Hp0jH1SHKbBPhSTvVeM92ZFMjXf8E
	xw4sFoTu6sJ0Wrt/5oofrLnQsOLOElXy2bZtQuic/QZGv9TPN1m9
X-Google-Smtp-Source: AGHT+IFb0xkO87iajvnu/RbrVAPg0isliEel8BvJnRkKJGUPpTxcrJm/nJ0DjzFAmMTSwgwn4ZHkXw==
X-Received: by 2002:ac2:5382:0:b0:511:4e6a:52fd with SMTP id g2-20020ac25382000000b005114e6a52fdmr423108lfh.3.1707463498323;
        Thu, 08 Feb 2024 23:24:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmi3o04Mdh3bqS+nHOZJmxKHpty+1hF0QEis1iuO4IqPlOp4kP98t7IUFwkPEa7qgTROukdKO5UVrwk0cWNyAqh6wShS8HW9ZFd+T8IlacrnFkWPK8ttTuvwUIzCeaNiCvS3qHXJ5jXwv5MUFKF+LGXlQhWaTswrb4P50bqtWeagCAu/IbDeY29Ey7f2fz9d9BP5Ko26GY5Oq3kn/DeSqNV7YLRzjzlVN8M5ESVphOl9V0FUmx1YTsZhbiMVcQt4F9aTcjfUv5h0K3rqhDIrs4trxuWjVyE9eCxg/LydWXan7RDD1MSCHc6RObeAKMkCNEWVwhLrMt0nQ11aLpAicm9R28EqPeoHNBe5+xRKnQxyy7bpG5po1SkpNLXoyIDtE8lr4MQDt6Of+0wPAnrX1F5tUNnuKSiidhBp3grKSIKHcEDTJwyutHhtMrhDADr3GCvxKJVS3v++U=
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id z13-20020a170906714d00b00a370e130fc0sm478163ejj.59.2024.02.08.23.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 23:24:57 -0800 (PST)
Message-ID: <6012ec99-4246-41b6-adb2-1bcd4dd159ac@gmail.com>
Date: Fri, 9 Feb 2024 08:24:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: media: convert Mediatek consumer IR to the
 json-schema
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240124095230.25704-1-zajec5@gmail.com>
 <62fca33c-eb1a-42ad-b7f7-31b14f0aa446@collabora.com>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <62fca33c-eb1a-42ad-b7f7-31b14f0aa446@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.01.2024 13:33, AngeloGioacchino Del Regno wrote:
> The driver says:
> 
>      ir->bus = devm_clk_get(dev, "bus");
>      if (IS_ERR(ir->bus)) {
>          /*
>           * For compatibility with older device trees try unnamed
>           * ir->bus uses the same clock as ir->clock.
>           */
>          ir->bus = ir->clk;
>      }
> 
> This makes me think that requiring *one* clock on MT7623 would be a mistake
> and the devicetree should use clk, bus - CLK_INFRA_IRRX_PD, CLK_TOP_F10M_REF_SEL.

Looking at mt2701-clk.h I can see CLK_INFRA_IRRX (which I guess you
meant above).

I can't find CLK_TOP_F10M_REF_SEL however. This seems to be available on
MT7622 and MT7629 only.
Could you take another look at it, please? Can you somehow verify what
clock should be used by IR on MT7623?

