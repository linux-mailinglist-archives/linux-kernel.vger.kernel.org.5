Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD3480F77D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjLLUHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjLLUHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:07:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F49D2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:07:28 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCJqHaY020819;
        Tue, 12 Dec 2023 20:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=Q/GRL87qaxDhpWDR1hpoZLWYAvUXZS+0s0HKcBxUoHE=;
 b=B54YbnKrUJpo11EaBK6vmr5i9CgN/1V89+NaBFOmyIC/yYxz5jfpIi6SvYNo5lBXFaIh
 N2QpQlr0JnsxejmEAa8ZHGhVwrntAsat5cSRugCn43MGkanFvIuJU4Nv7tWNiaMhB/oM
 1TWZhuBiA/ZHZlegiZuU7mEJSru6Dwq/VvsJsfzH3JpdIgdOyNv1mRa84EURlsb8/qSA
 dKG+WKyCf3reeZq/K0UoEzbc9QUIYnvuypfoTFRifG9gLaZcpshhELLBvadWaieIjBjp
 a9MReHu5fhPqL/QkF9BII6bKxBFYI8v5zjPQ1ceQ5GjxhWYBV/gs8VzRgdYeAMj25a11 /g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvf5c6mb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 20:06:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCIXrv1012969;
        Tue, 12 Dec 2023 20:06:57 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepdcr9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 20:06:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjXAqQpgkU8V3jm0mEq+wft3V14bi2avqtIdiRARZLo+mke1Cp6DNdg7IZC8gsNiQhG8EIFUuimO2zXdfBukvkJ2n/LByELOSk8PvTKxt7KBlSsymXfjlgdoGsoZvw1DOtuuACrRigkqJVmaUl6cNZsPl/7g6UrhIIEZS0/smj+mFbCURf9hNYdTtkvR+ljufuiXrHHCEWa67LkJNlt0C7ErUJL9n/CTih/jwp/V41keAmFC5cH2BRFAU4ejrWlRyhimS/BwEm9Z4ORfgYyvhBOhl97ZuL38/iutKIWn6ZtjCiE9qN0fIZ+0gxcQeGUYlBPUkTXLdMMMJgK+zKBy7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/GRL87qaxDhpWDR1hpoZLWYAvUXZS+0s0HKcBxUoHE=;
 b=X4ZBNWqNnUAYKbiit2HjTtUOOjx9hGsVAP8wYoPCoePE6yUHslFl9r1xJpsOjREfxFqeZTUFIP148wcM/K/pl/jfAsIdKWksjOo0j1VweOxIFyQ+WV/+ZVj9OpjWbliwCoLJCfH6/DGMG2CN103nBq1o8WBQ9Tre53IaLKq+96iIV8KSLMybCbTZf7rGHveAHs/IXid/sKJjnzJ9izvKM+cpX2twrSppNr5DByUPmsjB1EAJn+zaIhFbjSEyFNTsxo1NcgPU45sQABqqmaawWnxdOFlMrZSEhjYgLawaCw7UWfNtrt5Pn9FOn1zUfTLhN6MVb7wn/12Jac5BPrA8Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/GRL87qaxDhpWDR1hpoZLWYAvUXZS+0s0HKcBxUoHE=;
 b=Ls06n6AxfCiEPq5XbtZMccgWqcFP9/ZUhyZ5HYnW1DGx/bmfiJvR7Fh4caApvuuOejqf/0V6CzOTojtND9B6F+TCgMeFrsbTfw6cFa2Z6Idtig/qoj4iwgzkU4FiyMvi/i965P9Jhid9IrfLVhUWmZX8Cs8taUIWqQ/kq5q6nsc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB7126.namprd10.prod.outlook.com (2603:10b6:8:dc::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Tue, 12 Dec 2023 20:06:55 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 20:06:55 +0000
Date:   Tue, 12 Dec 2023 12:06:53 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Gang Li <gang.li@linux.dev>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ligang.bdlg@bytedance.com
Subject: Re: [RFC PATCH v2 0/5] hugetlb: parallelize hugetlb page init on boot
Message-ID: <20231212200653.GA7043@monkey>
References: <20231208025240.4744-1-gang.li@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208025240.4744-1-gang.li@linux.dev>
X-ClientProxiedBy: MW4PR04CA0132.namprd04.prod.outlook.com
 (2603:10b6:303:84::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS0PR10MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d87eb4e-039f-4e24-87ee-08dbfb4de3a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uHw93qYnBfDbxKwdxQRZ4VO58BgG4DF3wK95zaE9Q15WDSmXhataYoPM0Z4+Iicphg/HzKDNGEHVOMvuYv5BchcRSFjNrh1wjnqiRElBDjB96f4jDi9X28HoY5+RdgmKqTIuCcudcbgdDWUDD+fbVou0BjvpsPvoEM10YRACPe/aG9ED6cJxXiuYLw5ufIz5n7SU8ptM8aeP1v1hK3LGeUblRTMJpzwvNNM5uRYWCOfh7LUJtY74DUa0Hdi8LeHDoHGdP8HypuShm10ybbpievXXdRDHZ1J5Oh7FePhFYXUc99rD5cmE9OLeqtrHeHjCTQUVb44jxynsAm2ppCQyvvYR5BdfZXLrxrTB2fI4RDr1HMSX8CVlyipPMqg5/zbrEGq+UywbFkGPHmPxDtBEbSIV8SeFUR8skSlwyf+lsLS545vMO0JK0Ttk1auRaymF9UWkJxxMR5xnHeU0Lt0AmRB0r+MkPbeYJz1KmcMf5N1wRudu9G0FUIWlEAspPlRz8PToB+tdmcRtNzmywCslbAIDMMW8FpndRbxDIslBm89Y31Ppze/LJdXF+17+WZjJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(66899024)(33716001)(41300700001)(1076003)(26005)(83380400001)(33656002)(38100700002)(5660300002)(8676002)(316002)(8936002)(4326008)(2906002)(86362001)(6512007)(6506007)(53546011)(9686003)(44832011)(66476007)(54906003)(6916009)(66556008)(66946007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XV7OkaXe8lewr0JWo4EozahHD+0ZSLbo2TKipbfQikHQorJHVUfdYK1H5aq6?=
 =?us-ascii?Q?qL7u+FkJUF5h5vTLYGclt/fMXcta9pgZMw75s6sGiPF6GEK0d6/3GEF96Wp3?=
 =?us-ascii?Q?XyBt5TKkwLcYPRiCXq0udkABG9rBRSlGLniRjHbjayVdGyeRnPiEZ34cjIDy?=
 =?us-ascii?Q?5UZNrAgWBrkPZifeQZv69YaJL7uoYXpUiDwkzPgL/EcF8KhbpcXHKiesPdaX?=
 =?us-ascii?Q?UStyLMcKGaXhYvaS5EipnNB3/I29YOIfofnJ2JB6VHHR9T9J3PDIO+ogekiT?=
 =?us-ascii?Q?EVkaB9RB9tVWoYO603/vnYKRQDNfGYA61qztiM6i+ldFkN7FrVlGE2beBrHS?=
 =?us-ascii?Q?Ar6hetH45CNQJl6kS2FCVTaQ+8LdGyd11KPDDSVvGa4nl/TxXFf/M9G+BPiP?=
 =?us-ascii?Q?qxpbeJdWYxK7HQixlwdTye5QHM49q7oBZV488N/8iWStG+g1dpa0dXj9phkB?=
 =?us-ascii?Q?gTdar4oJXglRrIX7i1SwUhPR2yv7r0L3AJKzbPndecOZznsvkZSa0LubElDL?=
 =?us-ascii?Q?9ahCRLtlYOKWWw9uX17sgMSRLdR5tK2X3dR28FzPdHpvI87W4q9u6ok0Gu9M?=
 =?us-ascii?Q?pBP6qd6ImLsiYqzS7lT8iAU/N+py77eRH0b6RKA6x7f83gpOFKKuhvch7fgs?=
 =?us-ascii?Q?eaGIaL76i4HAxYa/mBGZ0gQfOa3esKrDUpmOAFMWkuQEJJfeESOl/uc/2x60?=
 =?us-ascii?Q?jAjNQhLEILKnrl7M+TY8R7j1aQOvKlB7lhIZKy9HE7ntQYdma2w0GBDN8IhM?=
 =?us-ascii?Q?7j1knJufswSOU5M7uUcDJMldmVGjz8uH7TEFZM5o8j22fIthYUKgmfKPJob6?=
 =?us-ascii?Q?cUF9gutjWKN/f/tN4ANUVW05njmX0of8PMvK1mwiEi5a51M7UbCumEwaxAYF?=
 =?us-ascii?Q?bA7c0EJ66LgY9kbYZvnWCslZ+g2sXjTxU8ejtTJHaVVZ/YQIkvML1eta/uNd?=
 =?us-ascii?Q?7OCRCvO3G/OAf7p3Q3G6pM6PJtHOoecOIsZ13vorFLG6WGbmhWm3c6EQm/9P?=
 =?us-ascii?Q?NYc6dcElILqsKbxw2OvqvPW+ZLDsT0xAD3UVbJtQsfUHoRFX/dKUjTbsIJSq?=
 =?us-ascii?Q?CVqy9fQr+c2oxkpGQEsErj5H/kjpiiplnTy9xgbtJy8Y4EZLiYJsuo8X+tPe?=
 =?us-ascii?Q?OyahaxzEZuzhr5vidPiO58OVqPQnMmfauyaPSDunEaQ/bWaHoptkB7y4J30X?=
 =?us-ascii?Q?7TecM4qFrPmQvnmlIHAclP+J71tn4eL+jyiiTCA8StGm4/1gJaZLxG38SSn5?=
 =?us-ascii?Q?nniIElCrJRBiSF6jpkpU68kdr5/xNWHAfUfceiFE/+HO37afRuBv+C3Cqsd/?=
 =?us-ascii?Q?YibXNMxUVsadHV053nhPmyF4eLJv/G+nYNWePxHT3UDdNtcIDp0V1awKzaSH?=
 =?us-ascii?Q?VhsYrhScZTaHPOodxwp4eOMqsgwpvWx14bmWsUBspJRKd1BH59VtqlrnGKLr?=
 =?us-ascii?Q?zdG+MALvFesDPKPUb1J/aHcDubTtCEJJTBJkgNTGpJg1/nsn1jgQ3nBbWY8V?=
 =?us-ascii?Q?+kJc8yj7UoliRbVuuCD+UfpUzPHZDsn+KAfWFOkkkLeouo53fhhL24D8dNiy?=
 =?us-ascii?Q?AvaSJRdpFIqfIHSfwGApNC9vpSaR3A7GmIGgooFL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lYgMwTFd/CXd0MTuT8NbYXkTy80L+ecGMZ1Y1R7yVAjeno5kAm6bcctktjqn?=
 =?us-ascii?Q?c/yMvuADF2GthIYoyWurErLAxkumcbxZ6f9wwiO26PRxg2e8Klt69c08mrqf?=
 =?us-ascii?Q?6Cywsd0FFLeadODyO9Pq4ONMlpbY8MQT0DVcJqHAGeAhapYHM6bX+gfLtiZr?=
 =?us-ascii?Q?NHpqQBRiTlla2C33NVLSodB0KhKxnjT8nwfykgv0ebXHtL672T0pIG3+2kSx?=
 =?us-ascii?Q?+cwglA0xTj9OALkbBmLVNzSQ/GaFedUo6VG3HWoUnfXp5mWQ8hTJrpQ1Bf2l?=
 =?us-ascii?Q?jTgchiLWLyhbbJA86GYLuyxIBCWi7S3UXdN2/FXp0yIbgB5PyeH3CCN7flvs?=
 =?us-ascii?Q?zrnjAfsWUwuIbFz3fPyG7Kfw5LLiJVoWdSCB+jCXaDqE5qcKaLIHZB9Hib2n?=
 =?us-ascii?Q?uIZq48IBy6Ko0dCYK8T4P//idRqJf69gvJUcLcxfl/wFtTPbaqbFRDuS8ZnS?=
 =?us-ascii?Q?4YvT3ZG57AEc5Bz2ea+1Ev/XAYyCQ4kGUgpjMI0ZwzYyk0BWUjYt6jLxnz6r?=
 =?us-ascii?Q?bavPljUTEdjkuBNxZ1lltrO/Orz2vFcpHzWz8gjfuCTsIr/td0H/04qUo8vn?=
 =?us-ascii?Q?w7vJGxRSPaH22TgbDrH9l6ICGvufbGbZhgx2WGmSXTsqr8NwY7q1whh16X55?=
 =?us-ascii?Q?/7nef+FeIR0VSJ824MJMG2U3oI/Ugtpf9rHm48rbDMWozmjS4x0lvncp2yHf?=
 =?us-ascii?Q?RcQVUt4fsFsoRdCxaMfM3ODzvAvnmsIDWsIFCa0xlFLEVXgsqhNFe+t66OjR?=
 =?us-ascii?Q?OpU32vrR8+c24D23Kxw8vHHylKPaTrrev9Eg4gWMqYCvY17/yw9cufUR8FpS?=
 =?us-ascii?Q?1qfGZQRp8PJyJUDcNd2PPTjnqn/yVpAEtfBW6koPYelz/uIjdN5dZI7vnI2Y?=
 =?us-ascii?Q?j6gjMrM3hrs01P7rbg3hRwKWiNtYxbGsTO0awph1tgvb1BEoIiU90i3+E534?=
 =?us-ascii?Q?JkDTgpNizEijrcT3rN1o3Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d87eb4e-039f-4e24-87ee-08dbfb4de3a2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 20:06:55.6238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYVu7jGhou8wPbO8P8AG4BZAsG9aMxAnrt/ATdmKmst3YzOkUOMQnsYPtN/obEOyhMxemDvb6ARZp9GO8ykqZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7126
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120154
X-Proofpoint-ORIG-GUID: cnFCGbhYo_z7IQ4Z19Siv7pg6VP65Vq4
X-Proofpoint-GUID: cnFCGbhYo_z7IQ4Z19Siv7pg6VP65Vq4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/23 10:52, Gang Li wrote:
> Hi all, hugetlb init parallelization has now been updated to v2.

Thanks for your efforts, and sorry for my late comments.

> To David Hildenbrand: padata multithread utilities has been used to reduce
> code complexity.
> 
> To David Rientjes: The patch for measuring time will be separately included
> in the reply. Please test during your free time, thanks.
> 
> # Introduction
> Hugetlb initialization during boot takes up a considerable amount of time.
> For instance, on a 2TB system, initializing 1,800 1GB huge pages takes 1-2
> seconds out of 10 seconds. Initializing 11,776 1GB pages on a 12TB Intel
> host takes 65.2 seconds [1], which is 17.4% of the total 373.78 seconds boot
> time. This is a noteworthy figure.

One issue to be concerned with is hugetlb page allocation on systems with
unbalanced numa node memory.  Commit f60858f9d327 ("hugetlbfs: don't retry
when pool page allocations start to fail") was added to deal with issues
reported on such systems.  So, users are certainly using hugetlb pages
on systems with imbalances.

If performing allocations in parallel, I believe we would want the total
number of hugetlb pages allocated to be the same as today.  For example,
consider a simple 2 node system with 16GB total memory:
node 0:  2GB
node 1: 14GB

With today's code, allocating 6656 2MB pages via the kernel command line
results in:
node 0:  924 pages
node 1: 5732 pages
total:  6656 pages

With code to parallel allocations in this series:
node 0:  924 pages
node 1: 1547 pages
total:  2471 pages
-- 
Mike Kravetz
