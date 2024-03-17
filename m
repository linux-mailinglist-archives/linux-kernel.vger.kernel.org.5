Return-Path: <linux-kernel+bounces-105343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE2987DC7B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 08:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204BF1C21065
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 07:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C828ADF4D;
	Sun, 17 Mar 2024 07:20:25 +0000 (UTC)
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93306CA78
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 07:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710660025; cv=none; b=LqdNhmg+5h0Zw3j3DLURvFXgePXH8J+zie1u13veGjkVN5yQfXmR7KDqrWL/wlmFwLGyR2OkozQ0/YzUUhm9mzL7xC5y6l17IJLTOEsunEfe5umX+IzxSrJZneecFTE38Aoek8LAxVmuQGxLTpE4rOyeSWhWG5iqNdRa/PM5PA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710660025; c=relaxed/simple;
	bh=opddDnWb2Z/FSmsz2hfMWwzMRH4rOt1teTswiVCM4ks=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nRNdLo57FFpFNUC6sJAkcs+7uz9qvMnmtbKnnmGB1PIT5XWCWBRyIeUe/mWpcz1/kjeSR060cNsFwW2Y3sVcyH9TKubakys6quxgh/LjjMuTtjL97Yw3yMobRlsCV9OZkzPgtGZh4uAOJV/uf4j/2HOTu57geL2rXKy0+0MrvaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id 47CD12002D7;
	Sun, 17 Mar 2024 07:20:12 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id 11776A006A; Sun, 17 Mar 2024 08:19:57 +0100 (CET)
Date: Sun, 17 Mar 2024 08:19:57 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] PCMCIA improvements for 6.9-rc1
Message-ID: <ZfaZnUHu8LcLHGqF@shine.dominikbrodowski.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

a few PCMCIA changes since commit c02197fc9076e7d991c8f6adc11759c5ba52ddc6:

  Merge tag 'powerpc-6.8-3' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2024-02-17 16:59:31 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:/pub/scm/linux/kernel/git/brodo/linux tags/pcmcia-6.9-rc1

for you to fetch changes up to ccae53aa8aa2d902242555638c5de104aab08879:

  pcmcia: cs: make pcmcia_socket_class constant (2024-03-10 09:07:00 +0100)

----------------------------------------------------------------
PCMCIA: improvements for v6.9-rc1

Ricardo B. Marliere updated the PCMCIA intrastructure to make
use the driver core now allowing some structs to be const.

----------------------------------------------------------------
Ricardo B. Marliere (2):
      pcmcia: ds: make pcmcia_bus_type const
      pcmcia: cs: make pcmcia_socket_class constant

 drivers/pcmcia/cs.c          | 2 +-
 drivers/pcmcia/cs_internal.h | 4 ++--
 drivers/pcmcia/ds.c          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)


Thanks,
	Dominik

