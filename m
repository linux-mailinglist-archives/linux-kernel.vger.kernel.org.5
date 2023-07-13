Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B3C7529EA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjGMRgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 13:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjGMRgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 13:36:00 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3973F2723;
        Thu, 13 Jul 2023 10:35:55 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-986d8332f50so141956866b.0;
        Thu, 13 Jul 2023 10:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689269753; x=1691861753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XG/k/cRtJtXp+BY1mTTrU8F/8twPnwgKPwg/xoLbVKM=;
        b=evZSon4l1w3MFy/kCvyyEqoToXQToZRIyQSE9MND+5jNfHLI1TOCN+fjMOdMWOA+eS
         SzG6Y6kTOYR4Z/Krhkc6fJHoZayn+73DK3FCT9ATfk7bRASMH1TfvrUsJs60UlE/aYfP
         qeEoeRn4twXlBqmEjfP74nuKcGUY9y7qtuT0vLISYCbtAsSQbbnOeRROTUlWHHPkkC+M
         fH3JbQ6FuK8MZVAWkbkJrk/54EUGSnvXAtPfK5f7bh/aMvWrU5ott8xJPk29+ahNZ7uh
         NVqogluvhA43Bj6BaNjawBGZs9zKBlK5fduPGsjcO3yyuB3MFukoncPmBtWdHzCqP5p7
         njsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689269753; x=1691861753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XG/k/cRtJtXp+BY1mTTrU8F/8twPnwgKPwg/xoLbVKM=;
        b=aQoXX4n+4iq51i1tk2Bez8ubQ5isIrVIzw7L3AVTeVTKNQFNOY4CvzCre20i11j6RA
         o95ULQYvDLRE/J5cBgHy7Hmd9B4vmOydlaHCW0GXGAWNzPCMycl1TzTBz55k57P7aCl7
         Z965RkJ9UkYyff96Aif3uCmmMMUX/ifvsEXVFqBl6g86PdY8IE7MgMIoq9f0ziJdplwa
         INxEFfPAsF5gbNdtvCG+dWXfqk6yXkTVdP9vKfDVgYLznH9q+FLYEpWhJ43ZSMSAmvvI
         NnYAnEISeHUI3/IvHnjK/LeENGR+QHtojzm1iDas/QHU6E3FAxmp10FO//m88/xFGWeJ
         rbCw==
X-Gm-Message-State: ABy/qLYkTMfGtPCEr4z3LCtTpgwSJmutL3eA8r2D1uVWq+P2JSx03+CU
        BU9sfsAgcfYdqwusSYE8a62brDHR0A8=
X-Google-Smtp-Source: APBJJlEoVwCZyYqw2lRcbmkrycs1KkdtU2F3uyCceyq6KuekHGCkgPRN1+ZfVY/y4X2+tmz583Jdbw==
X-Received: by 2002:a17:906:8474:b0:993:d589:8b70 with SMTP id hx20-20020a170906847400b00993d5898b70mr2158652ejc.10.1689269753041;
        Thu, 13 Jul 2023 10:35:53 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709061dcb00b00986211f35bdsm4204682ejh.80.2023.07.13.10.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:35:52 -0700 (PDT)
From:   Your Name <namcaov@gmail.com>
X-Google-Original-From: Your Name <my.email@gmail.com>
Date:   Thu, 13 Jul 2023 19:35:51 +0200
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        syzbot+cf71097ffb6755df8251@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] staging: 7811: Fix memory leak in _r8712_init_xmit_priv
Message-ID: <ZLA1942ebuVcUT3h@nam-dell>
References: <20230712205733.29794-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712205733.29794-1-Larry.Finger@lwfinger.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 03:57:32PM -0500, Larry Finger wrote:
> In the above mentioned routine, memory is allocated in several places.
> If the first succeeds and a later one fails, the routine will leak memory.
> Fixes commit 2865d42c78a9 ("staging: r8712u: Add the new driver to the
> mainline kernel").
> 
> Fixes: 2865d42c78a9 ("staging: r8712u: Add the new driver to the mainline kernel")
> Reported-by: syzbot+cf71097ffb6755df8251@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
>  drivers/staging/rtl8712/rtl871x_xmit.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
> index 090345bad223..16b815588b97 100644
> --- a/drivers/staging/rtl8712/rtl871x_xmit.c
> +++ b/drivers/staging/rtl8712/rtl871x_xmit.c
> @@ -117,11 +117,8 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
>  	_init_queue(&pxmitpriv->pending_xmitbuf_queue);
>  	pxmitpriv->pallocated_xmitbuf =
>  		kmalloc(NR_XMITBUFF * sizeof(struct xmit_buf) + 4, GFP_ATOMIC);
> -	if (!pxmitpriv->pallocated_xmitbuf) {
> -		kfree(pxmitpriv->pallocated_frame_buf);
> -		pxmitpriv->pallocated_frame_buf = NULL;
> -		return -ENOMEM;
> -	}
> +	if (!pxmitpriv->pallocated_xmitbuf)
> +		goto clean_up_frame_buf;
>  	pxmitpriv->pxmitbuf = pxmitpriv->pallocated_xmitbuf + 4 -
>  			      ((addr_t)(pxmitpriv->pallocated_xmitbuf) & 3);
>  	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
> @@ -130,12 +127,12 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
>  		pxmitbuf->pallocated_buf =
>  			kmalloc(MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ, GFP_ATOMIC);
>  		if (!pxmitbuf->pallocated_buf)
> -			return -ENOMEM;
> +			goto clean_up_xmit_buf;
>  		pxmitbuf->pbuf = pxmitbuf->pallocated_buf + XMITBUF_ALIGN_SZ -
>  				 ((addr_t) (pxmitbuf->pallocated_buf) &
>  				 (XMITBUF_ALIGN_SZ - 1));
>  		if (r8712_xmit_resource_alloc(padapter, pxmitbuf))
> -			return -ENOMEM;
> +			goto clean_up_xmit_buf;
>  		list_add_tail(&pxmitbuf->list,
>  				 &(pxmitpriv->free_xmitbuf_queue.queue));
>  		pxmitbuf++;
> @@ -146,6 +143,14 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
>  	init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
>  	tasklet_setup(&pxmitpriv->xmit_tasklet, r8712_xmit_bh);
>  	return 0;
> +
> +clean_up_xmit_buf:
> +	kfree(pxmitbuf->pallocated_xmitbuf);
> +	pxmitbuf->pallocated_buf = NULL;

The allocation was done in a loop. Shouldn't memory from previous loop iterations
also be freed? And allocation by r8712_xmit_resource_alloc() should be freed too.

Best regards,
Nam
