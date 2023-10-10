Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B647BFC09
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjJJM7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjJJM73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:59:29 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2240491;
        Tue, 10 Oct 2023 05:59:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbOzJPcRe00Cyxr0Vehx4MuEBJS4vaMePMCLDZoHirNmy17c4qCfMXhqpBnOX7lNYxYEWr5D2zV6yngYGo1UJC5eojlWrdULRDbHMncpnnqsr5URzx6RPStKTtcV0Jb4kEzA+LdhgLuVjD1qXDZHAFWhL6insiQ8cakDXXOHSe9L+ssXu/Q3SUXjfGvYq7ud+S08AHOBK9QIabr4de65ZvMvZZkXZyAkSjx5RmSH2qGBK9GhwSqAbmkh/c9tgkYWr7jnpGqCGWCW5h3cJ1kdKwqfQ1l7eKdmBUxPmSpyBPypzxGf/RWNzIdjVn/4K6MwAIqOT/zL5OSrKRNwclmLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFZeJojMrUHhVufLee9fcLZt1P2JF/OL9T6nSmvTZG4=;
 b=a3xcAA9jTCrkfmHThIPa2d6TrVkk/euizn6MHMr4L3QuKAkZtkoR00ivApzHPaSKcWZHy+Y1mSJW09xJMobnoTlrlbMB8+O4+dBMbXZT4YZ7Y+g9Xyvkk5TeeR8nbRS12eH3j8M9TCwY0Xr2J9jO9luNrrbIiZDgmJMHaMBQQmLdC1/PBJjynIJRavdJ2GPnoA9fwW0dRkIVR2avIGKc4hJsocMoe8MOAOhagq58JvqLjui9Dt7TvTuRNuv+jG58hEQd/7j/TGMMTMk2NyQdkhYjPLfKMl3jX8Y6cnwZUuoJjU0WZDrMWnAgB1TrsNpwv7v4ChtKdF+6k2EZVgYjSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.203) smtp.rcpttodomain=renesas.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFZeJojMrUHhVufLee9fcLZt1P2JF/OL9T6nSmvTZG4=;
 b=TH12z7RrWj2bIlvdvENHmfO6lDge/D9xBn90sSQ6RctqG2QtX9E/ndXLkcLlJC1/TOOkdaLF9tbmpS1jiGV4z9YIjntg5xOdlK8fNlaBdWd8FuAI5qmFrV7uJCaryg+zCYbzk/lFBJwO29E12UPF6PKLer9gP1ptXZqxfYm/Sz4N6L35Ts7TacsBT3xPKfcdJY2UHauKRG+s/4I7rTNH15ohFdkKHphxaWujdlFUD4ZOQnRnSjzJH5QuDUwqq9OWV5GphonG6hmDKnsrrxtieEcwR3JqYFV/kP8TV5e2St+smPc+cTQFNmJGG+U7LBbXw6r96eOKAkXOCezeCLPJeg==
Received: from DUZPR01CA0054.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::10) by GV1PR10MB6682.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:83::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 12:59:24 +0000
Received: from DBAEUR03FT060.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:469:cafe::de) by DUZPR01CA0054.outlook.office365.com
 (2603:10a6:10:469::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Tue, 10 Oct 2023 12:59:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.203)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.203 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.203; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.203) by
 DBAEUR03FT060.mail.protection.outlook.com (100.127.142.238) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6886.23 via Frontend Transport; Tue, 10 Oct 2023 12:59:23 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 10 Oct
 2023 14:59:23 +0200
Received: from [10.34.222.178] (10.139.217.196) by FE-EXCAS2000.de.bosch.com
 (10.139.217.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.32; Tue, 10 Oct
 2023 14:59:22 +0200
Message-ID: <de4ab49b-f1a7-5732-0970-13fd03407376@de.bosch.com>
Date:   Tue, 10 Oct 2023 14:59:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
To:     <yoshihiro.shimoda.uh@renesas.com>
CC:     <s.shtylyov@omp.ru>, <lee@kernel.org>, <linyunsheng@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <richardcochran@gmail.com>, <p.zabel@pengutronix.de>,
        <geert+renesas@glider.be>, <magnus.damm@gmail.com>,
        <biju.das.jz@bp.renesas.com>, <wsa+renesas@sang-engineering.com>,
        <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hackerzheng666@gmail.com>,
        <1395428693sheep@gmail.com>, <alex000young@gmail.com>,
        Zheng Wang <zyytlz.wz@163.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Dirk Behme <dirk.behme@de.bosch.com>
References: <20230725030026.1664873-1-zyytlz.wz@163.com>
 <20230725201952.2f23bb3b@kernel.org>
Content-Language: en-US
From:   "Behme Dirk (CM/ESO2)" <dirk.behme@de.bosch.com>
In-Reply-To: <20230725201952.2f23bb3b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.139.217.196]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAEUR03FT060:EE_|GV1PR10MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: c111d9d9-9b62-4469-5753-08dbc990ba2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y5Q7iKE390erCbINgX5yFxe9w0H5eqLGvHCygF8J6PMJAPRGrANthKfRw3PwegCyf1vW/3KxmHfmXxzvc8f4CuXyGq+xIReC3wjVfWqRl6PMFzI8KHUKtSZk9Z1VZclwaXsZFoq6tezodgQ5755kACbAUEENQTbygfoNedrtbFL5nWXhKfX+wQVFpY1a930erK0SJO6FwsCL3UV0oBK9zzQkKGGUSIYYFBNfWyvqvReS0HUmqyISwU+1+nTkCLMBYXe/R6BvQhU0x6JWR4BYSPNlHrSi3Wi5ENBsQVYr2/6oqKXSbv0TEnvwpvoUWFA2wvP+KoGNLKd5NbSFCmQgBE+9Q87E6cRiwYYg8223RK74PBn9l/Y3wy1UAiWHVv+iMVGA8YnpwPAglBIOXPPlftuAKGKHjpSnHPeqYGs4JShjHc0utwBsNiALuQCIltYwNkfGoJltUp2H0D6j7ksstoiuwNOfSe0ZmAg2wfX8uVoZamTOslGu2thWzp+4QS0+47wWhJZGbousCZhl/hk+BLpLj+UU5sb/SBzgcX/nXNTlbJoLaP5R1vbytER5YqUwrylyM7IpGBaD3s56BaZbr9BcpPlRDiIBP2od1f78HXj9TPLYzBrFGzgAWRFrQfxUSFT2xRngtd58of9MQx/m2GQ2A61QnLA5tjOjJTpp9tSBpDpGHZLPQBy3eqK9pKLd+HKZwH3a7UwFFWu7a0/XEyWibuuiVsxUJ2TV/fZ5/u6jUdvYRnAvwGoOVBv5EH+OxAw+7/4WDP8nUYA9KrDrM1w+qInSyskiqOK7LUXb9L6SH5/sV0hYGBup41HESuGr
X-Forefront-Antispam-Report: CIP:139.15.153.203;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(64100799003)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(54906003)(70586007)(40460700003)(426003)(336012)(8936002)(107886003)(2616005)(83380400001)(16526019)(36860700001)(47076005)(26005)(6916009)(16576012)(316002)(7416002)(5660300002)(8676002)(41300700001)(2906002)(478600001)(70206006)(4326008)(6666004)(53546011)(356005)(82740400003)(558084003)(81166007)(86362001)(31696002)(82960400001)(31686004)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 12:59:23.7774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c111d9d9-9b62-4469-5753-08dbc990ba2a
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.203];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT060.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6682
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26.07.2023 05:19, Jakub Kicinski wrote:
...
> The fact that ravb_tx_timeout_work doesn't take any locks seems much
> more suspicious.
Does anybody plan to look into this, too?

Best regards

Dirk
