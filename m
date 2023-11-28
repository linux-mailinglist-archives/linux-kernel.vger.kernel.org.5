Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA8C7FB67A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343899AbjK1KAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjK1KAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:00:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14C0DD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:00:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F81AC433C8;
        Tue, 28 Nov 2023 10:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701165610;
        bh=0XDd4GId1RUumC+pfTyLbSLBfY6q4ATklJ1bRPcr5kY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dBFf0MSsT0mRWp7hxYHFsMt2/EA775dXxS2oMfXUDMyXCZFvT1qOdNv8cfXNwvxZD
         jIlUWD2celdR/K6UjdwDHOx6d9+sHP/E/MldfD4Wrf4VvACja4WJdDsODA+OqsYjCS
         3MVHOJfdctK3Jwwu6fr+ejd5c38zdD+DyUpGPtcObT2+CDmmKUeWEb+BCW79gQQwYo
         t8p2RHeLgH1PL6WRsK74WALbcNqERGjXmS51cDajN++v8DlPzpL/QpsPs9ZDEpX2/N
         lJAtNWhfaGOLT1BwgwSJTXD4ojAou7/aVP3mkTMxJ36LfQxoQBlVCGG+KZF9yJu84M
         y/ylJO4XKr5ww==
From:   Vinod Koul <vkoul@kernel.org>
To:     linux-sound@vger.kernel.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20231127124405.2080431-1-yung-chuan.liao@linux.intel.com>
References: <20231127124405.2080431-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: generic_bandwidth_allocation use
 bus->params.max_dr_freq
Message-Id: <170116560796.73868.7251028532785421026.b4-ty@kernel.org>
Date:   Tue, 28 Nov 2023 15:30:07 +0530
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


On Mon, 27 Nov 2023 20:44:05 +0800, Bard Liao wrote:
> bus->params.max_dr_freq is calculated and set in sdw_bus_master_add().
> We can use it directly instead of calculating it again.
> 
> 

Applied, thanks!

[1/1] soundwire: generic_bandwidth_allocation use bus->params.max_dr_freq
      commit: 55d50ace6b88eb273a10963160cadbadccfcdd64

Best regards,
-- 
~Vinod


