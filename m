Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F6A809B95
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573177AbjLHFM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbjLHFMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:12:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099F61729;
        Thu,  7 Dec 2023 21:12:17 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B82fWMN000448;
        Fri, 8 Dec 2023 05:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=6ARSjib6yqzossKjmNlVRIb13i1DqVdFKeCdUj/UnLQ=;
 b=hwf3UPQd90VNNkeL5lems1SxKjDQ0E0NPUTHHCujDBmwGYMZAW1PmxwBpXp3kHjhufJz
 D6vdKYtaVvws9VZf+KONzUQ7MgNUUm9+WER0l4J2o2ums0UAmrpnIxeiIn1BuJI+/9ub
 1z8qpDSodWN2bURcX0AZ/MvuMEcT8wA2mH58ZGjeE2D12nA0Ij4eQO50NopNvVZ+w85I
 wweanWAWi1gwdgbEDRHlNEWGw1RrVrfMrrxwvi5u8vEej7O00amv96OABbqTGEmoeQfR
 EsKxKvDkQdCR/8bVffz1+J0+lR/rAVZ671rEGHRqs99SBWKlzl049+GS+CUWgS6smxc/ eg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdabw6fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Dec 2023 05:11:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B84PJfd037455;
        Fri, 8 Dec 2023 05:11:45 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan8efgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Dec 2023 05:11:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkdzQ54hDmvoUT+1dSH5PrK22zX0NjdJfX8y+r5o8Qz7YJQ16KGfZg5o0CzjTCCXlMQrWSyk5E6cwRUyk+J71jbPFaFA/Nh1idLZlWcp0BvPgJpvfMt9Dhxty1BPWzr/IRgP6PLF+QJQ41TcK9L63rIzhHRCDIbLUGT7Dz96CzxyX+/vIBgPQHUD7P38/AGR49TH5zXKA3pMzmM+UvKOV5EOCpholP5zrBHAlCTM0ikWzWE59D5TYF3Cty8ebdwc5HMVROs/rt/kjOQMzOGUfeEiOkpdNbrtPdgGaDcBFKVhRtUjYj9wxw90zFy1N+NdrWXHHchC3On1v8d0CYBKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ARSjib6yqzossKjmNlVRIb13i1DqVdFKeCdUj/UnLQ=;
 b=JHoyPJaY9CTZ/BvnmA6vkNv77XwWYlnqsty/9vTYXpudWokLlKPtaQeezb4ZS7rcLvcxuhiBei3hpGSMcgBGPHZMb4V9wVzux2NuN3pOHSux8Qlcd+LWEVoKR0BHNWMW8ofwUUc8IQ6V4pk5ke+BqmP2apzHO7naUZ3p0Nz3m+a9zusMTmvxt93XlmH9dtAgKYWEkXJFwacIORsY+22NsJ/jnLPAuNAuhPSG1WX3qD5+ByYC9zM2eQS6JuXEFVBAU0jkQiM6myrAnOO08huXDunvWuPdOpw4YW/D690EdgF9g/oDXds9ybaRjdh2flQQFp4ScJB4tNJNuztDa1ol1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ARSjib6yqzossKjmNlVRIb13i1DqVdFKeCdUj/UnLQ=;
 b=WtQbxuq+8zdbhuKl3PzrLIHBLH06ca/oRoAlmYaX5nqZxuJIbUF37t2+nKn7eYEqSQ3OHk3OVBbHjFiVdD35/Lwz+88tcW29xoxHDv9/Di4fBR6bJQhPTl9qrK7XQ/IBkpcqeujvK4F9dNJqPs+oIQSjBXkWanZ0KsVZfkHToc4=
Received: from SN6PR10MB2975.namprd10.prod.outlook.com (2603:10b6:805:d2::10)
 by BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 05:11:43 +0000
Received: from SN6PR10MB2975.namprd10.prod.outlook.com
 ([fe80::de47:3c1f:a55b:58d0]) by SN6PR10MB2975.namprd10.prod.outlook.com
 ([fe80::de47:3c1f:a55b:58d0%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 05:11:43 +0000
From:   Kris Van Hees <kris.van.hees@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Kris Van Hees <kris.van.hees@oracle.com>,
        Nick Alcock <nick.alcock@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH 3/6] kbuild: generate a linker map for vmlinux.o
Date:   Fri,  8 Dec 2023 00:07:49 -0500
Message-ID: <20231208050752.2787575-4-kris.van.hees@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208050752.2787575-1-kris.van.hees@oracle.com>
References: <20231208050752.2787575-1-kris.van.hees@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::6) To SN6PR10MB2975.namprd10.prod.outlook.com
 (2603:10b6:805:d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2975:EE_|BLAPR10MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: 54287107-f3d9-42c9-2d11-08dbf7ac2b1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AK60n9p18VAvZ9Z0ct3CYwmAJWv6lPqO4BpQd6n16/F76+PHa93L9Cw3IlRVwYMLJR21HVo99HRLtAAo+5LXLHJadY/vz7f/+EjEkuSp+FKTcIcwegvVr3dRi7YvfEey+EQ+i7AvIbgNpFFv1RMDH96ASSUrZ23Lzz5pWSnktFidPmDaxKBqWyagCjIa4Hl2j6FkwkYg4Q1NRcNq2kyS5ygju4KQhccKOXNA8yyrwy//2uGrtrrUBahO7dcwlpkWJ7y/uoK2rtbxs11C2q2PrW/ymtMePs5gu81vyLyxa57gbvQ+yfNqSNui2EKwsVt8aAX37b38WRfDZcOrWCyqJDGfNtGJGkX59vm/Qt+f4WD2PhAUj3Va9QZQnX3yUvEmNXcsNv77Xk3QULo5itLKP0d/7uz+VrAMR32qGh69WZZIUz26PQjE7fRDDvWWRzHmAtIQbenAufTLtU3RrEbFpdczy4CP9B4FmyIkMuV+Q/YTzdUxG8z9jWyEoMV+6fZ8hGxS+5fR18jxpV/xvicLGUF5DU99UUc87143w/LMyLpPtMhgGc0eJKUg4grbOG9e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2975.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(346002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6486002)(478600001)(66556008)(66476007)(54906003)(66946007)(38100700002)(6512007)(26005)(316002)(6506007)(2616005)(1076003)(2906002)(8936002)(8676002)(86362001)(4326008)(5660300002)(103116003)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FpnhyhPWb/QmsPq+ZlSuxbMZVFnNhVt2K6bxO65XOIcZ4Ded/wSF1yS31Bfk?=
 =?us-ascii?Q?vNK3x3mZyHfWwX0kL7H4JEDVRh4a3WeEnv2SrorbGjU2zx37VudUrDgJ2vlZ?=
 =?us-ascii?Q?LO7zCjyVVvQbfgGOdYwx9lgNQ3USB3CgP9u5JnEjCauDgpP06ZM7RNWVWlzs?=
 =?us-ascii?Q?kc7yTrdiqqnzB/F+E7WGIjOYtATqtSHt27PLs5IoSua2Dn/+zRdy0cRMMkvj?=
 =?us-ascii?Q?5iIxsmyuh5I5ifLNSGjCgwEgGYbfRAB5BK1r34AD9Vj9EuR8hil6AZT7xOCP?=
 =?us-ascii?Q?cM9M9fa6Jbou2TfZuw8vO1jRAf6NVVhbBnZDEP3gzExXvS1++M76XSNZbfNF?=
 =?us-ascii?Q?FdT4WzwltA7+fU586UmLkbk0Fng1c3XTl9EwxHsC7AphbISTviG5hDaNyeQw?=
 =?us-ascii?Q?4PlUF/rZ61EkxvYDAUtZzVYmwiWjswSFNWuyh4q+R7aCBBTKVRcohtp6PgB8?=
 =?us-ascii?Q?n9WVgegkH5CNt5IkQV87wxWb+oLHgSERncY6ZN2xRrgJk+6ODVHAkrB6ombk?=
 =?us-ascii?Q?HIMfa1upbuHLKrlHYmmEcM9kyLIqEZpf+uzFweDvQmmjjYEFhxqOZZZxdQxw?=
 =?us-ascii?Q?HIn/SyiBH8o1HuRC5qEee6OmBAqOgXZGJo6DCUTpxpCQo/3kAlSVazTAn/LI?=
 =?us-ascii?Q?NSoblslfLFcmBc9Ms5H3bPHAT8+K3TE+zv2+O1pwECpg0VjVpgBlO0IZe5o4?=
 =?us-ascii?Q?x181uKveEKlJG36smBrhZnqpVGnzymkrrX2obeBcFfY1bvDRNzd6b14xBuCp?=
 =?us-ascii?Q?IbTelwKJz/1Irny56S5vRrpu7qw8XZfDnUaO7eq5bu9j6Q1q405FBrHNAeRb?=
 =?us-ascii?Q?IUfpVuo2RsV7y+2/3Zw/jtM3FYn9bE/Ux98cg7xfvoPu52h/ahRu7wbUo89V?=
 =?us-ascii?Q?kFnWRGIVYqs25GczhTS5I/anGoE9LRYoUhoyHKdz47UHyqHIdsvzlY6UR3gl?=
 =?us-ascii?Q?Cs8cHwVyKqNy2tCZglG6o92qfA/L+JdTlORiezumLDdJREgdk/vRiY1YIhEd?=
 =?us-ascii?Q?kMkOHpGvntJeASx52VlDUrkbeS0roelBPe39YTrFQ8CNzJV/Pd74C085AT5F?=
 =?us-ascii?Q?tEMTdMATYLfeGbPNTd1rYEFQ83MI59XbljlGqQD7DIHhtT6pIFhZ1QbRjXtQ?=
 =?us-ascii?Q?keRNJXolZWnA6/VcYmG+MUgR3vUi02RLiRd+WzDh9PSKyneOk8G4GCxVP1jA?=
 =?us-ascii?Q?lmjoKNagNCccMvjhSe8MqGWD02doKE0KGlSGrgkwWATiCBNwRVDZhbDp99FA?=
 =?us-ascii?Q?amNZrkiyyOmPqhNswWBOhXzSJFdC20pBWf0H3G5FGnpquGD9YhB1U5rluOsJ?=
 =?us-ascii?Q?QeYeKzyelY0yxqhTuMqmgbt8AnWk6tje+SqNqzc9/3yrab51I2JEcx5Nfw4j?=
 =?us-ascii?Q?iHvRX/UL68tBbVbRf09Gm5g0mlFtiW2c+slMzoI7nLSTlRnd+O5mbNP4CVU/?=
 =?us-ascii?Q?2LDcsrwUvPjEm2ru/6haSHHqfjsQdydUB2hu/aLCBt0O20qS4DXNi8e64ePX?=
 =?us-ascii?Q?TNmIj+cKjAr9x/bkJx4EaGWRYx6qYxVfKtLZgvqCN/0Ft/+0dfpwTkvyHjEP?=
 =?us-ascii?Q?kK0C+QkzeSDo/dmnUCdMYnqXaPfQxszO/0LObxcyGc3wjWQxVyWfwzHuhTzJ?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: D/uc7Rrlqiz2aDGZ+HgKF46/12alpueRm5SPERloh+hgyaVqZCzj8oYjiCV54J1WY77XqDb2pr3bVYVoaevlntfHO2PUFliWpfrzQ78zsgwPiSRYYB9CXiy/zRjW9oNeQrl38tAaLKr9973igVURCorwVT5/J8sdslGjoR8CHdk1JGnOcwb5YYWLFwadgLOuoYEywXLpAZmQgQgxkw+bhwj2ScbZqy39xFCs1dXqOcLAoESlD1wv4eXPsbdAO4beG2iv7JLqGuZGYclGR8l+zmahPj6NwH71Sim/T5YywwNJ1nWnPo7xA8prJlKsyf1Qfd/PHltWCLRnD4EO5zO8HIyBoe1mzG5iBONDacoU5VR4YxKJuvvlY0oQVRqUw+nxt6E1RfDz+OrTA9R9mWOhZHYUEo6/HgRVVVBKNMz35J2T7IJapGDFBdVqZZ/Sqn5G6j/2xZ50Fjc23DOAPAlM+NhuuBHK1/fdRVbGjVR2buDVLRf3+NT9WRzeNVRUriB2w+ktsI9vrkbVr3B3ao+2rm2b8560OsHHAbJuGVRydnvFdpqJZ+gvP8a5ZV1jRnPS00m9fYuPyRm7+lPXga+uQPhe/bI07jW28bmGXs5LEhWRexwWDDo9nJiZzOiCUndgOAr56KKQVtznsvqSYO/OoCmYitDj1MKHpNYfNfDAPNqtf7c5aC65rDekluF+qHd9mSZZ3JCtzeG1lMeE1lhm4VoJ05GjJPcqAp3zJ7ZN5cp+3Ingym6XFEznOBZVIXtQYMNNbBC2eeXXym7b6TTmXQNscrz36/akmD3sHUK8mCSb36khOH6lx0RyWeAmIwQlUysElqCEY1c1EdkrykHNZ2Dpw59Jm5QpFyNkiWyxe0isrt2jJ5VXJrQaeaRIFwv/
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54287107-f3d9-42c9-2d11-08dbf7ac2b1e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2975.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 05:11:43.3732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83Slb0J/yZC3mcxreUN0+FXbKGLPiRHYX3QMbF2MwykNv43TtX2+VnsLeXS3IQhBWBqd+TtyAiafUEuUx4UP4ZPXDP1z/7HjsNoX5mJYXio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312080038
X-Proofpoint-ORIG-GUID: ren_IUvTaxd3WHG9thAsW5G7zbcgekLp
X-Proofpoint-GUID: ren_IUvTaxd3WHG9thAsW5G7zbcgekLp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_BUILTIN_RANGES is set, a linker map for vmlinux.o needs to
be generated.  The generation of offset range data for builtin modules
depends on that linker map to know what offsets in an ELF section belong
to an object file for a particular builtin module.

Signed-off-by: Kris Van Hees <kris.van.hees@oracle.com>
Reviewed-by: Nick Alcock <nick.alcock@oracle.com>
---
 scripts/Makefile.vmlinux_o | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index bfb84efcef39..9e35cb0ed862 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -45,9 +45,12 @@ objtool-args = $(vmlinux-objtool-args-y) --link
 # Link of vmlinux.o used for section mismatch analysis
 # ---------------------------------------------------------------------------
 
+vmlinux-o-ld-args-$(CONFIG_BUILTIN_RANGES)		+= -Map=$@.map
+
 quiet_cmd_ld_vmlinux.o = LD      $@
       cmd_ld_vmlinux.o = \
 	$(LD) ${KBUILD_LDFLAGS} -r -o $@ \
+	$(vmlinux-o-ld-args-y) \
 	$(addprefix -T , $(initcalls-lds)) \
 	--whole-archive vmlinux.a --no-whole-archive \
 	--start-group $(KBUILD_VMLINUX_LIBS) --end-group \
-- 
2.42.0

