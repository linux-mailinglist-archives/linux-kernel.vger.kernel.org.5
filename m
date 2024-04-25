Return-Path: <linux-kernel+bounces-157907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D74538B1872
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEF60B2527F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3802F10A3D;
	Thu, 25 Apr 2024 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YZc34OvS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FNCCtel9"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A609F9F0;
	Thu, 25 Apr 2024 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714008483; cv=fail; b=A32nlsUCdnRZRmJ1IUNg7y0vvzMP6687La/XSOb+HF5uCJdB0yFyyOjUQgusiwkjkC8I5kUQOjITcInSMOtvuQhySWHKfTkQYzlO9uFyoujLdOUPUKh3VcFoob0QVqLfsT0BIOthdwE8dBiYB8PhDILY4Q1cOon/Ina3uCSWbZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714008483; c=relaxed/simple;
	bh=a7CeKpnohUfb2gKgzwYu/+HaSIrLe13Iu0CQby3ohxs=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=klbZ4GEUBW2nmZKi4mvgblsMJVsLAnPfUGXU7tT2vihUN9bNn9UGgkwYCsy9v9uumKUioD3NH2+MO6uSUXHjp8sV4/rIrSGcDLWnmjyUl1XptwigjkeFh6pqWMGDHsrAk8sI5xhDVyMTrdFTCry1tJIkSMAUx3G+BtCIcXe6NP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YZc34OvS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FNCCtel9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43P0hpmF000704;
	Thu, 25 Apr 2024 01:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=0qN3btHPEi9OTW63RWc+ger2t1X60kJzwDdjrTk/eis=;
 b=YZc34OvSaOpxdIfU3KRgKVsd9EaByqKhVwqzDq5YB7JmI9NfbweSqD6xWjbHqQ5OK5LK
 koIRjaejoEFROPxb71955itHtF6uotz+IoJqLyVwNplL178bLNC3TndF5bX/NEWLfSHK
 uybvfLhcyevTrT9GwKb7cQnFS6CHNRdf+NEZFENA4KIO5UdP2qUhorm5jGeLqC9Rv2GD
 P40ihegHOyQn2CmxE5wtiqgY2G6UAn9pDe0l91sZNKOGZ7MlmrsW1pyw2Q/KvqoDB06B
 LQ7ptgwvB62ln8Bbhk4QyQR3Ord1kj5uUqQBPcH637fDuiuxfwVJqbTmw7EpSd1Prabz Xg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4g4hg9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 01:27:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43P1QpMP001768;
	Thu, 25 Apr 2024 01:27:56 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45a98pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 01:27:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQ4HBALmAyM2cO9jRTNtobutyNC2c5Jb9HvmSF1p8bAv0R+/wxkjNTfXgNShqJRf7QZ8RU2xv3tzbUi2FnWu83KJUhgm3LN11lmw0S9CO/WqSJxEdYi/IpA97gIbOv4WiLZM+ekGWAmdKIHPVajEkuxkxJHBmwhUr6NVgs+rUffMbrjIsNbXcneDllvjuM/wyUg9wiIXE7w9BVUzNlBm1FbN2Osej6OFtYIAkGCA/4GRp+eWgDDksh9bOd2IYFGbC8+U814ugd6oxqbOc7vb9ubtPKLeqkAbsvVBuL20vjEI5Qi6Gc40vJPLE2W6hs4tZYjFMNDyI6TeoBrHVQTOUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qN3btHPEi9OTW63RWc+ger2t1X60kJzwDdjrTk/eis=;
 b=FvgQ6W/qAOVHBOMB/HRK5BaxbLw4+Cr3HNxeaXPQIyEeeFWqP9jYZ8FiNAU6bedfB0c5NGpkEHvYlAirk1Bf7Ojh91EI45GZ201MFELFKSuLCXnZ/MRzn51i1HZKi3gRRit5pZz+ghlJ9NQUD75fPQEMcE6vDz0PwNyKI/jIXxg8Zsjy2nJqAkdMDT+k91DZu7r8iT+oiyCt1Jq30fwkwVS/XQVnWlJaqZLjraHojQf4YJ135+b6BPGHDOrrThNZmpu/tD/icPyRXX20Jy5nKq+ZwuGLAwA7wW4emr/bzuPtyRxZo9waOmQvs+quFVl17Zz+Pog++IQX9Ru+Emss1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qN3btHPEi9OTW63RWc+ger2t1X60kJzwDdjrTk/eis=;
 b=FNCCtel9kACI2gTvx0L1ifSsRCW+lDJHDYd3Fpm/QZY8zMBf3Cl9IWRRMpbixVBwboK+rbITYGt2ztc4Ljhyo5TvHDyFbVqs5pS/qquEGqG9gx9xt9O78JLAL3zv1KC8QrVtMmO3wDQbM3j6P9PNvw9V+bRON3cFkeB9a7ky4Z0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW4PR10MB6584.namprd10.prod.outlook.com (2603:10b6:303:226::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 01:27:53 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7472.045; Thu, 25 Apr 2024
 01:27:53 +0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>
Subject: Re: [PATCH v1 1/1] scsi: Don't use "proxy" headers
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240423211843.3996046-1-andriy.shevchenko@linux.intel.com>
	(Andy Shevchenko's message of "Wed, 24 Apr 2024 00:18:43 +0300")
Organization: Oracle Corporation
Message-ID: <yq11q6u8c4z.fsf@ca-mkp.ca.oracle.com>
References: <20240423211843.3996046-1-andriy.shevchenko@linux.intel.com>
Date: Wed, 24 Apr 2024 21:27:52 -0400
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:208:329::9) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW4PR10MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: 5293ea3d-91f3-43d4-4926-08dc64c6edc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rnwjq5cGVIIh7QitVnvIaDkmnkB7hCSgE7N8B4l8L+d0c5Q+mu69g+/iM0Rm?=
 =?us-ascii?Q?MHINTNMlw4Y4k/mABt6FWwAFzV7CjDVFuMMnuAx5IlQo8yIgUBRuq3AEohik?=
 =?us-ascii?Q?jrf7dC5J9nhZHIS/rN3V9oOGXr+dHWLmxs39eMypIYAU6BBwW6cMbaO0/qFl?=
 =?us-ascii?Q?J/cmCnBGuPKL77KYNl4MqjBmYt8+bYVgKHpJUnkhWDL+U1NKNEoTxb/Iq3sk?=
 =?us-ascii?Q?BVgOtbNdFQkTc1Ieu/2YjNm2HNlD11RDjH7BvPBaeShH/SrHthxO3HbRWYyW?=
 =?us-ascii?Q?7/tpyy49hJratethlIrbPug8fhDZDzKOGOJegAZBPrCdQCwFKycyvnWw6FX3?=
 =?us-ascii?Q?0IsuRm8SqA2QZDw3bYUUsep8k0AdG15aHfNDAYnroHT+WH536aSh5tdp9H+2?=
 =?us-ascii?Q?uXuFBT8MKPWUXST++SexigjePko24iBli0VX8WwowyQ71QolgltqF8bHaytz?=
 =?us-ascii?Q?TX24LbfunNyADufBqlGwuSLtxqKxgCHM9CLYnnrUl2GdWPV5W3gnIaBRYMNU?=
 =?us-ascii?Q?QwR8JsjVsYlNsUOxaqGhASyIsT/4uJvHItZkkgSZRy7W8UcwnK7QMT9MBLFd?=
 =?us-ascii?Q?Sl5E86qyokhfbWyziq5KIWDHGCmFCGL3ZxzoEMZ6DqEY8BErOwVjEe0qwweV?=
 =?us-ascii?Q?tmZi59wg8WIc3FAgBfXdfJNDU3PPkqLIWKw3qvf2TFfCX7/ESw08bDcTNl6n?=
 =?us-ascii?Q?OpO7r0ABQxtgnizjBOhqPTzRDYxemktjzEXINSQTnQb7LfBi5zWkwCCp94Ob?=
 =?us-ascii?Q?v92asT3XaoRWMz71RZOEJnEl04YcGauxNn6L6AdTAsJkTq2qktCzx8C1/viF?=
 =?us-ascii?Q?GQrIU6/NxG/qKZ1vl2uSomoa3dBZ+JHpHS6TqeITWWJu6z7mRhVoA60mVrp6?=
 =?us-ascii?Q?jLSQaiQmprXsxVPxKcveZGUImMnqqEmvBAvOOzIwA2ElQ6le0LjV4b3Ouf1O?=
 =?us-ascii?Q?Fbh0IywOyiQ7Dksu1Rr65ig7OQizllh1q1GyIo9RF+3o6y6zaVi/GSdYILFt?=
 =?us-ascii?Q?cHZj3bfYO1DJpOSSg7BNUUnJB3PnJ2GuKLMHMG7pdC9SCTkUohBFk7pOR2iB?=
 =?us-ascii?Q?x2G5nY/0+7tX+mfPZPZBNUa1j4ozMf08lxVrKKdX9w/BukAj2mFMSB41V3aM?=
 =?us-ascii?Q?hFr8Z+yJErFekbjtLdJvfNuye9/aH6RC/bfDgNiifziZPhJb6QIg/rykwMyb?=
 =?us-ascii?Q?0bRUXJQ4zy1pKbnaVC1ZTqnJCHs0MqCGbYAgVhaHJBPXEK5gL7LZ9CrPHklv?=
 =?us-ascii?Q?2gTaCZHHb00LKcwBt+zTU8bSrpF3Iq2k/cRGVQzGLQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gEykbnqlb6/caEMycSONztvjAkTJswvNvq17qheb1x8cTbwEjVzePOqHMuQp?=
 =?us-ascii?Q?NHSpmxzUX1Y6PWYP0eGHIDlTQ5ffXqjkAhyOzIzklnGTCpLDgP/TtIJPQ5uY?=
 =?us-ascii?Q?hmweYOwLKFGokWqir+Q5R3er9exZScwwL46ZM0I8qLMGx66DgAFHGVG/Q/Xu?=
 =?us-ascii?Q?b/bI7YIceibCWL2YJoAHTIebursjCmMI6D9ihYtzNxXEKkk2pM/rvAqwubRa?=
 =?us-ascii?Q?mB0SvD6d0pv4y5oyp0O7kwhRTa3iy9rktUD2pqNGo97odNEGgmzQU9ovSOm8?=
 =?us-ascii?Q?S/aRN7NnaYvmdKSF4m6+UsMDDiooN2kAtK6QSP8jTQL+UJBmXBHvB31ZAGQ9?=
 =?us-ascii?Q?UBNiZ4t90tOTUADoV6eM4IkR+DB6xa50tsQBq83zzBn60fXJxEy0yBvP+rLJ?=
 =?us-ascii?Q?06C/CZOqZXaQs3LBjAOpTIckDaffUpDZN92DaimCY9L+zXZgeYBgIzzTG0CG?=
 =?us-ascii?Q?YX9/eHL7TzU/eYdxsOKqvzlS+7ZO5O4qsHC8eoRLLkPw0wN3ZgQtcvObhMeB?=
 =?us-ascii?Q?d58UBA76tip4ZUS3H30QVm8m+Xy5nvMvRWnb29DSypSW11uR7K1w3GS83H1P?=
 =?us-ascii?Q?AV9WQE4G5nNytm/5cOYbnaq5bOq/AXEUugjuvKqhYwG2Dcbs/yR/vqdIDz+O?=
 =?us-ascii?Q?1zDZutSqQgZvEDSNHuiv5ZkEpQRcaa519yCVoninRgAlYrEXsUNRrK0nrRaS?=
 =?us-ascii?Q?dTRRq4CVxxze5RG8SfAO0e+DhGoKeTwJ0UEXLEbs5gmYUxNLbH0FvCESdGSv?=
 =?us-ascii?Q?gT6F4HRfsBMmYRl/BVMCdypyzP82IVL6EWLh6laCDxMz7j1ylste0OXibQev?=
 =?us-ascii?Q?u/auz0m0Oz11bpsEF85DhdI0Czdr2Aeh2xvRZUEePQfRgthg+Inq0AUsghK7?=
 =?us-ascii?Q?xk1rTTalQRiy/MEHGUIR/3lOs66PPfPXasODO7NOTOU+SHVMDjWI8KVkmTtJ?=
 =?us-ascii?Q?uQK8qZvit7SIDv9S2CyNZHoPNMXl4xbQqUDa20OFZkCNrVFULvFaAk0tdpoO?=
 =?us-ascii?Q?n87Kq+fwVnEbVjigOLLoTpFAEqHS9yWi6e6L3sd3rRi5asszlFyO/FJThXlA?=
 =?us-ascii?Q?z3zV7HNOBfDBmp0kVz7QCW3dOwqVQaU0cvotDA0+AMTn7ivTYOhhQdBZtQKX?=
 =?us-ascii?Q?53xxYr7Lux+iGB+yYoGEMkBhsg6YUVRMkKYNB3AyGdmsU2uqqCcSnNpsXaRh?=
 =?us-ascii?Q?aKwMb0p6Mkex1pT/7fCsVDAqmrqaPBneXq13NCucScikjCQFBwlcOJK5Cy8M?=
 =?us-ascii?Q?cfbCw6x5h8QlX7omiKfojStsYJyxT0WQEs04DUxOHwhm/izwydYO03vI7n74?=
 =?us-ascii?Q?A0ZebiVlRBkkmBPLiqlJW05hqRNLywlfquHrqmoFgtGz8XpTO1Xt+rSAc415?=
 =?us-ascii?Q?XU+OUp4NYJwjnqm8tqTiCBXYf/Z4lxPhQSvduDBy1n7GnpOTtPZnzzdpwUWW?=
 =?us-ascii?Q?zTkmHTQTcTXuFc8OzjGkFCse8snbAefY4YsCOADAJ6cVEILfahUX7rpBUyZ9?=
 =?us-ascii?Q?8WT8nMO4yQWYKAd/YHnf1nKtsDnP6gHjF2B6zGFgtHcwAuqBl9WLEOKoUDze?=
 =?us-ascii?Q?LWU1xIu627fAMzE0nbeEdxhzGOmB5/yHCWpTDeHWkvco/ZIMpyqGc5CHXUFh?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9Ck6pS9IeEcrYiVD1HUvDZRTOrAI73cZ1PK/QdxVwpsfEz5YNUzrfwQqX9elc3R49P/r0rYC9IoQgpfOTU3yc2V5CxCQX/j7a1nBlRbzOBvsfeNjaQ/d2bZW3hF64kkU+PR2kWPe4XFRJ1zJdAF5MVqpTGTIzqOETzj5Ix16Xel3DkEsnjkZ7f+D0Djq+/nMfos4K+wGSCBjIjjlM8CdZP4Vx3uE981ZtmKtPJoGUeKSPZP+VdSbQT6U+E/irHTY+syqryz+GwMlKnsLJD+ff6yHbl4U0NzuHQTu4aQjRtKBkA1UAA6bQ7kcmc6N5m9Xm13kwW/vT3PSnzDNoQkj9Vt7/3BgHCVZozgDyHL80t5FQvxCtPR4ECldPg29+Y3QhN4VtmBadwVQkQEXGawS9lC2nWQy/u8y0urI/A0KTzUfp6G3SBaEKjnyNDkDPzZbsWL9Lmce5Z5Wi/zs9MeTGRXA0oc36ScPRkyqmF3WJjUc4MMRa58tAMgGj3TYXO2jWoXwV9lByz6zSwBpLq/gJ3vVaZwxPbZp6LYA4uxFgAOfpiMYDgsroMdoy2VAUewRR1XfwEpEQKfUkEajU/5l1t6trRGyIg+mbIHT2KUeOXM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5293ea3d-91f3-43d4-4926-08dc64c6edc5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 01:27:53.6142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKsNYp8RTXiZPrIAluH6NyC/Be3RhKbYVyPTPGAIUbWL+wvPTrY0a741tAMWWEHLGDoagqZxEJ/bXqeawQEJflC55tMP8OVnsSArOa4jg/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_21,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=944 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404250009
X-Proofpoint-GUID: WHE6BgPfjWtUP7hzeCVgep1JWmBhohoq
X-Proofpoint-ORIG-GUID: WHE6BgPfjWtUP7hzeCVgep1JWmBhohoq


Andy,

> Update header inclusions to follow IWYU (Include What You Use)
> principle.

Applied to 6.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

