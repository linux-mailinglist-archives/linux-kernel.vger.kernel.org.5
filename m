Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D087FC930
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346557AbjK1WNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346396AbjK1WNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:13:08 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1174B1B4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:13:15 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6d817ccaa6dso2173531a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701209594; x=1701814394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzkua+PtowZpetcv1vSwzhlAqYyVuNpPQqTrqldHUFg=;
        b=hmQbeZfXpIw4kmeSYtE5EZugAGoYvNLJEKtFoJEjLozQ2DY+Iqzhj4SiHf5dDg28ug
         mel8QZLSdYFOcfWMZ4t1BY4uO4QmkkB7x9pXLAPfSEO1r6WCFFIEGub67+Nql+CovjDw
         b3HUt9PifzGjpjTYwqDdYEUHFexE+pZ63mKPPrpGN1kXf1lX5TFS5ZhF99VLl2hIf5Li
         aDLEIZLVvG1DO3eUO78QLLsa8sAO4Bd6dbgT5sDhHwlmBG0WmCKDG8BpddHRl4Fw2Wyq
         Pux61ZrR5Ng6QIKD5a0NTod3KNNG5tuTfqqwz0B5YhHGUAgeX5MYIwzByRbt5vQeQ42p
         3buQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701209594; x=1701814394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzkua+PtowZpetcv1vSwzhlAqYyVuNpPQqTrqldHUFg=;
        b=vDdHWDWaZukCEWZSu0kzXbEH8oAxaG2kp7FooKbuDKlJavs1wyqALwGCFB/SU33L8P
         hq7rWvNZ4RBBUtxuiNuRNdQBgJKizKTB6Q3jJexIfMtrgz2gB0QSHE5O6dh1UUaScs7L
         61qp/yi5ydQlApIKrfYpGat11JbImNSdUalPHX6TQotesES9WPVuDyByzBBeRi707t4v
         dSDNaAwENdbUyk+YHvTCc82WGhQVxggkwyNFs2Hz1TmHJD6woo30vqzN9aiV5LCCr+mI
         tdKWjwKhTOuTuuUITdJUFF9Kq5DfDOe/5xKLfibqdAgAeA11cnNVqrY3Z2cx14WOg63G
         dWLg==
X-Gm-Message-State: AOJu0YwqDnRoMsSWSkbVtsicyV9pAUUWo6ktotLCzfqSzlr6YRlSlof7
        D5RjQZ63mgLmnxYvGy3+hbQQUWAWK/M4K2ACFlU=
X-Google-Smtp-Source: AGHT+IFbrCgwO30ksnJPK0vfsHqHO0Uot3qklNhA8h4Ae+35H6kZ7mEYmIQO0afjWRq/2USC0OYc3UiMQOZSlgVxD34=
X-Received: by 2002:a05:6870:ebca:b0:1e9:9989:33a5 with SMTP id
 cr10-20020a056870ebca00b001e9998933a5mr23314739oab.5.1701209594307; Tue, 28
 Nov 2023 14:13:14 -0800 (PST)
MIME-Version: 1.0
References: <87edgv4x3i.fsf@vps.thesusis.net> <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com> <CADnq5_NVGS1XykxGxpcu_bpPbzboCUJQkcCF3r+0N9a23KUgiQ@mail.gmail.com>
 <96e2e13c-f01c-4baf-a9a3-cbaa48fb10c7@amd.com> <CADnq5_NBfeAXEyQw0gnSd67=tR-bUKg8w=10+4z9pGGuRnP9uw@mail.gmail.com>
 <87jzq2ixtm.fsf@vps.thesusis.net>
In-Reply-To: <87jzq2ixtm.fsf@vps.thesusis.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 28 Nov 2023 17:13:03 -0500
Message-ID: <CADnq5_Ou-MVVm0rdWDmDnJNLkWUayXzO26uCEtz3ucNa4Ghy2w@mail.gmail.com>
Subject: Re: Radeon regression in 6.6 kernel
To:     Phillip Susi <phill@thesusis.net>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-kernel@vger.kernel.org,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 6:24=E2=80=AFPM Phillip Susi <phill@thesusis.net> w=
rote:
>
> Alex Deucher <alexdeucher@gmail.com> writes:
>
> >> In that case those are the already known problems with the scheduler
> >> changes, aren't they?
> >
> > Yes.  Those changes went into 6.7 though, not 6.6 AFAIK.  Maybe I'm
> > misunderstanding what the original report was actually testing.  If it
> > was 6.7, then try reverting:
> > 56e449603f0ac580700621a356d35d5716a62ce5
> > b70438004a14f4d0f9890b3297cd66248728546c
>
> At some point it was suggested that I file a gitlab issue, but I took
> this to mean it was already known and being worked on.  -rc3 came out
> today and still has the problem.  Is there a known issue I could track?
>

At this point, unless there are any objections, I think we should just
revert the two patches.

Alex
