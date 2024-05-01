Return-Path: <linux-kernel+bounces-165000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10D98B864D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D642C1C20D15
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F3D4DA16;
	Wed,  1 May 2024 07:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="sptigEKU"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70D54AEF0
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714549630; cv=fail; b=qBYiL+RmXDnkYIz/R+3JzRxonKVNetPw+wW5nSDTLt6esIwgVAOCX1uY3P8jSaAoyDsi3zLBV2jWj5kN3V7Ts+57ZfT6xzw7KIesNiOoKbWs2vyRd3/lf5S+0hJ9bjn6O9OXjytFMznKrxhg/83TWZ4iYkN6itGLpTlkytiX6dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714549630; c=relaxed/simple;
	bh=TG+D6cK1Sw+AmX8glSPK40y3GzB6jC3bg/mupmtYWgs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sJomeuaVqWnymJoW0e9DRAohSQBiB3+Rrs2XD0SjYn2xynZNjc8jVppFFos8GzE4K9n2tztv4xqGxi6I9POKrfDJ6JgtbvFkHIAWZtp84iuQoQQbx9T0e9TTqHomYhCnva3L9zww1XAsp3iEOWhzHjj4L2c3d4R7cKd0Q61sBb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=sptigEKU; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UNYk4d008487;
	Wed, 1 May 2024 00:46:59 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xtxqf435c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 00:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJXM8iH9lXoTRdOr7mJzjcrKgnOnFy95uZ3Heg17efhSSkxdPUmU5JKdpywVWLyWjZGUacQP/0hUim3cWej+tR8Fjt3bfYzXv9ypMpmb4ZcJJjb77U5JfzV+TVlB9yw6sZOxHlpWCmQfJmCl/ppAZEQoETFciQyt8wGGI0WfHcNFXRYUhF9mzV5WpehfKnuOImGQcYmmSkZVaWQuOy0ybqQQh4yJ25npj0uj2k76W76es/atlwOeFdJQZG+LfjlLFz45JeJTb3GIQgeX+d/1heJCcbDB5UooZKtasHcP990dnq4/0rVEBjCM94Lppd9u6GTt6UwbTvkrejCa22u/2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCcazqzsPXTJoeASSuf8GbC5/m3/RW3hoDkieNVHmWQ=;
 b=V896VcyYNK5YZ09EB8bxftbIJuq3+TpW6f0rZA3UyvAwPRWmZFqIHtEll4qyhkpwY+YhRvn7PMK+DmTqnfCTOHO7IDuFzv4wENaLVYOzpVMXk03VAH+yAzwMlQY/TQWmW6ONjtxzRI7h+Qn823N/ChQ6ixwdv4tH2RfMxeTvLB26Bk2sVSnvO7HOOX/l8ki0Qnl5EFz2+T6RXh2vDRh+2hL8Ab+nHP3+2aTBPWS7XTvfZnsimArsTmvVYIm9YAvgvigXfYCLObaw/04zRrw/OGE58X2X3UnMggSzVjpY0HzfcDTW/wz19N9Z692MLRuKXbg1DS5RE4h93aA31uSjqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCcazqzsPXTJoeASSuf8GbC5/m3/RW3hoDkieNVHmWQ=;
 b=sptigEKU0ZyUGfvyUaLIqquzJG3Bci7KdCuYFYfojVJJOIJVU45kCt41ZXwBSm7lr/7NgtX35nBZfILmfAsGOW/YEladsNLfo/GrrYWCRLFFyXAySWf39r3VSIHaynr84VRMKi//9Pjp463d5g1yLVYdoYxYvsHu+9sXdFvLhPY=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by SJ0PR18MB3868.namprd18.prod.outlook.com (2603:10b6:a03:2cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25; Wed, 1 May
 2024 07:46:55 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b%3]) with mapi id 15.20.7519.035; Wed, 1 May 2024
 07:46:55 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "arnd@arndb.de" <arnd@arndb.de>, Jerin Jacob <jerinj@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v6 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Topic: [EXTERNAL] Re: [PATCH v6 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Index: AQHamfkp7FGSOUKA40uNodeVHlaTCLF+9yeAgABwFAA=
Date: Wed, 1 May 2024 07:46:55 +0000
Message-ID: 
 <MW4PR18MB5244A08DC9D2CF3FAF14314FA6192@MW4PR18MB5244.namprd18.prod.outlook.com>
References: 
 <MW4PR18MB5244E39EEBC3689CBF086050A6152@MW4PR18MB5244.namprd18.prod.outlook.com>
 <20240429055027.2162310-1-vattunuru@marvell.com>
 <2024042950-refurbish-duckbill-77b4@gregkh>
In-Reply-To: <2024042950-refurbish-duckbill-77b4@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|SJ0PR18MB3868:EE_
x-ms-office365-filtering-correlation-id: d1b9e2e4-6466-4af6-fc80-08dc69b2df63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?gFpGZAxVxdBroxGSii4I/vaeTzHs1wz9OYmtYlIb3ztPfK+2VxtLOsKa9Y+9?=
 =?us-ascii?Q?TY45nJTJUlshDkAruO9pbNAo8desfN7YuKTtV8AAo0ygiuczzrjcp7SOyKj/?=
 =?us-ascii?Q?Mg+ZCxqWyK+pnsRT151srErlFvmp4dv6zJvVjS78PeTTuxfbdDda85CMg6tz?=
 =?us-ascii?Q?+pc/gFBXWJO6Aw2TVJVfEjS/CvtkyFOiKBrrPzmCm6s9fbINV/kfzo1jQu7F?=
 =?us-ascii?Q?6cIkJN0AMhjyeIZ5GZ8dqnjyTcsuPgyguh0/J2/j7fiRKHJ0OlwDtYuw1GCa?=
 =?us-ascii?Q?S4k3I1C7X+eWk7rY9OAxfH5BbEdpT9Q92Jikic1YilD43jwX6DXiI8k3V8p8?=
 =?us-ascii?Q?vJQPKL6//k6hMwFXcjLMVvzjpNoS2CbsGfrWM8dlHSF2ZHK1lPXhjjOXFBnX?=
 =?us-ascii?Q?iVwWu2giXt93Zt9zisFvmu8VAX8PRMbdksAHT0b/LHfXGYtdAHYU6WySFdu8?=
 =?us-ascii?Q?VN8QUbcMMqZV9ucqinucKA0WqDPlnSVpTmyZJ1lIwnl1GxfKGUzbMulwZC1r?=
 =?us-ascii?Q?lPfWMbrI5hK+KNL4+CkH2y7k4KeOmNqAW0MMofqTxcVz8J3rlCERrXz2OCy+?=
 =?us-ascii?Q?ZsRE1IJwcbnGXCA4PXOao9qk9U+mSXnyEXhCZtbKYFIBR7qxUZJWakKoDhH8?=
 =?us-ascii?Q?nHq0OzPlNVC7NvSTwi45Oaln2+1RxN2/yioERN/aBQpMkn1cFcQSR1x0fsFn?=
 =?us-ascii?Q?a19VKFszp23OAx1m6U86O45N6Tw9LONnlDf9YucaVX46DS+ZtSiKd+Ukc7pC?=
 =?us-ascii?Q?FsOXU8VNmPh/gML4PFxIoQmuvYe6zBGGb8kL6IOCW/vOA2Aawq4Nbo1qomSJ?=
 =?us-ascii?Q?ar7gwZnpYBKz7toc1yoCkJDXFk1rg6FUqzEvoaJWxv0isKngvVzCrGNB/+WV?=
 =?us-ascii?Q?5TH6QwtRBUWbderWxa1fh2D1mNbTjMv8nfPowAVUcllIPB2eXSHlBNg7ehle?=
 =?us-ascii?Q?gLY+OPexPZeG9+9m8DfCikINhlqjSOUXHjaMwo3Qg8eV3aXYnbSr4uKkU4B/?=
 =?us-ascii?Q?8Dxqm7r1L5iJaIhWWnmCk6y+pu9Xf+k5dtOnhyFLJr1a0lCtuiGdHQp4Emc/?=
 =?us-ascii?Q?vcwcZhYovagl3/trdIxbbET5DYdtC6sdYPIXIXv/nyap48f57VkeM96X8jZ0?=
 =?us-ascii?Q?Bq+rVM6RlvtOUDPRZDmhFrKZJcXPV8SYPugmX1m/x3tYpdOv4AZ6UmzpvbL4?=
 =?us-ascii?Q?ca0G0d6HaXby/BQA8Rsv/qnoqv27/jIP8IYVn68Ek7jKhzviN3whYK3cbNB9?=
 =?us-ascii?Q?z89ocxuipc0lSBXZBLUw41mDAUr9lVXZVf25SEk/Yg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?tKMRCkN1M9RRFDmSICWvQruvv9SFlZAcJd32NvK+gkY2iNhoxmYWjvr/HWST?=
 =?us-ascii?Q?aezzf0ECVljSzdjAeZmQKLAbaPbrNiZ+W9P/Q2LTIgX8Tk/ayZNuehSSExZX?=
 =?us-ascii?Q?Q35N96VlGqwq2g3q6QaDptBM1olRFN1z2RNAw9qt/F7xaazAEbGLdSd151Ae?=
 =?us-ascii?Q?Kge5bprxrBTPKb8iTKoN6miz2tn4FeBFbm84e6FcYemN4AhWVJfHVk8s0bc8?=
 =?us-ascii?Q?gOEUyrJWpgjOj2fYpY7YkFnzCXPkyCgwAg6wIal9l74fCbja9jdAUY9xPkla?=
 =?us-ascii?Q?QNKRRPVVqJ2Z45jOjlbny8JSYZknaMY7e97zCPxGDRswUqkktFhm0W3oRpXm?=
 =?us-ascii?Q?7aN/RUk6QI21y47upgT3/cqIwD0Zl861HiljgpI4CZoTE8GBkSkEVcL8LScP?=
 =?us-ascii?Q?+aNEcRkBRRFwwnINkbv+zhogh0lZeC5rC9hIFagz3hZ8y7wk+Bq6LPOnXsJY?=
 =?us-ascii?Q?n7OqQdvEZEvN6nbmbjDdZpCoP2Ktx2xcNDX+yCRT22L20pTmrn8Qj6cntaA4?=
 =?us-ascii?Q?W+lxeBdEFyuChKD7FAvxmkWSsfaPGU5vhwJpvDcev0ShG7TTTeJMZNlfSmpH?=
 =?us-ascii?Q?EPfaV+sRwhlu5ooLfEtnHTuJkGOGHV0CJtq2YvOMRetMyvGo/AzPbZE4CsKg?=
 =?us-ascii?Q?UVpru2WHnwMYWxA8c9Sk8YbV9XprjgrMaz+v+V0CG+A3VyyzZeApC8S0TYGi?=
 =?us-ascii?Q?bpUKmVChatFPorvrvve5OMZ8JHRmUHWQVwIutOx7XR9DppzNn4I5TVJ4M4W3?=
 =?us-ascii?Q?LVa7VKoCA6wPaiDmbyyt55u90/nsUn1xgocgdDSud05rbsB3J85we54rhLKG?=
 =?us-ascii?Q?90WNlB9Uw62dV3Xv6ZesWU8XhkifvBxMBBwPs6s2k+Oa858xjFI6hL9BsVnL?=
 =?us-ascii?Q?rw0EZxc11iV4YgTU6LjrjwqRYtWoV7fdaA6m95FCcZ87YYQm3kk/w7cPSdbn?=
 =?us-ascii?Q?egAs3uRdqQiqJNyMIUBxqguQFucsnDAuw50hDghmEr7bEqIX24uVRt92IBUQ?=
 =?us-ascii?Q?YbPCfCGaGOeDpSshCgt3TkZsF+PICknzDVyTuraoVIIAwcnstt7MbT6Cw54e?=
 =?us-ascii?Q?2f8ZX8EdB4uSEqW7zHqBYjDJKJNk8aUS3BJg/djftCFeUCm7aHLEjcnExXli?=
 =?us-ascii?Q?ZGmPSgvtR0o0zKewKgEfAHsLQoayNfhBKLr2OtwER63Iu1+C/tiCoRQcO591?=
 =?us-ascii?Q?gV29AmirtzCTigqJcb3T5wPIqODcwbNHqbmXrBNJjIZeM9K2KaIv7et4VjAC?=
 =?us-ascii?Q?jUisy1K9aWUvw1A3wOesneg6kYPhUgUxdhQ42dAZzxV/GT/YUyYtVlX3pw5K?=
 =?us-ascii?Q?By33EOBeqVrI4iyQVCJih6c05TAROSWDfqM4+xXd1G1PXJ9Xpryu2S7zLSDo?=
 =?us-ascii?Q?+rtK56lPI71XuvjlKhHeb+v0dIV0c1e7U/h+/w4h+KvsHVSxWgBme3rKwyby?=
 =?us-ascii?Q?gurfQ9uCzhafufmptr12wpWrzmaIs1PA/gnkhJXyMqmjPd3RqDKsPbIjjq9t?=
 =?us-ascii?Q?mY+d1EotZhwC/hij7QYcrZuEfMvk+3zbnRQ2cFqlS0y/vCbu5wHknXRA8MC+?=
 =?us-ascii?Q?mGTJhtGArHjJcfz7tJMSJ1HkGmrnurIqywYv5C4a34ObzbHK5Rb62qX/aqeu?=
 =?us-ascii?Q?V7gTkWTVEkdnhN6ehgX/gH+q0hF/nMNw0E5umh0+SjlJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5244.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b9e2e4-6466-4af6-fc80-08dc69b2df63
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 07:46:55.2115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O0DRYcAbKfepQy5HfnOTDxqbfuRrPBkozyepbmJH/q4WGSYvR8yjypdAalDZxo3DALBKIrTTovw3LPuDhPvHnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3868
X-Proofpoint-GUID: r26eJvKEX9LAHu2QS5PfPGeD3HdIzt5E
X-Proofpoint-ORIG-GUID: r26eJvKEX9LAHu2QS5PfPGeD3HdIzt5E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_07,2024-04-30_01,2023-05-22_02



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Monday, April 29, 2024 2:44 PM
> To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> Cc: arnd@arndb.de; Jerin Jacob <jerinj@marvell.com>; linux-
> kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH v6 1/1] misc: mrvl-cn10k-dpi: add Octeon
> CN10K DPI administrative driver
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> On Sun, Apr 28, 2024 at 10:50:27PM -0700, Vamsi Attunuru wrote:
> > Adds a misc driver for Marvell CN10K DPI(DMA Engine) device's physical
> > function which initializes DPI DMA hardware's global configuration and
> > enables hardware mailbox channels between physical function (PF) and
> > it's virtual functions (VF). VF device drivers (User space drivers)
> > use this hw mailbox to communicate any required device configuration
> > on it's respective VF device. Accordingly, this DPI PF driver
> > provisions the VF device resources.
> >
> > At the hardware level, the DPI physical function (PF) acts as a
> > management interface to setup the VF device resources, VF devices are
> > only provisioned to handle or control the actual DMA Engine's data tran=
sfer
> capabilities.
> >
> > Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
>=20
> No one else at Marvell has reviewed this before you submitted this?

It was reviewed until V3, sorry for the inconvenience. I will get the next =
version
thoroughly reviewed and will send with reviewed-by sign off.
>=20
> > ---
> > Changes V5 -> V6:
> > - Updated documentation
> > - Fixed data types in uapi file
> >
> > Changes V4 -> V5:
> > - Fixed license and data types in uapi file
> >
> > Changes V3 -> V4:
> > - Moved ioctl definations to .h file
> > - Fixed structure alignements which are passed in ioctl
> >
> > Changes V2 -> V3:
> > - Added ioctl operation to the fops
> > - Used managed version of kzalloc & request_irq
> > - Addressed miscellaneous comments
> >
> > Changes V1 -> V2:
> > - Fixed return values and busy-wait loops
> > - Merged .h file into .c file
> > - Fixed directory structure
> > - Removed module params
> > - Registered the device as misc device
> >
> >  Documentation/misc-devices/index.rst          |   1 +
> >  Documentation/misc-devices/mrvl_cn10k_dpi.rst |  57 ++
> >  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
> >  MAINTAINERS                                   |   5 +
> >  drivers/misc/Kconfig                          |  13 +
> >  drivers/misc/Makefile                         |   2 +
> >  drivers/misc/mrvl_cn10k_dpi.c                 | 685 ++++++++++++++++++
> >  include/uapi/misc/mrvl_cn10k_dpi.h            |  37 +
> >  8 files changed, 801 insertions(+)
> >
> > diff --git a/Documentation/misc-devices/index.rst
> > b/Documentation/misc-devices/index.rst
> > index 2d0ce9138588..10f2e0f74e45 100644
> > --- a/Documentation/misc-devices/index.rst
> > +++ b/Documentation/misc-devices/index.rst
> > @@ -20,6 +20,7 @@ fit into other categories.
> >     ics932s401
> >     isl29003
> >     lis3lv02d
> > +   mrvl_cn10k_dpi
> >     max6875
> >     oxsemi-tornado
> >     pci-endpoint-test
>=20
> Why not in sorted order?
Ack, will fix it.

>=20
> > diff --git a/Documentation/misc-devices/mrvl_cn10k_dpi.rst
> > b/Documentation/misc-devices/mrvl_cn10k_dpi.rst
> > new file mode 100644
> > index 000000000000..cce202f114b7
> > --- /dev/null
> > +++ b/Documentation/misc-devices/mrvl_cn10k_dpi.rst
> > @@ -0,0 +1,57 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Marvell CN10K DMA packet interface (DPI) driver
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Overview
> > +=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +DPI is a DMA packet interface hardware block in Marvell's CN10K silico=
n.
> > +DPI hardware comprises a physical function (PF), its virtual
> > +functions, mailbox logic, and a set of DMA engines & DMA command
> queues.
> > +
> > +DPI PF function is an administrative function which services the
> > +mailbox requests from its VF functions and provisions DMA engine
> > +resources to it's VF functions.
> > +
> > +mrvl_cn10k_dpi.ko misc driver loads on DPI PF device and services the
> > +mailbox commands submitted by the VF devices and accordingly
> > +initializes the DMA engines and VF device's DMA command queues. Also,
> > +driver creates /dev/mrvl-cn10k-dpi node to set DMA engine and PEM
> > +(PCIe interface) port attributes like fifo length, molr, mps & mrrs.
> > +
> > +DPI PF driver is just an administrative driver to setup its VF
> > +device's queues and provisions the hardware resources, it can not
> > +initiate any DMA operations. Only VF devices are provisioned with DMA
> capabilities.
> > +
> > +Driver location
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +drivers/misc/mrvl_cn10k_dpi.c
> > +
> > +Driver IOCTLs
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +:c:macro::`DPI_MPS_MRRS_CFG`
> > +ioctl that sets max payload size & max read request size parameters
> > +of a pem port to which DMA engines are wired.
> > +
> > +
> > +:c:macro::`DPI_ENGINE_CFG`
> > +ioctl that sets DMA engine's fifo sizes & max outstanding load
> > +request thresholds.
> > +
> > +Userspace code example
> > +----------------------
> > +
> > +DPI VF devices are managed by user space drivers, below is a
> > +reference code to the user space driver's mailbox command exchange
> > +with DPI PF driver through hardware mailbox.
> > +
> > +https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__github.com_Vamsi
> > +KrishnaA99_dpi-2Ddma_blob_main_driver_roc-
> 5Fdpi.c&d=3DDwIBAg&c=3DnKjWec2b
> >
> +6R0mOyPaz7xtfQ&r=3DWllrYaumVkxaWjgKto6E_rtDQshhIhik2jkvzFyRhW8&m
> =3D7PlVgM
> > +7n0EhJ17QxPm3mXq6PT0CQzsOn2YFnRB8RMsIQdFAsZ5UKdTFmkcChUrf-
> &s=3D8wLYfXsc
> > +lLz7Fuvz9FfyEehC5xTSiIa88PJzturPF4U&e=3D
> > +
> > +Below is a sample application that uses driver IOCTLs to setup DMA
> > +engine and PEM port attributes over `/dev/mrvl-cn10k-dpi` node.
> > +
> > +https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__github.com_Vamsi
> > +KrishnaA99_dpi-
> 2Ddma_blob_main_application_main.c&d=3DDwIBAg&c=3DnKjWec2b
> >
> +6R0mOyPaz7xtfQ&r=3DWllrYaumVkxaWjgKto6E_rtDQshhIhik2jkvzFyRhW8&m
> =3D7PlVgM
> > +7n0EhJ17QxPm3mXq6PT0CQzsOn2YFnRB8RMsIQdFAsZ5UKdTFmkcChUrf-
> &s=3DBMRvLLAx
> > +cnlsyZlVCgOoUXju_jKom8zbKQ9GxlxlApg&e=3D
>=20
> I appreciate the code being open, but this is on a personal account that =
was
> created for only this one package, and it doesn't even have a README.  Ye=
t it
> is fully owned/copyrighted by Marvell and the code has been around since
> 2021?  Why isn't this on a Marvell-controlled page to show that this real=
ly is
> supported and is the proper interface to use this driver that it provides=
 to
> their customers?
>
User space driver is already part of open-source code base(github.com/DPDK/=
dpdk.git).
The mailbox related changes in user driver (roc_dpi.c file) are not yet ups=
treamed
which has the dependency with this kernel driver. So, I put the latest user=
 driver
in personal account and shared so that it's helpful for reviewing kernel dr=
iver.

I will work internally and get it moved to Marvell-controlled page, will ho=
st at
https://github.com/MarvellEmbeddedProcessors and update the same in
Documentation page in next version.=20

>
>=20
> > diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > index 457e16f06e04..e6fd0c386b59 100644
> > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > @@ -358,6 +358,7 @@ Code  Seq#    Include File
> Comments
> >  0xB6  all    linux/fpga-dfl.h
> >  0xB7  all    uapi/linux/remoteproc_cdev.h                            <=
mailto:linux-
> remoteproc@vger.kernel.org>
> >  0xB7  all    uapi/linux/nsfs.h                                       <=
mailto:Andrei Vagin
> <avagin@openvz.org>>
> > +0xB8  01-02  uapi/misc/mrvl_cn10k_dpi.h                              M=
arvell CN10K DPI
> driver
> >  0xC0  00-0F  linux/usb/iowarrior.h
> >  0xCA  00-0F  uapi/misc/cxl.h
> >  0xCA  10-2F  uapi/misc/ocxl.h
> > diff --git a/MAINTAINERS b/MAINTAINERS index
> > 960512bec428..ab77232d583e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13104,6 +13104,11 @@ S:	Supported
> >  F:	Documentation/devicetree/bindings/mmc/marvell,xenon-
> sdhci.yaml
> >  F:	drivers/mmc/host/sdhci-xenon*
> >
> > +MARVELL OCTEON CN10K DPI DRIVER
> > +M:	Vamsi Attunuru <vattunuru@marvell.com>
> > +S:	Maintained
>=20
> So this is not part of your job to support this code?  Why isn't Marvell =
allowing
> that to happen?

No, we are happy to support it further, will fix this.

>=20
> > +F:	drivers/misc/mrvl_cn10k_dpi.c
> > +
> >  MATROX FRAMEBUFFER DRIVER
> >  L:	linux-fbdev@vger.kernel.org
> >  S:	Orphan
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig index
> > 4fb291f0bf7c..78470ef2538f 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -574,6 +574,19 @@ config NSM
> >  	  To compile this driver as a module, choose M here.
> >  	  The module will be called nsm.
> >
> > +config MARVELL_CN10K_DPI
> > +	tristate "Octeon CN10K DPI driver"
> > +	depends on ARM64 && PCI
> > +	help
> > +	  Enables Octeon CN10K DMA packet interface (DPI) driver which
> intializes
> > +	  DPI hardware's physical function (PF) device's global configuration
> and
> > +	  its virtual function's (VFs) resource configuration to enable DMA
> transfers.
> > +	  DPI PF device does not have any data movement functionality, it
> only serves
> > +	  VF's resource configuration requests.
>=20
> Nit, please wrap at 72 columns, didn't checkpatch.pl complain about this?
>=20

Yes, I did not see any complains, not sure if I am missing any options. I w=
ill
double check and ensure clean patch in next version.=20

> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called mrvl_cn10k_dpi.
> > +
> >  source "drivers/misc/c2port/Kconfig"
> >  source "drivers/misc/eeprom/Kconfig"
> >  source "drivers/misc/cb710/Kconfig"
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile index
> > ea6ea5bbbc9c..5106bf96ea5c 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -68,3 +68,5 @@ obj-$(CONFIG_TMR_INJECT)	+=3D xilinx_tmr_inject.o
> >  obj-$(CONFIG_TPS6594_ESM)	+=3D tps6594-esm.o
> >  obj-$(CONFIG_TPS6594_PFSM)	+=3D tps6594-pfsm.o
> >  obj-$(CONFIG_NSM)		+=3D nsm.o
> > +obj-$(CONFIG_MARVELL_CN10K_DPI)	+=3D mrvl_cn10k_dpi.o
> > +obj-y	+=3D mrvl_cn10k_dpi.o
>=20
> That is odd, why are you saying obj-y here?  You want everyone to always
> build this code into the kernel image no matter what
>=20

Sorry, it's my bad, this change(2nd line) was mistakenly added, will remove=
 it.

> > diff --git a/drivers/misc/mrvl_cn10k_dpi.c
> > b/drivers/misc/mrvl_cn10k_dpi.c new file mode 100644 index
> > 000000000000..bd99583994f9
> > --- /dev/null
> > +++ b/drivers/misc/mrvl_cn10k_dpi.c
> > @@ -0,0 +1,685 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Marvell Octeon CN10K DPI driver
> > + *
> > + * Copyright (C) 2024 Marvell.
> > + *
> > + */
> > +
> > +#include <linux/compat.h>
> > +#include <linux/delay.h>
> > +#include <linux/miscdevice.h>
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/irq.h>
> > +#include <linux/interrupt.h>
> > +
> > +#include <uapi/misc/mrvl_cn10k_dpi.h>
> > +
> > +#define DPI_DRV_NAME	"mrvl-cn10k-dpi"
>=20
> KBUILD_MODNAME please.

ack
>=20
> > +
> > +/* PCI device IDs */
> > +#define PCI_DEVID_MRVL_CN10K_DPI_PF	0xA080
> > +#define PCI_SUBDEVID_MRVL_CN10K_DPI_PF	0xB900
> > +
> > +/* PCI BAR nos */
>=20
> What is "nos"?
It's numbers, will add full wording.
>=20
> > +#define PCI_DPI_CFG_BAR	0
> > +
> > +/* MSI-X interrupts */
> > +#define DPI_MAX_REQQ_INT 32
> > +#define DPI_MAX_CC_INT   64
> > +
> > +/* MBOX MSI-X interrupt vector index */ #define
> > +DPI_MBOX_PF_VF_INT_IDX 0x75
> > +
> > +#define DPI_MAX_IRQS (DPI_MBOX_PF_VF_INT_IDX + 1)
> > +
> > +#define DPI_MAX_VFS	32
> > +
> > +#define DPI_ENGINE_MASK GENMASK(2, 0)
> > +
> > +#define DPI_DMA_IDS_DMA_NPA_PF_FUNC(x)		(((x) &
> GENMASK_ULL(15, 0)) << 16)
> > +#define DPI_DMA_IDS_INST_STRM(x)		(((x) &
> GENMASK_ULL(7, 0)) << 40)
> > +#define DPI_DMA_IDS_DMA_STRM(x)			(((x) &
> GENMASK_ULL(7, 0)) << 32)
> > +#define DPI_DMA_ENG_EN_MOLR(x)			(((x) &
> GENMASK_ULL(9, 0)) << 32)
> > +#define DPI_EBUS_PORTX_CFG_MPS(x)		(((x) & GENMASK(2,
> 0)) << 4)
> > +#define DPI_DMA_IDS_DMA_SSO_PF_FUNC(x)		((x) &
> GENMASK(15, 0))
> > +#define DPI_DMA_IDS2_INST_AURA(x)		((x) & GENMASK(19,
> 0))
> > +#define DPI_DMA_IBUFF_CSIZE_CSIZE(x)		((x) & GENMASK(13,
> 0))
> > +#define DPI_EBUS_PORTX_CFG_MRRS(x)		((x) & GENMASK(2,
> 0))
> > +#define DPI_ENG_BUF_BLKS(x)			((x) & GENMASK(5,
> 0))
> > +#define DPI_DMA_CONTROL_DMA_ENB
> 	GENMASK_ULL(53, 48)
> > +
> > +#define DPI_DMA_CONTROL_O_MODE			BIT_ULL(14)
> > +#define DPI_DMA_CONTROL_LDWB			BIT_ULL(32)
> > +#define DPI_DMA_CONTROL_WQECSMODE1		BIT_ULL(37)
> > +#define DPI_DMA_CONTROL_ZBWCSEN			BIT_ULL(39)
> > +#define DPI_DMA_CONTROL_WQECSOFF(offset)	(((u64)offset) << 40)
> > +#define DPI_DMA_CONTROL_WQECSDIS		BIT_ULL(47)
> > +#define DPI_DMA_CONTROL_PKT_EN			BIT_ULL(56)
> > +#define DPI_DMA_IBUFF_CSIZE_NPA_FREE		BIT(16)
> > +
> > +#define DPI_CTL_EN				BIT_ULL(0)
> > +#define DPI_DMA_CC_INT				BIT_ULL(0)
> > +#define DPI_DMA_QRST				BIT_ULL(0)
> > +
> > +#define DPI_REQQ_INT_INSTRFLT			BIT_ULL(0)
> > +#define DPI_REQQ_INT_RDFLT			BIT_ULL(1)
> > +#define DPI_REQQ_INT_WRFLT			BIT_ULL(2)
> > +#define DPI_REQQ_INT_CSFLT			BIT_ULL(3)
> > +#define DPI_REQQ_INT_INST_DBO			BIT_ULL(4)
> > +#define DPI_REQQ_INT_INST_ADDR_NULL		BIT_ULL(5)
> > +#define DPI_REQQ_INT_INST_FILL_INVAL		BIT_ULL(6)
> > +#define DPI_REQQ_INT_INSTR_PSN			BIT_ULL(7)
> > +
> > +#define DPI_REQQ_INT \
> > +	(DPI_REQQ_INT_INSTRFLT		| \
> > +	DPI_REQQ_INT_RDFLT		| \
> > +	DPI_REQQ_INT_WRFLT		| \
> > +	DPI_REQQ_INT_CSFLT		| \
> > +	DPI_REQQ_INT_INST_DBO		| \
> > +	DPI_REQQ_INT_INST_ADDR_NULL	| \
> > +	DPI_REQQ_INT_INST_FILL_INVAL	| \
> > +	DPI_REQQ_INT_INSTR_PSN)
> > +
> > +#define DPI_PF_RAS_EBI_DAT_PSN	BIT_ULL(0)
> > +#define DPI_PF_RAS_NCB_DAT_PSN	BIT_ULL(1)
> > +#define DPI_PF_RAS_NCB_CMD_PSN	BIT_ULL(2)
> > +
> > +#define DPI_PF_RAS_INT \
> > +	(DPI_PF_RAS_EBI_DAT_PSN  | \
> > +	 DPI_PF_RAS_NCB_DAT_PSN  | \
> > +	 DPI_PF_RAS_NCB_CMD_PSN)
> > +
> > +#define DPI_DMAX_IBUFF_CSIZE(x)	(0x0ULL | ((x) << 11))
> > +#define DPI_DMAX_IDS(x)		(0x18ULL | ((x) << 11))
> > +#define DPI_DMAX_IDS2(x)	(0x20ULL | ((x) << 11))
> > +#define DPI_DMAX_QRST(x)	(0x30ULL | ((x) << 11))
> > +
> > +#define DPI_CTL		0x10010ULL
> > +#define DPI_DMA_CONTROL 0x10018ULL
> > +#define DPI_DMA_ENGX_EN(x) (0x10040ULL | ((x) << 3))
> > +#define DPI_ENGX_BUF(x)	(0x100C0ULL | ((x) << 3))
> > +
> > +#define DPI_EBUS_PORTX_CFG(x) (0x10100ULL | ((x) << 3))
> > +
> > +#define DPI_PF_RAS 0x10308ULL
> > +#define DPI_PF_RAS_ENA_W1C 0x10318ULL
> > +
> > +#define DPI_DMA_CCX_INT(x) (0x11000ULL | ((x) << 3)) #define
> > +DPI_DMA_CCX_INT_ENA_W1C(x) (0x11800ULL | ((x) << 3))
> > +
> > +#define DPI_REQQX_INT(x) (0x12C00ULL | ((x) << 5)) #define
> > +DPI_REQQX_INT_ENA_W1C(x) (0x13800ULL | ((x) << 5))
> > +
> > +#define DPI_MBOX_PF_VF_DATA0(x) (0x16000ULL | ((x) << 4)) #define
> > +DPI_MBOX_PF_VF_DATA1(x) (0x16008ULL | ((x) << 4))
> > +
> > +#define DPI_MBOX_VF_PF_INT 0x16300ULL #define
> DPI_MBOX_VF_PF_INT_W1S
> > +0x16308ULL #define DPI_MBOX_VF_PF_INT_ENA_W1C 0x16310ULL
> #define
> > +DPI_MBOX_VF_PF_INT_ENA_W1S 0x16318ULL
> > +
> > +#define DPI_WCTL_FIF_THR 0x17008ULL
> > +
> > +#define DPI_EBUS_MAX_PORTS 2
> > +
> > +#define DPI_EBUS_MRRS_MIN 128
> > +#define DPI_EBUS_MRRS_MAX 1024
> > +#define DPI_EBUS_MPS_MIN  128
> > +#define DPI_EBUS_MPS_MAX  1024
> > +#define DPI_WCTL_FIFO_THRESHOLD 0x30
> > +
> > +#define DPI_QUEUE_OPEN  0x1
> > +#define DPI_QUEUE_CLOSE 0x2
> > +#define DPI_REG_DUMP    0x3
> > +#define DPI_GET_REG_CFG 0x4
> > +#define DPI_QUEUE_OPEN_V2 0x5
> > +
> > +enum dpi_mbox_rsp_type {
> > +	DPI_MBOX_TYPE_CMD,
> > +	DPI_MBOX_TYPE_RSP_ACK,
> > +	DPI_MBOX_TYPE_RSP_NACK,
> > +};
> > +
> > +struct dpivf_config {
> > +	u16 csize;
> > +	u32 aura;
> > +	u16 sso_pf_func;
> > +	u16 npa_pf_func;
>=20
> Do you intend to have unaligned accesses to the fields in this structure?
>=20
No, I will fix it.

> > +};
> > +
> > +struct dpipf_vf {
> > +	u8 this_vfid;
> > +	bool setup_done;
> > +	struct dpivf_config vf_config;
> > +};
> > +
> > +/* DPI device mailbox */
> > +struct dpi_mbox {
> > +	struct work_struct work;
> > +	/* lock to serialize mbox requests */
> > +	struct mutex lock;
> > +	struct dpipf *pf;
> > +	u8 __iomem *pf_vf_data_reg;
> > +	u8 __iomem *vf_pf_data_reg;
> > +};
> > +
> > +struct dpipf {
> > +	struct miscdevice miscdev;
> > +	void __iomem *reg_base;
> > +	struct pci_dev *pdev;
> > +	struct dpipf_vf vf[DPI_MAX_VFS];
> > +	/* Mailbox to talk to VFs */
> > +	struct dpi_mbox *mbox[DPI_MAX_VFS];
> > +};
> > +
> > +union dpi_mbox_message_t {
>=20
> Didn't checkpatch complain about the "_t" here?
>=20
No, I will double check and fix it.
> > +	u64 u[2];
>=20
> What is "u"?
>=20
> > +	struct dpi_mbox_message_s {
> > +		/* VF ID to configure */
> > +		u64 vfid           :8;
> > +		/* Command code */
> > +		u64 cmd            :4;
> > +		/* Command buffer size in 8-byte words */
> > +		u64 csize          :14;
> > +		/* Aura of the command buffer */
> > +		u64 aura           :20;
> > +		/* SSO PF function */
> > +		u64 sso_pf_func    :16;
> > +		/* NPA PF function */
> > +		u64 npa_pf_func    :16;
> > +		/* Work queue completion status enable */
> > +		u64 wqecs	:1;
> > +		/* Work queue completion status byte offset */
> > +		u64 wqecsoff	:7;
> > +		/* Reserved */
> > +		u64 rsvd	:42;
>=20
> reserved for what?
>=20
> If you are reading this from hardware, the bit fields you created here wi=
ll
> NOT work or be portable at all.  Please do this properly.

Sure, I will fix it properly.
>=20
> Also you have a mix of tabs and spaces for some reason in this structure,
> again, checkpatch should have caught that.
>=20
> > +	} s __packed;
>=20
> "s"?
>=20
> What is "u" and "s" here?
>=20
>=20
> > +};
> > +
> > +static inline void dpi_reg_write(struct dpipf *dpi, u64 offset, u64
> > +val) {
> > +	writeq(val, dpi->reg_base + offset);
>=20
> No need to read to ensure that the write succeeded?  Or are you doing tha=
t
> in individual places where you want to make sure it happened?  If so, I d=
idn't
> see that in the use of this.

Yes, writes are guaranteed as it's an onboard pcie device and register writ=
es
are uncached memory accesses. =20
>=20
> > +}
> > +
> > +static inline u64 dpi_reg_read(struct dpipf *dpi, u64 offset) {
> > +	return readq(dpi->reg_base + offset); }
> > +
> > +static void dpi_wqe_cs_offset(struct dpipf *dpi, u8 offset) {
> > +	u64 reg;
> > +
> > +	reg =3D dpi_reg_read(dpi, DPI_DMA_CONTROL);
> > +	reg &=3D ~DPI_DMA_CONTROL_WQECSDIS;
> > +	reg |=3D DPI_DMA_CONTROL_ZBWCSEN |
> DPI_DMA_CONTROL_WQECSMODE1;
> > +	reg |=3D DPI_DMA_CONTROL_WQECSOFF(offset);
> > +	dpi_reg_write(dpi, DPI_DMA_CONTROL, reg); }
> > +
> > +static int dpi_queue_init(struct dpipf *dpi, struct dpipf_vf *dpivf,
> > +u8 vf) {
> > +	u16 sso_pf_func =3D dpivf->vf_config.sso_pf_func;
> > +	u16 npa_pf_func =3D dpivf->vf_config.npa_pf_func;
> > +	u16 csize =3D dpivf->vf_config.csize;
> > +	u32 aura =3D dpivf->vf_config.aura;
> > +	unsigned long timeout;
> > +	u64 reg;
> > +
> > +	dpi_reg_write(dpi, DPI_DMAX_QRST(vf), DPI_DMA_QRST);
> > +
> > +	/* Wait for a maximum of 3 sec */
> > +	timeout =3D jiffies + msecs_to_jiffies(3000);
> > +	while (!time_after(jiffies, timeout)) {
> > +		reg =3D dpi_reg_read(dpi, DPI_DMAX_QRST(vf));
> > +		if (!(reg & DPI_DMA_QRST))
> > +			break;
> > +
> > +		usleep_range(500, 1000);
>=20
> Why sleep this value?  Please document.

ack
>=20
> > +	}
> > +
> > +	if (reg & DPI_DMA_QRST) {
> > +		dev_err(&dpi->pdev->dev, "Queue reset failed\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	dpi_reg_write(dpi, DPI_DMAX_IDS2(vf), 0);
> > +	dpi_reg_write(dpi, DPI_DMAX_IDS(vf), 0);
> > +
> > +	reg =3D DPI_DMA_IBUFF_CSIZE_CSIZE(csize) |
> DPI_DMA_IBUFF_CSIZE_NPA_FREE;
> > +	dpi_reg_write(dpi, DPI_DMAX_IBUFF_CSIZE(vf), reg);
> > +
> > +	reg =3D dpi_reg_read(dpi, DPI_DMAX_IDS2(vf));
> > +	reg |=3D DPI_DMA_IDS2_INST_AURA(aura);
> > +	dpi_reg_write(dpi, DPI_DMAX_IDS2(vf), reg);
> > +
> > +	reg =3D dpi_reg_read(dpi, DPI_DMAX_IDS(vf));
> > +	reg |=3D DPI_DMA_IDS_DMA_NPA_PF_FUNC(npa_pf_func);
> > +	reg |=3D DPI_DMA_IDS_DMA_SSO_PF_FUNC(sso_pf_func);
> > +	reg |=3D DPI_DMA_IDS_DMA_STRM(vf + 1);
> > +	reg |=3D DPI_DMA_IDS_INST_STRM(vf + 1);
> > +	dpi_reg_write(dpi, DPI_DMAX_IDS(vf), reg);
> > +
> > +	return 0;
> > +}
> > +
> > +static void dpi_queue_fini(struct dpipf *dpi, struct dpipf_vf *dpivf,
> > +u8 vf) {
> > +	dpi_reg_write(dpi, DPI_DMAX_QRST(vf), DPI_DMA_QRST);
> > +
> > +	/* Reset IDS and IDS2 registers */
> > +	dpi_reg_write(dpi, DPI_DMAX_IDS2(vf), 0);
> > +	dpi_reg_write(dpi, DPI_DMAX_IDS(vf), 0); }
> > +
> > +static void dpi_poll_pfvf_mbox(struct dpipf *dpi) {
> > +	u64 reg;
> > +	u32 vf;
> > +
> > +	reg =3D dpi_reg_read(dpi, DPI_MBOX_VF_PF_INT);
> > +	if (reg) {
> > +		for (vf =3D 0; vf < pci_num_vf(dpi->pdev); vf++) {
> > +			if (reg & BIT_ULL(vf))
> > +				schedule_work(&dpi->mbox[vf]->work);
> > +		}
> > +		dpi_reg_write(dpi, DPI_MBOX_VF_PF_INT, reg);
> > +	}
>=20
> No error if reg was not read properly?
Yes, ideally no errors as it's an on board pcie device.
>=20
> > +}
> > +
> > +static irqreturn_t dpi_mbox_intr_handler(int irq, void *data) {
> > +	struct dpipf *dpi =3D data;
> > +
> > +	dpi_poll_pfvf_mbox(dpi);
> > +
> > +	return IRQ_HANDLED;
>=20
> So this can always succeed?
Yes. It's msix interrupt and not shared, I will check and fix if any thing
need to be validated.

>=20
> > +}
> > +
> > +static int queue_config(struct dpipf *dpi, struct dpipf_vf *dpivf,
> > +union dpi_mbox_message_t *msg) {
> > +	int ret =3D 0;
> > +
> > +	switch (msg->s.cmd) {
> > +	case DPI_QUEUE_OPEN:
> > +	case DPI_QUEUE_OPEN_V2:
> > +		dpivf->vf_config.aura =3D msg->s.aura;
> > +		dpivf->vf_config.csize =3D msg->s.cmd =3D=3D DPI_QUEUE_OPEN ?
> msg->s.csize / 8 :
> > +					 msg->s.csize;
> > +		dpivf->vf_config.sso_pf_func =3D msg->s.sso_pf_func;
> > +		dpivf->vf_config.npa_pf_func =3D msg->s.npa_pf_func;
> > +		ret =3D dpi_queue_init(dpi, dpivf, msg->s.vfid);
> > +		if (!ret) {
> > +			if (msg->s.wqecs)
> > +				dpi_wqe_cs_offset(dpi, msg->s.wqecsoff);
> > +			dpivf->setup_done =3D true;
> > +		}
> > +		break;
> > +	case DPI_QUEUE_CLOSE:
> > +		dpivf->vf_config.aura =3D 0;
> > +		dpivf->vf_config.csize =3D 0;
> > +		dpivf->vf_config.sso_pf_func =3D 0;
> > +		dpivf->vf_config.npa_pf_func =3D 0;
> > +		dpi_queue_fini(dpi, dpivf, msg->s.vfid);
> > +		dpivf->setup_done =3D false;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static void dpi_pfvf_mbox_work(struct work_struct *work) {
> > +	struct dpi_mbox *mbox =3D container_of(work, struct dpi_mbox,
> work);
> > +	union dpi_mbox_message_t msg =3D { 0 };
>=20
> Are you sure this can be on the stack?

No, it's not guaranteed, will use memset. Thanks.
>=20
> > +	struct dpipf_vf *dpivf;
> > +	struct dpipf *dpi;
> > +	int ret;
> > +
> > +	dpi =3D mbox->pf;
> > +
> > +	mutex_lock(&mbox->lock);
> > +	msg.u[0] =3D readq(mbox->vf_pf_data_reg);
> > +	if (unlikely(msg.u[0] =3D=3D (u64)-1))
> > +		goto exit;
>=20
> Only use likely/unlikely if you can prove with a benchmark that it makes =
a
> difference.  Otherwise let the CPU and compiler choose for you, as it kno=
ws
> better than you do (and will know better over time.)

Ack.
>=20
> If you want to use unlikely, you have to document it as to how it matters=
.
>=20
> > +
> > +	if (unlikely(msg.s.vfid >=3D pci_num_vf(dpi->pdev))) {
> > +		dev_err(&dpi->pdev->dev, "Invalid vfid:%d\n", msg.s.vfid);
>=20
> You send this to the kernel log if a device is broken?

Ok, ideally, it's not case, will remove log.

>=20
> > +		goto exit;
> > +	}
> > +
> > +	dpivf =3D &dpi->vf[msg.s.vfid];
> > +	msg.u[1] =3D readq(mbox->pf_vf_data_reg);
> > +
> > +	ret =3D queue_config(dpi, dpivf, &msg);
> > +	if (ret < 0)
> > +		writeq(DPI_MBOX_TYPE_RSP_NACK, mbox-
> >pf_vf_data_reg);
> > +	else
> > +		writeq(DPI_MBOX_TYPE_RSP_ACK, mbox->pf_vf_data_reg);
> > +exit:
> > +	mutex_unlock(&mbox->lock);
> > +}
> > +
> > +/* Setup registers for a PF mailbox */ static void
> > +dpi_setup_mbox_regs(struct dpipf *dpi, int vf) {
> > +	struct dpi_mbox *mbox =3D dpi->mbox[vf];
> > +
> > +	mbox->pf_vf_data_reg =3D dpi->reg_base +
> DPI_MBOX_PF_VF_DATA0(vf);
> > +	mbox->vf_pf_data_reg =3D dpi->reg_base +
> DPI_MBOX_PF_VF_DATA1(vf); }
> > +
> > +static int dpi_pfvf_mbox_setup(struct dpipf *dpi) {
> > +	int vf;
> > +
> > +	for (vf =3D 0; vf < DPI_MAX_VFS; vf++) {
> > +		dpi->mbox[vf] =3D devm_kzalloc(&dpi->pdev->dev,
> > +sizeof(*dpi->mbox[vf]), GFP_KERNEL);
> > +
> > +		if (!dpi->mbox[vf])
> > +			return -ENOMEM;
> > +
> > +		mutex_init(&dpi->mbox[vf]->lock);
> > +		INIT_WORK(&dpi->mbox[vf]->work, dpi_pfvf_mbox_work);
> > +		dpi->mbox[vf]->pf =3D dpi;
> > +		dpi_setup_mbox_regs(dpi, vf);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void dpi_pfvf_mbox_destroy(struct dpipf *dpi) {
> > +	unsigned int vf;
> > +
> > +	for (vf =3D 0; vf < DPI_MAX_VFS; vf++) {
> > +		if (work_pending(&dpi->mbox[vf]->work))
> > +			cancel_work_sync(&dpi->mbox[vf]->work);
> > +
> > +		dpi->mbox[vf] =3D NULL;
> > +	}
> > +}
> > +
> > +static void dpi_init(struct dpipf *dpi) {
> > +	unsigned int engine, port;
> > +	u8 mrrs_val, mps_val;
> > +	u64 reg;
> > +
> > +	for (engine =3D 0; engine < DPI_MAX_ENGINES; engine++) {
> > +		if (engine =3D=3D 4 || engine =3D=3D 5)
> > +			reg =3D DPI_ENG_BUF_BLKS(16);
> > +		else
> > +			reg =3D DPI_ENG_BUF_BLKS(8);
> > +
> > +		dpi_reg_write(dpi, DPI_ENGX_BUF(engine), reg);
> > +	}
> > +
> > +	reg =3D DPI_DMA_CONTROL_ZBWCSEN |
> DPI_DMA_CONTROL_PKT_EN | DPI_DMA_CONTROL_LDWB |
> > +	      DPI_DMA_CONTROL_O_MODE |
> DPI_DMA_CONTROL_DMA_ENB;
> > +
> > +	dpi_reg_write(dpi, DPI_DMA_CONTROL, reg);
> > +	dpi_reg_write(dpi, DPI_CTL, DPI_CTL_EN);
> > +
> > +	mrrs_val =3D 2; /* 512B */
> > +	mps_val =3D 1; /* 256B */
> > +
> > +	for (port =3D 0; port < DPI_EBUS_MAX_PORTS; port++) {
> > +		reg =3D dpi_reg_read(dpi, DPI_EBUS_PORTX_CFG(port));
> > +		reg &=3D ~(DPI_EBUS_PORTX_CFG_MRRS(7) |
> DPI_EBUS_PORTX_CFG_MPS(7));
> > +		reg |=3D DPI_EBUS_PORTX_CFG_MPS(mps_val) |
> DPI_EBUS_PORTX_CFG_MRRS(mrrs_val);
> > +		dpi_reg_write(dpi, DPI_EBUS_PORTX_CFG(port), reg);
> > +	}
> > +
> > +	dpi_reg_write(dpi, DPI_WCTL_FIF_THR,
> DPI_WCTL_FIFO_THRESHOLD); }
> > +
> > +static void dpi_fini(struct dpipf *dpi) {
> > +	unsigned int engine;
> > +
> > +	for (engine =3D 0; engine < DPI_MAX_ENGINES; engine++)
> > +		dpi_reg_write(dpi, DPI_ENGX_BUF(engine), 0);
> > +
> > +	dpi_reg_write(dpi, DPI_DMA_CONTROL, 0);
> > +	dpi_reg_write(dpi, DPI_CTL, 0);
> > +}
> > +
> > +static void dpi_free_irq_vectors(void *pdev) {
> > +	pci_free_irq_vectors((struct pci_dev *)pdev); }
> > +
> > +static int dpi_irq_init(struct dpipf *dpi) {
> > +	struct pci_dev *pdev =3D dpi->pdev;
> > +	struct device *dev =3D &pdev->dev;
> > +	int i, ret;
> > +
> > +	/* Clear all RAS interrupts */
> > +	dpi_reg_write(dpi, DPI_PF_RAS, DPI_PF_RAS_INT);
> > +
> > +	/* Clear all RAS interrupt enable bits */
> > +	dpi_reg_write(dpi, DPI_PF_RAS_ENA_W1C, DPI_PF_RAS_INT);
> > +
> > +	for (i =3D 0; i < DPI_MAX_REQQ_INT; i++) {
> > +		dpi_reg_write(dpi, DPI_REQQX_INT(i), DPI_REQQ_INT);
> > +		dpi_reg_write(dpi, DPI_REQQX_INT_ENA_W1C(i),
> DPI_REQQ_INT);
> > +	}
> > +
> > +	for (i =3D 0; i < DPI_MAX_CC_INT; i++) {
> > +		dpi_reg_write(dpi, DPI_DMA_CCX_INT(i),
> DPI_DMA_CC_INT);
> > +		dpi_reg_write(dpi, DPI_DMA_CCX_INT_ENA_W1C(i),
> DPI_DMA_CC_INT);
> > +	}
> > +
> > +	ret =3D pci_alloc_irq_vectors(pdev, DPI_MAX_IRQS, DPI_MAX_IRQS,
> PCI_IRQ_MSIX);
> > +	if (ret !=3D DPI_MAX_IRQS) {
> > +		dev_err(dev, "DPI: Failed to alloc %d msix irqs\n",
> DPI_MAX_IRQS);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D devm_add_action_or_reset(dev, dpi_free_irq_vectors, pdev);
> > +	if (ret) {
> > +		dev_err(dev, "DPI: Failed to add irq free action\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D devm_request_irq(dev, pci_irq_vector(pdev,
> DPI_MBOX_PF_VF_INT_IDX),
> > +			       dpi_mbox_intr_handler, 0, "dpi-mbox", dpi);
> > +	if (ret) {
> > +		dev_err(dev, "DPI: request_irq failed for mbox; err=3D%d\n",
> ret);
> > +		return ret;
> > +	}
> > +
> > +	dpi_reg_write(dpi, DPI_MBOX_VF_PF_INT_ENA_W1S,
> GENMASK_ULL(31, 0));
> > +
> > +	return 0;
> > +}
> > +
> > +static int dpi_mps_mrrs_config(struct dpipf *dpi, void __user *arg) {
> > +	struct dpi_mps_mrrs_cfg cfg;
> > +	u8 mrrs_val, mps_val;
> > +	u64 reg;
> > +
> > +	if (copy_from_user(&cfg, arg, sizeof(struct dpi_mps_mrrs_cfg)))
> > +		return -EFAULT;
> > +
> > +	if (cfg.max_read_req_sz < DPI_EBUS_MRRS_MIN ||
> cfg.max_read_req_sz > DPI_EBUS_MRRS_MAX ||
> > +	    !is_power_of_2(cfg.max_read_req_sz)) {
> > +		dev_err(&dpi->pdev->dev, "Invalid MRRS size:%u\n",
> > +cfg.max_read_req_sz);
>=20
> You are allowing userspace to spam the kernel log with messages by sendin=
g
> the driver invalid data.  THat is a denial of service, please never do th=
at.

Sure, will fix it.
>=20
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (cfg.max_payload_sz < DPI_EBUS_MPS_MIN ||
> cfg.max_payload_sz > DPI_EBUS_MPS_MAX ||
> > +	    !is_power_of_2(cfg.max_payload_sz)) {
> > +		dev_err(&dpi->pdev->dev, "Invalid MPS size:%u\n",
> cfg.max_payload_sz);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (cfg.port >=3D DPI_EBUS_MAX_PORTS) {
> > +		dev_err(&dpi->pdev->dev, "Invalid EBUS port:%u\n",
> cfg.port);
> > +		return -EINVAL;
> > +	}
> > +
> > +	mrrs_val =3D fls(cfg.max_read_req_sz >> 8);
> > +	mps_val =3D fls(cfg.max_payload_sz >> 8);
> > +
> > +	reg =3D dpi_reg_read(dpi, DPI_EBUS_PORTX_CFG(cfg.port));
> > +	reg &=3D ~(DPI_EBUS_PORTX_CFG_MRRS(0x7) |
> DPI_EBUS_PORTX_CFG_MPS(0x7));
> > +	reg |=3D DPI_EBUS_PORTX_CFG_MPS(mps_val) |
> DPI_EBUS_PORTX_CFG_MRRS(mrrs_val);
> > +	dpi_reg_write(dpi, DPI_EBUS_PORTX_CFG(cfg.port), reg);
> > +
> > +	return 0;
> > +}
> > +
> > +static int dpi_engine_config(struct dpipf *dpi, void __user *arg) {
> > +	struct dpi_engine_cfg cfg;
> > +	unsigned int engine;
> > +	u8 *eng_buf;
> > +	u64 reg;
> > +
> > +	if (copy_from_user(&cfg, arg, sizeof(struct dpi_engine_cfg)))
> > +		return -EFAULT;
>=20
> No need to ever validate any information in that structure from userspace=
?
> You always blindly copy it on to the device?  Userspace can never get thi=
s
> wrong?
>=20
Yes, couple of range checks are needed, will address in next patch.
> > +
> > +	eng_buf =3D (u8 *)&cfg.fifo_mask;
> > +
> > +	for (engine =3D 0; engine < DPI_MAX_ENGINES; engine++) {
> > +		reg =3D DPI_ENG_BUF_BLKS(eng_buf[engine &
> DPI_ENGINE_MASK]);
> > +		dpi_reg_write(dpi, DPI_ENGX_BUF(engine), reg);
> > +
> > +		if (cfg.update_molr) {
> > +			reg =3D DPI_DMA_ENG_EN_MOLR(cfg.molr[engine &
> DPI_ENGINE_MASK]);
> > +			dpi_reg_write(dpi, DPI_DMA_ENGX_EN(engine),
> reg);
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static long dpi_dev_ioctl(struct file *fptr, unsigned int cmd,
> > +unsigned long data) {
> > +	void __user *arg =3D (void __user *)data;
> > +	struct dpipf *dpi;
> > +	int ret =3D -EINVAL;
>=20
> Wrong error code for an invalid ioctl command :(
ack
>=20
> > +
> > +	dpi =3D container_of(fptr->private_data, struct dpipf, miscdev);
> > +
> > +	switch (cmd) {
> > +	case DPI_MPS_MRRS_CFG:
> > +		ret =3D dpi_mps_mrrs_config(dpi, arg);
> > +		break;
> > +	case DPI_ENGINE_CFG:
> > +		ret =3D dpi_engine_config(dpi, arg);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct file_operations dpi_device_fops =3D {
> > +	.owner =3D THIS_MODULE,
> > +	.unlocked_ioctl =3D dpi_dev_ioctl,
> > +	.compat_ioctl =3D compat_ptr_ioctl,
> > +};
> > +
> > +static int dpi_probe(struct pci_dev *pdev, const struct pci_device_id
> > +*id) {
> > +	struct device *dev =3D &pdev->dev;
> > +	struct dpipf *dpi;
> > +	int ret;
> > +
> > +	dpi =3D devm_kzalloc(dev, sizeof(*dpi), GFP_KERNEL);
> > +	if (!dpi)
> > +		return -ENOMEM;
> > +
> > +	dpi->pdev =3D pdev;
> > +
> > +	ret =3D pcim_enable_device(pdev);
> > +	if (ret) {
> > +		dev_err(dev, "DPI: Failed to enable PCI device\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D pcim_iomap_regions(pdev, BIT(0) | BIT(4), DPI_DRV_NAME);
> > +	if (ret) {
> > +		dev_err(dev, "DPI: Failed to request MMIO region\n");
> > +		return ret;
> > +	}
> > +
> > +	dpi->reg_base =3D pcim_iomap_table(pdev)[PCI_DPI_CFG_BAR];
> > +
> > +	/* Initialize global PF registers */
> > +	dpi_init(dpi);
> > +
> > +	/* Setup PF-VF mailbox */
> > +	ret =3D dpi_pfvf_mbox_setup(dpi);
> > +	if (ret) {
> > +		dev_err(dev, "DPI: Failed to setup pf-vf mbox\n");
> > +		goto err_dpi_fini;
> > +	}
> > +
> > +	/* Register interrupts */
> > +	ret =3D dpi_irq_init(dpi);
> > +	if (ret) {
> > +		dev_err(dev, "DPI: Failed to initialize irq vectors\n");
> > +		goto err_dpi_mbox_free;
> > +	}
> > +
> > +	pci_set_drvdata(pdev, dpi);
> > +	dpi->miscdev.minor =3D MISC_DYNAMIC_MINOR;
> > +	dpi->miscdev.name =3D DPI_DRV_NAME;
> > +	dpi->miscdev.fops =3D &dpi_device_fops;
> > +	dpi->miscdev.parent =3D dev;
> > +
> > +	ret =3D misc_register(&dpi->miscdev);
> > +	if (ret) {
> > +		dev_err(dev, "DPI: Failed to register misc device\n");
> > +		goto err_dpi_mbox_free;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_dpi_mbox_free:
> > +	dpi_pfvf_mbox_destroy(dpi);
> > +err_dpi_fini:
> > +	dpi_fini(dpi);
> > +	return ret;
> > +}
> > +
> > +static void dpi_remove(struct pci_dev *pdev) {
> > +	struct dpipf *dpi =3D pci_get_drvdata(pdev);
> > +
> > +	misc_deregister(&dpi->miscdev);
> > +	pci_sriov_configure_simple(pdev, 0);
> > +	dpi_pfvf_mbox_destroy(dpi);
> > +	dpi_fini(dpi);
> > +	pci_set_drvdata(pdev, NULL);
> > +}
> > +
> > +static const struct pci_device_id dpi_id_table[] =3D {
> > +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM,
> PCI_DEVID_MRVL_CN10K_DPI_PF,
> > +			 PCI_VENDOR_ID_CAVIUM,
> PCI_SUBDEVID_MRVL_CN10K_DPI_PF) },
> > +	{ 0, }  /* end of table */
> > +};
> > +
> > +static struct pci_driver dpi_driver =3D {
> > +	.name =3D DPI_DRV_NAME,
> > +	.id_table =3D dpi_id_table,
> > +	.probe =3D dpi_probe,
> > +	.remove =3D dpi_remove,
> > +	.sriov_configure =3D pci_sriov_configure_simple, };
> > +
> > +module_pci_driver(dpi_driver);
> > +MODULE_DEVICE_TABLE(pci, dpi_id_table);
> MODULE_AUTHOR("Marvell.");
> > +MODULE_DESCRIPTION("Marvell Octeon CN10K DPI Driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/uapi/misc/mrvl_cn10k_dpi.h
> > b/include/uapi/misc/mrvl_cn10k_dpi.h
> > new file mode 100644
> > index 000000000000..a1951644448a
> > --- /dev/null
> > +++ b/include/uapi/misc/mrvl_cn10k_dpi.h
> > @@ -0,0 +1,37 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
>=20
> Why is this file "GPL-2.0+" but your driver is "GPL-2.0"?  Is that what y=
our
> lawyers want to have happen (sorry, I have to ask.)

No specific reason, I think I need to use " GPL-2.0-or-later" instead of
"GPL-2.0+", will fix it.

Thanks=20
Vamsi

>=20
> thanks,
>=20
> greg k-h

