Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AAA7F444C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343704AbjKVKuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjKVKuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:50:07 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA79812A;
        Wed, 22 Nov 2023 02:50:03 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM9P2Yj001384;
        Wed, 22 Nov 2023 02:49:45 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uewnw4xs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 02:49:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xr4wn556w53w2KvOOx9ccKZQ1UOklMDa2zsYtt1olJ401dyih0XnRj5k/3xmFkGJm5KGrMhjnCppbVNJMg3DjYpEm28x8dq+phuCtwdqzXrFLMi+wYWTrsd2O8Z6k6kpLM/ashHbcbB82Tlo7VpGcu3wO3OFzKWJfd5alnMeGJoR9OBiJuRBMiO4UTFH3RnVCeX81ZiQOQoDHoXRc+NKdwnbrdromMDAqWmMQGJ+V231lXFD+ivU0xn64cNkZ6/T20+GodEWRuqeS+PvJVYmSGgoxk/j5c7oMZwkCwc7GHnsk27nbcNswRgIa/Cm1erWE/JKLhC/QBx5rRcZaVNGZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Rv7HRM7jNgWof9RZmbSDpGka9lcjhOxPku3sWUC0jI=;
 b=KJH5xzkYnDLXNj9RaB81hkMDVVil4NY1IEEzsgJ9S+/R1RYH9293eDevRed/X4L1CFBlOSYKH3pT0TBVY+8FKFQ1oyvr9GlC+x44y9C94Rs/KTqYa4pl4N9o2CxbmBCVO7dOM2O8h5E3QJxZ4BUadZ3qZifYymbt7MkDhviIx7Rrwuw5zC8SVR16nNMmEHOrrSf/0FRnJfEEKyUKbXOA/jErWAedbxoaz/pl2pd0+prUgqVbWnXMvtreHOvIWvAhcmxFPM8ggnEvV5dk+LY/3OZly3mUVfLPnAFPlKB1m8hzna3uMyTd+0PwVF5xltXtjnKSAzvInrzRjG+TqyaMoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Rv7HRM7jNgWof9RZmbSDpGka9lcjhOxPku3sWUC0jI=;
 b=fRPjh+vnmUuvjJVHUb7us4Kr8QiSk7bVjIxBRC1wJEPcGoU60kcWAA5q3KYecwIvK3cMqfZCsqI0Hzl+OTWvrBFZq0ZNm497zqDeY+yqlsi8s93BGon9eOP2vrkd7GdD3TezmMN0fBwdlcqvFOg/9BUO1BghyZDxMhUSGvPclds=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by MW3PR18MB3513.namprd18.prod.outlook.com (2603:10b6:303:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.30; Wed, 22 Nov
 2023 10:49:41 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::6a4f:cb8d:70fd:ef2]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::6a4f:cb8d:70fd:ef2%4]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 10:49:40 +0000
From:   Suman Ghosh <sumang@marvell.com>
To:     Wei Fang <wei.fang@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "claudiu.manoil@nxp.com" <claudiu.manoil@nxp.com>,
        "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH net-next] net: enetc: add ethtool::get_channels
 support
Thread-Topic: [EXT] [PATCH net-next] net: enetc: add ethtool::get_channels
 support
Thread-Index: AQHaHS+BTRkH+cf5B0qioiFUKZKZDLCGKB9Q
Date:   Wed, 22 Nov 2023 10:49:40 +0000
Message-ID: <SJ0PR18MB5216A0B9582DAE0DF8B6F1E3DBBAA@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20231122102540.3766699-1-wei.fang@nxp.com>
In-Reply-To: <20231122102540.3766699-1-wei.fang@nxp.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3VtYW5nXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctZDQzNGY4MDEtODkyNC0xMWVlLWI2ZmItODQxNDRk?=
 =?us-ascii?Q?ZWVhNTRjXGFtZS10ZXN0XGQ0MzRmODAzLTg5MjQtMTFlZS1iNmZiLTg0MTQ0?=
 =?us-ascii?Q?ZGVlYTU0Y2JvZHkudHh0IiBzej0iNjQyNCIgdD0iMTMzNDUxMjM3Nzc3Mjcw?=
 =?us-ascii?Q?ODI5IiBoPSJncU1zeGZFblovdmVrOVpTU1piekdVRm1mNWs9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCZ1dBQUF0?=
 =?us-ascii?Q?Nkl5V01SM2FBZTB0QXk3bnh0T0s3UzBETHVmRzA0b1pBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFCdUR3QUEzZzhBQURvR0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUVCQUFBQTlSZW5Md0NBQVFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBWkFC?=
 =?us-ascii?Q?eUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQWRRQnpBSFFBYndCdEFGOEFjQUJs?=
 =?us-ascii?Q?QUhJQWN3QnZBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBBWHdCd0FHZ0Fid0J1QUdVQWJnQjFB?=
 =?us-ascii?Q?RzBBWWdCbEFISUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCakFIVUFj?=
 =?us-ascii?Q?d0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFaQUJoQUhNQWFBQmZBSFlBTUFBeUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
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
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmtBR3dBY0FCZkFI?=
 =?us-ascii?Q?UUFaUUJoQUcwQWN3QmZBRzhBYmdCbEFHUUFjZ0JwQUhZQVpRQmZBR1lBYVFC?=
 =?us-ascii?Q?c0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUdVQWJRQmhBR2tBYkFCZkFHRUFaQUJrQUhJ?=
 =?us-ascii?Q?QVpRQnpBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFRQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
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
x-dg-refthree: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlB?=
 =?us-ascii?Q?QUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFad0J2QUc4QVp3QnNB?=
 =?us-ascii?Q?R1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZ?=
 =?us-ascii?Q?UUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBWXdCdkFH?=
 =?us-ascii?Q?UUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJB?=
 =?us-ascii?Q?QmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QmpBRzhBWkFCbEFITUFYd0JrQUdr?=
 =?us-ascii?Q?QVl3QjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFB?=
 =?us-ascii?Q?SUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhBYWdC?=
 =?us-ascii?Q?bEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFRQmtBR1VB?=
 =?us-ascii?Q?YmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUcw?=
 =?us-ascii?Q?QVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFiZ0Jo?=
 =?us-ascii?Q?QUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFBYVFCaEFHd0FY?=
 =?us-ascii?Q?d0J0QUdFQWNnQjJBR1VBYkFCc0FGOEFid0J5QUY4QVlRQnlBRzBBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFB?=
 =?us-ascii?Q?QUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdC?=
 =?us-ascii?Q?dUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0QWRBQnBBR0VB?=
 =?us-ascii?Q?YkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0JuQUc4QWJ3Qm5B?=
 =?us-ascii?Q?R3dBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdV?=
 =?us-ascii?Q?QWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0Jm?=
 =?us-ascii?Q?QUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VBY2dCMkFHVUFi?=
 =?us-ascii?Q?QUJzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFB?=
 =?us-ascii?Q?QUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QndBSElB?=
 =?us-ascii?Q?YndCcUFHVUFZd0IwQUY4QWJnQmhBRzBBWlFCekFGOEFjZ0JsQUhNQWRBQnlB?=
 =?us-ascii?Q?R2tBWXdCMEFHVUFaQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3?=
 =?us-ascii?Q?QmhBSElBYlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNl?=
 =?us-ascii?Q?QUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhRQVpRQnlBRzBBYVFCdUFIVUFj?=
 =?us-ascii?Q?d0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJB?=
 =?us-ascii?Q?R1VBYkFCc0FGOEFkd0J2QUhJQVpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBT2dZQUFBQUFBQUFJQUFBQUFBQUFBQWdBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQUFBQWFCZ0FBR1FBQUFCZ0FB?=
x-dg-reffive: =?us-ascii?Q?QUFBQUFBQVlRQmtBR1FBY2dCbEFITUFjd0FBQUNRQUFBQUJBQUFBWXdCMUFI?=
 =?us-ascii?Q?TUFkQUJ2QUcwQVh3QndBR1VBY2dCekFHOEFiZ0FBQUM0QUFBQUFBQUFBWXdC?=
 =?us-ascii?Q?MUFITUFkQUJ2QUcwQVh3QndBR2dBYndCdUFHVUFiZ0IxQUcwQVlnQmxBSElB?=
 =?us-ascii?Q?QUFBd0FBQUFBQUFBQUdNQWRRQnpBSFFBYndCdEFGOEFjd0J6QUc0QVh3QmtB?=
 =?us-ascii?Q?R0VBY3dCb0FGOEFkZ0F3QURJQUFBQXdBQUFBQUFBQUFHTUFkUUJ6QUhRQWJ3?=
 =?us-ascii?Q?QnRBRjhBY3dCekFHNEFYd0JyQUdVQWVRQjNBRzhBY2dCa0FITUFBQUErQUFB?=
 =?us-ascii?Q?QUFBQUFBR01BZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdCdUFHOEFaQUJs?=
 =?us-ascii?Q?QUd3QWFRQnRBR2tBZEFCbEFISUFYd0IyQURBQU1nQUFBRElBQUFBQUFBQUFZ?=
 =?us-ascii?Q?d0IxQUhNQWRBQnZBRzBBWHdCekFITUFiZ0JmQUhNQWNBQmhBR01BWlFCZkFI?=
 =?us-ascii?Q?WUFNQUF5QUFBQVBnQUFBQUFBQUFCa0FHd0FjQUJmQUhNQWF3QjVBSEFBWlFC?=
 =?us-ascii?Q?ZkFHTUFhQUJoQUhRQVh3QnRBR1VBY3dCekFHRUFad0JsQUY4QWRnQXdBRElB?=
 =?us-ascii?Q?QUFBMkFBQUFBQUFBQUdRQWJBQndBRjhBY3dCc0FHRUFZd0JyQUY4QVl3Qm9B?=
 =?us-ascii?Q?R0VBZEFCZkFHMEFaUUJ6QUhNQVlRQm5BR1VBQUFBNEFBQUFBQUFBQUdRQWJB?=
 =?us-ascii?Q?QndBRjhBZEFCbEFHRUFiUUJ6QUY4QWJ3QnVBR1VBWkFCeUFHa0FkZ0JsQUY4?=
 =?us-ascii?Q?QVpnQnBBR3dBWlFBQUFDUUFBQUFCQUFBQVpRQnRBR0VBYVFCc0FGOEFZUUJr?=
 =?us-ascii?Q?QUdRQWNnQmxBSE1BY3dBQUFGZ0FBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FY?=
 =?us-ascii?Q?d0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFiZ0JoQUcwQVpRQnpBRjhBWXdCdkFH?=
 =?us-ascii?Q?NEFaZ0JwQUdRQVpRQnVBSFFBYVFCaEFHd0FYd0JoQUd3QWJ3QnVBR1VBQUFC?=
 =?us-ascii?Q?VUFBQUFBQUFBQUcwQVlRQnlBSFlBWlFCc0FGOEFjQUJ5QUc4QWFnQmxBR01B?=
 =?us-ascii?Q?ZEFCZkFHNEFZUUJ0QUdVQWN3QmZBSElBWlFCekFIUUFjZ0JwQUdNQWRBQmxB?=
 =?us-ascii?Q?R1FBWHdCaEFHd0Fid0J1QUdVQUFBQmFBQUFBQUFBQUFHMEFZUUJ5QUhZQVpR?=
 =?us-ascii?Q?QnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUhJ?=
 =?us-ascii?Q?QVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3Qm9BR1VBZUFCakFHOEFaQUJs?=
 =?us-ascii?Q?QUhNQUFBQWdBQUFBQUFBQUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCaEFISUFi?=
 =?us-ascii?Q?UUFBQUNZQUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBR2NBYndCdkFH?=
 =?us-ascii?Q?Y0FiQUJsQUFBQU5BQUFBQUFBQUFCdEFHRUFj?=
x-dg-refsix: =?us-ascii?Q?Z0IyQUdVQWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBR01BYndCa0FH?=
 =?us-ascii?Q?VUFjd0FBQUQ0QUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQVh3QmpBRzhBWkFCbEFITUFYd0JrQUdrQVl3QjBBQUFB?=
 =?us-ascii?Q?WGdBQUFBQUFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFjQUJ5QUc4QWFnQmxB?=
 =?us-ascii?Q?R01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZBR01BYndCdUFHWUFhUUJrQUdVQWJn?=
 =?us-ascii?Q?QjBBR2tBWVFCc0FGOEFiUUJoQUhJQWRnQmxBR3dBYkFBQUFHd0FBQUFBQUFB?=
 =?us-ascii?Q?QWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0J1?=
 =?us-ascii?Q?QUdFQWJRQmxBSE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRBZEFCcEFHRUFi?=
 =?us-ascii?Q?QUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3QmhBSElBYlFBQUFI?=
 =?us-ascii?Q?SUFBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29BWlFC?=
 =?us-ascii?Q?akFIUUFYd0J1QUdFQWJRQmxBSE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRB?=
 =?us-ascii?Q?ZEFCcEFHRUFiQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3Qm5B?=
 =?us-ascii?Q?RzhBYndCbkFHd0FaUUFBQUZvQUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJB?=
 =?us-ascii?Q?QmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFITUFYd0J5QUdV?=
 =?us-ascii?Q?QWN3QjBBSElBYVFCakFIUUFaUUJrQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFB?=
 =?us-ascii?Q?QUdnQUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dCdkFHb0Fa?=
 =?us-ascii?Q?UUJqQUhRQVh3QnVBR0VBYlFCbEFITUFYd0J5QUdVQWN3QjBBSElBYVFCakFI?=
 =?us-ascii?Q?UUFaUUJrQUY4QWJRQmhBSElBZGdCbEFHd0FiQUJmQUc4QWNnQmZBR0VBY2dC?=
 =?us-ascii?Q?dEFBQUFLZ0FBQUFBQUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWRBQmxBSElB?=
 =?us-ascii?Q?YlFCcEFHNEFkUUJ6QUFBQUlnQUFBQUFBQUFCdEFHRUFjZ0IyQUdVQWJBQnNB?=
 =?us-ascii?Q?RjhBZHdCdkFISUFaQUFBQUE9PSIvPjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|MW3PR18MB3513:EE_
x-ms-office365-filtering-correlation-id: 3cac2ef8-8a5d-44e1-5fb8-08dbeb48badc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GNhR42rwl/0n4ZJ31SzdjYmBLEwcUTSfq4RmAXgO724xgbyIXEORRl/r+qnK/FOFrmi+C0ZGI8bQzt+ylmvnu6P4tnHu1EpNY1GgXv6bl5YHr2X5nKBeTJw+35fx5gabIAOvxm7DZLxpzoY2m+CrWew61r6EvkGUbPSxcx8b3OLZRSSQca/cZjM4EW9szdSsq4IHajNGJ9J8kYsWVevcE4KbKUIUiaW9MjlLijlwhlVJVHc0chHAPMCEAkKIlR3RAp+iLFz6+FNsTJpLnH0IRoJPGvdQ+vtHXP3bMkTl81abx3r6+3AChO7UAxKOgOGC9WY3E6WV81KilJurcs2uhZpTVqTcVBOrvIcSRzS48H2BWwQBdted0/lsM6PPukdsFAAkKQG2oa9q+FHYIVOqh/hEGUdsHxo7rnwoHRvgRpikiBXlK5vUOaV/uEyyvItwE1N27bbN8U7Eb7v4K/Jo4GVxBAGOAQSt3PVj9SFtNnMUL0TfdlsIXSOAODHHhlFXNTMY+S/fLTC2UJkfuAmW2sFfbiFLFqBP4wCNoE4iROoZx6/EwONnk6PiNkdAFHDVeyKQ2mRtKEbiFkQ+VCSKlm4aE/9DAf05RG1QLyaBaWyeedGfdRr4m5dNNEtKSqATrNTZiyrp2DawoiexyvtCow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(376002)(366004)(136003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(451199024)(186009)(1800799012)(122000001)(83380400001)(478600001)(7696005)(26005)(55016003)(9686003)(6506007)(966005)(71200400001)(66446008)(316002)(66556008)(66476007)(64756008)(66946007)(110136005)(76116006)(38100700002)(8936002)(8676002)(4326008)(2906002)(5660300002)(33656002)(41300700001)(86362001)(52536014)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z6LWxjQqcO8JAFDGMZ/a3mxJniTdZt6WLhdyLKpOEMYwIBy0JjQXYZy2nFot?=
 =?us-ascii?Q?4A16YkAkyQoxBFJ0WiXKtIqM83rLYIZBzz4LkewBG7x2euZydSOfhhDUpo9m?=
 =?us-ascii?Q?tWajd6ZyoGcAlLC0XEgCepzQIzzh4vXowmbyg9nH73Lh6anlviEWhTHTjx0U?=
 =?us-ascii?Q?8IHvIPUYak5ufIwIkCz7L0P77pT4IkjrApuwv7eLabSWNsfXgvnZUtvvpA8D?=
 =?us-ascii?Q?dKcod2KkAtZPYcWwXBLurxmUluhSG1A/K2PAkZNB8Q8D34ZICRYH1NT/RJkk?=
 =?us-ascii?Q?aDpAKSHDz8H526rrU/DYEZc4K7KOJOl2rcsQgivdRWjqaA359Us31XXaVaaI?=
 =?us-ascii?Q?vBKNzXOPdWqudhdU47ovVYPEF+ciur/iuyuUFXdYG92iWbIxWitpjZLd74yN?=
 =?us-ascii?Q?7EKtA1xReIZVzbxgyvn71egZnv7gSoweV5R+vFA73t2y3t4AUrYohY9zV61z?=
 =?us-ascii?Q?J+81VkkCYCZ1a96ZdPGJy8jP1Ga0wssTWTZemvNNcX8FFSWK6L/tHfTTf7xN?=
 =?us-ascii?Q?hHjusyLrpurEFQoDHLffsuzPFtzaDu94zCcBJJzNb/5IsJ/tg2dzdzhvg2is?=
 =?us-ascii?Q?mehkp7EqLtA0xmLUkb+Yd3df+cnNMVIm2F0Yw+kjXa3r2Ddy20xpY2ejH69e?=
 =?us-ascii?Q?jzKOx51YMHQ2JsLpYqhJ/MljsZ94Zt/327M/DJXBFZ6TfoOd/tMQPI2oeieN?=
 =?us-ascii?Q?DpcSLfWNmW3FUhXXXQMOtFSx/lt7055QWf/cg/yZxl8U3tmbip7Ewugj7r/d?=
 =?us-ascii?Q?tuYC7e5hIIGewRE0uNDPMEHa4n8eIdYMTZN1m32OonMx6gwB6D38HObcua9k?=
 =?us-ascii?Q?mo0GnmZ0/1baW/Es0+ptqhB0MNXDvkJmR8CinTDIlPUDW+/fYdaEGzmxa4Us?=
 =?us-ascii?Q?sjVss2cu4Jmv7JSqXtnf1lQBv1bA2S4CmU+cM8dftiFKn6YjUaZ20crWxu5l?=
 =?us-ascii?Q?0CW/860Rx+Sgj3P8/IqiqpYDIxBwwAEyjM/aEoUcdHtj4hu9zuyQ3MU3Q4xe?=
 =?us-ascii?Q?nj11eZM++jWfjXF6yR6N+gWTnfranTLGGfJCeZwLwewEzBR68wxrtcJ8yAin?=
 =?us-ascii?Q?y2wtU+OFGa9ikBXrml3f3PHqhBppff3PpmTkfqGhdPLwiiNSpmm2FWS9VkuV?=
 =?us-ascii?Q?G+zvbDEj35FBNlKskhEbo548CiVfDN/qbdPj6szRRNJvn9Os4kHzw1bu4sdT?=
 =?us-ascii?Q?dmZm9vQoWnUNfK0+Ewq6asrjEAZbWBcanbWvOWpBhrvdwZcjAjxjx9onRC1G?=
 =?us-ascii?Q?bgeLF71SEVOOw/G6gIpgpN9jOoeEAEIm9F7zTkUPGhQdb3SA8a8A1rWDumDB?=
 =?us-ascii?Q?kLHlaDJLzZPzEa4A2vbXqhUzt6770KxoOrUu+j+uqzKSruPQ8i9W4ojwlRqI?=
 =?us-ascii?Q?EBSOJd5GXthDAQNpNxRwqeiBQVVao2wY5seNDY5VBzPbQHTU7W9PO28JIpl7?=
 =?us-ascii?Q?X2Gd+adrF54D5aqHRnUnsEaIKpFwyxsRk/R9x8flWi9qMFn0jnWub958KaSc?=
 =?us-ascii?Q?L9OvEZDOvYZcGoKCeylKecZPfNmemSG1NXaBMLSV0SBbZqDIYh4MqcZU+sdF?=
 =?us-ascii?Q?cIQpf1aXBm6nZwOJGRqAfQQ0Y5dV/1HPHUIKJ26j?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cac2ef8-8a5d-44e1-5fb8-08dbeb48badc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 10:49:40.7678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PnxuGSWvjz4W/0ZPrJi8mAgCf9fXsBn2vAPIP/QblK2XlOapmKMVtegSzL5QmyrMuOLrP3k1Dkh+zEnRUx9t5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3513
X-Proofpoint-GUID: KVRwWeVF6nkQdMebt-5z8c4uZO1HiiBm
X-Proofpoint-ORIG-GUID: KVRwWeVF6nkQdMebt-5z8c4uZO1HiiBm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_06,2023-11-22_01,2023-05-22_02
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Subject: [EXT] [PATCH net-next] net: enetc: add ethtool::get_channels
>support
>
>External Email
>
>----------------------------------------------------------------------
>Since ETHTOOL_MSG_RSS_GET netlink message [1] has been applied to
>ethtool tree, there is a netlink error when using "ethtool -x eno0"
>command to get RSS information from fsl-enetc driver, and the user
>cannot get the information, the error logs are as follows:
>
>root@ls1028ardb:~# ./ethtool -x eno0
>netlink error: Operation not supported
>
>The rationale is that ethtool will issue a ETHTOOL_MSG_CHANNELS_GET
>netlink message to get the number of Rx ring. However, the fsl-enetc
>driver doesn't support ethtool::get_channels, so it directly returns -
>EOPNOTSUPP error.
>
>[1]: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
>3A__git.kernel.org_pub_scm_linux_kernel_git_jkirsher_ethtool.git_commit_
>-3Fid-
>3Dffab99c1f3820e21d65686e030dcf2c4fd0a8bd0&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPa=
z7
>xtfQ&r=3D7si3Xn9Ly-Se1a655kvEPIYU0nQ9HPeN280sEUv5ROU&m=3D-
>6bW3FaCKau7jio6XSUWDZw3IEqdetIwhU_Bgcv87QcnjyMDGD0slJGQYFlbVx7l&s=3D8vMevY
>UEvNkyCjMDO278j67ir4daMquk6QK9wR65NSQ&e=3D
>
>Signed-off-by: Wei Fang <wei.fang@nxp.com>
>---
> .../net/ethernet/freescale/enetc/enetc_ethtool.c    | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>
>diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
>b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
>index e993ed04ab57..5fa1000b9b83 100644
>--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
>+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
>@@ -740,6 +740,17 @@ static int enetc_set_rxfh(struct net_device *ndev,
>const u32 *indir,
> 	return err;
> }
>
>+static void enetc_get_channels(struct net_device *ndev,
>+			       struct ethtool_channels *ch)
>+{
>+	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
>+
>+	ch->max_rx =3D priv->num_rx_rings;
>+	ch->max_tx =3D priv->num_tx_rings;
>+	ch->rx_count =3D priv->num_rx_rings;
>+	ch->tx_count =3D priv->num_tx_rings;
[Suman] max_rx/tx and rx/tx_count can be different right? To me it seems li=
ke max_rx/tx should read the max value not the current configured values.
>+}
>+
> static void enetc_get_ringparam(struct net_device *ndev,
> 				struct ethtool_ringparam *ring,
> 				struct kernel_ethtool_ringparam *kernel_ring, @@ -
>1196,6 +1207,7 @@ static const struct ethtool_ops enetc_pf_ethtool_ops =3D
>{
> 	.get_rxfh_indir_size =3D enetc_get_rxfh_indir_size,
> 	.get_rxfh =3D enetc_get_rxfh,
> 	.set_rxfh =3D enetc_set_rxfh,
>+	.get_channels =3D enetc_get_channels,
> 	.get_ringparam =3D enetc_get_ringparam,
> 	.get_coalesce =3D enetc_get_coalesce,
> 	.set_coalesce =3D enetc_set_coalesce,
>@@ -1226,6 +1238,7 @@ static const struct ethtool_ops
>enetc_vf_ethtool_ops =3D {
> 	.get_rxfh_indir_size =3D enetc_get_rxfh_indir_size,
> 	.get_rxfh =3D enetc_get_rxfh,
> 	.set_rxfh =3D enetc_set_rxfh,
>+	.get_channels =3D enetc_get_channels,
> 	.get_ringparam =3D enetc_get_ringparam,
> 	.get_coalesce =3D enetc_get_coalesce,
> 	.set_coalesce =3D enetc_set_coalesce,
>--
>2.25.1
>

