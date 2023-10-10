Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D545C7C4228
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343827AbjJJVO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjJJVOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:14:55 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB98891;
        Tue, 10 Oct 2023 14:14:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kfw9IKZqItqUpTJ5ljjFItLH4CNQcbL9Wlc3iQkF7UeWXq1BW1hbwcRSevUYgQ4La0WcH23KeGLgaHXaBXgCYo7LtQKYPPysWkG/jSoxZjo1DMULpjjVqo7AH7EML6mLpGzADH1SZhXPz6hQRcIZ02SnoyCwXtvRz3rDgfC9RvLVE36AS+GNFEW/0QlGn0wb1rLUh87458Qc7oIM83NIV9RPB4Kgvhpx2a7TzwG5jiuetnvxsV76Lf5ed/2iyK9NfIjosZHZxpY5oZCUhGCFZ6zlTleBVYudQj7sgv2iElIgRd/+ru4W5xvVOKTb5buQ/iTR6OwGRo00ZbMuZ7XysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zqVy6qaBvfZqZmviXbSKPnZtTemIWWUQVBxmadVpQk=;
 b=SvWMhqHdc70aTbZvQgQBah9b/xg3svmKGPExhUdsr4dP+/Ca3imRkwiEL9uuKZDJJG+efe69EWsx+65zUIHIMInKd963S1qMMe2djh/4s3LesAK3jbB/Rh6xoOmQzvstvC/vNLSuhgZuB+sU6VSFHNHtnopPEo5gIxo+gkwnmBGKJpJLmfRONdQrtKBexjDFzHz0SmZIFQyhrCjWBLED7glSVe89tw/d5tV6P9zIUXAHzW50fugrovkysCV1eldn7JeJ+o5lfyijgSjDhTAXOZv9T5CFgOJa3ML+AQeNMcgZYWclo2PZM9JSCXXScSt5jf9kdV4o8bpvaq5oNGrL+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zqVy6qaBvfZqZmviXbSKPnZtTemIWWUQVBxmadVpQk=;
 b=CK/V3JPqmaJaP1T3Yi5gmHUwKgOQXNFcQKkUj4qkkFCfDmlAC/GdwFvw7KJ3bgysexAW0ftrhgCU1x4XgQ3U4oBxRklvMjhrqi1IJ45KtlN6EWda8F/AjwG3wNQTXzm1qCIBvxXTQhxVGilu5tsv1SIjvJr3rfWitclbwZOQOAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 21:14:50 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::9620:780c:562e:33a1]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::9620:780c:562e:33a1%4]) with mapi id 15.20.6838.033; Tue, 10 Oct 2023
 21:14:50 +0000
Message-ID: <cc75c480-5359-465e-adab-46b418ec5d97@amd.com>
Date:   Tue, 10 Oct 2023 15:14:46 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Deucher <alexdeucher@gmail.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Lei, Jun" <jun.lei@amd.com>,
        "Dhere, Chaitanya" <Chaitanya.Dhere@amd.com>,
        "Zhuo, Qingqing" <qingqing.zhuo@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
        Roman Li <roman.li@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231010124357.5251e100@canb.auug.org.au>
From:   Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20231010124357.5251e100@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0892.namprd03.prod.outlook.com
 (2603:10b6:408:13c::27) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|DM4PR12MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: 313947c4-cb8f-4d56-b03a-08dbc9d5f054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9piZUzbk67KCYSq9r3h0uBu+pNzl5grOoW7PX/+QcEIrXvRbk02juL7r2eWzMA9ALIA7BtGX3Aw7UyPRSF1WTTvgzttS/CzcBoPzR7c8bpbK+x7b6gd5TkQ617/JwCf8D7nKjPvJWcRhaaI7DILflbp0RGywoEpiIBSs0KoaqZ4Mvly8HOZI0yT9pOUv+E+0GgT5Rw9/Wf6gj5ED9BRGrgmvh28aj8vErAXEwp0uu9OBg/oozicFXb3Ss0HappxTXQORfsPNxKO/KmnaIAlExE4aUPQyaYEORrnGBVdvlfK251v4wFYla3nwdY/CRbQr+RPKGOQRwQNJDWte/tS71C2dO4ST+V2d2NGvXuD1GRkYf7EY6lOcC0nCFNZKm1nF15ewqV6kYO8qmatp3RaE0BBUTPmLVZUsLi4D8fvXTcV484Q0vlXVW6CUGK04vD660ysEeZGFWF3NrMY0wYkJHRWBaBEbkX3pXqVybmwLQ/qB3IPXU5QVZ53a/yC+iJix3SCLkXBGxZ9jyRHyZ4bOmiOPXvDh1/Sv2r8IQMu884PzFYZOtFd0CnkB1co4a7srefkOgS/jmPgRJHsWAevsYFlN1HZrCU5UsKcROHKL/CZENARLlIbLI1KEFeLHLsVscE0q3ARgiYg7ZJvGOmUm5Fq+ZD7Wiq93VM5re9ecRyA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB2941.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(31686004)(53546011)(6512007)(31696002)(36756003)(86362001)(38100700002)(921005)(6506007)(26005)(2906002)(83380400001)(2616005)(6666004)(478600001)(6486002)(6636002)(8936002)(8676002)(4326008)(41300700001)(54906003)(5660300002)(66946007)(66556008)(110136005)(66476007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2U2aXpUTTcwKzdPOStKN3hCcmg2cFE4eW5renNjQXdLZE83SXZSWGYyWXBW?=
 =?utf-8?B?QUE2WUpmQnlWcjhHTStzUFFWaTFkdkVxdlZqS0ViUWFUNGFhOFhHek45bllB?=
 =?utf-8?B?eHc5NnFQT3IyQXJ4bHVZRkphTW1YeEExOUtXM29WZUJFRGcwdWRHamp1NSs5?=
 =?utf-8?B?elI2MVIxWVhBQlpBWjUzMGxjUDVFZ1JMRTNjSEdlNHpIVjBrQ2hPdmhLclU4?=
 =?utf-8?B?eU13MEFSMk15dDZQMkF3eFdNSkVHSDdGbGFPTEVwckszUjNBcWcrOTNHaDZN?=
 =?utf-8?B?aGZGVXhuOVY3eDJ6cml2ZFJuQjRNTFlmdldVTEc3UTZvY2xXVFpJdlVRT3Y5?=
 =?utf-8?B?WDBCeEZNT3Y5cU9Ja1R1cnNUTFAvVVlUc0NkVFI4K2VIMk5tVnAwWXd5RE0z?=
 =?utf-8?B?Zm02cTZlZzc0NGtTbHNiNG84SXpZblo3VHgyaVcrZ1BLbGtIQi9Id1p3N3lQ?=
 =?utf-8?B?dUREL2hiS2lJcFFDNHluUDdjaFU0dnorbnBwNzhBdDEzRStiOTB6eEZtVElw?=
 =?utf-8?B?aGZaeXpYMXREbVRPVXlsbFJQcWJCN2ZkTGVISFlzdEc1RUtTSFJKM1duMlR5?=
 =?utf-8?B?bFpkRnFxN0hTWEY0S0R5eTAwL3NabXF0M2NGaDg1S00wODUwdGR2b0V3ek5j?=
 =?utf-8?B?enFEcUVOOEFqT3NPNW9IWjJ0UTBTQS9TL2M2VGdaQXZBaHBLRTAvMHNXaG15?=
 =?utf-8?B?cTR1TjlGeFVVYklQSVVDYi9Nbkc2bUpJWnQrWm01ZElUZDY0Y1I4MjdlUmtH?=
 =?utf-8?B?QzZQQjZLZGs0dVpnWTkwZUdjM0NHTjU5QnVUZURFaDhETm80NEs5MUpIVURp?=
 =?utf-8?B?dE1idEpNMUp6amtNeGR6K2tpd3ZESWRuSWFPelRrazMxeEMvTlF6Ump2Umhr?=
 =?utf-8?B?WjJSOC8weHZvY0o4LzM4ODZMa0pZQVhqVzdBYzNPSlc5YkN2cFVnQTVaZzR6?=
 =?utf-8?B?cjFOMnBzZGRIN1d5VFlCd0RmV2pQamF3eDJlQjdhQURBZWxNSElZYzRRNm5D?=
 =?utf-8?B?dHZzcHE1WjZmclFobnp5T01VMEtEWHRKN3NibkwvVXhGSHE5RDBSbUdkb0Fv?=
 =?utf-8?B?MFJFcXdHclgzK216ZDVIVzJpUStIdXlrWmU2NS9yY1RmVWl6RFJ5MzBnQ3J4?=
 =?utf-8?B?ZFNQbE9wOS9USFFudkYzRCtwZXo5UnpkcGJFakdvUllVSVd5dUkrUHdrVEJB?=
 =?utf-8?B?d1lLNjlIV1hJeW5EYTZVbE11amwwaVI5b1RXZm53QXk3QkNwRmIveWN4bm1X?=
 =?utf-8?B?MFpKVTdjK0xiZStud1hMN3lWMDdEc3hpNFJ1UkpldFRpMXV0SkR6WHkrbUsz?=
 =?utf-8?B?Tmk1cStzLzZXR01ZaERMOE1sRS9ZaXpsVXlzSFRISDlMMEZPSnk2U0dLNWN6?=
 =?utf-8?B?WEY0UHRYb0dIV3RjbTY5UXliQmkvOWpCblJBWjRwOGxJQnV1cUdHcyttWUNx?=
 =?utf-8?B?V2h4U0F0WlVQeTk1ZnFCZUxBb2tIZDQyRkVrdlBwZ3BjcUhRKzN5bEFtdEhM?=
 =?utf-8?B?NU02NXB2WHo4aEFtcEQ4ZE9HS0xLcDVuSzBmdndyZWV5eUd2NXMyclhtVW92?=
 =?utf-8?B?RU1sYmowUmNmYU1wWFVnK2FEOXJsY2hLby9sTUIzL3g3dGVPU2tsSzRWMzQy?=
 =?utf-8?B?cTZuZFYvK1ZkZ2xTSkcxZVg2WE5nL1o4QU9wQ0xjcnlacnBEMzUvUWFTa2Ri?=
 =?utf-8?B?STZFWmI0K05aRURDWkgxZjh1cHYrcUQrc3NuOE5JaW1JS0dmT1ZDcmVWbzgw?=
 =?utf-8?B?aEZIbHFVRnl2bEFVQ1ZRc2hWRklyTVNNdEtHRmppWEVFUXVScU5XT0llUGk0?=
 =?utf-8?B?TXcyZFIwVkVhYWFma0NDcWNqekI4V2g2REtVY1lxRndEamtCdTNqY2Q4dkZi?=
 =?utf-8?B?OVYvRmFaNkhlNXVSTFp2aUlXUEpiaHpqQ3lRVHVKempTQy9aZFR2VC9yWjFP?=
 =?utf-8?B?RlBBRDdNNldxY0hVeXljTm9LRGpGUll5QXpneUhPeDZqYStqSVRsRUlNaE1z?=
 =?utf-8?B?OGsydzJZQzZVaDZsdEUxS2gvK0RyTFR2L0tpVnIzdFNUajZCTFZ3bzM5d1JN?=
 =?utf-8?B?SGc3ajV2U0ljN2RKbE5pUFlFUzFJOVhKSFJJRDVvVTk0RG1iSXNJVkdnZDB2?=
 =?utf-8?Q?RBLceHG/yEOntAlAwUco0skDf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313947c4-cb8f-4d56-b03a-08dbc9d5f054
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 21:14:50.1876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9L+quk5pxwXxqbPlA+heRKi0bU1QkpsckKnZgjPWD54kVCnLZN2+76P2jvPTTl1NjK3sE2TXKmrd2cRJSMI0ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8558
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/23 19:43, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the amdgpu tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c: In function 'dml_core_mode_support':
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:8229:1: error: the frame size of 2736 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>   8229 | } // dml_core_mode_support
>        | ^
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>    7966f319c66d ("drm/amd/display: Introduce DML2")
> 
> (or maybe something later that changed storage size).
> 
> I have used the amdgpu tree from next-20231009 for today.
> 

Hi Stephen,
(+ others)

I think I have a fix for that, but some things are unclear to me. I'm 
only able to see this issue when using allmodconfig. Additionally, when 
I inspected the function, it had a few local variables, not enough to 
explode the stack size fwiu. Is there any option in the allmodconfig 
that makes it easy to see this issue? Maybe something that I'm missing 
in my custom config file? Is it possible that allmodconfig enables some 
option that might increase the stack size? Perhaps the FPU flags from 
GCC include something else in the stack?

Also, for investigating this issue, I'm considering the local variables, 
but as you can see from dml_core_mode_support, it has a few pointers. Am 
I missing something?

P.s.: I was able to fix this issue by splitting two operations from the 
original function.

Thanks
Siqueira
