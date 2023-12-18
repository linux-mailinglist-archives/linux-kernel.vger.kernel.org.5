Return-Path: <linux-kernel+bounces-4092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0D98177D9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42135284F74
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841CF5BFA4;
	Mon, 18 Dec 2023 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="q/sQKBc6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72E75D722;
	Mon, 18 Dec 2023 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BICTwAx017142;
	Mon, 18 Dec 2023 08:46:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	PPS06212021; bh=H17ct7uQxZ7lZUmCp+Es7FCGdOt2nSzZ7r/MDXDxAGw=; b=
	q/sQKBc6CJOuu2PE2JcyIxPC7ZL2TlMLNa6gmD4nT0fRaTo5YAnCRe0PKsqrbN5i
	EHsKPhIUviUp57ujZHp3zBOoRjDXY6h7SlWTI888V9Gn4IRjaDnG86VUEV5rFXCQ
	052QVJhFUbqc+fnhCzIUy+h9qIfsM1c3rFq+xxGjfCaRkZ+1pC0nXmnt2xyHBlZu
	EGNh0RuAYjhYLQ64lXZ2v5nDcO5+jhL4QKdX57V+28f2R7SudQAZu6eJmRmYTSDS
	VwdgA5vt5bhKlt/afl2zZ8HH4MtVxiJVuY6R2HEddK20tl2EJ77eWcnqMcntndrN
	D0RsWWg8d5/bW/KBTNDSOQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v1824hysn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 08:46:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lje3DQi2hqqqmxZJ+MLDg0r1DPcNBf7S6YOoyy8pNfCVvsGD3h1PrlzYb6jUr56GyFLmTSSLMSRtthwp80YShjMde2RHWc6x4DrVdtIELVC7itFQIv4/jf32l502uivLJw9FH/NuUl+oStoUmf8VRNoeHbXWrSMoPPQw4RBYQ63b1My6rDwe9NMZx+TzC/ULVtPVKxUi3ZVv07201h5KQuo5paqtgjL2JrxD6Z68DvISu1u5mBqDoLvPNWvCduz0h5H5s30BiesWN0LbNf7Odemm/av9kmDBEddYC3/ogQ9EAeAxRdgAqFFeEUYNMreT4UzRXQsa86VLvwRGTvi1BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H17ct7uQxZ7lZUmCp+Es7FCGdOt2nSzZ7r/MDXDxAGw=;
 b=H3TR3SZA66Y6mwFXFPJqfO0GvOeKy7PrndC4HREt9+nExw2cCLhhjYYETWOp4bLep5NCVGK0mQUnovsxkNXfWGq6HvtdCL+EcKCfUb72CgQNgfuav8hv1JyIb7y5996N3LkGBceBPq9+QARfw+gs6p5c6Hbq3cdaxZObEI6GvK3J27qPLkpLnpSBWCxsAWVnv6K2ZUXdQvx8FNU4OSGP5dS73ah09N3MWgDe7Vw6qfAjDr1tWTDLxRIADQh0IMiLNYDkRlj0g/fajn6MI3W3I8tJVV+MioxaFe9akK5XVChHMAsjkxNoa7mwSKciIvJWMwfB0rrW2pxfWFp/ngGJlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by SA3PR11MB7978.namprd11.prod.outlook.com (2603:10b6:806:2fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 16:46:26 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::7c2e:5b95:fdc2:30e]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::7c2e:5b95:fdc2:30e%3]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 16:46:26 +0000
From: ovidiu.panait@windriver.com
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, Ovidiu Panait <ovidiu.panait@windriver.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 6/7] crypto: sun8i-ce - Use helper to set reqsize
Date: Mon, 18 Dec 2023 18:46:48 +0200
Message-Id: <20231218164649.2492465-6-ovidiu.panait@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: a87d5fd8-3125-435c-31b2-08dbffe8e017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FSIdZpHemU3t6Qxx9fSKB9kpHBO8Dlopabt920ESrWIuCbrmBsqWK2BEhPReGuAE4zml63aQikuh6Lfzc8euqvlDmB0g0cDtnjkmlrMnO9LAyzWwUN8qFho+V6Ot9v22wFD9AFPMRQi+vGuUqALxSjPRvZEVYLDhc6yrqNdbTRDDbhwhLYzvSID8NRhQbwWVSrMmIxmdwOdD4IRkLyz2wxnAOLa2O9oDipynd8+2pmTeiuJxBEF2rhEIBKnhWRs2SlRwosTk5Vkoak7PtHTtbJbWOGBJ1nwt9Y+4jNCaF3Ex/fqg3+6SWNv6SPPe8pV5aGfRCGKXQWr58y7qO+bcsJmOw976PmGFdRvTE7PSY3E/DJJ1F6X0sgt3HRnbYE1p2vKvsOfkLiKcK7xrrDmlyXAkE2lcFvKwwK9+fyuaqhwNuFFEHJOrvKLIYY7JQqoGX9VHVefTSfpKiZAlF2jsYgaA7MZZ7nATl67q2sael6xFwx8aPG7wCqS7Nvu0ZGNKRMAtXbhkKS+eCFHR5ujyfHcZ0xMkdI+R/MK3OzTnWeBZAmf7UWd0d2JA4gF+pTEekUa9jHFTGlGEXe+d68GWDxtTXBZSlYI4Xu6QT0FGVMx/YrtvC4/j4YVI7duORBkc2bSkDzsodOSu14zsyFz5OQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39850400004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(86362001)(41300700001)(38100700002)(478600001)(6486002)(8936002)(8676002)(2616005)(4326008)(66946007)(66556008)(5660300002)(66476007)(54906003)(6916009)(316002)(1076003)(7416002)(2906002)(26005)(6506007)(6666004)(9686003)(6512007)(52116002)(36756003)(38350700005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YsqXcRU3gwh0eDqGWTsAoLACZOBmbUXV3QRxOvhpFRCR28KsokjouuYFbSVF?=
 =?us-ascii?Q?n5c4vLRYLW51hF/L9+pfXpFtr5h7Hjb2OAuZs0vvS6Pf37CFeY2TbMLpMMbZ?=
 =?us-ascii?Q?Qcv6F9DIvCLu6dy0UxIWbzHC/saUHyy+LtgTuRTj5OFqu+biGWv4f6ozMabn?=
 =?us-ascii?Q?nqpI5X70gaXqaS6GVHaLnRvLMGJE9+EAKRH5Co3aTwJn9BTmge8w+RlOPRc7?=
 =?us-ascii?Q?1p6qIOBAofPlNFkNWAX0Eci+7iWTqa6JzU/2WVyZAdhilZd1MK+5oxDKOIXF?=
 =?us-ascii?Q?kvAQpXk/ehEMTy5NAo8sQrvm9DQ5gM/AgPCY2B/XPi8PFzaw6cZS8V5Q2ifY?=
 =?us-ascii?Q?AFaWMBv5BjUqauOC4DLy7XtkXzVSy61EExKeuE4oKel8fBDGdOrTcOuHZNcm?=
 =?us-ascii?Q?lalvls/gj5cvfEYr4RyWzdP4yt+770QrQDLfBV+YhxNsmxxtgs8lTHrSuper?=
 =?us-ascii?Q?S8JDA+fV42NK3k5sxNW28LStGBuro/fWmQY4f8l1Sqy9eNJOcp6w7N6XjerW?=
 =?us-ascii?Q?8I4loGKZ6FwrneVm0u/6/0GUoCM2AyJyCpK49mI+bjC0W7L/Y0Cvopw30dBf?=
 =?us-ascii?Q?vyamDKXAAWl7lwhLQ23gA+LLelDXrWnB0sWRRYbjiKwI+GLr6h4I8TxRIM88?=
 =?us-ascii?Q?atjxSsTnQ3v8oMEytRuAB4vZWnXh8zdcS6OEsp1xAOHoThggjasxPh4JxWhr?=
 =?us-ascii?Q?bk6d2jO8o++6FSaj2K2Bk70HDzt2Jl8AnR6DNrXOHR8EkktnqibPCt8C+y9F?=
 =?us-ascii?Q?4Pg0zwzb/WtSMI0v/znkfUObYCfnLXKYoPaeB5IGj0ARo0g2K5Biah/Bml1k?=
 =?us-ascii?Q?yYh8Uf2CDYb3sO2Fd/t4LIya/PtBib3VgGwVZjuK9lIs4nIV3Sw7yMSXzIdq?=
 =?us-ascii?Q?QUvZTuOTWWdL3XYG+KUV2R2JapHO6wMGsc6koHGcPQubCV+ymUQlHjclnFoF?=
 =?us-ascii?Q?IpazSwz5QSydBVImm00QvuGHVVwsHI19eFx5wB+Z4MvXSRtwskd25y/yG+4D?=
 =?us-ascii?Q?loJqHcoASa4Qf7+sp9eBrKHzGwmyN0SQEmuE3IV1RxkChxTu5nrBiMKlb5sa?=
 =?us-ascii?Q?LokmTUWBBGC0stZp7MsBIGToHYXS4Zf0w07Mo23j6z7KWxESNlsA1CEO2srp?=
 =?us-ascii?Q?Hi0TjoiN0liQUsTAzWx7GqjC7+YV8C/4WwTSiqBHJ+9F/6vUfDYCi6mIP/MA?=
 =?us-ascii?Q?Voy9MJilPdh/mzjjQ2EQPgUDF9099H8faxxNrLctNg0NVVui7iCfgZ0EPPNP?=
 =?us-ascii?Q?AN/0y0ArBRgS1Y4xURgix+ZiSdmsE6Kw62jgFaPKMJlhbPI1gZ3gYDUk7fFa?=
 =?us-ascii?Q?2FDiLnsUXINeHJERd+cjKQedqZ38Tl8Qu88x1FhccnM+yHHDtWYokQHnCUKo?=
 =?us-ascii?Q?AGpKnYC/DiW18tOtpGv/01ACVkDQk0NiXoioRK94xCX4mHWwfX9UKkAduzE8?=
 =?us-ascii?Q?wzP3peasX1AOaAIWGG+M3bswT8j6tAWFE/faczi7z0AgkGzkw36NiIZozvVn?=
 =?us-ascii?Q?/tzxuqMUKunvNjheCHXFHUS5M8rtOk2tuZRIf0Q6KJEZNORsvzBxv8wCxtnd?=
 =?us-ascii?Q?oxsnNXTSXdwfP5t3kbwwVSNG0jw9GZ9LfUcR/2cVMewyCfVXi1N4Uncb/aJC?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87d5fd8-3125-435c-31b2-08dbffe8e017
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 16:46:26.2899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LerlGV8yM1UMjWCiJeliswbq0xGd4elaaJSZLJaYnuRbUaW5DhKaIc09WZuPciVjlWp1SSdDyfU9V48PXOgng/S99p9cStQEutda7JZTP0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7978
X-Proofpoint-ORIG-GUID: sR4_7YqfGjutKO6wdkg65tlbLHQqrlor
X-Proofpoint-GUID: sR4_7YqfGjutKO6wdkg65tlbLHQqrlor
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=702 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
index 8d4c42863a62..1262a7773ef3 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
@@ -431,8 +431,8 @@ int sun8i_ce_cipher_init(struct crypto_tfm *tfm)
 		return PTR_ERR(op->fallback_tfm);
 	}
 
-	sktfm->reqsize = sizeof(struct sun8i_cipher_req_ctx) +
-			 crypto_skcipher_reqsize(op->fallback_tfm);
+	crypto_skcipher_set_reqsize(sktfm, sizeof(struct sun8i_cipher_req_ctx) +
+				    crypto_skcipher_reqsize(op->fallback_tfm));
 
 	memcpy(algt->fbname,
 	       crypto_tfm_alg_driver_name(crypto_skcipher_tfm(op->fallback_tfm)),
-- 
2.34.1


