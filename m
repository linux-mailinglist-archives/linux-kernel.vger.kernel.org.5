Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468B57A26A1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbjIOSzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbjIOSyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:54:50 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF784220
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:52:05 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b9e478e122so1418347a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694803923; x=1695408723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X0WyqAJ5yJOqId14DuOsChOBKAGV647ZGJyOmq2Fqjk=;
        b=i8Ye2DMtYiBYPRcERhlvAPVdDc0JMFPyMVCZUMGebxTOr3BXkUsK+cW0t7lFisIXSt
         /r7n+jFfKBE720LIDKSviYgQHk5IAqKqB13F8e3p+YGrGfZsIn1umOHi3rUcZY+EUaX0
         FEE/NaXtQh0TCtCkXNHVC30V14VpPr7Iah5Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694803923; x=1695408723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0WyqAJ5yJOqId14DuOsChOBKAGV647ZGJyOmq2Fqjk=;
        b=afn6/XY8BO33lUJSdAfyzrk89dFevEADcS3Jw3lFcD1jbYqyfviNMOG1CCjqP+ipPx
         XjQWenOMaWxNl/2I2LhhpmHT5wZEjX5bQS0zHIGVLoC7T+JStPonuJl0z2r2wSRRFfz8
         PLJlDZsyHigp00jN2UOalA78nKyKy9sNjD/ums8X65ej0/5AQ+2g0PYWudPP80MqMoJU
         667Lbcty9YUKxtaO5jU+3NvrgLbRFwety+V/TgyJNg6FcDoUCBtVxL/POM2XNiZHGUZJ
         XmS5U8fuXEjKKO2pkswduCv6oJUxBJLVQcTdvEgyLHPiHcRSBGCu2UWyecodSKJ3XEKF
         rqtQ==
X-Gm-Message-State: AOJu0Ywl8akR821Lp8tDYZ7oSrMd3KZOnViuiKC2NpQ3beGgOvyXlOnN
        juRPXhD1guk0R/pwINe7IGSm8w==
X-Google-Smtp-Source: AGHT+IFLeulKYJVZbtaYCC78ng58EYSEdkdd1lDUFANMECpbOAZc+gCpxueIstOyFv/ysLfUav4NJw==
X-Received: by 2002:a05:6358:71a:b0:134:28d6:be7 with SMTP id e26-20020a056358071a00b0013428d60be7mr3696470rwj.9.1694803923555;
        Fri, 15 Sep 2023 11:52:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q13-20020a656a8d000000b00564b313d526sm2716841pgu.54.2023.09.15.11.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 11:52:02 -0700 (PDT)
Date:   Fri, 15 Sep 2023 11:52:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Peter Stuge <peter@stuge.se>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/gud: Use size_add() in call to struct_size()
Message-ID: <202309151150.74DBDCA039@keescook>
References: <ZQSlyHKPdw/zsy4c@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQSlyHKPdw/zsy4c@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 12:43:20PM -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound, the
> protection that `struct_size()` adds against potential integer overflows
> is defeated. Fix this by hardening call to `struct_size()` with `size_add()`.
> 
> Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/gpu/drm/gud/gud_pipe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
> index d2f199ea3c11..a02f75be81f0 100644
> --- a/drivers/gpu/drm/gud/gud_pipe.c
> +++ b/drivers/gpu/drm/gud/gud_pipe.c
> @@ -503,7 +503,7 @@ int gud_pipe_check(struct drm_simple_display_pipe *pipe,
>  		return -ENOENT;
>  
>  	len = struct_size(req, properties,
> -			  GUD_PROPERTIES_MAX_NUM + GUD_CONNECTOR_PROPERTIES_MAX_NUM);
> +			  size_add(GUD_PROPERTIES_MAX_NUM, GUD_CONNECTOR_PROPERTIES_MAX_NUM));

There are both constant expressions, so there's not too much value in
wrapping them with size_add(), but for maintaining a common coding style
for dealing with allocation sizes, I can be convinced of the change. :)

Reviewed-by: Kees Cook <keescook@chromium.org>


>  	req = kzalloc(len, GFP_KERNEL);
>  	if (!req)
>  		return -ENOMEM;
> -- 
> 2.34.1
> 

-- 
Kees Cook
