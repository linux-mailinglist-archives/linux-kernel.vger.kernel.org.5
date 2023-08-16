Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EE377DE69
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243849AbjHPKTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243852AbjHPKTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:19:34 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47BB138;
        Wed, 16 Aug 2023 03:19:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyD0G3p4NJm95QnuucRR2+NoEL195Jib6jjP7Y65krjBND7jCtKTrbm3FRMk3MXNF6gv5PAyKdYLEaqrGgAXfxCYMee9kp3Xk/9mTII6pI1yEq5e9K2x/NerNabEUgyq+7AqIDy6gMBzhrAIx6rlUThJzU50DqAwequy9pe76dKW2uq7xCEpxr5Q+e421hxmpcr2TAmHG8pfKF4050oawQWmcm75hRk/MoGZHE8SJWMhMcO//+rVqespy9cLnjUwjr2i1XkD/CvTSAK4MnnfE3yfN4wsU2nUJWOA3FPr5Lmgl44a3V7brB4LcrUU5cNwRwz7ce/Gl/rcmRymISoztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJAszJYbWIu1lJU/282dDBVhfccboBPc1ALeXeTGsJA=;
 b=gR+JNAaA0AVnivmXrDvuDsGMJEaga42nXlRxkyuhgqZjwgov+KyDGzQDcxAvE0v6TTB65JX4IXesFoT2r4EY33+GoHcj4U3FNg1UN+yFcGVoUKFxgl+e+A5cBnNO/YXoB7flzXXNdTut/XrhPp+QUfWbm/Pgr7gEbrYEh8tAdUdUrRswRGpBSI/MEPwIyFToNYoPZPUPC/A2/fxuB7IwXQRRBBYyxuIyNHwHBkePu4YQAUJsG5B8/AUNFWPWD8Rts0QrFQesoCB70C4Cxv+yEUFo+UNamXl7FZMddq2HL8svHy0nAbUPSZsbXyrgOIz5sjnYujLltRlBFXfISaFwtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJAszJYbWIu1lJU/282dDBVhfccboBPc1ALeXeTGsJA=;
 b=O5aqoQJnP5v7GzMEjaDqPAPkjvzkzYHPxTGz9/m2DwYAUS5AdP7QmaJDYqUAlhN/w1tK21T3B+VxEIcmtgv537Ir3Y4nN0mPOw1GIaDCfNnLgbslGpHySEHlnohbvldAzpLis9kyNoZ9umhGX42UkFXdEO45RyaM0bYSjuRj2Mo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS8PR04MB7688.eurprd04.prod.outlook.com (2603:10a6:20b:29d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 10:19:31 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%5]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 10:19:31 +0000
Message-ID: <274e3acf-50cb-1665-447e-a049251bc67d@oss.nxp.com>
Date:   Wed, 16 Aug 2023 13:19:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC net-next v1 4/5] net: macsec: introduce mdo_insert_tx_tag
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
 <20230811153249.283984-5-radu-nicolae.pirea@oss.nxp.com>
 <ZNfKeCGf0xZTTum7@vergenet.net>
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <ZNfKeCGf0xZTTum7@vergenet.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0193.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::30) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS8PR04MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b23abc9-242a-499b-7355-08db9e4247cd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhU7poDbFDziF2jDK+BdpZtgMuZiBeU2/zTwrRK7dMVMWSgFco2TNJESA4Af2kh7sD1MhDlhQZYGQGqeqGRfVedXnI19ouKz9eCBfm3eUQNj0Lc0uh+IGoh5Oct/Yl4mGHBXRPfdHSL76EMYPapjUsb9gQFHkahvsDxu6Q+j9RMTE6dptNp9P+YOFIu/J3okuM2xYBH6fNxCUqZmGsPuJXFIgDs/buUC/ZpILQ1VHuf809P8lJAXAYmJ72EVE9nbdTeuCI5umq6KB2pnMfgHOt570PyPDWtyP6qchwKL+tnCVWvXqxXNxK80itEDefRGmmHPzmdkEXfbfm4Qh8POjBlmPy2B0dTczG87301VRxH393AWuUmUGCNCWzinvhDavWRgeIOSYXs/1ytmFw1ueXCusmJwBc0Jrs7CK9XYzsgouKlab5/lha5HmZ8lmpuKgRD5i+twhTBt3UMfaaCUF/vyBgdd9VvxmySjvfJ2uFE9z1JUdlEkEqoaQzP5B6OLih/NyQrrqSjj/p2JFdoMMRqHGHd7AB11ltASv2YiFzQMuypD59zB0QyePBTN5eLIYO0efV6vt2BYr51h8J2vhiHZVPBYiZjfOSBtQzHwqXDQsH9/FsCahs/mEeP1x6VFAoqP0usUW3wN4LEaKxyGLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(1800799009)(451199024)(186009)(2906002)(83380400001)(7416002)(86362001)(478600001)(31696002)(6506007)(6486002)(2616005)(6512007)(53546011)(26005)(5660300002)(41300700001)(6916009)(316002)(66946007)(66556008)(66476007)(31686004)(8676002)(8936002)(4326008)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk5zY1l0ZmFld3lIQUZ5V0NtNjYwTTN2WFJNNUpJU1NpMldBTkpVNU93K2pv?=
 =?utf-8?B?SUljVFZiM3ExWlBadmFSWmhlNHpBV3ZQWVBhYlR4NEZHRzRoSFRocC8zTDY2?=
 =?utf-8?B?cklTOVVZak1wdjNqeTJhZ0RWRjZhUklyM1Aza3Y1cE5LTW9WMlZWWU1JdFMy?=
 =?utf-8?B?eDhYSFNEUkhWM1FqdEdrYnhwdnh4YTFQMmNpaFNoaTlVVk9nUGQzMDlhaTVS?=
 =?utf-8?B?VDJwSkpLN1pOMzNycGtEVEpneUltZzh5Q2hNSXlJUUNSdWh3Wm1WSGRrKzd3?=
 =?utf-8?B?S2V5VjdQRE04Z1doN1ZYVUFYUklHVXR4U293N1FNU3Q3d0Yzd1NPaklrUHB5?=
 =?utf-8?B?ZHFQc2RZd05sNk1UcVNYUkhiaVVvalVvUU1uV1MvSzBRY0NSSWpGU3hZTWZM?=
 =?utf-8?B?RVZCdmcvTlV2T1FpOXk2aHcwYUtLVWpZSVZOZlVkT255TzRhTzVkaTg3aEVq?=
 =?utf-8?B?bjlmV0tnNCtwcEs3WCtFS2xsM3pIbWVNdjNrY1JVRzFYUTNXWmtKYUYyYnZW?=
 =?utf-8?B?SU03TDVsbFNMNlpkSEN0cm1VT2hqU0pNZVFiZXQvOUZVbnV2VGpCUGZsR0dt?=
 =?utf-8?B?bWhUQzJESWFFTlM2UmVFSkVDMUhVbDhOaWxGcXg0eFlqYmVyTTBaeFk3ZVdj?=
 =?utf-8?B?WU1vUEp3V0o5Qm15enRvOWZRNUcySzJiODA2RXIrcWxUWmJNYlgvbTFMVWkz?=
 =?utf-8?B?MXdJNXM5NDFOV2puUm5sSGtDQXFJenczY2sxZ0x4VUNzNkIzajZmSFZIS0FR?=
 =?utf-8?B?TDB2Tys4VnVobXhyeTQzNXNMM1E4M0NKNnZMcW9SRHc4MnpxQVo3bkVHeEpa?=
 =?utf-8?B?di9hUmpzei9KeXdFckswY2NhNmw2M21lTmNVclhFNGpJTmVtN1JqTVNBdW9h?=
 =?utf-8?B?S3dZUG9kdWtuU1NCZjN0QXdBVUJCTUNXQTZEcC90QlJvTytTbyswVFFIVGp3?=
 =?utf-8?B?MzJtbVRDc1NTREJFZlByczVpVkVESW5sVFZxQ2liQS9rblo0MXJmbGpvbkxP?=
 =?utf-8?B?MUpMNHhSdmM4WjNma01vQmFwaXpzQjBjSXlUQ3hoVnB1RVhORzVrYnNLWWkz?=
 =?utf-8?B?MzEyK1hQR2Y3R3VJRFJrWlhLRlVQVHVJMnlGeXlrTHRIVWw4cGliWklLUjFV?=
 =?utf-8?B?M0loRnQ0b3FOR0lIN1lqU2MzalZwNGJCTjFBaG5uQnIyMktqSEd0MFc0c1M4?=
 =?utf-8?B?TUFiZy94OUYxN0o1b25GU21DUEhoaldhc2RGbFA1Q2x3bXpXVGhZN3FIWEhx?=
 =?utf-8?B?ZXJmMUE5cUxic3RCcUsyNUFRZUp3b09hcGZxOGtTcnY5aTdHOWtva3RDSE1r?=
 =?utf-8?B?Qm1IUUl5YWsrU3hmbjNYL2R2R3RoUmh3REsyL1lmMG55VDZScWZLQlZBK1pI?=
 =?utf-8?B?SEFFVXdoeWZhOTZrQStDR2tTbmJpVWFJQWFoME9vTG9tRUdxWGh4NXVXUEdB?=
 =?utf-8?B?N3NJK0twR3R3a1I3SkZld3JmcWNqNUNzNkRkRjdieFhWV3lWYUZtMEtLaElW?=
 =?utf-8?B?K1pza1BZMHFkNUZ1ak5tUU5MT3BtSDlTQUNST2s1TFZ5Mk1kdW5oVi9yTkx1?=
 =?utf-8?B?ek5GbXkybmJ4L2pocmVUL2VjR2p4SVNnSTJhZ20yL0xvemxpR3M5TTQ2cm13?=
 =?utf-8?B?THN3Vml4bHl5VGl4OGVqTjNPZmZ3VXlFdzRkR2dtVnlFaHFac0lxRmI4MTBF?=
 =?utf-8?B?R2g3dTUxVElzRStHTGw0K3VMazhiMEthZVEzckFPbFNMbXhERXR1WmdhQ1h0?=
 =?utf-8?B?elljK0lQZXJ1R0xPeXBGckMxM3BtYXlXMDBxSnBxWEl3TE1JcWIyamxLVmpC?=
 =?utf-8?B?SXJKajVYVDZQOU5PeklHN2tuQmFaWTBIR3BpZi9la2Nwb292TVJMV2QxWnVL?=
 =?utf-8?B?NnVZSXdSaGtxMlQwSUNxL1dMMGRiT0E1TzlrYlhaVy8zRXpRbWRpcEtmZ2lr?=
 =?utf-8?B?M0prbFh1Q0dnS2ovTU5YclNaMmY5ampiSUNBT0pmeWdMNXdqMGEzQytFTHNW?=
 =?utf-8?B?cjdqMjNVdGZpcHIzSUZ2RlVrTjMzNFFjNkg1cW9RR3JsQkFXVExWQjNxMVpr?=
 =?utf-8?B?dUYyV2FtRnZvRWlCeUMrdkxrSm1DbUdKUEtWV2FKS01ZMDFkZG1rbzVhQWNE?=
 =?utf-8?B?UDhzTFhsTkN6U1MyNmZSUmlvSkQzTVVDNzZKNzNWRjh4RVBNcXl4YWd4Rks4?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b23abc9-242a-499b-7355-08db9e4247cd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 10:19:31.4283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fH8cHyRj+VI33TZF3hBDeezSEflVJQmtu4B7tvPfKM+tdroQ3wwChhveoYIa1s7Z9toNo/kUD/jEc35nn+hLygqYwJ12Q7gc4vCwS3Y0vo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7688
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.08.2023 21:07, Simon Horman wrote:
> On Fri, Aug 11, 2023 at 06:32:48PM +0300, Radu Pirea (NXP OSS) wrote:
>> @@ -4137,6 +4211,11 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
>>   			if (err)
>>   				goto del_dev;
>>   		}
>> +
>> +		dev->needed_headroom -= MACSEC_NEEDED_HEADROOM;
>> +		dev->needed_headroom += ops->needed_headroom;
>> +		dev->needed_tailroom -= MACSEC_NEEDED_TAILROOM;
>> +		dev->needed_tailroom += ops->needed_tailroom;
> 
> Hi Radu,
> 
> Just above the beginning of this hunk it is assumed that ops may be NULL.
> However, here it is dereferenced unconditionally. Is this safe?

Of course it's not safe.
Thank you.

> Flagged by Smatch.
> 
>>   	}
>>   
>>   	err = register_macsec_dev(real_dev, dev);
>> diff --git a/include/net/macsec.h b/include/net/macsec.h
>> index 33dc7f2aa42e..a988249d9608 100644
>> --- a/include/net/macsec.h
>> +++ b/include/net/macsec.h
>> @@ -272,6 +272,7 @@ struct macsec_context {
>>   		struct macsec_rx_sa_stats *rx_sa_stats;
>>   		struct macsec_dev_stats  *dev_stats;
>>   	} stats;
>> +	struct sk_buff *skb;
> 
> Not strictly related to this patch,
> but it would be nice to update the kernel doc for this
> structure so that it's fields are documented.

Agreed. I will update the documentation.

-- 
Radu P.
