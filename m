Return-Path: <linux-kernel+bounces-9226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA1381C292
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE15C1C22C4B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FDB1391;
	Fri, 22 Dec 2023 01:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="qpWJAUAn";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="qpWJAUAn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE6AA41
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 01:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id D08EAC01C; Fri, 22 Dec 2023 02:07:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1703207270; bh=4ozmH151xu58IYSuMT/BMJQH629RfyPY+CsrR3SsG2s=;
	h=Date:From:To:Cc:Subject:From;
	b=qpWJAUAn/kfKjL+tKGxlgjWFtAbCKpeJmdHiwCDFbAXQ8e3PZMaOHXkYtXxLbrwKA
	 BH+6FuGhdPGG6mOt0TPflzeouav3j2MMUzP8HuPA99+atmv/5nrPoWxqvW9CyIn+Zd
	 UHtvoa/IGxXQkjb7w8OYpn8cN4D9+KCutuJjrvngPvNm5mgzO54frYMnZIR/Lj/+uH
	 6EfWMKwlcTMgHTPnP81OGxtUR+V/YD/wzObQkfeOn30zvd8nG7q95CXdmgJ2oGxPck
	 U/fY1aUnLgQ+ePJTttgrxzjjcP6kNrDNnTV9WKR2uD3xbiyAesSV9eMMuI1ijiE/YY
	 JqPenbqWqpdiQ==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 9408AC009;
	Fri, 22 Dec 2023 02:07:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1703207270; bh=4ozmH151xu58IYSuMT/BMJQH629RfyPY+CsrR3SsG2s=;
	h=Date:From:To:Cc:Subject:From;
	b=qpWJAUAn/kfKjL+tKGxlgjWFtAbCKpeJmdHiwCDFbAXQ8e3PZMaOHXkYtXxLbrwKA
	 BH+6FuGhdPGG6mOt0TPflzeouav3j2MMUzP8HuPA99+atmv/5nrPoWxqvW9CyIn+Zd
	 UHtvoa/IGxXQkjb7w8OYpn8cN4D9+KCutuJjrvngPvNm5mgzO54frYMnZIR/Lj/+uH
	 6EfWMKwlcTMgHTPnP81OGxtUR+V/YD/wzObQkfeOn30zvd8nG7q95CXdmgJ2oGxPck
	 U/fY1aUnLgQ+ePJTttgrxzjjcP6kNrDNnTV9WKR2uD3xbiyAesSV9eMMuI1ijiE/YY
	 JqPenbqWqpdiQ==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 46d12d02;
	Fri, 22 Dec 2023 01:07:45 +0000 (UTC)
Date: Fri, 22 Dec 2023 10:07:30 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] 9p fixes for 6.7-rc7
Message-ID: <ZYThUpCUMJUMP3Oy@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-6.7-rc7

for you to fetch changes up to ff49bf1867578f23a5ffdd38f927f6e1e16796c4:

  net: 9p: avoid freeing uninit memory in p9pdu_vreadf (2023-12-13 05:44:30 +0900)

----------------------------------------------------------------
Two small fixes scheduled for stable trees

A tracepoint fix that's been reading past the end of messages forever,
but semi-recently also went over the end of the buffer.
And a potential incorrectly freeing garbage in pdu parsing error path

----------------------------------------------------------------
Fedor Pchelkin (1):
      net: 9p: avoid freeing uninit memory in p9pdu_vreadf

JP Kobryn (1):
      9p: prevent read overrun in protocol dump tracepoint

 include/trace/events/9p.h | 11 +++++++----
 net/9p/protocol.c         | 17 +++++++++++++----
 2 files changed, 20 insertions(+), 8 deletions(-)

Cheers,
-- 
Dominique

