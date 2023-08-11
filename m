Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515D677870E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 07:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjHKFsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 01:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHKFsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:48:50 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5064C2700;
        Thu, 10 Aug 2023 22:48:49 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AN2MvY011226;
        Thu, 10 Aug 2023 22:48:41 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sd8ya10ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 22:48:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I32KxyzcF1jZzNmEB8ZYphFfiBXp9og8Q/r2qSBXPwLPZPwsJP+vuP6BvScxIE4cx6PTUlqWraskYIvf1uz3+UuxCVVS57QLZSX1QipVROfkPaqBJeggMjMFqYCXhTXMAIjxl41591dYu6z2+qbXRmgeYWbHkTK/YHSVI2PP5JUIt9doiHHFyNABmo+ft6ptRRitN5+hgGqo0DgueyGNG3ARalfC7rOxVn9ZzU/3xdN5FAM1gxmYhoMQyC1x+kXZjAQ0mn4rdh9I2SFIbzcR8k7YQ4K4PG2vXsggQwn3yqdqHQtR7nAjWjphd4pxmq7g0XmRxO64+DJ4+Tw+wKPZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usapnpVy4ZjTWQ+BO169WasI4BKeMAsh5h0nKyPxI6A=;
 b=L7FtpIC2Gr4SnvW/2rBZ+kwvuodwNf+GfJWIb1KxGKknNRjBq1ilgrIfkbHSxDqn+xb84FasHNpZBYwN5weXzITp7qv1S+z2dtk8Avli+OMpQHXw0mWi38+Oq06EjVOX+5ioP1yk8iNZKeSDhjc81NABBYAeyyWboYbQxQNJdU2l3561aFrzUZv6MhO6mAb2enT/oilNcrvPqJCTM9tVimAkZrRgdexAApET1kvXKMz3/9QycLG1fPQ4x7nTBb5MZ75xLSTCH8nawfDo3yyG+QoLwIa7C+izWe+gNKmVrqsIIm8GCnK/DgB6W2BNpCIfD0zb5VP0p0xXjAaYsQdCUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usapnpVy4ZjTWQ+BO169WasI4BKeMAsh5h0nKyPxI6A=;
 b=n3pzNaQTpZXxMAeaqApHyOBwjBEKI2Lh/O21Mcs8Cw35SDUBzaetckDx5tzSsBYzIy+l+EOhaRDQg6aM3ZGZrsJjrA7xB0H+uB3xPOhjHB6v2vbWOv9uIKEZCqlxOyMYNHjyck205GMUVgAu/NNiNXIxSjw1N82xMJD24BELpaY=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by SN4PR18MB4888.namprd18.prod.outlook.com (2603:10b6:806:213::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 05:48:39 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::bda0:6335:2519:31b5]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::bda0:6335:2519:31b5%5]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 05:48:38 +0000
From:   Sai Krishna Gajula <saikrishnag@marvell.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net-next PATCH v2] octeontx2-pf: Use PTP HW timestamp counter
 atomic update feature
Thread-Topic: [net-next PATCH v2] octeontx2-pf: Use PTP HW timestamp counter
 atomic update feature
Thread-Index: AQHZzBd5EeKIotOBfk6aipYP34LBZg==
Date:   Fri, 11 Aug 2023 05:48:38 +0000
Message-ID: <BY3PR18MB470745294C1B03C0DA5364E6A010A@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20230807140535.3070350-1-saikrishnag@marvell.com>
 <20230809155022.132a69a7@kernel.org>
In-Reply-To: <20230809155022.132a69a7@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2Fpa3Jpc2hu?=
 =?us-ascii?Q?YWdcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?us-ascii?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy1iNWEzNzQzZi0zODBhLTExZWUtYWQyMy0x?=
 =?us-ascii?Q?Y2MxMGM0MGQ5ZTRcYW1lLXRlc3RcYjVhMzc0NDAtMzgwYS0xMWVlLWFkMjMt?=
 =?us-ascii?Q?MWNjMTBjNDBkOWU0Ym9keS50eHQiIHN6PSI0MjY0IiB0PSIxMzMzNjIwNjUx?=
 =?us-ascii?Q?NTg1MzI0NDEiIGg9Ikc5ckd2VkNNd0NOK3czN3IxaTRpVytabnVuUT0iIGlk?=
 =?us-ascii?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU40?=
 =?us-ascii?Q?UEFBQlpiVWw0Rjh6WkFmdk92TmxMZkFWbis4NjgyVXQ4QldjWkFBQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFHMEFYd0J3QUdnQWJ3QnVBR1VB?=
 =?us-ascii?Q?YmdCMUFHMEFZZ0JsQUhJQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJq?=
 =?us-ascii?Q?QUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QVpBQmhBSE1BYUFCZkFIWUFN?=
 =?us-ascii?Q?QUF5QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBRFFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUEiLz48L21ldGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|SN4PR18MB4888:EE_
x-ms-office365-filtering-correlation-id: 2897a2fc-ca7f-4d4c-477e-08db9a2e9c64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E5rwRbPzQta5wc+k0mUwMoEovEaFvhcc6icJncEX+AZBKfZHnJw1JM1al9jk9cuJf612Wa+YI4TWC/ALi/shBegZaI2XoF+Q9+Hgu4W8LOlxhKI6OeuAzr9ZTC6Y0vc+dNKgkAmepg318JnwPuLPa+5mv/CMFSdnSwKUBX6z3IlVdhHgvg4Ywhw91nGsqb2pIWk29/llWqaO0LAV9rnKtsDGxcWiPjUbW8XfOeV6eW6Do0iDZB3f3NPo8QuNGMut2HAIPs/o2vaX1EUGj5/kIuJW1H7hwA/8J9ci+D6STf0IFO+fM8sjcpDf1HZYnRGe4kDHsKQ0wMp9/LWS1/jvGoB+MlpXgD3H0U1pahUTRp7+HtbWCQXjFfoKWmSB3/sUK/3howZY8x/PcCCHHOmqQQxWFKHfLvh2O394mNyJ95xApHyv2Nt5Snyiewv2jzclpB1Kzv5x80ssohEmdWWZ4pJgfCBPCo11Jaz22WucUd2g9BOleoKkjkWtqtrFLcr/DV75G7UiDNS//9xWpvm3BdKYLcDBdb0p8elEs9vyPYVw6bj0qBbswesztkofCqWChSAz+6mkBa6P7/OdmaUUKB6M5ZQL+FKIr1pLBG+FRazAyUXK3jmst4VrnMoH5oWq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(186006)(1800799006)(4326008)(83380400001)(2906002)(38100700002)(54906003)(86362001)(478600001)(122000001)(55016003)(107886003)(5660300002)(26005)(38070700005)(71200400001)(6506007)(52536014)(316002)(9686003)(8676002)(7696005)(8936002)(41300700001)(76116006)(33656002)(66476007)(66946007)(66446008)(64756008)(66556008)(15650500001)(53546011)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9oL6sJfjPZDWDEQBShdwlEz3La7gWH8Uy4Ar/HDXdhFo7iKMhYeDtFf/2ERK?=
 =?us-ascii?Q?qsUe03DImB75UJt/7ylroBqmIVPL9+E+eXSST8zerqAhTC4Iv3J/Lc9AOr2A?=
 =?us-ascii?Q?VCZMw7psKdXXSNd+7XuBiJ9+yiN0uL3KzdwromXydGml0/bcJ3NHzSzwxSar?=
 =?us-ascii?Q?6nr8npZgfJ7lFUZ98dYdULKFbFVxqrxNAhCbbQJgURmjPoysL1agR5Kav6XJ?=
 =?us-ascii?Q?F2rHSI9ueMrC9oH/VLOVN8NLY48MjaUxQnfDCSgzN5H+sbtfYvA8sD1n/H1P?=
 =?us-ascii?Q?4fffn1e9EOagW+Zd+YoDFqvViV1FMXgoMCdhNHqhU3zM6hIh/DdZd/uTYgS/?=
 =?us-ascii?Q?sZXlg4z8L0d6KTn2rPngdUOaAo9eQ+D+OGgERhzW39jgtEUhCa4VPR8WMmwa?=
 =?us-ascii?Q?jcBEgwtM0PoQYfjsw2/MOOomVMbuqwKLX8Oo14NzfYhsCn3Y2+ufhobsFuvc?=
 =?us-ascii?Q?lxzE4XTSqlXUt+R2Gr/sl0WRhF3nF2EahYA2vUbmqze3g7072SZRBNazFrFB?=
 =?us-ascii?Q?4sb2TsvNGCNnpq4MmhlMNBZ9Q6jB5vpASBc6QjfvNF8pax8pHrPDpK50F9Bh?=
 =?us-ascii?Q?WIcS4HQnlcejXo1gGOLlnSRl29fWd/UpCt4Bln98q3Kowgt5r4UZXdyLr1px?=
 =?us-ascii?Q?fn04G8FxmvjgtgjFNxZZd3U6Lp5IWI4wfCS6Qw+QpIyFcwDQNkYucI4pOFeV?=
 =?us-ascii?Q?WV/VNL2VzUXDTs4QAddBp7HXXnAHrNKtAul5ty0QwHOLTL6ccsvRjv1ihkgk?=
 =?us-ascii?Q?7SOD+DJeHaTyrJpZ8DVrjUd6Mq3xmr0gJ0+0f9Xgcjy4/Lqr7VBR14TfitBX?=
 =?us-ascii?Q?Oxd0eIceoL7HBkdqjP4wh6+ejNaxvz4G/0svlgVNtZbR9EIfuMn1YUrMuQK2?=
 =?us-ascii?Q?kSMh52ikgRYNPlq3NBASCGBSy62IQig5Zxa5DyqVRqBLP7gdAQ3IG+mUZnnS?=
 =?us-ascii?Q?NbE5Yb2X1rPb+k63n6Ey6Oll8/3wV7fsFqH+PtxMj51NOFROLmPdvysR/CjT?=
 =?us-ascii?Q?xD9XEft5orjLqsAC5edXr4NbDEyENwVWWKrxsi1PSPhXf+/oOIi1bnqm5uCd?=
 =?us-ascii?Q?MYXHnWo3Jv1i7ut1b4qgU5EA8KjRwjdA0aNMoI6G7eVbOsXYKFVeRQLlMN3b?=
 =?us-ascii?Q?bk+MEPk62xOaG+K+xtbT6HfexH706GD5xGOpaMRUfikU/xunViGENkpQL68E?=
 =?us-ascii?Q?qYRLX0pBzDdedOLiZ9Uivgx18Qi+1KtyvrJsDM+WjFmDFRf1MMA7IGu0PdHq?=
 =?us-ascii?Q?vmc+zjgbQ9eOqnhOlNYx59CA97kMatTd6AJ8BSXCg3dg2GDaIk2Xp9Z7xIZT?=
 =?us-ascii?Q?pmoOzOoIbzXXsCL8VnPB+ZbNdOabNHOt3W4NQv5Amke3QqlivE+doXqGGrbg?=
 =?us-ascii?Q?J1L8/bfCSlnpJbW2A6QTzYniUJrsRbaZQW886Yrc6xBplWW8/TghMq0EXlg9?=
 =?us-ascii?Q?gkQct0v7CYRexxFflX24/u2VOoSg7GAh1oYmQCIGpUN2zKGkD2ImwuxI7Ys2?=
 =?us-ascii?Q?+vSK8izMA+p3qdldqGt2iOvQJNLJ2t6hvrqr7tdO5taLH0Q1obRoZJix3XxE?=
 =?us-ascii?Q?lfbLCjr7k5FPHCEyE2BBgtc4JitjAQYYGEHV4E3J?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2897a2fc-ca7f-4d4c-477e-08db9a2e9c64
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 05:48:38.5844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tvi3hZAIOJIZZB+xztoCVDsWHKiII/Ch9FyGpuPncAnfNAXpATG0DHpqUnRYlK4vNFziahXbW6tO0DbLG+mGqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR18MB4888
X-Proofpoint-ORIG-GUID: Tah04fgDMEhcfvuZ8twxsk7nHPek-P4I
X-Proofpoint-GUID: Tah04fgDMEhcfvuZ8twxsk7nHPek-P4I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_20,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, August 10, 2023 4:20 AM
> To: Sai Krishna Gajula <saikrishnag@marvell.com>
> Cc: davem@davemloft.net; edumazet@google.com; pabeni@redhat.com;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri
> Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> <gakula@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>;
> richardcochran@gmail.com; Naveen Mamindlapalli
> <naveenm@marvell.com>
> Subject: Re: [net-next PATCH v2] octeontx2-pf: Use PTP HW timestamp
> counter atomic update feature
>=20
> On Mon, 7 Aug 2023 19:35:35 +0530 Sai Krishna wrote:
> > Some of the newer silicon versions in CN10K series supports a feature
> > where in the current PTP timestamp in HW can be updated atomically
> > without losing any cpu cycles unlike read/modify/write register.
> > This patch uses this feature so that PTP accuracy can be improved
> > while adjusting the master offset in HW. There is no need for SW
> > timecounter when using this feature. So removed references to SW
> > timecounter wherever appropriate.
>=20
> > -#include "ptp.h"
> >  #include "mbox.h"
> >  #include "rvu.h"
> > +#include "ptp.h"
>=20
> If you reorder the includes - maybe put them in alphabetical order?

There are some structure definitions in rvu.h which are required in ptp.h. =
So, re-ordering in alphabetical order will give compilation issue.=20

> >  static bool cn10k_ptp_errata(struct ptp *ptp)  {
> > -	if (ptp->pdev->subsystem_device =3D=3D
> PCI_SUBSYS_DEVID_CN10K_A_PTP ||
> > -	    ptp->pdev->subsystem_device =3D=3D
> PCI_SUBSYS_DEVID_CNF10K_A_PTP)
> > +	if ((is_ptp_dev_cn10ka(ptp) &&
> > +	     ((ptp->pdev->revision & 0x0F) =3D=3D 0x0 || (ptp->pdev->revision=
 &
> 0x0F) =3D=3D 0x1)) ||
> > +	    (is_ptp_dev_cnf10ka(ptp) &&
> > +	     ((ptp->pdev->revision & 0x0F) =3D=3D 0x0 || (ptp->pdev->revision=
 &
> > +0x0F) =3D=3D 0x1)))
>=20
> Please refactor the revision check to avoid these long lines repeating th=
e
> same logic

Sai:  Ack, will submit refactor changes in V3 patch.

>=20
> >  		return true;
> > +
> >  	return false;
> >  }
> >
> > -static bool is_ptp_tsfmt_sec_nsec(struct ptp *ptp)
> > +static bool is_tstmp_atomic_update_supported(struct rvu *rvu)
> >  {
> > -	if (ptp->pdev->subsystem_device =3D=3D
> PCI_SUBSYS_DEVID_CN10K_A_PTP ||
> > -	    ptp->pdev->subsystem_device =3D=3D
> PCI_SUBSYS_DEVID_CNF10K_A_PTP)
> > -		return true;
> > -	return false;
> > +	struct ptp *ptp =3D rvu->ptp;
> > +	struct pci_dev *pdev;
> > +
> > +	if (is_rvu_otx2(rvu))
> > +		return false;
> > +
> > +	pdev =3D ptp->pdev;
> > +
> > +	/* On older silicon variants of CN10K, atomic update feature
> > +	 * is not available.
> > +	 */
> > +	if ((pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_CN10K_A_PTP
> &&
> > +	     (pdev->revision & 0x0F) =3D=3D 0x0) ||
> > +	     (pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_CN10K_A_PTP
> &&
> > +	     (pdev->revision & 0x0F) =3D=3D 0x1) ||
> > +	     (pdev->subsystem_device =3D=3D
> PCI_SUBSYS_DEVID_CNF10K_A_PTP &&
> > +	     (pdev->revision & 0x0F) =3D=3D 0x0) ||
> > +	     (pdev->subsystem_device =3D=3D
> PCI_SUBSYS_DEVID_CNF10K_A_PTP &&
> > +	     (pdev->revision & 0x0F) =3D=3D 0x1))
>=20
> why are you not using cn10k_ptp_errata() here?

Ack, will submit the changes in V3 patch.

>=20
> > +		return false;
> > +
> > +	return true;
> >  }
>=20
> > -static int otx2_ptp_adjtime(struct ptp_clock_info *ptp_info, s64
> > delta)
> > +static int otx2_ptp_tc_adjtime(struct ptp_clock_info *ptp_info, s64
> > +delta)
> >  {
> >  	struct otx2_ptp *ptp =3D container_of(ptp_info, struct otx2_ptp,
> >  					    ptp_info);
> >  	struct otx2_nic *pfvf =3D ptp->nic;
> >
> > +	if (!ptp->nic)
> > +		return -ENODEV;
>=20
> Is this check related to the rest of the patch?

I will remove this check and submit V3 patch. Will submit this check as a s=
eparate patch, if required.

Thanks,
Sai
>=20
> >  	mutex_lock(&pfvf->mbox.lock);
> >  	timecounter_adjtime(&ptp->time_counter, delta);
> >  	mutex_unlock(&pfvf->mbox.lock);
> --
> pw-bot: cr
