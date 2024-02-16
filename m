Return-Path: <linux-kernel+bounces-68946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0D685823F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52AD81C217DC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C352B12FB39;
	Fri, 16 Feb 2024 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KD2crBHC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mZn6vVlz"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565DE12FB0F;
	Fri, 16 Feb 2024 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708100250; cv=none; b=qXZPAWcA/gV0bbTL3PNJ9hDqQ58LzJakKeWJX+gN+N2d35NijvZzw1vsZlE9nZqA8OFPldIhd+qVmHPS+foycqRreODrP4tKePntbVWkZ+qWHwR9D274aAhQb/j28C/nj29KZMluoYlsluW7sIBxe/Prd+5LCp8AwIBj61G+C4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708100250; c=relaxed/simple;
	bh=vzXLcJ2vTatAhLaZ0FkRk3tGkWpZ6N5mBVI7/QUZOAI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=OVfYqB/9xQzZIBm90pYheX7nw5t1LqtzwIVqW8MD300JTXbBRJurDzBo+cpme3xoZ+kOgiF8OqTmzGNB2PJZenPiT6QD0uLknG3ENaL6lm1i25W4JrkJeLk9yEx/+etUWLUVarB2gFwMIlrkKZbWznVE9aiwnovhoQwTTIYuzv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KD2crBHC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mZn6vVlz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0403A11400B2;
	Fri, 16 Feb 2024 11:17:27 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 16 Feb 2024 11:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1708100246;
	 x=1708186646; bh=NQ04yfFI5uomznDjKG5RYu13iYSYf7WZj9yNhO4AHb0=; b=
	KD2crBHCIxcC72RPbN46HFPyzzSGefTiTZnOu8PVTI968EX6DtMX13+Dy5IgJGwU
	JaCTkaSL4D1p0obCMaIZg5d5JXDC5Qj/m6Dau1WzrFgYL3kQPITZBil7Dtbtftve
	m+dFMVEAP3Aj/1HR5JC0Wnd+e4gxXbsZQaTEeXkYJx/+hS7re/5yl8wSQV7KM2b6
	nS21VcBebUm6yEDUdhcqJROME8zpm4dBVsDyM3m65qdzuHf6HRTpg0YrzluIT7qw
	4o5kEqzXEq6kKlB5NS42pf1ZdkHTiryjPnGakUoaPLsQL5vtKCsamF51ZxyEIPxp
	wK0ZGojE57/dCULbjORc2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708100246; x=
	1708186646; bh=NQ04yfFI5uomznDjKG5RYu13iYSYf7WZj9yNhO4AHb0=; b=m
	Zn6vVlz6zhgI3OQGmNKzGWAIU/+zHK8C96CQvbo0fo/0Zi0vIHn1HNgOVxY6Qsdv
	m0fjwcQbAo8NGejBbJ4bxu1lJxkgY026wTXhMz166AN/a/ArcbyCk4vXAFbyWyN+
	msOsxZ1n/DfSQrJos/tQsumRiintwnSUjpeN54iYlzq1kAaRMADfMTeIBUlnbMEh
	JsAhu4o9/cEynr4BQU/+EbEUEkZNQ7OVXP9p8JO0kZLPs5Fd/h+7AGc8ncpiLC1O
	c5VQ2q3jmhyvxIpjj8KRlUPtzCZ+GcxyfFbQmP8jVm/aMMulrSkxENLMp2YuljER
	UsVAVL5AgIQyfZzfcK1ng==
X-ME-Sender: <xms:lorPZdeHGkoabrCX4SsvCuAWiqIBXsDcq1vFFyNzPnKBuypq_jP7lA>
    <xme:lorPZbMcgVdUTNuNBKOs2SKK8sgGmp9ACIR3wKV0hIuvpwvfqz_XG92Co22iYBptD
    gP9KgELXsaLK5sYJCk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:lorPZWhiJuidpQzNpkULB5-DFy3t-csTNIU2O1WqhV1C06dHH3kcsA>
    <xmx:lorPZW_ChIESkKfG6YPEcmCcNfHAFFQpTrWc-Vxt2Puq8QAiyyZjIQ>
    <xmx:lorPZZtHzijUqbGFAYpf15ZbV6F3m6iHU9fB6RFEzWruv7xPxxWNjg>
    <xmx:lorPZa85h02KQTLz2PYvq5cPadqXeqblWD63M6CDFKhRMBSwv9FHaQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 76494B6008D; Fri, 16 Feb 2024 11:17:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20c18087-dc18-4671-b4ac-c54f7fe4ad21@app.fastmail.com>
In-Reply-To: <c6290c26-8d06-4032-8599-83556d44687c@paulmck-laptop>
References: <20240216125959.3766309-1-arnd@kernel.org>
 <CAMRc=MdBbzff5BppY4Hjwfi=SnmYopnFxg1AX4QsGt3Y+-g60Q@mail.gmail.com>
 <14ab7b63-b2c0-41e3-8104-da5515b379be@app.fastmail.com>
 <c6290c26-8d06-4032-8599-83556d44687c@paulmck-laptop>
Date: Fri, 16 Feb 2024 17:17:06 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Bartosz Golaszewski" <brgl@bgdev.pl>, "Arnd Bergmann" <arnd@kernel.org>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Kent Gibson" <warthog618@gmail.com>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: cdev: avoid uninitialized variable dereference
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024, at 16:51, Paul E. McKenney wrote:
> On Fri, Feb 16, 2024 at 03:04:14PM +0100, Arnd Bergmann wrote:
>> On Fri, Feb 16, 2024, at 14:19, Bartosz Golaszewski wrote:
>> > On Fri, Feb 16, 2024 at 2:00=E2=80=AFPM Arnd Bergmann <arnd@kernel.=
org> wrote:
>> >>
>> >> From: Arnd Bergmann <arnd@arndb.de>
>> >>
>> >> The 'gc' variable is never set before it gets printed:
>> >>
>> >> drivers/gpio/gpiolib-cdev.c:2802:11: error: variable 'gc' is unini=
tialized when used here [-Werror,-Wuninitialized]
>> >>  2802 |         chip_dbg(gc, "added GPIO chardev (%d:%d)\n", MAJOR=
(devt), gdev->id);
>> >>       |                  ^~
>> >> drivers/gpio/gpiolib.h:277:11: note: expanded from macro 'chip_dbg'
>> >>   277 |         dev_dbg(&gc->gpiodev->dev, "(%s): " fmt, gc->label=
, ##__VA_ARGS__)
>> >>       |                  ^~
>> >>
>> >> Use dev_dbg() directly.
>> >>
>> >> Fixes: 8574b5b47610 ("gpio: cdev: use correct pointer accessors wi=
th SRCU")
>> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> >> ---
>> >
>> > I seem to have beat you to it[1] and my patch doesn't change the log
>> > message so I'll apply it instead of this one.
>>=20
>> Ok, thanks. I thought about doing this, but could not
>> figure out which of the RCU primitives to use.
>
> I will count that as a bug against RCU's documentation, but I am not
> sure how to fix it.  Thoughts?

I didn't really try at all, I just figured I could avoid
thinking about it by using the device pointer at hand.

I'm sure the docs would have told me if I had bothered to look.

     Arnd

