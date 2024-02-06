Return-Path: <linux-kernel+bounces-54430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 641EA84AF23
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858151C227FA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4EC1292E6;
	Tue,  6 Feb 2024 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+HZhccr"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786AB12883F;
	Tue,  6 Feb 2024 07:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707205242; cv=none; b=QdtSy4WKgSHhFkr7VV5k5sNmf6Kr6Wgg+8iDv2uG6drPk0Aogq/p6y2PNwlT1s7V7iNY85uJpgteLwY7ESh5JJK0YhSKQfucK1wrkhg0d6OHpMt8DYq5v0u7p4GWfOzpr+r2c+C/LeQPEugsGOv0R5/eXCIO3bLIdbaFKKpY2hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707205242; c=relaxed/simple;
	bh=arCcW8vWDSz6V/iUzeoCUInizasGX6kVVUs3EMiYR3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaYS5xqyqhTtp2F4WdpxJfGTAT6l1fR8WX+9eSAMRlPRd4TPvt5GbOduuhrJT4I2z4Z4YnGYmJ1nqrjZXRqPouiTdMVuZhTc2FGvSBPxu2Z8VDQxtjpdXTfU8pZKMA09mPAREYp7iK4Mp2YxugGYKGMD9rh8TXEhvOWA7f6M56o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+HZhccr; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29080973530so4324152a91.1;
        Mon, 05 Feb 2024 23:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707205241; x=1707810041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EPKYHR/NtcQsnCb8KpcDdphKAv9ifKpvDNB/RB3Iecc=;
        b=U+HZhccri7qaR0kLCCi1b5n8PmupeHRrnqu83PT6xBw2NSU43vmILKdQSiSFEIM9X1
         ZriJumHf4ZQQeTo2PX007UNZqj/SlZAnDNPY8kfy/QkHvxzOBfqO59X/GNq92OEZqGF8
         YNIWWOWe75lBd0X5ICGDeudYAK2ntYnyNQPQLeiLwHnQvM1xnIn0ilMoHBjBVZo5+GL+
         ijMHd5rp4vY+RbU1qMLFWpYFdvGahDrXD8I+cdhzR8cILpUA8cg5SGenqJzMmxlOATIk
         aQE7GrQlPbfJXAXcbom986oHv7YvJF9Hlwmwq0ZmKGhHnp1/GfT+nVkuf0tHolstJGtN
         oUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707205241; x=1707810041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPKYHR/NtcQsnCb8KpcDdphKAv9ifKpvDNB/RB3Iecc=;
        b=Rhs10jaWG8YrGbe3tHaARZlHKPJS+iy2SCaR3qzy236DGEEZMA2/dtwoKf+yZb71mF
         1ipZfMg6c7e0Wqop3qsAkqBIAsKmsRuOLEvGqB9OCL5JB/xTiv75O5MtvrcRZwNCZMFJ
         YqUutBTWkksxMpedsk045k11kqjTuyVKjBKahfdSta/Fb1l1SaRfG0xKErOoPfRaPjag
         IXNkSmK0FcWdKWmp+tPtx+Jr+vvLK3jlBj+kKUsT+g2tITL4/HxBNPHnO9dT4ZFDsFQQ
         YmE85j4Iqv4JP8SAuR5fNdqBlQseWZsyjGbXnCG/rmNh0vb3uvI6+rgnyhUxSpD4Oh3A
         ZwaQ==
X-Gm-Message-State: AOJu0Yw1R6n5D+kKi5Zl9C60ew7ZOeKqXfoAiYhLUeNtEAOM+z71NnPm
	wTOfLR2TZS4f320m/ZGqlypIT6WKfs+yxnoRx+BfzEzSL4K74P51
X-Google-Smtp-Source: AGHT+IGKpyaA9KdX6ZOSDIvVsXYUOWmnDbIa5f9G+5VJHj5ti97Z4qnMuwmuRPuKFzda9jzh5VKH/Q==
X-Received: by 2002:a17:90a:2b87:b0:296:2776:8872 with SMTP id u7-20020a17090a2b8700b0029627768872mr1797505pjd.36.1707205240680;
        Mon, 05 Feb 2024 23:40:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXYhIuUE346q5Tt6mPUuNdx6mWgrk8m/SALnpBhVBKDBByjhuJ1BJL4Jq/CRxiLtFAt8X/FVZGyuzvzg9+2M4S7Bzh8xu6I+eWfsrgocqgcISxm7PI8mPuA60kYU94pxybFUzxO74kwDF7gXCAQ0Ln5o6n4jvVqxgwyhtqwmtvONG7pt8zxRc3qiU7ItVHUJrJhU+20DaxLqS0zaibJcn1+0W4oj2zMxXqFN7PceYW/AwCD+bh7Mqj9EN+HHBS4UTQxyMrpVtenjhZ+WpDERpq81jfpoujV75GqWw0VkD1gwHUJd5rViZqLXG0tkwPt124JWj2Tp1TpeHqSoqj/Lld7BXWye/1gyc8DwonqsWD9qsVFb4vBL8VFow5wcx1k3zg2y8vC0UFCskbu6EqhMkYY2qxMziJi+RUMju1MihxxI6tyczSgNqa6+K8=
Received: from dragon (144.34.186.27.16clouds.com. [144.34.186.27])
        by smtp.gmail.com with ESMTPSA id pv17-20020a17090b3c9100b00296ac1ed69asm785270pjb.11.2024.02.05.23.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 23:40:40 -0800 (PST)
Date: Tue, 6 Feb 2024 15:40:26 +0800
From: Shawn Guo <shawn.gsc@gmail.com>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH v2 0/2] nxp: imx: Add support for Apalis Evaluation Board
 v1.2
Message-ID: <ZcHiamfoDeZ1rueS@dragon>
References: <20240124141849.26254-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124141849.26254-1-hiagofranco@gmail.com>

On Wed, Jan 24, 2024 at 11:13:18AM -0300, Hiago De Franco wrote:
> Hiago De Franco (2):
>   dt-bindings: arm: fsl: Add toradex,apalis_imx6q-eval-v1.2 board
>   arm: dts: nxp: imx: Add support for Apalis Evaluation Board v1.2

Changed the subject prefix of the second one to 'ARM: dts: imx: ...'

Applied both, thanks!

Shawn

