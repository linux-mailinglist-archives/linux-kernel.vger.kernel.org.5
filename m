Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7316B7C911C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 01:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjJMXAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 19:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMXAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 19:00:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353BBBE;
        Fri, 13 Oct 2023 16:00:48 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DLJNwL017946;
        Fri, 13 Oct 2023 23:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=qR4gtHYp0WiL5G6YGHpdcUDpooBoCJ+0XbKGhQJvJY8=;
 b=Wd+6jqg2vjIwBmnCtuMYE7LwjJMkKO/vO1QApuM3u+cTzDHYBIxnsyImax2HesCrBVUP
 k7OJfc2BKWtENIyGfV5UMfZkur4aTp5neWrM/8idUbPbbpAvrYNatEeU10GOYho1vdXp
 j6W+kVomc4gxWwUaUb5tN2TbJ6FLGZuMSqqxJOf2RK/l2wdLvAiBTf2rr8G1xOfK1gUu
 X3KsPeJtktq+0NoyLJ5qDhHxyXjsud0UAFYbn8DSBdOJZ4SavDb4yOBKcz/HMXwU5HXk
 wouD+EwVV+p+VEiPOsQefZ6MTEbXSvfdHa7k2kGPbmTfeLtBE13bsjcvRJpM9+1Ewlq4 8A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjyvux1qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 23:00:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39DKs6Nr036781;
        Fri, 13 Oct 2023 23:00:38 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tpt0v25fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 23:00:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+sQiejcyhJVx6N72f1RxxJToTrrmWscWqEcZXZAbycXZZiqpvKphAO9h+7DtXd5tHQoLnyokZ+VquZobaaqJITjSvW6bQpXtwN+ieXSSFJ92FSK0HcN7l0XWTZtZPhuNEVyhTmuWWdKre4IAUyrspSCkNetYFzP6WOkAkSRCR749pbn6NN9GkWh8+CVDBnkqvsnkVHvz5iRASnx3EIHWdz5biJIokdpSbYj6hFZccYI4pbohMMI9itPNHx7hlb2bMgK2+LaFu328zquJRNmkUe6i8lqZO8JLmwnXDmyoMQe+E0QjOdVU8VxfiydRvmne/vN74qMVmGaKntAmRVblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qR4gtHYp0WiL5G6YGHpdcUDpooBoCJ+0XbKGhQJvJY8=;
 b=XQY/Cp73SbmegDNqiLtQcUkyl4Hfd+i7h/QgmxGhAk46wAWNf0dE3K5eEjorFgQXLSKkr/8KmDrYuo1v6vyfvaPXSFm9BJGATAE42p/VHv7MdIO/GWjPNSSvTB4i3hEyqr3I4MBnlom2ac5edYNbxTfrBqm/at3uOD4A6qGkSdT3mRhzyFSKncjvRJyXDrm3MElh1zDgBMw/hPh3nHuiEh8IZsLrgmIJ05fPGJ6HpUNvRfqKu0uhsQVS/x611BdsgygnzIPyLIb93Jrp61r6+WVJeejtNI+fZzvdTIEMG7i21jAY0FJuvyZs6EPQcmH49vUbqbUZWFJBz7Cs+OPqbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qR4gtHYp0WiL5G6YGHpdcUDpooBoCJ+0XbKGhQJvJY8=;
 b=dxEZeNkeN4aoUdS53deyEGa/XNh32WOfvS5ZFJigHD5A3EOfUWHJ9Wvu1ah7HqCLH1fzgf1T0dutB2kLgvLZCp0ck42L+UEmF+tiNFtTUa2Teqk4DGvQE1HB/qQhtQS0gGPKehOnbGnTLLwg9EIL4SdIyp1h3dOz8mylQzrkIlM=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by PH7PR10MB7034.namprd10.prod.outlook.com (2603:10b6:510:278::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 23:00:31 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::f5d4:dcca:5e7d:ad91]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::f5d4:dcca:5e7d:ad91%6]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 23:00:31 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     kernel test robot <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Liam Howlett <liam.howlett@oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [linus:master] [connector/cn_proc]  2aa1f7a1f4:
 BUG:kernel_NULL_pointer_dereference,address
Thread-Topic: [linus:master] [connector/cn_proc]  2aa1f7a1f4:
 BUG:kernel_NULL_pointer_dereference,address
Thread-Index: AQHZ647wLdBfKiOcokm+jxdng1npYrA52wCAgA6f94A=
Date:   Fri, 13 Oct 2023 23:00:31 +0000
Message-ID: <E79EF019-0E7F-4935-87AB-6A543A134E35@oracle.com>
References: <202309201456.84c19e27-oliver.sang@intel.com>
 <20231004084011.7aeef442@kernel.org>
In-Reply-To: <20231004084011.7aeef442@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|PH7PR10MB7034:EE_
x-ms-office365-filtering-correlation-id: 49f2a515-6bfc-405f-e80c-08dbcc403380
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wdfiNrAK55Z5r7CGjA/PUQ14GwsfvboznRMtgB2DNBIFyKN+wNvKSvQmKRBgEzqIacV3eLviCc8wOV8VHHsjV2EfZiEDakRNiQyyjD+ITXx1xcDVmka1PdmDHuKlM2bYNc1oDADu5xnLr3jfTJO0RP3EhgifdCuZtQIUsfTa2dtWYI6cBcls2jldl3F3CCvF394ZPWm40Uf6qnDcw1j5VPv56lnFIwcZsFAIF6REZlyJCnexuV5HfJMe9M6VoYiUC+W3YRQ7f8y6r3teGz4vWSyjp6QGMC5ZARhRvr1a2uNaJu/5H2c6lZaAmd4TwIQSSe17MlItV+YUsSm2yxVQ94MFtC5Hcjxmkl0G0PQCNbzpacgdmLfmeOHNWmguOP87JMZx9G0CI9KMlIZ/Rxroakebr31N+NkVye7biRV+f6SH83wTIY4C4WgDRhc1YBvBr1wf1K8FeHtjKbzyI34IMUER7KgAfr5M9+KWXnPTorznMwWqobB86uVoF40+76BizTe3ZqEJmgmQZ7apYjx0nrfeNhxqMksr0Bl4yfTOCYIM+C795MKMdpSruuL8z+kVB51JEV2VXXBs922FzSctzD8lKdzVwM/KA+Ig+ib5h1u1GVDr84JB5HRdeJVZM2ivWT87XMTkw4auOddmciecKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2616005)(26005)(6916009)(76116006)(66556008)(66476007)(64756008)(66446008)(54906003)(4326008)(8676002)(8936002)(66946007)(53546011)(38070700005)(36756003)(122000001)(2906002)(6512007)(71200400001)(6506007)(33656002)(83380400001)(316002)(86362001)(5660300002)(38100700002)(478600001)(966005)(6486002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ck9EU3VyWHZkMmsweG5iWEk4TW1rWDNydno0LzYyN0d1MTQ0QkVUb01IdEwv?=
 =?utf-8?B?V3pzVlhZWDdYT0dsSlg1REcycjJzc21OVnBDQ0ZiQjJDeTZaTUtGeGJJbjJu?=
 =?utf-8?B?bWNDb0d5R0NiUE9McytzRHlHWjdyR3gxKzlPZ1RwME80VzRmMzk5ZFh2djA3?=
 =?utf-8?B?SGtucWNkMU9LNzZWVFVGUXQyaFRVRmNWTXVQLzY2T3dtQkRGRThta0M2ZHhY?=
 =?utf-8?B?ZUlGeGpRRU10U3hJeFI0QmorNlo4ejNoQTREY1RORXAxMVJTRXFrSXlwdEdE?=
 =?utf-8?B?djMwNklvYkYxcTdhaE9McjB5ZlBHL1RIWlI0ZGVXMDA4cGxBVkc0dStJeEY4?=
 =?utf-8?B?Vmo3NTZGVGdmTkdnVTRCbHVBUVROdEVaRjl0aGJIZGhEOEluOC9ubmlocVlR?=
 =?utf-8?B?ejgzaWhZbUQ1N1BhdmF2bUh1MEU1aTFTV2VxZHo4WnEwYmJGSFJ1ejRXSVQ0?=
 =?utf-8?B?R1k1d1dPUEpNQzF1OGhYbGo4TTJ2bHlNaTlVemdsUkVnUk9MTlRGNytTamFC?=
 =?utf-8?B?NzFzMWdvdkM2OGU3amk0bHQ3YitmWkJFTzBYcTNOWUF2dTF6VXZjOHQ1SEw2?=
 =?utf-8?B?dU16VzZLS1dsU0s2cXl6QlYxWE1sWTRVMm94ekg2R3FsNjhTM1cvV1RBQU9G?=
 =?utf-8?B?K3BONG5RN2FZVkllKzMvUGJlb1ZPcHByazNRL1l6a3Vpc2pzVHYxNm1zWC9n?=
 =?utf-8?B?YjM3YXBHUmhkM0hGeGp3TEQ5MHdnYlZBbFpBVVdYbEhtL0VLbjAvQ0pxdFJs?=
 =?utf-8?B?NlVFQld5Ky9TcGtBamsyY2Q1bkFZc3pNUGdFeWVBbXhQWm9KTzF2YytZOTVl?=
 =?utf-8?B?MlZONkVZUWpmVldPM0lpL2FZbXh3WHFVTDhoM2IwMG0vd2NyWFB1TCtPR0h0?=
 =?utf-8?B?SkIvc1F1QjVkbzRiZDZ5NzRXaTZEaUZneGhUcWc0TVp5UHgwWUlQTUl4cXFE?=
 =?utf-8?B?TVg3VmVSR2VnS1ZPdUZyZGxnME9waXlwd2ljTGVBZG5QamdRVElTWWZtRTRK?=
 =?utf-8?B?Z0pIL2lrcjBROE1nT1Nja2NtbGxPVjBhSU5SeW9HOUUvZFcwWitja3RURkJl?=
 =?utf-8?B?SHR6UzZNaWhPRkZ3MTV5L3h2S3h5aUJoL2JacUdHUzQwMzBIZjJvVmluelU2?=
 =?utf-8?B?TVpoSy9SRHV2MEo3bHVmc3lNRTJhZmYwVndHYkk5dVB1MHZra21Pb21GSFFR?=
 =?utf-8?B?K1VCWlpiSVZiR0lmR3IvZE1ZQkRBRmNDSzlRS2xTSDlaVHY4aGxwQWlUWm8w?=
 =?utf-8?B?VVRsQjM2ZnZzbWxWbW10YmVIT3NBeThZdXRPUFRvQTh4d2FZUjNhRGhhdzVG?=
 =?utf-8?B?cWhlbU5scnBWbWJlM3d4bzRQaW1jeVpudDViM2l3UVcyYzBybUJPQnZlcWoz?=
 =?utf-8?B?Z2w3enE4b1doTDRCUnNLR3NvYm1XZWhUamJOTnJnTEZwT0oycG11R3cwYVQ5?=
 =?utf-8?B?cFBOVFpuUjFiK0c1dFlqekphRWFnb2swNENIdGJzbGUzdHNLdnduUXJMMTZF?=
 =?utf-8?B?eWxnTnZFVDRxa2lLY1l1TkY5ZWxrRjFXbWpZWEZLOE9ieVpEUTd0SVJ4NXlZ?=
 =?utf-8?B?N3poZWtPZVpUUWZoTEoxM1BmVjZkc2Q0RkROeGJNQVlQeTg5SVBLalJ2UW05?=
 =?utf-8?B?Q0p1czRWM2pUUkNjc0c1Ly9OeUUrOWhmWG5wdzZIZS9DTC9xSTNIY0dWakZh?=
 =?utf-8?B?aUdYSmlrWjZBR2JqLzN5MHFxRUFRZGhLUENBYjA0cGxXUTcwZHpqSDJhcmV6?=
 =?utf-8?B?Y0xweU0ybE1OSDRmdTI5M0p1Ym5xNDR1YTFmL2pGaUpDVWtVWFVpaW9HMjMv?=
 =?utf-8?B?eVRsTWI4dXdsOVBoM2NWOUxTOEpHTWFhaW5UcVpCcThnTDgxMHNwR3RDekxW?=
 =?utf-8?B?RUNGQmJvVGtmSmo2V1lJU09zSU1wVTVZTlVTU2Z1TUExTDB0U1BTcElYMHQ5?=
 =?utf-8?B?NG1HUDJwOFV4NVFCSHJWemtDaUdFa1RNZUtGZ2d0dXhGZ1NadEVnM21oQUo3?=
 =?utf-8?B?bmVxdHVZTWhWNDZNZWR4YWJ4TEtMZlNoZ1BXcFlsZ1YzeE1xTFprOUxxeEIr?=
 =?utf-8?B?SU9maEc5Y3dVV29QeTArY2pOM3ZuN0ZxcUh4VFA5emV4eWxwUFZSTmxnbzdX?=
 =?utf-8?B?QnQ4SWdFdW9MalFPY0NmVEVBRWo4SjdJeUU0SG00bGNoOUlGbHYrbjV0ZVhL?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEB5C5DF63E6CE43B0B5398B1FDC7F2A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VbwYfHQxk0L+tf32D3rDCFEUfd8dLFE30Y0EfuRtQrrGELgVpVCgVozwKpHYQhG2Vc6MJ9kGVu+KLJM1/cYl6qO2vTAxmkWcMQF7OKn4e1hJsXZe6+flAegrt/CMBGbcM6bwnSXdVkC7vCx3TCIF1S/B14Fkyf2vYA6YIzF2VI5NVD/IptveRKC3nXZ6UXkAxkXaFm84H1t8IXDWeavz6/CYnTalgNtGQvRu7+4tZxd4ab3Jk7xeizzpj14NwTww0dN0ARZ+P+ieGLzHwJm4Uafr4u9Dd9iy47sx1aFSXNVCpr6JpLTGWjl/oGF8VeYwgY/IHKP0QZxA9JBLa40ZFi0CVAmv7rCx/S/0Fm8ZtrxTc7ruhTTzsn/N/FsGZY6cS/TJ+eLO8gMOVyHEtS4Rw52EMrgC41W2bcZlg8govCRPZ5kcd+RMltEpqPnIykKcB6SH5lUHpRzkbodwifNhX0vWsUASf/vRH8azEdyXfb6r4rb7rzsKhV4kYqFDfbxpjVnKDxJ2uUdf02bPOaHDyXuXWraKM2ZUpQVK9S2s33j4RgAC2Ry2cLTXo11inI8TGlTlxG1fGS6XFv3UDt+p3pC99+Rg7tEhfr6RaNgCKLvqlvEfxYVfba2ijxgrxxWf618humU7mVVpkT7DNcb3xG5Rshf70v72RbV5B8p51aC93W7botZlow2+qhZ84i1WPLdynO5ViaLPeOyk5frHpmTF3JNVcXVVavdlVuMbt5TkKNHIoPAfnvPVAf2SgZ08jgC6cmOM2nZHlYZ/S2MRZCu+h6EY00TvHPnTKYxpjQdOUKqpMW7+kWatxRsv7UbW1LEUo5kA3zkVxG/aMIbzxcdgFztN7Od6ExYZg5EaEOVLnTv5pVbjjrBBnY56IQP5srtHEiRnRJFWjvel5PVB4Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f2a515-6bfc-405f-e80c-08dbcc403380
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 23:00:31.6843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qmve9brbA+AdbGqoq3NwlHEYvhHkwydFGv+wREAoV5xANLUfgyIKmtF4BPZaq6UBsz1CKMLuxsDgY5yyyhDG5f8eHJRw2SShskZhKiqz2YU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_12,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130200
X-Proofpoint-ORIG-GUID: lLv2EEoOALL0M0FB4yL2EqLy_zTbyJqL
X-Proofpoint-GUID: lLv2EEoOALL0M0FB4yL2EqLy_zTbyJqL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDQsIDIwMjMsIGF0IDg6NDAgQU0sIEpha3ViIEtpY2luc2tpIDxrdWJhQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCAyMCBTZXAgMjAyMyAxNDo1MTozMiArMDgw
MCBrZXJuZWwgdGVzdCByb2JvdCB3cm90ZToNCj4+IGtlcm5lbCB0ZXN0IHJvYm90IG5vdGljZWQg
IkJVRzprZXJuZWxfTlVMTF9wb2ludGVyX2RlcmVmZXJlbmNlLGFkZHJlc3MiIG9uOg0KPj4gDQo+
PiBjb21taXQ6IDJhYTFmN2ExZjQ3Y2U4ZGFjNzU5M2FmNjA1YWFhODU5YjNjZjNiYjEgKCJjb25u
ZWN0b3IvY25fcHJvYzogQWRkIGZpbHRlcmluZyB0byBmaXggc29tZSBidWdzIikNCj4+IGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvY2dpdC9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4Lmdp
dCBtYXN0ZXINCj4gDQo+IEFuamFsaSwgaGF2ZSB5b3UgaGFkIHRoZSBjaGFuY2UgdG8gbG9vayBp
bnRvIHRoaXM/DQoNCkhpLA0KSSB3YXMgdW5hYmxlIHRvIHJlcHJvZHVjZSB0aGUgaXNzdWVzIHdp
dGggdGhlIHN0ZXBzIGdpdmVuIC0gbWFueSBwYWNrYWdlcyBhcmUgbWlzc2luZywgZXRjLiAtIEkg
YW0gc3RpbGwgdHJ5aW5nIHRob3VnaCAtIGhvd2V2ZXIsIHRoZSBzdGFjayB0cmFjZSBvZiB0aGlz
IGlzc3VlIHNob3dzIGl0IGlzIGEgTlVMTCBwb2ludGVyIGRlLXJlZmVyZW5jZSAoaXQgbG9va3Mg
bGlrZSBpbiBjbl9maWx0ZXIoKSBmdW5jdGlvbikgLSBhbmQgSSBmb3VuZCBhIHBvdGVudGlhbCBz
dXNwZWN0IHdoZXJlIGEgY2hlY2sgZm9yIE5VTEwgcG9pbnRlciB3YXMgbWlzc2luZy4gU28gSeKA
mXZlIHNlbnQgb3V0IHRoZSBwYXRjaCBmaXggZm9yIHRoaXMgLSBpcyBpdCBwb3NzaWJsZSBmb3Ig
c29tZW9uZSB0byBwbGVhc2UgdGVzdCB3aXRoIHRoaXMgZml4IGFuZCBsZXQgbWUga25vdyBpZiB0
aGUgaXNzdWUgaXMgcmVzb2x2ZWQ/IFRoZSBmaXggbG9va3MgbGlrZToNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvY29ubmVjdG9yL2NuX3Byb2MuYyBiL2RyaXZlcnMvY29ubmVjdG9yL2NuX3Byb2Mu
Yw0KaW5kZXggMDVkNTYyZTljOGIxLi5hOGU1NTU2OWU0ZjUgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2Nvbm5lY3Rvci9jbl9wcm9jLmMNCisrKyBiL2RyaXZlcnMvY29ubmVjdG9yL2NuX3Byb2MuYw0K
QEAgLTU0LDcgKzU0LDcgQEAgc3RhdGljIGludCBjbl9maWx0ZXIoc3RydWN0IHNvY2sgKmRzaywg
c3RydWN0IHNrX2J1ZmYgKnNrYiwgdm9pZCAqZGF0YSkNCiAgICAgICAgZW51bSBwcm9jX2NuX21j
YXN0X29wIG1jX29wOw0KICAgICAgICB1aW50cHRyX3QgdmFsOw0KDQotICAgICAgIGlmICghZHNr
IHx8ICFkYXRhKQ0KKyAgICAgICBpZiAoIWRzayB8fCAhZGF0YSB8fCAhZHNrLT5za191c2VyX2Rh
dGEpDQogICAgICAgICAgICAgICAgcmV0dXJuIDA7DQoNCiAgICAgICAgcHRyID0gKF9fdTMyICop
ZGF0YTsNCi0tICAyLjQyLjANCg0KDQo=
