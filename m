Return-Path: <linux-kernel+bounces-149031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 880D18A8AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D890281E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AF8173328;
	Wed, 17 Apr 2024 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="IhCoJz6C";
	dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="pvxDPCce"
Received: from mx0a-0068d901.pphosted.com (mx0a-0068d901.pphosted.com [205.220.168.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C06171668;
	Wed, 17 Apr 2024 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713377212; cv=fail; b=ip9RP3/nB/APPZJxvnQ7bNLHkHXydczfbR2l5sgyXcYpBgNVK3rJEVcj+UckLnjnMa5VLavNXgfb1I5zXjVE6MDauIBA5DBwGiboFEp8Z3xV8cFMUSym0XIYo69jIMouHfjKS5zFWIX6Ap2Ug+ZwQHpORRvkzT2QYRTatQQ144I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713377212; c=relaxed/simple;
	bh=C8Gj/utYj99jLnJP3ZSB66ayCSCpMoIb7H25orepKxw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gjPCOFibb6woZ7av280kdEqqeR0P/R0NM7HEv2iYTWoGxfzlMGiUHtdxICdRpaY/qgHWoDd4D0mVo2INTuRCv0hcFGF2Lij6lyI2pUHXYxoIIvyjUUKTbYc9E0fgEtWShIwXistJBYfFi75Lx+3cOQxgpz0F27GTQDslIZY07yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com; spf=pass smtp.mailfrom=biamp.com; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=IhCoJz6C; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=pvxDPCce; arc=fail smtp.client-ip=205.220.168.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=biamp.com
Received: from pps.filterd (m0278264.ppops.net [127.0.0.1])
	by mx0b-0068d901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43H7UIgl005023;
	Wed, 17 Apr 2024 10:55:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=proofpoint; bh=rof4pR
	0qFTSllyD/FUk8mCuUFhS5yuWjyBKO11psF/4=; b=IhCoJz6CELqeCNgckTJuVD
	3LwSkakBRU+VUfbd+fq4gmMZitnu5JpCOXMWN5OblzDLpcsVzDxOdt8cELjQ7Smx
	dUVzjZPlquSFtfIEAxpR2Z5jg0PaBNGhluJqvBViw7u0pf+c3JKWgQU8jgIykPJr
	Q5xftwUxiKOUODrNyG1+fiSizryiaO/RJzdR32S7RXCUaSVGNR5Ci//MnjymBV1V
	FiGuy+3T4vPdL5nr+Xb5ggonrrPLNUHjD+NxbZ0z8wgVEr9ugzbo+78IVMyC3Yk7
	QBp0uCr/WEXxSaU93Ykv1tXgXlkuoZFpF7NPqmxJHPeXAqHYSPkud3gOT+ZL0v/w
	==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0b-0068d901.pphosted.com (PPS) with ESMTPS id 3xg09r2p3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 10:55:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKOyc+o5aon2A2OVVV/lJACMsRWPvzoJU+zP9Dt/dvofcmCrQ930A0jOt9wCO9nYCj451idg0L5gCtgJaYn4tfj2IEfj3yuhfeCXgZnNXerljNKtAAc/vpy8NJLjkYJQRCG5cVB1s6620G6uldt7h92db0c3ItEBL4FJBK7Y3xcs8oQm1eLdhM2fJ/wQo3QOOrpDVKcd18ZTMNAUE/gCsDHMxsWEoXors89aOJRcbd7I0bEwvyyzWo7jJK3jDnMAiz6ywnLZaCFIId9T7wCiTMRqnP43Hf0wWuXgcOj5ZStNTXTf8BtK5uwC1xc/f8nh2tWWcLvnHgCCQAob38DiPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rof4pR0qFTSllyD/FUk8mCuUFhS5yuWjyBKO11psF/4=;
 b=SuOIsYmhwIBvZbabS+x1eXvRRC0uRmXJYoimh0HfLrynF5jY1xSG+e/nR1pXcsMNDC+Kt45yWf19GBD5tankAic0KGaDOGnogDr9VJ2ioqQsmAsh9qg/eDTfWmN9ls9C4vpBeZtHOihhqvdocJYH1CeONTJoPQPeud0VE5IY/YaPSEZH2ow2ZTRY2Nm7mIuMq+avyNV8EZRHP6c72R44NzAeCiE3zW87bJ13VZGUSUlMRaFDHiOvvj04JbIQ5+O5YGOxRZdR/SxBzRZ/eUMA5LoFfvLqvDRuirowuJXSRk1s0fNGupTga+vZtgNtr2S3WNCMDzw6423FQsnYgeCiJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rof4pR0qFTSllyD/FUk8mCuUFhS5yuWjyBKO11psF/4=;
 b=pvxDPCceVkSf2qzj3dLf6HnUk4RiDUVDBC1O4BPfDvBV8OQrSIwxsFN8IBRIMJgZA1pVoPFog8mJ9zAdfYp6WKiQH+amUW5uSHVYtBQ5Ystof16OIz/7NTEnbNWv+8bCA2mSkA25zf0EQkKGw2fw5o94dzxzh1jdUxxQMlQt/z4mvmCr8MnD7gzR75l04G49PwBhvp5ELiz4sJkjoT7dxN9XZx7jBxGDyakEuqQSwwfJIM3uEg59bKy+lozHOZkNPD3wlcyXDWDgBrWUl049LgtziLuOzizUucbktnHy2SI/4L74qw6rzuzoMJSEPaJU1XAxpVsUPx8c5wpp9FJx6g==
Received: from CO1PR17MB5419.namprd17.prod.outlook.com (2603:10b6:303:ec::17)
 by MW4PR17MB4259.namprd17.prod.outlook.com (2603:10b6:303:7b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Wed, 17 Apr
 2024 17:55:41 +0000
Received: from CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555]) by CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555%4]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 17:55:41 +0000
From: Chris Wulff <Chris.Wulff@biamp.com>
To: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Sands
	<David.Sands@biamp.com>
Subject: [PATCH v2] USB: gadget: f_hid: Add GET_REPORT via userspace IOCTL
Thread-Topic: [PATCH v2] USB: gadget: f_hid: Add GET_REPORT via userspace
 IOCTL
Thread-Index: AQHakOr8siOKtzFuzku/dOQ975u9dg==
Date: Wed, 17 Apr 2024 17:55:41 +0000
Message-ID: 
 <CO1PR17MB541908AD41E1CC04D0016AB9E10F2@CO1PR17MB5419.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR17MB5419:EE_|MW4PR17MB4259:EE_
x-ms-office365-filtering-correlation-id: ffd7e837-4607-458a-97b2-08dc5f0798be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 4VbmT5vx/218zBQneR24gL2gSd2TayTsWmL/x2L3TmCkSJs9BN20sSlgemkcagjwd6Fc1mteAbgufzJZWyyRwdMmfugLzApMHFnHSItWOFgmWfMcLpdHzPNM4wGRDGdqutbIjQOr+iEkimFx7Rm453Rkw/onCGNuuBEcbbGOGp0H+5J2O4OJGEHQOZnI/qmcsMjg6px6KJfSHC+voCKNYuV8pCfEa7ap/Ks6I9cz9E625PL8DIAbKw9jGuiNDn1cYw9taIppYXJYQK8PQpUGpvUEw+d8uYyT3/+mhbvSPWisp3aHcuFeGjxKcizT/yLB3GiKWm/c04B9S01rOWlGMcRjpBspDRDXEd7G8OgHK42Woteb6ICHKBvIuwzZgPqpm6hWC1zwe0gwj42S+jNdlIe09xuJuV2vso15kdgVTvWRYrHYnamU3mqotolH2mjq6c+GiVGaIu9zw4vTz9hOr3cXK6AXDBDOGQg6YeQdAvfmZZsZL+LBAEneUYoevSSsEYDxMAnDBdF4VAv480W9gmsv4hC8+ZP5tjWvTz/FvAsiescYsl5NXsHZ3887h5GjYASNRqbNV3CFjKO8aCSV3u1zNO6vDvpov3rtbKEAPOLOjlJYsRZMhrJcFTZkWX7BmQjenH49GH/D2yxRYe4aCYt8ZWdw6tKMdIBoe/RMVRk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR17MB5419.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?ClexJvz/ghyF0Z05JJB6AjYqqJeE7M95GfFxI+N8Pt/OhVlNLiMyUtBSkK?=
 =?iso-8859-1?Q?QEpwJSo7nx37+Nqqn1aYq4GP97Th0uqXcQDImqQDy2OXy0z4x6s9kPx+Yw?=
 =?iso-8859-1?Q?fcxwtqDjoYWrR/ZXzfU66KFK9yDfGBY782SD0BYkHg+qjVij5x1Q0RHw1y?=
 =?iso-8859-1?Q?RkISDP0pYIiRSKQY38STxklKBV/g3uEUja8jLjTZemTuZMVDpJSePWEM+V?=
 =?iso-8859-1?Q?FOdwSHx9PPDhl12o5RijZVQ2gmLOB3ABLghlBQJAxnP3NXFwTWMRw4tihE?=
 =?iso-8859-1?Q?WV0FRtEErQSwngC1hpaxtl/vcwd8PxcLIdbHE2d8+7OhJ7DEhsfhDDIInq?=
 =?iso-8859-1?Q?vIteaBDLS0owcYNsnAJszhs0aEGJpYRHEL/4atjCnS/+sWEOUXOuoCLleN?=
 =?iso-8859-1?Q?vTmt01NpLksCpEKl49s3wUPhlgaN5U7swn0bPnfQ+ElgJeMuPQrSb+gQxG?=
 =?iso-8859-1?Q?JmFO16W61+7YDZFRe6i1rHTz54mmEYl+E/11ylrr5BmY9xFQmhPm672xXg?=
 =?iso-8859-1?Q?r2S/dNhLEusxc3Wl3JHRDUS6RMr5xIdosH/KvkdERjfhOVMxqJbTaenPUi?=
 =?iso-8859-1?Q?RV9R8p1UjgAOkfaxqK1FrWW/zujDju1a0zzMqPczefmcRMUgkGLlltbxNi?=
 =?iso-8859-1?Q?69gsniIlOi4EdYGJezJxx2Snl0rnouUHnwYAohN3ev7exl+6yuiLlY1jCj?=
 =?iso-8859-1?Q?bjz1yBmTDHr2wlZIWiPXZ27vDPS7AqwG1mzvMI5G5UTTiL5ZGCEGTTiOjO?=
 =?iso-8859-1?Q?yUT3QPNDQCOsbkml/8PFO3yREDwiIWN8gXu58cYkWs5duNZpnwXezhCxrE?=
 =?iso-8859-1?Q?8sEWpdY9dVx+It8K50EJe8MWPIRDrmlRcNcPsbsLZWhXE1dxAQvYLIN2QI?=
 =?iso-8859-1?Q?ESeI/7KA2kOSB5Tp57IqPJ3CFUiC9RYhLgmC+8Alr7aqlHc6+LSF3AUbGx?=
 =?iso-8859-1?Q?gTmu63noZQKI4bR3XdrRpOwtrvlake4gHDM0Cso/MHSrOa170PZ5NWzHSN?=
 =?iso-8859-1?Q?DFrQR757Vt2qPB7B94HzqSTM7ng1KUxxa7AfW/7UMzg06Vn3gYW8mCmnOK?=
 =?iso-8859-1?Q?dPXHXs2FOmHc4IjwzScf5eYlcAAYalykK2vOt32/+BF2+hWkWNZASt183b?=
 =?iso-8859-1?Q?M5P4nHiMcpx5V3j5Fm2mFEfzXm7y3Zx3hHQPt9xDLBs0jauAhV5rLwnpL1?=
 =?iso-8859-1?Q?4XDFQAI0dh4tb33J39Du6gDZ1LmkmlT7qzvdDbUgSMCLnDb05JQFX42hsJ?=
 =?iso-8859-1?Q?suAfklkHuF3LDBfnVTHitBh3CAYfHczXPip5Io6WIQhV3bte4vBNX0CVWa?=
 =?iso-8859-1?Q?biyo8fs57oGXM6vM9MFxnM6o7efeGGKrXH0PYYwtD17IB+Sqi8l7/izmVA?=
 =?iso-8859-1?Q?kgNwTH64fzzwritxG8iQeNiPAilK6pwWkEPVjiLIF6JBiTY8SxPyq9EQBk?=
 =?iso-8859-1?Q?xOlEacs5o/zs10/JtxzU2HQ3qLoidE2f7qm/yhLaKG4qEI5TsnPgH0uuoe?=
 =?iso-8859-1?Q?xCuTAoqfyMyJyFGFmT5zW1a1vAqXznfnVBszLSIrWYYRocXrhWjE/Kf8Z5?=
 =?iso-8859-1?Q?9N9R3D9Tv1VD8tt8Fb9aaYnCQ9XM6U47hokOnItXszsjiQtn3p8GhtLmOg?=
 =?iso-8859-1?Q?XzknAxQyNZIntkrJlIxU1TG4b0C9p9Tt0g?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd7e837-4607-458a-97b2-08dc5f0798be
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 17:55:41.1585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8eW5AWXkvqo+/tAsLaxJiv0XBh3mAo2jT8sUJutFLeKc24zzIavHc77cVEU1Gxq60I0J5z149f6ma0Mjwy3lYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4259
X-Proofpoint-ORIG-GUID: VouDY2vzHdn88w0YsYSLepu9ol8prmx1
X-Proofpoint-GUID: VouDY2vzHdn88w0YsYSLepu9ol8prmx1

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
----------=0A=
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
----------=0A=
=0A=
From 1da5a84d87a439ec4975bf4eb56dccfadf92db4b Mon Sep 17 00:00:00 2001=0A=
From: David Sands <david.sands@biamp.com>=0A=
Date: Tue, 24 Jan 2023 13:04:58 +1000=0A=
Subject: [PATCH] USB: gadget: f_hid: Add GET_REPORT via userspace IOCTL=0A=
=0A=
While supporting GET_REPORT is a mandatory request per the HID=0A=
specification the current implementation of the GET_REPORT request responds=
=0A=
to the USB Host with an empty reply of the request length. However, some=0A=
USB Hosts will request the contents of feature reports via the GET_REPORT=
=0A=
request. In addition, some proprietary HID 'protocols' will expect=0A=
different data, for the same report ID, to be to become available in the=0A=
feature report by sending a preceding SET_REPORT to the USB Device that=0A=
defines what data is to be presented when that feature report is=0A=
subsequently retrieved via GET_REPORT (with a very fast < 5ms turn around=
=0A=
between the SET_REPORT and the GET_REPORT).=0A=
=0A=
There are two other patch sets already submitted for adding GET_REPORT=0A=
support. The first [1] allows for pre-priming a list of reports via IOCTLs=
=0A=
which then allows the USB Host to perform the request, with no further=0A=
userspace interaction possible during the GET_REPORT request. And another=
=0A=
[2] which allows for a single report to be setup by userspace via IOCTL,=0A=
which will be fetched and returned by the kernel for subsequent GET_REPORT=
=0A=
requests by the USB Host, also with no further userspace interaction=0A=
possible.=0A=
=0A=
This patch, while loosely based on both the patch sets, differs by allowing=
=0A=
the option for userspace to respond to each GET_REPORT request by setting=
=0A=
up a poll to notify userspace that a new GET_REPORT request has arrived. To=
=0A=
support this, two extra IOCTLs are supplied. The first of which is used to=
=0A=
retrieve the report ID of the GET_REPORT request (in the case of having=0A=
non-zero report IDs in the HID descriptor). The second IOCTL allows for=0A=
storing report responses in a list for responding to requests.=0A=
=0A=
The report responses are stored in a list (it will be either added if it=0A=
does not exist or updated if it exists already). A flag (userspace_req) can=
=0A=
be set to whether subsequent requests notify userspace or not.=0A=
=0A=
Basic operation when a GET_REPORT request arrives from USB Host:=0A=
=0A=
- If the report ID exists in the list and it is set for immediate return=0A=
  (i.e. userspace_req =3D=3D false) then response is sent immediately,=0A=
userspace is not notified=0A=
=0A=
- The report ID does not exist, or exists but is set to notify userspace=0A=
  (i.e. userspace_req =3D=3D true) then notify userspace via poll:=0A=
=0A=
	- If userspace responds, and either adds or update the response in=0A=
	  the list and respond to the host with the contents=0A=
=0A=
	- If userspace does not respond within the fixed timeout (2500ms)=0A=
	  but the report has been set prevously, then send 'old' report=0A=
	  contents=0A=
=0A=
	- If userspace does not respond within the fixed timeout (2500ms)=0A=
	  and the report does not exist in the list then send an empty=0A=
	  report=0A=
=0A=
Note that userspace could 'prime' the report list at any other time.=0A=
=0A=
While this patch allows for flexibility in how the system responds to=0A=
requests, and therefore the HID 'protocols' that could be supported, a=0A=
drawback is the time it takes to service the requests and therefore the=0A=
maximum throughput that would be achievable. The USB HID Specification=0A=
v1.11 itself states that GET_REPORT is not intended for periodic data=0A=
polling, so this limitation is not severe.=0A=
=0A=
Testing on an iMX8M Nano Ultra Lite with a heavy multi-core CPU loading=0A=
showed that userspace can typically respond to the GET_REPORT request=0A=
within 1200ms - which is well within the 5000ms most operating systems seem=
=0A=
to allow, and within the 2500ms set by this patch.=0A=
=0A=
[1] https://marc.info/?t=3D165968296600006 [2]=0A=
https://marc.info/?t=3D165879768900004=0A=
=0A=
Signed-off-by: David Sands <david.sands@biamp.com>=0A=
Signed-off-by: Chris Wulff <chris.wulff@biamp.com>=0A=
---=0A=
 drivers/usb/gadget/function/f_hid.c | 270 +++++++++++++++++++++++++++-=0A=
 include/uapi/linux/usb/g_hid.h      |  40 +++++=0A=
 include/uapi/linux/usb/gadgetfs.h   |   2 +-=0A=
 3 files changed, 304 insertions(+), 8 deletions(-)=0A=
 create mode 100644 include/uapi/linux/usb/g_hid.h=0A=
=0A=
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/funct=
ion/f_hid.c=0A=
index 3c8a9dd585c0..605cbd37537b 100644=0A=
--- a/drivers/usb/gadget/function/f_hid.c=0A=
+++ b/drivers/usb/gadget/function/f_hid.c=0A=
@@ -15,13 +15,21 @@=0A=
 #include <linux/uaccess.h>=0A=
 #include <linux/wait.h>=0A=
 #include <linux/sched.h>=0A=
+#include <linux/workqueue.h>=0A=
 #include <linux/usb/g_hid.h>=0A=
+#include <uapi/linux/usb/g_hid.h>=0A=
 =0A=
 #include "u_f.h"=0A=
 #include "u_hid.h"=0A=
 =0A=
 #define HIDG_MINORS	4=0A=
 =0A=
+/*=0A=
+ * Most operating systems seem to allow for 5000ms timeout, we will allow=
=0A=
+ * userspace half that time to respond before we return an empty report.=
=0A=
+ */=0A=
+#define GET_REPORT_TIMEOUT_MS 2500=0A=
+=0A=
 static int major, minors;=0A=
 =0A=
 static const struct class hidg_class =3D {=0A=
@@ -31,6 +39,11 @@ static const struct class hidg_class =3D {=0A=
 static DEFINE_IDA(hidg_ida);=0A=
 static DEFINE_MUTEX(hidg_ida_lock); /* protects access to hidg_ida */=0A=
 =0A=
+struct report_entry {=0A=
+	struct usb_hidg_report report_data;=0A=
+	struct list_head node;=0A=
+};=0A=
+=0A=
 /*------------------------------------------------------------------------=
-*/=0A=
 /*                            HID gadget struct                           =
 */=0A=
 =0A=
@@ -75,6 +88,19 @@ struct f_hidg {=0A=
 	wait_queue_head_t		write_queue;=0A=
 	struct usb_request		*req;=0A=
 =0A=
+	/* get report */=0A=
+	struct usb_request		*get_req;=0A=
+	struct usb_hidg_report		get_report;=0A=
+	bool				get_report_returned;=0A=
+	int				get_report_req_report_id;=0A=
+	int				get_report_req_report_length;=0A=
+	spinlock_t			get_report_spinlock;=0A=
+	wait_queue_head_t		get_queue;    /* Waiting for userspace response */=0A=
+	wait_queue_head_t		get_id_queue; /* Get ID came in */=0A=
+	struct work_struct		work;=0A=
+	struct workqueue_struct		*workqueue;=0A=
+	struct list_head		report_list;=0A=
+=0A=
 	struct device			dev;=0A=
 	struct cdev			cdev;=0A=
 	struct usb_function		func;=0A=
@@ -524,6 +550,171 @@ static ssize_t f_hidg_write(struct file *file, const =
char __user *buffer,=0A=
 	return status;=0A=
 }=0A=
 =0A=
+static struct report_entry *f_hidg_search_for_report(struct f_hidg *hidg, =
u8 report_id)=0A=
+{=0A=
+	struct list_head	*ptr;=0A=
+	struct report_entry	*entry;=0A=
+=0A=
+	list_for_each(ptr, &hidg->report_list) {=0A=
+		entry =3D list_entry(ptr, struct report_entry, node);=0A=
+		if (entry->report_data.report_id =3D=3D report_id)=0A=
+			return entry;=0A=
+	}=0A=
+=0A=
+	return NULL;=0A=
+}=0A=
+=0A=
+void get_report_workqueue_handler(struct work_struct *work)=0A=
+{=0A=
+	struct f_hidg *hidg =3D container_of(work, struct f_hidg, work);=0A=
+	struct usb_composite_dev *cdev =3D hidg->func.config->cdev;=0A=
+	struct usb_request		*req;=0A=
+	struct report_entry *ptr;=0A=
+	unsigned long	flags;=0A=
+=0A=
+	int status =3D 0;=0A=
+=0A=
+	spin_lock_irqsave(&hidg->get_report_spinlock, flags);=0A=
+	req =3D hidg->get_req;=0A=
+	if (!req) {=0A=
+		spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	req->zero =3D 0;=0A=
+	req->length =3D min_t(unsigned, min_t(unsigned, hidg->get_report_req_repo=
rt_length, hidg->report_length), MAX_REPORT_LENGTH);=0A=
+=0A=
+	/* Check if there is a response available for immediate response */=0A=
+	ptr =3D f_hidg_search_for_report(hidg, hidg->get_report_req_report_id);=
=0A=
+	if (ptr && !ptr->report_data.userspace_req) {=0A=
+		/* Report exists in list and it is to be used for immediate response */=
=0A=
+		req->buf =3D ptr->report_data.data;=0A=
+		status =3D usb_ep_queue(cdev->gadget->ep0, req, GFP_ATOMIC);=0A=
+		hidg->get_report_returned =3D true;=0A=
+		spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);=0A=
+	} else {=0A=
+		/*=0A=
+		 * Report does not exist in list or should not be immediately sent=0A=
+		 * i.e. give userspace time to respond=0A=
+		 */=0A=
+		hidg->get_report_returned =3D false;=0A=
+		spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);=0A=
+		wake_up(&hidg->get_id_queue);=0A=
+#define GET_REPORT_COND (!hidg->get_report_returned)=0A=
+		/* Wait until userspace has responded or timeout */=0A=
+		status =3D wait_event_interruptible_timeout(hidg->get_queue, !GET_REPORT=
_COND,=0A=
+					msecs_to_jiffies(GET_REPORT_TIMEOUT_MS));=0A=
+		spin_lock_irqsave(&hidg->get_report_spinlock, flags);=0A=
+		req =3D hidg->get_req;=0A=
+		if (!req) {=0A=
+			spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);=0A=
+			return;=0A=
+		}=0A=
+		if (status =3D=3D 0 && !hidg->get_report_returned) {=0A=
+			/* GET_REPORT request was not serviced by userspace within timeout peri=
od */=0A=
+			VDBG(cdev, "get_report : userspace timeout.\n");=0A=
+			hidg->get_report_returned =3D true;=0A=
+		}=0A=
+=0A=
+		/* Search again for report ID in list and respond to GET_REPORT request =
*/=0A=
+		ptr =3D f_hidg_search_for_report(hidg, hidg->get_report_req_report_id);=
=0A=
+		if (ptr) {=0A=
+			/*=0A=
+			 * Either get an updated response just serviced by userspace=0A=
+			 * or send the latest response in the list=0A=
+			 */=0A=
+			req->buf =3D ptr->report_data.data;=0A=
+		} else {=0A=
+			/* If there are no prevoiusly sent reports send empty report */=0A=
+			req->buf =3D hidg->get_report.data;=0A=
+			memset(req->buf, 0x0, req->length);=0A=
+		}=0A=
+=0A=
+		status =3D usb_ep_queue(cdev->gadget->ep0, req, GFP_ATOMIC);=0A=
+		spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);=0A=
+	}=0A=
+=0A=
+	if (status < 0)=0A=
+		VDBG(cdev, "usb_ep_queue error on ep0 responding to GET_REPORT\n");=0A=
+}=0A=
+=0A=
+static int f_hidg_get_report_id(struct file *file, __u8 __user *buffer)=0A=
+{=0A=
+	struct f_hidg			*hidg =3D file->private_data;=0A=
+	int ret =3D 0;=0A=
+=0A=
+	ret =3D put_user(hidg->get_report_req_report_id, buffer);=0A=
+=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+static int f_hidg_get_report(struct file *file, struct usb_hidg_report __u=
ser *buffer)=0A=
+{=0A=
+	struct f_hidg			*hidg =3D file->private_data;=0A=
+	struct usb_composite_dev	*cdev =3D hidg->func.config->cdev;=0A=
+	unsigned long	flags;=0A=
+	struct report_entry *entry;=0A=
+	struct report_entry *ptr;=0A=
+	__u8 report_id;=0A=
+=0A=
+	entry =3D kmalloc(sizeof(*entry), GFP_KERNEL);=0A=
+	if (!entry)=0A=
+		return -ENOMEM;=0A=
+=0A=
+	if (copy_from_user(&entry->report_data, buffer,=0A=
+				sizeof(struct usb_hidg_report))) {=0A=
+		ERROR(cdev, "copy_from_user error\n");=0A=
+		kfree(entry);=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	report_id =3D entry->report_data.report_id;=0A=
+=0A=
+	spin_lock_irqsave(&hidg->get_report_spinlock, flags);=0A=
+	ptr =3D f_hidg_search_for_report(hidg, report_id);=0A=
+=0A=
+	if (ptr) {=0A=
+		/* Report already exists in list - update it */=0A=
+		if (copy_from_user(&ptr->report_data, buffer,=0A=
+				sizeof(struct usb_hidg_report))) {=0A=
+			ERROR(cdev, "copy_from_user error\n");=0A=
+			kfree(entry);=0A=
+			return -EINVAL;=0A=
+		}=0A=
+		kfree(entry);=0A=
+	} else {=0A=
+		/* Report does not exist in list - add it */=0A=
+		list_add_tail(&entry->node, &hidg->report_list);=0A=
+	}=0A=
+=0A=
+	/* If there is no response pending then do nothing further */=0A=
+	if (hidg->get_report_returned) {=0A=
+		spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	/* If this userspace response serves the current pending report */=0A=
+	if (hidg->get_report_req_report_id =3D=3D report_id) {=0A=
+		hidg->get_report_returned =3D true;=0A=
+		wake_up(&hidg->get_queue);=0A=
+	}=0A=
+=0A=
+	spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static long f_hidg_ioctl(struct file *file, unsigned int code, unsigned lo=
ng arg)=0A=
+{=0A=
+	switch (code) {=0A=
+	case GADGET_HID_READ_GET_REPORT_ID:=0A=
+		return f_hidg_get_report_id(file, (__u8 __user *)arg);=0A=
+	case GADGET_HID_WRITE_GET_REPORT:=0A=
+		return f_hidg_get_report(file, (struct usb_hidg_report __user *)arg);=0A=
+	default:=0A=
+		return -ENOTTY;=0A=
+	}=0A=
+}=0A=
+=0A=
 static __poll_t f_hidg_poll(struct file *file, poll_table *wait)=0A=
 {=0A=
 	struct f_hidg	*hidg  =3D file->private_data;=0A=
@@ -531,6 +722,8 @@ static __poll_t f_hidg_poll(struct file *file, poll_tab=
le *wait)=0A=
 =0A=
 	poll_wait(file, &hidg->read_queue, wait);=0A=
 	poll_wait(file, &hidg->write_queue, wait);=0A=
+	poll_wait(file, &hidg->get_queue, wait);=0A=
+	poll_wait(file, &hidg->get_id_queue, wait);=0A=
 =0A=
 	if (WRITE_COND)=0A=
 		ret |=3D EPOLLOUT | EPOLLWRNORM;=0A=
@@ -543,12 +736,16 @@ static __poll_t f_hidg_poll(struct file *file, poll_t=
able *wait)=0A=
 			ret |=3D EPOLLIN | EPOLLRDNORM;=0A=
 	}=0A=
 =0A=
+	if (GET_REPORT_COND)=0A=
+		ret |=3D EPOLLPRI;=0A=
+=0A=
 	return ret;=0A=
 }=0A=
 =0A=
 #undef WRITE_COND=0A=
 #undef READ_COND_SSREPORT=0A=
 #undef READ_COND_INTOUT=0A=
+#undef GET_REPORT_COND=0A=
 =0A=
 static int f_hidg_release(struct inode *inode, struct file *fd)=0A=
 {=0A=
@@ -641,6 +838,10 @@ static void hidg_ssreport_complete(struct usb_ep *ep, =
struct usb_request *req)=0A=
 	wake_up(&hidg->read_queue);=0A=
 }=0A=
 =0A=
+static void hidg_get_report_complete(struct usb_ep *ep, struct usb_request=
 *req)=0A=
+{=0A=
+}=0A=
+=0A=
 static int hidg_setup(struct usb_function *f,=0A=
 		const struct usb_ctrlrequest *ctrl)=0A=
 {=0A=
@@ -649,6 +850,7 @@ static int hidg_setup(struct usb_function *f,=0A=
 	struct usb_request		*req  =3D cdev->req;=0A=
 	int status =3D 0;=0A=
 	__u16 value, length;=0A=
+	unsigned long	flags;=0A=
 =0A=
 	value	=3D __le16_to_cpu(ctrl->wValue);=0A=
 	length	=3D __le16_to_cpu(ctrl->wLength);=0A=
@@ -660,14 +862,20 @@ static int hidg_setup(struct usb_function *f,=0A=
 	switch ((ctrl->bRequestType << 8) | ctrl->bRequest) {=0A=
 	case ((USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE) << 8=0A=
 		  | HID_REQ_GET_REPORT):=0A=
-		VDBG(cdev, "get_report\n");=0A=
+		VDBG(cdev, "get_report | wLength=3D%d\n", ctrl->wLength);=0A=
 =0A=
-		/* send an empty report */=0A=
-		length =3D min_t(unsigned, length, hidg->report_length);=0A=
-		memset(req->buf, 0x0, length);=0A=
+		/*=0A=
+		 * Update GET_REPORT ID so that an ioctl can be used to determine what=
=0A=
+		 * GET_REPORT the request was actually for.=0A=
+		 */=0A=
+		spin_lock_irqsave(&hidg->get_report_spinlock, flags);=0A=
+		hidg->get_report_req_report_id =3D value & 0xff;=0A=
+		hidg->get_report_req_report_length =3D length;=0A=
+		spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);=0A=
 =0A=
-		goto respond;=0A=
-		break;=0A=
+		queue_work(hidg->workqueue, &hidg->work);=0A=
+=0A=
+		return status;=0A=
 =0A=
 	case ((USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE) << 8=0A=
 		  | HID_REQ_GET_PROTOCOL):=0A=
@@ -793,6 +1001,14 @@ static void hidg_disable(struct usb_function *f)=0A=
 		spin_unlock_irqrestore(&hidg->read_spinlock, flags);=0A=
 	}=0A=
 =0A=
+	spin_lock_irqsave(&hidg->get_report_spinlock, flags);=0A=
+	if (!hidg->get_report_returned) {=0A=
+		usb_ep_free_request(f->config->cdev->gadget->ep0, hidg->get_req);=0A=
+		hidg->get_req =3D NULL;=0A=
+		hidg->get_report_returned =3D true;=0A=
+	}=0A=
+	spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);=0A=
+=0A=
 	spin_lock_irqsave(&hidg->write_spinlock, flags);=0A=
 	if (!hidg->write_pending) {=0A=
 		free_ep_req(hidg->in_ep, hidg->req);=0A=
@@ -902,6 +1118,14 @@ static int hidg_set_alt(struct usb_function *f, unsig=
ned intf, unsigned alt)=0A=
 	return status;=0A=
 }=0A=
 =0A=
+#ifdef CONFIG_COMPAT=0A=
+static long f_hidg_compat_ioctl(struct file *file, unsigned code,=0A=
+		unsigned long value)=0A=
+{=0A=
+	return f_hidg_ioctl(file, code, value);=0A=
+}=0A=
+#endif=0A=
+=0A=
 static const struct file_operations f_hidg_fops =3D {=0A=
 	.owner		=3D THIS_MODULE,=0A=
 	.open		=3D f_hidg_open,=0A=
@@ -909,6 +1133,10 @@ static const struct file_operations f_hidg_fops =3D {=
=0A=
 	.write		=3D f_hidg_write,=0A=
 	.read		=3D f_hidg_read,=0A=
 	.poll		=3D f_hidg_poll,=0A=
+	.unlocked_ioctl	=3D f_hidg_ioctl,=0A=
+#ifdef CONFIG_COMPAT=0A=
+	.compat_ioctl =3D f_hidg_compat_ioctl,=0A=
+#endif=0A=
 	.llseek		=3D noop_llseek,=0A=
 };=0A=
 =0A=
@@ -919,6 +1147,15 @@ static int hidg_bind(struct usb_configuration *c, str=
uct usb_function *f)=0A=
 	struct usb_string	*us;=0A=
 	int			status;=0A=
 =0A=
+	hidg->get_req =3D usb_ep_alloc_request(c->cdev->gadget->ep0, GFP_ATOMIC);=
=0A=
+	if (!hidg->get_req)=0A=
+		return -ENOMEM;=0A=
+=0A=
+	hidg->get_req->zero =3D 0;=0A=
+	hidg->get_req->complete =3D hidg_get_report_complete;=0A=
+	hidg->get_req->context =3D hidg;=0A=
+	hidg->get_report_returned =3D true;=0A=
+=0A=
 	/* maybe allocate device-global string IDs, and patch descriptors */=0A=
 	us =3D usb_gstrings_attach(c->cdev, ct_func_strings,=0A=
 				 ARRAY_SIZE(ct_func_string_defs));=0A=
@@ -1004,9 +1241,24 @@ static int hidg_bind(struct usb_configuration *c, st=
ruct usb_function *f)=0A=
 	hidg->write_pending =3D 1;=0A=
 	hidg->req =3D NULL;=0A=
 	spin_lock_init(&hidg->read_spinlock);=0A=
+	spin_lock_init(&hidg->get_report_spinlock);=0A=
 	init_waitqueue_head(&hidg->write_queue);=0A=
 	init_waitqueue_head(&hidg->read_queue);=0A=
+	init_waitqueue_head(&hidg->get_queue);=0A=
+	init_waitqueue_head(&hidg->get_id_queue);=0A=
 	INIT_LIST_HEAD(&hidg->completed_out_req);=0A=
+	INIT_LIST_HEAD(&hidg->report_list);=0A=
+=0A=
+	INIT_WORK(&hidg->work, get_report_workqueue_handler);=0A=
+	hidg->workqueue =3D alloc_workqueue("report_work",=0A=
+					  WQ_FREEZABLE |=0A=
+					  WQ_MEM_RECLAIM,=0A=
+					  1);=0A=
+=0A=
+	if (!hidg->workqueue) {=0A=
+		status =3D -ENOMEM;=0A=
+		goto fail;=0A=
+	}=0A=
 =0A=
 	/* create char device */=0A=
 	cdev_init(&hidg->cdev, &f_hidg_fops);=0A=
@@ -1016,12 +1268,16 @@ static int hidg_bind(struct usb_configuration *c, s=
truct usb_function *f)=0A=
 =0A=
 	return 0;=0A=
 fail_free_descs:=0A=
+	destroy_workqueue(hidg->workqueue);=0A=
 	usb_free_all_descriptors(f);=0A=
 fail:=0A=
 	ERROR(f->config->cdev, "hidg_bind FAILED\n");=0A=
 	if (hidg->req !=3D NULL)=0A=
 		free_ep_req(hidg->in_ep, hidg->req);=0A=
 =0A=
+	usb_ep_free_request(c->cdev->gadget->ep0, hidg->get_req);=0A=
+	hidg->get_req =3D NULL;=0A=
+=0A=
 	return status;=0A=
 }=0A=
 =0A=
@@ -1256,7 +1512,7 @@ static void hidg_unbind(struct usb_configuration *c, =
struct usb_function *f)=0A=
 	struct f_hidg *hidg =3D func_to_hidg(f);=0A=
 =0A=
 	cdev_device_del(&hidg->cdev, &hidg->dev);=0A=
-=0A=
+	destroy_workqueue(hidg->workqueue);=0A=
 	usb_free_all_descriptors(f);=0A=
 }=0A=
 =0A=
diff --git a/include/uapi/linux/usb/g_hid.h b/include/uapi/linux/usb/g_hid.=
h=0A=
new file mode 100644=0A=
index 000000000000..b965092db476=0A=
--- /dev/null=0A=
+++ b/include/uapi/linux/usb/g_hid.h=0A=
@@ -0,0 +1,40 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */=0A=
+=0A=
+#ifndef __UAPI_LINUX_USB_G_HID_H=0A=
+#define __UAPI_LINUX_USB_G_HID_H=0A=
+=0A=
+#include <linux/types.h>=0A=
+=0A=
+/* Maximum HID report length for High-Speed USB (i.e. USB 2.0) */=0A=
+#define MAX_REPORT_LENGTH 64=0A=
+=0A=
+/**=0A=
+ * struct usb_hidg_report - response to GET_REPORT=0A=
+ * @report_id: report ID that this is a response for=0A=
+ * @userspace_req:=0A=
+ *    !0 this report is used for any pending GET_REPORT request=0A=
+ *       but wait on userspace to issue a new report on future requests=0A=
+ *    0  this report is to be used for any future GET_REPORT requests=0A=
+ * @length: length of the report response=0A=
+ * @data: report response=0A=
+ * @padding: padding for 32/64 bit compatibility=0A=
+ *=0A=
+ * Structure used by GADGET_HID_WRITE_GET_REPORT ioctl on /dev/hidg*.=0A=
+ */=0A=
+struct usb_hidg_report {=0A=
+	__u8 report_id;=0A=
+	__u8 userspace_req;=0A=
+	__u16 length;=0A=
+	__u8 data[MAX_REPORT_LENGTH];=0A=
+	__u8 padding[4];=0A=
+};=0A=
+=0A=
+/* The 'g' code is used by gadgetfs and hid gadget ioctl requests.=0A=
+ * Don't add any colliding codes to either driver, and keep=0A=
+ * them in unique ranges.=0A=
+ */=0A=
+=0A=
+#define GADGET_HID_READ_GET_REPORT_ID   _IOR('g', 0x41, __u8)=0A=
+#define GADGET_HID_WRITE_GET_REPORT     _IOW('g', 0x42, struct usb_hidg_re=
port)=0A=
+=0A=
+#endif /* __UAPI_LINUX_USB_G_HID_H */=0A=
diff --git a/include/uapi/linux/usb/gadgetfs.h b/include/uapi/linux/usb/gad=
getfs.h=0A=
index 835473910a49..9754822b2a40 100644=0A=
--- a/include/uapi/linux/usb/gadgetfs.h=0A=
+++ b/include/uapi/linux/usb/gadgetfs.h=0A=
@@ -62,7 +62,7 @@ struct usb_gadgetfs_event {=0A=
 };=0A=
 =0A=
 =0A=
-/* The 'g' code is also used by printer gadget ioctl requests.=0A=
+/* The 'g' code is also used by printer and hid gadget ioctl requests.=0A=
  * Don't add any colliding codes to either driver, and keep=0A=
  * them in unique ranges (size 0x20 for now).=0A=
  */=0A=
-- =0A=
2.34.1=0A=
=0A=
=0A=
=0A=

