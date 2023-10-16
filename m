Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9AC7CA6E8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjJPLnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJPLnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:43:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A09E8E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:43:17 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39G6msCr021166;
        Mon, 16 Oct 2023 11:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8aJLe69LdK5dx8JvcdGLad/OtejF3a+9ja3cEUQnOaA=;
 b=L0tLM40QCogaQxXTduh0dXOGxdAvYj2mc03Icr38xXoMGDzHDJpzb695+QpOUFthr8Vw
 0fwJP6tfPIoBHFWKlq0qyrI3d3jNC6Ah62zQs2mJyE5oNVmKyiDpSniDZ3pRdpJUnPKY
 J9sHDBU6w7KksOYAJh8AuMs6+PNxeeLjqNpAzbY+2vAjy2QwvIV+hKh3AzGgOgST8dXT
 hDCvBf7oV3pmSSgZP8wqp5Ce372nYrc/GbwxWejCosglHYgMVsJvEIer908KrC1Gkfqn
 1IfRYnKME+NP6ileD2bmQCavKhTU5Kws2ZmmNSwstz3E+cel5G8QVbbOc2x5fhm+XbA1 qw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk3jjg55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 11:42:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39G9UR24009809;
        Mon, 16 Oct 2023 11:42:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg0k8c75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 11:42:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6VAe2a1/u/Lat1MtqVJ7FfhGuKnGg2mnTStDwdDnJ5jv1Y22NfhpGXoos0aps0KqC8/XvtRbqXt54H4Sm0KzCvIyI2o+5caJ1AtDAx2ZHDbMs29rGtFSTTlI+yl+1JwUuKmKx+l1VVk/tgWDxHjsgG5VIQEp7PYOZsIukGbsdDbeIdnW8w7qn5d2bk5SrDP67qQTfSjBAByn0FHFIQjOi7AcYFPFHgxMQD/k46+iE7wAURGmXCttlnP94iECWTOX1s1zvwWMG6ys9+aTGmDHZU8ck49GXusDBKKlT6rcyxhNKT+u7Hf2rZnsss2c0DJlGcY8FDtGwaS4oOvTeWI/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aJLe69LdK5dx8JvcdGLad/OtejF3a+9ja3cEUQnOaA=;
 b=NYptqFBqVRqn1jJhqBkYMqOJ44q+KZbGxwmqLEJTHWI8h34izTUTotQsVjcSWG+8RMq1aWgeTKR1SLrtrtzFoHA5Xrz/KwGGMuyVXoojrkRf6kwifHa6fy9N3cHec3soY7lKBEHrkF8e3/hJbhq4N8Oq5n6q1LRnSHARCLzRJrBGAm6hwRCRpyGICz8a870i6FV5Lzjl3SR+iiWHINbOrE4gtMF1RisBPQS2l6o1ISZxPKnsK76zuBXCUaVWrSyX04F8PABGm3/KjKc/C8y3qwV66KxnxPR1X/jn5pwLYJFJIt1mFj6I577GDUAp5neciQr5VvN+dewr8De3tICc4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aJLe69LdK5dx8JvcdGLad/OtejF3a+9ja3cEUQnOaA=;
 b=SDehJ3QAvda7XRt4mQbPdjB+qzy2/XM/jt8sJWhKpSENsvsEN0LfIBLbyBsOdlLf34f1zXYx9+ys5eXJYqPXCxlzxoK+jtodLGP2OJJocBW19LpbysE5LC3oJh6uYBVWGJZzC3qdkv5xWuMi+8tRXJLMWVlyu2kJoCB325VOzCE=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH8PR10MB6314.namprd10.prod.outlook.com (2603:10b6:510:1cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 11:42:44 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3%3]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 11:42:44 +0000
From:   Miguel Luis <miguel.luis@oracle.com>
To:     Eric Auger <eric.auger@redhat.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Jing Zhang <jingzhangos@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>
Subject: Re: [PATCH v4 2/3] arm64: Add missing _EL2 encodings
Thread-Topic: [PATCH v4 2/3] arm64: Add missing _EL2 encodings
Thread-Index: AQHaACJuFh446OF1ik66gL8ScAAqGLBMSGWAgAADCYA=
Date:   Mon, 16 Oct 2023 11:42:44 +0000
Message-ID: <18553105-45AE-456B-AAE5-27D462998F55@oracle.com>
References: <20231016111743.30331-1-miguel.luis@oracle.com>
 <20231016111743.30331-3-miguel.luis@oracle.com>
 <a067660b-7ba1-9a23-0b56-9fa4ada5db0d@redhat.com>
In-Reply-To: <a067660b-7ba1-9a23-0b56-9fa4ada5db0d@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|PH8PR10MB6314:EE_
x-ms-office365-filtering-correlation-id: a8ca2112-af8d-469c-a3a3-08dbce3d030f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZJAGTIYjSGIBKmhI2xf9E1/oQo4jkjbjyHKvRI2ZaZhE0QJ6DA1LbjCrctmMZb01O1mCtKx03nUkw+nMVzF6dUDXCn+RfiyO97GmIUIsA/C8o/KhkIsHh5omeO8HrShQvX99o7xaJ/o50fL1JreNJRmS2rVlE8yV8/yaDZUXsER3usq/xx8ZCy+cA4qxqpPx01baNDt66Jg/VVKljJriAwrsJ9u5u4Bu7TahIQf7rUU0JjJVyUCP/mJr14gKG9G4Vms4SQEcmdj8455UzCOQnvYZowECjBspDr5gAAkgK8iWyA6olYHefxkW+AfP5xbieQq7hQNi5upnU8c5eiMzjdisN2ofW8oF3R5Qdnkq7+fg1/V+ZdvoPuba+9qu8nkwPujdRBuOKb8/w7KEV+t4Qr+y39780cuy7YnqfhhIdQZT4k0+oH3AbXzS2GPPZqVeHrk3Ts50NQRWuIDyIOfCGoaXWxeC6r47KV92o2SfhcJVPl5bFVuGNba4laNtONEUJljCs/PuL50PTIudKa+SjBvC/xRXHqKlj3lDPks4nzsgZoxYy23tCa54XASkJ9Cd1yMneVnoPX1AnuohapvNoCKEhhosWeAcI2xU8L6OMJTB09/05xRJrFKipbEXjfoPpaQqRExzNzraWdrmQ8YWbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6506007)(53546011)(2616005)(6512007)(38070700005)(38100700002)(7416002)(86362001)(2906002)(6486002)(5660300002)(44832011)(8936002)(33656002)(71200400001)(6916009)(316002)(54906003)(4326008)(76116006)(66946007)(66476007)(66446008)(64756008)(91956017)(8676002)(41300700001)(36756003)(66556008)(122000001)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M3ifQBvHPgEhpWc9KjcQenaW/EAG02pggqeWb2aDkFIAS/MJxps7x7Q6Njxr?=
 =?us-ascii?Q?/LkknBEqDt3PzUlq/CWTLCluURdgT6bm7WOn2K9D+aq5U83+I+gKEMLb8o15?=
 =?us-ascii?Q?zpdvJoPQiBOW1u6+GEnOK410EzbQ4XS7d69A7jKSEPGw+iDPc7aGWCtwRClR?=
 =?us-ascii?Q?PzkR2gpEA+jSim3adm2BWpafBStJSpC2DwWoMI8/YzmPqTQPZ7CgAZ8Hh/ec?=
 =?us-ascii?Q?juhASAkjhRUPkmDvGTBeR98kVJs+x2reneK1TijM1zJaDtfIgYZ9GjCuZ0Hf?=
 =?us-ascii?Q?X348VOLBCUKPuSSbekmn/f6aSCMoJhg23XffkjfTc80RqVYwKuGXk+2uECWt?=
 =?us-ascii?Q?82cST8zHviWLqXlYOa2dUv3azMEqRTYsEdjJSGUQ2JDxtt8pYr5ybT5Td9tm?=
 =?us-ascii?Q?Ag7uaqacv+NDrdDN4ccHWoeqZpFHyQdVnAY3ubQpJqNlDjL4vAEBSppJeipd?=
 =?us-ascii?Q?iG90JQ5AQ5SbyqFkf3FdAbHcVfiXIwt+jZznP36KPC6yAFavz4NHIlDxGrzM?=
 =?us-ascii?Q?hiqmfEw/+IPBGV5htPeFfyC2/LQlIuIYkD9Yq/ArMJWKmvfN/eXy2/AThdCb?=
 =?us-ascii?Q?FqxMYIVHxcxvGWqwvirzgpwQlIdwmeMLcAygzascTfv2AtJRWlo2oJtYJNcE?=
 =?us-ascii?Q?KRsk7jaxMofEpgwjwfpe8rwaUPe3fmx3zHpcba0HMTF/ZK4twwgDaS+cKJPQ?=
 =?us-ascii?Q?I+BpZTndE5mJX65X5JxMdSnTMTQwLh+t0qeE9MizvbSxVzNvwZt4hCXh5j1I?=
 =?us-ascii?Q?freeQPSjt38vVOKo2eBqwCLWJeA2Ec5RVc9uhnGwUzwibdg8iYIs2oMXyE5v?=
 =?us-ascii?Q?TEFJx3GmU0iTKP/JyAvkqqXZvP4wRY2LozBXPZR8C1KVlk64lGz37Iu6tha2?=
 =?us-ascii?Q?dD7wijN1/j+gmsXwZaP4SPIJiWs36uN1+Cqb1Zc8m0ADOOeHzoe1UJSiuLxg?=
 =?us-ascii?Q?jGkaOCb55UHa2vMNPwJrRyj12X8KFeU2de51Yz5nteAN5JvYbwGzZxZpF9Qq?=
 =?us-ascii?Q?QJfsdUNaWFHkqGR0gOCsA5iEb+kVXuls7+XSV0kURIpvXXxHlgPhk25xeS5i?=
 =?us-ascii?Q?NUDmPWOAwUrnuRhd9lMFElzV1ifO9WxrHR1vkkzBAH4L3Ec21ppGOAYPTgjr?=
 =?us-ascii?Q?LbyimKW4D95EqZu32kkpXl2wbWlch2j8qwjWFt8yKVQwLFIoXyaH6PpCkPIV?=
 =?us-ascii?Q?UZQYZ6+eMAtT3vneIelW/NGYcDkgEAQ8RHKd6oIv62vOj5eFS6elTMTJ5Iri?=
 =?us-ascii?Q?by0fA09GEGoQk0wV3ETYJF8CQ+vE3rI5jmBWRmnw+ziuv/RG1htw8YFk6WN+?=
 =?us-ascii?Q?JctKue5NsVI7KzvoVRCwox9YVbTwgu3TYdZ2eCEPX4HRtNWgzcAgDKCGxZtX?=
 =?us-ascii?Q?B3JV2GJXjfhINKsxXum13i+Uz0JcgiyNCmGiUPvJZgXFM9ioFz3k+ZOalJRi?=
 =?us-ascii?Q?FWo+Wsauw29O2BXAerI9Uu+SVapCiU+CWwOLXY+pnBpElagXkv7+sq0voyRK?=
 =?us-ascii?Q?/Qh6aPwAaAnpol32ekFqGsyox8HQ+Jy/yrb/OU/Iy2oBFkHt5Nh4UOT1pUfy?=
 =?us-ascii?Q?ifL5W1ljLjJ1eaMdfWFnRuQ+xW11obLOqUoEcIXiviRYrDZ6UzKFeADuYdn1?=
 =?us-ascii?Q?KHj/y1yHbEOvzQ6z/VOS2bE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7BF6C9152589AF4294DD61E4D3D6D3F6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?F6OLJVd49UomiXPMLujg5QnaSsZxMwyDHkZzxbDR91FDw23Sk9bsDfuz1Og5?=
 =?us-ascii?Q?NGgBGMr4TyMWpXDYhQzueh8DzFjkr7voFJuS5ffyG+TPV6939NpVN1nHHmYB?=
 =?us-ascii?Q?yjfYn0HFu5d2CisjS2xrFufFNTn5ZFvvcGVGg9iqj1kQmXw+O7Kpx5DMNHbs?=
 =?us-ascii?Q?/kE+/R1dmPZks3wXQIrbaIJoYeDDYxYsoF6lml5pgWvRJDNZxrsgLkhhiVHV?=
 =?us-ascii?Q?9vCIF9okNAH0C5NtdqaqRALTzDiEr/Zj2ypC0TuhgggPtg3TMSKTESf6XRGp?=
 =?us-ascii?Q?lSajc0NSyWqwuNJ2FyPjvie467D+Xd2/WpZ0vBZWTzBftS6t3uTaCC+X5V42?=
 =?us-ascii?Q?Md9YWogkNxVSct3PaLoxIxT63kPZhAIclzAJZvr1tXQ7wXWnlQ8DY+t/5ii1?=
 =?us-ascii?Q?u7s78vIlETRpKJ+r4P2hBdBWSnm4PhStGsGtt8F8b2H0VA3BxiBr+/88tplU?=
 =?us-ascii?Q?slwPP7KYqoPQGtFgWLFROPTRpoqwENU9cJhfu8QC0+qoPCI4kfs5VwL2DMtb?=
 =?us-ascii?Q?bfISVPUpc2I153k3AWMYI8PKa4lEAg1M2ERb/SuOKkXPAw3/c2pOZ7ViTtos?=
 =?us-ascii?Q?yrjna0w/VV2BgnY4mD66Y/eg3zQ4jgXU3fVDKICz2PGFClvwkd1SiOETB2KK?=
 =?us-ascii?Q?JGcFzBcfFQjekyYGvzDcMcSJ8wfrKqVS71gEduPqaSz5PaaYiV/It7KS3JbA?=
 =?us-ascii?Q?t+Jyuh6VqZMd5krKBGePyUIShEdoptj5i7trL0+CzUOITExwxj055Wgx1yHe?=
 =?us-ascii?Q?bTHHMEWyPaipghFALiyw44RRIS77u7fGmmkyHKj4p5eYdXxdeMUTlP60Ke62?=
 =?us-ascii?Q?Uocq8K+MxAwhOsX46NUhf4U/lkCjjxAxOA8BoUNNHeaG1LDZ+FpqV7/JW4Wu?=
 =?us-ascii?Q?6yLhlk49HRfM4Rr94oeI94dm4VPxvWHb8FIWT3Zb9iRT8tsvtDlm0G5iTGGD?=
 =?us-ascii?Q?mrUIYlERIZNLeHw/IpLKBU7erL8Eh7bQRXhWi6/G1CVTff9D+wpkMnFa2vhd?=
 =?us-ascii?Q?whIiereEICrANAc/I786zCbRlw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ca2112-af8d-469c-a3a3-08dbce3d030f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 11:42:44.2721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ukOOwa0ja0CC2JI9V4RBV8aKJ4BQ+kohk5sHTL/TpNeC/ZgtvzS5nyaMPn+6X9jGMPfnx6PwMwZKLPgKYpWFfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_04,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310160102
X-Proofpoint-GUID: TDxwXOmJu7QZ8G7XG2TFy3ZGrHpILTk5
X-Proofpoint-ORIG-GUID: TDxwXOmJu7QZ8G7XG2TFy3ZGrHpILTk5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

> On 16 Oct 2023, at 11:31, Eric Auger <eric.auger@redhat.com> wrote:
>=20
>=20
>=20
> On 10/16/23 13:17, Miguel Luis wrote:
>> Some _EL2 encodings are missing. Add them.
>>=20
>> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>=20

Thank you!

Miguel

> Eric
>> ---
>> arch/arm64/include/asm/sysreg.h | 39 +++++++++++++++++++++++++++++++++
>> 1 file changed, 39 insertions(+)
>>=20
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sy=
sreg.h
>> index ba5db50effec..8653fb67a339 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -270,6 +270,8 @@
>> /* ETM */
>> #define SYS_TRCOSLAR sys_reg(2, 1, 1, 0, 4)
>>=20
>> +#define SYS_BRBCR_EL2 sys_reg(2, 4, 9, 0, 0)
>> +
>> #define SYS_MIDR_EL1 sys_reg(3, 0, 0, 0, 0)
>> #define SYS_MPIDR_EL1 sys_reg(3, 0, 0, 0, 5)
>> #define SYS_REVIDR_EL1 sys_reg(3, 0, 0, 0, 6)
>> @@ -484,6 +486,7 @@
>>=20
>> #define SYS_SCTLR_EL2 sys_reg(3, 4, 1, 0, 0)
>> #define SYS_ACTLR_EL2 sys_reg(3, 4, 1, 0, 1)
>> +#define SYS_SCTLR2_EL2 sys_reg(3, 4, 1, 0, 3)
>> #define SYS_HCR_EL2 sys_reg(3, 4, 1, 1, 0)
>> #define SYS_MDCR_EL2 sys_reg(3, 4, 1, 1, 1)
>> #define SYS_CPTR_EL2 sys_reg(3, 4, 1, 1, 2)
>> @@ -497,6 +500,10 @@
>> #define SYS_VTCR_EL2 sys_reg(3, 4, 2, 1, 2)
>>=20
>> #define SYS_TRFCR_EL2 sys_reg(3, 4, 1, 2, 1)
>> +#define SYS_SDER32_EL2 sys_reg(3, 4, 1, 3, 1)
>> +#define SYS_VNCR_EL2 sys_reg(3, 4, 2, 2, 0)
>> +#define SYS_VSTTBR_EL2 sys_reg(3, 4, 2, 6, 0)
>> +#define SYS_VSTCR_EL2 sys_reg(3, 4, 2, 6, 2)
>> #define SYS_HAFGRTR_EL2 sys_reg(3, 4, 3, 1, 6)
>> #define SYS_SPSR_EL2 sys_reg(3, 4, 4, 0, 0)
>> #define SYS_ELR_EL2 sys_reg(3, 4, 4, 0, 1)
>> @@ -514,6 +521,18 @@
>>=20
>> #define SYS_MAIR_EL2 sys_reg(3, 4, 10, 2, 0)
>> #define SYS_AMAIR_EL2 sys_reg(3, 4, 10, 3, 0)
>> +#define SYS_MPAMHCR_EL2 sys_reg(3, 4, 10, 4, 0)
>> +#define SYS_MPAMVPMV_EL2 sys_reg(3, 4, 10, 4, 1)
>> +#define SYS_MPAM2_EL2 sys_reg(3, 4, 10, 5, 0)
>> +#define __SYS__MPAMVPMx_EL2(x) sys_reg(3, 4, 10, 6, x)
>> +#define SYS_MPAMVPM0_EL2 __SYS__MPAMVPMx_EL2(0)
>> +#define SYS_MPAMVPM1_EL2 __SYS__MPAMVPMx_EL2(1)
>> +#define SYS_MPAMVPM2_EL2 __SYS__MPAMVPMx_EL2(2)
>> +#define SYS_MPAMVPM3_EL2 __SYS__MPAMVPMx_EL2(3)
>> +#define SYS_MPAMVPM4_EL2 __SYS__MPAMVPMx_EL2(4)
>> +#define SYS_MPAMVPM5_EL2 __SYS__MPAMVPMx_EL2(5)
>> +#define SYS_MPAMVPM6_EL2 __SYS__MPAMVPMx_EL2(6)
>> +#define SYS_MPAMVPM7_EL2 __SYS__MPAMVPMx_EL2(7)
>>=20
>> #define SYS_VBAR_EL2 sys_reg(3, 4, 12, 0, 0)
>> #define SYS_RVBAR_EL2 sys_reg(3, 4, 12, 0, 1)
>> @@ -562,9 +581,29 @@
>>=20
>> #define SYS_CONTEXTIDR_EL2 sys_reg(3, 4, 13, 0, 1)
>> #define SYS_TPIDR_EL2 sys_reg(3, 4, 13, 0, 2)
>> +#define SYS_SCXTNUM_EL2 sys_reg(3, 4, 13, 0, 7)
>> +
>> +#define __AMEV_op2(m) (m & 0x7)
>> +#define __AMEV_CRm(n, m) (n | ((m & 0x8) >> 3))
>> +#define __SYS__AMEVCNTVOFF0n_EL2(m) sys_reg(3, 4, 13, __AMEV_CRm(0x8, m=
), __AMEV_op2(m))
>> +#define SYS_AMEVCNTVOFF0n_EL2(m) __SYS__AMEVCNTVOFF0n_EL2(m)
>> +#define __SYS__AMEVCNTVOFF1n_EL2(m) sys_reg(3, 4, 13, __AMEV_CRm(0xA, m=
), __AMEV_op2(m))
>> +#define SYS_AMEVCNTVOFF1n_EL2(m) __SYS__AMEVCNTVOFF1n_EL2(m)
>>=20
>> #define SYS_CNTVOFF_EL2 sys_reg(3, 4, 14, 0, 3)
>> #define SYS_CNTHCTL_EL2 sys_reg(3, 4, 14, 1, 0)
>> +#define SYS_CNTHP_TVAL_EL2 sys_reg(3, 4, 14, 2, 0)
>> +#define SYS_CNTHP_CTL_EL2 sys_reg(3, 4, 14, 2, 1)
>> +#define SYS_CNTHP_CVAL_EL2 sys_reg(3, 4, 14, 2, 2)
>> +#define SYS_CNTHV_TVAL_EL2 sys_reg(3, 4, 14, 3, 0)
>> +#define SYS_CNTHV_CTL_EL2 sys_reg(3, 4, 14, 3, 1)
>> +#define SYS_CNTHV_CVAL_EL2 sys_reg(3, 4, 14, 3, 2)
>> +#define SYS_CNTHVS_TVAL_EL2 sys_reg(3, 4, 14, 4, 0)
>> +#define SYS_CNTHVS_CTL_EL2 sys_reg(3, 4, 14, 4, 1)
>> +#define SYS_CNTHVS_CVAL_EL2 sys_reg(3, 4, 14, 4, 2)
>> +#define SYS_CNTHPS_TVAL_EL2 sys_reg(3, 4, 14, 5, 0)
>> +#define SYS_CNTHPS_CTL_EL2 sys_reg(3, 4, 14, 5, 1)
>> +#define SYS_CNTHPS_CVAL_EL2 sys_reg(3, 4, 14, 5, 2)
>>=20
>> /* VHE encodings for architectural EL0/1 system registers */
>> #define SYS_BRBCR_EL12 sys_reg(2, 5, 9, 0, 0)
>=20

