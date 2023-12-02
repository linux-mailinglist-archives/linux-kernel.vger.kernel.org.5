Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337A7801A8A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 05:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjLBEO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 23:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBEO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 23:14:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8692126
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 20:14:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A11C433C7;
        Sat,  2 Dec 2023 04:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701490474;
        bh=fPGmDPaKjV8LMrfSaKKD2/2w8V2jbH3SmiSiLi26M04=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E0Tmj6hrHp7t06Sqv+Y/4N2r4YHquEOmxHUYx+fUaHchKjih0iSlHONwecakzJUl2
         IO66H2+Aji9o3rfqvoZhV3kElMddcjImiNFoYvuY9cfkLktIKP0DUepvGZm6f9Thkk
         IGsCK+uOOAAg+EThqHv9tbE6RsHzlxh1cAnhVE9ZWIQ8d5FTrDblVpHZ1DrgPrRQxj
         /Y7L+j61ZSeeVyHwWRf905+uqnagePbcRjjEFIg8UrIKc2CnU8Y7jbbBqZmY9ACZx9
         BYoO65fc7x0qpPxttpF02xq24cZNlwRH5rTD+LTpN1tL8MvidzlrAWKgARgi1XfR8L
         g7YsDM7q2yd2Q==
Date:   Fri, 1 Dec 2023 20:14:32 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     <hkallweit1@gmail.com>
Cc:     ChunHao Lin <hau@realtek.com>, <nic_swsd@realtek.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grundler@chromium.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v2] r8169: fix rtl8125b PAUSE frames blasting when
 suspended
Message-ID: <20231201201432.20d40150@kernel.org>
In-Reply-To: <20231129155350.5843-1-hau@realtek.com>
References: <20231129155350.5843-1-hau@realtek.com>
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

On Wed, 29 Nov 2023 23:53:50 +0800 ChunHao Lin wrote:
> When FIFO reaches near full state, device will issue pause frame.
> If pause slot is enabled(set to 1), in this time, device will issue
> pause frame only once. But if pause slot is disabled(set to 0), device
> will keep sending pause frames until FIFO reaches near empty state.

Heiner, looks good?
-- 
pw-bot: needs-ack
