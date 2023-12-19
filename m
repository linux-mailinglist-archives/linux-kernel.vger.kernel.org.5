Return-Path: <linux-kernel+bounces-4685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C5E818098
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744702825DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91075C98;
	Tue, 19 Dec 2023 04:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U/Qzq7dT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B1F11C88;
	Tue, 19 Dec 2023 04:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=TUfuyA2HikIciWYw2DWYWO3QHNpsWLvhYHuMp80PSzY=; b=U/Qzq7dTOUjuDqjUtTxylXhfM4
	XROpWSUBRP2XyNyOmQFUz7hc8/jrRmAlvsEqARcGxrmQzAAAEMo0S4BhJa2qD8/kT5DoQWadkWP6P
	bjlYuD8RRoVTdxoBZ7992qopBaFuYVva1pLHotOUt3h5roAL6pqWID/opGjGak68jxpZ+UlNlMDKx
	hJrGoeqHNKNZ7NQytTOH1/zEJEyKH/duJHtU3E/EVucv2bH0IPYb+C8GbfL9+oaCOnhkez2NOiFh7
	sS9ViVjq2QRSJ+EBWFM5E5jK3qqCBVa3JIQrZb+A9TjlQ0jigJOpz6hliwwj3fpUCz9mHeTzAOOzZ
	bOL1TrhQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFRn0-00CneJ-0j;
	Tue, 19 Dec 2023 04:33:06 +0000
Message-ID: <d3acd1e8-54fa-4523-95ec-b971d318e003@infradead.org>
Date: Mon, 18 Dec 2023 20:33:05 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tipc: Remove some excess struct member documentation
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, Jon Maloy <jmaloy@redhat.com>,
 Ying Xue <ying.xue@windriver.com>
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
References: <878r5rjasi.fsf@meer.lwn.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <878r5rjasi.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/18/23 16:28, Jonathan Corbet wrote:
> Remove documentation for nonexistent struct members, addressing these
> warnings:
> 
>   ./net/tipc/link.c:228: warning: Excess struct member 'media_addr' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'timer' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'refcnt' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'proto_msg' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'pmsg' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'backlog_limit' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'exp_msg_count' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'reset_rcv_checkpt' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'transmitq' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'snt_nxt' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'deferred_queue' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'unacked_window' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'next_out' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'long_msg_seq_no' description in 'tipc_link'
>   ./net/tipc/link.c:228: warning: Excess struct member 'bc_rcvr' description in 'tipc_link'
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  net/tipc/link.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/net/tipc/link.c b/net/tipc/link.c
> index d0143823658d..0716eb5c8a31 100644
> --- a/net/tipc/link.c
> +++ b/net/tipc/link.c
> @@ -82,10 +82,7 @@ struct tipc_stats {
>   * struct tipc_link - TIPC link data structure
>   * @addr: network address of link's peer node
>   * @name: link name character string
> - * @media_addr: media address to use when sending messages over link
> - * @timer: link timer
>   * @net: pointer to namespace struct
> - * @refcnt: reference counter for permanent references (owner node & timer)
>   * @peer_session: link session # being used by peer end of link
>   * @peer_bearer_id: bearer id used by link's peer endpoint
>   * @bearer_id: local bearer id used by link
> @@ -94,31 +91,19 @@ struct tipc_stats {
>   * @state: current state of link FSM
>   * @peer_caps: bitmap describing capabilities of peer node
>   * @silent_intv_cnt: # of timer intervals without any reception from peer
> - * @proto_msg: template for control messages generated by link
> - * @pmsg: convenience pointer to "proto_msg" field
>   * @priority: current link priority
>   * @net_plane: current link network plane ('A' through 'H')
>   * @mon_state: cookie with information needed by link monitor
> - * @backlog_limit: backlog queue congestion thresholds (indexed by importance)
> - * @exp_msg_count: # of tunnelled messages expected during link changeover
> - * @reset_rcv_checkpt: seq # of last acknowledged message at time of link reset
>   * @mtu: current maximum packet size for this link
>   * @advertised_mtu: advertised own mtu when link is being established
> - * @transmitq: queue for sent, non-acked messages
>   * @backlogq: queue for messages waiting to be sent
> - * @snt_nxt: next sequence number to use for outbound messages
>   * @ackers: # of peers that needs to ack each packet before it can be released
>   * @acked: # last packet acked by a certain peer. Used for broadcast.
>   * @rcv_nxt: next sequence number to expect for inbound messages
> - * @deferred_queue: deferred queue saved OOS b'cast message received from node
> - * @unacked_window: # of inbound messages rx'd without ack'ing back to peer
>   * @inputq: buffer queue for messages to be delivered upwards
>   * @namedq: buffer queue for name table messages to be delivered upwards
> - * @next_out: ptr to first unsent outbound message in queue
>   * @wakeupq: linked list of wakeup msgs waiting for link congestion to abate
> - * @long_msg_seq_no: next identifier to use for outbound fragmented messages
>   * @reasm_buf: head of partially reassembled inbound message fragments
> - * @bc_rcvr: marks that this is a broadcast receiver link
>   * @stats: collects statistics regarding link activity
>   * @session: session to be used by link
>   * @snd_nxt_state: next send seq number

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

