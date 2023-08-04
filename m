Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F667702F1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjHDO0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjHDO0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:26:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE5CCC;
        Fri,  4 Aug 2023 07:26:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40FA162047;
        Fri,  4 Aug 2023 14:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22842C433C7;
        Fri,  4 Aug 2023 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691159175;
        bh=ZmMYzvs6Ht0eY0s9Zw/JeOzxklPn2j5olcDBFxFeL8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nVGL7INSiPNbYfDh/iFghFDVnhKThmEUqj0lDEKbpdIMJqelVg1+2A/kLcml8EQS7
         ZdbH3Pr8rZXdaVz3+iIBLzhHtFscXWjmOD5rGLpqUU+uSFX3XZxoKHhrjt01qYMgUz
         Lhtkm1QJhx2qqbsIxGwZfadui2iCteqVm0THDuHw=
Date:   Fri, 4 Aug 2023 16:26:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] of: Move of_platform_register_reconfig_notifier()
 into DT core
Message-ID: <2023080401-bonsai-macarena-4b74@gregkh>
References: <20230717143718.1715773-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717143718.1715773-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 08:37:16AM -0600, Rob Herring wrote:
> There's no reason the generic platform bus code needs to call
> of_platform_register_reconfig_notifier(). The notifier can be setup
> before the platform bus is. Let's move it into of_core_init() which is
> called just before platform_bus_init() instead to keep more of the DT
> bits in the DT code.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/base/platform.c     | 2 +-
>  drivers/of/base.c           | 1 +
>  drivers/of/of_private.h     | 6 ++++++
>  drivers/of/platform.c       | 2 ++
>  include/linux/of_platform.h | 6 ------
>  5 files changed, 10 insertions(+), 7 deletions(-)
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
