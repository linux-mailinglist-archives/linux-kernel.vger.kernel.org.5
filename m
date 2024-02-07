Return-Path: <linux-kernel+bounces-56594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A73484CC4B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB102884D5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C658A7E769;
	Wed,  7 Feb 2024 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slFWABO9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC5D77630
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707314496; cv=none; b=lTj5oM+FrXjTjZndDch4Mqi8/vtYtsikoe7prA+dx+Ze2ht/v3zhPDc3lcR5+VP+iVssbKs0P7VBmR0RNy1FkPAN7muBYsNPxZBzHldEtwUtXM88TFH46yvJC+A40FTqz1FloZFbUw/0b4n72vhTJiAwOlpF0HVnLOT/TL2aOYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707314496; c=relaxed/simple;
	bh=DBW93eoiTOGNMTaQDIpoBf6GGb16/dyPd9SHQcXcCiM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DGbw8V0uQycHSmJz8k0iYNNifDU+kYevXgmkInm8p3AcRzQVc7Or98k7NrC+8sGLrS2Wvhx8+NRjB3Fbk58OqH9wBD+2lDXPJhb7APTZyvR3RtlMEL6JgbNqHXzhsowKsO5uuV4S7601MYh6fnVFnzkoUy+i8Ln7BDXw+1FMUa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slFWABO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24DCC433F1;
	Wed,  7 Feb 2024 14:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707314495;
	bh=DBW93eoiTOGNMTaQDIpoBf6GGb16/dyPd9SHQcXcCiM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=slFWABO9qFaXy85EHmRnfvVNbLeVSRQdFtUArjUkxzvnsQWXm9E4oWmzZ9LU+0t8c
	 pIMwdvzEBCsT+I5wdLOCpqmzWd4UDGFfGgS6MA9vuGCMD9cWbtca2IFelDU6HF/3Ao
	 Z6TIv2fn2GzKTEyRuwkk24XIaTeSuwBR9IJLjfUB5FLcJGlfxxJUda4qKkLvrDFuki
	 QG/N5LmAahnQRSHS56YwMz+Tr/0uBJQySP1eFjonUsx75LPAsXhv88ZSeV+KSN6r/e
	 n1/8QRQksbMbdZwhZYtt6uws/1mFcpGB0f4I0bvqk7Z/Jupg67NrRLRB7zeRmFGDCC
	 KId9lB1NV2Shw==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, Thomas Richard <thomas.richard@bootlin.com>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 gregory.clement@bootlin.com, thomas.petazzoni@bootlin.com, 
 theo.lebrun@bootlin.com, u-kumar1@ti.com
In-Reply-To: <20240125171754.773909-1-thomas.richard@bootlin.com>
References: <20240125171754.773909-1-thomas.richard@bootlin.com>
Subject: Re: [PATCH] phy: ti: gmii-sel: add resume support
Message-Id: <170731449338.147119.13043324915980323672.b4-ty@kernel.org>
Date: Wed, 07 Feb 2024 15:01:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 25 Jan 2024 18:17:54 +0100, Thomas Richard wrote:
> The resume callback restores the submode of each PHY.
> 
> It uses the submode stored in struct phy_gmii_sel_phy_priv (variable
> phy_if_mode). The submode was saved by the set_mode PHY operation.
> 
> 

Applied, thanks!

[1/1] phy: ti: gmii-sel: add resume support
      commit: dc7c77bd79ffbd4c2840354a5da4b08781cb1ee8

Best regards,
-- 
~Vinod



