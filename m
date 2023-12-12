Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D34680E9A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjLLLJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjLLLJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:09:15 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6E9A0;
        Tue, 12 Dec 2023 03:09:21 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SqG8R64l7zWjbg;
        Tue, 12 Dec 2023 19:09:11 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
        by mail.maildlp.com (Postfix) with ESMTPS id 75C451800D0;
        Tue, 12 Dec 2023 19:09:19 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 19:09:18 +0800
Message-ID: <c2d1a759-7cab-410b-ad9a-71ef3031ba2c@huawei.com>
Date:   Tue, 12 Dec 2023 19:09:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>,
        <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next 5/6] net: hns3: Add support for some CMIS
 transceiver modules
To:     Jakub Kicinski <kuba@kernel.org>
References: <20231211020816.69434-1-shaojijie@huawei.com>
 <20231211020816.69434-6-shaojijie@huawei.com>
 <20231211192122.14da98f0@kernel.org>
From:   Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20231211192122.14da98f0@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.192]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 2023/12/12 11:21, Jakub Kicinski wrote:
> On Mon, 11 Dec 2023 10:08:15 +0800 Jijie Shao wrote:
>> Add two more SFF-8024 Identifier Values that according to the standard
>> support the Common Management Interface Specification (CMIS) memory map
>> so the hns3 driver will be able to dump, parse and print their EEPROM
>> contents.This two SFF-8024 Identifier Values are SFF8024_ID_QSFP_DD (0x18)
>> and SFF8024_ID_QSFP_PLUS_CMIS (0x1E).
> Hm, you don't implement the ethtool get_module_eeprom_by_page op?
> I thought for QSFP DD page support was basically required.

Yeah, the ethtool op was ignored. And it will be added in v2.

