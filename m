Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0456375B27F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjGTPZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjGTPZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:25:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47682D6D;
        Thu, 20 Jul 2023 08:25:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsYyrzdYE5qLdxEpwvYRrmUAgYdQhANH/a03MzTv2pihkQRUKBrqU7hJurfaN5pvLWby86AE4Lurw+76rl5WYN1qX5eS7poa+zOThWFjtincbVLRJPBE+cHMI5F14XB+mP8Yo5D7ntaxVNPar2SXPaNYX9DKIYq81fllkR8MSM7Bus2yG5wRLdR1TNsL8Uffx2e6wIci0Tk86TI8Y5Qw32OgdMJUoU/I2DMqpxsgZThacn6ncxR076XSaTeD2VYHFgKmlWM9vKDzbnBe0hZxHcQFx3gc5rDXIIvBfWYpL6hYVcTsw/nLLeE/RL3/Mf0rlfLw4k8J5Kn96PeT3RwxMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/fsBJQfaj0JvZJwm+hpaBkCfkOtIoGHT5BcfevbaPg=;
 b=FaW/dLUIDwh7BhTLssZ14pDwc85cyPamIB1SPSawJEPEKwpONfiJnbchOGJhhi/d1EV4RHBgybzk8TAg9jDOIWi7RtHCDForUrpZdF2W0rkuiSUogjW1o2mwhfjvnOWbcvHiI0gT2WJHp+r8IjrdJugsCeHt2x3Og5qzSq3J230+LKsaSoTxkecLbzQZwFk/q9cbJKsh0Bp5TE2K96O4ww29q4/ptwV/Gy93H9BK60T0PdlVsfMWkbNoLkO1Iy22NIDx+2xcRTfCAeyIhlA/gNGoZjEWEUmYwz7Cp+mqhWgVeSd1RyjpQm31Fhtcz5Mhd5Y+H+bN4su3Rz84k+vjYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/fsBJQfaj0JvZJwm+hpaBkCfkOtIoGHT5BcfevbaPg=;
 b=W36V4CdLhsOM09VzfDx37EPYpIpa5bvh9ZQH8wNDbDyh8GKm80rTlaUodPLWLH3b7ESdOacuDNqRrbh/84MabxVBb6FJZQfm6+9drWwSyCPE9GTQ0spPdjeH51VrR7SSRwXuIJ+vcepW6R0XqgABYp90rY/pm8wBJ1sdVqNFsBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Thu, 20 Jul
 2023 15:25:13 +0000
Received: from PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::732e:9ec8:4223:bc0]) by PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::732e:9ec8:4223:bc0%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 15:25:13 +0000
Message-ID: <b70fa364-2f68-1336-8d1c-7687f5c4f1b4@amd.com>
Date:   Thu, 20 Jul 2023 20:55:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/7] EDAC/mce_amd: Remove SMCA Extended Error code
 descriptions
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        nchatrad@amd.com, yazen.ghannam@amd.com,
        Muralidhara M K <muralidhara.mk@amd.com>
References: <20230720125425.3735538-1-muralimk@amd.com>
 <20230720125425.3735538-3-muralimk@amd.com>
 <20230720135950.GHZLk91jGbX7l+7AMz@fat_crate.local>
From:   "M K, Muralidhara" <muralimk@amd.com>
In-Reply-To: <20230720135950.GHZLk91jGbX7l+7AMz@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::7) To PH8PR12MB7325.namprd12.prod.outlook.com
 (2603:10b6:510:217::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7325:EE_|MN0PR12MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: cbbd944b-5ff3-4abe-147e-08db893582f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KlDfJGkaGAswD6/Gq1S8EJzqG2k7DoZfVnbO1ZUl3w1OKfv8nhNGS17JdD1tcHayT1a87YcEunPEjoRv5QX7ymi0et4L6bcapDmBBwEjaAP9uOE27nyK9+/kaFFqacu7vXmXCzH39z6nCZ2LJ8oZNVHL11iP9SrscbcC5viNJTMXguT1QWrRvbUgxv+OkcZ9VPKsj2xwSebRxGsAZUO/LqjotPys2xXOIh2cSYxFdKqusHx4RxR1ADdSrCiFHqgdDq2C68oRH6vVzmxZVqv6Oe9lPhAlW1Avb3dIiw/7jM506tz3t3R1AEJeLfXSBM3dZ42vF9anDLt5yaNIR31/y0CQ7Sv1R88bjRey9ClAP6Oz5u+Hek2KN043boJ2Ups5kXsnr6Ji3VNDQrQv6n+Rewb+2RqsISz4I8h/lOgp802dEeukQzUWNlPtEfZTWmvK+1H9X9LizPfDwzdNK7hKxNA3jq/KrqmFgLfGFHC7/M8BMfWuO2aB0LF0BojUFNUpauzCXKsX7+0iBhfHdxh4+DXoXFzdnBr33tzVQk2BXcf3TNEyCFX9cugqJlweeliPrpD91r+cPgexLdRnHvK9pMSDL1NEhZ3jc/jI9l0MiOBZ6PUo3ajnXwrhGr0FyAD1lxM9LQtr0VOAta/qhpzN8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7325.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199021)(478600001)(6486002)(6666004)(186003)(6512007)(316002)(26005)(6506007)(2906002)(966005)(36756003)(66556008)(5660300002)(8936002)(41300700001)(8676002)(66946007)(6916009)(38100700002)(66476007)(53546011)(31696002)(83380400001)(2616005)(31686004)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzBJdU9FUFZMcENJbDNrbGRHbTliVHdWaHJnRDc1L2RzL3dnWlF6OEdxV0N4?=
 =?utf-8?B?VkpIMzRYUThMSUN4RnRmWGtWUERZWXVlMElJcTRCWVdRV0l2OEMzeTY1Nndj?=
 =?utf-8?B?aTIxU1JETzlyaXZMaks1aGhOT2JaeXBmQTBxRWJyNTRudUp0bk1SQmd5M0k0?=
 =?utf-8?B?em5WU3dFWm1reXV3aUozR2JZcjFyNG9ZWERTZUNkcW0yNnMzYU1yVTBab0kw?=
 =?utf-8?B?TTRxcCtLZExaY0lacjhBV0w2TXRoMGxlUm4yNFhLdUpaY0ZnejBGMXZaOWFP?=
 =?utf-8?B?TnNCN1ErU25FbHhDajZkOUp5UFF5NkVnSjBFMjNEeUtEUytJdmhTbmNrVWk2?=
 =?utf-8?B?RWN6RFhHd2NLTFdnVEh0eEZWbTNEVFFqTngwanpVdTljMWJlQ2s5SVJwam8y?=
 =?utf-8?B?YnBLd2ZUZWxiK0hYZGU4VDRZclJiS1gzNHlYdkFzVTR2L0k2K2hwam1od1NJ?=
 =?utf-8?B?WXZzOFlPMk9OdFZPSkgrTDJlRTc1cDN0WFpLTTM5WDcxR3BqaTV5U0hvQWVM?=
 =?utf-8?B?a0VBbmZSbC83SC9XWFV5ZWFOd21XVk56Z0dCNzJYRTlkQmlNSUZEcXlNTGZ1?=
 =?utf-8?B?UG5tdzdFMkRSbmJidkpKYkF2eExoN1VzVHdMcXFSV1lmcnpCdGVYTWFQcjFM?=
 =?utf-8?B?SDRhdEp6TmdadDh1Z0JQRXBQcmI2aWdwMkU3OUdTZzRldlEwSTJpVFlCREZq?=
 =?utf-8?B?aUVLQm1EL05neE9zWnZ3NlBYakk2MkV2ZEo1TDBiVTZhcmZ5T3RvN2sxdkw0?=
 =?utf-8?B?SytCbU50Y3ZWRVUvb0RUUjYzTDJ0SXozalc1eVVIaUNuUHRWOUJJY2NMTWVm?=
 =?utf-8?B?ekxWblhiMTQyOURIeitrdkpJZmJxQzBkSTR2K3M0L0Z3OSttQjVtUHJHUU03?=
 =?utf-8?B?Zk9ScHVjVllKcnhNQ3R3Qmplb0JyTGVLVlhBOE15WXZ6MGZYcWxqNmlVcWpW?=
 =?utf-8?B?RDhtNk1TQVhVVHo5YnVqZjE0d2M4UjRXajlxTnhxT0dzbmRYQkRqR3J0QXFJ?=
 =?utf-8?B?R0N5d0VsUzJxcWt3SFV4eFh4VVl3TjhzTms0aGhkZEFjd1N4T3phaVF6U3kv?=
 =?utf-8?B?NzdCTmxwdkRuVjBPV3pIYjJvOGQyRWFHeXBsRlk4Y085YXVXMzJMdE1WUDRY?=
 =?utf-8?B?dG5NL0o2MjhjTW1TNllvZUtkUitobVY3MXYrazFmUlZ6cmhsREtKbXBCZ3RM?=
 =?utf-8?B?V3BVNk81NzFXaFdFUmxQb1VtQi9OT1Jrb1EvNXd2M09MQ3V3L0NjN3pvZ2dO?=
 =?utf-8?B?dUZpd3lIbFdjdWhvNkYwbThFbG5qbDlPVW42RFpjcE0vR1BhckF2QUkxcGc2?=
 =?utf-8?B?czRRL2dJVytBbmM2U1d0ZmRCeExRSVN6NGtweWFxR0dnSHZhZG1iWUF0UCs5?=
 =?utf-8?B?Si9xMmJLcDQrWXMrNEtvTXhmTVMwS0NldUpsT1lWSTdmb3NiN0wxRCtqR2h3?=
 =?utf-8?B?VkZHS2tSQTl4Q3lIVDlWUytmSFlpSmF3YStjVnpacXVWN3MvTDk3bWNFWEFw?=
 =?utf-8?B?YlBVVW5nMnFPNnV5T3lpeW1WTHArbXpoR0RUZDlhUGJJZkxCLzEzVWVHaUV5?=
 =?utf-8?B?ZHlQL3JZUmlxbno4dmNoTUZsSllVUE56SkJhYVArTlVUeG1YRWxidWdkMis3?=
 =?utf-8?B?KzNNSVo2YmNVRUhwclh4bHdOUzdjSDR4MS9YbjZFbGtTZGdrbTZPaGJoMTFn?=
 =?utf-8?B?WFR6WCs3V1RablREWHRpbGdpL3VuSEM4dG8rYzBGWVV4UnNWV3NTb3hOQk1M?=
 =?utf-8?B?dXg4ZWpxeUVhMXczM3RORzVkeVRLZmxXT09JNDd1Q0RYKzFDTEtxME96cVBR?=
 =?utf-8?B?b0RvTlRFVk95YnBCdGNKMUFZa0FVWVhwYk95L0VrUFk3cGJZZjJnS3NFUXhI?=
 =?utf-8?B?TG1OQkNFNlJDdE4wTUVhWEhDWFB2dFdicEdaNktoZmxPRitpYUZGRE4yblRI?=
 =?utf-8?B?WFFTeVYyVzNVenZqWkdLRG5RdDYvMVRoR0ZtWGdjSnBYOW80amtxbXg5cnNl?=
 =?utf-8?B?VlplWHdObUFVNGU5SzBHQmgvWE5tVDJuRDFkSUQ2RjFjWFQ3NTU2bVNwSXEz?=
 =?utf-8?B?dnRlcDVnNC9CaEdXdVdVaUM1dFArV050UVZrdDE5cDZ4STFQQWlxZzJZSU8v?=
 =?utf-8?Q?CSUdJPYufZTOgq513Zh1Xmyxj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbd944b-5ff3-4abe-147e-08db893582f2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7325.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 15:25:13.0277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qFbICYyvunYk+WjowE50n+gkCfdRTR01lCH8BweHAjKoOD6ZMZ2Rrd6zZnUN84gyyHZy2PUmnJoct5mSdVUgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 7/20/2023 7:29 PM, Borislav Petkov wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Thu, Jul 20, 2023 at 12:54:20PM +0000, Muralidhara M K wrote:
>> From: Muralidhara M K <muralidhara.mk@amd.com>
>>
>> On AMD systems with Scalable MCA, each machine check error of a SMCA bank
>> type has an associated bit position in the bank's control (CTL) register.
>>
>> An error's bit position in the CTL register is used during error decoding
>> for offsetting into the corresponding bank's error description structure.
>> As new errors are being added in newer AMD systems for existing SMCA bank
>> types, the underlying SMCA architecture guarantees that the bit positions
>> of existing errors are not altered.
>>
>> However, on some AMD systems some of the existing bit definitions in the
>> CTL register of SMCA bank type are reassigned without defining new HWID
>> and McaType. Consequently, the errors whose bit definitions have been
>> reassigned in the CTL register are being erroneously decoded.
>>
>> Remove SMCA Extended Error Code descriptions. This avoids decoding issues
>> for incorrectly reassigned bits, and avoids the related maintenance burden
>> in the kernel. This decoding can be done in external tools or by referring
>> to AMD documentation. The bank type and Extended Error Code value for an
>> error will continue to be printed as a convenience.
>>
>> Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
>> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> ---
>>   drivers/edac/mce_amd.c | 480 -----------------------------------------
>>   1 file changed, 480 deletions(-)
> 
> This needs to stay until rasdaemon has support for decoding errors - and
> I've told you already.
> 
> Lemme tell you again, maybe it'll stick this time.
> 
> In any case, NAK.
> 

Pull request created in rasdaemon for the same.
https://github.com/mchehab/rasdaemon/pull/106/commits/09026653864305b7a91dcb3604b91a9c0c0d74f3

> --
> Regards/Gruss,
>      Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 
