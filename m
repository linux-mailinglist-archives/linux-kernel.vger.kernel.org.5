Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CC77E8453
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346215AbjKJUiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbjKJUhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:37:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4B4185
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 12:37:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE25C433C9;
        Fri, 10 Nov 2023 20:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699648654;
        bh=Gstp9yb61OjsTuHdpm83SN/hPjjO5FW+SEuM0791eZQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y4fy5nMj8Rzgkjiieh+wEpbAA1v5K1FVdZlRte9lQ1mT4VjhzMMbLlmWYv81gVTGT
         WW/uGbm+GBjrUquEJlpe7dhFBUbokGw5g8M/yuSmqNFMN9Pk48ebCh6dfOWBTR3bk+
         cO1Db4pKQd9QbO7Ou0ubLc7NucXVupnKg/0yAvpn1Z3SY+AKOMNoDrJWMNAHDi+/rt
         faIrmStpuLTXooDGsBL9hDanXwi+QVJlPGn8/decvcwUydszl7QOIZHAg3w7H52pt1
         6kQpTwc1PNRlRwPGmHH/W9CRc/aAoOV31KiomD3olDvSokRtW5WWcZGByFU2l7r05K
         vAucJEIphC33g==
Date:   Fri, 10 Nov 2023 12:37:33 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     <alexey.pakhunov@spacex.com>
Cc:     <mchan@broadcom.com>, <vincent.wong2@spacex.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <siva.kallam@broadcom.com>, <prashant@broadcom.com>
Subject: Re: [PATCH v2 1/2] tg3: Move the [rt]x_dropped counters to tg3_napi
Message-ID: <20231110123733.42f31ddb@kernel.org>
In-Reply-To: <20231110002340.3612515-1-alexey.pakhunov@spacex.com>
References: <20231110002340.3612515-1-alexey.pakhunov@spacex.com>
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

On Thu, 9 Nov 2023 16:23:39 -0800 alexey.pakhunov@spacex.com wrote:
> +		for (i = 0; i < TG3_IRQ_MAX_VECS; ++i)
> +		{

checkpatch says:

ERROR: that open brace { should be on the previous line 
-- 
pw-bot: cr
