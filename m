Return-Path: <linux-kernel+bounces-2664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C4B816026
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 16:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F692834DF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E430744C9E;
	Sun, 17 Dec 2023 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvYCyXxm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2644C7B;
	Sun, 17 Dec 2023 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4257ba1bc5fso24598021cf.0;
        Sun, 17 Dec 2023 07:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702827201; x=1703432001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5Z4tR06Qkm0+yhPoaVhQmj48yvm7Zr+y9XzEyeTPI0=;
        b=CvYCyXxmxy08oVqeMNCi5U6e3758b3ej+eh+fL5RIwXYZibozGJbjy3yyRqPlisXhE
         NzeKUhmiTfgk/ScLFXVgUBAO92zGwIGAEw2RijU4N6cd8aPpEj2kaeN+Vk+N9YTqKycr
         ktfr2+rxU5G08NduNyb2vPxVsWieAxKC+2e3jvwY9RAZ3o5MGqdXT0gSzXLIJ96Slya8
         U6fjl6nd7coMLaM0Wrjix2JFXFmq3lj5nFr/+k8M+KAjqezDwsSFBC3j7ujQ1q806Qvh
         zb6VH3CQc/MuzVqYIkfCdKkzTmitsuuvRN2uAPSrPL63ngwtEr3mLdJDR3juPf4mY9Dt
         L1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702827201; x=1703432001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5Z4tR06Qkm0+yhPoaVhQmj48yvm7Zr+y9XzEyeTPI0=;
        b=RbPnvoDF8oggreISlEKjy9lXVdf/EkF7NJIONEI9sBk0fDIkaGsVnoc2vxlISvSKjl
         2cI93qeZsqyEYMnqQFvUKuavBMEX+3pznGY/7+bROOldQvbvEaobZS3+U8+0t6gAgZEh
         cMpQL55RNWOOTyPyEvcMOzTMSrEn0Cc9hhVSBiHCqLb73CwH6pklkFVviV1TNywAPtzo
         eHHyYPBKtZSJzP+68N58Ld31YYPx0VjkgOeSTayEOPIlG6T5R4DAyq3qIahFs7LR9Nvo
         mies38ugRG/giLzZHPXoWQbFlCTE4CRUvas7cKXQWu1D6EJVAmZZipvMyKmCsYwOFNJ6
         zazg==
X-Gm-Message-State: AOJu0YxbEEJz/PrAKtkRVKgiMT0cOWhexPjoraDyQCtHAxeG11FH5ClU
	fWgrqfbQIAYYiDANcnQwyb5cN/CM9m4=
X-Google-Smtp-Source: AGHT+IG+rX2LsMaUu+ADAb4PaMIvL834e14XpGk9OidFNNFIXmM0sY9KM4s6PVRUg27xEyf932Yaig==
X-Received: by 2002:a05:620a:1271:b0:77d:5a1d:cf4 with SMTP id b17-20020a05620a127100b0077d5a1d0cf4mr17019544qkl.47.1702827201410;
        Sun, 17 Dec 2023 07:33:21 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m26-20020ab0751a000000b007cb8b709b31sm280484uap.23.2023.12.17.07.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 07:33:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 17 Dec 2023 07:33:19 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Mark Brown <broonie@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Peter Yin <peter.yin@quantatw.com>,
	Potin Lai <potin.lai@quantatw.com>,
	Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (pmbus) Add support for MPS Multi-phase
 mp2856/mp2857 controller
Message-ID: <9abe3c01-f6ba-4791-9cf8-d73dfe44d899@roeck-us.net>
References: <20231211160519.21254-1-potin.lai.pt@gmail.com>
 <20231211160519.21254-3-potin.lai.pt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211160519.21254-3-potin.lai.pt@gmail.com>

On Tue, Dec 12, 2023 at 12:05:19AM +0800, Potin Lai wrote:
> From: Peter Yin <peteryin.openbmc@gmail.com>
> 
> Add support for mp2856/mp2857 device from Monolithic Power Systems, Inc.
> (MPS) vendor. This is a dual-loop, digital, multi-phase,
> modulation controller.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>

Applied, with reservations (because due to lack of datasheet it is all but
impossible to validate the code) and several fixups. So this driver comes
with even less warranty than usual.

CHECK: Alignment should match open parenthesis
#671: FILE: drivers/hwmon/pmbus/mp2856.c:413:
+	memcpy(data->max_phases, mp2856_max_phases[data->chip_id],
+		sizeof(data->max_phases));

CHECK: Please don't use multiple blank lines
#673: FILE: drivers/hwmon/pmbus/mp2856.c:415:
+
+

CHECK: Please don't use multiple blank lines
#707: FILE: drivers/hwmon/pmbus/mp2856.c:449:
+
+

Fix those, and use i2c_get_match_data().

_Please_ run your patches through checkpatch. The above is really
completely unnecessary and creates unnecessary extra work for others (me).

Guenter

