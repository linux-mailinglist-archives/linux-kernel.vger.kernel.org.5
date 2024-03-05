Return-Path: <linux-kernel+bounces-92187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7623A871C6A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2F92853F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433B55C8F4;
	Tue,  5 Mar 2024 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="v8CyoauD"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB52E5C8E0;
	Tue,  5 Mar 2024 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635974; cv=none; b=u8lyePg1BNBFeVzXBdL6NL1zugG9cYUnldaxBhixBxHwS1yuwyV6bguCh632oNqQ4TC8FyJbQ4Eh2WEnfu/655+7+Gto+uqZkLNnsE0jqvigvC+sFqDGUJAo5cjBPcNXUeKlSo9VH0YhX6bjd53tk4Jk/ilAjMOX+nAaX+yYDEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635974; c=relaxed/simple;
	bh=w+dzZ9SEn7tNT1Gh8wYoSCpe+IryaeeidHzbyNkP7R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ukzYJ6ukUNjr87hZg3QdhZuauosmX5BLh28z+bLy+kmEdFD8ZWJ+8JQ/Bq98BJ7nWjC9yOtrcJRZbR6LIPGJqMm72RdzXFmicro2PvhOTpNqs9y5oREy/pFbqd2zwBICgOHL65v+gDfgOgeTucscR7HpgpQrkuUESGkXXZp5fiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=v8CyoauD; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 479f57587ba60efd; Tue, 5 Mar 2024 11:52:49 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E84CD66AA16;
	Tue,  5 Mar 2024 11:52:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1709635969;
	bh=w+dzZ9SEn7tNT1Gh8wYoSCpe+IryaeeidHzbyNkP7R8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=v8CyoauDU8ZpynYuaBRbQtMVQY4vxX7UkOSK/3KNruxCLZtSCXy2r82yRb29bkITt
	 l9kqVMPyBAG/qFk7EfczirDfnRL5BtOEDc6KULz/4grnLJ0W1I5atc/GejFHymQ5sC
	 Hkm4RAKzD8DdQS+DbM05dD5lLy5IY636+8ZpfyqHXt1rKE4iNK8k/H9t9nbvuBWYrS
	 1kuYBXF9nJ1O2xkaYJO7TlCZgWu0BEGcHT1m+YHAlNKaQXkzSg4bGAo2Cekh8DSOw/
	 2aF7jtMJOQqkpyqdJTIVM8aq6xY/eoUgFYtXrtlO0SfOfZolEpHrl+fM2zykVToQcD
	 PD+Jq2Mwdk5AA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>,
 Alex Elder <elder@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: linux-next: manual merge of the net-next tree with the pm tree
Date: Tue, 05 Mar 2024 11:52:48 +0100
Message-ID: <4903748.31r3eYUQgx@kreacher>
In-Reply-To: <20240305112641.6248c6fd@canb.auug.org.au>
References: <20240305112641.6248c6fd@canb.auug.org.au>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrheelgddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehsfhhrsegtrghnsgdrrghuuhhgrdhorhhgrdgruhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
 ohepvghluggvrheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

Hi Stephen,

On Tuesday, March 5, 2024 1:26:41 AM CET Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the net-next tree got a conflict in:
> 
>   drivers/net/ipa/ipa_smp2p.c
> 
> between commit:
> 
>   c0ef3df8dbae ("PM: runtime: Simplify pm_runtime_get_if_active() usage")
> 
> from the pm tree and commit:
> 
>   5245f4fd28d1 ("net: ipa: don't save the platform device")
> 
> from the net-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

The conflict resolution looks good to me, thank you!




