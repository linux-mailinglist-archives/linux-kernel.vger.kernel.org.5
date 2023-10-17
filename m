Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649C37CC95C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjJQRBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjJQRBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:01:31 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172B794;
        Tue, 17 Oct 2023 10:01:30 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d849df4f1ffso6752954276.0;
        Tue, 17 Oct 2023 10:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697562089; x=1698166889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1tr9jWdezKrUj+39blyTgNP6WvZwQ4TQTB9h22LmJc=;
        b=WqGcvlQkScUEGD2fI0k84y7BSQ11MXcsNAdRmtes2sOYu1PivjDHNjqJiourBrngza
         a7/HrRIGeZuqvnZs3ZU/6oz/rM0hwz6mYFOPnletFwfO+V6+tvIKvq9DwQDEWxcB3Xaw
         iyLq8QdLlJFltf92zPjIRmQookIl68INMidj7RG9bWdapAy29ivO8XJgmKZPfyWAFgF9
         rrLWWqYaZRrKo8F16ZZOkF3J5IJZmPZFywvnUQymudGA4KJovZvVrd91x91oC/pf+Q98
         EY/BogrsSxWNlw37Zte61Oz2GBX9jVSTBcpw/+sRA+G/8Lh2Lqx8Sen20Cpd9NUNLLH/
         AIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697562089; x=1698166889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1tr9jWdezKrUj+39blyTgNP6WvZwQ4TQTB9h22LmJc=;
        b=QZKC3WIrQMG+9skkaMMU0cdhLPJBNJDYUugglEuYpO9JsAirI7l2kFOqRYyx9lSHPN
         hGtK+msmUMPY/OBk60MFZoHPyCzJwJ/xp6NGYTaNB64qxgJPMKOPziY+IS+y+P1C7fsD
         8XQm8eFXljSdFqgVJ9UeaNx+KGb6VoYvT/fYcqk9vujJiQNuaRPhNOdHr1AOn7hmfM8m
         uZ/cXjHXeV9sAwYiC34ek+t17rzIbmv2k4l6AHVqtncBYj3BMrzfr2L7rw5UDC3h8u3s
         H1ceyIn2d3Nmn2IMm/XK84C9XxlZnuueSQlWQsuH5/9iTkHDya3l/aFSmpe90P6H+svC
         m2og==
X-Gm-Message-State: AOJu0YyfPqrpQbuzPVYhjsjt4xlrR6XPtaCCd2h+DyjeKn+C/AO5LH4T
        UFIMd9XZL6RjFUUIMBq+B48RLCyMzHW4pzO7lr8=
X-Google-Smtp-Source: AGHT+IGf7Em5MIZZVpUU/TCD6kqm/cIoCSak3omjVO1oEnWJVwM16E43TLPBUgTCCsXYNYKfQGU7sa20HbGHwKjjFlA=
X-Received: by 2002:a25:2584:0:b0:d9a:ca91:9f18 with SMTP id
 l126-20020a252584000000b00d9aca919f18mr2653469ybl.14.1697562089117; Tue, 17
 Oct 2023 10:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231016020847.1270258-1-haowenchao2@huawei.com>
In-Reply-To: <20231016020847.1270258-1-haowenchao2@huawei.com>
From:   Wenchao Hao <haowenchao22@gmail.com>
Date:   Wed, 18 Oct 2023 01:01:18 +0800
Message-ID: <CAOptpSMN31B6M38VyH6FhBOLTafTP645NgEv62qQA0A8EShjiA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] cleanup patch
To:     Wenchao Hao <haowenchao2@huawei.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        louhongxiang@huawei.com
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

On Mon, Oct 16, 2023 at 10:09=E2=80=AFAM Wenchao Hao <haowenchao2@huawei.co=
m> wrote:
>
> This is a cleanup patchset, no logic changed.
>
> The first patch just cleanup scsi_dev_queue_ready();
> The second patch add comment for target_destroy callback of
> scsi_host_template to tell it is called in atomic context.
>

Friendly ping...

> V2:
>   - Tell which spinlock is held in comment of target_destroy
>
> Wenchao Hao (2):
>   scsi: core: cleanup scsi_dev_queue_ready()
>   scsi: Add comment of target_destroy in scsi_host_template
>
>  drivers/scsi/scsi_lib.c  | 35 ++++++++++++++++++-----------------
>  include/scsi/scsi_host.h |  3 +++
>  2 files changed, 21 insertions(+), 17 deletions(-)
>
> --
> 2.32.0
>
