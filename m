Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7154E7FEBCF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjK3J0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3J0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:26:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4FB8F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:26:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C120C433C8;
        Thu, 30 Nov 2023 09:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701336386;
        bh=Fo0Pio3QZLXVJiyMZvAR93mM+9bLzpr7O6m3p7tFXVM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JGHM3KmMqmQn9ypX6vtyIaO67Rg22LUUwJduPHMI3VzXFwh9INwXPoy7oCW61HxF1
         fCy898LsZu93EhWv5YHrIPb8CHsjnfZ7UX4aLQ9Pyr0pzL8TCB3JGNSs4+VPrOJgRg
         wyX/zby9KDyvEkv1/sGp5GKV/dOQdeB2jRBpaaAxUF/L1nFaOzLOB1i9dBI3il2DV+
         8N+sXjHQz44DzUEwBZzewj7Lf4nVMqXOnyPmYXo0nRPBnH/8kg+Ynbv3KMPElmThcl
         ba2U1n61pmXsue249N3mysSWdtbkMrP5BOUDmce3SPr4wBjxgOrne0T83HjE+H8Y0N
         5x5pvzWn2dVVg==
From:   Maxime Ripard <mripard@kernel.org>
To:     Sarah Walker <sarah.walker@imgtec.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <a2d3210b-290f-4397-9c3e-efdcca94d8ac@moroto.mountain>
References: <a2d3210b-290f-4397-9c3e-efdcca94d8ac@moroto.mountain>
Subject: Re: (subset) [PATCH] drm/imagination: fix off by one in
 pvr_vm_mips_init() error handling
Message-Id: <170133638383.3077649.18368811865734250360.b4-ty@kernel.org>
Date:   Thu, 30 Nov 2023 10:26:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 10:27:15 +0300, Dan Carpenter wrote:
> If the call to vmap() fails the "page_nr" is one element beyond the end
> of the mips_data->pt_dma_addr[] and mips_data->pt_pages[] arrays.
> 
> The way that this is traditionally written is that we clean up the
> partial loop iteration before the goto and then we can say
> while (--i >= 0).  At that point we know that all the elements thus
> far are initialized so we don't need to have NULL checks.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

