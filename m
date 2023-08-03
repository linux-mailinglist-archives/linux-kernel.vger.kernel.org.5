Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAD676EDF9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjHCPWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbjHCPWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:22:31 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2FB10EA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:22:22 -0700 (PDT)
Date:   Thu, 03 Aug 2023 15:22:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1691076139; x=1691335339;
        bh=k5I++nvJ7Xqg3Fp+Q+60Yxv68PVfC3iWMrivxLIDp90=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=n0lAB4Sl1hGuc7fNVTs22fy2VshY42XLwZbz2alwhPOc8N46hQt40qVPZVcT/V/hS
         S4PC4ARMfSbJdpomhr8ohgPUk5a17ax6lWt1Uk5b7iYsZ280gdNYw/xx2kfd9sMiEC
         ITQuwAoysOAVumyAbEJZ2OFov3Z2nwNtRYbm8CY1RVoEdw05lXSLvTlxsjtzafBuhq
         FYJV6hByuV6MXBKMiPEl+oAYW/BGQLYBODnGiBD2yYbKljFaCwg++9U2/z7N1o8878
         mWXa4xMgoe0Qtj0eU6R6p8mKggYnoOMIiGdVu/TVv8BTpBOjCqJ57srI3k5/iRtJ05
         7rnaacE2kZ8uA==
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Janne Grunau <j@jannau.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 3/4] drm/uapi: document the USB subconnector type
Message-ID: <b6oOVz2YMIG4hJDWhq9lTh6R2HYcrpRwHENhplig9KSQMD8dIjTgC5KdH1Ij3URgV2HESp67Ax7QUsByGjMLouvbs-5q7PiPRdLkgJz6Fwk=@emersion.fr>
In-Reply-To: <DE2B4523-D16C-4AFC-8352-212B23548DD5@linaro.org>
References: <20230729004913.215872-1-dmitry.baryshkov@linaro.org> <20230729004913.215872-4-dmitry.baryshkov@linaro.org> <20230802185547.GC32500@pendragon.ideasonboard.com> <a32ce695-038f-0ef8-3584-5bd1ba528131@linaro.org> <20230802191351.GA1407@pendragon.ideasonboard.com> <DE2B4523-D16C-4AFC-8352-212B23548DD5@linaro.org>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 2nd, 2023 at 21:23, Dmitry Baryshkov <dmitry.baryshkov=
@linaro.org> wrote:

> >> >> +=09{ DRM_MODE_SUBCONNECTOR_USB,=09     "USB"       }, /* DP */
> >> >
> >> > Should this be DRM_MODE_SUBCONNECTOR_USB_C and "USB-C", in case we g=
et
> >> > another USB type later ?
> >>
> >> Hmm, which id should I use for micro-USB then? (consider anx7808,
> >> SlimPort). I thought about using DRM_MODE_SUBCONNECTOR_USB for both of
> >> them. But maybe I should add another subtype for SlimPort.
> >
> >I suppose it depends on whether userspace needs a way to differentiate
> >those. Do you have a good visibility on the userspace use cases ?
>=20
> No. I'm not even sure, which userspace handles subtypes properly.

wlroots uses it for human-readable output descriptions, e.g.

    > wayland-info
    interface: 'wl_output',                                  version:  4, n=
ame: 49
    =09name: DP-3
    =09description: Samsung Electric Company SyncMaster HS3P505873 (DP-3 vi=
a DVI-D)

The "via DVI-D" bit comes from subconnector.

The description is displayed to the user when picking an output to screen
capture, among other things. It is helpful to users because they can better
understand why their output connected via DVI shows up as "DP".

The KMS docs describe "subconnector" to be defined as "downstream port" for=
 DP.
Can USB-C (or USB) be seen as a DP downstream port?
