Return-Path: <linux-kernel+bounces-104877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5D687D4EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6249A1C21CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E42E54745;
	Fri, 15 Mar 2024 20:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="l7YKrnPi"
Received: from outgoing6.flk.host-h.net (outgoing6.flk.host-h.net [188.40.0.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9261F922;
	Fri, 15 Mar 2024 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710534129; cv=none; b=Ldt2MOOIE+zehiyrIep9r0IPo/Ca9ZLxj/evfJj+maLgUaAYURgfdSDbcrK50efKez2s7UwZGsEhBs2JIUKOekdVz0MLlzRSxq1NVKazeobvmLP4iHT8MtvpA4QLZi06wFh+RGCzHKJVN8xuPXg6fjHpTkBlih7oIXd9Oukm3U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710534129; c=relaxed/simple;
	bh=SJBU7jhfdzTKjoCJ9KMNg06b4IgZL88IQAtDVxAHtJc=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=qXINeT2mU/fH8WU7gI/lZ7P9Ke+sFKsjA5C1XgeFuRZ049big30YTfQelZcps/VSX8rvySPQFYOCCoxvzHGeg64O2xFi3aHFo6xpuZNl/Ka0Mwlbq6Kfj5fkxlt8QLz+wSADxEttOneZj32KmtPLDmRtF+cbeg84KB1XxI7r0fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=l7YKrnPi; arc=none smtp.client-ip=188.40.0.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Message-ID:References:In-Reply-To:Subject:Cc:
	To:From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:reply-to:
	sender:bcc; bh=//uDqZxww2AW+IIRaNpkx7sG+p6lLha2oCwZuquPjaI=; b=l7YKrnPiSty71c
	abFOR8qQpslU+gIwZGk63FdNmEFsrH/KHRm+tGKjIPi198/TPI6drVu901AqP6R5C2HvqvvfuwT8J
	GUE4PljouU3Za8hOUp/qjuF8pc1V796SRxUSEQkjDK1CdGVexJiJ2IKLgmzCWG7kLn4V+9HDBLfNN
	Cv1ivY4oSVH1WOKsj8EYJzDFMnhTZtzpWtLtD+XEF1gQuqiT/52zql2gTndEWvxDmPhToRgLrHbxG
	DGjJ6dM7jREJOeRz74S03BBdlQYQPp6O/gzrPUB4Yr3EDaP9No2rolKwbrlqd1SyX2phJ1h3mM4iC
	MhRL9X4mhX7Qqh3PQavw==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam2-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlE3v-00BbGs-DE; Fri, 15 Mar 2024 22:21:58 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
	by www31.flk1.host-h.net with esmtpa (Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlE3t-0006wR-JO; Fri, 15 Mar 2024 22:21:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Mar 2024 22:21:53 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: Mark Brown <broonie@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] spi: mt7621: allow GPIO chip select lines
In-Reply-To: <6c92fddd-f79b-40b5-bd52-61f43d6a7591@sirena.org.uk>
References: <20240315015708.13948-1-justin.swartz@risingedge.co.za>
 <d562be73-ad76-4450-8bff-38ed5d144714@sirena.org.uk>
 <2dbc59c9133542f6f8bc465113d9630b@risingedge.co.za>
 <6c92fddd-f79b-40b5-bd52-61f43d6a7591@sirena.org.uk>
Message-ID: <55c5f2e0723c18384c781e87985f0d22@risingedge.co.za>
X-Sender: justin.swartz@risingedge.co.za
User-Agent: Roundcube Webmail/1.3.17
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.27)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9/WeCzYiIeYgp7jnAlgaiTPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIss2oH4Yjh6Q4paNNh70vrmKlRYN8+ZW0XX0AH/7tz8lOUWMR
 3Oz/N19DDfqg//ykQCB4rUl3suKct8rEwEjtlBjGf82vsPPH4Z6bBeyJ2ioKLll7c1zqbZ0Shnfk
 f76m6WzjgyOQ30CX3jGye0AgO43dPg2t4siixN3H6ipUQpunbVFFkQUmxUqPs0MXBr9YWmuNA8WT
 ybi1JN85FSnfKaZl5e9CnNR0t//S8nh6vX9JR7tTkgtGxbJXMnaWeORi/IOL8hFK8UwSRsjj826v
 xIvoo9siXVea4yN8+JzC4p2qtoJeAaAIM5zNlwLSz7WsotxMDYRAzuCR0I/uZN17IfdXFZsEUcDk
 8TfE1VxuxGc2M4JzCc//R6Wyn0xEa4/gbKRUuwP9TxU53J++//mag2wVXO50BuTihrUiUr+Ne0YD
 3ddZG295JphtZpms9X0aBNANCxNWMmHXUTEMGGbKThOghFKJuzFdJ78lk25pCKnYrhUnk1aI/tYo
 PYfrgLItviC2z3vIzjh1mXBwO7cA3LYE//971/IPrjStHq+sLtv6f48W6vJ1YXzwg/yHdBoe6D9l
 C5HcnR5sMHCtNqaTmXQ4BkBE3IhMX1f/+suluw5k87r8vepAOoS2eUqUWS3rIOs6OFebJBWcGqKs
 Jc1xjt6Txl9yx/3BhqO3m5yd2tj74O4hBSz/kkmPgL+fgIguflsMx6vatUpjecZPSp26CgsDSXR1
 fPypOcxCjKydCywXfmGZydDD5rCF2+ouUHmW4q/WKvSWBPzknbkTJiNN9rwBJkpKiGGp8ai4iv7H
 Q04RFZ4oobg8BBg3Jq+ntzj0FowsI0DXck/yx+ZVYiqsOvAPPsA1Nn6T/CCq0ZTp7nHDepoBD+am
 da0wp7qBc46yuh1ul0jVKCFNLf38tcIOJVFfEoXm0/FPF8PR0w363llwyMFXKarlqLFqhfrB0GFR
 NCI72pnwdS+UMZgGNjw2gmyaDtrWPzIOQpV3d9KAZvFEy4yZs8FnQMzvojpIo6wEKULl9qYjJqeC
 CacQRjWWfmKrLjRFuOfsv9pIlKVsvXNK4117w0+Iu7iq/3ilwajFT6Qh9VybPYnXpWlnmHX0yg==
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

On 2024-03-15 19:47, Mark Brown wrote:
> On Fri, Mar 15, 2024 at 06:23:09PM +0200, Justin Swartz wrote:
>> On 2024-03-15 16:45, Mark Brown wrote:
> 
>> > The core should handle GPIO chip selects for you?
> 
>> As far as I can tell, it doesn't - at least as far the state
>> of spi-mt7621.c is concerned prior to the patch, plus kernel
>> configuration choices, device tree definition, and other
>> factors I might not be taking into account.
> 
>> But maybe I'm doing something wrong, or perhaps have a
>> misconfiguration somewhere. So, if you're able to point out
>> something I've done incorrectly, it would be appreciated.
> 
> Look at other drivers that support GPIO chip selects?

Of the 43 drivers (of drivers/spi/*.c) that setup the
spi_controller's use_gpio_descriptors as true:

   39 drivers use the transfer_one hook, and
    4 drivers use the transfer_one_message hook.

Drivers that use the transfer_one hook benefit from the core
taking care of chip selection on their behalf.

Drivers that use the transfer_one_message hook handle chip
selection on their own, within the function they've pointed
the hook at.

There's comment prior to the declaration of the spi_controller
structure (in include/linux/spi/spi.h) that says the following
about the transfer_one* hooks (beginning at line 493):

  *                    Note: transfer_one and transfer_one_message are 
mutually
  *                    exclusive; when both are set, the generic 
subsystem does
  *                    not call your transfer_one callback.

Considering spi-mt7621.c was implemented using the
transfer_one_message() hook, I'd assumed that it made more
sense to take the approach of determining whether a chip
select was native or GPIO, and then calling a function that
is responsible only for the control over a single type of
chip select to ensure that I was not influencing the previous
native chip select logic in any drastic manner.

To me that seems less intrusive, and allows less room for
potential breakage for existing users of this driver (who
are native chip select users only), than the outright
refactoring of the mt7621_spi_transfer_one_message() function
into an mt7621_spi_transfer_one() function instead.

Based on reading (some of) drivers/spi/spi.c and looking at
cflow-generated callgraph of drivers/spi/spi.c, to determine
where spi_set_cs() and any gpiod_* functions are called,
I believe that only the transfer_one() hook approach leads
to SPI core control of the GPIO chip select lines - via the
core's own spi_transfer_one_message().


>> To attempt to confirm if the core will handle my desired
>> GPIO chip select lines without explicit state toggling,
>> I tried to set the value of use_gpio_descriptors to true,
>> without any other modifications to spi-mt7621.c as of
>> commit 90d35da658da8cff0d4ecbb5113f5fac9d00eb72:
> 
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.

I understand that. The unlabelled commit was:

$ git log | grep -A5 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
commit 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Mar 3 13:02:52 2024 -0800

     Linux 6.8-rc7


> The core needs to know that the GPIO chip selects are there but once it
> knows that they're there things like setting the chip select should 
> just
> work.

This seems to be true for transfer_one() hookers only.

