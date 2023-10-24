Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0367D5BE6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344219AbjJXTyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344218AbjJXTyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:54:10 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6195010C6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 12:54:08 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9cbba16084so4200747276.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 12:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698177247; x=1698782047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ckMVj0mT1+iO70Z9g6qUdiFwwZNq+iyV8pOCG7UjtA=;
        b=D/SM7/Rp7/K9ZtBf/92hqhDjPNnR0rp+LFd4ivQjDU+x8RdntTnl7g3WLml+/wF0iD
         24Yo3fs/1hgwCQI3SipFyXPpDH4WVy1gkWqzS/hd+CbQCo2SxqYTVxNoOr4eP3qdDmLg
         5fatA/M6ygRiBdvjM0vRUUh6GL9bbuyVfWkh3hHAPikAFVL+hXTH0/eQDgICAX4GJHxb
         DR3eVqNiYYUdwNXCzx/n6MNyXElHve3NWNUC/UijMNzaZNzgjdt7DJ9YmkR//Txt+Qrc
         p3YUVPOaU5betxw4eCkYfhHHuXuOufUlQQ21Ac8Wi45U6HhVKrBPlYiaCo5cGRX3qVvU
         pvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698177247; x=1698782047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ckMVj0mT1+iO70Z9g6qUdiFwwZNq+iyV8pOCG7UjtA=;
        b=PHBQgzoLgZmQupv2EgI1xFsXkH3/6M6DW/5XvbfTGuJgkW9dDBSyVYnk9eOnUmAmLr
         LStZc+3Bv3lvFFHiu8sRr+5mwaSsrZp2sCBddonWN8VGsvChQqhp4ZeQVzJpJFCjNN0M
         YNNKyLluIdwAljSmRWWz82mqZSCI0dBpFBXNPqi4u59s3OW8WqhpsHO81Yly/V+fMWQk
         3Fpd5qGlWCJJIx2q4eGV1jGCM/K2dRwUXzy5JVk0kL8Vb5Col+I619hlykwjxEknPBYJ
         WfdZaY3dq0KVki14m63aJW7TPcn54MsNizJfHnIgaLoEk9gZ7k2QxvIWTTxditIhApva
         raIw==
X-Gm-Message-State: AOJu0YwVKMr5PyWcgXxrWu6uGDUia8pH8x/GXoT5r1Dxc1qO/aJKNY2k
        VknAK5DDeSKLL/5fO2yNMDs9/VreVx77n+r16B/OFA==
X-Google-Smtp-Source: AGHT+IGXjUjKDx8d+81HHT/vBnb5xzK6h/5gbJXjsqz14OeQuvCkEwZguoh+oy4hPPrMTLUBAu9opwIJg9sxaojjekU=
X-Received: by 2002:a25:2d07:0:b0:d9b:76c3:4567 with SMTP id
 t7-20020a252d07000000b00d9b76c34567mr13456231ybt.55.1698177247589; Tue, 24
 Oct 2023 12:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <1696440338-12561-1-git-send-email-quic_mojha@quicinc.com> <1696440338-12561-4-git-send-email-quic_mojha@quicinc.com>
In-Reply-To: <1696440338-12561-4-git-send-email-quic_mojha@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 24 Oct 2023 22:53:56 +0300
Message-ID: <CAA8EJpoWfiwr2ADWuej8+RkNqmP-=tbNq=me_ok72iuG6m9sug@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] firmware: scm: Modify only the download bits in
 TCSR register
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        p.zabel@pengutronix.de, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Poovendhan Selvaraj <quic_poovendh@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2023 at 20:28, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>
> Crashdump collection is based on the DLOAD bit of TCSR register.
> To retain other bits, we read the register and modify only the
> DLOAD bit as the other bits have their own significance.

Nit: please take a look at
`Documentation/process/submitting-patches.rst`: `Describe your changes
in imperative mood'.

We do not read registers. Driver does. Nevertheless, this is a minor
issue, which shouldn't prevent this patch from being applied.

>
> Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Tested-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com> # IPQ9574 and IPQ5332

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/firmware/qcom_scm.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 084e4782b88d..da3d028f6451 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -4,6 +4,8 @@
>   */
>
>  #include <linux/arm-smccc.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
>  #include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/cpumask.h>
> @@ -27,6 +29,10 @@
>  static bool download_mode = IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
>  module_param(download_mode, bool, 0);
>
> +#define QCOM_DLOAD_MASK                GENMASK(5, 4)
> +#define QCOM_DLOAD_FULLDUMP    0x1
> +#define QCOM_DLOAD_NODUMP      0x0

Nit: it might be better to move these defines after all struct definitions.

> +
>  struct qcom_scm {
>         struct device *dev;
>         struct clk *core_clk;
> @@ -518,6 +524,7 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>
>  static void qcom_scm_set_download_mode(bool enable)
>  {
> +       u32 val = enable ? QCOM_DLOAD_FULLDUMP : QCOM_DLOAD_NODUMP;
>         bool avail;
>         int ret = 0;
>
> @@ -527,8 +534,9 @@ static void qcom_scm_set_download_mode(bool enable)
>         if (avail) {
>                 ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>         } else if (__scm->dload_mode_addr) {
> -               ret = qcom_scm_io_writel(__scm->dload_mode_addr,
> -                               enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
> +               ret = qcom_scm_io_update_field(__scm->dload_mode_addr,
> +                                              QCOM_DLOAD_MASK,
> +                                              FIELD_PREP(QCOM_DLOAD_MASK, val));
>         } else {
>                 dev_err(__scm->dev,
>                         "No available mechanism for setting download mode\n");
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
