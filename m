Return-Path: <linux-kernel+bounces-128254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3F8895860
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E087B23336
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC32133422;
	Tue,  2 Apr 2024 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eVuKL+WL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WNX3vdxG"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929FE2E40D;
	Tue,  2 Apr 2024 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072546; cv=fail; b=UVrqgHLMCcuBFzhlppQCii7WrdcKovrpn0/xjtDVEN1iVSu4QXFN4duxtXWobb1T2q+rkswx7Oeva3MpB65UFGHrH9cdeOKs/a4BCg7L3yPbChE5166/q01t8GPbM+A9zN2yg2Ae6d5NxfVFBxmngxK6m8n50chzTR5JchNZgmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072546; c=relaxed/simple;
	bh=UysYd4MtB68N22vnsEEl5cQQN3BDeKRJV/LP5BAOqXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b+HE0Ifwr076vPnmAyEHoHTVqVGRJ7NTizKD/yBJoUBpUskR8gFn8wbU+0zh5ZZw0nI91u6qiOib7SRuPiwSHR7Aipb0El104cOKaeQFQp0UQMSxV0A4b7t46bUdlg2QONkgEENscjIwJyNYlXbwW/5eLM81rJFzbL9lJdIdrvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eVuKL+WL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WNX3vdxG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 432F6f0l005856;
	Tue, 2 Apr 2024 15:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=IlF0jhSL7BSlYMYhE5KppcrTDs2cztEUBDSGJm1yWXM=;
 b=eVuKL+WLoua5czznHOXxuI9stAKqSOb8qsfMYvt4EEl9KqteuNRX6PJBbDqZHgmQu8T5
 2TA8/fIriMIGqxtuj06rmNQXIEV9BaaGgKtXERR6P8HagwMTVYWOs3DNUOHQ3yEXiI3K
 0gfF1+d+N+9TF7su+kLYGV92GCnerFxZ0MbX7TWbkbSK1O/4yKgSB70XzMyGGx2pR6xT
 76C4ztY6fNbj6hQg7K/uvHwXKj6qU1vSuSpG7KU/IjAnYx3euOP2rVXUR6DffoYuxJpA
 q3/5a3pxA4tDEzRpvrTWHAKLRsAhs4UJxVmrLSg6OIY197Xi9YSE40o6IUJja1dxl3n/ mA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x69ncn2dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 15:42:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 432ETHib031029;
	Tue, 2 Apr 2024 15:42:19 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x69670b93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 15:42:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8VaBEXvfybp6AryY2McOdv9j+T2Org6/qkiQfvZYokVxhhE6eKv/YzSzUx9gB060qTBP+R60cxsEpOal9k5tyx24I413gTmQdCQ+LBzNShyiCb59QmcWzoeqe0QAyxGAiUj9gIwSybhlxGHzeSXKZWKsySWVk6TUXv0WsyiUk8EsU61+3f5GLbKeXKgyu4TC6cxI25aK2fMtjfiktfAupLsMk9n20kkvC2WoTyruQRrey8/pTVNX6FrwZPJ7e/aBEVTiRNLAqJugiXAJRdJ6QTpgCYp+jRJEAxaGxs6IAoLU7hLNhfKwp88/wYFKRqv8Ft7qnYMHv51NZ+/s3LfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlF0jhSL7BSlYMYhE5KppcrTDs2cztEUBDSGJm1yWXM=;
 b=emNneGjq+TxKl3UerXG+zHJ+KAccy+W9TfWNr7le1dH+lfxtuYFpZosw8FXve1bENrezeb1Rqj7vjxLsUF3Hybne65dN62+5ibz+QmrKm14Bqr1Qbj4JWArfTOG45btpKeXmJ2QGKynG4h8DDYx7gpgqDqr0kZ01kFKW8ODRMfABkM81mC7qS2BGzcm+h9XuQ8X4f+wG6U/wLM/wri39sBRfAjS2AVMCiBXBlXKJNZtrvJ0fLT/2AK1/3JUoHe3mkLPFvTHWLfGOSOfi55WNKcj6hrOQ/Jj865T7cqq0T5xY4tQsL3gXJrIJA7cifLgLXfZzSoRB3ZTTYC6JGrgftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlF0jhSL7BSlYMYhE5KppcrTDs2cztEUBDSGJm1yWXM=;
 b=WNX3vdxGj5+qn9Qpqu8kBzwC10wJaMKyB/nZQMSd50JwqKd80Fbvs3kwra9F34b0G0k67/08sLZkkEUfMKeG2REOnVOPBBSKMB+lCLPuPwhU+MbzJCJ3Ir2Iq0bJ9plNBBo78WWyoTfjtC/3SgG5Irl4/Y0FwAUaXF34lczU7KU=
Received: from CH3PR10MB7959.namprd10.prod.outlook.com (2603:10b6:610:1c1::12)
 by BL3PR10MB6137.namprd10.prod.outlook.com (2603:10b6:208:3b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 15:42:15 +0000
Received: from CH3PR10MB7959.namprd10.prod.outlook.com
 ([fe80::fccf:9a21:99be:ed8a]) by CH3PR10MB7959.namprd10.prod.outlook.com
 ([fe80::fccf:9a21:99be:ed8a%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 15:42:15 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Quinn Tran <qutran@marvell.com>, Nilesh Javali <njavali@marvell.com>,
        "GR-QLogic-Storage-Upstream@marvell.com"
	<GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley"
	<jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Larry
 Wisneski <Larry.Wisneski@marvell.com>,
        Duane Grigsby
	<duane.grigsby@marvell.com>,
        "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] scsi: qla2xxx: Fix off by one in qla_edif_app_getstats()
Thread-Topic: [PATCH] scsi: qla2xxx: Fix off by one in qla_edif_app_getstats()
Thread-Index: AQHahOQh91yVHc4OCEGa0hzVKaMVTbFVHrUA
Date: Tue, 2 Apr 2024 15:42:15 +0000
Message-ID: <ABEE85CC-86A8-4DBB-A409-212834875E08@oracle.com>
References: <5c125b2f-92dd-412b-9b6f-fc3a3207bd60@moroto.mountain>
In-Reply-To: <5c125b2f-92dd-412b-9b6f-fc3a3207bd60@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB7959:EE_|BL3PR10MB6137:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ZMRb6dAlndYxKrO77TSpuar8OEUJ79LXOJBLkG4xndmKJmgtPSyk+qOg/tXcx9LVx4OCLx9o6Rtn7WPc8T/qB2fv1pj45ZXfiwaGQQPCWCtgKU7Oi/5t3z55BW9e/KAHqIt+k4sF8OXEqHdqGA4Zjc9oEuRK3JNKNXSGNDtQUEGuXTvdJq66WtZ42wFzfMoEGHzDXEVn2f6lmtq6D/i6djBT89e+hGNKiWtsItDpkoGyZc6nhXhers2MtAp3CENi7+JbT3Zk1oqOoO++i9KjxiAXwWdy/FnIItK7kV/wT4KLko9NMbrD8q26PsnNQrallP6teAp8dAXaUfwJ52HVz6mkhaF/bpztTngBAF/+q98GZG8j0ktsBVMvFLwq44dXp7V4GWPkItqCvlzh0rndT89McSUhfVFzjdwRZDLR1YwQ21UN9jkWX42HCqs1MQvDNW0Nc7uY9u5mZD/S8BAKhW+ptQxFPpUK/MmhNkCdh6jxos7S49z8r/xsH6xa1xOFpZKtg7kgyD12JCw+5igvL//aoF7B+Sa5mpCJY6MoZTNjutuVy3iAy/+EsChQRXo66YRaXqdf6xHHnh+jw8CM4BLkbNym2B2siD37/wwlkGx+o0qdzNjX/1DM6wyq7F2pPQDbrl1Z4Tzwf0qqFpvuV5M28RhqqaNpYruXoyuqC6k=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7959.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?6wCuZxBf3nCMEjjYu1fltub2/45QRAwno1YfujxxE/zPONHKYnlg8A01OWc6?=
 =?us-ascii?Q?DCXA5PogUCse2TZUL37ddlKC4FYQTEZ9l1Qj/PPjCiT84crV+PMlXwUsg6Aj?=
 =?us-ascii?Q?Y7cchFGVM+811+EGe0QdBC8LWzt6J0YWNAXshkvEx5VJIzemC98gm4yz6/hJ?=
 =?us-ascii?Q?nZ6s4yM8W5ec88/NQ/132IUBwjNv7yKvmqIGD+UHy42KsJl2eb1hX2GHIW8o?=
 =?us-ascii?Q?PnPwwtMIQZsPGh8BNT/E3601lDQRk2CxTpGqUP1xbaV+E8SsB7Pq4UxPApCj?=
 =?us-ascii?Q?GWBkQvOMHtKScObn8YMEsx3/DUuACGgf5hV5FtX+4v0LVJ4eocGpmQ7oa0gD?=
 =?us-ascii?Q?8VbaAIdqsjDxlZARI33mwvsK+lWmkbfwn01VIUt/Mf39JAMLUlxH+HofyS/k?=
 =?us-ascii?Q?8D0J2BaBrrvSAGVwh0fFOIxSXZopMam+hOhMzl1I0ACHZhrLeIhfFssZdJtf?=
 =?us-ascii?Q?altMNnoao3s82cDTWQipYnNRao61NCjvTIJ8fD9nwotue7t+v+yVYf3fFTW+?=
 =?us-ascii?Q?ZwrurWwR/EGyFf84Zk5XEN0a56AibFAWqMN56g0TO3IRowTlncSqhzxnJY1G?=
 =?us-ascii?Q?+cuIWSQqgcFG/EM/3nBfOYPUy0Yd1GlmOpNw135es0qDyhM7v6ctq+xbJ8c/?=
 =?us-ascii?Q?JzLwBkpTNjxVSN7cPPgKjbyQg9wjCgUMMrdXlcx+P4Wo8aPDqWWoMFLmoFR3?=
 =?us-ascii?Q?DNSmJ5Vh2xC/jsP3A3jORhUarrAamiTF1mHYy0Hzm3eWrXzBzp1GPOd+qDit?=
 =?us-ascii?Q?931KzIU9JviQaecOHuIhP5dKikp/wGZjJ64Q3EviVEbzUjyf1pCmZFoQlRmw?=
 =?us-ascii?Q?eENXQi6klvDYIrG9b76nbKNGif1/ovWkjldjZVRGjt1YtmjSQhYiceE2+L+X?=
 =?us-ascii?Q?IXX/pS+GADylroApe9MgYcQRe5fVdKNRBkFncuQ5pEY9k3qokK8HeS96SNtl?=
 =?us-ascii?Q?glXVQIk8pi/+alvCpqNSjt2Zg/eWCdq0mPHPprDb+5LksWj9Ujg6Tvryp65t?=
 =?us-ascii?Q?9FLkOmsNwZR+sTm1db9hwroQBPRkk1p4M3dVM3n/Lc9BudqMGJTnCA3KN/Aj?=
 =?us-ascii?Q?MddC1VQaJRW2Te3odXdz3lqyGXN9CZPPxYEvr5FOTOnKLM6S+wQFYWg4aeUe?=
 =?us-ascii?Q?SbPqKhxwt8QyKi+PSK5ZZi+RawJj0MFR0Q88N+XWBdwZdqKSh7KAsOeHEd40?=
 =?us-ascii?Q?98p7vEwoK2Hc2eq6C+p9XioRTd6LtnxtawR55JiWbhDruLlwza7I+ZUvEk+u?=
 =?us-ascii?Q?7BgBjrrE4Q8qA+AQUBs4SqYdPtgDP19LP8zwu74KvvrzjX6mi42coPZEdKWy?=
 =?us-ascii?Q?/534ISNg0q6atBa14Q/PYOhSQd0QTZ4evzpnWhFr7ekiXwMpjQs7rzfdvlMd?=
 =?us-ascii?Q?jpw2AO5jXwSuwv7Hf6LfSb2DHMymxyGOUQ66w/jK794gJg3rF+taWGiNLQOZ?=
 =?us-ascii?Q?hUaOvjs6RcP8gC/NOVQ46zBMiqQHo+ZgN7fZEL7INXGsTtjYqwxnMXfP4f5b?=
 =?us-ascii?Q?T7iy5RIyVyIpCTOLq7aB/X7Z1ZpCTjMVchknnvUvlcP4fB9ZnB52X+jC1mn2?=
 =?us-ascii?Q?Y52TBckXWdrEVMq6Ey2zFnCD8ta/0hXGbt5a12+TogSJ3DH3I5gZWFb+3bUG?=
 =?us-ascii?Q?2nnjfgcIcn21GP8wU0lOd/I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B3332801D2332C4585760D60413BC21D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	J2sVHmE6UlkG/+8qWK1bVYQpz6LwWnk11BPWMnPNWXF1rzrbkM+FxUiLVvSg1PdFLrUKUZ1f/N7FCJFlGclu8AZEb6HU6r67tsWzJo7glfAFFibzdXY+nYTKYt578fxS9h81xBHCmWdTENeH0ky8/bt+02FS412NcplbuqbxwaQf/Pn7AairP8wgAeLsMCjVxav8QaACSqas1bZaSiVNGtkpfNFOLiqx3ZyhBY/ToZhWpMNzUZecc0ePrlgYds+6gv5Po5xUZArhgU4MP0pRfuPklCTS9I7FEDrwAE7nyD8sA8TMCqTlJRZfWRcfJg/zMCr0tg0J3jeHPberU6F0Z5JareOzSuhV3vUE0nJYiAP0rHNOmEBW4YMPKTeI/z5aj7GQ6sIVyPG7WMhZsg91WISccTyqUWPZW4CcXKoHyP4t+CPc7yI8yGodXS4RSxBWhyJsioLKHA2a3l/2qvI3X2K+FwMqFwryeQn2h3nYEgqaj8xIWbqdFBTsK3uHRL30Dp+YJDyAxzcn9lzB7Tc4pp5j3QE161ig5BbhB3/b0/kq+Y/+leThzsJj/fuJ1B7Q2WCnFzwr/qkceYfvC00ZmgXEp1/nbe3Cw1HxmWrVB6Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7959.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216c3925-3215-48b2-2288-08dc532b78d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 15:42:15.5236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0E0I4SAjY+DMKe02hMnIa3OPja3qE4Xr47JKleiQTSt/S1TvlpVdv9imI94Wdggb+jiBv6+n1+mq7yiYP8E3QEYo0+rvaFG2SjOgySe7Ekw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_09,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2404020115
X-Proofpoint-GUID: x7XqOVCHw_xHFlZxhb2NXXz3wd-jiO2l
X-Proofpoint-ORIG-GUID: x7XqOVCHw_xHFlZxhb2NXXz3wd-jiO2l



> On Apr 2, 2024, at 02:56, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>=20
> The app_reply->elem[] array is allocated earlier in this function and it
> has app_req.num_ports elements.  Thus this > comparison needs to be >=3D
> to prevent memory corruption.
>=20
> Fixes: 7878f22a2e03 ("scsi: qla2xxx: edif: Add getfcinfo and statistic bs=
gs")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> drivers/scsi/qla2xxx/qla_edif.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_e=
dif.c
> index 26e6b3e3af43..dcde55c8ee5d 100644
> --- a/drivers/scsi/qla2xxx/qla_edif.c
> +++ b/drivers/scsi/qla2xxx/qla_edif.c
> @@ -1100,7 +1100,7 @@ qla_edif_app_getstats(scsi_qla_host_t *vha, struct =
bsg_job *bsg_job)
>=20
> list_for_each_entry_safe(fcport, tf, &vha->vp_fcports, list) {
> if (fcport->edif.enable) {
> - if (pcnt > app_req.num_ports)
> + if (pcnt >=3D app_req.num_ports)
> break;
>=20
> app_reply->elem[pcnt].rekey_count =3D
> --=20
> 2.43.0
>=20

Looks Good.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com <mailto:himanshu=
madhani@oracle.com>>

--=20
Himanshu Madhani Oracle Linux Engineering


