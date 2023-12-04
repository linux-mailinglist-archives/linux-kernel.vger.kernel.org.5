Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DC080415D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjLDWLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbjLDWK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:10:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909E9D5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701727861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ByMP2bESxZ3CqMK+J+SZZoIbcIxRH2MhetgkMxSeNbY=;
        b=PBJoyeOSjUNabJFdPe0dKPTByBJvg3uIfNX2ygo42m3L1twGeFGYbJ6tjCxiIQab85km4O
        jWTgQtUkh1uZI+J+ngyfLjYe/24oPQYlghJJVpPf+J1BIx+ahvGkKdtyOd2ClSLSwelFdi
        He/rNWQvEtA1cAHV6NPS3AbHvotldUc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-J5F8-bPnMd-Cz5cGXTLtWw-1; Mon, 04 Dec 2023 17:11:00 -0500
X-MC-Unique: J5F8-bPnMd-Cz5cGXTLtWw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-54cb71a5e16so924102a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 14:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701727859; x=1702332659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByMP2bESxZ3CqMK+J+SZZoIbcIxRH2MhetgkMxSeNbY=;
        b=F1YG6vkUqxK/Li0Tf3PMnX+IRcHb4pDhyFKOiNKKICl8EclareMdTalN0DmpJAizVT
         Aj7/zgztphjpdjdfiNOP8zap8rYi1PXTImarex00WNhK0ko1Dt1A2Dl1ZLB8+caTBspf
         tB+zzzCk+nfocIM+Dl7z4gsuG5La7YcukB7MmGrHkyaz1Ng0u2yYNd3Ym6nHQBY9T7xH
         Sqgp+dRFgDGJiXSN4LJ3Kmb5SXNX5HMgzZreBXGtetS9UtRNLI+7Jywe26le5EQB2tLn
         2Uo/ApigsPeXXVkP6flPATToyqiHibXLR47tTqvBuE1fBYd/W80ZLRTL9YoYp5n5Mt2q
         qjVw==
X-Gm-Message-State: AOJu0YwvpXwCFPV38uof2xs/Z1FddPfu4yqQOXJp8oqkvxaNlPq/uCVt
        8Dutoz67iZznqpi2xF77xJneThX1ejSmKT+SBWCYjqA7Yi7BJ741Pf93cgTLiMY7BALFeYh7VuM
        olOAkM1KN3m10fzHEDMCtPa3FMgun9XSzkjQpib8Z
X-Received: by 2002:a50:9b50:0:b0:54c:4837:9a9b with SMTP id a16-20020a509b50000000b0054c48379a9bmr3196285edj.66.1701727859413;
        Mon, 04 Dec 2023 14:10:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHM83t2E2F5MEvtLCeFKdyCdGinuyTdBMq99IevqF0/lsod/1pMqyIMLZhiL2fY6fb1yfa70gAJ6m2xRNaJbb0=
X-Received: by 2002:a50:9b50:0:b0:54c:4837:9a9b with SMTP id
 a16-20020a509b50000000b0054c48379a9bmr3196280edj.66.1701727859077; Mon, 04
 Dec 2023 14:10:59 -0800 (PST)
MIME-Version: 1.0
References: <20231202150807.2571103-1-srasheed@marvell.com>
In-Reply-To: <20231202150807.2571103-1-srasheed@marvell.com>
From:   Michal Schmidt <mschmidt@redhat.com>
Date:   Mon, 4 Dec 2023 23:10:47 +0100
Message-ID: <CADEbmW12OWS6et2wp3skicUM=V81x8dS4_aySYP1Ok0kEc2M9Q@mail.gmail.com>
Subject: Re: [PATCH net v1] octeon_ep: initialise control mbox tasks before
 using APIs
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hgani@marvell.com, vimleshk@marvell.com, egallen@redhat.com,
        pabeni@redhat.com, horms@kernel.org, kuba@kernel.org,
        davem@davemloft.net, wizhao@redhat.com, konguyen@redhat.com,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 2, 2023 at 4:08=E2=80=AFPM Shinas Rasheed <srasheed@marvell.com=
> wrote:
> Do INIT_WORK for the various workqueue tasks before the first
> invocation of any control net APIs. Since octep_ctrl_net_get_info
> was called before the control net receive work task was even
> initialised, the function call wasn't returning actual firmware
> info queried from Octeon.

It might be more accurate to say that octep_ctrl_net_get_info depends
on the processing of OEI events. This happens in intr_poll_task.
That's why intr_poll_task needs to be queued earlier.
Did octep_send_mbox_req previously always fail with EAGAIN after
running into the 500 ms timeout in octep_send_mbox_req?

Apropos octep_send_mbox_req... I think it has a race. "d" is put on
the ctrl_req_wait_list after sending the request to the hardware. If
the response arrives quickly, "d" might not yet be on the list when
process_mbox_resp looks for it.
Also, what protects ctrl_req_wait_list from concurrent access?

Michal

> Fixes: 8d6198a14e2b ("octeon_ep: support to fetch firmware info")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
>  .../net/ethernet/marvell/octeon_ep/octep_main.c    | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/driver=
s/net/ethernet/marvell/octeon_ep/octep_main.c
> index 552970c7dec0..3e7bfd3e0f56 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> @@ -1193,6 +1193,13 @@ int octep_device_setup(struct octep_device *oct)
>         if (ret)
>                 return ret;
>
> +       INIT_WORK(&oct->tx_timeout_task, octep_tx_timeout_task);
> +       INIT_WORK(&oct->ctrl_mbox_task, octep_ctrl_mbox_task);
> +       INIT_DELAYED_WORK(&oct->intr_poll_task, octep_intr_poll_task);
> +       oct->poll_non_ioq_intr =3D true;
> +       queue_delayed_work(octep_wq, &oct->intr_poll_task,
> +                          msecs_to_jiffies(OCTEP_INTR_POLL_TIME_MSECS));
> +
>         atomic_set(&oct->hb_miss_cnt, 0);
>         INIT_DELAYED_WORK(&oct->hb_task, octep_hb_timeout_task);
>
> @@ -1333,13 +1340,6 @@ static int octep_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>         queue_delayed_work(octep_wq, &octep_dev->hb_task,
>                            msecs_to_jiffies(octep_dev->conf->fw_info.hb_i=
nterval));
>
> -       INIT_WORK(&octep_dev->tx_timeout_task, octep_tx_timeout_task);
> -       INIT_WORK(&octep_dev->ctrl_mbox_task, octep_ctrl_mbox_task);
> -       INIT_DELAYED_WORK(&octep_dev->intr_poll_task, octep_intr_poll_tas=
k);
> -       octep_dev->poll_non_ioq_intr =3D true;
> -       queue_delayed_work(octep_wq, &octep_dev->intr_poll_task,
> -                          msecs_to_jiffies(OCTEP_INTR_POLL_TIME_MSECS));
> -
>         netdev->netdev_ops =3D &octep_netdev_ops;
>         octep_set_ethtool_ops(netdev);
>         netif_carrier_off(netdev);
> --
> 2.25.1
>

