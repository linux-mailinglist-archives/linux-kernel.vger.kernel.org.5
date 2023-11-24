Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5137F7545
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjKXNdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbjKXNdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:33:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590581FC8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:33:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6203C43397;
        Fri, 24 Nov 2023 13:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700832803;
        bh=uoPeOd9O4SgQkdeE6NWSU3YB1DPElD4w0UIMSK4oJHU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GTzGzVWZV+39lerM0qSCYf+1y8RdZ8n7t8PU66/S7rCtUkPt1dA/Dj18tWlK6GmeV
         opYFxwcixBvCQj7UQCpzeuCNacBDXgDwKXfC9cGVLp5V91JO4I52XkpWpM/Mg0TOJW
         iRvAXbNg65mBuGbSptYLdWpg0pJpStgi8GN7/omibD1sMN7nK9yPAcilAaleHgLOW+
         uBL9XiWuZiwiRQXisv8hPK8F2r8uz1V5XRKy4xBcpjNO2SRGIzEgvpWkeCiIrDxHOc
         fhEtaHFzd3UMW4c1NXtglt3U4YaRGurdMhlH2mOdjLKZGGMt+bQ9/AgR2Fa4FqV93H
         twZPW16ItI1iw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231029170704.82238-1-povik+lin@cutebit.org>
References: <20231029170704.82238-1-povik+lin@cutebit.org>
Subject: Re: [PATCH v2] dmaengine: apple-admac: Keep upper bits of
 REG_BUS_WIDTH
Message-Id: <170083280044.771517.11806054531627846759.b4-ty@kernel.org>
Date:   Fri, 24 Nov 2023 19:03:20 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Sun, 29 Oct 2023 18:07:04 +0100, Martin Povišer wrote:
> For RX channels, REG_BUS_WIDTH seems to default to a value of 0xf00, and
> macOS preserves the upper bits when setting the configuration in the
> lower ones. If we reset the upper bits to 0, this causes framing errors
> on suspend/resume (the data stream "tears" and channels get swapped
> around). Keeping the upper bits untouched, like the macOS driver does,
> fixes this issue.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: apple-admac: Keep upper bits of REG_BUS_WIDTH
      commit: 306f5df81fcc89b462fbeb9dbe26d9a8ad7c7582

Best regards,
-- 
~Vinod


