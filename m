Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBE979F08D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjIMRpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjIMRpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:45:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB3719AC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:45:46 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DEkLV7032128;
        Wed, 13 Sep 2023 17:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MXKzSP0J8ygR+w/0mAJTJ6rm9znktfBwGJ3dkeiOUu0=;
 b=nrXAts+EYTCqtm/RlyHOp5hej63qgYAZ4uhFTutfH9LaO5ZcSLmD4u/ZFJdTCG+r6knz
 nccCEiYAjRXlI6nV4xz0VKWJwuVqtaBtCQAv76RaHWUmEENcTZZ4UbpekAt0MIrpUsRU
 jWg+aGEN+fumjZ5ZiQ+6c3OCrX8vkqfDYInqRZCgYR+KH6crnavAg+/uS+IVCY7mCoFX
 EP0wSHNhLIFMI01E+QAHEJXEWks6O7T8AIC1frzIF3VwJzUXv8RG+TvY3PwDh0HKXoTy
 PvWKyseuSutgsjpHfws6+wptp55iTvuuf98QwcGHU5JLx8r30H9rhA3+r8padrBcy4NS EQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7mtqdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 17:45:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DGQTAV002372;
        Wed, 13 Sep 2023 17:45:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5durpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 17:45:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4eyTc/LRgDvpsBGUIYYriH1fTJeznblF/iwiifGNCSXsBKBK0J0vAkISjYYH1YByc/LVZk0tCt3nNKD/U3I6zXRpypDFI1f5vPwMLFr7vN92CKzH+80oLXbAHQIN1CJu9ANdwGmMHfI6BwSuwvWTCHqYr61/ilDv03ojJarmoeYZWVlxWn2Ffr+TjxBduxMLxa39OOGxWubZUF96oB+1KWZx+S3qwq8JZkMiELI4yG2s/fj5kRk2qnGycw4PU8Y98tmbM/ngj6g6dLIDVSXJmHMUCHDaq4dI4Ozg6muV+wTXF2GT1FCWomq929uCJhXtgn5tpVDNtxp4Gg++y1dYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXKzSP0J8ygR+w/0mAJTJ6rm9znktfBwGJ3dkeiOUu0=;
 b=UdKRwPUpipjP47UYfvDTaG/XBCFNQ/C0Z+GHCMIt6eBCovd1EktwsQXxbl6pZQOgyG79Obnr57bJZ1FF5bE6YXnnnWm2e9EzEeL4Fq8BWohpWckvaNumeVJs0hJQO1LedBuU2LeD8Q0dhQh52ns0PCyM7f3tedn3N+tTVLbVSJIFHr6B2OsM0sOy5hXNRiKX/JFeoipn08VmS2V+FM8DrYyZ4s/VcDo1yKX83qGFen/fnnVtNCB0bzBxHBa1gWXmgXDrV94tdrxpozWkGM020183lIs5x8vcf3qQmixbogYo66x3dpkyNhjv7Bul4n9YIkBv57aNlVyb9ZOJmN9FAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXKzSP0J8ygR+w/0mAJTJ6rm9znktfBwGJ3dkeiOUu0=;
 b=sg5bXTbVIMRWsq0mXZeDzhkLJYxa3fEP9fzcQXxpDIENvajSBgomdlWqmid96UiUj2VxSxsLLWut90Pb6LYTCbAcfQYHfoL3xPyzIkoF/stu0zYoL1jnJNuU1iXNzHnFlzsk+k6/R1xYd1p5Z2c7mWiZ4dpEOmrqzvRY3L9CjIw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4180.namprd10.prod.outlook.com (2603:10b6:a03:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Wed, 13 Sep
 2023 17:45:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 17:45:25 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Feng Tang <feng.tang@intel.com>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [linus:master] [shmem]  a2e459555c:  aim9.disk_src.ops_per_sec
 -19.0% regression
Thread-Topic: [linus:master] [shmem]  a2e459555c:  aim9.disk_src.ops_per_sec
 -19.0% regression
Thread-Index: AQHZ4hUlovnTGopJRkWINRJx8jG2QrARAWsAgAVqhYCAAMJWAIAAJUUAgAANNoCAAa8uAA==
Date:   Wed, 13 Sep 2023 17:45:25 +0000
Message-ID: <CAB1984E-091E-482A-AB10-8C9903B83B45@oracle.com>
References: <202309081306.3ecb3734-oliver.sang@intel.com>
 <C85F44FD-BC7D-421B-9585-C5FDFAEA9400@oracle.com>
 <ZP++GV9WURg1GhoY@xsang-OptiPlex-9020>
 <84984801-F885-4739-B4B3-DE8DE4ABE378@oracle.com> <ZQCAYpqu+5iD0rhh@feng-clx>
 <ZQCLdzmtVcjxZWXt@casper.infradead.org>
In-Reply-To: <ZQCLdzmtVcjxZWXt@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4180:EE_
x-ms-office365-filtering-correlation-id: a2db0ff5-efe6-47e4-85b1-08dbb4813642
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tBwi0phTL7TENVnaqyfkKw37blEfI9P8U/Q7InFNBP/hVyEOlz7wZxnYKYd9ze+kE+cDzyWMCHq9DOBNx0tcWDlRSb0KzyeDBf5qQAidqTuLzNLkPPkHRjyFu6Hm0b6efjtgaahaXzXlKaGK6O/msz3GaLR4nvz0CClrOBOuK3F0jSTZ6Orx5J+YC4SF2OIUaeiMv8/KS03uy9AkRJHdW8v/SpgZwDNAPipzYnIa7bfnAHOGYBqQGlABRVEGtP2eHISfS6LSvN/oIgPSYCMdd5i+qqFCOOp3gaMoV8QXKAYUnXpNFnq/ZMEdNJQQK7yq9bWeXfE7a5HdwHpt367FKTH4II95u9/xeNwp4L1qV0Rdjltw+drPTbUpcKAAoVA3PPpEks+vIOB+XkXR6hWMBpEwtn52WI014oU+Yve5siMQ+uMPx+AWZpddNWkjD2AV4m347hTrpK8rBajw+n2VWrWomPYZI/rSq4KDwlKj7JAlaAV8wc73sTT4oIA/xpCGWsEIQy4LdtEEJ6gTpi1cANfC9MCFlMIRmoB2QGWoUs+Ko44nsKmmF0gU3niHlCx+kzBtIc+m6rNOWFuVfjBE9kBN7K6BlWp7LPGiDKzPBfuTE1PhM+fTm72mslVImesxeP4a8rh6cnncX5K8pBQDEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199024)(1800799009)(186009)(2906002)(26005)(316002)(107886003)(76116006)(66946007)(66476007)(6916009)(41300700001)(91956017)(66446008)(66556008)(54906003)(64756008)(7416002)(478600001)(5660300002)(8676002)(8936002)(4326008)(6512007)(6486002)(6506007)(53546011)(2616005)(36756003)(86362001)(71200400001)(38070700005)(83380400001)(33656002)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i2OQvOT1O0wD9u3cy5KKcfzXc1jzdZg9W1PorMQZi++aaE790W2BCuw19mzI?=
 =?us-ascii?Q?XA+b/lQ9Y7ubU6vgSup7rR+RKltzU49z5GSQVeSWPycgk2VD6Ki1c75WQzu4?=
 =?us-ascii?Q?xfhTUZAvPLMV/A0GGcPCjXnJ61NRnicw7XJ/NCK8JpovJd4iIT1koJeEfL8H?=
 =?us-ascii?Q?sMvI1Nrdeyn6ou/l76+UAZG4+g04Ai942l10cnqv6Zm7RoauFdkRPLHtdPNc?=
 =?us-ascii?Q?CZ5SIUvQ2yyTRtH8+V/rOiJiJ8NWIk9CzGKzJOw9kvUp6vjrHHD43171tB8i?=
 =?us-ascii?Q?s694DTc7sOwNi6uljoBBs6XnfLh7Jk5AYF5DZZhzrZVWgQ02xRlmkjGmGFbT?=
 =?us-ascii?Q?4jZVNha1LpX1BGDZwe1QaGVqa+DZMvIRehuaIBjOcFMuS6qsUeUelEM26WR9?=
 =?us-ascii?Q?/ApOEggvZRLFIJH/I5k+wjhSxaNK05Ht67ANHFtT/BhSJPqXwdAz4mn4wbaB?=
 =?us-ascii?Q?YU309bv9cSsd0XngiIvqeQ1h0dAqa98rCBgzsQCreA9BAs8WvhJMmfDWgJym?=
 =?us-ascii?Q?GjGqcKpB5AGIf7wLJNDuCH41AG6EkBBTS+pPGhXvw6sei1EnOUAOLM/T7wes?=
 =?us-ascii?Q?MzY4rQ9ISyxvdUXQA5fMcP1nWQM98w3P4n03PeMa0V6fn5z6XzAtVr3ubsd+?=
 =?us-ascii?Q?QOXCT9ttpRiP02ZAi7i3wFJnOIJXc3396X9uNN5m7ZFzAbfqNUaLIPzrzD2N?=
 =?us-ascii?Q?Q2osUtj0AlKdPfIHRELwLz9J9hG/55vlv+E7osNqh3yi4otpzdhWlhEoTD0O?=
 =?us-ascii?Q?MHOZoIYvxe+iSaBZSVA0qXcKWos2VRamyI75uDQv5rJ2J/e2LqbanmyxEn4r?=
 =?us-ascii?Q?8czXXB7a9erzCOYmknoUVrGz3zew3g/NzxCzPz7dyEM/k5Hxxo1EQYLh1ggN?=
 =?us-ascii?Q?kDIC78BL7dEtI3dn3YkrE2BrnYjCV/vIcq+gfo8ToG6dcunLX7m/5GOeoRZu?=
 =?us-ascii?Q?7D/OUBgCwINpRfNJ5o9pORy0SMvGmcdW6geDev8CJexkAVQvioSbmUDTwo/+?=
 =?us-ascii?Q?qaZhUEqkAtHypQTXOv/oc8Vqi20OlalwfKbBuafj0ofWuC0H8Yo/QOBnHkBN?=
 =?us-ascii?Q?ZzKuZvLMXpItrZ31O9Z8WTrcSro9hovtEjbWmCk40iHSdXR32iYFkfyBU/FU?=
 =?us-ascii?Q?sj0BrYLOw131AwLsx2lmWpKJWChgvKTGxWH12DvLW/a/TXNbdVJJPYk1C/db?=
 =?us-ascii?Q?5QMaZA3qLDFQdOP9BdY16NbgQeTymCVrMGVj43RJGRSVVXVLCE75g2YKnvK2?=
 =?us-ascii?Q?AAwYYZ+UU7PDyhEg1Gb7cVoCESsLhnsBkHmO7coGZ0+aoR3tFHHCjN+zE7ue?=
 =?us-ascii?Q?orIuuDgkyQfOq4RZvbUmKzV221s7MC20nZtBcqHSfQAyaS2a8ffRru2s869A?=
 =?us-ascii?Q?naCGEL/kvQG8Lpvj/9xW7jFfqQLsDUu1aejCy+WiyA6doEKoqQazG9zLx7Kl?=
 =?us-ascii?Q?+cjN8mnc0AcA6+IErKpwLCB8m69ejmI1FYFiYgzZU8qWB2tqSLav6vq7KuaR?=
 =?us-ascii?Q?YMFObCVZq9Ss3Hj3HrMFjq7EmRvGvy2oCSg7H0xP8K4F0EUrUqJ35DcLlaiA?=
 =?us-ascii?Q?+9yjVpVUpkx9twunYX08M2urH8I2AARaBTDX4M52LOUW6NVi2hewEM3DyDhF?=
 =?us-ascii?Q?5w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <01BC4B5335FE904EAC67778E4A2CA7C1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 91VH3DY7SE/91yLQkDzizJX34I3yW9H8XZYaTl9sBEvow+woF8GuI37NlM1uztwwu1pQJ4rov7wWGSP8MZ2oand9rG/NFFqmSHiksuuHSBxBI0CoO1YguPHxzZEMjW2qc4UuBiiMF/Yn5DmbyEYPmyO4CWwpZ0LFO97V4H3Bl1D1aIOfmZTaBMiI3JYtj9xDYWecbppNPoglYalGbfcAuMgLLIbUT3Nv26xoAIyyxrfzkXDTZvErZk66KFtYYGxXpvbylDPOlsAh3YgFAFB+E6HF2tpeCec+XJ3ERS8S1hMlEl8azqQoyWV+sKT59a2SyMFyutACmc8UIAh9ub0vJb95wOP3IqepkcOyIiPR2nm9Icd4W/vcKKOuD9hyK+VU+9uWCoLdegGGy0bS9ZDUGjGOJAFWF7K6G7mvvi2VTDAaesH+8nUFf5GgplJcgoZHvML8MtB2m8xSHBWFm2iAf0dHsPE4MnRYm6rJUZdjI/cGrZkwV0AvpMrgxHyasUbkZBt5nAxOer8K0FQjWPqKq5BohM+k+hWvMFvkwTDupwPyNOGZLPDTTlL5Ldd6Iv1l68FHdNQhu/J6g5KmhL2OxeNtUS64KU1IoeH9GixFzmCC+N6akhF4tCTiBBMMUJDBK+0Kbu6Im21+bz8kQ+PS2e1IKLBtM1gfDRx5j9v5k3SqpOI7m18eiGMsMakWt0DYQ1W3JTgbLKPOrUSAjQyRIBiHMkWnRK2DHQgRmEuj9+zKn808hM/tdRYfarxzlcOF3TVKlF9TOg5VPG+omG0GrKm20PoAB8YtnoX97zzHL4Axl4uB3hKukkNFgXigpYIUOQBbLEthSPCe0thnktMouzGSe1J0zpnwWjEoFaEX42b1K9YRPrcVgQRBnwUpeDjWOrZaTLKjQ61D3VmfNg7/cbD1egem/p0nV27KEKrCl+s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2db0ff5-efe6-47e4-85b1-08dbb4813642
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 17:45:25.7107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yfo1n7eXCCaQbarjMvpXD+WwJ9od2QKaZqyFGxHG9SqRnhrudqml/oqDV0e5LRwqworvqlNMJDX7Kz8XDq+/qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_12,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130148
X-Proofpoint-ORIG-GUID: SdQ-kzftp8OrXuNaYoCLgdRNZHfmgGMm
X-Proofpoint-GUID: SdQ-kzftp8OrXuNaYoCLgdRNZHfmgGMm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 12, 2023, at 12:01 PM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Tue, Sep 12, 2023 at 11:14:42PM +0800, Feng Tang wrote:
>>> Well that's the problem. Since I can't run the reproducer, there's
>>> nothing I can do to troubleshoot the problem myself.
>>=20
>> We dug more into the perf and other profiling data from 0Day server
>> running this case, and it seems that the new simple_offset_add()
>> called by shmem_mknod() brings extra cost related with slab,
>> specifically the 'radix_tree_node', which cause the regression.
>>=20
>> Here is some slabinfo diff for commit a2e459555c5f and its parent:
>>=20
>> 23a31d87645c6527 a2e459555c5f9da3e619b7e47a6=20
>> ---------------- ---------------------------=20
>>=20
>>     26363           +40.2%      36956        slabinfo.radix_tree_node.ac=
tive_objs
>>    941.00           +40.4%       1321        slabinfo.radix_tree_node.ac=
tive_slabs
>>     26363           +40.3%      37001        slabinfo.radix_tree_node.nu=
m_objs
>>    941.00           +40.4%       1321        slabinfo.radix_tree_node.nu=
m_slabs
>=20
> I can't find the benchmark source, but my suspicion is that this
> creates and deletes a lot of files in a directory.  The 'stable
> directory offsets' series uses xa_alloc_cyclic(), so we'll end up
> with a very sparse radix tree.  ie it'll look something like this:
>=20
> 0 - "."
> 1 - ".."
> 6 - "d"
> 27 - "y"
> 4000 - "fzz"
> 65537 - "czzz"
> 643289767 - "bzzzzzz"
>=20
> (i didn't work out the names precisely here, but this is approximately
> what you'd get if you create files a-z, aa-zz, aaa-zzz, etc and delete
> almost all of them)
>=20
> The radix tree does not handle this well.  It'll allocate one node for:
>=20
> entries 0-63 (covers the first 4 entries)
> entries 0-4095
> entries 3968-4031 (the first 5)
> entries 0-262143
> entries 65536-69631
> entries 65536-65599 (the first 6)
> entries 0-16777215
> entries 0-1073741823
> entries 637534208-654311423
> entries 643039232-643301375
> entries 643289088-643293183
> entries 643289728-643289791 (all 7)
>=20
> That ends up being 12 nodes (you get 7 nodes per page) to store 7
> pointers.

I'm able to run the reproducer Feng provided. simple_offset_add()
nearly doubles the cost of shmem_mknod() thanks to the memory
allocations done in xas_create().

However, tmpfs is already fast compared to persistent filesystems.
For instance, even with the simple_offset patch applied:

tmpfs: 158079.00 Directory Searches/second
btrfs: 64978.88 Directory Searches/second


> Admittedly to get here, you have to do 643289765 creations
> and nearly as many deletions, so are we going to see it in a
> non-benchmark situation?

Most directories in a tmpfs have a limited lifespan and thus are
unlikely to live long enough to be affected by this issue. The
only one that has a rather unlimited lifespan is the root
directory.

It's hard for me to tell whether this is a pervasive problem
or one we can live with until we find a more suitable data
structure. IMO the benefit of having stable directory offsets
far outweighs the eventual slow down in the root directory.


--
Chuck Lever


