Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA4A807318
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442063AbjLFOyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378996AbjLFOyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:54:15 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2137.outbound.protection.outlook.com [40.107.20.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF58D44;
        Wed,  6 Dec 2023 06:54:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjDKt8b91uv43lyhIipcUUZNgfsWNld4Eq8fCNXGkndRY9nKLRWwLAns6CckhTPQEaFOcTmVTMmGicKRawxVgqen+o18xr7WxlL5rl+qh6AvTz3yKx5q8n/viu4DqPR0RRLLVsFJ+jXrm9F89d9t28zn8GKMhwe/tvsRNCXlnreiELtchhPVhM0eor5+clo5nMw5YPLsb3hxvpKV8E49nAK8ksuQo0cx4/xmwOTqdxeQ1a5EZiR7Lbgoy3DgZ7lcrMhHcPVxC/rtHV57ZLi6bVHcYW7p/Ucw5wSUKJgaP+6AbL20ZXDg1659iMmxXuPBF+b4EBW9/cMZKrjDoaNcRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21Zn5XMRI0iYInGQIlyRdLqQT7HQV6FXgb3hUV3ZPDA=;
 b=YWhjUT+hXuBJd4LX4LSHEREVChSkhSXiCthf7ERJ3zNmTuk3fEIUoXLOj1P53I1Ll9BJTMWLxY4qK5IIzh95XVIGMYQam3MTFzl6Z13S2r61z26dbBt0NDWs3j8zcEFq2mQEV6yC9SCay1TbexIqUtmFsEHt0cjgpL4uBSE6C3zNDItlPllULZ00+gXHWTWwL078akYHJtq7+are+ruFdbSag5mkKWEZCjhnf0ZxwsAewNmVKXzaqNgU8bOA6BDXckoQjxMpZphA04icyzTLNCYVGCCQiBEKGGkuknrmEJ+YxkAP0DQ6vq439wptfbB2Pwtpw9TSeQRq+EVX1V1zvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21Zn5XMRI0iYInGQIlyRdLqQT7HQV6FXgb3hUV3ZPDA=;
 b=UKs/iwzX4STPbZ71Z89A717Ltuk75bB0W+a23pgysHpdo5jFxrKspmNRzSGXq76CmBAsdLhdotxwUD+QTPC/04EkBm1ZVl0fR5QKFyrNowrJ1jVxKEyxBEjGm8LreB1Hew3Ew/ng4wtBhlHrRi7m8WPNCKHq4JH7587kK8dYtU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DUZPR10MB8100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 14:54:19 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 14:54:18 +0000
Message-ID: <ce45d170-9331-47b5-b8c3-6feff489db1b@kontron.de>
Date:   Wed, 6 Dec 2023 15:54:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] arm64: dts: imx8mm-kontron: Add support for
 display bridges on BL i.MX8MM
Content-Language: en-US, de-DE
To:     Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder@fris.de>
Cc:     Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20231206144201.46911-1-frieder@fris.de>
 <20231206144201.46911-2-frieder@fris.de>
 <CAOMZO5Akp9PsFf2GrSFTKyM1c3kSUEeU=W9ODgiMkyHATRWHOw@mail.gmail.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAOMZO5Akp9PsFf2GrSFTKyM1c3kSUEeU=W9ODgiMkyHATRWHOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::19) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DUZPR10MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: ab52415a-16ec-4870-f983-08dbf66b3966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1ijCkn+6BJuCWocyG+TOjlemqsK0VN2ZYaBPu8A8QkHlMfcHzCXW0QWNtAnnznwWm6MjbEL2MYjFBb5W4erM+b+pwKey4HtnvUJghmN4Jcg5QiBig5NfHNbj1KyWfgu7tF0yzSOcTIJ43MK1g5np08qA3Y90H7+tXhaJeVtMVMRBRsr9c0BauJH0bdwRG8kGuSgRHJW41y4w2z3ma5GNshWlkITm5crcNlyR6ztC5+l3BPrfYvowOAXoWkEvbOG+IyWoW6IeMWY0Po8Xx6XbMPUOnPAlfFdwtck9hWc+w1RRJJwzo6Yw4Vn+oBVqt3Q+C8oMWgKial5eScAHE6pyOcHm2gOKDUgqzCQiBvxVlX2AqKoXdNlP32SZb0TymnSW7R0BRrUdJ92FEUrEYvAYn/AHbJ5d9GikuqwGLeyXoBVERzUzkric7dhDmltgitsruU6bllvPhDYCzU8qSnNdMHcJCbRaiOLy+IlE/zMrfV06UgqJo+4CUpPaOo8N2Amq3R70nvzK8R7U4c1O7qhBvmz3tdqBs4iBwI53w1fwX+LPQFPF0m90hCKkPcIaniDysmpVNQI5opJh5m6hNinm+55uv/ISkRN9e+al3+LOwugvv+BwXi4rwluaSGegLmkq9JiIgWh0gVpCwhEV+f37QH81e35GfK6i6wz8PsfXK8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(7416002)(4744005)(44832011)(31696002)(2906002)(316002)(110136005)(54906003)(66556008)(66476007)(66946007)(4326008)(8676002)(86362001)(36756003)(8936002)(41300700001)(31686004)(5660300002)(38100700002)(6486002)(478600001)(26005)(2616005)(6512007)(6506007)(53546011)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ris2aEVYd09WaUI0UWd2dENFc1Z4WXQ4dzF1bGhnZGdHeVFHcHRRMXF1UXN6?=
 =?utf-8?B?MHlXODdzM29JQTJzVmgyYmJPdWtWTzJVaDRQSXNydXZSYmVPZ2o5ODAvNDho?=
 =?utf-8?B?elZaNENuaVJzNE5uR0Q3K3Y0bGR2ZTVGbUI5a0Q1NnJRYlZSdklWaEJpMDJD?=
 =?utf-8?B?SElIaGdaS1VNVzMrQThEa21LSDE2dGFPQmhyZTR4TzhJT1prbXJzUjlLR0NX?=
 =?utf-8?B?MExRR2x2c0p3VjJjMXcyUVluQ0hFTHUzNTZ5VnJqLy9UT3dPL3hBaXA5SEVx?=
 =?utf-8?B?YnZWTVR6T1RTeTNOazlUb3NaWTcyNzNseGxVZFBCZ2VYbEtSaWZtWkhBbFNG?=
 =?utf-8?B?d3g4Q2RXMjB2UnduYlRxeDZ2ZXNYek4yT1U3N1RRVGJzOTRhZ0JIdGZCNmRD?=
 =?utf-8?B?U1hlZ0E3L1oySDFNeGlUUDFlQWhVeFJTalFsMEcrcTJSWHNzY1RqTCtKYlJx?=
 =?utf-8?B?cy9OUEVUNXE2MkRPTWVwdEduZzdPcEQyL1lNRGpXQ3daTlllZlRRZ1VyRG9j?=
 =?utf-8?B?TEh1RG1BMWNjd3JWQzBmVEd1NDdHSUkrT29wdkhvQnFaUjRJOU5LRXBFM2Ji?=
 =?utf-8?B?dWFmcG85VUdpNmM2TW5ic29XdmthNFVScm5xdEVkcS9jSys4VVNPLzEwTWYz?=
 =?utf-8?B?YTVRbzBSSm93MDQzYlA5SzJoZmxhdXA5WnZzSDFVOU4zY1JMTW9nSmpGQU9r?=
 =?utf-8?B?dWY4WThrSHEySVhGeDNSRlRMalZJZTBUYngrejRmRFErUVhkWVVDbDFZaTJu?=
 =?utf-8?B?MmR3K1BLZXYzMVJtZFoyRVJJODdCQmR4R3hLUTNBOEFydGwyZWRGaU44Vm1y?=
 =?utf-8?B?L1BVSm51NU5ybS90cGNlYUJFbHRZTGc3SHQzWGNaZDlIUUFYSk1waVRuS2xh?=
 =?utf-8?B?Z2VnSGpuVytZUmlrdDc4RHVieDF1VWh5Nis0NlM0Y2ZHZUNtLytHNTZzMVZI?=
 =?utf-8?B?UXdkOERWa3htSVRMdWdCRG5hOTdEd2NDOGhOMkp0SnFvbldGSkNqQnplK0Yz?=
 =?utf-8?B?eXhFd0FXaGtFVUwyWGZNVEpwTjF5aEdxeFkvczR3OS93eGc1Y3JUTnh1a0Rx?=
 =?utf-8?B?VjFwL3NNOWJISzZWM3lkRlJLR0M2YmY1N0ZUMWJCZXFrdy9FTS9jaFBhN3hN?=
 =?utf-8?B?d2htaUdpQUpyUWF1YXlUZTBjZTlVdHc1R0xiUjVKM2R6OGV2Rk1vdGZ3aUhT?=
 =?utf-8?B?cUhlZ1VHWjVwVmxWNTNyNjR0eUFwQXJqbEpicTdiTkNSbjdtTEs4SXM1Y1ls?=
 =?utf-8?B?NDVQTEdITEQxdHJNaFJtdGJNVkF0WWZpbVk3cEFZSXZMS1ZPc1BFVnFUQzdB?=
 =?utf-8?B?Ym1weHBhUVhxcmMyZ1dxZWFmWGV6bnByLy82RzhNQmhwOUMxa2MvOWgyWitz?=
 =?utf-8?B?cER4dUx6R0lKd3lZTENWTGhKTG0xMEtyQTIzeWhCc3Y1VGZPcjFOdzJYSnFx?=
 =?utf-8?B?aXNoM1l0VWVqVjMxOG1sQ1Rtb3F4Y2sxTGo1OW0zRWdSRzYwK3NhOFh2d0dW?=
 =?utf-8?B?NWM2czFTTmIybGdSbUw0VFZaRytkYTRlUmJodGNHY1NJQUdyYUFHVWlVY1pj?=
 =?utf-8?B?Ym42d0pxU2pMUVdOaUVQbVBraDA5Q0diNnRHdlIwQ2VsS0QrcC9hOFhlWXI4?=
 =?utf-8?B?M3pJbW9YeHRLZFRUamtVVlJnSkVGVHJmeU1DeWgwWkE4MVZ0Ni9MQUZhRUhD?=
 =?utf-8?B?MXlXSFZGbkc5WDNkQWNXRUJNbDN1YW4wUGxxU0QwVENoZXFzeWJyQzU0ZmQ0?=
 =?utf-8?B?TndwbWdvcVM0QWlkRHFYNTJ0TDE1S0wxbHIzNVgxZmkzNjdaOStaaHhlYnpy?=
 =?utf-8?B?WHUwc3BpeE5Od0VZaEdzQzZsc3hMdTk2OHM3U1BneTdrd1hZT0xYbzJxeTRW?=
 =?utf-8?B?VDFtYStFbkRDREwxQXl6UEVpZHlGOVhGM3JJL00rMGNreWNWWEw0YU5zaHNn?=
 =?utf-8?B?Ui8vUGFXeUE0ZzhiV05lNzFCbWhtenFhQ3JpQjVpblFuUUhYdHpzbHEydm5i?=
 =?utf-8?B?ZzVPWUc2QVVDdDZQNitidDVnaWhzUjhZNnVDdzFXNkhwcXlPdVdQcmY3dXVa?=
 =?utf-8?B?dzVYYk1hdTVnZWt3Lzd5SnNYZVBzWTVyakpYQ0VIRjBZSC9kampHMVRGYVZI?=
 =?utf-8?B?b0pDcUpPSDZuUXFwSUl1cUx3SXRPQ3FvajVweDRPRUdaeUxlNjVoRVBIMmEr?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ab52415a-16ec-4870-f983-08dbf66b3966
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 14:54:18.9045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EthT44wmHMI7BdQM9/SWw8S0q3SZ6jGD1gslml8OdQMz/rMkbt63xVc4qcfx7OYbcBQkRJKpvVwlGoyeqd7WLnX1PU+qy5XFSx71eLtYeb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8100
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 06.12.23 15:47, Fabio Estevam wrote:
> Hi Frieder,
> 
> On Wed, Dec 6, 2023 at 11:44 AM Frieder Schrempf <frieder@fris.de> wrote:
> 
>> +               a2vdd-supply = <&reg_vdd_1v8>;
>> +               avdd-supply = <&reg_vdd_1v8>;
>> +               dvdd-supply = <&reg_vdd_1v8>;
>> +               pvdd-supply = <&reg_vdd_1v8>;
>> +               v1p2-supply = <&reg_vdd_1v8>;
> 
> Supplying 1.8V to v1p2-supply looks strange.

Indeed, but it's correct. From the binding docs:

  v1p2-supply:
    description:
      A supply that powers up the V1P2 pin. It can be either 1.2V
      or 1.8V for ADV7533 but only 1.8V for ADV7535.

Best regards
Frieder
