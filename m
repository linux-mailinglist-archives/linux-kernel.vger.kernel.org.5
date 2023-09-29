Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705F07B2C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 08:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjI2GHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 02:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjI2GHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 02:07:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0010792;
        Thu, 28 Sep 2023 23:07:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R21youP2PHdLytZfpUWx+iSEh1QSnXLyBLAWkNH9hU0DU38TOu+qAwS6iMMs2skwfB2pei2bK99nddIzoG27UQjrpsj9R+suhhKVz2Z4xVfTa9EP6wn+j8/4pritU0mSNSZJtW/nDTAGl6ttSP4REdwh5KDtZDmCX7QOxSgNEux9eYd4Z5K+aSFOiBWxIDlHohRFxXzQwazZspIOAs5hcw1Z4KSCnmAJ/svgQ7FrwjVzKnCXPsNQdS6KO3Vo6wI7S0dUZ/nkxAdX+q89sghE0LbVb2pXerxnTC6wBpgCIPL8CCJ+IaEznDHyUaujUcbBZYT82fbiSg1jlDvAFzhh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/TpMJkn/Mc1GziBGiMMFboHA4q7xTbWP4Kdu5dibM8=;
 b=CuDKNEWQcerWtzt375dVa8urMMA1Sb944jbRinix1M0LxybAZMQw/XqIyFgO9nbV/molhLBrW+kkNVI7YBz4EPsviHdautGQoCs67r57cpZoOtJ1mTBh0ZiXet2xQCJU4avC6OnZdkSvnMwHNJtjYU1f7/v1hiPaBMa+Qar8GaemlzCvGXvKfgEzuV2Se00vyaaYZWE933s0tCKq50u15hFJVom4myA/fQcwQhr7bgKDxKA9MZMBLcE4hRuism+gTB8+3Zl2eXh4/kYjl1kUjI9qG+D8AjRj/A5P4TG4rJyRgn/ovf5kBtCNMPmwI0isP/uhWOoBynnjU4M7LTPM/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=geanix.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/TpMJkn/Mc1GziBGiMMFboHA4q7xTbWP4Kdu5dibM8=;
 b=VQTZfCVqJATXg2i/2a/O6YMfFWWhqETM4c0kEwcrEBXelR6wRZDTFPJcipcJwnBWiyzlSl2HMe0XADtEEW0qG8EmgLQoz+1FuBAZZh1uh8R8znsgZTFC7wHZnz9f9F/SpSNObFDQZin2j8HRARfkG3Lrppi35Q6QdDQt+C3ben4=
Received: from MW4PR03CA0215.namprd03.prod.outlook.com (2603:10b6:303:b9::10)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 29 Sep
 2023 06:06:55 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::a6) by MW4PR03CA0215.outlook.office365.com
 (2603:10b6:303:b9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26 via Frontend
 Transport; Fri, 29 Sep 2023 06:06:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 06:06:54 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 01:06:48 -0500
Message-ID: <4b8361e5-08f8-4cf8-a277-769647fb9c4c@amd.com>
Date:   Fri, 29 Sep 2023 08:06:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] MAINTAINERS: Add an obsolete entry for LL TEMAC
 driver
Content-Language: en-US
To:     <esben@geanix.com>, Harini Katakam <harini.katakam@amd.com>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
        <pabeni@redhat.com>, <jsc@umbraculum.org>,
        <christophe.jaillet@wanadoo.fr>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <harinikatakamlinux@gmail.com>,
        <radhey.shyam.pandey@amd.com>
References: <20230920115047.31345-1-harini.katakam@amd.com>
 <878r8qxsnf.fsf@geanix.com>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <878r8qxsnf.fsf@geanix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: e97de3e8-39c2-49ca-3c07-08dbc0b24800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QqaSNAAqBoUHddyrut2UJJW5e0TOQmQMry1RO9PogXNPxXtVoNnTY8V0T6gq9Tsx9nIXWDoHbOba41Y/ReN43w7OVvI4HWH3Gio5BHI4J8SGBOmL46YiSwEGyuQiPJF8xAywIOemQNLOh/jKS1o+iPT8vfBhYdrX5wVc19xtz5nELZQxn36qE3hQNg9iuvl0yoxTm5ehBLeVkYZMWUczt0milnwEpI1pfuU3zvpef9J8/e3QMchOYLvuqV/f9H1mJVx5CZ3/Zw2YAO5XTfKmoHMysF4oANdrEYZ1hBo0RC8qLIpG0qyE3fO6+D6iYdZDUvDZQnZZtSguxQzP4ggfMAJGZ+MExg31ZvHEsub1u9stdNfjVSegh+rDs3kwKeopYWA2pp6n3e8u+6RN8W4aW9XVo1Hb+fwHhhUXQvNVZXJhwQjkxwtmfboFqafkhIBLLh8bzRZNi1/kXcmvs0nhiWAjoIFPtu6XqdFAEhBLKW856ubJdel5zTCQNHyE575JdLjsskPviCYmUGNts9HYLU2S4LQ/t9eu4gnOxoMUaZoATlT7CFUHx6Q44Jv/xW2ZKsRN6fqAdNrutiWmjtUJSKkwKGkuN7FdBJKdbWHxgEc1gJgwqnI+fByINRK/FOL3XTRdomQv0AfgwbtSL4sB9IGAIch2FOLc6ZBf1SFBzv8PYpu+mozxCJ4AFiU3OjBCrm8TJObj4j7nrf81xmQkBSeeoFYpi6jQe2tJVgvefpzkX8l5A3+3gG6x+p5evk/KgcyJQsBNTTUAimhcUJtDuEl8laxZZ0yzP6FTNcBKV0CK+70HqsP1p/0KIv/qDdIe
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(478600001)(70586007)(36860700001)(41300700001)(47076005)(81166007)(82740400003)(53546011)(316002)(336012)(40480700001)(356005)(16526019)(6636002)(16576012)(426003)(2616005)(70206006)(110136005)(26005)(8936002)(44832011)(8676002)(5660300002)(4326008)(54906003)(31696002)(2906002)(4744005)(7416002)(83380400001)(31686004)(86362001)(36756003)(40460700003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 06:06:54.6181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e97de3e8-39c2-49ca-3c07-08dbc0b24800
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/23 16:46, esben@geanix.com wrote:
> Harini Katakam <harini.katakam@amd.com> writes:
> 
>> LL TEMAC IP is no longer supported. Hence add an entry marking the
>> driver as obsolete.
> 
> Ok. But while that might mean that no new designs should use LL TEMAC
> IP, why do we need to declare the driver for it obsolete?
> 
> Existing designs using LL TEMAC IP might need to upgrade Linux kernel
> also.

If you want to take responsibility for keeping that driver alive then feel free 
to send a patch on the top and declare it publicly. We are not able to test it 
on these old platforms that's why we are publicly saying that it is end of us.

Thanks,
Michal
