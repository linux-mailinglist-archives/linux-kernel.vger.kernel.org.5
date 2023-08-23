Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5040C7851E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbjHWHpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjHWHpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:45:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E641CE5F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:45:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76FFA651BA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE2DC433C7;
        Wed, 23 Aug 2023 07:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692776700;
        bh=Fx0FPACDZXSbXtney/v4smWbDcLrEcVygc6uYCB9xmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JRILnif71r4tPyGbEGyStZadyAPkiJdmqY8dzM1hbKydDOcDT7r5/VUmM8zLgCWFv
         g0NjRTluZHcrxTaqxfaEHPHKjEGBUmNFeSGoYlPEr0X4a1fGYyD6m4bvMfHJPSYoA1
         v8yO/Rs5g4F9P9iAce3GZwtB3/qDxfI02jj+n0RaqzV65fIWTbLn/oN8cJXbBUVitI
         i5ro3fR+BiRPO66nSSDfMn5B+DXhvK0x0HyMmFm6BOD6sOxgXvEyo4uQ2e84gJoNme
         CzTkB+c0XiuTOzo772LoELsrjIh+qUjNayK73gOld5h+o7grB+EFdwme1t2SSZY54B
         ySxhk9ysOp2Lw==
Received: from johan by theta with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qYiXw-00088f-0z;
        Wed, 23 Aug 2023 09:44:56 +0200
Date:   Wed, 23 Aug 2023 09:44:56 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] greybus: svc: Remove unused declarations
Message-ID: <ZOW4-OycWzNXdZDq@hovoldconsulting.com>
References: <20230818124338.37880-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818124338.37880-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 08:43:38PM +0800, Yue Haibing wrote:
> Commit 84427943d2da ("greybus: svc: drop legacy-protocol dependency")
> removed these implementations but not the declarations.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/linux/greybus/svc.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/greybus/svc.h b/include/linux/greybus/svc.h
> index 5afaf5f06856..da547fb9071b 100644
> --- a/include/linux/greybus/svc.h
> +++ b/include/linux/greybus/svc.h
> @@ -100,7 +100,4 @@ bool gb_svc_watchdog_enabled(struct gb_svc *svc);
>  int gb_svc_watchdog_enable(struct gb_svc *svc);
>  int gb_svc_watchdog_disable(struct gb_svc *svc);
>  
> -int gb_svc_protocol_init(void);
> -void gb_svc_protocol_exit(void);
> -
>  #endif /* __SVC_H */

Yup, these are long gone:

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
