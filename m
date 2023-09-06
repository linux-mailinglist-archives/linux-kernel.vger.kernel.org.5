Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E02F7942D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243866AbjIFSLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 14:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243769AbjIFSLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:11:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAD81997;
        Wed,  6 Sep 2023 11:10:46 -0700 (PDT)
Received: from [192.168.68.123] (unknown [177.134.102.128])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 10DE76606E9D;
        Wed,  6 Sep 2023 19:10:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694023845;
        bh=+BguOnFMoN0DTEiUJmqvKDEQH9cUWtAs2AUE4hzsEfs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XGr2l4DMSIi0YKMIThC5xNr6ONwfxb3OkfXw/vDpEqW2rrzxJGnMLFjhl2/tz69aw
         KG+fXoq0i8viL6lLfhtXmecqrFEOWTN/APQg+SvwQmDs3mH102RBt4to042tiRhOX9
         ZbviQDzTQqE91t5jmM6B2bZckV3AE0NcS6cGh/HHh9oHVWPCaQ5iP9YxQnnSgv2773
         lZMwTv0MHFSsq0RVooZcNvzp+GOGMbfOGMPzYJBpBnI8Exdq9f1ybq4VQmpWXcE2Kp
         ar1MXA5be30LqVbZ6Qrxwz9XF999wq4IyGV1qNj601na7BjhmPOTXHUmI/Vc7YJ+gZ
         UcfWh66AdcERg==
Message-ID: <5e44d344-dee0-027d-4766-01515e6ea155@collabora.com>
Date:   Wed, 6 Sep 2023 15:10:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] Remove the parameter not described warning
Content-Language: en-US
To:     Vinayak Hegde <vinayakph123@gmail.com>, sumit.semwal@linaro.org,
        gustavo@padovan.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org
References: <ZPiuH+ghqamtwJGA@vinayak-ubuntu>
From:   Helen Koike <helen.koike@collabora.com>
In-Reply-To: <ZPiuH+ghqamtwJGA@vinayak-ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinayak,

Thanks for you patch

On 06/09/2023 13:51, Vinayak Hegde wrote:
> I encountered a warning during kernel documentation compilation

Usually we write the commit message in imperative mood, please check: 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

> due to a missing colon in the documentation for the
> 'num_fences' variable in the sync_file.h header file.
> This change adds the missing colon to align with the documentation format.
> 
> Signed-off-by: Vinayak Hegde <vinayakph123@gmail.com>
> ---
>   include/uapi/linux/sync_file.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/sync_file.h b/include/uapi/linux/sync_file.h
> index 7e42a5b7558b..b389a5495181 100644
> --- a/include/uapi/linux/sync_file.h
> +++ b/include/uapi/linux/sync_file.h

Since you are modifying this file, if you run:
     git log --oneline include/uapi/linux/sync_file.h
you will notice that almost all changes start with "dma-buf/sync_file:" 
prefix, it would be nice to maintain the style pattern for the commit title.

Regards,
Helen

> @@ -56,7 +56,7 @@ struct sync_fence_info {
>    * @name:	name of fence
>    * @status:	status of fence. 1: signaled 0:active <0:error
>    * @flags:	sync_file_info flags
> - * @num_fences	number of fences in the sync_file
> + * @num_fences: number of fences in the sync_file
>    * @pad:	padding for 64-bit alignment, should always be zero
>    * @sync_fence_info: pointer to array of struct &sync_fence_info with all
>    *		 fences in the sync_file
