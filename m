Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B467E6D42
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbjKIPWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbjKIPWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:22:11 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AACB358C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:22:08 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo1536516a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 07:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699543327; x=1700148127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9yjPWyHeNycl0+imrePDdHzNT0Kg7J5k0khv5k91C0=;
        b=pcHcFrqPvgTUd5tzeSd+WXY9pVviQbl3wa6IIm/r/Ng8uA7ktaL1k438Kmmtn3zakg
         8uIKrhZ6Wsf7t2fdHxOk8fMm4V7+UMp1x2ymzJNxre40gPtG7cCqG8rihQZLTKh0Eqxr
         WIwt/5U2NQPicA2W+jZzZCywVf+kQtOC+1pscT+oQsQgSQBpl3KwXqnYewe0ffLl0s63
         +x67V3c7V7UZgcQTJGh+jBJ0tjKSWtoJC9dfJ25Fvx3VuocnabnQVjut1x98MAw8uq9h
         gdJXCyGksKxjPlxJ6ZSOgz33S/saG38p4PzQ2KOWFgbx5J5wV2Ea20/Kn43yEO1/nGjV
         cttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699543327; x=1700148127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9yjPWyHeNycl0+imrePDdHzNT0Kg7J5k0khv5k91C0=;
        b=Jkrjo256yu1jmuzppc5ulO9hCORmMiyaDGPszDSSYsFUCxpxzn5x1bGIjDp3V35HKy
         UVXI6s2d4DV7b16qPxIBvyZj2aX+ndvSFT5UkLfJQnXhUgvu0AzO6UyHGAWnWGAt/TWm
         2uQzPlKd8zwSNSK3YYkFqHWmGhxENKlv9Buot+OldZkPSJjIwlZcU8c3IIE4nrxGoSDc
         mysqWfdt9J+t4qWybgd88LOogAu42UKxsCfDkoTP6rHRSim8L9bgIpvYNjuhox9bJL+5
         uhVo1w47ymSm6GruHVCv/4d8jd07C0NLjBNEsYI34Glo+skZj03qt6avzAGb/SwC6WQd
         hEIA==
X-Gm-Message-State: AOJu0Yxhb5CywyZoWwbE6Z/uaks4jw8UbB+pzGejyYMHx8zqu8/LL1qx
        lnhDoPq2SzeDJr1Lsmwv64Uvf5hLk2sPoqzU1HM9iw==
X-Google-Smtp-Source: AGHT+IGfFfytWgw6WCJi+cIYFYSMlq2RtHRv6vUnGFf1YjYKjtrl0mDF3Pa7FnwbCea9sEsFjZQpYGUtuPm45qSgWfY=
X-Received: by 2002:a50:c31a:0:b0:540:1824:b8d0 with SMTP id
 a26-20020a50c31a000000b005401824b8d0mr4333869edb.3.1699543327038; Thu, 09 Nov
 2023 07:22:07 -0800 (PST)
MIME-Version: 1.0
References: <MEYP282MB2697B33940B6E9F3BA802729BBFBA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
 <ZUTOX0oSCPpdtjJV@nanopsycho>
In-Reply-To: <ZUTOX0oSCPpdtjJV@nanopsycho>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 9 Nov 2023 16:21:30 +0100
Message-ID: <CAMZdPi-GgchY2tWobFSohCzc2eBq=dUsSJS5qu_LW3xAPLVwBQ@mail.gmail.com>
Subject: Re: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump support
To:     "SongJinJian@hotmail.com" <songjinjian@hotmail.com>
Cc:     Jiri Pirko <jiri@resnulli.us>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "ryazanov.s.a@gmail.com" <ryazanov.s.a@gmail.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "chandrashekar.devegowda@intel.com" 
        <chandrashekar.devegowda@intel.com>,
        "linuxwwan@intel.com" <linuxwwan@intel.com>,
        "chiranjeevi.rapolu@linux.intel.com" 
        <chiranjeevi.rapolu@linux.intel.com>,
        "haijun.liu@mediatek.com" <haijun.liu@mediatek.com>,
        "m.chetan.kumar@linux.intel.com" <m.chetan.kumar@linux.intel.com>,
        "ricardo.martinez@linux.intel.com" <ricardo.martinez@linux.intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nmarupaka@google.com" <nmarupaka@google.com>,
        "vsankar@lenovo.com" <vsankar@lenovo.com>,
        "danielwinkler@google.com" <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi JinJian,

On Fri, 3 Nov 2023 at 11:41, Jiri Pirko <jiri@resnulli.us> wrote:
>
> Mon, Sep 18, 2023 at 08:56:26AM CEST, SongJinJian@hotmail.com wrote:
> >Tue, Sep 12, 2023 at 11:48:40AM CEST, songjinjian@hotmail.com wrote:
> >>>Adds support for t7xx wwan device firmware flashing & coredump
> >>>collection using devlink.
> >
> >>I don't believe that use of devlink is correct here. It seems like a mi=
sfit. IIUC, what you need is to communicate with the modem. Basically a com=
munication channel to modem. The other wwan drivers implement these channel=
s in _ctrl.c files, using multiple protocols. Why can't you do something si=
milar and let devlink out of this please?
> >
> >>Until you put in arguments why you really need devlink and why is it a =
good fit, I'm against this. Please don't send any other versions of this pa=
tchset that use devlink.
> >
> > Yes, t7xx driver need communicate with modem with a communication chann=
el to modem.
> > I took a look at the _ctrl.c files under wwan directory, it seemed the =
implementation can be well integrated with QualCommon's modem, if we do lik=
e this, I think we need modem firmware change, maybe not be suitable for cu=
rrent MTK modem directly.
> > Except for Qualcomm modem driver, there is also an Intel wwan driver 'i=
osm' and it use devlink to implement firmware flash(https://www.kernel.org/=
doc/html/latest/networking/devlink/iosm.html), Intel and MTK design and use=
 devlink to do this work on
>
> If that exists, I made a mistake as a gatekeeper. That usage looks
> wrong.
>
>
> > 'mtk_t7xx' driver and I continue to do this work.
> >
> > I think devlink framework can support this scene and if we use devlink =
we don't need to develop other flash tools or other user space applications=
, use upstream devlink commands directly.
>
> Please don't.

So this is clear that devlink should not be used for this wwan
firmware upgrade, if you still want to abstract the fastboot protocol
part, maybe the easier would be to move on the generic firmware
framework, and especially the firmware upload API which seems to be a
good fit here? https://docs.kernel.org/driver-api/firmware/fw_upload.html#f=
irmware-upload-api

Regards,
Loic
