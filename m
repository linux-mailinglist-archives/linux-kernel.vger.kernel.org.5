Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8186C75E497
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGWTpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGWTpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:45:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D0FC9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 12:45:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 698EC60E8A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 19:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39C8C433C8;
        Sun, 23 Jul 2023 19:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690141547;
        bh=E0MG1si/sl+6UDSSBH0GcBCPvGA8eKy+Y3YTNpsx658=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PevdvpjbSIR6FdI7Me5YEOk3zolSqXmyWc4stlUCGJr8cjMaB8tldQE4FhPCsWDe9
         MPS+mRdbkFOxBFpUhKX1/Cf9tofW3q78+aWRmTf5rnAxrpcU4LCDLGr+q/fAem3JWN
         j8CeU8GUGQtcExCXYf0lZHIaKzDFYSxWwG7S46rcctDQGqOwzfPnRN300wQlO+2VGw
         Jl7zeWgDzgNo61lMCALMm/bkM2XETEHAGqJ9QwqMvWG6mJk5IrN0LAv6s1gCLZ3uE6
         vBof1xlFq2LCn+8M4caXE3d+FL5bb4n/uVlVMKfk9iAGFsrnr0r8T4bBho44Bc9ank
         hnSohXrOQx/7g==
Message-ID: <2a1a066d-28d4-fed7-8116-f775c2a6fd5f@kernel.org>
Date:   Mon, 24 Jul 2023 04:45:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] extcon: Remove unused inline functions
Content-Language: en-US
To:     YueHaibing <yuehaibing@huawei.com>, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-kernel@vger.kernel.org
References: <20230720143712.24812-1-yuehaibing@huawei.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20230720143712.24812-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 7. 20. 23:37, YueHaibing wrote:
> commit 830ae442202e ("extcon: Remove the deprecated extcon functions")
> left behind this.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/linux/extcon.h | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
> index 3c45c3846fe9..e596a0abcb27 100644
> --- a/include/linux/extcon.h
> +++ b/include/linux/extcon.h
> @@ -328,16 +328,4 @@ struct extcon_specific_cable_nb {
>         struct extcon_dev *edev;
>         unsigned long previous_value;
>  };
> -
> -static inline int extcon_register_interest(struct extcon_specific_cable_nb *obj,
> -				const char *extcon_name, const char *cable_name,
> -				struct notifier_block *nb)
> -{
> -	return -EINVAL;
> -}
> -
> -static inline int extcon_unregister_interest(struct extcon_specific_cable_nb *obj)
> -{
> -	return -EINVAL;
> -}
>  #endif /* __LINUX_EXTCON_H__ */

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

