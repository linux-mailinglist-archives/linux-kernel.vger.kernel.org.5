Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52057783AD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 00:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjHJWdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 18:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHJWdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:33:09 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5337A273D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:33:05 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-583ae4818c8so15934497b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691706784; x=1692311584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCpHARoH+9MHiPabbHy1UHAbff3CHBc6LeMgany2RCA=;
        b=B/MgXjEljKoYzlEzoog+PMECU/8JWfc2RKcCNTZEbmFE/7C3HfVE4Fsa9P1Ve9lf7V
         HyWkP4PcsJo3AGiZANbYnYXi9G3qxK90UhMiln5V0KdU+DcH0umMwJTWmfitjHoxc7lo
         puUcKHDZdiE57vjaDnMWY8vkCIVB4iF5XpqCphZ1yMjyJHaCYUOvO1HuYJ16SwN7SsBo
         9fF+wkY5L0WL9aaCP0JgcB6kzg0EElsddGWayLv6qt9+Bzhohw75H14tt8dFZeOnG+WP
         XsbGDQaNidjAxPJvKfdaNqOByPtj5RiBcrqvFYJN3xeD0FCaESCiM4yKB7Tz2MxzH5sr
         HqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691706784; x=1692311584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCpHARoH+9MHiPabbHy1UHAbff3CHBc6LeMgany2RCA=;
        b=KAUYvWERMp5e8KVv0QAQcupg6PIgLQAZ5J22D+9FVW/wC27cSf3VucOeQneOEz/7os
         ECejiXxszoYl1ziNA0qO2ttH0Ajn8Rnd02HqWVJVF4SpmCPoXWx26dD3yvtCOLwH+uvH
         Q208e9kS6T5iZ/6E2rd9PAiOHayl74WA3QZRnV3nVvH4w5d75bxHE3OmyCCzaQ/rTWNE
         T9B09ce1c/0Hk3havtwovJ0ANh6DEHaaBS9MT9KtgSZXmsz10OOHziZIdRRXIlf0lqh6
         kA8qi4sbMvbk70vttsc6avl8ct1WZcC9GiadoGYj2eYoulWOOXhXfVScAKsTDEp2lXdX
         58iA==
X-Gm-Message-State: AOJu0Yzi0/YpnBG4vmW1ypVHc/n95N8rcKLrgWzPQjr6m+djvIA66Wvl
        dKkFMr/+gjNRSbLOvCpYohFPyRclBkgq403fYDsM
X-Google-Smtp-Source: AGHT+IF9xibU2Vw+cBFrvuHPVQZGps49801VJCLaBifmhPQ3xoeuTJZU5AbBdLG+uxksOghp6j8sj8kaVo2hF87YiBQ=
X-Received: by 2002:a0d:d64a:0:b0:583:fad9:e241 with SMTP id
 y71-20020a0dd64a000000b00583fad9e241mr266554ywd.18.1691706784525; Thu, 10 Aug
 2023 15:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230802174435.11928-1-casey.ref@schaufler-ca.com> <20230802174435.11928-1-casey@schaufler-ca.com>
In-Reply-To: <20230802174435.11928-1-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Aug 2023 18:32:53 -0400
Message-ID: <CAHC9VhQ4ttkSLTBCrXNZSBR1FP9UZ_gUHmo0BS37LCdyBmUeyA@mail.gmail.com>
Subject: Re: [PATCH v13 00/11] LSM: Three basic syscalls
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 1:44=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> Add three system calls for the Linux Security Module ABI ...

I had a small comment on the SELinux patch, but that's oh so very
minor and not worth respinning in my opinion; I can fix that up with a
follow-up patch once the patchset is merged.

I was also happy to see that John had a chance to look everything
over, especially the AppArmor bits, that's good.

Micka=C3=ABl had a lot of good comments on the selftest patch, and of all
the LSMs I believe he has done the most work with the kernel's
selftest functionality so it would be nice to have him look over the
latest revision in this patchset.  I know he is busy at the moment,
but I'm hopeful he will have an opportunity to look at it in the
second half of next week.

Assuming the selftests look good to Micka=C3=ABl, and no one else
identifies any problems, I think we're on track to merge this into
lsm/next after the upcoming merge window closes :)  Thanks a lot
Casey, I appreciate all the work you've put into this patchset.

--=20
paul-moore.com
