Return-Path: <linux-kernel+bounces-161725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF328B5035
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87674B20D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 04:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B098BE2;
	Mon, 29 Apr 2024 04:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="IYdEDpOa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XWtCMm3X"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451D6372
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714365147; cv=none; b=BIXgbO/UIKq36nW1O+PCjO0DYw2HajDxKueCB9Dyf+iHCqUo5mHPdP4jiDWenheu5HCkxN0xLBZjFkPHyWlNT0Jy6oVMk8yzNk4R7XwHPPhvuWXvBv6RhtQO/qiNIcDyJWyAqaq/MYFwusZ5xO0PWVe88LcnmAAAPJQcFkd8HMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714365147; c=relaxed/simple;
	bh=ox/62EbT5oj8f7xt9MKcSewdgkEtXx/74onEea31BCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nvauZ7zG4WAhaKHS+hQAyblPXwZ6thmoFx9NG1tL4iK4lUf/gu6F5zdhuGLmQNSfn9ug1/OWQNg50NKbN4OQt8iz3UBDiiyvcVw8sRNb/Oa5aeBP5p4755r/4qIVXsVePheokk3KEYPLxFQ+HXEpC5E5HL3ObRrcMb7iuCpL0Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=IYdEDpOa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XWtCMm3X; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 46A831380228;
	Mon, 29 Apr 2024 00:32:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 29 Apr 2024 00:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1714365143; x=1714451543; bh=SOhiZLaSJM
	K3vRwXHVf80avqHnvi4hJiW4QMdFB5tDo=; b=IYdEDpOalzPZbEZWa3eINnTYv8
	vrwutmxYOYrGrhUl8ZRkMmgvTcQKnr5cPPsMCwNXPGq/TN8wXIUk5O/8auutTncO
	A8DiQR4xHgaLVLJs/stCK80DS7KyeCAE913DSg9VvJQuQ9Csj+wZqzxkwzDq4RQ2
	nZD9ZcTQJ2uXLIRX8wksGI8CREOPZkrgwvI/Tv5OcZwdlI8qYxKsIElBLq5WQ2ZH
	vRgx2bngFmk0qBg0wmkcMfoipjEQnnUqgHovp9SBe5yu3AXvB62dL3jJj4eiM2mz
	Iv/61JytAp4uNtrMRcnP/XLYYn/5io2w7cf+59yrZ/3CBc2KIXO14+myRHAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714365143; x=1714451543; bh=SOhiZLaSJMK3vRwXHVf80avqHnvi
	4hJiW4QMdFB5tDo=; b=XWtCMm3XCG3Pi8vbCsp6ih+BY8w+rqdO2u2dHd9BGywE
	NJgUpGETTb6ToJuXEuJwWp+pfD6o3W8ziW1M9YUpWQ8rrcPHz3Ej2OCzlFT/XW87
	z1RH35nTl7zKXel40F6ONWWNe5h9+u1Cc/H69jWhRE6X/U6XsyGL/TrQfCh5VArJ
	LUms+OzzdgXdIvs+Rth7tP6ng4/i11MmXLY8RM88DrQVJiVSm2fuW7UMNWco8LQD
	SPgxy6OS0M0KB2tQOwyuQqHalnp4QXptbGmSsU7z1E1orsRLzZ3eMlrM+fl5fRsp
	DmTU529PNI1yaTS3WTEkpLgElyyB4oTmtOKaIMpuqw==
X-ME-Sender: <xms:1yIvZo4TJMBShdOty7YQF9qWl8wJL3ToH3-AUggp7dH4hTPqWlBKGQ>
    <xme:1yIvZp4DzKtypy3bfqQXFaoVr1YVbTLiLNwQQGeAl3V8jkWfjBvfanJ9eSM0cSr4-
    JB5zIPhpSfNh9NVW-0>
X-ME-Received: <xmr:1yIvZnfWJcI0jvM1F6OIQh3yS0QYkK9Wut3NcnUKEvTnu3kvY1qc6ASO2jdb0RJkNbckLfdAjGlTwX2es_fKjt0-ztuP2B6lUlW_u0tyA4ggIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtledgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeeggfehleehje
    eileehveefkefhtdeffedtfeeghfekffetudevjeegkeevhfdvueenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:1yIvZtKmYtVRBqZY0WQISGaNIQS8sNCVI07p3e1CAp2WG-CJov3ywg>
    <xmx:1yIvZsJ3vZ5CGODP9Aa88Q2ezF-ljH1dVJ3tkh4JuE8gmrMAkaWpYg>
    <xmx:1yIvZuzlAvQbYXM6sBji1Dd3QYNCiOjoFfek3LqA8W9RJ86aRbTczA>
    <xmx:1yIvZgJ_-4_XksZ0KycyF3dmmBwd1Yfw8zhjCPgt9jAOMn_GIjfh6A>
    <xmx:1yIvZjX7oq1zWA8vNxis0y--8L7YmUOSCKrxPBjG00PKnTwvxiUDZpi4>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 00:32:22 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] firewire: add tracepoints events for asynchronous transaction
Date: Mon, 29 Apr 2024 13:32:13 +0900
Message-ID: <20240429043218.609398-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The series of changes in this patchse is to revise the previous RFC:
https://lore.kernel.org/lkml/20240418092303.19725-1-o-takashi@sakamocchi.jp/

In a view of IEEE 1394 bus, the main function of kernel core is to
provide transaction service to the bus. It is helpful to have some
mechanisms to trace any action of the service.

This series of changes adds some tracepoints events for the purpose.
It adds the following tracepoints events via 'firewire' subsystem:

* For outbound transactions (e.g. initiated by user process)
    * async_request_outbound_initiate
    * async_request_outbound_complete
    * async_response_inbound
* For inbound transactions (e.g. initiated by the other nodes in the bus)
    * async_request_inbound
    * async_response_outbound_initiate
    * async_response_outbound_complete

When probing these tracepoints events, the content of 'struct fw_packet'
passed between the core function and 1394 OHCI driver is recorded with
the fields of header and packet data. For example of the outbound
split transaction:

async_request_outbound_initiate: \
    transaction=0xffff955fc6a07b30 generation=5 scode=2 dst_id=0xffc0 \
    tlabel=18 tcode=9 src_id=0xffc1 offset=0xfffff0000984 \
    header={0xffc04990,0xffc1ffff,0xf0000984,0x80002} data={0x81,0x80}
async_request_outbound_complete: \
    transaction=0xffff955fc6a07b30 generation=5 scode=2 status=2 \
    timestamp=0xeabf
async_response_inbound: \
    transaction=0xffff955fc6a07b30 generation=5 scode=2 status=1 \
    timestamp=0xeac2 dst_id=0xffc1 tlabel=18 tcode=11 src_id=0xffc0 \
    rcode=0 header={0xffc149b0,0xffc00000,0x0,0x40002} data={0x81}

Takashi Sakamoto (5):
  firewire: core: add support for Linux kernel tracepoints
  firewire: core: add tracepoints events for asynchronous outbound
    request
  firewire: core: add tracepoints event for asynchronous inbound
    response
  firewire: core: add tracepoint event for asynchronous inbound request
  firewire: core: add tracepoints events for asynchronous outbound
    response

 drivers/firewire/Makefile           |   2 +-
 drivers/firewire/core-trace.c       |   5 +
 drivers/firewire/core-transaction.c |  93 +++++++-----
 include/trace/events/firewire.h     | 211 ++++++++++++++++++++++++++++
 4 files changed, 276 insertions(+), 35 deletions(-)
 create mode 100644 drivers/firewire/core-trace.c
 create mode 100644 include/trace/events/firewire.h

-- 
2.43.0


