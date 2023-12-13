Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8806D811810
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442305AbjLMPr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442349AbjLMPrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:47:17 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C44DB2;
        Wed, 13 Dec 2023 07:47:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Il1tGUW26YNXweDailn9sIZX2lSp2zvyufBkzxsubAxBpCHY9Eqg+X0HKRsCsc+nN/Yd6Y3vfm59BhUT9jbz9jGZaRwXor+GvagyQtN0g7/Y/q7nTfsBV9Ag6CN8XseEgyHIE3PCM2X6T/97WTs1v38+oKsaEy69eGRomVMoJNTlxuPeG3k+k8M86UPOFA3wQ46o/bN1S/UZiKsF0xpmvTtpf2JAdTPV5U8YldcgDArx1wdKrXnX0Q7ezwbefV7wGFHzE2krHwoSTJBQH2GMVfUelLQypnnGVSv13Y+jTVHfJF4npfstL3hLXD7TUSzCcMU8E6BiRCgBexJogRZRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aslV1OZ4Ikw9IKOgg2A1BN98uqd9istGvIj+iv6t1Jo=;
 b=WC9NTaUTz1yiZHNR/TjLzccmNWewsoTJuX2SqucUPO/vbOnvvsHWSgbMKoZuNcWsr3nWDsxGg7etExthg9LqWcGgkgl8bNwMz0HX15v9VaMJPS7CMUbwkh1gjDQ5tdlYQ9YDK0LE2qZ6XPeV7A8EKLF2g+1VVd6bvwJxyokWKb2YpmjIWj5LsjEzNQ9qYq8Iep2q+1eYvOwTKnolmQhn3nHd/b9dt59yO0z5EYL9hBouJdcBZGIe6k1tZgzlSUd/WzMMm8oXlqq9ankHDOsZ4kW3Hp9i67b7nPMHF9jduhhk0uXZADNge51pu5JjaYfXQzHM60jVZYz/SCltsudZkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aslV1OZ4Ikw9IKOgg2A1BN98uqd9istGvIj+iv6t1Jo=;
 b=D206nCNJ+kZQSvp8J41xs5LkhCLlw3Y1eWPZcq4P2EGFTyvqwCRRJoLlD3XR0VYiWqvCV7IN9RIRIp5XZCkHzY+19ZbhEF08N/QByjAY+NP1XMdxHpKEnVlHNzK8wfFAFEomFOPF2wGS7Y5ICl/8EQGCktcVjsTTjxdSmH/Bg3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 15:47:20 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 15:47:20 +0000
Message-ID: <fc38f9a4-6ce8-4d27-9bdc-f317ad03c930@amd.com>
Date:   Wed, 13 Dec 2023 16:47:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Add missing destination mailbox compatible
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Varalaxmi Bingi <varalaxmi.bingi@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <96460adbb99ea829a2a95c72a40118f81946a559.1701335951.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <96460adbb99ea829a2a95c72a40118f81946a559.1701335951.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0115.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::44) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 9982f211-c921-4f9c-78c3-08dbfbf2caa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MrQNRuSwTTZcss55C0RZi0E+gl+fbCAAdu7A4QhaCE2NFlO+loBLzruzjc42vXk3x20mI9LXiT2gAcHrzZWaIyxXRVXGrM/ouyT6J18B2gX4WwXS+rxyUX/FMwmy3QjON5q5fXF+FNwgvpCSDq4zY0fcLIYt6pyRr5d4bkQ5fBQuprCzSRNUUbNO/EG2WirS3bve3xYLFyhBB6rysOiieUbJYjwQGcpuFTqZIZgOZXNkfZrUXfv0OjIBh3WYd0qPZM/ny3aBqH0ez0arhayDrju9/zSarySR8kJMloQ7Ghh5tj0rBdFHS8GFNb1xNCyiYQ0Mm3aTD+kK0eWpbJn88vxCvT3Z3dWPs3W6OB+x1WlNQ7GiPz7V3ZMiyCQ2fiQQDA275BJiu6UF+ZG5SishcQAWMiyPfNxBbpQXot8i6MmSgXfpjOcT/jokCZOse1Ne6Nz8QP1JXbKB1ipwu8DxzwgOTIbMIn0cR8x7pFdLpswluP4U6DI95Mx9vMWYEa+WDduDd76AWYL+9JVqW4X2lI7zmfe1NQav3zKFVcoekxJkS7FfsyXqic94/L1Rsb863Pk8Ku0xT8ee5XgZuGRseOIjutc5oAHG5QrVrpKPvauRInhNeCrE9cBgBUgiU7diLPKfvP7+RSqWoSeMBQXn4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(66556008)(66946007)(36756003)(31696002)(86362001)(66476007)(38100700002)(6512007)(83380400001)(53546011)(2616005)(44832011)(6506007)(6486002)(6666004)(15650500001)(4744005)(2906002)(7416002)(54906003)(316002)(478600001)(5660300002)(26005)(4326008)(8936002)(41300700001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGJnTFBnUFJrb0M4cmRlTW9sQmxFbEMrS3NaL094RFNuNUVCcTJHS1JGdG1v?=
 =?utf-8?B?QVRxV0hMWTdNQTZGVENTVHNIUzRpd0JDbFd4NE1IdEh0THFCMVp1bkpYMDdR?=
 =?utf-8?B?U1RwOFRVL1FuRzN1a0lIM2VjRldJTFphZlh3enJnMXNscDNzdVlEM2F6Zm9B?=
 =?utf-8?B?Y2Y3WnQyL0J3cXJmbTNVRUF5L25QMWw4MFJwa2pVSGRwaVV0d0xFNUFkdU1Y?=
 =?utf-8?B?NEpWaGdPaWtmL0NxRHFCOFlSZXh6c3VSdndBRVR5SmxzMCsrSVNld1NidzNT?=
 =?utf-8?B?dnBQVTFvYTdyV0xQWHZZWVduYU8yNytzZ0s1ZUJyMkR3dDJ3Y3BGSlJ2UWh0?=
 =?utf-8?B?T0VZRlVPK1AvaWhrc1h5Wkp2UmtMbGFXWFNIVWV2ekxlOHVxSGpJa0NWS3Nn?=
 =?utf-8?B?YmxKRlNWTTRwck9MSW4rVjZPbUgrSnZGeTF3YU1DV0VWakl6VHpyVXcrcDlU?=
 =?utf-8?B?UFdSWURxVVBQbjhTTS9TT1RwdkpQbFlhZ0M1TUNSdTlWamg2TU0wakRhV2sy?=
 =?utf-8?B?TmNubkJ1UjVlMUhWU2kxMHdaTUZsaG5iTXo5RGx6dzluYWlRVTgxbTh2MlRt?=
 =?utf-8?B?RHhSNEU4S3VYaS8rSEFUWmxnK3F5V29jNm5DSllHSmgyZFR0L3gxK0RjeHc3?=
 =?utf-8?B?TU11bEQybG5GVEp5dDUyZ1RvNDRDRVFMNUtSUFVjWW0xSUZERVBBa1NOMXVG?=
 =?utf-8?B?alJieWJRVU1qUFNwN2tJV1RkRE96TktWQkZ1ZnkrZW1xMStWOEdKQVdWSjNN?=
 =?utf-8?B?ajhhcWF3UytzcXg5NFFZeVVCNm5xc09CQnQ1L1VRMjF4UkFWOHVpRXI2am9r?=
 =?utf-8?B?MlZsL0dJaG91YWV1dVhBa1VsZCs1b3Q5ZG13aUZlUVNhSVJSYjNMbTVYNjB2?=
 =?utf-8?B?N1c0ZlcwWFVzQmpRQXB0ODUzcWNvejlrVmpaS2tFVUxsUE5HY3ZGNnEyL1Np?=
 =?utf-8?B?S1J3NFpyRkI1NzltY3JsUkJrRFFMaXo1R1lQemRSRFVXK05aWHJPc2dEd1Z0?=
 =?utf-8?B?QTc5b3BqVFJvcm11Ym5rL214bHlCNmRCOHNsWUtOcTU1TXRLa0luWjNhU0Ex?=
 =?utf-8?B?ZHBKWC9qVFpVRWJ4STNlbExoTmk3NVdkMzNEeUpwOCtmbXJHWFNHbm03T0RL?=
 =?utf-8?B?ZnkxMHN0ZWd2b3ZGS1M2S1h4a2R3L3ROM0VjY0FteXZwVzE2MTFIMkR5T2VB?=
 =?utf-8?B?bEV4bVNBYVY4YnliMkxSSU8vL2JKai8wRTBlVWFjbzdJNkk2RUU0enNHMTVu?=
 =?utf-8?B?Qm1OaWtrTXVSN1h4c3QwYW4xZ0pRU2lPNXZsV1J0d2xKSzZYZmdCcmEyTjBP?=
 =?utf-8?B?NE1iN1RtcjZrZzBsSml6YXZMbkl2cWJYc2N5UjlkYVFJeThrWTV1UldudUNn?=
 =?utf-8?B?Rk4rTEtVY1lob2JVU0RNSjRxN09QcG95TzVuazlZM1RrdmJCSnFGRDRnVFBT?=
 =?utf-8?B?blduRXNVQnJ1TUdHb1h6WEtKdHBMeWRIRzFGMEYzQUdCQUs0cGN6Um1UajRl?=
 =?utf-8?B?ZzRhc2cwZ2lNaXlLK216TmFtK1hySVRRdmNMZEFYcGN5eXdnbVU3YUx2VU01?=
 =?utf-8?B?VHcxdUFEQm9FSis3a2EyKzlZUXlkTGlBVnliTTlsRnYxaDJwZkYwVCthOTQw?=
 =?utf-8?B?ZW5waVBGT2VvNVNnZ1MxNkkyZ1dnS0RuejJzbmRqcFcybXRzVXdramhVTlBG?=
 =?utf-8?B?bHozbUlaQkhpZW43bWswbkQ0RGxMcEFhVWZBK1lyWHFoRDhzbzFwT1BkckVF?=
 =?utf-8?B?YXBoaGR3SFlNRXNkTFRVQmZXTjk5LzZYdjdxelk3UGRBM1AvMm41M256YmpP?=
 =?utf-8?B?RHg1YzBkeXIwcWxKZEJiNEdubEJrN0xIRnZxbzU4ckNlUnRXSWdncDZyWm83?=
 =?utf-8?B?TVFKN29pbUZZejBySVpTLytFN1h0NmxkUVhZa1pEdnViTXNrZFk5ZWN2QWo0?=
 =?utf-8?B?b2JUV1piVzV3Q3NoQmtwWFdrUDJrbnZZb0ZneFpodWZnZFhyQVhVdjFjMTA5?=
 =?utf-8?B?azI0dmZINWtrYkZpQkd0S2EyVW0zenV4SlhjVTNIZFlBcWE5VzBTSENQYVI5?=
 =?utf-8?B?ZEFQUDZzR1dwN1RDeE9UbEZVNU4xTkQzVGhmVDVxbEM2eTFEV1dvdVhpVVZB?=
 =?utf-8?Q?llWaP09Hua6OFh/r9uQf+5uCq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9982f211-c921-4f9c-78c3-08dbfbf2caa4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 15:47:20.6194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYe6RWhVhNhqrafzz3dOMQ0Sz4pdJJrIGyUNp4vHN3d0YK2BixJfufv1QYRbpKKW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/23 10:19, Michal Simek wrote:
> The commit 81186dc16101 ("dt-bindings: zynqmp: add destination mailbox
> compatible") make compatible string for child nodes mandatory that's why
> add it.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index f5e1eb8cb3b7..eaba466804bc 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -141,6 +141,7 @@ zynqmp_ipi: zynqmp-ipi {
>   
>   		ipi_mailbox_pmu1: mailbox@ff9905c0 {
>   			bootph-all;
> +			compatible = "xlnx,zynqmp-ipi-dest-mailbox";
>   			reg = <0x0 0xff9905c0 0x0 0x20>,
>   			      <0x0 0xff9905e0 0x0 0x20>,
>   			      <0x0 0xff990e80 0x0 0x20>,

Applied.
M
