Return-Path: <linux-kernel+bounces-28306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 786F882FCC7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA95D1F2D5B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AAD35293;
	Tue, 16 Jan 2024 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a6YyNgL3"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8FC321B9;
	Tue, 16 Jan 2024 21:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705440696; cv=fail; b=cbvDsEouS/aAh3fhDX+jrK6pHrumXJUiorCn1Tv7OufYj7DphtyorvuJNw9wCbR40biqfz8wm4sHREJZCjYCnkjs1Kd2ighjSdEObE72I+z4+l9w9rI+nGXeLIGsFgJYtt/d9Az9Ib6U7JM4JitQnNJe9n39gyOsHYEIjx/LPNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705440696; c=relaxed/simple;
	bh=q/Zp2P2YMM80FvOslMjjcAyQu4VkqA4rWeTrmTh6o+Q=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=oVjA0OvMnnhW5KsCoXusipeIMaZbD8UNubDUIp9onnt8rzuWwm2H4UkpLHGiLZbY7fSJ6rlDWQGls3U7Q0glW6jpgSQqzgaqT4ALj9LV2DOoT0psh5UYFZHUU0vdkk45J6mV78xFlL76RdxpOlVGjeigRcTRj4tSUGNYNPNGd0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=a6YyNgL3; arc=fail smtp.client-ip=40.107.104.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSPUBESebe92Fk4jZFmJArkeoZEGBjSsLNw7cfLEhiMO5dL4CNUGh4TBUSigCow/9IWiWyMBiO28yMR+BVutUVBu443BhmxnAKTbM30aGzBDrlzhTs3PqrOknqRdgC5bOdrz1NfrLLebvtJxY01qjGTqQsIs97fnmxg6MYlZKkRCQ5RvbQ+14na7dsSUixQ1cYAMjse/V2puvJXaihzXINdPVJYoD2XeB3lC6e1qZOiUI1imRZijjzeMW5T1h9yZDUwsYRasqf8tPMaK2/ga+57ux1xitetnErGXqvN7lPvIWCisaewfe6Dwmt2/PgawBa3rxmOXqmKMAafawiiKng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+sTjEyfxPEL8kx5rJB5VNZQv3KU8jt3fK70feRwJ+k=;
 b=fJ8M8W4bpaSl5CGCNDPAC/tZwHzPBhlQujbrwGyGjGvU2GH1bvSU0NrAmUjF0G74gkETRQ7jpVXi/YNqgu0UfdNvDQMMFd+ZoFW3UAvXlJ4BHAaO+WJaWkkNWv9zdTWmSj5uSnn32Xl1XAFKQ82/49qGvAhvJmMGmyHeF5l5PS5mP+r14fNGkz/+LyCWV5nUKnL7PnmvKv/oMBFpsAH3X58PxyhDe2iN2LSTSLz78WsmsqS4pjH5rmmf6JZBMtcfDx4e8yVQpCuGxyl4I1zewi50RWHpjqTm2G8O1fZ5BzdB9hZu2OesYGidRSKl+Hssnmf7I70D4mZZMOvTeCeoMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+sTjEyfxPEL8kx5rJB5VNZQv3KU8jt3fK70feRwJ+k=;
 b=a6YyNgL3pmOSaRt1BGNlbzRVOaduzfQvui0l7HRlwLJmBXRgjDzxY0I7ycFz8bkoHjLEA8ghc06hUkFCzJNFFJ9AOlbOe0r8KB5peVV3J/J+YrpMaOPcGPNta6T5XQ3TiG0gSKYwOqzqDa5QsnSZvJLCVSx98AUSjAFyocizSmA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7347.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Tue, 16 Jan
 2024 21:31:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Tue, 16 Jan 2024
 21:31:31 +0000
Date: Tue, 16 Jan 2024 16:31:22 -0500
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
Message-ID: <Zab1qj3+6daX8QH0@lizhi-Precision-Tower-5810>
References: <d45e31c4-914e-4cea-a145-9775b6f516ab@linaro.org>
 <20240116-bleach-herbicide-48d636967134@wendy>
 <3199c245-3d2d-49e8-951e-2b059de4d683@linaro.org>
 <20240116-achiness-thievish-10a12b3c08cd@wendy>
 <Zaa+cLGVVDSB5MYr@lizhi-Precision-Tower-5810>
 <20240116-retract-conclude-c47a7fc8cb21@spud>
 <ZabVSYgq1Mz3LPpC@lizhi-Precision-Tower-5810>
 <4a9ed1ca-cd13-4b61-af06-a3d7935aeeee@linaro.org>
 <ZabqxHD4wtiPn6ep@lizhi-Precision-Tower-5810>
 <c760b89c-efec-489e-8333-c60b38fb5a47@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c760b89c-efec-489e-8333-c60b38fb5a47@linaro.org>
X-ClientProxiedBy: SJ0PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b99023-1c1d-48db-dd04-08dc16da819a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uEXuF3XAToHNandBhdqWvd4qivcavfSR/9xUiEY51ESzkCH9grdGvEJUDhwoU/Ke0CkpbhVGk3jAox58SgTZF9yJMlf7c4XDuSNWxhN9709nL9vnLifZZA4muEuTx9ckcxfS8djoMfgwhjHWccnhEV/j5SHVjAcNldRmHbKdmnclCC6nbvWaSn0mkbTUp6s/1cQoNPfkBHkqDNDOjBRizN33UB7YTjG3241GU/3i9Gi0zzFpMnD6FpABc0LfeLZGDgZu7SxgBPqDy5Wb8gX2pmitktfqWkUDFXfyoVKaSzReCNYeLTfx+Gt0qzF5Y9L3972RBpQ8oWgvsfZXsojgQtWXRHB1KbPbgOAov9g98jHkLiOp639r8+ZkIsQ+02v8xUr6fSvEJDjltwIxec+hZ8R1zVIn5NLM5d7f4Jv6vYaMTJkYcMXxu1Jrd4xCQ7/zn0Td0SHdrrNcjzsni5vQ8Io1MSFhBTxoP17UPbVl+xsedVVUaCCx77eSZslME8EbrOulTPQtuo9E++dkVvmLwlhN1uR6hQx9dYaGcj2FmDvJSELzPG1OUv/604DVnTY4vTuwBACXLD20F5cpGkzTV9bPgrwibEr9dS+hMQYwrPN0UanrIENKHheXUaIto71M
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(396003)(376002)(136003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(33716001)(86362001)(41300700001)(4326008)(38100700002)(6486002)(966005)(2906002)(66946007)(66556008)(316002)(66476007)(6916009)(54906003)(9686003)(26005)(478600001)(8936002)(5660300002)(52116002)(6666004)(8676002)(53546011)(6506007)(6512007)(7416002)(38350700005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mdzvnar0aNQ04yLrosFEvM9osILalEHahv7Mwp4xLaOJZ+s4IZSl7711yswl?=
 =?us-ascii?Q?RmqH3rh/ZaADyaVK1a/2reNkFUBPMnSX5QRZjcnWZ+eDOsW8wFP+HjOdmL4D?=
 =?us-ascii?Q?Sob/cFT7xiEpjk5EDU4ntjrWXeQ7u970Ni+Kfulv5q71WZDn3z5ybbrkEVsq?=
 =?us-ascii?Q?D26sM6uGEpXSUXXcOLw/UuTghrF0YUMbDJEUpxKAtfdGXeoLDCD7NHerWhKr?=
 =?us-ascii?Q?12Us7RaRuwqpx2aFhIFs1rM4KwjJEMsWXJUn7Jvvil0Z5pc4vIRvnVj497kK?=
 =?us-ascii?Q?xY1Z0VgioZfaCTZa3C18XcMzOEiCHHk7rD08q3bewtx3sqw0POaUv+82vGwa?=
 =?us-ascii?Q?2C0s6hVPoDp630WFXI1UqvhTB+JxERUe6pmq3b3YLFySOJo5dXJSfFaprowz?=
 =?us-ascii?Q?yk4b5uQ7BJw0uIj1ALUJHZMxm3cdhBhhz7ojcekHrlVuj2DINGRCLbTkqx4J?=
 =?us-ascii?Q?DstxqJdfaIbyz9Q40qcBEU3EjaurB4kYZmMeRMLZpdy06+3XPJa/znMrVPDh?=
 =?us-ascii?Q?ez9MH1t6u2Ujj+P0NB9+gicdVfCyolSNg8rAp+lvs0TrzcrFIF48KDY/rZ6h?=
 =?us-ascii?Q?qjP1dUFC4sltHF/IHFUW5vE9rq3n+l6I7stb7uEbAckANCeJp48slQ8mIqgP?=
 =?us-ascii?Q?K9cwsvGNbVIkm9SFyNaHy49omChxIgtuGp21Br9cugsTY3GCkjbhhGywp8J1?=
 =?us-ascii?Q?wS3XZJbovFXMjBLu0QjbUS0xbggXYMzYOQI0HabRg7im5rSpQabMw5o0ZtVF?=
 =?us-ascii?Q?DYdP7bcKIpBvKlqBTonGQoYIfCFCTh5mrHNyQKDCK2HrdWJZJdClNxUHlBBk?=
 =?us-ascii?Q?fbAUCA6Qr3+uh1A9ycqUaFlzFmqnPZExduYHh3GKkuS3IJQJ7f/G7hbNwKCc?=
 =?us-ascii?Q?J2v6stNtUBLCydbxF8QJrV9jMmsybdrY8PR8hWz7t2txem2j6wYoWSbn9x8j?=
 =?us-ascii?Q?D06wnKtMS00a49qvG0rrNHptWgYDsS5BaDXYcTsFoKCF0fnrpBV7IkHUELwq?=
 =?us-ascii?Q?Omas6ygLYyO8IRJlCVmM/pNCU6EMi69vLfOO//iuyrP3re2CZN6/F3ek8ho7?=
 =?us-ascii?Q?OhoP50js/1Ay5y54TE30z9c0BNAf3KhFafiHb/SwAwaZ195DibMmwtvU87K3?=
 =?us-ascii?Q?MPZlP0gYiiHlTD4zAyT9h7UERPO7Ga6s7onPNCtMcreoM745EzzV6oRabc3F?=
 =?us-ascii?Q?zfC2cJTe6X7wBc00q2pinA/YMIx3UOJcRfkO063DzjI9Ultk1Sm3XKQfFbJ1?=
 =?us-ascii?Q?fLdjbfZ4gpwkCgR8T1kQEyrMMC0bC5tdLqICSw7wYoqH7CHQu5TEWgXWBeHo?=
 =?us-ascii?Q?O/2ad/ZgAwBAtSlZaajhF+DfO2xp9vHgjef23eEpRNJ1iKeFSGVm1HBMOggQ?=
 =?us-ascii?Q?mLTKSrjjoozlkMP6xEoJh5RaSjzMVmhALAyhKiZdcG3AdbGaLswkH8IP3gq5?=
 =?us-ascii?Q?qWdCdoORRNgQu8V28ZPcMtu9l8EVN43lw3asUi1Q2HphjrNjdmZqh/6vRTA2?=
 =?us-ascii?Q?znjmvhUjTcRQXsdo+dh3U/eZ5qQh6LyVE+Ce4hDKw4i7LeiGp5mS6OM5siaD?=
 =?us-ascii?Q?fkVW7nq7vEMwOX4iHqs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b99023-1c1d-48db-dd04-08dc16da819a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 21:31:31.4099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRL9gIuejYMhL17XZ08w1DOHoDFKLMjbGBUvNK0iLQLJd2khMpFMP0688U86ADD8FzFnU0vwQmPtj5OL4C1rEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7347

On Tue, Jan 16, 2024 at 09:56:03PM +0100, Krzysztof Kozlowski wrote:
> On 16/01/2024 21:44, Frank Li wrote:
> > On Tue, Jan 16, 2024 at 09:30:24PM +0100, Krzysztof Kozlowski wrote:
> >> On 16/01/2024 20:13, Frank Li wrote:
> >>> On Tue, Jan 16, 2024 at 06:23:09PM +0000, Conor Dooley wrote:
> >>>> On Tue, Jan 16, 2024 at 12:35:44PM -0500, Frank Li wrote:
> >>>>> On Tue, Jan 16, 2024 at 09:48:08AM +0000, Conor Dooley wrote:
> >>>>>> On Tue, Jan 16, 2024 at 10:33:48AM +0100, Krzysztof Kozlowski wrote:
> >>>>>>> On 16/01/2024 10:30, Conor Dooley wrote:
> >>>>>>>> On Tue, Jan 16, 2024 at 08:24:20AM +0100, Krzysztof Kozlowski wrote:
> >>>>>>>>> On 16/01/2024 03:29, Frank Li wrote:
> >>>>>>>>>>>> 	Patches were accepted after discussion, what you ponit to. So I
> >>>>>>>>>>>> think everyone agree on the name 'silvaco,i3c-master-v1'.
> >>>>>>>>>>>> 	I plan send next version to fix auto build error. Any additional
> >>>>>>>>>>>> comments about this?
> >>>>>>>>>>>
> >>>>>>>>>>> I still do not see how did you address Rob's comment and his point is
> >>>>>>>>>>> valid. You just did not reply to it.
> >>>>>>>>>>
> >>>>>>>>>> See https://lore.kernel.org/imx/ZXCiaKfMYYShoiXK@lizhi-Precision-Tower-5810/
> >>>>>>>>>
> >>>>>>>>> First of all, that's not the answer to Rob's email, but some other
> >>>>>>>>> thread which is 99% ignored by Rob (unless he has filters for
> >>>>>>>>> "@Rob"...). Therefore no, it does not count as valid answer.
> >>>>>>>>>
> >>>>>>>>> Second, explanation does not make sense. There is no argument granting
> >>>>>>>>> you exception from SoC specific compatibles.
> >>>>>>>>
> >>>>>>>> The patch could have been applied two months ago had Frank done as
> >>>>>>>> was requested (multiple times). I don't understand the resistance
> >>>>>>>> towards doing so given the process has taken way way longer as a result.
> >>>>>>>
> >>>>>>> I think that Rob's comment was just skipped and original master binding
> >>>>>>> was merged without addressing it. I don't want to repeat the same
> >>>>>>> process for the "target". Indeed I could point this earlier... if I only
> >>>>>>> knew that Rob pointed out that issue.
> >>>>>>
> >>>>>> Oh I think I got confused here. The context for this mail led me to
> >>>>>> think that this was still trying to push the i3c-master-v1 stuff through
> >>>>>> and I was commenting on my frustration with the resistance to applying
> >>>>>> the feedback received. I didn't realise that this was for another
> >>>>>> patch adding a target.
> >>>>>>
> >>>>>> I think you already said it, but NAK to adding any more compatibles here
> >>>>>> until the soc-specific compatible that was asked for for the imx93 is
> >>>>>> added.
> >>>>>
> >>>>> Is it okay for 'silvaco,i3c-target-imx93'?
> >>
> >> No, because imx93 is product of NXP, not Silvaco.
> >>
> >> You need regular SoC-block compatibles, just like we have for all other
> >> snps, dwc and cdns.
> > 
> > "nxp,imx93-svc-i3c-target" ? 
> 
> Could be, now please point me to patch adding such code to DTS. I would
> like to see the real use case for it.

This part have not sent to review yet. basically in imx93evk.dts add

&i3c1 { 
	compatible = "silvaco,i3c-target-v1";
        pinctrl-names = "default", "sleep";                                
        pinctrl-0 = <&pinctrl_i3c1>;                                       
        pinctrl-1 = <&pinctrl_i3c1>;                                       
        status = "okay"
}

> 
> > Just little bit strange for binding file name
> > is silvaco,i3c-master.yaml.
> 
> Many other bindings do it. I don't see a problem in creating device
> specific schema sharing some parts, if you have some common pieces.
> 
> > 
> > look like "dwc,*" compatitble string's file name is "dwc,*".yaml.
> 
> ? I don't understand how is this related, but if this is what you want
> to discuss then look:
> Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> 
> or many other examples. Please open dwc, snps and cdns bindings and look
> how it is done there.
> 
> Best regards,
> Krzysztof
> 

