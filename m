Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4688005D0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377874AbjLAIho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377850AbjLAIhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:37:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C311713
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 00:37:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DAFC433AD;
        Fri,  1 Dec 2023 08:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701419868;
        bh=bh85U6qN+NrzkHALJLdBDTWd6uulN/hrqM1AYU0gOBg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ISHSQGMzW++hzOPN4QdItD7NV5eW5IO8efyUg1rRCBw1eJvEcUYJWuj+RLY39Q2FW
         xvPRi7C1moOHe1ziCAQTJJYP/Mqfg6FQ/WRuNqMCLG9+azMHajN7vuOT9ieV/n11xh
         Fa61TXxgsQ0mWwq39/X2nyDXOYMGRh9SZpxsOiFxu5BBJj3axAaoiVHKL5CbtECmDj
         heNDpgCH4hRxz5ssaTjC9qJv7IixunS8BWgDQGuHVhv76nOmsOPnkbTT7VJ8n80+O7
         6Kuo58z2wRajfaX2ZOxA5kMdItdvAQfsXfQSq3bnXQ0mhsVZpR9M2DZ+jzEE1/p3l2
         EvsKlZKZ98kxQ==
From:   Maxime Ripard <mripard@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Donald Robson <donald.robson@imgtec.com>
Cc:     matt.coster@imgtec.com, frank.binns@imgtec.com,
        boris.brezillon@collabora.com, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20231130160017.259902-2-donald.robson@imgtec.com>
References: <20231130160017.259902-1-donald.robson@imgtec.com>
 <20231130160017.259902-2-donald.robson@imgtec.com>
Subject: Re: (subset) [PATCH v2 2/5] drm/imagination: Fixed missing header
 in pvr_fw_meta
Message-Id: <170141986571.3198881.12603407007353117665.b4-ty@kernel.org>
Date:   Fri, 01 Dec 2023 09:37:45 +0100
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

On Thu, 30 Nov 2023 16:00:14 +0000, Donald Robson wrote:
> A missing header causes the compiler to warn that the function below is not
> forward declared.
> 
> >> drivers/gpu/drm/imagination/pvr_fw_meta.c:33:1: warning: no previous prototype for function 'pvr_meta_cr_read32' [-Wmissing-prototypes]
>       33 | pvr_meta_cr_read32(struct pvr_device *pvr_dev, u32 reg_addr, u32 *reg_value_out)
>          | ^
>    drivers/gpu/drm/imagination/pvr_fw_meta.c:32:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>       32 | int
>          | ^
>          | static
>    1 warning generated.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

