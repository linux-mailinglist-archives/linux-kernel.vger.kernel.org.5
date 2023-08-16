Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3F377DE46
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243779AbjHPKMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243814AbjHPKMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:12:32 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2087.outbound.protection.outlook.com [40.107.104.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4A7E3;
        Wed, 16 Aug 2023 03:12:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiOA72/9stmuCOmgfEAtHvO0l7Oyt60ZcwQp15/ssaTMTsOcAzDJp+GpTh50kpbd7MR4logPxAyyjnDdEJ9hpmE/LA8z5p244N4AEczEeJwFpsX0EmDuNYbm39J7May0zil7Oaybems/15p6R5aU8nVJCJVv8cLi7nqVz9tnFloGs0kTkBLKrLQMEcZJvvWCkEg6lagdSaPD1uwhj1HkIneU6sxr/oLJ+rkazvywjkayMNj6T0GkFvE2AQyykNq57hqLsNCxJ7tvP/ASnYDdOkhJOL21pqPxRd916GoL8LzKn+InbVMwErk0iE4Jed8dziAKuwHHaGQtF2Jow1IG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEmmQ20UcYPqJscXYcDhjX4KXBb9oYGYKXoST/iqIIs=;
 b=fidkXNaDocX71Q4O1M+bxtoubzRzSmagIxr4BJg+U5kVd22H+rLP3UafhWJkTFuFysOsTCKL1546oj7WOZppKBJ7TLy//cBiMk8nb+EooRiRXcZNKPsTK3mpl06w1yLbWCcjiyuGi0XegprH8zp2MHvrTGrlQZS+IgUDeHCDo6ShlJjJIa04esc8Wpm/WeH/Kkeg8yl+bFRjqMKb3VMAc/iNq4BFdJ6BxI/Sw7K+p2yusVkYLteFugscFqA9qd9wG1gMtiy2f6aW00U/zPHwf8iFaIN0X9MGsSHWldfvQma1M27PMmhxpTdIiQI1g1LPZl+sG9+wnhrVwjL+s7dvRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEmmQ20UcYPqJscXYcDhjX4KXBb9oYGYKXoST/iqIIs=;
 b=UBRrioREQq9bn4IIv5AOH5RPpOYnOWu84hL+WjpQQ2+tb5rPBixFoYAbH5AcgsbpyLzqsrfsQ6IiCuSr6UJrZszJKKxJoTNSFABQC6jANWFmRFjBCg7rR9Vkay5JB3xpg/MWYv9XHS+qQbEqppacrrrqWiUVac+HS2ef1G8ze0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM9PR04MB7492.eurprd04.prod.outlook.com (2603:10a6:20b:282::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 10:12:28 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%5]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 10:12:28 +0000
Message-ID: <6eccb80a-a03c-4944-b7ac-e79e191802e6@oss.nxp.com>
Date:   Wed, 16 Aug 2023 13:12:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC net-next v1 4/5] net: macsec: introduce mdo_insert_tx_tag
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, sd@queasysnail.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
 <20230811153249.283984-5-radu-nicolae.pirea@oss.nxp.com>
 <ee545162-7695-4089-804d-64438e1de620@lunn.ch>
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <ee545162-7695-4089-804d-64438e1de620@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::13) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM9PR04MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f53ab9-21e6-473d-536f-08db9e414bc4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MWJpPoVHjjvhBQAv61iX6F0qYt1Kb2ryypY4OGj7hwikmYspe+lb+aJk3CZ0DXiLlafyrUgP5EXf7Xcc4MqdgZhIv1x5ddTLjl+DVe0tCLENbdGNjnvGcPTmOI6G7MK5K3jFW0L+9Fh+1wUKM5DYRKxB9PNvCtVGDLFANkHmuDHbC7/ilIaUqgIzHKYRHpN1aLZY1BVUlgSZ7eSECanY9jcRLOGzHczAFX9MowCiiUqvJIFgKciFlGqGPIiSuDXHLyzk0Pw0eDmpywfxYOU3jtyjEphX/5NoIKcvoTab25P5OfbS0A4tykXhV6hMidcax5l+4ooEWZxGXXKn+azHLm/JlZtGpUFn4SGwOxrT3ih1zyf/SYryP0T/bnpDacZnjTVJWdGXvlp/C/YiCw+Z/rZNlRdZYhSHtyQjAot88q1GF+mEzvdscIfziocfrDxjD6zmIlD0PXwEzepLWnhQfLY2gx6+mVxE1jZ4A541cp0Nvfo5SxXIz9dJmAxxMLYd4tKPws0SmgKeLYMBKlK0KYDWiWXpk0nmG/pltLavNyOqBwjR8HFL/jFIa2Hnv06ohqV6bAZuxSFovZ0Zdou1ogaI70Ajc41hwaMJCxjNCrm3vLlV71cv1i4wBGfh/TOcmiYDLeelMcbc+2E5sAb7xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(1800799009)(451199024)(186009)(2906002)(7416002)(86362001)(478600001)(31696002)(6506007)(6486002)(2616005)(6512007)(53546011)(26005)(5660300002)(41300700001)(6916009)(316002)(66946007)(66556008)(66476007)(31686004)(8676002)(8936002)(4326008)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0tvVVEwRGVnbEUvVzh3Nm0zU0tjMkV4TjlYRjVMSDIxUXFLSUprTUtLa1FN?=
 =?utf-8?B?OC9sWnZNOEl6U24wckxEMElqZ09yelFreGo5U1dFSWNkTnowRHRjRVFBV0ZQ?=
 =?utf-8?B?aDFGc0JrZGlnVkZ4R2NxSFJrajVXMmFiU3FpcHhqeW9qelJ6ZDUzUG45eTZj?=
 =?utf-8?B?dmsyQXFoUDNZVnFzRXVzWlBNMGVRcFBrVkxrWWRueXJQTStCYTVFWkxERkRx?=
 =?utf-8?B?dGwxMWhXQ0t6NFVVTFUrZXhLQWxIR3ZPQlNDSTFEZEhxakNsMCtkeUJaL0Nw?=
 =?utf-8?B?SHI0UVk2dmpXUURQdFdqZE5pT29iYWJ4NTkrNEFiTUNBOHI5S25wTXEwMnpL?=
 =?utf-8?B?Mno2aEZ5S2pFampMNVR1ZTZ6MXFYeUlHWGcwbmdUaUFVcEhkVHo4d1R0bklI?=
 =?utf-8?B?T05jbUlsWDVsKzFUNXVTaG5CSUJsRnJTN1g0RU4vZ2hxZlFoWllhd0pHTlQy?=
 =?utf-8?B?akNWWnB2YXRYVkFTUklNMkFVVTY2VWNyQ0h2cUszYWpzODBsbUpjOW5NR0F4?=
 =?utf-8?B?Z1Qra21iQjRyQWZmSElCR2pJTDZGM1QvUnB5UXJJdUxkVmZSdmpYMHlOK1FH?=
 =?utf-8?B?U05DUnJyUkpkeTlPOU1YYVNRTkFmSlI4aFVZQUFLUzZGcWZLZ2I2ZFhuZlpt?=
 =?utf-8?B?V3A2cjRrOVpHVUIrRXhiSVdvN2xUQWt4bGU0TVNuV1hiTGtHSzJKVXRLVUlh?=
 =?utf-8?B?NVJpRFVJZ1RUZm9oeHpCcWFTQVFWNlkwRWlObkNyOGxDY3c4Z2FaQ0k0ajF4?=
 =?utf-8?B?OFVCUWY5QkpoWTI3ZThmTGJTbytrL080SCtvSTlacG90ZDM2aHZDdVhTTURE?=
 =?utf-8?B?TXduNUN3MG9nYVpUTXdSY3NXWFVFbzJyeGVSTURYcXIzS1k3YnQ4RTYwdjgy?=
 =?utf-8?B?L0NLeHJucHJyMEkwZ2d1ZmhBRVB6TTB0Wm9PYjJ6NlByVW9UcXVkSXk2b2tO?=
 =?utf-8?B?cGZ2TWpKK2xFbXVsZmJ6SDVlNVVtWmFuYWpyT2tlK29xNy9Pd2lVUFA5WVlT?=
 =?utf-8?B?c0JNRjJBV2Y3NGRUTERuWEhjZDdvbkdOV2Fkby83aHBRWVh1cEtQWSt3OHB6?=
 =?utf-8?B?QmxRcUxjQ2RyYzJZbVJhNm9veXFydHpxVzZlRFV1cHN2V1VIdlFlbTJtNnlE?=
 =?utf-8?B?OEp6K3JIeDFodkdpdWtldiswbmt5Zm9HeHo1aWs2UHNiWmg2VVZvNlEvTG1a?=
 =?utf-8?B?YlhuRnpXdm1JOEVaREJlbWsvTnZOVUhxOGdqRmJCOGsvTDFoVlNoU2RpVDY3?=
 =?utf-8?B?N3BLTFNzTGZJY0NKcU9rd2h6cXl6NE9ielZYVE5aT3RicktWVUZRR2dOQ0c3?=
 =?utf-8?B?dW5yR2tpTEVuUXRPL0RTQ0xTSkc1TFJpWEttZnR2MjRza05PVHJyQUdiK0c4?=
 =?utf-8?B?QS90N3krWnVJOGZaZEdYaC84L1AzUDhVVnBzN2hiMGxlN2RoSFF3K1dNbXhZ?=
 =?utf-8?B?OWIrK0RBRUhOVVRJdnhqa3VmaG9CTUF4QVhhK3RxMjkzWHcrUWNlaUVacTNt?=
 =?utf-8?B?M3I5ZlRVeWpTY1RTQmYwSytmeVh5WmZGNDBjNVpiZ213ekVwV3hrWGxqZlV1?=
 =?utf-8?B?dGdURUhFYVk4UnJScSt0V21QUTFobGV1dFM4RTMzMFBaVjVqcHJvUmZEZm5X?=
 =?utf-8?B?OGRxajVaV1NBVjVHRDRYTGxrWEJiVlVFQkRZZVAySWN3cnFDcWtXQ3pKeU1P?=
 =?utf-8?B?eWFQY2V6cW9jL1VDMzVXRW53SS9WNGFXRXNJMDFTdjRlMnRHeXI1eW5tVFgx?=
 =?utf-8?B?K0Fnc3k3QkM4MElWTUhsbXZYSzNDRC9LRFJYNW1UaGxoY0FzN0hLMzR0RGQ0?=
 =?utf-8?B?b0d4VTYxa1Nqdk42eDJYdVZJWjlBNVlkcWcvZ0xJamtYUGU4WnpXVUM1SGxy?=
 =?utf-8?B?a2N6aXZYQ0V4dXhFMGFzZC9WaG5oSVFmMkVGVFJwejFEZUVaMWVkM0QvRnVh?=
 =?utf-8?B?TXRnRUlYTytFeXBpUGdBYUVpbnFGQTYxTkp5aEIzV21ydEROamR2WDlINTRw?=
 =?utf-8?B?d3lJcS9LMS9jbTYrWDFJT0M2bExVaVRrNUdHZnlIVGQxaW9JMlg0Wlc2WWo4?=
 =?utf-8?B?a3lsaEJpUXF3a1ZXWUZwa0YrZEhJemhJYTY5V3NQZTdLbVZPUVgxaUVJSEt3?=
 =?utf-8?B?M1FSQXo4cEJCeTBCVi9id2JnckpIU2xpeVYxc2VqRlRNTWdjenIrakorZ3Mz?=
 =?utf-8?B?alE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f53ab9-21e6-473d-536f-08db9e414bc4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 10:12:28.7950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcX9lEsviHax06XR9Qa7DW0DcI9VRsLXLP0oSuK3sFWI7E0bUG6XSOf48eXatTPEIV538GLPKspjAmMoJaGawhjC/VG5tH7grwg4e9MZQbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7492
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.08.2023 20:42, Andrew Lunn wrote:
> On Fri, Aug 11, 2023 at 06:32:48PM +0300, Radu Pirea (NXP OSS) wrote:
> 
>> +	if (macsec->offload == MACSEC_OFFLOAD_OFF) {
>> +		dev->needed_headroom -= ops->needed_headroom;
>> +		dev->needed_headroom += MACSEC_NEEDED_HEADROOM;
>> +		dev->needed_tailroom -= ops->needed_tailroom;
>> +		dev->needed_tailroom += MACSEC_NEEDED_TAILROOM;
>> +	} else {
>> +		dev->needed_headroom -= MACSEC_NEEDED_HEADROOM;
>> +		dev->needed_headroom += ops->needed_headroom;
>> +		dev->needed_tailroom -= MACSEC_NEEDED_TAILROOM;
>> +		dev->needed_tailroom += ops->needed_tailroom;
>> +	}
> 
> It is not obvious to me what this is doing. Should this actually be in
> macsec_dev_init()? My main problem is why there is an else condition?

The user can enable/disable offloading after the interface is created, 
that's why the else condition is needed.

>> +static struct sk_buff *insert_tx_tag(struct sk_buff *skb,
>> +				     struct net_device *dev)
>> +{
>> +	struct macsec_dev *macsec = macsec_priv(dev);
>> +	const struct macsec_ops *ops;
>> +	struct macsec_context ctx;
>> +	int err;
>> +
>> +	if (!macsec_is_offloaded(macsec))
>> +		return ERR_PTR(-EINVAL);
> 
> Hasn't this already been checked in macsec_start_xmit()
Yes. This check is useless.

> 
>> +
>> +	ops = macsec_get_ops(macsec, &ctx);
>> +	if (!ops)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (!ops->mdo_insert_tx_tag)
>> +		return skb;
> 
> You are in the hot path here. You don't expect this to change from
> frame to frame. So could you evaluate this once and store it
> somewhere? Maybe in macsec_dev ?

The macsec_dev struct seems to be the right place.

> 
> 	Andrew

-- 
Radu P.
