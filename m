Return-Path: <linux-kernel+bounces-118550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4921A88BC82
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D055F1F32545
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE8012E4D;
	Tue, 26 Mar 2024 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZKEDIBPe"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0EBFBFC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441976; cv=none; b=alUUMMbN2zRJDPABN8NT2kAZnTp8OHcbnlGMAvTl/ifua24+SGl5Dt2Tnt0A6NvU0RS8wNxy6zGsmqKk87yLG8oK3aT6DrNT5BMF2VlZEaaqzrrOyxoIh0SpUP37El+VsSiqt+005t9b+ESw+RNtU/zBGPO275nMPlvB1/iJtjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441976; c=relaxed/simple;
	bh=m0DOnNUIL7uNqVz6saMER7ZM2ibzgIW/MgrZTA4gZWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AxSvXpSg1GhkyVh2JDHfsJtvkcwW0YBWZR3Z4ZXs3JC0gnnB+tdxYFVFLK8rZvcvhLU7sLPrI3RAYG2hj/EvQDVa90YIV/K+0jtOf9k5EPc/W8gkdUV8AJNjjRPinjvkAQnKUJrcjxbnFFZiaQ1Zr4Luk5RbDd5bt6TK6qG3uVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZKEDIBPe; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 568201BF208;
	Tue, 26 Mar 2024 08:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711441965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0DOnNUIL7uNqVz6saMER7ZM2ibzgIW/MgrZTA4gZWI=;
	b=ZKEDIBPe3059LDifO3jfRqa+dkAT0jRat+d9rxbUEu1y38yXNydx08uUtIKny7J/ikrxRt
	rbKEYaT+SBHznlmE7TC5rSU8MLVAYg4QU3h2Y0CpWn30mLiswDaAbIJFYxiF9ScldrzzGI
	f38FQrPOzRyR/Os481anE/mgUvc1Bq3SB3UwH2Svui4x2KTn8mk1EZlMvbnMR41kZeo3xg
	UJUA08ckGKCBxfoJ5vQ3nRyJUIpHfoC7IywrYc9hZMzYoKhEWjqkmzonA0xY3bhSRvmxVJ
	OjWEswbpgJmbkMOkivz8y6sC6dkU1ZUqh0UDkL00CkBC0AkJ637NDXRF6z5HVQ==
Date: Tue, 26 Mar 2024 09:32:42 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mikhail Kobuk <m.kobuk@ispras.ru>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, Alexey
 Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH v2 2/2] phy: marvell: a3700-comphy: Fix hardcoded array
 size
Message-ID: <20240326093242.79ee848a@xps-13>
In-Reply-To: <20240325201254.54445-3-m.kobuk@ispras.ru>
References: <20240325201254.54445-1-m.kobuk@ispras.ru>
	<20240325201254.54445-3-m.kobuk@ispras.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Mikhail,

m.kobuk@ispras.ru wrote on Mon, 25 Mar 2024 23:12:50 +0300:

> Replace hardcoded 'gbe_phy_init' array size with defined value.
>=20
> Fixes: 934337080c6c ("phy: marvell: phy-mvebu-a3700-comphy: Add native ke=
rnel implementation")
> Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>

LGTM.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

