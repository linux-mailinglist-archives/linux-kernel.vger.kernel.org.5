Return-Path: <linux-kernel+bounces-22653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C5F82A0F8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828591F231DB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A1A4E1D0;
	Wed, 10 Jan 2024 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="blerndvp"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D1F4EB26
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3376d424a79so2856150f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704914390; x=1705519190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tdRnEqYu5wrFKOGAWOsEOlXkQ2QD0vaqBMcEARPLObw=;
        b=blerndvpUZlaPwbzDpOFvoN3JPgbRgxoPUe7qPbHgz4k4KeVJx0U0QjdtYOR4NcFLe
         Jmfy77PvKkEPesceDrOScYLVDX6ZKe7PPPRZ2mQa1/Jyxw2AeKxjiPqqhoIlMQOjjwtT
         JhVOgZtMsAGcoFmcsNvJknwfPnIlA/xFGYRNIcPfEAlg9/cQ1XUL2v09ubgNlKrZ+jqV
         ylUg6QB8dz/yV2ZG5Sq5r3ULPeD9vRENvYpaG8kktncv3tph0yAyxXpoyugDOdzhRoEb
         XtzvGROsSU3elTDCEruTEYNl/FaVEWvBINkcKo00dBdjPAsutfz6K9H3O7QX0dJ1sm0C
         A6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704914390; x=1705519190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdRnEqYu5wrFKOGAWOsEOlXkQ2QD0vaqBMcEARPLObw=;
        b=rp+7K2oc+BqyUUnd2t7yHlz7ndrI7lfFBhnjhNAA/p3VK7GcK1t48v5J3N/3NoWCdb
         kQ0pPoGRZwcOFb2k+sE5xptgH7Qti5w5hoLPlnT0ETIuIbNCrOfIIVyw/NVK20Rxt9Rv
         CLerRgfIcGoWD6PA3m5vEKPOkHhL/xZ2knjUMbSS4VdwcKgVZjKu7TuwcseWVrw9e9FZ
         tRvS7pg0uCDKuS++LDzHo3ALzG8hlujebPBZ48wycvu15qa7gx9evlvDWpSvCqLyHc8V
         8fn8Sxk/SpSLlwXtLsl32U0SO4LGTMPeZFuGUAzX2g8STxWxezjaMDCWNv35hrcQfAH+
         BpZw==
X-Gm-Message-State: AOJu0Yz0UGSqgiAjYV2Fxq1M2qZ1fFzYIZTRu+YlA02drIdwNu4X2XI2
	lbRpI/Osr4Lt98uIqi7tFMOElpOQKHRdEA==
X-Google-Smtp-Source: AGHT+IEmLeC2ktmpxo2R0vne+kJgsNzB9Hdh3HfglcN1MpydgXEq5JzAFIUMU2GngEm9WdIR9Tp/Ig==
X-Received: by 2002:adf:e448:0:b0:336:3b1d:6020 with SMTP id t8-20020adfe448000000b003363b1d6020mr645749wrm.92.1704914389899;
        Wed, 10 Jan 2024 11:19:49 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id d4-20020adfe884000000b003367a5b6b69sm5535607wrm.106.2024.01.10.11.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 11:19:49 -0800 (PST)
Date: Wed, 10 Jan 2024 22:19:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Rengarajan S <rengarajan.s@microchip.com>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_pci1xxxx: off by one in
 pci1xxxx_process_read_data()
Message-ID: <ce131217-64b6-4c4d-b9ec-7b07b832dba2@moroto.mountain>
References: <59f8aa13-3f88-4174-8e20-aa4467e7adac@moroto.mountain>
 <20240110141146.6422e7517fe7e07a833b66df@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110141146.6422e7517fe7e07a833b66df@hugovil.com>

On Wed, Jan 10, 2024 at 02:11:46PM -0500, Hugo Villeneuve wrote:
> On Wed, 10 Jan 2024 21:52:28 +0300
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> > These > comparisons should be >= to prevent writing one element beyond
> > the end of the rx_buff[] array.  The buffer has RX_BUF_SIZE[] elements.
> 
> Hi,
> your commit title message is very confusing and doesn't hint that this
> is a bug fix (or a potential bug fix)...
> 

Most C programmers know what an "off by one" is...  But sure I can add
"fix" to the subject.  I debated either way, but left it off because the
subject was already too long.

regards,
dan carpenter


