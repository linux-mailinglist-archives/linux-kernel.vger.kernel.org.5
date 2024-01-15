Return-Path: <linux-kernel+bounces-26387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D192C82DFED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831351F25A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1766218644;
	Mon, 15 Jan 2024 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XIBbmPRX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FC828F3;
	Mon, 15 Jan 2024 18:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0E3C43390;
	Mon, 15 Jan 2024 18:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705343419;
	bh=WVgobnxkvBv3xa4iN4d2TsnP8kmcHT1Kkc8iq16agyM=;
	h=From:To:Cc:Subject:Date:From;
	b=XIBbmPRXQNyHt3bklH7w0CX5KrsMja8mhGKYjeUVfrb7OvRTEKwMOpKE4S/TmMMSZ
	 NDQm/VPhkpCAp8a2dXxQKQ9g2gVtgpo4IBWdimsIfYS5YZ7QVcxupnonrHuQvXR5ud
	 p3GG4ZLPA0uAebtmHhWyzdn5VuciOCmqlz8sQ80M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.73
Date: Mon, 15 Jan 2024 19:30:15 +0100
Message-ID: <2024011516-congrats-mutilated-2f3c@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.73 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile               |    2 -
 fs/nfsd/nfsctl.c       |    9 +-------
 fs/nfsd/nfsd.h         |    8 -------
 fs/nfsd/nfssvc.c       |   52 +++++++++++++++++++++++++++++++------------------
 fs/smb/client/cifsfs.c |    2 -
 include/net/dst_ops.h  |    2 -
 net/core/dst.c         |    8 +------
 net/ipv6/route.c       |   13 ++++--------
 8 files changed, 46 insertions(+), 50 deletions(-)

Greg Kroah-Hartman (3):
      Revert "nfsd: call nfsd_last_thread() before final nfsd_put()"
      Revert "nfsd: separate nfsd_last_thread() from nfsd_put()"
      Linux 6.1.73

Jon Maxwell (1):
      ipv6: remove max_size check inline with ipv4

Steve French (1):
      cifs: fix flushing folio regression for 6.1 backport


