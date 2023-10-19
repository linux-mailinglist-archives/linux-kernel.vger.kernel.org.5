Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831657CED8B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjJSBWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJSBWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:22:18 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09398122
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 18:22:17 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b20a48522fso5021714b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 18:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697678536; x=1698283336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9n/QH+xbBrrvxUjfEmKhMirsI/te5jWZt1YAktGhyic=;
        b=RMS9RXfpZBrDw1yQNo2zlTc605YBxEZufqMqx8YMBKY03h31xXYbqZ0pq6neufVJFT
         CpA6MDAV7lFWMa2Y7YW905CpWrwNPfkj0ElWqs1zuPWbTDhTI1lPMNfJ5RlOVUPrXnIT
         Vb4d3lE16NXGzRAsY99v1wm4Lk8zt8CZgrvAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697678536; x=1698283336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9n/QH+xbBrrvxUjfEmKhMirsI/te5jWZt1YAktGhyic=;
        b=gdM89wFdmFSdYZfViDdBvqIlTa4Q5KDN49Pq8gt5JzUYGLIXq9U2uz9giebreSS4sD
         IsGbNAXHPxcmAg5DVyU/0FuRke60LTgzLdLqYc8LgKHpz4/wcSKH2h92qKbMEp1gBsfj
         QKjxUT5f82N/QkEY57G/0g0kTBjUXvyR1yRJd/nvayjrloJPAL2qVU+N6yKeEzraRfYE
         LVdx4Gw6OMQiUw9Na2qSW7cO/XeJrJoUXKFBe2JlHK8hl5X9Gjp1A8bjA+ZGQj6lACBW
         Z8MMlB4uVgAsDsEjrLy8kpgNATiX7OcMpB2W6F6TtJ07F/joLCiUQf4vcMRljYe50Rj6
         85xQ==
X-Gm-Message-State: AOJu0Yyy9Sw81pogqOQbk1Rv5aWnWt2SWLcIaca1uPPDJCJ8CBDcw7EU
        lf1IkUB7kKgMnzO6F4PgFzjhgQ==
X-Google-Smtp-Source: AGHT+IF7kVoDgCvAMAX61ZZHq2qj+2bRQzcvEeWrGaJGweRi1y5xM61ycUSkxB4x6/u047Ivm+nWwg==
X-Received: by 2002:a05:6a00:3a09:b0:6bd:705b:56fb with SMTP id fj9-20020a056a003a0900b006bd705b56fbmr622425pfb.6.1697678536382;
        Wed, 18 Oct 2023 18:22:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f186-20020a6251c3000000b00692754580f0sm4107595pfb.187.2023.10.18.18.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 18:22:15 -0700 (PDT)
Date:   Wed, 18 Oct 2023 18:22:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: iwlwifi: fw: replace deprecated strncpy with
 strscpy
Message-ID: <202310181821.16FDE58565@keescook>
References: <20231017-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v1-1-bf69ec7d1b97@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v1-1-bf69ec7d1b97@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 09:58:44PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Based on the deliberate `sizeof(dest) ... - 1` pattern we can see that
> both dump_info->dev_human_readable and dump_info->bus_human_readable are
> intended to be NUL-terminated.
> 
> Neither of these symbols seem to be actually used after being assigned.
> Which means our replacement doesn't really matter. At any rate, it would
> seem NUL-padding is not required so let's use `strscpy` [2] due to the
> fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding. (but maybe these should be
> used or removed).

This appears to be crossing the file boundary. I would be more
comfortable seeing strscpy_pad() used here just to make sure there is no
behavior change at all.

-Kees

> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
> index 3ab6a68f1e9f..5455f8d1aab0 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
> @@ -880,10 +880,10 @@ iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
>  			cpu_to_le32(fwrt->trans->hw_rev_step);
>  		memcpy(dump_info->fw_human_readable, fwrt->fw->human_readable,
>  		       sizeof(dump_info->fw_human_readable));
> -		strncpy(dump_info->dev_human_readable, fwrt->trans->name,
> -			sizeof(dump_info->dev_human_readable) - 1);
> -		strncpy(dump_info->bus_human_readable, fwrt->dev->bus->name,
> -			sizeof(dump_info->bus_human_readable) - 1);
> +		strscpy(dump_info->dev_human_readable, fwrt->trans->name,
> +			sizeof(dump_info->dev_human_readable));
> +		strscpy(dump_info->bus_human_readable, fwrt->dev->bus->name,
> +			sizeof(dump_info->bus_human_readable));
>  		dump_info->num_of_lmacs = fwrt->smem_cfg.num_lmacs;
>  		dump_info->lmac_err_id[0] =
>  			cpu_to_le32(fwrt->dump.lmac_err_id[0]);
> 
> ---
> base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
> change-id: 20231017-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-1f49f00b8a2e
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

-- 
Kees Cook
