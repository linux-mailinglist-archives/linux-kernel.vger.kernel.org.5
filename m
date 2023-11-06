Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24D47E1D6E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjKFJsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjKFJsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:48:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EB6DB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 01:48:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4153DC433C7;
        Mon,  6 Nov 2023 09:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699264100;
        bh=h+NSCPSwlpTiwPS/t/qXHGHCzH25S5Gk5v0x2k5LBkU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UYgfyXoKhcRw7fX2jwEFhlsk36VUopg/olpvjv+aIv6xKPdXk+tD6n6fRDQuEcQI4
         K1rQntb/DrNvBP1wBahGsHLn+QBgq5jyUhlhYI0kHsu+RMWMagZ1OC4ytqNcxzRDS3
         WNSGDxHS9zcPiy8ByzgU2yWBTkvwfwVTWq/kVyxn0KN5/oDD+/VVfKwMeSsAV21u+m
         xy2t9X8+oGMxjStITIzILXu5CwWUYyesF8T2+vbOceRau2lixoz+E24gInZRJPHNoF
         imCR3cW/nbBbRMCLHEaYscmjzrHpy0j4BOMFpE/R5LKcptNp5KLdalL/jOACNbLAg/
         o4W5099wqcK9w==
From:   Maxime Ripard <mripard@kernel.org>
To:     airlied@redhat.com, kraxel@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch, Zongmin Zhou <zhouzongmin@kylinos.cn>
Cc:     virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230801025309.4049813-1-zhouzongmin@kylinos.cn>
References: <20230425014543.3448839-1-zhouzongmin@kylinos.cn>
 <20230801025309.4049813-1-zhouzongmin@kylinos.cn>
Subject: Re: [RESEND PATCH] drm/qxl: prevent memory leak
Message-Id: <169926409790.498855.8582421584361847884.b4-ty@kernel.org>
Date:   Mon, 06 Nov 2023 10:48:17 +0100
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

On Tue, 01 Aug 2023 10:53:09 +0800, Zongmin Zhou wrote:
> The allocated memory for qdev->dumb_heads should be released
> in qxl_destroy_monitors_object before qxl suspend.
> otherwise,qxl_create_monitors_object will be called to
> reallocate memory for qdev->dumb_heads after qxl resume,
> it will cause memory leak.
> 
> 
> [...]

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime

