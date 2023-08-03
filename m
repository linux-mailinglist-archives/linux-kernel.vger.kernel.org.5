Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B21E76EE72
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbjHCPnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237208AbjHCPni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:43:38 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534EE35B5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:43:36 -0700 (PDT)
Date:   Thu, 03 Aug 2023 15:43:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1691077413; x=1691336613;
        bh=BBP2N35iv+TqeJMWI2iqlYWFErJ4Za6QEiZFTOjdzB4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=KNGQPx6R1J+TwnF3ps8/cb5fj9VHSkxvb70Ugdd4tV0JhCAsxXrvTf4bDR3FHqseC
         W9QcBbsHbAdQKtmf3VBkPWfNn0UJW0G6RZWgVUc1LvgDsDpcctNkHNqZ/7OGCOILzx
         cmDzkQZ/jRcj5WxRysh6hyGmaygkL5/ehTz1Sv0BVENcquG0xlr5gGkSWnh4fOri+Q
         Fatbm7ylCTgLxJicogPX3bZ40LCtTHgwitXsVsFtiiPEOYE7LegoPHcvKApf1wus41
         wIP9NydXUtkpMgP18K5sgU9Mrzc9PN4Zchb65roXha2CAeEwMHJp+/MuJD7C9EWg6g
         +rYCknq4JHNSA==
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
Message-ID: <C-Fu9j3hts_YcQxukEbidrKyTdqYNxYuWUX-694HnmYKiJGZip24s6R8-dULdTvb2VE972he3PZlju2K9wFNkA9j-XKUGemuWiFLGT1eUu0=@emersion.fr>
In-Reply-To: <CAA8EJppCECObEe5UG3LsHUsmYfKzakWzVw33S4nVc=DB9sA0ig@mail.gmail.com>
References: <20230729004913.215872-1-dmitry.baryshkov@linaro.org> <20230729004913.215872-4-dmitry.baryshkov@linaro.org> <20230802185547.GC32500@pendragon.ideasonboard.com> <a32ce695-038f-0ef8-3584-5bd1ba528131@linaro.org> <20230802191351.GA1407@pendragon.ideasonboard.com> <DE2B4523-D16C-4AFC-8352-212B23548DD5@linaro.org> <b6oOVz2YMIG4hJDWhq9lTh6R2HYcrpRwHENhplig9KSQMD8dIjTgC5KdH1Ij3URgV2HESp67Ax7QUsByGjMLouvbs-5q7PiPRdLkgJz6Fwk=@emersion.fr> <ADjuOeqA6575DKutMPaR9mW9rLhm-wjLc4ruoUkNwImf-GB90FdwDB7v7y6LFdzVG3BC4R52A0RUtStK4_smmGYTUs3UPDOX4T4Zl2YHkxE=@emersion.fr> <CAA8EJppCECObEe5UG3LsHUsmYfKzakWzVw33S4nVc=DB9sA0ig@mail.gmail.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 3rd, 2023 at 17:36, Dmitry Baryshkov <dmitry.baryshkov@=
linaro.org> wrote:

> On Thu, 3 Aug 2023 at 18:31, Simon Ser contact@emersion.fr wrote:
>=20
> > On Thursday, August 3rd, 2023 at 17:22, Simon Ser contact@emersion.fr w=
rote:
> >=20
> > > The KMS docs describe "subconnector" to be defined as "downstream por=
t" for DP.
> > > Can USB-C (or USB) be seen as a DP downstream port?
> >=20
> > To expand on this a bit: I'm wondering if we're mixing apples and
> > oranges here. The current values of "subconnector" typically describe
> > the lower-level protocol tunneled inside DP. For instance, VGA can be
> > tunneled inside the DP cable when using DP =E2=86=92 VGA adapter.
>=20
> My opinion hasn't changed: I think this should be the USB connector
> with proper DP / DVI / HDMI / etc. subconnector type (or lack of it).
> In the end, the physical connector on the side of laptop is USB-C.

- Even if the connector is USB-C, the protocol used for display is
  still DP. There's also the case of Thunderbolt.
- This is inconsistent with existing drivers. i915 and amdgpu expose
  DP ports for their USB-C ports. Changing that isn't possible without
  causing user-space regressions (compositor config files use the
  connector type).
