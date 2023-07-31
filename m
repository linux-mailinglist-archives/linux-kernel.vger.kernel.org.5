Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CB2769645
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjGaM0E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 31 Jul 2023 08:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjGaMZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:25:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ED1173F;
        Mon, 31 Jul 2023 05:25:16 -0700 (PDT)
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1c:f269::1])
        by madras.collabora.co.uk (Postfix) with ESMTP id 17F5166020AE;
        Mon, 31 Jul 2023 13:25:06 +0100 (BST)
From:   "Helen Mae Koike Fornazier" <helen.koike@collabora.com>
In-Reply-To: <CAF6AEGtan-bQ7syKAwOKDY=044aKu26SLPQ0j1ieLqXNyQQS3g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Mon, 31 Jul 2023 13:25:05 +0100
Cc:     "Daniel Stone" <daniel@fooishbar.org>, emma@anholt.net,
        linux-doc@vger.kernel.org, david.heidelberg@collabora.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        jbrunet@baylibre.com, robdclark@google.com, corbet@lwn.net,
        khilman@baylibre.com, sergi.blanch.torne@collabora.com,
        gustavo.padovan@collabora.com, linux-rockchip@lists.infradead.org,
        daniels@collabora.com, martin.blumenstingl@googlemail.com,
        mripard@kernel.org, anholt@google.com,
        linux-mediatek@lists.infradead.org, robclark@freedesktop.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com, neil.armstrong@linaro.org,
        guilherme.gallo@collabora.com, linux-kernel@vger.kernel.org,
        tzimmermann@suse.de, "Dave Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>
To:     "Rob Clark" <robdclark@gmail.com>
MIME-Version: 1.0
Message-ID: <282e-64c7a800-77-46253680@38053863>
Subject: =?utf-8?q?Re=3A?= [PATCH v10] =?utf-8?q?drm=3A?= Add initial ci/ 
 subdirectory
User-Agent: SOGoMail 5.8.4
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Thanks for your comments.

On Friday, July 28, 2023 11:37 -03, Rob Clark <robdclark@gmail.com> wrote:

> On Thu, Jul 27, 2023 at 10:26 PM Daniel Stone <daniel@fooishbar.org> wrote:
> >
> > On Thu, 27 Jul 2023 at 22:47, Rob Clark <robdclark@gmail.com> wrote:
> > > > I did run into a bit of a chicken vs. egg problem with testing the "in
> > > > tree" version (compared to earlier versions which kept most of the yml
> > > > and scripts in a separate tree), is that it actually requires this
> > > > commit to exist in the branch you want to run CI on.  My earlier
> > > > workaround of pulling the drm/ci commit in via
> > > > ${branchname}-external-fixes no longer works.
> > >
> > > After unwinding some more gitlab repo settings that were for the
> > > previous out-of-tree yml setup, I have this working.
> > >
> > > Tested-by: Rob Clark <robdclark@gmail.com>
> > > Acked-by: Rob Clark <robdclark@gmail.com>
> >
> > And it's also:
> > Acked-by: Daniel Stone <daniels@collabora.com>
> >
> > It's been back and forth a few times by now and reviewed pretty
> > heavily by all the people who are across the CI details. I think the
> > next step is to answer all the workflow questions by actually getting
> > it into trees and using it in anger. There was some discussion about
> > whether this should come in from drm-misc, or the core DRM tree, or a
> > completely separate pull, but I'm not sure what the conclusion was ...
> > maintainers, thoughts?
> 
> I'd prefer a separate pull, so that I could merge it into msm-next as
> well without having to pull in all of drm-misc

Should we create a drm-ci ?

> 
> Possibly some other driver trees would like to do similar?
> 
> BR,
> -R

Also, please wait for v11, I have a few adjustments to make as pointer by
some comments, and also regarding xfails list and how the configs should
be organized (unless if you are fine merging this version and I can submit
the adjustments later).

Thanks,
Helen

