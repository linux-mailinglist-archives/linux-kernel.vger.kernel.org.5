Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00527A049B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbjINM5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237706AbjINM5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:57:45 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9B21FD4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 05:57:41 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d7b79a4899bso958975276.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694696260; x=1695301060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RR3Rm3BvRcsogaZkU4Bg0Ejafb0av4o4WZ1/jDMEr44=;
        b=GT7YOe3Yag96osS+kNebu+LJLVACEAtPbg9PB4bRLk0libnh1Zg72oQEJO54houkTx
         sPj//pX0rD48MNlrcLVt6OTGmRm1HcX7+6TI8Bt8RR1VkR/tKCiDtk+WbScktLOyYcLZ
         ZujbMWe2y6w1biWg+gVOgtmN+KnFQW8JsLm9K5VEqMPEhokovfYGcV9zxw7r7p8eCr0Q
         7Suy8IRIIDPQhXt/UQirIVyVpAVr+7fHviQQ3rqGTn+PnZJgwfyN4Y7+gin1pVK8gl0H
         2FzGEB/r3dlgTVs8zGNFjbeEE1Z6TcS2M8RJMT4k05MPfEY/PecRriGWQz/6SpM21m/I
         i62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694696260; x=1695301060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RR3Rm3BvRcsogaZkU4Bg0Ejafb0av4o4WZ1/jDMEr44=;
        b=s3+WUZM64EsCKC0olRyucGWtrsBREZ5usbDP561Ysn6SbJK2+eG4O2r07tmi0N9MY9
         IKrT9/XPDRkCMHSRRYJYfeu+XM/2KXNRWyqxdLYkf8CZbFCVJPRMOzbpGXB6p+J6Y4Zc
         /2x//YArnhbknnXzCQhv8YX1pO0kf0ulATZBxJm4raNfX2vuXn9BLyI84IBB3nZyTAcZ
         KjLFXDLE/ivdGCLQ4wvz6YDsNhPVYBoO8/0zVq1cJDZTDUmiNBtNb2ipMlSPJRzVbRM5
         QQU04NJA9zt9U8JAVTYfclkZbyuyrZcoi30kqmEp/RS+p974vI5m/qh+MFhJSAXsP22v
         ZAYw==
X-Gm-Message-State: AOJu0Ywgx/ji6BdpdsQm/E5gHXUWR80eY7XJA8kCoCVjrv+i4kBxTaPJ
        g6jcQwKfzU+mNgq9TQuM5XCCsOpcwAImhEm167p6Dw==
X-Google-Smtp-Source: AGHT+IG8dtH15HRge6eN5RlxGnO2HTIFHcEjtnY4jBQGka7yBs1wMha24i43rdlme67glVBBEQnXGuMH2GKwzCxr1Iw=
X-Received: by 2002:a25:42ca:0:b0:d72:80bc:d3b2 with SMTP id
 p193-20020a2542ca000000b00d7280bcd3b2mr5130485yba.32.1694696260210; Thu, 14
 Sep 2023 05:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230829020451.9828-1-wenchao.chen@unisoc.com> <20230829020451.9828-3-wenchao.chen@unisoc.com>
In-Reply-To: <20230829020451.9828-3-wenchao.chen@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 14:57:04 +0200
Message-ID: <CAPDyKFo67SOWS3eYgEDKGOtmZJY5UtPw7+V0BEdkF_Y8yY2i5A@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] mmc: hsq: dynamic adjustment of hsq->depth
To:     Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenchao.chen666@gmail.com, zhenxiong.lai@unisoc.com,
        yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 04:05, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> Increasing hsq_depth improves random write performance.
>
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> ---
>  drivers/mmc/host/mmc_hsq.c | 27 +++++++++++++++++++++++++++
>  drivers/mmc/host/mmc_hsq.h |  5 +++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> index 8556cacb21a1..0984c39108ba 100644
> --- a/drivers/mmc/host/mmc_hsq.c
> +++ b/drivers/mmc/host/mmc_hsq.c
> @@ -21,6 +21,31 @@ static void mmc_hsq_retry_handler(struct work_struct *work)
>         mmc->ops->request(mmc, hsq->mrq);
>  }
>
> +static void mmc_hsq_modify_threshold(struct mmc_hsq *hsq)
> +{
> +       struct mmc_host *mmc = hsq->mmc;
> +       struct mmc_request *mrq;
> +       struct hsq_slot *slot;
> +       int need_change = 0;

Rather than using a variable to keep track of this, why not just do
the below here?

mmc->hsq_depth = HSQ_NORMAL_DEPTH;

> +       int tag;
> +
> +       for (tag = 0; tag < HSQ_NUM_SLOTS; tag++) {
> +               slot = &hsq->slot[tag];
> +               mrq = slot->mrq;
> +               if (mrq && mrq->data &&
> +                       (mrq->data->blksz * mrq->data->blocks == 4096) &&
> +                       (mrq->data->flags & MMC_DATA_WRITE))
> +                       need_change++;

And following above, then we can do the below here:
mmc->hsq_depth = HSQ_PERFORMANCE_DEPTH;
break;

That should simplify and make this more efficient too, right?

> +               else
> +                       break;
> +       }
> +
> +       if (need_change > 1)
> +               mmc->hsq_depth = HSQ_PERFORMANCE_DEPTH;
> +       else
> +               mmc->hsq_depth = HSQ_NORMAL_DEPTH;
> +}
> +

[...]

Kind regards
Uffe
