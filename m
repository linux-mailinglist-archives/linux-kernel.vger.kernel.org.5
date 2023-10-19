Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A427CF907
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345630AbjJSMdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345491AbjJSMdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:33:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D42C91
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:33:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F80C433C7;
        Thu, 19 Oct 2023 12:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697718829;
        bh=jMTp0m6MfwgWXwlTJUktp8D/eh+f+Wr88dtNX2jwcC0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HdRftkJ8ItEXgT8niZD7tQewxfT1vrZOuBeyZLs/qkOgfbuSeOo/3K3FQmJdnFstN
         xreGtK5GJYlCQ67lNgK6kEYH3v10zJUw22wJ2nBcDmGk8pE2p2+J3uSnFPb4jY1Zji
         rZG4AF/1M8doIFKFHx3lOdJMBuPIDZc9FChSkBkhViSiatyVpd7qKbRT8/nHUOS8SI
         Hhl/exXsjmEp0VNIc2pekKCYnDJCnzWxvcEaKdz86Kapej9O7CwcnRQlaiAnYveX9W
         SaYzQk0LSKFfK+L5R6yv86mSNISSXSnyw+LMJZQCbKhS7kO4H/28Ww0FjBWNdu9I3O
         0555s8Q5pEdpw==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20231017203537.2700340-1-robh@kernel.org>
References: <20231017203537.2700340-1-robh@kernel.org>
Subject: Re: (subset) [RESEND PATCH] mfd: motorola-cpcap: Drop unnecessary
 of_match_device() call
Message-Id: <169771882804.2475901.13260855763824624939.b4-ty@kernel.org>
Date:   Thu, 19 Oct 2023 13:33:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 15:35:36 -0500, Rob Herring wrote:
> If probe is reached, we've already matched the device and in the case of
> DT matching, the struct device_node pointer will be set. Therefore, there
> is no need to call of_match_device() in probe.
> 
> 

Applied, thanks!

[1/1] mfd: motorola-cpcap: Drop unnecessary of_match_device() call
      commit: de083f0eb4fe7f1f1d6cc0bad676a5adc38be8d5

--
Lee Jones [李琼斯]

