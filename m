Return-Path: <linux-kernel+bounces-154176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EB28AD8DB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960361F20C85
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94EB4597A;
	Mon, 22 Apr 2024 23:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAIVaEfI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41ED45942;
	Mon, 22 Apr 2024 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826895; cv=fail; b=HWcQ+pB7XnXnapBVPuF/xtNiQ+hA9vUHNZ3hIfbxiKYuwf6vOiCYyeWPRHNjIjbsDqc0ipMwGgPEffVFezkBIiEVbshzFA6U+jkRiHVDFXseNhpVArTlodDe3iIFItiGrQKbI9Y5DR25QZ8QgiWe0CphKgfa4d3Ik6Rg+I4h/dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826895; c=relaxed/simple;
	bh=ItodQKyDDAN0JpEhclCd2S3UYR1HCLNKreA2aZTyiAI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rIBMWVyGaY4AvA9iUevV4JUexlTNeGGhtuPJRZWTTZB8yw5D+NkDB2gsrBkzhvi51nJpMZlsDWyTWWBXo9FRswI1iqeqkY9iJvW6TnR4J1eF7pEWNPr0Eb7/3kCcf3Crk1KFklF4++sFod6jg4+/yO/dOOjtxk+DNjQ638a+gBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAIVaEfI; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713826894; x=1745362894;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ItodQKyDDAN0JpEhclCd2S3UYR1HCLNKreA2aZTyiAI=;
  b=lAIVaEfI94D0kYUBaUyJPpZNsZP8pv16q7qyqySrmGg1GojH9vvTI5qW
   AwPZXZeKACP20JtcdQiubEJCFKXf24WnG8tdlgGv+9hoQlGuHn3+26uJA
   G8ZLf4jOKnMGnScbxO7N3rqDW7IpqJHlKMaTqTjLrahEFPkaZGjskscze
   /FgCvFc5FKdR835LnpPRVyGQ5QKcK9bUheiQf+m6Dlpt29HSiFRqHM4ES
   mGxui5Ebzb2zr3Y0oIvYQZ+LEG5S7h1yMlESNbzEwBhzlc283yxbqwICg
   nlJgZKWQuiXC5MFrBSsczo935It/rwPT0Aw1q0JFZviJaaYz+K96QA66d
   w==;
X-CSE-ConnectionGUID: nvn0RkwcRIaffYzOWqOP7A==
X-CSE-MsgGUID: 8idseX2+S6K8Sz3xevW9Fg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9930785"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="9930785"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 16:01:33 -0700
X-CSE-ConnectionGUID: WDMH3RohQf6N0bzGiOZg9w==
X-CSE-MsgGUID: BffENRBCSu685iUZF+iOlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="28679539"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 16:01:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 16:01:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 16:01:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 16:01:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blVXdF7OECvFYzh0qiQ70stktOGL6ghw5Q3iC0fJNbkU6Oq+jmEhSlvqCQK7EEJakfxi/HeJU+wV0YpU07r11sXTL9Wf7l6R18C9iiBZm/bp0+PzalEoEjsThEtBvQJVuj/0PVGQbR5P+uIC6lTuqhVYFOr+zzcZaddUvPv7o2wvA+8NLCsp2NGP+mNsWMR9zXQsrK1Gl1UU5yrW4hD6oUT3ZhxBwsX9gsazcDwaLOrG1X+c+NEX+zIwOXIvQ85PjJ8IHX1XYRDqVv9cOeJHNFM2c3lr7w7BtY5fYWoJDgS2r8OKCj0mlMNpMa23VA3EGJT/pdMU0sS2iMhP13/s9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZkAh+9kShrTg+qQtGlhbwenip+2GilmrCWmBqTva5w=;
 b=iE8/8K4oPtFn2bZnNg2yCpsUA663ORxXOFbVbDBnSiELSuL8B+tJuUqTIbvdAyn6FLQ6Z31gG6Eo4qCinT492r2txtsMTu3RkcxiybESLEXHg606ewooUccAejZaNoHI5HfCRsDxZRcitjmlvOxxH7XTunyktm+Ou7jlyD7KXyhf0kgJZJbQLqrKOhHe6wkDzxqFfEmGjegKgTuBebv976Z9cCJyBLMrU8S/IqHcSzUGZslEyGiLuPKMcFi5KCASH+RC/X/mzREq0cEgB4PpWNqw7pmHmd2fRUafSMfmsXgchIU9uIb37ud7G80P/cFQ+aeCKVvO0HZ6XQX85UvHNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6186.namprd11.prod.outlook.com (2603:10b6:930:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Mon, 22 Apr
 2024 23:01:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Mon, 22 Apr 2024
 23:01:24 +0000
Date: Mon, 22 Apr 2024 16:01:21 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Li, Ming" <ming4.li@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Terry Bowman <Terry.Bowman@amd.com>, <rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/6] PCI/AER: Enable RCEC to report internal error
 for CXL root port
Message-ID: <6626ec41da372_690a294df@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240313083602.239201-1-ming4.li@intel.com>
 <20240313083602.239201-4-ming4.li@intel.com>
 <7172ec2f-7cba-460b-a6c6-9fff45ba938b@amd.com>
 <b4a721c2-567d-4ab3-8a85-963e3f323e61@intel.com>
 <91ddd182-cc71-480f-a1b2-e7c31b29a549@amd.com>
 <f0b85a37-ead0-4954-b7e0-dd09cbd9ab09@intel.com>
 <662134e290d89_5eec229450@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <8a304a97-7825-4b02-a716-f25d0e9d4718@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8a304a97-7825-4b02-a716-f25d0e9d4718@intel.com>
X-ClientProxiedBy: SJ0PR05CA0203.namprd05.prod.outlook.com
 (2603:10b6:a03:330::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a79838d-b8c2-4b61-049c-08dc63202217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ANQbWXs87URVx05ZWvefvrnDmrDXMxLDwNLCA6Pa5WhUat2ObAiZ+3JKxLcw?=
 =?us-ascii?Q?1/CKbHbj/A8UvYmtKeSM4QUFlzA9bWYHJuOd/pqesjz8SiEXg74syhopCKl7?=
 =?us-ascii?Q?HAG7E81HeCTr0kPGPiemT7EuKzqPYMT39EUjZVyJga+Prs8mKBVI8ZJt/23p?=
 =?us-ascii?Q?PcTmYJsuRQCY7NQyW4TgqWsI5jvENvuj+Wb8EuJyhzeLORXSvzgq478W8jv9?=
 =?us-ascii?Q?fAyUDm7eollKg9uAkdqOl6fhEsbm34haJ2hsqRRtxd9NpxOzLUyt5+cGaJZz?=
 =?us-ascii?Q?7OP4mTlRwfMc7SUT4YgXhkAZBVAg7k3xXsmrwXrY2e0s+fa9IeB8vO8rNiyn?=
 =?us-ascii?Q?XAwrgG2bUl0upBUhN0pSXvly2L0IbHGybQEqBH5fHbdLWr3fhsm96IkNopsU?=
 =?us-ascii?Q?XWTPGN05qQcDXhwdUxl9rDF1hodUqpL+3eq06YjN1tKLuIO/DIXlCL84rN9b?=
 =?us-ascii?Q?H/yoTQewEzxy541a+apDYU24YwBxPfC361XprOXOTRhaIC1toOvDy9s0z4ES?=
 =?us-ascii?Q?lQDwxDyvx7msGPKp3d8711+bM2Gsp4yxDCxW1hZgMruxyeYkAsiUExY+yA7P?=
 =?us-ascii?Q?7CD8ien4QiD14yTyo66uatIHZ39a86iEaMiLysH2IB2jA2hkegNepTsPIaBn?=
 =?us-ascii?Q?+pza6Aw/j1z+cgmzBOoAm++T28PVr8Z7kHJNmXBjDOO1OzSu2M+aQ6JrqU/o?=
 =?us-ascii?Q?wWKpOEmAkATekYmJYR0vCILViTBJIeKYLBNyWOsFueOT1ZHximldbxApKaOz?=
 =?us-ascii?Q?xbcMFYV0Qx1OYo7kcSOfGZpRnxqFWGcKzDDDDlPWPNHhjVWuvseleiOTkODn?=
 =?us-ascii?Q?FLuGT4RjPemzrGFYXGxD3FRXFO5egXHA7+4YiYMVyRlDDbsOzgPMzZKX0krN?=
 =?us-ascii?Q?N5tCdKSwFaqk/+6mV9hNzLi4KrUgMRt+vUWkupGCtXL+MoB/5gwxc4j1b63j?=
 =?us-ascii?Q?G9SuM7Ex96288yvb7fmpXlkkrTqTNIoFZihWcmqtjnTdwDLNivVGxw0hKlje?=
 =?us-ascii?Q?0X0uPAYoloUNS+PMxegtxkGpI2hvW+yapbEez6R/hUMcx26k3OxZjHP1bJM2?=
 =?us-ascii?Q?+RfPwlYwjYlWvMy3Xu5wJbfg0ek+a/0vz3YQrWpoiONx802Xr/Wc7hmfqBU0?=
 =?us-ascii?Q?0QnJP+DSBkRv5Pf+8fqAGu2oYfOqmyV7/cRhWxdYWkNuW3BTFUvrY0X4XMjF?=
 =?us-ascii?Q?+/XLBbgZFW1s2iIzNfUFL3jJoOrrVi6rBnfW68jlCU6KteNMPquUJnuF80mj?=
 =?us-ascii?Q?yOZIOqygiuOmeYAGtnkukvoyNHyNluOoDCBz1JYMMA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4E4P3nqS51dQXFIKaUtQ6ITgdJKez25hH6D4BCvXgNu3/BLztzJiFtkN3ufL?=
 =?us-ascii?Q?w0JaysQG7l8r/RRCI8xIuWIFA8lOcWfHPCpriOqWvE0D+KLSlWdFR7/xeqhD?=
 =?us-ascii?Q?4w+QD/eycvo8b7lUWVxVgctY3FsmduHSBw1mQazidJQ8988REqnDm7ea9m+k?=
 =?us-ascii?Q?KTFnhOQZEFITn7h/6910bMfNwOROW8s4YIbb6aRtedgFuWeCspAhmXQjOo2N?=
 =?us-ascii?Q?08ZO5ZXg+hSpE7cUoQOOSyybGqD2iMG/svXdiTVmA4zoIEURR71pGI67dNz+?=
 =?us-ascii?Q?LrJouL9nFL3sy/3EpZClWVPUwNJiFZy0zhZBC6rVOd9mQF5aBc51s6U5IZUY?=
 =?us-ascii?Q?u04XfCw955FJjhT6s4bO7is6GNbip2cYsy78NcvpBazfqagkVWPvXMfdrOL9?=
 =?us-ascii?Q?bHzPBk0NCL1Itd17uEnFkXHWlN4K6spvRrQRl6IpNdi+DfBD5kRU9dXzxKWM?=
 =?us-ascii?Q?P3EY1eqOBjdDKv74CWtonYt0F6NKXN3EwIHt+TRWO8dJfvWFqY4+kgWcnDQx?=
 =?us-ascii?Q?FPmg/5k7mFp9dCaFbTL3Qi0A/NMIQNIgkwUd24Yuec7Dxe8EV1vQbMQAYaPd?=
 =?us-ascii?Q?mpwS2a7u/VNTmiD7JS49Z99D+uyjgrh09RTvxbd6A4zsIQLgMhxx1wa4KPBZ?=
 =?us-ascii?Q?ljDuv9vj9bkbbuJb3nRC1ZEY+mXtJ5SziDq7BgXa/ty6r0kI2CtU9hjORvAi?=
 =?us-ascii?Q?7WI1Jy2yJCDmQlKTQCaNp6AdLRA/JX6uvOM+9xi1ePsSILc4o57Rhpp488fk?=
 =?us-ascii?Q?AsLoTdVuaAQUFLWTYwqAMEQvGDyWU9CRxPur9DEKQbwp0ogEQu2uTXvJu2e0?=
 =?us-ascii?Q?bymOy6pQOozIoH/4kkVEcgz5cX3qT3p5U8UKaTBxbAA3zPlKtrzxpasAPIYa?=
 =?us-ascii?Q?255f9fwaI+G56fL6IKnZPqs+W4Wg4D8MuS8orjgfOtdLQIhUpIxhaTGC1VRA?=
 =?us-ascii?Q?m1o0oebVUQZzVOQF++Me/cV7tLO8tH1PopqVHcbr1hYnWbW5Gma0DPSj0YXa?=
 =?us-ascii?Q?zbLxSA3QW3MXC8TJo0UBb3YnxOybS6Qi5knKYCpvigjgPxMoU3+Kto2b3kU3?=
 =?us-ascii?Q?HUPLVD1fpxlW3DpJg0fGrI+13hSELj6F8s3yE7G3Pp8TGRZ0nT8Jk8QmKpzx?=
 =?us-ascii?Q?OmzRKx+TS0qdrG6fzggFyyp32FlQqRL4A43zHcYyuHBiVfUzJ2EtLyL7BNie?=
 =?us-ascii?Q?J5C2nW4NyV7kMHndjnYA2jkzF6uL0PWM7BJL4FlebhMBW2grw/0Bzx+gfYpG?=
 =?us-ascii?Q?CnwyIo68gdna5+8HZLtRLQg04G7qFoMqbdICNSnDkp1Z8MfCA4K6MDw7uwZA?=
 =?us-ascii?Q?BsU49ezIxj/wpgePJkRzgvSE+CeVvG/bgtk+tapRZUYhUgr0sIfidJdYiFII?=
 =?us-ascii?Q?TVRU6Wn2X5ufWQAQtO+Zzhz+W2Ato2wMj+A5AdnRbMn1eZVYHLQXeLyrw0Hd?=
 =?us-ascii?Q?XTEXN6cZcs7Zj8pW04ru9+a0Wp5HshIXRyXIaOgubyceEtjaOqByahD8XoMk?=
 =?us-ascii?Q?w7lutB00IExIk4nSkXSG78vr3p+LTeIClYQCd65nIoIKbROeqShQIbg7Ckpa?=
 =?us-ascii?Q?9Rxl3ch7DccPrCnyU8TQSkXhIDUc9kD/z6B0Pi8GZlX0dIBZPjCpS6pRZ7yT?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a79838d-b8c2-4b61-049c-08dc63202217
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 23:01:24.3213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WORKsLYFcQE9QG0Gsc+I/InZf8MR0B6xcPyA5HPLq+EPJd8eMzPhc6KeeIy/zJV73nt8xOmWNjyXjUaacO/olgfIR9FuJV7pE3sTzwl7m9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6186
X-OriginatorOrg: intel.com

Li, Ming wrote:
> On 4/18/2024 10:57 PM, Dan Williams wrote:
> > Li, Ming wrote:
> >> On 4/16/2024 10:46 PM, Terry Bowman wrote:
> >>> The driver support is much simpler if RCEC does not handle VH protocol errors. Is there 
> >>> a reason to forward root port VH mode protocol errors to an RCEC rather than consume 
> >>> in the root port's AER driver and forward to CXL error handler? 
> >>>
> >> I agree that is simpler if only root port handle VH protocol errors,
> >> but I think that software has no chance to choose if VH protocol
> >> errors reported to RCEC or root port, it depends on platform
> >> implementation. So I think we should support both cases.
> > 
> > The question is whether the CXL spec RDPAS behavior causes any problems
> > for platforms that follow PCIe rather than CXL reporting flows for
> > root-port errors. I.e. does it cause problems if Linux starts scanning
> > root ports on RCEC notifications?
> > 
> > I do think the lookup needs to change to be based on CXL host-bridge
> > detection and not CXL-type-3 endpoint detection, but otherwise it looks
> > like CXL spec wants to invalidate PCIe spec expectations.
> 
> Hi Dan, if my understanding is correct, the CXL host-bridge detection
> you mentioned is that iterating all root ports under RCEC associated
> bus range for RCEC reported VH protocol errors case, and the
> CXL-type-3 detection is that iterating all CXL-type-3 endpoint under
> RCEC associated bus range. is it right?

I think this error checking needs to be tightly scoped to only scan for
CXL.cachemem errors and not CXL.io or typical PCIe errors. That way we
are not technically running afoul of the PCIe expectations that *PCIe*
root-port errors are only reported by their local AER block and not an
RCEC.

So the scanning should be limited to just the root-ports that have
negotiated a CXL.cachemem link.

