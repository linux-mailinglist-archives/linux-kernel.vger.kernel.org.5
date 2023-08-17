Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AFF77F49A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350077AbjHQK6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245144AbjHQK5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:57:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F8A82D4A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 03:57:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA64DD75;
        Thu, 17 Aug 2023 03:58:27 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7AE8B3F762;
        Thu, 17 Aug 2023 03:57:45 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@lnaro.org>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        James Clark <james.clark@arm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] coresight: etm4x: Ensure valid drvdata and clock before clk_put()
Date:   Thu, 17 Aug 2023 11:57:33 +0100
Message-Id: <169226979802.555124.13592500454111810038.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817035926.157370-1-anshuman.khandual@arm.com>
References: <20230817035926.157370-1-anshuman.khandual@arm.com>
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

On Thu, 17 Aug 2023 09:29:26 +0530, Anshuman Khandual wrote:
> This validates 'drvdata' and 'drvdata->pclk' clock before calling clk_put()
> in etm4_remove_platform_dev(). The problem was detected using Smatch static
> checker as reported.
> 
> 

Applied, thanks!

[1/1] coresight: etm4x: Ensure valid drvdata and clock before clk_put()
      https://git.kernel.org/coresight/c/a4621fd1d4fd

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>
