Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9F578E6B4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 08:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242754AbjHaGnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 02:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjHaGnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:43:19 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0171A4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 23:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPtJg5GyJZvsMhjsFDQYdqHH7hPlCIU9CsekvR1SxYSfQe09r8yOyodpXGr89fbnU3kpdotYabbXn12RWCG5Ki0jon1w5dRUcS4v8D5L0egBmO7oPspt73766wdvQI15NTuC1An+exlCpvxKi7a5u8OHjUtGOaRIaKTC2V7KxqyMP9Blgnn4zegWwOIvtMSUJI73cAaE0pG25v8EUYlXgLduc8HcliO7bzLZDDtHLzivb9w9VPMavdzl9mw5jbSSTu567NiHQaxYgoRQkjftpfix3F2WuFedukBaOtoyDAHHCbyItOLka2oTv3Gv7OQjNIybT0MYWhj9U9lKcSGa7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9644K+G0pEgP9Vdmx6pFK9uctgfnGPtIYd56r036mJw=;
 b=Cwa4bvHI3K5eHTOffaZ8+FA7Q9bvLEAgC9/0j3VGodqoWF2X7PfVtm0b18qjebbb/V4UG35Ilrm/6N9bUua1OjJ5AuMldlPnTBjGK4sLFC37+bGYQDtRWd88W16H9fdsqFI6Kk7GyKndfANJXK5PAkgS29J2r4DmjpBaokTQStDVs5woQs0cwLVdrJa4Wcoq2FAOipzGQVi+Tyuvcnmep+cKuI9k2bkky2lIJEGPeikHRnX3pq9AXmhkgMn2FskcyHboZ83bs9v2z8EMNPsJCD8zqUJ+/Idkd3WPSdj126rFLOZ8ZNTAlrDGIADADWB7sRUIhUn3v659+S2BYYmPdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9644K+G0pEgP9Vdmx6pFK9uctgfnGPtIYd56r036mJw=;
 b=b/wPvIAHvKGdNu8iRuZL8dLAi+5ad39k6bsGaHCO5klG/RPAqdW1v6t8m8wSoLO9N8iJk+yZcPgLgKpv0PC9hCfMXCESH6hhd6vlt/1ivIRBLqzI9YUwExXk7VhXr+ncDYPM5ej6qQd2rh0MfRpCNrePoLJ4eucAK1RU3xKGjhM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20; Thu, 31 Aug 2023 06:43:11 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 06:43:11 +0000
Message-ID: <20b44fe8-33ba-d6ae-110e-a82a19390bcc@amd.com>
Date:   Thu, 31 Aug 2023 12:12:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 4/5] iommu: Support mm PASID 1:n with sva domains
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Tina Zhang <tina.zhang@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-5-tina.zhang@intel.com>
 <aa834f12-ce45-fe15-430b-2a9c3446a5ba@amd.com> <ZO+oRPOf9jyNG2+B@ziepe.ca>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZO+oRPOf9jyNG2+B@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0226.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB5391:EE_
X-MS-Office365-Filtering-Correlation-Id: eab1e2a6-6435-478e-8709-08dba9ed8b62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0HoRf7W9If8WvzYd93O0CfUv2nHxWtjbM+S1Fp2t58dWWqo1ETkyakKtpwTbzEyzBFqSEa4M7ZWqH7V6NVC9K1usAKuY3ZwzAGWDs/cTNeonuLvhLGcTuP+emObj1k5f/AsbKboc2Y2+/dV2svPG2Fro3KrbAm+rGGkW5PZvEWGMtkEDJlMwiPKJtD53/VTx4QZMTDv3vS01yrM5JqXsWgTEYwA4bXKtUTvcPsamC0D1C3MPCGV6q37V12tfQfzek7O7sx6LA4phJDvJswmoFuUak/KCOURmCEvPvm6TCOj3OYbAX4rX0xvligpowe+zORS51I0coTlatqdpchBs2DW2MfZGCZqq+3/LDC7PG+bTU5M3Tciq/Kf/p0BUTLMEaWNdZuy+91DF3UN/BIjLXZN54k4JoVbESO4yc1YnD0XputWCYAbq5nfImJnLU5/U7JaUoS5+q2rm0ACyeO9UcSUqc7QkJbMYXJw0p2PoUbhU8YVC0cZGESagqg6biBvudii8CViXYDfWCX6Rcv2cnIldZtUORTHsOnB6Kc8Wz71ryFv9fuUT4yM+3U4/8+1PKI9B704Oau/JOVYistxUmBufvCp7yl1TeRki0T1Ka7GWNixaVM5FTaN9yP64G7CBT24gLyIcppNQw/vtmGYSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(346002)(39860400002)(1800799009)(186009)(451199024)(31686004)(2906002)(86362001)(31696002)(5660300002)(36756003)(38100700002)(44832011)(4326008)(8676002)(8936002)(41300700001)(6512007)(6916009)(66556008)(53546011)(316002)(6486002)(6506007)(26005)(2616005)(478600001)(66476007)(6666004)(66946007)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0l4L0RDT0VnRE1rZEQwa094Vlh1OGN0MC8wRkQvSmRjVDdsQlJXYkZrOHYz?=
 =?utf-8?B?L0Z2TVJoZENvTXBadE5uTlJDakFkMGNLNnlETWdPRG5xTE4yc1QycnhocER1?=
 =?utf-8?B?YTdwOEhUcXBNcUpDdFBvMzdSTzZJR2U5dlJHNUxXRDV6NU5YSDM5bjQ4ZlJq?=
 =?utf-8?B?OTJvcXR4b0tkM1JuT3hDUTJEaVc1dHptR0Y2aFdSZ1A4dk0yUlF6a3V1dnNw?=
 =?utf-8?B?Y2FTM1A1b0xBZldLbThUb2RtNXBQQ1A2a2czUG1Pcjd5Rm1vblVycUhGZ3BZ?=
 =?utf-8?B?bEQyV3N4aEh0ejQ5N0IwWWF6Zmw0ckJESG5Wcmp6N0VEUmFLMUYxT3Q5WFFX?=
 =?utf-8?B?MWxlTGlGc3M4WGZQdzBoVmpDbHdvZmpxWGxYWDdOSzI5Q2s0Rk9XOGVkNWVs?=
 =?utf-8?B?Tm5McE4xZVkzWDZnV1VlN1VvMFZYU1FRMjgyUDNFU0cwYVNLNy8wMTJZUUxY?=
 =?utf-8?B?cW5ReldmSlpxcDFVQnZOQWJFbjVJc1FxTzFOVUdQWisvMDY0UFF1a1U4aWZs?=
 =?utf-8?B?eDVFU1EvZ1RNYUVGNXV1VmUvT0VNRUdLUVJOQVFwajhZNUF5UGh2T0xJWGll?=
 =?utf-8?B?aDd3THR3cEdCUnFKOTJmdkRrWDNDWFVXMzRxZUxROS9XMTNTdWJkRi9MbW43?=
 =?utf-8?B?MXZaSzdFOGxlV3djRGhLZG8rVzQwN0lLOTdFQWM4THVZMGhKV0k3US84Y1Bj?=
 =?utf-8?B?d0dBSjE5bitTQ1NNdm9wTzJYK3FGM0JkclBvOWhiS3NMZHRKZ1h2OUpPNm42?=
 =?utf-8?B?TW5Kb3JwYXFLcGdXSGhzWGEwTDhqZU1TUEVlQStVbnNta2dKY2ZTbzJka1Ey?=
 =?utf-8?B?Y0RQTURJS3VXOUl4NkJ0dDh3QS9XOTRJWXZBby84TUVBNXNqZnVuTStyS0sr?=
 =?utf-8?B?MlFsYm9tbDFKWUtDb21qWjRNQWdoczVMYkZ3TEtGT0hqWjlYYUdKM2htaVNa?=
 =?utf-8?B?WDd0SGROVGZuZlJuM1l0aXBCb2Y2ZEx1ZkdDQnpSVmJvK25vdklUc0pEVlRO?=
 =?utf-8?B?WGUzOXY1eWZycmswU3ozNEVHd0taQUVhM2gwR2tJZXBBa2tqd0xhdUx4N2Q5?=
 =?utf-8?B?YlMxRy9zYXdtUVhBd01LMXRkZUpWWkR1Uy9wS1BCaW4ybGM5UjduV2VlWXlZ?=
 =?utf-8?B?N1dUa0xYcDJvL0NKbTlTcXpncVlPMWVKblNTUkRJZHpRdHJPVE4zZHNiTWo3?=
 =?utf-8?B?UTJvS3RsYmVGMThKclUzS00vVWJnQzgrVTNCRUk2cEE3QzcxMFk2TXFJbk9X?=
 =?utf-8?B?TzdSeS9hbjBPZnAwV2RjMDdBTnZzQWwvVkJxb0x4alQ4ZmtkSTdNWm1rc0ZP?=
 =?utf-8?B?clZSOXN2TkI2Q0VLQ3krMVU2d2pJNjA2OWEvYXIzNE0yd0I0NVJxMjM4elB3?=
 =?utf-8?B?MDhpWEgwSk5NK1pDbzBTUGdoTnFYZjkrY09Sa2orWUdRS0M2RHRsbDVHOWE5?=
 =?utf-8?B?Q3FvRDNWUncwd0hLczZJL0E4L05MNEhydmpJRHAwR2h4c3JyUnlmcE9jNDBJ?=
 =?utf-8?B?TWp5ajF4SlFCMVdlQlo1cnJNRENuQ3VTc2JUTnkrUXltSWpNVnhmNUJCbTVI?=
 =?utf-8?B?cStJb2RDa1VlcUUzTVlCSjlHckM1YmlRY05zWStlQ0czd0RxdmE2KzZwdXg3?=
 =?utf-8?B?L1JGNjh0TVdnTkxhN2hDZVBCVGlPQUFnMzZlK0NJN0FEL1hMSk1XUTFUN21W?=
 =?utf-8?B?QjhIUXZyd0thS3JqZXpzWmJpRzlPclY5WVhsREQ0U0xmQnc1NU1JL0ZOVXBL?=
 =?utf-8?B?bDFkZk5Jby9OclFKTEZ1VndMTGNpb3FaWnRJRGlRejkzZFJvSXNaZVBpU1p3?=
 =?utf-8?B?dFlPOFlwM3FYOUdDYzRMZ2wzQlZGYkY0UWlyd3djeTRoOWNocHNHTk9VNW5S?=
 =?utf-8?B?SU84anpoSVVpY0NNSmZwM0JnREZ5OGdxMFhGdEMyM0dHeXIzY3J1OXZCbTFx?=
 =?utf-8?B?enZTRzNGKy9naTZ6WkFXd3ZybytFby8vL2JDTXBheGZzWVU5UUxDUjR3cm1Z?=
 =?utf-8?B?ak94WlZaaERZbkRWY2NlbVNsV3ZsNkh4aG9JMFZHZC9BVW1HQ01vYTlMTTNR?=
 =?utf-8?B?anRHblNzUHUxVGNzeDdycEJ2eE1WZXp5bVZmOTRsMzBoY0QyQ1RNMjJGclZ2?=
 =?utf-8?Q?yFynyU3dlxg0ZOd1r3JMcge0w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab1e2a6-6435-478e-8709-08dba9ed8b62
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 06:43:11.7540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2j4Z2WjbWXkOA3oaud8sx+pttnyUQzcG/TFb6FhdZBR5NpOszF7GZwa33cA/zGyPX5U40mg5E98QIjUXZtuyCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5391
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/2023 2:06 AM, Jason Gunthorpe wrote:
> On Mon, Aug 28, 2023 at 02:02:52PM +0530, Vasant Hegde wrote:
> 
>> I am not sure whether I understood the flow completely. Just wondering why you
>> are not freeing pasid in iommu_sva_unbind_device().
>> I mean once iommu_mm->sva_domains becomes free shouldn't we free the
>> iommu_mm->pasid?
> 
> No, for Intel use cases that PASID permanently becomes part of the
> ENQCMD MSR and cannot be revoked once it has been set
>  

Fair enough.

Patch description did explain it to some extent. ("The PASID is released in
__mmdrop()"). May be this needs to be expanded to cover why pasid is not
released in iommu_sva_unbind_device().


>> Also in this function (mm_pasid_drop()), should we check/free sva domains?
> 
> No, the driver must support a SVA domain with an empty mm_struct, eg
> by hooking release.

Sorry. Looks like confused you. Looking into code I got this.

My question was: when PASID is enabled, is there any chance of mm_pasid_drop()
getting called before freeing all SVA domains?

-Vasant
