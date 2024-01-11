Return-Path: <linux-kernel+bounces-22923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D58782A583
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93CBC1C22FDF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D62807;
	Thu, 11 Jan 2024 01:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUfnHiP6"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DC2394;
	Thu, 11 Jan 2024 01:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ce74ea4bf2so3123676a12.0;
        Wed, 10 Jan 2024 17:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704936062; x=1705540862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JHpvuaXHtdCaSG+65uNqu4N8NK53ELdVOys3xfjWvOM=;
        b=AUfnHiP6B1z2jE/NlVSMCGQBXAyPEyyOse0dF/uyDYYtDy2zMmkJKpNJpkM2xc+Dee
         /kW9U1gVqIakmlewcc8gisfLZBCEwozP8lwwvgVsIUsYLt+QapotTl7JMd7WhzUBQEOv
         UYOHEA4Bzc2GpjSMRlMJzZ5x/RDm8ZIJis4hsuO7ppBlt/IhFiSnE4xUfIUpWvsKy13m
         mFxPqjSdY+FIJULO8r1dZYqC730irzlPn7Xqs6pokzto2Jvy9SpenuXy7GasPdzUZOPE
         qRsJ3ut9+daVXr+TlnwKDJ6l64b398A1Cz3iO8+Cu8V1EiqW5mL3WBlZesgMSmLTzd47
         30Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704936062; x=1705540862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHpvuaXHtdCaSG+65uNqu4N8NK53ELdVOys3xfjWvOM=;
        b=uQf6TETCSL2yIYUUGaIUGeHpCvquyCdJuofC9LV+J2E+oqusqh+w3ZJ2pyKRuyAfMx
         ref19aHN7W1mL65nsZvnU53ctkaiaSWonDxPJ8UaJnnctu4q4wDD5WgcjoH+/Rgrysfj
         ZX7Yh+cEbcmjL+XU53UVV5/gMA1rdXBifIqyFxhmiKd13eCB3bTMmujBuqV6QLUn9/GK
         jwW4E0TnRVutPJ/HknmXs0i+rmNL+0T61cG2ePIaAwdQEZGhw6Nu/F5lK2pL1nT17WBL
         YLTOBFy5in7j8kIthUQxle5KYOR8Q1PtkaWsqV1l7FBkijc/p7tFTkFPPjFRXohK18Qo
         1yRA==
X-Gm-Message-State: AOJu0YxizjQB54/u1zwb8mzwhjUpqDy8/lvBGjw15ImUyy/GQzK0vbEx
	dAIBp9pjh3F2UdgTUfQNgQg=
X-Google-Smtp-Source: AGHT+IE14qvrP/2cLWY/HBlCo+wLDJ14aOuepE1K27DJXRzvWLp87IZxeCygH+1D7lZKavhdCWqoGQ==
X-Received: by 2002:a05:6a20:9706:b0:199:fffd:a3e3 with SMTP id hr6-20020a056a20970600b00199fffda3e3mr405012pzc.52.1704936061575;
        Wed, 10 Jan 2024 17:21:01 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:70e2:a0a5:5166:fbbf])
        by smtp.gmail.com with ESMTPSA id v6-20020a626106000000b006d98f584ad5sm4262356pfb.199.2024.01.10.17.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 17:21:01 -0800 (PST)
Date: Wed, 10 Jan 2024 17:20:58 -0800
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
Subject: Re: [PATCH v12 1/2] dt-bindings: input: bindings for Adafruit Seesaw
 Gamepad
Message-ID: <ZZ9CetbTOHuVzR1A@google.com>
References: <20240106015111.882325-1-anshulusr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240106015111.882325-1-anshulusr@gmail.com>

On Sat, Jan 06, 2024 at 07:20:59AM +0530, Anshul Dalal wrote:
> Adds bindings for the Adafruit Seesaw Gamepad.
> 
> The gamepad functions as an i2c device with the default address of 0x50
> and has an IRQ pin that can be enabled in the driver to allow for a rising
> edge trigger on each button press or joystick movement.
> 
> Product page:
>   https://www.adafruit.com/product/5743
> Arduino driver:
>   https://github.com/adafruit/Adafruit_Seesaw
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
> 

Applied, thank you.

-- 
Dmitry

