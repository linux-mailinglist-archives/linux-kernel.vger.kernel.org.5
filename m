Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D407E9E84
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjKMOXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKMOXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:23:49 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA5ED56;
        Mon, 13 Nov 2023 06:23:45 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Fb+OQaFguJSO0NOEC1S/0T6IQIHw4lE1f0fU2Ab9fcPenPGAkyToSVurb1r1vdtuwFM55Lh+N7RolkscZXE7rSyl822+BNNkl5VUioaEHC71nk6GEZAO9zGgQLW8BQX+uKwMklMTsDLiIjMTbUip2fo+Y70Y8DxHAVITkbfuisR8f7mcq0lT7790FYPq/oiCi9YYuUgpaKbYbyxrgMpuCGyeGBLnG8iAcpF+oBIO+crfV/gZomGwRwym7hSKOX07JUbADos2m59y/AXA17+Z8+/Iv8P25DXBSh6hitMISFgL4IQxnRTVcg2mLxPAYyQzT4XSHHSc090os9PvYOcdLQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAC+4mqMoyD/1lsW1E3PoF/J3eBPvwsPuvwuZk2B224=;
 b=ln9a3n3C76uJRQTQV1FijGfQ81oZ3liG39P7xZ1gvtXFAq9OZA75jurIPDsWTm3F9No1iSzwdYwVPad5sZOEvDsMNVimgcDbhSB4QQECNWLn4dIP37j5o2b93A7SYhJU8X/mORru4WRKeDAjIZeSFDfKcxylTsgDmTNripTsqHVE7ZHspsDs5d1r77JkzFFxsfKtMXkXvUMyRulO9qo0M2iaD1sB10Nzr9KgvxXLLzeXOvpcy8I0shrju4vPJ+8dNFtgxzEvbkcf3of7fUIYS7DnKN9kgBR9gJY84AAekWId/f5vXkZhcb1mga1PDYDHWqFVnFm11sQaORgMcOp+BQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAC+4mqMoyD/1lsW1E3PoF/J3eBPvwsPuvwuZk2B224=;
 b=NifXr8hL1km8vKBqrtGOZR0Fy0iu7BTmJhwwkXGKHDQiPkP0g834xGsy2zBLHeB2rTqxo0ndNsQPGMWvF2Rm9Q4JjTY4phFilMbE2dcxdhixsLMgT1IuTCr5Duan5Tdu/AY/aOlCrI3albMJ2wgfdxwoI1lce4K4a3hLYilNOaU=
Received: from DU2P250CA0015.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::20)
 by DB9PR08MB6412.eurprd08.prod.outlook.com (2603:10a6:10:23d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 14:23:41 +0000
Received: from DB1PEPF00039232.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::44) by DU2P250CA0015.outlook.office365.com
 (2603:10a6:10:231::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29 via Frontend
 Transport; Mon, 13 Nov 2023 14:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF00039232.mail.protection.outlook.com (10.167.8.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.14 via Frontend Transport; Mon, 13 Nov 2023 14:23:41 +0000
Received: ("Tessian outbound 385ad2f98d71:v228"); Mon, 13 Nov 2023 14:23:41 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e9d3cb4e904d92e2
X-CR-MTA-TID: 64aa7808
Received: from da110d6931d4.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AFE53200-70BC-4B8A-8630-E5DCE8D58C98.1;
        Mon, 13 Nov 2023 14:23:31 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id da110d6931d4.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 13 Nov 2023 14:23:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ascbqY5sstLvFeqC2oOKxqphg1JWiZKwnMLAlk4nLNIqbeIY5wEDJDzh6tazem/D2jyp3yBJjsKpc5J3F66f4Q2R3ElEljc5au3JcfqUDNbXeBPy0A7hz6K1/c05zcQUc6WbDcf6XLnYTHqn5O0DnyZGChVFjllhQgpbE47XotTK04gFtxai6+BxiiQq2wUPqvH1CIS1Affn2xgUPrVaVJhk5WO1Mt5FkhU1RgQPqwL2DAjQaZDAHNcmxTIWQrCCHXCxaTm5WrAnMTqZzWOMd9GXYZ6E8p4HtSgxZX2eFKTkXzl12uVmz+XqcgjyckZ51XzmrYw/ttfQx0NNowCgZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAC+4mqMoyD/1lsW1E3PoF/J3eBPvwsPuvwuZk2B224=;
 b=HL0jm5X4JFgfEJkIp3DmqM8mdnFb1MDyRPnMiviHF951pVUjQ4CfOv0IR9bllglWdoH/agnHQuYyPpdwDTEUcR0O73ozhNU0jAVVz1aS3wI6iPMJBn++/zzWTiYQetf9ZX++AS4er1/5wM5N4g0YtynbiSJARmGFMR2O9U37aPmkHEF8bt9rxQsZ978wbZYCna6IL2ww6FoHwukKr1GrWc/FeH/Wcpn4iR7Qhv2xc0vrAG2jLnzc4HgpcV5IAVIhN8sLgzxtSwXSvCMlZ3stwJYR4jma9gJu58aqa2n1JdeKFUow7aZmQjcJvnpnZ0j8j7mD1mqrJIfyE/Yg3k9jqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAC+4mqMoyD/1lsW1E3PoF/J3eBPvwsPuvwuZk2B224=;
 b=NifXr8hL1km8vKBqrtGOZR0Fy0iu7BTmJhwwkXGKHDQiPkP0g834xGsy2zBLHeB2rTqxo0ndNsQPGMWvF2Rm9Q4JjTY4phFilMbE2dcxdhixsLMgT1IuTCr5Duan5Tdu/AY/aOlCrI3albMJ2wgfdxwoI1lce4K4a3hLYilNOaU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU0PR08MB9656.eurprd08.prod.outlook.com (2603:10a6:10:446::7)
 by AS1PR08MB7587.eurprd08.prod.outlook.com (2603:10a6:20b:473::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 14:23:26 +0000
Received: from DU0PR08MB9656.eurprd08.prod.outlook.com
 ([fe80::abc6:b931:ed3a:1901]) by DU0PR08MB9656.eurprd08.prod.outlook.com
 ([fe80::abc6:b931:ed3a:1901%6]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 14:23:25 +0000
Message-ID: <604aee95-ad46-4102-80aa-71c2c9d1729c@arm.com>
Date:   Mon, 13 Nov 2023 14:23:23 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 5/5] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
Content-Language: en-GB
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <cover.1698353854.git.oleksii_moisieiev@epam.com>
 <e9285b4377242e4d888391be987cbb99caf8c573.1698353854.git.oleksii_moisieiev@epam.com>
 <CACRpkdYW-xmejyOo9H9XSkcabvYgBqPvpjppvNe_RF6RLxyxKA@mail.gmail.com>
 <ZU2AP7leDcIZIN+b@octopus> <ZU5LFC23JaEidEGZ@pluto>
 <2535571d-6fea-4064-8325-0f47d031c85f@arm.com>
 <CACRpkdaRY+rU+md-r5gVyFH5ATt3Pqp9=M4=+WArYkfVLAFdpw@mail.gmail.com>
From:   Souvik Chakravarty <souvik.chakravarty@arm.com>
In-Reply-To: <CACRpkdaRY+rU+md-r5gVyFH5ATt3Pqp9=M4=+WArYkfVLAFdpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0009.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::17) To DU0PR08MB9656.eurprd08.prod.outlook.com
 (2603:10a6:10:446::7)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DU0PR08MB9656:EE_|AS1PR08MB7587:EE_|DB1PEPF00039232:EE_|DB9PR08MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c88c70a-fb4f-413d-90c6-08dbe45422f0
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: DU7o82mj0ajTlTHo6qHGNqAoG/oyVluiLbtuHrnQQoCj55vPRmfRq1nUzKh7wuOrfLkvbsVS944yXeMHPFj6u4npCaaOZv8xvBlUewkYg5yeCYwZ2Woe+BWFwTvb5rHNhcYIdb4VU73j28LRsSasiRUNIqGkKobMPo6zdnVwWYIS32d+kll0a/gU65hCwDmocqqqX1SoPGZAyATdvaWlN62MO4GUl5W6nGf55P7IcChZUFpnCdSSUtyHecYfB5yMH70HwhxK65RavUyu31RyuDziH8/XjyM/4nh5WWgcmXRVEVzY0oQ1Y73tdKMJgir1nJooYHEDzCme3gvjfF0tWgZTULIFVYci1r7l+AbTtvqshjCaSIVgTB732UveH5zyEVtbO6lapklbzR+7ycn4YohhnbP1ov9JueUv/QG0o+hVMOWWD7N+qhkngWA//ZAzSFPTD6ywaio4hqynHZUEmtR7/qAplpLLzpzN5VL0GJXJlVgF5gKS6RLJTseOflDHbAXJ/IeB2LQdEu+Ac075A+3aWuOyz/sxOalA8wlyP7e1A+vaHHDhSExs8Su/baPK+0a43NYu2yGFxMbfOAGo1uNJNd1OKa6SjOXFU6roWkQmVrfFiIboVnXh8YG5w+GRzAcB3hbEGr/YFfML6zVjvg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(346002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(26005)(6506007)(53546011)(2616005)(6512007)(83380400001)(44832011)(5660300002)(4326008)(8936002)(8676002)(2906002)(7416002)(41300700001)(6486002)(478600001)(316002)(6916009)(54906003)(66476007)(66946007)(66556008)(36756003)(31696002)(86362001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7587
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 44befadd-0483-4457-8c50-08dbe454193d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sU1vcCCwXSZRTgSKzA6uOtwobjuNbKCsNK3XN3BV6RVdUHyUGddZtf66cmSJMkRjwFNeSlahcPNlg/cY8GMKK3JHgBmICburTRQS8DB8/81dHHHCNX6Bw2l28DHAdghADJqPdBWnHlxhmmyDAh9bnyoqNjrF5gQy00hfSzGjabYDQfqj4iaqR/Yaanqsi0/Lh9RjcXYOZRw6U5F2v8bnsQqLsbeIV0n107dZrWZCaP64sYNzp0i0B/Ixh14GPI+E0Bz4HdBtCPfcGc5t21OktHGV3sTZtESvpm7QSEtc87rLyfQhhhiqTWxm4t56DvzcF9ktxFQbvB6hVJ+V2KrAR3ehmonNBx43/pxTVUcqbhA4iP5a9OyCJEX36SkBya3uraOyp6zC6SIZuWDF0npvK8NLFhzCp1AnTBOeqKo5vAFcM4gyUd1rT6MrNuaIQd17rSCQEG78R9IR0j9wXZCD2NZCr+rDbymxsH52CN28Fz+ZWaJflkyxDn9LCeE9/3dpLVFOJq5CmviG69wMgvsD+Yz7VMPAIn3krnH96AM0YZUgmjaPjBn2fmWAQHK9SZ34CRVrugLel03zBALDDd1WQ88mLsqhTpvwdz381AXgeMW2JuZ3KpwD6XxkvcH3PGgk7p+9lM88j3w838SU/tEdTyXZ/EZRPL3b4VJEzBKcJbRoCzczUBXEwswS/dIaA1pv/G/xRT+dLUXHb3Hnt/klrpXwg/IvuqnQEVFUJKYbhlOF0dipfuFehBUdn9QfcH3uE6DPNb0axlGG88JVMpoIHQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(356005)(81166007)(6862004)(8936002)(450100002)(8676002)(4326008)(5660300002)(82740400003)(44832011)(83380400001)(41300700001)(31696002)(86362001)(6486002)(478600001)(6506007)(53546011)(36860700001)(36756003)(336012)(26005)(31686004)(47076005)(6512007)(2616005)(316002)(40480700001)(70586007)(70206006)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 14:23:41.7633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c88c70a-fb4f-413d-90c6-08dbe45422f0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6412
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 13/11/2023 13:32, Linus Walleij wrote:
> Hi Souvik,
> 
> thanks for looking into this!
> 
> On Mon, Nov 13, 2023 at 1:56 PM Souvik Chakravarty
> <souvik.chakravarty@arm.com> wrote:
> 
>> The initial assumption always was that GPIOs can be considered as a
>> specific function. Note that the spec does not define the types of
>> function and leaves it to the DT binding (or driver) to figure out the
>> function descriptions/names.
> 
> Does this mean that each system using pinctrl-SCMI will need
> to specify the available pins, groups and functions in a device tree
> binding? For e.g. DT validation using schema?

Sorry seems I made a typo above ("descriptions/names" should have been 
"description from names") which resulted in turning things on its head.

I really meant that the driver has to figure out the exact type or 
meaning of what the function does from its name. SCMI still continues to 
provide the list of pins/groups/functions and their names.

Regards,
Souvik

> 
> This creates the problem of where to put it since
> Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> is all we have, and for schemas to be applicable the implicit
> assumption is that this is done per-compatible.
> 
> If we want to use device tree validation of the strings put into
> the pinctrl node we need to allow for a per-soc compatible
> under the pinctrl node like:
> 
> protocol@19 {
>      compatible = "vendor,soc-scmi-pinctrl";
> (...)
> 
> Then a DT schema can be made to match that and check it.
> 
> I'm uncertain about that because the SCMI binding has nothing
> like this at the moment, all the protocol nodes are pretty
> self-describing and don't seem to need any further configuration
> to be used, but pin control may be the first instance where we
> have to add some per-soc configuration into the protocol nodes :/
> 
> It's easy to do:
> 
> +  protocol@19:
> +    type: object
> +    allOf:
> +      - $ref: "#/$defs/protocol-node"
> +      - $ref: "../pinctrl/pinctrl.yaml"
> +    unevaluatedProperties: false
> +
> +    properties:
> 
>          compatible:
>              items:
>                - enum:
>                     - vendor1,soc1-scmi-pinctrl
>                     - vendor2,soc2-scmi-pinctrl
>                     - vendor3,soc3-scmi-pinctrl
> 
> This should be enough for just establishing the different
> pin control configurations we can have in the device tree.
> 
> We are then able to put a more detailed schema for the
> specific SoC pin control, such as a list of valid groups and
> functions etc under the ordinary pinctrl bindings such as
> Documentation/devicetree/bindings/pinctrl/vendor1,soc1-scmi-pinctrl.yaml
> etc.
> 
> We should preferably put some pattern like this in place from
> day 1 so developers know what is expected here. A mock
> SoC is fine for the time being (we can delete it later when there
> are some serious ones).
> 
> I'm uncertain because it feels like a first thing, but I can't really
> think how it would work otherwise, part of me don't want to
> pollute the SCMI binding with any per-soc compatibles, but
> yet since these group and function strings will be per-soc I don't
> see any other way, if they are supposed to be validated
> with schema.
> 
> Yours,
> Linus Walleij
