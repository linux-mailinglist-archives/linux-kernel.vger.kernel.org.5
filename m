Return-Path: <linux-kernel+bounces-138087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316ED89EC8E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CEEFB2428A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16BA13D280;
	Wed, 10 Apr 2024 07:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z7foJAt8"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8A613C911
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735028; cv=none; b=srFgKuEKJ4s0C39VU6BWAFDngKexmmAsnvTyaEBt8cHc2aLsMcK1z7wBc1wnqNDboCoiKIbhGYtwLStDGHluLAn5uCEzOY1DzO51szauyhKpa6P0eSVcNdDNHjuTxfjEbWlySm1meNh6OSFDqUTF2kIoZxeO1/7f4ulXQGTPwy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735028; c=relaxed/simple;
	bh=1QuHcBpaPbLz+yO1YHqq3OExfDMvUw8krLbM9ZoeMH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLGVuKaOy3HkcMygkI0HLZU/zRzWFwMWkKLbK6VbDov1C8SkzYX9vu4wO11i2gsgJAZ5LLA3s0T+cSoVwE0Fx8//1FMMA6h40JESQo3eowgPzqbOfNMgpU0GrJfNoyg64r2qGutiLGQw3wN0YOfaCoaUTUOXGM3cGty+dlL2d+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z7foJAt8; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so7813118a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712735024; x=1713339824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bxxYTR1JiHtFW2az4eCik//PkYsIJXfUFZL2/AsAomc=;
        b=z7foJAt8zLdzvuCGMQtWa1Q4UT2voVTUSPXWE+SEKy2AkhncmrshUHdLANUNtbrmt0
         FsgxqMruVM6Zgx7yYIA1l1o7oJtIdbbypzMuVd0+PCtooIKOV3z0kDsPL8sB9hFQYVxg
         /diPSknbXlH04J8FaVi2xw+AYCxkIUyap1rA3/0vjpBLwP9Xee3dAXaAEGlGUAZcvfUp
         /YyKGV0iQHCuvQWre2KeCOCQ1RIe89gAMTb88/dCNyGDhOKlm6k2sdFhEURa12AneD0d
         oaSqBeJxYgerh2euQ9VUwd7RJE32k6eUOsXPW3Ue6yznXKXVEXDIV+d+YJc6N4qJRbus
         6oQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712735024; x=1713339824;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxxYTR1JiHtFW2az4eCik//PkYsIJXfUFZL2/AsAomc=;
        b=dv29tUkn5VeJkw0NnqOqNZQVrEmDspiok+r6uFjiwSmeZiUWqcKZv4qY9+wIvIQMJ1
         Yl8mxmewyHJoKx3V192m9lX4+jiN96lr99FMyzhuj8eodPzDFFocpppcTHpWvX1U9Y6Q
         EfgL3ez+IrbsQ8UhBv1TEQVwgnd4cqhszEfs20ooVsnLWchOsh/d7kYgUeXHhfGfWWjT
         lmwAWBjwtf4XrPvt/S76C7AGuU8sIrYGTN/fcJjnR3kZNYLW9BG5WDfMBRO67+B5Eejd
         /IF8eiJf6BZDn+Zwe9dFT/iQt+uBH6kTEAVIryzfh2H3O/t52nBLhAJ5dDeejlu/IarJ
         CHOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAsco5IDE+JxaaxouKrPXufqfEMLFCfTEh+0YhVi0t19fD4EsOWA9Nfhat9TjHkr2b6pIOg+eVCOV8hpRWz8Zvguxgv7QTS/1GOvI0
X-Gm-Message-State: AOJu0YzYdDwg+yYXtZF3SRtTEFRWGvwdY0llQeADhThkcc6786iENa9x
	IiB/aRhfvXSE3t+uU+TnJGQc0jlKzEoALudiYl96ZFIXyoRJC9c725GIvQ2KYSA=
X-Google-Smtp-Source: AGHT+IFUZbOigEKcuthzo5ynjpncXlPigdoJ8wH5xAaC9ymCqbs63FVa5wbBRqVg8ijeVc26C9VU/A==
X-Received: by 2002:a50:cd99:0:b0:56e:2a21:3017 with SMTP id p25-20020a50cd99000000b0056e2a213017mr1398248edi.5.1712735024531;
        Wed, 10 Apr 2024 00:43:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id ij6-20020a056402158600b0056ddd9427d2sm6212819edb.58.2024.04.10.00.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 00:43:43 -0700 (PDT)
Message-ID: <c944f949-8907-4d39-9953-82748108ef11@linaro.org>
Date: Wed, 10 Apr 2024 09:43:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] drm/mediatek: aal: drop driver owner initialization
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
Cc: "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>, "airlied@gmail.com"
 <airlied@gmail.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
References: <20240330-b4-module-owner-drm-mediatek-v1-0-fd5c4b8d633e@linaro.org>
 <20240330-b4-module-owner-drm-mediatek-v1-1-fd5c4b8d633e@linaro.org>
 <48612f68a7e7b6aab0c6d5cbc77d85b1389f4591.camel@mediatek.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <48612f68a7e7b6aab0c6d5cbc77d85b1389f4591.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/04/2024 05:44, CK Hu (胡俊光) wrote:
> Hi, Krzysztof:
> 
> On Sat, 2024-03-30 at 21:43 +0100, Krzysztof Kozlowski wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  Core in platform_driver_register() already sets the .owner, so
>> driver
>> does not need to.  Whatever is set here will be anyway overwritten by
>> main driver calling platform_driver_register().
> 
> For the whole series,
> 
> Reviewed-by: CK Hu <ck.hu@mediatek.com>

For the tag to work on entire series, you need to provide it to the
cover letter.

Anyway, Philipp,

Everything good here from your side? Will you be able to take everything
to mediatek/drm? I think drm window is slowly closing.

Best regards,
Krzysztof


