Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBED757E43
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjGRNzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGRNy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:54:59 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15158F;
        Tue, 18 Jul 2023 06:54:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZJ+8kBjTBbMKeESwYuvg6tDlPyt7OkclBfqTXgblId/njS13b998pw4DINeMwv4pub8x+hWYIKE6/1np5dDlTSDVCfcDOZooiATA6Z/n2ygQDWi7JYw5+Jtxt4SxwsjgZGGEF/qR+hamQl2BvFiW5qBuY18uDFhaQlqQlPi4eGSdU63BglUX3SCzqQ55wIDeb29VhHY2POFfOcTLTNL5ogxfbzZ48dY+bqDxgFIQNf3OschdUJuyWegaNnM3AL0DV4JxCevl6TjgFyi845QJhvb/Jr2b+zCrve/79DSOIV706pq5Uzn/011m4XInzP9o5T9UIkw1Eqy8kv0C1zIsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ig736U4Q1CqEnvhv4e9dw1TukTJZkbbDE7eUI+9NcyE=;
 b=YRVJjIzSd6fpkAFuCjsmz/ju6E4nXqnqnPFutTS1onjR/WByT+pi2UeXlluvjQG+jIvN8tXZqwrcw8RgMX49ZTFIDDdAzBXSG3iEw7iG5jM94XSw/xQ4ZR+OZpKSaG04m0LorIBcXcIosQxIlESSMlkvmyjgQ6IWdDX0V+6TwE1vRVQNrOAB3CSrcrMfNeuGUeTJCA+HxYBmAzFU34AvJQlgVCbwRwts6gy45tb+m0uBAihM1c68yRdnYyUsMdtj6YdT/1SjaaYaGyCWmOYx8m6h0hwuDdXocap2wcQXjVDUo7GyrS/EtFe9aM+wjJ2qkOFKWRdeL6DcCmu5GnV7gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ig736U4Q1CqEnvhv4e9dw1TukTJZkbbDE7eUI+9NcyE=;
 b=G1Wkwv06Zo2DhI1zd767nPC8eZYA/ETEJq9tby45iC4Ke2Vsec2v+WU2qC8zxB5JFi+KKm5lvN4veibVRhXqgGoz7+Ry4ND22Kytxe/GHXWxX9Dmfd2YQTJ9YMRBqo3NvOLUV5eiluXjMXsUpuN0IcryTopjUVUIu1SV2MsNFQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 13:54:50 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::b7a4:9183:7942:5936]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::b7a4:9183:7942:5936%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 13:54:50 +0000
Message-ID: <88eefdcf-5398-97bc-161c-78f056c682a0@amd.com>
Date:   Tue, 18 Jul 2023 08:54:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 2/2] docs: Integrate rustdoc generation into htmldocs
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     corbet@lwn.net, ojeda@kernel.org, jani.nikula@linux.intel.com,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, konstantin@linuxfoundation.org,
        Akira Yokosawa <akiyks@gmail.com>,
        rust-for-linux <rust-for-linux@vger.kernel.org>
References: <20230717151624.3470714-1-carlos.bilbao@amd.com>
 <20230717151624.3470714-3-carlos.bilbao@amd.com>
 <CANiq72=jiEqYfEvcRAxXsm1BCODnpxmWZOmbGB_YwM=pUGYEeA@mail.gmail.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <CANiq72=jiEqYfEvcRAxXsm1BCODnpxmWZOmbGB_YwM=pUGYEeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0101.namprd12.prod.outlook.com
 (2603:10b6:802:21::36) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|CH2PR12MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: 557e5636-3f2f-447b-bbc6-08db87968dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bBwi10AiyPQK/IqcxJf3zZYuQAkrxFGALUCcHObGO6rmAx4OR5YrO9eSoUV+b3Dxi0jVe6rKMArLL3vqM57d24Va/n3+XVs7t7CzL19ksmRx5B8U6aqxYtg0XYv7t/Klrv1vvFhzHp6fIbzCAnG/4244cTXNS7wgAzbqgoUdVKmxPtZ7mjSAdIWAYX18h5suDQk8lBhgizArcOeCZA7fD5E4LLkT4BLcMUg2yJgLoNv188RtBUZGckwruYi1AjhTcvwRVcHXajpfrysRmfNyuOiW/NxF2eoNyiFY4nMQET5BqHG+hn7auZ4PTTN6mXLYrJ+AgzcLQ2u7m51rdl4aBUV6pqD2WIGrd9bzW6cuXLYD77G01t9Eg5PxZfG90UZoQZr2daJakjLTfzAycEEXYfyGiS7mEEJ3BOhAXurpKTDHGN7datrJ1/SgIfGr9jEl6/le/THijcVhduCvJ3plDJMOoHE7vmCBMTc18HobcwQk+2Q7C7yFzxM8DPvTei2oMSltLeRbwgFoTKNVBacqbxM20zUdyXEpPs2P6zH8bh/clFXq+bnZcFJfFEW3czmFZ/ZAK4LAW5Dgi9eaijV60IMaO7ExIUU40pA6aFrZLYDQ0w9iVxql5HKfCF4e3xdSaVNPL8fEYv0QOOdubRbU0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199021)(31696002)(86362001)(4744005)(36756003)(44832011)(2906002)(7416002)(31686004)(6512007)(186003)(6506007)(53546011)(26005)(54906003)(6486002)(6916009)(4326008)(66556008)(66476007)(316002)(66946007)(38100700002)(8676002)(478600001)(6666004)(2616005)(8936002)(41300700001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlJ1MkFTWVR3bDRSSEhSQWc0QWczVlhpbG1yZG9xVnlqSk5LOURGVkNNVmVL?=
 =?utf-8?B?aDZzekZNWWVNQlBlZnBBZDlzQU1PMmEvREdwQWhOYmptRUFYYmJVaFVrSFU2?=
 =?utf-8?B?d3ZmUFVhOHFTS2VvRmZGWktQZ0Fram9pNDNIS25BUjR0ZkJndUNVL0VnUzMv?=
 =?utf-8?B?ZVhyNnpPc0tpczVrMnl4K05WRkFZTnQ4L3VmdEVDSEN4NEZFZk1JTlNLZHNq?=
 =?utf-8?B?cWpuRWV5Y29qMGZCalpOQmRpOS9aWEpVKzI4UlE2VjI3SGxxRmF1S3d5NTIz?=
 =?utf-8?B?NWdzdmVCb1pUdTkyRnAzS1BLdENFcWprOEl2LzJ2eUNLSmxLbWNyeFZPUEUy?=
 =?utf-8?B?NXdlT1AyaTJQTHZKWG42SXczT1ArM3hremlSNW1CbEsxdFFpR0w3WnFpWVdZ?=
 =?utf-8?B?TWovZVF2QVQwUElsRHdXNFQ0amxwc1h5Zyt3OWdtS0tLSTVkZ3JXUnZZNzBL?=
 =?utf-8?B?SzZPT0NUemI1Zi9jV0ZWODV4amg1U2JXY0F4N2t1ZjJrcE9tRjNRSE5JdlJs?=
 =?utf-8?B?KzJ3MFQ4a08xbUdFcEt3ckthOS9nWHRUdi9qbDJ0SFF0dkdBV1hzaFZKcytI?=
 =?utf-8?B?bDZFMWRFTThYaXNjUU5QN2REWTBrWUtuVHNod3BacXN3blNtQTZqdWUvamta?=
 =?utf-8?B?R3llNFRadGJGdXdza283aWJPUXNldCtqemg0d2NncEhOVVIzcExIRVhWeGF0?=
 =?utf-8?B?WktJU0E2SThYbjA5NjNWdmUxdEFkM0E3ZXRFMi9qaGU2WDB5NnZ1THErb29C?=
 =?utf-8?B?K1BPaXNYYk1aejJhakQwYm9abjE2L3RtTmJBaGEySmJWTytVdmhia3JKWUxt?=
 =?utf-8?B?TElpTmdDZTBmclV1RnYrMDduY0hjNDFtSXZCVzhFOG8rcnl4bmR3aDRFUTNr?=
 =?utf-8?B?SThpUHNSVHpQZE5QZFVVVjIvc3loOXZxTjd2VEdGbnFMMUdHMmd0U3RxcGlo?=
 =?utf-8?B?NzNqNitsT2JXUDdwcjBEcnIyeDRHOWRKMlVpSGtRdVRnK2EwV3o2U3NDR0NR?=
 =?utf-8?B?WDlMNzNyQU9KS0Z4UldjOEtEcHRPa2xWbUxvSkpGMTRNWWFobWk0YTdhSllX?=
 =?utf-8?B?RjBZRm8xWVQ1NGc4Q3dIZHFSM1VxZlRPNFdERVlvV0xva0FBWjBKK0hBUkdl?=
 =?utf-8?B?MnVJRytDSlhVU2xjeU1sMXJJM1NYOWVLcEpSOUNnaWc5alY0TkJuT0ZrWEpo?=
 =?utf-8?B?R2dLdkV4amZiN3JDQU5TRldNTE1TamJ6cno2NWU5Tk92UHNmRjRQbFJnaThn?=
 =?utf-8?B?ckFVUS93cDNEQ0Jab1M1dDNaOGwvQ2Erb3YyN1VYdjFHQ1JlVFk0cHAwSU82?=
 =?utf-8?B?SU5BM2o1UWdEWHZJdGhBbmVIZFVFMU5GeU5PcnBwSENBc0pGaUhzVUxaMWZv?=
 =?utf-8?B?UHJyVzFzU3F0RmpNRmFEUUZ6MTdRR3p4dGZHUXZmT2R2MzhSSmdjcTk1RGRs?=
 =?utf-8?B?UDBPQXpxb1hBVmdVYU45TG9jTlRKcUxmdXNvd1VEU3dOK0JBV204VDA0dDJr?=
 =?utf-8?B?NW9WTlFnYjBENW15NUtLdnNraGs1THFJR1hZVTZXaUN2emY3S2JFUFB3Unk2?=
 =?utf-8?B?NVA1cWhLVzBIcWt1UVFHMlZ0Z3dUQ2xDZUNZTktGOXVhem1VM2VLbmxrNHRW?=
 =?utf-8?B?YXp0dVpubXB6RFQzcFFiaEd4S3NaUnEzaFNvV3JMUFFOZzNEUlNHT0NMN2VF?=
 =?utf-8?B?amxXT0pkTSt3UUk3VVdreFFVc0d6dEJhRTFPSHlJUGZvczdYeHYvb1A1Rmp2?=
 =?utf-8?B?dGx3N0VlQ1FZMWN3Rnp5SVNKbnJRcG9aQmROaWdwaUE3TncxcXF6RnlaUDc4?=
 =?utf-8?B?WmYzTHorbmEvWWpQNkYzSENPODJjUkZQSGJWWGVwcVd2bkVZc25zQ3JKYXpw?=
 =?utf-8?B?WTJUTEpZZW92STZQZ2NqM2lhYTIrSThqeFZZS3RhMUdzRDlBMWN2Q04xNlNR?=
 =?utf-8?B?Q05Mc2dBMTJEYUE2d0VLbjV1TDFKTWRBSmRXR1lEcHplREc4TU5WWVE1eklh?=
 =?utf-8?B?ZEdqajNodDM4U25wWnJVeklKZ25vcCtFOHQ5QTRmc0F2bkV6Y0tOcmJsOGx5?=
 =?utf-8?B?Q2JCNzRQQWJjamYvN0JPNnRrUXYxTVMrOG5hK2loaDNlMDFaRk9renpGUDF6?=
 =?utf-8?Q?r7dh9bnuVqf7lWKu7rnpfMck0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 557e5636-3f2f-447b-bbc6-08db87968dc3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 13:54:49.9495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xftKy5JWeW884fnXN7sdNLR9l17Zmx9UEfq2Hv06RkXhPmSqGkL1u+kh2mMeh2+LAiKAQJ7iWDkSZtXRFmn06w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 11:39, Miguel Ojeda wrote:
> On Mon, Jul 17, 2023 at 5:17 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>>
>> +       # Let Sphinx know we will include rustdoc
>> +       ALLSPHINXOPTS   +=  -t rustdoc
> 
> This is needed in the previous patch, no? I don't know if it fails or
> just does not work, but either way, perhaps you can split that from
> the first commit to put it last.

The previous patch works without this, the generated HTML will show in the
Rust index:

  This documentation does not include rustdoc generated information.

> 
>> +else
>> +       @echo "   Skipping Rust documentation since CONFIG_RUST is not y."
>> +endif
> 
> Is this printed for everybody? If so, then I think it is a good idea
> for the future, but perhaps a bit annoying right for most users right
> now.

Fair point, will remove as part of v8.

> 
> Cheers,
> Miguel

(CC'ed rust-for-linux list)


Thanks,
Carlos
