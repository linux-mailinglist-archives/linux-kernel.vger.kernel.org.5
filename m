Return-Path: <linux-kernel+bounces-49390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FD98469DD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74B71C25A67
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B06417C6E;
	Fri,  2 Feb 2024 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nYYKAISt"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A8E17BA4;
	Fri,  2 Feb 2024 07:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706860555; cv=none; b=Pe/v7OCl4RS/uuTDq4yKjWOSn58t2yMFmlyRzgfTfHCnMCxPbxq15wQWj3Ruf3Xp/AZ67yL2LfY6Vlyds2evLa3a0wt/uG4Ztn58AFpDH4Lb1KHZygfC0zMn8R9OUGqYw0E5JSHle+cgbDMd4vWv85dCQVjVnluzP7wLFx1qj6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706860555; c=relaxed/simple;
	bh=68hL+FZLLcrrCGOYzkanDw/JbY5cOul8cp+uyDfPMTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLS1WlDXJbdSKXIEJ0VBriMJkf5+xPZk4Bc/iW/LJkPs+JTpGFInQE+gs62EtYDV0PCiM1iFopDG2MDCp2NThm/ShesBTl7hrJDzO1gr5+8X8mMwqeJjTUpkK90QouA0r7rhlUUaRKFkSs4Pt9K3q8HzDZFng/9XseQnUriRHjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nYYKAISt; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E5CDD1C0007;
	Fri,  2 Feb 2024 07:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706860549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68hL+FZLLcrrCGOYzkanDw/JbY5cOul8cp+uyDfPMTY=;
	b=nYYKAIStwHLyok/90gVQUFipyrI5YTOPkDuMKsKZ6iZU4RCiPkvWu2iiOmX9O+5I1v1zss
	tbBKziub+xr6Xg6lIMCdA330UzueJNF2KyZfD1DNKcyh3N9SkN+KesMvgETxfb0m5Fdhr2
	Q4ZSRQ/LvGHV6fs4wiNe5HtG6OzJVAKVm2hYcabkrIAd8jTzWdCtclIzjqHcEAOEUn3EYV
	Mtdmr0Gfe9Nb1YdP2ZZW9Vk6BoL5mQExjs0m1n5UKNwqGil2nussRjtsJudP7ekEQgSkwA
	9ICpSqtpNWUUUzgpLyObGH93FcSHrWV4Kuo7mEKiZ2SgMtUk30wxome9qPJedQ==
Date: Fri, 2 Feb 2024 08:55:47 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Bo Liu <liubo03@inspur.com>
Cc: <alex.aring@gmail.com>, <stefan@datenfreihafen.org>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <linux-wpan@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: ieee802154: at86rf230: convert to use maple tree
 register cache
Message-ID: <20240202085547.46c81c96@xps-13>
In-Reply-To: <20240202064512.39259-1-liubo03@inspur.com>
References: <20240202064512.39259-1-liubo03@inspur.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Bo,

liubo03@inspur.com wrote on Fri, 2 Feb 2024 01:45:12 -0500:

> The maple tree register cache is based on a much more modern data structu=
re
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.

What are the real intended benefits? Shall we expect any drawbacks?

> Signed-off-by: Bo Liu <liubo03@inspur.com>

Thanks,
Miqu=C3=A8l

