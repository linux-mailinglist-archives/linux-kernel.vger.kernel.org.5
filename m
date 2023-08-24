Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015A2786C80
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbjHXKA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240908AbjHXKAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:00:16 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090A6198A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:00:03 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-58fc4d319d2so51524397b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692871203; x=1693476003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g5rBPrC0vQuMcmp4DDXqhGWwYLuvH0qXFYCzdTPwswc=;
        b=UvHbie/8LWoOd9pmsDUaYRgDhjjMFGDF1C3OOlCJ5qJ2CvjeQUuaV2iX/fcxhlVXg1
         txgK80KGJJY33qF2q8Y5tGr+k9h/HzuX2NDw2x8vk37SYnNAsXc0GEJ2Vp9RPrr4seZ9
         vatxLLtKsnxhb21G4mZZRAD8WmfUcWQ3Eq+SUe/6DwEv/TNp4h224VUnibnPAVj9kGFw
         +4HQRuFlmF5BjyBjswmH4RRvRPWW04XnmYYAXPylv2fxSJYKA95oQvGesF0t9yQ6ttLG
         EbyQhIVz8m3e+4p5VLqmbX+Kutok5QytFDrrltEwBSkpLu79JsS2Oj/doGQ+UzqnBScp
         qDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692871203; x=1693476003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5rBPrC0vQuMcmp4DDXqhGWwYLuvH0qXFYCzdTPwswc=;
        b=E6044EPrOkNtiahFi658EnJZjNpREP6Ft6lc3cfVxsTcdytoiPO4TeKCWVSywltMjf
         ePYD+J6CRBymmKVaqj28mRDpi5L9fL3A78u7K922T//FvweNnLo6Yeu0/mAAzIizFrh8
         VI2CgL+WU1D725w24gdwZNywjdZqcjk0GDvtejlm2gUQ7PXTin7qpU8hXs1TGis7sOhD
         9GkD6xCmXr6/2ERrKm8IXpGpqzu/Rao3aVF8suQ0gSLWDTvEnIz/9uAOS86gibM7HrTW
         ryWRvZ4IgBFHFuF/4x6G6fqJXBVBVc1d8RiRyjDP9VjRRbvfz4cvQ3ZQ8LildGxlHdOY
         uuuA==
X-Gm-Message-State: AOJu0YxDOozF7B6H4gpAnzmd4k6pVXLM44nn85hX4HNxoZx9qZZN+0Uv
        LMpxCD2cqcN8jp56jWxLN8SEmlpRu4hHvQXaN2WFUg==
X-Google-Smtp-Source: AGHT+IFCajrkQF9SFLOKPslL3gpX83VYgr+19SYAR8dR/LwPG2vSDJtUovktxg/kfqHey2hK+xu2RcKp9dNsJTnze8I=
X-Received: by 2002:a81:8882:0:b0:55a:3ce9:dc3d with SMTP id
 y124-20020a818882000000b0055a3ce9dc3dmr14818684ywf.13.1692871203062; Thu, 24
 Aug 2023 03:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230815014057.13589-1-wenchao.chen@unisoc.com> <20230815014057.13589-3-wenchao.chen@unisoc.com>
In-Reply-To: <20230815014057.13589-3-wenchao.chen@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Aug 2023 11:59:26 +0200
Message-ID: <CAPDyKFoMR_rX5O6rmp94SsBZL0=VeCgtanZzGVmTHcUihmHyKA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mmc: sdhci-sprd: Add SD HS mode online tuning
To:     Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenchao.chen666@gmail.com,
        zhenxiong.lai@unisoc.com, chunyan.zhang@unisoc.com,
        yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 at 03:41, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> First of all, Unisoc's IC provides cmd delay and read delay to ensure
> that the host can get the correct data. However, according to SD Spec,
> there is no need to do tuning in high speed mode, but with the
> development of chip processes, it is more and more difficult to find
> a suitable delay to cover all the chips. Therefore, we need SD high
> speed mode online tuning.
>
> In addition, we added mmc_sd_switch() and mmc_send_status() to the
> header file to allow it to be usable by the drive
>
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> ---
>  drivers/mmc/core/sd_ops.c     |   1 +
>  drivers/mmc/host/sdhci-sprd.c | 152 ++++++++++++++++++++++++++++++++++
>  include/linux/mmc/host.h      |   2 +
>  3 files changed, 155 insertions(+)
>
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index ef8d1dce5af1..a59cd592f06e 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -323,6 +323,7 @@ int mmc_sd_switch(struct mmc_card *card, int mode, int group,
>         return mmc_send_adtc_data(card, card->host, SD_SWITCH, cmd_args, resp,
>                                   64);
>  }
> +EXPORT_SYMBOL_GPL(mmc_sd_switch);

Please move changes in include/linux/mmc/host.h and
drivers/mmc/core/sd_ops.c into patch1. When doing that, please update
the commit messages too.

[...]

Other than the above, this looks okay to me!

Kind regards
Uffe
