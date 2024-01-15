Return-Path: <linux-kernel+bounces-26440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F30582E0D9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6D63B20CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1B518E08;
	Mon, 15 Jan 2024 19:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kA1prPc0"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F3918C16;
	Mon, 15 Jan 2024 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQTLdv5ojwCgTrWuzPLQjplrv/DgoW2TlIuP01NO22+AHtQKibHN/i5AdaAx8AwhnA8W2BT+yxPWsB2pISl6PBTqm6td7tuuJeoXy6/hJUJ/XN+5zl37tjzNPwL+A5/K4YuRAl+Rxt/RwCdrktjlfYbKwSfVLLse6SodKfDGMwStPIK2sgq+SqyGzaXFLOPmmQSo4myLtz0BaBfmDHCcNl3KqS1DHfZj5rygQIV8MvUwa1UH4SOE+YskHGqxR/Li5Tv2qySTGPWfWD1J07apBjzMNhfptZ72LsueBY32aRG+KbkbNdL5Vwtk42Mh/ZDem2mbw0LDrRZ4giUuTv6fMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDYYj88JYvyUVbbqgOBgWf2eYXBL+JkFlG/aFZlQF38=;
 b=LavZ1qDctFGLWB8dhxoyynlJCjd2kdh/QJnYf9Un+0hgELV6ir+/xfjx9tZLDDAlBs3Y8ApIWxgcCeGfYlAgxzfiCYTAjbWHA+Os4B0cVpYwnngSQSCC9Z4VIkKUORTuAsCqXcCetb2vCl8GI/wvH6sPv09ktpyTCZn43M84PsaS8jfeQArH/yLrFhqFUuCMR/EqldzDXJmbXF4TcsQLUoIKs9MHBxSSwkwEGHMMvbsQVpy53wPdoCJwCi8J6UZOBjSKcebrg589exc2Ni+SQDTRl97OOWgv4WEmf0ycfNpdzsNQTD9bPWor41DAlOalaOK+ctLWjDQJt2dHQ/v/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDYYj88JYvyUVbbqgOBgWf2eYXBL+JkFlG/aFZlQF38=;
 b=kA1prPc0ARgtYMlxqhYmcX0hfo6M4wIo9QgI6vi6soTNkCI1ZchPOhjp/MSWHGk0nVxc8uvZ3bQLM5poc9KcYNnNx4E14w/X2O3mh6w6AuLt1TTtVWae7rfV5tcqjqoZyJKqGsv+2txwiXk7ehUDkqNDlDIaZ9D9lQqW9uBMWsg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8390.eurprd04.prod.outlook.com (2603:10a6:102:1c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 19:44:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7181.019; Mon, 15 Jan 2024
 19:44:18 +0000
Date: Mon, 15 Jan 2024 14:44:10 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: robh@kernel.org, alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com, gregkh@linuxfoundation.org,
	imx@lists.linux.dev, jirislaby@kernel.org, joe@perches.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, miquel.raynal@bootlin.com,
	zbigniew.lukwinski@linux.intel.com, devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 2/7] dt-bindings: i3c: svc: add compatible string i3c:
 silvaco,i3c-target-v1
Message-ID: <ZaWLCrWJEMtFx8cR@lizhi-Precision-Tower-5810>
References: <20240110175221.2335480-1-Frank.Li@nxp.com>
 <20240110175221.2335480-3-Frank.Li@nxp.com>
 <3c0be658-e7a6-4231-b206-86ffb47e0cb2@linaro.org>
 <ZaFbbeQrC7o2dchO@lizhi-Precision-Tower-5810>
 <e3b9aa63-25a5-41cc-9eb7-6e7d1eacb136@linaro.org>
 <ZaFjaWCA6k+tiCSJ@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaFjaWCA6k+tiCSJ@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a683534-945b-4719-8a5d-08dc16025cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WRVrk9kuMjD2+BcpR71VNheiWMPgWQnkZ6FIIAk+t5Qttw8I/r4DSDW5gxEgC3/3IgCptGBSNmmQEAT0WL9/30gKarX2myzbxhEycEVIGPUqiDo69KSvTdY+8kgmCgmqj/gz0qE22fdjZMwmSRcdz49pU47YyGhVY9CnXBP2D4KPuV691uYGurAHrzfQt3YPgOeh9EqFRv5/KgcAfGPkyZBpjgMnsG2XkpeS5QDUbCju+GIZnsI8Nr6VSev2xBHggCnrMBJokTHfllWwrIHehW/iE/7WD2DMvtZ4kb6qtMOHF1+Y3rL4Jq8l3ax4Nbbjzg3QhEBHqiYmKV03ycFeRYO82YS5lEcat6lD9nGLxyKFUA/oWtM7cSMIeBtiJAQbjZDR8Ftc+YQ4Wm2k1X81XnNHT3eccrILCBh+saIlnxNMlXfMvNgiatFMjyDv5LAvUppDZdXHFWiwZiwzDo6LBts9dpiCGruLQA2KlUUPC1vaADdBvqebKCJAdPH9FsOXq7gTHlyeyu50LO7gHVBhcU0Nf4BeQjddkyhv4p/T6zvGKj15dktlqXT5o47zHCAdrxDRgKTPIDZpIfAmg73Yj1Hr0ZVNCcNemlTmMgBv6Bg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(346002)(136003)(366004)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(86362001)(38350700005)(38100700002)(66946007)(26005)(9686003)(6512007)(6486002)(2906002)(66476007)(6666004)(6506007)(8936002)(33716001)(53546011)(6916009)(316002)(52116002)(5660300002)(66556008)(478600001)(966005)(4326008)(7416002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4N/P44U3f6mwslBPEFOlxZnHePl6TQC4gfQWmozjn24vKTYXItvEJaNfZ+lI?=
 =?us-ascii?Q?ojjaLhM50jegwHkTK9oaDk0Y8qQbeSkW9GGiMZifvL1lRkmP0fmWorP8TRxC?=
 =?us-ascii?Q?XuahqYJnhllSq6KfVg03lbRdJ24nRDgBSlVCEPDHF+zo44GKf5PFZMOw3AbW?=
 =?us-ascii?Q?W3BQVyXgNlblvwvVH1TEQEc4RVb31ehazAfuoCvmSV+rSwxFf09EN+YwLDZ+?=
 =?us-ascii?Q?rhcpdEtmeXo0xnzlndwOsxYSfaoFW2cTyFa7cdPMeYZwrKTJHayxFs1Zny1L?=
 =?us-ascii?Q?bbo4PmPhLOv8AD72e6BotaxhIZseSnG5blNW1DyAolk43kOLPb3uNf2hn/g6?=
 =?us-ascii?Q?ySNxNsjM/+ZHxWvBW+F/I0bnoIE8aEgjfzAc6VGmEjPq0g21Nu4KBBedL5KK?=
 =?us-ascii?Q?BjOAIhceLjC5b+q9wtXHfLhJlEFuTlv+6yoxEzQdGD/egn1m1GKjbNP+X3e1?=
 =?us-ascii?Q?QSUCTcFVFB2n7Eiw3QymYKXqXGSQIYdyyrgaRsa4IgAo0iEMdPWX2ATkekr+?=
 =?us-ascii?Q?UMTMIZU0lHpQqyJF5eqn/upviVfukOOv/5+HFExaejK0flMmi9TwE6sCeN9G?=
 =?us-ascii?Q?Ye062SVBhcqYeVaNpafi/aCmPxQ7Mzbm7FSnQk3p8lbFjzgnKx1pHLTIE1RZ?=
 =?us-ascii?Q?x2gx0MiwfakXCin+bFsM5eZGkXTTEp5fMy6gcW/E9+7sO0oNVZDTstHUCI25?=
 =?us-ascii?Q?3X593UCneTU34am0lSfm84NLaPh3mAHT9Pt1QMc56t1C4waNzafOltz8h31f?=
 =?us-ascii?Q?O1lM4/Xj+kO5Y9SmuNAwYYDazPxAVIZtb0hyASb+NYfTuxBQfGPLVeOB7FUK?=
 =?us-ascii?Q?LnWOAhbqOzkDgIBgePHUMJJ03WZ4ItiHZohAHos7JJe08+/CYEvPd6eU2qHy?=
 =?us-ascii?Q?RXlwmsR9LgmBDMiScVKF8NcxsT6OFg+w8MKuhZQO51uIwkfDJEi1hDwi5/Wl?=
 =?us-ascii?Q?Vvxzk/qcY9z4ftuzL/fOu8s8WMEpC1+5UttW+Qmb8TWAXj32QimJNbGt+fOm?=
 =?us-ascii?Q?afQUY4E7e16Tv8YdV5pN1r/qnOSH7m+FDVmDsNaIJymf9G/v3emoKakAT6HS?=
 =?us-ascii?Q?QK8w5JWlJ4QFJZnI3gfxV1/hKtbM63/bvVq9r2vrU6/e5+fS5fX4OzvYE+y5?=
 =?us-ascii?Q?Xe2zHMxhcgZ06FTXZ9weYPI9en2oyC9N19SsiqQclmMR+KzHKCwS1BaYjq+V?=
 =?us-ascii?Q?Xmq+9oLd8WVBlow9K+PQvB2owFK8WoKNI/I3FDYE/C069mJ8tYwT82bdWuxq?=
 =?us-ascii?Q?7UXSu6J7C207jRwmTYaShzF80SVNkrDlPWU/zKgGnAq1PkDduEP+DdoDe4yx?=
 =?us-ascii?Q?BC4Rluvx1RG+viXRLNDn6EyzSjp9ENEppeWVtmY3X3YizcxW+y9R0nUm1TRI?=
 =?us-ascii?Q?xSYwaarOLoLh6MhVAUS7nCrh4S2wO8w8LCtFq7rrgwSNC7tAt5MXS3K3NrQ2?=
 =?us-ascii?Q?XCpAog2bUGzxVjgjWXtdYTwe4mdabt+qbaka7RdRyMWJEAytyIi153Ksx+bi?=
 =?us-ascii?Q?uBt4r306VybHtgj6fQXTZpP7dqjcBNwiVJkha0GYEyng7GEQ0/IfEuzR5F5e?=
 =?us-ascii?Q?cfd2Mvb0Je5BahInu+EDCRkIC0XP2iTllNjk9v0V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a683534-945b-4719-8a5d-08dc16025cfb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 19:44:18.6893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tH3O//p7u6jTfsJ0ULHcski5FD29QM5IduEso6rgD5uQDEqCV923sAnvKtcJuY07RASpY0h9I9+ypeRHGgupDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8390

On Fri, Jan 12, 2024 at 11:06:01AM -0500, Frank Li wrote:
> On Fri, Jan 12, 2024 at 04:50:25PM +0100, Krzysztof Kozlowski wrote:
> > On 12/01/2024 16:31, Frank Li wrote:
> > > I review previous comments. The previous RFC patches and I just want I3C
> > > expert review to check if there are comments about whole software
> > > architecture. Of course, thank you for your comments about "slave".
> > > 
> > > Go back this binding doc problem. 
> > > 
> > >   "No, it's the same device.
> > > 
> > >    Anyway, this was not tested.
> > > 
> > >    Please use scripts/get_maintainers.pl to get a list of necessary people
> > >    and lists to CC. It might happen, that command when run on an older
> > >    kernel, gives you outdated entries. Therefore please be sure you base
> > >    your patches on recent Linux kernel.
> > > 
> > >    You missed at least devicetree list (maybe more), so this won't be
> > >    tested by automated tooling. Performing review on untested code might be
> > >    a waste of time, thus I will skip this patch entirely till you follow
> > >    the process allowing the patch to be tested.
> > > 
> > >    Please kindly resend and include all necessary To/Cc entries.
> > >    "
> > > 
> > > It is the same devices, work at difference mode (master  and target).
> > > what's do you want to change to?
> > > 
> > > Copy to new file like pci/pci-ep? all context is the same, except for
> > > compatible string. 
> > > 
> > 
> > Apologies, I mixed up a bit patches, so this was not obvious. I meant
> > this comment:
> > 
> > https://lore.kernel.org/all/20231017201404.GA2570433-robh@kernel.org/
> > 
> > There is no indication in your commit msg that these concerns were
> > addressed.
> 
> Look like everyone already accecpted 'silvaco,i3c-master-v1'.
> 
> driver part:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=8911eae9c8a947e5c1cc4fcce40473f1f5e475cd
> dts part:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=b8ec0f3b42a3498d5115d1fb1490082ab525747b

@Krzysztof:
	Patches were accepted after discussion, what you ponit to. So I
think everyone agree on the name 'silvaco,i3c-master-v1'.
	I plan send next version to fix auto build error. Any additional
comments about this?

Frank

> 
> Frank
> 
> > 
> > Best regards,
> > Krzysztof
> > 

