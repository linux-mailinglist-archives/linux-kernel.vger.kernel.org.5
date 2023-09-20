Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B147A890E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbjITP4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbjITP4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:56:36 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA2CB9;
        Wed, 20 Sep 2023 08:56:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtmQZsB1VD4c125WWwVpGSTMDI15cnzBv6YCpeNs++Jah2Nn/nSVv0WbZNPc8nL/KsgZt3XN2VKgMhuM5p22P7yaJ/l0MjySRjeDyeJVejWyscCO1FcTP0NiqsXgmp1TgC+cVPwwkherdzv9qkBKK3J+7EU7F9Ed6U2wHkrJBX+mAMsNzdgO/27mKC4TW+ov7M/0PVoysxLl3TQx6RXAQndPvIX+VVQJtLgcuU4Hpd88l47VfJhwzOknSukb4hAlyHydGuaGjhlixzvEc0HmsHRai3dh4CAkBaLkV6ch+/Au00KKR5KT/yPff5mmAF1S+CmUq4g2G7Jxrex2D/1ROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGevIgLM82QqfUk8aNiVagGHq7Webv+UyaqewRTflak=;
 b=cFffVyvRP+DYIaRFieS0MjkzKfN/v+oKhIeZ59nvLtvjtv6pxkzyHdLCloiiPm2PIePJaW1AzYMa3RnYFpsFAJJ3SghHujjr2giqQS7uJ0JhbFsHwqxmaQ3V2iEQaBnw6WGEhM94AQE2UPSvWlq7xmbXUjsE3j6horl/AkO96ZsR9C8wy2O9/pxvPCuQNP5pTDf3gzO/A6BzAxFuDdmpebiugdKCjCi8H2JJAWqtlZd+6CE1sRyVRLwoaVW/ZDUJ1m2OBvDDSyE9d0Eurt4wQoYaBuvBOakfnf+VQTgeYQY2JVoT1XPcVOq9GA86tAMYf9nZY3ORdp0nsaHff3UiSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGevIgLM82QqfUk8aNiVagGHq7Webv+UyaqewRTflak=;
 b=qp60Rf50WvuSpJajy8wxsMQ86yCPqFjo2awWh53vToT8KCLOF8d2cGQYhpz4slmDBZAoLddErMP9E2Se6Z7Xx8suIrW5dB+0dBiqFTi1x19912c9hZ6G+RcAFXJhqXu4+/JNDAxIEaHJfhsFezMMdxcjRATh7Jp1Gmb0fBGWNdQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BY5PR12MB4872.namprd12.prod.outlook.com (2603:10b6:a03:1c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 20 Sep
 2023 15:56:24 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3043:e5d2:42f4:a231]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3043:e5d2:42f4:a231%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 15:56:24 +0000
Message-ID: <02e6de51-45e3-4370-95a2-df835b3bda46@amd.com>
Date:   Wed, 20 Sep 2023 11:56:21 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v7 2/3] x86/mce: Add per-bank CMCI storm mitigation
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
References: <20230616182744.17632-1-tony.luck@intel.com>
 <20230718210813.291190-1-tony.luck@intel.com>
 <20230718210813.291190-3-tony.luck@intel.com>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230718210813.291190-3-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LV3P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::29) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|BY5PR12MB4872:EE_
X-MS-Office365-Filtering-Correlation-Id: 26cdb64c-bb1f-4b6c-de3e-08dbb9f2238d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YPS3zGVMe/MZNYFrQMUv+vm8nDGxCkA013wjZiszdozlKrIH7ErVB2QGB1NIxzpz8G8rrXy9rPCsP/uHpO/mD6c2mH2HU/VWlkgN8kLOIxAIiHdVbX4df9JeYmbjwbiXPCVgCoQ6OrezBufrZwCRFEdFkAnH4NWtUthrCyNajOJwA2dxqJjwOJeXH9cS9dUx91TnJGMwdzvyTxRCDM0TD+NbBtKNcyhlbAiYlEFnmHnH9YPB4wAJ8DPTBPEoIBH7AVgB1nO/e31BPO68ohvrIX5+y+Oi2qyPSix8dECOgNvoyRbRShYeTLvtdiyDL/4nM3qHYIwkFvGZhk11NGAsWazGAE8iV/DGWbxddYeV8V9tIcedLKOCxdqtuicju1iqyKmH7oji7kjfnU172tAsYUMLovv7/n+AhPYLU5rjV8lpH8UHoiUVit3gIIcIxbw7asxw9G9nIPICxdRZEtgsZHyXLJD+mohRu0lKWQFZmWRVELryCqgqAN66c4wKOSUq4sJ2MDD1Z3kL4ZChaYj2gFBzwNjt7Pn1JXBLJznd8UIQv1/0gF6TjPbO6ADKiUAq6LdXJxhIqXlS284WBWYKnOLTpVSUa06oQamq501YQxwhab2/e1mI3z/mcdOcHmIfF5u3PSduJUqdYVFHJNPzSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(1800799009)(451199024)(186009)(6486002)(6506007)(53546011)(6666004)(6512007)(478600001)(83380400001)(2906002)(26005)(15650500001)(44832011)(66946007)(66556008)(316002)(66476007)(8936002)(4326008)(110136005)(41300700001)(5660300002)(8676002)(2616005)(86362001)(36756003)(38100700002)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFdiUVE5bU9xNDZZbjN6ZE9QRUlneDh6NlZPai9kTkJtOGN5Q1hMQ1krd04x?=
 =?utf-8?B?c3FidzJmUDUvQm1BRHhsSEN0TkxTaDVNS0RSWUlobVhrRzVNdW5XT0lYSVpF?=
 =?utf-8?B?QWt2eWgwTjhlVEZSVnRWeFZGMXZsMU9DdDFhSUtqbVZRYVV5ZW1VMmZpczlJ?=
 =?utf-8?B?VlBUc045bitFeWQ1UmhVTFRWYkMrRGwvMncvNEMyRmRLRTJIa2pySW5rVUI1?=
 =?utf-8?B?UHp0dVB4bjkrV0tZQ1ZZOERXSWFEZVRxYWNVVUJ2VHYyaFpzNjhxME14S3cr?=
 =?utf-8?B?Vkd2OGVKeEZXczd4RU5NK2JTbFN4eGs5cFlOZ25wdi9hdkVDRTdQNkxKVm9B?=
 =?utf-8?B?SnNHOW9wU0lrYmMxeFl3WkczTFM5dncxME1uZkF1U3lEUk5FRFgxVGJhbDIv?=
 =?utf-8?B?K3gvVEhYc2pldFREZDBsbWkxVmJTM3IrOGFsQ1ZzcXcxQytvaVlQTE9oVFNq?=
 =?utf-8?B?ZVRNT0l1NVhMU0JoaDd0dVd1K1gxeStUNVR4MUFEYnpDaThZbjJhSlMrdkpn?=
 =?utf-8?B?TXN4V2phaVRibUY0M2dtaml3VVAxR2k2cGxVVSszVTJIVXhLUjAzamZXR00v?=
 =?utf-8?B?L0VMN0l2ajlGTHpleHpPZGNXTUwyRkQ1R3hnT29adGlGaTk2dHV3QmxXd1Vt?=
 =?utf-8?B?eXk5TUh3ZkZsdmNJQTRVaFl6VjJjUVJLamxhSUlOdTFsTFovcnFtSE43TGF2?=
 =?utf-8?B?eU1xUFh4SWdJeVYwL1lHN05XU0pJeEYzeWJqNU9Ja3BlWkYwRmdEeEdWWkFB?=
 =?utf-8?B?MGQ5UmV4dDNRajJTSUxzR3d6S2ZTTms4MGpqcVhETnZqazNlNThmVlJNMFY4?=
 =?utf-8?B?ak9jWFVWNkFvT1JybW0zeFcvenVDUCtDU0hXY2pBcFB4MnNTcExBQ2k4ck9I?=
 =?utf-8?B?Rmx3NjRkMU5pR25MUXFxaWVFblhzc2ZLRnpsN3VjR1k2THo3dUVvcC9KYWdH?=
 =?utf-8?B?TytXQWNTbVU5WWd0ODZ1MTNTbHVzQWxtbCtRbUNkaVVGeS9IaDMza0pZS0hX?=
 =?utf-8?B?dUcwb2FQVkJCRnNSN0l0QWZpc1B6Q2tzc3pjdy91Wkg5Y2hXSTVpQjFpSzhI?=
 =?utf-8?B?OTdneTZvZmpKOFk0QTdiWExTcytBWGdnT2puSWJoQzI0WXNxUE9BMXpZOXdR?=
 =?utf-8?B?cXk3cmNieGJxYUU2UlVtNXJlemN3UGo3YVdKTmhYaE8zcThyNXlHN2dnWVFn?=
 =?utf-8?B?K3BySnZjb01aMDkyRVYwdWlGUXhNSjh3RWcrVVBSdk1KWDNjMC83N0dYbVJZ?=
 =?utf-8?B?Z2ZSSGdXcll1MFdkWVlTVjVvVURHck9oWXZYRDFUUkh6NU1KOVBKZnQwQ21r?=
 =?utf-8?B?cnRuSmp6UVE2UVZOMWpCaVRGVTFUb2lFaEkwczVYLytmSjB6YWpTNmsvTHQz?=
 =?utf-8?B?VlVUMmpla3F0eFo1WDhTK2kxL29RTXA2b3EyTDByZUt4b280U2Q3aFJuUWVy?=
 =?utf-8?B?QmhGM25QR3VFZjBzUlQ4azdaWmJwbGRHemY3ZWZlMEQwbERzV25zMFVqUUoz?=
 =?utf-8?B?NFlHallaNXlVOTZ4OWFoSzJwQS8rdHRXMzNOdWViQXVOQXgxRFRaVW9nMC9m?=
 =?utf-8?B?aUt6V1BXQ2VPeDQ5Wng3MkZnQ0Vrb2NVUy9DSjE0bDNDSnErZ05kdSs5YkFi?=
 =?utf-8?B?cjdaTWZlNVFLVnp1R0c3d2Jzdmdlek45a1drSE56TE9SUGZMeGNOVzRNMExE?=
 =?utf-8?B?cXE1aUd3d3ZsQ2F0WDB6SnFjNWRaOEZmaG1ZeUFSVSt6L3c5SmJKUEg3UEZW?=
 =?utf-8?B?aklUdjd4ZGRwWHRURlpuc1ZJMG1uZGFrM1Y4dFFFOU9kZnVTZm9aajFRK0sr?=
 =?utf-8?B?TUE1WTUzZVdKUnU1Z1B5MlBVektCN2VsRFFuTHZjNVgxYWhoT2xVc0ZDYnFF?=
 =?utf-8?B?elBBUDNaOUt5Vkx5YzlLZXVpU3pCT0dPNEhJS2ZUSDVzR2phNWtyOXUwMVZG?=
 =?utf-8?B?RE1CZDZvUG5tYUw3RWtwa3N1dkE5OWFhL2R0UUdWUTdrc2hmYjdxVzZpUE9D?=
 =?utf-8?B?akJMVUVHN0U3VE83MnB5dmJlVnJGZHd1Y1VyVFltaUZ2d1RRdjdkbmZjR1RF?=
 =?utf-8?B?SWw5bUI1ZldEMGdnK3dXSGcyRFN2TGxKRVFmR2Z1bVRBWUZQck5FdFp2UGs3?=
 =?utf-8?Q?R7NuKim5R+wgMfZ9kR929Tzxf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cdb64c-bb1f-4b6c-de3e-08dbb9f2238d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 15:56:24.1896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZTUTPBwa0Uc6H7firw/vdmRLH0h4UlawN8jt8e6Ki5apFzeL1yODOLFqGnJL9ft0YXysyrl7JHPBx8y+c/L1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4872
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 5:08 PM, Tony Luck wrote:
> This is the core functionality to track CMCI storms at the
> machine check bank granularity. Subsequent patches will add
> the vendor specific hooks to supply input to the storm
> detection and take actions on the start/end of a storm.
> 
> Maintain a bitmap history for each bank showing whether the bank
> logged an corrected error or not each time it is polled.
> 
> In normal operation the interval between polls of this banks
> determines how far to shift the history. The 64 bit width corresponds
> to about one second.
> 
> When a storm is observed a CPU vendor specific action is taken to reduce
> or stop CMCI from the bank that is the source of the storm.  The bank
> is added to the bitmap of banks for this CPU to poll. The polling rate
> is increased to once per second.  During a storm each bit in the history
> indicates the status of the bank each time it is polled. Thus the history
> covers just over a minute.
> 
> Declare a storm for that bank if the number of corrected interrupts
> seen in that history is above some threshold (defined as 5 in this
> series, could be tuned later if there is data to suggest a better
> value).
> 
> A storm on a bank ends if enough consecutive polls of the bank show
> no corrected errors (defined as 30, may also change). That calls the
> CPU vendor specific function to revert to normal operational mode,
> and changes the polling rate back to the default.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/mce/internal.h |  41 ++++++++++-
>  arch/x86/kernel/cpu/mce/core.c     | 108 ++++++++++++++++++++++++++---
>  2 files changed, 140 insertions(+), 9 deletions(-)
>

I was just thinking, could we put all this code in threshold.c? That is
the place for common thresholding support. And the CMCI storm handling
seems like it'd be part of that.

Thanks,
Yazen
