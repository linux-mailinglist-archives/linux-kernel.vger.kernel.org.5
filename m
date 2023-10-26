Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FF47D8659
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjJZP7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjJZP7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:59:14 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576BA1A2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:59:12 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6ce2ea3a944so686625a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698335951; x=1698940751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXVf0I4Mz5SjvG1c0AtJO2LhT3AtAdGjKo7FK2Zg4Ic=;
        b=Q7TxqLm3aKTQC/ar5o37y2qiMsnmUJh60IVOClyeYjJbwpTctGZRO9B5HshK5yqlY4
         kTgWRMIW+qY9Al/sXL9txeJHNnNmC7IDgl/gzlMRw1s9anPdkO6NYcWmOXh8dvZ5B7eP
         k61I8D/CFFGnnqxtO6O+RRmt8Sl0TlaWDnCb4n43x2F4CClpQGJPmMD1V7dKUkENEmor
         fmyKQ9rJ0hf8R8tb6P/tCVe6H07WbTev4kT7J+m8vm5fG+OWZispMAIghVsIe3PpfLJd
         jclU5wD21Ps13HT90/h03jX6k4wYhkQS+o6rhuSPoOIgCCFpV2kqUJuaZ4EBJEFwIPcm
         wnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698335951; x=1698940751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXVf0I4Mz5SjvG1c0AtJO2LhT3AtAdGjKo7FK2Zg4Ic=;
        b=TwfRscDIcCNUYftG06x6p5V5WCG7fCW7I8fG4WMLgqUJZplG/c4nFn1ia6foYAwVS9
         gAMddJgyP6wVbog0/2+ufd0x47TDfd8lHku0/DxjM4KUWPX6V1BKLfOQegyebTaJ4jpn
         xrSr3muTgqiCyUfQmQpU1Ie/50HNDDEBydSUvWoaE+44XSFFf4kH8yFfRjl2X4cLGVV+
         Em9akkH+zYxDLF3DXn8SCEhwFJqHv40vqWH0SyGUhYlpY3w4a+fVZfu9N5Lx3jQwTQkS
         eFpkfywOOX88rom3kMsc6YpXunZ2MV2CZ5LWYUlwu5BgxUk4jMcrdkwTg9pwc0+QkVp6
         Rr5A==
X-Gm-Message-State: AOJu0YwDYbTjva38uGgd7Y3QfIrLoZnuNonRy8CLX90bCVMGp6xm53i8
        LqWsD8gUHJk4mSg4E2Z286aoDZ0c/xqBCPrTS4yX2YoqBekflAo=
X-Google-Smtp-Source: AGHT+IGb4o9qqen65yJYa9Za8Ruc7HjT8pYyYcgd4PHBmG3d3r9sBzWlY55aGRO14AFQloUnfdjPobJ3/vZmMA0zA/s=
X-Received: by 2002:a05:6870:1049:b0:1bf:77e2:95cc with SMTP id
 9-20020a056870104900b001bf77e295ccmr16895417oaj.17.1698335951360; Thu, 26 Oct
 2023 08:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231026090259.362945-1-roberto.sassu@huaweicloud.com>
 <dd0f6611c7b46f3cecee2b84681c45b1.paul@paul-moore.com> <447298d65b497fb1a7f8d47c4f1a3137eba24511.camel@huaweicloud.com>
In-Reply-To: <447298d65b497fb1a7f8d47c4f1a3137eba24511.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 26 Oct 2023 11:59:00 -0400
Message-ID: <CAHC9VhSMVpEvLwWvBCgz0EMEb=DG_AZ7fenVUk5vPM=v5c6kYQ@mail.gmail.com>
Subject: Re: [PATCH] security: Don't yet account for IMA in LSM_CONFIG_COUNT calculation
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 11:12=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Thu, 2023-10-26 at 10:48 -0400, Paul Moore wrote:
> > On Oct 26, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> > >
> > > Since IMA is not yet an LSM, don't account for it in the LSM_CONFIG_C=
OUNT
> > > calculation, used to limit how many LSMs can invoke security_add_hook=
s().
> > >
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >  security/security.c | 1 -
> > >  1 file changed, 1 deletion(-)
> >
> > Merged into lsm/dev-staging, thanks!
>
> Welcome!
>
> Could you please also rebase lsm/dev-staging, to move ab3888c7198d
> ("LSM: wireup Linux Security Module syscalls") after f7875966dc0c
> ("tools headers UAPI: Sync files changed by new fchmodat2 and
> map_shadow_stack syscalls with the kernel sources")?

Let me look into that, as long as it doesn't blow up the stuff in
lsm/dev (I don't think it would), I'll go ahead and rebase to v6.6-rc4
which should resolve the syscall numbering conflict.

FWIW, I also hit the same problem with my kernel-secnext builds, if
you're using those RPMs you'll find it's already resolved there.

--=20
paul-moore.com
