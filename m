Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F50A7BD904
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjJIKx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjJIKxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:53:25 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CF18E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:53:24 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690d2441b95so3170337b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 03:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696848803; x=1697453603; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hjpz99pKtSDqY7Lxx2Kmyl5doNN9PYMFGMw6h35LBMc=;
        b=ReJNSlkCuggCd/FzGsRpccgFGTUe6NpOXYIR60xfamDJl/s5UyZsQqbDHTZmAY+bVh
         f7rbYI6+P3mFoMYZgbFRH9rwLiCqMOgS3jXMRlEjlYmywjS0bdXENsX0wsTnMKWSqR3T
         d1uF5baFYfbWgGZk0OLy/ImEZiuYpjCMx8/1UlA0Wk8gESCdPtjNnyEDKztJ8WpFeJSB
         oWhkJ/tO7L9sKjFvvn3HDmTAkKA5MyZzRXpqvvGA4Qv7T9hAF6eYA24x958ER1OBUK54
         nwIX/RMuUAKNhvKurPcslfm6uQqXKzQFWt3cu/eGEQv3lRQkGs/bvXTps5TF38sqHiFl
         HlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696848803; x=1697453603;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hjpz99pKtSDqY7Lxx2Kmyl5doNN9PYMFGMw6h35LBMc=;
        b=MkpuuMBMADAJRWjwJcyvX6fOu5LAJM/02vtXvmyoDFYWINd1PfUx1DucuL+BsgRcnU
         JF2T10ym5aD2h91IYFWh+HzEcPRY+DSZ7Aids+d+QU63vrda4BcbjQVl3EWcatlxrmgo
         /1McHHLqWI6Q90/z5iFIcJ1UGw9NIegvpUYIk9W2/5W/H//hXiczyt1L6AbrFysWhE/B
         ng1FOzfVCnXuIvaSQHXU8r9sm9PXZj39iF64P9IVPxxUv8/eN7MI41u9mbPXsR8orQGT
         VudVZk8Dj6l2Sd+ZXpOSxMPV7+asb8fr5FDsZHuQxaNlK3uYEF4USTrfkeTW9KxJG5YX
         rT/A==
X-Gm-Message-State: AOJu0YwXSgsg7S61L60BYSRSUkhHPwTDUTaH1PbGJcCDkOQz9xupl7pd
        QYUHozqg/k+zhtCEDVorVGIErw==
X-Google-Smtp-Source: AGHT+IEVfOR4NoAnaSIGgCYioI/Xey27e7ZEqzjGtmASnTwitAxG2F2Q7OoKyuVPHInKVZV5l5+DIQ==
X-Received: by 2002:a05:6a00:cd4:b0:68f:c1e0:a2c4 with SMTP id b20-20020a056a000cd400b0068fc1e0a2c4mr17399432pfv.3.1696848803584;
        Mon, 09 Oct 2023 03:53:23 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id g2-20020a63ad02000000b00584d035c08asm8018705pgf.24.2023.10.09.03.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:53:22 -0700 (PDT)
Date:   Mon, 9 Oct 2023 16:23:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 2/2] xen: privcmd: Add support for ioeventfd
Message-ID: <20231009105320.scljokj4ies2s5r4@vireshk-i7>
References: <cover.1693311370.git.viresh.kumar@linaro.org>
 <52b07a3861a34fb0deb6251bae8bd885815c6944.1693311370.git.viresh.kumar@linaro.org>
 <fb79fa9a-e91c-4bb7-8aee-c384b99df953@suse.com>
 <20231005063231.vqwhfnlc64phwmto@vireshk-i7>
 <877cnwqg27.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877cnwqg27.fsf@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-10-23, 10:40, Alex Bennée wrote:
> I thought generally sync points act as full barriers. Doing a bunch of
> grepping I think ends at:
> 
>   static __always_inline bool __mutex_unlock_fast(struct mutex *lock)
>   {
>           unsigned long curr = (unsigned long)current;
> 
>           return atomic_long_try_cmpxchg_release(&lock->owner, &curr, 0UL);
>   }
> 
> so you should already have completed your writes by that point.

I am not sure if depending on such indirect mechanisms to implement
barriers for you is a good idea.

The situation here probably requires explicit barriers to make sure it
doesn't break in future ?

-- 
viresh
