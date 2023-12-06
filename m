Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BCA807090
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378427AbjLFNKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378414AbjLFNKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:10:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABAB1A5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:10:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE206C433C8;
        Wed,  6 Dec 2023 13:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701868220;
        bh=h9KWpohyTTR3pTq0NasEcVnQ4d28IL9h85MEdUeIIK0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EPvHc7hY/n7aNn4K0+fbS9tNtpE4h3wneK9nI/9mhJZtawvSq6BdhQYu2mMnimYaT
         8L9nhgbracmjU6JuMzv8Mc5JksS5UYPnSXlvW481bxAVtaKuVzlVG0BG0jB/HX5ZiZ
         O/fgZsW12TkNt7P/zT/gREKO3uMn0FwteP9SfGGGP8/2+Scr2xQGE0oMwfM9gNBgY9
         c8/PO8qgnkJFdivu6dl2kqLjpQSny1wFq8Sp1yPUEBrRDTe3W8IVzhdy5aN/LGf/vy
         XJPr6IELbXQjivPkFk8TVp3dcnEXwzAV7UHXMVw1aQ3V56kSjBzg5zldiyaWOzJ0h5
         6+Up6o37toN1g==
From:   Maxime Ripard <mripard@kernel.org>
To:     Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sarah Walker <sarah.walker@imgtec.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231204073231.1164163-1-arnd@kernel.org>
References: <20231204073231.1164163-1-arnd@kernel.org>
Subject: Re: (subset) [PATCH] drm/imagination: move update_logtype() into
 ifdef section
Message-Id: <170186821781.357447.7620047835600780144.b4-ty@kernel.org>
Date:   Wed, 06 Dec 2023 14:10:17 +0100
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

On Mon, 04 Dec 2023 08:32:10 +0100, Arnd Bergmann wrote:
> This function is only used when debugfs is enabled, and otherwise
> causes a build warning:
> 
> drivers/gpu/drm/imagination/pvr_fw_trace.c:135:1: error: 'update_logtype' defined but not used [-Werror=unused-function]
> 
> Move the #ifdef check to include this function as well.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

