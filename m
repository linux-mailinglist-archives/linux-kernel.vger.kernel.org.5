Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F81782366
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjHUGFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbjHUGFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:05:47 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7CB110;
        Sun, 20 Aug 2023 23:05:21 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37KNV4FH030885;
        Sun, 20 Aug 2023 23:05:06 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sju3qkv84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 20 Aug 2023 23:05:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTjbXHFOh57PygeyttAix/WmVPaOb5iRaZPsNimCD8FZ46o9m2hKWZ1AZiaBFeJ0AeouiNbCzZKaSuw0sIb+WR+zNOm7IqyjaGLsWMUgoHUFnMAIQndsX1qDIbgN4BFIE8ehA5kjDzLwvoDF5k5Ma7GdlDS7MtOe3UWsh0suQYN88wDgGJgn+8X/CjNg1nhL/aIAL+GCk4KfD4lnKDoEv5wo+1ab14wgKB/e6naPORSech2+2MhMmUXi969Jpatm+2aKTsYQ0QULlAwofRhhkAwUZW0f6FEYLOnYmoRozQu5PZqp9zwRMOF/klv8TtT5pvk+AKy19YCDFlVpzKyuYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaM/umK1PNp8n442kEaiMMVa/G80f8Ktq2/PxwCKT/w=;
 b=UyMNfF85BTCZq78xRJNvNVXyEE+QaWJ0wYHanYI8CSFVPuiA22W3LDk8NG98ymcQdigeHFcCHK13aYjkzYCm7ZEVdDfQK/4nvSFMlRnK3OIa5j1QYd+XUvduyR6slMpvTjVvijclq1WEpaeqNSIOvry5NQjIk1sUkfQJi/FfgMk9aR1b6Ae5RYZhA1rpVhoHIL5Dljav+qdL7fFq1FfccAj7pyLXs5evWqj8mPWR86BEYseKV2EnhfMegPmc/VgaNUSIb/TA/JwzEXgNV/rwOo4FWSe6Jtip4QeFPEJGZQEIlRsOsawkM2LvWrqj9fPX2/YUNIZaKcUTFlAoog7Jsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaM/umK1PNp8n442kEaiMMVa/G80f8Ktq2/PxwCKT/w=;
 b=Km1zTU+unbKnOzMbJ5DL7yR9S3h+hWvb9GEWp7axNzJprvbxa3ApC5gcIXfIe1IM29dasHCb6E4YJJttWPXylegNDAypCw31ePGEIqt3UGJJIVAMoSL74Ktg8XP/kLRD/M5BxkYua4tSFSmcs2aiu7HZTM+o+XNLL7oGQXt30qE=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by DS0PR18MB5339.namprd18.prod.outlook.com (2603:10b6:8:115::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 06:05:04 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::bda0:6335:2519:31b5]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::bda0:6335:2519:31b5%5]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 06:05:03 +0000
From:   Sai Krishna Gajula <saikrishnag@marvell.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "kalesh-anakkur.purayil@broadcom.com" 
        <kalesh-anakkur.purayil@broadcom.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net-next PATCH v3] octeontx2-pf: Use PTP HW timestamp counter
 atomic update feature
Thread-Topic: [net-next PATCH v3] octeontx2-pf: Use PTP HW timestamp counter
 atomic update feature
Thread-Index: AQHZ0/Vt3Y53v8cQ1EGJPHwhORJilQ==
Date:   Mon, 21 Aug 2023 06:05:03 +0000
Message-ID: <BY3PR18MB47077D1B36A1AFE818F9CD4BA01EA@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20230817174351.3480292-1-saikrishnag@marvell.com>
 <20230818184901.GC22185@unreal>
In-Reply-To: <20230818184901.GC22185@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2Fpa3Jpc2hu?=
 =?us-ascii?Q?YWdcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?us-ascii?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy1hOTQ5OWU5Mi0zZmU4LTExZWUtYWQyMy0x?=
 =?us-ascii?Q?Y2MxMGM0MGQ5ZTRcYW1lLXRlc3RcYTk0OTllOTMtM2ZlOC0xMWVlLWFkMjMt?=
 =?us-ascii?Q?MWNjMTBjNDBkOWU0Ym9keS50eHQiIHN6PSIzNjU1IiB0PSIxMzMzNzA3MTUw?=
 =?us-ascii?Q?MTI5MzEyMDUiIGg9IldRSkJ3cFJ4d08vREd5ei85SjlNRSs2cGhkRT0iIGlk?=
 =?us-ascii?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU40?=
 =?us-ascii?Q?UEFBQ0ZIc2xyOWRQWkFhRk1zTkk4ditaK29VeXcwankvNW40WkFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFIQUFBQUJ1RHdBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFRRUJBQUFBOXlGWHFnQ0FBUUFBQUFBQUFBQUFBSjRBQUFCaEFH?=
 =?us-ascii?Q?UUFaQUJ5QUdVQWN3QnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01BZFFCekFIUUFid0J0QUY4?=
 =?us-ascii?Q?QWNBQmxBSElBY3dCdkFHNEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQWdBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFHMEFYd0J3QUdnQWJ3QnVBR1VB?=
 =?us-ascii?Q?YmdCMUFHMEFZZ0JsQUhJQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJq?=
 =?us-ascii?Q?QUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QVpBQmhBSE1BYUFCZkFIWUFN?=
 =?us-ascii?Q?QUF5QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdB?=
 =?us-ascii?Q?QUFHTUFkUUJ6QUhRQWJ3QnRBRjhBY3dCekFHNEFYd0JyQUdVQWVRQjNBRzhB?=
 =?us-ascii?Q?Y2dCa0FITUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWXdCMUFITUFkQUJ2?=
 =?us-ascii?Q?QUcwQVh3QnpBSE1BYmdCZkFHNEFid0JrQUdVQWJBQnBBRzBBYVFCMEFHVUFj?=
 =?us-ascii?Q?Z0JmQUhZQU1BQXlBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFB?=
 =?us-ascii?Q?QUFBQUFBSUFBQUFBQUo0QUFBQmpBSFVBY3dCMEFHOEFiUUJmQUhNQWN3QnVB?=
 =?us-ascii?Q?RjhBY3dCd0FHRUFZd0JsQUY4QWRnQXdBRElBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFu?=
 =?us-ascii?Q?Z0FBQUdRQWJBQndBRjhBY3dCckFIa0FjQUJsQUY4QVl3Qm9BR0VBZEFCZkFH?=
 =?us-ascii?Q?MEFaUUJ6QUhNQVlRQm5BR1VBWHdCMkFEQUFNZ0FBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFaQUJzQUhBQVh3?=
 =?us-ascii?Q?QnpBR3dBWVFCakFHc0FYd0JqQUdnQVlRQjBBRjhBYlFCbEFITUFjd0JoQUdj?=
 =?us-ascii?Q?QVpRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCa0FHd0Fj?=
 =?us-ascii?Q?QUJmQUhRQVpRQmhBRzBBY3dCZkFHOEFiZ0JsQUdRQWNnQnBBSFlBWlFCZkFH?=
 =?us-ascii?Q?WUFhUUJzQUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1VBYlFCaEFHa0FiQUJmQUdFQVpB?=
 =?us-ascii?Q?QmtBSElBWlFCekFITUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBRXdBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQWJRQmhBSElBZGdCbEFHd0FYd0J3QUhJQWJ3QnFBR1VBWXdC?=
 =?us-ascii?Q?MEFGOEFiZ0JoQUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFB?=
 =?us-ascii?Q?YVFCaEFHd0FYd0JoQUd3QWJ3QnVBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdF?=
 =?us-ascii?Q?QWNnQjJBR1VBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdCdUFHRUFiUUJs?=
 =?us-ascii?Q?QUhNQVh3QnlBR1VBY3dCMEFISUFhUUJqQUhRQVpRQmtBRjhBWVFCc0FHOEFi?=
 =?us-ascii?Q?Z0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZUUJ5QUhZQVpRQnNBRjhB?=
 =?us-ascii?Q?Y0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUhJQVpRQnpB?=
 =?us-ascii?Q?SFFBY2dCcEFHTUFkQUJsQUdRQVh3Qm9BR1VBZUFCakFHOEFaQUJsQUhNQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBR0VBY2dCdEFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refthree: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFB?=
 =?us-ascii?Q?QUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QVp3QnZBRzhB?=
 =?us-ascii?Q?WndCc0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FB?=
 =?us-ascii?Q?QUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFZ?=
 =?us-ascii?Q?d0J2QUdRQVpRQnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFiUUJoQUhJQWRnQmxB?=
 =?us-ascii?Q?R3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdCakFHOEFaQUJsQUhNQVh3?=
 =?us-ascii?Q?QmtBR2tBWXdCMEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFB?=
 =?us-ascii?Q?QUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBY0FCeUFH?=
 =?us-ascii?Q?OEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUdNQWJ3QnVBR1lBYVFC?=
 =?us-ascii?Q?a0FHVUFiZ0IwQUdrQVlRQnNBRjhBYlFCaEFISUFkZ0JsQUd3QWJBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5n?=
 =?us-ascii?Q?QUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4?=
 =?us-ascii?Q?QWJnQmhBRzBBWlFCekFGOEFZd0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFhUUJo?=
 =?us-ascii?Q?QUd3QVh3QnRBR0VBY2dCMkFHVUFiQUJzQUY4QWJ3QnlBRjhBWVFCeUFHMEFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29BWlFCakFI?=
 =?us-ascii?Q?UUFYd0J1QUdFQWJRQmxBSE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRBZEFC?=
 =?us-ascii?Q?cEFHRUFiQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3Qm5BRzhB?=
 =?us-ascii?Q?YndCbkFHd0FaUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNn?=
 =?us-ascii?Q?QjJBR1VBYkFCc0FGOEFjQUJ5QUc4QWFnQmxBR01BZEFCZkFHNEFZUUJ0QUdV?=
 =?us-ascii?Q?QWN3QmZBSElBWlFCekFIUUFjZ0JwQUdNQWRBQmxBR1FBWHdCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQnNBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdC?=
 =?us-ascii?Q?d0FISUFid0JxQUdVQVl3QjBBRjhBYmdCaEFHMEFaUUJ6QUY4QWNnQmxBSE1B?=
 =?us-ascii?Q?ZEFCeUFHa0FZd0IwQUdVQVpBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZB?=
 =?us-ascii?Q?SElBWHdCaEFISUFiUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSFFBWlFCeUFHMEFhUUJ1?=
 =?us-ascii?Q?QUhVQWN3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VB?=
 =?us-ascii?Q?Y2dCMkFHVUFiQUJzQUY4QWR3QnZBSElBWkFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQWNBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUEiLz48L21ldGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|DS0PR18MB5339:EE_
x-ms-office365-filtering-correlation-id: e9862cf3-55a2-455c-2927-08dba20c8fca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0SwgERdJ5YND1/4hbjZaVDHxJJ1TVrU6z45PZs4RqSdOW40LJ2iqSw1RyiXi83WSSj84XdcjzTu7HwuxgM8wdgRelROJMra3IIs95EGV1Z+Y+OcRwkD1eWaliu9ZPrefCwnK988braGwtNweM9i7VO6rToOzN4ClK2Y9RaJv6I4qQCVrraLQk5Q3HB/iDNfFBdvPMKEJ+a3DUt2JMhTQ2oa+jWowZddltL0sMHNVy0A+Q0clUp3G5nOlnROIrkjZaugkcwjeJZbg+pPYAVhfQAmfr23HiVSH2igydsoJA9/s5l7hhGMZLxk7WrQwjuGZMWkBDHbCgguuhuTE5uEjmLVpXS1omaGwPrUIvi83UNbIUPS32PwASvNaoLvAtwB7s2bvDrBOPl1nDm6U6A3KG9snU9DioI2R4DWstCz9EGa6MoF+nh4qTvf0wTz6WMCKHE5CkSDxyVbp7atML40H4JYIyhTxDYLiaopm8+HSJaIwAgSgK02o8L7CiqI5s0D9bl/3TMXI7O1Q6fbaQYB4LTxmv/HoI+tBZYhDW8eJCw/eiYuCZLfgPqL/ytUt9FfKMxx59eSJ7J3bkeEvCLhuo3WxN+vOOQD2spKKLNGnf+mp18rwXLpgRaGljGubupPC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199024)(186009)(1800799009)(2906002)(83380400001)(53546011)(38070700005)(7696005)(38100700002)(6506007)(15650500001)(5660300002)(52536014)(33656002)(26005)(86362001)(8676002)(8936002)(107886003)(4326008)(316002)(9686003)(66946007)(64756008)(6916009)(54906003)(66446008)(66556008)(66476007)(76116006)(478600001)(122000001)(55016003)(71200400001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V3b+C0QaCe49ps2Rezn9XuPNuY56g8rcWHDltdkIRuznVocR4cRNsOX4KSLk?=
 =?us-ascii?Q?P/quEM4XpT5vpNMKIyfPH2BgljZ4hAp4D968p4zkGmMv0CERTHY59/8eIBsz?=
 =?us-ascii?Q?sq770t2rUBXIFZWtHPZYeHdqBggrn4dqXiOOO1QnnBOlqnF4VUnxvdzynGRJ?=
 =?us-ascii?Q?O4ewuALGWZIIRetPOK7PLhmWdsVMuRs0lqMkecBwpnVcPyCKkgOn1+h7VnaO?=
 =?us-ascii?Q?jGA6sIzQ8YjpvEtPoTw5DNCtW53TmeCFpDPWqhzqW/4qSacgCgSfXzDWYRvr?=
 =?us-ascii?Q?oncMzFooOYqsBxwFYbINuwTJdL3nwPX71K37rSv4QkAu3NrBR0kW3MtHmRp2?=
 =?us-ascii?Q?WiVDnRvaK3GtC6bfgLmcSfA9Ci25C6b+lqQ6+Vf9ACyX43IFFa3rjCnoRx5L?=
 =?us-ascii?Q?k54WbpYP+tV3HO/i3mtk19+z+M7RKcxGGgshw6k+J3MFJbC2vmpRniU5ldNN?=
 =?us-ascii?Q?QDcp8/WDDEzKzeBGO7FPl6BzqemD+Q50zq7tDHfSLOUnFEwCUaPN880kzNu7?=
 =?us-ascii?Q?Da0ZUMj1+uHIvCC8jDzsd541mVJUZCUUqZgAwZOG7/WULc3ZJjrsKM77R2KO?=
 =?us-ascii?Q?xoG7dWjwtwEhjIYJv9FgHAIg98P63mPEsY0fbhvFyjSa/oWRoKqxQiQLs5Qi?=
 =?us-ascii?Q?f2g6YX9l5TS8ZDYcypdypYYkT7WXX2ZzH8COneKvEB7NdD60AzNfYF5pSn2L?=
 =?us-ascii?Q?wgmyN1+DOsp9XrOKC5nMgvLaL2fJZFBh0i9L/WBOuzO9RhAPktDD9p6D1LNK?=
 =?us-ascii?Q?eFa6A5j4yqFafdXdSuv77Y13lnP3lE2EQnaAV1/of4st5XLSBDkQuIHJbNqf?=
 =?us-ascii?Q?RXXgUxYosAWQkxbmfmBXVG3Yr2Fg6tx/YTx5MfjSfBqldB3m9YvA9wbZSSaz?=
 =?us-ascii?Q?ChYRa6HhbwogeaXqKdJRJv336969E4xJZJv8d3ZvkHBJ0tiENO3w1u9Z4hZA?=
 =?us-ascii?Q?IxChfSyyUhS2Muqrrv5Zz4KO467vSHmYkGjExTjWRXqMRutuAWGw2cQskNcd?=
 =?us-ascii?Q?M5Lzt9QfznexDYdCx9GV1ljrg7LszRsjOH2N6zUN9Ss6rA4kSr0MlvyAGjiN?=
 =?us-ascii?Q?fc8iwr+JjGEe7hX/PWM1DQ+oth/Vruy2Ya4/1gX0LCBCGaWWdEnYvaWr5kPg?=
 =?us-ascii?Q?+OEcg2sYQ4RXXqf3Dopb9pnh1Sw9dzsqdPxZDRJPw8l40UNSNrCc5JE8SpSZ?=
 =?us-ascii?Q?fHo3CWpFSrxO3Sud63fOvzUl2cTkoK+XsnnHyWm78NEKgnDTmLfrRG2VEvio?=
 =?us-ascii?Q?u01dizaPXOBygk0jJ1fiWjI3RPCyyMDKFgkTNjwsj2EsofTrvL75AE8P6cnX?=
 =?us-ascii?Q?J9F+97QPLI6OiFByr34Z+iWKsZaHnTPrk6QPfAg3NWXxdEye3mTzvVdQRNXe?=
 =?us-ascii?Q?fxnDSFtq/T/LFTWH+vJKHl5sh2pM8x48A5xcntzvY97eAiWhrLkEDeNq4A6g?=
 =?us-ascii?Q?HunQc+qvheE4qaZxNTSg8lryojSv+AtXguoSzGlxP6s8muM3ByGDa0XS3ZL/?=
 =?us-ascii?Q?IxZpPZsgMgXXE2Fs0AwK3C+qynzntWHcKurku7ZjmgjR19Efwh6Z3hPoDNBU?=
 =?us-ascii?Q?yb1Js2vNe1gsBL41A9IvU8tG612CokiZOgrxwVCy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9862cf3-55a2-455c-2927-08dba20c8fca
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 06:05:03.8240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kLeOY4CHAitIDW8EtCKnojH1eBSSAO4RNWuKiuFxezfF8d0xSQqMo6WQEtZ/3uZXo95FUxse9wjmh6IrPd03ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR18MB5339
X-Proofpoint-GUID: 8sjN0lqJMP0ZLuzGOq10dThjRjwEEVDm
X-Proofpoint-ORIG-GUID: 8sjN0lqJMP0ZLuzGOq10dThjRjwEEVDm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-20_15,2023-08-18_01,2023-05-22_02
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Saturday, August 19, 2023 12:19 AM
> To: Sai Krishna Gajula <saikrishnag@marvell.com>
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Sunil Kovvuri Goutham <sgoutham@marvell.com>;
> Geethasowjanya Akula <gakula@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>;
> richardcochran@gmail.com; kalesh-anakkur.purayil@broadcom.com; Naveen
> Mamindlapalli <naveenm@marvell.com>
> Subject: Re: [net-next PATCH v3] octeontx2-pf: Use PTP HW timestamp
> counter atomic update feature
>=20
> On Thu, Aug 17, 2023 at 11:13:51PM +0530, Sai Krishna wrote:
> > Some of the newer silicon versions in CN10K series supports a feature
> > where in the current PTP timestamp in HW can be updated atomically
> > without losing any cpu cycles unlike read/modify/write register.
> > This patch uses this feature so that PTP accuracy can be improved
> > while adjusting the master offset in HW. There is no need for SW
> > timecounter when using this feature. So removed references to SW
> > timecounter wherever appropriate.
> >
> > Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> > Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> > Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> > Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > ---
> > v3:
> >     - Addressed review comments given by Jakub Kicinski
> >         1. Fixed re-ordering of headers in alphabetical order
> >         2. Refactored SoC revision identification logic
> >         3. CN10K errata revisions can be different from atomic update
> >            supported revision devices.
> >         4. Removed ptp device check.
> > v2:
> >     - Addressed review comments given by Simon Horman, Kalesh Anakkur
> Purayil
> > 	1. Removed inline keyword for function in .c file
> >         2. Modified/optimized conditions related boolean
> >
> >  .../net/ethernet/marvell/octeontx2/af/mbox.h  |  12 ++
> >  .../net/ethernet/marvell/octeontx2/af/ptp.c   | 155 ++++++++++++++--
> >  .../net/ethernet/marvell/octeontx2/af/ptp.h   |   3 +-
> >  .../net/ethernet/marvell/octeontx2/af/rvu.c   |   2 +-
> >  .../net/ethernet/marvell/octeontx2/af/rvu.h   |  12 ++
> >  .../marvell/octeontx2/nic/otx2_common.h       |   1 +
> >  .../ethernet/marvell/octeontx2/nic/otx2_ptp.c | 174
> > ++++++++++++++----
> >  7 files changed, 304 insertions(+), 55 deletions(-)
>=20
> <...>
>=20
> > +static bool is_tstmp_atomic_update_supported(struct otx2_ptp *ptp) {
> > +	struct ptp_get_cap_rsp *rsp;
> > +	struct msg_req *req;
> > +	int err;
> > +
> > +	if (!ptp->nic)
> > +		return false;
> > +
> > +	mutex_lock(&ptp->nic->mbox.lock);
> > +	req =3D otx2_mbox_alloc_msg_ptp_get_cap(&ptp->nic->mbox);
> > +	if (!req)
> > +		return false;
> > +
> > +	err =3D otx2_sync_mbox_msg(&ptp->nic->mbox);
> > +	if (err)
> > +		return false;
>=20
> Shouldn't you call to mutex_unlock() in two returns above?

Ack, will submit V4 patch.

Thanks
Sai
>=20
> Thanks
>=20
> > +
> > +	rsp =3D (struct ptp_get_cap_rsp *)otx2_mbox_get_rsp(&ptp->nic-
> >mbox.mbox, 0,
> > +							  &req->hdr);
> > +	mutex_unlock(&ptp->nic->mbox.lock);
> > +
> > +	if (IS_ERR(rsp))
> > +		return false;
> > +
> > +	if (rsp->cap & PTP_CAP_HW_ATOMIC_UPDATE)
> > +		return true;
> > +
> > +	return false;
> > +}
