Return-Path: <linux-kernel+bounces-29376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0BF830D77
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F40A28821E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE71524A09;
	Wed, 17 Jan 2024 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c6h4BnDO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V0CTkamn"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF0122612;
	Wed, 17 Jan 2024 19:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705520970; cv=fail; b=EqFrKW4DWYvkhc+nJE2VHg7rmmDIOzruhL1/0JsMeYWVUwIx/oP08gNApxt/0VWE3IXM8fsJ/pJE4RXxp5ryCBex3wTRvDwj+Vd6EYhqp1YB2nb7fFagQlAlRjOwfuTLupUeH7jLauotKUC3saDRsQuHxxm1ff76g/bRN1KNguk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705520970; c=relaxed/simple;
	bh=5Wl15uY6w2WQ7KlS3UFgzL61Ig08F208TtAjUMb6M40=;
	h=Received:DKIM-Signature:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:To:Cc:Subject:From:Organization:Message-ID:
	 References:Date:In-Reply-To:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID; b=henwjRJmhRW0yTbQMVHUfDybR4QmOrH/UUITb0B9CewtRV9kffuC9WcQy1zBrsxDqCWqgD2OncqdCwTxY4WYvVaePDugJKtK+JnAQ6XMmd0cBu3pjfMCFQq/BqcRny42OLwXrT8vYqTNO97QthNpWsdKUtmisoeYE13WV2StqpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c6h4BnDO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V0CTkamn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HJcndl021415;
	Wed, 17 Jan 2024 19:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=SkKto/gxFY8ckG7dft1ul5TTzwM34Aq0GxCjFDTV8Kk=;
 b=c6h4BnDOkcnC+0RZLauLqdP5cLBl443O6hOYC4xoUjXpbQk2u5RPiI/63TsGjy4pxJ3I
 Hej0RV5DEkTwNPA7lrL71sTQJVOqEl4zGpmN5Y2MQNgof4f3abRbjj9pGU8UmxJVKiED
 pXjys351QaUA/AbojGKylOyzAvMO2oEzAp7m/nsN7HZYwNsCD4Dt8JBaMueluVKszdoQ
 7mvkqekbfTbXa2/Qj3fn6qtI50xv2hxv1YfONIxtqi+ZDqQQvWvHClqC2PL4BfRUDwdQ
 TZsxmwFlinOLB1nbaz6hxPgLNW7y9fO22o44ZvM9HCubufXsrq/ajhxsdhneNBwoRb+e JA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkha3gvt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 19:49:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40HIkCjq009387;
	Wed, 17 Jan 2024 19:49:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyb0111-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 19:49:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+Bssgg84RJsH0p4XzTYX7WcS5eVKFk79xbu91OYLJVo7oeeUnfSbZQGNo8hwcQpGe6k2an9ExXMId30INCTkg6O+kVkIT1BObzw5EaI1ATwMXWtCctlfOAnQWVXllwN8Wl0uZZm5MAuIL6Md11sv8HA+U7pys5h0wwHcy1a+fzGVygy4UDh7poiLXXLz/MK9O2fHf7U+f7ARR9cLF1XB2db1nrwh+HWTWOc+JwpDiK9kKYTukOzI4IHQh4SE5edD/CJ6ibvHhx1yQsf9XpdrtUWUYnfns/+tCaaRaDI904oPt3xpP1ftCvBm292XrVc5Ip6Y7qv5FvPEP3wrdjQVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkKto/gxFY8ckG7dft1ul5TTzwM34Aq0GxCjFDTV8Kk=;
 b=KNoNiC9TmQMqD0/B1RVV6H2e8gRtAvZ+h5XG47YwEi9kFDYk/JpC6IF0cuy0RfM3X7xrToGbGjGYwpveBTJRngWdw49nhNGCqrbQ1dO432fZDgFgKMriRnsPZKAa7Nk71zWHVu8/N00NSx8P7omkJHM6KIk8HMQW6Ii5RrRB3yWKmaQO+mk3UcieMgIB7jrSDM2vzRhR7PfCbHxHi8lA/mOXDxXsMFtHCASIkf4P8VpRO98Amek2rWCUvYkaLEbtUeZnmBNHdSDh000tqn6SA955HeBNgBq1xIirRI38JJ5PDC5vyer+kZsWF3r16Dw6ScwGVULzvtA+sEmvkuNbiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkKto/gxFY8ckG7dft1ul5TTzwM34Aq0GxCjFDTV8Kk=;
 b=V0CTkamnDUYTdvSXzlDabxEFk6q/g2wktb3QJEFm1l9JgJozetq8fNKYBtW4Xx5jzqKiklpekzZO7DTEnUkNuTU4BbzY8FozXRGZdA8PP2B6CNHWCwROPgJTCmZB/OYbMkbaguYJjgWOZ9JRiMIArZOjpEBxaPnuKrqU0vsgjvY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW4PR10MB6461.namprd10.prod.outlook.com (2603:10b6:303:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 17 Jan
 2024 19:49:20 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 19:49:18 +0000
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen"
 <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: initio: remove redundant variable rb
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11qaf3fm3.fsf@ca-mkp.ca.oracle.com>
References: <20240116112606.2263738-1-colin.i.king@gmail.com>
Date: Wed, 17 Jan 2024 14:49:16 -0500
In-Reply-To: <20240116112606.2263738-1-colin.i.king@gmail.com> (Colin Ian
	King's message of "Tue, 16 Jan 2024 11:26:06 +0000")
Content-Type: text/plain
X-ClientProxiedBy: PH7PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:510:23d::23) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW4PR10MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 239f9621-a560-4d7a-1b37-08dc1795647b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ueEvBCfFomfq0/f/uFbLZMMXyI8yNSQANHo1yvwt6HLud8V8rKp1ht+Nn6pYYb5MnMgSuKcG+bMg2LYTBiJchQWjoCoGEmdwe8PLihKyWnk48m2TJBcx1D7QGoyznLdBuchRq/6huo25fKnj0zZXUaEWWvrohdPRevouYGhuYeCJ0CvKlsKKHOvyjMzr2L1dfNy1wbGpe5Mq1hUyL0KxXg+NV1ptFTTrwGS9AFkd9YjcPKFD73Rh5xVgoGk87wyDjFyMN6M2tuYhw34nH8P07oECD2krUxS8bEyE788m3Ut3EHtNBVgPxHY07RyczdXhuiexn1nfQkqHsXS/r20c+Xev7SVUMpHHCczoHfMqLfSOUrQLCNs4yvUdnqKItSlz6wXJklnLJP2G0nAovx/TYyQ8n8ZL+qwlfZ0txZNI77o/IIjxIxgDtksXiGNasmHmUQdwEQfMo3Tspx0bxG2P7lI+g03eSp3WUxcy3LXG5wADRfTEzGGD9nw70Zbz51lhPsTGYazYZyYjhHbGiSxpzpysE10vefCzm85sjj3J+QP+7PLQMnfRa5RwPZg8SEKE
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38100700002)(478600001)(6486002)(8936002)(8676002)(66476007)(66556008)(54906003)(4326008)(66946007)(316002)(6916009)(36916002)(26005)(6506007)(86362001)(558084003)(6512007)(2906002)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nDHFKiESQYN+gCDSLhQA6o4ifupb/dGlSqd6dgp+D1QOeoAjjlpd+Bs7Tu91?=
 =?us-ascii?Q?GcNv5baavuwcRsNtF4wxMovaEg2H0dHs46wYRYBarNKlE4nTeK8z5jtvbW9x?=
 =?us-ascii?Q?FjbzPPg6i6tVHu+16ps/fFCMJ7t7SGyw30qxFRrs8z/AJvwCO7cpb5Ad+mLA?=
 =?us-ascii?Q?gv6YGN4Pu2GQcsIVbSan0rYijMPYM1hOSEI5EKn8DI3xA3pwW8AxAaNQuaCk?=
 =?us-ascii?Q?GOFTs2XChqCbTa0pT5bo/bb6YzgkuKJm3y1mQAYGTWIFKbMXV8pa0CyZCRzg?=
 =?us-ascii?Q?dZiU+2+usGWE+p5ZuvUfuxirrr+okqaegqVJif9FaVVWYoVJzAdJvUGNMNHE?=
 =?us-ascii?Q?dUVG025HhkvTwzpbKg8/bYkpkxOK8FYB+DKwTLZ2fclHcAlN7pgeqcJmIZkI?=
 =?us-ascii?Q?LAf5ordDXmhxu+iGdOGeNz4jd0g7MF06D45bqmOancVeZxqPRTNGFhyGDZ+U?=
 =?us-ascii?Q?4VWoQh6vt2UFMFts1/xtEcHekZjE6vfwY9gUnr4i+lks8wUDrowK2ENuTpS6?=
 =?us-ascii?Q?ZBDEnN/2YxhabPPZu1k4+FL4npOs1ztfczmTmpup7omsiwAdrfCKtPXyKTHL?=
 =?us-ascii?Q?qwLJuHY7YseetbTYyrOe0ScSTOo/P9dwqpKFzYWr9fZtz5wfV8JTbSf/0+78?=
 =?us-ascii?Q?QYtsyckWH/0vwyoZIcc2lATq3hmoAyUmW4BTNlZ2UZ+lthHOTc8h/S7Vfd4/?=
 =?us-ascii?Q?V1FOjPFC4ixW05KnzmrsiRRnBolDjXMH0C49ry4nTAszOe6/WIMRWTEfBCA7?=
 =?us-ascii?Q?qXYU4hInOa7BK30d1St0BWyKVJ1JoXfV2wo/iCM5WDUA5vRqzPwLUAXV3yVX?=
 =?us-ascii?Q?MCWPkT9hTRNfbOXf5aOUAUYndP4z0Itu3RtLEPfs7obi/POIh8ewztHa6sb8?=
 =?us-ascii?Q?TdpARIDLkg3FHxg7rcbjmn4w3JgrKJaV9fwnnzaGmcUItksGlx9/DWnC0LDf?=
 =?us-ascii?Q?DlznEElgpT1tztN0QPZGFVAra5309sba9Y3TSnJygsmn7Saj2w7zcUxfGM38?=
 =?us-ascii?Q?o+KJbFfRDr4VOA4QC8w2vjVa5HrQ8+KNfnl+K3Igcb/OYYQyCS08MNOjErJg?=
 =?us-ascii?Q?AVr6Kcs75+7cqcjB4cyRZ6HbeojwdbDmsX1ek0WgQNCSFd2rZhVSO5L8/ydv?=
 =?us-ascii?Q?zi4S9vBeJiUsUOgdc/h3nUL2ykk+TUcztzbrMeKE3Np26pcX827uAEpvXKpJ?=
 =?us-ascii?Q?mfFOipS5sS0d4s08xnE+Z/Jiv3UTvazqcfN0p4ZnS+q6J0sktRLNvl7HCYaM?=
 =?us-ascii?Q?R/vkbhkcOfTxl3Y7i0xYwQJEIvGWFZCKEGQWmjF9OjZksIepoZvqhG9o0BPb?=
 =?us-ascii?Q?gldBsj9O5ETEKJcFzHvyFWANMRqn5UIcbxN43CMt7KA6RV6cH78ANylFv+mD?=
 =?us-ascii?Q?egSxwoIVYONzcPX+HZSKtfEGnC6BIe2pPzPZdcUom3KoU6a5TpmxHh+uvdwI?=
 =?us-ascii?Q?tpGLlRPCbeFXp2X1yKNUqmbRKrOVW2eyyqWs6LL8okz244mpDUnKpWPruIY8?=
 =?us-ascii?Q?X29WOoqHbDA4Xq9KPLYLQeHFEnlgq7ZvKvPv6ZjzQChR3GkD9iz3onnS//fO?=
 =?us-ascii?Q?7h0xBk8BYCvb58M1x2az7tnaPb7cdyl5naantreeBOL4idk7mk8Ih6q7EKkw?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	F0xAdu3RIZrbgnDerBP1N0iRiOFuetru/YY+OuIf7OicXeFiCj+BkJzyIZrnFCQUsvV+qMdbY3gwGkSOw5M0j54Sfrfho5jCzNgRe2OhKYGIQtrZKs5niD/aYmtKIVneOE/lfJaKWLHSO+fUjuXAFMf4W98KW92K1mGdHFsmYfzyABCsAsuLaQWwfzH7JMJTMjt+k4Feb04t0XZbK2bnYPZ5QIzb418zyPnKij3XZkx5a/n8/Q7V6vZXripcCduFsuIo90aGW6FxyegiPvaoKVkMBkBg7GnwZ4PFtPwbJBF/NBM1tLLDWPVjpOnkX1IG5VK+qcxWXL5x+edqGcEcWDjilCly5EeLnSOYVt3HQ6xiLwgkqaB0md1I0V7HcHLPn4vdxVFLUhkYZ/wWoFKTmjjEFw2jp+PYbrZK6CZGveeAnVJscTiAsaOoKNb5MyyEKPJ2zVPtnwULx49d+LNtDLXD2POIfhePcF/+JrXYrSKrjeyD6lJuO6n0FuyHuSyAz9b044tyixYIE1YmfufwPzwsTmAFzYizBHrnRaijBa86r1biG0dwZBsy86Tf26XI0AafBynk5SfEtPjU37/5RCsOl6C53yq33rikjVlUtjY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239f9621-a560-4d7a-1b37-08dc1795647b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 19:49:18.4036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9CBTdl5r5UrKTuAG5LwH/9oNeEq6zBOXjbPWBEAhBSz52gMsmzVesqYyThvZWsydTa6p0Gys/d6+BrE1qMWoXdhbQZMFnmgPz43K4eo/1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6461
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=887
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401170144
X-Proofpoint-GUID: tBwNq3U7uQUgpujqADbLAA1sbEOlTtGH
X-Proofpoint-ORIG-GUID: tBwNq3U7uQUgpujqADbLAA1sbEOlTtGH


> The variable rb is being assigned a value but it isn't being read
> afterwards. The assignment is redundant and so rb can be removed.

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

