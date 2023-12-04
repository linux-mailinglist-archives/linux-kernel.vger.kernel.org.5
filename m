Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61A3802FE4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjLDKOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjLDKON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:14:13 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385A785;
        Mon,  4 Dec 2023 02:14:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVcnuzwkyBVwXK08dM+B7Ck79PqalFcsb4NjfNRoBj0kNg/A8OeIGSRvMuN+ABmc4FrRR/D/CJRiWoEbvHmLTTBaUQP54x0Z1y5/uaEfARdc/9JLuLdjFcp7Dx5LD6WvtG0hw8lM1PGh7NeVsPYTXlDQ1/JW03FheqUFQ3YFgzGtvg0qy+wM+CjERZiaisYijk++AR0vE6oWKkBIYevvKiAIUNntKHC8oK4XdKLO95l4hJaIOCvM03qTtCnTJnb8prMOqzoGEHxobHOk7c292rZBAVkPA4xXzoPZei9uARHRlDwvZ0iveois2SJgPeO+/RS4wwKTEe2hBw8XPhr8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NK36nIN8ePHeR4VI6DqoQNuwIVti5qjmSBMZeiAKF0=;
 b=ez+pzkQ6OyHYtHvWKZaZKNxEWTq7iWwT8kxN3J3RWqFM7aBzzIifzrTLutWfCaKxYHOdSz6boDAG2J8+cwrvSXmBWLwhl35KfsXnKWfYixZzQe9KbA/0KDqATZDqcXNtcy7hbY8s0r+WCWkhuPySCXfnFbX7dKdXs/K1HnkAXJmPK66ni5ZSkSU0T9KWkCtPfFRcZ4BHJVKg64XLUdVCOBEw4Dg0MVhIYoi5IpvyXMJZRIP7/1rlcb92Otg7b2QTgnvHGw6mnrNM4XpfPJ8rXPhfMLhShLU/f5vfvMCdTHPH8WiYiqk75TVryrQUIPFNWojAH9xQeUE3MaE0uIB27g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NK36nIN8ePHeR4VI6DqoQNuwIVti5qjmSBMZeiAKF0=;
 b=WmhXOIGbIX5XLftQN+1/5ocem8MEPPl6jPhAl09xFLoLXdfQ2mfIMRdeKEVES/I7dWk5+jDl9+wHc3eHDJxR4s90lcusKKmGrADFr0KGnLhCrI7cXlqfnJHHEgSfAh7Kw76bR0e8oSRRmbyvAk44Z9DGtBLcHtFjw2mDVwjP0V8cZMRpA7/q6/ku4oB3m6OLHKt6kaZsw+rqR+uOvZ9dBdawq19TFBlizQ/Z1ktjlISNEpf+1kEBMqNQo9jUxYkEV0NjGnmxMZ3X6WeUDvw3vrc2a4xMv9vFBZhb22VOBOXnQy5gScYZxTrlX6JdNGrdRRBcPl8/XwI3WI2yzvMT3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DUZPR04MB9781.eurprd04.prod.outlook.com (2603:10a6:10:4e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 10:14:15 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ee0:71d6:cd29:289a]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ee0:71d6:cd29:289a%7]) with mapi id 15.20.7068.022; Mon, 4 Dec 2023
 10:14:15 +0000
Message-ID: <10f8e599-940b-4b7c-8c82-8d505007f19b@theobroma-systems.com>
Date:   Mon, 4 Dec 2023 11:14:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mdio: enable optional clock when registering a phy
 from devicetree
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, andrew@lunn.ch,
        hkallweit1@gmail.com
Cc:     linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20231201142453.324697-1-heiko@sntech.de>
 <ecbdcfb7-32ab-45cc-991a-982c52bf4b14@gmail.com>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <ecbdcfb7-32ab-45cc-991a-982c52bf4b14@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DUZPR04MB9781:EE_
X-MS-Office365-Filtering-Correlation-Id: 583cfd83-2c37-413c-f752-08dbf4b1c4c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9qm7BAHk4FywL9O1+hONP5BmXNL8fwHXaOMWurMyB8CLlV2uEcwGGzHwshCXpyNA84X5zhyvAYg63swTxBSx+Q7licEeVODu28ArIuTyL25s86Y/9CspHEQotO/0WSTkB0m6piOTFKv+Lwf6RUVJAkmz6SeG31XJSWjFI3BukbKnBbJFJxuUvJ47a99I2z0Uwg560erUFcDU1f5r2cMx75RRlvzU7hFc0WM0bx1Hc+lhkw1Z3bFvd7Fb86ycwoO38uz+M6kJO42vJZrrXBO+PcIHsR5Ur/fzimc3XbQNRjyQsnMynDmZ40ecfbVWb9Wmr01nZy8221ycl7+esiK0qH/JxwIAOM8OpdPgLaMjcHmN3aTRHvGaCmq1CleaxfGGMI38eW0ZgNlHAuG1tqx7l8IJ11Hl2d8NXucN8jc4FCl9Saz4K2TxlA8TxD5imBz1D5qapSfOGPPbaJvUS690y5xMFtlr8/UjG3lPjDRNJthU9chMEJSkXo9p9p8XbccXdgjv9gVjxmrHz7lp+Q23Aij60wGTooe+QspE1aFN2VSIDK1VAbJutRjdf5/60JWHCX7+0uq1cpnK0BTkEXk7TsZhLcfIx90AhDldDZW5aF9uAw8l57SBFld5HJhXP+Makhu88YuqDw120YCRvdTGWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39850400004)(376002)(366004)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(66476007)(66556008)(44832011)(66946007)(316002)(110136005)(4326008)(8936002)(8676002)(31696002)(86362001)(36756003)(53546011)(6512007)(6506007)(478600001)(6486002)(6666004)(2906002)(107886003)(2616005)(26005)(83380400001)(38100700002)(41300700001)(7416002)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3RuSFE0YVlRQVErWEtjMmlGbVc5aldmQ08yNFdLNUJrWVA3NTFOcVR5RDNz?=
 =?utf-8?B?UlJPQWxJeUpEdVg1Slo0QlNNSEpOKysrWUJmSGNxVnRlbnV5TU9WTDM2T29J?=
 =?utf-8?B?VzlVL2pKQnMvczZiS3dlUzFGRDJuU3kwTXg4TlZmWHBxNDJxN1NKdXF6T2Nq?=
 =?utf-8?B?WSsyaXBDMm5ZQ1krM0FReGlTeWtTVFFpNVMrNzBvdmdOdUlVNitQSUs2Y0VV?=
 =?utf-8?B?L2ZIdS9hOUJzSnNuK2hoNEtSUjFrNzJFaE1IVGRvMXFnK2EvSURSUFhKQzRs?=
 =?utf-8?B?QWRWTk91VFRYTmk2WWVLTVI3bTloNW5CWm5WSmMyYml0cndjTHkrcjY1U3px?=
 =?utf-8?B?RGZGVWsxUG9SV25sYy94amV5YUZwSFMxc1lpYjVpcCtCYkpsNFpCUFFBdU5y?=
 =?utf-8?B?aktjV0V2SnErbkxrVVZZNHllZ3FMMzd0dWNUK2dRaFVOVlVYSVpqMHhDSE85?=
 =?utf-8?B?akMrS042MUdzU29yK2Y4ZHhYSVZsMzdkYWFydnhWT1QzTW9rUTVxblEzdzY5?=
 =?utf-8?B?UG1zN01iK0FhSEl5c29Mb28zajk5U1pQUHdXdFEvdGRMeStaQ0pVNFJiR0t5?=
 =?utf-8?B?MkRYZ1l0S1YxSDVJdWk0UnNsbThaT2o4MDJhYjZrbk12QTk3d2Fhdng1UUky?=
 =?utf-8?B?emJOK1FqOCtLOXF4Y093bUhvdUZtbGdoSnlvUmNQTDZRTkZuZEp6aElRelA4?=
 =?utf-8?B?dCtDb2k3cUZDd3lJNnV3MGRvbzZOS2hXSHpIK3UxYlIzbEd5Zk84MVZpZFll?=
 =?utf-8?B?THdra2xkOGIrdVIyMmRub0JzdnNPSlFlNGdUNllIMGZqbjZFS05QNUFQQXZq?=
 =?utf-8?B?cEFkSy9lQnQ1OCs2OE5BYzlBM3Yvc1NJRk5LUGFkUmRTc3NiTXBySVBHRmx5?=
 =?utf-8?B?SGM1Ly9LZytiYitrWW95K3F4d25wNGpISnp3a1Vqb0FOUWlzMGF0NU05aStX?=
 =?utf-8?B?RVZHZm5KQUpqQU5ScHdHVjNxYS9sU1owK3NOWlg3bTBXZGk0WUFaeml3a0tV?=
 =?utf-8?B?TldFRlNKVFJFRGE5cW8vT2Y4T3ZLWGcrNFdwNW16MERidWVodmoydnZmdkw2?=
 =?utf-8?B?N1p5aWJKNkpvcTJDUGZ4Wi91Mm5ia2NQZ3RIRnBCbDlsRTVBQjFtU3hMZitQ?=
 =?utf-8?B?N1IrSDd4c1dNZ2VyV2hGRjFLdWdxQTVBcXNpQ2pzVVpRWVEzNFZkVlRQejJZ?=
 =?utf-8?B?d1RJOWdvTFJjRzBnSkJYUmxiT3lKVlZtTWo2dytiOWtJbExIa3hkRDYwaXky?=
 =?utf-8?B?ZDAvekcwN1oyU3ozN1JjQUo3NDl0R29qd3FrdnUweHh1UHZHOFJPRGtXc0xH?=
 =?utf-8?B?TmUyaUpqNTJqQS84RmZtdVBKWW5xdk9GeHByaVR5RTgrSnpxNkhPS2FLZitO?=
 =?utf-8?B?b3FkQUNnSTFOZCtCSWt5L0JyV3RlMEFZdVJMdzVEMkpsZFUvS053Q0x4cWN2?=
 =?utf-8?B?cUdwUHFtUDVXaVJVN2kraU5QUFl6ZzZJa2ovUzRFbkhodFdreU1MbmhTQTFR?=
 =?utf-8?B?b3RMdGcrNC9qQzUvZFRpOUtMb1p4cVlCTnFtOXgybUNJNmE3QUFCYWNzbnNL?=
 =?utf-8?B?cDhKa0hLalh3UHVZZVAwaTQ0UFkybkdxTVRQZm0wbi84TEgyd3BBaG45ZFZo?=
 =?utf-8?B?NldnZFhYeGZMb3R1UjRDa21Td0d3R2xaS2xUYjNtWVVQRmJpSHEwR0VsQUMx?=
 =?utf-8?B?bjgyb2l5L3pIMGRDYUtHUktDaW10LzlUamo2UmxPWWJKUkdWckF4RGtBamk0?=
 =?utf-8?B?Um9pY2dLTG5Jc043QWtsVjUxTzd0SWE3MGsxWkhWaytBVWZvUzBJY2JpN3BM?=
 =?utf-8?B?aUxYMXFwKzM3ZGY5a0lPMUhzSlZkSzNpMVRQaTJSMk9kaXc4Qy91WTVwRWV4?=
 =?utf-8?B?Wjg2ejJOSnFLQVI2ZHFobUw4bVc5cVpSNnFEVG1PVGN0N2ZxUUg2UjdnVUw3?=
 =?utf-8?B?TGhmYW1jcVhHZ1lCMHlnWUVjaER0VWljTWlMUUV6ZXIzWndlOHBKRGdxSXNj?=
 =?utf-8?B?eTlMV1hBbURBMjRkRFpKejBtWWNOd2YrR1lDVHB2TnQrdWdRcll2dDhMK1pQ?=
 =?utf-8?B?NTZPTFFSeEsrTEs3QjdtUVJjZ3pzZlFCdUx4TkFsNzJLUFFWT2VyczhOS1Yv?=
 =?utf-8?B?OUVwUmNWQ1JNZ3YwSzlucjRNWk5mRlprTGZCazlwWFhaMWhvNVpHWllnU2s0?=
 =?utf-8?Q?/ledJB8EMF87ihbRRgv5rAs=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583cfd83-2c37-413c-f752-08dbf4b1c4c3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 10:14:15.1956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IoQ/uNof/tSYM4dw8zrkZMEeGZwZigVpoyc7fY9JQni7vj0lBwvM6oM3y1rZqzVcm8RtDd4wsc4EGxgu2G3dC5i8jVrAEyGe/2wuelrZri6yiTFVHKBTnFERhMvLJWAe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9781
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian, Heiko,

On 12/1/23 23:41, Florian Fainelli wrote:
> On 12/1/23 06:24, Heiko Stuebner wrote:
>> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>>
>> The ethernet-phy binding (now) specifys that phys can declare a clock
>> supply. Phy driver itself will handle this when probing the phy-driver.
>>
>> But there is a gap when trying to detect phys, because the mdio-bus needs
>> to talk to the phy to get its phy-id. Using actual phy-ids in the dt like
>>         compatible = "ethernet-phy-id0022.1640",
>>                      "ethernet-phy-ieee802.3-c22";
>> of course circumvents this, but in turn hard-codes the phy.
> 
> But it is the established practice for situations like those where you 
> need specific resources to be available in order to identify the device 
> you are trying to probe/register.
> 
> You can get away here with the clock API because it can operate on 
> device_node, and you might be able with a bunch of other "resources" 
> subsystems, but for instance with regulators, that won't work, we need a 
> "struct device" which won't be created because that is exactly what we 
> are trying to do.
> 
> Also this only works for OF, not for ACPI or other yet to come firmware 
> interface.
> 
> Sorry but NACK.
> 
> I am sympathetic to the idea that if you have multiple boards and you 
> may have multiple PHY vendors this may not really scale, but in 2023 you 
> have boot loaders aware of the Device Tree which can do all sorts of 
> live DTB patching to provide the kernel with a "perfect" view of the world.

There's a strong push towards unifying the device tree across all pieces 
of SW involved, sometimes going as far as only having one binary passed 
between SW stages (e.g. U-Boot passes its own DT to TF-A, and then to 
the Linux kernel without actually loading anything aside from the Linux 
kernel Image binary) if I remember correctly (haven't really followed 
tbh). So, this is kinda a step backward for this effort. I don't like 
relying on bootloader to make the kernel work, this is usually not a 
great thing. I understand the reasons but am still a bit sad to not see 
this done in the kernel.

Heiko, I would personally put the ID of the PHY to be the most likely 
encountered in the Linux kernel Device Tree so that if we somehow have a 
broken bootloader, there's a chance some devices still work properly. HW 
department said ksz9131 so we can go forward with this. In U-Boot DT, we 
would need a -u-boot.dtsi we change to the auto-detection compatible and 
we do the magic the Linux kernel doesn't want to do and hope it's fine 
for U-Boot maintainers. Once properly detected, we fixup the DT before 
booting the kernel.

Cheers,
Quentin
