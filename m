Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4255C7D417A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjJWVIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjJWVIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:08:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69292696;
        Mon, 23 Oct 2023 14:08:11 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NKO0D3031779;
        Mon, 23 Oct 2023 21:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=qu9tQTq4rhRMVDtKiDJPwdfAQka4X5riAQrp6c66A2w=;
 b=mIz3aJg3Cdvci2jF71EI4klwLzfffTHmbkovhGIROshWfJFdICiLSkqM0QRrV1qly9JO
 395cUsSF7ivcj4Rjcy8Pbw9vhbp4Z+ZCGqyYfiOWzUK9aap3Hr4tPJtZTzEkzIl5aOJQ
 /qXmdtVI8/cqaTbuoXqBCwPkpiVZ5wK7IHtF4NN14xglScAFtz4XxSOGY+qRlOt/YRoN
 tJHMENuH8uBwYIwyX5g+xDwWkeLAfmCwrbvuZduYo+YllC9XPlEjvFXoYycQFwKJHsQ4
 bjDaeCAc/ZrqCc7wz8nGnjVeSrzaliZw0NobMkJZU5indqDo4e8YCeTVZh60NtaD7i2H /A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv6pcv2wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 21:07:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39NKoQLJ034637;
        Mon, 23 Oct 2023 21:07:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv534gpcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 21:07:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qufj56kqGovjOP1GXfYCCi1b7anZ46RstwgF5Faqf8UPsvWskyzVInnBtyoyxiBVQWeogoiwtK0d4WOtDI034HJ3lOtCa0gL/XWNy5xNillyucVAAYewuDaRLvZF23zHkVBTl4EQljwNoi/bvj5UwlcJROdw2EefCyO6jYLod/+ld74YEfQ4NZMO6AIhPoCd24oKUTNnYVPLF7us1NeF7nZAr2mrPjjuUoKtqT3Kkeebap/J5y2llWsVBzfRrybyqZlNkEt+8za4pZhblGDyefIuSWY/cbm68nvT0rkt13dNPxy+cJEzDI7yFVeOjujxAQrPlHjXtGkuK6s1YmPmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qu9tQTq4rhRMVDtKiDJPwdfAQka4X5riAQrp6c66A2w=;
 b=gUf0FVa/31pCy25XzPBiLRauBCreXw6zTIBx6xms6yYOs/cwCM+KFwj/rzuw+vNy9gJSEGZWcrfD5eZ3r0JbAVmt6BtZDCONq26K7HcEJUjgoe3C3CodVs3XINKO00KFrNG+IFd9eMQR4XBVmLqUEsFgyKilbVxdmMVjSHczoP+3kR9KXHjgAsuph3L6iETV0encwC5PqdEzf5uUiuMh68UfOVgfKpw104SbWj0bYBJAlm5Dez0o/HKE3TSZLYDmH8M5rlri1LRu+RO/vsHLDoLYiXrtEYxUAq/Vrtf9xmwrauJrktlzfustfvK7OStUhsJ5IOS9A5YhznCB52DCLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qu9tQTq4rhRMVDtKiDJPwdfAQka4X5riAQrp6c66A2w=;
 b=uWZ6dGaTqmZ4zZiY9zMSG2z5KNb3X1UCKoxRQAtUaz1Cnh9dkQr6sx+U8baWEusTJX+9/yXuCOCgyRqlK/32qX2rhr6xVkB08B9GzFK6roJVoc9lwp2ZZYYtVY5yERxj8JEZ97MbygB0iNxU0l+CjSGUNcfN3fZ2fyHH+RfWubo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 23 Oct
 2023 21:07:41 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3369:c67d:e7b6:2311]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3369:c67d:e7b6:2311%3]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 21:07:41 +0000
Date:   Mon, 23 Oct 2023 14:07:38 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <bobwxc@email.cn>
Subject: Re: [PATCH] mm: hugetlb_vmemmap: fix reference to nonexistent file
Message-ID: <20231023210738.GB29802@monkey>
References: <20231022185619.919397-1-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231022185619.919397-1-vegard.nossum@oracle.com>
X-ClientProxiedBy: MW4PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:303:16d::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: b96994f3-f8f8-4ee8-0179-08dbd40c17ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22U6Z/gJ54kQlYLXYxMw1awVCEqZLGQmJy7v1ZEiDqGqBjZuoi5yxCpi5XabWPcUVGtRpE4HVCG6aHLtaiXn7+GQaGQm7jai7n+B9pUQyXrA0Fzhjbkag26O7ZIUB2lYqo7UXO9qExSjuqhfvWTp+SAUGopfHCRfXzgKjmP80shHpEV5jrrJXgchkAo+OKOwLCKk8XLf3/llZuyhwJLIySK0We/IgXRd4sM4m+XdUTa3Y2mR0gWUNuYb9fwywAfpfVzHbiBKFCKajHPdH1cgMfm6UOvYiPGTYDfENioShusd+AqHgnXa8E2bXngZpkY+hTZGVTcMP8l2I7zRiLt/+Gij5fu1nK2yaWjBbIIt6Oz2mWBbajLWh0yoFtwR0eJaYRDoBe1xtTBTz8Y1hjP6lrIp+AKDYNk4cYaGNHTKX1s5YZJ8OEpP3jAIP0c9Nh1xTrzkDD/gLXZ7PIrnIYSwVSkptMbNc1MrYoILV4S/s1uNPtcH2kzkTiH92S5Ys3lRvyseAY1gy5a8vLgLbm9/iYdUcw5JuGLjqOdiGkpK7bb0uoerJBlGaRT/SzriG/gn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(376002)(136003)(346002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(33716001)(54906003)(478600001)(6666004)(66556008)(66946007)(6636002)(6486002)(66476007)(86362001)(2906002)(316002)(83380400001)(6512007)(33656002)(53546011)(8676002)(44832011)(4744005)(4326008)(8936002)(7416002)(41300700001)(6862004)(5660300002)(9686003)(38100700002)(6506007)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?REMwCvfpcVnK6U4CUV3u5rkHeMUSyD/6/ndcir++KhQz6vZTftuchF87TUT8?=
 =?us-ascii?Q?DxdxzHcQdXMLDcWJyODeoH9rHr3VNC9CFkMC8VTDU7PW+zRPNwU3aWUE9xyq?=
 =?us-ascii?Q?SgjI6N1SrrZWyMWO1dUvsRvNWRZrUfk0VPRWMgKUhBARReBS3epORbVQ+IBJ?=
 =?us-ascii?Q?VAutXzCva7mfXfJK0tYbnJvrxPqgWE3xyDX/Rny382X0+cE6cMgjkU9ig5Gx?=
 =?us-ascii?Q?+8df5V+9FMaIM21wJ8plXyM4mqxBP4p5jdNYGAq4aH1xraq38N7hfbQi6idl?=
 =?us-ascii?Q?yv+7qMW2OSCXlwu9krvq8lUDmQjjjIYAd7q2rMc/XXsABfv1lFO4aPdpRdbT?=
 =?us-ascii?Q?u/jx++cq509rNmidzfQyq0cnzZbLdUyxAzA6S7tTSJU2StwgT/8UD5sifZVR?=
 =?us-ascii?Q?BQRGjHKgGAcPw2QNrd2uSBeRe/fVpQeDyi5aSzbjB4h8Fkd1sY5Vtp/Ac7RN?=
 =?us-ascii?Q?RX1Zo/c+2QFrLMHjtbLkLth3OD71nxyqXaT3PYqqSwvAfiuidPMMXLU+rZ6R?=
 =?us-ascii?Q?bFCDJMavHRqn/Yj7GoGE/slU1OHbonHyRpa4R68RjR/lCzJof84uXYPIvyXu?=
 =?us-ascii?Q?7En3xJ13SL6+1c84scGQwmnlXsUiXXxdtQH0WQv85ZdlHRyDgcKUZ9QsZedL?=
 =?us-ascii?Q?VI3kfPU6ys7Rl4tvwxn0e7Wdc+E6z+BnzjqEGak60UuN1FF2Ux5d9ZIzrPDS?=
 =?us-ascii?Q?JBZrkAcWjTIChnArhoc4ZsNJipZO3xo5Sed2IuvCi94+L2K5r/poohKc2oEb?=
 =?us-ascii?Q?vykSgYq783G+hV8r58oZemomT0QVdiEmEplJuMVY5m+BL7Wdw+3rupZDeDV2?=
 =?us-ascii?Q?KQIrgqRYDM7Kq6q2MFQtgFgu1r5PnlULL51O1/TroErEVyZEMrLBjnG1Y1SI?=
 =?us-ascii?Q?o9hHSUZA4CAr5pAPLjzu0TvoNUzCx5ekfPmwhleLJwjpKeNSn5Wg2l616tpu?=
 =?us-ascii?Q?H+OEcg1oa1D1Vk3Kj+axxcrOqJyPcrD9oj0bof9KuMMdbe4sgdurLhz/HWcv?=
 =?us-ascii?Q?H9ebzf7rHkUudCeGC5ACL50OlUpSXHwNKdb5mbfQq6X1cxaNUYfXoNz8wEZs?=
 =?us-ascii?Q?otSk7kvqiJZcj2c1B3HXxX/UneON9qBWDA2zNgWM+1abcLykSer3rWo9wW2b?=
 =?us-ascii?Q?NZgVrzIzO/C4tFYfM/8yxj9nrQVoPo/3gSRTsUwocCmN4s1qK/2gydeLDE+T?=
 =?us-ascii?Q?Ub+7/sRy4F2Oli3D4Rhd1sWiMZrRIIMZqEl2isAxMcXhDAkkcnTH/6t6BM6u?=
 =?us-ascii?Q?rrHzpwk4LXKYGOvYu+fOvK8XQ+I5dX/FjqG7TT0K2APZ9cm9MuGnlkKbfPu5?=
 =?us-ascii?Q?43CC8vQVcRMgvnqWohFvHvhwe2S7UTRy/HgdFnnHHYWCgrZNPzThG46neBkv?=
 =?us-ascii?Q?GsdS9DgV6/A2kuyoaWu4gkbGURif2PtWlg4layKvBRdyo6Z7ztxD7aBnajHq?=
 =?us-ascii?Q?OT4uykqfn8bbfFW4dyn6EPemlMzi4vorx8i1W9UBcicB0TdUzD9NfvSb/C1n?=
 =?us-ascii?Q?frgTYtgUIu+CwuIVFtOli3fo9tmUqdx3K+0TXWlaqd2yrLa+AV5C0lJvEJ3D?=
 =?us-ascii?Q?6mkwpEL+HEyDKDVqxS2PtspCqKowFugVXbBT7nRU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9hrITmgtD9q8ZJwomN2RJlZ6Z6pYt75t1CXH6bjg10Qw8Hb6Ol7iKt/c6Azr?=
 =?us-ascii?Q?tcbZv3pohwQY0/9bzYVgoQR3NPbTFcRewTxbVAbGm4iLwhpxtB6CFnLtfIut?=
 =?us-ascii?Q?Oq6v8sF14+n5XRy693n2Ymf4j67t8Ox9E2XRlliZEQyD1aBnsaPla6jv/G3C?=
 =?us-ascii?Q?SGEVW+FkwetIgk7JFH/dKRD4WSxzj7+mESL7ZZzBMsIagfvRSo57ZB6Ln1lX?=
 =?us-ascii?Q?O+BqU4keJhpIPCOSDeER2WI5E2R8E/e5v2NpUBqZEktQV7/32YC6w32+ovnf?=
 =?us-ascii?Q?EM/G5VoTrLGwvACqKw6YKaflG5RYpwPmQE4mQKGNyLiI/akrAlcWKuwXP4iY?=
 =?us-ascii?Q?FJSquUNh8+5lUE2vbTZtveRUD/zDcfKIDIxWOB4P1yZsbbCRFUI9eR4HeFDa?=
 =?us-ascii?Q?EQ76YjWQffFVYYQ2QFuvqWAG+NYtTVp4vQDiL6C6vXfu00JStSWDzWvmRF/O?=
 =?us-ascii?Q?34byKzDVnlcQEmHWDomPtI/rwH5LQ9ouuCvBpnXMM3ozuMgMnk7p3UkP+J2t?=
 =?us-ascii?Q?bVCoazYMjHAS52g/pxZwxJumN+o/Q/v4JEjnyaw9GAPmCy80rY+yfQHzSrKG?=
 =?us-ascii?Q?qnwBFWDvUaTzCN1nwlx2iZHVgVciJ3rrQrllsgZz1vP8KgK9vtbXGhFpqir6?=
 =?us-ascii?Q?kx7IOgDybfkjgLBCwquFaP7hl/psRVuIPciHUFu9yVm1IJrfgnocsuiOd7qj?=
 =?us-ascii?Q?B+mddVXrOwiCoqvGk9OLKdKrKpXOAgPEaOK52uhdu2DSha3rHIfV96RfNSba?=
 =?us-ascii?Q?AvG4bw7gojIaLnRGl6769g/0fe+RtAvzRF50+hwEtX7+ZtEy8cj3LmAVeqA7?=
 =?us-ascii?Q?+qIIG2fZ0h8vvbzHixgFLtb+wYXeAJyvhnXQKLBu46tuS8xuX8J84WDMjWQc?=
 =?us-ascii?Q?MnlLViCK1k0I/TBMYevdLX6pQTELGSBY8vpypY8ZUIhHg/n25hOyseo3Z5mI?=
 =?us-ascii?Q?8ixslLFotTyaTBCGrRPRFIIXlXDUlwqrufmcBfORYnnDS+8O0y5hGD95zNPe?=
 =?us-ascii?Q?sx23YG5F4oF9rscgudI10U2KBQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96994f3-f8f8-4ee8-0179-08dbd40c17ee
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 21:07:41.1373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqfGo+a7cWsFEVJGMVNdbTxrUddwy0iqSyZXQ0tG29PuLUyKzNx7h55/qUOH+pO14bpCA8nEzJZ9oyUD19t8zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_20,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230185
X-Proofpoint-GUID: DUjQqyOgxgwnOb74NS-fsPxlnBi0fsuJ
X-Proofpoint-ORIG-GUID: DUjQqyOgxgwnOb74NS-fsPxlnBi0fsuJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/23 20:56, Vegard Nossum wrote:
> The directory this file is in was renamed but the reference didn't
> get updated. Fix it.
> 
> Fixes: ee65728e103b ("docs: rename Documentation/vm to Documentation/mm")
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Wu XiangCheng <bobwxc@email.cn>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  mm/hugetlb_vmemmap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks!

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
