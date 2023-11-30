Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A117FEBB8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbjK3JSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjK3JSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:18:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A3F9D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:18:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01383C433C7;
        Thu, 30 Nov 2023 09:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701335931;
        bh=nT9nGRfMfU4zgEHa6fXZDXZZdiT3bkcMygf58AsjxvA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oT/IMeHMhtHPp9SwiakrtnQOomaEbeQQ3MX+Z0Sn3gUXDHeHrtiLnSG05innsBON0
         363PAMnvstx3bi1dB/K428ltGi+X4HJDHPWZ2U8bPNz1NpU/oPhyS7xlcS2eVCiR7w
         0IQfMIvRxEXO3tLgM6McOwxcOG9p3UL0gMHmAmq+f39el5JimFxEgunEkftfkrtWIq
         ghdz5FAwkmw9XUSPCuguHbXn04F/fHy1cjDeYjcvVof3wZ+ABgVqpJQau1xJFG4G1z
         QHhd5pH3d6vzWwl6p7r1cFWG/T42/PYOciAtLMXkL9fj7LzilePHbLXlNdJwAZZkYL
         b4A/R6UBi7lOg==
From:   Maxime Ripard <mripard@kernel.org>
To:     Sarah Walker <sarah.walker@imgtec.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <384288de-a779-46c7-869d-b3c63462e12b@moroto.mountain>
References: <384288de-a779-46c7-869d-b3c63462e12b@moroto.mountain>
Subject: Re: (subset) [PATCH 2/2] drm/imagination: Fix IS_ERR() vs NULL bug
 in pvr_request_firmware()
Message-Id: <170133592874.3076107.12823287713812257230.b4-ty@kernel.org>
Date:   Thu, 30 Nov 2023 10:18:48 +0100
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

On Thu, 30 Nov 2023 10:27:01 +0300, Dan Carpenter wrote:
> The pvr_build_firmware_filename() function returns NULL on error.  It
> doesn't return error pointers.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

