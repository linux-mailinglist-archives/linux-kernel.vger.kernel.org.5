Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE0776F430
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjHCUrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjHCUrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:47:25 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A5A423F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 13:47:23 -0700 (PDT)
Date:   Thu, 03 Aug 2023 20:46:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1691095638; x=1691354838;
        bh=fDIIkd6MbiuxDhWddMCvr1sTep0tBPtwcVzo2Vbd5+0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Lhk+WfXL0POi8w3MDDk+N+KGTUQcqdjQrn8XFERNWJUn8+EqTEyoNj+1qgvqiHmOr
         Q5Tl3f+NphgZlfvdUEs3rlX2K+t5yLNDKpw2m2yb8XcIDywXmMU5JlIjo/EOVjVwk3
         /8Pw89zebfKZPWJnGBWTPj8n6ehMLjGzBa5TfKCuxbCB5UFIKXLMhODfAMIzrHGNlx
         f5CLF4nA+oe7Opl9vFCt3TO4NhbpoyMvy6h/TygIuDupNwmdq4N43n9iwtQKfokHhL
         k3qeU1FwqxumT6Wu3s3k8cG8zwusNH+qviuuE/+Yi3Osu7HI0ZspzIoUcdXH0JUhdC
         /R6eiiIgSZyHQ==
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
Message-ID: <TR8IBdXbd0C4U8Z4zf9ZLEH66QMutWs0QAAkPnMlKiOvgEZCk6AfEIPcIfRC555XWs8eSzeCCCW9R-3NwxZg6hDhPvPseAgAULAdUQ6epDA=@emersion.fr>
In-Reply-To: <20230803204459.GD27752@pendragon.ideasonboard.com>
References: <20230729004913.215872-1-dmitry.baryshkov@linaro.org> <20230729004913.215872-4-dmitry.baryshkov@linaro.org> <20230802185547.GC32500@pendragon.ideasonboard.com> <a32ce695-038f-0ef8-3584-5bd1ba528131@linaro.org> <20230802191351.GA1407@pendragon.ideasonboard.com> <DE2B4523-D16C-4AFC-8352-212B23548DD5@linaro.org> <b6oOVz2YMIG4hJDWhq9lTh6R2HYcrpRwHENhplig9KSQMD8dIjTgC5KdH1Ij3URgV2HESp67Ax7QUsByGjMLouvbs-5q7PiPRdLkgJz6Fwk=@emersion.fr> <ADjuOeqA6575DKutMPaR9mW9rLhm-wjLc4ruoUkNwImf-GB90FdwDB7v7y6LFdzVG3BC4R52A0RUtStK4_smmGYTUs3UPDOX4T4Zl2YHkxE=@emersion.fr> <20230803204459.GD27752@pendragon.ideasonboard.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 3rd, 2023 at 22:44, Laurent Pinchart <laurent.pinchart@=
ideasonboard.com> wrote:

> On Thu, Aug 03, 2023 at 03:31:16PM +0000, Simon Ser wrote:
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
> Doesn't this contradict the example use case you gave in your previous
> e-mail, with wlroots stating "DP-3 via DVI-D" ? I understand that as DP
> carried over a DVI-D physical connector, did I get it wrong ?

No, this is DVI carried over DP. DP cannot be carried over VGA/DVI/HDMI,
but VGA/DVI/HDMI can be carried over DP.
