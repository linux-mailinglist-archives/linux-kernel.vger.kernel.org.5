Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7EE7C8B27
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjJMQTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjJMQS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:18:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8769972AA;
        Fri, 13 Oct 2023 09:16:41 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DE0fGH011190;
        Fri, 13 Oct 2023 16:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=l5oT29ZB0ECylXzf+j0WyklKiIK2bKu5KdtpJVERJns=;
 b=QZL9omGmA8KJqZjvQ0gNe/RdSr2s52jCvv0q2x+uEstw16jmjB/qaj/tMIpBQOhD0fa4
 moJf5mwoN0073camhvXIXw50UkjA3BT3bjZPNPsEi+2MzQyhwosJjUAdC8zI6wvLQCG1
 B4Wjq5H2WXkeVicfrZRMlYQdme70XsEwYzlXi3l0AjOrmroNFYBDzQEeXmX4vnX1qloN
 BNSOzUF/1B+vwjHwsEvT3LRxIHS8UI1dLlkrPGKWizcMem3HmJRqMkpCDpGG+svvkw3Y
 R99Wyjpn88f4doVmYiCazIKk6gJIaKBt+pCgPFrTLOG132jm4G45FEZyUsk7tVC5bt4q vQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjycdwfxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 16:16:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39DF0HbC020310;
        Fri, 13 Oct 2023 16:16:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tptcjsw1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 16:16:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBIUnbCHKBdTxa/bZ6TiEStQubiaCHToWVqWEZa63HktTzisc5hqYOxRpsODHQxDufV5Xb9mD5l2e/9DDXp8sRMtMq8jcNO5SXNoQ8SsBX34uTq90F6a8lnfJmCWKrWSmWCSAZQjdmla9298AXKNPPeGh0D0UUDsc88oQIeZQTjJU2GI14ulVJbG0VQnMoTZlTlDlcuSuIz26DWwEkSJvjYlrZ9/s1iIEMUmcVTp0ILhv65uA1CwAruYpSJbDxuHEcr42dGmOBD2OtHh8A1V/T9JhMCw2F3b3yMuk/VCxhp/BUtJwa7Aa8JlQqcGmLMQTdzZxdzpCdGTjQcP9Hf3Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5oT29ZB0ECylXzf+j0WyklKiIK2bKu5KdtpJVERJns=;
 b=gG3OKPru7YaXgornWu7xcI8lxdMxS+1P0CA/C5qNCEyjy5vxO0hQqt3vf9sgxI4Lrogb09kTMPynhGyEpIco8FDvarLVvF3PKN2teXTA0EZQJXzHT65sLGjk6w65J+lOVrFI4tz3gAPwzXypQOyOABR8H0c414vGW8DL3jzsvWi+WJByWxWneFTUQCjKTkPl3qR+0enWL72jU4OwUCNICXIJfakcxUrkpc9Tj0X0ZxeFuXxZf9lfaKoawmmL09TOicgHYPecGgtga6YRBCB8z+WxQ0kcw2uvwqs4/0teGjr53QMR7d+tozoWQViSm8LYfQrY2pehIJyQpTvjLhYzeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5oT29ZB0ECylXzf+j0WyklKiIK2bKu5KdtpJVERJns=;
 b=T3W2e/yZuZQXyaEIcc9lRyxXVZ5xAGFjpPmSmmD4SjQ2fq2Jyi03MNoy3trCra0T+0kgigaW5LXrQX7/6bf1XSIjPuTNsbLvnP8Y3oycsM+P2I4k5gbtreIQKf7rEmU87HOhXUnFjYqwlkoDYUWV5ESoqbsu/Is2XothKcPMdrI=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by PH7PR10MB6628.namprd10.prod.outlook.com (2603:10b6:510:20b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 16:16:20 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::f5d4:dcca:5e7d:ad91]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::f5d4:dcca:5e7d:ad91%6]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 16:16:20 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Simon Horman <horms@kernel.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Liam Howlett <liam.howlett@oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "oliver.sang@intel.com" <oliver.sang@intel.com>
Subject: Re: [PATCH v2] Fix NULL pointer deref due to filtering on fork
Thread-Topic: [PATCH v2] Fix NULL pointer deref due to filtering on fork
Thread-Index: AQHZ/AGKCAsFOxKU5UCM3TNn1o0Z4LBHod+AgABHRIA=
Date:   Fri, 13 Oct 2023 16:16:20 +0000
Message-ID: <49E824D9-6D96-4FFA-99BD-A1301CE351C0@oracle.com>
References: <20231011051225.3674436-1-anjali.k.kulkarni@oracle.com>
 <20231013120105.GH29570@kernel.org>
In-Reply-To: <20231013120105.GH29570@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|PH7PR10MB6628:EE_
x-ms-office365-filtering-correlation-id: 29967061-1bc5-4a7a-11b3-08dbcc07bc7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jkdnsl8YICH6q0O7BNKDxf/Qoy8AgA85BSO41PidhYQGg2btfy1JKWkpz7t61oI04XXVnpDtVOacX2q33jGj719vFd3ZopTUDgVkGt5i7DqBB0KMmztAaP6iWaHOvTwib2N9xcDPW0QQCst/lmkVQMMBSn8ijzNJmEJVmDpfq61nwwDnwbnXpVtW0VKQvwZlfdl95U6Czb/2VaMK+PFEh/jLM9LxygPUToKizAWwF3a9opjBlLyTNxjqVF//8DdIpADxoQd5B/Ob736JL/5GBv8lurIyMNN69qKOOW/s39q6j56uRO64JekaxHQ/qXFB+RvQyf6Uam2LCQEV4+KIJmd+TQGahFxJAu53KDB4XR8xlnmwlmj6RPCi0O6UyB676H3gHhHg5ND/msJUPqxQZTTk9c0OfviJk6AyGilBLOjeZc75pPyqGsQU5ONuNUnNRNugNunoCLgHPlTpdxt6moepmLn6f2tPSFgi9tB4vESYuDwBevK1ohTVJUP9Iys1w2I+pC1fSV9cU2/0hqxIYV4fVlANiQ4SC6dAv1jH6FmtqZRMHZE3jGkSgZeq5JwcUjopjS6NBtpUa3l3VGtBGiycZAf/lAA1WhY3U5j8aSswzlO29B70SQMg1FeadQwzPmcRlCBzRR7U7Mw0/qBjHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(966005)(71200400001)(2906002)(6486002)(478600001)(41300700001)(4326008)(8676002)(8936002)(5660300002)(36756003)(64756008)(66946007)(66446008)(66476007)(54906003)(91956017)(6916009)(316002)(66556008)(76116006)(83380400001)(33656002)(26005)(6506007)(6512007)(2616005)(122000001)(38100700002)(86362001)(38070700005)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R6hzNcpBhaUC6XuW/X9F8SPGZCb+vWPyAgMnf1gY9P0BqaG8qrP087YNH52N?=
 =?us-ascii?Q?8sg5MAwpv3nLoEjmSxeEauTXr14Z9OVZbLg6+UaM721UuqYNxxegFFRc368E?=
 =?us-ascii?Q?C4I2bkK0PDtjNXwEhMvls/RmkiJ2SxIZfxS17W6WR371gyexS4onH9XpyW7H?=
 =?us-ascii?Q?EUO+fQk51PDv4zozU3NNQrn/An0uY3e2XVEDg+jXyjVwnHbKDePMZHFaQPFN?=
 =?us-ascii?Q?KUVdPGhQBFGB9rjGIB9DU6x93HPNgXzyrUdASwmm4lmCzv3adI7dn8C5oOB2?=
 =?us-ascii?Q?1QVTgSjam9ccKkULG0PR8NfodaaDH78DCbZVowIuJjudHpOK7qK4gefPR2/X?=
 =?us-ascii?Q?vqhO9ezLyK4mmDsjKoH1k7ao6tx2Ny6pv/c1/61FV1hhzrVqyWRz9laN03pq?=
 =?us-ascii?Q?9MTaHyzGj/kvQJuTjzpxZO+GXIYbDc5emAoQGhpwDqkAGd6qS3I8wRBjB9k6?=
 =?us-ascii?Q?g0dMpZk+OViHxSeHeya27Rf/4vCgNoyIxdFpuc9Y8iEw0yZafEox4rWUzOp7?=
 =?us-ascii?Q?MzBYfKe+porG8nkGxQc9+lM3e1GORDuetUB7ECIgyMkbYlmV/KULmzHOWNRC?=
 =?us-ascii?Q?d7gxO1J0dCZJ0/miwjpoLpptl+sJJGfFkqFDWQTd6YOX4tX2nhlKzcLwe57f?=
 =?us-ascii?Q?JU8VdqMBz4WomC1KZT5ttnBowGVIEmHFhJwC+Qn6F175KDnIdG1ZgImPtC5W?=
 =?us-ascii?Q?CKdYvhpaS9XVE3RGDpd2t1/CY9NB9oWloyBMF0PfkHUXqTOs9tKAxquUxGp0?=
 =?us-ascii?Q?cs1yz/EcMRT6wkQsz/ISd/caUAxk8XP6MVo3lEq8YDot3HZZa5AFUjQ1ecMG?=
 =?us-ascii?Q?OflwNW7/GFYDW7aAf6x0i3pe8dHzugHb0vPux3qwRQpc0r5o3fKVcVb4PabN?=
 =?us-ascii?Q?zQBwMmZyTguqXR4pm3gRUMJw4YoX9JN/GQ9D8o1WYFkL//pTc8x+vBofwVMX?=
 =?us-ascii?Q?0rNutH6D2nl/uScOKfpMnQMssr3wia9j8A9dAQXM0zqzmRgVg4tf5sTzFuf/?=
 =?us-ascii?Q?IOL4QNdOZ+QdqMF2OlJc50/yHmrrOoSa18sF0dTS0aXKa/wZL0InKTE6wiHj?=
 =?us-ascii?Q?8W28J98c1ikvK+xCcVvXy2G+C6VtQuJtLF9fc0uGZP4hWELHxQHoQ3C1L48D?=
 =?us-ascii?Q?uYlaGzymLgE5gPmyWbOGs17PVW+ExUz7PXrUfhKu2neFvfwYBTTXStlWB42m?=
 =?us-ascii?Q?VyPvb6W6qcZdlA+EpXjw/lMYnPl5NPbVvXh/X74TSNJTI6SQ3sSeTN6y1x6A?=
 =?us-ascii?Q?rufb6g6+N056gf9+Yl10Pd7Uy19dB0Qztyxd5GwxnAcwJ1d/ufBwjHnetSoI?=
 =?us-ascii?Q?Gy0y8Rh/Buox9d60jV+08x4NjbOx00IyjqnzKi4+Ur0wla1DKEEdEdebNA51?=
 =?us-ascii?Q?KHWkW2835pUxFKqsHcnEf5hVoZHZ/A11NwUBo47WTwy08cGsD/PPHqJZ+5Xr?=
 =?us-ascii?Q?iy4cic52p94p6FtYyn6SObRBiCjdzoMTtnfliuDbQc0VnwjIIlie41e71BuR?=
 =?us-ascii?Q?XEZRmxCOIs8yofWJ0PpHZfs7IzdN1Q+iEg1VsOGbQw335k60S6H3nshXgOv0?=
 =?us-ascii?Q?QlUyZfdMo3oZK/6bRBgksZekBCGST8WlgSy2GI3fmBuD5UJ4jQ2Fu5T5r8/k?=
 =?us-ascii?Q?cw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C1A5BDD87CEA1C48AA1CCCB30E915653@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xWuqVbXqlFbpB4++pI/0USFo+AvrcYTXGQwBsAkD0S4/rMgn9FFWhsw96veFrrs/SKM7PfWnPZT4jQhN+Ntz6cplw6V2r7QwSLvmow5654trVlgw+P2Nne+cemoBJoabUh3xPnweX0sKcH9UWkU6Qb88uccB/YM4eRNIEZBhaDm55dcExEbvhw2zyX/eG5HW94YwS6teFDwqdo9wqJNcGB/HeUUqCniEFx5E+lC/cLB4K9kAcZPfJkcF+ZAZYJzTEQ4OQVwDbxUYHtmGBCTACJkPOoHevw/zK4hLa7W6p0TzIqfwEScHfGm0BuC1cl7gixOJQYQMd2bVcXBur1yADQCfMSr3eYZvZ/nN9yMmiRhah6Xyi7MhdW0mKo3bTUn9DCdG82mf49n2So0I3qcf08V5G8NnLf56Lr0dvEcG+rIlxH/6yXV54zO9n7HrRkrbTxPM8AmGAD7NQBIInzMNzea95vMW1BZSjYu92Bwphjfj6mwBB5GERDJhoQB/Detbr0QfRBT/zgxpzMn6UkbP2lJrlx0Moe/5gnRTTO406lX0QWxnL5BkGbPiHzaLxoVNG+IOdudC9/dSotHbYg89NOHHinZTX5N9QsK0uqnJ1kAnuj0+boAuCAhIyGUPqeT8nri8pz4GtD2X0sH8VSfpfcEidgfdob+Pe79YnOXX+O9pwz/tXlhnkU5mQTLXO8Ui7THnu8DEknsdA25y1/kReIsBrPO8pkzHkHCiVwCCGeJczoVHzKjzEwsQ6g5/tyLcNb846Kgr3LTnHkJyu0HhzXbQYTBnrn5oUO0nUjCO7XO2Q3tO0tk527TGzwn4c21K0dux/2vt2Dm2/o6lJqXAd3BUTenHVyB3/1s/7SLdyW8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29967061-1bc5-4a7a-11b3-08dbcc07bc7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 16:16:20.1902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BoLy0uGBBd/Zcpgfc4Oxil5CQvJiBWLV+7ZMGDNYLlhG6SQjbWJgWHOlj81hatT4jGc0p0xiEHwSOaZkVUZDYFxgb+9gd0pM/y3g4ndDeuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_07,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130138
X-Proofpoint-ORIG-GUID: XaleLkES1xdvFAqhr3w7Fq8OEQ_askcS
X-Proofpoint-GUID: XaleLkES1xdvFAqhr3w7Fq8OEQ_askcS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 13, 2023, at 5:01 AM, Simon Horman <horms@kernel.org> wrote:
>=20
> On Tue, Oct 10, 2023 at 10:12:25PM -0700, Anjali Kulkarni wrote:
>> cn_netlink_send_mult() should be called with filter & filter_data only
>> for EXIT case. For all other events, filter & filter_data should be
>> NULL.
>>=20
>> Fixes: 2aa1f7a1f47c ("connector/cn_proc: Add filtering to fix some bugs"=
)
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/20230=
9201456.84c19e27-oliver.sang@intel.com__;!!ACWV5N9M2RV99hQ!PgqlHq_nOe_KlyKk=
B9Mm_S8QstTJvicjuENwskatuuQK05KPuFw-KvRZeOH8iuEAMjRhkxEMPKJJnLcaT8zrPf9aqNs=
$
>=20
> For the record, this got a bit mangled. I believe it should be:
>=20
> Closes: https://lore.kernel.org/oe-lkp/202309201456.84c19e27-oliver.sang@=
intel.com/
>=20
> Also, there is probably no need to resend because of this,
> but no blank line here, please.

Ok.

>=20
>> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
>> ---
>> drivers/connector/cn_proc.c | 8 ++++----
>> 1 file changed, 4 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
>> index 05d562e9c8b1..01e17f18d187 100644
>> --- a/drivers/connector/cn_proc.c
>> +++ b/drivers/connector/cn_proc.c
>> @@ -104,13 +104,13 @@ static inline void send_msg(struct cn_msg *msg)
>> if (filter_data[0] =3D=3D PROC_EVENT_EXIT) {
>> filter_data[1] =3D
>> ((struct proc_event *)msg->data)->event_data.exit.exit_code;
>> + cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
>> +      cn_filter, (void *)filter_data);
>> } else {
>> - filter_data[1] =3D 0;
>> + cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
>> +      NULL, NULL);
>> }
>>=20
>> - cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
>> -      cn_filter, (void *)filter_data);
>> -
>=20
> I am wondering if you considered making cn_filter slightly smarter.
> It seems it already understands not to do very much for PROC_EVENT_ALL.

I could, but then we would be unnecessarily make an extra function call to =
cn_filter, and re-check this condition, which can be avoided if we do the c=
heck here.=20

>=20
>> local_unlock(&local_event.lock);
>> }
>>=20
>> --=20
>> 2.42.0


