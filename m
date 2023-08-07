Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BDF772C02
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjHGRGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHGRGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:06:00 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEC2C2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:05:59 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-56ca1eebcd7so2910918eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691427958; x=1692032758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbn3YRFHanofvHWO+jcCmLwBDagt8+vqY/B84h8as8k=;
        b=YnDZGWvNInlb1gECA6sEW2wGzcmqJjlpkxVx70DOIVYRxkiQ7x4Alv0CX5HpbLlzXa
         YOmTww0FYlm7gbIXuPqCQWs5aNJ6ELwQ4xNFRdl2SCnKMqUJcDCRLteWr+n2KmcaflIB
         YBPtItQDez+AFQ/aHNBx8QRkkGdAyss9/4co306Fe9i1PPXordqRNy3+sHfKbCcexEWg
         d8LaX5lhQ/kquX7uE6IxzfsWRGaklYucy9w8EnYYzO5r62LaQFAWx9ySQrMND8zBjguU
         yuarWYV9wnafp/5h7QBpoHRC5/nqcbX/mLIIDaBI2zWSDDDOPAq7g2bq14L974tyJ2pU
         1CxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691427958; x=1692032758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbn3YRFHanofvHWO+jcCmLwBDagt8+vqY/B84h8as8k=;
        b=K/tZ2Rbx+o7kEJwWCK5c1IFQFNhpP2JU/DTXTyAQd+2NmlT1Ex75Bh/DMLkz+nJYt3
         JQzvoOA5UcshY5AcuBfDNPGf62fj/A2bCPjrqWEzFGvKfQNin0hBfQXviuLctVwU3055
         G71JKSlwKZNSDAn0q6VgIG9Qo51aGklK+RFbWQ+w8QOhzQI7MoqPCtu5Savdt4CsAlgj
         IAaBQ4BMXoPC2KFIZ2fP4o/dLsc6iAvgoHe689rykTlEFz/0aXsRWL/4bm5fHxaYTAVT
         rno41lBZAEJDeuF/PxAJ16bnL0GyCsGJDGzn77oNVh4WQHOsxDn9vGoo6ckYO9ef2H1K
         JRHQ==
X-Gm-Message-State: AOJu0Yw80iL6MbloPO82NjxLhyhOXhTcTWsDQEkMl4IrDqeea4NS1N8l
        q16R3lMrhz4YQXPdIuFmQ8AIpJanaJAVUZitcJg=
X-Google-Smtp-Source: AGHT+IHFXB5CD8Mu6cDxwSyhTdt0CsqJNa2tDSIT2JIqrM0/yIbzRZq7+6WBDMPTTJWby2C/E0cwCZrrktpO0nCt2QY=
X-Received: by 2002:a4a:3018:0:b0:56c:7428:4a35 with SMTP id
 q24-20020a4a3018000000b0056c74284a35mr7764930oof.7.1691427958447; Mon, 07 Aug
 2023 10:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230802023109.9924-1-sunran001@208suo.com>
In-Reply-To: <20230802023109.9924-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:05:47 -0400
Message-ID: <CADnq5_NZSV-gvX9zOWLEifcBpj+fim5YCy2uW5yLsDnxcYiRTQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in amdgpu_pm.c
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Tue, Aug 1, 2023 at 10:31=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrot=
e:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
> ERROR: space required before the open parenthesis '('
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index 3922dd274f30..acaab3441030 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -743,7 +743,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct de=
vice *dev,
>                 type =3D PP_OD_EDIT_CCLK_VDDC_TABLE;
>         else if (*buf =3D=3D 'm')
>                 type =3D PP_OD_EDIT_MCLK_VDDC_TABLE;
> -       else if(*buf =3D=3D 'r')
> +       else if (*buf =3D=3D 'r')
>                 type =3D PP_OD_RESTORE_DEFAULT_TABLE;
>         else if (*buf =3D=3D 'c')
>                 type =3D PP_OD_COMMIT_DPM_TABLE;
> @@ -3532,7 +3532,8 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *ade=
v)
>  #if defined(CONFIG_DEBUG_FS)
>
>  static void amdgpu_debugfs_prints_cpu_info(struct seq_file *m,
> -                                          struct amdgpu_device *adev) {
> +                                          struct amdgpu_device *adev)
> +{
>         uint16_t *p_val;
>         uint32_t size;
>         int i;
> --
> 2.17.1
>
