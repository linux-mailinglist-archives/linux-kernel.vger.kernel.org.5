Return-Path: <linux-kernel+bounces-29846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA7F83144E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD581B21344
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2515E1170A;
	Thu, 18 Jan 2024 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="K496z8cW"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2086.outbound.protection.outlook.com [40.107.255.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846FE13AF8;
	Thu, 18 Jan 2024 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705565691; cv=fail; b=OXlfmGCF10nYJwZaYmsXmkZbILby2BW6j63vUOsijjD0cKoD+QN3UzAy/+ZpKftMJFBSHdwycyTxQjncmp9c1qNyXJw5MWjoTFyNz8MVZK8ovUI+BAKHrDKHNV3ZbQAsooceGRSdq9WEFfXyxLH8AVU0QyVjFS7ejYZFtsiwBfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705565691; c=relaxed/simple;
	bh=nZzLrAOUCByDo8UCcKHpV53sCTiAyVM3KHoPN0mPOZ8=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=tWQAuA7rL+QzByC76yMbmVVGN9gA0wmkfyzdDDee9baISVxpg6BHYl1mBAmW3SfJsM/3EKO7At61+nhKU4CVMRGwwoJQFo/tr5eTT1oUbHKtJv855sKrJdnR3hlXAGgsOkoAV49rkA0aWESZM0ilHDeV968RM0ratoYSdFLoNVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=K496z8cW; arc=fail smtp.client-ip=40.107.255.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tes79rnsmYJrQHAwUlxDCjV8jWIkOe4FkRJrjHnq8J+vrdAU4icRT4Sca29r1ZcZv3fqzkoYc/Q9M/aJ/OO4/1AFN+gV2RsByk/uggelIeTSp6Ie8CIXC6Ai9UoqdUV+0krLSWZdZNXvDUG/Z4qVDTcPAoXjybBkz7n8f+RMC4MTQNxy3h2zM3vZxkaIjle8rLA4n/9/JBG9ORRHR/zWOyMfgiTSbf3MEqRhttAKbcpqYUU6LWSZUKUkPyRN33STfDE2n/dfjpfjox+K8VjOnUeSJWVFeuGZJus/vHdqD3VbaUulvrMcbxzFZSOOSKc6jtwV7jc5blq5Jg6kT/vxaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AddfU5mfMCYomBt2Tuvvr5rtOW2XMYkHjkNHJKfKJqI=;
 b=PW49XS2f1D5hCmgnOHm55ZzaD4k6Fdly4B6KcxN9WMF28G9++F2w+fJEXjNsOhywDKMmms45km2E0yP/P8ivkCV76TQyrYDmV6uBscuhvb449+kirSFOZbL4RvCnSEA1ZV+gVgixlG2+cX4vT0c6joNDFOIpy91CleI2qIi9DZE8lRchVFq6rDiR4QtDTCNifJw8vreLtNlOF7FAbCv3QeJBgYELuesxFFR6Y62ZU8GMNp10KDXoyblO1Kzcmc8E3rmOtyerUUlh8wuOcPbdXr/njSIHo1j8E0l5SMA0a9cj3vbL9WnmNm/0JOXvLW+4A+cinshr6kY/HVFwM9MkMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AddfU5mfMCYomBt2Tuvvr5rtOW2XMYkHjkNHJKfKJqI=;
 b=K496z8cW1wAqbnlSanb/4JQrBjRvNB0so1955KClEfnh2lU4NqGpcA2wMESOHFXOVrHPTHIup9a3T9rJ2GzxX+nI6wuT0dY1j5OhJ1jPAlVCYED8tJLb+4P0ecxSdmDTTMEA5VaQoXgZzMIyNPY7SvP4vbfzC7+C/a9MuljBFhw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SI6PR01MB6423.apcprd01.prod.exchangelabs.com
 (2603:1096:4:243::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 08:14:45 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::1023:2132:c05e:ea6b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::1023:2132:c05e:ea6b%2]) with mapi id 15.20.7181.027; Thu, 18 Jan 2024
 08:14:45 +0000
Date: Thu, 18 Jan 2024 16:14:41 +0800
From: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	jirislaby@kernel.org, LinoSanfilippo@gmx.de, lukas@wunner.de,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/2] tty: serial: Cleanup the bit shift with macro
Message-ID: <Zajd8fd/U3foRyLB@moxa-ThinkCentre-M90t>
References: <20231201071554.258607-2-crescentcy.hsieh@moxa.com>
 <20240117145623.3556-1-cniedermaier@dh-electronics.com>
 <2024011836-glimmer-seventh-f2a7@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024011836-glimmer-seventh-f2a7@gregkh>
X-ClientProxiedBy: TYCP286CA0190.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::10) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SI6PR01MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: eea8ad19-870c-4f7d-5a15-08dc17fd87a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7vGd1Yok7cYkpBGRQVgDAdKEWERiEMk292qw3xeMNB7UOx2Yln1V4VfItjMDd9854FiqErqxUFhrinUeTVD372HeM0BGEJjGVlQW7/i6+AlnIU0XdldtRyAGK8mQJJ8GQxcmcfi4Mff+sZezl+5wJvwrwPS6pFqgfYsOY7eMXkVOk7vEbqt8DZzNKF2XC4wIyhwZBhCyP/JTQ8EcZpTBPK6f35sOEmL1GVdhwfQ/osHxT3yQBl6IdmAAkxfDw36+LEsIylMRen89/1V9CdJB6z41JYehXxLhxlimZr5f//USFidvhVRIfiVJH/dPJGuQBrnuxj74R3JJZyjz4IDcqhYu5BJnU5bCJEUIN2Jaa5I6cY9ijdoukUqIKbQy8qi2mNE+p9VDJ3vt2cPoFY0TKC/bY+TpWTh3uL0tt9fuMsLlgIDVpPD14R1xVVdhJFE/XyTLlPv+j3gOVJ1Nc3Y4v28COsyIaOVP3XvT68fxgxhqcNcVoVOxnImhuG30QcDFrsnHuaf2Fabo3gufbSTr9XLgFEYW9rl5+4U9MDCjVMdftMeafq0yhut47MSbW/4JCSWwPD/J6lCnGMfOubwv2RCiSvp98p8LndrBjj7Ax8YqDt3Ua6Cmik4ryXu9fpOS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39850400004)(366004)(396003)(376002)(136003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(26005)(9686003)(6512007)(6506007)(52116002)(478600001)(6666004)(38350700005)(38100700002)(6486002)(66476007)(66556008)(66946007)(316002)(4326008)(6916009)(5660300002)(86362001)(2906002)(41300700001)(8936002)(8676002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?opw1W/8hrTO1ujJdhiG7rZJYBv6zreHDIAQimTKmfctIhJYvCXG8o8jp1v6p?=
 =?us-ascii?Q?rrsi5lOvruAO/j9BAL2V2nHqLifeIEFQYaX9VMUhbLv3DFgHbrcY/4Fdvaxl?=
 =?us-ascii?Q?HQFxOPMvYYHyqj6StG0tO4jLmVfQx3Ko3RawKcGsZtNeFy2X7FhWkvaj1eBz?=
 =?us-ascii?Q?PPjBafM0L5icZWSTIn0neKMAkkIXTFQstI9g22CGO1I8K2UbcfHXvnH+S6Xh?=
 =?us-ascii?Q?PXQaJuYGfI4CUkeMpW8wtP6pluGi5ABh5opfF6guNIZ0JibEHdO8DWSR29Kt?=
 =?us-ascii?Q?JX2LFZKSuUdu0NGhuSD1UiFHs9Jgtvyu1+LsqLYGrp6XaV3bpoobq24n6/fy?=
 =?us-ascii?Q?WsIz+/z4XwerAiJV1fJ32UwpO0Tqc9hXZMuXWd46bW+i5glgPgX/Wkfy+L7f?=
 =?us-ascii?Q?fh7XTQ+w3bAB3l+Rcw+sxmUnez3RH1Vz1jHlFdM4Wjm92oFeUYVbTsiwxuwt?=
 =?us-ascii?Q?kJuptFh7jtVEkgXBp9mfvLmAcPmQrD9L/le+uFrbKXV9jNOMDtUlLYIyB1NI?=
 =?us-ascii?Q?wBRIrYsZCp3FBnOLImI4BZkaDJoWdTqhpftiiVn2UivX4/VH4GxmsqKsqVt7?=
 =?us-ascii?Q?qWH59UiB2NOz+h6mUWSzp1V3m5yocnqX+22XjPGbNBtRqPFZ33McAHY8R4HJ?=
 =?us-ascii?Q?SpFMAdjoYCGPpV2necKjB6zqLUoOsuCG1hSUjbKD6TFRMepT26Pa2hidlsn2?=
 =?us-ascii?Q?1WpEvSezjEtaSAUC1wQmjRtkvuGhaa4GLvE3Dobm8wDcZzXW7OkSCUTQ5rPI?=
 =?us-ascii?Q?OEUKOkBO/wA4p5L+VPMe9IebpTM1A7YGq+r1CBT93yZ5Ut7xs+GteXIIZslf?=
 =?us-ascii?Q?TwIT5ytJcqw55SeTbiSAwS5etVmmx9YH26SQHhUjbjuCCW9hQifigwnIb8Ki?=
 =?us-ascii?Q?QiqgFFzlL4v5PARnS0XQ+/LH5ezJ2OdzG3CrTk5fqL61R+HV/AibkuBRf3ya?=
 =?us-ascii?Q?bkOC+ceAlM942KS6lADopeUAGNjiLIdxzBKYDOMxvOjgtqLIuloTz1n7zPpm?=
 =?us-ascii?Q?+Te2itGK40GdLVU5/pikaBuYJNBffCO2165gViQZtQu2PrV9H0bljVfpzsHu?=
 =?us-ascii?Q?DaTuUnE+WG0UN41kqzL+BL6H4qsMsVL7cSU1ETelU8skHWwU9fG42XbMYrNR?=
 =?us-ascii?Q?7YMZ3r94VKsuysZ7/n/SqZeAERot36z3pQCstuoDUBspgSfvEcET/7gKgXF/?=
 =?us-ascii?Q?moL4g1GqIwX9U4+zMNtLOrgGgR+Y3qMRNigCU6tHyTYE4rgRqkA7W0eW45gU?=
 =?us-ascii?Q?FL/OJlMrTHsTT2n1OKmhMe/C8SvkLXTR9SOiLLKUDlrTaradBt+Gnlb5+pyJ?=
 =?us-ascii?Q?BG/lSJ3cLQT6FpI4fRTL8s83daWOnUoBxPYf+9bAn/dfKABBIvKY1Cec+Hf4?=
 =?us-ascii?Q?6W17vrKTUX2uWItSxNvCNbf2fceHEs9c4ty3PDO9DwdoxpSDHKQCwi1FuwKe?=
 =?us-ascii?Q?Fot/LeMIkIiDuxoxhkvVjAWqOwow8zxuKvnqTsfGkjPLTzsj8v8jxyXUyKrM?=
 =?us-ascii?Q?UpqtV8YTvxgWyEX1cxyb6OqzmZdEYTWNIAxqddH9rMgCCNVMWMj49v7JD5+v?=
 =?us-ascii?Q?fovpUE9xjLAK8ouzAqubwtkfE5URYtK+LEc4iRBY2mMJyZ9VGjwKRSxYAjSN?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea8ad19-870c-4f7d-5a15-08dc17fd87a1
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 08:14:45.1074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9Bl/PeujIkblzs+4Lk+ENccXboGtLRzzeXhX49m0rlW4tQEs5TDOE0Vi0e2daAqYm79OTi9jHPjVlBrN+5RuBZFG6P4/FccbdvecEamiGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR01MB6423

On Thu, Jan 18, 2024 at 08:01:58AM +0100, Greg KH wrote:
> On Wed, Jan 17, 2024 at 03:56:23PM +0100, Christoph Niedermaier wrote:
> > >  struct serial_rs485 {
> > >  	__u32	flags;
> > > -#define SER_RS485_ENABLED		(1 << 0)
> > > -#define SER_RS485_RTS_ON_SEND		(1 << 1)
> > > -#define SER_RS485_RTS_AFTER_SEND	(1 << 2)
> > 
> > In the old definition (1 << 3) wasn't used.
> > 
> > > -#define SER_RS485_RX_DURING_TX		(1 << 4)
> > > -#define SER_RS485_TERMINATE_BUS		(1 << 5)
> > > -#define SER_RS485_ADDRB			(1 << 6)
> > > -#define SER_RS485_ADDR_RECV		(1 << 7)
> > > -#define SER_RS485_ADDR_DEST		(1 << 8)
> > > +#define SER_RS485_ENABLED		_BITUL(0)
> > > +#define SER_RS485_RTS_ON_SEND		_BITUL(1)
> > > +#define SER_RS485_RTS_AFTER_SEND	_BITUL(2)
> > > +#define SER_RS485_RX_DURING_TX		_BITUL(3)
> > 
> > Isn't it a break if number 3 isn't skipped here as well?

Sorry I might have misunderstood the meaning of "broke userspace".

In this case, does it imply splitting the "cleanup" patch and the "add
feature" patch, or leaving the third bit unused? Or perhaps both?

---
Sincerely,
Crescent Hsieh

