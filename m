Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275F17B26DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjI1UwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjI1UwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:52:04 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0B919D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:52:02 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c3c8adb27so1790481166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695934320; x=1696539120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSD025Bd0l3//3cTjNFcOYkuWhfB01iv+rUbG/PQuH8=;
        b=j+B71mT7aOXXO4nxQvMTDonv8QOBdTb+I/6nox1ampnFRNDGr0CUKQ3gYctAmA+IeU
         ByycsUprHQDQZzBtkVA/WO7i8EZFLEk/hu8PoI5HRCW8pAJcqCxJupQujIODBG8pqUAJ
         L6eSEqyQR2g21/JUbmW929kCxwm4UZm1XTkG93B2z9KfZQnDqi4+d5K4fOnokRIiR4gt
         nOCn5LzRFPrAnAgAMZL/0++R/5OOWlwpivGpLg4z1IM43w507gF8gTel88yi3E3q3uxf
         TcljVXx4v9aIZvGduxaw58rv4iQk1L0UL2PBcB4RyZHAbDmyfFO05s5s+OhuykyBTDOI
         ngLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695934320; x=1696539120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSD025Bd0l3//3cTjNFcOYkuWhfB01iv+rUbG/PQuH8=;
        b=q/gtaxiFx9e26l8fr4m0e58rIQjWiQ4/HXyfZIwkkL6C79AkWy1UufInbTV96KCGmD
         fgcxGLTqNvRYgdZBPuiKaqrmgmCigE2x2Tz3huEvkVKy9VGYwWe7mZK5+iznwCx+2viI
         XD29ly+YXt1QVQBoaes6rglIhAejh71nEt6RXFPKQ1Xv63Kdhggshkt3mSGPR8JBjV/V
         C+zZ6n3Lr3Srmd7UV3d1IDudirQbZVQxwCRHWEyYyAxcOrmyemQpZdl83sOWtbadYlIU
         YExvgubUPW/ueXGvhZLYn1fAv3Ub5/swmZYLP39An0oZJiutmXuLdlt991Uspe0v1O7T
         +NwQ==
X-Gm-Message-State: AOJu0Yxxh1hNmv/r3SXEkpy6IlstY0wSYtgcts0sWiSF+MZUF+Fc/8dz
        VRdnuC2HN4FcgNRBlMCECjkBGVKXhkU=
X-Google-Smtp-Source: AGHT+IFgIzQ/Xht3PFBOQhCSb6dyI1xES5ctX17cc1t2SebuaoJd618TVcGEt03dBfelV08dcCfjLA==
X-Received: by 2002:a17:906:8a49:b0:99c:e38d:e484 with SMTP id gx9-20020a1709068a4900b0099ce38de484mr2302856ejc.6.1695934320315;
        Thu, 28 Sep 2023 13:52:00 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id qk7-20020a1709077f8700b009b2b4385db7sm2935834ejc.92.2023.09.28.13.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 13:51:59 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 28 Sep 2023 22:51:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Adam Dunlap <acdunlap@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Peter Gonda <pgonda@google.com>,
        David Rientjes <rientjes@google.com>,
        Khalid ElMously <khalid.elmously@canonical.com>,
        Jacob Xu <jacobhxu@google.com>
Subject: Re: [PATCH v2 0/2] x86/sev-es: Resolve early #VC handler UB
Message-ID: <ZRXnbZB3oAijpiQY@gmail.com>
References: <20230912002703.3924521-1-acdunlap@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912002703.3924521-1-acdunlap@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Adam Dunlap <acdunlap@google.com> wrote:

> In v0 of this patch, I mistakenly claimed that
> boot_cpu_data.x86_virt_bits was not getting set to 0 in some
> configurations. However, it is in fact reliably being set to 0 because
> it is specified to be in the .data..read_mostly section, and .data is
> initialized at this point. The boot failures that we were seeing were
> actually due to the gcc 12.3 compiler exploiting the undefined
> behavior to return false from __is_canonical_address when
> boot_cpu_data.x86_virt_bits is 0.
> 
> This patch set applies the 2 changes posted by Dave Hansen: remove the
> UB by explicily checking for 0, and remove the period of time where
> x86_virt_bits may be temporarily set to the wrong value where the #VC
> handler could observe it.
> 
> 
> Adam Dunlap (2):
>   x86/sev-es: Allow copy_from_kernel_nofault in earlier boot
>   x86/sev-es: Only set x86_virt_bits to correct value

I've applied these fixes to tip:x86/mm, thanks!

Note that I switched around the order of patches: we first want
to enhance x86_virt_bits to be reliable, only then do we want to
change copy_from_kernel_nofault_allowed() to be able to rely on it,
to fix early #VC accesses, right?

I also improved the changelogs & titles a bit.

Thanks,

	Ingo
