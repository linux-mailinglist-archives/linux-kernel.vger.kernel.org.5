Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36B07E522E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343756AbjKHIuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbjKHIud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:50:33 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF93D4A;
        Wed,  8 Nov 2023 00:50:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4psnGKtR/muTS6ZlNRA1982Yiyk1fyqui4denLyatzSoS9DYfn0RWBbQcqV+PnowoYOWy5zn9ATK7me+yRS43i3lMjCvkfOXhxvvXi+7NvpZC89ic1K7s1yl1Km/B7zsimtDb/XxdY0p8KbTcOllXx7ic9Meo4o1Ib36+UftYRWerMeA0cgysF6BXSc7PXFl/0ihlzok4zKWQGz2xyBI+rwVwBhHt4WNjNLy2k0mH9SpGOWEYgonNAITqIS4GxNMejPKBenet2TYGUG6rMsk4HXZ8rGO7DD3WBF3QskDvn9TURHeCnTwPR+TuRPAZphFNQCgYL52X4ADDK8z16v9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+SsvbMIjK4bUnIJBrpx0bxLRuOArzLYnDLKS84isyM=;
 b=O5e0Tf9pk1Cx7eeg0cHlXlIu7AZs98sBTo8PmHq5WQkCk/1bSW52dcBGaFttm8wSt5F4+e3UgDcER2gcIrs9I74BvGN4m8i/a3w7YzFCkcCVpdZvfVV8SKdUBd7mLEOLgeGX3H/Mxuf7owBTSwO1D2o2E40JKLXO86tZuTPJEePGPAdNgAZJl0QZhNCwcGWTD1n87FtB8iBu9rWjkrCiiszFLjRMNEJn3+0xYSb9eHwxngN+4b7FOvWzLh7/lKupjMwnZxNzRZI6yBs82pcpI76ABoESxdkZCGWZ6Ty06lGTMNcZnNo7wtRNlox2YSLiP/P1etqY/TapvqdtAPNAcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+SsvbMIjK4bUnIJBrpx0bxLRuOArzLYnDLKS84isyM=;
 b=qKCfBNYT5AygjIC6FCpnmXD/a6L/Z2GFRSIPFEw6ve34aSK6WZO3FeLP+WIOdq3nuQABq5xytGI9qlTjrf60JNwzVtIpXpOKx8wfxkjLaOx9MevOTjMpuGOMXQokBtxg9NmJu6wQgMwDS8epDLLVqwr1UqB9jNYzrteIbsca4zg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by PR3PR08MB5657.eurprd08.prod.outlook.com (2603:10a6:102:87::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 08:50:28 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::87b4:3635:b89d:c07c]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::87b4:3635:b89d:c07c%7]) with mapi id 15.20.6954.027; Wed, 8 Nov 2023
 08:50:28 +0000
Message-ID: <2afa69d0-93f6-4033-ad87-c3bf01588ba9@wolfvision.net>
Date:   Wed, 8 Nov 2023 09:50:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] media: rockchip: Add a driver for Rockchip's
 camera interface
Content-Language: en-US
To:     Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, paul.kocialkowski@bootlin.com
References: <cover.1698666612.git.mehdi.djait@bootlin.com>
 <f7367726eb077d43446c83591ecbf9acbc77ef5f.1698666612.git.mehdi.djait@bootlin.com>
 <6f98b471-b139-4043-a8ab-e7a9f9608d60@wolfvision.net>
 <ZUSt5GC4lALz/fq5@pc-70.home>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <ZUSt5GC4lALz/fq5@pc-70.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0228.eurprd08.prod.outlook.com
 (2603:10a6:802:15::37) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|PR3PR08MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: 08751431-dd0d-4bd8-e27a-08dbe037c1da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tOFfI+k+++amUAeM3lUKa98/dZgQZXHFkc+jCB5lN4k/BZfuFyQoQQ4a83/QZ2q7evzZwRTUlh1KOVMOt+q9TH2MNEoiqY+FZqZZNQmPBgfe5UT/9DIuBk9Ltu9X2bvBhVEkywHm8wjVI9S7aND8WdCzd8w96y8krIx/Rp4EFeh78QB2HUggFydul1rdpnNH+RNoQtzCVnZrjrG0YJzrpcczmoOR3m3Fo3AybgJuIu/rUGHtR7Mo1BRkCZsod/JbELxcQpxj6tamHc44CzbA1/Ja2u7v7w/SmH+U6XCdgxL36/zz5gI265Edmd+HN0AoJNGX6Vu7945C4kmN22CKdl23SEg4A604QGeaBaXoAGgT9ZM3foTrLz1cz8JC++0nEstk/bwkP+BsI/5zFIv+e5XOfHZV6Xlz+i2dIntdPD/r6XI8nIwXfAoAPYbFpXvuvHxhqokSy0zYhS48I35pWM3Gh5Ffgdrctp56Mz4Ghdrkigzsd3up9/nDRWeGSUEb/o/bLQnzNyzWF7oGpPCMFPt0pRPeyJJJPagGaHpncEjAh09r51rJEZpvBeKVvruT62wX6SdBecxwaAmnkQdZij8S/wDgM4C+gNKRjonVuS3EpFDGNCSh6tUxB1u6eQHIOPhN8ayxkavuPMYAKE0gVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39850400004)(396003)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(26005)(2906002)(83380400001)(41300700001)(38100700002)(8936002)(6666004)(478600001)(4326008)(8676002)(6486002)(86362001)(44832011)(36916002)(53546011)(6506007)(66946007)(66556008)(66476007)(6916009)(7416002)(2616005)(5660300002)(6512007)(31696002)(316002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlY2ZHYrVUZGMEkwSjJmTGhGZFlVUWZMY3dIaEh4SHFpNDVMcUZFSGYwQnJZ?=
 =?utf-8?B?WEdOSUtJVFVkaUVYL3BMcXA3VFNqaWpLV1dtQ3I0RTU4b3JldjVzNy9MNVdG?=
 =?utf-8?B?RmJ3T3Npb2ZIZXQ0a0NjeE9FQ1B6bUZXR2crUmNaQ1hGc2RyQmRnekVBbVZS?=
 =?utf-8?B?cXpjZ2o2UTgwaTdNYTc5bzU4TG1oZlFndS82bEhpbGp3RVdzVDgzZUdVdkdl?=
 =?utf-8?B?bGExRHpESmZPRHVERkZYQnJiM1hOUVhrWEU1a1lhWG91ZE5mbEd3c29VbGZn?=
 =?utf-8?B?ejBnREpRMFptdkNPR1NZTjFTV0pEUW9VbUhldlFUQzVBZWMrdTZERk9aRzRS?=
 =?utf-8?B?eGhWSWhBZ0hiN2hBQUpPek1rcU4yQ1VuWGRxT2owZ0hNNUNCa0dwdWZ1a3Vy?=
 =?utf-8?B?VlVhMnB6VHppWmwwYlEwLzRRVmRJL2U3Q2dnYkNhQWNCbFkzQm9FTjF6cldZ?=
 =?utf-8?B?Ty9kNThQazNLU09TT25zMUhnVUl1TW15ZVJuL1NjbmtkTzJoY095MjdkaEJB?=
 =?utf-8?B?UU0zbU56Z0lYZWEyeTA0NG44UDcxZFI1d0dvK29KYVFFQ2J1L1FKRkNwN1c4?=
 =?utf-8?B?Z0JPY1RMUXQrTGpGVm1DMjFnckZQaStlNWFmempmMDFWNlRaTXg4bEJpNnpV?=
 =?utf-8?B?VkFRY0Y5OHA0UlQzV2pkQnptUzFBdk8xNFp1dUh1dk9SU2plMmJaSTlwU1RW?=
 =?utf-8?B?Tk4wZVYyK1BxcGNuN2k3RllwMmR6UGtLdE5zcjlEMTgySG8rTW5KUHBSaU1v?=
 =?utf-8?B?WGZrNld2b2xYM0VLME9ySTNPMW8rS0ZGbktBY1pkTzNnTzVrbjZ1UmsrYkx6?=
 =?utf-8?B?VUM4NmRaeUhkdFp6R09rMGlYZ1dDMlNxN3Fwc3cyZE8wSmh6ZTdSQjFpVVNG?=
 =?utf-8?B?ZlBJajRWdXEvbmFJVnRvb0ZKM2tseWpvQzdKUVhsREMxckZTNUhjaWVBUG9r?=
 =?utf-8?B?NCs0dHZUMnpyRTN3WlprSWhtZ3RXVHlQSVNEZkFiQ0tJR1RrKzlIRWhFZ3F4?=
 =?utf-8?B?TEtpUEFjclZnVnlEQ2dGR0tPRCtoVkU4emtqd0hicWFKVTZzVE5Db0piMG5N?=
 =?utf-8?B?Tkt6QnF6dWxNS3M2UkZhZHZYSEpvam9jVjltQlNMQjYwZTB3QTJSMDU3TEtD?=
 =?utf-8?B?cHRTVzVuaEZOQW5CcGpFaEZFZ2E3QThZbys1RG9HcmpSUlRLVnBIcGJlRWc4?=
 =?utf-8?B?dklKV083aklLQUdCdDBqeFpCMTR4dzc3L3lNSWN4WEg3K3NlckZ6WkhGbTBa?=
 =?utf-8?B?UE5yS2lqekc1TTh3MkVkU2loZEdkNkJUTTJla2FIZFNLdEVPaFJEOUhLdmhW?=
 =?utf-8?B?bW5XY2ZBalNxbXhMNFB2b2pBKzZlKzN2OFMvUEgxM1NPY2JoaFdRWWdzM29J?=
 =?utf-8?B?Rmc2VTRsWnJNUnY0NjNEVEVJZUhCS2hlRzFKeXNqZFJVNG5UaC92Zk8xWHhG?=
 =?utf-8?B?Z3RIbURuUW15TXdoUXBwR0FVWUlBVjVmN2tPVmY5V3JidjJuc0xGMks1RmJ6?=
 =?utf-8?B?TWZmdVlIWjJZYW9EeUMrdHZ6d1BpL2lZTHRpeVRBRUFQMTZqRlBRSzJ4YXM5?=
 =?utf-8?B?ak9ZRTZocytGekdkNE5LM0ZhZGhhZzczME13SHZjdkpsR0JJMWxEdVBNZ3hz?=
 =?utf-8?B?eVAwNHd4NzRQVi9mSldjUE5ZdnM1ZStoQUVWRVN5RVFScEk0eXVhTUJBbDVX?=
 =?utf-8?B?NEoyNU01NG40cmZ6aGNIKzJKNXJhUlFKQ09GdlpFNFRScGsrVGhJYkIrOXFK?=
 =?utf-8?B?NTFycjg1YVpIVVdsNnhLSGR0MDRlSGtHSWl6dEJUVHAvN1lJYmVvN0I0UHdK?=
 =?utf-8?B?dnhJUnNXNHlJU0ZOZGZycERyMUQxbzdCREE2OW9PMUJUTXZyeG40SlZXUGZE?=
 =?utf-8?B?LzR6TDY5eXhFS3VwQ0R5Wld4Ylp1RTJPMWh2eGJPajBhQm1wNzVOa2poL2No?=
 =?utf-8?B?am5yclI4ckxrRXpta1Zqdk9YRVBrZTdPSC9DWmpBUEtlU00xNmU4RHl5TEE2?=
 =?utf-8?B?UFRJLzlaNzZ2cDFlOCtsQno0TlJtTVc5aDZqWGx3aVhmU3BUV0g5Z0ZyejI4?=
 =?utf-8?B?ZTdzdkdkelNleW9nb0t5emZoZUNCcDQ0cEFPVEpQMXI4d3FxZWNmeklrN3l3?=
 =?utf-8?B?SlplanBzL3hLQmlLMzQvVUFlcTVReitpMjZKazQvbkFxK2tWWVlXcHJNdjY2?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 08751431-dd0d-4bd8-e27a-08dbe037c1da
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 08:50:28.4883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWqbQWRoCNmZahBG8Qvcazfvtq3oCT/ADa2/AZAKyxLymAtvvbqXWmrRdMD8gqIamB6xs9Qbqj+KcScvPK3ABAX1p2hyOYhHtTKyFjH50I4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5657
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehdi,

On 11/3/23 09:23, Mehdi Djait wrote:
> Hello Michael,
> 
> On Tue, Oct 31, 2023 at 11:23:17PM +0100, Michael Riesch wrote:
>> Hi Mehdi,
>>
>> Thanks for your work! Please find a few comments inline:
>>
> 
> thank you for the comments! 
> 
> Have you been able to test this driver ? That would be really nice.

I applied your patches and added some modifications (= crude hacks) on
top of them to bring up the RK3568 VICAP (note that I don't have any
PX30 hardware). This setup is not yet able to capture the input stream
(from a HDMI receiver chip), but I am on it.

One question popped up: to get the cif driver to probe with my device
tree I had to request the IRQ with IRQF_SHARED. This is due to the
approach that the CIF block has one IRQ but is represented by two
drivers: the cif driver and the rockchip-iommu driver.

Subsequently I was surprised that you are not using the MMU at all,
although the PX30 VIP features one. Is there any particular reason for that?

Can we request the IRQ with IRQF_SHARED anyway?

Thanks and best regards,
Michael
