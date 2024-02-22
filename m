Return-Path: <linux-kernel+bounces-76306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 662EB85F574
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECCF284307
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBD039FFC;
	Thu, 22 Feb 2024 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGs2c6o6"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ADF1B59E;
	Thu, 22 Feb 2024 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597066; cv=none; b=o9/X9/acvm+3wHtt80hszowzNmS3trHqpF7PXBJcn+ImaP5jZhfbs+J96vCDJ2+yOg0zY/5C1d/g/IMvKyAf1aZUl+BcdMDZrZQ64eB4Gq9Zx5qLvvvmxcGBuXfF9EOgE7dpK9kDwZusZ6mKKZV8MOe0XC23Mk9GSnreRr042kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597066; c=relaxed/simple;
	bh=RcGPgWvUr89/90UiJww8A5DghH3iiqUPV3yU5/wDZ2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lbFLd/DnviYAvOkUfmf2denbFODBvFVsKD/+E4UQNHLVER/rnztIh9G1ZGO2/Yr7A4AR0ZkcUcGgVE+zn+uwEFlb7BrBs1W0taF2q2dq0Rdf3zaz8kiw8xOaekffpGb46Nx57rAmo4fyKuRsAmYP/PjEj9J7LIiqHIRjV3I1AP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGs2c6o6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d26da3e15so432828f8f.1;
        Thu, 22 Feb 2024 02:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708597063; x=1709201863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G1J8J17nCvBwJV4rCbF2JrhC1M/fgT2R9MteVMrLhr8=;
        b=MGs2c6o62eqZqNO1Sqz3SgEbTHJx7kRCC0PHCWohOcGQ9SuEgXIcqNEpzKYj9wNi1w
         x9Aw4RJAD0zHwnQ73+rFbGzkBEGroQojdLUMplG/2xF10JzfbuC3DGUe9ClaEeRlQyM3
         UZO3pWbgY2/j3qQGd8F7mMm+GH/dCffrQ7taLQt/OG4IZp6KWdbvVQEx+uEmcIQRf4wA
         DqUbcFJJs5+bKX7AMNegqgl4TS4Aoo6hwTFoikCNTvMIraCxUxYNPblyR7ToiyL2qQg+
         OYlstkXDwP2BgEOLUWonlIfCyjFwYGkZ1UloNCup4nd3P13g78rpBpkqAAza/b5FWYMx
         /J9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708597063; x=1709201863;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1J8J17nCvBwJV4rCbF2JrhC1M/fgT2R9MteVMrLhr8=;
        b=XcFOU0BOeUvuDRNO0tZluWHUwUTgT1oNU7zi3lruwCehtQBLTDjUVHAofBPe4xvm99
         1oROoMjFzO4GjXJmqwGlRnWG5358wzAy5SDsY8iW+SW/POO88kFX02l/UhzZzwERBsrb
         9a3uPw34VcNbD6kndWKxfrnfKAG1+VhBykXwKXtzipa+bvkk1vUtdCOdzP7j8lfKa56r
         3NjOJvsk0MHjYfPHHPb+xNDYHpGTgOh13LFKTsFuSNrbPVRmuHl7SyxkUHYQt4jLUt9H
         5TqZmEdRNw3cMSVtaOJP08ILSyRrabfM2Tx2ZqtUoEv7FOvnrwensSwQtxAESoVUFnjJ
         JvRA==
X-Forwarded-Encrypted: i=1; AJvYcCX1C3MKXwYxD/hoN+wCoWMRwQAPTPMfp7mdlc/xwh883eWOeIO+zcdnMAbwpNU0MrWGVkaDV/75LVOMmFB5TOjj+rqPiy5UdzGen+Ix9/l762a+wKKFpaSlAWF+8bHTvfnOy6mv8mlmhA==
X-Gm-Message-State: AOJu0Yx9inpTWebLFeURLi/Ej8I8x3Nxw0sVVpEp688avU4R/tYEwKIk
	oQDUv3QO9y+6JrLXKixFtWld/TVPBR8TXmhPWEB1hK4vG5hVuCLz
X-Google-Smtp-Source: AGHT+IGGd9rgcsy5ffeIqgGcAUSF1axJ92HYRhWHu2pwd1QcwlwOgUYgod//TagogmfGZq4p09kl9A==
X-Received: by 2002:adf:e742:0:b0:33d:3e02:a5b0 with SMTP id c2-20020adfe742000000b0033d3e02a5b0mr1926418wrn.11.1708597063175;
        Thu, 22 Feb 2024 02:17:43 -0800 (PST)
Received: from [192.168.50.110] ([90.255.110.157])
        by smtp.gmail.com with ESMTPSA id bu7-20020a056000078700b0033d5aee2ff1sm11542845wrb.97.2024.02.22.02.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:17:42 -0800 (PST)
Message-ID: <32098130-cd5e-4bed-9bcd-155227c6008d@gmail.com>
Date: Thu, 22 Feb 2024 10:17:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: meson-g12b-odroid-n2*: Add support for
 overclocking Hardkernel ODROID-N2 boards.
Content-Language: en-GB
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240222082523.1812-1-greena88@gmail.com>
 <1j8r3cet0i.fsf@starbuckisacylon.baylibre.com>
From: Adam Green <greena88@gmail.com>
In-Reply-To: <1j8r3cet0i.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/02/2024 09:37, Jerome Brunet wrote:
> Patch title is too long - checkpatch.pl should have given a you warning
> for this.
> 
> Not sure it is wise support overclocking directly in mainline, not by
> default at least. Maybe as an overlay ? even this I'm not too sure.

Hi Jerome,

Appologies for this but checkpatch did not raise any issues re the
length of the commit message.

Overclocking is not enabled by default due to the turbo-mode bit
being set, it still requires the user to issue the following
command to activate.

echo "1" > /sys/devices/system/cpu/cpufreq/boost

It's also worth noting that regulator voltages have not been
upped to achieve this.

Lastly if the HK wiki is to be believed then the N2 (non-plus) is 
already overclocked in mainline.

Best regards,

Adam

