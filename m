Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7E080F9A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377541AbjLLVpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377344AbjLLVpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:45:23 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFA0B7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:45:29 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so711323766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702417528; x=1703022328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJCdGKISotv2pJZ+hBcpKEM/45HxdS8m491Gp3+BQ4k=;
        b=jrn4JmrwLj/wAYQmTRabSvSJ5jluhWevaSXS8+Wvx0kjluYQ+VLJJE7oXPaPm+SLXe
         aL3rUiQJHI08+wMMocMdzAu6/vRTu1zfrQOiWUNqsH626nkGmRZiTIjAeM7v2E95xv6q
         w+2aqXe77wi1QFnQvveXOISK6AvSVGFLkPBZta0T/1f5JUkA2iyrlAOmAsP0aKvY/kws
         YBvGsN/vUYs6Qs7j5NRIJcN9lUiwaOsH4yMbtUekdb6rZxCgRHDpIM/8hIcyCebAnLoN
         oxpK1hZAQlvWmEOADv9xyO9q5kl7b98GOhUrcLO9knhBHYhuPl9gSBMgcKg7VSj9ggoT
         USRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702417528; x=1703022328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJCdGKISotv2pJZ+hBcpKEM/45HxdS8m491Gp3+BQ4k=;
        b=kZJZnRQMYKNKfndNasMcHbQEyY3fmDhuScCuoPU6Qzkd3ARHO8IjhkMhn4F4AblQwC
         bt+zzfziLqJRad76tmYr99HcYI788YVuaadgYR1Ncr3O9C/C0cFi1T4fGL43W1rljS+X
         GDjNW59fb6z0lbLaxDXaAEImfkkNV+UOTk1m630AbQa+i1mU+G6yS11XtA59K0LyYscr
         rgS5jXH8XVwFpjr3b+8G1awYl3FAVEV6GS1j+LFnKtte7pfj0mDWgEQaqZBQye6qZRt0
         YrlWBer7FwcmmqzjdApZQm1lG6XCIgW/BaqDHtVUvejL3dAijjIrS1wF+emkZxMAVOdj
         FMVw==
X-Gm-Message-State: AOJu0YzXTGsSqfK5stBWzGEnx/iLrt0T5oX7GnIOB6z9RtmX3MTzDFg0
        CU83E+O6EFX1RXjmGjfT/U3YM6XxflulUzQtJns4fQ==
X-Google-Smtp-Source: AGHT+IGf5gzmD+F1vkXOu2tcCBuGrRoRRXqRBUwUV+cVy2Hso3cw8EdmMC/vWvmcYkVNE5dnxlCx+uUI1L46s1J0lTg=
X-Received: by 2002:a17:906:2d2:b0:a1f:821a:11ae with SMTP id
 18-20020a17090602d200b00a1f821a11aemr3419980ejk.20.1702417527636; Tue, 12 Dec
 2023 13:45:27 -0800 (PST)
MIME-Version: 1.0
References: <MEYP282MB2697C6AC993637C6E866E492BB8FA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <MEYP282MB2697C6AC993637C6E866E492BB8FA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 12 Dec 2023 22:44:51 +0100
Message-ID: <CAMZdPi-ZxN+eGpHERe1XQ2hyu==bnwx2oHcbzVFtgcfS1k6C_w@mail.gmail.com>
Subject: Re: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump support
To:     Jinjian Song <SongJinJian@hotmail.com>
Cc:     "chandrashekar.devegowda@intel.com" 
        <chandrashekar.devegowda@intel.com>,
        "chiranjeevi.rapolu@linux.intel.com" 
        <chiranjeevi.rapolu@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "danielwinkler@google.com" <danielwinkler@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "haijun.liu@mediatek.com" <haijun.liu@mediatek.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxwwan@intel.com" <linuxwwan@intel.com>,
        "m.chetan.kumar@linux.intel.com" <m.chetan.kumar@linux.intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "nmarupaka@google.com" <nmarupaka@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "ricardo.martinez@linux.intel.com" <ricardo.martinez@linux.intel.com>,
        "ryazanov.s.a@gmail.com" <ryazanov.s.a@gmail.com>,
        "vsankar@lenovo.com" <vsankar@lenovo.com>,
        Joey Zhao <joey.zhao@fibocom.com>,
        "Qifeng Liu(Qifeng)" <liuqf@fibocom.com>,
        "Fuqiang Yan(Felix)" <felix.yan@fibocom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jinjian,

On Mon, 11 Dec 2023 at 03:06, Jinjian Song <SongJinJian@hotmail.com> wrote:
>
> > > > Mon, Sep 18, 2023 at 08:56:26AM CEST, SongJinJian@hotmail.com wrote=
:
> > > >Tue, Sep 12, 2023 at 11:48:40AM CEST, songjinjian@hotmail.com wrote:
> > > >>>Adds support for t7xx wwan device firmware flashing & coredump
> > > >>>collection using devlink.
> > > >
> > > >>I don't believe that use of devlink is correct here. It seems like =
a misfit. IIUC, what you need is to communicate with the modem. Basically a=
 communication channel to modem. The other wwan drivers implement these cha=
nnels in _ctrl.c files, using multiple protocols. Why can't you do somethin=
g similar and let devlink out of this please?
> > > >
> > > >>Until you put in arguments why you really need devlink and why is i=
t a good fit, I'm against this. Please don't send any other versions of thi=
s patchset that use devlink.
> > > >
> > > > Yes, t7xx driver need communicate with modem with a communication c=
hannel to modem.
> > > > I took a look at the _ctrl.c files under wwan directory, it seemed =
the implementation can be well integrated with QualCommon's modem, if we do=
 like this, I think we need modem firmware change, maybe not be suitable fo=
r current MTK modem directly.
> > > > Except for Qualcomm modem driver, there is also an Intel wwan
> > > > driver 'iosm' and it use devlink to implement firmware
> > > > flash(https://www.kernel.org/doc/html/latest/networking/devlink/io
> > > > sm.html), Intel and MTK design and use devlink to do this work on
> > >
> > > If that exists, I made a mistake as a gatekeeper. That usage looks
> > > wrong.
> > >
> > > > 'mtk_t7xx' driver and I continue to do this work.
> > > >
> > > > I think devlink framework can support this scene and if we use devl=
ink we don't need to develop other flash tools or other user space applicat=
ions, use upstream devlink commands directly.
> > >
> > > Please don't.
>
> > So this is clear that devlink should not be used for this wwan
> firmware upgrade, if you still want to abstract the fastboot protocol par=
t, maybe the easier would be to move on the generic firmware framework, and=
 especially the firmware upload API which seems to be a good fit here? http=
s://docs.kernel.org/driver-api/firmware/fw_upload.html#firmware-upload-api
>
> 1.This API seemed fit here, but I haven't find the refer to use the API, =
codes in /lib/test_firmware.c shown some intruduce, I think if I'm consider=
 how to implement ops.prepare(what to verify, it seemed modem will do that)=
 and ops.poll_complete? And it seemed request_firmware API also can recieve=
 the data from use space, is it a way to use sysfs to trigger request firmw=
are to kernel?
>
> In addition to this, I may have to create sysfs interface to pass the fir=
mware partition parameter.And find a nother way to export the coredump port=
 to user space.
>
> 2.How about we add a new WWAN port type, abstract fastboot and dump chann=
el, like WWAN_PORT_XXX, then use this port with WWAN framework to handle fi=
rmware ops and dump ops.
>
> Hope to get your advice, thanks very much.
>
> I want to implement it use the way of title 2, create a new WWAN port typ=
e used for the channel with modem.

I understand that the firmware update may not be as simple as
submitting a single blob, and so firmware-upload-api may not be easy
to use as is. But can you elaborate a bit on 'abstracting fastboot',
not sure why it is necessary to add another abstraction level when
fastboot is already supported by open source tools/libraries.

Regards,
Loic
