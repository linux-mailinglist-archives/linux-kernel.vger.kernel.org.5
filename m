Return-Path: <linux-kernel+bounces-14298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2C3821B0C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F38A1C21E3D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25C1EADC;
	Tue,  2 Jan 2024 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1wJhPs/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D950DE555;
	Tue,  2 Jan 2024 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3367632ce7bso8080581f8f.2;
        Tue, 02 Jan 2024 03:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704195300; x=1704800100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=orKv+A6OSfDSCHXqZgMuKri0ZasQ0RBaPs91SHs9hs4=;
        b=Z1wJhPs/+m6cROii4fyc4JZnfOXbocQ6f37emD6PHGC6RdXDircjHWk6yFEQPDZeUr
         tmADzMkKUss9gCBmkBU1Tcl4jK4OD+yTJcm49d2+sghZuJWxo7aoqrvUyQRhFGZs3Quh
         Zva1QfL7GPQbWlNqo2v1u0UrsxAE5O6IedEWQmEEORf42xERsjUi/r2OsroKoTDT4PrR
         ziRfT4WGuCxhkhz+vY9WdLIrzdo5n2sA45UPtMRXKdeJHiv8iIcfrRbIpHqhlLepg8W8
         O5tHl3/r9mSTM/AWkMFGo8+R4lVQN5Jfk+yddNDrhByTwb1Q0z3P150ch8mg6YMCpezH
         Oa3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704195300; x=1704800100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=orKv+A6OSfDSCHXqZgMuKri0ZasQ0RBaPs91SHs9hs4=;
        b=JjlsqL7TbMI/H3pJK3LVf2DphSmZ0Do04f5JmDqwg5hXw4mKcd84v5bLk+l4sf09kO
         uFjmSnCcpUrhapPJwlkN3WVeM/+UZU1r9EJ28bF/MVlhaHc8vut00zPUd2iEwibq8Nht
         hsnRHWGVgrwh/fEvu7SrEW5nSvtXis+9tz/pkfAMSKXg483u/xsRuLNBaHLKCL4gJHzu
         UDll8M60vgI+uGxtVT1tFF7zXW46F8352hWPFNf5U9GIbX2OXm30r9XpTDd/IN0xWm9P
         WdpcqXR1KUwHN6Z4h+V64qXEn1XWlR0983qflXouW3Dzwa+2qjoEftRzAlbHLyBpo8Wn
         On8Q==
X-Gm-Message-State: AOJu0YydyHPzLzVGXnfu09+1HADI4nthZGlpDJ6qRJsgWrq9PwTYc63o
	8s3zgqoVlGY6/08PD3cE6dmg4Hz3dd2BYqJH
X-Google-Smtp-Source: AGHT+IFELfAmzLhdsEPLyRg6tHOQEeIWwtkfVf7ghI/7U2Dm2/h+LkSyBXG29dKTFvqZGT4Ld73Xfg==
X-Received: by 2002:a05:6000:1c9:b0:336:7e39:a9c7 with SMTP id t9-20020a05600001c900b003367e39a9c7mr8644733wrx.141.1704195299883;
        Tue, 02 Jan 2024 03:34:59 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:f280:eb5b:2b83:dc35? (2a02-8389-41cf-e200-f280-eb5b-2b83-dc35.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:f280:eb5b:2b83:dc35])
        by smtp.gmail.com with ESMTPSA id u17-20020a5d4351000000b00336f05840c4sm15498408wrr.100.2024.01.02.03.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 03:34:59 -0800 (PST)
Message-ID: <c0c18292-b766-490d-a564-275f25d476cc@gmail.com>
Date: Tue, 2 Jan 2024 12:34:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] io: light: as73211: add support for as7331
Content-Language: en-US
To: Christian Eggers <ceggers@arri.de>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231220-as7331-v1-0-745b73c27703@gmail.com>
 <20231220-as7331-v1-2-745b73c27703@gmail.com> <2337038.ElGaqSPkdT@n95hx1g2>
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <2337038.ElGaqSPkdT@n95hx1g2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01.01.24 09:20, Christian Eggers wrote:
> 
> As I still work with Linux 6.1, I backported this patch for
> that version. A short test with an as73211 didn't show any
> differences.
> 
> If I shall test further revisions of this patch, I can do this
> after the 9th of January.
> 
> 
> If I shall test further revisions of this patch, I can do this
> after the 9th of January.
> 
> 
> Tested-by: Christian Eggers <ceggers@arri.de>
> 

Thanks a lot for testing, I am glad that everything still works as before.

Best regards,
Javier Carrasco

