Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FBB7818F9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjHSKmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjHSKlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:41:52 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6406B15F99A;
        Sat, 19 Aug 2023 03:10:22 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37J9SGvi022411;
        Sat, 19 Aug 2023 03:10:06 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sju3qg1uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Aug 2023 03:10:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRAAmJhCSPZPBFIkIRnRDTMezRQSq9bAemTzRWv2oa1lOpcojAEl+76GMjqRE5d8PxdJpFpebFiphnK8F2QkkXEjSnkruT3pjSiTfox61ZmMRV2Aj0p5G69TfcRdzpyxNZHxCG9H0L+Shp4C/goI5vIgvM1xpJrUuv56m/LpRmDz/ydEF5U9KrdzAZNkRCEUEpAk8f1gmXEyQA+iwLrHa8bQESlvW+mCJmHSdwRBUmWSrphmSgV9mnHZV74nZczGo24lahEOL5DNsIhktkMcKXY4icN+qxD8os50pu4iqm0RfE/sfE8PPwXx+HNRTdQ2k9JtWVgOmTVwVmmEtEWyww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lQTiYXGrbKFo2z75P2OX2D4kuX+T2JG+3tYaue0Wik=;
 b=Oz0TXGZIbX9//N4ufJLzXzoKiLXZS+XvCBbeXtS313Fw6xAtW5ulpQOuEUibEHaYzse4754wC2lMZanpxLqpM0D7hJUxI1hXrgpDgKm53DJUPFUsHagfqTXsEO8RRBbDp5lnu/yRritj4gxu8uYn2KfyaKKcFlFEq/UL1ie8XPnoHVZ2I1ttTRDlxURfjTAL2hLHmJtAKpn5m1gxqkmpxtufQBew24dtw9AtkW2QGjdlKEmf46LF9ztO7J1fgIoOQuKBEfrY8pJoLBH33R+9e4e7aABJj/4kpQ5JZZWkEJRhVpqLKii8Wjn6dNUOpWvpyELHLzgATfQkwzl2cV4Rtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lQTiYXGrbKFo2z75P2OX2D4kuX+T2JG+3tYaue0Wik=;
 b=dGA1jp4NU0cG5rUNRFND57wtljxJ1D+SwSaSc4sEKOr7gelBrkQHBhj7obWWWrtSDPs4ngtbAA8rshegMlc4EY2Q58Ghokm/3lin0An1bsRgmmyzH2adkplehRYZnzSLSTj3sQRk/6gjfq/GftBlBkIrYvpXns9WeBW6ejHXY2Q=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by PH7PR18MB5059.namprd18.prod.outlook.com (2603:10b6:510:15e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sat, 19 Aug
 2023 10:10:01 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::8d00:13b4:289:daff]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::8d00:13b4:289:daff%5]) with mapi id 15.20.6699.020; Sat, 19 Aug 2023
 10:10:00 +0000
From:   Suman Ghosh <sumang@marvell.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linu Cherian <lcherian@marvell.com>,
        Jerin Jacob Kollanukkaran <jerinj@marvell.com>
Subject: RE: [EXT] Re: [net PATCH V2 1/4] octeontx2-pf: Update PFC
 configuration
Thread-Topic: [EXT] Re: [net PATCH V2 1/4] octeontx2-pf: Update PFC
 configuration
Thread-Index: AQHZyo/3NE7iY9C6GUGnM2/TbmTYJa/ilsyAgA0RXnCAAJzlAIABL3Ew
Date:   Sat, 19 Aug 2023 10:10:00 +0000
Message-ID: <SJ0PR18MB52165078B560F019391C290EDB18A@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20230809070532.3252464-1-sumang@marvell.com>
        <20230809070532.3252464-2-sumang@marvell.com>
        <20230809160517.7ff84c3b@kernel.org>
        <SJ0PR18MB5216486E191AD5D8B6B12F3CDB1BA@SJ0PR18MB5216.namprd18.prod.outlook.com>
 <20230818090022.50e1c46a@kernel.org>
In-Reply-To: <20230818090022.50e1c46a@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3VtYW5nXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctOGM3ZWRjNDktM2U3OC0xMWVlLWI2ZTktODQxNDRk?=
 =?us-ascii?Q?ZWVhNTRjXGFtZS10ZXN0XDhjN2VkYzRiLTNlNzgtMTFlZS1iNmU5LTg0MTQ0?=
 =?us-ascii?Q?ZGVlYTU0Y2JvZHkudHh0IiBzej0iMTY2MiIgdD0iMTMzMzY5MTMzOTc5Mzc0?=
 =?us-ascii?Q?OTE0IiBoPSIxeGg3bUJUUEZhTm1ocEhNZUNCTXlGczhSbzg9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFONFBBQUJD?=
 =?us-ascii?Q?bGRkT2hkTFpBVWlNUzNkTlhYbENTSXhMZDAxZGVVSVpBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFCdUR3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUVCQUFBQTlSZW5Md0NBQVFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBWkFC?=
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
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|PH7PR18MB5059:EE_
x-ms-office365-filtering-correlation-id: fc635893-aa45-4d78-6492-08dba09c72e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xZ/lIo7vVUCicjlCNaqPIWgZP/huvVJlYdAjzLio5SMtW9qD+9++uUl5FOtvD8bZXy3EMIMCwiPu4rnhPhjAfc8ytEFJueByj1cZGpmSN/rv/BZ9nCVDjncfxcvzjxyHzJKVcTGTd9GtYTVB8Yj+qRWsIm8c2t7yogzYg4sVecBZmEkCcIxCPNcdWmHRYHGVw201xHs9YO1NVDeHCVqYbUfXLEs73akGxyU6TNzTXikGTs2y2/+zZc7gDLRIZDuSjbJJw5ilqcVKEaJ28MBlrzbXZg7SjFFToFaTbf/6Cf6O4hp5urMh+umAtTYyzQsavbEJx24D7tPJWpXMgj4Joe/0XZVItI7qCtETcrhNq3gzFURZzxMZO8rfilsyASRijMJOHG6PsnwkN2MwQiBHaK6sFtk/xrRafnjBfllyoVZiArBLGmO+GgJn8dxAgstAdloIRsSg7LAOn8rgFOylhQUEFh6jEYxAV1YtvSIivIQtrA9pIifPdDrXwwJOBvEWw5Q4k9UgLjb3ZcIqyNuAwSK0rX5ztiKgC1O6K6XDpWYHF49JgN84v2qMAeLElr7DtZ//qpRhe/jkZ+Kg08DNh8ss6O6fgdSK9yHOLlk6JI1X1HhRFpHLVlTFoviuVdYW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199024)(1800799009)(186009)(86362001)(76116006)(64756008)(5660300002)(15650500001)(33656002)(41300700001)(316002)(2906002)(66946007)(6916009)(66556008)(54906003)(66446008)(66476007)(8936002)(4326008)(52536014)(8676002)(478600001)(71200400001)(9686003)(38100700002)(38070700005)(7696005)(6506007)(122000001)(26005)(83380400001)(107886003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?71iRIlpHJ/JjUdRfYnwpHZ616c4f+6a5BocZhtOAvqP/qeai4z02E56zEi/E?=
 =?us-ascii?Q?RU99L7bbFRfOIA2jgePbjOFO80a4h+DRZYnzutozYqYN1H7sK4u9/HYIlFI/?=
 =?us-ascii?Q?4LKX1gG9W3jN7jVtCyOfg6iv8NaFTV+1wlCmic7cKzJKEHb9xMMq5b5jLNP+?=
 =?us-ascii?Q?FEIIzSRibsc7ypz+C2wsE9BGW+HOFEA2hh4GBpAhZiyQfEXQ0ryKUTKxwL/q?=
 =?us-ascii?Q?qpjrjnIsA9IsROo9atjT1ZOUI+N5KDfYsbWtVhgOhEkj4R0nC9rIZFuYhq9C?=
 =?us-ascii?Q?nqavQ6YyKRgFUPfl7jU1Wdak8pABReYQ5Mw8D0juHkQp67epJxlP13WEd/c1?=
 =?us-ascii?Q?Xgf5xC/jyqlvtY/Hvo63DwERUTOKF5v8PW/S15l2v1s96DgBZYUhMkUehpUv?=
 =?us-ascii?Q?uaTK7rYHJ8lVxcEs6Lk0KEvrL57jt1g5Cw7tHkB+vlS/GAl7OG0VAl2xxz7x?=
 =?us-ascii?Q?sQmOktKsIh5PpJZUvrde9mkihqDQguzARo5UN7JUj0FG1h/04oedanHmtVp1?=
 =?us-ascii?Q?7GTL96uu0dGSWJOSgRa8BaKPjkOTOHcy3pbIEsLHcj+N3TZpDfGpJfEk5Tou?=
 =?us-ascii?Q?phsSscpAhE3UhCIohxQcbrMLI5hoFQAX09KH1/pLEiqxfk7ujBYhIlvouFns?=
 =?us-ascii?Q?qsI/h+hnkBJh7y0B/ihihepEuLWkPptkqKzcQAlIgkPQDST5k8qT9dueFHzw?=
 =?us-ascii?Q?fU/7EoASBYNUT50mveImBqbrM16rst/zdtOIFnfxVoV4MpPZCUciHKx0GPQ9?=
 =?us-ascii?Q?fCYf1XlvYX9nk5AvzPc9zO8DBV41dNzFbexSfFrOFH0pWgMTbXw2/ha78MHZ?=
 =?us-ascii?Q?9As0Zd8bE1xMfw2Q/DzOralhmQxQcvDvYmMc7ra/PVASaqp50SItbBLtLu7L?=
 =?us-ascii?Q?pqDOOMpKzybL2yiH6O0lW/7T2VJ6uJ6lSIyyIaVCzgXz5+VPmsHbRoew4CsJ?=
 =?us-ascii?Q?jjdABYSb7nmG6WnV2gM0w9IVa67UlhAvE2hv2sDwbrOmKfVEVrhn67vjUp+S?=
 =?us-ascii?Q?oUQSxrpdSlESdCcguWK1bGNFGC80GEl36jcJjvzwFH7k2GjiDBcYBZI2hSHu?=
 =?us-ascii?Q?Eis/6tCtEqzjG71koXZm7tsYoyAHclJYIG5Actg+K8y4hn6CoGqHdFqpFjpp?=
 =?us-ascii?Q?BKi+aWKTdAjEodzvSe+t2Q4rJa2oMH5qwu3Onp/pjLBjZEt2ZykpmoQfLm7E?=
 =?us-ascii?Q?WiCsD/BQtcwQl6JvM1TrJto5rR6j4L8TadVU2gmUki304r73NVzRfJeq63V2?=
 =?us-ascii?Q?HpELVfuEIvzqyvEkFaxyMWNVQ0gQrgt58Tjdmmf5HK+yNQTKbKs/0vhyFUw7?=
 =?us-ascii?Q?DZXCP0xhA9XTZ9q2kdTpCQvK3vcQrK/5VqKOZed8qNyOv0msO3+yTgYNxQbe?=
 =?us-ascii?Q?j2RGSG9iKkvcSU/5gzSbS0AhYslkURJDDQGMWIbThl1NnMUthXreNDJPDg5w?=
 =?us-ascii?Q?DH4XNgtyUwZ7MJqO+qnMxk9H3T9PnsQEH7mJYjngMTMS+im9hL9c0qVM0rDo?=
 =?us-ascii?Q?dGYfRIYI7b04jPjEnjMlFuNR+8oskaiEVNp4c8gWke/PSpKuULYKOcm44th2?=
 =?us-ascii?Q?wVa36zzooTYSyRONcFTGseYtacr8jyo04RrCRMkc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc635893-aa45-4d78-6492-08dba09c72e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2023 10:10:00.5336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bcnofZ9yMd1ftWeWewAWClbO3EsWJ9l2iYmyKZkZiBnXpboKjfswXBC7kffHJWzWCSQHAF5FynqxVWpxkvzhGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5059
X-Proofpoint-GUID: Ry4qswUAUmxuVISfCNOLvsMOY5IUaEHC
X-Proofpoint-ORIG-GUID: Ry4qswUAUmxuVISfCNOLvsMOY5IUaEHC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-19_10,2023-08-18_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Thanks for replying a week late, always a good use of maintainers time
>to swap back all the context from random conversations!
[Suman] Sorry for being late this time Jakub. I will remove this patch from=
 the patch set and will push a new version with the other three patches. I =
will analyze the issue in more detail and will produce a proper fix.
>
>On Fri, 18 Aug 2023 06:54:52 +0000 Suman Ghosh wrote:
>> >If there is any error in open() this will silently take the interface
>> >down. Can't you force a NAPI poll or some such, if the concern is a
>> >missed IRQ?
>> [Suman] I can check the return type of open() and report in case of
>> error. But even if we force NAPI poll we might not be able to control
>> the watchdog reset. If we have a running traffic and interface is up,
>> when we force NAPI poll, then the new packets will have updated
>> scheduler queue and we will still loose the completion interrupts of
>> the previous packets.
>
>Why does it matter that you lost an interrupt if the poll has happened.
>Can you describe the problem in more detail?
>
>> Do you see any issue if I handle the error situation during open()
>call?
>
>No, for years we have been rejecting code which does this.
>If the machine is under memory pressure allocating all the buffers for
>rings can easily fail and make the machine drop off the network.
>You either have to refuse to change this setting at runtime or implement
>prepare/commit reconfiguration model like other modern drivers, where
>allocations are done before the stop().
