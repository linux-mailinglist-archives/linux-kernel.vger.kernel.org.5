Return-Path: <linux-kernel+bounces-62958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE2D852867
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B883B25814
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F13134A7;
	Tue, 13 Feb 2024 05:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NZN5sSpJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dT87G+Yn"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA52111C82
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803813; cv=fail; b=kIEnGsdWjcMRyLrziyfBqw/93XbyLwPtdaVC6Hy4ua7zljWQ6r83DsdI5thSNHowdiP2XbCwI0Y722N1eezP+dQGEfIXa5ZA+bDFrt+1hrbmFeLT9IZ4jl+d5Jeh2U+QYYYjWGXefbTlCUSJsq57MYhPoaD+K9oHZDakPUGpy0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803813; c=relaxed/simple;
	bh=c7vDiRC40a2gfZYgLklAP7cQJ+DGoX/A63ETunIq6YI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lDuAOk8S6aWfMUniWMn0TRoF0YEdXqrgQOUPHMq0/6/tTg1oEiYDXZQ3BxSOqBYU7XpC01HFKvuOaOkcdr2sj4VgYNhC7vGi4sNBAueu9pzkgMRbbF8Fe+Gb1fCn6FIgZDS0Ru5v2skX7HY5gFS3pP2oV6nlZnYWGAamSkVHlDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NZN5sSpJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dT87G+Yn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5ngWY028876;
	Tue, 13 Feb 2024 05:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=NJ3F9MMY35Q5cReOpKoUBDwzW5yjggD5Oj/M+HmYOsk=;
 b=NZN5sSpJoX1tZXOA8narfhBPwR+HuZV25gswItlHvfCahu3euGa4z9xaGLMFfx6Z+S90
 7M9mgIEMJBXy93uzCwgZG7KCCeWhZfNNm62D0+xU6TVKiNpHCU7bdvTic0mr3WjIQtIH
 9WzALiLXFSq+owJBvu2mG0xOn3D5EH+Al9aHhGXjhOsFshY6IaCx1K8/KPFMbKvE5Llg
 YSWa37tgTLgGM3hRWjQ7d94zArQOXrKNrpyk2kiN0N+Ucso++iK76WRHzHawPeofrZPU
 zxyYr04lm4TxiDT5HyAPohuBJiBazFGF9YugsYU916YGLEHUhEhff3brM6wvvUFkTmBO mQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w82m480gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:55:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5l6cL024619;
	Tue, 13 Feb 2024 05:55:55 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykd3sv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:55:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbk+IngOZi1B+62OMyRqhaCeOzBnwAVYRYbuxzoVgSbZxE3B3SBHV69ud7Gs4MY0RxP9hbjFhC+RwLcGa43feT8q6BtzUHq0IojxyRYj8YNRtrEftal7nLtp/olE9VpZEcWQ4mcotQPwerQMYM+ywQ2iu3d/U5SnU/MnJMxoK9gk5aTZVoeO+PGT57ll1kNvN6THk9olH5jPIeeF+0Wibxc5nrcNN/vcWAbVL4iL4eWxjFlnXEBFKm/t20PWW2PdCajONZb3f+328IznfCg60ai0sbnqpWiDM08Mr9DBs7f5TEptEuBfCjp0NyNvnk9LmCKxsZCyD9HOTa6Anhb5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJ3F9MMY35Q5cReOpKoUBDwzW5yjggD5Oj/M+HmYOsk=;
 b=XMv9o+XUX/ivs5pEBCsMlwGNFC/Yl+R51UCHgfumMLw7K2xrCf5m5ooM3whBbfOun0jdv+fXN60ZeXGJkWiICiSlFIv3K1bzZkVEBE2vY6YJv9lngR+YP4tgwAjhhVZNlarKwD8KKdIpyPV1RxxCzk1r8tpoOQ0djF8GSRT0F1kDFzhMGOVmWa+6wFrPfwuAIympm/HaM7zgKg4c2TNi+TxOFLfxPxDGJiuhy6uGfpP0xtZG4RMdLeoZVeQSSMMe/oWc02OdlZuYE1hJ2qZCGBclPfIozO7SXOJqckML7+SoWACLTZjFE8eAvk6jkiF5oXLIC6u7YfDcxpMAnsUZ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ3F9MMY35Q5cReOpKoUBDwzW5yjggD5Oj/M+HmYOsk=;
 b=dT87G+YnYvBLrT8VumphwhxnMYn0CPY1fku8nE8vlS0QIf0DSqsZAEF/2gjbQiKhXMia+9BbtFSm9KOYviZ+GCJpkqO7Wxyk0X24xSDnxVtjQPjTf3EnmvL8ZbfxQTuO1CMdpsyrwybqEPD9HUaoK0bClfii4nat/k55dw5iSjA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CO1PR10MB4642.namprd10.prod.outlook.com (2603:10b6:303:6f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:55:53 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:55:53 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
        mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH 06/30] entry: handle lazy rescheduling at user-exit
Date: Mon, 12 Feb 2024 21:55:30 -0800
Message-Id: <20240213055554.1802415-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0387.namprd04.prod.outlook.com
 (2603:10b6:303:81::32) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CO1PR10MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: f508e533-7c47-48c1-9dea-08dc2c587084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tPdn2McKEWQtQ+JiCW5rVWAbpGBM4nEqrmkaRR7uabRe3DoesHff4Hi82Cxk2fe5WDaz0aUHYtS81efDjK/fkoCq5gcasH7+qPAzpGmHW1gv4MOkizUDs9E7HA9mf884RjM9Dn9Nf0cqlkzx80MpkmnoWlZM95milNvmpudcML4Hrc7itOVOLT7MRd1+lAJQCcnNrUb2iUJF/DJwxNyEtv/G2nTtoMAnEcwunOhU+2kqq5RkJGD+J26psAW5j6ZzRZf3hkB4YovBu7aq+IPpsutUturx1MADPcPWiFy1RVqX/qysSIVJHHPyQwI7ClKdtLlp0TCt0kBH8dj/ms+/hqxJQJGoHGzBmKEqFNZRxT5unLHWvdUat4WAXW43NOLxn2+tfMh6CgL2QTcZM02tz0tmkm/wkszYYhP2rodVzdoTWPipTblHLRYTS+iX7G327gfye8jy+8I5lvhQ834R9J/UfU4aa4+ZnFRIHSWaRrXeSt2Agr4yzjzctpvgFdWExT0Xzhf68Ipp2h/UVplC3RMJOmZu8HiJJlNRFsuUs24=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6916009)(2616005)(41300700001)(83380400001)(26005)(1076003)(107886003)(4326008)(8936002)(8676002)(66946007)(66476007)(66556008)(6506007)(6512007)(6486002)(316002)(6666004)(103116003)(966005)(36756003)(38100700002)(478600001)(86362001)(2906002)(7416002)(5660300002)(7406005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8TWLDvlHT1A9q6YQU+sr9xAvMKEd//CXz+eOzSqyrtO8wpnfMwmRmRqHdgJf?=
 =?us-ascii?Q?Eq8MOLgHJVzX/cOmyOPbbi4y9dVf2UxUpnZPh2WbJdq4dX7q97f/WdTbkzdo?=
 =?us-ascii?Q?8cGwww1chQ615fzEw8lgmS35eYLgT154OfU+ArXbm+Ioaxcln6Wqz5qrIbs3?=
 =?us-ascii?Q?08YU17Fjb6ib3ty1lAM4gWM5utYAFJg2KfizsZp9gMBu+lr2jUIKc9BGcDmD?=
 =?us-ascii?Q?merQFRgAolaYcQW/8z90SvcLqPF65HrfvpLO/EcA0lJg7fvcduqVITz9UWsf?=
 =?us-ascii?Q?Xk7yqzlIjWFdPYQ8ceqVThNHgpCHv6r6KII48+o/slY0X9BV3OSjZeYIx7nW?=
 =?us-ascii?Q?gHdeXGwO4EMX4CjooMREDudeI2jq5aS+fk51tE+VKfVcUHvvo8rBDql6l14r?=
 =?us-ascii?Q?o5+2nz/rIQJAu9RjP/BKq8ECmsAeLleHJJt4Cjb/VszgcuS8Z7ojayhEMNWc?=
 =?us-ascii?Q?KilOG005lpIoKF/c/65vZpaYQL8s00ozt35tgQM+VzXJtIyoNVqTriQne14n?=
 =?us-ascii?Q?yV85ZyVjoL4zHlNGuBbnq6euBX5h+OoKBkh0jbwwWwj58d5L4GyJUUX+wGun?=
 =?us-ascii?Q?NUT2E2GREPXBMTdA0FXF9SIk1aiYobAjY05BOwc+/WhaBLfryCdvGa1MZCEB?=
 =?us-ascii?Q?WAbWtJfpIhDC0qeG472TRJ1QkSRJTD9UD2n4OfuaBnNK8IWX692+GBu9MwZY?=
 =?us-ascii?Q?IDvQaWnZejvRFTrjzn8WGo6RCOCRkNfDvZAceqX4moIrGsbNgEFgCzPP5z1e?=
 =?us-ascii?Q?49g8g6BbVF4G9oouYah/83XjTDwXXKe0crkxXRCX+ELZk/MOFWWWOe5gW660?=
 =?us-ascii?Q?/QJWZrWcZ6xk0lx4dRuPBeo4BDmwW+t4rhnWvEbiQF3Ziv6VyyfCr9n1aaqz?=
 =?us-ascii?Q?iabXQWfRpA13chevJ7G9nihELovGZCKbQZpL9L1x+bN6T8oTmDusCkY1snNN?=
 =?us-ascii?Q?z5EuGkF2u0W+wwrnhi9BbejpPggFu2RCCp2Grt7VAQyQBr7i9ixG7Zu/JvvD?=
 =?us-ascii?Q?iUMJ5T89FJPiVNw3aUxObVzUYrWnugvW/MQKvCTV63T7u9xPCGiVCrVIjUjD?=
 =?us-ascii?Q?Jbi+dVWHDN6JM/J0OgGNkOdGnnFf+pruuRf6KymRYftFLlNrpJsSBWVy7yTg?=
 =?us-ascii?Q?58YCEUHGmRGgY1ARLNyNpUTCkofGASD2IVuKIQSN88kPbcJL41Yzb0EkKoT/?=
 =?us-ascii?Q?zbFYUwgF0xM55+ca5haw9VAhe/tMvHbzV3V81tkgq3Di9dIL2/vV+/kBu/hk?=
 =?us-ascii?Q?uog8sRQ3lBG7TwhhbwUokrk21ClNhi6xSLTnXQInwQ7dK9/T62bm6m7j8ZI0?=
 =?us-ascii?Q?ztTXu3rOMbFxkbazdITFxEhSaN0Gg51RMeqisP1gG3upyD1KLzLr8HNfNaX0?=
 =?us-ascii?Q?nLV/AS5ju/qyRoKrMi2+mSLIM1U3VjNanUBRAteUiPSt8ywBl4QqgMYRVIgK?=
 =?us-ascii?Q?Spb2la3vd2lJBabFRqLVjIdf5RcMi5Cvm3nZsrOzcFkCsL/WR4rSBQfM6ROv?=
 =?us-ascii?Q?WYefdAL1BZaAj1GbmwCL6XYKgNst1jiDedfo3H7+bpmTaz5Ydf7lWTK+mcva?=
 =?us-ascii?Q?aD7tefYX30Bmh3BQrlv7mIhDuSImyfT6cnIh7LjftZ593zyTT3dfpdYq/8I5?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MB5jCMiQN0XTQ+QLTc0uIMZ92Cx2s1y2m7rTyVOx2/rzwis4jLv6TOvzuoSYkJae3jHd+7rPUm+HYXN3uCqwWiU4Y1CtVbHHq3ry83ObmOePEFktDbab9evSL/UZUMbxG7ZAe3edLlcYFb2yzUX89L7cmcub5cyDO668QOYEnzTaN0LQmxdwkbcKuUU6+T2wtheszpAm6pLN507JLBpAHwO1FiuZtXVyY17RYTKLdOxCiE5jj5M53OWEkZL6ai2KFT3tgQTuYZcTMvDiyHCnL9LTY38ukHDeo11kJC628KpjyFuCYnv8RrQJX23o75bA+X2K6cGqUtjxcDd3csKdlTLqof2jOG+OJiiNYg1RHCcx+ubXqkTjqUCxmu5n5sTcFb9R+/G937weRvZ0228L5hFc1dP1P6w99rWJTrhg6OOrxe9XGyJmOq3rdLDlYGrOCgaxcpY4EmZETPrIeduA6HJRDQpfUJwUKzNKxcrhHZSrERARYGTcI19OkzzdAkdR9HYJK7LVQghqYzzEJ+PGul2PSuNoCo9HQMwyEO7KHgd3PwEjDhORtRZk0Dn4DJ0cNaoV9zZMqEiUWFA3Tu6e3argZA89VKAqliMM6pUlP00=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f508e533-7c47-48c1-9dea-08dc2c587084
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:55:53.7565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3USngZK16H39tNBdEHl6eylsdjV8qTenvHev3Q0/SaCEZVM5ilffRz5ehGIeKLshxlqkBZposJ4rm8Rlhtg/g7wCp83xacvbjJ1Zv/d2WNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=611 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-GUID: VjPYC7iAKuk3zqty61qdMbSb9u94d3hO
X-Proofpoint-ORIG-GUID: VjPYC7iAKuk3zqty61qdMbSb9u94d3hO

The scheduling policy for TIF_NEED_RESCHED_LAZY is to allow the
running task to voluntarily schedule out, running it to completion.

For archs with GENERIC_ENTRY, do this by adding a check in
exit_to_user_mode_loop().

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/entry-common.h | 2 +-
 kernel/entry/common.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index b0fb775a600d..f5bb19369973 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -65,7 +65,7 @@
 #define EXIT_TO_USER_MODE_WORK						\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
 	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |	\
-	 ARCH_EXIT_TO_USER_MODE_WORK)
+	 _TIF_NEED_RESCHED_LAZY | ARCH_EXIT_TO_USER_MODE_WORK)
 
 /**
  * arch_enter_from_user_mode - Architecture specific sanity check for user mode regs
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 88cb3c88aaa5..5c5befb05410 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -92,7 +92,7 @@ __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 
 		local_irq_enable_exit_to_user(ti_work);
 
-		if (ti_work & _TIF_NEED_RESCHED)
+		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
 			schedule();
 
 		if (ti_work & _TIF_UPROBE)
-- 
2.31.1


