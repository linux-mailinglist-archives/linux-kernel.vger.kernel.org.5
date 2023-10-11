Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90927C45CA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 02:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344249AbjJKAB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 20:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344204AbjJKABZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 20:01:25 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADFE8F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 17:01:24 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-578b407045bso5027941a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 17:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696982483; x=1697587283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zXwHFTTSHqHksZHyWZ3bFkL07EMOlYzNsZg2rCsLLcM=;
        b=C7d/yRC5Raip0nMfFJljMYPZuVOwrxYCRUe4z9sSsoYFSsYqcS2kS0sUXwh5r8TxEU
         LQnikAzpaJOvdDZDRbVIeUFUS8fZSlviJTGP/SJnQKoAkLUysfm/xq9HTYN1Inai9hNA
         9oHroh9cjqDL0M3UEJNqIxP+fOMIkbxuH1kcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696982483; x=1697587283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXwHFTTSHqHksZHyWZ3bFkL07EMOlYzNsZg2rCsLLcM=;
        b=JVNSTqQ6PvTim9MD7dmzJ4WsZ+ST0CnjXrTgBQCnKvv7dectj9VyRfSXVmSPbC3l9X
         DtswaDcEAGWhAgvHBKjGHegbTjgMvmnpUyXhVGIkqnP/EgXnkAGvhnWjrKlZhQN4K5/k
         M6HlBw2TaqboIZHreNyteLHNxEEzwug6Uia/Vs8og9UwiDa/ARrjX5xQuI/0L0bjMAlc
         JWEQ3MPd0MChdElJAOVBwmUqLrH1IM5mO0lgbCATgqVWZ8p7dPgwLrNqF+CaSznIFUDS
         nDgMZMsyl4NkwMG8VDXbRsjS0DKnmeJj+uIQ9DKFVsYZ097MT/j4dQYWucF94ZFnIjW2
         OgnQ==
X-Gm-Message-State: AOJu0Yz32lYkOHaXFfZD3h5VwY9Cfg389jja09wlKvOEpc9xVbfFT1MX
        D75soVZeqORcWhJTisRqK48Dpg==
X-Google-Smtp-Source: AGHT+IHvnF1NY14+x1atCUXgwzdFEk0ZaADVkWvm44vtZyO7tNcwIEv+y9XR2Sh6iJ6MxunGIbRJhw==
X-Received: by 2002:a05:6a20:2590:b0:151:577:32d1 with SMTP id k16-20020a056a20259000b00151057732d1mr23567638pzd.22.1696982483550;
        Tue, 10 Oct 2023 17:01:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902868c00b001c625acfed0sm12371984plo.44.2023.10.10.17.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 17:01:23 -0700 (PDT)
Date:   Tue, 10 Oct 2023 17:01:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] octeontx2-af: replace deprecated strncpy with strscpy
Message-ID: <202310101700.1BE3455BE6@keescook>
References: <20231010-strncpy-drivers-net-ethernet-marvell-octeontx2-af-cgx-c-v1-1-a443e18f9de8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010-strncpy-drivers-net-ethernet-marvell-octeontx2-af-cgx-c-v1-1-a443e18f9de8@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 09:38:11PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We can see that linfo->lmac_type is expected to be NUL-terminated based
> on the `... - 1`'s present in the current code. Presumably making room
> for a NUL-byte at the end of the buffer.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Let's also prefer the more idiomatic strscpy usage of (dest, src,
> sizeof(dest)) rather than (dest, src, SOME_LEN).
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> index e06f77ad6106..6c70c8498690 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> @@ -1218,8 +1218,6 @@ static inline void link_status_user_format(u64 lstat,
>  					   struct cgx_link_user_info *linfo,
>  					   struct cgx *cgx, u8 lmac_id)
>  {
> -	const char *lmac_string;
> -
>  	linfo->link_up = FIELD_GET(RESP_LINKSTAT_UP, lstat);
>  	linfo->full_duplex = FIELD_GET(RESP_LINKSTAT_FDUPLEX, lstat);
>  	linfo->speed = cgx_speed_mbps[FIELD_GET(RESP_LINKSTAT_SPEED, lstat)];
> @@ -1230,12 +1228,12 @@ static inline void link_status_user_format(u64 lstat,
>  	if (linfo->lmac_type_id >= LMAC_MODE_MAX) {
>  		dev_err(&cgx->pdev->dev, "Unknown lmac_type_id %d reported by firmware on cgx port%d:%d",
>  			linfo->lmac_type_id, cgx->cgx_id, lmac_id);
> -		strncpy(linfo->lmac_type, "Unknown", LMACTYPE_STR_LEN - 1);
> +		strscpy(linfo->lmac_type, "Unknown", sizeof(linfo->lmac_type));
>  		return;
>  	}
>  
> -	lmac_string = cgx_lmactype_string[linfo->lmac_type_id];
> -	strncpy(linfo->lmac_type, lmac_string, LMACTYPE_STR_LEN - 1);
> +	strscpy(linfo->lmac_type, cgx_lmactype_string[linfo->lmac_type_id],
> +		sizeof(linfo->lmac_type));

Yup, sizes match. Good replacement and simplification.

drivers/net/ethernet/marvell/octeontx2/af/mbox.h:565:#define LMACTYPE_STR_LEN 16
drivers/net/ethernet/marvell/octeontx2/af/mbox.h:566:   char lmac_type[LMACTYPE_STR_LEN];

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
