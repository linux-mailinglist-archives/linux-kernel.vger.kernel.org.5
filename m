Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CFA7D05BB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 02:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346763AbjJTAQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 20:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346772AbjJTAQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 20:16:19 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE0111B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 17:16:17 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1e10507a4d6so223322fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 17:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697760977; x=1698365777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hEu1eSssB3T65KroddKXpWsNaV3cdGbl2CloW40p8rQ=;
        b=XKNrTAcwUYwoz8Bm52eSAw4//iurvHowtdbKax61ZkSH5G+kc0XVvUqdb9oZNFzfEf
         CvvOzpZ41r/vW3/dENIXtQiRIdlSOhJ+CEYeXGgc1d5BDkIbTExwo26ddSNMWBbU88lr
         rb0LOzDSqOViqzWgvtHxOB2l80X10esI8VUcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697760977; x=1698365777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEu1eSssB3T65KroddKXpWsNaV3cdGbl2CloW40p8rQ=;
        b=c+YWTeqQhgcGdBDjYukM2YEZ3mMntTtYspJ39s6BMxdF+WitkAuNODJhlDNE0Kldjz
         ioD32DmHMi3pH2eYwIDRADZTuGQdNe1Ll7Ojp5FWXg48//KCgjh+qxRsDV+4X8Btmh29
         bZ4FLIOiwDo+o/Hw2GTqYqz+WRfEioxIt4jLNfA1yzr90I1zAbu7T274csWPOCXyeo04
         D8JA0Lv8RG5GxJtcCTJqK9MAu1+kzK/vuV/hKn3zrmv+0kYabY9Nj1t3jzrqPl9pkN4l
         vHL6xDLK6RC0svMJgQpE+BIdgV5FWd8OdjoMLv77fqumtAC46yhlo8DdyMbYIEcPjkdV
         zERg==
X-Gm-Message-State: AOJu0Ywco36vU8Q2IVUPBNFDYn+f1gBkbvGe2Zt1Zs4lraHEJ/cY+WWP
        mju8+fBTuXvL0LiqcbjT3DBe4g==
X-Google-Smtp-Source: AGHT+IGw6iGv2GrzFkRpFoUMInWaglk1pERulGhcR2sJ/wJa0yQnRA0fw/QNogG4fYsveieaqaaT/Q==
X-Received: by 2002:a05:6870:3042:b0:1ea:206e:cb0f with SMTP id u2-20020a056870304200b001ea206ecb0fmr500951oau.34.1697760977106;
        Thu, 19 Oct 2023 17:16:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o67-20020a634146000000b005742092c211sm311363pga.64.2023.10.19.17.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 17:16:16 -0700 (PDT)
Date:   Thu, 19 Oct 2023 17:16:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] atmel: replace deprecated strncpy with strscpy
Message-ID: <202310191716.EE2FEB5B00@keescook>
References: <20231019-strncpy-drivers-net-wireless-atmel-atmel-c-v2-1-52e46fbea083@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019-strncpy-drivers-net-wireless-atmel-atmel-c-v2-1-52e46fbea083@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 05:29:01PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect priv->firmware_id to be NUL-terminated based on its usage
> with seq_printf() and strlen() in atmel.c:
> 1420 |       seq_printf(m, "%s loaded by host\n", priv->firmware_id);
> ...
> 3884 |       if (strlen(priv->firmware_id) == 0) {
> 
> NUL-padding is not required, which is evident by the usage of a plain
> strcpy():
> 3891 |   strcpy(priv->firmware_id, "atmel_at76c502.bin");
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Let's also replace hard-coded lengths to be `sizeof(...)` for buffers
> that the compiler can detect the size for as this is less error prone.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [2]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [3]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
