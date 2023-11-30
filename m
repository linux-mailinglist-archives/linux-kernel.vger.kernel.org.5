Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663037FF6DD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjK3Qsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjK3Qsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:48:37 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1C210E2;
        Thu, 30 Nov 2023 08:48:43 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sh2Cs19tDz6K9Bn;
        Fri,  1 Dec 2023 00:47:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
        by mail.maildlp.com (Postfix) with ESMTPS id C919D140684;
        Fri,  1 Dec 2023 00:48:41 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 Nov
 2023 16:48:40 +0000
Date:   Thu, 30 Nov 2023 16:48:40 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
CC:     <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
        <linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <x86@kernel.org>, <linux-csky@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
        <linux-parisc@vger.kernel.org>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <jianyong.wu@arm.com>, <justin.he@arm.com>,
        James Morse <james.morse@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Subject: Re: [PATCH 04/21] Loongarch: remove arch_*register_cpu() exports
Message-ID: <20231130164840.0000465f@Huawei.com>
In-Reply-To: <E1r5R2w-00Csyn-E2@rmk-PC.armlinux.org.uk>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
        <E1r5R2w-00Csyn-E2@rmk-PC.armlinux.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 13:44:10 +0000
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> arch_register_cpu() and arch_unregister_cpu() are not used by anything
> that can be a module - they are used by drivers/base/cpu.c and
> drivers/acpi/acpi_processor.c, neither of which can be a module.
> 
> Remove the exports.
> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  arch/loongarch/kernel/topology.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/loongarch/kernel/topology.c b/arch/loongarch/kernel/topology.c
> index 3fd166006698..ae860fe81536 100644
> --- a/arch/loongarch/kernel/topology.c
> +++ b/arch/loongarch/kernel/topology.c
> @@ -25,7 +25,6 @@ int arch_register_cpu(int cpu)
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL(arch_register_cpu);
>  
>  void arch_unregister_cpu(int cpu)
>  {
> @@ -34,7 +33,6 @@ void arch_unregister_cpu(int cpu)
>  	c->hotpluggable = 0;
>  	unregister_cpu(c);
>  }
> -EXPORT_SYMBOL(arch_unregister_cpu);
>  #endif
>  
>  static int __init topology_init(void)

