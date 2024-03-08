Return-Path: <linux-kernel+bounces-96951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5A1876386
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0DC1F24F30
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD4857880;
	Fri,  8 Mar 2024 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UYMB+PFt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NB2V1bWE"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F91356459;
	Fri,  8 Mar 2024 11:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709898265; cv=fail; b=dhv9fsSskBsIMcYdEp4I3s99dGId2OeKwiOFqA405gk5njq5PWU9IVFuRQgYbV3aezApy3CtUxR9m1MGmnuz0Dn6Vm8Uhc4dYkgJzWW87D5PZghjWHLr6iOzujW2YaHbbRsFcgNUsMutLUxf2tjw3V3kB05MOyb4a2qdd0Tn7As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709898265; c=relaxed/simple;
	bh=vQD7CDU+Ec+/M+QQ9hd/EVN63RDF8lYDogZXYZieDX4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=G92ayvqkX6Xb6u2t4424J754LOC4OEHYl04X8KWDxT5rr0O4BXS6UCWQBlef1AYY758ktL2Y/DkE9x9w8eP4CPrunv+EWsMt8nUZa3qlv0lwDgk2+TLbB31HhH6KZEwAeyurxWNDSU7GGHsCpW2nyUyht8UoDYRi9l7Iqzqoggo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UYMB+PFt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NB2V1bWE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428Aht0k003610;
	Fri, 8 Mar 2024 11:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=4z79vO7jBnJ82ftWpTpaaMCCIMe/MOYuIOnsQYb3C0A=;
 b=UYMB+PFtE9tQ2oNGLW8Ob8FAdlAQjEByuo8hZxHILtuQDwbjzmElcHg9NZ+6XyN1vbi6
 TYx4QHeEvFQDhLEs0LVcqE9OU+GCuphSdue+py5frXWzoDJRfVVEoF7279JECYw1x7ar
 60x4wN1OlxD42RukiRoMjf7Us+nzILguZJ0xnohvex7WK4/tERR0dhWYVU519PRNCcPj
 1Yh0PAbWSABepU9AV3aAGVXetwJNr6C9BqfzYDnOIRSxyV7KfUDKA3wpNcO4XEltcbNr
 cMWJD5thTfBpQpmiO8Bx7te78dVUBKytlN5oWlIRCPdlxCkwWRRnQm+zrhWukQ/dYmrv kA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktw4emh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 11:43:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 428ASUSP016003;
	Fri, 8 Mar 2024 11:43:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjcpmq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 11:43:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLtRhz/XqZyyWEWQO7nFOgAnPB3vRg2un7tb9P5PbumA9v2CiCLJJHPv2PxAVsCTwLyf5wX181i1rEb0/6wuM6u7azgygnGE7fvIOrcfO4Z1ky2AJmR3ri1MJfgtyYrJT74XhG685KUE1OuXDORwpszLQ0c3c7iDSgsmXsU78H98l/zdAHx8V95qQOCCuNq1gY2c417C/NfFZsUBiiN75pl4s0eKvMPNGDolgxRnk/18fw0KBx5HgnAqq7wTFDfdwhibZ0sAtVa87hy7WkFghkv7RTNKwcXpSJIyQN1NzWvhrwoPioAfaHFyrhSk3v0w7KCQYUSAwRbAXb6jVEeR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4z79vO7jBnJ82ftWpTpaaMCCIMe/MOYuIOnsQYb3C0A=;
 b=gOXK8k19ryYeLS7cjbCCOFZUXRkb55uH24oGjGZapJZm4f1F+WoiFGJpwmKUTogdcMT5NOkJujdiwaufc5g4PD0jse1hSihaBAXOudAuH8B/rgXL2qc3KxeH6oEh9b9nAGlZXF7IxAo+ed7IQTWBbPiYw28PclIGD7KrUdxoLI0t3B+TCIy8W/rM8sPWt+6/awxZuInDK8qRk5IWkLVIjuh1OEGB4dQAJHbTeKOL+z1fdiW9WORfcI8vAgJvzzuYB2QqezC1SG3APu+muycPRm3L2ytoUEkj85/6HtRf2uTGzJMud823ALsDKfHPPSwP1gBmFWv8D77sr91yzJzyqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4z79vO7jBnJ82ftWpTpaaMCCIMe/MOYuIOnsQYb3C0A=;
 b=NB2V1bWEXEzCRU4SihT5dyls67wTsAvWWeK4yOV3HsdePjwgnc2NnAzAnsVZQ9ZW85fePUt8YXA5Qe0plIiCa1PfLfaBGnNZy/xxR2Mp6EPM/xlBDPcFX0xfhsK5KKUJzPys1j/D/WDUSYNI9eRPL1sicpbOHudXhf2Nm469R3M=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4595.namprd10.prod.outlook.com (2603:10b6:303:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 11:43:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 11:43:42 +0000
From: John Garry <john.g.garry@oracle.com>
To: jejb@linux.ibm.com, martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        jinpu.wang@cloud.ionos.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, dlemoal@kernel.org, ipylypiv@google.com,
        cassel@kernel.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 0/6] Add LIBSAS_SHT_BASE for libsas
Date: Fri,  8 Mar 2024 11:43:33 +0000
Message-Id: <20240308114339.1340549-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4595:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e1a1a7-d885-47ad-84f4-08dc3f650148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	btM2ShSYvyUmvAuy1a7aQKC+CaCMPOAEBcTTr/WxQ+sIxNAdlzbcqhJt0v3I0N8tJnjYpnu35mUnOEbjzlKhYK41g/+rfALJ1ab1GJmQkm3qJgbmoDB72MwMs2URGyAu3a+kX0qoJM0gFWCpOCLjLCJdKsmW5DikCLx+qHm38Xzo/giQYIrN58nd7/9caMokdAmAusMzA+U7MHoNpjQbIDb91NK8XgDdqSO/qilhKQimke49LHnMEJbhl8bpvefdPe6Cpjth70hE2j8o/tWG5kPJz6/Nwja0/ZoHOOcrh027Np9T2kkvauQlrWLQP45ZZsWXFch2goP0uAlBxBHrobUiuN6+rz1Ue2s+i39nQxbUffWb9R1XmOojx75lsDUmK0F/C+sV7xKCnPz7b/mB48ze9JHBOggtwtr9ADNRXwcazknkqulQ/BMk6FqXTDjZgt5wQdNwooxCCAsUaVZ8rzacq6v8/bWi9aZwbvMbVwOO5jGpL/yvcnOhmCiG9cZoJgagxL/tuAXlazxBWtvz2KYQPmQ/NbjTsJshMJd3SfbEZL1KbiSnSW3cTafqeAncB+3pZ1Yt3V+XZKnsll9HyglTKjpUZI1WdN2WBdtTbjQhCFdVwmpoTo/62/upUsvxy/E2dQGyBNVkl3Hcqf2yeZz8dzTTZMRU2RVK2MIVuzs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?R9SdPGxhgzAnA+GPjX0tmnOTxPXWDDzXghz0G3mSngU1Al1DrxypwcVFqn7y?=
 =?us-ascii?Q?0Zm2u6cUvbNhJD4plGvIpSIFHMlYVnahrjpX+EkO7Uvr6YMn3r0Uj2feGQpk?=
 =?us-ascii?Q?rXVjc1EWW2H4z6m4NAU0fOQ5sTCN2TQttF1lvnHUliav50hwjKroQANvyO6J?=
 =?us-ascii?Q?d4La+jIu6d0iHBNk3QbDn4OJGO4hhgz9LyD1hDpnRwuypuhSh9xKJBLXtVju?=
 =?us-ascii?Q?qg8s9lnGM3g1kA4sKaW44vglfY5nS0UDc+xM7qaMct2TcyxUxjWwt/U3/fyo?=
 =?us-ascii?Q?0/Gextr7J2+QP4g0vXUmrkKQb6vXm6a0VTBhqLw/OKcc2sJrFWkKdk8Bh+EK?=
 =?us-ascii?Q?RHvBP97dDim3OR6ubvzMbmH7ywxNEkiott11H1bHGS8G23lcW7cAyaXsCn9G?=
 =?us-ascii?Q?y0m8cJdbOlUfyGZ5JTWdVqhbJ/XN8q0P2UJ0ohZRZVwICpZA6iH+6Ikj0LuN?=
 =?us-ascii?Q?CBJCi6tGDuT31zgiV+2o+wL3gjIIPGVQHWGhEvEIQuxK3XtKJEOEsqYrUCx8?=
 =?us-ascii?Q?vyKN+LVOWwO5RqJR/Sh6SNBY6TvwfMIXZblo3q3biVX7ImxAFox5qgnqymlz?=
 =?us-ascii?Q?L+VMKKmAmlbd1BpBKCesg41Y/MnDztHb0ZcDQ1WGIFUCItU9oGhAqejxjGWw?=
 =?us-ascii?Q?wNyj2EeMA5o2mU+vPbj2NHDmNL3FTGVtZwETwS+YoWRkp6bAwEDFb1Xm47ZQ?=
 =?us-ascii?Q?viIna59mnW8QCQxpiy7cERlnh6Laow+Wy+9S1i3MvIorGdteoq119w637GJB?=
 =?us-ascii?Q?IFl/29HbCWDAKRyKB2NxJLjdcWuWI5xvbDIDzvQfg+Oaygzd+0+3jqD8mHQ4?=
 =?us-ascii?Q?qlKowiyZ36boYR2Wxq+WLHMxsZSIi9soFCYLIQTrre/bBN3c1rQ/FA9vqOzi?=
 =?us-ascii?Q?kB6IZlWPiNcIW1gjoYK0F0i8J0wR3q03uV74QN3oIj7DrRAowVSR2m+O2oIV?=
 =?us-ascii?Q?L83wBbQFSMihT5zUGTPWHWJ/s+LnI727xwMpZWyiDXMG4p9sTs68Etx7YTXc?=
 =?us-ascii?Q?BeHylBIljKeE9aBUDNdl6oPQplY2lvlOCj4dsQaM7+LKSaWUpSaJAF1r0Axz?=
 =?us-ascii?Q?djixuvHdcsy5KVdEM/piHxWD+sfE0g2/qg8GmUr0tSKuxMfY3C4LITdQygbe?=
 =?us-ascii?Q?x3it38mB4gx6bF0y4Tc0iaJGb2EqOtjYE6drijhQr6WU5WzAyaE9x23Il9iM?=
 =?us-ascii?Q?KeDo9GEjhWKJydwZTsS2ykcEB3ff0yYqdap4uyKikYDDB6KpXOJGWPGt/+a1?=
 =?us-ascii?Q?G4pRuFPBs7iuj4RTLwVHR4fnvTecV4XvFxQL5fmFQF4I5z882yeBq5e1RJ3g?=
 =?us-ascii?Q?297c7frwWidA+ms43MF8u6v58l93fGHpX483zQENkZ2LKy0RQ6y99/j/QY7M?=
 =?us-ascii?Q?4279zIL3uQMgIIDZ7vDcv1CU5OclBT3WP5+kiQQcGVjLgezur4CXuJVdaMaY?=
 =?us-ascii?Q?dGKdjnq2qhp0x+oYi8zrfZYObByyTw6Jxi0x1bOhmSpnZCwnFHwwKOOHLbOR?=
 =?us-ascii?Q?vcGpcgra6btN4OTz8n40lGmyKUjH+VqCaA3JNzYB2uWSVEhaYXtiA+OagWAi?=
 =?us-ascii?Q?K4LMZnBPLhIB0EZ/2hPFWc0ZPcPKnd3aVimgywbGzH6kKYwfN04u0uOLHBWd?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yt0TkR/lgq7Q7HF6xFOKtFnQRH7hf1x0H9f//2id5OQBZGwt1g2Utg32EEVcwF+L9nT76iH5uWt3Rh9scJLN8kTkD/zEgIME0KdBlOrcSa/+4L5yKAeMPwGIxGlBGYFPeClMoBnbqj/JrWk8cZCGRBC62F6AfbTT7gsjj6UDV4twALdSG7hBe3Zi7Nvyo7OX87k39a9u57M0+yLuhNnMXg3iNaQvZZRUg5Q/dwGlvskOSx4aayjpj3frL0baTztgrkIUElRZg/reAZNVnCx0aXyKAeVqnNtDvAa7uTl9Zl+jqkfdFBFTpGGrkpLPZqVbk+Afe8Bn1gpZA5FjKc7WvXiD350auMsUwcNNgNn5G4K4XP6HyeqGazg9WiPxlRQ6PuGQw/fsjtlifjyG/pOw+NZ04tDQsk2ip468BnY0ZhyXvdvM2Frh2WJqLcdVaEs2o9Q+LOhmX8IgSIkUltwiFFevslnSFG3jrTmcmxpamSoiE9uHoBQMG/0/SzSJOJS29UtcgGrDCd1xKpQo/QdIG4Vipz72iWaS9dPccDzxut6wRt6Iv9GJX0xjeqLRkE5eRG+tHvswhzCMSxb3rGAkP/NPim0Ng3GjYwtpNH9YLhk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e1a1a7-d885-47ad-84f4-08dc3f650148
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 11:43:42.6590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Sx1vo31UCza6swZxuMIvyIjvYc2QoFd2AW+D4zAdaTsJzYEJZ9BxCUKTU8G9olX4SckqvsWFCWuauLO2/EupA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=721 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080093
X-Proofpoint-ORIG-GUID: 0c7SZ2f_N_gjIordK3eWpKZ5CrMTu2Dt
X-Proofpoint-GUID: 0c7SZ2f_N_gjIordK3eWpKZ5CrMTu2Dt

There is much duplication in the scsi_host_template structure for the
drivers which use libsas.

Similar to how a standard template is used in libata with __ATA_BASE_SHT,
create a standard template in LIBSAS_SHT_BASE.

Based on following:
b914227e4215 (tag: mkp-scsi-staging, mkp-scsi/staging, mkp-scsi/for-next, mkp-scsi/6.9/scsi-staging) Merge patch series "Pass data lifetime information to SCSI disk devices"

Differences to v1:
- tidy libsas.h change (Jason)
- Don't set eh_abort_handler in LIBSAS_SHT_BASE (Jason)
- Remove sg_tablesize in LIBSAS_SHT_BASE, as W=1 build dislikes it
- Add some RB tags (Thanks)

John Garry (6):
  scsi: libsas: Add LIBSAS_SHT_BASE
  scsi: pm8001: Use LIBSAS_SHT_BASE
  scsi: hisi_sas: Use LIBSAS_SHT_BASE_NO_SLAVE_INIT
  scsi: aic94xx: Use LIBSAS_SHT_BASE
  scsi: mvsas: Use LIBSAS_SHT_BASE
  scsi: isci: Use LIBSAS_SHT_BASE

 drivers/scsi/aic94xx/aic94xx_init.c    | 21 ++-----------------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 18 +---------------
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 18 +---------------
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 18 +---------------
 drivers/scsi/isci/init.c               | 23 ++------------------
 drivers/scsi/mvsas/mv_init.c           | 19 +----------------
 drivers/scsi/pm8001/pm8001_init.c      | 20 +-----------------
 include/scsi/libsas.h                  | 29 ++++++++++++++++++++++++++
 8 files changed, 38 insertions(+), 128 deletions(-)

-- 
2.31.1


