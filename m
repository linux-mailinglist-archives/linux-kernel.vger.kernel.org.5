Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D657F3041
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbjKUOF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjKUOFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:05:55 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFB110C4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:05:51 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1f5d7db4dcbso1735452fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700575550; x=1701180350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JicfpEa3uNWDUz2NDkVsyh217wG6PJj7MozXv7sFA4w=;
        b=DdJPZSovoMPlMU3KZCRxvC3VqG5NthmU5hFPCmVZbUFOf9F2dAGDHowEfIA/SxrI+6
         m+E1a59osoAqwNNTKaPZWmNQCJIe3OSvPdox6pTNOXyqqFjSqznr/GxCH5G9U5kHvshi
         UHCgTuzfo5G63S5tjNxR3FARuBtO0CKQvebgwr440u8lO1BP8FGprwKRoWBKUMRi06fA
         YH4hXPDWLEtGS8R0b1HL8otPo0/WjlsB8P3RxSGWbMlp2GinhOT3SWCUTzEDzSO7504q
         albBlMuklifdiHD2nIFVSfPNPiGY5FPI4PfDcYn6+nE14bONchGvVnzylG7qRR4YESoT
         WLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700575550; x=1701180350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JicfpEa3uNWDUz2NDkVsyh217wG6PJj7MozXv7sFA4w=;
        b=X4ur3mqSCW5diLeFKEka1PBL+eog9Yu5RydwTy45iMTodsITkPdLEiYLPB/zARXatS
         7DUnrWuovv7mu0HLiVj3hDXjgnHekn1YyUKmVcmX0e2yJi2jKYJv1J5Rg/XOBKZVZlti
         jawMlYMt1gC+wNdB3zFDJp+NQAIhPWaYbr44fcF7uRiriaTGg46rXwHtVdvdRIw/g8LO
         ZcOqs9p9gyVOLj5B6EvtF4jtSY+zL25cOwDhEDGHOVQJTXFV9vPMEYQPBCJ7Fmp9SRQG
         7hwhsH3GQI7ErG9lN/krrixknnwf31cZ3XJJA6Ggtp3Qs55mX98zVsR2XldRg9niqaSa
         CDZw==
X-Gm-Message-State: AOJu0Yypj55Qo6Gl6qAHOG51BlOyejPBohN9VV4iUSDk15fimaSICrQS
        WC4bL0SMQewd3qPksCPaGjI9ad91pByRvhK5mhE=
X-Google-Smtp-Source: AGHT+IHKHQMKS3b1gLqqox30Lk4uUwKC52JYW8VCEcKNOaYp9uPK894sLiFLuA30J+s9SqYcbYaSE9jt5JVjnAUgiXE=
X-Received: by 2002:a05:6871:7398:b0:1f5:994:9853 with SMTP id
 na24-20020a056871739800b001f509949853mr13022151oac.22.1700575550741; Tue, 21
 Nov 2023 06:05:50 -0800 (PST)
MIME-Version: 1.0
References: <87edgv4x3i.fsf@vps.thesusis.net> <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com> <CADnq5_NVGS1XykxGxpcu_bpPbzboCUJQkcCF3r+0N9a23KUgiQ@mail.gmail.com>
 <96e2e13c-f01c-4baf-a9a3-cbaa48fb10c7@amd.com> <CADnq5_NBfeAXEyQw0gnSd67=tR-bUKg8w=10+4z9pGGuRnP9uw@mail.gmail.com>
 <87bkbodp51.fsf@vps.thesusis.net>
In-Reply-To: <87bkbodp51.fsf@vps.thesusis.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 21 Nov 2023 09:05:39 -0500
Message-ID: <CADnq5_Nh4wCFY10Ha9dTGWvehPCdY2zxfERtFuoeF5_xA+P=QA@mail.gmail.com>
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

On Mon, Nov 20, 2023 at 5:40=E2=80=AFPM Phillip Susi <phill@thesusis.net> w=
rote:
>
> Alex Deucher <alexdeucher@gmail.com> writes:
>
> > Yes.  Those changes went into 6.7 though, not 6.6 AFAIK.  Maybe I'm
> > misunderstanding what the original report was actually testing.  If it
> > was 6.7, then try reverting:
> > 56e449603f0ac580700621a356d35d5716a62ce5
> > b70438004a14f4d0f9890b3297cd66248728546c
>
> I had been running v6.6-rc5 before pulling.  It looks like that got me
> somewhere between v6.6 and v6.7-rc1.  Reverting those two commits fixes
> it.

Does reverting 56e449603f0ac580700621a356d35d5716a62ce5 alone fix it?
Can you also attach your full dmesg log for the failed suspend?

Alex
