Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1199E7DF56A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjKBO5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjKBO5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:57:52 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46EA184
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:57:47 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-778940531dbso60626885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698937067; x=1699541867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oO6y6W0Hx2JX7rhY2F9inSHXy5EHTr89TCOrnU0rbjw=;
        b=WABnDmPn5on4qHZIWANY+CuhNh4heHUUGc6Z1RpTJLvLhxOk+sFyH+7L2AMchSpL+J
         PqTaI1s7f8Li/A5NPoBSePZDyRbPHpIjbQibERvyfmOYab7P1mS/fEx/Ot1dD7SS07Sq
         n9IDH2JN36ixe5W+G1wkbrhTu0CciPOYRUXpGTs/Np6efSo4vcQl9aTaK6cHnRj/iEhT
         qAwV4QY/CeuwrE7DRseMVwtFTV8DJd0oawbA/2gsPZ7fZzws34hrWcbJ0hQ4jxOHVpMk
         t16vU8dc5ir/4snBt+0cgtgoUpngRtkZeb9eKQw/qFTh/kpSmArsYS3sMQiq1pXXbwx9
         MGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698937067; x=1699541867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oO6y6W0Hx2JX7rhY2F9inSHXy5EHTr89TCOrnU0rbjw=;
        b=jHmFrm824Z5XCsMjR7B6GL7l0s1rO2k3yD++KOk9UcxWomXdY1L67eM7itt+zP7RPJ
         zko9h+w9amiT8VxozmE10aHl7dm6HGbUhTqUXYF3LJFasJkrMp3OpPnx9WLq749DnWTD
         i45YoqBu7EgMX7ox/5wqvo7XyPDmzVr/01omGnI8MEuP1uLh5mfkuG7VW/EQ1PIP3L6C
         wWjUp4wzRpjFEmsP5Xyw/kFucZMSKVwxD81/PyvPbHcwsdZICjMo/NKeIkJsj0giCKY6
         PbMqKwRrv1kwbb8fUNl5503uGbb2UVngm1IYEq7McF6QnheMfnJMcUIDq/J/hVQevh1B
         qMmQ==
X-Gm-Message-State: AOJu0YxsT/a4vBp6JFi6LCl6mkG0n33Fn1SX8JpZKs0nmbrs4jCUVXaA
        AHNGT8IU3meH1dKxDpxy8ZzeZoG0nYeZ44qhz1/DlQ==
X-Google-Smtp-Source: AGHT+IHH5fWOUl6XWE3cRbRkmtci3EQG11sJ5sTElOUO4i3o8jogptvsMwjY2tQIjVOiF2P5A518xtVBqTDVb2uPT1o=
X-Received: by 2002:a05:6214:252d:b0:66d:1b2f:3f64 with SMTP id
 gg13-20020a056214252d00b0066d1b2f3f64mr24532994qvb.31.1698937066885; Thu, 02
 Nov 2023 07:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-13-seanjc@google.com>
 <CA+EHjTyAU9XZ3OgqXjmAKh-BKsLrH_8QtnJihQxF4fhk8WPSYg@mail.gmail.com> <ZUO1Giju0GkUdF0o@google.com>
In-Reply-To: <ZUO1Giju0GkUdF0o@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 2 Nov 2023 14:57:10 +0000
Message-ID: <CA+EHjTwpVSyUC8oiii3EYU8pqEJ0D0NXA1EZt76wjfPBpk2rFA@mail.gmail.com>
Subject: Re: [PATCH v13 12/35] KVM: Prepare for handling only shared mappings
 in mmu_notifier events
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        David Matlack <dmatlack@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 2:41=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Thu, Nov 02, 2023, Fuad Tabba wrote:
> > Hi,
> >
> > On Fri, Oct 27, 2023 at 7:22=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > Add flags to "struct kvm_gfn_range" to let notifier events target onl=
y
> > > shared and only private mappings, and write up the existing mmu_notif=
ier
> > > events to be shared-only (private memory is never associated with a
> > > userspace virtual address, i.e. can't be reached via mmu_notifiers).
> > >
> > > Add two flags so that KVM can handle the three possibilities (shared,
> > > private, and shared+private) without needing something like a tri-sta=
te
> > > enum.
> > >
> > > Link: https://lore.kernel.org/all/ZJX0hk+KpQP0KUyB@google.com
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  include/linux/kvm_host.h | 2 ++
> > >  virt/kvm/kvm_main.c      | 7 +++++++
> > >  2 files changed, 9 insertions(+)
> > >
> > > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > > index 96aa930536b1..89c1a991a3b8 100644
> > > --- a/include/linux/kvm_host.h
> > > +++ b/include/linux/kvm_host.h
> > > @@ -263,6 +263,8 @@ struct kvm_gfn_range {
> > >         gfn_t start;
> > >         gfn_t end;
> > >         union kvm_mmu_notifier_arg arg;
> > > +       bool only_private;
> > > +       bool only_shared;
> >
> > If these flags aren't used in this patch series, should this patch be
> > moved to the other series?
>
> If *both* TDX and SNP need this patch, then I think it's probably worth a=
pplying
> it now to make their lives easier.  But if only one needs the support, th=
en I
> completely agree this should be punted to whichever series needs it (this=
 also
> came up in v11, but we didn't force the issue).
>
> Mike, Isaku?
>
> > Also, if shared+private is a possibility, doesn't the prefix "only_"
> > confuse things a bit? I.e., what is shared+private, is it when both
> > are 0 or when both are 1? I assume it's the former (both are 0), but
> > it might be clearer.
>
> Heh, I was hoping that "only_private && only_shared" would be obviously n=
onsensical.
>
> The only alternative I can think would be to add an enum, e.g.
>
>         enum {
>                 PROCESS_PRIVATE_AND_SHARED,
>                 PROCESS_ONLY_PRIVATE,
>                 PROCESS_ONLY_SHARED,
>         };
>
> because every other way of expressing the flags either results in more co=
nfusion
> or an unsafe default.  I.e. I want zapping only private or only shared to=
 require
> the caller to explicitly set a non-zero value, which is how I ended up wi=
th
> "only_{private,shared}" as opposed to "process_{private,shared}".

I don't have a strong opinion about this. Having an enum looks good to me.

Cheers,
/fuad
