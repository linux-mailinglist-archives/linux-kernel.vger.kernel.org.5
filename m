Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6FC75E4D6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 22:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjGWUam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 16:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGWUaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 16:30:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A811B8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 13:30:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B763760E88
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 20:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE38CC433C7;
        Sun, 23 Jul 2023 20:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690144238;
        bh=7+A6c39gdcE1g7Jj1te99cUCcE8RirIo32OTAJBLi8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SJrIGJv1CAoSzbTHPOQKckC86Lk6uMepycf5I6FF58MiBTFTAIDi+U0i0orJpmC58
         U5F4q5Buf8WybYBJbVN5jHYO6Sk9+bniYfmzohIn53Iv/zHNmpbgIoOJAjFf+as3Ih
         R8TCpa6BkfAEADQmNDf6enNim1lZQs9SiVmmYqIVig3FSsroQ+o5SGlVZPghtaSC2j
         bu9UiO2pBU+MfQQiNnzYrpIc3oh+zxGtfZOOcQr2341xgBglqZIsWDuD1UiNSr4Fb6
         VnH2XvL8FG1TCpvtyzqUj8bDuZCgbAsvK9P4eyitLiW5SpCL0JkIILrQpbB8JuUL3n
         7d6I/sjgz8ZZA==
Date:   Sun, 23 Jul 2023 22:30:35 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] driver core: Move dev_err_probe() to where it
 belogs
Message-ID: <20230723203035.wmdskibs2lvofnju@intel.intel>
References: <20230721131309.16821-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721131309.16821-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Fri, Jul 21, 2023 at 04:13:09PM +0300, Andy Shevchenko wrote:
> dev_err_probe() belongs to the printing API, hence
> move the definition from device.h to dev_printk.h.
> 
> There is no change to the callers at all, since:
> 1) implementation is located in the same core.c;
> 2) dev_printk.h is guaranteed to be included by device.h.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

yes! I think that's right!

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Andi
