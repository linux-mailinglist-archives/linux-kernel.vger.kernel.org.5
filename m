Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AAC77F670
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350862AbjHQM3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350867AbjHQM3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:29:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20184271F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:29:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A963766EA9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 12:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAACC433C7;
        Thu, 17 Aug 2023 12:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692275357;
        bh=zOJ5Vn8afCMHoM0g9p/wkMGQesUHcCwiemYIrx0LZTw=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=fWfk6XvNL3jYcifOSCH9LBF3guqrugP6N5HZW55U0YWVTamxCrHv9OWkupURdl0nL
         ILbbEcr8otS2NgAEZoXQB+fUBvR0cnUtghqkAz59UcH2HS9rqKnQKmXyaJg0lnwqJ1
         G2PPwXyCk8wonu3oW0hVE9oAFWc4jUAZDTkZdmWglyXkXGQJLQsZh6vNL/9KfPiQnC
         4D42ENcYahVqCtsNC5TuVWeBOlz/Gkr4JUp24Q/dwO2MYCsYg4ItQqrs37VnxI3Bzn
         WdLmzD+qQLsQsRecLuwexo+R5FGKWarzmVwd6OQ+jikmJL8QLF5lpBdpA//fepBv0o
         8boY2WnSbmdFg==
From:   Lee Jones <lee@kernel.org>
To:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230808130003.4076702-1-ruanjinjie@huawei.com>
References: <20230808130003.4076702-1-ruanjinjie@huawei.com>
Subject: Re: (subset) [PATCH -next] mfd: tc3589x: Remove redundant
 of_match_ptr()
Message-Id: <169227535616.1025957.13789465611029331682.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 13:29:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Aug 2023 21:00:02 +0800, Ruan Jinjie wrote:
> The driver depends on CONFIG_OF, it is not necessary to use
> of_match_ptr() here.
> 
> 

Applied, thanks!

[1/1] mfd: tc3589x: Remove redundant of_match_ptr()
      commit: 85356d665015540338ce84cfeba6c37704cd1b22

--
Lee Jones [李琼斯]

