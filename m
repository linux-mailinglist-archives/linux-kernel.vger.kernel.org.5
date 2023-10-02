Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A517B4B53
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbjJBGKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbjJBGKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:10:33 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E24EC6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 23:10:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROwJRN8bwgjKJ3qyfcr/8hxI07/mQIWK30PW3fHXaWYR5qEG9jOp4IRkcGt0/xgT00roJWR9HIuEOzLfpFLGxYIJ+GtCd49TSt4JVXbe7IXmPsCHSbCA47BqATsC69Bq6L3zk3J6s2pTqH6HcwstrDWZ9JLQTy9o6LwW+INYPSObva2J6lFvBugVxRnWAppYMMgIGKe9BOarYHMwJMM2J7JKqaY3m26dcDtWl9gVa5rg5N6JLLlwHhH4k3SWfeDXhoVv7G9TFJ3ETYE+6J1PHGsddxrsC5n9UUx/+sKZkI/GLW/HtRV/Orri7JxJwAJ/MbdeV2UM+kYii+a1B2JaMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwmjDC0FOKuAqWVmvvfH/20WXlj5/085PZUU7+uhn+k=;
 b=Ln2QAxbr/dZsZERJoMY/+b6fAsqBED+j7MMul3uAfescHg8DpPdwNTvfa1e16Z6odWnHIzXQgZ/mIIpmgs+oQFMSgQitvK4eqTfd3aAUW5NBoOKkkurImV/gmFkdqI+kK53ZiTuZ52ZQrfCs3CaHAK3ijd5MTNWTxbzNcYqJB1A3nk4P5bXy+LneWrHib1Nyt2sg1Ias7eziIEkucMU/fb5NucoTSvxjtz+WEwFMAYibFlJToM57jeifcOh+EIVCpRYHQh+55AHaM/Ff4Ztc4AC7sEAA+grFSQ3rNOgr2qvsZ4+/5BbHWzllV6FSG3KLFfEzMiPZkQjSbktFa/pjpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwmjDC0FOKuAqWVmvvfH/20WXlj5/085PZUU7+uhn+k=;
 b=xwcvFt8YfS9dpwbq17P68aeSanKnEDUjMAFQEq7u8kxZMLWxTAEemBx3ndfTazmAakqJ+xk2c//6M4PX3rXceBgSCRRl3yuotenzqCwbdJBlhEBZizQ77A/L4hUxFaGSbxqw1zjNP1VzVJZn88CqJTDo97AuGu9IpwLBXJeo8aw=
Received: from BL0PR0102CA0032.prod.exchangelabs.com (2603:10b6:207:18::45) by
 CH3PR12MB8903.namprd12.prod.outlook.com (2603:10b6:610:17a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.24; Mon, 2 Oct 2023 06:10:28 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:207:18:cafe::32) by BL0PR0102CA0032.outlook.office365.com
 (2603:10b6:207:18::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.32 via Frontend
 Transport; Mon, 2 Oct 2023 06:10:28 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 2 Oct 2023 06:10:26 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 01:10:21 -0500
Message-ID: <92c4c782-084b-4c65-a62f-1e8b2209b772@amd.com>
Date:   Mon, 2 Oct 2023 08:10:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] drivers: soc: xilinx: update maintainer of event
 manager driver
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
CC:     <tanmay.shah@amd.com>, <sai.krishna.potthuri@amd.com>,
        <nava.kishore.manne@amd.com>, <ben.levinsky@amd.com>,
        <dhaval.r.shah@amd.com>, <marex@denx.de>, <robh@kernel.org>,
        <arnd@arndb.de>, <izhar.ameer.shaikh@amd.com>,
        <ruanjinjie@huawei.com>, <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230929105558.11893-1-jay.buddhabhatti@amd.com>
 <20230929105558.11893-8-jay.buddhabhatti@amd.com>
 <2023093043-overbill-unsolved-6da8@gregkh>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <2023093043-overbill-unsolved-6da8@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|CH3PR12MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: 143ee439-9151-452d-dd38-08dbc30e4587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LO98S8m73y887EdP3G/zPjKzZftQNf7gA0wq+fg/FuAWk4Unm1as9nCsS9BV+r1xW5YEsVUW45R/4Q2V7XduFQwdAQACdqkmVHbnvL5ay4MyyYkGzHNW1CFQTBMt3OBc/NzWVQiyDtJxWi/lxb9RhzkfwhTV/OkMit829GTnlthokdUuedttX7maYlerJQvGU1vFNugtJ2DwGlTheRz16W4SsMb4u3dTvGzWl3Y2Nww42a/b7RJ3/bwnX/r1hzk8W4HBhDeCQ84nDwgj2X8lo7BsnirG+pbN11x5ghED6wl53IoRzb6ujLKzLZkPHzdcHFRyfr68dY7CudzV3hcKVi6AleCPzrj7jeLrnhsPOeB8a2cOz6XPbuUMN4rnxFPjeKIhMpJnh+Y19YSOVhNA6Ngbi2hPLjNw09GUqrQTzNLGdYPw4TXRv6QtdqGOo+im5WeVfmkLtCBXZjFcsJKrXBa5RgXUfXVzfZcvmXxS8E8z4uea+jPuF5JtKlXQmuWF69jsQmuSjv9BBC73co6pvaA+fGFRfUjJPMO8Nq31FfIDIqzkrtHlbJtKmS3eRMOttZg4NuHLRH8gFodzxRPY8BPlhPtBLF0v15aCzkhIS8HmE7t7PYVZhYOzlxYo8CEn71LvoMzS0MwAwcDVKKcA9hYfjyCzXAz6mlx+yxEtD+fSXaATL1NWDNTOjTQ4wFMN77wrwQ8NZB0G0XiDUTEiJBs5thqVbbh03NkX/Znn+N8Plvsv3TPPAUvjAGb7lnFct7GozJgBpK9gLS8kie1vWK/stNrNaqh6NcEFwQ54tCsvZIEc5Z5Ingzkfhv6KiYL
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(16576012)(63370400001)(81166007)(83380400001)(44832011)(63350400001)(36860700001)(8676002)(47076005)(8936002)(5660300002)(478600001)(70206006)(70586007)(54906003)(26005)(16526019)(41300700001)(316002)(426003)(336012)(110136005)(2616005)(6636002)(53546011)(356005)(2906002)(4326008)(4744005)(82740400003)(86362001)(31696002)(40480700001)(36756003)(31686004)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 06:10:26.5922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 143ee439-9151-452d-dd38-08dbc30e4587
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8903
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/23 09:17, Greg KH wrote:
> On Fri, Sep 29, 2023 at 03:55:58AM -0700, Jay Buddhabhatti wrote:
>> Added Michal as a maintainer of event manager driver as Abhyuday is no
>> longer in AMD-Xilinx.
>>
>> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
>> ---
>>   MAINTAINERS | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b19995690904..8da1ef5f80f7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -23671,7 +23671,7 @@ F:	Documentation/devicetree/bindings/net/can/xilinx,can.yaml
>>   F:	drivers/net/can/xilinx_can.c
>>   
>>   XILINX EVENT MANAGEMENT DRIVER
>> -M:	Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
>> +M:	Simek, Michal <michal.simek@amd.com>
> 
> Need an ack from Michal for obvious reasons, and can you put the name in
> "first last" format without a ',' to make it easier for tools?
> 

When this fixed please add my
Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
