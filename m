Return-Path: <linux-kernel+bounces-2857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4600C8162E4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B491F218B5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD2549F86;
	Sun, 17 Dec 2023 22:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SstXXnI3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F5947F5A;
	Sun, 17 Dec 2023 22:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56DFC433C7;
	Sun, 17 Dec 2023 22:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702853294;
	bh=4k/K7LW2vAuBQPFpH+DX281lWsUDNFM+Oh8iKk4HXPo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=SstXXnI3+v2NHVTPFPh/RJ6nqOHBYsHcznDz5gQ0cpCbdDgYUERYwSW5fkine7yit
	 Vq8lgJwYneoawYSgCI+QaD3rRMsEB2RqGI1iqKY/cnAujFDp0YFaF9xECgBaYkIrOM
	 hNkvhmw58xwqRmROm7pqQ2N/XKDyDhY8BL5/7Eok3dHMzdXXowLCWFs47zOMOcrOtk
	 QkVBmVMAgZELKD+awLjO4sMuwUjV6gNjFjBo313RJk8B8r6yb1qUbn9FkbgWBTJkaf
	 z7Oz51zBxcZDFqxOTUv+6N8SGGItrjyydI6smNlmoqQipAttIN9rfAxX9kD/JDJzRg
	 12MpTRzvBusjw==
Message-ID: <6b01be23781bc025f31bf733e366073a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231214-dipper-earshot-72eef3059961@spud>
References: <20231214-dipper-earshot-72eef3059961@spud>
Subject: Re: [PATCH v1] clk: microchip: mpfs-ccc: replace include of asm-generic/errno-base.h
From: Stephen Boyd <sboyd@kernel.org>
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>, Al Viro <viro@zeniv.linux.org.uk>, Daire McNamara <daire.mcnamara@microchip.com>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Date: Sun, 17 Dec 2023 14:48:12 -0800
User-Agent: alot/0.10

Quoting Conor Dooley (2023-12-14 02:59:57)
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> As evidenced by the fact that only 2 other drivers include this header,
> it is not a normal thing to do. Including the regular version of this
> header is far more conventional for drivers.
>=20
> CC: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> --
> CC: Conor Dooley <conor.dooley@microchip.com>
> CC: Daire McNamara <daire.mcnamara@microchip.com>
> CC: Michael Turquette <mturquette@baylibre.com>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: linux-riscv@lists.infradead.org
> CC: linux-clk@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---

Applied to clk-next

