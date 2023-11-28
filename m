Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5980F7FC20F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346263AbjK1OiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344927AbjK1OiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:38:14 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EC61B5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:38:20 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-332ce50450dso3761646f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701182299; x=1701787099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FBxCcIpOBNw2rVRQeI3GzaJA3+Yb6g+9ZiNBDkpz2v8=;
        b=MoFa+Sd5/mFjOh5UeSbKrDq3IXpteaCuiTMNinWuHUhQgsLJYJEUI0kAZZtfqrAT8d
         wrMbaQpTcbv2WYcwISoW9xc5M0Ib4GHp6IO43N/9DOQ//lapH6w3gnxZsXRY1//Kr5E6
         SLR3TQwD5s1IBDaA4YgVA8Ck3NkpkS7NnDkAmDTZIWZ6Ms0UIuZ1D1ibBohRujLussVq
         5Ls/8vXIhdj6OrGdIn9lcJtqOEETmLCJzX1bL+ZOAhcLpX26D9AXgyKngw0grAv1pqB7
         aCszPUFENTF4k95kNhhv2PZJxOQ3G29cxtXvZazNpvzE4DZU7xWSIU0yCJ68mVZfBpDZ
         ULMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701182299; x=1701787099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBxCcIpOBNw2rVRQeI3GzaJA3+Yb6g+9ZiNBDkpz2v8=;
        b=BAviNdyxtynLOycZre9IgNwXlRWgsCnLf0USZXl2K7TdnNOpK7M22SW7iJ3s5OY6dS
         Z1S8FZf6TWbMfmjk/xWrvOrPCpXIgBuZ5JmbTfIXCzTAhVTzA2/Gd7smN58XBO4U9zIz
         80lfBrub+CzNC6CADvZhJZBgPeWnAx8ONMzuC/q/Pb6z4lqthkfizoreM6JEIpzpX2zn
         t4guFzpCqp4+hZzZjGA3slzkPptAYps59CQd7Z1ozDx6hZOR3I3dWLNbxSmHjusMVyby
         X0VJV3oD3sNcJPTEFhU/UKUudsQYwqo/IkTWFayo0zNyhe8xpzO4y9wPskj4jBFXe2MW
         mQGw==
X-Gm-Message-State: AOJu0YwbkVEbO3vU2pO56ktK1zOT05kDfIeMyP2Y1OFYeJRGFIPCS+sY
        +x+52xaagm/Hwhegj1jbXhWquA==
X-Google-Smtp-Source: AGHT+IF9bAcLKlN7/AdST/QuvsSb3Y3zS3/xlnTBjpa/nQ2qo7yQfKSPyQPJmPB0wzINEf4MurRLtQ==
X-Received: by 2002:a5d:4b88:0:b0:32f:7f6c:72a6 with SMTP id b8-20020a5d4b88000000b0032f7f6c72a6mr10867144wrt.16.1701182299389;
        Tue, 28 Nov 2023 06:38:19 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g10-20020a5d64ea000000b003330f9287a8sm1813034wri.51.2023.11.28.06.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:38:19 -0800 (PST)
Date:   Tue, 28 Nov 2023 17:38:15 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Gary Rookard <garyrookard@fastmail.org>
Cc:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] staging: rtl8192e: renamed variable nMcsRate
Message-ID: <eda46e85-7b79-4e47-8e53-82ddd52172d0@suswa.mountain>
References: <20231128142027.15617-1-garyrookard@fastmail.org>
 <20231128142027.15617-2-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128142027.15617-2-garyrookard@fastmail.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 09:20:25AM -0500, Gary Rookard wrote:
> v2: Renamed from CamelCase to Snake case the variable nMcsRate, and
> additionally removed the Hungarian notation of (n) that [v1] did not.
> nMcsRate -> mcs_rate
> 
> Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
> Driver/module rtl8192e compiles.
> 
> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
> ---
> v2: Removes Hungarian notation.
> v1: Renames from CamelCase only, Hungarian notation unremoved.
> 
>  drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index 00273d709f3c..4ed72936eb4a 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -103,7 +103,7 @@ void ht_update_default_setting(struct rtllib_device *ieee)
>  	ht_info->rx_reorder_pending_time = 30;
>  }
>  
> -static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 nMcsRate)
> +static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 mcs_rate)

In the caller, this variable is called mcsRate, which presumably
checkpatch also complains about.  Why not rename them both to the same
thing?

It's unclear what value adding the "mcs_" prefix has, but I guess it's
nice to have a consistent variable name to grep for.

regards,
dan carpenter

