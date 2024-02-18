Return-Path: <linux-kernel+bounces-70197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CF185949D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D69B1F22BC9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB21F4C7C;
	Sun, 18 Feb 2024 04:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z8O1bURo"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDCC20EE
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 04:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708230889; cv=none; b=fDR5e1iAb03G/k3WpbI2En63p5nV59MWbF3b6xBne/JnSy+0VHkwO/3E+nXA8zU2XHGZQG7Z4T5Wt68LmjtpC6fuz8MCPuuW31c6ammV9PwGugHt3wRMMJmOtklX/urXrUuKZTbwL4iNqTqElp6kn7N5IdAPUqMVTBM5NEjfWec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708230889; c=relaxed/simple;
	bh=xEDFJrXpt9bKIZAVffndRoKTp/aC6TdJF8+e8iEwqFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=te3/WoAEvg32Erszq6lRH8z2I6VNMmeF3Ar2IO531TqBV5xw+o8lGJXUhwkQtwizAZFUjGa5kW9FedxRYDwkDoW8aQbpSwFPIahRdBJesQ6xOJhkDK5AnerWE6mcuhIOZPmGmSt7DwB2wLQQMZfsWK7pLW9GaFlucEVaNX5rFaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z8O1bURo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=xhzP2ooRFGv5dM/BZzeqRAuYhPFFscK7OUkjtxX4PvI=; b=z8O1bURowNjn3jZ/y8ZipPgnAD
	wcGD5NHu0hKmMFPqeJHhmDEivSswfJzEgMu6V0RMaGwd3iOnlfH55zIIAcovmZOdy9tTEZS3Nvf/Q
	dwXaPaV2DxqpgOQTkPnR/krE8FxSsvGpxKAXwl2jHEdRIu8tzvt44JnSUoenIP00FQThU+L/sH59A
	GTtlD6jXNpv625dFrptwyCNbekybEPgA3ILc12lpzqsnyHUvyMLJ2pq78+J1HC3MHKmN0FMt0dNSm
	OWg6oreEcZnE5AN2juZDEMdnmhIDZgAKTJxmv2+R9qb1xkDnnkY8h8PvXoQlDTBYzHsa1TihIqEtN
	VEdlQXMA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbYt4-00000006zoe-1Sp9;
	Sun, 18 Feb 2024 04:34:46 +0000
Message-ID: <f8a92dd7-8509-428d-8982-4ba94063081c@infradead.org>
Date: Sat, 17 Feb 2024 20:34:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux FS6712X-EB92 5.13.x - page allocation failure followed by a
 controller reset and the drive drops out of the array
Content-Language: en-US
To: Justin Piszcz <jpiszcz@lucidpixels.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <CAO9zADyveGGBNKsD-JFoOeGZ3om3wMhkqvPc2mvxp-yBzk5mrg@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAO9zADyveGGBNKsD-JFoOeGZ3om3wMhkqvPc2mvxp-yBzk5mrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Justin,

On 2/15/24 15:46, Justin Piszcz wrote:
> Hello,
> 
> I am using an Asus FlashStor FS6712X-EB92, and was curious why this
> issue keeps happening?  Is this a known issue in 5.13.x?  The last
> time this happened, I had removed the drive, ran a bunch of
> diagnostics on it and used it in another system and it was okay, no
> errors were found.  This is the second instance where there is a page
> allocation failure and a drive drops out of the array.
> 

I can't answer your question. I suggest that you ask it on the
linux-raid@vger.kernel.org  mailing list.

Also, I have one question:

in this log fragment:

[1698614.263935] SLUB: Unable to allocate memory on node -1,
gfp=0x800(GFP_NOWAIT)
[1698614.271680]   cache: skbuff_head_cache, object size: 224, buffer
size: 256, default order: 0, min order: 0
[1698614.281979]   node 0: slabs: 32, objs: 512, free: 64
[1933116.236646] nvme nvme9: I/O 119 QID 2 timeout, aborting
[1933116.242365] nvme nvme9: I/O 120 QID 2 timeout, aborting
[1933141.324640] nvme nvme9: I/O 1 QID 0 timeout, reset controller
[1933146.444701] nvme nvme9: I/O 119 QID 2 timeout, reset controller
[1933215.826997] nvme nvme9: Device not ready; aborting reset, CSTS=0x1

there are roughly 4 days between the 1698614 log entry and the
1933116 log entry. Is that (logging) accurate? Did it miss anything?
It just seems odd to me.


thanks.
-- 
#Randy

