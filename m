Return-Path: <linux-kernel+bounces-85221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA9E86B271
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3F79B216B1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FFF15B10B;
	Wed, 28 Feb 2024 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TBlzutj3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RWWbvqQ/"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA4973512;
	Wed, 28 Feb 2024 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132084; cv=none; b=TQW89ZslADvwov1np47i1xU193rDBNhqr2hammz2Fj7SfiCRflZBvrfD6KQ8UW1ylxhAj23cq09qliXurFCVZOVtgnt/sxrXomA6vBpTNgAaIZJJPtSmmgyw52ABn8M4TcE/IbPuOAHJUPP+VPzlWkVtiPjbyaNdJP29j6chTJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132084; c=relaxed/simple;
	bh=Y+7/5mhPZBptJeNuYZtHzu66OCEsCfP5b3mZFAVJEho=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=jkrmX/unszqe8TKuC4fQFhTNHytOw6sQZQi3w0yBHEZs2WTCH0GU5cYwyHSPnIbZhaZ2ZId08ueqv6Oo6nAcsMeOx8VKaQv/ueiVa/Q852a47kHIBZeQk0qYbtYvJnyMQBQOI9rbvc1hu5lR02qB4DU4/rOIScLTAasFAcPDoNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TBlzutj3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RWWbvqQ/; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 6DB5E5C049D;
	Wed, 28 Feb 2024 09:54:41 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 28 Feb 2024 09:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709132081; x=1709218481; bh=p2oBXCBPa5
	Te8eYjdkY/VrzwmmeYD1hEdZ5hF+LH8JI=; b=TBlzutj3JSlO5koSP5xw7k+irJ
	0hZavVqjKWnu7v2MYhHuOMiUE3fIFRzqi/rBPpvjGbntcg3uMyPAft+32ddXjmNX
	5zBABph+FZaN1gFRDTXCFJAwRFtoM8/mE7BOsPsdpNeqq6DDyjSbftV8OfFdiB0V
	+d+Aq8TQuSMnlzCje3325683suFGsnegn/tbIEAgQyrUuYnm0Hd3Xce2P4wnaPRp
	+YOjeuvW98qaV6cLgZHG06L1VIeerPOZ5lU1b9cA3ZEK8jAwBrjQKfEJWkqqXHKC
	E05U+vvmDT+ALjvya75BAn9NNId9lbH3kaKw+kI0y8ysAg5+4tSubv2EL/Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709132081; x=1709218481; bh=p2oBXCBPa5Te8eYjdkY/VrzwmmeY
	D1hEdZ5hF+LH8JI=; b=RWWbvqQ/Ne/Biv7H2HA1/RgmZ4nNcBwSykwsBTU2KoKD
	ENkzfIfAoi6RE0EqYAw2132pO/DFf1FuS6lx6B1j0hkxuHwHqnt46HAxJ3m3xnGS
	ALsmHSC8Fjs7je8qJDodeWMDKb3mNL7+pKA1X+3KL5Dzt/3j/OcCPCNU5OhhXbHr
	GbEoo3YWw2CPeGccgjwtHVQgS+aw6y1wRy/FEAHcS2QGhQZ/KXoe0iuao70gL4cx
	1/dKdJjjzHz0C29vhAiFJDFW2ADPC53PHcr6vJXv2jbB198vQhU0H0noSI2ZUDqv
	48Pi6NVQil6gE1OVy18zxChcd/s9sYee0ZsJn+TKvA==
X-ME-Sender: <xms:MUnfZb7jHSrWyVsdUu3ZM3yG53hbGTTR3Gv0pTrxwJ1i-x3q1MJkDQ>
    <xme:MUnfZQ7IdMi_NiixLikw6lfiygDu99L3A_orvyzjLKE1KGJG2tVCvaJH5krmgCzn_
    f0qt5YUbqikCW7-iW8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeejgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:MUnfZScavs01mZ8Cf7658uCEK5eKltpRUhbtWb9JyTxkd1Lhci-KOA>
    <xmx:MUnfZcKYR5hJQLUnXr4xCTf5SLNLrN_tNVVZlv2emQBriYftASweYQ>
    <xmx:MUnfZfIa1nQBXZKdNMaziTKaRCsm4OVK_exJq_cO-GUAf2YGSGhO6g>
    <xmx:MUnfZRyjBj4OCu_Q8XXzsjSr5g-FhUdrSE9p_hKxuQbcE9rr7WSz8Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 20E56B6008D; Wed, 28 Feb 2024 09:54:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-182-gaab6630818-fm-20240222.002-gaab66308
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <debdd4e5-d3f2-4199-a2f7-825e37b212da@app.fastmail.com>
In-Reply-To: 
 <CAA93jw50D5Kqi4=ze4qn1TUswWtmEao9=FBtH=4W_g9CnBf=AA@mail.gmail.com>
References: <20240228140413.1862310-1-arnd@kernel.org>
 <CAA93jw50D5Kqi4=ze4qn1TUswWtmEao9=FBtH=4W_g9CnBf=AA@mail.gmail.com>
Date: Wed, 28 Feb 2024 15:54:19 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dave Taht" <dave.taht@gmail.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Breno Leitao" <leitao@debian.org>,
 "Roger Quadros" <rogerq@kernel.org>,
 "Siddharth Vadapalli" <s-vadapalli@ti.com>,
 "Grygorii Strashko" <grygorii.strashko@ti.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>, Netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw-qos: fix non-bql configs
Content-Type: text/plain

On Wed, Feb 28, 2024, at 15:44, Dave Taht wrote:
> but why do you want to disable BQL?

I have no idea, I'm just doing randconfig build tests.

I assume Breno has an answer for that, at least he
sent the patch that triggered the regression, see below.

     Arnd

commit ea7f3cfaa58873bbe271577efa800647e30f18bd
Author: Breno Leitao <leitao@debian.org>
Date:   Thu Feb 15 09:05:07 2024 -0800

    net: bql: allow the config to be disabled
    
    It is impossible to disable BQL individually today, since there is no
    prompt for the Kconfig entry, so, the BQL is always enabled if SYSFS is
    enabled.
    
    Create a prompt entry for BQL, so, it could be enabled or disabled at
    build time independently of SYSFS.
    
    Signed-off-by: Breno Leitao <leitao@debian.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/Kconfig b/net/Kconfig
index 4adc47d0c9c2..3e57ccf0da27 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -331,6 +331,7 @@ config NET_RX_BUSY_POLL
 
 config BQL
        bool
+       prompt "Enable Byte Queue Limits"
        depends on SYSFS
        select DQL
        default y

