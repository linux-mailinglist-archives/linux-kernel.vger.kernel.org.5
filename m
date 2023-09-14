Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23157A0E52
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239657AbjINT1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjINT1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:27:34 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4034226B5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 12:27:30 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76dbe1866ecso89591685a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 12:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694719649; x=1695324449; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgN4WCvEJ8wWXRweLBdinmd4ZI7NWvgRKKEqbKZQ8K4=;
        b=ObH4GV6HWcaqilG+6j8/TWFkjrGRr5BIQ5N0mLEhnBmfVym3SYgxW+m1GOdw6DB5AL
         6llW30QDiyYb2ojOlhhwAC8xSTnkm6WGJzqI1pwD/s2UNp/hYG38gwLPNRiNVI6tiLh/
         W3eOMVVANlesdZEG0ATsj31iMPDXro73/Dm2HifMjhIbnXUOknTlRjT/bVf49D0mzstl
         aMMaewB84f/Wl4ySr8BqCe8OjrblFpkhkcGnOA8qr+gUQ2xjH7Yth8eMghs3rLu8o/wy
         X58uk0J/kxCm83Wl2R08U8DUxkfBs0jgcNfqMe1ekq/1926bOk86OypgdRAIj+T/PwWj
         Ayrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694719649; x=1695324449;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgN4WCvEJ8wWXRweLBdinmd4ZI7NWvgRKKEqbKZQ8K4=;
        b=dPpqQEaBzW0twMtfsM53Fio0A9wJidPt0UU/pu5FFfPCnGb+fAEZg5mRjq0CL3U8Z+
         k/YXDMsIregsIEmo/pmoWgFgcHbos75AWFMNs5nfFgpuhKwQJeNKgZTjZE+DGvhEKh1N
         qXcqpujCzyEjnF4unEZFy4MwFUcQSrxIH4ilXUIrc+koq6qeU/pEaB80r0O9preFxgnN
         wUdiUGqdMG+asZ3XuPi0rOIvbixI5CUh6vRX3Q4E6lnsNA/l/lB5M5z6AaCkyM79y2sd
         XG9ClqiQjzQpERRginhZVs1m4YLhS6xP4Kr8zVvZ3FcWHvtyFz1rWkNNFczYogio0Dh2
         fuCQ==
X-Gm-Message-State: AOJu0YzTrGOQf9UQLbVOFmXKIpeeMyWAXpIZjy2+HWgSlSzVci0UrfS8
        7TPFe9Ff+vR2Logrumose0UT
X-Google-Smtp-Source: AGHT+IH/m5H1VoxPInjdFLJZV1oHAFDb0GkezDRGraHnDv5FGgIiQcSe7t9i8flET4V69d2gupot8Q==
X-Received: by 2002:a05:620a:d82:b0:76f:1eac:e720 with SMTP id q2-20020a05620a0d8200b0076f1eace720mr6189920qkl.25.1694719649320;
        Thu, 14 Sep 2023 12:27:29 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id m10-20020ae9e00a000000b0076f35d17d06sm684548qkk.69.2023.09.14.12.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 12:27:28 -0700 (PDT)
Date:   Thu, 14 Sep 2023 15:27:28 -0400
Message-ID: <c1b149b8a7d35ed3b5da3b17f38547eb.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        ztarkhani@microsoft.com, alison.schofield@intel.com
Subject: Re: [PATCH] lsm: constify 'bprm' parameter in  security_bprm_committed_creds()
References: <ZOXAaHDqesqQXaNi@gmail.com>
In-Reply-To: <ZOXAaHDqesqQXaNi@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 23, 2023 Khadija Kamran <kamrankhadijadj@gmail.com> wrote:
> 
> Three LSMs register the implementations for the 'bprm_committed_creds()'
> hook: AppArmor, SELinux and tomoyo. Looking at the function
> implementations we may observe that the 'bprm' parameter is not changing.
> 
> Mark the 'bprm' parameter of LSM hook security_bprm_committed_creds() as
> 'const' since it will not be changing in the LSM hook.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h | 2 +-
>  include/linux/security.h      | 4 ++--
>  security/apparmor/lsm.c       | 2 +-
>  security/security.c           | 2 +-
>  security/selinux/hooks.c      | 2 +-
>  security/tomoyo/tomoyo.c      | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)

Merged into lsm/next, thanks!

--
paul-moore.com
