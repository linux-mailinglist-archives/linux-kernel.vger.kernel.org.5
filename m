Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D462802B4E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 06:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbjLDF00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 00:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDF0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 00:26:23 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58739E6;
        Sun,  3 Dec 2023 21:26:29 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B424qfw018798;
        Sun, 3 Dec 2023 21:26:22 -0800
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ur4yrkjje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Dec 2023 21:26:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUXpxyfQBvjSc4xu+hVvmAnCWkSdUd5fk6Vf44QkeVZKpcXfzxaItKjSUWcnrLW4wdVSurxgBiGzA/YfTxn9OoMmLx9Bg/yFoKkMsBlxDRXI0LBbnBJ2FuebdSuFRCweVsXp7Wns2bR/R04acZOVDL0Hfizc94bM7ncWhPgMgg23x8enAWh8r848QRrKjr4VZLRcgfL/NJJOfAIAWIPKnwKBKnQ2trC2khHwsh7C71ztwl9m5y0tptQhZIKxYQ1Jl28FwdU6IpfTbghKTyWhtoNx1XaK4Q5reqGT8VHVRYSGO1LESU5uWOMXjFioKpKPSMr4pmwGCui5jy/vXdu7ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBRhhtbiKJGp9FRm8fzaAJ/FtIDF0XYF0PmMgwMAZaw=;
 b=HBteMfPrmrbG4xB+aapA3cHmoTUUrocVlJ4gUlbX/erNDkejFUglcd9lzhqxhX93EZAwhvVvUaaNU741z6FWMym7QMeediQ5+z4H/xmCxLCiDaMGeQE49Nizho7NpdC2asPsXIR4u/IM9QQyCymg1tAGsQk5t+fHmdjG+/evhHT8WzxoC5321r3syHUTf4Aoyn30Ed2rMq8bPK4aRtqTVhx9g/Ic8khdvLs5lUO8607f7Gi/MrT1k9hJbw1JhFvR9q+Ne/Q8fcR1IfMret3zKT36WirsWFy6bulW2s/n+hyJpzJTy2fz+hcld8ICgHQcJhlv9wqcNrn3ceEp37uckg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBRhhtbiKJGp9FRm8fzaAJ/FtIDF0XYF0PmMgwMAZaw=;
 b=Esc3G12ZFpaXTBwLIZzaNmAXFMsfJFHk0y4l3+lhbXculhw9LbHXIBlffVgJrZD+S95nOSrwXcUu0a3bcFxXxEglJM4ieV8eQNCsRznIRKWC3oXk9YmSNQCY6wRn4dcnAT6iBkr+b0+vtEmRKsjUOwf7QUNoO0d+L0CgtHMy/OE=
Received: from DM6PR18MB2602.namprd18.prod.outlook.com (2603:10b6:5:15d::25)
 by DM4PR18MB4302.namprd18.prod.outlook.com (2603:10b6:5:399::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 05:26:18 +0000
Received: from DM6PR18MB2602.namprd18.prod.outlook.com
 ([fe80::a747:7509:8395:4f74]) by DM6PR18MB2602.namprd18.prod.outlook.com
 ([fe80::a747:7509:8395:4f74%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 05:26:18 +0000
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
Subject: RE: [EXT] Re: [net v3 PATCH 1/5] octeontx2-af: Adjust Tx credits when
 MCS external bypass is disabled
Thread-Topic: [EXT] Re: [net v3 PATCH 1/5] octeontx2-af: Adjust Tx credits
 when MCS external bypass is disabled
Thread-Index: AQHaI2MCmzc2c26P406SbfgryAxPK7CXyFGAgADVSgA=
Date:   Mon, 4 Dec 2023 05:26:18 +0000
Message-ID: <DM6PR18MB2602EC1560A801724F77095ACD86A@DM6PR18MB2602.namprd18.prod.outlook.com>
References: <20231130075818.18401-1-gakula@marvell.com>
 <20231130075818.18401-2-gakula@marvell.com>
 <20231203164121.GK50400@kernel.org>
In-Reply-To: <20231203164121.GK50400@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ2FrdWxhXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctYTQ5OWUwYWMtOTI2NS0xMWVlLTk2YWEtNDhhNDcy?=
 =?us-ascii?Q?MGFkNGE3XGFtZS10ZXN0XGE0OTllMGFlLTkyNjUtMTFlZS05NmFhLTQ4YTQ3?=
 =?us-ascii?Q?MjBhZDRhN2JvZHkudHh0IiBzej0iMTM2NjIiIHQ9IjEzMzQ2MTQxMTc1NjE2?=
 =?us-ascii?Q?MjIzNSIgaD0iczQrU0pORnpTeUFFZk1XcmtnVGNTR0hjV280PSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQmdXQUFD?=
 =?us-ascii?Q?N3ZQSm1jaWJhQWJ2Tk9yNmltVkpRdTgwNnZxS1pVbEFaQUFBQUFBQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFFZ0FBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCUUFBQUFBQUFBQUFBQUFBQUVB?=
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
 =?us-ascii?Q?OEFaZ0JwQUd3QVpRQUFBQ1FBQUFBU0FBQUFaUUJ0QUdFQWFRQnNBRjhBWVFC?=
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
 =?us-ascii?Q?QWJRQnBBRzRBZFFCekFBQUFJZ0FBQUJRQUFBQnRBR0VBY2dCMkFHVUFiQUJz?=
 =?us-ascii?Q?QUY4QWR3QnZBSElBWkFBQUFBPT0iLz48L21ldGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB2602:EE_|DM4PR18MB4302:EE_
x-ms-office365-filtering-correlation-id: 2179ed82-1718-4e3e-e764-08dbf4898af0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Arz+zhhK90Mds146AVoc/Aqjga0Olg/hKwVl8Mp4ATpw4Ku0y/rl8dgHs0wHLj7iwHUkJZxGEccdccCc3ZSEKYDb0DS8C9UmcHnL+TmIZa+k7H7MM/rUJ+RGgw3iJVpn6DJnDCXg5ksNCDF+71dWOwR+yW79TiLq7g9+kkaZERDWDa/JXnbN4zCv7UoAqbTsZvIEnEKKrQAL7CoRX5jrcKNmqUwcOiqahPVQR1sknnpdxGybXe6nd6KL7A2GpMIQeCvBRA/X6kotuMZ2m8mI5H1G7yG44+7thhRmQRXj1AO+SxykibRPqNz9sdiIb6SED6ofx29XQZV3bA0kE9+y4vxGT0kTpISDUXYf/7d/JVw3IQyOtSdLjM7uP0IpBWT6ntuxYLWKz4pQVDq59+0MBXngE58hg4U7SXHrXz6thYDD3I/eWcBkrzGg0M8RnCJ7Us9w5Qi7OU7QF6iNcN7pLeDfllFUYn4ygN34Bl4jJXNmwJx1X7a229W0W5ojJx+/1BP/uyr/RS3MnJsqaJzoJYN2wZUH4w/oed9XWbW09fmWIklDkJoD/apJChpBjUlHQ4Bm+eiDWa9hJIgL6dsdiR/IjoCrcHOxSOXxx2CMLKr1q/PTiFB1jjnpiNed8DFCLeeKZfDOX0hcmRgXmkFEjmJCz9Xse3nux6TmOqI7vmE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2602.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230273577357003)(230922051799003)(230173577357003)(64100799003)(451199024)(1800799012)(186009)(66946007)(66556008)(76116006)(66476007)(66446008)(316002)(6916009)(54906003)(64756008)(38100700002)(2906002)(5660300002)(41300700001)(86362001)(33656002)(38070700009)(122000001)(4326008)(8936002)(8676002)(52536014)(9686003)(53546011)(7696005)(6506007)(83380400001)(26005)(107886003)(55016003)(71200400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W3NYvuLtS4VZOnmtFa36MZ08z4ar74XFUTTJpYLtVBbVkMGSIhLN/tbFE35N?=
 =?us-ascii?Q?c4b+8WrIaBZVz1aAlEnO3m37GwV2CYNnAH2ud5nd72xkhtXL9BqJtYOukc5+?=
 =?us-ascii?Q?qkDrwov9ku/L9mm0gb+s1VRHezIMn19ayv9fCb/gsAGGGyS8sHQzZ6erxGZC?=
 =?us-ascii?Q?mkadUXzygvVG55IIr7YlNWdFqNYPNwXiBRDaod9vNQPGbFbk+vLf5DwLX3y0?=
 =?us-ascii?Q?H4lpO3/mB+1UfpfWXVx0I3PNfY5lIw4rAZcWIYOYHompwal9eCZ6+U8P5ul8?=
 =?us-ascii?Q?ETTp071/2XCyIc7sGgJF1NGnAnUyR8YpFYGdAa4/gFg0wFoB8TYadHGb2sT5?=
 =?us-ascii?Q?mADe9m2Oj4o7UYlphkrKIPppvCiytQAJylXWcFzOeIOcy8Ekiu+YPsLGhqM/?=
 =?us-ascii?Q?NbZZlGCB0R/0arHOTSyennOES8H2YqEtRFMU05gMzab9wA6Pe0sNCHX4Pxfd?=
 =?us-ascii?Q?z4iqky0EQCD8uIU19DbI/nW6rMb2w0TjplMTXMlGQMq3dVu1LDI7adu6sXR6?=
 =?us-ascii?Q?sBbQ7WO3CHvuOygYycng3YJrRsKDRNFk6H6NHeytN/Y6T7MMzMf84K+8q1Gk?=
 =?us-ascii?Q?br2wtq5X3u9xMuONwupBNXpzJn42vPZupZj0xaW2hNU+1cS38Rn+jCKqn6LP?=
 =?us-ascii?Q?LWev/3+5FZKtd8RUPnu7vjT2GFw74yg+ByvG8/VZ2rktoP7SbRKBr9vuBXKy?=
 =?us-ascii?Q?NqG7tXuqe0NRigfE41YWRHBHNzn9gaQPm0iMEzLH+f17WLHcVUqqzHc8zrve?=
 =?us-ascii?Q?5xdtYTKBs1quiLzqICXtMEvpHkhtMYTTph60gv7sK2Nr2Rua0PLyiYcjefLD?=
 =?us-ascii?Q?EwLjVB/1b2xGdJrUpLmyNneGblvbJA639apJ6/GVJu9q68KCiU8PHuMqyyli?=
 =?us-ascii?Q?IHx/Fy2z2983ge3AdcBs0HBU1EdIur63Au69SmwVK+EbU7Hx4oGwmQ7iPq1j?=
 =?us-ascii?Q?PNE1EcpBzoYRzU5SJMsiTEtOvgWF4tcPbhbhAJc81m32PJMtkKXt0ASDHKVb?=
 =?us-ascii?Q?XMWTRU7w/FJI88LP/3Ul2u0YQBNUOsb2Tb6Zz9RbbzMoy+wOVesv/TS76OWs?=
 =?us-ascii?Q?6JobbLUKNxGf1NB1FMu+vGXIyDtAWqgA5DYnYAFjjMCYZDKrt8fgDRvdgo3B?=
 =?us-ascii?Q?pEu/AtEXLqrdFmjJD1orekyKClI7uEmH2FO/9DicWwaoDj6eXwKHbBDj8vfv?=
 =?us-ascii?Q?Ew6X7yi1QXYwQAJ/EF3KS9z7AORFJWNIaSZ/2rdEbKxdN5DLLZV4s9aqdVPD?=
 =?us-ascii?Q?ZDa6gwQAJYwceJcUay5w+7j6P2K/ZJyDyb/k2ab85dkopBXlnhFm77ddguiU?=
 =?us-ascii?Q?up34CaUB2qlBTyQvIGMiAc149BLfigKdFrpQykwmt+fHUqSucb4K7qHC07Cs?=
 =?us-ascii?Q?qrh3MbVH4xhPyvxOSylKYJk39H9PNoMHyg4g581cE17fnUcq2vKFkYHG9YUl?=
 =?us-ascii?Q?F3RagUjTh83P93tJHyyQ1LfzQ8hBYZ502bcVPI7UKkiFfRXRsXxp7Ez+Z/j7?=
 =?us-ascii?Q?Q6QE/thhOFh61MHM7jKVtYlOXAD4BpQK9VoXVF/CedPvDHre/If1SybC65H7?=
 =?us-ascii?Q?q0iJSgC2Fb86TE5JElo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2602.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2179ed82-1718-4e3e-e764-08dbf4898af0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 05:26:18.1710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QXIJspp9+SJHICLpxLQBWdMS2iwhM00gow1Md81xx4ZNeini+h47JV909S0y1yguCH4AuzhJn/juF0k3QsYHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4302
X-Proofpoint-GUID: b-Gw0IPaL7QYjFr6ZHnlk7dADoDsG1Ev
X-Proofpoint-ORIG-GUID: b-Gw0IPaL7QYjFr6ZHnlk7dADoDsG1Ev
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_03,2023-11-30_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Sunday, December 3, 2023 10:11 PM
> To: Geethasowjanya Akula <gakula@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org=
;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Linu Cherian
> <lcherian@marvell.com>; Jerin Jacob Kollanukkaran <jerinj@marvell.com>;
> Subbaraya Sundeep Bhatta <sbhatta@marvell.com>; Hariprasad Kelam
> <hkelam@marvell.com>
> Subject: [EXT] Re: [net v3 PATCH 1/5] octeontx2-af: Adjust Tx credits whe=
n
> MCS external bypass is disabled
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Thu, Nov 30, 2023 at 01:28:14PM +0530, Geetha sowjanya wrote:
> > From: Nithin Dabilpuram <ndabilpuram@marvell.com>
> >
> > When MCS external bypass is disabled, MCS returns additional
> > 2 credits(32B) for every packet Tx'ed on LMAC. To account for these
> > extra credits, NIX_AF_TX_LINKX_NORM_CREDIT.CC_MCS_CNT
> > needs to be configured as otherwise NIX Tx credits would overflow and
> > will never be returned to idle state credit count causing issues with
> > credit control and MTU change.
> >
> > This patch fixes the same by configuring CC_MCS_CNT at probe time for
> > MCS enabled SoC's
> >
> > Fixes: bd69476e86fc ("octeontx2-af: cn10k: mcs: Install a default TCAM
> > for normal traffic")
> > Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> > Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> > Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>=20
> Hi Geetha and Nithin,
>=20
> some minor feedback from my side.
>=20
> > ---
> >  drivers/net/ethernet/marvell/octeontx2/af/mcs.c     | 12 ++++++++++++
> >  drivers/net/ethernet/marvell/octeontx2/af/mcs.h     |  2 ++
> >  drivers/net/ethernet/marvell/octeontx2/af/rvu.h     |  1 +
> >  drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c |  8 ++++++++
> >  4 files changed, 23 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> > b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> > index c43f19dfbd74..d6effbe46208 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> > @@ -1219,6 +1219,17 @@ struct mcs *mcs_get_pdata(int mcs_id)
> >  	return NULL;
> >  }
> >
> > +bool is_mcs_bypass(int mcs_id)
> > +{
> > +	struct mcs *mcs_dev;
> > +
> > +	list_for_each_entry(mcs_dev, &mcs_list, mcs_list) {
> > +		if (mcs_dev->mcs_id =3D=3D mcs_id)
> > +			return mcs_dev->bypass;
> > +	}
> > +	return true;
> > +}
> > +
> >  void mcs_set_port_cfg(struct mcs *mcs, struct mcs_port_cfg_set_req
> > *req)  {
> >  	u64 val =3D 0;
> > @@ -1447,6 +1458,7 @@ static void mcs_set_external_bypass(struct mcs
> *mcs, u8 bypass)
> >  	else
> >  		val &=3D ~BIT_ULL(6);
> >  	mcs_reg_write(mcs, MCSX_MIL_GLOBAL, val);
> > +	mcs->bypass =3D bypass;
>=20
> I think that bool would be a more appropriate type than u8 for:
>=20
> * The bypass parameter of mcs_set_external_bypass()
> * The bypass field of struct mcs
>=20
> >  }
> >
> >  static void mcs_global_cfg(struct mcs *mcs) diff --git
> > a/drivers/net/ethernet/marvell/octeontx2/af/mcs.h
> > b/drivers/net/ethernet/marvell/octeontx2/af/mcs.h
> > index 0f89dcb76465..ccd43c3f3460 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.h
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.h
> > @@ -149,6 +149,7 @@ struct mcs {
> >  	u16			num_vec;
> >  	void			*rvu;
> >  	u16			*tx_sa_active;
> > +	u8                      bypass;
> >  };
> >
> >  struct mcs_ops {
> > @@ -206,6 +207,7 @@ void mcs_get_custom_tag_cfg(struct mcs *mcs,
> > struct mcs_custom_tag_cfg_get_req *  int mcs_alloc_ctrlpktrule(struct
> > rsrc_bmap *rsrc, u16 *pf_map, u16 offset, u16 pcifunc);  int
> > mcs_free_ctrlpktrule(struct mcs *mcs, struct
> > mcs_free_ctrl_pkt_rule_req *req);  int mcs_ctrlpktrule_write(struct
> > mcs *mcs, struct mcs_ctrl_pkt_rule_write_req *req);
> > +bool is_mcs_bypass(int mcs_id);
> >
> >  /* CN10K-B APIs */
> >  void cn10kb_mcs_set_hw_capabilities(struct mcs *mcs); diff --git
> > a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> > b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> > index c4d999ef5ab4..9887edccadf7 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> > @@ -345,6 +345,7 @@ struct nix_hw {
> >  	struct nix_txvlan txvlan;
> >  	struct nix_ipolicer *ipolicer;
> >  	u64    *tx_credits;
> > +	u64 cc_mcs_cnt;
> >  };
> >
> >  /* RVU block's capabilities or functionality, diff --git
> > a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > index c112c71ff576..daafce5fef46 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > @@ -12,6 +12,7 @@
> >  #include "rvu_reg.h"
> >  #include "rvu.h"
> >  #include "npc.h"
> > +#include "mcs.h"
> >  #include "cgx.h"
> >  #include "lmac_common.h"
> >  #include "rvu_npc_hash.h"
> > @@ -4389,6 +4390,12 @@ static void nix_link_config(struct rvu *rvu, int
> blkaddr,
> >  			    SDP_HW_MAX_FRS << 16 | NIC_HW_MIN_FRS);
> >  	}
> >
> > +	/* Get MCS external bypass status for CN10K-B */
> > +	if (mcs_get_blkcnt() =3D=3D 1) {
> > +		/* Adjust for 2 credits when external bypass is disabled */
> > +		nix_hw->cc_mcs_cnt =3D is_mcs_bypass(0) ? 0 : 2;
>=20
> Perhaps it doesn't matter, but to me it seems a bit excessive to use a 64=
-bit
> field to store such small values.
>=20
> > +	}
> > +
> >  	/* Set credits for Tx links assuming max packet length allowed.
> >  	 * This will be reconfigured based on MTU set for PF/VF.
> >  	 */
> > @@ -4412,6 +4419,7 @@ static void nix_link_config(struct rvu *rvu, int
> blkaddr,
> >  			tx_credits =3D (lmac_fifo_len - lmac_max_frs) / 16;
> >  			/* Enable credits and set credit pkt count to max
> allowed */
> >  			cfg =3D  (tx_credits << 12) | (0x1FF << 2) | BIT_ULL(1);
> > +			cfg |=3D (nix_hw->cc_mcs_cnt << 32);
>=20
> I do see that cc_mcs_cnt needs to be 64-bit here to avoid truncation.
> But overall I think this function could benefit from the use of FIELD_PRE=
P(),
> which I think would side-step that problem.
Thanks for the feedback. Will submit next version with the suggested change=
s.
>=20
> >
> >  			link =3D iter + slink;
> >  			nix_hw->tx_credits[link] =3D tx_credits;
> > --
> > 2.25.1
> >
