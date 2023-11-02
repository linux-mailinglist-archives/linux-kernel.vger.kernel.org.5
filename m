Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905DF7DF376
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjKBNQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjKBNQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:16:34 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C31E112
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 06:16:28 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54394328f65so1512477a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 06:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698930987; x=1699535787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E5yaAbDPiXna8dJi00+Wdpz/feY1oyYdejkU9IxY/M0=;
        b=m7S4kN6ecsyzS7Rrq41/WYIlfEKWPVJtyxpei85jBlBC9v8QTaHmtNZKaMEApLguPR
         PLzRrj3MKJ2nSGu7sDGrm+6BKg8rkaZWN/rCDAygV6dYMQWw2zQbC8ke/CGzNPZCjgPo
         +eM8dfKrqyHcc6whdiov5zQ5BAjGAYA8N4ZHPIPCYWgS8isiyvGbjWpNT0ZJ9moMcnj4
         0qakWeBDUJOrNuVorTTyketeoBN3QTe6vjUpOcf88UaLd2rLWkPzOomFxRnUmNZplJ/S
         B/dG8gTQknkQp+0Bt+ri06sGNadJgtNjzSb9luE4Kkdc6hDhgcUIVocC/iA4vhorK1vm
         ZR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698930987; x=1699535787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5yaAbDPiXna8dJi00+Wdpz/feY1oyYdejkU9IxY/M0=;
        b=cVKGFTWBwnm0iXjF7+W5px2ts4/mF0vmsjpAaHTi5qHimuHuIbLblpbYTvCqbgihbj
         5bggj0OrefkopxPjeYuwyoq4VPlADVzQ+5ot9kqo9sG5QYXu/Se1DsvbalxnjaXx5ywg
         n39bwOVEBSsvVrywmNNURMwO32VS0aAX8tmKseGwiyUqjxhDX/vciVvCDnblmFyDJBoK
         YAqHDPM/WlfDjRaNFs0pUHvkifegX5dYM+mrT6LbjKExUu3yjhQztFffU2Nj1Va1bO2R
         I1bO3q6PsW9IgvWozz2WY2b4Osl5C5ZVPoufNCl7T5V6lROIJWOiZkvIgbn2irQpE9qI
         eDuQ==
X-Gm-Message-State: AOJu0YxPXzmhVAxaTAke0tQYxVfpnrca/M46hkURz3xOIJscJBmNVnIn
        E06V3cSTKhBo7gCVfx9EmQaBCA==
X-Google-Smtp-Source: AGHT+IGlecP3N2NT8y2y1I4Z1GJe0VJUiLksMzOTehsapNyXxMIAY1OFfxB535vV7YU1dC5JnfC1yQ==
X-Received: by 2002:a50:aacf:0:b0:543:bf55:248b with SMTP id r15-20020a50aacf000000b00543bf55248bmr3548620edc.13.1698930986951;
        Thu, 02 Nov 2023 06:16:26 -0700 (PDT)
Received: from rayden (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id w13-20020a056402268d00b0053da3a9847csm2317972edd.42.2023.11.02.06.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 06:16:26 -0700 (PDT)
Date:   Thu, 2 Nov 2023 14:16:24 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Olivier Deprez <Olivier.Deprez@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH 0/2] OP-TEE FF-A notifications
Message-ID: <20231102131624.GB1233092@rayden>
References: <20231026080409.4149616-1-jens.wiklander@linaro.org>
 <CAFA6WYOYRQ4BgyUE90EwAVULsa=qDkZ4C=0rX49e-E3LOvyz6Q@mail.gmail.com>
 <20231102115925.GA1233092@rayden>
 <CAFA6WYPh-hfzcuLOHToby_vuQcqHh64kF0WQ4AdoaRwjeyyFFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFA6WYPh-hfzcuLOHToby_vuQcqHh64kF0WQ4AdoaRwjeyyFFg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 05:46:55PM +0530, Sumit Garg wrote:
> On Thu, 2 Nov 2023 at 17:29, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Hi Sumit,
> >
> > On Mon, Oct 30, 2023 at 11:32:47AM +0530, Sumit Garg wrote:
> > > Hi Jens,
> > >
> > > On Thu, 26 Oct 2023 at 13:34, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > This patchset adds support for using FF-A notifications as a delivery
> > > > mechanism of asynchronous notifications from OP-TEE running in the secure
> > > > world. Support for asynchronous notifications via the SMC ABI was added in
> > > > [1], here we add the counterpart needed when using the the FF-A ABI.
> > > >
> > > > Support for FF-A notifications is added with [2] and this patch set is based
> > > > on Sudeeps tree at [3].
> > >
> > > It's good to see FF-A notifications support coming through. The good
> > > aspect here is that FF-A uses a common secure world SGI for
> > > notifications and doesn't have to deal with platform specific reserved
> > > SPI for notifications.
> > >
> > > From OP-TEE point of view I think most of the secure SGI donation base
> > > would be common, so can we switch the SMC ABI to use this donated
> > > secure world SGI for notifications too?
> >
> > The SMC ABI driver picks up the interrupt used for notification from
> > device-tree, so there's a chance that it just works if a donated SGI is
> > supplied instead. We'll need some changes in the secure world side of
> > OP-TEE, but they wouldn't affect the ABI.
> 
> AFAIK, a secure world donated SGIs doesn't support IRQ mapping via DT.
> The FF-A driver explicitly creates that mapping here [1].

That looks a lot like what platform_get_irq() does via of_irq_get().

> Moreover
> it's better to detect it via an SMC call rather than hard coded via DT
> as FF-A driver does.

Typo? I guess you mean that you prefer that way the FF-A driver does it
rather than having it set in the DT.

Assuming that you only care about "arm,gic-v3". The SGI will likely
always be the same so it shouldn't be too hard to keep the correct
configuration in DT.

> 
> So the ABI should dynamically detect if there is a donated SGI then
> use it otherwise fallback to SPI/PPI detection via DT. This would make
> the notifications feature platform agnostic and we can drop legacy DT
> methods from optee-os entirely but still need to maintain them in the
> kernel for backwards compatibility.

We care about compatibility in both directions so we'd need to keep it
in OP-TEE too, but perhaps under a config flag.

Thanks,
Jens

> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/tree/drivers/firmware/arm_ffa/driver.c?h=ffa-updates-6.7#n1283
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/tree/drivers/firmware/arm_ffa/driver.c?h=ffa-updates-6.7#n1275
> 
> -Sumit
> 
> >
> > Cheers,
> > Jens
> >
> > >
> > > -Sumit
> > >
> > > >
> > > > [1] https://lore.kernel.org/lkml/20211103090255.998070-1-jens.wiklander@linaro.org/
> > > > [2] https://lore.kernel.org/linux-arm-kernel/20231005-ffa_v1-1_notif-v4-0-cddd3237809c@arm.com/
> > > > [3] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/tag/?h=ffa-updates-6.7
> > > >     commit bcefd1bf63b1 ("firmware: arm_ffa: Upgrade the driver version to v1.1")
> > > >
> > > > Thanks,
> > > > Jens
> > > >
> > > > Jens Wiklander (2):
> > > >   optee: provide optee_do_bottom_half() as a common function
> > > >   optee: ffa_abi: add asynchronous notifications
> > > >
> > > >  drivers/tee/optee/call.c          | 31 ++++++++++-
> > > >  drivers/tee/optee/ffa_abi.c       | 91 ++++++++++++++++++++++++++++++-
> > > >  drivers/tee/optee/optee_ffa.h     | 28 ++++++++--
> > > >  drivers/tee/optee/optee_private.h |  9 ++-
> > > >  drivers/tee/optee/smc_abi.c       | 36 ++----------
> > > >  5 files changed, 153 insertions(+), 42 deletions(-)
> > > >
> > > >
> > > > base-commit: bcefd1bf63b1ec9bb08067021cf47f0fad96f395
> > > > --
> > > > 2.34.1
> > > >
