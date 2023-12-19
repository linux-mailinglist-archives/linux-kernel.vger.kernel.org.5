Return-Path: <linux-kernel+bounces-5559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A95F818C38
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756821F258D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D886200C4;
	Tue, 19 Dec 2023 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QmwXdk8X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4301F939
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7+k4ypdff44O8F+hZfZtJkgmC4IOp/qY1KXqL45sr/k3RCwueKFMEQD5eUHqsuYdSpPx1ZyMGbhQmBDLZ2gNWf5PcZeKC5aO3SH6Uqxyjz4hyN9AP1GQIh/y5v7889rpWLyXKBSqZSMPS75vW3NJuJjvsKmddSCl81eIr3okdjq6lb8bzYE1wQz6LlVjeCk3KacCBkADA7EowrtYvgyRqSG5/oGT82VuGsBhHVYQKZaomM7PaeXa8atkx7OPRNbxgMnpnrub+cSDzzQoIuMj2GH+Evy24eMU8J2jQRNF6vzCfVKDSmEfNOFZ867Yqd8Z5NbSwhoBuzK57MBQKNjWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gviysMBbJbiLlKpA/n/5n4I8XkZu8ZAjXIIiyk6fz6U=;
 b=WQPYoP5p8AYdTw/BgfVqLxznDfYBggkk0Wq3aMBTFlVyjUBnZk4vOdV14XzPp8GzEPZi73P5X2DZFftuR0SfsZO15jWyVGi7Z0VT2RIrtiJbscobV5Dsrl/A3M2e2OBx2qXWeFS2MTXgC+1nEHgdcgnzU05CirQyoMoLiKr+KxPHtImzfTvxEvNGw/qo3Fnyic8Gm2Izye3k/XFLo1R5WuFqdMnZUA7q9LIu4AODDtAbd/YwNBTAdzIFAn65Qti7kOKwCNYLchJ3bw/3igdJm1Rp2X94UnqAadJqTthUprQlQ6z0v6sKQLi3HNjd9kDFxVi0xfX3qJpa1KnE5963xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gviysMBbJbiLlKpA/n/5n4I8XkZu8ZAjXIIiyk6fz6U=;
 b=QmwXdk8XpVNpcq7YnB94Y/cxUXMtzyQquUzR+zcb/CT/AL5RokkVZuJTxAlsckuWmpm5ctMcISf8e61GSHP8Co/5DeX29UM6m7zJiZoYyMBL1ThS6GWjfPvpXGxG7h1Uyk4Em+nDBb+kURDAq1a4H4CkHiUts9Mv/gmmJ4jGgCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7887.eurprd04.prod.outlook.com (2603:10a6:102:c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 16:29:38 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 16:29:38 +0000
Date: Tue, 19 Dec 2023 11:29:22 -0500
From: Frank Li <Frank.li@nxp.com>
To: miquel.raynal@bootlin.com
Cc: alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
	imx@lists.linux.dev, joe@perches.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, zbigniew.lukwinski@linux.intel.com
Subject: Re: [v5 resend 0/6] i3c: master: some improvment for i3c master
Message-ID: <ZYHE4rl7snpYJPSy@lizhi-Precision-Tower-5810>
References: <20231201222532.2431484-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201222532.2431484-1-Frank.Li@nxp.com>
X-ClientProxiedBy: CH0PR04CA0065.namprd04.prod.outlook.com
 (2603:10b6:610:74::10) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: 4480ddd4-897b-478a-d3c8-08dc00afb198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YbvmHuAoWJ4WOPQBNQTEHeuYO0/SusDbzglgzp3ymTQxcrKu7PqBQHA2Rij7lqoEv13WATJ8xhLpf45YIixMuCRkRVrvUHi8Xd+iPWCiNLkk+S0wIhIrgdV60dDpoHI/HX05HTwoSBkQZn+YtwzWe0Pk5D8+ft3UffElPpDspqJe279zTfHG38wib2xzPIlz00aAvHZJaIPilFi5N1zPVtcZQxQ/AV3fnmC7dlZtFRf1n9Psbia2fElsVv43I1GlA7Et5lMfCj0I6SwbEfn5KvIqaBFeZ+is7BJuRg1IjMh9xcUfNXmHpJ7LOzt5h5TZnm2CPYYO+DsKsEVOrGoSep63b10qadQwZteGwOfnM60+dXKHnrA7TgVVeAjXa0np84pDqqdysE74j6Qi4Woaj4Yo+y34IFyRX7K3+nrvAy7D2FAM8JxCbv7ZYpuvTGwsX2CY3ji9dB95tN8lOWkxC1HnkEa9HDV9tjfpNhhB5k5CuMuLUrHjrWIjxQtM7CG7c7C7X+Tw6GQMiV9ZIpCGQzZw1KwsmuhYPZyVZ0aknDNQ202wxvf75mFfGe7fpF8+PXe6keKMN5bC5JFHTQ5bnsRJYQN+sQgHoUxciXrpKlvkNQaDOwPwIH33nqGXHuUSlblmwNlFfEbvm4pGy3bw+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(38350700005)(26005)(6666004)(2906002)(478600001)(6506007)(9686003)(4326008)(8936002)(6512007)(316002)(66476007)(66556008)(6916009)(52116002)(8676002)(66946007)(38100700002)(6486002)(5660300002)(33716001)(41300700001)(86362001)(83380400001)(42413004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vn2B++bh56ooYQMziG7u6Fn+4gbjKZKOpSHFjfIoiwXGIUqtMbPUrC93X1Ty?=
 =?us-ascii?Q?KQZKwaEm91aKt3dUETROsfrUc5GYQo+urNBCDUO7SzgoeWckl7c7Vg1xRdrx?=
 =?us-ascii?Q?XV/Y4v8l2wQJOr0RxkkgnOzxdGSyATdwyic962KB1jKy7lH6VPJCLQKRF6w9?=
 =?us-ascii?Q?65SgFVarxzF/nr1dtlk2sMrQmt9pYV/rh7RUvkxnR59cb+JsVazmBwgFKE/2?=
 =?us-ascii?Q?OxFSCQwQZQ7Dot/9EA9gWdjuFLtkV/lvb0HTPZQC7iCaRkLoHseswQZfruJ5?=
 =?us-ascii?Q?cSKpLZ3xcntn9OGnvUCdIOAl/LOvYsZ9XEEsaDDJzTpY3Q3wkOvABVEqrs/P?=
 =?us-ascii?Q?w4+O8NjAm7HCnfUmiF/VS9u9Uh1B6eAKNvNZAQ34L/LWUPZ6hGEsLf96xEaL?=
 =?us-ascii?Q?QosF3w3Xr7BOf91Qt0FeGGgOk+ZjmsjGK06q4yvGkyAdR8KCLy5JT4UtVV0K?=
 =?us-ascii?Q?jCS74jXiq94HFCd5Aqr3VYJWEpOvMDyH14p6k6MUrGWfVKxyIUtDS55aE/wS?=
 =?us-ascii?Q?MyyLef+BsXdtFs04lsceccZKB5DW2MSIEALSt6CGwkntElhc6ckCduwDd22R?=
 =?us-ascii?Q?Niy+Z+FcwRPeNHEfU42mYUZ4U1jSViTKhBh3mPn6FqCkr/4XLOSKwv9OyS+d?=
 =?us-ascii?Q?3j7KjXnt6ylAmj2voIn9Us3lmMFIppRmzK2BIAiA51LQcF0yKCP+IhYZmv8q?=
 =?us-ascii?Q?18DAHVWs6tBTfCTGH2NjWVGDcmbwkJA1ONORhGzbIZsWJaiiDfIxPycIIz+q?=
 =?us-ascii?Q?3lAwaA3Jqja33M4HsD3qZsTK9/wknOD3Dg2aXC2HbrYwmPShOgdft2droWK9?=
 =?us-ascii?Q?0deFHwprrkr+WqXVEBRzbaVIZuhseIk1QfWlGQd3KtpDCxUAGYoL2v0kX5ac?=
 =?us-ascii?Q?a8pY6K5hEbCsZH1niRAZuEW4xACtNvlL7mI6izZkUPAO4k/0U/C7DWOI0iM6?=
 =?us-ascii?Q?Vn+LfBbbgiQRt9MdSkwuc2asg2XHD+3BPC1s3qYrplC/7ezrLMeADB0Z2h5S?=
 =?us-ascii?Q?3dmMDcSCdl9y93phdVlQqBoLroflFfzWHhOx3OvtsF4iLc3me0iJkfdx+i2b?=
 =?us-ascii?Q?kg8XWSfhcD3TrMgisXjCICB+TBf8MuxGbV9Pv+LyVVqpZnXxDFrP5cX3dxM4?=
 =?us-ascii?Q?6bfccCTXzOxPHWmHKgy+N/Zb8C1wwa0gRLk9Ed0CEjte6NdHDTOZeWtTtGps?=
 =?us-ascii?Q?E6MQjsoK4qtw+z5RT2YtJtjh/+I60jk5JA5utEhenGgpk9wmKSRlmZWUlmpL?=
 =?us-ascii?Q?4i5OZYjNHVWdJfqFFWjrG231ZHI6tsA/maUGuLNANdmrnpec9M6qPlfpy0e+?=
 =?us-ascii?Q?uG0o/RSIX6wZSA/tqO3c8HuNaH98rZarlQA2ZmWh5ot/2dnqai/92GBibIRj?=
 =?us-ascii?Q?EcZ811TIprd383CNda9mwz+7II4TN0BE4jKST3qh2zzqB1CFc2FqxAshGJLV?=
 =?us-ascii?Q?LNen+npltp//aJEUk4NJaOEIV9/k9rGf+Cq2H2tr3EsZeKp1OJ/vE6gisIMb?=
 =?us-ascii?Q?pWWOjNoBLLJpDBcBLt2Aj3QEsUNEc4vmNEDRTiRpPl1kWqtsVF+xAtDJyyRc?=
 =?us-ascii?Q?6YFRIcx2pr5S7vSUvhQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4480ddd4-897b-478a-d3c8-08dc00afb198
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 16:29:38.0111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSxdcyFJuv6ghoSdtpOy9E1PN/gHuZJXE1fieHLSPTx3TYf7knb6RNAfFZz/B4Xa8fMM2O24y2dpqjHWF/OFPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7887

On Fri, Dec 01, 2023 at 05:25:26PM -0500, Frank Li wrote:
> There are three major improvement
> 
> 1. Add actual size in i3c_transfer because i3c allow target early termiate
> transfer.
> 2. Add API for i3c_dev_gettstatus_format1 for i3c comand GET_STATUS.
> 3. svc master support hotjoin

Friendly ping. Any addtional comment about these patches?

Frank LI

> 
> Change log see each patches
> 
> Frank Li (6):
>   i3c: master: add enable(disable) hot join in sys entry
>   i3c: master: svc: add hot join support
>   i3c: add actual_len in i3c_priv_xfer
>   i3c: master: svc: rename read_len as actual_len
>   i3c: master: svc: return actual transfer data len
>   i3c: add API i3c_dev_gettstatus_format1() to get target device status
> 
>  drivers/i3c/device.c                |  24 ++++++
>  drivers/i3c/internals.h             |   1 +
>  drivers/i3c/master.c                | 109 ++++++++++++++++++++++++++++
>  drivers/i3c/master/svc-i3c-master.c |  95 +++++++++++++++++++-----
>  include/linux/i3c/device.h          |   3 +
>  include/linux/i3c/master.h          |   5 ++
>  6 files changed, 220 insertions(+), 17 deletions(-)
> 
> -- 
> 2.34.1
> 

