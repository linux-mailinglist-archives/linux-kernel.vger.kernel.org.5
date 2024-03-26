Return-Path: <linux-kernel+bounces-118499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436A588BBD5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F102A6702
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0707E1353E1;
	Tue, 26 Mar 2024 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Nsu/q7hX"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4262A132C15;
	Tue, 26 Mar 2024 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711439925; cv=none; b=YdcUuewWQ+tIC/ctcgbY/3K5Ki6DPtK1mYCFOkG5UNj+SRFgJOnN/CqCcvY5x8UUxpvC+ChIl6yirp3hQbL3TzY4GMh2wnWlB7AlO08MOU3f+ZF+KdVGhm/pyin3wrqwjHniJ6kPN7F2wqKkfZJLzxcSa1IP4TMhY3uiFOroLpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711439925; c=relaxed/simple;
	bh=/9gEICQkPxTh8V8z1+Y8Fr0I4JhmrwJPTKvpFN55dOk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mxWkfakQ+0t3aH3gpZ5qRmzz7JOwDzWN/8E1r95b307RDu6ywV+07M/9AqChcr0rE/idYw+czxiloMLuV34YHTjYGU6tMEszJ4WtUkEbFZMOpu9B4Wr74AZ4icSDCK/HHgtyMoDzhBaN4qoiNJ9mX4+4QExmRqSlUoFyBRwpkeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Nsu/q7hX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=96w4obakqWrnv85p1XrQClv6lIKZ68sh74iV28ewsN4=;
	t=1711439923; x=1712649523; b=Nsu/q7hXVCNTUZ+oRdoKD0ZUKL2JbYprISgbNhEzgA2dBIC
	Zc7P/8JsmFQfn5GEEKtcD7WZxv1t3wuxaWiRtppEEUDBFIcLPm0O96v+ke3ksWbPyRr5fiaHb4y5O
	NwqCHfcddTxxX9X9Fe7No2vPB888bfIdx2HwkY+w3c86WXG86h0xHhq+UC5lM0fv8Pt6hbD1uBkq8
	UHif0tHtglIjLS+Um/Qom2KoxL6gSzTr9eavauImnr71FV16rFs+JwMaEEZ3tGlbJmuc7mSwjJMdR
	Wsg7XWQnLQidDUoI4XZA1iOfeIr2EH8cLPdC5zYaWM3rSpa91el153/eCNvUVOiw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rp1hd-0000000FYWl-0jJE;
	Tue, 26 Mar 2024 08:58:37 +0100
Message-ID: <49041c649349a3b252118f9bb26521e5d47c82b1.camel@sipsolutions.net>
Subject: Re: linux-next: manual merge of the wireless-next tree with the
 wireless tree
From: Johannes Berg <johannes@sipsolutions.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Kalle Valo <kvalo@kernel.org>
Cc: Wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>
Date: Tue, 26 Mar 2024 08:58:36 +0100
In-Reply-To: <20240326100945.765b8caf@canb.auug.org.au>
References: <20240326100945.765b8caf@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi Stephen,

Thanks for the heads-up.

> between commit:
>=20
>   5f4040050553 ("wifi: iwlwifi: mvm: disable MLO for the time being")
>=20
> from the wireless tree and commit:
>=20
>   bbd6d0f8bc51 ("wifi: iwlwifi: mvm: advertise IEEE80211_HW_HANDLES_QUIET=
_CSA")
>=20
> from the wireless-next tree.

I kind of knew this was going to happen (given how the patches applied
or rather didn't), but nothing to prevent it yet. I think we'll get it
fixed in due time,=C2=A0before all the -next stuff goes anywhere.

Thanks,
johannes

