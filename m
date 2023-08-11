Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9D97787D4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjHKHGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjHKHGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:06:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2022A271B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 00:06:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3CCB6514E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 07:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A73EC433C7;
        Fri, 11 Aug 2023 07:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691737609;
        bh=9t9OXLwolWaZM2qZYGvnVDgliT55fV8UASsB6brD4gc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZHAhG/Bqk5JY8S79U5V9cV8xv52fYcY10p51wM7MvOm8x78u2z7A6RDzZO8sTBWDW
         gn28BZIQ2Bld0akDFrR6wE7luCCx6NfRT3fMXAVCSI8cMhH/IEoGnt3oWhQPExwvOv
         oA1CmXLazKqVNqZmcW+CYALhLfINK3RLBnTRQz8QTmIDaCAz4+uk2GF8bJtlOMP07r
         hSx9ikq6Kub2Dm6hPJChtEDMRnIc/F5NpX+L3cruv3CJNBwEU5FJVFXRzt6xu/yvfB
         2vnJbBjtYtcOcs2/Np1rC/dSHV5H10kfMvSNEeH1omWfGgsakki6wcDXdMRhkzzftE
         VvxZDPVrq1e2g==
From:   Vinod Koul <vkoul@kernel.org>
To:     alsa-devel@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20230803065220.3823269-1-yung-chuan.liao@linux.intel.com>
References: <20230803065220.3823269-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 0/2] soundwire: improve pm_runtime handling
Message-Id: <169173760795.104525.2454658180185831669.b4-ty@kernel.org>
Date:   Fri, 11 Aug 2023 08:06:47 +0100
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


On Thu, 03 Aug 2023 14:52:18 +0800, Bard Liao wrote:
> This patchset improves the pm_runtime behavior in rare corner cases
> identified by the Intel CI in the last 6 months.
> 
> a) in stress-tests, it's not uncommon to see the following type of
> warnings when the codec reports as ATTACHED
> 
>     "rt711 sdw:0:025d:0711:00: runtime PM trying to activate child device
>     sdw:0:025d:0711:00 but parent (sdw-master-0) is not active"
> 
> [...]

Applied, thanks!

[1/2] soundwire: intel_auxdevice: enable pm_runtime earlier on startup
      commit: 3d71f43f8a59a62c6ab832d4e73a69bae22e13b7
[2/2] soundWire: intel_auxdevice: resume 'sdw-master' on startup and system resume
      commit: f9031288110589c8f565683a182f194110338d65

Best regards,
-- 
~Vinod


