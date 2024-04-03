Return-Path: <linux-kernel+bounces-130538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D438979A5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C7C1C21730
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13E3155729;
	Wed,  3 Apr 2024 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9bvNYkb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BA615539A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175071; cv=none; b=uY9EM1UE+XG0nPF9xND7DBNZlLnyzYwMq9MOjsLtMFfBjF9MNjf6wyew8R39j9Qcj0bnZqftxAyxOhmvRV9ZEKkkGDXERRSCtWp9hP269w0RCp2HxV1f8Flqp+wjIt714VJ4KdteIlEyMJamkr2J/zrJk8yYTAs19l70xbZk+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175071; c=relaxed/simple;
	bh=IvxSvK0WuGmIvWU6U5fh+b80fXcNaHsPVe6szix/RvA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Mcj6yJCEpMAOec7ykHfBQefAgW4Ef/AhqSbieCvhpq5aI9PV8siY0ARkPvCtR/mAqWf2zfiGijPW/Brco/3K0qHs8ZWzsP/6DZdZC5Qiu59DhnAEKIVlsYyvKJSQlw9TDHuX014O40lz9gG7Kl60LCBR1fgF+d3s4O7El/+A+NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9bvNYkb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDDAC43390
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 20:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712175070;
	bh=IvxSvK0WuGmIvWU6U5fh+b80fXcNaHsPVe6szix/RvA=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=E9bvNYkbT+leUJgrG8MBSI/t7Gv1RGkich6nnLWrefz6J4Lw5+omlEEJXjon1KeEB
	 fohvoqS4X0cJWKzLxf7WVn1ecaF/VZzeFq1Dx+RXSAClD2vGr+5I9/19ZbdjI0zaiT
	 /QdLCYkxuSkkxlr3CjPv4sq5FOALAWOfawZu2f1+S9ADa/l50kjWojmYBtXJRfvP2w
	 jeV7ZABAWgP0Ngv4XqMFVer+CSiEYqWjUTLOpfnmvPd8FfZPReUmp8wFNEyB0Bgjy7
	 X6zid3JTjeLRf+Cx4i5qtdGfFi1HOmNxeJLec0bzVtESR4h9d6GHkX1himXf8S35BJ
	 ehynsPBQUrErA==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 7D652120007F;
	Wed,  3 Apr 2024 16:11:09 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 03 Apr 2024 16:11:09 -0400
X-ME-Sender: <xms:3bcNZj1NeyVo-xDbiJ8C9RpS1JoBlLeLG0Jp4IW_z2rYN7RE9mn1Og>
    <xme:3bcNZiHNFh8BXNm7WM--QwwNjh66JeQGooa9kQaB20tW307ahUGR4QOCJQfAehJV8
    bowvayr2oKPNCsVE7M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefiedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpeelvefgudeiheefledttedthfffgfekudegkeelffdtiedvgfevieet
    teekheffveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnh
    gupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:3bcNZj5VzWhFBw2gQtIDpxY_fXKlfNsNgAdYgDY7dPwDU9P81NAWrA>
    <xmx:3bcNZo1rDrhT4xoe0zhB11lp5V4U8GCUDQwsOvA1bgg_ZcQzPdrDfw>
    <xmx:3bcNZmE9BPvUNMECxWGMpoJOpqc_hyNK-5-Ix4LhWgL7reD1tjHMsw>
    <xmx:3bcNZp_kReTyoLKX8L8HOFkYFE8OnlImEnPmJ0Im8udtHyMKY2RFlA>
    <xmx:3bcNZoN7YOioKXQ_9Lx9kIsfmgc22OK4vJ6aoD6ti5fQ4SphvDi0tg88>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 30314B6008D; Wed,  3 Apr 2024 16:11:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3dd44bdf-7950-4822-ac7c-97fc1bdcf5d7@app.fastmail.com>
In-Reply-To: <20240403130243.41a65a767f03fd7c4d8dabf8@linux-foundation.org>
References: <20240403132547.762429-1-schnelle@linux.ibm.com>
 <20240403130243.41a65a767f03fd7c4d8dabf8@linux-foundation.org>
Date: Wed, 03 Apr 2024 22:10:48 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Andrew Morton" <akpm@linux-foundation.org>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] kgdb: Handle HAS_IOPORT dependencies
Content-Type: text/plain

On Wed, Apr 3, 2024, at 22:02, Andrew Morton wrote:
> On Wed,  3 Apr 2024 15:25:46 +0200 Niklas Schnelle  <schnelle@linux.ibm.com> wrote:
>> 
>> This is a follow up in my ongoing effort of making inb()/outb() and
>> similar I/O port accessors compile-time optional. Previously I sent this
>> as a treewide series titled "treewide: Remove I/O port accessors for
>> HAS_IOPORT=n" with the latest being its 5th version[0]. With a significant
>> subset of patches merged I've changed over to per-subsystem series. These
>> series are stand alone and should be merged via the relevant tree such
>> that with all subsystems complete we can follow this up with the final
>> patch that will make the I/O port accessors compile-time optional.
>> 
>> The current state of the full series with changes to the remaining
>> subsystems and the aforementioned final patch can be found for your
>> convenience on my git.kernel.org tree in the has_ioport_v6 branch[1] with
>> signed tags. As for compile-time vs runtime see Linus' reply to my first
>> attempt[2].
>
> I'm not fully understanding the timing.  Am I correct in believing that the 44
> other patches are not dependent upon this one?  And that this patch is not
> dependent upon those 44?

Correct, there is just one last patch that depends on everything
else going in first.

      Arnd

