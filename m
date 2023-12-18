Return-Path: <linux-kernel+bounces-4087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B78A8177CE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D22EB216B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E1E42392;
	Mon, 18 Dec 2023 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="dk0xO8v5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B0A1DFCC;
	Mon, 18 Dec 2023 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI66tjS010877;
	Mon, 18 Dec 2023 08:46:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	PPS06212021; bh=kdh0U9w0IS6JpIYANvv8liQo8F02Qv+YSEZe7gV8cJY=; b=
	dk0xO8v5Olzs37dAT2YD7ibHPUNbYwIPyBY1Cc7WJ6EDwnmYq6l/5trB+OJXTq+f
	2njh+j3TnihiJnEOR4cFFYo0GSGnEXHaMSmHypHPaGZkj1DBf7mlBqKm+AMlYGul
	SX5FKzzHDqo0a0a9v3+XoD5GQdLxjUfkjNUOIiTYobdZTOwXJ4nXvWJ5bGqPMJeU
	+CDIoVBI2ykhauhFO+pzCffPFpBEDYP8qzTvnJ/Hv48C9pvaJaAZmAXWM5SYnURv
	78GF/2CYEWVceMSlGAgtb8jNnMDsqwFNZ7o5bjzD52KezYu4e4pykbyG3LMtzK6U
	rowbpubzJav8kmQosDvxEw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v1c9khtrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 08:46:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4/wXD5HOI46W0enMOKNWZ6PCmVsR+H0iAoOUWIDk5n1j4UulCnnSXNprvbwJ4YEh//T/9quArrf6pVU+dtYZh8WFLH1UYpQ/aTxZpr4LvPTaELkciy03K/qzDmjRWMKN9MHuDmF2Wky51o+pPtZmMGYmkInQqeKuhqQaVdXvbC49oiUjDnFZgiJEWmsoxUEoffAsHEPRB+OZwi/NGE9lD4jbthHURQu2/3GLh5RKgaNb0jYqg2dseo20x2KyEQpF2gNia9y6hIg407uE8dPmIESxWQR+H+lATyjvfpkuW6ucJoo+Tuhy8dN0abbB+vjeO0oNrZ0RgaIKrKlE/Pjuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdh0U9w0IS6JpIYANvv8liQo8F02Qv+YSEZe7gV8cJY=;
 b=Jl5WDciaEMkqyWXmIhuW0o8/dzZoXEwlA6UUyTnEpv0Ep698nDH93NnIKTbyWUNflCF+9fTuSJ/WC3XmFvdaoHbpEBOWRypUulBgJalgRQjI5r448Ai1gwef7RHzbI9KuVF9rMujXkRNbFv7xop5Cmo1/nFu8ll+yxxytMJllQx8Ynw7KV2uYZlJxzQG/Uqg+K3X9Y4Zpyx9Wac8MdYKTZvlU9aDYhihUpmmTKq4gou8lzac1IplEYsctfEiWxLK1KT66pA5sVbnPS34rqc2KKJX5xHU/2CQRPRVVkMJE05HGrb0XO2HHyfqUY0Osdj9EnQBaLB8GrlenOMZHhAsEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by SA3PR11MB7978.namprd11.prod.outlook.com (2603:10b6:806:2fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 16:46:15 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::7c2e:5b95:fdc2:30e]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::7c2e:5b95:fdc2:30e%3]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 16:46:15 +0000
From: ovidiu.panait@windriver.com
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, Ovidiu Panait <ovidiu.panait@windriver.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 2/7] crypto: amlogic - Use helper to set reqsize
Date: Mon, 18 Dec 2023 18:46:44 +0200
Message-Id: <20231218164649.2492465-2-ovidiu.panait@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: c8d6b6e4-12c5-4096-3823-08dbffe8d9e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bl5eKWhK5zCs9jaIfUp4j+OSha+tNftt8RA8k9QgwTAujOugIF+UrAp9DhPSqj1pJXygNgmc51VDOc1nprLI5Q6trgS56ZXtkb68tN1eUzC2ck/d+lN6mdLbmlTyn3ZKbDh/3muhfvipc0BuM4jmp0GqkVyuggOqTApUvtiAJ43kl1xnniBvpDL9hBBgqPUtG3b6o+LDaT2B3M5CK8x06K9TOeoQ/HEn1CUlzfyLBT67VVOoVd8zGAMu0XKlzEPxUZjVwweqePGTOpNomNo7qtlBWZxcNamqm+G1W4aNNUG8ArHmRl/ev5XJMU47/NypH6q63A6pSn4nfUSRy5UCsjBTGpL9/+PL87mGj4xavXfMCqK2xYq2ZqD2Yvb2UGBEXmAXj/2+0wvPq/UXfAjCdBJK+jiCftG172avOYHw49bLnVeBlDlm5exupqVzZnA8NxtW9mHp0CEWjm/AHpaab2YzVu8GbDOuAzW+PaQWNy+rsGeWfPQwM6DKvMtSPLGZgUv7FteEW+Jciq665xbxRX5sKAc5LJ8CZpDFUlFp7pz+utoPRQ4jUMbDQrLyzr7q1Ug7TX4dG1xVtjQaJ34DpOGgXtDfzYt5Q8NEXOEYg0sxWMyzJWvzCZmJP5H4xysu
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39850400004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(86362001)(41300700001)(38100700002)(478600001)(6486002)(8936002)(8676002)(2616005)(4326008)(66946007)(66556008)(5660300002)(66476007)(54906003)(6916009)(316002)(4744005)(1076003)(2906002)(26005)(6506007)(6666004)(9686003)(6512007)(52116002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qarAl9kyLR+Wwoljvntz63QSm1Bwo9V7droVBmkXF5jRMacdbnk2MT7moShk?=
 =?us-ascii?Q?nD1BNsmQfzbVeGSPJ+0I1TSW8YE7/bobadiLsp0LGx9E9HPGQF/mhJYyuU+L?=
 =?us-ascii?Q?KdIuKHERppMI21OakCGZKAYroCy3v3b6QMa+3+W99E+C14REl00qJr1svpBl?=
 =?us-ascii?Q?Kx4zRrvYKYTn3a5rfIpFfagIl54nHvYMuyZILa9KTgoPQp1HYf3OgsUQGGG8?=
 =?us-ascii?Q?eIsVkOLDlUldUPGb/sySJasvHyb7c/DcEc8E3yX3OsnIlYCscSkBcHhU8nfd?=
 =?us-ascii?Q?O4iTbUh+USlcWiFB5ellcarWcena7UTNsaCw1WtBl1TOhtqmEFNbVGIoLwJu?=
 =?us-ascii?Q?eb2u+xelp4eySoqHrIpM5/33pnLsoW49aSI7ikapTjXVey0UJo91m1Hf279g?=
 =?us-ascii?Q?9Q3A3ey9BsNSI+skxmbawkUtv3ZPD0NbUl/pr7gT6igsOS+lGge3LOzLdjtQ?=
 =?us-ascii?Q?Jr/G1vUf1nh09Mjhv2xUbv7obELkfMT16cMigZerQjTpKeUjklbkUl/Vi76X?=
 =?us-ascii?Q?EDsp1CGQ1N9PkjOZhsPLrew1C7U3TL7XB5BNhBK6VAN+4TdvQ5ri06UH3/ny?=
 =?us-ascii?Q?9GX/VWBtFb4YnBEvyh+U/vSd3F/TJwrfazL55HmB7TVAfz8Uv+Xb5xV2OkGt?=
 =?us-ascii?Q?rcxc09trRBEJM/WFLCf83KiFrnH5W18gIVK1yd14Ne4JjyEi8WUdGDvp6Wo4?=
 =?us-ascii?Q?t+9mABDyL9P3zG65UVl2ax0+pUZQqHgw+qclkb5kYTGYbYS7GwNWM5HcsIU1?=
 =?us-ascii?Q?cXlcCilwTEDZfrvn8f+XB76WPp0Dkmq65zV4sbj/lCTnQmTRV1UIhrSgxL/M?=
 =?us-ascii?Q?Krk5HQr4Cb0Nh4Pn+EwijYVWTJzhUfyDRxhjdCMrfEb/LZQW5q8deAZrY9ij?=
 =?us-ascii?Q?s+oyA3SETiJY41K4AXkyiF2T/55cu1Hiv+s6t1Ye9tLXzD7WhOzMfw8mIB+g?=
 =?us-ascii?Q?Ggph2t451xILaXU8yGqdQWEWOk9pTjfbobBdt/2cQeK70QN4xatTPdHuroEs?=
 =?us-ascii?Q?/oh4FEpfgClWwD6PPEVvW+jJw0lX0D74cpkRq3clh/udRPV0gn2D5Na7qfR9?=
 =?us-ascii?Q?GkY0sqZgJo6ePGdGNs8gAYx25L1RHWHVFB7DSrEbXgF7i6HOYJ4XKWvj/En8?=
 =?us-ascii?Q?i9D5J4jAJ7ZootonS8rMUrayXMu/dZu8nksXSGw8GQ0c0j9FxbggthkpCQt6?=
 =?us-ascii?Q?Eq0hG2jMfEN4MUm7aQ21eqKwFN6ju340QAesS+aZGZTxKgFB67aJAD7NlPsC?=
 =?us-ascii?Q?uj/0vqbU1WQteOmPZe2k/C5GUQfCIaLac93n+ZaSSzpiDMLFO8K1wvJ9XI95?=
 =?us-ascii?Q?p4gUqQ6ESOqD1Kcnt5VW1EU6trlx/4XUaGeYrUjCl3VLXfgOACEY2IX7cGAB?=
 =?us-ascii?Q?V4sKQqA9axa+gqh6TPoCcFd3m0qMSDB0wWqWynJlXi1CgkR/i0pz1gXtOmEj?=
 =?us-ascii?Q?rc1lu+W6FaltV+fxPEnCHpfMye4Ejie+JOPOFilonRPMqquX/QT6ZnYWglXO?=
 =?us-ascii?Q?LlYMw8FszS3VVxUKlKT+ynj9HujCqGXr4FJdcglKoT5wu/jSdcW6wryqk6ui?=
 =?us-ascii?Q?e6BlCFd6YWhTtX4SuzaJB0ANi48CwDWovoA6b/oAchpLYTMJp9m3GyR09hbD?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d6b6e4-12c5-4096-3823-08dbffe8d9e3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 16:46:15.8888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kVIdO929NVnBmylLuBVQc3NucPAv3b/yyez0RYQiGoV6bELhDzR7djzVlr9wOM6GqcJh+foFSEkT2c6J3D2SNvuVVCUINemo0lJ2DgEis0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7978
X-Proofpoint-GUID: P7gZVqs8XdbLnd8SM9vb21FmBx2itsL8
X-Proofpoint-ORIG-GUID: P7gZVqs8XdbLnd8SM9vb21FmBx2itsL8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=747 clxscore=1011 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180123

From: Ovidiu Panait <ovidiu.panait@windriver.com>

The value of reqsize must only be changed through the helper.

Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
---
Cc: Corentin Labbe <clabbe@baylibre.com>
Cc: linux-amlogic@lists.infradead.org

 drivers/crypto/amlogic/amlogic-gxl-cipher.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
index 3308406612fc..29048da6f50a 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
@@ -327,8 +327,8 @@ int meson_cipher_init(struct crypto_tfm *tfm)
 		return PTR_ERR(op->fallback_tfm);
 	}
 
-	sktfm->reqsize = sizeof(struct meson_cipher_req_ctx) +
-			 crypto_skcipher_reqsize(op->fallback_tfm);
+	crypto_skcipher_set_reqsize(sktfm, sizeof(struct meson_cipher_req_ctx) +
+				    crypto_skcipher_reqsize(op->fallback_tfm));
 
 	return 0;
 }
-- 
2.34.1


