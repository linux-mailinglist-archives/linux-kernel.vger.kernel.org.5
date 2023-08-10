Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1F57780FE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbjHJTFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjHJTFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:05:05 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15800E56
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:05:05 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bbc87ded50so9272035ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691694304; x=1692299104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=860PWC8FTmmxEiDUGxT48Wa5iNqeUxA9TN3Utilr4kI=;
        b=LSIsvcicRp1TsKNMDQdPJBWvLb2GfgqtEswz/i6nTSQdUdvBzEIwY/W7B2Y1v5Uhxg
         ZCmZzgBRaztX0P+sW2P/XnEHlCWxOrckk5v6DF6qBY1Wz5Jxt9byx+iKzfiNluXatS1s
         qlUZN1NTP9tllyAzKgQJmZUaJ7PzF8tURqBXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691694304; x=1692299104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=860PWC8FTmmxEiDUGxT48Wa5iNqeUxA9TN3Utilr4kI=;
        b=PoSvOKZkFwOTba2Po/DteYLlcSAZXpjdfNdX1/9h6bEgrgxkwJCKqVtl/8mdwlEnW/
         YZJUWc1+PqKPLKqGyb5VOgpJPLa9Rb30Luw9tyUEDI8oTRvR8C/13lPOBzILxkeZ36wj
         mH0ue1H8bSDIJGem1KCaPvFPykaNd9uekOWYm0ZF+B66JQmkykRJVRjyxtUDQ67rZuAc
         bnBZhjLMKIzGO0y+taMfQV0VHRpxoM5anrPx6MH08c+32yyGH0NjMkaEdP4NGquiFcIK
         mDmaWqU/mVNoR72nxo11kzk3PjoWvNd79a6uo0PNK2CWWMO3cvmmy0XCcIkNV5+VYWDy
         l/Uw==
X-Gm-Message-State: AOJu0Yy0dfgzbi+sHRydRnnvx3DE8nQvffxZoEUzKw4wIV36PjPCnjO0
        mtFnGrDRkBOGX68/23ZJZRwWKA==
X-Google-Smtp-Source: AGHT+IFZ70Z8bWdGaTakkvT4U9Nu4x3xJoLxtXsK6ixM+o35icuoD5Qtp4zihOOd3zdu/f4Iwv0JFg==
X-Received: by 2002:a17:903:120c:b0:1b8:b3f0:3d57 with SMTP id l12-20020a170903120c00b001b8b3f03d57mr3468147plh.31.1691694304549;
        Thu, 10 Aug 2023 12:05:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902d34d00b001bda42a216bsm1859975plk.100.2023.08.10.12.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:05:03 -0700 (PDT)
Date:   Thu, 10 Aug 2023 12:05:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-hardening@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] um: refactor deprecated strncpy to memcpy
Message-ID: <202308101204.BF36493304@keescook>
References: <20230809-arch-um-v3-1-f63e1122d77e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809-arch-um-v3-1-f63e1122d77e@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 06:19:32PM +0000, Justin Stitt wrote:
> Use `memcpy` since `console_buf` is not expected to be NUL-terminated
> and it more accurately describes what is happening with the buffers
> `console_buf` and `string` as per Kees' analysis [1].
> 
> Also mark char buffer as `__nonstring` as per Kees' suggestion [2].
> 
> This change now makes it more clear what this code does and that
> `console_buf` is not expected to be NUL-terminated.
> 
> Link: https://lore.kernel.org/all/202308081708.D5ADC80F@keescook/ [1]
> Link: https://github.com/KSPP/linux/issues/90 [2]
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> Cc: linux-hardening@vger.kernel.org
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for digging through this!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
