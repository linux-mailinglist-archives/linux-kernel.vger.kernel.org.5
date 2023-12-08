Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43675809BA1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjLHFUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjLHFUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:20:11 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFFD10F1;
        Thu,  7 Dec 2023 21:20:17 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8501UN014431;
        Fri, 8 Dec 2023 05:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=UD+nqGjl5Y7jj+YWbLy2EcIUg7eOdOBwh0D2z5TSUIA=;
 b=PGACs8egVMEsakbqVwJCw99cvk73A9jCqG/fshM7DIdlzL+UxNyM3Ey6LejUIFPRYUUl
 UBmBgtWR5GNkX2n0bsdCi2o//F/pkdZZz0FAav7KCuaVA5WRyCklRiP9X17Z1btzotHR
 hMPz6zpYOOqkb3yaCaFMXS1Xp+q30beNzyZTMjZnQVpSw2TW2WWVVjHrPBGB7ecD8rmo
 2G8tfk72CDvLFHC9/aZpHE5gxui23FL/oYlUNseAf6BOGw9MRne1noTfXDzc8NXH9g06
 mKDOKE432EtDRcUQHNccmvIaXQrPhJ7qtpW1leFoH4W492ydh1TqJtH4LwU3L/BGvWyz vQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd0hn8b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Dec 2023 05:20:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B84VWRD038005;
        Fri, 8 Dec 2023 05:20:09 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan8ened-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Dec 2023 05:20:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbMDOVSxGbkxoSmL7/o7ZyDZRWNIl70cR7ufYo7D+Wve0lEqy/OlxKeUfUPgqzr3W7Q2dmBFe/3YhfFzvtL6KWYpJkZ2fNDj40pIzPl6+f1t8ip7GoxsbAzi8rZxQsWHHu+afRsb8Bw/QC7B2N7t8qH7Uv4KjPc6VsxcbsaCVATw3cGCd4cRZpRGvsYaL2BFEdse1xECrrum7ydcFIL/F4m3NPfw8+f7t+cNCe1FtwhQA0JiM3EpgEbCD7hRVdfeaLJD+SXB6TiOdKBTAQCvmoNSFhx5JLkxBbs7hQ3aTvXzCkLt/Y7kh50ORVInwo2G4IvZHkdCChRcZ+tX4TNgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UD+nqGjl5Y7jj+YWbLy2EcIUg7eOdOBwh0D2z5TSUIA=;
 b=LXxQM5YdfkV3QH4QzZjZTZ9okwysSqmMvQyzPDC2nIQcdXdKMfjpfPzmh5G5ZUbTrcgwBanRTAVlBY6iq5GguFPAUbBkQGI/wJvu9xMC8TsdcGqheEZbaJMdRdV3JRobOCSaDdHzM/NG//82Upw7lTNoDmTzxTbYFksHspK1SAT5Z79MTkSdv7m/5pdr91FP8Qk0KVfMPthBG/8uHqjrYkLbuNweFOuzX97xXaEyAfXapB9fc4puLu55RpZsZeIgjgTEB/fcltyn63+0CtF8+DZN5Vy54rp3b7XwOv+YpKBNBge6QAedcW13sq3+PNMvkUPKNx49RLEK8KXEsA7+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UD+nqGjl5Y7jj+YWbLy2EcIUg7eOdOBwh0D2z5TSUIA=;
 b=Q3cbliMLGfGuW7WQO+pfIJTpeU6vkAm4My1HFSmRSwWs0GangCVQ77wPCqzG+Q8d1JUSbrBgGdHhECKQWdrB6VacEiLSyebGKGp4vTURUGnyWoA2bDttAZTu9ftsiRkIIqWOypqraXCFY8P3rtDCbaIvFHqEp7CcI3+qe4s2FnM=
Received: from SN6PR10MB2975.namprd10.prod.outlook.com (2603:10b6:805:d2::10)
 by SJ0PR10MB6325.namprd10.prod.outlook.com (2603:10b6:a03:44a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 05:20:06 +0000
Received: from SN6PR10MB2975.namprd10.prod.outlook.com
 ([fe80::de47:3c1f:a55b:58d0]) by SN6PR10MB2975.namprd10.prod.outlook.com
 ([fe80::de47:3c1f:a55b:58d0%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 05:20:06 +0000
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
Subject: [PATCH 4/6] module: script to generate offset ranges for builtin modules
Date:   Fri,  8 Dec 2023 00:07:50 -0500
Message-ID: <20231208050752.2787575-5-kris.van.hees@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208050752.2787575-1-kris.van.hees@oracle.com>
References: <20231208050752.2787575-1-kris.van.hees@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0155.namprd05.prod.outlook.com
 (2603:10b6:a03:339::10) To SN6PR10MB2975.namprd10.prod.outlook.com
 (2603:10b6:805:d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2975:EE_|SJ0PR10MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 75cd25fe-e894-4904-585f-08dbf7ad5703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b7Qi+rUQB2mdXLYm6C9KPqI/eCE7EiSESThySYoAq86xGiIwkiNDs8SuCdaR/Q903U/XFWkhlOwV/BeSorcNMwbhgsI0KxO1n2gqtwZOiF5StafxCcCxMe9F5pDWkxRzILKlF0lrYkLyS7nwwy+1tj6sSuMYh5MESbH7qaGWCpQDiYFS+R8plsKYW/O3DHHKCTpcPG2W+bwc+/v1JkRLGR50397P7nXiLW4ZYFELa6Fgs8ZEVbkJzlXoOxVOHjX2ZCWz0SN1UXMDpNXzpo6OiJ0H10YHjaXmfOB0U0u0LVlZqInmO/50P+QSVZLxdQ0HqGPXFW9Mx5nzNOt09TXekX98zBbcyK9lc5uZVVD+/ETS1hretOyq4kFhLOyWOtzXRURagE5RBUcPOiOP0EEbDIcXRIt/8lTOQ8MuxhCkAJwfQHTJX02Olc14tRgjtSR6ivi3yuJW14W8Vj3rZMyhq0ap8R04ZszyIcZUb303Hr/T9gVY1DNFg1S7ZX68cC/xrvkfvRoCxYkxoI1LbMBWi9usuMWfTHM3mOn0cl2Obq2jV1C2DZPoswplVj6ZRjdN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2975.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(4326008)(8676002)(8936002)(103116003)(2906002)(86362001)(5660300002)(36756003)(41300700001)(83380400001)(6512007)(6666004)(6506007)(1076003)(2616005)(26005)(38100700002)(54906003)(478600001)(66556008)(66476007)(66946007)(6486002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8AMHz3D6ENaWu+lAYOaytOa9PoHrEb+iujGIP9PZ2LWHuSie5BsT71c+VRHV?=
 =?us-ascii?Q?GoCToxgOwDwDqgt4oXlQnv9crJbZkc61c5GO+qNz/zW0ZQGZ7wQTXXxg02VJ?=
 =?us-ascii?Q?stg7zh2G64GRQUOZvVZ8YEEHSFGQN9hSk321pxNz0UACrwEvvzGI3jBfWAdK?=
 =?us-ascii?Q?Vue7yPtBDOp7lMBta8zR/tQqOzD9YLzl89wgqKFgwaoGWOPYDgs7Id6MIsz6?=
 =?us-ascii?Q?VgRy0MlBN5TMp3buTdCSSmvZycRRc8qDCjohBRgULp60rLt4fPGc7e5u2zGN?=
 =?us-ascii?Q?ZDhk/UMrwlL7IVfUBzhcgOA2RDQvRXA2Szjl2hJoj2oS1iqZ9nHWSgiG7e09?=
 =?us-ascii?Q?N43NoXvX0Npg9Mr5qLfNwwazuA1B7LS2YufYeBSAgvHkdUHx1ClPuue7reAC?=
 =?us-ascii?Q?h2bogh0sbiA82XRlej/199eK/a00UsrmdLJySpeMasdgBcmg4VihxypPKiJO?=
 =?us-ascii?Q?OzVxh9Bm6Rnx+FlkDnuYvX8r5U+VfSCZRs7M6tBoUUVmdYab680nyz6MdPvw?=
 =?us-ascii?Q?6nX0EiUp4OT5GZc1R/1HGbUNG1kBXb4To42V69nEz+PBmktDc1OnXctgpKtq?=
 =?us-ascii?Q?Jvhy2GT34DJ/895y1t8ojKe7WOD1Yfd/po7P6zGBNlbxjHCh4DzIyQqC7ijD?=
 =?us-ascii?Q?/5JLkSJx/yHRKDBmdhzQ6zvNE/3iE9wm8XMrEDe3Q9dAoyyWSyHfrOvNaBGx?=
 =?us-ascii?Q?a39OtNDI7mWYWoE4yu2yKVqajCXHEHSgkeUnKBrDUhzbrpiUMXLy8CZjFQwc?=
 =?us-ascii?Q?PiVne66dBIa02LQNfZ2/5BPV907kxhn1N7Ieqkj/leAkGUL7QnUVTYzh/WZz?=
 =?us-ascii?Q?PhYhzPdqoouNsejHVAuav5RAG7zKzTn5NFezgVZlJjsfj78LtkyIiaS3ZlhU?=
 =?us-ascii?Q?qLW4DTlocFaFrqLQFV7T29zJXvDXwNII3sHCZ0sMgZaYdzVlW9dVbHHpe2FM?=
 =?us-ascii?Q?53oEnEpI7pHY/jJgs6kMudiBvhepxQyD8j5iBDQGgtykU59uah5RyxTyijCb?=
 =?us-ascii?Q?A7iK1JISO9jp6L1/FW0M+ao9fH8/0255s5i91tv5ooNcKRhtNNAL0de4KMCD?=
 =?us-ascii?Q?oTWyrum2qegP0xofq7O/IFpXeP+Hg+XylaSgZVnZlATSRlUyhHxVPBROkkrb?=
 =?us-ascii?Q?hj3D6YluwnWJ3lJxFdoTpX6sBUyIlimjbeJNEe2hbd1NBGHOEpI8uOCrnHHb?=
 =?us-ascii?Q?2VMc8oKGwh6sVbShBTTFYRsEpJk2pueXnzxOiHx+MViMG0tHWQnlz+S0Os1v?=
 =?us-ascii?Q?zpFiWMS7MxlYqUqvswICyRXbSwQSmdg4mpnYMA0PTCqPMMElW2IzyZSk4TFc?=
 =?us-ascii?Q?ibP7tC9OOCCLuwnPcPxWyHK4TQdHJN/7LK9miX8ZG+WkUaNdI+Csv935SyWN?=
 =?us-ascii?Q?POX0l78Cm9YcOMMVDf87oHiRl2iX7oqQhIUZxtyDi2GJgjv1W/SCuWyLobxH?=
 =?us-ascii?Q?lnQH8RS7p0aSye/rGXFd5S14qziMZ5u3D6gEdlfTUODA4E6J0lWpUIWMZ/3O?=
 =?us-ascii?Q?eWBIZal4TOfMWr6XDZ9x2fV+gUhiwW6l9cPRHFuemCZBbIJjRpObHZ29NWUB?=
 =?us-ascii?Q?sGNEubu8c5I2OJoFhzfb9n3sNgprxPnsYSbB22KClW5Z6Nuymlrlj71BORSe?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uCplytDkdJyo8eXI69T1i6SYg60J+UjG6VS8pWQ8TL71hpUu1e9Nn7FFJcFy0gjkuKrKuWkG/OUjq/WuruN35HMM1TH385L+7PXU92l69gTOQpFP6Mo3ZcbYPIxZaE4P+bHAlTpaxLnUONX/nWNBFtl+4rgbA/2ZVVW7neZvyLz/pbZEuZ1C5F4NhIxVzaf5mgBJT4YHhn8Q68Af5XQ5M6UYFsv6/etNJilyE0nGI3Y/6WrWZjW1LvAEJq7gTveG3xJ8zf1Cv9OOGVcjvK/GX80bkxFYxB/WbgMxUwEioOlarVubKKrb4aQKiOCptBuOny57XYstgaaPwITaEORDQ+kLtRV4p4o4A0vkKUrY8VQuAt9CVzHbm9WJaRR3M6GppfnYqdyjRp68b3M1tzYWMul45bDK67wzNYrOqeGYbjlJ80RdVji2G15/EL6n4klHwX9gnGz8+C+6aHNVD0/2VmJ82gTY32csxKBN3pWoiH24tzIc/zT3f9lkjeZ/pVqgp9hSmnjHRGx025mlkBK0uhKaYLNPpY/1xsvXW5Kq59UEBpD5cPq0y9yAO9jZ4U3YpUE/Ha2toYZe8nr+dP0cJs6eh1c7MvHHkExaiRGalUoBdawxwTaBNxyaJ5WrTrnGmqPymVuVrNJjPOcjoVF2DdpNujinrKYztRL47ta6NH2GNk6Dim4S1LYBcwj5mYv0bNrQB0u41rtHHXztVJSlfpkJKxoEiKthZSjpoqkYvfJbu5faYxpPr7GaDO8gZl3X4h9y1ZOgYij6sgjd+sDdqcdeU+cV6HyHaXNwwKJWA4l79mxaGHUN5UKVSDfRI7dNa0kuglZyM3QsW9SIAm6UYtzoXqQBWy2ySJnHVV2ys3fyb4qqXGYtH0sQUy0dXoM5
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cd25fe-e894-4904-585f-08dbf7ad5703
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2975.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 05:20:06.5309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aZqpxSDVkw5bD4OXd/vMLLAPTphANVhDdykJ03qZAaUVZQdnNRYCp0wuP1JDNyLbpoaLnWSXLuL6sWpqInsYxxMG8t5h9TLZA6tl9e6DKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6325
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312080040
X-Proofpoint-GUID: mKXtzGJE-qmxgDqCJhg-Jk67ns0O7_pA
X-Proofpoint-ORIG-GUID: mKXtzGJE-qmxgDqCJhg-Jk67ns0O7_pA
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,MONEY_NOHTML,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The offset range data for builtin modules is generated using:
 - modules.builtin.objs: associates object files with module names
 - vmlinux.o: provides load order of sections and offset of first member per
    section
 - vmlinux.o.map: provides offset of object file content per section

The generated data will look like:

.text 00000000-00000000 = _text
.text 0000baf0-0000cb10 amd_uncore
.text 0009bd10-0009c8e0 iosf_mbi
...
.text 008e6660-008e9630 snd_soc_wcd_mbhc
.text 008e9630-008ea610 snd_soc_wcd9335 snd_soc_wcd934x snd_soc_wcd938x
.text 008ea610-008ea780 snd_soc_wcd9335
...
.data 00000000-00000000 = _sdata
.data 0000f020-0000f680 amd_uncore

For each ELF section, it lists the offset of the first symbol.  This can
be used to determine the base address of the section at runtime.

Next, it lists (in strict ascending order) offset ranges in that section
that cover the symbols of one or more builtin modules.  Multiple ranges
can apply to a single module, and ranges can be shared between modules.

Signed-off-by: Kris Van Hees <kris.van.hees@oracle.com>
Reviewed-by: Nick Alcock <nick.alcock@oracle.com>
---
 scripts/generate_builtin_ranges.awk | 149 ++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100755 scripts/generate_builtin_ranges.awk

diff --git a/scripts/generate_builtin_ranges.awk b/scripts/generate_builtin_ranges.awk
new file mode 100755
index 000000000000..d5d668c97bd7
--- /dev/null
+++ b/scripts/generate_builtin_ranges.awk
@@ -0,0 +1,149 @@
+#!/usr/bin/gawk -f
+
+FNR == 1 {
+	FC++;
+}
+
+# (1) Build a mapping to associate object files with built-in module names.
+#
+# The first file argument is used as input (modules.builtin.objs).
+#
+FC == 1 {
+	sub(/:/, "");
+	mod = $1;
+	sub(/([^/]*\/)+/, "", mod);
+	sub(/\.o$/, "", mod);
+	gsub(/-/, "_", mod);
+
+	if (NF > 1) {
+		for (i = 2; i <= NF; i++) {
+			if ($i in mods)
+				mods[$i] = mods[$i] " " mod;
+			else
+				mods[$i] = mod;
+		}
+	} else
+		mods[$1] = mod;
+
+	next;
+}
+
+# (2) Determine the load address for each section.
+#
+# The second file argument is used as input (vmlinux.map).
+# Since some AWK implementations cannot handle large integers, we strip of the
+# first 4 hex digits from the address.  This is safe because the kernel space
+# is not large enough for addresses to extend into those digits.
+#
+FC == 2 && /^\./ && NF > 2 {
+	if (type)
+		delete sect_addend[type];
+
+	if ($1 ~ /percpu/)
+		next;
+
+	raw_addr = $2;
+	addr_prefix = "^" substr($2, 1, 6);
+	sub(addr_prefix, "0x", $2);
+	base = strtonum($2);
+	type = $1;
+	anchor = 0;
+	sect_base[type] = base;
+
+	next;
+}
+
+!type {
+	next;
+}
+
+# (3) We need to determine the base address of the section so that ranges can
+# be expressed based on offsets from the base address.  This accomodates the
+# kernel sections getting loaded at different addresses than what is recorded
+# in vmlinux.map.
+#
+# At runtime, we will need to determine the base address of each section we are
+# interested in.  We do that by recording the offset of the first symbol in the
+# section.  Once we know the address of this symbol in the running kernel, we
+# can calculate the base address of the section.
+#
+# If possible, we use an explicit anchor symbol (sym = .) listed at the base
+# address (offset 0).
+#
+# If there is no such symbol, we record the first symbol in the section along
+# with its offset.
+#
+# We also determine the offset of the first member in the section in case the
+# final linking inserts some content between the start of the section and the
+# first member.  I.e. in that case, vmlinux.map will list the first member at
+# a non-zero offset whereas vmlinux.o.map will list it at offset 0.  We record
+# the addend so we can apply it when processing vmlinux.o.map (next).
+#
+FC == 2 && !anchor && raw_addr == $1 && $3 == "=" && $4 == "." {
+	anchor = sprintf("%s %08x-%08x = %s", type, 0, 0, $2);
+	sect_anchor[type] = anchor;
+
+	next;
+}
+
+FC == 2 && !anchor && $1 ~ /^0x/ && $2 !~ /^0x/ && NF <= 4 {
+	sub(addr_prefix, "0x", $1);
+	addr = strtonum($1) - base;
+	anchor = sprintf("%s %08x-%08x = %s", type, addr, addr, $2);
+	sect_anchor[type] = anchor;
+
+	next;
+}
+
+FC == 2 && base && /^ \./ && $1 == type && NF == 4 {
+	sub(addr_prefix, "0x", $2);
+	addr = strtonum($2);
+	sect_addend[type] = addr - base;
+
+	if (anchor) {
+		base = 0;
+		type = 0;
+	}
+
+	next;
+}
+
+# (4) Collect offset ranges (relative to the section base address) for built-in
+# modules.
+#
+FC == 3 && /^ \./ && NF == 4 && $3 != "0x0" {
+	type = $1;
+	if (!(type in sect_addend))
+		next;
+
+	sub(addr_prefix, "0x", $2);
+	addr = strtonum($2) + sect_addend[type];
+
+	if ($4 in mods)
+		mod = mods[$4];
+	else
+		mod = "";
+
+	if (mod == mod_name)
+		next;
+
+	if (mod_name) {
+		idx = mod_start + sect_base[type] + sect_addend[type];
+		entries[idx] = sprintf("%s %08x-%08x %s", type, mod_start, addr, mod_name);
+		count[type]++;
+	}
+
+	mod_name = mod;
+	mod_start = addr;
+}
+
+END {
+	for (type in count) {
+		if (type in sect_anchor)
+			entries[sect_base[type]] = sect_anchor[type];
+	}
+
+	n = asorti(entries, indices);
+	for (i = 1; i <= n; i++)
+		print entries[indices[i]];
+}
-- 
2.42.0

