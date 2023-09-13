Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26A779F06E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjIMRdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjIMRdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:33:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D30E9E;
        Wed, 13 Sep 2023 10:33:36 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DEkLTo032128;
        Wed, 13 Sep 2023 17:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=I0EbasnpgkfoCHVY5EAhC3vUvGhQaMzFRjtMjLaXamc=;
 b=qiX2zeKNGxQ53tG6D0AKZlZm423g+2Uq/76L7d0oxQVn+UNIEW2RRKnDpT0wYxS/iW8o
 ZfE6gn1smw2GaFe2/7GT5lE4hdNE+d2dYz4fSM1WZ6WseYahaC3x9yO71t6HsI12L1p7
 Fs0FmLL8ncHzXQxxy2sx+y+6wtZ0QI27ZIKldY6e1Vr3pme9zW30pTLE/v8sFSDRsuxA
 kaTSoihCRNzfVpYiSXN598RiOMMhRnLWlef3NbIfG9mz1abRQ2OJZAyHzs3t+R4lof+h
 +dqQIyqVubHwNJb0M+O8Gvv0mSglHjwbIWdmDk8yPwnSTLvT0N6N3S0gW5IsL+KNTPja oQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7mtpnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 17:32:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DGxBqJ004468;
        Wed, 13 Sep 2023 17:32:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f58av61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 17:32:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3FG63JwH1gjOlrGtFG9nI/PkABnpJJokB9Vo8CxaLOfKeImjPp8VpBxX/xgfo0DVj62bXZVpAAZvNO6WVFuQtHFmNX1Ju4nIby7VahzlM2SYd63mz18qW5Mx45yWGo+bYKfXdzsTBmsoGfEjPDBJtxYh6Sl4PMYQPWbKCEr62D98NCvw0gBYrEouk0f3Xg2Ogxt2F72Q4dhGMkeQmHtsh8V+6pPJnTdEwKgERqkYhUq01NyXMKXuEw74AhLpDk73qkxzVu4yPOBChTIvxXKdy9duu1XGUC2j9yunPtum8+oV1zfU7K0DoZPi29Z85xnPugVqZ+S/H6yRdFDR1UcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0EbasnpgkfoCHVY5EAhC3vUvGhQaMzFRjtMjLaXamc=;
 b=a1jtkMmoVIGLqvaP09kv7J/khJUXSm0JkdlZIWXLVk+8Obg+bJd/muPMmspKD3UWLn/9TKDh3DIqWQPiRMPVsQOhwG0fmaLnyv33I6D9VMr50lJBDcVH2HPsxxUpFkrcxNa7x/BUipIbb7v13WlYJRKT3anVLLni7hpsvECrdGxlqtYrs5GffZpbXgEsxXeXndY/Y7sLj/OOaixM+DPqPFTgFgvHvQdJtivEQJ8Q7eQkK4of5z1O1IANIR8Xvqy6AxWMBBH1I2fVR4bTnjUrKSV4bUlPNk9OE5XX7wnUzhAH9o/8SuFalY4yg7vcHNx1Vk2Xqa1Gpnh8h2bXi/Ulxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0EbasnpgkfoCHVY5EAhC3vUvGhQaMzFRjtMjLaXamc=;
 b=jssy0GH8dFsCvhqzsidZOytAeTcdB9gnLXn+yCXCU8cU1btV/RSGP/BeRPifYLtXscEXRFrlcxeCKZOMs6DeyrFytQ5MBDkFuV1JcwLMJ/SqUiSbEemoKVgQiNTwSFdPtB0une6aRpYZ70F3kGtWSFOf1zpi6TypeIjbnAVaH8M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5234.namprd10.prod.outlook.com (2603:10b6:208:30c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 17:32:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.036; Wed, 13 Sep 2023
 17:32:42 +0000
Date:   Wed, 13 Sep 2023 13:32:38 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] init/main: Clear boot task idle flag
Message-ID: <20230913173238.h6tj4lwsbdxcuswo@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20230913005647.1534747-1-Liam.Howlett@oracle.com>
 <20230913135246.GH692@noisy.programming.kicks-ass.net>
 <20230913145125.xssion4ygykunzrc@revolver>
 <20230913161236.GI692@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913161236.GI692@noisy.programming.kicks-ass.net>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BLAPR10MB5234:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e18517a-f05b-4219-73f6-08dbb47f6ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hd4LM1FOb3m9Y6zWikmrx33EkUK22jn0Fr4JZMjbAr2PVkwufPXPmSPN9PDzwD8yOx1c32vuhd0c+kS34JNMEk3aZbXhRRLE+IayqHLQzl+LCEuSwoBWKL4f/lGY2WZ5wPA2iJ5Pw543CFQxZJjh4vEDzWYPNSVBO8WxE8748L8ezXCYGaqtBUgNhucQQeA1zap2TaniiHLyutWkRfH3uLBsr4KbleiGcrPS/CKr4GJfKpGyuh6WYvPpS8v6OayK5t1KCettTJAfT7zr2FSWUojx1aZwVrMTobCM78iJRFFz8yT9tP56uaZnbHAqG4ACOzfLjuc36+UGopJZQpXubXTbdpjtiluszTTE88WSWezJZbiQAknEvWjhQHSBlAkOUIkgiwyZZAk5O908viBgwXErJLUW0z4Hn5CMFrddfAsO6EGcjb6W6zucXaLeaHDYg8Z47xy12cMt4n3qaT6AalhFDDUz3g8JDJ00hnZ8oGJrek1wh6gzpMky1FquWJlVx/mi7CuKvHGeRxqOswQYO+VflpDI8Dh+y1f9Ox7QZ9dglUpRkuh0P/k+CYUqR+vq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(396003)(376002)(346002)(136003)(1800799009)(186009)(451199024)(6666004)(6506007)(6486002)(86362001)(38100700002)(26005)(1076003)(2906002)(9686003)(6512007)(478600001)(83380400001)(5660300002)(8676002)(4326008)(8936002)(41300700001)(33716001)(6916009)(7416002)(66946007)(66476007)(316002)(66556008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2TYpVXyZMDkgKofvlAjkD556KKYjlUhvkLCFGKFOiye6riSQ1AKxSxZu6sE0?=
 =?us-ascii?Q?BJPyxbAfjjt3NXrBAXKGueUPAGxbo/WjnqTgW/Ct5FcmF/2iXUBbiXOh0s2W?=
 =?us-ascii?Q?5AUFjeaT8vB4gDU7jRXU4uIKYic5m6Opn0CmkvL4OgZiPkvmsGqGH7XKrj6B?=
 =?us-ascii?Q?CkIYc6Oc5QE63c0vFyEEGZsaBRvjhIhDGlYHMeU8y5wV4vhFPdcvzOhHwv2n?=
 =?us-ascii?Q?ZKz+kayWx9e5b5RGQVbN6WoGXfM7s5Ht1KUuYi/FuJN4/0SGAWODAuR9L777?=
 =?us-ascii?Q?xlX7SDNURx4Yr78FBsyQu7dPNJA3bJrS6zcCK4vFN1j2nt6NSeIrUPOUnmYR?=
 =?us-ascii?Q?xhNLuqjAtU6DE5vPV0eEAc18jTqlu9GSIiybCzRFjFuLdjXBGk/0S+z7WK6Y?=
 =?us-ascii?Q?Gyyydyb6Ii6q5lxMG3/JxhexzNtxxBfaxiPZPk0qoxDFKIf34a/TycWfjxuu?=
 =?us-ascii?Q?8wKxkEFHpX//c67bJjqJg4IXdl24MyIYeZSqYX0oZuzJfFHFG5PJE7WktpyD?=
 =?us-ascii?Q?OpL6Qeaq7F6fgbXlDgXTO3cefziRu766lvLNl4EaAsQLUjDD2sV1Zz5zKKwp?=
 =?us-ascii?Q?tu8QDUeXpAqeexnAInNDysUfrGoIhU5cGruItQrD507rzn2Hxbtw+Ok4NbCC?=
 =?us-ascii?Q?lgIbpFVpedOzYTWWzo6mB/A3h0gccdfsKcMwDUf1tLnhWbdpKha3DnjhxQhH?=
 =?us-ascii?Q?AwSpO9qrqKn6lcLRCZ06o3Ac2gTWR4Gi1+p+YB52ddBlvnN7dG3tP+qgyXFx?=
 =?us-ascii?Q?PbiR8VvDpq2ob2iE4cy97m/Uo5KsjMtKMmI+CqelK9xIhai6nbGqWx0M9Ych?=
 =?us-ascii?Q?DAYiRmQC6Kq5HGDAx3C8zCBE87CSaIwHAbMv3x3aNAchRn8a68IGX1xlPMEX?=
 =?us-ascii?Q?/FoTedNB9iEkiHscfiL0PHh5W+wGBHwXHx5qnThgLokJZQSTOShEYtCVGIgP?=
 =?us-ascii?Q?YlQoFV+TZyikaMByjVIjuD3RvtM9bZArUUU2hTCoPICG7Xyax2FB21hQgerd?=
 =?us-ascii?Q?umMuDMr4ziWAld91IXvzvWrstBUo5CVjZldQfk1pyiYggO5JADiDiXUPoGnX?=
 =?us-ascii?Q?8AnewexnQEkUgqmrZOQfdGWj6Je5LFTWzSoGd1etdHARMFLR8uUqrOBzAk9+?=
 =?us-ascii?Q?UxxokJL2LuULq3edwpSC3vRQkhGHMNjkd7DzXL6h5BXl2N9ek6A4ABnPfvwI?=
 =?us-ascii?Q?RtGyKPylG0QhRJW+TcKwBP904AXNmzq8xLOwrLJ8ext9j6LqKUG9kwKsms6S?=
 =?us-ascii?Q?nubTRV+5JxDbNlVkXNVaKNo8k942Clzsy5te8tN2sj5v6xN/Hzc8g4PQZtIP?=
 =?us-ascii?Q?A2F/KSnte1P7pFdUCe2Zz44ZD5cpaTmqRLdD6bTBpQp5vhS++JPyghUGTfYN?=
 =?us-ascii?Q?32fchpMixL7sBjZInbTDYWUji12n8mPfHeHljipL+BC0Q1MgtLWmcRuKHgvZ?=
 =?us-ascii?Q?6MbvJrE9GWiFjur8yxGJFTY3Eq1UT0PfBWfk6DtTPgpwxT4jg1gO3UnO5TrS?=
 =?us-ascii?Q?Me+eOK7xrm1alMAvTlQ1ue4cUNmS+MhffwE/FsJFi3Jce0jgEdH9Q3sV1uqN?=
 =?us-ascii?Q?xZqWwe+08LlDfvwAp3mHmEnQaDJRED1fjs7QHltT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4Jc+hYa7m4v6PF5WJOb8K0DqwK2cgHvuM2hOt3iqValully4jT5rjP/Aw6lz?=
 =?us-ascii?Q?gzVMxt0SkGamxjzCQ6U52Bvb+2/hw9js0BMeBqdlz7lCB0nfAh/EK9P3LVb3?=
 =?us-ascii?Q?gmu6TbS3JNjnkNcnJMPyC0g4yOl33cBAbtVh9TW8w11h+gGL7udEGsrZ+Enl?=
 =?us-ascii?Q?WnXhkVRJY/xcZZSZmlN0497LaIote1M3iuRHil8KJZFyo3PSstffd+RH14Kg?=
 =?us-ascii?Q?vKAy7ckKUDB6fLTk1x2J7SUBnn1t1GTU68ebIT8CXxkLrIOGSB4BFKXbiCMB?=
 =?us-ascii?Q?s8z/dUejA9Jy+wlQakUmRyXUGfrOjw7cCCjduRMyn24odNokRY7KhMwBst+L?=
 =?us-ascii?Q?UvmCuq90od2OrsKUDnExUvZjNZX2qHNUBqGoFivDJDf9PJSt9UJXKhnGIPF1?=
 =?us-ascii?Q?1Mbhz+/qbR37dUBCJPd9ofUlTMLcmGOwn/0WU/Vo6vNIz/mU9d+sOOUva+sE?=
 =?us-ascii?Q?ONXTT1K6R+YGsI1vvfBbh0irEG8myvmHMK86Qomb2osEK5Pxk1185Odxexq1?=
 =?us-ascii?Q?38lN/3jhX1Thcfw8vrT7BxPTRm7H1rgin+LPThmnPJ+U2njZw5cYQRHILwHU?=
 =?us-ascii?Q?zHji1mOn8hGLh24qqTPTA3lMXoLnlpBQWcAhEftC4zntvUBp9p4ZFT9VkM2n?=
 =?us-ascii?Q?bqlYZ9bzD9yQKcl48my0fyxpULSzKIl7f6OYJIQeO/qn43vhe+hqxSYhi3Yp?=
 =?us-ascii?Q?gR3K6We7tREsymehk058sw4h7Ew5AclU4RgG+p7gPcWR3oshz4ZmyfSPivuF?=
 =?us-ascii?Q?b8CUZ5wJFZ0h3kqptN+rcaHoBubtAK+RvovldM7oRb2GDuJX65Q+JFKftj99?=
 =?us-ascii?Q?k+51r19CnOLePUXjR0TdK8xN9p6JyJJFQK4dKuC/SUd6FhVkHNRgyuiMOgLg?=
 =?us-ascii?Q?7zI5iUaGHmWqCtgpc4WXnyMrk0r2Qr7nib70fDek5Q+TjcVmwjZK1YAtrhUq?=
 =?us-ascii?Q?+3IfFKBoMZSVut/jGW1XUSwZ6o+ZlfFrKZmOnS2qDQWXOTNTTXAwtkGRJI4L?=
 =?us-ascii?Q?gMx4KbTov8F6MjDQFbUyXRFVhCKob83aW4PwjGIddOjFnQk26h74wILOme71?=
 =?us-ascii?Q?G/57sfdaVEQM7r0v2h+Yu88guiB2P8n9M+LJFAnmJost5RTTdlQdmObemkqa?=
 =?us-ascii?Q?KXw6PCK20U3AIDCuh/M2NDkfcceaHvDA5Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e18517a-f05b-4219-73f6-08dbb47f6ef3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 17:32:41.9601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIcx3iX11UitY+V5OaNnnwswNl/FgPmhmNkxxQ1qFVKHWXrOdLQis1SMtMoicvN+mUGNL649NBjD/Y8DcwLvog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5234
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_11,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130146
X-Proofpoint-ORIG-GUID: _m3bl31haAqWH7Z6gAar9yK8cepPm9f6
X-Proofpoint-GUID: _m3bl31haAqWH7Z6gAar9yK8cepPm9f6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [230913 12:13]:
> On Wed, Sep 13, 2023 at 10:51:25AM -0400, Liam R. Howlett wrote:
> > * Peter Zijlstra <peterz@infradead.org> [230913 09:53]:
> > > On Tue, Sep 12, 2023 at 08:56:47PM -0400, Liam R. Howlett wrote:
> > > 
> > > > diff --git a/init/main.c b/init/main.c
> > > > index ad920fac325c..f74772acf612 100644
> > > > --- a/init/main.c
> > > > +++ b/init/main.c
> > > > @@ -696,7 +696,7 @@ noinline void __ref __noreturn rest_init(void)
> > > >  	 */
> > > >  	rcu_read_lock();
> > > >  	tsk = find_task_by_pid_ns(pid, &init_pid_ns);
> > > > -	tsk->flags |= PF_NO_SETAFFINITY;
> > > > +	tsk->flags |= PF_NO_SETAFFINITY | PF_IDLE;
> > > >  	set_cpus_allowed_ptr(tsk, cpumask_of(smp_processor_id()));
> > > >  	rcu_read_unlock();
> > > >  
> > > 
> > > Hmm, isn't that pid-1 you're setting PF_IDLE on?
> > 
> > Yes, thanks.  I think that is what Geert is hitting with my patch.
> > 
> > debug __might_resched() in kernel/sched/core.c is failing to return in
> > that first (complex) if statement.  His report says pid 1 so this is
> > likely the issue.
> > 
> > > 
> > > The task becoming idle is 'current' at this point, see the
> > > cpu_startup_entry() call below.
> > > 
> > > Would not something like so be the right thing?
> > > 
> > > 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 2299a5cfbfb9..802551e0009b 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -9269,7 +9269,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
> > >  	 * PF_KTHREAD should already be set at this point; regardless, make it
> > >  	 * look like a proper per-CPU kthread.
> > >  	 */
> > > -	idle->flags |= PF_IDLE | PF_KTHREAD | PF_NO_SETAFFINITY;
> > > +	idle->flags |= PF_KTHREAD | PF_NO_SETAFFINITY;
> > 
> > I am concerned this will alter more than just the current task, which
> > would mean more modifications later.  There is a comment about it being
> > called 'more than once' and 'per cpu' so I am hesitant to change the
> > function itself.
> > 
> > Although I am unsure of the call path.. fork_idle() -> init_idle() I
> > guess?
> 
> There's only 2 ways to get into do_idle(), through cpu_startup_entry()
> and play_idle_precise(). The latter already frobs PF_IDLE since it is
> the forced idle path, this then leaves cpu_startup_entry() which is the
> regular idle path.
> 
> All idle threads will end up calling into it, the boot CPU through the
> rest_init() and the SMP cpus through arch SMP bringup.
> 
> IOW, this ensures all idle loops will have PF_IDLE set but not the
> pre-idle loop setup code these threads run.

Thanks for the information.  This does leave the init_idle() function in
the odd state of not setting PF_IDLE, but I guess that's okay?



