Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB4F800FCF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379490AbjLAPvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjLAPvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:51:38 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174B81B2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:51:45 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cf4696e202so37909697b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701445904; x=1702050704; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PAeovdGjroVCsGrn3XWTlzE+J+H6t28MAePFWwHrtao=;
        b=V2ebkIoaA/4sdJFwyLW2bytuo8aTOTSk7eVqD7uHr94dXRp1UCU1yiLM/dP5jCTZMl
         uBMpO9uyfyQ9xdyp2H0cgX3BI5Yq+60r9GqCV9yhtm/ofDfy5e63xpBibB4H5DCRtFPm
         ZQaDmW4rfj5P3MY1vC7TfhzCPYdqfB3Uc90mm1jfr5MlhdlsRO4owFE0Rt9uZjZLrBZx
         TBH5uro7GP2O3UhKw+bpBltr1f9wnzdhyTjYdhqfGlkYurkT8O0cwHP1DubybnCFhBLB
         6w7XFj4YqXb36SAmRYcQUwM+EutujCXuQn1cMVBIb0vjWM5tCHwR9bg/EstaPX6BQ46u
         B0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701445904; x=1702050704;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PAeovdGjroVCsGrn3XWTlzE+J+H6t28MAePFWwHrtao=;
        b=oeLiefzn0T3QQkxtVVyxPkzffm/etHg2hbSQvbN0y6OhzXgXp+/z1pkrXs4z5enl0/
         hlnpo+9bz8c6T4VT/6jCBO6NWfBSnf47eUjN4FwTdJn3HgfuE/nKYiiTHt340hB266fC
         WNyeToMWbY3RCzk+ogQhcVrexZb+Ma+rNy73tArYCRbCW1I325gY5d09aNEm8lZ7w4eJ
         9ZYTj02RXzzvEaiuIgQllGPo2fR1WCDkSayD5kY2qxCLCHDFzvGtOCvYuDJjoJPIPDH0
         id/lGTiB3nnbqRU07VkuMrObvpO9swDQgMI+xYjS9gwD0o580OeUNkdTYwR3C7CipYvk
         N3sw==
X-Gm-Message-State: AOJu0YzFbqDYzDvp5fcYooP1KxzKXpv4c63qPHD26/XUCFehIsWE126p
        BUz1REKFyXv1dDaODTP/g85Gm7igX74=
X-Google-Smtp-Source: AGHT+IF/BSqTj5Ow5+rxN/Ku1lgO8NWN9bOrodXJa+C378+RoNDDmNhF1Gt7nscSQbypYDY/mLQOj3BB6X8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:fc1:b0:5d3:7ed5:dfc5 with SMTP id
 dg1-20020a05690c0fc100b005d37ed5dfc5mr198619ywb.9.1701445904264; Fri, 01 Dec
 2023 07:51:44 -0800 (PST)
Date:   Fri, 1 Dec 2023 07:51:42 -0800
In-Reply-To: <20231201142539.7519d330@canb.auug.org.au>
Mime-Version: 1.0
References: <20231201142539.7519d330@canb.auug.org.au>
Message-ID: <ZWoBDsMOOzYsIbLh@google.com>
Subject: Re: linux-next: Fixes tag needs some work in the kvm-x86 tree
From:   Sean Christopherson <seanjc@google.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Matlack <dmatlack@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   7cd1bf039eeb ("KVM: x86/mmu: Fix off-by-1 when splitting huge pages during CLEAR")
> 
> Fixes tag
> 
>   Fixes: f2928aae8b9a ("UPSTREAM: KVM: x86/mmu: Split huge pages mapped by the TDP MMU during KVM_CLEAR_DIRTY_LOG")

Ugh, my eyes glossed right over that.

> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: cb00a70bd4b7 ("KVM: x86/mmu: Split huge pages mapped by the TDP MMU during KVM_CLEAR_DIRTY_LOG")

Yep, that's the one.  I'll force push asap.

Thanks Stephen!
