Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A93771140
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjHESFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjHESFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:05:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128AF1A4;
        Sat,  5 Aug 2023 11:04:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B4AD60D41;
        Sat,  5 Aug 2023 18:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DB8C433C7;
        Sat,  5 Aug 2023 18:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691258698;
        bh=xBCbNByM2zM6Uu+EhMN5x/0VWLzyzREN31JtUtuJoYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WfE3BssWdMxhRPwD4a2GY6i4c4R4RzLN0bOviBcW/DR0pFWyjgO82HWpklyuhX8u2
         17Iw/ltaDtQ8rB4nuU4eAgpFCKEjRi9DNKQpk1O8ciiml7TV0S6Rj1G9tfm6756M+k
         c0rmaZo+bikBS0RSYbChAk5GVWv9bTkDNzwYeSPYqRQu4z6Iy+zka9zspEAZN85eV5
         E0uLezxjFl3Gn/a/q7C5epU+/hYP+p2Lp26/Q/wZWC+FlA6ArWEzeeaF8qFd9a59B+
         67VTv2Ikpm3o+Kg2HCHNIsJ0vXjYklC3HomZi4IIB7kbkMdZS7A8kfv0+ZLZ+oDH9d
         uHakEmXPqg+TQ==
Date:   Sat, 5 Aug 2023 11:07:55 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v14 14/25] gunyah: rsc_mgr: Add platform ops on
 mem_lend/mem_reclaim
Message-ID: <tresq6hho3iqo4z6lmsknalx7452hb4zpmefoaugypgwqkyk4p@rrmsuly65vpg>
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
 <20230613172054.3959700-15-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613172054.3959700-15-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:20:42AM -0700, Elliot Berman wrote:
> On Qualcomm platforms, there is a firmware entity which controls access
> to physical pages. In order to share memory with another VM, this entity
> needs to be informed that the guest VM should have access to the memory.
> 

Why isn't this handled by the system above us?

> Reviewed-by: Alex Elder <elder@linaro.org>
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  drivers/virt/gunyah/Kconfig                 |  4 ++
>  drivers/virt/gunyah/Makefile                |  2 +
>  drivers/virt/gunyah/gunyah_platform_hooks.c | 80 +++++++++++++++++++++
>  drivers/virt/gunyah/rsc_mgr.h               |  3 +
>  drivers/virt/gunyah/rsc_mgr_rpc.c           | 18 ++++-
>  include/linux/gunyah_rsc_mgr.h              | 17 +++++
>  6 files changed, 122 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/virt/gunyah/gunyah_platform_hooks.c
> 
> diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
> index 1a737694c333d..de815189dab6c 100644
> --- a/drivers/virt/gunyah/Kconfig
> +++ b/drivers/virt/gunyah/Kconfig
> @@ -4,6 +4,7 @@ config GUNYAH
>  	tristate "Gunyah Virtualization drivers"
>  	depends on ARM64
>  	depends on MAILBOX
> +	select GUNYAH_PLATFORM_HOOKS
>  	help
>  	  The Gunyah drivers are the helper interfaces that run in a guest VM
>  	  such as basic inter-VM IPC and signaling mechanisms, and higher level
> @@ -11,3 +12,6 @@ config GUNYAH
>  
>  	  Say Y/M here to enable the drivers needed to interact in a Gunyah
>  	  virtual environment.
> +
> +config GUNYAH_PLATFORM_HOOKS

Automatically selected by GUNYAH and the only platform so far, no need
to keep this as a separate Kconfig.

> +	tristate
> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> index bacf78b8fa337..4fbeee521d60a 100644
> --- a/drivers/virt/gunyah/Makefile
> +++ b/drivers/virt/gunyah/Makefile
> @@ -1,4 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> +obj-$(CONFIG_GUNYAH_PLATFORM_HOOKS) += gunyah_platform_hooks.o
> +

Why is this added before the core gunyah components?

>  gunyah-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mm.o
>  obj-$(CONFIG_GUNYAH) += gunyah.o

Regards,
Bjorn
