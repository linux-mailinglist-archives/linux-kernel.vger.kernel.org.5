Return-Path: <linux-kernel+bounces-23079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A4B82A76B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EC19B21B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604D223CA;
	Thu, 11 Jan 2024 06:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+HKG1xL"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BACD2101;
	Thu, 11 Jan 2024 06:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3e8a51e6bso39835755ad.3;
        Wed, 10 Jan 2024 22:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704953146; x=1705557946; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lHGoXIC2FCB2mAKhVqh6NZDuE4LJRbl6RDfBQ0QRmmo=;
        b=Q+HKG1xLsbBoITDb4YUFsnxMoHpaDEpTOCJwjCqbddCUCI4vcDZ7UWEgokaZHIemXP
         un/ycE8w5aj6RZVA4Uty5xrL1AZa2RFkgkC5nu8UK1oWcQ2TR5iz86JypqfDWf5MipTX
         NLFg6XbjJodNGzrMGxeJFg3KHfXBuMbzfWHA4w/yZStQ0amfQWJ6Dwr2GCGKzxf1Jbho
         PuWcBMlzal+ng/l/TroO4A4/4scy+izDdJ4Fg7Q3H+i3S4nqZXdhbbU/izuMshttjEGh
         8skdF1g/78HIRkGEJFntsY/Mc+CKX0KxnOdzlE54lfI46sOAhPcDChR53caCOj6vJ8g7
         SeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704953146; x=1705557946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHGoXIC2FCB2mAKhVqh6NZDuE4LJRbl6RDfBQ0QRmmo=;
        b=SHGuloj9jn+Oye+Q8eOMnFQYivjuQHjdPhBVziyY8I8lt04B/61eqKSWe6sjPbrAZB
         pqobOceuHXtZSijPbQmTWsfJM5W6zd4+U9MvsKtErAQeCIZs9E062silyriS+u1nK0a/
         qhiq0RUPpeA/ssFnqaMXBx1EcjgYutkVRCPWSNgGyilk+wLC7r47EF2uzrN/v2GFROSu
         DD7wFwPPjY+sLMvQ9pThBEJ4yIJZcEu7gCCvgr2xBmkt1v132kahboPnMcy8tFC9h5j6
         ohejipr0T/bArW7v/5Go7NVrXzfir/t7TBMt7q9Igyt4zdRBZzN5PdCG2ePwtQQw7uF1
         T2VQ==
X-Gm-Message-State: AOJu0YxmExeGcZFS2ZtPZQCYQEU+xZZI0+8lOYUIiDDWqpsLbL2QJ3YB
	fH777uQEg9NpKnkE2LNJDZjizKmHRsUIvp9YsZ4=
X-Google-Smtp-Source: AGHT+IH+1q73uvlfGT5vqj6l9FlxKHf19BKYpA8MaR24y+5FzlsjZZl9SiLbskLUCzdqOP3lbR6IitsAoaAGQSftlCY=
X-Received: by 2002:a17:90a:f513:b0:28d:b4f8:5104 with SMTP id
 cs19-20020a17090af51300b0028db4f85104mr498035pjb.48.1704953146596; Wed, 10
 Jan 2024 22:05:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914000348.25790-1-michael@allwinnertech.com>
 <CA+Da2qzr0SBu-kUtFTnBqT+OObFOSTFgmU30L3B-Rjv3rYbGKw@mail.gmail.com>
 <CAPDyKFpHw+6vovHRWbhsDwre81U4Uu_X-Wy_viQCZp6nj=5Jkw@mail.gmail.com>
 <aa657a1d-a25d-21a8-4093-ec8fbe298ca2@allwinnertech.com> <CAPDyKFoJpKdsey8dxbs+NpTDDU5fR7h_=JK+aEdD2oeO5W33WQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoJpKdsey8dxbs+NpTDDU5fR7h_=JK+aEdD2oeO5W33WQ@mail.gmail.com>
From: Wenchao Chen <wenchao.chen666@gmail.com>
Date: Thu, 11 Jan 2024 14:05:35 +0800
Message-ID: <CA+Da2qzsJyy08dfHDK6h0aVfgzbmCM9A=1XE9nkNkr7NQems_Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Add new flag to force hardware reset
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michael Wu <michael@allwinnertech.com>, adrian.hunter@intel.com, 
	jinpu.wang@ionos.com, victor.shih@genesyslogic.com.tw, avri.altman@wdc.com, 
	asuk4.q@gmail.com, f.fainelli@gmail.com, beanhuo@micron.com, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sarthak Garg <quic_sartgarg@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Nov 2023 at 22:20, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 6 Nov 2023 at 13:26, Michael Wu <michael@allwinnertech.com> wrote:
> >
> > On 9/25/2023 9:59 PM, Ulf Hansson wrote:
> > > - trimmed cc-list, + Sartak Garg
> > >
> > > On Thu, 14 Sept 2023 at 10:00, Wenchao Chen <wenchao.chen666@gmail.com> wrote:
> > >>
> > >> On Thu, 14 Sept 2023 at 08:04, Michael Wu <michael@allwinnertech.com> wrote:
> > >>>
> > >>> Entering the recovery system itself indicates a transmission error.
> > >>> In this situation, we intend to execute the mmc_blk_reset function
> > >>> to clear any anomalies that may be caused by errors. We have previously
> > >>> discussed with several MMC device manufacturers, and they expressed
> > >>> their desire for us to reset the device when errors occur to ensure
> > >>> stable operation. We aim to make this code compatible with all devices
> > >>> and ensure its stable performance, so we would like to add this patch
> > >>>
> > >>> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> > >>
> > >> like: https://lore.kernel.org/linux-mmc/20220603051534.22672-1-quic_sartgarg@quicinc.com/
> > >
> > > Looks like this series didn't make it. I was awaiting a rebase from
> > > Sartak to apply it, but apparently something got in his way for a new
> > > submission.
> > >
> > >>
> > >> You should enable it in the vendor host.
> > >
> > > Yes! We don't want unused code in the core. We need a user of it too.
> > >
> > > May I suggest that you pick up Sartak's patch for the core and thus
> > > add another patch for the host driver you care about and then
> > > re-submit it as a small series.
> > >
> > > Kind regards
> > > Uffe
> > >
> > >>
> > >>> ---
> > >>>   drivers/mmc/core/block.c | 2 +-
> > >>>   include/linux/mmc/host.h | 1 +
> > >>>   2 files changed, 2 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > >>> index b5b414a71e0b..29fbe0ddeadb 100644
> > >>> --- a/drivers/mmc/core/block.c
> > >>> +++ b/drivers/mmc/core/block.c
> > >>> @@ -1503,7 +1503,7 @@ void mmc_blk_cqe_recovery(struct mmc_queue *mq)
> > >>>          pr_debug("%s: CQE recovery start\n", mmc_hostname(host));
> > >>>
> > >>>          err = mmc_cqe_recovery(host);
> > >>> -       if (err)
> > >>> +       if (err || host->cqe_recovery_reset_always)
> > >>>                  mmc_blk_reset(mq->blkdata, host, MMC_BLK_CQE_RECOVERY);
> > >>>          mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
> > >>>
> > >>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > >>> index 62a6847a3b6f..f578541a06b5 100644
> > >>> --- a/include/linux/mmc/host.h
> > >>> +++ b/include/linux/mmc/host.h
> > >>> @@ -518,6 +518,7 @@ struct mmc_host {
> > >>>          int                     cqe_qdepth;
> > >>>          bool                    cqe_enabled;
> > >>>          bool                    cqe_on;
> > >>> +       bool                    cqe_recovery_reset_always;
> > >>>
> > >>>          /* Inline encryption support */
> > >>>   #ifdef CONFIG_MMC_CRYPTO
> > >>> --
> > >>> 2.29.0
> > >>>
> > Dear Ulf,
> > I have tested Sartak's patch and it is also able to resolve the issue we
> > are currently facing. Therefore, I would like to inquire about the
> > expected timeline for merging Sartak's patch.
>
Hi Sartak

Any updates?

> Hi Michael,
>
> There is another series [1] that Adrian is working on that is related
> to the problem in $subject patch. Perhaps you can take a look and try
> it out instead of Sartak's patch, which seems to have gotten stalled.
>
> Kind regards
> Uffe
>
> [1]
> https://lore.kernel.org/all/20231103084720.6886-1-adrian.hunter@intel.com/

