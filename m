Return-Path: <linux-kernel+bounces-97745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1262B876EB6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 03:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A33628203A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 02:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79902208D0;
	Sat,  9 Mar 2024 02:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMurn1Nq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB72F2374E;
	Sat,  9 Mar 2024 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709950347; cv=none; b=d9LwanoCR0XB0F5bR2K5uBPmfOC6Wof8nMWVZzrfiaErFpS8T/xCZDh39iyZCbriYm27DECB3M5Ic1vQqNwRowp3ItRoFzj9c6dC8b0/qSZRRzmTbbVtSH5zv2+AeUP1ZbldQZb94dqMn6DGgd2olg5rq9UN2AIS1jqT8Wgf+7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709950347; c=relaxed/simple;
	bh=OzgyO4IQYqZO7GHdWY27S+Mv/4FWMjbv/XOkG9jawcM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Yc079fOVDOI+5ZyDnC/5KZLnpfSG3Nfij9l7j0mXxnovgDMk2JEswAiUoqxsFNKI9zNt4CSPn6x8gL4fcTvVsJUgtpVBYmALYKCgQU0Dtty2emZHeUu9EYvUztD58q23ytHM7mGemFxoJsf9ShDHlMnD0/UaGzfJYMXyikvUJxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMurn1Nq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A95BC43390;
	Sat,  9 Mar 2024 02:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709950347;
	bh=OzgyO4IQYqZO7GHdWY27S+Mv/4FWMjbv/XOkG9jawcM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=cMurn1NqjCrTSIhehMUO3u7dFWoSZvSmbqleispdQ4yWxSumJhKpJvZTagnjAmZk5
	 kmZnKNVzf0APG+zz0/VbsLicdkd5dnSiPr+pMaadh/rdTl4R0UViZd7zK0nZnTDZxs
	 kc/SqlHJKsDAereJ0Jqv2acSPOFfW/IXsgkty3fztWQt73qToL7rVYcKEnelQoh36+
	 ACbcKmYKRffbYssbhBi5+03nNJz1zm7EebWFPeM7vFqI6Q08ZKKR5Cqt+pxT2f3daa
	 wZ/0VCQBndf4or0+Lhdjpe0DvsjPLh1FaYz34FHNGNkyf/AKYoOdLRoTVqyE/ubiZ+
	 rqBV+dO47G8Sg==
Message-ID: <274dad1569745dd705cbc65dcb1523db.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <49faf8ff209673e27338d4b83948ade86b3c66e4.1708397315.git.unicorn_wang@outlook.com>
References: <cover.1708397315.git.unicorn_wang@outlook.com> <49faf8ff209673e27338d4b83948ade86b3c66e4.1708397315.git.unicorn_wang@outlook.com>
Subject: Re: [PATCH v11 2/5] dt-bindings: clock: sophgo: add RP gate clocks for SG2042
From: Stephen Boyd <sboyd@kernel.org>
Cc: Chen Wang <unicorn_wang@outlook.com>
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org, devicetree@vger.kernel.org, guoren@kernel.org, haijiao.liu@sophgo.com, inochiama@outlook.com, jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com, richardcochran@gmail.com, robh+dt@kernel.org, samuel.holland@sifive.com, xiaoguang.xing@sophgo.com
Date: Fri, 08 Mar 2024 18:12:25 -0800
User-Agent: alot/0.10

Quoting Chen Wang (2024-02-19 19:08:59)
> From: Chen Wang <unicorn_wang@outlook.com>
>=20
> Add bindings for the gate clocks of RP subsystem for Sophgo SG2042.
>=20
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---

Applied to clk-next

