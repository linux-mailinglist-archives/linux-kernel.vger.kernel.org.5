Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD1579D641
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbjILQ14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbjILQ1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:27:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458FAF1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:27:50 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C9nUGr021527;
        Tue, 12 Sep 2023 16:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=EW54etv1dtqXSwpUuitynP6uBnTvffhJeCtQ2n5ksQI=;
 b=jPAMZBQPxx3VRgMrzuRvWLS0mngd0jRKFz909tm6uR9lpM9SkH5rn1aqqruOqkx1N9qg
 MoMHPHfHr6BypJu7kPz8V25c1Gs6WzllVxSJg3GMaoQR/D2ZZf/Se+4Uomk8TuD9OhZn
 qAqLrnUpAC8nd0m7MM+BxioZjbSUKbaiobN1dEfP/RyamoFOTVjj62HY8KC/LlruX3mX
 qitgJt91GmrylvPfQaj3LAsHebiy37krhjMGyhFIDe2vrJ23L2wcyxG0UlJFeO1INJ9Q
 XdjHjdRTcU9N091mTugG3cILUTaOnCqJntKUlfRzw/lPoIFjpD0Chp0od+ML3xdiKoEX +w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1ju1vdun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 16:27:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38CFFkEs033073;
        Tue, 12 Sep 2023 16:27:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0wkf98bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 16:27:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lyo+lJVfp26Lmws734vVSbmPDXev3MPraEct8Jspjc6j17O3hd7YLtj2oU95vrd/yKwN/Jvcx9VRYzPC2dqsE25otvBlaKFpnVyNu6Ms/dhCI6FYbdHiYy3ldybcLfNJUb9uQ+z0SSpMlIJaYMBCYIexUH+BOUk2yLjB0+1/JnOS33qwQcGbSwK/aiv0+YnJEqPSFt0JqeXBCtcpmIJD1hhgao0SwfA1thL6sWoUC7IoLGdTaAhJeDdFb+iBiTuJ4wISXz5O6UeetAnb6qgI5hYgH3RERS08Am+0uIQREVniv2ATZ2/kLm1lVu3SYdJoN7BQ4N52SAi6sNpVoGJPdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EW54etv1dtqXSwpUuitynP6uBnTvffhJeCtQ2n5ksQI=;
 b=kDBdvWcJb9yoI910wnjlwaivWE0GlxyDnxh/GaoRTSeGRMP3Azo8BE35+sovxWhCO9rPk1wBP8CYy8s8vGBGgmEZR8lYPpc/mUv66RKU3z8kCHZwXB2YbDF9PFDKSuAPg0JX7X7yB11pYMPRUViIQ4XPrCfN488HSCLW6dIct3MsUzeKQfODHr+o7JQ1cdY3FQVYsyoOuLu5nlTabDTFUuTMoGzH58GbL3HvcwQCFebIzJtNwRlsa83LzEirkfRdZhZytLv3j/U2AqLTc6i7oo6J8I+vo9Hj0r9OjXRuKL5m7S/rz5V3A45oJp1cfY2JumyrJCAsaTB5HLwmEcY+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EW54etv1dtqXSwpUuitynP6uBnTvffhJeCtQ2n5ksQI=;
 b=MkA1ubye56T0BVVhPzrF2X+NFSavxGZeizOCBsB7yQR3xYUJQLLORreqe727CKP0vdrfz4oiveRm49fQC7Zld5Cj6pCWDza6+OdKxHmHPfnd7JDkaAY5Acd4DHd/JpLAY+yuv6iffQk6fDVJjjWB+5U3ZhYSZ50SW/bSCPxabNs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB7007.namprd10.prod.outlook.com (2603:10b6:510:282::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 16:27:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 16:27:17 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Feng Tang <feng.tang@intel.com>
CC:     "Sang, Oliver" <oliver.sang@intel.com>,
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
Thread-Index: AQHZ4hUlovnTGopJRkWINRJx8jG2QrARAWsAgAVqhYCAAMJWAIAAJUUAgAANNoCAAAcEAA==
Date:   Tue, 12 Sep 2023 16:27:17 +0000
Message-ID: <FE37576B-70BF-47CF-97D1-DEEF0F33AD48@oracle.com>
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
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB7007:EE_
x-ms-office365-filtering-correlation-id: 48c0550c-c5e7-4863-fbb2-08dbb3ad214b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wmi0VWh6sOLUnT/BaWfnu+/GaUuH2i0vsGFGyDGDYYIjzPPkBtY3cp+xy2ibEnGrd1YajtqREg7rBAWi3A/qZVrarEnFWkS4z4LAim+NMh5EINNwRqdUZT+uRv4BfD9m4q0tdnBjHxb2iSWEJ2ivkcEd74bwZKObTjsC+hrx0uIyR3sOFabOUUvVw2boV45ydZQA5ulbosyaVk/TgfNZk9OworSWkF1jyB9zP4dcvzh9JD0niw1HbBn+rK4q5GMZsAwOY+n92GDMURLdBvVjzOCOElvupNMNQWqkkW5SEQRlCIGkzKOnzlZaYKthC/yLPvhjZMznNa33YymQDLWN5C1UsA7j5GgnH74wcB46Dv+Jt5nRvaSoWOk9KJDuGUnZRG1NsEbup3E6pUkWJVLHk3liU+v1ttpAcY49cQWqNonePxQ6WSgDXROO96u2hkwZzagYe1Y8vPSfGu4u0vWbw64xYlbdxuo8A4FTWU3f5KL/fEjBDc+HhIUpSOF0qCBst30Xb6rhhbDBHxOOKBUjj8YKAkQHEBB6SBSpzzxS72WGoHItqAE78tjsH9+xn2Twa7g+haNG6o5nCJITMIiIrtv0NH1EHu70MJlm5RJwVDYNgancD3DA8Rb4b+YYchaPOvnsyHbEvWsG2Nwkxldo+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(1800799009)(451199024)(186009)(66556008)(6506007)(6486002)(71200400001)(6512007)(53546011)(478600001)(66476007)(2616005)(107886003)(26005)(64756008)(66446008)(66946007)(316002)(76116006)(91956017)(110136005)(41300700001)(38070700005)(38100700002)(122000001)(54906003)(83380400001)(33656002)(86362001)(36756003)(5660300002)(8936002)(4326008)(8676002)(2906002)(7416002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5w1XJqjo+ZPvzeXYy5g+PcizWW1HuyeyxiMBPqcZwKbdQikZ0Q9H8ztZfVDO?=
 =?us-ascii?Q?CMkovHMKuHhtl5a0qbskOL6FcRvEsfORYKPy+rJjuDnM24//a9YbzRFuTN3J?=
 =?us-ascii?Q?iP+9GrlASOD1KW9wE+qtqGkMvs81WQeYbHn4IMfjS31lTbWjSQ0K2pCQRbgQ?=
 =?us-ascii?Q?M7UfTXoXz/+0BH4DDiVk5fc1RhArhNytFaTQzYBivZel1GQAiOT2cEwqWuSp?=
 =?us-ascii?Q?FAW7ZBHd8zpm7lLw3kZgoFQM22pcgffhdgGxQBq5FP6WxczuJRClmoa1+pqN?=
 =?us-ascii?Q?FCCAD7AmqbGbX7k+mYqG7MmjCrLXsYqUcVT3eVXD8IhkjXfEuezuh33tcMye?=
 =?us-ascii?Q?NfgBBn9Ewxd38lE4Cd6CcFtw+JEY8jdaLNCzNYeqvQG3RxWNTdgi2e24aAji?=
 =?us-ascii?Q?r86IDLnuB7ru/aNkxBt19UmVfgLAIn8HmDocHbJmdAMd7ZtS3zsylUNGveFM?=
 =?us-ascii?Q?vSL/OzotN/+vQSLwvDgkdvb4ap2fLhQliuUQJJLPkvpWweWOgwXvYkbBzcpq?=
 =?us-ascii?Q?VtT232wx9zvz0GCnuJ+sJygy0hwvlaAQfAtDKBh2oOSFKcI4PDy+QCYyeKJM?=
 =?us-ascii?Q?fCNtOVXmNf1x1KFGxn0ZtoxjhsV5w/e0nNBOKqKHMLfKaSISYXH2QCPl90uA?=
 =?us-ascii?Q?DoQOjuciU+MNnNEYl14iW0MhThiKV8hcZYzhx1Iq+OyqoktH7W6w3vECp/+s?=
 =?us-ascii?Q?oqloF7vpUs7cCnnFmaJ2EGPVQPnh4E/IAw3Vfe724d+TatkhxjNGZXGH32cX?=
 =?us-ascii?Q?nZ02/5l5q54oO38dcH83vsyZEiouvpkT3pyiJ206vPWQUqwPTJbSunPwobhv?=
 =?us-ascii?Q?wj+yeVvU8Y8vV2UxvXHWR312i8j/lLGkBAYZyFxR6Pb9Po+LK0iKUwcDyugX?=
 =?us-ascii?Q?OdVcHeN8FLMN1Z+MZOnfg/Lp6U4nygwAsMr8mEKhYobjC2JU+EyphvHANmQs?=
 =?us-ascii?Q?Bo/xi3P1BvFrWUoiBiVO2UwMzZoMMlOoO26Neg3hGaVjOWePH9MlHNtOWff0?=
 =?us-ascii?Q?4bmjxojFpbZJDrVZ8sw0cSBaARwzG+Y0I+lg5v3F9njFTVM1sHvZW8K9/il7?=
 =?us-ascii?Q?RI35rbMRFfSnMzSa67wZifN8GOYGRBv/ZMklheqfjYrtH/dfJUltFH7xQasA?=
 =?us-ascii?Q?6S7E6CyqZVaD5jCO5GDJIAAQn6+hYJZaZMxRfYBAaP0hd1p0M6cKkSElRIQM?=
 =?us-ascii?Q?24usyGKoKsKvpM9u0y8bA+6H92+plBQ+ffU3LR4odMoc0+5BEkz/rdg9qxNJ?=
 =?us-ascii?Q?+SrxSx9gclT33YVW6OOkgU1kE/RTaz+BruvQAEzQaGThZuzLabzYfpwXAmam?=
 =?us-ascii?Q?HgXTamdwoyEVcTTHZxw7Mkc0580XkauA4Yj1YAz9jLHu90D2LJ18oHEhGQ9q?=
 =?us-ascii?Q?qxkEF6Ov8zL9TVU8T/aBQtx1ezleXdgi3QxX1S4KKOcTLxkjYEqEB3RH7190?=
 =?us-ascii?Q?zpAYi9LdWmuGOcAVNX6c3mNVKcTEi68eq7ZY+PmZyb1qYBCW0rAqVA7JC2mR?=
 =?us-ascii?Q?uy0iqdVupAUfcJSKr/3OLPXrlYeQoDGZMrj8uisuH1PIQ2r6XmVleZH0g/a3?=
 =?us-ascii?Q?v5Rvi9HeoH4ACpT32srjt82L1/dEFovjeUoQ4V0GCeRAhQ4Lp3cqvIK/1zf3?=
 =?us-ascii?Q?pQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <440E7F0E7B71954CA39BDF52F57767EB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ji7puTLVzjniqnWjHHLiZbGbpDaZP4jvhlxHTNXxncbt+kmhV59QGyQ92iaGpjXmQF1DGNCxZ4k2pV9X6s9OcB4MUKmBuDv3ZW+4Gc8Yll3xtFCkg5ctEYOOcR84XCzNDj8i2Ty8rLxYCFXOvvzljuy8lwKMOIKu97MofBF7fpdk63qOlqq1g6HPLjR4aBtO1zwXSBP30sUHvNtk1zDDuNXdbQlx11yAeU9Y9iOdBy44iI8QvXDECNdV1cZLV2CIQQDFaLVdp9O70qxZsjLw/49AcNqLQL/ZjkRi3vxCsygeYc/C8DYal4B9UlaLPUGQ8C6sfktpiJ5W1YqOtrmsFdbR1MBDVQgYscJM8lHhUsHBzk6V72+GgfWGeIo54S400XNwIF2HjbeaIEduwEaCXcyXfcB15jdLpUkYTeW/3rGJkuWfuEdi1wzccq/quvuLTbnjErWIbDCV3YFt/IVe/5tvhnGA3cw5Ek/45P9O0XClGSab8uPiiMWc8jAwW90shGdk1ROKoNI+iZ3IOuoNvyBGwFWJyRpi+ZyGn37d+Bwo+SSrc4aaqclPdk7FjTuloO7mQc6LWDLQ3EPeaRZKArrv6ziyHsQKGYoFzaMGPXRU1YYe9BmzLaF+7Yw8JBVDg1fWc1hv6Q5E3I1ukha1ImQN0mKM2lQL5rg1mCliLRxcab9XkscVuFT66Rt7/+4m2rSZst/G63wbNOk6DLeqgKT1QXQezCqUvQ1fUdHIo85ImdM4ne3id2J6HPk1RuUo4Yog02nQmt9oPwnUAGotTJhVXJ0YXYhtdaA6K/fPLvwOBPc2uC7/HtcnDhhz81GBK0ebr1oAITDbTYyafc5Bk9TiBHNcKvTbKbzAjhJV3sxd1tL/naVKseXWJ7nwmIMrtLmI/nrvHXzKvS1ZugTAMptCh8KJfguu0upMIZMHLmI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c0550c-c5e7-4863-fbb2-08dbb3ad214b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 16:27:17.1957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oSKHZI9weM/X3lTjnuby1EI/+d3nC2b/iC6uZ5Kd+M5TCLUn67Gxca5e1mVrBaqxdfqyepKJo1CACRHupZ2X8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7007
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_16,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120137
X-Proofpoint-GUID: Ift65-PuKJfkv-qeNSw9eE8DGup2GOmS
X-Proofpoint-ORIG-GUID: Ift65-PuKJfkv-qeNSw9eE8DGup2GOmS
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
> pointers.  Admittedly to get here, you have to do 643289765 creations
> and nearly as many deletions, so are we going to see it in a
> non-benchmark situation?

I would imagine that a system that is up for a long time might
see that kind of fragmentation in /tmp, eventually.


> The maple tree is more resilient against this kind of shenanigan, but
> we're not there in terms of supporting the kind of allocation you
> want.  For this kind of allocation pattern, you'd get all 7 pointers
> in a single 256-byte node.

We can try switching to Maple tree when it's ready. The simple
directory offset API design, I hope, is reasonably resilient to
changes to the underlying data structure.

Meantime, I'm wondering if we can see the absolute performance
numbers rather than the percentage degradation? I'm curious
if we're talking about the different between 2 and 3 us per
operation, or something more substantial?


--
Chuck Lever


