Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1875C7BA5F8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242994AbjJEQWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241327AbjJEQQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:16:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE222A4292
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:24:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC80C43391;
        Thu,  5 Oct 2023 14:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696515845;
        bh=FGuHU46Lr0jpYh1Ku2bBcUUkixhkfj8A97mOmqhLY9w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eWBrYILR5Rxm/aZmNMhNTfzK/arOSg0g7uUmQewyzH8/KQD5440TohNLi6YJuf04p
         hKxRS00DhzINa0WAPlEbs9ZJ+nOclUO/N/2icyew+WDO40FEj5McWKRv52QpBbmCyz
         Se9yCumv7J4M8tMFIJJWST+brCocBob76e4QeDReUgvnES2/mTb3wvjK6FkvHnRfKG
         4nSCJvlvf/940W82imytwM4wfG6OGe0wwgLEFJVVwwvrQQS0A3PliAY3HAaOMhp9Xw
         3rK2YcpHxZPsIMbNppRzZsB/8yH05xrwBAXqSw/10Szoyufyeo7FM6tDyQLRRrKdQK
         dhHRB+5LAv+AQ==
Date:   Thu, 5 Oct 2023 07:24:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Robert Marko <robimarko@gmail.com>, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: phy: aquantia: add firmware load
 support
Message-ID: <20231005072404.783b00f9@kernel.org>
In-Reply-To: <56227e76-f01f-4b90-b325-1cd9ecb8d5a3@lunn.ch>
References: <20230930104008.234831-1-robimarko@gmail.com>
        <20231004162831.0cf1f6a8@kernel.org>
        <56227e76-f01f-4b90-b325-1cd9ecb8d5a3@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2023 04:43:51 +0200 Andrew Lunn wrote:
> The Aquantia PHY and its `firmware` is just weird. It is more than
> just firmware, it also contains what i think they call provisioning.
> That is basically the reset defaults for registers. And not everything
> is documented, and i think parts of that provision contains SERDES eye
> configuration. So i think you end up with a custom firmware per board?

Ah, that makes sense, thanks for explaining.
