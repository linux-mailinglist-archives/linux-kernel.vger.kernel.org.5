Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C757C455A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjJJXQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJJXQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:16:51 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BC89E;
        Tue, 10 Oct 2023 16:16:47 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1c434c33ec0so39351375ad.3;
        Tue, 10 Oct 2023 16:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696979807; x=1697584607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKx4zNE5WFIDI3mPQVAL8l752XPWDKdWcVAjVY3hphA=;
        b=OYY6pPOXQBtkhYDyogrew8cb2VU2D2hAXtok8JThPCO3pfUVRtQGeh+ojHrliVSymr
         ixUbcCVRYcvPylmWhsE7e1VwrVCz1gjaywciQq9Q7aJy+31D+DHcARTVsLUh9Jahr7oc
         Iz24LTxP4GZ1c/+KcGTabR/ZvV4ORIdqFJ0Sy4PHJpsmlKcxZguqY+nSS3sJ9XZw/WOP
         aiaUO+9mMApK4jPNlFUy5ybKaawsUXlgi7jKDO+MXH7cUF+c0wo54Dz3w6/rK+ZN64G/
         94EcQioXYM9SDuBzAzqGOuNanxQFthaVei6Lsn+4YByifbTwmorkwQBQ93NflE0Cwcjg
         wAmg==
X-Gm-Message-State: AOJu0Yypt6hQsNEOkUKWA3XtSul1CdR/r2iNYW42JfVseCM+0/qUna9G
        MoGZ2L3mxC/nayqG9winZS0=
X-Google-Smtp-Source: AGHT+IFmfyNumTvFJur1V+yc22XZRJd/mml48UJnnyjCVEYZNqHpwhjAF4XnuejM2cZs+ipgo1eg4Q==
X-Received: by 2002:a17:903:2310:b0:1c7:755d:ccc8 with SMTP id d16-20020a170903231000b001c7755dccc8mr20504201plh.29.1696979807312;
        Tue, 10 Oct 2023 16:16:47 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id f7-20020a17090274c700b001c59f23a3fesm12339823plt.251.2023.10.10.16.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 16:16:46 -0700 (PDT)
Date:   Tue, 10 Oct 2023 23:16:45 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Angelina Vu <angelinavu@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com
Subject: Re: [PATCH] hv_balloon: Add module parameter to configure balloon
 floor value
Message-ID: <ZSXbXbiR6d5nzAe3@liuwe-devbox-debian-v2>
References: <1696978087-4421-1-git-send-email-angelinavu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696978087-4421-1-git-send-email-angelinavu@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelina,

On Tue, Oct 10, 2023 at 03:48:07PM -0700, Angelina Vu wrote:
> Currently, the balloon floor value is automatically computed, but may be
> too small depending on app usage of memory. This patch adds a balloon_floor
> value as a module parameter that can be used to manually configure the
> balloon floor value.
> 
> Signed-off-by: Angelina Vu <angelinavu@linux.microsoft.com>

Out of interest, will there be a case that the balloon floor value is
misconfigured, hence too small?

Why isn't the larger of the two values (computed and manually set)
returned instead?

Thanks,
Wei.

> ---
>  drivers/hv/hv_balloon.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 64ac5bdee3a6..87b312f99b2e 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1101,6 +1101,10 @@ static void process_info(struct hv_dynmem_device *dm, struct dm_info_msg *msg)
>  	}
>  }
>  
> +unsigned long balloon_floor;
> +module_param(balloon_floor, ulong, 0644);
> +MODULE_PARM_DESC(balloon_floor, "Memory level (in megabytes) that ballooning will not remove");
> +
>  static unsigned long compute_balloon_floor(void)
>  {
>  	unsigned long min_pages;
> @@ -1117,6 +1121,9 @@ static unsigned long compute_balloon_floor(void)
>  	 *    8192       744    (1/16)
>  	 *   32768      1512	(1/32)
>  	 */
> +	if (balloon_floor)
> +		return MB2PAGES(balloon_floor);
> +
>  	if (nr_pages < MB2PAGES(128))
>  		min_pages = MB2PAGES(8) + (nr_pages >> 1);
>  	else if (nr_pages < MB2PAGES(512))
> -- 
> 2.34.1
> 
> 
