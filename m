Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7840879CA8B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjILIto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjILItm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:49:42 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C46AA;
        Tue, 12 Sep 2023 01:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8uKl+gQ29mYD5n6gfntMI5DjSU1Ecj1KLCEjj9AoqyWkWbB5vK97ssQs5+ryoYbxgSMzDHaVRcJmxaLEZvW85MfPuzYOBdrKEM7knbIrdRSmQzuEw7BGxFQ2k2ydVV4ALac2132LJ5Sabpk4+jdQIdOq2xLFaPeiseY3q4gp69usk+kHqWo3UV8MvwySFij1BUWmfOxQI1qvejpctziKL177ut4ZpTxpmlzPkF2TeuN/yXI0oBGlJHyuNWVj0k7tecsifssWM0i741vc1X4jlsrnK9BJf9JSQIzEhN/W/RFAu5YRLfKIme9wgWpWL0mWiDXE03Q6UY/fZuupP6Ung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5aI8DyqDpUxvL859MjnbnH6pedUMrOFdDrb6hsj0AU=;
 b=DUnRG591/B9FiS2BCERlbzbBEbN1UbsroL7lfO3ID1kKyV5cJ1k6zRdPTvCXZh3FKhTZfLSnX9vpnrxX/SuZXsYiyHQU+5e+VPzF/wHOoKfsSve+1PsfKJqekkXTfMkNj6sU8XA+TITlDpdAOs4df6Jiz6oE1ljPiuidoquk2CXQZvsqLAAmOWrtLO0Snzmew4O5ousdFQ8FQpxNbVSUqRfzn3wLe7mR9RdjPq6ZYbSWKxZzKKHME5gDHq9xNiWrcstpB++iIiun7h2+J8Hfci+ODOGTek1Fg7JV2mhSiUr/i8CQM6+DYh6IQ0Fmpmda9vFhlbBOCPeAWN6F3GFNyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5aI8DyqDpUxvL859MjnbnH6pedUMrOFdDrb6hsj0AU=;
 b=dPV2PT7e5GLpDNv+o8rjRiISF0pfzTZ+yJdZelkm+i92De2ZoOdrE3SwvKjoGr7WHN+56TWKs+wEg30EkmuD6RH58KNkOiVvhKUagYYMRPiJV3bhBkOZ6kDKQDuAyIUcBa6dR5Q60osjt0P2gr5q9KiWbvvWtzoH99pdoFyhvz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by DBAPR04MB7240.eurprd04.prod.outlook.com (2603:10a6:10:1af::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 08:49:35 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7%7]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 08:49:35 +0000
Message-ID: <fe47a94e-6788-a5ee-e8ee-ca58e4fa62d6@nxp.com>
Date:   Tue, 12 Sep 2023 11:49:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] arm64: dts: imx8mp: add reserve-memory nodes for DSP
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
References: <20230911224452.15739-1-iuliana.prodan@oss.nxp.com>
 <20230911224452.15739-3-iuliana.prodan@oss.nxp.com>
 <67de5706-d966-dd71-85c3-c95bc1b72733@linaro.org>
 <c0b32f41-46b4-81ad-9718-5f0856e42cb1@nxp.com>
 <32287c0a-e3c1-e474-3c90-913fe2c79879@linaro.org>
Content-Language: en-US
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <32287c0a-e3c1-e474-3c90-913fe2c79879@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0011.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::13) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|DBAPR04MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: f6bd1672-3c25-4ce4-2dec-08dbb36d3063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RFSsUoCVJWWCP5BimbzLn151ahe67FG6wP8cT3XPK3U0FRo1Kus6t0opj6D7674brXUiYLnpM4H8iADCMl2RkvZMb5mpySir3lg5ecun1ieG6/OKcBqcYOpjxe64tA/9nQZwK6UUWkztAbfpGZE5CmE2gOUHEawfJdqoetT/cO+Siae/KnIuEIk3fy1WBQ1T9DdlaqJzxE1oVjdlMqJJ3QHCAxrFJjdkvb8W+sOXoHttzXS1GJmUOaxHmJekITkG2jEGCeqFFk3pRiFKbFYl6bK5iiZrKCDwBGEcWl6pgPJsp4cK0obVyR8LDAMOn5335Cxiioa9usCEIbr8mlamvy7Aka2vGDMIWjRUTfdrb+YvmfDMZkpFCxzTQP0+XF1XkN/No8knZ4nVmTUThdbSvMefqKB5x/26QwbZFrnx3y93LaD+a3XapJgBTbgmVS39KpnsTypY9XLYfRapf/2GedF6GtwB2D9rdObQz2cTruPvx96coefLKqlitlwyZSq5OO5Xyi67irNSO16K+lzNRjOI/Kvncdn52mr3stqDkR603YqfI+EKdty/fYEqmrFrF7ae16iQ0ell38ugEEoj+K/c5wNZ7JHy58IojBAYFz6zWCN5rYE24indhDilCFAN5JWKygvYJixeeox5t5Xy1d8Oga/q5dN+hOzLZ0s+ZfTzLnmMzd5taFZc2KeXlpiT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(1800799009)(451199024)(186009)(5660300002)(54906003)(41300700001)(44832011)(31686004)(8676002)(66556008)(8936002)(4326008)(6636002)(66946007)(316002)(66476007)(110136005)(36756003)(478600001)(31696002)(6666004)(53546011)(2616005)(7416002)(6506007)(86362001)(26005)(2906002)(83380400001)(921005)(38100700002)(6512007)(6486002)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlZSL0pncE9OdEpJOVdRNUVwSlJ1YXoyQklnWXE4bVhyTnJXdjBCbllBZ0xY?=
 =?utf-8?B?bWlZZ0FDWWtQUzVEKzlEZVBSYWtNYW9IN2lkOTZaYmtJZEE2RWFzR01JdmV1?=
 =?utf-8?B?TWdXcVBMZ2xDZHppdTQyeXZwTlpxd2NpWURERkR0TkducW0vZFA5NmErK3NL?=
 =?utf-8?B?OVkvSnNYUkVlUEhsQWVLL2RrbHlPdS85N1ltdFRqTG9icHBDYXFlbCsyQVd4?=
 =?utf-8?B?Z3pxNmppTk02bnZuNTJ4RnJKZDMwZE5yN3MwbE5YY2NBY25LaWJ0ZFlIRGdI?=
 =?utf-8?B?VnRnMWh3b2VyclRxSHVkamM5aFp6REI1UWkxU01JeEV5TUZ4N0xUblIvZTEw?=
 =?utf-8?B?VlhncDU4UENQQXZWa2dwK1V1NkhhekNrdmR3NmlZQTd2c0xQR08wV1JFZWVV?=
 =?utf-8?B?TW92MFlQNlEzYlpNcUZqVHRJYzVWdXlaK1JoMGVTeTdnVVV5RlQ3WllldnZB?=
 =?utf-8?B?SlZFUEorTkRiejBnckdVRzNUYi9DdklVckVmVWhDbmFWSnJOU3cxSXlhVlJY?=
 =?utf-8?B?N0x3UFZpVWF3S2VIQlR3UEJXMkxtMEpINm0yRGhXS3AwMGJmdDFSRWkyNzdw?=
 =?utf-8?B?aWJuK25peHg3Q2RSMUZJc25uQXc5cENoRnhSSDJBelJ4MFlwTGhPZ095dGEv?=
 =?utf-8?B?ODVRbnZpLzFqRUl5aEFWdmUvUWU0eHQ5U1NGeGh3TzNKL2JuNmtDUVh6cUlC?=
 =?utf-8?B?WHI1cmF3c0UyZEZ0eG93Q01KR3hFYzBRQXp2UWFEaVgxZEVDTTVCNzVKZWdM?=
 =?utf-8?B?NEZZZE82aVgvUWk4cUxIL2dPRnZqUkE3cXpvODRjeUNQM1AwTUtxOWFaQTRo?=
 =?utf-8?B?bzRmV0RhUE5LZ1MzUFcvMThxZnRYSmtlcnEzOUM5Vkx6RGZ1Ukl0SitkOGJq?=
 =?utf-8?B?Wi82MU5JMzIrWmgrdmJ0U0cxNU8rSlBHOGE2OEM3M0xldkxMOVJieENOMTZJ?=
 =?utf-8?B?aE5RaWZ6RGVhRXJDb3lFNWRUd3daMStuRjNteGRiQlFWSE8yMC9GZUFvZm96?=
 =?utf-8?B?WjJoamIyYjR2V1BvR0FyQWR1MFZKNm5mejB2YUhWY29jSSt6MmZ5MVorNDZV?=
 =?utf-8?B?a0pyY0VuZDJFVlpTaTh1SUtxYzBVTHI1L3ZpRm9SdXRsSVRoQzU1MWI2ekhh?=
 =?utf-8?B?UlRWTUVXQ1Qzd01XQnVIbDMrOUNYaHN1TThESjhzUVFBSG5PS25SOTdWblJK?=
 =?utf-8?B?NGx4RTk0Z3hsVHM2TEpmaEh2bWR5SFVIcjE1cE4yRmdFUXhQZ2IwZjVJdGtZ?=
 =?utf-8?B?anR0c3ZvQ1htRFJZQ1IwYzhOd2ttV3hWRFplUCthazdLbkdYVHgwREdOTUE0?=
 =?utf-8?B?ZkdsNU1pd2hQUXZpSkpheHE4cnp0S2xMYkJxVmN2b09CbVNCTmVxL3NyVXZ3?=
 =?utf-8?B?M2pPUVJ0UFlyVENDUnJSMEFSR0xicEk2VWN0MlpNWWhsUUdvMEVLYVNYMDFO?=
 =?utf-8?B?VjJmY040aWpvanBiNmhGbW51SjUydXB5NzdROXVUNW1vU1pUSDR6UTRSbjVT?=
 =?utf-8?B?K2g2S3Byc0tMVGc4T1ZxRTFSYlhKd0RVY3BuRFFIV3o4UGVydkdxMmlMbVJv?=
 =?utf-8?B?Sm5aWnFpUDhMZnA5RUd1andWTWJkdWFBeERMOEpXNnhyOUt1U2ZCMmxndWJI?=
 =?utf-8?B?Ulh4U29VQ0oyRVhjWk9YeUtGSFdSTnR2MUhXa0ZjcDZGeUZGQlVQTE5PUVNH?=
 =?utf-8?B?ZEU3bDFDdXlKbG9WR1lnMGFQdTE3aVViVEVFQ29IM3plUmE0ejRnOFk0ZjZY?=
 =?utf-8?B?R0JTTldJMTh6U3ovdk9RM2wvNVVkNFB0cGxKRHFlNW81bWdGa0Nhd2xiSnJ0?=
 =?utf-8?B?dENScXExSkhXR3c1cTBONU1rY0MwUC84b2VLemdrL1VSdzhqQ3hmUzJIQWRa?=
 =?utf-8?B?RUhrZEhoRWVRaGRaV3c2aVk1ZEdBcWx4Mm1hTkNCUW5rVkdrT2xJU2FrbDFj?=
 =?utf-8?B?SmNRbERzV3JiRXQzUkZHYmJabnBPek9laUROaWYxUnRleHVROGpBMUpESlpw?=
 =?utf-8?B?L0tNWDdDSkp5eG50TkZWKzVUN0lhK3piQ1lyWm5lNkhUQk5pRXRoc3Zab1Nh?=
 =?utf-8?B?Y21DdythWTRMRXExVFNRZm5qSHoxNEpaUmxvRTVGQm1sVC9td2FtaVdnRVZX?=
 =?utf-8?B?dVRvbGk2a1N3QjExU0RPK2hzSkhmN3dVY3hIcWVKckVCMEpvWXdKUHFDWDc3?=
 =?utf-8?B?cnc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6bd1672-3c25-4ce4-2dec-08dbb36d3063
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 08:49:35.0006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BlHnicN2/OBMw34ckG5PGgUf9rpgSzMZMBCaCO4zPH/SIkjs2fZSPWpo0IEVzD+2v8kzYxzZ5gPd8DPwJHi8+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7240
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2023 11:26 AM, Krzysztof Kozlowski wrote:
> On 12/09/2023 10:13, Iuliana Prodan wrote:
>> On 9/12/2023 10:07 AM, Krzysztof Kozlowski wrote:
>>> On 12/09/2023 00:44, Iuliana Prodan (OSS) wrote:
>>>> From: Iuliana Prodan <iuliana.prodan@nxp.com>
>>>>
>>>> Add the reserve-memory nodes used by DSP when the rpmsg
>>>> feature is enabled.
>>>> These can be later used in a dsp node, like:
>>>> dsp: dsp@3b6e8000 {
>>>> 	compatible = "fsl,imx8mp-dsp";
>>>> 	reg = <0x3b6e8000 0x88000>;
>>>> 	mbox-names = "tx0", "rx0", "rxdb0";
>>>> 	mboxes = <&mu2 2 0>, <&mu2 2 1>,
>>>> 		<&mu2 3 0>, <&mu2 3 1>;
>>>> 	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
>>>> 		<&dsp_vdev0vring1>, <&dsp_reserved>;
>>>> 	status = "okay";
>>> Drop this example from commit msg, useless and not really correct.
>> Ok, will drop it. But this is a correct example, is just incomplete.
> No, status=okay is redundant, thus it is not a correct example.
ok
>>>> };
>>>>
>>>> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
>>>> ---
>>>>    arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++++++++++
>>>>    1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>>> index cc406bb338fe..eedc1921af62 100644
>>>> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>>> @@ -210,6 +210,18 @@
>>>>    		dsp_reserved: dsp@92400000 {
>>>>    			reg = <0 0x92400000 0 0x2000000>;
>>>>    			no-map;
>>> Please test the patches before sending. This does not build.
>> I've tested on remoteproc tree, but it seems I missed a bracket when
>> sending upstream. Sorry abut this, will fix it in v2.
> No, this is not how testing works. You must test this patch. This means
> you tested something, then ported patch to entirely different tree,
> resolved conflicts in buggy way and send it without testing. Nope.
>
>> Should I test this on other tree(s)?
> You test the patch on the tree you send it. What is the point to test it
> on some old code, cherry-pick with bugs and then send?
>
> If you have cross-tree dependencies between subsystem, isn't linux-next
> for this?

TBH, I don't know, that's why I asked.

For sure one patch is for remoteproc.
For the other, I don't know who will pick it, but I'll tested on 
linux-next, as you suggested.

Thanks,
Iulia

>
> Best regards,
> Krzysztof
>
