Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29077B2CF3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjI2HUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 03:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbjI2HUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:20:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1241A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 00:19:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40537481094so141939985e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 00:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695971996; x=1696576796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2G37RIl7kto4FtV/40rmYpXWGRKCCU93GLbr4NX82jY=;
        b=gNnY1S7mOVGnQ1XvplLEvJ1VafOvj0S+mgq5zI4cIpXy3sHWTd74YFtkIYOFJfGJB2
         gVZHC2siSlSLJBe0dlAV2TGS0agHi9oSsfPFiG8uqXcq/luANKcZfQKaOVunp1VnbA55
         YJsQmp2/vnPb96obCjwE0EETXLKO19nTzeMlrA5W5SRdy9pKF5WT3iDDK+2PD5UGx33f
         q3ycwLtVmhAj13k3PovQTdc7eHtaz7gX7xZNGeKDHHgxmmSOEohF8vTAmIUSJ8vDBBZ9
         7IbL6wdOXqzf1XdRqaVqE6OLErziZlxGe435acap7gPLat4QuIMZgZ+VlZ+td3w6W+Pf
         5rCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695971996; x=1696576796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2G37RIl7kto4FtV/40rmYpXWGRKCCU93GLbr4NX82jY=;
        b=sNeT/z5blL0D6Y6ge3xyjoC0TaKII9H2yt1gWEa+9DZho3ZIL1vs988IdYNkIVDego
         TcpEXFfeFppWg00pdUQ9eRklFpspt5gsqp5r3ITxXTWlchaQJFtFthroviClisR9ZFgr
         81ILii7VGqOC3yIDa+9fibRGTlnh7ZUST/o8wyShDv8jBgIxqXxVOc2FWG5xhfMz5mc4
         7izeq1MFmxSiisM54zf+WIuVdGI3gX/Elnch6++LnFljmjnMryfX5GVY5RX5O5/SRPdo
         BjSLlMVdcCJgx8T1jTZTKutDixUPzUKDaM3vhgxCyv5yHO2wb1lhIFy8kb4/qAGz9IZi
         i9Mw==
X-Gm-Message-State: AOJu0YwVZKzOkNIIghfaWFFrLqEamhbWMvYVuA0xNKdAHqS9mrfuK1YO
        kg6Xk6cphKsMFoH/wmfIa014Yg==
X-Google-Smtp-Source: AGHT+IFAnTJgZXllMlYUYlRUdQ4ql6RQj0k5B3k8rVQv/EDo9kRhHUg7wimNSMotX2rYeIBxcKp5VQ==
X-Received: by 2002:a5d:6910:0:b0:31f:e980:df87 with SMTP id t16-20020a5d6910000000b0031fe980df87mr2970055wru.38.1695971995977;
        Fri, 29 Sep 2023 00:19:55 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z15-20020a5d4d0f000000b00324ae863ac1sm2148989wrt.35.2023.09.29.00.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 00:19:55 -0700 (PDT)
Date:   Fri, 29 Sep 2023 10:19:53 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Pavan Bobba <opensource206@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: vt6655: Type encoding info dropped from
 array name "abyBBVGA"
Message-ID: <76e75a6a-b3f5-4f96-a9c6-b01f8f491140@kadam.mountain>
References: <ZRWWcGiySdLbCM3z@ubuntu.myguest.virtualbox.org>
 <29dc3df5-f313-f194-7f73-3207215e0864@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29dc3df5-f313-f194-7f73-3207215e0864@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 08:34:40PM +0200, Philipp Hortmann wrote:
> On 9/28/23 17:06, Pavan Bobba wrote:
> > array name "abyBBVGA" updated like below:
> > 
> > a.type encoding info dropped from name
> > b.camelcase name replaced by snakecase
> > 
> > Issue found by checkpatch
> > 
> > Signed-off-by: Pavan Bobba<opensource206@gmail.com>
> 
> 
> A coverletter is missing.
> 

The coverletter isn't required, but the more important issue is that the
patchset wasn't sent as a thread but instead as separate emails.

regards,
dan carpenter

