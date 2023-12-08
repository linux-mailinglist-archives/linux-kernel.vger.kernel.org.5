Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662CA809B8C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbjLHFKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbjLHFJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:09:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03B635B8;
        Thu,  7 Dec 2023 21:08:54 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B84VaY8028528;
        Fri, 8 Dec 2023 05:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=geVyhC03/DpDLGBbY9q2vya75Wtjximv6mPhK9yDd+k=;
 b=eN+2LlVVTBfeyDrO1jaCB5A8Fnozxg0xglILgBeMR6eZBQedL9I2Hrud1imLu3J3+yGU
 yZjBW919iW2JAZEShxHjcAZ/Z5stKFehhKZzKPRsPL8RUhx6Rn65E5fkliHyYH2va9TU
 iLgTHuKiDAuTecNboYdIXv4uJttSLL5SQGkiVaU/mBK6PyG/2fCXsECcbbpIdnjDGV/5
 R3eUcTAS0ogAR8d20XYkEkaU0xSsTqBEYxSwaJEtpJF9yNyWCfOvlAmzmeZaH0BV0PGI
 iNh1Mz52crTevTLp2OhLTXAI8ZGM5ejphBdzx9HdpNSVz4Jq0Hec3ojKVwx09moTs9k5 QA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd0hn80b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Dec 2023 05:08:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B84VOak040264;
        Fri, 8 Dec 2023 05:08:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3utanef1b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Dec 2023 05:08:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7PzxNJYp0K3Ot8+1QkLYR7P6C4Dnb7IkiMzq3xu5xQ9awRtgU7KuKRkBwDw179qeTQOFwEGc3eJB12TIi3bsGTU+/Vinu9O5c78P9AMj3Cds77Jy7hR43D/fQHzEezIKrgU5VXPvcz0kY0TcpuVuzn5Idtwh5v2NlNpqEdV9EJ8Zhd7W+fc12SAD0y8Evg7QyHzx2T2qevCypHo4icfdiir47KkjU2jJ6p8U/dEkMqDlJ++SUGJSaEM8YIMF5HeT4vQYkYOLp29IBSlxxky24tK5xX1Sf3PhJxsnCb4NHEGBxJLm7tyKrhVKyaW1vw05jE+hGaPbsGlTA60RpN1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geVyhC03/DpDLGBbY9q2vya75Wtjximv6mPhK9yDd+k=;
 b=LlD03HKd8W+FZdGQMSXExNXqSgZ45vs9vMhzdT8r8IawE3DgRkwXw6VlxWtiUZoeIWR7nb3pNQ8KHacDoOOBEEuKd4Hdx+ipV5t6JGVZn+I5bb5Z17ZQiLA8qbxH3n3hrwlArrn0rkGNN/f++1oVX9tYu1xi9C43B7EXmliOATrawUi2h3YskRIt6IfhsCvW0E1n50zAN+1f2cBPiG6R3veYDPjtt91Nfs93i2mkAjWGRpLiQVGVmyDRWXe4I2IpQ3nhJHb53neIgdCUjnzZTfXE/vJ8bptOxD551aH+BTH461eB4R5eOWrVYmg9mumDJwcpFF8Uiin5VmzFEEjX6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geVyhC03/DpDLGBbY9q2vya75Wtjximv6mPhK9yDd+k=;
 b=LWcTybzI21DCTROJ3v/vINJWje2/pGaBxMcRQlK7tZ+Ke4NrBbKsmVccI/gZmWQFc4g3Te1/UeFshbnSnk5JS8EJnXGo9d/nYRPGr/KDFp4cltkLRhOTd/nsBpr6u0VbqU0el8Y3CPmIFgYvbSdGtDDQijyzmbvpcdgxmq3I3FA=
Received: from SN6PR10MB2975.namprd10.prod.outlook.com (2603:10b6:805:d2::10)
 by BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 05:08:44 +0000
Received: from SN6PR10MB2975.namprd10.prod.outlook.com
 ([fe80::de47:3c1f:a55b:58d0]) by SN6PR10MB2975.namprd10.prod.outlook.com
 ([fe80::de47:3c1f:a55b:58d0%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 05:08:42 +0000
From:   Kris Van Hees <kris.van.hees@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Kris Van Hees <kris.van.hees@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH 0/6] Generate address range data for built-in modules
Date:   Fri,  8 Dec 2023 00:07:46 -0500
Message-ID: <20231208050752.2787575-1-kris.van.hees@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0022.prod.exchangelabs.com (2603:10b6:208:10c::35)
 To SN6PR10MB2975.namprd10.prod.outlook.com (2603:10b6:805:d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2975:EE_|BLAPR10MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b2650c-6b3e-4383-8820-08dbf7abbf7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oe/Q3gis/E5bzpQlrlLi+rTbfqtpFXHq/1yNbtaavqrw20Zst6ZpQqY+dBGYg0u0+hSON010B+2SFdLXzQqRAhULCiS3xmnXI3/h+TURrxtZC/Uf1Y7Mt35UtLjilAULkEjk1JmKaOFzaYDkq846gn9/lDErYZGeIgyX7KCDHKL1cj02c0mAqZRjdjeIxq1uYnH2rsZ/NldA/HnRMtogHrpmwXDQvHSatu14TqAqbI03bcHNoKZ+jsNzOyrgsmjdF9tXkX9Nbb5eoFLINbdovplrJDRqybjOKVs1HFYwYyvWRne8sLfTMuMy1EJUaH5lYHhM6/rsU72f0AmVU+8TN1CKNHrRmvXclmCFPeoqueoQTH/UKCV6zZRmerXBKYy4mhFppAjBNvjt6u6XRoAaKBmzXOp3vuJgYtOPNOd8q/eFJ1jVHdxBmojRDh1R3V9PTCCk7dCpA4jTwWn7WXDccKSM78mB1+8EdU4N0bSobRKz/3cZsZoYlpAClD0mk1ryERkHGpWXJbAsm8e4MO2J8Ky0kyWj76XgCLYU7r1Pap82VzITWaHxPpyDHcwZ7Zca
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2975.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(346002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6486002)(478600001)(66556008)(66476007)(54906003)(66946007)(38100700002)(6512007)(83380400001)(26005)(316002)(6506007)(2616005)(1076003)(2906002)(8936002)(8676002)(86362001)(4326008)(5660300002)(103116003)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mr5aB4Mo797Sk7EeK9bhkCAf985wyq7x813AXN9+wjFWa9o5dNn2Wkb6IMGQ?=
 =?us-ascii?Q?W3TbBbl8Zj+WPEzleYqbvzGCs0jB8tgfx4IqgfUykl5Miz34pzTeAPo6guZ0?=
 =?us-ascii?Q?R+eNsBKF/12bnBjrxQltiSznn2w31rrlL6HYyiSOhlPoNkzsmnZTMs7bIoKe?=
 =?us-ascii?Q?F0knh86subPiQk5D81cI+UqyusVrv+p/9J/3P2YLazf7BihDenO/lqwHGyfP?=
 =?us-ascii?Q?4py+XXd6Krxp04T8UxRj7WCkrnIzTaEyt7Jwz+8EP1ykGIj1N2gl1o6+USTs?=
 =?us-ascii?Q?H5Sy85fu9+c2vvD//hKkvgZE/YnigLrEIe0iztHfvFuDqDMaFpLEILAMl3LA?=
 =?us-ascii?Q?DPfeHq/xEMPQky4CSGN3EZdnmgBEVzvus6ugS95dj579PbQDEB6kgX3DsTGp?=
 =?us-ascii?Q?TvU2ve9314wwnKEp+1VHV3Gxa7OhCyjE/eacOrQzknSS6y+nzsV9uKcPZZCb?=
 =?us-ascii?Q?DHB3lK8CPh/IiUKqhF6Y2v/vdP+WD037BKbbhW374JVE/8IqNtEBlLKL4A/R?=
 =?us-ascii?Q?Pwo+/b2VkUQwSLIywo0HCgM5tBoL9c5PLhrfjXHg0AVDHhKZH7gJY1YTNwqD?=
 =?us-ascii?Q?K+3oONKBBBJPNhUe5REh3N8mu53Bk8RlFQtx/JvVdc0HX44JK6RMmw2AtRA3?=
 =?us-ascii?Q?WpBhtCoQgSHo/ILVIfxUUqHe6bDLO1KLIDn47WDX0xP/1WpHEJEyLvjRFhQs?=
 =?us-ascii?Q?rFgChlHqG8ot6G+uqQiSSnuav4acpgkJaWka872J9cX6CyGjGaXf9Mm3LaVC?=
 =?us-ascii?Q?Oyq1RgkNWgY+D2UPcnscE+qnbNnphH6iEIskv0/gO0LQf7+TtrTIVBKiSH2z?=
 =?us-ascii?Q?7TWmQdhbono1T2DzoS0BDtARG5RQw3RyxoNWqiSOnFg1id2hX+brYGnYNLIP?=
 =?us-ascii?Q?IRozH3/j7REIt4rFm6Q5vjlQcb06QmFfMh96lXGhkizJv19w0YsdIIMV06eS?=
 =?us-ascii?Q?+xikiEEebb4eQaAT0DALKkMiF4b5aRa5jwc88L4XOp0lzI3iO6WzhkhA+xgO?=
 =?us-ascii?Q?oqkbwrT4pK9aBoopXzC4B0XcTMvwUjNN7ZTDiquNZapYlZyVHWYsWVjtGW0+?=
 =?us-ascii?Q?Qwptntr2GBdQLx7JXqe222v0mvYtVFLeqUeFOqFSZ+t08k9HGBOGUtATWhfa?=
 =?us-ascii?Q?5g5DMJpEAuZ2jaaCqNQXwdXXZokmdLwLp3m/rIFzZsV7f0ufpXw4mg097bAU?=
 =?us-ascii?Q?ewfOIxd2gf1xG4vhslO68MhMgQYUUIpIQh8n6Idwggro4H+KjQdbmrzU0kPN?=
 =?us-ascii?Q?1GLk8uyve2QlzXp3tJgbEmFGm5oeOtwS5MssRgrkxsh4iaIPeFh7MnwE0UCu?=
 =?us-ascii?Q?sxSsBN4SGT9FMwlfzwjD9G5YBSxWgPKfBq2PL+I+5Di1WWQUiDHKHMmQx/a0?=
 =?us-ascii?Q?OkYWZYuhT9slgbeRXnopu2rXHlDOHhnnCNdAfFRWWOmQ2NypQgsyi8tLjLgY?=
 =?us-ascii?Q?DM3Fop896VbcH6RtKQmCnZZRlY/JyrxAHSsKnCYfVkwqy1DhAn6TClT7LOtm?=
 =?us-ascii?Q?wQcmm9cFyJnntlJVvOk2Bbo+zXB90p5MkdnHOizYRe0PTBhLpqwjC9F/vvhx?=
 =?us-ascii?Q?5Ucnxt0W1VJmzTRK9R2CbO4ah3sVtWnfSWjT7/CzeHOqW6nr7gPD6KZ13sSs?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: THamYKQmgI4StmkA4qI7jyKuTwcIVSngRNVDX2SQED12YORtSZhVOJLD85DYSVnfV66tReLJXcVSYeHqe8Qvz1UCajzejtif1BOtI8mp0O61/DYasn7thcN7UTt4Ll3zWOH4r6aP0KK+8FxwtZOn4piqBQ5sHlQMmUw0goOnUeHNLN3DwBw0UqXlEPfm8CgL1svPDQgCwZw+6WOMLB38eIDIjX3bvJU43OHZi+81atXx+UzVfLjwUGTVRlECcrAvf22SWWqXCfnUCtdc207izqnWgq47TTTdVNedeAjzgWOWEzigbk1XQis5VrvWW1gL1ZG0pGddVeJdJ/03SB+v3ULmee3zh6syFEsQCSwEVSYXrEmdDP+PdiDNJDND8EWdAzk67ObOG1BB01TnDrEJ4QS8Y+YWyrY+UdtihltuNjx0nA4ieDKjjzkaG/nUnX0V+KJX7066GxzjTWkayIK5dg5/g9c5Dt/OpTAhX0/C4PwM+xGxpYL+gENccFiNv0+5l7jejCbBJe7QL0d51Wp5PrI3YyShpJDinC3Qim2XGI7lNUHmEh/HmjVX+2bR1P6u+3pll9jb6F+4MxCGzf4D+y9sOFIjqiZFT5ihTAt8oW0WYqQ7WFLk7vPzI3/PW30hph6kch52AAgmFRnRRrcBPw2OtsUH3YOlKMeN+shoCSEFuvCc2C+9yeCe1SYAD5JXS5aCAYIogPP9/5wMml6lBNiLOpUO/frbmncZud3R8rGKZFSIHTIQ/KJncesbt7UzZtzlqd2HTMPxHoL2Lp2g91YNpi7SF95DtLb13XHprDx4Dc1efMb9LalDARlT8gqgoyBnIMWEOPKZPL//Ci4zvGwmrOamxlkxx7SOP56Hq3uI+rUgYdME5JQG5KLVzCzk
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b2650c-6b3e-4383-8820-08dbf7abbf7e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2975.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 05:08:42.9272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LcUXwPOPqMbzt3qRB/qwkivQeef1bw4dQQo3lp3dvlj1EIeMdx5LKXph0MoW+G2Ej0ej4U5tpMInx2m0C0AdvnDKnzjNqbc1jdNwWFphr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=922 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312080038
X-Proofpoint-GUID: ABPTVkFxa8-E2wDpfKxwS0WD9mitLVNZ
X-Proofpoint-ORIG-GUID: ABPTVkFxa8-E2wDpfKxwS0WD9mitLVNZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Especially for tracing applications, it is convenient to be able to
refer to a symbol using a <module name, symbol name> pair and to be able
to translate an address into a <nodule mname, symbol name> pair.  But
that does not work if the module is built into the kernel because the
object files that comprise the built-in module implementation are simply
linked into the kernel image along with all other kernel object files.

This is especially visible when providing tracing scripts for support
purposes, where the developer of the script targets a particular kernel
version, but does not have control over whether the target system has
a particular module as loadable module or built-in module.  When tracing
symbols within a module, referring them by <module name, symbol name>
pairs is both convenient and aids symbol lookup.  But that naming will
not work if the module name information is lost if the module is built
into the kernel on the target system.

Earlier work addressing this loss of information for built-in modules
involved adding module name information to the kallsyms data, but that
required more invasive code in the kernel proper.  This work never did
get merged into the kernel tree.

All that is really needed is knowing whether a given address belongs to
a particular module (or multiple modules if they share an object file).
Or in other words, whether that address falls within an address range
that is associated with one or more modules.

This patch series is baaed on Luis Chamberlain's patch to generate
modules.builtin.objs, associating built-in modules with their object
files.  Using this data, vmlinux.o.map and vmlinux.map can be parsed in
a single pass to generate a modules.buitin.ranges file with offset range
information (relative to the base address of the associated section) for
built-in modules.  The file gets installed along with the other
modules.builtin.* files.

The impact on the kernel build is minimal because everything is done
using a single-pass AWK script.  The generated data size is minimal as
well, (depending on the exact kernel configuration) in the range of
500-600 lines, with a file size of 20-30KB.

Kris Van Hees (5):
  module: add CONFIG_BUILTIN_RANGES option
  kbuild: generate a linker map for vmlinux.o
  module: script to generate offset ranges for builtin modules
  kbuild: generate modules.builtin.ranges when linking the kernel
  module: add install target for modules.builtin.ranges

Luis Chamberlain (1):
  kbuild: add modules.builtin.objs

 .gitignore                          |   2 +-
 Documentation/dontdiff              |   2 +-
 Documentation/kbuild/kbuild.rst     |   5 +
 Makefile                            |   8 +-
 include/linux/module.h              |   4 +-
 kernel/module/Kconfig               |  14 +++
 scripts/Makefile.lib                |   5 +-
 scripts/Makefile.modinst            |  11 +-
 scripts/Makefile.vmlinux            |  17 ++++
 scripts/Makefile.vmlinux_o          |  18 +++-
 scripts/generate_builtin_ranges.awk | 149 ++++++++++++++++++++++++++++
 11 files changed, 225 insertions(+), 10 deletions(-)
 create mode 100755 scripts/generate_builtin_ranges.awk


base-commit: 8f34f6b7b6b3260eb6312a19ececcc97908d15b7
-- 
2.42.0

