Return-Path: <linux-kernel+bounces-139878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4152D8A08CC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3401F27BDA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C3113D631;
	Thu, 11 Apr 2024 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blqZo9iW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56834F5FE;
	Thu, 11 Apr 2024 06:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818213; cv=none; b=Gos4wyeZ0INdrryqiW2N+DyRNKMp7oVwAuCMwaR5T+03YJCl3TlWd1DVItfNcfiaQTbpHHePKCIjdhlArwft1S6HG8dJroggQcurkWrhIvc9GmG9y1Gu6Cr4YQLItOhveSM+DvTJvIppt2BLb2mNuJVj4R4XPGSOfCW3bJbDH1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818213; c=relaxed/simple;
	bh=p5X7+YSGykaoroLDc3Utq5/1Ao3D7BavVji7tMzRmo0=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=VkzilHFKO8lZS45hoiziMdND1wJDWwS866JPmT0GqbSSYporR/RCDXGIJPD2Rn2SQUx8xOwTEGxB+YP4PdEnngmLQlijcbpJb4BgiqSM4iM4eYu2zsYEJQj+vgpUJrHxNKu1/I88qsPeakhs0xKv8JfGncdOhXyUNNvIzbhX9RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blqZo9iW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B29EC433F1;
	Thu, 11 Apr 2024 06:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712818213;
	bh=p5X7+YSGykaoroLDc3Utq5/1Ao3D7BavVji7tMzRmo0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=blqZo9iWReUjpET1lHp0b9kHsBlA8hKUyBSlYe4VSjHLRs87yVZBZl4BIcTx/n8vc
	 NGgW0e8wO6RX6qHiFl1PWHUs3T0VzX1AsnGMswu4k/yY9KlPcQVC/RxQwdFmZ9ns2m
	 CwX0IRp/dp9d0H98HXYf/ikYhPdIbLFQ2cJlpEo11HdF/nPgj8GfPfsQ0bLPns71q7
	 PFIQy+zumfYPizcQFxP4nw/P1wMUOCYSvbafxCfNSlpMzo41DQaUDZFMV2IMRW/h5/
	 kLRSdnqWGM7+PLG7WdZcSMsFkOSzTFR9RT9VCT6n+9wpq5xEa9E+ot0BRoNQoBGqK/
	 svWXR0kCSrz0w==
Message-ID: <7e12d6b1c0066b85e39e9af359f6f573.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240225065234.413687-1-mmyangfl@gmail.com>
References: <20240225065234.413687-1-mmyangfl@gmail.com>
Subject: Re: [PATCH v7 00/13] clk: hisilicon: Migrate devm APIs
From: Stephen Boyd <sboyd@kernel.org>
Cc: Yang Xiwen <forbidden405@outlook.com>, David Yang <mmyangfl@gmail.com>, Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org
To: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org
Date: Wed, 10 Apr 2024 23:50:10 -0700
User-Agent: alot/0.10

Quoting David Yang (2024-02-24 22:52:15)
> Migrate devm APIs for HiSilicon clock drivers and remove redundant codes.
>=20
> This series is a partial improvement of [1]

This doesn't compile on v6.9-rc1. Please rebase and resend.

