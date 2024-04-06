Return-Path: <linux-kernel+bounces-133835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0307A89A97E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 09:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8851C21CDF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 07:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7682C225CF;
	Sat,  6 Apr 2024 07:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpSeMMqt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4AC1C697
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 07:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712387630; cv=none; b=nrUO1cDhqNhaKaxYu8kKjW7ZgFbAmBoau+3bRwuGRcKpditjAZ14OP3mlkY3pPn1mL40pjhTxb8kwbiWz/UGNkw9bTtrwxmm/RWbJfRKP9n+uuoyRPeQbk4NiHxaVGr4HY1l7Tmqkw40U7/h9aFqSo0m66NiLZDFZwaNr8SX1aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712387630; c=relaxed/simple;
	bh=otn09rFwqivh/gePwrdoAAH8dH4n60Cf1yo60ZYoNTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H65qxTm24sVHQ+WWFx20Gy+8/kkO1MKpzKGsNWAdj+IMXvoj+JY9hAlE2eo0HjM2siKvlcMmWSXRR9zA479GvnQTAREeJk4/aZycVfOWlvUUVnHxt9D9PN7OMxt7t9C9Jz7MIqOnKdAmLBysaN69Eboc66SBd1jNo6cYNA/5eQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpSeMMqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C33C433C7;
	Sat,  6 Apr 2024 07:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712387630;
	bh=otn09rFwqivh/gePwrdoAAH8dH4n60Cf1yo60ZYoNTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KpSeMMqtXekcsG94J/slBvoWUl+5dMp2RHKq+hKlf68y0ocrjpg96nnhebCFILdaw
	 NrunEmaNoL0bpTtvBed9gXy11SlitDKfWN5bYC6S7jyADE0tCYKlKyCcrDkstZqhJ9
	 yhC9kKf7axU51TcaRiEwaQxe3O+mAXR+YdZjt0V4xZ0WCeiAZSomYn0kQKpd5xLkvV
	 idaz9bjqnGTz9DytmFiHvYBp1K6MtApeuTC8WUt9HLABYfhpxrqbnmP2VLz5QPyiNP
	 ylQEd5mJKFp+wTmoxmX93BWo995aAmsvS+LzbZSPn8e2jV41+lNG7UYZbJOYX58snS
	 Tb5bLFUvVT65w==
Date: Sat, 6 Apr 2024 12:43:45 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Mikhail Kobuk <m.kobuk@ispras.ru>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH v2 0/2] phy: marvell: a3700-comphy: Minor fixes
Message-ID: <ZhD2KTImtCMnglG_@matsya>
References: <20240325201254.54445-1-m.kobuk@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325201254.54445-1-m.kobuk@ispras.ru>

On 25-03-24, 23:12, Mikhail Kobuk wrote:
> Changes in v2:
> - Replace hardcode and ARRAY_SIZE() with definition
> - Link to v1: https://lore.kernel.org/linux-phy/20240321164734.49273-1-m.kobuk@ispras.ru/

This does not apply for me, pls rebase on phy/fixes

> 
> ---
> Mikhail Kobuk (2):
>   phy: marvell: a3700-comphy: Fix out of bounds read
>   phy: marvell: a3700-comphy: Fix hardcoded array size
> 
>  drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> -- 
> 2.44.0

-- 
~Vinod

