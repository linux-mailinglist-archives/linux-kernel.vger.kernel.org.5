Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A2880DCE0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344972AbjLKVPD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 16:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjLKVPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:15:01 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ADCBE;
        Mon, 11 Dec 2023 13:15:05 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6da06c505ccso550749a34.1;
        Mon, 11 Dec 2023 13:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702329305; x=1702934105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShV908uKHQ8j/q2SdlmwNDhfAbS3fETYLN+N3BXqHYs=;
        b=RwnbQpywAqTgpueJ2q/gkzUpxdOVED24PR9imDQn2Fv2zqjjehbZmKk7YizK/KTBK3
         bsp5X68BYe+lelaTK7ysNEQV5fM1gzI3hSRYCaDX0gqvNY/H4Z+rPkak/GPJg+FoC8iE
         T9/MhgdaUdfbe554gbnbCJTCLjuS1sqJqlWNnfn2tbII3UYK0uWsC0Ik2deVUUaT98+K
         Rb6I83F7DmKe7RQmjJjFHY4FKW5DdRtjobGVp2wwMAVzKeyulgh6qW0ZzFskvZLkPjG+
         skZ/ixFjNMhcYVVcdFMnJj2oLcIv6qwCQrsYCaZZ5e6g9qQ/H+UDV2eyi59PrSV2S52n
         z13Q==
X-Gm-Message-State: AOJu0Yy9DZvdYTfmFtDCd5mtQ3ndMoAlPR1vw/53ET66A+SxeITyEs6U
        GCrOIrSXzbIPY8xkaZwhqEgNcoin1olI4fkSFZo1GSoM
X-Google-Smtp-Source: AGHT+IHvGulAvqcIMEplX7CPNUZzrFCuQ8ytXiwmfCM/w9hUMupXPQE+XzfgW/DvSpooPl0Ba8YBd4xLJ/SAfNjPn8w=
X-Received: by 2002:a05:6871:289:b0:1fb:30b8:bb5c with SMTP id
 i9-20020a056871028900b001fb30b8bb5cmr10324867oae.3.1702329304988; Mon, 11 Dec
 2023 13:15:04 -0800 (PST)
MIME-Version: 1.0
References: <20231027021303.26187-1-kunyu@nfschina.com>
In-Reply-To: <20231027021303.26187-1-kunyu@nfschina.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Dec 2023 22:14:53 +0100
Message-ID: <CAJZ5v0jM=H=mAVLpDHbpUm1yg3rwHJg5JhN6ZyypW9cvo+H8Eg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_power=3A_swap=3A_Remove_unnecessary_=E2=80=980=E2=80=99_?=
        =?UTF-8?Q?values_from_ret?=
To:     Li kunyu <kunyu@nfschina.com>
Cc:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 4:13 AM Li kunyu <kunyu@nfschina.com> wrote:
>
> 'ret 'is first assigned a value and then used, it does not need to be
> assigned at definition time.

But the compiler may be confused, at least in the first case.

> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>  kernel/power/swap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 90bb583c57bf7..32e8cb6ceaea4 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -679,7 +679,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
>                            unsigned int nr_to_write)
>  {
>         unsigned int m;
> -       int ret = 0;
> +       int ret;

It is better to leave the code as is here as the compiler may still
complain about the initialization of ret.

>         int nr_pages;
>         int err2;
>         struct hib_bio_batch hb;
> @@ -1060,7 +1060,7 @@ static int load_image(struct swap_map_handle *handle,
>                        unsigned int nr_to_read)
>  {
>         unsigned int m;
> -       int ret = 0;
> +       int ret;
>         ktime_t start;
>         ktime_t stop;
>         struct hib_bio_batch hb;
> @@ -1166,7 +1166,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
>                            unsigned int nr_to_read)
>  {
>         unsigned int m;
> -       int ret = 0;
> +       int ret;
>         int eof = 0;
>         struct hib_bio_batch hb;
>         ktime_t start;
> --
> 2.18.2
>
