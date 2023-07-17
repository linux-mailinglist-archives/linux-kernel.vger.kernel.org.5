Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB530755E11
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjGQIO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjGQIOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:14:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA909E5A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55A8960FB4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41158C433C8;
        Mon, 17 Jul 2023 08:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689581651;
        bh=Sl+QltKLEKMYxs1hQQYrVUaWdIlqz3j/k7mSX0+hia0=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=bn7stKdHRnxERh8ChT9k48Nl7RDqA5KiV5mJzKqwKSoLmkNM3DkwItVrNBIRd9lKE
         vOZdKC+OEwIPjKfGIL49v9oGrpKiqZ1s/eIoy5rCDr+4+hJXBmHCaMc9FOUy0MLmcs
         HWFaeD4zwj7R8XPjhP+k3HJacKmw8nRUXtG5DFKtkWu4ooIIrLJRI3gwbcymOVJ763
         pjJhhRHGncO/25zybkV8OWZOatOvVk1u+Q0Rxhd8bEhGkPadQEdCCr26Mr67UL20ly
         4PLlMkWGwMY4jODeWw3bHcn6mr7D/NeqbZWm1e5AhI2ZKk1AHfsWP3azvdu/SWUJYZ
         pgP4exJc8mfBQ==
Message-ID: <c244d1d525c9582899fcf581b0f6078c.mripard@kernel.org>
Date:   Mon, 17 Jul 2023 08:14:09 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Sarah Walker" <sarah.walker@imgtec.com>
Subject: Re: [PATCH v4 05/17] drm/imagination: Get GPU resources
In-Reply-To: <20230714142618.111746-1-sarah.walker@imgtec.com>
References: <20230714142618.111746-1-sarah.walker@imgtec.com>
Cc:     afd@ti.com, airlied@gmail.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, dakr@redhat.com, daniel@ffwll.ch,
        donald.robson@imgtec.com, dri-devel@lists.freedesktop.org,
        faith.ekstrand@collabora.com, frank.binns@imgtec.com,
        hns@goldelico.com, linux-kernel@vger.kernel.org,
        luben.tuikov@amd.com, maarten.lankhorst@linux.intel.com,
        matthew.brost@intel.com, mripard@kernel.org, tzimmermann@suse.de
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 15:26:18 +0100, Sarah Walker wrote:
> Acquire clock and register resources, and enable/map as appropriate.
> 
> Changes since v3:
> - Remove regulator resource (not used on supported platform)
> - Use devm helpers
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
