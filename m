Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B779F811806
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442434AbjLMPqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442659AbjLMPqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:46:31 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B4AB3;
        Wed, 13 Dec 2023 07:46:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ci/4DvIMV52397/877wFTcUh9CuQEHyjnNSElCyiwIB/W4r96ID4RgBlEM2+ZYcZT/TcPfdpi5iqtbRUso9T4bgyFnzWF08kCoUtGyb91VwFTANF7JjFLmrBdduGQ/b1mBnskQCYm5QableIHSYcIBpHUlmkt8v0L3eYnlWemU4woXzrijIhZPHhWDiYtEHAhz86tFk7q4uWYligxnZMF1GACCfJKMsG6OQt2FSBrujOemf0xwQYyvUNFJHC0KE4qdp+MKb0DlkPttYQ9bktAlFFkBbD9AHyMXYohEtOjYg1shulDanQJSbDOKM023/c9epHYse5A79xFKO7XOpSqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzmd5lM8S4lnWpdhRDpitGyiOg4JtEysBYo5DefCXf4=;
 b=F7bBgw6ccMZ7j0Syk0kiDjBHe0UVdb3Mmhyz2DwrmyfptsIYmQs7/TUPdBv9Abj4KhPw9/y2LQGcYtL4/ljB44xl6bJJO8PBU1FIS4y4Z3GLDJNDm0JQjWS5r633aswCEtY8akHYomf+ma9U3znOAeGiEuO3h4bNDMje8OqgpYkTQKDO6jDsvz4ojlr6CCqQutGd+sODHemWhmhGZl/CtHugUCHFn/Gx1KJyBcy5paVn7fE/0YpQpNOyMvjaTol/7SowV7RQznGuB7ExE3/4Fs6EjykRP7qiwWEMca04nVxkufylkTHQY31H1eak1kC9jVlmkLaWozsQiPms0oJXsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzmd5lM8S4lnWpdhRDpitGyiOg4JtEysBYo5DefCXf4=;
 b=GXV4EVqhPudVHtyWuJh1RW/eG+Hu9LFmLnAiIApw5VwdHAkaviMktGZcAX9uSDCMW7SJ0gUSjm3j44gleF/KcuLaEbQEGRbeYtoVP8sdbBhbgF8PS3heMsLbv788ATb8him1Hn1oXYrJ5PFPzW2GaaXWOMh8vkFsOgdvF0lEDME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 15:46:34 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 15:46:34 +0000
Message-ID: <ff1a121c-e674-47a5-8187-52135fbf404f@amd.com>
Date:   Wed, 13 Dec 2023 16:46:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm64: zynqmp: Align fixed-clock nodes for kv260
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Andrew Davis <afd@ti.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1701338352.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cover.1701338352.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0115.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::44) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9bd28f-3169-4ce1-6b0f-08dbfbf2aee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ryiy11xd75loaGk/MXLhSkoluYjKNHDGjM0vkzMNhsq5WKPy2oeJJbtH1ybDwlRzIfmTcCWznbhyQ1Dl4bxD8oFGey3mqw6F9cvys80YYKXQHoyZEY12Tdkf+6x1N1lWoLJ1nQTePKJl1ZQr9TkXKmZa08PGd1un8WRQxn204MUozC0ZNmyJhbhvuJK0i0kCw5csS4qcq1iFWYRzQsYWkNazhUj32eVYXNSAzuw6MVLv7FQXM/vu+VFdN338vL8hkNRx128W8f737/27O46Olu3FZMWDF1wsf7O4/KJFAQPy84t3N+IrYKg0veQVJDFDDlARh053+qco4O4NsNB4YF5Qhl/mCK8baFYUW/HD9LkKbhSL+RPjcKzrkeSPkVcGcjFgz+BYdeDBtLuSaAp6oB8O3nNPeyoVyLu6X6y1Enj7yMgWuztqnaOkEq3KFIDEjXgCIrOVhX9IycADLqwJO6CmX3BJBwwsO85khJMh4+nL5c6GwuT3zlURbvC06kfbWkU9thdO2JxtS3uQoIqdBPjWabMi109cIXUe1jg+sCvpeHzZju+8TY9dnlJ/LYomL+oUMw0XxXoX+dre9AgU9nKoOBAii2SsXIUHyhXMKsCv1McnJ2hXdu1e9w+055ETeS+hFueChMV+0vC51hwVkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(66556008)(66946007)(36756003)(31696002)(86362001)(66476007)(38100700002)(6512007)(83380400001)(53546011)(2616005)(44832011)(6506007)(6486002)(6666004)(4744005)(2906002)(7416002)(54906003)(316002)(478600001)(5660300002)(26005)(4326008)(8936002)(41300700001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFJoZ3M5QnVXYWdtL2Y5ZDJkZVNDRk03R04rWDNZNE1JQmZMN05ScjJYZ0hZ?=
 =?utf-8?B?TEx5ekUxcUNRZW5qc2xiOUd4a0c4WDhONkVvekRXSEZNYVN6Ym5wTmpwTkxq?=
 =?utf-8?B?TnBjRFdDRkcraEt5MEZOa3J3V1ZlQzJMRm5jcitvRFo2Q0psMldwL1YxZDlt?=
 =?utf-8?B?aXVlVVZ0bDJpVGxxQndWNzdlNXZ3UWpiRUVGWURSU205RUsyc3J5RzVLbFVG?=
 =?utf-8?B?K0hqaWxZZHNkd0lkZ0taeVI5cklBNU04a1RkSUN6YjdqVGMwa1NQdzlZeVE0?=
 =?utf-8?B?aWYyeFM1VkJGZGNnVEh6YURBMFJteXI5TC9YTFlXMTNRSEFMY1Ftb24rUjc3?=
 =?utf-8?B?RTZtb1RxNXRlRVExL2s0TlNsZWdQVUtlOGdaTWtiWVJuRUsvOVNLSTdZbTRo?=
 =?utf-8?B?U2IraHhsOWppTmhBWmJSZk5tQmZxZzYxeHhxRUZRWDhDR2hZODhlOTFRMWJi?=
 =?utf-8?B?cHArb1Q0YVhQbmt4dHdDZkREdVBobVo5N0JTS0xsRm9vSDczNHBNZ0piczJY?=
 =?utf-8?B?UW11ZEpFakhIcjVnTkxIZ1VUdURJMFNNeGh3NVJBZnl3dmhKUnRXZS9ONmNi?=
 =?utf-8?B?ckxnTWRvaXBCWTdjYlcvNE5PdEkyRDhLRGJGSEtCSzlWcElIN1Z0V3F0K29T?=
 =?utf-8?B?K3BFR1REdHBHSUlib29OM1lWZDdPUngxek5wVHZDaEpOMEpRVmkzMlY2cGh2?=
 =?utf-8?B?dkt0bXhQOXlTQllLYllwUVc0b1U5U3ZKckZNTWRCMjN0ZjVPWXczOTl4MnlK?=
 =?utf-8?B?QXA0TzVWMFgwRXZzVHUvR1BrbzFCZXk1KzIraGRJWDREanFtMGZIWTdqWTdW?=
 =?utf-8?B?VnpoSkloN1hicjhiMlU2WGp0WUJNSnRsa2UxZHVsU2xhMHdILzk4U0xsTmZ4?=
 =?utf-8?B?OWtTZGNNUUVtbGZpYktTd1hacXkwdGdpam5aRjI4WlBPSVBXQVhKK2V5cUZZ?=
 =?utf-8?B?Szc5SFo5eUdGeW1GQzU2L0VpRDJRM2s3b1hoTVpBU21EYlVTNUkyak1LWUJo?=
 =?utf-8?B?RFE5Rjg3NmIramNtNTRnOHh5TFlnb0g2N2RnNjR6RS9GMWtZcEtTWW5aek1B?=
 =?utf-8?B?SitsZG5iNHFveG1vcnhhK05wQVpFUzRuWllESGNNSWhxSFZGTVFrTnlxU2xF?=
 =?utf-8?B?bFJUYkFGeEhkMUROR0FBbFV6NHAzbGRPbktSUHRLTEZCYisyazJwSHRtR1FR?=
 =?utf-8?B?SkNOWThldHBOcnlmWmIzbWNMVGpQSE41aWMwYkZmUC90SFdzV1ZSbzFDUzdD?=
 =?utf-8?B?TlZlOGYraFFKa3VScU9WUjlJSWROMVg2YjlTb29URDB5NCtrZWxjYjFSM09Z?=
 =?utf-8?B?YUFOczRjTytsTnZNd2V1RDN6SnlZdDdlQXd1WE9xOUd6ZnJBRURiODFBeXdU?=
 =?utf-8?B?SWhyb2lWRytpWkZ1a1puUEJ2K25ldEJ6bytUcTVkbVE2UTlmWGFHRTRKSy9H?=
 =?utf-8?B?andESWJQbm9QU0pweUJ1RURNVXh4bjZHV3huZDlMc1FHYzdZbUtSWm5tOGI4?=
 =?utf-8?B?Y2FlV2RrbWIxaFJZSDRvdCtTVTNFc3R3YnFQbTRBWU0vMVJlNUtYOG92SmE1?=
 =?utf-8?B?UTk0UUpzNUdaLzFrTkM4alFtcXoraUNaUUM1aGF3YUg4OFhPRWRVR3FYd1lU?=
 =?utf-8?B?QUtmZmN2WkFOTzdLUkZGNlpROWhoMnBKQ0RyK0RrZzNHRVIzdkVnZ2VtaHlu?=
 =?utf-8?B?QzdTUm1Ybk1uc3gxbWtGZDdrT0tWK0tsMkZvdmlBTlJxR2hUZC85dmRwMkt4?=
 =?utf-8?B?clZTNVhxeThOYmkweVVJVjJ2WnJBQkVGOW53V1pNNFdzVzZ3SFBYMldWenU1?=
 =?utf-8?B?dzMwTzlLczdkZU52VkVLM3Nzazd0SVlmb09DTERmN3ZlSnZvWllIekVNVUVW?=
 =?utf-8?B?NDg2eGlEOXJsZXF0L0dUM0h5YVN0azY1MnVGNXZaakJmZUNWN2dKb2RxSXNV?=
 =?utf-8?B?M2xMSmF5aG5BbUNiTExJV3pnTzJBNWszdENOQXMxRGQ1N0Rxc3FXNSs3aTQ1?=
 =?utf-8?B?UFRIUzJiZWpPb25FTmVFK1VhdWV2Q09Ha1dpNnVlYVdaQ0puNEdsdGZjSWg2?=
 =?utf-8?B?WVo3cHZoblB6eW1STU83Q211MGt5clNXOWQxL1BGK0tOYU01bUNhRVU0VGpN?=
 =?utf-8?Q?INRvbjURRJpYVTUhCZ6yh4zmy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9bd28f-3169-4ce1-6b0f-08dbfbf2aee8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 15:46:34.0868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BIIXB7dThe+44eE2G7oq2WDNoSsv7h91B+yBXHOxn+hXNAt28nT+Gg6+eg69BsD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/23 10:59, Michal Simek wrote:
> Hi,
> 
> these two patches are moving clock nodes out of bus because they don't have
> reg property and also align node names.
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (2):
>    arm64: zynqmp: Move fixed clock to / for kv260
>    arm64: zynqmp: Fix clock node name in kv260 cards
> 
>   .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 40 +++++++++---------
>   .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 42 +++++++++----------
>   2 files changed, 41 insertions(+), 41 deletions(-)
> 

Applied.
M
