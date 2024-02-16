Return-Path: <linux-kernel+bounces-69147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C694F858511
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC961F22E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E410E1350E3;
	Fri, 16 Feb 2024 18:25:35 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E25C131722;
	Fri, 16 Feb 2024 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107935; cv=none; b=LMHQyli+UlLVheAbiqrA+hceCd9s+i+tSbzsaSrXKrXBYrMi5QwckZMylOET8SzGnZh40X7g6S+x12Bul0+HDRG3PX/vam4tlLvALNldngTbKajf+59EelAwy1biBBw/P/oXCC/Sd1CVYBRxSOjKsnceNVLX5g8JF4j0Q0PVG5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107935; c=relaxed/simple;
	bh=kIkgK71iz07GCR0FVYa+wZExsN8ozSUAm/msq7WJ/Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/uFCBe23pCBXvrz2917A21CPxSxhrliBdCS3h6dLRfkcPOZZHhLBaD5Kb7a939VwbPoGR/x4e/O+qtD+bjr9zezflBBDu1M3yGbpmAfcDnHVQEeYDDD5gOVJyVd5HvF9zO79xkRseTT6AJJyNowZgWQdcZ/VloC4H2rJgxaxvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tc0Mj5r3jz9ybwR;
	Sat, 17 Feb 2024 02:10:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 877641405A1;
	Sat, 17 Feb 2024 02:25:20 +0800 (CST)
Received: from [10.45.150.70] (unknown [10.45.150.70])
	by APP1 (Coremail) with SMTP id LxC2BwC3rhd6qM9ldImiAg--.12363S2;
	Fri, 16 Feb 2024 19:25:19 +0100 (CET)
Message-ID: <33a1fae4-d713-4e93-89ff-ff9f377e8391@huaweicloud.com>
Date: Fri, 16 Feb 2024 19:24:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/8] PGP key parser using SandBox Mode
To: Jonathan Corbet <corbet@lwn.net>, =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?=
 <petr@tesarici.cz>, Dave Hansen <dave.hansen@intel.com>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Xin Li <xin3.li@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Kees Cook <keescook@chromium.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Pengfei Xu <pengfei.xu@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ze Gao <zegao2021@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Brian Gerst <brgerst@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <jroedel@suse.de>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Tina Zhang <tina.zhang@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, David Howells
 <dhowells@redhat.com>, Petr Tesarik <petr.tesarik1@huawei-partners.com>,
 jannh@google.com, linux-security-module@vger.kernel.org
References: <fb4a40c7-af9a-406a-95ab-406595f3ffe5@intel.com>
 <20240216152435.1575-1-petrtesarik@huaweicloud.com>
 <c65eb8f1-2903-4043-a3ab-945d880043b5@intel.com>
 <20240216170805.0d0decd5@meshulam.tesarici.cz> <87y1bktjdk.fsf@meer.lwn.net>
Content-Language: en-US
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <87y1bktjdk.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwC3rhd6qM9ldImiAg--.12363S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4UGw18Kw47WrykZr4UXFb_yoW8tFyrpF
	4YvFZ0yF4DG3Z2ywn7ur1xua48ZwnxXay3ArnFg3yrAwn8ur18A3ySgr4avasrtrsa93y2
	vryYqFyjka9rA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	J73DUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBF1jj5puTQAAsC

On 2/16/2024 6:21 PM, Jonathan Corbet wrote:
> Petr Tesařík <petr@tesarici.cz> writes:
> 
>> On Fri, 16 Feb 2024 07:38:30 -0800
>> Dave Hansen <dave.hansen@intel.com> wrote:
>>> I'm confused by this.  The kernel doesn't (appear to) have a PGP parser
>>> today.  So are you saying that it *should* have one and it's only
>>> feasible if its confined in a sandbox?
>>
>> I'm sorry if this is confusing. Yes, your understanding is correct.
>> This patch series demonstrates that SBM (even in the initial version
>> that was submitted) allows to write a PGP parser which can survive
>> memory safety bugs withoug compromising the rest of the kernel.
> 
> So I have a different question: some years ago we added the "usermode
> blob" feature for just this kind of use case - parsing firewall rules at
> the time.  It has never been used for that, but it's still there in
> kernel/usermode_driver.c.  Is there a reason why this existing
> functionality can't be used for tasks like PGP parsing as well?

Yes, it was an option I explored last year (briefly talked about it as a 
BoF at LSS NA 2023).

You are right, there is such feature that seemed to fit well.

User space blob embedded in a kernel module, so signed. User space 
process connected only to the kernel through a pipe.

I even went ahead, and created a framework:

https://lore.kernel.org/linux-kernel/20230317145240.363908-1-roberto.sassu@huaweicloud.com/

so that anyone can implement similar use cases.

The further step is: how can I ensure that the process launched by the 
kernel is not attacked by root (which I assumed to be less powerful than 
the kernel in a locked-down system).

I handled this in both directions:

- The process launched by the kernel is under a seccomp strict profile,
   and can only read/write through the pipe created by the kernel (and
   call few other system calls, such as exit()). Otherwise it is killed.
   Cannot create any new communication channel.

- I created an LSM that denies any attempt to ptrace/signal to the
   process launched by the kernel. Jann Horn also suggested to make the
   process non-swappable.

However, despite these attempts, security people don't feel confident on 
offloading a kernel workload outside the kernel.

This is why this work started.

Roberto


