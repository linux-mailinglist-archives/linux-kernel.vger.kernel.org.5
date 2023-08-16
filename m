Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D3777E2BE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245583AbjHPNiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245601AbjHPNiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:38:15 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64755B9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:38:14 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-58c4f6115bdso25180477b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692193093; x=1692797893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFk6yRXIIHkOEvFC134UvLIF2wd6FFDonNio1jeok9w=;
        b=RHoKBPupeYA7SrWo0q7PbNF5ntazEJKGsU97Zf9M3m0BVAUoOeZVNvoLNIRLdUkWTi
         sFFdOMafEkwKwKrCksLSRBZTxNbDND5cXKFDyPFTFj/h6Qp3NBTzANx2nfJDFWN1jss/
         7V4Lupd7U7EihO51vO648AM8KsoYyUqjDwbqC2phWZGbtqAuwrZvOif2vuMsbbRIqBcz
         uufM3u+0BAxxqInkAKotUiO5mKy7MHoX57owZtFRsPgNWO1XF03eW79z0WUj96OhRajy
         mZAv37KcXxRGPG3DzkBYp2h1tXU8LpMcJQ6dgMq4d/1hfpVDEf2Lu1eS7RDSgGNcSejE
         GNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692193093; x=1692797893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFk6yRXIIHkOEvFC134UvLIF2wd6FFDonNio1jeok9w=;
        b=Oh0UBhrGC5F+Pa6mQm0TLBvHW3aVFnlSkYZIGn4DHPgEDadqatIU3+mXgaWtawmXla
         dfKHRKROuhmH1JDeVVEaLUDrogkGwN1k8Im3g6LYYn1cDDhe1ks5m/ptR83HOEqDQshL
         IwhQsrCOZAJKnbR+cu3RjZ72AGVGnDqORD2rGRVaHCj2w3T9zWbT6fyQYu+M074Se/KT
         BOkD5L4SAokkUTpMsYoay2gwaqsS0GhRcZp0uqznRfsjmhnsSj7m5Kqekx/9NPJAgp2K
         ZGQ32fpnjn1mQpCTb8RyH1phw5PQsmUJ/Lt9nlAzX5Tz2eMrceenpBOuccsQpNXMiPjK
         JC/g==
X-Gm-Message-State: AOJu0YwJ7PNGaJgdL6cUfD4NkZwBxQm89ZjiQqD0uTqna1X8qsp2+pEs
        LUdfjf5tiSaNYDkJsJUkggJ9QNtz3VNeiuWd8lbMTsSzqRhnTv7Lk2Pr
X-Google-Smtp-Source: AGHT+IGGDk9Pyi5oSqBh7ckQNXLO3AWM6VH2oSh9mxDFPuQuoWa1Tzd0Ad8SzA7VmXTVYyeihZMbBixnVbyBWmdOdNA=
X-Received: by 2002:a81:8404:0:b0:58c:5132:deee with SMTP id
 u4-20020a818404000000b0058c5132deeemr1713911ywf.43.1692193093583; Wed, 16 Aug
 2023 06:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230815204553.52261-1-atulpant.linux@gmail.com>
 <aecb4e94bc65928c674b6a083e7fd489.paul@paul-moore.com> <20230816025550.GD57274@atom0118>
In-Reply-To: <20230816025550.GD57274@atom0118>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Aug 2023 09:38:02 -0400
Message-ID: <CAHC9VhQc9jfE=H-3ePTBbEQ3nGj8z1cwGPaZebrn=YjqO+J-+g@mail.gmail.com>
Subject: Re: [PATCH v1] kernel: Add space before parenthesis and around '=',
 "==" and '<'
To:     Atul Kumar Pant <atulpant.linux@gmail.com>
Cc:     eparis@redhat.com, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 10:55=E2=80=AFPM Atul Kumar Pant
<atulpant.linux@gmail.com> wrote:
> On Tue, Aug 15, 2023 at 06:09:19PM -0400, Paul Moore wrote:
> > On Aug 15, 2023 Atul Kumar Pant <atulpant.linux@gmail.com> wrote:
> > >
> > > Fixes following checkpatch.pl issue:
> > > ERROR: space required before the open parenthesis '('
> > > ERROR: spaces required around that '=3D'
> > > ERROR: spaces required around that '<'
> > > ERROR: spaces required around that '=3D=3D'
> > >
> > > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > > ---
> > >  kernel/acct.c        |  2 +-
> > >  kernel/auditfilter.c | 16 ++++++++--------
> > >  kernel/auditsc.c     |  2 +-
> > >  3 files changed, 10 insertions(+), 10 deletions(-)
> >
> > I changed the subject line to "audit: add space before parenthesis and
> > around '=3D', "=3D=3D", and '<'" as the "audit:" prefix is more appropr=
iate
> > and I'm a believer of the Oxford Comma.  Otherwise it looks fine and I
> > just merged it into audit/next, thanks.
>
>         Thank you for your comments. Do I need to change commit message n=
ow?

No, I fixed it up and merged the patch, it's just something to
remember for future patch submissions.  Here is the commit in the
audit/next branch:

   commit 62acadda115a94bffd1f6b36acbb67e3f04811be
   Author: Atul Kumar Pant <atulpant.linux@gmail.com>
   Date:   Wed Aug 16 02:15:53 2023 +0530

   audit: add space before parenthesis and around '=3D', "=3D=3D", and '<'

   Fixes following checkpatch.pl issue:
   ERROR: space required before the open parenthesis '('
   ERROR: spaces required around that '=3D'
   ERROR: spaces required around that '<'
   ERROR: spaces required around that '=3D=3D'

   Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
   [PM: subject line tweaks]
   Signed-off-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
