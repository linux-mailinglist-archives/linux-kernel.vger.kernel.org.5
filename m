Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B483B79DE6D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 05:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbjIMDAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 23:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjIMDAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 23:00:51 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F16171E;
        Tue, 12 Sep 2023 20:00:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52e5900cf77so8111602a12.2;
        Tue, 12 Sep 2023 20:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694574046; x=1695178846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0Ql+Umm198s7EODjUTAFVn1Eek/7t8Ja/ENb4v1xqU=;
        b=TemaMNVNrUp9WnJKSE+nzrvh+fLsA133vDvMBSDIs/EznNFxYyceoiXoV6eHSAI1IG
         FfyOwA2dhB2Lc9fQZMn+k1CPaNZmM7M6y5XRFQ1IXbLBZblMwAMXUL8JOlzGq/aT5Ehv
         lVxL+3xYIfH30XEaksvAvpQ2iyqqZPF/flOLVbxrsPOsrHdDj3oWBuH698ASRUHDgM5o
         rrfvaSsI3jYJEXQDV9lyHCUj8YVYZ8oPXlR3JwQLX3HvqbP3RA8Nxd7HS8s6fchgfoLc
         mJwO46sQQBQCFMl79H8hIsvLznGjmIjxNlVnCluF1L0Q90XbKzpIPesZqzd95jSO4K3+
         xNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694574046; x=1695178846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0Ql+Umm198s7EODjUTAFVn1Eek/7t8Ja/ENb4v1xqU=;
        b=R55HVhcsMtcmqhMI074IaiXfuTTstgcZNTGCfyO5xGJJhAFgW+9BTi5SB8dF8R4KDf
         NGxtdX+QKRCrIGArmW/+EqRnKg4YW0FmtGjvNnqFX9u+gYXzVfDnagcKnHuHIUSyskrM
         UcIehyC26mjAZqIMbm2dtDZajCZ4RayVfeM7dDkSjwO4rXvsGYQjmIWLd6j7TFxrtQhg
         m6bLGGFHGYMqyn+/sZcmcEagjjBeG03ZiKCiso3hM1uadNqkb4CpOioxDv2tGm0DIsmE
         0HojFQolGu3dFD0ato8ceYhnULDZp/IkgpxQgu2GGpN1tafOJ691rBqxV2NlBFkJc38U
         /xdQ==
X-Gm-Message-State: AOJu0Yx7TiNMym7fJc80/4G92zMqnPgVXAmsvJS9qD8MJCoOj+dMaX1A
        EGf2RVO4CMaXak/f/AvFNUUyMxdczo6RhjsY9e8=
X-Google-Smtp-Source: AGHT+IF0JSzHjtYwGdSyOBax8j/JP+0/XQuGOwuSzxEWvZ+fOgRCHl3kCpfR7eSsYL6DFD5DKB7OxY64M0Kcu7YHNxI=
X-Received: by 2002:a05:6402:6c7:b0:525:570c:566b with SMTP id
 n7-20020a05640206c700b00525570c566bmr1017895edy.22.1694574045793; Tue, 12 Sep
 2023 20:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
 <20230903214150.2877023-2-dmitry.baryshkov@linaro.org> <ZPbrtAlO2Y+bjDhf@kuha.fi.intel.com>
 <CAA8EJpqUg2-k7LLBL38RHU1sThkXB54ca68xEMd1yMnHQcQ++w@mail.gmail.com>
 <ZPh0Ps9UJ3HLzdeR@kuha.fi.intel.com> <CAA8EJpratbBybgk8woD3maA=J_HuQis44Unq0n+c_UvaFs__AA@mail.gmail.com>
 <ZPiAwOf00RREiYPr@kuha.fi.intel.com> <6b6bacee-f7b6-4cfe-be3d-24bda44bfbcf@linaro.org>
In-Reply-To: <6b6bacee-f7b6-4cfe-be3d-24bda44bfbcf@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 12 Sep 2023 20:00:33 -0700
Message-ID: <CAF6AEGvjPBETONoNet_wfR2c1o38eJ1JuajLYheMA-zvObeYBg@mail.gmail.com>
Subject: Re: [Freedreno] [RFC PATCH v1 01/12] Revert "drm/sysfs: Link DRM
 connectors to corresponding Type-C connectors"
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Janne Grunau <j@jannau.net>, Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andy Gross <agross@kernel.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonas Karlman <jonas@kwiboo.se>, linux-arm-msm@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Won Chung <wonchung@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 2:15=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 06/09/2023 16:38, Heikki Krogerus wrote:
> > On Wed, Sep 06, 2023 at 03:48:35PM +0300, Dmitry Baryshkov wrote:
> >> On Wed, 6 Sept 2023 at 15:44, Heikki Krogerus
> >> <heikki.krogerus@linux.intel.com> wrote:
> >>>
> >>> On Tue, Sep 05, 2023 at 01:56:59PM +0300, Dmitry Baryshkov wrote:
> >>>> Hi Heikki,
> >>>>
> >>>> On Tue, 5 Sept 2023 at 11:50, Heikki Krogerus
> >>>> <heikki.krogerus@linux.intel.com> wrote:
> >>>>>
> >>>>> Hi Dmitry,
> >>>>>
> >>>>> On Mon, Sep 04, 2023 at 12:41:39AM +0300, Dmitry Baryshkov wrote:
> >>>>>> The kdev->fwnode pointer is never set in drm_sysfs_connector_add()=
, so
> >>>>>> dev_fwnode() checks never succeed, making the respective commit NO=
P.
> >>>>>
> >>>>> That's not true. The dev->fwnode is assigned when the device is
> >>>>> created on ACPI platforms automatically. If the drm_connector fwnod=
e
> >>>>> member is assigned before the device is registered, then that fwnod=
e
> >>>>> is assigned also to the device - see drm_connector_acpi_find_compan=
ion().
> >>>>>
> >>>>> But please note that even if drm_connector does not have anything i=
n
> >>>>> its fwnode member, the device may still be assigned fwnode, just ba=
sed
> >>>>> on some other logic (maybe in drivers/acpi/acpi_video.c?).
> >>>>>
> >>>>>> And if drm_sysfs_connector_add() is modified to set kdev->fwnode, =
it
> >>>>>> breaks drivers already using components (as it was pointed at [1])=
,
> >>>>>> resulting in a deadlock. Lockdep trace is provided below.
> >>>>>>
> >>>>>> Granted these two issues, it seems impractical to fix this commit =
in any
> >>>>>> sane way. Revert it instead.
> >>>>>
> >>>>> I think there is already user space stuff that relies on these link=
s,
> >>>>> so I'm not sure you can just remove them like that. If the componen=
t
> >>>>> framework is not the correct tool here, then I think you need to
> >>>>> suggest some other way of creating them.
> >>>>
> >>>> The issue (that was pointed out during review) is that having a
> >>>> component code in the framework code can lead to lockups. With the
> >>>> patch #2 in place (which is the only logical way to set kdev->fwnode
> >>>> for non-ACPI systems) probing of drivers which use components and se=
t
> >>>> drm_connector::fwnode breaks immediately.
> >>>>
> >>>> Can we move the component part to the respective drivers? With the
> >>>> patch 2 in place, connector->fwnode will be copied to the created
> >>>> kdev's fwnode pointer.
> >>>>
> >>>> Another option might be to make this drm_sysfs component registratio=
n optional.
> >>>
> >>> You don't need to use the component framework at all if there is
> >>> a better way of determining the connection between the DP and its
> >>> Type-C connector (I'm assuming that that's what this series is about)=
.
> >>> You just need the symlinks, not the component.
> >>
> >> The problem is that right now this component registration has become
> >> mandatory. And if I set the kdev->fwnode manually (like in the patch
> >> 2), the kernel hangs inside the component code.
> >> That's why I proposed to move the components to the place where they
> >> are really necessary, e.g. i915 and amd drivers.
> >
> > So why can't we replace the component with the method you are
> > proposing in this series of finding out the Type-C port also with
> > i915, AMD, or whatever driver and platform (that's the only thing that
> > component is used for)?
>
> The drm/msm driver uses drm_bridge for the pipeline (including the last
> DP entry) and the drm_bridge_connector to create the connector. I think
> that enabling i915 and AMD drivers to use drm_bridge fells out of scope
> for this series.
>
>
> > Determining the connection between a DP and its Type-C connector is
> > starting to get really important, so ideally we have a common solution
> > for that.
>
> Yes. This is what we have been discussing with Simon for quite some time
> on #dri-devel.
>
> Unfortunately I think the solution that got merged was pretty much
> hastened in instead of being well-thought. For example, it is also not
> always possible to provide the drm_connector / typec_connector links (as
> you can see from the patch7. Sometimes we can only express that this is
> a Type-C DP connector, but we can not easily point it to the particular
> USB-C port.
>
> So, I'm not sure, how can we proceed here. Currently merged patch breaks
> drm/msm if we even try to use it by setting kdef->fwnode to
> drm_connector->fwnode. The pointed out `drivers/usb/typec/port-mapper.c`
> is an ACPI-only thing, which is not expected to work in a non-ACPI cases.

In these cases we revert and try again next cycle

BR,
-R

>
> --
> With best wishes
> Dmitry
>
