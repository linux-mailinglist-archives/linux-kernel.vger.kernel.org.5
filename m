Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB5277068C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjHDRAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjHDRAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:00:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8BA4C0C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:00:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374Ei6wF032152;
        Fri, 4 Aug 2023 17:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Z7Gj5S0j9aJuMmiu8QbGEoIFKbCYb02+sSjKCP66TtU=;
 b=eSOhx8TgRZwZc3YlZY6Ir19XNkq2l/W3HO5GD8fM4Fp1qpuqZ9HvlEUF1Q3xEbsudyl5
 YSzxtdqZvL/V65dpOxu3yMhXQi1rGa8ub/sOrfUit++S0XxBoSNBupS5xfLP4VvqjtXk
 Xv5htHm3FJGBmZF+4nonpbcYPN/zEJrAQw3+eIVAZrFuAJ8T8f6KoxnW7XnpWafWfo4W
 6X7AXzk537jAaUpQ7MMqv+nM439wZsbiaKP8enoy+26VSdbrQBiqVeR1ZwLlMbB+aPES
 y9l/ZfjNmvj8TpBU+CSXFNCpgiJeILXluhPbt1LQtAHWtSSBzDKLB8d5QgUhlB+v6JNu rA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s79vbx9eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 17:00:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374FBTWQ029325;
        Fri, 4 Aug 2023 17:00:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s8m29bn0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 17:00:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyqsAiCRKCZuWfF9Ah7S2aYj0Sva/MFw0cOqYhL5cRXjd+V1j/GL84nDQ7gjK1eSwrSUff3B4l8O+Y3qoIWyDFc2aBEyLWG0WP7Ujl8EsrCa1kG9I5KJDYLyWkTdszUddFeqLCTJ8DLEKcS92P6liH50xEjm/YJmjH1sSeNM/CF2rpUeOTib157mLHC+p6vaUO52IKJzzL4fTXVrFWoexN2gVw+vc8pOEhshW4k7BWf4D8xLmAmvgSmklK1zNrN9V5eYI0OVBjxhLHgqQqufobZp83SI5l+/FMYuKdm1CGxYUJ71fymrgX+ivLAc58Jdqv6OvN8FvcVnQCWJADzNGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7Gj5S0j9aJuMmiu8QbGEoIFKbCYb02+sSjKCP66TtU=;
 b=SZx+r65ZhWHNFAMAeri3p+YUdv4AC/SgVO1S6zA2lFFVT3mEPiFEcLEpTCJj9a6hHVfdOtmBXFNgI71AYjDK0FtdvGn+5ORVWVnO5+QvO6+Hipw9UES0ctL+3pvxzpmQGsyh2q40g4uPmtCUndl3D9ARC8Vyuz7DUHDc6sdssCu1QyDuak0BkC6CBfsD2KNHzWBNs4J0XKN6CSQV/Ph2Y0tB/u2mwS7WveSkgPJRJiPfpwQZbya1aGpstOYpFIBJjN9p137bUIOYfatYVVb/dhQ+xkD9qBBoeI8jlBa+qneyKcPDipQsqR+9nw0vkf1fkN/K7Ys7qp2W90VQxjoVEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7Gj5S0j9aJuMmiu8QbGEoIFKbCYb02+sSjKCP66TtU=;
 b=dgnDjNtibR7qwsGr4ZK1RxfsyJNSplNaSrr3VFp9O/Mc94MqIyBo8OYnge2PqIF+qUT/YqrcTFSru4mVqRm16r5Y9b+k6dOV2/cBcDZdTg1MGPLyPlKF084jMMH5o1uXyGkEkV/luvNRDM/3mnMPI1ogP0VoEaEEi6CDnjvD3wE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4939.namprd10.prod.outlook.com (2603:10b6:610:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 17:00:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 17:00:19 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 3/6] maple_tree: introduce mas_put_in_tree()
Date:   Fri,  4 Aug 2023 12:59:48 -0400
Message-Id: <20230804165951.2661157-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230804165951.2661157-1-Liam.Howlett@oracle.com>
References: <20230804165951.2661157-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0277.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::10) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: dc592ef8-9cd4-4fdd-8541-08db950c48b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H+0tr6yQAUTv9uVDHF4xH4n91gbWXUUC35WD4lLSv/D3QFyIWDEIEzAYjMX8SIEQBE2a9HiK/YuHCoZzRsKUzkVB/IJyUUgoY0KmiGuXdlyecfcmovWdBMDvrldVKm+VBezW3wfTCnFStd+xaBECNjGCtYvU6qwedV69+mjVfnIFH7SN+UlivD9NeL4RISxSo4EL9CPM3nN8bSitCtaeuqqhNAA1IIXNPBz9OBLmd9p+UL2zZsUsxqT8G0D3kN+se8EDBFVzlbBvOACQxBUJUAx8/ZHOzGmq6RumyAP1xs62T7mpxkR7x7Eku6rS+NsE0cKnQfo5JBEkD+bSzaLzONb0SNlhcesVelJbsYYAToJb96mJj3hmtOpeYHN324fAPBdhLbD/a4F2IgKGlpRVTlfthf3oti/dcVBVvvh7bQQ0NuvPJeXKUsywzGopO6gogObf2Y+XU8Bfd/wP9GW0X+cBq6HWjeSLzNdCNIy0MqE1cSgHjeueAY0EsYBxj2n6YhCQ7W/Dv0FbEuIKK5byFvwKCaiiWb9U3WvDD9b+eWv85JJyMGQa1KBgAyYvEHZs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(376002)(136003)(186006)(451199021)(1800799003)(6666004)(6486002)(6512007)(86362001)(6506007)(26005)(1076003)(107886003)(36756003)(2616005)(83380400001)(38100700002)(5660300002)(41300700001)(8936002)(8676002)(4326008)(6916009)(66476007)(2906002)(66556008)(66946007)(316002)(478600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eLVDOabtYvh96iaW28fjFiN0BI6+XPBKey+dLuuiNE2yEBH8rsoNmQXmqFb+?=
 =?us-ascii?Q?1B0Z6N3bMijFj3LvvBmorYeKduZ+jYWlE5MNfIC7XmgB/2IqyRNnuYrcfLnq?=
 =?us-ascii?Q?kzLk+hrCZPnaL9Pw/fpd2AgnPzTlXxhCOdUQILuX8WwbXO2yBFbeuWNBvIyf?=
 =?us-ascii?Q?U8HPn5AoTZ012PYMVmV/AX5urhVzGu1NvsM8zJ/wszmp+3a9Heyx2VhvoZjZ?=
 =?us-ascii?Q?xsP+MTbi+oUrIgLHpzvbFRwqYbiTMmqWzDQZWE2nHV21L3khJB3gESAAZnEK?=
 =?us-ascii?Q?0aHN3WctbB0+P3C96bmD2Nzv4aY9chUquxYZIR1I5LaT8ZlgW9flHEsC2lQa?=
 =?us-ascii?Q?bV3qvjHLMoCSVJ8UI2osXIj2tLA7EZy2vYDD8ss1Jd4BzjRT4w+R9LU1jlAq?=
 =?us-ascii?Q?XWCJXFPxAUkzTBd92FC+p0Aq0wewsBuFrQ7CjZebmWVr1kizK0a3JXPfHB4y?=
 =?us-ascii?Q?aYoCHYnPmg+iG8ecltJXWgAVFzJe5GsJD6xxDXWPaOVwEaZ+PfOqdqtDsIc4?=
 =?us-ascii?Q?nFj76sWd+Sa+rk1eLhWwJ1ie2TwXAFEea68fXeXsDkL67w5F4TdVdhirvwtc?=
 =?us-ascii?Q?Q46NUQjn+qAU2cV64jpso4rtjB+WznolKmmTUTTZvBdjziEI4iBqSMZz0PgM?=
 =?us-ascii?Q?V6k3VyZpfr6sYP9lVBWIkTA2WF/+/FSwNnjYkCY/dkxp0NRpDi87VyqsaJjD?=
 =?us-ascii?Q?q3HarU1NlxgNMfcd82psf0y7PD6Yh9pCltItdYGsSZs6AF0XtLZoZf+OtKPo?=
 =?us-ascii?Q?p61bjRR4wk8DdaFcw7xVRzWUA3z6lM2UeZ/m4khWJQ7nb90tBnxAkfFS3Mnu?=
 =?us-ascii?Q?w9xu8RTpLgKFD8WDbkjSvJZ4pgTQ0RDaewIkXn7bsYlXwFOEi819jjd5RXWB?=
 =?us-ascii?Q?UFekgNd4iIfHc6g//DVDtQiCbkViE9Scqpqbg1aJnQUy7C6uPmuZ5VfsRxYo?=
 =?us-ascii?Q?36j7WKhOABuicPzCkW1AHLfVX/dl1LW0M0k691tvl4foUDVK6HM1QTU7FgSq?=
 =?us-ascii?Q?IpBWCKpf9qJF54V5IWkSTyy2Jzd2DcXvpfk4xOcW7dMJChxDOPfumGiZv3sr?=
 =?us-ascii?Q?QcTqhdaM066JSeSHxuYe4sEXylfnXndUsnm/7V03DYgUxXUBMuZ5C4SAAuFz?=
 =?us-ascii?Q?NqRfQSfQrPdSo+syHbOJSttUsoAtzRwZ3SES3TnWRGwqbVEfFhkrF601WRGy?=
 =?us-ascii?Q?fC0A66dlax8ekCyFAtNIltvxKe8WRky+9JXJWDVhSt36DmrZJKYIPnOce8xm?=
 =?us-ascii?Q?N9Ua5HT+ahMUdvRTPQc3gzJHHxm/dXcmafLviTfWwNrSJVMZHMIWy2MgLPzD?=
 =?us-ascii?Q?wN6tGzVrffvFC8X3AyPB9ZjYvqo/rQdrZFQCjtCxiqJd+usbp2AhHqeZzyBt?=
 =?us-ascii?Q?lhjFQDOSls2TCDuBkN9Iflq3bcUOxF20QgcEl0+LB6GzQFtwd8ElI8IBDet5?=
 =?us-ascii?Q?zkT2d2mjLLqd4kfwl7d+PgtGgB25THXo9FtK+5ZwGUlAnRpcRpuPOv7EoNzE?=
 =?us-ascii?Q?XvO55rg3IYy3RU8ioTw1o2F9AqpHX8+9op6s439d5KANPmpyESBEsKuyMgM/?=
 =?us-ascii?Q?9RmwkSfTUGfgr+ZUHvmofswl5M1AHHSHPQw7r07HbZi/sd3aFhQBcA84lrAP?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?sWdmtV3O5dJ13qSJd3K3X+oSEtJ3YkLmeZKYG4K3svViO6a9CCWOtCcyO5Ag?=
 =?us-ascii?Q?paKRUh26Aw7ayJDHgsg47mz4jQ8ucFr9E/26vv3/0mP1suMYcAyLNlC4BjGn?=
 =?us-ascii?Q?gfpaEsrwqxS+BXBX7tov6blYlOxDNyOYglyMkQHm6hmptbapZxydKNgn/4Du?=
 =?us-ascii?Q?BGQwfw5HMkD5tzOXamRKPUm6UHiMMEpinbZd8JxtXKSywJ7LJBuJyp3Dy/nO?=
 =?us-ascii?Q?f2vWvhSLXEwumi5WqBkFSlhnEdSQxOZUExlj70JpJr7AS/buBYdVQB529PXT?=
 =?us-ascii?Q?pCybFDrrKKN9qC9xxIbWWoy8aUrIQzemfFakBfAAYFH5jCxSVumEh7nclnTi?=
 =?us-ascii?Q?uzrj+XFW8LXnRZtTgcOY+rMN4Z+cd7vYgPqgHuM+uI9o6Cw2HWog+LqKuPpM?=
 =?us-ascii?Q?Hol5iiLzyon+4juFF9M0IOqCGk8CZKJ/Fh0ziw1Qk8NCvoh7rgaZ9vzoJhaZ?=
 =?us-ascii?Q?xuWAbpLJX6dW28T8gXYfGQrTTzaP0BwWHk3S9ZfNx9Q8qUybSmpPwVXDIKp3?=
 =?us-ascii?Q?OqUd1smcRk0sDJ8sYBKSIHR8QeFc6XkcFfmCyzxWNQiA5xVuXUx318mST/Tq?=
 =?us-ascii?Q?cYzFUsV6OYhrW+aSlPAr4u7lXqAE6+z0u0hzGIKYw0IYP4Leb/DxtfCeyfDd?=
 =?us-ascii?Q?Qo54pPtOX209AfwqN7pQVW5D9sAOXz466DWsuF8FU7AjdmWC7BwVDpet/7MN?=
 =?us-ascii?Q?sPxt/Koxc0Zroor6cRWD3uf+93pYRug+LJJBRh7AQv8dhD0YwSR+4D9J8pyI?=
 =?us-ascii?Q?MEnCV0vCseHhiU4fZcx0vrU20TlgT9iQgXEHC5DpG6YCPbQzdu8lIiRuJQau?=
 =?us-ascii?Q?42xkg8/M4rP5PEmd2MPQwbpDiM0TBZdgDoFVvzyOBL0cdZlutPwUd9QLIXiy?=
 =?us-ascii?Q?wLaXxjdRaZKPj9Nvc/0UGF5iLg2eDnhd9IW5GptMohjKizyaJEcISR0zlF30?=
 =?us-ascii?Q?rhcsn7HWhuuclaof5+Lq3HfUSXwvZPTagxnLx237kds=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc592ef8-9cd4-4fdd-8541-08db950c48b3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 17:00:19.8035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WlWdKj4W1aijM1nMtEpg1WrbNxT0sRcU+m3Q9v/Xou/BcYtwW/wYVtUobhg72QAxSuzjRdV+6NBKX7+BpMdsVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4939
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_17,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040151
X-Proofpoint-GUID: jESdJAkz7tnNYuATUmTO2uzn7cRKzltb
X-Proofpoint-ORIG-GUID: jESdJAkz7tnNYuATUmTO2uzn7cRKzltb
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_replace() has a single user that takes a flag which is now always
true.  Replace this function with mas_put_in_tree() to better align with
mas_replace_node().  Inline the remaining logic into the only caller;
mas_wmb_replace().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 73 ++++++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 46 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 0d4573a8d134..c01b1be1480c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1715,45 +1715,32 @@ static inline void mas_adopt_children(struct ma_state *mas,
 }
 
 /*
- * mas_replace() - Replace a maple node in the tree with mas->node.  Uses the
- * parent encoding to locate the maple node in the tree.
- * @mas - the ma_state to use for operations.
- * @advanced - boolean to adopt the child nodes and free the old node (false) or
- * leave the node (true) and handle the adoption and free elsewhere.
+ * mas_put_in_tree() - Put a new node in the tree, smp_wmb(), and mark the old
+ * node as dead.
+ * @mas - the maple state with the new node
+ * @old_enode - The old maple encoded node to replace.
  */
-static inline void mas_replace(struct ma_state *mas, bool advanced)
+static inline void mas_put_in_tree(struct ma_state *mas,
+		struct maple_enode *old_enode)
 	__must_hold(mas->tree->ma_lock)
 {
-	struct maple_node *mn = mas_mn(mas);
-	struct maple_enode *old_enode;
-	unsigned char offset = 0;
-	void __rcu **slots = NULL;
-
-	if (ma_is_root(mn)) {
-		old_enode = mas_root_locked(mas);
-	} else {
-		offset = mte_parent_slot(mas->node);
-		slots = ma_slots(mte_parent(mas->node),
-				 mas_parent_type(mas, mas->node));
-		old_enode = mas_slot_locked(mas, slots, offset);
-	}
-
-	if (!advanced && !mte_is_leaf(mas->node))
-		mas_adopt_children(mas, mas->node);
+	unsigned char offset;
+	void __rcu **slots;
 
 	if (mte_is_root(mas->node)) {
-		mn->parent = ma_parent_ptr(
+		mas_mn(mas)->parent = ma_parent_ptr(
 			      ((unsigned long)mas->tree | MA_ROOT_PARENT));
 		rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
 		mas_set_height(mas);
 	} else {
+
+		offset = mte_parent_slot(mas->node);
+		slots = ma_slots(mte_parent(mas->node),
+				 mas_parent_type(mas, mas->node));
 		rcu_assign_pointer(slots[offset], mas->node);
 	}
 
-	if (!advanced) {
-		mte_set_node_dead(old_enode);
-		mas_free(mas, old_enode);
-	}
+	mte_set_node_dead(old_enode);
 }
 
 /*
@@ -1767,22 +1754,7 @@ static inline void mas_replace_node(struct ma_state *mas,
 		struct maple_enode *old_enode)
 	__must_hold(mas->tree->ma_lock)
 {
-	if (mte_is_root(mas->node)) {
-		mas_mn(mas)->parent = ma_parent_ptr(
-			      ((unsigned long)mas->tree | MA_ROOT_PARENT));
-		rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
-		mas_set_height(mas);
-	} else {
-		unsigned char offset = 0;
-		void __rcu **slots = NULL;
-
-		offset = mte_parent_slot(mas->node);
-		slots = ma_slots(mte_parent(mas->node),
-				 mas_parent_type(mas, mas->node));
-		rcu_assign_pointer(slots[offset], mas->node);
-	}
-
-	mte_set_node_dead(old_enode);
+	mas_put_in_tree(mas, old_enode);
 	mas_free(mas, old_enode);
 }
 
@@ -2789,11 +2761,20 @@ static inline void mas_wmb_replace(struct ma_state *mas,
 				   struct ma_topiary *free,
 				   struct ma_topiary *destroy)
 {
-	/* All nodes must see old data as dead prior to replacing that data */
-	smp_wmb(); /* Needed for RCU */
+	struct maple_enode *old_enode;
+
+	if (mte_is_root(mas->node)) {
+		old_enode = mas_root_locked(mas);
+	} else {
+		unsigned char offset = mte_parent_slot(mas->node);
+		void __rcu **slots = ma_slots(mte_parent(mas->node),
+					      mas_parent_type(mas, mas->node));
+
+		old_enode = mas_slot_locked(mas, slots, offset);
+	}
 
 	/* Insert the new data in the tree */
-	mas_replace(mas, true);
+	mas_put_in_tree(mas, old_enode);
 
 	if (!mte_is_leaf(mas->node))
 		mas_descend_adopt(mas);
-- 
2.39.2

