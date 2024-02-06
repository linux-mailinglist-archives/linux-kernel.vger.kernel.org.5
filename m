Return-Path: <linux-kernel+bounces-55459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA57E84BCF1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEDE01C23D0F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6C233CE;
	Tue,  6 Feb 2024 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="JVI0DTAO"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069DA28F5;
	Tue,  6 Feb 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707244213; cv=fail; b=jmLyYwPXZAuQYH7EfhoBMRyf7o1kRjgyPKZUTrSiiCu9hzMjpuLt1oP/C0+1zsTnnZ8O1ytaFWr974WsgrIqgpHxCDl4HGI7MSVmSr+PM1gApXRDGpWaedMVYN7bJedgcA8eNUsrkbBqKy2MVAfQHI1Gt1bH3NbpQ25qkiyFXxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707244213; c=relaxed/simple;
	bh=d384Sou3SONIOf99HmGfIv3q1Ov9DNtc1/VU/DyTefU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fuony73u7tWtJ0M11bhIl2/7zfHyp296pUVFcLxUaX2GJFzmlcWUOVNOg/EmLUWZxeEKZZXPbphlAgHVnu29a4VEfs3MZwLfNvI6GHTq2zpzIQzs/CXFWa++7JUdMNngP3o7iE+Zhraw0OGNP8hZ1UXqK2XXGTx0+GUd1GObBEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=JVI0DTAO; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 416DpfBX007435;
	Tue, 6 Feb 2024 10:29:58 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3w38u83f66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 10:29:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xb2o+MBVxnz+rmWQmxaCZHyuP9khiAwMzia0OzENUWD2kds3xnI1m0K+OQ01cqYKXQgbxEhtyX9xbqOWwCXU1kLqAs7zWkemuYVeOB2ZrhL/QhavV+pe8eaj4c4VajuV/3k3mTMCFCvgzOPMlHedqVMQmre7x8a6+T+hifwTZF116toJRD63LxwTRkYQtvAregj759d3D/9MzcA9EPPxKY7rFEeZCp8QlfWG/r+TMEH6A8oGc3yIT+oUvBbTcg/DkGniGIrXJJD0AVpzo44QwAnEQJBlBe0g0P5kFDrR13+ArlDKII7nVtExhK8/Ch0VgbmjMGI2vwWOKUSdeS69ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rf4U7JXHOM5nsdsU4gvxdJt3c00VP9WYK1YebwwgSN0=;
 b=lfSnLlxG2Edwb0OtpomBKRTmpEiKScIgsFQobhxDO9CMsv1jFxqc6enMIfyhcCUsBkcvjMba0mfUxV+kDyl/lIuaBd6NP6Lq/yw4oKoiKRr4Cx8ufkk9lxRGNw7Jiv8V487Cys3vhrMKgf8JcoqjRTBFvpSBKAruUvIfn+v14cY0vG4s+WYfhvEor4vS070/LNo0ezUpAJO/PS0YcussgAb+qrmYMLXNQ7iLPCVXaf6d1xyXn0lJ7XWXQhU3E/yFGIMffSE9/KTMIqd0oKUUzsSsd54A4iCv1UY7NzzuqmuR3RfSp2czE2OHJ+SoTYqIGZZ0/05/P3J1gU/5WGyibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf4U7JXHOM5nsdsU4gvxdJt3c00VP9WYK1YebwwgSN0=;
 b=JVI0DTAOYF4FWIRdU+g3JqBUHhqIch2fMTY6IGUYEEOytiSwTzVf30UGPVu96Bvqm1Vr7D+/6VOCsQIeQpWz5dK6R+v5Cv3+FNDGdZJaiDBXYHHKkrU/7nlCcRcbcey+StkuK7hT7R5CgwS6Ui0y87ZL1mXlsC2H9dlFrNqcDDk=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by CH3PR18MB6028.namprd18.prod.outlook.com (2603:10b6:610:1dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 18:29:53 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::3cca:92a0:1e88:5f24]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::3cca:92a0:1e88:5f24%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 18:29:53 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>
Subject: RE: [net-next PATCH] octeontx2-pf: Reset MAC stats during probe
Thread-Topic: [net-next PATCH] octeontx2-pf: Reset MAC stats during probe
Thread-Index: AQHaUpimwvoWGDyRoEKlOp7YcAsKuLD9qxHA
Date: Tue, 6 Feb 2024 18:29:52 +0000
Message-ID: 
 <BY3PR18MB470744E7FFCCC1B38A0B4E8AA0462@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240125110601.124209-1-saikrishnag@marvell.com>
 <20240125172803.01189ac4@kernel.org>
 <BY3PR18MB47071D86D89384FFA46286D3A07E2@BY3PR18MB4707.namprd18.prod.outlook.com>
In-Reply-To: 
 <BY3PR18MB47071D86D89384FFA46286D3A07E2@BY3PR18MB4707.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2Fpa3Jpc2hu?=
 =?us-ascii?Q?YWdcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?us-ascii?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy1iNTliMzA0YS1jNTFkLTExZWUtYWQzMC0x?=
 =?us-ascii?Q?Y2MxMGM0MGQ5ZTRcYW1lLXRlc3RcYjU5YjMwNGItYzUxZC0xMWVlLWFkMzAt?=
 =?us-ascii?Q?MWNjMTBjNDBkOWU0Ym9keS50eHQiIHN6PSI0MzAyIiB0PSIxMzM1MTcxNzc4?=
 =?us-ascii?Q?OTk4NzgyOTYiIGg9Ik1NdVloT29hSWRBem5wUTNocVZjcHF4MmREUT0iIGlk?=
 =?us-ascii?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUJn?=
 =?us-ascii?Q?V0FBQ1loeUo0S2xuYUFkYzMwcWtaUm51RTF6ZlNxUmxHZTRRWkFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFIQUFBQUJ1RHdBQTNnOEFBRG9HQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFRRUJBQUFBOXlGWHFnQ0FBUUFBQUFBQUFBQUFBSjRBQUFCaEFH?=
 =?us-ascii?Q?UUFaQUJ5QUdVQWN3QnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01BZFFCekFIUUFid0J0QUY4?=
 =?us-ascii?Q?QWNBQmxBSElBY3dCdkFHNEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFHMEFYd0J3QUdnQWJ3QnVBR1VB?=
 =?us-ascii?Q?YmdCMUFHMEFZZ0JsQUhJQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJq?=
 =?us-ascii?Q?QUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QVpBQmhBSE1BYUFCZkFIWUFN?=
 =?us-ascii?Q?QUF5QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-refone: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
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
x-dg-reftwo: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCa0FHd0Fj?=
 =?us-ascii?Q?QUJmQUhRQVpRQmhBRzBBY3dCZkFHOEFiZ0JsQUdRQWNnQnBBSFlBWlFCZkFH?=
 =?us-ascii?Q?WUFhUUJzQUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1VBYlFCaEFHa0FiQUJmQUdFQVpB?=
 =?us-ascii?Q?QmtBSElBWlFCekFITUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBRlFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
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
x-dg-refthree: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
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
x-dg-reffour: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFPZ1lBQUFBQUFBQUlBQUFBQUFBQUFBZ0FB?=
 =?us-ascii?Q?QUFBQUFBQUNBQUFBQUFBQUFBYUJnQUFHUUFB?=
x-dg-reffive: 
 =?us-ascii?Q?QUJnQUFBQUFBQUFBWVFCa0FHUUFjZ0JsQUhNQWN3QUFBQ1FBQUFBQUFBQUFZ?=
 =?us-ascii?Q?d0IxQUhNQWRBQnZBRzBBWHdCd0FHVUFjZ0J6QUc4QWJnQUFBQzRBQUFBQUFB?=
 =?us-ascii?Q?QUFZd0IxQUhNQWRBQnZBRzBBWHdCd0FHZ0Fid0J1QUdVQWJnQjFBRzBBWWdC?=
 =?us-ascii?Q?bEFISUFBQUF3QUFBQUFBQUFBR01BZFFCekFIUUFid0J0QUY4QWN3QnpBRzRB?=
 =?us-ascii?Q?WHdCa0FHRUFjd0JvQUY4QWRnQXdBRElBQUFBd0FBQUFBQUFBQUdNQWRRQnpB?=
 =?us-ascii?Q?SFFBYndCdEFGOEFjd0J6QUc0QVh3QnJBR1VBZVFCM0FHOEFjZ0JrQUhNQUFB?=
 =?us-ascii?Q?QStBQUFBQUFBQUFHTUFkUUJ6QUhRQWJ3QnRBRjhBY3dCekFHNEFYd0J1QUc4?=
 =?us-ascii?Q?QVpBQmxBR3dBYVFCdEFHa0FkQUJsQUhJQVh3QjJBREFBTWdBQUFESUFBQUFB?=
 =?us-ascii?Q?QUFBQVl3QjFBSE1BZEFCdkFHMEFYd0J6QUhNQWJnQmZBSE1BY0FCaEFHTUFa?=
 =?us-ascii?Q?UUJmQUhZQU1BQXlBQUFBUGdBQUFBQUFBQUJrQUd3QWNBQmZBSE1BYXdCNUFI?=
 =?us-ascii?Q?QUFaUUJmQUdNQWFBQmhBSFFBWHdCdEFHVUFjd0J6QUdFQVp3QmxBRjhBZGdB?=
 =?us-ascii?Q?d0FESUFBQUEyQUFBQUFBQUFBR1FBYkFCd0FGOEFjd0JzQUdFQVl3QnJBRjhB?=
 =?us-ascii?Q?WXdCb0FHRUFkQUJmQUcwQVpRQnpBSE1BWVFCbkFHVUFBQUE0QUFBQUFBQUFB?=
 =?us-ascii?Q?R1FBYkFCd0FGOEFkQUJsQUdFQWJRQnpBRjhBYndCdUFHVUFaQUJ5QUdrQWRn?=
 =?us-ascii?Q?QmxBRjhBWmdCcEFHd0FaUUFBQUNRQUFBQVZBQUFBWlFCdEFHRUFhUUJzQUY4?=
 =?us-ascii?Q?QVlRQmtBR1FBY2dCbEFITUFjd0FBQUZnQUFBQUFBQUFBYlFCaEFISUFkZ0Js?=
 =?us-ascii?Q?QUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4QWJnQmhBRzBBWlFCekFGOEFZ?=
 =?us-ascii?Q?d0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFhUUJoQUd3QVh3QmhBR3dBYndCdUFH?=
 =?us-ascii?Q?VUFBQUJVQUFBQUFBQUFBRzBBWVFCeUFIWUFaUUJzQUY4QWNBQnlBRzhBYWdC?=
 =?us-ascii?Q?bEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFISUFaUUJ6QUhRQWNnQnBBR01B?=
 =?us-ascii?Q?ZEFCbEFHUUFYd0JoQUd3QWJ3QnVBR1VBQUFCYUFBQUFBQUFBQUcwQVlRQnlB?=
 =?us-ascii?Q?SFlBWlFCc0FGOEFjQUJ5QUc4QWFnQmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3?=
 =?us-ascii?Q?QmZBSElBWlFCekFIUUFjZ0JwQUdNQWRBQmxBR1FBWHdCb0FHVUFlQUJqQUc4?=
 =?us-ascii?Q?QVpBQmxBSE1BQUFBZ0FBQUFBQUFBQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0Jo?=
 =?us-ascii?Q?QUhJQWJRQUFBQ1lBQUFBQUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFHY0Fi?=
 =?us-ascii?Q?d0J2QUdjQWJBQmxBQUFBTkFBQUFBQUFBQUJ0?=
x-dg-refsix: 
 =?us-ascii?Q?QUdFQWNnQjJBR1VBYkFCc0FGOEFjQUJ5QUc4QWFnQmxBR01BZEFCZkFHTUFi?=
 =?us-ascii?Q?d0JrQUdVQWN3QUFBRDRBQUFBQUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFI?=
 =?us-ascii?Q?QUFjZ0J2QUdvQVpRQmpBSFFBWHdCakFHOEFaQUJsQUhNQVh3QmtBR2tBWXdC?=
 =?us-ascii?Q?MEFBQUFYZ0FBQUFBQUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhB?=
 =?us-ascii?Q?YWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFRQmtB?=
 =?us-ascii?Q?R1VBYmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFBQUd3QUFB?=
 =?us-ascii?Q?QUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhR?=
 =?us-ascii?Q?QVh3QnVBR0VBYlFCbEFITUFYd0JqQUc4QWJnQm1BR2tBWkFCbEFHNEFkQUJw?=
 =?us-ascii?Q?QUdFQWJBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZBSElBWHdCaEFISUFi?=
 =?us-ascii?Q?UUFBQUhJQUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dCdkFH?=
 =?us-ascii?Q?b0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFITUFYd0JqQUc4QWJnQm1BR2tBWkFC?=
 =?us-ascii?Q?bEFHNEFkQUJwQUdFQWJBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZBSElB?=
 =?us-ascii?Q?WHdCbkFHOEFid0JuQUd3QVpRQUFBRm9BQUFBQUFBQUFiUUJoQUhJQWRnQmxB?=
 =?us-ascii?Q?R3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdCdUFHRUFiUUJsQUhNQVh3?=
 =?us-ascii?Q?QnlBR1VBY3dCMEFISUFhUUJqQUhRQVpRQmtBRjhBYlFCaEFISUFkZ0JsQUd3?=
 =?us-ascii?Q?QWJBQUFBR2dBQUFBQUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2?=
 =?us-ascii?Q?QUdvQVpRQmpBSFFBWHdCdUFHRUFiUUJsQUhNQVh3QnlBR1VBY3dCMEFISUFh?=
 =?us-ascii?Q?UUJqQUhRQVpRQmtBRjhBYlFCaEFISUFkZ0JsQUd3QWJBQmZBRzhBY2dCZkFH?=
 =?us-ascii?Q?RUFjZ0J0QUFBQUtnQUFBQUFBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBZEFC?=
 =?us-ascii?Q?bEFISUFiUUJwQUc0QWRRQnpBQUFBSWdBQUFBQUFBQUJ0QUdFQWNnQjJBR1VB?=
 =?us-ascii?Q?YkFCc0FGOEFkd0J2QUhJQVpBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|CH3PR18MB6028:EE_
x-ms-office365-filtering-correlation-id: dba4fb30-f596-4c72-7921-08dc27419c6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 mz9rwlFEhrKwODdK6UgPKCvl8ND3FUR8RfuVYWcd2SfB/z166b+NULJp5MbECIRMwsbiRjICXGuquFxSDo3gYa3gj126lKtMI7yRa6pbliozjEYnGho79Q1ygcjoYlysKXG1O9uc3o7lplWKuaNmr7sr42m88LnrbKBFfqIZauZ4bR1NmLR1Xr/i7K3EHxOFbcuppH3BM7JvOowC2mSX4SmS+UfAJsz+BLu6/KLIDldddh209p1bwnKTMG8YMF6SYFn9voI4fVJIQAm+dUTsNlCWf5WA8RgavoSUAay+VApNfOvqcfjn0EjC/lIPRN9GN4Krgu0vr4Te9wEe8NMXrFSdCklIm/fXxeZLWvUYhC72brQyB3DXeLfOg3jaibKne9rvggPPZg0BABfO6FD5fUy5h+VkLPTaj9ZKW3X3w1j3VsaZJoXM8PcaDP+BjaSUFV3IOcXaLFy2v4gR23CjipjzQFAdp+uSNITilqdE2ucovomJJDpnA7EGq1yfozk6g6T6Zi6Ij5XLr4j6/HQriT6zpsUoSQOAnCZ5UfMY1SAoBvnGKak49Zmg3yhvHWoJ7zhaa/qaCZahxggimIPnpclhKSPk08n0ydp2JgmYlMnQt7i/6TDvrPjOUuGMTdRa
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(2906002)(5660300002)(38100700002)(7696005)(83380400001)(122000001)(478600001)(64756008)(66476007)(66446008)(66556008)(6916009)(8936002)(54906003)(66946007)(26005)(76116006)(316002)(8676002)(107886003)(6506007)(4326008)(71200400001)(9686003)(52536014)(53546011)(86362001)(33656002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ug44lmgyJs+wCn8W4kw7eCIvfC3Zr2DQEMTGG+0AQ52udZcj0R35unBsJRwv?=
 =?us-ascii?Q?+uHiLxRgc4ogFeyxxWtKbG+fY1nruaP4Eu+kEBM91tRKOWBsBxFFCDP99efi?=
 =?us-ascii?Q?brulQo+57ABBaIVJve+G7LTal5O/1iMYMRQzO80sbdJ5ndLzVgQvC20z9c4f?=
 =?us-ascii?Q?5F+gzVnPVtoHKepiSYDTdlsWOtTtPbNoshArmX6dVWquUnWrXKqkDV7K0Pr8?=
 =?us-ascii?Q?eOz9FAaEwl1T96ubY4oYZQyZjGY9UJYYf8/GxQfNQB57OFKxxKJuz5Pe54i3?=
 =?us-ascii?Q?OjYm2DwDy6gL4l4igvA/XTr4agAQwxho9xRVGF2AylQVVwH6sPTkfDEJDS8k?=
 =?us-ascii?Q?QbNepBfhIGDzZLxcYLqwV0zN7QNNeDMOj0c2VfBCOgfXhmoRBMHVLd1v+ASc?=
 =?us-ascii?Q?X/3pcKhwoC0IfkOwMAANzUchMCvMFm9jTMIK44t0JzlwNWQPCc2UznbY7mtg?=
 =?us-ascii?Q?2+URrA57TpiB1xGU1A4HSCCbnai1UHwlF9Wp7ram8mML9w5R0jfyOqu2LE1l?=
 =?us-ascii?Q?RsyxHCWnpLdHMaWGFgBrmV0gSKMuY9+d0cTbdKsaEqkuk4lhjOQdo0xMIwvN?=
 =?us-ascii?Q?8Zc3hiAw3n7uZJex3Um2N2aC97EBsPjL3LgbQZR9Nd3rk6GCgQQ20Ef8c/zq?=
 =?us-ascii?Q?rkJQqGkieOuxNodO9rjJh3x6FXonZsymKljrRDFaTKtzuKdJ6DBVs3runjpz?=
 =?us-ascii?Q?uM4mleHN3J/ieR4wSQHn7fC0FvbYXrRKDUwVHoLHzKkzE6lhBDdSncouw/BM?=
 =?us-ascii?Q?tKnhFejdhGutraQValEmEzeTmsyuL4MCyjPQ+RrCE4mMUET0ECkc1Q6ZUNmy?=
 =?us-ascii?Q?UwsymKZDy+4nXhV+sJnc6tInfQZg1oBylt52Hmylo7LijmlWYYzqBtOCjBqh?=
 =?us-ascii?Q?jCZgYCguD1DR9lJgLfAYDYnm7Two77MIz9xKydXCdx5SNE3hVwQeLavf50K0?=
 =?us-ascii?Q?oqgXbfgS8XD7EaxjowKUA6y8YcP8PatDyXZAVzl4NYMOUCE2IlsjuA6FySou?=
 =?us-ascii?Q?Bp6eoDnpc57qBfyAC/tXoHqRpD6wtj5izjoCzniYVM2jlVKqsfTzwMxnnsoP?=
 =?us-ascii?Q?686ml+78fwx6UICEPI24pecHsBIjsVtwfhZWY4FG5GVfCTVdqsznCw5TMreT?=
 =?us-ascii?Q?NIZJwAUOP4HtqQEGNMJPXLrzbQYuWAwM29mgJjwHu5llDTvwkqBFM4bhQBFu?=
 =?us-ascii?Q?wOr+4VZcK39jPKWj4hQypaDETra4rmCjMJ94F5kAAfo3WrNqlINsTZm1XNpk?=
 =?us-ascii?Q?vq2/9ZXOGVYZmjLpKfnDpy/94G09+saflqRnqQ2ZqpzcfvUhtgAtNoE475y3?=
 =?us-ascii?Q?meZJm6luU0umB72sg96Re+Sh4Mzdi8U0QjCSASKV/1Xd6kQ7Hc+ISUkNMp3Q?=
 =?us-ascii?Q?OuOJVH0PYQlqs4b5A3qNYiJUWabbJdXFxj/DGggHX9Mx5L6n95uiflexAkIx?=
 =?us-ascii?Q?6I/43KG2rZpe4ToI6QUfEDplZyb/UtraS8NuBxi3OEhneshJNdf5fl1bMAj7?=
 =?us-ascii?Q?SPg/sp72lTh/M108V6AJO5wyW8e8xarCwthT6FVG8f2HLU+YmLhldWYoK7HU?=
 =?us-ascii?Q?jgRl5FuyD6Tut9vdy9R8te+oR4cYQU0xpRBgKwYC?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba4fb30-f596-4c72-7921-08dc27419c6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 18:29:53.0213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WsEZ2zG+Z5WHgPf4A1ybJE9Bc7uajJGROjbLgFq75zVfMWExJiR5pV6sP7sKKiErNx+V7W/MPIwa4liWI4vA2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB6028
X-Proofpoint-ORIG-GUID: 7Vh1uKYIi2MsVsJ_H0Ph_arp7LLqu-rO
X-Proofpoint-GUID: 7Vh1uKYIi2MsVsJ_H0Ph_arp7LLqu-rO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_11,2024-01-31_01,2023-05-22_02

> -----Original Message-----
> From: Sai Krishna Gajula
> Sent: Monday, January 29, 2024 3:21 PM
> To: Jakub Kicinski <kuba@kernel.org>
> Cc: davem@davemloft.net; edumazet@google.com; pabeni@redhat.com;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri
> Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> <gakula@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>;
> Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
> Subject: Re: [net-next PATCH] octeontx2-pf: Reset MAC stats during probe
>=20
>=20
> > -----Original Message-----
> > From: Jakub Kicinski <kuba@kernel.org>
> > Sent: Friday, January 26, 2024 6:58 AM
> > To: Sai Krishna Gajula <saikrishnag@marvell.com>
> > Cc: davem@davemloft.net; edumazet@google.com; pabeni@redhat.com;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri
> > Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> > <gakula@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>;
> Subbaraya
> > Sundeep Bhatta <sbhatta@marvell.com>
> > Subject: Re: [net-next PATCH] octeontx2-pf: Reset MAC stats during
> > probe
> >
> > On Thu, 25 Jan 2024 16:36:01 +0530 Sai Krishna wrote:
> > > Reset CGX/RPM MAC HW statistics at the time of driver probe()
> > >
> > > Also added a devlink option to do the same at runtime, this will be
> > > helpful during debug.
> > >
> > > Usage: Reset MAC stats
> > > devlink dev param  set  pci/0002:03:00.0 name mac_stats_reset value
> > > true cmode runtime
> >
> > Where are the stats reported? It'd be more intuitive to add the
> > ability to reset stats to whatever interface is used to report them.
> > Or one of your reset interfaces (devlink dev reload).
>=20
> We are using debugfs interface to report the stats. As you had indicated
> previously not to take input to debugfs, we implemented devlink interface=
 to
> reset the MAC stats.

If you recommend us to implement the reset MAC stats using debugfs instead =
of devlink, we will implement the same and submit patch V2, please suggest.

Thanks,
Sai

