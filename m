Return-Path: <linux-kernel+bounces-52211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A641584956D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F50287E02
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81711170E;
	Mon,  5 Feb 2024 08:32:45 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F60111A0;
	Mon,  5 Feb 2024 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707121965; cv=none; b=F/JmmkbEnT0LU9rvlIYZAbrKY+AwU8IzZgnwcjT0IFBVF8ZUsOileq8X5RsuMhfvgbA9vBxdkPekq4bQyY16leLqXJP3dCBJKhzNJor9Tq/uGkQ2lYKldiAEwZZpypJsx1N8KRf5i5mgq4ZS0vvkcsX7zdf/Q/PDrxRVKRbv7Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707121965; c=relaxed/simple;
	bh=cGi0edXAms+gLfEuC09SdCR3GDmLrpY/mp4Jfcdl4RY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=duGW6yix4LPP9Ea3DR07IivCEp24AxyFwlZyZT/4EidXRV1vcCWTg/dwASG4rl8BzUu1w9QubK/6R4uAtJrpPr/2NfPPfiQUO6HcYMagReh8WIEUMOIqb017mmXLz7hgZ59YUp0gaO5sOSIkPn1/FO3gAccBrXlNqi55dvdZxD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rWuP5-0000WV-IQ; Mon, 05 Feb 2024 09:32:35 +0100
Message-ID: <680ab492-8ffb-46a6-ab76-06605954308d@leemhuis.info>
Date: Mon, 5 Feb 2024 09:32:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: More detailed text about bisecting Linux kernel regression --
 request for comments and help
Content-Language: en-US, de-DE
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Linux kernel regressions list <regressions@lists.linux.dev>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Greg KH <gregkh@linuxfoundation.org>,
 Jani Nikula <jani.nikula@linux.intel.com>
References: <c763e15e-e82e-49f8-a540-d211d18768a3@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <c763e15e-e82e-49f8-a540-d211d18768a3@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707121963;a9f84ed4;
X-HE-SMSGID: 1rWuP5-0000WV-IQ

On 24.01.24 13:19, Thorsten Leemhuis wrote:
> Hi! Find below a WIP text on bisecting Linux kernel regressions I plan
> to submit for inclusion in the Linux kernel documentation in a month or
> two. I could do so now, but chose to write this mail instead, as the
> text would really benefit from a few people actually testing the given
> instructions. Hence if you notice somebody that faces a regression that
> needs bisecting, consider poiting them them to this text, asking them to
> play through this and provide feedback to me.
> 
> Ideally point users to the following rendered version:
> https://www.leemhuis.info/files/misc/How%20to%20bisect%20a%20Linux%20kernel%20regression%20%e2%80%94%20The%20Linux%20Kernel%20documentation.html
> 
> It is (a) a lot easier to read (b) has no odd or broken line breaks,
> like the text below has a few (sorry!) (c) is updated when I improve
> something.
> 
> Anyone who might be willing to provide feedback can do so in a reply
> here or by modifying the following document (which for copyright reasons
> is just a copy of the document I use to prepared the text for the actual
> submission):
> https://docs.google.com/document/d/1Im7SPK0j6PUGQTSGZyCTSQv8h3S51EYsZuRRdyhfzto/edit?usp=sharing

TWIMC, I changed a few important things since I wrote above mail. The
most important parts:

* I switched the default flow from "use a shallow clone of linux-stable"
 to "use a full clone of linux-mainline with stable added as remote";
the instructions for shallow clones are now in the reference section, as
it seems that was was some people prefer. Not really happy with that, as
I think the shallow clone stuff was worth it and not that much more
complicated. But whatever, not really unhappy either (maybe I like it a
bit better myself that way, not sure yet). :-D

* I changed a few aspects to make the text properly cover the "verify a
bug is present in mainline" aspect as well, as that's basically the
preparation and segment 1 of the whole process anyway. Not totally sure
if that was a good idea. Maybe having that in a separate copy might have
been better (basically a copy with the segment 2 and 3 removed and a few
small changes), not sure. But that should be easy to realize later.

See above links for details.

Ciao, Thorsten

