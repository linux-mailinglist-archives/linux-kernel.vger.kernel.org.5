Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5363811616
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442511AbjLMPWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442482AbjLMPWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:22:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D55F3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:22:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945C5C433C7;
        Wed, 13 Dec 2023 15:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702480959;
        bh=g9AfdMsMWQPrTFn3Rfxxtm16T5CwU3D5GqboUlkSxB8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GDrZI2XBTh3hJVVSXnxYxcQ4Ww8ny4IzmGeEg2lCyPdTBuIsmFvcdHOOWb3OtN+sK
         Tois1SqVzSuh4dUcqTnrm6GeKSz2YO2M+zSACcHSe0kaK2xIDt21NRwR5vhw9AFhaN
         oOWOyxDTSykwywZ7/ug2xhYAC1x58VCuQkgHji75L/2zZdCu9wGzUx+m0hLEdOnjty
         MR9/mY93zS4jpNKKATj/S1wq7Lv2Qdto6ywA3JCiSKgGgLTyPgGohLQ0YcKBw1GjxE
         62s77VFc1bViQj0yc3xnuDiL9x+2Jp0315SB85Qy+InXIFG9zFEPAYk4JOu/zZBjJA
         n9F+eN/wC2Dmw==
From:   Maxime Ripard <mripard@kernel.org>
To:     Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Bee <knaerzche@gmail.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Sarah Walker <sarah.walker@imgtec.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231208170856.1748413-1-knaerzche@gmail.com>
References: <20231208170856.1748413-1-knaerzche@gmail.com>
Subject: Re: (subset) [PATCH] drm/imagination: vm: Fix heap lookup
 condition
Message-Id: <170248095546.191897.14747854434891174089.b4-ty@kernel.org>
Date:   Wed, 13 Dec 2023 16:22:35 +0100
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

On Fri, 08 Dec 2023 18:08:56 +0100, Alex Bee wrote:
> When conditionally checking for heap existence of a certian address in
> pvr_vm_bind_op_map_init the condition whether the map request comes from a
> user is incorrect: The context must not be the kernel-context to be a
> user(space) context and should be looked up in pvr_heaps.
> 
> That makes addresses coming from userspace not being verfied against the
> defined ranges and prevents firmware loading for meta cores.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

