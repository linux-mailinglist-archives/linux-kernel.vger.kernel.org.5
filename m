Return-Path: <linux-kernel+bounces-55440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E5484BCB9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688411F27592
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95644DF71;
	Tue,  6 Feb 2024 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="Plphh40t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F5y8dXUx"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96B1134A5;
	Tue,  6 Feb 2024 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707242979; cv=none; b=elk/DYAOfDUrSA18RO9Sr1Y9ovlZe7+Qrf6CwOLmUqY6M+kGTo+7jf1t4bgekCvXP8AJWQsIuVjmKMeshPFvrotYsIWBPQ87d1zBHPvclutxuXLkUdLWDhcJgGQBH4ByZsJVeRS5wlVJrlAPxLPdJOZnyKnNpzlIuefJKsxucDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707242979; c=relaxed/simple;
	bh=Lkzj1Ayc+R4RiqSI0SS6Fu/wooUtrvulT1004AeJ7Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ob5D8W8hUJFX1uq6oRCP4f2zZc9RQ/u9dVb0FNadiXLIA0kSDBV7I1p6MdpwJLVWQxsQKSqvXdVCqrqxVTwnMXmN8CWjQeAJw2Zo0ck/cYQnApeX2XHl5qJjfJjiESDf3/txxff7kMVoav+Um5QWiaFIwcMo0TT8qGqAdaSwkhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=Plphh40t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F5y8dXUx; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 9500D5C01F0;
	Tue,  6 Feb 2024 13:09:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 06 Feb 2024 13:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1707242976; x=1707329376; bh=DB8DBh1GEy
	XCan3X4jjSpE9brtS6cbZs50FHQuPtbpc=; b=Plphh40tfqSto1OziocEInZ/vR
	QGd3hq3SQij4/SMfcurwsPyR2E7qj8796xDg1dn4TtpIgRdyhPAUquQ5MqMgRe2h
	XA6hAgZH1RObcm6A3hlHoC2Y3/ReFrnQVnKBm6Ai+nJaS01hwMLRTmHLfchwdZgP
	lCtZ5WxsKlgOlhlVv4y4U2+PR8wGpwm7Au40tjcQRZd7375mbOGIkrBxOcz4aD1f
	sLzUfollZfjEy0N6NElyMW34dVkKjpiuKqoWUwk3TCEKi2feEW2EtGloRwK+j+fc
	4c3uUJZ1XMr1zOdKctJMZrzxRyg8ztSslXLUpnwtmLYL2QV1pBrt5L8EQfZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707242976; x=1707329376; bh=DB8DBh1GEyXCan3X4jjSpE9brtS6
	cbZs50FHQuPtbpc=; b=F5y8dXUxDhfEIRxpnPgFsbIZ+30DW0hj8eeB6QjRltRD
	d8z4yt8NRwG/7O/8aadXfGEmStivn8AEKSXKCGhiexDvswKpEbKblFWcA4Roz8AR
	9PUbd7cGMhi9KpD1dJ46/OJOwMjkGHuR6JUBmWhDYuyoX+3B+VZ2TmHObe374XqW
	bjkRpqhkoFV/OluSyk19qymTL/FuWRjaYBZEh0ZF9x1yhle+IkkJp0fl5znD/C36
	hesOU60ClAKvs2zcwMl4w8lWGFhzKG0gBIzTRqssFn/9g5LeCUh65r8r6V+gaTtt
	/woOW7bquWXbvvavkEL3VD2iQSysBD8wq9Ldg5EMug==
X-ME-Sender: <xms:4HXCZVVdeciLSJq9KB1uNeMsgQ4ORMBYJ11zWg_ID1Mj2hNjfPUu-w>
    <xme:4HXCZVk32W3I4z6ZcYJucZFrNLv53BfLpBzaZUKFyHfZAkcAMaDkHMaNDoow38j6a
    lvBDnyGhBBiu8EXelw>
X-ME-Received: <xmr:4HXCZRbfohjaTLqMMX4-tVzdwPq7ciDQgPCCDwKaheOxyllQYtGS5sCm35FwNrncDUdJcJa9Hw-lefTgltYj2aKxe_cv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddtgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteeklefh
    leelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:4HXCZYUs8tLLk3bMCYPIZbmLigHd-_Q9tiDdlqvFVHSbMWSAj3yHdA>
    <xmx:4HXCZfk2_AF_TtAh1od3Ul9_lCCAHcoKFJAIcmAC_oyAloyWBYWjAg>
    <xmx:4HXCZVe6OY46kMsFo9j8LeTd_QEI6VPa3OeQ6QwkoVPor7MH8ACBig>
    <xmx:4HXCZasGNvMLqa4__5XAfRKB4_u7uYSsMC90X3O-8omF8XcipvdHZw>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 13:09:35 -0500 (EST)
Date: Tue, 6 Feb 2024 11:09:34 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH] pidfd: getfd should always report ESRCH if a task is
 exiting
Message-ID: <ZcJ13uLxD6rTqqZZ@tycho.pizza>
References: <20240206164308.62620-1-tycho@tycho.pizza>
 <20240206173722.GA3593@redhat.com>
 <20240206180607.GB3593@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206180607.GB3593@redhat.com>

On Tue, Feb 06, 2024 at 07:06:07PM +0100, Oleg Nesterov wrote:
> Or we can check task->files != NULL rather than PF_EXITING.
> 
> To me this looks even better, but looks more confusing without a comment.
> OTOH, imo this needs a comment anyway ;)

I thought about this, but I didn't really understand the null check in
exit_files(); if it can really be called more than once, are there
other cases where task->files == NULL that we really should report
EBADF?

Tycho

