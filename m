Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE36C788C1D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjHYPGg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Aug 2023 11:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343886AbjHYPGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:06:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891842127;
        Fri, 25 Aug 2023 08:06:05 -0700 (PDT)
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1c:f269::1])
        by madras.collabora.co.uk (Postfix) with ESMTP id 6E9BA6607285;
        Fri, 25 Aug 2023 16:06:01 +0100 (BST)
From:   "Helen Mae Koike Fornazier" <helen.koike@collabora.com>
In-Reply-To: <CAF6AEGsdR4XMQ73mwNEE-fntPFLbQrxmzdoWchjReoVXKexdVw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Fri, 25 Aug 2023 16:06:01 +0100
Cc:     "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Vignesh Raman" <vignesh.raman@collabora.com>,
        dri-devel@lists.freedesktop.org, emma@anholt.net,
        linux-doc@vger.kernel.org, david.heidelberg@collabora.com,
        linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        robdclark@google.com, corbet@lwn.net, khilman@baylibre.com,
        sergi.blanch.torne@collabora.com, gustavo.padovan@collabora.com,
        linux-rockchip@lists.infradead.org, daniels@collabora.com,
        martin.blumenstingl@googlemail.com, robclark@freedesktop.org,
        anholt@google.com, linux-mediatek@lists.infradead.org,
        mripard@kernel.org, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com, neil.armstrong@linaro.org,
        guilherme.gallo@collabora.com, linux-kernel@vger.kernel.org,
        tzimmermann@suse.de
To:     "Rob Clark" <robdclark@gmail.com>
MIME-Version: 1.0
Message-ID: <3f08-64e8c380-3-f083520@11689262>
Subject: =?utf-8?q?Re=3A?= [PATCH 2/6] =?utf-8?q?drm=3A?==?utf-8?q?_ci=3A?= Force 
 db410c to host mode
User-Agent: SOGoMail 5.8.4
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 25, 2023 11:41 -03, Rob Clark <robdclark@gmail.com> wrote:

> On Fri, Aug 25, 2023 at 7:34 AM Helen Mae Koike Fornazier
> <helen.koike@collabora.com> wrote:
> >
> > On Friday, August 25, 2023 11:30 -03, Rob Clark <robdclark@gmail.com> wrote:
> >
> > > On Fri, Aug 25, 2023 at 6:56 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > > >
> > > > On Fri, 25 Aug 2023, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> > > > > Force db410c to host mode to fix network issue which results in failure
> > > > > to mount root fs via NFS.
> > > > > See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a629b8c15c80a54dda510743cefd1c4b65b8
> > > > >
> > > > > Since this fix is not sent upstream, add it to build.sh script
> > > > > before building the kernel and dts. Better approach would be
> > > > > to use devicetree overlays.
> > > > >
> > > > > Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> > > > > ---
> > > > >  drivers/gpu/drm/ci/build.sh | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
> > > > > index 7b014287a041..c39834bd6bd7 100644
> > > > > --- a/drivers/gpu/drm/ci/build.sh
> > > > > +++ b/drivers/gpu/drm/ci/build.sh
> > > > > @@ -70,6 +70,10 @@ if [ -z "$CI_MERGE_REQUEST_PROJECT_PATH" ]; then
> > > > >      fi
> > > > >  fi
> > > > >
> > > > > +# Force db410c to host mode to fix network issue which results in failure to mount root fs via NFS.
> > > > > +# See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a629b8c15c80a54dda510743cefd1c4b65b8
> > > > > +sed -i '/&usb {/,/status = "okay";/s/status = "okay";/&\n\tdr_mode = "host";/' arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> > > > > +
> > > >
> > > > It seems like a really bad idea to me to have the CI build modify the
> > > > source tree before building.
> > > >
> > > > The kernel being built will have a dirty git repo, and the localversion
> > > > will have -dirty in it.
> > > >
> > > > I think it would be better to do out-of-tree builds and assume the
> > > > source is read-only.
> > >
> > > We have the ${target_branch}-external-fixes mechanism to merge
> > > necessary changes before building the kernel for CI.  Which is
> > > necessary for a couple of reasons:
> >
> > Should we create an official topic/drm-ci-external-fixes branch ?
> 
> Hmm, maybe.. I guess as we expand this to more driver trees, and want
> to be able to re-run CI in the drm tree after merges to
> drm-next/drm-fixes, we maybe want to have central
> drm-next-external-fixes and drm-fixes-external-fixes.  I guess we can
> keep those based on drm-next and drm-fixes?  And if there would be
> conflicts because, say, ${driver}-next is behind drm-next, then
> ${driver}-next could be rebased on drm-next?
> 

tbh this is one of the reasons I would prefer in-code fixes instead of
commits on a -external-fixes branch, since it seems things start to become
complex to manage all different trees for people executing ci tests
on different history points, but I don't oppose going for -external-fixes
either.

Regards,
Helen

> BR,
> -R
> 
> > Regards,
> > Helen
> >
> > >
> > > 1) patches like this which aren't appropriate upstream but necessary
> > > due to the CI lab setup
> > > 2) target branch if often based on an early -rc, and it isn't unheard
> > > of to need some fix for some board or another which isn't appropriate
> > > to land via drm-next
> > >
> > > We should use the -external-fixes branch mechanism for patches like this one.
> > >
> > > BR,
> > > -R
> > >
> > > > >  for opt in $ENABLE_KCONFIGS; do
> > > > >    echo CONFIG_$opt=y >> drivers/gpu/drm/ci/${KERNEL_ARCH}.config
> > > > >  done
> > > >
> > > > Ditto for the config changes in the context here. Those are files in
> > > > git, don't change them.
> > > >
> > > > Shouldn't this use something like 'scripts/config --enable' or
> > > > 'scripts/config --disable' on the .config file to be used for building
> > > > instead?
> > > >
> > > >
> > > > BR,
> > > > Jani.
> > > >
> > > >
> > > > --
> > > > Jani Nikula, Intel Open Source Graphics Center
> >

