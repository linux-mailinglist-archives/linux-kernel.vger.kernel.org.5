Return-Path: <linux-kernel+bounces-29205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D193830AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266581C208F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2BC224C0;
	Wed, 17 Jan 2024 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kBFyqHfQ"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8D2219F6;
	Wed, 17 Jan 2024 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508394; cv=fail; b=iRgNIm9KIOgEB8SLzKIwQnvyfd6PAQEa5JJeqZeVTRrK6NkSGbA2sDD1qJ9ziedbGrginHVknRXkM4vFGT26b5GRuN7jrE2UheN8dWbV502YmhARw9SXLQyXyqDezvRGe3IzVDq1OEvFP1hirCL/QXYbQXFpmMJF03JI8iwaD5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508394; c=relaxed/simple;
	bh=PeQ6Sewlf+iQRqicOBbGuLujgjEcJv0BTGcOJEurp8I=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=IpgxKK/DsYIOQJg9R0zBZ/BMh4sn3ot7n/GV4c+/cJwK3JMES1KRRwDtg/nr9fQuIy1TsxT04FKg42g5vhFEKR+vVKrPfhjVna7UHcFiish1YTp/0/VHnVPtyEpm89BUZL42VErkh0Y4bvCZ6DzQULiGDfnp8z/TAbdnxery8s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kBFyqHfQ; arc=fail smtp.client-ip=40.107.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGn94ew9d2q/aJTtuLk8Ci7YwwSwCQGARyK3VMFweUqvkhHgZdIc0NYfgKGmGBF2hSONUDGZZ+mdnG0WQuimpXlmw564ifaRlrVJwN6oEzRlvX7FuKJfnlKxKj64NMn5a5ebN3SmSeSHwIB63mLpOOFtIf3fU+FtUFTibMd+ubS61+8EXSqkVxt60h6o0yj6XodFe2HI8OvFPxOAfrB2247cuIyPbxbSEgY6QzZcZCOyhdBSth+4q4RrPBR+0qnlQAvvyfcGA6weANo+ujxh6JrGVJZD7BKERvg1FE9fr0K+h1g44SYWkAOn+SRKh/SZ9J+rWpX69A0GgBeS9NYRuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSYDwtNEVULQuGaJJ6KMtyff8dMhyglgJe+jloBITX4=;
 b=BzeDIOLpy32973wCZOBk/TRM0X24CqMCJZisLQI6kyF3AxOh919KKOSvDU91bkgfjDGN6W+mj4W33zo69KBSxsrwTei5D+Iz1fzfXIyuiNvTw2UDEhfsYlmA6OUz4GRYJ//82v7sYTouKuX7u8hJKSWU6QMBa/FluyCz1eWhEmwCWjEh2u/Hl57Dgp8ZVQa5sAEpsm1Uj65E5N08edTm0gneoYnMTCYUfZvlAx7y26p4a9gbT2qP0g+7i1ExPlFAyLyEwX7uRJrwkugHJZCj59nxZA+ehpQKrJC+c0Y4AcN4rbVKJlyKrw4gCThyzs+scFfMK5N57qV+wJrv1/cb3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSYDwtNEVULQuGaJJ6KMtyff8dMhyglgJe+jloBITX4=;
 b=kBFyqHfQPp+GPqej2iuzRVI/rvqSBQhc8ayHsNsNnXmW9VkIYMlM+fkC63IKGZO/d7UMaHu498+HmnncNLSNngPlDZ1p2UjZA3LqGNQ67UDG8lBp4SgWKpuSDNySEQ2LM00e6JpK34mbdgYKzbxKcWZA5ex4BzeoTYh5kX9A3HA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9312.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 16:19:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 16:19:48 +0000
Date: Wed, 17 Jan 2024 11:19:38 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>, robh@kernel.org,
	alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	jirislaby@kernel.org, joe@perches.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, miquel.raynal@bootlin.com,
	zbigniew.lukwinski@linux.intel.com, devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 2/7] dt-bindings: i3c: svc: add compatible string i3c:
 silvaco,i3c-target-v1
Message-ID: <Zaf+Gn6rYstttnrA@lizhi-Precision-Tower-5810>
References: <20240116-achiness-thievish-10a12b3c08cd@wendy>
 <Zaa+cLGVVDSB5MYr@lizhi-Precision-Tower-5810>
 <20240116-retract-conclude-c47a7fc8cb21@spud>
 <ZabVSYgq1Mz3LPpC@lizhi-Precision-Tower-5810>
 <4a9ed1ca-cd13-4b61-af06-a3d7935aeeee@linaro.org>
 <ZabqxHD4wtiPn6ep@lizhi-Precision-Tower-5810>
 <c760b89c-efec-489e-8333-c60b38fb5a47@linaro.org>
 <e54e2b30-03e7-40e3-bb33-dc71de8511a4@linaro.org>
 <ZacCQ1Eysqq5FnA4@lizhi-Precision-Tower-5810>
 <ad44d51a-ba64-4a4b-bba9-205faa760c78@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad44d51a-ba64-4a4b-bba9-205faa760c78@linaro.org>
X-ClientProxiedBy: BYAPR07CA0100.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::41) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9312:EE_
X-MS-Office365-Filtering-Correlation-Id: 21676586-b295-46d8-af23-08dc1778201a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fx6KxTzz0zwkomlJ7+pL9DUMG+h/Gci4VUNJqBBhwSKPgA3WjGRA4a1fVlGv7WUJsLspIfCX95sZlGg7ZruYRelhRFmOGgxiaxJ8ecb2PQ5BkbIDZH7BoI7JFXCGi/69N+Hr/P7o5aFKCg806qy4Xu01q6qzIa4rzcgSpgcTkkx7nmdWSezlC18s+FET+A76pSZtcFP4YRLTAeutY8zM6KQmvf646QY4l1OxnURECWmS/nY2Z/xhg56DiKf61sFcFrHhYSUt8XKdGfUCCc5+T6m4dkNwZCBap6GntJ0LfrZbBWXZepsZ4mOx0ybVJra6Uat6uTY7a+58kDWmMSzo4ReA6cFtJRRcK4Nt2kal3JvVh+aZgn7Nb37K2Ust3S2ks9fFGiFzeMbVN69hL7QeEM/m0PkGi/K4yC3DMmKeAElnLGcBQDwFyzO8Qgqyhma5L74sB20lF/OwEtGqteI/eaQ06oga8LuFPJ0s+1k40hTidcFFR+g82FX4kbb4o8hGJyw5T8ndcUauwFjFKv6QVjs/G+LKf1D4iREyWwf13k+QC6YkGxcZdsG4oAs9SvflN0PglVOa3pkEbtgb8oTEdu53aDAktKD6brVtecc9+vDH966aUEo1KT8bC4JlYXM2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(8936002)(8676002)(4326008)(5660300002)(6916009)(7416002)(66946007)(66556008)(316002)(54906003)(2906002)(66476007)(26005)(86362001)(38350700005)(6486002)(52116002)(966005)(478600001)(6512007)(6506007)(6666004)(9686003)(53546011)(33716001)(41300700001)(38100700002)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HpsqXnvtPDiv1GgPtCEgG0rnwv+0V+sIPBdYtyJWo4sLPVUMRZ0kWSMWxFcT?=
 =?us-ascii?Q?xEyYUoKQ7/2E7ovlxQcx606Omfz0f6NalR52fMZEkwIh2D2bfMfq9K4kKOpm?=
 =?us-ascii?Q?+iG8qKdizxxDJR3Xo9wzHrYLQEl+Q7HYjdM2xGYW6ZyX/8Aco2Ub4dvwUSu7?=
 =?us-ascii?Q?nshCczu94BTdkTFp71YIbU3LxkcyqjjzmjxnpXyROQubJZKs3YgIjwmG64U1?=
 =?us-ascii?Q?EKdHNSvDGRmBWXlYcnyKYMa1Y0Z4gZT0C5UmhUFwaG7O4hRidCzWArgKqBuP?=
 =?us-ascii?Q?6dqE/vWXNZzn1KUZ6OPjXt4A1XfAKKNJKTAnYzlKIHNhM1PO714W0kpGZBRD?=
 =?us-ascii?Q?AVh/ZJpW0gOFuVtF1ZR0exdiJJko8BkMROYaj/PJUf4FyM1XB0U64TjAY+EB?=
 =?us-ascii?Q?HtCKgl+/+890na0eK7X97llykC/YStkmtMf7jL8HGlrM5eMOgyCGehCarqO7?=
 =?us-ascii?Q?K6HYac9YhDksjESUFguMFjhCLbaU0XJxIfYl86nhrR5TWkwxoCm2jhNrduV2?=
 =?us-ascii?Q?DsuyEyFq62Lgk/WCJyWNweAmwFo34O44m0Dn3/vD48aqlGtzoTwDviCa18uc?=
 =?us-ascii?Q?Pwl/ASzuUOLTosK5Wy5d34x8CflmDc/sMw4cIT728YnQBOlGClJAXqVtF+zx?=
 =?us-ascii?Q?LRlp1p+y4Q89m9pn89HCzeLnZdsGhYAodoNkFUsdMxk7eFYPbTZY7sUPML42?=
 =?us-ascii?Q?qiQwzxfcKKt/GXCj3DOjOOU9InnSlEOnW6TWKJw0dykd2FOzaMM9C2fCkHo2?=
 =?us-ascii?Q?8Nhd9aARXy/mEDs/fNUvFG1TyjCCRUmj4rZvx2+e7/4SxsYWctKp+J5wHOu6?=
 =?us-ascii?Q?z8FsJB4ttuoh+VWc9pgoMvMNtDB64STyzMqTwYRItlgz4VSKLB4zRc0tOt8i?=
 =?us-ascii?Q?6KdXTvuYlckKzw46Zk5mVGGBmvOJf9IXGT8m+dK9YZgd9taF/1GRG5gI7myT?=
 =?us-ascii?Q?InSv7Jcj3Ptwf6YTxKlxvwQTBnqSg8MvwbYCl7kIFuBjaIMaNJWYJqb1FEdC?=
 =?us-ascii?Q?kJods3tCr0tm4wjqDWfvNMFsV8j/qCDOA7M5Nl0+5c2qwVPSLYsINUwU8dVl?=
 =?us-ascii?Q?tIxJDw4pfQ98v7knQpzSg4XYB9gtkee7pOQYW6gigdoUODkwLr9WSxRN/9Ba?=
 =?us-ascii?Q?rHHWWIBlViCwwRGtChc8Q/RmSJ6ZDNwoQni3yzlxRLZYz41JUPARiXHXVgNY?=
 =?us-ascii?Q?+DjZdSVCUGoXz1BdiHqhCYetm6aYdGzeJuYKHnXBqVNn4p1eyk72tS0H6Slm?=
 =?us-ascii?Q?bTVbimmOgZOUs+U+elDI3bFsKor8HEuF1Z1OwGVrXOcP38HzrB5Aa35NHHhJ?=
 =?us-ascii?Q?xFA/C7jvJ3BlrxRZd9nvpSBm3o52YyfZctdLl3OP50Y7EEYfjxJLYaQpNCJE?=
 =?us-ascii?Q?xXvtp7LGH9E7QFdGxKTI/6laVVPXFF4UT7uYxW5i8IJXzA3x/ofPs5iZPiB0?=
 =?us-ascii?Q?2Wi5vgD9Y+WcmnVlYqjuWfxeWHY13nOyaQ1w30INRSxQgyasfRZhAV2M4Br/?=
 =?us-ascii?Q?ZXZpBoo/5s6QnMgXn2uxNyTp7nmEq0GUZrRGbVpZqzvNfnVR9wQ26LzBFcW6?=
 =?us-ascii?Q?2VIRbtlmttLtvemDPxgbvRYkqTaJsRZDU1XgoxqF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21676586-b295-46d8-af23-08dc1778201a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 16:19:48.5458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRYuF7NTP0u+/ZrdDiEp9yjuYyHZTf/s3W6CssqOLgEWlfbDCcBO5ZfkMG09WQDVa3seWiu+ZjLWmtZeEo46cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9312

On Wed, Jan 17, 2024 at 07:50:16AM +0100, Krzysztof Kozlowski wrote:
> On 16/01/2024 23:25, Frank Li wrote:
> > On Tue, Jan 16, 2024 at 10:01:42PM +0100, Krzysztof Kozlowski wrote:
> >> On 16/01/2024 21:56, Krzysztof Kozlowski wrote:
> >>> On 16/01/2024 21:44, Frank Li wrote:
> >>>> On Tue, Jan 16, 2024 at 09:30:24PM +0100, Krzysztof Kozlowski wrote:
> >>>>> On 16/01/2024 20:13, Frank Li wrote:
> >>>>>> On Tue, Jan 16, 2024 at 06:23:09PM +0000, Conor Dooley wrote:
> >>>>>>> On Tue, Jan 16, 2024 at 12:35:44PM -0500, Frank Li wrote:
> >>>>>>>> On Tue, Jan 16, 2024 at 09:48:08AM +0000, Conor Dooley wrote:
> >>>>>>>>> On Tue, Jan 16, 2024 at 10:33:48AM +0100, Krzysztof Kozlowski wrote:
> >>>>>>>>>> On 16/01/2024 10:30, Conor Dooley wrote:
> >>>>>>>>>>> On Tue, Jan 16, 2024 at 08:24:20AM +0100, Krzysztof Kozlowski wrote:
> >>>>>>>>>>>> On 16/01/2024 03:29, Frank Li wrote:
> >>>>>>>>>>>>>>> 	Patches were accepted after discussion, what you ponit to. So I
> >>>>>>>>>>>>>>> think everyone agree on the name 'silvaco,i3c-master-v1'.
> >>>>>>>>>>>>>>> 	I plan send next version to fix auto build error. Any additional
> >>>>>>>>>>>>>>> comments about this?
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> I still do not see how did you address Rob's comment and his point is
> >>>>>>>>>>>>>> valid. You just did not reply to it.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> See https://lore.kernel.org/imx/ZXCiaKfMYYShoiXK@lizhi-Precision-Tower-5810/
> >>>>>>>>>>>>
> >>>>>>>>>>>> First of all, that's not the answer to Rob's email, but some other
> >>>>>>>>>>>> thread which is 99% ignored by Rob (unless he has filters for
> >>>>>>>>>>>> "@Rob"...). Therefore no, it does not count as valid answer.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Second, explanation does not make sense. There is no argument granting
> >>>>>>>>>>>> you exception from SoC specific compatibles.
> >>>>>>>>>>>
> >>>>>>>>>>> The patch could have been applied two months ago had Frank done as
> >>>>>>>>>>> was requested (multiple times). I don't understand the resistance
> >>>>>>>>>>> towards doing so given the process has taken way way longer as a result.
> >>>>>>>>>>
> >>>>>>>>>> I think that Rob's comment was just skipped and original master binding
> >>>>>>>>>> was merged without addressing it. I don't want to repeat the same
> >>>>>>>>>> process for the "target". Indeed I could point this earlier... if I only
> >>>>>>>>>> knew that Rob pointed out that issue.
> >>>>>>>>>
> >>>>>>>>> Oh I think I got confused here. The context for this mail led me to
> >>>>>>>>> think that this was still trying to push the i3c-master-v1 stuff through
> >>>>>>>>> and I was commenting on my frustration with the resistance to applying
> >>>>>>>>> the feedback received. I didn't realise that this was for another
> >>>>>>>>> patch adding a target.
> >>>>>>>>>
> >>>>>>>>> I think you already said it, but NAK to adding any more compatibles here
> >>>>>>>>> until the soc-specific compatible that was asked for for the imx93 is
> >>>>>>>>> added.
> >>>>>>>>
> >>>>>>>> Is it okay for 'silvaco,i3c-target-imx93'?
> >>>>>
> >>>>> No, because imx93 is product of NXP, not Silvaco.
> >>>>>
> >>>>> You need regular SoC-block compatibles, just like we have for all other
> >>>>> snps, dwc and cdns.
> >>>>
> >>>> "nxp,imx93-svc-i3c-target" ? 
> >>>
> >>> Could be, now please point me to patch adding such code to DTS. I would
> >>> like to see the real use case for it.
> >>
> >> Probably I was not clear enough, so let's be more precise: I think you
> >> might have troubles pointing to such code, because it just does not
> >> exist. It is a bit contradicting to single hardware description, because
> >> you want to describe one hardware in two different ways, with two
> >> different compatibles.
> >>
> >> Your commit msg is here empty - it says what  patch is does, which is
> >> obvious. Tells nothing about the hardware being described here, which
> >> does not help this discussion. This would need solving as well, but main
> >> point stays - don't add new compatibles for the same hardware, at least
> >> not without valid reason/explanation.
> > 
> > I can improve commt msg. It was similar PCI case (There are two work mode:
> > root complex and endpoint). So there are two kind compatible string for it.
> > 
> > If you think it is good for using two compatible string for two work mode
> > of the same hardware.
> 
> Not really, because compatible describes hardware and it is the same
> hardware here. We do not have two different compatibles for GPIOs being
> input or output.  Or two different compatibles for serial engines (ones
> providing UART, SPI or I2C).

GPIO and UART is simple. Actuall SPI and I2C have two mode, slave and
master. Many SPI/I2C is dual mode controller. Just seldom use slave mode
at linux side. So you just see master mode SPI/I2C controller in dt-binding
and dts file. So few people upstream slave part to linux kernel community.
They have the exact same problems if support slave mode.

PCI is typical example: 
EP mode:  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
RC mode:  Documentation/devicetree/bindings/pci/qcom,pcie.yaml

Which is the same hardware for two difference compatible string.
> 
> > 
> > I can write git commit message like:
> > 
> > dt-bindings: i3c: svc: add compatible string nxp,imx93-svc-i3c-target
> > 
> > silvaco i3c controller is dual mode controller, which can work as master
> > and target mode. All clock, reg, irq are the same for both mode. Add
> > compatible string "nxp,imx93-svc-i3c-target" to let silivaco i3c
> > controller work as target mode.
> > 
> > Of course, alternate method to added a property "mode" to distingiush
> > master and target mode. but old "silvaco,i3c-master-v1" will actually work
> > as dual mode support. Driver structure will become complex.
> 
> Please send full DTS of user for this, which works for 100%, so we can
> see how it differs from controller mode. If your code snippet from other
> thread is correct, then it would suggest "mode" property or lack of
> children. Maybe lack of children is not enough, if user-space could
> control I3C bus.

According to current implment, only need change imx93.dtsi's @i3c1's 
compatible string to "silvaco,i3c-target-v1". I attached imx93 dts node for
your reference.

	i3c1: i3c-master@44330000 {                        
                                compatible = "silvaco,i3c-master-v1"; 
					     ^^^^ only need change here!
   
                                reg = <0x44330000 0x10000>;                
                                interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
                                #address-cells = <3>;                      
                                #size-cells = <0>;                         
                                clocks = <&clk IMX93_CLK_BUS_AON>,         
                                         <&clk IMX93_CLK_I3C1_GATE>,       
                                         <&clk IMX93_CLK_I3C1_SLOW>;       
                                clock-names = "pclk", "fast_clk", "slow_clk";
                                dmas = <&edma1 6 0 1>, <&edma1 5 0 0>;     
                                dma-names = "rx", "tx";                    
                                status = "disabled";                       
                        }; 

For master mode:
Unlike i2c. Genenally I3C can auto probe children node like USB can auto
detect attached devices. So I3C master can work without children nodes.
Such as auto load i3c sensor driver according to i3c standard vendor id and
production id.

For target mode: using configfs to controller I3C.

mkdir /sys/kernel/config/i3c_target/functions/tty/t
echo 0x011b > /sys/kernel/config/i3c_target/functions/tty/t/vendor_id
echo 0x1000 > /sys/kernel/config/i3c_target/functions/tty/t/part_id
echo 0x6 > /sys/kernel/config/i3c_target/functions/tty/t/bcr

ln -s /sys/kernel/config/i3c_target/functions/tty/t /sys/kernel/config/i3c_target/controllers/44330000.i3c-master/

Then you echo test >/dev/ttySI3C0.

Unlike USB, user can switch host and gadget mode dymatically. Suppose I3C
only work on one of master or slave mode only, which is static.

Although it is one hardware, I think it is exculsive multi function device.

Summary: basice two option to distingiush controller and target mode.
1. by "compatible" string
2. by "mode"

I think 1 is relatively simple and easy to understand.

> 
> Best regards,
> Krzysztof
> 

