Return-Path: <linux-kernel+bounces-18329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71271825BA9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BA1284986
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFB120316;
	Fri,  5 Jan 2024 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JusJDyBO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lJrUv454"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EA01DFDE
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 20:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 1D9FC5C01D5;
	Fri,  5 Jan 2024 15:37:02 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 05 Jan 2024 15:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704487022; x=1704573422; bh=bk5Dr8X0YO
	CHd1Jl3i1ek4zNKLgAMly86kV1nZv04w8=; b=JusJDyBOqH5aYpg1JJ0cZU03Qy
	8utzg8I/uIquFPhD9KB0o2hhXJ5mmxxBDb9gHFjlixisHcH4rVx/EUrQw91nNcj8
	oCHfGyIxIupA+0nFVkUsqwWOAIUlX7yrVpD3Ktb2ssZ5C8W0aDBKEZi3vFT6fyzj
	XU+x71fF2SvAuj4/4gLBe/9qE7VBjlmZV7G+AkeddZ1o6CE7SgPQR+PShW74YZy4
	rn3gpx3PsUZo+G6x4BMQjjXqPcBFteFQ60Mh4EifYB5EGeCKqPah0o3R15gJo+WF
	vg2TMbCE3/0+mfhKaJ1nhqNAIjkDAYOJc15tpAypclyVI0Wvst8Pp9ytz6dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704487022; x=1704573422; bh=bk5Dr8X0YOCHd1Jl3i1ek4zNKLgA
	Mly86kV1nZv04w8=; b=lJrUv4548hvfuZxjAOK3VHoopmjb2+gPlkLQtF5nsc08
	7a6hlKbXyFVPjU/BCjteIWBtETcKIuvICwRo8Gd0sijrFjWeHC8JKTG5vbsnoBFj
	v45r7Y6JRaf4Z7gorSufAQoOM/2eiikCsY4SVQcsoz6ZNHdevc8dPGfIBOds31m+
	YxILU9dDYSoFGIU16D6/j/GR3XC32OW+rxHbGudtrejACXjRdnhnUE252YVXvgZi
	d20tPglqnUhAuZ/EgNNXPfqd7G4wAU0oIj2P7V5KIuOxKA/L13qB+uUCnO4LgED1
	kU2idQDsU3OiPGHmXItapmJb9JDwDTyI93b8NyBXmQ==
X-ME-Sender: <xms:bWiYZWTg-TuLeomyKvZ9-Qix5VfNfLMveQnsVvXiMow7raJ3ZG7dng>
    <xme:bWiYZbx-JOV4n-gVVdez4tTnMBG9C3RQXpL_ZXKBIYPIcBmTFmkMQlO1as-fwMXsw
    Vmisw1upnxFDtWhPLo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegledgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeeuhfejgeehhfefgfffhfdvjefhueetjeegffeuhfdvffelfffgtddvvefh
    ledugfenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:bWiYZT02Fy93bfKlDbzpWYukqaPGeH7iprJ3XNrQSq9e-TxxR1CNWg>
    <xmx:bWiYZSBSvBIhTYTe5EudX4cIwDDdYxBs8Wj6UBZKih0lbpzOauDMGg>
    <xmx:bWiYZfh7u90_0y6VB_Nzp7hGU4eHiV6NmCwEzDu0CYqi5g2E2v6iZw>
    <xmx:bmiYZaUm8AaU5jWZQYc5gaDVbNKxGGCTA3RS8VJbThLplJ-7P50NRA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 840EAB6008D; Fri,  5 Jan 2024 15:37:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20508695-b9e6-4aaa-9c78-84891c1a8f9a@app.fastmail.com>
In-Reply-To: <ZZhli2FWXwP1XSRG@kbusch-mbp>
References: <20240103155702.4045835-1-arnd@kernel.org>
 <ZZhli2FWXwP1XSRG@kbusch-mbp>
Date: Fri, 05 Jan 2024 21:36:38 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Keith Busch" <kbusch@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>,
 "Chaitanya Kulkarni" <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, "Daniel Wagner" <dwagner@suse.de>,
 "Hannes Reinecke" <hare@suse.de>
Subject: Re: [PATCH 1/2] nvmet: re-fix tracing strncpy() warning
Content-Type: text/plain

On Fri, Jan 5, 2024, at 21:24, Keith Busch wrote:
> On Wed, Jan 03, 2024 at 04:56:55PM +0100, Arnd Bergmann wrote:
>> @@ -53,8 +53,7 @@ static inline void __assign_req_name(char *name, struct nvmet_req *req)
>>  		return;
>>  	}
>>  
>> -	strncpy(name, req->ns->device_path,
>> -		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
>> +	strscpy_pad(name, req->ns->device_path, DISK_NAME_LEN);
>>  }
>
> I like this one, however Daniel has a different fix for this already
> staged in nvme-6.8:
>
>  
> https://git.infradead.org/nvme.git/commitdiff/8f6c0eec5fad13785fd53a5b3b5f8b97b722a2a3

+       snprintf(name,
+                min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path) + 1),
+                "%s", req->ns->device_path);

Don't we still need the zero-padding here to avoid leaking
kernel data to userspace?

    Arnd

