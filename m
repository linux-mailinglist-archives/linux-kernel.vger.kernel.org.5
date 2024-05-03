Return-Path: <linux-kernel+bounces-168165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588E58BB492
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3CF285DEB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2EB158D78;
	Fri,  3 May 2024 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="nsqq1Z58";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NX2buQXr"
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0EB155321;
	Fri,  3 May 2024 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767336; cv=none; b=eLLitb/HGHUGyJFjHnPAmBv53bkavcJCqDyKFoNnI+aDL6z7RTWNzDoe0tc0Vb4OGSOONaSNHzfwj00dW6XEuHddCZkaqdcffIIYUs0DbpgN0zY0PQWQdXo3IwSf/t3ZmdGVEjwlkXkN0/cm2tjTDKzTlU42XrWUcilGnhOFGC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767336; c=relaxed/simple;
	bh=HM8F0PQ394LhpqPEV/Z5taEtrw+ZqtqtpfiTTlIB8dY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=BbQI1uJ/x9e2bd2wSwzxWZxOYUAZcv+32buMGEJt+sPaLnvOgTuv1MygynNCqtw3eHaytWIGbyJ6MeZEWtF5SurrCMtN1MEXs5OHh6eauJYDY1O2+vzUOXEUs/VEicfDlUGt/KZgv6G+ycBvc0Bo2FkWWHspyWxMrea8e8wIGKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=nsqq1Z58; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NX2buQXr; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 988BE1C00169;
	Fri,  3 May 2024 16:15:33 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 03 May 2024 16:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1714767333;
	 x=1714853733; bh=aSeWM/wh3VnIuBoCTK5JiSYe4LKfwPuZ27pgSzHIMM4=; b=
	nsqq1Z58j1Fr9cyPmNKKSGfatcAzimPxtB/ydNkiQDUvdVYoonVSimn54sl1GRlh
	95jIZSndZFuXsjq6a2sGIUdgJJP2GlJyauhEUppaCPz8B1wM1bA9U+z0i/znHOhv
	Dd4iE5++zSvI67eLmVqBVmJZm0aM2NibFGny3dK+Z82AnSEF8t5RrP+ai6yEUSmn
	VrpqOZ7CD/UYtG/FPs7sQXxovFe3KFPeV2YMSU1xYL5MrUgmE3FfOmQrhU82y/tA
	Mky0AnrSgvNGBi6NBi/ylRBKzu0SdMR+AlIoVTDsS+4Rip2i8hoGfn6F41mB4ZEJ
	Alk0nuQQEG7DmEwR3s7YnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714767333; x=
	1714853733; bh=aSeWM/wh3VnIuBoCTK5JiSYe4LKfwPuZ27pgSzHIMM4=; b=N
	X2buQXrmxhfX3eottTwuRLyry39HEwU2ZUfDMmLkOf0JJ9Ko20MsKOPNy0XvTFhy
	glbxIHST+WVF9ANCgP5fTDQkTH5UO4Xd58v6hXgKynorJ67LUkuO2jb8RO5r4wOF
	qCBGbXy2T0TXcW3xV0RSGKXXgYq2odFbumj02ugEzrcPJQu2K0saxc84XxjEfJUY
	0mSeSo1iX6s4cXQTfvgbVcr7Y90YVhlkmzAmRDGqrNzMCIwMXo3EFmYGqyfVNqJE
	hRMLh2MZKUIdhnECDzWdr6Rrw1lqTsJNM3PbcyxL9OmAnKU0MA9xRvqB75ZU90dn
	1JjR9EStYYBL5cAHxhZBg==
X-ME-Sender: <xms:5EU1ZlHFjMHUhTqWYFZ6LXyGaTdmnggvQU_Ee6_bE2iT-q4mm8s84Q>
    <xme:5EU1ZqXl2E7EIZgvGJnlQBBpTC41EpzMvYN9vuw9tMqs8b30fsce5jIX1c4GiBbmY
    yjeDhLYIx0Uq8CJMkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgfekueelgeeigefhudduledtkeefffejueelheelfedutedttdfgveeu
    feefieegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:5EU1ZnJdKDIRLLPVhQKGYNKKNLV3sUz47dSOZ_Tn1Y8w9dvNVc6znw>
    <xmx:5EU1ZrGhH-UiMigYt6kkyxvljkERqFme1_nZ0CJgzCEC4jIX5JwOMA>
    <xmx:5EU1ZrWiLMMVfyWnkQn8I3Wl5zVvJ6Q71n7KfUbNj8rHxm0BVUAzyg>
    <xmx:5EU1ZmOB8qlzkQppQsdHmoeFTd-NLcaqc_jmk33ktRQUI-porzv0zg>
    <xmx:5UU1ZrSQlC1gd649oEsyQHL1v1qvuXr2zSWTQkgzD1u9BQOsRNYZb5o1>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C89D0B6008D; Fri,  3 May 2024 16:15:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-417-gddc99d37d-fm-hotfix-20240424.001-g2c179674
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b72c2b7a-a929-4c7c-9bef-b230630df882@app.fastmail.com>
In-Reply-To: 
 <CAEdQ38GNU_vCFgi-uuFCW_QVBObTdD8VwoyQ71Cm5dNfZ4+=JQ@mail.gmail.com>
References: <20240503081125.67990-1-arnd@kernel.org>
 <CAEdQ38GNU_vCFgi-uuFCW_QVBObTdD8VwoyQ71Cm5dNfZ4+=JQ@mail.gmail.com>
Date: Fri, 03 May 2024 22:15:10 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Matt Turner" <mattst88@gmail.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-alpha@vger.kernel.org,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Marc Zyngier" <maz@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024, at 18:06, Matt Turner wrote:
> On Fri, May 3, 2024 at 4:12=E2=80=AFAM Arnd Bergmann <arnd@kernel.org>=
 wrote:
>>
>> Al Viro did another series for alpha to address all the known build
>> issues. I rebased his patches without any further changes and included
>> it as a baseline for my work here to avoid conflicts.
>
> Thanks for all this. Removing support for non-BWX alphas makes a lot
> of sense to me.
>
> The whole series is
>
> Acked-by: Matt Turner <mattst88@gmail.com>

Thanks!

I've pushed out the series with the additional Acks to
https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/log=
/?h=3Dalpha-cleanup-6.9
and merged it into the main asm-generic branch for 6.10.

Can you give this a quick test on one of your machines to make
sure I didn't introduce a stupid regression somewhere?

     Arnd

