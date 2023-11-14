Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5627EADD3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjKNKSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjKNKSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:18:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5D0A4;
        Tue, 14 Nov 2023 02:18:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14F7C433C8;
        Tue, 14 Nov 2023 10:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699957108;
        bh=E6qJf5xkvt72gnGBq8WeS8tYIMgOIXLwZyGWKa+8WKg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OSN0dq8HLeTBHO7ktFmZI0+Y0fLYQbP9RpOimeZAMk2sDz7G8L6a614RYO2Y90VdS
         lfiyMaBRQyKomTtwqwbiaaEGtXyDDfJNmQ5a0YbQYtsaGN6NGis6CtX8IN4H8UPdwx
         pGuDD4L3TBXwr3NvU9kuVZND3uv+GyDG+jnQqYL5lHHLfiudOOVmXtxzwVvlESBw8i
         6/JCTGTUlQTZLxuLGLAVmrXsU5euzEircU/9B1ZJ5tpuD8NPidPfsLWBDiUTOBS9MB
         CynAdPjjWMJUbOpKYDPU2z8iJ2nvy4MVxbBAOIIYI3idenzZEscGFzsjNPldhJ96HD
         xEBtzeBGd2blQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rt2x00: correct wrong BBP register in RxDCOC
 calibration
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <TYAP286MB0315B13B89DF57B6B27BB854BCAFA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
References: <TYAP286MB0315B13B89DF57B6B27BB854BCAFA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        linux-kernel@vger.kernel.org, Shiji Yang <yangshiji66@outlook.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169995710456.3786790.695504990029617196.kvalo@kernel.org>
Date:   Tue, 14 Nov 2023 10:18:26 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shiji Yang <yangshiji66@outlook.com> wrote:

> Refer to Mediatek vendor driver RxDCOC_Calibration() function, when
> performing gainfreeze calibration, we should write register 140
> instead of 141. This fix can reduce the total calibration time from
> 6 seconds to 1 second.
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless-next.git, thanks.

50da74e1e8b6 wifi: rt2x00: correct wrong BBP register in RxDCOC calibration

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/TYAP286MB0315B13B89DF57B6B27BB854BCAFA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

