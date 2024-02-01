Return-Path: <linux-kernel+bounces-48572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D74BE845E3E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C6C1C2249B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB76E16086A;
	Thu,  1 Feb 2024 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="IW/5DRWW"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F50315F313;
	Thu,  1 Feb 2024 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807633; cv=fail; b=QbWzkrF7TIhvhHiFv/E5OWbZ5Z7PyIk0qmaADqIQcdvavk0+UTsQGGuxhMKrhH3dPjYFfUP9BLdkbiXnYmLWq1ZvwqrFHY/DKh5s6TY+TFuBmbw5l2dTUea2kiNcw50z7XmGcdqq32+g7dStMrL+PtWe0gdXNSwWOnwp6wr1cPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807633; c=relaxed/simple;
	bh=//l7fwohXb8phLtyIDhLgZum/TIE/lRWRi2p3nnCJ0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J4afCnV22njNqk2/KaxZLreumb3q2RCsA0DsbYPQxkbrdxX0Yow7cWMwHv0YQgVmTv6AXeDqZ4CmDu1PVtqIAruAY91CCwAHBfzugzOMN0D+8BKFm4fsM6PMDz6Yst9zJhF7Ne2VE9QhQIHfAY+H4Dq5iKbPCJj2fzi3jxy/UhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=IW/5DRWW; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 411FIVhl028687;
	Thu, 1 Feb 2024 16:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=//l7fwohXb8phLtyIDhLgZum/TIE/lRWRi2p3nnCJ0o=;
 b=IW/5DRWWdX+pr7bOQdjOB3XEe4FY7Mo5KvY0yL0ZtJqq48MZcOqVITxZckZ5Ko2VnrYK
 ZzXbTo7CcC0gZwyWiAhlU4Sr65qFFzK5jwQ5CCVak4n6mXsFv7EWEkLqVDQrgx8MCGcz
 zE238G/H2euJX8KRBh8kJoXF8aY5U6nOjReS9RyHy0vqALk1ii3L6TkYPkke1839UUsb
 zFFrCvSEZYQP2j/e6rGXDxZ9kT+YW5pJTDu9vOYAxNKcIsNTYcA7VXRDqXV9UdS537x4
 lyNilcbE/NcFr9roWsMirOEsG1krbnl3FI3lndAjQ+70n9p1YXP4wi31kHqS8ATJ7W1R 3g== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3w0du0gs4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 16:41:32 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 832F28005C8;
	Thu,  1 Feb 2024 16:40:57 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 1 Feb 2024 04:40:37 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Thu, 1 Feb 2024 04:40:37 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 1 Feb 2024 16:40:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1v+eK1c5FFUKGVDp7KIAhnuGtRtqYnOosNyJZaO2Wl2/7amJ2EgGDfYjcMXSEFhBdz0Q/mUUEq7njJtTwGP08vfoJ35VRVeB0TkKcxcFuIFUKvy9onsPrcIso57XkokN800g+ToqTSRrATNoj1scn0HWGkwTqssxyAdif3fSlTlMy/rmdPxYATU62TSICjF8EJDV0GG+TXpzaBEA+pV5+xErWdiP/XqKT4LJLKDV7Fzah0ydM+3qEzIphFumzQEueQxBdW+0dkORak/iYiL/DgZ18EqvQRbQRIeg0Dz7JjkUS4j883B2Goa1tzld8iN+TQG3HMLEA2rtLl4dsXLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//l7fwohXb8phLtyIDhLgZum/TIE/lRWRi2p3nnCJ0o=;
 b=PygoSEx4JTuPg6u7lb4gdf2veGEKR+JNpRxdWVOFu4wLuvOsdFHMPrVhuUEM7I9GZs2ytzMM/Cv4Meh3gtBqZp+22Nf8JHbAiBsY5yIVa3ZkLJ1u/KWISzCByxmhZ8eng6IZbFNQlZGKU2dJLn0DNBKVoki60oN6q5CPqk7YNadtMUztmi79PMCKTSWNXc6sTZZ5z/ncHHMInhnou9rlr7BBI556CzaVDt09b4E5PQQMxPtGj61KEERRnL8Lm+6WQCUvWOfkgR55VYDiBPKSAOhNaiM54ugGV6dSf5XihwFEyjijDh8GFIsUpM63WTcZdMRHe1SQlfx5+ffZ8R8YZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by MW4PR84MB1539.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 16:40:35 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f9c4:2ca:bc63:f0d6]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f9c4:2ca:bc63:f0d6%7]) with mapi id 15.20.7249.027; Thu, 1 Feb 2024
 16:40:35 +0000
From: "Elliott, Robert (Servers)" <elliott@hpe.com>
To: Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        "jarkko@kernel.org"
	<jarkko@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>
CC: "LinoSanfilippo@gmx.de" <LinoSanfilippo@gmx.de>,
        "p.rosenberger@kunbus.com" <p.rosenberger@kunbus.com>,
        "lukas@wunner.de"
	<lukas@wunner.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] tpm,tpm_tis: Avoid warning splat at shutdown
Thread-Topic: [PATCH] tpm,tpm_tis: Avoid warning splat at shutdown
Thread-Index: AQHaVQMsqdJbvpVSekKSGk2C/t7RT7D1rPbA
Date: Thu, 1 Feb 2024 16:40:35 +0000
Message-ID: <MW5PR84MB184274E28D83DC337B486CEFAB432@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20240201113646.31734-1-l.sanfilippo@kunbus.com>
In-Reply-To: <20240201113646.31734-1-l.sanfilippo@kunbus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|MW4PR84MB1539:EE_
x-ms-office365-filtering-correlation-id: 20382ace-56eb-492c-c685-08dc234483e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1EBXo8zG6YKA+RqY6pbvMYA4LDW3hZPdFLamF/lWZkNmphQbDZ/wOt0aKgjVO0uHbzVPALa4QxYYxC+xdSZqI8BzZRhUht2HCQIUWGCKUSVBZrVKrVwflLIlmbgJXLWgunj1d/9/KZ+VUoBdnMyviVONmeCp6zULehQ4dVzD/mqWAvy00ugr1AXiAReyaC1g10HLTAqSsoywprRAspsQIFJuWt3iUzfO4/QM0UcY4vreoTGzZFaoQPeFAiv1sBixr7ajM8zwgwwQDXhwCmRM6TGWeXlipmpGjzXWM1cu+k9pECrQe4r6+dn/02GH5T1BuVXgwwUCaVp2GhLJd79EbEY0rJ6RTN9oC1HJuAnP+WS0r8M/XSNpRIxyTKMSlbcqMxPtqPqqdlU/+5U5SnjxAZnTNE6RTV3AXQf6A6jCIE72+3/2gd0OJ4gc19J1J3OkVH04AYd4QeIuLu7d1PnYsFHUnsHLBVhLUDgKZmB8yvswVDVbatHErs5I/o6rfqS0+h0y7DE2dv7p8604zUUJPL5i88QBLQE9K5/edZfMEbzqR28Bgf7+eXUVSIWEm8jMY5At2mp40sQkEo9MpPhsGn8jONfSNYcfj1atuKvZqUK8tnLA0wNdO97/0UTHcRR/aqKb8+OoQnPQFbqLCkaOIGFRePKdkRK7UXq54Hn/NgE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(230173577357003)(230273577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(55016003)(83380400001)(66476007)(33656002)(86362001)(41300700001)(82960400001)(38070700009)(122000001)(9686003)(26005)(38100700002)(110136005)(7696005)(6506007)(2906002)(478600001)(66556008)(66946007)(76116006)(316002)(66446008)(54906003)(53546011)(5660300002)(52536014)(64756008)(7416002)(71200400001)(4326008)(8936002)(8676002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GVlvPMn8Tz+2aCGRQEoiVwzbg7eELcLGeGnTuS6WDy7/whFKuU5DjjayDbBW?=
 =?us-ascii?Q?UZc+qmYHdOK0nddArF8x/Xlt8jPqRewmkvUI7s8mIl+jGSY+8mUpeIXYodpp?=
 =?us-ascii?Q?8kMVxRA47d4Y6LIoaSuakaiZa22KqyYd5TYXOuTEQEUYt3nIBaApPm58l/70?=
 =?us-ascii?Q?UEd6Lzce5paeX31/PsUmHPNphrt+pdjEDKzAROUzZmJYFIJQYVzu2lKfBIdR?=
 =?us-ascii?Q?FQpmrI8jMkrmtnThjxsXZY7l5UKCn6o6mjY3SRA7s4a4ve8aNU3ShgQpLgbi?=
 =?us-ascii?Q?pXTdbMCN/OGU5TpRV3/SfiSf3dk3GKsCIaXzZ0U5h3/OLhTbS4HcK41oCw8u?=
 =?us-ascii?Q?uE1o7VFlHauV6QQflOodULwR0TKlJFdRaVNKEfA0O/CEqWZmGyRGvFzPkxKM?=
 =?us-ascii?Q?VMr720FoI+YBKJO35E3rPTv46KMKlOWUa4QpPoE4VDLn3aLvsqZj9HthhDVc?=
 =?us-ascii?Q?cMaJpMdyZBYFxKTJzwt1F46rw2d4zA5udmbGvyYnEdeimPB/iacyjMKS80WT?=
 =?us-ascii?Q?cIlBKwpPtCiace6mdbsMhhcH1sj7gI8X0UOpOnxaJm8eMgfWM3S5o2weRanY?=
 =?us-ascii?Q?q0dtvqCDOr/5ZGcAqumtqANJv8iaJl4611eJnpzNF6uX0mkDhU0xZvrWT/OB?=
 =?us-ascii?Q?hcKC0iVK3Sbr2zpH41lsEdI1afmeEXHJAfm4VAzRFXQQszg7yOeCh3A0fW4x?=
 =?us-ascii?Q?BBpPaNV3kVjpMzrjjfv97RaVyMJTycYcHPt6jbzdCrHytcaYLuPOnYXBlbl1?=
 =?us-ascii?Q?z/HiZqHX+LJKuqAQXA6G8OLZQbS0ShW7uCF8Zvyp+rG0ZhhB1R5iPbd7WCQ/?=
 =?us-ascii?Q?uA4j0Fu0Qn4fKy4G3zTZYo+RHDFFfi0zKcJXDbNiy/p03Z08eIgLx+7SKO1c?=
 =?us-ascii?Q?pqJcDc+VcGbHv8ehbbV4sbZC7cqBESb6Hg391rD9WbZ8NQiV+IDtNkIyxEN1?=
 =?us-ascii?Q?wuIsIQr+QyQhCTdaIfeLQjMEOQrV/8BeGsaDOaPHE1rYxR+46OzfM9FyEkb3?=
 =?us-ascii?Q?PHyL/TDzmLRqye3r61AxtaguqTQprtK6J+3/8GyhZMy80aEb5LUv79MR+SOz?=
 =?us-ascii?Q?urP/BA2NgmZOB8ZA58bAc/k7ziieRXZ7+CXIPi1TjuxbMTcPGDdcP16NVxk6?=
 =?us-ascii?Q?kKHckiF9OCSG2i8iF47HisZAkQSlJWeE0Tonzuhb8noJqu5mdHvs7P87s7uC?=
 =?us-ascii?Q?LiUephVzKl6gFtSJfCpStCFuRWJSRbBknNQoPk7d8JkbMJgUBmuqq+Aq4QS4?=
 =?us-ascii?Q?OR7xwf/Nvb6BycgiGylyFNEgLoNL3jPVL0goSlOO0hp1J6xBi7utavOFnEBH?=
 =?us-ascii?Q?50xsenA1tLJtE+V3QNQJxqWU8sPdOJip1qPf9unRcrlY/SEEWFpHPP3Oavn3?=
 =?us-ascii?Q?FqAN04J2zSOFvWfX2kADUd4vSZZhM2mSEmgl8rDn8opxXIKTmhVFSiEAk9Hc?=
 =?us-ascii?Q?Qgjbi4BxfrbSGdwaMmmSL8QA8fyil2smYZOaq8WUWfdk0dARB1PAA/+6UTd1?=
 =?us-ascii?Q?sbHcpy7u4LVYlgQF6P9gOaLHq90pSBniDV1u4vZYmKwDqAlvfB6khgqJJzJc?=
 =?us-ascii?Q?XzhxStLrOiWM8bIlrdg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 20382ace-56eb-492c-c685-08dc234483e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 16:40:35.6649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJ0so137Tes4nu7Lsw7Y4gW64SfGdK/c2w//F2/SBhLdiJThx5hEqaGsrTxkAyCw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1539
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: yzAebmcD9Ic7U5XXcU74tzFLQ25s1OVu
X-Proofpoint-GUID: yzAebmcD9Ic7U5XXcU74tzFLQ25s1OVu
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=670 malwarescore=0
 impostorscore=0 clxscore=1011 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402010131

> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> Sent: Thursday, February 1, 2024 5:37 AM
> Subject: [PATCH] tpm,tpm_tis: Avoid warning splat at shutdown
>=20
> If interrupts are not activated the work struct 'free_irq_work' is not
> initialized. This results in a warning splat at module shutdown.
>=20
> Fix this by always initializing the work regardless of whether interrupts
> are activated or not.

That's using flush_work(), which just waits for one to complete. Is there
any case where multiple work entries could be queued, and cancel_work_sync(=
)=20
would be necessary?

tpm_tis_probe_irq() has a loop calling tpm_tis_probe_irq_single()
for 3 to 15. Could each of those could trigger an interrupt storm and
call tpm_tis_revert_interrupts(), which calls schedule_work()?



