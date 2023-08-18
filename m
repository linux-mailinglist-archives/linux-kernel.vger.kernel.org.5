Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3736B7805DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 08:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356332AbjHRGZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 02:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240592AbjHRGYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 02:24:53 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962E010C0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 23:24:51 -0700 (PDT)
Date:   Fri, 18 Aug 2023 06:24:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1692339889; x=1692599089;
        bh=nairp59cuWUAchL6Zy0UjEcGhD+YFI/njR1gP8bry3U=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=C7GjTr6bdEjpnI/FIWCZIho18m9/DIUEAUDap0ASSXDLBtpnGJJWt0F5WC52OW9Ys
         WiBSga8+iYIElI63nS1km/Hmy246U20v31weBXxnIkc4DSWx0p5hL7cYtJ7BfwsiPv
         9OpFBGpjFYdeuYSpE/6gknWo1xv1CV13jVsfHEoD9ELV+jDYVpFfhhPxzxdsiyFzDr
         vzUWfb1/hzhCV9riML/Kkdpsixa+BeCsgdr6QKm6PQI7FrQXCLLxIo5sm5Hdo8Hx/j
         PMcEtcHFT+O40rGx8wtLucySGotpDR8FPPK3Nb2oPn1bY/GQiypX0lywMQur8nyqrG
         zwEnch7FxI6aA==
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Janne Grunau <j@jannau.net>, Robert Foss <rfoss@kernel.org>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonas Karlman <jonas@kwiboo.se>, Leo Li <sunpeng.li@amd.com>,
        intel-gfx@lists.freedesktop.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 3/4] drm/uapi: document the USB subconnector type
Message-ID: <gIjbz8oq8AuY8E5_XGKnJNjIyQK9SDxp2-3Ep-Dr3D9T_-iUIt-q-oFgarZor4jtdI3682ZtuvQnaQBhTrc5OR6G2sqvDxbmxGZmcRrBAio=@emersion.fr>
In-Reply-To: <d9f9c272-ce9b-4599-bb11-1c026087ead3@linaro.org>
References: <20230729004913.215872-1-dmitry.baryshkov@linaro.org> <a32ce695-038f-0ef8-3584-5bd1ba528131@linaro.org> <20230802191351.GA1407@pendragon.ideasonboard.com> <DE2B4523-D16C-4AFC-8352-212B23548DD5@linaro.org> <b6oOVz2YMIG4hJDWhq9lTh6R2HYcrpRwHENhplig9KSQMD8dIjTgC5KdH1Ij3URgV2HESp67Ax7QUsByGjMLouvbs-5q7PiPRdLkgJz6Fwk=@emersion.fr> <ADjuOeqA6575DKutMPaR9mW9rLhm-wjLc4ruoUkNwImf-GB90FdwDB7v7y6LFdzVG3BC4R52A0RUtStK4_smmGYTUs3UPDOX4T4Zl2YHkxE=@emersion.fr> <20230803204459.GD27752@pendragon.ideasonboard.com> <TR8IBdXbd0C4U8Z4zf9ZLEH66QMutWs0QAAkPnMlKiOvgEZCk6AfEIPcIfRC555XWs8eSzeCCCW9R-3NwxZg6hDhPvPseAgAULAdUQ6epDA=@emersion.fr> <d9f9c272-ce9b-4599-bb11-1c026087ead3@linaro.org>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 17th, 2023 at 21:33, Dmitry Baryshkov <dmitry.baryshkov=
@linaro.org> wrote:

> We have been looking for a way to document that the corresponding DP
> port is represented by the USB connector on the device.
>=20
> Consequently, I believe the best way to document it, would be to use
> DisplayPort / USB, when there is no dongle connected, switching to
> DisplayPort / HDMI, DisplayPort / VGA, DisplayPort / DisplayPort, etc.
> when the actual dongle / display is connected and then switching back to
> the DisplayPort / USB when it gets disconnected.
>=20
> If this sounds good to all parties, I'll post v2, adding this
> explanation to the cover letter.

But how can user-space discover that the port is USB-C when it's
connected? That information is lost at this point.

(In addition, this clashes with the existing semantics of the
subconnector prop as discussed before: USB-C is not sub-, it's super-.)
