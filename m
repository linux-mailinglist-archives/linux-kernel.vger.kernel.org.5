Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8060280DC7A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345012AbjLKVD5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 16:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344987AbjLKVD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:03:56 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAE8B6;
        Mon, 11 Dec 2023 13:04:02 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b8652c0bd2so356826b6e.1;
        Mon, 11 Dec 2023 13:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702328642; x=1702933442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YcmIjbD4ilvUJJ/ddZWdrhHOetOQgyrrR2/xbKsOJOE=;
        b=XvS+o7P/FB0KBj6ixdPo3z8a0OU7Oawccz970nShq8ETnlEzWMp51FdCdI9fabym2E
         5tC/IQmklMQtE79w4LcvczBhKmZtimPggadlfbnIu+Md71l3zR5GbipXqfg563CsZkIq
         kER3JQliDBy7CRu2N3s7wZ7EwrDSa5iQZN+UFFSuAGhYTO9liU1bzrPFlLObou6tP+61
         6ZRWQMZtcGEju8q130UuZKtSNkDKRRzK+pyQhQ+yiYaMNoLk69rHEbfqeAohK2pDcV3W
         sX3H5J2x3kGuitqXZdbhuR437WO+lpBn4/6pCPIPwDVJsHbO0E7Aa+Ai+JrpYpir7B82
         qENA==
X-Gm-Message-State: AOJu0YwYCWlzxYKdub/L9igldYfa4PWaCaJ+laEA+lUBnpk5IwDoa5Ju
        fs8GKzw1ezDYFy7GYHdJdQc19CkrcA5/afw/apeUQyWo
X-Google-Smtp-Source: AGHT+IH6eTK0P1jlWaFq384C1b231MI2KUrjIyx8Hc2zjlAPFyoCXmien2MztNQ2kiKnQFeQL/P3ZF5BM61CLUgPbRA=
X-Received: by 2002:a05:6871:e717:b0:1fa:df87:4eba with SMTP id
 qa23-20020a056871e71700b001fadf874ebamr10609885oac.5.1702328642162; Mon, 11
 Dec 2023 13:04:02 -0800 (PST)
MIME-Version: 1.0
References: <20231020085106.12026-1-chaodong@nfschina.com>
In-Reply-To: <20231020085106.12026-1-chaodong@nfschina.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Dec 2023 22:03:50 +0100
Message-ID: <CAJZ5v0g873f9jHRfEfBhX4bYeyFR_1zuB_Jga+fKX0Tc7mQX9A@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_power=3A_snapshot=3A_Remove_unnecessary_=E2=80=980?=
        =?UTF-8?Q?=E2=80=99_values_from_error?=
To:     Wang chaodong <chaodong@nfschina.com>
Cc:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 10:51 AM Wang chaodong <chaodong@nfschina.com> wrote:
>
> error is assigned first, so it does not need to initialize the assignment.
>
> Signed-off-by: Wang chaodong <chaodong@nfschina.com>
> ---
>  kernel/power/snapshot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 87e9f7e2bdc05..9acdc4458a36d 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1119,7 +1119,7 @@ static void mark_nosave_pages(struct memory_bitmap *bm)
>  int create_basic_memory_bitmaps(void)
>  {
>         struct memory_bitmap *bm1, *bm2;
> -       int error = 0;
> +       int error;
>
>         if (forbidden_pages_map && free_pages_map)
>                 return 0;
> --

Applied as 6.8 material with rewritten subject and changelog.

Thanks!
