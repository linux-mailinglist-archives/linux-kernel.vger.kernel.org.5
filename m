Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762A77E5F33
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 21:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjKHUbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 15:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjKHUb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 15:31:29 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2080.outbound.protection.outlook.com [40.107.15.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C591213B;
        Wed,  8 Nov 2023 12:31:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHvk+jwiwKdDRUoAl5u6sf0L+AV6hzOPLmSOv83LztwfS/yNLLPvTFsHQMxE6+fS8VURN466KwMjiQgfsAfk22WopYS8p0wHr9GD167cyvDvmrKEIgF/gpxPb54D6fw8/tSnyg8STAt+zqnypHoHgJzsAAKkPuA/6q/296+sSUIqOwQOiKZUBv4Ao80Z47wAnzBXsOuTTz63LbyRmTMUoLb6uXJBSYGzfMdAIyD2c0el8jPclwKgJxMSa5q8vAFw3stQ55rt/rT+eO31mhEabGlLIEL4cOxqJckdr3XrtGeth5KthGaQHRrs7ZAK6lIXocWy2rYzca/xmIa1i3EUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJ9d12Bx8q67/mohVsIrHsxEbwqc+/4VT3WJl+eCF5E=;
 b=FQrZnau22DCy6JBc+vIlK7m5eyIKXrNotrpMC5hLMUGQCnsVOs3GYuGdTB0lPhH9xBNyixL21762Pfr74S7gysoMduQr4LvwcTad8MB6YDV82y21dGvTkO6uxBK73r8xP8yyVFDe3dV440jUrginxXWOf6umpYknG9qaoWLlA3tDypgSLmSTRwf9jekh4fJrXgkvp+6b6DjYauBhXfG/7J+saHyxTxZlq/v7wRRWbQwPWSJgJTU+HUkzIEr43axecrCE7hkyEnL9I7XLfevKsjlSKlTiefm2Q9VKM5DujUYnnKbrozhQYh7MkJXtbIGL6dz9dBzNqU4ER9h/M0oUNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KULeuven.onmicrosoft.com; s=selector2-KULeuven-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJ9d12Bx8q67/mohVsIrHsxEbwqc+/4VT3WJl+eCF5E=;
 b=LBCCFySyPptOmCx52Xr1MqIbJr8HinI9fRQAL5W91ryT4zGtNV3GaQX8EpNlTPqYeDVhOTKQv1XRrFTDA5Vz0HHlN8o1vRoYwaSJOquzAfd/VPR5LsrTcnwIMYAlZvPKgZfC8y65P9f7B+9MEwtq/aR+wzWNd/LTbdLnWf5Hu48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from DB4PR08MB9334.eurprd08.prod.outlook.com (2603:10a6:10:3f5::20)
 by DB9PR08MB7794.eurprd08.prod.outlook.com (2603:10a6:10:399::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Wed, 8 Nov
 2023 20:31:23 +0000
Received: from DB4PR08MB9334.eurprd08.prod.outlook.com
 ([fe80::5891:9155:ec39:7e34]) by DB4PR08MB9334.eurprd08.prod.outlook.com
 ([fe80::5891:9155:ec39:7e34%6]) with mapi id 15.20.6954.029; Wed, 8 Nov 2023
 20:31:23 +0000
Message-ID: <55d6aa33-4ffd-4a0c-a449-63b136f5a1a9@kuleuven.be>
Date:   Wed, 8 Nov 2023 21:31:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/13] selftests/sgx: Fix compilation errors
Content-Language: en-US
To:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231005153854.25566-1-jo.vanbulck@cs.kuleuven.be>
 <119aaa2820be5dc58144e74574cfaa7777f79604.camel@intel.com>
 <f2726c67-87f7-409a-9ac2-e845249348cc@cs.kuleuven.be>
 <7e729488e2f841f384b719d0509a4f78f491d477.camel@kernel.org>
 <be63771f-080e-4832-955e-13f5b06b2010@kuleuven.be>
 <CWG522A78YHD.37CO0T9F3FVXB@suppilovahvero>
From:   Jo Van Bulck <jo.vanbulck@kuleuven.be>
In-Reply-To: <CWG522A78YHD.37CO0T9F3FVXB@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0009.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::16) To DB4PR08MB9334.eurprd08.prod.outlook.com
 (2603:10a6:10:3f5::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR08MB9334:EE_|DB9PR08MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a97025-499e-4bfc-3bb2-08dbe099ac74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HrIekoao29h5Nw5bzWpqezx1n5Nix4hozNON2fDv+JNwoc1p0U+H56OVbaRufG8kejwVP+ekKXtg+jxJS5UuGnsf+H93jg3uQlVLYPfDAiNAqlGdIm6+pFNNvUfUWdwaaMrZe0/xiI60No8obgDNhjmznhUqKi2l19om6qxvihVksYElXP9gLxQ/gs4OT/A5k4oV+hBXectJZvJ4LyP24J5xrvzWCNY8te4aanGYfPCc2K79Yscx0szABJPo79a9lFCD27Id6XbOHpFwdax3s1CSKdbLSsn5x03kP61aDzapFzZiubKFkq6kLWuSG24tuVlpcX0zNDi1wj1PwsII4X0BLinPiGcTJGBrmlbzMIe1kGDnb/uaR81MArPFdb+WLDBtqyNDXM1yU2FWnuwUoGV2H8VrEQlMfzxgeuQaUMzRiY+b3hGtbdBGQkdBGkAlUeoeg+2HW/MPz4Y0iiBo+heJyx2J3NDlG/+jcJ4zkiYYjm3nBxpwHwPatdT+yQy/y9ff4bVfNYub4r8X02SXvrOiECYR3En+Pgr3b0MipHbvUpkQmCE1aK95A3OHFDpU7VfaST/9aFjhk5fplGwgwT8OAQJVALlR7q+us+2X+NusRpsdULI4uV3emSIS/dGFNsX8xoIsTas9RSXChGxFrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR08MB9334.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(376002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31686004)(6512007)(6666004)(2616005)(6506007)(41300700001)(53546011)(38100700002)(6486002)(36756003)(86362001)(31696002)(66476007)(316002)(5660300002)(4744005)(8676002)(2906002)(8936002)(66556008)(66946007)(786003)(478600001)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnROcHVMVmZrNFBKbnJCcFVWQ1JEQmZ5d0NzNWJTTVVPb2lhR012NDUzM0NS?=
 =?utf-8?B?MVJPTVREOWt2YUNxMExzeVFoTkRBblArWWFkT1BXOFNOY1pDaTJLYzFJTFNt?=
 =?utf-8?B?eS9Ib2ZHeVFRd1lsTHRCMUJiSW9aTERrUncxMEY0OE9jc0MwRkNVMXBsKzQz?=
 =?utf-8?B?UzN3aWJLdmFNNWdoaFlBZ1dzVHBoL1RqaytKQjFmak9PSTRMWFIvRlhnQmY4?=
 =?utf-8?B?Q2lEU3JpWFV5Kys1TWsrcGRlMS9MK2tEM2hDNDN2ZmwwamkzNTN0RXA5RCtH?=
 =?utf-8?B?ZzhrdVM4S21YZVptR2g5dXF1dVNiVUZBd1M1T3RmbEtBd25GUm54SFpmVDFG?=
 =?utf-8?B?S05zY21JV2xyM05LZElHTjlGQ3UwQklFbVB3Y1JFQkdqanFHYmp6MkxyNklz?=
 =?utf-8?B?bXh2MXc0TVNPdDR6amtKcUdTMVJ3WUxLSkYwa0w0Ty9kbUpiUFY2QjdlOVBl?=
 =?utf-8?B?ZzZVL0xKNnpCRWtqU3AyK1gzenp3eWpHMGMvUlRsYmxlUTZiT1VZUkd2TXh2?=
 =?utf-8?B?Q3hZODVpdGVTamE1T3BJWG5yVXh3WWV4eHMrT08zaVNJYU1hejFLMjVJbzg0?=
 =?utf-8?B?dXBCWWVrMEYzejM3SFhEMWdBa0c3VjBIelVKOWRrTFJwV2NYU1RJQVBqZWdE?=
 =?utf-8?B?Zk5yVm1pb3d5UGQxMjBnWEtJS0VRZlRNckQrdDhVM2RjTXUvR3dIazd2SUN5?=
 =?utf-8?B?dUFqWUsrRlZobGRjTzFHTTZ2MTJ1ZGZ3L0lTWnNQbDc3T2Q1SDNGQk5EcUc0?=
 =?utf-8?B?eG10ZmNtVE1MbzFBY3ZCQ2RINUJaSU53TmVncHdjd2prRGVIa0JrcFZuSndh?=
 =?utf-8?B?Mm1XRXlCV0YreVVMZ0tsbFZobE1sVVZGbGN6dWNOV296YU9YSUErSjZBUDBp?=
 =?utf-8?B?eEFBUHBXczlOUk9UU2J2bGlMb2RiNmNjeG40WU5sS1pwZ2M5RUliemFNb3BD?=
 =?utf-8?B?OVRFNlB5VFlOemVRV1dYMTBXa2RGZ1VNN0ZWT3VSYVlpR0ZRT1lpa0dJV1U0?=
 =?utf-8?B?WGY3cGU4ZTZjQytrS3d1Q20ybEY4TmhJN1phUzRKMmtqZkVyUVFFQUZGM1lC?=
 =?utf-8?B?bVNYOFN4RFVERmxlOTl2V2E0UzlWK2tFU1kwMUtML0F5NkN1V2tCRVJPSGpQ?=
 =?utf-8?B?M3VpWGp3TWVQeFovZEFnS3ZjMzRETFFrcTBCTnVhakg0cXRYSDJMNXpYMGlh?=
 =?utf-8?B?MG1icFhtcTJyUzhBcElyNlVHaVg4RVdpeDFPejBnWmpXaGRDbmVzbmF1ZklT?=
 =?utf-8?B?ZTQydEhRZXBzY3RkUzE5RVhLazVoRUFLc2N1WnhCb09Dd044RzlZd082bVRw?=
 =?utf-8?B?ZW1MQk1qWW1xYUR2cDFMZlhYUkVBZU9wQzNhSGtncFg2djRpVjJPdUt1RUVk?=
 =?utf-8?B?RDVURjdULzNXN0w5Yko1cXdDbDdjRkZ0QmozZWlQMEh2MVExUTJXWjdIOGQz?=
 =?utf-8?B?eUJOR2tuNzYwejJobkdyRUdFakU3Y1hSRCtGMEhTMnY2d2twR3ZzWlhzTm1F?=
 =?utf-8?B?ZFY2UlFqV0RycEplOFNaejFTaVl6TENQTEhZMmZPem11bG5LTmVhQ2F5RG9D?=
 =?utf-8?B?cVluekF0cnF0R3dLRG5IaHdhUW1TWGhlRTVNcEhxaGVGMTdPRDZtTkFSNGZJ?=
 =?utf-8?B?UExqZkwzc2R2R1p1c282c1NZdElyY1EwRGlDeld4M1JwQ2J0anR4S2N0VWJa?=
 =?utf-8?B?OXYzV0RmUW5XN1ZwSno1dFJxK04zV1lPZExKb1BQL25sUFpWMk9JOGJJRlNC?=
 =?utf-8?B?US9QVEYrY054RVNDN0lhbWdjRC9jSUk2THBXY29kVi82aWJTMkw0YnFxbm1k?=
 =?utf-8?B?Vm5sVThrV0E3U3FEdUpPV05mK005VSsvbWtDcisvZHlvQkt6ZTI2M0s1M0Y5?=
 =?utf-8?B?MUtRV2RqeXRYOEVIU3kvektqMWFMU3g3bWxyMWMvT2F3U2M1Qm5KcWNOcWc2?=
 =?utf-8?B?N3Rlb2h0TFd6WmlIUnY0ZURpbEQwNHBWWWtaOU1HN0Q4UER6eE40c1lDQkVu?=
 =?utf-8?B?a1p6a0VzZ2YyWnlDNnZtMTZjRWlPSjF3ZU5vY1pCNkd6NWtzaHdNNmhhUXlh?=
 =?utf-8?B?NTdDNnNKaXpIODBKVERLcUtGNHdISEtNdkVEbUNWSG9QaTk0c2QzOEx3WXp2?=
 =?utf-8?B?YXA5SXZhTm80bk1WdmpucnB5Y1pReFlYK3NldHdUUHJ6WUtjSnNUWDdFNWtU?=
 =?utf-8?B?T2IzK1FtcUNDeG51YkFUTHJkL0ZwT0tMSlZZem1jRjhZMDhnZjdLeHBVNE0z?=
 =?utf-8?B?aTliNnk3SGZTenpTRllYOTNRR21nPT0=?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a97025-499e-4bfc-3bb2-08dbe099ac74
X-MS-Exchange-CrossTenant-AuthSource: DB4PR08MB9334.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 20:31:23.2430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWHkb3nIflVVWDTNmRql9mfrBm57mmMQT6Jbk9rRT5VhteCoFhkUTXsIjbcbxHPWOt+zWLfQJ2eF359NqxWOXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7794
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.10.23 23:32, Jarkko Sakkinen wrote:
> On Fri Oct 13, 2023 at 2:45 PM EEST, Jo Van Bulck wrote:
>> On 10.10.23 11:44, Jarkko Sakkinen wrote:
>>> Folks (sorry for top posting): I've now taken my old NUC7 out of the
>>> dust and tested the series :-)
>>>
>>> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
>>
>> Thanks for testing this Jarkko! Not sure on next steps, do you want me
>> to re-post the series with the Tested-by tag for all commits or will you
>> add that? Let me know if something from my side is needed.
> 
> Dave, can you pick these patches to the x86 tree with my tested-by
> added? Sorry for latency. It is flu season in Finland and I've been
> functional varying last week because of that.

Just a kind follow-up: from what I can see, this series has not been 
merged into the x86/sgx branch of tip yet (assuming that's where it 
should go next)?

Apologies if I've overlooked anything, and please let me know if there's 
something on my end that can help!

Best,
Jo
