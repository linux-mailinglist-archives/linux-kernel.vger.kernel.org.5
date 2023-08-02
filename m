Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A517B76CFC4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjHBOMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjHBOMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:12:47 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B21910E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:12:46 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bed101b70so864445066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 07:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690985563; x=1691590363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jk7dG2JQoSWzPUYFtbFVP5ZnJGBCto9sOcANncXe8Fg=;
        b=bm8wpxL4eg/lCXHTflwlgjjv7qSMLc8CgW64JCNIxYcBPWHFhk8LeLNiMmL2jzL9SM
         P4MbDYukFCh+p2NfuK4xtDd4GpB1XJ0GB0MhPsIC13QXT2Np2OpV9bhgIk+LUPMtzGaW
         47HmAashp6dCdElFYvKxmW0wtLzQ9Rgnghrag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690985563; x=1691590363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jk7dG2JQoSWzPUYFtbFVP5ZnJGBCto9sOcANncXe8Fg=;
        b=h5zgHfEXonSepydOP9icvBuWi/plVvmj46+iA2Szi28GpAooBOb22XrJN8DGLyQbeE
         FIdXMdaxT3Bmg0ziy0nghrevX+7q45Rs3KEGR4xFBtSK3eFVOOJxt2r4evb+AXg5xvCL
         ewjlA9ZZPR2+JBTTfbQ0Q/ZtdNU5zNAFzDstlvICp54NFWMACPsx6eKK1iVbDB++o6xN
         sqIVOBHUHG8buXXBierZJPKXGSsgklq881G1TnCfxdxeURQznCBkninh1xGpWekGC0MI
         t4ZeY77Kve/5JKndZsiTiDS6sXTxgnthlt1debtFOEJPntyljQdzHQVzFpNE3wZGIw9h
         v9UA==
X-Gm-Message-State: ABy/qLbFtIDkDJsfCnyWvDPr+XvCqSkFcSRNfdSporL+X0SYEwXZp84+
        9y8t4yZLtHjdYaNVqHfM9+13Q0piZwwA42C+eVHg1DmG
X-Google-Smtp-Source: APBJJlFi0hN/QCrK7U3fcplv/19MhJO6a2hRvpmYF00OAU79CQiGAPtPtP4FNhkUsr838vWcJz9IaA==
X-Received: by 2002:a17:906:518a:b0:99b:fdbb:31f1 with SMTP id y10-20020a170906518a00b0099bfdbb31f1mr5379833ejk.16.1690985563602;
        Wed, 02 Aug 2023 07:12:43 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id m15-20020a17090607cf00b00993159ce075sm9093337ejc.210.2023.08.02.07.12.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 07:12:43 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5223910acf2so13631a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 07:12:42 -0700 (PDT)
X-Received: by 2002:a50:d70e:0:b0:522:203b:c348 with SMTP id
 t14-20020a50d70e000000b00522203bc348mr407273edi.5.1690985562352; Wed, 02 Aug
 2023 07:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230731091754.1.I501ab68cb926ee33a7c87e063d207abf09b9943c@changeid>
 <ZMkBY7K3Dn04YQ65@dhcp22.suse.cz> <CAD=FV=V5hx7Zy-XMB=sPYcD_h-iP5VknmEoJwvw3Akd_1wDnRw@mail.gmail.com>
 <ZMkkNpYcaYPAMj0Z@dhcp22.suse.cz> <CAD=FV=Ujmyq-1GAvNJsrp=mj_Vg=9b6fmfMfkHq3+8ZQ5KiaRw@mail.gmail.com>
 <ZMoFWK0uGdneJYVc@dhcp22.suse.cz>
In-Reply-To: <ZMoFWK0uGdneJYVc@dhcp22.suse.cz>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 2 Aug 2023 07:12:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XQMH8sun7XCXJNjOC7tP1yt8=mt1NG3f8Xm9-x5TJFsA@mail.gmail.com>
Message-ID: <CAD=FV=XQMH8sun7XCXJNjOC7tP1yt8=mt1NG3f8Xm9-x5TJFsA@mail.gmail.com>
Subject: Re: [PATCH] watchdog/hardlockup: Avoid large stack frames in watchdog_hardlockup_check()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        kernel test robot <lkp@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 2, 2023 at 12:27=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Tue 01-08-23 08:41:49, Doug Anderson wrote:
> [...]
> > Ah, I see what you mean. The one issue I have with your solution is
> > that the ordering of the stack crawls is less ideal in the "dump all"
> > case when cpu !=3D this_cpu. We really want to see the stack crawl of
> > the locked up CPU first and _then_ see the stack crawls of other CPUs.
> > With your solution the locked up CPU will be interspersed with all the
> > others and will be harder to find in the output (you've got to match
> > it up with the "Watchdog detected hard LOCKUP on cpu N" message).
> > While that's probably not a huge deal, it's nicer to make the output
> > easy to understand for someone trying to parse it...
>
> Is it worth to waste memory for this arguably nicer output? Identifying
> the stack of the locked up CPU is trivial.

I guess it's debatable, but as someone who has spent time staring at
trawling through reports generated like this, I'd say "yes", it's
super helpful in understanding the problem to have the hung CPU first.
Putting the memory usage in perspective:

* On a kernel built with a more normal number of max CPUs, like 256,
this is only a use of 32 bytes of memory. That's 8 CPU instructions
worth of memory.

* Even on a system with the largest number of max CPUs we currently
allow (8192), this is only a use of 1024 bytes of memory. Sure, that's
a big chunk, but this is also something on our largest systems.

In any case, how about this. We only need the memory allocated if
`sysctl_hardlockup_all_cpu_backtrace` is non-zero. I can hook in
whenever that's changed (should be just at bootup) and then kmalloc
memory then. This really limits the extra memory to just cases when
it's useful. Presumably on systems that are designed to run massively
SMP they wouldn't want to turn this knob on anyway since it would spew
far too much data. If you took a kernel compiled for max SMP, ran it
on a machine with only a few cores, and wanted this feature turned on
then at most you'd be chewing up 1K. In the average case this would
chew up some extra memory (extra CPU instructions to implement the
function take code space, extra overhead around kmalloc) but it would
avoid the 1K chunk in most cases.

Does that sound reasonable?

I guess my last alternative would be to keep the special case of
tracing the hung CPU first (this is the most important part IMO) and
then accept the double trace, AKA:

/* Try to avoid re-dumping the stack on the hung CPU if possible */
if (cpu =3D=3D this_cpu))
  trigger_allbutself_cpu_backtrace();
else
  trigger_all_cpu_backtrace();

-Doug
