Return-Path: <linux-kernel+bounces-23686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 818C382B005
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41D21F2407E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F5E3C488;
	Thu, 11 Jan 2024 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORG5796793.onmicrosoft.com header.i=@NETORG5796793.onmicrosoft.com header.b="XtwdTQlR"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3B4364C5;
	Thu, 11 Jan 2024 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labundy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labundy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+gAiuoPRaXoKVZpIrdJLDaOJW3p1f8cwpP8f3UNkd5rObTt4gXH+EuYZ+vbrOWoz1SxKlhhXfRu0aiHeO5g09+g3J00OVPcbf2YW4MooaXy7dV21HxXIHx7mT34ECnS+IO9X/XaMpdFNbVRKFPVVdaAA5D3qQsuTSq95mAlFRG9sAYx6V1FDBy0YWa4joH+wgaWTXtTlP1B79u3AMDloX1nZzBF+iP/g210jj46q45YWm7JGsPfV0HwpQOw11QAkj292pp4ysHG9asYWWBRYItOZ3iUMaWn3aZx8BFMiwgy4sNMlUS1zn7zsarDK9BgNK56f30pTETY8ZGS1lcepQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REzi4lIqLddDL3R9sZyppejICVYzr1EpaHZvOd2UjSw=;
 b=YNkvgbCsY3M9QNiDB6bPBgzYxtkoi3O+d8HPeHuR8at5Tqovv6QPJjEAL5TlvOysw0I0yFYRDEmYyTsdpBfusrEOer+rVZ0YJ+JEFN+l7YQeMPMcwa37GHUTnOP3NPeZ4p85OAc1KH6qiOAoi3fu7C5LX5JmgPgCHSlTnCkQAnl64eMnbPyZ+ZbBr133xO7A9Uh8BoBPo7qkeDVLL+uxr3PMFuLwL4IkLRby/1GDE32Vxdb4sRJRIqwKuiGRgjLaL1HktwDi19xhBD+Apyu3H2iA2n/Pnb08Sq4oR20pX5SmGKOB4rk6n1XutxxA/ChYzv8NC/irvr4QkF8fzh16dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REzi4lIqLddDL3R9sZyppejICVYzr1EpaHZvOd2UjSw=;
 b=XtwdTQlROrpGi0h8khUWV+KkWd1Uy/Kr0Z+Mf7mCjorE/UxLh4sUzGDWJ2S5yxqr8ZMg080h7oxB+0Op3b7JWzDH2Zkh202hP3hT2GE/DMAph0kh+L3nDEAemV90P3ur/vBW17oK7j93cMOdfBHrPXdLTDPZLfo5qRIgbbqSM/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by MN6PR08MB8737.namprd08.prod.outlook.com
 (2603:10b6:208:477::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 13:55:28 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da%4]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 13:55:27 +0000
Date: Thu, 11 Jan 2024 07:55:19 -0600
From: Jeff LaBundy <jeff@labundy.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Bastian Hecht <hechtb@gmail.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/4] Input: touch-overlay - Add touchscreen overlay
 handling
Message-ID: <ZZ/zR+GybLjR8Dcb@nixie71>
References: <20230510-feature-ts_virtobj_patch-v6-0-d8a605975153@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v6-2-d8a605975153@wolfvision.net>
 <ZZB9x+0eNL8e+xI3@nixie71>
 <12ac3718-2c69-4d11-8ea4-b555f2321232@wolfvision.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12ac3718-2c69-4d11-8ea4-b555f2321232@wolfvision.net>
X-ClientProxiedBy: SA1PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::6) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|MN6PR08MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c9a63f-242c-4350-0730-08dc12acf73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	adQHboLq2FRBbz4Aq00eAK3xQv6J/C7/jk9p8yjkvD8zbi3ZOdiD41bD7hm/Smy81nk7xnE2zLWhUObemJ1vlV9+JKNbv5mE5jCNhEDOAy3asij1ZVq6EVqI5zHWlCfXdqZwXViwbrTAJlNA1ZPkL9/amtBqe4UQ1gQohzitpgH+KlXJ21NYo7n4Z26lkxggXncZHiz3vPdd4TszQfAXe1QGHgUBmdxPp51qQ1F2SwPidWxC663OQn2yW5eHv62ObzsrhcKy8/t+Ey0l8pYOGAQTb1CVNbbIpOOpjDd55C5QNZAvaxSjQVlKcM+wvplbTPDuv0IzmySsc/uxFEBqHZzKhkq88Gxa03J59l966UdxYbRDJJxdJgeOX6c6KFI34tntgj0V5v+xG+K5+ab2OSIS9CtwFyvVCp3giKe09GN6nVi0+NlgKeIRvMWlLdH7ai74sMorIVXno6eXGwHYA0/J/ZwbQDKcyvw5i01Y3IRVcKb1zvKCDiYQBGBTAuuID/ax8D3MpuQfyaHYASRijrTREFgVFm7J5h0DwN0nUoHXHQs9wMwImE4z9tH0HeXG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(39830400003)(366004)(136003)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(26005)(38100700002)(33716001)(41300700001)(54906003)(66476007)(66556008)(66946007)(5660300002)(316002)(2906002)(7416002)(4326008)(8676002)(8936002)(6916009)(6506007)(6512007)(6666004)(53546011)(6486002)(9686003)(478600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/PSaoP2f04TI5gF3lDakHKgvr4h/BTNgi4SDMsDWLlOxZkjJsdnX7LJss0rC?=
 =?us-ascii?Q?u8VaCA/1PDdNO3J0m+XBIw1VU04g5/DSmPgiNcJhJ3hCyfja2FmNF+8wZppJ?=
 =?us-ascii?Q?vmSImcsbaRQLJ7xiKc/F9g1akPDkvMieFJe+da8bztiB7XU3Ly7Z4cskvMWE?=
 =?us-ascii?Q?197UrA8qlPFrZOGEXAyQxsgdFCdNeFf3g863GUHQc+mlMLOwbnUw0Qi4TvIk?=
 =?us-ascii?Q?SwkqmSatyYH6+Cqyp7Sn6SD7TnytlOW2V2zQk13SzSEdjDmrF3saXTyaCLCc?=
 =?us-ascii?Q?k/BgiZ8ASLFP7MgHRTR+pvkJQpmdU6nKnPbdiolGkMIFWtGsCfPIy2icnosw?=
 =?us-ascii?Q?KgYkY4y9YkGK00bE+fz1aI9V9U6M8BJ69P+LH5OmHz0yqNtplMYNAS1hA+EB?=
 =?us-ascii?Q?W5Te/NAVl9Ig72E39GbGCBShM4i6fCAPqfsoNSfQO0KfKpV288f+g5P1dZsX?=
 =?us-ascii?Q?J21XxjrU9HFE/R/efqoCKtNc75iCPnoaMhXY9bknHrBcI5rhZU/EsNRkRK/4?=
 =?us-ascii?Q?8kXVjdLnNLmAremE3fTb0Wz0jRCKC4INnRTa5jsjGW2GM95Ya2YxsV45nkrW?=
 =?us-ascii?Q?6MUdH+kt1wEkbqNbT4woOvWE3bQEcUDzaxSKnPrGXLxHnWw19WrS90IbMosV?=
 =?us-ascii?Q?qhMyuqs4+yy23cBFczMasVuk+LaTtPWw2X1jGR87Z7+R5TZOIi/gDerV2r6+?=
 =?us-ascii?Q?y+qgtTDcXmOA5xrhV1orUEPTYQlIMxHu26ara4nF2icZDGV91EqUm828Cbjz?=
 =?us-ascii?Q?2PzfVHM7ghfjAGcrEGT9kn3lASzi7B/3GyVzgErN5bNVo3j+cw+sxz9nIXKZ?=
 =?us-ascii?Q?eNLe143/heAglcZDsA/+nZ/4oQtInF3DkjC3s9SYHhZyvWr8FPm7GstQlzbC?=
 =?us-ascii?Q?Y9lY0jiOv3k9mCuA9WTKwNvJW7lluTW6juHvaVWH6UqNG5KnBgVnsfSbez9o?=
 =?us-ascii?Q?KK0nTF2pUKtCZPWII2NSvnDvM2qVmolX/UP+QnHXLn2ApRB6BCR3ojYpOgZC?=
 =?us-ascii?Q?Nu7GqqYVM3PqSUKjR8zgqtikUPWw+GgxjETdgNaXFG4oqW3F1ETac0SAT5ps?=
 =?us-ascii?Q?AV2za6Oi8AYCXAnCWvnrOaC4s3qVsDqys2r89qFm6zSekf8bjjioGobIYlHL?=
 =?us-ascii?Q?UXBKsVFCvmXgriqC49p5bTM0LP2bGxWk0tZgYohd4s7gH81AGLI56zkA3BIg?=
 =?us-ascii?Q?s0fR5bJkukxF9eEFIeDyAND3uGibFcN0IX07fdaUkexNtgwYjJDGHC0hVeZi?=
 =?us-ascii?Q?VNVOgfkxbC/kdUXEFYpUKAk0Klaw+bS8BDPBQLWC5q3/BV1c+Pi3MQ4S0xGi?=
 =?us-ascii?Q?Hot5xShGRpIZT1p4A4yyVKnyNXOvYfP0q5XE/lOvocn3kFciNsPFnLFgOkZh?=
 =?us-ascii?Q?M3psD5lwYPe+OGg7/O29wxq5gzVzJDgaDceIEeLM336K1VABuvznCqgBvTjL?=
 =?us-ascii?Q?H390H7ADkhhXjV641cvHzd1psQ5m3Sy0/zdSR9C5LhAnKJHOCVetDJtojyRe?=
 =?us-ascii?Q?iwUfpzQ/8dHxhJ/OrSnUxwMy4scJSvvnUJ4MM458ad57IxXWUMCpJgGE1bz5?=
 =?us-ascii?Q?/iViURvvoapd6wAniE/JmDp/begZwv5dh9slFpMT?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c9a63f-242c-4350-0730-08dc12acf73c
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 13:55:27.3350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S003ZwdEQEmOEiPkfS0Pu3QWUTyH8pPll2Sa+UugE9SwxmoZ4epnJuCcaJaVifdF8wpD11zWiPxaPl+nfKgp+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR08MB8737

Hi Javier,

On Fri, Jan 05, 2024 at 08:21:25PM +0100, Javier Carrasco wrote:
> Hi Jeff,
> 
> On 30.12.23 21:29, Jeff LaBundy wrote:
> > Having reviewed this version in detail, it's clear how the implementation
> > imposes this restriction. However, it's not clear why we have to have this
> > restriction straight out of the gate; it also breaks the "square doughnut"
> > example we discussed in v5, where a button resides inside a touch surface
> > which is split into four discrete rectangles that report X/Y coordinates
> > relative to the same origin.
> > 
> > From my naive point of view, a driver should merely pass a contact's ID
> > (for HW that can track contacts), coordinates, and pressure. Your helper(s)
> > are then responisble for iterating over the list, determining the segment
> > in which the coordinates fall, and then reporting the event by way of
> > input_report_abs() or input_report_key() based on whether or not a keycode
> > is defined.
> > 
> > I think the problem with that approach is that touchscreen drivers only
> > report coordinates when the pressure is nonzero. The process of dropping
> > a contact, i.e. button release for some segments, happens inside input-mt
> > by virtue of the driver calling input_mt_sync_frame().
> > 
> > It makes sense now why you are duplicating the contact tracking to a degree
> > here. Therefore, it's starting to look more and more like the overlay segment
> > handling needs to move into the input-mt core, where much of the information
> > you need already exists.
> > 
> > If we look at input_mt_report_pointer_emulation(), the concept of button
> > release is already happening; all we really want to do here is gently
> > expand the core to understand that some ranges of coordinates are simply
> > quantized to a keycode with binary pressure (i.e. press/release).
> > 
> > In addition to removing duplicate code as well as the restriction of supporting
> > only one X/Y surface, moving overlay support into the input-mt core would
> > remove the need to modify each touchscreen driver one at a time with what
> > are largely the same nontrivial changes. If we think about it more, the
> > touchscreen controller itself is not changing, so the driver really shouldn't
> > have to change much either.
> > 
> > Stated another way, I think it's a better design pattern if we let drivers
> > continue to do their job of merely lobbing hardware state to the input
> > subsytem via input_mt_slot(), touchscreen_report_pos() and input_mt_sync_frame(),
> > then leave it to the input subsystem alone to iterate over the list and
> > determine whether some coordinates must be handled differently.
> > 
> > The main drawback to this approach is that the overlay buttons would need
> > to go back to being part of the touchscreen input device as in v1, as opposed
> > to giving the driver the flexibility of splitting the buttons and X/Y surfaces
> > into two separate input devices.
> > 
> > When we first discussed this with Peter, we agreed that splitting them into two
> > input devices grants the most flexibility, in case user space opts to inhibit
> > one but not the other, etc. However since the buttons and X/Y surfaces are all
> > part of the same physical substrate, it seems the chances of user space being
> > interested in one but not the other are low.
> > 
> > Furthermore, folding the buttons and X/Y surfaces back into the same input
> > device would remove the need for each touchscreen driver to preemptively
> > allocate a second input device, but then remove it later as in patch [4/4]
> > in case the helpers did not find any buttons.
> > 
> > What are your thoughts on evolving the approach in this way? It's obviously
> > another big change and carries some risk to the core, so I'm curious to hear
> > Dmitry's and others' thoughts as well. I appreciate that you've been iterating
> > on this for some time, and good is not the enemy of great; therefore, maybe
> > a compromise is to move forward with the current approach in support of the
> > hardware you have today, then work it into the input-mt core over time. But
> > it would be nice to avoid ripping up participating touchscreen drivers twice.
> > 
> > Thank you for your patience and continued effort. In the meantime, please note
> > some minor comments that are independent of this architectural decision.
> > 
> 
> Thanks again for your thorough reviews and proposals to improve the code.
> 
> I am basically open to any solution that improves the quality of the
> feature. If I get you right, moving everything to the input-mt core
> would hide the overlay stuff from the device drivers (which sounds good)
> and a bit of code could be simplified by using the existing infrastructure.

Yes, that is the idea.

> 
> On the other hand, adding this feature to the input-mt core right away
> increases the risk of breaking things that many users need. We are
> already using this feature in some prototypes since v1 without any issue
> so far, but it would be great if it could be tested under different
> circumstances (hardware, configurations, etc.) before it goes into the
> core, wouldn't it?

I agree with you. Thinking about this more, immediately introducing this
feature to the core is a relatively high risk that would be shared by all
users. I like your idea of introducing a preliminary version first before
making heavy-handed changes. That's the beauty of helper functions; they
only impact users who explicitly opt in.

> 
> I would also like to know what more experienced people think about it,
> if we should go all out and add it to the input-mt core now or as you
> also suggested, move forward with the current approach and let it
> "mature" first. The cost of that would be modifying device driver code
> twice, but I suppose that not so many drivers will add this feature in
> the next kernel iterations... maybe you? it sounds like that you might
> have a use case for it :)

I don't have an immediate use case, but I've been looking at this from
the perspective of a future customer of it. Maybe the right path forward
is as follows:

1. Stick with the same general architecture of v6 and its "limitations",
   which in practice are unlikely to be encountered. I imagine the overlay
   layout you have been using would be the most common use case.
2. Make the handful of small changes that have been suggested thus far.
3. Consider updating patch [4/4] to combine the touchscreen and buttons
   into the same input device as you had in v1. This sets a little simpler
   precedent for the first user of these helpers. If later these helpers
   do get absorbed into the core, thereby forcing a single input device,
   the st1232 would continue to appear the same to user space.

Does this seem reasonable?

> 
> >> +struct button {
> >> +	u32 key;
> >> +	bool pressed;
> >> +	int slot;
> >> +};
> >> +
> >> +struct touch_overlay_segment {
> >> +	struct list_head list;
> >> +	u32 x_origin;
> >> +	u32 y_origin;
> >> +	u32 x_size;
> >> +	u32 y_size;
> >> +	struct button *btn;
> > 
> > I think you can simply declare the struct itself here as opposed to a pointer to
> > one; this would avoid a second call to devm_kzalloc().
> > 
> 
> That was the other option I mentioned in my reply and I am fine with the
> modification you propose.
> 
> >> +	if (fwnode_property_present(segment_node, "linux,code")) {
> > 
> > Instead of walking the device tree twice by calling fwnode_property_present()
> > followed by fwnode_property_read_u32(), you can simply check whether the
> > latter returns -EINVAL, which indicates the optional property was absent.
> > 
> 
> Ack.
> 
> >> +		segment->btn = devm_kzalloc(dev, sizeof(*segment->btn),
> >> +					    GFP_KERNEL);
> >> +		if (!segment->btn)
> >> +			return -ENOMEM;
> >> +
> 
> 
> >> +	fwnode_for_each_child_node(overlay, fw_segment) {
> >> +		segment = devm_kzalloc(dev, sizeof(*segment), GFP_KERNEL);
> >> +		if (!segment) {
> >> +			error = -ENOMEM;
> >> +			goto put_overlay;
> > 
> > For this and the below case where you exit the loop early in case of an
> > error, you must call fwnode_handle_put(fw_segment) manually. The reference
> > count is handled automatically only when the loop iterates and terminates
> > naturally.
> > 
> > Since nothing else happens between the loop and the 'put_overlay' label,
> > you can also replace the goto with a break and remove the label altogether.
> > 
> 
> Ack.
> 
> > 
> > Kind regards,
> > Jeff LaBundy
> 
> 
> Thanks and best regards,
> Javier Carrasco

Kind regards,
Jeff LaBundy

