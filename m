Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A1779F4CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 00:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjIMWNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 18:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjIMWNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 18:13:10 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF96B198B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 15:13:05 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41215efeb1aso1577901cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 15:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694643185; x=1695247985; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2p17mow8jOToGHzl/reGSy5sg/JPF1WcbOesSQaNA64=;
        b=Fbb5HPISxCDtWGpl9r3GRmDhaUeVYIxqa/1sg3oUyaCODR7H7YtjdVKfm5TgrSdI2W
         CYQjkRmu1bdtMzeHAnIfXefzKarvguH2nD5PWKaIcVDe5VxHuJM7OHMNhVIblIJSe0Hs
         XFTGtdCC10260Pg255cABzIPiQUxPG2E2WbCB8Gn8i1Nu8uI6XKWipqGAOmlO8jZ+GM4
         t/dGefIWmD4X1OUL6UkoNcrM6QjIykoAmgnUXdYEfn2JxFFoBM5Gu1twISGfZKpyNfkQ
         Hdqt4L4TG0QqHzm+iuKmAI53+ytfdMUWr3lN3RoI0zhS+W8GzswF10JomlybLIs10mP2
         seeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694643185; x=1695247985;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2p17mow8jOToGHzl/reGSy5sg/JPF1WcbOesSQaNA64=;
        b=ThlS6ady6NAUxAaipm3WLIQ/61BgHSHxDgYLUDGW+t4QR3tKhAEq1s1Bu6v9/VCVM+
         yhMpbGlCpisPbwUQILeroma5cigSYi/8CSAQiYSTNUc/Jtm6mKWazc3pllw06V6Wyfgr
         gULeW+nkxeD+vCQYAdQv+rQQYsIk8xypRWOZbQ4USzIJlybIvx7oVnQ6rH+qcww6ojUP
         cTyqvuapQMOA0rWUkYKe4pj3U0sbK/+kX3otJfc7KfPWbySqi/YMqgpAtpJT2XXFc7Vr
         4xNoa42WO0K9iHO3Tm5pOPVKXlxY9NTAxQ+2Q9jxirBy3shNiCZqRFNhbT9t+ucflV/0
         10Qg==
X-Gm-Message-State: AOJu0YwVa7lo7EVFRra7f6somsoLmfCSFqt4YOXT4pYks1RPXy6jSqIf
        DaXUdiVGGME5kYlquUby62Irodw+91WR12b+Nw==
X-Google-Smtp-Source: AGHT+IF2ufzmX0mgSW8tYUOIhjgdVWAPVJoSNbm23WjMTFdbfD9qge9HiUsqmQYmCws2E0YhK7FVzg==
X-Received: by 2002:ac8:5e49:0:b0:415:15bd:94d2 with SMTP id i9-20020ac85e49000000b0041515bd94d2mr4259821qtx.43.1694643184892;
        Wed, 13 Sep 2023 15:13:04 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id m4-20020ac807c4000000b00410ab3c78efsm73610qth.11.2023.09.13.15.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 15:13:04 -0700 (PDT)
Date:   Wed, 13 Sep 2023 18:13:03 -0400
Message-ID: <82e3a9c95fdc838943802d9a22d83aa8.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        ztarkhani@microsoft.com, alison.schofield@intel.com
Subject: Re: [PATCH] lsm: constify 'bprm' parameter in  security_bprm_committing_creds()
References: <ZOW5rC1MngXvPQLz@gmail.com>
In-Reply-To: <ZOW5rC1MngXvPQLz@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 23, 2023 Khadija Kamran <kamrankhadijadj@gmail.com> wrote:
> 
> The 'bprm_committing_creds' hook has implementations registered in
> SELinux and Apparmor. Looking at the function implementations we observe
> that the 'bprm' parameter is not changing.
> 
> Mark the 'bprm' parameter of LSM hook security_bprm_committing_creds()
> as 'const' since it will not be changing in the LSM hook.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h | 2 +-
>  include/linux/security.h      | 4 ++--
>  security/apparmor/lsm.c       | 2 +-
>  security/security.c           | 2 +-
>  security/selinux/hooks.c      | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)

Merged into lsm/next, thanks!

--
paul-moore.com
