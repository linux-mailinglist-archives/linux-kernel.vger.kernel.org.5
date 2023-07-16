Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA6F75504F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 20:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjGPSZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 14:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjGPSZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 14:25:27 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA15E5D;
        Sun, 16 Jul 2023 11:25:22 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36GH0GHR021589;
        Sun, 16 Jul 2023 11:25:13 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rus6datxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jul 2023 11:25:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvoRXJrIMyCDlEly1th4FgiFfYUJdeZaZHE6jIpIf+BKtc5ttM9KCMFTFlxcJj92ckxrhpg8rMTgFOBjsjS90gRJHxTuPkoE/8TjLS5t7nk00BBd6Wz6HsLfDZNyrQMFta/J/tPdk8EPJOGdIhKB8K6R8u1CF6fhzJKJZurz/6oVx+1fqToy8b1hOSPSZX0w1mxoI/jYCnninVI2cDS1PWe2q4HLlV2f32s9pNj05c4Qt5slx//IvEhFBUS3Us765SYmHDBe80bx14wylFPmcJkM40KtE4TIKd+gUtvvC61JYQLuh6O5EB+Zj/JlaD1WyLnnEwo5B5xLKg+I6Gj/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwI4mFCRahz9EEfTzPuAleY0op62qUoGlmDGYAFuujU=;
 b=bHKsGnpNNW18/QjS9kaPHVbCV4Z3eaiZg0Igc8DM797vJBdjSmGpXnDhX0CelWrW35YJX7u139BVX9otFo2jFOnTQhUc0zaR66PQgZwZu3uRS7FPWbUiUq3b5ySjgykpwWkEucNKl/AUQp1TwYeO8oUA94RvAa8j84Ju8/iiPOgu5RZHkWpjTxYEU9jp43u25kpj/Jdp3pRXK1xI51+UozdPssfOGNRPm/tIYffKvgRlGQ7fYgRmQZ2yfeuUXms+8wp6SEa+fn0wNJhn0kijoLHLpT7H5v1Qm/hWMtwc+fD5v0Ubky+v3ZEKSbuFPAFeV3cDERYQCOUhewm2KGrSIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwI4mFCRahz9EEfTzPuAleY0op62qUoGlmDGYAFuujU=;
 b=PL0yXFqAkCLOSX2t2PXeGG14/dSiSgik0JeL7XcB1if2++g6hV8kzwPJkP39rcIRuN/B8iPPS2JF9wo5TdzMd4L7IRPI3Ghxp2kkUEUudyiBU0wtAjnNH6+My3nWcG2HshLYLwehp+02DDgLwRbgVwqIRa7AJfkBuQSCyG7LnGM=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by BN9PR18MB4265.namprd18.prod.outlook.com (2603:10b6:408:11a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Sun, 16 Jul
 2023 18:25:09 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::d194:dd3d:5ef:83ec]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::d194:dd3d:5ef:83ec%4]) with mapi id 15.20.6588.030; Sun, 16 Jul 2023
 18:25:09 +0000
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
Subject: RE: [EXT] Re: [net-next PATCH] octeontx2-pf: Install TC filter rules
 in hardware based on priority
Thread-Topic: [EXT] Re: [net-next PATCH] octeontx2-pf: Install TC filter rules
 in hardware based on priority
Thread-Index: AQHZtPBS4nYd3iKGS0CGQCKuEzAze6+6fs4AgAI34mA=
Date:   Sun, 16 Jul 2023 18:25:08 +0000
Message-ID: <SJ0PR18MB52168A23B94BBE005F159460DB3AA@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20230712184011.2409691-1-sumang@marvell.com>
 <ZLJVVh6BMRqaZZpU@corigine.com>
In-Reply-To: <ZLJVVh6BMRqaZZpU@corigine.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3VtYW5nXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctMTU5YWFhNzctMjQwNi0xMWVlLWI2ZGUtODQxNDRk?=
 =?us-ascii?Q?ZWVhNTRjXGFtZS10ZXN0XDE1OWFhYTc4LTI0MDYtMTFlZS1iNmRlLTg0MTQ0?=
 =?us-ascii?Q?ZGVlYTU0Y2JvZHkudHh0IiBzej0iMjQyMTgiIHQ9IjEzMzM0MDA1NTA1ODMz?=
 =?us-ascii?Q?MDQ3NiIgaD0iYUNKWXQ3YUN2aG5uQTBONDBzdDdidWJGQ3VjPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBTjRQQUFC?=
 =?us-ascii?Q?c014WFlFcmpaQWN5dW9OajZnQ3Nieks2ZzJQcUFLeHNaQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQnVEd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFFQkFBQUFJN3FUcEFDQUFRQUFBQUFBQUFBQUFKNEFBQUJoQUdRQVpB?=
 =?us-ascii?Q?QnlBR1VBY3dCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHTUFkUUJ6QUhRQWJ3QnRBRjhBY0FC?=
 =?us-ascii?Q?bEFISUFjd0J2QUc0QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFDTUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQSIvPjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|BN9PR18MB4265:EE_
x-ms-office365-filtering-correlation-id: 7d750f22-490b-4913-3f2b-08db8629fc57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h8pblBp4GuALZq1NWDbj2mZbDrZMh93ufb3PgqvPfx+7N3fzG7xJ/nCFqBO5v0EApbkPdi2gokzpRYHAEmJ1dceh7ONooqRlgwiMZQLK/HxEUcHY4NsZbIxgSHGG8coVtW4vypTkeRG1BFaYv+ZthKFSePmEaBPxOIgcfyR++6rMJIDImty/nuEeYFw6/qltWTDc0f1oNlvk0kLL1306eb2phOJyG1lJKjOWAcDZmhH1iZOXI5defndOqyehWhZhiU2Ns3/0ZEYseFwdblzlHzOQ9rJmwMRmbTlnOdva2STaYubBhjlhHTFfyVMESEvuyIWwPUtJaGsQUReoDMaOMFY4adHubogX4VpV7QMlikoFTbjvAjiQYUyYrpxw0Cgx9NRDB1kJclT1ZQvp+P9KPQ1EAS2FE69dxAHfDvlkQwatM7nG8PKrBxi0zSri76tRn8GnTrRHxBFZle516e90tjl9sZQIk/+9jhxz9V83ZQQgBgBYznAvTkdWKsR6l4wSaaXCCDaMLPjGk4CSY8XFqS0wj8fO+f9eIjUks6sWLMXEosG7BIfWeKM5eQnlZ8U3STVPLKlUBYWnOsDLL64fQYaWGiHQVce5W5gJmOrFoZIh6lb+cmMym2Wt4lPT+f1t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39850400004)(451199021)(55016003)(54906003)(122000001)(38100700002)(7696005)(478600001)(41300700001)(8676002)(5660300002)(71200400001)(52536014)(8936002)(66556008)(316002)(66946007)(66476007)(64756008)(6916009)(66446008)(76116006)(4326008)(186003)(83380400001)(9686003)(26005)(6506007)(86362001)(33656002)(38070700005)(30864003)(2906002)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WKoojIdKfG5RKt+I2R0F6W9PKc/VzhSp7aipDxZtKhtgygwKj0KK6QoFLuQV?=
 =?us-ascii?Q?AOu/OtEmDm0BEPjrHKz+amBa3Oxxeefn+iTs3Z16NUOwAhee1uJNuVw/WOCR?=
 =?us-ascii?Q?EwVG+2SREy3q3ny5QBtqNWGOIcuLVrkVN0h5Nl23QyFKkAwptbqeX1OTiBPt?=
 =?us-ascii?Q?YjV9RBsOoTa1f5mc5JVSfv+gkA2tqdCBiYbDQWfuYy2rJgjQbob5NHzMwxBA?=
 =?us-ascii?Q?J7f/kEXIxcG3y+SzubmsucHFfpd40ycjsivmQfz1QRpWs/chZBPDcWQzrsce?=
 =?us-ascii?Q?N+838JjIKUyqVsGwZE64I8qAhUWsHwq/cM3RKYOLpf1GmoBqytP6MnLh89GO?=
 =?us-ascii?Q?jo+k+K/M9yaBCpw2B+sFORVwFMTx9KaAwuuerUl8T/BsdwVPEkrT0rgiOqrV?=
 =?us-ascii?Q?EaT28/QmGIiF9JfVwAGW9CCfOeVpxSY8dx/NTZ+v/NbQq+FZ1iwDe/vjVFNI?=
 =?us-ascii?Q?Y/pweaC+nv+Wb7jySGfeNoUCwrhMkx+7zRlqi2nHpq/BVlxP31q8I4JuSmG2?=
 =?us-ascii?Q?cJDuWaXyblbmG4OnfP5L5GQ+oRXAev0RwR/mYmJAZ1A0AYaQeaMTOGJnk8D4?=
 =?us-ascii?Q?TZdutU6NnpeJZo7VsPrp+2/L7oLReCku35gFaxIriN/R7BrKJiVh6SIpMl7w?=
 =?us-ascii?Q?5bxeI7RJETXxZn8tCKjvCUEwZIZdLQ4kJ7QWS+BH6X9RakiQzXykjHhWtn54?=
 =?us-ascii?Q?KEVi5kGCF35SvIjISsVj4YwHAvsBaP8Rb+TcyY0JfLvZ4osIfoX/NuXzuCUI?=
 =?us-ascii?Q?mRe1Tt5QCpTGd9FEiIf9mKN0cbv0rYo90xhSOh2ItzCDk4wIRnVQx/VwYQqe?=
 =?us-ascii?Q?xgxHMBZRQ2qXkXCGrpxy+G/mTYIx8rw5B+B8eud2ysnP9NToIU+wl24BA40J?=
 =?us-ascii?Q?zerDuasbk8w36xg2ikOgt8qun2lPHoG5pd6Dg1Naziwtc7jFH4+Ya1mgO4He?=
 =?us-ascii?Q?C08vnYrRgext6vy1EzKSqiO/gUfs0/Ky9TEKgit75MPZ1JBiUlYcgfi3dLZa?=
 =?us-ascii?Q?90PsKubGfJDGcS61oBbY+k06MeH0yv8wFCCh2iiUg3Aww7PDdxpisNavJ9c4?=
 =?us-ascii?Q?u9vKeQlgWkHAi+dLcnTjhmNtJ5W08WV3b3pFyhxsj/PKaGMYI7OGk+6koaFQ?=
 =?us-ascii?Q?huJxyAzIDbenIMHeUTv8y/CNV5TWOtKG1RjoveeY5xZmo3uhZ3t7AYi5NXQB?=
 =?us-ascii?Q?rPgXfC38vdS7wBziRsU3X75Wod1Ky3U9W+UThxUH+2VMTWOl78d/A+3i0/Kz?=
 =?us-ascii?Q?f3umtQqsaZYPM4ADRw1IACJ/K6KYlHP3yg6ALjhsey7PukNJY7vdACD26UgE?=
 =?us-ascii?Q?4oNVcfFxapwYBO5tEZpOVCf+ZabpbejR9dzQfwDp18/EnJnP27leSwnaRvFC?=
 =?us-ascii?Q?omX6JPjTwUAzpCEc6TVE26G/JfvDc6MFHR3+7srpr1X7O2yR3rk6Meu3T9d/?=
 =?us-ascii?Q?gprtVM//9BP6qPEiChV/xcAyF8w0OokLN4a8hIVu67QJJP9SjtCQlfa3CYFW?=
 =?us-ascii?Q?n1beson2a0jBDnFcOk1T7oyfXWmqGRD7+6gd4pWRT2zaSflPCH7sZRydHyeM?=
 =?us-ascii?Q?KIU/GhxOe0vohG+zFjM31pzcS4/RzXQ4QK3U+DZa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d750f22-490b-4913-3f2b-08db8629fc57
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2023 18:25:08.7954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPXNQyCVzH2hUQFig/h8JB71Xw/9HpAxtCmZMVJL7F1A0Gzj5aD8RLDtu73uzBnAEvXmGjCqNod74/VgtpH7Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4265
X-Proofpoint-GUID: pgJ355kV1iVKc8kfR1Ih3J_0FyQl0lBD
X-Proofpoint-ORIG-GUID: pgJ355kV1iVKc8kfR1Ih3J_0FyQl0lBD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-16_05,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi Suman,
>
>unfortunately this patch does not appear to apply to net-next, which
>breaks our processes.
>
>Please consider posting a v2 rebased on net-next.
>
>Thanks!
[Suman] Sure Simon, will push v2.
>
>> ---
>>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |   9 +-
>>  .../marvell/octeontx2/af/rvu_npc_fs.c         |  10 +-
>>  .../marvell/octeontx2/af/rvu_switch.c         |   6 +-
>>  .../marvell/octeontx2/nic/otx2_common.h       |  11 +-
>>  .../marvell/octeontx2/nic/otx2_devlink.c      |   1 -
>>  .../marvell/octeontx2/nic/otx2_flows.c        |   2 +
>>  .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 315
>> +++++++++++++-----
>>  7 files changed, 251 insertions(+), 103 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
>> b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
>> index 8d5d5a0f68c4..ba6e249ee1df 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
>> @@ -231,7 +231,7 @@ M(NPC_GET_KEX_CFG,	  0x600c, npc_get_kex_cfg,
>		\
>>  M(NPC_INSTALL_FLOW,	  0x600d, npc_install_flow,			       \
>>  				  npc_install_flow_req, npc_install_flow_rsp)  \
>>  M(NPC_DELETE_FLOW,	  0x600e, npc_delete_flow,			\
>> -				  npc_delete_flow_req, msg_rsp)		\
>> +				  npc_delete_flow_req, npc_delete_flow_rsp)	\
>>  M(NPC_MCAM_READ_ENTRY,	  0x600f, npc_mcam_read_entry,
>	\
>>  				  npc_mcam_read_entry_req,		\
>>  				  npc_mcam_read_entry_rsp)		\
>> @@ -1467,6 +1467,8 @@ struct npc_install_flow_req {
>>  	u8  vtag0_op;
>>  	u16 vtag1_def;
>>  	u8  vtag1_op;
>> +	/* old counter value */
>> +	u16 cntr_val;
>>  };
>>
>>  struct npc_install_flow_rsp {
>> @@ -1482,6 +1484,11 @@ struct npc_delete_flow_req {
>>  	u8 all; /* PF + VFs */
>>  };
>>
>> +struct npc_delete_flow_rsp {
>> +	struct mbox_msghdr hdr;
>> +	u16 cntr_val;
>> +};
>> +
>>  struct npc_mcam_read_entry_req {
>>  	struct mbox_msghdr hdr;
>>  	u16 entry;	 /* MCAM entry to read */
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
>> b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
>> index 50d3994efa97..e016669bc327 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
>> @@ -1148,7 +1148,7 @@ static int npc_install_flow(struct rvu *rvu, int
>blkaddr, u16 target,
>>  	write_req.enable_entry =3D (u8)enable;
>>  	/* if counter is available then clear and use it */
>>  	if (req->set_cntr && rule->has_cntr) {
>> -		rvu_write64(rvu, blkaddr, NPC_AF_MATCH_STATX(rule->cntr),
>0x00);
>> +		rvu_write64(rvu, blkaddr, NPC_AF_MATCH_STATX(rule->cntr),
>> +req->cntr_val);
>>  		write_req.set_cntr =3D 1;
>>  		write_req.cntr =3D rule->cntr;
>>  	}
>> @@ -1362,12 +1362,13 @@ static int npc_delete_flow(struct rvu *rvu,
>> struct rvu_npc_mcam_rule *rule,
>>
>>  int rvu_mbox_handler_npc_delete_flow(struct rvu *rvu,
>>  				     struct npc_delete_flow_req *req,
>> -				     struct msg_rsp *rsp)
>> +				     struct npc_delete_flow_rsp *rsp)
>>  {
>>  	struct npc_mcam *mcam =3D &rvu->hw->mcam;
>>  	struct rvu_npc_mcam_rule *iter, *tmp;
>>  	u16 pcifunc =3D req->hdr.pcifunc;
>>  	struct list_head del_list;
>> +	int blkaddr;
>>
>>  	INIT_LIST_HEAD(&del_list);
>>
>> @@ -1383,6 +1384,11 @@ int rvu_mbox_handler_npc_delete_flow(struct rvu
>*rvu,
>>  				list_move_tail(&iter->list, &del_list);
>>  			/* single rule */
>>  			} else if (req->entry =3D=3D iter->entry) {
>> +				blkaddr =3D rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
>> +				if (blkaddr)
>> +					rsp->cntr_val =3D rvu_read64(rvu, blkaddr,
>> +								   NPC_AF_MATCH_STATX(iter-
>>cntr));
>> +
>>  				list_move_tail(&iter->list, &del_list);
>>  				break;
>>  			}
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
>> b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
>> index 3392487f6b47..329b5a02914d 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
>> @@ -145,6 +145,7 @@ void rvu_switch_enable(struct rvu *rvu)
>>  	struct npc_mcam_alloc_entry_req alloc_req =3D { 0 };
>>  	struct npc_mcam_alloc_entry_rsp alloc_rsp =3D { 0 };
>>  	struct npc_delete_flow_req uninstall_req =3D { 0 };
>> +	struct npc_delete_flow_rsp uninstall_rsp =3D { 0 };
>>  	struct npc_mcam_free_entry_req free_req =3D { 0 };
>>  	struct rvu_switch *rswitch =3D &rvu->rswitch;
>>  	struct msg_rsp rsp;
>> @@ -184,7 +185,7 @@ void rvu_switch_enable(struct rvu *rvu)
>>  uninstall_rules:
>>  	uninstall_req.start =3D rswitch->start_entry;
>>  	uninstall_req.end =3D  rswitch->start_entry + rswitch->used_entries -
>1;
>> -	rvu_mbox_handler_npc_delete_flow(rvu, &uninstall_req, &rsp);
>> +	rvu_mbox_handler_npc_delete_flow(rvu, &uninstall_req,
>> +&uninstall_rsp);
>>  	kfree(rswitch->entry2pcifunc);
>>  free_entries:
>>  	free_req.all =3D 1;
>> @@ -196,6 +197,7 @@ void rvu_switch_enable(struct rvu *rvu)  void
>> rvu_switch_disable(struct rvu *rvu)  {
>>  	struct npc_delete_flow_req uninstall_req =3D { 0 };
>> +	struct npc_delete_flow_rsp uninstall_rsp =3D { 0 };
>>  	struct npc_mcam_free_entry_req free_req =3D { 0 };
>>  	struct rvu_switch *rswitch =3D &rvu->rswitch;
>>  	struct rvu_hwinfo *hw =3D rvu->hw;
>> @@ -232,7 +234,7 @@ void rvu_switch_disable(struct rvu *rvu)
>>  	uninstall_req.start =3D rswitch->start_entry;
>>  	uninstall_req.end =3D  rswitch->start_entry + rswitch->used_entries -
>1;
>>  	free_req.all =3D 1;
>> -	rvu_mbox_handler_npc_delete_flow(rvu, &uninstall_req, &rsp);
>> +	rvu_mbox_handler_npc_delete_flow(rvu, &uninstall_req,
>> +&uninstall_rsp);
>>  	rvu_mbox_handler_npc_mcam_free_entry(rvu, &free_req, &rsp);
>>  	rswitch->used_entries =3D 0;
>>  	kfree(rswitch->entry2pcifunc);
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
>> b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
>> index 282db6fe3b08..6f1ff03cdc77 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
>> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
>> @@ -337,13 +337,8 @@ struct otx2_flow_config {
>>  	u32			*bmap_to_dmacindex;
>>  	unsigned long		*dmacflt_bmap;
>>  	struct list_head	flow_list;
>> -};
>> -
>> -struct otx2_tc_info {
>> -	/* hash table to store TC offloaded flows */
>> -	struct rhashtable		flow_table;
>> -	struct rhashtable_params	flow_ht_params;
>> -	unsigned long			*tc_entries_bitmap;
>> +	struct list_head	flow_list_tc;
>> +	bool			ntuple;
>>  };
>>
>>  struct dev_hw_ops {
>> @@ -463,7 +458,6 @@ struct otx2_nic {
>>  	/* NPC MCAM */
>>  	struct otx2_flow_config	*flow_cfg;
>>  	struct otx2_mac_table	*mac_table;
>> -	struct otx2_tc_info	tc_info;
>>
>>  	u64			reset_count;
>>  	struct work_struct	reset_task;
>> @@ -1001,7 +995,6 @@ int otx2_init_tc(struct otx2_nic *nic);  void
>> otx2_shutdown_tc(struct otx2_nic *nic);  int otx2_setup_tc(struct
>> net_device *netdev, enum tc_setup_type type,
>>  		  void *type_data);
>> -int otx2_tc_alloc_ent_bitmap(struct otx2_nic *nic);
>>  /* CGX/RPM DMAC filters support */
>>  int otx2_dmacflt_get_max_cnt(struct otx2_nic *pf);  int
>> otx2_dmacflt_add(struct otx2_nic *pf, const u8 *mac, u32 bit_pos);
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
>> b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
>> index 777a27047c8e..5f71a72f95e5 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
>> @@ -41,7 +41,6 @@ static int otx2_dl_mcam_count_set(struct devlink
>*devlink, u32 id,
>>  		return 0;
>>
>>  	otx2_alloc_mcam_entries(pfvf, ctx->val.vu16);
>> -	otx2_tc_alloc_ent_bitmap(pfvf);
>>
>>  	return 0;
>>  }
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
>> b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
>> index 709fc0114fbd..70c3ae2caddd 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
>> @@ -253,6 +253,7 @@ int otx2vf_mcam_flow_init(struct otx2_nic *pfvf)
>>
>>  	flow_cfg =3D pfvf->flow_cfg;
>>  	INIT_LIST_HEAD(&flow_cfg->flow_list);
>> +	INIT_LIST_HEAD(&flow_cfg->flow_list_tc);
>>  	flow_cfg->max_flows =3D 0;
>>
>>  	return 0;
>> @@ -275,6 +276,7 @@ int otx2_mcam_flow_init(struct otx2_nic *pf)
>>  		return -ENOMEM;
>>
>>  	INIT_LIST_HEAD(&pf->flow_cfg->flow_list);
>> +	INIT_LIST_HEAD(&pf->flow_cfg->flow_list_tc);
>>
>>  	/* Allocate bare minimum number of MCAM entries needed for
>>  	 * unicast and ntuple filters.
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
>> b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
>> index e64318c110fd..070210e86778 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
>> @@ -48,9 +48,8 @@ struct otx2_tc_flow_stats {  };
>>
>>  struct otx2_tc_flow {
>> -	struct rhash_head		node;
>> +	struct list_head		list;
>>  	unsigned long			cookie;
>> -	unsigned int			bitpos;
>>  	struct rcu_head			rcu;
>>  	struct otx2_tc_flow_stats	stats;
>>  	spinlock_t			lock; /* lock for stats */
>> @@ -58,31 +57,10 @@ struct otx2_tc_flow {
>>  	u16				entry;
>>  	u16				leaf_profile;
>>  	bool				is_act_police;
>> +	u32				prio;
>> +	struct npc_install_flow_req	req;
>>  };
>>
>> -int otx2_tc_alloc_ent_bitmap(struct otx2_nic *nic) -{
>> -	struct otx2_tc_info *tc =3D &nic->tc_info;
>> -
>> -	if (!nic->flow_cfg->max_flows)
>> -		return 0;
>> -
>> -	/* Max flows changed, free the existing bitmap */
>> -	kfree(tc->tc_entries_bitmap);
>> -
>> -	tc->tc_entries_bitmap =3D
>> -			kcalloc(BITS_TO_LONGS(nic->flow_cfg->max_flows),
>> -				sizeof(long), GFP_KERNEL);
>> -	if (!tc->tc_entries_bitmap) {
>> -		netdev_err(nic->netdev,
>> -			   "Unable to alloc TC flow entries bitmap\n");
>> -		return -ENOMEM;
>> -	}
>> -
>> -	return 0;
>> -}
>> -EXPORT_SYMBOL(otx2_tc_alloc_ent_bitmap);
>> -
>>  static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32
>burst,
>>  				      u32 *burst_exp, u32 *burst_mantissa)  { @@ -
>674,8 +652,119
>> @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct
>otx2_tc_flow *node,
>>  	return otx2_tc_parse_actions(nic, &rule->action, req, f, node);  }
>>
>> -static int otx2_del_mcam_flow_entry(struct otx2_nic *nic, u16 entry)
>> +static void otx2_destroy_tc_flow_list(struct otx2_nic *pfvf) {
>> +	struct otx2_flow_config *flow_cfg =3D pfvf->flow_cfg;
>> +	struct otx2_tc_flow *iter, *tmp;
>> +
>> +	if (!(pfvf->flags & OTX2_FLAG_MCAM_ENTRIES_ALLOC))
>> +		return;
>> +
>> +	list_for_each_entry_safe(iter, tmp, &flow_cfg->flow_list_tc, list)
>{
>> +		list_del(&iter->list);
>> +		kfree(iter);
>> +		flow_cfg->nr_flows--;
>> +	}
>> +}
>> +
>> +static struct otx2_tc_flow *otx2_tc_get_entry_by_cookie(struct
>otx2_flow_config *flow_cfg,
>> +							unsigned long cookie)
>> +{
>> +	struct otx2_tc_flow *tmp;
>> +
>> +	list_for_each_entry(tmp, &flow_cfg->flow_list_tc, list) {
>> +		if (tmp->cookie =3D=3D cookie)
>> +			return tmp;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static struct otx2_tc_flow *otx2_tc_get_entry_by_index(struct
>otx2_flow_config *flow_cfg,
>> +						       int index)
>> +{
>> +	struct otx2_tc_flow *tmp;
>> +	int i =3D 0;
>> +
>> +	list_for_each_entry(tmp, &flow_cfg->flow_list_tc, list) {
>> +		if (i =3D=3D index)
>> +			return tmp;
>> +
>> +		i++;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static void otx2_tc_del_from_flow_list(struct otx2_flow_config
>*flow_cfg,
>> +				       struct otx2_tc_flow *node)
>>  {
>> +	struct list_head *pos, *n;
>> +	struct otx2_tc_flow *tmp;
>> +
>> +	list_for_each_safe(pos, n, &flow_cfg->flow_list_tc) {
>> +		tmp =3D list_entry(pos, struct otx2_tc_flow, list);
>> +		if (node =3D=3D tmp) {
>> +			list_del(&node->list);
>> +			return;
>> +		}
>> +	}
>> +}
>> +
>> +static int otx2_tc_add_to_flow_list(struct otx2_flow_config
>*flow_cfg,
>> +				    struct otx2_tc_flow *node)
>> +{
>> +	struct list_head *pos, *n;
>> +	struct otx2_tc_flow *tmp;
>> +	int index =3D 0;
>> +
>> +	/* If the flow list is empty then add the new node */
>> +	if (list_empty(&flow_cfg->flow_list_tc)) {
>> +		list_add(&node->list, &flow_cfg->flow_list_tc);
>> +		return index;
>> +	}
>> +
>> +	list_for_each_safe(pos, n, &flow_cfg->flow_list_tc) {
>> +		tmp =3D list_entry(pos, struct otx2_tc_flow, list);
>> +		if (node->prio < tmp->prio)
>> +			break;
>> +
>> +		index++;
>> +	}
>> +
>> +	list_add(&node->list, pos->prev);
>> +	return index;
>> +}
>> +
>> +static int otx2_add_mcam_flow_entry(struct otx2_nic *nic, struct
>> +npc_install_flow_req *req) {
>> +	struct npc_install_flow_req *tmp_req;
>> +	int err;
>> +
>> +	mutex_lock(&nic->mbox.lock);
>> +	tmp_req =3D otx2_mbox_alloc_msg_npc_install_flow(&nic->mbox);
>> +	if (!tmp_req) {
>> +		mutex_unlock(&nic->mbox.lock);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	memcpy(tmp_req, req, sizeof(struct npc_install_flow_req));
>> +	/* Send message to AF */
>> +	err =3D otx2_sync_mbox_msg(&nic->mbox);
>> +	if (err) {
>> +		netdev_err(nic->netdev, "Failed to install MCAM flow entry
>%d\n",
>> +			   req->entry);
>> +		mutex_unlock(&nic->mbox.lock);
>> +		return -EFAULT;
>> +	}
>> +
>> +	mutex_unlock(&nic->mbox.lock);
>> +	return 0;
>> +}
>> +
>> +static int otx2_del_mcam_flow_entry(struct otx2_nic *nic, u16 entry,
>> +u16 *cntr_val) {
>> +	struct npc_delete_flow_rsp __maybe_unused *rsp;
>>  	struct npc_delete_flow_req *req;
>>  	int err;
>>
>> @@ -696,22 +785,107 @@ static int otx2_del_mcam_flow_entry(struct
>otx2_nic *nic, u16 entry)
>>  		mutex_unlock(&nic->mbox.lock);
>>  		return -EFAULT;
>>  	}
>> +
>> +	if (cntr_val) {
>> +		rsp =3D (struct npc_delete_flow_rsp *)otx2_mbox_get_rsp(&nic-
>>mbox.mbox,
>> +								      0, &req->hdr);
>> +		*cntr_val =3D rsp->cntr_val;
>> +	}
>> +
>>  	mutex_unlock(&nic->mbox.lock);
>>
>>  	return 0;
>>  }
>>
>> +static int otx2_tc_update_mcam_table_del_req(struct otx2_nic *nic,
>> +					     struct otx2_flow_config *flow_cfg,
>> +					     struct otx2_tc_flow *node)
>> +{
>> +	struct list_head *pos, *n;
>> +	struct otx2_tc_flow *tmp;
>> +	int i =3D 0, index =3D 0;
>> +	u16 cntr_val;
>> +
>> +	/* Find and delete the entry from the list and re-install
>> +	 * all the entries from beginning to the index of the
>> +	 * deleted entry to higher mcam indexes.
>> +	 */
>> +	list_for_each_safe(pos, n, &flow_cfg->flow_list_tc) {
>> +		tmp =3D list_entry(pos, struct otx2_tc_flow, list);
>> +		if (node =3D=3D tmp) {
>> +			list_del(&tmp->list);
>> +			break;
>> +		}
>> +
>> +		otx2_del_mcam_flow_entry(nic, tmp->entry, &cntr_val);
>> +		tmp->entry++;
>> +		tmp->req.entry =3D tmp->entry;
>> +		tmp->req.cntr_val =3D cntr_val;
>> +		index++;
>> +	}
>> +
>> +	list_for_each_safe(pos, n, &flow_cfg->flow_list_tc) {
>> +		if (i =3D=3D index)
>> +			break;
>> +
>> +		tmp =3D list_entry(pos, struct otx2_tc_flow, list);
>> +		otx2_add_mcam_flow_entry(nic, &tmp->req);
>> +		i++;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int otx2_tc_update_mcam_table_add_req(struct otx2_nic *nic,
>> +					     struct otx2_flow_config *flow_cfg,
>> +					     struct otx2_tc_flow *node)
>> +{
>> +	int mcam_idx =3D flow_cfg->max_flows - flow_cfg->nr_flows - 1;
>> +	struct otx2_tc_flow *tmp;
>> +	int list_idx, i;
>> +	u16 cntr_val;
>> +
>> +	/* Find the index of the entry(list_idx) whose priority
>> +	 * is greater than the new entry and re-install all
>> +	 * the entries from beginning to list_idx to higher
>> +	 * mcam indexes.
>> +	 */
>> +	list_idx =3D otx2_tc_add_to_flow_list(flow_cfg, node);
>> +	for (i =3D 0; i < list_idx; i++) {
>> +		tmp =3D otx2_tc_get_entry_by_index(flow_cfg, i);
>> +		if (!tmp)
>> +			return -ENOMEM;
>> +
>> +		otx2_del_mcam_flow_entry(nic, tmp->entry, &cntr_val);
>> +		tmp->entry =3D flow_cfg->flow_ent[mcam_idx];
>> +		tmp->req.entry =3D tmp->entry;
>> +		tmp->req.cntr_val =3D cntr_val;
>> +		otx2_add_mcam_flow_entry(nic, &tmp->req);
>> +		mcam_idx++;
>> +	}
>> +
>> +	return mcam_idx;
>> +}
>> +
>> +static int otx2_tc_update_mcam_table(struct otx2_nic *nic,
>> +				     struct otx2_flow_config *flow_cfg,
>> +				     struct otx2_tc_flow *node,
>> +				     bool add_req)
>> +{
>> +	if (add_req)
>> +		return otx2_tc_update_mcam_table_add_req(nic, flow_cfg, node);
>> +
>> +	return otx2_tc_update_mcam_table_del_req(nic, flow_cfg, node); }
>> +
>>  static int otx2_tc_del_flow(struct otx2_nic *nic,
>>  			    struct flow_cls_offload *tc_flow_cmd)  {
>>  	struct otx2_flow_config *flow_cfg =3D nic->flow_cfg;
>> -	struct otx2_tc_info *tc_info =3D &nic->tc_info;
>>  	struct otx2_tc_flow *flow_node;
>>  	int err;
>>
>> -	flow_node =3D rhashtable_lookup_fast(&tc_info->flow_table,
>> -					   &tc_flow_cmd->cookie,
>> -					   tc_info->flow_ht_params);
>> +	flow_node =3D otx2_tc_get_entry_by_cookie(flow_cfg,
>> +tc_flow_cmd->cookie);
>>  	if (!flow_node) {
>>  		netdev_err(nic->netdev, "tc flow not found for cookie
>0x%lx\n",
>>  			   tc_flow_cmd->cookie);
>> @@ -739,14 +913,10 @@ static int otx2_tc_del_flow(struct otx2_nic
>*nic,
>>  		mutex_unlock(&nic->mbox.lock);
>>  	}
>>
>> -	otx2_del_mcam_flow_entry(nic, flow_node->entry);
>> -
>> -	WARN_ON(rhashtable_remove_fast(&nic->tc_info.flow_table,
>> -				       &flow_node->node,
>> -				       nic->tc_info.flow_ht_params));
>> +	otx2_del_mcam_flow_entry(nic, flow_node->entry, NULL);
>> +	otx2_tc_update_mcam_table(nic, flow_cfg, flow_node, false);
>>  	kfree_rcu(flow_node, rcu);
>>
>> -	clear_bit(flow_node->bitpos, tc_info->tc_entries_bitmap);
>>  	flow_cfg->nr_flows--;
>>
>>  	return 0;
>> @@ -757,15 +927,14 @@ static int otx2_tc_add_flow(struct otx2_nic
>> *nic,  {
>>  	struct netlink_ext_ack *extack =3D tc_flow_cmd->common.extack;
>>  	struct otx2_flow_config *flow_cfg =3D nic->flow_cfg;
>> -	struct otx2_tc_info *tc_info =3D &nic->tc_info;
>>  	struct otx2_tc_flow *new_node, *old_node;
>>  	struct npc_install_flow_req *req, dummy;
>> -	int rc, err;
>> +	int rc, err, mcam_idx;
>>
>>  	if (!(nic->flags & OTX2_FLAG_TC_FLOWER_SUPPORT))
>>  		return -ENOMEM;
>>
>> -	if (bitmap_full(tc_info->tc_entries_bitmap, flow_cfg->max_flows)) {
>> +	if (flow_cfg->nr_flows =3D=3D flow_cfg->max_flows) {
>>  		NL_SET_ERR_MSG_MOD(extack,
>>  				   "Free MCAM entry not available to add the flow");
>>  		return -ENOMEM;
>> @@ -777,6 +946,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
>>  		return -ENOMEM;
>>  	spin_lock_init(&new_node->lock);
>>  	new_node->cookie =3D tc_flow_cmd->cookie;
>> +	new_node->prio =3D tc_flow_cmd->common.prio;
>>
>>  	memset(&dummy, 0, sizeof(struct npc_install_flow_req));
>>
>> @@ -787,12 +957,11 @@ static int otx2_tc_add_flow(struct otx2_nic
>*nic,
>>  	}
>>
>>  	/* If a flow exists with the same cookie, delete it */
>> -	old_node =3D rhashtable_lookup_fast(&tc_info->flow_table,
>> -					  &tc_flow_cmd->cookie,
>> -					  tc_info->flow_ht_params);
>> +	old_node =3D otx2_tc_get_entry_by_cookie(flow_cfg,
>> +tc_flow_cmd->cookie);
>>  	if (old_node)
>>  		otx2_tc_del_flow(nic, tc_flow_cmd);
>>
>> +	mcam_idx =3D otx2_tc_update_mcam_table(nic, flow_cfg, new_node,
>true);
>>  	mutex_lock(&nic->mbox.lock);
>>  	req =3D otx2_mbox_alloc_msg_npc_install_flow(&nic->mbox);
>>  	if (!req) {
>> @@ -804,10 +973,8 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
>>  	memcpy(&dummy.hdr, &req->hdr, sizeof(struct mbox_msghdr));
>>  	memcpy(req, &dummy, sizeof(struct npc_install_flow_req));
>>
>> -	new_node->bitpos =3D find_first_zero_bit(tc_info->tc_entries_bitmap,
>> -					       flow_cfg->max_flows);
>>  	req->channel =3D nic->hw.rx_chan_base;
>> -	req->entry =3D flow_cfg->flow_ent[flow_cfg->max_flows - new_node-
>>bitpos - 1];
>> +	req->entry =3D flow_cfg->flow_ent[mcam_idx];
>>  	req->intf =3D NIX_INTF_RX;
>>  	req->set_cntr =3D 1;
>>  	new_node->entry =3D req->entry;
>> @@ -817,26 +984,18 @@ static int otx2_tc_add_flow(struct otx2_nic
>*nic,
>>  	if (rc) {
>>  		NL_SET_ERR_MSG_MOD(extack, "Failed to install MCAM flow
>entry");
>>  		mutex_unlock(&nic->mbox.lock);
>> -		kfree_rcu(new_node, rcu);
>>  		goto free_leaf;
>>  	}
>> -	mutex_unlock(&nic->mbox.lock);
>>
>> -	/* add new flow to flow-table */
>> -	rc =3D rhashtable_insert_fast(&nic->tc_info.flow_table, &new_node-
>>node,
>> -				    nic->tc_info.flow_ht_params);
>> -	if (rc) {
>> -		otx2_del_mcam_flow_entry(nic, req->entry);
>> -		kfree_rcu(new_node, rcu);
>> -		goto free_leaf;
>> -	}
>> -
>> -	set_bit(new_node->bitpos, tc_info->tc_entries_bitmap);
>> +	mutex_unlock(&nic->mbox.lock);
>> +	memcpy(&new_node->req, req, sizeof(struct npc_install_flow_req));
>>  	flow_cfg->nr_flows++;
>>
>>  	return 0;
>>
>>  free_leaf:
>> +	otx2_tc_del_from_flow_list(flow_cfg, new_node);
>> +	kfree_rcu(new_node, rcu);
>>  	if (new_node->is_act_police) {
>>  		mutex_lock(&nic->mbox.lock);
>>
>> @@ -863,16 +1022,13 @@ static int otx2_tc_add_flow(struct otx2_nic
>> *nic,  static int otx2_tc_get_flow_stats(struct otx2_nic *nic,
>>  				  struct flow_cls_offload *tc_flow_cmd)  {
>> -	struct otx2_tc_info *tc_info =3D &nic->tc_info;
>>  	struct npc_mcam_get_stats_req *req;
>>  	struct npc_mcam_get_stats_rsp *rsp;
>>  	struct otx2_tc_flow_stats *stats;
>>  	struct otx2_tc_flow *flow_node;
>>  	int err;
>>
>> -	flow_node =3D rhashtable_lookup_fast(&tc_info->flow_table,
>> -					   &tc_flow_cmd->cookie,
>> -					   tc_info->flow_ht_params);
>> +	flow_node =3D otx2_tc_get_entry_by_cookie(nic->flow_cfg,
>> +tc_flow_cmd->cookie);
>>  	if (!flow_node) {
>>  		netdev_info(nic->netdev, "tc flow not found for cookie %lx",
>>  			    tc_flow_cmd->cookie);
>> @@ -1020,12 +1176,20 @@ static int otx2_setup_tc_block_ingress_cb(enum
>tc_setup_type type,
>>  					  void *type_data, void *cb_priv)  {
>>  	struct otx2_nic *nic =3D cb_priv;
>> +	bool ntuple;
>>
>>  	if (!tc_cls_can_offload_and_chain0(nic->netdev, type_data))
>>  		return -EOPNOTSUPP;
>>
>> +	ntuple =3D !!(nic->netdev->features & NETIF_F_NTUPLE);
>>  	switch (type) {
>>  	case TC_SETUP_CLSFLOWER:
>> +		if (ntuple) {
>> +			netdev_warn(nic->netdev,
>> +				    "Can't install TC flower offload rule when
>NTUPLE is active");
>> +			return -EOPNOTSUPP;
>> +		}
>> +
>>  		return otx2_setup_tc_cls_flower(nic, type_data);
>>  	case TC_SETUP_CLSMATCHALL:
>>  		return otx2_setup_tc_ingress_matchall(nic, type_data); @@ -
>1108,41
>> +1272,16 @@ int otx2_setup_tc(struct net_device *netdev, enum
>> tc_setup_type type,  }  EXPORT_SYMBOL(otx2_setup_tc);
>>
>> -static const struct rhashtable_params tc_flow_ht_params =3D {
>> -	.head_offset =3D offsetof(struct otx2_tc_flow, node),
>> -	.key_offset =3D offsetof(struct otx2_tc_flow, cookie),
>> -	.key_len =3D sizeof(((struct otx2_tc_flow *)0)->cookie),
>> -	.automatic_shrinking =3D true,
>> -};
>> -
>>  int otx2_init_tc(struct otx2_nic *nic)  {
>> -	struct otx2_tc_info *tc =3D &nic->tc_info;
>> -	int err;
>> -
>>  	/* Exclude receive queue 0 being used for police action */
>>  	set_bit(0, &nic->rq_bmap);
>> -
>> -	if (!nic->flow_cfg) {
>> -		netdev_err(nic->netdev,
>> -			   "Can't init TC, nic->flow_cfg is not setup\n");
>> -		return -EINVAL;
>> -	}
>> -
>> -	err =3D otx2_tc_alloc_ent_bitmap(nic);
>> -	if (err)
>> -		return err;
>> -
>> -	tc->flow_ht_params =3D tc_flow_ht_params;
>> -	return rhashtable_init(&tc->flow_table, &tc->flow_ht_params);
>> +	return 0;
>>  }
>>  EXPORT_SYMBOL(otx2_init_tc);
>>
>>  void otx2_shutdown_tc(struct otx2_nic *nic)  {
>> -	struct otx2_tc_info *tc =3D &nic->tc_info;
>> -
>> -	kfree(tc->tc_entries_bitmap);
>> -	rhashtable_destroy(&tc->flow_table);
>> +	otx2_destroy_tc_flow_list(nic);
>>  }
>>  EXPORT_SYMBOL(otx2_shutdown_tc);
>> --
>> 2.25.1
>>
>>
