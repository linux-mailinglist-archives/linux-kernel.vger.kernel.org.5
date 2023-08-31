Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE2A78ECCB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345358AbjHaMKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjHaMKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:10:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12402E42
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:10:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rc0NR0kHmz4wb5;
        Thu, 31 Aug 2023 22:10:15 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Rob Herring <robh@kernel.org>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20230829225837.15520-1-rdunlap@infradead.org>
References: <20230829225837.15520-1-rdunlap@infradead.org>
Subject: Re: [PATCH] macintosh/ams: linux/platform_device.h is needed
Message-Id: <169348378762.53003.9449787448140786027.b4-ty@ellerman.id.au>
Date:   Thu, 31 Aug 2023 22:09:47 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 15:58:37 -0700, Randy Dunlap wrote:
> ams.h uses struct platform_device, so the header should be used
> to prevent build errors:
> 
> drivers/macintosh/ams/ams-input.c: In function 'ams_input_enable':
> drivers/macintosh/ams/ams-input.c:68:45: error: invalid use of undefined type 'struct platform_device'
>    68 |         input->dev.parent = &ams_info.of_dev->dev;
> drivers/macintosh/ams/ams-input.c: In function 'ams_input_init':
> drivers/macintosh/ams/ams-input.c:146:51: error: invalid use of undefined type 'struct platform_device'
>   146 |         return device_create_file(&ams_info.of_dev->dev, &dev_attr_joystick);
> drivers/macintosh/ams/ams-input.c: In function 'ams_input_exit':
> drivers/macintosh/ams/ams-input.c:151:44: error: invalid use of undefined type 'struct platform_device'
>   151 |         device_remove_file(&ams_info.of_dev->dev, &dev_attr_joystick);
> drivers/macintosh/ams/ams-input.c: In function 'ams_input_init':
> drivers/macintosh/ams/ams-input.c:147:1: error: control reaches end of non-void function [-Werror=return-type]
>   147 | }
> 
> [...]

Applied to powerpc/next.

[1/1] macintosh/ams: linux/platform_device.h is needed
      https://git.kernel.org/powerpc/c/85a616416e9e01db0bfa92f26457e92642e2236b

cheers
