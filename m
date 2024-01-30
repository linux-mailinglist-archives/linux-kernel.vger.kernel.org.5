Return-Path: <linux-kernel+bounces-44611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6498D842503
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91B2A1C258DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1121B6A015;
	Tue, 30 Jan 2024 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="J5BNs1qN"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E346A00E;
	Tue, 30 Jan 2024 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618131; cv=fail; b=fFj+OqwznB8289uQnJVsKVRojS4BMU+a6HRwVPIlqR51NmME+5iwhIRGVBRUS6wq595u08wBCBDbXu0oVJjYUi1KragJ9ufs5INy86RhoxsWYgD9taV1svZdqUorVcJ2S8FjL+KUj5ZJI/cFZLAjtx8WI/XoWitluaARFW8eSvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618131; c=relaxed/simple;
	bh=YS+qgFujVz/G90aBuBcRZbw5RZ9raUvY7nORjvy8xRg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rKF8s3rSzBo1gNC5f9PRkzadNESkL42i3Hs671/Zf1nSQ1JeT8vKR+KumMmVNdD1t6C7GHQ9oXUQV5yrxMuSke7Ua2DuDkX1f6fO8oVHyXoXwkAcXNA8ePV5GCvuQsoUC0/13ywZmhzxruBYOPGuKQk3n8QKhpjW9McqHQ9wRxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=J5BNs1qN; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U8Dsd8027808;
	Tue, 30 Jan 2024 04:35:21 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vw27nhnnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 04:35:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFRgSNR/WnbtGV1yHWClffsfmlH8qy1jUyPR54jXSpueEcOw7sPQmioYLGaiufaxofzGhqwIFlZILJtV5FY4/vpbC7CrKHDkw05lBcv5FJVpLke9jc4q9xyn2Yj+sI3SjliFn2+YlUCXDgcHfCtuOaBATIRzYMDjs+Bxqe4VjAY4YUYUeTC9xWn5o4IoJ4lcDtgXHGL6HHooepYxCsas7J0slx6gsF6lkbKLybtehBTIbhSx9kf0hYfu0BZuPK+siE1HCzeEJY7pWLxTFovl82FgfYrzExJsDtqt7Hg6/DdoVY3LingJNSk62cBtdDJc2y92sKn20iceVOvrvnOS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OsMrnLCWvurXsXfcCBJIq0LBS9KwHQB4it5qYhoGRI=;
 b=LEsEcfkupvYsc8PqNLHV3LsNvDyXpRcQ+Y7X+EVFUBg2wO0qrRbCLufnf5Yz/yVgF2xDXcivo2gWotnAqcyHIyr+wd+6Oj+Xp3+D8ebiS+bvYmSuuDrjQAVOXdedPo28VUML9ljTWzN7gFffkty0a7WsIKmh0xf/ilOazlxv4FQcxudHlCR4K54G+UIwVzpWLH7W/ifFQhKipz1uYZgIyZk+oiovHUT1m3yrDRCAi9gqJ1kbRQs9FRAK4bx+R4mkkf1Xo3g7RDp7SwA6qkGBDpKDy8mz30MU1Cbeq0NJecvGplL/tf0+PkdnV12PqhnneSL08Udw+KIGmhyR2EoNuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OsMrnLCWvurXsXfcCBJIq0LBS9KwHQB4it5qYhoGRI=;
 b=J5BNs1qN0mwEhee/gdjzmGfglYGjri9E2RbreE8g3iNzW8IeUIRS6jwDeEk7bhYCtRBeRemEZvengKh3IWPmDg7qJkgZskSVhAIwWqGiZJsE1d+4ku6C3g9ZLGcx312fU8iCNoOZ8bCLX1K5Q2WOJz9M+EuKOdGmcNwWGgKYTMk=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by MN6PR18MB5441.namprd18.prod.outlook.com (2603:10b6:208:47a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 12:35:18 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::3cca:92a0:1e88:5f24]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::3cca:92a0:1e88:5f24%7]) with mapi id 15.20.7249.017; Tue, 30 Jan 2024
 12:35:18 +0000
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
Thread-Index: AQHaU3jIr0gj/RcLzEux3pY9wcityw==
Date: Tue, 30 Jan 2024 12:35:18 +0000
Message-ID: 
 <BY3PR18MB4707BC03A395B280639B23E0A07D2@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240124064156.2577119-1-saikrishnag@marvell.com>
 <87fryfr3we.fsf@intel.com>
In-Reply-To: <87fryfr3we.fsf@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2Fpa3Jpc2hu?=
 =?us-ascii?Q?YWdcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?us-ascii?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy0wNGE1YTBiMS1iZjZjLTExZWUtYWQyZS0x?=
 =?us-ascii?Q?Y2MxMGM0MGQ5ZTRcYW1lLXRlc3RcMDRhNWEwYjItYmY2Yy0xMWVlLWFkMmUt?=
 =?us-ascii?Q?MWNjMTBjNDBkOWU0Ym9keS50eHQiIHN6PSIyMzAxMiIgdD0iMTMzNTEwOTE3?=
 =?us-ascii?Q?MTYzMzE1Nzc2IiBoPSI5aFdiWDJaWmVMM1lQQnFGSGpOenNOUGlEV2s9IiBp?=
 =?us-ascii?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFC?=
 =?us-ascii?Q?Z1dBQUJBOGlmSGVGUGFBYWZQVk9hTXZKUnZwODlVNW95OGxHOFpBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFCdUR3QUEzZzhBQURvR0FBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBUUVCQUFBQTl5RlhxZ0NBQVFBQUFBQUFBQUFBQUo0QUFBQmhB?=
 =?us-ascii?Q?R1FBWkFCeUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQWRRQnpBSFFBYndCdEFG?=
 =?us-ascii?Q?OEFjQUJsQUhJQWN3QnZBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
 =?us-ascii?Q?QUNBQUFBQUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBBWHdCd0FHZ0Fid0J1QUdV?=
 =?us-ascii?Q?QWJnQjFBRzBBWWdCbEFISUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?akFIVUFjd0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFaQUJoQUhNQWFBQmZBSFlB?=
 =?us-ascii?Q?TUFBeUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-refone: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5n?=
 =?us-ascii?Q?QUFBR01BZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdCckFHVUFlUUIzQUc4?=
 =?us-ascii?Q?QWNnQmtBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVl3QjFBSE1BZEFC?=
 =?us-ascii?Q?dkFHMEFYd0J6QUhNQWJnQmZBRzRBYndCa0FHVUFiQUJwQUcwQWFRQjBBR1VB?=
 =?us-ascii?Q?Y2dCZkFIWUFNQUF5QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFB?=
 =?us-ascii?Q?QUFBQUFBQUlBQUFBQUFKNEFBQUJqQUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1?=
 =?us-ascii?Q?QUY4QWN3QndBR0VBWXdCbEFGOEFkZ0F3QURJQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFB?=
 =?us-ascii?Q?bmdBQUFHUUFiQUJ3QUY4QWN3QnJBSGtBY0FCbEFGOEFZd0JvQUdFQWRBQmZB?=
 =?us-ascii?Q?RzBBWlFCekFITUFZUUJuQUdVQVh3QjJBREFBTWdBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWkFCc0FIQUFY?=
 =?us-ascii?Q?d0J6QUd3QVlRQmpBR3NBWHdCakFHZ0FZUUIwQUY4QWJRQmxBSE1BY3dCaEFH?=
 =?us-ascii?Q?Y0FaUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmtBR3dB?=
 =?us-ascii?Q?Y0FCZkFIUUFaUUJoQUcwQWN3QmZBRzhBYmdCbEFHUUFjZ0JwQUhZQVpRQmZB?=
 =?us-ascii?Q?R1lBYVFCc0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdVQWJRQmhBR2tBYkFCZkFHRUFa?=
 =?us-ascii?Q?QUJrQUhJQVpRQnpBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUVnQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dBWHdCd0FISUFid0JxQUdVQVl3?=
 =?us-ascii?Q?QjBBRjhBYmdCaEFHMEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhR?=
 =?us-ascii?Q?QWFRQmhBR3dBWHdCaEFHd0Fid0J1QUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFH?=
 =?us-ascii?Q?RUFjZ0IyQUdVQWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFC?=
 =?us-ascii?Q?bEFITUFYd0J5QUdVQWN3QjBBSElBYVFCakFIUUFaUUJrQUY4QVlRQnNBRzhB?=
 =?us-ascii?Q?YmdCbEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUY4?=
 =?us-ascii?Q?QWNBQnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFISUFaUUJ6?=
 =?us-ascii?Q?QUhRQWNnQnBBR01BZEFCbEFHUUFYd0JvQUdVQWVBQmpBRzhBWkFCbEFITUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUdFQWNnQnRBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refthree: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFB?=
 =?us-ascii?Q?QUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFad0J2QUc4?=
 =?us-ascii?Q?QVp3QnNBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdB?=
 =?us-ascii?Q?QUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhB?=
 =?us-ascii?Q?WXdCdkFHUUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0Js?=
 =?us-ascii?Q?QUd3QWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QmpBRzhBWkFCbEFITUFY?=
 =?us-ascii?Q?d0JrQUdrQVl3QjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFB?=
 =?us-ascii?Q?QUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlB?=
 =?us-ascii?Q?RzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFR?=
 =?us-ascii?Q?QmtBR1VBYmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFu?=
 =?us-ascii?Q?Z0FBQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFG?=
 =?us-ascii?Q?OEFiZ0JoQUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFBYVFC?=
 =?us-ascii?Q?aEFHd0FYd0J0QUdFQWNnQjJBR1VBYkFCc0FGOEFid0J5QUY4QVlRQnlBRzBB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpB?=
 =?us-ascii?Q?SFFBWHdCdUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0QWRB?=
 =?us-ascii?Q?QnBBR0VBYkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0JuQUc4?=
 =?us-ascii?Q?QWJ3Qm5BR3dBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFj?=
 =?us-ascii?Q?Z0IyQUdVQWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFH?=
 =?us-ascii?Q?VUFjd0JmQUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VBY2dC?=
 =?us-ascii?Q?MkFHVUFiQUJzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3?=
 =?us-ascii?Q?QndBSElBYndCcUFHVUFZd0IwQUY4QWJnQmhBRzBBWlFCekFGOEFjZ0JsQUhN?=
 =?us-ascii?Q?QWRBQnlBR2tBWXdCMEFHVUFaQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2?=
 =?us-ascii?Q?QUhJQVh3QmhBSElBYlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhRQVpRQnlBRzBBYVFC?=
 =?us-ascii?Q?dUFIVUFjd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdF?=
 =?us-ascii?Q?QWNnQjJBR1VBYkFCc0FGOEFkd0J2QUhJQVpBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFNQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBT2dZQUFBQUFBQUFJQUFBQUFBQUFBQWdB?=
 =?us-ascii?Q?QUFBQUFBQUFDQUFBQUFBQUFBQWFCZ0FBR1FB?=
x-dg-reffive: 
 =?us-ascii?Q?QUFCZ0FBQUFBQUFBQVlRQmtBR1FBY2dCbEFITUFjd0FBQUNRQUFBQUFBQUFB?=
 =?us-ascii?Q?WXdCMUFITUFkQUJ2QUcwQVh3QndBR1VBY2dCekFHOEFiZ0FBQUM0QUFBQUFB?=
 =?us-ascii?Q?QUFBWXdCMUFITUFkQUJ2QUcwQVh3QndBR2dBYndCdUFHVUFiZ0IxQUcwQVln?=
 =?us-ascii?Q?QmxBSElBQUFBd0FBQUFBQUFBQUdNQWRRQnpBSFFBYndCdEFGOEFjd0J6QUc0?=
 =?us-ascii?Q?QVh3QmtBR0VBY3dCb0FGOEFkZ0F3QURJQUFBQXdBQUFBQUFBQUFHTUFkUUJ6?=
 =?us-ascii?Q?QUhRQWJ3QnRBRjhBY3dCekFHNEFYd0JyQUdVQWVRQjNBRzhBY2dCa0FITUFB?=
 =?us-ascii?Q?QUErQUFBQUFBQUFBR01BZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdCdUFH?=
 =?us-ascii?Q?OEFaQUJsQUd3QWFRQnRBR2tBZEFCbEFISUFYd0IyQURBQU1nQUFBRElBQUFB?=
 =?us-ascii?Q?QUFBQUFZd0IxQUhNQWRBQnZBRzBBWHdCekFITUFiZ0JmQUhNQWNBQmhBR01B?=
 =?us-ascii?Q?WlFCZkFIWUFNQUF5QUFBQVBnQUFBQUFBQUFCa0FHd0FjQUJmQUhNQWF3QjVB?=
 =?us-ascii?Q?SEFBWlFCZkFHTUFhQUJoQUhRQVh3QnRBR1VBY3dCekFHRUFad0JsQUY4QWRn?=
 =?us-ascii?Q?QXdBRElBQUFBMkFBQUFBQUFBQUdRQWJBQndBRjhBY3dCc0FHRUFZd0JyQUY4?=
 =?us-ascii?Q?QVl3Qm9BR0VBZEFCZkFHMEFaUUJ6QUhNQVlRQm5BR1VBQUFBNEFBQUFBQUFB?=
 =?us-ascii?Q?QUdRQWJBQndBRjhBZEFCbEFHRUFiUUJ6QUY4QWJ3QnVBR1VBWkFCeUFHa0Fk?=
 =?us-ascii?Q?Z0JsQUY4QVpnQnBBR3dBWlFBQUFDUUFBQUFTQUFBQVpRQnRBR0VBYVFCc0FG?=
 =?us-ascii?Q?OEFZUUJrQUdRQWNnQmxBSE1BY3dBQUFGZ0FBQUFBQUFBQWJRQmhBSElBZGdC?=
 =?us-ascii?Q?bEFHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFiZ0JoQUcwQVpRQnpBRjhB?=
 =?us-ascii?Q?WXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFBYVFCaEFHd0FYd0JoQUd3QWJ3QnVB?=
 =?us-ascii?Q?R1VBQUFCVUFBQUFBQUFBQUcwQVlRQnlBSFlBWlFCc0FGOEFjQUJ5QUc4QWFn?=
 =?us-ascii?Q?QmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZBSElBWlFCekFIUUFjZ0JwQUdN?=
 =?us-ascii?Q?QWRBQmxBR1FBWHdCaEFHd0Fid0J1QUdVQUFBQmFBQUFBQUFBQUFHMEFZUUJ5?=
 =?us-ascii?Q?QUhZQVpRQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFj?=
 =?us-ascii?Q?d0JmQUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3Qm9BR1VBZUFCakFH?=
 =?us-ascii?Q?OEFaQUJsQUhNQUFBQWdBQUFBQUFBQUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdC?=
 =?us-ascii?Q?aEFISUFiUUFBQUNZQUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBR2NB?=
 =?us-ascii?Q?YndCdkFHY0FiQUJsQUFBQU5BQUFBQUFBQUFC?=
x-dg-refsix: 
 =?us-ascii?Q?dEFHRUFjZ0IyQUdVQWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBR01B?=
 =?us-ascii?Q?YndCa0FHVUFjd0FBQUQ0QUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZB?=
 =?us-ascii?Q?SEFBY2dCdkFHb0FaUUJqQUhRQVh3QmpBRzhBWkFCbEFITUFYd0JrQUdrQVl3?=
 =?us-ascii?Q?QjBBQUFBWGdBQUFBQUFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFjQUJ5QUc4?=
 =?us-ascii?Q?QWFnQmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZBR01BYndCdUFHWUFhUUJr?=
 =?us-ascii?Q?QUdVQWJnQjBBR2tBWVFCc0FGOEFiUUJoQUhJQWRnQmxBR3dBYkFBQUFHd0FB?=
 =?us-ascii?Q?QUFBQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29BWlFCakFI?=
 =?us-ascii?Q?UUFYd0J1QUdFQWJRQmxBSE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRBZEFC?=
 =?us-ascii?Q?cEFHRUFiQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3QmhBSElB?=
 =?us-ascii?Q?YlFBQUFISUFBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZB?=
 =?us-ascii?Q?R29BWlFCakFIUUFYd0J1QUdFQWJRQmxBSE1BWHdCakFHOEFiZ0JtQUdrQVpB?=
 =?us-ascii?Q?QmxBRzRBZEFCcEFHRUFiQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJ?=
 =?us-ascii?Q?QVh3Qm5BRzhBYndCbkFHd0FaUUFBQUZvQUFBQUFBQUFBYlFCaEFISUFkZ0Js?=
 =?us-ascii?Q?QUd3QWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFITUFY?=
 =?us-ascii?Q?d0J5QUdVQWN3QjBBSElBYVFCakFIUUFaUUJrQUY4QWJRQmhBSElBZGdCbEFH?=
 =?us-ascii?Q?d0FiQUFBQUdnQUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFITUFYd0J5QUdVQWN3QjBBSElB?=
 =?us-ascii?Q?YVFCakFIUUFaUUJrQUY4QWJRQmhBSElBZGdCbEFHd0FiQUJmQUc4QWNnQmZB?=
 =?us-ascii?Q?R0VBY2dCdEFBQUFLZ0FBQUFBQUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWRB?=
 =?us-ascii?Q?QmxBSElBYlFCcEFHNEFkUUJ6QUFBQUlnQUFBQU1BQUFCdEFHRUFjZ0IyQUdV?=
 =?us-ascii?Q?QWJBQnNBRjhBZHdCdkFISUFaQUFBQUE9PSIvPjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|MN6PR18MB5441:EE_
x-ms-office365-filtering-correlation-id: a96f7aa0-4cd5-447b-1d67-08dc218feac9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 n9ezinw8jhb1eV3ki5R4tJDf2yRiswiHCt7KYuvsRF7vFintgeBC4fElZpSwNXBAVzmzoGzpTUt8wSWj1TYCdCcnM0Zr+D8/FmCOeYNSPIU6AAXgnzrTFcD1kyP62B/t9c5t3gNrkBqC6NWjQbB9UePcbj6CK1Qp946tSGwTyYWqbt8dw0+l9wSVZL9kGWsfkiIEl1OTiJve+Wl5/j4CuADMoM2mOKierFBp8Es3u4soe3fq73tOmLYQURpFzyCd4s9xe95u738rDPoWUEvB8Vi87Tk0g2dPOEpB0rC23xrDUF0ITeZYZxbAh8AYr3olHnWp4j0UYuhF8lMn/Ymzz8ByqnIp0bUDXLE1xhA5bSPTMqM4ORdrRmVSrMzIBDknsA7lKK55vJQNTpiUBv3Kp52rcVQ8IR1sRyOfdWqWRyVrjk2Op/ExRiMMygn2w7YgcB6Su5Zf60fSBMinqTowZw5+/VXvGrex9G9IPgXMo5cuaMpTtCSxP3FltPIu6PoimUbIidhDbM1LzD+tkBNa3KHWdn9cMazOOk1LaUIa2IbWKxLH1E3S6sBrMvn/ZJ9PNFwOCxEsf3sSVPembj/ufPfKNwHtYMWLlj9UzlpVzo06nxGov3AGMJOem1wFVUEq
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(41300700001)(122000001)(55016003)(38100700002)(30864003)(2906002)(110136005)(4326008)(8936002)(8676002)(921011)(6506007)(5660300002)(86362001)(478600001)(33656002)(76116006)(71200400001)(53546011)(64756008)(66476007)(66446008)(66556008)(52536014)(66946007)(7696005)(6636002)(9686003)(316002)(107886003)(38070700009)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?wM+JmrYsN0jGJ7Eg7NS1XHhjwSG661nrpsVj5dRkrtu00NUhPUhZitE5BEcX?=
 =?us-ascii?Q?B5rICTAXWcuMPP8AdEOeY5tyhfZaTG6QnGFw2sME+okTH6WxvEiwfiio0Lu2?=
 =?us-ascii?Q?Fi21lDaqkzb6EaevilKfVIBHwMFGlgX71X+Sm2zdtaa6BAJJgQSezz/islOl?=
 =?us-ascii?Q?tJ7FEXvaVyzACooaqqxMzQfh4vxDGUW9hjVf3MvfBVUA3D8c+Ij0gCItOjwn?=
 =?us-ascii?Q?8ouch8n2Uead68AOrXF16pOaQ2zIcM0WvLmAcRXeO+0ISOOiMNEM3/lPcTvJ?=
 =?us-ascii?Q?2jOf01DSR4Ww8ndhmhDzzxTmwE6aPQuUXK2+8I/RMY4cd/d1wDP0MXRamVOC?=
 =?us-ascii?Q?1McsAwTm7EM7ABJbxGiQsOwW/tYBm9hdb+a3uzVrhjVsMaPnhX9ssBCzQ2fU?=
 =?us-ascii?Q?J1wxaPM12WZ6+Wd5epgC+VU9LLxP/fCo7SEUtCfZCpSZdlPb6wdxTyScZur1?=
 =?us-ascii?Q?3s8izU7zVFB1fwZOBcO8Tx4D08crC7MaMZPTGNg+7ukAOeYFII1zlRLPIzwF?=
 =?us-ascii?Q?34elOqiydmBH/Y6shzdXDOM5ftEoUuKwU0bxXpUfpYkCrPeBNS5yGqzxunkj?=
 =?us-ascii?Q?WlNDzxF1GpWpE/OL+8SuPIBRUDMgVHzzxzr1yYOoxrbFYkY7iAePT8kdNGxF?=
 =?us-ascii?Q?2qgjBqCS78k/qL3LIzcSFs7K+wZ9Mz6hm0fd+bCgBua5rRSYSiIZ3NnZ2RQB?=
 =?us-ascii?Q?mBiIu975rGDshxetgGPDY66FYYVNNXyTM4mQMca0zzYs99/lpx3R8w9WyZxY?=
 =?us-ascii?Q?PB+DXa2QuI2BsUMDaFOBCfIz2QmN1un6TMj6kU7ablQBw0OqPIB8FeJZ5l67?=
 =?us-ascii?Q?i8fGbmVoov7QxGNQWWggO0qEHJNwV2RruZRjnK0vmJgOYyvm3Rvpr7sKUrfR?=
 =?us-ascii?Q?aXUvwyGFM+WqO3ZUrtPm6VfrqHvohlvRXYdb6lics5QaWVeY+h826quGUR5h?=
 =?us-ascii?Q?WWaPChst0Laq66hE0nuop3QypAN/Yiik9ibvFdIqDM+yuQojmVlBGaz49OVN?=
 =?us-ascii?Q?f9OL7USWJWGJuTpY9fyBV0HySzfFeKWLsR1YAhMSqsI41ppO3LGvH4a5UhFA?=
 =?us-ascii?Q?20dsgKDQMWD3pp36wV06tZ3wH+NsDqQcqndhxwX0kSiZ59wfohb/EWOAsxsE?=
 =?us-ascii?Q?9/VV+rpaka5HCHlHNi7o+apkAKW49nsECOJh4hfSpZWxBWCS6w94mnwisgGI?=
 =?us-ascii?Q?Nb66LNwb/vFOIXNGo2NDY+PTgFv1d9kESZg1Nbwz/PZkmo2/N4SOS7YxgEvP?=
 =?us-ascii?Q?B1QBjuv1cj3DHCQ6NNZlBxMxP+C9KGdNWILn6EtMVqTuJ4m/V8h/aD73ipQk?=
 =?us-ascii?Q?n5clTcmtqT70DBZ/aaPYE7P/dPU56AWuOIoKnSkpiFurtN2prZMU0fpRNGai?=
 =?us-ascii?Q?Rh+3dRt8XMoN4EVfNA9pBTtReCtRXtOCL+lPcA67jiQTDtPfJA42ZAp4nA2b?=
 =?us-ascii?Q?f9Ud5ALeOhmQPMiGCGZnIy1BxGNwdA3TyPNgUggedbSLlCdwQaK3AEQMWbdF?=
 =?us-ascii?Q?w1KTpLQCijcrLGIrz3e8CPZkijEEih+WGQ4A3pxNQJZD5HxcQxaFwO4LRjPh?=
 =?us-ascii?Q?3mioq3EjwLiuyhIkqaqmi8vzvwAQhvrBA9fCpONO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a96f7aa0-4cd5-447b-1d67-08dc218feac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 12:35:18.2681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rLq3CNmoiS0QueTtQ2xygEz8RyGAsAUFaGk+QkSjB1kTMW14V9CdfVWUogH2DNeTcUi+X4QMF1KEm575QKRy3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR18MB5441
X-Proofpoint-ORIG-GUID: D0ZwrDwzV8mobRFtBURMHtdUw87GdVJt
X-Proofpoint-GUID: D0ZwrDwzV8mobRFtBURMHtdUw87GdVJt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02


> -----Original Message-----
> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Sent: Tuesday, January 30, 2024 7:15 AM
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
> >  drivers/ptp/Kconfig          |  10 ++
> >  drivers/ptp/Makefile         |   1 +
> >  drivers/ptp/ptp_octeon_ptm.c | 254
> > +++++++++++++++++++++++++++++++++++
> >  3 files changed, 265 insertions(+)
> >  create mode 100644 drivers/ptp/ptp_octeon_ptm.c
> >
> > diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig index
> > 5dd5f188e14f..afa82555dbd9 100644
> > --- a/drivers/ptp/Kconfig
> > +++ b/drivers/ptp/Kconfig
> > @@ -212,4 +212,14 @@ config PTP_DFL_TOD
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called ptp_dfl_tod.
> >
> > +config PTP_CLOCK_OCTEON
> > +	tristate "OCTEON PTM PTP clock"
> > +	depends on PTP_1588_CLOCK
> > +	default n
> > +	help
> > +	  This driver adds support for using Octeon PTM device clock as
> > +	  a PTP clock.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called ptp_octeon_ptm.
> >  endmenu
> > diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile index
> > dea0cebd2303..e811ae6df5c0 100644
> > --- a/drivers/ptp/Makefile
> > +++ b/drivers/ptp/Makefile
> > @@ -20,3 +20,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_MOCK)	+=3D
> ptp_mock.o
> >  obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+=3D ptp_vmw.o
> >  obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+=3D ptp_ocp.o
> >  obj-$(CONFIG_PTP_DFL_TOD)		+=3D ptp_dfl_tod.o
> > +obj-$(CONFIG_PTP_CLOCK_OCTEON)		+=3D
> ptp_octeon_ptm.o
> > diff --git a/drivers/ptp/ptp_octeon_ptm.c
> > b/drivers/ptp/ptp_octeon_ptm.c new file mode 100644 index
> > 000000000000..da069645ebf7
> > --- /dev/null
> > +++ b/drivers/ptp/ptp_octeon_ptm.c
> > @@ -0,0 +1,254 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Marvell PTP PHC clock driver for PCIe PTM (Precision Time
> > +Measurement) EP
> > + *
> > + * Copyright (c) 2023 Marvell.
> > + *
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/pci.h>
> > +#include <linux/slab.h>
> > +#include <linux/module.h>
> > +
> > +#include <linux/ptp_clock_kernel.h>
> > +
> > +#include "ptp_private.h"
> > +
> > +#define PEMX_PFX_CSX_PFCFGX(pem, pf, _offset)	({typeof(_offset)
> (offset) =3D (_offset); \
> > +						((0x8e0000008000 |
> (u64)(pem) << 36 \
> > +						| (pf) << 18 \
> > +						| (((offset) >> 16) & 1) << 16 \
> > +						| ((offset) >> 3) << 3) \
> > +						+ ((((offset) >> 2) & 1) << 2));
> })
> > +
> > +#define PEMX_CFG_WR(a)			(0x8E0000000018ull | (u64)(a)
> << 36)
> > +#define PEMX_CFG_RD(a)			(0x8E0000000020ull | (u64)(a)
> << 36)
> > +
> > +/* Octeon CSRs   */
> > +#define PEMX_CFG                        0x8e00000000d8ULL
> > +#define PEMX_PTM_CTL			0x8e0000000098ULL
> > +#define PEMX_PTM_CTL_CAP		BIT_ULL(10)
> > +#define PEMX_PTM_LCL_TIME		0x8e00000000a0ULL /* PTM
> time */
> > +#define PEMX_PTM_MAS_TIME		0x8e00000000a8ULL /* PTP
> time */
> > +#define PTM_DEBUG			0
> > +
> > +struct oct_ptp_clock {
> > +	struct ptp_clock *ptp_clock;
> > +	struct ptp_clock_info caps;
> > +	bool cn10k_variant;
> > +};
> > +
> > +static struct oct_ptp_clock oct_ptp_clock; static void __iomem
> > +*ptm_ctl_addr; static void __iomem *ptm_lcl_addr;
> > +
> > +/* Config space registers   */
> > +#define PCIEEPX_PTM_REQ_STAT		(oct_ptp_clock.cn10k_variant
> ? 0x3a8 : 0x474)
> > +#define PCIEEPX_PTM_REQ_T1L		(oct_ptp_clock.cn10k_variant
> ? 0x3b4 : 0x480)
> > +#define PCIEEPX_PTM_REQ_T1M		(oct_ptp_clock.cn10k_variant
> ? 0x3b8 : 0x484)
> > +#define PCIEEPX_PTM_REQ_T4L		(oct_ptp_clock.cn10k_variant
> ? 0x3c4 : 0x490)
> > +#define PCIEEPX_PTM_REQ_T4M		(oct_ptp_clock.cn10k_variant
> ? 0x3c8 : 0x494)
> > +
> > +#define PCI_VENDOR_ID_CAVIUM			0x177d
> > +#define PCI_DEVID_OCTEONTX2_PTP			0xA00C
> > +#define PCI_SUBSYS_DEVID_95XX			0xB300
> > +#define PCI_SUBSYS_DEVID_95XXN			0xB400
> > +#define PCI_SUBSYS_DEVID_95XXMM			0xB500
> > +#define PCI_SUBSYS_DEVID_96XX			0xB200
> > +#define PCI_SUBSYS_DEVID_98XX			0xB100
> > +#define PCI_SUBSYS_DEVID_CN10K_A		0xB900
> > +#define PCI_SUBSYS_DEVID_CN10K_B		0xBD00
> > +#define PCI_SUBSYS_DEVID_CNF10K_A		0xBA00
> > +#define PCI_SUBSYS_DEVID_CNF10K_B		0xBC00
> > +
> > +static bool is_otx2_support_ptm(struct pci_dev *pdev) {
> > +	return (pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_96XX ||
> > +		pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_95XX ||
> > +		pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_95XXN ||
> > +		pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_98XX ||
> > +		pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_95XXMM);
> }
> > +
> > +static bool is_cn10k_support_ptm(struct pci_dev *pdev) {
> > +	return (pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_CN10K_A
> ||
> > +		pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_CNF10K_A
> ||
> > +		pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_CN10K_B
> ||
> > +		pdev->subsystem_device =3D=3D
> PCI_SUBSYS_DEVID_CNF10K_B); }
> > +
> > +static int ptp_oct_ptm_adjtime(struct ptp_clock_info *ptp, s64 delta)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static int ptp_oct_ptm_settime(struct ptp_clock_info *ptp,
> > +			       const struct timespec64 *ts) {
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static u32 read_pcie_config32(int ep_pem, int cfg_addr) {
> > +	void __iomem *addr;
> > +	u64 val;
> > +
> > +	if (oct_ptp_clock.cn10k_variant) {
> > +		addr  =3D ioremap(PEMX_PFX_CSX_PFCFGX(ep_pem, 0,
> cfg_addr), 8);
>=20
> Nitpick: double space before '=3D'.

Ack, will submit patch V2 with changes

>=20
> > +		if (!addr) {
> > +			pr_err("PTM_EP: Failed to ioremap Octeon CSR
> space\n");
> > +			return -1U;
> > +		}
> > +		val =3D readl(addr);
> > +		iounmap(addr);
> > +	} else {
> > +		addr  =3D ioremap(PEMX_CFG_RD(ep_pem), 8);
>=20
> Same here.

Ack, will submit patch V2 with changes

>=20
> > +		if (!addr) {
> > +			pr_err("PTM_EP: Failed to ioremap Octeon CSR
> space\n");
> > +			return -1U;
> > +		}
> > +		val =3D ((1 << 15) | (cfg_addr & 0xfff));
> > +		writeq(val, addr);
> > +		val =3D readq(addr) >> 32;
> > +		iounmap(addr);
> > +	}
> > +	return (val & 0xffffffff);
> > +}
> > +
> > +static uint64_t octeon_csr_read(u64 csr_addr) {
> > +	u64 val;
> > +	void __iomem *addr;
> > +
> > +	addr =3D ioremap(csr_addr, 8);
> > +	if (!addr) {
> > +		pr_err("PTM_EP: Failed to ioremap CSR space\n");
> > +		return -1UL;
> > +	}
> > +	val =3D (u64)READ_ONCE(*(u64 __iomem *)addr);
> > +	iounmap(addr);
> > +	return val;
> > +}
> > +
> > +static int ptp_oct_ptm_gettime(struct ptp_clock_info *ptp, struct
> > +timespec64 *ts) {
> > +	u64 ptp_time, val64;
> > +#if PTM_DEBUG
> > +	u64 ptm_time;
> > +#endif
> > +	u32 val32;
> > +
> > +	/* Check for valid PTM context */
> > +	val32 =3D read_pcie_config32(0, PCIEEPX_PTM_REQ_STAT);
> > +	if (!(val32 & 0x1)) {
> > +		pr_err("PTM_EP: ERROR: PTM context not valid: 0x%x\n",
> val32); #if
> > +PTM_DEBUG
> > +		ptm_time =3D 0;
> > +#endif
> > +		ptp_time =3D 0;
> > +
> > +		ts->tv_sec =3D 0;
> > +		ts->tv_nsec =3D 0;
> > +
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Trigger PTM/PTP capture */
> > +	val64 =3D (u64)READ_ONCE(*(u64 __iomem *)ptm_ctl_addr);
> > +	val64 |=3D PEMX_PTM_CTL_CAP;
> > +	WRITE_ONCE(*(u64 __iomem *)ptm_ctl_addr, val64);
> > +	/* Read PTM/PTP clocks  */
> > +	ptp_time =3D (u64)READ_ONCE(*(u64 __iomem *)ptm_lcl_addr);
> > +	ts->tv_sec =3D ptp_time / NSEC_PER_SEC;
> > +	ts->tv_nsec =3D ptp_time % NSEC_PER_SEC;
> > +
> > +#if PTM_DEBUG
> > +	ptm_time =3D octeon_csr_read(PEMX_PTM_MAS_TIME);
> > +	pr_info("PTM_EP: system %lld ptm time: %lld\n", ptp_time,
> ptm_time);
> > +#endif
> > +
> > +	return 0;
> > +}
> > +
> > +static int ptp_oct_ptm_enable(struct ptp_clock_info *ptp,
> > +			      struct ptp_clock_request *rq, int on) {
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static const struct ptp_clock_info ptp_oct_caps =3D {
> > +	.owner		=3D THIS_MODULE,
> > +	.name		=3D "OCTEON PTM PHC",
> > +	.max_adj	=3D 0,
> > +	.n_ext_ts	=3D 0,
> > +	.n_pins		=3D 0,
> > +	.pps		=3D 0,
> > +	.adjtime	=3D ptp_oct_ptm_adjtime,
> > +	.gettime64	=3D ptp_oct_ptm_gettime,
> > +	.settime64	=3D ptp_oct_ptm_settime,
> > +	.enable		=3D ptp_oct_ptm_enable,
> > +};
> > +
> > +static void __exit ptp_oct_ptm_exit(void) {
> > +	iounmap(ptm_ctl_addr);
> > +	iounmap(ptm_lcl_addr);
> > +	ptp_clock_unregister(oct_ptp_clock.ptp_clock);
> > +}
> > +
> > +static int __init ptp_oct_ptm_init(void) {
> > +	struct pci_dev *pdev =3D NULL;
> > +
> > +	pdev =3D pci_get_device(PCI_VENDOR_ID_CAVIUM,
> > +			      PCI_DEVID_OCTEONTX2_PTP, pdev);
> > +	if (!pdev)
> > +		return 0;
> > +
> > +	if (octeon_csr_read(PEMX_CFG) & 0x1ULL) {
> > +		pr_err("PEM0 is configured as RC\n");
> > +		return 0;
> > +	}
> > +
> > +	if (is_otx2_support_ptm(pdev)) {
> > +		oct_ptp_clock.cn10k_variant =3D 0;
> > +	} else if (is_cn10k_support_ptm(pdev)) {
> > +		oct_ptp_clock.cn10k_variant =3D 1;
> > +	} else {
> > +		/* PTM_EP: unsupported processor */
> > +		return 0;
> > +	}
> > +
> > +	ptm_ctl_addr =3D ioremap(PEMX_PTM_CTL, 8);
> > +	if (!ptm_ctl_addr) {
> > +		pr_err("PTM_EP: Failed to ioremap CSR space\n");
> > +		return 0;
> > +	}
> > +
> > +	ptm_lcl_addr =3D ioremap(PEMX_PTM_LCL_TIME, 8);
> > +	if (!ptm_lcl_addr) {
> > +		pr_err("PTM_EP: Failed to ioremap CSR space\n");
> > +		return 0;
> > +	}
> > +
> > +	oct_ptp_clock.caps =3D ptp_oct_caps;
> > +
> > +	oct_ptp_clock.ptp_clock =3D ptp_clock_register(&oct_ptp_clock.caps,
> > +NULL);
> > +
> > +	pr_info("PTP device index for PTM clock:%d\n",
> oct_ptp_clock.ptp_clock->index);
> > +	pr_info("cn10k_variant %d\n", oct_ptp_clock.cn10k_variant);
> > +
> > +	return PTR_ERR_OR_ZERO(oct_ptp_clock.ptp_clock);
> > +}
> > +
> > +module_init(ptp_oct_ptm_init);
> > +module_exit(ptp_oct_ptm_exit);
> > +
> > +MODULE_AUTHOR("Marvell Inc.");
> > +MODULE_DESCRIPTION("PTP PHC clock using PTM");
> MODULE_LICENSE("GPL");
> > --
> > 2.25.1
> >
> >
>=20
> Cheers,
> --
> Vinicius

Thanks,
Sai

