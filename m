Return-Path: <linux-kernel+bounces-34219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5F68375C0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39F128B3F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86199482F6;
	Mon, 22 Jan 2024 22:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tua+n0Sy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EeGbZsXR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710BD482E2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705960853; cv=fail; b=eF82Zn76sl3Z0knugFJs9g+UjDG3QtYqegWp2UpWkyRI7Bx+XpW3d48pfPJX7/NXNWOSqs/VKOOAp7HKYiSkQPsXITAR/YwCd+UWIbQZ+t3s1R79hHJhwqMK+TYBtllx9DCN/p0fOWtMpysjeECloXUJVRWJsYbPtT1idorUlYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705960853; c=relaxed/simple;
	bh=6dQhcmAX5ZkdTMSorJcYPFUdqiWI4/q6yq7r7JBFDjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pw5PILLCMw/8eHEP5IGBNUYkLtyNJ4cI0aMnhAfeeutyrdh/4xs3KfTJU4kvRu4j9gyhShSqk/ij/Jy/pzDpZfqS8pCGKSd61W1caREFDersxfxGwcoTWAl9GVJuK5zD+QdEbaf6hkuo57oXWXSOa0j2Y6uLxHLUEdVHoK9zEEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tua+n0Sy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EeGbZsXR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40MK46Pa027461;
	Mon, 22 Jan 2024 22:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=3TM/olKv79oTRq3E7AYz1EXTv6ahEa7tHYSEE4M1VNU=;
 b=Tua+n0SyAhXFZ6kQotv51HvVUXyzMXc8n+2Va0FHRMj7XGCKAyXsMSv3ZMwCbKtRx8oE
 DVrbbbm+F3rTrKm6aERH8pr39Lc0Qkfpuf/LwNJsGfAYzq6n7DJNe1fKw1t/tlxi2o/x
 7xDPJXVfFqc5x9QyVxrTCqTSD6DxfKJ2xSLKpaFRSfI09RzySt/s/3DaolAxUDSjtgHr
 jHs97dTatX6+U5dry/lBCoJqOJRKVgjXUdcoZcFh57cZBTaImulVBpfBis4IK+pLE0xO
 /JNp7WL+zP+2e/M8p2F1IAa6T8P57wDih8GdGV1bSPvTbnpWdAGSneRqsrM9p7GlGGvp Sw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79ncv1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 22:00:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40MLGawe033625;
	Mon, 22 Jan 2024 22:00:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs370bqph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 22:00:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+FK0+iR3eSGeQYsgbcHebXIApFfRd/VmUNYGqVFnsC88nN/2uSwZFLBhjfjwW0lXYkEnhOlBx44+cmGNrgT+Xy7tcmPi2TosLzQIxtB1V3VO6o5sDFiQ5P9jaNAUnflyy3DHGDiJm5uD/OxSaPaaNGvZtnltVIfwJF12DlN4PDWBd7GIhL0LfAfMjxnJ12xmzBN6xulkQ9KhZDp6EwO5IZfd/5cls12TdNiIkFLZHNSUB4PWLBbV6UekREyRK0eydD0l61nCa/D2z9RMqBM7jvWexADwXkyMF9QCCWARlvg7ZYEaPBf09bLqfe8DKdxXNjBhn09EDYxJVW45IqHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TM/olKv79oTRq3E7AYz1EXTv6ahEa7tHYSEE4M1VNU=;
 b=U0XoGWSKMBA4xuEycRHclmRxxiWrCF6Gh0FOrCXiOTMcWYAkhJpA8LA6BKC5FAYEmZgfDF70aWB58wdhIlRvoi8JKibt0lPwqfwlXqf3Kn4iLWcJcq/rnkmlBzp0qEL7EbBoBHPRa28X9ITV37Wu46D2tgubQBQqapV4al5lI2CNUU5QR41i9w12jg/Hyot3gr3C3M45kMXAgR49GzzRykKHGbD2cssvUswVbL+mjfYsnBcZL7VWNigOHn1gAVOs0yu4DZZvDCW9dcGHPzEysJgqmaOU6ueZMrEK7zHBjw8wYoewuIlDWkyKlM3L1O7AzFepB1Usu9xnpeqGioS6+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TM/olKv79oTRq3E7AYz1EXTv6ahEa7tHYSEE4M1VNU=;
 b=EeGbZsXRGA66vYMP6twSkZPFK+eFPdTXCv1/jeNomunBk5YsO/4MLU+dy/P/++WmDvy9zOrk36LvEAF2Vw7Q2uyLK2sE9eadvh6EddCcbahBIE19XB/7iGxKa2m3YEBNO/ZMPCYLpGrCZdwqg4laG9C/DLr6QvSJZUI5RXkWrZg=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB4621.namprd10.prod.outlook.com (2603:10b6:a03:2d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 22:00:33 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 22:00:33 +0000
Date: Mon, 22 Jan 2024 17:00:31 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: introduce vma_range_init()
Message-ID: <20240122220031.pwiravglee7o7k34@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240111021526.3461825-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111021526.3461825-1-yajun.deng@linux.dev>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0185.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::29) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB4621:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e2f985e-953d-4498-332c-08dc1b958e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hK/stZksTtq8mp3QoHapJNYoJoCca8+RG1TBGvT/aIlhMkjli5sA2C5e+StzJWW4TRRkkdKAit1ztAv47daLDj5NLJEENwiddUgEENEH+sBOLFq3OnO3cK4AfSko//TNrFwskPN/CcI0g4U40JqF/UA2rsFmbt9ed7ewdvhzKvBfFD1jbqUORkIP7ujj5NCp/qRVbVR84AONQ/AfQmkN/4hQEudoBA9FWy1nK3N/lGbhVkShvAxQPY5xDeFpjTGLtS8SUoGT2QS6+vcBiexRlwnHA4ZYFSFD8WfIzzKFOZndsY+oIK3w5OAgS2TCIiSvcmqj3QdMl9bT5DFjgc7Xexnh88horhOT85kGmtoDnOpKo6419J8+pRLhM4Q6SwcK4SEMYu+Mf+9h0h7Oh06iJfVwpWLRt48afLKc5UmHLavgHAiAKqnKF6lOMe7ynQHkytlezBWDOm3PTzbmTrm06LZRlqx2bWUaTm+cLBgyKqDWbtRrDB4ZNzW/mIQasFQnUBQ/9PTeEKPdwDfWvuddsLn7ibi4kKnStwQa6aNLoFyrs4ujS2wj+rVLhnQbWcic
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(376002)(366004)(136003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(38100700002)(5660300002)(26005)(1076003)(4326008)(8676002)(8936002)(33716001)(41300700001)(2906002)(478600001)(6486002)(9686003)(6506007)(66556008)(66476007)(6916009)(6512007)(316002)(66946007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?f3CF1ki/G8DnVtEAit4k8Pr889L6zIOsJDbALhUcQLLYxB1A6Xxtx9jwpD/n?=
 =?us-ascii?Q?xUEi43JHoYpkPHwegCm5ElS1cZIWT+293YjdulG3raGDabpICevcCW6ufwwt?=
 =?us-ascii?Q?UGXaptZeubPdr8pCXGyVyEiTefBOrlOXLHDY7mxf9mvWfUwbmusUkaZOGdm+?=
 =?us-ascii?Q?35tAC8ksIMroHn94inFm5yNp6cEb0NQQz8N4P44h4VZJQsIcTfZ074LjbiQR?=
 =?us-ascii?Q?Pvt3i+PCQTe70ypDEiy6ot4mdw3HkCbcThhpe6pKdb36XkWKNMtifJuXvCKq?=
 =?us-ascii?Q?ZW9mmbB6zvRI25J7uih667k0KQsv/1qaWoSaPhZLkc+JqCsCkJSgpAqd4QJo?=
 =?us-ascii?Q?HI6RySNHOSHyd9dQUha1BywGC036wwH2cDc+jEsbZMdCeR1WJ4+I0vL5kXVX?=
 =?us-ascii?Q?mfQC7t5INXqVIWzqpNvbyTeQ5bSciJAKMImN/0KzC/UWk7EVjb4I18IqkU34?=
 =?us-ascii?Q?5eSJCBVR6m6Bpzrfm9M1zFBNz59dhJu+IG5O6nktVPYKDyto8VR/914RYI4B?=
 =?us-ascii?Q?jVqGvxbiHdh6PgO/FSlqgCycO5Mu7DMdXTjxdf3zlDv8+qbzj091A4fI9PDE?=
 =?us-ascii?Q?fV8hpTz0P/9XyWQwInDXVyQ8cRc8AcGl3Uv1hrdxG6W4pypYgQMymokzmf8E?=
 =?us-ascii?Q?CoLpsxNw0ijeBQ9cwWP76S0BFZaCgrz7gMEGujopJ5XjBBE+Qd3TatbtvHCi?=
 =?us-ascii?Q?Nx9akiCahOpMA6yQU9olLILYHjuFkXBtPPvFwwRLuOmVD03V8eGkN3D19EgA?=
 =?us-ascii?Q?8hZ/K9AK+V6/9RctpqUG/p1P+6SWHSWCWoxzxnXxUA4C5mXWuhPwLkalJBii?=
 =?us-ascii?Q?3xncgiip1eR0NwK0S0mFCsSaLS7ayWESIHCyFuVg9IpFMi0oW1sUdBu/7Vse?=
 =?us-ascii?Q?Pk0pHxKfbyJuxJ+/POs8ya0NjEKnPuivw1Je6QSuzxT0KghHlqYnOrNEZsQw?=
 =?us-ascii?Q?+ANC7iimGRS9lJY9iUesupOFfj+l4I/uq2Ou3GoF2VHFbEuhMToGihc55xtQ?=
 =?us-ascii?Q?2x8mERHxI0VkXWAqbP+K2lCunL5PYK5qcrj6DsNEzSsU1nK6UIoH4NJazUrW?=
 =?us-ascii?Q?rNx57ZyLkDhXj9XfUMZ+0SVnDsxGtHKgz6eDbCHbBNeLOVibf7Fa/YCH3beT?=
 =?us-ascii?Q?FfOhCM31DV1b7TRksPGq+Ge8IqwU1/DwrtcftOsapuzhMXk90ZDbjk4nW81/?=
 =?us-ascii?Q?P7geaOC3VBxW8Bokj3qy0BeVz1qgtiA0FV/80dsLqa+wPvZ2ckg1iFGeGSu+?=
 =?us-ascii?Q?Xu73U49JLiz/5Cvel/sPV+ZJDw2AC8y6sYan94FG4c5MqBV/YbwFAwzu1FZm?=
 =?us-ascii?Q?t1DMYf5k6tbN4OyfrUwOueym24BVEoXSUSEjo7VpLtfNsu9untLZp7YvgZim?=
 =?us-ascii?Q?X3TlpfCfsq9wtNkeiJVESct9qIOUjks9Kht6WzhSdv92IIqFmSgGMVr59NUM?=
 =?us-ascii?Q?uxDFc/90HrftxKU+tFoRIlFFDgqwI2HChf4wSpSdjduvgTmhaxzdcMVyN8my?=
 =?us-ascii?Q?r15YxuHD2p8htxrOpTQhCjO+dz91vP65ZMm/gN1UP6SfQY/g/Y1WaiQIA5ej?=
 =?us-ascii?Q?cnNETeST3fHCCTBH2kPoJpgd+0Cm9yDp3XmBmjKu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Mx1tQTFh2qyas7fa5/TIaZ+HIy4tva3gkK4ULf600PqmUs/v8UpMPsONSk3cuKt6Xi5Pt9znKV4MUJWNbcALIIrFD1l4rYjxMXO5O9Dz7vMhGY0FB4fH7vZakPR3NGfDpGowERIasviVVRTCUFPSma8PG5417AbqVaOeqnnMs2S+IWR64N3H6JCkVQ6leWPybEE5laM5SuDuYUeYX/Bw4naTdTkeDTNkiaZ+ISPyAPNEWoulEY2jKhkFlcFEM86DTvmhhIEZRv5YqejbnyUn9qAf5XvSvEo9f/mjHJ+eAuv7D64DKqJWCj9Zy4no6avzLXCzqdMDhTl7K7zl3Ul0r6+6OVwsa9UANS/ONSt2/BtXn5j6zyggg7X0e6vqztnDdrlsZGD6P6uAmNfj5DLMR7kAvF1rAPYXU59qWQB0mACDT+Q6AtDwX4sHrusNl/cKTBo1IhSS1B2rsYQt+vGpP/eIFQoh42uT7bVcR5rfAWk31PlZoVouYZU9uHQ1ftinGvjdbNi8sJd5i6zu6IQcKKU9c1eCvxrLCPKHH6xxoJXCICuQTDYn6wtzNlM1j++S/MKcaI4VDf7JPPlFsex4ACzSy+cfrk14y6N0qSyh9YM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2f985e-953d-4498-332c-08dc1b958e38
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 22:00:33.1334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTpeubjwLbUIzHr3qJpQa5p0U2NViWUNYDPCPbbhhnPoAPZ7PV53tNyf9RWO3Q50L0ZF16AzSmPu0bDJlS9lwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4621
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_09,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220155
X-Proofpoint-GUID: s7enfeW9Li-M2dUXywEk2QKt9vgM80ci
X-Proofpoint-ORIG-GUID: s7enfeW9Li-M2dUXywEk2QKt9vgM80ci

* Yajun Deng <yajun.deng@linux.dev> [240110 21:15]:
> There is a lot of code needs to set the range of vma, introduce
> vma_range_init() to initialize the range of vma.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  include/linux/mm.h |  9 +++++++++
>  mm/mmap.c          | 29 +++++++----------------------
>  2 files changed, 16 insertions(+), 22 deletions(-)

This isn't a whole lot of code, are there others?  We're losing code
clarity in favour of saving 6 lines?

> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f5a97dec5169..abb4534be3cc 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3516,6 +3516,15 @@ static inline bool range_in_vma(struct vm_area_struct *vma,
>  	return (vma && vma->vm_start <= start && end <= vma->vm_end);
>  }
>  
> +static inline void vma_range_init(struct vm_area_struct *vma,

Any reason this can't be in mm/internal.h ?

vma_range_set(), vma_set_range(), or just vma_range() might be a better
name?  My thinking is that some of these are actually modifying the vma
and not just initializing it, right?

> +				  unsigned long start, unsigned long end,
> +				  pgoff_t pgoff)
> +{
> +	vma->vm_start = start;
> +	vma->vm_end = end;
> +	vma->vm_pgoff = pgoff;
> +}
> +
>  #ifdef CONFIG_MMU
>  pgprot_t vm_get_page_prot(unsigned long vm_flags);
>  void vma_set_page_prot(struct vm_area_struct *vma);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 06f1f3e88598..0d3f4612d001 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -663,9 +663,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  
>  	vma_prepare(&vp);
>  	vma_adjust_trans_huge(vma, start, end, 0);
> -	vma->vm_start = start;
> -	vma->vm_end = end;
> -	vma->vm_pgoff = pgoff;
> +	vma_range_init(vma, start, end, pgoff);
>  	vma_iter_store(vmi, vma);
>  
>  	vma_complete(&vp, vmi, vma->vm_mm);
> @@ -708,9 +706,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	vma_adjust_trans_huge(vma, start, end, 0);
>  
>  	vma_iter_clear(vmi);
> -	vma->vm_start = start;
> -	vma->vm_end = end;
> -	vma->vm_pgoff = pgoff;
> +	vma_range_init(vma, start, end, pgoff);
>  	vma_complete(&vp, vmi, vma->vm_mm);
>  	return 0;
>  }
> @@ -1015,10 +1011,7 @@ static struct vm_area_struct
>  
>  	vma_prepare(&vp);
>  	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_start);
> -
> -	vma->vm_start = vma_start;
> -	vma->vm_end = vma_end;
> -	vma->vm_pgoff = vma_pgoff;
> +	vma_range_init(vma, vma_start, vma_end, vma_pgoff);
>  
>  	if (vma_expanded)
>  		vma_iter_store(vmi, vma);
> @@ -2811,11 +2804,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	}
>  
>  	vma_iter_config(&vmi, addr, end);
> -	vma->vm_start = addr;
> -	vma->vm_end = end;
> +	vma_range_init(vma, addr, end, pgoff);
>  	vm_flags_init(vma, vm_flags);
>  	vma->vm_page_prot = vm_get_page_prot(vm_flags);
> -	vma->vm_pgoff = pgoff;
>  
>  	if (file) {
>  		vma->vm_file = get_file(file);
> @@ -3165,9 +3156,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		goto unacct_fail;
>  
>  	vma_set_anonymous(vma);
> -	vma->vm_start = addr;
> -	vma->vm_end = addr + len;
> -	vma->vm_pgoff = addr >> PAGE_SHIFT;
> +	vma_range_init(vma, addr, addr + len, addr >> PAGE_SHIFT);
>  	vm_flags_init(vma, flags);
>  	vma->vm_page_prot = vm_get_page_prot(flags);
>  	vma_start_write(vma);
> @@ -3404,9 +3393,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>  		new_vma = vm_area_dup(vma);
>  		if (!new_vma)
>  			goto out;
> -		new_vma->vm_start = addr;
> -		new_vma->vm_end = addr + len;
> -		new_vma->vm_pgoff = pgoff;
> +		vma_range_init(new_vma, addr, addr + len, pgoff);
>  		if (vma_dup_policy(vma, new_vma))
>  			goto out_free_vma;
>  		if (anon_vma_clone(new_vma, vma))
> @@ -3574,9 +3561,7 @@ static struct vm_area_struct *__install_special_mapping(
>  	if (unlikely(vma == NULL))
>  		return ERR_PTR(-ENOMEM);
>  
> -	vma->vm_start = addr;
> -	vma->vm_end = addr + len;
> -
> +	vma_range_init(vma, addr, addr + len, 0);
>  	vm_flags_init(vma, (vm_flags | mm->def_flags |
>  		      VM_DONTEXPAND | VM_SOFTDIRTY) & ~VM_LOCKED_MASK);
>  	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
> -- 
> 2.25.1
> 
> 

