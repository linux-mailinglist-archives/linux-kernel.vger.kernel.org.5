Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C2A788439
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242189AbjHYKBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243176AbjHYKBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:01:35 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6672117;
        Fri, 25 Aug 2023 03:01:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHI3cWrKkRfm/tcxdUaPPv96JnnDidymR8sUPYEgW1Nk8l8foUReL9dGis6qXZQXowxYVBqtp0AZP6nWLz6TAvX6xbIYF+z657T9IG+vtSzAKo11kL2+jZDxFQ9DXOzbzqgBLuP70QnRko6UN2iSOBbIV8kiAFUCHsNMMOXeruFwViOGCYna/qUWUHGP/MK+RkyI7zneK+nV9T1ZgiYEciZ36Ber9jXDjC3IB2iuiXd5nah5C5TPz0DbaX4nmhp6eGcb1mY2AspNH2Q511gHgkogW7YKW7qiDB8j3cUjrpSTCZix4KNHtI7VbuYpEWGpPEM6Vq6mi928qSz1jezqIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQ5OETnXVCvQQdt4eAHlD+SSZp2WPgziqsphcm5XOlY=;
 b=QussES1IIc9ntK35nGdZ0ADlkk7fPIFh9ilY+2TDVagRCp/ER95MaDMZrNFJFtfcyBJA3D1SP/6HBsCijK3rV4rKaVT6lxhPvveUtMqnuqaV5SMQ942TZ//XUvN6GXWBf5phEpWQIVLv3ZAu/zqLvyv+rX5w6vUKCFftSl2WjlCNqZThKbB1r+WTlUwOvczFtjD4Tp+hljHF2HdTMBHYumiQVzAtXQxy3XwI9rTLrtLjen8fGC34R4OQC01t5d/FPXAnVzPSwF2d/BgbysOW97H4mgPo6OTa5suHf14MXXqXAQGtfgy8jcpUfsJcuX62zne9sQYOCt2xk5o6I8rw8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQ5OETnXVCvQQdt4eAHlD+SSZp2WPgziqsphcm5XOlY=;
 b=LBloRVaSdB0W41bY3MWzq8l8nvwAv7Kzw3sB94Orp/335UcXM5xz0fhgUviCzsXjlZjU/662Nuz4aMlSQGDcMim4hDeGJJljxfX0rSJ7jQlLpeY8+1JpS9iA5ojjbIM171SGa0mo5tOxJYJsZxMCR9aUu+Rs5GmFWPNSRlmEEhE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DB9PR04MB9625.eurprd04.prod.outlook.com (2603:10a6:10:308::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 10:01:21 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%5]) with mapi id 15.20.6678.031; Fri, 25 Aug 2023
 10:01:21 +0000
Message-ID: <a5ef22bc-2457-5eef-7cff-529711c5c242@oss.nxp.com>
Date:   Fri, 25 Aug 2023 13:01:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC net-next v2 2/5] net: macsec: introduce mdo_insert_tx_tag
Content-Language: en-US
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-3-radu-nicolae.pirea@oss.nxp.com>
 <ZOduuY6cfXbgv_L3@hog>
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <ZOduuY6cfXbgv_L3@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0012.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::15) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DB9PR04MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: 805e6f9b-d710-4db1-d130-08dba5523b71
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXFLwXB0KFso72rMVqlP61DD8/QO1faRfSKX4c8wJZTrcqJ1TLSTXuMZtbrRZzEAa3bVacqnH9h4HXIXBBF1Al9EdO8gDf4R9L0a6sFtTRhX9HX1iqtgGdT0p0mSgeoII8x9Ex+gc3SeIvw1K5R1FsI1p6qTnPGruHU6xxsh3lAsLqmfug7XJCpaft7wbrqkzn6DQ0K4BVYzpa2C7uZN5gQ49BsVuk1JPEMv1O+EO/CAu2GAFuX6jH6aKmIaCDpvFDrZuJGii8lQTf4HSjtst1K0NO4j62Yhf8v6Bn+jgUZYi91r9bRlqVymeivl562lDNT7lInm16cg8QBEE/8Dy0+kWJYuREbEiDRUiUgu/l8fQGvatYRjsRu/oq1cedtj4DO1b8DgvD0fzxDjdgM7FCL6Oe48rJWvLfGAceemmOSe6aZAWzBKlwV4Bida+TPORR/eo4x8IdSHLFwuw1JcyxhRZHy1nVwsO70i4JZkNWjp1zQ1QRgzmUSzIkq48ldUvVZjhMb6XxQ6luuuI82QSQ59ODPwrs9rGW4dfCPlXFnLTRwA5nMX2U2CzKc8L50zqkrDEmyYnDII6O8C6nzZ5mbabc9iF2EtZKL8WZiEDzXjxayMyn44PiIbshmee+uzHHQHHT5ofizH0NIJgMMBPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199024)(1800799009)(186009)(38100700002)(8676002)(4326008)(8936002)(31696002)(41300700001)(6486002)(6506007)(53546011)(6666004)(316002)(66476007)(66556008)(66946007)(6916009)(86362001)(6512007)(26005)(478600001)(7416002)(31686004)(2906002)(4744005)(2616005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U25DVy9sMW1HaDlmR3FNcGJ4a3hWS0JzOTZVREt6NjlGek1VVExnUURqODl5?=
 =?utf-8?B?NXRwWmszSitwRHI3TWZDWHFRc1l6WEF2dGRCc2M1cE4zZzFkTGVqT3dwUnM5?=
 =?utf-8?B?dkJ5S0dXTExhZXlIZ2pRREoyREtpQzRWdmNROHpFL2tEQjJmaUtyOU9vRkxh?=
 =?utf-8?B?dU9EbTB2TTZkWHhaN2YzYU9wWGVNOGRRL3NJb2lCVlV4U3E1TmpQUm52elp3?=
 =?utf-8?B?d3l1R1pQZUo2MEFsWUdlNzh5Q3NiUjNGTTlrd1hLcTBmU3FLVkJiSXdWb1hv?=
 =?utf-8?B?czdGRGtMVklUZ2dvOXUreHVpNmozd1JWeEYydWFlY2RyeFYwajAxVVBlaEJl?=
 =?utf-8?B?emJncmp2cXlxb2drZ2I0K281ZmV5ZjNhd09aNEJGajhZd1I1eEVmR1pta3ho?=
 =?utf-8?B?ODlTMkdCVmlUcWFvQ3FZVmMwTzhEcEEzNnhrV0ZLUmFOU24rbHhvcVhGUkZn?=
 =?utf-8?B?ZUpQY2wrQ3Npd3FOeHBmWGROQWNySGY4VFVrS3VvQ0FTSGNsV2xpMGkreU14?=
 =?utf-8?B?d0g5MDAvZGVqM01WNVpDZXZEbjFzRE02RGU0cVQ0WU42RjlINzltUlpJZW0z?=
 =?utf-8?B?Z0VaVEJCK3dhcVNST0VvL1A4b3ZTQTduYjU0anNPVWsyYkNIcE9BejZMM1ln?=
 =?utf-8?B?cWNqZ2ZybjNGVFpKUUdqa3d4MmRXL3NzVTNxdG1BUXhDTVBlOVpJTEp6L1M2?=
 =?utf-8?B?RUc5RC85YWE0bWRYa1JWUjh4NVpJTHRpeHRlT2t2THkyb1BQUDFYQWJoSDND?=
 =?utf-8?B?N1lEVlJMNEpVZEw2MUMwZEptMmd2M2lpVFBJSm9DSnpGY2duVHBTM2VacW4x?=
 =?utf-8?B?d0lBc0UzaTZWRTR4bXV5SmlLVk5oTHJoeHJCWGxhQWEyYWRIUkZtNmFFYVI4?=
 =?utf-8?B?RDhZai9ZdlpUemJwRzVhaUdQLzFmOUNJdFVRL3h2YzhOVndlUTNCb1Y4QnNO?=
 =?utf-8?B?eFNUVWxHcmdPcnNwNmU2YjJtUnhhTEpDVXFoM0U0ekRvVUpnbmZhOFQ3RGEr?=
 =?utf-8?B?N3Rib2MyQTZCdGl4TDF5UU9aSmdXK1JxWlhuU3JOUVZFNFUvZm82TzRPUHpz?=
 =?utf-8?B?SVlOVk9vVmZocmFEQlB2U2ZidTNNdE5veDEwNE1OQmZJemdockp2aWhLR2ZS?=
 =?utf-8?B?aWF1OWYvV241UWVzbUZwb0p6ckJNbllud2ZzNlFXZmx4SzlxempPNHIvZU5J?=
 =?utf-8?B?aEtDdEMzVjBpdVZEc2xNREpHVW4veVhDUm1PQ1FTc2pXSTFUTEx2aU1TQUVl?=
 =?utf-8?B?MjBXdzBZMDVUVmNRNDNlVzQwSWhHY2ZRSDF0SGNITGxZRDZEaVRtaHY4bFZB?=
 =?utf-8?B?cmJXdU5JVGNFYW5odmt3dFU0UVlxL1N5TDEwNVRBWTRVeFpUdTdWamhFWTh1?=
 =?utf-8?B?a3ZYc0loVUk1Skt3SzdTckpOSjJiZ1VNSnRxVlMzWEFFbFN0SXlkWlVVWWZx?=
 =?utf-8?B?V1Eva0RSNDJORjRscXNGK1VDQTlRZVZKeXJzaGJDK2NvV3dkTFVoMGJ1N0JC?=
 =?utf-8?B?dVlvVkFLMDZRbUVKQ0dIQlViTkVzT3dXYUpTRWpRQ3lBcktQbnRMdldla1FX?=
 =?utf-8?B?Y2lmN0V2dTBvYlNmN0VsQkV5cjRXZmhsdTU3VUg3aktNZ0sybzJNUUVrOUp0?=
 =?utf-8?B?d0IyNCt5aUZiS28xVCtoYlVNWnA0VC9LWTVlNHhrWEVuWVloaWRtUXVJMUJ6?=
 =?utf-8?B?Zk1EWVlnYWdWTDY4ZlRPcEpOWnZmdkNjY3lPK3J4UnhKMFJ1ODFpNzVheHNS?=
 =?utf-8?B?aTIxZmR2dEdFZDRNYnVDWHkxdFV5SXhYeFJnelIyT2lJTWhVL0pZMFpJMldR?=
 =?utf-8?B?RDBUenh1b2ZBekE1V0lHRlVZVTlPR0l4SDc0Vjdsb1FmbmhlQTFFTEMzLzlj?=
 =?utf-8?B?TWJLYkNKTWNiNzllNktQYS95cG1qUllncUY2cXJqZHI5NUlwU0lRTEFETTA4?=
 =?utf-8?B?RWx5VGJZTGh2TTdneURBWUFPVUkyeURuQXhpVEtmQ3JadnF5Z001VGdQUE56?=
 =?utf-8?B?RDBTQkMwTVdwQlpOdC9GWDBSbHh4a2t1dlFzYlc0Z3FCa05wcStBQmNsNm9V?=
 =?utf-8?B?dDliSnYyWitVNFhvdnZuZ2FscEliZVpjc0wxbVdXUVJySXF3eEIxdXlaUWJp?=
 =?utf-8?B?SkdxamRZSk9QU1FrSmpXd0Vnd1dkcWJhY2daTEM4cG9sY0Z1blV4eVNIekVT?=
 =?utf-8?B?d0E9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805e6f9b-d710-4db1-d130-08dba5523b71
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 10:01:21.6227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdICKeVtyLvtHWDy5jEQrfZeB0+t5qdhP6q/p8oBorHaJ/8la+2ik342NPD1Xn/ZAhvIHwu+8RASGpJuMg5TJwOJ+aNQEB+haIHGi114xRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9625
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24.08.2023 17:54, Sabrina Dubroca wrote:
> 2023-08-24, 12:16:12 +0300, Radu Pirea (NXP OSS) wrote:
> 
>> +
>> +	if (macsec_is_offloaded(macsec)) {
> 
> Shouldn't that whole adjustment (in both directions) depend on
> ->insert_tx_tag?

I asked myself the same thing and the answer was "It depends". This 
adjustment can be restricted only to the offloaded MACsec devs that 
require a special TX tag. However, the offloaded MACsec devs do not need 
additional headroom/tailroom.
>> +
>> +	if (!macsec->insert_tx_tag)
>> +		return skb;
> 
> I think it would look a bit nicer if this test was moved out, before
> calling insert_tx_tag(). Then if we call insert_tx_tag(), we know we
> have to insert it.
> 

I expected this suggestion :)

-- 
Radu P.
