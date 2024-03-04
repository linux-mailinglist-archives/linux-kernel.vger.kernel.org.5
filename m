Return-Path: <linux-kernel+bounces-90467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B9486FFA1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82664B24236
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB55381D5;
	Mon,  4 Mar 2024 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BqJS6S5r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="McKmMK7J"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206D9376F7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549924; cv=none; b=HKfGq9BpFB/KKfcqHiD2/x+hmcpff+WqeQhxkSC+EjQ553thvay9LIbG50x8aZAg9rkwu4TojuuwqPacifbYqA8SLXGxAZNyu+B8Pz4KCwW1VUyDStFgUQg2OdNF12nLzAFEiNXOwQQxDdC1O7vY2FGPFlrOetqGKPT4R+bTVfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549924; c=relaxed/simple;
	bh=249yk6eWEjjWoRhjonEKb38hHj3r4c1txX4WOVsv668=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ro9ud49PCUjdPs26dHpO8MhJKQm0KKmn3Q1RpdR6rmZvwUIdHETHQI/UxU7jmK+4uWTE3t9dx3BhWxBn7EA50kh55ay63a97qwYDpUHuvdOqODaRqsO0Scg9CySmMwNiolGK3jGgY++rI8cNvBKWJUB9gSKvW0JSsYcUzf2azpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BqJS6S5r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=McKmMK7J; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id CABDB1800072;
	Mon,  4 Mar 2024 05:58:40 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 04 Mar 2024 05:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709549920; x=1709636320; bh=LzF8Zv3PvX
	VlkIrXqbIlnUe2pkXzxE7AeiA/nV9wZ/E=; b=BqJS6S5r3T52XC0SuE4vLtOSVe
	qgAMGz/30FS1ct8VLOYEllUQ8nuL+hGIu8WeD0zAPGslqX4nw3cS842P2o7ColOU
	ZOiSCyEha51V0ZAUbjBs1wRd+Bv2VaXorgzkOjpJr/dX18TiUEJCWpe0ZxTKNFA0
	5ISyqaJds4LHxVvtpyp6SB3YvsfBP4epCaBEFF5VQY3jx4pjgY5xqNtkxWxDVwGv
	0RGqk/ve+c88ARhncQZ5exdRoFyXmS6r2BpJBrB4Hm3h3EK6GCYtVyzDqt+wE0ul
	CTiinKlKO0z05veQFQ43Bui60rkpYkoUDNN3/jY/sNNZdyrq4pjOqX0/FWtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709549920; x=1709636320; bh=LzF8Zv3PvXVlkIrXqbIlnUe2pkXz
	xE7AeiA/nV9wZ/E=; b=McKmMK7J/QSsg6e0l+x9jZDQGYlrrn0CYR1bSZNAcIxN
	eSnFz3Dpsnl/hVavIdDU5hArlkvIGiQdwk/iSFjrLpT8EAm23IlQ+cqQ1MrfpO/Q
	JZqqetoFG0wN5vo95pqLBZxnpqBwptK6Jaq+MA4Lr8cqjnD8NUds7XMKaYmlqrQU
	9FPVG+SspvflQ5kablMq1CrPLXLNIKBn2/7qC9cOA2W19k+Io8fje7vcl281XG0w
	9KA2fDRZPwq4MqfN548Hq23+59FRgLLlGkOv2/RS+luDGvp/YAgZdgAk0O96gdcC
	20isq7Yi1JTgq5Udh159sYURbQq0ZaH/bbI7TEmoqw==
X-ME-Sender: <xms:X6nlZXEoL2IsNnaq2vb0f7CaiKWKhjPiEjHtMjwLFVW6wBiW7rLiTg>
    <xme:X6nlZUXai7pXc8QCuJgNL6PzXuW16al638PBqiMD0CkHd7c1wIiSULx4eqtGJZg_d
    i9fXKXlC7dy0Lqb3mQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:X6nlZZJFohizVSKnvmXVdVUY7CgqT8KnKj_rSlTxAzhV9ujwv163nw>
    <xmx:X6nlZVE3FEvJ59TaS7RF8QY5PIa0xLTEnH4ZkMW2YiIHrS0XuiJX1A>
    <xmx:X6nlZdUXPpoacw7aJCxNS_0LXr25KvbiaTh7FZcElq4hbH6FPaijZw>
    <xmx:YKnlZbfXH5d_SU6YrLHwgofmuWmD7GpTgKPmS-6Nu2NMS6Y2urAm40kXLZI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 70F7EB6008F; Mon,  4 Mar 2024 05:58:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-205-g4dbcac4545-fm-20240301.001-g4dbcac45
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <44216ff8-740b-45ca-9902-b52a04901655@app.fastmail.com>
In-Reply-To: <Zdc0M9Uf2zn63P0e@kekkonen.localdomain>
References: <20240219195807.517742-1-sakari.ailus@linux.intel.com>
 <20240219195807.517742-2-sakari.ailus@linux.intel.com>
 <MW5PR11MB5787130A75404600F47A7D9C8D562@MW5PR11MB5787.namprd11.prod.outlook.com>
 <Zdc0M9Uf2zn63P0e@kekkonen.localdomain>
Date: Mon, 04 Mar 2024 11:58:19 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sakari Ailus" <sakari.ailus@linux.intel.com>,
 "Wentong Wu" <wentong.wu@intel.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 "Tomas Winkler" <tomas.winkler@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] mei: vsc: Call wake_up() in the threaded IRQ handler
Content-Type: text/plain

On Thu, Feb 22, 2024, at 12:46, Sakari Ailus wrote:
> Hi Wentong,
>
> On Thu, Feb 22, 2024 at 03:26:18AM +0000, Wu, Wentong wrote:
>> > From: Sakari Ailus <sakari.ailus@linux.intel.com>
>> > 
>> > The hard IRQ handler vsc_tp_irq() is called with a raw spinlock taken.
>> > wake_up() acquires a spinlock, a sleeping lock on PREEMPT_RT.
>> 
>> Does this mean we can't use wake_up() in isr? 
>
> Good question. A lot of callers currently do.

If driver has a traditional (non-threaded) handler, it should
always work fine: on non-PREEMPT_RT it can take the spinlock
and on PREEMPT_RT it automatically turns into a threaded
handler that can still call it.

> In this case, handle_edge_irq() takes the raw spinlock and acquiring the
> wake queue spinlock in wake_up() leads to sleeping IRQs disabled (see
> below).
>
> I don't think there's any harm in moving the wake_up() to the threaded
> handler.

It causes an extra bit of latency for the non-PREEMPT_RT case
because you now always have to go through two task switches.
This is probably fine if you don't care about latency. 

You can probably replace the open-coded completion (wait queue
head plus atomic) with a normal 'struct completion' and
call complete() in the isr instead. This one seems to only
take a raw spinlock already.

    Arnd

