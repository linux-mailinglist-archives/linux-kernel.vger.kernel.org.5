Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0F381093D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 05:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378507AbjLMEwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 23:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378466AbjLMEwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 23:52:20 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3B398;
        Tue, 12 Dec 2023 20:52:26 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BD3Y1Ko012763;
        Tue, 12 Dec 2023 20:52:21 -0800
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uy4tgg724-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 20:52:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cixrvh2UTFeLG4Nh3+rDG3MTAzZteeOHia11uDSQzlsPRfBGobIItmqNcTUUCXpygxJx931Q2BzYTREpSFZI0iQXrxFp+cbq5cReV9wGXWJnQDCQOnBnzYqN0qRfAQDIZ5a5kQATb0WOugkQU56E8SzvBPEeDDhu7Gy4oikeG6jUtPDjejEC4spXkNgfvuV6IN9TijBEHtDQ+GgFtNQvKLrrk/gyao2fhdcYe8wt4BYDLJ1iVLdkRhwyyZixbQcuJzNjzVGlfIwmUnBpkl+n8MbHfuwV/uTQ0NGe9g7/zfZ4anQctXA87vbnNn/nd0sb94fLJda6mUY4CDbM/Nq9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzgUkW3NoKdplkh75Vz2yQ1ovyHLRmzNKnnstrjiJ4M=;
 b=oND/XUdeCgOUkyOrVY/DxtvYtyNSLkP1EpCQH47nCP3s9ONBQlc92+1n6uxcHiX5SLK9Recrh9s+COHH5bzHVPWfIFOgnEKPdjFL+h3x/8DdtjvGDO+cceM1VswFnIdxwm9RkS7K8CsAdvaJDDHJ3oJN24d4FGamGMTZO4WOFbJQzAuSxqx5FVt+Xr1ln8tMpXY8sjrypHPdQeOVicblF8zU4C+KJsnRaeFlW2kgQyxDJFhrrNri6GtaMJak/AnPpWhT7OwpMB9mGnJIcH+7HxEEXcNRquAKrpvb1pz5ifu4g1MVvJ4NmX4lrZK8t99of13Q0nOfQndIWdyfATqCdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzgUkW3NoKdplkh75Vz2yQ1ovyHLRmzNKnnstrjiJ4M=;
 b=J37iZBh3Y1LIBy/ZAcY98wdcEtvb+cs5E4Rp4c2ly3zqUS0A+lJc+KJQ0jLuYlnXBFYmF6LdTCv+Togt3H4Ogk4wR6BYUjhv1x5NGcbL1QZa2/MkUs8GbPivSfdQV2RE2TM4l+x+0fcPdy9YzpPMIiZNAGsZjmHbMBJHhQsORdc=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by SJ0PR18MB4833.namprd18.prod.outlook.com (2603:10b6:a03:3e9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 04:52:18 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::6a4f:cb8d:70fd:ef2]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::6a4f:cb8d:70fd:ef2%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 04:52:18 +0000
From:   Suman Ghosh <sumang@marvell.com>
To:     Simon Horman <horms@kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Jerin Jacob Kollanukkaran <jerinj@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [net-next PATCH] octeontx2-af: Fix multicast/mirror
 group lock/unlock issue
Thread-Topic: [EXT] Re: [net-next PATCH] octeontx2-af: Fix multicast/mirror
 group lock/unlock issue
Thread-Index: AQHaLNvX8WS5xAq8vkuTBqQGFCVEArClf3WAgAElgMA=
Date:   Wed, 13 Dec 2023 04:52:17 +0000
Message-ID: <SJ0PR18MB521639933FF3226216EFC982DB8DA@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20231212091558.49579-1-sumang@marvell.com>
 <20231212111601.GY5817@kernel.org>
In-Reply-To: <20231212111601.GY5817@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3VtYW5nXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctZDkyYWVmOTQtOTk3Mi0xMWVlLWI3MDAtODQxNDRk?=
 =?us-ascii?Q?ZWVhNTRjXGFtZS10ZXN0XGQ5MmFlZjk2LTk5NzItMTFlZS1iNzAwLTg0MTQ0?=
 =?us-ascii?Q?ZGVlYTU0Y2JvZHkudHh0IiBzej0iNTYyNiIgdD0iMTMzNDY5MTY1MDU0MDE1?=
 =?us-ascii?Q?Njg1IiBoPSJJNEFhZnZZM2ZZWVpuWkhPY3RCM0lxa1pHSEk9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCZ1dBQURG?=
 =?us-ascii?Q?T0lPYmZ5M2FBUUY4K1R4R2lrTWZBWHo1UEVhS1F4OFpBQUFBQUFBQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBT2dZQUFBQUFBQUFJQUFBQUFBQUFBQWdBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQUFBQWFCZ0FBR1FBQUFCZ0FB?=
x-dg-reffive: =?us-ascii?Q?QUFBQUFBQVlRQmtBR1FBY2dCbEFITUFjd0FBQUNRQUFBQUFBQUFBWXdCMUFI?=
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
 =?us-ascii?Q?QVpnQnBBR3dBWlFBQUFDUUFBQUFBQUFBQVpRQnRBR0VBYVFCc0FGOEFZUUJr?=
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
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|SJ0PR18MB4833:EE_
x-ms-office365-filtering-correlation-id: fd545aa3-3e64-4093-9460-08dbfb974892
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OXHn0z8QUIjvacLHWz+dmGyv7lUtEX/JLCm8R5IFUMHK6aXZfE8QXX3DzHA6XrJ1UVGSiNtTJGU4QcS2V/8mqvO8K87Vi2VSAbHeGrEI15Yw3dukYWdI+dV7c9k4jpxs9h4LZOo9RQumlsCVvINxPySmT/HXjziiFkIa47nUkDWJDUQEkUeM+O5tXXjUOj+vRFF33fb//dUGPJ6Z863rXXLRz61VOhFCQ813/3lK+nKoxQeM+X8jKFnQdQg9i+wjNG5PRARZYfb+fwIrFFJrxARUBeeO0YIWSSRDMEPp633pJ14b8ZUgUruEYdJ9nCIgYm7EoTqJaXJ/jbieIsmZ+J0WFhlVcuC2RKCpHn8QxQ6iJ6oBjm9xZ/pD6I5PZfcmbOgYX0w8Rx89t/IErVp+w9w08ttunexKw1xVQD7aq/J1CdBCw2hoyW45PkzQwQ7od/N2Xz83rrPI3i1bxqYmYMWxie7VZWsS/g9ln4w3zI83OtsB1gNOOpWSfv3inWsOd2cMbK9pxxzVfMwan8LSw2NaXifhuhBUAv8/IZLX+xY9MMdK8cY8nYfC5/agEjpGqnqWsWbMyYubvcX0Iwq8WQUofX8chetDjGttCvTzqzPfW6mPUR3jPSqWoDqAdYx0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(55016003)(41300700001)(2906002)(38070700009)(8676002)(316002)(5660300002)(8936002)(4326008)(52536014)(6506007)(9686003)(7696005)(71200400001)(478600001)(66946007)(33656002)(6916009)(66476007)(86362001)(122000001)(64756008)(66446008)(66556008)(38100700002)(76116006)(83380400001)(54906003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B3k1vV7kFVYT9q1/fjG2FpWtumuuR8RErHeiOOPSpCOJuqCW6PVRIrDxE7d/?=
 =?us-ascii?Q?HcTvp3fq63z8UbMu88nNy8bd6xZtlw6Clfeh7khVsIA+OEv8qO7DsSgb4h1W?=
 =?us-ascii?Q?avD2CqGhD1Ttr2BagAi7DW9H11oErn6OxI/UOZpL21AEpxBdXr4epjEIMdWG?=
 =?us-ascii?Q?1o4P18Eyfdv8vJ5tkmenxeCbTJQURFQLRK5oXsA2UZNKAf19sq8RsTMWKgOx?=
 =?us-ascii?Q?rOihq4e2nEk0GkuA9LpO2M7B65YQeXkLd+me7/ixcybqgXhlVSM0pF+3Y6k0?=
 =?us-ascii?Q?lneD1raIAsV973CUOIGiuCSDhvM4sClsbJMc2fht5650/XNGNMX0Cc56ybwv?=
 =?us-ascii?Q?+LWZ3z8KAXVw7Dh1uwBDzJn+wHfV3HLNi/iEiVZIupLoQ6sPr82JpKgunVMY?=
 =?us-ascii?Q?mvUYx8qvhVjAiMbOlsNQX9P9irE8ipY/gtrwExapsb5Hba7rBK0QJ5GmjZjQ?=
 =?us-ascii?Q?ix4v+BbPwr1eg6WXpAnhLhfrXuAXSZJFe0w55xe1MqZuyREzRw51SG07liLP?=
 =?us-ascii?Q?XtTl2sw7WMlT4IaTKeq2VRwFQOlIb+VT0HeS96fw9pRES+WuIhL0itOJNDvn?=
 =?us-ascii?Q?XGl4m2bebHzzOWFjk0xDXXx56y2Kxv8GyCFAOIEJCkgvpRaZsiIpJn65j4kS?=
 =?us-ascii?Q?J6CCHfYazHAtHtOrkPJ4G4gBez5kc0zFs8vH97O6tTRH667Mhvb/IyrJ6Up5?=
 =?us-ascii?Q?uwAqJA4Rl/dATWXN6WWIUJFv9s2B46AUpK2G3+V8/aKXH/iGcv+ITnICyF85?=
 =?us-ascii?Q?eynrBLsuStCtMisuZo6/R5Hk0gYl2wxd8FlIikzPeQBMVSnY5TavK9fO8HuO?=
 =?us-ascii?Q?ZNWFB5Dw6KCoris6s06oUijqkp3vwC8zJjXJ291rxjQ530JyC3tJb316iwCI?=
 =?us-ascii?Q?CFOCDaI1clahppoLnUDBqajEzl1E9eBzsrfpzdsfniRAWxFlcZ4pewF62qXa?=
 =?us-ascii?Q?9vpvmTp1o5DrPuAH+V2f3ewXIQxalF1zka98Z5cq7lIN+z3AfktdJS6ny2BV?=
 =?us-ascii?Q?g+bWjb0N04DOTc94AT6O4bAiV22NoWzSVjfBr8hTC+RF+O8m+kDPlZvqOGN3?=
 =?us-ascii?Q?FKaAmHc5QF+/Xi9ypFGQsa8377rfvUfCxlMU0ZdHRhw3O1h9bgZRrxBUfdHR?=
 =?us-ascii?Q?OvgYgUuxjzYiJnzLuYjHeBFk2KHMtg8zFYW278OeT+ucEbVyp813kdmotH7R?=
 =?us-ascii?Q?ThWxkQQuoLDaEJ/AxJHccqd4vV785lg9FR7LC0soaZiIzBi1eEKfwgb/MPEF?=
 =?us-ascii?Q?uMFHSjIlgF6Oyxzd2ZIiTCff1LGgP1ZHvyc2jFPw1ouj8sIAuwAFumATUk6g?=
 =?us-ascii?Q?VByeTvXP82cRWOsJLJsZTsLazmvtsofafOaGYaW9u+ZEGc+Odpg/3Xu9ZaK2?=
 =?us-ascii?Q?5gKezi1jWEvkrktIqjdCapUcIA4aRLfAitOGpLsOLwBVw2yOzlcdJ0tQsEHR?=
 =?us-ascii?Q?LbTYws9xSz5zJUiRv2zGJ8YXW/Ayhgz/R93DiC3Vv1l4esKZ+nyvY631sWGc?=
 =?us-ascii?Q?ALcXh9ZD0bmWIfz+2bPt7m6bTXdSkhBAS3YcPs5wXUEv/zG5TEsJoNtY8cBJ?=
 =?us-ascii?Q?9Ik8B3nQPxySk+/Un3qBTLe6da1dUw66TdNDD3SS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd545aa3-3e64-4093-9460-08dbfb974892
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 04:52:17.9071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJFwcBU1fe6+lhfOuF1FuP+MQ+wIWuxkuNXURlWJ3EIU+3xgxr6UmAJP/koBP1GX9wYn0mGX4oLevG3JedjZyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4833
X-Proofpoint-ORIG-GUID: kYBTcEsmzdnLZxnyaVdw7qEz_XDQ8Ffm
X-Proofpoint-GUID: kYBTcEsmzdnLZxnyaVdw7qEz_XDQ8Ffm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> @@ -6306,6 +6310,13 @@ int
>rvu_mbox_handler_nix_mcast_grp_destroy(struct rvu *rvu,
>>  		return err;
>>
>>  	mcast_grp =3D &nix_hw->mcast_grp;
>> +
>> +	/* If AF is requesting for the deletion,
>> +	 * then AF is already taking the lock
>> +	 */
>> +	if (!req->is_af)
>> +		mutex_lock(&mcast_grp->mcast_grp_lock);
>> +
>>  	elem =3D rvu_nix_mcast_find_grp_elem(mcast_grp, req->mcast_grp_idx);
>>  	if (!elem)
>
>Hi Suman,
>
>Does mcast_grp_lock need to be released here?
>If so, I would suggest a goto label, say unlock_grp.
[Suman] ack, will update in v2
>
>>  		return NIX_AF_ERR_INVALID_MCAST_GRP; @@ -6333,12 +6344,6 @@
>int
>> rvu_mbox_handler_nix_mcast_grp_destroy(struct rvu *rvu,
>>  	mutex_unlock(&mcast->mce_lock);
>>
>>  delete_grp:
>> -	/* If AF is requesting for the deletion,
>> -	 * then AF is already taking the lock
>> -	 */
>> -	if (!req->is_af)
>> -		mutex_lock(&mcast_grp->mcast_grp_lock);
>> -
>>  	list_del(&elem->list);
>>  	kfree(elem);
>>  	mcast_grp->count--;
>> @@ -6370,9 +6375,20 @@ int
>rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
>>  		return err;
>>
>>  	mcast_grp =3D &nix_hw->mcast_grp;
>> +
>> +	/* If AF is requesting for the updation,
>> +	 * then AF is already taking the lock
>> +	 */
>> +	if (!req->is_af)
>> +		mutex_lock(&mcast_grp->mcast_grp_lock);
>> +
>>  	elem =3D rvu_nix_mcast_find_grp_elem(mcast_grp, req->mcast_grp_idx);
>> -	if (!elem)
>> +	if (!elem) {
>> +		if (!req->is_af)
>> +			mutex_unlock(&mcast_grp->mcast_grp_lock);
>> +
>>  		return NIX_AF_ERR_INVALID_MCAST_GRP;
>> +	}
>>
>>  	/* If any pcifunc matches the group's pcifunc, then we can
>>  	 * delete the entire group.
>> @@ -6383,8 +6399,11 @@ int
>rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
>>  				/* Delete group */
>>  				dreq.hdr.pcifunc =3D elem->pcifunc;
>>  				dreq.mcast_grp_idx =3D elem->mcast_grp_idx;
>> -				dreq.is_af =3D req->is_af;
>> +				dreq.is_af =3D 1;
>>  				rvu_mbox_handler_nix_mcast_grp_destroy(rvu, &dreq,
>NULL);
>> +				if (!req->is_af)
>> +					mutex_unlock(&mcast_grp->mcast_grp_lock);
>> +
>>  				return 0;
>>  			}
>>  		}
>> @@ -6467,5 +6486,8 @@ int rvu_mbox_handler_nix_mcast_grp_update(struct
>> rvu *rvu,
>>
>>  done:
>
>I think it would be good to rename this label, say unlock_mce;
[Suman] ack, will update in v2
>
>>  	mutex_unlock(&mcast->mce_lock);
>
>Add a new label here, say unlock_grp;
>And jump to this label whenever there is a need for the mutex_unlock()
>below.
[Suman] ack, will update in v2
>
>> +	if (!req->is_af)
>> +		mutex_unlock(&mcast_grp->mcast_grp_lock);
>> +
>>  	return ret;
>>  }
>> --
>> 2.25.1
>>
