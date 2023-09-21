Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCF87A9E07
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjIUTxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjIUTxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:53:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1144790F28
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318448; x=1726854448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WcLEf00Eqb1E6LPJncnTQV2d5+wdroqiKE95ygxlftk=;
  b=DIEoKc3nr3JMh9ZzHDARjd2xxVtDe+ewEStujonF97dYrX1utLvBtdDS
   LEklICCcSvRABsLg/ZqPbp6VYBrzj8UYRSq+8x7JMTBls11hiwJGF2f1y
   noazlkAgP0RExdIbmiSqxVbJlSLY/PMNaAAjG5jF6nI66gVwDwgLXBoHZ
   r1iPpKlGL9j5hbtJL1GctHNpxVkKtqtxYgJcl84TNcqH/yU9mE4V+V+RC
   ViJ/LFhWQxu3ReuUoc4CZmaWf9cQOKZ9/UWCvqZJ4ws9wGriiS7BEf/8d
   JD9tHJlk5VI6GEmbXefwsNTJueAYbHm77LBcaNSP1FGInuxaTxBTC7L/o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="377858639"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="377858639"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 09:03:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="740706780"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="740706780"
Received: from xwan118-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.51.175])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 09:03:29 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E4B0B109F14; Thu, 21 Sep 2023 19:03:25 +0300 (+03)
Date:   Thu, 21 Sep 2023 19:03:25 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Aaron Lu <aaron.lu@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec@lists.infradead.org, Tom Lendacky <thomas.lendacky@amd.com>,
        x86@kernel.org
Subject: Re: kexec reboot failed due to commit 75d090fd167ac
Message-ID: <20230921160325.g5ei2gfads6deb32@box.shutemov.name>
References: <20230907131409.masxz42ik6u456qp@box.shutemov.name>
 <20230908060230.GA283801@ziqianlu-dell>
 <20230908123233.dpbpohgrbyyxekzk@box.shutemov.name>
 <202309080856.F066F92C98@keescook>
 <CAGnOC3aG9BuoVEGs4LQhhczdhAF0gFBmXR7GXKAf4Z8FPTb1PQ@mail.gmail.com>
 <20230909113209.actnan6hczrclz2d@box.shutemov.name>
 <CALu+AoSKpgbbKmsL8iuWpQB2ANqnhhfXR5pN5m0EsKZeFUBPkw@mail.gmail.com>
 <20230911145707.hslq47ngknshrlyk@box.shutemov.name>
 <20230913142410.dfqsg3l5v44mr5j3@box>
 <91daa8b6-57c2-424f-8c6c-647e05f2a8c9@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91daa8b6-57c2-424f-8c6c-647e05f2a8c9@leemhuis.info>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 11:54:15AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 13.09.23 16:24, Kirill A. Shutemov wrote:
> > On Mon, Sep 11, 2023 at 05:57:07PM +0300, Kirill A. Shutemov wrote:
> >> On Mon, Sep 11, 2023 at 10:56:36PM +0800, Dave Young wrote:
> >>>> early console in extract_kernel
> >>>> input_data: 0x000000807eb433a8
> >>>> input_len: 0x0000000000d26271
> >>>> output: 0x000000807b000000
> >>>> output_len: 0x0000000004800c10
> >>>> kernel_total_size: 0x0000000003e28000
> >>>> needed_size: 0x0000000004a00000
> >>>> trampoline_32bit: 0x000000000009d000
> >>>>
> >>>> Decompressing Linux... out of pgt_buf in arch/x86/boot/compressed/ident_map_64.c!?
> >>>> pages->pgt_buf_offset: 0x0000000000006000
> >>>> pages->pgt_buf_size: 0x0000000000006000
> >>>>
> >>>> Error: kernel_ident_mapping_init() failed
> > [...]
> >> The problem is not limited to unaccepted memory, it also triggers if we
> >> reach efi_get_rsdp_addr() in the same setup.
> >>
> >> I think we have several problems here.
> > [...]
> >> Any comments?
> > 
> > I struggle to come up with anything better than increasing the constant to
> > a value that "ought to be enough for anybody" ©, let's say 128K.
> > 
> > And we can eliminate logic on no-KASLR vs. KASLR vs. KASLR+VERBOSE_BOOTUP.
> > 
> > Objections?
> 
> Apparently not, as there was no reply since then (which is why I show up
> here, as it looked like fixing this regression stalled).

It has been fixed in upstream by the commit f530ee95b72e
("x86/boot/compressed: Reserve more memory for page tables")

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
