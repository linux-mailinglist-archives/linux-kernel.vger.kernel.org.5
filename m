Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5357C48F3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345218AbjJKFBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 01:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345197AbjJKFBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:01:43 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA5B92;
        Tue, 10 Oct 2023 22:01:42 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AN3BgP023081;
        Tue, 10 Oct 2023 22:01:28 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3tkh7ckt4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 22:01:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ID8vci9FA3RygBkU6naegqGNypIi3z/pCVCtwirAd04S9E1ueJ6DvLXqiov/7fr6B6OrMVTG3pFD5KVqmQIO6NZD1n1a9D6C8F6HPBG5uiRHyW8BHz+2KlGiTySl0H/VjE3X9BnFEmIHR4AxidmSYWDChuX2Yom1sRsBjAnzgpKBC2m6eXuMCqLse1vdQSgFk4pugl9P3iA7+RYHrWfH//wo/6QowzN/C1FIHT5kRbxeyoU+AnCkPnVFdNna8PdB5bAiHz3PMIHvO8aGpfgyAsogLYpNcoFo6ABwC0iWJEUC++WKFf0Dxj5UMLbM/GE6Z/m6PBEl4b7LlZkgN3DZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfQzmortm7h1lktZ5GPF4/D4pJb0AL8qhbx1Hrs9jd4=;
 b=ejDdiahzC9P7gZaRlt1LECmdI359JHCLGJ0qQrkQdtD0xLcK6SJ7Us3wT8z39FlERfR+lPjx5Ewf73sUqqQCaYTRGrD5pHC2gVdYzTNLOVtbgEYnqSv70WYsdVDrwx9zIKjGH3XI6fu0HOLIrl1YZLxpJlChgFOPNoZrGY/5rRTBhp9OoUIJOnysrmEe00KLQs7hbzHi1z2naQQu5oGBfD2GLmm0jtUOL+1Ha8Sl2I3Y28Bqp+arTBv1krFpuA/yJ1ivKPbp6xGJZ+/3hPjKH9R8zPE2PccdTZEwe6DFuX0zgG6YzuXhO0tQiA4ZhDEwSnK3aEcwRlckaEOml/3Npw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfQzmortm7h1lktZ5GPF4/D4pJb0AL8qhbx1Hrs9jd4=;
 b=Wk3Kx0Ar908Ofat94++0H96t2tMvB2baGfTSQeniuM/ONHMIwBzgA4cWxIZXsniAvXsrfPRyePd8zJraht9NYV6d2aqU3YKUpDQPLYrmphqWitB+AusdK61V3LobptMlDaSTHQSw5X31RnXAL51Fo9Qo4MopeVA5fis7suQcUAQ=
Received: from CO1PR18MB4666.namprd18.prod.outlook.com (2603:10b6:303:e5::24)
 by SJ0PR18MB3866.namprd18.prod.outlook.com (2603:10b6:a03:2e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 05:01:25 +0000
Received: from CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::9caf:dc2e:a8d7:b5c6]) by CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::9caf:dc2e:a8d7:b5c6%5]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 05:01:24 +0000
From:   Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
To:     Simon Horman <horms@kernel.org>,
        Sai Krishna Gajula <saikrishnag@marvell.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        Linu Cherian <lcherian@marvell.com>,
        Jerin Jacob Kollanukkaran <jerinj@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXT] Re: [net PATCH v2] octeontx2-af: Fix hardware timestamping
 for VFs
Thread-Topic: [EXT] Re: [net PATCH v2] octeontx2-af: Fix hardware timestamping
 for VFs
Thread-Index: AQHZ9el+w8foFfrOuk2xyZPKerH4V7A+b+iAgAWjhpA=
Date:   Wed, 11 Oct 2023 05:01:24 +0000
Message-ID: <CO1PR18MB4666CF65EDF7736D79FAF3EEA1CCA@CO1PR18MB4666.namprd18.prod.outlook.com>
References: <20231003110504.913980-1-saikrishnag@marvell.com>
 <20231007145217.GB831234@kernel.org>
In-Reply-To: <20231007145217.GB831234@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2JoYXR0YVxh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTM4MDQ5ZmVjLTY3ZjMtMTFlZS05YzZiLWJjZjE3?=
 =?us-ascii?Q?MTIxOGI3YVxhbWUtdGVzdFwzODA0OWZlZS02N2YzLTExZWUtOWM2Yi1iY2Yx?=
 =?us-ascii?Q?NzEyMThiN2Fib2R5LnR4dCIgc3o9IjU3ODIiIHQ9IjEzMzQxNDc0MDgxOTky?=
 =?us-ascii?Q?NjkwNCIgaD0iMStZejBBdjVIT0FrNUx2RDh1b0JXVGlnSFZZPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQmdXQUFC?=
 =?us-ascii?Q?NFgxLzYvL3ZaQVJlRktXTDk3S2RkRjRVcFl2M3NwMTBaQUFBQUFBQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFFd0FBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBVUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQU9nWUFBQUFBQUFBSUFBQUFBQUFBQUFnQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUFBQUFhQmdBQUdRQUFBQmdB?=
x-dg-reffive: =?us-ascii?Q?QUFBQUFBQUFZUUJrQUdRQWNnQmxBSE1BY3dBQUFDUUFBQUFCQUFBQVl3QjFB?=
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
 =?us-ascii?Q?OEFaZ0JwQUd3QVpRQUFBQ1FBQUFBVEFBQUFaUUJ0QUdFQWFRQnNBRjhBWVFC?=
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
 =?us-ascii?Q?QWJRQnBBRzRBZFFCekFBQUFJZ0FBQUFVQUFBQnRBR0VBY2dCMkFHVUFiQUJz?=
 =?us-ascii?Q?QUY4QWR3QnZBSElBWkFBQUFBPT0iLz48L21ldGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4666:EE_|SJ0PR18MB3866:EE_
x-ms-office365-filtering-correlation-id: 10d04e41-9299-4c82-eb8e-08dbca171e68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5oQXLQI3BrOJaekjW2O+5PgMi4hP8Rw3iTZA32cOCWXCzHvuuKzSSe74qCcSycaqHpu9IBwzeSGRwEewjUzONKsg1cgvDfvJ5+7oQVpo2x1iPNjP9eStmkvJ6mpwfCMmcTmelaZOEPJv9KAQt5wt6wgzqfRYzeBZ0QRkRtsZnPdW2T18KN0dUx1jO2/7Aj+d1XrNDRirw1kRg6Sc16957FU/tMB7YJUsYlJI1lLv78HhNvaImFalkxrb2bqzRChkac5f0BcqlRNFhv5XnreAQvSuACUtgBlawdtqdxl7IByp/3hfrZ3lCrtmzCEvnJhrFCLwn1FP+C2tPgO4JKnQynpAg34bvO15mGZk0/1i3fL8GgJQ9Ef6Bqx2KolJAXS+VbyDbEboafQV2v9ooiqVM/Fv29HnFXmVXoVvayxZVDe7DNboo1SVz8abFKq1Fd2mOl3jpCENI7M+LcoeqFR/JnV0SEZbL3p+ty5/u6Pq253Wj//r2ylPCSfXiPyrn6WwEEsutzZbSZ2uk2JvJmRYEunpglg+NxG2PXkK9um78cvYSSuPkNgpFAxPIAXWGiC5PSGVu5e79tgghuZ93hhicvzjn055nrzeeyxBZUFoDW4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4666.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(55016003)(6506007)(7696005)(38070700005)(38100700002)(41300700001)(107886003)(122000001)(26005)(9686003)(86362001)(76116006)(66556008)(66946007)(66476007)(316002)(110136005)(64756008)(66446008)(33656002)(6636002)(54906003)(52536014)(5660300002)(2906002)(8936002)(8676002)(4326008)(83380400001)(478600001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YrVvoZOXMh9p9HCltOMZrkvdrp4ybXOc5+jeyTXLVFOU9m6DjvuZJCjJOjOz?=
 =?us-ascii?Q?b4gsXe3W8dw4+Xg29cZIPJ8clziVKlXiQawFsDZ9Gp2xPZf7OSCTdYawiBY8?=
 =?us-ascii?Q?yJs6WTcixI6cUBrUHznh00rF8FcWCM6JreR3J8+6TwLLK7/NB2/UBduVANK3?=
 =?us-ascii?Q?QBee3rvIvTspQOKIqTaHVWgCQ3b3IJfWfy6KF4kvK0vJGaxqagHs4xZNLgRh?=
 =?us-ascii?Q?945DeJQ+zzE+nqimwbPQP4GkVIoen5jgPmFv10BBPkXbb+dEt4zjHOSAPQOb?=
 =?us-ascii?Q?uzzl45bKw8zvt+nDflUuKsOR/g4Iv5Ps9b6re4g7rTeDmCwQdHeJFUqNPySw?=
 =?us-ascii?Q?+AKDeSkV3oHYW7gNGFhtEToQyhhNF77olNmobmsRdp7H2XxFpBhqyn7BFU3t?=
 =?us-ascii?Q?zH6OjuqNDosRW8XjpHk2Zeh/vw5Vm8nzP+biZAwVBiAGymGbJwQ0kNtCmtBl?=
 =?us-ascii?Q?0BEJu/Yej84JpE8wtWV2Cv6RAGD8cWyODJW4S7yK3ptC2ZnUHeoGpJWZwzjP?=
 =?us-ascii?Q?MnC3zQmoV2e/R1pNDaT8kVIawA3DxbsLFdkJEk2zdtErx1MULfXIpl/cg56+?=
 =?us-ascii?Q?MHyOuvmhuboR/HefWpGngf1Eem2nD/zf+ZS3vJe8tkQdOBpEG0ynN1pvtF5b?=
 =?us-ascii?Q?i9TvW0Ozb2dSL4r9vde6pY7s5h2hKisR8Nlaqjt8CvyakijW0Ny6mGoX1hWw?=
 =?us-ascii?Q?6134g7ufZuAwY1ICQFjdfhAe/wi06K1ihl4QrBFUsWvAngz2hVpzgIuArFKI?=
 =?us-ascii?Q?88wz83Mt44K1Tosw5pBLfXMXJERbTJaZGTcp/cfIyuh/se6ARZDCePKzz8kP?=
 =?us-ascii?Q?3hozabdmvMaq/HFEbPIa/1MtbF3gGIz+VSnfkwjTfwtJ2W95ZoCG37WveDjh?=
 =?us-ascii?Q?UA0pHt/j0cRY6/FeeSCw4voLlFY0GEIu4kNjgvoGNdcarHXocGbYgGJD2Nf4?=
 =?us-ascii?Q?wHuMxnqahSE/qUnUwUlj8/zzdkr+iDmQOKNogHiZFQZHr4kCYck9+y0ogjG6?=
 =?us-ascii?Q?GIweItShSSIMwzXgxjY5X+a4+ldwvvAfaK3fXvSZXqdCM/d8sMGA9f0U78MB?=
 =?us-ascii?Q?WVEd9IIVKNmbGKiABoyjjeMPa2RNbYYOWIb+zct7IvjPiCPKK5nE1d1TAO9a?=
 =?us-ascii?Q?l2OqlllDXHsP23ATNZEMbADGnAHkzsH6s5mN31mH0FXujxuLWqUW9urz/cYm?=
 =?us-ascii?Q?XwVN2BPfysT9+BaV9S9cOSxUowPtHdLpqDlXkVDcG8HzuB/kiEB2DXe2Whud?=
 =?us-ascii?Q?wfeU8VDsU5/9PoVggcHqcNDBKTGo5LD0rLlks7c9+9Er+3GVQsAXma9XP1x9?=
 =?us-ascii?Q?EbIYBui1d0QdaRbccmNeWH31ZrFs9yM0FuCjWhWcBmVLelyppuN/pcMZ/a0J?=
 =?us-ascii?Q?fkNeheMtVRv1AthmNKdDrM7cGDmi4bbPua1+sOOgW0rsOK7hJ57grgaiBbEz?=
 =?us-ascii?Q?J63Abu8P9cKopF4CvlTIXmD7wl6+kyeSqFSLdeFD7L9Wz6zNT2cF1uqlOyoC?=
 =?us-ascii?Q?0KWYVzynM8uCXEe0ZG/zNHkB55OmBMzmfQCjK7C+ale6OoT2xiVZM9/2RCeV?=
 =?us-ascii?Q?4KrJXf8jl/95MGlRdAPxe86RTCJM4UJcEdrZEXjo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4666.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d04e41-9299-4c82-eb8e-08dbca171e68
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 05:01:24.6145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oyCa8CJ+/OsRsb9P7pc5Au70RLhW1T3zCYcdZOXH+47row+7qm/d149SYWLRYwVsm8zEriNQVaj+Wc0z7Qe9gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3866
X-Proofpoint-GUID: ToRqzTDGYEFo1CUuY4qZI4vQYWJGGqTU
X-Proofpoint-ORIG-GUID: ToRqzTDGYEFo1CUuY4qZI4vQYWJGGqTU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_01,2023-10-10_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

>-----Original Message-----
>From: Simon Horman <horms@kernel.org>
>Sent: Saturday, October 7, 2023 8:22 PM
>To: Sai Krishna Gajula <saikrishnag@marvell.com>
>Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
>Sunil Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
><gakula@marvell.com>; richardcochran@gmail.com; Linu Cherian
><lcherian@marvell.com>; Jerin Jacob Kollanukkaran <jerinj@marvell.com>;
>Hariprasad Kelam <hkelam@marvell.com>; Subbaraya Sundeep Bhatta
><sbhatta@marvell.com>
>Subject: [EXT] Re: [net PATCH v2] octeontx2-af: Fix hardware timestamping =
for
>VFs
>On Tue, Oct 03, 2023 at 04:35:04PM +0530, Sai Krishna wrote:
>> From: Subbaraya Sundeep <sbhatta@marvell.com>
>>
>> Currently for VFs, mailbox returns ENODEV error when hardware timestampi=
ng
>> enable is requested. This patch fixes this issue. Modified this patch to
>> return EPERM error for the PF/VFs which are not attached to CGX/RPM.
>>
>> Fixes: 421572175ba5 ("octeontx2-af: Support to enable/disable HW
>timestamping")
>> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
>> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
>> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
>> ---
>>  drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
>b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
>> index f2b1edf1bb43..f464640e188b 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
>> @@ -756,12 +756,11 @@ static int rvu_cgx_ptp_rx_cfg(struct rvu *rvu, u16
>pcifunc, bool enable)
>>  	if (!is_mac_feature_supported(rvu, pf, RVU_LMAC_FEAT_PTP))
>>  		return 0;
>>
>> -	/* This msg is expected only from PFs that are mapped to CGX LMACs,
>> +	/* This msg is expected only from PF/VFs that are mapped to CGX/RPM
>LMACs,
>>  	 * if received from other PF/VF simply ACK, nothing to do.
>>  	 */
>> -	if ((pcifunc & RVU_PFVF_FUNC_MASK) ||
>> -	    !is_pf_cgxmapped(rvu, pf))
>> -		return -ENODEV;
>> +	if (!is_pf_cgxmapped(rvu, rvu_get_pf(pcifunc)))
>
>Hi Sai,
>
>I'm not clear on why this change substitutes pf for rvu_get_pf(pcifunc),
>as futher above in this function pf is set to the return value of
>rvu_get_pf(pcifunc).
>
Good catch. No need of rvu_get_pf(pcifunc) again. We will change and send v=
3.
Thanks for the review.

Sundeep

>> +		return -EPERM;
>>
>>  	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
>>  	cgxd =3D rvu_cgx_pdata(cgx_id, rvu);
>> --
>> 2.25.1
>>
>>
