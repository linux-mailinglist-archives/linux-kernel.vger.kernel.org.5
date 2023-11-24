Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F597F752D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345221AbjKXNcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjKXNck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:32:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E596D10FF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:32:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5D7C433C7;
        Fri, 24 Nov 2023 13:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700832766;
        bh=o1nAJawZujV8ky8aBl2/Qzgffw+hVov2napCORg7MCE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=k83ufH4ExiieTHPouLNWbD5c/SIUNv0xaujtcNKGT0wyNCYDyoEI1P9x+F1Wzzlyg
         QvC07Mu8cgBz9mQd7mm+4C+rqQTtrn9W5jSCJdJg9TzL2Lndq/PPxqi56jNqmw8McJ
         h7I3Ghm/VXxaHu8p6n7+4goIHIeDbpKY3vq1Get4rcojihaafE/Fp89OwHxDFlCzKk
         mSh9jpgFRPGVThkWl9rcxOWOwuo7sRc6kNX6EJwYt158BAuQqhBieKLSXCaUHQmeWk
         EzxP95f4O/3dSkoGaUj0doRr4RPxvIZnDUMh6y2wSAlE+99CWOjtA+vM8GV8BIUnz+
         F0cBHyJjV1cpQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jai Luthra <j-luthra@ti.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ronald Wahl <rwahl@gmx.de>
In-Reply-To: <20231123-psil_fix-v1-1-6604d80819be@ti.com>
References: <20231123-psil_fix-v1-1-6604d80819be@ti.com>
Subject: Re: [PATCH] dmaengine: ti: k3-psil-am62a: Fix SPI PDMA data
Message-Id: <170083276437.771401.9856922958033463487.b4-ty@kernel.org>
Date:   Fri, 24 Nov 2023 19:02:44 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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


On Thu, 23 Nov 2023 14:57:31 +0530, Jai Luthra wrote:
> AM62Ax has 3 SPI channels where each channel has 4x TX and 4x RX
> threads. Also fix the thread numbers to match what the firmware expects
> according to the PSI-L device description.
> 
> 

Applied, thanks!

[1/1] dmaengine: ti: k3-psil-am62a: Fix SPI PDMA data
      commit: be37542afbfcd27b3bb99a135abf9b4736b96f75

Best regards,
-- 
~Vinod


