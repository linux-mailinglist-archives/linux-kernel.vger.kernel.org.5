Return-Path: <linux-kernel+bounces-62957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FCF852866
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DAC281820
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BDB125D7;
	Tue, 13 Feb 2024 05:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JhtHFee7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d+8IUr6O"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FE629A9
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803810; cv=fail; b=LEV4SqJr5pdG0QCSVmUJHbdpPfWFTjI4/LUgOoQD6bJwlbKC2chwvm2tn1VgSiG1z5OpZHnXM9zMGZSTjCNM6vDCj7HVHap4EEoXSvhv49WqC0Sh2GgdqlRJYZO9ATw30VN7xbPZ9yEQLD34WCJHyI0oaTp+2ZXeD+/SwBnCrEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803810; c=relaxed/simple;
	bh=QmfmyVZ0kYUPs2l22YvwXK8WS3qxh3wfxhMrlw84LAs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oXAD32yoN96UAWpxSB2eWQyNxeq5hwkrE9lVsnYKqQyBTnv2fyT37Mhi6603xSAc8t60C5TjYZuS6JXOsSui4Tw2yuJgns5XngC2e7jApCG/mjPSzhOmN+76hm/SR+QjoR/4xb32WI+gQRB/Nez8b2nRkSesOvKAdH6TpStlgaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JhtHFee7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d+8IUr6O; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5nfnP028871;
	Tue, 13 Feb 2024 05:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=7BXgj5ojMBd4y0BjmdCwqG8UY8YbvazdoI8FuJE8Rn0=;
 b=JhtHFee7Tg8zl+UuSdDNxgUkuf7vb/2JbMcnXe1R13psm/0BQlzhEvwQiwmNohXTvDlK
 TmY7xGL3fuwTHxWyI8M44Z4a8fe00mXsadPvMwD0PwJ0o8E6clYRXgl0xi0QAduJZ9/D
 NUbrrvtZ3Tr3s5V0wuxtM1HBYjQpSpHXJuEdgk9Gpmuo8Gx0X2y47aRkb7YUI/Ow9be7
 bZoiJrYf5QdKK7kHxAWYWYPUHQ/CEwQgtWyWHNaLe09m6LoBVMQ8JP2+K1/uLzIgLdZi
 ae3qyqh+l1bNGrjAGuvQ2VW2yPB6O1AQcFnBnGrVZsOeKNsCYSGtcpdsxTYHyU02o7k6 lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w82m480g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:55:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D40f8f031501;
	Tue, 13 Feb 2024 05:55:39 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6tvnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:55:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gh9MfDDWKy7yHSUh+xOwE5ycH1jeT2yD+vLnLQ5WowOk4yxZkZZhmZToZIUJCYO+ErNwvECJyZgeZJRXETcFq10PteO2jAoMgAcxCW6jdBQwb9140a1eWtxl+33INiie1UMkP3yaD9Z7LXFTIi0/WzV+ObUBVN73mF9dfH/WG/JOZaclkuOrG7SaNcSmfSt2TFO/3nDnljz9quUa3/n+BQLgWBSQs/y1bHdoGD7U2M8plz3uy/2CUvzOl0Ri8WNGiVU34g7VF+wblzdGj/ETz4DhAMhfclO3eeQUZMgi3zjVqwMZG+UPgrar7kjfyXt9hrkdHNILEz4ZMlefSVtpNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BXgj5ojMBd4y0BjmdCwqG8UY8YbvazdoI8FuJE8Rn0=;
 b=jOwgH7qCD2eQTgXJ+6P5UNxpIdxlMoW3CwJcCbf7wl+0tLV0ASlRu832yjJaoEbbBmpoBZQZ54FiEIFpfRmCy/oD2axdNO6mNnL8lwupGjwjqjhhR84emYE0D9ZOLDyHqdnhX5FBWPQ46EVPO6tHxIOU4B+egkUWykZNnFNMFD/2F1kGsxJorDCN3zp0v1Y2zAq8I93hVA1LBthgr91Jr6x/Y8wU/1c9Z+tA/30GWe+nXQqCxlsM+biDW5+Yr1oTQMaRD8qpKysKdzXd6M2SR40/KnolccI7bSLmMHI0jxl5Fws2Gmy4KI5FsWzx1e+9zAnLltkHVwmu5AW9Fdzqww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BXgj5ojMBd4y0BjmdCwqG8UY8YbvazdoI8FuJE8Rn0=;
 b=d+8IUr6OZyKPTazNjoZU1JUB+ucScP8fb9qel181a+XdjhbluXffrxqj4Ken8UCdmQkO0wN7W5m8jqCt6x7J5RxTXQ0fSuGORzS8H+Am/O1Tm+YucOlMQWwvFmO7s/JuqC6T90y/rqvZxGFlOIO2H67pU6NTzTcemr4/8B9XCaQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CO1PR10MB4642.namprd10.prod.outlook.com (2603:10b6:303:6f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:55:36 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:55:36 +0000
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
Subject: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
Date: Mon, 12 Feb 2024 21:55:24 -0800
Message-Id: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0249.namprd04.prod.outlook.com
 (2603:10b6:303:88::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CO1PR10MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: 79901bba-158e-4251-0906-08dc2c586646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2odTO8AIDnluwdxIXNoAWuM2afQAH2Awas94gyOEsj8fvdNZOqqm34N74fUC6cTVDf1IPygsNR+ifk0wYQa9+eABl59Es7dh9Jr8/WVAKRqnbBxrgfZI8hA/oBwKx2x31FdK9tt0qmh6+cz+AcgWqgXOPQj1mSgj9IL9jFfxSN7z7f9RHoEpwlc7Kh7MPENPvkkKI7JIPezw8cAMR6lDJy7W95rX37+htLQk8LmIHSyOIWdO6HBSJItYb7BP15PLG5dfskjJrunBYsGiI9smE8p7NjKyz97zFuxu6S1NuugWEJ6vaOJT5TNudVaNCN+BmOf64JUUupVLO0GuQHS+fVL3ciVIosJ+aNlul1vgH2D3G20REZKb0AFnbgqOa1MVCxI3PzjQ8OhFDGXabZAwtJq6MtJ0IP3pnmlAL45Gxj9NUQKPRIVXPwAswuLtw7WKpx12Vt07+aD7KF3omgk4m+eT4cTHbJhQaFmZY5zt9B0zcFs1LYnnpX9CRnhneN81znqr6DqeGKLIWqNaURJvwM06wyd416lA8d/8ccqgKfeUni49JAT/h6UdF2dxyjF2AQIEzptIMRIF4FsqAU1Yfg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6916009)(2616005)(41300700001)(83380400001)(26005)(1076003)(107886003)(4326008)(8936002)(8676002)(66946007)(66476007)(66556008)(6506007)(6512007)(6486002)(316002)(6666004)(103116003)(966005)(36756003)(38100700002)(478600001)(86362001)(84970400001)(2906002)(7416002)(5660300002)(30864003)(7406005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?toHw9qR2QyzJHblwTCm235JS8NDxYe7rDis3gsYc/GBn2qj/xPPWo+r+h1Ec?=
 =?us-ascii?Q?v/zb0TVtCMUurBVketBgJ5v8QLeVQ7gt+lirulsMX5BtEEcBnDzFmmMw+ldo?=
 =?us-ascii?Q?A8QongYDPMEtASVk6MIJ2F7JzT23/nlMC5sxI6HaCzZHmusUtxIOlDQjUfXg?=
 =?us-ascii?Q?KmhxnODhVFO5UG4aAhhYs7og5bA2wsJMay/D0GqQN0r37xAQRTjlIWWGqVQt?=
 =?us-ascii?Q?bXJyXGU7l5JJ7gHa30RqFA1hzJ7BY3YN377pDNLnIkQIC2jl4CAZ9HF0Y6Lk?=
 =?us-ascii?Q?1V/aInu1ZyP/jdzh417+/MX2wYTcvO8jIkBxDXiY+d0TYFr0nL4hkEO/EY4e?=
 =?us-ascii?Q?W6BpTnyT89P+kGTxl1i15KumgnxYnnChlU2U+c/nQPtlndNxEHki95CJ8fQi?=
 =?us-ascii?Q?/Kvy4eTibthkkwm614bity739g6Sjmx1GL+oWYcgG7JfqoY4o1QziCcDklJL?=
 =?us-ascii?Q?psYaiDnHUNHo9JoB02OPnn22n+SCtt4WNy4rvs84gM9ZWIR8JgF5FWLW4gmY?=
 =?us-ascii?Q?X6l+bEre7PQc9bGxxTBvxQptwiXabZQxVDpmcQZGBtKIypHs6jAd72rZ6GiV?=
 =?us-ascii?Q?vfs3NBW4C12nj02yy8rGR63kfgOZ//iYGgRtpxUT+MMj/Sm9FuNsYnavqOxl?=
 =?us-ascii?Q?erPQ8tBkvJIB7TzxwGzYCS7pvlQMLuphBWJjphFWcovSJxTsjTPxRZfOBvMp?=
 =?us-ascii?Q?17HjgqlaqWfFUX/qMeiNtJ+nMDQ5bzzvnVJeaLZEB6cS9T2Ux+JfFJuSt1Wn?=
 =?us-ascii?Q?eGrf4yTCpjIsQdLAhuD4JrPjKWjiOrN3eWYL9c0oi+xDCwY04e+nGB7KgXEX?=
 =?us-ascii?Q?xN6k2IlZStKrB8ggWh80ni0s0JnMhtNHxDdWnLHSnqhxAXyvZvCSl6AhDUku?=
 =?us-ascii?Q?pRacYuH7li4a7uG12VCfePyE/tfynbpuA0zM9FrKHhMTKyahMdmpzVrh7SVZ?=
 =?us-ascii?Q?Twi5y756/9jQ8j5Evj41AsSYcoSa6v9Kf/E9YUyaeTq9aBoorB+zX1skBjFa?=
 =?us-ascii?Q?L/V8lOhyhIgRwr9bEHqD/C3oAmVLvWLKsvI9HA2IZZSDgOIex2/YmXqPZE2N?=
 =?us-ascii?Q?jNMzZUSjHN1bGiqXC9AmOYdLUITHrOmcI9man4RymnQLSccFiG8C62DyKoqZ?=
 =?us-ascii?Q?HQWw8VxPt7Q+0wyQPQ3WuuqzkwpNFWgebyxrKMl792CGvqI2daGlqsK22/hJ?=
 =?us-ascii?Q?iGQnHKcNLrlDoVRYyYjyrPYYFSFta+e4nT8rzkU8HRC4eRKT6mB6SdTVuh4h?=
 =?us-ascii?Q?qRM7UQDR57O/0uCCLJYlmLdAYFHW6HqycLhsrS5gqFdbonemfDvf1x/Whqy+?=
 =?us-ascii?Q?osZReDVM/aIckoRjcl9nC2OCiHYLiRt8dRL7nB5iPybr9TI3PfLN00nqllsS?=
 =?us-ascii?Q?5AEDjbxV5Gh4OT6eMnSYmtf3Jos7zSx0yj1ihmtp86wBsKIZxVze1AD+a9/c?=
 =?us-ascii?Q?jPjh9t9O0BHu0BCauwp8zn8vmg7pUeAY2rgWNetgAdDK4HDTfV2O6MSsxUCh?=
 =?us-ascii?Q?3MtshWgD994Is4HdKprYZAzS8psUNtsrPqHd8mdVUDLbxp8aXdMaDuoO5qcd?=
 =?us-ascii?Q?/agrNeB18Y2HpyD8Oflwvg55Esjo1M9Nko0UTyPHYSR5jDI3YQCMBmUkD8cD?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pMgN3u6ZG3JuN/h+9NmOqk+Q2GmQrDjCc0XQydQIcJKt1g3dTywqDDwsg51d9Ia+MKO35Ba8dAKuXfDP8WCVN3G3gYCpUAUPBhM1TFtZCWmiHCVZQ4KGCVKHp75inE+HmzAIWz4Tv1B+VvB7v4RRpbtieYPlC1trQbbkV7h8vZmkIbOHcAOLVZuRQk+7IcJI7dpFEr4oBHgmPoNUP+olYiCfajpENfy6n9Qkfwtepj5yQBEOsYvqr7TPJt9N0eXXbfCPdx3gys5kGV4hV+v7+Tm0puIV9UFwnR01yyUuCNEHvYYF93Uya/xA+ePOa2mDs9VCJYUmdjrmOwhuWQPz8ymFfMuULQdqgmnuWOwXwWwKSDfpp3PQ4we0k4nRZZ7CvlhZOpILmezYp89NntDajc2WDO4ZHLifHQg2v2jb4N0vjhPfJx4gneeqn/T/iA9d23S6PEjWC6YKM8Ytaa8Sb5/29W1dRAyVwRHYHaEdtwYFSYMx4YoRaxAFYtqk8wG4EBZQMFnksTLKWn02kNZ4tmQCHMxWDnlxSBZxhDPyn4EiWPkXvd4n/gFiucnETXiwYgzyLtNLgMR/KyOD5MdvfA9+CBYmwdG0Wth6AUoIas8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79901bba-158e-4251-0906-08dc2c586646
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:55:36.5670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHyAOzrHBU8fsZW7VeSefKZOlyXVfCj5xiluUYJc4YSlbHZgC7cF2YDEQi8/kZpMSBDsonXepPtDrYiU/C4A/AlzOPsZizuBLKu3A6e75bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130043
X-Proofpoint-GUID: Kv0E6hnRhdIwDQWdGy1BajrSj_KcSBHJ
X-Proofpoint-ORIG-GUID: Kv0E6hnRhdIwDQWdGy1BajrSj_KcSBHJ

Hi,

This series adds a new scheduling model PREEMPT_AUTO, which like
PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
preemption model. However, unlike PREEMPT_DYNAMIC, it doesn't depend
on explicit preemption points for the voluntary models.

The series is based on Thomas' original proposal which he outlined
in [1], [2] and in his PoC [3].

An earlier RFC version is at [4].

Design
==

PREEMPT_AUTO works by always enabling CONFIG_PREEMPTION (and thus
PREEMPT_COUNT). This means that the scheduler can always safely
preempt. (This is identical to CONFIG_PREEMPT.)

Having that, the next step is to make the rescheduling policy dependent
on the chosen scheduling model. Currently, the scheduler uses a single
need-resched bit (TIF_NEED_RESCHED) which it uses to state that a
reschedule is needed.
PREEMPT_AUTO extends this by adding an additional need-resched bit
(TIF_NEED_RESCHED_LAZY) which, with TIF_NEED_RESCHED now allows the
scheduler to express two kinds of rescheduling intent: schedule at
the earliest opportunity (TIF_NEED_RESCHED), or express a need for
rescheduling while allowing the task on the runqueue to run to
timeslice completion (TIF_NEED_RESCHED_LAZY).

As mentioned above, the scheduler decides which need-resched bits are
chosen based on the preemption model in use:

	       TIF_NEED_RESCHED        TIF_NEED_RESCHED_LAZY

none		never   		always [*]
voluntary       higher sched class	other tasks [*]
full 		always                  never

[*] some details elided here.

The last part of the puzzle is, when does preemption happen, or
alternately stated, when are the need-resched bits checked:

                 exit-to-user    ret-to-kernel    preempt_count()

NEED_RESCHED_LAZY     Y               N                N
NEED_RESCHED          Y               Y                Y

Using NEED_RESCHED_LAZY allows for run-to-completion semantics when
none/voluntary preemption policies are in effect. And eager semantics
under full preemption.

In addition, since this is driven purely by the scheduler (not
depending on cond_resched() placement and the like), there is enough
flexibility in the scheduler to cope with edge cases -- ex. a kernel
task not relinquishing CPU under NEED_RESCHED_LAZY can be handled by
simply upgrading to a full NEED_RESCHED which can use more coercive
instruments like resched IPI to induce a context-switch.

Performance
==
The performance in the basic tests (perf bench sched messaging,
kernbench) is fairly close to what we see under PREEMPT_DYNAMIC.
(See patches 24, 25.)

Comparing stress-ng --cyclic latencies with a background kernel load
(stress-ng --mmap) serves as a good demonstration of how letting the
scheduler enforce priorities, tick exhaustion etc helps:

 PREEMPT_DYNAMIC, preempt=voluntary
   stress-ng: info:  [12252] setting to a 300 second (5 mins, 0.00 secs) run per stressor
   stress-ng: info:  [12252] dispatching hogs: 1 cyclic
   stress-ng: info:  [12253] cyclic: sched SCHED_DEADLINE: 100000 ns delay, 10000 samples
   stress-ng: info:  [12253] cyclic:   mean: 19973.46 ns, mode: 3560 ns
   stress-ng: info:  [12253] cyclic:   min: 2541 ns, max: 2751830 ns, std.dev. 68891.71
   stress-ng: info:  [12253] cyclic: latency percentiles:
   stress-ng: info:  [12253] cyclic:   25.00%:       4800 ns
   stress-ng: info:  [12253] cyclic:   50.00%:      12458 ns
   stress-ng: info:  [12253] cyclic:   75.00%:      25220 ns
   stress-ng: info:  [12253] cyclic:   90.00%:      35404 ns


 PREEMPT_AUTO, preempt=voluntary
   stress-ng: info:  [8883] setting to a 300 second (5 mins, 0.00 secs) run per stressor
   stress-ng: info:  [8883] dispatching hogs: 1 cyclic
   stress-ng: info:  [8884] cyclic: sched SCHED_DEADLINE: 100000 ns delay, 10000 samples
   stress-ng: info:  [8884] cyclic:   mean: 14169.08 ns, mode: 3355 ns
   stress-ng: info:  [8884] cyclic:   min: 2570 ns, max: 2234939 ns, std.dev. 66056.95
   stress-ng: info:  [8884] cyclic: latency percentiles:
   stress-ng: info:  [8884] cyclic:   25.00%:       3665 ns
   stress-ng: info:  [8884] cyclic:   50.00%:       5409 ns
   stress-ng: info:  [8884] cyclic:   75.00%:      16009 ns
   stress-ng: info:  [8884] cyclic:   90.00%:      24392 ns

Notice how much lower the 25/50/75/90 percentile latencies are for the
PREEMPT_AUTO case.
(See patch 26 for the full performance numbers.)


For a macro test, a colleague in Oracle's Exadata team tried two
OLTP benchmarks (on a 5.4.17 based Oracle kernel, with this series
backported.)

In both tests the data was cached on remote nodes (cells), and the
database nodes (compute) served client queries, with clients being
local in the first test and remote in the second.

Compute node: Oracle E5, dual socket AMD EPYC 9J14, KVM guest (380 CPUs)
Cells (11 nodes): Oracle E5, dual socket AMD EPYC 9334, 128 CPUs


				  PREEMPT_VOLUNTARY                        PREEMPT_AUTO
				                                        (preempt=voluntary)          
                              ==============================      =============================
                      clients  throughput    cpu-usage            throughput     cpu-usage         Gain
                               (tx/min)    (utime %/stime %)      (tx/min)    (utime %/stime %)
		      -------  ----------  -----------------      ----------  -----------------   -------
				                                            

  OLTP                  384     9,315,653     25/ 6                9,253,252       25/ 6            -0.7%
  benchmark	       1536    13,177,565     50/10               13,657,306       50/10            +3.6%
 (local clients)       3456    14,063,017     63/12               14,179,706       64/12            +0.8%


  OLTP                   96     8,973,985     17/ 2                8,924,926       17/ 2            -0.5%
  benchmark	        384    22,577,254     60/ 8               22,211,419       59/ 8            -1.6%
 (remote clients,      2304    25,882,857     82/11               25,536,100       82/11            -1.3%
  90/10 RW ratio)


(Both sets of tests have a fair amount of NW traffic since the query
tables etc are cached on the cells. Additionally, the first set,
given the local clients, stress the scheduler a bit more than the
second.)

The comparative performance for both the tests is fairly close,
more or less within a margin of error.

IMO the tests above (sched-messaging, kernbench, stress-ng, OLTP) show
that this scheduling model has legs. That said, the none/voluntary
models under PREEMPT_AUTO are conceptually different enough that there
likely are workloads where performance would be subpar. That needs
more extensive testing to figure out the weak points.


Series layout
==

Patch 1,
  "preempt: introduce CONFIG_PREEMPT_AUTO"
introduces the new scheduling model.

Patches 2-5,
  "thread_info: selector for TIF_NEED_RESCHED[_LAZY]",
  "thread_info: tif_need_resched() now takes resched_t as param",
  "sched: make test_*_tsk_thread_flag() return bool",
  "sched: *_tsk_need_resched() now takes resched_t as param"

introduce new thread_info/task helper interfaces or make changes to
pre-existing ones that will be used in the rest of the series.

Patches 6-9,
  "entry: handle lazy rescheduling at user-exit",
  "entry/kvm: handle lazy rescheduling at guest-entry",
  "entry: irqentry_exit only preempts for TIF_NEED_RESCHED",
  "sched: __schedule_loop() doesn't need to check for need_resched_lazy()"

make changes/document the rescheduling points.

Patches 10-11,
  "sched: separate PREEMPT_DYNAMIC config logic",
  "sched: runtime preemption config under PREEMPT_AUTO"

reuse the PREEMPT_DYNAMIC runtime configuration logic.

Patch 12-16,
  "rcu: limit PREEMPT_RCU to full preemption under PREEMPT_AUTO",
  "rcu: fix header guard for rcu_all_qs()",
  "preempt,rcu: warn on PREEMPT_RCU=n, preempt_model_full",
  "rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y",
  "rcu: force context-switch for PREEMPT_RCU=n, PREEMPT_COUNT=y"

add RCU support.

Patch 17,
  "x86/thread_info: define TIF_NEED_RESCHED_LAZY"

adds x86 support. 

Note on platform support: this is x86 only for now. Howeer, supporting
architectures with !ARCH_NO_PREEMPT is straight-forward -- especially
if they support GENERIC_ENTRY.

Patches 18-21,
  "sched: prepare for lazy rescheduling in resched_curr()",
  "sched: default preemption policy for PREEMPT_AUTO",
  "sched: handle idle preemption for PREEMPT_AUTO",
  "sched: schedule eagerly in resched_cpu()"

are preparatory patches for adding PREEMPT_AUTO. Among other things
they add the default need-resched policy for !PREEMPT_AUTO,
PREEMPT_AUTO, and the idle task.

Patches 22-23,
  "sched/fair: refactor update_curr(), entity_tick()",
  "sched/fair: handle tick expiry under lazy preemption"

handle the 'hog' problem, where a kernel task does not voluntarily
schedule out.

And, finally patches 24-26,
  "sched: support preempt=none under PREEMPT_AUTO"
  "sched: support preempt=full under PREEMPT_AUTO"
  "sched: handle preempt=voluntary under PREEMPT_AUTO"

add support for the three preemption models.

Patch 27-30,
  "sched: latency warn for TIF_NEED_RESCHED_LAZY",
  "tracing: support lazy resched",
  "Documentation: tracing: add TIF_NEED_RESCHED_LAZY",
  "osnoise: handle quiescent states for PREEMPT_RCU=n, PREEMPTION=y"

handles remaining bits and pieces to do with TIF_NEED_RESCHED_LAZY.


Changelog
==

RFC:
 - Addresses review comments and is generally a more focused
   version of the RFC.
 - Lots of code reorganization.
 - Bugfixes all over.
 - need_resched() now only checks for TIF_NEED_RESCHED instead
   of TIF_NEED_RESCHED|TIF_NEED_RESCHED_LAZY.
 - set_nr_if_polling() now does not check for TIF_NEED_RESCHED_LAZY.
 - Tighten idle related checks.
 - RCU changes to force context-switches when a quiescent state is
   urgently needed.
 - Does not break live-patching anymore

Also at: github.com/terminus/linux preempt-v1

Please review.

Thanks
Ankur

[1] https://lore.kernel.org/lkml/87cyyfxd4k.ffs@tglx/
[2] https://lore.kernel.org/lkml/87led2wdj0.ffs@tglx/
[3] https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
[4] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/


Ankur Arora (30):
  preempt: introduce CONFIG_PREEMPT_AUTO
  thread_info: selector for TIF_NEED_RESCHED[_LAZY]
  thread_info: tif_need_resched() now takes resched_t as param
  sched: make test_*_tsk_thread_flag() return bool
  sched: *_tsk_need_resched() now takes resched_t as param
  entry: handle lazy rescheduling at user-exit
  entry/kvm: handle lazy rescheduling at guest-entry
  entry: irqentry_exit only preempts for TIF_NEED_RESCHED
  sched: __schedule_loop() doesn't need to check for need_resched_lazy()
  sched: separate PREEMPT_DYNAMIC config logic
  sched: runtime preemption config under PREEMPT_AUTO
  rcu: limit PREEMPT_RCU to full preemption under PREEMPT_AUTO
  rcu: fix header guard for rcu_all_qs()
  preempt,rcu: warn on PREEMPT_RCU=n, preempt_model_full
  rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y
  rcu: force context-switch for PREEMPT_RCU=n, PREEMPT_COUNT=y
  x86/thread_info: define TIF_NEED_RESCHED_LAZY
  sched: prepare for lazy rescheduling in resched_curr()
  sched: default preemption policy for PREEMPT_AUTO
  sched: handle idle preemption for PREEMPT_AUTO
  sched: schedule eagerly in resched_cpu()
  sched/fair: refactor update_curr(), entity_tick()
  sched/fair: handle tick expiry under lazy preemption
  sched: support preempt=none under PREEMPT_AUTO
  sched: support preempt=full under PREEMPT_AUTO
  sched: handle preempt=voluntary under PREEMPT_AUTO
  sched: latency warn for TIF_NEED_RESCHED_LAZY
  tracing: support lazy resched
  Documentation: tracing: add TIF_NEED_RESCHED_LAZY
  osnoise: handle quiescent states for PREEMPT_RCU=n, PREEMPTION=y

 .../admin-guide/kernel-parameters.txt         |   1 +
 Documentation/trace/ftrace.rst                |   6 +-
 arch/s390/include/asm/preempt.h               |   4 +-
 arch/s390/mm/pfault.c                         |   2 +-
 arch/x86/Kconfig                              |   1 +
 arch/x86/include/asm/thread_info.h            |  10 +-
 drivers/acpi/processor_idle.c                 |   2 +-
 include/asm-generic/preempt.h                 |   4 +-
 include/linux/entry-common.h                  |   2 +-
 include/linux/entry-kvm.h                     |   2 +-
 include/linux/preempt.h                       |   2 +-
 include/linux/rcutree.h                       |   2 +-
 include/linux/sched.h                         |  43 ++-
 include/linux/sched/idle.h                    |   8 +-
 include/linux/thread_info.h                   |  57 +++-
 include/linux/trace_events.h                  |   6 +-
 init/Makefile                                 |   1 +
 kernel/Kconfig.preempt                        |  37 ++-
 kernel/entry/common.c                         |  12 +-
 kernel/entry/kvm.c                            |   4 +-
 kernel/rcu/Kconfig                            |   2 +-
 kernel/rcu/tiny.c                             |   2 +-
 kernel/rcu/tree.c                             |  17 +-
 kernel/rcu/tree_exp.h                         |   4 +-
 kernel/rcu/tree_plugin.h                      |  15 +-
 kernel/rcu/tree_stall.h                       |   2 +-
 kernel/sched/core.c                           | 311 ++++++++++++------
 kernel/sched/deadline.c                       |   6 +-
 kernel/sched/debug.c                          |  13 +-
 kernel/sched/fair.c                           |  56 ++--
 kernel/sched/idle.c                           |   4 +-
 kernel/sched/rt.c                             |   6 +-
 kernel/sched/sched.h                          |  27 +-
 kernel/trace/trace.c                          |   4 +-
 kernel/trace/trace_osnoise.c                  |  22 +-
 kernel/trace/trace_output.c                   |  16 +-
 36 files changed, 498 insertions(+), 215 deletions(-)

-- 
2.31.1


