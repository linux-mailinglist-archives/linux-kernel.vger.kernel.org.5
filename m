Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543C580AF70
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 23:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574873AbjLHWJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 17:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbjLHWJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 17:09:57 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4AA10E0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 14:10:04 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-357d0d15b29so9185ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 14:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702073403; x=1702678203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yq8sLZY529fpZyvYcaaHG7aerxfsju32DEaOISOYWys=;
        b=1R2f3ug9nTIVeV4qd2MJ90MwIDAgYzXtosGKPI8WwaHoKLhl3iv1OZRDdQf5vSrNlZ
         8eHyGOmmhu26kHqeyXJYoNfp/NdhEq9MiiZ8VXw6FSq8DQbNKy+z/tjVQRA5pD+QUtku
         xP7/tdnxSOcDZYNatvQ9RbioBWKGzrfMx9Y8Q75ccxjbFB2JJW5W9MRUlmbmNIh8oVcZ
         5R/zgGLq5N47dIdqoL+5Isx+M1HgSknhidgEpPorEolU1LvWXGIHz0pQNAhb6sgHo6rJ
         yAxbq8CItOs5rkRgRvqT29qz8Qb6KgEIcyRLfkFgk53Ex+sWdsHabKKep4dpIjjT1A9x
         krjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702073403; x=1702678203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yq8sLZY529fpZyvYcaaHG7aerxfsju32DEaOISOYWys=;
        b=xB4ZahpG416WqujJ6AiWfG8lGQ8ZZr/R93n5GSXtdrnf6N1KNLFvUEytflbhqQfVHW
         3iLgcIE6e6w7PtvLXyANw67QC5vAzeSwBCVsOiZyR8twxBD0notgitLiupzEMewG5ARz
         mMe2ZGdEIuL+lC8FuYaGJB7ZAGggVIPTpqM6jRgz86ybUccsZvggFfSdJ3fGiUZXWa9J
         UN+vXmZrmPdDQmC6yJE9+HvwRrHl7KT49jBeGTxybSV+q7fQcEwvwGi/vEI5HoMlVwdt
         jo8EZ2NU2nKwVP29nKFD6E68jP7PO0ofrgwU1sesxVLgaglGYIlveAkaDYMFU9O9CpGX
         pdmg==
X-Gm-Message-State: AOJu0YwGQ7EelWMzFm7hKfb4urkkjmyzc5Nyd3WacA7p+QGxre2n98Aq
        eTCKXlpSjLvfRUgoC9Ps2NAXoOd1doRrgy1vfafvOg==
X-Google-Smtp-Source: AGHT+IF+7j3OGuA6M1m1GklJP1yo6EP7HkZ23ytD0eEL4vpAJ88qnrNWtxyHiYrK17I7SJvwBMPxSHB9bsYkWIrc+PI=
X-Received: by 2002:a92:c52c:0:b0:35c:efe7:e9fa with SMTP id
 m12-20020a92c52c000000b0035cefe7e9famr285633ili.23.1702073403543; Fri, 08 Dec
 2023 14:10:03 -0800 (PST)
MIME-Version: 1.0
References: <20231201214737.104444-1-tony.luck@intel.com> <20231207195613.153980-1-tony.luck@intel.com>
 <20231207195613.153980-2-tony.luck@intel.com> <CALPaoCji1yzfkA=tms3LhYMvRB+wSJQM3qzPKrHNEa7a+KduTA@mail.gmail.com>
 <ZXORTTIUKWXOsd9p@agluck-desk3>
In-Reply-To: <ZXORTTIUKWXOsd9p@agluck-desk3>
From:   Peter Newman <peternewman@google.com>
Date:   Fri, 8 Dec 2023 14:09:52 -0800
Message-ID: <CALPaoCj_OvMzD8W9+jEORewwDquM6F-sOW32Ngcy+Gm6A1+OcQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] x86/resctrl: Add mount option "mba_MBps_event"
To:     Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 1:57=E2=80=AFPM Tony Luck <tony.luck@intel.com> wrot=
e:
>
> On Fri, Dec 08, 2023 at 10:17:08AM -0800, Peter Newman wrote:
> > Hi Tony,
> >
> > On Thu, Dec 7, 2023 at 11:56=E2=80=AFAM Tony Luck <tony.luck@intel.com>=
 wrote:
> > > @@ -2715,7 +2723,25 @@ static int rdt_parse_param(struct fs_context *=
fc, struct fs_parameter *param)
> > >         case Opt_mba_mbps:
> > >                 if (!supports_mba_mbps())
> > >                         return -EINVAL;
> > > -               ctx->enable_mba_mbps =3D true;
> > > +               if (is_mbm_local_enabled())
> > > +                       ctx->enable_mba_mbps_local =3D true;
> > > +               else
> > > +                       return -EINVAL;
> > > +               return 0;
> > > +       case Opt_mba_mbps_event:
> > > +               if (!supports_mba_mbps())
> > > +                       return -EINVAL;
> > > +               if (!strcmp("mbm_local_bytes", param->string)) {
> > > +                       if (!is_mbm_local_enabled())
> > > +                               return -EINVAL;
> > > +                       ctx->enable_mba_mbps_local =3D true;
> > > +               } else if (!strcmp("mbm_total_bytes", param->string))=
 {
> > > +                       if (!is_mbm_total_enabled())
> > > +                               return -EINVAL;
> > > +                       ctx->enable_mba_mbps_total =3D true;
> > > +               } else {
> > > +                       return -EINVAL;
> >
> > It looks like if I pass
> > "mba_MBps_event=3Dmbm_total_bytes,mba_MBps_event=3Dmbm_local_bytes" I c=
an
> > set both flags true.
>
> That's going to be confusing. I'll add code to stop the user from
> passing both options.

Also kind of confusing, after reading the second patch, I realized
"mba_MBps_event=3Dmbm_total_bytes,mba_MBps" also results in both being
set. If you're able to fail the mount operation if both flags somehow
get set, that would address this one too.

-Peter
