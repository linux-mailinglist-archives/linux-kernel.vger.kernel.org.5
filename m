Return-Path: <linux-kernel+bounces-14762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C3D8221DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742E81C22A1E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9240C15AEE;
	Tue,  2 Jan 2024 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="U8YF6nH4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E60B15E90;
	Tue,  2 Jan 2024 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FOkFG3JsQO68vefg2PdTIP5MphkMJlbl6dquQ/8fPr4=; b=U8YF6nH4qKNdYQfs4dkCcZqT2A
	BJAnyDcBFHPYpA9PtnSRnf94RJZLBZ6hNjuf3cToFBMyRfLLemFGVqrCpZUrvk17409lU+2rAmUZl
	x+dEGbN9yOuBI7HQwckj/ZL7K39+U2aO4Y4olW2ioVZibvLkIXPMdGUleRDm+xnV+bIuXPBYFa9Xq
	hgZexS241MTCaPvskDp9rE1yxcYARdGQ3pSFuPOLrzy4uAg5jOQtf9Qie2XXakkKXhct6+dcTSpf0
	uA8hGYEF9MlFzDjQDTnSNUP+4Zftrc/SDdZ4uk8/POCEjVMxKkfNdgP1P2R2ggAvUuqns0CvcRIf3
	u0waflwA==;
Received: from lfbn-idf3-1-20-89.w81-249.abo.wanadoo.fr ([81.249.147.89]:59766 helo=sauron.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1rKkDh-0003nt-BH by authid <merlins.org> with srv_auth_plain; Tue, 02 Jan 2024 11:14:33 -0800
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.96)
	(envelope-from <marc@merlins.org>)
	id 1rKkDf-005z1P-2b;
	Tue, 02 Jan 2024 11:14:31 -0800
Date: Tue, 2 Jan 2024 11:14:31 -0800
From: Marc MERLIN <marc@merlins.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: sof-audio-pci-intel-tgl/soundwire 6.6.8 kernel outputs no sound
 on speakers but works on headphones => missing alsa-ucm-conf
Message-ID: <ZZRgl9HOLHEnSTmR@merlins.org>
References: <20231223234430.GA11359@merlins.org>
 <alpine.DEB.2.22.394.2401021117370.14041@eliteleevi.tm.intel.com>
 <ZZRP8RqT83cE-S5m@merlins.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZRP8RqT83cE-S5m@merlins.org>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-SA-Exim-Connect-IP: 81.249.147.89
X-SA-Exim-Mail-From: marc@merlins.org

On Tue, Jan 02, 2024 at 10:03:29AM -0800, Marc MERLIN wrote:
> First, a big thanks for the quick reply and help.
> For the benefit of archives and the next potential person looking for
> this, my debian system was lacking 
> alsa-ucm-conf
> which for this soundcare is not optional at all. 

For debian users, the other problem is that a lot of firmware is missing
0000:00:1f.3: Direct firmware load for intel/sof-tplg/sof-hda-generic-2ch.tplg failed with error -2
0000:00:1f.3: error: tplg request firmware intel/sof-tplg/sof-hda-generic-2ch.tplg failed err: -2
0000:00:1f.3: you may need to download the firmware from https://github.com/thesofproject/sof-bin/

merlin:~# aptitude search '?broken-reverse-recommends(?installed)' > /tmp/missing
merlin:~# grep firmware /tmp/missing
p  firmware-ath9k-htc - firmware for AR7010 and AR9271 USB wireless adapters
p  fwupd-amd64-signed - Tools to manage UEFI firmware updates (signed)
merlin:~# grep sof /tmp/missing
merlin:~#

This means there are no relevant packages with 'sof' or 'firmware' that
were recommended, and I had to find this:

merlin:~# apt-get install -t unstable firmware-sof-signed

That package was also missing and not suggested by any package is seems,
but it was easier to find thanks to kernel dmesg. That said I had to
look in ubuntu to see what package those files came from as the package
was installed in that test ubuntu image I used and missing from my
debian12

You know this, I'm sure just adding it to the thread for google indexing.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

