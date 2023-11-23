Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F4D7F671B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345932AbjKWT2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjKWT2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:28:14 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2619B9A;
        Thu, 23 Nov 2023 11:28:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdsR6jhWykZgQW3VOsmMtTVJlInTZbzVBZK01g4ZMNHyPLCn2P+sSHapHgj6pBqPGpwx0y99LLGREVDbhgZqh94729tee4hcvCh4Osc1lrMmLx9psqYh7I7kme5FmyP2hNDNbslrAtkJFGp0jX6ruwAt98BQn3T9fbY5YiH2g1V7cmAaaj76/KNvFCtGrS55TyqneZ0EouZjnkHxDcTTk4VBznAviSeLeQNJtZFgGrSq8X0pMEdIOoxq/+GO7nZs8CD0kMWUV6QJ9RTpvvcESDIoM7q5l6btz8WT1cys8sVu6EpoT5C7eAuLD9DFZ3kS8FORjJj1NQYNiDXAFYVbvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHK91HqO9Ev3CGROgDgTIvNKku4PPIyzSNhyCBFrvXo=;
 b=CBjRrxA2TK6BrOjOmxhoOsh6ULA5JM/ZpoXJI3AhlyaYQMVx1YxXs9YuRp5feHsfQrHQOy7oXVY4m8sI9e2WFzmBzkCctBQotQINUA9gILKL93c6I7c+ufk6WQxN/N0XLX+1AD8/YKbe9kd2KhnP5jHTtRol6VLfhRmCbGaRIrRRPbvBC+XR9FBaTFSWMsMS+eVntkrd5imnSAQ6I1IGlJEg3onEhrWahJaODZs+6d14eNGVpkH/mkcZ1ULSUpuMorWkPE30CqAXP/6jtIUw2JVmxlvkva0riyh94CsZmRc2v9v9oi0HxI9KaNZXQPPfnKoDE7gPv7vAPsGYLX8Krg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHK91HqO9Ev3CGROgDgTIvNKku4PPIyzSNhyCBFrvXo=;
 b=M/9q6RA+v9ZMke6jf9j/6I/1OnkgWbXu2yWm2jjWBi7r13I4SniyWVe6pbOPLLHVUCBfocJpL9eMF5WZateZHX53dN/qszRNb4I5BaWBDoj8GnpHTvRudSqGDoVczwDKC0lEFRYsUGQQtd1e8ItNiUXoYqtcWcbWB5R0tLRSQN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by GV2PR08MB9422.eurprd08.prod.outlook.com (2603:10a6:150:dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 19:28:14 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 19:28:14 +0000
Message-ID: <4816cf48-ac89-4ed3-85f2-b69d37566052@wolfvision.net>
Date:   Thu, 23 Nov 2023 20:28:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC WIP 0/2] net: stmmac: dwmac-rk: add support for PHY
 wake on LAN
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        David Wu <david.wu@rock-chips.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20231123-dwmac-rk_phy_wol-v1-0-bf4e718081b9@wolfvision.net>
 <f023fbf0-3669-4617-bb60-77fde3255dc0@lunn.ch>
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <f023fbf0-3669-4617-bb60-77fde3255dc0@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0251.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::12) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|GV2PR08MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: ef6d3176-bccb-4fe5-098f-08dbec5a560a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oM4eRpz1alO0y2y+ruxqybY1gft0Moyw6Ob861KdEWgdynMmNAr6TRtUqJP2buaHsIUVgTpNgGgGeGgSRO3WOuwLL5Z7Lw+cujFnDHSaCF5HDpOGnqzf/r7LGZhmCZP1dnqB3QxZqPTKnj4ffboImbMamTs97jk8XOZ4CPjj7CKikDfgGs/ttWZt1N/BU7jduEwEfvq5O7wbEc34TXovm5FlGcRwYL1t4F4uDAGrqh0XDhoWJ2Wll+HqRdqs9C1/pagN6P8J+ssRKmzP+cW9I416HyhGAn3K5XPiQFmv9I+DyX6Wu27DxFlF2ZpCX/pSBi6GOTEEIa007Hr1d46Qg1NRa3Xjq9NzQER5qv9aGS45oDC0yixs7HDcgGkxO19W77FV9EhbNcZGmxrBnNzAGMf8Ssy+7jdeeYoBKjYnU13cx0o0sryhmhB1BKh6ZFptGcJ8dv4+XpOY7FPif2KF23npt8XLduqU59n5FFWqhWtiGJDErSyvv7liNxgUz0OkfXxBogpIOeK9AirJ8M5fuW3DV6GlAKHFZn33Of/UKukNa2seZQdJDYze/iwBTmg9JsOgkXcTrYBNWcF9Zk9kIMXYFiL+cIIKrC3TvIchWQpu/tJ8+op1r9ZXqCuHqIlEdCEOsUiPWF3Hi5XYoK63xQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39850400004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38100700002)(478600001)(5660300002)(7416002)(31696002)(36756003)(86362001)(6486002)(2906002)(6666004)(4326008)(8676002)(2616005)(6512007)(8936002)(6506007)(53546011)(31686004)(316002)(6916009)(66476007)(66556008)(66946007)(54906003)(83380400001)(44832011)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGJ4VlNWNkhuWFlBc29GUFBuMmJ0bzBjT3gzVW1NVC80OThGR2Q3cXg2cElz?=
 =?utf-8?B?QWVjNEViUElibTNRMkcrSWo3cXFmKy9ZWHh0cFhpcm1IWDRtd2VET2xybWdF?=
 =?utf-8?B?cFpscm1wMHJFbGRRTlB4VjE3V1JWQUxXYjgzUTIwSzdJWWk5MHdGRWJ0K0ZH?=
 =?utf-8?B?a2k0T1k3VG4yb0o5aGxrZTRLaVZ3bDUzc0VYemlCRDRpTmpWYkNMalVQSXJo?=
 =?utf-8?B?WFJteS9WdnB0QWVISVFqNFQ3c25DODhZMVcvZDBOOTJIQUtxaUZTU3NnQ3RD?=
 =?utf-8?B?WUdpc21DWGtwWDlzK2lCQ2IrRjZ0WGlYZGFnWlJuMHk1Q0hsaE9pWnVGRHoy?=
 =?utf-8?B?YXZjMVBPMy9xWmNyWHNNRUVtL3J2OE5ieVBha0cwV3BwQmNqOVRhSGVKZmIw?=
 =?utf-8?B?QUlaZHFXdFlyekRKZ0hxM1hqaVd2Z1ppcExueWpCdjc2d2p2djl3dnV3QTgy?=
 =?utf-8?B?a0VKUC9yTjhsMHIxWTJDcUduYWx3aUNqS0NXREtlYnJMZTJ2VE9KSXpJbDNV?=
 =?utf-8?B?dEptcTdwS3g1ZFdEUWJqeVh4aFZtV2c2Yk4zYXhkNGdDL0k5OUxZM2d2UjN3?=
 =?utf-8?B?dG9oTnFZS015ZlJiZGJvSHk0YnNJUlp1Mi9JaWdSQUJTK0pRdlkxbWJNRklW?=
 =?utf-8?B?TWhtaGtSbm5lTHNpdmhhNy96aUVsNlZQQzVURlR0U2tFTnJ6MUFXd1ZkUDE3?=
 =?utf-8?B?V1Y1VGlCdFlKK0RoK0NDTlVCTFFGdlJhTGdHYWxScmU1ZHMzZFUxcGJQM3Ni?=
 =?utf-8?B?N0ZibmN2UVZ0NUZYZTdOS3VSUWRlZHFFUWpoZm9tSTIza09zck9JMGZqd01T?=
 =?utf-8?B?VnhFeERqS2FLTTN6OTlybGoxTm1PVHE2TzAzTFhvbEdXdC9odUJsWVBDZm1i?=
 =?utf-8?B?YjZoT1Azb2FNaDhPemJieG8rYll1Qk5SZVFLVWtsU2prWlRBZnBYdnhON3JI?=
 =?utf-8?B?a3VuY3hkRlRPVnpJL1krS09mZHd2anB5bzFpK0I3OHZBWFU4NC9ncEhVS212?=
 =?utf-8?B?bk9jUkthSGtSa05GdXFzMFlJUVFyVzdHUVBhMnVQaW9oYk5PWHpDbkwxL1NV?=
 =?utf-8?B?NVhrenhuMnpNdmZwNUhNN2gxQURNUlZ6cVJkcFVOU21mWDNiV0xxTzBZV095?=
 =?utf-8?B?eWZxS2lQOXJFdml1MG10LzlWdWlzOTVmVi9MN1FPd0h3Zlg5MTZDRjI4VGFM?=
 =?utf-8?B?RkxEaHprblFVdkhMR0FJalpoZDRNYm1OZjdoZHVCcDgyVGhMTlQ4bm1PZzdV?=
 =?utf-8?B?T0NLWXRVOVNLZnBwbU1CR1NhY0Q1UXBLc0gyR0RIOElUd1VYZVIzKzZ4ZFA0?=
 =?utf-8?B?WU8vMWlYRFNJVXpUWFg4dUd6aE04VlQreFh2ZzhRaENDSy9Gelg3eUdUNUh1?=
 =?utf-8?B?UDJvQ2ZpRkFOVTQ3K3FLeG1oVll4VmQ4bDMrc0VubStjUitrQkNJRDQ3RkhU?=
 =?utf-8?B?SE05eGYxWmNKdWorR21MdTN3Q1RsK0JoMm9XREZCZDZKWDZYQVlkNndmaWpF?=
 =?utf-8?B?dUxCMjA1NTQ4V3QxaTRtYmZUdjBKaGVHbyszSUJtKzVjbW5yKzBkWGEwRk1z?=
 =?utf-8?B?aXBDRzN5YWh6Y1ZnRHg4cUFDVE5PTjlvUFBLMTlWTGFQOTJMcnI2Qi9qbGN6?=
 =?utf-8?B?TElrU3VHOWczaEZRWWRIZ2MreUJYandJMkZQMDZOT3dib1E1U2NkK3BnK2w2?=
 =?utf-8?B?b1B1azI1TkxqNVhmaGxFZnhSWWdaNkFJZWxrMnd0RlpzV1hLZTNsTUlUc1Y1?=
 =?utf-8?B?RjRCM3RYMjVFRmhHNlpyb2dBQkpMRmpOWVcxd0dlYVNCN096MHVuYzBFMEJs?=
 =?utf-8?B?bzFwbFpZNUI5UVg5VjA1cGZIYVRVb1Zkd3p5cHNrU1hVU1YvZ3ZTNXNzVm9R?=
 =?utf-8?B?RENTSHgyTXAvVmNCMnRRMTd3dFJFR2ZaMnJvUlVheTNzazZZR2VHbDBGblo4?=
 =?utf-8?B?ZFExcEs5NDZkdi8xdllWamVqQUxIRTRMaVpMNU9hRURWVDFsRjJyQ0hUN0pi?=
 =?utf-8?B?QVN0alNHbTdKS3NvVnAzWGtNeXZPQml6T0dkMmJFY3JLTjhFUG8zU1FqS1Iw?=
 =?utf-8?B?OW1FRThqcUoyemVxQkwzVGo5ZHNJNFA3N3FHMUdqcVhGR3hPZEZKcTBndXR6?=
 =?utf-8?B?VXpBUjdpclVEdVJaMmt3NW5WUHdMd3ZIRDRzTlR0eUFnNjZrMHpST3R0RElx?=
 =?utf-8?B?dVRoRnhPYVNRSUhSNnlESlZGSmtnK2ZoWnh4SjlXa1RKbEUwbTdIRnM5dFcx?=
 =?utf-8?Q?PeoyP+3tmJvrMgFA7dD5/yDhChUVJl8I73fq/XTvEg=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6d3176-bccb-4fe5-098f-08dbec5a560a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 19:28:14.0176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yrjq/bgjU03yT1o/ttlB2anpywtPldOLT4dX7eXU9oGSFm1WAcaNcMoV0CaMW+SFljszgyn4GpabM5U2TBi+yzUFEhmPKMbXipwGO2dLKZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9422
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 23.11.23 20:04, Andrew Lunn wrote:
>> Setting the USE_PHY_WOL flag configures the PHY as expected (its driver
>> writes the MAC address and the interrupt configuration into the PHY
>> registers) and an interrupt is generated with every magic packet,
>> but only during normal operation i.e. there is no interrupt generation
>> in suspend-to-RAM.
> 
> Do you have a logic analyser connected? Can you see if the PHY is
> toggling its output pin? We then know if its a PHY problem, or a SoC
> problem.
> 
what I meant by no interrupt generation was not even physical interrupt
generation i.e. the signal does not toggle in suspend-to-RAM, but it
does during normal operation.
>> A (probably naive) wakeup-source property in the dt node does not help.
>> So now I am trying to find out why the PHY does not react in suspend and
>> why its interrupt is ignored in freeze mode, but I might be overlooking
>> some other important point to consider.
> 
> What is the clock setup? Sometimes the MAC gives a clock to the
> PHY. Sometimes the PHY gives a lock to the MAC. If its MAC->PHY, and
> this clock is getting turned off, that might cause a problem.
> 
>      Andrew
Thank you for your feedback, I will analyze the clocks carefully.

Primarily I would like to know if my approach makes sense in the first
place even if there is no clock dependency. Two dwmacs (realtek and
intel) make use of the USE_PHY_WOL flag, but I could not find any dts
where the mac-wol property is used to check if the MAC power source is
off in suspend.

Best regards,
Javier Carrasco
