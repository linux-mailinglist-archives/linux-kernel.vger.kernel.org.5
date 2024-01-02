Return-Path: <linux-kernel+bounces-14850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F6182232C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D061F227D3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B89171A5;
	Tue,  2 Jan 2024 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corelatus.se header.i=@corelatus.se header.b="hDl49Nbd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="faazUGM3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151E8168AF;
	Tue,  2 Jan 2024 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corelatus.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corelatus.se
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id E4BEF5C04D0;
	Tue,  2 Jan 2024 16:13:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 02 Jan 2024 16:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=corelatus.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1704230033; x=1704316433; bh=/Z
	5C3JxfHNpoAjvvAcHhDmbyTXDu4B/UNHLYNTCyyOE=; b=hDl49Nbd/OzY8EIQVu
	ONP1QvA/NC2ZCgHHRSQKI2cy4CdYQcYkvncWPOwsrOVbef9mnMaJ1AixNAwoVyEH
	m8FOkWH2axI/Zy5W/wHj+nuqTrM3O9MbRdxOEjRBzDkHN8pSFIc0Colo+wtQwTTJ
	Jd0c/uHinTSzdnn/mRxHvaaeQbRbVowIHupNe2wOzoIWXYcDKzgFK59K+t3VBQdP
	WXp/lquDmLEhf2ZtHgxIF+E6ugPk6mVt2yA8bsMv++v8JNBCDZ0h2xo3X1CL7Zxe
	OE50N7LCoPWJcKCsdK9bu2MhPsWlJxlgIY5ffcC9mcSVSd9B4QsFj4T3gfQByn7k
	xJqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1704230033; x=1704316433; bh=/Z5C3JxfHNpoA
	jvvAcHhDmbyTXDu4B/UNHLYNTCyyOE=; b=faazUGM3y1V24Od/hOTQgt+sO92Jj
	XiyFoVrt7zFfvyN8aYjaqxX29gZzGIo3XOoauCSYsJa2lh3Huu6eALjH6KtnIcGW
	i+ECVqw96mHXuuoZHbleSTUzUdiUe/1I/sRIEdfK1VQpqADQNLsNzAEVphIPSmwj
	whvrhDztR+VS+YA4npiFUT8xU+NB+zvajF2narq5WtuoPJIIFCAR++KZlEL/xzSJ
	xFPlS53QMMiieX4Agu6S8JVJ07pFoUSSsc+1OktHtaBiYZLDr6A1dS9DsPSp2USS
	Ek3ILgsdaTVmoQMUzsRBkJfthH6FpW8iTgBqTrfKewRCrZeKCOeD+TOvQ==
X-ME-Sender: <xms:kXyUZZKfszaGVZdPnyxVOU8rZfELIwNJueaexja2Th-WeLd6ageztQ>
    <xme:kXyUZVI5ZqrnnbBOxZH52eySj-XZ-N0jV5GNL0ifa_LL-vaRWVKGc-2kC-tfgXw15
    fteu7MpB3p8goxT1A>
X-ME-Received: <xmr:kXyUZRts_k8ffx8D4lVKJi3iNETxzWz-PiHDW5oA7n2hUMgLXf3xrM4v9EuFQbk->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegfedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfhufevvfgtgfesthejre
    dttddvjeenucfhrhhomhepvfhhohhmrghsucfnrghnghgvuceothhhohhmrghssegtohhr
    vghlrghtuhhsrdhsvgeqnecuggftrfgrthhtvghrnhepfeeikeffueffiefggfehvdeuff
    dtffevgedvleelhffgjedvtdetkeegtddvveelnecuffhomhgrihhnpehkvghrnhgvlhdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hthhhomhgrshestghorhgvlhgrthhushdrshgv
X-ME-Proxy: <xmx:kXyUZaa1O_zZ1-embXhdOGkDBapxXFXCouOboLHSAu4FJHJ8_lfw6w>
    <xmx:kXyUZQZA669006KxNKAxngP5q-AdLG6sDG8xJAZs9w3xhsaCSd3qeQ>
    <xmx:kXyUZeBCHv1q5yoDbQLjlbfi1iOI5Vd3Q0R3haitw7s-R21MStvjjA>
    <xmx:kXyUZemL4S6U5AXsACJyh1j9mEQyK84rWLIoOpn3g24jEXovq1i6ew>
Feedback-ID: ia69946ac:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jan 2024 16:13:51 -0500 (EST)
Message-ID: <d1ce6aba-1b10-471c-ba60-10effa1dac10@corelatus.se>
Date: Tue, 2 Jan 2024 22:13:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Thomas Lange <thomas@corelatus.se>
Subject: [PATCH net] net: Implement missing SO_TIMESTAMPING_NEW cmsg support
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 jthinz@mailbox.tu-berlin.de, arnd@arndb.de, deepa.kernel@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

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

