Return-Path: <linux-kernel+bounces-108988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED9988130D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 873B5B21EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337E743ADE;
	Wed, 20 Mar 2024 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jcline.org header.i=@jcline.org header.b="vfnEmlvi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tzsDmUAw"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C371D4AEFA;
	Wed, 20 Mar 2024 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710943933; cv=none; b=iQAhNw62xlDiai54LW+8TUGWm6+sPFF8lx0GOF0ssakUfohfhGCj/2Q2TzfbE+gFXyo1vE+lCmqkluBye5AjNX3/0fpzb88IZYLnvB2Wm1v+/Y2m1xfv8LD4oBqzHLvVkgy/4MTNHswEQEPC8+WckeE01E924sWcdaiX8s8VnHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710943933; c=relaxed/simple;
	bh=pIskZTdiijOHyXJ06Sh/ccutKUyXwwsPo+SoFuzkqlc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=SFR1WRVNaGPotCH4upHbcC6SnDVlsuvEHcSGw9KrDtnEyEqfRhPhptGQWfRKejQESI4GhC7zcnkQUVyigWrkAxrhFNQ6oKA0sFMBNJVhDmIjzI6uFtORGGIdzw5e9d+sf63BSjLS9TrM1rUUb4vewXiIHmvFDl3pgPR18tbcrOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jcline.org; spf=pass smtp.mailfrom=jcline.org; dkim=pass (2048-bit key) header.d=jcline.org header.i=@jcline.org header.b=vfnEmlvi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tzsDmUAw; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jcline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jcline.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id BF22F13800C7;
	Wed, 20 Mar 2024 10:12:09 -0400 (EDT)
Received: from imap42 ([10.202.2.92])
  by compute5.internal (MEProxy); Wed, 20 Mar 2024 10:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jcline.org; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710943929; x=1711030329; bh=pIskZTdiij
	OHyXJ06Sh/ccutKUyXwwsPo+SoFuzkqlc=; b=vfnEmlvi3ojRCQ0sPvhEwmBEAd
	8Cf02iIqn2NuIsPB1wN+izTaaRoOBZAoLdD7HQd96NJNncvqZneHp8q7r7oHHtiu
	8BmkK+V40Faok5syEvkd7YZpTTkHVzNekZR18lJqWPvRoYkduoHkFAb6JihhRnWk
	2FQDrXuR7oiFD5ihecoljtwsEhGNeId/3ewFvXGO4eINyGyPTGqS6DPwkYVPISw4
	/u29RsCRdifN+hquSwaVECZiu1jHIpItpg/RMLDb3tRJiIdqfgtSPBXBCR3vrrSH
	UfP3UeEqSScc/IvqItKgtFjTprD0nxtTDBrZKoDFeO0lIlX5deNQ13rxdM5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710943929; x=1711030329; bh=pIskZTdiijOHyXJ06Sh/ccutKUyX
	wwsPo+SoFuzkqlc=; b=tzsDmUAweZdIUmcRXqCGp2IHxwN0gynOAyLci20aME6X
	wzXkIt0NJKOWxbpLVItF4ClgainsJnP1QerAXvBsEYAeVT8aLmKu62H8oiSbQ3Yt
	Um+2jpcbxoKHdIxkSrMPGI50RB/Am+B5Dk18Mw+mguuc50ReVCLqu4M0wgcpbQvO
	y6ESCepo8zIjAx4pKr2GCMEWrX+SMG5K8FoZUcV1WdZzHE8F/YUtQF6wV8VDgLm1
	p6raQGoR+zLbOMGrHMDeB3fkAe7FclSO3+MAKMCoDhZc25HdENdOIrFb9Nong3zf
	KMMDsx1sm4BOlb32O3ApfwC7+JwYXMLJVRKh79LFvQ==
X-ME-Sender: <xms:ue76ZQtyMBBC8ydXvW-SjlzkgkUq_JLMUwM6u9J9vxdkrLvaggD13w>
    <xme:ue76ZdeMMF86nu1GJVI-gUrxp-oI2OISfl5D6xyoo7mdpSh-eDtmcKs_whT5_8cPg
    d4oM5jDEKVJhevEL54>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeggdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdflvghr
    vghmhicuvehlihhnvgdfuceojhgvrhgvmhihsehjtghlihhnvgdrohhrgheqnecuggftrf
    grthhtvghrnhepueevtdfhtdettdetvdegleelvedvheevjeehgfehfeeutdelleeukedv
    gefgieevnecuffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgvrhgv
    mhihsehjtghlihhnvgdrohhrgh
X-ME-Proxy: <xmx:ue76Zbx5yWX4C9otLFVB3DX9GDrhrrjsDf8e5EBDEiU7rHf-K6pBSQ>
    <xmx:ue76ZTMpW-CHAAlHtAAegKn-8bT8ohsqjKygKZKWHVC45z6j9agGxA>
    <xmx:ue76ZQ8hHN-A5DUYnHXNAQvICSY2gS02D0-5G3rN4QmnRF0KPsLEaQ>
    <xmx:ue76ZbUpaEFaq_UL_hF6Eqiesi-dd1dL_mL96hpd-LHVRN9Ty0w7hA>
    <xmx:ue76ZbWFQzSw9czc9xUTSq7eR0ZdKC07oMT84PMTaeHqBx7BBlr5Gw>
Feedback-ID: i7a7146c5:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 597D7BC007E; Wed, 20 Mar 2024 10:12:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d09d7505-7421-4975-a73d-3253d32c4db1@app.fastmail.com>
In-Reply-To: <20240320005412.905060-1-ryasuoka@redhat.com>
References: <20240320005412.905060-1-ryasuoka@redhat.com>
Date: Wed, 20 Mar 2024 10:11:49 -0400
From: "Jeremy Cline" <jeremy@jcline.org>
To: "Ryosuke Yasuoka" <ryasuoka@redhat.com>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, syoshida@redhat.com,
 syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com,
 syzbot+29b5ca705d2e0f4a44d2@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet
Content-Type: text/plain

On Tue, Mar 19, 2024, at 8:54 PM, Ryosuke Yasuoka wrote:
> syzbot reported the following uninit-value access issue [1][2]:
>
> nci_rx_work() parses and processes received packet. When the payload
> length is zero, each message type handler reads uninitialized payload
> and KMSAN detects this issue. The receipt of a packet with a zero-size
> payload is considered unexpected, and therefore, such packets should be
> silently discarded.
>
> This patch resolved this issue by checking payload size before calling
> each message type handler codes.
>
> Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
> Reported-and-tested-by: syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com
> Reported-and-tested-by: syzbot+29b5ca705d2e0f4a44d2@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7ea9413ea6749baf5574 [1]
> Closes: https://syzkaller.appspot.com/bug?extid=29b5ca705d2e0f4a44d2 [2]
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---

For what it's worth,

Reviewed-by: Jeremy Cline <jeremy@jcline.org>

