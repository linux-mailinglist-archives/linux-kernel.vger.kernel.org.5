Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980DB7E267A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjKFOUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjKFOUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:20:16 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA03BB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 06:20:13 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a81ab75f21so54092457b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 06:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699280412; x=1699885212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RLr2bQVZO5vELBcg960tlJRT0FhBkpzjwU4puAyAeTw=;
        b=e1Xr5o5f8Hl/00fAv4oFSNrxG7mpRUouvd6m9+jKH5fRkU3b9nH5TWsNgE4R0I1Z3M
         1WeLlPyzk80CtcBpvB+wL/QUvBWN9soN9t9tnSl2vaGs+uzIIOa2XNwCM+Z+Q7zED/pl
         1SV34ohwtdjaY3KZRNvCJrjuhU5SA1gtpGwaueg0enl9MUG4cYGXrvOfehwcVCJLla0t
         5XAe63oWWysS9JAVZuAjwr6F0J6S3ChG5fGnlgbvPncVf4yD/r+RDZjRNSvBJXaG/htL
         K2hxT3UptoFmESd8i9yMvytqkPbKeIJH96TNNCg1hSCKVaq40SBu5XwSzkzJRF5RYPm/
         aA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699280412; x=1699885212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLr2bQVZO5vELBcg960tlJRT0FhBkpzjwU4puAyAeTw=;
        b=oHF2OLF7rPeTHz8DQXSjoYyOf4f5IbVGMpXZ6MIN6h6JsyWkavJMoGx563Pc0LqWsd
         pAXBW02iBz1aEKbzO7Ct226DM/yjaUTtpvJ4HAtjdic9V2uYD6cCqHVV/rqLmOEKrYNv
         hoFArtTBOrXYzLF2uFbA5PYibSTpPo+7BW9U1Xzwn8pdnZmN2cTAQSOF1RHTmqZz9kbN
         WVCbJJv50LJsG7JhaQ8TeaMCIRUqSxRrQX/03Cm3rXDYc8iN3kVoKAnttPuke6RDrxFw
         DzAiivwIHgaQpM9HcFFyfy3FXkw4U5rcGcG9xbQkkLaRkLeh/CH0jaow2lv4QGnSa1Z/
         6TZA==
X-Gm-Message-State: AOJu0Yxfz51Bxct4A9i7PQmoxmFxW5BhD+9vMa1zK1BzbAVy4J4q5Ick
        O5XkZXiRVE+B/p+/rZAR5azsLaHjrQm1AwGdhPAi/Xa0lIh9qz0A
X-Google-Smtp-Source: AGHT+IGk8feKQPmREZ+V6jHoeKxzW88DftuPTqak5nCuD9daIA/Y5CkXOOfbp1RsCt/ymkMoiWQzP14PZaYoickFWt4=
X-Received: by 2002:a81:a0ca:0:b0:5a8:3550:61b2 with SMTP id
 x193-20020a81a0ca000000b005a8355061b2mr12196848ywg.29.1699280412564; Mon, 06
 Nov 2023 06:20:12 -0800 (PST)
MIME-Version: 1.0
References: <20230914000348.25790-1-michael@allwinnertech.com>
 <CA+Da2qzr0SBu-kUtFTnBqT+OObFOSTFgmU30L3B-Rjv3rYbGKw@mail.gmail.com>
 <CAPDyKFpHw+6vovHRWbhsDwre81U4Uu_X-Wy_viQCZp6nj=5Jkw@mail.gmail.com> <aa657a1d-a25d-21a8-4093-ec8fbe298ca2@allwinnertech.com>
In-Reply-To: <aa657a1d-a25d-21a8-4093-ec8fbe298ca2@allwinnertech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Nov 2023 15:19:36 +0100
Message-ID: <CAPDyKFoJpKdsey8dxbs+NpTDDU5fR7h_=JK+aEdD2oeO5W33WQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Add new flag to force hardware reset
To:     Michael Wu <michael@allwinnertech.com>
Cc:     Wenchao Chen <wenchao.chen666@gmail.com>, adrian.hunter@intel.com,
        jinpu.wang@ionos.com, victor.shih@genesyslogic.com.tw,
        avri.altman@wdc.com, asuk4.q@gmail.com, f.fainelli@gmail.com,
        beanhuo@micron.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sarthak Garg <quic_sartgarg@quicinc.com>
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

On Mon, 6 Nov 2023 at 13:26, Michael Wu <michael@allwinnertech.com> wrote:
>
> On 9/25/2023 9:59 PM, Ulf Hansson wrote:
> > - trimmed cc-list, + Sartak Garg
> >
> > On Thu, 14 Sept 2023 at 10:00, Wenchao Chen <wenchao.chen666@gmail.com> wrote:
> >>
> >> On Thu, 14 Sept 2023 at 08:04, Michael Wu <michael@allwinnertech.com> wrote:
> >>>
> >>> Entering the recovery system itself indicates a transmission error.
> >>> In this situation, we intend to execute the mmc_blk_reset function
> >>> to clear any anomalies that may be caused by errors. We have previously
> >>> discussed with several MMC device manufacturers, and they expressed
> >>> their desire for us to reset the device when errors occur to ensure
> >>> stable operation. We aim to make this code compatible with all devices
> >>> and ensure its stable performance, so we would like to add this patch
> >>>
> >>> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> >>
> >> like: https://lore.kernel.org/linux-mmc/20220603051534.22672-1-quic_sartgarg@quicinc.com/
> >
> > Looks like this series didn't make it. I was awaiting a rebase from
> > Sartak to apply it, but apparently something got in his way for a new
> > submission.
> >
> >>
> >> You should enable it in the vendor host.
> >
> > Yes! We don't want unused code in the core. We need a user of it too.
> >
> > May I suggest that you pick up Sartak's patch for the core and thus
> > add another patch for the host driver you care about and then
> > re-submit it as a small series.
> >
> > Kind regards
> > Uffe
> >
> >>
> >>> ---
> >>>   drivers/mmc/core/block.c | 2 +-
> >>>   include/linux/mmc/host.h | 1 +
> >>>   2 files changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> >>> index b5b414a71e0b..29fbe0ddeadb 100644
> >>> --- a/drivers/mmc/core/block.c
> >>> +++ b/drivers/mmc/core/block.c
> >>> @@ -1503,7 +1503,7 @@ void mmc_blk_cqe_recovery(struct mmc_queue *mq)
> >>>          pr_debug("%s: CQE recovery start\n", mmc_hostname(host));
> >>>
> >>>          err = mmc_cqe_recovery(host);
> >>> -       if (err)
> >>> +       if (err || host->cqe_recovery_reset_always)
> >>>                  mmc_blk_reset(mq->blkdata, host, MMC_BLK_CQE_RECOVERY);
> >>>          mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
> >>>
> >>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> >>> index 62a6847a3b6f..f578541a06b5 100644
> >>> --- a/include/linux/mmc/host.h
> >>> +++ b/include/linux/mmc/host.h
> >>> @@ -518,6 +518,7 @@ struct mmc_host {
> >>>          int                     cqe_qdepth;
> >>>          bool                    cqe_enabled;
> >>>          bool                    cqe_on;
> >>> +       bool                    cqe_recovery_reset_always;
> >>>
> >>>          /* Inline encryption support */
> >>>   #ifdef CONFIG_MMC_CRYPTO
> >>> --
> >>> 2.29.0
> >>>
> Dear Ulf,
> I have tested Sartak's patch and it is also able to resolve the issue we
> are currently facing. Therefore, I would like to inquire about the
> expected timeline for merging Sartak's patch.

Hi Michael,

There is another series [1] that Adrian is working on that is related
to the problem in $subject patch. Perhaps you can take a look and try
it out instead of Sartak's patch, which seems to have gotten stalled.

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20231103084720.6886-1-adrian.hunter@intel.com/
