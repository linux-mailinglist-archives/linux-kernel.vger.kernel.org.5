Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A537DD87B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 23:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343927AbjJaWkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 18:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjJaWkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 18:40:17 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDE8F5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:40:14 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32f7c44f6a7so2318563f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698792013; x=1699396813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJWbuo+9TPVToDVPf96jeRxWUliwPBKXtZxQViTwJnU=;
        b=1K8ZS/bJ+GdgqaZUvAP2WwNROh7zVafE6rW0I41BI7g6Cuii9iWqj6tqLetfVQnuij
         mqrLEsygd5w8lFAbQgvkcROrnJCCEWMldrHP4O25qc38/KI1iGCpM4/wrvLPnGiRRjUy
         UET+n2k3pAZakVazyzGziZONC7dCPAfAWcn8RnZtvZvjJ74w7BjYg9SOd2E/VCWJsh/Q
         hjUqjy6DwE0Kw7wq3scIRWXIYCWNSNlnBFHdqI4GR7b6c9oH1dXwTcZ3eALS/mu/CWM4
         6h7c+KWgRKLbE/7nXwFViCsz1g/egULjDKcBBbXrfllPtyavfMqnz40g0XlTC3tuQAJS
         fXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698792013; x=1699396813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJWbuo+9TPVToDVPf96jeRxWUliwPBKXtZxQViTwJnU=;
        b=Pta8CijAac8Al9iBAY9PDP00/zPhPM/z6WEhTf23NFU51ydYza9u+aX9doSygaYUA7
         ZVb/RKvuNh3RCJymI7optRJ36gWd/xgs0EGAymxi3h25Kx7p7ekF20eNRuv2GzrvYi5W
         1Jp6jLGf5ZY3eKvfGzPTlb/aKiIBEqlqHaM+wnhc3Cy4Tsy2wDbJ9rmzI8K5kYQNgcD6
         VODVURoJob2GKyS/iRY66YQEND8CM/n1xpNe9xIcfshriHCjOm5tVb3lzw08zivoA4AY
         B64Q0lszEpGpwcmwsyBQ1FZx1VmlKiploMaN1vxSDR1ufX4RAu+yWyk6zOErs/a9qjs4
         77RA==
X-Gm-Message-State: AOJu0YyX/WyM5ZjWxLqMQcEXBDvMyUT4u1qclBP+pnM09JzC67IRhw4J
        c/oy+6SlTCyah1ji0BsUQT6+4pCSTcvt/EZ8Id7Wwg==
X-Google-Smtp-Source: AGHT+IHkDiPkYLUipg1BNgD620eOceDAkQD+A32NnZclx+AVnVsN45AUMqsjx/qUof6Oj5kTmFWO4hEnjV9b1jDP2pc=
X-Received: by 2002:adf:d1ef:0:b0:32f:7db1:22fb with SMTP id
 g15-20020adfd1ef000000b0032f7db122fbmr8716023wrd.28.1698792012937; Tue, 31
 Oct 2023 15:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-17-seanjc@google.com>
 <ZUFGRyQEuWj4RJS0@google.com> <ZUFzZf-YmCRYP6qo@google.com>
In-Reply-To: <ZUFzZf-YmCRYP6qo@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Tue, 31 Oct 2023 15:39:42 -0700
Message-ID: <CALzav=d9eXZfK=op7A=UftbpuPpUbxqV6CmkqqxxBNuNsUU4nw@mail.gmail.com>
Subject: Re: [PATCH v13 16/35] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
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
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 2:36=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> On Tue, Oct 31, 2023, David Matlack wrote:
> > On 2023-10-27 11:21 AM, Sean Christopherson wrote:
> > > Introduce an ioctl(), KVM_CREATE_GUEST_MEMFD, to allow creating file-=
based
> > > memory that is tied to a specific KVM virtual machine and whose prima=
ry
> > > purpose is to serve guest memory.
>
> > Maybe can you sketch out how you see this proposal being extensible to
> > using guest_memfd for shared mappings?
>
> For in-place conversions, e.g. pKVM, no additional guest_memfd is needed.=
  What's
> missing there is the ability to (safely) mmap() guest_memfd, e.g. KVM nee=
ds to
> ensure there are no outstanding references when converting back to privat=
e.
>
> For TDX/SNP, assuming we don't find a performant and robust way to do in-=
place
> conversions, a second fd+offset pair would be needed.

Is there a way to support non-in-place conversions within a single guest_me=
mfd?
