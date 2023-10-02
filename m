Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F537B5CA4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 23:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbjJBVqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 17:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjJBVqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 17:46:40 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF644CE
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 14:46:37 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-277564f049dso166449a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 14:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696283197; x=1696887997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y86AWWtsD8deWIYd/tc86/npyfYKbgsHuTwpWzSR7k8=;
        b=mHvsPlAtygwBG7QOJPNJ84ThlHeoSO+2YjSWSckdB1AMPvOvJyhnTqyjhuqcSUvnhq
         IP+KKXn39cdvnd7iCaM/6ROsDEqiSkYUy6QnHGzwMXMmq3EupjN3NS70qy5LQ16KNBeR
         5BH/2GgXFdJPUlq5DrFF4bOftMDDl8I4Qp2on0zn9MNaKV7qwQ4tMxEZW0U14b9Ptulj
         ZCtCoVrl4eeICKWNPjmvlxakdV1zXfnW1gLVWGxentgrBmfGjDElen32DbSYHsGrc76v
         qlWxXYZrX2XvyIOgHW+ouF8QXBOMMeaB7cFHoxZfO4jiFKj9uPw/3VsVbScapatdhPLu
         qppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696283197; x=1696887997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y86AWWtsD8deWIYd/tc86/npyfYKbgsHuTwpWzSR7k8=;
        b=dfQc/OIObcfX6NZJU4QHeEb713PiYf/qx47L7gtk+NUDmOzejlXAR62sBje9PQTiPy
         22NAcJwEXpW9Xf3KdRnPSyrfxro2MAwS6amB5VymHyJL+A9+0hS8BZe/Emy4STHy4uWW
         WbKfh9XqU4wUtvbl/e3fnVbBw3fKw5Bya/bfEzSFZyipz2nmgr3txTDnhEcQrEk6oDGM
         BVBovcyEO2inP0Y5eMmf+VSpbj+Qv3sY9FF7qhou22tPGHd2Z6ZzjRLPwx/cj8W9xTFX
         EEcr+LLA9K+0O3fgQPzQr4ZNkU04/vKhYtv9QXM4EKqAWB0ZcrdMSg746CJf+gbkC7eP
         m7/g==
X-Gm-Message-State: AOJu0Yx5R279JniuJOa4eMP/4x3vdOQ210K4/qjOSzqmvFARQ6mrZ/1b
        4hdeq8zuWCxdGUSLjTLoeslSdQgB6xmeJna1DaD5BQ==
X-Google-Smtp-Source: AGHT+IHrxazDYrCjdNrlY+7cwdza88XWMhkayyfug7tp5B15h5gGKmsYqWOmgmzjLPoFA/MAXmKxT7vXgqmEokhFS0o=
X-Received: by 2002:a17:90a:3884:b0:26b:49de:13bd with SMTP id
 x4-20020a17090a388400b0026b49de13bdmr9890126pjb.36.1696283197079; Mon, 02 Oct
 2023 14:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230912002703.3924521-1-acdunlap@google.com> <20230912002703.3924521-3-acdunlap@google.com>
 <20231002200426.GA4127272@dev-arch.thelio-3990X> <8c99f8d2-247d-ccee-3a0b-e95e547f8b9b@intel.com>
In-Reply-To: <8c99f8d2-247d-ccee-3a0b-e95e547f8b9b@intel.com>
From:   Adam Dunlap <acdunlap@google.com>
Date:   Mon, 2 Oct 2023 14:46:25 -0700
Message-ID: <CAMBK9=ayzz3yz-Cbf3vx1=v2bFqQM8Vmyo0NtfoKY0jqGuBk_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/sev-es: Only set x86_virt_bits to correct value
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
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
        Jacob Xu <jacobhxu@google.com>, llvm@lists.linux.dev
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

On Mon, Oct 2, 2023 at 2:41=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 10/2/23 13:04, Nathan Chancellor wrote:
> > On Mon, Sep 11, 2023 at 05:27:03PM -0700, Adam Dunlap wrote:
> >> Instead of setting x86_virt_bits to a possibly-correct value and then
> >> correcting it later, do all the necessary checks before setting it.
> >>
> >> At this point, the #VC handler references boot_cpu_data.x86_virt_bits,
> >> and in the previous version, it would be triggered by the cpuids betwe=
en
> >> the point at which it is set to 48 and when it is set to the correct
> >> value.
> >>
> >> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> >> Signed-off-by: Adam Dunlap <acdunlap@google.com>
> > Our continuous integration started seeing panics when booting ARCH=3Di3=
86
> > without KVM after this change landed in -tip as commit fbf6449f84bf
> > ("x86/sev-es: Set x86_virt_bits to the correct value straight away,
> > instead of a two-phase approach"):
>
> I can't reproduce this, but I'm running a gcc-built kernel and I haven't
> tried very hard to replicate your qemu setup.
>
> I did notice, though, that the patch in question forgot to move one
> assignment.  Could you see if the attached patch fixes things for you?

I reproduced the issue as Nathan described and your attached patch fixes it
for me.
