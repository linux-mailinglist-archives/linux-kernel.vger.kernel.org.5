Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBBD7F3342
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjKUQIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjKUQIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:08:45 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0EB18C;
        Tue, 21 Nov 2023 08:08:42 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507a55302e0so8280131e87.0;
        Tue, 21 Nov 2023 08:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700582920; x=1701187720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zRjkOqBRMmhvIXHuVwrrGHzbti912sOG+0V5mOgwkwU=;
        b=WoncN3WdrjpWAYYtfE/Yxs6+v4Wo1qX9orY7zXrTlQqCX8SZTojyl6bXD8FdI5e633
         15i9Kx8gvVin3/f7d3VOaN+p94dxORKv1zjq3+2wphLybZ9/P448RwWIR32aVRBR8jLl
         boxhm1MV7rcP3zbEWRMrcXYdRiu71PS+n8WUInazwq4ybA7LoVxviU3nwdEhd8jF7yEl
         VC07o49lv0E9akVVKC9dNqv2aeuZqGOatZ4JeT3uVAHFs8sMdPbovV1CyAEVbs8CHLqp
         g+Ay8s0K2j7Weu9tJGNia3h+c4PmxWJVAjLf8GVYkeughZ0UGePjRljsg0i69H2T40Br
         PEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700582920; x=1701187720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRjkOqBRMmhvIXHuVwrrGHzbti912sOG+0V5mOgwkwU=;
        b=oL77ouW/fME3NN7ZQ9oPKg8vWU5bb8Nmeb6zUTAkZvUKjxgRb8PaUViMJoLtkq35uM
         xv1c2RD5G1QJYeijQKMpMtmcffuQK8/rlSa51Ppjf0HJFKpxL/qF14NXTKh1kCOoGrdh
         4RId1Au0lCxCVfaOKSCewti5YgYTZZgWMKpqshnnJmfs6Agzhzfx6TC8DTRXQpp0FBMv
         vPDkVlF1+KPgzwbsIyV31xn+9vxE6GuVe4/g6dFNRjaL+rxH9aEUofA3ySO0FzHE8Avq
         CKDMHprJlBNTP+/eQFqC3kb9UILlcr/d9qkNsI6uoR44gT2BgDpBo0cPcS4Wjp4GCzZH
         V9WQ==
X-Gm-Message-State: AOJu0YxWJekEgnnmfFA+3jazHl59+9nZJSQWndozR9vGn2Jk1PeW82pu
        gQewPRLI6L6hj0WLtCBrWG8=
X-Google-Smtp-Source: AGHT+IFG9vRB3v1TrMf4vFSpltRDXMlu9u3haBbVqEFcdzua2WTC9rhlFL4fxhr6TFcdb8KPAXXQtg==
X-Received: by 2002:ac2:43a5:0:b0:507:ce2f:8f0c with SMTP id t5-20020ac243a5000000b00507ce2f8f0cmr7175385lfl.35.1700582920078;
        Tue, 21 Nov 2023 08:08:40 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id n16-20020a0565120ad000b004fb85ffc82csm1545270lfu.10.2023.11.21.08.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 08:08:39 -0800 (PST)
Date:   Tue, 21 Nov 2023 19:08:37 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v4 00/24] i2c: designware: code consolidation & cleanups
Message-ID: <e57s22hk6wrupnhjva7sqxobuy4rgkbnie4dfu34wx3yuvy357@cmpxpbnpja6s>
References: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 04:41:42PM +0200, Andy Shevchenko wrote:
> The series now consists the following groups of patches:
> - fixing cleanup order in error path and remove (patches 1-4)
> - refactoring i2c_dw_*_lock_support() (patches 5-6)
> - refactoring module alias and device ID tables (patches 7-10)
> - unifying firmware parsing and configuring code (patches 11-15)
> - miscellaneous cleanups (patches 16-17,21-24)
> - consolidating PM ops (patch 18)
> - using device_set_node() for all drivers (patches 19-20)
> 
> The "Consolidate PM ops" might be considered as rft, however I don't think
> we have any hardware where the behaviour will be changed, anyways, good
> to test.
> 
> Changelog v4:
> - dropped first patch as controversial (Jarkko)
> - dropped Fixes tag from a few patches (Jarkko)
> - moved a hunk in patch 1 to patch 2 where it belongs (Jarkko)
> - exported i2c_dw_disable() for modular building (Jarkko)
> - added tags (Mario, Jarkko)

It looks like the series review is almost over. I've got it tested on
DW APB I2C v1.21a on a platform with the directly and indirectly
accessible registers. No problem spotted. Thanks!

Tested-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> v3: https://lore.kernel.org/r/20231110182304.3894319-1-andriy.shevchenko@linux.intel.com
> 
> Changelog v3:
> - doubled the size of the series
> - fixed compilation error (LKP)
> - added tags (Andi)
> 
> v2: https://lore.kernel.org/r/20231109182823.3531846-1-andriy.shevchenko@linux.intel.com
> 
> Changelog v2:
> - reworked the series to make it less twisted (Jarkko, Andi)
> - added tags to the patches that have been rebased (Andi, Mario, Jarkko)
> - introduced a few new changes (PM ops, export namespace)
> 
> v1: https://lore.kernel.org/r/20230725143023.86325-1-andriy.shevchenko@linux.intel.com
> 
> Andy Shevchenko (24):
>   i2c: designware: Fix PM calls order in dw_i2c_plat_probe()
>   i2c: designware: Fix reset call order in dw_i2c_plat_probe()
>   i2c: designware: Let PCI core to take care about interrupt vectors
>   i2c: designware: Fix lock probe call order in dw_i2c_plat_probe()
>   i2c: designware: Replace a while-loop by for-loop
>   i2c: designware: Save pointer to semaphore callbacks instead of index
>   i2c: designware: Add missing 'c' into PCI IDs variable name
>   i2c: designware: Replace MODULE_ALIAS() with MODULE_DEVICE_TABLE()
>   i2c: designware: Unify terminator in device ID tables
>   i2c: designware: Always provide device ID tables
>   i2c: designware: Drop return value from i2c_dw_acpi_configure()
>   i2c: designware: Drop return value from dw_i2c_of_configure()
>   i2c: designware: Rename dw_i2c_of_configure() -> i2c_dw_of_configure()
>   i2c: designware: Consolidate firmware parsing and configuring code
>   i2c: designware: Unify the firmware type checks
>   i2c: designware: Move exports to I2C_DW namespaces
>   i2c: designware: Remove ->disable() callback
>   i2c: designware: Consolidate PM ops
>   i2c: designware: Uninline i2c_dw_probe()
>   i2c: designware: Propagate firmware node
>   i2c: designware: Use pci_get_drvdata()
>   i2c: designware: Use temporary variable for struct device
>   i2c: designware: Get rid of redundant 'else'
>   i2c: designware: Fix spelling and other issues in the comments
> 
>  drivers/i2c/busses/i2c-designware-amdpsp.c  |  10 +-
>  drivers/i2c/busses/i2c-designware-common.c  | 167 +++++++++-
>  drivers/i2c/busses/i2c-designware-core.h    |  47 +--
>  drivers/i2c/busses/i2c-designware-master.c  |  19 +-
>  drivers/i2c/busses/i2c-designware-pcidrv.c  | 114 ++-----
>  drivers/i2c/busses/i2c-designware-platdrv.c | 337 +++++++-------------
>  drivers/i2c/busses/i2c-designware-slave.c   |  12 +-
>  7 files changed, 337 insertions(+), 369 deletions(-)
> 
> -- 
> 2.43.0.rc1.1.gbec44491f096
> 
> 
