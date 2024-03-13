Return-Path: <linux-kernel+bounces-102286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E95287B033
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636C528C0A8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8A0131E41;
	Wed, 13 Mar 2024 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bulatov.me header.i=@bulatov.me header.b="RU3pp7G9"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265BD5339D;
	Wed, 13 Mar 2024 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351625; cv=none; b=BfqOO75JgKnArnLMLXx3pOBbCrGQatcZqWK2FKyoZloaPv18y6puooOWpBKFDldETPmfwu/Br6Rlsd9HVi1g9ZuuFcaoC38lEQHX/ohnuhXxu6Cy8pFCAk7z8zCzyULttxucQ0uLW7Lz+r2u39+WGSE8+feaDOPZAjtZHUBeDVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351625; c=relaxed/simple;
	bh=SHNsFKcCjctU1oTQ2mrNyrwS3y3J6rO1/xV8aRmrQC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9Cmt48HSg5nAr7Lxr8XUYxpznXf7uFQDMwei3nevBwbsZ9HekepRWlrT3GUtSiW0PRiQv/RCRPP8CMQq8wcvh70RPHqVjNGDDyA8AajcmoOlwgQFQFRqDBbz6EpQi7EwECZ9EM9TcONqgQWy5u1cFtHrTpwXIZldi9pui2pbKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bulatov.me; spf=pass smtp.mailfrom=bulatov.me; dkim=pass (2048-bit key) header.d=bulatov.me header.i=@bulatov.me header.b=RU3pp7G9; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bulatov.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bulatov.me
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4TvyTH4KGdz9t90;
	Wed, 13 Mar 2024 18:40:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bulatov.me; s=MBO0001;
	t=1710351619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kiU9ZS2IFj0jAOjFbYcHToCkrWqaZyIxflp0svWWa7c=;
	b=RU3pp7G9GRS5GhwWDm7jamZALtbJdawmrR5UZSFtgdQyZImf9ep9v4ah6vlXmAI7/jNXJG
	ZT+Y5XWdb8ptYbLCdov9aWbTNjtLWvJ6g1P+VGWrRCd2jlTLTJc+oWNb89zVh5wH/kt8ZR
	4AZVuhOUp8my9byOkRbAYq80Ab5WTE9UCLO1qrcaoYAYWmJ4njIpi3OWFv5pz4gdj2LktX
	HEBFENIer+eRkaWrrMc+LLsRUb0xRJW6R/ZBbbQ59PvFJ/D6yoI8FNYVENKJRQT6x1ogb9
	PmhEHOBrVZ9Hiopccb/dOs+1/L1YfN/39Cb1iiL14v8AnJ6U11U4MuIeozuOaQ==
Date: Wed, 13 Mar 2024 18:40:15 +0100
From: Oleg Bulatov <oleg@bulatov.me>
To: legion@kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, kbd@lists.linux.dev, 
	linux-api@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 2/2] VT: Allow to get max font width and height
Message-ID: <c3wrf2h7h45h2vee7gc42zmy43rsh7niueknvsrlsibnae4pdw@4u6b4qulfe6r>
References: <cover.1708960303.git.legion@kernel.org>
 <cover.1710252966.git.legion@kernel.org>
 <78fcb9ad77b88edee8768806ce6a4d23f6d33118.1710252966.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78fcb9ad77b88edee8768806ce6a4d23f6d33118.1710252966.git.legion@kernel.org>
X-Rspamd-Queue-Id: 4TvyTH4KGdz9t90

On Tue, Mar 12, 2024 at 03:23:58PM +0100, legion@kernel.org wrote:
>  drivers/video/console/newport_con.c | 21 +++++++++++++++++----
>  drivers/video/console/sticon.c      | 25 +++++++++++++++++++++++--
>  drivers/video/console/vgacon.c      | 21 ++++++++++++++++++++-
>  drivers/video/fbdev/core/fbcon.c    | 22 +++++++++++++++++++++-
>  4 files changed, 81 insertions(+), 8 deletions(-)

newport_con.c is an interesting one, apparently it's for SGI Indy and
Indigo2, both are discontinued in 1997. Do we still have a way to test
this driver?

Oleg

