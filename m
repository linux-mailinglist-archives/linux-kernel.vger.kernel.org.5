Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C52E7D22D0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 13:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjJVLJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 07:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjJVLJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 07:09:07 -0400
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87AEE3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 04:09:03 -0700 (PDT)
Received: from Vostro-3710.lan (unknown [58.61.140.248])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id A9001800084;
        Sun, 22 Oct 2023 19:08:15 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     jernej.skrabec@gmail.com
Cc:     andre.przywara@arm.com, conor+dt@kernel.org, robh+dt@kernel.org,
        samuel@sholland.org, wens@csie.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: h616: update emac properties for Orange Pi Zero 3
Date:   Sun, 22 Oct 2023 19:08:11 +0800
Message-Id: <20231022110811.1109389-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3254946.aeNJFYEL58@jernej-laptop>
References: <3254946.aeNJFYEL58@jernej-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGBpOVk9KTEkaHUJDHkJPHlUTARMWGhIXJBQOD1
        lXWRgSC1lBWU5DVU1KVUpPS1VJT0NZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Tid: 0a8b57124132b03akuuua9001800084
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PyI6PCo4MTw6UUIxNjcvPC4f
        KQgKChVVSlVKTUJMQkxJQ0JNTUhLVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWU5D
        VU1KVUpPS1VJT0NZV1kIAVlBSUlJQzcG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you also explain how did you figure out that additional PHY properties
> are needed? At first glance, based on description of motorcomm,keep-pll-enabled,
> it's not immediately clear why it should be needed. Same goes for second
> property.

This is based on a search for
'motorcomm,clk-out-frequency-hz = <125000000>' in the kernel.
Refer to device tree of other devices with the same properties.
After a simple short test, it seems that it is unnecessary.
I will delete these two properties in patch v2.

> 1800 ps delay basically means that rgmii is not correct type and rgmii-rxid
> should be used instead. Indeed, schematic confirms that's the case. With that,
> allwinner,rx-delay-ps can be 0 and thus ommited from DT file.

Thanks, rgmii-rxid works for me. Will be corrected in patch v2.

Thanks,
Chukun

-- 
2.25.1

