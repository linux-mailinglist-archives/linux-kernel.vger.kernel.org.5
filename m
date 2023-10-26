Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20F37D7DBA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344370AbjJZHle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZHla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:41:30 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2117.outbound.protection.outlook.com [40.107.255.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AA8184;
        Thu, 26 Oct 2023 00:40:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7TiDdXZhtlPhjrupepUg8ip3BgKKfbBIKf9xSku9BGpXS1BTMs4jLgivqaqcvqmFbli76oMSClkuYBHOGUNCanf9tng9Svq0tZJThtbi/GUsh71KZ4CC1OgPGGRBAU2j/IGJZsKaWzUtrF6XczRTUhfnXmyopVyw8ObrpKh4u3jRXLS+4d2myYPYqhI1mAdXtK+mu6Pfk+c4QbPm9zwTkbTvmoYUKe7X1ZK4ZCa4GaVVf2jk7IMiS/53ccB+K/wxzVvN3RANwZAeMUNheikNDz6VphA9c4odj/8jM90xTvONFQ6pcRyrr5rMeE3R9X+YNSRvRg4K661m6qi9Jw12Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONKcJVsQyuwDUdhWZ/wOx8o7jFcwUCQstQnQNV393rU=;
 b=SV8zs+0dbDBBwHY3vjE7rRcfMi39oPQm3mbyB8wArNQEnvdZZymP+oyb1x+meBAiHlOlVUPWKvSSdPVhnqyezj6c7HqEqJ0PLXmBTLfTD32n3OwHd9EyWk8NyUMp7LuAIUc+6cVqS82zMbiBNahIJoXM+kUHEXDPyNQDfrygge+PpAhimAnmnw8qG/ytmvkrnZjzjpDB5J5lCgtSRt25RdRLxWhdedKoFRh+I/XRJVjTLCiVler+7uGnBr1Gvwdia8aTNaisg4JrXPW0RUy6geAT8KH5V1WMHAbxRwdS0fm9MzqZRqOKiAtAh5j3KESxgq7AGc+Qst+0bu4WbHGzcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONKcJVsQyuwDUdhWZ/wOx8o7jFcwUCQstQnQNV393rU=;
 b=PLkZjWL2HAWDS2VAh/i5r1v8oMV2K3pCek7HWjhalxvLbkBUKQn3Z8b5VN+e8sY0luZP2PjCoyP4EgmnxwBRcWopGeua2vaGmLo4+QmOjYacA6RDeLJlAYQniOzjPdHDCEQ/NuUy+Ksz8KBhc3zkIR/PJOyFHZ2HcPAEcr6k2yfMVj8qdxYEiF9zTh2JwVa9HLAykT4FaQaml6X/zG8orT9pXgbNvVPqiVxMaGrD0S92pCJ++0ArN9ZuU1sa0YnSYF+gfqhm20H5W9HInAymoNKcfKZ48hhbJdZu76vrT9HiGeYo1LlFsUGcgmSPiICcIM2a0dmELhx20ieFWyivMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB5939.apcprd03.prod.outlook.com (2603:1096:400:126::12)
 by KL1PR03MB7503.apcprd03.prod.outlook.com (2603:1096:820:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Thu, 26 Oct
 2023 07:40:36 +0000
Received: from TYZPR03MB5939.apcprd03.prod.outlook.com
 ([fe80::4011:f41:f71f:355c]) by TYZPR03MB5939.apcprd03.prod.outlook.com
 ([fe80::4011:f41:f71f:355c%5]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 07:40:36 +0000
Message-ID: <7c81e31f-3ece-4a95-80db-dfe7fcd4de0a@amlogic.com>
Date:   Thu, 26 Oct 2023 15:40:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: meson-gx: Remove setting of CMD_CFG_ERROR
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20230927072544.764285-1-Rong.Chen@amlogic.com>
 <202309271651027503622@amlogic.com>
 <1jil7wkl39.fsf@starbuckisacylon.baylibre.com>
From:   Rong Chen <Rong.Chen@amlogic.com>
In-Reply-To: <1jil7wkl39.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:404:42::13) To TYZPR03MB5939.apcprd03.prod.outlook.com
 (2603:1096:400:126::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB5939:EE_|KL1PR03MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 10cce0aa-cbe1-44dd-6d60-08dbd5f6d7fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oq9kPDgMcNhYHrJmMW7I0TXo0Sqq7mYNrl9trzmarj4c/CQs3lGGLGsyg/gXEhuA8v9aIeWe2MQjIm3pmfJM7ezHM3oBc9g7FYbbNiwfo4LKZcRyemBY0Ymh3VKaMb55sEK7pjnn2VPwcoaJ9pjuaEvQJG0+mck2/rnamCd/ECIvNwjXLad6l1yvxAH/DToQjR7f6uZ11a2MSs3FyYSR9KxTVAJkD3+djmLw0mspALjclX3Rnomveg4DMXlPh0IbX4BMyOLYaUzMznMRHU3bas7vpJIj4R1UejKj4P/W7YgF2TuxK2QruowHxmOdY6eZ/ItjfdmquVGgqCocRE/GilzgMN4dAhGwVVCdNZ6Uz5WZ/WW4dYoW/Poc5SFO/oPwkTUWxqYaY4bYyywjoyxb04/Kq38uFloDkCX0eLIEJEYcAQEAzcWCT4+mobzM2OCk23WHK/zTNnrPcJzAYQ7X+Xb0ep4LNA69qjCoutzkd+tcEOWMskmDVkFe48np7ZDnPOb3V5aBswWKejSdnM9yiJcW5HLaJKDbSW0iTSOeOE4qKn7giKMgtD6WAaJl78Br+r3vxckQUO4+jm4+HnXFHSi9IoAxN2m7hQnQC4XDZ/L/lOz6uwjgj7PS76bBusDYP+I7Wqwo9uZm/lgiZ9T5/7Tsn95clMf3ONu6RiwTsO00WvhytGsvJ8t2mLxX+Uzs21OFN/gnWPqiZBU63XjqLbWH06SGbATMVtFIz5fqOX0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5939.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(39850400004)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38350700005)(26005)(31686004)(38100700002)(2906002)(41300700001)(86362001)(31696002)(5660300002)(8676002)(36756003)(8936002)(4326008)(478600001)(2616005)(66556008)(6506007)(110136005)(6512007)(54906003)(316002)(66476007)(6666004)(66946007)(83380400001)(53546011)(52116002)(6486002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0RjV0dLUzdOYVZleHNPbWxZZk85anhVZjJCRXhSeEJ1bkttT3FucEZZTzFz?=
 =?utf-8?B?K0hTeXBhTWlJVTVRQkJHaWZmM2ZnSk9QL2ZjMG1FQ1NQcVFVV1NvS2Z2a1FZ?=
 =?utf-8?B?VUk4MmJIaVdRZUlBam1XRlZUNkh6YTlxTGVWcmdMMFQ2Z2JCRjRIY08rQXMr?=
 =?utf-8?B?ejJnZWlXSXpPeTFLN05SZjdmWi9wYnU1TytXNmtFRHdXQm1iUldqa2I4N1Er?=
 =?utf-8?B?bkdOZW9aU1BzK1M0Z2VmeFdzb2FxZmtwVDBlNnBzdk1rUGtiRGdVamNYL3VF?=
 =?utf-8?B?QVZFZ1dMbDdaQXJlS3BRaXFDRHRDWUVlWnZQNTBvb2p0eTFRSHFJOFVhMmJn?=
 =?utf-8?B?VU8vSHJyak9WekwxM1JrWnRjbm5lQ1pDMjJzQ1drV2hQZWdyeUZNTy8wWSsw?=
 =?utf-8?B?bWljSDQ0WWJBd0pZV2VDTEw0OEVnb1RUK21adVZaaDMrMWszcWg2Ymt0Z1ZV?=
 =?utf-8?B?YW4wWXVsS2l0QzF3TzluM3RqenVWTGFaTDI0THNPaWZYQ29kWVFWQytTNXdP?=
 =?utf-8?B?QVFMaW93d0xFb2owdUhMMWczN2pFZW5vcGx5b3lGMjFZS1VDM3BLN3ZUenNo?=
 =?utf-8?B?akV3NUtmdU9xRnNyb3krVmRZRjM1alhFYjNYR055SmdvMlZDMDlaZmhuck01?=
 =?utf-8?B?R1FPVG00aDcvN0s5bXgvMzZNUjY3c1pydW5pc0YzNmZnM2NRcWlXTDhtTTgr?=
 =?utf-8?B?OWNRVjdJM2hWRldVRndHWHdJajNCWFhGeTh0K2hBKysrY3dIdTB4OFVtc0pE?=
 =?utf-8?B?bzZpeTdaQnJrVUJBcW5kWUVtK1p0N3U0WGZZeWd0QnJJWWVuTXZRZ1B3Z2Jh?=
 =?utf-8?B?ZW9zMHBtOTNERVZFN2xMYkdtb0J5N255ZUlzaCthL1ljZkhhaG1nSy8zNUho?=
 =?utf-8?B?R1ZiSTVjOU9WS0xXUFVsRVZ1aEdVY1kwTnR4cTFSMC85MlNLOEt1TGlnL05G?=
 =?utf-8?B?b0Q4b1ZhUldodnlaTm1kTlc5Yk9sS1QyQWQ5dmhDaGVma0lsQ2xNaXRqNWRi?=
 =?utf-8?B?LzNjYXNpanZNOU1CSjhRd1BLTnlXNkVFSWJPS2VnNjBzaFo2T21adUFrcnNX?=
 =?utf-8?B?amRhMEdJcXVLZWxHOVZNajAvZUZISDBFd040L29TbDF2c2tzT3ExcGh2aTJq?=
 =?utf-8?B?R0lqQUVGRHpReE9Bc29aN3NEblF6OExLQ0pVL0laYno5Nm8wd1lZQkJTRWhX?=
 =?utf-8?B?N0Fjc21VU1JjWVFQbnEvWEIyUk42eHdxOXh4d3JLeUg5TU1aVzhlclV0bGgx?=
 =?utf-8?B?UXlwaUdpWlphcVhpVjFzaWpPZWlFSVp1Mko3d2ZFL3l2OFU4azJxVXNoWFp2?=
 =?utf-8?B?QUorT2Jxdm9WMk0wUVhPS0t1VHZwUGMxaWJLUjE4VXY5bVZmVXpIZytzSEJx?=
 =?utf-8?B?eEFVNTdIK2o2Nk9aSTZ6SnIwUDZsM2FZamR2SlcwYWNNbmxRR0E2S3RNclB3?=
 =?utf-8?B?alZudTIyWTVBdThmbUs4RGVHRGJwREZoS3FXUmlNUU1CMkRMTHZ6VGczaVIz?=
 =?utf-8?B?dUlZV2VvbDV0S1R4RjdlSnFqTDdZcDZsMEd5MnMzMjRZU0FmT1YxR0VSTGkw?=
 =?utf-8?B?T0ZHZDhORE9MT0hmN0NEZkxoeml0dWg4TzdoQkZaN3R2Nkl0RVZXd0diSVZ1?=
 =?utf-8?B?Qk16cDkzWjdYTnpOSXlMMmZvUEhTT1RzWmZ4OXBhQTF5T0Q0NHF5MWViOG15?=
 =?utf-8?B?bjZ4S0gxVGx5dnZGTzNxRFdDR1NTbGhRTnRhNmkvbVdIVGJIUldjNWE5SEo0?=
 =?utf-8?B?THY1Y2dvNVJLUzFjVHNyOFErTVVXdHVqTnhJOC95YUdSWUQxdUtKRnlXamlM?=
 =?utf-8?B?a2ZlWFFaeGV0aEttOUc0VUlNUFd0WUZsVFBqTmdyaHJ5L1loYmpnaHY4Ykh6?=
 =?utf-8?B?VThYdmNVQzdQVEswa28yQ0dXdldzQUd3TG50bDhmQnNOak5IdmlZam1sdDBu?=
 =?utf-8?B?dUt3U0xtZEV4UWFMSmZGSlA3dnRqb2lReW01dWU2YXVRYmJtYk9XcFRJaEZp?=
 =?utf-8?B?b2ZMTEJpSHpBNVR1UmtHQ2VDeEJuR05iSmJ6bVBwak51RGQzNEJKMjZFTEpk?=
 =?utf-8?B?b0M2K1QzS3Zna0s3UUVpam9uZk0wVDR4dkhQV1ZKbnBpcTF0c0JHL0JiVmpX?=
 =?utf-8?Q?sucqJj40TUcZasRLzsBOMFTlH?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10cce0aa-cbe1-44dd-6d60-08dbd5f6d7fb
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5939.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 07:40:36.6868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhFNyW2fLvzPpdTMbVtXypJNz6stMWSWXSbkRzUQrNk9wqjZLIbrH/zcUEZIwjdgFKJ/AdUecZWsMoOlcdPJJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7503
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

I tested on meson-g12a-u200 and meson-sm1-sei610 board successfully.

*meson-g12a-u200:*

[ 1.308436] mmc1: new HS200 MMC card at address 0001 [ 1.309223] 
mmcblk1: mmc1:0001 AJTD4R 14.6 GiB [ 1.314724] mmcblk1: p1 p2 p3 p4 p5 
p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 [ 1.321724] mmcblk1boot0: 
mmc1:0001 AJTD4R 4.00 MiB [ 1.325727] mmcblk1boot1: mmc1:0001 AJTD4R 
4.00 MiB [ 1.330427] mmcblk1rpmb: mmc1:0001 AJTD4R 4.00 MiB, chardev 
(511:0) [ 11.368251] platform cpufreq-dt: deferred probe pending [ 
29.695649] mmc0: new high speed SDHC card at address 0007 [ 29.696402] 
mmcblk0: mmc0:0007 SD16G 14.5 GiB [ 29.708053] mmcblk0: p1 [ 48.132967] 
mmc0: card 0007 removed

*meson-sm1-sei610:*

[ 1.815416] mmc1: new HS200 MMC card at address 0001 iled:[ 1.819542] 
mmcblk1: mmc1:0001 016G30 14.7 GiB No such file or d[ 1.826207] 
mmcblk1boot0: mmc1:0001 016G30 4.00 MiB [ 1.831692] mmcblk1boot1: 
mmc1:0001 016G30 4.00 MiB [ 1.836250] mmcblk1rpmb: mmc1:0001 016G30 4.00 
MiB, chardev (511:0)

[ 5.857437] mmc0: new high speed SDHC card at address 0007

[ 5.858046] mmcblk0: mmc0:0007 SD16G 14.5 GiB [ 5.869727] mmcblk0: p1

[ 9.958449] mmc0: card 0007 removed


在 2023/9/27 17:30, Jerome Brunet 写道:
> [ EXTERNAL EMAIL ]
>
> On Wed 27 Sep 2023 at 16:51, "Rong.Chen@amlogic.com" <Rong.Chen@amlogic.com> wrote:
>
>> Hi Jerome,
>>
>> Socs containing previous controllers are gxl, gxm, gxbb，g12b，g12a，sm1，axg, a1，s4 and t7.
> That is mostly all the SoC we know of in mainline ... This why the way
> you explained is confusing.
>
> And below, you say 'on latest controllers', okay but which ones ?
>
>> The bit CMD_CFG_ERROR is used for selecting SG LINK of data address on latest controllers，but
>> data address don't use SG LINK at present，so it will cause an IRQ and stop working on latest controllers.
>> Therefore, remove this setting.
> Not totally sure what SG LINK but okay.
>
> While the change itself is fine you really need reformulate the description.
> Based on your explanation, something like:
> ---
> For the t7 and older SoC families, the CMD_CFG_ERROR has no effect.
> Starting from SoC family XYZ, it will select SG LINK on error but this
> is causing a problem with the data address ... blablabla
> ---
>
> Please expand a bit on this, try to make it clearer.
> Also, please insert the proper fixes tag
>
> Last, make sure tp reply with plain text emails, otherwise lists will
> drop your reply and please do not top post.
>
> Thx
>
>> Thanks.
>> -------------------------------------------------------------------------------------------------------------------------
>> Rong.Chen@amlogic.com
>>
>>
>>   From: Jerome Brunet
>>   Date: 2023-09-27 15:43
>>   To: Rong.Chen; Ulf Hansson; Neil Armstrong; Kevin Hilman; Martin Blumenstingl
>>   CC: linux-mmc; linux-arm-kernel; linux-amlogic; linux-kernel
>>   Subject: Re: [PATCH] mmc: meson-gx: Remove setting of CMD_CFG_ERROR
>>   [You don't often get email from jbrunet@baylibre.com. Learn why this is important at
>>   https://aka.ms/LearnAboutSenderIdentification ]
>>
>>   [ EXTERNAL EMAIL ]
>>
>>   s
>>   On Wed 27 Sep 2023 at 15:25, "Rong.Chen" <Rong.Chen@amlogic.com> wrote:
>>
>>   > From: Rong Chen <rong.chen@amlogic.com>
>>   >
>>   > Setting bit CMD_CFG_ERROR has non effects on previous controllers.
>>
>>   Which previous controllers ? v2, v3 ? Can you list the SoCs please ?
>>
>>   > However, it will cause an IRQ and stop working on latest controllers,
>>
>>   Isn't it desirable to stop on error ? seems like a sane thing to do.
>>
>>   > This bit is used for selecting SG LINK of data address.
>>   > Don't set the bit CMD_CFG_ERROR anymore to resolve this issuse.
>>
>>   I'm not sure I understand the actual issue being resolved.
>>   Could you provide more details please ?
>>
>>   >
>>   > Therefore, remove this setting.
>>   >
>>   > Signed-off-by: Rong Chen <rong.chen@amlogic.com>
>>   > ---
>>   >  drivers/mmc/host/meson-gx-mmc.c | 1 -
>>   >  1 file changed, 1 deletion(-)
>>   >
>>   > diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>>   > index 9837dab096e6..c7c067b9415a 100644
>>   > --- a/drivers/mmc/host/meson-gx-mmc.c
>>   > +++ b/drivers/mmc/host/meson-gx-mmc.c
>>   > @@ -801,7 +801,6 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>>   >
>>   >       cmd_cfg |= FIELD_PREP(CMD_CFG_CMD_INDEX_MASK, cmd->opcode);
>>   >       cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
>>   > -     cmd_cfg |= CMD_CFG_ERROR; /* stop in case of error */
>>   >
>>   >       meson_mmc_set_response_bits(cmd, &cmd_cfg);
