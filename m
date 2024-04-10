Return-Path: <linux-kernel+bounces-139208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C686B89FFDE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1581F2B518
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CC6168CC;
	Wed, 10 Apr 2024 18:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aATc1SgV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dblv65rP"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9909B15CB;
	Wed, 10 Apr 2024 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712774008; cv=fail; b=nsEZOl1vtM8PzHW7bgqtkZwzHsUw+ooWWpjwCBzPXhGKYOs0jgjjoaswCtKBVIF/DiW7YPNt0E2ONnGZGldRJV0sLYYKAIUAnPVpe4Sh7Ddz4k0R8uIw0cEmiwerIn5eljd2AiqfIIXoydiFGDKyYEcARk0KTBtZT+WYs8K1Jtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712774008; c=relaxed/simple;
	bh=OceUadT0+pdYitDU7mKE1+c1UWVGEg+KhDPKAQlo/yU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M4mAS1aFqwowoWCTYDpuDpxFSdbJKcTfNHRfQx4uwkQcAymoZUpURrK/4Q5mT6Ff9sLgPg7LFRcez5PE8FZwc5zGTjapfkZ46sHaVJh4JiafbUJ2TPvkAL6CWd5Hskecl4rq+9BIx40+rFt2NL7hTILItYVCapv2qT5aDMdNEco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aATc1SgV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dblv65rP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43AHn5NA009218;
	Wed, 10 Apr 2024 18:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=OceUadT0+pdYitDU7mKE1+c1UWVGEg+KhDPKAQlo/yU=;
 b=aATc1SgV/XBYV1PY+JAizYe8ma6Tzqv0LO0Q9azM96p8mWE5Vrio95IgT1YPe2w4kV1W
 bt4r1o4YKVN9NWAddMvdXj7Jr39w0y9JIhwO8HoFUB0AfVK1aQHmQ0kYcs1kPFsMXVlA
 rVmY1Mz7YfnmY+pWRnitLBhDhJoNPq9OvjCLw84RYzzAeP0AmBM4SXeJc4gNlR3oYgNt
 0A5e5ExfCdwArHvBIi58doOp/lq0ugwzmB8vyT/aeJ/6+rno7/PzDrCD5VfX87fiRo7n
 mrxQ0tYaIF7/Ys63tpw5kzxKpHtN3r8MHfzOyI2sivJ3iOfLu1g0Nfog1xBjaYHtPSw6 oQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxedr5aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 18:33:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43AH9fNk003010;
	Wed, 10 Apr 2024 18:29:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuett0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 18:29:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHVnhv+KY44TMo5DRrm6jN75dl3sYL+HGMSPsOzLHLPwRSAN1vnNyj4gKKxnzLufuPYdW+8kbUIJjIREojmKGDxR5+9GC7qlZ3/5+xYzyXCZKEtKZGmVC4qZ8nNjfXanF/Im6eLT6hgTk/AtuA5c7FhFtv4x+hHZOjIvqWEkGb3tscG1q9RtvwGzLo3z42yn96GsQbONN596e69BW9z2lVgHJvVYlfm8Bmb19NVlDE2syLSfvQfMrmhCXOCzlfHdW9HDfMMFwsX4CojXjjolJxQ29gsxTXrJhrqqYzI4W5c/7DcTdiiK749FNGsa8UeSd+++Lj6hMkQJOrHbMaAhFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OceUadT0+pdYitDU7mKE1+c1UWVGEg+KhDPKAQlo/yU=;
 b=ZxNyBL0OuC0uWqaMGQ41r3sMjn7aVkptuiIi5hcn3Zd8NZq0SO9HU9mg/G44CoHt2I3RQ6vkr6R7Cn7bf5UV2ia7TD+bRBMfRzBAht5is3j0vzUD5qjRnpcTdGWP+PRZq74+FalBBf0n2CV2xolS/e/+KFQlYQZU6tLWPB8uQ7qFHUP/GpZX2ulR4YskowCqH5TFToz5vdXlAbhS5tcy/jmyZoL5SDr4v8GOwX00o8D/vyqFwWXHy8ZixmqZRZKq398NCEwxIFVhVFtaxkfVYUFAUxjOWVbgc/hUFrTIjMZL9bzEAFYfyy/bKnxNSEhklD/yrGtFsrmQYfZTh+sGGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OceUadT0+pdYitDU7mKE1+c1UWVGEg+KhDPKAQlo/yU=;
 b=dblv65rPFsXJF9T6Rlbp7QDsJAACWhfcp3E8pJcUritCdCem84vM0POrgbjCUextqRBC7NTIjAaEj8nlhAG+zPXnWPX93mJ/EIGE6uwj/UZ8dLjHKsuJHvj34G+d3Pf7ZGlu+OOTaWJWO2fJ4S/RNRmVoxF/nOuBQJV7nyNSt4U=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SA1PR10MB7710.namprd10.prod.outlook.com (2603:10b6:806:3a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 18:29:35 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::ee66:40c0:bcee:ce7]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::ee66:40c0:bcee:ce7%7]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 18:29:35 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>
Subject: Re: [RFC PATCH 3/4] ACPI: processor: refactor
 acpi_processor_get_info: isolate acpi_{map|unmap}_cpu under
 CONFIG_ACPI_HOTPLUG_CPU
Thread-Topic: [RFC PATCH 3/4] ACPI: processor: refactor
 acpi_processor_get_info: isolate acpi_{map|unmap}_cpu under
 CONFIG_ACPI_HOTPLUG_CPU
Thread-Index: AQHaio+bKzbJEucF902Gmw2yADhKgLFhf5GAgABVT4A=
Date: Wed, 10 Apr 2024 18:29:34 +0000
Message-ID: <AC422669-2869-4C05-B8CD-4C94BDE24012@oracle.com>
References: <20240409150536.9933-1-miguel.luis@oracle.com>
 <20240409150536.9933-4-miguel.luis@oracle.com>
 <20240410142359.00003dea@Huawei.com>
In-Reply-To: <20240410142359.00003dea@Huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|SA1PR10MB7710:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8LVRJoEA0J9bIYqD8U/3qCgXV9fOtHfV7S4d7VsoE0IwfZhdCzHWTEt/naw/1fr5WPwsRuHVvQvtrqKnP2eLKxOvL93XXdiEXuMQSqDGoefHsaAXxFyjyFTnvtPaYyhvjfGA0tSJkkH7ghQQW9Zum6aks8DYg9fJO1hPTzHeLt+CCuysTzorU0lq9UCIseLSv1efzeC+RBQiIdLJjjcLZBfop7YFKrz4yAIAE8SvXkA8j1vaVWHyXiL6jZSTqYCrLt4jggpwwa+6KtfXr7mCliZyyH5qy59+yFduQBWewUT/WPSzg143MpI+LSHW7KxFFZvuxPb5cmFr4KKdF1Gz3m/81Rg4B5nTU9AyiHVOqfVotD4l6KYYCxiPTetdaNYvvVKEdyaxdqpfOBTB0z1HJa6ND199QDGqzTVEoQObmoiY/gYtZWwZPL+OQyPUj4vaCMJkP2cJkYKoAa3Vwvx430QFUXQh61rn9qaxSxm4nqiTsTZlD4jwnHxD3bp1ae+Mgam0MHqSZwLGAltzvhbhStzRXYpuiowEp725wqD6OEidAqAr/5I0tqF1vojn11+8SbjHY1anXiJdXfWA9O3VUt8hgasEDi8CLJTLygIQPvVo2U4jJMlN1Q5zA9qAWR68n/DdSnNMyXfuFTb3kSpY4LPkltHOuEn4qDBBR8GmDuI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZDM5UnltQXpFQVI0MkZjaDBKNSsrREdVQkdzS2VvcVVOQWNjT3daK29OVHpv?=
 =?utf-8?B?UVZpK1JseTAxOHQrUk42d28ybmhOV3Q0OWczRnNiM2VBQm9EL3FsN2daU3dZ?=
 =?utf-8?B?ZmNFVytRUmx5alRZcVRWMERJeCs1azJKWFZ1YnZGMGhKRFEzczc2cnNOSlNx?=
 =?utf-8?B?dkhSYmdBWU9JR29YNkNOb0IwZmJHWFpTamRGQmRIQ2xvb0lnNDVsM0hvakU0?=
 =?utf-8?B?amtsY1ZEYTF5cVNPVEV2TU1lbFFZOUFIUXVaVlh6clMvUHhLYS9TN1A0MVlu?=
 =?utf-8?B?K3BQWkliTGlhbjljQjhSSitXU2VCbm51UlhML2lWdEhyaWxjZjdYUWZUamdM?=
 =?utf-8?B?SUJ4ZEZ3YU9UekZOb2hCVUoyVDdNVU9EdFNqVDVrOXVvNExIdWFIYWtRTFhF?=
 =?utf-8?B?Q09WSHQzRVBhc1JsQmpuWW1sOEZ5bGQybVExZDBPQ1UxV2tKRk9tRHVOMTRT?=
 =?utf-8?B?dTJKUVYwZ2U2RUpPMURmV3NLa1lkOSt0RWx1ZStiTTY0YnVJWk51dldxcWlL?=
 =?utf-8?B?YTdiWXduSWQrV0hnZzBuS2FvMlQ4aXhndmhoTW42eVA5bFJmb28ybmpyNVEx?=
 =?utf-8?B?emtYVkhmWThGdkJLa1N4MkdUTXZQdDNKdEJ0UjUxcWpiUTNjTlBDeTdGc0xR?=
 =?utf-8?B?bHIzeHN3SUFjZ3haS3lNWnFEWUJQQWlJUVRiSzE3bHZSalRJNmJpNndMME11?=
 =?utf-8?B?QzA4ZXJrQkZDZmZsalRTY0RoNCtaNDVVUERqN0JXR2poNW8rWUVvRFp1UWY3?=
 =?utf-8?B?WFJHNFZocXZ0RXV6ODNVRlJQM2k1Rmd2SFJKUUQrZHU1QXVNcFFvY1RNMWlx?=
 =?utf-8?B?MW0yN1BuTkZIWHI4U0RreWF4dmlHQkpIK2Q2Y3RWZnZWZXlNRXBwMlp2R2h3?=
 =?utf-8?B?cVNsN3N2dVJIU1hmaytiZ3hSeVU1M2FmZVdYUXBNRFEraU8vcE1hYklQWlFW?=
 =?utf-8?B?TWNPVm5YcnBwdGV3cXR0VmRYWHB5NlU2ZGJOQVdVWmZKSGpGd1dQazl6MFlC?=
 =?utf-8?B?QXUzQ0pyOWNTNFRXRWhsREpUdjJFNmk0a3JtMXdrRGRUdS9icHNyU21tcWFK?=
 =?utf-8?B?ci9DSmtRQytqR3lFSGF4YkdIZm5mVjR5RlQ2dklhQkZTNjl4RWlwVzhranJn?=
 =?utf-8?B?VlVDQ0Z4dm5SSjAxNE05NldoUFpQNmVrbTFWUXNXK0hFeC9waGNXTG9KWlhI?=
 =?utf-8?B?dG1iSXJreXZHdG5kaExmZ0trOFhjMkt6VHZXN2Via0VIM09JangwYnpPTE0r?=
 =?utf-8?B?eFpBZUdJamVpc1ZKeUU2akdndm5QTnZjanQxVzkyUDdCNjY3MmJIT0RmcDY2?=
 =?utf-8?B?ZDd5MHMrK3llcmZJWEN5cTFtcXFxUU1CcXYvaDNtdnZLRkd6MDk1anpOVnBz?=
 =?utf-8?B?dVRaVHlNZFFLUmFFMTUxTXVON1ZJaWV0UXVTZlk0UE5rVjFFQ1NVa3huRHU0?=
 =?utf-8?B?cU51aWZxVEkzc2tFTnN3dFdPNlM1MEtQK0FmMk5CNW1CQjJRVGRsbzFkYjln?=
 =?utf-8?B?ZUIvRitJbW9NREZkeTBHRmhjTHFEK2xQV2JZSVBkOVphQkl5UUVqMmZxZkpM?=
 =?utf-8?B?VXhlS2g3Q243a200VEkzYWs1YnVuWTUrVFMwVE1wQWNhMW5QY1JseGVGQTdh?=
 =?utf-8?B?Q1Z6QVpwY2pycVpsMDJEL29iS3lxT2ZhR3pxZ3BUbUxSM0J1UmJZZGJvYUFx?=
 =?utf-8?B?dHhrK2VCWEptay9ndTk5QU1aR24vS0kwY0VSVnJOMU9BNTZzc3pXR0hLVU9M?=
 =?utf-8?B?OFNxOHBIaU1rWDNMZDBSaGRjZTFWVFJDVXVMYVFCcHpMMjB1V0gxRDI4dFNF?=
 =?utf-8?B?cjhROHBjeks2OEM0YWZqVDByNFRIOXRLaGhKMzRXTjE3ZlJ5SEpyYlNMWWpD?=
 =?utf-8?B?aFhadnV3NG1FdG9uRDduZ0ZLTkJydU1rOFk3c3EvSmh3eUxnYlAxckxsU0o0?=
 =?utf-8?B?R2xlclI1Z2lrLzlOcmRLWHd5SGdHcys3UVpZd1NiNFhXTjR1dU1URWx0bFVy?=
 =?utf-8?B?S3NJc29HSHlHMkd4cE1JV2RDOWprSHVoQ3J3U05IRkNpU3ZJSGtZM1QvdXYw?=
 =?utf-8?B?cDJVMklvb09WZnpnVzNLek1uNXFQeXBmR0pGeWFsVnZrZ2NtK0dUemovMXhk?=
 =?utf-8?B?emlLZTFTeE1HTFV2cFR5eXlpSEEyWXU4NUkyb21rV1BSM3UxSDl4Rlh4M2VT?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BD1E148A5C8EF4A813DE340DAFBABA6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8/gaenTbUbwxzFPLqeCQ5R+8OwfDt6nYehKtvyBTYOWaIMOfl0hjHhdn1q23ctV69OSV64FsHwk4HYs5iK+oLFOD/q7sISQeBNIRIktZXRWFIX1YVET7QTMa+3R8NlGI/eg8MD4Y3c1ZjtGQceFHVxlWM5N69czUhabLzFIJd10MGbV9fTxB4jqqKwLzjIL2wbBOzMdqZhdJ7m+Gg9NcOor8qg2bZgAgzUiH5Tcq0wbE+MiUi7aGjkw77BtRMmZ30h/08LJxCWePo7oz8R1Quax5MflaqfcSdTk5SxTZ+ggBHM9JAfyB1ncQiKD+lHFyDxthpR5dNvPji6UE+eSKEdXoTidYdcUYE6deywkGJ3jzvQt327Z5hcQ8UvAseSdX4lnP3ira1jHKXhJlo9QX3tW63Aju/B8rWJjHcgto7fgHzi8J8zxN512eNQGxcjFbr9/KejdOXptdUqXo+gaxu6RInSvc7xd5gl1Gg82qpuH3Qd6YVEUySzhM7Oaq0KCEyAOViRqBejZC6H4jKvlqKse7EfGt6GYsAF0mpo6eQGHNC/oKGUJcp5uJYRHnTLMS/Ks6wmgWaFH4ly3MWQJJ0MAGAU7Baq5M/k0FLaOU2Ps=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daed88a1-6841-471a-d371-08dc598c2c24
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 18:29:35.0139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ecenMcutcs4etCaNwxW2mwo3lcRZUl1A9wGd3XCMk5vQtJRZlqsfSdaPp0FaWjB23liMMi+iNsg+E5vc3oKq/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404100135
X-Proofpoint-GUID: cP81NOgf6f8oZTJRGEHrkxa2V2PoIu1q
X-Proofpoint-ORIG-GUID: cP81NOgf6f8oZTJRGEHrkxa2V2PoIu1q

DQoNCj4gT24gMTAgQXByIDIwMjQsIGF0IDEzOjIzLCBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhh
bi5DYW1lcm9uQEh1YXdlaS5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCAgOSBBcHIgMjAyNCAx
NTowNTozMiArMDAwMA0KPiBNaWd1ZWwgTHVpcyA8bWlndWVsLmx1aXNAb3JhY2xlLmNvbT4gd3Jv
dGU6DQo+IA0KPj4gbWFwcGluZyBhbmQgdW5tYXBpbmcgYSBjcHUgYXQgdGhlIHN0YWdlIG9mIGV4
dHJhIGNwdSBlbnVtZXJhdGlvbiBpcw0KPj4gYXJjaGl0ZWN0dXJlIHNwZWNpZmljIHdoaWNoIGRl
cGVuZHMgb24gQ09ORklHX0FDUElfSE9UUExVR19DUFUgc28gbGV0J3MNCj4+IGlzb2xhdGUgdGhh
dCBmdW5jdGlvbmFsaXR5IGZyb20gYXJjaGl0ZWN0dXJlIGluZGVwZW5kZW50IG9uZS4NCj4gDQo+
IFNob3VsZCB3ZSBjb25zaWRlciByZW5hbWluZyBhY3BpX21hcF9jcHUoKSB0byBhcmNoX2FjcGlf
bWFwX2NwdSgpDQo+IHRvIG1ha2UgdGhlIGFyY2ggc3BlY2lmaWMgbmF0dXJlIG9mIHRoYXQgY2Fs
bCBtb3JlIG9idmlvdXM/DQoNCk5vdCBzdXJlIGFib3V0IHRoZSBwYXR0ZXJuIHRvIHVzZSBoZXJl
IGJ1dCB0aGF0IHNlZW1zIGZpbmUgdG8gbWUuIEN1cnJlbnQgdXNhZ2UNCmlzIGFyY2hpdGVjdHVy
ZXMgZXhwb3J0IGFjcGlfbWFwX2NwdSBmcm9tIHRoZSBhY3BpIGludGVyZmFjZSBhbmQgZG8gdGhl
aXINCnRoaW5nLg0KDQpRdWVzdGlvbiBpcyB3aGF0IHRvIGRvIHdoZW4gdGhlcmXigJlzIGEgdXNl
LWNhc2Ugd2hpY2ggZGlzbWlzc2VzIGFjcGlfbWFwX2NwdSBhbmQNCml0IGdldHMgY2FsbGVkIG9u
IHRoZSBjb2RlIHBhdGg/DQoNCjEpIGV4cG9ydCBpdCBhbmQgZG8gbm90aGluZyAtIGl0IHdvdWxk
IGJlIGNyZWF0aW5nIHVubmVjZXNzYXJ5IGRlcGVuZGVuY3kuDQoNCjIpIGV2YWx1YXRlIHdoZXRo
ZXIgY2FsbGluZyBpdCBpcyBleGNsdXNpdmUgdG8gdGhlIENQVSBIUCBwYXRoIGFuZCBrZWVwIGl0
IHdyYXBwZWQNCmludG8gQ09ORklHX0FDUElfSE9UUExVR19DUFUuDQoNCk9wdGlvbiAoMikgaXMg
dGhlIGN1cnJlbnQgYXBwcm9hY2ggb24gdGhpcyBSRkMuIElJVUMgYWNwaV9tYXBfY3B1IGlzIHNv
bGVseQ0KdXNlZCBmb3IgQ1BVIEhQIGFuZCB0aGUgc2FtZSBhcHBsaWVzIHRvIGFjcGlfdW5tYXBf
Y3B1Lg0KDQo+IEkgdGhpbmsgdGhhdCBoYXMgY2F1c2VkIG1vcmUgY29uZnVzaW9uIGluIHRoZSBk
aXNjdXNzaW9uIHRoYW4NCj4gd2hldGhlciBpdCBpcyBob3RwbHVnIHNwZWNpZmljIG9yIG5vdC4N
Cg0KSW5kZWVkLiBXaXRoaW4gdGhlIENQVSBIUCBwYXRoIHRoZXJlIGFyZSB0aGVzZSBhcmNoIHNw
ZWNpZmljIGludHJpY2FjaWVzLg0KDQo+IA0KPiBBcyBtZW50aW9uZWQgaW4gcGF0Y2ggMiwgZmFp
cmx5IHN1cmUgdGhpcyBuZWVkcyB0byBnbyBiZWZvcmUgdGhhdA0KPiBwYXRjaC4NCg0KMiBhbmQg
MyBkZXBlbmQgb24gZWFjaCB0byBiZSBzZWxmLWNvbnRhaW5lZCBhcyBDUFUgSFAgd291bGRu4oCZ
dCB3b3JrIHdpdGhvdXQgbGF0ZQ0KQ1BVIGluaXRpYWxpc2F0aW9uIEkgdGhpbmsuDQoNCk1pZ3Vl
bA0KDQo+IA0KPiBKb25hdGhhbg0KPiANCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogTWlndWVsIEx1
aXMgPG1pZ3VlbC5sdWlzQG9yYWNsZS5jb20+DQo+PiAtLS0NCj4+IGRyaXZlcnMvYWNwaS9hY3Bp
X3Byb2Nlc3Nvci5jIHwgMTcgKysrKysrKysrKysrKysrLS0NCj4+IDEgZmlsZSBjaGFuZ2VkLCAx
NSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9hY3BpL2FjcGlfcHJvY2Vzc29yLmMgYi9kcml2ZXJzL2FjcGkvYWNwaV9wcm9jZXNzb3Iu
Yw0KPj4gaW5kZXggOWVhNThiNjFkNzQxLi5jNmUyZjY0YTA1NmIgMTAwNjQ0DQo+PiAtLS0gYS9k
cml2ZXJzL2FjcGkvYWNwaV9wcm9jZXNzb3IuYw0KPj4gKysrIGIvZHJpdmVycy9hY3BpL2FjcGlf
cHJvY2Vzc29yLmMNCj4+IEBAIC0xOTQsOCArMTk0LDIxIEBAIHN0YXRpYyB2b2lkIGFjcGlfcHJv
Y2Vzc29yX2hvdHBsdWdfZGVsYXlfaW5pdChzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByKQ0KPj4g
cHJfaW5mbygiQ1BVJWQgaGFzIGJlZW4gaG90LWFkZGVkXG4iLCBwci0+aWQpOw0KPj4gcHItPmZs
YWdzLm5lZWRfaG90cGx1Z19pbml0ID0gMTsNCj4+IH0NCj4+ICtzdGF0aWMgaW50IGFjcGlfcHJv
Y2Vzc29yX2hvdHBsdWdfbWFwX2NwdShzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByKQ0KPj4gK3sN
Cj4+ICsgcmV0dXJuIGFjcGlfbWFwX2NwdShwci0+aGFuZGxlLCBwci0+cGh5c19pZCwgcHItPmFj
cGlfaWQsICZwci0+aWQpOw0KPj4gK30NCj4+ICtzdGF0aWMgdm9pZCBhY3BpX3Byb2Nlc3Nvcl9o
b3RwbHVnX3VubWFwX2NwdShzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByKQ0KPj4gK3sNCj4+ICsg
YWNwaV91bm1hcF9jcHUocHItPmlkKTsNCj4+ICt9DQo+PiAjZWxzZQ0KPj4gc3RhdGljIHZvaWQg
YWNwaV9wcm9jZXNzb3JfaG90cGx1Z19kZWxheV9pbml0KHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAq
cHIpIHt9DQo+PiArc3RhdGljIGludCBhY3BpX3Byb2Nlc3Nvcl9ob3RwbHVnX21hcF9jcHUoc3Ry
dWN0IGFjcGlfcHJvY2Vzc29yICpwcikNCj4+ICt7DQo+PiArIHJldHVybiAwOw0KPj4gK30NCj4+
ICtzdGF0aWMgdm9pZCBhY3BpX3Byb2Nlc3Nvcl9ob3RwbHVnX3VubWFwX2NwdShzdHJ1Y3QgYWNw
aV9wcm9jZXNzb3IgKnByKSB7fQ0KPj4gI2VuZGlmIC8qIENPTkZJR19BQ1BJX0hPVFBMVUdfQ1BV
ICovDQo+PiANCj4+IC8qIEVudW1lcmF0ZSBleHRyYSBDUFVzICovDQo+PiBAQCAtMjE1LDEzICsy
MjgsMTMgQEAgc3RhdGljIGludCBhY3BpX3Byb2Nlc3Nvcl9lbnVtZXJhdGVfZXh0cmEoc3RydWN0
IGFjcGlfcHJvY2Vzc29yICpwcikNCj4+IGNwdV9tYXBzX3VwZGF0ZV9iZWdpbigpOw0KPj4gY3B1
c193cml0ZV9sb2NrKCk7DQo+PiANCj4+IC0gcmV0ID0gYWNwaV9tYXBfY3B1KHByLT5oYW5kbGUs
IHByLT5waHlzX2lkLCBwci0+YWNwaV9pZCwgJnByLT5pZCk7DQo+PiArIHJldCA9IGFjcGlfcHJv
Y2Vzc29yX2hvdHBsdWdfbWFwX2NwdShwcik7DQo+PiBpZiAocmV0KQ0KPj4gZ290byBvdXQ7DQo+
PiANCj4+IHJldCA9IGFyY2hfcmVnaXN0ZXJfY3B1KHByLT5pZCk7DQo+PiBpZiAocmV0KSB7DQo+
PiAtIGFjcGlfdW5tYXBfY3B1KHByLT5pZCk7DQo+PiArIGFjcGlfcHJvY2Vzc29yX2hvdHBsdWdf
dW5tYXBfY3B1KHByKTsNCj4+IGdvdG8gb3V0Ow0KPj4gfQ0KPj4gDQo+IA0KDQo=

