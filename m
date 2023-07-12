Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFCE7514D0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjGLXz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjGLXz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:55:27 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A230C1FC7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:55:26 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-55b1238a024so185439a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689206126; x=1691798126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/vU/3bfdHl64WUkd75ReRDYfirTILS0gvYwUTQH7DSM=;
        b=J7alN4E4ewEYIushjF5RhD5xtHURzl5VVAKqYeqMlBLF8w84WUPewCv7Owf2hO1Sx8
         s+NCKO3579s52rnAVRhkl9Bu3oO8BbS3ffYhxKwUqGrTmYDf88Wx6URNb5AOSDmk5OMZ
         e9iOjL4hPL/awuWYemSCQciujiFphf+0gfcEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689206126; x=1691798126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vU/3bfdHl64WUkd75ReRDYfirTILS0gvYwUTQH7DSM=;
        b=jqw3/zeynUkbW+hCEaJyBydNeUu91qLlemGIq66/dGEY3DAVsauDIRJ468+ialtLeD
         pa3ee9aENkFlt0tl9pSrqs9fTGKQxiK6TW5NEcQqPyF3lfHRkAQJ+0PcchkvwTY+IK6X
         MOwK8J5m2avRbqyNIDd1K1FWXa+sAZXO1JoWUVXNnNJNkbFu35uNGhV5tkzS2Se8VqGB
         20e44fuIH/joVKOJOw2TqUWB0EW39XgxX7PyKRrKUp/As4aRQtUXilxi43/Cn9P0lTsV
         yuhaT/5Kzc5lyVoClntvBhDhGUPc7T+QjeCNKfRYn8D6qI/aebz28V+KEfkawMqwqXFu
         BLnA==
X-Gm-Message-State: ABy/qLaD0zojZRvP+vQz2OWsid01gmIXZ33xNSn2j6j4tlqCBeRpOtJE
        BYzsZBtUNUfcaVQhODv9WxGgwQ==
X-Google-Smtp-Source: APBJJlHQZRshLJRZTXRiub4lrbl9NPrV3egVjkpObEu7LZ5J/dFpr8E4upDYkJFMKJLvoGPiSxabFw==
X-Received: by 2002:a05:6a20:3257:b0:120:1baf:e56e with SMTP id hm23-20020a056a20325700b001201bafe56emr21055274pzc.19.1689206126202;
        Wed, 12 Jul 2023 16:55:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j2-20020aa783c2000000b0064f76992905sm4120145pfn.202.2023.07.12.16.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:55:25 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:55:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH] wifi: mwifiex: Replace strlcpy with strscpy
Message-ID: <202307121655.C365BB8@keescook>
References: <20230710030625.812707-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710030625.812707-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 03:06:25AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since return value of -errno
> is used to check for truncation instead of sizeof(dest).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
