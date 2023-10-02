Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6267B5195
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbjJBLmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjJBLmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:42:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48634C6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:42:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40348C433C7;
        Mon,  2 Oct 2023 11:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696246924;
        bh=d8FcFb3yWGd/9wtt0mcVGwPft2o/vm/EglUHKzdkfgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sPG0RdMpsRSEdUD24LYEMhEURsA7sqlGX29fJ5XEfM0gmq3NlvgvkoV7tHor+LC0x
         uWR04f5dKQExuM5HEQ8X5EPbFKBAW20JvqzSgDBiJ/Ig8a1xMp3Y6jXJhmXXKIzutf
         iWGdjOIB2dSKGH3qUVJmpIaSboNgAp0rqLbeEFmA=
Date:   Mon, 2 Oct 2023 13:42:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] usb: Annotate struct urb_priv with __counted_by
Message-ID: <2023100246-stem-overcoat-c4b8@gregkh>
References: <20230915195812.never.371-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915195812.never.371-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 12:58:16PM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct urb_priv.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mathias Nyman <mathias.nyman@intel.com>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/usb/host/ohci.h | 2 +-
>  drivers/usb/host/xhci.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Thanks for taking these changes through your tree, I was too slow...

greg k-h
