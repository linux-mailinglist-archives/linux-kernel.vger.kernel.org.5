Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C27D786736
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 07:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239867AbjHXFlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 01:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239724AbjHXFlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 01:41:14 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC99E67;
        Wed, 23 Aug 2023 22:41:12 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NHwgT6001949;
        Wed, 23 Aug 2023 22:41:05 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sn20cx74n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 22:41:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUL1hXUNT5bhcz2paetVo47DxpVnbB9qgSuP4noa5aKf4ful7Xiqo1M3O4vOXNrGV17DtdVxe0xmaz8n9AfKi/HSDKrpCefN8+PCnUTQllABHZ57UJULk4EGLNdd4hPNXuTAZ1ijiCELgCKvSfj1ZbAcxfqSHc655jvzBKt1jki5VUMrmU0/nJIhBkC27PjQVlOUocqzDH44mVuTUoPcrGF1lVYbChaZqH3AQ5QpzY48xz+dQKxBCQOpaox3HV+31br/P4xG2eAjbrwjEdX4Qi7iK5l14ysmTejkNYES7yvvnSFnR6/61DaLZN+6fz38Yjgk4u3L+RFV7AR5dJJXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+fr5QdozcHsBCxmfIdjrA5fPRr4/UqbQDObEFeYCJI=;
 b=j7KyS6Llphb531ge6Vc+q8V1gPuMRkGnf6wQ5R/d5yEl/hX5Qs64zpEMRh6q+LsGY1OefhWuMFNhpYFBU1lmhcBYmL7KaUD8G7edVPcScpYPWR9xUhjoLlpbmn4jltTQXfe7NTy5e5w2F00Ysa6YAleVaAFDk7j7j0zLQRy0zgSonwxgd3ZHSZHJ5VM+wfbHkXaozZiy4QazOafAlpFssmp1FkD/jBPugEW0vme82UbzSOBrrV68A7vhqz/ZP8cHsNtFIQ6lYAF9nIGAeAJ9kHoosVDBEY67qt4hwAAPgS0hThyTvCN0rQFletL0LFm+3jyWBHdkwPm5xyB08wAuqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+fr5QdozcHsBCxmfIdjrA5fPRr4/UqbQDObEFeYCJI=;
 b=DHnR2g3qbEj9WUKFVkQH1NOAjuEWyqSCI9IiElX1WecZjWrbcfp0Dkms0+swA/LJpQlLWKhMQih8Q5ciCBJ6OajNAcZ+SeId3ml/qLrSCracdMqYEMpRtYFAS2VlNBWBhQItvxZhHX9+rCnGPai2dG7QKYAN8RwMpglEPjOSP34=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by DM4PR18MB4142.namprd18.prod.outlook.com (2603:10b6:5:389::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 05:41:02 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::40cd:dad4:16a7:c214]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::40cd:dad4:16a7:c214%3]) with mapi id 15.20.6699.026; Thu, 24 Aug 2023
 05:41:02 +0000
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Jerin Jacob Kollanukkaran <jerinj@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [net-next Patch 4/5] octeontx2-af: replace generic error codes
Thread-Topic: [net-next Patch 4/5] octeontx2-af: replace generic error codes
Thread-Index: AQHZ0xx+57iYNqI7c0ijjwEX2ps9f6/49KoA
Date:   Thu, 24 Aug 2023 05:41:01 +0000
Message-ID: <PH0PR18MB4474038302489C10086DC1B5DE1DA@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20230817112357.25874-1-hkelam@marvell.com>
        <20230817112357.25874-5-hkelam@marvell.com>
 <20230818195041.1fd54fb3@kernel.org>
 <PH0PR18MB44744DCAE48DA4AAE1082A1DDE19A@PH0PR18MB4474.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB44744DCAE48DA4AAE1082A1DDE19A@PH0PR18MB4474.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcaGtlbGFtXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctY2QxNDQwZGMtNDI0MC0xMWVlLWI2ZjgtZTg2YTY0?=
 =?us-ascii?Q?YjVkNWQyXGFtZS10ZXN0XGNkMTQ0MGRlLTQyNDAtMTFlZS1iNmY4LWU4NmE2?=
 =?us-ascii?Q?NGI1ZDVkMmJvZHkudHh0IiBzej0iMTg2NyIgdD0iMTMzMzczMjkyNTkxMzMw?=
 =?us-ascii?Q?MTE5IiBoPSI3S1QxQnc4R3VJc3Z6STlobVk2NWJPMXJKRTQ9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFONFBBQUJI?=
 =?us-ascii?Q?TTI2UFRkYlpBUzdzaGtaU0s5N1hMdXlHUmxJcjN0Y1pBQUFBQUFBQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQURBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
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
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|DM4PR18MB4142:EE_
x-ms-office365-filtering-correlation-id: 20858f70-50ea-45c1-360f-08dba464b394
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Na2viPw++wI5Oqoe5samHa7b+BjF/l/q7v/qIeOBHK/NDv2r37KWnTKQQRxHaSYHC+YpZeP3Da4bzeHbuqUHPA7LmM3Dc0QuDk8K2fx0uvHy+aNJ14sNJxaGnE2Zjh+9Jd0SIELpoCk0l72Ert9H6MbrT6Y68R/OyRVTiuDX3N7IsCb2U28C6q9RjbWys05NCg+4G1zX7IX/OhYFnNM0bXhNtmWJnN1yyVki49k1h86kGO5Gz2JS71J49/s0y2PVSDxR3dCf5oMCTM9/gTBFKgG3SLKVbboh1wNgAD7TPC+e5W0opDsuypOZ5yyyLNYun5xyRUJfaqsz8UJiMphgcL2SJI8TVKTONP0ekEni0a7wsSdvwCFU5xuj54jLx51bZ0xC7xyqWcQB1NGOdkC1H8jP0T8j7JFJ7yl3WHLtr74SRXGd3rzUTLvUfBUs+HmouULBsSlG3BFwMPhfy9bdSqWY3FCm6wM+9cWM/kz9GPF420Fy95Yb1E9UAodsKlxAdYZy4DEI3771xyknfgEYEN5Fo1OK/BsEi2HMxFZLFCxvirjom1aLKDqou4wJZwHmxLUOEDFHhHrwqxA+9QAQT8Z3GocWF5Xrxb+MI+30iN6sOEMws5NX3XLFkBVmChAceW739bv+C4o9PBSgORazvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(366004)(136003)(186009)(1800799009)(451199024)(52536014)(5660300002)(4326008)(8676002)(8936002)(83380400001)(33656002)(55016003)(26005)(71200400001)(38070700005)(38100700002)(122000001)(66946007)(76116006)(66556008)(66476007)(66446008)(64756008)(54906003)(316002)(6916009)(478600001)(41300700001)(9686003)(2906002)(6506007)(7696005)(86362001)(53546011)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qbZOQL4OOIWrwMFtKy55AKsMOzKg8CaS7dKWPQJa0OYFO9bwintrHnwwDTcI?=
 =?us-ascii?Q?Rq64dy5Ys2B+VuuhlWjNZFXSM5JjSMK7+fEb+XTRR+8i7uaM3XlIXIGjZoaB?=
 =?us-ascii?Q?m3HReX/4BMaxVAWmA47NyV3H8g907vSDgUpO1LlmX/tR/1XKFT7sgLRqqM/t?=
 =?us-ascii?Q?tM7xjIKdW/5j+aXL+VL1EWgCGb1iy7Bi7eGs4T4l4gWrJBystRYw4aiYt9Ho?=
 =?us-ascii?Q?OzzxAyFaQNuKol2qFzMbm/t7ig85EczUSR2mjChLTyDi4vr/yfhqaYgKUqc6?=
 =?us-ascii?Q?Dc+bC/9sPeANdfWEwyX4JNxBz4Gg0awrylLcyfLEEeCPW+aaGRX2anamq3i5?=
 =?us-ascii?Q?kTWTGr1nszoIJuJaDhQLVlxLSeaOqqShlbP/TTSXg3FRTKYTSqy+T4fhp1lZ?=
 =?us-ascii?Q?cRRRbun3TjwOfk2U73OFDHY1FQo1MfTCcMF/DLe4q2J7FOkLu1r1cz7fKMjF?=
 =?us-ascii?Q?qjLA/22m+UzrR/kzizTM3SIeKpPxpIGxtLV54KxaNI0rvSCsNhNFbf1IqrhJ?=
 =?us-ascii?Q?t/tqUprNILvPDJuQ5E9eARdXa2zt8uDm/0Yhofi+jcRPgRPMYLP3Z6w/3wEZ?=
 =?us-ascii?Q?p/DYevD4ViloRtlcC0Qwua5s/Yjj7cd97O8UR2DIoBueLWqUFpzZltfuydIP?=
 =?us-ascii?Q?HOp4bta38ffbegeCTBqHJEIhUOyxFn8LXpAJzGjj2Hohfe5hDe/5HL48z/9M?=
 =?us-ascii?Q?V/7uAlLzbQx9dDGGIWwvC+8PNSVkVAfi5W2fJaorRoPVfvW4J32ocWY8lpzN?=
 =?us-ascii?Q?G+2lj7yQRUaHslqikHtqhPIfZhH6ARWTk+0CYnazWMPvsIZAxMQxhtLjyakJ?=
 =?us-ascii?Q?jZlwvMEJBoQ1dXreNwtRHbb9e63EGO8bL3vyXWI4Wq1CsIHUgzi18f9IDIlv?=
 =?us-ascii?Q?8U2v4tzpKoWkxat4XDvaz58BVj7qdyXOQrz8fL1jfA59iW2Ve0XZ0tv+5ZAP?=
 =?us-ascii?Q?v0M8nMTJ97gFDKKzm71Oz/27dwjE85OrzVrEZMtajnH4fPaKFMY56SMzWdNB?=
 =?us-ascii?Q?CZk6F37ynsPZki2KO6jeoX6muSi6Pfo+GGUeWHcIWO2mObgXgIsTJhppE8Yu?=
 =?us-ascii?Q?DpwqZpS1FPORs0bpsSWj/Q3E7vhQOrxsK/g8PcNXntR987oHfAXd85ISF3XQ?=
 =?us-ascii?Q?lvACKKw+6CJVVsb+W0O0WUK3pI112mZ+cd2styL99oHht3d7R/FPXMIMxA4A?=
 =?us-ascii?Q?Kcl9mPfu/i2uGnGzPW56eyjpN2X5fxF9Hw9iaq8Z3nJmkzQNWHBkYXuyjw2j?=
 =?us-ascii?Q?WB2xLxnikyBeJe8mHeizV/ceJwxqktI+00AF8uRUaqsQB8DgYMQO+zvR3S7a?=
 =?us-ascii?Q?4eszY6lrLT1ptdiFRL49BkeNLz2Kr+A7+emmQ5B7MUYM1Fow+RhacVwtJhkP?=
 =?us-ascii?Q?xgc912bXgP/dAM3FtcKAUqePlak+bcXDCEeTsVcyOMAqRRmiRS+xckDqhXPa?=
 =?us-ascii?Q?gVBqTL0VfR9msC7juWp1SzWKpwPoYqsrE+4tNpfwKrgKmKUXDlTux7g1pTQC?=
 =?us-ascii?Q?ruZauWy+Urrs1XCJfB/hgEfV/4h039Pr+8IKd6T24ob/NG6bkbNafoN7i469?=
 =?us-ascii?Q?9mEQrxm8mQL24hdBZRY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4474.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20858f70-50ea-45c1-360f-08dba464b394
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 05:41:01.9185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vKwT6qKFpJQJQUxYQGQaHqz52wXDVqhJSv2dPjnWpYrCzZH7LAfqMLO/w2dE5D+9FEvwwKVHbg3aZSxd1YUfFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4142
X-Proofpoint-GUID: 4Ft3O7SEcPNgPC_E_ZxTjwFmK9HBR_2W
X-Proofpoint-ORIG-GUID: 4Ft3O7SEcPNgPC_E_ZxTjwFmK9HBR_2W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_03,2023-08-22_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Hariprasad Kelam
> Sent: Sunday, August 20, 2023 9:42 AM
> To: Jakub Kicinski <kuba@kernel.org>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> davem@davemloft.net; Sunil Kovvuri Goutham <sgoutham@marvell.com>;
> Geethasowjanya Akula <gakula@marvell.com>; Jerin Jacob Kollanukkaran
> <jerinj@marvell.com>; Linu Cherian <lcherian@marvell.com>; Subbaraya
> Sundeep Bhatta <sbhatta@marvell.com>; Naveen Mamindlapalli
> <naveenm@marvell.com>; edumazet@google.com; pabeni@redhat.com
> Subject: Re: [net-next Patch 4/5] octeontx2-af: replace generic error cod=
es
>=20
>=20
>=20
> > ----------------------------------------------------------------------
> > On Thu, 17 Aug 2023 16:53:56 +0530 Hariprasad Kelam wrote:
> > > currently, if any netdev is not mapped to the MAC block(cgx/rpm)
> > > requests MAC feature, AF driver returns a generic error like -EPERM.
> > > This patch replaces generic error codes with driver-specific error
> > > codes for better debugging
> >
> > The custom error codes are not liked upstream, they make much harder
> > for people who don't work on the driver to refactor it.
> >
> > If you want debugging isn't it better to add a tracepoint to the checks=
?
>=20
> Hari>>  These error codes are added in AF mailbox handlers, user space to=
ols
> like ethool ,tc won't see these since these are between pf netdev and AF.
> During netdev driver probe/open calls, it requests AF driver to configure
> different hardware blocks MAC/network etc. If there is any error instead =
of
> getting EPERM, we will get block specific error codes like
> LMAC_AF_ERR_INVALID_PARAM, NIX_AF_ERR_PARAM etc.

Jakub,
Any comments here?

>=20
> Thanks,
> Hariprasad k
> > --
> > pw-bot: cr
