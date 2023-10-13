Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C967C8385
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjJMKo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjJMKot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:44:49 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92169DC
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:44:47 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so22605805e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697193886; x=1697798686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XCTYo1QvPgr9D8OOo/ac1BFS2ndiObZ+hWV0ZomsWcE=;
        b=bHpiG4bO2gHO8vH+gmWGl/tmYq/eDxm+8xKcwPQP6qTw9NsGwmZx4+56V5emKsY4zL
         PXMO29OCJzFzTvNbsNIOn7uCEFHjVUukrra9CNfv2OAiAayyJcWNddhInWbvrXQr+550
         mFnrrDAYVF0gwxYsg2T4VONsDxIINvDZom3XjIjY+kaXuo7niKywfEvWAkh6+NADX3Jh
         npsMHq61FYCCEoqKLnVmFdbXkcyMprFdF8KRqcEKsh4ETNTWwHU6v0912K2Y5nS1w8RE
         al5GYdEdv1VSv4razMkTwDrDtrblJb5dFgWjYOgCkv6K/Zw9HJq5w6VAfp9Vxawgd5h2
         lW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697193886; x=1697798686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCTYo1QvPgr9D8OOo/ac1BFS2ndiObZ+hWV0ZomsWcE=;
        b=BU+BUrjr7+G32wEDhmjfe//podC/0bTY1EvAcwtaHhVQcc9/FFnjzbenqA6M0DzOg9
         y9kfmGR5K7Z7Pd8S8J5bdn5rtbKWLpbEARSqNO7E43kfybiAu+D6kHJyklvD+nUizMiV
         cLUEGVKwow+t/n8+lIKnTNIcgwmwJeTSl80SZXGOxxscVI5/QAcmgj0pVs5socgrFv4g
         6+L6Lg/Pd2iD8abqWGGhiapL6wMqxXTzY3DyZ7qF44OyXU+ZKFbnPTWQ27gYIRzv1Y8X
         Y5hT8P5doFpC9aKjtgM2xMYUuAktj6n2KoGbgiemIf+1MAJA9qcO5BIHsWpWFN2O3lng
         XqgA==
X-Gm-Message-State: AOJu0Yw3l+6RAixgJs0hOlZdXM9UZBmzeCPOaFG8fQeLTzSw1mze0bwv
        V94ozlM/hT6LA702b/TEcSc7iYuwyMzRfqvWRcI=
X-Google-Smtp-Source: AGHT+IEubGhPXfLRKaMsQ9DF2i292nfBVjTNlhOLd8k2zPnDChgrer6Ha7bPCC/VPK1enKrQ7MnLKQ==
X-Received: by 2002:adf:eec5:0:b0:319:7134:a3cf with SMTP id a5-20020adfeec5000000b003197134a3cfmr23692272wrp.31.1697193885917;
        Fri, 13 Oct 2023 03:44:45 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e2-20020adfe382000000b00327de0173f6sm20515196wrm.115.2023.10.13.03.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 03:44:45 -0700 (PDT)
Date:   Fri, 13 Oct 2023 13:44:42 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luke Koch <lu.ale.koch@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Simon Horman <horms@kernel.org>, linux-staging@lists.linux.dev
Subject: Re: [PATCH v5] staging: wlan-ng: replace strncpy() with strscpy()
Message-ID: <4679268f-63ca-4854-808a-5cb45624167b@kadam.mountain>
References: <ZSkaIYGqAg5xJakY@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSkaIYGqAg5xJakY@lab-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 01:21:21PM +0300, Calvince Otieno wrote:
> Checkpatch suggests the use of  strscpy() instead of strncpy().
> The advantages are that it always adds a NUL terminator and it prevents
> a read overflow if the src string is not properly terminated.  One
> potential disadvantage is that it doesn't zero pad the string like
> strncpy() does.
> 
> In this code, strscpy() and strncpy() are equivalent and it does not
> affect runtime behavior.  The string is zeroed on the line before
> using memset().  The resulting string was always NUL terminated and
> PRISM2_USB_FWFILE is string literal "prism2_ru.fw" so it's NUL
> terminated.
> 
> However, even though using strscpy() does not fix any bugs, it's
> still nicer and makes checkpatch happy.
> 
> Signed-off-by: Calvince Otieno <calvncce@gmail.com>
> ---
> Patch version v5:
> 	Removed v1 patch details from the revsion history

This patch doesn't apply correctly.  It has been white space damaged
for some reason.  Tabs replaced with spaces.  Read
Documentation/process/email-clients.rst.  Hopefully the first paragraph
convinces you to just use git to send patchs and you can skip the rest
of the document.

I try to catch these sorts of mistakes earlier instead of making you
send a v6 but I thought the issue was the v1.  Sorry about that.  The
good news is that now you can delete the extra space character Julia
mentioned.

regards,
dan carpenter

