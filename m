Return-Path: <linux-kernel+bounces-16375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2D3823D97
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0570DB20BFF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A45F1DFC2;
	Thu,  4 Jan 2024 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zxRlYUfW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEDE1DDC3;
	Thu,  4 Jan 2024 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FclJQenVelnCN39/am16dBCDAwtTbb3MptzcTy+FVQalQnSx4Wmkx98Yuxs8stfLXOdMQXfNAm2kq65IefiVkaHqqfNbz0rey/vOFiGcQ63ci02FEZ+o2+lZ79YCWrKU3WDxDCBRJB98br5FBpen9NkU69Mq5y+HdDpXLLt0Bo/kRhINAE/s4mcFjOeO2BvptQeU9v7UP4o5de9c1HtMiSR01F8Emx+fiCBSLmOazdBT1fFvlR6sRo5gIvHqBCjMNnUDqMNz3H7bel6aO55lBX0UULoIoq6BLPhjeDXytjkNZDnppa+2KL0bai9Ont4TlG+yl0J01MoaguE6q2W+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMGkMAcVuyEUKEuhXSUNdWPPvdRxsN061VdyA1fsVjM=;
 b=E12yv86B64WCMGgXFrJjvDbxFO/uvUI5UULYkwuSAhOGJSshHC4iogvvkW/nY3S7YvNBEO/VfC6wc1zhlsXCOIGAxW6nAV2APXk8z6NQb4uPhcL/nx8LjS0sC7nUyEsCKk1nu3pRyaTdg276uW7v60D/05tw+Si+KGUAHEoWsCtQlpkv24FUjpQ2/Rvj6H7HkvqF6/EpFkVwl3cg41QJ1irwznDbGcUxBrcjlsipFFKbe6dVdRrpPv/+cQBTq1gVMb9+OD6tW7geDOzzr49Rs6gXDJCrBcpEkQB+yfWW8UiAkMtLyIJxGez66BAt/TUetg9tWbBBzfIPJdyOOns2QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMGkMAcVuyEUKEuhXSUNdWPPvdRxsN061VdyA1fsVjM=;
 b=zxRlYUfWO8hsvUyBoNMzl/DsSyLUeg8AG8uvR+ReIR2whbClePvph60cImOjbXfDZeLCyhX4R5BSlNhGrE+iU/cvRs/XH8t2piqeEIIWDNo4DLsAasHCm6PqVI+UqXDCUr8lk8DPAhqXr3TJdWNvDYxCDwQbdxtVFE990PLS6HY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by PH7PR12MB8016.namprd12.prod.outlook.com (2603:10b6:510:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 08:41:42 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::5786:22a:27df:9a70]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::5786:22a:27df:9a70%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 08:41:42 +0000
Date: Thu, 4 Jan 2024 09:41:37 +0100
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Fan Ni <nifan.cxl@gmail.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] cxl/pci: Get rid of pointer arithmetic reading CDAT table
Message-ID: <ZZZvQcWKHd2Pmg3O@rric.localdomain>
References: <20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com>
 <ZVfIaNhiSc-yQZo5@rric.localdomain>
 <ZVfJ6Fxidvw_gz7r@rric.localdomain>
 <657bd741d2961_269bd294d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657bd741d2961_269bd294d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: FR3P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::22) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|PH7PR12MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: e38b1026-07a3-4960-0194-08dc0d00f9e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WSrKTrt/rFIjEC3X/q/DeSz7BS8BBRrjMqoXJkmvaszbXuB1lg3Gxyz4eCVJiRFPlLgnk+49emZlpimGQ/BSJ/HICcFTjRvVdP74UvTUcr2ym0ezD6Czo8sXPmxoGF1K9y9Ls8E0cW1nFcJy5E9HrHW9A/qucEpl8gzOrRF0cuKWo7dmrbztenUx0C5qm7fE+U+s+RKfNu190cnEJQw9MhzavFrTFNjPxoDPSz5B1Hi3cxVCv/+7vBC4NbIohE3dTyb/i+cWy67OEV7PTyISk3W2lLXQy9uVhMRu4DFzJ09SyFUo1XWt0C7+ax+h0OtFWrc/sAeVL+Ls8Zj0uaHgvh6+fBhIF79J+N1NWG59hBDKyZaUN6T1m3Xt5f/SUk1bBlDIsC67SVbVtqNFYwbK6jG+5H/T2uEwuoCkV2HT0h9uAHcpGdAkhKb/W/LDFIvg5CBjWidR1kD0XlXrd+bJbvNjaiXCoKlsEVB0TczPexuMm9wmJ9WOuzfoi/IxFVgg87EQkLcQ5suQdJ3PqUEYLSAG+79zdGQO4PDKfEvULtS7nBe9COwyL05nc91yWmsOLYMiv+7qI4vAzfnG5Nl5R28GbSK4VKbHfwRsS2sEVCY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(2906002)(54906003)(4326008)(5660300002)(7416002)(83380400001)(41300700001)(26005)(9686003)(6512007)(478600001)(6666004)(6486002)(6506007)(53546011)(8936002)(6916009)(66946007)(8676002)(66476007)(38100700002)(66556008)(26583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CGtKJ14hF0e7aQR+QfZQqkLT3Du9Rh1xvAYoy55TWrHfZQYRNdhlBvX6Mo75?=
 =?us-ascii?Q?s21rxVF2+ijvuAMnQB9B0t7w7DVeseDsscdqY8+8Gt4PJZaES90zc3tBaO0r?=
 =?us-ascii?Q?tV7TxO9OFw8dTNqHvuJxQhoDGYVfqu8EXI1Q4lvF74SFSLRzhgesyYYing36?=
 =?us-ascii?Q?ewQYtRTSkZpoFXVdjF20jgyAymj2lplOgu3mBk5ChoAYOH8yB13YLmukZm9Y?=
 =?us-ascii?Q?hFQKYe65gOFQw4uhYiuFUTir7agMQaoW8B3ItH0ndohA0ckyNQcXIqB1HWEm?=
 =?us-ascii?Q?zC2F7d9c8m1AObgP7/RPZvm3zcGoiNGrMIYwX/7vbsWlgsaI9PUNeiT6esxR?=
 =?us-ascii?Q?lZ7778pfqfl0DoYzmAP9uJ1lzHRhkyQpjWHc74PQBxSAJAJwEcHjLreU29zH?=
 =?us-ascii?Q?JljKte3jmu+shKl0Tiu9+moOBV+sCXEhovfkoYqGn0FgL4h/768BzAWYH393?=
 =?us-ascii?Q?66wrggqMytlgmr3wo02HEWlGsXMrBvhOss9n2oqKnNMpAuKHxVERekYO9UB6?=
 =?us-ascii?Q?PPnR3h1aCQv5jXpSqgPZTx6IOgSAl8imcXMzKXwKQlh2SgiWt25MkzDyVP2O?=
 =?us-ascii?Q?9yX/Chzf8M+kEp09sR4OlYb6CxJjWzKXU41uSbADZRyqB9+NIM1Ns/6EjfYI?=
 =?us-ascii?Q?aGaiYglgfbGHOPjCqxS1RJN93SnVYb9RAC8e1ySPptsBg976SX11HBWrX3SS?=
 =?us-ascii?Q?ob8tyPZANSSrekfxfKrMtOkyvUS+udxzGKVRabUASNl9X0Ha5s6q8SYCgip+?=
 =?us-ascii?Q?CmY9UuD8qsjSk5CJA9LPokWyPpw5vePCTDnHYXOEF3+6KMGgFLxqHOgXbWrI?=
 =?us-ascii?Q?UieeYY23VKmXiFuAIksQoBncUfshG/HvGQ7XxZSWCX6mHSMqW3eu3MB6K9iT?=
 =?us-ascii?Q?iaa/x+AuhxNlPJSrjTgUECAvv5LvH40SUGc/CfaORPDpu87y/G7dr8XM8K79?=
 =?us-ascii?Q?2ST0dzEXD60mbXsc+Hf6XR7HONvFoX2MYa5J+fDWxa3Y9rB3l/Z/11+yKJDG?=
 =?us-ascii?Q?U6310V8QoOwXWLRSTXAfVYXU57k9/Pt8I/eJfyNXyYqkwDG81jnA1VLaGFAF?=
 =?us-ascii?Q?XGmPbIpGAnLzGBi273InH9qnnbyhZ/vy86DWa6sExWjX7ZSgmJ128JFLd4Fe?=
 =?us-ascii?Q?qG58FiKyg6eTDmoFP2Tul/MkkDQa/HOXsi/ILBkWmnaWy5+nMCE+FQLjWf8N?=
 =?us-ascii?Q?u9JcnLjGgliAhvDzlJDbZoD4AAaVSVh7tlNJNYYlbUKwjRUXD2Oc71Yitepq?=
 =?us-ascii?Q?0mwLFVSJU5sk18GU0S9osJjlIdJ2Sf87fq/cDXT/TJXb7tjnaXcES1xKPDsS?=
 =?us-ascii?Q?r6iox16EOSoWmU4xv6xf5GfqE+Rlf8mdAAErjNeOAiSakxQEJqn9/FvGT9Dh?=
 =?us-ascii?Q?YK6LeR2eXOS3Y7iLZpC4kNE70Q85Ua0E5BqltwhfcmRVAGqaCRSI0rKkm32o?=
 =?us-ascii?Q?qtxS9LlADBMyYxdDOxhKHCeJQ/jRN6M4TYtnC+aG3JqlBlxiJZplXaHtjcWz?=
 =?us-ascii?Q?8XWHLXbJvrraHlzWx8Kjb6Ge4D5nZ5clmrL2RC2PwPHxFWERsp8Y6AOkyoOt?=
 =?us-ascii?Q?GzCQDKyKyaD9asXNBi1Ijr6tOg+YEYtCDmvTGZhB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38b1026-07a3-4960-0194-08dc0d00f9e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 08:41:42.5419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKGgFbjX8BIz2irCv4aE+6XFc1L7RUbzu9hivpFlZQTgCDpA0EiCM0K40bADSYgIT24WL+zJtUvfef091DjTTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8016

This threat slipped away end of last year...

On 14.12.23 20:34:09, Dan Williams wrote:
> Robert Richter wrote:
> > On 17.11.23 21:09:18, Robert Richter wrote:
> > > I will send an on-top patch for 6.8 that reworks that code area to
> > > remove the pointer arithmetic.
> > 
> > Here it is:
> > 
> > From 13787f72c20b8c54754ae86015d982307eae0397 Mon Sep 17 00:00:00 2001
> > From: Robert Richter <rrichter@amd.com>
> > Subject: [PATCH] cxl/pci: Get rid of pointer arithmetic reading CDAT table
> > 
> > Reading the CDAT table using DOE requires a Table Access Response
> > Header in addition to the CDAT entry. In current implementation this
> > has caused offsets with sizeof(__le32) to the actual buffers. This led
> > to hardly readable code and even bugs (see fix of devm_kfree() in
> > read_cdat_data()).
> > 
> > Rework code to avoid calculations with sizeof(__le32). Introduce
> > struct cdat_doe for this which contains the Table Access Response
> > Header and a variable payload size for various data structures
> > afterwards to access the CDAT table and its CDAT Data Structures
> > without recalculating buffer offsets.
> 
> I like reworking the code to introduce an explicit type for the response
> buffer, but as Ira points out, lets call it a "response" not a
> "cdat_doe".

Looks good.

> 
> The feedback on the flex array is accurate, but I see no reason to have
> 3 flex arrays vs:
> 
> struct cdat_response {
>        __le32 doe_header;
>        union {
>                struct cdat_header header;
>                struct cdat_entry_header entry;
>                u8 table[];
>        };
> } __packed;

The flex arrays are due to sizeof(*doe) which is just the size of the
base payload without any variable data then. Another nice effect of
this is pointer creation of @header and @entry:

	doe->header vs. &doe->header etc.

... which aligns with doe->table too.

This all leads to well readable code.

> 
> As far as I can see nothing outside of drivers/cxl/core/pci.c needs
> 'struct cdat_response', so it can stay local to this C file.
> 
> While you are working on that I will do another lead-in cleanup to kill
> the goto in cxl_cdat_read_table() and let you come back and kill off the
> open-coded "+ sizeof(__le32)" that I will leave behind.

I briefly looked into your patch, but will send for reference a v2
with a rebase onto cxl/next and small updates only. I could prepare a
v3 that bases on your patch afterwards.

Thanks,

-Robert

