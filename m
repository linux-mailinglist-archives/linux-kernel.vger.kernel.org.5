Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA5677CDDF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbjHOOL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237534AbjHOOK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:10:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE87199B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:10:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39D66651C7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535A4C433C7;
        Tue, 15 Aug 2023 14:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692108657;
        bh=ja6LcUYlIg8akYex1UYrFdK9oOg2Smd4yqpdJcFupds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+P7qArAEreMUVVrVIq6MMBq1CuMRPRWh44nLTf8Ikp1OIYB/mRoYrRUsO+UuvF/T
         5Dfmig9tTJm7f/p0ynxD5jZJKCxaO6tIoBAQbgjA8+4O61IJri8tFx0PdSLNsFlj6i
         Qh9OEoEktTtWodr01sQcDAj8b0QmKA1JHSho4o3gLp8Rq3mVApORRSU7zx/kf+eiHB
         9yl1nrMwWPq3+K5a2HkmZWFsP2NWE8cAak2AWHPDWCUdsTLwLN2MPlbgpUVmR2umIp
         p9/LQNzqpsHotkXukg0QxEqVV119F1TJ4m37V2M3xTJ1X7i745/dADTFspvSxDUpPE
         qDruIXFMeDKGA==
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, liliang6@email.cn,
        linux-kernel@vger.kernel.org, 21cnbao@gmail.com,
        Yicong Yang <yangyicong@huawei.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, jonathan.cameron@huawei.com,
        linuxarm@huawei.com, yangyicong@hisilicon.com
Subject: Re: [PATCH v2] perf/smmuv3: Add MODULE_ALIAS for module auto loading
Date:   Tue, 15 Aug 2023 15:10:49 +0100
Message-Id: <169210038508.538825.12874741797783565923.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230814131642.65263-1-yangyicong@huawei.com>
References: <20230814131642.65263-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 21:16:42 +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> On my ACPI based arm64 server, if the SMMUv3 PMU is configured as
> module it won't be loaded automatically after booting even if the
> device has already been scanned and added. It's because the module
> lacks a platform alias, the uevent mechanism and userspace tools
> like udevd make use of this to find the target driver module of the
> device. This patch adds the missing platform alias of the module,
> then module will be loaded automatically if device exists.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/smmuv3: Add MODULE_ALIAS for module auto loading
      https://git.kernel.org/will/c/1b0e3ea9301a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
