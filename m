Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EA1801642
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441829AbjLAWYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAWYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:24:02 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284A710D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 14:24:09 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5aaae6f46e1so1196265a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 14:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701469448; x=1702074248; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/EaOyG2WIzsmtRAtj27ai8on7XhQQ3gj4a4UXCtq+eI=;
        b=xAKRMNyAvhsdmdwsxirPecuic9+vA3FGhqgLEEGD66zfKFy1JE6KnXdXVebXGH6kTI
         +bW319xynRBprHz49TYRt9f8VxgZt6C6zy7bvx9kyXJD7cMNws8GDnyJjZNa9FzM7v/f
         JRZbwdRgpCK/OCO/64BEwZOYl404E17RJ4BWzDM1yQm3eaCyeLAuNzI+22jyrYFk8j5d
         5XPMUL/gfkpfPDdkcbvD288nftmQ6USSewEbkwR1RFm87YpRIbdpRqD40RKNYSynCqq4
         K4tmixrgjYgmD/iwPM77JQhLTMwoo5TUy+JkRV3W/E9hAHKYyaYpVQnEJyuKo64FEYmv
         SKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701469448; x=1702074248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/EaOyG2WIzsmtRAtj27ai8on7XhQQ3gj4a4UXCtq+eI=;
        b=GYAJETbjQq09cY2lJQl+da90lceRQlXMXmMfWXjJn90x+t7ZgpgpTQgf8FxxqsOw7s
         sre15ZfBxthZ3GpPbf3+FNUSNc36yTeWHLQSBLKPhKXkblfi2gFWk2myLIZCTfxn8zrc
         VURkZZBAhHwFfBpoZ2WhvTk+0C7dRG16Ua3IpIJ0iEn6pZTh+FH8DHJZ6B84UM5Gbqlc
         BID8lq+cmna3KHyMJkjZM2TvpisQrZSlxM/RGEDkiq+5hL9xqkLOU/0/S8nl4N74/tyH
         LQl6OLEhVSpBLufuNArdJagsb/NhDsWVs3mhs/69VoAUTvs+8hhYPz9ntwaRFDdhnyc8
         QouQ==
X-Gm-Message-State: AOJu0YwJq8cWURdEJeSD/Ue3D5bmV1I5wFALVZ7h/CQyHbWYrLSIPVsA
        hlJ3TNiSHWOcTCUnvw/tabMF3l/skxA=
X-Google-Smtp-Source: AGHT+IHBKsIe10IjUhxcQAtfYEI4/8c1//xFBlfVjKfiL+tnaRnVczW5eRuthcqEdiVgakMe8USSUyiLSyo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:1402:0:b0:5bd:bcde:c677 with SMTP id
 u2-20020a631402000000b005bdbcdec677mr4120679pgl.2.1701469448566; Fri, 01 Dec
 2023 14:24:08 -0800 (PST)
Date:   Fri, 1 Dec 2023 14:24:06 -0800
In-Reply-To: <20231129153250.3105359-1-arnd@kernel.org>
Mime-Version: 1.0
References: <20231129153250.3105359-1-arnd@kernel.org>
Message-ID: <ZWpdBtj8RIB8m_jD@google.com>
Subject: Re: [PATCH] KVM: guest-memfd: fix unused-function warning
From:   Sean Christopherson <seanjc@google.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With migration disabled, one function becomes unused:
> 
> virt/kvm/guest_memfd.c:262:12: error: 'kvm_gmem_migrate_folio' defined but not used [-Werror=unused-function]
>   262 | static int kvm_gmem_migrate_folio(struct address_space *mapping,
>       |            ^~~~~~~~~~~~~~~~~~~~~~
> 
> Replace the #ifdef around the reference with a corresponding PTR_IF() check
> that lets the compiler know how it is otherwise used.
> 
> Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  virt/kvm/guest_memfd.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 16d58806e913..1a0355b95379 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -301,9 +301,8 @@ static int kvm_gmem_error_folio(struct address_space *mapping,
>  
>  static const struct address_space_operations kvm_gmem_aops = {
>  	.dirty_folio = noop_dirty_folio,
> -#ifdef CONFIG_MIGRATION
> -	.migrate_folio	= kvm_gmem_migrate_folio,
> -#endif
> +	.migrate_folio = PTR_IF(IS_ENABLED(CONFIG_MIGRATION),
> +				kvm_gmem_migrate_folio),

I'd much prefer to just delete the #ifdef, e.g. so that we don't somehow end up
running fallback_migrate_folio().  I have no clue why I wrapped the hook with
CONFIG_MIGRATION.
