Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3D77ACD8B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 03:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjIYBSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 21:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjIYBSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:18:41 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC2ECA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 18:18:34 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68c576d35feso4915778b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 18:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695604714; x=1696209514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9DU462jzu0KSSUhuGCGA7DV9qo0R9Jblrk/4+b+Zma0=;
        b=S43V/sgk4uFDQ1qU+bJiP+aoGrYczLUQK8n9G80IVrvUprhG1XbFJ896rEAnRyJ5wu
         pQrEM6WvJ/ZsHP/bWKPLQOypiA8rg6OOAG1WiblaJI1JhDzCSNaQ4jaheM6E41HH/VWS
         sOXlNtLcMP5UDNTBjdVdIv4Bg7gfqb4Rv2+ZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695604714; x=1696209514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DU462jzu0KSSUhuGCGA7DV9qo0R9Jblrk/4+b+Zma0=;
        b=UahOktvXxmgIIrm01J0JsHer2GHnCOOLdJ+PD/Ee9+F0EJdyg0e1Kokihr5BB0yLmd
         GcAf5m1tleKKRYK2at9zZnezHmYSmLc5TxfpvWnCtIZKteQZCDAQcXKj8LRYpOXw37NP
         fRScbg/4g8yM60QLsHvgm4uyKvkzCCEJv35PnC4XxIvUS9tZVc5OsqvRkyzOiq9ks7iY
         MTyjStT8TAPwlPG1EJnpxifCjlRqrF68snL6lz1E50HHFAGnL9NJajGLckLA9XZ2Ihen
         uw0PHGa4aJB7KThrdD668JBmZBcYTAZQdHJzmp1npCyL1xTRrDjyUHwgEEXJEo8sKVuO
         ejbg==
X-Gm-Message-State: AOJu0YxCjG9xvVYj8fvDnZvd/ac4o4HhgRpT34zruJN1GA0u1xfp4D4o
        MT3pVWDw6ZQzBXhkJ3xikDFVnA==
X-Google-Smtp-Source: AGHT+IE43Znl4JMWvt1Sa+09y9ZCuxcI1ZEW+xSvOE2VOYQ6szobgNYlZM4v0M1FLtM3mFR/8AsmbQ==
X-Received: by 2002:a05:6a20:9383:b0:15a:2c0b:6c73 with SMTP id x3-20020a056a20938300b0015a2c0b6c73mr7171586pzh.12.1695604714203;
        Sun, 24 Sep 2023 18:18:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001c3cbedbc47sm7469161pld.6.2023.09.24.18.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 18:18:33 -0700 (PDT)
Date:   Sun, 24 Sep 2023 18:18:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the execve tree
Message-ID: <202309241818.2F77ADE18@keescook>
References: <20230925081510.6dacf35e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925081510.6dacf35e@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 08:15:10AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   d11362467939 ("elf, uapi: Remove struct tag 'dynamic'")
> 
> is missing a Signed-off-by from its committer.

Oops! Thanks; fixed.

-- 
Kees Cook
