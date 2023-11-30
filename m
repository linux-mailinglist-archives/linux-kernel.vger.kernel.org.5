Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F187FF3E3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346403AbjK3Pqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjK3Pqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:46:48 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2109.outbound.protection.outlook.com [40.107.8.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541BD83;
        Thu, 30 Nov 2023 07:46:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqbSlXZj56BYzGkeYWdveBcWFuj+m5M3ynz4wPFco6gWSNU4Ki7X4U5CGg1z0Gtw5xLEqFEUV0VuSL9HWyOrBc8d+fhur1VB3PtHZmrlW4dZHZYiZwBuOMfztEPnCjf1e1UP7R52OktNKTLfPNomWr4w2BzJIIobQW4sUta5rrR2OFJqVkmmEUwIFpN2CEpFPSY78eeFed3rxueS/XB0zkUP12mJZ7HE2dYi1y3dvaUs21m5iwTBMDjlkKwytGi86yx2XlY1eD04hXFe7CNuOnJ+jI/U8BNDl4wSIjexmhovn0OCfMWME5en9gGoLGOAsHui+2EnIAcXhhU7pC7atg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YcuAq2WvQmS9ZkLIuLHULHgYCyA7CKzq/M6gsaoJLM=;
 b=dCxi/ZlOfWg3GQZsfYctek0/rz49hogDc87ZD2kWpeGeX/LgGCMCaEmHf1eC3arf9TzQf8IoF/PvKoXT9KMJB0WPzI4QJHJU30QbDETLw/3wUuurJrE/8YUNW24AwGmKD9fQ9s3r41Sa43aReVL0PHmc500HdEHg09p5i9qmKfNB+YPjfdOWIUmcXy2Zy5m7Ly3FATtBQDrEzxJZsnD3tuKaDtJkQr4TNkTIYiuOCSH5GEESTKh7g25VTDu0j9tEeBoTixfvVWgEY153xSDfcAjmaQ/thEgOVpyL/I7wiXN2m+FLPYpJRlybVNkoT2lMHF79RW5RE+qqlU5aqkDSgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YcuAq2WvQmS9ZkLIuLHULHgYCyA7CKzq/M6gsaoJLM=;
 b=o77cx4Os7Sv/xircl8u8ip45pA3tmYR6drx1h9QIHEAS/lM/UgrwzamicVguiJekN13DQnx+rlV2vTo8NzWe6N7h+iHsQNObi1Ns6kAU0IVqYouFn1NtEVPtM/fzYQTq7Mt+iNaBiWOt5RQgLwqeYOI95BC6Hu8/jbchu4sA2Yk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AM9PR10MB4069.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 15:46:51 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d%5]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 15:46:51 +0000
Message-ID: <56f1239c-2ca6-488c-9894-8f876a3aecab@kontron.de>
Date:   Thu, 30 Nov 2023 16:46:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: imx8mm: Slow default video_pll1 clock
 rate
Content-Language: en-US, de-DE
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembeded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231128045415.210682-1-aford173@gmail.com>
 <20231128045415.210682-3-aford173@gmail.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20231128045415.210682-3-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::10) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AM9PR10MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ceb359-5a6d-4326-1ee9-08dbf1bb922a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8l9I9vU6maWYj/yWjOvNYrDzNf6XEZq2lKmOKsSANlA92gUIOX88RM5U6sDhomSw2AsL1om5JWFrQZjsJp7iUpjL2Tr387tBpJ8/qTPlIzIbFOnboIyBCxuWgbrMUSrYjvK+4P16q27v80Mt2838AMIgT+eHZf8s+2RkiUp0b30I2KLxZAdNltHL6b5w19pnyBdMpLc5UMU28OxN/utZRxEYO+zVNl2O8tftHuBpCzzUMhviJ42CdhOSQ0Re+gDsWqqGXZpbV+BCphhbvLTV7vsriRg9XgPMVm8WQ9DDJ3997JPXo+y7Tk+yigdaBFFlAxmU0VFDVJnjRU7aQatp6xtCqJZ2Y8h1B30bfPHnLJAKqR7IwjtuA/vJzDcpiT4jzaHC/nJl2E/Vcq1u1dgPkctKrrViL9ecsPjcno1udt0L8a2NQJZf3Fv2dDi7A8q9S1PJdvyyvjN0cYS2uGCmlMIWl8NWIeiHQnG35HI3vo/gmVms/CJFQ3y7J47d3CugDmrSO7BrxHA6JTk10Z00BbZihxvdOQ1nK3a0HaU3v3CTRlrbyf1Ve0Gq0H+MkI+IS0zGy3gGOg9tYwAVhQ9Gnc7WUZKrNntW6k675IcbA/Xlu9FJisxJxPjq9k8np5P38Wiepeif5E6KxarPucxJL1HbOYUvxzlAD4g148TbTlc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(86362001)(66946007)(54906003)(66476007)(38100700002)(36756003)(31696002)(26005)(6506007)(83380400001)(2616005)(6512007)(53546011)(2906002)(316002)(66556008)(6486002)(8676002)(5660300002)(44832011)(478600001)(41300700001)(4326008)(7416002)(8936002)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVMwVnBjTStqekNzM2UyTUZ1d3I1RjlpMnhWZDFibkNSNlJGTC93VXpGQWVS?=
 =?utf-8?B?b2IwQUxYdytjWFBONnRCTkFMSVZXdVBEL3podnNlbVg5OVlwU3VZdHJKc2ts?=
 =?utf-8?B?a3podmVGYU1HaTVFc04rN1dJRWF0b21IU2xvOGs2c3U2V3cwTUxKbnQ0RnUz?=
 =?utf-8?B?eFpuUzJWQjh4RGZScE5xRnZ5WjRycnQ4aU5SRkJkWndmKzJpUkRRMTg3c1BR?=
 =?utf-8?B?VzlDNE1ZK20vWm9CWUY4b1M5eUxrZkZtbGN2Qm55WGhYakJTSUVJamxwNk8r?=
 =?utf-8?B?b2VMUGJtczZaUmc5NWtBUXFydlgwR3lISTBFWlVSRTl3WlZEVDdpdHZ2YnNT?=
 =?utf-8?B?ZW42R2RNMWJ0WVZOSjNxdmwvVmsydjQxYnB4QWtpaDBQSEVqeVQ4LzkrUGc2?=
 =?utf-8?B?aTdlTzlHKzhObzY4c01kdVFCN1FpV0VGeGlvcFpDNWdCR3lTVDNsTlNZeFEy?=
 =?utf-8?B?RGw4SGxhZ1dycGZHRGIzdWVIVVRWOG1FRjV2bFpLNmdkYmJrSktmMkM2SzhP?=
 =?utf-8?B?ODBDa2tMWTVxRGVIOGJFUlZKcGRzblpWTUphQk1XZTdjTnUzTzdXOEQxOHhi?=
 =?utf-8?B?M2lYWFVpSENZWnh1R3p4MkovUCtGZEFKazhzUmdFaFdJQVpKb2Z6QjZCaUhM?=
 =?utf-8?B?Wm5IMUVtWVo5YnpIRVZXRlVzbC9BYzhXOWZ4ZTcvS2czMzFHOFFON1VhUEg4?=
 =?utf-8?B?RmdGbHhWUkQ2a3VCdXZzRG01WThDbzRjUXhwb2xqdUtEdEU2OWxiT1pEM056?=
 =?utf-8?B?QU5aUmM1TERyaHJuMU1CdzF3ZVBOcSt4amQ2S1RvU3JTSGVIckRqNTF6aDlH?=
 =?utf-8?B?Nlc4ZlBtWCs1T0NMR3FWYk8yRDgvV3c1Y3RqcCtDalZCdUxRQ08yZFlncWFa?=
 =?utf-8?B?Y0t6bnUrNGVPQllJTUtVc3Y1bVZOTHJMY3hLQStXWWpSSHA4ME1PM2ZMTXph?=
 =?utf-8?B?SUcvbVFwUTJwWWlRaFJURlBzZ1E2UzRyaEp6bE1WMXBnL3Z0S3hMWGJvci9u?=
 =?utf-8?B?M1k1aWdDL2NYeEVjcG5uNi9zNDJjRWdtUWVxanlROW9iOFdJUWxMTnQxOHdq?=
 =?utf-8?B?YldzU1VoM25pQVRKc2VmeDZmNWpzUzV0WDlLQzlvYUZoUXZKQXdJU1kwZndS?=
 =?utf-8?B?aTJuRVRPaUUzUFhPU25qSktIOWhzZDlZWjNoWTFsTmxBRElJUFNyMlZTbHFq?=
 =?utf-8?B?TytoZ29jQW9KUW9LUy9GajJKNDlBL2h4UmdGRFd5TWt4UEZmUHNwL1AyNGtF?=
 =?utf-8?B?bjMwVzc2UVI5bTZJS0dyY0hYMjZ1RGJBYTlXdXRtMThvYTJLNFc1RlQ1TmM4?=
 =?utf-8?B?eXpnNWJacllzUW4xVXVCV2FWVjN0WHo3WmgrNG05ZE5MdkJ5Sk9aVGZjRGhC?=
 =?utf-8?B?TG5FamtOOUswN3U1R21wUHFPRU9ZQWk5Uk5maTF0aFkwWHlWMFl5K0JYNWM5?=
 =?utf-8?B?N05icXdoT2gzOVo3cm8yOEtiaGUyUDdmekVabzJ5OEl1ci9KMWRmYXBlMmZZ?=
 =?utf-8?B?QmlIb0U2M0Zwa3NCYUFOejhGcE1NakV0bHViRExoYXhvek5FbmJBRmNxMG1G?=
 =?utf-8?B?ckZtbVpXcFBWV3pwOHBEZ2RiR0xaKzViUmxjUVc3c3hqNG95VFpuSkpxZWlZ?=
 =?utf-8?B?WjFSNi9xdWpLbkVVdlVJcERkQUx2YytyWTYwUWtVcjhDeUQ3d29Majl5ZEVI?=
 =?utf-8?B?cXBFamZ5YlVqUEo5TVp2WG96SGc3ekJoMi9GenV5WGxqOHRmbEZ4QUVzQjJw?=
 =?utf-8?B?aDVvNU9ldTJ2R2d5L3l6NGc5MWxGaTlYNWdrYVB4NmV3ZXE5UkFYQ0pRWDVD?=
 =?utf-8?B?UlNaci9hYlF3NDMyd1pVUUpqRXZQNENQT016YUo2TnVjTFJkL3VKZW5oU1Rh?=
 =?utf-8?B?UERMeXc5SENIUGE0RXJ0RWc2VmQ3Slc3YS9qN1R2dWRlZTcxRHFDUTJMemlJ?=
 =?utf-8?B?RmxjVE1DNk1NTXpVblB5RlVjbUYwdTNGWEtndVlocnU1b0c4eFVvVjJNRndo?=
 =?utf-8?B?ekNhNFZPakNId2pjQU82MjAyU3REZlBQeWFrcG8wNlJoWE8yanM1WXBBeWZa?=
 =?utf-8?B?UmtJQzZ5SjM1b0pBNEoyR3dUSjhXcEZTWGl5RzZqUGN5QXNsRWJQQ09PZTNN?=
 =?utf-8?B?QytpM1BTMzQrS0djS2txUkszSFRWTTBOTGZmVGc0U0VqL3Bod0szejF1eU03?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ceb359-5a6d-4326-1ee9-08dbf1bb922a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 15:46:51.7580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2h8yTqxJKdw5U49dXIkFYGEljPGT/tLWr8JZknDmTId8y23tHe8Wz7tTqPVg84LwZssJjRMnjTMMa0+E88Es6UtGWOnlrB95Cu3qKAsKj/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4069
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.11.23 05:54, Adam Ford wrote:
> Since commit 8208181fe536 ("clk: imx: composite-8m:
> Add imx8m_divider_determine_rate") the lcdif controller has
> had the ability to set the lcdif_pixel rate which propagates
> up the tree and sets the video_pll1 rate automatically.
> 
> By setting this value low, it will force the recalculation of
> video_pll1 to the lowest rate needed by lcdif instead of
> dividing a larger clock down to the desired clock speed. This
> has the  advantage of being able to lower the video_pll1 rate
> from 594MHz to 148.5MHz when operating at 1080p. It can go even
> lower when operating at lower resolutions and refresh rates.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index a3dae114c20e..669fdd2c54e4 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -1131,7 +1131,7 @@ lcdif: lcdif@32e00000 {
>  				assigned-clock-parents = <&clk IMX8MM_VIDEO_PLL1_OUT>,
>  							 <&clk IMX8MM_SYS_PLL2_1000M>,
>  							 <&clk IMX8MM_SYS_PLL1_800M>;
> -				assigned-clock-rates = <594000000>, <500000000>, <200000000>;
> +				assigned-clock-rates = <24000000>, <500000000>, <200000000>;
>  				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>  				power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_LCDIF>;
>  				status = "disabled";

Thanks for the cleanup!

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron BL
i.MX8MM
