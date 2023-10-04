Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9AC7B827A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242959AbjJDOfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242940AbjJDOfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:35:11 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A3010B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhMsIK38oakwbQeKV+9uG2kl4/MZialnGrW4WDTGOFVICSGtim3fl+QmTh4i6C2aWrdIIu6U4ngFryiezBmoE1oKZc3YPYyAIl+MPdcz2qXxILbTtI17XbjaHv5cWLxDT47mH/qxEz5wBsvF1yxeZpLIAm2bIdHE/nCi7F2wEIV9jWw1G53xlv3nJG5vFEA6fz8Czvv/J2efe7nTGi7X0yLeoq18fQTX3mjI88+rnVkS9rEa6yfCs5S9AYG3gweUvl+9PvCF82/JQuANcP7RALicE3IaR93HA1NFoi+MsovZMUMRWN3kklSdVCYUVLRtLsSx0y33dxyWMrXpSuP4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+frkgjq5gKV1l2j8BgR2iche3TASnxOkIMV15Mqo9dE=;
 b=j4YgGE0Ic/myV6WHO9j6ZmjSdUlHMsymSGARuC12phxMOcnt/fzAzBS633J0NFwKWtsP9S9mmszXHG/1Cm/geKxQz9FYNESothOI+UlBr8xb6cxFu+k1AqZnaLsPbTE0asVeL+Gz+ZBfGTK2+vjLKIpiCPcL3CDsQaPB19HICsIdBMV8HwW96h4PHnzXBqpmyalI+hqHeKn3FEkOZ4ptQy6hbI8gkK6JL6M6q9XROqzJVMuTDcKsWYMnmTPu/83P4lJPDwDVfxz09n7i//lOCCl5sbn1p3TyO83uF+u0ml56svczTBCnLBuZEEEYLEgQWpbHlaFzbCLH98XIP9cZ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+frkgjq5gKV1l2j8BgR2iche3TASnxOkIMV15Mqo9dE=;
 b=D7zx/RpotKFWNQ6DTh6FRcCvdx2jVOob+uacC6KAqwmuDAQUm3FSCzvKHSJThRcI4B93jBHDRMsLYm9XQSTbOobwq+n4Thg9NpxulCo8wgUzlgT/Ju6agL1e+5wL+DOgisN/P6kSZWxe+KKrlGftkEGE4ArSvfQsEDKxfGw6xNU=
Received: from DM6PR17CA0032.namprd17.prod.outlook.com (2603:10b6:5:1b3::45)
 by LV8PR12MB9334.namprd12.prod.outlook.com (2603:10b6:408:20b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 14:34:59 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::99) by DM6PR17CA0032.outlook.office365.com
 (2603:10b6:5:1b3::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Wed, 4 Oct 2023 14:34:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 4 Oct 2023 14:34:59 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 09:34:56 -0500
Message-ID: <d4ee1dc7-d642-4cbc-a2a6-200cd1fcc96f@amd.com>
Date:   Wed, 4 Oct 2023 16:34:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] drivers: soc: xilinx: update maintainer of event
 manager driver
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Jay Buddhabhatti <jay.buddhabhatti@amd.com>, <tanmay.shah@amd.com>,
        <nava.kishore.manne@amd.com>, <ben.levinsky@amd.com>,
        <robh@kernel.org>, <dhaval.r.shah@amd.com>, <marex@denx.de>,
        <izhar.ameer.shaikh@amd.com>, <arnd@arndb.de>,
        <ruanjinjie@huawei.com>, <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
 <20231004094116.27128-7-jay.buddhabhatti@amd.com>
 <2023100446-jokester-uncrushed-c9b2@gregkh>
 <48bc9520-fd5f-43fc-9adf-2a9e0493109a@amd.com>
 <2023100444-dose-laziness-d488@gregkh>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <2023100444-dose-laziness-d488@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|LV8PR12MB9334:EE_
X-MS-Office365-Filtering-Correlation-Id: c6748fdd-80be-4695-1dae-08dbc4e7167d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4QujuYc8dX8ZDJslzEyiVSyP9PzrrzXsfEGCSNA2xjrxbw+CQ8vUxlgOvtZh5ljcOFEPYCua/rV+kV1kh2BK3GQKdAJukpfZ1OFhbP/1INQp4qWcVdQ3pVm8feC83AzOxPhLbxa7OeVq4QTxDvF0jxSHglEIuKvIq0aAlWP+wX0/9c6mQxQEIJHkT65sRXKWDb81rUQps2HEI4AFkaFK18l0/m8/usMQ/e2w9usO0iNRYZNPg7v8CpbAuAXf8n7Dn5gh2XrAA2TdBx/8rgU72kL1kG2ly1b8bBJVGnkBDtFdNUIbEDk0oQsw+idqWZNj1DD/ybglpa8os0kSkHcTAeI8c0Z326wW0jdFdi/+P01cTyDNASkJ0T4AiKuefLMaH8OgoyBYMxlvIp6wMtuHzxkCBLcsk31JshwFPV9fgLKNJIGR80uKvM7CYywUnOadqHNYbNaLqZodULRSs4v+YUC1Lra5ZzJ8L0rtXv5jEJ6nzGsyo+nE5emsk5OOQEbk1hREIcXEZVrnQT8zysPnyJ2dLQf5BAFPNgcwSMPuTuI2dk8rxNfjSntS1SwOeV7vEW8YfZWgFEEvTmzJk1RNbEV2bcG2paNI4IEhzTZfq+ssYMpxMXXX+qH9+lT10FvNCGGtixPZWfa3JKrSXSUpo+T87MioVIgWbnklVd45Vwnm9UuON23xKhug5fu3ODSHiX5qdgZeszSWSHkW1ekbQumWAtB5WIsx9IODdMIJ3yYRQgHcIMHUHmsivFYJL3KFtqyWBjfEPoVc9d/FUtkWLGGE5pS1iHP1o02S7QQQOCyjSjuhp4GdkNr0Ufka1Oif
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(82310400011)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(31686004)(478600001)(53546011)(16526019)(36860700001)(31696002)(82740400003)(356005)(86362001)(81166007)(2906002)(16576012)(54906003)(6916009)(4326008)(47076005)(83380400001)(2616005)(426003)(336012)(26005)(41300700001)(36756003)(70206006)(70586007)(8936002)(44832011)(5660300002)(316002)(8676002)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 14:34:59.5907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6748fdd-80be-4695-1dae-08dbc4e7167d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9334
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/23 15:47, Greg KH wrote:
> On Wed, Oct 04, 2023 at 03:16:15PM +0200, Michal Simek wrote:
>>
>>
>> On 10/4/23 14:17, Greg KH wrote:
>>> On Wed, Oct 04, 2023 at 02:41:16AM -0700, Jay Buddhabhatti wrote:
>>>> Added Michal as a maintainer of event manager driver as Abhyuday is no
>>>> longer in AMD-Xilinx.
>>>>
>>>> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
>>>> Acked-by: Michal Simek <michal.simek@amd.com>
>>>> ---
>>>>    MAINTAINERS | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 35977b269d5e..f36fefd7032b 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -23672,7 +23672,7 @@ F:	Documentation/devicetree/bindings/net/can/xilinx,can.yaml
>>>>    F:	drivers/net/can/xilinx_can.c
>>>>    XILINX EVENT MANAGEMENT DRIVER
>>>> -M:	Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
>>>> +M:	Michal Simek <michal.simek@amd.com>
>>>
>>> For obvious reasons, we need an ack from Abhyuday.
>>
>> He no longer works for Xilinx/AMD but I have asked him on side channel to
>> reply and let's see if this is going to happen or not.
> 
> Mantainerships follow people, not companies, so if he wants to keep
> being the maintainer, he can be, there's no requirement for him to step
> down.

No doubt about it but normally in these cases people send a patch to start to 
use their new email address which is what didn't happen for quite a long time in 
this case.
I am definitely happy to wait some time if he reacts but if there is no reaction 
for some time we should fix it.

Thanks,
Michal
