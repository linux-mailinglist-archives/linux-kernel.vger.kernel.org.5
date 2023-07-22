Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DCA75DAF7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 10:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjGVIHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 04:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGVIHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 04:07:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D62A42D79
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:07:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 973A71FB;
        Sat, 22 Jul 2023 01:08:28 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 05FF53F67D;
        Sat, 22 Jul 2023 01:07:43 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org, peng.fan@nxp.com,
        quic_nkela@quicinc.com, Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH] firmware: arm_scmi: Fix chan_free cleanup on SMC
Date:   Sat, 22 Jul 2023 09:07:41 +0100
Message-ID: <169001322427.3545964.6410630104067663771.b4-ty@arm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719173533.2739319-1-cristian.marussi@arm.com>
References: <20230719173533.2739319-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 18:35:33 +0100, Cristian Marussi wrote:
> SCMI transport based on SMC can optionally use an additional IRQ to signal
> message completion; the associated ISR is currently allocated using devres
> but the core SCMI stack, on shutdown, will call .chan_free() well before
> any managed cleanup is invoked by devres and, as a consequence, the arrival
> of a late reply to an in-flight pending transaction could still trigger the
> ISR well after the SCMI core has cleaned up the channels, with unpleasant
> results.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: arm_scmi: Fix chan_free cleanup on SMC
      https://git.kernel.org/sudeep.holla/c/d1ff11d7ad87
--
Regards,
Sudeep

