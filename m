Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80BF7A8EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 23:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjITVnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 17:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjITVnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:43:09 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ECC9E;
        Wed, 20 Sep 2023 14:43:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoB6q/FgMtpUtJEOfJovegNyGnzUkOWj6T1LUjUX/TVPjNDjUagthbpGL62zfAYGE2T7n5Zk+iUxaN8HepYLaIMzm0caqDQCet6m7T9wX7uSciDCukwnDMXfn3r06bcwrfQSCORlzyh24VP3VrM7VC8CvIsl1pQvxMKh5yc3gDeN59RrdNUgXplABLJWyiyJJu+LHtNX9B2jSLeRKMGLR221JliOHR4U1GrF47sZXux3AOvf4eJ02JAZ4lZqOEal5opsSvhgl7Snu18zq8bxxjc0On9+otfG7GC9tJmbM8wiA2gxmbEgNzK71bkGd6/7qH91ehvPEb0XMHFDdzIrZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FavoNDOxrg0VjL88ARTrB1Z0fYYaeF10CNTXCxFi19Y=;
 b=ZUfdeY+jt1L0oCJQM9WSrOJNttYoofA1pumi/gJua5XCGFfRVkzoN/BZ33yswQ11KChablg6RSMX+VU36z/Sj1fCQdB9NfLwlG2WPer9qrFY0p2S1YRClZkXA+fDMqWEWWN/lg77KfbMVQIu62FMUrgc1k+xrR9vkk85Tfqg6yNL60wP3C00bd0P0Sfn5OYrfovZesmVTl4SKn6tV+7Ot+o8z3l2SwqQrCAmq/tSCiA4Muzwu4DRMdi+IGGo32Ly0WNwpNR3uZWuiF0EyIwGS7uMPfdkGgA8CjbCYQbW2FDx9A2aBN6z6TsRDgwcAnvn3s73V6ZIZSLV2QErMmOF1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FavoNDOxrg0VjL88ARTrB1Z0fYYaeF10CNTXCxFi19Y=;
 b=KTH27IUKbQUzvFPcrpkWEzBGGUE31qAfUbs3y9YfsL+ynY75DefmS9GJ14TTK0ba5g5+8j2E7jpKx3gyszhpkA0x1TNvY2a0HbjzzxMKhP/J/4c3GqBavqpPedOqCVhNxiEjPgUSEplhJ47wIF3BtL5//Edj922NA+YHjP+c0VE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM7PR04MB7158.eurprd04.prod.outlook.com (2603:10a6:20b:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 21:43:01 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 21:43:01 +0000
Date:   Wed, 20 Sep 2023 17:42:50 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     festevam@gmail.com
Cc:     clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, imx@lists.linux.dev, joy.zou@nxp.com,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        pierre.gondois@arm.com, robh+dt@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org, shenwei.wang@nxp.com, sherry.sun@nxp.com
Subject: Re: [PATCH v3 0/3] arm: dts: imx93: add edmav3 support
Message-ID: <ZQtnWvTXlI5i7u4G@lizhi-Precision-Tower-5810>
References: <20230824165753.2953431-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824165753.2953431-1-Frank.Li@nxp.com>
X-ClientProxiedBy: BYAPR11CA0092.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::33) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM7PR04MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 841a0404-820a-473f-8be5-08dbba228ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qnA/ZGrayBGmcloeAhPJK7BoLjn+y7srI7OpsVETT0Cd+rOHi/IYs0Sw7Lf4MJ7cvfwH/FyVXLKpwQ72L/G9XZ4JbE80RnjEdWh2bIzfrSicbsz3bWzWQYoA9guEKXO7dON1edN1TYZa0agFVwwhQtvtyX+8Nv2DgD6X+JDSso+a/YVE1DN87AJvDViUefEEtt3YJkAIpcrnzoNFvPF8d6CNKcH9HepIiRLCZ4eFGtf1djTHbEkCto3pbWLB+QL2xRY4TyquxX/yXi4pG/b/+8E7F/CnQ44zUnMCjALYPqsE0W9EWb9TRhDkxDFP/pL+NNQt/gbj7S+sBZpjlA2nrvRFMd4yX7G56hewKxCy6FsCQt1g0Xtp+X/PlYNBGCidHlpoULfgwpctY+uLqwMYXqfIg8Om/y/bFfk+Y1uujtxv3OfKpy2oVw5A34bw5LOUwFePKRIERc9ippDRUfQAH2XNIxJ/JdfOtdsqC9PVh+neKlfWRxqBlER/z5KSexLrNSKO0YazR4QH7SUfO25W5g5WslNsebFNvhWB5fSossGrQRwQXlXKB2IX6jbuqb8pRIH4/2zBIxpYxd7Q2iofV1bmIf3fN3UV0mtfLf2zFkQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(39860400002)(396003)(376002)(346002)(1800799009)(186009)(451199024)(9686003)(6486002)(52116002)(6666004)(478600001)(6512007)(6506007)(8936002)(8676002)(66476007)(66946007)(66556008)(966005)(316002)(6916009)(5660300002)(38350700002)(86362001)(38100700002)(4326008)(4744005)(7416002)(2906002)(26005)(41300700001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?74CNDYydMJrOkcvYx2k+6t5q49Wq2yANNbC20t3htJl3mf3lB1z/meMB2icC?=
 =?us-ascii?Q?89oHjiKWSqEcIl96U6Rxa8aPYL/C1/SeRFxFFUSoEPIwSfTkI1u8T32OA5UF?=
 =?us-ascii?Q?dNX5dHf5hZjbo+1hAJDixm7K1pd1MIHgJWkHedsZCuQSGCxTjZeFiRBRnC78?=
 =?us-ascii?Q?sGYwOJB52wMFMl1CHX6fB31u7l87Z29nxqVkvCOPVe59XjY63ushrtxDyqtu?=
 =?us-ascii?Q?mjKuEKZiq8A5Wl16l0xtsZ9PTEabCAPVKxwtlljnIVASFhHDZ4wGtKDo+HoM?=
 =?us-ascii?Q?ny4m2tbNHWg0a/vNUXNmyltJVDEZyFFPhfdHE+erFPF80ydV52Ck/ezI7eHJ?=
 =?us-ascii?Q?cWR5+rkb82sSbU5YMoJFDvWNUoDKxWdnF65M12hm86UgIT8eKU3J6hv5W1vM?=
 =?us-ascii?Q?nDCVFGGWjusc1832rEx9CN4O9PZMUhxxE5DcyL7VxZzHtWhRr/Nqngpg5aWO?=
 =?us-ascii?Q?fE1n8u1Vsl9nFp64vGADDusI3QtAb97Xmmfj+6ypDC06mi9hxjubXpmWQqzR?=
 =?us-ascii?Q?c7vVmPIS6ercTfi06dPImajlc62isCi3bESTQ8QSih6olBgB2mqZsCB2vBBz?=
 =?us-ascii?Q?r/rFOHiFWISrkv5Z/k56M9i1P+WNRXRasxN0tukauZ20oADkXEnYw9JogJvJ?=
 =?us-ascii?Q?NhM65jmlQgN+vElVBQe8RMr7YQbNCd7lE8eOztHMiTEU6Ce0R2VxtuG1vRNh?=
 =?us-ascii?Q?nHrN56JsqqCGkC0HSkGINZNQm5jpBQEP+uN0NtCK2JR+0IgP7rUJET4kf+uX?=
 =?us-ascii?Q?u3p4JPKih3QMbPd3CHGtYCCoyuHjnWbBz85SWNAHBEadaDNL5gUiFvASOy6j?=
 =?us-ascii?Q?ztsqURj0aUaCgpAUMCrlA9VfGxOy1l19jsoNCHjZT2qxO3mng/XaHX9etwCx?=
 =?us-ascii?Q?DD6R7zs0gSqfpNr+oHMGq421FfLQdzfuX7+4U4nNFnHrvMlyWgqDwAOBA6mP?=
 =?us-ascii?Q?QGUExZwdv9jYmlSVNkoniVUVMCn8O6VffwmixYLkO7PZLF5sM0n98vRLZbP2?=
 =?us-ascii?Q?507fh1XJbh4h5Y4K6DfTeCRGMF4dh5nu0ukfCNBu/USBIa2oIuidgSnl+2i6?=
 =?us-ascii?Q?bjMy9iGU/7q+LQtiyXRErewaGIWjtXOpGFuMMZJ2NF5SC/dHaxDibFP7rF9i?=
 =?us-ascii?Q?/MJLer2CqRwzSsS7utv3vXSBjCb+b7A9+/WBDPRImL7j/Hw4xSTctJ8ePjeN?=
 =?us-ascii?Q?wqTSY+xlexOgZM4Jg/KCX65W4B9HrSwipo4Kt82G8Z75EoBiLg8YowcCrg5w?=
 =?us-ascii?Q?VrHfp/ZrDVqBNGYF2F+WIeXnmgTALHDQDji7GYN4SMNt/MZ6r9sXjJ0XXe61?=
 =?us-ascii?Q?1XUDplg57ICZPYEar2+bibSWZdPkzR0bTqxmWkDpTwfYECjf9K4QWhSCFxtx?=
 =?us-ascii?Q?/Qnhzh39h92hFsAjL+t1Xe3VEIG+PNRqQHdrTSSymxf55NU+qmaqYzr7x63x?=
 =?us-ascii?Q?NyIYH18j2kH2kj3+zhhj4bZrfw2kPLSrlKRl+nJYD5Nrg4DyJZUXz/knu7yF?=
 =?us-ascii?Q?b0DiSqOyasy8OHeIYdxwyDlKpacvcI3KL6QVkdvZ+I4aM5RYaYiYZ8Yo+LjU?=
 =?us-ascii?Q?eaOl7IK9gObLwdKdHfyoMXnrF/EpsiH9Kj5TdARF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841a0404-820a-473f-8be5-08dbba228ff2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 21:43:01.1862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EocrU1TrPuFmgTCy8MXD1gpCCQrf8kx96GbOt/51woYjE+ARMTsYDodmaaPxIYLx71wYr0Zc1ajaiotBRHXykQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7158
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 12:57:50PM -0400, Frank Li wrote:
> edmav3 patch already accepted.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/log/?h=next
> 
> Add dts part for imx93
> 
> Change from v2 to v3
> - fixed Krzysztof's comments
> - drop unused fsl,edma-axi

@shawn:
	ping?

Frank

> 
> Change from v1 to v2
> - Enable UART1 also, lpuart driver will disable dma when it is console
> 
> Frank Li (3):
>   arm64: dts: imx93: add edma1 and edma2
>   arm64: dts: imx93: add dma support for lpuart[1..8]
>   arm64: dts: imx93-evk: add uart5
> 
>  .../boot/dts/freescale/imx93-11x11-evk.dts    |  15 ++
>  arch/arm64/boot/dts/freescale/imx93.dtsi      | 130 ++++++++++++++++++
>  2 files changed, 145 insertions(+)
> 
> -- 
> 2.34.1
> 
