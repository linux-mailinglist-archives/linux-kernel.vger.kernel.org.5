Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3357DF7A1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjKBQ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376933AbjKBQ26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:28:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCA512D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 09:28:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32fb1c35fe0so200737f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 09:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698942533; x=1699547333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20owt2l3/cxGLzLA2xbevoL+xSQuNASMB596X3+ow7c=;
        b=iP3n4d/OPngbE98wbRDR3NysfZjhFfYHlQVQlVBVc9y+2/IJSvqtZz866SXw/mX+/e
         W0pJF0hWV7u78rKyEJP7X+RqylVKogh2sx+8h9p7boqcoyUCTkc5limXF7CmLJDfcO64
         ZVrNM92P6dDLOSAV+cQzWAkB0Oi1ZUWaebe4LyULhZgDomckhwu5VVQTDzeOX4bgRpgA
         /0tUSYkqtqp21tSUpv2QVc+s8tqJQkzTBfAXMfgsTGtf7UpIn7H/jiKHA6oIQEXZVTaZ
         Cs+HgkrMeohH6Yri08aBNMoVe4FgY5Dfy/Og6XJljrTyIxyihRg7OtaXxruVXMlYQ06a
         MXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698942533; x=1699547333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20owt2l3/cxGLzLA2xbevoL+xSQuNASMB596X3+ow7c=;
        b=jjasPjge1w06g73XKzjw1W1U9lJFKmU81H6CUvCIF8naIwm7g6dgVpUDxetrUUi5m9
         LnW2/oF3OWCmi7kPWTt3cB0tMdGd5a7fV5g2E0ZeJj2NHJqjXJeYZuDjkeOqG3b3EOOI
         jqY5vSduCabpw5hPgRvifwZr+18sIdiFxSOXsb1noawaiMswPOBB1NDHOJW0mYDM6GPH
         WlZMbdJS/MkqV7UZMcARSMZ/2B/RuN/lvQKr+c3HvFkjlyKg5GPtDjOLHSzRrHpp3hxC
         a8FY4nrBMzzuTwTp1muoE/t89/g/hu92B0A8V6v1O5Vwj9GqwBLjGvxqeGs8q26Uzu+O
         MKAg==
X-Gm-Message-State: AOJu0Yzj/nSaZP1sSdiY+uzFd4hMH47qkK5zwn3KLv07dYMHXva4XI7c
        VpQgsyNmmvMayaVsI7pYw0PoZ5E6u8eHmzmOjQ/jkA==
X-Google-Smtp-Source: AGHT+IGzC+UPQWsYSxEKly7WToGYHThIxdsAXI0NVkPIoloyom3O4LGBjzNagfuu2dI4j91jKOVPOWF7c1N4gZ20sPc=
X-Received: by 2002:a5d:4b51:0:b0:32d:8e54:29f6 with SMTP id
 w17-20020a5d4b51000000b0032d8e5429f6mr14415276wrs.47.1698942532901; Thu, 02
 Nov 2023 09:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-17-seanjc@google.com>
 <ZUFGRyQEuWj4RJS0@google.com> <ZUFzZf-YmCRYP6qo@google.com>
 <CALzav=d9eXZfK=op7A=UftbpuPpUbxqV6CmkqqxxBNuNsUU4nw@mail.gmail.com>
 <6642c379-1023-4716-904f-4bbf076744c2@redhat.com> <ZUPIXt1XzZrriswG@google.com>
In-Reply-To: <ZUPIXt1XzZrriswG@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Thu, 2 Nov 2023 09:28:23 -0700
Message-ID: <CALzav=eaVc5rzmHwnQr7aotyTKi9Agdte7NAL0NvBeE+f6zYoA@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 9:03=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Thu, Nov 02, 2023, Paolo Bonzini wrote:
> > On 10/31/23 23:39, David Matlack wrote:
> > > > > Maybe can you sketch out how you see this proposal being extensib=
le to
> > > > > using guest_memfd for shared mappings?
> > > > For in-place conversions, e.g. pKVM, no additional guest_memfd is n=
eeded.  What's
> > > > missing there is the ability to (safely) mmap() guest_memfd, e.g. K=
VM needs to
> > > > ensure there are no outstanding references when converting back to =
private.
> > > >
> > > > For TDX/SNP, assuming we don't find a performant and robust way to =
do in-place
> > > > conversions, a second fd+offset pair would be needed.
> > > Is there a way to support non-in-place conversions within a single gu=
est_memfd?
> >
> > For TDX/SNP, you could have a hook from KVM_SET_MEMORY_ATTRIBUTES to gu=
est
> > memory.  The hook would invalidate now-private parts if they have a VMA=
,
> > causing a SIGSEGV/EFAULT if the host touches them.
> >
> > It would forbid mappings from multiple gfns to a single offset of the
> > guest_memfd, because then the shared vs. private attribute would be tie=
d to
> > the offset.  This should not be a problem; for example, in the case of =
SNP,
> > the RMP already requires a single mapping from host physical address to
> > guest physical address.
>
> I don't see how this can work.  It's not a M:1 scenario (where M is multi=
ple gfns),
> it's a 1:N scenario (wheren N is multiple offsets).  The *gfn* doesn't ch=
ange on
> a conversion, what needs to change to do non-in-place conversion is the p=
fn, which
> is effectively the guest_memfd+offset pair.
>
> So yes, we *could* support non-in-place conversions within a single guest=
_memfd,
> but it would require a second offset,

Why can't KVM free the existing page at guest_memfd+offset and
allocate a new one when doing non-in-place conversions?

> at which point it makes sense to add a
> second file descriptor as well.  Userspace could still use a single guest=
_memfd
> instance, i.e. pass in the same file descriptor but different offsets.
