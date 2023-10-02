Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A7C7B4D21
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 10:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbjJBIM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 04:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbjJBIMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:12:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B676BC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 01:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esUykyXs1v4LIGNVGglo4UrlNUl897ZsrFy70o0rZc1vIqkbAy1FXv2wvGW02UVGCKr2C6lWErKuJB5JaAFFNP5lTG6XHlWnIu3GVg49b4NooC2M/7ahQ2+8SGsSJe9wv4PXpQ2c9r1hY8SxnQiHggCFn800JGi6lGL3w0OwdoTDfKREGwMvom1lct8+6BCiM94+pd0igUG2XjlBXszcZS+hzS6oiiS3KhPcqYjRlvpnYZdUBYSgt7J55juvl2AwSIv8I51qPBPJxsBGq4G6zXe8ix33itoXoPd2r6HfPCKnQhly+VwddcV1djck0wR3RRKoVyk1B3auOxn+dQj7cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hmrkxpz23UUxOK24yZd0Bup72eXuZy1uvc70LQrpuy0=;
 b=NV+EwMsXA4QyLFZkYBdQmF5x823AbSeWZxdwRTrBgCwE1W754uQ8m6Mk8BPim/8wQe16joOmooOCMMOpVvo/LKncTq8msMwy75j7OzM2h7EYwVQ4NgiWxxXBeAVYlIJyEtXt3ZSxihKv2waTPmeZluF7pBqcCc6n/BjNqsOUPloYsU7E2Vu96xT/FaFT/KVDn+NWtNiuaP+03o6/fBUTqirgw+ayfLL7TuLvknDgQyE6msGlG/33XhY9QtI9wzg2lah2U97uEydsNGiUK1P4FdF3qBybW/I7IG/AFpyrmEgxvNG7+wWoUQcnJFUDmYrdLrOZSsk8msZw0bKlQfK/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hmrkxpz23UUxOK24yZd0Bup72eXuZy1uvc70LQrpuy0=;
 b=DWM6RIUgnnbfaVYFEb2Jp9dLXOziRNVU5JqZ5WUZcUXEdub+2oT09Cj2JTlIpAHDyoILoqdipFFrBWGSxV+s394crIha37tR4jVKXcoJ5eL0bD50H4FPb9lk4zT1SQnRPImYOJMhXCC0WYj2nhRqFJLqyv8dBN4Swza4gXQcJBU=
Received: from SJ0PR03CA0234.namprd03.prod.outlook.com (2603:10b6:a03:39f::29)
 by PH8PR12MB6913.namprd12.prod.outlook.com (2603:10b6:510:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Mon, 2 Oct
 2023 08:12:45 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::28) by SJ0PR03CA0234.outlook.office365.com
 (2603:10b6:a03:39f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Mon, 2 Oct 2023 08:12:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 2 Oct 2023 08:12:44 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 03:12:40 -0500
Message-ID: <68e8a5ad-650b-4d1b-94fa-8eb74e904aac@amd.com>
Date:   Mon, 2 Oct 2023 10:12:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] drivers: soc: xilinx: add check for platform
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Jay Buddhabhatti <jay.buddhabhatti@amd.com>, <tanmay.shah@amd.com>,
        <sai.krishna.potthuri@amd.com>, <nava.kishore.manne@amd.com>,
        <ben.levinsky@amd.com>, <dhaval.r.shah@amd.com>, <marex@denx.de>,
        <robh@kernel.org>, <arnd@arndb.de>, <izhar.ameer.shaikh@amd.com>,
        <ruanjinjie@huawei.com>, <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230929105558.11893-1-jay.buddhabhatti@amd.com>
 <20230929105558.11893-4-jay.buddhabhatti@amd.com>
 <2023093034-spiny-diagnoses-3da7@gregkh>
 <1a38b6bf-00ef-4ada-a9a7-8dff5c3a1934@amd.com>
 <2023100223-trouble-conjoined-fb51@gregkh>
Content-Language: en-US
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJkK9VOBQkWf4AXAAoJEDd8
 fyH+PR+ROzEP/1IFM7J4Y58SKuvdWDddIvc7JXcal5DpUtMdpuV+ZiHSOgBQRqvwH4CVBK7p
 ktDCWQAoWCg0KhdGyBjfyVVpm+Gw4DkZovcvMGUlvY5p5w8XxTE5Xx+cj/iDnj83+gy+0Oyz
 VFU9pew9rnT5YjSRFNOmL2dsorxoT1DWuasDUyitGy9iBegj7vtyAsvEObbGiFcKYSjvurkm
 MaJ/AwuJehZouKVfWPY/i4UNsDVbQP6iwO8jgPy3pwjt4ztZrl3qs1gV1F4Zrak1k6qoDP5h
 19Q5XBVtq4VSS4uLKjofVxrw0J+sHHeTNa3Qgk9nXJEvH2s2JpX82an7U6ccJSdNLYbogQAS
 BW60bxq6hWEY/afbT+tepEsXepa0y04NjFccFsbECQ4DA3cdA34sFGupUy5h5la/eEf3/8Kd
 BYcDd+aoxWliMVmL3DudM0Fuj9Hqt7JJAaA0Kt3pwJYwzecl/noK7kFhWiKcJULXEbi3Yf/Y
 pwCf691kBfrbbP9uDmgm4ZbWIT5WUptt3ziYOWx9SSvaZP5MExlXF4z+/KfZAeJBpZ95Gwm+
 FD8WKYjJChMtTfd1VjC4oyFLDUMTvYq77ABkPeKB/WmiAoqMbGx+xQWxW113wZikDy+6WoCS
 MPXfgMPWpkIUnvTIpF+m1Nyerqf71fiA1W8l0oFmtCF5oTMkzsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmQr1YsFCRZ/gFoACgkQN3x/If49H5H6BQ//TqDpfCh7Fa5v227mDISwU1VgOPFK
 eo/+4fF/KNtAtU/VYmBrwT/N6clBxjJYY1i60ekFfAEsCb+vAr1W9geYYpuA+lgR3/BOkHlJ
 eHf4Ez3D71GnqROIXsObFSFfZWGEgBtHBZ694hKwFmIVCg+lqeMV9nPQKlvfx2n+/lDkspGi
 epDwFUdfJLHOYxFZMQsFtKJX4fBiY85/U4X2xSp02DxQZj/N2lc9OFrKmFJHXJi9vQCkJdIj
 S6nuJlvWj/MZKud5QhlfZQsixT9wCeOa6Vgcd4vCzZuptx8gY9FDgb27RQxh/b1ZHalO1h3z
 kXyouA6Kf54Tv6ab7M/fhNqznnmSvWvQ4EWeh8gddpzHKk8ixw9INBWkGXzqSPOztlJbFiQ3
 YPi6o9Pw/IxdQJ9UZ8eCjvIMpXb4q9cZpRLT/BkD4ttpNxma1CUVljkF4DuGydxbQNvJFBK8
 ywyA0qgv+Mu+4r/Z2iQzoOgE1SymrNSDyC7u0RzmSnyqaQnZ3uj7OzRkq0fMmMbbrIvQYDS/
 y7RkYPOpmElF2pwWI/SXKOgMUgigedGCl1QRUio7iifBmXHkRrTgNT0PWQmeGsWTmfRit2+i
 l2dpB2lxha72cQ6MTEmL65HaoeANhtfO1se2R9dej57g+urO9V2v/UglZG1wsyaP/vOrgs+3
 3i3l5DA=
In-Reply-To: <2023100223-trouble-conjoined-fb51@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|PH8PR12MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c09d4f-25bd-4afd-7e1a-08dbc31f5b5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bljATyYe0t+9x2fBUDIcgWoLqO6foE5804vsSBZI52b4Gvt14Bo56fNZMT13VovI8XFEsL9r7E+ZTII8eu6ppj/KdAGySjWDKwM2V24vQxE1iRHBbB8FTxX2Xz0qda/8Ntgv9sDlZMsKER/V1S6RB/HjPbSSqoIVYorY8wfaPpJ4wIobKXe5KEV9JfSUZRsZzBr3+mxDsDi0KxkLI7wkcOURUTTf4L9ouMO3+WHyES+Eg9T3GGvaK9sGbMRJ2LjFf12bfm9qE7VH7wTu4+RojFTrg7pJxl4xJnXqYSjfdrk9E9kxRc7VPe6o+l7VfTgPcDZkgv60sKdcSLYBs0fnHulLsIUlvTrFAFr9Vj85Apls+DKY28x0BDtdI1P67axDuUG48f+hKX8hAsCoKOWxhFNEGgc1HCCwOpOm62XGzRLYN1yAgWMYywcr3mDd+wc8IkgSxv5cu9rkX3l1iL71CvrlNgLi6xLjWM11Nu4pg+y2rg3XhReJtP+KvKGMp1DcXnxROdqY+baF4F9zeqZ8SgNNVwiKRnOfkS676JVa6iRmJRWCV5KCARyi0lGGS2YXiEFpETCkti9C2LpB+FWa7p4XnLMhEFG8o1NPQci5zFmntqUsikKya0EJNU8oVkB4BDhNgDDfjT89twu5t9JS8Y8MPHSljwDbLm27m1Sy60J3cVcW2StE0pdwDqekYzbC4tmSMMUkQxEhyWrSmK55aZRw4S9OU73mrrDCQaSOAviAwb/VZIOmMRVKHw3gBf7lu3hkVhB3/EW1olkYU6NX1MS7XJ+aDmxNM1MQrRisWwsrVUhliq708qAQECqhMQ6G
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(31686004)(66899024)(2616005)(53546011)(36756003)(40460700003)(40480700001)(86362001)(356005)(81166007)(31696002)(82740400003)(36860700001)(336012)(16526019)(2906002)(8936002)(47076005)(83380400001)(478600001)(426003)(26005)(54906003)(8676002)(316002)(41300700001)(4326008)(5660300002)(70206006)(44832011)(16576012)(70586007)(6916009)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 08:12:44.6532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c09d4f-25bd-4afd-7e1a-08dbc31f5b5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6913
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/23 08:20, Greg KH wrote:
> On Mon, Oct 02, 2023 at 08:09:50AM +0200, Michal Simek wrote:
>>
>>
>> On 9/30/23 09:17, Greg KH wrote:
>>> On Fri, Sep 29, 2023 at 03:55:54AM -0700, Jay Buddhabhatti wrote:
>>>> Some error event IDs for Versal and Versal NET are different.
>>>> Both the platforms should access their respective error event
>>>> IDs so use sub_family_code to check for platform and check
>>>> error IDs for respective platforms. The family code is passed
>>>> via platform data to avoid platform detection again.
>>>> Platform data is setup when even driver is registered.
>>>>
>>>> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
>>>> ---
>>>>    drivers/firmware/xilinx/zynqmp.c        |  2 +-
>>>>    drivers/soc/xilinx/xlnx_event_manager.c | 25 ++++++++++++++++++++-----
>>>>    include/linux/firmware/xlnx-zynqmp.h    | 16 ++++++++++++----
>>>>    3 files changed, 33 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
>>>> index 5f40288f69a9..6583efa9ac48 100644
>>>> --- a/drivers/firmware/xilinx/zynqmp.c
>>>> +++ b/drivers/firmware/xilinx/zynqmp.c
>>>> @@ -2019,7 +2019,7 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
>>>>    	np = of_find_compatible_node(NULL, NULL, "xlnx,versal");
>>>>    	if (np) {
>>>>    		em_dev = platform_device_register_data(&pdev->dev, "xlnx_event_manager",
>>>> -						       -1, NULL, 0);
>>>> +						       -1, &pm_sub_family_code, 4);
>>>>    		if (IS_ERR(em_dev))
>>>>    			dev_err_probe(&pdev->dev, PTR_ERR(em_dev), "EM register fail with error\n");
>>>>    	}
>>>> diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
>>>> index 38cfc161a713..8074ded7b39c 100644
>>>> --- a/drivers/soc/xilinx/xlnx_event_manager.c
>>>> +++ b/drivers/soc/xilinx/xlnx_event_manager.c
>>>> @@ -23,6 +23,7 @@ static DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number1);
>>>>    static int virq_sgi;
>>>>    static int event_manager_availability = -EACCES;
>>>> +static u32 pm_sub_family_code;
>>>
>>> Why is this not a per-device variable?  Global variables like this for
>>> drivers are almost always wrong.
>>
>> Not sure I get what you mean by per-device. Can you please elaborate on it?
> 
> It should not be a global variable (i.e. the same for all devices in the
> system.)

You are not changing silicon when you run OS. It means strictly speaking you are 
not changing sub family silicon code.


>> This is the part of firmware infrastructure and there is only one instance
>> of the driver in the system registered from firmware driver itself.
> 
> Then that should be fixed.
> 
>> If this should be done in a generic way then there are much more variables
>> which should be moved to driver data not just this one.
> 
> Agreed, they should all be moved there.

Let us to take a look at what can be done to try to remove all of them.

Jay: Can you please remove this patch from this series and let's deal with it 
separately?

Greg: Are you fine with others?

Thanks,
Michal

