Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE79178CED8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240934AbjH2Vis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240054AbjH2ViO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:38:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DF0122
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:38:10 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TIiemb031375;
        Tue, 29 Aug 2023 21:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=FIBN6YhPsvUwRzPH0L9SXh5tL8FY8pkar6teks6b5sk=;
 b=jIhRhp7kqKCa61Q+qvvomc3+cKf8QuLqZihpEIATmZhu9y1bpgSAGemIx22PoKwH648t
 mZIaWssvoIO6bnXVPGDxZ6vBz+cFQsOU4NmwtFrV8alFrMc8l9EJXxh8zKYOCwDghm9x
 7Admbpcxp8oMJyZryCEVNsmCHXEHyTnR+5BZUM3G7VLtOL84kOicMU6nl1awabx0qB/D
 GNgMjz9ahekrDdN4nvNWcj9Pi2DFO0ltPARJTVOzgD9Uxxr/X8E92gkqfnlw/1zOMNeo
 4ijpTPJF67HuPZKs0JGhlDdtpA5fjq6xkYNkeGHUU6pX8p0N06siZpBrb9ml6+6Jl14d nQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gcp149-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 21:37:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37TKWW9K014286;
        Tue, 29 Aug 2023 21:37:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6hnps93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 21:37:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNsXUfAXj0/Vd0Etjhyymk530NdTFHd7+OR/NT3IvRVX3YgXh0XphF351bYes3RnN4Hy+FVXGmd0EEhLZfvRs+5Li9ZL1X+c9AvkxRlRk6x8inqPJsXZgrj8DujG9azrdmTiamXTUVY/Q7cck++Ra7fxUKym3Hf/5igYZ1sxlM/CYjchJ6iQCu2Z0IBpYYuF1EGRH0PLlyMKKMMCqBvQDOtN/8ZZEulHzq7Jur1v3dXuRnCE7wcQlMm26Hrv3HI1S+RpzFK2hX//MgA45CWisaIYC7e4UrO/M5AN0MXhzqf736ZzA/ZF0nWoeLgZ5bX42RJxLCoHcu/Ry6IxEQL/4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIBN6YhPsvUwRzPH0L9SXh5tL8FY8pkar6teks6b5sk=;
 b=Wpcj+koXyNXyx0a6OzUdv+xosxuyG6p4dcdPnMmVunoQyn5OZrpuX9zbfTIur+BTaLKo7yLBVkre6rEUoILjbuUUlzzFQqDxMo/FNz5/ZsfeNK/nVu0GH9DQwlGWndaif4/xlvwRtcIk/l10hVNCLRMyuqB1aeBKlFU/hMxFBn7i18X0NpdPll6Y70VaYNyYeeAsAJbBVNg9hSwnbNciOxSTYgtG1dn0l0s/DjAK1kttv7YK92R8pQa3GioOKpq9BV1GsFa973RzVD2P3QVIU0AkzWW8J+YUXEA1ertCzk06KtWjrPRwtoONukgrZ8ZvnC4+JK6SpmdlZUS57v32MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIBN6YhPsvUwRzPH0L9SXh5tL8FY8pkar6teks6b5sk=;
 b=qf+NAwkioOmWl0B7cUJPH7DiqBDD3m+SeE6Pk5YZ688gyf9lR80xxLMXMK+9S2Mtj62k4r0eRfY6prWHXsyfRpk1E1jZEGKt+zkUiONCu7E8t7dA4+9bWmd3mf6svF9gpGY9BPZAruxZawC3pa2eNyInlTEnyk5BOOeqVNOgz2w=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW6PR10MB7640.namprd10.prod.outlook.com (2603:10b6:303:245::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Tue, 29 Aug
 2023 21:37:39 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937%7]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 21:37:39 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Usama Arif <usama.arif@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        James Houghton <jthoughton@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] hugetlb: set hugetlb page flag before optimizing vmemmap
Date:   Tue, 29 Aug 2023 14:37:34 -0700
Message-ID: <20230829213734.69673-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:303:8c::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW6PR10MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: f70240da-6e31-4ceb-68de-08dba8d82af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e2c60XIzweOSz/O7KweT1ZTcNWCMLDESghDCeexWo7+SJSRkDBYSUmGr3cnPGe+6oYx2q242DKZlM+oN/ovZa8Odu9PyskvGd7Y5XIacTeR35EOHzfC7OTCfxuXpij2r8ZyzgMNp/87ONuROusUO+wjgsbVMB2ce5BP0cY947nAyM6n05RclO5XMwhrDPgodKGTGk49FoZZDZfNVVjsTrf4+qgm1v0SKt1NdmdBR0z6DwlPH0m5BUiuO+Mpir7GMj/rjyFBHuSzPwk4ysFwZCwvFR0UxZh9tpsAsOZwKYJ5FR0zGK9yK4tuYRQ9fDKVp93nbTwQ2jqsTwVCPhPLEhufRfMN/sRgMdbgAgkxm9VNX+4ucg0Qmu6I9Gu43eGvFBB1xD5Pk7PtRefZ85MgpBxoe/08r58Ojud8Sn0CzsoVyeho+fUmVrfypPwVjD9pKBJnr0AnbesIUKk+5CieiQIj7QmoQKYM86ZIowKKfphex1DRd+KbqsQoLHGp2haraWP/u+zZ0WS7E18qy39D6vkiG7e47Y6JeJiKeQg5wG45NgLSRewh6jVOYpW/hk3My
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(1800799009)(186009)(451199024)(6666004)(6512007)(6486002)(6506007)(83380400001)(26005)(2906002)(1076003)(478600001)(107886003)(316002)(41300700001)(54906003)(4326008)(66556008)(66476007)(66946007)(5660300002)(8936002)(44832011)(8676002)(36756003)(86362001)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ssFO1zVbx5s/Mi++bSzlV2o/WXIrhPJXh0PPXjetclNukdB12IR6NIIcP/4o?=
 =?us-ascii?Q?d15InPU2k1Y4fM0BNulCaxEixJCV2QygxHmMhlo/XD9udQIG7++oWMw5VwbA?=
 =?us-ascii?Q?4WsgJ0aEZVVkWKpNRVYUrqhCVbHnYWcsWTIlJdC3k5NJf9JEq7KsbMZDaANO?=
 =?us-ascii?Q?92Z5JqNf+589coMc/xInvcW516hjhYh9PLZE67SQGJGHBZtsgKhywZuUMCd0?=
 =?us-ascii?Q?n+fV0oP01r1LUcWF+v+ERlxGcwn5jAhHNEVQneYRdZMZIHSUH8r/5lCmc8Om?=
 =?us-ascii?Q?YISBvgEltcfHH37IOuWDTenOKEty9kGvm/ue9x2x4IGEYhkhEyyXKf3bHvTL?=
 =?us-ascii?Q?a4UTEsuSHXUHI4eLJgNEM9hOtDRfAn8D383MwbdqAasTzk+GTajZQg5QoJ7P?=
 =?us-ascii?Q?rEwLseTmLrqaONA5PQQhxwgW7yxfcJ5MZi7pOqiWUCZQVFx/FbyyGWubYmbN?=
 =?us-ascii?Q?HbHCIGaVgHJrhbhwSrkwDglbVroCyeGVGOSL7K2JR9fbiOTegT7ZxjAzhHQk?=
 =?us-ascii?Q?5lvQ+MW+A3z+BAZT6nSBFJv1LiFILQbngggFPgcgj/2TBeGoGrRrbHg8PeEz?=
 =?us-ascii?Q?8FXxFP/Yw8mBqNZWScJ/0eT0nM7KqpIeha23zi/3NvCseEXrmT+FOhJTHqyS?=
 =?us-ascii?Q?8gxP47uZSHKOHXnV+VA/1JQSbJnl3kwRabFNOVzGVlJxJn2vUibDZrXCrtZU?=
 =?us-ascii?Q?JsQBhv7YU0OnqtpawJnA2DORp5o3lcIdORLTQNwpWlLl6jVeDM68d1X5FLJe?=
 =?us-ascii?Q?irAAQ4FYoONEEdOIEtCnnumPp4kKJU3/qvaexYWANH3zFwn+ZuSa4AjxuSY6?=
 =?us-ascii?Q?eL2W4zqrCAyFdN4lpJf1omtvJIP2ImJZVOVJUhkhwRAq4nWxWHyGSw/7DQMw?=
 =?us-ascii?Q?jUEBZf54Dr9uZ7+YWyknADBwtAqVRPdrs03/JKmLTYrKEcxibizV81Ugyhvr?=
 =?us-ascii?Q?NH268WSFubihrDBCqFz8RgNru7AWt5xhMPb36O14ZYrCLf1KuzvJZ1X7f5hs?=
 =?us-ascii?Q?krtnOenfoNliTaaoVieZ8cyeOFDQ07l/GFCssSyJFWq6GCF5IKNk93gpDBzQ?=
 =?us-ascii?Q?H7zq3HZOQQ3RPjNl46OgAEcXSG6yjaHIvk8ReNrItWvu8+C4RlhsrtJ0wO/V?=
 =?us-ascii?Q?SRzyA2x9p74FWzkxjxCcNhZPIz5Dnm+sitVTgooD9EUD6IdNpzhpgmli12hi?=
 =?us-ascii?Q?0p0spkcNwW81ydP/FCXRqvH9ad6kussPBy8TlWLkawsNPW9maU5djrSKAVpL?=
 =?us-ascii?Q?SXP9ZOth7jwcQVBosJJwp8TlSIU6lJ7q5VACUw1pznY+X7AzsHkRyJtlp/hE?=
 =?us-ascii?Q?N/r66dkvOHBlLnw/6dC7Ld7rrC4xt3qLf1s4w1N7ZkVc14+LI9B0Z4Lgijx1?=
 =?us-ascii?Q?+gETJBOgqHK0gw5P86GwSs56ApYnL6gBgF7a4+egEMTJuh4F7et7QAEvTvj5?=
 =?us-ascii?Q?XRwZyepcBJ9u4AXJAyS/7OTcVfZQBeXfatkld8mgK+xvMEZRlvgfQNqxntr2?=
 =?us-ascii?Q?JMHR3SEIGjzOjFoUrpwie+nTaxTwFwTBPC+ATr4WcvMvC6+4Oc2snBGxFzM4?=
 =?us-ascii?Q?YXSFm49YZif/5AsNj0NbhFRzM7ZzZEqGl0ls1Rki?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nf/xLUhqHLlQ8cU5BB0LPGRomntctJTTMBqgV4rQIaXOx1Fed+7qcei8sdrQ?=
 =?us-ascii?Q?QvguF4/iJcTAsp/PWfNuS0WzsFFXWN3j2I7+PJymx+zpXz1grvUn6nSDe94E?=
 =?us-ascii?Q?PDH8LHeBKmSDLoxM0bY5cnrFCM7Z7p8zDHUmYTxBJNrxQ+b+aFXzIsy4RglK?=
 =?us-ascii?Q?4/RQsIzyeiZmm8rDrvsLA5HJ7wqjsDOJHKHW01gmgfiWj7iZ0tGwx4txEW8j?=
 =?us-ascii?Q?kPqB+hYzyysbA0SM73YKDY0kV41ZD4xuv+u6XT5wrdTd9vm7w3NCYFZGJZfl?=
 =?us-ascii?Q?v73x5U3+c3ICynA6sHoWr5DozN5CCNmSq0Pdb1cO1bOrh5uWpTikx67IHpgd?=
 =?us-ascii?Q?/4hy/wxv2EIqHVuvdoABZ3YVDlb4/iUigIhQr9ahO9bAAEoVUiSVZBCMweAR?=
 =?us-ascii?Q?2JGvrKih7SOAA1Fwud8YwQpTroiaw99faYYA+o8ywnU/rqDAe1rGsdRHmsOj?=
 =?us-ascii?Q?qXFoKUzDy+nvxsufbFGY1U0uiRYSuOGXFnV1FCVdR7nVAc4sZ1nNOzRQMHIx?=
 =?us-ascii?Q?im+UHWyAA4hfkZ5xchqQv2fB10NUGRAZsCk8+MAvOWFVT171fZgD4Hla1+Ft?=
 =?us-ascii?Q?U97yd/vdjo3WXmPT3B/31IsFgfADlqZDXF/Kj1mu9pC8iV5/bxn1v/ZLr4AM?=
 =?us-ascii?Q?5Y/3qd8uqK3jm1FmEuTn49JZTDGbTdNdZ1AjD70PjmVISmyoMyxKdyhSSZSR?=
 =?us-ascii?Q?YSj3XG/dsFEhpYq2tDq7fYPKuMsmDYlpSyVzy3BiF4qqS26C3g8WcsAdVH9q?=
 =?us-ascii?Q?LCpXkZkZi3dxT0GBDMlEfwYDnDch7GfDQScWceCzgUZ+8I9LP/mk92g/a9E3?=
 =?us-ascii?Q?lXK0VISq10o9zY80DZw7bixO9avZoSfBytKP7q1ZEn7AsH5j1fcjA8luG4rb?=
 =?us-ascii?Q?WsggqWDRrmyd+D2Qgmg3kzjzturuDrbkBH/bAahb+aYgcpaRwVvL+uasubmL?=
 =?us-ascii?Q?BEedRISlER+WV/Y9jkl5tB57BkCSCwRROtaFcDWzu3g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70240da-6e31-4ceb-68de-08dba8d82af8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 21:37:39.2575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNEoO16+TnVyKZvbsEfylSgEGCqiAbCHbCRuXXhDKFdtW1pDgFqL+f9CUEcH0PKTYXCKtTR0h8DVa+BsEKX7PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_15,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290186
X-Proofpoint-ORIG-GUID: Po97OXFQ295PCcXRWY215wcGsbgK0sRP
X-Proofpoint-GUID: Po97OXFQ295PCcXRWY215wcGsbgK0sRP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, vmemmap optimization of hugetlb pages is performed before the
hugetlb flag (previously hugetlb destructor) is set identifying it as a
hugetlb folio.  This means there is a window of time where an ordinary
folio does not have all associated vmemmap present.  The core mm only
expects vmemmap to be potentially optimized for hugetlb  and device dax.
This can cause problems in code such as memory error handling that may
want to write to tail struct pages.

There is only one call to perform hugetlb vmemmap optimization today.
To fix this issue, simply set the hugetlb flag before that call.

There was a similar issue in the free hugetlb path that was previously
addressed.  The two routines that optimize or restore hugetlb vmemmap
should only be passed hugetlb folios/pages.  To catch any callers not
following this rule, add VM_WARN_ON calls to the routines.  In the
hugetlb free code paths, some calls could be made to restore vmemmap
after clearing the hugetlb flag.  This was 'safe' as in these cases
vmemmap was already present and the call was a NOOP.  However, for
consistency these calls where eliminated so that we can add the
VM_WARN_ON checks.

Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with each HugeTLB page")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c         | 31 ++++++++++++++++++++++---------
 mm/hugetlb_vmemmap.c |  3 +++
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ba6d39b71cb1..c32ca241df4b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1720,7 +1720,12 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
 		return;
 
-	if (hugetlb_vmemmap_restore(h, &folio->page)) {
+	/*
+	 * If folio is not vmemmap optimized (!clear_dtor), then the folio
+	 * is no longer identified as a hugetlb page.  hugetlb_vmemmap_restore
+	 * can only be passed hugetlb pages and will BUG otherwise.
+	 */
+	if (clear_dtor && hugetlb_vmemmap_restore(h, &folio->page)) {
 		spin_lock_irq(&hugetlb_lock);
 		/*
 		 * If we cannot allocate vmemmap pages, just refuse to free the
@@ -1930,9 +1935,9 @@ static void __prep_account_new_huge_page(struct hstate *h, int nid)
 
 static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
+	folio_set_hugetlb(folio);
 	hugetlb_vmemmap_optimize(h, &folio->page);
 	INIT_LIST_HEAD(&folio->lru);
-	folio_set_hugetlb(folio);
 	hugetlb_set_folio_subpool(folio, NULL);
 	set_hugetlb_cgroup(folio, NULL);
 	set_hugetlb_cgroup_rsvd(folio, NULL);
@@ -3580,13 +3585,21 @@ static int demote_free_hugetlb_folio(struct hstate *h, struct folio *folio)
 	remove_hugetlb_folio_for_demote(h, folio, false);
 	spin_unlock_irq(&hugetlb_lock);
 
-	rc = hugetlb_vmemmap_restore(h, &folio->page);
-	if (rc) {
-		/* Allocation of vmemmmap failed, we can not demote folio */
-		spin_lock_irq(&hugetlb_lock);
-		folio_ref_unfreeze(folio, 1);
-		add_hugetlb_folio(h, folio, false);
-		return rc;
+	/*
+	 * If vmemmap already existed for folio, the remove routine above would
+	 * have cleared the hugetlb folio flag.  Hence the folio is technically
+	 * no longer a hugetlb folio.  hugetlb_vmemmap_restore can only be
+	 * passed hugetlb folios and will BUG otherwise.
+	 */
+	if (folio_test_hugetlb(folio)) {
+		rc = hugetlb_vmemmap_restore(h, &folio->page);
+		if (rc) {
+			/* Allocation of vmemmmap failed, we can not demote folio */
+			spin_lock_irq(&hugetlb_lock);
+			folio_ref_unfreeze(folio, 1);
+			add_hugetlb_folio(h, folio, false);
+			return rc;
+		}
 	}
 
 	/*
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4b9734777f69..aeb7dd889eee 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -13,6 +13,7 @@
 #include <linux/pgtable.h>
 #include <linux/moduleparam.h>
 #include <linux/bootmem_info.h>
+#include <linux/mmdebug.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "hugetlb_vmemmap.h"
@@ -456,6 +457,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
 	unsigned long vmemmap_reuse;
 
+	VM_WARN_ON_ONCE(!PageHuge(head));
 	if (!HPageVmemmapOptimized(head))
 		return 0;
 
@@ -550,6 +552,7 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
 	unsigned long vmemmap_reuse;
 
+	VM_WARN_ON_ONCE(!PageHuge(head));
 	if (!vmemmap_should_optimize(h, head))
 		return;
 
-- 
2.41.0

