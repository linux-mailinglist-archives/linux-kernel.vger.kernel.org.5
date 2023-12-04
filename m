Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB194803548
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjLDNqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbjLDNqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:46:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0554FD2;
        Mon,  4 Dec 2023 05:46:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1484B152B;
        Mon,  4 Dec 2023 05:47:00 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A82B3F5A1;
        Mon,  4 Dec 2023 05:46:11 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     quic_mdtipton@quicinc.com, quic_asartor@quicinc.com,
        quic_lingutla@quicinc.com, Sibi Sankar <quic_sibis@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH 1/2] firmware: arm_scmi: Fix frequency truncation by promoting multiplier to u64
Date:   Mon,  4 Dec 2023 13:46:05 +0000
Message-ID: <170169746209.29716.16597269014104395598.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130204343.503076-1-sudeep.holla@arm.com>
References: <20231130204343.503076-1-sudeep.holla@arm.com>
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

On Thu, 30 Nov 2023 20:43:42 +0000, Sudeep Holla wrote:
> Fix the frequency truncation for all values equal to or greater 4GHz by
> updating the multiplier 'mult_factor' to u64 type. It is also possible
> that the multiplier itself can be greater than or equal to 2^32. So we need
> to also fix the equation computing the value of the multiplier.
>

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/2] firmware: arm_scmi: Fix frequency truncation by promoting multiplier to u64
      (Applied changing u64 to unsigned long to fix armv7 build)
      https://git.kernel.org/sudeep.holla/c/8e3c98d9187e
[2/2] firmware: arm_scmi: Fix possible frequency truncation when using level indexing mode
      https://git.kernel.org/sudeep.holla/c/77f5032e94f2
--
Regards,
Sudeep

