Return-Path: <linux-kernel+bounces-90186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B3886FB7D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5EA1C20F3F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17575171B0;
	Mon,  4 Mar 2024 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XpM+eCfB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HrYWa3iZ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14A214005;
	Mon,  4 Mar 2024 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540234; cv=fail; b=Qrs03guTpkL6cInA2dJ97YzvxMfIS2nYBRsLfKx3c5bWEXVXbaPPP4EEBcsFgyV9+Kv1lBYNYGdBczGTAMxGy2W0ETEalofYhGuqCvPtoVB8utX60mp0MgidE+ioM4yQeUsh58YqTY+s847Yky7GNsSMl2JeNY8KBXgqH5fnh6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540234; c=relaxed/simple;
	bh=3cfHu5DvwQEP6vfIpGR9a6G9vTV7T4yBNz5sDN+BUHc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uU8W6One7KKBDuGNP6CFSD/vcMRnyx8+RfzwbstDFrs4bLJkWHPJIa8Sn2KyUpSlLzSwYv2+TjwzaOBjuFdd4LTs4LyBMMmdFJGr8On9Tg1RHdE8qUedQy+p+hN9YzLqTncvOgTtPI1v+h2SXU3l6BBz1YUSHFauxZ8aSEF0Zc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XpM+eCfB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HrYWa3iZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4247hrke015209;
	Mon, 4 Mar 2024 08:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Kq8/cNWQ9SgHGl9bGzIcmIi9ElVPzkVYLMVRXAa1d/E=;
 b=XpM+eCfBpVYg/Nbodqi+Pi2c1VaIkLssBnKZmoOc2jNkPXwFQVV3NFhj1fasGhRqDHhn
 oMtsCQ6R+M5dx5K7rlbv9l7CKl9AZA7OxKFIJRsFfi4pEcLpbQgzlSyuCzPV9NBZi+2T
 zacCysjlSNvZQgsJr84OTkw5+SqOzmWBmxVxoSGYXbxKBPayIbj9CD2Bq4kAreaXElQE
 P7d544d5h59s2jlOxMO0F7HvsmKVvjk96b9LWSnQnvkfsEfngy6N0e4ObTstyWnpCPms
 M5ChViqRqWOlPxZmj8kHH3ekmHTZRiGLGVs9zsL4BJvwcSg4i/FVWnCgMs/fi5DsaJUN kA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5darqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 08:16:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4246tw5P033227;
	Mon, 4 Mar 2024 08:16:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj5s2sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 08:16:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdPwRaPcrJKB8wNqZMNPEC7rfr8xRNf8J1imLDUY1V1jbXQbjCEY/Fl/5Mtb6Ohv2t8xVoyJydF8X4iRVPd60GnSqH6mITdsRotqKd+TMNKDD8OKyXhYVScgDIMms0QS/tL+7j0wZfJJIJaNka0hXYWQsVelPBdRvhHUrsxGdZQeY46n5sOPMK6feX9XSNpm4Sq/GQ2KFsVN+AYvk4IOakA9K8nTxyF7jT3/I024ALX6oy4wdT7rpbJcJvR2/sXb/kEKgXJFd5yZ5sZG3a3kT7nEV9rwoLjpjoz4MUcxgtR5xLOroE8x+gAJlrjygpX2ulJG7AS5yO5LS6lW70/Q9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kq8/cNWQ9SgHGl9bGzIcmIi9ElVPzkVYLMVRXAa1d/E=;
 b=ktc05YQcOi/IbFPYjkJFgQGJ6xkgA+l9Dg6Y9uL6ug4vK8OA7TwQ4ZbJnXACLKRBGRq7d95a6eI4tNZOVQeNmvgP8NJ4VnriodZsEjy7qJqbhPTwld6gW63PkmsoBW1eNV18ruGOCFytIqvV030hOAHY34PLsHa8yhdl3d9G1h+YsJhWnfjGGtDLXDeoCexP++hIoaUSgOE8jGZZMOdj+1Pzq+mcmu16keLmUyf3DVdzEr7SEH+I24jLWQ25s6J65QOs2PZhWMP1eBDEa4C4STWmKUg8FYozEuGCm9wgvWChos2WNVTjgQgPr2u1Jf7Dn0gYz4igAvilJErbzDls/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq8/cNWQ9SgHGl9bGzIcmIi9ElVPzkVYLMVRXAa1d/E=;
 b=HrYWa3iZEZ4k/4XyBAs8mEPmDHAKJRpe5lgo2i+S1rGin3Ry/iDh4YSrL4PTNJ1pKrtkO7LFLgsrDQ3RD5d9fI4c0YCHzruDe9iP3CH6iVO5qJKtKEDc4oM75WzRYtWHtflYY4VLNNiJTd6i/aBDBdUO+e9MJHuhF9skXFFF2GQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5676.namprd10.prod.outlook.com (2603:10b6:510:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Mon, 4 Mar
 2024 08:16:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 08:16:49 +0000
Message-ID: <6b59e357-9327-4480-bc3f-c02c474ea10f@oracle.com>
Date: Mon, 4 Mar 2024 08:16:47 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] scsi: mvsas: Add libsas SATA sysfs attributes
 group
Content-Language: en-US
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
        Niklas Cassel <cassel@kernel.org>, Jason Yan <yanaijie@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240302201636.1228331-1-ipylypiv@google.com>
 <20240302201636.1228331-5-ipylypiv@google.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240302201636.1228331-5-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0213.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 203fc835-b2ec-4c56-0c8b-08dc3c2370a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hVi+8D6jJpYv6blx4LjqGrXaU5UchR2wZmT2+UkSrS9D994Gemoh7ZM3b2ZTLbJTBTizecZK3LAybGC3fTMbtoNAceE4oH6HCvuMXpTBjF5HteCcogrbjPjmrD+r7vKuQ3szCO9vr+IlVDiCd2hJBIpemFUDElkZ3HxkjE16wT5AOrM4PS4I0Cl47VNlKeiKNPG8syWaVGnY0f6bXrTVDKW+m6rwks78i01hiy1PwyT1yt2mVtSkgbJqL+C+41mmpOzeVll7PqIjR1O7AdyJ4dVjqNOoIbPRFu40tGXmNDe7wrVoplPR/Xaa9dKJDDsF/h9eA70f31RLz1tHM1OjzhO9bXC2EpawNPTAxsFVULwrVEUpvE3BqD34BC5tznBhivrLHp1lsamnNwRcMLmHGQKTXJ5SOUKQDADdl5QIFc+znsKwABzO7hAK4JYsW1YEZ9uTLShPCv9sOondmLKxrUr1OUqEYqsz1ijOSMdvLqUJirlkSKcb8Yp9x7BKVUwpOvXyG5Ah+tRirg7t1xK7I95JiRt/XgIu819833Hyt78FhrkQ5tHfKWjD0dHV67MEouOqX+PJLhrNBjX80Vj5EEr1bXfgzC5JQH2Rjbq/xInPgXuio2+WMKOC6WBiNdyZl83sDVcjbnpzTM6cHnnFZvxfWaB6SSyyTAvy1Ic4JqdMyDElH6WHP3W106EMCnw5F3VyjK7DOkbR3cSDcBOHzw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bkpRNzRaTDFSMmMrVHkrWEUwbFpxalFOMElhU0JWSjZQUjJ0YkZIdEF6OS9x?=
 =?utf-8?B?N3RuVjN3RlFnY2JjV0tkRytneE9TVjFzaCtJcDBQS3N1K0FRSkdXaUgzajlT?=
 =?utf-8?B?a24xek53TS91T0sveXFjeUtQc1lKR1ZMRjAzeHlQYkdLSnI0S1FSNi8xVTAz?=
 =?utf-8?B?cHV1cnNvS3d0QmY4WjVkaFdlYkFXQ3JHOUZWZGxOMnZuNTRPYUhpNmVuVmZY?=
 =?utf-8?B?c2N6V0dyVnJ2SGcyK1U0OStmRDgwMng5ZDVFVmFPamZ1N2JHOTZQbGNXS1RP?=
 =?utf-8?B?Q1dXV3lIRUNkcGIrRlJNcGVreWs5cmM1ZG1RWUdlc2hsb0xlNHVNU0JoNURq?=
 =?utf-8?B?Sk9wNzVsUzRsaVlEbEN1bkJiU1hQS3pqeUlTKzl5SzVYSTlvcG5oMnIvNjkz?=
 =?utf-8?B?UVRSYUUvdkpjYzh1Y0VjTFN3eEI2Z05JYzlqNHhSVGsxWlEwdURjaGlGY3RK?=
 =?utf-8?B?UjhMZWMzbllkWXBWVzJZZno4dzhIYytoSWNzTjRWYTNwZ2d5KzU1dURZSkNk?=
 =?utf-8?B?d1EvU0hud2dJUHQwQTFrQXBRMjVDODlwQm5ZVEtyaTNsKyt5SlVnOG40Qldv?=
 =?utf-8?B?SWYxcGhiaFFFVGNlRmJSVWdNSWpwVDYyc2hKRVF5NjZFandmTkNHZHVuRnJB?=
 =?utf-8?B?OXNyZ2N1bFR1KzVxQ041cG4rajl4bmZoMzkyK2dQVlllRFBvbTk3OFkvS1pT?=
 =?utf-8?B?UklXcG4vTGlUbHM3S0tJZTk3ZEYyMzNVZUFoTVlUSlhKYk93UTFZMGZjYld1?=
 =?utf-8?B?QTBmbVpFQkhxcWhsMkVMQnhiUnkrKy9qUnBQRXVVdXgzV3RwNmMxUkFSaGxs?=
 =?utf-8?B?aTE4UTdWczU0aEtyMXhEYnJTWkxZcTBDa3hpNWxaeVB5MFBDaEdlMHl3cEE5?=
 =?utf-8?B?aUFiR2pPWXM0dzE1NTBvVjA5eU5PR29DWkVMdVhGaEJrVkIwNjBETWFRTTlz?=
 =?utf-8?B?L3RJQStIQWpZVytnT3lGRjBaaTFsenBzWGk5VXg2L3dOUG1yNEZjQzM3MVpH?=
 =?utf-8?B?Ylcwc3FmbXZpUU91UlNRRGZCLzArT2lNR1g4K0dFckZ0eHZvck9KY2kxQ29v?=
 =?utf-8?B?bm5qOWxWWURhdzZRb2UxcUVVZFR0ZDdKMmc1WTk0TmxvN0xuSzZ5UEV6TDAx?=
 =?utf-8?B?eUV5eXpSdGJnUkQvMDZWOXVIM0pVQUlSNXMveC9SeXNqekVnZmhLSTJsVVgy?=
 =?utf-8?B?L0d4TEc5cHlRTHA4WlFPVFc1UGRhNzJSaGE3ZW9seDE0ZHd2Nit1Sk8rc3ll?=
 =?utf-8?B?TTAxd2JaUG5lL1ltbXY1ZHFCUXZuWUcwdUY2c3hyOFFqakFqQjRhREN6VTFG?=
 =?utf-8?B?dWQrTUQ2SEtkYUhmYVllWE5mN3ZhM0JZdHR5d2xkN0ZUUGV0bHIwUTMwb0Fw?=
 =?utf-8?B?bnR6bXNCVG9LK3I3L1FHY1NLSVkvNEtKOWxNYmxtajM4OVRMR0tDS2U1NVBt?=
 =?utf-8?B?OVp1anFvQWNQVVJ0V0xyMXgwSFZKT09tYSsyaDhrZmdwMGt1MFovMUk0QkpX?=
 =?utf-8?B?NE5pSmZ0c21HQ1N5MTRBdm9Ud1ZYd0FXVDJTREpybGhOU2g3WDBITjVGRXpW?=
 =?utf-8?B?TlY5TFBia1JjWTc4dE9kb3dsRDJ0bEc2Rm03c0JWSmlTeXdZdlZhWEdraEU1?=
 =?utf-8?B?T1c5alV2eEcyc1RZdkkrVCt2NlE1ZlROZEd2OVJRaWIrS3F6cFcxb2NzNUx2?=
 =?utf-8?B?ZDFJZWYxdENqR3k1WXc1K3NTZGFTVzg3WUdTNkdBSENGZ2E5NXB1TmtRbzAx?=
 =?utf-8?B?RG5xR3VYRjVGTE9Ta3dVRWJKRHYzQlg0SjJXVnBILzVRbnVOcGpud3RNL3Y0?=
 =?utf-8?B?TXVIek4wZUxjbW16Z0tGSUtpaXlMNTR2UXdDOWF1VkJoaHlHQXVQQWpvVjl0?=
 =?utf-8?B?bU1Cd056Q2Z3RVRXRkY4QnJPTkd1VTcvK2hCeU4rUHIxSEc4TktBL2ZueEZQ?=
 =?utf-8?B?ZCtCaVBMUUx1UStRK0xReVpURWp5ZXdLYy81NzFBWGh6U1hjMFhJUDA3SEJY?=
 =?utf-8?B?dDA2emtuYldGUGw5Zm5WVDBKcEJzOUJqVm1qemw4Y1gxNk4wdFBGTHNzaVA3?=
 =?utf-8?B?WEhVR3ptY3J0akkzNXZwMjhzRWRtSWIwKy8vbjl0eE1STUd5c0p3d0hPT1Vw?=
 =?utf-8?Q?1ZN6C0ME6XOjCInLSon/hnaQ/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	M19wpF26ubxbiJoNqzeLdS2hxz2z/i87VmdkzuOCwfItOJVYXZAdePxWDZCj80FY0keK+q7n3EC5PbE0oYPxp/hmYM3dk6tuPchD/zkDoj34nlukzQPvFBtMZjqPj1DjFTGbQQQBkqYZQsr6XRpXkOFTAhdeDdR5hCeJkT94gFWt1AFfzg80MX2OuQvc2+WoOExl/Z4YRHQ5jnRmiw+2RNQMyMWFzSKzm5xTRn+ewfxBjXFYYdD4o18A6Bb4GOcIPQCq8Q1xdnpJdnynER4t9DDJs3T/quSHnWPcGNq2Z7UpKCXd6V5l3DDNTUAd2ls08UfzsFlbLH9bFgg/B0ji8m3QEC+1nokcmor4QJMe/o+ewCMaXoRfY1rQQHjbfEIx+NQR5O4KD/KuRsqqisa0VlNvUY7pVRW7amLmvdUFgICXYGo0h5KzmDCrN0Y57KjnLUjbCa8dn9/0NWepSdn5K0OmKCdqABrNj6BPywhLbk6dPg7laFfxfmq7mx5gJ2bEUTRflbNupnho64hdTmDK3gvwUH8nvqsGt71wQzrqbY+pgWttUdd91gqe/Z/Ziq1QOsr0WsD/NsO0f47HHwsFIErTd3TuQ5ZzvEHFhlHhVAg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203fc835-b2ec-4c56-0c8b-08dc3c2370a8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 08:16:49.3123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmNUIjZLEwbk7iso8eseuNR/zozxq62w3LraNXcGGDNeqsVKPkibbrIhQXIYuv7L9zqnaLO++9fBwdNEPDNQnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5676
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_04,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040062
X-Proofpoint-GUID: tG_4ve_QsgfmP6UFr9fyRJyR82nNx476
X-Proofpoint-ORIG-GUID: tG_4ve_QsgfmP6UFr9fyRJyR82nNx476

On 02/03/2024 20:16, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Signed-off-by: Igor Pylypiv<ipylypiv@google.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>

