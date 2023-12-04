Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521E080346C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344202AbjLDNXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLDNW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:22:58 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2085.outbound.protection.outlook.com [40.107.247.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEA5C4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:23:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIPoWU5V0wc17hlaanLNmVBKhMIVe5D/h6MReH4X1mTFerp7SDxQxkCWJ+DomFCg9xA6YUcRhsSAgDMVgDIQHFt8aQeYsGhKg5aAphT0K4WexR9VfsMnA3ElSThYiC91uWmDJPFw5gKuTm7RFdhzMLuZW1aIyv17HsM/Vc+EUsDoRzZPhxE8hOAw5Vgkz6SKgQuaXfrZFHOxOJRvLlXqxqNXjl0vpjInXQR3erJJ7dODyha5lZNBEPt1+mpVxpOdcwnVks314MxRbesfdaCW5CAOatemKjgsfJRU73eJWJA5iJtjD2qoDPZ35JovjdJf5LuL3qHwzjOhkFUfukCFzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XEOfVzTuqeXLiZxQhpiK868SlwmtXKguqmiNWpwPMQ=;
 b=Lt9QXX2JDH3NNkl36FrkI4Cl+thSUtEYB7Q1TJMINQ05vl29K241YBCjeipV/2jLguBZJpnW8yqqBr7AHdQmj4U0fvUDtlenssFRapMsi3lPwD7RTc0KGjB28Cf/X7+nx5JTqR//YNXQvtfwPFsT89/zMIfcTrIcUyN2QbjfRqOnK/0lbZHQuR8sr6EMr72nRSsEx1omiFq/3wx3zQXbpSo9EuRYSWdZxyEAwwnyH/AuRSdcpjvb1YnjyDdFT141KPQelqTNCl4VTIurCSrmd10GAsqHKNFVNSqSA1rxrC9WO2tyZfCdd0RTzHh4mgSTlVr30IqBkZ0oqzvtVKqj9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XEOfVzTuqeXLiZxQhpiK868SlwmtXKguqmiNWpwPMQ=;
 b=s+KU69i9fkFha91CP9Iiw2PbMkdA5Fqtu6MfG67ot+h9NxRXk36SHgTcHi97UmwxUcqFYNTll5nEvbGcgxwxoYGHDVqu4aH63yAb8WGt8hkRLC3j6rrZ9KFhIG/+rN8ZLpfyAOhKg8bvoeuiCwB5z0GypHhAij7UXPnSRNqKT1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by DU0PR08MB8205.eurprd08.prod.outlook.com (2603:10a6:10:3b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 13:22:58 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6%5]) with mapi id 15.20.7025.022; Mon, 4 Dec 2023
 13:22:58 +0000
Message-ID: <750c2c64-4fd6-437b-bb14-100f6941d2c4@weidmueller.com>
Date:   Mon, 4 Dec 2023 14:22:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] extcon: usbc-tusb320: Set interrupt polarity based on
 device-tree
To:     Chanwoo Choi <cw00.choi@samsung.com>, lkp@intel.com,
        'MyungJoo Ham' <myungjoo.ham@samsung.com>
Cc:     Lukas.Funke@weidmueller.com, linux-kernel@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev
References: <202311221355.yxYpTIw3-lkp@intel.com>
 <CGME20231122080822epcas1p23e2e80d3db305229f9d611d79b667a2f@epcas1p2.samsung.com>
 <20231122080749.947682-1-lukas.funke-oss@weidmueller.com>
 <002e01da26b0$52582960$f7087c20$@samsung.com>
From:   Lukas Funke <lukas.funke-oss@weidmueller.com>
In-Reply-To: <002e01da26b0$52582960$f7087c20$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0442.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::14) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|DU0PR08MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: c92ce9dd-bfe4-4cb2-3138-08dbf4cc21cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GiJABFleejVgTUOWW2bWk5BKSPLYGsAJEW42vLEf0Uphahxc/Bm3L8Ht4vgY5C2OlryRbZq+6jofmpkmB1fQxRdZ+zsYEtBV9ObV9twdPsV8xj5Dcf3miEDnkdgsHzcFMbYv2k8PKIYhU6r+MdC2l6JrH1+ZzPqEVDAcBN1kAXM0OScENZTHCTeAY6VqbK8ao5kgleNgueVOooYb65pGugKu/pDd1ktA748qzSAkOwtm2jD7mbkh3BCO47ll7M0YnI7f2+5Bh2FLbZmIBe4sSC/UHSPKOTF+pYrS2FISCLcSKHhJQyIihZZsgWdT7ARtTHwgd6PiOotK+19cBfEQBio9qwJxYOXgAcZVKQ+3ZGHsLlfkD22/GhZjL6zgLdWSUhOZiFQDHtUf9Qm5gbyNeTdKCYTpdE+/IfPb/5K/NNyBrbY6//TDJ2JNrt7Ld+JUfMTE4U7RyybpR1TnMW4/YZujO/mXtRgYzCtcaraHShsSAsu2ASqiHj9rIxBfi26UsRq8ovRljg0PrxAmFZnLKmQTC/gFvnliHGYmTb+o+WybuYYMsOVXCm93VQ7u9ez/HWjBYcJ4AWa+rVacFkqCoGqQrIskXlKzk8TwWqOQFauVQ29e4zPhwN+W9wAyu0NRUHfrNtSmA2/ZUEcY+uTbdrSOKeK9oTlYqnOypRFOCDP2oLQpiCBhwAbznoajrr/+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB8431.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(230273577357003)(230173577357003)(1800799012)(186009)(451199024)(64100799003)(31686004)(2616005)(8676002)(4326008)(8936002)(6512007)(6506007)(53546011)(83380400001)(26005)(6486002)(966005)(478600001)(66476007)(66946007)(66556008)(110136005)(316002)(2906002)(36756003)(41300700001)(38100700002)(86362001)(31696002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1d4bm1CcWp6THNFVUZnam5qa2V4elJDenZHU09aeFRHVlV1RXZYNTZOVFpU?=
 =?utf-8?B?QWVKdS95S2dvam00OGxZTUNKTVAySUlHZ2tHRkJWWExyeVQzYUdqZVozV2ND?=
 =?utf-8?B?MW5qWHdZaVRscVc0b25mZzc0eUtXejFUYlJudHpDZW54YzJPOWhJRnl2Zjdn?=
 =?utf-8?B?MEhLdWEzUXVlNGYwMVR0NUFlR25YQThNZjNENlM4VjRRL0ZpYnNPWE1IcVpv?=
 =?utf-8?B?R3VBdXB3by9aZGRjUVZNQXlxMFk1eHRBNlA4Y1l2b0ZMaUVROE5iWUtMMFM5?=
 =?utf-8?B?dnhyV0FnMVlsbS9Ibmdpb05rcGlMQS9qT2JpMXNtWXRvbTZtSTlMSHdIaXlz?=
 =?utf-8?B?bnFLamtoOEhtYlEvQ1YvTW56RFl6cDV2NWQvcG8zc010aTEyS00relFYTUw2?=
 =?utf-8?B?b1BVRXRXSStmbWhCTXBZUm0vZmNabi9MT3JZSmw4aUlTaEpuYlJ3Q0JXZmIx?=
 =?utf-8?B?bVcwU2xrbTRrVzJXa2FzdEFhZUZnT0lxb1FUMS9uclJ3NFhoMGFrNTZGaHBH?=
 =?utf-8?B?eFRTSVlFN0pWdmM2N1NXVk9CbHpvYkdPaFpUbGN4emhwd3gzYmhBMDZaeWUr?=
 =?utf-8?B?cWQ5UXdFL3FLSWZIcTdvcngvN29DYjNETUJTRlI3Vnk0L1liQ2l6VnFBQVRl?=
 =?utf-8?B?c0RwRGYyMnZpdCtyaUJwUUdqRlNaaXR2bFhDbzB1TzZXT21XbFFCUUNra2dL?=
 =?utf-8?B?UG1VU05XNUQ5VkRld2ljNVVBcU5zei8xTEkxN0tveHBDcXppUnVHMFRpVmlP?=
 =?utf-8?B?RzJZaExEcThKV1hQVXRqeVRlMjAvMERqZnNTM0VPRkRyWGRRSjhyck1TQUox?=
 =?utf-8?B?VzVCYmFheDdpWkp5QWFtclhSQTlFaW15ZGtsSURNWVRHclF5KzBINnlUUzhX?=
 =?utf-8?B?b3JreXNYb2l4UFJ2Q3prbFl6bDhDWFlCZW9Hd2RkTzBQZkZOV1R6L1JhSGRR?=
 =?utf-8?B?UW1oWDlGZk16SGVOWjVONXo1UjFZZDM4S2txUk8zd1o5NDJqVFMzdy8rS3Er?=
 =?utf-8?B?d0NiMy84NldFLzVCODIyZlhiL2YwZUR4M0pUVDhvOUhRUktkM2c2TzFiMW1I?=
 =?utf-8?B?QmhHWmxWbEdNTXorU09ZUElvenF5SHZLN0hpT0xvQmh4UDhwYTQ5RS9qKy91?=
 =?utf-8?B?TVZ3ZDdXa0NBeEd2dFcwRHJnOFJFSnBtdDBaUU9sM0ZFbDhKb05uazlTQU1s?=
 =?utf-8?B?Zm1wMmtWdVlIcEZIZHZPV1hIazlod2lRamdqM21jaFg5eElYdlptUlgzV1dJ?=
 =?utf-8?B?VHdza2FDdnAzbzZ0VFZ5c2xHRDZrcTNZaW5YaVpkRTgvakNib0VuQzNDdTJQ?=
 =?utf-8?B?OE8wVTlZM1RUSFNwMHNJZEZCUW5qTGlIMHhjRlpWZmx5NzBuSlMzQUYvVlpp?=
 =?utf-8?B?K0JJMHhmV25VZlUwalZ4T081UWIzUnJWMVRvR01mN092RXlEM1d3Vzk2VUdD?=
 =?utf-8?B?ZGdUV0FteE1sYmRPdklsRWRac2ZyTUFiRVZaK0FWMzdIaGJYd3BIb3dWa2R4?=
 =?utf-8?B?cXI2TEhSNnNoL29sQ3dyOFBKTHg0YTZmb0hsWlVBZjJIZzVuNk5aT0Z2SkxR?=
 =?utf-8?B?UTV4L0JEczlOMXZjeWpaMXBZNTNiU056TDUxYkU1TXVtM2t1L1dlTlQ2SStx?=
 =?utf-8?B?YXRQZ2pRTWRKTmF5R1hqZmcyL1BjaDdCUHlVT0VTNEwrS0VHK0VFNTAvQWo2?=
 =?utf-8?B?VDJJWDNIVm04ZCt5REY5WXN5NTdMaWZ6TmlRQmViV3R6UjZma0ZmZGhUbDNw?=
 =?utf-8?B?NXpuN3N1ekZXVmRpeVh4dE9HQWlWUitFYXZaSm5xeVRnMUQ5T1Z1US84TTRJ?=
 =?utf-8?B?Y3BZYmg2UXRVMUtxY21ReTFFM2xhL1lNNWRhaUpDcEJKR1RkSHNTM2RsUFFi?=
 =?utf-8?B?MmRFKzQ5dDBIbE9PeEs5bC82bW5Ya3JWYXVERENJRitTN2pmSDdLaElERjZ6?=
 =?utf-8?B?TkQ4OE1LYTFaK1VVU1lPaUwwYjdlb3E2Qi9VU0drTW01ajNBT3lrWnJRK3Rr?=
 =?utf-8?B?d21iblJOWFNtZXFDcEwrZUttaElGbldXYnorNmk2OTZnOTgzczFZQ0szWUUv?=
 =?utf-8?B?bWQyL1RoTUpqYk0wZEprVVNuUnJ5V1g4NUM3Y2VUUk5ic2FheFB1S2MzbG1a?=
 =?utf-8?B?dEhKNTFTWlp5SlNpU2VOVG9hTm1nbkhQcURsR0t0Z3NZY2h5QVRVaDJjNldQ?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c92ce9dd-bfe4-4cb2-3138-08dbf4cc21cf
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 13:22:58.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYaLFASqHUQG1bA1oCbPlnGtamRCO5cETNj/6LXSmQmjdR6snzMAfsBa37qTC7vl4krlqW9s9Xfzwq4kVVbT/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8205
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 04.12.2023 13:49, Chanwoo Choi wrote:
> 
> 
>> -----Original Message-----
>> From: Chanwoo Choi <cw00.choi@samsung.com>
>> Sent: Monday, December 4, 2023 9:33 PM
>> To: 'Lukas Funke' <lukas.funke-oss@weidmueller.com>; 'lkp@intel.com'
>> <lkp@intel.com>; 'MyungJoo Ham' <myungjoo.ham@samsung.com>
>> Cc: 'Lukas.Funke@weidmueller.com' <Lukas.Funke@weidmueller.com>; 'linux-
>> kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>; 'oe-kbuild-
>> all@lists.linux.dev' <oe-kbuild-all@lists.linux.dev>; 'Lukas Funke'
>> <lukas.funke@weidmueller.com>
>> Subject: RE: [PATCH v2] extcon: usbc-tusb320: Set interrupt polarity based
>> on device-tree
>>
>>
>>
>>> -----Original Message-----
>>> From: Chanwoo Choi <cw00.choi@samsung.com>
>>> Sent: Monday, December 4, 2023 9:09 PM
>>> To: 'Lukas Funke' <lukas.funke-oss@weidmueller.com>; 'lkp@intel.com'
>>> <lkp@intel.com>; 'MyungJoo Ham' <myungjoo.ham@samsung.com>
>>> Cc: 'Lukas.Funke@weidmueller.com' <Lukas.Funke@weidmueller.com>;
>>> 'linux- kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>;
>>> 'oe-kbuild- all@lists.linux.dev' <oe-kbuild-all@lists.linux.dev>; 'Lukas
>> Funke'
>>> <lukas.funke@weidmueller.com>
>>> Subject: RE: [PATCH v2] extcon: usbc-tusb320: Set interrupt polarity
>>> based on device-tree
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lukas Funke <lukas.funke-oss@weidmueller.com>
>>>> Sent: Wednesday, November 22, 2023 5:08 PM
>>>> To: lkp@intel.com; MyungJoo Ham <myungjoo.ham@samsung.com>; Chanwoo
>>>> Choi <cw00.choi@samsung.com>
>>>> Cc: Lukas.Funke@weidmueller.com; linux-kernel@vger.kernel.org;
>>>> lukas.funke- oss@weidmueller.com; oe-kbuild-all@lists.linux.dev;
>>>> Lukas Funke <lukas.funke@weidmueller.com>
>>>> Subject: [PATCH v2] extcon: usbc-tusb320: Set interrupt polarity
>>>> based on device-tree
>>>>
>>>> From: Lukas Funke <Lukas.Funke@weidmueller.com>
>>>>
>>>> Remove 'IRQF_TRIGGER_FALLING' request which is not allowed on every
>>>> interrupt controller (i.e. arm64 GIC). Replace flag by a request
>>>> that depends on the actual device-tree setting.
>>>>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202311221355.yxYpTIw3-
>>>> lkp@intel.com/
>>>> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
>>>> ---
>>>>   drivers/extcon/extcon-usbc-tusb320.c | 13 ++++++++++++-
>>>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/extcon/extcon-usbc-tusb320.c
>>>> b/drivers/extcon/extcon- usbc-tusb320.c index
>>>> 4d08c2123e59..140ab28dbd36 100644
>>>> --- a/drivers/extcon/extcon-usbc-tusb320.c
>>>> +++ b/drivers/extcon/extcon-usbc-tusb320.c
>>>> @@ -17,6 +17,7 @@
>>>>   #include <linux/usb/typec.h>
>>>>   #include <linux/usb/typec_altmode.h>  #include <linux/usb/role.h>
>>>> +#include <linux/irq.h>
>>>>
>>>>   #define TUSB320_REG8				0x8
>>>>   #define TUSB320_REG8_CURRENT_MODE_ADVERTISE	GENMASK(7, 6)
>>>> @@ -515,6 +516,8 @@ static int tusb320_probe(struct i2c_client
> *client)
>>>>   	const void *match_data;
>>>>   	unsigned int revision;
>>>>   	int ret;
>>>> +	int irq_pol;
>>>> +	struct irq_data *irq_d;
>>>>
>>>>   	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
>>>>   	if (!priv)
>>>> @@ -568,9 +571,17 @@ static int tusb320_probe(struct i2c_client
> *client)
>>>>   		 */
>>>>   		tusb320_state_update_handler(priv, true);
>>>>
>>>> +	irq_d = irq_get_irq_data(client->irq);
>>>> +	if (!irq_d) {
>>>> +		dev_err(&client->dev, "Invalid IRQ: %d\n", client->irq);
>>>> +		return -ENODEV;
>>>> +	}
>>>> +
>>>> +	irq_pol = irqd_get_trigger_type(irq_d);
>>>> +
>>>>   	ret = devm_request_threaded_irq(priv->dev, client->irq, NULL,
>>>>   					tusb320_irq_handler,
>>>> -					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>>>> +					IRQF_ONESHOT | irq_pol,
>>>>   					client->name, priv);
>>>>   	if (ret)
>>>>   		tusb320_typec_remove(priv);
>>>> --
>>>> 2.30.2
>>>
>>>
>>> Applied it. Thanks.
>>>
>>>
>>> Best Regards,
>>> Chanwoo Choi
>>
>>
>> In order to remove the build warning, I changed the variable type
>> of 'irq_pol' as following:
>>
>>
>> index 140ab28dbd36..cec1889549a6 100644
>> --- a/drivers/extcon/extcon-usbc-tusb320.c
>> +++ b/drivers/extcon/extcon-usbc-tusb320.c
>> @@ -516,7 +516,7 @@ static int tusb320_probe(struct i2c_client *client)
>>          const void *match_data;
>>          unsigned int revision;
>>          int ret;
>> -       int irq_pol;
>> +       u32 irq_pol;
>>          struct irq_data *irq_d;
>>
>>          priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
>>
>> Best Regards,
>> Chanwoo Choi
> 
> 
> How about changing this patch as following?
> When irq_getg_irq_data returns NULL, just use the IRQF_TRIGGER_FALLING flag
> to support previous version. Because I didn't' check the all use-case
> of this driver on DT. I think that better to keep the IRQF_TRIGGER_FALLING
> flag
> when irq_d is NULL.

Good call. Just one minor change to make the 'else' obsolete (see below).

Best regards
Lukas Funke

> 
> 
> diff --git a/drivers/extcon/extcon-usbc-tusb320.c
> b/drivers/extcon/extcon-usbc-tusb320.c
> index 4d08c2123e59..bd5ed8dd8fdd 100644
> --- a/drivers/extcon/extcon-usbc-tusb320.c
> +++ b/drivers/extcon/extcon-usbc-tusb320.c
> @@ -17,6 +17,7 @@
>   #include <linux/usb/typec.h>
>   #include <linux/usb/typec_altmode.h>
>   #include <linux/usb/role.h>
> +#include <linux/irq.h>
>   
>   #define TUSB320_REG8				0x8
>   #define TUSB320_REG8_CURRENT_MODE_ADVERTISE	GENMASK(7, 6)
> @@ -515,6 +516,8 @@ static int tusb320_probe(struct i2c_client *client)
>   	const void *match_data;
>   	unsigned int revision;
>   	int ret;
+	u32 irq_trigger_type = IRQF_TRIGGER_FALLING;
> +	struct irq_data *irq_d;
>   
>   	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
>   	if (!priv)
> @@ -568,9 +571,15 @@ static int tusb320_probe(struct i2c_client *client)
>   		 */
>   		tusb320_state_update_handler(priv, true);
>   
> +	irq_d = irq_get_irq_data(client->irq);
> +	if (irq_d)
> +		irq_trigger_type = irqd_get_trigger_type(irq_d);
> +
>   	ret = devm_request_threaded_irq(priv->dev, client->irq, NULL,
>   					tusb320_irq_handler,
> -					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					IRQF_ONESHOT | irq_trigger_type,
>   					client->name, priv);
>   	if (ret)
>   		tusb320_typec_remove(priv);

