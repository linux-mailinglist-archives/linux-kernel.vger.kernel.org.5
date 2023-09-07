Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F47797B1C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245725AbjIGSED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240929AbjIGSEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:04:02 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C42171F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:03:42 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-573e0d471ceso917327a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 11:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694109822; x=1694714622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEmLf5tBZnrpTc75BUlpf2BY38NVDiguy/Zml9Cxbdk=;
        b=HNUDJaemHUpG6tb6QBOzy4WXMZ+yM7P7mUY8YgXVQXnvLNtxvcPYMSRIFJ8QVAlRw+
         ZWrHTsXUdkNQfM9QlDhkE1lGmghr0DKwc5ernpEmdckv4rSB5DGKZ/ODHOHduaHHEdhi
         GhTQEIVIuoijjphtgU8Ys+LZJa8Py06UmXVpFbYS8mLKYF4pbBROwYDRq6P8KIjuShPr
         xF3Cl06ibvsEh/lRaXF5Edw6FL88tZ9/zNUz1SFuqQ2tk7oaOjjcjQUGYzucnkdBOOFj
         NhcJ9okxIT56NUoXvry3NVxJmTacVtRne/jtnqaXEDV0r2fsRvbm+UYx8t4+7QLN73Xc
         5LLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694109822; x=1694714622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEmLf5tBZnrpTc75BUlpf2BY38NVDiguy/Zml9Cxbdk=;
        b=J61XHXaJZJaIQN8clFXh0Ayzs6SXrHvYaMPwKBkyfFWnaJhB49T25EEtk2huBKtu3a
         q93fhXOzygIYLAqPCk6Td75ln6frC4LzxkcPuhpInwEEbtd+DaIBypQt3V/S7PH1AajN
         ZSZo5LlfQFIvrC5nPddvaQ0zD/LfqivHWxF4LGCuCPIvnHyOjSwCvas0KbhMWm2/DQ81
         vaEfKvp8N22x+Or1Jtns/eS9NabXlKrZ8Qo4JIAdpA2qdevo1H55EMJvjqMs4e4Z2A40
         s+Lmyykg/p+27hjfx/8bXnxjSgWwmn21nKIBCeUInO5NzVIz/nkoV59oyKIAdQOUPf4x
         2ukA==
X-Gm-Message-State: AOJu0Yz/Pj+qJRbcnZZPIOqgzj8ESHCJCgJEipcJXFt7Mc8KXZNBwSsk
        X82ctMTQgnnbj0EAk/b0JbkQhhWpvNIlvdD36dmvyw==
X-Google-Smtp-Source: AGHT+IGuRtK1RspOtvuxn9SRC6PHPgXUrdJxzN9hvwl+GeMezP92bsyLRcRHBUX/NqdzlcPahOafo1q2j+Afg1wUX54=
X-Received: by 2002:a17:90b:314c:b0:262:ceaa:1720 with SMTP id
 ip12-20020a17090b314c00b00262ceaa1720mr351227pjb.5.1694109822164; Thu, 07 Sep
 2023 11:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230906224541.2778523-1-acdunlap@google.com> <e037f1c0-aaf6-7951-04ea-6d27e557b61b@intel.com>
 <CAMBK9=b9V6WxYZNrVPNV5vzBZ-mT_noBAxod=ijqrV3bUXAUyA@mail.gmail.com> <cb958f57-6a3a-d626-da51-53ad0e61870c@intel.com>
In-Reply-To: <cb958f57-6a3a-d626-da51-53ad0e61870c@intel.com>
From:   Adam Dunlap <acdunlap@google.com>
Date:   Thu, 7 Sep 2023 11:03:30 -0700
Message-ID: <CAMBK9=bk715TjXhzwss+wFqpafKganGhZ=WKWPvEuJyM5M2MCQ@mail.gmail.com>
Subject: Re: [PATCH] x86/sev-es: Do not use copy_from_kernel_nofault in early
 #VC handler
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, Jacob Xu <jacobhxu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 7, 2023 at 10:06=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
> How about something like the attached patch?

I think that's a much better idea, but unfortunately we can't rely on
boot_cpu_data being 0'd out. While it is a static global variable that C sa=
ys
should be 0'd, the early interrupt happens before .bss is cleared (Note if =
it
happens to be 0, then the __is_canonical_address check succeeds anyway -- t=
he
boot failure only happens when that variable happens to be other random val=
ues).
If there's another check we could do, I'd agree that'd end up being a much
better patch. For example, maybe we could add a field to cpuinfo_x86 is_val=
id
that is manually (i.e. not part of the regular .bss clearing) set to false =
and
is only set to true after early_identify_cpu is finished. Or the
simplest thing would
be to just manually set x86_virt_bits to 0 somewhere super early.

> But a closer look would be appreciated.

Turning on CONFIG_UBSAN catches the UB that happens when x86_virt_bits is 0
since that causes a bit shift by 64. Unfortunately, the ubsan reporting
mechanism also doesn't play well with being called so early into boot, so t=
he
messages end up corrupted. But the fact that it only reports one error mean=
s
that (at least in our tests), it only happens once. Of course, there could =
be
other interrupts or other configurations where other problems happen.

> Also, what's the root cause here?  What's causing the early exception?
> It is some silly CPUID leaf?  Should we be more careful to just avoid
> these exceptions?

Yes, it is a CPUID instruction in secondary_startup_64 with the comment /* =
Check
if nx is implemented */. It appears to be pretty important. Potentially we =
could
paravirtualize the CPUID direclty (i.e. mess with the GHCB and make the vmg=
exit)
instead of taking the #VC, but I'm not sure that's a great idea.

There's a couple of other CPUIDs that are called in early_identify_cpu betw=
een
when x86_virt_bits is set to 48 and when it is set to its real value (IIUC,=
 it
may be set to 57 if 5 level paging is enabled), which could potentially cau=
se
spurious failures in those later calls.
