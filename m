Return-Path: <linux-kernel+bounces-134172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CDC89AE9B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 06:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173131C22115
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 04:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37CA1879;
	Sun,  7 Apr 2024 04:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xfgOrlJI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q6YUqoR1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SxSc0Nzi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MDTGqn+l"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD88A35
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 04:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712465522; cv=none; b=IpNh4hh9AyXQPLIRezgJ6U7Evrqnxxd6MGUGQsSQlPoJHKzyMwLVL+LA2ufO4+IcawI3HPo2nLxLeIcYzVzEuGppsl3eLIBgHT/4/iStL+PgGsUJBPHP/iQ+C50PoaLLGjDMc0F9w/Wy7u8BBVBA5JUgc5EQgUgmopK3Qa9MlvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712465522; c=relaxed/simple;
	bh=8cyo8L0GhE9DQ/ubrE0w2ks7IUFrZQw5ljpsc1FWl4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cu+3mzkNlZADkOjqHk/k9X0hqdGnB+DvH+pzU2KKs9Sw/c+Kj3brL0hWHot06mvIJjof4DmDY8xTt/crIiOmdZV8bjrmOvVjaH8dVq/jFkBJ3iFajq31GhMqRHyEIORNwlPcE26+I66MbGxJpQCNtiEGfyXq6HFlOEsmIKOVtr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xfgOrlJI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q6YUqoR1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SxSc0Nzi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MDTGqn+l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D89221B12;
	Sun,  7 Apr 2024 04:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712465518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TOC31N0dUOY57cqlivIP5Wt1ycysMDUSGgir8PPvt98=;
	b=xfgOrlJID0g/nHPtrmPZ96OM3qgpzum4nHDfrosR5/jtNkGb/mxdXBuH0I9R+4DByJaBUy
	8O9Fj+uJicQ2TWz8Te7vpumnJH5tYH+z5CW0FSs3ChWnF4ih5jDi6e9p4wSmcQKp1V23kU
	rUv8hP8JeH45W6+PH5ZWFsU2YMKaZt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712465518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TOC31N0dUOY57cqlivIP5Wt1ycysMDUSGgir8PPvt98=;
	b=Q6YUqoR1A+5sAH+FvWzsn+xbX7vgZLrrqCDZP9PQIud9UudaZxlhaoxtjioyLj8n62rM/Q
	qiI9UeApFZ8jZcBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SxSc0Nzi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MDTGqn+l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712465517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TOC31N0dUOY57cqlivIP5Wt1ycysMDUSGgir8PPvt98=;
	b=SxSc0NzixFvARdW/eNzWfg7k1mih2NPOl6Idm0efJNYYxbVFp2JFkIWyfWFdbaDFLdYo9p
	kg8hBxb+CtQLBmS4okSnmTo1+jY9fEFRH74sXd1456RAIkdN9cjyh0XQixDBScM8dVMtLo
	n8Y+s+8luDySDrc18z4UrQr3VQOoSRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712465517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TOC31N0dUOY57cqlivIP5Wt1ycysMDUSGgir8PPvt98=;
	b=MDTGqn+lES5vnX7xHbDoxgQJu5tf68v7a4lx0SZvNUkNRv1FB/DbSUOI2sOoaiwyl/C8a+
	jz4v2FzGfetDmHDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 06970132FF;
	Sun,  7 Apr 2024 04:51:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id UNIeOmwmEmZhDwAAn2gu4w
	(envelope-from <osalvador@suse.de>); Sun, 07 Apr 2024 04:51:56 +0000
Date: Sun, 7 Apr 2024 06:51:51 +0200
From: Oscar Salvador <osalvador@suse.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Machine check recovery broken in v6.9-rc1
Message-ID: <ZhImZwKhp-CZ0MFN@localhost.localdomain>
References: <Zg8kLSl2yAlA3o5D@agluck-desk3>
 <1e943439-6044-4aa4-8c41-747e9e4dca27@redhat.com>
 <SJ1PR11MB6083AB3E55B7DE0D3FBE185EFC032@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZhCQPwgMWo9w3LlO@agluck-desk3>
 <ZhCxAZy-Iuz2XR7A@localhost.localdomain>
 <ZhDHh_W1WZuFhsfg@localhost.localdomain>
 <ZhDMBZ2I9M72D87F@localhost.localdomain>
 <SJ1PR11MB608323D7E6113B78A35F4999FC012@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608323D7E6113B78A35F4999FC012@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:dkim,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8D89221B12
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.51

On Sun, Apr 07, 2024 at 12:08:30AM +0000, Luck, Tony wrote:
> Oscar.
> 
> Both the 6.1 and 6.9-rc2 patches make the BUG (and subsequent issues) go away.

Thanks for the switf test Tony!

> Here's what's happening.
> 
> When the machine check occurs there's a scramble from various subsystems
> to report the memory error.
> 
> ghes_do_memory_failure() calls memory_failure_queue() which later
> calls memory_failure() from a kernel thread. Side note: this happens TWICE
> for each error. Not sure yet if this is a BIOS issue logging more than once.
> or some Linux issues in acpi/apei/ghes.c code.
> 
> uc_decode_notifier() [called from a different kernel thread] also calls
> do_memory_failure()
> 
> Finally kill_me_maybe() [called from task_work on return to the application
> when returning from the machine check handler] also calls memory_failure()
> 
> do_memory_failure() is somewhat prepared for multiple reports of the same
> error. It uses an atomic test and set operation to mark the page as poisoned.
> 
> First called to report the error does all the real work. Late arrivals take a
> shorter path, but may still take some action(s) depending on the "flags"
> passed in:
> 
>         if (TestSetPageHWPoison(p)) {
>                 pr_err("%#lx: already hardware poisoned\n", pfn);
>                 res = -EHWPOISON;
>                 if (flags & MF_ACTION_REQUIRED)
>                         res = kill_accessing_process(current, pfn, flags);
>                 if (flags & MF_COUNT_INCREASED)
>                         put_page(p);
>                 goto unlock_mutex;
>         }

Thanks for the detailed explanation.

> In this case the last to arrive has MF_ACTION_REQUIRED set, so calls
> kill_accessing_process() ... which is in the stack trace that led to the:
> 
>    kernel BUG at include/linux/swapops.h:88!
> 
> I'm not sure that I fully understand your patch. I guess that it is making sure to
> handle the case that the page has already been marked as poisoned?

Basically what is happening is:

1) We mark the page as HWPoison
2) We see that the page is mapped by someone
3) We try to unmap it, and in the process we create a hwpoison swap entry.
   See the following chunk from try_to_unmap_one():

   "
    if (PageHWPoison(subpage) && (flags & TTU_HWPOISON)) {
            pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
            if (folio_test_hugetlb(folio)) {
                    hugetlb_count_sub(folio_nr_pages(folio), mm);
                    set_huge_pte_at(mm, address, pvmw.pte, pteval,
                                    hsz);
            } else {
                    dec_mm_counter(mm, mm_counter(folio));
                    set_pte_at(mm, address, pvmw.pte, pteval);
            }
	    ...
    }
   "
4) Now there is a second memory event (maybe the previous one has
   already finished, I do not think it matters for the sake of this
   problem)
5) The second event sees that the page has already been marked as
   HWPoison but since it has MF_ACTION_REQUIRED specified, it
   goes to kill_accessing_process() to do what its name says.
6) We walk the page tables of the accessing process to see if it has
   the poisoned pfn.
7) check_hwpoisoned_entry()
   (which is called from
   walk_page_range()->walk_{pgd,p4d,pud,pmd}_range()->ops->pmd_entry())
   checks whether any of the ptes is poisoned.
8) Since the previous MCE event unmapped the page, pte_present() == 0,
   so we want to get the swap entry, and this is where it falls off the
   cliff.
   See check_hwpoisoned_entry()

   static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
                                     unsigned long poisoned_pfn, struct to_kill *tk)
   {
          unsigned long pfn = 0;

          if (pte_present(pte)) {
                  pfn = pte_pfn(pte);
          } else {
                  swp_entry_t swp = pte_to_swp_entry(pte);

                  if (is_hwpoison_entry(swp))
			pfn = swp_offset_pfn(swp);
         }
	 ...
   }

is_hwpoison_entry() returns true (remember the make_hwpoison_entry()
call we did?)
But when we try to get the pfn from the swap entry, we stumble upon the
VM_BUG_ON(), because is_pfn_swap_entry() only checks for:
 is_migration_entry()
 is_device_private_entry()
 is_device_exclusive_entry()

but it should also check for is_hwpoison_entry().
Since it does not, is_pfn_swap_entry() returns false in our case,
leading to the VM_BUG_ON.

Note that this should only matter in environments where CONFIG_DEBUG_VM
is set.

I hope I shed some light in here.

> Anyway ... thanks for the quick fix. I hope the above helps write a good
> commit message to get this applied and backported to stable.
> 
> Tested-by: Tony Luck <tony.luck@intel.com>

Thanks again Tony, much appreciated.

I will write the patch and most likely send it out either today in the
afternoon or tomorrow early in the
morning.


-- 
Oscar Salvador
SUSE Labs

