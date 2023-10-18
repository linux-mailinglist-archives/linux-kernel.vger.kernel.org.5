Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83ED7CD16E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 02:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344232AbjJRAos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 20:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjJRAor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 20:44:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C93AF9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 17:44:45 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HJwswC008171;
        Wed, 18 Oct 2023 00:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=+ApPqscOIDWc6QzfO/rULCLSTf892kyBkF1bQmxr+is=;
 b=nKhMA6kop9k0fpwvxWHxKLZ9NlSrTU6OTVbOOPvgqFsQMtWAiAuFg2jZtI7wS9Zhdcxq
 drhIOdILFupionyhKsrX4+JjFKZaQFh9GU7qptIer/psEeGrvtGxBMgo7ZdM+OJ6zujP
 TN9GvAz2byStqv1OJFjeTAvqfj2mmEPPSmCM5g2PgXrLobHEVd47lpaKAqcKP+cWc+li
 1cwbCZLRWeh5pz0Nc+nR2YlNsc+vHss8jUggI5zgL5l1ArPzGFYi2csy2y5LVQNY+dlW
 a8Jb4EcEkKx4qtcnbRn7cOMz5mlmJmROeEATp+jOpyTLui1vd4hXJnOEcIdHYgOVVgsQ TA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1cxefe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 00:44:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39HMb1BI021622;
        Wed, 18 Oct 2023 00:44:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg51sk28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 00:44:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2GjrsdEue6sKun+VD66vp65fezecA1h47dB7Be5rhEzurQ7VLgDfr5wLwbG8ljHeZZX7IV/nikdY1Adr37AHx5XAIwjX/Z+V5sToB+03hWtMNlowDb9Zd8emYfjFFSRoZMLjlCZwc4E5Wc1cX9c6D+SEosxD2/90OJp6GIxOX0Xke8/PVClTjUgVNyb7AxMp+0CRT6bQgD47wPhTEWvOTxpRo3JYaK5iVGWPO+fxhPv1DQdTEVxZNpc1mx4lQXS1/Sy0qTYvB2Qu1iITPFX8XUZNBCh0300YaRpFQ1YOKbpXDDF1A4o1vA6pouNExDPkExM7g9pbvAqaJ8Yb7HQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ApPqscOIDWc6QzfO/rULCLSTf892kyBkF1bQmxr+is=;
 b=D/VpzRXNcFGyxYbatsX6Y0HQTeSvYQwm0mriOOuajAeoU215GhcB99YDJIaHqjDJIQIV6Kv/Glx5a9XZClGXZttXedOw3d3oK79URTw24/p89RyDJPmjwEA5iEzVtgdfB+3dbMhcbMbwN/r+jPvCS7uZATxsayuZHUp23f50uxn/VpQSJrBYEFa7FXpFBSO2aP17g5vUge7mnuB5nMctIdMdcF6MDYZtcXedi/WGIa7udRYV0wmisfkVdeSf/DXuwWX4wqNTaEatqbPLGvZRsPCrWt3Z8Tr7ivKsN0PVneckXFAXOmE/1OwM+zEOEtM/ST4HO1ZIyE58JNz7ulzvbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ApPqscOIDWc6QzfO/rULCLSTf892kyBkF1bQmxr+is=;
 b=vtExNp1iXftpSdyfRNtn8BSlHVCk466xVuC312DHVZ6w+NNKBpFEDfgsJLGMxTAfcxsy5NNZnZ9pJOQBs1mnfbtlW/Xb7ATteewBPTTHWMGK26MYvw/Rvl4NCYwpyNXiQgzNwNdNmuo8Rr9pG4dmp0TbtGX+Fr070QLGCqd7IAg=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by SA0PR10MB6426.namprd10.prod.outlook.com (2603:10b6:806:2c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Wed, 18 Oct
 2023 00:43:59 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::e277:20c3:200b:7790]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::e277:20c3:200b:7790%4]) with mapi id 15.20.6863.043; Wed, 18 Oct 2023
 00:43:59 +0000
Date:   Tue, 17 Oct 2023 20:43:54 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     bristot@redhat.com, bsegall@google.com, chris.hyser@oracle.com,
        corbet@lwn.net, dietmar.eggemann@arm.com, efault@gmx.de,
        joel@joelfernandes.org, joshdon@google.com, juri.lelli@redhat.com,
        kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@kernel.org, patrick.bellasi@matbug.net,
        pavel@ucw.cz, pjt@google.com, qperret@google.com,
        qyousef@layalina.io, rostedt@goodmis.org, tglx@linutronix.de,
        tim.c.chen@linux.intel.com, timj@gnu.org,
        vincent.guittot@linaro.org, youssefesmat@chromium.org,
        yu.c.chen@intel.com
Subject: Re: [PATCH] sched/fair: Always update_curr() before placing at
 enqueue
Message-ID: <x4ptje5uqobysfje22cqcxn4ajatq7nyj2zldtkt5t7cjqvy5x@37flzfaselbx>
References: <20230531124604.068911180@infradead.org>
 <20231006164826.335223-1-daniel.m.jordan@oracle.com>
 <20231006195810.GI36277@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006195810.GI36277@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: BLAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:208:32b::26) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|SA0PR10MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: f245136c-486b-43fd-fa63-08dbcf735118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e9XXOXaFfH+FmG8q9L3+O5jMb2gbxS2m7qLClpAP3di9k3RJ2DJ8eofKlxYbtV0mU5Kmdgkqi90XXbvhFgOluluPcJHRiqWTkXBk2SOxhckYcJXzdDXxLocGkI2mVhVZtuIvM6+J6EY+WWxjf1boHKsRDYBRGab4OrTpx9P107W4SNkUQ/+94I9yorBru0GqVp/sztZAweFb2PJraZoxVjlYX2OPHoByJlZF4LamY/a6tQpc4CVWmR+coRcrTy5GfVvHqvFWedWNDZxbN1UIGaD04b6OEjShF8AEcN/kEQwxYaYdc+kblMyXZmGPVSDvx6KqaaOqF2BCNfj0iKN0B83EP3M5wXmKyxJnxe8UeahYtLgmghanMY+YRqfRDqWPvnRFsphPfjAzrNvA82Q0KDn3w4YGEap4bNI+FBTh0KcqMQUc7+JUecJMLjJ1fxb9gA3JyXGaRVR4p/n42NAsDFX+JKnE+hZeVv37ACYMiPobbsKzsJxDcQs+VA9jGgx1NbbNDS81C2v/Nn596hfubvuBnbjeTeD+5pYWwf+zygqGlG6g2ikfYdKWV94/y5qdiQaWaTPWCLrTDvT5s1NN3nzHAUbKDGmBYdJsShGaN/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(9686003)(8936002)(6512007)(6506007)(6486002)(6666004)(66556008)(83380400001)(33716001)(8676002)(5660300002)(15650500001)(7416002)(4326008)(478600001)(66476007)(41300700001)(316002)(2906002)(66946007)(6916009)(38100700002)(86362001)(26005)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/bvUftTbsAuexw/n5tQS9xQHNyUzidjk8/6UJaOmJpS5+2sNrkLQGVIQmu21?=
 =?us-ascii?Q?Oqvc1Y4v1ndJmJQwBUVFxFj2TtwQdyBuM0il8I/0st/i2R4GrLW/7c/DFvL+?=
 =?us-ascii?Q?GtKTeurUtRkfqPxQw6qiXBQBR9dETShCplO0iyTvjMCCoYQTjwAWEjD8AF+y?=
 =?us-ascii?Q?SJf2gkVylDI6r4iPWOWglG8bqaCFx1kkI6Amj7uJuVdymwS6iCXYXxWqV41O?=
 =?us-ascii?Q?vjwbt4LSUD34k7O+dlQNNsNo+qoQOW5ynTqDbErM09ytTaL8iT+waUZboT60?=
 =?us-ascii?Q?Q4otHprTPTvcGB5HFVeDCp4POP68Tduj1S3PB1gTMvWWttZzDm1aRzltBLRs?=
 =?us-ascii?Q?Lx+foUpWEMsWelPSJ8IXCpTpnx8FD/eNQUFg9/VaD5WMx6YRZ54BVAzZDrqx?=
 =?us-ascii?Q?QJdDp70j2nnmlYlzKRrXfRkBDI5iKp3kLGOcZ78M7Wu0PFVWAfEe8AU9R98x?=
 =?us-ascii?Q?4DBjNEdgk08PUe+OCf0Jq8CvSelMCWGEhQUfrpWZxkzh2AVtLV/sTmB4WZRg?=
 =?us-ascii?Q?qN6tBoM5xG/ZTBVGhgI4Ajs8bmHATs0Wkg+2xccO++zual9tG7VXFVg7CP0L?=
 =?us-ascii?Q?1sUR6T0QnKR1AMeC+lxdjdofoiwiJw+SeQIqnMXpiVfDaSi9Ak98j7La9Upa?=
 =?us-ascii?Q?aJEJ9porhT3R6jHKI6oifuMUzKSjqWjs6srQZ2FFKSZ+Jbrwfg2AjMmIrMRn?=
 =?us-ascii?Q?2g7kfJuSn8Igx92xyUQvAJ/f6fkLqPB6OOjeqlqbhewWh2ZJv7oBVUeRxrhK?=
 =?us-ascii?Q?6u3u9GVUwlUZBaGvsK4m59kbDRAgyWusYWsyZuI8+kqKFgwwkm3tdUvJww5Z?=
 =?us-ascii?Q?8pHuN7mIJZMhzh4xlnzzttascaks4Qxu0Pn7Iv20Jwg6ADnl7Pga3v7UV3Qz?=
 =?us-ascii?Q?msWjlYKWB2NYMnKgMT1Yk08C3clFIGmIEK2RP3OSWvMZJI9ShM0+ezWaNC6x?=
 =?us-ascii?Q?BsKrBtAqFanbUT62MS/xpJAkhQAzG36dxrLHVEgObP8LBXsUOKdo30LSX15C?=
 =?us-ascii?Q?fb7j7xO5xhNXm8TieCHPM10scQdRZGnxSVVDYgLKRTLNnxaTHBC6ssAFAK2g?=
 =?us-ascii?Q?MJ6UUwfdmIE9w9YcR2EVi9FNNlHBf86HyTifw3LinCxahrsxJlMbouc/6/m/?=
 =?us-ascii?Q?m0mjk/baMc2ntwJSZUnYdZVDgp5U1CsRDatoCyiOu945aersauRP341waFtN?=
 =?us-ascii?Q?hVCV2bA7PsD9hzm2OU40vEWkPSHaK4LLWcZORhwdiIjP/whqeIr21lsyN1K7?=
 =?us-ascii?Q?W3c+qgSu3QBuicGC2UhpliBTl5crZnun/C2GiQJ3J15Znn9BwEJkgwpYvxVN?=
 =?us-ascii?Q?anSbYdBvL8aNPdO0CWs9evCob+X8Cxa2hi8oiTgJyCJIwuG7shqXuBPWs3US?=
 =?us-ascii?Q?CTXZxpHC6DwNWow58kXxQ9vu+/R5TiE9LhBomw+u14O8UaKhJ2yufMu997Ow?=
 =?us-ascii?Q?EcpnJfg/wdTCjHZK1BxNr6MU/Z8vmPCIUAT9BMNYzY2IDVeeCUpJFWBgIHHx?=
 =?us-ascii?Q?v62iM32p/A+yiwyIKTIg0HfuaurUJ1YeLHgMKRetzSV3EDXmRLlFYm5CR/3E?=
 =?us-ascii?Q?JOj8HwrggeoD2kmpH5nXR7YXomFpSaNXukq3zEFoSNOGQ/wFcOLttbu6G5wu?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Boy0373++YBWVcYHeyk5WctYGuwEAyO+GJoQsKFsEkj+Fsnd2G/J2m9fAOjW?=
 =?us-ascii?Q?J3TKsp0N3UlabGpZvMr4/VHk39lD7XHZQnX/ydaHfOr2y3Y82cDOrsgpD4B7?=
 =?us-ascii?Q?pJI5XSZpjQn1uMFO8HpVJjgQoZpNCvFLw/xCB81Ep2A708J0HQgkjkAf6DW7?=
 =?us-ascii?Q?6CxghzcrBRvoT5q3pW4MkQnrjQ06uxkPLd5IsY+gnRwqKBzH94lvSMm92PHo?=
 =?us-ascii?Q?EBVTGgHKyNzs/xiTjjbc2HzdsWo5zWGmYeAqkyh8AFtfWYf0RY/pc+6hZ73y?=
 =?us-ascii?Q?z02RDqf4xBSu+9mWmZWkCZfIGBdmwiBuIE/vZkBQO7ycGt7yg4eLQX5qeMJl?=
 =?us-ascii?Q?+hSFZeBLkur9j4S4AqIKBpcm1IIFOd0ga//lXtBI46LarbTryBg1XKhOIMEZ?=
 =?us-ascii?Q?aRZ+CITFCYfu46PaR6eLW9GD4hiGuyCP28FxilwO1tOPKiEXX3yiPgc1gqiL?=
 =?us-ascii?Q?TzpBDLkLcbOqghw7G94nC/yhUeq4+prRaCFhId+iG9a7fMh8AHrRbcXjn5+K?=
 =?us-ascii?Q?dedrfEZ+RBK4TvvgTjIr0EXvfuQkW9H1yp4axsAT9WSRpjM9lFY+/cFq5/E+?=
 =?us-ascii?Q?ArassLXjPNTiuKUMku60Lg1HnZWnuOPTxo1eKRpigFq5oCtEejb8zmM9g8IA?=
 =?us-ascii?Q?rYYtEqnRqjAf59XAyo+pYyW6STlUDULqoW8xT7d/XZezkw7PBRl8Fk/7rusW?=
 =?us-ascii?Q?p68NVduj2SAe/hyJd+CurvrWLBjKUPS09fneQUrGtK0Wgc+wRUNDRF99dxdu?=
 =?us-ascii?Q?bYnGAaKVeNLuLKH6BYiUIWIpLBCLaED0Nf02JZj05EsJ7432GXj+zmBWChBB?=
 =?us-ascii?Q?6XoYrqtpeqfcfIJIVCMKRX7IZCi42MgrPniwpWy1cGoaHPFA+7M4KeybQ54O?=
 =?us-ascii?Q?uO3ztaqO61gW8/4wjxvxVRvdglHrvG6f4KinXkvwN6LmWb4VmzI7ZUFb35r7?=
 =?us-ascii?Q?wUkS3rlmAPfPyA6rnJlV3wHE80ik/w0GAz7j1YdNLujUzVuFjL91wV6tIRRZ?=
 =?us-ascii?Q?W28Km51OkfyvSZEc0c813td9HTvMoQRLTHX0AN8+l9Al5AGPdz8zYRQuVdZ+?=
 =?us-ascii?Q?qmRiImiXxpDGRtyHfFzX1C4z9oZKyiluRq4r6T9/KCBsIreJUN8JHYx/cf1g?=
 =?us-ascii?Q?w8Z42S8nyDlub3Yy3ezY7uUZ4crf/hvKjuMC+vOe0H/Wu7qeYgHJXKmYcriY?=
 =?us-ascii?Q?LijTlQHeKyLjMWAJKTpvukZO5rrKjy01WeOjP5ILgKinLeLoRvFMAcbJIMAo?=
 =?us-ascii?Q?P4RACcd9qSIDdllwXll1cg3fqoRl4pEtlGuO9geVb5jytV+Yz+pt3bEdyoud?=
 =?us-ascii?Q?weDrAVegR1ZTr2ac980rBPwsgCPfeAesm9jrCfvTACe8Jw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f245136c-486b-43fd-fa63-08dbcf735118
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 00:43:59.4669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oR1gGRyxiXBumJd3Pngsg96DhFM/A45WHPpIJfxjfftisSYHxHIRGvGMYNM2lBNdTTv8GScw1pv42jJDI1A6q9kLTh+Ml5eInf6b6cozwYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6426
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_08,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180004
X-Proofpoint-GUID: uPo5CVO4qobpg7lAFFrhjPeFVYFgAdi4
X-Proofpoint-ORIG-GUID: uPo5CVO4qobpg7lAFFrhjPeFVYFgAdi4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 09:58:10PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 06, 2023 at 12:48:26PM -0400, Daniel Jordan wrote:
> > Placing wants current's vruntime and the cfs_rq's min_vruntime up to
> > date so that avg_runtime() is too, and similarly it wants the entity to
> > be re-weighted and lag adjusted so vslice and vlag are fresh, so always
> > do update_curr() and update_cfs_group() beforehand.
> > 
> > There doesn't seem to be a reason to treat the 'curr' case specially
> > after e8f331bcc270 since vruntime doesn't get normalized anymore.
> > 
> > Fixes: e8f331bcc270 ("sched/smp: Use lag to simplify cross-runqueue placement")
> > Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> > ---
> > 
> > Not sure what the XXX above place_entity() is for, maybe it can go away?
> > 
> > Based on tip/sched/core.
> > 
> >  kernel/sched/fair.c | 14 ++------------
> >  1 file changed, 2 insertions(+), 12 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 04fbcbda97d5f..db2ca9bf9cc49 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5047,15 +5047,6 @@ static inline bool cfs_bandwidth_used(void);
> >  static void
> >  enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >  {
> > -	bool curr = cfs_rq->curr == se;
> > -
> > -	/*
> > -	 * If we're the current task, we must renormalise before calling
> > -	 * update_curr().
> > -	 */
> > -	if (curr)
> > -		place_entity(cfs_rq, se, flags);
> > -
> >  	update_curr(cfs_rq);
> 
> IIRC part of the reason for this order is the:
> 
>   dequeue
>   update
>   enqueue
> 
> pattern we have all over the place. You don't want the enqueue to move
> time forward in this case.
> 
> Could be that all magically works, but please double check.

Yes, I wasn't thinking of the dequeue/update/enqueue places.
Considering these, it seems like there's more to fix (from before EEVDF
even).

Sorry for the delayed response, been staring for a while thinking I'd
have it all by the next day.  It'll take a bit longer to sort out all
the cases, but I'll keep going.
