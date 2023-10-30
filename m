Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE497DBF10
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbjJ3Rfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbjJ3Rfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:35:32 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2060.outbound.protection.outlook.com [40.107.247.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FA59C;
        Mon, 30 Oct 2023 10:35:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKz33+m1lFBK+xpl+I/lAhs5O6MI7lPRMA8pS/BCdkCHmUQoXCbI9Z6csNtu1HIHDd2SCdvLwowgBbiBvVFz4NIrwa6g7Oe+KDvLrcqpyYcNwwkUHD9Y6hxXMDJcnLLdZFhcWGOaUZ4rK4QYKp/GeXcwUr3BU74dyTIk3RMpBeOH5AD89OxrXnCO/B4xK76ccE7RuOw4xadtRdQbITKYwcvJJe9mw5sFW86nre2aitgV0Avm31Zq5YhALGmsjtO9rf519JUecGUhu1c0An+iRMQdSDD1dNfepS3zqnxUYctRMAFNSxYYKoJNOSZi74yDD9R6m3SxWambwsrPpot1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvH0nYycAO6sAl/F2vJcb18b2LcPDZnTf02Zg6sDcFE=;
 b=AbJKdJTiAfegkefAqXUeO3sl7LtyiNSYTPQd+3+3tuXPPJOd8Z+uiXMqURibOk5Cat7M8tdYX+49zEQQKz3iY7diJkCzhwQZ6m4gr2xRAVCQQ+FK2xo6ZbisdMHD3fZeehANWRSWZHSw44Mca4VDoYA5tP+qTw1UKGyz+VGtJtceS4ngUEYj+VGLw+OKhX9TRN+yBXeWqCwLOPM1tPEy9FiN5haSi7vuY3bySdkzNL63KjGGVVYu8u9mjJ+VXHyUzxjsendLNjkFOIrYRD6iHN/mdeFDZ4Yf/EElodDSuv2B1rUtFFmXw0jwwwTHnAxUKp6m7vvkOwqc6N9ouY5nhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvH0nYycAO6sAl/F2vJcb18b2LcPDZnTf02Zg6sDcFE=;
 b=ILGoz6BBJ09Fhf7CI7CHQkgwPcGUN658s5isfC0d7pfod0z97EkmRNQI7AF1tyH+ZTHHpobxqgRtdbAtqat1PvqHvUrTntxT9RODTDHCOX1ReySm+UfGZqdG8Qbw0F7kAWceVa6CUPv+Rnkay3jCY/lWUIWmUDnQDVEOlb/gBtjsL34RL9k6OoNA3lERC2x1vUL372AzAM07wBSDyrTrxSnRbz8yx4qJWnQJBaV5Xayz8oJSPS+P3qfjw8/uVvIqnVMdDNQY4rQhS1k75R9BhFGc7ZW61DYC5BxVuiSKK4u9+89QfS8QTUHk3PlzYEBA7lHhjPhGvJ8eO00RJQJdEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8083.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:115::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Mon, 30 Oct
 2023 17:35:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d%4]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 17:35:26 +0000
Message-ID: <90334e24-6bcc-4676-8ddf-8c8f8191038d@siemens.com>
Date:   Mon, 30 Oct 2023 18:35:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] dt-bindings: trivial-devices: Add IOT2050 Arduino SPI
 connector
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
References: <cover.1698413678.git.jan.kiszka@siemens.com>
 <7838d99a1795337c73f480fafcbf698fc17d16dd.1698413678.git.jan.kiszka@siemens.com>
 <20231030164327.GA1242659-robh@kernel.org>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231030164327.GA1242659-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:610:cc::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8c3bea-30b3-4a40-7ecd-08dbd96e9a57
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T4c5mPGvBXq001i92aAvLWb1krtG1ER686EXrHnND96IasMvOHTV5dvRIRkgLSadeg4wZcLUXcrV+GwtN3FYtOHcU3Ep152tKu748DNI/Rx93PyFe/C3MBCONSYVMlYr8bebdHHvM7TY8DrbLjNV9CeJ0fsyVMd/iniLuEt8YxUcfyeO4Mfvy9aJE+oZraDolLThSH6Q4YoaI04tok03i3ilcSFLoaWCaDiJAHVG72lizdldNAw3OLo+iapdouJNnCSNyhAjhdiuypcFDGfDREK5svYYHKDiThrWyB3ofLIrxNPv3EW9ysBzOaf0/4t9hBtKKHw3Z+JK7z1cMHUyEUphP2R5iJK2s4SlKJeJjhKocbCYbFtnTG/sXckCxNmTo8qGBs02ESneY0sjoMvPAloWUixYcBdWxIwEk00Jac5dLxM+3We7qHrxJiAXw3usJqKC8yihB1OWJmiGAfnL8WUhmStekcY/hYG04ud/GXJDnpCmgdwb7heyianXSfKBhhoL5sRFlu65vv2I47pqxLPbfom1zqimxjJMcTXOhBXYx4UlYQtwUxiE29NathhfK3IWYpRyoyjzl3UZkRQZfWbMoNsV15qgNvv2dypa8ZzsSc09xeOvd+ZnJKo+41tEUnoaU6Wj7St1f3WrxRIIJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(26005)(2616005)(107886003)(38100700002)(316002)(54906003)(66556008)(66946007)(66476007)(6916009)(5660300002)(44832011)(8676002)(8936002)(4326008)(53546011)(6666004)(6506007)(6512007)(6486002)(2906002)(41300700001)(478600001)(82960400001)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2ZpNExJdFU4WWFCZ29WVE03ekdCeEdJR05RbkdYZE50NHM4Q2Voa29GQWtQ?=
 =?utf-8?B?ckxSdFVORXJMTDlqQUJvNDZDTUFtbVVFQkFlS1NDazlqOTV5b1FFdG1uc3gr?=
 =?utf-8?B?eGU4dEtMeFJsOEk0TkorYTFIeXNQRVZ0Kyt3VXlsSWtKL0RYa1UwVzVNMjYy?=
 =?utf-8?B?WWhPaTJ3bzZNdHlPZkJGeVdFaDNMQlBXZWQ5eHh0TXpwWlNXMFk2MHBmUWFm?=
 =?utf-8?B?RU9TWlpmdnAwY0xMeXFUWHY1MU5hSWZyMDNTdDFiS3VjZGdURzhFUy9kOG52?=
 =?utf-8?B?TTB1MGFkZzRIRm4za2lyRWhSSTJWRGNCQ3N6OTBud3YvKzJ3K1o3TzVnS1ZV?=
 =?utf-8?B?bmRBOXlFaHQyZFNQcVR6Qlh0S2grdXVIK1BuYjhkN08xQTBLUVRYeFkvK3JY?=
 =?utf-8?B?UEZhNE51Mk1BTUljREJNZ0E4bVNKcGRYWXBpUjN2WVA0WWgwQUgrRGRrem94?=
 =?utf-8?B?MEhHaFN4a1k2UndVR255aDBWOTVLYzdLRnJtb2I5dFpLbFM2NmhNZ1pER1da?=
 =?utf-8?B?dFhSbXFrU3pQaE1CL3FkYXYzYUZhb0c1eHlVL1dhRVg1ZmxYZ3Z5anpyTUJB?=
 =?utf-8?B?S3UyT0RYTzBZYWpXTXZUTG8wcHU0YVpKK1d1dm9WZDl6UmpsK3JFKzkrK0lJ?=
 =?utf-8?B?S1BQcHhwUUQxc0dlY2g1bWdXZ0pyT0Y5QmMvS1JoT1ZiT0ROQWgwMDlDUDR3?=
 =?utf-8?B?a0FDanVIVUZ1R3FDRzJmWStpT0U5S1RQNXZ2endiR3plTFJIQXdVZUZNV0Z0?=
 =?utf-8?B?MXhydFRZWWxHVE9GbWRVdGg2WGtuMzh6SzRPdG5Va1lmTzQzem5hMU1KTnJB?=
 =?utf-8?B?QjJOTFJNMXNGOGFoWU9wU3ZlZjkyNnY4Y1ltYjh1Y0wrYi9ZMjg2NDBjeE1I?=
 =?utf-8?B?NFhKNjI0QjU0UkRnSC9JSHd1ZVA0N25FbDhZNGFBSU1VaXVFdXpndmJwQ2Rm?=
 =?utf-8?B?Um1vVmNETkVuVHllaVljZWxkYnRjK2RmUFlCOW5rMVdyZFk1d3lHT1FvWlIw?=
 =?utf-8?B?QzdzVC9veUpPeEtNNkJSS2ttZzVQRlBmdU1WVDlnWWtNbkowaHdEcFFoWnp5?=
 =?utf-8?B?WElVVU5wUEZDUzB0dlUvaHJ0NENDRFBHQnJkdGY5ckZrcTVvZHFpMy9kWXA0?=
 =?utf-8?B?RXo4eVFMTURGcmVKYVc5d2oweTg0TEZ4NWkzZlMrQThqSkhldCswMitkNkF5?=
 =?utf-8?B?OEdTbHNDMWlMWXhEaEVaVHREUitIV3R3UGxVSVBtcXA0ZGZ5SjZsODYyY0dS?=
 =?utf-8?B?bkZOcHhGOWIyL2RITlNza1ZZK0MyUXJUS0hPOURreTcvSUkvakNEdzFGd0lH?=
 =?utf-8?B?dmVZRitEL1orVm5IZ3M3UUJDdkpTSjVsSjJVSC9VRlRDLzZrMTVVRXpldlVM?=
 =?utf-8?B?L2Rvdk5wQXVsSjdQZTd4OGlRSlVNdTZSVkwvd1VPdXRtdDRDU1dFK3lFM1RK?=
 =?utf-8?B?ZmZnMWFVT1lrUTU5ZmxZVWRKMVFlUzFyQTlmcTlLdnVBOEtNb0JhV2l5Uld1?=
 =?utf-8?B?WGlYWk83ZEVjVS8xL3ZKOUhwSzg3eXVBNFRDaG55Um1sbGVjWXBKQ0lpUFJE?=
 =?utf-8?B?Z2l4aDZRRnBlUTV5WUNkaFRsakpKdzZiZ3ZDZmQyOVFvRE80aXp4SVI1QUcx?=
 =?utf-8?B?RzhLRmhhUk51cEl3b0ZHYU1rVThXL1NQUXoxT0NLUnllaFh1cWxXTUlxYS9J?=
 =?utf-8?B?N0xBS0VVWHRMcTNSemhMM05nL1VqMThydG41K080WmtUb280QTNtazhPaEtK?=
 =?utf-8?B?bUFNMEQ4bElKSDQ1U1VITFRBWGRYa3FtQ0U2OVQwSkN2OTBjQTFkM3hCWTB1?=
 =?utf-8?B?RTIyRFVjMTZsMFZUZ2N2dmZQZGtqdmNMVVBCM2hMUkU3M1Y4MFhYQjI0dDgw?=
 =?utf-8?B?VDVjUVpCQmpZUnU5M0cweExiZHJKdncyU1VzOGNhOEQ4aVdMOWN0RmJMS1dr?=
 =?utf-8?B?M1prMnZ2Wlg5V3ByZ3BJNCt3VHZUbTZqMG5TN05iTm9yRlVIeG5ZYXRKbHly?=
 =?utf-8?B?NWd4SnEyWmM1QUE5Zkl1dis5K2N6K2YvY3dzcW1qcDhGdXVPQm5UMGJtOFV6?=
 =?utf-8?B?NExKUmFuNDlLcGh6d1RlREpLZnlkK2FRUEVORFRsYm5YOVFvYVh6d1hpd0xB?=
 =?utf-8?B?bDZJVW1NTGlyNUlrSTM3WUM2WTNoTFZnSDdVc1JmRFQ0SEFHMEdpWDhqTzBC?=
 =?utf-8?B?d0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8c3bea-30b3-4a40-7ecd-08dbd96e9a57
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 17:35:26.5188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugs3A+9tF1rPLhCkmMty2EqBDm9LrFtOtuxIebue2jqyfbUctYi7fstCvFnmLv/UnJv6ElSJFf1njIfJKrHt6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8083
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.10.23 17:43, Rob Herring wrote:
> On Fri, Oct 27, 2023 at 03:34:36PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> On the Siemens IOT2050 devices, the SPI controller wired to the Arduino
>> connector is normally driven by userspace. Introduce a binding for use
>> by spidev.
> 
> What's spidev? Not a h/w device...
> 
> 
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>> index 430a814f64a5..01b9f36afcd5 100644
>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>> @@ -349,6 +349,8 @@ properties:
>>            - silabs,si3210
>>              # Relative Humidity and Temperature Sensors
>>            - silabs,si7020
>> +            # Siemens IOT2050: SPI interface on Arduino connector
>> +          - siemens,iot2050-arduino-spi
> 
> How is this specific to your board? Presumably, an 'Arduino connector' 
> is a somewhat standard interface, right? If every board with an Arduino 
> connector adds a compatible, this doesn't scale.
> 
> A connector is what you should be describing, but I imagine it is not 
> just SPI. Here's some past discussions[1][2] on the need for connector 
> bindings.

Right, we are not alone with this modelling problem on our board. The
code talking to the SPI devices is inside applications, the kernel just
needs to pave the way to the interface. However, you can't define that
path without bending of the DT. This is specific to at least SPI, maybe
some other buses without probing as well.

If this were a PCI device, no problem: tell vfio-pci or uio_pci_generic
to be responsible as well (add IDs on the fly), bind bind any of them
and then let userspace handle things. Same why to go back to an
in-kernel driver. No bothering of the DT regarding how the final device
is driven.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

