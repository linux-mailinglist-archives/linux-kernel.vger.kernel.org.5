Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C83C77E8A2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345494AbjHPSZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345564AbjHPSZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:25:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BEA10C1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:25:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BB82638E2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 18:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E65C433CC;
        Wed, 16 Aug 2023 18:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692210349;
        bh=DYPmhYIuh9bFpNKPVU8nxjO5wHmWj7wxN2CiZWVEWR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AZz+pDqKjvi60FLbwD0Vqy3J5qNH9AGQNFfSXHXbQZGZuU7hzh4zNn/WS8uTv7Ie8
         JnRIqduCk5BAsE5d6n/MAOR6Wz6MtqNLJ1GMea5M5EWj0vyaMQGtSEa2JeKyIKVcRE
         /bPd2lJ/vRkx7cEgcF7ml3H9+GfNFzV+VRDMZs0nQWalhjrWBE05yYac+A3LLYOG2/
         B+dKwm8g5uWFLAUF8unI2P38X2kqC1mzXyWI2kfMGVOPod9IyaMWChrTi8/JNQg1kd
         YqnHuONEnS3WLqR6j8Fh28IounbgftW6Rj9GYhqLOfmEsPTDVlKEdmdCdzWtfgc9PM
         4Inf0PxZqiIkA==
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, Yicong Yang <yangyicong@huawei.com>,
        jonathan.cameron@huawei.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, prime.zeng@hisilicon.com,
        linux-kernel@vger.kernel.org, hejunhao3@huawei.com,
        linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org,
        yangyicong@hisilicon.com
Subject: Re: [PATCH v2 RESEND] drivers/perf: hisi: Schedule perf session according to locality
Date:   Wed, 16 Aug 2023 19:25:29 +0100
Message-Id: <169219246371.1945208.15145762874971798248.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230815131010.2147-1-yangyicong@huawei.com>
References: <20230815131010.2147-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 21:10:10 +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The PCIe PMUs locate on different NUMA node but currently we don't
> consider it and likely stack all the sessions on the same CPU:
> 
> [root@localhost tmp]# cat /sys/devices/hisi_pcie*/cpumask
> 0
> 0
> 0
> 0
> 0
> 0
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] drivers/perf: hisi: Schedule perf session according to locality
      https://git.kernel.org/will/c/83a6d80c2bfd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
