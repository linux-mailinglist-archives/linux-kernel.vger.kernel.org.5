Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A8F80E2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345852AbjLLDVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjLLDVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:21:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A2ABA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:21:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C09BC433C8;
        Tue, 12 Dec 2023 03:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702351284;
        bh=wRPseFsynabFF6ox9cUgnxmV7l2w8DducyuqPfkFGTo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hWSo+D3sNzmsjgH0dbI8NyBUQ3biddHYlnS5fa1RbEQJtV3fl42MNBgUvaqgHp9oo
         QmYoultXA22eYUunYcfYlZiEKjza0Q7XnhvqVU7jEJONnFl5ssOgpRp1o6O3dXCFbR
         qlYZmXNF1PPVVWOIBMdStUbf6E3gNytZ1Nq/UDAFW7Yy7sFrBgy/4mhyS6aQRXhWGX
         35eGZHhtYUF46f6u+Z4WfCNkorphg5gfkcyTQOBICnCNXxd0Dk4cb2IR6JrM5AKAtR
         kxV5o6M3EKWtGx4EzcRKQZsNfVy+YFZLdg63YP9VmGxFKZHvDgM1NMaYO7YNuXrRK9
         owmsbHG8rIp7g==
Date:   Mon, 11 Dec 2023 19:21:22 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next 5/6] net: hns3: Add support for some CMIS
 transceiver modules
Message-ID: <20231211192122.14da98f0@kernel.org>
In-Reply-To: <20231211020816.69434-6-shaojijie@huawei.com>
References: <20231211020816.69434-1-shaojijie@huawei.com>
        <20231211020816.69434-6-shaojijie@huawei.com>
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

On Mon, 11 Dec 2023 10:08:15 +0800 Jijie Shao wrote:
> Add two more SFF-8024 Identifier Values that according to the standard
> support the Common Management Interface Specification (CMIS) memory map
> so the hns3 driver will be able to dump, parse and print their EEPROM
> contents.This two SFF-8024 Identifier Values are SFF8024_ID_QSFP_DD (0x18)
> and SFF8024_ID_QSFP_PLUS_CMIS (0x1E).

Hm, you don't implement the ethtool get_module_eeprom_by_page op?
I thought for QSFP DD page support was basically required.
