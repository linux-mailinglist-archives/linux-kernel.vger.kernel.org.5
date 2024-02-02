Return-Path: <linux-kernel+bounces-50489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26A58479CA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8508D1F21E14
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C4680607;
	Fri,  2 Feb 2024 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gZ6u0hYq"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE24615E5AE;
	Fri,  2 Feb 2024 19:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706902895; cv=none; b=bX7aSQwfAiUYNjldwaPC0OG6T8pbsn+UkF2YY42nK45qvFD9z1bXSf7fZCCHCO7HGvKIY82W545/SNPzsqCUu2PqrDJ/w93cpMYfSTVxcnCBtjngyvEZOot+JVt6kwhFufN2kLj0JWhu6o5STkbFBvTy3zsNakb9SXe2YZFE70g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706902895; c=relaxed/simple;
	bh=PA6V8qrjOEmRUGi+eQ/RS4oAQjuEZxBHWI8Xka+E70s=;
	h=Message-ID:Date:MIME-Version:In-Reply-To:To:Cc:From:Subject:
	 Content-Type; b=NTirCzr1zhK2zFq3a9n8ICk2Tc9NXv/cWjJeqwgjMkz8NlVS1XpA5u7/6foewbJPZZ9atpKoJCqseIBsxpvRt481maRYEpwbhkYTidaqN4jz7K2xYlHQ6YU5i7ZTpGquFKm3jWjXs4c/J6uuwmJBbJ2yRfkBEV8vNfp0Qrd7mYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gZ6u0hYq; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:
	In-Reply-To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PA6V8qrjOEmRUGi+eQ/RS4oAQjuEZxBHWI8Xka+E70s=; b=gZ6u0hYqRPUgVhYJbVeGYB/L9g
	/Ea5eM3HWDDp2WL/dJ/L2qUe77Z/CuO0U0bqKFNk9R167WtRmTjiWOCRuUarhFKJOL5lhb51L6NYI
	EpMlao2gZByFMHhpXgRbf6n8RspviwcY/LO6pQRwYfDRWvhCu24FkCG1TgZoTqG+pHMGlqW2Ce4KG
	wh2Bis9xuVCJYZulzEejI0c9KYjEF94ULju972kxSHVdFOSJ7KiNH8npvewGwr1F2l9KRtcC3qWit
	kdeaSO1LLofZUqQYqb3Hh+oLtti6W6CDhsHKM0FKi1TNLS3QGY9OCRmatKpL3d8h3mQKKku/YA/uE
	WXyhqkfQ==;
Received: from [187.90.178.235] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rVzPE-00D4dK-2z; Fri, 02 Feb 2024 20:40:56 +0100
Message-ID: <66cb411b-557a-6a70-57c9-457c969fec24@igalia.com>
Date: Fri, 2 Feb 2024 16:40:46 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
In-Reply-To: <000000000000d08921060fe27342@google.com>
To: syzbot+239f12e20785af44332c@syzkaller.appspotmail.com,
 Thomas Gleixner <tglx@linutronix.de>, jannh@google.com
Cc: akpm@linux-foundation.org, Borislav Petkov <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 "luto@kernel.org" <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, syzkaller-bugs@googlegroups.com,
 "x86@kernel.org" <x86@kernel.org>, gpiccoli@igalia.com,
 "Guilherme G. Piccoli" <kernel@gpiccoli.net>, houtao1@huawei.com
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 bpf_probe_read_compat_str
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi folks, I've been trying to play with this report and was able to
reproduce on v6.8-rc2, in a simple qemu VM.

But the thing is: after looking similar reports in MLs, this seems quite
the same report as [0], so a dup. And we even have a candidate fix for
it, in the form of Thomas's patch
(https://lore.kernel.org/all/87r0jwquhv.ffs@tglx/). I've tested this
patch and it works, preventing the crash.

So...

Jann: could you help me confirm the reproducer here is the same of the
other report, in which you nailed it to accessing the VSYSCALL region?
For me it's quite similar, but I'm not experienced in reading this kind
of BPF program...

Thomas: could you maybe re-submit/merge this patch, if you still agree
this is the proper fix? There's a Tested-by from Hou Tao in that thread,
and feel free to add mine as well!

Thanks in advance and let me know if I can test more stuff / provide
more data, etc - I'm glad to help here.
Cheers,


Guilherme


[0] https://lore.kernel.org/all/000000000000c84343060a850bd0@google.com/
("[syzbot] [mm?] BUG: unable to handle kernel paging request in
copy_from_kernel_nofault")

