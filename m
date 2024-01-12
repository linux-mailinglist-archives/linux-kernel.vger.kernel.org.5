Return-Path: <linux-kernel+bounces-24843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD2382C352
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B78DB22CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDA473179;
	Fri, 12 Jan 2024 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AuS64Mi0"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6B673165
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7beeeb1ba87so34354139f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 08:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705075681; x=1705680481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtoHWZ99B2ThLFNUBH+p4UtbFzDTjEFR2zCJ/MgSZl0=;
        b=AuS64Mi0vOEeDj2TRdaZvm9FnXbENRGinn4tVajD9zJCOeNIc9hm+9jOzdWBgRrigg
         o9uVyL24qvkP/KPlARV9uw1RBPnbB6OfDJBTc9poerP/5DsTf4VCeaKMv1fAGkADgSRj
         SXae34TxLZ5ALunH1jLddpPDqMHAHibz+TMW/3hos7utooKfi4rsgKNvnaoXSn3psGNe
         NmJKMS4DEPrPcCMUmQDGyKPDWyVEzV1Gqu5jF2MfrJBf+2My56pflSH9xhsimaWcQZiT
         spK/fZTV0i60reX+pTafsYFVfBW7F1M82j2vj2o/UP37fF1Hk4AdNfb8rVviPr/ufk+i
         uWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705075681; x=1705680481;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtoHWZ99B2ThLFNUBH+p4UtbFzDTjEFR2zCJ/MgSZl0=;
        b=HW7kEQSqMNKT/UACkNrD6EjUe8I1DuiUT2iN/wwnLgNiIsFDtJFUOoC3OmkOUnbfeJ
         np7IAZ+fVYJZRWAf9daQEAkTp5UqpLM5/gvDZK3oniuZd18kCb82QZ6VpLfwfIw/uzny
         /w11iCxg+T1wOVjo9pxG44y0qGMcMEngvDxGPbTAccbbnblOe3C1no/KtznidMiGeavb
         hZtq2zesLL/fk9lFg7dkyDIhVYi8mOotwFBsYy9NKYM3tfSBN9joJWR2lQ6Y8PWgIEm9
         J2fllc33TouCgcmUvSBkwj49y3/D1wnjidKqpRroBhKSSMS6hSUFCjs+FTKm4ZD35dUs
         fkIg==
X-Gm-Message-State: AOJu0YwJCvVmPX5JAqsEF8ldebKTSB++PZavxFeUWB0+7H1BlQjGAyNB
	/Gn5kECX2q9V5N6/oEfb844dLqEXGdPinR4vj2GyuHLW7nFVjg==
X-Google-Smtp-Source: AGHT+IHKR+V+EZfBu7Epg3SVvtSsdxta8fN1DAtH3/aqcp8GCRXCwg2aKC0fFrZxPD4VzBCtnXT/YA==
X-Received: by 2002:a6b:e505:0:b0:7be:dade:b053 with SMTP id y5-20020a6be505000000b007bedadeb053mr1922686ioc.0.1705075681679;
        Fri, 12 Jan 2024 08:08:01 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id k13-20020a5e890d000000b007bef5867ac8sm853127ioj.52.2024.01.12.08.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 08:08:01 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Christian Brauner <brauner@kernel.org>, Min Li <min15.li@samsung.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Christian Heusel <christian@heusel.eu>
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20240111231521.1596838-1-christian@heusel.eu>
References: <20240111231521.1596838-1-christian@heusel.eu>
Subject: Re: [PATCH] block: print symbolic error name instead of error code
Message-Id: <170507568074.2252898.16058213199435982083.b4-ty@kernel.dk>
Date: Fri, 12 Jan 2024 09:08:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 12 Jan 2024 00:15:18 +0100, Christian Heusel wrote:
> Utilize the %pe print specifier to get the symbolic error name as a
> string (i.e "-ENOMEM") in the log message instead of the error code to
> increase its readablility.
> 
> This change was suggested in
> https://lore.kernel.org/all/92972476-0b1f-4d0a-9951-af3fc8bc6e65@suswa.mountain/
> 
> [...]

Applied, thanks!

[1/1] block: print symbolic error name instead of error code
      commit: 25c1772a0493463408489b1fae65cf77fe46cac1

Best regards,
-- 
Jens Axboe




