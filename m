Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60222778C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbjHKKqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbjHKKqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:46:16 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6402A18E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 03:46:16 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-589addee1c1so17634507b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 03:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691750775; x=1692355575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OxKCnQ3Nf0OoXkm3KIvybcN6xTpbTvDcEELwFyI6iaE=;
        b=R1iB98WNHqiPIjx44MtM+qax6kRr7tkiseiEF8VgiBVlC/TxQo1w4i7sZtO6yRESwi
         LBjcmeqM1BDk/Oz7slh6dD7krFwyG1DdWNJDB1WHiGpju5Zx32pKNnqKOiJLiOvhcSA0
         1OaqVYTwUbpP316Iaie95wbyc4iMTZMJsQf38RanuWKK7Dvp/7B5q7RATpjCTl19RvPm
         05Q8NVxZDzzGCy8asA5rBvMgSmJo1It6CXqQrfYcOMISnzeivfel7ikxNOm05v9nvBit
         gEqlIbDaAyoeWo+NNqyzDTQAsQ7x64mUKzRi/65sMW6TuAryz7zeeFKQzyoAtZIFtYda
         1tMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691750775; x=1692355575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxKCnQ3Nf0OoXkm3KIvybcN6xTpbTvDcEELwFyI6iaE=;
        b=iUdk9f26dXOjMrs7G0szSJqhP+V1Digz/wjoObY4U1mfnpwG5rQ4CFCEFynRrQcgCZ
         jwBXtyKECBvy4P+IFTKR37LG9Nu7abAKkvHZ4VAFl7gN3WxnujxvTvzK5Wu/DDI6xmlR
         0wGIrhVmPtH/01Ns4hanyuBwUVWmpHSN6jG1dxdapTZmt0MWYbphCJ8m4C2NOEHslKph
         vS+8bK/O0bkeyowOfl6QuQLObBP7gR7BQgL27GiNF/kcnmbrBctxBRIH5o+Rus7a0U2v
         PbBH8N5rtIm1igbsbRTKiNY0UVaxXyRI8ySUbgJcbTi5lj7X8U1JfFm4Yw1bQh5IdgYt
         ZDRA==
X-Gm-Message-State: AOJu0YwMfYgmgkzX/dQcMtc77NBzEWHQLLmUHPzu+zFGPWyeOyff0bmk
        5zRRHYD5zJBZbVrfqByhF06vrz5tP4Gye5DTMW0T5A==
X-Google-Smtp-Source: AGHT+IEdYfUU7Jzi/9KeeAdfACtjeUvEi4RarygP4Ogf98OGdaY6HBKDDt4nQRh6IT4nydqX00tk3d+pMSCfiibHSLI=
X-Received: by 2002:a0d:df57:0:b0:589:c30e:eb2 with SMTP id
 i84-20020a0ddf57000000b00589c30e0eb2mr1215342ywe.33.1691750775630; Fri, 11
 Aug 2023 03:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230811033517.11532-1-chevron_li@126.com> <20230811033517.11532-2-chevron_li@126.com>
In-Reply-To: <20230811033517.11532-2-chevron_li@126.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 11 Aug 2023 12:45:39 +0200
Message-ID: <CAPDyKFry_UPapSSbM2tH7=HcWd5ZSFqNj=ytjwK77jSbKpUgGg@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] mmc: sdhci-pci-o2micro: add Bayhub new chip GG8
 support for express card
To:     Chevron Li <chevron_li@126.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shirley.her@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shaper.liu@bayhubtech.com,
        Chevron Li <chevron.li@bayhubtech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 at 05:36, Chevron Li <chevron_li@126.com> wrote:
>
> From: Chevron Li <chevron.li@bayhubtech.com>
>
> Add Bayhub new chip GG8 support for SD express card.
> This patch depends on patch 1/2.
>
> Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Change in V1:
> 1.Implement the SD express card callback routine.
> 2.Add SD express card support for Bayhub GG8 chip.
>
> Change in V2:
> 1.updated some typo in patch and modified title.
> 2.updated patch format according to reviewer's comments.
> 3.updated the logical to try UHSI when express card initializatio failed.
>
> Change in V3:
> Fix the redefine issue.
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 65 +++++++++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index ae2707fbd119..7bfee28116af 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -21,6 +21,7 @@
>   * O2Micro device registers
>   */
>
> +#define O2_SD_PCIE_SWITCH      0x54
>  #define O2_SD_MISC_REG5                0x64
>  #define O2_SD_LD0_CTRL         0x68
>  #define O2_SD_DEV_CTRL         0x88
> @@ -631,6 +632,67 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
>         sdhci_o2_enable_clk(host, clk);
>  }
>
> +static int sdhci_pci_o2_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct sdhci_pci_slot *slot = sdhci_priv(host);
> +       struct sdhci_pci_chip *chip = slot->chip;
> +       u8 scratch8;
> +       u16 scratch16;
> +       int ret;
> +
> +       /* Disable clock */
> +       sdhci_writeb(host, 0, SDHCI_CLOCK_CONTROL);
> +
> +       /* Set VDD2 voltage*/
> +       scratch8 = sdhci_readb(host, SDHCI_POWER_CONTROL);
> +       scratch8 &= 0x0F;
> +       if (host->mmc->ios.timing == MMC_TIMING_SD_EXP_1_2V &&
> +           host->mmc->caps2 & MMC_CAP2_SD_EXP_1_2V) {
> +               scratch8 |= SDHCI_VDD2_POWER_ON | SDHCI_VDD2_POWER_120;
> +       } else {
> +               scratch8 |= SDHCI_VDD2_POWER_ON | SDHCI_VDD2_POWER_180;
> +       }
> +
> +       sdhci_writeb(host, scratch8, SDHCI_POWER_CONTROL);
> +
> +       /* UnLock WP */
> +       pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch8);
> +       scratch8 &= 0x7f;
> +       pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch8);
> +
> +       /* Wait for express card clkreqn assert */
> +       ret = read_poll_timeout(sdhci_readb, scratch8, !(scratch8 & BIT(0)),
> +                               1, 30000, false, host, O2_SD_EXP_INT_REG);
> +
> +       if (!ret) {
> +               /* Switch to PCIe mode */
> +               scratch16 = sdhci_readw(host, O2_SD_PCIE_SWITCH);
> +               scratch16 |= BIT(8);
> +               sdhci_writew(host, scratch16, O2_SD_PCIE_SWITCH);
> +       } else {
> +               /* Power off VDD2 voltage*/
> +               scratch8 = sdhci_readb(host, SDHCI_POWER_CONTROL);
> +               scratch8 &= 0x0F;
> +               sdhci_writeb(host, scratch8, SDHCI_POWER_CONTROL);
> +
> +               /* Keep mode as UHSI */
> +               pci_read_config_word(chip->pdev, O2_SD_PARA_SET_REG1, &scratch16);
> +               scratch16 &= ~BIT(11);
> +               pci_write_config_word(chip->pdev, O2_SD_PARA_SET_REG1, scratch16);
> +
> +               host->mmc->ios.timing = MMC_TIMING_LEGACY;
> +               pr_info("%s: Express card initialization failed, falling back to Legacy\n",
> +                       mmc_hostname(host->mmc));
> +       }
> +       /* Lock WP */
> +       pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch8);
> +       scratch8 |= 0x80;
> +       pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch8);
> +
> +       return 0;
> +}
> +
>  static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  {
>         struct sdhci_pci_chip *chip;
> @@ -703,10 +765,11 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>         case PCI_DEVICE_ID_O2_GG8_9861:
>         case PCI_DEVICE_ID_O2_GG8_9862:
>         case PCI_DEVICE_ID_O2_GG8_9863:
> -               host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
> +               host->mmc->caps2 |= MMC_CAP2_NO_SDIO | MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V;
>                 host->mmc->caps |= MMC_CAP_HW_RESET;
>                 host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
>                 slot->host->mmc_host_ops.get_cd = sdhci_o2_get_cd;
> +               host->mmc_host_ops.init_sd_express = sdhci_pci_o2_init_sd_express;
>                 break;
>         default:
>                 break;
> --
> 2.25.1
>
