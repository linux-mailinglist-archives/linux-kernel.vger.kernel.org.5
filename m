Return-Path: <linux-kernel+bounces-34618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6C083844D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E584B20EB6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B167E66B2D;
	Tue, 23 Jan 2024 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V+zW5wvT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E++0oFII"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BCB4F212
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975226; cv=fail; b=RRJRAcGu8t1m2fHF9MWqovfCVsVemouHL0sIzwZ6HUCROLnMkZDq/mXrvkdGoF+tbFLZY0pKEg8dZi5CpCoeSPFKRwSXntz1QOnLXYoPwvQ5Ha5n1f1p8CnrK3NFI4BcBmGozi3gTSMdij2P7YLCuaCZ5g17Q09nDzbXAGXihJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975226; c=relaxed/simple;
	bh=RkxpV7U/7zkBXJ6tz/5AcG8jb4nMux8AZdU4OA8QWDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sdh+V2Y7zxeo83d8l1kuJjZKce/gZrWmw8FOPd5ESmP8TNqRw890KGdS/R8xidawkLgUGiKmLCFVxEhA4nKqY0pKScLXXqzgEqpVVdfkpPdKUlBjVQuo73uoYdRE0Z+EJtvPuUlUbdlcpIfZntTu/ocOFILxlLTOHcykJ+7yx4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V+zW5wvT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E++0oFII; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40N18mMx024845;
	Tue, 23 Jan 2024 02:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=RkxpV7U/7zkBXJ6tz/5AcG8jb4nMux8AZdU4OA8QWDI=;
 b=V+zW5wvTHvoKfK+ZA90XiHDgL6Ugr9gioPvo1HsqOFNSvGm/WAvub39evyFwx2dPxaE5
 0ZgdLQcysLwHlfAN1sCKn7RJscI+km323tE5nwPe1oF2IPi4aKoNZSj589UaUi2qHuN2
 /EGTYhMMhYo8zmJIRQd27Q+Qta8FEpk0Rz5W3wF4KfK2XlrjheITQcngzoOk5NdPZMF6
 PhKXamoSiSEz/1VpOWhcs29IaBDsLh/GN2ZQtRHAfUwcU+H+kn/8lhGBj/FCWszP43GP
 S6awm1BibNg26qQ+Tml5KXr5QLZj8UsuzdWdh4gYxJk0R+76GYgVCzJzNh33OyRltAh7 PA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cxw0pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 02:00:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40N10wVU016230;
	Tue, 23 Jan 2024 02:00:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32q3ae0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 02:00:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIE7z4unFcUm4txCaqTuxvo7WLcnwiylqORjHXfVpk3EKQxZLSS+aJAYrYaW69gkJjzSP7QOA37UuG7xGGa/Rp1FgqGtpIJOjj1T0K5Rc0ahBgMP98SgJo7vQ7+qhXB5/z3reQ1U3BuVAHMSDum5g+QwYV70exaamNDOnJ/5czMimS+7xrgpRfNMxKtM17vRHJ+4k9SO2Fm8LRhnjCwpqqN0eBlrQkZJ+eUNTRkIA8b1UJ3s/ofvg3yjBQNeqhuUCutidJbI71KOJwoQRlALWyPSFZ43k5dge+8ZkQb/QsaR/SHlbX/P64AU3DHoAkM4TaResEOoY9Dn3Oc0C9i6kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkxpV7U/7zkBXJ6tz/5AcG8jb4nMux8AZdU4OA8QWDI=;
 b=m/opAu+KTMR+WM1N19q0TA24ZV+KHaSZhWAJGjJmyUKZYQaQ3JQ2s9UDsVB92lJib3BZTfDNgZ7xM6NKz67vv78v82MQrN7Y6/9dXd3FR6umE9ouAMyqyNU+qa1k5GBF9V0pRMK8QUej4slJZQMA3tAPejIGVqHXhY3FeheGXU5D2arIrvVNl6QwRNo5jxMkDr7eRHjBx5OJyDjUfiRTo1T8c71QickSOcHjOF3JqlF5t5R5KZHoG55bqIIeuz/RURjeiz6GpawOBjLVO2E+s0hWGCx0/HpeNXwwPYslZ/PAicCW3/6b1uVnOgh0JflhRh0bHovxINPCEiHM9tSi1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkxpV7U/7zkBXJ6tz/5AcG8jb4nMux8AZdU4OA8QWDI=;
 b=E++0oFIIaZeA0g18mn45art7n4HOJ0UOl7P4q1tckpbPkslSmz4so/mMl+4XpoEYgcjFGyl7R+QNx5/5z3rOVrn6OCKph9buSn0FggCOvPYgSroer5cE8aPA4SzsEDKdBBAQnwfhe7nJ/EoguRyhfjC6RKcIdUht8fHbVGYOSOg=
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 02:00:12 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::328a:88d2:1e74:fb50]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::328a:88d2:1e74:fb50%6]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 02:00:11 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "muchun.song@linux.dev"
	<muchun.song@linux.dev>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH] Hugetlb pages should not be reserved by shmat() if
 SHM_NORESERVE
Thread-Topic: [PATCH] Hugetlb pages should not be reserved by shmat() if
 SHM_NORESERVE
Thread-Index: AQHaTLmwlElGBPi+U025BxoFJNM3mLDmphyA
Date: Tue, 23 Jan 2024 02:00:11 +0000
Message-ID: <EAA37C24-41E0-40DB-9EBB-D207C581DC8F@oracle.com>
References: <1705713472-3537-1-git-send-email-prakash.sangappa@oracle.com>
 <20240121143207.299f0d3df52ac746224dacd8@linux-foundation.org>
In-Reply-To: <20240121143207.299f0d3df52ac746224dacd8@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR10MB2629:EE_|BY5PR10MB4196:EE_
x-ms-office365-filtering-correlation-id: c2deb260-7753-4bca-fd3d-08dc1bb70865
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 adOPmQBcy3g3tjl1yGp5xG/eODBsP8h86F585Md1JjYHPpGLGMcTXBWugC3CSzV385aEcBBoTQBQzivm7NkDZmvngsIXROJGW3Ew1oSe6AYVcl+kySBQ0f880nbTy4giPZJjtmlQhehKkj3+WWMDaP5rpAuOfg7HNaI6LiPyTERgffHtNLjdaJKczb367HSyG+3J3DDleKowHwk5JLcZDq+Xi0tLDwys2mvouIkAj6s0+4f5b5vIVnR5Galvhq/nTkgfMWmZ4TXEch426aB9pInRRNTcj4BSgGmvr3ktGFccmtMOjUsuewTn8i1jezetOvo1Nv8pK97fRMjdsdFy0/Su0lQ9rxWQiVk6Zval25nLS+hTzX8FBgpcxGNADOTSi5OTg7WIZ3a/QrDFnryjHwyn8GNsHOORVQr3s4bgqsw4SW6lXlchPnnAc76fI47lyzrgolbekXMhB+EP8R4mMapThKxPwybA0J5dX4QNrNsDsnU0s2ddNgAvQGZ9NMJga+5kg67KmfdZWd1wCJlIsxKF/t4rqkyGbLLMl1O5Ymut5SAgAAhyRXfDCWPiuLQSQYNxG8LwRv7Eiqk2rzwAVOC1K/Y7MrnduhYD+BScVjs0uP5cyus+PUJ1Py33Zfzd0wM3sFnJuj17tROl4qjx8w==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(376002)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(38070700009)(478600001)(64756008)(8936002)(4326008)(44832011)(54906003)(76116006)(316002)(66946007)(86362001)(66446008)(6916009)(66556008)(6486002)(107886003)(71200400001)(2616005)(2906002)(26005)(6506007)(36756003)(8676002)(5660300002)(6512007)(53546011)(66476007)(41300700001)(33656002)(122000001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WkpGcDA5bzA0aktCZVpOckZsc1pZNENCR3lEQ3p4ZXFTbCtJRS9ocUkwZjVZ?=
 =?utf-8?B?UGtJR1pYRUxFK0R4anA5N2gybXdPQzhwK0pMNEsyc0srQTQ3emQ1TU8zenN5?=
 =?utf-8?B?NGFyUUk4K3NTelkrbmd0UUhZZjRrTWpyQlR2N2oyaFUwOFBmd1VjdHVxL0d3?=
 =?utf-8?B?Yi9GNGxFR0xwNTJIWVI5dzNPRmhwUXVIVDZHaVgxZWJjZjNRU2dXN21tTFR5?=
 =?utf-8?B?SWlsNkxrbEFTL1lxR1RaNjNZSEk3bGUrNkF0U0tvbjdaVGZLQ2dBVDBMaVE2?=
 =?utf-8?B?SlluYktNQyt3UG1ZaFRaVlBPcHc2Qi9uS0Y0aVE4VEJBRDJnRkVYRmdLMTFo?=
 =?utf-8?B?MFE5V0dsMlErRCsyTzJBM2puOFZhRy94UlNFeTNnN3N2TjFObXpjZGtCQVlI?=
 =?utf-8?B?MDFGcU9tQ1NGeGcvQUF6QXR2eTRzU1ZIZEZHcEw5djlVUDNjN1FYTEd0QmlD?=
 =?utf-8?B?WkNlOGd1U1lDRW01UlIwYkJ5YzF0L0RVYTRibEhTeFR0bllGb2V5dlJsTGww?=
 =?utf-8?B?T0xkVG9OZTd5RlNmcTNnL1hvbVhFdEhMQ3pnRXRUR1h3VElua0h2VmNQSWNU?=
 =?utf-8?B?NXZPTTUwU3hnN0x2NWtNZ3M5OVNJclU4WktJNnZkWS92MXF5T1AzSFluUEt6?=
 =?utf-8?B?SWhlVzNsdFoyeFptV3NMT3N0QncrQldTKytoMHhHRmV6djJxRDEzcEx5aWNG?=
 =?utf-8?B?ZkNBaklSUFBjOFd6N0ZmYVJSNTBDaGswVmZZeTBybFJTWTlCN3lITGF0eWtX?=
 =?utf-8?B?TEgyaXRHYTc3N3RadCtmaVBxNklJVFp3V3VDUURRTW1WRlNta3k5RWdzUGZY?=
 =?utf-8?B?cU9veWdMZFNDN3E2RHdnRFZoSnZ3TU9CSWIweGM5ZVpidHBsb1U1dHdHby9x?=
 =?utf-8?B?b1JQQUVmTHhCd25ZOUtpL2ZtaFNLOTNFa1duOW5WY3BqeWs1U1ViQ2FjRnpl?=
 =?utf-8?B?SnNwdTJNSCtIZndvRWYwUm95MDdjZHNJVnVyOXVYWlE2cy80TWYxQmN1eWd1?=
 =?utf-8?B?eG1GWDZZTVJuYmcwVXhnZWtMdnhCd1hJYkFLYTgvaWQyUUdhZDVjNnFSRXBH?=
 =?utf-8?B?UVBORWd4clB3UTd1K1l5NlBXNWtVZG5YSWI1SEZzVFVSRWpwaytCQkdVVGlP?=
 =?utf-8?B?WWFKSW9KUXd1bUpQaFArcmd6eWt5RGUrMXZ4U1lpV0UvUEpTRFV6UzBqQW10?=
 =?utf-8?B?Z0NROGVta3hOQkNBOUE0eExteHRVWEhrQi9RRXAxaExWOEhBY3dEUHM2T0RK?=
 =?utf-8?B?SE5NcWhsTmk1Si82UVRxLzhKY2RHMnVYMFdMVGJwekUwRHFnMnA5RTZ0dHBO?=
 =?utf-8?B?K0MwaU0xTWFnNVR2YWRUTHh6cjJzbTc4UlNvVDVoR1RGc3J2WUVMOWFKa3Vy?=
 =?utf-8?B?MTlzL1hJWWc4NUl5clkxbk9nZlVhdDRIdndIV1pJZEhGYWd2ZUhCRndLRVhk?=
 =?utf-8?B?dTBJLzRhYmQrM1oxZXVKN3lETUREY2hsVnZ4Y1dveUV3NW1sUnlvTHNRa3ZD?=
 =?utf-8?B?MzArNmMzcXlRdkw1Mi8zZmhNUzdQSWxSeU1Mdk9pVzJsTk1iVmdmazFVd09v?=
 =?utf-8?B?blU4YkI5NUxNT0piTW9EbHZPZTdmZ1MySE0zVlhkNFJwWFF5Z2haMDJ5QWFV?=
 =?utf-8?B?Q3RxU2l3cUI3bEQ4QnhKanJQdms1WDI5dU9XT0MyMDhMUHpKRkxBN3JSSk40?=
 =?utf-8?B?RzV6Y2psalZreVgwUkhyb0d4N05EL3c4ZjFXY1dnVXVGNkdhL2JzNWprbXc0?=
 =?utf-8?B?ZUpKM3d1WHF5OG04NGNqMHRpMXdJRFJiS2piTENZQlBSaTh3dUNMbHF2WHJ6?=
 =?utf-8?B?RFpPY2h2cUlkYUJ1ZFdSVEVNVWk2Qk52TnpjTS9jNlRNc3NqWVlJaURQQVpo?=
 =?utf-8?B?aEVtZVlaNlIzMFlOZDBBODhjMG5LckdObmFXczdUZXluakt0K1E5TW5ySS9o?=
 =?utf-8?B?b3g1dHJvNWdiWG9xNi9FNlFkdWsyaU44c1ovNVRwK2NPcUtpTzF4RmZZRUxY?=
 =?utf-8?B?Z0d3L1BQNUVrd0dIeXZmMkNpY2QzTTdUOGs0WFk5K0RyM0REamlYV0dNSGxi?=
 =?utf-8?B?VFNUSHJKZ0RSZnY4dDJkanJ3c0hveDBuWGhFajNFbmNtblpFZnhLemVqQWR1?=
 =?utf-8?B?K0hhY09TOERMaHdtV3NCSllVM24wQVFMcDBKWTZDYVBjdTljTFdzeE5BMjJM?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24BBCAC0BB1BA24281F2CA32A36ADDB7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	a158Li1lWP5Q9riOSACwX99gEcBsvwA7AzJNBUDhA9d9wO3rAUBKHQ+m6+O+R1q8eI8Q3LqtG57gIr0RvwX1/E+jBsD7A5LbYUc+48d8SowsNw84aZoTPC6ZGv7njW5qTnG4dKWmPxxUqTIqBMU7Ge1+Rk8Q4Z20OtX4Y9eL/UQLS/qGCIl1Ipmd+vG/C1efYnpAWodncIgKZR4wxxcwVxpS7AgbNjTc+WQxTWFxzw/WwxhQcR/OwzDFVhUi7APEKIdmy4CRbF93EuSyQBOW5I244inLhjpkyIyF5YuVdI3FDgwrUWvsNpEHZgA+0sKsJtoxXpe06zjbAya1qAoAwbRoUBMsFty1sbW1MWKbt8kXT60OOCeaAP7foeBQzzg0BLbQsqDe4P9NxObmLJ8+yJer/7SArqcEZkdknPf0umHKfRLgnX3H/LfiZSN8ncFifMVjI05mbep9EA1B2Bk+98frrg2wdKsRbBPYtDGIL7c18Qu/4x5AajqQyWKTYK4GNTw8HhO+Lw91wDGmBZyCkjFwLBS+HypqIBjAnnSTC+irMV9Zvj4WFUVgvosueUC9bBmf3T/PFaDcTbWmIq7n0Dh19hGWGbm2hztWDlOTzOI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2deb260-7753-4bca-fd3d-08dc1bb70865
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 02:00:11.3397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lbdjrpo1f+ltXwy2c0VrQBEDqnF2bhoKYM9lXg4+U60aCjivJMPteqfxT3+6V2AP7B6CAzSN9AhwkbwVD4qQebgCptYqx7BkxpzQfM2Xfc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=953
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230011
X-Proofpoint-ORIG-GUID: VFVm-bTL1Kb95yfucvxYCo49Wnd3fvSl
X-Proofpoint-GUID: VFVm-bTL1Kb95yfucvxYCo49Wnd3fvSl

DQoNCj4gT24gSmFuIDIxLCAyMDI0LCBhdCAyOjMy4oCvUE0sIEFuZHJldyBNb3J0b24gPGFrcG1A
bGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpLCAxOSBKYW4gMjAyNCAx
NzoxNzo1MiAtMDgwMCBQcmFrYXNoIFNhbmdhcHBhIDxwcmFrYXNoLnNhbmdhcHBhQG9yYWNsZS5j
b20+IHdyb3RlOg0KPiANCj4+IEZvciBzaGFyZWQgbWVtb3J5IG9mIHR5cGUgU0hNX0hVR0VUTEIs
IGh1Z2V0bGIgcGFnZXMgYXJlIHJlc2VydmVkIGluDQo+PiBzaG1nZXQoKSBjYWxsLiBJZiBTSE1f
Tk9SRVNFUlZFIGZsYWdzIGlzIHNwZWNpZmllZCB0aGVuIHRoZSBodWdldGxiDQo+PiBwYWdlcyBh
cmUgbm90IHJlc2VydmVkLiBIb3dldmVyIHdoZW4gdGhlIHNoYXJlZCBtZW1vcnkgaXMgYXR0YWNo
ZWQNCj4+IHdpdGggdGhlIHNobWF0KCkgY2FsbCB0aGUgaHVnZXRsYiBwYWdlcyBhcmUgZ2V0dGlu
ZyByZXNlcnZlZCBpbmNvcnJlY3RseQ0KPj4gZm9yIFNITV9IVUdFVExCIHNoYXJlZCBtZW1vcnkg
Y3JlYXRlZCB3aXRoIFNITV9OT1JFU0VSVkUuDQo+PiANCj4+IEVuc3VyZSB0aGF0IHRoZSBodWdl
dGxiIHBhZ2VzIGFyZSBubyByZXNlcnZlZCBmb3IgU0hNX0hVR0VUTEIgc2hhcmVkDQo+PiBtZW1v
cnkgaW4gdGhlIHNobWF0KCkgY2FsbC4NCj4gDQo+IFRoYW5rcy4NCg0KU2VudCBhIHYyIHBhdGNo
IHdpdGggc2xpZ2h0bHkgbW9kaWZpZWQgZml4Lg0KDQo+IA0KPiBXaGF0IGFyZSB0aGUgdXNlcnNw
YWNlLXZpc2libGUgZWZmZWN0cyBvZiB0aGlzIGNoYW5nZT8NCg0KVGhpcyBpcyBhIGJ1Zy4gRm9s
bG93aW5nIHRlc3Qgc2hvd3MgdGhlIGlzc3VlDQoNCiQgY2F0IHNobWh0Yi5jDQojaW5jbHVkZSA8
c3RkbGliLmg+DQojaW5jbHVkZSA8c3lzL21tYW4uaD4NCiNpbmNsdWRlIDxzdGRpby5oPg0KI2lu
Y2x1ZGUgPHN5cy9pcGMuaD4NCiNpbmNsdWRlIDxzeXMvc2htLmg+DQojaW5jbHVkZSA8dW5pc3Rk
Lmg+DQojaW5jbHVkZSA8ZXJybm8uaD4NCg0KI2RlZmluZSBTSE1TWiAoMTAqMTAyNCoxMDI0KQ0K
I2RlZmluZSBTS0VZIDQxMzIxMjM0DQoNCmludCBtYWluKCkNCnsNCmludCBzaG1mbGFncyA9IDA2
NjAgfCBJUENfQ1JFQVQgfCBTSE1fSFVHRVRMQiB8IFNITV9OT1JFU0VSVkU7DQppbnQgc2htaWQ7
DQoNCnNobWlkID0gc2htZ2V0KFNLRVksIFNITVNaLCBzaG1mbGFncyk7DQoNCmlmIChzaG1pZCA8
IDApDQp7ICBwcmludGYoInNobWF0OiBzaG1nZXQoKSBmYWlsZWQsICVkXG4iLCBlcnJubyk7DQpy
ZXR1cm4gMTsNCn0NCg0KcHJpbnRmKCJBZnRlciBzaG1nZXRcbiIpOw0Kc3lzdGVtKCJjYXQgL3By
b2MvbWVtaW5mbyB8IGdyZXAgLWkgaHVnZXBhZ2VzX+KAnSk7DQoNCnNobWF0KHNobWlkLCBOVUxM
LCAwKTsNCg0KcHJpbnRmKCJBZnRlciBzaG1hdFxuIik7DQpzeXN0ZW0oImNhdCAvcHJvYy9tZW1p
bmZvIHwgZ3JlcCAtaSBodWdlcGFnZXNfIik7DQoNCnNobWN0bChzaG1pZCwgSVBDX1JNSUQsIE5V
TEwpOw0KDQpyZXR1cm4gMDsNCn0NCg0KDQojIHN5c2N0bCAtdyB2bS5ucl9odWdlcGFnZXM9MjAN
CiMuL3NobWh0Yg0KQWZ0ZXIgc2htZ2V0DQpIdWdlUGFnZXNfVG90YWw6ICAgICAgMjANCkh1Z2VQ
YWdlc19GcmVlOiAgICAgICAyMA0KSHVnZVBhZ2VzX1JzdmQ6ICAgICAgICAwDQpIdWdlUGFnZXNf
U3VycDogICAgICAgIDANCkFmdGVyIHNobWF0DQpIdWdlUGFnZXNfVG90YWw6ICAgICAgMjANCkh1
Z2VQYWdlc19GcmVlOiAgICAgICAyMA0KSHVnZVBhZ2VzX1JzdmQ6ICAgICAgICA1IDwtLQ0KSHVn
ZVBhZ2VzX1N1cnA6ICAgICAgICAwDQoNCj4gDQo+IEJhc2VkIG9uIHRoYXQsIGlzIGEgLXN0YWJs
ZSBiYWNrcG9ydCBkZXNpcmFibGU/DQoNCkkgdGhpbmsgc28uIFRoZSBpc3N1ZSBpcyByZXByb2R1
Y2libGUgb24gb2xkZXIga2VybmVsIHZlcnNpb25zLiBSZXByb2R1Y2VkIG9uIHY0LjE4DQoNCj4g
DQo+IEFuZCBjYW4gd2UgcGxlYXNlIGlkZW50aWZ5IGEgc3VpdGFibGUgRml4ZXM6IHRhcmdldCBm
b3IgdGhpcz8NCg0KU2hvdWxkIGl0IGJlIG1lbnRpb25lZCBpbiB0aGUgcGF0Y2g/DQoNCi1QcmFr
YXNoDQoNCj4gDQoNCg==

