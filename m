Return-Path: <linux-kernel+bounces-3052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1939A81669E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4422829AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06F26FBD;
	Mon, 18 Dec 2023 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQkEXWA1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0342C6FA4;
	Mon, 18 Dec 2023 06:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FF6C433C7;
	Mon, 18 Dec 2023 06:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702881747;
	bh=AwJNM7kjqHQrQoilZccaoFSHjFIYmQS8NoKwlo7QtXM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=IQkEXWA1U7LoCHSMVViOC1Y7lnX+dhVPkpNNmlJyE7+pzCymjxrV7w4XO/FSHh9AZ
	 9lKvVM29VBL+tgeMPyW/IxyXFmDPZP7csPOB/H5kKfTzLEjhQClb7rnsxlomDWeWf6
	 yUuMgoVMb2I7GSdnvzmiR7jdU2NwAz527ugm1Lka/XLt2wwqUkSwLq9xsXzH9CT5oZ
	 QYPMEnTsXNQ9f77K0ELeUB+FnBVKTwzzkFNT9xRWS6KSai4xQASP+dAk6EAV1Li1nf
	 0mjRnvQC4r1D++yISkKRweKSyrjSk7kWIO5/PMAwFFb9HlEfTHf2FTbS0BiiUMDd/8
	 X1i/L736a/6Nw==
Message-ID: <c64e6ff8bf03245106746ae741f7f703.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230731121821.22242-1-mmyangfl@gmail.com>
References: <20230731121821.22242-1-mmyangfl@gmail.com>
Subject: Re: [PATCH v6 00/13] clk: hisilicon: Migrate devm APIs
From: Stephen Boyd <sboyd@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org
To: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org
Date: Sun, 17 Dec 2023 22:42:24 -0800
User-Agent: alot/0.10

Quoting David Yang (2023-07-31 05:18:00)
> Migrate devm APIs for HiSilicon clock drivers and remove redundant codes.
>=20
> This series is a partial improvement of [1]
>=20
> v2: fix test robot error
> v3:
>   * size_t for all these num types
>   * hisi_clk_unregister() change into separate patch
>   * keep relevant header inclusions
>   * split driver files changes into separate patches
>   * explain hisi_clk_register_fn() checkpatch warnings
>   * not fixed: MODULE_LICENSE("GPL v2"), as stated in SPDX-License-Identi=
fier
>   * not fixed: "hisilicon,hip04-clock" un-documented, as none of dts file=
s in
>     arch/ use it, better to ask hisi people why they pushed this driver
> v4:
>   * typo: hisi_clocks_get_nr() should check clks->nr first
>   * unexport hisi_clk_unregister_fn() as no one use them outside
> v5: catch up with remove_new refactoring
> v6: fix compilation error and expand macros

This needs to be resent. Sorry. Use mod_devicetable.h instead of
of_device.h please and fix compilation errors.

