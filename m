Return-Path: <linux-kernel+bounces-65928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168658553E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42906B2BB74
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2508513DBBB;
	Wed, 14 Feb 2024 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I07/FptB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TBw0i4AI"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C5A13DBAF
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707942081; cv=fail; b=aiQPJJNoRFE8i+Zovytm0cHzXKdZGf1fGeoKOvYxTovWebA5PSrM4JtIPnbzDp/UA8WkuowawMi7YFAXrj9YaVpVwhb4eOwLipVPt4bHFG3JpPaVqyZjuaqMLEAMskLBvm2aI++pZ25uIZrUZnpdu6to/ohA3EiH8t8szpoJSEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707942081; c=relaxed/simple;
	bh=5RrlV3fg89USfu3I+rInJuIWH+oNe16fU8lMiYrZZb4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U121PVI57Q91p6vj6ehKyaAFS4MpsXjTMopnn4Cl4AS2u5zodFTlKJRfXarDmPt4LSZs9CwIxPlz67/ylEHdXXzvpArA9pQ/ZDF/K7rxoXMEa57Wm/qO6dfkBaJyeLfDya6wLa+/POqSNArZcViNJGoJkSy+sRIaOW8LWT5QvHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I07/FptB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TBw0i4AI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EIdevE026498;
	Wed, 14 Feb 2024 20:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=iiZ7gxu9lMa4IRCeTP5FkjlK9j0oa0IquhNO+uwdz1c=;
 b=I07/FptBmoxL9pINPvNrEtNn9NYhcsZ1kY3cRhBTszkh2d01Xtvs6skK1l767+we2t4j
 x5njUnJQu/VZwsZ1juyFbYEaPhsuFBLeR0RHsRmJtw7H55vaf5E4XBgUxG2MLlavYoBO
 SDZtDzruhdcoezife3g36vBV8MYimFj9OiM2M0jdBQP/mnnsZusBYi/ncZUgNEwqU1bn
 mzM9x5dLr5P9M8fXVgHiy2DYTstS74K7ALeIF/1/2WbK9ynuEhwIuomRBcORlLEO6L/Q
 sDBcdUjovARre9GtDXKSWoTTmAhVcmVzAx9nAFoaOK+mojVBWxjJQnMSx7g9rx1pwqif aQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w9301g732-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 20:21:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EJJ9b5013773;
	Wed, 14 Feb 2024 20:21:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6apc9n8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 20:21:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iODJhtJDUwHfTxj31/A9AXhD3UZPUk1ph5LlnUhxR6z5r+2XxF+Oq7jVuOe51jAA426ul++h2Hve/l+ujEsRN/wZUO8t3qTrBuyPLXgCisLj3bP+Okqb/442cinXHeWFGO6k3Huu2hrVCtPYaDM78dIE0Jz8Y+8MwDillKuYfyahnZp82vFg3HqZPwjUK1OAGVYF5mmQgWgybpIpbyGhgZ7X6rt4TFyGhFAX9G2PcZZhHuGTK4V3FfVLU1IKVanuKe4NGHHXEC1YkVGH5wLhLBiTaucqLPIPcM+0wBd2bB8Ms0suDsteOd/e+iN/5dDOmXImiZXtCXaBssYIgKUqyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiZ7gxu9lMa4IRCeTP5FkjlK9j0oa0IquhNO+uwdz1c=;
 b=CPI3uXdTkWag+8bJxaO+Jh1tGXWo0bD0UNAbgKCQh6Qs4EZbAW008jMwviHal63H4Qvh15RnhdpkRmZQIMN5FAftJ7gLHL2nQ5tN6kQvtlsJeb3/VKPXix7OuqrMPAIrFvqs7bSot2NDiBedYAgl4xDLy/4oSvPi10YILREYSpRwtWBEkSfjodJs7AiOhE2BMgZaXzy0G1dWKTnidfWGJ+x1SjNxlQjKhTCLLyJVl2PmPq7S582Mh0DDNj7hSpRhNQH84tTcPMn2o4Y2m+NEOMBoEtT6EgtrhGbjXoLeHqT3njPGZHApu3/00uGgyzkFDh6inVfJK65c0/uRhpXq+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiZ7gxu9lMa4IRCeTP5FkjlK9j0oa0IquhNO+uwdz1c=;
 b=TBw0i4AIZacWSlBZS4fg2VZ1cuXxjg57yJm2Pjlq2FC4ZAfARDg/oX5oAKDU/3cbJUIXjcKSbdyuZUw8CEG7JboKwJKrjMYSEY+l4wbcoJVumqHyhOlM2JW/Ck6QZE0oa3vceVnsygZhMGd1amVHnNR3nu7oP7CGey6KoaSzyCg=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by LV3PR10MB7963.namprd10.prod.outlook.com (2603:10b6:408:20e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.37; Wed, 14 Feb
 2024 20:21:02 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7eeb:3b3e:601:2e14]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7eeb:3b3e:601:2e14%3]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 20:21:02 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 1/2] mm/migrate_device: further convert migrate_device_unmap() to folios
Date: Wed, 14 Feb 2024 12:20:54 -0800
Message-ID: <20240214202055.77776-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR15CA0023.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::22) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|LV3PR10MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: accf2949-7f8c-44b8-842d-08dc2d9a7667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bJG7Ug+HAD5LMCpF8fCQt7nRtg6w/aO2vNkxm/B3b0X95Hs6pWFnQH5PM5jssnXjbLo0DffvgpbtnaW0gOXch3j/DaLEDcEhB3hYNLd1O6FrtlayYcjkG3dVhCPw5JeabxEGzypbHHHUmdhalVzw33Q2kM1FxQLJfKbsk6adNND1QO/kLknIXVed0qtsnF1w4ZQJT34w4Wq2UVQsR3zd1HVbbrQjNZ9FcG8u32uNQixd6pmfXNvEbDxNWanZR3YcYAf5sBs3AJoiq2SfyctKXhHHsWGRtjqDKK1V4y7QpEjxftPbyd6IhAIzYxuVda3IHzq7NFMSnVhDNslb+JqNGvdwZlR+zWzhJbceO3vUYYbwi4M4i0StYfLcv9mMNHTJvjREDHFsqB1xrSWt4/j/DZ8cclt+jC/N4UN+dzIORdMb544mocoOWPkN6VPHhe8XNmE04g4PPxKTZlj4uF7K2WlJdLdATVR9lmldO713YUUYLMjHNsZf/3At2FxdNLkRisKrKwn6hEhfO6Di1pInnD1y9mezPBQbUDSJO6UmMAVQIxN0j50qBM/Z9QyJAuOR
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2906002)(4326008)(8936002)(8676002)(44832011)(5660300002)(66476007)(1076003)(2616005)(38100700002)(36756003)(86362001)(107886003)(66946007)(6666004)(316002)(66556008)(6506007)(83380400001)(6486002)(6512007)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kI5mfImXzBXCJncEw8IAlPDehk0KDaD+BCcBC5T3USUIe3+PE39eXvlGxV4w?=
 =?us-ascii?Q?7Bzf1Qs6xneCBdTCPxzUA0OfzvxYInRQz2b6AmUzlHtW+PAuBddvGTf/N1Za?=
 =?us-ascii?Q?3RkBesBP7au8XOdvJ+OlNkvT9LhPImUzmNPcxZd9N+MOqhT+NefEBkdV0jLL?=
 =?us-ascii?Q?CZpQLC8jWltyAfSpgBUUtHNOXGu7zvhEFBqI6cFjcAE9wn6XjH0cmcZrXHp5?=
 =?us-ascii?Q?G3Y+uTyWjSh8ArAZzSep2EQCDHTj/JXjwY8sStbu7VaCXc4vrKjWMowTRtU+?=
 =?us-ascii?Q?d1KnWrQ7CwXWLxWMYdoXuZB0jLVh6AY/Z9lTBmh/S9HeLE/pfbmwGGvqnStc?=
 =?us-ascii?Q?IfTEnuFru0bSxZpJVQbgJqf0vy2sbq7Om2dXTBNpW+6zi8lEONItQf53iyZv?=
 =?us-ascii?Q?nuk7oDRiu6RxDkkKCFfbQXOvHimgrXewayF/0pzH6D0pAkULDB1+8RUFuMp2?=
 =?us-ascii?Q?QkkLC1PgxE+axilv8NjJ4SY46vzEJBUDCe9fiatDzc033y5FH34pYplnuHAU?=
 =?us-ascii?Q?L6WjZfMzuvv8J35kGE5lGEj5yvjxPCLHbb7Cj+EVRaqSHkCK2u5jKUcW/HJT?=
 =?us-ascii?Q?jp8F5ioTqIPp4K0Xcj8Dme+NCzqtZLoxSnCp7Qybz+mndcw0KbQDVNGzNvy7?=
 =?us-ascii?Q?htWrz8/5oZvipukyxHZ9+N0DPBlHoTa90G+GYlPK7EzJoeukN7kswdqeLcDF?=
 =?us-ascii?Q?q8bowvPnED0pqGazrHnF8W+kOnQiiIBGLAYWWBgIHtRNKKWryya1v9Cv1sFa?=
 =?us-ascii?Q?RfcfgapY46IYQ8SfeeN8xBnNjSrh4eX3e/NL7weOuOayt1fV+2TkZVNf2GLB?=
 =?us-ascii?Q?LoNTusHVkkhDG+RcndIYCAoZhsgSrJ3H0HEFY5APhgHhEnaousBxFeXlta2V?=
 =?us-ascii?Q?dMNBbZhnwdUQsxUObETXN/EXgEuyh7++m0EXxSPeH3vTtAIBBtLDU1obWkb5?=
 =?us-ascii?Q?X3AaNQoyX3VW6FCMOvv844iy+x06mQeD0MBpsAwykCk61nG3SARIahBidJzL?=
 =?us-ascii?Q?wf7fHkXYPz4Pgx+I0TJ3aj4n5mb35i/6DiCtfXfGKQ0QAVGnBCnFsMmdSUPy?=
 =?us-ascii?Q?lhc63ebeThvdA+r4cBrRcoUvMWs7u8CxwNCzObXnReqdQmSqjNW90tPkNeOD?=
 =?us-ascii?Q?wKPzcTOOiDQi6B1J4PeUZ68MrJvSm22V7ayJ77RW5DEgLyBG0E/Ak4rnruwR?=
 =?us-ascii?Q?AgDCM+0x3PtCzJ1Yps2xnzHdZMdc2Gp4u2OAuO8yJUAZz2F4C9UfZlLoB5z5?=
 =?us-ascii?Q?VV6edZkBruOCX6CzddQDp3fBt8O27VerS2hR7f3YlOXLsSyY72K/QcA4+5R/?=
 =?us-ascii?Q?3nu/R+olVJfeDZhYZmHLjuiQNy6z2hX1H7DHJn+5wkT6h5uyl0Dx/mw3JiMF?=
 =?us-ascii?Q?+f7S1jSbAidvU1YV3/Ylu4IWyJ/AjL5AAW69D5Ohmu6rax+aRD3e0aoDWR5M?=
 =?us-ascii?Q?AkEGc+cVY1sCofoHI9H+v4hYeB97eZ0fC/aKfo7JGkeW+EVbyH/rWXFjW+Oq?=
 =?us-ascii?Q?ob8rIVhOKnv5/sen9UWolU/XkdmjSN5PHQ2OQDhqP+Y5cLCzqtGQaKawjyU3?=
 =?us-ascii?Q?JdFEy4FG8wkcSu/s3ci8/AqgtxPBLPdqKFQs3/dGSfYkY7pLWeHY6sSUiRs9?=
 =?us-ascii?Q?TT86uoqShqjEirQxQl/jFYw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Cy7wYQeykq4zj/3uvKUrnDVlx9ENOgeunOJKpGUAUzD3MgWckTh4ID7Tv0t/x/A4MineytW+nJDkmA/ORzNGnJ1y7UegRYAXEt8IKF4UMtE00NivtupRf6TnjGu4FFI1s4K9VdY0lOGrKNqm5pNE7dorNkNDm6RDhXfipWmiZdraM2r5jAG2jQrD6ZKNz9RzRFiQD4KXTbk6dGyhlVuDE4lxA1mLlEQQ2e5M8Gf6r1bqjH8dPBTjN7F+OkB2AT1lrKG72HvqVZ5I1nN/QHFOlQoehMc/xOOa0Hm5o2wIXRspgZRcDskk+kRQUYZ04Dsm407o5QhSV8YcCmKviHUwZQPwmSnnbFiPwQOKMixUseSKj/IdMl4CEJbuKBx1UO7L/7h2qZ+H972Hdzi5FzkenYcyogLV85r+rd/MKp9pZ2XUuqhcC+VKKx2F4a6sGchuxhN/UPoqfyPJpEHIJ/fdab825mBpk3K8g5VJSewlWnNWLL9S+UollOsno+KoM1U4DsfF8qr+Li6NlLDuHK1kNj/v+TzfRLHrNGou8EHOKn+SK/Y0VY23PH/Ipmq3y0zYjOSTVqgJzWdcg+PcaHX1EMHkBaCkHXpLGokPqlBz9xQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: accf2949-7f8c-44b8-842d-08dc2d9a7667
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 20:21:01.6749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxLBPSDyC4VI09W53OEcJwa39WtPhqMQ9AmaEArjqehkJakJGF8Q0EHZJ59hE/j00EJu1TF/9+VVZXTkQ1zi0lepAwMzCQOFXG+KpyMCNVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7963
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_12,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140159
X-Proofpoint-GUID: InrWXzdQ2Pe51EgldL5xHgewOgZzewMd
X-Proofpoint-ORIG-GUID: InrWXzdQ2Pe51EgldL5xHgewOgZzewMd

migrate_device_unmap() already has a folio, we can use the folio
versions of is_zone_device_page() and putback_lru_page.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/migrate_device.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index b6c27c76e1a0b..9152a329b0a68 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -377,33 +377,33 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
 			continue;
 		}
 
+		folio = page_folio(page);
 		/* ZONE_DEVICE pages are not on LRU */
-		if (!is_zone_device_page(page)) {
-			if (!PageLRU(page) && allow_drain) {
+		if (!folio_is_zone_device(folio)) {
+			if (!folio_test_lru(folio) && allow_drain) {
 				/* Drain CPU's lru cache */
 				lru_add_drain_all();
 				allow_drain = false;
 			}
 
-			if (!isolate_lru_page(page)) {
+			if (!folio_isolate_lru(folio)) {
 				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
 				restore++;
 				continue;
 			}
 
 			/* Drop the reference we took in collect */
-			put_page(page);
+			folio_put(folio);
 		}
 
-		folio = page_folio(page);
 		if (folio_mapped(folio))
 			try_to_migrate(folio, 0);
 
-		if (page_mapped(page) ||
+		if (folio_mapped(folio) ||
 		    !migrate_vma_check_page(page, fault_page)) {
-			if (!is_zone_device_page(page)) {
-				get_page(page);
-				putback_lru_page(page);
+			if (!folio_is_zone_device(folio)) {
+				folio_get(folio);
+				folio_putback_lru(folio);
 			}
 
 			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
-- 
2.42.0


