Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB3B7FBAB5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344938AbjK1NBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344886AbjK1NAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:00:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7464D10E7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:00:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0C4C433BB;
        Tue, 28 Nov 2023 13:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701176458;
        bh=j0jjiheRS7DE4WAr5PkTVziGAOVyNRK3hhCMBZKajFQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KsA17b8aS4/+1pg5VQU/LfyGUw3AvwNKG2YGY4FjRvPseS/hqw1bnYZU+S3kj21jL
         VySGwwKL6qviId39WIIoFtnasevNjDMyjFFnumG/E1dzgju+Uc1m15mD7cG8xi2r1B
         1Yc/5Nenp57PXCqWwQcdex3JCbq2wSws+W1SgEFZU/qi4+3d0hTRnGPvQHGTAdnm0L
         U9opjRtLPpGXu/B/SN/7LBdjUyF625+fCgrziXkAWeqy4Gln3+GEqQaiymJAafcEtu
         cucA/iulmA/oCQ1ONv7w6nO/mrkA/VpRFWgt9iwU7Xw5Jy+ywFx8wyfUC+pFlHNrnE
         fLDYYzvvHbw3w==
From:   Maxime Ripard <mripard@kernel.org>
To:     airlied@gmail.com, daniel@ffwll.ch, frank.binns@imgtec.com,
        donald.robson@imgtec.com, matt.coster@imgtec.com,
        sarah.walker@imgtec.com, Danilo Krummrich <dakr@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231124233650.152653-2-dakr@redhat.com>
References: <20231124233650.152653-1-dakr@redhat.com>
 <20231124233650.152653-2-dakr@redhat.com>
Subject: Re: (subset) [PATCH drm-misc-next 1/5] drm/imagination: vm:
 prevent duplicate drm_gpuvm_bo instances
Message-Id: <170117645564.2825698.1827367300735783510.b4-ty@kernel.org>
Date:   Tue, 28 Nov 2023 14:00:55 +0100
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

On Sat, 25 Nov 2023 00:36:36 +0100, Danilo Krummrich wrote:
> Use drm_gpuvm_bo_obtain() instead of drm_gpuvm_bo_create(). The latter
> should only be used in conjunction with drm_gpuvm_bo_obtain_prealloc().
> 
> drm_gpuvm_bo_obtain() re-uses existing instances of a given VM and BO
> combination, whereas drm_gpuvm_bo_create() would always create a new
> instance of struct drm_gpuvm_bo and hence leave us with duplicates.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

