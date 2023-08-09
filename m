Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735EB776126
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjHINfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjHINfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:35:10 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2089.outbound.protection.outlook.com [40.107.241.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCE81986;
        Wed,  9 Aug 2023 06:35:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jvm+CAR4Bzrva8YwEAwnBtT2CRltQdTvXxw1NczZezNMaCxBuzJy/4MjZH1G5dIayNttis8a2hozknsw4VGce6yW5GZS1GhIVD1NltcGMsIabiS3tRM7rV2tXI9ltTZuhy1HOp673N94RRAAh40ilmzBh5SJ9h9TGMWjmQfKvM/6jyRLy2859rmSJu1cyq73GugmwQJVYkYZ2LlkY1JPIslbsJRQCgcEiFlCmA5rMI3+HMu6y6UEJol/f7uzj1GiKtdr9FcZ9MCWd5uEC34Ys/01Vik2OZhid6u9IlreYFBIN0NHspSpk1z4WVKlLBqn2uP7OHvR9M9iqZDRbx1xWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hOsLC85Pj1yRgxfWE+2sOzsup4hT9zk3K/87i7/rW8=;
 b=XyEyzTv74bvi6dWFTV09j4ziibX5matswdCL3YCzuu4+kX+tks1y/8Ce1XtUHoJ7wSJBmDEiC2d0ttaxwqCLTvf4ID9sLkR+nompcUehQkCP/y9PaHS0IC3kNUZFN1iw6AkuS0/ViIZmP5zC4b28Z5ikf3RVCDpAkklxW2rNhZkLdULv/NMSleZ4Hdgz1wTIAKo5tbL1LoT41brvWkq4qkpTXeTN+qlUL2FVzyR1/F4XZBgG+Vj2FCrccGpHV2+n0Kk9yXLT6hKwLrXOvVEEQIf4rlOFW3L1Rs9SSsjIJNHk1pDPFzzdUK+LnwZxuSMLHPoKyZ5siK23mjgswHJErw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hOsLC85Pj1yRgxfWE+2sOzsup4hT9zk3K/87i7/rW8=;
 b=c05SlvM/Z1WJnmeCl2S85Y6/o9QFnLvCr/gbO6wT73eH1KvpYDdX+jUsiUEVMNBaNTbQSuVOZ6dwMTpdSF24xFb3Ha32AO6JAxUWK+Rod9VMYoE+bw2i7JBoOo6EjG6qN8xczSeEpcEaM+vjTqc7jTa5I/bV+OPz56JTDCxDyC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by VE1PR04MB7438.eurprd04.prod.outlook.com (2603:10a6:800:1a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 13:35:06 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%4]) with mapi id 15.20.6652.022; Wed, 9 Aug 2023
 13:35:06 +0000
Message-ID: <d5690d60-addc-7cff-8a61-33322878bd1c@oss.nxp.com>
Date:   Wed, 9 Aug 2023 16:35:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] net: macsec: use TX SCI as MAC address
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230808141429.220830-1-radu-nicolae.pirea@oss.nxp.com>
 <ZNJdo6bow7uK8bTn@hog> <b33195b3-aa6d-defa-97c4-280da7e5e6d6@oss.nxp.com>
 <ZNOCLV6NZvzuPeWB@hog>
Content-Language: en-US
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <ZNOCLV6NZvzuPeWB@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0230.eurprd07.prod.outlook.com
 (2603:10a6:802:58::33) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|VE1PR04MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 0253937b-5319-4435-3478-08db98dd7152
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uCs5abGPXvcHc7apjjnkf1JjA1/2OAHc1ZAOpyR4uUx2FE8eclXJuncshIxeYUrIrte1nU+kc57JziUS73nrRNXzUXxqERNWtMI5Qr7ZD5e4tt+DO+wxh1yGJA9L3lS+k8Wc7MHgeJpOlVqP4lkjTqp+bqpOAVa0O4XPU74bKp/ON43hS2IVx4FZjFSjjf44OXYugPJEKOI7w4ID9UKSh6rbfw9oeNnkV+JFoWEnxQRCu94Y6wvjtoiBn0YOrg7BnznM0r32l0RHWMV9j/RKsSm/IsHYTS/Xji9K5ykm6CIYfoHKvYjGM3ABJwzZxWgAZNe941kyeuUTBrkos8DLDnlWyhf1cFILwjqlnQ+8KamL9HXGrZ55OPECqJqLta523cVBr4xe+O+Gs+Fsx62bluESdxZi/GmWSIcF1muHRsYcElvMKIlkcGSTaGhoPxpTsrofKiZFcrM02HnCsnRnJdtqH2btCTRfxyVnWAfQYtTqU587p5Ywj2TLvH0ik0OEGalivF4eiwka0nIxpoG3a3qkg1mGsXfEyNEOQWI31cQBdKMH+fbHiEYozzs05MZBhrRlUxGWvzJU6/rFm/Dmw9mR905yrblKUsD1QvnifBoSC+5wwdv6z0aNoAqvW/veHds22RG0sT68t1Jv8k+2I7HxlfXrfXemh4WPLGJiBv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(1800799006)(186006)(451199021)(6506007)(26005)(53546011)(31686004)(6512007)(6486002)(2616005)(31696002)(86362001)(478600001)(316002)(66476007)(6916009)(66556008)(66946007)(4326008)(41300700001)(8676002)(8936002)(5660300002)(38100700002)(2906002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGtQdEVqeHEyR0FSM1dPaVkybVVIcFZnSktFcEhBTTRYQXFuZlA5aWlJa0ZW?=
 =?utf-8?B?Y1doU0VrU1VPY2ZPR2ZVSmYvdHVSL2dNWW43MEVSVk05NUpRbDZsaEdWa3d3?=
 =?utf-8?B?bFowSGJUc1V0ZGVESno5RjlXcHZTWjc4OUF1RHQxeHkvSVdvVUkrUDh3Skdm?=
 =?utf-8?B?RzJnSmVFRG9ubWk3UkljdlpvSzFEZmwvSWxBNzhxSkFpZjJDaXZaZmE4bDJ0?=
 =?utf-8?B?d3g0TjVWYzhaTnVqZ3lhbi8xUG83RkdFSFFrZ1dzR1F4dk05dktSY3B1NS91?=
 =?utf-8?B?R3ZVMVgxczZtRFIxVCtwYkJzaW8rZzdJOWRuRGJod0dSTWo2RDd5MjlkZkNV?=
 =?utf-8?B?T3R6SlczOE1zUDk3WFRBZUxYaHc0Z3FzSlZIUnNmMDUwMmxPY09kRUxzWXgv?=
 =?utf-8?B?amtDWG1ETjB2ZTJjRFBueS8zaUZ6TzFtQllBY2xlRDV1WXpuWnJXcWlTVUZ4?=
 =?utf-8?B?SnpWdE5mczlGMjg4aXBYZjRMZE90VXBBU0tJQlBodHg2eXgxU29YZmJXK3F3?=
 =?utf-8?B?TU01NW1ORlQ1aHNmWkpYWjY5Vkp1WUttQjVmMlVGOUtYTS9QS0NzVGo4NzhH?=
 =?utf-8?B?dVAySys5NUlvUjVtbldQY1BTWlh1VXNoR2xEL0Ryazh5d1A5WS9UUjRQZG5E?=
 =?utf-8?B?UVF6bkk5UldQU2JFVXpKMUpkNS9qQkY0QVptYks4UVdSazI2YWFpWG5KUjhk?=
 =?utf-8?B?UzRuR0E2WHR5U3JSRFQ0QVQ4clBRM2UzbTZENExWSTZzYkdyRE9lMnFZZHpM?=
 =?utf-8?B?aThseVg4UUZTYTBWbTNZTmpIWGljemxiM0IwRzk1T1RVTVVPVitySDRJaFpU?=
 =?utf-8?B?RDlMeHlza0JCOUFRSEFES1lZSUNYOTB5QWZuSkdkc0tMUUQ1YnJ2NDJObGgy?=
 =?utf-8?B?YXVRbGNFYllYTjZKRVFSb3ZzblliQnhLUWNydGh0b1JCQWVkOEFpTnAwYmNs?=
 =?utf-8?B?cVZuam96dE9IM2pHZ1NBV0JWQ1gxcGg4aGFzalZlNlYzRjBSMWNLREVlZFFJ?=
 =?utf-8?B?ejlEWHBBSHR0Mi9DSmRpMnJDVWtSN2FITEZJR2RqaTE0QlBCRENjZlJUdGk1?=
 =?utf-8?B?VlZxTkVqejlpd0FiTFgrWm1Lb1dHbVozR0kxQjhzZzhNUXNseGd0YWZIZzlZ?=
 =?utf-8?B?NlJ3NDVWT3F5dVRUTUNlbUVmblZ6aXZzVDF3ekczUGFhMTFuSDUwVXZoTndO?=
 =?utf-8?B?aEhjbE0yWm11Z1l0NFJtZWNFbFZzV3BMUkhOeVRKSjJTc1RERk4xOFhVNGZY?=
 =?utf-8?B?NnFxMzE0Q1lrR0VMVTM1dFpSNjJEaENNak95V3dWZVFyNUpQN051d3o4c2Qx?=
 =?utf-8?B?WU1XZlBCTjFuVnNhZjU0bkpoZlVzVGZUdXg2Sng0a3JxSWNqUVZyN3ZHNnNp?=
 =?utf-8?B?MCt4d29mT2RYWDNQVGc2MlBWeldROVJvc0k3OEdTKzh6R2o2MnNhZVhweGJt?=
 =?utf-8?B?UkxLRmhQOEdycEtOREc2MEExUnFUUE9QRmJzVVg0SVNTQWJyaXNveWZOWG1Q?=
 =?utf-8?B?ZWpxd1lBRTc3Q3YveW9ObVhUY1RZUk1CanhER3VqWkYyUWxKS2ZEZk9OM1ZC?=
 =?utf-8?B?bS9rRFJyRVhjcG95anNwaW5DMzUyRmp4TjcwV1hiRmt4cnZDdER3WlRMR3VH?=
 =?utf-8?B?L0treVhVeEcyQVVINngwcU9YRHROaGVHT0dpWHZQTHpEc1VJNS9tejhIMHdS?=
 =?utf-8?B?TlNFakxlM3pPVUFKNGhEdmRKb05QRzhPYUh4ZjRsTi9EOC9Wa3ZGRWFmcUNu?=
 =?utf-8?B?VXZNZjVDQlhTY1BYdGRuVk5GaHFmS3dIZHYzczhJQWdadm5CWWNlRncwS2Nr?=
 =?utf-8?B?QkZQVjlKZWJIbXNma0ZveEgvalBLWFNmRkpuamtER0xoQW9Lb3VJSEZJdlg0?=
 =?utf-8?B?dUtYL2x1aUlDR2VjRGtMNVBuTUltejZkSWgzbDBZZjJyeVNjRHRsSjNrZEtN?=
 =?utf-8?B?Q3FZMlRPUCtMclBBMEk1L1ZSbDdjQkdLWDBDWlFhWlBpdk1ON1VCNHpLSlRM?=
 =?utf-8?B?U2xvbjBTUDYrUWNzMC8rSzhpMFd2RjFIWDJkRkZyMFdsTDJZT3lqMmhNVzVy?=
 =?utf-8?B?UThTeVpENlhaRnpQYjJHbFUxVnd1ZlA3ck5IVmxwcFRVRkhrQU80T1VTZHhH?=
 =?utf-8?B?Y045aHU5a2ZCaFlnNkJpVytydVUzaVJFcmNwWFF4N1ZCYUNUUDVOeXNCZFMr?=
 =?utf-8?B?UGc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0253937b-5319-4435-3478-08db98dd7152
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 13:35:06.3099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: geVDLkv/ahpyzRScCU+31AXvaly5SvR+RcllkeX0aoDucUPRmOqGQPMPwfSKIVU7DFrxSIXI3xRH1zFVZ+WKBfYNpJ7Ejubf8QEWT835EAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7438
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09.08.2023 15:10, Sabrina Dubroca wrote:
> 2023-08-09, 09:37:40 +0300, Radu Pirea (OSS) wrote:
>>
>>
>> On 08.08.2023 18:22, Sabrina Dubroca wrote:
>>> 2023-08-08, 17:14:29 +0300, Radu Pirea (NXP OSS) wrote:
>>>> According to IEEE 802.1AE the SCI comprises the MAC address and the port
>>>> identifier.
>>>
>>> I don't think the SCI needs to be composed of the actual device's MAC
>>> address. 8.2.1 says that the MAC address *can* be used to compose the
>>> SCI, but doesn't mandate it.
>> I used IEEE 802.1AE-2018 as documentation and the text is slightly
>> different. However, the purpose of this patch is not to force this match
>> between the MAC address and the SCI, is just to have different MAC addresses
>> when the interfaces are created with an specific SCI.
>>
>> For example, the following command will not set 00:01:be:be:ef:17 as MAC
>> address for the new interface. Would you expect that?
>> ip link add link enet_p2 macsec0 type macsec address 00:01:be:be:ef:17 port
>> 1 encrypt on
> 
> Yes, because "address XXX" comes after "type macsec", so it's an
> argument of "type macsec", not of "ip link". IMO the manpage is pretty
> clear about this.
> 
> The command you want is:
> 
> ip link add link enet_p2 macsec0 addr 00:01:be:be:ef:17 type macsec port 1 encrypt on
Now I see...

> 
> And with this, I don't think your patch is needed at all. It would
> even introduce an undesireable behavior, in case an explicit address
> is provided (as in my command example) alongside a full SCI (instead
> of just the port).
> I agree. Thank you.

-- 
Radu P.
