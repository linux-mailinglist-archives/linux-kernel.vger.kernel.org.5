Return-Path: <linux-kernel+bounces-44438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4F284220B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFB01F2815F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB9D664B0;
	Tue, 30 Jan 2024 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="nLoM89Ry"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61655657DD;
	Tue, 30 Jan 2024 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612233; cv=fail; b=faVEQJ8i44b7lyl5XNEEleWfu9dTd7SPEf8jESYCIL9l3z+/Yre+NYzdM0XiTWM5fzw+8goI0KMXK5tY24WH37tFkp8fmVfpowBJW/GnwxadGP3wHIWnyKAvzP2nqtk4ZVVr0p9SNyhMs8SHzdW7Daxepv9pJYB1Bix8tm3hlvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612233; c=relaxed/simple;
	bh=9VzY0ukd+K0TO2JDjdlYuEKNhyLwU4nehvZwA1pv1yE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GrXGrq5ytZyxsEvYwvo9PAaYsZCtBUOaB7lKMHXm4XAZV99MYDo6pawHbYHImwTw/NtRx5bVCnlGohimoBL81Lu+1NNnAFGENKg0kj6tioGf3wdrUQuaolSd6DGIf/cplq/FeQ/AaV842ZaRN2uQQKXeGkixQSuJ+IJcQLJxBc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=nLoM89Ry; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U8LpvW020251;
	Tue, 30 Jan 2024 02:56:53 -0800
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vw27nhckc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 02:56:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmtiIRHgxYuqvEtuwsXxs12fqtEmsUx++7GqUw096DNch0fN+mf5vk7OxFWGM/wOJjtuxQKJHCs9YPOQXU0gHO/d9pI3U+sDw+C2w9dLMT3Osv46bbqylaUze7kPfuh+RUcOw/gMwABosUPdsXmNhPZpKhf7wlPWCbA3Sej+RlcvveKTOugCm1fzUUSftH0PV+4Ayp7QOB5+KmYqz21uO3EUxRvAsPxUQCNxrQ4d00U5pnFKbIS8FVXtIpeEygwHhcrJ5cLbZUXZuhDpom/GhtI4ynkzaw2aoSxAIIXDEttaIOBH2cUaqedAeF3/jNMC+b/2QOhYtTKuBzNCLLFwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aU12L2yF9CN3IrrI8eiUic7zvo3ujUZAG0HTzMzvPLI=;
 b=TOeQPcWpl6YzjlX1bwF7mkFSHCoP6oVP7StejdDbJTf4YzbZ9OC4SR8xUh5MmpPUTL9hNYMEP7p+exyPem/lXzLy7HBQKjpuObA7LfghhGoG+JDEwb0vJeICxMIeO9lT39y/2wTOX3SZcSlSbZsA9y6ElhX16d/Umg1koHnhx/EzaXJORbCqm7lPUpEPa2SYEVEho/rKMcehARrXEDqdrwKYxKsOBC/AVf1q43TQf9YwfmZEtSAXcVdcCieTW7i+ZafyDlKZG0IPjWUt+vEcgTgoHcVg/1mZDM/89IYjWnMNtMO+RFGkG5lUtqVkt/dCSHXQL+aMUq56lx9qk++B6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aU12L2yF9CN3IrrI8eiUic7zvo3ujUZAG0HTzMzvPLI=;
 b=nLoM89RyTgLPj+AmxAqmK1VTGGhUpp9Y1r1gI7ECSS1kpgd+t8M2ySbMAzmLZx0jEu6jiXSEWNysoqt/5wJm9mq3+4Unlp7aDXhADqKoI1IYi69Mpl0onllzMA13qoncanZqDNAxVU3XUcbHJlV/vSnQBcDRbEPzaQ4ZRDgJfGc=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by DM8PR18MB4438.namprd18.prod.outlook.com (2603:10b6:8:3d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 10:56:37 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::3cca:92a0:1e88:5f24]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::3cca:92a0:1e88:5f24%7]) with mapi id 15.20.7249.017; Tue, 30 Jan 2024
 10:56:37 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Naveen Mamindlapalli
	<naveenm@marvell.com>
Subject: Re: [net-next PATCH] octeontx2: Add PTP clock driver for Octeon PTM
 clock.
Thread-Topic: [net-next PATCH] octeontx2: Add PTP clock driver for Octeon PTM
 clock.
Thread-Index: AQHaU2r/3q7bgzzZEEmTAPAsMLYhuQ==
Date: Tue, 30 Jan 2024 10:56:37 +0000
Message-ID: 
 <BY3PR18MB47075899686A57C3FBA0A7CFA07D2@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240124064156.2577119-1-saikrishnag@marvell.com>
 <20240129105921.GJ401354@kernel.org>
In-Reply-To: <20240129105921.GJ401354@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2Fpa3Jpc2hu?=
 =?us-ascii?Q?YWdcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?us-ascii?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy0zYmQ4ZjM1OC1iZjVlLTExZWUtYWQyZS0x?=
 =?us-ascii?Q?Y2MxMGM0MGQ5ZTRcYW1lLXRlc3RcM2JkOGYzNWEtYmY1ZS0xMWVlLWFkMmUt?=
 =?us-ascii?Q?MWNjMTBjNDBkOWU0Ym9keS50eHQiIHN6PSIxMTE4MiIgdD0iMTMzNTEwODU3?=
 =?us-ascii?Q?OTU3MTY1MjUxIiBoPSJHaVdFL3BEY1UwZWxEaG5EZU5xVVc5RHFLTk09IiBp?=
 =?us-ascii?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFC?=
 =?us-ascii?Q?Z1dBQUREeURIK2FsUGFBVDEzdFhIU3ZkcTRQWGUxY2RLOTJyZ1pBQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBT2dZQUFBQUFBQUFJQUFBQUFBQUFBQWdB?=
 =?us-ascii?Q?QUFBQUFBQUFDQUFBQUFBQUFBQWFCZ0FBR1FB?=
x-dg-reffive: 
 =?us-ascii?Q?QUFCZ0FBQUFBQUFBQVlRQmtBR1FBY2dCbEFITUFjd0FBQUNRQUFBQUJBQUFB?=
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
 =?us-ascii?Q?Z0JsQUY4QVpnQnBBR3dBWlFBQUFDUUFBQUFRQUFBQVpRQnRBR0VBYVFCc0FG?=
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
 =?us-ascii?Q?QmxBSElBYlFCcEFHNEFkUUJ6QUFBQUlnQUFBQUVBQUFCdEFHRUFjZ0IyQUdV?=
 =?us-ascii?Q?QWJBQnNBRjhBZHdCdkFISUFaQUFBQUE9PSIvPjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|DM8PR18MB4438:EE_
x-ms-office365-filtering-correlation-id: 79477646-3341-47f3-7e44-08dc218221dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 KLWlFrSFIDGtBOXV34/4OaFewpO/N/rKH+4gFvxeROqv6BKBAz2SxdbWUTkPlb/KQn7tOnXUwLFni0LipTvqM9Whenk3douDCqHfR4bU3lfns2ILW8PZdWDA2qjnW9D6R759aOxtySMUc94tgNOUPVs/kKeB97noqDNOTqPk18o20VHmYK+lnzE809GxCjRN7DHTjBa3EE0IxIh3VPcwvrSW7im5vP/hOP+UjJB41L2ptbGbCzDAnb6WFVQp8axBw1UVMOz1GtzlCzNK+0G8WzZx5QAd77+tJKYkwfuegSPKVYlfadzPj617H94b6+jEOGo9a/6XK9/nMdOITetJJ/DMIZgb6nIVCoNwbutbP54sxANFhNG3yoOYapSLKy+V5Gd0/V3v7HiIJCc7ZBK02gbnu6O3STQ7DXNO3LrZhy1CJf+hg5xUmQfICqc7za9qqZgfFmXaahBOtH6v3OFfbq4tHD+PgQ58pByW7Efp8TLg1hn0DGdKbwEQRsMFe2v+ACMsJ53lW64rzHS1pNHXcBkKRTOH43GdIDLpVLmi7/1mUpy/hnCFRTbaNmHqM52siofq9Y00wZws6jJDWmSeZmkuRvp/rq+I45uh9C+elngZ4EV8LoOZsDBUhSC7OusS
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(39860400002)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(4326008)(71200400001)(8676002)(478600001)(6916009)(316002)(8936002)(55016003)(122000001)(38100700002)(53546011)(2906002)(33656002)(83380400001)(9686003)(52536014)(7696005)(6506007)(86362001)(66446008)(64756008)(54906003)(76116006)(41300700001)(38070700009)(107886003)(5660300002)(26005)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ZCkM1cMLEa5o6U5P2F1eR3JwOf3XHYtpp6OAOCgFQZO+2E908WD/j19yc4mq?=
 =?us-ascii?Q?zEML3AsmNukxzg+0qtq2BIhl9DhH2+F7aUUk63DSDoduFVgpJFy8NJ+KZzDs?=
 =?us-ascii?Q?Ua/MdcWR6ZFeie4SMUONJgPvMKxKKcN7vhd8HfL2FroVO2mKaudq+kUdU5uS?=
 =?us-ascii?Q?9xmi03wZGbVFxgkKwecBRk4nIR8s1e6ezTExX/y1m6LeeKZ7GFPq5Zps5qgK?=
 =?us-ascii?Q?BLEnGRELssJc7wYcP8syf8ExOnMf+rbpM0f4a9r2XMDwprLe5Y0/xQQfHzHW?=
 =?us-ascii?Q?LUNEQUlxv6uZACawJfrvyvEfIW7ood0z5vYaMK/FOpl6X3hacOtjDcgnEHv9?=
 =?us-ascii?Q?FXy1Ip9Y+7w0S4L6HYYnbKx3Qnyvg93y3/e27qr7x4aI9q+cssSrTacDsMlx?=
 =?us-ascii?Q?+lsai/VxlOf1ZqcH6K5SA+2DLoPvxEgTN24+4EAgqEMjIXYd7hZVxd2ZJUTL?=
 =?us-ascii?Q?PQjNpK+2groOhEBo9z7cGvEEVU8gzM69Bf/ABcKxFZPUZO/sEl6+hyNVoQhV?=
 =?us-ascii?Q?2OW6vZ1eANTJEH6ZHYkMgAFq8NeM0JpANaaq1v48tyQfQjZ+xvnWpp1Vli1Q?=
 =?us-ascii?Q?FnjF+lx15pq+CUBBr0MNZcfcPMwzcTJzi5OlJrh9vsWzKFS9M7TR3MDDBFH8?=
 =?us-ascii?Q?kulMDc2Bt+aDvZV6z67gXFZyagSw0mp1Q+aRNMSfIGiPoyuaWSLylrnbiPEt?=
 =?us-ascii?Q?LCWxWwhm7HJl9WU2UkjAAGj9eGRiVmAoNg5OFYVfgsAq4m8RGAhHfMNbkH5C?=
 =?us-ascii?Q?W2tYuycKg1Cv/HAEoM4Tvq4FBHbUNHrdO6Tg1+TtjK6fojF2Uj14eCFlNuaJ?=
 =?us-ascii?Q?Ax8ZYqZK3RCf47QlR3ry0e5QrxXICw3/2kU0k7Dmi2WxdpYKuqXau68O5uDL?=
 =?us-ascii?Q?R1JrmOLd0PA/YQy0Maf1betSIXIhsG9NV9YKvMc2+XaqOxVCzB9qF8v5vz6e?=
 =?us-ascii?Q?aQFgHvK4gLpIYCFHdb31IEtK+aRSef2zPZE4GIgFq3J1eQ5/6NCGN0yaBUVF?=
 =?us-ascii?Q?MIFbz1vZVgfX86WOL3qrL5tl3RtVwoDvB7JrWgFnHZ46viEBpHAxJcRxnh7S?=
 =?us-ascii?Q?ZhUzlD3c1wt7s1+T+YaQo1h842vq1mti4k/mcYW9WmlQmVcWHpEy8CqgXWtL?=
 =?us-ascii?Q?zpwt8R4KdGs/I4NeqifLU9An/FSwev5ZX+nFn9l1FTe0syJ/6VmiaiLYI9ow?=
 =?us-ascii?Q?goYusTQne8fGqxp8M3ZhJpy9n7SmdJZOUG+Wyec0QYOY631JDwlwRtaWrbzu?=
 =?us-ascii?Q?p1gptltgEMgHlimGozTC3FU10wpA8KCsuER/M2JcEO6aiU4YuZLdGoF//Wss?=
 =?us-ascii?Q?ySCnZGceuIP/Y42tWS9eDpdJGfSR6499Ld6ZCoOWMrusoNL/YcxmuBQ2HfF9?=
 =?us-ascii?Q?x2MavtW5UG6nBHkRlb9oAABpJWaNnzQqPFDo8c2jGRCwaFnA3qlgMsBtL0fR?=
 =?us-ascii?Q?/SUJ8otB3QqPPAjf/HIhNqY88EWiZIf32UpM+qavMMJzszzB4cGsb+7ynltA?=
 =?us-ascii?Q?MW9wBPhXcG5JwH7vgiigd+/YFOvq2iMFz2QuEXX5dj6ylF6oCWUZ7+FlvdQt?=
 =?us-ascii?Q?Ab312rx20UupALLMA4ol/TRVMvO7jlirPuMujjFC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 79477646-3341-47f3-7e44-08dc218221dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 10:56:37.7264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JUVLcn4Ku+rm4Kdscjbhglusxwn0CM3+TLSvsSQnKnbUZsHCklDP8ciqEiEYpSXolxS1ZMAf5cE/fgOQZwb/iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4438
X-Proofpoint-ORIG-GUID: j5JCBsKKgBooRL1yOhwJIa2AtyxAifvp
X-Proofpoint-GUID: j5JCBsKKgBooRL1yOhwJIa2AtyxAifvp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02


> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Monday, January 29, 2024 4:29 PM
> To: Sai Krishna Gajula <saikrishnag@marvell.com>
> Cc: richardcochran@gmail.com; davem@davemloft.net; kuba@kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri
> Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> <gakula@marvell.com>; Linu Cherian <lcherian@marvell.com>; Hariprasad
> Kelam <hkelam@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Naveen Mamindlapalli <naveenm@marvell.com>
> Subject: Re: [net-next PATCH] octeontx2: Add PTP clock driver for
> Octeon PTM clock.
>=20
> On Wed, Jan 24, 2024 at 12:11:56PM +0530, Sai Krishna wrote:
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
>=20
> Hi Sai,
>=20
> some minor review items from my side.
>=20
> > diff --git a/drivers/ptp/ptp_octeon_ptm.c
> > b/drivers/ptp/ptp_octeon_ptm.c
>=20
> ...
>=20
> > +static u32 read_pcie_config32(int ep_pem, int cfg_addr) {
> > +	void __iomem *addr;
> > +	u64 val;
> > +
> > +	if (oct_ptp_clock.cn10k_variant) {
> > +		addr  =3D ioremap(PEMX_PFX_CSX_PFCFGX(ep_pem, 0,
> cfg_addr), 8);
> > +		if (!addr) {
> > +			pr_err("PTM_EP: Failed to ioremap Octeon CSR
> space\n");
> > +			return -1U;
> > +		}
> > +		val =3D readl(addr);
> > +		iounmap(addr);
> > +	} else {
> > +		addr  =3D ioremap(PEMX_CFG_RD(ep_pem), 8);
> > +		if (!addr) {
> > +			pr_err("PTM_EP: Failed to ioremap Octeon CSR
> space\n");
> > +			return -1U;
> > +		}
> > +		val =3D ((1 << 15) | (cfg_addr & 0xfff));
> > +		writeq(val, addr);
>=20
> This causes a build failure on x86_32 because writeq() is undefined.

Ack, Will add ARM64 dependency in Kconfig  (depends on (64BIT && COMPILE_TE=
ST) || ARM64).  Hope this works!!

>=20
> > +		val =3D readq(addr) >> 32;
> > +		iounmap(addr);
> > +	}
> > +	return (val & 0xffffffff);
> > +}
> > +
> > +static uint64_t octeon_csr_read(u64 csr_addr) {
> > +	u64 val;
> > +	void __iomem *addr;
>=20
> nit: In Networking code, please consider arranging local variables
>      in reverse xmas tree order - longest line to shortest.

Ack,  yeah missed this.. will change in patch V2.

>=20
> > +
> > +	addr =3D ioremap(csr_addr, 8);
> > +	if (!addr) {
> > +		pr_err("PTM_EP: Failed to ioremap CSR space\n");
> > +		return -1UL;
> > +	}
> > +	val =3D (u64)READ_ONCE(*(u64 __iomem *)addr);
>=20
> Sparse seems unhappy about this cast.
> So if this is really what you want to do then probably a __force is neede=
d in
> the cast.
>=20
> But I do wonder if there is an endian consideration that needs to be take=
n
> care of here. And, moreover, if a standard routine, such as ioread64(), c=
ould
> be used instead of this function.
>=20
> N.B. as per the note on writeq, possibly this only works on 64bit systems=
.
>=20
> Likewise elsewhere in this patch.
>=20

Ack,  will submit the changes in patch V2.

> > +	iounmap(addr);
> > +	return val;
> > +}
>=20
> ...
>=20
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
> > +oct_ptp_clock.ptp_clock->index);
>=20
> It seems that the pr_info() call above assumes that oct_ptp_clock.ptp_clo=
ck
> is not an error, but it may be.
>=20
> Perhaps something like this is more appropriate:
>=20
> 	oct_ptp_clock.ptp_clock =3D ...
> 	if (IS_ERR(oct_ptp_clock.ptp_clock))
> 		ERR_PTR(oct_ptp_clock.ptp_clock);
>=20
> 	pr_info(...)
> 	...
>=20
> 	return 0;
>=20
> Flagged by Smatch.

Ack,  will submit the changes in patch V2.

>=20
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


Thanks,
Sai

