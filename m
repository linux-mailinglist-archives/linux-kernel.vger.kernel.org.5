Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09174802B44
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 06:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjLDFW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 00:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDFW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 00:22:56 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F37BE6;
        Sun,  3 Dec 2023 21:23:02 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B41Oplx006363;
        Sun, 3 Dec 2023 21:22:56 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ur2tvbrqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Dec 2023 21:22:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4iRnazzLf25nIzuUQomFykcNiN5P5oLdCJa5H7Q8+9MsqLUc9Q9Qhfspc7YwCpdEzB77fQxjJm61V1HUg7zb3KkYOA0y6/xlEqyahdYw/VpaY0zkHyrPUGTEu6s31+Ce2DSLN0qMLZ0a7k7cwK1+OpNS570EiP1u4sbhqR0sW02o049oah5v7cofg2l15aQKKyeHjLO7B3fqKxiP1OHcI5NWhs+LGl+B1SJuq9nPkOnsVNqj/PVfX6WCx/j4goRpTTYFd+1e7PDK4kTksl1MDmMMWzqgQGByj2i7P6S32Za888cgO+Czg3HLJ1cZIGsHY7JUJHzksC4zvR3Vzk+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQ0qfdE+ODbHKeAXmx/mK8W9yTnEd9KyJ+6H7mcYZQU=;
 b=AJgSKxRYd9kqk62urZqG2KYyaFOUrAUjRby3n9g52G+1/6UahTuEXOxUiNW9lmhwo+Ji16WSX0BvAqTigAiQN/g+OVGOaJKL1887jiEkTMBIxM2Jru84hMSTYeg5hZC9en9cYPp+FhPBZshP5IA80wT8UKvZKVR+EkdXnkaTNNg7KGQq+kOPLzfgjYLh1MPh26Q5WqLjmtW2cIsPYh1UFxOANxhA9w0bDai8VOS/uiPOXTubX+01DDeSLNTdlMLa6F8JApaoAxc0pp7NM6zIxfAKW+6lpJGhE12ZvG84/eQkUwUyTFLV3ON6xSVNxZaSMHce24bfnKEirgPwuRYKyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQ0qfdE+ODbHKeAXmx/mK8W9yTnEd9KyJ+6H7mcYZQU=;
 b=nzanWumt4d3sLOHKkF5zwd6DK6HhWKIfeVAersBOBKOIu3Df12Gc9WlS3Loapw+Ffkmr6nEsmrAbSi+jSWem85WDSTruiA/4eqCYNA8Q1FgdKXc69+6q0R6vW+nrgrQBGIcuY/KdvERER53+lXIzfYztyQn0U06qF5VwCsCipR4=
Received: from DM6PR18MB2602.namprd18.prod.outlook.com (2603:10b6:5:15d::25)
 by DM4PR18MB4302.namprd18.prod.outlook.com (2603:10b6:5:399::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 05:22:53 +0000
Received: from DM6PR18MB2602.namprd18.prod.outlook.com
 ([fe80::a747:7509:8395:4f74]) by DM6PR18MB2602.namprd18.prod.outlook.com
 ([fe80::a747:7509:8395:4f74%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 05:22:53 +0000
From:   Geethasowjanya Akula <gakula@marvell.com>
To:     Simon Horman <horms@kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Jerin Jacob Kollanukkaran <jerinj@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXT] Re: [net v3 PATCH 3/5] octeontx2-af: Fix mcs stats register
 address
Thread-Topic: [EXT] Re: [net v3 PATCH 3/5] octeontx2-af: Fix mcs stats
 register address
Thread-Index: AQHaI2MJo8oLnqMHDUCszsbF1cpkorCXzccAgADOWXA=
Date:   Mon, 4 Dec 2023 05:22:53 +0000
Message-ID: <DM6PR18MB260210685BDED4A713503D9ECD86A@DM6PR18MB2602.namprd18.prod.outlook.com>
References: <20231130075818.18401-1-gakula@marvell.com>
 <20231130075818.18401-4-gakula@marvell.com>
 <20231203170054.GL50400@kernel.org>
In-Reply-To: <20231203170054.GL50400@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ2FrdWxhXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctMmEyODRhMmItOTI2NS0xMWVlLTk2YWEtNDhhNDcy?=
 =?us-ascii?Q?MGFkNGE3XGFtZS10ZXN0XDJhMjg0YTJkLTkyNjUtMTFlZS05NmFhLTQ4YTQ3?=
 =?us-ascii?Q?MjBhZDRhN2JvZHkudHh0IiBzej0iMTEyMTgiIHQ9IjEzMzQ2MTQwOTcwMjEz?=
 =?us-ascii?Q?NTA5NiIgaD0iYjBJUXlSKzVWT1ludlFmUEVkdHZNU1NNdHh3PSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQmdXQUFB?=
 =?us-ascii?Q?NHhZVHNjU2JhQVhPdE5lak5kZm1NYzYwMTZNMTErWXdaQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQnVEd0FBM2c4QUFEb0dBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFFQkFBQUE5UmVuTHdDQUFRQUFBQUFBQUFBQUFKNEFBQUJoQUdRQVpB?=
 =?us-ascii?Q?QnlBR1VBY3dCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHTUFkUUJ6QUhRQWJ3QnRBRjhBY0FC?=
 =?us-ascii?Q?bEFISUFjd0J2QUc0QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBZ0FBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWXdCMUFITUFkQUJ2QUcwQVh3QndBR2dBYndCdUFHVUFiZ0Ix?=
 =?us-ascii?Q?QUcwQVlnQmxBSElBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmpBSFVB?=
 =?us-ascii?Q?Y3dCMEFHOEFiUUJmQUhNQWN3QnVBRjhBWkFCaEFITUFhQUJmQUhZQU1BQXlB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdN?=
 =?us-ascii?Q?QWRRQnpBSFFBYndCdEFGOEFjd0J6QUc0QVh3QnJBR1VBZVFCM0FHOEFjZ0Jr?=
 =?us-ascii?Q?QUhNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBB?=
 =?us-ascii?Q?WHdCekFITUFiZ0JmQUc0QWJ3QmtBR1VBYkFCcEFHMEFhUUIwQUdVQWNnQmZB?=
 =?us-ascii?Q?SFlBTUFBeUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFB?=
 =?us-ascii?Q?QUFJQUFBQUFBSjRBQUFCakFIVUFjd0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFj?=
 =?us-ascii?Q?d0J3QUdFQVl3QmxBRjhBZGdBd0FESUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFB?=
 =?us-ascii?Q?R1FBYkFCd0FGOEFjd0JyQUhrQWNBQmxBRjhBWXdCb0FHRUFkQUJmQUcwQVpR?=
 =?us-ascii?Q?QnpBSE1BWVFCbkFHVUFYd0IyQURBQU1nQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVpBQnNBSEFBWHdCekFH?=
 =?us-ascii?Q?d0FZUUJqQUdzQVh3QmpBR2dBWVFCMEFGOEFiUUJsQUhNQWN3QmhBR2NBWlFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJrQUd3QWNBQmZB?=
 =?us-ascii?Q?SFFBWlFCaEFHMEFjd0JmQUc4QWJnQmxBR1FBY2dCcEFIWUFaUUJmQUdZQWFR?=
 =?us-ascii?Q?QnNBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBbmdBQUFHVUFiUUJoQUdrQWJBQmZBR0VBWkFCa0FI?=
 =?us-ascii?Q?SUFaUUJ6QUhNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFFQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
 =?us-ascii?Q?Q2VBQUFBYlFCaEFISUFkZ0JsQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4?=
 =?us-ascii?Q?QWJnQmhBRzBBWlFCekFGOEFZd0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFhUUJo?=
 =?us-ascii?Q?QUd3QVh3QmhBR3dBYndCdUFHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dC?=
 =?us-ascii?Q?MkFHVUFiQUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0J1QUdFQWJRQmxBSE1B?=
 =?us-ascii?Q?WHdCeUFHVUFjd0IwQUhJQWFRQmpBSFFBWlFCa0FGOEFZUUJzQUc4QWJnQmxB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUcwQVlRQnlBSFlBWlFCc0FGOEFjQUJ5?=
 =?us-ascii?Q?QUc4QWFnQmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZBSElBWlFCekFIUUFj?=
 =?us-ascii?Q?Z0JwQUdNQWRBQmxBR1FBWHdCb0FHVUFlQUJqQUc4QVpBQmxBSE1BQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFHRUFjZ0J0QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-refthree: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJ?=
 =?us-ascii?Q?QUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBWndCdkFHOEFad0Jz?=
 =?us-ascii?Q?QUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBB?=
 =?us-ascii?Q?WVFCeUFIWUFaUUJzQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4QVl3QnZB?=
 =?us-ascii?Q?R1FBWlFCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQWJRQmhBSElBZGdCbEFHd0Fi?=
 =?us-ascii?Q?QUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0JqQUc4QVpBQmxBSE1BWHdCa0FH?=
 =?us-ascii?Q?a0FZd0IwQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFjQUJ5QUc4QWFn?=
 =?us-ascii?Q?QmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZBR01BYndCdUFHWUFhUUJrQUdV?=
 =?us-ascii?Q?QWJnQjBBR2tBWVFCc0FGOEFiUUJoQUhJQWRnQmxBR3dBYkFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?MEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBYmdC?=
 =?us-ascii?Q?aEFHMEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFRQmhBR3dB?=
 =?us-ascii?Q?WHdCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBYndCeUFGOEFZUUJ5QUcwQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VB?=
 =?us-ascii?Q?QUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3?=
 =?us-ascii?Q?QnVBR0VBYlFCbEFITUFYd0JqQUc4QWJnQm1BR2tBWkFCbEFHNEFkQUJwQUdF?=
 =?us-ascii?Q?QWJBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZBSElBWHdCbkFHOEFid0Ju?=
 =?us-ascii?Q?QUd3QVpRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFH?=
 =?us-ascii?Q?VUFiQUJzQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dC?=
 =?us-ascii?Q?ZkFISUFaUUJ6QUhRQWNnQnBBR01BZEFCbEFHUUFYd0J0QUdFQWNnQjJBR1VB?=
 =?us-ascii?Q?YkFCc0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJ?=
 =?us-ascii?Q?QWJ3QnFBR1VBWXdCMEFGOEFiZ0JoQUcwQVpRQnpBRjhBY2dCbEFITUFkQUJ5?=
 =?us-ascii?Q?QUdrQVl3QjBBR1VBWkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFY?=
 =?us-ascii?Q?d0JoQUhJQWJRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIUUFaUUJ5QUcwQWFRQnVBSFVB?=
 =?us-ascii?Q?Y3dBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQnNBRjhBZHdCdkFISUFaQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBb0FBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQU9nWUFBQUFBQUFBSUFBQUFBQUFBQUFnQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUFBQUFhQmdBQUdRQUFBQmdB?=
x-dg-reffive: =?us-ascii?Q?QUFBQUFBQUFZUUJrQUdRQWNnQmxBSE1BY3dBQUFDUUFBQUFDQUFBQVl3QjFB?=
 =?us-ascii?Q?SE1BZEFCdkFHMEFYd0J3QUdVQWNnQnpBRzhBYmdBQUFDNEFBQUFBQUFBQVl3?=
 =?us-ascii?Q?QjFBSE1BZEFCdkFHMEFYd0J3QUdnQWJ3QnVBR1VBYmdCMUFHMEFZZ0JsQUhJ?=
 =?us-ascii?Q?QUFBQXdBQUFBQUFBQUFHTUFkUUJ6QUhRQWJ3QnRBRjhBY3dCekFHNEFYd0Jr?=
 =?us-ascii?Q?QUdFQWN3Qm9BRjhBZGdBd0FESUFBQUF3QUFBQUFBQUFBR01BZFFCekFIUUFi?=
 =?us-ascii?Q?d0J0QUY4QWN3QnpBRzRBWHdCckFHVUFlUUIzQUc4QWNnQmtBSE1BQUFBK0FB?=
 =?us-ascii?Q?QUFBQUFBQUdNQWRRQnpBSFFBYndCdEFGOEFjd0J6QUc0QVh3QnVBRzhBWkFC?=
 =?us-ascii?Q?bEFHd0FhUUJ0QUdrQWRBQmxBSElBWHdCMkFEQUFNZ0FBQURJQUFBQUFBQUFB?=
 =?us-ascii?Q?WXdCMUFITUFkQUJ2QUcwQVh3QnpBSE1BYmdCZkFITUFjQUJoQUdNQVpRQmZB?=
 =?us-ascii?Q?SFlBTUFBeUFBQUFQZ0FBQUFBQUFBQmtBR3dBY0FCZkFITUFhd0I1QUhBQVpR?=
 =?us-ascii?Q?QmZBR01BYUFCaEFIUUFYd0J0QUdVQWN3QnpBR0VBWndCbEFGOEFkZ0F3QURJ?=
 =?us-ascii?Q?QUFBQTJBQUFBQUFBQUFHUUFiQUJ3QUY4QWN3QnNBR0VBWXdCckFGOEFZd0Jv?=
 =?us-ascii?Q?QUdFQWRBQmZBRzBBWlFCekFITUFZUUJuQUdVQUFBQTRBQUFBQUFBQUFHUUFi?=
 =?us-ascii?Q?QUJ3QUY4QWRBQmxBR0VBYlFCekFGOEFid0J1QUdVQVpBQnlBR2tBZGdCbEFG?=
 =?us-ascii?Q?OEFaZ0JwQUd3QVpRQUFBQ1FBQUFBUUFBQUFaUUJ0QUdFQWFRQnNBRjhBWVFC?=
 =?us-ascii?Q?a0FHUUFjZ0JsQUhNQWN3QUFBRmdBQUFBQUFBQUFiUUJoQUhJQWRnQmxBR3dB?=
 =?us-ascii?Q?WHdCd0FISUFid0JxQUdVQVl3QjBBRjhBYmdCaEFHMEFaUUJ6QUY4QVl3QnZB?=
 =?us-ascii?Q?RzRBWmdCcEFHUUFaUUJ1QUhRQWFRQmhBR3dBWHdCaEFHd0Fid0J1QUdVQUFB?=
 =?us-ascii?Q?QlVBQUFBQUFBQUFHMEFZUUJ5QUhZQVpRQnNBRjhBY0FCeUFHOEFhZ0JsQUdN?=
 =?us-ascii?Q?QWRBQmZBRzRBWVFCdEFHVUFjd0JmQUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJs?=
 =?us-ascii?Q?QUdRQVh3QmhBR3dBYndCdUFHVUFBQUJhQUFBQUFBQUFBRzBBWVFCeUFIWUFa?=
 =?us-ascii?Q?UUJzQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFI?=
 =?us-ascii?Q?SUFaUUJ6QUhRQWNnQnBBR01BZEFCbEFHUUFYd0JvQUdVQWVBQmpBRzhBWkFC?=
 =?us-ascii?Q?bEFITUFBQUFnQUFBQUFBQUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QmhBSElB?=
 =?us-ascii?Q?YlFBQUFDWUFBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUdjQWJ3QnZB?=
 =?us-ascii?Q?R2NBYkFCbEFBQUFOQUFBQUFBQUFBQnRBR0VB?=
x-dg-refsix: =?us-ascii?Q?Y2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJmQUdNQWJ3QmtB?=
 =?us-ascii?Q?R1VBY3dBQUFENEFBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNn?=
 =?us-ascii?Q?QnZBR29BWlFCakFIUUFYd0JqQUc4QVpBQmxBSE1BWHdCa0FHa0FZd0IwQUFB?=
 =?us-ascii?Q?QVhnQUFBQUFBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBY0FCeUFHOEFhZ0Js?=
 =?us-ascii?Q?QUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUdNQWJ3QnVBR1lBYVFCa0FHVUFi?=
 =?us-ascii?Q?Z0IwQUdrQVlRQnNBRjhBYlFCaEFISUFkZ0JsQUd3QWJBQUFBR3dBQUFBQUFB?=
 =?us-ascii?Q?QUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdC?=
 =?us-ascii?Q?dUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0QWRBQnBBR0VB?=
 =?us-ascii?Q?YkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0JoQUhJQWJRQUFB?=
 =?us-ascii?Q?SElBQUFBQUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpR?=
 =?us-ascii?Q?QmpBSFFBWHdCdUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0?=
 =?us-ascii?Q?QWRBQnBBR0VBYkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0Ju?=
 =?us-ascii?Q?QUc4QWJ3Qm5BR3dBWlFBQUFGb0FBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0Fi?=
 =?us-ascii?Q?QUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0J1QUdFQWJRQmxBSE1BWHdCeUFH?=
 =?us-ascii?Q?VUFjd0IwQUhJQWFRQmpBSFFBWlFCa0FGOEFiUUJoQUhJQWRnQmxBR3dBYkFB?=
 =?us-ascii?Q?QUFHZ0FBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29B?=
 =?us-ascii?Q?WlFCakFIUUFYd0J1QUdFQWJRQmxBSE1BWHdCeUFHVUFjd0IwQUhJQWFRQmpB?=
 =?us-ascii?Q?SFFBWlFCa0FGOEFiUUJoQUhJQWRnQmxBR3dBYkFCZkFHOEFjZ0JmQUdFQWNn?=
 =?us-ascii?Q?QnRBQUFBS2dBQUFBQUFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFkQUJsQUhJ?=
 =?us-ascii?Q?QWJRQnBBRzRBZFFCekFBQUFJZ0FBQUFvQUFBQnRBR0VBY2dCMkFHVUFiQUJz?=
 =?us-ascii?Q?QUY4QWR3QnZBSElBWkFBQUFBPT0iLz48L21ldGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB2602:EE_|DM4PR18MB4302:EE_
x-ms-office365-filtering-correlation-id: 145d5d00-8058-421a-51c6-08dbf48910c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z7gdQZPKLadYBCWwtJAXwqGX+LATLA8osMO9aooUrgprN0Ek/gQj0rBBb9hCXb7p3PWdE6dT9rCxrvFw6KHwqH/rkdIshkkfvj+m/eKKTAIFmoEea4Bko5Eh2qiqRmWFf2o1jb6WxnMBSkOtOyZF+8SDwHdBW12RgvQPQkVBVZu1R18Och6qu63fwnzDaO+alRlyFXFqPoee7dtNywOGhZYWg5Cm5Iz6hBQ8byMJ7Wte0OyxDgEokLih2LK97lzLW1SSd5hcXnCrCf3JOnnUWJtiLb52BZiiRLQc/ZbZNon/0gRikD9W7xFJaI3j5hGWXe3ldjFGLSHzNAJvP0J9QkOq9FlyEiVVlwl+w4heCQf0bYUR2PxVOSf5gkhXF4PDSw2W4NX6Lm6eyWJRD+TPC64JAl/E65qo4NKxd5eTyYfn/ovNC05QdrBqei5C9a9EGwGzo8GNDF2vYjrdXH5mprZDZXdVdFLNputqWglOpf/wyw2lcTZcDCGhJ26adF4yJLSLg7sJgW2E/JPY+2rVjPmV4GJTEcHQJWWn0/NAmSwgRugrYyRJVnpzI36vud5o5B2sZLNg9YN8QJUU0ujgneaXDK8ffTZdha12adQ+0vUbqrEKgJTnsAQ7FW85KOIrMj3zSiTR6U49aiThXOSQ5se8EVEtk/QrcCqxlTrlNC4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2602.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230273577357003)(230922051799003)(230173577357003)(64100799003)(451199024)(1800799012)(186009)(66946007)(66556008)(76116006)(66476007)(66446008)(316002)(6916009)(54906003)(64756008)(38100700002)(2906002)(5660300002)(41300700001)(86362001)(33656002)(38070700009)(122000001)(4326008)(8936002)(8676002)(52536014)(9686003)(53546011)(7696005)(6506007)(83380400001)(26005)(107886003)(55016003)(71200400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NDq0Yf6SQIjOchyC3T/Y2QI4qx9Q7S4J8ndQjfpyRG0iAJi/Tx4YgNRxtXTG?=
 =?us-ascii?Q?uUNsFMLNcwkjTdJQpcAQov2+tX53sJP04pfz+DJCkqoPwlredQ4b2DKil6ge?=
 =?us-ascii?Q?m/l3dZh8prqiWF6EdDPTVS8C06qRv+beq/qhcZvS6Y3SWbtDWfRYxm97z2Ux?=
 =?us-ascii?Q?ed8uGiJSVtH8CeFfv2DkmWLG3hx/JAcXJXUiCIJ8tnZPY3AatXXNJYBidGZ7?=
 =?us-ascii?Q?ilhR8F5EF0WftbK4gsMaownMJ0MqXceTRy6rcgBShG9cH/LvScInF6L2GGdK?=
 =?us-ascii?Q?1+iJdqWznkFcenXRbSZS6Kg8S8CRSHpyW/oqBfmchsRt7eSwVNPgW1uWD4Oh?=
 =?us-ascii?Q?FDdT+psdogUlFGj66tHllx3vZFa0kR7xev/7661ISeFMLO93PHjxK2KHYX+Q?=
 =?us-ascii?Q?tbex0A/RLy7LOQ6DuUw5lvgTzN2OO5B+EOKwjOo8si61UO9BomzHp5/iXIFp?=
 =?us-ascii?Q?u7zaw+olpQiaiHEnI8GbgfzhsH9VcyV6fvUh7SRv35A/XzAh/SIa1nsNz1XQ?=
 =?us-ascii?Q?mVHDhZSxVdSSIf82OqLRbniuM+h3lpjqC1R/gfTFTMNyCMi3U9cXye9cGnDI?=
 =?us-ascii?Q?I68M7ZM49BC2+chVfk/+Kq55vba1ywGLoXaVaSp14Fg+rviFHPiMJmycn4Vm?=
 =?us-ascii?Q?AReLyq4qUoCjpzwYbQV79xvyvAh23lw0Ok9t620SxqY0bN8FIk1h9JxFER5Q?=
 =?us-ascii?Q?69quSy7qnpk23oXdi62qdQdZJYGa7ffu+Yvzct2GTUbJhhlZuwzVLfCOXRIu?=
 =?us-ascii?Q?gpPs/s03mdKcIpEzD+WxetItr7uoP0WAyje2ux+SQ5pl5EgWJbuO4qtG0grc?=
 =?us-ascii?Q?PSlqrML4lOpk2vbAZ7y3s3FXd9JFiHqQHszggSCCJ1Pe+hMSa4ZSAP50HKRM?=
 =?us-ascii?Q?GPwJ4/ZeKTVYwFzpdxFVSE1lM9KZYZzBsujXLSs3Fe+KNQljIhz2xD27q8OK?=
 =?us-ascii?Q?UF5X3SQB3DL26YSZ7Zo43CwtYeIpp31kV20bsF+F7rJfHuExTUVhTSi6ecw8?=
 =?us-ascii?Q?5mRagWIzpIryDLRIavLHuuqGAUOF1DYT4beQdZfVSRjoYMqwECJGnjmhgMM5?=
 =?us-ascii?Q?69lE2l01dG6/bZtDqrfv+STEVwr5FFjONdlRBmeTLnGQOktfS60Kpq2LnuFg?=
 =?us-ascii?Q?+onOpnKLcjLxTElDEc8BWdwFfxnRMWXJ+8dGsHV8LEdXEu4D4BHIbHOkXPRH?=
 =?us-ascii?Q?YaeY2k9pxHvMPecrSU4Z5ZQBBazgpnnv+6tIPHc/7BCzbbqpSpgbuCBNNC4R?=
 =?us-ascii?Q?pm9hw03/z6R9y+CCcvQYCc7EIUm0/21YajiWuV3oh34pNgWlA2ULY1C1WmRx?=
 =?us-ascii?Q?UIFxCyph/Jqc/RVHuPROJGaGirS+IqR7DtFoZcZPnWigbbPCYhYT6st4Qg3O?=
 =?us-ascii?Q?rE7f+FO6NOsesr6B/nGtTFxoIo9b92AT/kebstRfzrX94WbS9i/I6rjUGD75?=
 =?us-ascii?Q?EXJFBz0uhSrLCEz8pZCh0zPEsdetsin4RDFbuV8pkftM5XUWdaczd6ISSL6I?=
 =?us-ascii?Q?WJq2bRa19tWqpyUiIgHo4p1teUIc9U6Er1NvpREcOtjG4xgguavZnfVpTUym?=
 =?us-ascii?Q?t/9r4xHiS0DzAPHz4QM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2602.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145d5d00-8058-421a-51c6-08dbf48910c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 05:22:53.1785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uHzUvnbancSu93rlcjqyQnDMl/kVeudjW9AcAW61xGDVb6EM6b3+WeeCA5GzTMk48bBnxHzZCWYSACryddyupQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4302
X-Proofpoint-ORIG-GUID: BLWVcD4v3BDEXzht2_FJWVSvb0T6VFqr
X-Proofpoint-GUID: BLWVcD4v3BDEXzht2_FJWVSvb0T6VFqr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_03,2023-11-30_01,2023-05-22_02
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Sunday, December 3, 2023 10:31 PM
> To: Geethasowjanya Akula <gakula@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org=
;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Linu Cherian
> <lcherian@marvell.com>; Jerin Jacob Kollanukkaran <jerinj@marvell.com>;
> Subbaraya Sundeep Bhatta <sbhatta@marvell.com>; Hariprasad Kelam
> <hkelam@marvell.com>
> Subject: [EXT] Re: [net v3 PATCH 3/5] octeontx2-af: Fix mcs stats registe=
r
> address
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Thu, Nov 30, 2023 at 01:28:16PM +0530, Geetha sowjanya wrote:
> > This patch adds the miss mcs stats register for mcs supported
> > platforms.
> >
> > Fixes: 9312150af8da ("octeontx2-af: cn10k: mcs: Support for stats
> > collection")
> > Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> > ---
> >  .../net/ethernet/marvell/octeontx2/af/mcs.c   |  4 +--
> >  .../ethernet/marvell/octeontx2/af/mcs_reg.h   | 31 ++++++++++++++++---
> >  2 files changed, 29 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> > b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> > index d6effbe46208..d4a4e4c837ec 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> > @@ -117,7 +117,7 @@ void mcs_get_rx_secy_stats(struct mcs *mcs, struct
> mcs_secy_stats *stats, int id
> >  	reg =3D MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYTAGGEDCTLX(id);
> >  	stats->pkt_tagged_ctl_cnt =3D mcs_reg_read(mcs, reg);
> >
> > -	reg =3D
> MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDORNOTAGX(id);
> > +	reg =3D MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDX(id);
> >  	stats->pkt_untaged_cnt =3D mcs_reg_read(mcs, reg);
> >
> >  	reg =3D MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYCTLX(id);
> > @@ -215,7 +215,7 @@ void mcs_get_sc_stats(struct mcs *mcs, struct
> mcs_sc_stats *stats,
> >  		reg =3D MCSX_CSE_RX_MEM_SLAVE_INPKTSSCNOTVALIDX(id);
> >  		stats->pkt_notvalid_cnt =3D mcs_reg_read(mcs, reg);
> >
> > -		reg =3D
> MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDOROKX(id);
> > +		reg =3D
> MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDX(id);
> >  		stats->pkt_unchecked_cnt =3D mcs_reg_read(mcs, reg);
> >
> >  		if (mcs->hw->mcs_blks > 1) {
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
> > b/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
> > index f3ab01fc363c..f4c6de89002c 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
> > @@ -810,14 +810,37 @@
> >  		offset =3D 0x9d8ull;			\
> >  	offset; })
> >
> > +#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDX(a) ({	\
> > +	u64 offset;					\
> > +							\
> > +	offset =3D 0xee80ull;				\
> > +	if (mcs->hw->mcs_blks > 1)			\
> > +		offset =3D 0xe818ull;			\
> > +	offset +=3D (a) * 0x8ull;				\
> > +	offset; })
>=20
> Hi Geetha,
>=20
> I see this is consistent with existing code in this file, but I do wonder=
 if there
> would be value in moving to a more compact mechanism at some point. F.e.
> (completely untested!):
>=20
> #define MCSX_REG(base, a) ((base) + (a) * 0x8ull) #define
> MCSX_MB_REG(base_mb, base, a) \
>         MCSX_REG((mcs->hw->mcs_blks > 1 ? (base_mb) : (base)), (a)) ...
> #define MCSX_MCS_TOP_SLAVE_PORT_RESET(a) MCSX_MB_REG(0xa28ull,
> 0x408ull, (a)) ...
> #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYCTLX(a)
> MCSX_REG(0xb680ull, (a)) ...
>=20
Hi Simon,
Thanks for your suggestion. Will take this in different patch set.

> In any case, such a change isn't for this patch, which looks good to me.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
>=20
> > +
> > +#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDX(a) ({	\
> > +	u64 offset;					\
> > +							\
> > +	offset =3D 0xa680ull;				\
> > +	if (mcs->hw->mcs_blks > 1)			\
> > +		offset =3D 0xd018ull;			\
> > +	offset +=3D (a) * 0x8ull;				\
> > +	offset; })
> > +
> > +#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCLATEORDELAYEDX(a)	({
> 	\
> > +	u64 offset;						\
> > +								\
> > +	offset =3D 0xf680ull;					\
> > +	if (mcs->hw->mcs_blks > 1)				\
> > +		offset =3D 0xe018ull;				\
> > +	offset +=3D (a) * 0x8ull;					\
> > +	offset; })
> > +
> >  #define MCSX_CSE_RX_MEM_SLAVE_INOCTETSSCDECRYPTEDX(a)
> 	(0xe680ull + (a) * 0x8ull)
> >  #define MCSX_CSE_RX_MEM_SLAVE_INOCTETSSCVALIDATEX(a)
> 	(0xde80ull + (a) * 0x8ull)
> > -#define
> MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDORNOTAGX(a)
> 	(0xa680ull + (a) * 0x8ull)
> >  #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYNOTAGX(a)	(0xd218 + (a)
> * 0x8ull)
> > -#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDX(a)
> 	(0xd018ull + (a) * 0x8ull)
> > -#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDOROKX(a)
> 	(0xee80ull + (a) * 0x8ull)
> >  #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYCTLX(a)
> 	(0xb680ull + (a) * 0x8ull)
> > -#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCLATEORDELAYEDX(a)
> (0xf680ull + (a) * 0x8ull)
> >  #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSAINVALIDX(a)	(0x12680ull +
> (a) * 0x8ull)
> >  #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSANOTUSINGSAERRORX(a)
> (0x15680ull + (a) * 0x8ull)
> >  #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSANOTVALIDX(a)
> 	(0x13680ull + (a) * 0x8ull)
> > --
> > 2.25.1
> >
