Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFE780708D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378412AbjLFNKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378112AbjLFNKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:10:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A1EAC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:10:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DE6C433C8;
        Wed,  6 Dec 2023 13:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701868217;
        bh=jIbKL5LRHGYHKC85M/i5/2RcS7LR3FeKW1eEn/Ul9/c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=P8LuolL+HT/EAp6zuZi0qpIGPEZaLt8V3lxRCn6ixgDsBoSYvHr5AVFnu2fDK24o5
         rvCWRWPNavbIlVctQOw8Q2OE3GCoM5CQnw7P6R2ahEy3d3m/cZCzy0NPaP3HTNXs/y
         NvYiJEgmwJ7F53fQxWePruKP7BEyg+V6wPeb5NWTh04wANouDTW/sK1Pny3P3jZ4Ww
         +vMeOEDXMhr/thS+/OSkOA8APUlSuoFethnyORthETEMKrCriL0XY6XWTf1EsVu2gU
         LLbIydvT1dTRq84LrQVBhbQaMnG5KxVdkADzeEVygwFI7CP1adtTjMp5vlL/PuhJ4X
         Md1WuGTAn7WLA==
From:   Maxime Ripard <mripard@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Donald Robson <donald.robson@imgtec.com>
Cc:     frank.binns@imgtec.com, matt.coster@imgtec.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20231204151337.60930-1-donald.robson@imgtec.com>
References: <20231204151337.60930-1-donald.robson@imgtec.com>
Subject: Re: (subset) [PATCH v2] drm/imagination: Removed unused functions
 in pvr_fw_trace
Message-Id: <170186821499.357447.5969662518847238769.b4-ty@kernel.org>
Date:   Wed, 06 Dec 2023 14:10:14 +0100
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

On Mon, 04 Dec 2023 15:13:37 +0000, Donald Robson wrote:
> Fixing the warning below due to an unused file level vtable. Removing
> only this causes additional warnings for the now unused functions, so
> I've removed those too.
> 
> >> drivers/gpu/drm/imagination/pvr_fw_trace.c:205:37: warning: 'pvr_fw_trace_group_mask_fops' defined but not used [-Wunused-const-variable=]
>      205 | static const struct file_operations pvr_fw_trace_group_mask_fops = {
>          |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

