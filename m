Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D810766F84
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237097AbjG1OcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237091AbjG1OcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:32:01 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2110.outbound.protection.outlook.com [40.107.8.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6B93A96;
        Fri, 28 Jul 2023 07:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iO3umnaANz919k6pTSz98kknY5a/w0tyhrww7OVGZ9vbNl9xB3aaBjoeR3U6vub+I1Eh6WL702cBXoCXnnNjmnTwhmbzA1V1mYso7/qQJeKn2+vfpg/Jib/3w+C1q6O5jCtRo7dByNIzpsM2JTBzGGG/VAJnUBdHo0jLVuMa9dqFGqU6ge7vwyde3FiKgAOM1K7OHAzOynofZvtkUL/kir+PJrs0UEAWe/iOr2vaxKjRxRNMeWOu4l4RvERSHFdhx9R7p133lUUGILzGw4VbSM0bziTSyECHIOfcgwgfTjNNYJH/0/Iq+Jdw3XJu1kKRJMWoajn5WhJmvO2a3azjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qBsNf+oIV3+xJPSCrtpXPxgIeBvOLD+C6xXY/ke0ME=;
 b=TtLMijvGuJrRdosqDldwQR9xRnYse3wvR3Ni3GZoqOhpfSZ2lyiBe8P/oeChR6AHNRYkODcwpJNSTfKS2J0mWUyHIToJth3zRj3Xb/OcfBqI5IRhsYFRLDYQqhb2fwA85OFMrMEHbhlKRDez0yk/VUSJuaF2qREZHK0MTmkGGmq6/ZpAOsa9vCGICvX0VrtVZYy5/F/fkvPvHZLqvGZiLBITIia7VTx2O4lfBYoxqH78B7jDSX2SlftsTi8+z/k6gTXmysXeJmlu/UrgjyayepCIIjqNKXfbFb1mMdgjw23lrXm8sBnDsjmXP0cAMD9xrgaFnh+GrjkkIRgDG9u+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qBsNf+oIV3+xJPSCrtpXPxgIeBvOLD+C6xXY/ke0ME=;
 b=I1nvGfgwjMtL4sQcZtloIbYA+9dfIB47Oor+vQERyXqX/F/TxBfn6LDZYPmHIwRMaUqlN+5SZTpadNsPTkWWDTW4gMYzaMJQtXKf/FtP7o7UqNziUtEnxID2mbuk/37xzEzljbRzzKGi14QRu1IWOe8AqHA4ngiq/sLIw7XEdEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB6553.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:568::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 14:31:53 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4917:2b7d:c561:a3a1]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4917:2b7d:c561:a3a1%3]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 14:31:53 +0000
Message-ID: <55c19de0-2465-cc4a-6ec7-fd524816fd2b@prevas.dk>
Date:   Fri, 28 Jul 2023 16:31:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 0/8] rtc: isl12022: battery backup voltage and clock
 support
Content-Language: en-US, da
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230615105826.411953-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20230615105826.411953-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::16) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 4395b650-762c-45b1-596e-08db8f7762fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tfiXTYP8hHkgtemSG65Z4Y9T9rytpS2NgrgoNdCLGmwHv//TJsSjmVJndQBjEer970BBiKpchdI6soglkh43u2xSQJJTfhTvYLvd2pZp63AGlukwge12X4FN3tDjRiSeWEPmrCpyAVoO0mhi6G7LACZ/IQt2yHqI8gH9ay/qoeLQV0m27DtGoUDF5IpIvKs3ZNburoAhJcZ1dPHIZyPNFPa1dgbm5DaGuZhnWleUx7jBfWLlnc0cugCnbddHIlOTxU6e8clTuSnZH2oPHVX9UgOGcixmHoMDjiQvBm8iMuyuvmZmGKy4GXd2H7HFtkMp0Q3xq0c/KH4MqzQm1DCOgUlHjalI3+29Q2wbcM5a5tiLCJfvOfIuxbee+yEh2eO1OhlP3gBbDkTerm1oJhBk/5W1B5ZTc0TfVKeEnpEqSMWV0h61SDhlXWeQmxC99PPfy17cEFuK2SJltwMKCY2UDgZ/kgA/dkWu9cyM/Lh00CTanpJ+EktJLjDv32pJGp9FuP+86y/zfyQncqo/1HByEpadYKKniqi+PUr11iXRWDNqnB2xwEhnbTh1BmNUGcIDovQ92Lp4U0A2Bw9Dy/OgGzjmLVV+yGFMZpNoulQl/X4W+TnwHB7L4Je3alAGAy/IXO3tQbOkaKmis1TRIO+L9cOgG0GNimCroKL0nlLv+HXFb/qgX+rKh66eLL8xfUQg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(366004)(39850400004)(346002)(451199021)(36756003)(31696002)(186003)(6506007)(86362001)(26005)(4326008)(66946007)(44832011)(66556008)(66476007)(6512007)(83380400001)(2616005)(31686004)(6486002)(2906002)(52116002)(54906003)(478600001)(110136005)(4744005)(38350700002)(41300700001)(38100700002)(316002)(7416002)(8676002)(8936002)(5660300002)(8976002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjBqT2FSRkd6bVlEYXZ5N3NZclBXRi8yem5vZ1VEQ3dYMklVTXd2b3pYWGw4?=
 =?utf-8?B?Yjh5d3k5dmpsa1pwS00xcmRaNFJScTJHTjVGMkFiS3dxd1FjbE5lVHNHaDJr?=
 =?utf-8?B?bVY3ZmFjdGFDWFZ3bzM3YlBBdk0vTHc2YWp0ektBT2FsWUN0enlETHY0ckVh?=
 =?utf-8?B?bkNRQWxnWXRJcmt5R0ZNNHcxWDR0b3dyMGJ4Wmo0cVhVaG5ianhpTDJjYUdq?=
 =?utf-8?B?Nm9MLy9mN0pQbGdsNnlFS05MQVlyY20vbHcvbU5uRGN0cFhHWXhvVjhIbno1?=
 =?utf-8?B?RUdLWWZuWk45QUZlOUtZMjNKZ1E2QTBNa2JyelVQWXFZb1RQWFo2Umtmdk1B?=
 =?utf-8?B?ZzVONENCeWtJN0ZEU0dPV2U0bWlNVTMyeVpnN3dVWS82RXRDRHA1dWFaREdm?=
 =?utf-8?B?RTVGcjBNNVFWeEhuSEJRZmxKT0lGMy9Sckp4QTZOWlIvR3dsUjNwdlZJL3Z6?=
 =?utf-8?B?Y3lORUhTbCswNlhnM2JuK2VkdVBmTmErVGFPc3UwNjBpQ2ovV3dub0o2Mk5Z?=
 =?utf-8?B?bWpVODJITUx1UWZsWnF1cmh4Rk84SStYWTVlNUlaU3BjZDRrS1YxRU1TRnZj?=
 =?utf-8?B?SWpjd2NQQlZYamhYMC85WWwxSE1TMG94ZDhWb2hGQVR5NDFjdk0zWVRkNlRY?=
 =?utf-8?B?ZDl1QkZBR0dvK3lPVGhlaXZVMVhLa2daZ29kUmJpajdNWUxTblZmZDBKMXBk?=
 =?utf-8?B?UnRLZ3FSYXpWYmM1N0NLYVYwb1JEbFpKL1pLU2FhQysvOS84RjRBQ05lRkV5?=
 =?utf-8?B?ZUQ1RXluZWhUT0FCSnk3bzlEaEJnQXRmVDVZQ3NOZWF1U0F1ZGlWV1ZFdkFT?=
 =?utf-8?B?UW54eFpvYWpVaS9uRjAxbVBoZmZIRkR6RXB4eDRwYlJ1b1ZyWXNKczQwNlpa?=
 =?utf-8?B?VmJoZTRCRmtJY3h5ZnhlSjIraHQxazAxRWlqK1NiVEJwVURRaUMwSVIzb3FJ?=
 =?utf-8?B?STdnUjBETy9DZ1kzT3J2L2tNQVkvSlk3Y0hKWjNEYjc3b1lxS0ZyOThtWmha?=
 =?utf-8?B?bFdSZTNSTGRuWmQrSlRnQjllZkdpY04vQStTVy9MeUpMekxxRU9xOU9Cekov?=
 =?utf-8?B?K3FhVXR5VElFUmxFWTltck9mTUlpQ2JMbWJjMmZMK05TRVI3R1ROL01jVlFS?=
 =?utf-8?B?T0xUVnRHMFZRL29CSXNmM2syVk81U2ltVEZLWUJFY0hFeGJsS1VQNWlkSTBW?=
 =?utf-8?B?dlhVSWF0cmJtbDdGS29LT1V0ME0vVkR6aStLQ2xFQ0pBK0dlV3VXUHlQNEZP?=
 =?utf-8?B?N2E4Q2YzRnZ0cEh6NjhZYlI0QU1EaUt2ckNRZklGQ0hLcUFablNzK0tlVExG?=
 =?utf-8?B?a3NnYUdzQk1tQmpiR1JFdmhLM0lQSmNQeXMzcXZHSFRFaDdsTmNSVytESm0y?=
 =?utf-8?B?bzVIbVZoa01UNTl0MUwrbHh2aFFuRVdRQ3pqb0FRdEwyTjJkUk15WDMza211?=
 =?utf-8?B?cHM5bUM0OUNxU0V2WkR3ak5VUElBcDN3Y1NYYTgyQmhwbVA4dmxadlJlZEdP?=
 =?utf-8?B?aTUrVG85d0txL1V1YUZFK2JtaUIrRzJoL1FGVkhNSE5LbG1YOWxJLzFncWRv?=
 =?utf-8?B?ejR4VlpMYktOVERHeGxmc1p6NmR3L2ZLbUZVRGdkOXJnSW9KcXNRMHRaenNP?=
 =?utf-8?B?K0hvOHBvUVhSbGtmRlhxMGRrcHlSNzV6MmRHM0djNVBxd00vZ1l6azBFRTdu?=
 =?utf-8?B?Nlg4NmdBdG9LQlVyc1lQa0kxS21jR3EzNkV3RlNYWXhIT0xvVU1aQXo0ZlNn?=
 =?utf-8?B?Q1FqbjBZZm41OFdFc0REZHNXUlB5am81NjVkM0o0T0k2VjJLRUpTbElnRVlh?=
 =?utf-8?B?SWxWYVhxUXptRlgxVHVLK25CMExnc3hURVhXYUFHcDUveHQvQVBkUzRJY01I?=
 =?utf-8?B?aFhwRkd3dHRRNEZMZzY3YkNjc05wSzNNTmtlT0NZOUQ2Q1h5K1NZUmhvMGJI?=
 =?utf-8?B?K2VpUnFtSEg4YWNIbGtabG13S2g5aGNjWENVcFA5cy90ZXhuaUJBMXhCMkhj?=
 =?utf-8?B?bXNCbGNMcERnOXlSY01OQ1p2RzVmOFc2MkFQc0ZYM1Y3ZnNuSE5mREMvN3Yx?=
 =?utf-8?B?Z2N5UWQxb2tFMFBFZFpXV3h2Q3VEM2RubW1uZ0trbm9aSzRmQVY0bm14aHJk?=
 =?utf-8?B?d3ZETlQ3b0tBUnBTcHhtelhrT051amtZM0p2eUhJMzFzMDNBQ2FUeDg3YVg2?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4395b650-762c-45b1-596e-08db8f7762fe
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 14:31:52.9704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mx2w0pAHosz8sj4aO1ct7d/i0ecxwrqJmEvlpdxdadJvX3IPUtt+reLW8jkBUmIkWgjoesGtqReydAaUZq1NGcJfuFv0weYq25b57udrTlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6553
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2023 12.58, Rasmus Villemoes wrote:
> The current handling of the low-battery bits in the status register is
> wrong. The first six patches fix that and implement proper support for
> RTC_VL_READ.
> 
> The last two patches allow describing the isl12022 as a clock
> provider, for now just as a fixed 32kHz clock. They are also
> tangentially related to the backup battery, in that when the isl12022
> is not used as a clock source, one can save some power consumption in
> battery mode by setting the FOx bits to 0.

Ping. Any chance these could be picked up so they make it for v6.6?

Rasmus

