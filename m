Return-Path: <linux-kernel+bounces-4091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EB98177D7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF91284C16
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75DC5BFBC;
	Mon, 18 Dec 2023 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="kY3EiauW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A65E5BFA4;
	Mon, 18 Dec 2023 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI77r2T031764;
	Mon, 18 Dec 2023 16:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	PPS06212021; bh=e+rF8ROoF3L297yE2tRb9P3sgJ9dfcO4vdRnXGMg1cE=; b=
	kY3EiauWaZJGPnKH2Q//w+x5pOJTvp+mjhIBJluSdsV4rd844Y8odcrxdhQQbCsC
	xTV0AcXW/dzyPn1XC9b2w2oLQIresrjz9FUV2j0tpMtK2g3WA998uAiRlA2HEK8V
	JEW9WVSZWYjwQEbtYBeYUwXIBSWSxPxe9iRchGaIa3xcT5RyG02OQgUzjKe6m4Le
	mow5uB+FGaKZTV5XIol9oljI/GXvcpRCFCiDaq7cXZ6690coycxQ4YtD+fDX0D3H
	HUpQ1N6hKTwxYThlQ6hSXoFp72Ekd/zRH7EPCXyE3it+jDzD4pIwXaey8Xxm8UUY
	03OG2G0/v+D1jSurGp8/3Q==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v113xa8c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 16:46:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyerOn8CIfRxhLy2Rj8hvm2wlzw+33xG7Gp/ly5INDNE6XMRTQq97TbOGyAY+sTP2svaW10apglnaFlaIRqdsCREO0077ezjgD9RxwEi1o8NPOx93vp9dcM5Lsah3mZdDfnPSgM86SjhaCUzAmg8p2TOcrNloJHREWIakRjjxNoLM/8Kc7QTjbiX4+3iSn/dCOD9COye19BW5lkdbcPGIBzJ+iJQGE9YoMpHDrUKECI8I3whDtaSGW9Fti0o0CoNYp/iauICizOZJW8BIYzHUEiSHLV1YiQhLXbLwtUSbhRz/fWxnfN1sRJy4WlxLAYsYAmgf+3srr4TmWYuTpiFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+rF8ROoF3L297yE2tRb9P3sgJ9dfcO4vdRnXGMg1cE=;
 b=HILHBRgLVTbRAlZ/SUCqIWnkmWPtX0Zc3pmDOexRrmur21P59maqnpAT3gclSzfPRH5X22IF8yvSmHnPf9Htji/gHI0wZCG5K7k9z5R5tB5iQfWzSy119D0FXDuisgVN0hGibRbP6tgeguCod+38o+Z5/bQTpLbKhDh2+SnfpuSHin7+TtbKa5UxYqvH6xLjat+KHZH8XNlf9akBA4AtnrIpcYKfo3wiF6gXqdTmAoVXwq9btmXhEErONZ2ogA0YDMK5StSfD9IQICau9NpLtgpMV3pVvQHF0RxXd4ZoSwsn1+fbJXP0kTWIwjEeLzA7Ujw8GLgO6KrPgDR9Jtw2cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by SA3PR11MB7978.namprd11.prod.outlook.com (2603:10b6:806:2fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 16:46:20 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::7c2e:5b95:fdc2:30e]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::7c2e:5b95:fdc2:30e%3]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 16:46:20 +0000
From: ovidiu.panait@windriver.com
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, Ovidiu Panait <ovidiu.panait@windriver.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/7] crypto: stm32/cryp - Use helper to set reqsize
Date: Mon, 18 Dec 2023 18:46:46 +0200
Message-Id: <20231218164649.2492465-4-ovidiu.panait@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: ab9d6cff-ac1e-4589-ac4f-08dbffe8dcd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OFgi0gF5NzklUorB9M6s8G+rdMaZ6ZmfpNGzH+LYdTEW4kCQj6PXl9/qcxDBNWEwH+ZMe8V7F41JHQK8LtYFH3nGW+wKiBvEY+b/fWzU7XmZGKwv1nlk17uRxCXzxP6Z34aA0oPq04S6YgvMu8VqrgvK/VCTzAbQn/NO8Z2M6f0GIgLu/BmPL24CYmcRzA3Tka17x3W1rv3/ZzCEfdQzT6KMhjaThuRM361PC4cnwlVRrBUFDLfG4yKo43EOKxCXIM2l+yEUGvLwfMVZPTsw64QNJ5+DFFjYHB7Rez2HhUHxrws4a7UqRvwJPPWF2doSWdw/SpFxSL/49sCwmbYJoCkoj3ZpoADOpdLKX6dsVV6I0JRkViGSGyuK905Vn+y1hCVh8wQXYioldhLyYFW+wnHqYwbTF9Du0wxzjDKx2AEee+Xq/GcpF2R4/US7Rkyk0AE05KrPOLWZqFQDWkWCqfkq8gpD4NO8excv9/w113CccQ9FnU7/9dh9c+TNW8/FGlFVxSknzZBIBsen9mgL8LFvgiPUM7XztjOxPz24G2Lm4WMz0EJpVu+LppwNCIuhM/1r0dU3HmSAcoQeG16KqOaVl+7M98uyzHecvySm9L3d0EyQCYdRZFJtmEcOAqgy
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39850400004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(86362001)(41300700001)(38100700002)(478600001)(6486002)(8936002)(8676002)(2616005)(4326008)(66946007)(66556008)(5660300002)(66476007)(54906003)(6916009)(316002)(4744005)(1076003)(2906002)(26005)(6506007)(6666004)(9686003)(6512007)(52116002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Z74Wa1sPnbxJA8CyPQ/U1OxGqREpVMl/jNcN1VCJJtG9qrrIakRfaicBSvkb?=
 =?us-ascii?Q?eWaGMuB+7+ibmf0NaiynFUcUVm3S+FdzbjgXyrPG5hkV2xfQoQafmQBLVW0H?=
 =?us-ascii?Q?/DUzbd2E3jDYLnucdhevdYm7k2JdxAkszd5sKsNW3hm8pCghhATZ0CP817BB?=
 =?us-ascii?Q?3Ft+aw3VUxoCviJ3E3xR7XZ3mluqVUzRTWNyfHRfCYicRIt07GeopV1hKYrU?=
 =?us-ascii?Q?7BEL0lm6Mj15yx4dfCDm6V5EVPtWte69lKJB8aF1cb2e4ZGZSsSNhhHsBplb?=
 =?us-ascii?Q?rEcNRbf8sgso7cKwB0Hy0DiMmstjxJNDpLPfYRmJ1faX3fBmkQH7jTOLCmBF?=
 =?us-ascii?Q?DGcSdXmT6DxAycW5QXnU69ejcyT9avKhav7EpNTFBdgTOxs0g3RQ0wA0f090?=
 =?us-ascii?Q?CY6onjDMpFbf/4v++TBsVYV8xkHb95ag+kl13kDnplgAKhdePFkiaw7fBK/v?=
 =?us-ascii?Q?bUhIGi+sWcXYH0B7IhM24uKtABiH+TKOEHdd8e2lvU+uzCl11t3VPCFF1S9r?=
 =?us-ascii?Q?0fGgRsaIgvvAGexN03k19SYKTe4u7aRdIgD+Vefe8uMcU0sl0YVj/6f0gFfs?=
 =?us-ascii?Q?4oRDOrM8eZ7xM/5Fx8VPtAaJKU7KNzUztmsZJT1Zil/5UiiEy8fA9fGLWrGd?=
 =?us-ascii?Q?YRJqL2HbfU98MuyVE1fI5Ax0FqQ8W1M0tgHteRjb1eFNfFhiX91dDkSj3R27?=
 =?us-ascii?Q?4hxr/cOR/RTcH4FCLNcWjPjEQPr+nuybSFNdEXlGVa4L4IvR3PPBCJsLTeL0?=
 =?us-ascii?Q?BY0sOZ/ED53TcY65bbMR96mmnAZ4hW5q5DaMBu8TkXLzMWS+ACt4++RCrKxt?=
 =?us-ascii?Q?nm06G8SZN4UKB97GW3+uGOdRHlG/HIzWG6lpktBejx+DbJRaACRtRi0ezxzh?=
 =?us-ascii?Q?prtJ5Fc6ZmXYwSywdfobcp9yLtliXnUx0+/gA9lgn+JeOJa7n8E1PPNSj0ZU?=
 =?us-ascii?Q?1EOY+jdsiAHtqpd/mAWqn0FiIbJlYEUu2zNq6Bzr/fNPw/Vw5E12iSKDDqvr?=
 =?us-ascii?Q?0CxVvyx0SBqfYwj9N9Ww0CqLtzazbfIGmoCsOtQMy2zJQsfTJMPC2GBlYfYs?=
 =?us-ascii?Q?KJwsSlR8x+47FTT9tYbfqKb5wnLj/Aq7YCKIbJiYKwdjROLocFsmuy5kiHor?=
 =?us-ascii?Q?uOaSMhYWpWiV9OzrwxJHg48FSVXWGcNjtbMPXg7mAh3WOlPPKtx1B3X/7fnk?=
 =?us-ascii?Q?ZULCgcbcvbnZgy+lrYfWl4wfB/Zn56lqNhnInh19Tl3M2ZZMXcW0d3qr5Tx2?=
 =?us-ascii?Q?tAPzbUOowxMwb6Xb0Y1/xxgkCtpVEHrmLFL20besyeZ9JUEwHCZeTkT1Z05G?=
 =?us-ascii?Q?vpNc36t+Ayx/aMMMImMv+d71JoidfJqOjikvIKzW9PwBgoPVvfyzQvSIyier?=
 =?us-ascii?Q?ncQ40TtVSWUfklvjsd3lBpYIE18gm1kL44mAPrRqLEvMxpPY/WS6NqZS7C8M?=
 =?us-ascii?Q?MjPuniDaDCa9SsNj/ReQl2MQ+DZxnIJovNSP+HhdV6ObMZFCKUNFsT2Qk7/s?=
 =?us-ascii?Q?kvKODrinWSQ/ET4lMucpeCeQturNAY6RlVQo5YN5LYRLi44fzoR/BuuKU7Kb?=
 =?us-ascii?Q?Ax2kMXt/DJPzmF5P1VRb4+a+iH7hoKG+MKvI1EH1wig/XrnyinlUrMqW0XbI?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9d6cff-ac1e-4589-ac4f-08dbffe8dcd4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 16:46:20.8246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKTvLaljWIVwpdOR4QQ0JFuA8GlWRIM3p0sV34x/R3GQ3nPeWlwF8JY7Xq1WEixDveRiHDhvLbh/bmzXnWJGDjGh5yzdFtIi2Hda9/qRoFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7978
X-Proofpoint-ORIG-GUID: ZJZZ89pzk-g2GhQISCvlhFfhsaxPl72w
X-Proofpoint-GUID: ZJZZ89pzk-g2GhQISCvlhFfhsaxPl72w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=543 malwarescore=0 spamscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312180123

From: Ovidiu Panait <ovidiu.panait@windriver.com>

The value of reqsize must only be changed through the helper.

Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
---
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org

 drivers/crypto/stm32/stm32-cryp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
index c3cbc2673338..11ad4ffdce0d 100644
--- a/drivers/crypto/stm32/stm32-cryp.c
+++ b/drivers/crypto/stm32/stm32-cryp.c
@@ -838,7 +838,7 @@ static int stm32_cryp_aead_one_req(struct crypto_engine *engine, void *areq);
 
 static int stm32_cryp_aes_aead_init(struct crypto_aead *tfm)
 {
-	tfm->reqsize = sizeof(struct stm32_cryp_reqctx);
+	crypto_aead_set_reqsize(tfm, sizeof(struct stm32_cryp_reqctx));
 
 	return 0;
 }
-- 
2.34.1


