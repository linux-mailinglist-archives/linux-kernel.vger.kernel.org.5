Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D39F8005D6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377873AbjLAIhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377901AbjLAIhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:37:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87B9173C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 00:37:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30553C433C8;
        Fri,  1 Dec 2023 08:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701419874;
        bh=vitW7sTDA72AlBoRjwnKcCCRY9cZK5Zt7DNCu14No5U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tDHcFeSlBHWn+bZNPU1CgK0TyZSiRCjEqzxPacSXeURlJ+qVZBZCbLvlfnshtfhmx
         Lt9d7Rayz86N8yxBWjOoApzR1qq589RQem7zc8gHoz52yq/9frAbsiWVaErqSXGVLZ
         Nuu1WI0972T+7DcoDaQwMxM/BSSs3iPCS45So2p3IZ1xoo/WLXBIv7I+BTFswzbt3A
         W4TFB4cw4khfob8lWSV2IlWyg6oeNBumX3kLRCVI8nhoD2gM6KOdLx9cuxDkLOWNog
         4/F9BvWW7RQ7cpXbGxNxYuMi70qzxWLWW6r+hyypU2W7M7mYkFUsZ0MdYP2Otdz1nb
         0H8Z8CD0IGH0Q==
From:   Maxime Ripard <mripard@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Donald Robson <donald.robson@imgtec.com>
Cc:     matt.coster@imgtec.com, frank.binns@imgtec.com,
        boris.brezillon@collabora.com, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20231130160017.259902-4-donald.robson@imgtec.com>
References: <20231130160017.259902-1-donald.robson@imgtec.com>
 <20231130160017.259902-4-donald.robson@imgtec.com>
Subject: Re: (subset) [PATCH v2 4/5] drm/imagination: pvr_gpuvm_free() now
 static
Message-Id: <170141987169.3198881.5941706864545367309.b4-ty@kernel.org>
Date:   Fri, 01 Dec 2023 09:37:51 +0100
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

On Thu, 30 Nov 2023 16:00:16 +0000, Donald Robson wrote:
> The function below is used only within this source file, but is not static.
> 
> drivers/gpu/drm/imagination/pvr_vm.c:542:6: error: no previous prototype for 'pvr_gpuvm_free' [-Werror=missing-prototypes]
>   542 | void pvr_gpuvm_free(struct drm_gpuvm *gpuvm)
> 
> Make it static.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

