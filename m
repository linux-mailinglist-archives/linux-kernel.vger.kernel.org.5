Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E102475FB7B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjGXQHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjGXQHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:07:21 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F83410F4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:07:16 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-583f837054eso14656277b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1690214835; x=1690819635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H+9hATyxM1wFvDyiZv4CUg26TjbnT4RKHY7Z6xDG7Qc=;
        b=n4RguLbipIDQE05X2UsocctdpugWflo7O4z8c3gwAfkLynyr8zm5/CVjbVs+tll8O7
         X0Ku/7bnlehb3Ox7SBdt1JsBF51lWhN9JK4rkJEMe0mtYfMYNmhReGcTwTaGi7XrgH6w
         AoqM98jUDwcsem/XlkeUawhQ/Quf5wkpYquBpA2iv6vMPHpiz/M0Efuv1r/EidPG0Cga
         g/AtYUJgSPRocmaMMJ5LbLxrodle3GBgnj/TYbtq4vGuFmT/0T6ZBnSct+p5l8T3d8J5
         iuyr8NvNhfPPNd6gvWBkWI3g9QTKs7q2xbyLTIMfzVy1BOOaCmxvRzGuXAOkGFLAzt4f
         aGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690214835; x=1690819635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H+9hATyxM1wFvDyiZv4CUg26TjbnT4RKHY7Z6xDG7Qc=;
        b=Q7UDu6vU92va0vtGi6ghi9d7SQrPS0p6o3k/05xUryMYlHHQ27CjGHV98jUXtcFH7f
         cPRia5D98Lz3VySlA27NYaMJwEt1X1eHhuOwdSN3HZf4VOGluYR7H4V20IxXF0yNOkRV
         9LB6VGrBbAAR3XL/t7WJADrxN8aXhLzmeUrDUYXw8daML8gE/OW6DE6/0d5+x46A3HP/
         mJ8lE5nbXJFfkJL3YOyB75WMa374y1q/u60DQvyp9RyTWD5rJPa1fYTYNzJtdfsqPabk
         Yh7EtKiLwboefkS1cKHdI47ZRtTI9J0xtl6HvP8wfS+iz8ZaRsn1NtVZ40s0FjgKkO2O
         NWDQ==
X-Gm-Message-State: ABy/qLYO/D5euiJzi9BFzTTrQEF4JqonEGZ7500SYiH/0ODwPdaF8yUi
        x2XspnmRyTHY22mruk7NFpjzuKkiEBsl2xwloKCQLA==
X-Google-Smtp-Source: APBJJlHCWUTp7P04MApBHJlPyUxUZOvWwilt6qHx3n6q3KAE86ERNTh2oELFuCYqojOuLFYMFtf2PwJIimHh9n9Bbn0=
X-Received: by 2002:a25:ada1:0:b0:d0f:2038:9ca2 with SMTP id
 z33-20020a25ada1000000b00d0f20389ca2mr3639883ybi.51.1690214835437; Mon, 24
 Jul 2023 09:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAMEGJJ2RxopfNQ7GNLhr7X9=bHXKo+G5OOe0LUq=+UgLXsv1Xg@mail.gmail.com>
 <2023072438-aftermath-fracture-3dff@gregkh> <140065e3-0368-0b5d-8a0d-afe49b741ad2@kernel.dk>
 <ecb821a2-e90a-fec1-d2ca-b355c16b7515@kernel.dk>
In-Reply-To: <ecb821a2-e90a-fec1-d2ca-b355c16b7515@kernel.dk>
From:   Phil Elwell <phil@raspberrypi.com>
Date:   Mon, 24 Jul 2023 17:07:04 +0100
Message-ID: <CAMEGJJ3SjWdJFwzB+sz79ojWqAAMULa2CFAas0tv+JJLJMwoGQ@mail.gmail.com>
Subject: Re: [PATCH] io_uring: Use io_schedule* in cqring wait
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg KH <gregkh@linuxfoundation.org>, andres@anarazel.de,
        asml.silence@gmail.com, david@fromorbit.com, hch@lst.de,
        io-uring@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens, Greg,

On Mon, 24 Jul 2023 at 16:58, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 7/24/23 9:50?AM, Jens Axboe wrote:
> > On 7/24/23 9:48?AM, Greg KH wrote:
> >> On Mon, Jul 24, 2023 at 04:35:43PM +0100, Phil Elwell wrote:
> >>> Hi Andres,
> >>>
> >>> With this commit applied to the 6.1 and later kernels (others not
> >>> tested) the iowait time ("wa" field in top) in an ARM64 build running
> >>> on a 4 core CPU (a Raspberry Pi 4 B) increases to 25%, as if one core
> >>> is permanently blocked on I/O. The change can be observed after
> >>> installing mariadb-server (no configuration or use is required). After
> >>> reverting just this commit, "wa" drops to zero again.
> >>
> >> This has been discussed already:
> >>      https://lore.kernel.org/r/12251678.O9o76ZdvQC@natalenko.name

Sorry - a brief search failed to find that.

> >> It's not a bug, mariadb does have pending I/O, so the report is correct,
> >> but the CPU isn't blocked at all.
> >
> > Indeed - only thing I can think of is perhaps mariadb is having a
> > separate thread waiting on the ring in perpetuity, regardless of whether
> > or not it currently has IO.
> >
> > But yes, this is very much ado about nothing...
>
> Current -git and having mariadb idle:
>
> Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> Average:     all    0.00    0.00    0.04   12.47    0.04    0.00    0.00    0.00    0.00   87.44
> Average:       0    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
> Average:       1    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
> Average:       2    0.00    0.00    0.00    0.00    0.33    0.00    0.00    0.00    0.00   99.67
> Average:       3    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
> Average:       4    0.00    0.00    0.33    0.00    0.00    0.00    0.00    0.00    0.00   99.67
> Average:       5    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
> Average:       6    0.00    0.00    0.00  100.00    0.00    0.00    0.00    0.00    0.00    0.00
> Average:       7    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
>
> which is showing 100% iowait on one cpu, as mariadb has a thread waiting
> on IO. That is obviously a valid use case, if you split submission and
> completion into separate threads. Then you have the latter just always
> waiting on something to process.
>
> With the suggested patch, we do eliminate that case and the iowait on
> that task is gone. Here's current -git with the patch and mariadb also
> running:
>
> 09:53:49 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> 09:53:50 AM  all    0.00    0.00    0.00    0.00    0.00    0.75    0.00    0.00    0.00   99.25
> 09:53:50 AM    0    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
> 09:53:50 AM    1    0.00    0.00    0.00    0.00    0.00    1.00    0.00    0.00    0.00   99.00
> 09:53:50 AM    2    0.00    0.00    0.00    0.00    0.00    1.00    0.00    0.00    0.00   99.00
> 09:53:50 AM    3    0.00    0.00    0.00    0.00    0.00    1.00    0.00    0.00    0.00   99.00
> 09:53:50 AM    4    0.00    0.00    0.00    0.00    0.00    0.99    0.00    0.00    0.00   99.01
> 09:53:50 AM    5    0.00    0.00    0.00    0.00    0.00    1.00    0.00    0.00    0.00   99.00
> 09:53:50 AM    6    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
> 09:53:50 AM    7    0.00    0.00    0.00    0.00    0.00    1.00    0.00    0.00    0.00   99.00
>
>
> Even though I don't think this is an actual problem, it is a bit
> confusing that you get 100% iowait while waiting without having IO
> pending. So I do think the suggested patch is probably worthwhile
> pursuing. I'll post it and hopefully have Andres test it too, if he's
> available.

If you CC me I'll happily test it for you.

Thanks,

Phil

> --
> Jens Axboe
>
