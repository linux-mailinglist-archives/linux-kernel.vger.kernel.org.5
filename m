Return-Path: <linux-kernel+bounces-57876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2384684DE7F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565B21C2446E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8DE67E85;
	Thu,  8 Feb 2024 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="Z9TpARIu"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAC11E884
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388837; cv=none; b=kI2x6xT8IFtBohajCKkt+M8R4wQdHXOuwAg21VU5P9Ls+8DkiaQuhyqipUxhU0A/D3qV/ZKqqAqc5tNSbrxiV/LvYbDCAaSpoTuRxDifFLB/EpyEF921lnqxSvP8YSxNwtaBh0EcJ5znVtRAsAAalzFdbtgFbT40G7RL7U+W5Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388837; c=relaxed/simple;
	bh=iJZj3a2A37Yc2+UbCcT708fFiaad1lyduEVZ2e9J9os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwzDlRp1JwaiQI9/JCO3/szu1UusKGp7boMr7/m/43V4q0IY2kllUB2qHjx9AM7FV6M5NhSjZTSfuaqg68iSw1CIlzpwb/UmSSRIrSpSyr5pK7FYevmbarlf1Nh1muXrcvaFoZDf+a6R+Nb7uV/hv45jRN27YNdgCsh/eU3OcUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=Z9TpARIu; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3be6df6bc9bso1017980b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 02:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1707388834; x=1707993634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ovh33pxfI8P/Sa+5KCuYC2GFDU346PqyTe6ORiybvcM=;
        b=Z9TpARIuN4o6WDVy/IX9xCy/rLoQf/0eFBAP1xGnaU4iJf6TZst7nmd4IDkuUu1N8q
         9xYSeaCanmqWLQ2n4YapCz9pntpc6BoJn+FttAi559QjaHn13aFgSJOU4EibmpwFZBdd
         sI1BSIA31m0jChuqD1DHN6HGgGjXzff3ctGoObMCE8+AcumrSVkCoeo9NMZ7HwGBG6hm
         fizKubrkh2GxP22kMPY0qQ1Ub+vjWGExh/8Irx95efeuD44dI8U+wgtHn4gSCwfJy2ZO
         938fUAkzxbyukOmF8jJD8tBnA4BxFPu6pKnyixaxI2hyyZndNAEq+gU957LfEVyudrgZ
         LhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707388834; x=1707993634;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovh33pxfI8P/Sa+5KCuYC2GFDU346PqyTe6ORiybvcM=;
        b=rTicAkPyMK7os4idjNJt6BXQIs7Gv4hGQUJSa2PuIUixYIxC2YhhAtDLR45p/Cj6KF
         w/SD2OTmnUZoowTKepn15n/h82wudldGoGxcXwI3bXZKEogLwEKE8G2c8KaJNUnjfM1i
         GFu6TqhhDwAql6/G0U6uu6uLPXpTxw1smEbQ0R3ltn6oBckSVmAjEUaLbuZPvHdxXsyy
         RxBl6yKyBy2fXYIU06wW+HUzeKCGCgHWXgPkud9YbVwMwtU1hcP+RE8NDnzMdZsZSWgC
         8yxGOO4/AEDZnlGrZnLg1itJwMN1bXhP/DVI8U3QIAFirzb17wD+D8Nbqkkj/duvrRNa
         hpHw==
X-Gm-Message-State: AOJu0Yw9zL7pXvxsRy9heSRzdqedgs3B21fNZ2yhnnO/5RZC9tZJm5BY
	WmJs2kB/g31q810HKS9ooOa7bNw9yK/28AEFAztEIF9eTHqS8fcg+vdkHHn0ckw=
X-Google-Smtp-Source: AGHT+IFPgSwcGTkRc6XoMyUTVPv29LV1357qIzDt3rcTIlrqnUrpFzLDGx7+ulkb4Hy7vZXonzOOIw==
X-Received: by 2002:a05:6808:ec2:b0:3bd:c146:5444 with SMTP id q2-20020a0568080ec200b003bdc1465444mr9826422oiv.51.1707388834544;
        Thu, 08 Feb 2024 02:40:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUI/U8Wrq0Y3XuS3yK7Em2IDVV/HYjo2hYUJd2IrowVuHRl898Aq57w7GvWMP/MtuydUgWPTliuy7ac1AsrNwXHUZwIMKHjKq4+3lQZAGR/2aS0hSxjcOpQraw6jZqdp9BEJrk/IRspax9qZSY0ptrR0gGLQ1tP18OTxixODz63K8WY7Ooc8GFPw64th1hNAFlUWV9sFf3DhpzUrfjGhn5wQAf+rNedBZrFUvWZQwbLy8WPpZa/dJNztu+ct2juKktPK0b0mr7QuvjYFzVGQqlfbPYdTTngVLfj/TzoRAzWCg65abkYuJcB2ZlA5uJY+0j834mpzRSAeOvKaNQCweDvS9wuYFMVn9ii3kqyPj4G+g/QX4PJwnKBA7Gd87fu/rke7n3hxsCOKX3ogkdSAZrgzqYuW0xtM0YUTpLEm8PmpeQr6GLn7JBbr07NkZBrtQIHMzy3IUG6O+Budsx2huVhpKRSb/MgS1zaUQZrNeFBiA4=
Received: from [192.168.20.11] ([180.150.113.62])
        by smtp.gmail.com with ESMTPSA id lo19-20020a056a003d1300b006da19433468sm3347516pfb.61.2024.02.08.02.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 02:40:34 -0800 (PST)
Message-ID: <84591019-6958-4685-8830-54260aadd26b@tweaklogic.com>
Date: Thu, 8 Feb 2024 21:10:25 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] dt-bindings: iio: light: adps9300: Add property
 vdd-supply
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Matt Ranostay <matt@ranostay.sg>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>
 <20240206130017.7839-3-subhajit.ghosh@tweaklogic.com>
 <dbfde067-50b8-4f86-a098-0fc160114854@linaro.org>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <dbfde067-50b8-4f86-a098-0fc160114854@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 8/2/24 18:47, Krzysztof Kozlowski wrote:
> On 06/02/2024 14:00, Subhajit Ghosh wrote:
>> Add vdd-supply property which is valid and useful for all the
>> devices in this schema.
> 
> Why is it useful? How is it useful? DT describes the hardware, not
> because something is "useful".
I am adding this property based on a previous review:
https://lore.kernel.org/all/20240121153655.5f734180@jic23-huawei/

Does the below commit message in this context make sense to you?
"Add vdd-supply property for all the devices in this schema."
> 
>>
>> this patch depends on patch:
>> "dt-bindings: iio: light: Merge APDS9300 and APDS9960 schemas"
> 
> This is unrelated and does not make any sense in commit msg. Drop.
Apologies for the silly questions:
What does the "Drop" signify? Are you asking me to drop/delete the above
"...patch depends..." message or does it have any other meaning?

In the next version, do I include the ack tag by Conor for this commit?
> 
> 
> Best regards,
> Krzysztof
> 
Thank you for reviewing.
Regards,
Subhajit Ghosh


