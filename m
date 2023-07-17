Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54A1755B6D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjGQGXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjGQGXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:23:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF71211C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:23:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 673CF60F36
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF82DC433C7;
        Mon, 17 Jul 2023 06:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689575025;
        bh=nBThRVZ4Oky8fa1QW1VgwmNUavOj/4ZPF5yh4TAUhuI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=O5OOkwfzWWtIBTdhwEPjapd6eDcgqOJj67AtlmVTorNdb3tRtfNLXeb0jkdixdxHw
         2QhFP0WjpX3B5xi8z1DlH+jzf/I5Irujwn/LCMlaiaFiMjxWl46wx27+/oRWK5rIdD
         TLRxygISdzaJAbGuB3ahar8D45H17DSfUqyNAe2TtvC5DnUwCzQfDhIhI02IV6QbK3
         BzzeIvXYqe9whz3cNV/Fp5IJCTsQbDs3QqMYZp70qwycFENPxZRaQlRJnfh3e1Si3L
         oumzwfh38Qh69ADXsYvJNhEy5f89UDVeFhRTjZteZxJQckG4iFGRdE2jk/Cm0vbGvj
         gwL4ASVZtOvOA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Roger Quadros <rogerq@kernel.org>, Andrew Davis <afd@ti.com>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230713200957.134480-1-afd@ti.com>
References: <20230713200957.134480-1-afd@ti.com>
Subject: Re: [PATCH v2] phy: ti: gmii-sel: Allow parent to not be syscon
 node
Message-Id: <168957502328.294691.10049399572182946150.b4-ty@kernel.org>
Date:   Mon, 17 Jul 2023 11:53:43 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Jul 2023 15:09:57 -0500, Andrew Davis wrote:
> If the parent node is not a syscon type, then fallback and check
> if we can get a regmap from our own node. This no longer forces
> us to make the parent of this node a syscon node when that might
> not be appropriate.
> 
> 

Applied, thanks!

[1/1] phy: ti: gmii-sel: Allow parent to not be syscon node
      commit: 1fdfa7cccd35519d97a1f301b8143ea4196b2d16

Best regards,
-- 
~Vinod


