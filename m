Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBA87B7574
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238352AbjJCXqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237659AbjJCXqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:46:50 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA3CBB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:46:47 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57e40f0189aso868939eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696376807; x=1696981607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PPFPtgXKpDPjFV3QZDdRhVrKDYAKfhNMoOZnAYYIu54=;
        b=dMSf0fmkjXKzyUhCUD+39MmCtkSf7GOv33nC3LVWu6SHJyYFqx2PK0l6bg/xw0CGIo
         r1C4Z1UuD32Bt6HWZ4bxGHVw2DG5ga/JsfCx6Op1pcbOA+6OgBFWTTaEXXZdymVMNe1Y
         jt+TXutgbPeDvjdFV2Rka7ZhEG8VMVf+5LYUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696376807; x=1696981607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPFPtgXKpDPjFV3QZDdRhVrKDYAKfhNMoOZnAYYIu54=;
        b=XhGJHiOz6K834QckonExfpmKNdsscTB29Hw5DwYCGxtshMZsaomQjT0ubp3J8phfBR
         h+p9BGl7uaHCdlHnEkASLthUWjZzxF48pnorSbvrDWDaa699mLCRSIvEAsVRsCinptOz
         hhV9nChpLeYS9NmW74Z1/IvOtmj/fGHeb7iVr4zqm4Oo/eH2lpD72I9DJaeCpTjIWUbn
         gau3JBtt+nTSDd6k9ZeiTfslWIVx2LRWYujFksuc1y1kGSahqz0+kw7366sBpxvohjJ9
         T+x0LuXwTmmPonHYysSMJnQXOY55GYvVRveWVqbAw4nvKZE4N1RmjLZYGXiKZ6GyYhW5
         0KjQ==
X-Gm-Message-State: AOJu0YyZaLsDt3QDYhDMfEwBhoW9cXEpCl/E4u1paVZGUQnUYoW91tIE
        pKskk/pBge+mWfXPoGI37uq25A==
X-Google-Smtp-Source: AGHT+IHbxAfwDk9rTDaWI6/sinLESFPC9XLXsSohZ3q/HHKFgdJUwD8aS1e0iHAM1k2HY5fFzEXS7w==
X-Received: by 2002:a05:6358:e4aa:b0:143:9b25:c029 with SMTP id by42-20020a056358e4aa00b001439b25c029mr898736rwb.2.1696376807010;
        Tue, 03 Oct 2023 16:46:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gl18-20020a17090b121200b002775281b9easm146149pjb.50.2023.10.03.16.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:46:46 -0700 (PDT)
Date:   Tue, 3 Oct 2023 16:46:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] drivers: misc: ti-st: replace deprecated strncpy with
 strscpy
Message-ID: <202310031646.C94326A6@keescook>
References: <20231003-strncpy-drivers-misc-ti-st-st_kim-c-v2-1-79630447b0a1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003-strncpy-drivers-misc-ti-st-st_kim-c-v2-1-79630447b0a1@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 10:23:07PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect both `kim_data->dev_name` and `kim_gdata->dev_name` to be
> NUL-terminated.
> 
> `kim_data->dev_name` seems to not require NUL-padding.
> 
> `kim_gdata` is already zero-allocated and as such does not require
> NUL-padding:
> |       kim_gdata = kzalloc(sizeof(struct kim_data_s), GFP_KERNEL);
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Let's also opt to use the more idiomatic strscpy usage of:
> strscpy(dest, src, sizeof(dest))
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for the adjustment. This looks right to me now.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
