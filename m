Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3717779C19D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbjILBYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbjILBYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:24:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB357A3D15;
        Mon, 11 Sep 2023 17:45:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BJYPvr030630;
        Mon, 11 Sep 2023 22:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1Q3JVuTdIvT99OB7dXXXE2T/f8cB2NzGwkaz4gCoHME=;
 b=NArD6ovHbhcbEPd6pl/P7GuiXZ0tM/QKm54Cf0acZSUF0+YAc5hRFH892NmeEyik4AaY
 tMFeYYRxZxKJz7hgf07CjxC/g1hxWbnHBGk1XfGWPPLtHloBJmG2KOmGRQLYPxm7F1s7
 PwFk7EcKIuSFtvPV3hhOLTgP2yJd0HAWUfUbmI0hobis7+1BrS0EiExfhxNHkzDPLBnj
 dSn25Ot2uXfEet6moVHbPSfARsKXPv9TlmOJpggvGUWns+T9oHLkG2xRL+lqeEtbXXrH
 p+N1n6z1H1oNKMtA3BDdewk1s4aNlZeQB+OMfVWOPsfkNRb9k/waar79U0Yh4cvKZDR0 Ug== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jpatmux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 22:23:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38BLIu0M033080;
        Mon, 11 Sep 2023 22:23:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0wke4myh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 22:23:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvrT00I9POJ3q6b2BVq/MOwV3GXHbQS+69/y0/UMEZUmUFmveCjVh1XbDj4V2kl3BcIWKTgevW1g1g02/Oi65vDReGLl0g5oHY85XFECNqA65QwSMK7TSeXnqTPc3Pd5N7gf0TxuQ+WqXrH3VaTvp05oI4Zq3ld/UXL0w1Ot0KtIKre0oFVo/T/5ZdycTXz6hfX59E9XlQQybiVAdWhHrZy++roALlyEYd76wbtr1B7eRkKUPa990chu2C9W64G/ocqztRCXg9AOHv6nY+iS3nFN8baWMJ91ELBtCROK47tjuVhQPK5upjTJYvGV9KM42jDTI2VyxveKJ4NvOcJyvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Q3JVuTdIvT99OB7dXXXE2T/f8cB2NzGwkaz4gCoHME=;
 b=Ufo1gSsduSd9+kCo8xcM/cZ2AGm0G5rZzucZr3ffwtBWIRjCHXFa013gEkWDN3qwQcYnfNKxpo1qdfNpMoV96Vv0rNwaJsB2KpRCzZv1pcsPaPYasEq5b9jDgnAiVtvfai4826HNaG9BxDgOc2bEc9vkplroh732GF2q1AvZtGmzm+/9bk0NV+SiwznsL64Xet1eG4QLSI4nEtW4Uj6VLUKwzXiKRRatUje7Vwqv9vlbfcSEI/wRlpZT6rdAyqizfU23mo5lTSajnA9p+PL7yltc2ObqxLug6uNXGXJHFRjq96olUxTGfjNK64hp5sU8bn5Sw0pd4MGcP3BC/6woCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q3JVuTdIvT99OB7dXXXE2T/f8cB2NzGwkaz4gCoHME=;
 b=FHN7kPe4uUdsURPtFIDut+eQkkywNA2G35629OxWK20ri1STSZdq73rEqb8EkXjswX8eCbNql8VbdC7N055ToFAEB59yEd/SjCAHP/vSiTtj63GgejYmQQlFnCwFdSMObf0A01p/yvp3UjbKzzz3zz/DZ7U6EXp+itu3+VHelrE=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SJ1PR10MB5953.namprd10.prod.outlook.com (2603:10b6:a03:48c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Mon, 11 Sep
 2023 22:23:33 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::3f7b:855:6a95:8aed]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::3f7b:855:6a95:8aed%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 22:23:32 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "mic@linux.microsoft.com" <mic@linux.microsoft.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] certs: Restrict blacklist updates to the secondary
 trusted keyring
Thread-Topic: [PATCH] certs: Restrict blacklist updates to the secondary
 trusted keyring
Thread-Index: AQHZ4p0BkG9ylPk27Eafo4TPmLwJdbAVoqeAgACQE4CAAAU7AA==
Date:   Mon, 11 Sep 2023 22:23:32 +0000
Message-ID: <73BCF379-05BF-4D75-A2DC-8FE5007D5BC0@oracle.com>
References: <20230908213428.731513-1-eric.snowberg@oracle.com>
 <097a0413b27ed9792dc598ff184730bcf6ae8fcf.camel@linux.ibm.com>
 <CVGFG0625KNL.3B8Z118U3IGBY@suppilovahvero>
In-Reply-To: <CVGFG0625KNL.3B8Z118U3IGBY@suppilovahvero>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|SJ1PR10MB5953:EE_
x-ms-office365-filtering-correlation-id: 0e3f69b7-4043-4177-93c3-08dbb315bbca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IeygvzJLY7VyCryGHX8xO0uCoevb/R0V8P9YRdbw161OHFmAmSRt7CZyFqcAEBb5lx6FbVxGzxFlK0b/ddgzsmP52EwA1WHoicEg0g432nVjD38QeRKwB2DVGNU4mnWtHNPVSee6Dulm8FXxc9h9zsbkIn62UHaDH2+eFZVEyN/Rw4EkklrWmOunSco0XzjnIRSUq2z2+jlzQa6CCWalbxKcwLvSdNq1Wn/EVMME2M5f8tkd8YYthQ3ir7NkTGvaGqAmPEfbuSxJDpKcTrMgewL+oRkdKSG4R5zmH3DwH9ul+2OEgTLuEmIeZ0lbZfiGTYVjKBzwHx6g5MnBjJFg4EtcGnLg01olgRYQwr5v1vGGViVas+QhWeBZrT6CfjqdB0GRJBTiy6vDNHqvxf22E9Z+me52z0o+R4Qwvk3DpuK1RPvPMk7reGGZv8yfcgZVeHMaZRXwaNfNQTjSYM7K6p+kqsvCimHY5dTcXDH05ES8drSNkTyVD2CEgs/WQVsdNK8/KUxnDGeNnvBA1n75eAHpxh849I4QBtRPD7rUmi9LXYBBjcCQrOSfPRc0N9lXf5Hp92LM2DFmpsxhnF/NIrLTkuDZA1jJKnLJSn3ArT/LMsRFBGBIK89I03tCHmgVHpPa5tYGvDShpUE/WUgaEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199024)(186009)(1800799009)(478600001)(71200400001)(53546011)(6506007)(6486002)(6512007)(83380400001)(2616005)(2906002)(15650500001)(26005)(76116006)(8676002)(316002)(66556008)(54906003)(6916009)(66446008)(44832011)(66946007)(64756008)(66476007)(8936002)(4326008)(5660300002)(41300700001)(36756003)(38100700002)(33656002)(86362001)(122000001)(91956017)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ybDEC0VR/Yj5yOs9CoXevET/SD99JP8aVyRM+nBRxqfNmnpmqT7HmlyikFSV?=
 =?us-ascii?Q?VE7wT0oeLdhlclrZCWS/dg4/H5Z85H+KytQYrKx0zVtpxe3qbq+Vwh9QA2Hr?=
 =?us-ascii?Q?WymmoCijpb4Io98unG1TOngbr1+4zrsP6YUGl0bf6irIafzvhDLcnjBLD3Z/?=
 =?us-ascii?Q?IA7hggh2XLrBHwTj0uFq1+dg37oo/c3DKXgN9Hx3JCPDXtybkUDzXILgxght?=
 =?us-ascii?Q?9zmh60/jEo3k/r9Fu60m58JczUn6My9VDO+IU5UDSZ3pBAVZB2xs1YRCBFhU?=
 =?us-ascii?Q?yLaoiHlu4Q2Mvw7MsoC3XMxm/NnWSO8NUzIscHOCdsB0Us4r7SH7FNEJt285?=
 =?us-ascii?Q?DTpIJ++qiOQS/iGkAcKraGgiXy7mMGG9ShZ0076r1lwGA511JXJTlyZiw8gT?=
 =?us-ascii?Q?rvvPIvpxqrsRjus2nHxl+CcujtYwDHjt6CIznYmU01hc8n+v3F0b06RBC9ac?=
 =?us-ascii?Q?Oho9nO+PqLhFaMNs2S6dabg8ZZ7Pr//8wigVcpzpO5p+W5/yHzi5GNKvLOJA?=
 =?us-ascii?Q?yNiHGCd8W/I6KZ/oV9e/R5xtBNMgWPY3YPz22yXERIZmPiwHKCCDIhpaZJlh?=
 =?us-ascii?Q?OsZXeXq57MeC1gjQ5BgnSbpaJOz+O4IAxKPUo2w4YW2J8S9yYHK9QugScblO?=
 =?us-ascii?Q?1Zb8RoVJlOkYdtWuN3XfJKEpUGNsFMT/HPx72vKsocnvZ+GdBroD5OVPWqzN?=
 =?us-ascii?Q?n9cjsE2WoT6+akxzRaYS4uiDD7exjKgx/KHVogho4lDkG1uNR1lKX0AwYHo9?=
 =?us-ascii?Q?5MdaKgzqSvyaxD7dj9LGYhPqJUFuzwA7ocZAIU1lX86O0rdJBnYN5Lb+7xy2?=
 =?us-ascii?Q?38Ee86i6P1tcpXQbY27GzGR+bBarYezOUS077uB1QhrHUzc83oI0kqyRt7Su?=
 =?us-ascii?Q?0hQIDhK2xOcjBw+LIOlNxNl3C41xC58jVL1UBd6W/st43SyoG1rkHyJlzTyf?=
 =?us-ascii?Q?RJRU6Kz9QO40pjf7+q6vd3Zz3ugbKMpjDAZu7mDUhUdLPR+8iM70gUK4Mpk4?=
 =?us-ascii?Q?6H1GNdemPEK3ajZuPRyfRaUPL+VbOPw54kTIDgrBE1AKHcSMyzwCovybQGv/?=
 =?us-ascii?Q?cV+Jn8ejxLm7c7clVd9O34KATpOHBjcuh+nNjIEaNNFuSdnnknG4e1IdDYc5?=
 =?us-ascii?Q?o5j/k+sSDA/P9iVB3tYd4kMtOAX9gDNDVwNNA05M8jYcg/z6j7B+dskD41nK?=
 =?us-ascii?Q?+Rc4a+eg1u2vUIxkU3g7V35mTnj1vfMXuDE7qzGBRbI3hIWZFo5GOVjJayPh?=
 =?us-ascii?Q?9Q4bkFLOx6+LKSrFYpFijQi3jKTY2A2yGSMKR/LVwxnjiieFCyOqgNNZSHb7?=
 =?us-ascii?Q?+O3wVln7+KPDyC7GMzKUuK29YLLdenR9KaWYojycjTCMT7QMoUmU07D7l2c/?=
 =?us-ascii?Q?3KWw1CdqkcGZxUSaNPxTJWo/I7LnaViulpzyOLwbi00YFLQII14+EABro1R/?=
 =?us-ascii?Q?lBEc5nliD4v2K9PrNvftYK6JcSF6SPioWg1F74RZY4MCMFJ1s5ZmwWHQfypj?=
 =?us-ascii?Q?9nxfK0TGrpfi5BaOg1wHK+aoxzYzEQe4BV/8JHo8f0rVuIIeHRJ63zMF6A/k?=
 =?us-ascii?Q?ea12hzJ+CSnA1pvLGpb9mlvgF08QCCc7/pb7tFNbUPwYl8brCicEW3SSQ20t?=
 =?us-ascii?Q?TQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13D2ECD3128E3A48BB8469FDFD5DBCB0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CWvo/KuRnQDFaA6r+X96Exv3EIZLkLxGQzsipo+3fxuGIJHxGyu02SwWgDl8?=
 =?us-ascii?Q?9VNkBGMy9vt6/q/6Yub9mZ7L4NnuiUhEl49NB9s3i9XgZ+iyWmzCIFMLAjmh?=
 =?us-ascii?Q?sVpW0AhRwoef2wua4AUkBNhx/+q7a1qpQLJ+w9WnaT08J509Jwdj0V8BT3LH?=
 =?us-ascii?Q?2X6quOx0Q7bJ8IDq6aeNteSzFpuNP+FPS+imwUPkSBJwI7Ikw9xrCBmh/IKM?=
 =?us-ascii?Q?i/O43nQD3D+zp769Ckv+3LeDmE98+VsnpF8R1dZHQYI1Ap6h7TzBwQ78fjID?=
 =?us-ascii?Q?9S2ddPGkKqe9BLnA1Ox1irktF86Jc1NgEWwI8JIscNbCtudDb5r+WUoXCRkm?=
 =?us-ascii?Q?+WOOJFUhUMQ9ZEpFJObRMm9XZ4kZYX3+xBk9bnZxGLAYeCQNCsR5LGpaGrZW?=
 =?us-ascii?Q?q+hNTntQbtkRmsR6dRGwbtFVYAIV19fJEDOHlhZX7hG66NmJib7vzgLZ5jHf?=
 =?us-ascii?Q?tvT+XRCkjpQNtAPiQs7rWsUnUw5mzQzaY4jZd5YFiOM1/lawAxauEpVEQhtI?=
 =?us-ascii?Q?SEHOciaY/nX3P8bEJjxZ9+QKFytkf9PjHeTM0fBy4n6215Rz8BfdELjO9y6f?=
 =?us-ascii?Q?uEiNfidw6Aff6eK3B/vWZ6xd7VoY4AOmUADSw56rUw4Iz3jDwxI0sMxNctZz?=
 =?us-ascii?Q?o9U+h/Pg1wwscUvBAvYeCAODWDXT+JfT97Ek15x66Vddr/qr+qCFfNSUWwEI?=
 =?us-ascii?Q?s9s+xnCEfyGSEGMAazd1C+UHwMT3TyRwF5OU/lmml1VVsPDfo0SvEPHP2ymg?=
 =?us-ascii?Q?rVD2Hwd7MN0fAsdK6wc/6B8IBWymDlf91wyZOXT98daYSUByGbD8LlUCfgfH?=
 =?us-ascii?Q?ILJlfLccIUDo56NTvhQMg4ZeQBsxUB7nq2XeCGy1MJ6TczP0zPeZjadfb3EF?=
 =?us-ascii?Q?fM2rH82VFNIOoUqP/uC73TVHBOZAjwqDnQ8cXfXUJdN4tW0j0e+6fnC1FtYw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3f69b7-4043-4177-93c3-08dbb315bbca
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 22:23:32.8903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y8J8RUR/LpcHE0rvIeD8/vqiZT1tJ/pNpx2wQHpHAyaeZSb/GOxiuTHGhAnhgMCi971Y7DHAOuVLboW6anjCmP8Fqoit/uiKjPGkvfjll/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5953
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_18,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110206
X-Proofpoint-GUID: pjMfCr45-ae2sW67eYqUKK-o8V4LGWct
X-Proofpoint-ORIG-GUID: pjMfCr45-ae2sW67eYqUKK-o8V4LGWct
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 11, 2023, at 4:04 PM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Mon Sep 11, 2023 at 4:29 PM EEST, Mimi Zohar wrote:
>> Hi Eric,
>>=20
>> On Fri, 2023-09-08 at 17:34 -0400, Eric Snowberg wrote:
>>> Currently root can dynamically update the blacklist keyring if the hash
>>> being added is signed and vouched for by the builtin trusted keyring.
>>> Currently keys in the secondary trusted keyring can not be used.
>>>=20
>>> Keys within the secondary trusted keyring carry the same capabilities a=
s
>>> the builtin trusted keyring.  Relax the current restriction for updatin=
g
>>> the .blacklist keyring and allow the secondary to also be referenced as
>>> a trust source.  Since the machine keyring is linked to the secondary
>>> trusted keyring, any key within it may also be used.
>>>=20
>>> An example use case for this is IMA appraisal.  Now that IMA both
>>> references the blacklist keyring and allows the machine owner to add
>>> custom IMA CA certs via the machine keyring, this adds the additional
>>> capability for the machine owner to also do revocations on a running
>>> system.
>>>=20
>>> IMA appraisal usage example to add a revocation for /usr/foo:
>>>=20
>>> sha256sum /bin/foo | awk '{printf "bin:" $1}' > hash.txt
>>>=20
>>> openssl smime -sign -in hash.txt -inkey machine-private-key.pem \
>>>       -signer machine-certificate.pem -noattr -binary -outform DER \
>>>       -out hash.p7s
>>>=20
>>> keyctl padd blacklist "$(< hash.txt)" %:.blacklist < hash.p7s
>>>=20
>>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
>>=20
>> The secondary keyring may include both CA and code signing keys.  With
>> this change any key loaded onto the secondary keyring may blacklist a
>> hash.  Wouldn't it make more sense to limit blacklisting
>> certificates/hashes to at least CA keys?=20
>=20
> I think a bigger issue is that if a kernel is updated with this patch
> it will change the behavior. It is nothing to do whether the "old" or
> "new" is better but more like kind of backwards compatibility issue.

For a kernel built without the secondary trusted keyring defined, there is=
=20
no change to their security posture. For a kernel built with the secondary=
=20
trusted keyring defined,  I would view the system as being more secure=20
with this patch.   For any system using the secondary trusted keyring,=20
root can add trusted keys.  However without this patch, root can not=20
mitigate a security problem on a live system and do any type of revocation
for keys it owns.  Without the ability to do a revocation, we really only h=
ave=20
authenticity, not integrity.

