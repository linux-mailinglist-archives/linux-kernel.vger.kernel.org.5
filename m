Return-Path: <linux-kernel+bounces-36294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FFF839E84
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B56B1F23B45
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795CC185A;
	Wed, 24 Jan 2024 02:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AyxMdf1O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qBXeOOIc"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01385468A;
	Wed, 24 Jan 2024 02:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706061743; cv=fail; b=VBBsq+sJotkadftylhy1vUI70k3txgRAqydLzr2F9rJZ1lcJE8q1Dfbg6RnTIL0tsv/AOQTnzU96r0G9+1YoC+j3YBGrMG+rCMQfgTOCm2UYcofq6SfrKnOX4KQ4V0wp+ChwsuW5vD05s3/dX4iI1WiRX0NbxekDJvzcY3T7gS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706061743; c=relaxed/simple;
	bh=i5iK8DPyDTICGfBH5mAD84WRB4grYwxoiVt/wlGsAV0=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=UaPXHBjqm0N3exhNF8t2+5xjvkBYHomjQN0c5a8Izpx7ZcyKxKCHYSiHeysoSQH1uZnaGYz4lDqv/F/zGWzX0OmNQ0JCVwZalAVGrd56hbwCBg/J9qsaSw10E9Wj04IDuz8MBaPGjkKsgN9uYfO495wCYe/ojNMeBIzbY+lEj2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AyxMdf1O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qBXeOOIc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NMuALP011684;
	Wed, 24 Jan 2024 02:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=1YFvq4HEp8zaPcpzDHYwYBVSPZNDBDco8QjUDMCOEm8=;
 b=AyxMdf1OwpU6C18sxDpV1KsoPMtIib9wyj0+zbKBHUqE+MibBERdRI3BY8aXQcNP5/Qw
 N6yvISq7dC+HsrkvLW+xzBjWmJLyAK1ThYpE4cpiVPgBC18zhNyBJCzIOnYEsJivVuND
 LtjUT8Etp0303qUgz5WCC6ZGt6t/lotEy3lWuAnInlEd/qfXGw1JTlQXBPSm7HjdZJzp
 rrPn57n2MG/22WRhQEqfYZ+wxfPQLK5u7S2WqwyZh2WvApHOWVCqbGi0ctgJvjfo0B9i
 ghuzqrmGVrST2b0cruKOdPjXf2fsSECDpdLqLbwKSB0BfWe8OYPo+gp5t2kCoXRtEAZW 1Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cuqxm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 02:00:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40O1CcNi001721;
	Wed, 24 Jan 2024 02:00:57 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs3237s1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 02:00:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBS82i9RD7XSQUSGq3pIuUQHxI4qAcf/vN1PiE9DV6gDg+3V05Sf4w7H+riGEPUb8IHvnXRPEMPRNAIetySGrdSTZghY9jKztWJLeTeDHbquJlnNdXSg/vlm4oxcSYr/TiD7QFL5xX3+EwzpGB3j/eiY+Mg8zLTKA01FhlZ0GNY2Bxf/Nra9dfJUFHDJcr+gd4MAmlDgTWeP97tUIntWQX9Ae/+S+V2RPHAKBNaAvpWAUcOgxpVvoXGNiU7XnE5pkpwQzZoEjquCHQtvx9JjT/nDRW4cBfLe3M7Cx68kSzfPcrOrLSBsaYEBRFqQ/PJ4KQvrxe6XoICjP4UPvT8yig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YFvq4HEp8zaPcpzDHYwYBVSPZNDBDco8QjUDMCOEm8=;
 b=Ic8ImRSrPuVH60rqZRC+w0swFrlGF/EEVlSIoIqZDy90cW/aj/aiOpW1a2VcQokt7kE3tyWVNeeX9bJ6DyMRK2/Gni0LqH2TkKCVXSXXai7CGxqwLDDdCX17FEXWvDW/FU7gpl6FpYl/aRUOc6gCxjgWBvCJc7zXQxPrSb57xED2/z09KlrXGtZzYOwBFhuOKp0GFq29f0ogidC0BmWS6fJjF6DKAnWyaCp78Ed84QGW1yd6DAbj6a+sfh9uFxa0C/A+9WW1/5IcJFnUOrN6RXB7Ify61uTnRAU2PkEJDikWqCOhjrxzmGW5QC2m8JRy5OaUnu9QVGEhx1H3hH8a8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YFvq4HEp8zaPcpzDHYwYBVSPZNDBDco8QjUDMCOEm8=;
 b=qBXeOOIchXzblPw9bQI/rygFULrKaYhUlloQEDHaGmRMl1cpMGqyn330n33fpMYzYR0fhEL4H9Ojn0XVKO2ltEfw13WY/f9kJyfxGrC63I7PhE6QzPkfJb2Rt7+Z4JKE4YQlogH10jT3EwtuYtKklJSJJDPUGn9DxQpoKqYfXLQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA0PR10MB6724.namprd10.prod.outlook.com (2603:10b6:208:43e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 02:00:54 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654%4]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 02:00:54 +0000
To: Maramaina Naresh <quic_mnaresh@quicinc.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Peter Wang <peter.wang@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,
        Alim Akhtar
 <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van
 Assche <bvanassche@acm.org>,
        Stanley Jhu <chu.stanley@gmail.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>
Subject: Re: [PATCH V6 0/2] Add CPU latency QoS support for ufs driver
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1a5ovze0z.fsf@ca-mkp.ca.oracle.com>
References: <20231219123706.6463-1-quic_mnaresh@quicinc.com>
Date: Tue, 23 Jan 2024 21:00:51 -0500
In-Reply-To: <20231219123706.6463-1-quic_mnaresh@quicinc.com> (Maramaina
	Naresh's message of "Tue, 19 Dec 2023 18:07:04 +0530")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::7) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA0PR10MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: e7657fb8-79d7-47ee-d0aa-08dc1c804c77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TWJ2S137zqQdKDltTcU/o5VPxxZt1r2uttoyfy2zhZg3+KfVkRIGlkYRa0TMqXVfNvFBfN1qmcRAQXBBFNQ3rSR/b4/IzgmlgwKoU9dXWffXp805frv5r2S8YRBAkCDvTTYseWrkfZsZWUgSZ2+9VGGj55F+6tBrBWsM+gRbodgFN4+sTSbXWmEegMirNNDXU+ffUQyrwF9lbTQ4a587OMi63MbRV8lmKniEU4v8emJzjAE0ZiYFzx5j+tac9DOeTFVC/6KULxds9616uEl6RbEbwFAAfrmXNPeCudtJ8jvX27Lz+EmvMDeQClqP05MXwjg2JxkeKqQxgIfZ8Y3wt1C7QQeO+qbX0fBHMVgxsYntGjL+kuRy+9q1DVpFiYNgbr9kUSy6rTqYRwRw7lrc04sO19lA0qZ6LIK9E3VG92DRe3O8VhXwjBp+54nEkCCwuM1CLoSIJ0FjyfWy4B9MtWzXg4QUn3DaiiXtcJ+7Y5vbEJrFB7ALbGp2W3uh6Vq4e/GaVoKFiF/ROJMnykPnwfSPkovymNQul9MCx5Kfb/JeP1vnNSGf5LZfA5PAui5z
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(7416002)(5660300002)(6916009)(66556008)(54906003)(66476007)(316002)(66946007)(4326008)(8676002)(8936002)(478600001)(6486002)(6512007)(558084003)(86362001)(38100700002)(26005)(6666004)(41300700001)(36916002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Rn7kuLMIKvpq99pWw935haJNTD93fO2C/nfoS4Lr4ZokMUI0Oq7yh74cLGMu?=
 =?us-ascii?Q?ox1C/7Cbb7sPh1hg+iAuTBfWruY2fOjJiHCt/zuZeUGXx3UC/zn16Iu4zYaA?=
 =?us-ascii?Q?EaGSliKhXt90ri0vMYc71gOPbgpr8zUlF/bFYb17FniFl+s4gFCFsAf191j3?=
 =?us-ascii?Q?FBSo33PsDzZZLJXOS1i3uP7zsnYYsudO3JZa8Ro0xrA/qbB9VzfelBwxXy4X?=
 =?us-ascii?Q?hKbZwPG89jH4cqbk/Ng+vUnHK1PvZaHmBzmvXdE7d7P/TuJwOzRhd2Cdo5Vj?=
 =?us-ascii?Q?UbfvThtHmZbgKyIJO+joFoSOM3CZNJ/mkChsbYILSfTFGmahlDl8sbXoWfS0?=
 =?us-ascii?Q?ewA5V5+HGRrf+W5SM2ehbS2/ETNdhglyNIHxr9AmwQDpiYr0T4uTzHkQEt6f?=
 =?us-ascii?Q?2uolJshuhAeDyeAVR+aHbTZkkIDjjBSamVEZdv0AynZG+Dp8lFubPF0GgNR7?=
 =?us-ascii?Q?4io7EhG6wJZE+ZfIJq2x+dS4qdrdU+V1b1kmbuvqHOpw4xOzLZp+FcEZQcqt?=
 =?us-ascii?Q?jdJ5bjLzsbBvxa74igqBsfEaAdeDZiTAvYgNG9C6KhJdS99Oyv+a0My6guhT?=
 =?us-ascii?Q?bL2eTLxqV0wAlajPY3fxAM6eI8m5pTZiuzVlnX8rDTf2Rly/xt2Zg/StBwzO?=
 =?us-ascii?Q?4WDPDbPW0stv3GQb+5yn+DBYNh7W/q8knW2gqY/2E17Dq6YrN58XeF/FPNpT?=
 =?us-ascii?Q?otgKF8f1kcDEO2idYbM4w0WdWXgUn27USgsMWlxqzZaqcoJk3cfYZEPrT5Ci?=
 =?us-ascii?Q?S9+x5aMwr2GohTn3CTqgMnr7hqQk1a/yZsOX3XD+XkaEvz9eWy7BNwwrjYB/?=
 =?us-ascii?Q?0JqSqJAwQ6e8hIvfe8eK7LArGxC9qrRSqzs6B1gvwGDEcfN9ZWOcUZBFxhf1?=
 =?us-ascii?Q?ZkyW0GlZlgFm0osgCvQj8OHCr8sSTUvPah+k7SpyMw3d3g7HDTbF/Z1J3H8X?=
 =?us-ascii?Q?FKybW2coQyND0DSlAd0WfAmo4dWicFFxGhyPoYw1BlWmtqOLtZ51WMltkHUP?=
 =?us-ascii?Q?7q6sn7Uh/xJANriPbtzFbzTS35Up4u/gLemWDxyeqF4+DD4fWPcaAavMfh0q?=
 =?us-ascii?Q?HBjlx9GTnmAHfri50a6ZrRD9XGKaScMdEzdqzUfm0wP2KR3uQtPAkzRWNMv/?=
 =?us-ascii?Q?y72hCYArecaTyBZRLuc2hk04WlNUxV/OIPG8eLjiEpdQhz87AczKL/6RZ4EX?=
 =?us-ascii?Q?jdP9ZjN3XeG1zaAsSKNiG2l9jo7Ljv9u2z0UZlmGGV8QXKiyCx7yBAOZeVDR?=
 =?us-ascii?Q?HWkPJl3m1Mc4sixkI86CFLQLN8AQ9HdeZ2uwm1of3rxYJx+jrKtpY6hDrnHn?=
 =?us-ascii?Q?COpYnVz93PrHrWXnOcWyGLt8zIhkp4nyIGFprBUrbvJ3eZaMsZ8dojIfhqAq?=
 =?us-ascii?Q?USIJDk8LeUxwUPRVTmSnmqss/qohEa0R9DMjSaXOTr0Kih8BjtHBX2bqJf+q?=
 =?us-ascii?Q?Q49MBSxFGd7nkxqE+p9fK0H0A2x4BgcY/L4wAKT90v/VYOxYuggHWRAqRmv5?=
 =?us-ascii?Q?9ylxtHvRstBfNwJ9TZbV+a3tLqha+wUjZiX5iH377bN4np3fAbqH6ELXSEHW?=
 =?us-ascii?Q?Nibf5kuoyDykjyR4bixlub7afOX9xvGpPpz9Epn5v3g+Al/ZmrgRJq6AvYpd?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OOk7ywZEhu9waVCWZLf3X69K1nin2/PhaPJ799qN2P9GQVwVTKg+/4T60YmOAKs5v9aR3lsbkvpZoMAuK4ytJweNjS175Q/f860sZnU6YcmzbCvHRQ0WIjp+QwhSW9ycoARAJUWqAI9bPNcodfaqLwM3vXsJ07qPgrRC/dgrgIZTpPLYaznugDY+KHC7QHMv5jfBy5dLR1H21yi48/dErMRCVxqyv9FcO2umn6a6qO6pT0SdXHChplYRBJTdkzpH9t3oCDpc1rBdQPo4Wu4VFpOQmuEEa3ILoyvn38+6ux76sPVDPMC9weAK0gbTLfqWz03BLPllNWcqMmS2/VNO2COZ837k2QnVVOotcvAqdRrmRxEXXK5/+CRxTjieJMaDDMgqRXO1dIDt+UG9MO2qPcD7+c5gMfpiSXbAtD0xnVbSy3voATdnHKhBCEwZokAb6ssyHq2uddM94WLdraDzBBNC9ZohT6DsFugDSzTPgdKl2NrLlegLOo2RtTJ5YPwwqWHONDNIS3GNuczzGd4Su4Y1eFLyxkyrAdtS0rgio/HIfOvWUpymwmmjVMJhZobm4rF7ZA33xEh8Jg0UgRAf0/a1hq3z7PZT8UVJ2xq6kbA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7657fb8-79d7-47ee-d0aa-08dc1c804c77
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 02:00:54.5040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0Zz71njcK1ZUepZQ4RMGBJB4j5Nn1yDB1jh4L0SHU7/Gf5O3CgtbPPq2+pYAZeYXobbu5niiBkH4RqwOoGgr8k2c93O3wck/uGs0nZVBfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=808 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240013
X-Proofpoint-ORIG-GUID: aBWgtrvSLc5m1YOPRyRPj7uUD6KwYLnp
X-Proofpoint-GUID: aBWgtrvSLc5m1YOPRyRPj7uUD6KwYLnp


Maramaina,

> Add CPU latency QoS support for ufs driver. This improves random io
> performance by 15% for ufs.

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

