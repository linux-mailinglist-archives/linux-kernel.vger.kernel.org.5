Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BABA77C46E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjHOAae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjHOAaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:30:17 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF38198B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:30:12 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40a47e8e38dso75801cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692059411; x=1692664211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNJoaJWeIvUddw5R6SlhDX5IJGHqkE8DYyIqOAmI/Gc=;
        b=dTFmXzF41H/n0mK5Jfs/y8u8AIBRo6B27+rwi8uJSpQ/wDiNzZvL4lLXxVNTiAFnkY
         suX0m2QNqLhILSSE09Qp0EukFkzTu5fkVeX9h2uqxOukcSvGAGoFfI/tN7OJN6Tmf4hp
         2mQFyYwAgzeVf26n6t7iWvkYuXuBdnimEIsWJq+Q0pT1f5LSRaCImOR8BywZSjIJIdOq
         cAmcg3NOXGzR2UQrLQh9p0Dfa+ukixiNWjSnvTSaiF7HQoZ6Tumr7UhEepy6riEpq6V6
         Q96VUWIOScaDoDQ5SHJBhUhM3mvGwEwsUjr+/ALmvdKPAVvLMf2FUm7Gsdz4zcVfLTzN
         vJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692059411; x=1692664211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNJoaJWeIvUddw5R6SlhDX5IJGHqkE8DYyIqOAmI/Gc=;
        b=UA2mj30q8aHTQqFE5uSzwrLxJO8BYcv5zjF2A3F6uenSQXUdLMrhU0sM3mMHGAh46s
         tZO+xZhxfCBVQEI1kRzdgEuNssIBOgROl1mEegOPDjBKyNyiGUsEF7N+Qx00YP9H/IwB
         5qeqQZfng1yd9NxGJBGFtYrbygo+YKPYCj3kywMJ4eCzI5UrJO+eLXxicm5roCKbkEMf
         AsbIESrccKf1SfUSzIUZuAAyqojpCVJua+GeaFFYgR7UEIzl92n7su+CU69d7DTNGI9h
         N3h8tY+81mhGNlpWF2zggHsHiqivJwAWJcP90p4OcrhUgkaZ+U6+T+4TM9BkcSvJTIRe
         Ge9Q==
X-Gm-Message-State: AOJu0YwkHVi/V/KgXJ1lyPwCZj+eEjzCKcmEJFmQGAr+5UmA+iEHuy/v
        9oiieEB1qoyTpelvI0tsrmZTBf5FoOo9tAVvWduZVg==
X-Google-Smtp-Source: AGHT+IH5y5MbCy4rjhKShz2AECkzIJQAfVMplY8s8RsyVo2A8Q6lT4pFb0RwiAA0GgJLzfktk2kf1TttUxP9ICKRKm4=
X-Received: by 2002:ac8:5b51:0:b0:40f:d3db:f328 with SMTP id
 n17-20020ac85b51000000b0040fd3dbf328mr724022qtw.2.1692059411605; Mon, 14 Aug
 2023 17:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230811045127.3308641-1-rananta@google.com> <ZNq15SZ+53umvOfx@google.com>
In-Reply-To: <ZNq15SZ+53umvOfx@google.com>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Mon, 14 Aug 2023 17:29:59 -0700
Message-ID: <CAJHc60wMueazp3Wm=b6-tnFPAyX0zeYuVQe9uPEJrpAm0azw2A@mail.gmail.com>
Subject: Re: [PATCH v9 00/14] KVM: arm64: Add support for FEAT_TLBIRANGE
To:     Sean Christopherson <seanjc@google.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Jing Zhang <jingzhangos@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Fuad Tabba <tabba@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 4:16=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Aug 11, 2023, Raghavendra Rao Ananta wrote:
> > The series is based off of upstream v6.5-rc1.
>
> Lies!  :-)
>
> This is based off one of the kvmarm.git topic branches (I didn't bother t=
o figure
> out which one), not v6.5-rc1.
>
Sorry, what am I missing here? My git log is as follows:

$ git log --oneline upstream_tlbi_range_v9
5025857507abe (upstream_tlbi_range_v9) KVM: arm64: Use TLBI
range-based instructions for unmap
5c0291b99a8fc KVM: arm64: Invalidate the table entries upon a range
8c46b54d4aaec KVM: arm64: Flush only the memslot after write-protect
231abaeb7ffc2 KVM: arm64: Implement kvm_arch_flush_remote_tlbs_range()
5ec291b863309 KVM: arm64: Define kvm_tlb_flush_vmid_range()
5bcd7a085c34e KVM: arm64: Implement  __kvm_tlb_flush_vmid_range()
ea08f9dff7e5b arm64: tlb: Implement __flush_s2_tlb_range_op()
b3178687947c9 arm64: tlb: Refactor the core flush algorithm of __flush_tlb_=
range
a4850fa988eef KVM: Move kvm_arch_flush_remote_tlbs_memslot() to common code
306dc4e6afd37 KVM: Allow range-based TLB invalidation from common code
d02785a0a1e01 KVM: Remove CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL
136fa2d254537 KVM: arm64: Use kvm_arch_flush_remote_tlbs()
e35c68a75170d KVM: Declare kvm_arch_flush_remote_tlbs() globally
5d592777b9bba KVM: Rename kvm_arch_flush_remote_tlb() to
kvm_arch_flush_remote_tlbs()
06c2afb862f9d (tag: v6.5-rc1, tag: linux/v6.5-rc1) Linux 6.5-rc1
c192ac7357683 MAINTAINERS 2: Electric Boogaloo
f71f64210d698 Merge tag 'dma-mapping-6.5-2023-07-09' of
git://git.infradead.org/users/hch/dma-mapping
...

Isn't the commit, 06c2afb862f9d (06c2afb862f9d (tag: v6.5-rc1, tag:
linux/v6.5-rc1) Linux 6.5-rc1) the 'base' commit?

Thank you.
Raghavendra

> Please try to incorporate git format-patch's "--base" option into your wo=
rkflow,
> e.g. I do "git format-patch --base=3DHEAD~$nr" where $nr is the number of=
 patches
> I am posting.
>
> It's not foolproof, e.g. my approach doesn't help if I have a local patch=
 that
> I'm not posting, but 99% of the time it Just Works and eliminates any amb=
uitity.
>
> You can also do "--base=3Dauto", but that only does the right thing if yo=
ur series
> has its upstream branch set to the base/tree that you want your patches a=
pplied
> to (I use the upstream branch for a completely different purpose for my d=
ev branches).
