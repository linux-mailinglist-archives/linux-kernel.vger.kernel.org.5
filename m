Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D02C7AA23C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjIUVNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjIUVNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:13:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74695A9F4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:07:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A30C3277D;
        Thu, 21 Sep 2023 09:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695289075;
        bh=f0hMerwRhx/1AQZRWpVJNP5Dke4BMcZtppjsfSmRH0I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kHPfPTO2JHn/nno2XF9xqccLf8ZLsXKtGAYzlcrNiiC+tgoXkVBfRENP+YB1U6rlI
         ggtEC3/3s8YEZXSBrY0+Q1uvJfmAmL9oXmfO4xBN5H47SXqOd/kEVpzjNEo9w0jHnV
         P1GzoopstKYbmX/sDs3DdqpDoNUc+cJthz+usVFJGAzCdYkXn0Byqt+YBSZ2EiGOug
         aFxhACmSDPkEdtrKbWW5DtTEn0w4DppE8fmGl8xcKtNN0OF2mzUhOnmFalFrwLWVtW
         lXsMuy78wLUMmdU8T2VzTDl5aj2l9SY9kIFTfhuXjJqAPzQov+m/RUBYt/DEh5pcc3
         DSnga4THCyy2w==
From:   Vinod Koul <vkoul@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        rdunlap@infradead.org
In-Reply-To: <20230920160401.854052-1-ckeepax@opensource.cirrus.com>
References: <20230920160401.854052-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] soundwire: bus: Make IRQ handling conditionally
 built
Message-Id: <169528907320.97239.11506619845267367958.b4-ty@kernel.org>
Date:   Thu, 21 Sep 2023 11:37:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 20 Sep 2023 17:04:01 +0100, Charles Keepax wrote:
> SoundWire has provisions for a simple callback for the IRQ handling so
> has no hard dependency on IRQ_DOMAIN, but the recent addition of IRQ
> handling was causing builds without IRQ_DOMAIN to fail. Resolve this by
> moving the IRQ handling into its own file and only add it to the build
> when IRQ_DOMAIN is included in the kernel.
> 
> 
> [...]

Applied, thanks!

[1/1] soundwire: bus: Make IRQ handling conditionally built
      commit: 3b6c4a11bf2b810f772f5c2c1ef6eef3fc268246

Best regards,
-- 
~Vinod


