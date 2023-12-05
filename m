Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4961804D2D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjLEJFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjLEJFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:05:02 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF40AC9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:05:08 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c08af319cso26576615e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701767107; x=1702371907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EB/Y92v0I9IkLUdwFZ6UBLMNAao4UX9xJXV50Zdq6Ao=;
        b=CQjDVn/VzVRX+tbqF+PIeK7GWYEjABOXW7DI1vh4vkTNb8oYETQa4JgXWlbWewhpae
         IX3MnJkZY5igUN7OWdz3P3gYIdIdlZrIujmx7R4tfuGgX+tXa6nvtrlSO0/Z2AOL6WlR
         Q6xkEkTupAEl+Jr3iVzpSfO9TQ917itnBHxt4SjX5rMYJ312Kpm9M3TCzFUHK2vxe1ht
         pZK6vFTN2dwEZK3G4Zllg7Dr/OhwiC+q9aH/fpZfYL6TZ4Gz+mBqvk+V6ixvCiXEvXNZ
         07t893V+EQ4zrR/FZPhK6q9ggP7Tv3mslClz80DssXJ7ucySFyNVhLKbx63H+SrYXC4Z
         U1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701767107; x=1702371907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EB/Y92v0I9IkLUdwFZ6UBLMNAao4UX9xJXV50Zdq6Ao=;
        b=D4miY8vfGnQoLYp2GLDRrWk/8mti3cDhygv6gsoq8Ze/llmqHg4EW6+xuzdIJfIzWX
         ie/D5tw/twOb+LE2b+3LkYDCDiZTs7Ra2Kng/I6h5G550lg4fGAWnUbqQ0nzxv/NAC1c
         KMmE40M306gtxw+6JbhWFlbQFmahuYzX5No2dMAbEZs9Rg7LP1nFqFfSnbW45Zy1b7oU
         dsfOaiXZnldFrqMwzwykUcx9r8fq5Izr0/ejqVnZwKCikn4MdPPxGZesQr/vetvxQyns
         Fjgzqsv6xvd5wT9gyqehpbQjuU+jxO6wZAuOiOO3zYIB6XW9yMoG/g/bqjZF2RIH26Wj
         65iw==
X-Gm-Message-State: AOJu0Yz64HPt0sYo9tob72q0bP9aJKRhaKwqVC0Fe5Wg2JfJV0yqxn+O
        DDeRpGkHhEVby2iuK82pk9qP+g==
X-Google-Smtp-Source: AGHT+IHzbXwr5ME5OwjDJBGKBmy57k08KuhAPRUBnAvT+jiYCDRow0jaZ3wtgDJkcfuVRBvshGgQlA==
X-Received: by 2002:a05:600c:25cc:b0:40b:5e59:e9f3 with SMTP id 12-20020a05600c25cc00b0040b5e59e9f3mr253482wml.146.1701767107112;
        Tue, 05 Dec 2023 01:05:07 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b0040b37f107c4sm17991122wmq.16.2023.12.05.01.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:05:06 -0800 (PST)
Date:   Tue, 5 Dec 2023 12:05:02 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, lkft-triage@lists.linaro.org,
        regressions@lists.linux.dev, davidgow@google.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: Kunit drm_test_check_plane_state: EXPECTATION FAILED at
 drivers/gpu/drm/tests/drm_plane_helper_test.c:123
Message-ID: <42d85b15-9ffd-4a08-b51e-a3367e57d128@suswa.mountain>
References: <20231204173536.51003-1-naresh.kamboju@linaro.org>
 <rxv7jlfuwjib443pzdepbtgu454gdzemd3ojmmhbnhr4syneve@6me3bduyx2ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rxv7jlfuwjib443pzdepbtgu454gdzemd3ojmmhbnhr4syneve@6me3bduyx2ee>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 09:37:05AM +0100, Maxime Ripard wrote:
> Hi Naresh,
> 
> Thanks for the report
> 
> On Mon, Dec 04, 2023 at 11:05:36PM +0530, Naresh Kamboju wrote:
> > The Kunit drm_plane_helper failed on all devices running Linux next-20231204
> > 
> > ## Test Regressions (compared to next-20231201)
> > * qemu-armv7, kunit and
> > * x86, kunit
> >   - drm_test_check_invalid_plane_state_downscaling_invalid
> >   - drm_test_check_invalid_plane_state_drm_plane_helper
> >   - drm_test_check_invalid_plane_state_drm_test_check_invalid_plane_state
> >   - drm_test_check_invalid_plane_state_positioning_invalid
> >   - drm_test_check_invalid_plane_state_upscaling_invalid
> >   - drm_test_check_plane_state_clipping_rotate_reflect
> >   - drm_test_check_plane_state_clipping_simple
> >   - drm_test_check_plane_state_downscaling
> >   - drm_test_check_plane_state_drm_test_check_plane_state
> >   - drm_test_check_plane_state_positioning_simple
> >   - drm_test_check_plane_state_rounding1
> >   - drm_test_check_plane_state_rounding2
> >   - drm_test_check_plane_state_rounding3
> >   - drm_test_check_plane_state_rounding4
> >   - drm_test_check_plane_state_upscaling
> 
> I found the source of failure to be f1e75da5364e ("drm/atomic: Loosen FB
> atomic checks").
> 
> Fortunately for us, it's already been reverted yesterday for some
> unrelated reason, so it should be fixed in next-20231205 onward.

Sorry, that's a bummer that these patches were reverted.  :(  The whole
episode was a bit unfortunate...

Qualcom has been working on those patches for a year.  They must not be
using kunit testing as part of their QC...  It's some kind of
communication failure on our part.

Hopefully we can get this all sorted out and re-apply the patches soon.

regards,
dan carpenter
