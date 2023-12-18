Return-Path: <linux-kernel+bounces-4093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC67F8177DB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603F31F24F59
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED584FF61;
	Mon, 18 Dec 2023 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="sBDBoOv/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2538E5D730;
	Mon, 18 Dec 2023 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BICUKJU022106;
	Mon, 18 Dec 2023 08:46:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	PPS06212021; bh=DyTVn1nmqwRrTBFhQQu+VqBDWSypH7+lqsGqD1HShDE=; b=
	sBDBoOv/E4r5LT8+LPG+D9Fdam/6NRPk01CSr/Ypc1m3xYQZ4GfsWRhdNxlgSP2+
	Djl2RtfkNf4L0OKPYpjQPBu3hTX1NkY/3PNMD8mW+Q30CXZ+y2Yy0tB95bLVKDj2
	nxtf2cpajh7IdQ6I48n/Xmcakscxmu1nYS6EeXMSJsmd+uAv9uM0EnJ8ZWu85Tt/
	h098t/bd/6su62Gte5lZ6sSB32/fmWONEmAn1eK00KROaR0cCsKHJPqZoNi3LhnJ
	lbNbiXdynvEaikYMdif5LDU5OEyGrcFXZQxWgTDrwdtVS9PtZJD6PTlVYe0XhG/+
	ljU5iNhMqPgN1HGcwLbDzg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v1c9khts5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 08:46:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYJJZzK5oepELzzf88WB1C9zkDEobmAwP4YqZ1U7IZhwcg2nqUtQjeYZADJZwqb3fWOppzxsJNieaRf/dLEWWChgBVZn4wWoyBE7agJxJmFehkew776JH1Au86oSwI7QHxv3qSjcLcc+IKxyyP9aD/3kQghvclu7KCSuTZr+YmflzBECFW8U21YL7I1W26WBAPbp04rgrVX6DfMKUT8pEiCJac2Em2haB0pfI8HUtTOh9k4eV5ekTfFyfQp10OcY7evRIer4WOo/plq5YqpYvUypXX4KESUP99yBrhuEMM2AYz2JqyKDy672w+OikVEGBQoGGh1+r0LjXWYbgKu2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyTVn1nmqwRrTBFhQQu+VqBDWSypH7+lqsGqD1HShDE=;
 b=AJZpZ245wZ8MZ+5Vhm1y1YNMknrASk4PcSJ7DJ9F8V9z/MkwZnbpZAI+yVc2Uq+GgIrMY0DhbsqL7MaX4pbGEj66tNJRtEA6kw/jl5A+s6ykW4uqqMOpX++gvE9YRvnbCmxjHdyFm94YtQhBxwn9ynJh2kOiIhAxZk0ek2BQMQ+YKbisOIozp/wygNi8msKiHPPr6zm9F5xEXsaIkQmsKNNqCjdB53xfVl0AoBEyzZ2Bhi4Q+6wmIFilaX5QVPii9xadLuxt8/+Jt28FxbY60rCfv/s1ExaNbj6wpNX+Mzei3UJQH71vkTfYm7f4IY0ZCa5ccAZLF4Nz73Z7mqvzBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by SA3PR11MB7978.namprd11.prod.outlook.com (2603:10b6:806:2fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 16:46:29 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::7c2e:5b95:fdc2:30e]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::7c2e:5b95:fdc2:30e%3]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 16:46:29 +0000
From: ovidiu.panait@windriver.com
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, Ovidiu Panait <ovidiu.panait@windriver.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 7/7] crypto: sun8i-ss - Use helper to set reqsize
Date: Mon, 18 Dec 2023 18:46:49 +0200
Message-Id: <20231218164649.2492465-7-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218164649.2492465-1-ovidiu.panait@windriver.com>
References: <20231218164649.2492465-1-ovidiu.panait@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::33) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5327:EE_|SA3PR11MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 35357026-b128-4f10-4c56-08dbffe8e1d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hoRBHJaECf9S9cpkIXWW+lEZEnH6IvKprEbu5/nQfZTp/FwtLI/xzgzn2rjZP7fkrO1625fXSagyhx8oF3L/Ldz/YLRERe+mCyGgVqBL5Hl9g6brmlDJlOoRrpe/HHfQpeU4VFJx5uCj2a5Sxy/WHOJIkBhKaEQes/+5lsn6qZDw0UFZq33xhaUILScIXJgAjn+0yxew5RLYU9MrNa2I1xdSwjk9cEGGvi5GhtVDUuQMy2KL4O5DWFXGJm+4zqgJGedd1XycgF4WmAbA0c0NsLVpDXukZ/7X1Bwo57BbiAAUSY12KdWuLOK0YlYfOO1BJPVyjOJPBPYED2XyLozkYXG3LRTGML/fi0Wyit1hqFDy0qgEzZNmeJlnJqpq+raTHWQCqJSmC1fKozA44es/oki/IOSktAXfJtVMDNsTtuhYqQVz9Npcp6zpS1aFNWvUVF4UZft9/jfNZUxRBfYniOQEtbtwj3FdL+Jzp93fYIMzNocZ10PCJL5hNmwN8XZ5zdP6MtRkFLNOGKNkV3r/J44B2Jcic+SITVN8bZkDAYPMSf1xY7duHg9z27EVaRU+TjeYdAk83r1oFGS/vI8LmbDLvtUviZjP9xp4608CMLDtBVSGKx1Os3x4DiqPfuviCEdKbNsH1E8WEsDfenDkHQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39850400004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(86362001)(41300700001)(38100700002)(478600001)(6486002)(8936002)(8676002)(2616005)(4326008)(66946007)(66556008)(5660300002)(66476007)(54906003)(6916009)(316002)(1076003)(7416002)(2906002)(26005)(6506007)(6666004)(9686003)(6512007)(52116002)(36756003)(38350700005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NaOuQ7Md+hhB/oJDyQnxT0zIuzXJX+MJ0FxzY9NQQRhyyIyac6LrDlJfzIT7?=
 =?us-ascii?Q?CvTlrwbMzjmHbnknj5rmVXd3SRpJf5pjaZIMJK6dom+c9CNgxLrqMuE6bBHt?=
 =?us-ascii?Q?kw795RMVCnDgBx0jFzKnTkstnLQTeyAuynMOvEoOHWwRXvmCbFHElGklTpTF?=
 =?us-ascii?Q?hCxxUU8aN7ar8pGaPkqIlWp+yDK9tA49egMk9iTrKbZvKAoxgxCaVf2Bbd9i?=
 =?us-ascii?Q?6gdtbB/28KBRPaqY2YQb5ljB1mtwzfI01nb1Oj0hL2SjyySvPxp3fdln8EVt?=
 =?us-ascii?Q?6Pc4aLR5DUEggmugmlU/nYrsFNOayFso9oU/9nE7tuMOnqjrA6nsRngyT/VK?=
 =?us-ascii?Q?QVL8pEF1T4G0XoKNCmVg5JipDihQrUIvM43CSl/HUq6E7PU/iPCwZU7RcbIh?=
 =?us-ascii?Q?eEp2sN6S1Mo8p4UbxlNUtns61obqJdreoDouLTYa5dETtrbO/SkPBFzBY4Qf?=
 =?us-ascii?Q?OdecHb9kdaYg2UghHrhgcQzaiPZOpCDTiLd1OBbgsC+kg+daI1p0U73sOexB?=
 =?us-ascii?Q?bXUQwFK7QkK+TQWcDVXL0+6UVMpC7yoSVCm4UXKuk6pmGQZlqLbDBIPqIxaZ?=
 =?us-ascii?Q?hcVIMvl3hgIqybUXE8qmAvfkFP+Pxe33M3AGcr4F0BrcGIron/tyYcKeXXnd?=
 =?us-ascii?Q?6N/OeszU8yNMrAbgzp9NhZQmkOskkBSP1m1TLZT7M24o8rJur7NKuBLTFKS4?=
 =?us-ascii?Q?BixLKC/+BiWrMLUWnR+gRYnd00FPKPA3X5tKEYTbAGPP29cTW84N+avAihvS?=
 =?us-ascii?Q?59sUUcsfjjD5BHZzrgUf6SBsUHtCCUErIHd9fQs+KutOGKzpP2+pKAPDvpVd?=
 =?us-ascii?Q?JHyxaG7My+xPuNQFBxIkXNNiyFI4UEzpha6Xc36/dHesE53A0FYlukSXKNBH?=
 =?us-ascii?Q?EyZleoOSexO4JOMqftpqNzemBoOrU/549e0Yv/zEFi2C0JB0xBsMq5EVTDAp?=
 =?us-ascii?Q?FYQnHBzTOTvlPbcVaBGZFOfYNnPhkM0uBOZLEQgex+24P3ufgJC05Ehx5UIX?=
 =?us-ascii?Q?mSxnfXbviQDb7sjh//ZnEp7C8TZ6NOE8zYQhj7zxwmEU6krT7KL8Z1mPKC9K?=
 =?us-ascii?Q?zkzcNr3RcQDIBrWLYryAadiLtUHb0vDu0IZN5uDIGMTEmkG5IOOGWata1CIz?=
 =?us-ascii?Q?tgIrSqLHX1K9EjDnOxqcnpWc2FH7/yaBrLh/HiWh0egE2DskGGzWc2r6fdR+?=
 =?us-ascii?Q?GFDsapoht7Vu+LGLOQTTdsKX39xnBp+jnt4CEYoyzWKLKKwIeXkUFhxOkWN8?=
 =?us-ascii?Q?9/zkg37Krebpoxao6iKSJLaSP2+G8NOO6/DjdddqfAl7slc4Njha69AvhcgZ?=
 =?us-ascii?Q?Yf4G7QrIr0fLnm6GQW+WxyvGxSP/B+UqEU5Ed/CashMlsU4xbRRMXqSbU9cy?=
 =?us-ascii?Q?J7ee0WFvbg9P/jHWhNeQixPHNtIHtKUbjaGGf+lFVn9qE13cqqTjPt/oLq4a?=
 =?us-ascii?Q?O+8rc3Vml3jrSMU2RcBwQuFFYohCd9h7R0X5sT5KDu/2JsuDiDRkFcPfPUp/?=
 =?us-ascii?Q?abNFtZhw3mVDNFhTwYeS1NJ5qRYZ7ekY9XiklkAGZyVAGFr0wfhJ+irjiZzV?=
 =?us-ascii?Q?xYnhci6gPyh6PYc4id/IHHDu9a7boBJDVsMrGgInDJ4szqoMnKCiU5qZ2FtW?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35357026-b128-4f10-4c56-08dbffe8e1d0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 16:46:29.1804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hv1yLRp2+s9xFiEto0rSoWzfKWrh+YrFUYob3qUx6NVG4WFWxW4k6GnT/S3va/n7cgeHYltkUnAZMwhTYa8E2nyOIgjANLD0vHGzACukNRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7978
X-Proofpoint-GUID: 82CgqN1gG-HhhdGgzLF36H6q1fE5Jr8d
X-Proofpoint-ORIG-GUID: 82CgqN1gG-HhhdGgzLF36H6q1fE5Jr8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=702 clxscore=1015 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180123

From: Ovidiu Panait <ovidiu.panait@windriver.com>

The value of reqsize must only be changed through the helper.

Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
---
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev

 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
index 7fa359725ec7..9b9605ce8ee6 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
@@ -405,9 +405,8 @@ int sun8i_ss_cipher_init(struct crypto_tfm *tfm)
 		return PTR_ERR(op->fallback_tfm);
 	}
 
-	sktfm->reqsize = sizeof(struct sun8i_cipher_req_ctx) +
-			 crypto_skcipher_reqsize(op->fallback_tfm);
-
+	crypto_skcipher_set_reqsize(sktfm, sizeof(struct sun8i_cipher_req_ctx) +
+				    crypto_skcipher_reqsize(op->fallback_tfm));
 
 	memcpy(algt->fbname,
 	       crypto_tfm_alg_driver_name(crypto_skcipher_tfm(op->fallback_tfm)),
-- 
2.34.1


