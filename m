Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153997D1C57
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjJUKBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 06:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjJUKBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:01:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609E11A4;
        Sat, 21 Oct 2023 03:01:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2094C433C8;
        Sat, 21 Oct 2023 10:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697882492;
        bh=3zCgKmJdi98hP9QQIfd4H55ELJbSnTf8HD6FTfiv8Gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h8ILdv1xC+/c1UTQ76hervPgmqNVMKWX4Y1SckCY0sU+yPerY622eXEh5sr/07KxP
         7KTjkMSqtlB3+cs0GxDuUvRGi2frDN7BX0cwCHzIRPuLcpd5dGv+Pd7ydJvPDhLVBP
         xBF2rFo/2wXRDSmEp+/vLY0Kp5D0YzDzcmfQk+Jo=
Date:   Sat, 21 Oct 2023 12:01:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     outreachy@lists.linux.dev, julia.lawall@inria.fr,
        dan.carpenter@linaro.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: sm750fb: Remove unused return value in
 display_control_adjust_sm750le()
Message-ID: <2023102113-barbell-amazingly-cef6@gregkh>
References: <20231019101348.22076-1-anonolitunya@gmail.com>
 <20231019101348.22076-2-anonolitunya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019101348.22076-2-anonolitunya@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 01:13:36PM +0300, Dorcas AnonoLitunya wrote:
> Modifies the return type of display_control_adjust_sm750le()
> to void from unsigned long as the return value is being ignored in
> all subsequent function calls.
> 
> This improves code readability and maintainability.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_mode.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

This patch doesn't apply against my latest branch.  Please rebase it and
resend.

thanks,

greg k-h
