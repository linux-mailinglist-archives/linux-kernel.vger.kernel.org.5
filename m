Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9427E2991
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjKFQRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjKFQRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:17:49 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEF6D47
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:17:46 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-66d190a8f87so30187276d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 08:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699287466; x=1699892266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUV8zKIdpTV0f8ZMhx633GQ2l+XRSBNMcsvYJoEfTx4=;
        b=3o8M6NtHBemcOm+WImExN2FSkf9rn450dHn/P65eZjlIW2aCrACWXBwOyfiWzwA0QA
         df03rptJDJdDFyoyBXZQMrx8x+zr4/6Yho5Vq99CZOwdBOT1kOO4ZrxBi5VSfG7/g+i2
         42W6TbW7eDdDtEnIrogMhtX8k2PHMwCNFCtBhwTOp5ZndPZSh88xacBL38yksWV4tbmd
         YssaPajDRIXn9V+UEvZla/fNVG9vrw3IAHWjNnhcIL+B6UWMtixB3zKHyQ0J9uJjpjLT
         ADMfKVdRzDOZC3f8Kf0ejMMB6+1chRy6YFVtxYxOc27YRb4a/ZBquILr8L4z6bW4Z1s9
         dFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699287466; x=1699892266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUV8zKIdpTV0f8ZMhx633GQ2l+XRSBNMcsvYJoEfTx4=;
        b=bS2mOAhVIf+EcD2TxstrDTMXjlevsoJvrsogl1vChzrfr4cfC/gxfhnKuzde6kv1aB
         r1EmIrWvYz4e1JJKL4iEvrNam0bh7IMRPN9YyZrWIPNxyFwqPzwl/8HIXhcT/5l8wrl1
         GxXSggagX6H23I8CS4Zf21CBiVw6v599TQD5T0yTaVxbMMFr5/p33icK6gJkNdi3OAo9
         UVO4nvLeJuFc5np63j0l7YuF1Y792Or2A/JuPLL0LkSOFpVOl40+sSYq7wRR+C5GVHt/
         LJEWr1y+SioZF53g3B8BlFsHhFAp+b3oCLQ8e2F6zrl5wJe3jrM49u+W59CgJb+MIp2Y
         /Sug==
X-Gm-Message-State: AOJu0YwEg4iY2RJl1cXVblk/Mc0c7BDaSmn+c8/VCTQVRadVEzQ4vu5A
        tFa5upmh+EcAhvEY3rkAmgJzqvSgGD5gI2YVJLvrtg==
X-Google-Smtp-Source: AGHT+IFFqaeUa+zb1fqYMH2SBG8qERPcG1V2EKOvlLONFWJF+9JT7SC3ACnaIHdf6fX4zUtKFZJjWCRYHGHhXFDqHvM=
X-Received: by 2002:ad4:5c83:0:b0:670:9f8d:f7be with SMTP id
 o3-20020ad45c83000000b006709f8df7bemr44676404qvh.13.1699287465633; Mon, 06
 Nov 2023 08:17:45 -0800 (PST)
MIME-Version: 1.0
References: <20231105163040.14904-1-pbonzini@redhat.com> <20231105163040.14904-28-pbonzini@redhat.com>
 <CA+EHjTxz-e_JKYTtEjjYJTXmpvizRXe8EUbhY2E7bwFjkkHVFw@mail.gmail.com> <ZUkOgdTMbH40XFGE@google.com>
In-Reply-To: <ZUkOgdTMbH40XFGE@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 6 Nov 2023 16:17:09 +0000
Message-ID: <CA+EHjTzc4zwN1atU1mSnbi3Lvb0c83MATQSk1uSWxae2iKi0aw@mail.gmail.com>
Subject: Re: [PATCH 27/34] KVM: selftests: Introduce VM "shape" to allow tests
 to specify the VM type
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 6, 2023 at 4:04=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Mon, Nov 06, 2023, Fuad Tabba wrote:
> > On Sun, Nov 5, 2023 at 4:34=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
> > >
> > > From: Sean Christopherson <seanjc@google.com>
> > >
> > > Add a "vm_shape" structure to encapsulate the selftests-defined "mode=
",
> > > along with the KVM-defined "type" for use when creating a new VM.  "m=
ode"
> > > tracks physical and virtual address properties, as well as the prefer=
red
> > > backing memory type, while "type" corresponds to the VM type.
> > >
> > > Taking the VM type will allow adding tests for KVM_CREATE_GUEST_MEMFD=
,
> > > a.k.a. guest private memory, without needing an entirely separate set=
 of
> > > helpers.  Guest private memory is effectively usable only by confiden=
tial
> > > VM types, and it's expected that x86 will double down and require uni=
que
> > > VM types for TDX and SNP guests.
> > >
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > Message-Id: <20231027182217.3615211-30-seanjc@google.com>
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> >
> > nit: as in a prior selftest commit messages, references in the commit
> > message to guest _private_ memory. Should these be changed to just
> > guest memory?
>
> Hmm, no, "private" is mostly appropriate here.  At this point in time, on=
ly x86
> supports KVM_CREATE_GUEST_MEMFD, and x86 only supports it for private mem=
ory.
> And the purpose of letting x86 selftests specify KVM_X86_SW_PROTECTED_VM,=
 i.e.
> the reason this patch exists, is purely to get private memory.
>
> Maybe tweak the second paragraph to this?
>
> Taking the VM type will allow adding tests for KVM_CREATE_GUEST_MEMFD
> without needing an entirely separate set of helpers.  At this time,
> guest_memfd is effectively usable only by confidential VM types in the
> form of guest private memory, and it's expected that x86 will double down
> and require unique VM types for TDX and SNP guests.

sgtm
/fuad
