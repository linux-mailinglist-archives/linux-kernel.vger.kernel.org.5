Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8C3802F07
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjLDJoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjLDJn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:43:58 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3039113;
        Mon,  4 Dec 2023 01:44:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8+0NyYiUdr8xDtefcTRZWouCWPqXpKlWQ5pGo5gdhxVw+64+572vpfh6XTUsy5bZnVKR0ClRrHN7wcaCQ4vh9sAEL5/HSpncPn25JtWxO+dHbeJ1v5dHwpMv4dA7hdNaDTBSClE5MIyWSog95kAXyWUcu6tkbzd2wfXETttc8hb2ylM9rFBMR2GqMAy50vnJF68UBxZ1KYxobbICKm9TJkJmFF2gyEQo3xN3TTXeoffK8r926xgm/56ctAFayYIZpRG1MrwhWKlGDYT58Q/XFfGXv+1eB2o1KCyHR4OexqbUliRDvn5h4zIywUoltiAYGRzIrhAxRdQF70gVeuCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mk0rnq/J91yQs8Y7pa5dDentfdUgynNxpBnu2QD1TLw=;
 b=G0lOFAkU77IsUqu417O0DxiDo50wJJI79Ow7urmCPS68hUXbifM14RX7HQ1YfDvb3ncc7G1RUh1wyg03wCq9SI14SbinQpV+5xTzJrLoGPUyaPOsbnWJfsqnmEaFsICIc7m3/fq98xrAUuOdy8ncO+DhpnWOnXVryhTRDy3jAYg1c55X/9s4VBjkcwjQLw1gBBO0NVt7Lg/qam4g9lqI4nL9Vx4VMloc1SvyI9w4mbca2apoHWBta/KCWdrQAF7DXqohYQezKyYSsCTdDiUZY9/4arHs6VE8Wl8Qe14/ihh6XmvGhzkChFugjeXYnit7cai5p+CLYFPkX6ZJYcJR7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mk0rnq/J91yQs8Y7pa5dDentfdUgynNxpBnu2QD1TLw=;
 b=SlCTUglN8oFmNrDCTCG0HrLGoTkUHSxQfD/sTyFEF0gCLmfXrrK0S9meWcilgMZ9heFJLl+LmfGfqvY2WZ6TDgstdhPCiSheEmt16HVFJbHRMgKgqr9BBAyIdN5x6VzrWShJ+iUDm7nhSyMr3qKxXD6DH6AmowzUxAfrDwzFfcRKlxsmgDzUx97gnWmRfDSribDVpFOTnFIq9QZNrcdtR1gQNDpw17WNPY6tntRmOBYxsZnSuNOVCcNHioypkMkQa1SLQrTqvsPUJepRgQPFoZFPMnIdYUXOGbEcytKo5tCIN1J+++V7sjedwUKUuYxmd/iDN1w5JJ9NxOFYTlqtEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DU2PR04MB8966.eurprd04.prod.outlook.com (2603:10a6:10:2e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 09:43:59 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ee0:71d6:cd29:289a]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ee0:71d6:cd29:289a%7]) with mapi id 15.20.7068.022; Mon, 4 Dec 2023
 09:43:59 +0000
Message-ID: <b36e07f0-a8d6-4623-8531-4c3eef5dece6@theobroma-systems.com>
Date:   Mon, 4 Dec 2023 10:43:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mdio: enable optional clock when registering a phy
 from devicetree
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>, Heiko Stuebner <heiko@sntech.de>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20231201142453.324697-1-heiko@sntech.de>
 <84c102fa-e3f4-4454-82c9-95eea7eeb941@lunn.ch>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <84c102fa-e3f4-4454-82c9-95eea7eeb941@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::12) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DU2PR04MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2e2b97-9b81-4512-5dad-08dbf4ad8a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YroV16e+tdqZdKFlpBGaoCMTBgD9p7OrDOHmOYY0YkX3W/AGNf8YHxn+zSYNiOQMoySxTFxoPPZUqDwwdWE26ncvO+yM9OqaiczchakDICAb3klHS+sULibzdmuGpm9TroWJCh17R/npgaZlxP1qRvJfkfRncjO4xYhfJcYOe/IkeMM4I5iMZwh0zrm60v+mSZdFDJyqgBa8bNgQjyZUc9HV1apdVc4dqb58RkM+7XF2584HsIogLpcRDHrIxuBXxbSnIfCLml5vMc/0tBXJFM8vkZQ5qzALMPwq89lbbMazTv7xnaww51gp5YmXfjL64R2JMV6yduU1FfAOUD0UGCr6W9tGzdALArzlqU7l97nboqybTz1wulz9xq699VKHQMgzYaj7i9xht2jBmepYKF+eaJTby+MMJT5XMSl5fF6DrDoq4NzRVroMXQaTOfj46woy2YJ9Zj91lDMJ5ZMdc2sc3+lUpyCFY3+z2XHIW8bzkzbgEzZzaAzHKico2AsZdPBZxf7yS3xwjKKIvIUsGArgtMIOwcIL7GUKuHkpWw5y6KgH6pwppjbbF8dfoavOGVR24Y5TvUZp7XRE2WtCFynliKo+7iDQLoHVSkNYjtBrVqKK5XJlxML9n8FCRnxuhlkcQek2FJVV4vCRAIFr4Lej1h01zUKIPRm5F5InDPHHZFPq6kGJF3D2AGodz2kg8Eo/sgf96/7EHf2UEwpQez+myOlyd7QY7lYx3ed+gNY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39840400004)(396003)(346002)(136003)(230173577357003)(230922051799003)(230473577357003)(230373577357003)(230273577357003)(64100799003)(451199024)(186009)(1800799012)(7416002)(5660300002)(31686004)(110136005)(316002)(4326008)(44832011)(66946007)(66556008)(66476007)(38100700002)(41300700001)(2616005)(83380400001)(26005)(8676002)(31696002)(8936002)(36756003)(86362001)(6666004)(6486002)(107886003)(2906002)(966005)(53546011)(6512007)(478600001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVlDQWdsL0NQdlRYdm1YdEsrdkViUDREcUc5aGpvV29TQUhFaUo3cEpsZ2sw?=
 =?utf-8?B?ZGxWWlpjRUI1Z2x2L1NjUEZxRnJYQURJQ3Y5ZjJHSFArcjYrS2dPeCt5Wmg5?=
 =?utf-8?B?TXNja05CRVp4K05KU2FWeXlTc3BmK2xGMC9iUStlU2d5L1pxb1ladHRPa0FZ?=
 =?utf-8?B?eUM0eHE4eTBLTUFvM2pCY3BQMTRKSmd6L1Rjem5DL2VBbWo5K1dMTXBLdEpC?=
 =?utf-8?B?QTd5dG1ENWFET2l3K2pRb1R2ZlpCQnpUVi8wTDVxZE9abEh2dmVaUzI3emhk?=
 =?utf-8?B?NnBJV0lYSlFHTW16OE9BZU1OdFluQmYzdWR3NGtYNENIclJiUU9uQitWcXBi?=
 =?utf-8?B?ZzI4UG9EODVNOHgvczkvcU5hS2JJeHdNTkVvMXlnZkphYVI0aCt6RTRYV2di?=
 =?utf-8?B?QXVOSDY5cmcyWWx0VVBuNUd6aG9DbEFGOTkzaGpFTVgyLy9kdGhucURkRnFJ?=
 =?utf-8?B?eXhxYVZNRk9qKzllamU1bkl0cmdES1hlMlFLN3ZrWG1DcVhLKzJIZlFqVUhw?=
 =?utf-8?B?VkZOTC95YW9KdFkzTVU2cWRuZ0ZwTm5QcHBJQWJkUG4yUFphOWliUXJDYTk0?=
 =?utf-8?B?cjdxOEdVVnJkZ3o4V3NSN0ZsUGhSenBGR3RJb2NoSE1UUTkzSFpicTdyZVRw?=
 =?utf-8?B?d0ZxSGhxMjBmTE51YVNYeVZBUGVWRThyOVNNemNtMnNVZEplelp2Q1VLU2Ji?=
 =?utf-8?B?UjNTTURsdGxMeklPazRTdHNBYVRQaXlYcXA3UjFFZVllYlg3QjhrbXdGMkpP?=
 =?utf-8?B?ejBiR1ZIZnAwOC9Yc00rVk5lR0xPRUtwaG5wRzhxb3pPR0dXVDlsUkxWOFg5?=
 =?utf-8?B?a05YcXRMQjhQV0ZMbjBsVDBwMGl6aGxqL3MxVStHZzZxUmVwS0NBbjJndjUw?=
 =?utf-8?B?cGNDNURTcDJFSmVuSEFDSXBGc25qNDgxQzVMOHZVZzNzUG1ZNVk4WmVFeUdn?=
 =?utf-8?B?OERjMzhkWjhpb3pvZGkrUVFMM3dEczRRRHUyckQrTnN6bXE4MXNwaCt5dXBl?=
 =?utf-8?B?TlRtZy9FOU1sUzBQOVF5RExkTDVraTVaZnZrNXJ2dXE4VmV1Q3d0YjlLcGRD?=
 =?utf-8?B?dlhCclNwZmhGdCtKWnNucW9vNnZybXVhWGNZbE0vN01TQ3JaU2NqS0hQTHMr?=
 =?utf-8?B?eVVkUVpobzVuUnNTdnp6K1hRTDdERWV2SXJSVEt6anQwaU1uUXVIeVRxUldw?=
 =?utf-8?B?VUwvZGFkTDdiUU9yc3c4cXN5bENrRjRpY2JhNHdkSjU3VEVvVTYrbDZnWERn?=
 =?utf-8?B?TUtXaU92Q1ZsQ3lJcUlZeGFNRFJMZXd4WURrRWMzSXRGUVJuUFh3Z05DT2JD?=
 =?utf-8?B?NmNSWnF5OUNsYlBzb2RONDY5bjBUMDVvOHRmN21ZaVl2Y0gzdzBlV1pxM0sv?=
 =?utf-8?B?N2ExazRGc0xWUHlpV1NCbXZUN0RJMGJqbVkrRWJwbUVuYzhUMzNiRFNyd3hB?=
 =?utf-8?B?cmxoREl0T3lqQUozUGE0MTA0UXpzeEVBdW1JS3p4Z0cwc0VGc1hkUGh5cWMy?=
 =?utf-8?B?RGQ0bGlNNHg0NzNHdFRRb3prcFkwZUVFajBxQ0d1eHQ5QVZjVDlETlZucDc1?=
 =?utf-8?B?a00yTk1lU3lqQmJ6RXZUT0pKdW41aEtSK3pnUlpONnJaMHA5TldFZ0xjWFdS?=
 =?utf-8?B?VHd1anAvRVgwS0loclZuYnBaWWljc0h5dkZRa0d2MThRajhWQ3hRNzhoTFZO?=
 =?utf-8?B?R2s3QU52dlRYcnNueVRia29XZEZobjV4eU1xQm9aR0UvMlNSNDI1UWFiWlkv?=
 =?utf-8?B?RHNqcEpLN0g2S1VGRFJqR2doTUZTakNBQjVDclZQdDJxdXJOUzJrYUhPYjFF?=
 =?utf-8?B?VzZvQm04OXY1QUJaM3lJRituLzBCaFhKZVVvOTk1VFpNbHJYL0pBRXN3Q25L?=
 =?utf-8?B?cGMzY3RuNDFDZzA0d1k0QjBzNDB5RTJnSWhnMW9rOE4rWnpkbDQvc0R5TStn?=
 =?utf-8?B?aHkySXdzWmZoNFdpbHJ5cXltK2oxa1RqZUlXSmVoUm5rTm50YWRVdnRWS3FZ?=
 =?utf-8?B?b1JwbjAzVDRMdHJGTnNBY0c2am41YVYxdEwzSzhVMWRpZkxYNTFGL2hFanBT?=
 =?utf-8?B?alJESlBLbWZaZ1p2VXBqdVpwbFpxVld4UzBiRlFYN3RidXh1Q0hseWIzbjRO?=
 =?utf-8?B?b29ES1F4OUluUStxQnJLU3RCME5TWDh4dGZxNFJUNUx3V0IxUW93SWJoLytY?=
 =?utf-8?Q?zl7RPz2C+Sqy77VnF9amLsI=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2e2b97-9b81-4512-5dad-08dbf4ad8a44
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 09:43:59.0089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVHaeCOC60WNcDNlGfWTX/BEWvK3JXYTu9pnmWONVlTHi3JDZh0qUswMjNan4QbrWnXnjob/ZgBhnvx9/Lb8UkUwUYqFRHcl0pgc2+2LeLzdeG/4P4jI3UXxcwKm23xY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8966
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 12/1/23 23:15, Andrew Lunn wrote:
> [You don't often get email from andrew@lunn.ch. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Fri, Dec 01, 2023 at 03:24:53PM +0100, Heiko Stuebner wrote:
>> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>>
>> The ethernet-phy binding (now) specifys that phys can declare a clock
>> supply. Phy driver itself will handle this when probing the phy-driver.
>>
>> But there is a gap when trying to detect phys, because the mdio-bus needs
>> to talk to the phy to get its phy-id. Using actual phy-ids in the dt like
>>         compatible = "ethernet-phy-id0022.1640",
>>                      "ethernet-phy-ieee802.3-c22";
>> of course circumvents this, but in turn hard-codes the phy.
>>
>> With boards often having multiple phy options and the mdio-bus being able
>> to actually probe devices, this feels like a step back.
>>
>> So check for the existence of a phy-clock per the -dtbinding in the
>> of_mdiobus_register_phy() and enable the clock around the
>> fwnode_mdiobus_register_phy() call which tries to determine the phy-id.
> 
> Why handle this separately to the reset GPIO and the reset controller?
> 

I was just wondering about this as well. Right now, we put the reset on 
the MAC controller device tree node for our board (c.f. 
https://lore.kernel.org/linux-arm-kernel/20231201191103.343097-1-heiko@sntech.de/) 
because otherwise it doesn't work.

I assume this is because the phy net subsystem is not handling the reset 
at the proper time (it does so before probing the PHY driver, which is 
too late because the auto-detection mechanism has already run before and 
the MAC couldn't find the PHY ID since the PHY wasn't reset properly at 
that time).

I think essentially we would need to have both the reset assert/deassert 
and clock enabling/disabling in the same location as this patch is 
suggesting to make all of this work.

I'll not investigate this, because Florian NACK'ed the whole thing. I do 
not personally have an interest in fixing only the reset, because we 
need the clock to be enabled for the auto-detection mechanism to work.

Cheers,
Quentin
