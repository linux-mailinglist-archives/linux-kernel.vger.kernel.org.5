Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A137A2A59
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237965AbjIOWRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237793AbjIOWQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:16:55 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FED8B7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:16:47 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-403004a96a4so29380495e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1694816206; x=1695421006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hx79jYqQlletaTAU2xU1OGCLoHI/owAdHUz3GOVb0BY=;
        b=Gtjg1rBqw7HUDM1z9gyB0QjEaNvMlSXmppTj/cKqP4Rgp497Agqa+lDFKFVnENXEOC
         TWMv3rpShflNhkEs52FqF02oWSrkDNeKP0K4FHSabGSat0pNB+iXXcEzGu/DM1U3E3xR
         QSaOtgmiJgGN3I0JT7Oqiq0SOMD+l9yNFRpI9L8fGkQ9++SNw5qnyT8imkGYuATC8LIg
         Nahk214LxCgj6JKUoRCguszo906Kzayke3wGUNtUxDObm7mKFlQ0L/U8Dl+iHfTC4+Oy
         lh06B8JCFqnMGm2eMak6ZocuJjPBAXnSAAuDTSI4m9mw2jHWAguSr8ugQxxCWY5yBgR8
         RL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694816206; x=1695421006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hx79jYqQlletaTAU2xU1OGCLoHI/owAdHUz3GOVb0BY=;
        b=hF52vSW9UMXFqji3RrZ/UvUuekrBwyVtUR/zct5GWOHc9L05JGe0fIQB8IuRK9yfSV
         UqssQOJCTES0/29ajJj9awHRUv1rXbZpy1DC19RwOvJCIFL6uGUUIVWWg4qQ4JcYVUzb
         2DF41CaJea8L37T0TRwrwz3seb5qEcacPKbPg/V5mTdFJlBLWOtaZFZLYCoAoUUQfFzY
         WIfn6wdK/QXMRO89tg2bQdm2d1ySPYWDktanqrZKBrVJaK0+QqrZ0f7rwJYInL/oMXjr
         9O0PJbBFxpgsprh89l/tqvIt9LOO2Ss1mgj4ri0760jPFnlGCboHFB5Zl81zoamMzR1u
         f38Q==
X-Gm-Message-State: AOJu0Yx7FS/jEFdubz2uVaWm5Zd+VsQunlUtrGPyIZS9plHJNLWOLo7s
        O9KGDjtxfIYNlzgCswM/PbGxB3aEev5HAQSGNoW+NQ==
X-Google-Smtp-Source: AGHT+IGDU8Ph5l9pRDGaOWN67P4arFu4uLsx88HR4DrUBMmxtv4+qgesE2QUUwC/mduyZtqoi9sUjLginqkP4oLMqCw=
X-Received: by 2002:a05:600c:ac3:b0:401:519:c9 with SMTP id
 c3-20020a05600c0ac300b00401051900c9mr2699220wmr.13.1694816205688; Fri, 15 Sep
 2023 15:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230915104057.132210-1-swapnil.sapkal@amd.com>
 <20230915104057.132210-3-swapnil.sapkal@amd.com> <00b201d9e819$b2447e80$16cd7b80$@telus.net>
 <2fd025a9-52f3-4922-99cf-82355b0e35fe@amd.com>
In-Reply-To: <2fd025a9-52f3-4922-99cf-82355b0e35fe@amd.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Fri, 15 Sep 2023 15:16:37 -0700
Message-ID: <CAAYoRsUhusVzOnaGHjPoMWYy2_iPFAjFLoCrj6vSX26EHNWGiw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/power/x86/intel_pstate_tracer: Use pygnuplot
 package for Gnuplot
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc:     rafael.j.wysocki@intel.com, Ray.Huang@amd.com, li.meng@amd.com,
        shuah@kernel.org, sukrut.bellary@gmail.com, gautham.shenoy@amd.com,
        wyes.karny@amd.com, Perry.Yuan@amd.com, zwisler@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 2:31=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
> On 9/15/2023 16:15, Doug Smythies wrote:
> > On 2023.09.15 03:41 Swapnil Sapkal wrote:
> >
> >> In intel_pstate_tracer.py, Gnuplot is used to generate 2D plots.
> >> In current implementation this tracer gives error while importing
> >> the module because Gnuplot is imported from package Gnuplot-py which
> >> does not support python 3.x. Fix this by using pygnuplot package to
> >> import this module.
> >
> > As described in the prerequisites section, the package name is distribu=
tion dependant.
> > On my distribution the original package name is phython3-gnuplot,
> > and it is working fine.
> >
> > sys.version_info(major=3D3, minor=3D8, micro=3D10, releaselevel=3D'fina=
l', serial=3D0)
> >
> > I don't currently have python3-pygnuplot installed, and so this patch b=
reaks
> > the  intel_pstate_tracer for me.
> >
> > So, I installed the python3-pygnuplot package, and it still didn't work=
, as there
> > still wasn't a pygnuplot module to import.
> > So, I found something called PyGnuplot.py and so changed to that and go=
t further.
> > But then it got upset with:
> >
> >    File "./intel_pstate_tracer.py.amd", line 298, in common_gnuplot_set=
tings
> >      g_plot =3D gnuplot.Gnuplot(persist=3D1)
> > NameError: name 'gnuplot' is not defined
> >
> > I gave up and returned to the unpatched
> > intel_pstate_tracer.py
> > And checked that is still worked fine. It did.
> >
> > So, I do not accept this proposed patch.
> >
> > Not really related, but for a few years now I have been meaning to
> > change the minimum python version prerequisite to >=3D 3.0 and
> > to change the shebang line from this:
> >
> > #!/usr/bin/env python
> >
> > To this:
> >
> > #!/usr/bin/env python3
> >
> > I have to use the latter version on my distro.
> > Back when I looked into it, things were inconsistent,
> > so I didn't know what to do. The kernel tree has 52 .py files
> > of the latter shebang and 11 of the former.
> >
> > ... Doug
>
> Presumably this is the one that Swapnil intended:
>
> https://pypi.org/project/py-gnuplot/

Yes, I found that earlier.
For my part of it, I do not want to use any out-of-distro package.

> It requires python3, so I think if upgrading to this one the script does
> need to be switched to python3.  Besides the shebang, you should also
> use a helper like 2to3 to look for any other changes.

I already did the python 3 patch in January, 2020:
commit e749e09db30c38f1a275945814b0109e530a07b0
tools/power/x86/intel_pstate_tracer: changes for python 3 compatibility

I haven't had any issues since, shebang aside.

... Doug

> There were 97 hits for 'gnuplot' at pypi.  2 stood out but at least in
> the case of gnuplot based stuff, I think it's worth dropping
> a comment that links back to pypi page for the intended package.
>
> Another alternative is to include a 'requirements.txt' file that pip can
> pick up.
>
> https://pip.pypa.io/en/stable/reference/requirements-file-format/
>
> >> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> >> ---
> >> tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py      | 1 -
> >> tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py | 4 ++--
> >> 2 files changed, 2 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py b/t=
ools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> >> index 2448bb07973f..14f8d81f91de 100755
> >> --- a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> >> +++ b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> >> @@ -27,7 +27,6 @@ import re
> >>   import signal
> >>   import sys
> >>   import getopt
> >> -import Gnuplot
> >>   from numpy import *
> >>   from decimal import *
> >>   sys.path.append(os.path.join(os.path.dirname(__file__), '../intel_ps=
tate_tracer'))
> >> diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.p=
y
> > b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> >> index ec3323100e1a..68412abdd7d4 100755
> >> --- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> >> +++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> >> @@ -32,7 +32,7 @@ import re
> >>   import signal
> >>   import sys
> >> import getopt
> >> -import Gnuplot
> >> +from pygnuplot import gnuplot
> >>   from numpy import *
> >>   from decimal import *
> >>
> >> @@ -295,7 +295,7 @@ def common_all_gnuplot_settings(output_png):
> >> def common_gnuplot_settings():
> >>       """ common gnuplot settings. """
> >>
> >> -    g_plot =3D Gnuplot.Gnuplot(persist=3D1)
> >> +    g_plot =3D gnuplot.Gnuplot(persist=3D1)
> >> #   The following line is for rigor only. It seems to be assumed for .=
csv files
> >>       g_plot('set datafile separator \",\"')
> >>       g_plot('set ytics nomirror')
> >> --
> >> 2.34.1
