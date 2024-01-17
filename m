Return-Path: <linux-kernel+bounces-28424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF14282FE5D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E549C1C24EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF8C138E;
	Wed, 17 Jan 2024 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="glB33J+j"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634B07465
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 01:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705454653; cv=fail; b=WFKur1RWdtg0NWCEeMs9x59Zn+rVvsBuvRQFtA8rhNnpb+mrPaaQEYJo/22tKPO9qn+SyLkhdw15KwcMAPixEvtQFIMoxDluc35pTOq3Qf/sBgVyguDrVrBrWmxLZ4D4+xZknfw0Tzt1CvPxWjTjSYDnti9QQ6NNpIvB51ndCW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705454653; c=relaxed/simple;
	bh=QLuzEA/xW/iZrEcR38h/dCtDF0BLGg3QmjBjFCB+8lY=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=A9YFEbekhb5epGOkSOWHWeXHsYx/NwOvEE6OstA9mj4KUYzZqcFhZwT49psOp2ZRE7S4qOX1OFUUQGYWLfBmyk721JFJpN7EMKTju7NNdAsSV3yEWU2k9DgokMR/0dVk5y2wrw8ePd0WD9X4UFvjHKMk7bSlEDO/bWdeb58ZYnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=glB33J+j; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705454651; x=1736990651;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QLuzEA/xW/iZrEcR38h/dCtDF0BLGg3QmjBjFCB+8lY=;
  b=glB33J+j2C9ZQCrc8go2R7+Yt131R6oqYYBoEp0aw12/NQf0BXpro/8V
   W6breZ0N7MkpHITmUvIKGi3jticoIccB9+X57y/NqwD8+m4MTC1F6EIEX
   ZAD5x4sBAWKhINS4nMz0jzq3l1PrbKktkv7hoLwGssh4if9Y5rf9NmMCv
   Bd2JlTnOEq+YivCT67eqEBB1QamATpethF5hbEx8J86gGsNSwo5319Gt/
   x62bHl0YlGUcdH1+Zr/SRZulhnSaSLufD3AD5Cf9HWSJOQhUbb4LoTezE
   DEqCtI7UPnXB66g1tLjaWNz/STNtyCn6hGPAO2n+CDl7itnwSHO8tXb4O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="7428495"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="7428495"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 17:24:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="733795431"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="733795431"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2024 17:24:10 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 17:24:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jan 2024 17:24:09 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jan 2024 17:24:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImDWSosRxaxvQPpspojKXxOGE1rpSAvkC3uSYkTrMurRgmkbWb3s0WqHszLvM+gj5FJLscg3/umO1VMHNEWBZ7KKEF8WiCJW1pBvxFJo57rC0tZe/b8TL+Cn7EZVrzBG2XxBcI+8bGHxARYtDJ+9pxthCIw5RPbhFs4pI/A50wCetB2ZRP4QJSp3b1bMA3vAMXa8qK7HruDI12w8H9Sazo8kFIqtZpdcgyU035wVQ7Lp3g7RnlJtChnGhBtpB7xh9Sfepzxmk3Wn1JqOyyIJ+OgZCs8K47Q627GBgdL4RUUewiDQ5f9YFrEGftjs6GXLQ59zIJr26vojdRQDGz7pOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8zpfIVStrSMQVaZ9rUpAwKyc9mDBIpZHK9rqiBmTEU=;
 b=JPqh7OkNoBUw4+dT8DvWwXK7Q5T+RfGU2wAy8LrDds6/xGl+w9gKw5WaCINItJ1ag3pm5Dgp5buv6ko2VKyvC1cgkxhG+OgOz6t3C8KV0Wup/GTdbuVD2fR7I51HqKoLebPjxiiCGoobzQzcyV+8iBJ9bxiBTenfdj0q/SAczw+KMdW0zpVRLvAMOZAThKEjaW/IcqiqcHKpHNTuAy1as+IBZHNDl+9SzYsya1xidv4FUN0xs2I1iLHwOPWnDbBJPKlcH95ijZBF5urjDQfRSSCby00vljLIsJLhkXzLAH33Js9oVWpHDcrRYrSr5RGD6kW5lxVQB89+GKtes2Vj0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6120.namprd11.prod.outlook.com (2603:10b6:8:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Wed, 17 Jan
 2024 01:24:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Wed, 17 Jan 2024
 01:24:02 +0000
Date: Tue, 16 Jan 2024 17:24:00 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Samuel Ortiz <sameo@rivosinc.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
Message-ID: <65a72c305291f_3b8e29484@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240114223532.290550-1-sameo@rivosinc.com>
 <20240114223532.290550-4-sameo@rivosinc.com>
 <1bbf8d3e-aa94-48c7-a1e4-76f9eefc4af7@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1bbf8d3e-aa94-48c7-a1e4-76f9eefc4af7@linux.intel.com>
X-ClientProxiedBy: MW4P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: e9fc680c-6cb0-44d9-7bb0-08dc16fafd2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/sWNsQNTUcHF1K1eEFsEuoNQgsFVbXdyJTpGyKARqxtZhaSMTfLDTbPVGaqC+12e2wFRX2ngE20fTUBdUydpBhQAy8sf9iZNLWZBdkIBRRDmP8HjV/2YeOfFftX5nYelPLOQ9jMKdgX1ay8xs7vebSoZp7kowXEIVeMggTEIat3Mxe5a4SmvXVq9GGu/j7EdbUEi3DVe5rYomnS3TcTj7QfbpswewD2dhY39o3V3iLFnBBTc8ZHpOd6fNH0eFJ9MZaH5OH3XKcVEj0K7/PyXiJ5/DWvFbuKddfyjTE9/avmS8dW8GmePzaj7AGBIWSjJtRqUpiZoO1kDOskOtW6Z9z35lP/aWOjSMURKrmJ8kIvEK8horccZeyS1Zhaua78O4ziUOxzSKXpgkfJCIo9GfdfaaizbDTU67csefFGf+Y2KFemvDL3FsNnmTr28aqeOTMNGz1RgKPvk2CfyAEXJPN9IzCbMCZSolq3A9095yP9SRIn7fJ2ru2riwgzCGcN1pkqX+E4gPdAw4RAd2NuLdSAj3HjTW/NxH+j/K4QW1sMJuYMqXD4DpRf1pNY3EeP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(316002)(110136005)(66946007)(66556008)(66476007)(9686003)(6512007)(53546011)(478600001)(6506007)(41300700001)(6486002)(8676002)(4326008)(8936002)(2906002)(5660300002)(83380400001)(38100700002)(26005)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CIlLovDqBWKHnQFIotRDtnsV9whRjyjL+DgjR/4QJoYUwXRqq+HqfaUlJtw0?=
 =?us-ascii?Q?ExN599ew6RxCvGl7edLxXjbGyUeRhbmJ2QJBSHi63W0n9En31BRF2W45wqoR?=
 =?us-ascii?Q?FT/NJWRUmQSf3ETzOGr77LaLOWkMldoPoLP11bbx0OWfUix169B6t5rhuNWW?=
 =?us-ascii?Q?k8XxVzqlBdCdG7E+t7k22bukAbkIQ651p9lZDZr1sOV/65SekyQeETjSoCRh?=
 =?us-ascii?Q?0rXWlERMEjtTbnCkk3AhUVmvUdZJ7/uf1JSQAXUdqxULZ+VrDkpi8wAb0WyF?=
 =?us-ascii?Q?ihPwoWZfN1Xn4DjAyJ6aqEXBSGGBS1FEOKqA+FUwWGlhITg0cCtzT7AsFvDj?=
 =?us-ascii?Q?3OVdvM1fv2htWNTO+7Dwk1nx0HTFX3nNHe5Pf1JXyLlN6pJi0n3pzJO4Cw4i?=
 =?us-ascii?Q?58E3mlVTbXVC09pXch/fXiY5lMlpwsTBYlwg6JtbYAW9KuR3CDzVUTkpgMDC?=
 =?us-ascii?Q?VV4DIK8K2HjYBDwq2oywbrgDkJ6Az1yTxw4S8It2GkSkV9+6vINHtEZGmA03?=
 =?us-ascii?Q?9U82X3NDCr5mphi13Ah4phz9dzo1BJsYhHipmyHloKmqAHA7GdosI/uHS9HY?=
 =?us-ascii?Q?0P77B+MpZtgixqyo4fydBWkq8UynisczcSdavAYmRUHPACI8zpv8ALSOIKD7?=
 =?us-ascii?Q?tQtL+64j9y4fo6C9ZSkqhqHjwLVJ00rkgpWHdLa3E+nkaAkfnYLS8d4SqL1J?=
 =?us-ascii?Q?Geb50iPGqlU1RMI2ZDMtLltMh52v1RkYOWDZWslCXFuG/i6vr/DRuux3XTSc?=
 =?us-ascii?Q?OL9sI8/yeIoZmKH91nz5Ex3Y/fR4aERwC69BmtY4q3LjqQd0EtCbEX6HSiBn?=
 =?us-ascii?Q?+a572oiG35g5hJo0lTJ4tAUcL3o55ZcBgC0YaCRJGD8LmCwfqxUZ3Z8483WX?=
 =?us-ascii?Q?/y1XsJUEXLWkPBiwtn2i/U+f08pV4qy5wqbTGdldTj/MCDVaMHNSCXb7Savf?=
 =?us-ascii?Q?FE6ZX0RwVZcBvHgQWgLo8eVP4So2++iK8bLRjTXNcSpKJkOvVAqq3sxHDWQn?=
 =?us-ascii?Q?RF/oeIRT6n977Wm5/YeDC8POWS54DuCpYRroT2HxBnm9eyW5I2QEcYS94Z9T?=
 =?us-ascii?Q?+uY1FKQDJTnAku60cc/8IDBbD1R8V/yyrU6mf6z8t+HVfSoxCYm/ndoptGwW?=
 =?us-ascii?Q?UFgQP3B9i8UwgACUOQr35kzXzTNCjQJoMQZO4U0q9adtgNcz0PTEFVV5qLCN?=
 =?us-ascii?Q?TMep4W39UD52SyWh4pmNZr2s8GIsU8gTxehQvu+lFrmM1rna8Uk0pWRANYmk?=
 =?us-ascii?Q?UDo8Iub2e845Rd5xS3VwjUvEBR3wv3YxLgsyeQ1+iugVpjtvNaX58POldOKK?=
 =?us-ascii?Q?pYP8zUY7/s/0S3hNykompNPNDusBEKDEQPO3egVi3M7ZYxU9ejbcvQo1JX0z?=
 =?us-ascii?Q?qb1/FwQvGaaQrqoCzVLgxmIhJmXXqvFBJ+c8EqxoDd/wtdGMj1zem/Z+OU2P?=
 =?us-ascii?Q?m7o43SlL8Z6C9NGYdfTn0bRdwipmegRW0xhOwE7kWaxfQf5mKR6ugFfyJ/05?=
 =?us-ascii?Q?6ZN1aGIHBAR7ZKEYHbnE0MrEY1IR9urUKaRouCvqO6XvnGClbjcTMLmzkXrU?=
 =?us-ascii?Q?Qha3sVU+uzNPdS3hechV7jKyAGk2rZYwj/GO9BumdbhartmUQi0kHXBoBP+w?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fc680c-6cb0-44d9-7bb0-08dc16fafd2d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 01:24:02.6247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chdyRUKkzp/6YwnnWZmQW/LAHsjrIM/QZkf/9pyqiH0/JGWzLDexzfB2btq9DRI5rTqlxrpzb43QiuTOy3o2C1yGsymH1Q1fgvDu4Jjph2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6120
X-OriginatorOrg: intel.com

Kuppuswamy Sathyanarayanan wrote:
> 
> On 1/14/24 2:35 PM, Samuel Ortiz wrote:
> > Many user space and internal kernel subsystems (e.g. the Linux IMA)
> > expect a Root of Trust for Storage (RTS) that allows for extending
> > and reading measurement registers that are compatible with the TCG TPM
> > PCRs layout, e.g. a TPM. In order to allow those components to
> > alternatively use a platform TSM as their RTS, a TVM could map the
> > available RTMRs to one or more TCG TPM PCRs. Once configured, those PCR
> > to RTMR mappings give the kernel TSM layer all the necessary information
> > to be a RTS for e.g. the Linux IMA or any other components that expects
> > a TCG compliant TPM PCRs layout.
> >
> > TPM PCR mappings are configured through configfs:
> >
> > // Create and configure 2 RTMRs
> > mkdir /sys/kernel/config/tsm/rtmrs/rtmr0
> > mkdir /sys/kernel/config/tsm/rtmrs/rtmr1
> > echo 0 > /sys/kernel/config/tsm/rtmrs/rtmr0/index
> > echo 1 > /sys/kernel/config/tsm/rtmrs/rtmr1/index
> >
> > // Map RTMR 0 to PCRs 4, 5, 6, 7 and 8
> > echo 4-8 > /sys/kernel/config/tsm/rtmrs/rtmr0/tcg_map
> >
> > // Map RTMR 1 to PCRs 16, 17 and 18
> > echo 16-18 > /sys/kernel/config/tsm/rtmrs/rtmr1/tcg_map
> 
> Any information on how this mapping will be used by TPM or IMA ?
> 
> RTMR to PCR mapping is fixed by design, right? If yes, why allow
> user to configure it. We can let vendor drivers to configure it, right?

I assume the "vendor driver", that publishes the RTMR to the tsm-core,
has no idea whether they will be used for PCR emulation, or not. The TPM
proxy layer sitting on top of this would know the mapping of which RTMRs
are recording a transcript of which PCR extend events. 

For IMA the situation is different because that can be a kernel internal
configuration flow without need to involve userspace.

