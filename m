Return-Path: <linux-kernel+bounces-46260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794E9843D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933B41C26885
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2F7745C8;
	Wed, 31 Jan 2024 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QNtS8flB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QBIEHuxB"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2169DF9;
	Wed, 31 Jan 2024 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698182; cv=fail; b=rN+AAegiJqWiwFWgLRfQPKZeFl2TKMcc0MSQfVq/0xVeVXkjP/+LGTwXhAhLkUWX/Gmjv0jHl/CvgVErJHcKq8KJLdRQGagbQsFh/AyNorS+5TTntrFwd5A7yMFKEWS2emj7UdK8AaZVvjhBRRsSbfs2bL6Ug+7OvMkPmxlkPyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698182; c=relaxed/simple;
	bh=0p2KECGGrDUaQ83g+ZjToufoycV8Vie5lOsLZSjamIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fVYL4juB93gFz/9I6OPecOq+JjV51KUjNbVdBh/cOKVD/p/HDaVmbwpUUOXAgeEsrpS0ZuTM0XLNiMIU4h+NEBrYCFzJLKjXVTeAM65Y9bkfRfSBoEpYOXHX0E0C3kpqpmBtR1tjQomznmqzWGHTxIfJM/88PzlCvQOK19+09DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QNtS8flB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QBIEHuxB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40V9iObJ004847;
	Wed, 31 Jan 2024 10:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=9wjyPovYRNxZxlq2Qq+xUkuYPzIcWUmL5xwC1wAoWCc=;
 b=QNtS8flBggWhY3gelpl/e/BkfndKOGxdNoKEvEiLIuiGmpNCIDt9uMM61eeILRba66ns
 LmV+x2WvdrrAON/BpmINNoNfGpcwZNZOeMLn8gktZF5JoZ2o24S6knfEbhF1UDIW6OHj
 sXLcV3vBxNXhyhEwfpu4I8yj38U4S2mZMDIM2uclQ0LggBWTyRnt8NqmGrbKTwrBeR4V
 59VO/qCeFmtFO+LKO8+P0IKjgQnd4Nxq1SSeYqJ7m29tf/Sg4CUuIxI7S9w0j1gTwbM9
 1vqQO62B28UafTw5w7kdnyQBCTW7rWgDlpT3UveJpKTqBFUO4VqyWKJQAxFt2OLSvYMi mA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvre2hp56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 10:49:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40V9YLkL007822;
	Wed, 31 Jan 2024 10:49:18 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9f4c91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 10:49:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgWg+4rpaAm97kTMztBW3FwsL8MfTbLwzEoUWOOfQoFRbt2Xt0GhnkFgLKh0XIdxMAOfnaySqq+sEtbV7P2sEfS05MysXnB24v5pvN+SXMIFYr9swIHBBPqC3sOatiGFtcgEhl3r/ofxJiQpQ/3i8jlyB2YCrENcuQKvywWXsQBgxJqcBTorWAtmWcCg/+XY9W/vPQcuMYmREy5tZNpg5vx9BX6lPmSwFNtfXRv1gVFZ2emtj5YavUIcaCkQWMT58gyYYAcAlF/QPl+TRgMOEIpdBeTk/A7A9jVn6haI/QbiL/OsMeurcFiN8IdsB9RQG6KRoKe3mrBceC55DsErkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wjyPovYRNxZxlq2Qq+xUkuYPzIcWUmL5xwC1wAoWCc=;
 b=M7/GKIn6a8miDms+YgXyDoiQKhea+iX7rVeOHia8HSiXPF7ARngBNcwrfHNxIJ+KvLLWWy91kTdWyaOWzrrGvZtrXV+cbZDBZKtMrnaFH6uVn9YvlLMeHVRE5zASO7kbgb8MLx3bgCzqoNXasYFzkvODsSQaAKn0A10GnK5KuW2AOX7g718n6mjNs93Grh/yr2ZWOgnVUUM6Z5LjIWllaw0LtdQvATE4o7PHWpelBYsEhXkipk/H7OdDgyxp0h3vU7WTCTbtisiKxpOUp5CJM+wCvt3VPIHJ+geK2SCrmzuG1nKQRfl3m0BsUMTWOd3JmznOeHZWyetsnuMmpMJcmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wjyPovYRNxZxlq2Qq+xUkuYPzIcWUmL5xwC1wAoWCc=;
 b=QBIEHuxB3Q7nu6yX3nYUj7fR02SnDKkZtVHFS/mI2QGQWPT54krnTTYBTX64RkNA4lxMOmXxCtJklqODQjV88KTr/G9cg6Dd+AEok0vZJOQSMwA3Er6fJmHqbjllRQ+D7wV2jVGXBz21izd8PDYMpm45oAYWQNO1S0MFfuO3bxc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7323.namprd10.prod.outlook.com (2603:10b6:8:ec::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.22; Wed, 31 Jan 2024 10:49:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 10:49:17 +0000
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
Subject: [PATCH RFC 4/4] firmware_loader: Use uts_release
Date: Wed, 31 Jan 2024 10:48:51 +0000
Message-Id: <20240131104851.2311358-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240131104851.2311358-1-john.g.garry@oracle.com>
References: <20240131104851.2311358-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0107.namprd07.prod.outlook.com
 (2603:10b6:510:4::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d5c2554-8653-43f4-9261-08dc224a4588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	leou84dqVaTRpQKHfghgWmartuk5yaTC4mtgSlykHqDt1IY5dAARBA6ggq+RnO45A8NjulvD9z2XKwbWC323y6pQ9ZJEiDNZ+7cd1H8RwJWydDhzomzmQzZNp9ad+B+xLJpfqDo6nkEv+e8Nn5QRZX1WgfSvVRf3clcqJfmBYK8fGRFk/w0YvtD2EYvjdZ0pKCw0XxSyNHhgWhM59C2s+eeRLsn/HcwsnnxSeLeZFlgCTKIyWUgh8xEZvl5sgsiE5g+DHCFm4Zy2ix82xfHkMXP+EljVbNG2GlfaSVkDq7h8g8u1EV2y04GVW4AphffB/3uKCBd6OPt0fmHieq9WrbXR1e6Q6A2+7xItc6jsfPsz9Lr7/h43SrWJlqqga7j8TVsAWRl5sixLNo2c//u8I/8fOVtMhy4ctVnrD7GNFRCWLhDkDCxPTpgetCFqF9trTNvoG4GPzMm0vzrg+f2ethrRShmJo9K23FTLDVLqniBTh2Pw/kBdmU9V1L2XpXYfrL1uWwaTtSw4KH6ztlc3NyUoVpfeFCrgzF5Z0Wwnt3015ZLrI/Dg5wDCK6Bha/3inFENSLsY5cHoICwYsAmSM0jQwFz/8D8AhqW0tBB3SoM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(921011)(26005)(2616005)(1076003)(107886003)(83380400001)(6486002)(41300700001)(478600001)(6506007)(6666004)(8676002)(6512007)(36756003)(8936002)(4326008)(316002)(66556008)(66476007)(66946007)(2906002)(7416002)(5660300002)(38100700002)(103116003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NTUhIGthGuMujUvVo84YYT9WK+TaLTe+EUCcw7xC5OxKJ1SE9lJa7yX7+jRo?=
 =?us-ascii?Q?WrxM/8x4amNhnQzmLSu6CRDTXId9YsvFcvKzjONupRU26oKbeYhWSnwalgaw?=
 =?us-ascii?Q?fxA84GkXgAl4aHawtFh+k8gBXVuRYKhaf8mfaXQuaCV2Ib7HG0nIUgN65xK0?=
 =?us-ascii?Q?oxFy694DYDmg1m7DDx1ImbD0b/+VgGPJD05Z61c7wCItcLHCZSx3SWSr7+4V?=
 =?us-ascii?Q?09K4M4XIFHOpa75QeUkCGQAeTdS1S1/WAdCPpCrh5jxhu/Z8HvrqHRNDKguw?=
 =?us-ascii?Q?2yvyTs6uupkmUQAqq1lg7tK0IUlKvV1d2WRLB1kb7xbmOvq72tSCUQ2OMUQi?=
 =?us-ascii?Q?7PBEIkr4qgi8dm2sSleLy/vhU/YEQR6+5iD4nohaVu72+cvwpr5UmeoYaTgv?=
 =?us-ascii?Q?jA+LCQlwHXv4O95fVIoPCTwcAZ9EKlJxGhUzJLEZdiKDbpq0+3r4/9iJX/nW?=
 =?us-ascii?Q?SI7FfwQSigg9vauILbArqPguRuXiEenkqiIMD7bCahTD7Y6/sCbVtCmpwHwW?=
 =?us-ascii?Q?YP7EIAoVCo4uepheym0qMzNIc2LWnoYut+j1EXR1vzq1P46fobCI0o7HsT0N?=
 =?us-ascii?Q?zp7VWJ2DYWDcVrTyALNJcHmfF3ixT31DpyemYb3zdCFEDGPMDkjiVZjZTJC4?=
 =?us-ascii?Q?I81OFcZsQZaDbcJ7cHG5uUFmC4JzWT6HnsOJM8pkxTVQ+Gqw7Z7I+doU83i7?=
 =?us-ascii?Q?kmFIbvVtALPwRpttzo/BwGsspNLQCxG8BwMajuX6rjU7Qk881BFsWiZvIW0P?=
 =?us-ascii?Q?rkr+oYhWVkymrRKiENdfOr4eBYjG9GiRpfzy4wSOCKBZnbwryaY64FmqC+Pc?=
 =?us-ascii?Q?bOSWkeO3uPTV3HNGnhTgm10AAAK259ubWk5JjIgIz+FZI/s/Twlxdhs6hhsF?=
 =?us-ascii?Q?4oBCwXqQEIG4TXAMeFjWrdemM6bbIrk7RIpSXrnTteBrsOb00RV2EnYNT8Of?=
 =?us-ascii?Q?JDAnL97TXUSBnS0Caauk/Eb5qXIgN4nLRMsQuIlcQPt0mOSTeiGBeh5WsPtR?=
 =?us-ascii?Q?fUlt5Nm+rLIkFUBv1PAKy9SHZi3xmTvAnjIt4/0LgNWbq2TBB53WzqpELH0O?=
 =?us-ascii?Q?ABDzQz+8Ax/62PwkX9JBto6wSV9tsETCd+K6zJsuhVRwb70EMWu1sK7KBhi2?=
 =?us-ascii?Q?ItKfTxVHem7VjVlTGUFVE1BO3TnFMJfJL3lt3d/qP6H+Md3kE+IbhpOzXF76?=
 =?us-ascii?Q?qT0znTtjUyVPLsEPTA/3UWeZKKaukhyG8h1bJPy1PKlI4Fp7xSuNJfnEje2Z?=
 =?us-ascii?Q?o7YMgvlYmAPSLAyo7PmV38f0yNA8yRSYGsfWbEm/lxT3XA10i3nmujNHN1GJ?=
 =?us-ascii?Q?OSs++It0HT5ZnNg3cSEBG6K7Ueb+c2UUq6Y3dmbS7JImGnLXT0pu9JDOFmi3?=
 =?us-ascii?Q?oeMXGb3JX9rFeUt3kta9I9I/TRMwMOUHblXgUJsFKG+UQKaiggWsUjCkhWev?=
 =?us-ascii?Q?wM9W4S+b9RlGgEU/aavL/utqbkhytLEGfVdIvwJaMV5TYL3BJxSHB20iTKTR?=
 =?us-ascii?Q?LdQcwItg+FqqiPiISGvLUrVQwYFpZFfuOu3CZNUh9FUMKflJXOGufxiuj0US?=
 =?us-ascii?Q?5/uzDyxs/EQ+WioKch5M/rpIf96bWpdic+rbVXeE9ELVYBxnw49tOWuU3eiP?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UKdPI2zLhFS8/ZmlA9LtpLZW+CDD/fDOU58361sEQ+9HV0jHTRgRbn/TPFPVYMTSE5yqrV8zQitLW8X8Z2/ACsoR49/xpAPZ8HGDEaifmhh/WAMGeRaQnbR3PJTd7wdbxls2fOBXnC4oG8R+Hkyq78irhlw1CrFFaDoLHD6/j9zbtj2P/Oi/4G6Zprw+DDzB7qJbeQlQK5tuaR7JxjtD472Kolsgb7AyU76gS1Ol3GimEJ7rx+JCjk2LbFTb/1sOA1KTtvAh5fPF8yGJOAk3QUl4Qm0RRyKVuvSvQWatYBtSEop2B54Up9kJeRiMBvM4Ml5cyv0DgzDK2PPBDSBjQN/ltp6V+5iABV8rc4WdBmPsgdIPlDU1f6pZbUkuQAlv59ngVY/FLHKKI5JaTXJ3hJL+yQp/XfEInS4lJRzL2f0fD93JAMKHG0kNYblXyMBffHMvUPqSA0HAD/dozwwM10RIlO6IQhF7nK3+xEF5/DmjHp5Ixb5wyD8edO2wnBNhYf4Oh0RLjO5zwaKYSywzQX7hFiogrPkv00Htgz0VsA8sawjj5cWdASJThLrqKI5DRcpewZv8jqfIIyKkb9zuyuNcGyEkuzYk1Z0aSOlxF5o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5c2554-8653-43f4-9261-08dc224a4588
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 10:49:17.0775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXZqAdvGyyQiOz28QSrdeXgG3vjNn16axbUNSTln5gK+4sExkrPLdEtMN/Ns5Z14H1Pz4MRynA9MyviQ82c4OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7323
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310082
X-Proofpoint-GUID: MnMwAmFC07av7qcK0i4uhlvlXW7OVANc
X-Proofpoint-ORIG-GUID: MnMwAmFC07av7qcK0i4uhlvlXW7OVANc

Instead of using UTS_RELEASE, use uts_release, which means that we don't
need to rebuild the code just for the git head commit changing.

Since UTS_RELEASE was used for fw_path and this points to const data,
append uts_release dynamically to an intermediate string.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/base/firmware_loader/main.c | 39 +++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index ea28102d421e..87da7be61a29 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -38,7 +38,7 @@
 #include <linux/zstd.h>
 #include <linux/xz.h>
 
-#include <generated/utsrelease.h>
+#include <linux/utsname.h>
 
 #include "../base.h"
 #include "firmware.h"
@@ -471,9 +471,9 @@ static int fw_decompress_xz(struct device *dev, struct fw_priv *fw_priv,
 static char fw_path_para[256];
 static const char * const fw_path[] = {
 	fw_path_para,
-	"/lib/firmware/updates/" UTS_RELEASE,
+	"/lib/firmware/updates/", /* UTS_RELEASE is appended later */
 	"/lib/firmware/updates",
-	"/lib/firmware/" UTS_RELEASE,
+	"/lib/firmware/", /* UTS_RELEASE is appended later */
 	"/lib/firmware"
 };
 
@@ -496,7 +496,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 	size_t size;
 	int i, len, maxlen = 0;
 	int rc = -ENOENT;
-	char *path, *nt = NULL;
+	char *path, *fw_path_string, *nt = NULL;
 	size_t msize = INT_MAX;
 	void *buffer = NULL;
 
@@ -510,6 +510,12 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 	if (!path)
 		return -ENOMEM;
 
+	fw_path_string = __getname();
+	if (!fw_path_string) {
+		__putname(path);
+		return -ENOMEM;
+	}
+
 	wait_for_initramfs();
 	for (i = 0; i < ARRAY_SIZE(fw_path); i++) {
 		size_t file_size = 0;
@@ -519,16 +525,32 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 		if (!fw_path[i][0])
 			continue;
 
+		len = snprintf(fw_path_string, PATH_MAX, "%s", fw_path[i]);
+		if (len >= PATH_MAX) {
+			rc = -ENAMETOOLONG;
+			break;
+		}
+
+		/* Special handling to append UTS_RELEASE */
+		if (fw_path[i][len - 1] == '/') {
+			len = snprintf(fw_path_string, PATH_MAX, "%s%s",
+					fw_path[i], uts_release);
+			if (len >= PATH_MAX) {
+				rc = -ENAMETOOLONG;
+				break;
+			}
+		}
+
 		/* strip off \n from customized path */
-		maxlen = strlen(fw_path[i]);
+		maxlen = strlen(fw_path_string);
 		if (i == 0) {
-			nt = strchr(fw_path[i], '\n');
+			nt = strchr(fw_path_string, '\n');
 			if (nt)
-				maxlen = nt - fw_path[i];
+				maxlen = nt - fw_path_string;
 		}
 
 		len = snprintf(path, PATH_MAX, "%.*s/%s%s",
-			       maxlen, fw_path[i],
+			       maxlen, fw_path_string,
 			       fw_priv->fw_name, suffix);
 		if (len >= PATH_MAX) {
 			rc = -ENAMETOOLONG;
@@ -585,6 +607,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 		break;
 	}
 	__putname(path);
+	__putname(fw_path_string);
 
 	return rc;
 }
-- 
2.35.3


