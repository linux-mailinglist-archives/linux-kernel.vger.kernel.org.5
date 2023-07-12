Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C3D7514CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjGLXzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjGLXzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:55:01 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ADF1FF0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:54:55 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-668711086f4so45543b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689206094; x=1691798094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Se+J8BMBlZ7z7N8IwDTVCsMWBFzaqhftgKoOtqAN2Vw=;
        b=jmbu3E9YYfWknUGb/cwYyFHkWhFyLsINERbOh19iOI27YCJ0rFJOanRa+GlZ3FzNOu
         5LHgII8Xw19t8JhIaJgwJx44SOGDiNDgayxWodP8LNjgonKA9+xyDwr/cAeRG+M4tG4E
         PurMSQV2w2utcEtv8GySBO6M73oYB1FmVF8No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689206094; x=1691798094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Se+J8BMBlZ7z7N8IwDTVCsMWBFzaqhftgKoOtqAN2Vw=;
        b=eULhylduloXQovgBv8rPShpOQuiULMMMYJAocBfgIBGLc/oZ5RCYAhp094b/1b58W5
         UaRtlvgKIhHkz6Ie443k9PwWgjxnE5Tv0/t5iPC31vXF4ZFaZLyHpi9Bp5SIWJuWfo/i
         rQL3kKNIIkisB261PC2Sjmx///+iPF6APie31AaNvWn3XSQ7OMyswN6YzU8jcgcZhl1m
         dhrBoB5AvBYkltMJIchqMWfhZycUUg60j8n36baJKzbPxrKKZd+xwKt1vlm/cXNbwyfk
         9iz+7Q17kdxRf07unn/K4eUz2IF7YvJjRHWERDiUcQiOjTOHo1147dJId7l7vSJAnkJD
         jIbA==
X-Gm-Message-State: ABy/qLZQseajp1+JjLSHoZcrbLpczQNzU0ySZQPd4KlC7PPDUGjRDDb4
        CN7EW1yJgQSkcAb/7Ksl0TjPFw==
X-Google-Smtp-Source: APBJJlHlNCamcVbfB5M6HLYNdZMLF6qk04LaC58OxarzNI2yzUPi6NLd/bcgqWvxJjN9YJIHYNvlnA==
X-Received: by 2002:a05:6a20:1614:b0:106:9266:4448 with SMTP id l20-20020a056a20161400b0010692664448mr417583pzj.16.1689206094633;
        Wed, 12 Jul 2023 16:54:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i12-20020a633c4c000000b0050f85ef50d1sm4163719pgn.26.2023.07.12.16.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:54:54 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:54:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] EISA: Replace all non-returning strlcpy with strscpy
Message-ID: <202307121654.5F8D4C6302@keescook>
References: <20230706175804.2249018-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706175804.2249018-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 05:58:04PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
