Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF13B8005D4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377897AbjLAIhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377878AbjLAIho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:37:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5361725
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 00:37:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CE3C433C9;
        Fri,  1 Dec 2023 08:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701419871;
        bh=GtOb7UvLlhlShiykwkEEt3ZUh/apOEUuovQcZ9swJoU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WjUmokJhjx0vCMz+ZoiwLJ2b/MVhE9yvFT0hzWcwSKE3W2N8lIc6aZnjk/FyQvuQ3
         +yYX8QXxUWewlVhx25vqR1ma5pN6HxcnE1t5dZIROIpn1OSs8wjo0Pmne8YD9Kvwtw
         HF8v4kroDo09sbEawEl/0kqVmP8Oqupl2cF7ISzvInp5m+bvBitKHF6Kip6nWbSm11
         H8/wzzwGVRhCpeiowRqaIcROHsiZinCoaaejMb6pD1RBpvL+nTpjc11XYCSYvzT6mH
         MAA2gXHBlI0nZWI3un5JcqEOcvkavoMtk2PDe1P5avsNFeX2G/P8oB60IJsTqteADf
         rVP9i4v5Z20HA==
From:   Maxime Ripard <mripard@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Donald Robson <donald.robson@imgtec.com>
Cc:     matt.coster@imgtec.com, frank.binns@imgtec.com,
        boris.brezillon@collabora.com, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20231130160017.259902-3-donald.robson@imgtec.com>
References: <20231130160017.259902-1-donald.robson@imgtec.com>
 <20231130160017.259902-3-donald.robson@imgtec.com>
Subject: Re: (subset) [PATCH v2 3/5] drm/imagination:
 pvr_device_process_active_queues now static
Message-Id: <170141986885.3198881.10423861649737982177.b4-ty@kernel.org>
Date:   Fri, 01 Dec 2023 09:37:48 +0100
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

On Thu, 30 Nov 2023 16:00:15 +0000, Donald Robson wrote:
> The function below is used only within this source file, but is not static.
> 
> >> drivers/gpu/drm/imagination/pvr_device.c:129:6: warning: no previous prototype for function 'pvr_device_process_active_queues' [-Wmissing-prototypes]
>      129 | void pvr_device_process_active_queues(struct pvr_device *pvr_dev)
>          |      ^
>    drivers/gpu/drm/imagination/pvr_device.c:129:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>      129 | void pvr_device_process_active_queues(struct pvr_device *pvr_dev)
>          | ^
>          | static
>    1 warning generated.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

