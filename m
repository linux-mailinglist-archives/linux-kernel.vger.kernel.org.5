Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7262578447F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbjHVOiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbjHVOiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:38:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF69D126
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:38:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C9896592A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD58CC433C7;
        Tue, 22 Aug 2023 14:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692715123;
        bh=1+RJ1M6QJX8MLAXrvtw4SmvGw+B+4yYVB2UUeN6A+zc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kkssIQIy+tpavbENVGV+TbD3Q/lvmWOhmT72sjkTzTtHjzBpzUndVdzDath4cEwYd
         9uGqk0Ufu03x7mSsSsa6ZHF4/DUPD5MotI8zweCY8Tz6lLGvf+Rp0113++Mdd3o3JS
         dJ+4sxLvCnam1F+/qyeGMBmF9PPJZPl6UBxIeDJQuxXkw5BuZPARvBsel4jJVfwuXU
         s0A5HB25wKRFVYjvv0/tMb0yay/18trXA2GqcFZe7cPj4fl7BYvIQzAP9NX+vuDudl
         mqSdkvr/3fW+mZY2W16IqVuNxS0CzNQgh0IrpfufiOgFRANURVjmWZ0pqYWDdqdNZl
         tKPvMatD/wYNA==
From:   Vinod Koul <vkoul@kernel.org>
To:     alsa-devel@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20230802061947.3788679-1-yung-chuan.liao@linux.intel.com>
References: <20230802061947.3788679-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: intel_ace2x: add DAI
 hw_params/prepare/hw_free callbacks
Message-Id: <169271512146.281392.3704161093550026838.b4-ty@kernel.org>
Date:   Tue, 22 Aug 2023 20:08:41 +0530
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


On Wed, 02 Aug 2023 14:19:47 +0800, Bard Liao wrote:
> The code is fork-lifted from intel.c and is mostly similar *except*
> for the SHIM configuration which cannot be done here with the
> introduction of HDAudio Extended links. The ACE2.x SOF side also
> requires the hw_free and trigger callbacks to be implemented for
> HDaudio DMA management
> 
> 
> [...]

Applied, thanks!

[1/1] soundwire: intel_ace2x: add DAI hw_params/prepare/hw_free callbacks
      commit: 8c4c9a9ae5aff2125ea44f0b26f9e3701d56d6db

Best regards,
-- 
~Vinod


