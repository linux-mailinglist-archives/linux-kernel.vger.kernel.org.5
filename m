Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D34375BDD8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 07:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjGUFoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 01:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjGUFnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 01:43:51 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490262D75;
        Thu, 20 Jul 2023 22:43:43 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L2Pdjb010493;
        Thu, 20 Jul 2023 22:43:35 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ryh7g8gn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 22:43:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHugqcQVwTt2rVyCadXgDsvAZD1FpX7MNIU2JOct43UDcxksVrkAQp9/nTJf82XS7mNaNj+sV8pqi/Ant0k3On9X1hYI3hHkHPQNiwNV3I765N1eikHrOfhjzbiGzwuQUlu6rk/cko5EZGXMYuPHSGk8va7SnisU6POMj0AjFvzOwUd/J9DCny60Uq8KIoBUuNgNpTxoihNNblJsKtcxJVnvWvnarFWeGHoYR186Qrf0YYUKudkgtXXxIfEhqgkRzW7nfFuLbJC/9E6DTTYG78NurGIAdzcyH6kCksvAXgrqkXgnNRaRKO0bFR1NZVfoKLQt3DIGFyOZlLW1tCTc1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEibYOKhr3YgpYsSa4rBxacnvPAmdrUB5ZenXk4kpMY=;
 b=YpPDVRhZkMU524BDL21O/GNbn5c1sXKvjRB7VZfMnnlIQGd50RBT1pWcJInfEvtxCkhhNbuAKboNgoVMy5zflzQRx2HVZpV8t5zvGqdtqi7MflxR0Rgj1VTTaIH2UVCJ/kWTc+Qa6GVLsQ7HQbBcnw7rS4q4D2d55drySZokAUXi2Stp0agPoLEeM96SG6q5oMTI6U0mvkS7Vyx6WjzigpT9f9Lk+UTZsEN7FNKlL2GgPH2Kxn7zvj/zEwaa/yxOV8X2hMzFUmWhk162dgGGr9WQLxTQjO14MWTYK/ffrPFYyGlIZkuDkog43lJJu7q+ozsdPlR4hvB/D7U8BKSgyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEibYOKhr3YgpYsSa4rBxacnvPAmdrUB5ZenXk4kpMY=;
 b=Gai/yCtCTmOR4wkOs1vhlYmcIpsNbn2P5dgq0FhFU1TJh8jDgN3LjhrW+P3QnPohmyHgRWCi8S61jkOcmceOLRDa5J8fqRKJ+unXZnBdVaNqkDyL7DYA40U+N9muwJQD9mEgG9HMExqCB9V45SuaqIBAKQAKhFuRpJBmbFSh5x8=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by DM4PR18MB4286.namprd18.prod.outlook.com (2603:10b6:5:395::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 05:43:29 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::a87:97e:8f7a:330b]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::a87:97e:8f7a:330b%4]) with mapi id 15.20.6609.024; Fri, 21 Jul 2023
 05:43:29 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [net PATCH V3 1/2] octeontx2-af: Fix hash extraction
 mbox message
Thread-Topic: [EXT] Re: [net PATCH V3 1/2] octeontx2-af: Fix hash extraction
 mbox message
Thread-Index: AQHZuBwQdKkVZMhOgU+ghup6AT7sRK/BME8AgAKLw+A=
Date:   Fri, 21 Jul 2023 05:43:29 +0000
Message-ID: <SJ0PR18MB52168D1146609692E01FC2F9DB3FA@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20230716193049.2499410-1-sumang@marvell.com>
 <20230716193049.2499410-2-sumang@marvell.com> <ZLf4DKJ6IU8+Z2zS@corigine.com>
In-Reply-To: <ZLf4DKJ6IU8+Z2zS@corigine.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3VtYW5nXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctODJhZDk0OWYtMjc4OS0xMWVlLWI2ZGYtODQxNDRk?=
 =?us-ascii?Q?ZWVhNTRjXGFtZS10ZXN0XDgyYWQ5NGExLTI3ODktMTFlZS1iNmRmLTg0MTQ0?=
 =?us-ascii?Q?ZGVlYTU0Y2JvZHkudHh0IiBzej0iNzA5NiIgdD0iMTMzMzQzOTE4MDYxNjE2?=
 =?us-ascii?Q?NDIzIiBoPSIyYWQ5M1hkeUdpaCs4OU5CdjV1Wm9iL05CNmc9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFONFBBQUFu?=
 =?us-ascii?Q?ZlFWRmxydlpBWHhJLzh4Z1BMSnZmRWovekdBOHNtOFpBQUFBQUFBQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUE4QUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBIi8+PC9tZXRhPg=3D=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|DM4PR18MB4286:EE_
x-ms-office365-filtering-correlation-id: c35a9fbe-e302-4617-7146-08db89ad697d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tn9TNM6D++nwNYP38kpvuyPy7PKyVueTtpf4bycOhuQxq2BvxYUOYnGFxuhprgfyfbP90iSiHqcYxsfsPqn5HVLTZaGDygr1NzhgBzmQbhSUfVuwRienF0PKWsODj3+3fzb3G6UvcJ9CVJLIBk1G/e4Hlo2x08fRilvPD30x6FrFYZ3/U+qJ85npU6H6+UwyqxM6K0pfvhinG78dyL24kRzd+A7X10XKhZXOK84C6K9Ttp8C2DozvLcCW2rjOvW6zGoBNCb3H0SuTt623NVYhEYom3CBGXs//15KdSsVvS+2hUNI1A3rsrKFEv5dAKgBEpBwwNNBxJGrk3ysDJq2pC45RhC8G8S7Zp6x/oe5fkbvsGrhAfV5G4zWuDrXPPmpB0chyue/FGArXy6x+M4EmS+oJ42J4a6kdwuNrE+UFkiTKJdtGFeD6sjYG1BrFYH5BSqGRVRgjkbtlaErIBKknLxNEHN1Mcoc7HJp9Mh9qcaOFfXZ+fDj0pqGTYO7dcF/9xvKg6/hI5dFJwFb8mWIaWgW4Wdjwd1m8YvoXHvD/GlyXA5kFLkFWwUJmxqb4fi4r2+UHpGMqqdO12tZPkth90gkAIhCPbxcUKfuIx8kvzRuiqEmpxXetDwVsrYa+W2R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(38070700005)(33656002)(86362001)(38100700002)(122000001)(83380400001)(8936002)(478600001)(2906002)(8676002)(64756008)(71200400001)(5660300002)(55016003)(9686003)(7696005)(6506007)(15650500001)(26005)(186003)(52536014)(54906003)(4326008)(316002)(6916009)(76116006)(66446008)(66476007)(66556008)(41300700001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IbO9FHNOheA48UGYRy0a2t45L/7eQQX+SRo4hzsqmTSuJur0wbWRCnk1tHz5?=
 =?us-ascii?Q?OM+z4QavBLTwCx9QEa+8SAKplCWhPQwFCug8e6cgI3PbVqREQd7SCOrs7W3R?=
 =?us-ascii?Q?ZByWAH71kdkACgKTlvF//krt+wQsh37GXmOLRl7JjK5E/nDYBOESBssdXBCK?=
 =?us-ascii?Q?Eb/XOHRKjC44dKWG1h99ZvKqh9QVv945Y8KrgPveggqWQ0LXbKjwBBQ0BbFu?=
 =?us-ascii?Q?m4Etc9bZyBW0lHWAwew/psOAVDdFWmJ8iYlj44aryg+uqr+ln+ATGoJkPxfA?=
 =?us-ascii?Q?XSMON0THcpgniJM5JXBaAbX8xrrQj5eK0k/aCju0iR21LRrHpUFzvOCUZ9YA?=
 =?us-ascii?Q?Ca1nBVQBLA+iAs5iCshQ2KOl5J+iLA9gfzQ6BKUTyX9zmnz1YTjVHGoqjgGb?=
 =?us-ascii?Q?gXk/FGqjAdwSWLAI5mEJ3wgze9LjcUeTBBlz34JMVfY1/j/mzN7Vnyx3aop8?=
 =?us-ascii?Q?yxdRV0BMnUVIbLkyN5F4HfZjdm40m+Q1ChqiNkWnK4Rr15QI3PG0fUtOAlqn?=
 =?us-ascii?Q?KrhJ1sisQMwIz+51TVglsi0KE1xHoZiLHrC/I0ElS5XbBhc8rcdFKI1m0kid?=
 =?us-ascii?Q?WsWjx4ASmge3IGOuDX6vD70EeaM0uKQebMlOJLiWrrTguE0LyzMjqL9iSQ0x?=
 =?us-ascii?Q?ssvjWR7LaM+WPwXDxylFTUUoOYI84AtEqWnIFAZm6McPbb+YBphPRi2A3xKg?=
 =?us-ascii?Q?Y+98BPEFcsyoPOQ1WUrS3DFkXIRgTiLbYb7AWDGKyNVHZt9XNI6v6Xf3i+7s?=
 =?us-ascii?Q?hGaf999DL9ETL+Vvd3QjdbzSPhv60pZn64j9G6sC3ehSh6dwYBobRSZXun8+?=
 =?us-ascii?Q?Sq2NPrRXY+YWVps8vi//FkSpSU/RGi2UVUMfOUuqCIfygHs8VvymwGTbGF7r?=
 =?us-ascii?Q?nGxaod+iOvF2epH2gVF0CibKTGoG8Qq96gj2T6ONq3VSU8CqlS6pxB8mQPih?=
 =?us-ascii?Q?27gf8ybAmP1hYTafKimkOGQTkeLEPH0u9g4vbsvcDiNeOmOzBHcYr0Ubcq5v?=
 =?us-ascii?Q?LD+Va9Dv0AoaF9TUb5f+T0Pug6Pp1/vtJDUetiCoT3zwZ2hRD3RU0IdTP54h?=
 =?us-ascii?Q?/XKwEh+OWMJxfNv5LB2UH0AcbZ9OC69mFj024U4PAonWS0fZhojEI4NBA37R?=
 =?us-ascii?Q?oRmvOF/yoAyeXYnVSnMmX10aM0g9QYTLtkJE2+RCz1lLaFVInFBnQPzAWD9p?=
 =?us-ascii?Q?WmHdrXkxyjFXP4zrbOMJYCXDgtOnUUfKRoGmFw+5GjsD6Pjp0pIBhUPoHYuf?=
 =?us-ascii?Q?yq9NUdG7RO229Bx0/KmczlP5qZZxbJ4wHJer0s/KkRO7AgCNcSOufsKkrOfW?=
 =?us-ascii?Q?ZOCjTpqRYYJcppDbHiDdQuFMKD14K+w2jtYwlKOcGm4amXKQImvGCvmGJpdT?=
 =?us-ascii?Q?8wKFCPDJhdu6pzv+8q6F0Kjn72icpe6ywnu6Pw9lyH5VAYrRIh8sgEJTBj2G?=
 =?us-ascii?Q?GcWqkey0SW4diMjbAdNsbuL5MBWWLIXIlgew+9MRP8/XCL98v9IlCnAVStsu?=
 =?us-ascii?Q?/OFJWV3Rd+fXTqMd4mwTVStBX68bBPKAYn8HI48toOdMunSpph4Domw7EfYv?=
 =?us-ascii?Q?6bp3ou/8dPfvKGbPOBgzym2Hi3Q0BoKoxryDJjVd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c35a9fbe-e302-4617-7146-08db89ad697d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 05:43:29.4851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUr/B7qKVVxsPRYuBY3tlhovH3pALUFsZBpT7bz3F9GD1grLunQo1/qDqIQXYaeHUQww4MEwfqQJ427xf5bWGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4286
X-Proofpoint-ORIG-GUID: Ao40_YlfpsMPVxpig_WQsHir9VmrAwX6
X-Proofpoint-GUID: Ao40_YlfpsMPVxpig_WQsHir9VmrAwX6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_02,2023-07-20_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My bad, I will discard the patch since it is already merged.=20

>On Mon, Jul 17, 2023 at 01:00:48AM +0530, Suman Ghosh wrote:
>> As of today, hash extraction mbox message response supports only the
>> secret key which is not a complete solution. This patch fixes that and
>> adds support to extract both hash mask and hash control along with the
>> secret key. These are needed to use hash reduction of 128 bit IPv6
>> address to 32 bit. Hash mask decides on the bits from the 128 bit IPv6
>> address which should be used for 32 bit hash calculation. After
>> generating the 32 bit hash, hash control decides how many bits from
>> the
>> 32 bit hash can be taken into consideration.
>>
>> Fixes: a95ab93550d3 ("octeontx2-af: Use hashed field in MCAM key")
>> Signed-off-by: Suman Ghosh <sumang@marvell.com>
>> ---
>>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |  6 ++---
>>  .../marvell/octeontx2/af/rvu_npc_hash.c       | 27 ++++++++++--------
>-
>>  .../marvell/octeontx2/af/rvu_npc_hash.h       |  9 ++++---
>>  3 files changed, 23 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
>> b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
>> index eba307eee2b2..5a5c23a02261 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
>> @@ -246,9 +246,9 @@ M(NPC_MCAM_READ_BASE_RULE, 0x6011,
>npc_read_base_steer_rule,            \
>>  M(NPC_MCAM_GET_STATS, 0x6012, npc_mcam_entry_stats,
>\
>>  				   npc_mcam_get_stats_req,              \
>>  				   npc_mcam_get_stats_rsp)              \
>> -M(NPC_GET_FIELD_HASH_INFO, 0x6013, npc_get_field_hash_info,
>\
>> -				   npc_get_field_hash_info_req,              \
>> -				   npc_get_field_hash_info_rsp)              \
>> +M(NPC_GET_FIELD_HASH_INFO, 0x6013, npc_get_field_hash_info,
>\
>> +				   npc_get_field_hash_info_req,         \
>> +				   npc_get_field_hash_info_rsp)         \
>>  M(NPC_GET_FIELD_STATUS, 0x6014, npc_get_field_status,
>\
>>  				   npc_get_field_status_req,              \
>>  				   npc_get_field_status_rsp)              \
>
>This hunk is a white-space only change that doesn't seem related to the
>patch description.
>
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
>> b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
>> index 6fe67f3a7f6f..a3bc53d22dc0 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
>> @@ -96,7 +96,7 @@ u32 npc_field_hash_calc(u64 *ldata, struct
>npc_get_field_hash_info_rsp rsp,
>>  	field_hash =3D rvu_npc_toeplitz_hash(data_padded, hash_key, 128,
>159);
>>
>>  	field_hash &=3D FIELD_GET(GENMASK(63, 32),
>rsp.hash_ctrl[intf][hash_idx]);
>> -	field_hash +=3D FIELD_GET(GENMASK(31, 0),
>rsp.hash_ctrl[intf][hash_idx]);
>> +	field_hash |=3D FIELD_GET(GENMASK(31, 0),
>> +rsp.hash_ctrl[intf][hash_idx]);
>>  	return field_hash;
>>  }
>>
>> @@ -253,7 +253,8 @@ void npc_update_field_hash(struct rvu *rvu, u8
>intf,
>>  	}
>>
>>  	req.intf =3D intf;
>> -	rvu_mbox_handler_npc_get_field_hash_info(rvu, &req, &rsp);
>> +	if (rvu_mbox_handler_npc_get_field_hash_info(rvu, &req, &rsp))
>> +		return;
>>
>>  	for (hash_idx =3D 0; hash_idx < NPC_MAX_HASH; hash_idx++) {
>>  		cfg =3D rvu_read64(rvu, blkaddr, NPC_AF_INTFX_HASHX_CFG(intf,
>> hash_idx)); @@ -319,9 +320,9 @@ int
>rvu_mbox_handler_npc_get_field_hash_info(struct rvu *rvu,
>>  					     struct npc_get_field_hash_info_req *req,
>>  					     struct npc_get_field_hash_info_rsp *rsp)  {
>> +	int hash_idx, hash_mask_idx, blkaddr;
>>  	u64 *secret_key =3D rsp->secret_key;
>>  	u8 intf =3D req->intf;
>> -	int i, j, blkaddr;
>>
>>  	blkaddr =3D rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
>>  	if (blkaddr < 0) {
>> @@ -333,18 +334,18 @@ int
>rvu_mbox_handler_npc_get_field_hash_info(struct rvu *rvu,
>>  	secret_key[1] =3D rvu_read64(rvu, blkaddr,
>NPC_AF_INTFX_SECRET_KEY1(intf));
>>  	secret_key[2] =3D rvu_read64(rvu, blkaddr,
>> NPC_AF_INTFX_SECRET_KEY2(intf));
>>
>> -	for (i =3D 0; i < NPC_MAX_HASH; i++) {
>> -		for (j =3D 0; j < NPC_MAX_HASH_MASK; j++) {
>> -			rsp->hash_mask[NIX_INTF_RX][i][j] =3D
>> -				GET_KEX_LD_HASH_MASK(NIX_INTF_RX, i, j);
>> -			rsp->hash_mask[NIX_INTF_TX][i][j] =3D
>> -				GET_KEX_LD_HASH_MASK(NIX_INTF_TX, i, j);
>> +	for (hash_idx =3D 0; hash_idx < NPC_MAX_HASH; hash_idx++)
>> +		for (hash_mask_idx =3D 0; hash_mask_idx < NPC_MAX_HASH_MASK;
>hash_mask_idx++) {
>> +			rsp->hash_mask[NIX_INTF_RX][hash_idx][hash_mask_idx] =3D
>> +				GET_KEX_LD_HASH_MASK(NIX_INTF_RX, hash_idx,
>hash_mask_idx);
>> +			rsp->hash_mask[NIX_INTF_TX][hash_idx][hash_mask_idx] =3D
>> +				GET_KEX_LD_HASH_MASK(NIX_INTF_TX, hash_idx,
>hash_mask_idx);
>>  		}
>> -	}
>>
>> -	for (i =3D 0; i < NPC_MAX_INTF; i++)
>> -		for (j =3D 0; j < NPC_MAX_HASH; j++)
>> -			rsp->hash_ctrl[i][j] =3D GET_KEX_LD_HASH_CTRL(i, j);
>> +	for (hash_idx =3D 0; hash_idx < NPC_MAX_INTF; hash_idx++)
>> +		for (hash_mask_idx =3D 0; hash_mask_idx < NPC_MAX_HASH;
>hash_mask_idx++)
>> +			rsp->hash_ctrl[hash_idx][hash_mask_idx] =3D
>> +				GET_KEX_LD_HASH_CTRL(hash_idx, hash_mask_idx);
>>
>>  	return 0;
>>  }
>
>The three hunks above appear to change the iterator variables for the
>loops without changing functionality. This doesn't seem to match the
>patch description.
>
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
>> b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
>> index a1c3d987b804..eb9cb311b934 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
>> @@ -12,9 +12,6 @@
>>  #define RVU_NPC_HASH_SECRET_KEY1 0xa9d5af4c9fbc87b4  #define
>> RVU_NPC_HASH_SECRET_KEY2 0x5954c9e7
>>
>> -#define NPC_MAX_HASH 2
>> -#define NPC_MAX_HASH_MASK 2
>> -
>
>This seems to remove duplicated #defines.
>This doesn't seem to match the patch description.
>
>>  #define KEX_LD_CFG_USE_HASH(use_hash, bytesm1, hdr_ofs, ena,
>flags_ena, key_ofs) \
>>  			    ((use_hash) << 20 | ((bytesm1) << 16) | ((hdr_ofs) <<
>8) | \
>>  			     ((ena) << 7) | ((flags_ena) << 6) | ((key_ofs) &
>0x3F)) @@
>> -41,6 +38,12 @@
>>  	rvu_write64(rvu, blkaddr,	\
>>  		    NPC_AF_INTFX_HASHX_RESULT_CTRL(intf, ld), cfg)
>>
>> +#define GET_KEX_LD_HASH_CTRL(intf, ld)  \
>> +	rvu_read64(rvu, blkaddr, NPC_AF_INTFX_HASHX_RESULT_CTRL(intf, ld))
>> +
>> +#define GET_KEX_LD_HASH_MASK(intf, ld, mask_idx)	\
>> +	rvu_read64(rvu, blkaddr, NPC_AF_INTFX_HASHX_MASKX(intf, ld,
>> +mask_idx))
>> +
>
>This seems to duplicate existing MACROS, which appear a few lines
>further above in this file.
>
>>  struct npc_mcam_kex_hash {
>>  	/* NPC_AF_INTF(0..1)_LID(0..7)_LT(0..15)_LD(0..1)_CFG */
>>  	bool
>> lid_lt_ld_hash_en[NPC_MAX_INTF][NPC_MAX_LID][NPC_MAX_LT][NPC_MAX_LD];
>> --
>> 2.25.1
>>
>>
