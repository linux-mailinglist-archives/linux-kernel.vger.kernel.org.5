Return-Path: <linux-kernel+bounces-155746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E9C8AF68B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69EE1F25319
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AAC22F17;
	Tue, 23 Apr 2024 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="cG6URue7"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751091AACB;
	Tue, 23 Apr 2024 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897047; cv=none; b=SaBfBCoHSaep/jG6Ka8lr14MrTm23E2JZr+cA2CYNzKk1lyAdC4Ve/rEdfhufcJ7I7tYotsgAc6mlbYkaCMMAYXNz/IWhVhb9tqgufSU+D3E4SEkbuwtcIEGpSs25ia0MLni0VZ3w4YkXA+DMtXegZbfjl33HY9TtW1azmQoTog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897047; c=relaxed/simple;
	bh=RFLVao8VFS9H/vSYh9wVNzB1/kKqDD9w28nPAFPN6MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZNLgr0jwDW3jcAaNob9eZO/+d74XmTo8ubNMWAmBfiLudysEb08fOzhuO8yZ9IU8adJavD8E3Bg5ftx8uPSWOPuRSCKuOgnstg9iSX4rdxuDmDs+joq4MLYdQjQJRbk3hRFUFtM6Kow0Sju4MuVt6fZZQZwmaBpbdgIaBmvKaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=cG6URue7; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 301c8b56d00d4e83; Tue, 23 Apr 2024 20:30:43 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id DCBCB66DB8D;
	Tue, 23 Apr 2024 20:30:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1713897043;
	bh=RFLVao8VFS9H/vSYh9wVNzB1/kKqDD9w28nPAFPN6MA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cG6URue7kEmcSZ8dgkbCjfb7T9PYZWQWtgjmHoobjdDRf57IRPso46UK6u4ckSqlF
	 GdWIy3qBU42X9C9+sOdkM8RRGU/0BVdNAcuZlGjBR8HB2HgSTxXPAYY/6JhyYN8a/Z
	 XV1h6HFw2/K4OENCSUo2cEBX4RferB9V/ljHt5X9tTpV0XlKULZ9dCy+RLzLjux/jR
	 6PIlLQY+MRfOz9eaKSNpH5gUVi08Rjs3rI68LvTbbxWdS7IGuRBeCbj1f5hDrhDofB
	 EgZ0sO9OtQLAb6V7C4TegAfEV1+YLB1S3Qy1jL8y/IcceLcrkmaLosSCwwQDzTb220
	 QrdS1UM4QXFZQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: linux-next: duplicate patch in the pm tree
Date: Tue, 23 Apr 2024 20:30:42 +0200
Message-ID: <12425337.O9o76ZdvQC@kreacher>
In-Reply-To: <20240422081547.7d75d471@canb.auug.org.au>
References: <20240422081547.7d75d471@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeluddguddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepshhfrhestggrnhgsrdgruhhughdrohhrghdrrghupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhgvgihtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

Hi Stephen,

On Monday, April 22, 2024 12:15:47 AM CEST Stephen Rothwell wrote:
> 
> --Sig_/2mWov6L/1T3YTV5TB80hoeT
> Content-Type: text/plain; charset=US-ASCII
> Content-Transfer-Encoding: quoted-printable
> 
> Hi all,
> 
> The following commit is also in Linus Torvalds' tree as a different
> commit (but the same patch):
> 
>   6711564863de ("thermal/debugfs: Add missing count increment to thermal_de=
> bug_tz_trip_up()")
> 
> This is commit
> 
>   b552f63cd437 ("thermal/debugfs: Add missing count increment to thermal_de=
> bug_tz_trip_up()")
> 
> in Linus' tree.

Thanks for the report, this should be fixed now in the PM tree.

Cheers,
Rafael




