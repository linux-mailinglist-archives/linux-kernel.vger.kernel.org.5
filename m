Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8487C7CF217
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjJSILc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjJSIL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:11:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526B3121
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:11:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52961C433C7;
        Thu, 19 Oct 2023 08:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697703087;
        bh=/AQ30Ywjd2dmLHisUfQKE5YeApuVr3bs37ZknilJ9wE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=On7fRHdPyznxzxA5fETIzzeHx+I7IOIsQA2Vdy6cl0ihUKzObyeYslC2k9SLdFuhO
         zG9Jef3BG1OXXCFoZZOdnjZI0LpCTuVHPoF09akcxI/EFeDq0oh8I/gAi9MM+0MLU0
         YRFoKbWLioYI9EOGl+rheRewEX90qD4H0rwdVE2kV1B8WhJWCUYHKFt2AHXFxKKjGH
         vD3jbMmaTe3cFI6WwJZrYEyogE0wEkhZ3/DJeh/sZpepFyARLFu0MhOdCydgGqypWl
         cVBExEGVhVBFddEkIxh7a9WAq6lCV9qTptqCVcyPjdoZ1JOAoRMhFCBbT70fpgsaV2
         oHUm7qJkajrMA==
Date:   Thu, 19 Oct 2023 10:11:24 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: BUG: KASAN: slab-use-after-free in drm_connector_cleanup
Message-ID: <p5lvorprghpplw2gxxiajfea6xcjecevjkku7xg6phdg2l7jez@3cexjfyqqpg6>
References: <CA+G9fYvJA2HGqzR9LGgq63v0SKaUejHAE6f7+z9cwWN-ourJ_g@mail.gmail.com>
 <1ccaf470-4bc1-4a1f-81b0-2757a4a53bd7@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ccaf470-4bc1-4a1f-81b0-2757a4a53bd7@kadam.mountain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 04:13:53PM +0300, Dan Carpenter wrote:
> If I had to guess, I'd say it's an issue in the vc4_mock driver.  It's
> crashing somewhere in Subtest: drm_vc4_test_pv_muxing.

Thanks for the report. I'm currently at XDC but I'll have a look as soon as I get back.

Maxime
