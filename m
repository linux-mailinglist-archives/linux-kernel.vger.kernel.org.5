Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A307F89F3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 11:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjKYK0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 05:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKYK0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 05:26:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6849D62
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 02:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700907998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wLQCR+hwcyQJXO1rzDrTi8/6fcFm4TdvVYYy57cW/E0=;
        b=GsL/e3top406g4tUx1gVeX944tFnG5DgC1P3qxcD5f0sCPPWT0gmlUXz1C4sLufYrMw8C9
        iZZmqMzIgnZdKd9jkWxzo3uKLGIJklaIvH5x1PTJJQxX3BZau82k6pcKYF8KHLhJuavZ4R
        qRB1zK1caYnoTf/yWV+wGQA/qfKzkSo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-eX_6BgD7MaexIHiOHTDneQ-1; Sat, 25 Nov 2023 05:26:36 -0500
X-MC-Unique: eX_6BgD7MaexIHiOHTDneQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5be39ccc2e9so3333579a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 02:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700907995; x=1701512795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLQCR+hwcyQJXO1rzDrTi8/6fcFm4TdvVYYy57cW/E0=;
        b=Ue8LVaeXKYf8qIlt/TL2M76UsT3soPW3fGRtByNMuS+v5qGWExEzWIJMEI/LoPZaMn
         9K1CwzTWMEW5GEnoSrTidMV8YHt8Qy/WfyfOi1Qm7N1c4Cxcq4OTl0WK7g8zBa1u/oBL
         LIhM9xtc/9inXzIC9DClEPgGLusyZV9u0kt9whKqCWeLFV8i0WeSzcgy19XLrWwPUoxR
         AQBBSimh+ndL5piJFObtQK4bH36vIm+sz3TbKMnrbcnb2/0z7dXTNul+yhRdNtNZTf1D
         puXyx48/nHRVcwRGPg7sH8jmSLHZbXLZIoOJ58+WTqVP+FF/P9XNVkjytR981aWHIG4s
         bakg==
X-Gm-Message-State: AOJu0YycQy+o9PRhSfMTMyoU4+nXGzgLdPuAawzFO/vTENeU7v4yCXGi
        ypOTduBj7vGH9cTnxhtd4BEO1F6YCZelbg5V7UeEDJWzeXzJEAYSm8QZ4aRgJcCqLm0ytlwvdzE
        g0oME9Hzp1AnajoWjWKrRP7nrlcfVmLGzMnng1CH7
X-Received: by 2002:a05:6a20:729c:b0:18b:826c:411b with SMTP id o28-20020a056a20729c00b0018b826c411bmr7123664pzk.17.1700907995673;
        Sat, 25 Nov 2023 02:26:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGj+gQkJqIindZjd3rTyUNigqh/fYulbFnVwdUMwwH5xmJ5qdJwem2NEr8aPpml+N3jfIVMwuQGohO5FkUFNTg=
X-Received: by 2002:a05:6a20:729c:b0:18b:826c:411b with SMTP id
 o28-20020a056a20729c00b0018b826c411bmr7123650pzk.17.1700907995306; Sat, 25
 Nov 2023 02:26:35 -0800 (PST)
MIME-Version: 1.0
References: <20231124075953.1932764-1-yukuai1@huaweicloud.com>
In-Reply-To: <20231124075953.1932764-1-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Sat, 25 Nov 2023 18:26:24 +0800
Message-ID: <CALTww28eDmnGC4SPPTezxS_QNvr_o5cz-npyhHMCRt=xcA+nVA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] md: bugfix and cleanup for sync_thread
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, yukuai3@huawei.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
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

On Fri, Nov 24, 2023 at 4:00=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Changes in v2:
>  - add patch 2;
>  - split some patches from v1 that will be sent separately;
>  - rework some commit message;
>  - rework patch 5;
>
> Yu Kuai (6):
>   md: fix missing flush of sync_work
>   md: remove redundant check of 'mddev->sync_thread'
>   md: remove redundant md_wakeup_thread()
>   md: don't leave 'MD_RECOVERY_FROZEN' in error path of
>     md_set_readonly()
>   md: fix stopping sync thread
>   dm-raid: delay flushing event_work() after reconfig_mutex is released
>
>  drivers/md/dm-raid.c |   3 +
>  drivers/md/md.c      | 149 ++++++++++++++++++++-----------------------
>  drivers/md/raid5.c   |   6 +-
>  3 files changed, 75 insertions(+), 83 deletions(-)
>
> --
> 2.39.2
>
For the series
Acked-by: Xiao Ni <xni@redhat.com>

