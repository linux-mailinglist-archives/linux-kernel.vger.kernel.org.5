Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CE1809F2F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjLHJXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbjLHJXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:23:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EA9172B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 01:23:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8611DC433C7;
        Fri,  8 Dec 2023 09:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702027430;
        bh=8OKSkc37GqD1hhdq1qHNAv72gT7ownApsTE4qDcF0aw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IEFVVX8rcnFCr8X12QXLAg/kSs1vQpQ0dB/O10eu0OqplaCbjSus2/W+zozrl4FXQ
         xKoLedcf+mBEx8NYJNFyN2f6AGIg2+0mmFiSZah1wgL8DtNjPuGRyYaAFhR4FZyZGa
         pU9V6b8voPW/3dUKQr6LBh9Y9iAYStW1GUPgUobBF6kKUZuzCXEW7NMkSfyOgeAU2R
         gbefywtzFVCsu4lZJQXeMBS261j0cMnYGhHGaMbku40yAVybUoufMKdKEDx+Lvtc+Z
         CxL98nX4fQ1U9US/6Nhd9mWiMchAgwlSSGtiPGGqtLInIRmvbc/m1cdEnO0NcOKmpy
         x1ld9JOeh0FAw==
From:   Maxime Ripard <mripard@kernel.org>
To:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, ivan.orlov0322@gmail.com,
        maarten.lankhorst@linux.intel.com, skhan@linuxfoundation.org,
        tzimmermann@suse.de, Ziqi Zhao <astrajoan@yahoo.com>
Cc:     syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, linaro-mm-sig@lists.linaro.org,
        glider@google.com,
        syzbot+4fad2e57beb6397ab2fc@syzkaller.appspotmail.com,
        sumit.semwal@linaro.org, linux-media@vger.kernel.org
In-Reply-To: <20230721161446.8602-1-astrajoan@yahoo.com>
References: <20230716043411.4950-1-astrajoan@yahoo.com>
 <20230721161446.8602-1-astrajoan@yahoo.com>
Subject: Re: [PATCH] drm/crtc: Fix uninit-value bug in drm_mode_setcrtc
Message-Id: <170202742812.13384.8140202310424410642.b4-ty@kernel.org>
Date:   Fri, 08 Dec 2023 10:23:48 +0100
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

On Fri, 21 Jul 2023 09:14:46 -0700, Ziqi Zhao wrote:
> The connector_set contains uninitialized values when allocated with
> kmalloc_array. However, in the "out" branch, the logic assumes that any
> element in connector_set would be equal to NULL if failed to
> initialize, which causes the bug reported by Syzbot. The fix is to use
> an extra variable to keep track of how many connectors are initialized
> indeed, and use that variable to decrease any refcounts in the "out"
> branch.
> 
> [...]

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime

