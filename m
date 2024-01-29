Return-Path: <linux-kernel+bounces-42963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09D084095A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 037C6B2317E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA31153BC1;
	Mon, 29 Jan 2024 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="gT/D/i5i"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FDA1534FA;
	Mon, 29 Jan 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540936; cv=fail; b=VSjllGfT0fiDmtBOBrRmpoNhS1Ty3CtT7loiUVoUvbyTNbRTMm6eFOoIzPi/yrEKYTvrTVTcbKtTclS/QKvKuf0sMQMDOfr4RGER2vu1ENoEhHn96onZirEKAGyM8Bcf/VU6bKmvFyy0L0Pvr/zLcEA5FozPlQqs4C8XEmGLLyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540936; c=relaxed/simple;
	bh=BV4Deh+APfHvbPIvZCvkHyHkXmfWQyaPFk8sMXLOrzo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u57wbL4fho5sozSXJq1cYdsjiGYk/XesDn/1NjTuss9Y0/AQw1F2y9CjIHa2xcaJC9cM6Rg0PSZ6D0ApTZMoLVB72B+N9Su/nWP5NgBxkymv/sIAYGG9Tmfu5xG2jLcDt3Oehltkxunq4PhW5GLCvogrcyW6HNm3LvX85/TFhG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=gT/D/i5i; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T4JNVs026741;
	Mon, 29 Jan 2024 07:08:48 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vx4vr9mpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 07:08:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzzMCV8ESnU36IctzK2GT6NS0Rq8mXdghpok2ADjXR75xE1NacPbm1bzgEQSZ7NVmoKUzkiKJaOrVCsUoxFt7nw9kyOe1CI5AqW5hTcFKbAasO0e8XKPIdoGOl7a7WzJq5Co1lV2xdSIkxhgyMP4TXoFEBLPmgmcz/ExRpvF3J2jxxEOCvhxtD/s37EEyL1AW6eCXmn54Qrm06oWYLSmIc5yuPSY7xNSrmqos0AkGCRT3WA6bf8G5RBbvutMRhi4CsIuM2g9TC7DWmrQ/hYdSD663jF6HuOy5EZnhMJIlWUj0oE/hf5NtzPLxtKHxQD1Q8doGhtqvN2A6deVd83MlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BV4Deh+APfHvbPIvZCvkHyHkXmfWQyaPFk8sMXLOrzo=;
 b=ZRjhKosVYGtib2pqvXl2TEeiFLjGzC4xSkBfLT3ym+6vmFpjLMKv4JewTZnjL5iCVgRzw1JhS25ec6UjPSfOfpDgFFb+UlCjJ6Y+NRM8IhkuMATESv6nXdtewP63hGy5yTYN+kEPOkU2/uBq5ftl6SFnFZ5Ou94as1UaN7KM5ZFsYavOnbg8IUM7wUIuoZxe+kD8hA8GEW7+80xqfGtrGfYc8/OZje4AGMqu9Jmeur7Nc6Bbc+dzcSDlXdExv3ZCBE2rV4f1HHEAZ2I/oO1Fuwbo5KMpVEk9D26GIO8Y14Ht3r0aapjqgpCgwlR0cbIgE2/TjoylWeRsIOngzRLrkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BV4Deh+APfHvbPIvZCvkHyHkXmfWQyaPFk8sMXLOrzo=;
 b=gT/D/i5i3ogLo09HQZgo5omTMqIpGrFbkdsI/HTuNsP2IxPSV4EVaDaZjFr2o9oE7dVWpsd5Be+vIu8ZEQhJt+h423patwW1B4zAY8qp1KemTLpo0EczuK9Wxq/1qFi5xGwsCIS5PUNQF4LnUtvJE/v+NsiULkW6FaDuMFtmhQI=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by SN7PR18MB3887.namprd18.prod.outlook.com (2603:10b6:806:105::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.20; Mon, 29 Jan
 2024 15:08:42 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::3cca:92a0:1e88:5f24]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::3cca:92a0:1e88:5f24%7]) with mapi id 15.20.7249.017; Mon, 29 Jan 2024
 15:08:42 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
CC: Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net-next PATCH] octeontx2: Add PTP clock driver for Octeon PTM
 clock.
Thread-Topic: [net-next PATCH] octeontx2: Add PTP clock driver for Octeon PTM
 clock.
Thread-Index: AQHaUsULWkwLO8I3d0esTIbEpcakBg==
Date: Mon, 29 Jan 2024 15:08:42 +0000
Message-ID: 
 <BY3PR18MB4707BB7ADFB58EC7032FBAF7A07E2@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240124064156.2577119-1-saikrishnag@marvell.com>
 <87h6j154yx.fsf@intel.com>
In-Reply-To: <87h6j154yx.fsf@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2Fpa3Jpc2hu?=
 =?us-ascii?Q?YWdcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?us-ascii?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy00N2YwMzA0OC1iZWI4LTExZWUtYWQyZS0x?=
 =?us-ascii?Q?Y2MxMGM0MGQ5ZTRcYW1lLXRlc3RcNDdmMDMwNDktYmViOC0xMWVlLWFkMmUt?=
 =?us-ascii?Q?MWNjMTBjNDBkOWU0Ym9keS50eHQiIHN6PSIzOTg0IiB0PSIxMzM1MTAxNDUx?=
 =?us-ascii?Q?OTgwOTE3MjgiIGg9IlhVNjBGMnd0MHNTZU9iVGtNUCs4SEMwZzNuMD0iIGlk?=
 =?us-ascii?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUJn?=
 =?us-ascii?Q?V0FBRFFiWEVLeFZMYUFXMUtIaGFIdGFSRWJVb2VGb2UxcEVRWkFBQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBRWdBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
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
 =?us-ascii?Q?QmxBRjhBWmdCcEFHd0FaUUFBQUNRQUFBQVNBQUFBWlFCdEFHRUFhUUJzQUY4?=
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
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|SN7PR18MB3887:EE_
x-ms-office365-filtering-correlation-id: bc63c519-b9e2-47d5-395d-08dc20dc2e78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 UJvdqK+vUaFiQ6Av5VoSr1gzL5k1DO7u0lUMTwHxw044EgHqjW2w+c51YzXlr3x7liJjbYrDjbuyTqjxhX+NAJIVcLKcGcvawoh2g7e5dy9OpRaAWoywRLS1foijjOdKRHrBcgcBnTjhjoXBgw50Tv3ulK1ztU1vTeK6LsSS9l/lX1ETw6dgmV6BePm1OsuGjgQXSv1N5AxhLjs3CiRyyMV86VuD9cVQy/8+v529jlbMFFTjdHE+5Jt8b8nzeQHA1yRvq2k/4MsTE7Cog1lr8yFZJ8naZmbTmR0aX0Te6omxLcracMarzybht5+MWRX6nDs9lzVnbdp9qiX+tWj4EuO48sMr8sd2SBc71EEnacIKdZnO4oajjRGSyaLwn5r3JVlL+PUpYDEtl0xA/glCJNy2DdDevIk4cpD73+J3yMXKHhQXmsUAXSjX4OW8gXrDmvlGAhlJD1iGPF95Fy31P8MZodd3955Bt2qqLd6mdcL97oeX8lPqRHhAboj5SJL6qhsorB0xCuyTl2YOlN61xHnOpH/enS44cMSd0yhI8gbkukiH1uiRqsyVxuP89kHwGrEc2JbBWsfIiZs1VtI+9ZkpoYpuDVJ5tgyAPuypGglnF1tES7ulZ+4pyBkEkNB2
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(366004)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(55016003)(6506007)(26005)(53546011)(107886003)(7696005)(83380400001)(33656002)(86362001)(38070700009)(5660300002)(66476007)(8676002)(41300700001)(4326008)(52536014)(9686003)(38100700002)(122000001)(71200400001)(76116006)(6636002)(110136005)(66556008)(66946007)(921011)(64756008)(2906002)(478600001)(8936002)(66446008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?/LGskAYO4IInb6Yyy3aKMM2DNmsl6iejGrwlVsSPp7k/lDQtHyi4tkOCodIO?=
 =?us-ascii?Q?uIe0Ubypd7axgqeiWAlcEkE06WWt5wcPE9m4uQEHRUIgnq0g8VuBcsVtYML+?=
 =?us-ascii?Q?5r7BeaIgnYJ1u2VoLrzptov+mXanxVy0G6vE73fDgsTailhIyCbBgS4LgOMd?=
 =?us-ascii?Q?Q4xjVtXVi/Lb67VvoLqtqEURLh6lm8F4yZ+UqhrZ47Ibfva9Y9jJiDwgwqA2?=
 =?us-ascii?Q?Sq9MroM43AdECVTkZz0P/m3g6VPEsOsYgC1fzav8R3NBVYmlAEOFczrAmzXg?=
 =?us-ascii?Q?T29nHSJkZhdUdsFf4d8bdAQw5xu5RApFtR3E8LIrtFdSrpKJGldsBDhs8NsL?=
 =?us-ascii?Q?La8qLIsOyWoL5pEygMu471n0mTS4gocr5+AI/8NKKUHFdKFoIS+PkWGF3kpK?=
 =?us-ascii?Q?GB9LTo6nYVAbRIjeA5CCLoMWNTcAqckKm82F3JJzFz7B8HbyJzragoKasJuU?=
 =?us-ascii?Q?a6VO0n6ipJfkjGWjj/yl3pEEWDBCNC9yWXW/GACjvHvpbgngoIKZSZPKHW/M?=
 =?us-ascii?Q?Q/mfvLSTKrdCcD1+U6HsfdkSK3wmkFt+VoDXkSwprIp+s1CUahPODdEo1a6W?=
 =?us-ascii?Q?COsGZnb4MhXdzEcEzJMF6mZl5d/l0r8EhVZyl4b07z80QnZswwzT+UDwXY02?=
 =?us-ascii?Q?P2DvMrJgZv0fA+Jr3QRHewi11xkIRR0WTEv0IuKcM/mHVyGzlVhohVsXtt2G?=
 =?us-ascii?Q?go1x8/E12uo06UritTlv9lVUfITxii62MCbiqZH2m2zsNyws9yLNoUTsnyWW?=
 =?us-ascii?Q?5GwmYwBnUJ1thyGOwe6jSQP4cj7qV50OhJllU/IY4eaTT8rDvwKH3jMN3QZR?=
 =?us-ascii?Q?9P15bnsmZoNzSNxsIyumTl7L5yZlYT1S2cY/Zq/lOBcoSaoDPOMWLMg3mtPb?=
 =?us-ascii?Q?BBuUzATT45R8Be3g+IHCHIDR6bnUHAE2lmy1q13HzGZp+7yXg1dI9aRQrYIu?=
 =?us-ascii?Q?Tjw3sYl836iYS3fjDUqQD5bLNAJ//Xm5kvLZwlYdzaRpxvHmhVCig4khlKiJ?=
 =?us-ascii?Q?AOD2pnaOqehmP9pKYJhDhLCUXMnMNic4xhrhwK/qlp1gqNWrJTVFQ5UBG5mZ?=
 =?us-ascii?Q?dkvALLLDtt+BfqhSOGpwLVVYvq+E3j1GiWTiMX1Y9cycd6hxRk30PS1oufKZ?=
 =?us-ascii?Q?Yu3kS1JGoDcY+4B9kJr0hy77G52WFsuKEdQ1C6kETJYIhq2TdztPygND6cxY?=
 =?us-ascii?Q?85GBmM0tFXMOR8o84/T2vgVox+s60XbCem+ZT0EURytnRldhsmnFrHIL3zfd?=
 =?us-ascii?Q?usWMzqL68y3X58IroM+OllVCAn3EU4fj3lgNJeJUlJwcKPWHS/nwXqASwnjX?=
 =?us-ascii?Q?fCBcb0eoIQwCTaEhpbHEftbtU5Fpc9ibQ0Bk+0ekUJlph2JQ1N9SkCeWjfpI?=
 =?us-ascii?Q?YHb+c+6GFrsv0flyznQmpknBmG/AMAcD0edTGUkUFkQiP4LtjyyS8UVPBhEs?=
 =?us-ascii?Q?lp6jCQaJGTcUbPe1gQHu1JMjQGGSV8/vHdrJPjynuz7tm67ZjY+Wxlp17koy?=
 =?us-ascii?Q?ga1kmwnLFQMImT10Vz5qLkvlgvDFCTUOb90L464nvFyvZC+fz7YTMul8HQz0?=
 =?us-ascii?Q?qRy4nu9zR+o6c7b+SxJReQXHF1z3bSK1bkLU8ZnS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bc63c519-b9e2-47d5-395d-08dc20dc2e78
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 15:08:42.3715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ln09ySva36Z36Z2xtCj/vwXQ8paD0qC29CvhuvJ7j7dLgk4QZnjjXxpsDYeojCpjA+3TdVznSGnrmHzs+Gd9lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3887
X-Proofpoint-ORIG-GUID: _ebNUDvQsnd4oC8XiUcMTgfLwmjtYHbT
X-Proofpoint-GUID: _ebNUDvQsnd4oC8XiUcMTgfLwmjtYHbT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_09,2024-01-29_01,2023-05-22_02


> -----Original Message-----
> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Sent: Friday, January 26, 2024 5:41 AM
> To: Sai Krishna Gajula <saikrishnag@marvell.com>;
> richardcochran@gmail.com; davem@davemloft.net; kuba@kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri
> Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> <gakula@marvell.com>; Linu Cherian <lcherian@marvell.com>; Hariprasad
> Kelam <hkelam@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>
> Cc: Sai Krishna Gajula <saikrishnag@marvell.com>; Naveen Mamindlapalli
> <naveenm@marvell.com>
> Subject: Re: [net-next PATCH] octeontx2: Add PTP clock driver for
> Octeon PTM clock.
>=20
> Sai Krishna <saikrishnag@marvell.com> writes:
>=20
> > The PCIe PTM(Precision time measurement) protocol provides precise
> > coordination of events across multiple components like PCIe host
> > clock, PCIe EP PHC local clocks of PCIe devices. This patch adds
> > support for ptp clock based PTM clock. We can use this PTP device to
> > sync the PTM time with CLOCK_REALTIME or other PTP PHC devices using
> > phc2sys.
> >
> > Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> > Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> > Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> > ---
>=20
> I can see that the same device id (PCI_DEVID_OCTEONTX2_PTP) is used by a
> ethernet driver.
>=20
> That brings me a question: why expose a different PTP chardev? In other
> words, why can't you just implement .getcrosststamp() for that ethernet
> device?

This driver runs on endpoint device and not on the host. getcrosststamp() n=
eeds ART time, frequency details in case of x86 host system. Our use case i=
s to sync the host's PTP/PTM time to the endpoint device via PTM interface.

>=20
>=20
> Cheers,
> --
> Vinicius

