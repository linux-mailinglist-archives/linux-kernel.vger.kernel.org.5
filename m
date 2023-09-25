Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A7C7ACD32
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 02:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjIYAlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 20:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjIYAla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 20:41:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB70CC5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 17:41:14 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38OLsBVC012416;
        Mon, 25 Sep 2023 00:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=wop91Vn2thHKTczlqkauN3ZgszKMNCLF+DVzOTx6zso=;
 b=ep1qyqEVmrzBRT2+RbRmWKqmAwDbD1zK6SVv1Cyx5hp27Zozadjz4NnMSd0jDzgyOwIm
 z7/b0IHwKR2t5yvxDOMlmc9mwAWNpqGbQCyecgjCviDtfD8oMMdq9B8KTj/xv+WNo0e2
 EneIQovAVqE9AUMtFj0vDxPmTompUync9x5uAwET24uPpkpY3ikU6hf0ieAsH75ffLQR
 rUjaxuuiTnnzXLa/rkahPQxoiEhNiA7Z1sprZizq4c/ns3p3e4Dh6dlUQ87nEfwuB83g
 b4Y0Ol4eLgtWQJCEyabpZa/BA5IibI432VIqvSWQ0dln/kexKQMGenmZlo/1BCqL/Ri8 fg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pee2era-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 00:40:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38ONoR1C034959;
        Mon, 25 Sep 2023 00:40:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf418em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 00:40:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBWfd9CL4AsBujLRTY4kcV5TUp4jdIs2yZGXOK+dtNLO4B1xn7E4Bls8mtY8VZTCxibSwgGFwd5yAq2h/lmd9qw/4110hF+8wNBtn0/E+rnmCtWy//EyVbmkFKT74ew/ZdNIuF+U/ViZHcznXmMumPMzrt2hfHfkChr8Dl8jPEt8hT+dBloPd8zOuQMNjPPdmH+ZfAck8mZwSsBWl17d0y8cDBmc2fiQXcANYq2zQ9cS17VG+L6B6h8jLWOcRsjOuBpqaiwGPat/HYFNtIfVCft5Ad2M2YFDUO6ebML6x020OZyyLwUQVcWR6Mu2W3JUIszgkm1P57bPqUznArP+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wop91Vn2thHKTczlqkauN3ZgszKMNCLF+DVzOTx6zso=;
 b=GXHR66F8K7zQVewYTa1fh71lfihDIay6xt8k6AgAZsSUE4sfy1eIQsk677+C2vgt6p9b9wmA+iWlupI5pLPr0u+SRBNW1II2lJMJmvb/04sz8kJ7fLCrd1I4LmDCS+n3tU1H9a+4nbR05T4XU1KKeBpQLFzUzwOo1Eklwe4dhz4W9qhxyQwxSoHdFiMkXvcjxuoX9h6rOkhP6N4HjV3Tif21nPIOWFcb0PInR1yGRfnXym8Au0C+voWAxLmqleYiLj/Z0MCW6iYKA4rW1BWpuifAxVgWLlbkHBHP3OXorqWgfkuIwn///DCEUAhXWruweoQMsoEQ7qRVtOTJYATIfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wop91Vn2thHKTczlqkauN3ZgszKMNCLF+DVzOTx6zso=;
 b=gIowThSl/plu+lqovuRlFR2YnBDhEQQu2BEDP/j7M6JKCvrdm69VCU3MglXOQ0nXe21kC61ymba5gYnTUAIVGQgWjBZTtUfiyxI58H2rMD3f2nAKSUDN/+yJ0l058WV1glcr1gKai4AKya8vobHO/FrvK4Pjs6A2ybfu8UVGvI0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB7174.namprd10.prod.outlook.com (2603:10b6:8:df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 00:40:34 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 00:40:34 +0000
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
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v5 8/8] hugetlb: batch TLB flushes when restoring vmemmap
Date:   Sun, 24 Sep 2023 17:39:52 -0700
Message-ID: <20230925003953.142620-9-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925003953.142620-1-mike.kravetz@oracle.com>
References: <20230925003953.142620-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS0PR10MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 850d5942-369b-42eb-e66d-08dbbd6007a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pQykPRYOD8wuYtR72o4E10z24sJrFYeKoV2IbpUqrUUfEjkukxuOEbWJg4w3JPIqWBEKzql8S9V+eHA6d82Az7w8aaKMWkNolH3Rzp6bCknXJX8bLzyPsH8nWvBXI5qQFkkVngoSfE0TMV8PfG+LW8Icsl1ZgDPiqIFP0cp/+NeoV6rcNTpYCW7/ed2n18apUWtFtm+MZyS3yvI1XECCd3tb8iTNYEsuV7n2KHWVXkjgyBillQOKUB04qW4OjMiUguU5ikEpSjjLCbS+hUZgup7YLq5bnYbTumShuRIblEqEdR6gliJJorhPgWdur/rK3WiQMNOy09YcDccPtuzwlN8yD+J7H4Vin7pIh9UkYYooQhCfBD7IdlAyuk/EuApnqyqVh65shnYPfaIRNidrKEHLa5r51Z2S3YUjg0m1lCcPxNCGk/D+EkBMWbdI5szAA9PCkr3v0F0AAGf6Vd7xmfbIjXGcyC0+rGveYyIg2U33WOdg0OeW02djgv0HC/OdbybZPoRtC/h3erpkBMsOHhf9zIMI8oHx9PELk1S6CZ6wDj/+7I5KpD/A6JsKio6U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(186009)(1800799009)(451199024)(6666004)(478600001)(6486002)(107886003)(2616005)(1076003)(26005)(83380400001)(36756003)(86362001)(38100700002)(5660300002)(6506007)(6512007)(66556008)(66476007)(54906003)(66946007)(316002)(7416002)(2906002)(44832011)(41300700001)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tDKvKEUfyS3vqsfjPMflm7+M/+Ms9NnLXCWz2jMAhavmz2C8sJNuujTtWU9o?=
 =?us-ascii?Q?1V/rtn9W+BjZqth8/QoPn75AYLQadsrGHizpRlSgT9MB8Ux3YhDB/hy1W4HR?=
 =?us-ascii?Q?HRPbEd1xKVDD7OTFuyYcptE6rXD14s7n6ksJdx1F0vS7BTG3hg7mitzxtCRD?=
 =?us-ascii?Q?1ZoJGfNobr4iAVNPl7AqlBzHmdQF5epco7MTR6YnFAzXJB5jj3AMgBD6fWqc?=
 =?us-ascii?Q?ne6za5zj/tCsNI2HFDlr2dDaFrT1dNzJKVgm4xB9OsxjnunrQRli9Nv6SBiy?=
 =?us-ascii?Q?FUB6+/CONno29ZOO/KqjKEFkD0PyYqily6hy2/aF8GKCLGrt//Z1bbXKi1c5?=
 =?us-ascii?Q?hP4mWC+1tWCs7okUjVOAc+jMVmqTMVC6/xA0e78DWHTZxFg5tOYqDvFXPuKB?=
 =?us-ascii?Q?97Jb4LyJVY2bcuUzL7PZF/+oTdTWUNidBN2qSxtgu7EcCzNKjxcF1hPQnrCh?=
 =?us-ascii?Q?D/YIHMG9CsIfJ3PJgbATugxIOzwpo9x66oupilQ5JboAYmbSy1IW/OtqGwAJ?=
 =?us-ascii?Q?cd+mHUPoYGTShR0l5p/dblLO7Bjx+XV+IbNPnK1rGI0pNOkYDD2I5taNWwVE?=
 =?us-ascii?Q?HP1h57+hCiddBf4xb2xHEQSgP6O7+9+TzxmDEoT+xxQBrgzUGV2UDHTeKCZL?=
 =?us-ascii?Q?/+1bbGSP61kDrKS9FQN+AARSXvhubhbpdgsyqEXvBGZ2Y7xQL+Rw/SlH6qk4?=
 =?us-ascii?Q?sCfy9fJmX1d07hTUYkJdjVL1WTUMDZaK94/iCVqihjiAcNgbjySSxdSkorpg?=
 =?us-ascii?Q?EIL48TO9CMADdsWezlUr5fzFqwTeAXSexXlFR0/Zo7utzB4uz8GRoMFSuZ3N?=
 =?us-ascii?Q?r9KS6ZQt0boFDtafUMgBWDVMP5NY0y43TXdViPliDeSVz+iYT24mTTV5X8V5?=
 =?us-ascii?Q?GV6LFI/jSJ/0cZxQbaSJpxmzAxYmXQZM8/VzrdxGpLhSVoYgXzl3asC54H9B?=
 =?us-ascii?Q?qRbLCqEecZv7vftHV0DnbRBc0n0PlZbFtu/aefYuk3iZqnx2T/pgZ3oMdCFG?=
 =?us-ascii?Q?L+QopBReYkl1K5Z3CW/Az1SLw2i3FjVOEPTYvLjOPVlOo2UfIO4LWwKvby5u?=
 =?us-ascii?Q?qPE7WmH3MBfVq0/WGKl4EkFUOPCdAqMgEZD4/TqjEtC4Te87wL/dhXsuwRZU?=
 =?us-ascii?Q?4x9ohkJbrSrW8uKGuE7iH6pWGDMrTzSlk3u0CDC0jDraJrO3f+lF0LfCBmJ1?=
 =?us-ascii?Q?wLYHNQnWvdns2vHJn98k/9NmpcUvLPbVpkR2rce6DVJyC5m0jxu7aflqusY7?=
 =?us-ascii?Q?1eLBJFNL53SJEYzdR9xXSzqUIpugFWZn9bMhnrlxz1VyGTofMynppzw15301?=
 =?us-ascii?Q?ips/c2GMZemqYqqp8LihCQWeDN1o0E+4BrBfWM6Mgzv5bbsTQSXv9zxOx3Sa?=
 =?us-ascii?Q?bv6grtr+LVtvYqJQ9iJI9mUWasNXQqGhzmluXrBC44NB/GH5Hl7Z1gqL0evy?=
 =?us-ascii?Q?xERr5VryNUdmT22Jqtwc/fa2JtR0QkNG9kNuKBwLFnijaevG6qaQ517bgUuh?=
 =?us-ascii?Q?+LM1BHeE1SpytQGI1d7voNc7E5cien3bNaPNyMLIGUa2ekUPzekmshJZXp+O?=
 =?us-ascii?Q?K5vZbxwPUAddQ54DDV6qSdqXDd1mCcEkN4Dvs9KS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?YHyqp6+/8bjXPej6JaTFF8SsdO4nCxAGxBsgEbJkTDlTb4bcoQXGC0XpcQHr?=
 =?us-ascii?Q?KRSsmJvpYBhYtPB6cAOe3UhhbIDonpAaBP6di9NCZiSyRISqnNS0I7aRYhCE?=
 =?us-ascii?Q?y1X7xtSeZHIOnM/ooGIyVj20DljBptkgrLizz1iLutuTq+I6assVMnYY8LMC?=
 =?us-ascii?Q?okBTck2T58MlgePPQLxC/NTohGPMNfbXkllCuV+TRvEKm9i6Y28NPo8n1kCU?=
 =?us-ascii?Q?fY607gWl92AhsgVtSbjPZ/fez7ySzMInILf1nkdHvdIX5jcCSJWg9b6PJjyb?=
 =?us-ascii?Q?iiq2mBD4AyRkDCGJlV4BQwmNNn3fr2srCD/NMcOfS9AhfA/kNDC7GY/O5xfU?=
 =?us-ascii?Q?MayDM0Z5XARkx1bFW8Stn8ZZjoMnNsTaPobRhIDmUfw92QGD+u6xX+3HuWjd?=
 =?us-ascii?Q?wVG0D3nWR0jfAw9atSlHxlCGW2sEWZZddiM/FBaCSHvC09nDyMXnO34MsjTu?=
 =?us-ascii?Q?togDGPgEXesX6zcqBHXbDoXqQSCL1p+FnfSecyQdJhNf7SeCk13Bq4qvTwpx?=
 =?us-ascii?Q?dgdvY4TVo4YkauczzYelqA/sptOnpHCd/4Z8Cg7G5Rj2MiPlFBa+LLzyDwDr?=
 =?us-ascii?Q?wAdvU3Rfv10ERCz5XvgnE/wLKcarYtiVhH7m0PqV82FAfnjmx4jOVJ3Zx9XM?=
 =?us-ascii?Q?eqsCgYf6Mn6gWyHFSgT3LxVozyhhbWH1joSJ7vk7JVbjwrrVZnSV97DJi3iM?=
 =?us-ascii?Q?EfvqVEBQ5VyLJAHBUoRyJ6yyHrmWXNoO9a+mfAlUEW0Dfrh5yKSThObU37t1?=
 =?us-ascii?Q?rdVh3NsDqeifR2aJ28thhxPBVc3cRnX0f10RxNjgy5qkibA8VQOmtWAMgHJf?=
 =?us-ascii?Q?sc8sfmNcHQpCh7xfsCvIKFiaHxuhHuwXLZXZJuOXopGUwjfXk0MKnEF3+Szg?=
 =?us-ascii?Q?fgNe1tvjxHuqgzgOF/Th18oZ7l4LOW4RMMZYDNRPiLJjCGgVxEHscOpRsyjh?=
 =?us-ascii?Q?jj03NVPauyQ0ijI23mwigUcMktd8cP8zjszNLQCWzDui0SdTx5Agv1P/qWL0?=
 =?us-ascii?Q?FLAPVjZIoGp1PHDFRXGFzCQCD4DOqNia6i1Horzmui0I/cfu7gIcHt8gY+NT?=
 =?us-ascii?Q?Lxqi64S3RGKm3343l2bGLx82ZpVJF9NYMJkAdPGjVm1FfgyaNfIgLjFrSMVa?=
 =?us-ascii?Q?17RU6nZfdcXU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850d5942-369b-42eb-e66d-08dbbd6007a3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 00:40:34.6878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3paTb7dxTRgo759+XdEXmKnAP2aiveNoFdqXOPU52e19++MtE64aHco9zRP3MyTub9YFp8Uki6hy9XYIOZ0rQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7174
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-24_21,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250000
X-Proofpoint-ORIG-GUID: pSbux-Z7blrrWnBynn8BvvvvUoxkzByW
X-Proofpoint-GUID: pSbux-Z7blrrWnBynn8BvvvvUoxkzByW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the internal hugetlb restore vmemmap code path such that TLB
flushing can be batched.  Use the existing mechanism of passing the
VMEMMAP_REMAP_NO_TLB_FLUSH flag to indicate flushing should not be
performed for individual pages.  The routine hugetlb_vmemmap_restore_folios
is the only user of this new mechanism, and it will perform a global
flush after all vmemmap is restored.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb_vmemmap.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 9df350372046..d2999c303031 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -461,18 +461,19 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
  * @end:	end address of the vmemmap virtual address range that we want to
  *		remap.
  * @reuse:	reuse address.
+ * @flags:	modifications to vmemmap_remap_walk flags
  *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
-			       unsigned long reuse)
+			       unsigned long reuse, unsigned long flags)
 {
 	LIST_HEAD(vmemmap_pages);
 	struct vmemmap_remap_walk walk = {
 		.remap_pte	= vmemmap_restore_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= &vmemmap_pages,
-		.flags		= 0,
+		.flags		= flags,
 	};
 
 	/* See the comment in the vmemmap_remap_free(). */
@@ -494,17 +495,7 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 static bool vmemmap_optimize_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
 core_param(hugetlb_free_vmemmap, vmemmap_optimize_enabled, bool, 0);
 
-/**
- * hugetlb_vmemmap_restore - restore previously optimized (by
- *			     hugetlb_vmemmap_optimize()) vmemmap pages which
- *			     will be reallocated and remapped.
- * @h:		struct hstate.
- * @head:	the head page whose vmemmap pages will be restored.
- *
- * Return: %0 if @head's vmemmap pages have been reallocated and remapped,
- * negative error code otherwise.
- */
-int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
+static int __hugetlb_vmemmap_restore(const struct hstate *h, struct page *head, unsigned long flags)
 {
 	int ret;
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
@@ -525,7 +516,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	 * When a HugeTLB page is freed to the buddy allocator, previously
 	 * discarded vmemmap pages must be allocated and remapping.
 	 */
-	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse);
+	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse, flags);
 	if (!ret) {
 		ClearHPageVmemmapOptimized(head);
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
@@ -534,6 +525,21 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	return ret;
 }
 
+/**
+ * hugetlb_vmemmap_restore - restore previously optimized (by
+ *				hugetlb_vmemmap_optimize()) vmemmap pages which
+ *				will be reallocated and remapped.
+ * @h:		struct hstate.
+ * @head:	the head page whose vmemmap pages will be restored.
+ *
+ * Return: %0 if @head's vmemmap pages have been reallocated and remapped,
+ * negative error code otherwise.
+ */
+int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
+{
+	return __hugetlb_vmemmap_restore(h, head, 0);
+}
+
 /**
  * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
  * @h:			hstate.
@@ -557,7 +563,8 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 
 	list_for_each_entry_safe(folio, t_folio, folio_list, lru) {
 		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
-			ret = hugetlb_vmemmap_restore(h, &folio->page);
+			ret = __hugetlb_vmemmap_restore(h, &folio->page,
+						VMEMMAP_REMAP_NO_TLB_FLUSH);
 			if (ret)
 				break;
 			restored++;
@@ -567,6 +574,8 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 		list_move(&folio->lru, non_hvo_folios);
 	}
 
+	if (restored)
+		flush_tlb_all();
 	if (!ret)
 		ret = restored;
 	return ret;
-- 
2.41.0

