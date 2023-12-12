Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E83E80F95B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377419AbjLLV2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377406AbjLLV2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:28:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF83AB3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:28:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDA9C433C7;
        Tue, 12 Dec 2023 21:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702416532;
        bh=7g23NbUaG9IocrYKtfcJQkcARBOL/6cB9B3IBOO179w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RcEo5PtV4dcAiaQiaiYd9nV1ggHqQ2IfUnP05wzeW+Exw/eoKMP0vUwUlK+ubJvFm
         D7kgFLDhvfVL3xvjQzuFVEDI5tENiXmEq6M1OxK74Y+wAh/DOuK4XPs9a0VpSGAIUD
         i5IF/Az+XIJYBNC9C468l2agnMAnC8MrxjHg0h6riZL/zzzKFtO58KCnhPa1M+FkWm
         O72fM02HcAHtEEmUIzDrYIiFJzKVwvVmc5xd9E0gmajxplF6jVUAlHY9I2GmfQkAZ1
         yGOsAKJjb/MtAJNIkGIpIb7pPD+2DwJXDOTrr3EE6r4MxjJ8C9BI/YIT8t5zkNRkRQ
         8/rovDm3IMRZw==
Date:   Tue, 12 Dec 2023 13:28:51 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kunwu Chan <kunwu.chan@hotmail.com>
Subject: Re: [PATCH] iavf: Fix null pointer dereference in
 iavf_print_link_message
Message-ID: <20231212132851.59054654@kernel.org>
In-Reply-To: <20231211025927.233449-1-chentao@kylinos.cn>
References: <20231211025927.233449-1-chentao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 10:59:27 +0800 Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> Fixes: 1978d3ead82c ("intel: fix string truncation warnings")

No need for the allocation here, print to a buffer on the stack.
-- 
pw-bot: cr
