Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE79A80CED0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343864AbjLKOvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjLKOvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:51:41 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF15CD5;
        Mon, 11 Dec 2023 06:51:47 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BBDsDPR019781;
        Mon, 11 Dec 2023 06:51:25 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uvrmjmx8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 06:51:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWYODao0j29qdAKmhKKt0qjMV8aFVIx1whMtxcM/P8SBjuQ+OOuliUoZKz508HleaD0Ft+sQ0hqpdBzchFhz89OMHz/7zVdZbGTqAzVgcEQrcSi2kbhO0Z5khy88op6+p2TILXMsAivV0GaUXKs0JjqI05wRvqBYxCKDazEx08754hiAeQcRs4H9A7T0WzgOC6ogoZ13NHjfEtumldOFBwEit593x1NL+6Xc6svb/DFwDtNFIpLWWyd5h6N65O2iJ+syXD4u1EM23vxYLf+vGFq1V72K3ThPaGrDhP6P6DwZj63lWhCFJwNRaEUAoZTJK4Mdq59o1ZCjBxL99zugNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Db6eQT1a0T7QdD10THpLkQrNJyF43sZJzs9SNVk414=;
 b=GdqEzOPbbdfvt5tfkM7tZZG8tSVkoYb30K3iuICBEAJvJxMKuKyg+erUGl8mEB/9gKdNubyk4Uk42Y6m3LdACIYzqUEoHPI7mppmJC6hhS5TbfuwpHf7ccgrPcm0wXC1cb1dkabMrPOOTtWucobGCYHzLocugqSiOrjCH3aG3vqryN9IXnO1ujlYjRSyaM7LdM9d4HMhfZHrQ+AAXxR3Rlz0dvluJqU5l1Y5P04zfkUG737matI4n1mlSowMo3eYHggrhIZTFD2KKc8VQVZTcUnAxwqffONI3x8sLTJpbaf20KN70EchckYQ82pk0b+wr3HA1Ui8gsg1yZuYyWPlfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Db6eQT1a0T7QdD10THpLkQrNJyF43sZJzs9SNVk414=;
 b=jst0og99KrLTniUFtUbgweuTBBNDMZz4ZVJOrTBJ/lbcEiFS68peTZvhXyAeF3qFNJYs2FyGVXr6O60jjn4Ed7vQxNdlWamudAIpR3bLWdtAmOvTubOpedlgZsY5t9UkC6beBfIqGgvDY8IofcHSu5+RQDpOBTrWzUuXMFRtgvg=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by CH0PR18MB4257.namprd18.prod.outlook.com (2603:10b6:610:b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.21; Mon, 11 Dec
 2023 14:51:20 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::41f7:8311:f9d8:f3c4]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::41f7:8311:f9d8:f3c4%3]) with mapi id 15.20.7091.020; Mon, 11 Dec 2023
 14:51:19 +0000
From:   Shinas Rasheed <srasheed@marvell.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani <hgani@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "kheib@redhat.com" <kheib@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh B Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: RE: [EXT] Re: [PATCH net-next v3 2/4] octeon_ep: PF-VF mailbox
 version support
Thread-Topic: [EXT] Re: [PATCH net-next v3 2/4] octeon_ep: PF-VF mailbox
 version support
Thread-Index: AQHaK/wMORkyMuRMT0eHMOpWmawaoLCjxTQAgAAaEyCAABGSgIAAG5SA
Date:   Mon, 11 Dec 2023 14:51:19 +0000
Message-ID: <PH0PR18MB4734AAA106B7EDE3D80C59DCC78FA@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20231211063355.2630028-1-srasheed@marvell.com>
 <20231211063355.2630028-3-srasheed@marvell.com>
 <20231211084652.GC4870@unreal>
 <PH0PR18MB4734652F50856F52507577ADC78FA@PH0PR18MB4734.namprd18.prod.outlook.com>
 <20231211112305.GD4870@unreal>
In-Reply-To: <20231211112305.GD4870@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3Jhc2hlZWRc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1iYjgxNWE3Mi05ODM0LTExZWUtODYzOS1jOGNi?=
 =?us-ascii?Q?OWVhOThmOWRcYW1lLXRlc3RcYmI4MTVhNzMtOTgzNC0xMWVlLTg2MzktYzhj?=
 =?us-ascii?Q?YjllYTk4ZjlkYm9keS50eHQiIHN6PSI1MzU0IiB0PSIxMzM0Njc3OTg3NTgx?=
 =?us-ascii?Q?MzkwMTYiIGg9IkZGMVRpMnlEeUJOUG5XZjYzN1F3eUtLOFg2bz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUJnV0FB?=
 =?us-ascii?Q?Q0lwTzU5UVN6YUFTVDBENS9LVDEvWEpQUVBuOHBQWDljWkFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUJ1RHdBQTNnOEFBRG9HQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRRUJBQUFBOVJlbkx3Q0FBUUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFa?=
 =?us-ascii?Q?QUJ5QUdVQWN3QnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01BZFFCekFIUUFid0J0QUY4QWNB?=
 =?us-ascii?Q?QmxBSElBY3dCdkFHNEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFHMEFYd0J3QUdnQWJ3QnVBR1VBYmdC?=
 =?us-ascii?Q?MUFHMEFZZ0JsQUhJQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJqQUhV?=
 =?us-ascii?Q?QWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QVpBQmhBSE1BYUFCZkFIWUFNQUF5?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?TUFkUUJ6QUhRQWJ3QnRBRjhBY3dCekFHNEFYd0JyQUdVQWVRQjNBRzhBY2dC?=
 =?us-ascii?Q?a0FITUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWXdCMUFITUFkQUJ2QUcw?=
 =?us-ascii?Q?QVh3QnpBSE1BYmdCZkFHNEFid0JrQUdVQWJBQnBBRzBBYVFCMEFHVUFjZ0Jm?=
 =?us-ascii?Q?QUhZQU1BQXlBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFB?=
 =?us-ascii?Q?QUFBSUFBQUFBQUo0QUFBQmpBSFVBY3dCMEFHOEFiUUJmQUhNQWN3QnVBRjhB?=
 =?us-ascii?Q?Y3dCd0FHRUFZd0JsQUY4QWRnQXdBRElBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FB?=
 =?us-ascii?Q?QUdRQWJBQndBRjhBY3dCckFIa0FjQUJsQUY4QVl3Qm9BR0VBZEFCZkFHMEFa?=
 =?us-ascii?Q?UUJ6QUhNQVlRQm5BR1VBWHdCMkFEQUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFaQUJzQUhBQVh3QnpB?=
 =?us-ascii?Q?R3dBWVFCakFHc0FYd0JqQUdnQVlRQjBBRjhBYlFCbEFITUFjd0JoQUdjQVpR?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCa0FHd0FjQUJm?=
 =?us-ascii?Q?QUhRQVpRQmhBRzBBY3dCZkFHOEFiZ0JsQUdRQWNnQnBBSFlBWlFCZkFHWUFh?=
 =?us-ascii?Q?UUJzQUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1VBYlFCaEFHa0FiQUJmQUdFQVpBQmtB?=
 =?us-ascii?Q?SElBWlFCekFITUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFG?=
 =?us-ascii?Q?OEFiZ0JoQUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFBYVFC?=
 =?us-ascii?Q?aEFHd0FYd0JoQUd3QWJ3QnVBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNn?=
 =?us-ascii?Q?QjJBR1VBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdCdUFHRUFiUUJsQUhN?=
 =?us-ascii?Q?QVh3QnlBR1VBY3dCMEFISUFhUUJqQUhRQVpRQmtBRjhBWVFCc0FHOEFiZ0Js?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZUUJ5QUhZQVpRQnNBRjhBY0FC?=
 =?us-ascii?Q?eUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUhJQVpRQnpBSFFB?=
 =?us-ascii?Q?Y2dCcEFHTUFkQUJsQUdRQVh3Qm9BR1VBZUFCakFHOEFaQUJsQUhNQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBR0VBY2dCdEFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refthree: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFB?=
 =?us-ascii?Q?SUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QVp3QnZBRzhBWndC?=
 =?us-ascii?Q?c0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUcw?=
 =?us-ascii?Q?QVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFZd0J2?=
 =?us-ascii?Q?QUdRQVpRQnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dB?=
 =?us-ascii?Q?YkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdCakFHOEFaQUJsQUhNQVh3QmtB?=
 =?us-ascii?Q?R2tBWXdCMEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFB?=
 =?us-ascii?Q?QUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBY0FCeUFHOEFh?=
 =?us-ascii?Q?Z0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUdNQWJ3QnVBR1lBYVFCa0FH?=
 =?us-ascii?Q?VUFiZ0IwQUdrQVlRQnNBRjhBYlFCaEFISUFkZ0JsQUd3QWJBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFB?=
 =?us-ascii?Q?RzBBWVFCeUFIWUFaUUJzQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4QWJn?=
 =?us-ascii?Q?QmhBRzBBWlFCekFGOEFZd0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFhUUJoQUd3?=
 =?us-ascii?Q?QVh3QnRBR0VBY2dCMkFHVUFiQUJzQUY4QWJ3QnlBRjhBWVFCeUFHMEFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNl?=
 =?us-ascii?Q?QUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29BWlFCakFIUUFY?=
 =?us-ascii?Q?d0J1QUdFQWJRQmxBSE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRBZEFCcEFH?=
 =?us-ascii?Q?RUFiQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3Qm5BRzhBYndC?=
 =?us-ascii?Q?bkFHd0FaUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJB?=
 =?us-ascii?Q?R1VBYkFCc0FGOEFjQUJ5QUc4QWFnQmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3?=
 =?us-ascii?Q?QmZBSElBWlFCekFIUUFjZ0JwQUdNQWRBQmxBR1FBWHdCdEFHRUFjZ0IyQUdV?=
 =?us-ascii?Q?QWJBQnNBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FI?=
 =?us-ascii?Q?SUFid0JxQUdVQVl3QjBBRjhBYmdCaEFHMEFaUUJ6QUY4QWNnQmxBSE1BZEFC?=
 =?us-ascii?Q?eUFHa0FZd0IwQUdVQVpBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZBSElB?=
 =?us-ascii?Q?WHdCaEFISUFiUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
 =?us-ascii?Q?Q2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSFFBWlFCeUFHMEFhUUJ1QUhV?=
 =?us-ascii?Q?QWN3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dC?=
 =?us-ascii?Q?MkFHVUFiQUJzQUY4QWR3QnZBSElBWkFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFPZ1lBQUFBQUFBQUlBQUFBQUFBQUFBZ0FBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFBQUFBYUJnQUFHUUFBQUJn?=
x-dg-rorf: true
x-dg-reffive: =?us-ascii?Q?QUFBQUFBQUFBWVFCa0FHUUFjZ0JsQUhNQWN3QUFBQ1FBQUFBQUFBQUFZd0Ix?=
 =?us-ascii?Q?QUhNQWRBQnZBRzBBWHdCd0FHVUFjZ0J6QUc4QWJnQUFBQzRBQUFBQUFBQUFZ?=
 =?us-ascii?Q?d0IxQUhNQWRBQnZBRzBBWHdCd0FHZ0Fid0J1QUdVQWJnQjFBRzBBWWdCbEFI?=
 =?us-ascii?Q?SUFBQUF3QUFBQUFBQUFBR01BZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdC?=
 =?us-ascii?Q?a0FHRUFjd0JvQUY4QWRnQXdBRElBQUFBd0FBQUFBQUFBQUdNQWRRQnpBSFFB?=
 =?us-ascii?Q?YndCdEFGOEFjd0J6QUc0QVh3QnJBR1VBZVFCM0FHOEFjZ0JrQUhNQUFBQStB?=
 =?us-ascii?Q?QUFBQUFBQUFHTUFkUUJ6QUhRQWJ3QnRBRjhBY3dCekFHNEFYd0J1QUc4QVpB?=
 =?us-ascii?Q?QmxBR3dBYVFCdEFHa0FkQUJsQUhJQVh3QjJBREFBTWdBQUFESUFBQUFBQUFB?=
 =?us-ascii?Q?QVl3QjFBSE1BZEFCdkFHMEFYd0J6QUhNQWJnQmZBSE1BY0FCaEFHTUFaUUJm?=
 =?us-ascii?Q?QUhZQU1BQXlBQUFBUGdBQUFBQUFBQUJrQUd3QWNBQmZBSE1BYXdCNUFIQUFa?=
 =?us-ascii?Q?UUJmQUdNQWFBQmhBSFFBWHdCdEFHVUFjd0J6QUdFQVp3QmxBRjhBZGdBd0FE?=
 =?us-ascii?Q?SUFBQUEyQUFBQUFBQUFBR1FBYkFCd0FGOEFjd0JzQUdFQVl3QnJBRjhBWXdC?=
 =?us-ascii?Q?b0FHRUFkQUJmQUcwQVpRQnpBSE1BWVFCbkFHVUFBQUE0QUFBQUFBQUFBR1FB?=
 =?us-ascii?Q?YkFCd0FGOEFkQUJsQUdFQWJRQnpBRjhBYndCdUFHVUFaQUJ5QUdrQWRnQmxB?=
 =?us-ascii?Q?RjhBWmdCcEFHd0FaUUFBQUNRQUFBQUFBQUFBWlFCdEFHRUFhUUJzQUY4QVlR?=
 =?us-ascii?Q?QmtBR1FBY2dCbEFITUFjd0FBQUZnQUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3?=
 =?us-ascii?Q?QVh3QndBSElBYndCcUFHVUFZd0IwQUY4QWJnQmhBRzBBWlFCekFGOEFZd0J2?=
 =?us-ascii?Q?QUc0QVpnQnBBR1FBWlFCdUFIUUFhUUJoQUd3QVh3QmhBR3dBYndCdUFHVUFB?=
 =?us-ascii?Q?QUJVQUFBQUFBQUFBRzBBWVFCeUFIWUFaUUJzQUY4QWNBQnlBRzhBYWdCbEFH?=
 =?us-ascii?Q?TUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFISUFaUUJ6QUhRQWNnQnBBR01BZEFC?=
 =?us-ascii?Q?bEFHUUFYd0JoQUd3QWJ3QnVBR1VBQUFCYUFBQUFBQUFBQUcwQVlRQnlBSFlB?=
 =?us-ascii?Q?WlFCc0FGOEFjQUJ5QUc4QWFnQmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZB?=
 =?us-ascii?Q?SElBWlFCekFIUUFjZ0JwQUdNQWRBQmxBR1FBWHdCb0FHVUFlQUJqQUc4QVpB?=
 =?us-ascii?Q?QmxBSE1BQUFBZ0FBQUFBQUFBQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0JoQUhJ?=
 =?us-ascii?Q?QWJRQUFBQ1lBQUFBQUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFHY0Fid0J2?=
 =?us-ascii?Q?QUdjQWJBQmxBQUFBTkFBQUFBQUFBQUJ0QUdF?=
x-dg-refsix: =?us-ascii?Q?QWNnQjJBR1VBYkFCc0FGOEFjQUJ5QUc4QWFnQmxBR01BZEFCZkFHTUFid0Jr?=
 =?us-ascii?Q?QUdVQWN3QUFBRDRBQUFBQUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFj?=
 =?us-ascii?Q?Z0J2QUdvQVpRQmpBSFFBWHdCakFHOEFaQUJsQUhNQVh3QmtBR2tBWXdCMEFB?=
 =?us-ascii?Q?QUFYZ0FBQUFBQUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhBYWdC?=
 =?us-ascii?Q?bEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFRQmtBR1VB?=
 =?us-ascii?Q?YmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFBQUd3QUFBQUFB?=
 =?us-ascii?Q?QUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3?=
 =?us-ascii?Q?QnVBR0VBYlFCbEFITUFYd0JqQUc4QWJnQm1BR2tBWkFCbEFHNEFkQUJwQUdF?=
 =?us-ascii?Q?QWJBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZBSElBWHdCaEFISUFiUUFB?=
 =?us-ascii?Q?QUhJQUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dCdkFHb0Fa?=
 =?us-ascii?Q?UUJqQUhRQVh3QnVBR0VBYlFCbEFITUFYd0JqQUc4QWJnQm1BR2tBWkFCbEFH?=
 =?us-ascii?Q?NEFkQUJwQUdFQWJBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZBSElBWHdC?=
 =?us-ascii?Q?bkFHOEFid0JuQUd3QVpRQUFBRm9BQUFBQUFBQUFiUUJoQUhJQWRnQmxBR3dB?=
 =?us-ascii?Q?YkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdCdUFHRUFiUUJsQUhNQVh3QnlB?=
 =?us-ascii?Q?R1VBY3dCMEFISUFhUUJqQUhRQVpRQmtBRjhBYlFCaEFISUFkZ0JsQUd3QWJB?=
 =?us-ascii?Q?QUFBR2dBQUFBQUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdv?=
 =?us-ascii?Q?QVpRQmpBSFFBWHdCdUFHRUFiUUJsQUhNQVh3QnlBR1VBY3dCMEFISUFhUUJq?=
 =?us-ascii?Q?QUhRQVpRQmtBRjhBYlFCaEFISUFkZ0JsQUd3QWJBQmZBRzhBY2dCZkFHRUFj?=
 =?us-ascii?Q?Z0J0QUFBQUtnQUFBQUFBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBZEFCbEFI?=
 =?us-ascii?Q?SUFiUUJwQUc0QWRRQnpBQUFBSWdBQUFBQUFBQUJ0QUdFQWNnQjJBR1VBYkFC?=
 =?us-ascii?Q?c0FGOEFkd0J2QUhJQVpBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|CH0PR18MB4257:EE_
x-ms-office365-filtering-correlation-id: 00f7646f-f710-4db6-afb7-08dbfa58a2c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7r3vrw13vupuxBhLehrNdk9Zxqq8gsnwe/xbqHLnEU0pxWT8jqW3cz2k/J9O21AVRcyuaYRFbd3ZNuFt2WN+wTp1Jp5794acEkg8gaL24RYbEJVt1Ge1DY1FPVZ1qtscunI/IthM+j21V0tq/0AHyfuEQtc2cyevPVn+/45AjyC8ZN9EluYsPzUuEEM/BHBxtUlA8ikIj31yUM8VbvMmtG7e7rumonW4t8w8YKlAU1s4ecEG8JcbHIK9mFDq264C+XvxehYpiGYfhTh2G8bn9zMsU4duW5n5sC67X0FhyzrZs6+qPqt1BOYwAX33OINHKPM06DW7Umwcz4++xvCcn6345JVdT1XkwMRUZmDfmQ5v6fcrlu5k9dx0DB+d1JiQzhoUj3qZZLUZAikjRl1o+vByAiRwRZE4jnUUULSXQ8Ke9c7JnutPcJN/EdyDaYcyr3LqFIq7OpSs0fhZ13pksNK8clgxIIUDvWV3HgMER5Az03QexkV+hUt/VrLARsNMOFWjh7heb3bHl97tEAhQ0kG/ORsIuq6F6PHwhFwehJ0SS9Iy4bkh+hIJtwAt2jse0uQrF7wLCDcLRIJI5CycqVMMEkORfOFTfOwMRUAg6bIs+bdglX38NdPKX41p58C2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(2906002)(478600001)(41300700001)(55016003)(38070700009)(6916009)(66556008)(66476007)(66446008)(54906003)(76116006)(64756008)(66946007)(7416002)(15650500001)(122000001)(71200400001)(316002)(38100700002)(86362001)(7696005)(8936002)(8676002)(4326008)(6506007)(9686003)(52536014)(33656002)(5660300002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8vcB4lw74FQdscLwY3lHZlqoh34U9LCz4XOLoxeqBcF0lqEijp7on6BmQ8uf?=
 =?us-ascii?Q?kBlViQva+HJSfFmsxfLj203A0xmvPkyrS3V8gVqiZJ5PEjkz7ngb0hlZURSq?=
 =?us-ascii?Q?zFzrKUYl0e2j5L/U9p4yvsuoa3jZtJFkSWk4zPoTfE3FWwj5+RenaFMS+fzQ?=
 =?us-ascii?Q?uB5coUWbvwlngoC4O3rTaAVvTsZ2OC7e692aDp9eMMgl6KGN6V6GGdHCAmqi?=
 =?us-ascii?Q?nNLzFhQ3fnb88kDT6O4Xm7evdYvsi9Qlfr0Ihb2iaF3j3EAZiRB8bcHq7+to?=
 =?us-ascii?Q?strLLCrnp6t+Yo9+zBKkjbh38MRQNDqWNyrHyeBA6cMS5l6KRyZOcH7olDTn?=
 =?us-ascii?Q?abwagyYFOtqZL5DtwoAOrvHkeZMTLtnhyjO5SB1U+hbaaDU9Li0PVT9xPBz/?=
 =?us-ascii?Q?D40IyKjTAFMcQzN9poCJduWTz6KEIehnvAL2KE192YvpKI3pU8oUqgVnd67j?=
 =?us-ascii?Q?oRZNOR5L3stk1dsCQbQIVesTw/uAs3dNoXpBXdkEVuqYuniIMFYEFu6Me7NY?=
 =?us-ascii?Q?7zZi/hKbWD2rVnxmqLMpyTEuOGxglqhoT8QxkpmoYNdoRohEKTjhARh8H55E?=
 =?us-ascii?Q?CXOYVdkGwwbFsj2OmmwNUjVOY9MOy/TWOEOOCEYxzWXGld81k8EpRh24nsid?=
 =?us-ascii?Q?XaIBV5iPImDDn8qQWxG5wAirGh1XpWLJwvmgiuH7bEuU9vN9W5g1Jy8JsFL5?=
 =?us-ascii?Q?N89+HvuSlx3mFELmxpPab2zrbtlsuGO3xD11mxYSuNqjKjXXxaNdvp4JnTgi?=
 =?us-ascii?Q?vK878SXIVPqhTZnay1olWrCBJGiL1muDd3+SBWp4p0Ueqg9yUdSNMVVIDT9T?=
 =?us-ascii?Q?wbcc8+TGjDRJhhI56bc9Eza4ae3YLTYvlrmkpy4Bbc09jH7re9B3Ha7M7SHX?=
 =?us-ascii?Q?/pCsf2QNllodnzAuEyxD+CYtuW+abejJHuAAuf7UICjTEztKJDa6YyxfNfpF?=
 =?us-ascii?Q?xVFd773Ozyps2okR6l55nVPk6e59kiW7CIwdpT4DXHE2lo0EzraTVM6qUEqi?=
 =?us-ascii?Q?fytkXFtAQ1IQUsBYOROPaVOqB5zaVm+UUKGiAzPlv3Fa1NkEIBw6g+1UV1oF?=
 =?us-ascii?Q?lF/XV2aEcx/cXdYeGuU2Uxnv+7dBOFz5s0KiMqvJC8bqrzUUM6+vtmSLTX+0?=
 =?us-ascii?Q?z5UJoMAI7Mh6Qj1JfByheGQMHe76ntlWhaXLxFUJJSYTwxr8vHT6NRvXLi1H?=
 =?us-ascii?Q?hhQhSb1Z07RMB3SNZqcP/WvTiYd7M5KTcOpTIFNP/9GPTPZAhW9u+rtTzgAn?=
 =?us-ascii?Q?BI+H5ymoOddRp38FS6G2x7I65sv7DL75zbkrw0YKFJMHxFN3VSja4fqBsavZ?=
 =?us-ascii?Q?vVCVj+41hOfACQK5r6QATAuGaqYpGphFgo/JRK/DFoX7sGHo6/kS1W57sdvG?=
 =?us-ascii?Q?ienWsPW1VGi/GnLSXz1Mzzxrw+/Tw/sTdwUCQtMYkjz9AJpRZBi8c79K7HSI?=
 =?us-ascii?Q?4Babu1HoES+n0Br9DNb2yjqRKLMuX3s0KNcdWxRUpqadpqwaW2BjGCTyZTAt?=
 =?us-ascii?Q?P6RewUY8gzCYDJJZmiBazbS5IMxvVfuOClY2C1xcSSvvpRKap2MpOwxDaPWb?=
 =?us-ascii?Q?uqddlC9NJ5qU03mJnhruRlwHxsRHw4bVdLopAW9I?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4734.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f7646f-f710-4db6-afb7-08dbfa58a2c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 14:51:19.7730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KnuEsQjPaLlGD0ylFaM3eRdUE5+ZHR7FaDGQkHSHchq7zWCUraHE+uhTdmfX3+bG4Yurn/bSS7OXTweCtv/fsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4257
X-Proofpoint-GUID: uBsjNSyrxVhbyzH0g4DRxQlQ2d5tC4EH
X-Proofpoint-ORIG-GUID: uBsjNSyrxVhbyzH0g4DRxQlQ2d5tC4EH
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

> > > This architecture design is unlikely to work in the real world unless
> > > you control both PF and VF environment. Mostly PF is running some old
> > > legacy distribution while VFs run more modern OS and this check will
> > > prevent to run new driver in VF.
> > >
> > > Thanks
> >
> > Thanks for the review. This version validation only concerns regarding =
the
> >control net API layer (which is used to communicate with
> > the firmware). In the case you have described, this instead enables new=
 VF
> >drivers to atleast work atop legacy PF drivers (note legacy here still
> > refers to PF drivers which support this backward compatibility), althou=
gh
> >they might not be able to use the latest control net functionalities tha=
t they
> > have been enabled for.
>=20
> The question what will be in X years from now, when you will have v100?
> Will you fallback to v0 for backward compatibility?
>=20
> >
> > In the absence of such a backward compatibility, VF drivers would issue
> >control net requests which PF drivers wouldn't know, only leading to log=
s of
> > incompatibility errors and erroneous usage.
> >
> > Also again please note that this version compatibility only concerns th=
e
> > control net infrastructure and API (the control plane).
>=20
> It doesn't matter, even in best scenario, you can't guarantee that code i=
n VM
> actually
> implements version Y fully and will need to check correctness per-command
> anyway.
>=20
> Thanks

I'm afraid as to what else can be an alternative? The control net commands =
have to be decoded and passed by the PF driver for the VFs,
as only the PFs have access to talk to firmware directly. The VF drivers do=
 not have an alternative way to query control net APIs, and may fail=20
if the control net APIs they have are not even recognized by the PF to deco=
de them.

Either VF commands which the PF can't support can be blocked at the source =
(by the equivalent PF-VF backward compatibility which will exist in VF driv=
ers)
by this negotiation, or we have to let commands come through and fail them,=
 leading to just redundancy in terms of running code. I don't see how this =
negotiation in
any way 'limit' the VF drivers.

As you said, in essence the VF drivers will have to fallback to v0 for back=
ward compatibility if the native host uses some old OS having older PF driv=
ers. If not, the=20
commands would come and fail anyways at the PF. Either way, it's an error c=
ase and this negotiation is just to decide if we are going to allow letting=
 such commands in.

Thanks for your time
