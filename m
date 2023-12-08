Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7A8809F8C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573448AbjLHJgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbjLHJgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:36:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F974171F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 01:36:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32B3C433C7;
        Fri,  8 Dec 2023 09:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702028184;
        bh=2CP+g0JFWDQiXDkdMQf10ayFgPRTjEJo99EqpGJ8aOk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qGGib1lagyidxAtZKdJT5zotbna+a0mat76lxP/Bh9bceaO81OJbA93b9DXkUgsXh
         lk8R7EENn2x8Ue3sBwDwUEE48g2azhiJMI5REeDUYOzcdCEPyl62naOz/J6o7MT8yi
         c3Dgvi1M6cB6DJOPl8DMWZ1Fk/HJshGl4vqfGCx6L1lrISTT/BvCr+pBpdLii2AWAK
         ObS+PJiKulS5b+nxAfXqJpScGIE169Bh0OhExwdgev1q1fCxWlD3BMgi0yVeN6oDhB
         0y5E1Kozo1vXkaTmOzk6JjJkYtFhVIJUM1d4GFRYy1oXz2J3mIL92tapptGYB8noSY
         UA49V64VxheHA==
From:   Maxime Ripard <mripard@kernel.org>
To:     Donald Robson <donald.robson@imgtec.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Frank Binns <frank.binns@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sarah Walker <sarah.walker@imgtec.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <13f4278e-af9c-4092-9196-bc0e6b76f1eb@moroto.mountain>
References: <13f4278e-af9c-4092-9196-bc0e6b76f1eb@moroto.mountain>
Subject: Re: (subset) [PATCH] drm/imagination: Move dereference after NULL
 check in pvr_mmu_backing_page_init()
Message-Id: <170202818166.16687.13249105887832691264.b4-ty@kernel.org>
Date:   Fri, 08 Dec 2023 10:36:21 +0100
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

On Wed, 06 Dec 2023 17:37:24 +0300, Dan Carpenter wrote:
> This code dereferences "page->pvr_dev" and then checked for NULL on the
> next line.  Re-order it to avoid a potential NULL pointer dereference.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

