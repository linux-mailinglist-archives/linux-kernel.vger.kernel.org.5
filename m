Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7805180F94F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377248AbjLLV0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377764AbjLLV0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:26:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30E5B3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:26:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA31C433C8;
        Tue, 12 Dec 2023 21:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702416398;
        bh=7MZqk1hNPj7r4egGXbPOB+Rztv8D/+/C7L1c9OmJaNM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=flRSOrwLQ6Kc4Jr7ORRXvJ9GkwBbbqmpb4qM7hK2Pq5Mo+ix+PgPwknWPbsyLrJk5
         ATqdQHydWfdFqN7c1//tDtxjet1++b4i1v5AH8a+DDpq4uEldVokQHHzyzTEu4snaE
         PHEte5nKs1RG9Td3XkE5pZDvwXd0Al1n19rkQeezl55Mbx636qHNcj2XAigiLYP5I1
         8nZMz9R8VtlS6dMY91F5MT1dyZv+mBHsFOeajqHZy8Z6jSX/NyTnzzkn1GuOQEALCY
         ujUJz7wtIS2l3TqBZ3cA72Q3XKBddfCGVKWrrvtxdIiQR7WlXf2k+1Tju5sYYLA2Mm
         J5FjKLntIkB8w==
Date:   Tue, 12 Dec 2023 13:26:37 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kunwu Chan <kunwu.chan@hotmail.com>
Subject: Re: [PATCH] igb: Add null pointer check to igb_set_fw_version
Message-ID: <20231212132637.1b0fb8aa@kernel.org>
In-Reply-To: <20231211031336.235634-1-chentao@kylinos.cn>
References: <20231211031336.235634-1-chentao@kylinos.cn>
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

On Mon, 11 Dec 2023 11:13:36 +0800 Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> Fixes: 1978d3ead82c ("intel: fix string truncation warnings")
> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

The allocation is rather pointless here.
Can you convert this code to use snprintf() instead?
-- 
pw-bot: cr
