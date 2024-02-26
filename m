Return-Path: <linux-kernel+bounces-80597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07D1866A29
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549392816C9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB58F19BA2;
	Mon, 26 Feb 2024 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ylcUFohs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gmTCd6fH"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806B61BC40;
	Mon, 26 Feb 2024 06:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708929642; cv=none; b=eiBtsIEarS0h3TTCQhPdMxg2EL9W9orIrzL4w8tjJEByQpPTPQb2IfqD4gqp80513LSnxM0k2Xpm5dqv0YhEfiJgS5gxPIg6fVG9NgIcyaiY13BmB9vQX2JqeOwUdLoa/awJBDupEqTV9eQU+POsM2J21lj/jtxRM4iQ3LenAcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708929642; c=relaxed/simple;
	bh=F6xS/sPDcnGi+LW5vTTRr/QxpEkulMQOTp4x7pE3ti0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=u069j6tN3ycXt5XBqIiYgWumeXu+HQh52XUGbL7I52qJEI37Q7JeTy3pwk10fDqYDAVi7VNkAvmlAXocXF2Ydf8RfOukJ4oqmx7SeyAFcHiSSn5RbJ9xoU1J8S60Y2fMkzT5KskFvBCsDsCVQfMBujeeytdDk5mY3YNnDFr3rVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ylcUFohs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gmTCd6fH; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8B7C911400D7;
	Mon, 26 Feb 2024 01:40:39 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 26 Feb 2024 01:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708929639; x=1709016039; bh=niqg6Cmwj6
	McOY6q6YOYSiG1lI/AhWSYhtFhttSI3+A=; b=ylcUFohsRpW2osobS1SzL9f43k
	cXbdks5YgERsk8w+AhIrJ2zch9vgDk54QpaMaGe0pfJHp5hnnLBon8Xsbab4w1Y4
	FN5NcjA+9hEl13XKZLu+GMRpuPprgig/YEdrINFJYyafqa3BWOs06EkiEZydY3Mt
	bPuBHt7u5xEQhtn0iOPeUGKVICW5BkCs+4p4nrzI8B3ApGRMo744gxFuALOsxMG5
	h+oJJZAR7XtaFiwvbtPIcWIDeCceBcpTqCZKJ+S5PSJoyzHvse8XmYlljwoqHKW0
	/H/1vyvMAvIGdntsg571PK95qmZ58Z6cvrYLS3/q9KXe4GVRbXJ35sCrgMoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708929639; x=1709016039; bh=niqg6Cmwj6McOY6q6YOYSiG1lI/A
	hWSYhtFhttSI3+A=; b=gmTCd6fHyHCbMVnrMNr6SxbDZTN7HzIC2m+K3dXIpgHc
	XHfk6GFvhe8kYjkxun3dACk75dY+ItX0TdwlbCqF63azAUy0rY5MiSZ78bxocIQR
	U7KsYKMRTomwsogk7vdXeCmghYCHAmQUtP556dCgq/SyB4THh7GNGx2j3Xf+Oxpj
	45wpKHmBdl1/kTP1GBIoGRFx/vBDWNTK3lfEGwEBudJ7+t+d5bOFUBsFPvcNpb7o
	Zq1T+u9/700HxYm92jrHsdaefk7JRbrcgotaMas4cTKbznhYo0w8tbKFAQhHhaeG
	BFj3IJA184GhqecEx25YUgf3lSKcQRBe7n7SwjJE9w==
X-ME-Sender: <xms:ZzLcZZ10f8jr78mhSylkAS3QEHFcUauyEfEGuVwLaq4Vv_ITTwvJAQ>
    <xme:ZzLcZQHRu89H9DIfrQCWLkC8iLffDE-u7n7Ofp4bWovnsWY07Cjm7-t6Tv_5e0Oom
    yi3GSEgROZtnHNrID0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedugdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ZzLcZZ47C7MHeKln-OlA19Vj0HBG7sN8EJVkvHKLJtZ4ZGxoNy0e6A>
    <xmx:ZzLcZW3C45HywqviGkbs3cXfJbbgLh7PhM888xmOM1-z8i6qfKAwDw>
    <xmx:ZzLcZcF6Z70NJf03ZjHaFnJ4qBi9StAiv0TJINxkflS6I8g1ExtfXA>
    <xmx:ZzLcZU8_FnbjCcuw9QwGXwATNf6tuSa6wBHUvooKZbRb_CqKD8dVTA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2013DB6008D; Mon, 26 Feb 2024 01:40:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bfc0de42-a34b-4701-a392-6cbd0061a433@app.fastmail.com>
In-Reply-To: <20240225121929.2e3fdc1b@jic23-huawei>
References: <20240224121140.1883201-1-arnd@kernel.org>
 <20240225121929.2e3fdc1b@jic23-huawei>
Date: Mon, 26 Feb 2024 07:40:18 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jonathan Cameron" <jic23@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] iio: avoid fortify-string overflow error
Content-Type: text/plain

On Sun, Feb 25, 2024, at 13:19, Jonathan Cameron wrote:
> On Sat, 24 Feb 2024 13:11:34 +0100 Arnd Bergmann <arnd@kernel.org> wrote:
> It's a false positive, but the compiler has no way to tell that only bits
> 0 and 1 can be set.
> https://lore.kernel.org/linux-iio/20240222222335.work.759-kees@kernel.org/
> for discussion on why + the missing zero initialization bug Kees noticed whilst
> looking at this code.
>
> Kees proposed an alternative way to suppress the warning that I've just applied.
> https://lore.kernel.org/linux-iio/20240223172936.it.875-kees@kernel.org/

Right, that's fine.

> Your solution also works but leaves the implication of a real path to
> overflow the buffer when there isn't one, hence I prefer what Kees had unless
> some future version of clang trips over that in which case we can revisit.

The idea with my patch was to make it obvious to the compiler
that there can't be an overflow, which would ensure the warning
doesn't come back. Kees' version works by avoiding whatever
code path in the compiler trips over the warning, but it's more
likely to come back later if something changes in the compiler
itself, so there is a slight chance that we have it work
around it again.

      Arnd

