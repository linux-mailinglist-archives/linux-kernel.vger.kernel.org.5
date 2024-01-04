Return-Path: <linux-kernel+bounces-16162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0718239F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091F81C24C03
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C00F1847;
	Thu,  4 Jan 2024 00:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZ4BJ3NY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72775221;
	Thu,  4 Jan 2024 00:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CFCC433C9;
	Thu,  4 Jan 2024 00:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704329967;
	bh=HfyO2BBvvpPgvHn99fSkOKBYwTQEs5Bb353iEMV9WsM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=KZ4BJ3NYvW2wdG3ZSaVLkzd7XU10gFIElcXH3P8gLcw+CW7+IKP2SD5mqidXkJQFP
	 Om47CoLgQIae8n0w4YvmlUfIFEIeFDiGtVMG2gA7r8rOJSBGwjZX11lIvzWE0UHN1K
	 VlaSeJPfU/1VW+zDgvvUxd+W9tDPv1drAexhzuGIWh9KWWoHK84Lz+ap4jKurm/gGR
	 MD4aWr68y7lfsG5beLU5m3xTSAYt5JOWb0n46jS9EPoCXQbCvGTiwaAGjquaEO9aWR
	 8ulu8JI/SqMMzpFnoaeIDwiAZlFk3Y95GaBW+LKjEejqvDasT86hU61MY3v4KxD7iN
	 EC8PDQYMM+l8g==
Message-ID: <922a9ea36dc6eb25b32ca5c714beb7b9.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240104100428.1f2c3f6a@canb.auug.org.au>
References: <20240104100428.1f2c3f6a@canb.auug.org.au>
Subject: Re: linux-next: build failure after merge of the clk tree
From: Stephen Boyd <sboyd@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, Sam Shih <sam.shih@mediatek.com>, Stephen Boyd <swboyd@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
To: Mike Turquette <mturquette@baylibre.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 03 Jan 2024 16:59:25 -0800
User-Agent: alot/0.10

Quoting Stephen Rothwell (2024-01-03 15:04:28)
> Hi all,
>=20
> After merging the clk tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>=20
> ERROR: modpost: missing MODULE_LICENSE() in drivers/clk/mediatek/clk-mt79=
88-infracfg.o
>=20
> Caused by commit
>=20
>   7589129341ad ("clk: mediatek: add drivers for MT7988 SoC")
>=20
> I have used the clk tree from next-20240103 for today.
>=20

Thanks. I've fixed it up.

