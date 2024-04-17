Return-Path: <linux-kernel+bounces-149050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDBA8A8B09
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D501F24A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9DB17335B;
	Wed, 17 Apr 2024 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="Gc+oCoIq";
	dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="hSVDydbW"
Received: from mx0a-0068d901.pphosted.com (mx0a-0068d901.pphosted.com [205.220.168.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B0012F398;
	Wed, 17 Apr 2024 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713378422; cv=fail; b=Wh22l4eK4q3hD1HVMz6XVUCjg3sv6HNgSNlyNSo0e12V8hqvToYOcUzyKt+lDYb1K85GPx1h2B83uhn3I81VNowpacz+vqORUrISbj9crrnhp/QP0Vj/V1AdJT5XuOGY6jLREQ4Nnr12pJANZrbt1oJVQIkVHbhzAYhWzllbPFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713378422; c=relaxed/simple;
	bh=qGsHNjJWliMvnBc7ggSHRkOusRrQqqUNXlZdN7a1KJY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Sqm0SBQwgri3lQO6a20hJv5s5s5ATeti7ZOoRq3sx4Q3G3w4VTiRyqt4wY2MHQtPtEJUjrSJHk58S/9HEoLmsfRxQ5syi/QFPZ9NK02sdrW8mfvNJFUrM9l8bvyn3cIqnKEqcQOGhJzMd45G4qnsFUi2624hce5f5pkmMb2WU6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com; spf=pass smtp.mailfrom=biamp.com; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=Gc+oCoIq; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=hSVDydbW; arc=fail smtp.client-ip=205.220.168.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=biamp.com
Received: from pps.filterd (m0278264.ppops.net [127.0.0.1])
	by mx0b-0068d901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43HAkoki004700;
	Wed, 17 Apr 2024 11:27:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=proofpoint; bh=pKDzgW
	6qaj33fE2wFMFcZ14ZX7Sbw0aIN98qfRmnjJQ=; b=Gc+oCoIq9m3x9OTwazmv5z
	sN4aL33YoPjMcPC67j2Ma5rJvXJdPYFgz9r+1qNU72saBEu9HH1Ynm4pwJkeORSH
	CwtaywBqhpUQrKeZk2310EOb1Z+YtY+c9j1HhdIv1Z9zWMvRdvsd9k2omFPicqME
	ZK2G5EggFl47xGT2iSQuQbfnCKc7/b5oG4x3WgKsf48FqR3YhcWw3lqtb0H/a/wf
	GEBjZhqxgdoVTURU+BV9r77+Ph2MWnwd0ns0bIzsQ5WpWuk0hwp7FlN0Q3z792l9
	YL2gMa5dvE+OJZc8vVWYiL7xbsaO2SBiVx7Ao9C4r6XE9KpvJSiQOkvXORYUBL2g
	==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by mx0b-0068d901.pphosted.com (PPS) with ESMTPS id 3xg09r2pxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 11:27:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAyXig/J3vQYKcTk5ZcEP2u+2hu16ypKCLwYOGSm5grV2JhryNfMTSQIofSKGfKJXMM8BKb4jrIlSQV11gghfrxWk//GoJpGD6VjIQrqB+VXrR/hT2gz26MrNsu7jkpKPkupF6FW4hsCikhCyZViJjctdeLrjSnHyPeh2qERWuRgX8rYe3B9WgCh0i/v7jbIDc9Fw68uIPaJL+B1srgQNG+4j9KpIZ44uH6YrKyGOnqY4m7NQjnePLjwR7OtEfgHE7qri2kSK4GKjUewahqZq2z4L6I8FrlRi4m0P9wrw1lEonQ3uH7JAc1so1Jc3dxAwfEsjVt7/3psLJkvWnQ+Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKDzgW6qaj33fE2wFMFcZ14ZX7Sbw0aIN98qfRmnjJQ=;
 b=kEs7Ard38cyPTowhwhjhalkL5lHgZr/f8AbRcnBAU5nVY+Bp7E+AC7tYwf/RQg8lN7ECySN+RJ6ekqhmUa0s+ViiXweGSwn2I9afqo/oirAWGx102doyF+JnIVw0/w+HUSGUsTflvPoZr3CtUJkE4hvz894MIDHFr+gXVmSOTY2vdyNC8z81fhOwgy6xlxbRbr42r9CNAyxqW9jn9aK/41D0GxEkOxX4TsxPLbB1ADZw7uJ3WLlRYn4tAVPfMaIfdmvjYy0kjr4mS2wxaCIl7He2OVGwOdPJhJkQICBzTR0TyhakqyF9p04PFoEXSwqrc9XyDaM0Eorm0EuwODEf+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKDzgW6qaj33fE2wFMFcZ14ZX7Sbw0aIN98qfRmnjJQ=;
 b=hSVDydbWwjo3NTJ9XphPGZDrsFHTYzJOqh/DmdyDBR/vpdvzizAYeu67tbV0CvyMUi162P5RXHgdKqQtlOGZyJRyEdzBKAu6mXfzE0i2ut7ltxTAHbGKVODm8rI0ZN1kkZ6ppCp+xvXyQJR8ac7T2Mc0rkpWSLX7dO48iQ2pN+x147pzcNdrZVXzFCtya4Se2BtMhpqDAQqOdq6yfkaq+R8MulXT64ZH3RTmffihYalJmHip5ozyhLtAa932yDCVp50qNgUM5WYfAe5tvPaWDYCwWkfIDLY7AN2BkrF/E+UfonVgY6GS2OJ35/UNehhzs3+TKy7bB4oVJ2NcP4QHTQ==
Received: from CO1PR17MB5419.namprd17.prod.outlook.com (2603:10b6:303:ec::17)
 by SA1PR17MB6425.namprd17.prod.outlook.com (2603:10b6:806:335::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 18:26:52 +0000
Received: from CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555]) by CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555%4]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 18:26:52 +0000
From: Chris Wulff <Chris.Wulff@biamp.com>
To: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Sands
	<David.Sands@biamp.com>
Subject: [PATCH v2 0/1] USB: gadget: f_hid: Add GET_REPORT via userspace IOCTL
Thread-Topic: [PATCH v2 0/1] USB: gadget: f_hid: Add GET_REPORT via userspace
 IOCTL
Thread-Index: AQHakPR++ve0oK7msES/uXpyLvI1+g==
Date: Wed, 17 Apr 2024 18:26:52 +0000
Message-ID: 
 <CO1PR17MB5419D609FAC3234E360A035CE10F2@CO1PR17MB5419.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR17MB5419:EE_|SA1PR17MB6425:EE_
x-ms-office365-filtering-correlation-id: 64e69dbd-53f4-46e6-1548-08dc5f0bf418
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 yfS90ob0mPl4EdP5IioRsSeb8Vz1kQamfnY4I460iP0brD+sYbaQO9DThvWlUOZEvGCZmYnBIVJks7cFT0GZAS5FbWd/zKerLeMKFImRFhHwtad1xf1x4lfpGIua1xz4du122/EifE/zTSOTIrjTtnptQbr4FLpz0Rm8yC70aO32I9/tZN+nzDUcCNgBXcKb6JlyMQqTEtHNMCjXKgtRg8x219JsomAh7/vpcakboTRAMPe5vtTc+bqV+0vv7h6iJK7VxaNA8sR24avdwMkaHzFQ2vl4Nifegke+sNMljHubXbjCRoOE45vnI0g8Dx07xvikZKtDR9ydwO5a83IJ8swcCCqElGJub1eo0/767yh6itz6ad1TKn6nlatXxY+9FMfyFCS5MY0qdqkn4HPtjJ6KOW86pLoZTpLYpB6bwQVQ6rs+a/eWv55csgoGuuMxyetf9UiYznyvpM9Z8USsnu7ne9DkmKDUUvMIID4PgftfRLLtCS5LogiOxvA9C3giKbAEXmOowq+LL8Iz5C5GJoUP6mY8ZonjseMsXNnwInlAjDWTOEn00yiyTWhaB3ygIKUBgcAE6qF77jU4s+aSCtJU8nTKKOZ3zJCWLWWEI02AzogV1egCBElTmTr9CiLKev1gdjC+7tmvGr1zYoh0AYxpsxM1QWXcBBVwd9ePm3I=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR17MB5419.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?stU8QlT+4LNOuifBJoPi9sqLH6xfnH3WccN3I2bJa8/UIrMlgEXygHOUQv?=
 =?iso-8859-1?Q?OsMhyYkWu6wwetQt68+ontoJ3mwAassUh+7mOXg95JJBwzfhu5gPFGP7/X?=
 =?iso-8859-1?Q?Dj1SgbTnzdIeLceXGILxNR0z67Amqkl39+Ysty4Fv2fKjoL/6oH2dI0Xc8?=
 =?iso-8859-1?Q?NAgjTFa03FLCIckqxfTpYnst+oWMX44t4oeG55Rg+B3XwKGnoSIu0Ra7F/?=
 =?iso-8859-1?Q?IfraYwr55Fd9ap3jzFUqjxfqpaI3JgLGJZW/G67FcOBkKdVFirtZbrrjZ7?=
 =?iso-8859-1?Q?tqrlkH7EzdeQsJSFCbW5zHWZjqH8376ia4wSLh7gAnFNYg+am7kbItBj5y?=
 =?iso-8859-1?Q?dl8ztsVgMn7Ud3NypdMB6GqMzUwPmZ84ars3A6sGYUcOFT8QVf7mK6FZYh?=
 =?iso-8859-1?Q?ji6TnGTPulMTwvkQ1qHmgDIbX2nlj/PWU8Xv+79HgUriCY0SMCwdsPQ98J?=
 =?iso-8859-1?Q?vn6RO91mrrDDst4PnYzuPL+lVqpvwwKXZvfztLyhyqIieJdZeQccX5e0fh?=
 =?iso-8859-1?Q?YaBcoTbggSd4xX8gwMgJsGTEywyUGMfFxYhPcGMz3yEcND/GIAP8boveeB?=
 =?iso-8859-1?Q?TTqfawC4aVdEJQ1lVwPNuAReBXbHTBFzGjJjMaxOevkxK0ThDgBeUZeeUF?=
 =?iso-8859-1?Q?6RaypMPA4VCoZjEIK0wxW6DQHXkoi5i0htnKUkemoTFeBYiaPQBOCffFG4?=
 =?iso-8859-1?Q?IGX0b6W5qmXGYrFPbMIs1QMmgsnTE3JJ7Xec/n8vkWUNyVJ5JA6HE9UgHw?=
 =?iso-8859-1?Q?hkgeLhMg8Am1qCQ1iasH5BbLzJ38X8rZjCmmTweu0Dbo/BkkMEHsa1+iQa?=
 =?iso-8859-1?Q?F83CRoS/ZeuUEpCHVcW0HOzCTZyk/HmUIMUQfkTqtpo+N1h9iV4q6bLjVC?=
 =?iso-8859-1?Q?3UKHvthdWqc7vHeXGuXW7/Q2/vvLm+pvrH7MDhTqDSDVpC8+M8qJ4Gxw9L?=
 =?iso-8859-1?Q?082RU6gsXAoOIgHvfXqE64vCc0AmKbu3Ev7grmTTrcA2UHNW4uQaPSCR6q?=
 =?iso-8859-1?Q?v9amwSk6rwz9Ac7YUHf6mHpadMegS+aqAXQPbebIWwQHPYRY+oCJmGy0Xn?=
 =?iso-8859-1?Q?VVUeD8as/XPFDUFuCsQ5yLjrRwZpZI+SIQ9Xfq1poRIPD51kwwlcWipy+K?=
 =?iso-8859-1?Q?YX5VmQ+lgn0q2yNW/p0NY/L9u8ACJt3tmYssQTVsjyuuGRvrHIfZ0LZnWg?=
 =?iso-8859-1?Q?sAXBb3tv20wOLZc4tfldQ/8NFq+bvJoukmksjdmFK7ogH2l5kjUWlNZd0S?=
 =?iso-8859-1?Q?46TLY2v5ul3ugGTkucsc4J2q3V7hW0LypXrttj9XM+JdfnM4/7TKlwYi2u?=
 =?iso-8859-1?Q?acffbGzA8D2dyuhXOIykN+p/bMtbVvDNVyQ3/YkOieJWa20VIr7unRiDaC?=
 =?iso-8859-1?Q?ep41zJ8UGPbXJfqRIwCptHBQdYm4ruNu8KvKC/QJPKyyqw2BilifVkS9c8?=
 =?iso-8859-1?Q?ZuSjMYorGou1Ta4ygf1CcSG55CJ/AnvIbRV7r8CwJ6QYc8MH8649vjZiPg?=
 =?iso-8859-1?Q?jC7aaJj6Q0tD9OVX8anVlhUxV3wrnUQnXDwgMe86zqeaNamQdyap4TW4vy?=
 =?iso-8859-1?Q?SohVL0qkp3elNDuS5CI1KKFBCwM2mSGIvJNiWi3iSn14Jb930fYWhaTb1r?=
 =?iso-8859-1?Q?uF6q6S3Rfj8Nv1y4GKrZmfbtZiT88fBevs?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR17MB5419.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e69dbd-53f4-46e6-1548-08dc5f0bf418
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 18:26:52.3719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2alhJtEI0gOx7+uGcFhEdRUF0F73iNT0ibj2tUXU3aXq0gwB4WzDEBga0S0BsNzMMTvA9cxTuBwG6A3TB9n0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB6425
X-Proofpoint-ORIG-GUID: DqZ0HdsjjaK4zrKNPEF-WMndTIOC-qgv
X-Proofpoint-GUID: DqZ0HdsjjaK4zrKNPEF-WMndTIOC-qgv

This patch has been cleaned up with suggestions from Greg KH=0A=
(https://lore.kernel.org/lkml/Y+4Wwm1kFTUEED89@kroah.com/T/#r12e1bcf3ec45e1=
9d7e2247f7070faac19e0fb60d)=0A=
=0A=
Additional changes since v1:=0A=
 * Fixes race conditions during gadget unbind=0A=
 * 32/64 bit compatibility fixes (compat ioctl and uapi structure padding)=
=0A=
=0A=
Additional testing has also been done on Zynq UltraScale+ with the DWC3 dri=
ver.=0A=
=0A=
Example userspace code to respond to GET_REPORT=0A=
---=0A=
#include <stdint.h>=0A=
#include <poll.h>=0A=
#include <linux/usb/g_hid.h>=0A=
#include <sys/ioctl.h>=0A=
#include <fcntl.h>=0A=
#include <unistd.h>=0A=
=0A=
void handleGetReport(int hidgfd) {=0A=
  uint8_t reportId =3D 0;=0A=
  int ret =3D ioctl(hidgfd, GADGET_HID_READ_GET_REPORT_ID, &reportId);=0A=
  if (ret >=3D 0 && reportId > 0) {=0A=
    struct usb_hidg_report report =3D {};=0A=
    report.report_id =3D reportId;=0A=
    report.userspace_req =3D 1;=0A=
    report.length =3D 0;=0A=
=0A=
    switch (reportId) {=0A=
      case 0x01: // report 0x01 requested=0A=
        report.length =3D 2;=0A=
        report.data[0] =3D reportId, // Report ID=0A=
        report.data[1] =3D 0x00;     // Report Data=0A=
        break;=0A=
=0A=
      default:=0A=
        // Unknown report (return empty report so the host doesn't have to =
wait for the timeout)=0A=
        break;=0A=
    }=0A=
=0A=
    ioctl(hidgfd, GADGET_HID_WRITE_GET_REPORT, &report);=0A=
  }=0A=
}=0A=
=0A=
int main(int argc, char **argv) {=0A=
=0A=
  int hidgfd =3D open("/dev/hidg0", O_RDWR | O_NONBLOCK);=0A=
  if (hidgfd < 0) {=0A=
    return -1;=0A=
  }=0A=
=0A=
  struct pollfd fdset[1];=0A=
=0A=
  fdset[0].fd =3D hidgfd;=0A=
  fdset[0].events =3D POLLIN | POLLPRI;=0A=
=0A=
  int running =3D 1;=0A=
  while (running) {=0A=
    int rc, fd;=0A=
=0A=
    fdset[0].revents =3D 0;=0A=
=0A=
    rc =3D poll(fdset, 1, 1000); // Wait up to a second=0A=
=0A=
    if (rc > 0) {=0A=
      if (fdset[0].revents & POLLPRI) {=0A=
        // Process Get Report=0A=
        handleGetReport(hidgfd);=0A=
      }=0A=
=0A=
      /* POLLIN can be processed here for output reports */=0A=
    }=0A=
  }=0A=
=0A=
  close(hidgfd);=0A=
=0A=
  return 0;=0A=
}=0A=
=0A=

