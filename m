Return-Path: <linux-kernel+bounces-44418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBA48421D2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22FDD1F2D270
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D49465BC9;
	Tue, 30 Jan 2024 10:44:50 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9851562A07;
	Tue, 30 Jan 2024 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611489; cv=none; b=rqTx+9vLY5f2IVOp5g4kFw4TDAl/oUczds44ttorPQuEaIaef2QGjPICBtGlkMvan//lddudd+K+tLgCdzyixVjPQhvNUnx3VOGniHRXInYZ763hbeteJJWaDQw+jWerC76qdwBkvf0Iw0EZfLZG7qfJ9VLxoANPoTQRtwBFsqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611489; c=relaxed/simple;
	bh=TWCilI70G0ZJ8AVfj5RY2XjZjY1InA1IMvi1KPgmJEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1edBP5cPMF+0oEmGHhSetzGY4LjUs6AQZbLgqk+YAUpFdtpjXKmpVY7KFXhTCc76pkiIIpC7gcByPQgtyA8UixN5iWOzIMJY+ytqd1Y7IMc1E2vyMHv1gB402K7aNzerqQpFrxJSIn1bVlz98xE0OjtdwmhQaQZzktksBvf1wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from archbook.speedport.ip ([91.37.179.254]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1McHM2-1quLS40FQ4-00cgZG; Tue, 30 Jan 2024 11:44:28 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: aliceryhl@google.com
Cc: alex.gaynor@gmail.com,
	fraunhofer@valentinobst.de,
	kernel@valentinobst.de,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	wedsonaf@gmail.com
Subject: Re: [PATCH v2 00/12] rust: kernel: documentation improvements
Date: Tue, 30 Jan 2024 11:44:08 +0100
Message-ID: <20240130104408.45153-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130092252.1610582-1-aliceryhl@google.com>
References: <20240130092252.1610582-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TuQY0iUk4qyUTx2siwXQW5auU1X9DoZarLZqaWLEO6AlSvwmYJX
 N90nKkorXCAO8YQbmorubKEZESmT2ZnqJRntC7r4XCGub4BQDv8zCKJ+uJ3p+YU/GaSeZuG
 gQ9k1m5HQTqFyPQLI0uY4l/FAw2qY+K5pZMrPdB+x+A1SyfjwyrbqNqLZQahCtWA76kpI8L
 M2MDuNLoqfkSLZN9Ir/9A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5e+z9YtyKQQ=;KrNyKu8E2Jmm9U0/TXG1ptOaqUu
 uIa+ruCKtmeADKl3FJfdZHSbG3rn3cGTptvekS5XfBxl6gxM4/K1KTfVnFDTphw6StTIc29ss
 bz5KlEP8hs0+Iul6vEYllpRd5dz7aM86SxtEGxkH5d87BrlTbc+eJpUUtfUHhXLNCFz2tbSBt
 PR3EJ2KDi2LIAkbxm/i8rvsnUQ8wXGgB15ASsOavc6m3WoS/27gmPHpxaq+Vo8zGl0eYTUmcn
 Fiey3b1htxoffp3Blb7yq6Di3bZr/pnDR7UHllDMnbSkLGsEBYrjBkgfH29tMDq5uqavW5Red
 WJ/wDH1U7A3tbk3+knEinyKeEhtNyq1A/O/yaNFbprRpq7Ee5NrGU9d8WodQpAl62vEpQAi9R
 tx3bn7FXt7+7n7hufae0xMOsfqQG14EW9mVrtCH/DrWFROr9orzubjaIN9vVEOx5LSp5mJdPK
 PVPEb55vwpr55gVy8GoECiwLKR41QETDIYTDeJs6vcj73+uFEv/uGt82V4qefvSfJK6XKRa2V
 iQFNH26K6MWzAsVVh+6bDzN5NEEcLS5MvyLxf0TTTnIKp0bFM6eNxe67i4tqj3oXG80q+ppGb
 rSSAUty1LO2c/S7BnOfG3GURz7zW/bZW2Vpe5X4kBO+otd7WUKIEbBFJRZ4GMUKRW+b7TMFbN
 tSv+BXkPC/P4KGqCIdGeijsn04qxYeaznXJy4xiv02f0NpNrwM9RBb26krJ/VMD682mfLNUXI
 0Opk2U/8e4X6a8F+QmI3WiIm067jTwSh+WDx3yiDQQT2Zv82/W7+ALr3y/p48hNb5vXXGi5Bd
 74ATawY3y7cC331KzDeuh7us74rV8M98vy5flR4CyQFHlbbSS7j3bBLWpZOlOA5bV1LCkXgAv
 UtTORifDW7oguWg==

> I left one comment [1] on the last patch. With that fixed, you may add:
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
> to all of the patches.

Thanks, I'll fix that, rebase with `rust-next` and send out a v3.

	- Valentin

>
> (I responded on v1 by accident, but it was v2 that I have reviewed.)
>
> [1]: https://lore.kernel.org/rust-for-linux/CAH5fLghSaorRgDDuqNCN-BhQ86ysX96b=nKM_cZAN0_E6Ai04A@mail.gmail.com/

