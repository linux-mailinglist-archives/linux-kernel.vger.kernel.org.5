Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6F980A5CB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573988AbjLHOjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573991AbjLHOjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:39:06 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A007E19A4;
        Fri,  8 Dec 2023 06:39:00 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Smv0G6ChVz6K5rY;
        Fri,  8 Dec 2023 22:38:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
        by mail.maildlp.com (Postfix) with ESMTPS id A92FB140680;
        Fri,  8 Dec 2023 22:38:58 +0800 (CST)
Received: from localhost (10.126.175.81) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 8 Dec
 2023 14:38:58 +0000
Date:   Fri, 8 Dec 2023 14:38:57 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Robert Richter <rrichter@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 3/3] PCI/AER: Use explicit register sizes for struct
 members
Message-ID: <20231208143857.000061f4@Huawei.com>
In-Reply-To: <20231206224231.732765-4-helgaas@kernel.org>
References: <20231206224231.732765-1-helgaas@kernel.org>
        <20231206224231.732765-4-helgaas@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.175.81]
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

On Wed,  6 Dec 2023 16:42:31 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> aer_irq() reads the AER Root Error Status and Error Source Identification
> (PCI_ERR_ROOT_STATUS and PCI_ERR_ROOT_ERR_SRC) registers directly into
> struct aer_err_source.  Both registers are 32 bits, so declare the members
> explicitly as "u32" instead of "unsigned int".
> 
> Similarly, aer_get_device_error_info() reads the AER Header Log
> (PCI_ERR_HEADER_LOG) registers, which are also 32 bits, into struct
> aer_header_log_regs.  Declare those members as "u32" as well.
> 
> No functional changes intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Another sensible cleanup. FWIW on such simple patches
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
