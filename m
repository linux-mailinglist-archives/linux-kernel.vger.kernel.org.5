Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76496783285
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 22:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjHUTzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjHUTzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:55:19 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE73F11D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:55:17 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5257f2c0773so4635655a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1692647716; x=1693252516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHODIufbnuwNvzgvQHGm/W1L7WZK7VyHnjitbLRSOfQ=;
        b=ECdKsJIaDY8mYAOCu7++duAU5j+20akQbKY9Cz4RIVWAg0kB5bFzbf1MmAv3MnRxxg
         2fr8agBagTfv8iDS+HQb8PUOFtOqxnSAedB2a0mTtKeS8qlE2HMUSVf+HeXGx8Nkw0fs
         sBhEwtUCKBLrZ8M8f8BWi3F32u+VW75OxlfguZ+rbnhDWdCRGGQ2dc+o8sbICgpJLmPr
         elFaTwMd1RdY/6SWOTVV0eRbBsGUdVkLmxVMyNbx6/vOtbA6n+ZqWUjtMY7j2H1q6RE4
         AvzadKha8wxVSeO48nCYHMGPU/DAC2rn/uC7Y8CoWt8xnPe7p4XjCgW65Py4/ZaSFc1u
         IoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692647716; x=1693252516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHODIufbnuwNvzgvQHGm/W1L7WZK7VyHnjitbLRSOfQ=;
        b=II8w5BVLQj2iOGiyqXJhjjeca9cFxc5NOGQLtYTSw6Jk2Zj9MEXWSt2CbY0+aP9nCZ
         OY2LugsXCwAdwkkoyKLN5Sd83NcB6XY8ebqNBi61DbovIrUG+sP7EVTBzN7D69Zf+JU+
         P6BN340IM+Nf/FHgSM1YngXn8K7csnbDrb9KmL1NliHR2Oa+/BrAGQ2I4EAaqXLuM4tw
         6Tn/sNmD/6pCWmXTcfRQo9Tn8/OvK0c4+W3HBtAFTd7KUBPDsxRxOrgji1f+Yk9yCPZS
         vuMQvW74lGAbKEi8Nzym8Jy9g2nh5oguhO2/UDVZBpP6GG9HVt3leDuxMJGAd9fzUsZq
         PVQQ==
X-Gm-Message-State: AOJu0YzWn8tRehc9mOkUhDWlssloTBl8YWg0nWvzt/Y29mEsx0DcUgdA
        0JA+WT/6jDPp8aDG3HzonXvvLpMalgW1qBHRN2NlcQ==
X-Google-Smtp-Source: AGHT+IHpcacR+65lK0QtvUrOM1B+HCXuvqiFC2KyBeECPkljyaCq7+rk45xyQyeeBX92RprgjlMv++PeNak2wr1N4H8=
X-Received: by 2002:aa7:dcc4:0:b0:524:5e4c:2fa4 with SMTP id
 w4-20020aa7dcc4000000b005245e4c2fa4mr5069116edu.14.1692647716449; Mon, 21 Aug
 2023 12:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230818124700.49724-1-yuehaibing@huawei.com>
In-Reply-To: <20230818124700.49724-1-yuehaibing@huawei.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 21 Aug 2023 21:55:05 +0200
Message-ID: <CAMGffEnGLyHtzV5L1OTek27dy3eL+qLBP53nNB2n6ppOQ8k2dg@mail.gmail.com>
Subject: Re: [PATCH -next] scsi: pm8001: Remove unused declarations
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     jinpu.wang@cloud.ionos.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, john.garry@huawei.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 2:47=E2=80=AFPM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> Commit 4fcf812ca392 ("[SCSI] libsas: export sas_alloc_task()")
> removed these implementations but not the declarations.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_sas.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm800=
1_sas.h
> index 953572fc0d9e..2fadd353f1c1 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.h
> +++ b/drivers/scsi/pm8001/pm8001_sas.h
> @@ -702,8 +702,6 @@ int pm8001_mpi_fw_flash_update_resp(struct pm8001_hba=
_info *pm8001_ha,
>                                                         void *piomb);
>  int pm8001_mpi_general_event(struct pm8001_hba_info *pm8001_ha, void *pi=
omb);
>  int pm8001_mpi_task_abort_resp(struct pm8001_hba_info *pm8001_ha, void *=
piomb);
> -struct sas_task *pm8001_alloc_task(void);
> -void pm8001_free_task(struct sas_task *task);
>  void pm8001_tag_free(struct pm8001_hba_info *pm8001_ha, u32 tag);
>  struct pm8001_device *pm8001_find_dev(struct pm8001_hba_info *pm8001_ha,
>                                         u32 device_id);
> --
> 2.34.1
>
