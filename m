Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410267D3771
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjJWNHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjJWNHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:07:50 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A01101;
        Mon, 23 Oct 2023 06:07:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pke+1cUn2dQ+MbpFTNClxUnVO8GLdRYqylRKI477oDrQ8rWek9AwhsLMRpU67tBjurHFblQyMtUPOXGGhZWawAJfZBbe46vEpNyQNbHiO5iFnFnuEpAGk6Iie0yG/GZVa2i42qusK3OQjrLT7a0sHXY/47f08A6OW1eolKX5eTksZ6rhwza0piQ1G94zOpCc5KXO76UGDrTC0HLNTBWFkM5M9hhzM25SXKuF/vMhOeDNDkSi2TbVLNQnH4lBXf4z06lKFCCq3SZRxc5A7zkVSOrG8Gbpm5/4oek4JshkgIeskdL09JCB41YcMLr5ZPeTgxvlLKs/20vGxVMVLqymGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtuidR1v24Sz4xUF87ZgFgHlwKt1jIDABNvQTRvCWkA=;
 b=BMAH4c8bvJm/Ri/h5wJDFLIpWNMNQX46Grg8DSHOYtzLwukYNfkRgZTpBK5gzE8qEn9NpMZZBMxtcW3aVF13qls4XqE4Z32AaicXFHG73j1cN4L2g/hl+N30Rda5IsrO7YCmSurHeHxYWkNhmSDm1nc9o5bxkG5719S9SaP32JTePW0DMShitg95BLkwrmEEc37QoURKANYo4a85GyKbg+7+U+4st05LPAR6t20nHeZLTA74UjgCQ2VxIW84h0jGOxQ/pRmr8TO9Dd8wQ8pvnM/HCGqKINTF93t+Tco+0UsRmuQbRbBvPJ7TCggmw3bmGES/aGpk4JJkeVvb3u4I4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtuidR1v24Sz4xUF87ZgFgHlwKt1jIDABNvQTRvCWkA=;
 b=EvSc6MUwmpntwwJdY9LknaHXXy5G0XJwPL7Zkl0l2xzKRnPITdywfsghdRTUtkGtNiRpQs8qxEhJfJrC+2r4r9Rz30yez9DuuHL0YveCrofZ04l00NDYfCutRwCZwF4XbXqgbRUhFKF7NieC5+B4DXJisNL8i5XYFcPAnERuKXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AM8PR08MB6516.eurprd08.prod.outlook.com (2603:10a6:20b:363::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 13:07:43 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::1d06:cca0:f1ef:ff62]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::1d06:cca0:f1ef:ff62%4]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 13:07:43 +0000
Message-ID: <11cccad3-e665-41dc-89c2-5ddc22b1e2fe@wolfvision.net>
Date:   Mon, 23 Oct 2023 15:07:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/3] media: rockchip: Add a driver for Rockchip's
 camera interface
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, ezequiel@vanguardiasur.com.ar,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com
References: <cover.1697446303.git.mehdi.djait@bootlin.com>
 <ZTFMR7PlcQXpeoQO@aptenodytes>
Content-Language: en-US
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <ZTFMR7PlcQXpeoQO@aptenodytes>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0096.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::11) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AM8PR08MB6516:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb1cd5e-94f1-4686-ce93-08dbd3c90ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kfvC9EC+jhKJd3f3bm1Ug+id++h5aFQF34mro3414670sWMJkNOqKf+jaoJPI9c0SQqUdftahys93KS7JKHt3P7H8usUbzWrDzV+TVjHvSsr8169WhFBroDCDHX0tD/QazrkBymdOVeVNC2bTMNkCTTMIii3nt3vLF1yLqNYOXRci718EWpfDfh3803zxUcL+oLUpI2RU6J3rOb/nuMLE5MMJ0nXPjD3O8K8GErwoChTCs5IXXPyYxz9xdASXYBWB/CCxg22eP2lP0UlH9B8BD2qXxTkaBiKm7TADSn3cH616qMXGN+Uiup0dopxeuS4FYsH5oLnlVD7MHuN8seWMWfTDyUty45b1EoBGl88Gq4XWMZwUbt2V1R6+lE7L7Vs8rSx1zjneLw05xsupU2jRGVgBWCTPIUxw+jjhrl+mCT+H7snKruGmTOc/hObL/TXXP/TUSUp9y2uOd/i/b0gtxMxI+wunrsGvnh3KO8Y7RQ1J7sYjm11NjrCuVjr8+ESeENWyyej6eXHSKKYgci73UkxImj0rvO4Ln2m7GSI/LiqvkX9wCWZAu0dPM48ly/IxV8Pw1UmErLFUm/tteZhGU8hFH6I+7E5KObeqmkSc+STj4GFXD+Gj8ux+0P0B9DsoFVU3YMENWSG2DXSdqYZZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39840400004)(396003)(376002)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(30864003)(2906002)(38100700002)(316002)(66556008)(66476007)(66946007)(6506007)(2616005)(110136005)(478600001)(53546011)(6512007)(966005)(6486002)(83380400001)(41300700001)(44832011)(7416002)(36756003)(31696002)(86362001)(5660300002)(4326008)(8936002)(8676002)(31686004)(66899024)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0o4cldEUTdNcndPeWpiUjJZMmlSUkljOTVTaFdmV0xDUDNNR3c4UnVrVmNn?=
 =?utf-8?B?dlBXZkdPMVVQb21TcjVTemoybFVCUHFSa1hoR01tY1ZIbzhzMkF0Wk4ramRK?=
 =?utf-8?B?cWgvRjQ4T1JzV1dOZTVteEZtd1c5TkxOZmgyeWlKcVRxbFpTd0ZzMEt2OFlr?=
 =?utf-8?B?b1FJdEVBREsramNac3pVNGdmQjBtS2NNb3FzWnNaSjV4bWt2SGJ3UlVTd3hG?=
 =?utf-8?B?WkFRbktNcHZHdDE5aDA4eXJZWndOd3ZtVExka3lIaFNsdFEwd2xyQytRM3lS?=
 =?utf-8?B?UDNUcCtqR3VTRE8yOXVOcGFQMFJ0SzBxQ3g3VzI2b01PTjlRZHhwWWQxMnU4?=
 =?utf-8?B?Wkd5MVhkdXRlTjZZWHZWWm51N3FVdzNocXQ3YVZEOCsvZlBYZVdZMEhCVGRM?=
 =?utf-8?B?aURuck9rSEx4YWltRHpmNEx4L3hidFVLNFR6VkV0VjRpdGw1MndjZXRJaFli?=
 =?utf-8?B?VVdveFRzMU1uYi9MNzZDallYQklQblhZak8rSW8vWTNiVG9nR011ZW1MdHNI?=
 =?utf-8?B?QXBJT3BobE9tbGl4TXc4TnZvZkpYWUFyZXUyYzJXV2Fidk5XMzg0WnVSeXBu?=
 =?utf-8?B?VEgrdEllZlM4T3pxZG5ybUpkc1pXSUxWY2tScjVRTEY2UStIaGFvOTZXeGVC?=
 =?utf-8?B?U1RsLytVeXkzdUVjaHhrdlVOYjRVZVF5bFhQRm5Eb3dUcC9yN01NU1dxRG52?=
 =?utf-8?B?QzBUWUkvbHorZFFYZDJPR2prMmk2cktZVXJ2Z1U4ZGxVVC95ajlrblpqZzE4?=
 =?utf-8?B?RC8rL0JLTmxmMTJ3SHFuTUFYSmdzWlpWQk9Pa2ozTVkveGpiTDNOL3I0RkNt?=
 =?utf-8?B?Z2VTQzJUZGo2Vmp6cGZlcyt4WU9sdVlBdDI2M202MnEvNVVZdmpQNGxUR1BQ?=
 =?utf-8?B?d1gvOU5mVFhIZWFQTVVrRWtXZU1pdDNzVkcvSFlVWG1QQWJkQVluS3VDWkVx?=
 =?utf-8?B?L3BrS1FUVXlYbFp2VU02c0wzdmJoQlJ3RzZiQkhtVFFVUm9saHM2ZHJyWUZk?=
 =?utf-8?B?aWVBQnRJNDVwRGlLbFlHTXlFbnFBUFZLWCtlNlBUSytuczBMY3dwNHh1M3Fu?=
 =?utf-8?B?eTVNLzFjYmNoNmNmdGNNYWxPTnhSZXJ6L05hU1dvTkR3TERoSG5PT1l4c1ZJ?=
 =?utf-8?B?REpqVW5pTk1vZmxEMTBLbE5pNjRpK3dKZU40Z2FPc3p2Y1V3WDQrNnIzM2xE?=
 =?utf-8?B?UGVPbHhFaUh0d1huRlZHN3VWNEhwQUFJdW92ZHpkZTkxVGdZOWlUdFNlNDZV?=
 =?utf-8?B?RnJYSTFFcStzQW4xV21PMHZPUUtBc3NHYjh2U3RPSHVMcmdqUTVNVFdaUUNX?=
 =?utf-8?B?dzZvWGxWUy8vUXFUa0s0VitEdWhObnNVSGZ6aEwzQ3BxY0llelhzN2hPcXZr?=
 =?utf-8?B?V2xnNHY5WGdwbWs5SVpIZmJrQmxXOXZ6a1VNSkNBWkVNNXFETEJ0Nnh4Ty9Z?=
 =?utf-8?B?TjFJVDFUNDVnY2JVWWhpQUYxL21acDRJQWNOUVZIc0lKODNSOW5adkFUNStO?=
 =?utf-8?B?VEM5UENraXpwSlRGeGNzSHR1bDBkb0V3ZkU1SkYzTGVHN1IzOG9rNlJmYkJP?=
 =?utf-8?B?Nkw3RDludEFFa2lCTFFJc0dGbEVSajV0a1Irc2tvODdja3pDa3FCMjcvcUJh?=
 =?utf-8?B?M3lpS3JzbDR5Qm91Zkl6cjdQcm5KV3dmM1ZwMGFVNXhvTURVODNwVi8xV0xp?=
 =?utf-8?B?bmttQVY0RG14YXhDSnhsUTlWenNYZmtUcGdtOEFjUC9yeHFKa1ZqYW9aV044?=
 =?utf-8?B?cHBkSDU3MUN2R1BmSWp1L21NZUFheDNCT05Xb3NmZmsxWjhLQWRINzBZQjFk?=
 =?utf-8?B?aDNXVEVKbkJOMHdTczN1SnNQdFhsdlpwQ042azQ3TlBXeHlrR1NRSEEwSjNF?=
 =?utf-8?B?VFgxYzZuRUMwajlDK0p6cXFNSFlKRlJ1KzJxMWhQQXZRa3YxVzhSWGhyL0Q4?=
 =?utf-8?B?dDdxMTJxYmJ5eEVPQkdRUURBUStIQk9LZ0NLVzBDb1pTOFhPV1VRelBYa0RO?=
 =?utf-8?B?QUtxeURpdW84MWF1RmNDV29HQkczMlpOZHlxUWNWL0xIL2VmRnhZKzd3MGVi?=
 =?utf-8?B?TWVEd0FESUtkSGd5djBhVHdsYTMzaXJxKzYram1wU0NTR1FoNHhXdUxORUdR?=
 =?utf-8?B?cHc4TFhRYWdKS1cxaWxXRjJDNVRXbWZGWEc2ZXpSZnNEUDFOQlpESkJWZ2tt?=
 =?utf-8?B?akRUYXFKa0M3dzg0dGNFdHFUWnRWYThuMy9EQ1Q0TzdVNHA4Tmd5a0FQNC9K?=
 =?utf-8?B?Rm9PYTJpWjZyYmpkbDI3emF6VnNnPT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb1cd5e-94f1-4686-ce93-08dbd3c90ad4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 13:07:43.0113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1URekM30l13D8jfnGTa8h2F3H46zjmOH4EPVQOYDbrqO/FWr/A+5aJUKPD+DC/Ala8ue0TeLnkq+qhKtO6oNRjPjgoCnNkwtDfgwB0lthvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6516
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URI_HEX
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehdi and Paul,

Let me begin by saying how great it is to see this series moving
forward. After nearly three years of silence I was not expecting that
:-) Thanks for your efforts!

On 10/19/23 17:33, Paul Kocialkowski wrote:
> Hi Mehdi,
> 
> On Mon 16 Oct 23, 11:00, Mehdi Djait wrote:
>> In the BSP, this driver is known as the "cif" driver, but this was
>> renamed to "vip" to better fit the controller denomination in the
>> datasheet.
> 
> So I have spent a bit of time trying to figure out the history of this unit
> and in which platform in was used. The takeaway is that the earliest Rockchip
> SoC that uses it is the RK3066 (2012) and the latest SoC is the RK3566/RK3568
> (2020). Earlier SoCs (RK29) do mention VIP but seems quite clear that this is
> a whole different unit and the recent RK3588 (2021) has a new VICAP_DVP unit
> (mixed with VICAP_MIPI) which also seems significantly different.

The RK3588 VICAP may be significantly more complex, but it is supported
by the same driver in the downstream kernel [0]. The DVP part (which is
in the scope of this series) should be more or less the same deal
(although Rockchip mixed the register positions once again, the
registers itself are similar to e.g., RK356X when it comes to DVP).

> Over the course of the existence of this unit, it is most often referred to
> as CIF. Since this is also the name for the driver in the Rockchip tree,
> I feel like it is best to use CIF as the mainline terminology instead of VIP.
> Note that the unit is also called VICAP in RK3566/RK3568.

But even if we take the RK3588 VICAP unit into account, I'd agree that
CIF seems to be the better name (precisly because the downstream driver
is called "cif").

The individual compatibles can be named "rockchip,px30-vip",
"rockchip,rk3568-vicap", ..., right? This would be in contrast to the
downstream driver (which uses "-cif" for all units) but here the
alignment with the respective data sheet comes into play (which will be
helpful).

> Here is the detail of my research on the concerned chips. The + at the beginning
> of the line indicate support in Rockchip's 4.4 tree:
> 
> - RK3566/RK3568 (2020): CIF pins + VICAP terminology
> + RK1808 (2019): CIF pins + VIP registers + VIP_MIPI registers
> + PX30 (2017): VIP pins + VIP registers
> + RK3328 (2017): CIF pins + VIP terminology
> - RK3326 (2017): CIF pins + VIP terminology
> - RK3399 (2016): CIF pins
> - RK3368 (2015): CIF pins
> - PX2 (2014-11): CIF pins + CIF registers
> + RK3126/RK3128 (2014-10): CIF pins + registers
> + RK3288 (2014-05): CIF pins + VIP terminology
> - RK3026 (2013): CIF pins + CIF registers
> - RK3168/RK3188/PX3 (2012): CIF pins + CIF registers
> - RK3066 (2012): CIF pins + CIF registers
> 
> Note that there are a few variations over time (added/removed registers), but
> the offsets of crucial registers are always the same, so we can safely
> assume this is the same unit in different generations.
> 
> Since the RK3066 is the first model starting the RK30 lineup I think we can
> safely use that for the "base" compatible to be used for e.g. the bindings
> document, instead of px30 which is just one of the many SoCs that use this unit.

Once the name of the driver is defined and adjusted in v9, I can try to
give the series a shot on my RK3568 board. First attempts to do so
basing on Maxime's v5 showed that with a few modifications the DVP
feature works fine. In a subsequent step, we could discuss the inclusion
of the MIPI CSI-2 things in order to keep the driver sufficiently general.

@Mehdi: If you could Cc: me when you send out v9 it'd be much appreciated.

Best regards,
Michael

[0]
https://github.com/rockchip-linux/kernel/blob/develop-5.10/drivers/media/platform/rockchip/cif/hw.c#L968

> 
>> This version of the driver supports ONLY the parallel interface BT656
>> and was tested/implemented using an SDTV video decoder
>>
>> media_tree, base-commit: 2c1bae27df787c9535e48cc27bbd11c3c3e0a235
>>
>> V7 => V8:
>> vip/capture.c:
>> - fixed a warning: unused variable reported by the kernel test robot
>>
>> V6 => V7:
>> vip/capture.c vip/dev.c vip/dev.h
>> - renamed all struct rk_vip_dev dev => struct rk_vip_dev vip_dev
>> - added some error when rk_vip_get_buffer() returns NULL
>> - removed a WARN_ON
>> - made the irq NOT shared
>> - dropped of_match_ptr
>> - added the rk_vip_get_resource() function
>>
>> rockchip,px30-vip.yaml:
>> - changed filename to match the compatible
>> - dropped the mention of the other rockchip SoC in the dt-binding
>>   description and added a more detailed description of VIP
>> - removed unused labels in the example
>>
>>
>> V5 [1] => V6:
>> vip/capture.c vip/dev.c vip/dev.h
>> - added a video g_input_status subdev call, V4L2_IN_CAP_STD and the
>>   supported stds in rk_vip_enum_input callback
>> - added rk_vip_g_std, rk_vip_s_std and rk_vip_querystd callbacks
>> - added the supported video_device->tvnorms
>> - s_std will now update the format as this depends on the standard
>>   NTSC/PAL (as suggested by Hans in [1])
>> - removed STD_ATSC
>> - moved the colorimetry information to come from the subdev
>> - removed the core s_power subdev calls
>> - dropped cropping in rk_vip_stream struct
>>
>> rockchip-vip.yaml:
>> - fixed a mistake in the name of third clock plckin -> plck
>> - changed the reg maxItems 2 -> 1
>>
>> [1] https://lore.kernel.org/linux-media/20201229161724.511102-1-maxime.chevallier@bootlin.com/
>>
>> I used v4l-utils with HEAD: commit 1ee258e5bb91a12df378e19eb255c5219d6bc36b
>>
>> # v4l2-compliance 
>> v4l2-compliance 1.25.0, 64 bits, 64-bit time_t
>>
>> Compliance test for rk_vip device /dev/video0:
>>
>> Driver Info:
>>         Driver name      : rk_vip
>>         Card type        : rk_vip
>>         Bus info         : platform:ff490000.vip
>>         Driver version   : 6.6.0
>>         Capabilities     : 0x84201000
>>                 Video Capture Multiplanar
>>                 Streaming
>>                 Extended Pix Format
>>                 Device Capabilities
>>         Device Caps      : 0x04201000
>>                 Video Capture Multiplanar
>>                 Streaming
>>                 Extended Pix Format
>> Media Driver Info:
>>         Driver name      : rk_vip
>>         Model            : rk_vip
>>         Serial           : 
>>         Bus info         : platform:ff490000.vip
>>         Media version    : 6.6.0
>>         Hardware revision: 0x00000000 (0)
>>         Driver version   : 6.6.0
>> Interface Info:
>>         ID               : 0x03000002
>>         Type             : V4L Video
>> Entity Info:
>>         ID               : 0x00000001 (1)
>>         Name             : video_rkvip
>>         Function         : V4L2 I/O
>>         Pad 0x01000004   : 0: Sink
>>           Link 0x02000009: from remote pad 0x1000006 of entity 'tw9900 2-0044' (Digital Video Decoder): Data, Enabled
>>
>> Required ioctls:
>>         test MC information (see 'Media Driver Info' above): OK
>>         test VIDIOC_QUERYCAP: OK
>>         test invalid ioctls: OK
>>
>> Allow for multiple opens:
>>         test second /dev/video0 open: OK
>>         test VIDIOC_QUERYCAP: OK
>>         test VIDIOC_G/S_PRIORITY: OK
>>         test for unlimited opens: OK
>>
>> Debug ioctls:
>>         test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
>>         test VIDIOC_LOG_STATUS: OK (Not Supported)
>>
>> Input ioctls:
>>         test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
>>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>>         test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
>>         test VIDIOC_ENUMAUDIO: OK (Not Supported)
>>         test VIDIOC_G/S/ENUMINPUT: OK
>>         test VIDIOC_G/S_AUDIO: OK (Not Supported)
>>         Inputs: 1 Audio Inputs: 0 Tuners: 0
>>
>> Output ioctls:
>>         test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>>         test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>>         test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>>         test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>>         Outputs: 0 Audio Outputs: 0 Modulators: 0
>>
>> Input/Output configuration ioctls:
>>         test VIDIOC_ENUM/G/S/QUERY_STD: OK
>>         test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
>>         test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>>         test VIDIOC_G/S_EDID: OK (Not Supported)
>>
>> Control ioctls (Input 0):
>>         test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
>>         test VIDIOC_QUERYCTRL: OK (Not Supported)
>>         test VIDIOC_G/S_CTRL: OK (Not Supported)
>>         test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
>>         test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
>>         test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>>         Standard Controls: 0 Private Controls: 0
>>
>> Format ioctls (Input 0):
>>         test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
>>         test VIDIOC_G/S_PARM: OK (Not Supported)
>>         test VIDIOC_G_FBUF: OK (Not Supported)
>>         test VIDIOC_G_FMT: OK
>>         test VIDIOC_TRY_FMT: OK
>>         test VIDIOC_S_FMT: OK
>>         test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
>>         test Cropping: OK (Not Supported)
>>         test Composing: OK (Not Supported)
>>         test Scaling: OK (Not Supported)
>>
>> Codec ioctls (Input 0):
>>         test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
>>         test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>>         test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
>>
>> Buffer ioctls (Input 0):
>>         test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>>         test VIDIOC_EXPBUF: OK
>>         test Requests: OK (Not Supported)
>>
>> Total for rk_vip device /dev/video0: 46, Succeeded: 46, Failed: 0, Warnings: 0
>>
>> Mehdi Djait (3):
>>   media: dt-bindings: media: add bindings for Rockchip VIP
>>   media: rockchip: Add a driver for Rockhip's camera interface
>>   arm64: dts: rockchip: Add the camera interface
>>
>>  .../bindings/media/rockchip,px30-vip.yaml     |   93 ++
>>  arch/arm64/boot/dts/rockchip/px30.dtsi        |   12 +
>>  drivers/media/platform/rockchip/Kconfig       |    1 +
>>  drivers/media/platform/rockchip/Makefile      |    1 +
>>  drivers/media/platform/rockchip/vip/Kconfig   |   14 +
>>  drivers/media/platform/rockchip/vip/Makefile  |    3 +
>>  drivers/media/platform/rockchip/vip/capture.c | 1210 +++++++++++++++++
>>  drivers/media/platform/rockchip/vip/dev.c     |  346 +++++
>>  drivers/media/platform/rockchip/vip/dev.h     |  163 +++
>>  drivers/media/platform/rockchip/vip/regs.h    |  260 ++++
>>  10 files changed, 2103 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
>>  create mode 100644 drivers/media/platform/rockchip/vip/Kconfig
>>  create mode 100644 drivers/media/platform/rockchip/vip/Makefile
>>  create mode 100644 drivers/media/platform/rockchip/vip/capture.c
>>  create mode 100644 drivers/media/platform/rockchip/vip/dev.c
>>  create mode 100644 drivers/media/platform/rockchip/vip/dev.h
>>  create mode 100644 drivers/media/platform/rockchip/vip/regs.h
>>
>> -- 
>> 2.41.0
>>
> 
