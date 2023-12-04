Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FF080355A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjLDNtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLDNtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:49:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC7C3D2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:49:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA3AC152B;
        Mon,  4 Dec 2023 05:50:06 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7F3063F5A1;
        Mon,  4 Dec 2023 05:49:18 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, nicola.mazzucato@arm.com
Subject: Re: [PATCH] firmware: arm_scmi: Add protocol versioning checks
Date:   Mon,  4 Dec 2023 13:49:12 +0000
Message-ID: <170169770105.30728.4184748461867553378.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201135858.2367651-1-cristian.marussi@arm.com>
References: <20231201135858.2367651-1-cristian.marussi@arm.com>
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

On Fri, 01 Dec 2023 13:58:58 +0000, Cristian Marussi wrote:
> Platform and agent supported protocols versions do not necessarily match.
>
> When talking to an older platform SCMI server, supporting only older
> protocol versions, the kernel SCMI agent will downgrade the version of
> the used protocol to match the platform one and avoid compatibility issues.
>
> In the case, instead, in which the agent happens to communicate with a
> newer platform server which can support newer protocol versions unknown to
> the agent, and potentially backward incompatible, the agent currently
> carries on, silently, in a best-effort approach.
>
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/1] firmware: arm_scmi: Add protocol versioning checks
      https://git.kernel.org/sudeep.holla/c/b5efc28a754d
--
Regards,
Sudeep

