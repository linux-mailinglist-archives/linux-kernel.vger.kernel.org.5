Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9437B808D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242556AbjJDNQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjJDNQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:16:34 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC495A1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 06:16:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZKfAC3mR9J5zBys/sbjolHXbX9viSmtpUSdp0LUkuv+0V3DLKJ4DMQBkqd4NCF7SQD0cjqCohOQUkoPKKi1+Q/N2+25fMmuauskCk4TS0HnRDDxqoT2zY8HmrOgunShEzrslAjyB0NJUWqWt4MiE8+swY6XdPagOmFL2ce0IjiF54Oksjtj3LHPYpqSN+ZlJKYKJ2gK2YeqHnwRAFq1GofdoVz2s93Uh3EhLDsVx9lRtkHH7cq91pT4SzBteayZLtlXhH8AvwuckmzaffqP+FfugU7TsmZsTZZ5I/vjITUTCJ6pKlM10YNhqw0HzE2jiNSuWTIn9gxKOJLroLV9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lc8UW6Q+hEQYC7ZZNFUr/pCOi4WUmhXGDUqnfjNRLIU=;
 b=MJZTsY2pFfmSnwGoVptOk2LqOGH3rPJ9KnVpytN4gsqRi29BrmzCWkzYSvc6FydRzzgC5+s8UC5qppbGwSlEzIADQmTvJI0DAVPqpbIEd2cRMHGNqSmI0BRpppLwmZAbdsFt7ijeCAtijmWnhO0919ZV8fFOsKP+Y33wNUOPJafw42n3LQjf84sWILGEyAkkHJq6Ug06eHxnTqDxkZamXdAGXWtUeLY1ruKAf2HiysKwlofDlVmjj7Yp3jurba4HSBsPFm9JubLZaeVpUQPT24/oig+dGIKR3IeKk+kEt9hOBzbz2kWq2ErDC0M8/6hm+Za8xrUfrjEeg+vJqIn/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc8UW6Q+hEQYC7ZZNFUr/pCOi4WUmhXGDUqnfjNRLIU=;
 b=iA37NX5Yrtqcl7SfzLelw74sLNvuW+ZfO4sosTcDdNiJF5Zb9zJWLkeI3uVqoVFljmCy3wVbzz0NMErfjWRBQa4W4t5AMFAqj+GojxPOLmZfkiqtzVzibaSxQX3CbjEANQzP7pMn+K/wMTDGvGsqY5av88JEZscFcHP4WvZHPGs=
Received: from PR1P264CA0175.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:344::14)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Wed, 4 Oct
 2023 13:16:21 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10a6:102:344:cafe::f8) by PR1P264CA0175.outlook.office365.com
 (2603:10a6:102:344::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 4 Oct 2023 13:16:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 13:16:20 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 08:16:15 -0500
Message-ID: <48bc9520-fd5f-43fc-9adf-2a9e0493109a@amd.com>
Date:   Wed, 4 Oct 2023 15:16:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] drivers: soc: xilinx: update maintainer of event
 manager driver
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
CC:     <tanmay.shah@amd.com>, <nava.kishore.manne@amd.com>,
        <ben.levinsky@amd.com>, <robh@kernel.org>, <dhaval.r.shah@amd.com>,
        <marex@denx.de>, <izhar.ameer.shaikh@amd.com>, <arnd@arndb.de>,
        <ruanjinjie@huawei.com>, <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
 <20231004094116.27128-7-jay.buddhabhatti@amd.com>
 <2023100446-jokester-uncrushed-c9b2@gregkh>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <2023100446-jokester-uncrushed-c9b2@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 8deffc9d-383c-4f51-0ec0-08dbc4dc1980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QxJ71brmBHp1qfYw92IVMo2scJMjJKMDAkiMgWQaXPzpNg+8Zd2SkaAAToAr/n2yLzuQztBWOFnjtq51SVtz/S+eqUYst4PjQDS68TZ0oe8syGyMBLYrzuKvHccU5M5MoP+jUxeNMzka3uuORppzhRhDg7vDpeO1lD8mvh8xIRgQ01UpMCQ8/4if9gx3l2gmtCw45OZC+U414FcE8QoNxqtiDNu9e8fw/qNueGDn/C2inFlhkJrDGHegmQ4RBKjcqfqA+AEDAi6pOVnRT5zogYYZluVNrdfzCInWBkczK0sFgzduhMHgbVoHFdgrlH1kMJdAz87nIl7mFAaYimCrzDuV2TTCCObM08CHKZvtYyq7GZrQ7unJ3U0rcZMmJIMIi5Le52j5ra+2wVCzDJBaMZGmS689AgWsvxFfSJfeEdYtWE7gWJfZZwR4k/nVoTKfhPwisHk4cAsqSaMpOU396qfK+yDSgEPKlKwa1KlGDbjSMzLQMllmkSlKdrDLty76Uq6wM4o8erR5wYBkEuZGmPQ2PMDSWvuOJ82Y41rdizht/6CxLRkx+VIIDxhed+IlIEsEof2LGo88PtI1D/Qww4WTXWkR4o2JQzvU6h+BiGshMemcBmlhYv7lxXY8YTeleF4vAeQxSFmc5OTjzbslG7N2SVPXcl+RhJbCW2h65b6QIHg9jlOpiErShaN3oPG0lIIFA8i8dRsTMdlMrLypi/k7mt9MqciWieFtoW/PuDYRVRQXRF6TZDsWASSv3uc47HPCYB9AGcKSrvdiJvBqjCckTqd9wgXpwE0Gl3+LcZ9GpwkU5ZtTDzj+NFmtxL+I
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(83380400001)(40480700001)(2616005)(53546011)(26005)(41300700001)(44832011)(16526019)(2906002)(4744005)(47076005)(5660300002)(8936002)(70586007)(4326008)(70206006)(110136005)(6636002)(16576012)(54906003)(8676002)(426003)(316002)(336012)(478600001)(40460700003)(31696002)(86362001)(356005)(81166007)(36756003)(82740400003)(36860700001)(31686004)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 13:16:20.2104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8deffc9d-383c-4f51-0ec0-08dbc4dc1980
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/23 14:17, Greg KH wrote:
> On Wed, Oct 04, 2023 at 02:41:16AM -0700, Jay Buddhabhatti wrote:
>> Added Michal as a maintainer of event manager driver as Abhyuday is no
>> longer in AMD-Xilinx.
>>
>> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
>> Acked-by: Michal Simek <michal.simek@amd.com>
>> ---
>>   MAINTAINERS | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 35977b269d5e..f36fefd7032b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -23672,7 +23672,7 @@ F:	Documentation/devicetree/bindings/net/can/xilinx,can.yaml
>>   F:	drivers/net/can/xilinx_can.c
>>   
>>   XILINX EVENT MANAGEMENT DRIVER
>> -M:	Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
>> +M:	Michal Simek <michal.simek@amd.com>
> 
> For obvious reasons, we need an ack from Abhyuday.

He no longer works for Xilinx/AMD but I have asked him on side channel to reply 
and let's see if this is going to happen or not.

Thanks,
Michal
