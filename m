Return-Path: <linux-kernel+bounces-25484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 010A882D0F3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EAE4B215B0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 14:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851C13C30;
	Sun, 14 Jan 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EK83sAd8"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68E923C2
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6daf21d1d5dso1197882b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 06:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705243091; x=1705847891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slYG4/qUPS5LvmTSE00TdapIZbw89Wa5F9GMGjLGJYw=;
        b=EK83sAd8acrfoPmfv/7OUOqGfQdCb5aZn0Xnzc58YVKlFB6k5hOmrU3ErhuHaJRTCS
         pmNUx9qE1QkVFxb755N5eaajRVlcVmpOP8RuMfhObD944ALvxT75xkccaYkt9x/iYiPA
         TLt83GO94/GwRt3BR6GTi1EtbTwB4jf1CTpxPtDpceFAuneEiTFd2Q+o8EN30XHJ58Jy
         P7BqCpuevoGgeEbEQtVVy2sXuz9F5N4icnbpKvn7nmIMDPR9RX9kRd1Su2lBZotrtViQ
         BB5OZkwm43FB4+DW3xpRWKwnULECQL2ifBqYtQhLA7jF6yAkaH25f/isWUZx7BH5Wz9N
         YWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705243091; x=1705847891;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slYG4/qUPS5LvmTSE00TdapIZbw89Wa5F9GMGjLGJYw=;
        b=oO+QCBFEWWAPm1ULz0HOgLDJTEQSN3p2+rPbQWDhXR2/qMEVlbfXYCwInRbTkkm4ku
         8qYdxN+hDSjpVhCOR1mTWdRaAOD76dcaBMs5E1ayJf/Nqih9wdWFgcfkxcCG38IVMR7W
         gmQdzOy1dZo5mpMGJX3de32b6GLmHovUFpL8AdoAmfmsDI9SQIzakyx+H+OhyyED+VB+
         P3k1IEYHOVpxfMT3ZtooO2LOEyDtCDiZDBsnwMW1dPTuhlNW3MzlwfHJPYXZkPa+e/di
         HvSuEY1P9zJ4UX2gRBBG7xHO/5SCtNCjjMyyBhEWjTgl9+0uIbh8cc2bTjIkxQ5vl7Pn
         eRtg==
X-Gm-Message-State: AOJu0YzQjD4znfQkDK+nPZ5TNe31RPt2I46T9FCW36PkhbLJozFe7TER
	0Pe30m2Mu9YInwwpMjMg1BJXFAnLPSpF6hnED2OQm4ivnr5hwg==
X-Google-Smtp-Source: AGHT+IHplSmHWesRFB5P6Lfx/hWC52f22Mw48hTkqWT7ZepTEfuYELh4EtN1JGuZI2wGuw8VSuONZw==
X-Received: by 2002:a17:902:c38d:b0:1d3:7788:1c40 with SMTP id g13-20020a170902c38d00b001d377881c40mr8522221plg.0.1705243091553;
        Sun, 14 Jan 2024 06:38:11 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d3-20020a17090b004300b0028ceeca04a1sm8026694pjt.19.2024.01.14.06.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 06:38:10 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-block@vger.kernel.org
In-Reply-To: <bf257b1078475a415cdc3344c6a750842946e367.1705222845.git.christophe.jaillet@wanadoo.fr>
References: <bf257b1078475a415cdc3344c6a750842946e367.1705222845.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] null_blk: Remove usage of the deprecated
 ida_simple_xx() API
Message-Id: <170524308977.2428903.15884730102790776317.b4-ty@kernel.dk>
Date: Sun, 14 Jan 2024 07:38:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Sun, 14 Jan 2024 10:00:59 +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> 

Applied, thanks!

[1/1] null_blk: Remove usage of the deprecated ida_simple_xx() API
      commit: 95931a245b44ee04f3359ec432e73614d44d8b38

Best regards,
-- 
Jens Axboe




