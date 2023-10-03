Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA517B6FBE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjJCRaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjJCRaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:30:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01DC9B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 10:30:02 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393DwnZx017405;
        Tue, 3 Oct 2023 17:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=LU32n8Od08nGNRDVX5IbukbVim1plDGKubzeeCZGv7s=;
 b=j8+kwWZ4Nw2ipFRP/YU3H+p1jGTIsBDjwlCeK+pD1ZWnJnMf2SDRMHekKY2dC2351x1+
 z0ojH4XGwocCIbigw9LvQoqTtmhiUmKvCqAy2IoAvjntHDA28JOxcisJ5VdxHhh0uJ51
 qldS8TkK7xrV/hhsCcfPoRoH1Ye19KNXBfbZiv4K8EDELKkFZX8QqqhjU4qieaEGE7gg
 mGjESxLC6+d10Vg47LCK+CjFkQyM9kLJ1TnRLd2+lcGfG8/T/WTos76oDXXKbVLyduh9
 dK05KHjI61k7QVChG9ear4WuSgDGCAzYcqR9Ye4r9TShTlG1CMGL3EMC0r2+7zyG0Xhc Hw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3edacc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 17:29:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393Gi3ME000649;
        Tue, 3 Oct 2023 17:29:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea46abjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 17:29:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCI0hH0MVTGCg7WoDN+EnjwpEMlxzBOUAFZ4bUkNR8/PQzc6J5CG4ML+B5KDXSuFLzdWbG7EYidJM/53jEnmDUNYpCM9mkMAuAA7UhecXgQPDVRzxai3VfQ0+r39MSg7kIKPecnMfB/tlfvTteLPD/Sh99acDL0H6roqNOLmBsfMeiy/THmPX2Cb2RzuNi5doqhVN6Qp550HEOMTvFjSbJP24yutr8Fd+TkmlSxNJD1kGXUYmA9Wi+Cj0hc3u9FGdzwvi3YsTk8dYN2POQItn6XzhsFgMnmjfpFrZwtWIyc23XayJ8uUwMcUPf/L81RN4sH3/y1H5NfDBOn2o8My7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU32n8Od08nGNRDVX5IbukbVim1plDGKubzeeCZGv7s=;
 b=m1spTFB5XjHHDonTVzbNPcdgbpshiStHouEmIHkZMs5WfntU5kkoJNnDXkiD7N6gkmxH0f7CbiqbrqTnCxKH9kgLW3OjaXJ9dqgbNjvkPb8CtWmqMP0KNkA5gabti3msMM6Gic3An838xCfsZRwlMj3H9NHoMYDFZ+1PQ44/qwlfhZrHoHRWDfJi5T+SZX2qKXIqbYqq13cXhyOaIbtErrpXPJklS93W5QjRWJdXCGdodCCzeap+/WFg44H7FvNVXA6VX+ydPXK6oLPJBZvTKMGRuk6IsMtp4HeFru6CkbFT/l9R+0m6KWR761CxtQZFRn+zrwstciGTbTGyJeFHxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU32n8Od08nGNRDVX5IbukbVim1plDGKubzeeCZGv7s=;
 b=ZMJSp4deoT/Evkw+R+kPc5BanyhikXQbUwZ7N3v3W2UJjo5keosRDRqAX0Ykq6h8GSxaXHKS/pVsrC7PkFt/IWJ2hOI2tX5eZxAkPzn1hiIQZPwNAr/CBjQ4B/v4GaWW0TcyTPaeI3s56RK5IIMrVtTKqTL+NepfxGO4FWTQRT4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4585.namprd10.prod.outlook.com (2603:10b6:806:11c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Tue, 3 Oct
 2023 17:29:32 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::94a0:adfb:6474:63bf]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::94a0:adfb:6474:63bf%6]) with mapi id 15.20.6838.030; Tue, 3 Oct 2023
 17:29:31 +0000
Date:   Tue, 3 Oct 2023 10:29:28 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Rik van Riel <riel@surriel.com>,
        syzbot <syzbot+ec78016e3d67860eec28@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, muchun.song@linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [mm?] WARNING in copy_hugetlb_page_range
Message-ID: <20231003172928.GC314430@monkey>
References: <0000000000005f05820606a0838a@google.com>
 <0000000000003179510606d327e5@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003179510606d327e5@google.com>
X-ClientProxiedBy: MW4PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:303:b9::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA2PR10MB4585:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d610eb8-ae63-450e-5c33-08dbc4364de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fD5zoczH9b8hk0HNPCZsgEdqn5jvpV7qv6YuplgXy1F0BKx+UHQ7h93swT8U?=
 =?us-ascii?Q?RWJAY6iPx2Cf53dNV4LsCLu9zYDbZcqsAVMylvMlozWmJggeLMs/PoelhUJU?=
 =?us-ascii?Q?PC2Zxy8MKFNPlLndt9eBFgk6ZH+aKEaWSDdMqGU4aYIvSX1pV3xFjJz+X3RE?=
 =?us-ascii?Q?VavhwOHfLdiSKirMOg3ImPNT0YrUy31a4AMw+d+QHL70Chlczen9BJ3hsyjH?=
 =?us-ascii?Q?voPtZexuyfMUhAbSogX/CIk/aD1PhaaMM1P9Tp6ZZI6TuYgxBi7pCy4QX98w?=
 =?us-ascii?Q?Fy8hoRl8hE81C6bOGMoCLd1jA9Jr8K9NPSe3evIGSsZUQKDvRBpLMfeO0TiL?=
 =?us-ascii?Q?XoaG0oFySwSGVQrAg1iOdyrQk2JWVkfu4Z1Qx2Sq2CtBwhUOO5UAq/2gMFSv?=
 =?us-ascii?Q?RDkjM/twoBtXh/ajkeYPdnOIVA6wZFux0h2J8eYEpg/I0eHE33qrq9pe7CdF?=
 =?us-ascii?Q?tTMUTWEmj1hQBaGwuYevsUsnTgleCqqEJikvt3JmLFo6Q0zuwHb0wTyevvtU?=
 =?us-ascii?Q?0HDr9i7HClUXHapqfKHiNQ2KFIL+SJf4rW9dVCH8P7QOB5qMl/dcPRboDgRi?=
 =?us-ascii?Q?kvCGzjJR3XSH1D8x7gjj+3U+8evG/36zVJjvOgYWSgllPQcdPPM+W7CQqCWQ?=
 =?us-ascii?Q?wme1FXP9Rmon2AgfakXatpRC2Bv2z6FXOU9XwZEHb3BH+MxSd7jiVnmAkWS8?=
 =?us-ascii?Q?7ZykJQF7IMHVR9mkpTNmvuJQt5znF4d/rLRrcVExcEYMcD66jST831skVk1M?=
 =?us-ascii?Q?6+GLyOP8FPpwEzNC0q4SCUZ4JQcj690uhDRmwu/+MTwyyPM6WFS2wAS02G5a?=
 =?us-ascii?Q?78K/+GFTrBdI1Shs0Fyf2w4PuIb1zCp1m6J5CoVqxljicBE10A1RiBPYqsT8?=
 =?us-ascii?Q?QA1DdpKkH7vi85soeLIU3hKESM2o7bA6MAVDVYwns4ORkBpxNPGcCCpijemK?=
 =?us-ascii?Q?6BD+f1b47LwyWFHOVrUmog=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(136003)(366004)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(44832011)(5660300002)(86362001)(33656002)(38100700002)(53546011)(6666004)(2906002)(33716001)(6506007)(6512007)(6486002)(966005)(1076003)(7416002)(45080400002)(478600001)(9686003)(8936002)(26005)(83380400001)(66556008)(316002)(66476007)(110136005)(4326008)(8676002)(66946007)(41300700001)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f9EpeoUHDPUVm0+IcWKMd3Yk8bZWFprJB6zSOYjRM7v+0YV4HM+JPorRgr7P?=
 =?us-ascii?Q?5U8nY/SUEYqY+rJBbLbJKA0k5EVce6EG/HF6yw8CofulWYxF/1fuPGZigGun?=
 =?us-ascii?Q?YEHBzg9ZcaO00kspCDrxpWAWfoP4+Hns9AcViuvjbHi1KNrQm5NmTG8aSDg/?=
 =?us-ascii?Q?RK8CitrDJztBdeR69UUxoyNQAiXT+oap18hCj665lPzOdHFE2fTlCjUb5KGl?=
 =?us-ascii?Q?BdfTO6mI3Nnn+79d+hpc0p1/DyKvk1I6lz7oapn9yreVXteYqqjUaj92jugQ?=
 =?us-ascii?Q?r75f1iCjnGdO3InUNmPWND6XpTDAy/yNikQHuM1In6cBoS+oT9Sw4Bg6stR8?=
 =?us-ascii?Q?Ug5z20fMqAXB03HTZGAOh1X3gb9UrFbFeu8HHqgA75FndjOZcbcStULBFBpg?=
 =?us-ascii?Q?no03CfbmkcuVZKi2/8KyqSO8b7N+Vl3LcNlCrig0nTf+QAeks38VxaZR4Bf5?=
 =?us-ascii?Q?rOZgi2xSAACyOkVRIG5jeWWGWIhj/mbCvMQRoTMIdvnDXj5lkhdzU6vEvLvZ?=
 =?us-ascii?Q?YXditoC2uUHloISBq1mYQMtPhHNN+fzY3C+6NpcH0x+XLZXOA5n0mVK+Jsf5?=
 =?us-ascii?Q?xciZfZw9jnR/0BY647R8XhKoEiPRHt4k8pNSyfADmowNuyf9pXXuCOZ4sl3W?=
 =?us-ascii?Q?b90PHZhNATFtH8rsRPWDwH6DKdlltAifTRjiU7Eqls5HtcCm5OFgZQJlvmGF?=
 =?us-ascii?Q?4k/Iv1uG47q6oZ+vekSUnYD3b7h5mmq6VTEFI44IHuC2hv1aiKPwN7Lyt7X9?=
 =?us-ascii?Q?FLttw3lhotey5YzTAm2xen7Yk0vkomFBzDnnFijo43EUssP5DXTCHL2gM6qj?=
 =?us-ascii?Q?37fPKmMT1Buo9lo+AMhV5J6XaSwFeAKqBi8h+kSxuyH877vNR4M52H3UgCrN?=
 =?us-ascii?Q?aePHpkhR9xtQQ2dfZRCVJJo9nqr/iRe8DLYNG+acP17ftOzaT1JM1JZSrpB2?=
 =?us-ascii?Q?hKytwFp6O+lELvUUXVJhEPwWbJxmXqV7oH2FYiAY2PixYgV2Rv8SR7GHnu2y?=
 =?us-ascii?Q?tmF9GHtday0o9fw5vs8Lzt1r7eDrIwaAF616DZ1mj0W4c/csse/Z/CpPp7zQ?=
 =?us-ascii?Q?vhiSorSea54iyZMPULsyJ4e57FGLFHUHXT3PEbvIBlrVtX0PuB3aQ6akc7BS?=
 =?us-ascii?Q?h4j0ELcKVlUholpcAkQx57z88U294buOcd8V/WMN8OOC4oaohMrn9pLHIHk+?=
 =?us-ascii?Q?4XveLh3o8zdp6VHUCb3CNzBT8SK3kihaBOPF4PvsqjkE4E6yMnP6t5XzemLG?=
 =?us-ascii?Q?xE+rnKYrIkZi4YDYNR6+Tga+AdTjSaCzI1QI+MWBaWofOGip/ONL2jkw8xri?=
 =?us-ascii?Q?z31NDEMCasOZJxJTk842F3OE2EeGdD/9rH3hO70BjvNVuU9ulBqMo6z3Y809?=
 =?us-ascii?Q?3OpoXK5DeAbHA35MTjbuDShFalxhlzEQ0qsgzwuu+EtcYcE5lhritGLs+h8Q?=
 =?us-ascii?Q?gqBlVV8UDZcuwXEo5Jym6bmqLZ7oMVVIjiFtsn6oZc+KP6qeOrUfheuEGTwo?=
 =?us-ascii?Q?vrg3rTptuL77kdUIX8e42sz7Wq9Oqcu7fRrSG8yYTrYQ3gYBevshx8mqii6O?=
 =?us-ascii?Q?8ssXFIV01VuzEJWsR68eLTqkOlFgoZJy4vai15wU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?UgSsBDZB4kwGr9vg7dWdriAFq+n6x5vZlhRMmsJlce/2f1xNIO0K7BwFF5sG?=
 =?us-ascii?Q?jqkvRsqBbtJzl3tlex7zFNIer3s6kzy+XfHYKrItSQ+XHnwGZV44qpVCiqVn?=
 =?us-ascii?Q?PMTaK8X3eHUPCr0s6wZLV+Ykwhxj8Ab4byp9uYJq4fWDX2R5wuTVQSWga5Tl?=
 =?us-ascii?Q?bc8ww/X9PRunQw85VCaNy1s9tfE7LdshPkL+y0qauduGLy5Lpj1R6gFDtCKk?=
 =?us-ascii?Q?uXnuMiZgWu3O0wIBLoz+DEj2+H5/X9K2arn2ETCZfxxlgmaqVyM1MYnYXJ6F?=
 =?us-ascii?Q?79TcA+tJIfG1NXjjrAmqeen7S2vnErcz4jkc6MlvUgkpuTzDFtBQgsPFNoCN?=
 =?us-ascii?Q?bw3uTzeUIwUHsrMUwXvvOa1/qn4JxzFgVwF/ZOcY/ClqkL6qLvbKcKnovGqT?=
 =?us-ascii?Q?9KAmFCa30ETvUboSAFJ5R7EKXjgIR7nE6JiLgWFNafPDx/bQ6rsKGZXgBEuw?=
 =?us-ascii?Q?6Z5rEo9YbGT8uGQBxokRIOHQIqkNyWj9u7rIOIYHcoNHT8SD+U6TY1+1zOLh?=
 =?us-ascii?Q?vvmfGL1LuUg0p7d/G74AY9OiOAqhZp5tKdDMSe2Npuz/J6MQC12afF9cOa6m?=
 =?us-ascii?Q?3hncNivlGqErGaylVNzslVhBPURiHImpCbQM/z0dDSB5M20uSjoHDFr7YDM8?=
 =?us-ascii?Q?2dx9/50kTYSbGcVkOdlZWmvAVGVyfR3HUuf1VjgG/yTL16slw7jeHOaZ3Oyj?=
 =?us-ascii?Q?8DhL2fY1yLxSBicH12eJBdrJ7y4aov5Xojcq29iIGHtwTxe1oMoEidn7bgUJ?=
 =?us-ascii?Q?in/5JEOIt/3PT0XPKIoa3anwmp2bpSmPZe9GecvuBL/iUTUtt2yQkOiAHGon?=
 =?us-ascii?Q?zqlnoJhTK7nSkv4Bq/Rhy5fjnlG8ISyAneC4Gsc7UeeVSbMVL553G8B81ETO?=
 =?us-ascii?Q?gDMB5X6tJpzYFDcucMP2rTkUelFztvvRTWoTzigmeJMmqxfU4nB1oOOeSPJT?=
 =?us-ascii?Q?3WDaL1KQrQwSIWH9EulnFluKmJGpq7sws43uc3lu37qtqPBYnJ8KJYilPtCD?=
 =?us-ascii?Q?fm0YXFd1JbhhdPZtfKRVQC6xw0WhggOJOJA224kQLRvGYNpvH/XyFgHdnQoC?=
 =?us-ascii?Q?HuqJzuSq2/RJSZPWIGDyOGayC1O4EYLd1cm8XP+A7ce26B260oVt5BoH8iv2?=
 =?us-ascii?Q?sQEd0MKr2r0sD2yMYoBQtPm9uNfhlIPnFg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d610eb8-ae63-450e-5c33-08dbc4364de1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 17:29:31.8103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hk8GY9/scxC+1Tt2Ampw2T+Rp7jF1gJI3/16xYGtudIUQXZl2OhSIj4laWcXtFbVlm5NyHkofoH6cXwKf6HEkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4585
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_15,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030133
X-Proofpoint-ORIG-GUID: aSC5PZuD8U-Dq-KXN_JXTX3J-cZMI9pN
X-Proofpoint-GUID: aSC5PZuD8U-Dq-KXN_JXTX3J-cZMI9pN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Rik as this was a result of the conversion to invalidate_lock patch.
-- 
Mike Kravetz

On 10/03/23 10:23, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    c9f2baaa18b5 Add linux-next specific files for 20231003
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=154df992680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3fe9c462fee1649f
> dashboard link: https://syzkaller.appspot.com/bug?extid=ec78016e3d67860eec28
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e4b011680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11772062680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/5361e41384fe/disk-c9f2baaa.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7028b209124d/vmlinux-c9f2baaa.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a167dc667ee5/bzImage-c9f2baaa.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ec78016e3d67860eec28@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5054 at include/linux/hugetlb.h:1289 hugetlb_walk include/linux/hugetlb.h:1289 [inline]
> WARNING: CPU: 0 PID: 5054 at include/linux/hugetlb.h:1289 copy_hugetlb_page_range+0x675/0x3520 mm/hugetlb.c:4940
> Modules linked in:
> CPU: 0 PID: 5054 Comm: syz-executor329 Not tainted 6.6.0-rc4-next-20231003-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
> RIP: 0010:hugetlb_walk include/linux/hugetlb.h:1289 [inline]
> RIP: 0010:copy_hugetlb_page_range+0x675/0x3520 mm/hugetlb.c:4940
> Code: 00 be ff ff ff ff 48 81 c7 a0 01 00 00 e8 b3 2f 6c 08 31 ff 89 c5 89 c6 e8 68 77 ae ff 85 ed 0f 85 dd fd ff ff e8 eb 7b ae ff <0f> 0b e9 d1 fd ff ff e8 df 7b ae ff 49 89 ec 31 ff 41 81 e4 ff 0f
> RSP: 0018:ffffc90003a2f4a0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000020000000 RCX: ffffffff81d9dcf8
> RDX: ffff8880675d0000 RSI: ffffffff81d9dd05 RDI: 0000000000000005
> RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: ffffffff910df9a8 R12: ffff88807905b900
> R13: ffff88801efab500 R14: 0000000020000000 R15: dffffc0000000000
> FS:  0000555557543380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fcd71918140 CR3: 000000007b828000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  copy_page_range+0x1dc2/0x3c70 mm/memory.c:1293
>  dup_mmap+0x13f3/0x1d80 kernel/fork.c:758
>  dup_mm kernel/fork.c:1684 [inline]
>  copy_mm kernel/fork.c:1733 [inline]
>  copy_process+0x6cc9/0x74b0 kernel/fork.c:2495
>  kernel_clone+0xfd/0x920 kernel/fork.c:2900
>  __do_sys_clone3+0x1f1/0x260 kernel/fork.c:3201
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fcd71930ab9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc79f4f9b8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcd71930ab9
> RDX: 00007ffc79f4f9c0 RSI: 0000000000000058 RDI: 00007ffc79f4f9c0
> RBP: 00007fcd719a35f0 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
> R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
