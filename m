Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6B07A0E68
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbjINTfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjINTfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:35:41 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B01826B7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 12:35:37 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-770ef4d36f2so86972485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 12:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694720136; x=1695324936; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bhzt7woUu7b+LnfC6SMihfQRxp2ROfPzJT4I0mUPjCU=;
        b=SouEFi6Pa8vVFKo4FoE2TYQdM/SBebI+6NNJ0k9OlepaFMqnqPCvpXPKqyk31Yga+h
         oFpxOqcFifRufbYtnrPDQR1al+vaGWD7yprk3r7NKKZAR8avw9E+345hw8KzAdEc/e70
         p7FWngYzF6qPN5uAbiaALJ1gYXSSqT+CrWPSn9PImSwQ8fxMm/WnraGkPxTTAUIxiMWj
         6HM2eDU8d2yjuTH/Jw+UoRS42C78N/gsjXCtKjC4YSIKokYOoS5cN2JSRDXRmFrFm2lM
         xKxcO0Qsj1WWdMIw1UHOGjiqKYq1UxpRNHR+yW5yGrpePZ14DS7QhcR/qv8JOrbXNNvk
         mB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694720136; x=1695324936;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bhzt7woUu7b+LnfC6SMihfQRxp2ROfPzJT4I0mUPjCU=;
        b=co9PIG7wCZmBsYQBpB0giofr9K5baehYKE4bCbaD93MjF7ZcqPkVMHI8CQGfEQTwHy
         ubq8OTWCscWaOCoCgRL7EnjLbMmqJ/aR071KCztikvJ7kNKTsODOcLM0opyw1uH9qfp1
         UObtTO1mlKGioYDEVraVBKG7HbOzbN0xqXogeGwfOrAbVEjieWdwZ74yVJt8wJodPZW7
         +0ONFXTPbj3qVGuhzXhXfAh3r3ZOhuWJgxsMJeyjbXzyCN2d13e1i/J9u2QXg7B5QhAb
         vR0OHG4CHF9vQhhk/jOviPesTwOxJhNiJyKdRNxJyvoNi+teOZr5uY2v5wYXO0k4mxqt
         Au8w==
X-Gm-Message-State: AOJu0YwR2QRz3RObXrq3Ap8vvSalSWlQKFg0CY8jGZQSy6uUUui/AN/P
        Cw3M2n6endTv8bU0Hi7JrRs+
X-Google-Smtp-Source: AGHT+IFf+Btkyt3Zj3w+He3Gu0o8QU6bctV9HMlyovOVbOfHa4yuylmXr8fH+j6V8C936k23RSue5w==
X-Received: by 2002:a05:620a:4728:b0:76e:eeaa:a06e with SMTP id bs40-20020a05620a472800b0076eeeaaa06emr7273564qkb.4.1694720136248;
        Thu, 14 Sep 2023 12:35:36 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id p9-20020a05620a132900b0077241440be8sm692552qkj.7.2023.09.14.12.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 12:35:35 -0700 (PDT)
Date:   Thu, 14 Sep 2023 15:35:35 -0400
Message-ID: <d9054dab0a970c154c46bb48bafa2904.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        ztarkhani@microsoft.com, alison.schofield@intel.com
Subject: Re: [PATCH] lsm: constify 'sb' parameter in security_sb_kern_mount()
References: <ZOXK6MywWFIdUTsr@gmail.com>
In-Reply-To: <ZOXK6MywWFIdUTsr@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 23, 2023 Khadija Kamran <kamrankhadijadj@gmail.com> wrote:
> 
> The "sb_kern_mount" hook has implementation registered in SELinux.
> Looking at the function implementation we observe that the "sb"
> parameter is not changing.
> 
> Mark the "sb" parameter of LSM hook security_sb_kern_mount() as "const"
> since it will not be changing in the LSM hook.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h | 2 +-
>  include/linux/security.h      | 2 +-
>  security/security.c           | 2 +-
>  security/selinux/hooks.c      | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)

Merged into lsm/next, thanks!

--
paul-moore.com
