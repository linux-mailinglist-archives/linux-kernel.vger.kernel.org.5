Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2233480EEA9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376451AbjLLO0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjLLO0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:26:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F395AD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:26:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D05C433CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702391204;
        bh=+qJsvEnfvif5MXh/GMlXuF+eSOXDhh7AwIAYXsqp9Vo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MNFg3Oka802B/O3UYw4mb3SBj1uPaBDWBJITgUeGDjGxxF6Tm9lWgO6dEOWz/9rAk
         95zPEDi4NL5m7RWyfiUrpWMtS+BNeF2Q9Dkl2eTVIiphqMWZdA/gLOK8Kx2F0kpLka
         ksMKPsqZT6PA49+BQZKIAy4lzLI7kLnloDQJS/p3caGDFJqKPBkz8WZ8ZY+3i5nHrx
         pzQAn0xF8JLX0Zyzb1rqlH0jr5JzOEfdHkEEK/YNj7t8pTDbDXfDnKFBU7ETpF48zN
         69jR3oT9r/gB+NfJnOdoFYWhzzy2nXEfZTAitiOQhsWJxmhqwNTlMdSC1HtgWq6D0Y
         eLWNCpErlrCAQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50c0f6b1015so6734699e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:26:44 -0800 (PST)
X-Gm-Message-State: AOJu0YywES5Y/qVJcakZnP8kqinMfVfVnO/7aI60aXJ/aE4aLRmWJC4z
        9M4PxqQAoy8M+adYF06FPptHAzHOq+EahVuAIg==
X-Google-Smtp-Source: AGHT+IF/T5pQzrymJa7Oe578ltsoEfzzuSWBSOyxqt++BeSNPDZeqsctF7I4WdBT1IPIdQAlBu9FJTk31WETVif5++c=
X-Received: by 2002:ac2:531b:0:b0:50b:ee1e:3380 with SMTP id
 c27-20020ac2531b000000b0050bee1e3380mr2423910lfh.34.1702391203128; Tue, 12
 Dec 2023 06:26:43 -0800 (PST)
MIME-Version: 1.0
References: <20231207163128.2707993-1-robh@kernel.org> <BL1PR12MB5333564B386B8273120FD0109D8EA@BL1PR12MB5333.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5333564B386B8273120FD0109D8EA@BL1PR12MB5333.namprd12.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 12 Dec 2023 08:26:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJMK7s+uNk+GpppmAcprc+21Ffa4X1YLvRPrYhAPZ-PbA@mail.gmail.com>
Message-ID: <CAL_JsqJMK7s+uNk+GpppmAcprc+21Ffa4X1YLvRPrYhAPZ-PbA@mail.gmail.com>
Subject: Re: [PATCH 1/2] cdx: Enable COMPILE_TEST
To:     "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 10:40=E2=80=AFPM Agarwal, Nikhil <nikhil.agarwal@am=
d.com> wrote:
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Thursday, December 7, 2023 10:01 PM
> > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Gupta, Nipun
> > <Nipun.Gupta@amd.com>; Agarwal, Nikhil <nikhil.agarwal@amd.com>
> > Cc: linux-kernel@vger.kernel.org
> > Subject: [PATCH 1/2] cdx: Enable COMPILE_TEST
> >
> > There is no reason CDX needs to depend on ARM64 other than limiting
> > visibility. So let's also enable building with COMPILE_TEST.
> >
> > The CONFIG_OF dependency is redundant as ARM64 always enables it and al=
l
> > the DT functions have empty stubs.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/cdx/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig index
> > a08958485e31..7cdb7c414453 100644
> > --- a/drivers/cdx/Kconfig
> > +++ b/drivers/cdx/Kconfig
> > @@ -7,7 +7,7 @@
> >
> >  config CDX_BUS
> >       bool "CDX Bus driver"
> > -     depends on OF && ARM64
> > +     depends on ARM64 || COMPILE_TEST
> Hi Rob,
>
> There is a CDX MSI support patch
> https://lore.kernel.org/lkml/20231116125609.245206-1-nipun.gupta@amd.com/=
 which is in
> review and is dependent on ARM64( msi_alloc_info_t definition differs on =
x86). So, the
> COMPILE_TEST would break once the MSI changes are added.

An ifdef around 'scratchpad' should fix that. It is worthwhile to get
all this to build on x86 allyesconfig builds at least because that is
frequently built by the various CI systems. arm64 is getting there,
but x86 is first for many.

Rob
