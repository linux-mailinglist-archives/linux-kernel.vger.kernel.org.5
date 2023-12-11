Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C617B80DC39
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344939AbjLKU6u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 15:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344858AbjLKU6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:58:49 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD64CB;
        Mon, 11 Dec 2023 12:58:55 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5909156aea9so501645eaf.0;
        Mon, 11 Dec 2023 12:58:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702328334; x=1702933134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6ByGiT9WFMUFMKy+HhAkr+u0X6bTiLvBm2bjTbo8WQ=;
        b=SfwocifkhiF+7XM0LFMmxnlKaZtO8vJPxYj/2Y58gooYiBkZXOdPLB1zIm0aByYEcr
         BtJZyuu8ltHc/DlGsJlBZ8FFnxOnysRxA/U5c9/2Y6BDekWr7s7o7fvaPGNAjanvu8ov
         oJ7vAOMiLpQlfXQEE7M34ByUKxdBh8rv1aoXGCA+lpweeN5iOT0MC0c6fQ6tld2/UTPc
         ksc7LvB7QAg5oTITOFEqZqkbol37QGipBwLKCDDhbubiyHcvjkM8v+YTZr5DLB0w+3Tm
         2qW5lagLEMyIu+UKpnQxu6VeYJsvQ/33nqBmPwmgqN2gU/Y9S2q2JEG6jeSN2+yueEqz
         C3cA==
X-Gm-Message-State: AOJu0YzTa4jM5R0e3wjcJrobPbWJc2d/YharfkawA5uIJ9qsH3H1POZB
        /48i3HeeGoIMDRDWTAaicwxZWfzikAnPhPXFO3Q=
X-Google-Smtp-Source: AGHT+IGJG6VkapEFtpmMStjO8dS8/sKRcxgCxZjLP4PiW6fUcT/JqBeX1B3Q3gc2qat14ZMPMruLDLxpGsKT9qP06j4=
X-Received: by 2002:a4a:da02:0:b0:590:7b43:47e4 with SMTP id
 e2-20020a4ada02000000b005907b4347e4mr8624200oou.1.1702328334790; Mon, 11 Dec
 2023 12:58:54 -0800 (PST)
MIME-Version: 1.0
References: <20231020083743.11412-1-zhoujie@nfschina.com>
In-Reply-To: <20231020083743.11412-1-zhoujie@nfschina.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Dec 2023 21:58:44 +0100
Message-ID: <CAJZ5v0iJRDN=pzkBTqhJipnsDpqPS5ehxWUcKJ3RXAR2=hkD-Q@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_power=3A_main=3A_Remove_unnecessary_=E2=80=98NULL?=
        =?UTF-8?Q?=E2=80=99_initialization_from_last=5Ffailed=5Fstep=5Fshow=28=29?=
To:     ZhouJie <zhoujie@nfschina.com>
Cc:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 10:38 AM ZhouJie <zhoujie@nfschina.com> wrote:
>
> Declaring char *last_failed_step; is reasonable because you can later
> assign the function's return value to last_failed_step without
> explicitly assigning an initial value.

Did you want to say something like "it is not necessary to initialize
last_failed_step to NULL, because it is never read before being
assigned a value" ?

Also, to my eyes, last_failed_step is redundant and can be dropped
from that function entirely.

> Signed-off-by: ZhouJie <zhoujie@nfschina.com>
> ---
>  kernel/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index f6425ae3e8b05..24c675f6ab862 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -410,7 +410,7 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
>  {
>         int index;
>         enum suspend_stat_step step;
> -       char *last_failed_step = NULL;
> +       char *last_failed_step;
>
>         index = suspend_stats.last_failed_step + REC_FAILED_NUM - 1;
>         index %= REC_FAILED_NUM;
> --
> 2.18.2
>
