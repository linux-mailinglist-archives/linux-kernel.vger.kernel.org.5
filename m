Return-Path: <linux-kernel+bounces-130777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1DD897CFC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D7B1F2AB7D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09578139E;
	Thu,  4 Apr 2024 00:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kuLzy2lQ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0763634;
	Thu,  4 Apr 2024 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712190068; cv=none; b=TfwhBEv88e0tx8JzzoQJnAHQvMwbXiFLnl4adOSNJOHYVjqOKuOuCmbVB7KRpuD65Hb8z7/dYoRAprmAJMHp0I05ci8Q7WccTKd74xx8BHzqjRVKsn5wIm/zCwf/45+URykjm/tAzFM4XADipv3tRAGaUe+Zjkt6PgKH1dhKPCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712190068; c=relaxed/simple;
	bh=UFMcrZzd5fY3dI5ggquMLYAhgyCdtiVfSq1hDRf4DT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRYQLr/iNY4ohoCoy2QC0LZnXZ5cW3hm2v8yVuiCYZx36UDX7CkRqDI5C8EXlIWJcrLAlVcJy+A/cPTZ5IUuhVn+euwsOgr8/loTMXdqnkiNHWbCwIGzxQZDZpMh86zyU1zHCFJbmDpWWikma3PecuyU9f/TotAmxLEBfVF5R9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kuLzy2lQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=LC9sqlC4wjJH17+sYVS+YlsViYsTu7cjAusLLak7UB0=; b=kuLzy2lQ74YdxJJ3pL9RaHGel1
	i6H2rf6S1jkwncVuI8g6PgGA3UzG3ismw2nzTg3OYgulbYXTDcWfhBWcc8b6JIyS7f8LiX3mX36IO
	D3IYXCKlVlk6m9fvXrNxY9S1FXqln1o+BtZDL4FQoWmrkX31vmn6uUi+2fVgwP9vkkbPtN0JiyQ6c
	wtohaF/0RAvqcTcp3rjgyQaD8rQgSwroMH6ICXepdLtBO+9L4aNx+9hMDrQYPKA/qDSWpuU2wa/Vg
	yJkKBYZg2ZELMXVaoMrspmQ91FKVDAu94hrn2eylUgUPh0sd/DgokC3f1OpqO/NMiZvutQYeaDZSK
	Fq4pYF7A==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsAqk-00000000kh4-0fPJ;
	Thu, 04 Apr 2024 00:21:02 +0000
Message-ID: <5f56a81b-ac8a-417c-85ad-149f9f64649b@infradead.org>
Date: Wed, 3 Apr 2024 17:21:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: duplicate patches in the vfs-brauner tree
To: Dominique Martinet <asmadeus@codewreck.org>,
 Christian Brauner <brauner@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240404101038.11486a24@canb.auug.org.au>
 <Zg3tWULD56chInTG@codewreck.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Zg3tWULD56chInTG@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dominique,

On 4/3/24 4:59 PM, Dominique Martinet wrote:
> Thanks Stephen!
> 
> [off topic, I just spent 10 minutes looking for the list of urls of the
> repos merged into linux-next to check that 'vfs-brauner' tree commit as
> it doesn't appear to be in next yet, and couldn't find it as there's no
> "Merge branch x of ...brauner" commit in next at the moment.
> I'm sure it's there somewhere and I didn't look at the right place, but
> perhaps a link to such a list could be added to either of the following
> (which all describe linux-next to some level):
> - https://www.kernel.org/doc/man-pages/linux-next.html
> - Documentation/process/howto.rst
> - Documentation/process/2.Process.rst
> /off topic]

If you look in the Next subdir in a linux-next tree, for 20240403 it shows:

vfs-brauner	git	git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git#vfs.all

in the Trees file and in the merge.log file it shows:

Merging vfs-brauner/vfs.all (35c44ac8370a Merge branch 'vfs.mount.api' into vfs.all)
$ git merge -m Merge branch 'vfs.all' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-brauner/vfs.all


HTH.

-- 
#Randy

