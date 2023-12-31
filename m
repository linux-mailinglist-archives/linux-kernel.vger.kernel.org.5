Return-Path: <linux-kernel+bounces-13775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0795A820C60
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 19:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6490281F3D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 18:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59B59449;
	Sun, 31 Dec 2023 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZY10gzz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03045BA34;
	Sun, 31 Dec 2023 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d4414ec9c7so16214465ad.0;
        Sun, 31 Dec 2023 10:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704046335; x=1704651135; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AwaSMVrWSRKiP+4LmAY44s/3TRUbSCGRt3tgVVpbOJE=;
        b=GZY10gzzCwWoFShSK0a9q7HQBwQRlJJg5cVKVxRd2GKNMWe89l1bkUrjbon3B9S0p0
         yvQb9MNi6dRuWLsOVI3RMLyA9G4tiCjNz3+aaP08CSwWEcuveVzi/Orv/g6F8rYZsx74
         MbCoRwcxOFYZSXtL4r2nQFzatx77o5fxGUnyUweHRNfr+N81sEdtqZZY08CUhwnZjNYi
         JWZNDfpyvl6v5maW+1lw83BOLjILOU4yUC9Ceccvt4ue1tCkLTjlNqRVCPVKfUh//TX5
         SwQ0GTvps7OQGwEpDVLdIQ0luZOop/VZthLJJPEZRdzkXpfy5ffM+uFI05vsFdMwaPu9
         O5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704046335; x=1704651135;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AwaSMVrWSRKiP+4LmAY44s/3TRUbSCGRt3tgVVpbOJE=;
        b=g2xak3AUC44hCrSzWUJDQUMSI0IlTNB8Zo9OHaPucMgEJQ06XefhvO7XlbO+EiH3JC
         QXEHVZ/EQ9Wkyqh05pPK6vm9P+aiGSITLuNYz4Vhl0MuVJM43aPp4UYX3SzBe4nznZFU
         seukmeJJx5DeQ4Z9qefmFp5i4PuzmcqyQjWHVT5tyI9f0xkiIQS4qdATYLYAm1kD1cCp
         /azZd7PF/ibHq8LoNSRt0xPiiqv67Ao/O7wqAe2mHKnJcBnXegStb8PNoxNLnSfuWEmW
         YCXvg+RMalpsdzQsNPQ92hqB5mcFRgkb1pssi63yUhF1Vd/Rl04CT8yhhFg/BWxI5g4o
         shHA==
X-Gm-Message-State: AOJu0YyAS7vv5v5qL9HE8DrSV6H+wsSf3rAinFCFk8OKRsBs1EZLt3QC
	xI5CUJX4y9BHG1oMrakvmqg=
X-Google-Smtp-Source: AGHT+IFAxuGb0IaQj5xduB7Ya4NBGisdZk5Xhpo/Ai7TB2KpkGs+4yx71WgL5dEY03+oRxG7pvCfCg==
X-Received: by 2002:a17:903:22cc:b0:1d0:cf22:c6ca with SMTP id y12-20020a17090322cc00b001d0cf22c6camr8394769plg.52.1704046335210;
        Sun, 31 Dec 2023 10:12:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f10-20020a170902ce8a00b001d347a98e7asm18829147plg.260.2023.12.31.10.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 10:12:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 31 Dec 2023 10:12:14 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Abdel Alkuor <alkuor@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: hwmon: (lm75) Add AMS AS6200
 temperature sensor
Message-ID: <dba19cf5-c615-455e-8811-1e479b7fa1a3@roeck-us.net>
References: <17ba2dfdb3d25bf1b5b4ed9f858b6e28902bedbe.1703127334.git.alkuor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17ba2dfdb3d25bf1b5b4ed9f858b6e28902bedbe.1703127334.git.alkuor@gmail.com>

On Sat, Dec 23, 2023 at 11:21:58AM -0500, Abdel Alkuor wrote:
> as6200 is a temperature sensor with a range between -40°C to
> 125°C degrees and an accuracy of ±0.4°C degree between 0
> and 65°C and ±1°C for the other ranges.
> 
> Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Thanks,
Guenter

