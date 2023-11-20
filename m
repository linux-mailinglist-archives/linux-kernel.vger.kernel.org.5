Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18667F182D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjKTQJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjKTQJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:09:10 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE55100
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:09:07 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6d31f3e8ca8so2783587a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700496546; x=1701101346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2oEbSauGOHvjZGkANky2osMy3LrJnK1DvMlgtxNIqU=;
        b=NX/hYXuCNZMf/W5WUP37PvNmf8zRmqkKYOwcqLnRsQRnC9fTsfjLIpmWu4v6iiQyqQ
         yeNbLQ8M65l6o/WTVY+ydd008IqaFTIL4lJnAUb/4xbNixO0UOZ5ps52WT50ejLYRe9Y
         vGH3eHrzV0FwgGKzRE4xipT1oBGkIHYjmBk7Rt60f2NmhrAlJxLTilWLHO0xt3zB8YRp
         Y2GLeXpXZ0wPO6o/vnoIsahPnlZulGZQaDyi8D6gs8tRmskXLqdMm8P7e/LEuAPSwJYk
         SY8bButSZ1MJFS1KcPFTiF5oS4FVcPYXiLhRhgPwA3rySQoqZ48sMcuaKWs8idP8YUAD
         ZbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700496546; x=1701101346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2oEbSauGOHvjZGkANky2osMy3LrJnK1DvMlgtxNIqU=;
        b=ODiz+v2oUJuxpD6oUhOoFjZb7b9cXmYRoj9elGYQkUYoJCpeGUsPw6oVKFE5cE1z5W
         V5ILCuXz/cknR/YaH7apX0xpLL74Xmn+T1/nsvwCjd2zQZ6w282qWd/JUkF5JodtPqzP
         +VSZHOuXCFugsY1BXK8SgNOK/JTNVcbz1zQjXFkRsNGvfJQGZSucHqtYZr7FBNIP5DWD
         /Yf5MvyK3nvJBuS6uVusVLegVYw/IBsKwraIa7iEIJms4oNArn2iDZT25TQFiQEg8uS1
         PN63nZA74XwBfzUGacV4vLRFov2m2bvXUjCnyOsCYGwvYuIVr0LLzpu5PdNJgF0EK3x8
         jVyw==
X-Gm-Message-State: AOJu0YywDkCh78Xz9juQl0GTCw+/uY1MCrzFhqwDw7piNq+iktEgiLHW
        zWIV4qQrvopbkLTQ26wfskZYi95dhbeSdLhXSWePAQLO
X-Google-Smtp-Source: AGHT+IEvbqXG00KL7aQO3Yc9jfLXnQj4XWLXSx/JaniG8N/Ocl9GUeaAS9Sx0btCzaUWmAP3MwcAMlhcoTbsFJ35TUM=
X-Received: by 2002:a05:6870:7987:b0:1f9:34b3:7ae9 with SMTP id
 he7-20020a056870798700b001f934b37ae9mr4808940oab.17.1700496546587; Mon, 20
 Nov 2023 08:09:06 -0800 (PST)
MIME-Version: 1.0
References: <87edgv4x3i.fsf@vps.thesusis.net> <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com> <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com>
In-Reply-To: <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 20 Nov 2023 11:08:55 -0500
Message-ID: <CADnq5_NVGS1XykxGxpcu_bpPbzboCUJQkcCF3r+0N9a23KUgiQ@mail.gmail.com>
Subject: Re: Radeon regression in 6.6 kernel
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-kernel@vger.kernel.org,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        dri-devel@lists.freedesktop.org, Phillip Susi <phill@thesusis.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Mon, Nov 20, 2023 at 10:57=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 19.11.23 um 07:47 schrieb Dave Airlie:
> >> On 12.11.23 01:46, Phillip Susi wrote:
> >>> I had been testing some things on a post 6.6-rc5 kernel for a week or
> >>> two and then when I pulled to a post 6.6 release kernel, I found that
> >>> system suspend was broken.  It seems that the radeon driver failed to
> >>> suspend, leaving the display dead, the wayland display server hung, a=
nd
> >>> the system still running.  I have been trying to bisect it for the la=
st
> >>> few days and have only been able to narrow it down to the following 3
> >>> commits:
> >>>
> >>> There are only 'skip'ped commits left to test.
> >>> The first bad commit could be any of:
> >>> 56e449603f0ac580700621a356d35d5716a62ce5
> >>> c07bf1636f0005f9eb7956404490672286ea59d3
> >>> b70438004a14f4d0f9890b3297cd66248728546c
> >>> We cannot bisect more!
> >> Hmm, not a single reply from the amdgpu folks. Wondering how we can
> >> encourage them to look into this.
> >>
> >> Phillip, reporting issues by mail should still work, but you might hav=
e
> >> more luck here, as that's where the amdgpu afaics prefer to track bugs=
:
> >> https://gitlab.freedesktop.org/drm/amd/-/issues
> >>
> >> When you file an issue there, please mention it here.
> >>
> >> Furthermore it might help if you could verify if 6.7-rc1 (or rc2, whic=
h
> >> comes out later today) or 6.6.2-rc1 improve things.
> > It would also be good to test if reverting any of these is possible or =
not.
>
> Well none of the commits mentioned can affect radeon in any way. Radeon
> simply doesn't use the scheduler.
>
> My suspicion is that the user is actually using amdgpu instead of
> radeon. The switch potentially occurred accidentally, for example by
> compiling amdgpu support for SI/CIK.
>
> Those amdgpu problems for older ASIC have already been worked on and
> should be fixed by now.

In this case it's a navi23 (so radeon in the marketing sense).

Alex

>
> Regards,
> Christian.
>
> >
> > File the gitlab issue and we should poke amd a but more to take a look.
> >
> > Dave.
>
