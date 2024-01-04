Return-Path: <linux-kernel+bounces-16408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA91E823E07
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C9DEB23464
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DB32031E;
	Thu,  4 Jan 2024 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corelatus.se header.i=@corelatus.se header.b="hfEuH+Ch";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="9bnB67Y/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3EB18C31;
	Thu,  4 Jan 2024 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corelatus.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corelatus.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 5B9343200B8F;
	Thu,  4 Jan 2024 03:58:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 04 Jan 2024 03:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=corelatus.se; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1704358722; x=1704445122; bh=/Z5C3JxfHNpoAjvvAcHhD
	mbyTXDu4B/UNHLYNTCyyOE=; b=hfEuH+ChLsjSk3N51fYhtm5AiDWaWOHk1jhKs
	apM1OTUIwllA0t8K1DLKWosXVCQqhABWW29iNdc5E2c8HxbeZOsYUMkM2adsnmHL
	etzHVzeE9aoUJ3z9zh5N2y/kvCgG70sFJQ5isZr1YOIQEJen9LDuAhF7pqs+Vaf1
	YyV2kTjL3GRM7g54L68pQTVeyTgGLRLD73MhEP1IlrUYA8zWbJuZYgrk39HUecUT
	LHJmR93xqNzI4GhAWO0CVTBYCA43RLnpsWMUaQCGxALoqVEh+dCqHRZ9YMlW7YLc
	kbml8ee3Pwv3T29vUo5HlWXBCUCY4U8BwH5JAdzEZ6sb/G3MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704358722; x=1704445122; bh=/Z5C3JxfHNpoAjvvAcHhDmbyTXDu
	4B/UNHLYNTCyyOE=; b=9bnB67Y/ea3yYp8QD6L1/UTUORth69DAuXyCvZo8Q9pn
	JUNxbWHqv2Z4HIL0kT0FzgHX/n15N+sayRtvOz7E1sfeD4UefR0GXYb0rIAbXeKI
	MoHyoM5IEDfnabehUgdGBTH0k4ycQFeiR/EqqwvqJyV4x5qxVwuErC3OGS2zesjF
	D/+xpk3ZZ7QtIvTFGR9oKn4neCs5Y1KJeLpT6Nltug9tPJCS3WwuQcHOj5L1Wy1h
	foNJvdodfziQQa9xX/kiVJvhu6vWXWGL8Na1oL7ukpnrznT+VfLjHdfqAmJY/DTe
	H6fnHncZaeeGagEAgQsXLBd7ndpT4mJRNnAaRh4J4A==
X-ME-Sender: <xms:QnOWZQ-NGvloWF7aXXi20FoD9qP9bNQLdTZrK_B21iq0cku-u_mbEA>
    <xme:QnOWZYul0z7Np6GHLj5brJhvL2de5YyvOlKXn5K2WrhRLi5Opkn3xN6UZ2tmoYFaF
    rJFHvkHqcUC5HKAYg>
X-ME-Received: <xmr:QnOWZWC2XATOceOOiKbuRywiaghL549WTSHN4bVlu-OzgMkZA0hK77_nxZo3PICiINbD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegiedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomhepvfhhohhmrghsucfnrghnghgvuceothhhohhmrghssegtohhr
    vghlrghtuhhsrdhsvgeqnecuggftrfgrthhtvghrnhepjefgffdvgeekieehheefheekud
    euvdelueeltdefjeekjeegueeugeelkeeijeeknecuffhomhgrihhnpehkvghrnhgvlhdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hthhhomhgrshestghorhgvlhgrthhushdrtghomh
X-ME-Proxy: <xmx:QnOWZQdTt8yPkaTQ6_neK1tPS1ZMejeoMqjbJdN5QgqBzhoCVdhPXQ>
    <xmx:QnOWZVNoXrdVmVNQAketPtuuE5xU-kt8k3g2JXvWv8oS_l48XgnZoQ>
    <xmx:QnOWZamZV4xoFQMBlDjzTSd_H8K-hiFKZIXzaz4_uTGdweO4bIcnxw>
    <xmx:QnOWZYpDc8Xvli5HnImNmUxRHUFaAXJihgAZhDk6eBIZNzPXk-2ghw>
Feedback-ID: ia69946ac:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jan 2024 03:58:42 -0500 (EST)
Received: from thomas by k2.corelatus.se with local (Exim 4.96)
	(envelope-from <thomas@corelatus.com>)
	id 1rLJYl-000Cnh-0e;
	Thu, 04 Jan 2024 09:58:39 +0100
From: Thomas Lange <thomas@corelatus.se>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jthinz@mailbox.tu-berlin.de,
	arnd@arndb.de,
	deepa.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Thomas Lange <thomas@corelatus.se>
Subject: [PATCH RESEND net] net: Implement missing SO_TIMESTAMPING_NEW cmsg support
Date: Thu,  4 Jan 2024 09:57:44 +0100
Message-Id: <20240104085744.49164-1-thomas@corelatus.se>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW") added the new
socket option SO_TIMESTAMPING_NEW. However, it was never implemented in
__sock_cmsg_send thus breaking SO_TIMESTAMPING cmsg for platforms using
SO_TIMESTAMPING_NEW.

Fixes: 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW")
Link: https://lore.kernel.org/netdev/6a7281bf-bc4a-4f75-bb88-7011908ae471@app.fastmail.com/
Signed-off-by: Thomas Lange <thomas@corelatus.se>
---
 net/core/sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index 51d52859e942..d02534c77413 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2813,6 +2813,7 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 		sockc->mark = *(u32 *)CMSG_DATA(cmsg);
 		break;
 	case SO_TIMESTAMPING_OLD:
+	case SO_TIMESTAMPING_NEW:
 		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
 			return -EINVAL;
 
-- 
2.39.2


