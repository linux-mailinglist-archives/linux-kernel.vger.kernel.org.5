Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFC27BFD3F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjJJNW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjJJNWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:22:25 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E021B0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:22:24 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3af65455e7cso4083845b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696944143; x=1697548943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kFYaphee/OWYJ27akU61ySL2pcyi+L0fBa4hg4/3zoY=;
        b=BgdjTdPC8Ng01xi+Q0/55efSNnkwtmnc6+NJpj/F0j/J01VfkW/FwJ+GzRXhdPX7/g
         qbxbxkcGDErAfB6QO7FF/axX8U3lWU9YDYtXpTUe+9kQu8iuZvIFcjK1ofhKaDlAsb80
         qG+/m2pPFFQMxDAhm82iBzOTd8s/exTuPK/TuaLyEHnWfCm75dz7eWd4dZKLqbxo9dzT
         ez2ZuvaMD4FkF98RUjCexd2SHHs4oEDrz47+LO1qt59swSXs9QCB6DYwBARBNTSpi+x/
         VZhFWQNIfXALR4X75RCOZ7Uwra1O3FKqVZGJhTVZSdLEEagZUKFoUXWWnDC5bCvVbYm6
         R/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696944143; x=1697548943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFYaphee/OWYJ27akU61ySL2pcyi+L0fBa4hg4/3zoY=;
        b=LbPDKiNIcKPtv6tvqsZ34d0POA+guEDQQJEhAbSYwqCLQOwOdOiNJ9ZJQxDjOeJt5Y
         O0ArKC77lZhFdIKbo553TDm5BiePiRSQ014AcQq60ssNbwpak7DyP02M/LpmbgLN4uE1
         d32MBynvUWpPE2PilTKZBhu3Wf5l7tqyqDuPLvNbZ2myj4KNjFYa+TEVOZ683n4EJX3N
         ILBHte73NCiDScXZv15dwPUPYKUo/jU1YksCo7UGMK2uVryWr56jQwgDxxWf6Vsmcmwd
         5OrGXDWAdJXVqaaNHx9wOyswmCuUEWmhedXrkbRbyqPtOO6zWJJAf0VbnkU8JSbL85C5
         LpDQ==
X-Gm-Message-State: AOJu0YzJvS6jwSESUxqpTm6A9EBpDit9vbLiy75kdUQ/BIt8h3WJAEHl
        2DArrmq6uxfIcfmc/gouH5m6IuPCvLD4qnVWunw=
X-Google-Smtp-Source: AGHT+IGt5DfbIAyyFbvDL1031BwHE+134NWp0GPw9ZXRVvuTrzv7JENSrRl2NlkoylidPQmariFEOw==
X-Received: by 2002:aca:1c18:0:b0:3ae:5c89:dcc2 with SMTP id c24-20020aca1c18000000b003ae5c89dcc2mr19889308oic.34.1696944142863;
        Tue, 10 Oct 2023 06:22:22 -0700 (PDT)
Received: from [192.168.2.7] (pool-108-31-156-225.washdc.fios.verizon.net. [108.31.156.225])
        by smtp.gmail.com with ESMTPSA id r5-20020ac85205000000b004181aa90b46sm4492961qtn.89.2023.10.10.06.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 06:22:22 -0700 (PDT)
Message-ID: <920a671c-1927-4086-950f-db8e3293a989@linaro.org>
Date:   Tue, 10 Oct 2023 09:22:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Stratos-dev] [PATCH V3 2/2] xen: privcmd: Add support for
 ioeventfd
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
References: <cover.1696850733.git.viresh.kumar@linaro.org>
 <957de2a53dde99a653b47af9c95bc17692870294.1696850733.git.viresh.kumar@linaro.org>
From:   Bill Mills <bill.mills@linaro.org>
In-Reply-To: <957de2a53dde99a653b47af9c95bc17692870294.1696850733.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 10/9/23 7:29 AM, Viresh Kumar via Stratos-dev wrote:
> Virtio guests send VIRTIO_MMIO_QUEUE_NOTIFY notification when they need
> to notify the backend of an update to the status of the virtqueue. The
> backend or another entity, polls the MMIO address for updates to know
> when the notification is sent.
> 
> It works well if the backend does this polling by itself. But as we move
> towards generic backend implementations, we end up implementing this in
> a separate user-space program.
> 
> Generally, the Virtio backends are implemented to work with the Eventfd
> based mechanism. In order to make such backends work with Xen, another
> software layer needs to do the polling and send an event via eventfd to
> the backend once the notification from guest is received. This results
> in an extra context switch.
> 
> This is not a new problem in Linux though. It is present with other
> hypervisors like KVM, etc. as well. The generic solution implemented in
> the kernel for them is to provide an IOCTL call to pass the address to
> poll and eventfd, which lets the kernel take care of polling and raise
> an event on the eventfd, instead of handling this in user space (which
> involves an extra context switch).
> 
> This patch adds similar support for xen.
> 
> Inspired by existing implementations for KVM, etc..
> 
> This also copies ioreq.h header file (only struct ioreq and related
> macros) from Xen's source tree (Top commit 5d84f07fe6bf ("xen/pci: drop
> remaining uses of bool_t")).
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/xen/Kconfig               |   8 +-
>   drivers/xen/privcmd.c             | 405 +++++++++++++++++++++++++++++-
>   include/uapi/xen/privcmd.h        |  18 ++
>   include/xen/interface/hvm/ioreq.h |  51 ++++
>   4 files changed, 476 insertions(+), 6 deletions(-)
>   create mode 100644 include/xen/interface/hvm/ioreq.h
> 
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index d43153fec18e..d5989871dd5d 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -269,12 +269,12 @@ config XEN_PRIVCMD
>   	  disaggregated Xen setups this driver might be needed for other
>   	  domains, too.
>   
> -config XEN_PRIVCMD_IRQFD
> -	bool "Xen irqfd support"
> +config XEN_PRIVCMD_EVENTFD
> +	bool "Xen Ioeventfd and irqfd support"

You certainly know about kernel policies better than I but why the 
CONGIG_ name change?

With this change all downstream distros need to find this and re-enable 
it if they want to keep a working Xen system.

I presume the kernel can still work in the old way and not use your new 
mode correct?

I would certainly change the description but I wonder about keeping the 
CONFIG_ name the same.

No issue if I am obviously wrong and this is done all the time.

Thanks,
Bill
