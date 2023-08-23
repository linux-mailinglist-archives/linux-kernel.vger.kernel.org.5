Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E2D785653
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbjHWK6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjHWK6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:58:22 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7FBFB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:58:20 -0700 (PDT)
Date:   Wed, 23 Aug 2023 10:58:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1692788298; x=1693047498;
        bh=cv2+UwZVJU09IPn6jP3k4R4bB5Rtx3kU0cPpN+EkpqQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=hL2EcCgUlFXtDG9uDf7h6VjLM2JCqzIItk7ZdN7TuJ+RP5Tx8DbnvG663iH0FJLE2
         km56x2lleDFAARH3XfeLNfW9MkHLi/Q/oGo4YHAm5dOZKvRUL0aJLyrU4CRYlfmsjD
         xzHm2+LUhYCVOyvhkzyZ9UYcvnXA2xwlYEk/ezDPoCQTSYgcCPKFWtSMkukSIJoZSI
         cJ2gMT0V2kK+cn6X62YMx4J4eUv18uyeF385wPICDRKOLKWkHmy0XHVji+6CPOG142
         OKVKi1DUVvTd6zo1DbRwk9APiKFeZE2ItJTPqm4DpVxtEgFwdcu/4maatpnUbqZF9X
         813v6eWx12b9g==
To:     James Zhu <jamesz@amd.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        =?utf-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Oded Gabbay <ogabbay@kernel.org>,
        James Zhu <James.Zhu@amd.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH v6 3/4] drm: Expand max DRM device number to full MINORBITS
Message-ID: <RMIFRuUra0Qgzx9r2eT-GsI-9FdUFjfiNCvpax8I4OwuQidm8sFcaSzoZqHfbA3iXsW-z0z31K5qZ-7w_1ciDF4KSZwz2JbOggtTqHTsHsY=@emersion.fr>
In-Reply-To: <f1Cwh796fW9-Sse4KkXw1Xpgaknx9yWMP3bi-8mGhNOmZ2_aeqg5unzrBNuHiNCPzvXTs6B2tH-XxNH7jVWDzg3PnVmCa5XaXTe3xhxyTM8=@emersion.fr>
References: <20230724211428.3831636-1-michal.winiarski@intel.com> <20230724211428.3831636-4-michal.winiarski@intel.com> <83s0YPWEdYE6C2a8pa6UAa3EaWZ2zG-q7IL9M-y6W1ucF9V54VnZtigKj3BGKUA2FZpIrs0VVxmpHO2RAhs_FdOnss9vNLQNSHySY8uH7YA=@emersion.fr> <69801f61-37b0-3e46-cbef-31ff80ae9a34@amd.com> <TAdBP5BOy3cy7VnUb4t7ZkDOMK6wI_gPCjXanItN3TOsA1TbSk_6yrlcPTqvk3AZjamo96yHlEhjpfNUPFF6tA_9K8iRoie3h_z5Jf6zNtc=@emersion.fr> <ad26d275-4373-429f-ecaa-3e35978f1fb0@amd.com> <61efe587-9a7a-063c-a388-eed9f51958d4@amd.com> <f1Cwh796fW9-Sse4KkXw1Xpgaknx9yWMP3bi-8mGhNOmZ2_aeqg5unzrBNuHiNCPzvXTs6B2tH-XxNH7jVWDzg3PnVmCa5XaXTe3xhxyTM8=@emersion.fr>
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

On Wednesday, August 23rd, 2023 at 12:53, Simon Ser <contact@emersion.fr> w=
rote:

> On Tuesday, August 8th, 2023 at 17:04, James Zhu jamesz@amd.com wrote:
>=20
> > I have a MR for libdrm to support drm nodes type up to 2^MINORBITS
> > nodes which can work with these patches,
> >=20
> > https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/305
>=20
> FWIW, this MR has been merged, so in theory this kernel patch should
> work fine with latest libdrm.

Hm, we might want to adjust MAX_DRM_NODES still. It's set to 256
currently, which should be enough for 128 DRM devices, but not more.
Not bumping this value will make drmGetDevices2() print a warning and
not return all devices on systems with more than 128 DRM devices.
