Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBF97B2A83
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 05:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjI2D1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 23:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjI2D1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 23:27:49 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8575D199
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 20:27:47 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-691c05bc5aaso12019869b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 20:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695958067; x=1696562867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KtntkVvW66DKYrGtJ/jS2FGAG296faVgNeolyBQMZE4=;
        b=Dl+CFExBKY00RhiYj3nXl3CeJr7DjSDLWJ3Dc5UtQ7qIrKWxHYNFSfpkNhQoPsYb7F
         EPvFTLEPPgVTMGSmQpfm024rX907pyGDAdaRLTrHWOzYT1Lz/AWqKLmfPJkxPefodHb6
         Vr1jJ8yv5L1k3VmX8qLHVvSSL6J/TtDPB5ESRToz+Ev79Z8nxy/fqdnD8+DGEVE9odaR
         mhT8l0yVEvFGX3AY082t9N2AMXDmFZA91g/1vzZk1rZ0ovLiimWFX7stn2YS/WgypgoV
         klEJ/DXNlI82mFJz3WnBegIfSiE7Xf06hj2z/+v6joh3quSgGfW3Vz/jfIFOInjMVMbp
         UNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695958067; x=1696562867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtntkVvW66DKYrGtJ/jS2FGAG296faVgNeolyBQMZE4=;
        b=jr5s81wmwBOiceHAMxTwVyYEUORScxr7J81NCfv+3xVq1+65l7YAroJpHQFjQwIR6e
         DHjLtCIszPNbXr4PX6JMUKA6JJFh3lC8rcuIQ0xwavix6/gMV1vWl8FdKlZ+NPge6CTZ
         8BT4OIN9l+04YOV9sJGqjAc4ympJsSyCYe7phkYx0HfQlkRLo/BcxD2i8gaQe+kMH7gz
         /WgWUt0sefVFbLRv5T7ioOmIoFi4Auc+rxCO8bptXGEfeIb8Tf0f0eUZ/oTxAG6kHfPw
         BmrgFpyzenIOj73j0+pEbAEERZWZGB3cc8wylpe9+z43HUfZS2Z8v+3GiIcweTxLmLHh
         U4/g==
X-Gm-Message-State: AOJu0YzDldRNokZZbwYFzTND0gaI43QbMC+lwICM5x1wsacZ7aaEWpXd
        puM8npUu05BGH7K/5ngWDTT1qg==
X-Google-Smtp-Source: AGHT+IHA0pjq1wR/idEN/HmG6zHuyo1p8a1DhpezWwunN8VWYsqT4nn0S44N1xLcBNWCL8iKV/4ebg==
X-Received: by 2002:a05:6a00:1394:b0:68f:edfd:2ac6 with SMTP id t20-20020a056a00139400b0068fedfd2ac6mr3817336pfg.0.1695958066695;
        Thu, 28 Sep 2023 20:27:46 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id w18-20020aa78592000000b0068890c19c49sm2662332pfn.180.2023.09.28.20.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 20:27:45 -0700 (PDT)
Date:   Fri, 29 Sep 2023 08:57:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        vschneid@redhat.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Rebuild sched-domains when removing cpufreq
 driver
Message-ID: <20230929032743.6mjcyyx3cmjjxsix@vireshk-i7>
References: <20230918112937.493352-1-pierre.gondois@arm.com>
 <20230928071810.hkdmuoaasrv4b2oq@vireshk-i7>
 <93262faa-7089-f2a2-3df7-058c338adfc6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93262faa-7089-f2a2-3df7-058c338adfc6@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-09-23, 14:49, Pierre Gondois wrote:
> Another solution would be to call sched_cpufreq_governor_change()
> from cpufreq_schedutil's init()/exit() callbacks. This would make
> more sense as EAS/schedutil cpufreq are tightly bound, and it would
> allow to cover all the possible paths.
> 
> When tried locally, it seems to cover all scenarios:
> - insmod/rmmod a cpufreq driver
> - changing the governor policy
> - offlining all the CPUs of a pd

Right now it is done for all governors. We don't need that ? We just care about
schedutil here ?

-- 
viresh
