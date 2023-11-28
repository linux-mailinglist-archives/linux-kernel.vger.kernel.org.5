Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E4D7FC2E6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346788AbjK1PUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346774AbjK1PUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:20:14 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CD010D7;
        Tue, 28 Nov 2023 07:20:16 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SfmNF1qh9z6D8Wv;
        Tue, 28 Nov 2023 23:19:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
        by mail.maildlp.com (Postfix) with ESMTPS id 33CFB140CB9;
        Tue, 28 Nov 2023 23:20:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 15:20:09 +0000
Date:   Tue, 28 Nov 2023 15:20:08 +0000
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
Subject: Re: [PATCH RFC 20/22] LoongArch: convert to use
 arch_cpu_is_hotpluggable()
Message-ID: <20231128152008.000008ed@Huawei.com>
In-Reply-To: <E1r0JML-00CTyV-9a@rmk-PC.armlinux.org.uk>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
        <E1r0JML-00CTyV-9a@rmk-PC.armlinux.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2023 10:31:01 +0000
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Convert loongarch to use the arch_cpu_is_hotpluggable() helper rather
> than arch_register_cpu(). Also remove the export as nothing should be
> using arch_register_cpu() outside of the core kernel/acpi code.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
