Return-Path: <linux-kernel+bounces-68695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F93857E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A02D1C2123C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96708129A9E;
	Fri, 16 Feb 2024 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="d1gMyEQx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CYUGZ/nj"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6494D12C54A;
	Fri, 16 Feb 2024 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092279; cv=none; b=TjM5R6ukrR2xLfn+GMKbNzalRAUXqSBA/Ud7bRrzurTuKSVR/ZOp9NjgHqXaVEEOshZ1ye5dnQAXiAuA+rZgqpNF6AIkroYojE5Wn37GhiOLzmuJqEKA38cRZnhyZptlmAllOlAuHvQY3MueYlfheFB2xx783h5IdsUsPkJI4zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092279; c=relaxed/simple;
	bh=JKmsLs59jO5nqdFavx3u4/IOXJSpBQJ3cSSgM+LlTx0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=qxLrwPPpXFpqdRPcTpPO4DTV4Xlnar94rCFRtH9sQS0fpxk1dg1SB75Rf5lvSlYGAGbMBi/PwhQtM0NyhY/KP2z5h40cxpAvC6JDQ8N/xw0NfFeeXTKYAHO2Xw4XvpJLsYx7HBNgM/8UA6/7WpwcVFqNIysK/Tcf9iN+YIVXgS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=d1gMyEQx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CYUGZ/nj; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1C7CC13800CB;
	Fri, 16 Feb 2024 09:04:36 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 16 Feb 2024 09:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1708092276;
	 x=1708178676; bh=xFinwvZsrlvUGjNZQPKThE+p8vedvK1faZDi1/Ymc0w=; b=
	d1gMyEQxtRotjYkrw8mdHJ8KXrjzwEl/mdKBBRxPEUcUHwccIXLQH9Z26S5jaIOJ
	r8TFhJrjXEGR0469jU44PG+bKttR1gJ+kS9Gu7gL8nDdUcdYR7RP/iCXf3B2zoyd
	7uFgp4MdeG/rT6sBXCgAL5XtzfCtKQ2gr9RaZj2lw5nlqAnJAGUMYJTPSxqbQXjS
	bvNR1eGuWLQCxUDVzLNEFDjF+Db2tfB0RY6J6XFPskHKxJfXm7fS/fbNeiarYtaq
	vRU1Xg6Mu6OvK4m8p6HTAlkSQjxasDGoYYvBOJHZP96KvJhUoPAEiSVKF8QVujCS
	u6QpsRV2b1N4S3M0q6SBxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708092276; x=
	1708178676; bh=xFinwvZsrlvUGjNZQPKThE+p8vedvK1faZDi1/Ymc0w=; b=C
	YUGZ/njD8YfSpEDvhvTXVQ9OorBdHGWJa+FVOTRsh/D+vls5IyyQWdy/A0TD3oUV
	Xd4MIjnYzJ0v/NHNjLZja+vvlDV/GC+B30xJoNJmfjTOwJG4vy+KHchuanIU75gJ
	zvBhLjsJYPKYsFodxfl1dW5nqwWmg8OZCsmnPR8UPVfKm+BNtSp5X59jrQ1I83TE
	bL+GRJLYVqe5pZDFl/z8DQUqHRwbYlKYE78KrEzACzaxEi0gYEP71ttWlDmvQd6v
	7e6VHB8v24dpaf6oYgd5P3tl/7Kh+PCq9pxzJh/U/RdhhrgIpGxf8fpritAtR+qb
	1cxkxnLKhzV7d0cVPFguw==
X-ME-Sender: <xms:c2vPZTGXQbZ5Mz8SIxdotjtNZTliLREJZQBUFU494y4CNqzoG4YJYg>
    <xme:c2vPZQWC5a6ds-Uhqw_rPQMQjUwyYFzESuV4Ud9YHxOF1Sm6rvBbIAMC6UqQ90dOH
    8L4bmG3wrvr0yQoKeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:c2vPZVIyhdRQ_DGL3RlOiIH_wQgfh2nol4zSHPH8VYDYUCCo4_J81g>
    <xmx:c2vPZRGFZ-zHxiliB3-rzjUXa3tGx-IsQPyrBFNVnLLzvxas_SoP7w>
    <xmx:c2vPZZWykE9YcS1cjbYuh1MCmrKUELYUggTGkw0ZrL_UXVdbbk2FTw>
    <xmx:dGvPZYGX9-9kTPXpv7uYgrEaM_qu3fRrVxhHAdN9udtO0hQYgNMstQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 16E8AB60093; Fri, 16 Feb 2024 09:04:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <14ab7b63-b2c0-41e3-8104-da5515b379be@app.fastmail.com>
In-Reply-To: 
 <CAMRc=MdBbzff5BppY4Hjwfi=SnmYopnFxg1AX4QsGt3Y+-g60Q@mail.gmail.com>
References: <20240216125959.3766309-1-arnd@kernel.org>
 <CAMRc=MdBbzff5BppY4Hjwfi=SnmYopnFxg1AX4QsGt3Y+-g60Q@mail.gmail.com>
Date: Fri, 16 Feb 2024 15:04:14 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Bartosz Golaszewski" <brgl@bgdev.pl>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Linus Walleij" <linus.walleij@linaro.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Kent Gibson" <warthog618@gmail.com>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: cdev: avoid uninitialized variable dereference
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024, at 14:19, Bartosz Golaszewski wrote:
> On Fri, Feb 16, 2024 at 2:00=E2=80=AFPM Arnd Bergmann <arnd@kernel.org=
> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The 'gc' variable is never set before it gets printed:
>>
>> drivers/gpio/gpiolib-cdev.c:2802:11: error: variable 'gc' is uninitia=
lized when used here [-Werror,-Wuninitialized]
>>  2802 |         chip_dbg(gc, "added GPIO chardev (%d:%d)\n", MAJOR(de=
vt), gdev->id);
>>       |                  ^~
>> drivers/gpio/gpiolib.h:277:11: note: expanded from macro 'chip_dbg'
>>   277 |         dev_dbg(&gc->gpiodev->dev, "(%s): " fmt, gc->label, #=
#__VA_ARGS__)
>>       |                  ^~
>>
>> Use dev_dbg() directly.
>>
>> Fixes: 8574b5b47610 ("gpio: cdev: use correct pointer accessors with =
SRCU")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>
> I seem to have beat you to it[1] and my patch doesn't change the log
> message so I'll apply it instead of this one.

Ok, thanks. I thought about doing this, but could not
figure out which of the RCU primitives to use.

     Arnd

