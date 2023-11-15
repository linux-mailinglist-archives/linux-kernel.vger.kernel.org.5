Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FCC7ECA44
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 19:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjKOSKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 13:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKOSKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:10:48 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32526189
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:10:44 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6d63e0412faso1105722a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700071843; x=1700676643; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvVSilkTlmHKx1H7XRvFa1ycfaLcXw/q2OAB52G/jaE=;
        b=X767n4Mu5iOWqjqCLVVfqE2qNBZeiItTIn+u+m+0QQoXVwSN2EtXtpfG0ZWvRXV6z4
         r7jIwPaldWUbpBFL8gl5K8jstrPLZclWExIrfanYM9tp6vmyNMHXjjL/QcnRNruAjTTd
         uc8eDm8Bd1G4NvzR4D5Xs+EMZoa2zD3zV5Lwksy5v4FrsXplAafH3vuKo5+90RDx/o9N
         y4Wn1zZgqnWG+QTtKvtVj9wzvuKg5d33O0ySp95JADnvhOVYNQq4LdqqzKFmj6hSOgic
         lIGQxA2mKKwaigrRmyIuEtyA3DrN9F/eu/OVEqH/hskYt1vOEOC/IxD7XjzjovKGUPXQ
         5zxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700071843; x=1700676643;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvVSilkTlmHKx1H7XRvFa1ycfaLcXw/q2OAB52G/jaE=;
        b=lCCuGViyqQqVSsIPNRwp7QnNzVZhXNQFqEXXSfs+1HxPoyslLPUPSBmMRvo9+4Yzgg
         C6/Iu1EbS/SCutkoIo1wjIrnkIefSgdRh35KfyKY4scldk5BTsmSE/H5YqQBAuA7HHbt
         E8pnN9My64+NQl3rUH9u18fBCM81UmDnjg0dEeqGx7LP42Uo8GeP8RVSrdiR/017Hrrj
         oDEXWlUsy8/VKaF6VOSM9D5AirgQCf7JFoampLE0rWbWFsRx4go8BQRz52nQ6kT+lxHx
         pOCW6QGsqXAns8JLk+gehCGIcI9xq7j5BF2h3s37blvl73EOSUAxEg5Y18gGUS5KgqT8
         DvDA==
X-Gm-Message-State: AOJu0YywhcMOnkYv7PSGdbpyWCTHE3KKR+gpsW+2Z6sDNxmSqJLBaH9/
        +8UGGZHWofFNwbkrmk00sAer52/AOPyAmE7lp6WKhmMRtap6GD/Y5z3Nbw==
X-Google-Smtp-Source: AGHT+IE6PRuYzCSXcmeLGmx7kvaOAPrGi8m1Y1cQtZMC16aZEPjLnYO6nijHZ0Vn8Xz/EMHx682T/JqVNTRsg0wvdnc=
X-Received: by 2002:a05:6830:a84:b0:6b9:db20:4d25 with SMTP id
 n4-20020a0568300a8400b006b9db204d25mr6821491otu.1.1700071843389; Wed, 15 Nov
 2023 10:10:43 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
 <CABXGCsOqbLRHSkiz79NkVQ-wUtR7y-ZFHvhMw0+JJ_cY2AZmSw@mail.gmail.com>
In-Reply-To: <CABXGCsOqbLRHSkiz79NkVQ-wUtR7y-ZFHvhMw0+JJ_cY2AZmSw@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 15 Nov 2023 23:10:32 +0500
Message-ID: <CABXGCsPE9=Qp3Jg5hkRsTQoNgODnS_cXFU1d+hg3Baob40AaAA@mail.gmail.com>
Subject: Re: regression/bisected/6.7rc1: Instead of desktop I see a horizontal
 flashing bar with a picture of the desktop background on white screen
To:     alvin.lee2@amd.com, hersenxs.wu@amd.com, daniel.wheeler@amd.com,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Tue, Nov 14, 2023 at 11:03=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Tue, Nov 14, 2023 at 3:55=E2=80=AFPM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
> >
> > Hi,
> > Yesterday came the 6.7-rc1 kernel.
> > And surprisingly it turned out it is not working with my LG C3.
> > I use this OLED TV as my primary monitor.
> > After login to GNOME I see a horizontal flashing bar with a picture of
> > the desktop background on white screen.
> > Demonstration: https://youtu.be/7F76VfRkrVo
> >
> > I made a bisection.
> > And bisect said that the first bad commit is:
> > commit ed6e2782e9747508888f671e1101250bb19045be
> > Author: Alvin Lee <alvin.lee2@amd.com>
> > Date:   Mon Oct 23 14:33:16 2023 -0400
> >
> >     drm/amd/display: For cursor P-State allow for SubVP
> >
> >     [Description]
> >     - Similar to FPO, SubVP should also force cursor P-State
> >       allow instead of relying on natural assertion
> >     - Implement code path to force and unforce cursor P-State
> >       allow for SubVP
> >
> >     Reviewed-by: Samson Tam <samson.tam@amd.com>
> >     Acked-by: Hersen Wu <hersenxs.wu@amd.com>
> >     Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
> >     Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> >     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >
> >  drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 17 ++-------=
--------
> >  1 file changed, 2 insertions(+), 15 deletions(-)
> >
> > My hardware specs: https://linux-hardware.org/?probe=3D1c989dab38
> >
> > --
> > Best Regards,
> > Mike Gavrilov.
>
> I forgot kernel logs. Not sure it would be helpful because I didn't
> notice anything unusual.
>

This only appears on 7900XTX and 120Hz.

--=20
Best Regards,
Mike Gavrilov.
