Return-Path: <linux-kernel+bounces-45498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E76A84318F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55BD11F24D62
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3C17995C;
	Tue, 30 Jan 2024 23:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="iPYjb+MK"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF21C79949;
	Tue, 30 Jan 2024 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706658475; cv=none; b=E8UDGp+63wSOOuWPrwkgT93W/A5YjUWFApQnZEDNXppDuYEeG2i4PnnkiI/krSnYpua01wHXOWe6W0iqLNJxJjaAGzj4p9EnjCb7Wq8OWloV6NgrGFZR0SvZTWOcwblFeTenpmT/+0umE17q3NGZI1XXLDTKmKvHUjfVXdsjxOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706658475; c=relaxed/simple;
	bh=gctvI4c91ZSe947+t3hshpyres3oHGTht00pgMABwFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qtPvtqAwATnnGWmlJw26pEeDGH5dvxG/4/QXfyffbzi5dcU5LSfIdVbL4jPpN+hRf4bMme03bMDP03CraHZhltr/YhSZ8TfF3zPHAtJt/rDnroFjnusSIl7EGwwwImMn64hEftjSwyoeOYRwR9TS6gEHMG923ufDujC0KaKpdsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=iPYjb+MK; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 49EC341A47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706658467; bh=YSz7eSIovPWVPhBp2QrZNSSUITddjIeIoqMEKbJWRGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iPYjb+MKZtw+jS8PLorMz2kanellKAa+RfVkuG7ywSujVT8Ed4wJSZZckc3LBv3mp
	 tvtgGJiIF3eSsevqCmoF/+VXNXN+l40A3WDqvy0FWTBMw9mV1erUDggnbmQOBW6fQz
	 1FFR1bvpagKpWyTX3vM80tEZiwXgPTjHlnBzkXOIku85AP947u+MGkgqxvmyeF2JB+
	 DFWTcuCSVCJO1ubG71SDpLPJgUMERTwmi2bzheJZY9Fa2VKQfximKhPK6xu4eKAUcz
	 Sa3ru1yGlyIsSKkPtTD2eP0IffxnmzkGpeFFVG4mw85ZXrnVp5BVogQdczgDoSCKr1
	 osUsjZNz//Hbg==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 49EC341A47;
	Tue, 30 Jan 2024 23:47:47 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Rothwell
 <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Udipto Goswami <quic_ugoswami@quicinc.com>
Subject: Re: linux-next: manual merge of the jc_docs tree with the
 usb.current tree
In-Reply-To: <2024013009-helium-woozy-c6c2@gregkh>
References: <20240131095231.292911c3@canb.auug.org.au>
 <2024013009-helium-woozy-c6c2@gregkh>
Date: Tue, 30 Jan 2024 16:47:46 -0700
Message-ID: <87le868jtp.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Wed, Jan 31, 2024 at 09:52:31AM +1100, Stephen Rothwell wrote:
>> Hi all,
>> 
>> Today's linux-next merge of the jc_docs tree got a conflict in:
>> 
>>   Documentation/usb/gadget-testing.rst
>> 
>> between commit:
>> 
>>   20d03ae36ec0 ("usb: gadget: ncm: Fix indentations in documentation of NCM section")
>> 
>> from the usb.current tree and commit:
>> 
>>   e49bf650ab5b ("usb: gadget: fix max_segment_size malformed table")
>> 
>> from the jc_docs tree.
>> 
>> I fixed it up (these commits fix the same problem, I used the former) and
>> can carry the fix as necessary. This is now fixed as far as linux-next
>> is concerned, but any non trivial conflicts should be mentioned to your
>> upstream maintainer when your tree is submitted for merging.  You may
>> also want to consider cooperating with the maintainer of the conflicting
>> tree to minimise any particularly complex conflicts.
>
> Fixup sounds good, thanks!

OK, fine, I'll drop the patch out of docs-next.

Thanks,

jon

