Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98278011FB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjLARp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLARp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:45:27 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE121AC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:45:33 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cdd13c586fso2194075b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701452733; x=1702057533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9uudzapsKSbAF1Nf6v1rAhKcYau6FtPD1nj4fOsoHgo=;
        b=lQ+/KwqC2jl5gjb6lqTHU+tWGGd6LRnV0E5lvK9bUjmeHqxuZKfyA7A5zd1dWUE94d
         3oY2fC/qxmG3oma0iIcfhJ7xO+yhesOSUlpT6g0nIj0R+Fyu6KFm3wg1V/sXFmBfOPJO
         6oPc59TcnfW7jJMmn5A6FYTDuu/KqKc6m7wj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701452733; x=1702057533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uudzapsKSbAF1Nf6v1rAhKcYau6FtPD1nj4fOsoHgo=;
        b=KyOHkJfahgWHG2EMIjuWi9J9ilXy6iQYaC/mspwceDLSEzrxmlZ0I3XDlMHP13iRGn
         SQIEHFM5XnJ74yxVQytzRTlL7V5lcO8pPE1d0nDFaFjAfGF6NJPygwyompjJHpaAPM5A
         mf8HIawEOuf7sImhKL8qfoUz2jh4y6SAVAYJs4AmdIjyFfyHXGw0KuQOvCp4DQNCSB5J
         pLeaxSIcoLw6BlXMKDEIimfjtWsxqLeR/83D6JLq0Z5UStT1LaO7p1Me4yaQOLndQpZ5
         p0Swk4dPN9C5VTR5476g99EA1Yr9y6IvNOZEiKMv2nCLrgHuUrFPUl9FFHJol7zjf2vM
         8QZw==
X-Gm-Message-State: AOJu0YwErFWnDApmGEEbZZQr0IrKY6XZG+t4+c/FmVVoLuHiYvHVVFLW
        LG+f4yhwyAW4Za16q4jDMC1Nyw==
X-Google-Smtp-Source: AGHT+IE8Y3Xlb1nIh430VzJEjJko7Zybqxd7NABPBjihyrc4oBTu7YxNT8W6hr62WXGLZOQCgU7lbQ==
X-Received: by 2002:a05:6a20:3d07:b0:18c:4105:9aa8 with SMTP id y7-20020a056a203d0700b0018c41059aa8mr24903073pzi.51.1701452733274;
        Fri, 01 Dec 2023 09:45:33 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q13-20020a056a00084d00b006cdc0181de2sm3258261pfk.128.2023.12.01.09.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:45:32 -0800 (PST)
Date:   Fri, 1 Dec 2023 09:45:32 -0800
From:   Kees Cook <keescook@chromium.org>
To:     sxwjean@me.com
Cc:     vbabka@suse.cz, 42.hyeyoo@gmail.com, cl@linux.com,
        linux-mm@kvack.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev, corbet@lwn.net,
        arnd@arndb.de, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
Subject: Re: [PATCH 1/3] Documentation: kernel-parameters: remove noaliencache
Message-ID: <202312010945.3320D8EFF@keescook>
References: <20231201031505.286117-1-sxwjean@me.com>
 <20231201031505.286117-2-sxwjean@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201031505.286117-2-sxwjean@me.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 11:15:03AM +0800, sxwjean@me.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> ince slab allocator has already been removed. There is no users about
> noaliencache, so let's remove it.
> 
> Suggested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
