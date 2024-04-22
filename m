Return-Path: <linux-kernel+bounces-153998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 286F38AD5DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BAD281D89
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAA11B949;
	Mon, 22 Apr 2024 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZwzAgGMT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zLQ/ZVU6"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07B01804E;
	Mon, 22 Apr 2024 20:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713818092; cv=fail; b=YdzTbaN9iyQIB/BBymQkArEOxS09hRPdjXSYA11JDhH8e7XGRPLhwEcweZTMhjEC4DNLAQ7EmN6CFqn3tZ2aUAtPeeNZxPdDin1dVd2jRCHdumjeshOUZbjXFaHiuNpHaXkXVxHlVK4288vzLUviPU/InrJhXwPG0HRRqFSUX8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713818092; c=relaxed/simple;
	bh=L2VwAb0XID+NmRIpW+icy2ngQYfjwMpjvmTiDtvdv1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ek/XsuZTeIQVyUuhQ37/RPGYz2GUKPSS9HE4XrjjHSqEeMSdYycqxHGRf2zBCjMhA9EnOBZrV/PMP4RtcYYAOyy6eSyoka1SH1JzvvbzktOqnFYW85CLeX7yTpmt9eIjL3Ih4Tz0GShsnAs3jH/fwKYlGThvWSzq3djm+uy1DdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZwzAgGMT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zLQ/ZVU6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MHnQ9j005092;
	Mon, 22 Apr 2024 20:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=3K4P4JuBuNlZbcsga6MXMOdIH6qrTwFkbB7Gx2cPTKE=;
 b=ZwzAgGMTfvxXlJyznEhrNxgm++sMzPILSEa9yCgbVVrHOgTW9A9//WSxFB9jxTuGB1Yo
 YvSYHVYREwWLio8PMYscasox21eJHxU0o36vPeI8FSgO6MAmVkpsIy7EYtdQk6qyCryB
 Zpv+U4k7EKsAObXBcw+QH84GpJgouPe1uQ32XSQ8ZU4sXYkHozZIb9Z08o8WBCd/FefN
 atqTC9Ab2H23bCuzSo1yTytTgAdC+BM4yEjyTB9UfXVL+YWkzTjLPNeWFobYnHEHFjTQ
 AA1QWMrc3cZ0VGktBozRRJL0fpTtWB8uWDMcVs4YCmg5mnTzejnPMV+U1AJiXLZXILkl VQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4md3pce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 20:34:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43MK6dub006759;
	Mon, 22 Apr 2024 20:34:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45677uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 20:34:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jqcjo50jTpJv5AwEftFQlJG28R3RXBrXYIFzr6vEt6zkQrAfd4f570pSX2cDS+LGYoutYz4xWRO71dZFxsbEnIaxWmfO4k1PWCVi4SmFG7PADRT81Glj8sAGmWSX17QXLURGzFeCHXF5iq9uMu4zz9a2ncTB880QBLzYHbbkzRLukNuYUR+orwHlz1J/2i9xS5KmJSK0swoaslYGLkTj13BBNZw2XDum1tZQgDX/PEyi1wG1XAg2z1IMKbhPVD7USVt6NXGbHMq/ePFNfd4gKuFCOj25Iyw7cDohdkIBmeG+xX0UYEqTLD5QMf1bg14Bd4sUFE2HFIAxj+ePcU68gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3K4P4JuBuNlZbcsga6MXMOdIH6qrTwFkbB7Gx2cPTKE=;
 b=iHKRKxg0Mrxd22xp6EswrUZKBhV2r2044aWwOPg5BWeqViwygx3id/nLIqk6SCy0fCipSqs+z1sR5b4ahlX25Apa9DKFYsPvM5RYIMsAbbRegfnXWUWL9B7L6/l3frJeFTPpG1iecuI+2OvHM6+p3HcIL69Qsmh3RBmalNSk3ygndTPazQMxuTk9h4chS0EZg5RFkziRmV7OGnN9xUO7JJtDoYK1eEmXsfqQxN8QoFr2UfZnrKI4YIXQA6sF3u3PojMKqljh2Jo79ddHI2+BkW4KzA30K8Hl95rog2WGRLDbGm5oblPQyQG3m/TWBD46dWzY5UJJuqu3cEE5vjKR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3K4P4JuBuNlZbcsga6MXMOdIH6qrTwFkbB7Gx2cPTKE=;
 b=zLQ/ZVU6FBb45if+MXxflQfnCqsu+ZFfsp+/QTbRUg32zDoTRc969e00EQMb7gzikj61CCx/9KEptV+jlZFpOChtDvHJ3wuqmitGy7/99aDbLQaufOSyRq7QS2JRmjoiKZ6Lvdy8pYOqktKdou1M/czHd6hTEJmMuY922If5BxU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DM4PR10MB7449.namprd10.prod.outlook.com (2603:10b6:8:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 20:34:16 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 20:34:15 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Marius Fleischer <fleischermarius@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>, stable@vger.kernel.org
Subject: [PATCH] maple_tree: Fix mas_empty_area_rev() null pointer dereference
Date: Mon, 22 Apr 2024 16:33:49 -0400
Message-ID: <20240422203349.2418465-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0355.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::25) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DM4PR10MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 4092826d-4705-4a09-f7e9-08dc630b93e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?uODq/kldDq8yWccTv+HqrfQj/e71MrB6KrnrbMLSQpmePGK2pudEpO/Oh0FS?=
 =?us-ascii?Q?+F2hsvH4D7L7WiivQHNNQ4vCO/XyAlovqg7eaBJhfH3YK6EGpxGCREVOypR3?=
 =?us-ascii?Q?n9fKM7WIRb0Spz7ZLonyphxgNPH2pogX92Xo8N/IvdMzYZ0A7wIpNjrRCFZ/?=
 =?us-ascii?Q?gcdbkLeGKWwA/4J8OkH6/6U0x24As3R9+z+fvMXQU5UvyYADjlnVM8eR2HvP?=
 =?us-ascii?Q?psEZIAlndFLQzjKb0AjftVspng2zN0n4r8kmiy2wOG1t+GtKBgz71P6gWi3C?=
 =?us-ascii?Q?0CWmYN9LY1y69fvYpHBc1Sq4s9RjR5yCEb+DWJDFDCJyJ6TKmzmrWj4hj57E?=
 =?us-ascii?Q?Aw3tgGELQroPP4FZw4ScwPYSEjHZCVi9yGNTGE6mi5/PFuF2WmsTVDWmbscn?=
 =?us-ascii?Q?gSHjTbYSOzU5Ez4rqelT3Bj5YBbmgWEI8B06qqYxNuH1fgdbKxfZ08FMdfHD?=
 =?us-ascii?Q?VRSom8QMEfVoV5g04q3eKuq2ivbtHEhSbmXglobERvMR66iUT+sPie24xDlk?=
 =?us-ascii?Q?mTlVNpBdRy/qoUfyAH1CKr1nXvILE1C7qrNQwjjh92ZfC06EBLAWj1LoAKSw?=
 =?us-ascii?Q?OGXwlGqXTag7jxM8RhnOoqOV/cSmLmutlLdc2oLFrSj0Os9zu6VuNSAJScR7?=
 =?us-ascii?Q?kQEh6RqZ1j1ywu2j8Un9aCUq/1Upc390yzosvLkvX4LbF5/cxQPv3c0iI3Vd?=
 =?us-ascii?Q?MhUHuJPnfKXLpLg4pBftORibeVlrG6heaE/+LKmaaVTe7eFCDAPeygyW2/D4?=
 =?us-ascii?Q?ncrkXBxgb6kxNxEQOl+6Q1lFiJ9uaFamVl1Vqw78xWXdLXn10g0YYsN2TUL1?=
 =?us-ascii?Q?xDpp+G+0E5PRJqznPpHqQbDkFXdQkb5VU4ywIhs4OEj5nxiwLbA3866sgeiQ?=
 =?us-ascii?Q?RISY60ehgu7xxcvTQEecY2LWJFsGJraKTvdOyf7AP9cROTWmF+CfqYoODG4h?=
 =?us-ascii?Q?a1B+rPAC6tPgI73LbLXDAQzh+QEU+SUx9dfM3pWWQ5nxilye5AgdrzwnktVX?=
 =?us-ascii?Q?Lj+xv0msnRr8RcVDkPvYwCNjfgdvE1O9XxgxhgkGAm9+ydyzFAICVyzWrxln?=
 =?us-ascii?Q?Derk7vaWOJEHiIyht7/k/hClPzpGuQq+cYWs6ujZsd/n1CUhmvxodKnVjyro?=
 =?us-ascii?Q?ZNZ7vG7OpcCj2XmtEufsixAWAtwC+H9ndoPrUMoKVEHJesIXSnhK9P4ZnZk3?=
 =?us-ascii?Q?P1E8x2DIeQsuYUA7n9Lq1MwiMiQCznGur5mewRY9e+EPswN6wqfrC/qiCS6M?=
 =?us-ascii?Q?4ElDxmOwV3jrdjaICVNB+X4A2GNUbr8TKsevEe2uHQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WU3tVXQ86O4DbPE+2yzCuEse/8MhLunbQRjEQ8CjazDp3JgkK/yHz5bmQHj7?=
 =?us-ascii?Q?uiKfU6yCX1jaBGAPjbI1o7BPBiAp46P3wUFmIVYV/t4fxRMoQJcAW+PD1wWU?=
 =?us-ascii?Q?xbLyt/afZMXW/IhGikDqUjJ6uygawyQBfx4UznDKQa8ydalBrjwmJuk3xazU?=
 =?us-ascii?Q?qfmizJmNGNS33g4c6JZnMgM/m4RB/ZNgY0XsQJph9XhUZ9RzJWr4cJfybgnB?=
 =?us-ascii?Q?paQm7zYEi9gSyz891fv5tBcH1trMKeG42RGMv5tPUg2291pdrEiMERCPDgfh?=
 =?us-ascii?Q?5/yBFxthF/pv71fmiX1I46VQpcqRGspTaR50PSHOPOyfATayrHZ1Ilu4JDZQ?=
 =?us-ascii?Q?TybHBKQ9Et9NCaW+w1kGRYtmVx/zqadxl1lnNId2YJK2wQ13J1RIg/iyX2RU?=
 =?us-ascii?Q?A9ZGD4IvcX+9EemTPCeVCtcM75yoxkblmuWFhS6/fBQP1fSb5ZDMFg9ZBYOd?=
 =?us-ascii?Q?p0YvdKFrmafJWEWeNESrPNdJeslxdI32a/Xx0p3/eOyTcaidMUeQjFE4VaZk?=
 =?us-ascii?Q?etKYwstrVHa5QixH8FvYbw6UDgd1oM2Qc5C6h4uMEoNeFH1fuqC75ehGp/tt?=
 =?us-ascii?Q?tr4cb3TbQ1UQUx0Q6CdmHds9fH4VuPrAjfdvSP8Gto9zxblD4tsu7cCeXXnV?=
 =?us-ascii?Q?kgkIjN+cfrz9z7NHXAmJd0JZkdJQe5Qe1RF0UpJm1slYOBKs1ZaSJm+sjHhT?=
 =?us-ascii?Q?9IJWpAvsp/rsCT6RJ78peD/4MLBZYmLJYKzXRownjNNPvbsfFhNfScXzx/Tf?=
 =?us-ascii?Q?AYPGyNd6Si6+LzRiuPPU7mGDGQz8oXg0fveq6lso/7KRb0NPEF8Ol5HMSWDq?=
 =?us-ascii?Q?8x719GdtjIvuPzoQBAXKfeLLEBZF+TiGLBpPAcdhpBIhJVsPqEIMdjmNYcas?=
 =?us-ascii?Q?cQJ4JPY2cauO1NOWmpXEg31g6Bb2WxkIZve2m7zry5j5Bmsu2oRsgbSm5IOi?=
 =?us-ascii?Q?oEgAMWTo8C3BsQVR5bBe9NVK02IrbUjUeKW4AFLZwVkdVQueEqglWUZPAF3r?=
 =?us-ascii?Q?XMKMnRxMgBWabfw32g9XHbT6v4ZjV+vvvRyrSRZv4xyfmlxc7grmUFaBGEgd?=
 =?us-ascii?Q?H8SdXyC/VcZI94gscgpusbi88dM7mYlMmc8vDS3RzfuSDdcm7yE3N2OaHGid?=
 =?us-ascii?Q?UJPSYQt+8ti1dP61xC/3TRsSsVUMIYVn8mxNcFz6/GQymGCcIlLtOa79coIb?=
 =?us-ascii?Q?/90fdX6eRzkAhNgqDHIzMfwlFc0M2FvVBtyE67eukI58kN5MNf6VyLkG91my?=
 =?us-ascii?Q?Ff7fT3Biy3rTdc1flLg7aLegsup1X1vuGpW9rCZDxMlgZLzXx3PJgFOOH1a7?=
 =?us-ascii?Q?MVcvpWRrPjiRXPtXBjUfmBOGo5rOVh6CaEUvpWI4yd+vkpOnz+cg1j5PsYVw?=
 =?us-ascii?Q?Qc3kRVBKqvVTBxlQh3Fn8ip7P+YFq1Smmfd2YCM0S+3J7j5YHyC2wiUXS9Zr?=
 =?us-ascii?Q?QcHTrTVnUbWrxGL21e56AZNMWUsN/V5813WGLwrObylsgRDxZwVwPbx/eIn6?=
 =?us-ascii?Q?6kfm6kw4KEsJxkxH9v10U2m0mA/SAVF/1v9cSfwuIaeSJPoOGzEN13PKAnJ4?=
 =?us-ascii?Q?xlhJyBR0ZTWFGD25xVG5XWmNKSuClO5G6lB1JRuL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	msdPbYdSCF+A15EvVU8gppw9cDvek1RJwLaaRruWoljdrrM8UURlMUke9+EVwqo/XGKcQoxnd1g3cUlyH4nogYTX2zx0flr0YPAphxtOcQ6xXBb2xFBFzggipVBip5XpnQ/mwkek3H6KqxxRJd9JGaFlTWyrCd/mfbEhJexmXoRhi79KOTC/aOVtHv0qcEYEJvFj+eSZDqnV/AU7eI12Y/Eu42S6sAa2qQ9rFgle9Zt7hPEGoMwOHmx+i8hmgkowVz+L+8y6QBY8PX7IDt7xNJ5Rg1BOw9/E1mX6yCdzQksMLnUfzwB61/1amjijgT7NAMo3MtXIqOLuLZA2MPeFaKZ5X2IdyGhrUVym9gFFYbcqj4yCir/DMYcO9mUiwcCrMjvCsy2LnrZZi0Zd3ZCr7JFHEI7nsETZyW2vWQxtP5O+UlwqFyEMk1PlS4ctNCBHfLA9ft4ZX17fR3T+vKH19PcFDZrKF2aJmv1MkjPbGWLfrpWgQocS+yHFkaytG3b3Q2WxeyHAcrrPEgkiVMivRstdLw8dRqtYkq0Mjgo87bSgljEsHz86BAIDdx/gaIU3VhFc93avIg04/gg8JOZhLIIj4m6YtQSMSMAS4czOH4E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4092826d-4705-4a09-f7e9-08dc630b93e7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 20:34:15.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYo/pi03O8kX91OpNJcoeCZNH+evYN9I6ycYWyvRpJbYM9G/kJTHuKWG2kzMYiL5sSiurD+GVLL8nkaBvwNHng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7449
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_14,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404220087
X-Proofpoint-ORIG-GUID: jmK1BxBrpnyHu7mVxlh1VW8R4MKeW1dW
X-Proofpoint-GUID: jmK1BxBrpnyHu7mVxlh1VW8R4MKeW1dW

Currently the code calls mas_start() followed by mas_data_end() if the
maple state is MA_START, but mas_start() may return with the maple state
node == NULL.  This will lead to a null pointer dereference when
checking information in the NULL node, which is done in mas_data_end().

Avoid setting the offset if there is no node by waiting until after the
maple state is checked for an empty or single entry state.

A user could trigger the events to cause a kernel oops by unmapping all
vmas to produce an empty maple tree, then mapping a vma that would cause
the scenario described above.

Reported-by: Marius Fleischer <fleischermarius@gmail.com>
Closes: https://lore.kernel.org/lkml/CAJg=8jyuSxDL6XvqEXY_66M20psRK2J53oBTP+fjV5xpW2-R6w@mail.gmail.com/
Link: https://lore.kernel.org/lkml/CAJg=8jyuSxDL6XvqEXY_66M20psRK2J53oBTP+fjV5xpW2-R6w@mail.gmail.com/
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Tested-by: Marius Fleischer <fleischermarius@gmail.com>
Tested-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org
Cc: stable@vger.kernel.org
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 55e1b35bf877..2d7d27e6ae3c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5109,18 +5109,18 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 	if (size == 0 || max - min < size - 1)
 		return -EINVAL;
 
-	if (mas_is_start(mas)) {
+	if (mas_is_start(mas))
 		mas_start(mas);
-		mas->offset = mas_data_end(mas);
-	} else if (mas->offset >= 2) {
-		mas->offset -= 2;
-	} else if (!mas_rewind_node(mas)) {
+	else if ((mas->offset < 2) && (!mas_rewind_node(mas)))
 		return -EBUSY;
-	}
 
-	/* Empty set. */
-	if (mas_is_none(mas) || mas_is_ptr(mas))
+	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
 		return mas_sparse_area(mas, min, max, size, false);
+	else if (mas->offset >= 2)
+		mas->offset -= 2;
+	else
+		mas->offset = mas_data_end(mas);
+
 
 	/* The start of the window can only be within these values. */
 	mas->index = min;
-- 
2.43.0


