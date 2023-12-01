Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874B9800E64
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379500AbjLAPRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379498AbjLAPRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:17:22 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088261BD8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:16:44 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54c54a3b789so1396839a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701443803; x=1702048603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqyWOd2V2jjfULDVhDbfTsYOuXxG/ALnevGqkLboVV0=;
        b=AsrYZTDpwYBlWhDKwbRHaHPZl/zlpKnsCUETmt96rl/sOmzlIrfQ3DS1zSJ5NzuXLK
         G8j2TzyleC4l0i2DwOA6XXTd0RMn3iB3s5lRCkV7UHwYI2/CQB1MIdpKdyzk6S4CVOuZ
         SK7stsQATU3i6/fNY2qqccopKhRrsaH+RGe7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443803; x=1702048603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqyWOd2V2jjfULDVhDbfTsYOuXxG/ALnevGqkLboVV0=;
        b=bcR/DIhOSbiq6rfbTbley9ZnjNrneGI9RJEahMFGPUxxxCgph4mBOVo/H6z7T5abry
         W8aNpnizg2q5PNRI9HV6KlsHVpE1LDY1nuqZS+nR33a3i1oBjpTbwAt+X/dRn9Gw8E4d
         WALOVugU+YLtSI7tQVNz4UAJaMbI8DjyVaaeL/yF9AGrsmET4F4ZFWG3J2fkBB2FipKl
         PAApaeO2Y2o31mgjGRj8q6LCJzSB2LG9WetPj6w2uBHGuu7IT+r+FAqaDb/8G+Xk6XGd
         yT7j1WYYkvu+9+retei9lFJ5Au353Lxxj1n9AHh4u6CGisXlPLQeMSvLZkWLXXEJTuH+
         hlOA==
X-Gm-Message-State: AOJu0Yz33FFoblWPDul1VGj+k95iAAvG+rmQ8IBzoQb1IMJ7/s3YyNhu
        3/hAz4bnadEmdbW67477CzIRSt3PFVS2DCAXDPDCeQ==
X-Google-Smtp-Source: AGHT+IFOLQds9xwK4v7msrl0MltyoxBizBxY9cLpoMVFJj3ZNT+A1s65meJrBFBGUI0pIqmgQz54Eg==
X-Received: by 2002:a50:d547:0:b0:54c:511f:e240 with SMTP id f7-20020a50d547000000b0054c511fe240mr1228543edj.41.1701443803497;
        Fri, 01 Dec 2023 07:16:43 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id y13-20020a056402270d00b0054c5710b518sm638647edd.38.2023.12.01.07.16.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 07:16:43 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so69915e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:16:43 -0800 (PST)
X-Received: by 2002:a05:600c:54e7:b0:3f7:3e85:36a with SMTP id
 jb7-20020a05600c54e700b003f73e85036amr131039wmb.7.1701443802948; Fri, 01 Dec
 2023 07:16:42 -0800 (PST)
MIME-Version: 1.0
References: <20231201083926.1817394-1-judyhsiao@chromium.org> <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com>
In-Reply-To: <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 Dec 2023 07:16:30 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vf18TxUWpGTN9b=iECq=5BmEoopQjsMH2U6bDX2=T3cQ@mail.gmail.com>
Message-ID: <CAD=FV=Vf18TxUWpGTN9b=iECq=5BmEoopQjsMH2U6bDX2=T3cQ@mail.gmail.com>
Subject: Re: [PATCH v1] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
To:     Eric Dumazet <edumazet@google.com>
Cc:     Judy Hsiao <judyhsiao@chromium.org>,
        David Ahern <dsahern@kernel.org>,
        Simon Horman <horms@kernel.org>,
        Brian Haley <haleyb.dev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Joel Granados <joel.granados@gmail.com>,
        Julian Anastasov <ja@ssi.bg>,
        Leon Romanovsky <leon@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
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

Hi,

On Fri, Dec 1, 2023 at 1:10=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, Dec 1, 2023 at 9:39=E2=80=AFAM Judy Hsiao <judyhsiao@chromium.org=
> wrote:
> >
> > We are seeing cases where neigh_cleanup_and_release() is called by
> > neigh_forced_gc() many times in a row with preemption turned off.
> > When running on a low powered CPU at a low CPU frequency, this has
> > been measured to keep preemption off for ~10 ms. That's not great on a
> > system with HZ=3D1000 which expects tasks to be able to schedule in
> > with ~1ms latency.
>
> This will not work in general, because this code runs with BH blocked.
>
> jiffies will stay untouched for many more ms on systems with only one CPU=
.
>
> I would rather not rely on jiffies here but ktime_get_ns() [1]
>
> Also if we break the loop based on time, we might be unable to purge
> the last elements in gc_list.
> We might need to use a second list to make sure to cycle over all
> elements eventually.
>
>
> [1]
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index df81c1f0a57047e176b7c7e4809d2dae59ba6be5..e2340e6b07735db8cf6e75d23=
ef09bb4b0db53b4
> 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table *tbl)
>  {
>         int max_clean =3D atomic_read(&tbl->gc_entries) -
>                         READ_ONCE(tbl->gc_thresh2);
> +       u64 tmax =3D ktime_get_ns() + NSEC_PER_MSEC;

It might be nice to make the above timeout based on jiffies. On a
HZ=3D100 system it's probably OK to keep preemption disabled for 10 ms
but on a HZ=3D1000 system you'd want 1 ms. ...so maybe you'd want to use
jiffies_to_nsecs(1)?

One worry might be that we disabled preemption _right before_ we were
supposed to be scheduled out. In that case we'll end up blocking some
other task for another full timeslice, but maybe there's not a lot we
can do there?

-Doug
