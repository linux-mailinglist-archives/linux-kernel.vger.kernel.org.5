Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8697A98D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjIURxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjIURxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:53:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C467F66353
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:34:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72E2A169E;
        Thu, 21 Sep 2023 06:55:08 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B649D3F59C;
        Thu, 21 Sep 2023 06:54:29 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        etienne.carriere@foss.st.com, peng.fan@oss.nxp.com,
        chuck.cannon@nxp.com, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com
Subject: Re: [PATCH v2 0/6] Add SCMI v3.2 Clock new CONFIGs support
Date:   Thu, 21 Sep 2023 14:54:27 +0100
Message-ID: <169530443907.3223609.9080063769460703725.b4-ty@arm.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230826125308.462328-1-cristian.marussi@arm.com>
References: <20230826125308.462328-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Aug 2023 13:53:02 +0100, Cristian Marussi wrote:
> this small series introduces support for the new Clock CONFIG features
> added by SCMI v3.2 specification [1].
> 
> It does NOT add support, still, for the SCMI v3.2 Clock reparenting
> features added in v3.2 too.
> 
> After a small refactoring in [1/6], support for the new CONFIG_SET message
> format is added in [2/6]: this is just internal rework to support new and
> legacy (pre-v3.2) message formats.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/6] firmware: arm_scmi: Simplify enable/disable Clock operations
      https://git.kernel.org/sudeep.holla/c/03a95cf233b5
[2/6] firmware: arm_scmi: Add Clock v3.2 CONFIG_SET support
      https://git.kernel.org/sudeep.holla/c/e49e314a2cf7
[3/6] firmware: arm_scmi: Add v3.2 Clock CONFIG_GET support
      https://git.kernel.org/sudeep.holla/c/34592bf0a5cb
[4/6] firmware: arm_scmi: Add Clock .state_get support to pre-v3.2
      https://git.kernel.org/sudeep.holla/c/5b8a8ca37e49
[5/6] clk: scmi: Add support for .is_enabled clk_ops
      https://git.kernel.org/sudeep.holla/c/1b39ff5140c9
[6/6] firmware: arm_scmi: Add Clock OEM config clock operations
      https://git.kernel.org/sudeep.holla/c/141b4fa03625
--
Regards,
Sudeep

