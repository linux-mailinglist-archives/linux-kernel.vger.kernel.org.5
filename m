Return-Path: <linux-kernel+bounces-78787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A458618CE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572FF282218
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AB812AAF5;
	Fri, 23 Feb 2024 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IR2YFhgL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78C51292DF;
	Fri, 23 Feb 2024 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707940; cv=none; b=A0Wwlr7so9e5hffEmyDnclNizFDPYiVgeHG9UVvl//b5IR+TcXj2DJF///bEwWQ2E1wLxkIopOAjlaACHvLJ5ZVZDIpRIFsy1WgiDzXn2D6yHWqqQXsl3HvmL8KvIwZ91gk1/CZSNCRAwI4pCnTqz34MW+VGG0ZIgac4pge8I9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707940; c=relaxed/simple;
	bh=johfqZ8/uBnH7uqzkmV6AcXLgah6W50lRu9i7z7bF0E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SgRPlUo3HU00PhW9Uzl3R1+1gbDK14ZGN2cA8wNpiuHZ8QLrsYFiF+45JXA74EG7t/4VBGDMduzx4Dak3cRPDaTV8phGoMLtosfP+4to86D4vTRO0DnNKmtRyDFei+7fhtW2zt6JGRjleToHhE4BTyrR1lLn974HES8AdlUggZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IR2YFhgL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D13C433C7;
	Fri, 23 Feb 2024 17:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708707939;
	bh=johfqZ8/uBnH7uqzkmV6AcXLgah6W50lRu9i7z7bF0E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IR2YFhgLttzGw771mx97cV3koKjdmGLoe8PXtURoC8ocNMzDg2SeGOnE44JQbI/qg
	 qC62s9C4qsnuVrYtv8LKlgznrdUos0aymlZIw6JZQEBHOEWmiWOanHKmXWiuf5Vpr5
	 X6xbtccmiE8mJnwMhWYyI+OTxoep0TKGVTvxixRAGjLQ25vTXxh5oP1VXZkKI6E8Af
	 42TapFVVYiFuzzuGhhSqjzKGQKcan6CusmgKoaB680YWovz/TWMDWF1rkbJ5iQ5ils
	 ohufe5FSgPIJqVViAG/Zi0I8NVFrhsKTWIzmJ89ztnR8azpyt9rHnujB2zVmNPM9Mr
	 de7X9Yecw7u8Q==
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, 
 "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: Lee Jones <lee@kernel.org>, Andreas Kemnade <andreas@kemnade.info>, 
 stable@vger.kernel.org
In-Reply-To: <20240221143021.3542736-1-alexander.sverdlin@siemens.com>
References: <20240221143021.3542736-1-alexander.sverdlin@siemens.com>
Subject: Re: (subset) [PATCH] mfd: twl: select MFD_CORE
Message-Id: <170870793806.1758312.295203260299451071.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 17:05:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Wed, 21 Feb 2024 15:30:18 +0100, A. Sverdlin wrote:
> Fix link error:
> ld.bfd: drivers/mfd/twl-core.o: in function `twl_probe':
> git/drivers/mfd/twl-core.c:846: undefined reference to `devm_mfd_add_devices'
> 
> 

Applied, thanks!

[1/1] mfd: twl: select MFD_CORE
      commit: 3bb36528d46e494987ee5e9682d08318928ae041

--
Lee Jones [李琼斯]


