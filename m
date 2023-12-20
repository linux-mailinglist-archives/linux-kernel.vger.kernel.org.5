Return-Path: <linux-kernel+bounces-6819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D18819E09
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A4F1B24459
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6572136F;
	Wed, 20 Dec 2023 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dBFSbaar"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B9621361
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5e811c5c1adso12592567b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703071775; x=1703676575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8kxF8LUVYhR2aTsvs1flqh7HbUt3/a+ia0Ngdcr6Ok=;
        b=dBFSbaaryiQ9yjLsLcLMszwbWI6GKbqkGGjBZiucTGVvp58WoZPlVpxk7cKCOCqEGv
         EWXjoDX/AsY7d1GTbGcqRmRSZpI2/GVeCxQIggpvSNhzsHkHNDJTdo08sqLx3SQ5DXqD
         dc21aDFtTztraNBVjySqkpL7ubSeaBBk6u0+TXa6KaBugHdPS+lmDnxT9JZviLXIJF6R
         ij37uFbDTJ0nbHaFUdQRnrZ+keVLntQ+16GhTqGSftntN3s2SDQk3N8PWkFcSNJU1tuf
         VQTJMDH42ec1oXbg7z6DssiRnaHHbD2/m8Sciw5K6U63VZN2el6luQxH9SU3Tlneisxu
         odhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703071775; x=1703676575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8kxF8LUVYhR2aTsvs1flqh7HbUt3/a+ia0Ngdcr6Ok=;
        b=wu++DQEz+AeWRUkcCupd6e0qaEE3cMcbll/+lcoMcoX1bEjktcu47mYyMthnWRBWpF
         /nd2Z0hP6QnDPMqwLxDtxU1zyy8xjodf3+UX6vuvbBO9xFKTgAfOg5Yx5lUPP02i6vAS
         cr4j0D111JItQelYuY3tCUQC+QZb3uQYxdvmXPDl2NuVUXiyhvFXdWvdOgMF1Wa4vYsV
         jEneH32Z0EE8pDTWtmvHmaYu0DbfT1ldWA0ydsf2ZSWNVrs2AtSp3NcVG24NgxqAaSPa
         tBdTY/mwJBIzLWYN/6q/jbV3ClGiXOANmhf+ZHwMJsmg6re/O4PmxzUelY53npKexXxj
         Me4g==
X-Gm-Message-State: AOJu0YxIJPyWCymbm48xoEQLsDh6HOk31SCXhc+VdMsW3LooqVqxHaTU
	KHpAkEn7z6IdeX+LHi3fqJ3/RuVZRuTwP2eZZYuajw==
X-Google-Smtp-Source: AGHT+IFEILbPSofwXJi1nVG2FR851hq+WQps6O0WExCpGnchqqyCMig+vcIB+eOMT9ukErRIzCdi+DRmnoTbp40O6/A=
X-Received: by 2002:a25:2e4b:0:b0:dbd:38c:e612 with SMTP id
 b11-20020a252e4b000000b00dbd038ce612mr4396939ybn.84.1703071775603; Wed, 20
 Dec 2023 03:29:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219004158.12405-1-warthog618@gmail.com>
In-Reply-To: <20231219004158.12405-1-warthog618@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Dec 2023 12:29:24 +0100
Message-ID: <CACRpkdYq_zfBoWVhRHLD3WH2GXi1f7+DgFnZhmp3L9KwuVo-2Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] gpiolib: cdev: relocate debounce_period_us
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, brgl@bgdev.pl, 
	andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 1:42=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:

> This series contains minor improvements to gpiolib-cdev.

Sorry for not reviewing this in time.
For the record the result looks very nice!

Yours,
Linus Walleij

