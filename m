Return-Path: <linux-kernel+bounces-22922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FB082A581
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650B3286133
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06400804;
	Thu, 11 Jan 2024 01:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="as678D0K"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C777E4;
	Thu, 11 Jan 2024 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3e05abcaeso32226605ad.1;
        Wed, 10 Jan 2024 17:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704936046; x=1705540846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3+85vjAWnmuAqmINzQfl2QzJ3u0NEMnxOJaGB/D0sB4=;
        b=as678D0KPbj0sIUHW+qxxHH/W3AV0pvjJ/N5zcl+6TNU6ZGF2NzAcHyAFBGDvv1aP7
         O2IvmaSbwFxiYas7QhT2KW9nD9QEb6SQr6wfrZGfktvSaHTnANd7LrzJ0Xw/x1pDHQ4Z
         DnltngmFoVgNUKW1h+g4p5R+6oWRm+AfSo2kDgxcEQeyJCeF9B0nzHb1rw0bjlC1fe8i
         IufYFgBzlL8EgFqYEKlfDK/CKoOnmcIrF0RgEiH7rwfUS+a0Gl1FcKUNQ4iLz29lN6s3
         2fbQveEGT9IICRQbx3MtanyecPvfmZYCk95UT3Yci0ab6mTmuaKf8eMWKs4s6FwYakiX
         qtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704936046; x=1705540846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+85vjAWnmuAqmINzQfl2QzJ3u0NEMnxOJaGB/D0sB4=;
        b=iibHMGBsV9CESSQ7BRfehYlZPoqOAMYvHVpAo9i/a67Lu4YeqCVPLh/6i2pheBamU5
         z5SXpwfjtGluWH4wLtdGCkQJGxp0gq+DK4Ysx0rfwHaAunOKFe9yJQDDumjAkAWv7Ic6
         fzc/gMBcaRn4j/fV5GHeD7dSl1hMK8nCQUoyF0GPEK1AE5VK/Hv16hRDkG2CcmVcBUO2
         1vG+Ye5wj+XjCK3V/FE/WcBzlUn/N5eisElkO2oXY1H+8b/wq4h8p939iQPKotDfMyW0
         KLyJCDMjaKkezwbe+Kxup8BghCOcZ4coh8par2gFpkCV1C+2Es4COd3Mx+RXS43Ob54I
         2L7Q==
X-Gm-Message-State: AOJu0YxRE4lDyb8oNzQnNMAMuhxcQPnjKxqQJRNLxYprqDovHA1BjwKJ
	VgqYcJoFjmI9sqNPv/iv+Zg=
X-Google-Smtp-Source: AGHT+IHDtY/zHkCm0BIQ5AWUy1WbvTxZ/YQnd12fJR9h98cktHmfmoALSkLqP6i+09l7fOkogTzgeQ==
X-Received: by 2002:a17:902:9a05:b0:1d4:cdc9:6c1e with SMTP id v5-20020a1709029a0500b001d4cdc96c1emr336684plp.109.1704936046045;
        Wed, 10 Jan 2024 17:20:46 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:70e2:a0a5:5166:fbbf])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902820900b001d4cad5bcf0sm4249726pln.237.2024.01.10.17.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 17:20:45 -0800 (PST)
Date: Wed, 10 Jan 2024 17:20:42 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Anshul Dalal <anshulusr@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jeff LaBundy <jeff@labundy.com>,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v12 2/2] input: joystick: driver for Adafruit Seesaw
 Gamepad
Message-ID: <ZZ9CaiYCqDlSxiIb@google.com>
References: <20240106015111.882325-1-anshulusr@gmail.com>
 <20240106015111.882325-2-anshulusr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240106015111.882325-2-anshulusr@gmail.com>

Hi Anshul,

On Sat, Jan 06, 2024 at 07:21:00AM +0530, Anshul Dalal wrote:
> +
> +	for_each_set_bit(i, (long *)&SEESAW_BUTTON_MASK,
> +			 BITS_PER_TYPE(SEESAW_BUTTON_MASK)) {

This is not really safe as it might not be aligned properly, and we can
potentially try to peek beyond the data element (even though we limit
how many bits we consider valid). I changed SEESAW_BUTTON_MASK to be
unsigned long.

I also dropped bunch of unneeded casts and applied, thank you.

Thanks.

-- 
Dmitry

