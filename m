Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487B1770583
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjHDQDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjHDQD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:03:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5FD4C21;
        Fri,  4 Aug 2023 09:03:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBLcY6IzEwKQ+7FDsBZ+ONvy0oJq2eF9HfvOmwX6drrUU5ad/0963h4iuuA1Mxnx7B4c/oN5iArQ5JJt22+AZ7ZLxpZuWNK7R468TCw4wps47DeZtUbRw+1klTLf0124zOqkOK14laGruY/SVa3v70/EFTCi6JCWJBG+9LUyXw5jf35zeGYH67+mYbl228ulkfiNdxbtFnblpbqJ7vijGrXee6BSb92EvBDH999lit3oa1F7cBk6dMpN32OiJZP6wdHYWk9Q1PjcuXo6gotMFe1RY59Z1nmIFl9RJwhEHFwDr8nvsGOCgGn/GcnRF1Ei+C3mJVjPtecuhwk38FkLTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlOQsI9UCgfpWrKBWF019vaPw4cmNXrgt52C7jJqbp4=;
 b=IfpPGhXjPcLUq3K/kTEZ0kTMUfjX3LRH5BbRqj/iSTipi6aeIOfPAoRBXc3cQiaQrXb4vRTMSUyVIrtKzs+ANW7PQ02eCHbQ6sZ5n6m/ZkrPvwQHOO29dVg6U1sYwjjARViT5TouueO+waZK4Rw2C6Yh2DfUMi/rxOlh8Sd37sj1Lw7cJp8X2gZuRndV7uMVyyDx7Aohd7ocJN8LZaPZj5KhauxtoPdfXG20vgs7HaaAnrou/VfqQ3R26G8y9MaG7cwRP8Bdf8kM+Bp1QjGu5eeXUZUSRebfXCFuc1+0IdYx3p3sVPrGfZxyrBhHg9IIIN4/FVKlhhyZ0eszZCwfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlOQsI9UCgfpWrKBWF019vaPw4cmNXrgt52C7jJqbp4=;
 b=fdh2IkerFUqTMy8TGjgYfL0GrDeYp+u0yHUHVkz7La4Mq2ny76xLJ2GU7cQj0Y1yw09x8zqhMA3ZAHERuv2cTYzorximOJvuZnBEsI1fJfsHsFmRCqPXSQOnJMzeDBfJZqyVn+cCmf+0uucAx0zE9qmXXgqYbbAF2fbUnC+8Fqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 16:03:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 16:03:08 +0000
Message-ID: <1606f9f9-5d5a-788d-b058-ec218fb73712@amd.com>
Date:   Fri, 4 Aug 2023 11:03:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] EDAC/amd64: Add support for AMD Family 1Ah Models
 00h-1Fh and 40h-4Fh
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Avadhut Naik <avadhut.naik@amd.com>, bp@alien8.de,
        linux@roeck-us.net, x86@kernel.org, linux-hwmon@vger.kernel.org,
        linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, avadnaik@amd.com
References: <20230706171323.3722900-1-avadhut.naik@amd.com>
 <20230706171323.3722900-4-avadhut.naik@amd.com>
 <e5b0063a-ae41-41ab-b3a7-2084dfa7f816@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <e5b0063a-ae41-41ab-b3a7-2084dfa7f816@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed8f2f5-37cb-4f47-b0a0-08db95044b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FwzZkLP2jAQ0TG1TH00k9kWGnv+0a1fAKlDn7xr/Bfxw9CARskWPdrcM/o8Zk8kcw5IsStCYv/SQPD2vBc3KYyt8N3uNUQsWjZKrdeq40rZqjWdMxdnxLrDqexReB/semBovifopzkqs3WoMGM2PkulskQKD0ul+5OlntlKGkMPupOKkFoItW8T5eXuOgpzJ94WtzMesk3mskJdtcOGEVpYSh5OPIMuOzX8WmJ/pAg6+WCrc3cHmwtCOHMvk0pksB7a9uCVkIh2x7zNb4lPNfOrQckZU4jOEF4kv3Volz8r5qGwwpP8YNFSqaPIF/W1PxrpsP8OdvwTlb9Vhm2RJlHTTRBkDwO5zVa+W/OXVZotcxhXcS7B+zzKlQfRXT8veaAUAh2ID90wSkz+IOcQo/MJ5Cr5BonqjRdyOlNS2PfUekPGiJb8zQptAtZY0+O8UkG+JMKm9iLi3FEepkPO9SfSUOWNVmj3USvUHhlqnHuXXLpQGP4x5Uke78/e4vX21qViSScTkV+3Ioxfon0+/YT1GQNuSbXfNVxIcu4CoHTClYc2i7WqEYXbF9aR9i5/MGXnjT+Ker03jEduggfR3Bo9PpxOer+6lrQBc+O8bYbN6jPBkHMTwU6EVGwpn7jv5eRl2JxJKDnySqp7cb5j0Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(186006)(1800799003)(451199021)(36756003)(86362001)(31696002)(31686004)(478600001)(110136005)(38100700002)(8676002)(2616005)(26005)(6506007)(53546011)(6512007)(6666004)(41300700001)(8936002)(6486002)(4744005)(316002)(2906002)(66556008)(66476007)(4326008)(5660300002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wmc1NzNhMWhwV1JUY2xwMklEeVM5Sis5ejdYYUZ5ZmlHWVNPUWxBTW9YVEdF?=
 =?utf-8?B?MXZXdllXTDF2TXZManJ6RnBRa0FsWmlGZWhRMHE2TzFKQkhzaE5GZFNPeHg0?=
 =?utf-8?B?OVJQM3FZMTBLQ0V1dGJlbkdHVHpYa1FOQjkwdmxrZXRkbVppSkZXUEZrL0VX?=
 =?utf-8?B?OGhTZTlOVTlwNzdDRTdpRXZ4bk8zaE5VVTFsallYUzlkeXR6SGthVmlScUZo?=
 =?utf-8?B?bFVuMmkxck1MRTlDYmlJQlVSMTRHTWlxZXJTUW1IRm9CeU5yTS9lUkd3TVF0?=
 =?utf-8?B?dGlLQXpOYVorVmd0Z2o4dXFCVDI0VC9UTXM3ZTlzalFkOVdCVm1Hazh4cE4x?=
 =?utf-8?B?SmhMaHkrZHQ0RzJzcGxaZ3I2UndBQXA3QjlDOXpvUHlRaFczajYyYm5DSXRn?=
 =?utf-8?B?MTF3cElLaU5qa0VINnhDcVdkS0VDWFh4ZlFvbTltVVlUL1JaNFJQZVRHM3dD?=
 =?utf-8?B?R05GUGtyQlU4cXp3UnJXaC8zMUZSdGtqQkNMNTh5cHFDaFZzUXAra0VxME91?=
 =?utf-8?B?ZHQzMURCcmc3K1dGd0s4Z1pMb091eTJlRHk1QjVGMXBrODVlZUdaQTk1cDU1?=
 =?utf-8?B?djQzeFh4TndnM0lqVWNuQ3NaeWZiK2hXQzJKczJrdFZUU013eVNYMVhieVRK?=
 =?utf-8?B?MVV0S2FFbGdtMHJMdG9LUkVWdVRQc2lIMEhVOW9YYTNOWGo3TnlOZGtQWWhk?=
 =?utf-8?B?c1lSekFZZDRoNjZiOXVBZnRsR0RBaFd6TE9DRm5HUGJ3blF0b3NkQ2NMU0lJ?=
 =?utf-8?B?a205MHZ6c2NFT1Y0ejR3dkJrbnlHN3NJR2hBaUswWHhmZEUvaEQxYTlETHZ6?=
 =?utf-8?B?NHhaNisrWGF4ODd1cE5zZkEvVmtEd04yZVpWNzdsbTBLcENrbjdYcU81SUFq?=
 =?utf-8?B?eEtQejFIeVBIaWNxc0tmMDFneUxrWjltMG45ZWxwdHFlZFBtVkx2OHJucERl?=
 =?utf-8?B?ZXh2Ync1S0NUTDIvdloyLys2NFkxaWJGdmxEWG9BNnQzNlJYRWlMMVRydS94?=
 =?utf-8?B?REZsQXJ1UUtrRDlXV2tEMFZsNEd6bFk3ZVNtODg3SjQ3WTVyNXFJWjBSZGVh?=
 =?utf-8?B?SHplN1RFSVV0cXI2MWFVeFlFSlRnbW51WGVtUUN0RnROM1FQZW9vRVA0TXdu?=
 =?utf-8?B?dDVNZEpSdUhKUEpjVnMza2VaUmFIdVB5UlYvTnBZS2tpU29IY2EyNDR0VURJ?=
 =?utf-8?B?YWQ0R1FwR2Y2MEV1NFRydyt6V0Y0MXMvYUg1NHJJNlRTRWRTWkNzNkR3MmhS?=
 =?utf-8?B?Mlo1T3ZVMWUyU3kzS0QxUVF4eE1LSnFQRy9NbXpkaHEvbXlsb0UwTCtDUGt4?=
 =?utf-8?B?SGlreUVQR0p4VDZlL1oxZ05WQmZBU1JPOWZWbjZlYXJ3YjJjZnE0Wm5ib2VB?=
 =?utf-8?B?emFtR1dzU2pYeldvT2tvMm8vbnVrYW15UDY0c1UrYmF6bHdKa2FkU2pGOHpL?=
 =?utf-8?B?UUQyNld5bkVSVzQvaDdydVlEVDZadFdaUWVEcVJiTVRUS3cvV3FyMGhudTFw?=
 =?utf-8?B?czFITXF5RVVSV0xXSGh0K1BTRTMxSEdMeEFBaHR0OFpjejVFRUpaSnJlUmtV?=
 =?utf-8?B?R09NVHVBNVVBWG5Sejh0VUJVS0d3MnFyTmlYRVZmRlVvZS9pd29iS0hESkF6?=
 =?utf-8?B?clFpdGtKV0ozbTBjc1VsdzJ6VmNUUnJ1UnpEZTN2bG1jVG41RXpSRWcyMEJ2?=
 =?utf-8?B?Mm5iY0U3SmtidUwrRGQxWGZWU0NVUDRXTDdENXBHWTI1QkNwMjVGRmVIQ1My?=
 =?utf-8?B?bkR4dlNTV3ZyUjZTZC9yN2gzTi9ocFV1V3pvNy9yU2xPQ3VYRG9vQ3g0R25P?=
 =?utf-8?B?enBpa0VMOEJvdngwZDFQNFBFaE1aTnhEZzI4UXRaTUJDS0ZJYkNiTlh5cHFx?=
 =?utf-8?B?eHhEWk53ODl1ZFo1MHlkQVFKdDlDWjNyczlLQnJyaGx0R3lPOExEZzF4SFE5?=
 =?utf-8?B?Z2NSbTdtRk5BdURrQ2pOMWJqUElLZDdDNi9UeFJGSTFFTll5NC9sbkhBZ0ZB?=
 =?utf-8?B?NjV3VWJSRHV0aHRyMUdIdzJHSVlXM2ZXVEV3UkxtNkJkNmxnZ0FNOVVjSFY2?=
 =?utf-8?B?bkFJVEdpN05FNm0vSVE5NFFGNjRjYXNsTCsrLzBxaHpmbzJ6WjVybWJ4Smxo?=
 =?utf-8?Q?6gQ1WEzF7WEn3ab9VVlidMMJH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed8f2f5-37cb-4f47-b0a0-08db95044b6c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 16:03:08.2622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kg3fFYqKjYdXAoEj5bbR33WM68GV5Os02KRMkmPh46wHoeVAj+z1a5ysJPodSoIjpyZGIYiXGc2vYcpUcJmbpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/2023 7:25 PM, Yazen Ghannam wrote:
> On 7/6/2023 1:13 PM, Avadhut Naik wrote:
>> From: Avadhut Naik <Avadhut.Naik@amd.com>
>>
>> Add the necessary support in the module for AMD's new Family 1Ah-based
>> models 00h-1Fh and 40h-4Fh.
>>
> 
> The first patch in this set adds PCI IDs for models starting at 20h. And 
> this patch adds support for models 40h-4Fh.
> 
> Can you please elaborate on the discrepancy?
> 
> Thanks,
> Yazen
> 

Model 40h-4fh shares some of the same design as some other platforms.

The root port ID PCI_DEVICE_ID_AMD_19H_M60H_ROOT and DF_F3 ID 
PCI_DEVICE_ID_AMD_19H_M60H_DF_F3 covers it.
