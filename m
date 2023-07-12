Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C3C75106C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjGLSXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGLSXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:23:01 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3A11BF3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:22:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3142970df44so7151802f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689186177; x=1691778177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zEptLORFsPcNRSNWyiLt/qdXLZFMpFLB74XceY7kfJs=;
        b=NESOhrM+60c9TaKgiaIunf+PqQPIiBLE3dQ9ohYJ10UGNBLpP71Pw63cm5FCYIQjg3
         vSc2vV0+vin0J4kZHikU2XhxSSio4lTYEvE7XeY9L/9ItYK7ivFTsbK5Pj0hTkJ9tTB/
         Gs6wNB5zXnFjWLNd7Ufb4RBx6gDD2Vxn0UIl5v/LvKGUOxH3+AOBGj+TZJlH+DD0kbaL
         9D6MmYT5Ykym5O/lqMR7yo0pcdpbSAzVh0ESz3OyXUgikztzX9ojWLoCNPXXK5ALnJwl
         t06OlCkmiXzr8v5veQMH/kDwu63CaY1xtE2+K7TTax0s7lRchOGCX3cK1VPlHl+d7+Nr
         zfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689186177; x=1691778177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEptLORFsPcNRSNWyiLt/qdXLZFMpFLB74XceY7kfJs=;
        b=iGBqaP03pQGvoNeM1CFmKKRBtbzkCp+dr8IXNGvobLTU03hRj5XP/+khGNu8dvvPzO
         Apg+DiCiMqgrdTiZaXlzufAlZj2itwznXQyQhvBj88kDSL3pXjCKJZhdDu10m/c7pXq9
         SMLhVtj9TyLQI56WB2W6uawLXiokXrw2VzqNtil2gfOz82dbIj44mAOQFG1sotN3LT50
         AarS39uGq6MiVCXYn0vgks6bKH+32N8z9JNSp3k+v/31EvVzMeHgpUFdiv3Jd4BumVay
         KcCIp1pnXDDP3QHpQWR5qqGMwEtrIofSzC8ZB0TFbVfMl8ozxWJn49ny3TN7y7NYHOLX
         Vj5w==
X-Gm-Message-State: ABy/qLYgG37Ks3sL70qxn5+G/6V6MeZJKIcMGtC83yY/wXVFbYkYkCfl
        8nCuNlE9yZVHGEKOcSyYTMSXMKzVf2WEkK1Pdf1uEg==
X-Google-Smtp-Source: APBJJlHMQns32yY3qDu99XriZAQm+PfgqTyCkmM5Rr4OFbIo1eXyU4SfgLsCdRIpUXiTRIT4A3OFVAGT/QWgUoAtj1k=
X-Received: by 2002:a5d:51cc:0:b0:314:121d:8cbf with SMTP id
 n12-20020a5d51cc000000b00314121d8cbfmr13778455wrv.25.1689186176882; Wed, 12
 Jul 2023 11:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689148711.git.quic_schowdhu@quicinc.com> <18212c7abbb8c833cc07f8500d4905b79c49ec59.1689148711.git.quic_schowdhu@quicinc.com>
In-Reply-To: <18212c7abbb8c833cc07f8500d4905b79c49ec59.1689148711.git.quic_schowdhu@quicinc.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Wed, 12 Jul 2023 23:52:45 +0530
Message-ID: <CAH=2Ntz8JEGp_Atsv3iToUG1WdLKvdt5GYu7a=LwgmgY7v0rvw@mail.gmail.com>
Subject: Re: [PATCH V1 2/3] usb: misc: Add notifier call chain to Embedded USB
 Debug(EUD) driver
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Souradeep,

On Wed, 12 Jul 2023 at 13:58, Souradeep Chowdhury
<quic_schowdhu@quicinc.com> wrote:
>
> Add the notifier call chain to EUD driver. The notifier call chain
> is added to check the role-switch status of EUD. When multiple
> modules are switching roles on the same port, they need to call this
> notifier to check the role-switch status of EUD. If EUD is disabled,
> then the modules can go for the role-switch, otherwise it needs to
> be blocked. The notifier chain can be used to link multiple modules
> switching roles on the same port and create a ordering, priority and
> conflict resolution among them. The wrapper functions are defined here
> which can be used to register a notifier block to the chain, deregister
> it and also call the chain.
>
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  drivers/usb/misc/qcom_eud.c | 52 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 50 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
> index 7f371ea1248c..e6c97a2cf2df 100644
> --- a/drivers/usb/misc/qcom_eud.c
> +++ b/drivers/usb/misc/qcom_eud.c
> @@ -11,10 +11,13 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/usb/role.h>
> +#include "qcom_eud_notifier.h"
>
>  #define EUD_REG_INT1_EN_MASK   0x0024
>  #define EUD_REG_INT_STATUS_1   0x0044
> @@ -22,14 +25,16 @@
>  #define EUD_REG_VBUS_INT_CLR   0x0080
>  #define EUD_REG_CSR_EUD_EN     0x1014
>  #define EUD_REG_SW_ATTACH_DET  0x1018
> -#define EUD_REG_EUD_EN2                0x0000
> +#define EUD_REG_EUD_EN2        0x0000
>
>  #define EUD_ENABLE             BIT(0)
> -#define EUD_INT_PET_EUD                BIT(0)

These indentation issues are already addressed in my EUD patches.
Please rebase your patches on the same to reuse those.

> +#define EUD_INT_PET_EUD        BIT(0)
>  #define EUD_INT_VBUS           BIT(2)
>  #define EUD_INT_SAFE_MODE      BIT(4)
>  #define EUD_INT_ALL            (EUD_INT_VBUS | EUD_INT_SAFE_MODE)
>
> +static RAW_NOTIFIER_HEAD(eud_nh);
> +
>  struct eud_chip {
>         struct device                   *dev;
>         struct usb_role_switch          *role_sw;
> @@ -41,6 +46,42 @@ struct eud_chip {
>         bool                            usb_attached;
>  };
>
> +int eud_register_notify(struct notifier_block *nb)
> +{
> +       return raw_notifier_chain_register(&eud_nh, nb);
> +}
> +EXPORT_SYMBOL_GPL(eud_register_notify);
> +
> +void eud_unregister_notify(struct notifier_block *nb)
> +{
> +       raw_notifier_chain_unregister(&eud_nh, nb);
> +}
> +EXPORT_SYMBOL_GPL(eud_unregister_notify);
> +
> +void eud_notifier_call_chain(unsigned long role_switch_state)
> +{
> +       raw_notifier_call_chain(&eud_nh, role_switch_state, NULL);
> +}
> +EXPORT_SYMBOL_GPL(eud_notifier_call_chain);

Probably I missed it, but you have not provided any example users of
these APIs in the patchset or reference to another one which shows how
these APIs are used.

> +static int eud_vbus_spoof_attach_detach(struct notifier_block *nb, unsigned long event,
> +                                       void *data)
> +{
> +       struct device_node *eud = of_find_compatible_node(NULL, NULL, "qcom,eud");
> +       struct device *eud_device = bus_find_device_by_of_node(&platform_bus_type, eud);
> +       struct eud_chip  *eud_data = dev_get_drvdata(eud_device);
> +
> +       if (eud_data->enabled  && event != USB_ROLE_DEVICE)
> +               return NOTIFY_BAD;
> +       else
> +               return NOTIFY_OK;
> +}
> +
> +static struct notifier_block eud_notifier = {
> +       .notifier_call = eud_vbus_spoof_attach_detach,
> +       .priority = 1,

Why do you need a 'priority = 1' here, it can be 0 or even lower?

Thanks,
Bhupesh

> +};
> +
>  static int enable_eud(struct eud_chip *priv)
>  {
>         writel(EUD_ENABLE, priv->base + EUD_REG_CSR_EUD_EN);
> @@ -196,6 +237,10 @@ static int eud_probe(struct platform_device *pdev)
>                 return dev_err_probe(chip->dev, ret,
>                                 "failed to add role switch release action\n");
>
> +       ret = eud_register_notify(&eud_notifier);
> +       if (ret)
> +               return dev_err_probe(chip->dev, ret, "failed to register notifier\n");
> +
>         chip->base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(chip->base))
>                 return PTR_ERR(chip->base);
> @@ -226,6 +271,9 @@ static void eud_remove(struct platform_device *pdev)
>
>         device_init_wakeup(&pdev->dev, false);
>         disable_irq_wake(chip->irq);
> +       eud_unregister_notify(&eud_notifier);
> +
> +       return 0;
>  }
>
>  static const struct of_device_id eud_dt_match[] = {
> --
> 2.17.1
>
