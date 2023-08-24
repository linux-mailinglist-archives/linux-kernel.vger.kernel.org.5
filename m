Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA3B787396
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbjHXPFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242108AbjHXPFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:05:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414741BD8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:05:20 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-26f57f02442so2622500a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692889520; x=1693494320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JiozmI8Cx83SGOqAUTYb4WjbXbJdSTEwcACCqiQMyg=;
        b=DFkNxQ2WgmD00dI+dYPj6aE6ODh7ejj6kD+vD3el3amYTH5/aqAi6LIefmDra2QWFf
         WIPQFnWG+TnkrMJGuo1EP8EuLxynObez14ViP3GVRDW4gajcSRV2WRHwi/EcggRd/gSQ
         v94d9M0Tw33Sc+2qlQBkyi32xC1g1cMNPVfr3Yju+IP2EBGVbQOnThpeRc8eCRU4GBjF
         Kv6wG3qXiqIIX7G1CGmzbXd5mLRiwJ8zpUVLtsPZyibPAnzmCS6SnCAde6venbGQWJDH
         nG+QfDEqUJ44Q2JVbO2d6WWcdGjFnmOH84/OsadDF0Su4O3W6HRe2KFPbWhPvGEIlBpA
         71GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692889520; x=1693494320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JiozmI8Cx83SGOqAUTYb4WjbXbJdSTEwcACCqiQMyg=;
        b=HV7LDdNak9ukGudwH1YGVZMUItIQnz+C3J09KW9V7cY8Pd2jWmkUtHb7D9aAHRKEsn
         0bzdN/22ES73uxnlRJJ6m1cirVcitvsW4tcgn6LygUS91tgF0SQQGQwnBJsS5vskHA5I
         wk7LJY0fLOLUht76YMvwQYzXeN6u1o4tvyiMCiGL4ju9IN/ZKpic2TibUV5IcwMTeLvo
         0PlU8GTKFXgIirKCbkfSCldOKan7xeNhixor8VFXL1Wj3GlvKwq6/emwZRQGAaZpckdT
         JGfOVBXK3irQ62u1btRZQ2VDKC/S9X9RQ8e3VQYpUbGT3oevTfqgXNPwFoCWI9IQoGZc
         giSg==
X-Gm-Message-State: AOJu0YzZ0ghDt5ymFPG79tICf+B6xbk+iMOPd3lfGL4dy5V73KENkpGS
        l5HIqUp3Q7HU1JJNOtynLlSrjXfx4BPiZDXlum8=
X-Google-Smtp-Source: AGHT+IEjVuaz2eBKTKtrJkva7vLQeVw9T1ELZG1C3oRrHlp4p/OLPld9I1byQD6LgbSAjXrJO+2zBZG3/2fPSYGj+GI=
X-Received: by 2002:a17:90b:124f:b0:26c:f6d2:2694 with SMTP id
 gx15-20020a17090b124f00b0026cf6d22694mr12373747pjb.12.1692889519611; Thu, 24
 Aug 2023 08:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <MN0PR12MB59538822AA264031D0CAE468B70DA@MN0PR12MB5953.namprd12.prod.outlook.com>
 <ZNL14lnrHvzbpRQu@MiWiFi-R3L-srv> <MN0PR12MB59535434E071499DDE439B08B710A@MN0PR12MB5953.namprd12.prod.outlook.com>
 <ZNogKKZCp12Q92jh@MiWiFi-R3L-srv> <MN0PR12MB5953FFB655A208BD4FA32EE4B71EA@MN0PR12MB5953.namprd12.prod.outlook.com>
 <CACBYKvRJL_WmZUN7BH_TjxX+TC2O1gjsudkh1GtRyB3WifjMJA@mail.gmail.com> <MN0PR12MB59532ABFAF131AC84F36B73FB71CA@MN0PR12MB5953.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB59532ABFAF131AC84F36B73FB71CA@MN0PR12MB5953.namprd12.prod.outlook.com>
From:   Alexander Kamensky <alexander.kamensky42@gmail.com>
Date:   Thu, 24 Aug 2023 08:05:08 -0700
Message-ID: <CACBYKvT6AzupfrHZ58BYM8xi8TDLeppqD+Lt=rf9hfmSew+nmQ@mail.gmail.com>
Subject: Re: kexec reports "Cannot get kernel _text symbol address" on arm64 platform
To:     "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc:     "bhe@redhat.com" <bhe@redhat.com>,
        "piliu@redhat.com" <piliu@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sarangi, Anirudha" <anirudha.sarangi@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:09=E2=80=AFPM Pandey, Radhey Shyam
<radhey.shyam.pandey@amd.com> wrote:
>
> > -----Original Message-----
> > From: Alexander Kamensky <alexander.kamensky42@gmail.com>
> > Sent: Tuesday, August 22, 2023 9:24 AM
> > To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> > Cc: bhe@redhat.com; piliu@redhat.com; kexec@lists.infradead.org; linux-
> > kernel@vger.kernel.org; Sarangi, Anirudha <anirudha.sarangi@amd.com>
> > Subject: Re: kexec reports "Cannot get kernel _text symbol address" on
> > arm64 platform
> >
> > Hi All,
> >
> > Sorry for the top post, but I believe that I might have posted a fix fo=
r this
> > issue a couple days ago.
> >
> > Please check and see if it helps
> > https://lore.kernel.org/kexec/20230819191119.975299-1-
> > alexander.kamensky42@gmail.com/T/#u
> >
> > Explanation for the issue I observed with a similar secondary kernel
> > traceback on arm64 is in the commit message.
>
> I fetched latest kexec sources (777ca453ca69e46f7376b07ba6727bd261ec97ef)
> and applied above patch, a bit improved but still vmcore size is huge.
>
> / # ls -lrth /proc/vmcore
> -r--------    1 root     root       15.5G Aug 23 18:55 /proc/vmcore
>
How big is your system memory? If it is 16G then the above is normal.

The most important thing is can your secondary kernel read it? For example

cat /proc/vmcore > /dev/null

If you want to capture only kernel core out of /proc/vmcore you need
to use makedumpfile
to filter out the rest of the memory.

Thanks,
Alexander

> Thanks,
> Radhey
