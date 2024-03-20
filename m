Return-Path: <linux-kernel+bounces-108544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48016880C12
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3E7CB23039
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083B52C19F;
	Wed, 20 Mar 2024 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GeDJp657"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AB023770
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710919878; cv=none; b=UCjOFMBMm7S9oK4xaXNU9pyD8RRgjuq/dlQvJa0QBDe6jpQ51+5qbJJIW3O0aivhTV1PoMVpdOn6UvDLcmQIZtTJfedEgEYre/sWoBylzbn1VsHK2mjdMhpURIe61KRKkKLCLOYFcfxx5984b84V3lTPUniS+V5wfd6uCeK7YdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710919878; c=relaxed/simple;
	bh=8GkjGw3/sOrORiBUiGsT2jAoZiaP1v4JajlPJuP4qTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=joXRrioTW3kKEvV46NXYmaGqRoTsvFP/U0Bu4MV+1TvzuDfVh8jpDX/X1ZtTIcocuxS6/OJIxnmpKyRfdzd6DwOsrwInfx7WqTJ1NH2Gh5pUB9y7RkYZmxIHZIIcpEL1pJjOKI4xvKRD0SlU9xtdW80r4WTRv+9sZUg+2rNoLfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GeDJp657; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso7757595a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710919874; x=1711524674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8xEIUTznrQVSL70C6oRjL1I5rh5o7wWPgx3F+xPmOKY=;
        b=GeDJp657ui9ZjwcVisQiPrroz7zW0y49rRjeuSrRPNMCWxTzk1TeziagFRySTQkgEu
         eJZIStJUOFlsrnhaqutaOJOatdZq1U10hnHSXlK6hiNV5Ys7SE+mBHlGYvY1+Y4DJyl0
         dBode3/ziqRssTQrcf9cLlH0/lieJuZrSjzidlgqOL2/cEArTKOXuRy+8f+wivJ+Ozjc
         ppZbvtxSHrZxrn8RJXJKNHweakYMaj95xWNsZyJ61jH1qm8qFstonJELKnSlYg8siWW8
         Sr/ZhXt8RgAEcDa2HR5cXRl2FV0t/jI4trLPL3e4PC42lhFdZxtA3NDpsHlgzryPupFe
         WfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710919874; x=1711524674;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xEIUTznrQVSL70C6oRjL1I5rh5o7wWPgx3F+xPmOKY=;
        b=bJvfxbgfudo4n3IkBAZmn30LAmFUK3Si3M3ND0E/w47mcFD8utmR25A3uc2dehcLZr
         nW343ltP3efTBIIetKVhTAg4KSjca4zcpC3F+KM5o3GKIHbnYnPM5oRQ7UGvul7gOLHz
         NZWA/d0/cD/ZmTeNga2KwORWU0BOMfRXjVlb3neMvc/2OZhjENB+U59nDpaSn32y9GJi
         xC1heFDOSHKRXjc/zr9OYdYOo/JGIPbXUboQZmFAvwXs/uKwrjSWNQFis46O2Zw8Nfn1
         hnX8rI/h8p2+QBNaXepphhblQ0S0bHUy/38fdt4Bv/fjQAnfMiVo1JIbX8W9Ggh851mC
         hVAA==
X-Forwarded-Encrypted: i=1; AJvYcCWMmQR1hj3droA6V2qZ+hu5J+dqUTvcSmoR0Vyt00JZr9uf2qnGLrrS510D35UM9eyU2be0yQGywCnuhSZuIQ5MfNNwmCXLidKUozzR
X-Gm-Message-State: AOJu0YyanfGT6+7zFhnSwe24K9pSf7Rqf9P4rkeAH2b5PGvFyNcSgF7J
	6sebR0hYT7Z+MHrzJQRs1epF+ixFedLpNHE+SGz2tnDp+OOvRFLNlLLU3vMjQxA=
X-Google-Smtp-Source: AGHT+IF1j6M4tEq92+m+SqkomIgZHn/M+kPz7rRG4xKuSv1DpkrJ9WhLR7h3XwPVp1W7n7fFi5mRrw==
X-Received: by 2002:a17:906:f884:b0:a46:be82:f478 with SMTP id lg4-20020a170906f88400b00a46be82f478mr5114732ejb.68.1710919874527;
        Wed, 20 Mar 2024 00:31:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906c00900b00a46ce8f5e11sm2481648ejz.152.2024.03.20.00.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 00:31:14 -0700 (PDT)
Message-ID: <13ced390-71a0-4edf-b2f0-19195ec30c22@linaro.org>
Date: Wed, 20 Mar 2024 08:31:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] dts: ti: k3-am625-beagleplay: Add mikroBUS
To: Ayush Singh <ayushdevel1325@gmail.com>,
 open list <linux-kernel@vger.kernel.org>
Cc: jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 lorforlinux@beagleboard.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vaishnav M A <vaishnav.a@ti.com>, Mark Brown <broonie@kernel.org>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
 "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
 Vaishnav M A <vaishnav@beagleboard.org>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-6-ayushdevel1325@gmail.com>
 <889fb174-076c-44d1-9c6f-c3b967cd01ea@linaro.org>
 <3ed8c487-544b-4d72-b1e0-edb5baa8119b@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <3ed8c487-544b-4d72-b1e0-edb5baa8119b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 07:34, Ayush Singh wrote:
> 
> On 3/19/24 11:29, Krzysztof Kozlowski wrote:
>> On 17/03/2024 20:37, Ayush Singh wrote:
>>> DONOTMERGE
>> Why? Explain then the purpose of this patch.
> 
> Well, it was suggested to have DONOTMERGE by Vaishnav in the patches 
> until dt bindings have been approved, since this patch touches different 
> subsystems. Here is the full context from v3:
> 
>> The reasoning behind this is that these patches go in to separate  maintainer trees and without the bindings merged first the device tree changes cannot be validated, thus it is a usual practice to get the bindings and driver merged first and the device tree changes to go in the next cycle. Another alternative is you can point to your fork with  all the changes together.

This is some odd style of work. Please don't follow such advise.

> 
>>> this patch depends on patch 1
>> How? I don't see any dependency.
> 
> I think it is not allowed to have code in device tree unless a 
> corresponding dt-binding exists for the device. And thus every time the 

And you provided the binding.

> dt-binding changes, this patch also needs to change.So I thought it is 
> dependent on patch 1.

But it is not a dependency. Dependency means something does not work
without another. Or something must be applied in the same branch as
another. None of the cases are here. Drop the statements.

This is no different than all of our regular works. Do you see any of
such comments ("dont merge", "dependency")? No.

Best regards,
Krzysztof


