Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE6176639A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 07:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjG1FZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 01:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjG1FZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 01:25:03 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1451330FF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 22:25:02 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so18522175e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 22:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690521900; x=1691126700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QhXjvTT1z/0Yde7vmO70EoyF2uav/7UHdhOF67DdG14=;
        b=XOQgq3+ILcCCJmdqTQzoiRxVgQX65mXoXI4u+ymyDQGTa2JEOKd5rI4c2BUeZQ9ddp
         4hLFTUYPbQ3wth7dA32jY73j9JABR7M/hYXTlI0K3RikX0Af1pE+7s+kZjfm6ZGq5ZQB
         rfv5QeZhhiGHOXIxXNVuY6a+rf5eSp6FCag/+NvyyHzoN6ZH30DQP/b3Z+JX2A+R8Zat
         gfVZvxZH5i6G9yk0JPTiengAvXb5kyHEMtcuENqynXv2n0RziGFyGHJUFKPe499ydroU
         1N+iyM7RrslQnVYbudq8/b5oPXQrVw5Wq6FdotezmIpKZiIvC0eGS+mg2fLYMSlUwZEv
         LyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690521900; x=1691126700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhXjvTT1z/0Yde7vmO70EoyF2uav/7UHdhOF67DdG14=;
        b=JiLHKWkBL9tS7+fcUlivQM2MhCTDhCITQivjSmso7yRVz++bSBQ2+Wy3s2llxYUxiS
         DufoPv97OsL1hCXzJATCz0cXqTxba+5yZI3J4E/GgeDLnCQ+VPv01u5R6Aa5flOo+j5z
         8Hh6ZdZExwNtW/bz0RkHlYeczPb/ZmZ7xvyw3Og6Qhd9DjpZ5H5UvhxH6bWQS+ktqYbK
         ZLtwz0x6f4oR7N3bBQbpuRPI/FPVXCY4i2eYuJpk6YIk6uaIBrQbzW1xyUEVvIvBrnTG
         LEppAUmI+AbPMWZUMr/KTnAPeS8c7zbG0lRFL5IsyW4jN7Vs8JSsFCx3AcxQm3Bhw8ml
         2aYw==
X-Gm-Message-State: ABy/qLbA+EdZqp5y2wt+65jz9gqWFPuLFErkBDYVPcqy2k1G0o7vsCZ9
        y2eaNXD8cjM7qCT4a/buW0l66A==
X-Google-Smtp-Source: APBJJlGHtNWsq2d6hGtGwwyGl9qqBOF+mkyNxUw1SO2HGPsAosfmm009SzN4C8A/L0G//Y5RnoXO5g==
X-Received: by 2002:a05:600c:2258:b0:3fe:10d8:e7fa with SMTP id a24-20020a05600c225800b003fe10d8e7famr25702wmm.41.1690521900478;
        Thu, 27 Jul 2023 22:25:00 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c248100b003fbd2a9e94asm3241617wms.31.2023.07.27.22.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 22:24:59 -0700 (PDT)
Date:   Fri, 28 Jul 2023 08:24:56 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Alexon Oliveira <alexondunkan@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: fix check alignment should match open
 parenthesis
Message-ID: <2354895b-c127-40eb-8f16-b19e4750e1d0@kadam.mountain>
References: <ZKjeHx/zqrNIqaA6@alolivei-thinkpadt480s.gru.csb>
 <2023072729-sensitive-spyglass-ec96@gregkh>
 <ZMKDeyGaPQHm6/pr@alolivei-thinkpadt480s.gru.csb>
 <2023072741-mankind-ethics-b95b@gregkh>
 <ZMKkgItqf8r8BcRB@alolivei-thinkpadt480s.gru.csb>
 <2023072752-stem-pupil-76ab@gregkh>
 <ZMKrcvpu3b15Hdif@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMKrcvpu3b15Hdif@alolivei-thinkpadt480s.gru.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 02:37:54PM -0300, Alexon Oliveira wrote:
> > 
> > I would have thought you would get a "line is too long" warning, that
> > didn't happen?
> $ pwd
> /home/alolivei/git/kernels/staging
> $ perl scripts/checkpatch.pl --strict -f drivers/staging/vme_user/vme_bridge.h | grep -i parenthesis
> $ 
> Nope. I didn't get any of that. Check it out:

Heh.  The warning is there but you used grep to remove it.

Speaking of long lines.  Could you fix your email client to line wrap at
75 characters.

regards,
dan carpenter

