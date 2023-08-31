Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA8478EB41
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344744AbjHaLBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjHaLBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:01:31 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABC5CDD;
        Thu, 31 Aug 2023 04:01:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a21b6d105cso75352666b.3;
        Thu, 31 Aug 2023 04:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693479686; x=1694084486; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eO3kPR8hwQQNiVrq80EvGuv/qgY68iFDiiKzJDgISpA=;
        b=sQGjiDMQtLroc4/97tbRzBaGDZk+doUSB8g1gfusUjUaaq4A5uOvYJnRbrKTHYtAew
         NoBXcIn2vC+t+1hgfyrVTKOZA8SuagjPwFV4J1A+dBtMWIX8EjknqvPlm4r+Ns7YrSXS
         f/HePrmEFelZUgGH1i5JypJvHygulqOOGOvQASsEumALpPFldLMzK09NBYVRE3DjQA6G
         7v0QAlQFV4rMQwAsSYDEC9kMklvjnnyHBglrTuE1FG1GVgfnvNQyGYd0vtN7ZbACov5b
         V2gYGhjZoS9dRMWMLDnsQso1iOTj7dxMJtZvJdGwBKplvcRKBO/wMQ25qgdFOE1ibXRX
         5llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693479686; x=1694084486;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eO3kPR8hwQQNiVrq80EvGuv/qgY68iFDiiKzJDgISpA=;
        b=XL0ld+PXRjD5itQ7PABFwWu4XkuCP8ZNEXA4G5VbgJj3YjHMWGJNwpRqkOr8WJW1Y9
         UWPvUmBbXBpuokues9wmtb15oCRU9fMBgQHZ0lK6LaFEivFp+GOow/PhWocOwSI27bcf
         1pdvRvH8AxCTAZFYVo+ZKCEw5g4+B5kajiveeErOy7hRnpDh4+y31EHiKtYuVCgZ7YM+
         e+4TWS25vvNwMbO62H+z+R0JgbXDHKGgdSDpdGfhbuKUwlbWXjW4/TanxJjGtlUawXug
         +U+7Rb50LYz9D1H1HP6SxGVD1v0YqRbx5nAgGtxFMaeFUCcOr5JnDcdDVR0MU1VArOzV
         tBcw==
X-Gm-Message-State: AOJu0Yy6Oe4jf/Eah0YmLABvtwHzcLNnUa0m86bjjoNThWzpVcsitYvZ
        Cx0dxxZfRk+qQjSStGNzOQo=
X-Google-Smtp-Source: AGHT+IFKmUNRd857qFSDmC7Upxx+JxDAYy0VxA0KOk6zd6KKRErWFaSuBzEdyne6H556QfNF9Fh96Q==
X-Received: by 2002:a17:906:53cd:b0:9a1:fcd7:b825 with SMTP id p13-20020a17090653cd00b009a1fcd7b825mr3980283ejo.71.1693479686140;
        Thu, 31 Aug 2023 04:01:26 -0700 (PDT)
Received: from ?IPv6:2001:a61:3488:8a01:c631:bde5:1eff:9b66? ([2001:a61:3488:8a01:c631:bde5:1eff:9b66])
        by smtp.gmail.com with ESMTPSA id c25-20020a170906529900b0099b42c90830sm638090ejm.36.2023.08.31.04.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 04:01:25 -0700 (PDT)
Message-ID: <066d686946951e270e8fca127d8332c80b6cfac8.camel@gmail.com>
Subject: Re: [PATCH v4 0/6] iio: Add buffer write() support
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 31 Aug 2023 13:01:24 +0200
In-Reply-To: <20230830171836.000045c3@Huawei.com>
References: <20230807112113.47157-1-paul@crapouillou.net>
         <20230830171118.00007726@Huawei.com> <20230830171836.000045c3@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-30 at 17:18 +0100, Jonathan Cameron wrote:
> On Wed, 30 Aug 2023 17:11:18 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>=20
> > On Mon,=C2=A0 7 Aug 2023 13:21:07 +0200
> > Paul Cercueil <paul@crapouillou.net> wrote:
> >=20
> > > [V3 was: "iio: new DMABUF based API, v3"][1]
> > >=20
> > > Hi Jonathan,
> > >=20
> > > This is a subset of my patchset that introduced a new interface based=
 on
> > > DMABUF objects [1]. It adds write() support to the IIO buffer
> > > infrastructure.
> > >=20
> > > The reason it is not the full IIO-DMABUF patchset, is because you
> > > requested performance benchmarks - and our current numbers are barely
> > > better (~ +10%) than the fileio interface. There is a good reason for
> > > that: V3 of the patchset switched from having the IIO core creating t=
he
> > > DMABUFs backed by physically contiguous memory, to having the IIO cor=
e
> > > being a simple DMABUF importer, and having the DMABUFs created
> > > externally. We now use the udmabuf driver to create those, and they a=
re
> > > allocated from paged memory. While this works perfectly fine, our
> > > buffers are now cut in 4 KiB chunks (pages), non-contiguous in memory=
,
> > > which causes the DMA hardware to create an IRQ storm, as it raises an
> > > interrupt after each 4 KiB in the worst case scenario.=C2=A0=20
> >=20
> > Interesting. I'm guessing you don't necessarily need contiguous memory
> > and huge pages would get rid of most of that overhead?
> >=20
> > Given embedded target those huge pages are hard to get so you need
> > hugetlb support to improve the chances of it working.=C2=A0 Some quick =
searching
> > suggests there is possible support on the way.
> > https://lore.kernel.org/linux-mm/20230817064623.3424348-1-vivek.kasired=
dy@intel.com/
> >=20
> >=20
> > >=20
> > > Anyway, this is not directly a problem of the IIO-DMABUF code - but I
> > > can't really upstream a shiny new interface that I claim is much fast=
er,
> > > without giving numbers.
> > >=20
> > > So while we fix this (either by updating the DMA IP and driver to
> > > support scatter-gather)=C2=A0=20
> >=20
> > Long run you almost always end up needing that unless contig requiremen=
ts
> > are small and you want a robust solution.=C2=A0 I'm guessing no IOMMU t=
o pretend
> > it's all contiguous...=20
> >=20
> > > or by hacking something quick to give us
> > > physically contiguous DMABUFs just for the benchmark), I thought it
> > > would make sense to upstream the few patches of the V3 patchset that =
are
> > > needed for the IIO-DMABUF interface but aren't directly related.=C2=
=A0=20
> >=20
> > Good idea.
> >=20
> > >=20
> > > As for write() support, Nuno (Cc'd) said he will work on upstreaming =
the
> > > DAC counterpart of adc/adi-axi-adc.c in the next few weeks, so there
> > > will be a user for the buffer write() support. I hope you are okay wi=
th
> > > this - otherwise, we can just wait until this work is done and submit=
 it
> > > all at once.=C2=A0=20
> >=20
> > Absolutely fine, though I won't pick this up without the user also bein=
g
> > ready to go.
>=20
>=20
> Having looked through these again, they are straight forward so no change=
s
> requested from me.=C2=A0 Nuno, if you can add this set into appropriate
> point in your series that will make use of it that will make my life easi=
er
> and ensure and minor rebasing etc happens without having to bother Paul.
>=20

Sure...

- Nuno S=C3=A1
>=20
