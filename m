Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA0D79928E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 00:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344534AbjIHW7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 18:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjIHW7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:59:07 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320AF1FEB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 15:59:03 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id BCCB2320095B;
        Fri,  8 Sep 2023 18:59:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 08 Sep 2023 18:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-id:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1694213941; x=
        1694300341; bh=AVa2iU7isfYOihwSnrZn9s+Ygc1uEyi3ymZHBdxzyGs=; b=C
        LR3jhl3GzQRfozzrZ8d7zOzR9BW2W0I+wU7sLmv3nRQqYXtSyVdvn9HnooWlXbT1
        5S6eWZeFZpat6Zifrv79VaoSUzs7PsDxjQ3SDljTj+jvGU3Y3hvdqKB3CkRxEwo4
        SyMRetaxzAMjN5942ljfXUHe3Mvz8gNhFU4iYsCgBbLgOUeWHyDqjwFvnW4Z5ZlV
        6eAnAU3Wn+v3XWStqw5wIT8ehGXrDPr2bTcfytet8L/ykxzqRsgWcUaKH5bUe3zG
        8a+tTxR6gIc3ZigkMTyyp+fVYMcEFEQydVXGnEXOvlzaAnebzN5mt0mrnWPdKmHh
        djrlcSUrJLBUYXuGFj19Q==
X-ME-Sender: <xms:NKf7ZPQzntiSh6_1jRL9SunU8JLb1cvVVVMAUyb9zkTxeCTTpaUf-A>
    <xme:NKf7ZAxz7yJ00BE4cEtwJ80NxwP3mHf9hxqQ_RD_QtScMsDfmGESJZag5XhKe_izm
    Rk2v6rheaQZgJqBhvk>
X-ME-Received: <xmr:NKf7ZE0cwW-CjCk6X24Ng-g4dv-YnEbEzyJMyKBohNaY0ya5jTRbohMi0YfEwIWuKeqzxVKJdp12CdO6gv2o8U_whTTcYnU-Tto>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehkedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehmtderredttdejnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelfeeklefggfetkedukeevfffgvdeuheetffekledtfeejteelieejteeh
    geelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:NKf7ZPCmhTYhslxjaGNNVIvL7zDoOPoVfrJVq0jUoBdVSLxcSJK2Xg>
    <xmx:NKf7ZIh4Z4ztnNqoPcU2Lwn4yMSoUAEqsfW8mpsVCdrA8UOhXcl7Tw>
    <xmx:NKf7ZDoen0zpLW2qfuR5Flk06zLSkPcomGO1ZPLwnyg1UTey512P6w>
    <xmx:Naf7ZEjYi1GvjubnrxBT1_dysexK2S50pyYt13zMYCpEQMzuml1Trw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Sep 2023 18:58:58 -0400 (EDT)
Date:   Sat, 9 Sep 2023 08:59:11 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Philip Blundell <philb@gnu.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 32/52] m68k: mac: Add and use "mac.h"
In-Reply-To: <CAMuHMdV1Xejj2hmS6fO=gviRCuqL82S+9nFLtSkJjH-aALWThQ@mail.gmail.com>
Message-ID: <4a126e21-6c36-024b-9ab1-b4798ef274d4@linux-m68k.org>
References: <cover.1694093327.git.geert@linux-m68k.org> <e9f3da9b152b7d19b64d775d04e9e11b63dc35b6.1694093327.git.geert@linux-m68k.org> <1c7894fe-4cf4-1ad9-5ed2-aaab4351ff4c@linux-m68k.org>
 <CAMuHMdV1Xejj2hmS6fO=gviRCuqL82S+9nFLtSkJjH-aALWThQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463811774-325678859-1694213835=:13296"
Content-ID: <dc62573c-a8e6-d248-7fd8-89db80912592@nippy.intranet>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-325678859-1694213835=:13296
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <0046fe36-494a-d0fa-fe49-88f0be5cfc9a@nippy.intranet>

On Fri, 8 Sep 2023, Geert Uytterhoeven wrote:

> On Fri, Sep 8, 2023 at 1:44=E2=80=AFAM Finn Thain <fthain@linux-m68k.org>=
 wrote:
> > On Thu, 7 Sep 2023, Geert Uytterhoeven wrote:
> > > --- /dev/null
> > > +++ b/arch/m68k/mac/mac.h
> > > @@ -0,0 +1,25 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +struct rtc_time;
> > > +
> >
> > I don't think we need a new header file. Related function prototypes
> > already have homes in existing header files --
> >
> > > +/* baboon.c */
> > > +void baboon_init(void);
> > > +
> >
> > this could go into mac_baboon.h
> >
> > > +/* iop.c */
> > > +void iop_init(void);
> > > +
> >
> > mac_iop.h
> >
> > > +/* misc.c */
> > > +int mac_hwclk(int op, struct rtc_time *t);
> > > +
> >
> > macintosh.h
> >
> > > +/* macboing.c */
> > > +void mac_mksound(unsigned int freq, unsigned int length);
> > > +
> >
> > mac_asc.h
> >
> > > +/* oss.c */
> > > +void oss_init(void);
> > > +
> >
> > mac_oss.h
> >
> > > +/* psc.c */
> > > +void psc_init(void);
> > > +
> >
> > mac_psc.h
> >
> > > +/* via.c */
> > > +void via_init(void);
> > > +void via_init_clock(void);
> >
> > mac_via.h
>=20
> All mac*.h you suggest live under arch/m68k/include/asm/, and are thus=20
> shared with the whole tree, while only the core code under arch/m68k/=20
> needs these definitions.
>=20

I guess #include "../mac/mac.h" is expected but
#include "../../m68k/mac/mac.h" is not intended (?)
---1463811774-325678859-1694213835=:13296--
