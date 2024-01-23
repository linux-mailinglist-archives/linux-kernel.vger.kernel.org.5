Return-Path: <linux-kernel+bounces-35725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0558395B6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D87AEB27A89
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BC57F7F0;
	Tue, 23 Jan 2024 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="b2CMzWLR"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC375733D;
	Tue, 23 Jan 2024 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029121; cv=fail; b=i51Vm//pwKWof4NOzkAtkN7ii343y1iDz361iidCH+SXncqv3qKTI5IhObi6XX8rTy/Z1Ykklon10ts42t8ASYMLCBT0vrIbtIq7CdpBmEwLsS6OCMFsn//U8rLPwHl32WvXe1pnVRP2rrKBaA88fMjRAbGdFrGxsfn8WneZtCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029121; c=relaxed/simple;
	bh=CQiCnAxw1xDXewOhwWsa9qehGPz5SGyAJIcjvko12ok=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WsIxq5bBYs1Dg8zLWYyZlht7I9c5NrvZK7McRauHfS7KAusYJpqwkSa4kuo5Vx5p7mIunlaTn837e1DQLi04BiXQE/7XJWTSDe6M5zz6ZUKs0NUEQ9bcacWWQyfK+kmJL4zlanamluCe++UM15vk5HEo0k3NX/dICWjMraTcS4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=b2CMzWLR; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N3fC8g011365;
	Tue, 23 Jan 2024 16:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=PgpiAsCyPf7QfY4KVH
	XMKIX8PHx94TGuao87xzS9gn8=; b=b2CMzWLR1soylWsTTgTcCyylI4D5kR4kim
	8p0X+dytWmCA2/UIZM5LREOt4hzEkmpr3GQAWHH5nWdNXp8SbTwi6+cJAdO4Z61d
	3YHDmivRUI+gJ7Qacdo1Ir/YOwTIzx1bs9muTM/E541CJuZXXcSSOCQN6AVuINDP
	SnpZjqcClUUTI4tDZizFpJjhlpokuT3X1TM4NIqzlLu1JVp9JuQFl9wHl8zDpSa8
	Giz+lsCEaGQ7nWTAm1FsAOemm7MDQU85zBoy1q8+kBD22Ilf7SKnLdOykhUjW3St
	y4IFwal0D+TJYkWd5QoXhMGo+hpjUo4gUtqXoFyF6I7KQ1SJivjw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vr5573mec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 16:58:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLTLKbOB8hWx/RdN033IAOrrkMUN7SCeSHTD8UyODkrXb/Wv0/+Xqrt7LOHIe/xfpIqQi1D5YjFXYXeiP2QD42T3eEc6hatEWsGVC8qdBgz5jK+viusmhlEINct+OoN7e228WrdGBnPJMoO26bhxowX41IV5OjaxIqYD5X+BqiXhbHcaSBpsCVDQzPyUG/OHDov7fqjUFT1oFbHH/5hk7uzDtNttuxy6CQTNfS1SPIocbtGL121tALnunNaDU+fokhej9glYbKjEIWygkQRfXblJoHnltFEL5jj7qDk1jk/JA/YNM16GJIN3Tj5UbvQZBq//hNBjpmmalvaSXNcw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgpiAsCyPf7QfY4KVHXMKIX8PHx94TGuao87xzS9gn8=;
 b=VChOY839FXYjQS93aVmKhTK/9Ys5umWRcqMIVIj7zzZJtx8pvcP0Iy54tDMS5RieS8NI7aFLow8U/DgsHf5wiZUNJZZ0XUueI9+zPsGaGchdCMKWTsgEIWRSlKpcCg55ofqf4kbu51MOo0p+K/NAWUlncPWFphlxX4aTzYovWs2G3DMneDGWuAI4vK4a5OnFu2vv9vs9pHsK0No3xa1GRbkLEtnMgbNqCNO51Pnwe83oX7ycXvjgBFUAi8fw9j7eHJLnw/v9EwA/siFwoRY/oUw2oMDozfzsBrSVW/ORdppNbiNl4XFUUbM9e6fZwjgA8RuiQ/mnffizgiYZiCvJYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by DM6PR11MB4673.namprd11.prod.outlook.com (2603:10b6:5:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 16:58:12 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::7c2e:5b95:fdc2:30e]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::7c2e:5b95:fdc2:30e%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 16:58:12 +0000
From: ovidiu.panait@windriver.com
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca,
        Ovidiu Panait <ovidiu.panait@windriver.com>
Subject: [PATCH] iommu: iommu_group_alloc_default_domain: Fix ops->default_domain codepath
Date: Tue, 23 Jan 2024 18:58:29 +0200
Message-Id: <20240123165829.630276-1-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0048.eurprd04.prod.outlook.com
 (2603:10a6:802:2::19) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5327:EE_|DM6PR11MB4673:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a91ff2-739d-41ff-5458-08dc1c347ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rKruvXK+aBmxToO145Jp90vUhcI8/ro8Lr8XyD7L4oOr/uv8gCjR0Q+uBkeignve3jqEJKkZa2ePWU19fTfpLZaZBdU++UprQ9OVOU8R9tXlv4AuH5s+ST74GLBzWGdZInwK8/skqW7L5bHlcEzvvb7yH7GVLpUxGmrVxl6k3nbVSIfHeeAxJ7HEqiG+EeJapg9ExJyhyRP3jEWUOz5LoTDanp99spPoxF3UTXrJGAG0Heb9iTdP1yYtQukuhIez61FqReFeyReJ8dthbwlXNTmQPxBgh/otmHMn4PRou9ymQkV63ao4FBGoHjKXk1WBAuKgadFkD2RYExp+OG78j9UtSAlDtQ/23oPFDW3QUeyznJJ7fxc8lbSI1+i9ITtx7NKisor3a1AqIJWKgVNX4Zg9xk+pbE0zeUVSpr5Q3JBd/cx/8gsu7XsGedLrPZB6XdC7gZ60ydzY37V4EGUByX0QyrSvqVhg29IPhte5HgGP7urLZyLfpwUpRsr8EjaAigNwx5fC55jmedEF+ZVz/i9P2fSjqMJ6yhhcLx9lnZhmuKD1aQ5UBdAicAd79rgEZnypqwaS/29DRYNtjIftxKOt7nMTu6jWG//3PjS6czo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66946007)(66476007)(316002)(66556008)(36756003)(38350700005)(6486002)(4326008)(8676002)(38100700002)(8936002)(86362001)(52116002)(26005)(6506007)(478600001)(6512007)(9686003)(1076003)(2616005)(6666004)(83380400001)(107886003)(41300700001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?B8Sv03r8R8xOS/ZFFJvqyTcH5S2KQqn/o+RIMbYVnbG3wxYdsVVO2PLyYry1?=
 =?us-ascii?Q?oBVjGx3/bWm/OSYbAQqDiYjGpeE/1ltDfhCKJLw1sQ1Wv9uvnrHd5vWGtTKn?=
 =?us-ascii?Q?GdvjAagaacEYK8AC1AqdmQ+bD776kFyQj72rY2nlSJL8bmQNopCT2e+IFJJY?=
 =?us-ascii?Q?QU0FtAoM4vVUMcatuKP9nly9hYlkAUaZnqZjmJ8Ny3I0GAk0LdJGsuK43dxm?=
 =?us-ascii?Q?JSHoTsrRi5g/MfMeXXygQEfs0Q+LkzORKlaOkd+Dohl0zhoIoLadt0n4WpVi?=
 =?us-ascii?Q?AES5miDiRwez4gMv69YBn2KmzsC03B98YWrn03pydreGqwPYsHPJyYpHtdf4?=
 =?us-ascii?Q?4q0B7GSh6ccb4Pw95vy2l8ByaD2zpIVeYZ86IIEu53V2yzqsufbpt/n2SGRC?=
 =?us-ascii?Q?Vyv6kiC9BVHDU5sEEO0MwrmQwwAPgOrLj7gLXj5I1IvpREZWVn3tGJwcf2No?=
 =?us-ascii?Q?HUEWuTqNgDaynBVl8he5whnUA14Uva3SqYE+x7fv3ha2qZX2WsIaKnHVkVjr?=
 =?us-ascii?Q?67UC6atKEk4l3Cc+Z2xOfc16vZxpJmYFq+BtV8jXDLsW3FHL+FLVn0tmN5jW?=
 =?us-ascii?Q?JbOezlL3QPCQh2eDmUFKNwyyWZSVCAOjJY0XxN/kftFzP9NkyJ9r0rMKaToZ?=
 =?us-ascii?Q?i3zG1FSqnYXiUCargZiDyv6UWy8E2UtuLsetaoPhQiIMLqPgAQHx71K6n5gc?=
 =?us-ascii?Q?NpImvHxVrE/J9KOZOFer2EwTxnO++S42fbZ283+R3b93zhiCv20rXFeinH6l?=
 =?us-ascii?Q?Nymm2rxLk7VM5BRUy5O/O2uFEVNlgFSG9dtxAhhqN9QidaxnAKbNz3Cm75ar?=
 =?us-ascii?Q?ufomMx9YzHm9AUN3sGsG5LG7vgbFQO0pGCM3UqVNWGkNMcVo9coWuTH5Fkjm?=
 =?us-ascii?Q?2JdtEShZD9WdiN7u2exadEPGKCo5I40NIz9y0SwPnabciYC1GVW6lV7IpziQ?=
 =?us-ascii?Q?dISlbGZb30N7TvTQP6+XQKrQ606Yf4hlIdTnl85vX1rQWotY+ENN4zA+2Ptp?=
 =?us-ascii?Q?8WqB9JDpZATo2xcvSJ6R8ApkRladrlN1WFTkwX562FCt8uV4kSa8IBcRLAwM?=
 =?us-ascii?Q?a9xOvBlB9gTlPa0SZzRALnh6H2arlmtou0q96SjWPAgCHw9wh8pOgKFkLk3W?=
 =?us-ascii?Q?viohKCVukvwTHNtAgqRBEwFyM6sDpaAM6fbXHwFlp2c1FplFAUSYpQU/HjBE?=
 =?us-ascii?Q?WXIHjTVizUCSCHQwGb9DkEEz/M9xQqATEnrbhq1WzUl8KHIJxYlTil9ia4et?=
 =?us-ascii?Q?LcmQNESs+rfXERNpcIhH2H5IAbkWo4FxkV0p2VuozcFfeV7B5g8mAn+vPZNL?=
 =?us-ascii?Q?AMen171SynFYZLD1qxjqATQgcMPLJog9KS5E+Pyum78PiajB91v59g68cbQS?=
 =?us-ascii?Q?YVKGv81IXnQCMrjMpgZCvR/tGOBxZV0N57u99zcM90Jqxp0QpMBxvoghB0ZW?=
 =?us-ascii?Q?MmNfC3S2rH86IJLqiY58HZkftpPCNc51DSub2dVLisnOtvOOfAgc6BJEb13d?=
 =?us-ascii?Q?BJhFFF0qhw4j8zcgTUoFEul2gTSIIUWU409uNxVDv3X4564npNwpon6MfqNY?=
 =?us-ascii?Q?DflZeZFiyrjmPClewZZHzat8nxZsPCBodU+AojIBJDWBI7IX0msqhG5IADGe?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a91ff2-739d-41ff-5458-08dc1c347ba5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 16:58:12.0793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LiIex2dwKUaCEUB8/jR4EOMo4iBSJjRt+WPysJcv5GlqZh/aRz4enp9/KHWUbTNoqznisPlFUxeuRXFVJJc7Sa5frlWwm1tnA+JUValtdQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4673
X-Proofpoint-GUID: Gk2lxkVcu14qDdMBdgsZpSoSfN80qxHV
X-Proofpoint-ORIG-GUID: Gk2lxkVcu14qDdMBdgsZpSoSfN80qxHV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_09,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=906 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230124

From: Ovidiu Panait <ovidiu.panait@windriver.com>

Since commit [1], FSL_PAMU initialization on t4240rdb board fails
with: "fsl-pamu-domain: pamu_domain_init: Can't register iommu device".

Commit [1] changed the behavior for drivers that set ops->default_domain,
as the function iommu_group_alloc_default_domain() is now called with
"req_type == IOMMU_DOMAIN_IDENTITY", rather than "req_type == 0". This
causes the following EINVAL condition to be hit during FSL_PAMU
initialization:
  ...
       if (ops->default_domain) {
               if (req_type)
                       return ERR_PTR(-EINVAL);
               return ops->default_domain;
       }
  ...

To avoid this issue when ops->default_domain != NULL, remove the check for
non-zero req_type and always return the proper default domain, as set in
the driver.

  [1] 0f6a90436a57 ("iommu: Do not use IOMMU_DOMAIN_DMA [...]")

Fixes: 0f6a90436a57 ("iommu: Do not use IOMMU_DOMAIN_DMA if CONFIG_IOMMU_DMA is not enabled")
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
---
 drivers/iommu/iommu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 68e648b55767..8e79a074e560 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1798,11 +1798,8 @@ iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 	 * domain. This should always be either an IDENTITY/BLOCKED/PLATFORM
 	 * domain. Do not use in new drivers.
 	 */
-	if (ops->default_domain) {
-		if (req_type)
-			return ERR_PTR(-EINVAL);
+	if (ops->default_domain)
 		return ops->default_domain;
-	}
 
 	if (req_type)
 		return __iommu_group_alloc_default_domain(group, req_type);
-- 
2.34.1


