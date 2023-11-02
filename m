Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0B67DF222
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347143AbjKBMRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347273AbjKBMRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:17:16 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4859D185
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:17:08 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-457cdfc293bso354103137.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 05:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698927427; x=1699532227; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Emmjf+2NO3ztIpMJBBAOr+RoGGRHaG/AsnUmU9W3f0=;
        b=NvvBgbk6vIdTRgWWuUnqLIXV1w/E7dQ4AvSBGe36KzSGJ3DreW+20H54zUim8vS0p3
         MK8AKWdjfrIwgodjm2arJ63zoghGDfcjpWtgGDjxZ6n3zEUKKpdBQTP/fFWlvSxHZKEF
         yAx21j/Vc93x9Oi86ewoN+OWR1DSCHj1HZCV2RTnMdf18ebP7qdT4wldBouyd/8MaHeJ
         8eKULYBtt9qCDjoRCQzGqSJOxw0MniS7A0HM/o8oDgStdDax7X6ZZkUzswcMqJxX1Qyw
         VgDlzT8geRfVlYu16Dg6+nFS58u10c2L0U3iWkLfD0kOPi4eT4hLmA3aLDv/yhrZdbsV
         9cNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698927427; x=1699532227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Emmjf+2NO3ztIpMJBBAOr+RoGGRHaG/AsnUmU9W3f0=;
        b=pWQY3e17FxNqzQDpHyuJ6sZpy9/6bI7Yen7kpBEuBFqA+4rPfGu6//YVHCgjwVbiWy
         2Hre86OJXxEX9QrdFfr4UYFlv3dgJSJgElc8KOoTI4YgZnLprOe1BQa2cY1iVAGCKPvj
         v/95aY3j3nDi3gMaorjF+Z/hkUXdhtinugdzRQXQ1XCEGOfTRogvAplKaY9+oDqABc20
         3ew91ol/8vjidFrmy++u5CetSp5PWL/LTzZQrTXFRRSNam36QUpvwvinhNyNVOS08ZJl
         Wf/CvW+AFhTMj1o7wrpqLjcedEB84m6lywoxuugMbo2OaMqmnOnVPHfCKCCv/v8BMFtG
         a4RA==
X-Gm-Message-State: AOJu0YyjISUxnhDCg4oQFf9gK8MEuwiv4T+Bd8Pb7FFbMdWSYOpXD7Q7
        f9fVkq7nOFXJkABYmvAR8KPuyhn7wwu0SEWf+GlFoIdflEpAkbNeWPg=
X-Google-Smtp-Source: AGHT+IG+ZyBeZ0CLPfoumkQrBc86+ccJD0aqllH3DMSEJCfF0qUcyiO7GaiarKOm4FqE92bRK9O71qXTxuCxvfGIsww=
X-Received: by 2002:a05:6102:200f:b0:45c:c42d:87cb with SMTP id
 p15-20020a056102200f00b0045cc42d87cbmr2466070vsr.24.1698927427313; Thu, 02
 Nov 2023 05:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231026080409.4149616-1-jens.wiklander@linaro.org>
 <CAFA6WYOYRQ4BgyUE90EwAVULsa=qDkZ4C=0rX49e-E3LOvyz6Q@mail.gmail.com> <20231102115925.GA1233092@rayden>
In-Reply-To: <20231102115925.GA1233092@rayden>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 2 Nov 2023 17:46:55 +0530
Message-ID: <CAFA6WYPh-hfzcuLOHToby_vuQcqHh64kF0WQ4AdoaRwjeyyFFg@mail.gmail.com>
Subject: Re: [PATCH 0/2] OP-TEE FF-A notifications
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Olivier Deprez <Olivier.Deprez@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023 at 17:29, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi Sumit,
>
> On Mon, Oct 30, 2023 at 11:32:47AM +0530, Sumit Garg wrote:
> > Hi Jens,
> >
> > On Thu, 26 Oct 2023 at 13:34, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > >
> > > Hi all,
> > >
> > > This patchset adds support for using FF-A notifications as a delivery
> > > mechanism of asynchronous notifications from OP-TEE running in the secure
> > > world. Support for asynchronous notifications via the SMC ABI was added in
> > > [1], here we add the counterpart needed when using the the FF-A ABI.
> > >
> > > Support for FF-A notifications is added with [2] and this patch set is based
> > > on Sudeeps tree at [3].
> >
> > It's good to see FF-A notifications support coming through. The good
> > aspect here is that FF-A uses a common secure world SGI for
> > notifications and doesn't have to deal with platform specific reserved
> > SPI for notifications.
> >
> > From OP-TEE point of view I think most of the secure SGI donation base
> > would be common, so can we switch the SMC ABI to use this donated
> > secure world SGI for notifications too?
>
> The SMC ABI driver picks up the interrupt used for notification from
> device-tree, so there's a chance that it just works if a donated SGI is
> supplied instead. We'll need some changes in the secure world side of
> OP-TEE, but they wouldn't affect the ABI.

AFAIK, a secure world donated SGIs doesn't support IRQ mapping via DT.
The FF-A driver explicitly creates that mapping here [1]. Moreover
it's better to detect it via an SMC call rather than hard coded via DT
as FF-A driver does.

So the ABI should dynamically detect if there is a donated SGI then
use it otherwise fallback to SPI/PPI detection via DT. This would make
the notifications feature platform agnostic and we can drop legacy DT
methods from optee-os entirely but still need to maintain them in the
kernel for backwards compatibility.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/tree/drivers/firmware/arm_ffa/driver.c?h=ffa-updates-6.7#n1283
[2] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/tree/drivers/firmware/arm_ffa/driver.c?h=ffa-updates-6.7#n1275

-Sumit

>
> Cheers,
> Jens
>
> >
> > -Sumit
> >
> > >
> > > [1] https://lore.kernel.org/lkml/20211103090255.998070-1-jens.wiklander@linaro.org/
> > > [2] https://lore.kernel.org/linux-arm-kernel/20231005-ffa_v1-1_notif-v4-0-cddd3237809c@arm.com/
> > > [3] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/tag/?h=ffa-updates-6.7
> > >     commit bcefd1bf63b1 ("firmware: arm_ffa: Upgrade the driver version to v1.1")
> > >
> > > Thanks,
> > > Jens
> > >
> > > Jens Wiklander (2):
> > >   optee: provide optee_do_bottom_half() as a common function
> > >   optee: ffa_abi: add asynchronous notifications
> > >
> > >  drivers/tee/optee/call.c          | 31 ++++++++++-
> > >  drivers/tee/optee/ffa_abi.c       | 91 ++++++++++++++++++++++++++++++-
> > >  drivers/tee/optee/optee_ffa.h     | 28 ++++++++--
> > >  drivers/tee/optee/optee_private.h |  9 ++-
> > >  drivers/tee/optee/smc_abi.c       | 36 ++----------
> > >  5 files changed, 153 insertions(+), 42 deletions(-)
> > >
> > >
> > > base-commit: bcefd1bf63b1ec9bb08067021cf47f0fad96f395
> > > --
> > > 2.34.1
> > >
