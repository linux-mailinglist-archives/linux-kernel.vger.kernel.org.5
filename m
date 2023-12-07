Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3318B808DFD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjLGQlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjLGQlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:41:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C14010D1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:41:42 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7FIm5W015157;
        Thu, 7 Dec 2023 16:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=LduJtT2hIYSMz9zZKPii7A3+0GxWo8QsY2fq5PmcdKY=;
 b=IE7QBa+4gDNkPlwESN02LkSBpo6qiPZUDgKMHKU6lAT5pWhIVXdsxr87YxyNYh9DKKUM
 JMx9zCn8nPicyImBTvh6giDBDkbznrtD6JQK1MS7izNd87IjjdTMlg8DvJTDqPx5dj1i
 u6sBH8f1K/tUBsLSh9mtPgdkQZ9uNv/0Kj8HIXlrHWX15l1nLi5rRlFRwMZT3obQwbVB
 H06F4BaMB03AI5Pv0ckWZv10tbhWXtSF8XYK9uBYLYHHfADZycBQi0GzFiSwzYYPB6ne
 AtkNBy1YqaowaUQC7GFBmxoVz6Z7R45uYN4La+4RZQz2BISeY4WEa6IqDOpD/IFiOe+A Iw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdmbm9pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Dec 2023 16:41:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7GXM8A019800;
        Thu, 7 Dec 2023 16:41:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan6edj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Dec 2023 16:41:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmqnP0VzMrddrEGGdkdLEWHnxYftKKQ7EiCuWDV2twbXUwbHfixRjY1oorJeQfuYLOP06KgJV/9uDfFaofz1PMX1vLGsBtFQGTrWm35HbnEc/ySdQemGmsZkTmzULZdeJ20s7a0rVcG8RsfMohO/8s5TXisMGdjCf9DDOZ2ybnq2V3f8XG0K4t1gsIt7lN/sUs9hqFoxKhFi+Tou4/AEYslIOxklrWgNrFjCUbJ3WV4UvdG6xmhXfkpF7kCLrKRTZpD3Q37oFh2HSWDaifx+e2x70XX+wcwaVmZZBKkPYP3nnzWv6zWYFaCNG36uAfP1EIc6oW6IkDoOY9/LWMN20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LduJtT2hIYSMz9zZKPii7A3+0GxWo8QsY2fq5PmcdKY=;
 b=BJVajII0M/PS54CyPW27TW6IorYsa/mQs8V9ExmiO+1Lhgv7sbUGmRljiZ/5B46HIVYKNl4JMbV04y+dlhQu2vqKxFoXKkoCODgA5g1zEivUIFRBGlTTdk5xCSpopfBXxUmL+X62silsPS0dSFIMtybPINyM7RLI1BhYD0eUXN9Vnwss3Qqrism3gOekJI036SWNF6ar++8wecQlx1dStdU3Sdh1ld88QPMgVH4eLMmzOzTRlbHOCBwBEmI53c4rFBKnYk82nYSs5JQV5ROCETKRobHBLU27oczlzeWpv6qH7uEeWYQwaXhBkkAHnBIbsM/0ZjlA0cJfArExURnWQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LduJtT2hIYSMz9zZKPii7A3+0GxWo8QsY2fq5PmcdKY=;
 b=EmWFOoX2D8aSXlF3VH2kZfMkBRed9vLqznPM4iiopJPnw33HFQKUg6Qi2D8IxVFeuj6zvTyURPTtve611/2CmcNJ5hrIxpydv6Jt8UoKm/avNl7EVoJ4qS3Nep9eq66jZahDWegQd+5mFELS0oT0RYood5qCAqxbDvGup63JBgE=
Received: from CH2PR10MB4309.namprd10.prod.outlook.com (2603:10b6:610:ae::12)
 by SJ0PR10MB6373.namprd10.prod.outlook.com (2603:10b6:a03:47d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 7 Dec
 2023 16:41:30 +0000
Received: from CH2PR10MB4309.namprd10.prod.outlook.com
 ([fe80::300b:9614:f3b7:17d8]) by CH2PR10MB4309.namprd10.prod.outlook.com
 ([fe80::300b:9614:f3b7:17d8%5]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 16:41:30 +0000
Date:   Thu, 7 Dec 2023 10:41:25 -0600
From:   Aron Silverton <aron.silverton@oracle.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saeed Mahameed <saeed@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <kakenvblxlgrkjvcrwfflnkm6n5fpxgr4qifwkdttjascth3te@57us7mblobjz>
References: <20231128162413.GP436702@nvidia.com>
 <20231128084421.6321b9b2@kernel.org>
 <20231128175224.GR436702@nvidia.com>
 <20231128103304.25c2c642@kernel.org>
 <ZWZJGF7moDM_k6TU@x130>
 <2023112922-lyricist-unclip-8e78@gregkh>
 <oxtcvxwbj2hzv4lxnxubo3hoxn7diyzhm2oj3tsw2toxbc3og4@ddglhm6r3oa5>
 <20231204185210.030a72ca@kernel.org>
 <fgalnohzpiox7rvsf3wsurkf2x3rdtyhwqq5tk43gesvjlw6yl@i7colkh2sx5h>
 <20231205204855.52fa5cc1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205204855.52fa5cc1@kernel.org>
X-ClientProxiedBy: PH8PR22CA0023.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::21) To CH2PR10MB4309.namprd10.prod.outlook.com
 (2603:10b6:610:ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4309:EE_|SJ0PR10MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: b4ce335a-ca58-4935-8bcb-08dbf7435cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SfScGndW/dYEWltkSxBH5Oqn49htfBxMOG4C2b4YHqXQFFVaGru4S8uSPo6M1sg5rFxCRq7eGtll/ZiTeE+RGKqZKpIZHt7klgeaG8ODRAKiW6pvzfL7PkonGddDcze3XltXNe34MieDJKHMK/5LuIldEukWKWReClxIlIVGqO0zar90OACWs022FXB/3ILQidO8XsmG3ZRVxuZ9PKdGU3MvfzWm1Z5Xly4jGfI/i1ANLLH59QK30EVGltebP7/RMh/AX6aXV66evCIk6Hg5wZFbsq5c1W9h+wqlADIXOzp6zsNjoIHH2Ds6h44vJ8bavpE+d49LTDaLs0LKPHlE1B2j6fZ454Hlq19s+SJ9ihTcovAI5jAqUh4LdO8W3MzCG4ekmqi25bfTIV2LJkC8gWHdqIlmQtRi3mZFYAnV/x9KHE+oQTWdNquEn9UeB5Ypx0qfMzmjuuPep6LpcxRzJZqUHEGivqjoL7In4Fk75DnJa/oEiA5+5unFfdxOd0W7DRqat1wZAzVcmrTC9EgMZfVv/YTOPLT8JcXMbc4q/9SQHkli3soXn5N59CY+uUTleMPVLOjrY2+21NIa2tiAEM7SgibF6ca4aD6+hakyxnZZadICGWhx3OjNB2ljSuep+4mPE///I78hQ3D3Jj9ewrdqCFvshLkD5ou2aR3H0u6nZs/LU7ZiKGstmMcEtPCA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(396003)(376002)(39860400002)(346002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(41300700001)(66899024)(6666004)(6512007)(9686003)(83380400001)(316002)(66556008)(54906003)(6506007)(478600001)(6486002)(66476007)(66946007)(2906002)(6916009)(5660300002)(7416002)(8936002)(44832011)(33716001)(86362001)(26005)(8676002)(4326008)(42413004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rcAQzwIcOIXy4oxXVJkd922zIMJgomK4MNCCjhLkniqRDa5p4+q2hAWa4BsJ?=
 =?us-ascii?Q?UbVYOyglDOU58tdgOHKozZ4aEdKyoA3R7g5JrmSoevuFKpkkEBEfRqYOW2hA?=
 =?us-ascii?Q?mZfT0b2lKN6T1ahGwbPrvM3U4jTcC/etgtaNq0vPfulczp6UeJ9oCHt+L/nT?=
 =?us-ascii?Q?LFf3ZrE8miKJza1RQgdxJUJFwvadF3BJK02PZB3gRE+/EC/dgepMISnlz/Ws?=
 =?us-ascii?Q?xRoXpBsdhwaeAjdbvcyATCQF3kf1lWf2ExT0ZItCdMYkV1LMqrIMGCVtSFCW?=
 =?us-ascii?Q?R2Yz/OTmO0Pn0czifKNbnrV2LjLuoNuDUgM5SKXlI+pWmpn1KPCkYanzOEW0?=
 =?us-ascii?Q?aHRiueVcmg0wBVfQY6gyPXDca6T8G7eyI/p5h87xkpgFAgrglygoLFSK222c?=
 =?us-ascii?Q?IsDIZTzdR9K8nPUXiGkt99X4D7ezib9DWWX5DC6qCoCS+GsGiy26RJouUSIq?=
 =?us-ascii?Q?dvlOMwhHDdU5iW86V+LQeFvWZNPgWud+34ZZQQgOtQMY5oy+y9kAS46L8jtO?=
 =?us-ascii?Q?OU96oH67O/1D5XyF9H+wd2pzu5FLydqpWhen6RqHABqxlBUSgomrdBi5Fpvs?=
 =?us-ascii?Q?q+oKIg19D7LRKMQryPG91gkhuRErLizQYxSTbfbzJrih8ETymVuE5ozv44Ta?=
 =?us-ascii?Q?NP44YZt+wz9xx2RwmchL9/nm4SHUzyzTk9bBCJ+4+LXqKebE4eE614gvlpTw?=
 =?us-ascii?Q?f4LLDeykv/1WN93XjjQbS3IgdGq0DJdFY2rbLvk6PQ5/msnLlLLG0q0ex22L?=
 =?us-ascii?Q?CyQmN8IKQiYNDuJ6CCy7iD5gofsiSU2/RceXbgwQDnwSAF8yxWWFdnqX3H1P?=
 =?us-ascii?Q?5iMRuYlhyo9DOiL/f+mh6lMNGqLTQH7zBaPfd69YmNti61IQ4zOPu44kWAcO?=
 =?us-ascii?Q?u14VoK2JqlNoliKmWbpRvP1PuCQjYzJNLarAU/FGn/sHlGh1U9qka/Edm3mq?=
 =?us-ascii?Q?4QQvZNwBt4qgyWregQW5THSel3TIIwjCnRzmJp8i3U1aJkcV4vZJhQ1W2wqS?=
 =?us-ascii?Q?xfEEKG2St01zLABR9yqeD/6JaJPz69pP4rwwlC0D2hnJyjUlQW7lbqCxT1id?=
 =?us-ascii?Q?qrZBynpLk+9Is5gduHpBe+hhtPjQ7VDsZq+Q99+nGtAphSbE7/QxY/SoxdFa?=
 =?us-ascii?Q?+mWLtfZlLYKTMO4H1E02HIF0Gkg0xF+NJf1P3ujwkeqHGJTEZybId/66//3p?=
 =?us-ascii?Q?ujipny9aNf13E1aNylBhEYCH48t+DFbBaK1YlIIgsZdVb+aeoCdOSzihqoZl?=
 =?us-ascii?Q?uKG8Mys0MUJac8ieLmPuiWtxHxMyGdDlN+rYep1lsj9twzTyKsXX7qDo/cyS?=
 =?us-ascii?Q?x8hmKyqfeEfOeyPjq/AxpTBjupR1I3qDN9YEsbjKdYO8u+2VHYUDbZl9DLBo?=
 =?us-ascii?Q?KdF3BEcsISE85A3gcy1Dd8yUDXtFohVRMeGEBrQtz6+hLSGsyfVyXHBZqqEe?=
 =?us-ascii?Q?1btYgLWtv/fhWOFyBa8KLW6DVO/hHajq3qtDN3w3JywUIwkEUjz0QzPAJBoN?=
 =?us-ascii?Q?psE7s6YSK9DbvuSS7AKHJ1rI/h5+SqEzhWQYaED46vILElKj0L9Q2aTjQrpt?=
 =?us-ascii?Q?tASkuCBQAAqy9ij77VnjsNdE6v5atZwRHVQpBov03vZ1XG6tj1uNzNmkuzyY?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VfY2BBoi4lZSC406xEEXoeOzqtI8KmLfnwOqij8UbhMoKAJ8AS3gkVCxthJyAQRQfPsl3gj/+l+krjtIyVPkHGLORRjoldX3cr9h/1ImWm9qy8YyiVzwoWhUdGgTaHbyyZcZCkdctwGXNK1p3Mu0tAWeY5sfNCTMXeIRkLaPIoC9FVF+tTmHbKrUZ0YokizPdEGxriZ8fgdoAnyRvSLmNf54EiHuLgnSv/hc43RFo350mE+Dwz/+TEFMF1RrfIDwGMBNaqvC2dQuln9gBYc7SJAzXRtZmkhVqRW6ZSnnV6H6fC3yF/3gsiECZCh6jBHg6llTw7BlkNx9vSpRZL7M0hpaCLrAd0WUHPD0r2u9rpmJCTnfgg7uemB81GC5lzkABrnSjaeHSmpzQ/QpycRajEiiwoPwtakUzds4NvbaIy6x1xIr0w8VVg/oFjBFvZJbVmjMhUwyOT1spHiWWRhM0iTBv7exjO0Q7odTybbTRnQy4L9eu+XMDv/ozMlu5SaoWOs9Hnk0QNe4GhI3IumNArk349FQaXwbDnXNJMZXZQqhJuVSqsD00Jjzz0u4RnbOrdho1AIFddTTn910Hl/7OD6eWVWYrgtjJPqPDXse8NGkCc3bSeH50MSzLwtQD5RbbX5ArNqi/5iAFPDm3WFjvqCeUjG6gpeP2zAfRJ/Jxvcz4Hx/OxSdbUpBgzSEdAzX6Rr9mpSB1SQJPwzd7hbRw7rUBlfm26A5VsFbJjzTiS81Rdk7PVtdNIzKWwWfSbz+aDB4vdmV3eITOjTzS1qexO07KEDEUhStrUUQ2Adp+s4luCAgNEj9+dS8KVEmbqFPaNp1wtapCTBND1vAK5qrfH7pMG2Y3TmubqH7uTd9h/8KfemPCLh/EYEXGlPYL/iItwUSB0aAyuLiAyuHX0WzfQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ce335a-ca58-4935-8bcb-08dbf7435cee
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 16:41:29.9982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBCEhnahSDwdb7YnMkItX7S6qrujFAtpAg6JM6m/cA+rWVlfB0w0nFbN+gx5vxQ0Nmw2y+S+lBZ0Oind6K0q+51QpvY5C+XjeniJTU5qWS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6373
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_14,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070139
X-Proofpoint-ORIG-GUID: VPqdFOJFfN83wh9fYVhD8a-JdSrXUsAn
X-Proofpoint-GUID: VPqdFOJFfN83wh9fYVhD8a-JdSrXUsAn
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 08:48:55PM -0800, Jakub Kicinski wrote:
> On Tue, 5 Dec 2023 11:11:00 -0600 Aron Silverton wrote:
> > 1. As mentioned already, we recently faced a complex problem with RDMA
> > in KVM and were getting nowhere trying to debug using the usual methods.
> > Mellanox support was able to use this debug interface to see what was
> > happening on the PCI bus and prove that the issue was caused by
> > corrupted PCIe transactions. This finally put the investigation on the
> > correct path. The debug interface was used consistently and extensively
> > to test theories about what was happening in the system and, ultimately,
> > allowed the problem to be solved.
> 
> You hit on an important point, and what is also my experience working
> at Meta. I may have even mentioned it in this thread already.
> If there is a serious issue with a complex device, there are two ways
> you can get support - dump all you can and send the dump to the vendor
> or get on a live debugging session with their engineers. Users' ability
> to debug those devices is practically non-existent. The idea that we
> need access to FW internals is predicated on the assumption that we
> have an ability to make sense of those internals.
> 
> Once you're on a support call with the vendor - just load a custom
> kernel, module, whatever, it's already extremely expensive manual labor.
> 
> > 2. We've faced RDMA issues related to lost EQ doorbells, requiring
> > complex debug, and ultimately root-caused as a defective CPU. Without
> > interactive access to the device allowing us to test theories like,
> > "what if we manually restart the EQ", we could not have proven this
> > definitively.
> 
> I'm not familiar with the RDMA debugging capabilities. Perhaps there
> are some gaps there. The more proprietary the implementation the harder
> it is to debug. An answer to that would be "try to keep as much as
> possible open".. and interfaces which let closed user space talk to
> closed FW take us in the opposite direction.
> 
> FWIW good netdevice drivers have a selftest which tests IRQ generation
> and EQ handling. I think that'd cover the case you're describing?
> IDK if mlx5 has them, but if it doesn't definitely worth adding. And I
> recommend running those on suspicious machines (ethtool -t, devlink has
> some selftests, too)

Essentially, a warning light, and that doesn't solve the underlying
problem. We still need experts (e.g., vendors) to investigate with their
toolsets when and where the problem occurs.

I offered this as an example of one issue we solved. I cannot predict
what kind of issues will pop up in the future, and writing a self-test
for every possible situation is impossible by definition.

> 
> > Firstly, We believe in working upstream and all of the advantages that
> > that brings to all the distros as well as to us and our customers.
> > 
> > Secondly, Our cloud business offers many types of machine instances,
> > some with bare metal/vfio mlx5 devices, that require customer driven
> > debug and we want our customers to have the freedom to choose which OS
> > they want to use.
> 
> I understand that having everything packaged and shipped together makes
> life easier.

I think it is a requirement. We operate with Secure Boot. The kernel is
locked down. We don't have debugfs access, even if it were sufficient,
and we cannot compile and load modules. Even without Secure Boot, there
may not be a build environment available.

We really need the module ready-to-go when the debug calls for it - no
building, no reboots, no months long attempts to reproduce in some lab -
just immediate availability of the debug interface on the affected
machine.

> 
> If the point of the kernel at this stage of its evolution is to collect
> incompatible bits of vendor software, make sure they build cleanly and
> ship them to distros - someone should tell me, and I will relent.

I'm not sure I follow you... The mlx5ctl driver seems very compatible
with the mlx5 device driver. I may be misunderstanding.

