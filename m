Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D167D5C02
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344329AbjJXT72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344261AbjJXT70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:59:26 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6E010D5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 12:59:24 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d9ca471cf3aso4617042276.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 12:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698177564; x=1698782364; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X3Nt1tRk4oZwItsFbTrN6/wGS4LwWRGecYFcsIlq7X4=;
        b=zCY6bt73oxGhskUCk9Pmpg3Fr5C0HGIzHPrzyiD02102LmKzG2+0XavVDjrSloZHlK
         Hi0x2JXaM9fPh/boGIED52dneytai+pJJJ/yO9InBcm51VqKpzK1mU3KVMgSyPUi36w4
         FomEShm6P4u3vy1ukzfkBLEk9SFo+jWDCjdjDPcvJqKSvcF1KRoAGIfyuqJzoM/dXwCk
         g8DIlkQxu8Dh5H8ixbv18amksyiLNBwoQg9IAgbA/q3z/oZeycS54HiAoydQzTvj6ShM
         QZ0qjjX3+FW42Zc5LFjsey9401CaLHDJmQkHFrvUC7l1sEBlKXf/RhDLuzPvUiB2+pcx
         NX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698177564; x=1698782364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3Nt1tRk4oZwItsFbTrN6/wGS4LwWRGecYFcsIlq7X4=;
        b=hCfHLbV95dzata4RZmQJn3PxuSSW4C5u1BWJP+BI+DF57yl4ROphzaTGRWwd1/gua/
         5sd47sHkHM7XsQDY9cHg1gr3bYhZjV3BG8q7d9zl10w0SjHVmacS9V8205Qbcacl8UUc
         yjBCFbpMIcxv7Cf55TqjXbGr0c7ZJD2oT/r+VSxWSBhNxR8UO3DwR9/Tm+FoxBBBWygn
         fXT0zmaGIvY79LsVqjPN+SVJeEWFSxhTMeumDg02VXTfjLWgtIs7JqcxHLsiCZTJsLoq
         GFSUUNjrqR2sRd6YYzxXxBzHSUjvoBIeuFHpBWvkWnADvGAHNLJrsq9GPrRNrZxFtTyc
         jEQg==
X-Gm-Message-State: AOJu0YzbyMO6CqgJOfhmVeamjpKzZHki/jdtc8yvwL1HfXspK3aFX9Ml
        7DRDSyAEUrtV7czGaREnMb/xlHa/Pc0x+x+TKPv47w==
X-Google-Smtp-Source: AGHT+IGIKU90txs7qDa16dt6ToUY7ImKSmv34abro4cWrTktqbf66JlzZobnbOCvfV97zA6I4eFI/43VsNo0lIy2q0k=
X-Received: by 2002:a25:51c3:0:b0:d9b:b6:ad72 with SMTP id f186-20020a2551c3000000b00d9b00b6ad72mr13160609ybb.50.1698177564020;
 Tue, 24 Oct 2023 12:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <1696440338-12561-1-git-send-email-quic_mojha@quicinc.com> <1696440338-12561-2-git-send-email-quic_mojha@quicinc.com>
In-Reply-To: <1696440338-12561-2-git-send-email-quic_mojha@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 24 Oct 2023 22:59:12 +0300
Message-ID: <CAA8EJprscPcr0pMM=fz4yGWsgprk7bAXCcbbZJQmdv0siKASow@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] firmware: qcom_scm: provide a read-modify-write function
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        p.zabel@pengutronix.de, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2023 at 20:26, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>
> It was realized by Srinivas K. that there is a need of
> read-modify-write scm exported function so that it can
> be used by multiple clients.
>
> Let's introduce qcom_scm_io_update_field() which masks
> out the bits and write the passed value to that bit-offset.
>
> Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Tested-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com> # IPQ9574 and IPQ5332
> ---
>  drivers/firmware/qcom_scm.c            | 20 ++++++++++++++++++++
>  include/linux/firmware/qcom/qcom_scm.h |  2 ++
>  2 files changed, 22 insertions(+)
>
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 520de9b5633a..084e4782b88d 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -122,6 +122,7 @@ static const char * const qcom_scm_convention_names[] = {
>  };
>
>  static struct qcom_scm *__scm;
> +static DEFINE_SPINLOCK(lock);

Please move the spinlock inside __scm.

>
>  static int qcom_scm_clk_enable(void)
>  {
> @@ -481,6 +482,25 @@ static int qcom_scm_disable_sdi(void)
>         return ret ? : res.result[0];
>  }
>
> +int qcom_scm_io_update_field(phys_addr_t addr, unsigned int mask, unsigned int val)

qcom_scm_io_rmw ? qcom_scm_io_update_bits? These might be better names
and they follow the existing function names.

> +{
> +       unsigned int old, new;
> +       int ret;
> +
> +       spin_lock(&lock);
> +       ret = qcom_scm_io_readl(addr, &old);
> +       if (ret)
> +               goto unlock;
> +
> +       new = (old & ~mask) | (val & mask);
> +
> +       ret = qcom_scm_io_writel(addr, new);
> +unlock:
> +       spin_unlock(&lock);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(qcom_scm_io_update_field);
> +
>  static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>  {
>         struct qcom_scm_desc desc = {
> diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
> index ccaf28846054..5497eaf9c7b5 100644
> --- a/include/linux/firmware/qcom/qcom_scm.h
> +++ b/include/linux/firmware/qcom/qcom_scm.h
> @@ -82,6 +82,8 @@ bool qcom_scm_pas_supported(u32 peripheral);
>
>  int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
>  int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
> +int qcom_scm_io_update_field(phys_addr_t addr, unsigned int mask,
> +                            unsigned int val);
>
>  bool qcom_scm_restore_sec_cfg_available(void);
>  int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
