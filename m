Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DFE7E2E21
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjKFUZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjKFUZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:25:42 -0500
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C05D73;
        Mon,  6 Nov 2023 12:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=780; q=dns/txt; s=iport;
  t=1699302340; x=1700511940;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HRW+Y423CtGyjRd1BTQ5nI0HpbBALFGgthn3OBYiF64=;
  b=TmCfKt9SrhVqVmZDc8tzLqPG0eDLRvHjyPFZD1gZuHAZmtv7lljppz4M
   lcroE+lF7qoscrhBHLZlo78AmHKiAN2O8LgOGD2u3v0l8xH1l78kvgeQE
   vHhpA2Q1S++D7x07thbD69lnrlq/HoMCJRkzNRBHtuHIAL9g6blg9wNZE
   k=;
X-CSE-ConnectionGUID: 17MAxdajSXukalytYHf84A==
X-CSE-MsgGUID: g9i9XtX+SF2WI6w/sh2I+A==
X-IPAS-Result: =?us-ascii?q?A0AnAAAFS0llmJxdJa1aHQEBAQEJARIBBQUBQCWBFggBC?=
 =?us-ascii?q?wGBZlJ4WzxIhFKDTAOETl+IZZ1+gSUDVg8BAQENAQFEBAEBhQYCFocQAiY0C?=
 =?us-ascii?q?Q4BAgICAQEBAQMCAwEBAQEBAQECAQEFAQEBAgEHBBQBAQEBAQEBAR4ZBRAOJ?=
 =?us-ascii?q?4VoDQiGRAEBAQEDEhERDAEBNwEPAgEIDgoCAiYCAgIwFRACBAENBQgaglyCX?=
 =?us-ascii?q?wMBoFcBgUACiih6gTKBAYIJAQEGBAWybAmBGi4BiAkBgVCINicbgg2BV4JoP?=
 =?us-ascii?q?oJhAoFiFYNEOYIviS4HMoIigysDJo0PCXdHcBsDBwOBABArBwQwGwcGCRQtI?=
 =?us-ascii?q?wZRBC0kCRMSPgSBY4FRCoECPw8OEYI/IgIHNjYZSIJYCRUMNUp2ECoEFBeBE?=
 =?us-ascii?q?QRqBRgVHjcREhcNAwh2HQIRIzwDBQMEMwoSDQshBRRDA0IGSQsDAhoFAwMEg?=
 =?us-ascii?q?TYFDR4CEBoGDScDAxNNAhAUAzsDAwYDCzEDMFVEDFADbB82CTwLBAwfAhseD?=
 =?us-ascii?q?ScoAjVDAxEFEgIYAyQDRB1AAwttPTUUGwUEOylZBaN6gR2WHkmuMwqEDKE/F?=
 =?us-ascii?q?4NuphKYPiCoCAIEAgQFAg4BAQaBYzqBW3AVgyJSGQ+OIBmDX495djsCBwsBA?=
 =?us-ascii?q?QMJi0oBAQ?=
IronPort-PHdr: A9a23:3sxIphd4qRyeI5toKDIP8bFIlGM/fYqcDmcuAtIPkblCdOGk55v9e
 RaZ7vR2h1iPVoLeuLpIiOvT5rjpQndIoY2Av3YLbIFWWlcbhN8XkQ0tDI/NCUDyIPPwKS1vN
 M9DT1RiuXq8NBsdA97wMmXbuWb69jsOAlP6PAtxKP7yH9vRht6r1uS7+LXYYh5Dg3y2ZrYhZ
 BmzpB/a49EfmpAqar5k0wbAuHJOZ+VQyCtkJEnGmRH664b48Mto8j9bvLQq8MsobA==
IronPort-Data: A9a23:CEE37KAadTCRYhVW/xTjw5YqxClBgxIJ4kV8jS/XYbTApDwmhTYBm
 jMXDGCDOqreYGWje4p/a962pB4BucTVydZiOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4SGdIZsCCaE+n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357hWGthh
 fuo+5eEYQb9hWYvWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxMUlaENQ4ZW7
 86apF2I1juxEyUFU7tJoZ6nGqE+eYM+CCDV4pZgtwdOtTAZzsA6+v5T2PPx8i67gR3R9zx64
 I0lWZBd1W7FM4WU8NnxXSW0HAknYohv6LPOI0OPrM+ay1zaQlvik6lHWRRe0Y0woo6bAElU/
 vAebTsKdB3G2qS9wamwTa9ngcFLwMvDZdxE/Co/i2CCS697H/gvQI2SjTNc9DQ5nNxPGf/dT
 8EYcjFoKh/HZnWjP39OU8tlzbfy3SGXnztwpwOU9Jor0yvo4lZO8ebyd8HVIP3JbJAA9qqfj
 juWozumav0AD/SbyDyY4jevi/XJkCfTRo0fDvu7++RsjVnVwXYcYDUSVF2msbyigVW/c8xQJ
 lZS+Sc0q6U2skuxQbHAswaQunWIuFsXXMBdVrB84wCWwa2S6AGcboQZctJfQIV5keYmSTUo7
 W+UnNrtFCBekLPFFVvIo994sgiOESQSKGYDYwoNQg0E/8TvrekPYvTnE4gL/Emd042dJN3g/
 9yZhHNh2OhL3Kbnw43+rA+X2Wv9znTcZldtvl2/Y46z0u9uiGeYi2GA81PX67NLK5yUCwTHt
 3kfkM/Y5+cLZX1sqMBvaLtUdF1Kz6/YWNE5vbKJN8V4n9hK0yXzFb28GBkkeC9U3j8sIFcFm
 nP7twJL/4N0N3C3d6JxaI/ZI510nPm6RIm5CqiEM4Imjn1NmOmvonkGiam4gTiFraTQuf1X1
 WqzKJz1Vi9KVcyLMhLsH75DuVPU+szO7TqDGc+kp/hW+bGff3WSAawUK0eDa/tR0U93iFu9z
 jqrDOPTk083eLSnOkH/qNdDRXhUdiJTLc6t9KRqmhurf1AO9JcJUaGBmNvMuuVNwsxoqws/1
 irmBRcBmAug2ievxMfjQikLVY4DlK1X9BoTFSctJl2vnXMkZO6SAG03LvPboZFPGDRf8MNJ
IronPort-HdrOrdr: A9a23:Wx1coaqt2FgNQV+eVAEVwFUaV5tuLNV00zEX/kB9WHVpm5Oj5q
 OTdaUgtSMc1gxxZJh5o6HwBEDhex/hHZ4c2/hpAV7QZniXhILOFvAt0WKC+UyuJ8SazJ8+6U
 4OSdkCNDSdNykcsS++2njHLz9C+qjHzEnLv5aj854Fd2gDAM8QinYcNu/YKDwIeOAsP+tAKH
 Po3Ls8m9PWQwVtUi3UPAhiY8Hz4/fwuNbNZxkACxQ76A+Iow+JxdfBeSSw71M1aR8K5a0t31
 TkvmXCi5lLtcvV9jbsk0voq7hGktrozdVOQOaWjNIOFznqggG0IKx8RryrplkO0aKSwWdvtO
 OJjwYrPsx15X+UVHqyuwHR1w7p1ytrw2P+yGWfnWDoraXCNXAH4ot69Mdkmynimg0dVeJHoe
 R2NqWixsNq5Cb77WDADh7zJklXfwSP0CEfeKUo/g9iuMMlGc1sRMokjQNo+FNqJlOm1Gjhe9
 MeVv309bJYd0iXYGveuXQqyNuwXm4rFhPDWUQavNeJugIm1kyR4nFojPD3pE1wv64VWt1B/a
 DJI65onLZBQosfar98Hv4IRY+yBnbWSRzBPWqOKRC/fZt3d07lutry+vE49euqcJsHwN87n4
 nASkpRsSo3d1j1AcOD0ZVX+lTGQXm7Xz7q1sZCjqIJ94HUVf7uK2mOWVoum8yvr7EWBdDaQe
 +6PNZMD/rqPQLVaM90Ns3FKu9vwFUlIbooU4wAKiezS+rwW/nXitA=
X-Talos-CUID: 9a23:2WJGumCSupwZv+z6E3A40WcEFsknSU3Az37UMlOJKWg5FJTAHA==
X-Talos-MUID: 9a23:qTvaiwuvAnSZdd09Ec2ni2BjZfd00+eVJhoysMsZ/NKEbw0zEmLI
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 20:25:39 +0000
Received: from rcdn-opgw-2.cisco.com (rcdn-opgw-2.cisco.com [72.163.7.163])
        by rcdn-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 3A6KPdwA026624
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 20:25:39 GMT
X-CSE-ConnectionGUID: IB2dfStbTmeAXEcTRU40kA==
X-CSE-MsgGUID: PQxH+dt/QsKc5tQN40Q2sg==
Authentication-Results: rcdn-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,282,1694736000"; 
   d="scan'208";a="7215006"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by rcdn-opgw-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 20:25:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkKAz8eIqMl4LsqmhKu2uAUrc4Hb/jS9nq3a7Lhn0h4wQzFEPHAz7UAgldbGqkd2P+PzngYhxowQu5rebKp7F4y7dusj15//x0TsBe9IGa5sGirc22h4eNG4NUl5RO6YDuy5cijJTOMreH1EgvWt2rwhosUHVIuQZGpKWlbTA8wPI89Uu4WDMp5WVhq/+H/yTYwwJ8jnkxGbHuyRF05/26wtW78gt4OcMWpL8FFAoxXngzlzsITM0ZCqQFg+LyvdacRBxoMjpSSr4u0tDCULgdv4b3ieD3B1n22GZQQm04QooGnwr5VpFgDlzJ1pUUCtR2DvydV5XQ3VVVM+vhCxqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRW+Y423CtGyjRd1BTQ5nI0HpbBALFGgthn3OBYiF64=;
 b=im5pgqODDmy5L89BJnig9Y+k20MdoCDWaL1/HYAvuoUMNlc6ktZnoAQWLTt3RWgH/X2FhxYcBtb3drNelrI4jTOEm0WEPjwQIZXzasIrk0byMRfp+vOnGk3bg8I46JfwoydkoH0dMrckcjITgChyYSRRMbZ2HK51hsHhjhZ+0ErIeghEL5zNC+vGsbI75HjozAtGCmzXS4Hfs/ReYqLR6SoQVkrOHz5MDSzo4fQazmCkQmZ9minyffcIQTczfwQQsOir8eNpq0T0T1kzldTpiY6zJEB96jESRNdyCrZ2Db9PRIy+CmGz1c7HtDo9D97awSwLxB9Th+0DCAOCQme47w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRW+Y423CtGyjRd1BTQ5nI0HpbBALFGgthn3OBYiF64=;
 b=cygwyzbLLLyON4Y0V0JAJIjs8mAQsjr+xLS0xMIm/Uy4MQaK3K/W8sQzNtezSFHj7rH7432Eje0lBYtAKETBNMUUvPSEu53A0Co/gQ+xtK2YsYAt/3ZIrycXtUSF/aPCimrGgPuXIPNdVwphFHKT9Nr+se7F9jAB5Vzww+b1beM=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by SN7PR11MB6994.namprd11.prod.outlook.com (2603:10b6:806:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.25; Mon, 6 Nov
 2023 20:25:37 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::24ee:3bbf:e40:6022%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 20:25:37 +0000
From:   "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To:     Hannes Reinecke <hare@suse.de>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>
CC:     "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
        "Dhanraj Jhawar (djhawar)" <djhawar@cisco.com>,
        "Gian Carlo Boffa (gcboffa)" <gcboffa@cisco.com>,
        "Masa Kai (mkai2)" <mkai2@cisco.com>,
        "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 12/13] scsi: fnic: Add support for multiqueue (MQ) in
 fnic driver
Thread-Topic: [PATCH v2 12/13] scsi: fnic: Add support for multiqueue (MQ) in
 fnic driver
Thread-Index: AQHaCP/7p6v7K1fr9kePWpFv2SwZUbBmtm2AgAcU//A=
Date:   Mon, 6 Nov 2023 20:25:37 +0000
Message-ID: <SJ0PR11MB58968181F46112B8C7B5CA36C3AAA@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20231027180302.418676-1-kartilak@cisco.com>
 <20231027180302.418676-13-kartilak@cisco.com>
 <7f8d8801-2f70-4608-9b42-4a0f98aff3d3@suse.de>
In-Reply-To: <7f8d8801-2f70-4608-9b42-4a0f98aff3d3@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|SN7PR11MB6994:EE_
x-ms-office365-filtering-correlation-id: 9f1744c3-74d2-4d04-d3bc-08dbdf068963
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NdEAbJc8BB+ucMPkG02MVpV8eEmlXnDRmh8IPLyNX+vS9hFjIN0KI3KGSWv2qkBvae0DUNr+x9yIUtc8VaA4+oMM0GnnBOt8QJLpUJUmBCRa7G7wBpErIZqaCitHTgR+XiZMxErqxK5+WheXQXmhMb/pUyvbBKBJ0vN2mQvdaH7O/Afq6Rwa9WcC+1kl9CM+yInyHmbSiAkXuyi08kqdnbjsFab+Jb9MVUwkoJfDwJNl1DZr1v4o0Fn3zFMAxRC7SNrY8OHypc3t90wRdYf2hO6bZB2+q8Amu91qK1QnunnSXY/iLghPFuN14ugLOPtZFKpBM8DYmC/KKm5vyaztQmszw7K0JCIQquUFzg8xjWkp2Hbb99pQuE/7WLJo3i3uWVtdftbgAE+otoVsde+HwkiGXlVYk2tuVeEnWPPHT3isUM0te4v8bHHYTUabrwPyTRPIDKTkbVgO+pPJnRTdotd7p+0BtpmAKOkPPZF+n0QVTZ0N70xvUo+xFTSpjtSR3ZvEksD/N+RpR6qXFUDQARVJd74zMvqPAWwGUlz1cPwT3qP8SUrk/wcWI0wes/YNnhlFa05Er349EN6Qj8qb1Nd7I50jqgAJ3gYc91BkMB4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(33656002)(4744005)(6506007)(64756008)(53546011)(9686003)(71200400001)(2906002)(5660300002)(76116006)(7696005)(8676002)(41300700001)(478600001)(52536014)(4326008)(66946007)(110136005)(6636002)(66446008)(66556008)(316002)(8936002)(66476007)(54906003)(122000001)(38070700009)(38100700002)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekhGOHJRYldDbjUzb3UxL2l3RlJMU1JGalFadm00dlQ5Y3lTdHRhQzY0MkRZ?=
 =?utf-8?B?YkRVN1Uxd1BzMGUzMWxCMFRjTXVWdFk1MkV5MktPVWxqRjgzamZBUEFhUzBu?=
 =?utf-8?B?VXdBNWFFVWpGS05UR0Y3dUNuMGprYmlqOFFIUjl2SURIQ3RhUmFTeC9GT0xF?=
 =?utf-8?B?ZElYNVJtd2VEejR3VlFwRXRTSEZOdlVCNlVHUm5PSlJmdko3dmprbDZVMVR3?=
 =?utf-8?B?VkVFOGxmbkc0YWIxMUt1UGhGdG9jY1R6SVlPdzFZcEZtcExEbzNnd3lzNWRU?=
 =?utf-8?B?aWxzZ3BleDRYNU80L2hMSXhpd2I5a1k0c09wT0kzbGRGVlUxRFJLdGxQUlM1?=
 =?utf-8?B?Z2Myd2pIZ1pVQnZIcVdKMFlqUzJlM0hQU1lDVjZhSStEOFNYUDBoVGtrSks0?=
 =?utf-8?B?ZXlhYWpyaDZkQjA3ZU9Jem1qZFFxc0lxb2g5NU9GMkxra2I4YWMrcnptSXI0?=
 =?utf-8?B?MDlGNmtJbGRBV0d1NVQ0dm0vY2NDSWRXYkdkbUk4SEVydENNSE1mRXVJTy8y?=
 =?utf-8?B?eDFnU1R0dExnQ3d2dktLQjVPMnFUKzZoUjdtSWc5MDhnaTU4dGJ5SXZnMWxU?=
 =?utf-8?B?ZWI0R2lpVVBkUVJXeG5qb2ZENFUvR0dwazRoMldjQnc2YmZGd2k5Y1dvblFr?=
 =?utf-8?B?MllCNTBDT0lYakhsZVFxWkNuaVVXN1hSUjMwLzA4NVkzcWFTdlhZSmxLeENu?=
 =?utf-8?B?WkU3eFBhMlJuSEh0YlBhVjV2MjdpM3FrVVpadnZ2V2UzRktxVTZ3Y3ZQLytn?=
 =?utf-8?B?c0NLZFJLODNEc2tmQmEzT21acW4yS3AxcFRNV1BFOXFLYkp3ekkvcnpIOVZ0?=
 =?utf-8?B?eHp1SmlSSCs2YkhsY0FQSVNZbi9TREg5MUd2UVVIc0JYMlo5dHQzUC9DV21R?=
 =?utf-8?B?S0VwRVNkcXFHY1phZzQ5cVowYW1hQ1NOODg3eHVhTXdKVVNMZDh6d1NxOG4w?=
 =?utf-8?B?ZnFWMVNJbzhEYitaQ2VOcUhUM3Z3Mm80UXZSMFlEeE9pWEJWRVo5U2dkZC9R?=
 =?utf-8?B?N1FBTzIvMW55cE1PTGpRTDh1d25CR1Y3cnJXYmlLbXc4UVJjS0NNNUFhL0hw?=
 =?utf-8?B?TXJ0aXpNRFozL21yeXJiZVdBWHdrdXBXbXZZejBFTUU3dm9UWlZ5RXBoeTdL?=
 =?utf-8?B?Mmt3WHpCbFJVVDVqRXYvT1VCeDBwWW5XbHpFWWEyUWdKdzF2bGNSLy8weVJN?=
 =?utf-8?B?czBpZENXVDMyeW9UZHJld2g0eU1henZpQmtsSnhCSTZJZXh3amMyR1BDWllP?=
 =?utf-8?B?Z201NmRTeSswbEVIUXBaUEx6dTBvN3lVeGg3N1BNbVAvUEo5TndJSUVIQWVQ?=
 =?utf-8?B?MDJSQ2Y1elF0bFBFMitkTllMUWxnaXVZaHJOczJCS3cybmdhTWxXWXZOK2U0?=
 =?utf-8?B?TGw3a3lHbDRhSk5hNitCZk5qYWlnUi8vWVRDUnNneW5PUC9QbXh2Tkt5amQ4?=
 =?utf-8?B?MGg3SDQzYzl4OTJTUlVsVkhoZXozRzJveEtHbWgxVXg0eFdhSkJVbk1Nb1Mx?=
 =?utf-8?B?V25VUTdaVFhQMzR5dllDbWhXZG5nbjJrQjZwUmVaL243bkxHMXpBSkxPRTg2?=
 =?utf-8?B?UFN4K09EdDlqczdHRDhlRTdKL3dDa29QeWVsQ0FuOEZaNUZZdEZxdUZJNjR0?=
 =?utf-8?B?UFlnejg2b3NlbmFNMFluU21HVndYK2xvVGp4cmZhcjBnUTZud3JqZ0pNdmlD?=
 =?utf-8?B?SGcyeWxHN1V2N2hZdWVlUzNOdVFwMmJqUW5rcU1Xc1lmOFQ0N1lHR09IbVRu?=
 =?utf-8?B?aDRkY01URlY0dXRxb05hU3U1NGVGQ1lXY3NRaEk4dGlXSG01QkVWWWNiWGRk?=
 =?utf-8?B?eVJsYjFDVSt2TDhpajlWR2QxYytac25zNDdONmFaWGNwVGZpcnZtWlhNQUZZ?=
 =?utf-8?B?a3grTjhnM2lBcXlDeC9ubXB4N2ZMa3dFL0ZhMUM1RmxYQklVM2ZwaEhHbzN6?=
 =?utf-8?B?L2FFZlpPbEpGcWJvS3RKWGY1ZThNWjR5NHhEamp1MFNnRmc2UDZXcHpBYmY2?=
 =?utf-8?B?eVNTU1dsYksxSEFKZzlRSjdoVGg4MUhkbWZvN1lkZ1V4QXFtdDM3SGRGdG9q?=
 =?utf-8?B?L3F0WXBDQmRNSWxzN1A3LzhtUWhkaG9BOWllLzRHMFYzVHVPK2Zyc3huWGtJ?=
 =?utf-8?B?VGRNMUpYVWhGV0dHRy9BSmh2K2dCemJJR0EzSmhYQTREQkFsS0daZDZhN3Ex?=
 =?utf-8?Q?WBMydngNh34Rw4DVAAw/N1s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1744c3-74d2-4d04-d3bc-08dbdf068963
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 20:25:37.0623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tVhgAdcZKxrrG3jbKfTMMUaC/zCGe+uD4kxunCuHoWI6YwXdixDotwQfdo/Exgnr1cM8Ahx3Jb7A/CQvuQ70eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6994
X-Outbound-SMTP-Client: 72.163.7.163, rcdn-opgw-2.cisco.com
X-Outbound-Node: rcdn-core-5.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1cnNkYXksIE5vdmVtYmVyIDIsIDIwMjMgMToxMiBBTSwgSGFubmVzIFJlaW5lY2tlIDxo
YXJlQHN1c2UuZGU+IHdyb3RlOg0KPg0KPiBPbiAxMC8yNy8yMyAyMDowMywgS2FyYW4gVGlsYWsg
S3VtYXIgd3JvdGU6DQo+ID4NCj4gVGhhdCBpcyBvZGQuDQo+IElmIHlvdSBwYXNzIGluICdtcXRh
ZycgeW91IGNhbiBkZXJpdmUgdGhlIGhhcmR3YXJlIHF1ZXVlIGZyb20gaXQsIHNvIHlvdSBkb24n
dCBuZWVkIHRvIHBhc3MgaXQgaW4gc2VwYXJhdGVseS4NCj4gQWx0ZXJuYXRpdmUgaXQgd291bGQg
bWFrZSBzZW5zZSB0byBwYXNzIGluIHRoZSAndGFnJyB2YWx1ZSBpbnN0ZWFkIG9mICdtcXRhZycs
IGFzIHRoaXMgd291bGQgc2ltcGxpZnkgdGhlIGNvZGUgKHNlZWludCB0aGF0IHlvdSBkb24ndCBo
YXZlIHRvIGNhbGwgYmxrX21xX3VuaXF1ZV90YWdfdG9fdGFnKCkgYWxsIG92ZXIgdGhlIHBsYWNl
KS4NCj4NCj4gQ2hlZXJzLA0KPiBIYW5uZXMNCj4NCj4NCg0KVGhlIGZvcm1lciBhcHByb2FjaCBz
b3VuZHMgYmV0dGVyLg0KSSdsbCBhZG9wdCBpdCBpbiB2My4NCg0KUmVnYXJkcywNCkthcmFuDQo=
