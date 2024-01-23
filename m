Return-Path: <linux-kernel+bounces-36044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEC7839AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE63728E188
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01C353AB;
	Tue, 23 Jan 2024 20:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4p8TLuC"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611735392;
	Tue, 23 Jan 2024 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043464; cv=none; b=g6FxYRP2/ax2ad4Dl3jucvuabZtPkuKb3KVQ6Q14ebqoQTt8RVddXKe8d/ALdxSprI4zeOxrN+ehjrn7OqreNaoCmMuxm4Ov39v1sTwsElwgiBYjfqPLkwTgz/9dzGR6LlpjMbeMxOHd2QE2wkHBubNob6xSWO+NObtLlDumgS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043464; c=relaxed/simple;
	bh=LMHI3ZyKjenRYrlE+O2xcbn5Ctiz1JUEBKIqeCuDgSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZY+EtIi9nKBVxh72fiaQnEFp7EFgIL0QVmBDyGPjXwES4hGVk6oIQGc4qniYwVnnGtaXwhbFh+8oG0YZtUGHMKfg2LelBZz6fbgQM560uYy9GCs5GQ+uMQG7Z17PCA9JdHhMmZ1CvFrZbTmbbtAdnmm/ey0OGppAQ4+uMuDfvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4p8TLuC; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-339237092dcso3453625f8f.3;
        Tue, 23 Jan 2024 12:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706043461; x=1706648261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMHI3ZyKjenRYrlE+O2xcbn5Ctiz1JUEBKIqeCuDgSk=;
        b=T4p8TLuCjCiy27AfWxyDPzTgQbabC5J3ilqLHXDkZEWpgpQ4r7j4TKf3/5Z7jyXkYY
         6F0Yfzff6L0GyCrbj+cMEm+QGd4Lgv18cfEhAY8VZkUZ+87Ft9axyfDbNetOaKtvns9i
         Oj8Bz8YVLnRzKSTDPqku96JjD2Oj/IN9xYIXbMuKnEM34DNvnQ/JEyC+u8ZnqJg+XA3r
         xGCPY9gxKMfzr/uh2hJGghddDg15PG/kITQxY6UfA8/D1AOeHTc5Z09xjTOfacitDMhG
         V2ecPB9oDIPD8Hq6gt12mXncnSv98xkPnp64vNQEZnWeeBm9m2RhLCVIAhJyCPEhB4lg
         qniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706043461; x=1706648261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMHI3ZyKjenRYrlE+O2xcbn5Ctiz1JUEBKIqeCuDgSk=;
        b=BMutvzPRF6VeZPJQkFjTwKloagXU5ozPH68nLpCCtTgrpAUPVm/+1O9K1cawQTuoeq
         47rTvuHJacxVYGqYA5eYjawHoesZFkoa1OToMqOZqkSqnOtNlYeRJKE3codrmG4UcWJN
         CccoFNSir158L3rvdtQz6swk9nmSNsMvqJcUYTsUjTq1hSNrhT6I2641oaVWkUp6yd+O
         aWDfzc9zGkATSniO39vtMX44PZyAF6wNFHw5t/mRXJb/31Yle4cIe4Tt8dsk47U31jMu
         RuI8/WWdzZoubZ3A4aZ8i1UakVc8zPjAhhLk6THhsfy/anAwSeibfQ2jSjd6YTWnUjuW
         MN/A==
X-Gm-Message-State: AOJu0YzYLlDX78LoxPZjPWVIu6jIeqt1TtfbqGncfCYazKOGOO1COUYF
	vZvC2gMNNpp3KsHgdqL/zyWNb0UW0shn3PYLS/CQy0JJme05v7n8q8d1AioE
X-Google-Smtp-Source: AGHT+IGyHltPBF01PYc7KGvL0FOhunCwSkDUTKurU5YPs5tT3eu+XinrHNV/4/LQKm1C0hTJ+Jh5Dw==
X-Received: by 2002:adf:e58f:0:b0:337:b56f:caf0 with SMTP id l15-20020adfe58f000000b00337b56fcaf0mr3889646wrm.47.1706043460423;
        Tue, 23 Jan 2024 12:57:40 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-14-70.dynamic.telemach.net. [86.58.14.70])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d4cc2000000b003392d3dcf60sm7986180wrt.88.2024.01.23.12.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:57:40 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 linux-clk@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] clk: sunxi: usb: fix kernel-doc warnings
Date: Tue, 23 Jan 2024 21:57:39 +0100
Message-ID: <5906747.MhkbZ0Pkbq@jernej-laptop>
In-Reply-To: <20240121051858.17647-1-rdunlap@infradead.org>
References: <20240121051858.17647-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Dne nedelja, 21. januar 2024 ob 06:18:57 CET je Randy Dunlap napisal(a):
> Move the function description comment to immediately above the
> function implementation, the add function parameter descriptions to
> prevent kernel-doc warnings:
>=20
> clk-usb.c:80: warning: expecting prototype for sunxi_usb_clk_setup(). Pro=
totype was for SUNXI_USB_MAX_SIZE() instead
> clk-usb.c:91: warning: Function parameter or struct member 'node' not des=
cribed in 'sunxi_usb_clk_setup'
> clk-usb.c:91: warning: Function parameter or struct member 'data' not des=
cribed in 'sunxi_usb_clk_setup'
> clk-usb.c:91: warning: Function parameter or struct member 'lock' not des=
cribed in 'sunxi_usb_clk_setup'
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Emilio L=F3pez <emilio@elopez.com.ar>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-sunxi@lists.linux.dev

Merged, thanks!

Best regards,
Jernej



