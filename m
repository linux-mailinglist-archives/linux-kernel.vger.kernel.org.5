Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E1C78B3B0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjH1Ovp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjH1OvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:51:14 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5193FDA;
        Mon, 28 Aug 2023 07:51:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-26934bc3059so2896642a91.1;
        Mon, 28 Aug 2023 07:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693234271; x=1693839071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXt3TPcvYVKlMyqkhhKh3WWuCwebjJYnvbJKeXFlF8E=;
        b=bm5t2JRousUW/OmMCAh3g2yChDTZAAQ8r/oHIidAa1mYEmhKOA0YCEpJgr7XOnFxpV
         GcgyK3sY6w8SbuFbfH8s8Q7Fmycwoogu+ptOxPTJE4KpU/ArkNO/lTv7ZOegYUSfwQ8n
         kI+CDI2ObiZQ/zTcX1VEguygAYZY1kHE/35i4YYSg6oRhnAfY5bBNH37TaFGXt4pZk5X
         7Ych72lZhzV4eo/8FJiuabfVF3r38+So5CP9A0jnp/BWSt+ZUdku//fPb45TzzbDNlVH
         eL483Lb40DV3qYuu9cpL03iV1CDONIwl0b3JVrtvsfMRFuV10NKP/imGusJ7ZvbUgfwQ
         LndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693234271; x=1693839071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXt3TPcvYVKlMyqkhhKh3WWuCwebjJYnvbJKeXFlF8E=;
        b=Rqla2jTMJTmCbSbV4N5bpi+ykopNJOjL8B9yTE9koznWHI1QfvxnymKPZOW+jS1qMz
         TIcdb1rynPpW9rD6gW60lRuAO3lmAXDD3G2Wbu7uPdrOhmV+9hpQd7b/rBzR//32ebA+
         NcxZUQoA3FWd+5LBZVWm/crZHPmKlzWtI4EtfxysgCatO3M8h6Ov/MzXX31NUqlVkPYz
         yPNPdolB0nl5tB7nxUz3Lk0gay+eRXDgx11AXiZAT3FC3bs1ZW2YmzAlbKbp36H+ncwu
         ewEfIuQC/aZ9wa8uem6CjGyW7rHFhmoA371vqAJ07Txqe4V6hpLrSKW769l5bCcbnZTM
         nH9Q==
X-Gm-Message-State: AOJu0Yweu3IOOZB1YpevYpoNlzRW68Nga+dadKJ/KV7QJXI+HEz41qRN
        l1wlEHjkTrQ+XdinscdY53OXKqO8sQr7402IeSo=
X-Google-Smtp-Source: AGHT+IEI+yJ38Xcj4TQATOLF0HwaGi0+NYyhXtwDO0IrxG7wjYR04CEQ2HjTdCyC/wOGO6EutWF8oFyYwQXngT5A9Zs=
X-Received: by 2002:a17:90a:c985:b0:261:2824:6b8c with SMTP id
 w5-20020a17090ac98500b0026128246b8cmr38768851pjt.13.1693234270559; Mon, 28
 Aug 2023 07:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230816100113.41034-1-linyunsheng@huawei.com>
 <20230816100113.41034-2-linyunsheng@huawei.com> <CAC_iWjJd8Td_uAonvq_89WquX9wpAx0EYYxYMbm3TTxb2+trYg@mail.gmail.com>
 <20230817091554.31bb3600@kernel.org> <CAC_iWjJQepZWVrY8BHgGgRVS1V_fTtGe-i=r8X5z465td3TvbA@mail.gmail.com>
 <20230817165744.73d61fb6@kernel.org> <CAC_iWjL4YfCOffAZPUun5wggxrqAanjd+8SgmJQN0yyWsvb3sg@mail.gmail.com>
 <20230818145145.4b357c89@kernel.org> <1b8e2681-ccd6-81e0-b696-8b6c26e31f26@huawei.com>
 <20230821113543.536b7375@kernel.org> <5bd4ba5d-c364-f3f6-bbeb-903d71102ea2@huawei.com>
 <20230822083821.58d5d26c@kernel.org> <79a49ccd-b0c0-0b99-4b4d-c4a416d7e327@huawei.com>
 <20230823072552.044d13b3@kernel.org> <CAKgT0UeSOBbXohq1rZ3YsB4abB_-5ktkLtYbDKTah8dvaojruA@mail.gmail.com>
 <5aae00a4-42c0-df8b-30cb-d47c91cf1095@huawei.com> <20230825170850.517fad7d@kernel.org>
In-Reply-To: <20230825170850.517fad7d@kernel.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 28 Aug 2023 07:50:33 -0700
Message-ID: <CAKgT0UeHfQLCzNALUnYyJwtGpUnd=4JbMSy00srgdKZz=SFemw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Mina Almasry <almasrymina@google.com>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 5:08=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 25 Aug 2023 17:40:43 +0800 Yunsheng Lin wrote:
> > > One additional thing we could consider would be to simply look at
> > > having page_pool enforce a DMA mask for the device to address any
> > > cases where we might not be able to fit the address. Then in the
> > > unlikely event that somebody is running a 32b system with over 16
> > > terabytes of RAM. With that the DMA subsystem would handle it for us
> > > and we wouldn't have to worry so much about it.
> >
> > It seems there is a API to acquire the DMA mask used by the device:
> > https://elixir.free-electrons.com/linux/v6.4-rc6/source/include/linux/d=
ma-mapping.h#L434
> >
> > Is it possible to use that to check if DMA mask used by the device is
> > within 32 + PAGE_SHIFT limit, if yes, we use jakub's proposal to reduce
> > reduce the dma address bit, if no, we fail the page_pool creation?
>
> IMO you're making this unnecessarily complicated. We can set the masks
> in page pool core or just handle the allocation failure like my patch
> does and worry about the very unlikely case when someone reports actual
> problems.

Actually we could keep it pretty simple. We just have to create a
#define using DMA_BIT_MASK for the size of the page pool DMA. We could
name it something like PP_DMA_BIT_MASK. The drivers would just have to
use that to define their bit mask when they call
dma_set_mask_and_coherent. In that case the DMA API would switch to
bounce buffers automatically in cases where the page DMA address would
be out of bounds.

The other tweak we could look at doing would be to just look at the
dma_get_required_mask and add a warning and/or fail to load page pool
on systems where the page pool would not be able to process that when
ANDed with the device dma mask.

With those two changes the setup should be rock solid in terms of any
risks of the DMA address being out of bounds, and with minimal
performance impact as we would have verified all possibilities before
we even get into the hot path.
