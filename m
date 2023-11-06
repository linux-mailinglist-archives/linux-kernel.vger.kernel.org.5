Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B187E2960
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjKFQE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjKFQEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:04:23 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C741D45
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:04:20 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ae5b12227fso64364877b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 08:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699286659; x=1699891459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBcfSXW+7b0RYZr/CwodaGuIC1t2rSK8z82L7NdJqdg=;
        b=wFpslrgmIgIbaZOnLmqhhsJ9lDbgt0QTYXsM/t9b7FrC5cgpaymNsWQX/WWEoi7FQr
         E/bE/k+zCfeCsDQ6kp5smusq2Mr+EUiKnNmREGKBUaW+YC3SO+yS8VAGYnKZsvJ77fOE
         fMAnL0JHqR6sUtdNJjBm8Aik+fy2iGwNJW9rhJx2SBQ4S4UM5m/tLtDrWXuhjn3+ZHrm
         06Afvfng0cn8QBQcKGDsPnW+8DCJJpE4VHZCoiIaWRFxleb/9ugM75rY0RRFQSVvHZYx
         CeVPu3Fh483VCoEqrQSAnCd1jwLIhpCHNNho6qiGzNqwXXphlYb7mMh8JmrGlazciaNh
         sIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699286659; x=1699891459;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vBcfSXW+7b0RYZr/CwodaGuIC1t2rSK8z82L7NdJqdg=;
        b=Okn2VCBSLteENKYZ+TdYcQGnPsHKcBiP29uO2LFE+CCLKTaY9dWGoQT9JWEyFi7zCl
         XQL7q3EbVcnqNGMkECs5pRBhuebmqFk6DwPz5cJOm2xbmhJG2lBOOer52EE+Jz5+ffEg
         ZgDTv0eJgbe5yIhHP5bqVbYtzTu1KES6/TU89ef8ZWhvlay5OefFuOC+N66LMiUgLJaE
         dQfU6NQwc++wl/BTsWYiMC5oIGoTAQ/qf7XPO2II89glELEubm/CRSIBGHy2/+YX39bp
         DskwwVGzyaCf9vvxWgd8lV1sXMkV4PE86EyC1hQQpEm+zuYOzS3zsLNEe7fFQyJwYfFY
         b3bQ==
X-Gm-Message-State: AOJu0YyZs52kK006Tw7MYLJvzrfXMaaevW9a4BwhYCRDUv4E2F1zP5K3
        vpMjukV3wg9p6VHHgr1RBVtfdcu9Gos=
X-Google-Smtp-Source: AGHT+IG4M/eznhqFxpL/eWUumIXP2aANvxiOg95OzhM2lh4aiDVuodrpXWON7UbLhWxQPiRYqqCoKKt9NcE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:830d:0:b0:5a8:6162:b69 with SMTP id
 t13-20020a81830d000000b005a861620b69mr214046ywf.3.1699286659321; Mon, 06 Nov
 2023 08:04:19 -0800 (PST)
Date:   Mon, 6 Nov 2023 08:04:17 -0800
In-Reply-To: <CA+EHjTxz-e_JKYTtEjjYJTXmpvizRXe8EUbhY2E7bwFjkkHVFw@mail.gmail.com>
Mime-Version: 1.0
References: <20231105163040.14904-1-pbonzini@redhat.com> <20231105163040.14904-28-pbonzini@redhat.com>
 <CA+EHjTxz-e_JKYTtEjjYJTXmpvizRXe8EUbhY2E7bwFjkkHVFw@mail.gmail.com>
Message-ID: <ZUkOgdTMbH40XFGE@google.com>
Subject: Re: [PATCH 27/34] KVM: selftests: Introduce VM "shape" to allow tests
 to specify the VM type
From:   Sean Christopherson <seanjc@google.com>
To:     Fuad Tabba <tabba@google.com>
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
        "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>,
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023, Fuad Tabba wrote:
> On Sun, Nov 5, 2023 at 4:34=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
> >
> > From: Sean Christopherson <seanjc@google.com>
> >
> > Add a "vm_shape" structure to encapsulate the selftests-defined "mode",
> > along with the KVM-defined "type" for use when creating a new VM.  "mod=
e"
> > tracks physical and virtual address properties, as well as the preferre=
d
> > backing memory type, while "type" corresponds to the VM type.
> >
> > Taking the VM type will allow adding tests for KVM_CREATE_GUEST_MEMFD,
> > a.k.a. guest private memory, without needing an entirely separate set o=
f
> > helpers.  Guest private memory is effectively usable only by confidenti=
al
> > VM types, and it's expected that x86 will double down and require uniqu=
e
> > VM types for TDX and SNP guests.
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Message-Id: <20231027182217.3615211-30-seanjc@google.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
>=20
> nit: as in a prior selftest commit messages, references in the commit
> message to guest _private_ memory. Should these be changed to just
> guest memory?

Hmm, no, "private" is mostly appropriate here.  At this point in time, only=
 x86
supports KVM_CREATE_GUEST_MEMFD, and x86 only supports it for private memor=
y.
And the purpose of letting x86 selftests specify KVM_X86_SW_PROTECTED_VM, i=
.e.
the reason this patch exists, is purely to get private memory.

Maybe tweak the second paragraph to this?

Taking the VM type will allow adding tests for KVM_CREATE_GUEST_MEMFD
without needing an entirely separate set of helpers.  At this time,
guest_memfd is effectively usable only by confidential VM types in the
form of guest private memory, and it's expected that x86 will double down
and require unique VM types for TDX and SNP guests.
