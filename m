Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C4A76AB57
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjHAIwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjHAIwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:52:33 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933C0170A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:52:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so42812435ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 01:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690879951; x=1691484751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sQb6hWeSHt5AzlUqNhh20pk6zYPdhyIHacjYa5WcAVw=;
        b=fShC8m0sAxSzyfBCOQCftRJtjAugW5Q74CK11/6Z/7aJGRUOP1SjNs5C6yvXEnrd3F
         mC4jmWHzDL3Ii05rpo+SZAYNLkZNazAf9vHoPd59ZBsz3xxQZG+kJD2/Tufvdv0Rj3H+
         l4eCSo4x839DYlntSH5tJza/polLoi3/uKRyBTq16Xo2iadb5gSl+UVAaolJoyxHO+8n
         5Al57INR4QTnBf/tVo0V8g1Ni8EImtliXIE5IFU/geNc4XqrStasiHUv/6zTHMn1+J0H
         I2trapnK3BJ+/YZwAwcEznbSZqxOgQ1bdvOucnv8AroAR7bdUDxR1CieJe0S2a0L0AaT
         EBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690879951; x=1691484751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQb6hWeSHt5AzlUqNhh20pk6zYPdhyIHacjYa5WcAVw=;
        b=hxd3N2oEaslrcg8xO24XGoJJpa+9IO1mhC9DzrkYseQrmX0FxgJCHU9Fxz6bJFHFMh
         RrHYmKN+pkcIJJ34pR7jNT52TtLqVgPPZ6tFhxIAtcrK+BMcCLS6EVZxoyatFQpJEa7l
         pOwiB0fLSTvPrxdCk5BbdGeAJClAyrkXBSzWVnP5oMrwEsQYxRnVqoGMEyNG4X/rbjd6
         0G+omexrNErJKYCxr6q5z2KzbofBP1WRl1k9Y2AlPlS8y4cVMXHAF/BBpN2COLU06+uh
         xDVuqNyfYLXZnqisBiZ9lD+sQn/tV5IdWhwEDzNyc/3blbSed0+6A584LNEIDVOPrz3x
         k6/A==
X-Gm-Message-State: ABy/qLaqioNrHlysqAYF1Rmu4AfM30RvxL0JWnpXyBaX0KXn9kmUZQAl
        Ocv/LE5CsLCjrFS5QNacGrrktg==
X-Google-Smtp-Source: APBJJlH7sFdfOCMX1cyHt9oMrKnAymfqE4PzBGrcLvsl3aP7Bhi9gwsVgnVM9S3nmr9v7kjQ0eNA/g==
X-Received: by 2002:a17:902:7486:b0:1bc:5d0:e8db with SMTP id h6-20020a170902748600b001bc05d0e8dbmr7361705pll.62.1690879951085;
        Tue, 01 Aug 2023 01:52:31 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id b11-20020a170903228b00b001b8943b37a5sm9942580plh.24.2023.08.01.01.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 01:52:30 -0700 (PDT)
Date:   Tue, 1 Aug 2023 14:22:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Meng Li <li.meng@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Modify the function to et the highest_perf value
Message-ID: <20230801085228.6f5xley3aybryfjv@vireshk-i7>
References: <20230801004719.1298415-1-li.meng@amd.com>
 <5b92239a-4255-346d-1dfe-c7953535083d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b92239a-4255-346d-1dfe-c7953535083d@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-07-23, 20:10, Mario Limonciello wrote:
> On 7/31/23 19:47, Meng Li wrote:
> > The previous function will be deprecated.
> > 
> > Signed-off-by: Meng Li <li.meng@amd.com>
> > ---
> 
> This actually has functional impact; doesn't it?  Can you better describe
> the reasoning and expected impact in the commit message?

Also write the $Subject properly like:

cpufreq: amd-pstate-ut: ...

-- 
viresh
