Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B8578445A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbjHVOcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbjHVOcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:32:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68EA1BE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:32:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 441C462D4D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E96C433C8;
        Tue, 22 Aug 2023 14:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692714748;
        bh=EM9dUTqY0ids7+xie3FqnEpTZ2/WW77WHF1TTpHX1OU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fp014mT0BHy/W6TdZQ3ksrSxxV2gR1PvkCoLJ1d6MbBfjLWkOTscNXBck4GqecVku
         flb362LY1ETdzc5UMrULOvqQ+DbOFaJaXa/YmBzLedCvVDyG0zYdiYZ2aLoysit67U
         Sk/ipo3dT7e6jZhXBK/WKTSCB6BlHjom/YEXHlew=
Date:   Tue, 22 Aug 2023 16:32:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] greybus: svc: Remove unused declarations
Message-ID: <2023082220-washbowl-shed-6be9@gregkh>
References: <20230818124338.37880-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818124338.37880-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
> -- 
> 2.34.1
> 

Nice, how did you find these?
