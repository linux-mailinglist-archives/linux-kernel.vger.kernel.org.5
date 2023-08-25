Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE50788E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjHYSAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbjHYSAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:00:17 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D26E59;
        Fri, 25 Aug 2023 11:00:15 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53fa455cd94so676632a12.2;
        Fri, 25 Aug 2023 11:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692986415; x=1693591215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dTGOHpLCghqFrKN/eG+RlHSLAI5UV3j2Aq7spVq32nI=;
        b=mDxH8FzC0k8We0/YQN5LGSp11gGbDLEx03QIYAIGfn3uIbh33ngtC+NrcJEnjWPqQt
         gi8RkRoAEwusx+7SlYNoRhmg8OuX3EHwNmLNNdgmj0SVSL2K1jcfRt/iIszeANoqrk9I
         oD/7wy2VZrUtEGq8A+w3pXCMKrUlBAQzx3ghair5yCDe6CmoXPb1kBAaZu/McmdAIsY9
         5m7delawhdwTAid516waO+TmCtTUKmV5OUOCJQhDXufpDmLREJeIF48en8/FOUlWdVA7
         MM0UqzOX9Idu//n1R+AMDrK+hr+XoPaPQL5TY+EA9CXwWmOGzxBo4Q9C4mcdA9G5jI2q
         MWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692986415; x=1693591215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dTGOHpLCghqFrKN/eG+RlHSLAI5UV3j2Aq7spVq32nI=;
        b=Fs1tBT+3turXHA9TCT2NSX9GGJqQXA3WCxu0Stc3R/tzhwYlCISPJ5mJ4dLaEmPRp4
         EG9zR+BtxnDC5r38zwsLWlIi0Vyy6hyzKJ9vEIr052jd6HWLIZww42VyZkUqGSfwTbY7
         iq+4FRr9P8gD4fzGTkPFZjEdXFkAacJd0AdFQ9kXxHozJ8OtR+9c5ztO0T0AKN7Gp1oL
         bgJ8VuBBV9lxBTYcutt2qy87eSahavpUlUJfgOMAq7UbiL/hyfMIFq1R8f18WNTa227s
         tENXaY1XT78bGWoyWn7d/Hpgk6gq8TO2YDw+OIW6v5UbqqqrmbwdCe+Txz0fEX2dq+yG
         xKPA==
X-Gm-Message-State: AOJu0Yz61r7UP9uCk5+RclNIMjZ9rKaDJZfkfXZEQCiJU3ucTcPnhlw3
        t5c8OzVcz6UQxAGL3vnEWLXFU3aGTxDeHlfZtfw=
X-Google-Smtp-Source: AGHT+IGbmnWJ3gBrg1stH0g/5v7ANGHxVRCdm4d42EaMLTJeTb+ZjbwwAZWv91ujsSbmUsfaAxUew0HqmFwF+iFCGpA=
X-Received: by 2002:a17:90b:3b8f:b0:26d:28a8:5880 with SMTP id
 pc15-20020a17090b3b8f00b0026d28a85880mr16340536pjb.32.1692986415286; Fri, 25
 Aug 2023 11:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230824145023.559380953@linuxfoundation.org> <61314350-629a-f870-e203-270d66b13a54@gmail.com>
In-Reply-To: <61314350-629a-f870-e203-270d66b13a54@gmail.com>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Fri, 25 Aug 2023 11:00:04 -0700
Message-ID: <CAJq+SaD=0=MAti0fcif_cGjXi_BBEnswgurZ+ZcRFjPCdkM64Q@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/139] 5.15.128-rc1 review
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is the start of the stable review cycle for the 5.15.128 release.
> > There are 139 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 26 Aug 2023 14:49:55 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.128-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
