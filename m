Return-Path: <linux-kernel+bounces-30625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0175E832228
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E0C0B232D6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B981EA77;
	Thu, 18 Jan 2024 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RsqxWPfb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SvZhrG6+"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1271D694;
	Thu, 18 Jan 2024 23:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705619642; cv=fail; b=S/QqZlISyI8Grj+Ru6R4Jls++FJWY3VDtpUn41UVowR8S7ufH2kC3ol1LNx8tVJY9rMhdzft8fX7JYyQ81H6QTtBLVr5DgtwBjSPhYkUMqCqG9zC5zRnBML+UkaP4qy02mCdcyIkTqJSnwuQm2pxBRgUBCHAc+V9b/DNiIS/yi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705619642; c=relaxed/simple;
	bh=dBWkPdHcCexZw3jIBekgX96JJgn+4ndr9IhWvqoE0Qw=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=I/xQNP5OFisIZwBEYKY8Mh4SINEDWscJRWCzbbD81aNnp0AsH0RjiHWzyTLlJbwdNP4VsmXnXtrjpelS0RLk8Ve6Jvnyxqcvrppzq40m/z4RW8nDeskpvxN6tM5BzfSHoJ76NarmvqJH7iycOPpQcS0BWSJg3EGfIBf4wh4ZXQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RsqxWPfb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SvZhrG6+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40ILTC8h026409;
	Thu, 18 Jan 2024 23:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=qvMKmwSt/RAHnp3IlqNtdVYhqMBYpXJZRHxAq1JKloM=;
 b=RsqxWPfbyumu2wiHlP1eFCzsP2dgdVSFHBkRavWzP7V+2ozISlfa/Af5eXzErtW8NBuf
 gQFboAQgsIM/jnmOVaxb7ezWft5E7zOiofqNAakT/qwaXIWfbO0Um8OS9hUwdbHYmp1J
 jQ1mkCMSjdgnrR0gcS+7iWAxdKcgX4Bj1MDDFg7HDwR7OURtul/eKp0p3+prlkqhOYC7
 kbLiVEHjusFhQwyUCzRFFxMvgSWa5xoHaRMLDjopfc2oWQecYTpp193dywCayjsMh7px
 5xuyqhlwZ69VuR8bbag+Qb3gXOmYizX4vr9NyrTzFo9xHIIqnCEPrEpS5HTuQ84CQY5l Dg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkjjemab9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 23:13:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40IN687Y005369;
	Thu, 18 Jan 2024 23:13:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyku0be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 23:13:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjTkm4NWtybW7gs8O9kxGCV39fgRYGWvNzIHw7edBew0KbMx6mDv93Pud70V/FByBsccnN4k1ok7B+ovkOX18Wx7B5M6nssUkauzUvPv23wmRfd/YbqCjqKlVe+yYc4r52RCIBdh2gfqcMMlszCInLr2kh/NZNEAXhVjMyQu0y/jQQn455ZQqg+0q5PHAJrNnxnEULMZTtKfCAaXQm4hCVIyRkepNaJUMytXs1Qn5vFs+6/hn3TwWQgNT3kpPYmz39rAQRbaQse8aSZNwyisZSZrxbqtDyQh25AbjEVKDbWRYSDfpncpL0khWp1nxRX1f/m7FcVdi2tkR4yXol84/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvMKmwSt/RAHnp3IlqNtdVYhqMBYpXJZRHxAq1JKloM=;
 b=ZNYURC7Kzhtg0LMc8yH3FsrsIuO/Bq/8V+iFoNswPMaSHgymX27U+fOvEFOLk3vdG5N6GGDTtDqbtm4TUFpfiC0f70Fut1PQAvWnug56xXv5fgHyPdut7b4BzJogctBUu/UaSjm6ZX/26j2QGiSgwS7qeeV9XWf8ql3YntbAqfSndFT3VxGKt/qJDImwcXBictqsWuCkBwjmzGXNjcQv+e9H9mfJiyKLxKcp5fip8Rp0eYbMYQ/VBJhSgNoepJjY3uMfZr9oBwv9E3l0F1Bo0+2C1G+0FlKD9R6Cs5Nat9TH9ydpAJ2vdFUeB4+KfnLXD/QmN51ufRphOh08X8nniw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvMKmwSt/RAHnp3IlqNtdVYhqMBYpXJZRHxAq1JKloM=;
 b=SvZhrG6+oKJVcRoHUmQ4/zwmuJR3shhD647+kSLjxX8uJQPCSV96+B4Sg+ISosOdOvudDCoivA2xQf0Slz8AZSo/F24kY4tT0Ns2Jw0w5a7m7h0V5SZ9OYUJL3qcxKN+242Nmv1dFYd3AnKuTFFtaTheprkcGRnofPdULh0Ef6s=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB4447.namprd10.prod.outlook.com (2603:10b6:a03:2dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 23:13:46 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 23:13:46 +0000
To: Kees Cook <keescook@chromium.org>
Cc: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>,
        Justin Stitt
 <justinstitt@google.com>,
        Michael Cyr <mikecyr@linux.ibm.com>,
        "James
 E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] scsi: ibmvscsi_tgt: replace deprecated strncpy with
 strscpy
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h6ja1bhs.fsf@ca-mkp.ca.oracle.com>
References: <20231212-strncpy-drivers-scsi-ibmvscsi_tgt-ibmvscsi_tgt-c-v2-1-bdb9a7cd96c8@google.com>
	<202312121321.E15E09BF@keescook>
	<9f246fbc-b2e4-4585-912d-a5a00ac8cd04@gmail.com>
	<202401181442.ABC133B203@keescook>
Date: Thu, 18 Jan 2024 18:13:45 -0500
In-Reply-To: <202401181442.ABC133B203@keescook> (Kees Cook's message of "Thu,
	18 Jan 2024 14:43:16 -0800")
Content-Type: text/plain
X-ClientProxiedBy: BL0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:208:91::25) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB4447:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a93948-20eb-4679-da90-08dc187b1f46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	C/p/pC2+bgP5QFP3uqZaabYx+RATYHFiEjoE2OVfJ3YzRLK81WDq3yOrkajg5wiTjUPYS9QwvtTsdu0YDarjt0/6oTGxllUmxMvTmdQHoABl1mQe3yHLx4jOCWj+vtorrmdclWLPoLQGhpnm86FpLwJPJ3psfIH4Ab0eGCjsdqceLFPNeSrG2NBCD/9X5rF44HqAExMBeOLq38HYu25HUApQUKEJqWbZ/9IQVJUDu0CoytxMfHv+yj5kl2Uuzaf6mBEhSnZQxJYXCCMlkGTB0UztOQTyE+fp2CtTGVbn2HhorqDPuBpb302L6jZpVgYDrKuNoheyNYSkPCtEOqa1Qoj+Ev80HxfK4EGGK8/IJGKzYKIEgQ6YIu/FpmMmdYF3oG005FXE78EMUgxVaoeWjFv+rXCnnt3BAsIrL+lTAEFj4BOn21z4jIXF771ssxN4O0MeeMH2YlZK5AhG8op1nJ1jcgEZ9kBAZ9HDCL+gVXNa6XXioe36F8VY4mo/8B9z1r8zsiQkrbYD2M8aXVTMYNq1AvSJ1TZmppWcLu5iP0rCzybJz1um5a6ywO8Jx23RuDDG3wWFecU6AKZOvcgykRP8k0/wZlxImZvF0SOtbtEhQn7FRN0y7foGgyfJRmBH
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(6486002)(478600001)(86362001)(6512007)(316002)(2906002)(41300700001)(6506007)(36916002)(66476007)(66946007)(5660300002)(54906003)(66556008)(558084003)(6916009)(4326008)(8676002)(8936002)(38100700002)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kGLtEWbV1RD/StUs4rMcXkThgSEhaLUqIpe7IyzW8ZO95NIU0ijEC5Qw5+Go?=
 =?us-ascii?Q?GGkl5mhypJit0g0yJn6Y1yHZveHZ48P/VPrzu49logSVZAzOD7TFhOv7fAxQ?=
 =?us-ascii?Q?xZzJHy1gX2hdJCVe9IUJR+LXqGIdxiZbAYen77wFE1Uroqcy9V1fhYmduJYl?=
 =?us-ascii?Q?bZs8bIB4I5cB1i0IP/mWCUQSXXHxwjfK8w4TcS5eB32NqtwjQTq3uMxdYc6z?=
 =?us-ascii?Q?pOsn2WGLh+AZeoUMjeKdGHYf2wOhAvHb/C0K9BwTuWYkUKQR+73Te7lPY9N1?=
 =?us-ascii?Q?ZEIv91HRL3Wx/t9KUlgG/IzEYqptm8r+3EYywhtnV+r7CRA7rAY7Ud5S+Icr?=
 =?us-ascii?Q?g4JIpXeqKjkSAcgnXjlO8rvv6X/cIlME/HuObBBYOEGUP9IX/SmdvCwscl2s?=
 =?us-ascii?Q?aHON69RTxI2OD5LqiLLPW/Tdbajim16N2yLKwmyR2ID+fG9sn5xO0VsHewr8?=
 =?us-ascii?Q?scGiGaBmeTrhURxWPTzJHcWbAMl9jbM+V7pRJSGf235lM2cZK1bTaMcMQS3r?=
 =?us-ascii?Q?NrysfG0qEASvaP7+/GtntNK7AwSpwWoVz2B7psJiAJduN9PeWgcNwX2CFHay?=
 =?us-ascii?Q?5MCmiMW890wrB+P+a1pNER7icSj0wr1B5HHf/r+KCUo3qsXni/zNLe11A/eS?=
 =?us-ascii?Q?oCt+kjk4yyt/R54RgMjasXSwDKyvWNQcvnRDC0kpJmUb+jbu+7ZOdnn+NJys?=
 =?us-ascii?Q?0cyEgvUZZs6ZPDtadchxVAzOU22hICSND7ffqqJM+FI/QMoJ52GfoUbw9ald?=
 =?us-ascii?Q?LmFcR/nIOnKchOE9sVJ60My9i4fvqHywzEsIUJ4HN/FroNDHHF8uiZT4mMyy?=
 =?us-ascii?Q?P/D4zAbKHvX0NWw5WlXJseVQwVSzXHN2cXX5IdfZyU+tDz5tWB3KWaKzZQrQ?=
 =?us-ascii?Q?q3UkzNQGwO7MfUlAK87UuM2dcOF9wpjN9M221z0cf0MKUanQvEZRMFYd+4dw?=
 =?us-ascii?Q?e6iZXtp0pSDn3u0J0tiV0hFfhnz02Ucxc76peo4ADm1znDjlL/WbnkZnPy+A?=
 =?us-ascii?Q?XpCAyow3bzJ+PF9RohpaIadk1KPZ3f39+7V2sQeDZGPSSlukOMvW4Hd1uQ69?=
 =?us-ascii?Q?r1i3nKzzK/KM/FD/96gyjgcTt1CDZefoUkgNgUyedW2CMVBYoRuq8NA4Bcg6?=
 =?us-ascii?Q?QFVwevLMJ8OJJCDjf4QYV7JqgQ9H9agABCcvKNifHn7dDyYfOZdIeYkHUk7g?=
 =?us-ascii?Q?qrkPWksVVU0Ud4OqQskvx0mdERClfDAR3OeoDzuMT5bQFeiXlP33QyofFKnz?=
 =?us-ascii?Q?F+AzvD0t6UNOVxKF5mWBoynA1KZimH/FIKGZUSRmAx3WvOd3OkX8AF+yLNw+?=
 =?us-ascii?Q?iu3tRjOocZSh68QCMnXVCBEzjuWnG1l2QFSMliG797lTlCx19sWAxECVIRth?=
 =?us-ascii?Q?H1FlYWKWZD82GMRnPE2CzEM2N+wBCMJRv3NF8HU0C0q02eXIfDSWVkIND/X4?=
 =?us-ascii?Q?BXw/ybdFxF0oqTK0ZlOs+tMlxEnK5M6rmFOVxQVoMDfkd9AptL9l8jvQjpVq?=
 =?us-ascii?Q?rSW0japV/J/WlUIIZIt8Mu8G0vNbO4sMOGpcPUJluJ2dG1TrBpmDB1W/Y8sd?=
 =?us-ascii?Q?8iDWYFrMu/4S6GW3ZqFMXdvS0c7WwSrv+F2fJpgnNULHWKa8gdpzI7O7skO7?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZESWDr7y2Iwa2MbPgaayClAM20JEUa/g3BlZXVxDSDcgihPh8jjNe6TU9vhyo34Zd0t8+JGmAQFtgzuqmXwvhRyhJsrsAVx5Cz5iLYGZJFAbEgQ7hIveqA5QzLydnn2WhrEj7HBwoIdia8iq/zNU9C76rAk5Ixp8rD+faWJpMGQ68b/Pnkltjsp6zdxhkltXfNhEA3K7IcZPcJySXBavexbL1cld/Ov2K07K7luO7OpjiRlU1obucVW7gZZVgcW3ofVElpabe02X/eG2dD0bJ8xfe9tVcU3pWklY/BBqdwF9wlEDkXIytx+kEBvTKAoGFpYslwjf9PcCXkKCU18TiwT8rdqbtRL+wTz4z1U7a+YKxha3gNEwhyQBSogD/UPsySkONnK20Z5iH6Y5ei7/e16AfOLJ/A5YVLV8/e5SqadpLySG6rerzw2fDfUJagt7+t128nA5RUnFCdr9nmpF8qb0BoCG10m1CircEpGbUGWusSDpOKWKnzRqm3UcECbuL+IQq6JuqAQePnPgt57+nAdQsr7YevTC35mLtaEXn1QFDkDHDUqNlnvm4m6EiIUQP2NJAIV5c2Cpg569i2yuvNr0/hz83rCuCP53690bP7Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a93948-20eb-4679-da90-08dc187b1f46
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 23:13:46.5869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGeXA/k3z1J3+WiLX1ZqD0rrB3k2RQfsaVvmbUzDhM0f5iSXEcgewkOhJFNSJdN0DN5IJFO3D5e7/Ve0cfZ5yGk96gdZj0fiq8D9R8ujntI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4447
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_10,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=594 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401180156
X-Proofpoint-ORIG-GUID: kbNlDXhl-CQY34NuyXuJKERRpgwe7yUl
X-Proofpoint-GUID: kbNlDXhl-CQY34NuyXuJKERRpgwe7yUl


Kees,

> Great; thanks! Are you taking this, or should I carry it in the
> hardening tree?

I'll pick it up now that Tyrel has reviewed it.

-- 
Martin K. Petersen	Oracle Linux Engineering

