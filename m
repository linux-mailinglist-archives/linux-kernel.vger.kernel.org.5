Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1997D0547
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 01:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346704AbjJSXJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 19:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjJSXJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 19:09:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ED4119;
        Thu, 19 Oct 2023 16:09:06 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JKx6La032305;
        Thu, 19 Oct 2023 23:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=EcD2rWRrqJp2v3Ry/6/bQiBN+GTVbD/FI/hlrdnIRLY=;
 b=ShO92VqF3v7LI1bWvSiRRQb/7a9BIt3iOXImWu3u5A0sdWiVSm2MvhySTrmhNvNbYftq
 6tD1WHzU4o4qon7uZNx3+cYrfso4dpBDpZEjOid3C5VvGdeqk9JR7Ae2FlsAuTbbhCwb
 eiTVZjV3xyW+w2uNslWV3xTeU4cCoo6Dl/zQMndLlePvxRgAIrTaI/e2vFSxgnCLZ6hW
 2tnj6j/Y3iwgwreIOIxGG3A55jhm6IFb4Xut52efWrMbtn89v1DaOHa2dHVhyoUqZtbV
 AdIHf8hGz69I0C9eygKCVW9p+whk14OjEF31ZKK6Fi3p9BGXddBQuN0bgdcHWkGSK2Eb yg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tubwb858y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 23:08:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39JKrjaM038511;
        Thu, 19 Oct 2023 23:08:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tubw43yy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 23:08:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2xZ31lgaq/dOhqCMt1dZP9WHonpADjNtQDzyxjerXs8UFsVJNmhKOy/Tn8fiwrpIXlckE/f7MvNFrDYiNkgj5wj9AHTf1kpgrSQ8PTwJYdqRcRPqIllbF/9kV77ZOH4If/esW0yFIWeAoATIWvvkGqDhxzOpLURSIe9AFJv9sSs237lsEpFeiD1UbnLQrvQwyCF5gf1b0ggg61CSNI2KHQ/x2XExSN9Dr/kB50LwHuh9aMioIsOCzKUzH8lnWY0DlvnKeqTOjxKbz0RlHm3gUMnTz39PgkFXxmGuLyMdlF9DfSbch56pY8YzjaQGxehPWADsaWCr30WcyXPsHNZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcD2rWRrqJp2v3Ry/6/bQiBN+GTVbD/FI/hlrdnIRLY=;
 b=hYVRqT6tuuzfQp5rGVX/YxxbIA9T9A3+e2nCNN4aZyZ6M1xLHwSgn49nNo208ZOuwkMUJls0OmGpYn29Wh76fHeWCUxBxHM8ETGGSKvJlYC+DJdCO35MYVy77FRRozNUWFZQzyiQDMv+tj/FrSlsDzXKnvdmo0qTSIWYO/qZetT0kR9iCQjmLE0nQv3QrVld9JKjUGDRQMAbT+R+lFqZ/j2VTzLkOZzC0ZHMto06EX5lJt/LJYauEZPe1DFs2p7PngtRUwb7C/IT969lZ3E+ScTaM23I83QjtA0DA/7KPJrgQ7QSMBeQrxQ++pRfrTMv9FU972xyiLYScYj9Kjch/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcD2rWRrqJp2v3Ry/6/bQiBN+GTVbD/FI/hlrdnIRLY=;
 b=vZzzhyhEXGQXW3+EIpwgJR3tFOmbkrTftaOKhRjLO5Ab5EPgswO04urIaZ3cVdJ0af6HwvxcaSkMdTWfAgLsILt0/gYiw2vVdaZ6uOPl7k2O9EKC01pGlIcrRI8Rd9WUYSaR0S/XciwZ1uDCB7q/SPRHG7DW+1jfQnV41AzR3LY=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by IA1PR10MB7239.namprd10.prod.outlook.com (2603:10b6:208:3f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 23:08:39 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::134:c770:8cb6:70e]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::134:c770:8cb6:70e%4]) with mapi id 15.20.6863.032; Thu, 19 Oct 2023
 23:08:39 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
CC:     Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: Re: RFC: New LSM to control usage of x509 certificates
Thread-Topic: RFC: New LSM to control usage of x509 certificates
Thread-Index: AQHZ93c4gJX6SHkC80mNOExcrBTnXrBOD7yAgAAjSwCAABc5gIAABa6AgAAIMoCAAA68gIAADAcAgAE44ICAAJZxAIAAp5UAgADpnAA=
Date:   Thu, 19 Oct 2023 23:08:38 +0000
Message-ID: <0296DA27-7CAF-4605-AF67-3645F82BEE4D@oracle.com>
References: <20231005.dajohf2peiBu@digikod.net>
 <d3b51f26c14fd273d41da3432895fdce9f4d047c.camel@linux.ibm.com>
 <CAHC9VhRdU1CZJpPSEdSmui-Xirr0j261K=+SM7KiDwiPG-JSrQ@mail.gmail.com>
 <a851227aaa75ab16b0d6dd93433e1ee1679715f9.camel@linux.ibm.com>
 <CAHC9VhS_Ttdy5ZB=jYdVfNyaJfn_7G1wztr5+g0g7uUDForXvA@mail.gmail.com>
 <5c795b4cf6d7460af205e85a36194fa188136c38.camel@linux.ibm.com>
 <CAHC9VhTug20M0ET=QojUPtjrGkeHfU=ADDNrKfXmLTQPG_i1vw@mail.gmail.com>
 <2512D2AE-4ACA-41B9-B9FB-C2B4802B9A10@oracle.com>
 <20231018.heiju2Shexai@digikod.net>
 <18FC67B7-7966-49B7-8C27-F815F1568781@oracle.com>
 <20231019.vair7OoRie7w@digikod.net>
In-Reply-To: <20231019.vair7OoRie7w@digikod.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|IA1PR10MB7239:EE_
x-ms-office365-filtering-correlation-id: af9d306c-10d3-4b2a-f734-08dbd0f85453
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IaFJ5pDfXSBndcqq1Y8CTmRzJ6+q4kxlSv/531SA/EHyq4/vwH83zUAjvYW81pP+ux0BhBURXtmdFPayV4f+IDUniMx6GgY7vlkred4F1uq9VnF09hql4i3EEqcurgBE9YkuxR8ibZlGJqKxpjjmdQi+15fJ6R+Bs8Sj2liCBqG+TdotlWtF58Z1IeyiTPIYQkg1Qyebb1PoXTgZTSMQ8f57DgYJRwraZKeLzXNO0DEN755yTP0mv5JIGXFpf1jDl2xp5zKrqcmlMkXdMPCzRkJ8NBZwfPnSzOwLnzmNHDmIg2XQumQnMhFbuOYbjskiOn9s85+SU12j7crtuOd0yc4w7GnFRSXnxXyN9FmmDSbT/FfXLeIlAbHLMBjqqho/y9ZV0yzMPDbSTbTz31nbrtKfUnVSR2b0sHRA5ze43JNDiODq8DY2bpM6mC9XqkXDsvrJMTYFOcIAz5adAUDPr56NUN5FDFN5oXprpWRKcm+eArz33C7R6JhfUMtflW6W0QGJRY6p1xhEZok+JnRuEnB9jMv8snclmMd3mYD4YIWENuGRnzv+TagpuyLm6cG3mAJz0sZDE9ZqGJLH2+AyN1M5dm97+xzMX7SsGChxmzN+jw4gJWi3mGI2tFajpNfMimklYut4c25hEjAjT5SuZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(33656002)(36756003)(66899024)(38070700009)(66446008)(66476007)(6916009)(54906003)(66556008)(66946007)(76116006)(64756008)(38100700002)(86362001)(2616005)(122000001)(91956017)(53546011)(83380400001)(6512007)(26005)(71200400001)(66574015)(6506007)(6486002)(966005)(4001150100001)(2906002)(8936002)(316002)(478600001)(5660300002)(44832011)(41300700001)(4326008)(7416002)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUZKTUk0T0lrZFNlMTJTSGlzd210NExPaWZSd3Iwa3JyaUVSSTMyRHorV3FV?=
 =?utf-8?B?Q24rbWR4VWJDRnJ5MjgzajFWY3Q4QjJEbHhtY00veStrd2tOWGx0bGdYQU8w?=
 =?utf-8?B?MDRURWpwVzBZTmFQT0tvLzVIZEdDRUJrOUs2clRIbFN6MWxDMGNFQlNqdVB3?=
 =?utf-8?B?S3dQdUZlQitWSzgyRHo0ODEvWTJoVnVmeWNGTVVkWWJFVGU4bkZVZDlPYmdJ?=
 =?utf-8?B?U3loTHUzb2pRdUYxSUZzb25MOFdDL2M1dGNSK2g1V0dYMy81VTNMcGxlNlU2?=
 =?utf-8?B?TE12eHNNdVVGNXJTWDhiekhGR0k2a2MrVGhlT21yMjhvOUVDUTRRL3N2QUZH?=
 =?utf-8?B?Ui9pdk5KaHBmMFc4U3FOeUx4cldTZWdiMGFiMkpkTmRzSGd3SDFaRGlmOVo0?=
 =?utf-8?B?S2RwTjIxMHBMVTFGTlJGOFRRR1J0SEFGZ2d5TmlUYnd0TFVRbm52RXFjSVo1?=
 =?utf-8?B?Z2J4VlhVQlhTOUFGM1JlMmFYdXpraWs1OElXVE9RVGgvbWRMU08xcUV5RnU1?=
 =?utf-8?B?a3p4UTNHZzBlNXVmeDlGZFpPeCtLWDNER0VzK2d5WElaV0ExT0RNT20zcXRQ?=
 =?utf-8?B?MTFNU3l1aE9kN3pOYWtZbysxeEtvQlJLdHZqVzhieSt5S2FnbFU4OW1hcHBk?=
 =?utf-8?B?alpQT1FRcE5yWjl6K2JGYWZaeFUrdllwYUpHL0srR3hXTi80VTV3Z2g4VjAw?=
 =?utf-8?B?bVQ5V1V1SHJDN2FrOUtsYmUvRkFlV0QweEorUlRLd2UxSWRUNlJjQzhMU24v?=
 =?utf-8?B?RElPdExRZy9IaXNmV0t5QlVpblBlMmxDUCtSelZsTUdIRldDU1FyclNmVkJF?=
 =?utf-8?B?dFV1c1JGbWR3ZnJUWXE2R2M4Y2RSZXBpdHM2ZDdnZzZyUjVmeFpBdGpsMyts?=
 =?utf-8?B?THBmTEVySWxUdDdpaEEwenJxdWF0Z3EvTDdHSGpjWHZxYjlYTHhOQXNQZ1Vy?=
 =?utf-8?B?UDBRWkdHYzc3TkJDRm96UzloYXdIWkxLN0trNEgxN2hmWXVjZThhLzFOVmla?=
 =?utf-8?B?RThxWUgxRGozZ1hyTHFTbi9VcUdlalBLVkp3dEFQaGVvWk1HelJ3dUFPS3FR?=
 =?utf-8?B?VlRUbk9yN0dkNTk1Z2JrWnd5QjdTZlRZckl1VUc5eVBMTjk1MnltVk1la1gz?=
 =?utf-8?B?SGtrSjJzZzh6SWFNZElWK1p5RGlOM1ZkYmJ5SlJRb0VPNVhnZkxVUW9lN3F6?=
 =?utf-8?B?aHgyeU9mdGpmRzhGTEtuUGhrL0Mzc0tDb3dnVXgzWTZwR3NoYkJlRWsyclVr?=
 =?utf-8?B?SUdHL09LRnNhWm5FaldndzFRT3BBa0xzZjJhTThpWEFoZDVMTU9KMGprM215?=
 =?utf-8?B?NmM1aXB4T2txTXR2MkVoMGl1Q3hkd3FWeVhqTGZMUkJaM1hyalo2RldraHZB?=
 =?utf-8?B?b2hQdTJUc2lDQnBWT3I5WjB3Q09nKzdFU2tKS2lUR01RbUx3SnEwU3ZJditJ?=
 =?utf-8?B?MTREcTdVVHE0dkdZZVQxZ05hQlFmMENTenh1VWdhOEJid1psK25meWpiWThD?=
 =?utf-8?B?NmtTaS9JQ3h5NDUyMkkvNXZ3LzVkejRhWDdYaHpiaEM2cHBSd0NwVUQ4a2FU?=
 =?utf-8?B?L21qdE9vODQ3dzRGejVJa0dCd0xmUURwMGhjS2QyMHVweWIxbkU5ZXoyK1Rp?=
 =?utf-8?B?dmFSeDlHRjhtTDJ0RzkwZzF4T0d0NU9JTjRYYlpac1FoemdveWs2THR1RlVG?=
 =?utf-8?B?MzZKT2d0TVBnZzZUeDB6cFFjTzFZcDVROGZndDRUMU9ZMjVCSzFTdnNNSzA0?=
 =?utf-8?B?RElhWGVhT3h4ZHNETldrak5rRlRkZjFHVDBKd2RJVjMwUk9naXhieExkMGg3?=
 =?utf-8?B?NGZsT09EMjhyT3Rwd2NuNktKK2QwVDZKMlcxS29rZXFtZkU3SzQ0NnJBTVVL?=
 =?utf-8?B?ZjNuNTR3UExWOFdRWmNDQk85OExVZGhTNVYxcm5xNks4Q2VwblIxVHBJSTZC?=
 =?utf-8?B?OHJaRVNGbU8rdU1rSHZKQnJwRDRvVStvbFJBWnVDQ09CRm15Zkw1cVdtV0xC?=
 =?utf-8?B?alNEelMraVRZVnBVbzQ0aDZCWC9XbVgxNVpNYTNSNHlQeGZ4WTdPVHJ2bnBL?=
 =?utf-8?B?UXVTMGQzOHZsczhvbFBNNm9NN2dhRnhDNXV4c3k0NHExTmpuMFMyZFZZeHh6?=
 =?utf-8?B?bnMwNk9BcHBpRGNKUitmV3hiTS8rUVV6MGRub1JmYUlWSUYwOXl6Ym0wMzFF?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E60C14C21B8944993C83C381E95A8AA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SFRDNlh2MVZ2bEhUcUVKMURzNVMrZjBSQ0Z6ZEpvQ2ZPT3hTU09zQTgzbndV?=
 =?utf-8?B?UUFnQXVUMlZCL2paR0lRWXZMdEtIZmJSbjIyazJ0Zm01dFpsbU1veWhDUzkx?=
 =?utf-8?B?Tmh1Zm1VRFdUeWdSUkFXaDhRM3dVQ2dPNXNpYjdDMnV6eitGVi9zM0tFdVVq?=
 =?utf-8?B?c0wvVkUyTjNndUl3V21UbUxicno2cXlvenIxYzEwL1JDRlFMTG5rdXd5Zmc2?=
 =?utf-8?B?Y2ZrVGpnb1ppMVp1L21KcGlDV21lZHdqNURBek1wYWFCaXU2QXpQOEZxcUl2?=
 =?utf-8?B?RHJMYkZOQVZCcVJMZFZBYnN5YVE4ZHVkZXBNYnNSWktNKzZPZ2dLL0gxdkVx?=
 =?utf-8?B?ZXdIUitMbStNSmpjYjNZSnBLOFAra20wdUNqN0hTYkxzMDV6NWIxb3hVZCtj?=
 =?utf-8?B?ZWZEYW85NlVGeXVycUVNK0dJTnhuUjBvSnZyRHRHTVJ0RnVOTlJpTklQUXgw?=
 =?utf-8?B?Z096VFJ4VW9wUU91czZQY0tXZ2szL2hLd2poTkFkS29mYUhQRDFFWmJOSFdr?=
 =?utf-8?B?UWNWTHVaNjNFUkJCMUx0Q1AvRjZiY1dkcUlRbkFTVWFLU2dkSU8ycGNIeDJP?=
 =?utf-8?B?UmdDVngxcFEzbkRqRU5WZmFPVkZEcDAyaHFmTVdUNFFtdFY2TC83Q2lhamhw?=
 =?utf-8?B?QlkzTmQzZDRCOHVMVlVxR0N0TXNmSTJ6QmFoemFOakJxVnlNdHdjd2duZnNw?=
 =?utf-8?B?ck9UZzlpUllTUFBEQzJmSzhKa3BZUU9BY1J1SXFEWW1USHJUcXJtbnVpcmpV?=
 =?utf-8?B?M2QxREZWejFrVTh2K2pVbFFvckJWNHdyRTRHT3hFSzc5MVljVC9HbUU3dWdQ?=
 =?utf-8?B?RGZ3TldtazNzWTlDNGsvM3RtWlVOdVVEajFPbjkwRzVWSDNmb1EwdkIxb2hQ?=
 =?utf-8?B?M0lpdjNlRWNQVlo3dW0xNGdqZGhzSU5pNTN6YnZidFRxSkRUU0FKOW4vZ0RG?=
 =?utf-8?B?SXpIU2kzOGRhYUFqSm1BTFBRNjhGNkRxeDRyVmtxM0QrUDQrYVVtY2V1WHla?=
 =?utf-8?B?VVNyYnRjZzFrMi9aZlo1N0hrRlppbGJIeE5pc29rMFZoc1Y4VnFRaGFXRFJS?=
 =?utf-8?B?c2s5U3hxZmpHeC9DYmd3TXh4WTIyQ3lZNGhCVFBYWTBWQURWZThIeUo2d2V0?=
 =?utf-8?B?UVFjWC8ydXY5SW5RNmxSY0NxZWU0WjNpdzFBYXZKUWYvSzA0TWw2a09OVURT?=
 =?utf-8?B?N2RMSUV0WGhnQ3FFaVpKb3JvaXB2Mlc1STFOc2MyQldQaldaVnFKVmxtSjc5?=
 =?utf-8?B?RXpkVzdlbmdROWMxS3d1Q0VXVm92NW9yQVUxY1RkOXlvZmZKN0ZjbG1mQWE0?=
 =?utf-8?Q?ufU2K8+I/Ky8MpLOm8N1tAkve4FEP/XSmV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9d306c-10d3-4b2a-f734-08dbd0f85453
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 23:08:38.8237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gaDt5QXOPCNkhMViN1ZzX9Z/qrPpaWQNsPAp9Kyqe86lMHaVNRJVMM7OeCch63jafga+ZHsYe4rfiUwaTC+HkMNiYoRgd332gO+dFilNZXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7239
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_21,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310190196
X-Proofpoint-GUID: f-KVXxkxz9IIPk9KkXmE_0QanZMh3Kyj
X-Proofpoint-ORIG-GUID: f-KVXxkxz9IIPk9KkXmE_0QanZMh3Kyj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDE5LCAyMDIzLCBhdCAzOjEyIEFNLCBNaWNrYcOrbCBTYWxhw7xuIDxtaWNA
ZGlnaWtvZC5uZXQ+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBPY3QgMTgsIDIwMjMgYXQgMTE6MTI6
NDVQTSArMDAwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gT2N0IDE4
LCAyMDIzLCBhdCA4OjE0IEFNLCBNaWNrYcOrbCBTYWxhw7xuIDxtaWNAZGlnaWtvZC5uZXQ+IHdy
b3RlOg0KPj4+IA0KPj4+IE9uIFR1ZSwgT2N0IDE3LCAyMDIzIGF0IDA3OjM0OjI1UE0gKzAwMDAs
IEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+Pj4+IA0KPj4+PiANCj4+Pj4+IE9uIE9jdCAxNywgMjAy
MywgYXQgMTI6NTEgUE0sIFBhdWwgTW9vcmUgPHBhdWxAcGF1bC1tb29yZS5jb20+IHdyb3RlOg0K
Pj4+Pj4gDQo+Pj4+PiBPbiBUdWUsIE9jdCAxNywgMjAyMyBhdCAxOjU54oCvUE0gTWltaSBab2hh
ciA8em9oYXJAbGludXguaWJtLmNvbT4gd3JvdGU6DQo+Pj4+Pj4gT24gVHVlLCAyMDIzLTEwLTE3
IGF0IDEzOjI5IC0wNDAwLCBQYXVsIE1vb3JlIHdyb3RlOg0KPj4+Pj4+PiBPbiBUdWUsIE9jdCAx
NywgMjAyMyBhdCAxOjA54oCvUE0gTWltaSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4gd3Jv
dGU6DQo+Pj4+Pj4+PiBPbiBUdWUsIDIwMjMtMTAtMTcgYXQgMTE6NDUgLTA0MDAsIFBhdWwgTW9v
cmUgd3JvdGU6DQo+Pj4+Pj4+Pj4gT24gVHVlLCBPY3QgMTcsIDIwMjMgYXQgOTo0OOKAr0FNIE1p
bWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPj4+Pj4+Pj4+PiBPbiBUaHUs
IDIwMjMtMTAtMDUgYXQgMTI6MzIgKzAyMDAsIE1pY2thw6tsIFNhbGHDvG4gd3JvdGU6DQo+Pj4+
Pj4+Pj4+Pj4+PiBBIGNvbXBsZW1lbnRhcnkgYXBwcm9hY2ggd291bGQgYmUgdG8gY3JlYXRlIGFu
DQo+Pj4+Pj4+Pj4+Pj4+PiBMU00gKG9yIGEgZGVkaWNhdGVkIGludGVyZmFjZSkgdG8gdGllIGNl
cnRpZmljYXRlIHByb3BlcnRpZXMgdG8gYSBzZXQgb2YNCj4+Pj4+Pj4+Pj4+Pj4+IGtlcm5lbCB1
c2FnZXMsIHdoaWxlIHN0aWxsIGxldHRpbmcgdXNlcnMgY29uZmlndXJlIHRoZXNlIGNvbnN0cmFp
bnRzLg0KPj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+Pj4gVGhhdCBpcyBhbiBpbnRlcmVzdGlu
ZyBpZGVhLiAgV291bGQgdGhlIG90aGVyIHNlY3VyaXR5IG1haW50YWluZXJzIGJlIGluDQo+Pj4+
Pj4+Pj4+Pj4+IHN1cHBvcnQgb2Ygc3VjaCBhbiBhcHByb2FjaD8gIFdvdWxkIGEgTFNNIGJlIHRo
ZSBjb3JyZWN0IGludGVyZmFjZT8NCj4+Pj4+Pj4+Pj4+Pj4gU29tZSBvZiB0aGUgcmVjZW50IHdv
cmsgSSBoYXZlIGRvbmUgd2l0aCBpbnRyb2R1Y2luZyBrZXkgdXNhZ2UgYW5kIENBDQo+Pj4+Pj4+
Pj4+Pj4+IGVuZm9yY2VtZW50IGlzIGRpZmZpY3VsdCBmb3IgYSBkaXN0cm8gdG8gcGljayB1cCwg
c2luY2UgdGhlc2UgY2hhbmdlcyBjYW4gYmUNCj4+Pj4+Pj4+Pj4+Pj4gdmlld2VkIGFzIGEgcmVn
cmVzc2lvbi4gIEVhY2ggZW5kLXVzZXIgaGFzIGRpZmZlcmVudCBzaWduaW5nIHByb2NlZHVyZXMN
Cj4+Pj4+Pj4+Pj4+Pj4gYW5kIHBvbGljaWVzLCBzbyBtYWtpbmcgc29tZXRoaW5nIHdvcmsgZm9y
IGV2ZXJ5b25lIGlzIGRpZmZpY3VsdC4gIExldHRpbmcgdGhlDQo+Pj4+Pj4+Pj4+Pj4+IHVzZXIg
Y29uZmlndXJlIHRoZXNlIGNvbnN0cmFpbnRzIHdvdWxkIHNvbHZlIHRoaXMgcHJvYmxlbS4NCj4+
Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+IFNvbWV0aGluZyBkZWZpbml0ZWx5IG5lZWRzIHRvIGJlIGRv
bmUgYWJvdXQgY29udHJvbGxpbmcgdGhlIHVzYWdlIG9mDQo+Pj4+Pj4+Pj4+IHg1MDkgY2VydGlm
aWNhdGVzLiAgTXkgY29uY2VybiBpcyB0aGUgbGV2ZWwgb2YgZ3JhbnVsYXJpdHkuICBXb3VsZCB0
aGlzDQo+Pj4+Pj4+Pj4+IGJlIGF0IHRoZSBMU00gaG9vayBsZXZlbCBvciBldmVuIGZpbmVyIGdy
YW5hdWxhcml0eT8NCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBZb3UgbG9zdCBtZSwgd2hhdCBkbyB5
b3UgbWVhbiBieSBmaW5lciBncmFudWxhcml0eSB0aGFuIGEgTFNNLWJhc2VkDQo+Pj4+Pj4+Pj4g
YWNjZXNzIGNvbnRyb2w/ICBDYW4geW91IGdpdmUgYW4gZXhpc3RpbmcgZXhhbXBsZSBpbiB0aGUg
TGludXgga2VybmVsDQo+Pj4+Pj4+Pj4gb2YgYWNjZXNzIGNvbnRyb2wgZ3JhbnVsYXJpdHkgdGhh
dCBpcyBmaW5lciBncmFpbmVkIHRoYW4gd2hhdCBpcw0KPj4+Pj4+Pj4+IHByb3ZpZGVkIGJ5IHRo
ZSBMU01zPw0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBUaGUgY3VycmVudCB4NTA5IGNlcnRpZmljYXRl
IGFjY2VzcyBjb250cm9sIGdyYW51bGFyaXR5IGlzIGF0IHRoZQ0KPj4+Pj4+Pj4ga2V5cmluZyBs
ZXZlbC4gIEFueSBrZXkgb24gdGhlIGtleXJpbmcgbWF5IGJlIHVzZWQgdG8gdmVyaWZ5IGENCj4+
Pj4+Pj4+IHNpZ25hdHVyZS4gIEZpbmVyIGdyYW51bGFyaXR5IGNvdWxkIGFzc29jaWF0ZSBhIHNl
dCBvZiBjZXJ0aWZpY2F0ZXMgb24NCj4+Pj4+Pj4+IGEgcGFydGljdWxhciBrZXlyaW5nIHdpdGgg
YW4gTFNNIGhvb2sgLSBrZXJuZWwgbW9kdWxlcywgQlBSTSwga2V4ZWMsDQo+Pj4+Pj4+PiBmaXJt
d2FyZSwgZXRjLiAgRXZlbiBmaW5lciBncmFudWxhcml0eSBjb3VsZCBzb21laG93IGxpbWl0IGEg
a2V5J3MNCj4+Pj4+Pj4+IHNpZ25hdHVyZSB2ZXJpZmljYXRpb24gdG8gZmlsZXMgaW4gcGFydGlj
dWxhciBzb2Z0d2FyZSBwYWNrYWdlKHMpIGZvcg0KPj4+Pj4+Pj4gZXhhbXBsZS4NCj4+Pj4+Pj4+
IA0KPj4+Pj4+Pj4gUGVyaGFwcyBNaWNrYcOrbCBhbmQgRXJpYyB3ZXJlIHRoaW5raW5nIGFib3V0
IGEgbmV3IExTTSB0byBjb250cm9sIHVzYWdlDQo+Pj4+Pj4+PiBvZiB4NTA5IGNlcnRpZmljYXRl
cyBmcm9tIGEgdG90YWxseSBkaWZmZXJlbnQgcGVyc3BlY3RpdmUuICBJJ2QgbGlrZSB0bw0KPj4+
Pj4+Pj4gaGVhciB3aGF0IHRoZXkncmUgdGhpbmtpbmcuDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IEkg
aG9wZSB0aGlzIGFkZHJlc3NlZCB5b3VyIHF1ZXN0aW9ucy4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IE9r
YXksIHNvIHlvdSB3ZXJlIHRhbGtpbmcgYWJvdXQgZmluZXIgZ3JhbnVsYXJpdHkgd2hlbiBjb21w
YXJlZCB0byB0aGUNCj4+Pj4+Pj4gKmN1cnJlbnQqIExTTSBrZXlyaW5nIGhvb2tzLiAgR290Y2hh
Lg0KPj4+Pj4+PiANCj4+Pj4+Pj4gSWYgd2UgbmVlZCBhZGRpdGlvbmFsLCBvciBtb2RpZmllZCwg
aG9va3MgdGhhdCBzaG91bGRuJ3QgYmUgYSBwcm9ibGVtLg0KPj4+Pj4+PiBBbHRob3VnaCBJJ20g
Z3Vlc3NpbmcgdGhlIGFuc3dlciBpcyBnb2luZyB0byBiZSBtb3ZpbmcgdG93YXJkcw0KPj4+Pj4+
PiBwdXJwb3NlL29wZXJhdGlvbiBzcGVjaWZpYyBrZXlyaW5ncyB3aGljaCBtaWdodCBmaXQgaW4g
d2VsbCB3aXRoIHRoZQ0KPj4+Pj4+PiBjdXJyZW50IGtleXJpbmcgbGV2ZWwgY29udHJvbHMuDQo+
Pj4+Pj4gDQo+Pj4+Pj4gSSBkb24ndCBiZWxpZXZlIGRlZmluaW5nIHBlciBwdXJwb3NlL29wZXJh
dGlvbiBzcGVjaWZpYyBrZXlyaW5ncyB3aWxsDQo+Pj4+Pj4gcmVzb2x2ZSB0aGUgdW5kZXJseWlu
ZyBwcm9ibGVtIG9mIGdyYW51bGFyaXR5Lg0KPj4+Pj4gDQo+Pj4+PiBQZXJoYXBzIG5vdCBjb21w
bGV0ZWx5LCBidXQgZm9yIGluLWtlcm5lbCBvcGVyYXRpb25zIEkgYmVsaWV2ZSBpdCBpcw0KPj4+
Pj4gYW4gYXR0cmFjdGl2ZSBpZGVhLg0KPj4+PiANCj4+Pj4gQ291bGQgdGhlIFguNTA5IEV4dGVu
ZGVkIEtleSBVc2FnZSAoRUtVKSBleHRlbnNpb24gWzFdLCBiZSB1c2VkIGhlcmU/ICANCj4+Pj4g
VmFyaW91cyBPSURzIHdvdWxkIG5lZWQgdG8gYmUgZGVmaW5lZCBvciBhc3NpZ25lZCBmb3IgZWFj
aCBwdXJwb3NlLiAgDQo+Pj4+IE9uY2UgYXNzaWduZWQsIHRoZSBrZXJuZWwgY291bGQgcGFyc2Ug
dGhpcyBpbmZvcm1hdGlvbiBhbmQgZG8gdGhlDQo+Pj4+IGVuZm9yY2VtZW50LiAgVGhlbiBhbGwg
a2V5cyBjb3VsZCBjb250aW51ZSB0byByZW1haW4gaW4gdGhlIC5idWlsdGluLCANCj4+Pj4gLnNl
Y29uZGFyeSwgYW5kIC5tYWNoaW5lIGtleXJpbmdzLiAgIE9ubHkgYSBzdWJzZXQgb2YgZWFjaCBr
ZXlyaW5nIA0KPj4+PiB3b3VsZCBiZSB1c2VkIGZvciB2ZXJpZmljYXRpb24gYmFzZWQgb24gd2hh
dCBpcyBjb250YWluZWQgaW4gdGhlIEVLVS4NCj4+Pj4gDQo+Pj4+IDEuIGh0dHBzOi8vd3d3LnJm
Yy1lZGl0b3Iub3JnL3JmYy9yZmM1MjgwI3NlY3Rpb24tNC4yLjEuMTINCj4+PiANCj4+PiBJIHdh
cyBhbHNvIHRoaW5raW5nIGFib3V0IHRoaXMga2luZCBvZiB1c2UgY2FzZXMuIEJlY2F1c2UgaXQg
bWlnaHQgYmUNCj4+PiBkaWZmaWN1bHQgaW4gcHJhY3RpY2UgdG8gY29udHJvbCBhbGwgY2VydGlm
aWNhdGUgcHJvcGVydGllcywgd2UgbWlnaHQNCj4+PiB3YW50IHRvIGxldCBzeXNhZG1pbnMgY29u
ZmlndXJlIHRoZXNlIHN1YnNldCBvZiBrZXlyaW5nIGFjY29yZGluZyB0bw0KPj4+IHZhcmlvdXMg
Y2VydGlmaWNhdGUgcHJvcGVydGllcy4NCj4+IA0KPj4gSSBhZ3JlZSwgYSBjb25maWd1cmF0aW9u
IGNvbXBvbmVudCBmb3IgYSBzeXNhZG1pbiB3b3VsZCBiZSBuZWVkZWQuDQo+PiANCj4+PiBUaGVy
ZSBhcmUgY3VycmVudGx5IExTTSBob29rcyB0byBjb250cm9sDQo+Pj4gaW50ZXJhY3Rpb25zIHdp
dGgga2VybmVsIGtleXMgYnkgdXNlciBzcGFjZSwgYW5kIGtleXMgYXJlIGFscmVhZHkgdGllZA0K
Pj4+IHRvIExTTSBibG9icy4gTmV3IExTTSBob29rcyBjb3VsZCBiZSBhZGRlZCB0byBkeW5hbWlj
YWxseSBmaWx0ZXINCj4+PiBrZXlyaW5ncyBhY2NvcmRpbmcgdG8ga2VybmVsIHVzYWdlcyAoZS5n
LiBrZXJuZWwgbW9kdWxlIHZlcmlmaWNhdGlvbiwgYQ0KPj4+IHN1YnNldCBvZiBhbiBhdXRoZW50
aWNhdGlvbiBtZWNoYW5pc20gYWNjb3JkaW5nIHRvIHRoZSBjaGVja2VkIG9iamVjdCkuDQo+PiAN
Cj4+IElmIGFuIExTTSBob29rIGNvdWxkIGR5bmFtaWNhbGx5IGZpbHRlciBrZXlyaW5ncywgYW5k
IHRoZSBFS1Ugd2FzIHVzZWQsIA0KPj4gaXMgdGhlcmUgYW4gb3BpbmlvbiBvbiBob3cgZmxleGli
bGUgdGhpcyBzaG91bGQgYmU/ICBNZWFuaW5nLCBzaG91bGQgdGhlcmUgDQo+PiBiZSBPSURzIGRl
ZmluZWQgYW5kIGNhcnJpZWQgaW4gbWFpbmxpbmUgY29kZT8gIFRoaXMgd291bGQgbWFrZSBpdCBl
YXNpZXIgDQo+PiB0byBzZXR1cCBhbmQgdXNlLiAgSG93ZXZlciB3aG8gd291bGQgYmUgdGhlIGlu
aXRpYWwgT0lEIG93bmVyPyAgT3Igd291bGQgDQo+PiBwcmVkZWZpbmVkIE9JRHMgbm90IGJlIGNv
bnRhaW5lZCB3aXRoaW4gbWFpbmxpbmUgY29kZSwgbGVhdmluZyBpdCB0byB0aGUgDQo+PiBzeXNh
ZG1pbiB0byBjcmVhdGUgYSBwb2xpY3kgdGhhdCB3b3VsZCBiZSBmZWQgdG8gdGhlIExTTSB0byBk
byB0aGUgZmlsdGVyaW5nLg0KPiANCj4gVGhlIG1vcmUgZmxleGlibGUgYXBwcm9hY2ggd291bGQg
YmUgdG8gbm90IGhhcmRjb2RlIGFueSBwb2xpY3kgaW4gdGhlDQo+IGtlcm5lbCBidXQgbGV0IHN5
c2FkbWlucyBkZWZpbmUgdGhlaXIgb3duLCBpbmNsdWRpbmcgT0lEcy4gV2UgImp1c3QiDQo+IG5l
ZWQgdG8gZmluZCBhbiBhZGVxdWF0ZSBjb25maWd1cmF0aW9uIHNjaGVtZSB0byBkZWZpbmUgdGhl
c2UNCj4gY29uc3RyYWludHMuDQoNCkFsc28sIHdpdGggdGhlIGZsZXhpYmxlIGFwcHJvYWNoLCB0
aGUgcG9saWN5IHdvdWxkIG5lZWQgdG8gYmUgZ2l2ZW4gdG8gdGhlIA0Ka2VybmVsIGJlZm9yZSBh
bnkga2VybmVsIG1vZHVsZSBsb2FkcywgZnMtdmVyaXR5IHN0YXJ0cywgb3IgYW55dGhpbmcgZGVh
bGluZyANCndpdGggZGlnaXRhbCBzaWduYXR1cmUgYmFzZWQgSU1BIHJ1bnMsIGV0Yy4gIFdpdGgg
aGFyZGNvZGVkIHBvbGljaWVzIHRoaXMgDQpjb3VsZCBiZSBzZXR1cCBmcm9tIHRoZSBrZXJuZWwg
Y29tbWFuZCBsaW5lIG9yIGJlIHNldCBmcm9tIGEgS2NvbmZpZy4gIA0KSSBhc3N1bWUgd2l0aCBh
IGZsZXhpYmxlIGFwcHJvYWNoLCB0aGlzIHdvdWxkIG5lZWQgdG8gY29tZSBpbiBlYXJseSB3aXRo
aW4gDQp0aGUgaW5pdHJhbT8NCg0KPiBXZSBhbHJlYWR5IGhhdmUgYW4gQVNOLjEgcGFyc2VyIGlu
IHRoZSBrZXJuZWwsIHNvIHdlIG1pZ2h0DQo+IHdhbnQgdG8gbGV2ZXJhZ2UgdGhhdCB0byBtYXRj
aCBhIGNlcnRpZmljYXRlLg0KDQpXZSBoYXZlIHRoZSBwYXJzZXIsIGhvd2V2ZXIgYWZ0ZXIgcGFy
c2luZyB0aGUgY2VydGlmaWNhdGUgd2UgZG8gbm90IA0KcmV0YWluIGFsbCB0aGUgaW5mb3JtYXRp
b24gd2l0aGluIGl0LiAgU29tZSBvZiB0aGUgcmVjZW50IGNoYW5nZXMgSSBoYXZlIA0KZG9uZSBy
ZXF1aXJlZCBtb2RpZmljYXRpb25zIHRvIHRoZSBwdWJsaWNfa2V5IHN0cnVjdC4gIElmIHRoZXJl
IGlzbuKAmXQgYW55IA0KdHlwZSBvZiBoYXJkIGNvZGVkIHBvbGljeSwgd2hhdCB3b3VsZCBiZSB0
aGUgcmVjZXB0aW9uIG9mIHJldGFpbmluZyB0aGUgDQplbnRpcmUgY2VydCB3aXRoaW4gdGhlIGtl
cm5lbD8gDQoNCg==
