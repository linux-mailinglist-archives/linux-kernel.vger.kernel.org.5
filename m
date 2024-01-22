Return-Path: <linux-kernel+bounces-32469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D844835C15
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3B01F22D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E28820DE0;
	Mon, 22 Jan 2024 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khVfk36o"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06021A71B;
	Mon, 22 Jan 2024 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910080; cv=none; b=Txjrff/J/bqDTTWf70D1GaNYrM2zIJske1Td2oLN8FMCUiAeZxdfEaMx+yRTth/uREJyE5gvh+fkIqvpnVlE9rpPhmKjWdT/46/Kaoq5/gk5UmNrLUBJsBL4rnjI4ifjpRphfFlA8oi/01PjQluetv9QHIr9/bCQ9hF7nwCxC84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910080; c=relaxed/simple;
	bh=bg1c/cvshfSUWUxEN92SDIwzLHl9kyDOekX8mUVZHAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mv3XwUOqq6llLnqROazaZHi434M0GwYoJa0NaINZB4CO+uZshRhuqy6wW1xutOw0iiHArV8QTOqm8ltCyQ9lN7Qu9wIY4H13LzjrGPtP+nclUY8907YNiAThtqAmUTdzz9HbkIF6sOcQLnODNMTVsLMkGaL2nyTWUx5zUB8Yg3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khVfk36o; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3367a304091so3192057f8f.3;
        Sun, 21 Jan 2024 23:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705910077; x=1706514877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RabbX6Gki8udX9fVIXmTnIqe6Awyq5G6O4BYZpPJAwo=;
        b=khVfk36oks5VDOCsSHYrN+qegAiwgAABcy5ODfLRn+nlKSaH3W8Gh0K9Jod+O5jDZx
         7kWSq3p3ejholcOieOpEJEnCIS0+n/Pxgi2IUc4RW1QP/UIhYBrPjviZjpHo0Ps0AWny
         wrMnQRFjp8hoAL5tGzCG0KSRk2NCOW9e+Kx3F6o6xjveEwy2nPxmyO/TWBVNyXpni6Ng
         h4bfHSOFRb0uOqDY9H8nZPC2jWBjnPsO8cIzwakrTnn4ARmLOkyAH4LXfG8xD+FBgMpB
         ljvQ0czuIkpgmMO/m6t6sM/BqE5F38E9AFIGUrnjuFptv9GBzUE2dYt59aoCy947B7wu
         IDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705910077; x=1706514877;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RabbX6Gki8udX9fVIXmTnIqe6Awyq5G6O4BYZpPJAwo=;
        b=amhflFGZEPbX2xMwhAhZb2ForrT4nMLTKCWn9UVcG/8xgXxgu+rH14rJVuQsBQVukD
         KyR6KeI7Zh/L+l1xD4iAHIcTV/MuzwKiRrDeILJKnz10RlTgYU0ofD8/yJSjadCCaM9x
         RRGiCQsMkGtfNEkEePHuJUy6Q+GjUyxwxatw8wjrAGaOGI2O2NjPVbZHnXfCebZbe8hi
         FJSkdHLiQLi8rSgklHmftzo06r+aHeEeNuk9hp5Aga5bFmJ7MuXEsTg9TzTjbipIn8by
         AV2rdNwioh/GhXFFLgMp8FE4gMG0DH9heEi0OEExOVG6ySHDz/vFNWixL76+LwHt6Hjz
         VN+w==
X-Gm-Message-State: AOJu0YxwhnMWXswrmpLKDxA/8hoeblhq4BfrK8Oycnkm9aIL/jNSGGFh
	XSb2rygC+OOq0Z+jPuV1GSWJ2IOpnq01TH+onnQh/bJjMz0E3BbS8yE7CkOb
X-Google-Smtp-Source: AGHT+IFUXMwoASwaT08yq7oCYxK7JHY4M48Muo93TI2g9XhuhCgYy//a3jzYQTs3TsQAwjAFmBA33g==
X-Received: by 2002:a7b:cb8f:0:b0:40e:55a5:85f0 with SMTP id m15-20020a7bcb8f000000b0040e55a585f0mr1493445wmi.87.1705910076812;
        Sun, 21 Jan 2024 23:54:36 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.188])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm37761046wmq.12.2024.01.21.23.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 23:54:35 -0800 (PST)
Message-ID: <115ec234-64b8-4dc0-8db2-aa1e81b4f3db@gmail.com>
Date: Mon, 22 Jan 2024 08:54:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: media: mediatek-jpeg-encoder: change max
 ioomus count
Content-Language: en-US, ca-ES, es-ES
To: Eugen Hristev <eugen.hristev@collabora.com>, Rob Herring <robh@kernel.org>
Cc: bin.liu@mediatek.com, angelogioacchino.delregno@collabora.com,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20231227130812.148914-1-eugen.hristev@collabora.com>
 <20240109032731.GA2578937-robh@kernel.org>
 <94beea2a-c4b9-4241-bbfe-8c57ca50fbf7@collabora.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <94beea2a-c4b9-4241-bbfe-8c57ca50fbf7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/01/2024 04:57, Eugen Hristev wrote:
> On 1/9/24 05:27, Rob Herring wrote:
>> On Wed, Dec 27, 2023 at 03:08:11PM +0200, Eugen Hristev wrote:
>>> MT8186 has 4 iommus in the list, to cope with this situation, adjust
>>> the maxItems to 4 (instead of previous 2).
>>> Add also minItems as 1 since iommus are mandatory, to avoid warning
>>> on the example.
>>
>> maxItems alone means minItems is the same size. If IOMMU is required,
>> then 'required' is where that is defined. Is there a case where 1 IOMMU
>> is valid? If so, what h/w has this case.
>>
>> Rob
>>
>>
> 
> Hello Rob,
> 
> Without setting a minItems , the example in the binding fails, because it has just
> 2 items, while the maxItems is now 4.
> I set minItems as 1 to avoid restricting any kind of hardware to have at least 2
> items, but if you claim that previously, maxItems=minItems=2 , I will change this to 2.
> Is that fine with you ?
> 

I think that's what you should do yes. If in the future there shows up a 
platform with just one iommu, then we can fix that.

Regards,
Matthias

