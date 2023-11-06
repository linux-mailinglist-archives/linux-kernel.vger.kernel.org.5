Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7147E2F0D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjKFVhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjKFVhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:37:31 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A198D57
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:37:28 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1f055438492so2734780fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 13:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699306646; x=1699911446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OphoK9q7a6dBe49RqxvB+ZhnnNOavYr9X32u348/Dmw=;
        b=VGFfeDjrbXEI1xXu64l0H1RKcVFmuJ1caKRQYgQwREIbf4VowDWZy/JDSJBqPkdVSJ
         tFw9ityfJ5/Xutnjy+vw5c/uj5I+u2z+qASmwHYrWgecywXOurlWo7qED/ionxb7S/+x
         opLHGGKK4aGHQDaeYoDraqtoStdre6x33lvVHgFW3N3Bt1y+osGf6bIt6UovkHGqYCSW
         4ULurTpJXP48+cipwWeDb6R9bjM4ErQXeHnkkj1UkITASBTv5ee7mlY2DRWGB+TN5AI2
         hXsE+f99pO5leDs9Csc940FvRcaNletnE+NtaRjPxuRNVHw5QUCBsGAzlnzBx8qoS8Vf
         MRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699306646; x=1699911446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OphoK9q7a6dBe49RqxvB+ZhnnNOavYr9X32u348/Dmw=;
        b=wci0y4jdE1737n2QgOqeWEvSuksOvEYG32GCmhAqEbW2ihxAPXo3+k/WujN5GeoDpr
         MiO1ff1slAlDHcmo+n38hcvDSJW7JWRe8ZUnzO0klBxsPwQ3EM8FxAX5G5lfRXXm323B
         ml9ASVXBrcaQOmpSjiTA+ZBJNsSM2Hn6201pT+O4ufrjGQSxsDlx5MAiDX1RNh38ISgp
         aLGJrc4275Efa455X7bhxIgWYp8tq1IHfp4rTcxQuHnFZZ3RX0LbD8EDU1pf94XmpA7z
         G8JeiBnmHoyy7L3xrGpM9nagL0f/VNwseliryDnsmndXQ+A2LJTCgJ6u+fdxHc8Ww7QJ
         N0iA==
X-Gm-Message-State: AOJu0YxUPc6hUOjImSWDNWwRcGxthIMum0SnSNkd6KXBIGaeFWSO8lZo
        tlqG2HB/gLoV7XxnKGf6EOkY5CZAn8oHp0jxWZM=
X-Google-Smtp-Source: AGHT+IEP1XqEthoQJtfpl0npA4ae93Dzz/ImFHkuNMcwaOYVT9bgazTQ4NPqNXzu0dmR/IWccQ3n4KaVPdI0Je829g8=
X-Received: by 2002:a05:6871:339e:b0:1e9:b0fa:de48 with SMTP id
 ng30-20020a056871339e00b001e9b0fade48mr1089412oac.47.1699306645891; Mon, 06
 Nov 2023 13:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20231103155013.332367-1-singhabhinav9051571833@gmail.com>
 <CADnq5_OkWD3YmCKgXbtk=Gnba3AgAiAWp2z_nzHQvRfEOsdXVg@mail.gmail.com> <3b92b89b-ca72-4012-b4f2-0b19e4ba9153@gmail.com>
In-Reply-To: <3b92b89b-ca72-4012-b4f2-0b19e4ba9153@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 6 Nov 2023 16:37:14 -0500
Message-ID: <CADnq5_PXRN+PL4wp+sWOXs2L5nQiRmfrw4065R1TE4YKw-ZeUA@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpu: Fix warning using plain integer as NULL
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Mon, Nov 6, 2023 at 4:20=E2=80=AFPM Abhinav Singh
<singhabhinav9051571833@gmail.com> wrote:
>
> On 11/7/23 00:25, Alex Deucher wrote:
> > Applied.  This matches what we already do in the other clear state head=
ers.
> >
> > Alex
> >
> > On Fri, Nov 3, 2023 at 12:00=E2=80=AFPM Abhinav Singh
> > <singhabhinav9051571833@gmail.com> wrote:
> >>
> >> sparse static analysis tools generate a warning with this message
> >> "Using plain integer as NULL pointer". In this case this warning is
> >> being shown because we are trying to intialize a pointer to NULL using
> >> integer value 0.
> >>
> >> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> >> ---
> >>   drivers/gpu/drm/radeon/clearstate_evergreen.h | 8 ++++----
> >>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/radeon/clearstate_evergreen.h b/drivers/g=
pu/drm/radeon/clearstate_evergreen.h
> >> index 63a1ffbb3ced..3b645558f133 100644
> >> --- a/drivers/gpu/drm/radeon/clearstate_evergreen.h
> >> +++ b/drivers/gpu/drm/radeon/clearstate_evergreen.h
> >> @@ -1049,7 +1049,7 @@ static const struct cs_extent_def SECT_CONTEXT_d=
efs[] =3D
> >>       {SECT_CONTEXT_def_5, 0x0000a29e, 5 },
> >>       {SECT_CONTEXT_def_6, 0x0000a2a5, 56 },
> >>       {SECT_CONTEXT_def_7, 0x0000a2de, 290 },
> >> -    { 0, 0, 0 }
> >> +    { NULL, 0, 0 }
> >>   };
> >>   static const u32 SECT_CLEAR_def_1[] =3D
> >>   {
> >> @@ -1060,7 +1060,7 @@ static const u32 SECT_CLEAR_def_1[] =3D
> >>   static const struct cs_extent_def SECT_CLEAR_defs[] =3D
> >>   {
> >>       {SECT_CLEAR_def_1, 0x0000ffc0, 3 },
> >> -    { 0, 0, 0 }
> >> +    { NULL, 0, 0 }
> >>   };
> >>   static const u32 SECT_CTRLCONST_def_1[] =3D
> >>   {
> >> @@ -1070,11 +1070,11 @@ static const u32 SECT_CTRLCONST_def_1[] =3D
> >>   static const struct cs_extent_def SECT_CTRLCONST_defs[] =3D
> >>   {
> >>       {SECT_CTRLCONST_def_1, 0x0000f3fc, 2 },
> >> -    { 0, 0, 0 }
> >> +    { NULL, 0, 0 }
> >>   };
> >>   static const struct cs_section_def evergreen_cs_data[] =3D {
> >>       { SECT_CONTEXT_defs, SECT_CONTEXT },
> >>       { SECT_CLEAR_defs, SECT_CLEAR },
> >>       { SECT_CTRLCONST_defs, SECT_CTRLCONST },
> >> -    { 0, SECT_NONE }
> >> +    { NULL, SECT_NONE }
> >>   };
> >> --
> >> 2.39.2
> >>
> Hi Alex, thanks for looking into this. By applied you mean this patch is
> accepted and it has been merged?

Yes.  Once it makes it through our CI system, it will show up in my
drm-next tree.

Alex
