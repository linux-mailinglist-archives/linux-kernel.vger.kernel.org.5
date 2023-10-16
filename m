Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0C27CB6DD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjJPXFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjJPXFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:05:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BBFA95
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:05:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAD951FB;
        Mon, 16 Oct 2023 16:06:17 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0ABE83F64C;
        Mon, 16 Oct 2023 16:05:35 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     coresight@lists.linaro.org, James Clark <james.clark@arm.com>,
        hejunhao3@huawei.com
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: Fix crash when Perf and sysfs modes are used concurrently
Date:   Tue, 17 Oct 2023 00:05:30 +0100
Message-Id: <169749720984.709368.4192452224332206520.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006131452.646721-1-james.clark@arm.com>
References: <20231006131452.646721-1-james.clark@arm.com>
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

On Fri, 6 Oct 2023 14:14:52 +0100, James Clark wrote:
> Partially revert the change in commit 6148652807ba ("coresight: Enable
> and disable helper devices adjacent to the path") which changed the bare
> call from source_ops(csdev)->enable() to coresight_enable_source() for
> Perf sessions. It was missed that coresight_enable_source() is
> specifically for the sysfs interface, rather than being a generic call.
> This interferes with the sysfs reference counting to cause the following
> crash:
> 
> [...]

Applied, thanks!

[1/1] coresight: Fix crash when Perf and sysfs modes are used concurrently
      https://git.kernel.org/coresight/c/078dbba3f0c9

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>
