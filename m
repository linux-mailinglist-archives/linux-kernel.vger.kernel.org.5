Return-Path: <linux-kernel+bounces-32656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1428835E86
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE7B5B2704D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3C039FE1;
	Mon, 22 Jan 2024 09:46:58 +0000 (UTC)
Received: from abrecht.li (75-128-16-94.static.cable.fcom.ch [94.16.128.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0CA3A264;
	Mon, 22 Jan 2024 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.16.128.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916818; cv=none; b=t7dtp3gxkcU2/LwcnTP/WakENpgkJpEAm9bgGUypQmAmYeO1LNmPEAnlazw+LKJAgKgRnwNmviDsb/lZHJdo4WPaDuuTYHNadGdEoPBOOYqoP6rPj+p2THLsdOfwoRAyDsFPAd4sqPHbP6C4PcQQLMaecleRwefm/V9G1pePoyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916818; c=relaxed/simple;
	bh=nNE+TrGPWGFZ57cqJwRJqwzuf0I8IesCha8kr8iEvXk=;
	h=MIME-Version:Date:From:To:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=f0TZmr78rEacoSwr8TinW4zdqk/iakqonjikCdbyqqTT1XDwbhQEML0BxNWfoPxHnKlBlx48dPazJuMc5ByWGKiJ2XMUqxzN4eUf0wCfv6BRtOlamXu0X9M1Tm767jtRJTNa1AcHJAXfBL6ugQ9KCl3BvGZuYiB0XUp5b9wc/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nodmarc.danielabrecht.ch; spf=pass smtp.mailfrom=nodmarc.danielabrecht.ch; arc=none smtp.client-ip=94.16.128.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nodmarc.danielabrecht.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nodmarc.danielabrecht.ch
DKIM-Filter: OpenDKIM Filter v2.11.0 abrecht.li EB9312752AC3
Received: from toucan.dmz.abrecht.li (unknown [IPv6:fc00:4::a3c:111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by abrecht.li (Postfix) with ESMTPSA id EB9312752AC3;
	Mon, 22 Jan 2024 09:46:52 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Jan 2024 10:46:52 +0100
From: Daniel Abrecht <linux-sound@nodmarc.danielabrecht.ch>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: soc-core.c: Add "Unknown" and "Unknown Product"
 to dmi_blacklist
In-Reply-To: <7d11d0711ad93f2208efb9ab13fe915b@abrecht.li>
References: <7d11d0711ad93f2208efb9ab13fe915b@abrecht.li>
Message-ID: <ea2e1e0c40aa9cbc9d08ec014ae06e90@nodmarc.danielabrecht.ch>
X-Sender: linux-sound@nodmarc.danielabrecht.ch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I think this time it should work. It's surprisingly difficult to get roundcube to not alter plain text messages. Sorry about that.

