Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5607787D5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjHKHGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjHKHGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:06:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2272D57
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 00:06:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 158D265168
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 07:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AE2C433C8;
        Fri, 11 Aug 2023 07:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691737610;
        bh=YimjOo4i63vgRZqsG35a+urQVO7OPLU+EV2AAAkyZOI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=F47+daCAtAzDglTToTYMykUvM0fHnxXfUeLObZ0qhT+uEhG+toOw8klzE41vWXX2M
         EarXn6D1BTjxX4MQX5vll/u788CYCgqosmMkj2nKS8KDRFtny5xwA4s5N8lhLLCp9w
         1eb6edRsVHzVLxlkIH1pZ+Y72YLX084eFL89LsgHtj7xO/+rpgEYLaOzbad7s17u3T
         E8oFbBJyCncgz7NdvRhMAwyAAGI0+JRwpuApjSxzXNk69y3XWusZYpB9SbaBiipICX
         cGBHTmJ1TekiW0bzGQq93QHeJnysfVVn7KECqNI56EogpswIYLF2O0TmX5No2oRxkz
         K6s2hBsI6V0kA==
From:   Vinod Koul <vkoul@kernel.org>
To:     alsa-devel@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20230731091333.3593132-1-yung-chuan.liao@linux.intel.com>
References: <20230731091333.3593132-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v2 0/3] soundwire: allow for more than 8 devices, keep
 IDA for wake-capable devices
Message-Id: <169173760931.104525.18320129974065669032.b4-ty@kernel.org>
Date:   Fri, 11 Aug 2023 08:06:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Jul 2023 17:13:30 +0800, Bard Liao wrote:
> This series suggests a hybrid strategy for device number allocation, where
> only wake-capable devices use a system-unique Device Number which will be
> used on LunarLake to handle wake-ups using the HDaudio WAKEEN and WAKESTS.
> 
> Pierre-Louis Bossart (3):
>   soundwire: extend parameters of new_peripheral_assigned() callback
>   soundwire: bus: add callbacks for device_number allocation
>   soundwire: intel_auxdevice: add hybrid IDA-based device_number
>     allocation
> 
> [...]

Applied, thanks!

[1/3] soundwire: extend parameters of new_peripheral_assigned() callback
      commit: 23afc82fb22bccd3f1d2a856d3eccb70453f33b0
[2/3] soundwire: bus: add callbacks for device_number allocation
      commit: 39d80b0e5fed2c32f66093fead626358b7106974
[3/3] soundwire: intel_auxdevice: add hybrid IDA-based device_number allocation
      commit: e66f91a2d10b9a25eedcaddee9d6f08c8132760a

Best regards,
-- 
~Vinod


