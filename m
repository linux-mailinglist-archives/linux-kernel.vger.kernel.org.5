Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94B47680CC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 19:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjG2Rm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 13:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjG2Rm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 13:42:26 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286ED1BEB;
        Sat, 29 Jul 2023 10:42:25 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36TH0Of3018761;
        Sat, 29 Jul 2023 10:42:09 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3s504ngumm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Jul 2023 10:42:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y640B0y0TbGuBMqf/6xOYmiQoWGXGuJWQMYKQKbQSnmzg/JMM7rX2edAIiXA/xbq6mZOh2RFBT+EWKrW+bBBl3QJLQIIMQmtpIUxeUpbjAOYDZnmTfeu8dkihbgxDskjD3wT4ai20aDPUarCB3heSpnRerOjoPCCgimILbIV7RulQDS6ycK+gkil5Y6fy1248014n1iUG5EafXI6YWbfMmaUKopfaVdZ38sKY4wRbomgc/b22EpQUyFLSUiiNnHLX06z3FUORT6vdDoTWWyzjwpbLY4mDIjIgJkHUitIQ2Ous/Z9Hn4H7UuaWlXmzwFmoHRahPybwqdXpxNTUX5Cvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pKG1UTsHhqwFqF4PcxauY2k1+cn2UFuj+QBjGJCXVA=;
 b=LTyD032OjiMTEssZM1NEBdFmJNTCmjnjzZ15UtRY8kxMUpzAwtPKA/dbZItu2na8FDnh8YXTH4P9t2jiKuITptrsndXvQ37BlKgvJXhwWbht1ZCKJY4zryqrdbscf8NKN87lsxvjAfSypaOXBHbtAbuI8dCk/mFv3ZQOIk3LiBZ24yEnA9dsbUs7oM7YAYB63F6z9qSTJa0NJkRBd7c5f8iGmRvJVH8B4iDBC5i6qhcvkPCLNTkOLbg+jLz5UAO+PxDKHxUSpzLl17tZRtW7K5zpxMNh4awweqJPgydmIDaB2uwvQNZjTt8nm872WalmAKMR4Rq550FU9PkiQsktlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pKG1UTsHhqwFqF4PcxauY2k1+cn2UFuj+QBjGJCXVA=;
 b=GJABFjMEsHcjweTnVPyYNbCah6W6/PndjpY17tI3ugLy2GAGevbUmVvs56PGs9mXRgD2suwqf61wHO2N1UKmXJaaoZEXetYw67sd1o+KjoFg3Zqd11FPQ60Ux8ISc5HUcmxKEocbUFtWsZ02NNRDHIT47hvGvjZrUMFqsrHh+90=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by SN7PR18MB3968.namprd18.prod.outlook.com (2603:10b6:806:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sat, 29 Jul
 2023 17:42:06 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::115c:adb2:aa97:d187]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::115c:adb2:aa97:d187%6]) with mapi id 15.20.6631.042; Sat, 29 Jul 2023
 17:42:05 +0000
From:   Suman Ghosh <sumang@marvell.com>
To:     Simon Horman <simon.horman@corigine.com>
CC:     Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linu Cherian <lcherian@marvell.com>,
        Jerin Jacob Kollanukkaran <jerinj@marvell.com>
Subject: RE: [EXT] Re: [net-next PATCH V2] octeontx2-af: Tc flower offload
 support for inner VLAN
Thread-Topic: [EXT] Re: [net-next PATCH V2] octeontx2-af: Tc flower offload
 support for inner VLAN
Thread-Index: AQHZwEkI9lBzsYVr7EiFhLyEp62aaK/Qhc8AgACBHcA=
Date:   Sat, 29 Jul 2023 17:42:05 +0000
Message-ID: <SJ0PR18MB52164A46E895E6A9D74815D7DB07A@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20230727051252.2779804-1-sumang@marvell.com>
 <ZMTitp4+oc3+/D1U@corigine.com>
In-Reply-To: <ZMTitp4+oc3+/D1U@corigine.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3VtYW5nXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctMzk1Nzc4MzktMmUzNy0xMWVlLWI2ZTAtODQxNDRk?=
 =?us-ascii?Q?ZWVhNTRjXGFtZS10ZXN0XDM5NTc3ODNiLTJlMzctMTFlZS1iNmUwLTg0MTQ0?=
 =?us-ascii?Q?ZGVlYTU0Y2JvZHkudHh0IiBzej0iNDkzOSIgdD0iMTMzMzUxMjYxMjI1NDQx?=
 =?us-ascii?Q?MTUzIiBoPSJSVFRDNlRXeG5VeitxNFRSa3VoL2R3OTcwdEU9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFONFBBQUNC?=
 =?us-ascii?Q?VjdIN1E4TFpBU0FWRTFYQlpJclZJQlVUVmNGa2l0VVpBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFCdUR3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUVCQUFBQUk3cVRwQUNBQVFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBWkFC?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
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
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBIi8+PC9tZXRhPg=3D=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|SN7PR18MB3968:EE_
x-ms-office365-filtering-correlation-id: 42d6c83e-6000-4ec2-f72b-08db905b2016
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BVaK8LkkLdYwrx5gsJUv2PHXEsVZ7JsaB2Trkk+ztIjTsVUZUxFa3MpP1x71R748lACfT0hTMoJ/xBI4jqBChYIyHrdRoh8nAnrKmReGSPQVSRJHTe5YG9MHwZYNfvOUCqoBwbxUJEkXIYCl5xFxiqpwKery8oiybtkBtDnBkduavhkjsPQgQrnT+qVCSsyFUj/SwhsO4LWRiKl1nYfIyj5DfwYIQ2fqBl4K3IBObcHXssTJrLZsijWbvZyGrrZCeXNTQfkLe2c9SEGV5bvLtgHeyRdm9y6h+EnCgRj1ZD4cM4wSLC7askCPT9EFTIIYegY9rXYouGMYyOmEEzVFWaJenlxN5L6DDlv6qUOFsayI7f7NmlRGJN7VUZs4jQbfVOv9+LC1nWV5Ya1tq1bITpgorGIjUfECtqugxKq3hZ68/CewOUr4kLIP5mY80MmrparwCS16rlU6YNHWbOe/oakGqQ+41Uzvcf37WE8rAlYBwfWYdSYaIjpbM6JCNedouS7nxAwPfMvGg5XuzeGEwX8n6nBvTo8kXpI/hioThf/9CvrNZToT5Gc+Nur59YzgSIrhuMBpFbho1DyL/yJYaoitYrmx5bIO5uJOQcCdeg/HeDhhEeg4B6q1lXuHBzS/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(366004)(346002)(136003)(396003)(451199021)(66556008)(316002)(26005)(8936002)(41300700001)(4326008)(6916009)(8676002)(6506007)(33656002)(107886003)(55016003)(54906003)(122000001)(66946007)(478600001)(66476007)(76116006)(9686003)(64756008)(66446008)(7696005)(71200400001)(38100700002)(2906002)(38070700005)(86362001)(186003)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N31fp4hF6LjZ7+29LcGm0pwi9vbaZ5lXMhi+GLOazgF7FLugbw2ermmdZE+w?=
 =?us-ascii?Q?J/YyzXErYpuQWfK83FO9t5qfy2jbIF/9GjLVEyDzmKWl/Xde729j1oM+xEzK?=
 =?us-ascii?Q?4I4G/x1UYgMgO4PHbVaOfaqVj995gch2JhuJzVa87lplTWMkHdRVZ1bKTgFi?=
 =?us-ascii?Q?M+RqeTYxqKdYOfpSfKEhkR2aj1lgavrYtcX/GQ2gxik2JUOZ7niw+CfVQwza?=
 =?us-ascii?Q?8tSJEN33ccJe0dYmCt5s/nVqJ/3FhMECkLj8qH7xFicgnLvDYG4xOcL+YGMl?=
 =?us-ascii?Q?vcAudXfBiuZuC25eCtvg1Tpyrzac+3m+BAeUYrm3T3Z9VStZUaex2E2gYdy0?=
 =?us-ascii?Q?WJPOVzg1zZ5zhz5uraUAY2KbVQg41SlmCRil816RcRgCGthJ+lu4Iveczb0z?=
 =?us-ascii?Q?DYnL5PCnhY5ltaYFbWdG6UDRpmkTK/VMFC0D+IDWRiqdoiaKzX+HK5USdryD?=
 =?us-ascii?Q?yDP5dj5M/Wwuib05HwAeBdb8Rpp2fN2sYH9BOdPlNeSs3fJLsKcbWPrYApoo?=
 =?us-ascii?Q?chuTM4SaxLFcvb9k1Vx1QFLpLygxhOe0voUCBUGI+lgpup2cWc/tlmNfXheF?=
 =?us-ascii?Q?XQsbtndfT8ZB0/UVMm/ux/PjfQYvG0FVxGgyvIlu6X9ZaE348DIdaTcXRPwd?=
 =?us-ascii?Q?did18tc6xkdUJSbddZICX0BitbEsWdzraIv7LHKY9Qik/5SrZ6UyH93GbCJi?=
 =?us-ascii?Q?F/+cfijENHxr1DHEx0n/34lbQeodpwT/jkZt870wP4O8lwuZUj7yT51+tJ8A?=
 =?us-ascii?Q?2e7RyIpuGSAMjYTtaoTApt1VX9Z2CNpfuTDNpo2ZgRQgmxJHAn8ouvnbCAV4?=
 =?us-ascii?Q?OBsdVgnSE27fZnysMa4T+Pa/1Eww+UiCoXn4IYV0CX6WH11BuLDMQfiaOZ2Q?=
 =?us-ascii?Q?aeFsXtN4t7IzzYlC4QSGK+rY7lSXGxf+k8DVw2hsyV3lub0tbD0JjBmVGqBs?=
 =?us-ascii?Q?jAnFh3MJaKo36V9CnFiIuiDR5vPU/Z+Gk7e3kYBTJr1aDXJoax9TFZW+2knK?=
 =?us-ascii?Q?fbVxaRd+E7/0n8ZNlo3+0Ulf3fauPDXfoMNadzCENrSYOkBBhICL2pocpjkb?=
 =?us-ascii?Q?szwL62zEBjouFWvlUS3+gnk0n2hDAiMpXyqywQjiqpeNoPXamUOHDIM/aHiE?=
 =?us-ascii?Q?BL/JLV361VCFEuwrrkMiLZU8XC8kLBaf0UVkOHz3iIr+06q3mIMrJTNYuAFh?=
 =?us-ascii?Q?SZGdGbivOO176NzmS7yMCagfvH6I2jA4IxXMMn4O1pDBHQaRIs2n5jtiU/dR?=
 =?us-ascii?Q?7e0/ux6FpgdO823Sf2XLqraKyK4D1vlOhDiGbSKtq18fAQkbc2FFmsZ62nIM?=
 =?us-ascii?Q?t5rakHyN1IAkQNj2Y63sMOgBqPcASPuKGjzYjuWdEExvhecTdKMKSeU9YyP/?=
 =?us-ascii?Q?3vKLChFPTlVUKvSHxna65Roh8jQNg5hCF1Kmntklpkry1Be+ewvJAv+3Vd4F?=
 =?us-ascii?Q?TzyYiVAtPFd4D016rrXRyVlTVNWkKF8c4YVbm4uJnZD5N5NnqOcMDNoNt2tt?=
 =?us-ascii?Q?E8icAnkfP2xNIcBSGnrbBpQplGGoeZ+VydBstuzfdkhP4jQk/cLPrO7ARJ5A?=
 =?us-ascii?Q?90Eyk3FdDU/5WzdlZ8C2Bj5tJOW1QhGzYGgDVZfr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d6c83e-6000-4ec2-f72b-08db905b2016
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2023 17:42:05.7379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: roFL2u1EzLottwIbcMYjrKxTp+6hzmmEen7OeNTt2i6pKDb0PRadGw3E6PXAJGMgCOTcoPml87cWYTkvx3j3Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3968
X-Proofpoint-ORIG-GUID: aaGWQmakshfplqlJnyr1ba3ci6YF-2SN
X-Proofpoint-GUID: aaGWQmakshfplqlJnyr1ba3ci6YF-2SN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>  }
>>
>> +static int otx2_tc_process_vlan(struct otx2_nic *nic, struct flow_msg
>*flow_spec,
>> +				struct flow_msg *flow_mask, struct flow_rule *rule,
>> +				struct npc_install_flow_req *req, bool is_inner) {
>
>Hi Suman,
>
>Most of the code in this function seems to be moved from elsewhere.
>It might make it slightly easier to review if there was a patch that
>moved that code, then another patch that modified to support the inner
>VLAN feature.
[Suman] Okay Simon. I will push a patch set of 2 patches involving the sugg=
ested changes.
>
>> +	struct flow_match_vlan match;
>> +	u16 vlan_tci, vlan_tci_mask;
>> +
>> +	if (is_inner)
>> +		flow_rule_match_cvlan(rule, &match);
>> +	else
>> +		flow_rule_match_vlan(rule, &match);
>> +
>> +	if ((ntohs(match.key->vlan_tpid) !=3D ETH_P_8021Q) &&
>> +	    (ntohs(match.key->vlan_tpid) !=3D ETH_P_8021AD)) {
>
>I think eth_type_vlan() can be used here.
[Suman] Ack.
>
>> +		netdev_err(nic->netdev, "vlan tpid 0x%x not supported\n",
>> +			   ntohs(match.key->vlan_tpid));
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	if (!match.mask->vlan_id) {
>> +		struct flow_action_entry *act;
>> +		int i;
>> +
>> +		flow_action_for_each(i, act, &rule->action) {
>> +			if (act->id =3D=3D FLOW_ACTION_DROP) {
>> +				netdev_err(nic->netdev,
>> +					   "vlan tpid 0x%x with vlan_id %d is not
>supported for DROP rule.\n",
>> +					   ntohs(match.key->vlan_tpid), match.key-
>>vlan_id);
>> +				return -EOPNOTSUPP;
>> +			}
>> +		}
>> +	}
>> +
>> +	if (match.mask->vlan_id ||
>> +	    match.mask->vlan_dei ||
>> +	    match.mask->vlan_priority) {
>> +		vlan_tci =3D match.key->vlan_id |
>> +			   match.key->vlan_dei << 12 |
>> +			   match.key->vlan_priority << 13;
>> +
>> +		vlan_tci_mask =3D match.mask->vlan_id |
>> +				match.mask->vlan_dei << 12 |
>> +				match.mask->vlan_priority << 13;
>> +
>> +		if (is_inner) {
>> +			flow_spec->vlan_itci =3D htons(vlan_tci);
>> +			flow_mask->vlan_itci =3D htons(vlan_tci_mask);
>> +			req->features |=3D BIT_ULL(NPC_INNER_VID);
>> +		} else {
>> +			flow_spec->vlan_tci =3D htons(vlan_tci);
>> +			flow_mask->vlan_tci =3D htons(vlan_tci_mask);
>> +			req->features |=3D BIT_ULL(NPC_OUTER_VID);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct
>otx2_tc_flow *node,
>>  				struct flow_cls_offload *f,
>>  				struct npc_install_flow_req *req) @@ -458,6 +516,7
>@@ static int
>> otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
>>  	      BIT(FLOW_DISSECTOR_KEY_BASIC) |
>>  	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
>>  	      BIT(FLOW_DISSECTOR_KEY_VLAN) |
>> +	      BIT(FLOW_DISSECTOR_KEY_CVLAN) |
>>  	      BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
>>  	      BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
>>  	      BIT(FLOW_DISSECTOR_KEY_PORTS) | @@ -564,47 +623,19 @@ static
>> int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow
>*node,
>>  	}
>>
>>  	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_VLAN)) {
>> -		struct flow_match_vlan match;
>> -		u16 vlan_tci, vlan_tci_mask;
>> -
>> -		flow_rule_match_vlan(rule, &match);
>> -
>> -		if (ntohs(match.key->vlan_tpid) !=3D ETH_P_8021Q) {
>> -			netdev_err(nic->netdev, "vlan tpid 0x%x not supported\n",
>> -				   ntohs(match.key->vlan_tpid));
>> -			return -EOPNOTSUPP;
>> -		}
>> +		int ret;
>>
>> -		if (!match.mask->vlan_id) {
>> -			struct flow_action_entry *act;
>> -			int i;
>> -
>> -			flow_action_for_each(i, act, &rule->action) {
>> -				if (act->id =3D=3D FLOW_ACTION_DROP) {
>> -					netdev_err(nic->netdev,
>> -						   "vlan tpid 0x%x with vlan_id %d is not
>supported for DROP rule.\n",
>> -						   ntohs(match.key->vlan_tpid),
>> -						   match.key->vlan_id);
>> -					return -EOPNOTSUPP;
>> -				}
>> -			}
>> -		}
>> -
>> -		if (match.mask->vlan_id ||
>> -		    match.mask->vlan_dei ||
>> -		    match.mask->vlan_priority) {
>> -			vlan_tci =3D match.key->vlan_id |
>> -				   match.key->vlan_dei << 12 |
>> -				   match.key->vlan_priority << 13;
>> +		ret =3D otx2_tc_process_vlan(nic, flow_spec, flow_mask, rule,
>req, false);
>> +		if (ret)
>> +			return ret;
>> +	}
>>
>> -			vlan_tci_mask =3D match.mask->vlan_id |
>> -					match.mask->vlan_dei << 12 |
>> -					match.mask->vlan_priority << 13;
>> +	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CVLAN)) {
>> +		int ret;
>>
>> -			flow_spec->vlan_tci =3D htons(vlan_tci);
>> -			flow_mask->vlan_tci =3D htons(vlan_tci_mask);
>> -			req->features |=3D BIT_ULL(NPC_OUTER_VID);
>> -		}
>> +		ret =3D otx2_tc_process_vlan(nic, flow_spec, flow_mask, rule,
>req, true);
>> +		if (ret)
>> +			return ret;
>>  	}
>>
>>  	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
>> --
>> 2.25.1
>>
>>
