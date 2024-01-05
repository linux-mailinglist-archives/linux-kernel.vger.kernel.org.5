Return-Path: <linux-kernel+bounces-17942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0E4825576
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE11BB216FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2808C2DF9C;
	Fri,  5 Jan 2024 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WUQhQajz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C592DF91
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTJPT/5rT+zFUc/Onnj6aHA6BSvkkhFJs3OggXNOtQGAKKE3S3s0Ca2arWCQ3JzaxGprIwpFhevmskpDqwfB3KGzWOBP+indAtXa51PZyP/7hFU/fCYKnryI131P1EN38ZMy7F/GqKRP1p/2xNkbReuSehqUq7xUF2qlQS7/yqSC3jlrsEtLmGdRkygsdjdEP22iSBv1O9/sFCHx4x34xOY4RNYBkoMo47iC9rpWPHguUhPUrSGjS/A9ouXA/hxFHoa0cHFG/Ntojx+wTOw0OiOCMCMIWKl/DMrvhXye7dyF9ZX2IyTRyoqJH0DUPOMwx9Wv41Sy3GWhVp08o3bPDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMKxvnAnCHaG7ZnKRJWDM+ji2sJ692dqDN8dU297oAg=;
 b=CKKg0w2WqjS4HmbfLpeAtqp78BdbNwGZfEQcq4Xc59wmUIQ5akmxwd2omynfvDGq3nF45y3mO+P+MCgC5Egn3xDF4s0FRAL6JZGKdD4MnUreq8r0asBIrpJVPNWobGk6jdj2x/rtXqk8oq8+1EyucejRCn4aqxljZtXKzrpkSEcG1QoYkJ6BBvLU4x1yjbTOaTIPFK1YbCxYaHsaWcmDaoh4g4gfFbw02bFYeJZODNLaI+nBU3pti9MDEPCcA+jteJf2zp1t11mcY+YGiKaw3oPPN6HBkA0I2pQpGLu6wNzwQWlly2zT/s2dyksNUGVYfY2sIwqM5Sl/C80dgqR5mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMKxvnAnCHaG7ZnKRJWDM+ji2sJ692dqDN8dU297oAg=;
 b=WUQhQajzcPMhDLlgmpK/rZZHxNCab3KXr4z80Q5vUyxc+qQgpbHHsUvnalh6GmX4Wq+raT7lz0J0YFW19Rh8Igf1WnUpZ0f9SgAupmSrmy44wRaEqeJnBgHyOvVI/ZjYDrDRI6xZvtAtY1zoBCcWS4fiyGXbyshPSHnfvbdnSPRwpDNnaaoLf4FLgEl5CVNEZFQlPsozXbmpBxIJ8Q+Qt7LKV9DrT5KPB/y3cMQhgvtKGa2YHZuxq0+hMzihKuFAdeF+UqzUTOBnkX1rlgwcbPSxW3XxD/TyeILePH5wz1ILE8n0qtZpmvModddZp2GhbF10l1H46wddfDMzyiQMyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5050.namprd12.prod.outlook.com (2603:10b6:408:133::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 14:37:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 14:37:04 +0000
Date: Fri, 5 Jan 2024 10:37:03 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>,
	"Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
	"pandoh@google.com" <pandoh@google.com>,
	"loganodell@google.com" <loganodell@google.com>
Subject: Re: [RFC PATCH 6/6] iommu/amd: Introduce nested translation support
Message-ID: <20240105143703.GA50406@nvidia.com>
References: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
 <20231212160139.174229-7-suravee.suthikulpanit@amd.com>
 <BN9PR11MB5276BA85118EECCCD89681EB8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d2cc19fc-f8c6-4b3a-ba88-5db947fb1604@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2cc19fc-f8c6-4b3a-ba88-5db947fb1604@amd.com>
X-ClientProxiedBy: BL0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:208:2d::36) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: 23396138-73b3-4f79-e572-08dc0dfbc906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pI6UORps5srFLj4gh88lH47kWb4uTgA6BSHizsHObxVpXkbKlefiiEFeAGzYmxNx03n60UsVcDrvDK1Sb1ZJccwyiif3XuyV7+LMIbAhan1VNWyh1qM8m8ah6JFJFj8t6qIfd8FmNjCm5UX+llB+fsbTE1V3yxiL+FUm4b3JCmoUbrWcxnL7m8+nY0gV6UrOuh6TMnHa8B3cMzReaW0450cVvdf/dBlseMdv9PQe965WUxXRZVykbAGhhLVoPDch9OCARTqXx7GZvTxUa/Y7t6pHj0nqb5HF3hkds6jd/Xh2S7A3tF4QF16b28zpxCl1TURyxx+YI2CKUS2+E2LLNzvyw+9+6kjhSWKnBceu/ILTXe6miVqiTQXJ2lyksu7SgghKdlNrbkdqaptmEtr1DkOWOVrBuEkJat2iccoCJ5rY+UbM33SgPxrfU+fm6vlSkuxq0AlEatQVQaiK0VEVuMK//AKxBdy2xJ8Nv2cbWFf8gWO3EtNrT6cWHbK6YYyMTA0IPC+RS15LDdtppuIKMevzO66v3IySYs35x1w3jup8JzUEIUeQJ9cvbFBjAudi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(376002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(2616005)(6506007)(53546011)(38100700002)(478600001)(1076003)(26005)(4326008)(6512007)(6486002)(316002)(66946007)(66476007)(8936002)(66556008)(8676002)(6916009)(54906003)(41300700001)(86362001)(33656002)(2906002)(36756003)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x4CUf9EQSBP/tGMw+OyG+UDr1IbIPsi6tIWggjPgYCDEzG6T/vAy6USAHcCv?=
 =?us-ascii?Q?cgEz71ktnCTmZtXCwWd2QC6sj8Zu/1JZBomogfGVNzqwwNF/x20N6rv3mlZe?=
 =?us-ascii?Q?xOUOkkEhl2SeXfOPVIajCNXDThaniHmqYGXfUXzFLNlRyI987wzepDO2vKRY?=
 =?us-ascii?Q?fhqwolnpsvSUgaK2hwdlieI0qwFMqTE5K5I9FwGtrGfEWISA700OSUFycfQJ?=
 =?us-ascii?Q?4SZaLiQf+4J68SNfWWz5aJHXh4PUD7AQjxPB5xv2rYMofnYi1w8/WziXfMZv?=
 =?us-ascii?Q?flHaqfZ4pC3ors3g0rOokEp8PeoHCAR31DsW52weFXW43dlzxoY3s7m6z87n?=
 =?us-ascii?Q?QXRZxzrixnctq93LfSmSN6XWA1Oh/XQip4tfIcKk+c09XxfJQO8wuqT3t4sM?=
 =?us-ascii?Q?Vmgi8bKhzJRDhUkNeCyytf74d/Wx8bPMVygla9kGwfHWEPzq8DpgfMVhv71b?=
 =?us-ascii?Q?UW5oZA2DwoaZoqk/I9KcKwNZmBEaUiqi9J6Pif+B4AW52jrJ2Qy0dKFpavLT?=
 =?us-ascii?Q?JKo7vgJFvlFYSX7T9QCvwrwMRw62nwzLgI6pyd8DVUOVBy40lKgtkHNlMT3M?=
 =?us-ascii?Q?CO91wneXVXL5c6BgzFyNTfz8pUFeeu7coNobuKKp45KjfIGdpsTG7Hb9ExqL?=
 =?us-ascii?Q?Xvh/6umy/N2ZYQ0cxyLy69gbiEb5/YDFissA3Btfzc5chh7SLcvrpCfpEsB7?=
 =?us-ascii?Q?r7IqfGygeJfjZ+7bq869CJcFHq2XsCkDsfBOXmU2seDnBbO39DfVB13nfBQg?=
 =?us-ascii?Q?D1YhJNHN1/GXGqRx+z5uOTKama24QNll1FMuSG1S/vfyiXyV407dqUOpnXnI?=
 =?us-ascii?Q?FhqctgRWUAFIOsKcpwU40pRibBcYYedmlIxdh15avCD0pHhMeOlWsl/Q8yzP?=
 =?us-ascii?Q?/Xsyv6HG91aasCijO9TjfsipotnsSIPqFL865qR55f6IXSb56miKOoyiNIk5?=
 =?us-ascii?Q?MtlhmkAoxJohn2ujiruicjqORhPrTZV+LTT6I3iB/7kr/n+NfT8MDyyULrIm?=
 =?us-ascii?Q?yWo4nI1++6v1Xw1PihM38m51LkNTrU1WhDkKaB5oMjkhJV9Z2tMMoYzJ0U7+?=
 =?us-ascii?Q?kXVWsFE3gB2lCgFRN4hSb48PJKtLdIX1j/gTYK94ddgy0n0dqsdevDe8PF16?=
 =?us-ascii?Q?CCaF39m0fmaFZAYQ6MHhgJccrz+73f/9+u8r517OKBMfXc42Q2QmeU1Ptq7k?=
 =?us-ascii?Q?jDe2DoPiPE6/FpTyV/0PgWONB+RmSYKjdCu9HtDIubJWysg1eRJvXmiVBY4p?=
 =?us-ascii?Q?TBVBUWnTs6kZjjy6ZYI035I2lYizzoV7sZ7HJdX+O+NM8Ihqpp8obGe3phqt?=
 =?us-ascii?Q?ckDfPXGZB3Xf1AjKNNlWE6msV1H8YrMb6BVmV2xZXfChtiSr/GMGgoKsJpre?=
 =?us-ascii?Q?GmpfkgIpKHsubOISqnse5cJW0QXcAEq9RmS/t03SgqfZ2X/Wz/KfRdx+Uv7n?=
 =?us-ascii?Q?3gj3ZfeLlA82oVs749QSuBYA+0hP7SwgL0hoVJX+QcKZKpSwc9vpjbZ/r6Ci?=
 =?us-ascii?Q?SwBXHFiOv4b/EKdGq3xYWALAnH9ADynXOAYTsYP/nK/V0mu/VD9QcYidrToN?=
 =?us-ascii?Q?+0AoO8NWtcakr8sQkio=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23396138-73b3-4f79-e572-08dc0dfbc906
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 14:37:04.1741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /81jNGl1MiH/GRgmkZYa7gycLK0LrZdfGkOubaKogRpQep0y6XMDUeBaY8/tAVWK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5050

On Fri, Jan 05, 2024 at 08:39:52PM +0700, Suthikulpanit, Suravee wrote:
> Hi Kevin,
> 
> On 12/15/2023 2:45 PM, Tian, Kevin wrote:
> > > From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > > Sent: Wednesday, December 13, 2023 12:02 AM
> > > 
> > > To support nested translation on AMD IOMMU, the driver needs to
> > > program DTE[GCR3 Table Root Pointer] with the address provided by
> > > the guest via struct iommu_hwpt_amd_v2, which is passed as a parameter
> > > of the struct iommu_ops.domain_alloc_user() with the flag
> > > IOMMU_HWPT_ALLOC_NEST_PARENT.
> > > 
> > > Note that current implementation only support GCR3TRPMode for
> > > nested translation, which uses GPA to program GCR3 Table Root Pointer.
> > > 
> > 
> > means there is a plan to support another mode in the future or
> > actually the nested translation requires GCR3TRPMode as a
> > functional requirement? imho the point of GPA is assumed
> > in the nested configuration in concept...
> 
> On (older) system, which does not support GCR3TRPMode, the IOMMU driver
> needs to program the device's DTE[GCR3 Table Root Pointer] field w/ SPA.

Meaning that on older systems the GCR3 Table Root Pointer is not
translated by the parent v1 page table?

> When QEMU presents an AMD vIOMMU device to a guest, the guest programs the
> guest DTE[GCR3 Table Root Pointer] with GPA. Then we need to :
> 1. Traps the DTE write
> 2. Translate the GPA->SPA
> 3. Program DTE with SPA.
> 
> With the GCR3TRPMode, we can skip step 2 above and directly program step 3
> with GPA.

Do you want to support this? It will be hard to do because it is not
just those three steps (which are easy) but that you have to somehow
maintain coherence with any changes to the parent page table, so you
have to hook the iommu_domain unmap as well...

Jason

