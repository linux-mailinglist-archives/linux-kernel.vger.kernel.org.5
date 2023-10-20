Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0841B7D133D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377823AbjJTPzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377824AbjJTPzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:55:45 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8021112
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:55:39 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507bd644a96so1395809e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697817338; x=1698422138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U6kzOgo9KLgnzG1tBcKH3CK3w1Ak8u2S5mlzy6a00p8=;
        b=IgRjW4R+Md9eLeHioWeQ/m5ikyTTIA2uzr3R5piAw87QweXMC+HASeXhplxfwouP5p
         ZUlEtdruRDqulS1ugPDNV6O2J3GEEXU5LOSR5wMThPO6jKKY+2j5II7MLqXbVcqRF6Pe
         c1x2kR0Ds0OE4V+Hx/zXNn6XP0mWJPTp5Vx0Mw/KSEsMRKoPVyKKYrx1WhLcm7WmOurU
         GNsuDHDtSVCj+vPOPRfRxROM0M3+axZ7wZquqR2nSvkVP+zEj0u8FSoYQ/YCPQQklzsd
         fRS3KI8vzS/ACdRkzUF3VNpu4Reoaj+dZtOFu05irdsy9pbs3yHg4WN4Kkn+BssMw9Fp
         QqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697817338; x=1698422138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6kzOgo9KLgnzG1tBcKH3CK3w1Ak8u2S5mlzy6a00p8=;
        b=L6QppC6IB7N7ol3EYN66x26/ELs48ijntQOT+QS+Hy575rOGGVYS6TcWfJfzu9ZbZT
         faq1oE4R+yj4WzqpezkHOhjQwFvhf68aYZXlvAFJsGdHGJ3nSpKlKoFYck+jVCVmDLjR
         XEE4QabU/WusBkii6FS3/qRs2MgA+PlcAdq0LoBI6Y0NP2sEZ+X7d9fT5iKCTTt3xR6e
         3zHVXB3dp7vmglPSADetlvVuD1MFefjabAtP7e7fKZ7hZrH2nb/8SzWLiErMbCDEiuzI
         tO40F7v6IiCGxXrmWPuNHYyiPltpTtUxI96bzqYVTYhPAjguGqb7T8Ny3Yq4ZCwftFzj
         tkMw==
X-Gm-Message-State: AOJu0Yy4q3U3g+JuoqU2d9AnzT8NLAX64llS11QQCCQ/XTp3HQarE0wD
        hm5eOTzQrJHaJmbcZvQvAQit+Q==
X-Google-Smtp-Source: AGHT+IFpm3YF6F1pk+UdApdLVX+ULTxt+ZFtNP4MtvY8mHk6SL+aZm0RGmKhltAzr1WzPTmhZutzQQ==
X-Received: by 2002:a19:760d:0:b0:507:99fe:28f3 with SMTP id c13-20020a19760d000000b0050799fe28f3mr1587690lff.34.1697817337768;
        Fri, 20 Oct 2023 08:55:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u16-20020adff890000000b0032d8ce46caasm1944414wrp.93.2023.10.20.08.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 08:55:37 -0700 (PDT)
Date:   Fri, 20 Oct 2023 18:55:34 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Chen Shuo <1289151713@qq.com>
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: camera: fixes alignment should match
 open parenthesis
Message-ID: <de77b29e-fb65-407d-ab77-f4a2a77a8422@kadam.mountain>
References: <tencent_2E5278ECD059882823EF2A5209D98B53E306@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_2E5278ECD059882823EF2A5209D98B53E306@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 11:12:03PM +0800, Chen Shuo wrote:
> This patch fixes the checks reported by checkpatch.pl
> for alignment should match open parenthesis
> 
> Signed-off-by: Chen Shuo <1289151713@qq.com>
> ---
>  drivers/staging/greybus/camera.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> index cdbb42cd413b..ed9e16bab4cc 100644
> --- a/drivers/staging/greybus/camera.c
> +++ b/drivers/staging/greybus/camera.c
> @@ -378,7 +378,7 @@ struct ap_csi_config_request {
>  #define GB_CAMERA_CSI_CLK_FREQ_MARGIN		150000000U
>  
>  static int gb_camera_setup_data_connection(struct gb_camera *gcam,
> -		struct gb_camera_configure_streams_response *resp,
> +					   struct gb_camera_configure_streams_response *resp,
>  		struct gb_camera_csi_params *csi_params)
>  {

Just leave it as-is.  The original was fine.  I know that these days
we can go over the 80 character mark but, really, does this make things
easier to read?

regards,
dan carpenter

