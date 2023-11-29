Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13DE7FE248
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjK2VtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjK2VtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:49:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAE298
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:49:28 -0800 (PST)
Received: from notapiano (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DB0716607322;
        Wed, 29 Nov 2023 21:49:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701294566;
        bh=2gj9NzAWMfdqhV+kfWsNMx9rUz3XS8mCH9IzNviy5r8=;
        h=Date:From:To:Cc:Subject:From;
        b=DI+fmpG9YdhBFCVdxlN6MLPRWs8UlJI0lEi6wz2rHZd9xkRaeinkmjbkQdr6CW4Bb
         UYcpGLfvB2WTxgStbLU0E5rWd5LSSda+FpEMP7046+Wty6ZqphUBD/upkpevD3FY14
         aBWxaOMLdcNiIyB3zX/j7ztsCd2LLWAcralvLWDPpYk8ePowEAUbnBofr5P0fxGcMp
         peOMpQ3h6wjCGZ6HcebHfzTjPr26PFfZXRVZtf/lV5yBSGs8hRRBnA+2EkEkqeCbl8
         orNcMMODmaagnoDEcp/xQBCZLfWvUIphHc/rkVjzN0SYM8eVLwZBDzXsM0lW+NS+jK
         IyqNWrHPhjAmw==
Date:   Wed, 29 Nov 2023 16:49:21 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Adding SPMI tree to linux-next
Message-ID: <facc6759-b222-4912-9d78-deebecc977db@notapiano>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

I've noticed your spmi-next [1] branch is not currently tracked by linux-next
[2]. Could you please consider adding it?

There's a machine (MT8195 Tomato Chromebook) that relies on a fix from that
branch to reliably boot, and since the machine is hooked up to KernelCI to run
tests on top of linux-next, having the fix integrated into next would make the
test results more useful, the machine's current upstream support easily
verifiable and regressions detectable.

Thanks,
Nícolas

[1] https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git/log/?h=spmi-next
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/diff/Next/Trees
