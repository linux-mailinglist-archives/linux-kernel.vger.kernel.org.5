Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14128765432
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjG0Ml3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjG0Ml0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:41:26 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DBC1AD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:41:24 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b7dfb95761so1549985ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690461684; x=1691066484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KQ8BaEVwqYES+Q4z+oRgG6vTaH3aCUtpJSguMpLSeA8=;
        b=JnFFjL0lRw0ORnhk5g51ONshSQkQWoSGRwnnKStzL2tWVOFCk3K9EJ5cF5PON4aBik
         Kb75Lr8hQF1/sbq9BUq1+dgjV4B2GaqXiYFDFp1ROI/Ldsb4KfdW1FyWIx2YQ9ZFxBcI
         7JUgWMb3tFDE52Wskkc6z8Ua38lQUvRJfcE3xIcPorjCsQkFmTlCdsFtUJmk4wwtteFE
         znNLLQemrRnWyhSTIm1yPUJIB4d5v8WINfX1lTv3F/8pzKd5hFPkLi7ie1XqGAUjdrBs
         BEbtgWTwReNupsynKmC4eURGN07UP3G/Y0IluuIsDvhKZ9jZiFV8eYC2bqpMFtuzpUqO
         UwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690461684; x=1691066484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KQ8BaEVwqYES+Q4z+oRgG6vTaH3aCUtpJSguMpLSeA8=;
        b=CqCW3HU1+Ng6HnpZWXDBply0DX9FvnVzaPpU5HMyfdMFhYsy51PSdChX7k5pHbNRUw
         +j+BQjr69SFHHL3nUcqs2IKO1JT0vpWzjwF/lc2K6TIsE3TXZR7LwJ6ER1B3NysMc0FJ
         cf9x9Jpj2GNUgd+Ll0RXHUPmmqIRH4x4MJnNQ/UQFkfJJO50BdgpEvfw95yppldT8mlL
         /0pIEw1tf+URDYW5FvD4o+iqeNldizuL9yLdRSQFqQxhfj0Ipc0bJWC6Qe/0N+Iixj4N
         Y4A65MvQwJqpDIhEthvGNd38XGYK5RIP21MQEo4aA6+YEZbSWaDJZKg1/pqIgQNKBeCc
         riqA==
X-Gm-Message-State: ABy/qLbFax/BXbpNUiZM/yIocrc7n1OiixNd4J3cNZFeugMWIC9Jxou4
        XTAlsvM7usmtCeAtV1OyW42YEw==
X-Google-Smtp-Source: APBJJlGE24013q+4PofPzmhLr3Taz7s5b4o4W1eHagzT+bFWPX/zj2H5Wa+zBbWagDDZ/4srgZXujQ==
X-Received: by 2002:a17:903:22c1:b0:1b8:ac61:ffcd with SMTP id y1-20020a17090322c100b001b8ac61ffcdmr6420934plg.3.1690461684041;
        Thu, 27 Jul 2023 05:41:24 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709026b4600b001bb9bc8d232sm1537974plt.61.2023.07.27.05.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 05:41:23 -0700 (PDT)
Message-ID: <66fe31f1-7f83-8cb2-f093-fd1a03b15c00@kernel.dk>
Date:   Thu, 27 Jul 2023 06:41:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: linux-next: build warnings after merge of the block tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230727161012.752ff71a@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230727161012.752ff71a@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 12:10 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (htmldocs)
> produced these warnings:
> 
> kernel/futex/futex.h:183: warning: Function parameter or member 'wake' not described in 'futex_q'
> kernel/futex/futex.h:183: warning: Function parameter or member 'wake_data' not described in 'futex_q'
> 
> Introduced by commits
> 
>   c8d49e4f6dec ("futex: factor out the futex wake handling")
>   16759c720d7b ("futex: add wake_data to struct futex_q")

Thanks, I'll fix those up!

-- 
Jens Axboe


