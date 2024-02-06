Return-Path: <linux-kernel+bounces-54175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D8284ABDB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7743AB22DBC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD9456B74;
	Tue,  6 Feb 2024 02:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hDa6VnC9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Yt7N1FqA"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F62756B6C;
	Tue,  6 Feb 2024 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707184853; cv=fail; b=iTWPLnVOgXCnQyxcr0rn3qdzslNX6Ril33GL9/qmZLFfVcYt9khXUKtkXU/sMTT6BrZV/D6p+1+Cuo5OCEX/pJhed7zC7TAdVq8kEcYTq+vRi/XzSz6Q7vRjD6eGNic0t4LPIwsqvsvHhT0Zs/VvEc/2I3OY+lMf82uXs8q47VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707184853; c=relaxed/simple;
	bh=gxTJ9m0TfjRNsjn6U1wUEXALe+ZPaJYndTDgylK+pJs=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=aPyYDdYivTBzgVoTMedA7WNUHi6C8MehWsSKgZ0IjElBXOhC2BVuIPBsTjJMjJl0yhPjN5+0ZIlseMUuNFDUyJLiIhLBNOd23JJjPxjyLmmrNSYH/574j/tGyv6RLjccWwcDovfMu5U4jjyqJ7nmWWXEwN6Ol1enFkEkgDnXcLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hDa6VnC9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Yt7N1FqA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4161F0WU025525;
	Tue, 6 Feb 2024 02:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=eqUo8c1f6/x+gWJ+iCVbuU+szl/jCsoWqzLeZIT+j+c=;
 b=hDa6VnC9ChLNPi3sEQvCt5eTMBs1/xnO5nwbzZhC3zFUl71ZFUU8AUsUSMrK8B8B+czB
 miljZF9KiNc247ORs6WzPS+Ca8Sv/cENclf5nAynMURKcMqlrT2RswDg0oPwf0fgJNF8
 tygGF+iaEK0Lq4AMNkGNYvHBrf6qr1+CtK/rYaVunRZskZV9IqStAJWMjOU+/W5YSH5N
 5S/FNy45cAVlYil/rRUw/IXNkb2Z4aw8FzTA3BnaXDG1WJxT+6Kq4YVDs5EqpMA0SUqw
 5u6b8eekpVFvoe8Jq4AJeSGU8SvEfKSSZysDZ6v1PmpFpIAEoEGk0hD5E4cVPgFenS1a Rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1e1v5fw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 02:00:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41610LiE007111;
	Tue, 6 Feb 2024 02:00:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx6scq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 02:00:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+GKwU2XBu0wYUd24FRWKQ64ND5BZUGv1drEPCAG6WZ0xXrl8L30Yq+Nbo/uMakaqE6psc5a0JLlxRQ0iT2rQhALJrStrfza8oFzFTomO6xW/t/PbQg8raF1OnpVWlXLO3LmXOf86R9V8Yx/rfEtPsdTMRruv6eyZxRTJzUcEmKDJPf89bd0FFFa1dpCnzwAv5TqD/yYZptQI6yhOFAYyXo6oKEvCXmGoycgEvbkDG1N55x9+6NRGguvzTXXutvnt4JMlN+u7tRAZql97uE7HfZG7wlYVfvnYC87o1JoV0ZSJQVUEnjNCSXvg9VYSx7vup698Ype1bM+W0m0kgvjtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqUo8c1f6/x+gWJ+iCVbuU+szl/jCsoWqzLeZIT+j+c=;
 b=L1HYJQfFh0C/gDsJUsSj25aEUoBFCP/t4WZSqKR40RVYqua4ve7mzj9wvgO9/m1SroO1elEXFjUNImMZWJwxBOe/MBmqujyXfBne4vSLD2pZ5OqHmvUMp+AUMTpSRIgLV4304y43wRud99+jeuGNB08wwED0cadCyDFBAUarwoIURKuqFbQBXXBUwlBvMO96jpnBG6co/x1StXC9RUUMHQjhHEi1Kq+SM/L1RwWao+I45/kxlzSfbOflkUrExu2IMG0I2EXb8wTb/ENPLZTJKwH1DTK0Z/kzTImi5Jv6+4VB0spyCO1q9cjdXBKVdTOkvnUtKmTP1kzTeTeHx9oZrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqUo8c1f6/x+gWJ+iCVbuU+szl/jCsoWqzLeZIT+j+c=;
 b=Yt7N1FqAtlZh9YPjpzwM01sTEFrZ2ofqi2gtco0tHdmz4OrE9k2p/xxr4m0RulCvdlFCGDSdcWfm4lYxfTMS3N/24UTll+WIIAW4bDX5dFwvVGMlr6leDMx3RNYv1m+gS+0ZnmAIKtgHoIOiBKAay3tCkl+FkSIJLmMOb0GkxMs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB7406.namprd10.prod.outlook.com (2603:10b6:8:158::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Tue, 6 Feb
 2024 02:00:28 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654%4]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 02:00:28 +0000
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley"
 <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Mike
 Christie <michael.christie@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        open-iscsi@googlegroups.com,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/3] drivers: scsi: struct bus_type cleanup
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ttmmnyic.fsf@ca-mkp.ca.oracle.com>
References: <20240203-bus_cleanup-scsi-v1-0-6f552fb24f71@marliere.net>
Date: Mon, 05 Feb 2024 21:00:26 -0500
In-Reply-To: <20240203-bus_cleanup-scsi-v1-0-6f552fb24f71@marliere.net>
	(Ricardo B. Marliere's message of "Sat, 03 Feb 2024 15:38:59 -0300")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::26) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB7406:EE_
X-MS-Office365-Filtering-Correlation-Id: 129cd9f3-fe2f-4617-d6a2-08dc26b7642a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xaAuUelXugV1C1Ks8ErBIgMIZ5SpaFaccCCt8rBXrAUJug52Nv4PxVG0gelkCNRxJl1mGFOwKTMoW3JqiFUxT+1xK+DqF2+jy7QzLTBcVRgjhGLdCDv/h6I/2Rqo1Wd00jC9XsAgFolCRgTqNBnCl2zJS8abAPkkaiGUWAs2ybMf+8jt9fw2FinHGpQ+UvMVi66kR0Mhd4l76ttiEkPBO8mgDVwUc6ajAjR8qqJVLM4Af6qx3tDHd6yFU8YK5c87a9qt/WEb4MFzuce+I40vr9lKFzQrfsnbd2yTVxF9vCK/ExFhurBMno1bKjzlKX/qAHtrod+k4+smb0L2BG6XWRr2wbqVmQJUnNcim5WeJuMLVWO1R+jyCYLYyP03nIl53nHbHbnh1tnX2rQbcoVA7cId3t9rGAwS4RusAZQBWkeVjl08FJ7yCfDaOxDY248THvjlDHJYVB0Kp+xYzkKYq+M6eMbYLmokU1Anv76heEZfJJ0oN3AUI8o8PidOZSWpK7Fwzz4B43GCy1UcbNcihZVX4ujd0MTkzoVVCfTlwksefphGjxyzlHne1OebnPLo
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(6486002)(66476007)(66946007)(54906003)(6916009)(36916002)(6512007)(8676002)(478600001)(66556008)(6506007)(4326008)(316002)(8936002)(38100700002)(26005)(86362001)(5660300002)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Xo1OahTRwZ0Xr3MF5ijisShdzyqKLS4hGg8kVArGmNBoIUSge9vL6O4G6wwk?=
 =?us-ascii?Q?bZEWQ1VNqQlFN1hudd+kg9dw/9ysPXOHu5HU2NEp8H38l9Wsz5PT+cR7evm7?=
 =?us-ascii?Q?b2NwA/JUlwHUpqlBzwLJua1yK929WJ93VjVVKERRbAL4HTjrumIWX/FjMQ16?=
 =?us-ascii?Q?qDTYfQtKQR4qkPbPx/XORdh+PHnYpgSx8F3IRFYHnRbbWTcFowBHnaBWOU4B?=
 =?us-ascii?Q?aTVRcHD7Yo13Wr34JjSH38MK69QcCB1neSAA+eZSWECzyjFeAPX0uVO6k5Rj?=
 =?us-ascii?Q?w4JvkYIOui2T+Rb76cMWJu+Jy31c9w4Vb9r/hjmSOeTCDPXe7t3SaUMsI9eN?=
 =?us-ascii?Q?aAJm1LG7MBNxCmif2o1DvzBV7VP1ysE3A4dxs5VlQXdmSHIaAUKiAOv/11LZ?=
 =?us-ascii?Q?+84rkUc6gHV01S/adrOpuv+mtVtVptA9v6UGKPjWASXcd/7XKnPpoo1bif9A?=
 =?us-ascii?Q?qdGjhav4vXVgjKwatHmxaSLlR9v6FJ0GR6RkgWL3zufcS3LcAMfODnXqVkFc?=
 =?us-ascii?Q?nV+bYK3vzLhDu1rs9CK9qzVjuW4+LbyFPl7DdDNes7PKZEWJSx8Co9DUYyGR?=
 =?us-ascii?Q?kPeKwJALrcUbiVcxQKPbzMG/eMh1K+6MsMUfQeC52J8h8BvRhLLry9MtueQv?=
 =?us-ascii?Q?GzuAnaCCpl2eBKlHHgR7yAM7dP3UHhLh1LGUNUk9IXW3p5Mnop/UYKjb7Mg6?=
 =?us-ascii?Q?BvJJi7vFq1TQ2+LQe27GjifjqGRrY0NH0TLTYYei1tKIF9EZ8E33SGITytKK?=
 =?us-ascii?Q?pMbJzheQDq4IPNi1vn1YxV6qSaXGIjlfeZBZfOpCl/5njoDxQHvXQs+1Aklw?=
 =?us-ascii?Q?WOD5A6vAxVZHjh3CUDjLI04zw9UeDsEuwyCPdF1xv3xKK82RE0m8vJIwzzv8?=
 =?us-ascii?Q?lJ+EuOloKT5+xilTmz4KZ9cRhSZkbc5NmtVjfwjdph3u+l/zkm7Z+GGli7UJ?=
 =?us-ascii?Q?xjDq7+CUCdDAJpvZJBdaOyM3RZTcDn58OS1eMHpI0DFSSNBEkkHkEEmFe2UA?=
 =?us-ascii?Q?6Nd82+kJ5Cj1yjSjkxbKLFe9Gi6PME7vy7U/0Lbt701ZI4uTgOO8COCXPsIR?=
 =?us-ascii?Q?6uGl3bovphlRDS6MPuS3wn9NWb7Bpp1wiNe2TKeunZCDAErZwsWHilbzxv8q?=
 =?us-ascii?Q?NbOY3uuZRAXinxAQx73xAqoJbtQHfNMVKrM2yybyjtwb7BE6OjEx5jWUrqbB?=
 =?us-ascii?Q?a9DHxGre33Z/E9OL+lbHKmumWM53MXYQqV7PEoYusmzV99VqjxShSVedqGIc?=
 =?us-ascii?Q?kfN2pOWK/I/BpkWow/yQKlSJm6k/xWVLXk44Seo7MmyqyH4VXMQzhuwRGl5W?=
 =?us-ascii?Q?XErlY3l+kdSmyyaMv31aSqjKp3Wy7aRf/fb9wlQMRiVXQNo+vAaZ0DFRUdro?=
 =?us-ascii?Q?FRuzZengd0EUzaloKH9YQiPHQfofX0hsfd81F4v4JzYGi33WODlE53563A4V?=
 =?us-ascii?Q?zQ5c0KxQZ8K4QY3yaXqNBp3KgncuBG38W0HQcIYmdBwYrCCAU4o/t39gCK3M?=
 =?us-ascii?Q?YgmruGRALFOuImNPf/t/ml12+qAVTxYyS7IzIlfMH2oUPS/hEA5FSu6O03A9?=
 =?us-ascii?Q?KtVQjHURvR3VfCHU/JgkM37zAbJh9yMyaHquY3j8iv4II5BLQdOQr7pz0zTh?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5LKdiZ0FDipKmvuJvcBGPltahSuDrbvllmdOKkqSlaIooaLYOgmgieS8UT9dXNd3/oLCK4sxdETx3u/SNsbyuVrGd/nCLX5tdiY+UQ14fMv1kNpBQ8d6n/XH6kFzhzj+m+Ky8iLQaEMxmKbLG98ey0W1FtrSvEr1/siSsrMnxtpNJ/GLbyDFrRvOjz3+voAHfQr7Y2sLyyOPCM/9LPQBn+eoc9vakr9dr8HrBmkJEZiu0EuFdMpzAY0wxA6WBVigCeYqFfnpmKl9vI38aQgvPpZTPIs6KNuDdgGDOb4WyXGSeK3OPWTHnRFksr0WyTdz0d3YrRt3BP5eh1gHHsKP0IcNux6h6I1AM9xzddwlguqgF3JOwCc3GReqWf87LBmv9DwRAL+l5GffZSYCDx7tTZzZmqT3H8OuzPdT/5VYY0Y8tDTkQuxcuHAJMFOBDsCs+3QsuzHOWguDIDAKGyXIY34aSf3x3+kIV+/l3kYDyrc6M3ACYguVCKfT3JrF4jLtsi4C9WSOssDAqhdw8kpoYs+2e7PF4NsVgQvfqy02TIev0JAvGciSZR67clj1in2hR5xuw6KscnHUUDFmLCXL2e5ypY1zt3f4J1wT73apS8c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 129cd9f3-fe2f-4617-d6a2-08dc26b7642a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 02:00:28.2164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXMT9H9RpbapamKr9iJOI7FnyexyjejPccQV+WjFYmyFBmKDNxOz9nOLz2pRMnvJssfdtQfQNG23QYpJH5C7kzrEWPoonerM+xwrZeX7I+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7406
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=695 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060012
X-Proofpoint-GUID: _jwbdH5Qy61aPe5jyH8_QXzvqyUeJEQJ
X-Proofpoint-ORIG-GUID: _jwbdH5Qy61aPe5jyH8_QXzvqyUeJEQJ


Ricardo,

> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across
> the tree (e.g. [1]). Specifically, this series is part of the task of
> splitting one of his TODOs [2].

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

