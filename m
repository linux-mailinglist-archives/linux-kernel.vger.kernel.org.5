Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B4E79B0D7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238481AbjIKUyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237752AbjIKNOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:14:20 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B3DE9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:14:15 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52e5900cf77so5673992a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694438053; x=1695042853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bzg1j4l+T9SlvjeUrT1btKedodryHP6lWwaPR4x8CXY=;
        b=sHY61oXBUBArw1Jbi+F58+Kf17Rw7wLgrSgGbQqBPu6EvsQv/QUezqkYjm4DNUuOpZ
         ZIKxB+GnGG6nBVlV+kaWx+5Rq2Lt/G41LPxDyuNeokdqx2nGuShfs0dFMgudMDe2zH35
         UgE+tLnEJrE9No3M//QRjW2JLCMyCPJqpyK1eFoPHKKpPPmlJhGMzGDswDpk0mDWaChw
         +tl0fTftdPsR3bkonqw+TbVuIJrkikYzVuwAvm9QXh4Y0ITou+VafYfnWkdGYWSXN65a
         TpWRpsIlKw0hn7jzr21admZdaH70EhB6zy0Txxvn5qWsqca3evYPMfwnPkZUxQsDm5QV
         3wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438053; x=1695042853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bzg1j4l+T9SlvjeUrT1btKedodryHP6lWwaPR4x8CXY=;
        b=ZyMs6bS0F8E65TVkqZu9sn16HnC0oPej2Z/2ZkVyyQugH0HfmDD/RoaVFRf8Gq9Ccs
         CCJQP6unafmMJ2c8gNYHo2IS+bJbVcfYNFTLmo82Yp1nN2SVqGF7f3MmcbJPCyEATk5x
         a/Co5clYyAGMMdaDeDjcpe2niDqI50/WBBHDyeGT75tGwKjEa0qHqmd+2becZUH44no2
         98Yhi5vgiJ085gk02t7vQE6SiwupgxUkF8Jd7OWClXVjPRMNEoY6LO6AgDL4jrUs+Xt2
         R4MJsYXa+naKl65BI0qdrO05fcVpTOiZl/NpJ5tuVjKJVH6OYmDRIK5pU4wKuupd25jM
         xnDw==
X-Gm-Message-State: AOJu0Yzgu1bsOKwPSDQ8aGcKqUa1z9DKBsl3GkB3nVxtIYxwxXbq+lgu
        4SVFxHOPwu0V6LFVidC0XFtIxQ==
X-Google-Smtp-Source: AGHT+IFj5+4CXTSkggw+7E+WKQwCfPGMicwOZyOZAcCpdAagzmFGkR8AQFbMmiMrOoOYJaf+r+zbzg==
X-Received: by 2002:a17:906:2dc:b0:9a6:4f23:9d8f with SMTP id 28-20020a17090602dc00b009a64f239d8fmr8478768ejk.47.1694438053554;
        Mon, 11 Sep 2023 06:14:13 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id kt8-20020a170906aac800b00988e953a586sm5313648ejb.61.2023.09.11.06.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 06:14:13 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/17] media: qcom: camss: Add parameter passing to remove several outstanding bugs
Date:   Mon, 11 Sep 2023 14:13:54 +0100
Message-ID: <20230911131411.196033-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V5:
- drops ret = fn(); return ret; for return fn(); - Hans, Konrad
Link: https://lore.kernel.org/linux-arm-msm/20230907164410.36651-16-bryan.odonoghue@linaro.org/

Bootable:
Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-09-06-lenovo-x13s-v6.5-rc7-x13s-camss-patches-v5

V4:
- Adds additional Reviewed-by / Acked-by from Laurent and Konrad as indicated

- Updates commit log per Laurent suggestion not go on hunger strike
  Link: https://lore.kernel.org/linux-arm-msm/20230828185110.GN14596@pendragon.ideasonboard.com/

- Includes suggested changes to switch {} statements - Laurent
  Link: https://lore.kernel.org/linux-media/d7745ece-bea1-f8f9-a1d2-0f01aa221ade@linaro.org/

- Drops SoC specific vfe_get()/vfe_put() we have been using.
  There is no need to differentiate on SoC since get/put reference count.
  Link: https://lore.kernel.org/linux-media/62f78aac-c1e4-018c-93c2-4dac1ec7c688@linaro.org/

- Changes the name of the generic struct resources to struct camss_subdev_resources - Laurent
  Link: https://lore.kernel.org/lkml/20230828173055.GF14596@pendragon.ideasonboard.com/

- media: qcom: camss: media: qcom: camss: Move vfe_disable into a common routine where applicable
  Follows up on a comment from Laurent
  Link: https://lore.kernel.org/linux-media/20230828171725.GZ14596@pendragon.ideasonboard.com/

- media: qcom: camss: Propagate vfe_reset error up the callstack
  Take the different approach to fixing the vfe_disable() routine doing nothing but returning 0
  Per Konrad's correct comment on vfe_reset() error
  Link: https://lore.kernel.org/linux-media/aaf9db49-54c4-4c27-8206-61e86ad560c2@linaro.org/

- Restricts the length of buffer size for clock name string lookups - Konrad
  Link: https://lore.kernel.org/linux-arm-msm/076d958f-2cf3-4a52-99a2-52a6cdd5443c@linaro.org/

- Some outstanding issues not addressed in this series

  * Clock name string lookups.
    This warrants a standalone series - which will need yaml and dts changes to group clocks
    by name across all supported SoCs.
    This will then negate the string matching for clocks.
    Link: https://lore.kernel.org/linux-arm-msm/3b3682be-5dbd-5e2d-a6c1-7bdf6d3ff8cd@linaro.org/

  * Pixel formats are assigned via control strucutres not pointers from compat params
    The struct resources stuff is still sub-optimal and it feels to me as if we should
    do a bigger intervention to break away from a generic structure to subdevice specific
    parameter structures. Such a subdevice specific structure would support passing pxiel
    formats.

  * We still need to follow up on having named genpds instead of magic indexes
    Link: https://lore.kernel.org/lkml/b7e1d035-ee79-77c9-e81f-56fa8c2cf1df@linaro.org/

  * More generally this driver allows for arbitrary connection of CSID, RDI
    and VFE but, that is not how the hardware works. I believe other people
    have works in progress to address some of this shortcoming separately.

Bootable - includes tag for patches queued in Hans staging tree
Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/commits/22ed4a935d6d323e71b014a69bafd638ad53cb5c 

V3:
- Adds RB/AB as indicated - Konrad
- Replaces >= SDM845 with helper function per discussion - bod/Konrad
- Leaves out constraining VFE clock names sizes. A full pass for resource strings will happen later. - bod
- Clarifies commit log resulting in updated patch title also
  "Add support for setting CSIPHY clock name csiphyX"
  ->
  "Fix support for setting CSIPHY clock name csiphyX"
- Adds patch to remove dead integer return type in vfe_disable()
- Adds patch to comment CSID dt_id meanining which I personally find non-obvious right now - bod

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/commits/09e7805a733b488c5dc19b301eb3b77cb0fad3d6

V2:
- Replaces &camss->res with pointer to res - Konrad
- Squashes patch for NULL removal - Konrad
- Left suggestion on ICC initialisation points alone, doesn't seem to fit Konrad/bod

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-08-07-db410c-rb3-camss-dts-v3+maintenance-bugfixes-v2

V1:
- I forgot to include patch # 14 in V0 of this series.
  This patch leverages previous changes to unwind the fixed polling of
  RDI[0..2] allowing driver data to articulate on a per-VFE basis how many
  RDIs to poll.

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-08-07-db410c-rb3-camss-dts-v3+maintenance-bugfixes-v1

V0:
This second series of bugfixes stacks ontop of the Fixes series sent earlier.

Link: https://lore.kernel.org/linux-arm-msm/20230814141007.3721197-1-bryan.odonoghue@linaro.org/T/#t

Rather than send both series as one giant series, I opted to send a pure
Fixes series above, with this second series a non-backport series i.e. no
Fixes tags in this series.

The existing CAMSS code relies on some hard-coded parameters buried inside
of the driver, instead of passed via compat .data as arguably ought to be
the case.

This brittle model is an extending morass of spaghetti code. More than that
in CAMSS Video Front Ends (VFEs) and the number of Raw Data Interfaces
(RDIs) per VFE can vary from SoC to SoC. Indeed sm8250 has VFE and VFE Lite
blocks which have a different number of RDIs per block.

The use of defines as opposed to per-compat parameters inside of ISRs leads
to either under-polling or over-polling the number of RDIs.

On top of all of that we have some hard-coded statements for clock names
which breaks easily.

We can solve the under/over polling loop problem by transitioning loop
controls from macros to parameters passed via probe().

Similarly and unsurprisingly we can also solve the hard-coded clock problem
by adding some string processing routines that take passed arguments.

There is still some additional maintenance work to be done in this driver
but before adding one more SoC the code needs to be made more extensible
and less brittle.

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/commits/dc346c7f46c0680bcfb84fded6db97497fffe49a

Bryan O'Donoghue (17):
  media: qcom: camss: Amalgamate struct resource with struct
    resource_ispif
  media: qcom: camss: Rename camss struct resources to
    camss_subdev_resources
  media: qcom: camss: Start to move to module compat matched resources
  media: qcom: camss: Pass icc bandwidth table as a platform parameter
  media: qcom: camss: Pass remainder of variables as resources
  media: qcom: camss: Pass line_num from compat resources
  media: qcom: camss: Pass CAMSS subdev callbacks via resource ops
    pointer
  media: qcom: camss: Assign the correct number of RDIs per VFE
  media: qcom: camss: Remove special case for VFE get/put
  media: qcom: camss: Untangle if/else spaghetti in camss
  media: qcom: camss: Allow clocks vfeN vfe_liteN or vfe_lite
  media: qcom: camss: Functionally decompose CSIPHY clock lookups
  media: qcom: camss: Fix support for setting CSIPHY clock name csiphyX
  media: qcom: camss: Support RDI3 for VFE 17x
  media: qcom: camss: Move vfe_disable into a common routine where
    applicable
  media: qcom: camss: Propagate vfe_reset error up the callstack
  media: qcom: camss: Comment CSID dt_id field

 .../platform/qcom/camss/camss-csid-gen2.c     |   5 +
 .../media/platform/qcom/camss/camss-csid.c    |  28 +-
 .../media/platform/qcom/camss/camss-csid.h    |   4 +-
 .../qcom/camss/camss-csiphy-3ph-1-0.c         |   8 +-
 .../media/platform/qcom/camss/camss-csiphy.c  |  67 +--
 .../media/platform/qcom/camss/camss-csiphy.h  |   4 +-
 .../media/platform/qcom/camss/camss-ispif.c   |  32 +-
 .../media/platform/qcom/camss/camss-ispif.h   |   4 +-
 .../media/platform/qcom/camss/camss-vfe-170.c |  57 +--
 .../media/platform/qcom/camss/camss-vfe-4-1.c |   2 -
 .../media/platform/qcom/camss/camss-vfe-4-7.c |   2 -
 .../media/platform/qcom/camss/camss-vfe-4-8.c |   2 -
 .../media/platform/qcom/camss/camss-vfe-480.c |  45 +-
 drivers/media/platform/qcom/camss/camss-vfe.c | 127 ++++--
 drivers/media/platform/qcom/camss/camss-vfe.h |  15 +-
 .../media/platform/qcom/camss/camss-video.c   |  17 +-
 drivers/media/platform/qcom/camss/camss.c     | 429 ++++++++++--------
 drivers/media/platform/qcom/camss/camss.h     |  34 +-
 18 files changed, 450 insertions(+), 432 deletions(-)

-- 
2.42.0

