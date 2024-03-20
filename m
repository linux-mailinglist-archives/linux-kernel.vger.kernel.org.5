Return-Path: <linux-kernel+bounces-109068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA9F881440
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8B41F2336E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7819C53379;
	Wed, 20 Mar 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd8HcGUC"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220D6524B7;
	Wed, 20 Mar 2024 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947566; cv=none; b=KC0anEdz6P07IgA8alQM9ftOGYI9B4ZHorbQPzFDx6XQqRmXF42+BEI1Lxu9SBIoahveSllEKSOV/i8Jna3w+FcTig5OJcUQQPr37rR2RD5egUbBAmuSq2LNG6f3J4jrzI5i9vY1uZvyJnsAUeXusvduaZUf4LwVWskK9/JDBpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947566; c=relaxed/simple;
	bh=lujk9lU125wCesb290Yfcege4U2BvoIEq9CjFfIpdGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PL9a9zllMnnt2qzZGeVYPlO/6kndWqAA2tqoeOcENlI5eVF1JXb1dcelq4tdp4swD7ejWOUVJjt9gFDlgg3k9MK+DY7ljxGuMiglLOY2AxIe3XEMvMMjgCPKa1IC4batwIh8ahmHVZRVnj+UmMc7trio52SGrdyuXp8tEscRHDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bd8HcGUC; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so84005451fa.3;
        Wed, 20 Mar 2024 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710947563; x=1711552363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VKDCvcnWgS98kbw0fYidYmjqYC/LQ8RqbNoxwppD2oU=;
        b=bd8HcGUCNjxPwF27y6YU5P4iKp7np6yt2qd3MfucgS0fAFj1TqD+w+ggkbx44VZhWX
         Gs0sE7zy2D+9+p9+bV2q9O7sj55pMpIxxYpPfqOSeBfoTX9oqGxtf3X2k27nGL0EU96t
         tAUb5l3erIUTMwcPcCn/x4pSGPAQi5cV+v0xB39pz8Jmhk3IaC03bAEWpmKBX7rnKiCu
         qtyERWlHZ6eKAlaC5MHJ5m4ajDVwjktsHxlyRW60aQyzvakbbvNlcKAPoo2dftmM1jzK
         tSOJDlUzzfZJjBJhwHjOtKU+jrhMrhVbPCz9t5ea9SM5dSP4WorvbzTp2wdqx54ilbz0
         7c7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710947563; x=1711552363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VKDCvcnWgS98kbw0fYidYmjqYC/LQ8RqbNoxwppD2oU=;
        b=MaUeNkWmg1AgOMmNnucX/dXXnJuMAqlO3p0cYMf7TuTU550gvzPdVLNhm2ObWDVdx6
         VK/jaBB26BDuR3a1CXSefFnzvwqVsdSa+3535ppaXUvpTfmoAT+NjR2CpyN0Mz4U3xB5
         x/7M5KuE2kEXnQnm8sIyt8XWkOZ09LSf5zhCtrf4zNiD6YlNUJ8rAuOSndTLJ4YzcSFo
         J/45zTAEPCFJhrmeDGS/lsh4uZblyBmCessxYOLwh5f21HYeL2sjoVNv83Emw2To+iFe
         RbViFJvcd4oeWtl1ItFZeeKREA/sANUc41joUklaRik5Oyj+a35XqL+D0vPiFf6muJTM
         XFTg==
X-Forwarded-Encrypted: i=1; AJvYcCX+o3MWR+62eGWPBBO30G952fzM2NjjUx1+mfo6pfTBGu3FETXh3WW3Xgnr1ypu0NNp2VeA1jPn5e8Zmin0z//1VZ1tdZJtllaxBoWQwhJe/gBN5rshpxFl72oH/LsBEjztPVznJI0ozA==
X-Gm-Message-State: AOJu0YyQAzf76AqrZDLladr1LRXgGgxfIw/Fff3Wa8MeP9WjCoZNI2Kv
	tr9V5/LFYtrW8yz6oUkb+VgWuJUtJdT3Z08yqs2DyQBQUS9j6UI9
X-Google-Smtp-Source: AGHT+IFT9VgVVUGrEsXx4hdX1Xure9Rf4dbvEDYWuckKrrAkroGtk3moQU6iBZ09MUSIgYCXGLSHqQ==
X-Received: by 2002:a2e:be09:0:b0:2d3:f095:ff2a with SMTP id z9-20020a2ebe09000000b002d3f095ff2amr12648201ljq.47.1710947563034;
        Wed, 20 Mar 2024 08:12:43 -0700 (PDT)
Received: from ?IPV6:2001:999:708:5b57:30d6:2195:bb7b:bb94? ([2001:999:708:5b57:30d6:2195:bb7b:bb94])
        by smtp.gmail.com with ESMTPSA id u22-20020a2e8456000000b002d51e0b73aesm825619ljh.25.2024.03.20.08.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 08:12:42 -0700 (PDT)
Message-ID: <24792e21-afcf-489f-a47b-01f88721ea5a@gmail.com>
Date: Wed, 20 Mar 2024 17:14:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] ASoC: ti: davinci-i2s: Add TDM support
To: Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-8-bastien.curutchet@bootlin.com>
 <9d123584-1feb-404b-890f-2da694cf56d5@gmail.com>
 <f2d8715d-a1ad-45a4-952f-a702b29740be@bootlin.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <f2d8715d-a1ad-45a4-952f-a702b29740be@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

HI Bastien,

On 20/03/2024 09:31, Bastien Curutchet wrote:
>>> +    if ((dev->tdm_slots || dev->slot_width) &&
>>> +        ((fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) !=
>>> SND_SOC_DAIFMT_BP_FC)) {
>>> +        dev_err(dev->dev, "TDM is only supported for BP_FC format\n");
>>> +        return -EINVAL;
>>
>> I think this is not a valid statement, Fsync can be generated internally
>> or coming from external source in TDM mode also.
>>
> 
> My hardware allow me to only test BP_FC so I wished to put some
> 'barriers' in front of untested things.

I don't see restrictions on the other changes affecting this to be lifted.
I would allow TDM for full clock provider mode also.

> 
> 
> Best regards,
> Bastien

-- 
Péter

