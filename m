Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F337A73EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjITHX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbjITHXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:23:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4F8D8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:23:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A44EC433C8;
        Wed, 20 Sep 2023 07:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695194627;
        bh=Fr3JD9GG9Pv2NhbFBRrIecMlB8b/cJd3MubePCRDoBI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ryGeX7ybQANwCRQBuGONr8oqGV/MlwcqmdsvDiBCp1EA3XCldLTifNAk6E9xuHhd0
         XLQSc+8R4cV4UYfjlWw5K5qs4+lBxQtP1xXX8HTJV9tA1RwzNK5j1kjvnviV9glm3o
         2bFlIkiuHTM8nDUIfvwVxSToXqIvEr+3Y+vQ0xBmBnl5CP0UGuXOkGW2LbUX1NDsJ/
         4gpYh4aPITARMMwak1NiZd74A80fNTOoP/ZP1npKmqtzuaSrb98v8KQHb0f224WWj9
         LF2cwkbtb0kOGYFJrGw3HcqKGc8Px2TAy10aAy2S8OAWT90QRgUOw8zW8DWYkbKkSz
         x3eqE3NsxQ8TA==
Message-ID: <f25b7cd6-90e9-1d81-d135-38bb3df408c5@kernel.org>
Date:   Wed, 20 Sep 2023 10:23:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] usb: cdns3: Modify the return value of cdns_set_active ()
 to void when CONFIG_PM_SLEEP is disabled
Content-Language: en-US
To:     Xiaolei Wang <xiaolei.wang@windriver.com>, peter.chen@kernel.org,
        pawell@cadence.com, gregkh@linuxfoundation.org, pavel@denx.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230912064946.1405848-1-xiaolei.wang@windriver.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230912064946.1405848-1-xiaolei.wang@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/09/2023 09:49, Xiaolei Wang wrote:
> The return type of cdns_set_active () is inconsistent
> depending on whether CONFIG_PM_SLEEP is enabled, so the
> return value is modified to void type.
> 
> Reported-by: Pavel Machek <pavel@denx.de>
> Closes: https://lore.kernel.org/all/ZP7lIKUzD68XA91j@duo.ucw.cz/
> Fixes: 2319b9c87fe2 ("usb: cdns3: Put the cdns set active part outside the spin lock")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---

Reviewed-by: Roger Quadros <rogerq@kernel.org>
