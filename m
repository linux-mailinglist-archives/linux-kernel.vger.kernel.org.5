Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9C07DF1DA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345667AbjKBL7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjKBL7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:59:41 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EC4C2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:59:35 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5b999980689so617032a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 04:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698926375; x=1699531175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v6GIry2u37qS/paTC8hDQ4u7eRD8q6M0WQU/suo4YZk=;
        b=e3u5kGyhqwIsfFu2wCDigy/6NsuA8c3G5jFNSo/rfGifZO1op9PUdiQ5l0lXqj3rLl
         5tWb9wCycsD/yQga+AC1pF33P9o6rjAt4Q2O0Jj8yyrH+pk2fQjB5rT5SFl7Z8UBwogZ
         Sq3BBoyJbN3VWqg/LTEGKM+UXazsdzczOrUpjAdrDgphsByFhrQj6Ph2pYVdpj04TG+e
         HzqKLRYpAxDVtdlGiygddp9Jdr0iMLyln72BDH86V3gI9B89XdIg3dbtmBEovLix+Sh3
         iduFnMdrsPJiUoeS9lZsx4rCel0unMfwxI5FQv6vGI5J9WeigPi2P4Nq0g2zSl1m5lml
         /03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698926375; x=1699531175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6GIry2u37qS/paTC8hDQ4u7eRD8q6M0WQU/suo4YZk=;
        b=UAjb4vVf47tEPuzQc4e5lMvVpsv2TQnOBBw4Nm6TXM502E8woHsuxrA5KnDOYVG5Ko
         0M2rGqm9RlrVy9Rsqjcd3KfbKq9n12Kh4tPOXkr6gdvV2DONtYizdzYZpibNkgoQOJlq
         KpAa/cp6QzeLURaOahvoIxNcU1PSqmlYAUuPM8EoqBdoVN5CLkmzW/pyHcCfmHXzY8ak
         gvXTEfOSZMbG17gFpqVm7cw+YVo+Ab2hCykjO5vv6iPyBvARA2FAucZuN0sHv4KLN7At
         2/gWVfQmEC/EzgtgadIBpSDAPbnXrnbtRt2QZ7Sd54in5ZXg+gkNwer52zn8XZN5//XU
         +OWg==
X-Gm-Message-State: AOJu0YyUMYJbZfTP/WIVjB0idKJ6R8gCwoak3y2gb245bVAhmrrCd3/B
        By9OcUjcItMX+CgYKFnBo+tTMw==
X-Google-Smtp-Source: AGHT+IEzUMwVaz76qCPmMCzFCT7XpBn4OPpLVH1Mn79Zk3bd3nXEOmmKj30AMNaVYof3vYbhUFCV3g==
X-Received: by 2002:a05:6a20:7f93:b0:171:737:df99 with SMTP id d19-20020a056a207f9300b001710737df99mr19777401pzj.40.1698926375155;
        Thu, 02 Nov 2023 04:59:35 -0700 (PDT)
Received: from rayden (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id d21-20020aa78695000000b006c148c6767bsm2725910pfo.218.2023.11.02.04.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 04:59:34 -0700 (PDT)
Date:   Thu, 2 Nov 2023 12:59:25 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Olivier Deprez <Olivier.Deprez@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH 0/2] OP-TEE FF-A notifications
Message-ID: <20231102115925.GA1233092@rayden>
References: <20231026080409.4149616-1-jens.wiklander@linaro.org>
 <CAFA6WYOYRQ4BgyUE90EwAVULsa=qDkZ4C=0rX49e-E3LOvyz6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFA6WYOYRQ4BgyUE90EwAVULsa=qDkZ4C=0rX49e-E3LOvyz6Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On Mon, Oct 30, 2023 at 11:32:47AM +0530, Sumit Garg wrote:
> Hi Jens,
> 
> On Thu, 26 Oct 2023 at 13:34, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Hi all,
> >
> > This patchset adds support for using FF-A notifications as a delivery
> > mechanism of asynchronous notifications from OP-TEE running in the secure
> > world. Support for asynchronous notifications via the SMC ABI was added in
> > [1], here we add the counterpart needed when using the the FF-A ABI.
> >
> > Support for FF-A notifications is added with [2] and this patch set is based
> > on Sudeeps tree at [3].
> 
> It's good to see FF-A notifications support coming through. The good
> aspect here is that FF-A uses a common secure world SGI for
> notifications and doesn't have to deal with platform specific reserved
> SPI for notifications.
> 
> From OP-TEE point of view I think most of the secure SGI donation base
> would be common, so can we switch the SMC ABI to use this donated
> secure world SGI for notifications too?

The SMC ABI driver picks up the interrupt used for notification from
device-tree, so there's a chance that it just works if a donated SGI is
supplied instead. We'll need some changes in the secure world side of
OP-TEE, but they wouldn't affect the ABI.

Cheers,
Jens

> 
> -Sumit
> 
> >
> > [1] https://lore.kernel.org/lkml/20211103090255.998070-1-jens.wiklander@linaro.org/
> > [2] https://lore.kernel.org/linux-arm-kernel/20231005-ffa_v1-1_notif-v4-0-cddd3237809c@arm.com/
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/tag/?h=ffa-updates-6.7
> >     commit bcefd1bf63b1 ("firmware: arm_ffa: Upgrade the driver version to v1.1")
> >
> > Thanks,
> > Jens
> >
> > Jens Wiklander (2):
> >   optee: provide optee_do_bottom_half() as a common function
> >   optee: ffa_abi: add asynchronous notifications
> >
> >  drivers/tee/optee/call.c          | 31 ++++++++++-
> >  drivers/tee/optee/ffa_abi.c       | 91 ++++++++++++++++++++++++++++++-
> >  drivers/tee/optee/optee_ffa.h     | 28 ++++++++--
> >  drivers/tee/optee/optee_private.h |  9 ++-
> >  drivers/tee/optee/smc_abi.c       | 36 ++----------
> >  5 files changed, 153 insertions(+), 42 deletions(-)
> >
> >
> > base-commit: bcefd1bf63b1ec9bb08067021cf47f0fad96f395
> > --
> > 2.34.1
> >
