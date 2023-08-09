Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD1C776679
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjHIR2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjHIR2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:28:45 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB771703
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 10:28:42 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-583d63ca1e9so1703527b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1691602122; x=1692206922;
        h=content-transfer-encoding:message-id:references:in-reply-to:subject
         :cc:to:from:date:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5GHkqllOrwa7dKjTHTMacksa/BCngUM75YVKngzb84=;
        b=e5LzrZn59/0i0VBuG6353Wmc/jFvdaVaQytmwbjSxYDCk34yEp8PDkhT2vGcnrcFnJ
         /b6ENtHApcz7MsGLKPoya22WAvN1w13LWZolIBeE2F7GqawZkdj00o8qBK2EDpu06hca
         N3EoRMrltIHmMZsx+Kvs+Us8njn5MwOXvvyBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691602122; x=1692206922;
        h=content-transfer-encoding:message-id:references:in-reply-to:subject
         :cc:to:from:date:mime-version:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w5GHkqllOrwa7dKjTHTMacksa/BCngUM75YVKngzb84=;
        b=lmj41cMF4XhXeu9rsWQjdAD1YgbWZ/3rM4vc3av/KMfUWEiSNWuFVcvs7BuXRqqgBC
         +/MpiSaLgO+IfAtMvPeCB2Jc8BRKvFTMbzCJo6MsKN4bX+p4uy9C4L2xEhgsVzWFnzLw
         nSHUvXk6dmchdlZVyyGxKCnYll1pbqoy7CI/j97v7sHflvNr55RhdXntd02GzKYdKAxl
         T7O+Tz5+LY4UjsCzY7NKLY7/hLTpt5fbm9x+4OuBWzkriOTNyfkie65zXMdgKO6qTQOO
         p5iMoCRNQ7xv6wZt9XJeLwUMBzEZvWZX3spDIeC4IrYZV1/+J5OxETB0Ix6lvRQobcCF
         dDWA==
X-Gm-Message-State: AOJu0Yy5f/RYnemiV389nfcO5oycbNvauuLdTTKtFyzK0Gn6GaNtDLJt
        PCwHnPWNX6boq0pHZ5/aXOYQKA==
X-Google-Smtp-Source: AGHT+IHnuIrs3PweL9xunsuqoCKY17H82lE7cx9iaHFpRDYegJH258vHKi0V/9LAgF/GQyHIiowhsw==
X-Received: by 2002:a81:9282:0:b0:585:5fbf:1bf1 with SMTP id j124-20020a819282000000b005855fbf1bf1mr3438208ywg.48.1691602121836;
        Wed, 09 Aug 2023 10:28:41 -0700 (PDT)
Received: from sunraycer.home ([2601:246:5d81:5e3b::100])
        by smtp.gmail.com with ESMTPSA id u123-20020a818481000000b00559f1cb8444sm4066142ywf.70.2023.08.09.10.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 10:28:41 -0700 (PDT)
Received: from 10.10.2.100 (sunraycer [10.10.2.100])
        by sunraycer.home (Postfix) with ESMTPSA id E94F55C406E;
        Wed,  9 Aug 2023 12:28:40 -0500 (CDT)
MIME-Version: 1.0
Date:   Wed, 09 Aug 2023 12:28:40 -0500
From:   steve <magnani@ieee.org>
To:     Steve Magnani <magnani@ieee.org>
Cc:     Quinn Tran <qutran@marvell.com>, linux-kernel@vger.kernel.org,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: Prevent firmware rejection of
 MBC_GET_RNID_PARAMS
In-Reply-To: <20230809141059.10790-1-magnani@ieee.org>
References: <20230809141059.10790-1-magnani@ieee.org>
Message-ID: <2f4214c089c0269786abe1695fe7adec@sunraycer.home>
X-Sender: steve@sunraycer.home
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please disregard. It looks like the original patch b68710a8094f reduced 
the amount of data copied off so much that port logins are broken even 
though with my patch the firmware now processes GET_RNID_PARAMS. The 
breakage has been introduced during 6.5 (and propagated into 5.x stable 
branches) so there is some urgency to getting a proper fix.

I will send a short series to revert b68710a8094f and replace it with 
what I think is the correct overrun fix. AFAICT the overrun is only a 
single dword.


--Steve


On 2023-08-09 09:10, Steve Magnani wrote:
> At least some firmware (for example, QLE2692 FW 8.08.231 (d0d5)) 
> returns
> MBS_COMMAND_PARAMETER_ERROR when 
> MBC_GET_RNID_PARAMS(RNID_TYPE_PORT_LOGIN)
> is issued with a transfer length of 4 (DWords). Correct the overrun fix 
> to
> issue a "normal" transfer length and instead limit copy-out of desired
> PLOGI data to the space available for it.
> 
> Fixes: b68710a8094f ("scsi: qla2xxx: Fix buffer overrun")
> Signed-off-by: "Steven J. Magnani" <magnani@ieee.org>
> ---
> --- a/drivers/scsi/qla2xxx/qla_init.c	2023-08-01 03:46:21.727114453 
> -0500
> +++ b/drivers/scsi/qla2xxx/qla_init.c	2023-08-08 23:18:46.475286995 
> -0500
> @@ -5549,7 +5549,8 @@ static void qla_get_login_template(scsi_
>  	__be32 *q;
> 
>  	memset(ha->init_cb, 0, ha->init_cb_size);
> -	sz = min_t(int, sizeof(struct fc_els_csp), ha->init_cb_size);
> +	/* At least some firmware requires sz > sizeof(fc_els_csp) */
> +	sz = min_t(int, sizeof(struct fc_els_flogi), ha->init_cb_size);
>  	rval = qla24xx_get_port_login_templ(vha, ha->init_cb_dma,
>  					    ha->init_cb, sz);
>  	if (rval != QLA_SUCCESS) {
> @@ -5560,6 +5561,7 @@ static void qla_get_login_template(scsi_
>  	q = (__be32 *)&ha->plogi_els_payld.fl_csp;
> 
>  	bp = (uint32_t *)ha->init_cb;
> +	sz = min_t(u32, sizeof(struct fc_els_csp), sz);
>  	cpu_to_be32_array(q, bp, sz / 4);
>  	ha->flags.plogi_template_valid = 1;
>  }
