Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ECA755DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjGQICE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjGQICD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:02:03 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036069D;
        Mon, 17 Jul 2023 01:02:02 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-991f956fb5aso528493966b.0;
        Mon, 17 Jul 2023 01:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689580920; x=1692172920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Md2k3SrB9PFNNZtXw1D5bjJvxlmODL3oFcv29rGU+0w=;
        b=Tj9ESHlAIEY5Ok+t1+UQEqgXZpFohXw53hftfkkBeDtkJIo0nBvLvFnisMxq5Rj2iQ
         8PdNEnjyaoS3UOEi9nMjIifEQFGggbFY24svukX5rnVJOCICfNyxM2s59REzz8UWfsIp
         ZawCt/JduBAq7tD9sQFEtpyhZCVMxmJef/ARUOi/5XgDoiiri8ZVk3Ooe/THn+zFXcTM
         z4EiPvrbE/5ScWF5My9n5UAxbY+/u23lKTRQJM9dJ7+ItLjDQcSZkrc1jpUqsaxNIZmm
         zG/iJhwiSZQr96qBLHcF2SeD/Hsp4E00qsw5D1bKsKirfD/yPzGiMrlGRgYG+Tvf2j6d
         BgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689580920; x=1692172920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Md2k3SrB9PFNNZtXw1D5bjJvxlmODL3oFcv29rGU+0w=;
        b=WjAngw8foHGi8aI7Cz75jtYNU+tGbJFMxj6KegN4wMxnG1Sl6hgoXMuNrzYdsYFTvt
         PaBw5nf2fWRuDw2BGy8zPJ+RGcPgjb24w3imE/H/TnWJyBGeuK63dg+Ds548EygUUczE
         lBBSuOR644bLhuDdeBvMEz++0Y0pdhbs4WxuR2G2dw7BzkYwE+1YnCZ2QV0lfBxpFQHB
         q1LqoclTcxTtVjiGMjHaPVEq7RYEvx1rTnamTPNJf5ka+tX2vQQb6i9HdB8sB0U/bBEW
         jm5Xx35t39y801mGPurknekN8UEtED+8Y+zTKzG7KQsXx3i9ypArvAItz6vqEP8TDprM
         SDDw==
X-Gm-Message-State: ABy/qLbd88fBUbG9gCS4PVcxixSoaDaobZqy7bn5qhbmMW2Dpk1px4Yk
        YhopwWkvP+kyn12YIfc6yEZ/uk//IH7jPRj8INA=
X-Google-Smtp-Source: APBJJlHZQRmdkq0uytrbJpI4dB8Hr+FJMXkrPe3TaMiMWBSlVina9KNg9TPqxFql3z1+rKwkjMtlLgZZSjtgMCU/25g=
X-Received: by 2002:a17:906:20d6:b0:994:4e9c:30c6 with SMTP id
 c22-20020a17090620d600b009944e9c30c6mr3743404ejc.57.1689580920270; Mon, 17
 Jul 2023 01:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <b99a5149-c3d6-2a9b-1298-576a1b4b22c1@gmail.com> <0206e2ce-ff33-6017-15ab-cc89f1eb7485@augustwikerfors.se>
In-Reply-To: <0206e2ce-ff33-6017-15ab-cc89f1eb7485@augustwikerfors.se>
From:   Nils Kruse <nilskruse97@gmail.com>
Date:   Mon, 17 Jul 2023 10:01:49 +0200
Message-ID: <CAKVFSw+_EFNaYjOjNDQ0zOGoSFMt3yZctR47Rcss2KhkfNQJ9g@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Add quirk for Samsung PM9B1 256G and 512G SSD
To:     August Wikerfors <git@augustwikerfors.se>
Cc:     stable@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 9:30=E2=80=AFPM August Wikerfors <git@augustwikerfo=
rs.se> wrote:
>
> On 2023-06-11 13:41, Nils Kruse wrote:
> > Add a quirk for Samsung PM9B1 256G and 512G that reports duplicate ids
> > for disk.
>
> Is this the same issue with suspend as [1], [2] and [3] or is it a
> different case?
>
> [1] https://lore.kernel.org/all/20221116171727.4083-1-git@augustwikerfors=
.se/t/
> [2] https://github.com/tomsom/yoga-linux/issues/9
> [3] https://lore.kernel.org/all/d0ce0f3b-9407-9207-73a4-3536f0948653@augu=
stwikerfors.se/

Yes, this is the same issue.
