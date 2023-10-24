Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777A87D46D6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 07:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjJXFQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 01:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjJXFQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 01:16:20 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8B1139
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 22:16:16 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bfed7c4e6dso60732941fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 22:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698124575; x=1698729375; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aE2lxw/rNDGPdJ05hPD2uVnr0m8qN8L+coi09dprodY=;
        b=voTdEEAbTJR0vwW/o1kox8OsrTmg7U2FoGbx1H5joxsxlF0QSn2NYPi/U52DUXrp1A
         OeLIhJMp+8cZJwG7Zz0uqmuyCNVq4Q+agqQiYhZpzg9Ng2f51pUOSXjzEjW3TgS6LF7B
         DVGEuJ9r9XsQWiSLlqF5qpjM4QHZqnjVQSW/KKrMfDqzysdODfqMlhJd+2XSgwdEb8BU
         xf4o7+2PBgNmMS8QHfnid87w7x6b+0QRFyrZg0kSJt4NiXnCA9H97rqoKw/2q/adYkTi
         ih8GpeO8r6TS1BskYoWFfY9Cx32Kp2U1h9jD8lpomjamc/S5bqKBSS4KSaH5OhZLKtoE
         lmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698124575; x=1698729375;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aE2lxw/rNDGPdJ05hPD2uVnr0m8qN8L+coi09dprodY=;
        b=CbrYSQEWw27tPdpLXuIDxXs9j9bMWNfpRpEdgPErm+yKFEbx44aZOvk+l50AzRd/iY
         r1m9bYyrobMML1UKAnMFvAY8l9lfdjk22c81z1kCCgTByvIn/R694nSIvRivp7xq+Q3X
         ARoBDGw3gEiXpGqaVyim0xJmssdpgLh1I3hsVEZwLjil9QxXroQ7wqtWzPCXAgChOC3y
         Lea1E+kLHgCd2MXAMsuzHfpktfGS8QK/KVDaR3MPdcTJrhqVIGbdrJUlL1AFvpamClJk
         hHxk9TLcC/wTWdmImgZdQCvQK4T3nGOKD5YlhlGn5wx3wAY2L8xLBPrhbAb8xzwSCDui
         RBpA==
X-Gm-Message-State: AOJu0Yyz2iP4lD5dwC3J3n+feXDnZa5+1vUwd1PC8CuoyAnl9/Thfkyq
        gJe4OqMir21I1LYSc4ZYDIgyO4yiNFK9FXcIt5c=
X-Google-Smtp-Source: AGHT+IHjW90meTVeICIf9vFGqWrh2jrlNk4jyKzQOzYpwwr591HktRYBLgZz3B9ZPTt8EKOFSYqyOA==
X-Received: by 2002:a05:651c:70f:b0:2c5:2cd7:62e8 with SMTP id z15-20020a05651c070f00b002c52cd762e8mr6721518ljb.12.1698124574533;
        Mon, 23 Oct 2023 22:16:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b003fe61c33df5sm15988490wms.3.2023.10.23.22.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 22:16:14 -0700 (PDT)
Date:   Tue, 24 Oct 2023 08:16:10 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs@lists.linux.dev, ericvh@kernel.org, linux_oss@crudebyte.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        Su Hui <suhui@nfschina.com>
Subject: Re: [PATCH 2/3] 9p: v9fs_listxattr: fix %s null argument warning
Message-ID: <03a1c530-ac79-4286-9156-b258f79d1fca@kadam.mountain>
References: <20231023233704.1185154-1-asmadeus@codewreck.org>
 <20231023233704.1185154-3-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231023233704.1185154-3-asmadeus@codewreck.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 08:37:03AM +0900, Dominique Martinet wrote:
> W=1 warns about null argument to kprintf:
> In file included from fs/9p/xattr.c:12:
> In function ‘v9fs_xattr_get’,
>     inlined from ‘v9fs_listxattr’ at fs/9p/xattr.c:142:9:
> include/net/9p/9p.h:55:2: error: ‘%s’ directive argument is null
> [-Werror=format-overflow=]
>    55 |  _p9_debug(level, __func__, fmt, ##__VA_ARGS__)
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Use an empty string instead of :
>  - this is ok 9p-wise because p9pdu_vwritef serializes a null string
> and an empty string the same way (one '0' word for length)
>  - since this degrades the print statements, add new single quotes for
> xattr's name delimter (Old: "file = (null)", new: "file = ''")
> 
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> Link: https://lore.kernel.org/r/20231008060138.517057-1-suhui@nfschina.com
> Suggested-by: Su Hui <suhui@nfschina.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> I've checked this works as expected (getfattr listing all user.* xattrs
> after setting some), so let's fix this warning.

Awesome.  Thanks!

regards,
dan carpenter

