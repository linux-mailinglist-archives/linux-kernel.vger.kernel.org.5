Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98B47678E8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 01:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbjG1XW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 19:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjG1XWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 19:22:55 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697673AAC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 16:22:54 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686be28e1a8so1868737b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 16:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690586574; x=1691191374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3J02gGPlZbZHgOQ6syHZQDMbL88svEYL3WquPy69jjU=;
        b=OyOMvsiUoVcZVoxz3S3mVRqlkP5ItPBXfoVU508M21VmJ77cghHo71kcfTxpCTQr9B
         +KOdpAXL278mjK4gvNLkJMvHfGwSCGkxz2J2FM+sOO/PUx5qle6t7qqrHwT7HnwRvPri
         h9Eb9Y0/mCIbT3eADa8OM2kGwHE+NsJRA1EnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690586574; x=1691191374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3J02gGPlZbZHgOQ6syHZQDMbL88svEYL3WquPy69jjU=;
        b=M3vqf/l2SQVshuGOVGJb0PRqXBQW2Hrk3NerGMU7xNDarD5pJaRuSuK70GZ2KVSZuL
         10ntTYP5kAnfgtLQaxThjQ7kjOYilSE4ILH30/9H7YFxDmCu5onLuERaAjQfAxA9zMWD
         OIde7IdTGahZgqvOXjCN4STe2BDZsXMbR/kMbNM0V4l66P73hwA3GlFuTMfV6LMSoRyU
         3YuyVRE7168QwycNq+t58c5qKeUI5PB7pJ7+1AdkDZNMcbLRzJvSF2AogvuWoaE1Uu98
         j0nLHNiO1HGOiwWFINv7Os5MJyP+0F2HXIQuOguUJJwpknenEO+DjvKWBEmMNL4KPBwk
         nRxA==
X-Gm-Message-State: ABy/qLYe5v9tg9TGhJD5wvEx+sTyWmCYbZKkYY70h6T9avxuaOePLBsP
        fKPyNhBcI5EPBa2g3Xxqd5Sjmg==
X-Google-Smtp-Source: APBJJlGQfZLVQNgsEv0pXXb81+pMSf6XgrCMsILXZO2g0C5yTNhAizbBghrn9UMk6Jj4XjQAIKBtQw==
X-Received: by 2002:a05:6a00:138f:b0:686:9385:4644 with SMTP id t15-20020a056a00138f00b0068693854644mr3518683pfg.2.1690586573930;
        Fri, 28 Jul 2023 16:22:53 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a10-20020a62bd0a000000b005d22639b577sm3615689pff.165.2023.07.28.16.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 16:22:53 -0700 (PDT)
Date:   Fri, 28 Jul 2023 16:22:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Docs/process/changes: Consolidate NFS-utils update
 links
Message-ID: <202307281622.CF15DDB@keescook>
References: <20230728211616.59550-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728211616.59550-1-sj@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 09:16:15PM +0000, SeongJae Park wrote:
> Two update links for NFS-utils are in two duplicate sessions.
> Consolidate.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
