Return-Path: <linux-kernel+bounces-63791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EF685346B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8A2282531
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0835EE80;
	Tue, 13 Feb 2024 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iNTL7Dok";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T1BW/yoJ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEE25EE7E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707837363; cv=fail; b=HxTnNabsn1aKt3o120B4i6B3kN0zSSnuH922PxiPb7TA52RxUjAtE5S2YFj5iq4D48qiJyP4D8Nv+tLYVPFmFTJey5NLw6GYKSE3baRoiL37eiFtOWqB4aD/yHgiHnS3jrJBBomZ0wuRcMehSfgv877/4onzyfUwSpTnG1DKYeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707837363; c=relaxed/simple;
	bh=twtJCZWFiKiXNgl+7X9Fe0XX/0t65vKiXUd4qKzTf+w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AgzrEA5O2BQSUUZFKNh6Jy/euSuf6wuqwgKgt8qbppHHt9aqRpeoBcXpEVG/9tQoG60OZm7EA1XN9NRqgsCdpu7zGIA+FjEzCjGKh8wyl9yknDU0Jsvb7oW2bgZFqtQCJkfOYpTsgjl3D7qp5qwqPdUqFd1+cOAx2LOd7MqmVQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iNTL7Dok; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T1BW/yoJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DEEGAA012628;
	Tue, 13 Feb 2024 15:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=GTA4ElRV+cDFpnW3qcRGNA3lxSEilCcsvP5sqDOdwYI=;
 b=iNTL7Dok7EP3Hc0OfF2CNTgV7TFx9oXSUrOd8J61JUverqg/AlvVlZMcYNGCSqwok5u0
 DRmZKCXf8afcCH0Mh7x9xwPeqVxHuiPq8Bo/z7iFhn4uEIwm28FOmrPZ4us/POj5xkPe
 ILZpyuz1ubbi9PCxN9X/uCbJ1z36s91bmgqdy9C+jXyyNfD8P5ESRGmcSqazLOpEdxP/
 n8M7rigwexEwKS+Cg/QepBxaVfDZpme+yu2dqXG9PZxzS+y8kTA244kDg0+6ydTLvSEc
 F71kLLe99JiHGmArakDNFYa+wIg8dbz/wO8lW8LF1KsUFYhibjcLt4eVdSCf7HfjIMe2 sg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8a0q86rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 15:15:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41DE33Ih000682;
	Tue, 13 Feb 2024 15:15:54 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk7g355-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 15:15:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWkH26H0UiTfAu8vfyAJ7ylQs4riknoQILnTMuiHM/KxpPKD/N7jDuicn3JdOVvu4ZnX/6LdDPv5frDAkMi3rNSubkyqKGyMiYtPKWjfLkaLHC/yoxigjER6JyFZ5JDsePujivOPn5Qmq87xbuAVvvoh+nKhJjpQJ6W28gnbDlutiVZTLf9JFORzcEGmkCfQxbMaj2nAHVbCIenwSifg95EDECq9V3xI3d7Ir5fhy30xSiN/bBSX5gAOnodq2r1JT4EfSd4BGHH15Ueas22D0GAj7uTzaibpoOF6c0P48I5ljh5cbUo4srNU7s53TjXF/ECwInEd4bz8c1m8+K40JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTA4ElRV+cDFpnW3qcRGNA3lxSEilCcsvP5sqDOdwYI=;
 b=hpcDp7j6mTsYP8sMio/xm2w2v948S6UZ8+fAWbzexYMDhGzXs/mbQVFskQIOZYXabrBu0kcxwUNTvxoLz2jxPfZN866o3s+280mNLaz+ZLm0fW1wjEGLKvlVFTAZUM7KXitMa3SDIkQ0gk+RbuhIOl3A4+mln0VtIlkIlIcWWyxhWUiic7iZDc38c02FsaxfCogHW3J0U/17uMmCxBXkwKCnuPHQ9WllSrBt/XCNHORa/07JyFBfH2JW1sQN7OTGUQPeV6qT2t8otdmwNxdvrU+RaTGUCt4dNYqUwJqBsVYKz1E9CLESPFczEQv/zREXA+rGf5134Dz9RBj5Q+oZow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTA4ElRV+cDFpnW3qcRGNA3lxSEilCcsvP5sqDOdwYI=;
 b=T1BW/yoJQ/2RqEaHp/3A58oBFP9UYckmdMua+b1ao3aKeX4yuQPg5OXGR3pCZm0N6IHG1SeY/373aqloJ0IwCW+Vot824KXZhca4Ji5QSv4SZwo/ovM9ZZ0ynnQWJezrXo2/Nn+1ZtuGvEqq+h85emCC0CPDtf46hsoC6Rd5nv8=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by IA0PR10MB6841.namprd10.prod.outlook.com (2603:10b6:208:437::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Tue, 13 Feb
 2024 15:15:51 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.022; Tue, 13 Feb 2024
 15:15:49 +0000
Message-ID: <27cbed30-64e2-4843-a32b-0c0a5b1643a2@oracle.com>
Date: Tue, 13 Feb 2024 10:15:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] vdpa_sim: reset must not run
Content-Language: en-US
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <1707517807-137331-1-git-send-email-steven.sistare@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1707517807-137331-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::21) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|IA0PR10MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3bbcc7-15db-4296-2150-08dc2ca6a8f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FoZhgCCVAWdf0suJYAjEnypD2XCgOsD4T9Udxgtvsj4R8xLCVRNK9+QzYkyFJG8KUZHdKdhWElO96JnyWHYDgrFAORSHHfGZOMwmOQz+Y9VYkdkL5d+sBEnZ61iYhvwd+8C3Jiojq5CXfpAXReS0b71cn2lVwnt2HI/DfzlqJY1rvyq+Tf4cVXDtTw3+4KYWIDxHjsSR4lwI1qMBFGuIlq1GbSf/6DKGzxmecGKk5/A+18acuD1ZYXzv1eFM35N3+yRAl9J/mmed+ts0XcfnF160T0TWJD9O/kRPJ0Gi4/9vV+QgX4w/TaaFQU5ilfWESHFY3tL9fPpfeif+3EpHgo63OTKRWN8n/g+0y9oQR7GLrOv39S8KQyNneDDKQvqVjrcYEMrLjyM2Os8Hc1Aic16KxZIEuqCEo+H6wm4Oc8JAHyIlaWcB/a0iibfHrGgm5NUhpgu8JUJRstENZPgFdNkePBNgZfXDW/HcS4QI18v1b2iSLYBjp2aWsRkJZQLIwx2Phe7zJkvcHYy6cmSdZwB1TvKNc9SF4O2OBkP/FewGibo1ThCt+I9fGfztEZK+
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(5660300002)(66476007)(44832011)(8676002)(66556008)(66946007)(8936002)(2906002)(4326008)(66574015)(86362001)(36756003)(38100700002)(478600001)(316002)(83380400001)(6666004)(6486002)(6506007)(6512007)(36916002)(54906003)(53546011)(2616005)(26005)(41300700001)(31696002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WXZxOUpnUktZbDZReGZUczBOS1hIbmZWbk0yZXpYR3llcU1JRGcvRVdhSlNi?=
 =?utf-8?B?dUdvSnhsR3J6RTdPU2N3bmpxT2NaWisxOW9uN2tGRGJLQlBkSXY5N1dqNTJU?=
 =?utf-8?B?MHpKdUMxNEcvU1gxS2ZNQTF4ZzVsRk9JN3ZoSGV2TVA0QjdSRk5VMTdxeTEw?=
 =?utf-8?B?ZGlneGM1ZGN1RWVHUXMyMDA4elVIVE9kdDQxQWdlTzV1MG14blptNWlyUG1W?=
 =?utf-8?B?TG1kK2REOXVDNGlXL3hra0l2YzVyeGN0Qm4vNXNoNFRQbWtDQ3hjSGRJcE9Y?=
 =?utf-8?B?L2pNS3ptRUUyNjk1ZlcrdmllWGhpREQ2MzBEUldhL3VnQXo5MkIwdy9NcmRh?=
 =?utf-8?B?NnpMdjZPUlVtY0gvK2NXcGF6UHkwOS84Rk5sQ0JoZ1U4QVFIUnk3MnIzaEo3?=
 =?utf-8?B?SERFZnVtbHErdk9sRThEemlpQWVxbjcralpFY0Z1WjdTWFNIL0lYK2VMSDZE?=
 =?utf-8?B?TFhqRlBuZEFLbmVJbmsrMVdtREhXMGVvMmtDUHZ2SzRvcnhvcXloMWRBakg0?=
 =?utf-8?B?N2FmNkxxbkxjbURmRmxlek9iTjJuY0tHNkhxK1ZYdzZRMzZ2V2tINnVOeExX?=
 =?utf-8?B?YW1DK29UNlZhQ2lmSHovNlNVRW5RS21PYmQ4bkdzTW94SVFaSDJRcDArdkw1?=
 =?utf-8?B?WTg4M0xtdGtvUXVjTHh3RkVBcHdIakJld0s4Ry9ad2pQZXppTFJ6NGhCZStq?=
 =?utf-8?B?bFAvWGFud3lGVUFNMjVZNWFTVzBHVFZ0SHZxZm5kVnpLaWoyV3lGWmp3cUsx?=
 =?utf-8?B?UHRaSDVralRGQ1FiU0c5QnViWXJmT0xiMXRsTkhYcitMRW45UU9XeUs4SlJ2?=
 =?utf-8?B?emRCZ0ViTVgrb3JCNFBwOEF0UmlEZ3RqbWFpaHBjWGovRGY1NVlTOFNpRjYz?=
 =?utf-8?B?cElHdnpYNUc0VjBiTGRaazlGRGsyNDBZZ1A2K1p6eHFBd0toMXBMSTl4UkpF?=
 =?utf-8?B?Nm52amRKaHhMMUxyLzlWM2FEb2NxNFI3Ry8vTGdzeEMvRTllM28wQmluL3Fa?=
 =?utf-8?B?bTV0VGhQMFJneW0ydHo0NkxRcS9BSm1leHNQQk4wNzNIL205di9wRVlEM1Zp?=
 =?utf-8?B?c3NXcjBrdVVUNHc1c2NXQ0JObjQzRkZOTXVBTUFwMnNCemFaL3VRc1BCY05s?=
 =?utf-8?B?L2RiTG9FUS9pdDdYLzhQOUJ1TXhkYlIvLzRUZ2NQWFBqTUFxUGJJVk9DZmU5?=
 =?utf-8?B?MzBITlNldFpscEFzTlhlOTJJS0l0ZnkrNTZEaHowaUNtMU9JUnA1KzVmazNC?=
 =?utf-8?B?eXNKSGIySXQ2M1orSDZrN3dzbEFoa0pKWW5BeUR6ak5jN1QybmxNc0VBT1Iv?=
 =?utf-8?B?Y0JnVlpoUWhzSmtNa3hzc21MZHB4eExKaWtVSWJWdXhGUk5kQ0R2ek1Kb2RF?=
 =?utf-8?B?ZklTemRtRVV1NmZ1eVlXMHBOcVlNTWt6cDRNUkxUQ1FGZ1dSNFlRQXFpZGRK?=
 =?utf-8?B?UE1sWlRacjVmRjZLOTk0MnBpSXpYdnFHVG1qM2lGQ21OMGJOaWlUOHRmcFpr?=
 =?utf-8?B?UXBMRDRXcGtHdXZTS2hpVlNQb3h3dTZuYkxOZ2EzMEpCeVQ4aGhYMjd0RWZi?=
 =?utf-8?B?L0hmMldLdHhMVWtNNGZYVWJubkVuT2s3UHZocFN5YSt0dDJkcVErNktzYzJm?=
 =?utf-8?B?WlN6NG8wVjhMYXNHQ2hjOE9RMk04N0RYSjVBVDB4bE1YWER5YTF2eXA4KzhJ?=
 =?utf-8?B?ZHlhMUtsODkwVE9rRTNEQ1VkbWpFZGMrR3FudGxaNFZNd1gyUlAzdnZGNkt6?=
 =?utf-8?B?NC9IREZkWTVPdCt1TUhqTFRMOHFxOUxOMnI4MU1GUkhYOHNuRVNSS1VscFVT?=
 =?utf-8?B?U1BkL1NMOFRJelZRbUpVZHVNc2dVRlVRREc1NVFKR3ZabkhpdDladmFJS2FQ?=
 =?utf-8?B?UUVWOWRIMEJwajhnbnhFdHVubGxBV1BGcVhIUnl2Yk5iakpCK1JFR0JyZnFQ?=
 =?utf-8?B?OS8yVG0vWDAvL2J3OGZ6elh4NXpGamJwMXNEcSsyZWZ3UjYwSDJBVlZ0dnI5?=
 =?utf-8?B?NGdEQWl0cFUzMU5RVXpGcU56NUo5U2dTMEFRL3JNazFIMEhXbi9aSW5MaktW?=
 =?utf-8?B?dGxLT0dyNGh5WEdHRTZuazVsZjlDZ0FEVG16LzQvVU03cy9oMkxGcGphL3FO?=
 =?utf-8?B?cEt6RDlOUjFyZGk4OWNHdjVHKytBaFlhamhhV05OdUEwcHJpVThGd0JCMjNH?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MCZlMDhg0I291ej0d7jhpivFHfuGg/PzRV9z5tKKzqwZSLZ6xzdGDj9JKIStI7UGLRd9NqB7mriPprt+sLohM99Jd1M5AxJ8/Aia/pkjFSzEIeXnjzNUkgvdkyCG5cN3oWO+Xk1hrMZeGXSx3gB+MX7MRz6a5T8EoFaT1/HYRqJ7H3ENE58u8rgdI4SlDFh8qwfG9PW/0Qxf6N3WECzzHv3W1i1ZWr0ZWeHEpEMJxLel5rpWlDDSfZZnlSyXFbRVun+EKkjeErD/x/D+5YLTYiTzdRS8+QvRaS2lU7zCRCNkGeDG2lr+3BcobpXmS0MA4nhzSS3VTitK33DqQWU1veOSctI65uQHR9YU9zQUKgPQO9/lcTGjEKSDsChznDqkfrMP6g24kxqclXYykOhdtZPh6ZtLhUSjys5UNmv5NrJC4Ht+aDjWeDC47MRZ2H1J+3EsknpiGNFkQqao2i2s/GdhjJi++E8HzgdNx8SmljNFyHUz5CflT64NqcLsgIALlP8FfmbaGFWwH9eocy2cVHSgVnn3dKEIFivRcAlSCRVWNE6a69jW3YdM5h6E5u5QgqfYIfqfjiw2dY7vO4toDuSMaXB9wMN+c6Kv7MkZjRo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3bbcc7-15db-4296-2150-08dc2ca6a8f8
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 15:15:49.1753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VerTxJm5igc2rTN3fcNDxvcucuyloE9wIUloRhKc9BOel5M1ASheFQR6rA+ghh7dLsz6Y711UmfJdWwyAGntZ8FAdKrjeibScCqpIs3FYpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6841
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_08,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130119
X-Proofpoint-GUID: Lv-UpHciKDNbGwWWIKp3ZPOP1pQ1lpJ9
X-Proofpoint-ORIG-GUID: Lv-UpHciKDNbGwWWIKp3ZPOP1pQ1lpJ9

Changes in V2:
  - test DRIVER_OK instead of FEATURES_OK
  - post singly, and add RB and acks

- Steve

On 2/9/2024 5:30 PM, Steve Sistare wrote:
> vdpasim_do_reset sets running to true, which is wrong, as it allows
> vdpasim_kick_vq to post work requests before the device has been
> configured.  To fix, do not set running until VIRTIO_CONFIG_S_DRIVER_OK
> is set.
> 
> Fixes: 0c89e2a3a9d0 ("vdpa_sim: Implement suspend vdpa op")
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index be2925d0d283..18584ce70bf0 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -160,7 +160,7 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim, u32 flags)
>  		}
>  	}
>  
> -	vdpasim->running = true;
> +	vdpasim->running = false;
>  	spin_unlock(&vdpasim->iommu_lock);
>  
>  	vdpasim->features = 0;
> @@ -483,6 +483,7 @@ static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
>  
>  	mutex_lock(&vdpasim->mutex);
>  	vdpasim->status = status;
> +	vdpasim->running = (status & VIRTIO_CONFIG_S_DRIVER_OK) != 0;
>  	mutex_unlock(&vdpasim->mutex);
>  }
>  

