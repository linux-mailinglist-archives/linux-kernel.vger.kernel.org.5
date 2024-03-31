Return-Path: <linux-kernel+bounces-126349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4647589356E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 20:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4901F21312
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B8A146D58;
	Sun, 31 Mar 2024 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b="kwUFGgTw"
Received: from mail.wantyapps.xyz (mail.wantyapps.xyz [66.135.5.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A3145B33
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.135.5.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711910044; cv=none; b=X6udhcKZydJq0LJv41ftnRc3Jo+QfuZnKBdQfBGWKsNzBoFsWwARMjmGFGjWlMTQWyMo5c4J+w7LnGfovpFWCdKnnDH2lVd+OROt3B3u1tq4+QO/3WDL81fx+vgXT/py+SQhN8GNyiS0erqMULn2VUrbw1z70qPOB+moyeXLM+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711910044; c=relaxed/simple;
	bh=MEYr4sr56oeu6vXPIa0IsRM09gVoyTOnuitazPXXJnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqlSBJrZSzDPreZ8u8hUsyrRv1Sm9GDiJ80yZFtt4yRYbJvhAf6w/sKkAVRWjnAabOQLtE+hVf0jgO+/NPp6aYDRVII0skX/YKCwYSLd37uSXXpHevLMEQ/cM2nukSxmNCfAEhtVblC5UUzx2Sr3d8K1DmA+ND3/6PhTxtZE0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz; spf=pass smtp.mailfrom=wantyapps.xyz; dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b=kwUFGgTw; arc=none smtp.client-ip=66.135.5.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantyapps.xyz
Received: from multivac (unknown [147.235.194.23])
	by mail.wantyapps.xyz (Postfix) with ESMTPSA id 690D4931F2;
	Sun, 31 Mar 2024 18:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wantyapps.xyz;
	s=mail; t=1711910041;
	bh=MEYr4sr56oeu6vXPIa0IsRM09gVoyTOnuitazPXXJnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kwUFGgTwn3Nh35SeB4uMImVxW9BscBXm/5qSMECuwD9Qslp/lF80VFwY1Vqsmv7W9
	 6j7NEZ2e1tfe/J6KpuQJY0dGOrNrQo0sCq2jmCDtpRpnsIC+CXNQmIGu5RFsGAtW1x
	 19OOswPqK3GYqLC9dfVThUbyV2RTOoj3FdlER6wIaIWX5A0LsjbS4kWbr12zWFevOQ
	 Pdgn1oYJgs7A+Yt+tE5pJbHRsd7OcojlnAJy7B/9vna2hnYpVQmEetegMNyPk0zIyk
	 b7FctbDIjkdYTImNdLvKDvkT6d6cobDvsByHrlg9HfOHI4bRZ7S4jk49OGkJKVQRmK
	 x40PxQhXCR1lQ==
Date: Sun, 31 Mar 2024 21:33:55 +0300
From: Uri Arev <me@wantyapps.xyz>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: christophe.jaillet@wanadoo.fr, frank.li@vivo.com, 
	gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
	luca.ceresoli@bootlin.com, prathubaronia2011@gmail.com, robh@kernel.org, 
	skhan@linuxfoundation.org, u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH] staging: axis-fifo: align arguments to open parenthesis
 in axis-fifo.c
Message-ID: <qnljnwccqvqzilxuoat2s6md2zwcuhfruzbpepxebk65k34t3g@cyl67lk5lsoe>
References: <z2ewk44rjutv24i6lqau3adrmlprj524ulqtqbncvfaj44dwcg@2dnnbm75abbp>
 <72dc90fb-79ef-4dd4-b30e-97b1e7058156@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72dc90fb-79ef-4dd4-b30e-97b1e7058156@gmail.com>

> Oh, that's too bad. Thanks for the heads up!
No worries, I wouldn't mind it if your patch got accepted and not mine
:p
I just don't think they accept patches to axis-fifo anymore, especially
not basic syntax and checkpatch patches which are not as important as
actual bug-fixes.

                 Uri Arev

