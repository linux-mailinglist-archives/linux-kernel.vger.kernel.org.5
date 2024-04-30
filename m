Return-Path: <linux-kernel+bounces-163176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4508B66CA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CEA21F21949
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C34A645;
	Tue, 30 Apr 2024 00:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="ede8xVRQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UA+jxhrz"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7315336C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714436052; cv=none; b=SAO+8c+oAmgpTkd3Rih0aNHN9YFF6eOiKTK2urPWKAf3PX7jB26v9juxfVsZg8ntsOZXGdLtqSwCJWj6zdfxwuTannUEae92+rOfqs5zikkqVTfNbdJfyuWpi6wRArWuVcUZ9y7c4n049MKIPqW8jrw1+6/E6Mw6SMKWZ5c7xe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714436052; c=relaxed/simple;
	bh=Y6iKUko0hUY2UDpdwvI8T19S468Kf9XO9iLcV5QGGW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IHmRsdSJIfWigJIaKK37xmNACOQcTQNUjZIQdZCNbZfofHAmkNDegzTjt5rq4Pjr+koBewqasJpGLE/n2vWIQg9/Id7Z83tzhqWWtvoVPeFgdpLRlZIk9FLTZu3xgUXUjJED/ujDIQ4XeGF8DmAd/p5Arr4nVIfFMgWttBLTLeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=ede8xVRQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UA+jxhrz; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6C67A180010F;
	Mon, 29 Apr 2024 20:14:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 29 Apr 2024 20:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1714436048; x=1714522448; bh=ujqvnV1Ujb
	rAMhw/pMuGXiQMwMWayFyg1OYX4BtO330=; b=ede8xVRQW1nb3YclMEGbrAx9SW
	EWWbgFdgsBqqRFMyAQPuFf8SMANha5bJ0huRjTmr4L7BJHrv9fTuaVmHc74f+jvD
	Omt1vt3IXqMCDRRvL6bNC7wLmsir4khaR1MJEoNS1VC1uRAHeFRqT3nvGG5nhq2S
	6RJTponqqZXKn/VEPyVWb5ahRUfsZomA3K9NfW/t93GPJqN2gR4GTecacp5JEaOE
	kEMTn8Jt0J/i3cRzA3dtHvaUxod0mNv2lbYPzbVBk1e7vEjvwLCbQvMs5nV+28UX
	cPWna/tOyWUQNCVBRKRmw5dYKYcgUQ/Jxg/TxI5xBcR12lPMJRioRHgdNAig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714436048; x=1714522448; bh=ujqvnV1UjbrAMhw/pMuGXiQMwMWa
	yFyg1OYX4BtO330=; b=UA+jxhrzVLn+brPc/kW0Flb4P19mkOq7wqjbVmYMGwvg
	wiwQAzFoyB6S8/INyxX+3Oc9IbFQgAJTMJHrSXO9b9K/FkzTbPDqc9skWJMVUoOZ
	v3iRIcnPdhNqjEyLzywe5BfroEdTCeBn2q6q62T+YKW5zIuVfpwNjJ3d5ezLXegI
	/OM1smOjsDI3/uOOdsETh0gXdLPw8OL9Ez+gPcj8cVbCohJwhLvw4L36dTqBcLaq
	wzVdz8ky5ItKJ8uHt9mQ+ao56o2Bk5SGj3sl+BkD1SEE4kGcCsCXWqR6waKBumhg
	phCEVTCLn9hVxl/01wh/CZwPlkeKxnwB96918consA==
X-ME-Sender: <xms:zzcwZr4sY5Aq4_Cf-bR3EY4AWXxIeoM4XrZ8pWoIrb7WGfqVlfumUg>
    <xme:zzcwZg7dit-14qLmNNTAy3Y4YtCxAxsAoSJmt0lruUNoLH2-BF9t23B888liP6uJa
    UCYdRWmfkxYkWKUJZ4>
X-ME-Received: <xmr:zzcwZicLA9WT631UvQZnLAEDLH0zr8DeZEW4ERl0wrtRAjV7g61A83a7Ma22PvZRaAR50RXPOGUfK_i3t9vwQHhzt0no4VsNj1apyNvjY65tRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvdeuleffve
    ekudfhteejudffgefhtedtgfeutdfgvdfgueefudehveehveekkeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:zzcwZsI1KM2RG9GJZ7gZ-u5VWsvkFrQA-XHd84VB2aysJ7uQfGOxOQ>
    <xmx:zzcwZvLzhoFVhdbW1qbGCo9iqhz8GTq-SWOd3ayWtnvzfUMYC-_3xQ>
    <xmx:zzcwZlzmn6Wt8xXXm5eaiCLlPsCF41jwY30nOcIq2fLA8yQ2Qh9IbQ>
    <xmx:zzcwZrJOecUz4yY1UtLnS1fUGYdUuEhLtiJ4CAYQ5qA9N4AEjveUIQ>
    <xmx:0DcwZmXNrdClA44xaoSeofdo4oDhp0ffWQYItlY3KOdMXGOzUesiGS6D>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 20:14:06 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] firewire: core/cdev: add tracepoints events for asynchronous phy packet
Date: Tue, 30 Apr 2024 09:14:02 +0900
Message-ID: <20240430001404.734657-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

In IEEE 1394 bus, the type of asynchronous packet without any offset to
node address space is called as phy packet. The destination of packet is
IEEE 1394 phy itself. This type of packet is used for several purposes,
mainly for selfID at the state of bus reset, to force selection of root
node, and to adjust gap count.

This series of changes is to add tracepoints events for this kind of
asynchronous packets.

Takashi Sakamoto (2):
  firewire: core/cdev: add tracepoints events for asynchronous phy
    packet
  firewire: core: add tracepoints event for asynchronous inbound phy
    packet

 drivers/firewire/core-cdev.c        |  7 +++
 drivers/firewire/core-transaction.c |  8 +++
 include/trace/events/firewire.h     | 78 +++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)

-- 
2.43.0


