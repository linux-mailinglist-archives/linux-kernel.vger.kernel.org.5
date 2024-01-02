Return-Path: <linux-kernel+bounces-14391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7BC821C6C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11D12837AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D44FBE1;
	Tue,  2 Jan 2024 13:15:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2079.outbound.protection.outlook.com [40.107.239.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D030FBE2;
	Tue,  2 Jan 2024 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmCtO0ViOiSNOZIE5F6WrHopMvAef+sfkSJmFvFPJPf/tvocy6x99oInli+iq/WW/yYTcLZ9AA5rQynHilvrA5f3gRMusDqagjYS+RI+TN21d12LnfsKKWSeN+LM7AsaYn115TOG2mUqJZi1F2SRLW23QDSs7y25f0vMEvKMlsnq07UBxc3bPYh5Vhef1WdDcX37ZXx6JoIf+0mwlbHpOB2QRGNh7n/oGFebr1LbLbvKOnkfGiAEag6v0pNaMCCLDNBqh5jRK4hoCZFw9FHtHu8cGSOyNyUxViGMJbavLqA4bsTgI82niVl2pLkxGqSk0XC/mduC0bQgtIEqLAUbFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pk2k7HCUO2fW3r8o+R4rlpx/u5bswYcg4/m43ayJwdQ=;
 b=l3TzO/NOCT8cIH3ACK9Es7XT5ufHFBlJH5a69l6eUiZvZm/pdHT6lIvC11WEerQFRcIkVjLm4NJ1S2eS2tyCOIjaTrZHNM9sVIjyjqHOV5JB5HInECO8jTpHR4gZwVbokVV8QYfcunHommkNhxuA2UmCmNkp34TulvX3ID2UUEEBsntNETvqSDDCtQsMlEhjmk4lv+d3+OSrMltQ/146AbzQRE3UTJ5aCM7vGPjZkVEsUpWWOMQ/4nwesOauiSsrPE7sNPFjXI3ZV5cpI0WpXl2on9NFBEYlLaxMphs/UtBWNJTZN0Zp27v2Z0WxA993UImQ9hrBRwi1cok9vycU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3PR01MB10135.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1df::8)
 by MAZPR01MB7376.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:59::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 13:15:41 +0000
Received: from PN3PR01MB10135.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::e2fc:c41e:7375:e933]) by PN3PR01MB10135.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::e2fc:c41e:7375:e933%3]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 13:15:41 +0000
From: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To: stanimir.k.varbanov@gmail.com,
	quic_vgarodia@quicinc.com,
	agross@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	mchehab@kernel.org,
	quic_dikshita@quicinc.com
Cc: himanshu.bhavani@siliconsignals.io,
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
	linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: venus: use div64_u64() instead of do_div()
Date: Tue,  2 Jan 2024 18:45:09 +0530
Message-Id: <20240102131509.1733215-1-himanshu.bhavani@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::20) To PN3PR01MB10135.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1df::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB10135:EE_|MAZPR01MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: efdd9e03-e5cc-477d-c5ac-08dc0b94eb68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zjgWzbURvx6kv8VYV7+Sh5+aa1gG08b1qc06cKnNcWiY2mhdH+cwrejKTFkDUrat9usF5SKLlknCugxULEtzcFdAldkAiLYOPcJlxsC9P1MMrZbPuOlkq4h4GZ10jcHFlIypd91gnUeX6e6q+3b34g9yYl/vmZGpXdWzeKrcMYMQJ9vTqraUohhpdXwdhThfnsVH3KoHOmBMPQPcgAG9L6PodSgeqdeCNrQDAURmpO8qJLXTMHCYZs/0durwmHraGvrOEvdeY9milnT8muSsHNMN5wFJAwzJUSfjRDe6zM02QvtVYlHGJkJOzOz3b9nDp65EB7acFaBOIrOsy2X82ykuM4dq3bcOd0KFeeLH0hUcEqlGqHjSC+SobuS5NrBygWJexMh09Cg91PFPT+Ec+qjqqsOx/dS21pfbxPGlEn1v5d3SMP4F8bhSUiIvENcIYxFtdgPpEBzipA300OQ5WM4FBQqQTleO6QbbnKGWkvbPnSG1o6eP2esjzTf20WtHY63kI6L0jmOoHghxt4kxzqYuhYTdtOIEFAvvtDtbSQLqezp27bfAqFIvhxP5sMG7f/MmTv/5Pk/2MtACw62fp5NppbtavyQt1PAEaYP+Bf9hlFGN13ilA3zDWkH/Xz84SuInhEdX8k6on2XqcESap25XoyP4fO+ns1CHTYPlwLc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3PR01MB10135.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(396003)(376002)(136003)(346002)(366004)(230922051799003)(230273577357003)(230173577357003)(64100799003)(1800799012)(451199024)(186009)(6512007)(52116002)(6666004)(478600001)(6506007)(6486002)(83380400001)(26005)(1076003)(2616005)(7416002)(2906002)(41300700001)(66476007)(5660300002)(4326008)(8676002)(8936002)(66556008)(44832011)(66946007)(316002)(38100700002)(38350700005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bNxJMJFbXGuGI3khobvxl59izhEzDQ/Y55l00+2CoQnpW7NirtRefA3ioRHA?=
 =?us-ascii?Q?VnaM8QdCDKBCooVPK0pPXmwK7gGPcQ9jooO/4MfwDNx+8ebd8v6bx384GM5W?=
 =?us-ascii?Q?ArCg7mcb318nRGcDveSROJpyanBaf/hm49UO3fLYEj6OuL9QkOQKEID3LB9t?=
 =?us-ascii?Q?lSHc5VGJh69rbS5jPR2eTUgqPRkdQTohqcgMxggd/OTuj0FUdldO3lTXEIYN?=
 =?us-ascii?Q?YqXlnapI+6djd6thCQQ7NZxezT/JNi0PxYWyO5PDH4XHlAsTmHHeeALz0xbU?=
 =?us-ascii?Q?Abphjbg/zJwYABeBXZrc4eWa+aWeSfRAZKWQ1NznwoGvMGGAXYYTfzYrIL6C?=
 =?us-ascii?Q?WyVCatsw7/7jo8/ozkK9ULhSTYLF3VQ/lb6DikAH9dHcivusRYKUQYOQu9Z4?=
 =?us-ascii?Q?EIQKhEkTFh1u8W+Qw4Z114awps9OeMGlcy+QnMOr8Q0MT+U5PLjUUqdrSkRg?=
 =?us-ascii?Q?jVQOnXYIvjvsLyJw/0lbcTbd3gTVOStCn7t+fRZc/KZQjk4JkJWQmUuvh4ME?=
 =?us-ascii?Q?4nMoL6/pzgaiXLKICSzXttPYWhEgW+E1Lz+dP50kD7quX3JnqpoOrbQgDpzB?=
 =?us-ascii?Q?GbqFb5XZ5+n4I/TTBPlnK8c6RpnG8unTJWkw9OuWPAnn+qPIPDdRtQp9Sk6y?=
 =?us-ascii?Q?0YmfYV2AqmqlMtgQDxnXUPapxIXkSW+fL7reRFqurK7QULPJY01TYszLat1q?=
 =?us-ascii?Q?UZ3STLNB/EcIkm8X0nQ/mcFdnGWZK3kc3Alh+2dcexNNID4xgT7Dus/ugRDH?=
 =?us-ascii?Q?bMaJK5x1PbJ0vPYFvhRf7H+2hIRPO0vXmOaxcxQF+zPvfmkETKVRG7LWn8ua?=
 =?us-ascii?Q?KSl7YyIkr7qtTytVdVGsoygpVHHR5n9wTjJ7xY3cyswNm/CFABCYm197iPjq?=
 =?us-ascii?Q?SXlcRJyBJu5XrlabddRWw+B5UJ3zbaqv6lm9PwExw1kH/TSBMCtC5F6MLgyM?=
 =?us-ascii?Q?Tp50A/U0UUn3Snb8bq4ZXo8PJGGcIO9Jc5kyw1Eq1lpglzs8XP5ZuzPkJjdI?=
 =?us-ascii?Q?swgYaaztzUbSInZOEPLAkg5X1WS9aSZVsfe6sUR9vTTGRwLep9htwYxmtu/S?=
 =?us-ascii?Q?HfID3V2APm4t90V8HM4bFs2LVyA3NiVTQIKlGcygIVjcn2BCJE5r6lhsxusV?=
 =?us-ascii?Q?sfgSKE35RG61YUhQebrmSSCOhMrPAS0Yp5xzLBR1MWyRs1FG2cHB7OcTZKNk?=
 =?us-ascii?Q?DdV4DeSCH2HVjwiRbVDwhjmjYKVbWSYm98XsLCqA5D6lDwkAow70rPRqq61U?=
 =?us-ascii?Q?X2aihtQHbre0bQE+17UTlNNV1ms36/h9QrC5zqAj9jc8LgZP6p5UVc8CD99g?=
 =?us-ascii?Q?SjRkHhylaaYpKkcAlkCfXt/Pbpqq15BCwOo4hLyxjNISu4pC+bN2aUtA87KI?=
 =?us-ascii?Q?x0R4uCCmH+5FFLYBxo+WHp5bZWLm8Mu8W3gWg42GcjQJHS9i8l6J/OfciE82?=
 =?us-ascii?Q?XLD5o7EvBbVPC775Q8YtSBZVYfmPTBBiNRh78p0RdCHU1dcgv4YEZ/4QTXgf?=
 =?us-ascii?Q?aHizuNJ0AEXRdpObMntNaWF40h2oQoPi6ev6/kLeBr0nKNChzQ0Oapwq3S+X?=
 =?us-ascii?Q?XSWZaaFDRXq+tuOnyXH+AQ4HCNMGY5DUq2VHq4C32PMSsqLwNNPaPRSdUgWl?=
 =?us-ascii?Q?3mGqJbJ53/HxchX4HlzMdfU=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: efdd9e03-e5cc-477d-c5ac-08dc0b94eb68
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB10135.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 13:15:41.3505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nM3eJd84V2rLH225x1/rI60yyBqy7qR92w41PSonjQR4PHY48Lx2lKzlr5hUqeX8HHHzkKaHjqX2iW2wTU5i+ybPdf083StOS6hdsC6ZBDVCREc3RdlFjV8LGxIYD8w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7376

do_div() does a 64-by-32 division.
When the divisor is u64, do_div() truncates it to 32 bits,
this means it can test non-zero and be truncated to zero for
division.

fix do_div.cocci warning:
do_div() does a 64-by-32 division, please consider using div64_u64
instead.

Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
---
 drivers/media/platform/qcom/venus/venc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 44b13696cf82..ad6c31c272ac 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -409,13 +409,13 @@ static int venc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
 	out->capability = V4L2_CAP_TIMEPERFRAME;
 
 	us_per_frame = timeperframe->numerator * (u64)USEC_PER_SEC;
-	do_div(us_per_frame, timeperframe->denominator);
+	us_per_frame = div64_u64(us_per_frame, timeperframe->denominator);
 
 	if (!us_per_frame)
 		return -EINVAL;
 
 	fps = (u64)USEC_PER_SEC;
-	do_div(fps, us_per_frame);
+	fps = div64_u64(fps, us_per_frame);
 
 	inst->timeperframe = *timeperframe;
 	inst->fps = fps;
-- 
2.25.1


