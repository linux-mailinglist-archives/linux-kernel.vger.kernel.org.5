Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1760F7B68E3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjJCMWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjJCMWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:22:42 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471C8A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 05:22:39 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d865c441a54so909233276.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 05:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696335758; x=1696940558; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lb24ixVjLrqHVgiVFy7sBe/Ze+Gd/rXyWVC9HX9RmA8=;
        b=TLfuAgkXskq0xaXA2+BqcZRh2D9Tm1nmHO4qHMcS8eHHdZn2SUxDb07Q16pHxCX7T5
         8VfT8qCz5P8LD/CZlljYxF+6dVw8jT1gE/N0So8TwR/OoNZDce2AkGDUlznqcbJ6rdy6
         pkhw4vXm7xS/lZcx9DYa1PJ+4tAdA9Qs1DpP7IIeEibsEySKi7fTk4rrxmQhrdAP1I9r
         Oh5q/3MXIR+sS9CP8FhNOyUz6GY64CrNzT00Km5d9gCKS9Ru+Bte09Lga34dTWlQ7EoQ
         M7NQLJo5pErlknFH8jqsWtoFK9OP4z06cR0k3jzU1G+Bq38UFtofdRBbEqAnx7ZCNbqb
         Fz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696335758; x=1696940558;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lb24ixVjLrqHVgiVFy7sBe/Ze+Gd/rXyWVC9HX9RmA8=;
        b=hZZnrHU2ZiTtZjRgIHIB8nS8iiAPE/tcl3eXWU+u/BDKpGh6yA9O8Zg7u77QiNWl7J
         VCsZxxrR8hxGxUEf5RFV3GIg9ZLU4PNwZll2gRHwX+mNfQ5RiIR4VYYZCoRNLgKD6Bvn
         Cu10TMCxmsfYqDCCmG8Y/Q792hPvZdm9gO/2G+n75me1SRxiEDgrZJ7hubp5AfMuaioq
         EFop64K6OzZ1TIyRW501kXcBhlvmseA1nB9JADQ7s82U+Q0GfMXeE3PyLAtXLnUDA2+5
         eeKOuQCJvhf1k0j/m4s2NWqVDWPydlPltdz7y6vcXzoB8PoiNq3cH/y2qucWIyEMkw8O
         OYwg==
X-Gm-Message-State: AOJu0YynkE3kQPCusgHlkQi0YNLcmbWnPgop+/Oy1I83mz+K6ujJ1yN0
        ElstDC4l8069zOjQ6W2S7QLOU0dnZEW254N+vMT/3g==
X-Google-Smtp-Source: AGHT+IGTIihcVEUc4h3xy92CtrxrzttJjNQ+Jdd+oH86w3GCVwGjTx1a8/xm8q7k9/tSbmDS6fog6Q08fUt3ZPz4hG4=
X-Received: by 2002:a05:6902:1889:b0:d84:bf67:c775 with SMTP id
 cj9-20020a056902188900b00d84bf67c775mr17054704ybb.17.1696335758381; Tue, 03
 Oct 2023 05:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com>
 <20230915094351.11120-11-victorshihgli@gmail.com> <CAPDyKFrynugse6+vwummTQ73egwvGAfKreH=iihv9bhFN1SJYQ@mail.gmail.com>
 <afa2aeed-7296-4075-a7e0-62f3d59bfdf4@intel.com>
In-Reply-To: <afa2aeed-7296-4075-a7e0-62f3d59bfdf4@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Oct 2023 14:22:02 +0200
Message-ID: <CAPDyKFqidGZ242P-9xnxokSCeGxk8uziqR=AteWt=iQFz5fA9g@mail.gmail.com>
Subject: Re: [PATCH V12 10/23] mmc: sdhci-uhs2: add reset function and
 uhs2_mode function
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Victor Shih <victorshihgli@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2023 at 13:37, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 3/10/23 13:30, Ulf Hansson wrote:
> > On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrote:
> >>
> >> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >>
> >> Sdhci_uhs2_reset() does a UHS-II specific reset operation.
> >>
> >> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> >> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>
> >> Updates in V8:
> >>  - Adjust the position of matching brackets.
> >>
> >> Updates in V6:
> >>  - Remove unnecessary functions and simplify code.
> >>
> >> ---
> >>
> >>  drivers/mmc/host/sdhci-uhs2.c | 45 +++++++++++++++++++++++++++++++++++
> >>  drivers/mmc/host/sdhci-uhs2.h |  2 ++
> >>  2 files changed, 47 insertions(+)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> >> index e339821d3504..dfc80a7f1bad 100644
> >> --- a/drivers/mmc/host/sdhci-uhs2.c
> >> +++ b/drivers/mmc/host/sdhci-uhs2.c
> >> @@ -10,7 +10,9 @@
> >>   *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>   */
> >>
> >> +#include <linux/delay.h>
> >>  #include <linux/module.h>
> >> +#include <linux/iopoll.h>
> >>
> >>  #include "sdhci.h"
> >>  #include "sdhci-uhs2.h"
> >> @@ -49,6 +51,49 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
> >>  }
> >>  EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
> >>
> >> +/*****************************************************************************\
> >> + *                                                                           *
> >> + * Low level functions                                                       *
> >> + *                                                                           *
> >> +\*****************************************************************************/
> >> +
> >> +bool sdhci_uhs2_mode(struct sdhci_host *host)
> >> +{
> >> +       return host->mmc->flags & MMC_UHS2_SUPPORT;
> >
> > The MMC_UHS2_SUPPORT bit looks redundant to me. Instead, I think we
> > should be using mmc->ios.timings, which already indicates whether we
> > are using UHS2 (MMC_TIMING_UHS2_SPEED_*). See patch2 where we added
> > this.
> >
> > That said, I think we should drop the sdhci_uhs2_mode() function
> > altogether and instead use mmc_card_uhs2(), which means we should move
> > it to include/linux/mmc/host.h, so it becomes available for host
> > drivers.
> >
>
> UHS2 mode starts at UHS2 initialization and ends either when UHS2
> initialization fails, or the card is removed.
>
> So it includes re-initialization and reset when the transfer mode
> currently transitions through MMC_TIMING_LEGACY.
>
> So mmc_card_uhs2() won't work correctly for the host callbacks
> unless something is done about that.

Right, thanks for clarifying!

In that case I wonder if we couldn't change the way we update the
->ios.timing for UHS2. It seems silly to have two (similar) ways to
indicate that we have moved to UHS2.

Kind regards
Uffe
