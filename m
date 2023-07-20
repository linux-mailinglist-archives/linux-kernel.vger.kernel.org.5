Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F14175A8DD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjGTIOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGTION (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:14:13 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC00E172A;
        Thu, 20 Jul 2023 01:14:12 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id E0E67168C97;
        Thu, 20 Jul 2023 10:14:10 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1689840851; bh=xrpHTACrVoZG7MNSm/D8K7vhd21yQrNcC9Y59ZeXRvs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=3dd5Pavmv3EXKNAnnR95EiSeSQ2THQUdM5wMjtCg0ChzLt/QUmCXzUOB/38fD8mLk
         pyi6yZ1E36fc6dVkU4iROaJCHSNuoayo36vmhwrxilJg22KieWiuPFpNO9POe83OP6
         w/LYkzTz/FO9CHthSROhqFP5h1/CyJay2rWag0Ojzfm4NKFwj+3ycKGyMFXaEpi1IM
         F5e3mTJfOrAF5pYv5RQeB3Ub4VIXhxADABWKFfLAMIOjbP7zZIIzYOwdjf1R1742Ip
         QjGS92dn0WHV1QT7i2g89YpdooKhVyiSAd2Atp3oB8tlSZc8NdlmEQYo5AhZATkk3W
         hxtId0DxzzqfA==
Date:   Thu, 20 Jul 2023 10:14:09 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Seo <james@equiv.tech>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "moderated list:XEN HYPERVISOR ARM" <xen-devel@lists.xenproject.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:XEN SWIOTLB SUBSYSTEM" <iommu@lists.linux.dev>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 2/8] swiotlb: add documentation and rename
 swiotlb_do_find_slots()
Message-ID: <20230720101409.559a2a34@meshulam.tesarici.cz>
In-Reply-To: <20230720080110.GA6358@lst.de>
References: <cover.1689261692.git.petr.tesarik.ext@huawei.com>
        <11826bfbc148771ab36d0b485558aa52cbdd204f.1689261692.git.petr.tesarik.ext@huawei.com>
        <20230720063819.GB3842@lst.de>
        <20230720095609.55b3a642@meshulam.tesarici.cz>
        <20230720080110.GA6358@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 10:01:10 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Jul 20, 2023 at 09:56:09AM +0200, Petr Tesa=C5=99=C3=ADk wrote:
> > On Thu, 20 Jul 2023 08:38:19 +0200
> > Christoph Hellwig <hch@lst.de> wrote:
> >  =20
> > > On Thu, Jul 13, 2023 at 05:23:13PM +0200, Petr Tesarik wrote: =20
> > > > From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> > > >=20
> > > > Add some kernel-doc comments and move the existing documentation of=
 struct
> > > > io_tlb_slot to its correct location. The latter was forgotten in co=
mmit
> > > > 942a8186eb445 ("swiotlb: move struct io_tlb_slot to swiotlb.c").
> > > >=20
> > > > Use the opportunity to give swiotlb_do_find_slots() a more descript=
ive
> > > > name, which makes it clear how it differs from swiotlb_find_slots()=
.   =20
> > >=20
> > > Please keep the swiotlb_ prefix.  Otherwise this looks good to me. =20
> >=20
> > Will do. Out of curiosity, why does it matter for a static (file-local)
> > function? =20
>=20
> Because it makes looking at stack traces much easier.

Got it. Thanks!

Petr T
