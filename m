Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812CA810ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377646AbjLMKt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377811AbjLMKt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:49:27 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE41B2;
        Wed, 13 Dec 2023 02:49:32 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 0B3B128042DAC;
        Wed, 13 Dec 2023 11:49:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 004AD231117; Wed, 13 Dec 2023 11:49:30 +0100 (CET)
Date:   Wed, 13 Dec 2023 11:49:30 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc:     bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
        will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Haorong Ye <yehaorong@bytedance.com>
Subject: Re: [PATCH 1/2] PCI: make pci_dev_is_disconnected() helper public
 for other drivers
Message-ID: <20231213104930.GB31964@wunner.de>
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
 <20231213034637.2603013-2-haifeng.zhao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213034637.2603013-2-haifeng.zhao@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 10:46:36PM -0500, Ethan Zhao wrote:
> move pci_dev_is_disconnected() from driver/pci/pci.h to public
> include/linux/pci.h for other driver's reference.
> no function change.

That's merely a prose description of the code.  A reader can already
see from the code what it's doing.  You need to explain the *reason*
for the change instead.  E.g.:  "Make pci_dev_is_disconnected() public
so that it can be called from $DRIVER to speed up hot removal
handling which may otherwise take seconds because of $REASONS."

Thanks,

Lukas
