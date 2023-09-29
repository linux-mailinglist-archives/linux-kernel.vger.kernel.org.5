Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA83B7B3904
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjI2RfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjI2Re6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:34:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7237195;
        Fri, 29 Sep 2023 10:34:56 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TGnZaB001030;
        Fri, 29 Sep 2023 17:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=ZvRVNYC6Mb9o+5qqHCON9eIpBgn42Gefin1dW1cEtYA=;
 b=BDVUWAw4qLrOGWIgE7E5fEZcwiynA/efTkcVmWJr+gcyrBuoNnIoNlPUu5q4QSb6N/hP
 qQFVdptJl+hGW7q/VoSMCia28SAnABne3SEgWZcoBiGVu6kiC4G8ODQ2WtP+Ddqm1CF2
 J4bqbvEB6h3xS8m66pS6mG9k4PkmbGmwekkVoim6Q1jZ1Rw5L1sA+TcqKkHZf7ha063V
 ibFfQ7veK37Zwc6t8ig1FU1FIdYX+P3ZeaxSrpy9s6WL3FiZ8SVAskuRB4e8DwBppW4b
 LnNHHG+yo8TaEU26nXh8WcfdFm/Ez0vIu3hYvzu2aU0mscftnaKxCzwi3QnMzTSpP06V sA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjuq9cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 17:34:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38TGGS3w025271;
        Fri, 29 Sep 2023 17:34:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfhm5n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 17:34:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oX0LW9j5DMoAZJ1VhfgnFzSZ9+wFDHoYPffGXYE4P+p7vIK5S40fqkf4JMtxWLCAtc1K4chnrceqLzZorsl2xmgdin2zMB2NIf5X867llDqH0QzrYRfGtMTFELbYMzXD7CGOi+f6F+jclautrqjgdyf+H337EZY4RPEzJBzmnTTHHVBuiSsd1IulAihtAuUnK2h7u65JNBezWCycUPZa+XXTT0mJ+7EwLfEVh7zpHnJw4BLTKBNQT35PdqB5KzchwrV1lYh2f7TLu3oqyJSRHmhtByLjq/d/T53g0K3v9VNVU0kv2f3vcEeH+b6RB7cQDZBRb624NSCPOhCIAHpQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvRVNYC6Mb9o+5qqHCON9eIpBgn42Gefin1dW1cEtYA=;
 b=e21FaIY9W3X4HqdAQP7PMShdk9dsQvZ02ATedsPcyx2d50RQDHo+MOpssUV/rK6/ih3y6giT3Qy//GYtS96x/t8W5vlvIYI8vui+b5YNIFUSSAjM3ZDkHR9KcGf5uObtX3XgAImuR1Fe48j0dHsYt4IbXPuNFhDF3QMox0lX4rKJEDRD+XSRcZHursH1TZk8ofewRXvbG+S48x99wkOqO2KtdaW4CrHadLZmjhzXnYJnbrjIevr0PaeVIBiYPB1WAbtgVeZWkcYRMX916Fb79XbBsX1B7rRcSrktw28Lv18lWeofw08sfGYE8J9zHHJvUwjaGTfrg/jkExpsJxsjtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvRVNYC6Mb9o+5qqHCON9eIpBgn42Gefin1dW1cEtYA=;
 b=yHRcFaKw/Cyi7cyJXHk88UgA3bsfQ+RWxUMemTf/6DqPoSKCE4JGWdtEU4Ww9+QU19GCtpLW6/U/AjIiL9FH9Nfv6jC5YRHFSS5VHL6hrqHDXRqy+KElsra4ihuLsjWvvcuBnR86x/sAZT+45Xm0v3pgVi0JbUB5hU8MHwRFqIk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6863.namprd10.prod.outlook.com (2603:10b6:8:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 29 Sep
 2023 17:34:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 17:34:17 +0000
Date:   Fri, 29 Sep 2023 13:34:14 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Ott <sebott@redhat.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm: Fix vm_brk_flags() to not bail out while holding lock
Message-ID: <20230929173414.g7ovzk4hwpz5kobq@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Ott <sebott@redhat.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20230929171937.work.697-kees@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929171937.work.697-kees@kernel.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 3225d621-9953-466f-5195-08dbc1124e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zEtnBYEc9Q8xOxlpXxr5UFNtAtuGuWQKstiEu/gr5lVAaggru2WxV7ikTzsdgVcYl7XcOkgEJC86Bc9ZEM9Vx0pL186+q9wMNQmMFdrdfjOORJGKJq8TxUZ9KOE9A4SUZaN1U0UXi/QTipCzmjSS09Fk6Zl9B78Wrklh5bQToRayCniRWYM8LPwp51TB8xcMfDQZAmJa/lMEMMwOA7BR9ixGYmGWW9ThAElCTz2dyssV8kMTO10fAdl0XtL94MY9+fnluWP4hlq5HzeuBtL8AI4a8nKkD7CBOjymngqRlwwGMAh9t/1GF/QZo5mOh35WANQEoytL+tzYpD3+SbsDR/x7sfH2hC6N2n5jxzxTamf3toMvPa1gOJR8kGhYgzaZZbZGrM5yMifX/PHGk53SlsjQYhtEk0lBqQXX7ee3YNpr5CItMXvmIiBk6EkW3hmzvKJijopByJwuMPyEYnKlHUN43tf44/auLOH0Gs82Vl+zIk2tBIQsJYJOJ1q02hvRdkFKIj05OzkgxHSfDMo/uxpj0C7o0VViF3fuTq4YV/s8qz9hkfrTzCgeXoRQyvDf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(39860400002)(346002)(376002)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(6512007)(6506007)(6486002)(9686003)(86362001)(38100700002)(1076003)(26005)(2906002)(478600001)(6666004)(83380400001)(4326008)(8676002)(316002)(8936002)(66556008)(41300700001)(66476007)(33716001)(54906003)(5660300002)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6SlcbiJI6NeTkTXcFZxYGZ5J80eFK4E7X1tM11aESsNKn0SKXrRNASyV+RhC?=
 =?us-ascii?Q?2BQo0ZDvQ5QkZzcDiAGOoDN9UAH4PK0UQ9C39jl7VPWyCQIhmwBT/lh+un+v?=
 =?us-ascii?Q?d2HoPwZC0kgUAU7fQz9nJPBQjsan+idcSTLzmvzjZluxj2ocNjmi27QbuyXq?=
 =?us-ascii?Q?muZS3Ihm5KpCP8s6DeulSH7/eEMLYa4TzQw8vb8u4q+3vU9rF98iBH23o4F3?=
 =?us-ascii?Q?J9PzNwDMieQoduZknGacgwILKqRTyUy42ykKkFsjQ+d4hxBzxc8JgcbqTrqb?=
 =?us-ascii?Q?Y6L5Qh1jlxz0wcA0/BHkBXu4F365hcmVPIpdd+JNYOE/ErvtD22XZx7B8Jzw?=
 =?us-ascii?Q?4bw1T1EIWu3Y7EOCYge+N3R2NMeY6kClWoutN1xApucQEOOcykwfvJV+JPDa?=
 =?us-ascii?Q?4FDDpasNYoQbGFmh1eOrRQkUrIW67caSvXU/EnkH0D95scxl2WFLSK6DYpid?=
 =?us-ascii?Q?clJE4fjV+oB+6FHFTlTyV3uSjduQMVWHhKE2mq/MhqEwvDCDB3HkVtB7pbHS?=
 =?us-ascii?Q?DSa+B/jKpjiMj4XWpYpttwS6Eh75Jguxr7HDpf/IYUhK+bTdjx9NccOeHSlF?=
 =?us-ascii?Q?uX8HHQr+UGp1Ovg7+KNf61BLXsm78ZgD6JQC6/IuxizaojvfObANAAxvj0ff?=
 =?us-ascii?Q?56TvhLVi+KYdG+s9JmfrE6rdXz5BsEcDXGZc1C/wi7sanxQ122BST66ULmOw?=
 =?us-ascii?Q?eCZ33SfAhwhrXbNS87bA/qjM5BJvIQ1JsRzzOc0+wjcFjUW3gDgcba/WZUg2?=
 =?us-ascii?Q?j9a/LO4kzK3vDgz0ltPLOWilrpo0RdVvXd8raftYEg+tVspPYG3ZWZi/WWHf?=
 =?us-ascii?Q?aarpU4VUYIyirA+oMyukpoPvnX+9HLJCJ4oygUlpy+i5tgRaPuI8W6FfUH0v?=
 =?us-ascii?Q?jzo9qkwu164iLQMhmdL7zZWP40O6stsp3RTg1dvEX4GOemBXe5hcX6FSUGtl?=
 =?us-ascii?Q?M2+vQU7R1wMe0gO5IsQnnPiBzRNIfMa0sUVAfR+RhcyiiT0tQt1p2Hd6Y8Yk?=
 =?us-ascii?Q?jh7dqujoS0G4W16eecX1XVA89HjqSB1VKa4/J3U7zSMwTTz5UYGEDxg12hj7?=
 =?us-ascii?Q?J2wxyP9uAbb9kgeqAY4KegCrMwcmJgzPuceT+1FRdFyxyfCAxBaEOL+CumPK?=
 =?us-ascii?Q?ds5KNMkwfJnTguhlvIwM+z47ONNl2XhUyVCNRXAqP9qPkGhhMhnDSL+RGF7W?=
 =?us-ascii?Q?jT6s73qkn7GX2yfq/D5Sl7NhxACPGLJ3lZfn6LRrMPHqtIsCGCdBQRxV5s1p?=
 =?us-ascii?Q?vHLQlKUlJRmrAkm5jaaD3Gxp97ZisXqSgbmvx1Pwv+ARiazgw9jyhnsZj4fJ?=
 =?us-ascii?Q?cFN3Hu1SFRPbLhRvUb5XbBqEZSGeGQGqBWTMZParxnMFeMQ/URKvj7B6UFTj?=
 =?us-ascii?Q?VuteD3YlUfZJgMr4wLsfFAi7QhAtukTQo35gzKdQaWeQKM8ai19a7oz0RYW2?=
 =?us-ascii?Q?BVvo1nk4+zPmxAfdkAUlEdhtJRI3QzLE3ACOSOd13zBF6EkUNj++VxetBSur?=
 =?us-ascii?Q?lF++nAFpdONx5JnwILhce/NzSYcbOhwCgKMQSzkPf0obfiQgOvCAK/mXhVbz?=
 =?us-ascii?Q?CXKbPKba5iaqJi+cFyxim8oZ0LDuH43MBqy5FkBv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?w/dvwz+Uezg8zm+q3AxTbWBUFjvaF1rB5Jj0IUC7e2x+DwLuF82/VPgyyVko?=
 =?us-ascii?Q?Tt617V2xmfYoxl4sPPwTEDITqD6wLNsEip5QCoIeP9VTU82ZAEt029vJOTeE?=
 =?us-ascii?Q?kNVLZfEveFc9OiS7BvUOuTQABj/69Ixf3Ght2WwdNpXcq+613KIqAQ6TTQvp?=
 =?us-ascii?Q?YB1GyV7ssOwOrNpkr8wNIoEE2DiGxEStv49n3IX4r+qF6pW+nRIZvn462iOW?=
 =?us-ascii?Q?1FAZb0i2Z7nAYApBnV9eC40yv4SCGrLuUbWO+bh1Fnx1zhVzgeTVxUh0K8UQ?=
 =?us-ascii?Q?3PXfbe6mbWzpV3nFswSjvoN/JuqJcgLzECLrLkpn6XhoU7l8fdZnKJilyU87?=
 =?us-ascii?Q?yXbCh74SY7bhZm2eGPh86XVY/sJgo5D48E+0oRM4LCyTsAiSHI9QcTLZ4RGe?=
 =?us-ascii?Q?JfFzbDdiH6RL1FC6dx8OyKUuKbL2oH2oPVS7J958dF45zw6j8AkvmRzMiCKu?=
 =?us-ascii?Q?GUB+s8C3DJ3wn5EB7Na2pn0HDEmWx1Dauzz8b81BGuGDAp8tfryUT1csp4yn?=
 =?us-ascii?Q?04W9AR6oXYztX6c8dRjjqQaFAo0Icyc9DomA6JYyuGYnpIGxABMo2oUk86t1?=
 =?us-ascii?Q?oAkawzfUS8PJ2j9mObl4fcqd1Wz3VsC0hLCjMD1mvQvAoIGWxaeJVRHChgbZ?=
 =?us-ascii?Q?FdAUaz5DnESnTbaqBzojLaCnt4W2+ZoszFqMXUYgFBgYKGAUF5/X9i5CtY01?=
 =?us-ascii?Q?a2FVLXbp/WhLgU6tXQBpa0psCuAknVmKB0IYAzGgbWGEAGgHwRlsjCaL3/nG?=
 =?us-ascii?Q?0iD3DsZygKkyVwf2gKisYQvtV185Y6CXrG9oQp5wRrFl7tLpaA5C9uXOeMPH?=
 =?us-ascii?Q?jSj9BSMKxBUoahYYunHb3tn39+49XvhuLKZgt6Gyzvwwf8GypBPAxGgjzwMc?=
 =?us-ascii?Q?jChTeiTsuqLKOVkQn1IYmFstYY5Xztb1RqFzY4kf7C4Jsz9anjAg28IutD4B?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3225d621-9953-466f-5195-08dbc1124e55
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 17:34:17.1766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XalINFIem7lF2967d7KBKcNNrCUBNVlCyjMJ68EHPa/rCH3KsXKjdv81Vw0cSQ8YZsmHgQERvA0sAJ5bgK90g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6863
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_16,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=904 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290152
X-Proofpoint-ORIG-GUID: o97H_caz3yr5K5kNQE9eRz6lfFMZH5Eb
X-Proofpoint-GUID: o97H_caz3yr5K5kNQE9eRz6lfFMZH5Eb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kees Cook <keescook@chromium.org> [230929 13:19]:
> From: Sebastian Ott <sebott@redhat.com>
> 
> Calling vm_brk_flags() with flags set other than VM_EXEC
> will exit the function without releasing the mmap_write_lock.
> 
> Just do the sanity check before the lock is acquired. This
> doesn't fix an actual issue since no caller sets a flag other
> than VM_EXEC.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: linux-mm@kvack.org
> Fixes: 2e7ce7d354f2 ("mm/mmap: change do_brk_flags() to expand existing VMA and add do_brk_munmap()")
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/mmap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 34d2337ace59..c8996fe847c9 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3143,13 +3143,13 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
>  	if (!len)
>  		return 0;
>  
> -	if (mmap_write_lock_killable(mm))
> -		return -EINTR;
> -
>  	/* Until we need other flags, refuse anything except VM_EXEC. */
>  	if ((flags & (~VM_EXEC)) != 0)
>  		return -EINVAL;
>  
> +	if (mmap_write_lock_killable(mm))
> +		return -EINTR;
> +
>  	ret = check_brk_limits(addr, len);
>  	if (ret)
>  		goto limits_failed;
> -- 
> 2.34.1
> 
