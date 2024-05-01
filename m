Return-Path: <linux-kernel+bounces-164988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F668B8617
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E871C21C00
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E1B4D135;
	Wed,  1 May 2024 07:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="cVWV2Xdd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jt/WdK2h"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424154CB4E
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 07:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714548767; cv=none; b=Bds5Ufz9BT+oE1DIccE1giIHmUO+J8g5Ud3axu0pKGJOU7/ZAGBADjT2LCM/DPZGi1bpuQSffIIoqhxDLaJaoMr50/48YxSIfBbiKquXbl6QHak3X0FwX3ykH7pHJoS6rgIEaXA2KhovSd80xMCFdWnULP37hyOpQ87iULfJFh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714548767; c=relaxed/simple;
	bh=EHRFXSlMVVihutZd+NDwkkM7YzI0Pr2uJgEzv29I8LI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VtrfJ00Vl/O9/oG52PrcAJ3UJSk0iPHbFR0s3uL65C0DtbVOP23jC6LfYC5Wl9JgsZ6kuwlhJhKNeApW10/7UcM6zi/tWhX7AMog6NdbzrlvD3kDK811iHbsKCWsDdQOLPhZrAtZ82mgabujtbH9P+heLyiK5WLnxE8fH5KgywI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=cVWV2Xdd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jt/WdK2h; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 261461C000F9;
	Wed,  1 May 2024 03:32:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 01 May 2024 03:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1714548763; x=1714635163; bh=RAFY3cY91T
	SkbsCZhMDbVyQHMlPIpPBZeDAj36rF968=; b=cVWV2XddlXNJH9dqlDA6xe+uTH
	ZydKkzh55eEqCYoxucDK3oSq1AJcW7rroR6ROy8dKpSM9I3Q2LWdIfC04S8+TdOQ
	10OpE385Dq4RTkfPR2GhAyo+eH/oC88fB56/NTz10O0tl8gvrPskvN/AICTUYtEU
	w4+2wUFERDewZ2TeoMxpcOvUO0+5O7Hw77kgXwax/Fqvgc4kqR2PeguCKtM474c1
	yOtyizRsCBEsz4zzExtss5zY6RKfmamjj8FCVNBOM87VZaSsyifx+OG0YJl/ArgX
	J0PlSmMxGi5rlKcLzLokziI1Vt22gxtusRLhZUsIlFRlkEyYY/evRsQbxO1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714548763; x=1714635163; bh=RAFY3cY91TSkbsCZhMDbVyQHMlPI
	pPBZeDAj36rF968=; b=jt/WdK2hOB/4Xyym0f2RnqrUp+mNZ+89xqFqu6/RRE9W
	YWyoKjswTAVGb0j8b9tnAeFDuTbUavvDSbOvZhGPtH0glOCjXi4dRsO0vN5lXPEo
	fw20CWdzY5tiydzi8wXStpsx13eBDRqK9P03U1fquUnpOb0AxRIWpuBROISzV3rQ
	3xF1xKYzfUuBMpKgwfIA1MZYV1GVwalyrwBRY5Jpk1qaEu7A14K0fPWPxnLLSoS0
	5tK3bih3BCzM10+GYnu0L4Ku7LcfH8pBf2lAqRK4C/AAIt9fr8v/6Kc+t9q0NRbG
	rjma0A9XjShEuKJrXHpSo7BEhsD44veMLX+GlLpEfQ==
X-ME-Sender: <xms:G_AxZtil2T0fpzhav4Lh67LWriDUoXeUB29NU1JuNGRAX2aZotwJuw>
    <xme:G_AxZiDJwVvNw8GoIBw_IYUyKvluPxUNijtRIuaJkszGLklyArU7_Wv7tDi_s9G5D
    glBLPa2K8MTmJoYJB8>
X-ME-Received: <xmr:G_AxZtG6FU1E2nEKwf0eqRDBS2r8QVV0HO4R5yFrQCQycJyvsUVHhnx01VcxSd5fYPq1w4tdCq93YPhKl66me-VElRyfcwYPsNzKgjEsWLC1bdI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduhedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvdeuleffve
    ekudfhteejudffgefhtedtgfeutdfgvdfgueefudehveehveekkeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:G_AxZiS9pxO3PSreKaiJM4NCRDJlZFuacYRy7MFyELIu2J4M5ph_mg>
    <xmx:G_AxZqykzeOTyqgTh7eGJIJ6xt3pH9FFU_jEYYqqVTzeHHKVDTgdVw>
    <xmx:G_AxZo5B-Dfx_8HUQ5nlpXj-F9BxP7jCY74Y_gHUZnCG1qGy-XtCLg>
    <xmx:G_AxZvwOH-XN5ixo3PvZ1ReEfH7NMyHa9okNc2JkeSmsAR9exePwuQ>
    <xmx:G_AxZu8K5vgC8ChGtlvPfWIoIFPwbjn_j2yUz3GFFTwhKZ3xi60mlm8U>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 May 2024 03:32:42 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	adamg@pobox.com
Subject: [PATCH 0/5] firewire: core/ohci: add tracepoints events for bus-reset
Date: Wed,  1 May 2024 16:32:33 +0900
Message-ID: <20240501073238.72769-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

IEEE 1394 bus is under bus-reset state when the physical state of bus is
changed; e.g. bus topology change by adding new nodes in the bus. It is
important to handle the state appropriately for the maintenance of bus.

This series of change adds some tracepoints events to trace the events
related to bus-reset. Some kernel log messages are obsoleted and
deleted. It also includes for 1394 OHCI driver so that bus-reset IRQ
event is recorded as much as possible, and obsoletes bus-resets bit
from debug parameter successfully.

Takashi Sakamoto (5):
  firewire: ohci: add bus-reset event for initial set of handled irq
  firewire: ohci: obsolete OHCI_PARAM_DEBUG_BUSRESETS from debug module
    parameter
  firewire: core: add tracepoints events for initiating bus reset
  Revert "firewire: core: option to log bus reset initiation"
  firewire: core: add tracepoint event for handling bus reset

 drivers/firewire/core-card.c        | 13 +++---
 drivers/firewire/core-topology.c    |  3 ++
 drivers/firewire/core-transaction.c |  7 ----
 drivers/firewire/core.h             |  4 --
 drivers/firewire/ohci.c             | 18 +++------
 include/trace/events/firewire.h     | 61 ++++++++++++++++++++++++++++-
 6 files changed, 73 insertions(+), 33 deletions(-)

-- 
2.43.0


