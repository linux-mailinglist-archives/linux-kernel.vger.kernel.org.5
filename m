Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F66676CECF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjHBNdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjHBNdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:33:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D07726B5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:33:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so212474666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690983209; x=1691588009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d4AXvn8YAh0C3eFlVqEZKeUnnypm7aKvOJgR3PvgTGA=;
        b=PMPR2OWOMVbhB7/iiSHM4Zm2WiqJdOu7TG37zlceX7LhipuwHIHciCnTQpEmcFUMfW
         VLIaakb51MdzUszVvBPBLEcb0rKthfDDuKcVuDD+UfP9Czjrt+M7nLuhudk9LPHUP+ey
         Ot9SPlwdkGDGzLCJdFbbTS3iBT7VMg8EQEZfM4LKztcN5qkXlYYyadluo14RlMasGIQq
         d3oAtnACMz+wDZni2KvHQ++q8zDqDfAiUA2BaG6zAUif8nWE4K1h86OlQ5tnjuCE0TeR
         jfrii1pOdqMa6SU4IdvBRFYsSpspyNdpOnoaguTpVBEd7pycOYoeJernkXcqkoFWJJCY
         w2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690983209; x=1691588009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4AXvn8YAh0C3eFlVqEZKeUnnypm7aKvOJgR3PvgTGA=;
        b=Kgq+ZZXw9SFwmHnSM3dPpab8qNTi4PB8fxCvBafaBpOpzOHbXcbCIm8qaQI5r3LTWg
         Vg5ZNxr7ToBnvMHUMdKa39663p6oQzaJyq6S6lv0evtP4eRQxJbELVcQ773E4Sj33sVC
         I2RFqP94SkuyJpaI2GkzYnF1tNA2iG9uEnsoFY/kpzINOkEQENb7ufjxzSQKu8K9sTD8
         YiCaMROXW4RhCtcDTgXDkN3u95rmFr4KMHbThTX9/uniTQFbOyLdy01qoqs9qEAScs6J
         AR/5K++1G5lM3VBfdaK68mSNsEeud2tzajpJwy277PsTLrXCMg8xiLxZL76tIVnVTI0u
         Lp3g==
X-Gm-Message-State: ABy/qLYS2tyQ0dIuJOPlB4r5onKUq7LqND0Ry7LXQUv3y72wGycydFMk
        AgKISc/LwAO8ixQTJXXvOP3tVQ==
X-Google-Smtp-Source: APBJJlGP+hX7tMjiAFswQ9Pw2LkLP+0TiEZnObeXHHZBmTYyu7bCVqf8eUa83iyuMzZ4qKYYVua7uw==
X-Received: by 2002:a17:906:8455:b0:989:450:e565 with SMTP id e21-20020a170906845500b009890450e565mr6926524ejy.23.1690983209637;
        Wed, 02 Aug 2023 06:33:29 -0700 (PDT)
Received: from localhost (h3221.n1.ips.mtn.co.ug. [41.210.178.33])
        by smtp.gmail.com with ESMTPSA id t25-20020a1709066bd900b00977c7566ccbsm9024030ejs.164.2023.08.02.06.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 06:33:29 -0700 (PDT)
Date:   Wed, 2 Aug 2023 16:33:24 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Pavan Bobba <opensource206@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: replace camel case by small case
Message-ID: <f967a1d0-639c-4cab-8fa0-e04ccde4ed5f@kadam.mountain>
References: <ZMpZixfZ4WQgpzF1@ubuntu.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMpZixfZ4WQgpzF1@ubuntu.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 06:56:35PM +0530, Pavan Bobba wrote:
> Replace array name of camel case by small case. Issue found
> by checkpatch
> 
> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> ---
>  drivers/staging/vt6655/baseband.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
> index 0e135af8316b..8b913c64845c 100644
> --- a/drivers/staging/vt6655/baseband.c
> +++ b/drivers/staging/vt6655/baseband.c
> @@ -499,7 +499,7 @@ static const unsigned char by_vt3253_init_tab_rfmd[CB_VT3253_INIT_FOR_RFMD][2] =
>  };
>  
>  #define CB_VT3253B0_INIT_FOR_RFMD 256
> -static const unsigned char byVT3253B0_RFMD[CB_VT3253B0_INIT_FOR_RFMD][2] = {
> +static const unsigned char byvt3253b0_rfmd[CB_VT3253B0_INIT_FOR_RFMD][2] = {

The one before it is called something liek by_vt3253b0_rfmd.

I don't know what by_ or bb_ meant to the driver authors so I can't say
if that's a good name, but lets at least keep it consistent and put an
underscore between by and vt, by_vt.

regards,
dan carpenter

