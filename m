Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227C37CE2DC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjJRQfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjJRQfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:35:52 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC08BD
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:35:50 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9a3d737d66so7485124276.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697646950; x=1698251750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yg1ixXD9WP2UwFv3eCuFIgDaKeSzuWksYgfLUmtsPLE=;
        b=YyjzUlMVr6NeIBZstb5IqDkkcck+5xjDdyastFAX+IA2reEOf2RmtoKTy2G1G5PXR8
         8KopRCBxuHEPuPBIcqAWqe1g+86RNPddLDwuvPYW1qRNiA/bQO0k9u0BkAok9OC/6wDy
         QKQxpKIjq8f4dqtbJUpPHShIO577inw/fiuT8geddCX5xHrA9gQ+yWS9FQxiRTcrOSOI
         le763e1Fq2N6eHOpaDErlGS6/vKxK7UETnoGUjki13GwCsyzR/RIInWPU43A9JSbm4cD
         FLpZAoBYyGTYu5976WkvHizZRksdf815iH7cfFWToH/LzyYE8TDh+q5JiBjyAvUwMB4v
         VUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697646950; x=1698251750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yg1ixXD9WP2UwFv3eCuFIgDaKeSzuWksYgfLUmtsPLE=;
        b=u6Mind43de+KKMAvXRAwfmfu6ouKR3gOkkdrTMv+G5ezttknYf0+J5XpD/QEZyjw/8
         uo4MeV+YGtFqZvBuweecnpRNSGJcxVf2ERFF/TMGyRDCqvrDIsmZIXXXKevZCC46e2hP
         CemCtcjMQH1154xt9avenFNVTVK4k6DEHnlC+0nUFYtmf6mAsH5tqCLUuavkvWV9yEBV
         55y4FAp+b+l3KoWRM7TVNftfGT82bTtAuNK3q3vVIaR8jySl9NiWlscbeb3TBkjRPhHQ
         HvZmK021oNvfw87a3FJWAzQNuEn3zmJNL00CDg54S0b3Ne8Gm7o1Btq5b13Tq/8Czt6X
         rhpA==
X-Gm-Message-State: AOJu0Yx7qOCTEj3xi7VynmDMwaDAbPOi5FF67SHLWzZLowSw+0kinkr1
        kqp5OA2STWkzceWHBA+PiuwrVSy6843xotDrnMfb
X-Google-Smtp-Source: AGHT+IEUZ6xuw82JyE5izuSckatFgudDKao+ZUtrcCvlVYbpEdBTt8l9Iieigfc86lzMInTlfSG9zwOCz5pN9FOfDmQ=
X-Received: by 2002:a5b:a:0:b0:d79:d23f:b49c with SMTP id a10-20020a5b000a000000b00d79d23fb49cmr5549383ybp.35.1697646949881;
 Wed, 18 Oct 2023 09:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230912205658.3432-1-casey.ref@schaufler-ca.com>
 <20230912205658.3432-1-casey@schaufler-ca.com> <CAHC9VhRcbp3iWQwL7FTUrcU1C3OsZ413Nbq+17oTwW7hZ7XvBw@mail.gmail.com>
 <CAHC9VhSqY5+DR-jXprrftb1=CzDvhTh0Ep66A16RMd4L7W7TYw@mail.gmail.com>
 <ae39864947debbc7c460db478b8abe1c147b7d5c.camel@huaweicloud.com>
 <CAHC9VhRQ7xpeSX7b3VZfzQ15noJ8mgauNMuHWo_n3hMgsYMAfQ@mail.gmail.com>
 <468436cf766732a3cfc55d07ad119a6ccdc815c1.camel@huaweicloud.com>
 <CAHC9VhTjHT-DGKu0=cZPVb=+kMwmbPdr8HiVWJq-yzaDiYk_SA@mail.gmail.com>
 <6f33144c850c40e9438a6de2cf3004e223508755.camel@huaweicloud.com>
 <2637d5294d4a7ae871f1b758f5a30234836e2463.camel@huaweicloud.com>
 <c896c8ed559d0075146070be232e449b6951eb99.camel@linux.ibm.com> <283bf52d-af6e-4d20-a5ba-d98511c2e530@huaweicloud.com>
In-Reply-To: <283bf52d-af6e-4d20-a5ba-d98511c2e530@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Oct 2023 12:35:38 -0400
Message-ID: <CAHC9VhSiUgY1Dzy6LGOjPF6XQ3pVBiZ9LPdcQANNXZ9rj-WURw@mail.gmail.com>
Subject: Re: [PATCH v15 00/11] LSM: Three basic syscalls
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:15=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On 10/18/2023 3:09 PM, Mimi Zohar wrote:

...

> > I agree with Roberto.  All three should be defined: LSM_ID_INTEGRITY,
> > LSM_ID_IMA, LSM_ID_EVM.
>
> I did not try yet, but the 'integrity' LSM does not need an LSM ID. With
> the last version adding hooks to 'ima' or 'evm', it should be sufficient
> to keep DEFINE_LSM(integrity) with the request to store a pointer in the
> security blob (even the init function can be a dummy function).

First off, this *really* should have been brought up way, way, *way*
before now.  This patchset has been discussed for months, and bringing
up concerns in the eleventh hour is borderline rude.

At least we haven't shipped this in a tagged release from Linus yet,
so there is that.

If you want to add a unique LSM ID for both IMA and EVM, I'm okay with
that, but if we do that I don't see the need for a dedicated ID for
"integrity".  Roberto, Mimi, one of you please send me a patch on top
of lsm/next-queue that updates the LSM ID to look like the following
(I believe EVM was added between AppArmor and Yama, yes?):

#define LSM_ID_UNDEF            0
#define LSM_ID_CAPABILITY       100
#define LSM_ID_SELINUX          101
#define LSM_ID_SMACK            102
#define LSM_ID_TOMOYO           103
#define LSM_ID_IMA              104
#define LSM_ID_APPARMOR         105
#define LSM_ID_EVM              106
#define LSM_ID_YAMA             107
#define LSM_ID_LOADPIN          108
#define LSM_ID_SAFESETID        109
#define LSM_ID_LOCKDOWN         110
#define LSM_ID_BPF              111
#define LSM_ID_LANDLOCK         112

... and also update the LSM registration code for IMA/EVM/etc. to do
the right thing.

Also, just to be clear, you should get this patch out ASAP.

--=20
paul-moore.com
