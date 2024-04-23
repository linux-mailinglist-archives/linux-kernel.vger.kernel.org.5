Return-Path: <linux-kernel+bounces-154668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6698ADF8C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3067C1C2154D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BEF502B5;
	Tue, 23 Apr 2024 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIz7uV2h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2D32B9CA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713860230; cv=fail; b=cyLVcEj1N22wbZh18Vajb04oW7peswyWpFpg1cjYgYywnRAZj76zbdozhYdjVBBy0UJtgV6Sw2SJa/2Mz60u5lG2L7RqWF66gx9XgmtJ3xfZ3+R4M9GcfFncNcJ6zKxHkskY9ZEEo3DiPy++tcHOFZ/BwcddnIFVW5POrOjIXQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713860230; c=relaxed/simple;
	bh=tZywtbTsMxpcgIk1Rpq3fRLVKEKozrcpB9m2dYDLJ9Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=if8l5x3Ubyu/4UfCC1DjuABjDsVi38mt5n5CT6SMl3Mvd90cvzcpVj5T3Ay9LqfGj/dl8Ta0bzILWtQQm+DjfY+5eVwPsD4uk7wWweLpIXEkZmdwuMCpDYfUxZmpEXXdG+mhnmLmST31xc0CypgBfnXlIBQ++FMKwfjfspZIH9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JIz7uV2h; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713860229; x=1745396229;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tZywtbTsMxpcgIk1Rpq3fRLVKEKozrcpB9m2dYDLJ9Y=;
  b=JIz7uV2hhKRB2UWNEk8FqjVnLZCwyaLE6pugQ30Kbh7cITud05oNNXSy
   gjreN7g1GDw74DvzOBbJs6px8yFuf6K0gMG0U3/zr7kwBcxmEubkNOlnt
   gMNebAkum8J/7SRXcEjDma3SOumhZhP7h61BCRW9su/9TMFBuhZzfvamQ
   RJxWI0eHkwuX6x57AIeGorDQsJhz3p+IimCUonj9TJy5Kapo4vQObSd3U
   WnT0JYuNhQ2fj/N0zK18727njs8nKtuJQhJozmjyHtwNQ1A3W2QK+6M9Y
   xRpdelahpUBNDyC6iu2jbw1hJfVAlVpdFtIFuYk12B6x40FdDuf9tTz2n
   w==;
X-CSE-ConnectionGUID: 9Ishj4laRE2992JNy+cWyA==
X-CSE-MsgGUID: DJnZa1yMSZisJUZfsZpYhA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9297709"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9297709"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 01:17:08 -0700
X-CSE-ConnectionGUID: VOXuggwQQGq1fV3WyU9a+Q==
X-CSE-MsgGUID: PEv4VH6iSdevgpuyp8ewnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28796957"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 01:17:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 01:17:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 01:17:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 01:17:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 01:17:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPpu50Nm1UipEpEJqXvVn/FE0WtZvUTarZr/YES5bUNZSCrAy7ZLTo2HF69M/YKmc6U3hOb1SVsdZ6W/RlZJYgFZr4iLzLZnmOeGMwjUVPD+20tla6FX7wBe1j9RoOBP7GQTU3cbvBk8QDMyraqar2YGMjoZVWLmg2qJyLtZ/NYZR3ZItJJH7jOSnrn7V38vjQPspUpm6uOLUBT18g4FPfwsHqc91W0+9FtAtuQ1530FLLWY8OcB3oIYJh/CLL87qf/1ndZZBKGPj+WF3eebKzL7+h+Wmjq8jaeggs1rcXSw30WhGrMXWR6KBLXLVcABmCOK+M3j0kFPojMR/7nIrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZywtbTsMxpcgIk1Rpq3fRLVKEKozrcpB9m2dYDLJ9Y=;
 b=AuogKpabUcrVxOVDCsM63YS9xksYcwbGvUwljkRncjFOWDeGPNWTqRpBbElOWlgoHC3xDd4PGQcN9sZUaJBrJ+QbR96+T7CDBEPk89bATcLUnsc5Pvk4I20ypupUYckxwm0v13QRUPmQ6FzRUondo5pv79SRyMIYWMnIrATiV7JCoClbLEEEbdM1WAghNwKvDxtkRPWCX8FKPWO5dZ2QKUgeMQesDuVnUTv05ZDuFwTUGdV8Qar16/VZgrIYtqZvdT0s5Isyh0rsrnfGLmwbm7wOpjgGAaGaR8okhzAWiSbjnp1f0is9F2vGcBrWDhBa6yGdVqF6FmCBomECm+4rAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4868.namprd11.prod.outlook.com (2603:10b6:303:90::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Tue, 23 Apr
 2024 08:17:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 08:17:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Zhang, Tina" <tina.zhang@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 01/12] iommu/vt-d: Add cache tag assignment interface
Thread-Topic: [PATCH v3 01/12] iommu/vt-d: Add cache tag assignment interface
Thread-Index: AQHaj9VBHEr21xvfHkeP18PDMfcoLLF1jXGQ
Date: Tue, 23 Apr 2024 08:17:05 +0000
Message-ID: <BN9PR11MB52764D1943C9A5CD91666E228C112@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240416080656.60968-1-baolu.lu@linux.intel.com>
 <20240416080656.60968-2-baolu.lu@linux.intel.com>
In-Reply-To: <20240416080656.60968-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB4868:EE_
x-ms-office365-filtering-correlation-id: 2bb0a17c-c3ae-4b40-fc11-08dc636dc305
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?ylo/sADg81uscDkf5mX6A0jkFHZJwqgJqMOoImhMizVh4EvgRC+St7niTXpy?=
 =?us-ascii?Q?u4LaILdVKHcad6BDx453u6T4q2LJFojlNkQbUSiPmCKjMhqKcMPRhg5qbDFt?=
 =?us-ascii?Q?eC4dZUul9SLuGaZx8qjYzPPV7mdQXvIEsjbpJccCL8UaCnnBiZeAvASO6FXl?=
 =?us-ascii?Q?lnzugPzkbmvc/YInplEvW2BsbvQ3acl3y1FdDlCerQrG083I7jqzuTaW06Ba?=
 =?us-ascii?Q?IOLXE79+lEtESWW/kq0XZ/R/LcCn2SELWSJjh/qbjl5i3MMFfCLud6sK1bke?=
 =?us-ascii?Q?dw7HOd4I4755p2V62sBQRi3saQZv1rkSuaZ3HGLH8oZuR9mCIZzhgUrD2QEl?=
 =?us-ascii?Q?j1YRTjDZXmgibmxOKydASmvHOv9tWo1CrHQDjMFElk6jkKXyADY7gcLAycEs?=
 =?us-ascii?Q?swnwK2Namks2Gdcp1aTjy33j5J4lJu4iLpQACJkuXrwTaXdEz16zAXMS662E?=
 =?us-ascii?Q?Yj4mMmYT1weSEt+Y056T2Rq7zWTbEcrPaV+s2YwZWHiStj1g3Q4X4kOGHoml?=
 =?us-ascii?Q?KtVBQ7HVAdrypE28VqLIHKw7wLSmw+DGqE8VHOEQhM19nRp8TEjN753fYCfh?=
 =?us-ascii?Q?knKi5lktoRsrJv5WOtSLeWIu8xT+TrKM3dt3osajPkjXAhODnkF5NcZwsANI?=
 =?us-ascii?Q?xVC+wOijESKHLQvshZXGS7UV8sxRf7PDimKs8eMDPcKpB1YyENiaMtNbxvW8?=
 =?us-ascii?Q?Vr7JXIW9bndgpzhMzyjahUp8T0ccuxyMZPIuhs4t4xrlzckGOGJxvM9LZc65?=
 =?us-ascii?Q?KovKzjOTgBkukPgnqGGfX2qniYi47ecaN0im8girdLYbadrbPxYp9+vNS2QY?=
 =?us-ascii?Q?r3mbjEkKJiRC0yuG7MYSBc3YJjKJie0MwjxAqP2TD0x+4SyMWAJlp6ChR/Au?=
 =?us-ascii?Q?yqEL/qN5Vn9W070iaa0WNY68zLvXaxpICdLs3zqnx5nqrvBQ97QBP0fsTgeR?=
 =?us-ascii?Q?UCXQVKE8ev/zgIKc/d17YN8RZKeQRExDvprxh4q4AC/gz04f/y9uxS71ymTo?=
 =?us-ascii?Q?nfuudapxLMHj0k+et4MXvybVThfWNyF5wJYFKcG1y/0S01o0iS5Y8LYT3f4r?=
 =?us-ascii?Q?0i0bg5xPAxBI3Y2AMbJ+p8020t2sqOYTUWu9pkiAxF5x8tu7CLU3X7qoj85h?=
 =?us-ascii?Q?Jz/+kKR7XcfZuJLAA0KhSwTLQdciKDJhVmU6ajdE0i0OceXqsaXDYak2UaUd?=
 =?us-ascii?Q?Gflr4MxriVfQpqO9d9RsrMAI/aRTSLedPkvJiYcJSYK2kp3ZohqtsK+Hgw4F?=
 =?us-ascii?Q?GruQpVdRGqaoGn3QlYezA6WKM80RcSa39WKgEHDOAJ77iWu+4DtFayiM6KWb?=
 =?us-ascii?Q?XO3BKLbkscfC++7QL1xW9O5EfvSpDvy7NN5cqadT4Vb5UQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x7q5vjIU9NAnx5hdMNNSE7RGS+Edb7eV4p08y3hjAw4llHTtBoiSGmof5yW0?=
 =?us-ascii?Q?SyJOyduZ3GO6ENRYHxYJR+2GsmLOIQ6UO+jvB6FhDX6cRG7Y3YYigdf+QVSS?=
 =?us-ascii?Q?+HnnmUfrIPT9QHWG/wuytGuxX9bY4I6LafgMmeZzwWKu3/n0jX26cbgrdw+o?=
 =?us-ascii?Q?1Xpct+YNMArDxc46J2DJj6rVnJo58rNu8UGI+Z1NchDqYpSN8D6JCIR20nYQ?=
 =?us-ascii?Q?/vJJ3ARfHDzwLC3gL3bPEjmbtAOQa13iATHjGeK2t5B/Bubg1ddk3Ja/IVkc?=
 =?us-ascii?Q?dSsDtiYZq2uD2mH6z7eAFGM5CMfKNHhcBebvbHacnWhffX6RzotMRO9gmt8+?=
 =?us-ascii?Q?KFix5D0pQ80ElcJWwvrFMTtuI93WviKpXfuitOZ8Kwp28cK5U5ursKEedo9y?=
 =?us-ascii?Q?Qm1OpD31jeq21IuCAihIKAqp5iZDQjL8iNivnPlO8zPEWoQ4hiz2YR/eP8vR?=
 =?us-ascii?Q?k12xSPG2wl+uRJexCdOGYAGAQFtaZtE5jpy+9jgrGeV2EkBZX1JzYKgntyHb?=
 =?us-ascii?Q?TcwjLj4eYsAZXms/6Sb8borcXEOATuflETMqUJq+fqbG/mmLnyIvm1rvIYvZ?=
 =?us-ascii?Q?jAQIQQCfe6XDvsOYiQKesOiEDn0h0Ick91EkEruZjnomZelAxKt+vFFNi9Al?=
 =?us-ascii?Q?1cWx1eiiZpAWSO8YOzaYR4/uCEhGN3CS/Zz6CsXvo751jWj93RiiDfG8s8Rq?=
 =?us-ascii?Q?ETmkigBkM1bX6F/PG65EBCRwPud6GlNscAlSnpdBTXdiJ7qykWp4B5hQqES0?=
 =?us-ascii?Q?ZDrhRUY3dPraRh6/cJ3AWHHlkdycTHeW4emVAKkDhRWSXmJv5TbC+BRUAcnh?=
 =?us-ascii?Q?Sw/g0ktQ+Cghj+iGUwix6eU8z8da76/IgWCoS8Td6s77PiJvxyEEtEt38ovb?=
 =?us-ascii?Q?VCPk2C8SOHhDDu3H0BYloyyJddH4OnSUBZupjw7DdixwHjQcwBrwB23efNis?=
 =?us-ascii?Q?fLfNqvvRqoKBK0pd9C69JiboHU+8p1BgbMewsABlefscWaKzGZ81f1MPnvlp?=
 =?us-ascii?Q?qpWPuHeXl8T0TProR+zKp19npkjaW5RCK9Ft5RXgRDOfLx7H3QUi7ohh6pJT?=
 =?us-ascii?Q?p9YrzGSqCHBlomqeQKbW9TUB57fBwN+CMdOiQSRylR5L0Im8jTql00vb5evK?=
 =?us-ascii?Q?wwZC4dcVuwNY/XuNkrGihTBxZkdoUVFRm/uMYJ25XmKNcGPl/E6QyFDQ925p?=
 =?us-ascii?Q?Psu70ucrmGgnfdbk+cNNGz1bm8KlJchuq+usGc8KaJ1725FYNgxzBe/v4wK4?=
 =?us-ascii?Q?sG0l5I8iMDDlv79oPGyhOwCn/dy4PWT+j7Z06JGRT6qTvJ7cY+ZE1VB84F3h?=
 =?us-ascii?Q?KiKn2WWJK0jvLAF9ouuOFiVNBOnFJzg1hvDgUQt3/kEZBWb4ngDVazaVvY0l?=
 =?us-ascii?Q?VBjKCJygH30uw5hZJ6/bBwtmUl7eh0x8lVfN5H5FbJExrxNHV3u37ByrpbEn?=
 =?us-ascii?Q?+oUnwMN3BZuSRwgouygH6qcjbfm4Ox80UiY2xJZLnSpM+z3D6+x56YqRmCok?=
 =?us-ascii?Q?l9WeyTOTbuRAserEpdD0QxEpLXKYE0c9zMJunjhawnOrkw4Y6OnhkcZ1T+ab?=
 =?us-ascii?Q?qPdv2ulXyQbaE0zl1Ok7JREHUp1WG+ODMhpg+ZyT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb0a17c-c3ae-4b40-fc11-08dc636dc305
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 08:17:05.3680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPuOGkQHyr4c+k9h9PD1loE8fPzOEUUuQztHutLTOsQ1rmsYy0EKe/vx0KzsOO9zqDnyIKARU8x0YTiPNCmZWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4868
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, April 16, 2024 4:07 PM
>=20
> In addition to the basic IOTLB and devTLB caching tag types, PARENT_IOTLB
> and PARENT_DEVTLB tag types are also introduced. These tags are used for

it's NESTING_IOTLB/DEVTLB now.

