Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB3B77F866
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351734AbjHQOKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351731AbjHQOJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:09:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B51EE55;
        Thu, 17 Aug 2023 07:09:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HCOGxG016435;
        Thu, 17 Aug 2023 14:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=4Ru0IXL2QWjy5DsKJVzxY5f+oYHIrn5Mcefx2GZGPSI=;
 b=OVEInU8+7N3m8Gn9vOlhURiOvpp9BJlJuZ53Myli/OmJJurwCnYIutH6n6UX3jA9HQlJ
 MgJwDSOjCt8liheWBHnK6kwMRpSY4YVXflRkUEDI9jwd6PwgLaCJlGxuPprdd7gh61M+
 StPicmDh+7Nm/MVi1ReAeQnYDMuiC4wbofWxmaiZ7SKyRRti3DtZW0LUgKa4txM3WwU7
 0YbgJ7YrJa2VK4fOEQ0ya7trDcnpJz6GGBxP+WjVZ9Txlm5v4EPPq/Fkp8jitj9v7vo4
 4x6WNPi0C269k87d9ziQdSOJVDtxccfvRpc/W02g9usOGSwzCQkj9e/pxk5HtZutTYEz tA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w61md0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 14:09:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37HDXwRc027382;
        Thu, 17 Aug 2023 14:09:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1uvfne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 14:09:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/5CMyXzcD5epGvkwgS81T/KolWqh38HyQ57EWg3CAlBUFtHBQFFA68WvISOvcqm1TX0+rrd2ulT8odOcDYgbkCCAsl+Em3HGwZ5Np1ywNO9zmlKM4SAXBC9Q7v63zHEiwhMQ5gH70lXFWp8KtW3a8lTIwhkSE80IpuAWEioJdwDe78ImTIlDYa7w8Q+HpozeKPB+HkkYFbDcbC0dsOAovtsdbEh9j9Tu48qkqNzdRuqsYceJnj/jMIwkk/4tLTaNc09PlGJm3tJsI2sRijTw7XdE0EdqCUhhujQCSx35ZjcM/Om7CBg2yaaw5VwSkXzTxk1qR0CX0yXOQq5LD9npg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ru0IXL2QWjy5DsKJVzxY5f+oYHIrn5Mcefx2GZGPSI=;
 b=B42RZC9nJNOVLAve2rycLXcEi8/T2nyI2Ce2XsNPHhU8Ly7exG4WSNfjDac7b/TDW7Wam27Z4l9huLsaSDgiMNE3UneYH1lg7D86fTaFiGNaPN5aLmooxzfHu/B4OovPr67a0d+uCG2duQ9V1wCESVo5hKha4bfnlZhZNFAdxUuQb1nhztKgXilUIU0gH3UMOAVQxTY5/eGXeQGHNCnLSVhUDqSLflQPpOCQCfEzw4RDMl1976TeqYQbrnzlvV56E00WqjslhB98D0I9qYaBGfY16VbnHfaVJmzs6dxdrL6UFgIAAhjv7aql6UU1wuQxVr8lSc9b+acawZYJ6Izebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ru0IXL2QWjy5DsKJVzxY5f+oYHIrn5Mcefx2GZGPSI=;
 b=zW7NFjMXWW8EUC0EAiZNgTUYKojFx+NQRK++25fx2ajbbylSu0YuNvgY3HH2fUYIP4Tb6pVKOn2YKK7k2jc4TCO/U8hQvikQnxzHEM1fxUsMW9Bm33rUHJ772T1pDC7Zeczx7Co5tritBuMsbzlIoR6JdvTCzJlsQhhNgIbRC2g=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MN2PR10MB4368.namprd10.prod.outlook.com (2603:10b6:208:1d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 14:09:33 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::3f7b:855:6a95:8aed]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::3f7b:855:6a95:8aed%4]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 14:09:33 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     dhowells@redhat.com, jarkko@kernel.org, dwmw2@infradead.org
Cc:     zohar@linux.ibm.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com
Subject: [PATCH v2] certs: Reference revocation list for all keyrings
Date:   Thu, 17 Aug 2023 10:04:07 -0400
Message-Id: <20230817140407.1599240-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::6) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|MN2PR10MB4368:EE_
X-MS-Office365-Filtering-Correlation-Id: f740fcdc-0ccd-4a5e-98e4-08db9f2b9490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tLoVO0bftf0lVDH9ph6FZPPHgZh0dPzBLdNJHBWKJfvNVrnxFR3QgWxAXNFZyfBneKr2K5EwpY8XITjjxEtP6GxFdlR7s9pmGoxADBLzoBgftL0HyzvGP0FpqszzMYDdfpYPGt90qz/6frkKY6UDwPM0aDL4M2h8dLLjHkqlvlUS+1vIJQnXLgkPurmYokH1n437nLotnA02kWnlcSVfLIve8rWB3AIJtZK43DKhj/ckX35iQHFQM6id5qxpYLPTYj37Il7woQad3pdzpE6dCLzj0qLpmvAkv0fb1LoGkIySxD+8U89NVTTXlkhCUON3st2I3FJHwHH2BBXFBIaYR1oDsJehPER57RGxVedqcbtjH+SzuERMHd0OwFRDekHlLHxnYuEo746ykZ/8zeO1VbUWzFyrR6v+baeeGSRhuYIbUQQuIerHZ2kPKw70ax3ly5ykw/wNOevS0GjZjtsZxRZUX7/67T5eDTzNy+/n1kgju3BFvIn4lN4hOzC0VM2l9OuaKseVH6LACOi8lLv5IEnIxm+6yatljOeGlOp/uSE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199024)(186009)(1800799009)(86362001)(36756003)(38100700002)(478600001)(5660300002)(107886003)(2616005)(44832011)(66476007)(6486002)(6506007)(66556008)(66946007)(316002)(966005)(6666004)(1076003)(4326008)(6512007)(8676002)(41300700001)(8936002)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+3DROQde+LiSJ2xFvwlUsmG/wx2IskgHGKjwYWZlbPeELaQwduhJwyeHW46d?=
 =?us-ascii?Q?Vaey2rdL5VDR0+VAwvp88RxkySLu6A8Q7rKZRLeqqQ43uowXUbUhhGPdverQ?=
 =?us-ascii?Q?uNbzfpEJ6dmnn3TWqHHaSS46MogC1euTFjyc6giFdtIS5XDCOeI3lLQKYxpH?=
 =?us-ascii?Q?DW6OyXvHHJZD0djmsU6fxSvqwYUar4md1dMK6HZiHUM7HDnNhFDILQpqQuiC?=
 =?us-ascii?Q?PbIL0Ym08qwjZRgQ8XQpXRgcuJXsCGiFLlN7A1GlYERZO+nevLjXjmQkgXy2?=
 =?us-ascii?Q?4HMFyIs02z8pA8+b7DG1DddWerTxXd7WPsUVMQvqd1iMiST6EF+XjkRhu5ao?=
 =?us-ascii?Q?d31FzH8spU5jBa1TJDBnTxzT0UBpx01jCbrQSxSKH0OdpPLDubamy5tb16u/?=
 =?us-ascii?Q?dUspGNewLeNvbpX/sw8J1kNiIrJA+7z/FaQMD7OrbRJNxmN7AgXgLoFcLqAo?=
 =?us-ascii?Q?LS0vwoRja1ioChLJ4uXKiK7ancosZFyQPE77ENFEPbu8AyGF9Dn5okqoMmNZ?=
 =?us-ascii?Q?Wildt4RsPaNnxKQBnD1p7YI5PjgwRb2UiXgs7FHvuc9AZ48C+J2ermgEUDVp?=
 =?us-ascii?Q?/eE3m089zCbqliw/0dkEJqJRhHNdWV+xtmOemPraQ5Kn24O2+44r6OiqBV8n?=
 =?us-ascii?Q?JoEntb4TzGSJ/b7lLoL+SdUxAx6H+b8MIITaWBH+PaJqmssk5WUo592b/K+G?=
 =?us-ascii?Q?40v8nGVxJYjrgSavL9v1XZy5rMJqnnyuf9xT88dtqzedrVrlQleGRbg4Ie8O?=
 =?us-ascii?Q?8HoMg7zKhYLEuxgd8g8jzSEgoHX1TEUJZwHdgsPS1oIYY3xlQJwV9AVuU1iE?=
 =?us-ascii?Q?PhRwLvGmNIlns1l7oC2mtIzn5alGgb8ckLLwoRWR3zqEiIendXMicE7DjlVq?=
 =?us-ascii?Q?P2GGdxI8109PP7Co0Mh7q8gsLrfo8awChKl9L8XvkPX+PL3JR11ROezjzUWM?=
 =?us-ascii?Q?3hquXPJyv2fu8r8D2lG5FVTDyhbAcar51VqAFSlwkwa/PW5sBxCaw91YFK/+?=
 =?us-ascii?Q?0Kd0w1Y7JnxTS3mXs6kS8So9wysQtendAb2l9FzqjD0OBrl7nZSyTwadwxvj?=
 =?us-ascii?Q?t1rv8D9exzChwwONCiK0d+oNywhKK89C5pBwwK5tRm+5RG8OCf2299wNaB0+?=
 =?us-ascii?Q?iSbvpDGc1HUkOc1lrlI02wh8VJVTzjb9moJB3jdbFdVqxNjugvlPazFMkfPH?=
 =?us-ascii?Q?1LjobLSWAOSk3WqmSRKTWNYjKv+1q9hNHMXiNY6wEzKePIluoqnFdJUx+dFo?=
 =?us-ascii?Q?NcCGAyp7yB7ghVyAGcoeuTQbl3+EQitHJ5IBuDlAC6yGu+T6o8Zpn0CI/k0a?=
 =?us-ascii?Q?6NPU6bYjvNwWy+h8hCixVygYsZSItDhCJ9v66MYmqkHnv5ZPHFFloXq8bMZJ?=
 =?us-ascii?Q?2PfvucYTPUp7QU0areYEpYPD+MHGHHB+ZS1ZrVjPt4AZMCpcIri/TiNFrgMQ?=
 =?us-ascii?Q?N1gH7VlhMwbHcgt7OTpl4LXet4tiSKWZvGXwdsWptwSNQdyFUHGnLsgG9Y+0?=
 =?us-ascii?Q?tny2YIZl0ip+i3DY7HyJDgz7x533Thx2NM19sWh1KA4QOt9zj0An6zy8lz98?=
 =?us-ascii?Q?VJrP9op2uc8xOS3/zU532Ja7CI2GsnrgeGJ0QZwo08g1Wf7nVb9Edlzchm9o?=
 =?us-ascii?Q?5tzy9GDOaSXA60IZbg44PO8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TtQJZMhb9QaDF2xYau6QcZeQHAXkgQEG3L4r4nPuSoPNzUV5Kztxxgi88OrDQiyuH1QgfzLvpH5FlrBEQ8Az/BqE6X6jg9czV5fGMEe1WXzql376PeInWBn0Qd3qn0o82zTqc5R+x/twTS8b2H64lohkxLfVnGtus8SShrxv5V4DWnEA6EldXmuWc+WVo02AAqle3twWjK+4DDRENgiI3nYFpkDAAQfXjAiI9Ms45HLyclj+VHiKWxz78nwK9F7CSOdpwF+XbpJSCCp2r/Ln00e97Tj8+gZGEE4uFZ9u5JMoKc7FAFNzLc1zqazywcji/4o72TI37i1/l776fhn8e9lp42nu1mZCuNVf2xcOusXxFafKn055Tfm9OQ6kx8n6dOJR7/doGKQ/iNO31pHvb4qhk7kD59d1xoIs1HldCdjPW7ym2Pm0aLq2bEcEq8ymUVz/GNN+V2Nwtz1vwwfdOKb5v2roDTON2yoKYnZwYY9MURFNrxvYjGIgoUX6WcXxDVXaX78aAv9V4OBLRVCwgsiKOQ1ROmKq17t7zPfTlEE4Ibi13vxiNcxX4lG8uilPE+nWiOnUYixNojpvY75nN7oFxZsZSynEKSJxLuyhZcet8nQIb573jTvMcIR6FEjc1Sv2gAsmwo4BpEYw4CT6+9Wgi3rKhVhncwK2qropNK/dWhNNsVQ1s2to7b4XV6Ncnr60jnWP8vDburoSvS1yI+3+V9tCPtnp27xjuMHZDdti84M3ru8rv4MnHTbkb3Hcxv5gRyKQg+gQksmk1yMpjWjIHO6OH26hztmnL34wEItILSzd5Lvtkc6svOcHuBeJSDF3j65HwpT9NLLp0mtj4iFOxy9S4zSqOq+au2HIk93mn0Li5drsXfcos/mlWOHL+LwhgRacQcCKMMm44XaGKg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f740fcdc-0ccd-4a5e-98e4-08db9f2b9490
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 14:09:32.9855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRAAHPBbgw6YyLhvGym/U0Gtln55BHPuuSjgQNtfo5UiMXGiETlajfvqjMIl6vwlRrNt3RyCSKAki6hgeaZKeaXZrX06vJoPcX23VlBT3Jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4368
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_08,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308170127
X-Proofpoint-ORIG-GUID: lIrURG7qe73ns1w9-JAcmrSkQbgpNjfR
X-Proofpoint-GUID: lIrURG7qe73ns1w9-JAcmrSkQbgpNjfR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Systems booted with shim have a Forbidden Signature Database called mokx.
During boot, hashes and certs contained within the mokx are loaded into the
blacklist keyring.  When calling verify_pkcs7_message_sig the contents of
the blacklist keyring (or revocation list) are referenced when validating
keys on the platform keyring. Currently, when validating against the
secondary or builtin keyrings, the revocation list is not referenced.  Move
up the check to allow the revocation list to be used with all keyrings,
including the secondary and builtin, allowing the system owner to take
corrective action should a vulnerability be found within keys contained
within either keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
v2 changes:
Since this one seems to have been forgotten, added the two Reviewed-by tags.
Unless there are any objections, could this be picked up?

link: https://lore.kernel.org/lkml/20230117171506.3888602-1-eric.snowberg@oracle.com/
---
 certs/system_keyring.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index a7a49b17ceb1..6bc138bc594f 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -251,6 +251,12 @@ int verify_pkcs7_message_sig(const void *data, size_t len,
 	if (ret < 0)
 		goto error;
 
+	ret = is_key_on_revocation_list(pkcs7);
+	if (ret != -ENOKEY) {
+		pr_devel("PKCS#7 key is on revocation list\n");
+		goto error;
+	}
+
 	if (!trusted_keys) {
 		trusted_keys = builtin_trusted_keys;
 	} else if (trusted_keys == VERIFY_USE_SECONDARY_KEYRING) {
@@ -270,12 +276,6 @@ int verify_pkcs7_message_sig(const void *data, size_t len,
 			pr_devel("PKCS#7 platform keyring is not available\n");
 			goto error;
 		}
-
-		ret = is_key_on_revocation_list(pkcs7);
-		if (ret != -ENOKEY) {
-			pr_devel("PKCS#7 platform key is on revocation list\n");
-			goto error;
-		}
 	}
 	ret = pkcs7_validate_trust(pkcs7, trusted_keys);
 	if (ret < 0) {
-- 
2.39.3

