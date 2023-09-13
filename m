Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A86279E95F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbjIMNdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241005AbjIMNdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:33:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B252128
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:33:12 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DBZX0S013578;
        Wed, 13 Sep 2023 13:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rdro+bKOY5Ud4F9M/OtghXJ9cBYRk8EoXQV9Vr9ZjnI=;
 b=m4CMiq62JP020PEbOOQui6TY42aA0D4L7ueebGhhZPXP52oCXj8VRfUyLYy9OhPfGA4O
 mbcYabe/9qM3XejlMgO+fJ/2Qu4JnKImw4NTkfRyLjm+21zv0BIknECr6rrO0ON9QGQl
 NwPMTheA1zgrkGIVf1z0mn7CCcMD0Db10kONv7M7Ia5VbsgltE0eIvSbTZDRHdHG4kbf
 ncwSLYNgn6Brj1kXxflnkB/AeKfmIY6TwQ7NoQs7DjU6gLcny7H0ml6yZoYGxPCAhfS9
 8C6VjDt4gjBeMR/mLzelcwF8xSiPMPSUTrAtxVUA856wTI4cosjctgSVC16Xt0ShMxsD +w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7khx92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 13:32:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DDGY3l007773;
        Wed, 13 Sep 2023 13:32:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f578b4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 13:32:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3OtJ2mrYKI26473ixFNMqFvU4MSoPy37MHkAtB1W2v+Z7efcQj+evolU3m5zN8c7fdvUcj7zPKZJ45r0qYbe7D8tiYT/9S6rj/+abhDnApfDU80Py9TqLkU7zLht6/fKD3/vLX8vATFwKQ1QWuOjqEkEdNOZCnIW0NiwAAH3sm9fg5UJnazIvh+kT/It42m9kWeRJo+JxVX+ITELbe92192RAX8Ht30h+gmcqMrlONpMaM0JUTNWJZ9J+5fMZociA4QlqMXBoola/MTVPvfPKj7YnMKFfXA/vBMp2kjkKUsWLJdg6WOs+1rsGNYMikYfeKPsInp+fScRSJjSeVg8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdro+bKOY5Ud4F9M/OtghXJ9cBYRk8EoXQV9Vr9ZjnI=;
 b=MsUunSRs4YPQNre0CRVu9dOfONvtpXutInjhxt//U8MScsLBBQpDlPy+bd7ZKrbKD5USwkEJ2tgM8O47y+v2rO8HQatMD3cHB7cz2Lq7q4KG2oC1T1uL/oL+Gy91B81ytHmlvrcLWPZsMK/I0ob1902QPb3s9691EFehmbf3Kg4TmaVnGKEL7i1p+ftuyB4FwBYyJE5y1TR6DIO6ilRjAJAFlQijqm7zLSFkCOQ3R9LYOMtN15D+Lt1KIsRIjR9dFUJgKXMAULpm0Cv8ZyF81tOqV47omtfZrTj/oS49ZtaF0XiZAiOI1w/Aj2Yf+opKSzSZ73/rVSFpxtmSBObc+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdro+bKOY5Ud4F9M/OtghXJ9cBYRk8EoXQV9Vr9ZjnI=;
 b=rKul3sxrEcUDen0NXoOwnAK3tUeUDb/2UNr6i/TEleFa4bai6Az8FdSMW7KOHqMJ1DgXpJD+//P84w5gP1JUk9P1E8IMnPtLGKBdUPg71c47bPmDv8mvC1jWjvvYjO1OQgUNHieguG7ErKBI0977ZHdJtT56rUGjSn59h5zXwzA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4545.namprd10.prod.outlook.com (2603:10b6:303:9a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.36; Wed, 13 Sep
 2023 13:32:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 13:32:50 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Feng Tang <feng.tang@intel.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [linus:master] [shmem]  a2e459555c:  aim9.disk_src.ops_per_sec
 -19.0% regression
Thread-Topic: [linus:master] [shmem]  a2e459555c:  aim9.disk_src.ops_per_sec
 -19.0% regression
Thread-Index: AQHZ4hUlovnTGopJRkWINRJx8jG2QrARAWsAgAVqhYCAAMJWAIAAJUUAgAEEf4CAAHFTgA==
Date:   Wed, 13 Sep 2023 13:32:50 +0000
Message-ID: <2EF8A3C8-DF03-454E-82D9-DBC1FF7DF56D@oracle.com>
References: <202309081306.3ecb3734-oliver.sang@intel.com>
 <C85F44FD-BC7D-421B-9585-C5FDFAEA9400@oracle.com>
 <ZP++GV9WURg1GhoY@xsang-OptiPlex-9020>
 <84984801-F885-4739-B4B3-DE8DE4ABE378@oracle.com> <ZQCAYpqu+5iD0rhh@feng-clx>
 <ZQFa5x1THIYuagWR@feng-clx>
In-Reply-To: <ZQFa5x1THIYuagWR@feng-clx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4545:EE_
x-ms-office365-filtering-correlation-id: 37117a70-fca7-4357-6676-08dbb45decef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SshAQYUIJkW33OvWBCyhtguo25myztlQBqHDqJaMVXN3UoO3lioxzA3+EgvWeormgj5sQcfIDN6XkRQoGDLLCIvmy68glHul1p82ZgQTBaR5370mQFz5V16vgBKk16CmH1Cc+OlQFawlnAJNJrIo/3EfB73+8Ej/UKE0Zkfbx4jYlmd4JDw6NUEMGhNvVX4n/uuWuGUnW2GZ6T9Lv0KVot0qe84sRG5mxyE//kH/hT+uAyEJWR+LSIqDkgDa+bmAXtfzYnm7WYfT5QT5DId2yxX65A7e1zEBWihXhE6WVHrOyZcIs1GUS3wDNLGwrn3JulIZgqRbXE7AvR3jMEU3myu3glcxE+mD8MLGb7tLRqlooZVHevNwCXqPb9I5R9H0Wg/V/C6od5U89WbTjvqGycDheax+Z3uhkH50IETmrc9LF9FjfnhVGAr4UshMl4BFNCuT2YWx0UTOvyOoCxqQJkcU4vCVpnB9JlPox4+LV/OZQGMyu3PMUZ3BMR9vjgOfAfqExUdN8BKbiaPN1rfwnEc80GvohXex2yrlQfZ8Hf4DwkPFc3lUe1g0hIcVs6UtaPtOOBblOArz0RcwodLkgtHPwG3LopgGFvVhcX9f20mznjTcgAC4T1VCjUqzriZQ7eyQzk7knvyywIbTENo+rQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(376002)(396003)(1800799009)(186009)(451199024)(2906002)(7416002)(71200400001)(86362001)(2616005)(6506007)(26005)(6512007)(6486002)(53546011)(33656002)(36756003)(38100700002)(122000001)(83380400001)(38070700005)(966005)(316002)(6916009)(54906003)(66556008)(66446008)(64756008)(4326008)(41300700001)(5660300002)(478600001)(8936002)(66476007)(91956017)(66946007)(8676002)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3c2K3hFK1dUMDJ0K3ZYMTVENUdreExGUnVGWk9PYVRCMzBzQThYWDB0VVIy?=
 =?utf-8?B?bEswOUVwa2xKT05xYVJzaGxOVWF0VEwxRk4rTUNDZlIzUHdkRnBZQXo2QmMw?=
 =?utf-8?B?NlVuZFYxSWZ3aTMwMG9GM3NDSVBwaEw4bFdhSEtxU0lTRUI0bi9oRTdCMi9Y?=
 =?utf-8?B?d1k2QStVM0h0cTFOdnQzRzd3WUJNN1Q0WmplNlBvR0hjTlcyZTVhSVE1MWJa?=
 =?utf-8?B?SW51YnZzMGxxVVE3L0RMMEJzTTBLTVpQcHdpVWEyb0VWSUdyZGFSSUMxcUpi?=
 =?utf-8?B?cXR4UDN0ZHBRUWl0bHV1Z05IeXd1ai9IaWhMdyttdXBuUkRCUzZhRUoyb1Q5?=
 =?utf-8?B?Y1lyd3lZOWJTM3Bkb0dCM3hNVE9BWWF2cUFUWURoN0pENEtVdW9JV2pNdHE4?=
 =?utf-8?B?eFdPdEVIWjZyR2tkcnp6S29ZNEJHOExveittUm1GMXpnenB5VFdtcUNCNDNj?=
 =?utf-8?B?Ti9KSXJwaDFUYXNyVWZiSDFNSGxqdFYxa1BoSHpJeFBMOXBRV1hLZ3NzM3gw?=
 =?utf-8?B?QjRQVWI2VWVvb0dvOUtjNENOenJFTmJ2QmlYemFjVEJIRk1IVnI0WVk5a0tM?=
 =?utf-8?B?Y1JkOWgvRUtzNlkwMVBjK1lZczlLVlVnSkJGcGtLbEFMNmsweHV0aXl5bE1r?=
 =?utf-8?B?V241RnVPSnFXK2lMTitIMS9kczMzLzl6RmExOEM2ZGcvUG1qWUU1S1p4YUho?=
 =?utf-8?B?UFFKREZhRytFdFYwYlJyOWdncGY3dnNYMkhDMFo0RlREQU03RnovWTJLOEZJ?=
 =?utf-8?B?emt1LzFzckk0STJqUlpDR0hQcTBTeGZ3MUpjWkhadmo1dHYxY3FjR1ZLbGxv?=
 =?utf-8?B?NmpPYU9PbUw4czFHUklXRjROSXRXei8xakVjN3E1Z1dNMWE2eUtsNmpTR1R0?=
 =?utf-8?B?YWdDalRNSDhLMHBNSU5OVlo4U0dLV2JleHNXTmV2TnVxMlJsalJGYWZ0Q2Jp?=
 =?utf-8?B?Nko1VllvdlUzYTRiTUNqOUZYUzdzMU8wTG5DNkdUazY1dERhRnY0cjlWRlF0?=
 =?utf-8?B?ekd4T2ZMeUo1eis3bUVHWnpoOTkwdkgzSWNzbkFDZlFzdmc4Q1Y1OHY1N3FF?=
 =?utf-8?B?KzNFSGlHUEdhZVozUWM2WDRpQVA2ZmpoMGk0S2YzcENSb1RxMW4vVmdqK2RV?=
 =?utf-8?B?N2hHSUpocGl4VTBSeVNSMk1GYy8xZjlHb1pNd1U0Vkc3aWhDcGVGK3pqS2F5?=
 =?utf-8?B?TkFScUx3aXYyd0NtN2N3L2FyUnN3aUZ5RXVFazZxWlNLTy9xU1hQS2RhL296?=
 =?utf-8?B?SWZHdFltdDBGcklmQmtKdDNTenZ6QVpmRUN0a2Z6cnJ4bGRTZ2JOdDRGV0Vp?=
 =?utf-8?B?WGhyZ0ZNMFQ3STdaVWtvbEh4QnFPSG1NN3VWK3pNMGFLbE4vN2w2SmN0N3Nr?=
 =?utf-8?B?QjZ0byt6VitaUTVyc1VaamtZazdPelJTYVNCakVjNXNzNnFFQjZQc291Ui9Y?=
 =?utf-8?B?YnJYODRDQlVjdjlrM1BsdjdjdXZuSmlVM3dTelovWVk0cDRYWThCaHBtMWJj?=
 =?utf-8?B?bnhBSFBCSHVaUmhmVVlzb2hRT1NHeGlMYit6WWhCYlFmQzJ0cDBud2hPYnFa?=
 =?utf-8?B?bTNrWjkxSW1kdFZIMis4dmlkNmRTSGw5STlMalExdUpKT3VmcUV6cFRETmpx?=
 =?utf-8?B?cGVoajEvZFRheVFCTnZVY1BoejhIb0pGYk9pMVdFSS95VVF1dmpSWkxhTGxH?=
 =?utf-8?B?emhENkVYWnlaamFtVGpwSUxXT1I3cWVKM0kvUkg4bFR0eXIzdGt6Wjg4bkhU?=
 =?utf-8?B?TWh1MVBvNWxOb2NrQi83dFhwM0RsOUV0NUl3b2VWc0pRQk1pWWcyd1orYzVn?=
 =?utf-8?B?ZmhkUGxMS3lxd0JRV1ZBWk5QYzFBTmJCN3JySU9DbkhIMzAvcXM5RmdrY1BG?=
 =?utf-8?B?WWllZzBNK0JJQTFqQnVRRHhsWnFLaTNjNUM2SXdSOXU1MU1PK2xnMVJPQXE5?=
 =?utf-8?B?TDNTNnF1VXRTWWRaVU9oVENVL0x6ME1EQ1ErL3JBZ2w2TzRNajBvOTRvVlRN?=
 =?utf-8?B?czNWeDB5aXpucnB1Qi82R3NiTGJWeUk3Q2wzZllFS1plR0xGUFJYTDZpRGZx?=
 =?utf-8?B?TTlBWmVKUHZ1UEc4NGxjSFM1a2puMU9RMUU4M0tDMlgwd2Nhdk85bnhuME9k?=
 =?utf-8?B?YmdjcE8rNC9DTXdUR0tkZDVEOU1MVlpxYjkzSmIza0orY0h5SE82OWVueGR5?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE1FA5869E980542B2B69A2B2B0C00B8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UYGeIqCoB3j7pesZMAX1j1fSMuJuQ3dfAUSbY1smBa7g26QG/6zaDpeQDE29UFNXX/Oyt8QC/Hsfnn8caBi0W1BGFYSmZ3wbdgwk0KHu7/GVt1ODZLSRL9Z5t5Zy/2fjDCAFNf9aZKNawe1D3Ed39vBfOFy4WKh9MFlLhMuwfa5Z+3KN8PPJFuotTXOhLMYgng5v9mSOGcC1MyFv7+5wEqfoJ9XESxJIAqO3qrA5jHpQsgKfe/CUyGLl0+1HlmzaneRf931elyr6zl9zPUFu4Jc0kjIa+Q99wrElw9eFxXwVFCDGVOXTzOQLio8jvx7wl/s50VcZI+/OjjZTHt3UcsZVQxeAH8ZNjDGZdq+xd/NhLLL1NUkxTMXlScPfQyM3maYZD9zE70XAwu5tccuIa0XTVegotrclzOSkwbLxsLE3zvqmYlvRUp0lUfR3B4B3tRaqKkQPd7GEROnVw5rLun4S/KDDTpJgJBqOYp/ZfTfrAF0CnpCCl4LXxdttv6tOMiABd+SRkdTQR2TURV06s+La+wcdNZ1++L89XFO5kVA7AoXDixi9lccDzOcz4ldUNPNVsBeSnd/ZDEUnBiHUPtoaQIgHlJvRKrAfyZUwouBJy4Mu2XQhN/8OdG18zjvy0I97a1fWBV8fgbfl2NRE0/Mj/V6VQv0FeBwD/iWcfWE7mr++KT8uZeYMqVmdPvWqcC1zvFreGBtkuGTjHhjIYZMp8JjyoEQGoD3RLmTAdUWBwZqkRMkA/vRB3O59mTqctKQEhoOAXYWan0rP0DWkp1sgGEBT4W4PrcUUGJDwX/DhFegOLCD35tbu7RL7d38kpCAd1qgjgghtSg8uhYo0Hd0QEn3TYKkk1eQfybf+N466qDdBQAv+mrMWPFbE0XMBj48GvS4j2lvLAkb3o8mdUZ8MKaybwePVAWP891CZk5A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37117a70-fca7-4357-6676-08dbb45decef
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 13:32:50.3034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DkdWXo1aXTeprAnAZxlfuILdZnfNIiw+vc0Z1mBMgMAPxbkv1q3zhyFyX890uqIatJ5xGZOe1fuJXtX6n1XVqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_07,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130110
X-Proofpoint-GUID: mbva0H4ixpv01BhC-dXQDbYYZ32HZr1A
X-Proofpoint-ORIG-GUID: mbva0H4ixpv01BhC-dXQDbYYZ32HZr1A
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gU2VwIDEzLCAyMDIzLCBhdCAyOjQ3IEFNLCBGZW5nIFRhbmcgPGZlbmcudGFuZ0Bp
bnRlbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgMTE6MTQ6NDJQ
TSArMDgwMCwgVGFuZywgRmVuZyB3cm90ZToNCj4gWy4uLl0NCj4+PiANCj4+PiBXZWxsIHRoYXQn
cyB0aGUgcHJvYmxlbS4gU2luY2UgSSBjYW4ndCBydW4gdGhlIHJlcHJvZHVjZXIsIHRoZXJlJ3MN
Cj4+PiBub3RoaW5nIEkgY2FuIGRvIHRvIHRyb3VibGVzaG9vdCB0aGUgcHJvYmxlbSBteXNlbGYu
DQo+PiANCj4+IFdlIGR1ZyBtb3JlIGludG8gdGhlIHBlcmYgYW5kIG90aGVyIHByb2ZpbGluZyBk
YXRhIGZyb20gMERheSBzZXJ2ZXINCj4+IHJ1bm5pbmcgdGhpcyBjYXNlLCBhbmQgaXQgc2VlbXMg
dGhhdCB0aGUgbmV3IHNpbXBsZV9vZmZzZXRfYWRkKCkNCj4+IGNhbGxlZCBieSBzaG1lbV9ta25v
ZCgpIGJyaW5ncyBleHRyYSBjb3N0IHJlbGF0ZWQgd2l0aCBzbGFiLA0KPj4gc3BlY2lmaWNhbGx5
IHRoZSAncmFkaXhfdHJlZV9ub2RlJywgd2hpY2ggY2F1c2UgdGhlIHJlZ3Jlc3Npb24uDQo+PiAN
Cj4+IEhlcmUgaXMgc29tZSBzbGFiaW5mbyBkaWZmIGZvciBjb21taXQgYTJlNDU5NTU1YzVmIGFu
ZCBpdHMgcGFyZW50Og0KPj4gDQo+PiAyM2EzMWQ4NzY0NWM2NTI3IGEyZTQ1OTU1NWM1ZjlkYTNl
NjE5YjdlNDdhNiANCj4+IC0tLS0tLS0tLS0tLS0tLS0gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tIA0KPj4gDQo+PiAgICAgMjYzNjMgICAgICAgICAgICs0MC4yJSAgICAgIDM2OTU2ICAgICAg
ICBzbGFiaW5mby5yYWRpeF90cmVlX25vZGUuYWN0aXZlX29ianMNCj4+ICAgIDk0MS4wMCAgICAg
ICAgICAgKzQwLjQlICAgICAgIDEzMjEgICAgICAgIHNsYWJpbmZvLnJhZGl4X3RyZWVfbm9kZS5h
Y3RpdmVfc2xhYnMNCj4+ICAgICAyNjM2MyAgICAgICAgICAgKzQwLjMlICAgICAgMzcwMDEgICAg
ICAgIHNsYWJpbmZvLnJhZGl4X3RyZWVfbm9kZS5udW1fb2Jqcw0KPj4gICAgOTQxLjAwICAgICAg
ICAgICArNDAuNCUgICAgICAgMTMyMSAgICAgICAgc2xhYmluZm8ucmFkaXhfdHJlZV9ub2RlLm51
bV9zbGFicw0KPj4gDQo+PiBBbHNvIHRoZSBwZXJmIHByb2ZpbGUgc2hvdyBzb21lIGRpZmZlcmVu
Y2UNCj4+IA0KPj4gICAgICAwLjAxIMKxMjIzJSAgICAgICswLjEgICAgICAgIDAuMTAgwrEgMjgl
ICBwcC5zZWxmLnNodWZmbGVfZnJlZWxpc3QNCj4+ICAgICAgMC4wMCAgICAgICAgICAgICswLjEg
ICAgICAgIDAuMTEgwrEgNDAlICBwcC5zZWxmLnhhc19jcmVhdGUNCj4+ICAgICAgMC4wMCAgICAg
ICAgICAgICswLjEgICAgICAgIDAuMTIgwrEgMjclICBwcC5zZWxmLnhhc19maW5kX21hcmtlZA0K
Pj4gICAgICAwLjAwICAgICAgICAgICAgKzAuMSAgICAgICAgMC4xNCDCsSAxOCUgIHBwLnNlbGYu
eGFzX2FsbG9jDQo+PiAgICAgIDAuMDMgwrExMDMlICAgICAgKzAuMSAgICAgICAgMC4xNyDCsSAy
OSUgIHBwLnNlbGYueGFzX2Rlc2NlbmQNCj4+ICAgICAgMC4wMCAgICAgICAgICAgICswLjIgICAg
ICAgIDAuMTYgwrEgMjMlICBwcC5zZWxmLnhhc19leHBhbmQNCj4+ICAgICAgMC4xMCDCsSAyMiUg
ICAgICArMC4yICAgICAgICAwLjI3IMKxIDE2JSAgcHAuc2VsZi5yY3Vfc2VnY2JsaXN0X2VucXVl
dWUNCj4+ICAgICAgMC45MiDCsSAzNSUgICAgICArMC4zICAgICAgICAxLjIyIMKxIDExJSAgcHAu
c2VsZi5rbWVtX2NhY2hlX2ZyZWUNCj4+ICAgICAgMC4wMCAgICAgICAgICAgICswLjQgICAgICAg
IDAuMzYgwrEgMTYlICBwcC5zZWxmLnhhc19zdG9yZQ0KPj4gICAgICAwLjMyIMKxIDMwJSAgICAg
ICswLjQgICAgICAgIDAuNzEgwrEgMTIlICBwcC5zZWxmLl9fY2FsbF9yY3VfY29tbW9uDQo+PiAg
ICAgIDAuMTggwrEgMjclICAgICAgKzAuNSAgICAgICAgMC42NSDCsSAgOCUgIHBwLnNlbGYua21l
bV9jYWNoZV9hbGxvY19scnUNCj4+ICAgICAgMC4zNiDCsSA3OSUgICAgICArMC42ICAgICAgICAw
Ljk2IMKxIDE1JSAgcHAuc2VsZi5fX3NsYWJfZnJlZQ0KPj4gICAgICAwLjAwICAgICAgICAgICAg
KzAuOCAgICAgICAgMC44MCDCsSAxNCUgIHBwLnNlbGYucmFkaXhfdHJlZV9ub2RlX3JjdV9mcmVl
DQo+PiAgICAgIDAuMDAgICAgICAgICAgICArMS4wICAgICAgICAxLjAxIMKxIDE2JSAgcHAuc2Vs
Zi5yYWRpeF90cmVlX25vZGVfY3Rvcg0KPj4gDQo+PiBTb21lIHBlcmYgcHJvZmlsZSBmcm9tIGEy
ZTQ1OTU1NWM1ZiBpczogDQo+PiANCj4+IC0gICAxNy4wOSUgICAgIDAuMDklICBzaW5nbGV1c2Vy
ICAgICAgIFtrZXJuZWwua2FsbHN5bXNdICAgICAgICAgICAgW2tdIHBhdGhfb3BlbmF0ICAgDQo+
PiAgIC0gMTYuOTklIHBhdGhfb3BlbmF0ICAgICAgICAgICAgICAgIA0KPj4gICAgICAtIDEyLjIz
JSBvcGVuX2xhc3RfbG9va3VwcyAgICAgIA0KPj4gICAgICAgICAtIDExLjMzJSBsb29rdXBfb3Bl
bi5pc3JhLjANCj4+ICAgICAgICAgICAgLSA5LjA1JSBzaG1lbV9ta25vZA0KPj4gICAgICAgICAg
ICAgICAtIDUuMTElIHNpbXBsZV9vZmZzZXRfYWRkDQo+PiAgICAgICAgICAgICAgICAgIC0gNC45
NSUgX194YV9hbGxvY19jeWNsaWMgDQo+PiAgICAgICAgICAgICAgICAgICAgIC0gNC44OCUgX194
YV9hbGxvYw0KPj4gICAgICAgICAgICAgICAgICAgICAgICAtIDQuNzYlIHhhc19zdG9yZSANCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLSB4YXNfY3JlYXRlDQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIC0gMi40MCUgeGFzX2V4cGFuZC5jb25zdHByb3AuMA0KPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAtIDIuMDElIHhhc19hbGxvYw0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAtIGttZW1fY2FjaGVfYWxsb2NfbHJ1DQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gMS4yOCUgX19fc2xhYl9hbGxvYw0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtIDEuMjIlIGFsbG9j
YXRlX3NsYWIgDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC0gMS4xOSUgc2h1ZmZsZV9mcmVlbGlzdCANCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgLSAxLjA0JSBzZXR1cF9vYmplY3QNCj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByYWRpeF90cmVlX25vZGVf
Y3Rvcg0KPj4gDQo+PiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IG5lZWQgbW9yZSBpbmZvLg0K
Pj4gDQo+Pj4gDQo+Pj4gSXMgdGhlcmUgYW55IGhvcGUgaW4gZ2V0dGluZyB0aGlzIHJlcHJvZHVj
ZXIgdG8gcnVuIG9uIEZlZG9yYT8NCj4+IA0KPj4gTXlzZWxmIGhhdmVuJ3Qgc3VjY2VlZGVkIHRv
IHJlcHJvZHVjZSBpdCBsb2NhbGx5LCB3aWxsIGtlZXAgdHJ5aW5nDQo+PiBpdCB0b21vcnJvdy4N
Cj4gDQo+IEl0IGNhbiBiZSByZXByb2R1Y2VkIG9uIGEgbG9jYWwgbWFjaGllbiB3aXRoIENlbnRP
UyA5IChzaW1pbGFyIHRvDQo+IEZlZG9yYSA/KSwNCg0KRXhjZWxsZW50LCBJIGFwcHJlY2lhdGUg
dGhpcyENCg0KDQo+IGFuZCBzb21lIHN0ZXBzIGFzOg0KPiANCj4gKiBkb3dubG9hZCBzb3VyY2Ug
Y29kZQ0KPiAgJCB3Z2V0IGh0dHBzOi8vc291cmNlZm9yZ2UubmV0L3Byb2plY3RzL2FpbWJlbmNo
L2ZpbGVzL2FpbS1zdWl0ZTkvSW5pdGlhbCUyMHJlbGVhc2UvczkxMTAudGFyLloNCj4gDQo+ICog
dW50YXIgdGhlIGZpbGUgYW5kIHJ1biAnbWFrZScNCj4gDQo+ICogY3JlYXRlIDIgZmlsZXMgJ3M5
d29ya2ZpbGUnIGFuZCAndGVzdC5jb25maWcnDQo+IA0KPiAkIGNhdCBzOXdvcmtmaWxlDQo+ICMg
QCgjKSBzOXdvcmtmaWxlOjEuMiAxLzIyLzk2IDAwOjAwOjAwDQo+ICMgQUlNIEluZGVwZW5kZW50
IFJlc291cmNlIEJlbmNobWFyayAtIFN1aXRlIElYIFdvcmtmaWxlDQo+IEZJTEVTSVpFOiA1TQ0K
PiBkaXNrX3NyYw0KPiANCj4gJCBjYXQgdGVzdC5jb25maWcNCj4gdGVzdA0KPiBkaXNrX3NyYw0K
PiAyMDBzDQo+IC9kZXYvc2htLw0KPiANCj4gKiBydW4gdGhlIHRlc3Qgd2l0aCBjbWQgIi4vc2lu
Z2xldXNlciAtbmwgPCB0ZXN0LmNvbmZpZyIgDQo+IA0KPiBUaGUgdGVzdCBjYXNlIGhlcmUgaXMg
J2Rpc2tfc3JjJywgc28gSSBwaWNrZWQgb25lIGZpbGUgJ2Rpc2tfc3JjLmMnDQo+IGFuZCBhdHRh
Y2hlZCBpdCBmb3IgcXVpY2sgcmVmZXJlbmNlLg0KPiANCj4gVGhlIGtlcm5lbCBjb25maWcgb2Yg
bXkgQ2VudE9TIGlzIGRpZmZlcmVudCBmcm9tIHdoYXQgMERheSB1c2VkLCBzbyANCj4gdGhlIHBl
cmYtcHJvZmlsZSBhbmQgcGVmb3JtYW5jZSBzY29yZSBhcmUgYSBsaXR0bGUgZGlmZmVyZW50LCBi
dXQNCj4gdGhlIHJlZ3Jlc3Npb24gdHJlbmQgaXMgdGhlIHNhbWUsIHRoYXQgY29tbWl0IGEyZTQ1
OTU1NWM1ZiBoYXMgYWJvdXQNCj4gMjAlIGRyb3AuDQo+IA0KPiBBbHNvIHRoZSB0ZXN0IHBsYXRm
b3JtIGRvZXNuJ3QgbWF0dGVyLCBJIHRyaWVkIG9uIHNldmVyYWwgZ2VuZXJhdGlvbiANCj4gb2Yg
WGVvbiBzZXJ2ZXJzIHdoaWNoIGNhbiBhbGwgcmVwcm9kdWNlIGl0Lg0KDQoNCi0tDQpDaHVjayBM
ZXZlcg0KDQoNCg==
