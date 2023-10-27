Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C177D9689
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345734AbjJ0LZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0LZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:25:36 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F74FAB;
        Fri, 27 Oct 2023 04:25:34 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R5TxAW012574;
        Fri, 27 Oct 2023 04:25:20 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3tywr834vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 04:25:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E92bIA7NlJu9XSbvSjyzQlEyYG7khIKgJ/6i2lt7aKPqeT2kDnBgMKmnu7yjTPIgOpQJfSsRhziun0YUzcliRc27Ls4pu4805+xQ4mDiHoQlJrq5YizLPylUwRHOtty5rCw7vQQTAoKgNIEDyEuPNdvG7BFdyA42tKDBeeghtY8NV+E8vTyU820Il0vP9jC+Kg1S0JbfCbbIIfjZlrUTHZMrclH9rk8s7JdEoIls7/yKeDdv0QSMVV9p6VCAg8avV2l2XXgWbdt8suCq0DMFiuIkk8zgKqwBUFDNzkvN+A5vTilANLXPX3IIyPskCYvaytnaYOPjLL3vTxVuVXRI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isI5UJUypfP63v82GSjgfn45a59wiNP/AqlDsxoyY2Y=;
 b=cNGzyaQv9JQD+XCeIOZK+nd8tIsfxB1NXe52+pMEhf8Q1J0J1EA9GzqAPO2Pf/NsdQwcX/ORN3bAtpVoVkJ/m6p2q+YSXMRZB1HD/94Kta+Xlf6udhaeYijSXgIQvatNrjnTIIoKN7LiKb8cYJCOoJHngxZdBmqjVQO7m10jdYoIbm633cCvG51Nar3/B6vnijmbQLrotYIXMTD+kw6QpfyPCrlPO05NNhATEZxkPlrOm8B3VdLSqBmspXcr1ewODP/wVYMa5y/+bAGQlpCU/UZu2UsXS6fzDYQtxPgUKSET1bRL3N/6x1jgbCMHg7/B2XsPmDRFjouQ+e6PRxdtqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isI5UJUypfP63v82GSjgfn45a59wiNP/AqlDsxoyY2Y=;
 b=L8vuYk0yKjBDWNQenMuq+DqVXZ/t0YHVSriTsokOQFBKromW816L2plTDqWablAnoa2p7FQzgfG5XpT/6qZ9vvhMHIsLv4ysSG3W5WDPh2QGvyNzkzXVdS00u2L3+gghPuiLHrX27HcNSQAu+ot2bwN7r64L43paScXu69Uj134=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by SN7PR18MB5364.namprd18.prod.outlook.com (2603:10b6:806:2ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Fri, 27 Oct
 2023 11:25:17 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::7c0a:5ded:25e9:7fa2]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::7c0a:5ded:25e9:7fa2%6]) with mapi id 15.20.6907.028; Fri, 27 Oct 2023
 11:25:17 +0000
From:   Shinas Rasheed <srasheed@marvell.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani <hgani@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh B Edara <sedara@marvell.com>
Subject: RE: [EXT] Re: [PATCH net-next v2 3/4] octeon_ep: implement xmit_more
 in transmit
Thread-Topic: [EXT] Re: [PATCH net-next v2 3/4] octeon_ep: implement xmit_more
 in transmit
Thread-Index: AQHaBomdyCzd/AB+BUOLdgCH/VlJFbBZpWyAgAIItnKAAHrBAIABV/rw
Date:   Fri, 27 Oct 2023 11:25:16 +0000
Message-ID: <PH0PR18MB47347AFC5F056058BB8D7B3CC7DCA@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20231024145119.2366588-1-srasheed@marvell.com>
        <20231024145119.2366588-4-srasheed@marvell.com>
        <20231024172151.5fd1b29a@kernel.org>
        <PH0PR18MB473482180622D7C163B487ADC7DDA@PH0PR18MB4734.namprd18.prod.outlook.com>
 <20231026074454.767a8a2f@kernel.org>
In-Reply-To: <20231026074454.767a8a2f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3Jhc2hlZWRc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy03ZTVkOTQ0Ny03NGJiLTExZWUtODYzMS1jOGNi?=
 =?us-ascii?Q?OWVhOThmOWRcYW1lLXRlc3RcN2U1ZDk0NDgtNzRiYi0xMWVlLTg2MzEtYzhj?=
 =?us-ascii?Q?YjllYTk4ZjlkYm9keS50eHQiIHN6PSI2OTQ2IiB0PSIxMzM0Mjg3OTUxMzU1?=
 =?us-ascii?Q?MzU0MzIiIGg9ImZQQXZTMXFCcWJoTThaa3FHRlRkV3NGdm5jaz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUJnV0FB?=
 =?us-ascii?Q?QklxZHhBeUFqYUFjNnBGT1JKUms5M3pxa1U1RWxHVDNjWkFBQUFBQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUlBQUFBQUFBQUFBQUFBQUFF?=
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
 =?us-ascii?Q?RjhBWmdCcEFHd0FaUUFBQUNRQUFBQWdBQUFBWlFCdEFHRUFhUUJzQUY4QVlR?=
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
 =?us-ascii?Q?SUFiUUJwQUc0QWRRQnpBQUFBSWdBQUFBSUFBQUJ0QUdFQWNnQjJBR1VBYkFC?=
 =?us-ascii?Q?c0FGOEFkd0J2QUhJQVpBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|SN7PR18MB5364:EE_
x-ms-office365-filtering-correlation-id: 31498fbd-841f-4083-02b0-08dbd6df6539
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ++8JOCOxz/Z3jjTyeZmgHrtZWYhuMowyt+0bHbXZiUNnOFTP085B44sX5VCs/4HC6aK4+OQYWNT243hb2Nfu3BGUJYLVaO7R6ocK7A7qsiWVX0cRGbntER7oJIy/jTNOcX60Sukx7138YALQ5fRybLzJK4Dt5bT01P7tQObGbTb0uRMUPo43+8eZEY2z9VVa0UZT/G8t6mg5qHn9mBS422bi8+0+aivTxIZPERY2xbl9aFQpSW41UFWlHe1Q9X8VeAfYIrW5qw7USAZDwi9sia00a8G+KsKA7kVS4CmjoXpX5wdUfih8terIM86aPymuPKMr0wHU9RMZBrgaZomxof6AqZskC0jhxuI+odF9fc9SJGB7Olv00b2vQkJU05xO+kHhx6vI5bRtCLyENPpW4lUvzNCwQ8XZ7h6d2uIhYxDiJmQEMs3yihnWMpfuBFHbQ4VvFK+BFZCo+n+ICS+3ACoExdTp3BsSsO+CtmC+NzzX9Sfkn5X6WLcdTUevj2GI4fe/S7U3DG2EYkmzafFRQWkmf5u9XVNXnJ3tje6lqEt/SENxR3MG0l1ZXqnbZWc5MNRZK3wyMmXL+X1B3vMhhW4g/IycTn4M/brnPncq5Pk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(52536014)(76116006)(64756008)(2906002)(86362001)(66476007)(478600001)(122000001)(316002)(38100700002)(54906003)(66946007)(71200400001)(107886003)(6506007)(66446008)(9686003)(966005)(53546011)(83380400001)(55016003)(4326008)(110136005)(8676002)(5660300002)(41300700001)(33656002)(7696005)(19627235002)(66556008)(8936002)(7416002)(38070700009)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8G8NcRQ2MwK18fBDoV1D6w/BFWdBgnlBiXm28iKvNI6dJ8St9WAUHj/mdCcq?=
 =?us-ascii?Q?rwD8Aq9FPiMRFwiOWIC0P3J6WkBua30w8CKDjpUQ/TkHFooNCJpQznXRGIbg?=
 =?us-ascii?Q?DWVdHTQfNMLbxuC+VXD/CcMgSGbiolHGsFLlhbnq0jN2VNEEYhYdkThSAvPS?=
 =?us-ascii?Q?Yuqh5WTSU9Pz8qRnMNA/FvzNIP0PJw38dN/bbEG8anx1TAJemGGtaXm2lIUx?=
 =?us-ascii?Q?JIDiBojRcVHR5AkMGONKH6OVqL/uU20y6KvWmwFoxXvokxKD0kBcv7PhL23q?=
 =?us-ascii?Q?rnJDE421fBniR7cjHgIj8rqoFLYI1TiX1703gxVpLWflOxcyuHdfSY6RzJ1N?=
 =?us-ascii?Q?Zi11H8UwC+MfdtseGOUT4mUXykHMZgOqCSPmBc9pFseG6gHdboIZGTqfhvtY?=
 =?us-ascii?Q?A8DIZkc4Z/yWw0Du3twfi+m7On5XUjyAFrVoioxA5fYwEZFmgRPMWTyAZv2t?=
 =?us-ascii?Q?bqrPJn1aCJfzYuoj24F7OlIl4e1HZRAb8/TLScnJbg97TwU6jWwHTtX/fKTi?=
 =?us-ascii?Q?GXqYUYlJcoOGYgg1gW3Gc6KTvAstj4by8UKfs49VGCTuAdCAQBYGO629ft6E?=
 =?us-ascii?Q?bktm3rUml8VmGhfS7+rlkh4PH55mB7YtI88zQ6038kJb6l1oKHGelMRx/TS6?=
 =?us-ascii?Q?Abemc1UHg0mJABNuNrmBBIOmKshiy7IT1rV+KwKFRIVRiE7bM0UrGiJxN0gZ?=
 =?us-ascii?Q?H1QpGQYZAEwS79XAkVVWsXNGUM9nxqLbUXcpVdP0dCh0ARBEQA+ikTdIO1cY?=
 =?us-ascii?Q?lkbzELJj23/ABDZMRUakQyPW4YXExErOPjPvu9XeG2rIpchmErSRwGNj/4I6?=
 =?us-ascii?Q?SI9qs2TomuevCs3jtc9L7PUJuS/+bCQRVMyMviQbsT8fcJplPYMxNEXjmRuT?=
 =?us-ascii?Q?qn7ToeTQ5h3ygTVLDIh76RtY1kvmMDKiC23LB4Wf3QCO8/SuNQqG86Cgd+GB?=
 =?us-ascii?Q?2D6bTvNVbx9jD0ObHq35jvKbMCwdJNHBf/dPRNm5U0spSCotBKVbKHlvewSZ?=
 =?us-ascii?Q?vy7GxxFhgYxoV31b9d0pi3bUPZZFB7Uz3Cyb2DblMYhORaLm2mpZ+hwizD9b?=
 =?us-ascii?Q?9+AMEAHQnLyYURoZq0YzTIGxxVIVuFnxyLk0Tlxx3Z2ZIIvmA+gUkVOChXj/?=
 =?us-ascii?Q?Z9h2LJk1PqDCxG1Qx0oEwmk7r2GazJfShHGLWux7y4npmcy1aizt2+97/rYB?=
 =?us-ascii?Q?6j6j4Yj30ngjxyZSjDYVua2l/Kde5wkSxOGhYKnceJtuseJi/Gk2coiAZeM/?=
 =?us-ascii?Q?I0ClIltleJao+qHsngjacTkSLklhDncM5zynWLHINPF4uFAAxo5l2nyfqjS5?=
 =?us-ascii?Q?OgRKQNidUBw0pXIYYTEj24r8XTSEsFU/WvHXnnuqWOeF+N1L6Ip/IlI0upHx?=
 =?us-ascii?Q?CF15tN32T7foxj/xIbZZoR1UoykB+HJFwJJTdIh43nFw61PUyvLOofQp+GwE?=
 =?us-ascii?Q?EnUqXjvljro9zllqMU5y/nD/zedSdJY3174++sDN8DciNnKRhqRUr+pybxHV?=
 =?us-ascii?Q?RNezD/Me2qEC5ylJobapxk8wzQRYWnFyIqlphr8yEWSBDJ1RTNpXG6eIZW68?=
 =?us-ascii?Q?lnQfLac93neeTdOjxxIlbw4xHBKOtf9Tq29sSpxE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4734.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31498fbd-841f-4083-02b0-08dbd6df6539
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 11:25:16.6987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bf7ybu1PrCLPD4kfnGWPFCGnKGQjdBgg5vRNNkLuzFGe3m86n14ZckQrD+F1a6wajOIohwG/MnSs/Oy1THrlBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB5364
X-Proofpoint-GUID: oSXXVXzti-MCNLNqBjKhCem4vr6Q8i5S
X-Proofpoint-ORIG-GUID: oSXXVXzti-MCNLNqBjKhCem4vr6Q8i5S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_09,2023-10-27_01,2023-05-22_02
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, October 26, 2023 8:15 PM
> To: Shinas Rasheed <srasheed@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Haseeb Gani
> <hgani@marvell.com>; Vimlesh Kumar <vimleshk@marvell.com>;
> egallen@redhat.com; mschmidt@redhat.com; pabeni@redhat.com;
> horms@kernel.org; davem@davemloft.net; wizhao@redhat.com;
> konguyen@redhat.com; Veerasenareddy Burru <vburru@marvell.com>;
> Sathesh B Edara <sedara@marvell.com>; Eric Dumazet
> <edumazet@google.com>
> Subject: Re: [EXT] Re: [PATCH net-next v2 3/4] octeon_ep: implement
> xmit_more in transmit
>=20
> On Thu, 26 Oct 2023 07:57:54 +0000 Shinas Rasheed wrote:
> > >The recommended way of implementing 'driver flow control'
> > is to stop the queue once next packet may not fit, and then use
> > netif_xmit_stopped() when deciding whether we need to flush or we can
> > trust xmit_more. see
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__www.kernel.org_doc_html_next_networking_driver.html-23transmit-
> 2Dpath-2Dguidelines&d=3DDwICAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D1OxLD4y-
> oxrlgQ1rjXgWtmLz1pnaDjD96sDq-
> cKUwK4&m=3DFyJHTb5Z2u9DTFSYPU38S5kPcP5KvwGWzY-
> DPcqOl1gdnm7ToZhTFpyvhLMqh1hd&s=3DdBMmwfWKAi0UH3nrz7j9kYnAodDj
> uN3LZ5tC2aL_Prs&e=3D
> >
> > >> In the skeleton code above, as I understand each tx desc holds a skb=
 frag
> and hence there can be possibility of receiving a full-sized skb, stoppin=
g the
> queue but on receiving another normal skb we should observe our queue to
> be stopped. This doesn't arise in our case as even if the skb is full-siz=
ed, it will
> only use a single tx descriptor so we can be sure if queue has been stopp=
ed,
> the write index will only be updated once posted (and read) tx descriptor=
s
> are processed in napi context and queues awoken.
> >
> > Please correct me if I'm wrong anywhere (sorry if so) to further my
> understanding, and again thanks for your time!
>=20
> Could you please do some training on how to use normal / mailing list
> style email at Marvell? Multiple people from Marvell can't quote
> replies correctly, it makes it hard to have a conversation and help
> y'all.
Hi Jacub, apologizing for format errors on my part, will try to rectify in =
coming mails. Sorry again.


> -----Original Message-----
> From: Eric Dumazet <edumazet@google.com>
> Sent: Thursday, October 26, 2023 1:59 PM
> To: Shinas Rasheed <srasheed@marvell.com>
> Cc: Jakub Kicinski <kuba@kernel.org>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Haseeb Gani <hgani@marvell.com>; Vimlesh Kumar
> <vimleshk@marvell.com>; egallen@redhat.com; mschmidt@redhat.com;
> pabeni@redhat.com; horms@kernel.org; davem@davemloft.net;
> wizhao@redhat.com; konguyen@redhat.com; Veerasenareddy Burru
> <vburru@marvell.com>; Sathesh B Edara <sedara@marvell.com>
> Subject: Re: [EXT] Re: [PATCH net-next v2 3/4] octeon_ep: implement
> xmit_more in transmit
>=20
> Fact that octep_start_xmit() can return NETDEV_TX_BUSY is very suspicious=
.
>=20
> I do not think a driver can implement xmit_more and keep
> NETDEV_TX_BUSY at the same time.
>=20
> Please make sure to remove NETDEV_TX_BUSY first, by stopping the queue
> earlier.

Hi Eric, I think I understand your point and shall submit an updated patch.=
 Thanks your time!

