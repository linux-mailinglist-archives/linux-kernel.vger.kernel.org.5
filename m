Return-Path: <linux-kernel+bounces-124377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453DE89168B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807AB1C22737
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A192452F79;
	Fri, 29 Mar 2024 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BleqpA6Y"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D94C3D69;
	Fri, 29 Mar 2024 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711706941; cv=none; b=qm7d3kn5/KDIrS6RwKSz1TwFAJK0hIdCvQg16cxUcg0Hed8hOnDr6fpp3pb73mmxnUZbPY1fNZnLYD2EmiY2YxISJKbu8/tJRMQ2XGlxzqG9noDiYV3wg7HKGxd8gC9iXAjnUb8c78rbO7XEZJHjYexjYu4pvxGdEjxM/m8no9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711706941; c=relaxed/simple;
	bh=dg0yHYFFg6Qelahf4065Koyo4tP8zYyKc28NhzfXrb4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YxU1XZgOSg0xGSPXhgIfSWsghU0uhyF1DOQT09YTbP/YZXAahUM51NdL7Qkuu9sSv5pf7raV+I8PyBtct1oYL0mQaIWBwL2mIdXGQDycg1LWe2SL93+6j0lOVmwV7SQ8PAZK8MP4qy4ng7sEX6t7SL4FeEX4T9MbnRd8MhDwOQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BleqpA6Y; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JVRE5r2JvlRPMJCBO02lL2KZKo18Jvpo4jhkCWAHS08=;
	t=1711706938; x=1712916538; b=BleqpA6Yojcuetvwxv78+g5fukS/fWVqSbwm/9J4RamoCEw
	Gv2fAzYIkPXnw/tk0Cw7aCMYafScZ/1ZEjGgtPRaDvzwUG7yg3t8/hVlXksD0VvWQY5LnZGKUkuFI
	2R9g95QAvY0RstvDryuSODaQuVVQGO1A1vHK7VKAITn0nmAXiYiRW3+rerE955ZPca2reYeXMgrti
	CDx+wm3dRPYhV2AkmB+5JvLIwTCK00Sf/z6WuaBF+Z98Clic+p2iZ0bZsVClgq28QJzz/5ZVTxCKb
	f7Rar8urK7fQ5LKJtsjlnQKezhrQQe2gNEJe/vngtJ18cBzghIqaEvM7Wbij/V8w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rq9AK-00000002Ww4-27PN;
	Fri, 29 Mar 2024 11:08:52 +0100
Message-ID: <21c0ba406df6bc4cbd54810b3ff343ced5462615.camel@sipsolutions.net>
Subject: Re: [linus:master] [wifi]  310c8387c6: hwsim.autogo_chan_switch.fail
From: Johannes Berg <johannes@sipsolutions.net>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Ilan Peer <ilan.peer@intel.com>, Miriam Rachel Korenblit
 <miriam.rachel.korenblit@intel.com>,  linux-wireless@vger.kernel.org
Date: Fri, 29 Mar 2024 11:08:51 +0100
In-Reply-To: <202403291042.d9211733-oliver.sang@intel.com>
References: <202403291042.d9211733-oliver.sang@intel.com>
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

On Fri, 2024-03-29 at 10:24 +0800, kernel test robot wrote:
>=20
> Hello,
>=20
> kernel test robot noticed "hwsim.autogo_chan_switch.fail" on:
>=20
> commit: 310c8387c63830bc375827242e0f9fa689f82e21 ("wifi: mac80211: clean =
up connection process")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>=20
> [test failed on linus/master 7033999ecd7b8cf9ea59265035a0150961e023ee]
> [test failed on linux-next/master 26074e1be23143b2388cacb36166766c235feb7=
c]
>=20
> in testcase: hwsim
> version: hwsim-x86_64-717e5d7-1_20240320
> with following parameters:
>=20
> 	test: autogo_chan_switch

Does any of that tell you which version of the tests it's using? It
doesn't tell me, and "717e5d7" doesn't seem to be a hostap sha1. I also
didn't find it in the CI archive.

That said, there were test issues raised with recent commits (and
particularly this one), even upstream one of them (eht puncturing 1) is
still failing as far as I know.

johannes

