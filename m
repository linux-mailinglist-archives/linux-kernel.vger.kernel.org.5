Return-Path: <linux-kernel+bounces-130761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4D2897CD1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA8F2B279C7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1BD1370;
	Thu,  4 Apr 2024 00:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="hl/hkNBY";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="e8VPkXDX"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8B6641;
	Thu,  4 Apr 2024 00:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712189112; cv=none; b=CKKGHLLBrUs4eAXlcFpMIT59CF7vbKLM61KPleqDqvxaSSipICa+bcZ1MHbE0tC2d6s30z8hMRCjrYmqryZtu4qnNs4x14kHm51p9wn4OJHGuGxBuxlAm2Jbh4S2y3zTd9ZhSVBaGpiwu11hY1Aqv8qSh0g97bB30My+JX3e3BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712189112; c=relaxed/simple;
	bh=SQ0ipV/aFZevRZbQoVb97kEo9SFHmc1vSwZrkDCETOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glc15nyY5lee8BO5lrEFShZ94V+JajZ1TAi/azF9W1lvScCJGEDQTXa/EDskjDzHkfyrRbXUBTJZ1X7a5p+S8INo3HpuUC7WQlPMjo4UCXc4PAcyo48rm8UEjMch+RWPp8SGqeKH/i3MuFe91AtsvT2dMam9Pufs7LWoLcQ1JgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=hl/hkNBY; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=e8VPkXDX; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id B788BC01E; Thu,  4 Apr 2024 01:59:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712188785; bh=iFZ/mkav7pOcjR/ZmvLNwSUTF1RkqX8g6p3bjVc91fA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hl/hkNBYe2+Y9drCuGa4x8Befec3nqnpOcW5Ae+gkUe1Yfnl362IjDCMsRAhkGpbq
	 VZv3j4MiJdUaGleA5pR23ErpEzmks+jcF6F6CroEbw8lIdzmc9Zu9Qzjl9ukvkDZIf
	 dquNfFcHFQ5FObZqA2F5rWBBgeSPAZIV8ShU1vIyQu65wFM7lgmuMLalN4zT/SGT4x
	 mIyFiro7l0svHJgrR/8QgAixaLB32JoQoA9Pe/08/y3mhUBE0TW2C8XEnHxqFpdvsp
	 P/42XzzKvNoHgp5R6sch9K19rgf2X13juNPhNfc9QS1erzH/F+5lALeD6q8wQMRXDg
	 2wd1QkcR9Nx2Q==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 6AEC0C009;
	Thu,  4 Apr 2024 01:59:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712188784; bh=iFZ/mkav7pOcjR/ZmvLNwSUTF1RkqX8g6p3bjVc91fA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e8VPkXDXPCxhgEmzyYcmujNt/d+OvznYyEjMko0x5TdEPt4hJpAmRaSnu/9WyM/lB
	 RGAqKXFH2O46bYHVmC4raMoyqz91r96hKH4VEvJopynCodcr3vfA9XITGfi3NvidYI
	 q6HS7703QJNE1kiJsMYj70qJT23ZMgPlgfZJ0HalJ0UnI04/bjWuDA4iroN4z4+rj6
	 i7/zjiTlQp2fDiCxHShwK1XoGCHvSldb0dPhe8ZQgPifMppKWNBU0xb468WiomiV06
	 mlWJII9+Ci0goASz/OuzV5CHsfsvspU8xAjHkD89Vsx97v7oLvdLF+uyW1U9rFR+Xh
	 eL+8VCpKudrbQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 874626b3;
	Wed, 3 Apr 2024 23:59:36 +0000 (UTC)
Date: Thu, 4 Apr 2024 08:59:21 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the vfs-brauner tree
Message-ID: <Zg3tWULD56chInTG@codewreck.org>
References: <20240404101038.11486a24@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240404101038.11486a24@canb.auug.org.au>

Thanks Stephen!

[off topic, I just spent 10 minutes looking for the list of urls of the
repos merged into linux-next to check that 'vfs-brauner' tree commit as
it doesn't appear to be in next yet, and couldn't find it as there's no
"Merge branch x of ...brauner" commit in next at the moment.
I'm sure it's there somewhere and I didn't look at the right place, but
perhaps a link to such a list could be added to either of the following
(which all describe linux-next to some level):
- https://www.kernel.org/doc/man-pages/linux-next.html
- Documentation/process/howto.rst
- Documentation/process/2.Process.rst
/off topic]


Christian,

Stephen Rothwell wrote on Thu, Apr 04, 2024 at 10:10:38AM +1100:
> [...]
> 528aa74c091d ("9p: Clean up a kdoc warning.")
> 
> These are commit
> [...] 
>   7013482ff594 ("9p/trans_fd: remove Excess kernel-doc comment")
> 
> from the v9fs tree.

Thanks for picking that commit up (assuming you did recently); I've had
it in my tree for a while and should have submitted it for 6.9-rc1 but
the other 9p tree brought a few bugs in at the same time to I had held
it off for safety, but it doesn't really make sense and I should have
sent it a while ago.

I only have a handful of patches so I can send them today/tomorrow if
you drop your's, or I can drop this one here and send the rest
shortly later to avoid further confusion.

Cheers,
-- 
Dominique Martinet | Asmadeus

