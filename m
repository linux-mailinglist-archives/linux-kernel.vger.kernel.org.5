Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3754C7E52B4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbjKHJg7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Nov 2023 04:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHJg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:36:57 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7296E199
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:36:54 -0800 (PST)
Received: from loongson.cn (unknown [209.85.219.181])
        by gateway (Coremail) with SMTP id _____8CxLOuzVktlw_83AA--.39042S3;
        Wed, 08 Nov 2023 17:36:52 +0800 (CST)
Received: from mail-yb1-f181.google.com (unknown [209.85.219.181])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxjd6xVktlPfA7AA--.2220S3;
        Wed, 08 Nov 2023 17:36:50 +0800 (CST)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso6081632276.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 01:36:50 -0800 (PST)
X-Gm-Message-State: AOJu0YzVQSQpIp8TCw1R0p806bK2Wi2+0IDndMW/8R0OaCDcsd95lnfL
        zKAu1WPylUfqxGxgLvpXDVeCB7ABB1JZTOFCWNg/iw==
X-Google-Smtp-Source: AGHT+IF7Egb8RiUObh7jAE8iM4wFRrqgo9bG5b8f2JcO57JxfoqZyKyA977e/ECC4xVaAtAw/8f7y7/RheUTwoNIqyA=
X-Received: by 2002:a05:6902:1008:b0:da0:5933:c62d with SMTP id
 w8-20020a056902100800b00da05933c62dmr1369671ybt.28.1699436208883; Wed, 08 Nov
 2023 01:36:48 -0800 (PST)
MIME-Version: 1.0
References: <20231108040447.288870-1-wangrui@loongson.cn> <d32d8a26dcd75a840727cdb50546b621d34d326b.camel@xry111.site>
 <CAHirt9jQHTRGdv4rShgvWHEbG1vzuLkNDbxLP7x4eMtuB3BB5g@mail.gmail.com> <4075b4dad9bedbc3def5dfe75f66f3e5d49ce6d5.camel@xry111.site>
In-Reply-To: <4075b4dad9bedbc3def5dfe75f66f3e5d49ce6d5.camel@xry111.site>
From:   WANG Rui <wangrui@loongson.cn>
Date:   Wed, 8 Nov 2023 17:36:38 +0800
X-Gmail-Original-Message-ID: <CAHirt9jRH1CKE=BUWpML_jNgTBvMfJiYoAYPnVS3E=89oBUVyw@mail.gmail.com>
Message-ID: <CAHirt9jRH1CKE=BUWpML_jNgTBvMfJiYoAYPnVS3E=89oBUVyw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Disable module from accessing external data directly
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, loongson-kernel@lists.loongnix.cn,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-CM-TRANSID: AQAAf8Cxjd6xVktlPfA7AA--.2220S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ury5CF4xXw4kJF1xGw4xXwc_yoW8Xr4kpa
        97GF1rKws7Xry8ZrnavFn7Z3Wa9a1xCrWxKFy8Cw15Zas0kr9rXa13tr4agFnFqrZ0gw12
        krs2ga47uryUXagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG
        67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
        IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
        14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzsqW
        UUUUU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 5:26 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Wed, 2023-11-08 at 17:20 +0800, WANG Rui wrote:
> > > then the linked binary triggers a SIGBUS.  Ideally this should be
> > > detected by the linker at link time, but currently the BFD linker
> > > fails
> > > to detect this error (FWIW this flaw is caused by a really nasty
> > > method
> > > for the medium code model implementation).  So to me -fno-direct-
> > > access-
> > > external-data is the default.  I also grepped for -fdirect-access-
> > > external-data in the kernel building system but I've not found any
> > > match.
> > >
> > > Are you using a different version of Clang, or maybe Clang has some
> > > configuration-time option to make -fdirect-access-external-data the
> > > default?
> >
> > The clang enables `direct-access-external-data` by default in PIC and
> > disables it by default in no-PIC. This also applies to PIE. [1]
>
> Oh sh*t:
>
> xry111@nanmen2 ~ $ clang t1.c -O2 -fno-pie -no-pie
> xry111@nanmen2 ~ $ ./a.out
> Bus error (core dumped)
>
> I'll consider it a Clang bug then.

That's it, no copy relocations. As far as I know, copying relocations
has some issues and is not recommended by Fangrui.

For modules, if distance is not a problem, `no-pic` and
`direct-access-external-data` can be together because the code is
writable. Does it seem reasonable to exist?

>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
>


-- 
WANG Rui

