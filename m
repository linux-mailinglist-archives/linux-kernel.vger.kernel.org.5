Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F913755ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjGQFZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGQFZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:25:26 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479CBE5E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 22:25:24 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5701e8f2b79so41999987b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 22:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689571523; x=1692163523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5o8x7WfqpbTWGumqTfPqJNHGtE2wJfE7jtkKpKYZj+c=;
        b=VWEV+4GR/v7uuYphe9pBIAVRaiJlQbvCVNeujPX4hg40uriLybQcuhZ+uaM+WTJdhp
         Za2D4vjxhCQwvI93en1hma1VbvwvqxEWnOTN/ODo46pmjPERsPQhJH446KPjHXSbBfUS
         iCfSiTiymROpfAiHAItYMxuOsdI+ZjkZzLKGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689571523; x=1692163523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5o8x7WfqpbTWGumqTfPqJNHGtE2wJfE7jtkKpKYZj+c=;
        b=RjHfgaum5IO+kuBgdS7K6i34a1WxTsYTqYNDSVyY3YsWcyzfn4AjVkPeZAkXrUkkP3
         xZCrzuJ1syfiAnEcJzJrVuA1cCGeiTksMmXc/Fg4z7+LYsKejO191BEC9b9KlGS/918N
         tlVtXa52GIF/EDiz/1kMGVQZkK3PkNVv3Rn8i+N6Rr+SaMxo/9RwXflcpOi2rQkxPCHj
         mCEwYSw5902jC/hRvjOzp/vLTx2JdZVoa0xkMBd9WrZAtKCEtzmvE9CCD/qcO0eBecNN
         XHqhLFromGnf9KULqZ4/E9JlrYFTJYbyGw9vr8hIOcBpg3V9gn9rLLpy7EGv7xQKNAzk
         /Xwg==
X-Gm-Message-State: ABy/qLb6EcG9e1aYPWE4vf+HNJMhm436aVbn92ZSfNqcPb+b6iBEfG/2
        CPZSpoMPjUVNyXXUYwrjqpPCGe1MxGNkkPlLd3s=
X-Google-Smtp-Source: APBJJlEtplyetddtVmYEMQHZPZJ1nOCCKZQC3m54KDhQQ25VSAD2FwWsAma5iEEyM6CZtW1Qeq5XEQ==
X-Received: by 2002:a0d:d808:0:b0:577:257d:bf0e with SMTP id a8-20020a0dd808000000b00577257dbf0emr11316233ywe.22.1689571523481;
        Sun, 16 Jul 2023 22:25:23 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b001b8a53dde99sm11709820pln.296.2023.07.16.22.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 22:25:22 -0700 (PDT)
Date:   Mon, 17 Jul 2023 14:25:19 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust printk/vsprintf entries
Message-ID: <20230717052519.GA57770@google.com>
References: <20230705131511.2806776-1-senozhatsky@chromium.org>
 <ZLE4BVH3o-Y3ximB@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLE4BVH3o-Y3ximB@alley>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/07/14 13:56), Petr Mladek wrote:
> 
> Thanks a lot for staying around and keeping an eye on printk().
> 
> I have pushed the patch into printk/linux.git, branch for-6.6.

Many thanks Petr!
