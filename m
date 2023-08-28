Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3F278B51F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjH1QKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjH1QKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:10:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CD811A;
        Mon, 28 Aug 2023 09:10:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 228056102E;
        Mon, 28 Aug 2023 16:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0D6C433C8;
        Mon, 28 Aug 2023 16:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693239000;
        bh=ourgvljZVpiT9tfwtdLrBJP0YReykf036bBNIlqMv48=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AxUgdRsrCPlLX9dL67bnAyN6pSAV+In27aAq1A4OMpYR3DMEBJoigrBhGLPHCmzZU
         Iq26sGgrS5bRmA4vskVozzVWQYYA3cX12Gk/zKjXkpxN8urJMLjYaI/PcAFQqFnBjF
         DkJWfyuqOopir1HDyyAI0qO2hAVpmGhIMSLq2+AH/AV61TzHB/Sd5d2sHkUfU1wcpD
         a8pTuPzn0KMspAJ6LRKCYaeYxkd8FtTodyss04aHVQrobeBYn3P+z4yVdDs9jiyzNx
         Lue/RQ6iDXD10Cuj3u3Xaqm880NOVpJMbkBGU1lba7VDQfUbp5SUraenyEY02w1U8z
         thiTkx8UoELVw==
Date:   Mon, 28 Aug 2023 17:10:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Philipp Jungkamp <p.jungkamp@gmx.net>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/3] types: Complement the aligned types with signed
 64-bit one
Message-ID: <20230828171018.2ee59df7@jic23-huawei>
In-Reply-To: <20230815154027.12468-1-andriy.shevchenko@linux.intel.com>
References: <20230815154027.12468-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 18:40:25 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Some user may want to use aligned signed 64-bit type.
> Provide it for them.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Excellent.  I'll pick this up once the minor things in the first two
users are resolved (as long as no one argues we shouldn't have this
for some reason!)

Jonathan

> ---
>  include/linux/types.h      | 3 ++-
>  include/uapi/linux/types.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/types.h b/include/linux/types.h
> index 253168bb3fe1..78d87c751ff5 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -115,8 +115,9 @@ typedef u64			u_int64_t;
>  typedef s64			int64_t;
>  #endif
>  
> -/* this is a special 64bit data type that is 8-byte aligned */
> +/* These are the special 64-bit data types that are 8-byte aligned */
>  #define aligned_u64		__aligned_u64
> +#define aligned_s64		__aligned_s64
>  #define aligned_be64		__aligned_be64
>  #define aligned_le64		__aligned_le64
>  
> diff --git a/include/uapi/linux/types.h b/include/uapi/linux/types.h
> index 6375a0684052..48b933938877 100644
> --- a/include/uapi/linux/types.h
> +++ b/include/uapi/linux/types.h
> @@ -53,6 +53,7 @@ typedef __u32 __bitwise __wsum;
>   * No conversions are necessary between 32-bit user-space and a 64-bit kernel.
>   */
>  #define __aligned_u64 __u64 __attribute__((aligned(8)))
> +#define __aligned_s64 __s64 __attribute__((aligned(8)))
>  #define __aligned_be64 __be64 __attribute__((aligned(8)))
>  #define __aligned_le64 __le64 __attribute__((aligned(8)))
>  

