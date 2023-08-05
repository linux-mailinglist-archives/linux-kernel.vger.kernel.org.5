Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CA8771151
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjHESIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHESIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:08:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C574619B;
        Sat,  5 Aug 2023 11:08:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59B9360DB5;
        Sat,  5 Aug 2023 18:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA552C433C7;
        Sat,  5 Aug 2023 18:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691258917;
        bh=o1T6WnCOl5nls/Z32FQUuI4vIWqJLvZNcazUro6lNio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oBXocZdCA2osDvHvD8WVyNio/gV6OKzFo9MtHyK/iBf0DY56PO9xJPizOMgKFDOPc
         dOx6hqB60YygH69+Jtn7OBjJG7RAF0yWkzsx0SYt+cZr9nZRtiHT9yCBb2jWsXddsg
         pFhgSg4krC+k/HQOV/w7tMEeEnStdR0V+NuQHhr5Eg3EAp10JmgAsNpfj1dN+HCZ9F
         a6/S/ATA530tyoOV7sxtuD0e+tLBKDRPQIVfBlJO6bsENv4qSr60KE8zDamwCTm1Xr
         aYSvNj6fQ20QcLuMEiYsnPkwqtjgwCUNgLfzuxMtb6SWcxzrTT6jK+j3GeSvmjOEp8
         quIqeBavQjmLg==
Date:   Sat, 5 Aug 2023 11:11:34 -0700
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
Subject: Re: [PATCH v14 15/25] virt: gunyah: Add Qualcomm Gunyah platform ops
Message-ID: <7bpdzvlrdxwqpxor36i4nha5qs4opvnf7tr4sfb7ta3ebl7fdl@c5nylbvtnv5y>
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
 <20230613172054.3959700-16-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613172054.3959700-16-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:20:43AM -0700, Elliot Berman wrote:
> Qualcomm platforms have a firmware entity which performs access control
> to physical pages. Dynamically started Gunyah virtual machines use the
> QCOM_SCM_RM_MANAGED_VMID for access. Linux thus needs to assign access
> to the memory used by guest VMs. Gunyah doesn't do this operation for us
> since it is the current VM (typically VMID_HLOS) delegating the access
> and not Gunyah itself. Use the Gunyah platform ops to achieve this so
> that only Qualcomm platforms attempt to make the needed SCM calls.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  drivers/virt/gunyah/Kconfig       |  13 +++
>  drivers/virt/gunyah/Makefile      |   1 +
>  drivers/virt/gunyah/gunyah_qcom.c | 153 ++++++++++++++++++++++++++++++
>  3 files changed, 167 insertions(+)
>  create mode 100644 drivers/virt/gunyah/gunyah_qcom.c
> 
> diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
> index de815189dab6c..0421b751aad4f 100644
> --- a/drivers/virt/gunyah/Kconfig
> +++ b/drivers/virt/gunyah/Kconfig
> @@ -5,6 +5,7 @@ config GUNYAH
>  	depends on ARM64
>  	depends on MAILBOX
>  	select GUNYAH_PLATFORM_HOOKS
> +	imply GUNYAH_QCOM_PLATFORM if ARCH_QCOM
>  	help
>  	  The Gunyah drivers are the helper interfaces that run in a guest VM
>  	  such as basic inter-VM IPC and signaling mechanisms, and higher level
> @@ -15,3 +16,15 @@ config GUNYAH
>  
>  config GUNYAH_PLATFORM_HOOKS
>  	tristate
> +
> +config GUNYAH_QCOM_PLATFORM
> +	tristate "Support for Gunyah on Qualcomm platforms"
> +	depends on GUNYAH
> +	select GUNYAH_PLATFORM_HOOKS
> +	select QCOM_SCM
> +	help
> +	  Enable support for interacting with Gunyah on Qualcomm
> +	  platforms. Interaction with Qualcomm firmware requires
> +	  extra platform-specific support.
> +
> +	  Say Y/M here to use Gunyah on Qualcomm platforms.
> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> index 4fbeee521d60a..2aa9ff038ed02 100644
> --- a/drivers/virt/gunyah/Makefile
> +++ b/drivers/virt/gunyah/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  obj-$(CONFIG_GUNYAH_PLATFORM_HOOKS) += gunyah_platform_hooks.o
> +obj-$(CONFIG_GUNYAH_QCOM_PLATFORM) += gunyah_qcom.o
>  
>  gunyah-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mm.o
>  obj-$(CONFIG_GUNYAH) += gunyah.o
> diff --git a/drivers/virt/gunyah/gunyah_qcom.c b/drivers/virt/gunyah/gunyah_qcom.c
> new file mode 100644
> index 0000000000000..f06a598f2e1b3
> --- /dev/null
> +++ b/drivers/virt/gunyah/gunyah_qcom.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/gunyah_rsc_mgr.h>
> +#include <linux/module.h>
> +#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/types.h>
> +#include <linux/uuid.h>
> +
> +#define QCOM_SCM_RM_MANAGED_VMID	0x3A
> +#define QCOM_SCM_MAX_MANAGED_VMID	0x3F
> +
> +static int qcom_scm_gh_rm_pre_mem_share(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel)
> +{
> +	struct qcom_scm_vmperm *new_perms;
> +	u64 src, src_cpy;
> +	int ret = 0, i, n;
> +	u16 vmid;
> +
> +	new_perms = kcalloc(mem_parcel->n_acl_entries, sizeof(*new_perms), GFP_KERNEL);
> +	if (!new_perms)
> +		return -ENOMEM;
> +
> +	for (n = 0; n < mem_parcel->n_acl_entries; n++) {
> +		vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
> +		if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
> +			new_perms[n].vmid = vmid;
> +		else
> +			new_perms[n].vmid = QCOM_SCM_RM_MANAGED_VMID;
> +		if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_X)
> +			new_perms[n].perm |= QCOM_SCM_PERM_EXEC;
> +		if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_W)
> +			new_perms[n].perm |= QCOM_SCM_PERM_WRITE;
> +		if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_R)
> +			new_perms[n].perm |= QCOM_SCM_PERM_READ;
> +	}
> +
> +	src = BIT_ULL(QCOM_SCM_VMID_HLOS);
> +
> +	for (i = 0; i < mem_parcel->n_mem_entries; i++) {
> +		src_cpy = src;
> +		ret = qcom_scm_assign_mem(le64_to_cpu(mem_parcel->mem_entries[i].phys_addr),
> +						le64_to_cpu(mem_parcel->mem_entries[i].size),
> +						&src_cpy, new_perms, mem_parcel->n_acl_entries);
> +		if (ret)
> +			break;
> +	}
> +
> +	if (!ret)
> +		goto out;

I was going to complain that you don't unroll the assignments on
failure, but now realized that this "error handling" is backwards and
actually represents the success case.

Please don't do that, goto error_handling || kfree(new_perms); return 0;
here instead.


That also means that you don't need to zero-initialize ret, because you
would goto err_reclaim inside the loop.

> +
> +	src = 0;
> +	for (n = 0; n < mem_parcel->n_acl_entries; n++) {
> +		vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
> +		if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
> +			src |= BIT_ULL(vmid);
> +		else
> +			src |= BIT_ULL(QCOM_SCM_RM_MANAGED_VMID);
> +	}
> +
> +	new_perms[0].vmid = QCOM_SCM_VMID_HLOS;
> +
> +	for (i--; i >= 0; i--) {
> +		src_cpy = src;
> +		WARN_ON_ONCE(qcom_scm_assign_mem(
> +				le64_to_cpu(mem_parcel->mem_entries[i].phys_addr),
> +				le64_to_cpu(mem_parcel->mem_entries[i].size),
> +				&src_cpy, new_perms, 1));
> +	}
> +
> +out:
> +	kfree(new_perms);
> +	return ret;
> +}

Regards,
Bjorn
