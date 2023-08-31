Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383C078F348
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345995AbjHaT0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjHaT03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:26:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165F81BF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:26:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7814efcccbso1066661276.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693509986; x=1694114786; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g6Tf3ZAjz5BRxqYmSOmi3DFQDfVDfYaSY76D6qeC9yM=;
        b=prWdRNlrHbuDnVYQvJbbzFEynY/Jr5XkGcV6GHNmAWPMTH68ynv7sHKD7PeFWsTP4J
         x5bZWo1U9WS7zyLobPpxw8+ic4zaTvy1qyidIrheJLVm05HhTcJoRmrE/iS73OUMt9M4
         XnV1zrtIybohnvWfvPxsTvtABHb3XIWVHH/y96d07t1LZDz9u1qEY1dtC4FQBZ+DaaO+
         RZczjM3/a0OCqdyQKBhTgyep0YcqJLC4c8NtK26O1USe2WKCAEr1Tw7d+GOG362Lbgiv
         /ZLXmqixBJDBHZcERoE6Wdl9BTKCktEjGNMH2sjPAUUrKz6wfhAm8HPSIcp7MPaZyen5
         L5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693509986; x=1694114786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6Tf3ZAjz5BRxqYmSOmi3DFQDfVDfYaSY76D6qeC9yM=;
        b=JnT4qkW0F3Fyhi89pw/bFLneUSGIeEiq7n22+lTkylBaet6eXCNvi8xZENi8jPHjbi
         eOMcsAP4J1W5OYe1yvvNRexkQfns6T5T9gOHHpXs901tbzy5VzihFH/h1u62TC3PvXTp
         lP3NKjIBJtZral0OK4bGb2QC3aER3Iyo/DmQr3QNgmOqbvZ2rQNY5VHZIWSMxNVX8wWh
         wwde8aXbG8oi8IbfqlUN55SuXzZtHQFOu03RL42XmNuS8vYbzk5uCLMSkB017iOz8GhY
         SZcTmvU7TrhtyOiL2memM/1feRHtFdG5ZrF8OphoB+yUcplUO5uUhkKUj8+8gXWaSvRT
         vOiA==
X-Gm-Message-State: AOJu0Yz1sk2bEfMbe0r/v+1CnbhQzz081VlNdIsC936Jp472/y9KKcbA
        RzlJVDJBRvaX/pgOBKIFBkifiyF1bwg=
X-Google-Smtp-Source: AGHT+IH8M0VYP2jot5+095k6ObFx+ZWf24y1Sxn22pYWebzpMsn5f2iAMF3TVhv2FinHGqonFYaHnN5B71s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:bb12:0:b0:d7a:6a4c:b657 with SMTP id
 z18-20020a25bb12000000b00d7a6a4cb657mr22072ybg.0.1693509986347; Thu, 31 Aug
 2023 12:26:26 -0700 (PDT)
Date:   Thu, 31 Aug 2023 12:26:24 -0700
In-Reply-To: <7463d8dd-5290-59c0-73bc-68053d6a320a@linux.intel.com>
Mime-Version: 1.0
References: <20230719144131.29052-1-binbin.wu@linux.intel.com>
 <20230719144131.29052-2-binbin.wu@linux.intel.com> <ZN0454peMb3z/0Bg@google.com>
 <7463d8dd-5290-59c0-73bc-68053d6a320a@linux.intel.com>
Message-ID: <ZPDpYGzt0GdDQxEQ@google.com>
Subject: Re: [PATCH v10 1/9] KVM: x86/mmu: Use GENMASK_ULL() to define __PT_BASE_ADDR_MASK
From:   Sean Christopherson <seanjc@google.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, chao.gao@intel.com, kai.huang@intel.com,
        David.Laight@aculab.com, robert.hu@linux.intel.com,
        guang.zeng@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023, Binbin Wu wrote:
> 
> 
> On 8/17/2023 5:00 AM, Sean Christopherson wrote:
> > On Wed, Jul 19, 2023, Binbin Wu wrote:
> > > Use GENMASK_ULL() to define __PT_BASE_ADDR_MASK.
> > Using GENMASK_ULL() is an opportunistic cleanup, it is not the main purpose for
> > this patch.  The main purpose is to extract the maximum theoretical mask for guest
> > MAXPHYADDR so that it can be used to strip bits from CR3.
> > 
> > And rather than bury the actual use in "KVM: x86: Virtualize CR3.LAM_{U48,U57}",
> > I think it makes sense to do the masking in this patch.  That change only becomes
> > _necessary_ when LAM comes along, but it's completely valid without LAM.
> > 
> > That will also provide a place to explain why we decided to unconditionally mask
> > the pgd (it's harmless for 32-bit guests, querying 64-bit mode would be more
> > expensive, and for EPT the mask isn't tied to guest mode).
> OK.
> 
> > And it should also
> > explain that using PT_BASE_ADDR_MASK would actually be wrong (PAE has 64-bit
> > elements _except_ for CR3).
> Hi Sean, I am not sure if I understand it correctly.  Do you mean when KVM
> shadows the page table of guest using 32-bit paging or PAE paging, guest CR3
> is or can be 32 bits for 32-bit paging or PAE paging, so that apply the mask
> to a 32-bit value CR3 "would actually be wrong" ?

It would be technically wrong for PAE paging, as the PTEs themselves are 64 bits,
i.e. PT_BASE_ADDR_MASK would be 51:12, but CR3 is still only 32 bits.  Wouldn't
matter in practice, but I think it's worth calling out that going out of our way
to use PT_BASE_ADDR_MASK wouldn't actually "fix" anything.
