Return-Path: <linux-kernel+bounces-59057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95F784F0A1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB0A1F22077
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C349657C7;
	Fri,  9 Feb 2024 07:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xU9MCXow"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E436657AB;
	Fri,  9 Feb 2024 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707462421; cv=none; b=ER6jbbPlvA2oEQDUa7dYUBT40Up5EGdaf2VmcaXPiH6dafYwmu7cmil0k1nhhsI8fV9e/4xBWpW/Hooix8M1S94jPGclcfvF8i0Cljmx7TYw1rmGNZJWXoiXbcMLSgJuQY4sKllF8DZopuED5QSKwhHFhCnlChgNF4I1/C3xTKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707462421; c=relaxed/simple;
	bh=iyE+8IowZHpUWq55kut4No1c3UML2iBHavqLeO0WYZ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bt6mUM1ChZLJoia4+MFiI6H5ntyyIvn9bkKYLhc+fnHyGEg8HOmNAXOKfWnpUQiszc0WG48+3uu6cAZcYE/4SG9mm37hJ+aOSKtIQdnwnjRZJ1qVib0S6hGke69HlJ/UHiGZEgQEKrBKXTn72uaA7kNYh5nBbZ18kFIXGlGgJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xU9MCXow; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iyE+8IowZHpUWq55kut4No1c3UML2iBHavqLeO0WYZ8=;
	t=1707462420; x=1708672020; b=xU9MCXow8wkd91k5kWKAeTiBcjqCGdGbJ3IN/rEqkw26yDW
	oWxCkp8JHHfihnkZ5o+S815tv7LZE4IDfwJ8pcec/HEEC2VbmDI6gEZx/81CQuAMnhb0uk6JNbXJK
	WyuPmOQi6PKOtseuoh82z1NArakfD3n73w+MK3TzzCCVnll4+gwCDT9ec0CPnGjNVOutUltR3FE+m
	zBgX8FnpgrqW/wxLJicU8Fw1UTan2rfSEunVgfwh2ZHMfPFE7fe4hoqUjQ+hs43ElbisQSc+2PKJx
	HqbMVs0DAveK3ljlbqskp6JWeL+OrI/Zd9xo5gIV7g+Chz2PpcGKMHGSRw+v9ghg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rYKyN-00000000xkK-2UYa;
	Fri, 09 Feb 2024 08:06:55 +0100
Message-ID: <5a549dc1cc586e86206394519fe430236ff9de42.camel@sipsolutions.net>
Subject: Re: linux-next: build warning after merge of the wireless-next tree
From: Johannes Berg <johannes@sipsolutions.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Kalle Valo <kvalo@kernel.org>
Cc: Wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List
	 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
	 <linux-next@vger.kernel.org>
Date: Fri, 09 Feb 2024 08:06:54 +0100
In-Reply-To: <20240209142950.703eca9b@canb.auug.org.au>
References: <20240209142950.703eca9b@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-02-09 at 14:29 +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the wireless-next tree, today's linux-next build (htmldocs)
> produced this warning:
>=20
> include/net/cfg80211.h:1067: warning: expecting prototype for cfg80211_ch=
andef_primary_freq(). Prototype was for cfg80211_chandef_primary() instead
>=20

Strangely enough, I have a deja vu now, as if I'd fixed this before
somewhere. Oh well.

Thanks for the report, now fixed!

johannes

