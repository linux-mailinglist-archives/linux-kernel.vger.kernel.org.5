Return-Path: <linux-kernel+bounces-152083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749D08AB89B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966D91C20A2D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F52463A2;
	Sat, 20 Apr 2024 01:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z18il0Ex"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3B3A32;
	Sat, 20 Apr 2024 01:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713578269; cv=none; b=g7F1uMYSXHFSrix/URb0c0L/xD0NS7Tn5tJJjiA3aOCUUFWZO7z/tOPzvgqAPaD/eodhPtAnCvjosLcwn/P6uSHK4je9a6G/1jahUZKnIs7gn5BurJCFrK3AEqtPiiPp9FAjAXhAeaYpzVBL5io7/p7xuVE1QxKEXiTUnp9QKS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713578269; c=relaxed/simple;
	bh=x4Zxk8c624BjMwyB8jVXsgIdc1kswnsuToKBo3sJyP0=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=CWr6D3ASV8O2oswwdrZIcenZJqyB4p53BLhvgr9hhdaWfMm005em4K5c/Pb3He/t47e8FuvEypjRqVIgW9aJ18t5q2Q6uy3NMZILf1QsORKt8GvzEn+XsxcKti3HDw+FgK2UHM1nhBNtphl66YGFu8OY3vWjKK5D5baPN/nl04Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z18il0Ex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0986C072AA;
	Sat, 20 Apr 2024 01:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713578268;
	bh=x4Zxk8c624BjMwyB8jVXsgIdc1kswnsuToKBo3sJyP0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Z18il0ExCCmCXel0oyDPQbizSCoK9WDtxYJIwyplfCAgwPsKq2EYTZa+s0x4iwOMo
	 Ust42G09gBhAno8YSA3Z3Izs9w3L+VgGIueCkDJ+ZLDmVmEj58HHZW/I29uZ/JE/nK
	 nJkmIVYEDceyx6p1mgGpVTdW95uWXXyfHpfWwwBw+h/Q1HDiC5Ziqfg8Urksgrn5Qy
	 A8GNQ05gPFpxDAwGkBK96dsARvjWpooiUkDjPZXX0d9CKhqJNlH/wP5QaHGEIBmvI3
	 klg2QJNytcpSgrvOLgmOZZsdKWAcAImnMmjvq5ifiP9KPZy6+jkcBGuZA9nTvSYS0F
	 m7+hnYRkw1H2w==
Message-ID: <c52d65eef4bde8d8cde21657470d7aab.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <90b19f2af3077075d4254e01d5ae919c423d067e.1713016457.git.christophe.jaillet@wanadoo.fr>
References: <90b19f2af3077075d4254e01d5ae919c423d067e.1713016457.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] clk: highbank: Remove an unused field in struct hb_clk
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-clk@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Michael Turquette <mturquette@baylibre.com>
Date: Fri, 19 Apr 2024 18:57:46 -0700
User-Agent: alot/0.10

Quoting Christophe JAILLET (2024-04-13 06:54:35)
> In "struct hb_clk", the 'parent_name' field is unused.
>=20
> Remove it.
>=20
> Found with cppcheck, unusedStructMember.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied to clk-next

