Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560167C851C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjJML6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjJML6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:58:14 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EC1A9;
        Fri, 13 Oct 2023 04:58:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQxbA2EM7AwylgsbCy0gkViqf61l5UfTblE9wDPUN9/cAOIdKNWEycZVgv5HK9E2GAyXgjtIfvAPq/Q8dzYNz0NtrccYpjg22+s9cqV+viWuCdCUBHZn5BhXGpAp1Y2Nk5XQmM9vsKyn2TCkxTVlCuAsPu5SQOSnvnRuzA5umQR5hVoUTbO3QTOYz1ORQ8FVv7LlRE2V4yBpGt0Tm67i8KQyOQOX8ZIgzKjrH0b6Sd9XjGb1L6G/H7kcJ/pOFLSvjoJviji770q/WTKOoegGVKbsz+Ebton6Lf6gGZ9zXbNWZZF5aHirentHhRiUJCmRCA079WwHGk2znKcnK1hFjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8kvfXkarsZYGJedSBVzfHumboHTiAKcQz1qOgykTic=;
 b=FFMe4AX2FzOTutdBDMRMrzoG1X+kAvYmiw6ayMRPWnurth8v4ZNe3F0v2keTQ47Awd4h6XeaXCm/pZbvpZAKVz1vgsiS2LKkEdDDQ9Os9/lVMYZizpOGRTRmDoYhEItpW4PlnHawEcO6q1KP/msa4QK5KL/UmMdrCK4ytVt9IgZyl/nW9Xuhg9RKjGd8b0J1hbSd8Sk67I9L+INDIMvR2ZfTZshheDB6jACFBWzZYwFvxHxRZTXc2Wes3P4Qs2ZziuDECu3ZWWGbXcCF8Sfw4O7REFHfbTJhTrLIanqMINzNlG2qjhjqZypyVxZbVNxENgRf2jpFPNWLNhPdGvZOCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KULeuven.onmicrosoft.com; s=selector2-KULeuven-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8kvfXkarsZYGJedSBVzfHumboHTiAKcQz1qOgykTic=;
 b=CocSEFVPuIr7Z7JJONrJGL/zWtcjJs+/iEvy8sSeoH49e6FA5Klye827YhVPxoptojgn4YABu21/+z0MBbvYkVIISJJOu7WekMFEXu8W7ihJx8H5mw9XmZeFs8VqjgtZg2mMHVuH8xiIYCBM/qHFx7uekyFV7+W/gvTSjUsn644=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from DB4PR08MB9334.eurprd08.prod.outlook.com (2603:10a6:10:3f5::20)
 by GV1PR08MB8744.eurprd08.prod.outlook.com (2603:10a6:150:3d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 11:58:06 +0000
Received: from DB4PR08MB9334.eurprd08.prod.outlook.com
 ([fe80::f21b:70b2:5484:6a31]) by DB4PR08MB9334.eurprd08.prod.outlook.com
 ([fe80::f21b:70b2:5484:6a31%6]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 11:58:06 +0000
Message-ID: <8ee33b07-8636-4060-bf60-a5f6d3384b41@kuleuven.be>
Date:   Fri, 13 Oct 2023 13:58:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/13] selftests/sgx: Fix compilation errors
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        "Huang, Kai" <kai.huang@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231005153854.25566-1-jo.vanbulck@cs.kuleuven.be>
 <119aaa2820be5dc58144e74574cfaa7777f79604.camel@intel.com>
 <f2726c67-87f7-409a-9ac2-e845249348cc@cs.kuleuven.be>
 <7e729488e2f841f384b719d0509a4f78f491d477.camel@kernel.org>
 <4124e803b340fc23e74fc5afe1343b1a7940c82f.camel@kernel.org>
From:   Jo Van Bulck <jo.vanbulck@kuleuven.be>
In-Reply-To: <4124e803b340fc23e74fc5afe1343b1a7940c82f.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0091.eurprd05.prod.outlook.com
 (2603:10a6:208:136::31) To DB4PR08MB9334.eurprd08.prod.outlook.com
 (2603:10a6:10:3f5::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR08MB9334:EE_|GV1PR08MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: eb3e21df-8638-4855-980a-08dbcbe3a937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQ4D5P65cKk9LFHBCoz5w45QZ+t0zLcMd7Vc4Vca0Q3LYhnKqVxzuLUdVOPkA0PMNssufh5XhvBFjvtv79hlKEHpfgacd5PUDCstvP3I/aiNJ4uRnWNk+HAaEs8K3OEogNaI7ZRL2BGTH5QvIA+c1SSEd9wCbS4vHunquADgSkEIXv7KE4SCrVcYnKnBYFemNitH7+bdicYpY0OZR0/MOCdQxzdHA0C2q7LVPfIwbC4yD0sVPzoNZxb8skrT3LZGZYtpfOT5gzLrgX5PpV4Uk8r44nBG11IdOZasRWx4JTI29z0tSO6NBrKGP/J5KkNm5WPbZufg2Z/0WbMXgL8v7C10Kwt7yAv3CO916MnfJSMHDcV7omtnerbdTv2E7yvlC+c9rsPNih4C4LHhafI6a90fVc95l7Pb8x4xIT0U5aBymKAfINX5/L8jFR+ryDjztHZfNGUYvFvLsYUqeUAAVh84MpGPeCmR+PwmR2EdZCtPbpNvXLwtpO3OJfvfB0QfaIorV7nPkEnGVCld6PWuFCY3bM6qpx7CvHR5p9pq4YkPeAVDKwuQT+9fPjSsfi4VyjbYTYivNqYw8GFUoO9GAiPdsIF3+DNKWdtxCo1j93dvkTR589HxnAqYqbJCZFMxRhNr6xioVdjaSOJhFcLRVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR08MB9334.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(376002)(136003)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6506007)(36756003)(316002)(83380400001)(786003)(110136005)(66476007)(66946007)(66556008)(53546011)(2616005)(86362001)(38100700002)(6512007)(31686004)(6486002)(31696002)(2906002)(478600001)(6666004)(5660300002)(8936002)(8676002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGxVelQwZUptWUJ3ZmgxVk1zekFUcFBSYW51VUVSNnNuWGJ0R0V6UFdUK0JU?=
 =?utf-8?B?b00wQUFXaUJ3dC9tbmlIOFp4NTh3TFZuS2VrSjkwdHd2Ujg0WllOWEdNK1dX?=
 =?utf-8?B?ZG90YUNDQ3E4TkJZMDZ1UVVXcXV1bjdVV1c3R1QyT3BNUlR5NmNrMDZ1RTE3?=
 =?utf-8?B?SjUvSDhHOGlHSEF4RmhLUnQ5YiswTVJnK0MxQVFkaHFYNGIyZHkyYzcwQnJx?=
 =?utf-8?B?NjdIUDRkR2ttZDVPYi9RSmsvRW9wSS94QkdtVWthRVBYcXBwVUwxSHhXS21J?=
 =?utf-8?B?TzNUMU04QUZyRnUxbGx3WVZ5ZmFMSWtoUFJjYmIxTVB1WGtiWVAxVFVaWEtR?=
 =?utf-8?B?ZXNDckhHUFBYMXRYVDNKS290dzUzMzVOVUtMZDlhbXhkZFhOSzV5VVRab0gx?=
 =?utf-8?B?czRTRHAyNjhwRnhLR1BBOGlQdnpUYlpRTWlsNTFXWitCNmpMcGE1NHRncjUz?=
 =?utf-8?B?RURkSWFNQ21iNDQ0ZmpiVnRYVkhFcUNSa2tzRVZtanFBRlRpZFExNitVdUZ0?=
 =?utf-8?B?Zzdma1FOcjNnNHliU1ZmZ3J3eWdoSDkzWStXRlFDZzJiNDZZOGo5dUdaWmVC?=
 =?utf-8?B?UlZFbHl0ay9VUTZUNm1ybHA0YU5pQkpsT0VjblgzVnJ3c0RjQXhKNzI5NE1T?=
 =?utf-8?B?TFNKV2x3ejcyWVF5UW92N1h3dDBYRXJUeEl5bnEvUzJqS2V4a3QzcUhSdUhr?=
 =?utf-8?B?WFdXTGxpSkhEMC9tQ09DMW1hQXBoUzZTem5OL3dzQ0xRenIraWtFL2YyMjlq?=
 =?utf-8?B?Y1RMbWJNOXgwOUQ5N2Y3YjFld2hvMGNmN0M5azE4Z3Q1U1pycm16RU1zR0I1?=
 =?utf-8?B?eTlES2xkRSs3YS9PU3pTbnBFMGpoalpTWE9KcHgvdkpSNStzVEhwUzBEdFMr?=
 =?utf-8?B?bG1Cc0lNNUdNQ0tnN1lzZGc4Qm1wVDhFZzMzZ3BOMnFhVXZQWUt6LzhhS0gr?=
 =?utf-8?B?QzBxMHVacFRXaXBaMlNaOFRSTmNIY0dQVnRsQll6ZDBQNms1ZmVROTJ4RUY1?=
 =?utf-8?B?Nk1jQXc5NERYZ013dkE2d1FUdldVWXBMZWZDclZQM1RxUEVrQlR6SkJibEQ3?=
 =?utf-8?B?ZTFDSCs2ejdQTmo1UzhVUVZIWDJjc2tUcmJkVkJodEdISWExbFFMUVllV2xM?=
 =?utf-8?B?R3VWMU5iMkZDWHUzU0FEUlZvdWxpek9IekxoN3l2Rm5iNWNKMnFydC9kUGsw?=
 =?utf-8?B?YW4wZG56L0NuVy9WeGxCNGpWblFNV3JQWGxnUDRIMDhBeG1YcWxIek0wRnc5?=
 =?utf-8?B?NS8yYmpDeHoxTk1YellyZWVKVjk3aEpNYzIxcWZVVVlDVmdFT2txbEhmUkpa?=
 =?utf-8?B?ZkVTdFRqZVZGeDlOdEZ1RTUyNS9HRnl3bGZtc056Z29nck15WjdDbHFXUkdp?=
 =?utf-8?B?SGNUZzJFNk5sRlVHSHVUYkt1SXR3OVJyWVZvT3dtU3ZpZUZHVkJFdXZuR3BJ?=
 =?utf-8?B?MFIvSmU1SVlveGpzbVhPamdHdTJUdzE5Y08xK2trWDFhSlNFelAwUjZwbElO?=
 =?utf-8?B?V0Z1VDlBbXF1MkFyZkRjTEhzZS9jTkRiVWs2UnBoQi9NNGk4aVJIM2dXNTdO?=
 =?utf-8?B?V2dCcmxCZUpnYUkxbFpMY0xCTjYvSGRVTndwKzBEdGFuM0N6anM2YmFHRlVy?=
 =?utf-8?B?cTc5d3d4RVp0ZTIrUG5wampSSVNYS29KbDQ3bXlSeGRpcWpRM29YRklTTzAy?=
 =?utf-8?B?V2s1cytFOGV6V3lrQXVZTTM5SDRLVHpkZzQrdDJrU2p6YnVrVkZNSysvcStZ?=
 =?utf-8?B?aTNJVTNmd0xiUmFWLzF5VzJJRzlWQW9UOUR1VkUvVTIzT3VpSHJaRnF1alVv?=
 =?utf-8?B?NVFjbzVlODJIRjR3RjM0MG00N0psUkZYSHBEa3Y5cVhLVCtwV0lra0p4QTZk?=
 =?utf-8?B?RE00NWJmbG9SaTR3aG5nWFVRUGdOUENzM01tSEFmN3ZWUzF3RjdjZit0N2Mx?=
 =?utf-8?B?bzBmMVJvT1VIOHhEd2JhRmdVMnA0c0U2eWFNbzNqcU5pNEs3dDBaNExxbjBJ?=
 =?utf-8?B?RU9EUEpiSjBBRy8wRFRBRUY5M3NSOVlEbVc2T0hJbDlURTFHSUoyUEgyRURk?=
 =?utf-8?B?WUtXQzk4MkJnRGN6NmsrM3ZtMXdZOGduT0VPbzRhQlNmdk1CMllzbUZuR3Rv?=
 =?utf-8?B?RmRVbGtSem1FMmh5UVNnaHZZbVlJUE5aVXMxbXhaSzRhNjlXMGtTRERGczgr?=
 =?utf-8?B?SXQ3OGMzaEZCb0dveEVrK251bjhibzFkMDRSSHNEbHRMUVVXelZoM0VVTnFk?=
 =?utf-8?B?WGkrVVNXZ1kxM1hkK1lPeklOYkVnPT0=?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3e21df-8638-4855-980a-08dbcbe3a937
X-MS-Exchange-CrossTenant-AuthSource: DB4PR08MB9334.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 11:58:06.2339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7RivWj6k7s+PizGcOria13W29/bzWGWxc5zco+nSomgN76ZUmEyp4GA5gBuRuOSLKU4HFCpqTUsuEf1a/u3Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8744
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.10.23 14:11, Jarkko Sakkinen wrote:
> Dave, since there was already sort of talk about detaching this
> code from kernel tree so that Jo could work on "pure C" runtime
> would it make sense to dual-license this first in the kernel tree?
> 
> E.g. Jo could send a patch once this is merged with a new SPDX
> platter and we can then ack that?
> 
> Just a proposal, with the emphasis on minimal amount of work
> required from each party. Also this would help with possible
> (and likely) bug fixes, i.e. minimal friction on fixing the same
> bug.
> 
> Later on of course, we can consider adding "libsgx-dev" as depedency
> similarly as today there's a few dependencies like libelf-dev.
> 
> I'm open for alternative proposals, just throwing something that
> came up mind.

Pitching in here: from my side, I'd also be fine to develop this 
bare-sgx "pure C" runtime under GPLv2 as is.

FWIW, I'd be mostly interested in and see most immediate use cases for 
such a runtime in research purposes (e.g., low-level benchmarking; rapid 
prototyping attacks/defenses; etc) and a copyleft license would be a 
good fit there IMHO.

This is not to say that I'm principally opposed to a more permissive 
(dual) license, especially if there would be a good use case for that.

But it seems to me that it may be non-trivial to build on the existing 
code base and re-license that, whereas GPLv2 would allow to fork 
immediately and also have any overlapping bug fixes seamlessly merged 
back upstream as you pointed out.

Also open to hearing alternative proposals of course!

Best,
Jo
