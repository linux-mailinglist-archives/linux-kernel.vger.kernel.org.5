Return-Path: <linux-kernel+bounces-149053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE5E8A8B18
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FA51C23C97
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4201173340;
	Wed, 17 Apr 2024 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="AGN+KtKr";
	dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="qK3HKk6M"
Received: from mx0a-0068d901.pphosted.com (mx0a-0068d901.pphosted.com [205.220.168.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4C312C819;
	Wed, 17 Apr 2024 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713378574; cv=fail; b=fIOUjIXQsIVS5MykkN4q7BJGasjstKc/U8C2p8qTN0L3iS5LW5Y2ioVAp0O6wvcj98VvOur/bFtJF+1o2yHCA/lOKPQ3mFAdSEGuHLmLl/GTl3fGwuNgrgeyad43y55qG32bMLhs/2U0en+4OoC3ecxoxXfLA8vGtO1tkEmIAoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713378574; c=relaxed/simple;
	bh=R0wGpWUBhKJX27ws/BcNgHLoO9piZfsvZJgdA6qTf5U=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Uwy0fIlkcpNKYkcP/h2rQVWfV42yp0SDt9FmZbK02X5AM7ltEJPLKkf4jtgnFs/oyywUPTqctofXYOXbMjFdeTzgGX5U9AVGqMkJy5aE1GBojXKKsVTC4hC90mxM9pvkk9rh5ST87DXDZYzu9IcVg4uOasz71P3xgz8PeKd9HRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com; spf=pass smtp.mailfrom=biamp.com; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=AGN+KtKr; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=qK3HKk6M; arc=fail smtp.client-ip=205.220.168.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=biamp.com
Received: from pps.filterd (m0278264.ppops.net [127.0.0.1])
	by mx0b-0068d901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43HCpRFu027792;
	Wed, 17 Apr 2024 11:29:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=proofpoint; bh=pzTQl1
	4QYSh0GNCELAT69hG20wHARcccBMELq/P/mTw=; b=AGN+KtKr/OqtdZ1+lSHtHg
	bXhScxWXPaxVTtBEE3gtWLXltWMMsgGqsfIj8HZixJov8NWSbTh+uW4f7EaW43qw
	vkeE8k2d8uqNqMb6uQTSW+CWoyisJb5o2dYgMHrZk7oVBtHz79sxFc4EMaLSfJzr
	/WqKFdksedS0GaWPp18IbEYWs3ZfUhr81VBrI9Cq/RdMpavTxWUxOArAaJSQfC/5
	e4Yy4mMxQ2KCkW/I35GZdRTTobQayJ/fr1BnhFEZNKg5T4bp3X1qb47XCPQSzYDc
	9/ggNfmo4dQP94GzrBtu0fc4xanWWJE7NNdT0iNFdZjcG5AOWKzYJrBfmFD7hSIg
	==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0b-0068d901.pphosted.com (PPS) with ESMTPS id 3xg09r2q06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 11:29:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBw9Q1W3kaRHkB2NsIXPEGj1G65h4tOTjBF++hdIgRBBLOdGf6UIYFiP7cxssPh1DM81M0sdej5S2Qvudmc9BRWma9iUxuAMDeoz5mfiEektnQ9dT4q9ILv4ZPlepcy6LBrCBWgoNxmm6ekfvsXO08OtTb7C6MD1LlU93rRgNjzcettIFEqsMFRtSnSTdep3DzzhIY/VKmwGhYNH7hgG+Gbwkn3WtdycI012Bh87eGp/I9fR5KQ/JhrdXjIR5Q0fLS+oAjtuaamdUSilcj1f2ZUPrsOM/wwxAKyKvMLESsj1RSFtvDD8wuhCNwZF5EcYDi3Cd4vxx1mA0xrZJGoWnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzTQl14QYSh0GNCELAT69hG20wHARcccBMELq/P/mTw=;
 b=kPS401gUxurxgQAxdurtR21UxIu6PWIaxwOYj1R/+URiWgmWlQQB1j1YHQjXqk4rP/DCHu9RSgN86TjwkHEM2nTmYy4Wbg5f7aTjj4gEecblpKLBkhXBDgQAbnA66lR84ylwhli/aWm298ddK3i9DRMUpIWfOYfJAyf52Fg75wk/c6lk0j2MTcQzQZ6DvS/GwMkogcy06Be+804roCQlye5NR0Jc11yL2C3zrYSuAG/86w00zcDMb+JB/Znl2KrE1zMTvUk11QSLFyt4UKxy5RSK9TNaDaU1+h4u1Jm2dEQBK6Iws/5vBwIDX0qTvXsXPjg/vvDaBkdRLGNzlhNAGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzTQl14QYSh0GNCELAT69hG20wHARcccBMELq/P/mTw=;
 b=qK3HKk6M+1TSNBkm/m5jylLfQm43YB+JIXtHK5FEm+b23a7xoYXOJzXmzi3biTw6rN2x/r/AjafQmN89LVryS5Wzc/VNoeCU1x2kMC0yFwp2mFIU1vGWfNQto7s2g0PFnxsDXVmbGFFXoZtm2iQWgbAN+sp+G+U1uO6ghOIUwA5YaE3vVJQQvuuXrHsmRa3UKivGukjzIXYz+pA0kJuHu66I/gGjOJH8hxIINKIilac6TmaSWqKqQr5D87fCAK+EnhqTak9lep/FqEOGJuhAWT7dV6OAjco64IYWFnPnAHR3SOJU8XicTZdHdpdLoQEN/r67hFdzX1MDq8dfrkrGUA==
Received: from CO1PR17MB5419.namprd17.prod.outlook.com (2603:10b6:303:ec::17)
 by IA1PR17MB6122.namprd17.prod.outlook.com (2603:10b6:208:3a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 18:29:27 +0000
Received: from CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555]) by CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555%4]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 18:29:27 +0000
From: Chris Wulff <Chris.Wulff@biamp.com>
To: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Sands
	<David.Sands@biamp.com>
Subject: [PATCH v2 1/1] USB: gadget: f_hid: Add GET_REPORT via userspace IOCTL
Thread-Topic: [PATCH v2 1/1] USB: gadget: f_hid: Add GET_REPORT via userspace
 IOCTL
Thread-Index: AQHakPTUsPpYPjVyF0mGYUmSCVPaPQ==
Date: Wed, 17 Apr 2024 18:29:27 +0000
Message-ID: 
 <CO1PR17MB541952864266039BAA7BBBD3E10F2@CO1PR17MB5419.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR17MB5419:EE_|IA1PR17MB6122:EE_
x-ms-office365-filtering-correlation-id: e4ec93c1-8421-49f2-bb25-08dc5f0c50b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 P0jLJrssVoCNuo3TXdWIAZCpwrTvrJJBuLcn1gZbOg/Z5Pd4x9899wchfZIsE5t5XB0qZz2pSrerxIFJDvxpUDMAgAqV/VW8glJ6u1uIRw+87vRVsEuCpUlTrQPciT5l0PvqA8QE+vslCIaxgEzY+DLnj4sclzeM7UjOisON6S9F0i4puM6g/8LFRi+WwqXH5ugCam/LGAY0ohbEsns+DmCNZa+/9v3AFy7JN42Lwa8VJGOwLxcmMIZY/iL6Oi/2Iq+O4zisw94rmvGXByjCj2CYVE6dK6LU2MbbgGOLQ0ui31eVTrWkQ1t8eNpktqSVtPJVfT+CeRXFYrd/qpjQ2LPPZTyuS8REGRLySAiV0UE/YelIWdHMzsuypvwDtDcHm4NxZFowH2Xz9oJ9TeYVAHQqI0BiIRYXmLttRRwRcq06WD7RA6a15TO3Td0SJE+7WHXTo43lKPrpyA/RqvguuoP5FTQURBak/XXvlgHlCHRzLntQtsGdE5beKLOO9LZT7B7JCb7SjObCsaCL31Y8kypB0uEKSRkFd9lgSe+quwXI0YOZAazDsYQ9IOtWt2PPBk7WJtMes22aAZVRK5cc9BTqEoa2MWlo0Y4zEakDDoVjfKxrMB6Vn8LFA9Q9M0d4Wgj/uloI7PRLJuc9SUl3U8NYNelvzjF0Z2h2KE37jGE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR17MB5419.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?Pd6PFGgHwXm6fxmvLDsIkA7G21D0jmHDPh8ruuDaR+yTlaCt9FavIyViA8?=
 =?iso-8859-1?Q?F5DwYxoi/EsjHa+/DSJOND/xwSE4KXz65hZmaos7q7eM3poGvek74JjgOb?=
 =?iso-8859-1?Q?7eo1F3NA5/uN91Ls/aRo4mtJ34O/3DjZRrjg7WAgqnwq/lYoKuIN4LBlgL?=
 =?iso-8859-1?Q?v6Fk4R/IWsCx0QhbNXOxKkMpGw2vx5wIk+N9y3q/B/coKaiO76rHcO2XE/?=
 =?iso-8859-1?Q?ep9mxMvDKhC6kggr5epItFKO7C4e2callSitQUvJRPGYKheSPs7dgnoBm2?=
 =?iso-8859-1?Q?I4++DYlwCAFlzzARI6xdbpdh5Y/WtS/XTfi3lgWL+6F18V/8FtHbjDAHjE?=
 =?iso-8859-1?Q?oAKHjRq9c7uuuGxFZAadikk9lJES41rle/RIIHYvVNvbapVqMwRDqXNpx7?=
 =?iso-8859-1?Q?oimaaS/wPTJuPjbNwNUND1DEa52tXlhbLkZbukf2VoetWKbn0TRHV6fBdB?=
 =?iso-8859-1?Q?Zx9Jkfuar1pAYD1F6+ijbFRqsUHkR5eELBF/yfTw/Bmtva3Juu46FTerGz?=
 =?iso-8859-1?Q?MpRdlk/WIcr62G1VcY6sVouYz/7jdwKBPmzH16WGaFIMsXSaC4wbRq0hZA?=
 =?iso-8859-1?Q?9851nfVcpgCSYTbSHJXkUDV2iPLUgsFc+OJjSQ7CdRX6Up5v45F6engEu3?=
 =?iso-8859-1?Q?EucezvYe8NbsQnEdzPSJKWz1+2/9WE3ylhTXxvpS5R449234JpfJWeWdeE?=
 =?iso-8859-1?Q?i1fooAVdm9X/w2H+5tw4vddL3blhBZ6Ur9bs6I1e9GGCyGzFIjPiqETOna?=
 =?iso-8859-1?Q?DYvHsgxsvzkqKWshruz6vngrcaWwgI5PwgSEymRFE8I1yRXABxrJ/uMZla?=
 =?iso-8859-1?Q?Sqgcv72kuayCv4Ab6Xh3YDgWL7bSg4xfQaQ+djTvdQuybqoT09oQdqM5nU?=
 =?iso-8859-1?Q?ATTUT/oUkPMstcZW6eR2rBXanwJokKSxxfI6sJiP64RhOo9yipqaz2AYVG?=
 =?iso-8859-1?Q?qIbV1WgXkhBBypkzdwBCykJ3acZ5BXoRyFEKTR/xVegj5X1wlRcwPkXB81?=
 =?iso-8859-1?Q?2/hKxCjGvk3Vjc+NoEZbkoH+Cn+rIy8UiDZSz7Zjvtf/3LYjTb4pfw0E/5?=
 =?iso-8859-1?Q?asPkeOwpT6oqZD4CFvekosRLfhxqJz2d4ebG8S7aZYu/Tr5FblqnBthm39?=
 =?iso-8859-1?Q?MNAVFrRrvjGrJ+tfkUcRDwLzCADWu99VuE5qOO7mgHob32LHeeB1238BUq?=
 =?iso-8859-1?Q?nd2+rLiZCmHH1MkWMRkiCYYVgQD/vyx5ACl/aBkPRT/fcCNRw9Qumr3qbn?=
 =?iso-8859-1?Q?zAJEaaUNA6YYHqbJpIgvdBb+oyK+y72+u9vPy25FfkzIBzXnVshq+m2pNI?=
 =?iso-8859-1?Q?XTL01zcgeoTKhaR/ptQEBIBRQdUQgrgKxrwawKFfmg3VZ0KzDTnttdquXQ?=
 =?iso-8859-1?Q?P5BlVFYtnhLHvCV7uFXKw3FHB1qQet4A5Hbijy3gLhRfPpuiRBjoZSe8Wq?=
 =?iso-8859-1?Q?8B5SiViqwLSZFQTRfLlFILKdZr4bj4/ON8w5Fe2HxFfjupjjyNXyXj/EhM?=
 =?iso-8859-1?Q?/q6bbK6eK73GEhTRpqfKC6xfK16+ryuOLc8oW1v3mLLV9n2lAeW0qxp4To?=
 =?iso-8859-1?Q?0uHmoK5QRGs17JE3t0myn0CIeSS9LfV8BVcfwpfT94iaCr2NxkohEYjXhe?=
 =?iso-8859-1?Q?ro5ZX/0Yq+LM3NsOltRKRYPaynQG5hWp4X?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ec93c1-8421-49f2-bb25-08dc5f0c50b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 18:29:27.7689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xp35m8BqlQ+O0/aoPdYI6v1uInubyfihENGx8UxfKL0TSsRDYiEeMRPxMaqVW1C5JMw2JO/sVKxN9G/oV4Le+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6122
X-Proofpoint-ORIG-GUID: UpIMqUpwiu9Uq68IepcNqO6Y-I_8z1Z6
X-Proofpoint-GUID: UpIMqUpwiu9Uq68IepcNqO6Y-I_8z1Z6

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

