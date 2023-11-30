Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DE37FEDD9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345295AbjK3L3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345296AbjK3L3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:29:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D67271FE4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:29:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 853301042;
        Thu, 30 Nov 2023 03:29:51 -0800 (PST)
Received: from [10.1.34.23] (e122027.cambridge.arm.com [10.1.34.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91CB93F6C4;
        Thu, 30 Nov 2023 03:29:02 -0800 (PST)
Message-ID: <871c4b6d-fb37-41ae-9dcf-b98345e70c77@arm.com>
Date:   Thu, 30 Nov 2023 11:29:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Panfrost devfreq and GEM status fixes
To:     =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20231125205438.375407-1-adrian.larumbe@collabora.com>
Content-Language: en-GB
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20231125205438.375407-1-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2023 20:52, Adrián Larumbe wrote:
> During recent development of the Mali CSF GPU Panthor driver, a user
> noticed that GPU frequency values as reported by fdinfo were
> incorrect. This was traced back to incorrect handling of frequency value
> updates. The same problem was seen in Panfrost.
> 
> Also one should consider GEM objects from a dma-buf import as being
> resident in system memory, so that this can be reflected on fdinfo.
> 
> Adrián Larumbe (2):
>   drm/panfrost: Consider dma-buf imported objects as resident
>   drm/panfrost: Fix incorrect updating of current device frequency
> 
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 17 +++++++++++++++--
>  drivers/gpu/drm/panfrost/panfrost_gem.c     |  2 +-
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 38f922a563aac3148ac73e73689805917f034cb5

Pushed to drm-misc-fixes

Thanks,

Steve
