Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46E17CE930
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjJRUkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjJRUka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:40:30 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782A2114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:40:28 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d9a6399cf78so105951276.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697661627; x=1698266427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBX89TOd2XNsREV6sYMesdAWMTbxT15WNrv90h+6g78=;
        b=ZXy7YbZ1cQoQ85IEgJn6bMs73ecSNPeamVrsQCbPQvLSxKjBkbuiPpVgCBgz0XPWE4
         xQY+ZxxW/NxOPdTtGxRw8aYCY8uOG0LT4GI1PvBslEGDlcGDq5M3q9dSy1xGPBJSULP+
         XFArkP9O+D1vzXObAmDGzdxsLKNS3t3jZfLhSEKegWNmz+wVjqf9E9VX5Nl6Y+HybnKl
         jwAdVCqI+Kkv+qGIx9JRIeMvoqQxXIESwDZQ7OMDD8lxZs2KzXLc5S+3Xbm+lRuZAuKu
         NO0J3Ki9gnBK8Q5vH6/NqOCzgFzF13y80qAnh20ZvqB99sMfNf3UHw8T5hfKtpp8LBnt
         q+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697661627; x=1698266427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBX89TOd2XNsREV6sYMesdAWMTbxT15WNrv90h+6g78=;
        b=ZggtSOFHPVIfsny+XrnanlhdafVKXQ6dnb5FxHjx1oM56aB6NqwYANsPtCvfTThdXr
         ezV3QDqxuRtTT1mzJcvoOLXEy6UW7MGC5hRMC/Dho/mA3E+0dlX15jJ1Htfch7UjEbWE
         6g4/168Pg2dIMcInDtFO61KBLHg6Bj6G3jOI5RJh7PQzDZfIky05bMTn4FiEHiE9TIzg
         0NkQSHZrFuBvETbz8yX3JKiWfU3AkBtboO0uohjXUwjU66cRbs2KIGc9U5VzsE9IJl5P
         TVWBux7m+vny1EszNgRn9iyzasdZQEsnUswx/hbXUqkCpjj5mK8H/rYMPQm63w4bHiWu
         Nrhg==
X-Gm-Message-State: AOJu0YziJe8CB39QCEnHXMHTqLwVMnNVLnYvIkqg0lZ4cFnMyaIO8+QX
        ugbqMichOg1cSZTAB0GOzKHMzPHgvi1jRMjGSA4L
X-Google-Smtp-Source: AGHT+IFvWReW4umGMptCXdVoLxvyKYnY8atS/QTLxHeGyisEa9Zy3YvSppV2FjksorUXbkn+U5CwQD1Uwh/uypYMywc=
X-Received: by 2002:a25:bc13:0:b0:d81:5cbb:689e with SMTP id
 i19-20020a25bc13000000b00d815cbb689emr4428344ybh.21.1697661627592; Wed, 18
 Oct 2023 13:40:27 -0700 (PDT)
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
 <c896c8ed559d0075146070be232e449b6951eb99.camel@linux.ibm.com>
 <283bf52d-af6e-4d20-a5ba-d98511c2e530@huaweicloud.com> <CAHC9VhSiUgY1Dzy6LGOjPF6XQ3pVBiZ9LPdcQANNXZ9rj-WURw@mail.gmail.com>
 <80f05011bf9fe19bde1f923e98c2db69ffc91065.camel@linux.ibm.com>
In-Reply-To: <80f05011bf9fe19bde1f923e98c2db69ffc91065.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Oct 2023 16:40:16 -0400
Message-ID: <CAHC9VhSqgAD09QL2n0aoWLK7RGPkkjZHBrDCQmt1p3=ozpdt4A@mail.gmail.com>
Subject: Re: [PATCH v15 00/11] LSM: Three basic syscalls
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
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

On Wed, Oct 18, 2023 at 4:23=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Wed, 2023-10-18 at 12:35 -0400, Paul Moore wrote:
> > On Wed, Oct 18, 2023 at 10:15=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On 10/18/2023 3:09 PM, Mimi Zohar wrote:
> >
> > ...
> >
> > > > I agree with Roberto.  All three should be defined: LSM_ID_INTEGRIT=
Y,
> > > > LSM_ID_IMA, LSM_ID_EVM.
> > >
> > > I did not try yet, but the 'integrity' LSM does not need an LSM ID. W=
ith
> > > the last version adding hooks to 'ima' or 'evm', it should be suffici=
ent
> > > to keep DEFINE_LSM(integrity) with the request to store a pointer in =
the
> > > security blob (even the init function can be a dummy function).
> >
> > First off, this *really* should have been brought up way, way, *way*
> > before now.  This patchset has been discussed for months, and bringing
> > up concerns in the eleventh hour is borderline rude.
>
> As everyone knows IMA and EVM are not LSMs at this point.

Considering all the work Roberto has been doing to make that happen,
not to mention the discussions we've had on this topic, that's an
awfully small technicality to use as the basis of an argument.

> So the only thing that is "rude" is the way you're responding in this
> thread.

Agree to disagree.

> > At least we haven't shipped this in a tagged release from Linus yet,
> > so there is that.
>
> What does that have to do with anything?!  Code changes.

Code can change, Linux kernel APIs should not change.

--=20
paul-moore.com
