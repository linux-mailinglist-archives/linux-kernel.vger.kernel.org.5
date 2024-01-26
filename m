Return-Path: <linux-kernel+bounces-39958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E0F83D7D1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD471C2A857
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDEF16428;
	Fri, 26 Jan 2024 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="q3Ac/WJk"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A7012B6C;
	Fri, 26 Jan 2024 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706262787; cv=fail; b=bAbW91m1w1Z/ZSgVL2uH+9kv1Te2Su5y8dg7eAcu5f4TwlONbFX+KQN1SrzmiFQub/a/pdlh+8T3to/tkvqCE1wIX4Io/DwOa0jtbddqYt4zTrnK8w07YrmFKUsXpOUMMaiZVtYFoFO0Q9nKb1Zw+FRvbogJgYC/JTqzY0y/Ujk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706262787; c=relaxed/simple;
	bh=M4JWn6QqojR9d6LBmq7+nopP/7xWPctJz8aeGI7IPQo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i+zfdczIxShK/rb609XJmcGO7Xir1/cLCzSq0d39744zt2yA0P8egBOuVs0Ae+REUm/+ZBy/EeN6oAdo3wZx068xhmlajXwJqrME3BqnD4A75MxqiJhtZ1CLL2kBjPNRkJhO1RORb4PSNnQ77qvoNNveqVXmjfkZQmW3fVZht8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=q3Ac/WJk; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40Q32Wkx024987;
	Fri, 26 Jan 2024 01:52:45 -0800
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vv4g0gxk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 01:52:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArR4DoAKavdjQComXpMS2+tINHlYbCGh4xr0BU5/9EnzG5GDqNM6vR4WW/+dTHs6nhXl8lV8fKLAueNntf6L7erC1oYxq1UZ6LazPa6ry9FLKKyYdAiLs4T3E8DmAN/z4Gy6gl7LNulu4SusHu44mbtUIdawSSQkpr6361FVPbhSeIQxqPivoADdBh4GSEzv1mnr67mKMjntZUat/oPHv4mS/MmqF/vich1p/aeClplvkOxTB8vwXup/kEachQK0lObPfuHqmD24K2GTDZ3uoOWXLBW4fbaG0dBYCWbq0ahwVUQXxRLpugl3kHpODhp8MjYKuuzx364fMd5RZfOzdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPaqXEHsK/bdAjhTwflY8BwTX/mV0EPjBsCpvWreXm8=;
 b=jd3+OqWjfdBYHNbunz8AdaYa7fmzt5SNzKpXlQx3lEcZbtXjW4YDjaaNLDfPz81YGpEuJ2aWUkObJL9o0a0P9owiHTvQObo9D7TCbPJAe/8PGzZ3PK3g9xdgnp8pHcynFDhL8zUAfhNkx6hts2NyTJY1FdMWxqvIExzvM4CLlKYDwl7D3aWp6fsRW+RaZEtfI/koXfAUiiZV+QWSSctwRt/KhD1E4qgrT6DIszY/YBWCh8WRfeTbGum3bn24ZPIApnJ5ydUDueLfQT7/ZMAaVxefwoTC+h+GTeUF3goe5nPa8u+BTBM676GXOH6vBEWzvrCtEg4N26z+aFuCM87JuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPaqXEHsK/bdAjhTwflY8BwTX/mV0EPjBsCpvWreXm8=;
 b=q3Ac/WJkmu/ycQEQvl21M6pzJa4gNKa2yPHlN1w8x+vr7by39wIwafsXoLyi6+gtzkXBMO9XAEHTNhn/EqluOb3iUFKz2kIKTINjJgKE8TwYWa3UMhhVEnb4lZ+zQUCP+c5y3N739M7/uY6JWYSFR9GzO26DTd3i0h2OgMfYbMs=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by LV8PR18MB6098.namprd18.prod.outlook.com (2603:10b6:408:224::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.14; Fri, 26 Jan
 2024 09:52:42 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::fa2f:8d29:5bea:70]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::fa2f:8d29:5bea:70%4]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 09:52:41 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXT] Re: [net-next PATCH 1/3] octeontx2-af: Create BPIDs free
 pool
Thread-Topic: [EXT] Re: [net-next PATCH 1/3] octeontx2-af: Create BPIDs free
 pool
Thread-Index: AQHaTok8aUkkR9PDFEyZWfgUDbMGuLDqZ5gAgAF1l1A=
Date: Fri, 26 Jan 2024 09:52:41 +0000
Message-ID: 
 <CH0PR18MB433913F678EED5D6A5F52DD4CD792@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240124055014.32694-1-gakula@marvell.com>
 <20240124055014.32694-2-gakula@marvell.com>
 <20240125113336.GF217708@kernel.org>
In-Reply-To: <20240125113336.GF217708@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ2FrdWxhXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctYTFlNGY2NDAtYmMzMC0xMWVlLWFmMWItMDQ3YmNi?=
 =?us-ascii?Q?YzgxZjdkXGFtZS10ZXN0XGExZTRmNjQyLWJjMzAtMTFlZS1hZjFiLTA0N2Jj?=
 =?us-ascii?Q?YmM4MWY3ZGJvZHkudHh0IiBzej0iNjg1NCIgdD0iMTMzNTA3MzYzNTY1ODUx?=
 =?us-ascii?Q?NjI1IiBoPSJqc0s3OEhkSElKaW94eDFteHBBVWwwaFUxNkE9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFBNEdBQURw?=
 =?us-ascii?Q?MHoxa1BWRGFBUk00eHFmbU9TSzZFempHcCtZNUlyb0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFjQUFBQUo0RkFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUVCQUFBQXZEQk91Z0NBQVFBQUFBQUFBQUFBQUo0RkFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUFBQUFJQUFBQUFBQUFBQWdBQUFBQUFBQUFmZ1VBQUJZQUFBQVlBQUFB?=
 =?us-ascii?Q?QUFBQUFHRUFaQUJrQUhJQVpRQnpBSE1BQUFBa0FBQUFBQUFBQUdNQWRRQnpB?=
 =?us-ascii?Q?SFFBYndCdEFGOEFjQUJsQUhJQWN3QnZBRzRBQUFBdUFBQUFBQUFBQUdNQWRR?=
 =?us-ascii?Q?QnpBSFFBYndCdEFGOEFjQUJvQUc4QWJnQmxBRzRBZFFCdEFHSUFaUUJ5QUFB?=
 =?us-ascii?Q?QU1BQUFBQUFBQUFCakFIVUFjd0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFaQUJo?=
 =?us-ascii?Q?QUhNQWFBQmZBSFlBTUFBeUFBQUFNQUFBQUFBQUFBQmpBSFVBY3dCMEFHOEFi?=
 =?us-ascii?Q?UUJmQUhNQWN3QnVBRjhBYXdCbEFIa0Fkd0J2QUhJQVpBQnpBQUFBUGdBQUFB?=
 =?us-ascii?Q?QUFBQUJqQUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QWJnQnZBR1FBWlFC?=
 =?us-ascii?Q?c0FHa0FiUUJwQUhRQVpRQnlBRjhBZGdBd0FESUFBQUF5QUFBQUFBQUFBR01B?=
 =?us-ascii?Q?ZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdCekFIQUFZUUJqQUdVQVh3QjJB?=
 =?us-ascii?Q?REFBTWdBQUFENEFBQUFBQUFBQVpBQnNBSEFBWHdCekFHc0FlUUJ3QUdVQVh3?=
 =?us-ascii?Q?QmpBR2dBWVFCMEFGOEFiUUJsQUhNQWN3QmhBR2NBWlFCZkFIWUFNQUF5QUFB?=
 =?us-ascii?Q?QU5nQUFBQUFBQUFCa0FHd0FjQUJmQUhNQWJBQmhBR01BYXdCZkFHTUFhQUJo?=
 =?us-ascii?Q?QUhRQVh3QnRBR1VBY3dCekFHRUFad0JsQUFBQU9BQUFBQUFBQUFCa0FHd0Fj?=
 =?us-ascii?Q?QUJmQUhRQVpRQmhBRzBBY3dCZkFHOEFiZ0JsQUdRQWNnQnBBSFlBWlFCZkFH?=
 =?us-ascii?Q?WUFhUUJzQUdVQUFBQWtBQUFBQUFBQUFHVUFi?=
x-dg-refone: 
 =?us-ascii?Q?UUJoQUdrQWJBQmZBR0VBWkFCa0FISUFaUUJ6QUhNQUFBQllBQUFBQUFBQUFH?=
 =?us-ascii?Q?MEFZUUJ5QUhZQVpRQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFC?=
 =?us-ascii?Q?dEFHVUFjd0JmQUdNQWJ3QnVBR1lBYVFCa0FHVUFiZ0IwQUdrQVlRQnNBRjhB?=
 =?us-ascii?Q?WVFCc0FHOEFiZ0JsQUFBQVZBQUFBQUFBQUFCdEFHRUFjZ0IyQUdVQWJBQmZB?=
 =?us-ascii?Q?SEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFITUFYd0J5QUdVQWN3?=
 =?us-ascii?Q?QjBBSElBYVFCakFIUUFaUUJrQUY4QVlRQnNBRzhBYmdCbEFBQUFXZ0FBQUFB?=
 =?us-ascii?Q?QUFBQnRBR0VBY2dCMkFHVUFiQUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0J1?=
 =?us-ascii?Q?QUdFQWJRQmxBSE1BWHdCeUFHVUFjd0IwQUhJQWFRQmpBSFFBWlFCa0FGOEFh?=
 =?us-ascii?Q?QUJsQUhnQVl3QnZBR1FBWlFCekFBQUFJQUFBQUFBQUFBQnRBR0VBY2dCMkFH?=
 =?us-ascii?Q?VUFiQUJzQUY4QVlRQnlBRzBBQUFBbUFBQUFBQUFBQUcwQVlRQnlBSFlBWlFC?=
 =?us-ascii?Q?c0FHd0FYd0JuQUc4QWJ3Qm5BR3dBWlFBQUFGNEFBQUFBQUFBQWJRQmhBSElB?=
 =?us-ascii?Q?ZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0J1QUdFQWJRQmxB?=
 =?us-ascii?Q?SE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRBZEFCcEFHRUFiQUJmQUcwQVlR?=
 =?us-ascii?Q?QnlBSFlBWlFCc0FHd0FBQUJzQUFBQUFBQUFBRzBBWVFCeUFIWUFaUUJzQUd3?=
 =?us-ascii?Q?QVh3QndBSElBYndCcUFHVUFZd0IwQUY4QWJnQmhBRzBBWlFCekFGOEFZd0J2?=
 =?us-ascii?Q?QUc0QVpnQnBBR1FBWlFCdUFIUUFhUUJoQUd3QVh3QnRBR0VBY2dCMkFHVUFi?=
 =?us-ascii?Q?QUJzQUY4QWJ3QnlBRjhBWVFCeUFHMEFBQUJ5QUFBQUFBQUFBRzBBWVFCeUFI?=
 =?us-ascii?Q?WUFaUUJzQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4QWJnQmhBRzBBWlFC?=
 =?us-ascii?Q?ekFGOEFZd0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFhUUJoQUd3QVh3QnRBR0VB?=
 =?us-ascii?Q?Y2dCMkFHVUFiQUJzQUY4QWJ3QnlBRjhBWndCdkFHOEFad0JzQUdVQUFBQmFB?=
 =?us-ascii?Q?QUFBQUFBQUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3?=
 =?us-ascii?Q?QjBBRjhBYmdCaEFHMEFaUUJ6QUY4QWNnQmxBSE1BZEFCeUFHa0FZd0IwQUdV?=
 =?us-ascii?Q?QVpBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QUFBQm9BQUFBQUFBQUFHMEFZUUJ5?=
 =?us-ascii?Q?QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBYmdCaEFHMEFa?=
 =?us-ascii?Q?UUJ6QUY4QWNnQmxBSE1BZEFCeUFHa0FZd0IwQUdVQVpBQmZBRzBBWVFCeUFI?=
 =?us-ascii?Q?WUFaUUJzQUd3QVh3QnZBSElBWHdCaEFISUFi?=
x-dg-reftwo: 
 UUFBQUNJQUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSGNBYndCeUFHUUFBQUE9Ii8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|LV8PR18MB6098:EE_
x-ms-office365-filtering-correlation-id: 5ed41996-9ea0-4dbd-a71e-08dc1e5489d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 4Cp5IgPYxJ+7cJwg/Ne5kGG3HcXadJ5aFjYXz3b8sfJxMGsTEVX9r1bWfHNJM/mRYyu54iW7ScHrU0+WvkIlbxwICL4+GXs8XWmzqAaJzNQO9khJTtxPalEHA6r2EXY0glmFlx7azBVNdfKdDCG8fhPeUxtt5lCm7cab5QyNx+F/RgFeyuYCTlXTSEaSZCx8l1D0yWxdPF8RZrdr4k7Iu5UHuEtuZ/4TapHSTXO+O1K/13ZEK+SconZejzp4wJd9lKdgMFWVMrDn6aaAtYEsPO3WiPqAttGQLSyM3GhMXPYJNOyBbOHfmguag4LNwQmIjLBz5l9ElIu8lSdE9BWg0iWZcg1a5lfwi22g9wvLrjQjs9O0KkHGJAhGiAdBaGFBg/Vw03V+qp0tVbBR1HK0X6x08UwCSThSSZDqv41TJefWZlTy+/YoivxIK9PsLLpUdrVV29gYEbX4bhJJuYh4d6IDGz6p6EVjsyKD0I0jF0wUe7djtA0GbBwyONmDWEeOpi83huJK1aL4Zw4l20+hZQdP5gsj+D8X3+QaTqs6qeUVRS7vNRu/F+EQszPVv1OBQV/43JRsJLQPkJNjPgiGUdW6Dj1BJ2tPV+OcW9sDoipwp5ptZ77u2MEZNR3Ye/AhyHAZHyzEWLmLg+vXCXlifj4gIW+2+AZOMjX+R5toT/s=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230173577357003)(230922051799003)(230273577357003)(64100799003)(451199024)(186009)(1800799012)(33656002)(83380400001)(2906002)(5660300002)(52536014)(4326008)(8676002)(122000001)(38070700009)(41300700001)(478600001)(107886003)(38100700002)(66556008)(6916009)(66946007)(54906003)(64756008)(316002)(66476007)(53546011)(76116006)(66446008)(86362001)(9686003)(71200400001)(55016003)(6506007)(7696005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?UtF1N/t9B9DtSUrAzNhXoZXHnYtjn6gvdutGGy+RnPDGS/Xd0Ka6qBu9cOuQ?=
 =?us-ascii?Q?Dtg4TSRzS+n2yBYMIX3HqMVzNHPqKUWBmcwVoMdH0e04mecwjx5lIguVpe+S?=
 =?us-ascii?Q?+p+3rO6HrNCo2s/AxJqJ4r2AT/1nJUsZLoHotoo7GFWgy8h1I38tFVCg4DNi?=
 =?us-ascii?Q?uk/EySxJD3L16mP7L7oKCrJOIaSyMz/EUcgPgoYu+VJz4NhSiPRu4+2/0KYm?=
 =?us-ascii?Q?MwJ3LzindLu5FhaynY8sfbqLmp6i6TuqhyZ11mpbJW1mV1P5QFNhQVrWkfAI?=
 =?us-ascii?Q?52o4sqF/A2fhioQtMfhpRTg/wtbu5o8KYn0SskItacgiPuTlxHRiKxwjddb1?=
 =?us-ascii?Q?kUAU24sB/RgMwXZJsTSdZxjNGkUUf/88/Z5WRMH1hY8sHD9C+MjyKFqdCWWV?=
 =?us-ascii?Q?NkVI7gwLG0jB6JnVof+M5FRSr6FiyG+/sFHDylbAhWUFL64A1CwkGWAuut2/?=
 =?us-ascii?Q?u+sBa3DMAPNqNkQd6wqNLhuHPQ3yGmQFdeExYe7D48snIkcmGT69Pir2H95a?=
 =?us-ascii?Q?Fi80kM/LxwkET12J+AtH9URwHGNGcBMBiAoh7WCVEdPlsO03hKco1uO7BUjf?=
 =?us-ascii?Q?2kiPuAUbVGJUyY6MH/yDgEk0AXbslCibAGURiSVt/1Dz3zj9H4rei3gFUlNd?=
 =?us-ascii?Q?8wDfKOk0rMbMICPfogmIxz3GX5gqqEHGhEhcfKqXcIYfF1gzwrH9VPbfWByp?=
 =?us-ascii?Q?S96TJJ6bB2/RyySUl5XTVxhpGyjLyYTWBgiF9R99PwE4wPpMOJoOnqovp4kE?=
 =?us-ascii?Q?4JYls8rODsNEHwEh9Llrg5jH+BWDdFLeHHFImC0ovCcDs/c7KRYr0M3qvvx2?=
 =?us-ascii?Q?z+JLb+plwHB85cqjBOXsWU1kl9W4swgCcWBmXYlirgqZvrMLeU1zJE5RzVOi?=
 =?us-ascii?Q?EbJ9XxRGU5ob0zpzLR7vkpM2+ulNIllVFazOewLc2D1CY9R/pzRCKEnpeYgm?=
 =?us-ascii?Q?1iyNH8EAiWNkrG8TpclVWCdIIUZqt1xF6B3X9Vriw7yE2PLWVFjth3mfThWt?=
 =?us-ascii?Q?4P13j7DvwvKdImA/xIbzLKiNIyGZjl0pivYiaOPmQnpjDgJ8kYQHUUeD/4QE?=
 =?us-ascii?Q?gdjWyPKhYxNzppME0A6EQXuWydTk5VM+kl3xa+wGq501EU+H/8YMdQeDLPrp?=
 =?us-ascii?Q?e9AX8wBSwerQ11Ka9EXWGjpBhnowzh4ShY3tybvJ/4tUdxd5K6JHpHCmMd4t?=
 =?us-ascii?Q?ERez+l+QrzN76xFYd4MzGUwnURd0ycWo+dp5CKeMKx6AfVlQ4OXeEf+42wpz?=
 =?us-ascii?Q?aUdGFvlwLA9VuUgguBEhEsTcoilgtXTa50EPV80fYbkv6KNPxxxaIJwbWofH?=
 =?us-ascii?Q?16MS1A2t0bWRBhe2+ZjSrxQmC9x1oYvL+XSnbSBzkSyL+QgXBDlQHTzMKfVL?=
 =?us-ascii?Q?wbcCwrvS5Nz+cZ+505k3E1IX0FRfDHTf8BsECo3tXIZrfkbofhKZWe8I2Tcw?=
 =?us-ascii?Q?AoBk8J7iRb9KkvETvHIet+zzDJjUeC69WsJ+AhSmcXaznjL16Jb2beLwkNMW?=
 =?us-ascii?Q?IVtyUjFxYLdFYdwrfXvaERH1AIaMkFpDXXW79mitlDExe5jraZMsXMYA/MjY?=
 =?us-ascii?Q?9dQiXeZY4HT2bFMs3v2KIC2A7qYZglbgXYep/+c/LXopxDoLNZ5gS4EGFOm9?=
 =?us-ascii?Q?xaZfciJnVQs2s2UoaOvRUso=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed41996-9ea0-4dbd-a71e-08dc1e5489d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 09:52:41.8154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xytq7pX8R9rmyRMUCUT+dn7xy8LBpWqtEslO/Ti24cIO4SxH2ioc5ehqwsyCZlOyQ/tHeRxKOk0zGQJwCwFidQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6098
X-Proofpoint-GUID: Gu-F0krOn4wRY9yI1SDggFrg1nh2kNTy
X-Proofpoint-ORIG-GUID: Gu-F0krOn4wRY9yI1SDggFrg1nh2kNTy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02

Hi Simon,


> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Thursday, January 25, 2024 5:04 PM
> To: Geethasowjanya Akula <gakula@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org=
;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
> Subject: [EXT] Re: [net-next PATCH 1/3] octeontx2-af: Create BPIDs free p=
ool
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Wed, Jan 24, 2024 at 11:20:12AM +0530, Geetha sowjanya wrote:
> > Current code reserves 64 bpids for 64 LBK channels. But in most of the
> > cases multiple LBK channels uses same bpid. This leads to inefficient
> > use of bpids. Latest HW support configured multiple bpids per channel
> > for other interface types (CGX). For better use of these bpids, this
> > patch creates pool of free bpids from reserved LBK bpids. This free
> > pool is used to allocate bpid on request for another interface like
> > sso etc.
> >
> > This patch also reduces the number of bpids for cgx interfaces to 8
> > and adds proper error code
> >
> > Signed-off-by: Geetha sowjanya <gakula@marvell.com>
>=20
> Hi Geetha,
>=20
> I have some suggestions for possible follow-up below.
> That notwithstanding patch looks good to me.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
>=20
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > index 66203a90f052..e1eae16b09b3 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > @@ -499,14 +499,84 @@ static void nix_interface_deinit(struct rvu *rvu,
> u16 pcifunc, u8 nixlf)
> >  	rvu_cgx_disable_dmac_entries(rvu, pcifunc);  }
> >
> > +#define NIX_BPIDS_PER_LMAC	8
> > +#define NIX_BPIDS_PER_CPT	1
> > +static int nix_setup_bpids(struct rvu *rvu, struct nix_hw *hw, int
> > +blkaddr) {
> > +	struct nix_bp *bp =3D &hw->bp;
> > +	int err, max_bpids;
> > +	u64 cfg;
> > +
> > +	cfg =3D rvu_read64(rvu, blkaddr, NIX_AF_CONST1);
> > +	max_bpids =3D (cfg >> 12) & 0xFFF;
>=20
> I don't think this needs to block progress of this patch, but rather I'm
> providing this as a suggestion for a follow-up.
>=20
> I think it would be nice to define a mask, created using GENMASK, that na=
mes
> the register field (I don't know what it is).
> And then uses FIELD_GET here.
>=20
> Likewise for the 0xFFF below, and possibly elsewhere in this patch.
>=20
> Further, in patch 2 I see the use of BIT(11) in the following patch.
> And existing use of BIT(16) in this file.  I assume are register fields.
> If so it would be nice to make #defines to name them too.
>=20
Thanks for the review. Will submit v2 with suggested changes.
> > +
> > +	/* Reserve the BPIds for CGX and SDP */
> > +	bp->cgx_bpid_cnt =3D rvu->hw->cgx_links * NIX_BPIDS_PER_LMAC;
> > +	bp->sdp_bpid_cnt =3D rvu->hw->sdp_links * (cfg & 0xFFF);
> > +	bp->free_pool_base =3D bp->cgx_bpid_cnt + bp->sdp_bpid_cnt +
> > +			     NIX_BPIDS_PER_CPT;
> > +	bp->bpids.max =3D max_bpids - bp->free_pool_base;
>=20
> ...

