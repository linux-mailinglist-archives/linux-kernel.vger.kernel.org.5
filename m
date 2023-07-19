Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284A27594F0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 14:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjGSMSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 08:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjGSMR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:17:57 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A022D1A6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 05:17:51 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-55ae51a45deso4233168a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 05:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689769071; x=1692361071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuhhXkXir4voS8gRIBtJkYV+Q76WiKVmML4Bwp3OVzQ=;
        b=VN2la+gdY313z4WUzC82DsEJ9wBoMtyeSH2mhElyVbBo60S9VhRCReD8xRqJ2TyZep
         9PSHM5RabSrfqqtLK1j+qo0SUgqzNWXnOh2CzXAAaMmHRLITmRSs+UQRtiM2c6PHYVRW
         6w0ov4Nq/0dSbye8Vy15WC7tGCC5/Uve8phR1P7NNnsvCwudh7VwOXsylHO+lJ5zR8lq
         HU9CYeG4l9WYAzrwQnH/FCUgOdD4YNdMThnVhDJChXObDPV13o1hPc4HFrZeBnMIm7gj
         FR/vITBKH4zYz2q+N+5d7ApM583VJk8ZCJD/l2yHUnsFx3Tgi5x/9+8ch2nz7IdrdUie
         jQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689769071; x=1692361071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SuhhXkXir4voS8gRIBtJkYV+Q76WiKVmML4Bwp3OVzQ=;
        b=R8VdZ0eqnyDxjuKF4WN8wbpg+vfhMzwrMxNncvess9k3S6NrQFxQZEictPCb+d4Rf2
         TWEyGtDymVChr7pRVr3X4X6NgTnW2tRwFp5EHmGVHNfxWpvPdBoclqXtxhz9+zLFJKcJ
         z2qRKdgYq9qzQP0p0ary7AaVOYVlu42m4ch0JSihFkfz0c7PFGsNKh5sOQgMwukibw9E
         AeV8qBsqL3qCquWfCPdnoHYzBbW2a7F66XQblBnsG5kCZXqJz3Jrtqf6TuI6wzyr/oSY
         uLRwbeGibqmVF4HLfECmSMtTBUGu/rlrv0/n7eYW9CoAkvQjeibtnxiXXUdouPA71sP8
         py9Q==
X-Gm-Message-State: ABy/qLY+KhMI5p8UlWaPMtg9fiefhPploAsFBGJfa3GTzxnqmY+xFK5F
        Cpwou6qE5OP/eXUmkNkbM3N+Qh9JV0kPqek0dfRUWw==
X-Google-Smtp-Source: APBJJlHFeWc9QGjqVC7qDUf6qbm4HxW11xlzgnjByON1Pmpylvr7wULvgzZw0+ykoLhMoB/wrY6jgYsktx9m7ChZRwM=
X-Received: by 2002:a17:90b:108e:b0:264:929:ed96 with SMTP id
 gj14-20020a17090b108e00b002640929ed96mr1664814pjb.9.1689769070641; Wed, 19
 Jul 2023 05:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230712091241.3668454-1-Naresh.Solanki@9elements.com> <c1988d23-c19c-0ec0-9f61-01cbb00ead3a@molgen.mpg.de>
In-Reply-To: <c1988d23-c19c-0ec0-9f61-01cbb00ead3a@molgen.mpg.de>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Wed, 19 Jul 2023 17:47:41 +0530
Message-ID: <CABqG17i9T5e7Foy7L1D=OdPo8uHfQ2xfvEPmxLB6hQY42Yq3Xw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] peci: cpu: Add Intel Sapphire Rapids support
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        iwona.winiarska@intel.com, linux@roeck-us.net, jdelvare@suse.com,
        openbmc@lists.ozlabs.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, 19 Jul 2023 at 16:50, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Naresh,
>
>
> Thank you for the patch.
>
> Am 12.07.23 um 11:12 schrieb Naresh Solanki:
> > Add support for detection of Intel Sapphire Rapids processor based on
> > CPU family & model.
> >
> > Sapphire Rapids Xeon processors with the family set to 6 and the
> > model set to INTEL_FAM6_SAPPHIRERAPIDS_X. The data field for this entry
> > is "spr".
>
> Please add, how you tested this.
Yeah, sure. Missed adding that. Will update the same in next revision.
>
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > ---
> > Changes in V2:
> > - Refactored from previous patchset as seperate patch based on subsyste=
m.
> > ---
> >   drivers/peci/cpu.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/peci/cpu.c b/drivers/peci/cpu.c
> > index de4a7b3e5966..3668a908d259 100644
> > --- a/drivers/peci/cpu.c
> > +++ b/drivers/peci/cpu.c
> > @@ -318,6 +318,11 @@ static const struct peci_device_id peci_cpu_device=
_ids[] =3D {
> >               .model  =3D INTEL_FAM6_ICELAKE_X,
> >               .data   =3D "icx",
> >       },
> > +     { /* Sapphire Rapids Xeon */
> > +             .family =3D 6,
> > +             .model  =3D INTEL_FAM6_SAPPHIRERAPIDS_X,
> > +             .data   =3D "spr",
> > +     },
> >       { /* Icelake Xeon D */
> >               .family =3D 6,
> >               .model  =3D INTEL_FAM6_ICELAKE_D,
>
> It looks like it=E2=80=99s incorrectly sorted, probably due to merge conf=
lict
> resolution?
Will move it to after Xeon D in next revision.

Thanks,
Naresh
>
>
> Kind regards,
>
> Paul
