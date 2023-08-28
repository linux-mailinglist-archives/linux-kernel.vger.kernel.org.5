Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574E678B30D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjH1O1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjH1O0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:26:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E047011A;
        Mon, 28 Aug 2023 07:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73BC66425F;
        Mon, 28 Aug 2023 14:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D771C433C8;
        Mon, 28 Aug 2023 14:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693232792;
        bh=HIrFHgWhQZpe35N9L4BQZ+OnaWUt3RZd9gRbJ86S2mc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gjRE/U1K8ajkhTC4vsPmijhxcf5G8em4eWy7C4aCWu2Z0FIWaXghHJjGEKCOtGA8c
         Fu+Dat222eWmkuQd/k4q71ws6O32wwY8VTWcqXubU6qLQ3A2ayFFDY2KnpRHXhgv3d
         +ByKpvFZm9xffEst8puAVXC7rNXGrPl0IhHnRQTIjVHYZ3ku3tkosq0aodIr5TrUD3
         0Kfm7ifQVy/wjKN6T/bSGBwhTNfCQvuCI3h6C/KN+qCRYf+A41GELe6GgJNWbRB1fk
         nPNB0vwmKbJ+UBwJVVRofAq/TlbACk8j+MO8fkuTAFvDnyFY3bKBMzd0Z/pZn1o5nt
         6NO6q1N+xGwLw==
Received: (nullmailer pid 440513 invoked by uid 1000);
        Mon, 28 Aug 2023 14:26:30 -0000
Date:   Mon, 28 Aug 2023 09:26:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Lizhi Hou <lizhi.hou@amd.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: unittest: Fix of_unittest_pci_node() kconfig
 dependencies
Message-ID: <169323269352.438100.1553765681221364058.robh@kernel.org>
References: <20230824221743.1581707-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824221743.1581707-1-robh@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Aug 2023 17:17:34 -0500, Rob Herring wrote:
> of_unittest_pci_node test depends on both CONFIG_PCI_DYNAMIC_OF_NODES
> and CONFIG_OF_OVERLAY. Move the test into the existing
> CONFIG_OF_OVERLAY ifdef and rework the CONFIG_PCI_DYNAMIC_OF_NODES
> dependency to use IS_ENABLED() instead. This reduces the combinations to
> build.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308241954.oRNfVqmB-lkp@intel.com/
> Fixes: 26409dd04589 ("of: unittest: Add pci_dt_testdrv pci driver")
> Cc: Lizhi Hou <lizhi.hou@amd.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/unittest.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 

Applied, thanks!

