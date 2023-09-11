Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AE979B449
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355493AbjIKWAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241237AbjIKPEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:04:41 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2082.outbound.protection.outlook.com [40.107.15.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42D21B9;
        Mon, 11 Sep 2023 08:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZJ1/9w0da22gE/bLaZEeR4vA8pv/fHLO5ctAuc0ukwHphBKXPF2djPwXAmrNnvcQiXyHzeBZ1vPaACJrfsisIPwZEbcuzOAtCZK8373EABhU+I4bSxGdg+BrOSjGXVDGyQl0sq+4AHGcM1XfcdnRDmGiMVaQ617NgJJVzU6x7+b0I+Xumd1nJSwNy0jkpHKd1UomGRI4KQ0rcIQzd8iy5iuwvJdqKBxhEkCl3lxzwoNEEKVKm0YvGOsgxkequYH8Sddj04Z2f3nvm7XSlmpbrBw2cikwh6b8NUpStNtu4+nvekpOtmg0NxSPT6EKqiEiteNvZ+UIc6JYGiJngi61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Wi7sTyOay9yOELnDKiBIzy94a0MRmy1gfJKLLpxd2w=;
 b=Niuw+S8tT65fOgAX+tglj10uPD0sNUNELWDORXNOkLEGGAaiPrEhLosXc/5UBGkAkawxcE69SEuflpAhOVag0n4ENdSOWL31sbirEdyXTkbtBFWgd0WxeQBtbZxMUXnztndzaw7zMvuGUSpcmzx5KrQHzJ6iCO4/CJXC+yu00VZRoccLqcVHuG07LxCesjaz8Wp+xyKZZBeJ17trc7pDBLaY1UosTIedwSvwtLtgdyItDJYxBVW0GxOP3JB6Hm6Xk8Ntjz2Afh1U0t8q339lU/BcNuYLHsjBHzIyIX4MA29eJLZRLkcqy3TIzA9YSUyxck6m+f5oagyfCqUCCQfYng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Wi7sTyOay9yOELnDKiBIzy94a0MRmy1gfJKLLpxd2w=;
 b=Y8iTG18xlHNeiWEZqxkRurDXn97r7BK6x2Dly9+UQMTp+z1QZHzDaaqucIy6tYZv1O17C59LV0s5u1IVsoGySPxyGEKd0kLzbIMPPz00M/+sj6xoevylpTv+6vHIVT6zZn7Zua7LdnvlnvyiZBqvmb7waLXbp2diaBtPbs46hlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DBBPR04MB7819.eurprd04.prod.outlook.com (2603:10a6:10:1e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 15:04:33 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 15:04:33 +0000
Message-ID: <50617433-2c93-839a-445c-e0d11e95496e@oss.nxp.com>
Date:   Mon, 11 Sep 2023 18:04:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC net-next v3 5/6] net: phy: nxp-c45-tja11xx: add MACsec
 statistics
Content-Language: en-US
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230906160134.311993-1-radu-nicolae.pirea@oss.nxp.com>
 <20230906160134.311993-6-radu-nicolae.pirea@oss.nxp.com>
 <ZP8Bc0KLTthSiKD-@hog>
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <ZP8Bc0KLTthSiKD-@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0003.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::16) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DBBPR04MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: d71cf967-4039-406a-671f-08dbb2d86839
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YWcQM1k00TfeAi6DLZgdlL2qtARo3nV0P0FhB75akH0FN4PhiYTB8HCT63VaPz1pyNI7MADOJ3q5H4o4A8aRFOhi/1gPvKFcLBPzjy4sxtVOlc7H0V3E3vwRQ/FUmdgnQ1mUnnBpWXC7FKsp5DDegESxJ8gz4pJX+YxbHCRIBmwRr6MxSP06Db0L1GGWOGljLXSan1PXrgAqRlRUDq6LEHOJVBU3o6ZBtJbLHILgMPLSA49hMyUa7CSk56vRnTTAdD0+wZ1U4Lu5p/AtlWdTFbxDx0dgwAnggqvSxLX3pgz5Obgo8pN8asf+pcHxZ5M8oSjxZX2JeoPzR/XinyeKjDmKZ5tXn6YBuKiKzni1HxhPJxdMgvASBFgnCSSNyhuhUPcXhGLmTrIJqcOqZolLLAZYqeWjK+lKny1oA4Lqj5a61iekKPrOgxREnuFkj4WphRXWHCPt/7KS9IiqPExa1aVCgUpwsM+aMXRFE75lWMMCVy0wFHxQX6if0DOwH3l0EDLJjw/37AoHbaoZvnDqeKssy5ezWdOYqncpCULCOQbdraQt7ytW+2d0oqnHJavxvz5hFZ9mEjx6ml4aJUnf1d3c+L2K2zJBqFV6v8hYGmnoXYq7W0OiTPHWLkGNOJQ5IRLuGkRXvQun22VIrXiGQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(186009)(1800799009)(451199024)(41300700001)(53546011)(6506007)(6486002)(6512007)(83380400001)(478600001)(2616005)(26005)(7416002)(66946007)(6916009)(66556008)(66476007)(2906002)(5660300002)(316002)(8676002)(8936002)(4326008)(31696002)(38100700002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0tkYndKVi9XSlRBN1Ayc2h0MmlGRm9ubFRiZVIrT1FxRVdvbmVjSjMyZkNW?=
 =?utf-8?B?UlU4TVlQRXZrajBGRi9MSnY0WVp4OXhDMXFnVzZacXY1UmdDSmlCTDJjczVq?=
 =?utf-8?B?V3ZnSnl6TGxRTFQrUmRmcjk2ckRyZnExUFZvUHRvMm9Hd1JhQW5uL1V1aUVn?=
 =?utf-8?B?cDVGOENGbTMyQ1EwYlc1bnZGbTNRK29hbFA5STRRL1JYZ0FOSTRNV1FIcnBn?=
 =?utf-8?B?UjZyTzd4K1EvM0xDcmMvRlMweStDT0QxdDQyMC9HUDB5cFFnQlBTa3B6dDJo?=
 =?utf-8?B?MmhzSWdQZHQ1Q0gyK2JUNll5KzdXYzdPc3ptYW1MOHhqSHdaZVNZZTZPRi9l?=
 =?utf-8?B?cmFXU0VKUUVxZXFnenlQMVV3SXBPVHlQRGtoVHU0b0NRdzVCSmZhTFhzRFlL?=
 =?utf-8?B?NmlOMU1EeTFqVlVMdFhBNlBJWThSbERYV3NmeVBrZEVDdlFaNE1FSVpFK09a?=
 =?utf-8?B?TGdTaEpSanhkM1B6V3ZxOUowdEFmMnc0RVJoWlBCd2N5SUVZS2xyTjR5TlBC?=
 =?utf-8?B?WEFFQTc1d0h6R3VzTkU3R290WURNd3RNWFpORnhZQkdRRS94eVJnZXVGOVRZ?=
 =?utf-8?B?NVU4eXdCWE9JZHcvUUFnTHVVbnpYZ1g5YjhkZHdEMVplek5PSDV3NjZsZU9I?=
 =?utf-8?B?MGc5bVhKenZXcHNYSXpiNFFNSWNlYlY3cFdzN0lEaE11Ujhrc3R6VWt1MXE3?=
 =?utf-8?B?YU5TSXV0em41NUZITFBEdk1Ga2pIdFY3Q1JjbE12SWZ3Tm81b3NPN3JYZ0tL?=
 =?utf-8?B?Y1J0YlpGTXZBM0dNOVNtdVErZHZQQ3JQRFc2aFJyRU9pSEgvcjlWMFZTTEt2?=
 =?utf-8?B?VCtuRXNFLzhnRE0wNHBHUUp1NzZzUVNySlQ5OU5JNFlxTTJicmdGUm9QeVBy?=
 =?utf-8?B?eHlLVWY4N0Ewd2tJY0IvY0Y5ZjRiM0ltd2JLSklXOGd1dXFzZHp3L3FreU03?=
 =?utf-8?B?SERuU0dxdEx4d0s4RVhzUFNPY09Tc3hHbkU4dFdkYk44RjRid1dleFUxQjFl?=
 =?utf-8?B?R0lMZ3pLUlQ3V0FoV0c5blZ4c3BtZDRYM3FpZXE3R0RWaWtXVzNTeUh5REpt?=
 =?utf-8?B?MTRnK1k3UmNYb2lzVFJYNkFRa3pNMGpnYlAzMkt3RHpoM0pMcXZWZm9pN053?=
 =?utf-8?B?endFQzN3N1R4ZCs1UWNVcklLSHVZN2dJekhMSzh4MklSWFdUVmlsODE3Wmxo?=
 =?utf-8?B?T1VqRkhwV012dC81aXVhSkNwQ1pPNktFeFI2U2lzMW9VWk9SaGVyTFFtRng4?=
 =?utf-8?B?Ulg4b3dPMW1JSXdVVDQ5STRPTit0YWRhK3F3R1hXWEFJUWJ3a2J5RGx1bVBJ?=
 =?utf-8?B?b3BLYkxHRm1rRzdqd3haLzlVc2pVSWt4bnRScTJRUFpTbElUQnFsWURjUlpu?=
 =?utf-8?B?dGFsOE96azVZZFpWSStzdWdrTXhhMndGSndkaFkxTHVYTjlucEJTVit3c2x2?=
 =?utf-8?B?bkdzOW1UbVh4eUREOGtBREI5UHo5TlhadXZCemR4Mmt1NzNLV0hOY2IyZVZK?=
 =?utf-8?B?K0MwYS84Y2V2VVVQMHRlUURlMm1sYnV4ZkowWmdKSzRxMElCYmY3NDI4QlI3?=
 =?utf-8?B?Q3pkUzgyL1kxVTVxbUpIb21pV05tN255NWEvRDRXOWE1YStzMlVZdXVzdzJl?=
 =?utf-8?B?V0FKRm1makhHRk5DbVZxZmUvYktZY1dEamlkdmhoVHpBaU4zTjZUMlNaTzFv?=
 =?utf-8?B?ZnFjSjcyckd1T3VnSzFFTnNKZDQ2akFsWDdWaTR1Q0Jpa0NGaTRsWXpTMWxG?=
 =?utf-8?B?NzVmQVRXVkY5ZC9tU2pNZXVUb21wTjdwcExrVjFIb2plMHBvV3h4VG1pZWFS?=
 =?utf-8?B?c0U3bzRDalZFdi9iMnU4WHArSEx6YWRKT0h2K2JBZHU2THdIaG1ZZTk3RmMz?=
 =?utf-8?B?dVVSclQzeEExZ2RQQ2NvVUJDRTQ1L2tHQ0xBUEJzWmRNMXczRWY3aG93ZVJB?=
 =?utf-8?B?TjBEK0laNmtiYUJrT0Yvbm5HU1A3MzVQbkZzVFJiUW42RTd3WnFoUnBGMlFW?=
 =?utf-8?B?cjZRTDdMMnF5K0NlWE15K2x2VWU0WmtJMDljS2VsVUZDVHcxd2p6akxlV2VH?=
 =?utf-8?B?Y2FoUVJZem9iMlJDQ2J4ZExJMFFMTHhFZ3RyL3RmZVpXUDBVdGE5WmV6RmE1?=
 =?utf-8?B?R2lZcWJSZENJZkRHdEFoUUROYWtPcDNNK20rTDhJRjZFQVFNZTRrSG5nQWM5?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71cf967-4039-406a-671f-08dbb2d86839
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 15:04:33.8516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nXy+Wk9XRdU6c9B7N7JMP3L4vXcxbYk+FtVz/49OW8sHBIoyB/Dbi43oUSQcDgru9+aHjIR+E7/xCt0Z7+wvDV+3yOXEVZGlEXy6hySEdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7819
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.09.2023 15:00, Sabrina Dubroca wrote:
> 2023-09-06, 19:01:33 +0300, Radu Pirea (NXP OSS) wrote:
>> +
>> +	nxp_c45_macsec_read(phydev, MACSEC_OPUS, &reg);
>> +	dev_stats->OutPktsUntagged = reg;
> 
> Can you read directly into OutPktsUntagged? It would make the code a
> little bit more readable.
> 
> It's a bit unfortunate that all those stats read turn into 2 (or 4 for
> the 64b counters) reads. If the HW's value can be incremented while
> we're reading it we'll see an inconsistent value :(
> 

The 32b reads are consistent. The inconsistency may appear when the 
lower half of a 64b register overflows.

>> +
>> +	nxp_c45_macsec_read(phydev, MACSEC_OOE1HS, &reg);
>> +	stats->OutOctetsEncrypted = (u64)reg << 32;
>> +	nxp_c45_macsec_read(phydev, MACSEC_OOE2HS, &reg);
>> +	stats->OutOctetsEncrypted |= reg;
> 
> Since you have a few 64b HW counters, I'd suggest a helper:
> 
> stats->OutOctetsEncrypted = nxp_c45_macsec_read64(phydev, MACSEC_OOE1HS, MACSEC_OOE2HS);
> 
> 
> Or (more consistent with the 32b reads):
> 
> nxp_c45_macsec_read64(phydev, MACSEC_OOE1HS, MACSEC_OOE2HS, &stats->OutOctetsEncrypted);
> 
> 

I will add two helper:
- nxp_c45_macsec_read32_64	- read 32bit counter into u64
- nxp_c45_macsec_read64		- read 64bit counter into u64

-- 
Radu P.
