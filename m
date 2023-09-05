Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87B079244C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 17:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjIEP6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 11:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344472AbjIEDoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 23:44:16 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE48CCB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 20:44:12 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4141d8a4959so12899981cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 20:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693885451; x=1694490251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAZHJuenxcHpAilGOcCYgpTDOCH9+ws/HIfnUtOnAtU=;
        b=J8l8wDdHabzfac0jkMIe3eU8GR0PfomtQ8NupJZ/95WVie4VchlCbCJB69ybk2O5GT
         Vzl8++6EBe9cK1uS6GEQ/G/gqUcFRGE5F6Zn8pkOmbP19of4frrrtLMExkanvx9Nt/1T
         82F0fCQlY101qxAQuvuemMKGcksFAGpaHhKmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693885451; x=1694490251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAZHJuenxcHpAilGOcCYgpTDOCH9+ws/HIfnUtOnAtU=;
        b=NcgsixEmgt0C3FYCWITFgcKB4V04ch6SJnmJparJP2WDrLAzcqTTnuZEtTyXXytbFn
         vewefhs2AWzPpkV5H7pm7U6p8QpVw2e7IzSzwbXuXLEyXpunyKlFMN8XbhEQlf88S8jk
         XDqLNDyt4nP/ID3GOqUPwjy4C9Tiw2Acz8JDI9oxqMIVD9HMqPN93E++MuUHlx/UrMJp
         my4t49vZ3BvMQmq6k+pEYScDxiKuy6d68G3GEtDhK95yer5KBGvanh4jrB9BctuL56y6
         RLNXdsV07pz6Qu71tcawVNcu4qhj/yqKQXzlV3rhUyi8GkmAx9ZMwee0gAumfRO7cCqu
         G4qA==
X-Gm-Message-State: AOJu0YxJdjVAXe5vHK3NngUXp6imFvuj8w7l1hxeX2HF0OUcQF2sjLdm
        4hAmUFVK393+bLjdi7acwHWty22HmzSwjJ8Kfjy0Yg==
X-Google-Smtp-Source: AGHT+IHTF6SxyGvgJB3dRBEPvW9H9bNLFPVll2r2F4nFq2ca2GNEbNhLYsQuMKPhaVBj9MVSWfqmqg==
X-Received: by 2002:ac8:5d94:0:b0:412:f105:280f with SMTP id d20-20020ac85d94000000b00412f105280fmr14645261qtx.52.1693885451024;
        Mon, 04 Sep 2023 20:44:11 -0700 (PDT)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com. [209.85.219.44])
        by smtp.gmail.com with ESMTPSA id jr26-20020a05622a801a00b004054b435f8csm4016268qtb.65.2023.09.04.20.44.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 20:44:10 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-64aaf3c16c2so12493756d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 20:44:10 -0700 (PDT)
X-Received: by 2002:ad4:42af:0:b0:651:735c:26f1 with SMTP id
 e15-20020ad442af000000b00651735c26f1mr11597948qvr.55.1693885449698; Mon, 04
 Sep 2023 20:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230828075420.2009568-1-anle.pan@nxp.com> <DB9PR04MB9284AA58AA71655C9C0C7C9A87E6A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5DYxwX+JdXQ_-ba5B9y+gyWPjvUpCBnKM1zz1W2EkO_vA@mail.gmail.com> <DB9PR04MB928460023FB3CCCBC3EACE1487E9A@DB9PR04MB9284.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB928460023FB3CCCBC3EACE1487E9A@DB9PR04MB9284.eurprd04.prod.outlook.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 5 Sep 2023 12:43:50 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BGJX7=Z1ukFRq_ktaQ0d7FbvV-ob5gs8hfGaNHUXPTww@mail.gmail.com>
Message-ID: <CAAFQd5BGJX7=Z1ukFRq_ktaQ0d7FbvV-ob5gs8hfGaNHUXPTww@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
To:     Hui Fang <hui.fang@nxp.com>
Cc:     Anle Pan <anle.pan@nxp.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jindong Yue <jindong.yue@nxp.com>,
        Xuegang Liu <xuegang.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 4, 2023 at 4:10=E2=80=AFPM Hui Fang <hui.fang@nxp.com> wrote:
>
> On Wed, Aug 30, 2023 at 6:20=E2=80=AFPM Tomasz Figa <tfiga@chromium.org> =
wrote:
> > On Wed, Aug 30, 2023 at 5:50=E2=80=AFPM Hui Fang <hui.fang@nxp.com> wro=
te:
> ......
> > > I wonder if only NXP met the "swiotlb buffer full" issue. In theory,
> > > when format is YUYV, those resolutions no greater than 320x240 (15360=
0
> > > bytes, which less than the max mapping size 256K ) can't meet the iss=
ue.
> > > But resolutions no less than 640x480 (307200 bytes), may have chances
> > > to trigger the issue.
> >
> > I think a combination of a device that can support scatter-gather, but =
requires
> > swiotlb is kind of rare. Most drivers would require a single contiguous=
 DMA
> > address (and thus use videobuf2-dma-contig) and physical discontinuity =
would
> > be handled by an IOMMU (transparently to vb2).
> >
> > I guess one thing to ask you about your specific setup is whether it's =
expected
> > that the swiotlb ends up being used at all?
>
> Yes, the swiotlb ends up being used. We met the issue when bring up
> DeviceAsWebCam (android-14 new feature, android device works as a usb cam=
era).

I see. I guess the mapping is done by the USB gadget controller
driver? Could you point us to the exact driver that's used?

Just to clarify, swiotlb should only be needed in the very extreme
fallback case, because of the performance impact of the memory copy
back and forth. The right approach would depend on the DMA
capabilities of your device, though.

Best regards,
Tomasz
