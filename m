Return-Path: <linux-kernel+bounces-61824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F038516FE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1321281D90
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C04D3BB26;
	Mon, 12 Feb 2024 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wRbBVABy"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043423B782
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707747771; cv=none; b=LV5UVvXkGFMRB6JC41agIuoCYMvEzV+bD6j0l+9aGd3mEEIXV3sAKvitZd5yivH+HRWqj5X1OBy2OHv0O/Dzt0ASa1fVDyep4cHE64tmmIc6vzqY8Bg7tgbld/Zu35F6IFCscbLn9IzOO6o571PmVrMTfv5b9hETn3/ivu3oxuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707747771; c=relaxed/simple;
	bh=07cZI/S4GK8mTXXZE2MOjchE5YSxqAJKCccca8LJMlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crRnP1ZPcLttPZchDaJ2bpQE2HwcjEWG4ns7aRBumPTobgUFwo2SpezDAmKNaWVUVKZfHwGrObO9YSqCh2UEz0rEyhZDKOjZbVTjakBFbZv0Dh2kaThT5Z6Ui0oTTRegC0nNEBW2SuuyClRb31nySHhL48vTjCRXcybaUQPXnGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wRbBVABy; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33b29b5ea96so1525795f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 06:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707747768; x=1708352568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ItAuHSalJCNukfekRAeNOHLT747CWo+LpaoIN6hRoRc=;
        b=wRbBVABy6eg/XMP+N4PdArnBiabMwixwGUCoo0TRo5DulP2/wyYF6eokIHiiIsniGY
         0b0L1mxiJ9GimN4cwrwescgxXc2bulq5jT5zUR2OvB4JCtZQOPmTBKsxuEVZGWOwe4rV
         45APFqMRgQCBNmurZSaWRPiQ4tvopS0tx6Qf2wyocYVxUOncT7P2fK2rdWHSkI9fK4Jk
         e8e2cPCb2h40b1tkzxhuOXaxU9UEldMI19ypPNPDteSDvEAQPklqu5wv6xVPWrHCzQ+5
         wcMo01tBWchgx+t00NHyxToVZRqAipPwrwg66vos10utOXqzeJ3nAe1h20HFOzTQFXKN
         4VtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707747768; x=1708352568;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ItAuHSalJCNukfekRAeNOHLT747CWo+LpaoIN6hRoRc=;
        b=jIc0S9UFVcLvMR9iHRRPEQurTYmU8c//1MMkE2yGz1AoEIrgwUfNKDjsr65iSbIbTX
         Dz+EjBkEmSOZK3x+hRRjRBDGNTx9/OUitvgnSDQ+8LWS3eVbBiezb9xWIskxq3AxtJxN
         X+GtxVO1EyJ3gqeva+WjCOKadx91Zd4HnckiHNYFVX5ol45agbGBQIYBi6eYzLK/mzy8
         5ifpnRkPPoQRD95uxPt0rG7fDp+Uit4c7LwzyqT7cmky/m8jypdSpIB/AbWQoKONGBd3
         uFrVHC2vD2lySwwAS8HboYkPaD7adBv2BnRzslZvFc5qYTbV+45ELPaRaKI3hwAHKs3W
         fBFw==
X-Forwarded-Encrypted: i=1; AJvYcCU6WlgU0SclQBjZ+BBTLdSXN+GQu/rjf5JadmvSicZNdeycct/eF9qKPngXFmgjtiLg/6cwCmVSY/6TkiXOKAWMi56OMbl/ri3yfgZP
X-Gm-Message-State: AOJu0YyCUCvmiA/buV9oBLeq6PVStWEgqv3ghNpIl5eaY/w4AYcpHWDC
	DBN6wvh8VlRkiagDSiTXVn3h1/mkr0r9EwA9F0PAK06xDPmroY0k6mFFNCAR40E=
X-Google-Smtp-Source: AGHT+IGJ3ugFEbTL2PsMR58y0ymkOu4lPNK5urQ7gA0zjpXlsPAKXhizMjaGozVGvlbFFJ3EPvj4Ow==
X-Received: by 2002:adf:f081:0:b0:33b:5735:e9bc with SMTP id n1-20020adff081000000b0033b5735e9bcmr5196734wro.34.1707747768194;
        Mon, 12 Feb 2024 06:22:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU15q98/pVgphxSjJ5v9Fre4mQ4JpsH146jhPZ6R+YAPBHVoaPRqrHHE0o2kTQ7JCp4ZaoTvM2N8fOjPDFYZtUPX5cSLVKkbldhw9akVWpprts9ctqvGbJQ1hJ9y2VvKgFas5XQtQJzpzq669/8cIEuVg9IV6SspGw6o2ljT282HsIoUpNX3tGmbaRTGE44mQh9xCmYe8AQ3F+NNl6QsDbBzNOVqIZzOOpfLaAL2a4HQHUiBPqG7JTGGW6w+iEtg0pKuuz33YRx+16QksFmzaxIzy9TrgCPxfUU+J7/TLclakpB2k1ApeKQ7LfTwSfkD6gsMbJF5vkcMHF0AKZvbc1hOz5UKscxnWVG63Bi203sEeMCHNIhF15p9tX3ZzE80MYb54RhLPE1O/GdidasqieTuIdBwCpG7L5NPpcb6xRh9J7hU0KjC+WNYn8Sx25+/B/eMGlS1YwgAaXNuyf67lRDF7pttd1L
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d65c1000000b0033afb963d0dsm6915289wrw.101.2024.02.12.06.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 06:22:47 -0800 (PST)
Message-ID: <945a884f-926f-4a30-8c68-725a52a97833@linaro.org>
Date: Mon, 12 Feb 2024 15:22:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: add smartrg
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Chris Morgan <macromorgan@hotmail.com>,
 Sebastian Reichel <sre@kernel.org>, Andre Przywara <andre.przywara@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240212140839.27150-1-zajec5@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240212140839.27150-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/02/2024 15:08, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> SmartRG described itself as a CPE manufacturer and produced few home
> network devices (e.g. wireless routers). Their SmartRG SR400ac router
> (smartrg,sr400ac) is covered by in-Linux DT binding and DTS file.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


