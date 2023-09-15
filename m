Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F817A2A63
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238175AbjIOWRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237958AbjIOWRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:17:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FBE83
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:17:09 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLvnCf031156;
        Fri, 15 Sep 2023 22:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=KVXGH08x3ax1vR6HN82mHK+6ICeAb1chYX6HzievKKg=;
 b=DgP6mbDbVJa1qzsYcAqVKrO8ymVx9c5epq8lydAI12ygLnk+ZZEOxhUbHq/aZULbSVfd
 5A4UxSJlDIRU5RDi0dFKcY7Ws2MCcPgc1x5Rz54yWI6pR3pA71J29bJQmNA9Rvm6rqXx
 NkfWBZhUIUawGOUHsuRNm8prXxOmQG3gu3iM2y/8tZBujoo7iMD/BarBpfvKlIgWI6uS
 bdlSYyYzPdLHyPqzvsL+JYgIYB+XddLmG0cEfiepXyiZ0ASifKPzW/y8zO9ZWkR9eWro
 x064rmECKZsg5sddoet7qQ8mePWDtkT5gymYH3cbG94Dmri8X6SYmO2YeVAAIFRRjv6m Sg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y9m0nyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:16:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FJwJrf030387;
        Fri, 15 Sep 2023 22:16:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0wkky7cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:16:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+MyylBfOtq9yEKf2s2SZWYmUjUWX0MCEHNdJrfOAE/MTADxtUMKZx/JuQOLrf96/TEzPDPYEGcGEDutlW66W0v2+FY9jmkwEo2AKTx59cWOkM4eyq0DhrUIWazD2X7w6jkGnSltUANC5RGABTKSnS0D/3pU9nMcHsQipwFwyEfdP5iIK/Rd8+5Yv9F8/5Um1yazw+RDmRSkZBLqae4UyOTfCxlvkkuXWB2PaqsVDhTzYdjTJYMdZICm5AWUnTCDxMOfNICZQnng0V+2peE/kgtKnBByI0DDQ0snl+2vxDS+aao3mTPiOGdf7r4qxLKxpUzTuWlzla/PRIambwIhgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVXGH08x3ax1vR6HN82mHK+6ICeAb1chYX6HzievKKg=;
 b=JKzcIjqHr6zSYb6Dm8DHQB3esaFbZ7i7ZKmRDcson6ZwjFv+hx6tFaUm+XusSW3tcpE3T1l0ILsXQQ2lyLWlELrziNIkFnM+jPoKukc1IOdUfBpAKD/JiHtS/rDj6CurlLXGNbiM8dxFsU2b7mgIzBHk4YL2rAFqC2yPi8opNZOKMfAj9UNWVru2DGlDiXvi8IQe7WGjAu1TGnM415Gjih+t4jJZU4n85owOR6+3j33Vlu/Ehvb37i7W6UHNWuJ26bcKN0HoALSbO2lU64kW3hSWzoOTNBFjQZKxKYfrxEVCAosclM59BPVlV9ibp4TYzvcwikmwX5oNA7YFDDY2TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVXGH08x3ax1vR6HN82mHK+6ICeAb1chYX6HzievKKg=;
 b=MqTiVVZB8yshw1PoVV3hAUuyFr+6Vtux5EvhsSykzw2jSVHHcowqD0pki823Zoun2RlqrWtumKWR5GxN/G5I9NEAdcKY1ZZ8j87BneUOF0cyTI3dPqnYTBqZLhMP9lkdrhSMQCMQuEB7Q2p9AXf1vRMpAzfSPIB5aqjK5ziZJAs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5861.namprd10.prod.outlook.com (2603:10b6:303:180::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Fri, 15 Sep
 2023 22:16:22 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 22:16:22 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 11/12] hugetlb: batch TLB flushes when freeing vmemmap
Date:   Fri, 15 Sep 2023 15:15:44 -0700
Message-ID: <20230915221548.552084-12-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915221548.552084-1-mike.kravetz@oracle.com>
References: <20230915221548.552084-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:303:8e::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: a9445a06-5465-44db-5ba4-08dbb63964dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rLGGHI3ilkJTaiF9zRX0mO2qMjMl/hGWkFrS9U8cfLFTJVeSRc74rMmKoru6Rbv6YpqLCn1NEPRRmtJSqUwZdbj0P0l0v6auqYQFXMNwVrDYhSjluQxfZW+/w9+cWp18WBRXAALEuXB5LeHtv34+j8rwWShxmFw22v2oLMptxWGD29eD/utPmLFfQN1iMwLkvR1TAdVFdMlyBhHWPNWpc4b5qqVaseSfxRcTSTl0RPdXYpx3mnEQN9Wtp+k7sLFrMiGagYzGecgwqr/dGD9JqDB/4AOEOrgq2bfK+tXvX9k6OC1LtZ6b6z+7IcRCSICTN7XJ1Cl4cu3G5Oa7BBmMTJBFCEacaX+BPk7SuNmbvuxlLtxQRqaDuVhTDOwTMxVN4pU0haCfVHJz1LM9jOx/NAqVYPkTBCCKcIKayJPM6WnPwFRC8PUPI2dpfgdwocFHxs7x9WDjaQgrpMljJ7EzsZTIg+C+auqBJk9ZglGS8oRQ80N6T8BLasr321erXaVAvbOOwswGwCeVCyj+VEEAeCPdq/BQ3PbLsRU91TK7pU8gTesO3w7tpnakL/+UL5Vj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199024)(186009)(1800799009)(44832011)(86362001)(36756003)(83380400001)(2906002)(38100700002)(478600001)(1076003)(2616005)(26005)(107886003)(4326008)(6512007)(41300700001)(5660300002)(6506007)(6486002)(8676002)(6666004)(66556008)(316002)(66946007)(8936002)(7416002)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qpVFlkuNaQld2kWan3MVFklbwP3urrvuCAYJ1C91vbnhKATaWH06c52k/2Uv?=
 =?us-ascii?Q?X+8Yx/QXXNQduLKELLYR9HQx1ongxa1POqUsm3Vn0BKJDN61akb90p2qhxs2?=
 =?us-ascii?Q?fU5HMkz86O27z1mh8hfdTNGmijUbK/EUNRrCu9tCEHiZ5L+kRlJ0lTKZpc7a?=
 =?us-ascii?Q?BmOuXEadYkenKFgnaGz9GUZ61C+B09DGgkRlt8oy3v3fpEYGSqaXHrxhboEH?=
 =?us-ascii?Q?rcfAeOWsn6rrfLtY45PqtRm9lgsco1lR0u94bu7qXxBgjIbiN2zpnSZFKoQi?=
 =?us-ascii?Q?syRootaHYYA7V/sE14bMQPyvZo3uavEZySV5c34y5BpHvUmldwfAoNErQTot?=
 =?us-ascii?Q?canZKl0k0ESaBtZrlllW0d5nhVIiq4z2Dl/UP7hU7mWV6KdhsoBMKF4ftw1+?=
 =?us-ascii?Q?8bGCYjNP+6zg60cUiQY1Wuu2ECrEo/Uix+uPQtdcsXxfJIlg0RrbjNs3AH0u?=
 =?us-ascii?Q?UE2sPPVllOnQ4XNgpQeavtPn8s0kthUbABlHMK3Taxe7hv3THVGPEpquQiva?=
 =?us-ascii?Q?3e1962sWgF4U4szhOG/hNWhm2qX1ihihqdQ5Vb+9EcFrZKOWQG2tS9INezG9?=
 =?us-ascii?Q?Q/rkJJGOL9h7SMpOTAsTqk5WseLzVhhQUb7fS9dqPJp5sLSTBXqR22YB1rb3?=
 =?us-ascii?Q?thm9d3VBaZomkRHh0JfK9LoOOOrctmnEgIZBPRks3UCN1Df1K74fNutHECC5?=
 =?us-ascii?Q?tWUE29NMFdgksQCJnEqWbt2eGYszu/LMY0bzd4/iwHUEiR4O+Yl5MkYxM0ZO?=
 =?us-ascii?Q?FYNo2MnWrCMRB0lVZWWwDapURhfhVR1QqcWENRusPy4fGNaz+0Fs9BCKYcQ8?=
 =?us-ascii?Q?fg8SSo3BSlcNBmVFLtHYvoki68njo2HfoJ8ZeJHbXwB6sfGVgZyx3jxmOPsK?=
 =?us-ascii?Q?QvbHxwuztw0QXlNpfr8iDNL2Un3PZWXj5Y2himZ1iAzZ0R7VpMlFflx2KmBR?=
 =?us-ascii?Q?SAFn7QUJsdbX1izT0YbdcktdznHuEwU70QQPcWjKjsHtseBXil4eP/zkYpD5?=
 =?us-ascii?Q?xujj6zOVrgCpWwuNSJAlL7Yjv9NzM5rLX2yvQ1eHdv0UlITNs562yxTRyMcQ?=
 =?us-ascii?Q?8udfrE0unsmOi9NBdzh4gDCoBBgF3j8dXQSwLuBkchlAtKE/BNXlWx96Jq9C?=
 =?us-ascii?Q?zyjWXcoqJ2UwiULYfRJvy4d3on3uau0AoxCssjfzOlyIMQWSpoQao7VGyrY0?=
 =?us-ascii?Q?vzbuqLLy2RdCN8qYfSzzsT8yWSEe50qYL/F77oCVZsQ9EXlmv/OPll+08YNr?=
 =?us-ascii?Q?xFlJacg1PralCmxXZeuUdZWDjdOyRoagWksZ3B8+QeED/BnWeSgCGopyvXmy?=
 =?us-ascii?Q?OG+2gZgy0lhLsfZRVeFUrWGMUlQ/nIv+ccpPu887TI5SeGE5d27GyIqUWibT?=
 =?us-ascii?Q?9fIBQLq42zCeXIKBKjhBbAcZ/TIxo1b5FWmKR3EaHGZo8VGWeZiFPXtMomvQ?=
 =?us-ascii?Q?zNglbDV8KTr7ZFOFt8ks+4A7K7TLuzWf+8PELSZFUBZUP3Dgmrb3/Zl4tGiL?=
 =?us-ascii?Q?M/Pxi7of+gI5C273YfV+KZJQee42QDz2BsPwa2mzWc4TFBInzIjjIM8y+x0o?=
 =?us-ascii?Q?U9S4dwfAM9rKzxOqc16TX1kcj8PAzNutYmfK5CMnBc/m4RzcH4cv8U7EEQyn?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LLt4B3ge3EZq1PzKHTdip/EFr35PGYcJsT/27O3qoAIHHf87vrqj+aw5KB9F?=
 =?us-ascii?Q?59iR94Kmp5hrqrexFgY9JK7Ouo93k8ErBe0UgTbB9tBRjQ9cI7cxj3gunzW7?=
 =?us-ascii?Q?Gb2KMR4fYce1QTTVnQYLfQ4/E9yww1Z/gN3zW2bwLcyVWU3qBU7hZ4Lh+eE9?=
 =?us-ascii?Q?ix0Bs7OEh1Y+uIlFHt4yZNMpP9tiIYU4WiO/pgTPWXei4XXTXVz3lTYj3rt7?=
 =?us-ascii?Q?s+hmzaN9Z6zCI0B5Ve3BWigvHv0OO2G33K4OGX9g3I5RdMPqK/7JrF3Xt0wd?=
 =?us-ascii?Q?BmyTvdacJknf7T/tC1E3x27DQYbkuHlbE460wQu3sNwMzhxAY8CtAiOGPsr+?=
 =?us-ascii?Q?kfoaqoLFZ45FBOBwByhTfpWstPsLhACbTbdWKucXv9KH9iJ0P/R8XmssA3Qy?=
 =?us-ascii?Q?RQYlzq2v9TfMWOR1ok5b5lnJ3zBU9XE3ANl4yVtgLR0n85lHt/avQPpO7Rci?=
 =?us-ascii?Q?pjfiOL6H7JLfrULu/vPrtYkJe4+0QIgpGqHb6QGVMDgxeLqyCRvzS7JNuNoM?=
 =?us-ascii?Q?5DJCeKhU+5lTbH53LCC9OxQh8QpZhb2HxVxF0IsQeEo3CpdMoI4kHA9GOsr7?=
 =?us-ascii?Q?xql/9EIJjgfYuzOkC184nCj3ezgLTiakTapNzCOj5GGOk5+dn51HVw3Qqc35?=
 =?us-ascii?Q?h+aWC0SuL1U6uam/tRl6hdHtAY6s4okovydryNZiyvZsYpp0ktxOxtWlmUqF?=
 =?us-ascii?Q?cCrsLsFVpAFHg8D7zaeT3lLlHNGh5FQs4+Kupiuv5M8z+qobAExvcK+PS/qo?=
 =?us-ascii?Q?uZEUfEBrr8OUb2LnGEPJ8Etr67chOT4cPU5nb+KJuXxqwlI+4usd5j2k+VOz?=
 =?us-ascii?Q?+K+ruLj9JVO2GB7OqN5v9lysHpQewOzjo/6TMU46SAIkZWyBwwQzb0NIQwdn?=
 =?us-ascii?Q?a66IrGoUkLhPP7WVuy2zQlCOuoyNlrg2WjF2P0seG8pPdf9C2Ch9Uxp4onBq?=
 =?us-ascii?Q?6kn167GuDDQMYkxKljiMYh+tLbz6ONzgMcpmCaMeT/A5fqKygQm9NXJFD34w?=
 =?us-ascii?Q?sdejk5WiM1cugPQ3VNAgr3mSrSWDK5PTzuYo7pHQ6In2o0y+twXGV/oCYLpR?=
 =?us-ascii?Q?T/a1/sdGCgnX+gAdnXBLxOLvRkiCoLqJeAcxWTI8N5ZAXxiqx+bWCaLS/SSv?=
 =?us-ascii?Q?Nxc4b0lqKndb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9445a06-5465-44db-5ba4-08dbb63964dc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:16:22.5921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+VB81NrBPXra16DfyJoa6+XvNIx1KquXGYW3eCn2NTqitWtYVA9TrzA+0oAXp63JqHQyXDqN5xsih+Ws85ACQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_19,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150200
X-Proofpoint-GUID: bJMmjlEics-sIz0b4OFHXYuD1U3EifRW
X-Proofpoint-ORIG-GUID: bJMmjlEics-sIz0b4OFHXYuD1U3EifRW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Martins <joao.m.martins@oracle.com>

Now that a list of pages is deduplicated at once, the TLB
flush can be batched for all vmemmap pages that got remapped.

Expand the flags field value to pass whether to skip the TLB flush
on remap of the PTE.

The TLB flush is global as we don't have guarantees from caller
that the set of folios is contiguous, or to add complexity in
composing a list of kVAs to flush.

Modified by Mike Kravetz to perform TLB flush on single folio if an
error is encountered.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb_vmemmap.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index c952e95a829c..921f2fa7cf1b 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -37,6 +37,7 @@ struct vmemmap_remap_walk {
 	unsigned long		reuse_addr;
 	struct list_head	*vmemmap_pages;
 #define VMEMMAP_SPLIT_NO_TLB_FLUSH	BIT(0)
+#define VMEMMAP_REMAP_NO_TLB_FLUSH	BIT(1)
 	unsigned long		flags;
 };
 
@@ -211,7 +212,7 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 			return ret;
 	} while (pgd++, addr = next, addr != end);
 
-	if (walk->remap_pte)
+	if (walk->remap_pte && !(walk->flags & VMEMMAP_REMAP_NO_TLB_FLUSH))
 		flush_tlb_kernel_range(start, end);
 
 	return 0;
@@ -355,19 +356,21 @@ static int vmemmap_remap_split(unsigned long start, unsigned long end,
  * @reuse:	reuse address.
  * @vmemmap_pages: list to deposit vmemmap pages to be freed.  It is callers
  *		responsibility to free pages.
+ * @flags:	modifications to vmemmap_remap_walk flags
  *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_remap_free(unsigned long start, unsigned long end,
 			      unsigned long reuse,
-			      struct list_head *vmemmap_pages)
+			      struct list_head *vmemmap_pages,
+			      unsigned long flags)
 {
 	int ret;
 	struct vmemmap_remap_walk walk = {
 		.remap_pte	= vmemmap_remap_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= vmemmap_pages,
-		.flags		= 0,
+		.flags		= flags,
 	};
 	int nid = page_to_nid((struct page *)start);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
@@ -628,7 +631,8 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
 
 static int __hugetlb_vmemmap_optimize(const struct hstate *h,
 					struct page *head,
-					struct list_head *vmemmap_pages)
+					struct list_head *vmemmap_pages,
+					unsigned long flags)
 {
 	int ret = 0;
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
@@ -639,6 +643,18 @@ static int __hugetlb_vmemmap_optimize(const struct hstate *h,
 		return ret;
 
 	static_branch_inc(&hugetlb_optimize_vmemmap_key);
+	/*
+	 * Very Subtle
+	 * If VMEMMAP_REMAP_NO_TLB_FLUSH is set, TLB flushing is not performed
+	 * immediately after remapping.  As a result, subsequent accesses
+	 * and modifications to struct pages associated with the hugetlb
+	 * page could be to the OLD struct pages.  Set the vmemmap optimized
+	 * flag here so that it is copied to the new head page.  This keeps
+	 * the old and new struct pages in sync.
+	 * If there is an error during optimization, we will immediately FLUSH
+	 * the TLB and clear the flag below.
+	 */
+	SetHPageVmemmapOptimized(head);
 
 	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
 	vmemmap_reuse	= vmemmap_start;
@@ -650,11 +666,12 @@ static int __hugetlb_vmemmap_optimize(const struct hstate *h,
 	 * mapping the range to vmemmap_pages list so that they can be freed by
 	 * the caller.
 	 */
-	ret = vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, vmemmap_pages);
-	if (ret)
+	ret = vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse,
+							vmemmap_pages, flags);
+	if (ret) {
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
-	else
-		SetHPageVmemmapOptimized(head);
+		ClearHPageVmemmapOptimized(head);
+	}
 
 	return ret;
 }
@@ -673,7 +690,7 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 {
 	LIST_HEAD(vmemmap_pages);
 
-	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages);
+	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages, 0);
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
@@ -708,19 +725,24 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
-								&vmemmap_pages);
+						&vmemmap_pages,
+						VMEMMAP_REMAP_NO_TLB_FLUSH);
 
 		/*
 		 * Pages may have been accumulated, thus free what we have
 		 * and try again.
 		 */
 		if (ret == -ENOMEM) {
+			flush_tlb_all();
 			free_vmemmap_page_list(&vmemmap_pages);
 			INIT_LIST_HEAD(&vmemmap_pages);
-			__hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_pages);
+			__hugetlb_vmemmap_optimize(h, &folio->page,
+						&vmemmap_pages,
+						VMEMMAP_REMAP_NO_TLB_FLUSH);
 		}
 	}
 
+	flush_tlb_all();
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
-- 
2.41.0

