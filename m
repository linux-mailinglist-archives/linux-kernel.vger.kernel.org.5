Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440117B7462
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjJCW75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 18:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjJCW74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 18:59:56 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11EEAF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 15:59:52 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-49d9ef118a5so520905e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 15:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696373992; x=1696978792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuLZmgaV89lzOHymPqsmAC6abj1UTBHkava0gPj509c=;
        b=HZR93xxM84qxgnwPHXx6vfV7FbLovXh3ObYwd6DPcFpbCDM/szoGzBJ44pL9r43+RY
         OOwmkuJW1GtTBmNvIQLF3XueStHUjnTfMq/mGKiPbcIWsQmYXB7wM076qWq4opVVVojR
         XtwDRJhBAN7y6kvUTgM0H3ou+TjLaGVM7Xf7N4u8XcP/ex3qZh810Kmb5H1j5tkaSs2L
         WUW+Sy1eAdwO7tf8rSmpQibVIxxyHKn4481i6iwdTJG2nVzUys181GtHpse7V26oRdMp
         X/dablmoxRFxp5JoUDo3SR8+jC3DyATo+QX7RXNkDBFK8c5LjCdAaoe8mPTLzwR5ubo1
         gpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696373992; x=1696978792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuLZmgaV89lzOHymPqsmAC6abj1UTBHkava0gPj509c=;
        b=ZcVbyUT7Pn8QXXknDTtxqFZTzsNVXHV3mN35k56ZeS2J+RgeUITGzsrq76anjUKMM0
         pkiz8+isuqAzKRiH1SAmXNbOj2d8xwf7CbU4KW/fnNadH/dKxUR0PDI3+6tlnqYzoWxo
         9l4ZRHMZRlmNNPtzS77cot/YqrpaiEGUmmx77WC4Nrn0X6kZ/0bscUaT2mILmUSfUjYR
         BZ4NOHlfLgoerdYICUoUpUOa+ctT+H5WWITU9jznk0WQPqY/8KH3E9K7pYtEtSzmrO6d
         r76hH55iHb1v03nfxQpZdDDVd0uoUeSbFj+3VzoM3l9LQYo5/BY/e8TmnHU4hYT22teA
         I9Lw==
X-Gm-Message-State: AOJu0YzANcys0LCKoY/Yh/pR04iy5X3AmV1AyvnmvQ0rQG4Y6hqJnYO4
        KPSnfFafoh1eWTz/2aFPheagnTYEEWkVxKzmMVSGhA==
X-Google-Smtp-Source: AGHT+IHt/5hi86I5tWmFhMD1MR9ouSEy0bKqsB0WSgB1we3wcIPiKRqguWhLnlbBZgNBr6PNxrWaK8kmhmE6ei5mSik=
X-Received: by 2002:a1f:4887:0:b0:493:3491:ce89 with SMTP id
 v129-20020a1f4887000000b004933491ce89mr587565vka.14.1696373991201; Tue, 03
 Oct 2023 15:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-8-seanjc@google.com>
 <117db856-9aec-e91c-b1d4-db2b90ae563d@intel.com> <ZQ3AmLO2SYv3DszH@google.com>
 <CAF7b7mrf-y9DNdsreOAedGJueOThnYE=ascFd4=rvW0Z4rhTQg@mail.gmail.com> <ZRtxoaJdVF1C2Mvy@google.com>
In-Reply-To: <ZRtxoaJdVF1C2Mvy@google.com>
From:   Anish Moorthy <amoorthy@google.com>
Date:   Tue, 3 Oct 2023 15:59:15 -0700
Message-ID: <CAF7b7mqyU059YpBBVYjTMNXf9VHSc6tbKrQ8avFXYtP6LWMh8Q@mail.gmail.com>
Subject: Re: [RFC PATCH v12 07/33] KVM: Add KVM_EXIT_MEMORY_FAULT exit to
 report faults to userspace
To:     Sean Christopherson <seanjc@google.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 6:43=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> > - I should go drop the patches annotating kvm_vcpu_read/write_page
> > from my series
>
> Hold up on that.  I'd prefer to keep them as there's still value in givin=
g userspace
> debug information.  All I'm proposing is that we would firmly state in th=
e
> documentation that those paths must be treated as informational-only.

Userspace would then need to know whether annotations were performed
from reliable/unreliable paths though, right? That'd imply another
flag bit beyond the current R/W/E bits.

> > - The helper function [a] for filling the memory_fault field
> > (downgraded back into the current union) can drop the "has the field
> > already been filled?" check/WARN.
>
> That would need to be dropped regardless because it's user-triggered (sad=
ly).

Well the current v5 of the series uses a non-userspace visible canary-
it seems like there'd still be value in that if we were to keep the
annotations in potentially unreliable spots. Although perhaps that
test failure you noticed [1] is a good counter-argument, since it
shows a known case where a current flow does multiple writes to the
memory_fault member.

[1] https://lore.kernel.org/all/202309141107.30863e9d-oliver.sang@intel.com

> Anyways, don't do anything just yet.

:salutes:
