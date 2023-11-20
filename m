Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EDD7F138A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjKTMiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjKTMiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:38:18 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D746CD2;
        Mon, 20 Nov 2023 04:38:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLox1ZDi+dMCbZbq3MkXPt5MnZVjntl+koFu98vYXJq/1N8HEHn+BKCn/uKKgvmw7l33VnI8jMqdF/mRE3fQBvUydV+Ms3IFODFLa0HdUM8V2iOs1ZZASXhrATXkPaUNY07izLaRckwjhn9xdKJBxkunecxP79xEJn2ZpUR2aqiEDR+oN0z2u/GwiAnIffi1oxZhpssYA5nyXIqXl3UV9ThURS4oneCO8fPPLsgmjA4cBnaXc7gXI79XqQmpH7AiWP6svBl7CscqO9KGcTyaQ2Op4Oym2EB2HwqyOPOTJvSnAxd8ew5FQfGYD+akYr973oOz2Kpc46VbPNTSio0wfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yV5zFv6E2j3sXGU7rI/iUY4u8BCL38Oe2P0dwiUJvco=;
 b=mq/ilTbkx+ktmB61eYgiq3fx+rrPLYmfyP7ZiZfOow0Dt3QfvNcYCC6GSCYqS74IcNhgxW9Xu0/oNGgKGjy58TyPYOpelvkz+3yEB3qR0jou/Pm7lE0hjWEXu3nJj+htiYAVMpUt7F8SV1bMoKQG7iW63RBxevoJBMhz7PO7mtN6uTWCxK0pelLNej0KH4c1zJwH69pjitJIJR3NnpheYXmICUEli3/cYQPa+avSz8llFDAwSCq4tofjMvQuDWw01hWdupKN/RmL/Nm3VH5c2mNR7LEwrR7PS4mrlEC5rjf7NRP+CCiTif3KbrHxcFb08X++cqSMx3xphdZb9hwfiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yV5zFv6E2j3sXGU7rI/iUY4u8BCL38Oe2P0dwiUJvco=;
 b=jybMhXN/uXY2Y2CX/NcFtYMv/wUH10p042kAW7YhVTM/PcB78MIBVuS8D2kBKic6Cm/DGQJd/G1B/HlQAt1LQDX1OpRGekLBhrVdHM3j2qdRHEO+xmnY1c/LKfEl4hIs0Tns3U3Xd2OAClycSsv2j7kkLk65KatNhywHIqIc/c0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by GVXPR08MB7773.eurprd08.prod.outlook.com (2603:10a6:150:68::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 12:38:08 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6%5]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 12:38:08 +0000
Message-ID: <2508da6b-a099-4271-a1d0-04cfe5d39daf@weidmueller.com>
Date:   Mon, 20 Nov 2023 13:38:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: Fix potential null pointer access
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lukas Funke <lukas.funke@weidmueller.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231120093256.3642327-1-lukas.funke-oss@weidmueller.com>
 <ZVssJrplePACN3of@shell.armlinux.org.uk>
From:   Lukas Funke <lukas.funke-oss@weidmueller.com>
In-Reply-To: <ZVssJrplePACN3of@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0450.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::11) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|GVXPR08MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b9c3ee6-50c8-4591-7a91-08dbe9c58c82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mh9LrxbBHTpchx7KVnob2y6s5WfSduBaYgzkSo/3/iZQQQivOGRi9LJmbSglUegfe5+rc0QRy+TnvpAQ/2hL2UJqV2jLZH71Z8a3cuDydNqIHXgSWp9GCYXVE0R3kQEgrTKxfGfL4BstdHd8MJ1Dn3Tdp8jzocd7Bud2Z8XIGEDWl5I8QtsWpMs6aVgtzUpRWWreZr7LrCfgj8rAjvcicqx7xsIglwX2+sluACkrCgFTxThHits4X8ep/PbGrz8HK+e4zycljzgRRFfSb+lae/TWNmC0kdk0bxAtVXgHp1VFwgHEglwxGO7JSf5LWjvB/k8gvox3hp/b8rH4mPLrNbLUev3XiJnZk+ffyotqqqUbA2WsS8NEJnqfQcqzA8wnfb60sZ+z/K+ZK/ALdCJAvEvHIZ1p1Ws8QQPseFD79J/5mKyrWjsSX2z5Wg0fSk5dFG53mJ9QXDvzae/8oT3Q7v95vre4RpSvT9/JHraG/QQHnyS+yEwXNBKdaj5gsrqeK5MkkX0HTfluFBJLcuKlH72hHvcxQS7lYf+A8AZxH7bT3ZkbEDPytDMQM3yTaJbeGCCmY1p5oSPlOw++qExSE7FhDplAiVGSQdanztaBvZlSMBD1YDdPJ11Om2ePfP5DUr94GAcSeN7YeFNSiowwxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB8431.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(4744005)(5660300002)(2906002)(26005)(2616005)(4326008)(8676002)(8936002)(31696002)(86362001)(41300700001)(83380400001)(36756003)(66946007)(66556008)(66476007)(54906003)(53546011)(6506007)(6916009)(316002)(478600001)(6486002)(6512007)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlR4eWpPWERvQ3dMUEJzZWRhUnUxYlpYWkF3NG11NWtWY0s5R3pDMEdwSURx?=
 =?utf-8?B?WkNUc202NzNVRmpBeERYL1hDRzZKWTZpR2ZQNVlrak5WaVVPS2NIay9ZUEFs?=
 =?utf-8?B?RjRhRFdpZ0gyMWN6Y213QlZRa3RvMVp5U2VUV0JFblhVMitkTTB2N2piNDgz?=
 =?utf-8?B?R2ZIMWdaSm5EZEYzSWN6SGlKVmlmeWF3KzRodmo1bkVUSy9xeTJFVkRoVWRz?=
 =?utf-8?B?ZDllRnhrMWxSNit6TUJZTmNNcWxpdmFnRys4R3JOZUpIUCtjVWd3b01xeTBh?=
 =?utf-8?B?aVdadWp6KytDWVRsb1cydGVDZzQ3WlFCS2t6YmIwZlZYN2k4eGdDR0J2SWlR?=
 =?utf-8?B?eUpyWUNWdW9kaFBCdkRyMy9ubXVLRy9BRGthdEVpbGhUR1FmazhjOXVpVTBx?=
 =?utf-8?B?ancvVnlwTUFiRkZMWlVGZC9ROFdBcVJVYVRHRC9EVnV4ZWpOYVNFSTY2NnVj?=
 =?utf-8?B?TGhhcHcrNmgwRU9rOXk4NXpnYjR3M2Qwa3JvMGw1QTNhQkRsUzBvQnAxeU5R?=
 =?utf-8?B?UmhGTWtSZ0VTOXhOcTh4bnQ5YXFhV2creFFnQkZUUjV5TVN3K0x3VGlISFpX?=
 =?utf-8?B?QmVDeGpOdHQwWS9ESHlJL3EzRzVIdi9DKzBZanRSQlBmM0sveklYTHBtcVZ0?=
 =?utf-8?B?UGxaMXhiUVFsL0xQWUE3ZFU5akxqdGVzWXNFdVhkTEhkQlZmM2ZLT3Q4WkJP?=
 =?utf-8?B?YmZ0MnBQcWo3N0lGZW03T280RXh4b2xmY2N0WUFqUXdNczFFYzBvZXIrSExE?=
 =?utf-8?B?ekRPTXZ4ei9oZzhXbjU1TWlHb3o2QUpoMXExOW9sd01kdFhUaVJlZzhnc0RI?=
 =?utf-8?B?TWFTOXJYMWZMSmpRelhUU0huckFOUVNvV1Y5V0QySjlQUlhVZXFnL29ORXhP?=
 =?utf-8?B?L2tiOW10K3psVFNLUmQ2TnpPc1hXS2lHamZLVFRCM3JnY0t1TUc5OWdhT2VE?=
 =?utf-8?B?b0ZHUExZZXFJSWVoS1d4Wk1zWXV0WVN1QnRUbFRudE5ka0tzam5LdHhINHJJ?=
 =?utf-8?B?ekpRTzR2bk0zNGRRS2czTzg1dkxpc2dPT2Y2czI5R1dGVWZ6eWVUb1V6TkRW?=
 =?utf-8?B?VEpuWi9rWXdjRFREeXdhcFVndXBpQzNhREpxbHg1alJPZmNtYWsxR2lNYnF1?=
 =?utf-8?B?TU5zYWdzTU02ck1qUkl0QmNlRUUxa2srRlVlSmpBVHIzditnQjZKK3BTWjV4?=
 =?utf-8?B?YmZUU3NDN1E4U245c1JjYjliQnVJMUlja1lDZEhtbTdXOVJjQS9tRExBZTky?=
 =?utf-8?B?SHpOZFBKdCtLVndCZG1udU1QSUt4NkFPcGdRY1JiV0FJNFJsYXB1ZllySXUy?=
 =?utf-8?B?d1ZuenI4K2lyT3p2bzNxRCttU3d4eHV5QnhsU096T0NBOWd0QmJ5TTZtd0NF?=
 =?utf-8?B?VmZkd3JyNDUvRFhHTHp1Z3podm5adVViMkw0TDJES0piSy9BbmpTM2RTbmpt?=
 =?utf-8?B?K1hqbjUwdm1BZzhJWlRxVjg4SVFNUndad0ZjUVVSL1VtdlFYcjNBTTQwQSt0?=
 =?utf-8?B?ZlhtMnVjUnRHN0xBemZ0a0twSHlxVEg3bklyNGRxNXZWVGtXWDlQaFNhd2ZJ?=
 =?utf-8?B?d3VZYk40MzJaYmt0cUhycElud2FEb0FkaGRDSWlFLzlQQnFjUkNvN2xLdnVJ?=
 =?utf-8?B?VWdlZFFESGI0RHJISzdIaW5mQ1NJRzNiM3JlaE5TakJpMXdsN3VFb0hvMlZC?=
 =?utf-8?B?TTBrSHZpUmtybE0rZWJYSnRPNHFmYkNXRnB4OVlnSkRzMW5MSTZkUFgrbHY1?=
 =?utf-8?B?ZHBMS3RWOHhSc2tMZktqZ1pKOEYxNHJXOVRnbFhIMGRrdlBhTXRreXBVdXEz?=
 =?utf-8?B?eEV5NGh6SiswV2hZS3AzMjhCdENzbElQZzhlV1JsTnp5OEd4VlFzUEhXMlIv?=
 =?utf-8?B?UTBLcWpmV2UxT3RsK0QzWS9QMlQzVUtrRmR2MThxMHZhVnFMdS9iRkZ3UERF?=
 =?utf-8?B?eHQ5ZjU5RnRocFg0cTZGdXJqQ1R3NERjblpsd1Y4VnRSaFloa2wyUk5UTnVW?=
 =?utf-8?B?Tm1zZmhUcGhBek9EYjd2TTRlVmMydW5SdW4vODR5UVlLcmREcjVqUjEwZVdW?=
 =?utf-8?B?a01laGNDTVNqejBCSmdsMzloY1NTejQwR3Q1Qk5mVkFPZlhtWXpkTlR2UWUz?=
 =?utf-8?B?aUxpVWFvb3J2N1Yza042NE40RkJIaUg5QmJHdnlRV3FWM0hzY1RmN1JPZ0xO?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9c3ee6-50c8-4591-7a91-08dbe9c58c82
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 12:38:07.9141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44JFihAr8TGUvV4Iz0qAHv6IB6y/EeTvgNCjq7dKcsutnxPK441bOUurhZtAN597/c2imokc4PXtlZ+7JzUCPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7773
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russel,

On 20.11.2023 10:51, Russell King (Oracle) wrote:
> On Mon, Nov 20, 2023 at 10:32:54AM +0100, Lukas Funke wrote:
>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>
>> When there is no driver associated with the phydev, there will be a
>> nullptr access. The commit checks if the phydev driver is set before
>> access.
> 
> What's the call path that we encounter a NULL drv pointer?


The patch is a bit older and the path is reconstructed from my memory:

macb_phylink_connect -> phylink_of_phy_connect -> of_phy_connect -> 
phy_connect_direct -> phy_request_interrupt

It happend when we used the Xilinx gmii2rgmii phy driver. We did a 
missconfiguration in the dt and bumped into the nullpointer exception. 
Since other functions like phy_aneg_done() also check for driver 
existence I thought it would be a good addition.

> 
> Thanks.
> 

