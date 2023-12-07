Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272C18089C0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442832AbjLGOB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjLGOB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:01:56 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A701610F3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:02:02 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5d3c7ef7b31so7556437b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701957721; x=1702562521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xqSN2wz/zGfROIqFiurJMPD+/BJpUqBprXGsU0gwv9Q=;
        b=kxLlZvpqxT4FoowXREhO+D/r3/lncVGKrOhheT1Q8TsbSJG5FAscSUOWyLGiyBXgDH
         mtmKRe+GT6p40OIScxDv5Nki87K9XWRs+a8/NiLa54PMSfrNc4CTuHrpjZvkspPw37/5
         2e8JGMElffVGJCb+cZ/uQW0fewQclDYAykaxesgj5OazgG6HoziVZTbvSm4cXrN3iOk0
         hfKk5z3dJLdrtBv8VROAMNKMGkIx+CyA8StbXGEfneD1zEWfcPZJYTsnuahuEVaWB430
         3YaHCYz8Om6T1+GrIqhSrqoLQn8HRzqj9Odn9FApmIt18lQ9WRdyxs8xhjHuX+APk2+J
         Q16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957721; x=1702562521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xqSN2wz/zGfROIqFiurJMPD+/BJpUqBprXGsU0gwv9Q=;
        b=iwrDNW3knYsjMoCtQqb/fCyKDc+fRITy/F8+0nfRikaH/NjGm3AwsLZlZcjoyjxAtx
         1iEwCpA+DWdgJgxVDFvM4xGhUElH9l36RbgmUDsptZzOMDpyhboXL7fhQ88ZUSxFiqwx
         Pgou84RYJbMDRKg3G3y3grO/dFxcIgTxMQgNHoRwaTaum6RTWydtpGMdQ+o1zrkmrZAO
         uFHtYgLtxhX2Ca8V0/h24Dhnx38yG/QJmNtC4cQ1RFjFNOps90JSILmBRsQAC9e/4el+
         oaISAlfoQBGu4+O9NcF/fNH3XibrejBciSlNir6homMeYrvYt834QnOsKxudLdvZVsu+
         8L3w==
X-Gm-Message-State: AOJu0Yy2FWIFsa7GlYdM7X2zgbXp+ntXE3O+gyMDiFAVsnzK6TOU5SSl
        mbxe6nTvul3/gEhvfXjfs83zPCSXhC22Sg6DJqULCg==
X-Google-Smtp-Source: AGHT+IH3A+kfMVFWXCHHzW1EoiuSi/T1nkVcCCM0Y1P3XBgusQEyXxhBLp9MTbatm83rnaE5ppyGAiBDsLZJiNAzu+I=
X-Received: by 2002:a0d:d88b:0:b0:5d7:1941:3556 with SMTP id
 a133-20020a0dd88b000000b005d719413556mr2618248ywe.61.1701957721714; Thu, 07
 Dec 2023 06:02:01 -0800 (PST)
MIME-Version: 1.0
References: <20231201102747.3854573-1-treapking@chromium.org>
In-Reply-To: <20231201102747.3854573-1-treapking@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 Dec 2023 15:01:25 +0100
Message-ID: <CAPDyKFrAvkzgHUttY_mVAHK3HXCV_eE6=KhQkdQyLq22zstX8A@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: mtk-sd: Increase the verbosity of msdc_track_cmd_data
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ot_shunxi.zhang@mediatek.corp-partner.google.com,
        linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2023 at 11:27, Pin-yen Lin <treapking@chromium.org> wrote:
>
> This log message is necessary for debugging, so enable it by default to
> debug issues that are hard to reproduce locally.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
> Changes in v3:
> - Only print the warning when -ETIMEDOUT or not in tuning process
>
> Changes in v2:
> - Use dev_warn() instead of dev_err()
>
>  drivers/mmc/host/mtk-sd.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 97f7c3d4be6e..6ae5e0a9fca9 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1149,9 +1149,11 @@ static void msdc_recheck_sdio_irq(struct msdc_host *host)
>
>  static void msdc_track_cmd_data(struct msdc_host *host, struct mmc_command *cmd)
>  {
> -       if (host->error)
> -               dev_dbg(host->dev, "%s: cmd=%d arg=%08X; host->error=0x%08X\n",
> -                       __func__, cmd->opcode, cmd->arg, host->error);
> +       if (host->error &&
> +           ((!mmc_op_tuning(cmd->opcode) && !host->hs400_tuning) ||
> +            cmd->error == -ETIMEDOUT))
> +               dev_warn(host->dev, "%s: cmd=%d arg=%08X; host->error=0x%08X\n",
> +                        __func__, cmd->opcode, cmd->arg, host->error);
>  }
>
>  static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>
