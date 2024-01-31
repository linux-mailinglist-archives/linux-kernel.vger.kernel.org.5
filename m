Return-Path: <linux-kernel+bounces-46261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FEF843D31
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C941AB2E33E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAAA74E26;
	Wed, 31 Jan 2024 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WhVmZjKm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A9EdMHIM"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74A669E01;
	Wed, 31 Jan 2024 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698182; cv=fail; b=T+67EMACfcXS6Ah+9NQlGY1A/8u7gZCRTHPNxXdiyndx3NBEm/LJiyPrq+qY5yDDrvZ2zthWYcXx23K9xVYO6y9sNOJuqRA8KdWPQrbCPc0et0x1Ts++sWDAR/UIkPSP1A0NAlt48b4TXwQrmrUHPVzz0NdUu+ipN/og7pmohCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698182; c=relaxed/simple;
	bh=DlfAuXlB/5ULW80F5bSB2AZa7n6iHxDSO4EopGHwhgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n3rgFjFsHlTQ37byya9mOA7YAieocED24o6XRz8plMJgt5jpGzyqVRKGco7twA8/7clEEI/n84NPiZVzURMWoyMUBJvFzZXuMuiMhVZEwoAYdgACsuZ1PXnUPbEWW/R9ZHNECpxKrSqLln1vAKnDIzVY9RR8m6sxVbU4NcsPQDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WhVmZjKm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A9EdMHIM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40V9iOHW004855;
	Wed, 31 Jan 2024 10:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=P8JJpyrkFGlpvFAE89/qAv/NtUexUbO72vW7m8ppNt4=;
 b=WhVmZjKmZwl+Hi2FANNO5KGtSBjoOnL39CtHl6pV1OsL/VM6vn1F+BdkJm/3eiNgbd1Z
 BztgquUNX2PAxREJKFqvnRmX/IIfNoQ5lnRyVmrqf/p3B2n4bwfl4atrP95GKYzcD4A7
 jDqpyiRWAMSuG3KH1Br8dzw8/F442zCo6bM07vjx6x6Bbhhtsb+4xdYiGTqsETyXjLM3
 /vOqVmwMc3HVQ5iuvilz2EiOkzWVg+K9yFrWu1Uvq6mB9Oj4F7x9BTYZCIEXXYuLq9Ho
 PIF6Wnm/XZe3VOD9bVm/Q4E2NzEoWbqRdPnvn56yUVK51mM1zMkDf5bE5YNss0eJU+D5 Ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvre2hp53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 10:49:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40V9q3Hv007821;
	Wed, 31 Jan 2024 10:49:16 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9f4c82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 10:49:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJ1MacHJp3CF2IuO3/W33FbQp7Lc/9Qlofl+w867J5kd6jToZ33yuPW3+Bw+JH8GSnZKT8kQZ3CLIy3TRw3oXW51wLZlDXtkYk420rx+2P/H3EhjiUNsNl5DfuwY5mU02bNcYHZkoSXb4A4/UI3/zO3gDvqD0jzTgxC1mppK3dzDGKUcxdRKj6njPb8bSkplpI0ztUYeXJ3UsFhKGDXIEn52ZP2H2+RCd4akLyaiVi6ia7rA07tcUlaxZBBRjgAtdsA1URjr1m0AUOGmGaJObE3CmlXLnAqNmpS6K0BZypkfypd9PEqZR2JmmfMz9anG4SZEVa2jErr43RPMDMHEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8JJpyrkFGlpvFAE89/qAv/NtUexUbO72vW7m8ppNt4=;
 b=aFpx6yS25HhJ2inMg1GVx1ytujDqdUuRU+W11RIFUIyoYybYwcg1Z12nm5Z/bMI/nleAwadJajHSyIv9FPTSpe5TCfchcft22BR05hXv3bV8Jox0G9Ns78KDFDVFu2msvyDHucB38IaI0b/E85aIUoUFrROXSk3HkzwNnNpS78YbwWeFidW1hY95fy4kbZsgbKJCPWS3+8IzuSmdnmSo+1DC3bULJcJs4r1X4pLAh7GDp1QzqUDUuCXz72CNF+60orPP7+GNQNPmCwVqFIHxnKFXmq5EDcXPCi4cp/bGFfOvaMlJKPZ/ZdZnR6QEXqxBoIxLr4dZKExYhij5IYtfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8JJpyrkFGlpvFAE89/qAv/NtUexUbO72vW7m8ppNt4=;
 b=A9EdMHIMoLqu2Bntzss1IUuuHznMKHrLKYiCRFEVPv52Tyunv/TkzcQUnG6ZB8vkEMMHgbEVDV+oexaFX6383htu0UH2zjASJeWL6sXd1IkVI5+qDO6M6OZrb9txsN319QUJiqr/+YMBkmLMQRRaWnSyjxXxeN3lKjsg9hI5YSI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7323.namprd10.prod.outlook.com (2603:10b6:8:ec::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.22; Wed, 31 Jan 2024 10:49:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 10:49:15 +0000
From: John Garry <john.g.garry@oracle.com>
To: mcgrof@kernel.org, russ.weight@linux.dev, gregkh@linuxfoundation.org,
        rafael@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        keescook@chromium.org, masahiroy@kernel.org, nathan@kernel.org,
        nicolas@fjasle.eu
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kbuild@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 3/4] net: ethtool: Use uts_release
Date: Wed, 31 Jan 2024 10:48:50 +0000
Message-Id: <20240131104851.2311358-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240131104851.2311358-1-john.g.garry@oracle.com>
References: <20240131104851.2311358-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0115.namprd07.prod.outlook.com
 (2603:10b6:510:4::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f65689-0c6b-4d40-7211-08dc224a4436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xY9HSexY4wiCwxKL0QS9wfkLNmdOW4ZmZ+qxa9h2eZ9uV2PiOs882gm6nDDSVeCCctkTvLrxrom0Z3TDswdiFfuSmOrXlk/H0RH+D2KBF3ejY8pE+SLsVftaLwRXxitu5D36X80rYpppbFMOQ9WfQNzdmgWlzv0kg1EZ8/Ru6WyStEbmK4tFMel1T5yaK0FEWpVBkBJfivN8TIiVJYL+MK2TWvYum8ibAb1HiH3S8fV0c0/fXd/7K9qF49IgD+P6lzkisUYhwEBkT4L0KKr1S0jZtpSG3ZfsYYHc7PgaZ61AQB+6tWOGfB9xqrEskLoHsT6lhgA0SmOsXn41tNMbScdsOYYhzXUiPLi2N5r+JEoQVhPKslpC153wglCL3VrheyNUIUqRTaVB3vg7qOkdx/okqn2awh0eREg8tINUC4MAD8QwDwznC2rn+dk3w/Nv0e0WWHmtkBbnhxBvl+7yPg4fWLFKMHihHOL1CQVPzpZFgI+Qk1U41Tt1S7FqQBB+FaHMEpQpoxIO2/9bHTieJxOcmMC/OMJe7Bwbcv2DSaW+yOpRE9xEo0+85xBG7H1iSjVdzOMpELOs5/gtYNtaulpjySh7+77DOOwxopl04Es=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(921011)(26005)(2616005)(1076003)(107886003)(83380400001)(6486002)(41300700001)(478600001)(6506007)(6666004)(8676002)(6512007)(36756003)(8936002)(4326008)(316002)(66556008)(66476007)(66946007)(2906002)(7416002)(5660300002)(38100700002)(103116003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8ONbzDyuDgptHtZaGC3D9Tgv7ZFrrTGtGqHaQhezSDM/yBgOqgTVg0485PM8?=
 =?us-ascii?Q?2SD0ocMqiqqkxstxzPgxwnqpt6OFnaWqycvSi5Dppm8hBVncAbEg8hn7MrDR?=
 =?us-ascii?Q?NPoFYTGhzyswK1LZ9MHsWvJdWSbfyCVFuX/SIxZ2KJrSoyYHlKpWSDKuThSq?=
 =?us-ascii?Q?V6IG7gaZwM1Ca/ZHEh21RS8cmkh8pGRmipCK66wN3O85H1lXYIYMRCZ+68jg?=
 =?us-ascii?Q?R+TMKQmpICDLpa9UupB34NMlB/2FNf7ezpc0Tl1v163ugq0b9ezviSY/KJto?=
 =?us-ascii?Q?Fghsh2CknFcZ+rpMX4pYgfHNM+fB0x5bSwhsqTcGOHbbhwMh68GxS/IwUm9U?=
 =?us-ascii?Q?bvzXbZ2JNrvOz+ifllbKiOGLrFLkVXZhpjBcVnktFXsfsKvGz1aqo3pF3s8X?=
 =?us-ascii?Q?vDS0lod4JApQWJsKf5f69ac5y/Rb8vyg1MyUwSNSkzYIBiYsf0iwFlGOK73Y?=
 =?us-ascii?Q?zx5gWu/yVkupW4rIoQKIxvkOzodjoh7jiiZgGRMJ3VhYic4RNLXGJbDN910V?=
 =?us-ascii?Q?ue6thM2AvQnSL/b5xgfIBCYeKa3IxSFlRkJq7KowwObkVwe5UAaZdKtu2JL8?=
 =?us-ascii?Q?AonTfi1qzE5ta9FV3QngR3r0rgeAZp8jAMNAHeN0/no/uhJ1akV6aF13HVoo?=
 =?us-ascii?Q?Y9H0JZVlwMJMqkwyGk9k8Wc4RvIlj6sXLfkVP/9siaJTgRKs9N1knDNo70zj?=
 =?us-ascii?Q?Sv8AM8GcSgyeW4TbuCjal537EMIfBBm3iEPc+GkHnAXPWore+j5Adnx4V81u?=
 =?us-ascii?Q?L1F9XKz7huv8t5niaZr2Dvu6NKkQF3XMr4exYxS2a/K2kl3bSTqNeLp3wM8L?=
 =?us-ascii?Q?/bWOhFaBE2pKaFKbEpClXZGAY3+06vxR6gU/qevAC1/P4JJJL3jOjmGGPHvB?=
 =?us-ascii?Q?6f3auXyH4UwDT+OwFIogF1Gurc6NsagtG+oDkPAUqxj1Quan6ozw1J8UaGCy?=
 =?us-ascii?Q?eqoL9V4uFtRH0GAyjPYTrqvo1QsOZRfsSV6PvfQ+M+5/glsyDFusRje9OQZ8?=
 =?us-ascii?Q?NNue0rZkyslcqyxTE1xUSNZdcwfWDl2O8o4VczjlldHTA0CeqKaQtN4dJsuV?=
 =?us-ascii?Q?mqu34/9HZ+YgaOHHCLVqsQzx979xibj/uDQejidyGf6BYxYLEU0v9gVxtWa0?=
 =?us-ascii?Q?XpDdzdDvIlNNtYLpxNk99po0ie7pYqn7Wm55D7526BB9hRb4dBnSoPXdocs2?=
 =?us-ascii?Q?yvcsaySMfGzdikOeZ3xjiSf9PHunRYFElfMNNCc9LaN4ryvNWinH//+HZABD?=
 =?us-ascii?Q?wiRqDsQvLcIrT3HnAVfsfx44Nhjozo89o+LHmyGedVM7n8x0dCtb9piZXp0o?=
 =?us-ascii?Q?qyFoWoem4d4AFGWhpqS1OyhAYnsD0496W0JmGGjI2KtgMbJSfowiQpMjkdVP?=
 =?us-ascii?Q?pKD9QPq8v1GFo+jMU1TfWpZdLrnm7jGBvqCEtq8tgjr812UDtNKnDNVtuyry?=
 =?us-ascii?Q?YsubRmYbKmRVI5PWuHaEM5lvSPDFoQtkJHzD11VyXNpxtFNZGE0KHFcH6/ZX?=
 =?us-ascii?Q?vZPxEKtbuAjx78P2BYUqQTGpJUvFMg36v706KSvxAhyruttTiXj/CTuM8N5X?=
 =?us-ascii?Q?Vr53dO2s0azwecK/ifzuNN4bKKUCHBz3IJll9i48nfEmFHLFpUnMQoTrhuDQ?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Wg1gMZjCUAnl3kIBLbNa6iKZe+JR8zcogRQMzqIbYJcTqVVoUblAIeBOP+WUttGi7P6sLLKoBmFtZUspZb5ijww9VdH9IY9UwEfxqHiF8ZXzTNtMZtbZjL8L8ldCr+QJKGMp2how921HDeamUomLhBoqbeXKlKUQiN4O877G9saLGDQlIfMT9MGYQeDpf6Is/KXy+8BYFXEjYkcygJfhfVnJ+A+vcpidXx/sXcZZAgo33VfNVA5AOW8erQFPzicTvbfm7+rfEjC4JgJWi8zDcplzFXLgU5u4h/tjSyAh63R9srTg1D30O6zK3Jd2qBHunUnY+Iou9Gh6LqjlYKuxcoDnpSv8H9z4Jm9uJkibMj6sathctc+PlPVqBymEMwcZWXuIT47NBJkTZFMpDFXTD0pYhZeCkZAfIfOMR7w805tlGCrN9C2Wcmux6HpgPgPdA1whJwW5y1nvKaXkgOn5Z02AZfzNFkdc0KVLtoABA4A/YboXAuCwjFOz6AMIykSxpQZLRZDo/9aE3fDZXYBI+fMtOuJBjdd3U4Z6z/vv2kUR4YgjLB+uRINSVLxhJWFbBe9MMZzh4eH+wIbHR4/EwQWNl904RP+r2OBXM1WZ9oI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f65689-0c6b-4d40-7211-08dc224a4436
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 10:49:14.9575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hs+B9ccMWdY1LQ2aDnb26PHKANJss0ZAtLQUvV4fe1yN0aTt7PE5Ecb3tZeFaKMyfnA68D5T6OqjU9GjXed34A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7323
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310082
X-Proofpoint-GUID: SC2q2pN_ztbj-AZRvtK0sws7BTUPOknF
X-Proofpoint-ORIG-GUID: SC2q2pN_ztbj-AZRvtK0sws7BTUPOknF

Instead of using UTS_RELEASE, use uts_release, which means that we don't
need to rebuild the code just for the git head commit changing.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 net/ethtool/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 7519b0818b91..81d052505f67 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -31,7 +31,7 @@
 #include <net/xdp_sock_drv.h>
 #include <net/flow_offload.h>
 #include <linux/ethtool_netlink.h>
-#include <generated/utsrelease.h>
+#include <linux/utsname.h>
 #include "common.h"
 
 /* State held across locks and calls for commands which have devlink fallback */
@@ -713,7 +713,7 @@ ethtool_get_drvinfo(struct net_device *dev, struct ethtool_devlink_compat *rsp)
 	struct device *parent = dev->dev.parent;
 
 	rsp->info.cmd = ETHTOOL_GDRVINFO;
-	strscpy(rsp->info.version, UTS_RELEASE, sizeof(rsp->info.version));
+	strscpy(rsp->info.version, uts_release, sizeof(rsp->info.version));
 	if (ops->get_drvinfo) {
 		ops->get_drvinfo(dev, &rsp->info);
 		if (!rsp->info.bus_info[0] && parent)
-- 
2.35.3


