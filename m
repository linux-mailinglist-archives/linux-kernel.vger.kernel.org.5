Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC5776F421
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjHCUpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjHCUo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:44:58 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D86A30EA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 13:44:55 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 625A58C1;
        Thu,  3 Aug 2023 22:43:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691095428;
        bh=LWzMEFgrC/PlVsgJUx4AkW/o073y3IloiFtC+MVjNYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=htZTfD0VD+z3VFAZGYDuiQdDo5xVWEbeOBhNwfGKc9LSk3PLbSVgkCtCkjM/j9BxB
         8E5WnhtCUzr1uXSi06u7uVCt7vB6c1QPpGZ7D0gtqlhSJXze9SobkS2nZtv1Qcnef/
         l1oHArjkLnBuI+DbSS/WNT7hvS4yOlhpzZ/ukXSM=
Date:   Thu, 3 Aug 2023 23:44:59 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Simon Ser <contact@emersion.fr>
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
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
Message-ID: <20230803204459.GD27752@pendragon.ideasonboard.com>
References: <20230729004913.215872-1-dmitry.baryshkov@linaro.org>
 <20230729004913.215872-4-dmitry.baryshkov@linaro.org>
 <20230802185547.GC32500@pendragon.ideasonboard.com>
 <a32ce695-038f-0ef8-3584-5bd1ba528131@linaro.org>
 <20230802191351.GA1407@pendragon.ideasonboard.com>
 <DE2B4523-D16C-4AFC-8352-212B23548DD5@linaro.org>
 <b6oOVz2YMIG4hJDWhq9lTh6R2HYcrpRwHENhplig9KSQMD8dIjTgC5KdH1Ij3URgV2HESp67Ax7QUsByGjMLouvbs-5q7PiPRdLkgJz6Fwk=@emersion.fr>
 <ADjuOeqA6575DKutMPaR9mW9rLhm-wjLc4ruoUkNwImf-GB90FdwDB7v7y6LFdzVG3BC4R52A0RUtStK4_smmGYTUs3UPDOX4T4Zl2YHkxE=@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ADjuOeqA6575DKutMPaR9mW9rLhm-wjLc4ruoUkNwImf-GB90FdwDB7v7y6LFdzVG3BC4R52A0RUtStK4_smmGYTUs3UPDOX4T4Zl2YHkxE=@emersion.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 03:31:16PM +0000, Simon Ser wrote:
> On Thursday, August 3rd, 2023 at 17:22, Simon Ser <contact@emersion.fr> wrote:
> 
> > The KMS docs describe "subconnector" to be defined as "downstream port" for DP.
> > Can USB-C (or USB) be seen as a DP downstream port?
> 
> To expand on this a bit: I'm wondering if we're mixing apples and
> oranges here. The current values of "subconnector" typically describe
> the lower-level protocol tunneled inside DP. For instance, VGA can be
> tunneled inside the DP cable when using DP → VGA adapter.

Doesn't this contradict the example use case you gave in your previous
e-mail, with wlroots stating "DP-3 via DVI-D" ? I understand that as DP
carried over a DVI-D physical connector, did I get it wrong ?

> However, in the USB-C case, DP itself is tunneled inside USB-C. And you
> might use a USB-C → DP adapter. So it's not really *sub*connector, it's
> more of a *super*connector, right?
> 
> I think [1] is somewhat related, since it also allows user-space to
> discover whether a connector uses USB-C. But relying on sysfs to figure
> this out isn't super optimal perhaps.
> 
> [1]: https://lore.kernel.org/dri-devel/20221108185004.2263578-1-wonchung@google.com/

-- 
Regards,

Laurent Pinchart
