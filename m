Return-Path: <linux-kernel+bounces-17966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E9682561C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028302830CD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BB02DF66;
	Fri,  5 Jan 2024 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lp0PKQPr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6A12E3F0;
	Fri,  5 Jan 2024 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMgvF1ubFyP1oD9dH3SEtOXhxWxIpS1TYyDvtzn2+PCmUVkc8szZvf1DACmz8gJjA7h7ClO+AaKWCvJXvwLzTd2CQ9teCuOPUYdz/gPX0h2yloqxNQnximNUj6JYC6knWmfwmo1y9iRSya4YEHlxT65dqQA4awnCVsJr7O2MHVpUhcZk79u8gspyRlH8p+E6/OUZ3elI9fe7cklRpd9ICBZw1oUp8l+jK7qJg1s5PagokqaY4PoiZo1DmmOeTzyhNRIfCMt70490ZZPKE181di2lPr3MzhLt8xuuxJURqwNPSLmPLr/O/3RvgnqdcZjiWjAuKXKLL3H4Nizk0uKmsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6gaxjHIlLXhpsvX81KHN77DC3V58eU88r2RS2Yd6xI=;
 b=BcdgleNF7QkfIYqte1cn9TM1EXFrC4efM8rP7AtTWYGpxoukKR005WlWHtx0BtQtTK5ylMVgQoeDOLwKvzMbo0Fhe+2YX1MPr2ZnPc4pN77ifaK6qzRJQ4BLRYV7NdMVL0Ep3/0McRjlL9Ec1c0nU9/ZabkX243bcniJU5rBWxl8/q4EktejfEnNzgW/7NWdY2wKogY/wKr7WG9fMEpdhFOL0XxKqPQBU4q5hq8FkeNGHuQhXBOuQycgT5DsgWz57OoRx3O4R2GG5AtIzQOCDArXp0Dzx81S4oY9cI7pkJ69OsjZzrPCi/1Zc1/PkCe9BHRZXxGBcWLCgc3Fask3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6gaxjHIlLXhpsvX81KHN77DC3V58eU88r2RS2Yd6xI=;
 b=Lp0PKQPrfhcIzHuyu0UmyWym6X9DqNv/MT1SEL2RhYJS3NlZ1H4ZrTad7UxX3rAAW+RT64xpdr18sG3BhJlocgId0tPYH6mfWQQyUmsfJWYERBeeZ4sOQViuUnm8P8JW1AL749zp9JYqrtZ9DTTcAthqCklEBWx76qwkK99owf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by BN9PR12MB5212.namprd12.prod.outlook.com (2603:10b6:408:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 14:49:48 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::5786:22a:27df:9a70]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::5786:22a:27df:9a70%7]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 14:49:48 +0000
Date: Fri, 5 Jan 2024 15:49:42 +0100
From: Robert Richter <rrichter@amd.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Fan Ni <nifan.cxl@gmail.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] cxl/pci: Get rid of pointer arithmetic reading CDAT table
Message-ID: <ZZgXBjyh4WbVULJe@rric.localdomain>
References: <20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com>
 <ZVfIaNhiSc-yQZo5@rric.localdomain>
 <ZVfJ6Fxidvw_gz7r@rric.localdomain>
 <656648433bd82_888fe294a6@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <656648433bd82_888fe294a6@iweiny-mobl.notmuch>
X-ClientProxiedBy: FR0P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::7) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|BN9PR12MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: 890b5746-785e-4f6b-c303-08dc0dfd9054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UxodUKjRJEklmXHBRSf4i3GpwMNL9LeG6zhSenvbZ6bjxB7+YQ+gJ8rcOR2TC41PKU9jAFv/QzzXpUDihUyN0/yFE/ZeJfFk0Yj6eReHNZ46jXvx3+yIwM0x42vTsg7OTX6xSZ4CMYk3jlZUuVYgBH1P0Nqhd1w2fHLSIIv4UeTQG1ISVaLQHPStoZpraRPfSV160qV69BUbgsWOZ8OFnrjYQ/oObFMELKXa0G2w/ZsNHWYruLPiXZjSDyQcriZ7p1/i20SmIyCSTkXszDPsF+LwyKsJlfZU8WQdavDHXUG71MhCubhbOx/fREa4jKY8n2c1mp5EwkFDgaD/qM4FM4VUqMWOud6yJUOzBTvhhMeQsP9AZnUB/TqBVdnw1+MFZaE9qWyTtSjFzUoZ0dUrupnrDA3/N4pAmBBhWejhPr1LJwRFseJPvfhqMsmP9AshOwgiwkyzO/5GHzMD/qXn7x3SfnnYPzebTvYvcS/EJJNGrxOR73n4/KWtWAKUz6llEOlDc9HwqKtEdAhimLh0gq3vMP07XXdC2290a4Fg9eny3fog/JfIq5Rf8C7V1GuvrZnBJt8/OA/WjpmIIiXJeIVUg2UPeg1JXpbc63/azsg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(26005)(53546011)(9686003)(6506007)(6486002)(478600001)(6666004)(6512007)(83380400001)(7416002)(2906002)(5660300002)(41300700001)(66476007)(54906003)(66946007)(66556008)(316002)(8676002)(8936002)(4326008)(6916009)(38100700002)(66899024)(26583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lfjZOfW8WmARuDkWv545ViZIyhQ4q8hDdcqPdriWURX0h8BF926Kpkw9HuJU?=
 =?us-ascii?Q?dvLbg0vSdt+OwGQIuz2n0u8tCGePbJApD0cPoWHjvg/b/V8qGwUXqEf2qmdw?=
 =?us-ascii?Q?ff+2HS3RsKufQ7WfvcrqLf5P0RcE8fwMzMS/sLNYIXEHsvVTRPVS7dEGip0v?=
 =?us-ascii?Q?N3CBOI4X9aP6zwvWD9AwZ/cruFPlNb0caDCq3ewmTkPfsVE9oPs1EmCqaFwb?=
 =?us-ascii?Q?fD73dN3j2WbY8+z2mWIgJigx8EEthbz+I5UG+1PRloNOfUf7lFcVDI3vb/4G?=
 =?us-ascii?Q?AIboEFZ01I1WYSoxP+PVYqTD9MGzoNvrHXp0C3qVZJ5G/C89LpZvhsV0TSnn?=
 =?us-ascii?Q?gNKjIT5vmjF6kB1GGLuSsrMk+taDM0kB9KBxZ4m2gHhh+sSM44m2D8KR81n6?=
 =?us-ascii?Q?lflTMIeUw4BZ0usqPJXZGUmM7/N7ctdUYsPY1WmxoVRtUluRvV2hDuAEOLZ2?=
 =?us-ascii?Q?i/Y+jZRNXYSTrXPUGHeeX6qlw2idfCTDdJ4mzOgws5oOVkbMcAA36m/DrWIq?=
 =?us-ascii?Q?//2nGg+GTudt/uUUQB2hNFBYoA9G0WBbJQ6qSfkbO2BV/zf/nN8A3dYYm41U?=
 =?us-ascii?Q?7kYRFh393D5AIxupebTVeT4jMzSMkCpLlM2ooCfeZZ2vYGaGFc+L/vfqPz/l?=
 =?us-ascii?Q?XaOj3l5mtT2HAGKGH+ZcbuoGTVel2ljDni6iXP0pupQ9KRJISLoo5Lx2Hpfu?=
 =?us-ascii?Q?HsJV2R/ftguDy4FwUiregxXsFpZIjgFoy7F0uQc6cUyx0qaoJtE0L/bR/aYs?=
 =?us-ascii?Q?DAFr17OAmDLUbPo68lSQVttgYTrp2Nr6EFUXZyrPEwnV8rvNP9cGNYzBztlY?=
 =?us-ascii?Q?x/i6EUwKIixmnKFpLmYzwiBgEQsepHtFOu+CjwyTEbX7a9d7vmKehhRzcgtg?=
 =?us-ascii?Q?8XsPaRUI7+tjTFNLQ2ivO0Po1JYUTw/VIQqiz1uWVXf6sbVHvhw1m4PU0hzZ?=
 =?us-ascii?Q?YKuhG64E/20tx7rpy+ez5N2n8loPwfrXjo+gUiNxy9xJjgsNloUt9NZgFPdY?=
 =?us-ascii?Q?Bm+EHyLxbdbeSmfpJt1PqFf9BY2MdzOI97sQ+P7+qUby63ROoZXUc1CW0AgU?=
 =?us-ascii?Q?Lp5SlCaYjXSmpP8Ro6Vs+Olsl6NAeRaZfdyS/1qKVh3KBkf3448o9PTHn1gG?=
 =?us-ascii?Q?6+We/1HDMzZBCHdEXL48ESAIFuoIZUf4d+MrHHlcbGNIT/iJElK5JKIJ372S?=
 =?us-ascii?Q?G6TdY3fVM0YURPlChohrDdS3rCHg2kiCxtgGKSGdM3tALRUPmw8b95rZK+Jr?=
 =?us-ascii?Q?c708dc9vDMdov/cjFlVPShkfR7QmoDK5TNBojZIzhjTDsfzK7GXrSFeloLrT?=
 =?us-ascii?Q?REY1Wcn5pErWl9S30Poa6BHgAubdYK0TV+T65yb7R34FoZYU7DByFVgfdNbL?=
 =?us-ascii?Q?9OS3s+kW7+N7c9eNCG9I/K1onUPMy6XNVkxQ0NzpAeSB201Xv80biBgmlCdb?=
 =?us-ascii?Q?51OZiVL0ng6+Z2qWyXDfZWLtQ85u4IACwNiAZwDNHkqOBH2SR2r4SdlaS38F?=
 =?us-ascii?Q?YvvMEfR8VY9Xya90yCa+XaJaQippD7AAfafyLMnVzM+Yad45SH2iwyJ/zQQ0?=
 =?us-ascii?Q?OVegRR262ub7lmCnJna31n4UUaA1cgsnEgEQk75N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 890b5746-785e-4f6b-c303-08dc0dfd9054
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 14:49:48.1592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhONntRLx7zUWJUxhdIOwa9E0BjvIVW14s70Lrfcx04oaBEmWG1cCi23T6D+h3C44qkBB4oW+wqr3LWI4LdBuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5212

On 28.11.23 12:06:27, Ira Weiny wrote:
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
> Thanks for this.

Thanks for your comments.

> 
> > 
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Fan Ni <nifan.cxl@gmail.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/pci.c | 80 ++++++++++++++++++++----------------------
> >  drivers/cxl/cxlpci.h   | 19 ++++++++++
> >  2 files changed, 57 insertions(+), 42 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 5aaa0b36c42a..f900740c6dea 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -517,14 +517,14 @@ EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
> >  	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
> >  
> >  static int cxl_cdat_get_length(struct device *dev,
> > -			       struct pci_doe_mb *cdat_doe,
> > +			       struct pci_doe_mb *doe_mb,
> 
> NIT: Why change the variable name here?

There was a conflict with cdat_doe, so I renamed this. Now, that
cdat_doe is not introduced any longer there is not really a need. On
the other side 'doe_mb' is much more describing the actual meaning, so
I decided to change the name anyway in the next respin but do this
with a separate patch. This makes esp. this patch much more
readable. And of course. Jon would complain about it. :-)

> 
> >  			       size_t *length)
> >  {
> >  	__le32 request = CDAT_DOE_REQ(0);
> >  	__le32 response[2];
> >  	int rc;
> >  
> > -	rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
> > +	rc = pci_doe(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
> >  		     CXL_DOE_PROTOCOL_TABLE_ACCESS,
> >  		     &request, sizeof(request),
> >  		     &response, sizeof(response));
> > @@ -542,56 +542,54 @@ static int cxl_cdat_get_length(struct device *dev,
> >  }
> >  
> >  static int cxl_cdat_read_table(struct device *dev,
> > -			       struct pci_doe_mb *cdat_doe,
> > -			       void *cdat_table, size_t *cdat_length)
> > +			       struct pci_doe_mb *doe_mb,
> > +			       struct cdat_doe *doe, size_t *length)
> >  {
> > -	size_t length = *cdat_length + sizeof(__le32);
> > -	__le32 *data = cdat_table;
> > +	size_t received, remaining = *length;
> >  	int entry_handle = 0;
> >  	__le32 saved_dw = 0;
> >  
> >  	do {
> >  		__le32 request = CDAT_DOE_REQ(entry_handle);
> > -		struct cdat_entry_header *entry;
> > -		size_t entry_dw;
> >  		int rc;
> >  
> > -		rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
> > +		rc = pci_doe(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
> >  			     CXL_DOE_PROTOCOL_TABLE_ACCESS,
> >  			     &request, sizeof(request),
> > -			     data, length);
> > +			     doe, sizeof(*doe) + remaining);
> >  		if (rc < 0) {
> >  			dev_err(dev, "DOE failed: %d", rc);
> >  			return rc;
> >  		}
> >  
> > -		/* 1 DW Table Access Response Header + CDAT entry */
> > -		entry = (struct cdat_entry_header *)(data + 1);
> > +		if (rc < sizeof(*doe))
> > +			return -EIO;
> > +
> > +		received = rc - sizeof(*doe);
> 
> This is not ideal.  See comments on struct cdat_doe below.

Thanks for your kernel doc pointer, I will rework the flex array
handling.

Here, there is not other way to get the header size of the struct
(without the flexible arrays). Looking esp. at the implementation of
struct_size() using sizeof() for actual variables is allowed and safe
to use.

> 
> > +
> >  		if ((entry_handle == 0 &&
> > -		     rc != sizeof(__le32) + sizeof(struct cdat_header)) ||
> > +		     received != sizeof(doe->header[0])) ||
> >  		    (entry_handle > 0 &&
> > -		     (rc < sizeof(__le32) + sizeof(*entry) ||
> > -		      rc != sizeof(__le32) + le16_to_cpu(entry->length))))
> > +		     (received < sizeof(doe->entry[0]) ||
> > +		      received != le16_to_cpu(doe->entry->length))))
> >  			return -EIO;
> >  
> >  		/* Get the CXL table access header entry handle */
> >  		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
> > -					 le32_to_cpu(data[0]));
> > -		entry_dw = rc / sizeof(__le32);
> > -		/* Skip Header */
> > -		entry_dw -= 1;
> > +					 le32_to_cpu(doe->doe_header));
> > +
> >  		/*
> >  		 * Table Access Response Header overwrote the last DW of
> >  		 * previous entry, so restore that DW
> >  		 */
> > -		*data = saved_dw;
> > -		length -= entry_dw * sizeof(__le32);
> > -		data += entry_dw;
> > -		saved_dw = *data;
> > +		doe->doe_header = saved_dw;
> > +		remaining -= received;
> > +		doe = (void *)doe + received;
> > +		saved_dw = doe->doe_header;
> >  	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
> >  
> >  	/* Length in CDAT header may exceed concatenation of CDAT entries */
> > -	*cdat_length -= length - sizeof(__le32);
> > +	*length -= remaining;
> >  
> >  	return 0;
> >  }
> > @@ -616,11 +614,11 @@ void read_cdat_data(struct cxl_port *port)
> >  {
> >  	struct device *uport = port->uport_dev;
> >  	struct device *dev = &port->dev;
> > -	struct pci_doe_mb *cdat_doe;
> > +	struct pci_doe_mb *doe_mb;
> >  	struct pci_dev *pdev = NULL;
> >  	struct cxl_memdev *cxlmd;
> > -	size_t cdat_length;
> > -	void *cdat_table, *cdat_buf;
> > +	struct cdat_doe *doe;
> 
> Since we are trying to make this cleaner I would prefer a struct and
> variable name of cdat_doe_rsp.
> 
> So...
> 	struct cdat_doe_rsp *cdat_doe_rsp;

Looks reasonable, though I will use the shorter 'rsp' for the
variable.

> 
> > +	size_t length;
> >  	int rc;
> >  
> >  	if (is_cxl_memdev(uport)) {
> > @@ -637,40 +635,38 @@ void read_cdat_data(struct cxl_port *port)
> >  	if (!pdev)
> >  		return;
> >  
> > -	cdat_doe = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> > -					CXL_DOE_PROTOCOL_TABLE_ACCESS);
> > -	if (!cdat_doe) {
> > +	doe_mb = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> > +				      CXL_DOE_PROTOCOL_TABLE_ACCESS);
> > +	if (!doe_mb) {
> >  		dev_dbg(dev, "No CDAT mailbox\n");
> >  		return;
> >  	}
> >  
> >  	port->cdat_available = true;
> >  
> > -	if (cxl_cdat_get_length(dev, cdat_doe, &cdat_length)) {
> > +	if (cxl_cdat_get_length(dev, doe_mb, &length)) {
> >  		dev_dbg(dev, "No CDAT length\n");
> >  		return;
> >  	}
> >  
> > -	cdat_buf = devm_kzalloc(dev, cdat_length + sizeof(__le32),
> > -				  GFP_KERNEL);
> > -	if (!cdat_buf)
> > -		return;
> > +	doe = devm_kzalloc(dev, sizeof(*doe) + length, GFP_KERNEL);
> > +	if (!doe)
> > +		goto err;
> >  
> > -	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_buf, &cdat_length);
> > +	rc = cxl_cdat_read_table(dev, doe_mb, doe, &length);
> >  	if (rc)
> >  		goto err;
> >  
> > -	cdat_table = cdat_buf + sizeof(__le32);
> > -	if (cdat_checksum(cdat_table, cdat_length))
> > +	if (cdat_checksum(doe->table, length))
> >  		goto err;
> >  
> > -	port->cdat.table = cdat_table;
> > -	port->cdat.length = cdat_length;
> > -	return;
> > +	port->cdat.table = doe->table;
> 
> As an aside: the type of port->cdat may need to change at some point too.
> 
> > +	port->cdat.length = length;
> >  
> > +	return;
> >  err:
> >  	/* Don't leave table data allocated on error */
> > -	devm_kfree(dev, cdat_buf);
> > +	devm_kfree(dev, doe);
> >  	dev_err(dev, "Failed to read/validate CDAT.\n");
> >  }
> >  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > index 0fa4799ea316..d12ed9d8dec1 100644
> > --- a/drivers/cxl/cxlpci.h
> > +++ b/drivers/cxl/cxlpci.h
> > @@ -85,6 +85,25 @@ struct cdat_entry_header {
> >  	__le16 length;
> >  } __packed;
> >  
> > +/*
> > + * Response contains the CDAT only response header of the DOE. The
> > + * response payload is a CDAT structure (either CDAT header or entry),
> > + * it may also mark the beginning of the CDAT table.
> > + *
> > + * Spec refs:
> > + *
> > + * CXL 3.1 Table 8-14: Read Entry Response
> > + * CDAT Specification 1.03: 2 CDAT Data Structures
> > + */
> > +struct cdat_doe {
> > +	__le32 doe_header;
> > +	union {
> > +		u8 table[0];
> 
> At a minimum we need to use flexible arrays here.  See:
> 
> .../Documentation/process/deprecated.rst
> 	'Zero-length and one-element arrays'
> 
> > +		struct cdat_header header[0];
> > +		struct cdat_entry_header entry[0];
> 
> So this would need to be:
> 
> 		DECLARE_FLEX_ARRAY(u8, table);
> 		DECLARE_FLEX_ARRAY(struct cdat_header, header);
> 		DECLARE_FLEX_ARRAY(struct cdat_entry_header, entry);

Changed that.

> 
> Also I think it would be best to use sizeof_field().
> 
> That said I got crossed up when this structure was used to represent not
> only the individual DOE responses but also the cdat table as a whole.
> 
> I think it would be best to call this cdat_doe_rsp and somehow make a
> distinction in read_cdat_data() when assigning to the entire port cdat
> table.

I will name the table buffer's variable 'buf' and add a comment.

Thanks,

-Robert


> 
> Ira
> 
> > +	};
> > +} __packed;
> > +
> >  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
> >  struct cxl_dev_state;
> >  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> > -- 
> > 2.39.2
> > 
> > 
> 
> 

