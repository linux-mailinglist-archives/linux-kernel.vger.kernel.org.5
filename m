Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0137FBAB8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344987AbjK1NBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344924AbjK1NA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:00:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1212019A3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:01:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55219C433C7;
        Tue, 28 Nov 2023 13:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701176463;
        bh=cno0wrTciQcAWVSsnIZ43dCdMCLvNvzuyANDvYgnksw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aXVlGl515Dfgo5/K1KozTP82iuF3KvDFwv+ZDaBUl+zAblgkAnP4MYltZlGXrQX4S
         GHKUtwhG8dEviY9RQEO/ECqcW/ICgiIstWLe4kdomhHILClEBjQ49mmkY0Jzi6O0ue
         X5qzBMKUs2wDqPwjoFRT7Vb1/bvzuRfaJcbV0CLri3FQjJ9KsWzeHfmcXXY/lHRk3w
         VNQqE3waXpplg99R7nRF0RNF+eIMnf2pZOK2ls7jYED82nCFda0xS9LYWBi2B0Vhjm
         0d/ikYHDDRsSBfYwtPr5uv5qWvzgjTmU5dMeWH7Vyo9AXBECKvGq2QtdwcOMD6bvmp
         aajCxQJuF4gFg==
From:   Maxime Ripard <mripard@kernel.org>
To:     airlied@gmail.com, daniel@ffwll.ch, frank.binns@imgtec.com,
        donald.robson@imgtec.com, matt.coster@imgtec.com,
        sarah.walker@imgtec.com, Danilo Krummrich <dakr@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231124233650.152653-4-dakr@redhat.com>
References: <20231124233650.152653-1-dakr@redhat.com>
 <20231124233650.152653-4-dakr@redhat.com>
Subject: Re: (subset) [PATCH drm-misc-next 3/5] drm/imagination: vm: fix
 drm_gpuvm reference count
Message-Id: <170117646120.2825698.16047207632231408028.b4-ty@kernel.org>
Date:   Tue, 28 Nov 2023 14:01:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2023 00:36:38 +0100, Danilo Krummrich wrote:
> The driver specific reference count indicates whether the VM should be
> teared down, whereas GPUVM's reference count indicates whether the VM
> structure can finally be freed.
> 
> Hence, free the VM structure in pvr_gpuvm_free() and drop the last
> GPUVM reference after tearing down the VM. Generally, this prevents
> lifetime issues such as the VM being freed as long as drm_gpuvm_bo
> structures still hold references to the VM.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

