Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DE578872A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244712AbjHYMZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244880AbjHYMZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:25:25 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C40212B;
        Fri, 25 Aug 2023 05:24:49 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-649edb3a3d6so4262986d6.0;
        Fri, 25 Aug 2023 05:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692966237; x=1693571037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AI4j/imUS1MUuQuGpKi9NalKkJwpNjUoHfF8ByAQng=;
        b=UdvTOpoxY/bhUnWcwMDoPK3kdZpyKVKrnioA961W9+oEUcjNgxrV5Tue0bv+v//qKs
         DtTT4REBuL39Fb1rY2VvgwZqPWpBaEycuMWT47HyyU8xheDjANC+hJjSXkOexRPpeMsE
         bYE11Fw4GrJPX1jpt0LVAb7i3hbt1HoMstnhvT4/2YYzb5ItJrp6L1eXl+d6u2ENnyeW
         cN5pclyTlYuHMZD2ag9nQGV3lw5WrRxyO3uu3bE1XS+n/D/UKlb3yNjI9/T7SZoWyY9v
         Oy7wMP/Cfn89YnHV9haKI8PJOlcxkEDy81a6qMXacVgbw4FiygZge8pLy3XfPd1WEp/M
         SA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692966237; x=1693571037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5AI4j/imUS1MUuQuGpKi9NalKkJwpNjUoHfF8ByAQng=;
        b=S8JMOuRUFrf9+/XyDFMuEyhgFM/W+htkLAyyfeTHOO993jSSIOFXx+r+WUgkwo5c5q
         nYXgX5H9vkPDBnWNQ5z/j3BmIFSEE8kvMDvzRn5LaID3BRAYy1HIurXACdPRj81mEV16
         Ygt+IVwH3I7wx/3fVQu5e+yvKEonRCW0zO1//UxI8vhF3AIlnroN0I0PJVxHDQcrSAEf
         mfmqvyJ9WfURhrfstRGWWpw7KN99k0v7cYUea8ZIj960PaEcG8fkdIxuK8C0GzkHqU+X
         RWBPdcZlu76jyilUVpCSQehUAB05FqzS+8+w30OYqPjkL5ywcAhtDRTSzrXriuM4j7j/
         HHAQ==
X-Gm-Message-State: AOJu0Yxsvcyu0gJJEj/HVkmHtQRFsZMfvKhuyHST5bXcgrfCZYyF0QEX
        2VwYd1Y3nkQ50kGOeLJjWBtih+8KQ4yUwxj0FMe3if07K/g=
X-Google-Smtp-Source: AGHT+IGtZ7hZKI6y2+C2LIuIKucinFYqd9TnTYNAMR9h9zLHBa9eEs/JQljbdDYs/MShD6tHQS1vpuVnBnneRKpm9jc=
X-Received: by 2002:a0c:dc06:0:b0:64f:6625:48f4 with SMTP id
 s6-20020a0cdc06000000b0064f662548f4mr7140539qvk.5.1692966237149; Fri, 25 Aug
 2023 05:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <c8c059ce-53a9-3627-8984-dff771dff1de@rock-chips.com> <20230825083918.24334-1-Sharp.Xia@mediatek.com>
In-Reply-To: <20230825083918.24334-1-Sharp.Xia@mediatek.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Fri, 25 Aug 2023 20:23:45 +0800
Message-ID: <CA+Da2qxaCJwZhn0C7VxZzx8TB1VDR_xa2P0cDXUaNA9=YzSJYg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: Set optimal I/O size when mmc_setip_queue
To:     Sharp.Xia@mediatek.com
Cc:     shawn.lin@rock-chips.com, angelogioacchino.delregno@collabora.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        matthias.bgg@gmail.com, ulf.hansson@linaro.org,
        wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 7:43=E2=80=AFPM <Sharp.Xia@mediatek.com> wrote:
>
> On Fri, 2023-08-25 at 16:11 +0800, Shawn Lin wrote:
> >
> >  Hi Sharp,
> >
> > On 2023/8/25 15:10, Sharp Xia (=E5=A4=8F=E5=AE=87=E5=BD=AC) wrote:
> > > On Thu, 2023-08-24 at 12:55 +0200, Ulf Hansson wrote:
> > >>
> > >> External email : Please do not click links or open attachments
> > until
> > >> you have verified the sender or the content.
> > >>   On Fri, 18 Aug 2023 at 04:45, <Sharp.Xia@mediatek.com> wrote:
> > >>>
> > >>> From: Sharp Xia <Sharp.Xia@mediatek.com>
> > >>>
> > >>> MMC does not set readahead and uses the default
> > VM_READAHEAD_PAGES
> > >>> resulting in slower reading speed.
> > >>> Use the max_req_size reported by host driver to set the optimal
> > >>> I/O size to improve performance.
> > >>
> > >> This seems reasonable to me. However, it would be nice if you
> > could
> > >> share some performance numbers too - comparing before and after
> > >> $subject patch.
> > >>
> > >> Kind regards
> > >> Uffe
> > >>
> > >>>
> > >>> Signed-off-by: Sharp Xia <Sharp.Xia@mediatek.com>
> > >>> ---
> > >>>   drivers/mmc/core/queue.c | 1 +
> > >>>   1 file changed, 1 insertion(+)
> > >>>
> > >>> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> > >>> index b396e3900717..fc83c4917360 100644
> > >>> --- a/drivers/mmc/core/queue.c
> > >>> +++ b/drivers/mmc/core/queue.c
> > >>> @@ -359,6 +359,7 @@ static void mmc_setup_queue(struct mmc_queue
> > >> *mq, struct mmc_card *card)
> > >>>                  blk_queue_bounce_limit(mq->queue,
> > BLK_BOUNCE_HIGH);
> > >>>          blk_queue_max_hw_sectors(mq->queue,
> > >>>                  min(host->max_blk_count, host->max_req_size /
> > >> 512));
> > >>> +       blk_queue_io_opt(mq->queue, host->max_req_size);
> > >>>          if (host->can_dma_map_merge)
> > >>>                  WARN(!blk_queue_can_use_dma_map_merging(mq-
> > >queue,
> > >>>                                                          mmc_dev(
> > hos
> > >> t)),
> > >>> --
> > >>> 2.18.0
> > >>>
> > >
> > > I test this patch on internal platform(kernel-5.15).
> >
> > I patched this one and the test shows me a stable 11% performance
> > drop.
> >
> > Before:
> > echo 3 > proc/sys/vm/drop_caches && dd if=3D/data/1GB.img of=3D/dev/nul=
l
> >
> > 2048000+0 records in
> > 2048000+0 records out
> > 1048576000 bytes (0.9 G) copied, 3.912249 s, 256 M/s
> >
> > After:
> > echo 3 > proc/sys/vm/drop_caches && dd if=3D/data/1GB.img of=3D/dev/nul=
l
> > 2048000+0 records in
> > 2048000+0 records out
> > 1048576000 bytes (0.9 G) copied, 4.436271 s, 225 M/s
> >
> > >
> > > Before:
> > > console:/ # echo 3 > /proc/sys/vm/drop_caches
> > > console:/ # dd if=3D/mnt/media_rw/8031-130D/super.img of=3D/dev/null
> > > 4485393+1 records in
> > > 4485393+1 records out
> > > 2296521564 bytes (2.1 G) copied, 37.124446 s, 59 M/s
> > > console:/ # cat /sys/block/mmcblk0/queue/read_ahead_kb
> > > 128
> > >
> > > After:
> > > console:/ # echo 3 > /proc/sys/vm/drop_caches
> > > console:/ # dd if=3D/mnt/media_rw/8031-130D/super.img of=3D/dev/null
> > > 4485393+1 records in
> > > 4485393+1 records out
> > > 2296521564 bytes (2.1 G) copied, 28.956049 s, 76 M/s
> > > console:/ # cat /sys/block/mmcblk0/queue/read_ahead_kb
> > > 1024
> > >
> Hi Shawn,
>
> What is your readahead value before and after applying this patch?
>

Hi Sharp
Use "echo 1024 > sys/block/mmcblk0/queue/read_ahead_kb" instead of
"blk_queue_io_opt(mq->queue, host->max_req_size);"=EF=BC=9F
