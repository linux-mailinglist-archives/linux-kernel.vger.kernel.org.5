Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E8F7FC2C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346155AbjK1Oai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344930AbjK1Oaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:30:35 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C1218D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:30:42 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b3e7f2fd9so27106285e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701181840; x=1701786640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JLEYkHRJMT3OqT04CWYEA703zQvHqSolyT21WNnk3PQ=;
        b=kk1oN1+bs1cG4aqWZBjIaf9UKfbUiexxIfb2ZQ2mAoKzfFeUbmFTOeQcykTgA3EtDA
         LjyxCgdmwLXtCilDCcCD0EdMkNV60NYErRuSgrOLbGZ5WeISjHyUsOMkkCY/LuCahNjY
         LKK9wnkvL0fOL4Qw16UN9rFPWWB7aNW33vyi91Q03CYmlNN2zncAvRkBEVl+ewk10sfq
         DgY59bJkmsyDQsLikBhcStJuyJpR9yhTxyaTBgkO1M8HFt5vojON8ZPRznlQTM1ygc4W
         02CQJHwjYFbPNVWbGjViFZBBTe8YKBxeaZjMzPPvhJ7gU1KmakyMbGFBDPkpUAFJEHTG
         7FxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701181840; x=1701786640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLEYkHRJMT3OqT04CWYEA703zQvHqSolyT21WNnk3PQ=;
        b=vJ4sKSqvP6tshqGY2pqaQdDvA+aSwlAub0vSZ/kaOT4UEHowj9g7R399XYk2zapA50
         lSeY43O0sFf96X7Cch/YbbIkHMLPEHcZ8n80zx4U5Rz9GiKo7pxy3gKJkhNzVI/3ZpdF
         GsuAKF4zfDU3Itq2iw2IOSUDdUuj0e60PGKoHdbzsK/Og4hR2pTaiQ+rEA9TWu9ZMfzP
         pRjN8HVP98U7lY7xEvHO5gLsInPqdbkWIyZhlo8mL4O1/B3DFskWJZtlX2li/dOagyeD
         9JYy4uem9XvAQ5lUpvtwu9vxRfmgfM0Mzdc1sssYL+BOcgVYcWTuSRZBYsQXj5TWlHO8
         xEow==
X-Gm-Message-State: AOJu0Yw7TCz0AsEAz95YY6s8hDS8ygQbryuiERwqXSCNbSpMnWGgc0ql
        xiqXEEjxhnaCP0ngoZfQz2LELw==
X-Google-Smtp-Source: AGHT+IFRSBdeNgBVBzXbX04M5CydoBRX/3/68FCyYlI2YkiakrnnEFYTLggv//rdjN95vH2IOP4Azw==
X-Received: by 2002:a05:6000:543:b0:333:875:27f6 with SMTP id b3-20020a056000054300b00333087527f6mr2795165wrf.60.1701181840487;
        Tue, 28 Nov 2023 06:30:40 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f10-20020a5d568a000000b00332f95ab451sm8493636wrv.58.2023.11.28.06.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:30:40 -0800 (PST)
Date:   Tue, 28 Nov 2023 17:30:36 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Gary Rookard <garyrookard@fastmail.org>
Cc:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] staging: rtl8192e: renamed variable nMcsRate
Message-ID: <acc04154-6604-4cd1-a6cf-58d89d6798e0@suswa.mountain>
References: <20231128142027.15617-1-garyrookard@fastmail.org>
 <20231128142027.15617-2-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128142027.15617-2-garyrookard@fastmail.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 09:20:25AM -0500, Gary Rookard wrote:
> v2: Renamed from CamelCase to Snake case the variable nMcsRate, and
  ^^^^

> additionally removed the Hungarian notation of (n) that [v1] did not.
                                                           ^^^
Delete this stuff.  We are not going to merge v1 so we don't want to
mention it in the permanent git log.

> nMcsRate -> mcs_rate
> 
> Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
> Driver/module rtl8192e compiles.
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is taken as a given.  Don't put this in the commit message.

> 
> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>

This commit message is kind of bad.  A better commit message would be:

"Checkpatch complains about the "nMcsRate" variable because it is
CamelCase.  Rename it to "mcs_rate"".

There are a bunch of ways you could write the commit message but my
proposal is acceptable.  If you want to mention Hungarian notation you
can.  "Plus it's Hungarian notation and Hungarian notation is rubbish."
but that's not necessary.  If you're going to rename the variable then
we just consider that you're going to look at the context and the
surrounding code and pick a good consistent variable.

regards,
dan carpenter


