Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E23E7BCBB8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 04:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344315AbjJHCWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 22:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344249AbjJHCWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 22:22:43 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0C9B9;
        Sat,  7 Oct 2023 19:22:42 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-66afd39c8edso10587426d6.2;
        Sat, 07 Oct 2023 19:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696731761; x=1697336561; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G3v6Cc18PHjKmTN7pHo7UsjFFbpGlQjjLMYj+ARVLmA=;
        b=bOnBtXpiBEg1ZIHj1Ym/c1QvzGqfWJkULWi5NO6p6KRwUjOS51bcq0RAFbcrbyey9q
         HXfKTryUBw8ZEz1Yxr9rrFgoYzscOOfFnvBFrbWwWk1Yz4jJwHQBN7lTTjO9RlMq1gSq
         YCWHIctzCU9XeTY1TdKfrs5rNM/Bg1PpSSMSVRr7g3gDNODdhT0BhVFa3NqS100vk0vd
         pXRtmeVaFkt479/9mODQYXgsmH7+vKDEC0TGZfiDLFw8LPR7Z6dc7ga7JvR7hoAqTBDp
         n9hjapN7sdlIbEHtBd5+Hm9r40Ck7fQ2j/pETGyOkl1eL4JlFQqP0pEaR2UPtW33H0Ji
         3Iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696731761; x=1697336561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3v6Cc18PHjKmTN7pHo7UsjFFbpGlQjjLMYj+ARVLmA=;
        b=bXIw3dXhlRqWKlk5f8Y254uC+7G71o/pstWBx1vVeB7pLxYpppzsrnQWzlm456ktl+
         F6MJmIkyowk3uJaFnicDNmCj2fzXurctE/GfmLdp28ac9uYNl80aTNXPUY27Ur1xUgHl
         r2fiLNQ39USwB4JmHmXa3iVSUXtF2+aLVifdHWBkMdWegwkmHuvRQsm6clhSTOgfrTEm
         kaEGf5WnEIlSfyvIuqkjwOApYav4UL5qfLlnR1ew2eowSWOTFG5fowUZ+U5Ls8sT42a3
         YV45tG8hjzDrNcEVABiDx6D3etw4M7nbmAwJ/tAjs6DdJ9vq9SaAF4dO3trriZ1qxKj6
         bJwA==
X-Gm-Message-State: AOJu0YzmYp90YFKZKnk5wWrCWXkQvfwFeuUGgCbAVHGLbYCsDUWF/HcZ
        bJYm59zcC7vvyqGo6EaMMsVdPrBYkKMpW2ep0Cs=
X-Google-Smtp-Source: AGHT+IHL881GioORqGpCN3KhxrK6qPwqqqLidWnU0eRk0iWU5HVK1rpOZ/WvcnQAalk1LYPGsXwarwTY/DHmESX+EN8=
X-Received: by 2002:a0c:e54a:0:b0:65c:ff35:42f3 with SMTP id
 n10-20020a0ce54a000000b0065cff3542f3mr12028237qvm.13.1696731761227; Sat, 07
 Oct 2023 19:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230929102831.9702-1-quic_sartgarg@quicinc.com> <20230929102831.9702-3-quic_sartgarg@quicinc.com>
In-Reply-To: <20230929102831.9702-3-quic_sartgarg@quicinc.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Sun, 8 Oct 2023 10:22:30 +0800
Message-ID: <CA+Da2qz=jSfi=WzJyykaMUd4RSYMORe05YQS_y3c0cEW=o4-Vg@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mmc: sdhci-msm: Enable MMC_CAP2_SLEEP_AWAKE for
 Qualcomm controllers
To:     Sarthak Garg <quic_sartgarg@quicinc.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_narepall@quicinc.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sept 2023 at 22:44, Sarthak Garg <quic_sartgarg@quicinc.com> wrote:
>
> Enable MMC_CAP2_SLEEP_AWAKE for Qualcomm controllers to let them use
> sleep/awake functionality for faster eMMC resume instead of
> doing full initialization.
>
> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> ---
>  drivers/mmc/host/sdhci-msm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 668e0aceeeba..be44a6851fc9 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2627,6 +2627,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         }
>
>         msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
> +       msm_host->mmc->caps2 |= MMC_CAP2_SLEEP_AWAKE;
>

Need "MMC_CAP_AGGRESSIVE_PM"?
/*
 * Callback for runtime_suspend.
 */
static int mmc_runtime_suspend(struct mmc_host *host)
{
int err;

if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
return 0;

err = _mmc_suspend(host, true);
if (err)
pr_err("%s: error %d doing aggressive suspend\n",
mmc_hostname(host), err);

return err;
}



>         /* Set the timeout value to max possible */
>         host->max_timeout_count = 0xF;
> --
> 2.17.1
>
