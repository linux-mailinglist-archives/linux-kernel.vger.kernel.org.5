Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECBB78FC4C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbjIALbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjIALbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:31:42 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2057.outbound.protection.outlook.com [40.107.241.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF201BF;
        Fri,  1 Sep 2023 04:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liL7/bvvXgw1TpHeT5QrmMYNJNmckQ00pN2QyEk3iEqkrgXlyu/+mGZoeD6anREMbOiqO9NS8LVARDoCr2mFos1yzpjVVNpmCOelv8aArk1PPJts/h1HSNCKwdcxOrS4/qsrWDDuUZo+NbpkraczBzLOefOHuYk7BWT7eFS4feT32P/UwKPacnpxkx2YVnuChNIS/7Vhnq9aV3xIlZzzCQ3rEPnBm8kW5Hs1cFCPI/UigDnaXWzPkBx4HoRY2JpFJ9OkaTRSVRjBzi86EyUywZD5ROzX1d88HYdgJEwm1ARTOpkmdwpxzJxUfewnTPhvpstVB4Vml99MZmcw8j2J8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Njs81M/hXsqU2yD9YUSoYZ/b0nKxHj5i1ToBewrFaaU=;
 b=E09fiBcqjTqxXs8MJQZDBLPLO+dihAAJg+rBycRjJsOU/XZKhXqG/bL5UafH/9BODsqD3CJpayDrCFkh41rRC4/tFlMs8tRhm9PLySoZhdHplgfRSfbPMasSe5cz8Leou5uTTWoxLaeon4hSvekbLU78ZBHo90VuJbZoE75qbNGYTDhIAxU62GtxmNOq5mg9olZNLuyJfVlekyU6H/5ZNihgKrBriO3ZoGZHQe70SS4NTZltoev7/oPmLdT6yXbHULdGFhR3Fip67jKS5sEzmW45N2C+EPOCu3wRZvztPmH0U7+BmH+omIKGAr5NZIURnF/5L8l0YWMzgxSconomZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Njs81M/hXsqU2yD9YUSoYZ/b0nKxHj5i1ToBewrFaaU=;
 b=YFn9qS0c5rlW6AxwXJ3a40720wvm+7tPl8dNYntNXJT7t5WXp+mOR9S58LJJBK7sBMCJz13B4ihN9brApPsOCZF2bbLMT0UpuZZ7L9QYRSqN2ruyBRVekkhRA5NxNpbJ057R9o2YG/HHLJPjLIqOuh2ANkZhwq44ZsuOEkuJRYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM8PR04MB7890.eurprd04.prod.outlook.com (2603:10a6:20b:24e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 11:31:36 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%5]) with mapi id 15.20.6745.021; Fri, 1 Sep 2023
 11:31:35 +0000
Message-ID: <f094ff74-4ee8-e58e-a1f1-0be27cfe729a@oss.nxp.com>
Date:   Fri, 1 Sep 2023 14:31:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC net-next v2 5/5] net: phy: nxp-c45-tja11xx: implement
 mdo_insert_tx_tag
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>
Cc:     "atenart@kernel.org" <atenart@kernel.org>,
        "sd@queasysnail.net" <sd@queasysnail.net>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Sebastian Tobuschat <sebastian.tobuschat@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-6-radu-nicolae.pirea@oss.nxp.com>
 <ZOx0L722xg5-J_he@hog> <5d42d6c9-2f0c-8913-49ec-50a25860c49f@oss.nxp.com>
 <ZO8pbtnlOVauabjC@hog>
 <518c11e9000f895fddb5b3dc4d5b2bf445cf320f.camel@nxp.com>
 <ZPGuchwza3xr5SaF@shell.armlinux.org.uk>
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <ZPGuchwza3xr5SaF@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR09CA0028.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::16) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM8PR04MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: e331fe92-4bd3-4bbe-9960-08dbaadeffeb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oteiCpp+NrjIEn4tt+OA2nYjDjPBq42+nFEeS8r4GNnJOSQbuXlI0P3pm614SDrkfyEHR+fn4zj0jUXXnDTL4gA7RgSd3nrM8tedh9aMmx3krxTzXHUC/h64fdfw30x0gkPoCxYxwHPdidvLRlF9yCDaL6fmEBhgJpT7g2P4ffppwvF26Noub7fHk8t4NTBc8K5XTvaCyXE5Xrq73kowGfsL1FTWlwiIGv0PwpShFEePv/inxbcYz0ePCRc3wB6xTStpNDmE7kUDUKXiTqLXAXgYcUyPzP0xZsdIJ/SKyyFPB04qUEOjioZVoSQHlw0IdrZKM0zWB0F678c6NoEks6Phny5c4UQw7+EWOAErtAAqARhaYFTscl+skFIEdgjpM3cE89aDb8hdesfV67c34SfhRWyigTQdGqztyo+RmC5HMwG7vAizKOJObPc5FJD63dIU9d8eEx3h+7o+JNEnxC9bwWYquvDm+v87/dil6BLzhT0oeGZrLR+AneNMe2dScCl68jrvUlpv4VEz7ik2xhUwiCHg8wCbYSLZdq7om6tScmzaCiomjm6Ae/eplcWA4IxNIpYwrSAkPw57h2FuqOeI8mEC3E9SF0oZArKcQUE76+tGhxgwfDOBnGZNvVNp/SzrTqV+uEw+k1zucLiXrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199024)(1800799009)(186009)(6486002)(6506007)(6666004)(6512007)(53546011)(478600001)(83380400001)(2616005)(26005)(2906002)(7416002)(54906003)(66476007)(66556008)(316002)(41300700001)(66946007)(110136005)(5660300002)(4326008)(8676002)(8936002)(31696002)(86362001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGVLVnExMDlGZnVMVEtuM3pxZDV5Tnk0eWZXT0FOTitwdkRwT2VWcUJqV2Fu?=
 =?utf-8?B?RXE3ZmR1V0dka21ZRzNRQmVQaVllalZGZ1VDNm16Rkc1SFFoV0FVZXFTcUpD?=
 =?utf-8?B?bjRJcGs1ZkVnNmVYZWVMTUJaUE9IRXRDR01nM3NZd3N6cFhkWmJ3dUd4bjRP?=
 =?utf-8?B?blEvRmR4OVliUHVETDhmUVNwR0V2OHpPK0l5WTIxUEhURWJxVTBhQTB1VHpz?=
 =?utf-8?B?dmhTbTc2N2treDQyN0x3T2VVV0piNFBETnlyOSttMzJsVjd1K29XalBkMUwy?=
 =?utf-8?B?SDc5ZDhoaWxaNDAvNzd2dzdlV0J2S3dlTVlMMnM3Y0tGcWNXZm9LRkZDbS9D?=
 =?utf-8?B?TzVBUWJmLzNwUU45ZTkwZDJaMmtqYTAwRmVoR1Y5dDRYWWk4YTFGSmdhN1Ni?=
 =?utf-8?B?ZUZxNXYzTW80ZEhUMG5kMGtreDY5N1Z1UXlsUnlSZmhwaWxCZXE1NHYybU5n?=
 =?utf-8?B?KzExMTlaQWZmeU5CNkVGL3JpcFhVMlBWSnFTMEk3QktiZGNzY1lhaTg2Syt2?=
 =?utf-8?B?eU9kRjhpNHFBemZESEJkdlM0WUFrc1VLNUkvWVVwdkdTcFB0eURLUDkzcWUv?=
 =?utf-8?B?WWxWYzl6TWxTQmpOTjBGR0ZZUzVuOTlDM3daUndJek1wUE1RYTkzakdRUDR2?=
 =?utf-8?B?alNBcG1EcUtkc2JKMW83c1dCTVlSbUpkTEd5RDl4NzJITkx3R2g0dnpTUHIw?=
 =?utf-8?B?WWFsQXZhNUxxVkJmeEtPVExuMmora0VsTHJmWmd2SERzNTZUZG96ODFMbDcr?=
 =?utf-8?B?RzNoQjJxNWF6aGs5bXdVeWs5RkhLL1U4OEN3YnRCSVNwWmw3aVJOT1dqd1I3?=
 =?utf-8?B?QkUxL3p3K29nUzhuTU9rVkQ5UVMrQko3ZDlXREY1a2R1OEx1UHR2d1NQZWNy?=
 =?utf-8?B?U0tCK3NRTHhNUWtsUndTM1l3VGVaVlBVMnQ1c0RYNEtzWDhqRnBrYjl5NU8w?=
 =?utf-8?B?dmpaZnVEbHhBSWkrNkgxSTh6ZEQzUzd4SzhLTlN4YTJqK0ViQ0REM0ZzNldr?=
 =?utf-8?B?cWFNUitaQXhWMnB4NGJZT2NUZmh5WkZ4aDkrMUVpNWxKS2FFUUYzSkVSNjBG?=
 =?utf-8?B?a2lHT0tkL0I0aTNsTVZEK3QwdGNDYXl5SmtSR2FicmhYWnJVbjFuZ1FDUGxx?=
 =?utf-8?B?bXM4cGt3UmxVVWNNZUZxYXlyYXBnY0VyLzg0eXgyNTYzVVNDaWVac0c5TFp4?=
 =?utf-8?B?bHZYckVmZzR3Tnd4Y0FyY2prTXE5K1EyeHRZdVh2c2hMRjM0Z2hybzdDUXpJ?=
 =?utf-8?B?WWs5VlNRZUFEOWVQekYyYTkzVW5CYWxic3RKWmlVeWpMVmlYdzlaeXRlV3Jw?=
 =?utf-8?B?Qk5XSjRCVnVjSG0zQXJsMDVyWVNxRkRPaGV5Z0p5bk5ackk0M0pCM2x4OVhF?=
 =?utf-8?B?VGRPOU5tV0RCb2QxWWplV0o3Mi82NUZ2WCt3aDJLUWllaDVCd255dkl5NXRG?=
 =?utf-8?B?T0pOdnhIT3lpa0k5QWNzWmNVd0M2RkFaVk8xSXd1aU42ZkczdiswY2tKK3k0?=
 =?utf-8?B?RFoxYmtMWkdHQyt6N2lHdmlxMG8xQ1RqaldBWnZjRHF2L0JLdEUxdm9aZ1Rt?=
 =?utf-8?B?QnZ1cmxaeXF3NStSOVNMTXVQODk2WFloc2RoVVYyZXRQSDRNcWtNeDdLanZx?=
 =?utf-8?B?V3VwTTk5NmlxelVrZUhOVUJJeE1BVEw4MkxpcUV1Nm9iSlNJTWZ1Vnl5VGVQ?=
 =?utf-8?B?Zm1jRkVjd0RJdzFRRUdFWFhLYnB0bVY4Uklma2x2eU1pMFFqdXpTS05qNjRY?=
 =?utf-8?B?ek1ucERwampPOS96SzRSamF0S0VLdnNRLzFNWFFzZXlZVlVwTFNkeU16WlFj?=
 =?utf-8?B?UERtejg1WWdOVTRycXpaU3daenFJOERBK3VSaXdvSFRYQ3dEM1Roc1VROXdZ?=
 =?utf-8?B?NVU5bXYvOGgwUW0wMm0yWWZFSjNEd2w2WXJSSWJ4T21WWW0venVzRFdoRFRr?=
 =?utf-8?B?YXErWVMzWjFabytJZXZIVHkyUTV3VFh0MURQZUh1blltZFNJNE5oaDdSc3k4?=
 =?utf-8?B?endJUUw3SkJFekQxYTMxQU5uMjcyTG9OVmZ6eThuaTlDdmV2dXdYUTU3OERx?=
 =?utf-8?B?dHk0MnZWUFUvT3F5WmxQZHdWVThzRUZxdUFIcE1kdVJESnFPUTFwZUtYOFk3?=
 =?utf-8?B?WGRlQnROekczZzFnTEtUZTZGOHBtU1lMUUZEMmZ0U1orT3VhNFNNUUNpVnBK?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e331fe92-4bd3-4bbe-9960-08dbaadeffeb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 11:31:35.8993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMiSwHuDFhwWmymrGKl7FeEBees9S6YE02M9/X2A5yXybjYkljk/FXnKrrNt/7qhZWvT7+cGQEJYH52Vh9tpadChHSpdgkLr8Oki38495dc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7890
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.2023 12:27, Russell King (Oracle) wrote:
> On Fri, Sep 01, 2023 at 09:09:06AM +0000, Radu Pirea wrote:
>> On Wed, 2023-08-30 at 13:35 +0200, Sabrina Dubroca wrote:
>> ...
>>
>>> And it's not restored when the link goes back up? That's inconvenient
>>> :/
>>> Do we end up with inconsistent state? ie driver and core believe
>>> everything is still offloaded, but HW lost all state? do we leak
>>> some resources allocated by the driver?
>>
>> Yes. We end up with inconsistent state. The HW will lost all state when
>> the phy is reseted. No resource is leaked, everything is there, but the
>> configuration needs to be reapplied.
> 
> If it's happening because the PHY is being re-attached from the network
> driver, then wouldn't it be a good idea to synchronise the hardware > state with the software configuration in the ->config_init function?

.config_init might be an option, but keeping the keys in the driver 
might not be a good idea.

> 
> Presumably the hardware state is also lost when resuming from suspend
> as well? If so, that'll also fix that issue as well.
soft_reset is called when resuming from suspend, so, in this case, the 
MACsec configuration will be lost.

-- 
Radu P.
