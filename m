Return-Path: <linux-kernel+bounces-149190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46DF8A8D00
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10D53B24C6A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBCB47F7D;
	Wed, 17 Apr 2024 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd5lCre+"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3544B1E48B;
	Wed, 17 Apr 2024 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713385947; cv=none; b=qfIrHDV0SUzdN1Qrac3H60BjkWlujkEDTuRSxR1LnET3uGHqoiTwi3Yz+bDmEW28xMoXGp3/xEtcDnHJ43kVrtHMYwso/ECP9PHhQ9xPqLdWEk7fBQtGStz65Y3/xxR+ZCodbfd7pfDYXmM87vbvXttAJGAgau0MCcE29cN50xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713385947; c=relaxed/simple;
	bh=Bp7/jJqYjF0Ufn+wONJ27PQy6j++8W3yduqSFKReMUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtU5Z/q59q9SJMTd4qawT1hHOg149sJ42hmBFIpPuL0XVHW/7hxo9kAY1bpdx5BB4cWCikw58UUlwZtClos4VBsPIWpGtfV4chYO9LGsDB5STNkKuh9Wc7L4i7R/sCvvk9i+nS6ElPSAY0jWrwrCYg3diXUS8XFDXvmaXrHpdV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jd5lCre+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-418d1edcd4cso1276625e9.1;
        Wed, 17 Apr 2024 13:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713385944; x=1713990744; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3lo45R9LbyC8+5GXWJMBZAtN3X7dVs96M7iPR9wUUDU=;
        b=Jd5lCre++/rYWjiYoMcL6GmgPwTOZdiD53WDRwO0z4AQZwlRFLkqnVzsg6GZSpQg6b
         dInsjq0Iz0AzWxj0wcGeoQVLbc3YCTKHnDyUquzkHg9at/m8pDwNeLQ1MQQ6Xxbvkll+
         RTbacRcdDxXIgxKTVF6FAHrjmoQJXkSC0KJKyirph74u2KoArJQpRuQgWBi/0PZ6HE2Q
         yATYOGW2GOApaw6dkebN7xJURnC+abkdi3mdQIi5fuGju36cmUNOOGMaq6so3+gs5cKX
         OW1u9LhIXBrCbFk3OKINDX9fl9noXfciqQ8lV68UMDPHuufB7t2A/7QDwSEtBsrZefoW
         2feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713385944; x=1713990744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3lo45R9LbyC8+5GXWJMBZAtN3X7dVs96M7iPR9wUUDU=;
        b=bY3ZRr9xQOz0FTgxrPr2xLatabhP3fLS9gAm3h0Hsc75DMqr5Jrzcp4GtqflKo4G23
         kga93SWXBlIEdigGs/Zl1YN/krI+5DxIZZfBxkcP0ntvm+8k86+jQpkE2QI0K6iS2bW0
         LxYU7futVV06bgGrsrB0QlOLYBjboQlNDbIazbEM04RJHYalYuOI40J3araapTLxki0B
         7sG15xTStWEV/wingPthNDpg7ewjNURrwjoKbY52XocAhL/sWlWts5W49TQ8wuE16JKc
         PjWCfNRLZUZITUvTz4NdA8Gxaq+1davbuX3myVr2pvlWE/JDDTnAxDYfc1Ln4V5007P+
         sCMg==
X-Forwarded-Encrypted: i=1; AJvYcCUj62/esPPYh+TQR0nnVAQHop5376yfHrCoEOaWsOU6jULGhuX27blLSAI1yavOAy3PqLv63fVGOAVArdXGPYq+qR6WwdPJ+4GSWl1r8AdLoROOgVCiGBOZ38T6nN5Ql8aGEi9gT/A6zQ6y1zHs8vSRdcM4h52Ve4d3QbvriO1iUNOlog==
X-Gm-Message-State: AOJu0YzGj3AwPDAPts67f5DSkCBAMegfgVC+LOocZxS5YCG1VUeFSDhU
	1BXtqDvIgG5rRl7Ph/as5ECAjNG9XkP2UWsvS4qoeaQHv3PQcLu+
X-Google-Smtp-Source: AGHT+IEraNpT/6Vq6fA9vsxYdOXx0g1Se19Swwcf429ga+GBrjJSwS7ijIkP2LbUsDhoqDXbbwUDOA==
X-Received: by 2002:a05:600c:1ca9:b0:418:93f4:b4ef with SMTP id k41-20020a05600c1ca900b0041893f4b4efmr601343wms.0.1713385944301;
        Wed, 17 Apr 2024 13:32:24 -0700 (PDT)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id s6-20020a05600c45c600b00418244d459esm222251wmo.4.2024.04.17.13.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:32:23 -0700 (PDT)
Date: Wed, 17 Apr 2024 22:32:21 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] pwm: mc33xs2410: add support for direct inputs
Message-ID: <20240417203221.GB148552@debian>
References: <20240301111124.29283-1-dima.fedrau@gmail.com>
 <20240301111124.29283-4-dima.fedrau@gmail.com>
 <dwd6idyv2dvfih57sdfnr6cxztrx6gv3pwuy6rdopjw2lv2z6y@in2sn56t3x5k>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dwd6idyv2dvfih57sdfnr6cxztrx6gv3pwuy6rdopjw2lv2z6y@in2sn56t3x5k>

Am Tue, Mar 19, 2024 at 05:38:52PM +0100 schrieb Uwe Kleine-König:
> Hello Dimitri,
>
Hi Uwe,

> On Fri, Mar 01, 2024 at 12:11:24PM +0100, Dimitri Fedrau wrote:
> > Add support for direct inputs, which are used to directly turn-on or
> > turn-off the outputs. Direct inputs have the advantage over the SPI
> > controlled outputs that they aren't limited to the frequency steps.
> > Frequency resolution depends on the input signal, range is still
> > from 0.5Hz to 2.048kHz.
> 
> I didn't make a big effort, but I fail to understand the concept here.
> I'll delay giving more feedback till the next review round for this
> driver. Maybe then the description is easier to grasp.
>
I will drop it for now and come back later with a separate patch. I
think this would make it easier for now.

> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |

Best regards
Dimitri

