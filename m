Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B370879E405
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbjIMJon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239380AbjIMJoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:44:39 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7F2198C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:44:35 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-64a5bc53646so40860396d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694598273; x=1695203073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9pWS5RKacUJB+Dks28jDzi/RTSOwkJtyGFeCb9s9pw=;
        b=fFLDJHG/ehIv5uE6W/xrd+cyq4pSuwHnR+Xt81evRx0L6ZqVnSviiCzI1TfVCT+don
         DCf28hoqRRUvK5iX6e2e41ppB1nZ0CnzmpYR9PUzSFmZXDxzn1fBmowhGRIFujNFfxjX
         xrlF7Q+jkFOoXbP0nt9sG81QOT24MUyUi3bCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694598273; x=1695203073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9pWS5RKacUJB+Dks28jDzi/RTSOwkJtyGFeCb9s9pw=;
        b=V6Rmtir0Gz6VL8ul5w/Yrql0GbDj7axPj+SuVeQ61ymyjJYo1af8KKseOzr8U+QuYj
         xX2D96vdgoZsve+2iw2oFCRfPqgWYNfMODqTLhOzxsa9VjZgfqZFF6xJxL0m+KNs4eim
         vPU/pLHBPdwRlSl6L8p1l8dfSq/MEw8QlkBRIDxNsjUQWIp4zg6EfvUAn4PvN9aAlZvr
         96SWWJmI0SpRzMvnMb6NEO9rOkC4TmgVsETlOiL1ifABiT7uYl4rfB2AR4fbFiSBPEhr
         h55emvJGgKdUIDXEX6TVlhO2qr3GA44Mq73lvPDUwRWlp7tErmQ621rBdC7kVf2GmDUn
         CHlg==
X-Gm-Message-State: AOJu0YyGS27gs0+X9vc6uWjJW1aYcrZAwNOtF72nH7enXx8xVst3sdLq
        umpe205woaeT/A91hg23FVcBYrEpplFuqTkEj6s=
X-Google-Smtp-Source: AGHT+IETuh3wr/GAC5U8ZeLRitdkL5MVSgZnvbexRSaM5X61tp+BFW2ohBapwL6pC4Pd4C0mz1eHyg==
X-Received: by 2002:ad4:44af:0:b0:63f:9aa3:867b with SMTP id n15-20020ad444af000000b0063f9aa3867bmr2095170qvt.40.1694598273559;
        Wed, 13 Sep 2023 02:44:33 -0700 (PDT)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com. [209.85.219.47])
        by smtp.gmail.com with ESMTPSA id x15-20020ad4458f000000b00655e5724eebsm2538373qvu.66.2023.09.13.02.44.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 02:44:33 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-64c2e2572f7so40842156d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:44:32 -0700 (PDT)
X-Received: by 2002:a05:6214:8ce:b0:64f:518d:ac91 with SMTP id
 da14-20020a05621408ce00b0064f518dac91mr2055205qvb.8.1694598271822; Wed, 13
 Sep 2023 02:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230828075420.2009568-1-anle.pan@nxp.com> <DB9PR04MB9284AA58AA71655C9C0C7C9A87E6A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5DYxwX+JdXQ_-ba5B9y+gyWPjvUpCBnKM1zz1W2EkO_vA@mail.gmail.com>
 <DB9PR04MB928460023FB3CCCBC3EACE1487E9A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5BGJX7=Z1ukFRq_ktaQ0d7FbvV-ob5gs8hfGaNHUXPTww@mail.gmail.com>
 <DB9PR04MB9284A0CDB1FC7CAADE0A394F87EFA@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5AugUGh7Z=9Qh7SS4=-0ddGBmRAOOyCGDfPdT-=eurtUg@mail.gmail.com>
 <DB9PR04MB9284A45033B3E24F44C5AA3987F2A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5Bk0DUq5jgFDHV2wGYEcfQzNVQ2KYJ2ZYLubwFLgqW4kQ@mail.gmail.com>
 <DB9PR04MB92846D75C93A9B2B8C8A998D87F1A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5Ar18TvFE3jXBuphpCiwWAb8O99wqkiwEVDSs3+MXvW0w@mail.gmail.com>
 <DB9PR04MB9284404C1E1F1300EEF5A70487F1A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5Aq=ZrNGQU6psXJXt1ak2SkoRrZ=QBzp+xxHmWre0zBVg@mail.gmail.com> <DB9PR04MB9284A1DAB3C642C57298893A87F0A@DB9PR04MB9284.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB9284A1DAB3C642C57298893A87F0A@DB9PR04MB9284.eurprd04.prod.outlook.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 13 Sep 2023 18:44:15 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BQ+FsuKipxE-yh3P-NbPdc_U=FHp7PBkWY-xunxthKuA@mail.gmail.com>
Message-ID: <CAAFQd5BQ+FsuKipxE-yh3P-NbPdc_U=FHp7PBkWY-xunxthKuA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
To:     Hui Fang <hui.fang@nxp.com>
Cc:     Anle Pan <anle.pan@nxp.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jindong Yue <jindong.yue@nxp.com>,
        Xuegang Liu <xuegang.liu@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 6:14=E2=80=AFPM Hui Fang <hui.fang@nxp.com> wrote:
>
> On Tue, Sep 12, 2023 at 16:52=E2=80=AFPM Tomasz Figa <tfiga@chromium.org>=
 wrote:
> > Right. You may want to try modifying vb2_dma_sg_alloc_compacted() to us=
e
> > dma_alloc_pages() instead of alloc_pages().
>
> Thanks for your suggestion, it works. And it's a better resolution since =
no need
> an extra copy from high buffer to low buffer.

Great to hear! Could you submit a patch? Would appreciate adding

Suggested-by: Tomasz Figa <tfiga@chromium.org>

above the Signed-off-by line if you don't mind. Thanks.

Best regards,
Tomasz
