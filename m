Return-Path: <linux-kernel+bounces-39960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDADD83D7D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E39298EE1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6845100C;
	Fri, 26 Jan 2024 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="N4OzVeFm"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C50410A19;
	Fri, 26 Jan 2024 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706262882; cv=fail; b=GjWWVoD1FYSRSnh9ryRK69Nfbh+xOFpfSmJrJ0M7Wwx5i0ozAeZTKCJUGIsv8wm3ivhIYnKTSgaVb8cNBEfXbC1GouKO9Xym1rqz0JqDzr23//WANnWwBHmNwAWjmfFz2CpFFLq8Wu1K+MgfZe3MXcHfrBD1CdK91qtDvk6MbW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706262882; c=relaxed/simple;
	bh=s6pXtVTemkyVnysbbA4JEmQVkU4ud6xL+ZrxCtnKrck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lC7g8sKw71Fa/JXHa3LKRTw3U0Tn9b+QLphLlPOXtBnmkRQnG+6L84OilW7QkEufFe4VHyCmZDPLq7XaFpoYSHdcdu2ouXTT1aqTKD0ZdzRZ5MNzybtGovg6QEr7scC0DtFv9S65kv3AM1efdrujOStyOdN70+MSczc6tXduI6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=N4OzVeFm; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40Q32LId006645;
	Fri, 26 Jan 2024 01:54:20 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vv4fxrxwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 01:54:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPgdeBK3fSi0oYAE6XyIsy5C4unUruTlO9sErv1ttgJPtZMuCXGfSyl67oued8/ZgG0som4dO5DQ5uMQImOIEBxaKPIUtwbh2iKYi7Jui0gg2XX9RR1Ak6ZJVSfyUzpzJOfenQcboyqSvW550x+OQYfGJjJUJIlhl/OmMHM0uBt2WGRe22kGkrnbf4xIVVPvINzcGAsT9xrZz8ORe5w0rWorZE61zKCI6YWrcN85NtYNdf3nLBKaqfnuPAXG/0J5Ef1cGhPgDHHdYCTgNiO9HPbb564GM2nTLMK9viPqJ5fyTtH4mW8N/SUcv08CmfJlJMb31EzZcYxHV9HHrxwYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6pXtVTemkyVnysbbA4JEmQVkU4ud6xL+ZrxCtnKrck=;
 b=QEwVaPJkFJ9WO0csJMkw7hmHohwyd/aPXXBGsBkdFsiGMFBXkwZcV8C37N2EljMGz2Uyj8K7kHC9kdonxJMqJ8AEF2zIXf2zpoJO5cIVRqoVIJ3rMVZFeA/KkKpIkV42DZtFH6JwvnvgJmx/1KVIz0L9lXdkq76yYpmWNLfNj0Hf4JpQiyJoayo8+QDA8BkmmhtkxDR4XbOIkSjZGIIB3G8a2j5Zntj1eYyHVymN+nySyuztkQD38xauTyd5nXZpKrbDFnZSfHbbnnHm4fBSqgGg+mCm615QyXyrZ70OL4jbj6EN5QzD6jjvb/4L5I9iC22Hat1dsIG9DKkNA+3lZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6pXtVTemkyVnysbbA4JEmQVkU4ud6xL+ZrxCtnKrck=;
 b=N4OzVeFm9eQ/O3+S/SYF7qgr74MmHRRn6iwzp/5sv/n3oZUrgV1cLvNcnmsFGkzUe+kse9IkWTviaXaUkANcZn4u/tzaTs+o0gayaYcma2FNsllPIwGkdyhcwi2rS2/GkNFwOF+gCFjhV4nj7LqOJh8AC8rs1YWai80Nbeykrv8=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by LV8PR18MB6098.namprd18.prod.outlook.com (2603:10b6:408:224::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.14; Fri, 26 Jan
 2024 09:54:17 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::fa2f:8d29:5bea:70]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::fa2f:8d29:5bea:70%4]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 09:54:17 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil
 Kovvuri Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXT] Re: [net-next PATCH 0/3] Dynamically allocate BPIDs
Thread-Topic: [EXT] Re: [net-next PATCH 0/3] Dynamically allocate BPIDs
Thread-Index: AQHaTok6SZZ1na3BqkmsVO9wD5LN6LDrXlkAgAB/gUA=
Date: Fri, 26 Jan 2024 09:54:17 +0000
Message-ID: 
 <CH0PR18MB43399B4587C275523A79DFD0CD792@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240124055014.32694-1-gakula@marvell.com>
 <20240125181646.522e6d35@kernel.org>
In-Reply-To: <20240125181646.522e6d35@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ2FrdWxhXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctZGNmNjdmYzEtYmMzMC0xMWVlLWFmMWItMDQ3YmNi?=
 =?us-ascii?Q?YzgxZjdkXGFtZS10ZXN0XGRjZjY3ZmMzLWJjMzAtMTFlZS1hZjFiLTA0N2Jj?=
 =?us-ascii?Q?YmM4MWY3ZGJvZHkudHh0IiBzej0iMzA1NiIgdD0iMTMzNTA3MzY0NTU2ODcx?=
 =?us-ascii?Q?Mjk1IiBoPSIyNXhGQnFoQXREWkYreWIvUVZ1aFdBSGE0T289IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFLSVRBQUIv?=
 =?us-ascii?Q?bGsrZlBWRGFBVzluVURVU05OYS9iMmRRTlJJMDFyOFdBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFDVURRQUFCQTRBQUo0RkFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUVCQUFBQXZEQk91Z0NBQVFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBWkFC?=
 =?us-ascii?Q?eUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQWRRQnpBSFFBYndCdEFGOEFjQUJs?=
 =?us-ascii?Q?QUhJQWN3QnZBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBBWHdCd0FHZ0Fid0J1QUdVQWJnQjFB?=
 =?us-ascii?Q?RzBBWWdCbEFISUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCakFIVUFj?=
 =?us-ascii?Q?d0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFaQUJoQUhNQWFBQmZBSFlBTUFBeUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01B?=
 =?us-ascii?Q?ZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdCckFHVUFlUUIzQUc4QWNnQmtB?=
 =?us-ascii?Q?SE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFHMEFY?=
 =?us-ascii?Q?d0J6QUhNQWJnQmZBRzRBYndCa0FHVUFiQUJwQUcwQWFRQjBBR1VBY2dCZkFI?=
 =?us-ascii?Q?WUFNQUF5QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJqQUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QWN3?=
 =?us-ascii?Q?QndBR0VBWXdCbEFGOEFkZ0F3QURJQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?UUFiQUJ3QUY4QWN3QnJBSGtBY0FCbEFGOEFZd0JvQUdFQWRBQmZBRzBBWlFC?=
 =?us-ascii?Q?ekFITUFZUUJuQUdVQVh3QjJBREFBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWkFCc0FIQUFYd0J6QUd3?=
 =?us-ascii?Q?QVlRQmpBR3NBWHdCakFHZ0FZUUIwQUY4QWJRQmxBSE1BY3dCaEFHY0FaUUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: 
 =?us-ascii?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmtBR3dBY0FCZkFI?=
 =?us-ascii?Q?UUFaUUJoQUcwQWN3QmZBRzhBYmdCbEFHUUFjZ0JwQUhZQVpRQmZBR1lBYVFC?=
 =?us-ascii?Q?c0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUdVQWJRQmhBR2tBYkFCZkFHRUFaQUJrQUhJ?=
 =?us-ascii?Q?QVpRQnpBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUNnQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFiUUJoQUhJQWRnQmxBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhB?=
 =?us-ascii?Q?YmdCaEFHMEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFRQmhB?=
 =?us-ascii?Q?R3dBWHdCaEFHd0Fid0J1QUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFITUFY?=
 =?us-ascii?Q?d0J5QUdVQWN3QjBBSElBYVFCakFIUUFaUUJrQUY4QVlRQnNBRzhBYmdCbEFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUY4QWNBQnlB?=
 =?us-ascii?Q?RzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFISUFaUUJ6QUhRQWNn?=
 =?us-ascii?Q?QnBBR01BZEFCbEFHUUFYd0JvQUdVQWVBQmpBRzhBWkFCbEFITUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUdFQWNnQnRBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-refthree: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlB?=
 =?us-ascii?Q?QUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFad0J2QUc4QVp3QnNB?=
 =?us-ascii?Q?R1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZ?=
 =?us-ascii?Q?UUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBYmdCaEFH?=
 =?us-ascii?Q?MEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFRQmhBR3dBWHdC?=
 =?us-ascii?Q?dEFHRUFjZ0IyQUdVQWJBQnNBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJB?=
 =?us-ascii?Q?QmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFITUFYd0JqQUc4?=
 =?us-ascii?Q?QWJnQm1BR2tBWkFCbEFHNEFkQUJwQUdFQWJBQmZBRzBBWVFCeUFIWUFaUUJz?=
 =?us-ascii?Q?QUd3QVh3QnZBSElBWHdCaEFISUFiUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFB?=
 =?us-ascii?Q?SUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhBYWdC?=
 =?us-ascii?Q?bEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFRQmtBR1VB?=
 =?us-ascii?Q?YmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUJmQUc4QWNnQmZB?=
 =?us-ascii?Q?R2NBYndCdkFHY0FiQUJsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUcw?=
 =?us-ascii?Q?QVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFiZ0Jo?=
 =?us-ascii?Q?QUcwQVpRQnpBRjhBY2dCbEFITUFkQUJ5QUdrQVl3QjBBR1VBWkFCZkFHMEFZ?=
 =?us-ascii?Q?UUJ5QUhZQVpRQnNBR3dBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFB?=
 =?us-ascii?Q?QUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdC?=
 =?us-ascii?Q?dUFHRUFiUUJsQUhNQVh3QnlBR1VBY3dCMEFISUFhUUJqQUhRQVpRQmtBRjhB?=
 =?us-ascii?Q?YlFCaEFISUFkZ0JsQUd3QWJBQmZBRzhBY2dCZkFHRUFjZ0J0QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdV?=
 =?us-ascii?Q?QWJBQnNBRjhBZHdCdkFISUFaQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFB?=
 =?us-ascii?Q?QUFBQUFBZ0FBQUFBQW5nVUFBQUFBQUFBSUFBQUFBQUFBQUFnQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUFBQUIrQlFBQUZnQUFBQmdBQUFBQUFBQUFZUUJrQUdRQWNnQmxB?=
 =?us-ascii?Q?SE1BY3dBQUFDUUFBQUFBQUFBQVl3QjFBSE1BZEFCdkFHMEFYd0J3QUdVQWNn?=
 =?us-ascii?Q?QnpBRzhBYmdBQUFDNEFBQUFBQUFBQVl3QjFBSE1BZEFCdkFHMEFYd0J3QUdn?=
 =?us-ascii?Q?QWJ3QnVBR1VBYmdCMUFHMEFZZ0JsQUhJQUFBQXdBQUFBQUFBQUFHTUFkUUJ6?=
 =?us-ascii?Q?QUhRQWJ3QnRBRjhBY3dCekFHNEFYd0JrQUdFQWN3Qm9BRjhBZGdBd0FESUFB?=
 =?us-ascii?Q?QUF3QUFBQUFBQUFBR01BZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdCckFH?=
 =?us-ascii?Q?VUFlUUIzQUc4QWNnQmtBSE1BQUFBK0FBQUFBQUFBQUdNQWRRQnpBSFFBYndC?=
 =?us-ascii?Q?dEFGOEFjd0J6QUc0QVh3QnVBRzhBWkFCbEFHd0FhUUJ0QUdrQWRBQmxBSElB?=
 =?us-ascii?Q?WHdCMkFEQUFNZ0FBQURJQUFBQUFBQUFBWXdCMUFITUFkQUJ2QUcwQVh3QnpB?=
 =?us-ascii?Q?SE1BYmdCZkFITUFjQUJoQUdNQVpRQmZBSFlBTUFBeUFBQUFQZ0FBQUFBQUFB?=
 =?us-ascii?Q?QmtBR3dBY0FCZkFITUFhd0I1QUhBQVpRQmZBR01BYUFCaEFIUUFYd0J0QUdV?=
 =?us-ascii?Q?QWN3QnpBR0VBWndCbEFGOEFkZ0F3QURJQUFBQTJBQUFBQUFBQUFHUUFiQUJ3?=
 =?us-ascii?Q?QUY4QWN3QnNBR0VBWXdCckFGOEFZd0JvQUdFQWRBQmZBRzBBWlFCekFITUFZ?=
 =?us-ascii?Q?UUJuQUdVQUFBQTRBQUFBQUFBQUFHUUFiQUJ3QUY4QWRBQmxBR0VBYlFCekFG?=
 =?us-ascii?Q?OEFid0J1QUdVQVpBQnlBR2tBZGdCbEFGOEFa?=
x-dg-reffive: 
 =?us-ascii?Q?Z0JwQUd3QVpRQUFBQ1FBQUFBS0FBQUFaUUJ0QUdFQWFRQnNBRjhBWVFCa0FH?=
 =?us-ascii?Q?UUFjZ0JsQUhNQWN3QUFBRmdBQUFBQUFBQUFiUUJoQUhJQWRnQmxBR3dBWHdC?=
 =?us-ascii?Q?d0FISUFid0JxQUdVQVl3QjBBRjhBYmdCaEFHMEFaUUJ6QUY4QVl3QnZBRzRB?=
 =?us-ascii?Q?WmdCcEFHUUFaUUJ1QUhRQWFRQmhBR3dBWHdCaEFHd0Fid0J1QUdVQUFBQlVB?=
 =?us-ascii?Q?QUFBQUFBQUFHMEFZUUJ5QUhZQVpRQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRB?=
 =?us-ascii?Q?QmZBRzRBWVFCdEFHVUFjd0JmQUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdR?=
 =?us-ascii?Q?QVh3QmhBR3dBYndCdUFHVUFBQUJhQUFBQUFBQUFBRzBBWVFCeUFIWUFaUUJz?=
 =?us-ascii?Q?QUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFISUFa?=
 =?us-ascii?Q?UUJ6QUhRQWNnQnBBR01BZEFCbEFHUUFYd0JvQUdVQWVBQmpBRzhBWkFCbEFI?=
 =?us-ascii?Q?TUFBQUFnQUFBQUFBQUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QmhBSElBYlFB?=
 =?us-ascii?Q?QUFDWUFBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUdjQWJ3QnZBR2NB?=
 =?us-ascii?Q?YkFCbEFBQUFYZ0FBQUFBQUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlB?=
 =?us-ascii?Q?RzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFR?=
 =?us-ascii?Q?QmtBR1VBYmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFBQUd3?=
 =?us-ascii?Q?QUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dCdkFHb0FaUUJq?=
 =?us-ascii?Q?QUhRQVh3QnVBR0VBYlFCbEFITUFYd0JqQUc4QWJnQm1BR2tBWkFCbEFHNEFk?=
 =?us-ascii?Q?QUJwQUdFQWJBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZBSElBWHdCaEFI?=
 =?us-ascii?Q?SUFiUUFBQUhJQUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFITUFYd0JqQUc4QWJnQm1BR2tB?=
 =?us-ascii?Q?WkFCbEFHNEFkQUJwQUdFQWJBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZB?=
 =?us-ascii?Q?SElBWHdCbkFHOEFid0JuQUd3QVpRQUFBRm9BQUFBQUFBQUFiUUJoQUhJQWRn?=
 =?us-ascii?Q?QmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdCdUFHRUFiUUJsQUhN?=
 =?us-ascii?Q?QVh3QnlBR1VBY3dCMEFISUFhUUJqQUhRQVpRQmtBRjhBYlFCaEFISUFkZ0Js?=
 =?us-ascii?Q?QUd3QWJBQUFBR2dBQUFBQUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFj?=
 =?us-ascii?Q?Z0J2QUdvQVpRQmpBSFFBWHdCdUFHRUFiUUJsQUhNQVh3QnlBR1VBY3dCMEFI?=
 =?us-ascii?Q?SUFhUUJqQUhRQVpRQmtBRjhBYlFCaEFISUFk?=
x-dg-refsix: 
 Z0JsQUd3QWJBQmZBRzhBY2dCZkFHRUFjZ0J0QUFBQUlnQUFBQUFBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBZHdCdkFISUFaQUFBQUE9PSIvPjwvbWV0YT4=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|LV8PR18MB6098:EE_
x-ms-office365-filtering-correlation-id: c23a9c9e-5463-4264-cec6-08dc1e54c2f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 sT0gFnnpB7Zplx4Lj9ylrmpFhEC0ym+MAV9SuNAfE8HTtmPI9k59TdVWlNPWRNQ7pXnhIeT35n+qOoZoSDJZkeALeLLm/xsFvOFzaWKpcNBG05hm5qLlM6RleZIajDLRtCTjzoBMAR1bjUvjEHxjGaFeIm8r2ZHxyfRAkjZhi+g+K7K7gik+VGKpETEDtK17q6GbMDQsWTpJnXmDzf/eALvQLtoycrWNsaIJhOwH66ptbRAws1oBv/ZBwBrwQTgWd+xdhss9iQXAhsY8oO3GI1OGbsD23M6DCYnpjd+haGgZalB7Z58SxEZoflgQbcmn+rYKER7OC5jyOJRw4O+HRB6A1/dgn3L1TVvTQT/irG7WdZCFWaCWDTx2EyEUFfSXXldFPCf1d3hsgap8Mwg89pyiB8oo67PCwx1tQOkgohNyrgJxNPUgB1ipWPzwvBMR79kk8cVeqHeUnP/2NgbJWRl0i1H1JJ/LHTl8r7uKRSCGcb/emzI15nhAnMeY7+MIoqKfr3bShccY/yXHOG1xAtmabTmQ7i0U0Llz9EqfnaJkeW6QiombsmGD2a410pmAPXkpsVG3XvXIh4TRcBzOkgU8MNJUXcdG7eXZBGAA64iYtWuyIxtUDbbT1qXFJw3/5OMnjz0/2RbjL5CbVIhA3EGs0ID5JKG1vzBZsnpJR8Q=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230173577357003)(230922051799003)(230273577357003)(64100799003)(451199024)(186009)(1800799012)(33656002)(83380400001)(2906002)(5660300002)(52536014)(4326008)(8676002)(122000001)(38070700009)(41300700001)(478600001)(107886003)(38100700002)(66556008)(6916009)(66946007)(54906003)(64756008)(316002)(66476007)(53546011)(76116006)(66446008)(86362001)(9686003)(71200400001)(55016003)(6506007)(7696005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?pxTE04ZuPcYCAl/bmxKB4atKNN/szD37MsZFZg4apA1kTMc0YTUsr8z6O9Gq?=
 =?us-ascii?Q?aYaemUEzGzJbfkLgou3cwQ7A5q8IWn/2SxpfS8uIJayn/bF+OGjaRK80pR1G?=
 =?us-ascii?Q?z4ewmyPv7AOxIfFgLnJdkMSaKWlaO1U09PobJcw6coAVnZBEqDIwVg/UQNos?=
 =?us-ascii?Q?O+M4FlD1+PcpffFodWtlvNtmww6TR5YrFs5PkX6j54AYGuYyQQ5t7DoXEcjM?=
 =?us-ascii?Q?7M98X/aezhZipib2QuHDmLOnQHMuFj2Mks5p++vT3G0ZYYDLvAqXG4fAqPrK?=
 =?us-ascii?Q?OsunlrRbsEHS4U1aJeEOCV2xyoa8ieO65UulQap0UkuOrZ3VELYnVNyeUgir?=
 =?us-ascii?Q?RuiC4NQCWhNbxbgx80KlXqA/yJeeZvJhJcxVj0x7Kfd1urSBniUxeXDepSxp?=
 =?us-ascii?Q?rivKwZue4fPwQcsshUuNzJHWrnIDvGF/UjwLYAR+XVY9qE5njNwqc5oY5AIr?=
 =?us-ascii?Q?XioShUbUaeE9M+Bt6uP350G51adLQ5G/pY+uIad35O3QgYSrzH6QtHuyG5ML?=
 =?us-ascii?Q?5L+JOAL/l1lUTRE4j3tXIF5OujOKIEk63prRDNROPSCwibZIA0VXWDYyneK2?=
 =?us-ascii?Q?M/EIg4GJfWqVYU7rJIelekE/+FGABfLrCImuipPRfIK1YYTLJPAguFmYt7jC?=
 =?us-ascii?Q?/P0GorUPERCbS/cbazRupfuqiOQMgDKladnysEa7H/XABOc0iR1tF5udoCTy?=
 =?us-ascii?Q?Hyu1HlvgZmVXj0tmNP3kcq6X9W/mTC82KK482R/VHcpJ5HgUKvzKWOUrNtzH?=
 =?us-ascii?Q?nIg/q6lU6FftzeGS+a/hXXkavghYAIZsEkPsQnjCdN+jK1iYal2hGq86rhIH?=
 =?us-ascii?Q?B4IJkOd/eQe/iyUO68Nj8FB1G8VlnqCtVSpi9MhvK9WkhGOB5PNSTTAsDHEM?=
 =?us-ascii?Q?+/wVW+I1IiBI51+R2obQ+RhT1+4DanarKKP6/v0qHLHpoj4Qx5epA2A7gHeC?=
 =?us-ascii?Q?yareaIjZez3bP6Mbl+cbgpugktLssyZW8dfNfU+LQx/k1+kH767yG1I/taIA?=
 =?us-ascii?Q?1KhllSowKaOCHzBjh5EvxTkczwhsDfdifcy3iEcbjZ19NFWzSW/qmLCWUIwR?=
 =?us-ascii?Q?c6KleE0VkNkke3iuZmyoD1r4UYyz1+KYSH3bfJ59tI0lTZCM3+r4CdGX9qVc?=
 =?us-ascii?Q?q+s3HkokjSIoP+PGK1l16RdFVgpPyWg6AGyW7t14vEL/xyVLKUXaEh0CNiLs?=
 =?us-ascii?Q?tY9MuG3Fbch4gM3fe022p1rGgCMjjF24t4tOGJIGQ5S0evHFzx+NK/CdJErr?=
 =?us-ascii?Q?2S0mxFinJ6FcQelL6aQDDwuwPI4S0UUmeajGpwGYvrE2rPg/99Cb6rRZG9z3?=
 =?us-ascii?Q?LWmKfqBDxHlhfkwSuaoLcvhw8k9UpgWfcYVVAeeKZAZnPTBANdE46sdz2AYL?=
 =?us-ascii?Q?0mFB7sI5lVtdAQnK794yiQBpLi7i2PuT/sFt7Bks56PEnaDp3+ZdNyLDYcZU?=
 =?us-ascii?Q?SnTj4qkGGbqMq000Nshzgtb6AY0y0eAtchEZAxA4pl22WNXIaKjnCCnNZ300?=
 =?us-ascii?Q?r104IduN1tcBIwYQy6Kpngp5Vx2xDHH4VLzMazXZkvAy9lMwjRoXdZAIrG1H?=
 =?us-ascii?Q?A6n9tZx/QJ5DIFDpan75qVU+L1KpjKh+f8yum/IkRvgvGnlDAme369mfqKJC?=
 =?us-ascii?Q?gvBZCJZl91qjuyp5LtQHO62ft7vN0tdMDo8P8ZVT573K?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23a9c9e-5463-4264-cec6-08dc1e54c2f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 09:54:17.6741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4c8heBvJjXYo5gm6UihWDwO+w9tEpUOF57SBVS3zWDTvy8Oy95Huemn3BGfUd8M02PIOdjFJVd2g+IrDxWzvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6098
X-Proofpoint-GUID: 51mnjtWtnTJ7aoYvnD1FpESio48kyACv
X-Proofpoint-ORIG-GUID: 51mnjtWtnTJ7aoYvnD1FpESio48kyACv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, January 26, 2024 7:47 AM
> To: Geethasowjanya Akula <gakula@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
> Subject: [EXT] Re: [net-next PATCH 0/3] Dynamically allocate BPIDs
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Wed, 24 Jan 2024 11:20:11 +0530 Geetha sowjanya wrote:
> > Current hw support 512 backpressure(BP) Ids. These BPIDs are
> > statically reserved among 4 interface types based on number of
> > channels supported. Latest HW support configuring multiple BPIDs per
> > channel. To support this feature, the patch set creates BPIDs free
> > pool from the BPIDs reserved for LBK channel as, LBK uses single BPIDs
> > across multiple channels and on request it dynamically allocates N
> > number of bpids from the free pool. This patch also reworks the LBK
> > device id checks.
>=20
> I looked at this for 20 min, I don't understand how this fits together.
> Please improve the commit messages to also explain the functionality and
> how user interacts with the features.

Will rework on the commit message and submit v2.=20

