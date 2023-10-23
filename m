Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DA87D3BC4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjJWQI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjJWQIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:08:54 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DE6E9;
        Mon, 23 Oct 2023 09:08:52 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NCbGke020236;
        Mon, 23 Oct 2023 09:08:39 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3tve5mxh0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 09:08:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hrr1/n7KyMRTUfmLvaI37nTdaQTXDg7eLJR4Q8s47ceLu42AJt6VvotnDK9ea233OVKOetKiE8YB890O/UeiLaNoTzEAm5VnWPIdi2+V0pxTNH2Ggu+0W15iI9WI47vFEJD8A8wrd0sGWQDjKwBnpYsA9Ln1enRysfJ/jj+ElQCODeQdlDtlLxNfePJEYqFcmrO3+6tNTc1G7yd7sxJP5AAkdbhrQhsGtcMJmMwu1pS7md5/GYsodJ01RocBZLgW1O7bA/RBogIi/1RDCtc9B73+SkvggJlQ/P1GLJq8FwnnAriqSHLHVb4pjF3IMS76Y8byEoDh9ylm5efPB4NpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CNDZe7CRPsUc+OPqFuRAuBTTjkO0UtitAdtgbpyeEE=;
 b=kBNY3PJQhQCK6SbQQxSFiUgL2MeTQ+395XeDIrlxws4gyTzTePTwZXfhGAcMLiw0WKA6jRLboPy5+MWwHSMDeCOnhPOvqaz4fPSNpFkjQmH7CE22tz7xrS9/v3LXZhAHKQQwrAKZDdVvxKHkqnu9VFyOFX4dJnZ5+Qva3JlIdj9gwehH7xmHQ7wKbYNgpZtwGVWVEjDD8po+CLFAoO1gL5D+hbwdgBeWOMlG/Y2EPeybWBDqM2eXjI/x5Xgsqba6B37vg4tdUWiynMPqfFbRYGaWH73VlJbMAjzr5p3BKBdA7bu3tI71IEBbgxfHWihN07mVf7FhC1Qre2DkFIG6fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CNDZe7CRPsUc+OPqFuRAuBTTjkO0UtitAdtgbpyeEE=;
 b=Lic3aINaSNoV0+HEsB1milvSlWM3wphW7sTygNOvJBJVjkNJlLwOiZ6f9XmN0mOWKeJkxVwbSsTWZVbnFneF8ANgHL8a/oU2HREdM4sOdo3MXAXtl5tDGeeowAY3UAPqAh8qc7RiWd8JKn7Tk55xkXW69qBcKxXBf51BcLR/JZI=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by CH0PR18MB4162.namprd18.prod.outlook.com (2603:10b6:610:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 16:08:33 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::7c0a:5ded:25e9:7fa2]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::7c0a:5ded:25e9:7fa2%6]) with mapi id 15.20.6907.028; Mon, 23 Oct 2023
 16:08:33 +0000
From:   Shinas Rasheed <srasheed@marvell.com>
To:     "Drewek, Wojciech" <wojciech.drewek@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Haseeb Gani <hgani@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>,
        "Gallen, Erwan" <egallen@redhat.com>,
        mschmidt <mschmidt@redhat.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh B Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 2/3] octeon_ep: implement xmit_more in transmit
Thread-Topic: [PATCH net-next 2/3] octeon_ep: implement xmit_more in transmit
Thread-Index: AQHaBaZgKB+ScISTk0Gr6mfSxGxpx7BXSWwAgABBYWc=
Date:   Mon, 23 Oct 2023 16:08:33 +0000
Message-ID: <PH0PR18MB47347E951E2A7F9C37E2F166C7D8A@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20231023114449.2362147-1-srasheed@marvell.com>
 <20231023114449.2362147-3-srasheed@marvell.com>
 <MW4PR11MB57766788EBB4D99302002A7FFDD8A@MW4PR11MB5776.namprd11.prod.outlook.com>
In-Reply-To: <MW4PR11MB57766788EBB4D99302002A7FFDD8A@MW4PR11MB5776.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|CH0PR18MB4162:EE_
x-ms-office365-filtering-correlation-id: 4ceb4173-2b7d-4135-beac-08dbd3e24e74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Oyx3BPyudor034lx5n+0zaqb+w5QrwCpt0zE7k7mROh4eywddz/bhVVFh+GJ1SDbDn3IEEgAMfwVTBE8dcg9TLxw6ZNT9Km1Nvu9IlsEQNqLyChhkbmTmZODJ6SRkkFV3R0I+Um2WwPhl5gPUAwTDZg1IrDubqkITrypDwAH3sI1PpdJGxAJwP7RuaMra3qM+Emb1cpZc7E1sR4G/OgQp6a7T31XT21zMZcqtWP+klo7VU978OVraV9gVrhDoWv2YCWtRFghp+nfnDsAyeAyaN0B4g3mhgpS9NT/o/yE6ykesPpNW4EXi275xTyGJAtIPC8lqlW32KRnedU94UoR+DH4YeSja/tZTXYx/r8+Snc/OCjY9do6dqXygENk1qtoCNrO2fQW49/+OH6D365fRS5sQpHMr2WBQxL3Cl5HOpxGn7uIEmI2PxTaqId8xzhufm3osJt25as23eLdTD1d2jKtoKEG7uM9Sxf/a/TOLcs8w9OmoyJAGRKGbrcEc42KhFwn0OUvIy0bzX2UyWr+1CU11jpy0h8vTh/CFKtaz3Gla+1BE/TEylHDHsivzsfYqJtKtZjtUTMZ83k7AxrHnxRMG/qPLuve2uDQDRGciJ1vujs/kJ0OG5imy4C25sU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(346002)(376002)(396003)(366004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(38070700009)(38100700002)(2906002)(55016003)(86362001)(5660300002)(7416002)(52536014)(8676002)(8936002)(558084003)(33656002)(4326008)(6506007)(478600001)(7696005)(91956017)(71200400001)(110136005)(122000001)(66476007)(66946007)(64756008)(316002)(76116006)(66556008)(66446008)(54906003)(83380400001)(41300700001)(4270600006)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b3R+bM2uqWnVZDMuDp7eqUl5v0xfJM6+0R7bLnpubw4NFA+a0rUIrjnm23?=
 =?iso-8859-1?Q?0PsIFN5s0HTxxW/IyaLG6ukTxfOsfSsSMPIA1tTzeuuKqefj+VlrWc5wPy?=
 =?iso-8859-1?Q?j80ClKeDykBwRyWmVvubp/f1CSKyIH2x/OTtowmNWPm35qa9zJQb78mjDN?=
 =?iso-8859-1?Q?2iCVxZEATbnfvd0GdCBH2h4CY2gDrKquVpn/E2+IIucqmVXoxiKjoaf4vd?=
 =?iso-8859-1?Q?G3lhmCvWSXE7O7P37i7gZvAIHsy0Lh8Xp5SLleuyxwjxUD8xYoPtXZB3XL?=
 =?iso-8859-1?Q?p93r1s2B08g/pVOikfXeU7aL4ELBd92fMssh+h40AUaBASJkSmgBU1cU5y?=
 =?iso-8859-1?Q?yKooucpcapdfjth0MOWmvsocFHlpm/kPLv6mNr/1J+hQMOkvvvsH1ngDqt?=
 =?iso-8859-1?Q?WpQB3NDcMHydFZHpUDNE9WBS0BI0ysCavKAwIJ3rL5x+qDdSq1nYAHygbh?=
 =?iso-8859-1?Q?eU4F1M/9pTPUDdavbstKsa4iXG1ehSJfbjKD5f54jze6TU8xPKEb4ZjnRz?=
 =?iso-8859-1?Q?N6iuJ+CY1w6aWc9rIjhQ0szeWyXKSzhHh3CFKHlHimaZkV+6+oftAxCK/N?=
 =?iso-8859-1?Q?/TZ0hk9iBVDjXbxt3SHKf/inPqJOxynyb4DATUnVnmoHYg5OcjBbRT2j/e?=
 =?iso-8859-1?Q?fl/zPAx9baL4sVUeFnqHEMF9WH2shUC+Pc002qE+4sqzpkryRVBd1I+Zh6?=
 =?iso-8859-1?Q?gCBbolX48YlB+eIvDKn0OtmKVeebY/EesnviQWwxY4VXiIyRCihgUVRvqE?=
 =?iso-8859-1?Q?wuNsx60zUua9l5qq6xEaL04UpoU/Mdkepmf/bHxYjFMFIqPtxg+DxBErTy?=
 =?iso-8859-1?Q?1+aHS8JL18cN4mrIOJgA8T3uoDM283k70u/QshBem9h+/oR7kjjynB/yKJ?=
 =?iso-8859-1?Q?2eh0ndrcU0GDU7xlHCcguiSlru4GQep1ihgLIGQWamFWbyV3bTgKzpNtuc?=
 =?iso-8859-1?Q?iyFqubz9TIj+E9kC8gtdMAbUSAjFvUBSNwBLAi5Mg5ztkMfnCx59rgCRDD?=
 =?iso-8859-1?Q?PIdQHvKveZpoCCIhBEIEA8eVOhe7PLVmYbGyfm8TqkzUjP4oRnNrBlVpAv?=
 =?iso-8859-1?Q?ff3AYxxfUHQkqCEXSBQs9V/MJB9azwuSV7fXDBaTOx133NxXK6vysLy8yq?=
 =?iso-8859-1?Q?Hsb/oIRsWZbpgfxKaOpUeV765OeUog0SHbapbNBxYxjnnaIjkz7+3agdqx?=
 =?iso-8859-1?Q?k9aulR9icugzV5VFQfcm8+saNW8rLMogbseOBQx0Bt50Tp/04PmHkdFkVO?=
 =?iso-8859-1?Q?AolzzJSFnLZ3WMT+XQ61XESynkSJDB+KOPtCHSOYHcA7srRujUWWJte/R+?=
 =?iso-8859-1?Q?imBmNVW95NA/3OQaOzZYL6OzBiRlYouJMa838ekeSccEH7qqSIIHtQCxSE?=
 =?iso-8859-1?Q?d+1wQVgqSX9pm94zeze67SrSoFGCVydYBfDgqK3PDo+RIHjILdsl+4s46I?=
 =?iso-8859-1?Q?9LYt28SXx8W9vM+X6exVF1aKnCSt4s6sO9YyrP64xMQ9olTFuxDWXzk9MD?=
 =?iso-8859-1?Q?6OtXEAmbI1HLygG5Fguj0DPGKZ6bbNbOxYzi4Ulib3gfpDmHiW2C9WbRk+?=
 =?iso-8859-1?Q?p1WACuAVGM14DVEch89ZUAmqAHXKo6vRk2F/Yiujpl1ZJ9Olwm2avL6Zjo?=
 =?iso-8859-1?Q?PzaOcZ9yr8HaQ7/bkrlZGoRQdr9ojLfX8n?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4734.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ceb4173-2b7d-4135-beac-08dbd3e24e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 16:08:33.5168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avJMEUhTVsEuBOgatBGvzCDz7i5RC81lv8B/Rj86ciN+v1y4Tm6fbk0J/uE0zcp8PwOe5XDoO3LdN4Mwr/SBig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4162
X-Proofpoint-ORIG-GUID: AXitf_5wQpfm0Erocml4IGaF9ZXcN1U2
X-Proofpoint-GUID: AXitf_5wQpfm0Erocml4IGaF9ZXcN1U2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_15,2023-10-19_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure, will update it since the first patch changelog requires more explanat=
ion as well=
