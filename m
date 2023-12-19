Return-Path: <linux-kernel+bounces-4522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59006817ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1CAFB22AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1DC137C;
	Tue, 19 Dec 2023 00:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Vw7IAmmr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7BF387;
	Tue, 19 Dec 2023 00:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id AC5A32E5;
	Tue, 19 Dec 2023 00:28:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AC5A32E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1702945693; bh=a0F1KU/c3GJSM1QvgmP6g60KFqrrB2L92VtyVaFu2AE=;
	h=From:To:Cc:Subject:Date:From;
	b=Vw7IAmmrc6vAXS/pqzU68bdEHzA1Wq4Cy1DJTXVUvvkpZzZ4xF2RUzYnQZaDkrvf/
	 5VLQKzI40rtpt2xsp3acV6laGL87KeduAMWnp4/nH/J090kmgoRTyOxkDuLoJ2sjqK
	 fRKfclNyDMaMbU4ADh0O85kd9kBtl/0DfpVN9E24F5e18BmNkNj6Qzr3XQflUyQTcL
	 0tYLdTU8JCg5kejRbgrV2L/llepW9RGSrmeJ0eCIy6p59A5/zfZBasfCFJnDS5xTye
	 1MvNLs9x4HQgbAkixFfBRyAz0nHIVg8ImZJaXiyrLjzhUHQ/qcEilVzN6n9kVLwms2
	 O3T73zOVc3HUA==
From: Jonathan Corbet <corbet@lwn.net>
To: Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: [PATCH] tipc: Remove some excess struct member documentation
Date: Mon, 18 Dec 2023 17:28:13 -0700
Message-ID: <878r5rjasi.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Remove documentation for nonexistent struct members, addressing these
warnings:

  ./net/tipc/link.c:228: warning: Excess struct member 'media_addr' description in 'tipc_link'
  ./net/tipc/link.c:228: warning: Excess struct member 'timer' description in 'tipc_link'
  ./net/tipc/link.c:228: warning: Excess struct member 'refcnt' description in 'tipc_link'
  ./net/tipc/link.c:228: warning: Excess struct member 'proto_msg' description in 'tipc_link'
  ./net/tipc/link.c:228: warning: Excess struct member 'pmsg' description in 'tipc_link'
  ./net/tipc/link.c:228: warning: Excess struct member 'backlog_limit' description in 'tipc_link'
  ./net/tipc/link.c:228: warning: Excess struct member 'exp_msg_count' description in 'tipc_link'
  ./net/tipc/link.c:228: warning: Excess struct member 'reset_rcv_checkpt' description in 'tipc_link'
  ./net/tipc/link.c:228: warning: Excess struct member 'transmitq' description in 'tipc_link'
  ./net/tipc/link.c:228: warning: Excess struct member 'snt_nxt' description in 'tipc_link'
  ./net/tipc/link.c:228: warning: Excess struct member 'deferred_queue' description in 'tipc_link'
  ./net/tipc/link.c:228: warning: Excess struct member 'unacked_window' description in 'tipc_link'
  ./net/tipc/link.c:228: warning: Excess struct member 'next_out' description in 'tipc_link'
  ./net/tipc/link.c:228: warning: Excess struct member 'long_msg_seq_no' description in 'tipc_link'
  ./net/tipc/link.c:228: warning: Excess struct member 'bc_rcvr' description in 'tipc_link'

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 net/tipc/link.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index d0143823658d..0716eb5c8a31 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -82,10 +82,7 @@ struct tipc_stats {
  * struct tipc_link - TIPC link data structure
  * @addr: network address of link's peer node
  * @name: link name character string
- * @media_addr: media address to use when sending messages over link
- * @timer: link timer
  * @net: pointer to namespace struct
- * @refcnt: reference counter for permanent references (owner node & timer)
  * @peer_session: link session # being used by peer end of link
  * @peer_bearer_id: bearer id used by link's peer endpoint
  * @bearer_id: local bearer id used by link
@@ -94,31 +91,19 @@ struct tipc_stats {
  * @state: current state of link FSM
  * @peer_caps: bitmap describing capabilities of peer node
  * @silent_intv_cnt: # of timer intervals without any reception from peer
- * @proto_msg: template for control messages generated by link
- * @pmsg: convenience pointer to "proto_msg" field
  * @priority: current link priority
  * @net_plane: current link network plane ('A' through 'H')
  * @mon_state: cookie with information needed by link monitor
- * @backlog_limit: backlog queue congestion thresholds (indexed by importance)
- * @exp_msg_count: # of tunnelled messages expected during link changeover
- * @reset_rcv_checkpt: seq # of last acknowledged message at time of link reset
  * @mtu: current maximum packet size for this link
  * @advertised_mtu: advertised own mtu when link is being established
- * @transmitq: queue for sent, non-acked messages
  * @backlogq: queue for messages waiting to be sent
- * @snt_nxt: next sequence number to use for outbound messages
  * @ackers: # of peers that needs to ack each packet before it can be released
  * @acked: # last packet acked by a certain peer. Used for broadcast.
  * @rcv_nxt: next sequence number to expect for inbound messages
- * @deferred_queue: deferred queue saved OOS b'cast message received from node
- * @unacked_window: # of inbound messages rx'd without ack'ing back to peer
  * @inputq: buffer queue for messages to be delivered upwards
  * @namedq: buffer queue for name table messages to be delivered upwards
- * @next_out: ptr to first unsent outbound message in queue
  * @wakeupq: linked list of wakeup msgs waiting for link congestion to abate
- * @long_msg_seq_no: next identifier to use for outbound fragmented messages
  * @reasm_buf: head of partially reassembled inbound message fragments
- * @bc_rcvr: marks that this is a broadcast receiver link
  * @stats: collects statistics regarding link activity
  * @session: session to be used by link
  * @snd_nxt_state: next send seq number
-- 
2.43.0


