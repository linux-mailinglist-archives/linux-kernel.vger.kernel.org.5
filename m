Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EED771A9D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjHGGlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjHGGlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:41:46 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE0D1A4;
        Sun,  6 Aug 2023 23:41:45 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 376MhGa9024834;
        Sun, 6 Aug 2023 23:41:27 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3s9ksscf2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Aug 2023 23:41:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k89W4jIl+WDpJA9uJ4WxeZgTsWcGsYXyXTIHzkfgnn40Ve/hwOVSEi3M+MDAit4MfFsrQuJG2NGnuutySfPZTMNaY0ttuWdA0nnLapVj3E/+/ONCeUIJpNGCmT4Xk3/S67fKDe/UaQ1f89JcZMX12PoJTO/4jyOELc1TC57StuqreFEGmeYbguDDwr52bb/8MQP5do582Pj44QDKPaCVhc2cdnPZFBshfONMdY422wUopfoLkJmxX8c6VGpZec0qvbmpov8xP6klXuZHxXZRQGYPjxtbfdm+gaotu7/UbMsPYQpOQz1uJRh+ENmPap8vSmuWbB7iI+gOJra6f9P6Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u88JO1NHoPG04ZH4ekPxIyam/6tYX/DF7VWUzYVrGUI=;
 b=Wtvh2PMv7ivYmHPLHi88e9XyLfuiFLYK4tZ3WAaIKBaoLl5tzDKbWQPrF8ukJjGviRHgmx4Vk8UD4cvBFm0XfffuuW3lbTN8ySBnBkgyJQD/f//mhl782UhI+mGFf9KPTCKp75DA5V2FgIN9oVFDpplFFvlWQkaYztJnH/yZj+Vb2V2euVBhF5DJyrjUwWMht1FGPh7rEmZQ3T12lfaLDwfwwlogyDhSGOjev/umSlDZG4ghu8/rmgEi1O5r3vP1cStqLkW2fV130TxpEo17MC/BNGvTdUCf+3znIv1pDG+SgvU7CGldIk+Ru+UXJvHzPYHUMr0teSS2wbY+eLvDyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u88JO1NHoPG04ZH4ekPxIyam/6tYX/DF7VWUzYVrGUI=;
 b=HlKGJdY1ZOeWVHGfi5rJF8Z274BIpgtE4Ffv5DfaFuPI/v2IETXbOhYBuu8GNTe6kWgRsdBYY1NRBQ4irLSgMZP2n71gTlLGLu8vWjCDxdFAcHHIxEX+UWwl0FFFSvtuzLXViptU9exKOK6FmvONAzh0NJuVFKAWbtAXbdw+dy4=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by PH0PR18MB5141.namprd18.prod.outlook.com (2603:10b6:510:165::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 06:41:23 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::bda0:6335:2519:31b5]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::bda0:6335:2519:31b5%4]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 06:41:22 +0000
From:   Sai Krishna Gajula <saikrishnag@marvell.com>
To:     Simon Horman <horms@kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net-next PATCH] octeontx2-pf: Use PTP HW timestamp counter
 atomic update feature
Thread-Topic: [net-next PATCH] octeontx2-pf: Use PTP HW timestamp counter
 atomic update feature
Thread-Index: AQHZyPou6tZoCYwWUU6g8m09WQMaWg==
Date:   Mon, 7 Aug 2023 06:41:22 +0000
Message-ID: <BY3PR18MB4707D17FD94F2700F9E85226A00CA@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20230804093014.2729634-1-saikrishnag@marvell.com>
 <ZM4zmG55sEr9b62l@vergenet.net>
In-Reply-To: <ZM4zmG55sEr9b62l@vergenet.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2Fpa3Jpc2hu?=
 =?us-ascii?Q?YWdcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?us-ascii?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy02OWM5ZDdkOS0zNGVkLTExZWUtYWQyMS0x?=
 =?us-ascii?Q?Y2MxMGM0MGQ5ZTFcYW1lLXRlc3RcNjljOWQ3ZGItMzRlZC0xMWVlLWFkMjEt?=
 =?us-ascii?Q?MWNjMTBjNDBkOWUxYm9keS50eHQiIHN6PSIyMTYyIiB0PSIxMzMzNTg2NDA3?=
 =?us-ascii?Q?OTE5Mjg0ODMiIGg9IjcrOHAzQ2FnTXhTaFB6QWF4aHJuUG1jRmUxWT0iIGlk?=
 =?us-ascii?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU40?=
 =?us-ascii?Q?UEFBQ2p2aUVzK3NqWkFmTUpxb2dMUGduWDh3bXFpQXMrQ2RjWkFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFIQUFBQUJ1RHdBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFRRUJBQUFBeloxamFRQ0FBUUFBQUFBQUFBQUFBSjRBQUFCaEFH?=
 =?us-ascii?Q?UUFaQUJ5QUdVQWN3QnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01BZFFCekFIUUFid0J0QUY4?=
 =?us-ascii?Q?QWNBQmxBSElBY3dCdkFHNEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFHMEFYd0J3QUdnQWJ3QnVBR1VB?=
 =?us-ascii?Q?YmdCMUFHMEFZZ0JsQUhJQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJq?=
 =?us-ascii?Q?QUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QVpBQmhBSE1BYUFCZkFIWUFN?=
 =?us-ascii?Q?QUF5QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdB?=
 =?us-ascii?Q?QUFHTUFkUUJ6QUhRQWJ3QnRBRjhBY3dCekFHNEFYd0JyQUdVQWVRQjNBRzhB?=
 =?us-ascii?Q?Y2dCa0FITUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWXdCMUFITUFkQUJ2?=
 =?us-ascii?Q?QUcwQVh3QnpBSE1BYmdCZkFHNEFid0JrQUdVQWJBQnBBRzBBYVFCMEFHVUFj?=
 =?us-ascii?Q?Z0JmQUhZQU1BQXlBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFB?=
 =?us-ascii?Q?QUFBQUFBSUFBQUFBQUo0QUFBQmpBSFVBY3dCMEFHOEFiUUJmQUhNQWN3QnVB?=
 =?us-ascii?Q?RjhBY3dCd0FHRUFZd0JsQUY4QWRnQXdBRElBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFu?=
 =?us-ascii?Q?Z0FBQUdRQWJBQndBRjhBY3dCckFIa0FjQUJsQUY4QVl3Qm9BR0VBZEFCZkFH?=
 =?us-ascii?Q?MEFaUUJ6QUhNQVlRQm5BR1VBWHdCMkFEQUFNZ0FBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFaQUJzQUhBQVh3?=
 =?us-ascii?Q?QnpBR3dBWVFCakFHc0FYd0JqQUdnQVlRQjBBRjhBYlFCbEFITUFjd0JoQUdj?=
 =?us-ascii?Q?QVpRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCa0FHd0Fj?=
 =?us-ascii?Q?QUJmQUhRQVpRQmhBRzBBY3dCZkFHOEFiZ0JsQUdRQWNnQnBBSFlBWlFCZkFH?=
 =?us-ascii?Q?WUFhUUJzQUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1VBYlFCaEFHa0FiQUJmQUdFQVpB?=
 =?us-ascii?Q?QmtBSElBWlFCekFITUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBRVFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQWJRQmhBSElBZGdCbEFHd0FYd0J3QUhJQWJ3QnFBR1VBWXdC?=
 =?us-ascii?Q?MEFGOEFiZ0JoQUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFB?=
 =?us-ascii?Q?YVFCaEFHd0FYd0JoQUd3QWJ3QnVBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdF?=
 =?us-ascii?Q?QWNnQjJBR1VBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdCdUFHRUFiUUJs?=
 =?us-ascii?Q?QUhNQVh3QnlBR1VBY3dCMEFISUFhUUJqQUhRQVpRQmtBRjhBWVFCc0FHOEFi?=
 =?us-ascii?Q?Z0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZUUJ5QUhZQVpRQnNBRjhB?=
 =?us-ascii?Q?Y0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUhJQVpRQnpB?=
 =?us-ascii?Q?SFFBY2dCcEFHTUFkQUJsQUdRQVh3Qm9BR1VBZUFCakFHOEFaQUJsQUhNQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBR0VBY2dCdEFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refthree: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFB?=
 =?us-ascii?Q?QUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QVp3QnZBRzhB?=
 =?us-ascii?Q?WndCc0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FB?=
 =?us-ascii?Q?QUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFZ?=
 =?us-ascii?Q?d0J2QUdRQVpRQnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFiUUJoQUhJQWRnQmxB?=
 =?us-ascii?Q?R3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdCakFHOEFaQUJsQUhNQVh3?=
 =?us-ascii?Q?QmtBR2tBWXdCMEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFB?=
 =?us-ascii?Q?QUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBY0FCeUFH?=
 =?us-ascii?Q?OEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUdNQWJ3QnVBR1lBYVFC?=
 =?us-ascii?Q?a0FHVUFiZ0IwQUdrQVlRQnNBRjhBYlFCaEFISUFkZ0JsQUd3QWJBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5n?=
 =?us-ascii?Q?QUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4?=
 =?us-ascii?Q?QWJnQmhBRzBBWlFCekFGOEFZd0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFhUUJo?=
 =?us-ascii?Q?QUd3QVh3QnRBR0VBY2dCMkFHVUFiQUJzQUY4QWJ3QnlBRjhBWVFCeUFHMEFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29BWlFCakFI?=
 =?us-ascii?Q?UUFYd0J1QUdFQWJRQmxBSE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRBZEFC?=
 =?us-ascii?Q?cEFHRUFiQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3Qm5BRzhB?=
 =?us-ascii?Q?YndCbkFHd0FaUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNn?=
 =?us-ascii?Q?QjJBR1VBYkFCc0FGOEFjQUJ5QUc4QWFnQmxBR01BZEFCZkFHNEFZUUJ0QUdV?=
 =?us-ascii?Q?QWN3QmZBSElBWlFCekFIUUFjZ0JwQUdNQWRBQmxBR1FBWHdCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQnNBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdC?=
 =?us-ascii?Q?d0FISUFid0JxQUdVQVl3QjBBRjhBYmdCaEFHMEFaUUJ6QUY4QWNnQmxBSE1B?=
 =?us-ascii?Q?ZEFCeUFHa0FZd0IwQUdVQVpBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZB?=
 =?us-ascii?Q?SElBWHdCaEFISUFiUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSFFBWlFCeUFHMEFhUUJ1?=
 =?us-ascii?Q?QUhVQWN3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VB?=
 =?us-ascii?Q?Y2dCMkFHVUFiQUJzQUY4QWR3QnZBSElBWkFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUlBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUEiLz48L21ldGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|PH0PR18MB5141:EE_
x-ms-office365-filtering-correlation-id: 233febba-ce12-4863-9f3f-08db971150b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pg1TGjMljK2IyrbAJGNEVb6OkUrAFeipPkIATdt9gcpbSMYp8GbCXiBjsVzyljnFCh7/IPzuspViRW97qgbmKlz1Ji5Y0AUPkvskI45iKrO2KVpa+EhCN1C/n+uWQj59GB2FzD45bR9VkdWfS2qsbLpeWN+5nFt2LdAaIbSybacHFUZ6J6TeP7Pg20eKBxz+bs8hkIjPFi7NiX5DOURMEk2t/RX+VAosSQ63h0krySTwK1Adi8+V+umGAfeMpLDGOyLVf8M1Sivj+eD/NXfFE4hRnjELqcbQYk3IvmWZQoXB+zLmD0OdmRulemOHvZdNc+orrELUQ+BfDP8wRet107IK5yjLbEvrwwRtQKZBUff0kBbqmH3YU4KpCDLUYzJSnpG4uNvMOY2JhWnEeNYi9YjPr4aux1ImfMfjWNaf3o7Qh4BWKjGny6rCDQHgCOZZDOseFj6FenaswwTCw8x9o2ywdW8fY6fm75sCENWRNBMxyFiTT8h1DrEXICrUwEJmVgyZyT1GB02/8gqvtwu/qGDuNHWg5fM3dTgJcXt0wC9ZKQuVWsbCUNAa35/vMlWpGZczkVg8GbKGtVR5JgPiZ+KUMx8i6vFax+gsHLiRDCOnrwxEf/y2DaK35Jc/ltZh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39850400004)(346002)(396003)(136003)(451199021)(186006)(1800799003)(66556008)(66446008)(64756008)(76116006)(66476007)(4326008)(6916009)(41300700001)(66946007)(316002)(15650500001)(2906002)(54906003)(478600001)(6506007)(7696005)(9686003)(71200400001)(26005)(53546011)(107886003)(8676002)(8936002)(5660300002)(52536014)(33656002)(83380400001)(38070700005)(86362001)(55016003)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CQDcr7KMpPrXRWNnnDh9YQ/cryFXNkYVWm/QTCscYRBHTv4GvEq/E1Wt7bYz?=
 =?us-ascii?Q?tb1zFbOYvvrn79MMqUlXrDOs3ZTda/rpeQ2GagOsDqPUvyWeMr2SRSwStOZI?=
 =?us-ascii?Q?RmHXrha2Yd6iFPFWQDbOgScrH4tuOhU0v65u53nK46fSO6MUDLYsJ6G3C5gB?=
 =?us-ascii?Q?LSzNzHB0YhPnRlWTis/Zw35QWBoil1d8ZMz/upWTCRBnDNWFCQLjuRcbV3cZ?=
 =?us-ascii?Q?AV3hdM2sltQmw1rJuBXewWLpSCVrgg8MAah0/j2v9IEUMzCulKtL+zFll/x0?=
 =?us-ascii?Q?s5EPBWV6Qe+PwD+oVnShiNw7TI9TjUQyJmockfeCHOoPEVTvBJ4pj12ppKOD?=
 =?us-ascii?Q?SJkELSTsQMqZODbKtrnA7f/6IcOiAyOqiNysSt62dmlp98nPf7UyE3zwm8t+?=
 =?us-ascii?Q?TUmLDT1Ed0Mt9ZsVqcd1zLEkTIY9J/hCVn3HLbMwxvQV7cCKLzOr5IIJQqYx?=
 =?us-ascii?Q?97GCnu9+goFotllVLcHEBoqVW1uEAF1JtvNU9GnOPaW252miLhk924HigO5C?=
 =?us-ascii?Q?Dn1OoUqAL4XPh0wFJhW6KSIav1G7E8Hi3iTWSP/3MwtxPrlhp9/jWEeef+qy?=
 =?us-ascii?Q?j4/GaTO1uWy0AKx4RXxaJdlGxLYW/QSPzARosrvx3FzQ5M3wEaRjrc+xPrZG?=
 =?us-ascii?Q?pz82TlTKdWbj8t2PUms23Mgl/34uUk46RrubIMlJ3DTIT22FJmQ+u+1fBe2F?=
 =?us-ascii?Q?L/KZ41WPZBOD0UO+U9hlqHmUT5iMhaWhOxSRwpVCRDwsfTdUPuffgXAIKyK2?=
 =?us-ascii?Q?q3L599WSoc1CHGxl953uIQv5OcHUIrrzcVtDSzvB+8SW1w10xsMCaIVjYC57?=
 =?us-ascii?Q?xHAXBG3mlYo2eiqqM7PpLDaOJVyc3WHCallsaLDXEwmQjxa55X2VCuv0/fj+?=
 =?us-ascii?Q?5c69dm4KrtZNcIRcv/6QZPXkxH1vtu6gmAP6KW+mpYYcYsjAoCiSyMnZR5k4?=
 =?us-ascii?Q?KZAdB7MMCom5gJOQZCoF+GkeEqa7AQy3tYOpP9beoQqU2dKqeSCwBd0nCQ9O?=
 =?us-ascii?Q?++8auwXo8gL8e+SlM2+kyJ2tu/iZWuULba9xzVtYw/pKlY9yrqMvz36ZeE76?=
 =?us-ascii?Q?iegsihMV+/j/lUAmE7B2Anky+vjUJ6xx5MstG6wi+EiVZ0p8UWZn8gvZWc50?=
 =?us-ascii?Q?1eYx6dYBpkJejUEk4KcDRbmZbXMh91/pKg2UI/sVqAW7ZE9WCzmg+s4j1tv5?=
 =?us-ascii?Q?Ys/eRx4VcYM1zkZohKgiGSMXfkJzOxdarIKVqWEHb11V0y6rOwq76eC16IZN?=
 =?us-ascii?Q?5iSMTk1UMBQgr+AfI6j88XqLre3FhmI1iW74l4fR2aj/HLwwLRPAYdCiT3hc?=
 =?us-ascii?Q?QKCqNbfmMpFlB26rzYejf4s1YYidzQf4ssUP2pLya6IMWlCowrldMEcZ+i+A?=
 =?us-ascii?Q?mIEJ/KbWAWv1AF269mSR2eSfIwExHTHrEKhX25TBDTO9U5hnrmwRqwOJoYlw?=
 =?us-ascii?Q?YUe5NqDOUeYf2vbnlnIDh1nilxZEZTFOTdL/SQe0KfqNoO6R92ywS45oPP3a?=
 =?us-ascii?Q?uv88JaPJNR6uJaE9d4A6E0BacPX78LlSqeIHIjpwfUosWYjt3uSlXneDu1Kj?=
 =?us-ascii?Q?qnzV7kCqksF+9IaxCCvTjzwKa4bIHi2sa+LtqEgb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233febba-ce12-4863-9f3f-08db971150b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 06:41:22.7031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wiTvEJM5+0jIST1H29BCgopib0XMDBwvuSzXTtoYKpBKaE+YetDGPN2wXvxsu7azLM+f6PMaU39+7uljc+fezQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5141
X-Proofpoint-GUID: WfPbRIJ9J3NkDVHUUOz9KbwKdDkftMYJ
X-Proofpoint-ORIG-GUID: WfPbRIJ9J3NkDVHUUOz9KbwKdDkftMYJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_04,2023-08-03_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Saturday, August 5, 2023 5:04 PM
> To: Sai Krishna Gajula <saikrishnag@marvell.com>
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Sunil Kovvuri Goutham <sgoutham@marvell.com>;
> Geethasowjanya Akula <gakula@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>;
> richardcochran@gmail.com; Naveen Mamindlapalli
> <naveenm@marvell.com>
> Subject: Re: [net-next PATCH] octeontx2-pf: Use PTP HW timestamp
> counter atomic update feature
>=20
> On Fri, Aug 04, 2023 at 03:00:14PM +0530, Sai Krishna wrote:
> > Some of the newer silicon versions in CN10K series supports a feature
> > where in the current PTP timestamp in HW can be updated atomically
> > without losing any cpu cycles unlike read/modify/write register.
> > This patch uses this feature so that PTP accuracy can be improved
> > while adjusting the master offset in HW. There is no need for SW
> > timecounter when using this feature. So removed references to SW
> > timecounter wherever appropriate.
> >
> > Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> > Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> > Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
>=20
> ...
>=20
> >  struct npc_get_field_status_req {
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
> > b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
>=20
> ...
>=20
> >
> > -static bool is_ptp_tsfmt_sec_nsec(struct ptp *ptp)
> > +static inline bool is_tstmp_atomic_update_supported(struct rvu *rvu)
>=20
> Hi Sai,
>=20
> Please avoid using the inline keyword for functions in .c files.
> Unless there is a demonstrable advantage to doing so it should be left up=
 to
> the compiler to inline or not.

Ok, will remove inline keyword and submit V2 patch.

Thanks,
Sai
>=20
> ...
>=20
> --
> pw-bot: changes-requested
