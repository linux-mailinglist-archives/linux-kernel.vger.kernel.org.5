Return-Path: <linux-kernel+bounces-119191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B19B088C550
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482801F34808
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC2A13C3E1;
	Tue, 26 Mar 2024 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dm3l7G6E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAEC763E6;
	Tue, 26 Mar 2024 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463934; cv=none; b=hrr+sKA6Dv5etX2McQZQ4EC21VMPpVZDBLWQ6poydK0Wm+WEA0aB/ZAvH882rgD2AU9rtHZ+cn77Nlz0qysXAG4Ort65oTT78wrSH5XuPh5viwHjYkooDapOsosvbyeWKNA1OmTpQG9a/Pr4jfabHGSP0ho3gSBOHHtui8VHZgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463934; c=relaxed/simple;
	bh=gHroWCuJnf1md1YwPUVsD4d9qdV4yVBD8yNFmcL2YKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mdcpqOgEXjG4ZzlFtBJPkymQIYGR+u5KzdO9nYnkCBALx/Dk+IrF0BUZ672v9HGhVaxS/7IBJULwq0StN3Ko2wO4ddBIjCD1+Hn3ihQPEK8f29sx4AS8sPAdUk+is16pXIs2omv9SchYE8Rfb+r0KaCihnXy23baNjT3Yn6dwl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dm3l7G6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1919EC433C7;
	Tue, 26 Mar 2024 14:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711463933;
	bh=gHroWCuJnf1md1YwPUVsD4d9qdV4yVBD8yNFmcL2YKQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Dm3l7G6E8mDC6tvoPT/wB+izw+2N3ZOY2F9KPUAfngDhcSdUtxSCb572pfdHBv0LX
	 2i7NzljIDb57F4M5WXuq4431cCRc9c7eNkwMmp8x/EtafbI59vkm5O4YJlJnQ9CpT9
	 QXIs0usjGPWNJvn/eYrrxp69+/Nd2jRRXZZ1CyvVJkBWdIZRcPEep51pBRgBYxVcBL
	 02x80CUtU5E4RcI/oAmAkwg7FVlN3B7/2CkZccVhZAVPvefirqjHbAm2yqY6BQZ2Jw
	 /strzW7gCnt02yjIgE8P4fzhRIdfmLkqI9zsKLt5xRCKQjvegX3ygs5MGPXmmYfRQv
	 SysaWSi1f540g==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org
Subject: [GIT PULL] tpmdd changes for v6.9-rc2
Date: Tue, 26 Mar 2024 16:38:38 +0200
Message-ID: <20240326143838.15076-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  Merge tag 'gfs2-v6.8-fix' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2024-03-25 10:53:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.9-rc2

for you to fetch changes up to 6999f8229e5998e8286e6a960779b6c202d878da:

  keys: Fix overwrite of key expiration on instantiation (2024-03-26 16:24:53 +0200)

----------------------------------------------------------------
Hi,

This pull request contains just a couple of unintrusive changes for
v6.9.

Note that "keys: update key quotas in key_put()" makes quotas less racy
by updating qnkeys and qnbytes already in key_put(). It is not exactly a
bug fix but does make overall kerrnel behaviour more stable and
consistent. Just adding this because I try to keep follow-up PR's for
kernel releases bug fix only but I think here it makes sense to make an
exception.

BR, Jarkko

----------------------------------------------------------------
Luis Henriques (1):
      keys: update key quotas in key_put()

Silvio Gissi (1):
      keys: Fix overwrite of key expiration on instantiation

 security/keys/gc.c     |  8 --------
 security/keys/key.c    | 35 ++++++++++++++++++++++++-----------
 security/keys/keyctl.c | 11 ++++++-----
 3 files changed, 30 insertions(+), 24 deletions(-)

