Return-Path: <linux-kernel+bounces-149788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6478A95E2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241B628474F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68D915AD8F;
	Thu, 18 Apr 2024 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="OCOwZLhx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="enHVTZU8"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AAE158868
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432190; cv=none; b=R3JMbU5rXUpwul7IzcMAoCMjyNSl4IWzgIHd6z3cK26ikCVfGxGd5HR8wlufvBNklUxlJ8aMxAUGXLS8gA4oU/r4C08TIaLihoXbAkzNTTzakgYQS28y1LcggSY2DqIljX4Rcv1Kf4KsSKzMW2C1zP7n4hkXBQ3OUMRg8r5keaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432190; c=relaxed/simple;
	bh=Za0pdOUubJ3GArouCFnXQf6FdPJ5xrIZCvnwSJ+M+3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLjkK8DO1Y8jfs7B5+4Ie65qoub6OvhO5i4KYQpDCVMC92iDO6vl9HjXA+daK8bxoDudoc8vKa9+7dRkYe66yVwGwWYvyNPiKp/UzEaCJ0aeGYxruHprWzXE8jvZXQAJ8+IIHF4/i/H2CT+7mumITTN5poswyPk43uvc9fr+/4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=OCOwZLhx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=enHVTZU8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4E0F313800CE;
	Thu, 18 Apr 2024 05:23:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 18 Apr 2024 05:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1713432187; x=1713518587; bh=b5uV8UhRzV
	ktf5c7Ro3Gio5czUP975e887v2Xxyituo=; b=OCOwZLhx5Dx1cIqlG4Dj32G1Um
	Smk0SucGCk78DBvddZXcMV2Fm4Mv/stnFwj2v6PWjGm1Nk6RrmF9hCElgcTMmErj
	uQH937teoa9i3Lgh04n810b/6dlXX0LtznKVMaHxZebdVKKLG1CWkE/O/Bks5YyH
	1dTAFGLBBq+d1XhoYFc8kbPKFNeIO6QTFAJc+qZoNm/bnNMsudpZKfD/804yIAMy
	MSuZFh7TfOj9owsWc2V3XZqoCTRHC30kbaR1QYSOLmA4kQQUdEat7yu7Gcve53Kj
	CqlQyvTt4ZCaCa29F7XeC3yR1TkYJD+I0vTqE5oQIMDdkOKJIpmAJk3F06sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713432187; x=1713518587; bh=b5uV8UhRzVktf5c7Ro3Gio5czUP9
	75e887v2Xxyituo=; b=enHVTZU8c75Uf5DkONAJl1L9MBH1u+xVi3oRL24IUivU
	uYU0EHPcBBGriOxzy2PdoTH48iNle8M7zPv7oberGjljNvyW9onmHGpEypxL3V6D
	dB3NkWzearEPEyOEyO4SS+EAykIJe6X9Lh5Xo24HBoRgSCultXEdpKZYinLgZ5d5
	vbWPx08Wlip9mVdtCGM7fL7a21wDWnh8JRwxbUi56MqceBmAg6k3NrRokuAuG49C
	1VcG9z43TBeGU9USY5ybyCyeTYaJt8nJPHbLbiCfzX6J1zz+oPpLajGriqS1Y6Ar
	jHrlyKzeAgnCgrQb5HDXhTJtqHsx+vs30wmv3tifYw==
X-ME-Sender: <xms:e-YgZuabLTlhFX7e9_S8EdqfudrR6YmANelvLt5y1Vxu6S3oKNY6wQ>
    <xme:e-YgZhYhesaiNMZQuvaTn5Kex6fWXBuY4JKfnewsY2441oXsOD4dpmRC6pvqss082
    rV-lh5Rfo9m_VF8cJQ>
X-ME-Received: <xmr:e-YgZo8yYsf6PU6fL_RZWLIAoCoIrkndaSq1gJAFxExJ1NWsCxrHWSg6P5lNJMOUqID79GlXH8fXUv3FgUcIPLFhpSyJoguvi8LVB7DLC8wW8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvdeuleffve
    ekudfhteejudffgefhtedtgfeutdfgvdfgueefudehveehveekkeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:e-YgZgpt8wA9jDIzJrY8_cnpFkalYu5wekAusk90aLEMMUzroUEguw>
    <xmx:e-YgZpotGIkYE4d7Ge335sRemqEdrg8D7564P7Bsxdi9FZsrquaqbw>
    <xmx:e-YgZuRiIi82SFG8tp5pJ7MxP_SnLmx7VO--hsOE3YvtBdQS9lB3ZA>
    <xmx:e-YgZpqESkvWz5b7XKHvzHlhM8Ozc14iVIDzpOIXAusaJJTr84KJPA>
    <xmx:e-YgZg2UfapCPgrrccKFcue7vQUuWQLgoTWZ6MQns28MZlUwQps_snqT>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 05:23:06 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 00/13] firewire: add tracepoints events for asynchronous communication
Date: Thu, 18 Apr 2024 18:22:50 +0900
Message-ID: <20240418092303.19725-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

In a view of IEEE 1394 bus, the main function of kernel core is to
provide transaction service to the bus. It is helpful to have some
mechanisms to trace any action of the service.

This series of changes adds some tracepoints events for the purpose.
It adds the following tracepoints events via firewire subsystem:

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
transaction:

async_request_outbound_initiate: \
    transaction=0xffffb7e382373718 scode=2 generation=6 dst_id=0xffc0 \
    tlabel=59 retry=1 tcode=1 priority=0 src_id=0xffc1 \
    offset=0xecc000000000 \
    data={0x6000000,0x1000000,0x40000100,0x3000000,0x1000000,0x0}
async_request_outbound_complete: \
    transaction=0xffffb7e382373718 scode=2 generation=6 ack=2 \
    timestamp=0x2296
async_response_inbound: \
    transaction=0xffffb7e382373718 scode=2 timestamp=0x2297 dst_id=0xffc1 \
    tlabel=59 retry=1 tcode=2 priority=0 src_id=0xffc0 rcode=0 data={}

To provide the parsed fields of header, the series adds some helper
incline functions for this purpose, then refactors the existent code in
both core and 1394 OHCI driver with sufficient tests.

Takashi Sakamoto (13):
  firewire: core: add common inline functions to serialize/deserialize
    asynchronous packet header
  firewire: core: replace local macros with common inline functions for
    asynchronous packet header
  firewire: ohci: replace local macros with common inline functions for
    asynchronous packet header
  firewire: ohci: replace hard-coded values with inline functions for
    asynchronous packet header
  firewire: ohci: replace hard-coded values with common macros
  firewire: core: obsolete tcode check macros with inline functions
  firewire: core: add common macro to serialize/deserialize isochronous
    packet header
  firewire: core: replace local macros with common inline functions for
    isochronous packet header
  firewire: core: add support for Linux kernel tracepoints
  firewire: core: add tracepoints events for asynchronous outbound
    request
  firewire: core: add tracepoints event for asynchronous inbound
    response
  firewire: core: add tracepoint event for asynchronous inbound request
  firewire: core: add tracepoints events for asynchronous outbound
    response

 drivers/firewire/.kunitconfig                |   1 +
 drivers/firewire/Kconfig                     |  16 +
 drivers/firewire/Makefile                    |   8 +-
 drivers/firewire/core-transaction.c          | 239 ++++----
 drivers/firewire/core.h                      |  21 +-
 drivers/firewire/ohci.c                      |  78 +--
 drivers/firewire/packet-header-definitions.h | 234 ++++++++
 drivers/firewire/packet-serdes-test.c        | 582 +++++++++++++++++++
 drivers/firewire/trace.c                     |   5 +
 drivers/firewire/trace.h                     | 265 +++++++++
 10 files changed, 1280 insertions(+), 169 deletions(-)
 create mode 100644 drivers/firewire/packet-header-definitions.h
 create mode 100644 drivers/firewire/packet-serdes-test.c
 create mode 100644 drivers/firewire/trace.c
 create mode 100644 drivers/firewire/trace.h

-- 
2.43.0


