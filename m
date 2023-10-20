Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DF37D19A3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 01:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjJTXaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 19:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjJTXaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 19:30:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6407D46;
        Fri, 20 Oct 2023 16:30:12 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KM60Jt027730;
        Fri, 20 Oct 2023 23:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Nbt2HdqgNwvO5E5F4jhQ9qPrY13LFr3w+hqxUdjFS1M=;
 b=kfEbs9cQo9DcG215xDNIdgY1yfxptDNRzMWtciuMeLbEHWLTDA9PLUm5YAwTD2pbLJLj
 1M/jNJqwPzpsb1Bg+ZL+XWGnFhm7j9lMXqgVWUz+1e0MMMufAlPw2LIP3H/nUbBJAG3G
 56snG20ptW4Jjjz+VrggJv8YFudvnI2uUooQH7eVbFdidKLSIKf1lKfOuj+THto/9sLN
 hN36nBnq6vDesbPtvo88gKsuMCR8CStNB2dkjVv/vGe96z/2JH6pANrIO49VBCONAlcm
 UId9Qe0Z0LfM5mXkMukj5RZ+QLzR9p4X8Zd4eh+yhrNangLJwDXG9+gWqceDNLnnTe4u wQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tubwajtws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 23:30:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39KLgkZQ013957;
        Fri, 20 Oct 2023 23:30:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tubwfvtje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 23:30:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkAQQWlTIV1JLAfPQ5CRAHVfverVaT5ilchUrhcmFUlZ+MZPThllYgXIQ0410MdCqSkj7K3H14GeJFoc92kLNxCdPemHSl8ogiOu9/k6zV/5IQZ7zlbHWCrZGdhzo9bxysi0FIii9h2j5iRvdKUTqcW6hSEKFuRhFg5mSaMnyp0WUJwXk4dZZYckqHyEkqqrn7dSJXiQzBVK5kAfYLGlL0+I0/Gohw4A9hOW/dIMYmSR6uIX7OyWJNQ1iPw3cuL9Qc0w/QVchsorVqTKCx25Jrc2XWjgJK8BfldH6w+3+WMVvJM1l05qqZryNhA89LUKi9ebgUm1U/2BcyT9d5BLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nbt2HdqgNwvO5E5F4jhQ9qPrY13LFr3w+hqxUdjFS1M=;
 b=Fcu2XsuaKB+fHJY9eKlS/Li2vNrbkEZiCbM1loBKkCgjqZ0V0/I/nGjwfbk+CWC5M2V1AW1rJyS4sF2gWl1H2WzrGAhZGvTj+MtM1ly27ODz6yAaXgMazUdAySMLUqRlw0cyrnHTVDASHlDL8LRj67NHTho3pyDF+9yBmc/9+sf2vaYAlZFOrwFNG8j3cl+zc+pqJ/6TGTSQc9ap6YRquEEFFO1LBbMJnQLPFAWsOt2SZRJOiLD++zdanmsT+6Z/1DqsT9VxLiGfjQ6rvQwD7J6I/NhKKw35s62bmJbND3FLNL6dUSC2oA2UEklQzpw8yWB3PeuvY/u9lxvabEk/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nbt2HdqgNwvO5E5F4jhQ9qPrY13LFr3w+hqxUdjFS1M=;
 b=MkT4EJYD2TqDdTHfuc/JALpEnCn+zBKi9GedvSOFYf4Wawvn8Ac6ugDX1j2eYgw3QhwXN/RaLBWgMGehSPz1Su0udd0jzPSqAoZH/qx2Gost75aIfsBO6Tp1k3RaNNaJdqvWIpGIYdiTmOmYoigBZaOzpBv8GZXI+Rp4VLj/1cY=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by PH7PR10MB6506.namprd10.prod.outlook.com (2603:10b6:510:201::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 23:30:02 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::f5d4:dcca:5e7d:ad91]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::f5d4:dcca:5e7d:ad91%6]) with mapi id 15.20.6863.032; Fri, 20 Oct 2023
 23:30:02 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Simon Horman <horms@kernel.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Liam Howlett <liam.howlett@oracle.com>,
        Netdev <netdev@vger.kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Subject: Re: [PATCH v1] Fix NULL pointer dereference in cn_filter()
Thread-Topic: [PATCH v1] Fix NULL pointer dereference in cn_filter()
Thread-Index: AQHZ/ih9jUSSRZynuUmcpd9TV4mzXbBNpCQAgAW6LgA=
Date:   Fri, 20 Oct 2023 23:30:02 +0000
Message-ID: <6C29584E-AF58-42E0-84A5-DE2F3FE49F16@oracle.com>
References: <20231013225619.987912-1-anjali.k.kulkarni@oracle.com>
 <20231017080210.GG1751252@kernel.org>
In-Reply-To: <20231017080210.GG1751252@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|PH7PR10MB6506:EE_
x-ms-office365-filtering-correlation-id: bdd3f763-d259-4fbc-d52a-08dbd1c47bee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HbIQHg860Jsml7NEWY3EkQLWM3oSTuCO/CDBGP974mdUCgmW7s9EHcrtHRj/nIT/WIAVYhkG7ANpiTRtAkUknf3XcGz1AwJyGDmZUAEDQIOStYDI6eFQglEMjioWiU8BrbgluUyOerB3IQYxO57WGYWle4etjYDkSKilFj3WJyc8tbVQpyA9mtXFw2t2vRf9xDPoFqRrPi6ErPZN5o8S6ZzIAODxJHGk2/I1lqgj2LIyS+k6YfqAvqQfCacU9nKggk3qbRTlFrGnkz8aU27QaDwvBFvRSTEfrBlWPHNC9m7g0ca8LmGl2EjRbTfHpwp5KwH49aSawQ7W6ZXLn0YFLJ0vbtlh+6SKSUcl1/JtiLjqg7h3fXOS71T5y3QQGcz/WASCdtYZvA3IH1/ScD6/5U4vGu/t5S0d29P4DN2I3G6P1NqBSuJnBYH4iuTdYNE5tYUEM/QYH7R5doXl4bf4QBQvFCUbQ+Vww7SOcfDJCTm4yRwHrN2B0SFL7/06xdGAyQsYaaOaRjHZ3Y4H51ZEcBxnhevueslrDz3SclAGbB/tLu8XnqvUoK+CZnzNkYxbZvMNHhBrICtwazgpvth7PvkrkH3VLgE/aS2tlp/jh0Cak0O8Pjp3NgpAp7atN1xspbeTTbrp9lg+gT6FW45otTqhtKibULuDXasxRXNcRmQxjzFyq95Hwuk6rid5YrXN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(38070700009)(26005)(38100700002)(66899024)(83380400001)(41300700001)(8676002)(66946007)(316002)(54906003)(5660300002)(8936002)(4326008)(66476007)(66556008)(2906002)(86362001)(76116006)(966005)(33656002)(6486002)(66446008)(6916009)(6506007)(53546011)(71200400001)(478600001)(107886003)(64756008)(122000001)(36756003)(6512007)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lKsn1iV1T8zHopNBhuxP4lEh9Kc6pT23utXJULyfyPP1+lismYjiOvStcPQh?=
 =?us-ascii?Q?PSsVRik5Mes3roil8/Lm8ISQbAwIFiFLa0DNTIga3pJ2g/XNFpQktPoBRCFp?=
 =?us-ascii?Q?eYwIcGFXQPXYjaropEKI24UHAQkFPSZa43mE7Yk3nEf1MR4g1CdxG6ndfllC?=
 =?us-ascii?Q?902VWuiaImMi+f4om8XUVggqJOnMDzplpjgoGaNrdWjDApAiT8iy8AoSMJt3?=
 =?us-ascii?Q?Zt8EmRoX7S851x5A6TL2XiAwi03BjBIAPSP8gf/6sHiuFLjUCFS+h+pnMK/5?=
 =?us-ascii?Q?NYV3Bje6ojNX1EuJgmHbxaY1tQLKyuGUs9/ROjWHfTEWNdNscNQN1CIFHJPN?=
 =?us-ascii?Q?9IqR11CptpWCcPBXpXF2MbJcdLGKhOoHM2D08Lb0f2YQz+qkC8ebi+jOGtDo?=
 =?us-ascii?Q?GQN84vknTYrFBecyw5GOPaxxTRr3gKUWMHQPuXWFQr4+qZKXzF9F5/WxDeB+?=
 =?us-ascii?Q?GM/gPbEZUkulSRxcST/pcAVK3gWgXas+SboWZgRhsboVjtOcCz+S/UGxqdv3?=
 =?us-ascii?Q?9JOT4piMnce4jizrHyBL1Yil5kPazCWV5Z4H4CPNw2Vna30kfF5VmFYkhbZY?=
 =?us-ascii?Q?SPNd7cKijfX0XAHFQXFpdfPwlTibd4wl/eGrEOT/O6mvRokrO3vMwOQnGZ0G?=
 =?us-ascii?Q?mfZTJtWDN5l4qFZaKCTUTThvQoF0OmUmmJCn9HUAoPH/mEwc/8tqmKkPW+T5?=
 =?us-ascii?Q?TQdYOBciimA59IKr+nErHMytG8y1/l/kKwWb9dMmEb0Cr9wOlJrp737mQIgy?=
 =?us-ascii?Q?TA6O1GnHcx+o4vtG5ABOnRHPTcES00HQuJgVvh+PU6RMsRiupB2QF9pPREe4?=
 =?us-ascii?Q?dF4AFBVxIrMbA0TcnPheAYCaqokm7oCA/0an8/6O2LUlwiC95762wkW017hI?=
 =?us-ascii?Q?xrBbt0Nefowgwhfg+t607O26QQ66clL2JWhWLLza6TpwsB5uc24f8k+pXAGR?=
 =?us-ascii?Q?FLwlOiaX/EXnJ6wXgZrl0Ro/bjstjEWhWm8LQlWfr8PeLLPCziqV6qfYHVXq?=
 =?us-ascii?Q?FybEFNfyM14sdYyU38II3y7n5p0s37PpH5ha4yzfyqLKrCP7Dks/or3+Z8fk?=
 =?us-ascii?Q?oREH+uBbm/8nxIn93ua4UIgxglHMWg6HnKb19ovxIe1XUjVyaXZXWDhCFFhe?=
 =?us-ascii?Q?mXngtjyZxx104a0KLms0/Jwz3WYufX/9/p7X9tziI7hJUSibV3Alp73Bo+AI?=
 =?us-ascii?Q?eyY8l5xRbmnpFxxonUzoB3eHe53qvT6xk6lVJZJv564Vtzbbwhmpw7r0qxDA?=
 =?us-ascii?Q?f/MljSBBtGz6ntNXdQ76POMazwnWAoYSdNegMtaE9uXNSZoY+J9N2YlUSRXt?=
 =?us-ascii?Q?Q3WRCtmuwm87DVXxpBXrQ5hH0p17sqdg3YuV2AxsUpy84H0aHCro7Kt6TVU3?=
 =?us-ascii?Q?byuruvNpSZjJDwP66WZ5Qpo2ccf9feEZB+Q6A4G44IrzENk7ZgsNXawlzqyQ?=
 =?us-ascii?Q?zd57oVui+fefzCjashQHIULuyA935CXQ8somTmMpibabd5Yl8k0g4dczV8cd?=
 =?us-ascii?Q?t9qK7gxZ1+zSXvMNsBdCWXPjp6ssNiVLuo93kQYODKS499Ir0nNKRus5fl9e?=
 =?us-ascii?Q?e8McA/fx0iafa7Ij+iotO9Pw8le61beOKGi+ZGxAfCqf1e94KN3yoQ2isVOe?=
 =?us-ascii?Q?ZA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F2AA941A9EC0D7499A770686118BC100@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: k13g98cGnd8FcW7IIouX6tW07BcmauSAe+AjLlbz2kKZzkeaeSsWT81D8wz/6AFbmjrA5KSNSvYjoVUU1Fjc8r0KvUURZRxJfdp4mdEP374DZIVhOHaWy4A77642nSNWMcgME4/c4Cj2U4F24BlmjvyPWW3wtcpnPJMUvpUPnBLCTnGuzGOkZPfWsBHE/B2Nl7LKjcMicTnGrw5cUcrfXohjOZOFGzJdNRBiSxocRdcqqDTE78wkv2+xV0BlcbmJzzZOOvXRGTWqebEPzzn2HCXXQ3rawa6xOFdGcmImcJwv2gQ6miVyv0JedzcKt5GIbi/9ppdITGGsbq0AxJeLb4QhLT/tf4oa54Yj25riFnRJrl/uj6Uqd7n5BN7aFvw3XKNhdH/DTvh/xJ3GkYGMyLcYsX6HSaGEKbO9H7bk3LwfuT8VH4ycZqL2XS6mkC3WxWdUBIkQoauyPxXYpdDKtZdwnNvMhNzx5+w6Z4L4/meAA3DpB1azP7oAjWcckrhU5Bq1r3ol0mbmA8hnCbTp28ui0KOXejhtrQzxDeN3UkjxoIG6b5IHESZWsNQHD8kVQ8NxGanv92KBAcQyW6bpg1/UFax1OQJXz6hFsTrwaN9I4owJRmlteECNxzbc8XvFrVBt+sxwucbEkKPolVMB1LVolKIgrNx7iJN20E9ezC/6xfMbuZoFjoe23icVn3zl5ZkiQsUxxdo1H8hKoyACxXh8b9oLJdhHdkACbCP7MSnHTWBK6e8E7zvfSj3W04+AuwgateQZxF3DNfVteRFhMNG2xObL9ijhYlFaG10hSn3hUlDtludfB+aXnJNs3vCYW80QlKSGD3ye2dQeRWj4PL6aGglAQioaFcTAqZh07s0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd3f763-d259-4fbc-d52a-08dbd1c47bee
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 23:30:02.5958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXgyO0+S/VOPqwkqwUJKmjeT/0LomWIipIe6KzmmCligm+ZtFt/F5A/eUue3nvXc+QGO/c6V5QCt6Hdd0YYc2XTuPbOONTwVDYo0m399YlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310200200
X-Proofpoint-GUID: teKnHRHzu0UykFC57-fDA2BQ2vUVn1K9
X-Proofpoint-ORIG-GUID: teKnHRHzu0UykFC57-fDA2BQ2vUVn1K9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 17, 2023, at 1:02 AM, Simon Horman <horms@kernel.org> wrote:
>=20
> On Fri, Oct 13, 2023 at 03:56:19PM -0700, Anjali Kulkarni wrote:
>> Check that sk_user_data is not NULL, else return from cn_filter().
>=20
> Thanks,
>=20
> I agree that this change seems likely to address the problem at the link
> below. And I also think cn_filter() is a good place to fix this [1].
> But I am wondering if you could add some commentary to the patch
> description, describing under what circumstances this problem can occur.

Hi,

We always allocate sk_user_data in cn_proc_mcast_ctl(), which should ideall=
y
happen before any fork event is triggered, which ends up calling cn_filter(=
),
where we need to use sk_user_data. So in the normal flow of events, sk_user=
_data
should not be NULL in cn_filter(). I also looked at whether there were any =
race
conditions which could cause this issue and found one possibility - if a fo=
rk
event was triggered between the time that the bind() call was made by the
application (which ends up adding the socket to the multicast list for CONN=
ECTOR
maintained by netlink layer), and the call to cn_proc_mcast_ctl(), then the=
 netlink
layer will try to send the event to the sockets in the multicast list via  =
cn_filter() and find that sk_user_data is NULL.
However, when I tried to reproduce this case, I could not do it by adding a=
 wait
between bind() & cn_proc_mcast_ctl(). On looking at the code, I did see tha=
t
in proc_fork_connector(), we do check for proc_event_num_listeners being gr=
eater
than 0 before we invoke netlink layer's send message, which calls cn_filter=
(). And
proc_event_num_listeners is only incremented after sk_user_data is allocate=
d. This
is why we cannot reproduce it this way. Perhaps there is some other way I
am not aware of, but I could not think of anything else.
I will just resend the patch.

Thanks
Anjali

>=20
> [1] https://urldefense.com/v3/__https://lore.kernel.org/all/2023101312010=
5.GH29570@kernel.org/__;!!ACWV5N9M2RV99hQ!NNsMHaho3lyW2NyoT8Sju1BL78S5pNu5A=
htZC76cc1Xb1_psXwfP0lmVtVmTxGRrsQkzClWNS8HriosTMols$=20
>=20
>> Fixes: 2aa1f7a1f47c ("connector/cn_proc: Add filtering to fix some bugs"=
)
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/20230=
9201456.84c19e27-oliver.sang@intel.com/__;!!ACWV5N9M2RV99hQ!NNsMHaho3lyW2Ny=
oT8Sju1BL78S5pNu5AhtZC76cc1Xb1_psXwfP0lmVtVmTxGRrsQkzClWNS8HrirVfNms7$=20
>> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
>> ---
>> drivers/connector/cn_proc.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
>> index 05d562e9c8b1..a8e55569e4f5 100644
>> --- a/drivers/connector/cn_proc.c
>> +++ b/drivers/connector/cn_proc.c
>> @@ -54,7 +54,7 @@ static int cn_filter(struct sock *dsk, struct sk_buff =
*skb, void *data)
>> enum proc_cn_mcast_op mc_op;
>> uintptr_t val;
>>=20
>> - if (!dsk || !data)
>> + if (!dsk || !data || !dsk->sk_user_data)
>> return 0;
>>=20
>> ptr =3D (__u32 *)data;
>> --=20
>> 2.42.0
>>=20

