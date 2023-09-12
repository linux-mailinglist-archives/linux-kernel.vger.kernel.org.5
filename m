Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2788C79D011
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjILLfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjILLeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:34:05 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD9810DE;
        Tue, 12 Sep 2023 04:34:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EydD9j9g/pDXQAFq6yZw1dCpkpsbUe+qaK9LLAzFnX6h0RBCdndTSkZOypHFZaF8BuU2lQFrhVCVbDnY5Ms2N59zkUyOi90pP+OAIXCE7LUhfmRYGVo/0r+MrCyisckclgDD2paMCLmzmglf3cOIzFBMYb7FnplEn7ydnT5IeKrhLjOYaqLWfJwzNLrcSKC0YjdXAVod+S0zXfydCfGwzGrr+0PqrCq1IR7cOF0AeOMD2RVXDJLWAuNufv164yAw4HFZjEIICJot+juyk2fEBt3jiOKZTmdS7BU9a9U9+5xHFQDZqxZ9uffVa0IbDysxXtJ9N6KL7I9eIh5bX/PabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxc6yHnOSqSIhJhbqxgjPcm/qPmnr2mFRGdkBajSUr8=;
 b=fkBmILMGoLCeirjNPxWZktSg34Z2G3gbeN1annIwus35tMbyctvp5BuaTtnreiQSVdhWcDaN8NcsbUtFVs72ShmrZsGvlp743aGXFxmcq82+F9CR1t71hPfd9SDDRy24pq3I+8l/nj55ImoLgBG+85KD4jUi7Z0SZoOL6lqP2yWIW2WXQ/3XIEij8EQokfUemvs3/j16aJ/J2SYCgk+QzKWOw9j6XU6groZA6LPqM5TZuC2ZdW9vsO9zZmSFzjTmD1S+04YTQ/G17nKcewuQvqN1E+RERkij8z2DsNQhl6O5n3Asqj5qPTB4wskHzDFjvlmA4R2745HZk6AsJeok9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxc6yHnOSqSIhJhbqxgjPcm/qPmnr2mFRGdkBajSUr8=;
 b=gulTMJBFGhY7EasheguaHCC4y77nEXjWdFsubFz7voO9Ldg+DBK2H4WQxAqsm8VwkZaHiC2XvAO5ILMPLuqEtaSVr+Lz8lWDOlkooH81q4xiFXdsQHWomWuW//gZn7TjJBw4mEm1iLeh7hNXQ+yZqZPNF89hn+YxFDgeIzutUMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by VI1PR04MB9811.eurprd04.prod.outlook.com (2603:10a6:800:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 11:33:57 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7%7]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 11:33:57 +0000
Message-ID: <2d5f1ca5-0d09-399e-aa41-e43fcf444b8b@nxp.com>
Date:   Tue, 12 Sep 2023 14:33:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] arm64: dts: imx8mp: add reserve-memory nodes for DSP
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>,
        "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        LnxRevLi <LnxRevLi@nxp.com>, linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <20230911224452.15739-1-iuliana.prodan@oss.nxp.com>
 <20230911224452.15739-3-iuliana.prodan@oss.nxp.com>
 <20230912113056.iyckw2j4sbg2brwr@pengutronix.de>
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20230912113056.iyckw2j4sbg2brwr@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P250CA0001.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::6) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|VI1PR04MB9811:EE_
X-MS-Office365-Filtering-Correlation-Id: 05869b06-5d3a-47af-9fff-08dbb38426cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P/eTMGM2LR5FTWLUoJ+Vowu4lDTIMWbbefq62UlCteIMtPtnaLfj/rmLvYfq24pp5lBcXM7XIrlJYaKCOSeuM4d4pjG9ust18/vV88AmR/oyDfSN+4ERAStG/1BxAf56IBMKZctqf/IrTL9opidVIh4pZEXb2z4NmfM9QjtXSIyxcxnTUy9GWEE17n6INe/afV5ufXK882U+jeTUAjoq/8YKDlymmJ2ycNQMZpnBg2Eo2b9uIdhJ8IKdKDp997eKMrzvbDdGrpT/g+1r1Trz+qLridc9hgZTcf+0t3V8GsLxZDIgVyQNyodH6WnfdrArt3pZCHJFrwkas4Pyd8/RjmpivxMCS/TMuQ6ArC8lZlufTt6jTgKMNYsLqxdG56wlFT8uHwxnNYiiaMoNzu77tW8+8ykmvBtMJdElQ5C6rEu8jhN3PuBuVQo+a+V8MiZ692YhE7glDW7KiicHK1cTgS3xpG/Sw3+nZiZWpud/Y27e7kxG0r/lACH9sgCENAF/nm5D2i2Hrp1qHFCinAMmw6S4XjqBdjG/AQ0FUGaPCqOsTdq2psdc6MkhuZEc6TPwuQs8omJgzkJ+yymwBbeF4zXZKbZef3ZkjZt374PnjeE+auo99Z2VzwdKdTYOqwpOWT5Yr8ufhmLgoMU4LxaiLQEG3wetWQ7eM+CNrXqq3m0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(8676002)(4326008)(2906002)(8936002)(31686004)(66476007)(66556008)(41300700001)(110136005)(66946007)(38100700002)(316002)(54906003)(7416002)(44832011)(5660300002)(478600001)(966005)(86362001)(31696002)(6506007)(6486002)(2616005)(53546011)(6666004)(6512007)(36756003)(26005)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWpOUW82SEdHeVYzcnd1L3ljSFFJQXI5VFR1T1U2K1o3NndBZGd4SVRyQ2tq?=
 =?utf-8?B?RlNjLzY1dXdGUHdKQjA3SEc3dmdnd0N2TktxcFNSZmNRTmwvOHRpeFRLL1Ni?=
 =?utf-8?B?eFJuTFpjNGJnMEpXNWdHT294M2dxa29lVi9qcUdzVkNhM2FBTmVQdlZKSnJu?=
 =?utf-8?B?MzZzRGlYdnRsOHFiUTFlOEhLOWg3NmpmbHk5QVE2NmJaNDgyOUMyd09uYjVr?=
 =?utf-8?B?ejlHVnpjMlJ3RDFCYzAraXp1eGtGbHcwMVdzNjRacDN1bzhrWXljSjJTMk1o?=
 =?utf-8?B?V1JjNEVXSjE1QWNYeGtKZ3EzZ3JlZjhFRGxwMjVJSkZzQzRmQWdUdWhpbHI1?=
 =?utf-8?B?cWxRV0RaYkRqZER1TXVTeCtzUVJNb1huTko1WUtaSmNZcmkxT25IUCtSNkNk?=
 =?utf-8?B?c3VURlNCTC96Z1RPSndnTFJqbEd4YU4vaXkyQVZ1ZnNkN0svcWtkY2hwN0tI?=
 =?utf-8?B?MllCSk1TMUtjdVhTM2dLcU9zdUFOTU45eVFEVTJFYnNFVlduaHlMc2pNR3Z3?=
 =?utf-8?B?eGVzWHh2b0JQcTVlZ1VBNEYxVlBiVnhsTkNHMExpNTVYMjlwVldxVHE2OGUv?=
 =?utf-8?B?WXNlZkpkVnhQN1B5dG5Ga0tkRE9GbTlkeE1wdmtoc21KQlY1U3F6cnRwZkhR?=
 =?utf-8?B?NGJkVlZ6MUhyN284bzNPZXZGRndTTmVxNkhjR1VKWnROUkx4UXQ4eEx0ek1v?=
 =?utf-8?B?T3JaQlY1SDkwN2JPZTV5dUVvdUtBNHhwMFluZFhjZEpISzRYbWQxN2V0a2J5?=
 =?utf-8?B?azlOdmJVQktKd1JxRlF0SGJDOE5rZ2xqTjNMbHFsMWE4WmYyTTJFUVF1RDBu?=
 =?utf-8?B?aUczVVIzbHd2Y3ZNMVhBbGU1VWpZYXpDZTNpKzl5M0VKMnJWUmc1WTFtU2tZ?=
 =?utf-8?B?UE5zcStsYU1ScnRWQWMyQ2ZGN2pHTHN0Y21CdzEvazlJTjlQN2ZMU2Rva2RL?=
 =?utf-8?B?U2oySTBGWElqR2E3S2pCQzV3Yk1WZnRnUUhIWGpjWmp4MTZsRWlIc2gvcS9L?=
 =?utf-8?B?dzhJYktGdVllZXNwM0ZqMnN3bldwd29zbnUraVRWang5VmZCMitmbVhMTmtN?=
 =?utf-8?B?SUsvOUQ0S1NTSFVKd3BlbEtjTnJaV1FkU3cyeDhnWGUwTXJVUEx3UjlFU3c2?=
 =?utf-8?B?Q2FIaDAwY3dzeFd1OFgrSUFCQUk0RFlKcXNFM2hDT1laZXdIWUtnYzZZY2d6?=
 =?utf-8?B?cEZXMldmbDAyV2REM1EyV2diVWl0RUVjSzNkc1FKR0FYcVMwL1JoWGo5TE8w?=
 =?utf-8?B?TWxEQnVvYStHNnd3YlVHeDI5VFpHbzRYSWh3YXBVZldGY3g5V2R0RnFzV0JR?=
 =?utf-8?B?LzJtektYTnZuZUlweDRCUG9YRzZwM0w5Y0FFUytTZHloNndqUDUzOEZMRXdI?=
 =?utf-8?B?TitvUVJnd3JpeTl6VjdYL20vOC9rYnhva21PMG9HN01BOU11SkN5V0wxL2d1?=
 =?utf-8?B?eVVZRnJRSFpUS3JoZnVEbDA2ZkdMSE1pVkZwb0RnTUx3TFVMb0ptYUk5eERC?=
 =?utf-8?B?ZkVIWkM3RkEzbzYwSzZrekRYQ1lZQndKN1RJeS9Ib3JuUWQ5Q2hYRjhkNzds?=
 =?utf-8?B?YnhJajZmbUdqRmlYT2dXWEtQY0hTby9sU293RmZpQ1hUbHdqbXR2S0VZOEpC?=
 =?utf-8?B?VU12dnErZGIveThydkx5b2Z1cDF4OVV2UFdLeGdGSFJuV0FhVGhYM0tnYUhI?=
 =?utf-8?B?U1k2M2NwVXYwUlVldkFKUGJuOGNhNUhiYStSS1lxVEcxMWxJV1lVcXpUam5F?=
 =?utf-8?B?anhzcDhCQ0pRVTBqeTJkNG1VU0hORlhHSkFqTVYva0NQRGEvMUFyaHl5RWFa?=
 =?utf-8?B?VGJ1bG5Semtpd05RYmd4ckozV0svOG5qVzNPdG90UWF4VVZoUFFGcjBFRU9k?=
 =?utf-8?B?TlBQUXFUR0c5UHZvakMrci9jcnd6N3hwNXdxK2tGREtkb3ZRSFBUOVRVc1ZU?=
 =?utf-8?B?R0xnamNvNWJVaHlJU0RNZHJOM1hTcCt0WmgxbTNrOUdqaHNZeCswV2ZLalNP?=
 =?utf-8?B?M0NaYVJHcWl1ckJvMmJCdmJIVmREY2RKaktUQkFmUUtnVFlaYVRIWXQ4MXl0?=
 =?utf-8?B?eHgyQlhJaDFPUGFkTFN4VWgwRXZ2MnJnb2ZlQ0lYMnRobktmQUxKNHU2elJR?=
 =?utf-8?B?cExXTWdXQmpiVUxRZjZ0Mm8wL09VSk1aM25aMDExYW5IK1lwVEE2ZksyRm5j?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05869b06-5d3a-47af-9fff-08dbb38426cb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 11:33:57.2376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RcfAuoTB4ogWYaEuuDll9i3HYfJdG4zloKxnfV1mArJeI63+ZhHDCaYmBCdtcyRiOGZr4Z4imwDKl6Jd2RQNHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9811
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2023 2:30 PM, Marco Felsch wrote:
> Hi Iuliana,
>
> On 23-09-12, Iuliana Prodan (OSS) wrote:
>> From: Iuliana Prodan <iuliana.prodan@nxp.com>
>>
>> Add the reserve-memory nodes used by DSP when the rpmsg
>> feature is enabled.
>> These can be later used in a dsp node, like:
>> dsp: dsp@3b6e8000 {
>> 	compatible = "fsl,imx8mp-dsp";
>> 	reg = <0x3b6e8000 0x88000>;
>> 	mbox-names = "tx0", "rx0", "rxdb0";
>> 	mboxes = <&mu2 2 0>, <&mu2 2 1>,
>> 		<&mu2 3 0>, <&mu2 3 1>;
>> 	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
>> 		<&dsp_vdev0vring1>, <&dsp_reserved>;
>> 	status = "okay";
>> };
>>
>> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
>> ---
>>   arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> index cc406bb338fe..eedc1921af62 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> @@ -210,6 +210,18 @@
>>   		dsp_reserved: dsp@92400000 {
>>   			reg = <0 0x92400000 0 0x2000000>;
>>   			no-map;
> This seems broken.


You're right.
Already answered to this here: 
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2558691.html

Thanks,
Iulia

> Regards,
>    Marco
>
>> +		dsp_vdev0vring0: vdev0vring0@942f0000 {
>> +			reg = <0 0x942f0000 0 0x8000>;
>> +			no-map;
>> +		};
>> +		dsp_vdev0vring1: vdev0vring1@942f8000 {
>> +			reg = <0 0x942f8000 0 0x8000>;
>> +			no-map;
>> +		};
>> +		dsp_vdev0buffer: vdev0buffer@94300000 {
>> +			compatible = "shared-dma-pool";
>> +			reg = <0 0x94300000 0 0x100000>;
>> +			no-map;
>>   		};
>>   	};
>>   
>> -- 
>> 2.17.1
>>
>>
>>
