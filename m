Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8767E7DEEED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345734AbjKBJcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjKBJcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:32:15 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D59123
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 02:32:13 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40859dee28cso5499905e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 02:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698917532; x=1699522332; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WqxvJKYv5vpdTxmgr1nqq+qFlX0PIIBhjoeGRz1GRg8=;
        b=TYfG70a0/tR1SNRRDyHWbDxTSKBAyrrYQ/TnvRKRFdO91xpdIAi2sFak53ZuuwVVJh
         upWherboAvZ9JQo1dYOSQqAYqd2Ko/2kY9mMNjnJiAaTjRZ2ozpaJ0DGgkK5YoSPlm8A
         rV1XjJm5KCu+Q5ktj4E7cwtDoMId9jMIDHyORXs88iFwCsSA/dubLaZ63epfPqrdTvcp
         dgibMnT93or81Ml1MRbz5RUb83qyzJOjBac4gPUyyIwxKDytl2q8YQZBVEyqrlvzKZfN
         mK9mPPkSFE5z/lkAm6nIqGwNQR0+pbWdY4A3oaOxatLEz0klH1YqPJuXVV6pKyuFeNGK
         k0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698917532; x=1699522332;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WqxvJKYv5vpdTxmgr1nqq+qFlX0PIIBhjoeGRz1GRg8=;
        b=RbTbd+RzJjH6WdtPddJ1qQr6iifQSyqLw5mwXkx/V80TFA9A9wOXMMQqdiRTdsTP7U
         OjZS6xSRI6Vys0W70aLj+jOpC0GdTQJzDYC0XiLQKUZJx5qC1kHN9MOzvpaWNpI1N/6s
         lf/UmQiiuaBIBHDq3HutbCzzBSUg/QmvxnpfHeh70mlMv0j+9rsbc4PJbbVHMGU37ouF
         RH5AOs91WlMrhrwSwHZZaHbHVdSiF7RglFm4bmUr9fhwaX7lU7ihImpGV+o/MOad4AEm
         xrQffVweWwN3TauALm81bfMKVZD2juxBr9DqGTFat53ktRN8lNBro/22kKVzb1PA86Gp
         qimw==
X-Gm-Message-State: AOJu0YxXsMrkJOtqR4AIu6/ywafV2QnWZpmOzhBWGZwrDP4eIACf8ywd
        kXKBtZUDP5YNDDYhTgB3QwdxiowxKTlLxA==
X-Google-Smtp-Source: AGHT+IHc0wpbmRp2tgf8ByRrDxa2IV0hXvaKz5WVhrwURQsV1he73lF5J1ODWGCP4OWwTpvppn7IUg==
X-Received: by 2002:a05:600c:5119:b0:409:2f7:d771 with SMTP id o25-20020a05600c511900b0040902f7d771mr15550596wms.4.1698917531582;
        Thu, 02 Nov 2023 02:32:11 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id z6-20020a7bc7c6000000b00401d8181f8bsm2240311wmk.25.2023.11.02.02.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 02:32:11 -0700 (PDT)
Date:   Thu, 2 Nov 2023 09:32:08 +0000
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Roman Li <roman.li@amd.com>,
        Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "linux-kernel@vger.kernel.orgLinus Torvalds" 
        <torvalds@linux-foundation.org>, regressions@lists.linux.dev
Subject: mainline build failure due to 7966f319c66d ("drm/amd/display:
 Introduce DML2")
Message-ID: <ZUNsmJGbYwgPaUpY@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The latest mainline kernel branch fails to build x86_64 allmodconfig
with the error:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c: In function 'dml_prefetch_check':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6707:1: error: the frame size of 2056 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
 6707 | }
      | ^

git bisect pointed to 7966f319c66d ("drm/amd/display: Introduce DML2")

I will be happy to test any patch or provide any extra log if needed.

#regzbot introduced: 7966f319c66d9468623c6a6a017ecbc0dd79be75

-- 
Regards
Sudip
