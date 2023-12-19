Return-Path: <linux-kernel+bounces-4829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EE7818296
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8CA1C2388A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94987C8EC;
	Tue, 19 Dec 2023 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RO0Xx/x3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CAC11C96;
	Tue, 19 Dec 2023 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2343c31c4bso304970066b.1;
        Mon, 18 Dec 2023 23:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702972343; x=1703577143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ditOhE+0seBqU2UlbkqGvYHoVQu6xwEtezEcpATI/0=;
        b=RO0Xx/x3neZlw51vrpCKFn/zpSJu+id5RUGAEb8RHhAFhk+3H21aAsr7Ubhtr738RS
         4evamwObYRVQiFv9aqt3DLHy8MXaBOu9+ISkrZ/xcJlQ14D0+vZB6zvCoPTtxMe87StV
         mXxUnrj7aOnP/A3fwT68XgOiHm7001j2xyVT6wS4zjNDv7xC3ZOIXfj/7GZBQC6dn8z9
         2Nt9t0eI/kI/olyiwyrVFlz6m1mos+USIXLnPTG5/yzk0OV9wdGXK4ZnFb/g4mDqDmwk
         F2f2sP+efNjKGmIBEi5GR3GmZijV21w2ItBxgVVpI15YQ2wv0xzIGLFGa+fP5/7+LiR9
         2iVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702972343; x=1703577143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ditOhE+0seBqU2UlbkqGvYHoVQu6xwEtezEcpATI/0=;
        b=VtTADqCOAb50y7kVQpT/kKh1a3A9XxbM4NSLEjGfmyOVG7ny5Z0F5VGU2tstkGrnaB
         pJrrpCwxiJVH6muifQDT0Ll0cxfZDIEk3LBa0eAGP0WkxL8Q7N7BeA4N8jqqXWWa4PnC
         VvC2cKVVI/bfPoyM0lSRSQr1SpAszeVDg0JhS8sTxl03S+oQwC/dCz8NvHX6P9Gmd9b+
         ARVR3suSC3dFbLpGBuaFJ5hyuEpg6TUsQRdxNuNjVC/1nfjdmZulf/bs1dnhZ5HbrPii
         TWtrkLk/l/8OEkNFqRk5xrPffaJPLfNXV0st7T4f7IJ6j647ZOiMiAbr72EcdFtsVoPg
         ojOQ==
X-Gm-Message-State: AOJu0YyVa8mQhuxHi+3SqxiK4scnJ6pGyuKXW7fo51jqkMcpmDOV4Yjb
	4cbc+1Ev4JtTqRrXzb13pbk=
X-Google-Smtp-Source: AGHT+IFj+ah6FefdOL+HjfZxK/azv2LFp/Sj5s/dB/Cylsu3X8kyol3vvlFIN94YYD3RuyvofZ/DrQ==
X-Received: by 2002:a17:907:d406:b0:a19:a19b:4224 with SMTP id vi6-20020a170907d40600b00a19a19b4224mr6691183ejc.143.1702972342628;
        Mon, 18 Dec 2023 23:52:22 -0800 (PST)
Received: from [192.168.100.74] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id tx17-20020a1709078e9100b00a1b75e0e061sm15125257ejc.130.2023.12.18.23.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 23:52:22 -0800 (PST)
Message-ID: <ba43ce1c-433d-4df9-8421-67c24cea09b7@gmail.com>
Date: Tue, 19 Dec 2023 08:52:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] dt-bindings: hwmon: Add Amphenol ChipCap 2
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <20231020-topic-chipcap2-v4-0-7940cfa7613a@gmail.com>
 <20231020-topic-chipcap2-v4-4-7940cfa7613a@gmail.com>
 <521e7e47-099c-4a95-8681-cb690f159ccb@linaro.org>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <521e7e47-099c-4a95-8681-cb690f159ccb@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19.12.23 08:42, Krzysztof Kozlowski wrote:
> 
> Please test your patches before sending.
> 
> Best regards,
> Krzysztof
> 
Sorry for that, I did a last-minute modification to comply with the
changes in the driver and I forgot to check the bindings again.
Definitely something to avoid in the the future.

Adding the const "amphenol,cc2d23" to the compatible property fixes the
issue and passes the tests, so I will include it in the next version.

Best regards,
Javier Carrasco

