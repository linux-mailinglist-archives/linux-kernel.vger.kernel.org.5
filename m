Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640A7773DD5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjHHQXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjHHQVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:21:43 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CEC9ECA;
        Tue,  8 Aug 2023 08:49:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXW8fvCH4PHmgS0Zn99hmsy2WvnQXOV1vF6GlBT5ne5oDM7sR+41UHNXTG508t9PCBHfbNyk+6Hp+iOZWE/ljhbccy04uQd8mGtpxtccCfkX7j09bgn8fKXGJIapDiTkXrb0ZPQUl023YiwOYFNAv9/PHamAf2ePu7fRi0Du8tlAnCbB1n1RM+0qIg1DP2tc+iECinUhn1z14BlQhP5lg2aj+vdRKIj1Q1L/sI5vbfA/fSZFznttLX0CBGR7QoQjfmOj44DaRzmZblo4UiV7GgW1OIIVt5JYiLKPwd29Qb/azQY9pycPY9rok6P2nV685OYotfB4R9bMSRPTyH2GJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgIycTEylHJQdw5nLMHfBAca4og0jNO4V8TBhBhEm+0=;
 b=Bx53x0NsgFkUD1QfTyG268D1oFYwNt2l6pxckAfFTKkk16M4ZeEIQgpvYhZ1at3kuXY5wwRssP7dN0zn9Yy+sohLwJ1zJwdUQS6mq+1F0BnNjalYNz19UbbH+i+MFRT59K1ZoPcyr6Go1rFEoX7yvDyqslVajvceOkJ90158NcbXz1Ee50NdIP80sy9PI5m3NAcxpNDoHx+crSS/HSLVsKJ92glaDu+u89AL/tx22qKpfdU3kqSu3ECEQVDQaaxdr2uMBqA82E3TwzBbSDxAb0sUhnMnwVQ8J2eBxbM8LFDpRlueQ85/v3Do5mD7ewteRoRL/tKwohevXng35uGHQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgIycTEylHJQdw5nLMHfBAca4og0jNO4V8TBhBhEm+0=;
 b=A50alJ//Dz5Pf1d37hfftcrhQNRNAP7M9Pd5eETajAraM/xYELE7kOkKO98c+qbcqoL4BY8oKncACDONxTCTPnIketbnBmfxVwMQNSjW0S4WGyNnOegTYf9QH67NPyXjcIz+p1ETuS7pRfIONEa2qoVbgynhMzWMyMMzXb3gsTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by PH0PR12MB5401.namprd12.prod.outlook.com (2603:10b6:510:d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 14:28:52 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 14:28:52 +0000
Message-ID: <a62282e0-3784-4d96-b632-fdd6d2627ca3@amd.com>
Date:   Tue, 8 Aug 2023 10:28:51 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        linux-edac@vger.kernel.org, hdegoede@redhat.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        avadhut.naik@amd.com
Subject: Re: [PATCH 1/2] platform/x86/amd: Introduce AMD Address Translation
 Library
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
References: <20230802185504.606855-1-yazen.ghannam@amd.com>
 <20230802185504.606855-2-yazen.ghannam@amd.com>
 <58934edf-4fad-48e0-bc5d-62712b11e607@amd.com>
 <894b3737-1a0a-4139-9c73-686a95481795@amd.com>
 <B3BE6B56-FBAB-4878-A45D-E95AFAC86AB1@alien8.de>
 <f989cd56-a066-409a-8d82-40d0bc6ff89b@amd.com>
 <20230808142007.GCZNJPFy8PqTJgTAN5@fat_crate.local>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230808142007.GCZNJPFy8PqTJgTAN5@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN7PR06CA0047.namprd06.prod.outlook.com
 (2603:10b6:408:34::24) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|PH0PR12MB5401:EE_
X-MS-Office365-Filtering-Correlation-Id: 9265ab5a-ef91-4816-4c9d-08db981bc9bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: grfM7DCE9DUWrs0ViZxic+hKdpLjDKvVXi2XL5UrhpCR4LHVmgv43ffqrfD4/yvB0LJxTiaiYTqBqP6d3i5mObTvY6D0Sp7wQrTYyuSiGd2B4nt+TLcp96SM/KqlVuX2mmMihF/GqAAlYy1YSzxMjHMiMf/CZ65RT+BJsx/kN9x8IDPo041/0LCOIPdpYaCkzEzbPFVrNzaozuSn2Hm7095JE4jXqAZXCy01vWrC0/PjafnRosqh3yefqpFiRDaNeHNlmA4ogUfhCzaihMY3wQ/ooLVcGZsrWMdaV6zc4VTdb/cAw3WxbnwagQe1miNEVDR2FE8ttIB/jJz7QtaumL56c9rzEGXVSMJvS0/dcvU9bzyHBHfYa8gis+81OLdM60Yn0DFuoWc23+Kius+vs21BLVfaaanS6x6Ig12XIFf+zlknSSKleRmnZM0j9XSilmStBELy9OIGwm42R4wahn/mgadBZkSBHidl4syhTJGHVWk4/bqd3dMmsR1TZdClrwn3KISjv/4dGt619coku8IOL0mgoZaGrF56H+2XeBAsxTcrbievHW5Jdpc1wH4VbaTJN/qxFYAUZGh1I14kwcYAbencz5D/i7RXxnhRCWMVL0rUFarAIO0FNvzLen6qKMN6GbsN4Y4M2/jCXFsdUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199021)(186006)(1800799003)(8936002)(44832011)(8676002)(5660300002)(6916009)(4326008)(41300700001)(316002)(86362001)(83380400001)(31696002)(2906002)(4744005)(6486002)(6512007)(2616005)(53546011)(26005)(6506007)(36756003)(66476007)(66556008)(66946007)(478600001)(31686004)(54906003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFY5YWZoWTRNL2NNQmRzNkRGYUljNU9tQnU3WEpxNDZQL3BsWVFUdGlSQmpO?=
 =?utf-8?B?ZGVmV3VLUUFGbzV5OXNERmIwRlpCRFlsbXpZaVJaNlJUb3lraDlZNVg3eEFo?=
 =?utf-8?B?aktON29BbVBwNXRERytiL1BON24rY3FwOHVrWUFsNk9WZmxhK3lKYktnRGUw?=
 =?utf-8?B?a2tiTzQ4OTlNL1p1L0dJV0ZYQlYwMWVaM2dOUjYyT0RmYjY4YUF2dWVwYW93?=
 =?utf-8?B?RUtkVDZ1S0VIY0xkYjUzbHY0SFlEWkE5TVlqVGJTendhdDBqdXcxQ1lHUlFR?=
 =?utf-8?B?YmJOaitpdUpOSysvOTJ2T1kwRGZCbUw0QUhNOUxqUW41cERDVWZLSTA1Y1dy?=
 =?utf-8?B?ZkJJQzlIL2k0YVJnQkYrR3BkVUhzZG5ySWtvSm5tTzg4V3Vad2hFNHQxRHF5?=
 =?utf-8?B?bDlxbkNPRzdwb09rdlFBQ1ZMdWJaSzlGM09kUEhRb2M2QTdXeFVGcEdOTWc4?=
 =?utf-8?B?YmxJSU55SzVIUkFSWEhKK21GbUZ1TGJ3UTRhejBzVUQxcnpzbTRPM1pKbkFi?=
 =?utf-8?B?T0JhcW5tV2oydmFQUUtRaWlJUEpGVGtqRk01SElJWUtiSm1JRzl2Vm9iQkhJ?=
 =?utf-8?B?eTFQNU1XdCt1TXhCUllFTHdrZG81ck14Tm1jSVQrd1VBTzUrWVpsN3FrbWVa?=
 =?utf-8?B?NHlSKzNzRWIrNWlJSzhHeUNHNGpiTHh6YWYvWTVNcXJSNTJnaHJQdEQ5OHpi?=
 =?utf-8?B?UGk4UXJjMlNqRmdZdzdHVWcvaEM1Qk9VakJpL3JRNG1YSXRFb2s2cHcyZ2pG?=
 =?utf-8?B?cGl1ek5iaFlSUEtnc0RuTy9CRU9ncEJzSVRtQStlZDk0WlF0cXBubjF5eFY1?=
 =?utf-8?B?bTcvWUgyNEM5RU5OYU5ZYk1ISmdCcE9yeitEQUNraE9rK3o0TlhtSFhwQVFI?=
 =?utf-8?B?SFhWK1VGM3NRS3FhenNXU1dGbVlVbjBCSERpb0hKYXRQK0RuY2pOWjJ1TXla?=
 =?utf-8?B?bkcweko5RG9vemFRTVR5RjJpUlU1ZlJ2cXNYVTJYTGJuVDROOTlkb215TTZp?=
 =?utf-8?B?QkgzRHNuZnZCUSthVHdudVBwbnNIcW5SSnphWjNxcnV5QjV5ZVZORG03ZUZj?=
 =?utf-8?B?WHR6N0pzYzcrLzZnZkR0TjRENWdyM3JGV1ZjQU96bDRTYXp1NjhBdEYwMnR1?=
 =?utf-8?B?eHZkT3kwRVkwRytFWWo0VmJJcjRKbldQV25KN29rbFNFUUpCR3JiYXBWT1JW?=
 =?utf-8?B?MlpwU0diWitKampBRnBWWDF2TjZLb2hNZHdCd3B0VEFEQVN1K1FKd3FuMjNL?=
 =?utf-8?B?R2xLWXNScTYzVmtHdFQ0MmNmTXJaM2ZzendjSExvRzlRZlBiN2E0YzFCckZ6?=
 =?utf-8?B?UGJzNVl5cUxmb1NGeGRoYjVjOTYwbC9yOEVKRjlWTlZGYlRIVmpyZm1acVRD?=
 =?utf-8?B?Tm9LNFcyb1NjVVc0QUxkOVdkTFIrdFhJbE1WOWt1TDlQaG1RTVFEVUdUWEt5?=
 =?utf-8?B?clE4dWhlRGV1Y005VlR4aXdkbTE1OG1OZEJiTnJSSVlDVWdUZGZkYnFuOE00?=
 =?utf-8?B?UU5IZ25pdTVGcUtZU2E4VHM5dzd1aXlUZDV1VGlTdjRyM1NkeG5TY3VZdFJU?=
 =?utf-8?B?a1AvNGFRTHNyK3ZKYXZmQXA0NWo3bkVKaHFkRFh4aitSSkN3YW1CVytTbWVr?=
 =?utf-8?B?bnZYYXVnVDhtTTRGNnF2VmxTWG9yMXhheVVrTTR1MTNPdlhSTmJ1QXpsNkNZ?=
 =?utf-8?B?WmJkVzlpQVYxdXFhOEVoYlBYVlAzclNOQitMYkRPMFJEdkYxais2Vys3VElr?=
 =?utf-8?B?NE1ETHkwTGNpTUhJMkJHZUtDUmpWVVYwSEdnMkl1a3lXTFk4VG04Y0U0NElz?=
 =?utf-8?B?Z0VENVFGdHloMFgwdEYrZXJHY1RhczhaZFB3VXloTGFZc3g2RmZKencyRHR2?=
 =?utf-8?B?YkZqY2ljUlRkdXFZMDBndGJsd0V4ZmFwK3hJUTFDeDFOMWFybk9pcFZZMFdW?=
 =?utf-8?B?Uy9UaDdOMUFMUWY3dU5iTDFVSEh2RHFwSHVQZHl0NGRYQVFwdWpwOXBBV1JV?=
 =?utf-8?B?UkN1M1ZTN3gxbVgrcWxjODhHY1J1RHl4Zms5b3NnWmlPOVc4enIrUm1xcHJy?=
 =?utf-8?B?SW9KNSs5eXhsandqdklXcjFIRFg0RSsreGROdVF1djRzQno1QVZIUXJCV1pD?=
 =?utf-8?Q?a913g3HYm3YNZeym8SDcYFO0O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9265ab5a-ef91-4816-4c9d-08db981bc9bc
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:28:52.0576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySDBFC5kA8HU+rbhBBEIX6JOT/c4GDgbTJUhpghyR+vOws+Wnlf3syTt+khlk9o3/a3v4IeY8YI5i4DvrOlBBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5401
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/2023 10:20 AM, Borislav Petkov wrote:
> On Tue, Aug 08, 2023 at 10:07:19AM -0400, Yazen Ghannam wrote:
>> But just because there's existing vendor-specific code in arch/x86 doesn't
>> necessarily mean we should keep adding to it. So is this okay?
> 
> I'd say since it is not so close to the arch/ part, drivers/ras/ is more
> fitting IMO. Just like mce_amd is in drivers/edac/.
>

Okay, then I'll move this set to drivers/ras, if there are no objections 
from others.

> Which reminds me: why aren't you adding it to
> 
> drivers/edac/mce_amd.c
> 
> ?
> 
> That is an MCE decoder *already*.
> 

Because this isn't intended to be only for MCA errors. The translation 
code is related to the AMD Data Fabric. And it'll be a common back-end 
for memory errors coming from MCA and CXL.

Thanks,
Yazen



