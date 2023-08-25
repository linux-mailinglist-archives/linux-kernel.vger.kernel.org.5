Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DD5788B9E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343728AbjHYOW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343852AbjHYOWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:22:38 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE30D210C;
        Fri, 25 Aug 2023 07:22:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7Esx6ImZU/TPO4is/bqSDpN5u8hT3Cm9TpyuofbyWB7xk/mbagFp23pZjv8vkCa6UNJuXLHtLeJPD8WErKR3I6EICwjVM47vs8lZWz9ULe4nBqzTRFHAY5wm/QxXuWRB3xy/L5/8NUHxqvaN8BKEoK64z/jF4qLPVaPSmCOYamvMfRKP9p0iw0/xB0vVWKp2QY2/Vgx+QxcvxlMSSx0cT2Qq5RegxYu9Rtp61X6s4WHtEScDlc+uax1pWdHdFb+h0BpcR0TK7pTXDUPwGU8pJUIZ9GteCdesxaYuimEzj/dMoqTFcog/SlqVB61NOpiG3LqBHCbkrFGfIrrlQGpcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RX6fMG2FEFqNsz9wem+VuMwYM3w7QlF9XGk+e7/er34=;
 b=Hzkt2UOqQ2oRav3H1dHgcsqAJmk+JslbHvpNIevodZp80E2mSXwSbfc2YByXjgfl/B/x90S6nWUW3kqnQ3GiW4ooHBMsMzn5nx46TOiV4GvtiEaxhO0GFoWcV5219HZ+syQPnwLZosEQdgWs3+x9Oc3Tjb2BRKYLz1ktGMle6CTh/ecpg78YjKjrvYthMYs/XLVv9JzgCYZ43/BGofPbVZB4e1bIdNv/70eFxvVEsORHtdEwpLNpewjedz+K2+wbkZ2JrVBFNQvirTrVmwFArOPTAOGcWBPtiIJGROvZxhEYQsi/KEMRBMKaEmd67ed3ZIpyxk1ictAb3LRGR8SeiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RX6fMG2FEFqNsz9wem+VuMwYM3w7QlF9XGk+e7/er34=;
 b=MZwQEkMk5yX1+rfXN+OZ2P0/coye5+EVPFBORSqlwBSvjxvYNv5sKpqCCFT7B70f6JXQEeA2NBO0KdFc4Pd1Igom7rw1f0cb4Uh3sHlMQGc/WAgVxm+yyc5gmnpPlNiNVVBa7p8TCzEqaDGVCS2TWY+OOIWjNGZNpZdV8juqbxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by VI1PR04MB6863.eurprd04.prod.outlook.com (2603:10a6:803:12f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 14:22:21 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%5]) with mapi id 15.20.6678.031; Fri, 25 Aug 2023
 14:22:21 +0000
Message-ID: <d62e6d74-8906-74c6-7389-594f656df9e9@oss.nxp.com>
Date:   Fri, 25 Aug 2023 17:22:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC net-next v2 4/5] net: phy: nxp-c45-tja11xx: add MACsec
 statistics
Content-Language: en-US
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-5-radu-nicolae.pirea@oss.nxp.com>
 <ZOivfv6H60faLvCi@hog>
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <ZOivfv6H60faLvCi@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P195CA0013.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::18) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|VI1PR04MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: ada6c8a0-adc3-430e-bb7a-08dba576b172
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztXnVLblPw4gNovWPD/kTEQZyjZ99D3w4XjJfgY8HioEdajiwmJt5D2VQPbjFsh2rsAE90bqQ/IBHDso/nInnoZoZLnL2ILPlECmIN4RbINr2kRaTXG9d7fc93J4dcsNQRnn58xo8rEdw41kXLOF0I5+oCwCGCWjIGxLFsQP+hZBTfzdlmdSFivAca7LYrFbkyRbuvoDRGyBChtT9L2OSTyow9L+jNLSdQFUgKm99MjZBeubwfNspe+oAKG1PCGv7rtFtPG3+Fk66w0NJ9NfFH3Yjp4bdH9AwE+ydpbHqPfNNWtgG8uJcAFHgBTN6fYwr69tdg6Yf03Fia/v880vmjVFYkhxR58uDM/5B6shtqSsDvqY4GHaSGlTeYYw/yeB/MAyIYQWLnLkbqOApFc6Zi5U9SUr4kx61QRARa2bNfbN1M9RI3FOWLWT+k4mJ6ZLyxqI1cf3RL+G0uGtbEjbl2D/p6EJUz4onbM6I+zdf0QYBYFWjxp6Nv1yAzORaX2QrA9I+WTTdIbzA92dDnshSbPs18kS7ZNvgiJ5DtpzA5u3/Ox0NeDT0nmhZQUerox3xe7ITRWRyxzguAXuOj7R7IKce51krF77/BS8LNHdNDcQy3IkkEgMYEIB/5Iuha9bi1UzGCvIN/sdL9crRaqrtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(346002)(136003)(186009)(451199024)(1800799009)(2906002)(66476007)(66946007)(66556008)(316002)(6916009)(478600001)(26005)(38100700002)(6666004)(41300700001)(53546011)(6486002)(6506007)(86362001)(6512007)(31696002)(31686004)(8676002)(8936002)(83380400001)(2616005)(4326008)(5660300002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWpJSVkzY0dXaWg4dElRYWJGOE5sb2VubUZ5aWtiSzB2aDNwbHVZQW5yR3hR?=
 =?utf-8?B?ZUUraTFpRk4yamtHckJOSWo5RUxycTlPajhMS0dIK1V1RStWZTZzSXZ1c3BX?=
 =?utf-8?B?Skh4UDFIdjlYUjZ6U3Rjb1p1SHo1N0VHWTFvVFZCS25ockJrdzd3enY1Sm9X?=
 =?utf-8?B?ZG5iK2Rha28wSjQ1bEZsQk1RV2dWNHlJV1RhNkJVbG1zWlpJMzZLQXJVd1JF?=
 =?utf-8?B?bmlBOTdTTVdGTHhFS2hFZnlYaWJheWFnUlZTbzVGK1JhMTJ4YUxWanljbVRi?=
 =?utf-8?B?S3ZHTWFDeGM5YmZRR2s4STdoOGNsR3htazdiZFBUY1BSMjdySXRacWdyblI2?=
 =?utf-8?B?RXhERlUraGhjQ24yRnlXVVI4Q2JpNFhKNERrM05zNTZNUitodUFMUS9jbGEx?=
 =?utf-8?B?S1RzcWlsdmR2Z2gwUWFNSkx6MXZvTXRFeEo1Q3lBYWsyZEZxRC9ldWVBL1Ez?=
 =?utf-8?B?K240MnZUWUtRQktWMnlLU2tkSjVNYmk5NDJPV05ZYlJDVmZTYUhwQktRWFEx?=
 =?utf-8?B?YlNZN2VONmMvSEFDUXJrK0pBblhYYitpLzVJNXBQdzhoUWV6NTlPeGpUZDFv?=
 =?utf-8?B?YmdHbjdCNUdhSWIzQlFSNndsY2M3TlJiZ01TdWtuS1NVd0F4bnBSazlmeUdE?=
 =?utf-8?B?Wi94U1QvM3BuaTQyMkRjWjJ4MEorbzZtT1JQMnFOM2VCOTRIaWhOOS9RYXJy?=
 =?utf-8?B?S1hXU0JtR000aEtTUVVmMVBia3cyRHQrU3NjUDVLQTFtY05nZkhpQlcwOEJu?=
 =?utf-8?B?Qm1ReU1DWlJJYjBrTGZOeVQ4cERHdGtDaVBSVDRxb1pNd2tteGdLMmM5THJx?=
 =?utf-8?B?STNMMmd1MWQ5ZjUvSU5BeEJHSzZPdmtYN1pCUy9UaWF5VDBZSkkyTEpOZWhH?=
 =?utf-8?B?YVloU2FqeE8rdzRhRmMwSk5xM2pLcXNVYkI0a3M3Y0owckVJTUVxa2RrVHZa?=
 =?utf-8?B?UVNvQ3hZUFFDVU96dmpzK2IvS1ZMb2V1MFlmM1A4b21LdTROc2F6MUV0b0No?=
 =?utf-8?B?eEE0cTltbkw1V3FLZDdqV2hpRlcyejYxWjRlWllJNEg0NFZ0aS9LbXVSOWJu?=
 =?utf-8?B?aWVpNG56UWF4T3lIcXllN2hBR1ZwQUl5eWluNm4zaTE0V0d3a3pXbUVDSENi?=
 =?utf-8?B?OXU5LzMxb2NyZERaVHhjWE5BOEtKdDE1WkhNUnk2VldPQUcwQU1id1lGQ1Fq?=
 =?utf-8?B?WjVQK3NVNjBqc3RwWmpoemNZWWd0RVpKVTdtTVRNWGVidWhUaGFmNmlqekg5?=
 =?utf-8?B?TlJoc0tIdnNaS1pOZEo2a2s1TThKVWorZXEwRUNwTmlJUlNIQ3pza0tSaGU4?=
 =?utf-8?B?UjJlRGdTcEQxVWw0L2tJTGk0eTEwU2hIdGJmY2NTZWVIWEVPblB4UXMyMXMw?=
 =?utf-8?B?d2ZzeUYvY2gyNVhsK1lkUERiN3E0QmpvT2kxeVV5MHIrdEhuczI2T01ManRU?=
 =?utf-8?B?QzFuVjdNY1pSd3dYZGF5RGFNNW44SGpWMEtBSFp0QzU3eVdGTUU3ZXJnSmRs?=
 =?utf-8?B?ZEpBajZiRWRDZVRjdXJ1UDkraFpsWlVzU0l4SUc4Vk1ubWhPeE56ZmNxc1Jl?=
 =?utf-8?B?V2hUVEp5ejBMakppRlA0cU8yWU1XVWYyUTFJSEltVHRXZzNkbHFsVXNZQk5Z?=
 =?utf-8?B?YVROWVV5TmVIZ2VNTHFLNDZNN2YrOHFJaDVTeXlsbUdVdlB4MHZZYnhhWUVB?=
 =?utf-8?B?VGxwd01zczlYQjVuUmZBbW5ER1JSeE1Ub2t1Z3h3bDF6NzJCTFFIdk9VZjNI?=
 =?utf-8?B?VFoyZElUQ3cwcHltRU0venl3TzhKeWxVR0MwVzRmMDM1cnMzQ3crRXFlMFlw?=
 =?utf-8?B?anZ5d2hMREUvWmZTaTB0WUFQMzZIUk4yN0JOdjRqZGMxd2ZnMENBbDAydzJh?=
 =?utf-8?B?Q05Ic1FQMlRRb1BXZ0VSMGZnbXg2K1pMb2lwSHBiOUFVMUYrc29tWVd5dW9H?=
 =?utf-8?B?ZlI0UGh0c3dwTSs1RnpHZCs0M05sYnNmRXdGRlpmVEFEOGVwWWZoNGF6NC9q?=
 =?utf-8?B?ckJ1NnIvaUdxS0pvUkJDQTJLSnZSbUZNZ2VVTlJYaXZVMkJmVUZnZGhkUjZy?=
 =?utf-8?B?YWN0dXJxVzZIdEkrUDFYbnZCdmZtWnBkREtnTUUyb0hsTFFEaDI2TDgwQkR1?=
 =?utf-8?B?c2ZtZ3hwc2pRWXZ3UzJmVURwL2hpMnprNmtGcDVRVmlncEJzTTFRVllPcUxT?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada6c8a0-adc3-430e-bb7a-08dba576b172
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 14:22:21.0041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uMGpxsZSkCW0f70IxacECrKmUYnePIfgteSxZNog0QG7Qx29oehCKdR1EfYdFpOkmvue1jvYUOb/8GMywq0r1TLPTc0VKWKIi+eZNlQQwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6863
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.08.2023 16:41, Sabrina Dubroca wrote:
> 2023-08-24, 12:16:14 +0300, Radu Pirea (NXP OSS) wrote:
>> @@ -1323,8 +1469,10 @@ static int nxp_c45_mdo_del_txsa(struct macsec_context *ctx)
>>   
>>   	nxp_c45_select_secy(phydev, phy_secy->secy_id);
>>   
>> -	if (tx_sa->is_enabled)
>> +	if (tx_sa->is_enabled) {
>>   		nxp_c45_update_key_status(phydev, tx_sa);
>> +		nxp_c45_tx_sa_stats_clear(phydev, tx_sa);
> 
> If the TXSA was already disabled (via mdo_upd_txsa), don't you need to
> clear the stats as well?

Yes, I will clear them.

> 
> [...]
>> +static int nxp_c45_mdo_get_tx_sc_stats(struct macsec_context *ctx)
>> +{
> [...]
>> +	nxp_c45_macsec_read(phydev, MACSEC_OOE1HS, &reg);
>> +	stat = (u64)reg << 32;
>> +	nxp_c45_macsec_read(phydev, MACSEC_OOE2HS, &reg);
>> +	stat |= reg;
>> +	if (ctx->secy->tx_sc.encrypt)
>> +		tx_sc_stats->OutOctetsEncrypted = stat;
>> +	else
>> +		tx_sc_stats->OutOctetsEncrypted = 0;
>> +
>> +	if (ctx->secy->protect_frames)
>> +		tx_sc_stats->OutOctetsProtected = stat;
>> +	else
>> +		tx_sc_stats->OutOctetsProtected = 0;
> 
> This doesn't look consistent with macsec_count_tx
> (drivers/net/macsec.c).

Actually OutOctetsProtected register is not read from the hardware.

-- 
Radu P.
