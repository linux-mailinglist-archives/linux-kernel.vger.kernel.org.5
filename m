Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221AA7713C2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 08:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjHFGeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 02:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFGeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 02:34:17 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2347D1FE0;
        Sat,  5 Aug 2023 23:34:16 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3765JBb6012896;
        Sat, 5 Aug 2023 23:34:01 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3s9kss9tf1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Aug 2023 23:34:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByG2E2FV3uwPYrF/ivAGAwrP48xu/89LXXZSOYcOH/2GK2r32uV5K4DknhVDHdzzSOnfve44FOhvPdKseuIGdkI21EsvZCIcedFKkIZdtWYLxI2+fwuwGvA5sqJJUap8KTeYw60LJbBQiW2i+4m6ndln61lh9G3ZIvIEsXVXYVNC8USdDAOpCQodZrVxaFjTzfZKPVBxL8+CQJzlvxRwDgH7Hn8BMld1aBcvjJmEyG+3H3/Ibr2Pedce9uTjBRsk+0r9NzOPxhMMKsnxb4kWBg6N1iyHkt7wtgkXMJKEjE+TXWZBbCp3p4n4eUsEAaVgOowmOp7IK3njx8B64klW+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2lFWl9W5hiXXcMXsu4/zho4giBLEQv+uX5d0YtJVXk=;
 b=iIwlb5jX4E2uCo6jxk3jUg7wOv5QlMJjtvml0EFiKunyZpoGU+pC/iIOE7r+T38P7kMqmIsq9CHJH/NdYAuzn9zNqpNJm0euZUQF0LOu9lFJ3QZyHhlnaDfc5jUdtdovkcJiitJn2Z6ph2UmlP+qU7x0JSO/MguPn1R2geRxOP7q26rWtxCmyCKr2HlqO4w6LR9C8OEfcGSJvlsi/Fuw+yf+ageUo45/PMNZWErBWHGE/4ufwcE3OYvSJU1e9RsiYEP++BdeQzTtUQBIDPCWMAdj6ZtKm4weXkDxzrt/1LIYAp11cJN9pcq23lqlN/DQnaFj55uZBCkeYfZPhtDX7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2lFWl9W5hiXXcMXsu4/zho4giBLEQv+uX5d0YtJVXk=;
 b=TFv1cHs7QHAQ8DfoGuAKe+Q2K/Ny1qnHbMeX8xxES/L0bXGpF0lkZfnD8Hh5n82+a8QEpWFOzEiBToAOHJgIBAnTj8wgqq7jEI8PH6S0W3uyj/6ipOnODzDfWMZeAMjsTUDtR9Rx0OVEkG4BhnWUwyrnH4YIfoijcbeFRICl9OI=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by DM8PR18MB4405.namprd18.prod.outlook.com (2603:10b6:8:3d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Sun, 6 Aug
 2023 06:33:58 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::cbc9:7998:ae70:6b17]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::cbc9:7998:ae70:6b17%5]) with mapi id 15.20.6652.025; Sun, 6 Aug 2023
 06:33:58 +0000
From:   Elad Nachman <enachman@marvell.com>
To:     Jonas Gorski <jonas.gorski@bisdn.de>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yevhen Orlov <yevhen.orlov@plvision.eu>,
        Oleksandr Mazur <oleksandr.mazur@plvision.eu>
CC:     "Taras Chornyi [C]" <tchornyi@marvell.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] net: marvell: prestera: fix handling IPv4 routes
 with nhid
Thread-Topic: [EXT] [PATCH] net: marvell: prestera: fix handling IPv4 routes
 with nhid
Thread-Index: AQHZxrw7PDULGwpVhUa3n50lD7b1Z6/c0mSA
Date:   Sun, 6 Aug 2023 06:33:57 +0000
Message-ID: <BN9PR18MB4251ED95CE62843B994614BFDB0FA@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20230804101220.247515-1-jonas.gorski@bisdn.de>
In-Reply-To: <20230804101220.247515-1-jonas.gorski@bisdn.de>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZW5hY2htYW?=
 =?iso-8859-1?Q?5cYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-1?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy0zNGE1Zjg0ZS0zNDIzLTExZWUtYjc0Ny?=
 =?iso-8859-1?Q?0xOGNjMTg3OGFiYThcYW1lLXRlc3RcMzRhNWY4NTAtMzQyMy0xMWVlLWI3?=
 =?iso-8859-1?Q?NDctMThjYzE4NzhhYmE4Ym9keS50eHQiIHN6PSI5MTY3IiB0PSIxMzMzNT?=
 =?iso-8859-1?Q?c3NzIzNDcxODU5OTIiIGg9Imt4N285WHJDUFlsUEtWM1hVczA1K1B2djJR?=
 =?iso-8859-1?Q?OD0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-1?Q?5DZ1VBQUdJV0FBQkltOHI0TDhqWkFkZkZ3SXkzMHdYZzE4WEFqTGZUQmVB?=
 =?iso-8859-1?Q?WkFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQUJ1RHdBQTNnOEFBSV?=
 =?iso-8859-1?Q?FHQUFBQUFBQUFBQUFBQUFFQUFRRUJBQUFBSTdxVHBBQ0FBUUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBSjRBQUFCaEFHUUFaQUJ5QUdVQWN3QnpBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBRUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQU?=
 =?iso-8859-1?Q?FBR01BZFFCekFIUUFid0J0QUY4QWNBQmxBSElBY3dCdkFHNEFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQX?=
 =?iso-8859-1?Q?dBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVl3QjFB?=
 =?iso-8859-1?Q?SE1BZEFCdkFHMEFYd0J3QUdnQWJ3QnVBR1VBYmdCMUFHMEFZZ0JsQUhJQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJqQUhVQWN3QjBBRz?=
 =?iso-8859-1?Q?hBYlFCZkFITUFjd0J1QUY4QVpBQmhBSE1BYUFCZkFIWUFNQUF5QUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-refone: =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbm?=
 =?iso-8859-1?Q?dBQUFHTUFkUUJ6QUhRQWJ3QnRBRjhBY3dCekFHNEFYd0JyQUdVQWVRQjNB?=
 =?iso-8859-1?Q?RzhBY2dCa0FITUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWXdC?=
 =?iso-8859-1?Q?MUFITUFkQUJ2QUcwQVh3QnpBSE1BYmdCZkFHNEFid0JrQUdVQWJBQnBBRz?=
 =?iso-8859-1?Q?BBYVFCMEFHVUFjZ0JmQUhZQU1BQXlBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmpBSFVBY3dCME?=
 =?iso-8859-1?Q?FHOEFiUUJmQUhNQWN3QnVBRjhBY3dCd0FHRUFZd0JsQUY4QWRnQXdBRElB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdRQWJBQndBRjhBY3dCckFI?=
 =?iso-8859-1?Q?a0FjQUJsQUY4QVl3Qm9BR0VBZEFCZkFHMEFaUUJ6QUhNQVlRQm5BR1VBWH?=
 =?iso-8859-1?Q?dCMkFEQUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUNBQUFBQUFDZUFBQUFaQUJzQUhBQVh3QnpBR3dBWVFCakFHc0?=
 =?iso-8859-1?Q?FYd0JqQUdnQVlRQjBBRjhBYlFCbEFITUFjd0JoQUdjQVpRQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCa0FHd0FjQU?=
 =?iso-8859-1?Q?JmQUhRQVpRQmhBRzBBY3dCZkFHOEFiZ0JsQUdRQWNnQnBBSFlBWlFCZkFH?=
 =?iso-8859-1?Q?WUFhUUJzQUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1VBYlFCaEFHa0FiQUJm?=
 =?iso-8859-1?Q?QUdFQVpBQmtBSElBWlFCekFITUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRGdBQUFBQUFBQUFBQUFBQUFR?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQ0FBQUFBQUNlQUFBQWJRQmhBSElBZGdCbEFHd0FYd0J3QU?=
 =?iso-8859-1?Q?hJQWJ3QnFBR1VBWXdCMEFGOEFiZ0JoQUcwQVpRQnpBRjhBWXdCdkFHNEFa?=
 =?iso-8859-1?Q?Z0JwQUdRQVpRQnVBSFFBYVFCaEFHd0FYd0JoQUd3QWJ3QnVBR1VBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQVhBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCZkFIQUFjZ0J2QUdv?=
 =?iso-8859-1?Q?QVpRQmpBSFFBWHdCdUFHRUFiUUJsQUhNQVh3QnlBR1VBY3dCMEFISUFhUU?=
 =?iso-8859-1?Q?JqQUhRQVpRQmtBRjhBWVFCc0FHOEFiZ0JsQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFB?=
 =?iso-8859-1?Q?QUFBbmdBQUFHMEFZUUJ5QUhZQVpRQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQW?=
 =?iso-8859-1?Q?RBQmZBRzRBWVFCdEFHVUFjd0JmQUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJs?=
 =?iso-8859-1?Q?QUdRQVh3Qm9BR1VBZUFCakFHOEFaQUJsQUhNQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQU?=
 =?iso-8859-1?Q?FBYlFCaEFISUFkZ0JsQUd3QWJBQmZBR0VBY2dCdEFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refthree: =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QVp3QnZB?=
 =?iso-8859-1?Q?RzhBWndCc0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdB?=
 =?iso-8859-1?Q?QUFBQUFuZ0FBQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1?=
 =?iso-8859-1?Q?VBWXdCMEFGOEFZd0J2QUdRQVpRQnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZU?=
 =?iso-8859-1?Q?FBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFB?=
 =?iso-8859-1?Q?WHdCakFHOEFaQUJsQUhNQVh3QmtBR2tBWXdCMEFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFH?=
 =?iso-8859-1?Q?RUFjZ0IyQUdVQWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWV?=
 =?iso-8859-1?Q?FCdEFHVUFjd0JmQUdNQWJ3QnVBR1lBYVFCa0FHVUFiZ0IwQUdrQVlRQnNB?=
 =?iso-8859-1?Q?RjhBYlFCaEFISUFkZ0JsQUd3QWJBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWU?=
 =?iso-8859-1?Q?FaUUJzQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4QWJnQmhBRzBBWlFC?=
 =?iso-8859-1?Q?ekFGOEFZd0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFhUUJoQUd3QVh3QnRBR0?=
 =?iso-8859-1?Q?VBY2dCMkFHVUFiQUJzQUY4QWJ3QnlBRjhBWVFCeUFHMEFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQU?=
 =?iso-8859-1?Q?NlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29BWlFCakFI?=
 =?iso-8859-1?Q?UUFYd0J1QUdFQWJRQmxBSE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRBZE?=
 =?iso-8859-1?Q?FCcEFHRUFiQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3Qm5B?=
 =?iso-8859-1?Q?RzhBYndCbkFHd0FaUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0?=
 =?iso-8859-1?Q?QUdFQWNnQjJBR1VBYkFCc0FGOEFjQUJ5QUc4QWFnQmxBR01BZEFCZkFHNE?=
 =?iso-8859-1?Q?FZUUJ0QUdVQWN3QmZBSElBWlFCekFIUUFjZ0JwQUdNQWRBQmxBR1FBWHdC?=
 =?iso-8859-1?Q?dEFHRUFjZ0IyQUdVQWJBQnNBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZUUJ5QU?=
 =?iso-8859-1?Q?hZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBYmdCaEFHMEFa?=
 =?iso-8859-1?Q?UUJ6QUY4QWNnQmxBSE1BZEFCeUFHa0FZd0IwQUdVQVpBQmZBRzBBWVFCeU?=
 =?iso-8859-1?Q?FIWUFaUUJzQUd3QVh3QnZBSElBWHdCaEFISUFiUUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3?=
 =?iso-8859-1?Q?QWJBQmZBSFFBWlFCeUFHMEFhUUJ1QUhVQWN3QUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QW?=
 =?iso-8859-1?Q?R3QnZBSElBWkFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQWdBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQWdBQUFBQUFoQVlBQUFBQUFBQWNBQUFBQVFBQUFBQUFBQUQ4WE55QW5S?=
 =?iso-8859-1?Q?UW1Rb0w2eUN6clhFWUlIQUFBQUFF?=
x-dg-reffive: =?iso-8859-1?Q?QUFBQUFBQUFBMTBnZmNiMUxza2VQT3I1SHZQRTFxeW9BQUFBQkFBQUFJZ0?=
 =?iso-8859-1?Q?FBQUFBQUFBQmpBRzhBYmdCbUFHa0FaQUJsQUc0QWRBQnBBR0VBYkFBQUFC?=
 =?iso-8859-1?Q?b0dBQUFaQUFBQUdBQUFBQUVBQUFCaEFHUUFaQUJ5QUdVQWN3QnpBQUFBSk?=
 =?iso-8859-1?Q?FBQUFBTUFBQUJqQUhVQWN3QjBBRzhBYlFCZkFIQUFaUUJ5QUhNQWJ3QnVB?=
 =?iso-8859-1?Q?QUFBTGdBQUFBQUFBQUJqQUhVQWN3QjBBRzhBYlFCZkFIQUFhQUJ2QUc0QV?=
 =?iso-8859-1?Q?pRQnVBSFVBYlFCaUFHVUFjZ0FBQURBQUFBQUFBQUFBWXdCMUFITUFkQUJ2?=
 =?iso-8859-1?Q?QUcwQVh3QnpBSE1BYmdCZkFHUUFZUUJ6QUdnQVh3QjJBREFBTWdBQUFEQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQVl3QjFBSE1BZEFCdkFHMEFYd0J6QUhNQWJnQmZBR3NBWlFC?=
 =?iso-8859-1?Q?NUFIY0Fid0J5QUdRQWN3QUFBRDRBQUFBQUFBQUFZd0IxQUhNQWRBQnZBRz?=
 =?iso-8859-1?Q?BBWHdCekFITUFiZ0JmQUc0QWJ3QmtBR1VBYkFCcEFHMEFhUUIwQUdVQWNn?=
 =?iso-8859-1?Q?QmZBSFlBTUFBeUFBQUFNZ0FBQUFBQUFBQmpBSFVBY3dCMEFHOEFiUUJmQU?=
 =?iso-8859-1?Q?hNQWN3QnVBRjhBY3dCd0FHRUFZd0JsQUY4QWRnQXdBRElBQUFBK0FBQUFB?=
 =?iso-8859-1?Q?QUFBQUdRQWJBQndBRjhBY3dCckFIa0FjQUJsQUY4QVl3Qm9BR0VBZEFCZk?=
 =?iso-8859-1?Q?FHMEFaUUJ6QUhNQVlRQm5BR1VBWHdCMkFEQUFNZ0FBQURZQUFBQUFBQUFB?=
 =?iso-8859-1?Q?WkFCc0FIQUFYd0J6QUd3QVlRQmpBR3NBWHdCakFHZ0FZUUIwQUY4QWJRQm?=
 =?iso-8859-1?Q?xBSE1BY3dCaEFHY0FaUUFBQURnQUFBQUFBQUFBWkFCc0FIQUFYd0IwQUdV?=
 =?iso-8859-1?Q?QVlRQnRBSE1BWHdCdkFHNEFaUUJrQUhJQWFRQjJBR1VBWHdCbUFHa0FiQU?=
 =?iso-8859-1?Q?JsQUFBQUpBQUFBQTRBQUFCbEFHMEFZUUJwQUd3QVh3QmhBR1FBWkFCeUFH?=
 =?iso-8859-1?Q?VUFjd0J6QUFBQVdBQUFBQmNBQUFCdEFHRUFjZ0IyQUdVQWJBQmZBSEFBY2?=
 =?iso-8859-1?Q?dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFITUFYd0JqQUc4QWJnQm1B?=
 =?iso-8859-1?Q?R2tBWkFCbEFHNEFkQUJwQUdFQWJBQmZBR0VBYkFCdkFHNEFaUUFBQUZRQU?=
 =?iso-8859-1?Q?FBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUY4QWJnQmhBRzBBWlFCekFGOEFjZ0JsQUhNQWRBQnlBR2tBWXdCMEFHVU?=
 =?iso-8859-1?Q?FaQUJmQUdFQWJBQnZBRzRBWlFBQUFGb0FBQUFBQUFBQWJRQmhBSElBZGdC?=
 =?iso-8859-1?Q?bEFHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFiZ0JoQUcwQVpRQnpBRj?=
 =?iso-8859-1?Q?hBY2dCbEFITUFkQUJ5QUdrQVl3QjBBR1VBWkFCZkFHZ0FaUUI0QUdNQWJ3?=
 =?iso-8859-1?Q?QmtBR1VBY3dBQUFDQUFBQUFBQUFB?=
x-dg-refsix: =?iso-8859-1?Q?QWJRQmhBSElBZGdCbEFHd0FiQUJmQUdFQWNnQnRBQUFBSmdBQUFBQUFBQU?=
 =?iso-8859-1?Q?J0QUdFQWNnQjJBR1VBYkFCc0FGOEFad0J2QUc4QVp3QnNBR1VBQUFBMEFB?=
 =?iso-8859-1?Q?QUFBQUFBQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWX?=
 =?iso-8859-1?Q?dCMEFGOEFZd0J2QUdRQVpRQnpBQUFBUGdBQUFBQUFBQUJ0QUdFQWNnQjJB?=
 =?iso-8859-1?Q?R1VBYkFCc0FGOEFjQUJ5QUc4QWFnQmxBR01BZEFCZkFHTUFid0JrQUdVQW?=
 =?iso-8859-1?Q?N3QmZBR1FBYVFCakFIUUFBQUJlQUFBQUFBQUFBRzBBWVFCeUFIWUFaUUJz?=
 =?iso-8859-1?Q?QUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4QWJnQmhBRzBBWlFCekFGOE?=
 =?iso-8859-1?Q?FZd0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFhUUJoQUd3QVh3QnRBR0VBY2dC?=
 =?iso-8859-1?Q?MkFHVUFiQUJzQUFBQWJBQUFBQUFBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRj?=
 =?iso-8859-1?Q?hBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUdNQWJ3?=
 =?iso-8859-1?Q?QnVBR1lBYVFCa0FHVUFiZ0IwQUdrQVlRQnNBRjhBYlFCaEFISUFkZ0JsQU?=
 =?iso-8859-1?Q?d3QWJBQmZBRzhBY2dCZkFHRUFjZ0J0QUFBQWNnQUFBQUFBQUFCdEFHRUFj?=
 =?iso-8859-1?Q?Z0IyQUdVQWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdE?=
 =?iso-8859-1?Q?FHVUFjd0JmQUdNQWJ3QnVBR1lBYVFCa0FHVUFiZ0IwQUdrQVlRQnNBRjhB?=
 =?iso-8859-1?Q?YlFCaEFISUFkZ0JsQUd3QWJBQmZBRzhBY2dCZkFHY0Fid0J2QUdjQWJBQm?=
 =?iso-8859-1?Q?xBQUFBV2dBQUFBQUFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFjQUJ5QUc4?=
 =?iso-8859-1?Q?QWFnQmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZBSElBWlFCekFIUUFjZ0?=
 =?iso-8859-1?Q?JwQUdNQWRBQmxBR1FBWHdCdEFHRUFjZ0IyQUdVQWJBQnNBQUFBYUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFjQUJ5QUc4QWFnQmxBR01BZE?=
 =?iso-8859-1?Q?FCZkFHNEFZUUJ0QUdVQWN3QmZBSElBWlFCekFIUUFjZ0JwQUdNQWRBQmxB?=
 =?iso-8859-1?Q?R1FBWHdCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBYndCeUFGOEFZUUJ5QUcwQU?=
 =?iso-8859-1?Q?FBQXFBQUFBQUFBQUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCMEFHVUFjZ0J0?=
 =?iso-8859-1?Q?QUdrQWJnQjFBSE1BQUFBaUFBQUFDQUFBQUcwQVlRQnlBSFlBWlFCc0FHd0?=
 =?iso-8859-1?Q?FYd0IzQUc4QWNnQmtBQUFBIi8+PC9tZXRhPg=3D=3D?=
x-dg-tag-bcast: {BB38C8B4-BBDA-40C5-8168-0013E523D1A2}
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4251:EE_|DM8PR18MB4405:EE_
x-ms-office365-filtering-correlation-id: 62d7d04c-8876-400d-2931-08db96471d39
x-ld-processed: 70e1fb47-1155-421d-87fc-2e58f638b6e0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wj+OGj//suyT/737A1GI74vXQaF0mf3qBga8xxkEzh86lj1TBTOkd6WDBdzprKY0FxA2I0SuuRONv2fVyEw/GBTCw28lh2S93+SZA9sJtSju4bYCgViZDqzoJCbvuwv3bJT3YULWaMaFNIJCO1qcruMY/byHDRBQ4rPf+i8peKQUbcB7okz5eQhpWjvXuc3OZLFEcK569Sh9CYz2CyEhUuNf32lRB1aLhVmWrpygjzke/MQ1i/rTDzUI6/ktd9ks4GC64svfDIajag+6ubCGKZRf2Z/vZiPJwXoa/bVebRrxpLebUnc+XPFh4WuGKD1OSEYUqNCTiKIjTEtw5yBWHCHunO5LWivzBUNBs16SHi6DXX4e8zj/YRZ7kMcv57y85WK5kHpAeZbfdl16dJW/6ImuXS8ULRr7HyL2ybPI6YgS1Y1tJxVBzMgDMEoWZB16mtKzgiu/SPtDf2+vSPyrJ0ntuwTq7NekCTECyT+y0VKDGpPSwMNGEHWZwvkaLw7vADAiBUB5hGXzt9Q5M+TF+RClJTsy1KcNWGTwuRi5wktOmm94963A0AVgX12mCNK5AgzP3ct1o4JB98sHdyieph7aDPutiUPG0dH4wggXmEM4tUWGkyRaoRFJ52MA/DsV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39850400004)(346002)(136003)(376002)(451199021)(186006)(1800799003)(55016003)(4326008)(9686003)(316002)(86362001)(478600001)(122000001)(110136005)(54906003)(38100700002)(76116006)(71200400001)(66946007)(66556008)(66476007)(66446008)(64756008)(7696005)(33656002)(45080400002)(53546011)(6506007)(41300700001)(26005)(52536014)(38070700005)(66574015)(8676002)(8936002)(2906002)(7416002)(83380400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EuWZ+d+lQcuD8ULkoDGwf20KsGk5ZMiILddifBUqBBj/Wgc2QoG5Q0YsXv?=
 =?iso-8859-1?Q?jNrG1Xaw0MqlohFf+AWv3fkCdfwYrxea971//63CVyfz18pon6VbVAursH?=
 =?iso-8859-1?Q?s8EhalUe7lleH//mom1PsLcdARyCJfkpsHJIsJypghsl1yI4M0a4NS8uko?=
 =?iso-8859-1?Q?CqtpiSWDTCQYvjb17K9J3+X/THqdjovGw5dGYb7cpbZ28XtXvD1xajScyA?=
 =?iso-8859-1?Q?D+VL0pDUP6crZ3BneOvb5F1nBy+NPLSGnNuT1H1I5VUbFqOX4Jl4CT+/h1?=
 =?iso-8859-1?Q?6lHMWgYxDSHVyVbWqpkhStY8o2OcXanY0pOHBB3ciK1TvQNeiLjER1mVEy?=
 =?iso-8859-1?Q?JWOtzvsU8hHrJ5nUxkaVAGJ7P/tOP5CfTCfqibaxYtQjIiWD9PLSpqVt2U?=
 =?iso-8859-1?Q?2dfmu6sXBJzSMxCQ3m/JwcNfwL96JmRWI8zpMwK3okMTxcAnBhZwMxz2ds?=
 =?iso-8859-1?Q?0dIjcru83KBz1kmzcvdyqfcVhitnzRDXj/ydMMLfdwL2X2kL98P9yoYad2?=
 =?iso-8859-1?Q?3oZ2M8VoegFZ5M9eXyZDzMu2/2UUY2EmPYQzji9KzGtIOoeHIkKxQpynTw?=
 =?iso-8859-1?Q?ZS9LrXZIfftfcz1wtIQZJJlgS9cvpCrBVELqndk0V/U1eWS+cWwpYSq8vJ?=
 =?iso-8859-1?Q?4UKPIuu3fBE+iTAVR3RRQ8S6fCVWXJbEBHNJByBdkAtxPpTig+ipttw8Bk?=
 =?iso-8859-1?Q?vCgbUGE6iNLk44UZe20WQzJNbMimoxsnplRfLMmruaJpMAn6fP0TxBQzCv?=
 =?iso-8859-1?Q?aTRDlwHZ15cVw0X8DhEKM2fONbwxpZpfo02FJwEi3xvsnJNtOxKnaz3Hqo?=
 =?iso-8859-1?Q?Hll6lxIC9c/K6cwVEMlex6MLll/k1cQJe3OjPKriKNwXRMeY20hIWDDkMr?=
 =?iso-8859-1?Q?PFLOYaF608TCwjYtkBNP2pEyqO6DL5omoTADDNI3BqseMROVo71DxrZp6n?=
 =?iso-8859-1?Q?M9X1JlB8EGvsG3xcVfHvDhRTg3wvIMSMsfuo7cVAJFGbq7Iu5xDlfXtdlw?=
 =?iso-8859-1?Q?+YVtzhvC0635J5wFQz7r85cxC3G020tvr4UW1DCuxYy0Ck+G2ijDIk8va3?=
 =?iso-8859-1?Q?DUicI/a0BWAPhIkJaNXgcCTMzlSvbi6r/l+QpGGFGckCE5ITlBQmdVsZ45?=
 =?iso-8859-1?Q?aGhXR8GC3/8WV54PHzdGHmSU0VG/lFKMDBuNrJKa+a8RF3Gs0Og7AMB/k/?=
 =?iso-8859-1?Q?g+Vk9LX5+g4QOrN2h9oG4EQzwapwdF5GGMbTBkm5p+s8mL/v91d3NgwVjG?=
 =?iso-8859-1?Q?tl2H3gUFxV8a/jpfGGFM/4igVe9gBS8PV1F2+8x1i2HqMDg2GJhkXwdDKz?=
 =?iso-8859-1?Q?yNyljyV1kfXenGYa78Sb/Kx5PV67hPAb2LbmgXH2lxmeFI2I2wxugf3ya7?=
 =?iso-8859-1?Q?xHPvOJjwiPbFSbmfsCbsHoIdKlbhMRMVzsfSM5+hjbzs1NqPiN6ubOCphK?=
 =?iso-8859-1?Q?Lx6e9r7KbtE6RxymTdz9T8uoBoDt+ipVKERSrALlyTPGJOdidXAKxXvyJM?=
 =?iso-8859-1?Q?LPhvCUYI35XZh0uMeqDkIm2xAjWR2m9Tqc6T2STzPhM7A1uTdMiOx2S7ZR?=
 =?iso-8859-1?Q?fuNdJnvPMbi8nQUa4s1QwyVdBs0xDWb9nctaeBeewVK1yxSMqm3hVqvBtV?=
 =?iso-8859-1?Q?DQfFPsEY2XjeoU8pQFT6ITdeTBe02kBL9D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4251.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d7d04c-8876-400d-2931-08db96471d39
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2023 06:33:57.9755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ewGmnpEqG95ZBGX3NIjLPJuy3cT3ez5PCYGagrIFxt2VLbngwyup+kxeNa7kMnuyjZmIElQNAhBdzIiQOBvAaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4405
X-Proofpoint-GUID: HymuAD46Wo9EO6o0Q2fwjldVBF8jF8jW
X-Proofpoint-ORIG-GUID: HymuAD46Wo9EO6o0Q2fwjldVBF8jF8jW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-06_01,2023-08-03_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jonas Gorski <jonas.gorski@bisdn.de>
> Sent: Friday, August 4, 2023 1:12 PM
> To: Elad Nachman <enachman@marvell.com>; Taras Chornyi
> <taras.chornyi@plvision.eu>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> Paolo Abeni <pabeni@redhat.com>; Yevhen Orlov
> <yevhen.orlov@plvision.eu>; Oleksandr Mazur
> <oleksandr.mazur@plvision.eu>
> Cc: Taras Chornyi [C] <tchornyi@marvell.com>; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: [EXT] [PATCH] net: marvell: prestera: fix handling IPv4 routes w=
ith
> nhid
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> Fix handling IPv4 routes referencing a nexthop via its id by replacing ca=
lls to
> fib_info_nh() with fib_info_nhc().
>=20
> Trying to add an IPv4 route referencing a nextop via nhid:
>=20
>     $ ip link set up swp5
>     $ ip a a 10.0.0.1/24 dev swp5
>     $ ip nexthop add dev swp5 id 20 via 10.0.0.2
>     $ ip route add 10.0.1.0/24 nhid 20
>=20
> triggers warnings when trying to handle the route:
>=20
> [  528.805763] ------------[ cut here ]------------ [  528.810437] WARNIN=
G: CPU: 3
> PID: 53 at include/net/nexthop.h:468 __prestera_fi_is_direct+0x2c/0x68
> [prestera] [  528.820434] Modules linked in: prestera_pci act_gact act_po=
lice
> sch_ingress cls_u32 cls_flower prestera arm64_delta_tn48m_dn_led(O)
> arm64_delta_tn48m_dn_cpld(O) [last unloaded: prestera_pci]
> [  528.837485] CPU: 3 PID: 53 Comm: kworker/u8:3 Tainted: G           O
> 6.4.5 #1
> [  528.845178] Hardware name: delta,tn48m-dn (DT) [  528.849641]
> Workqueue: prestera_ordered __prestera_router_fib_event_work [prestera]
> [  528.857352] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS
> BTYPE=3D--) [  528.864347] pc : __prestera_fi_is_direct+0x2c/0x68 [preste=
ra] [
> 528.870135] lr : prestera_k_arb_fib_evt+0xb20/0xd50 [prestera] [
> 528.876007] sp : ffff80000b20bc90 [  528.879336] x29: ffff80000b20bc90 x2=
8:
> 0000000000000000 x27: ffff0001374d3a48 [  528.886510] x26:
> ffff000105604000 x25: ffff000134af8a28 x24: ffff0001374d3800 [
> 528.893683] x23: ffff000101c89148 x22: ffff000101c89000 x21:
> ffff000101c89200 [  528.900855] x20: ffff00013641fda0 x19:
> ffff800009d01088 x18: 0000000000000059 [  528.908027] x17:
> 0000000000000277 x16: 0000000000000000 x15: 0000000000000000 [
> 528.915198] x14: 0000000000000003 x13: 00000000000fe400 x12:
> 0000000000000000 [  528.922371] x11: 0000000000000002 x10:
> 0000000000000aa0 x9 : ffff8000013d2020 [  528.929543] x8 :
> 0000000000000018 x7 : 000000007b1703f8 x6 : 000000001ca72f86 [
> 528.936715] x5 : 0000000033399ea7 x4 : 0000000000000000 x3 :
> ffff0001374d3acc [  528.943886] x2 : 0000000000000000 x1 :
> ffff00010200de00 x0 : ffff000134ae3f80 [  528.951058] Call trace:
> [  528.953516]  __prestera_fi_is_direct+0x2c/0x68 [prestera] [  528.95895=
2]
> __prestera_router_fib_event_work+0x100/0x158 [prestera] [  528.965348]
> process_one_work+0x208/0x488 [  528.969387]  worker_thread+0x4c/0x430
> [  528.973068]  kthread+0x120/0x138 [  528.976313]
> ret_from_fork+0x10/0x20 [  528.979909] ---[ end trace 0000000000000000 ]-=
-
> - [  528.984998] ------------[ cut here ]------------ [  528.989645] WARN=
ING: CPU:
> 3 PID: 53 at include/net/nexthop.h:468 __prestera_fi_is_direct+0x2c/0x68
> [prestera] [  528.999628] Modules linked in: prestera_pci act_gact act_po=
lice
> sch_ingress cls_u32 cls_flower prestera arm64_delta_tn48m_dn_led(O)
> arm64_delta_tn48m_dn_cpld(O) [last unloaded: prestera_pci]
> [  529.016676] CPU: 3 PID: 53 Comm: kworker/u8:3 Tainted: G        W  O
> 6.4.5 #1
> [  529.024368] Hardware name: delta,tn48m-dn (DT) [  529.028830]
> Workqueue: prestera_ordered __prestera_router_fib_event_work [prestera]
> [  529.036539] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS
> BTYPE=3D--) [  529.043533] pc : __prestera_fi_is_direct+0x2c/0x68 [preste=
ra] [
> 529.049318] lr : __prestera_k_arb_fc_apply+0x280/0x2f8 [prestera] [
> 529.055452] sp : ffff80000b20bc60 [  529.058781] x29: ffff80000b20bc60 x2=
8:
> 0000000000000000 x27: ffff0001374d3a48 [  529.065953] x26:
> ffff000105604000 x25: ffff000134af8a28 x24: ffff0001374d3800 [
> 529.073126] x23: ffff000101c89148 x22: ffff000101c89148 x21:
> ffff00013641fda0 [  529.080299] x20: ffff000101c89000 x19: ffff000101c890=
20
> x18: 0000000000000059 [  529.087471] x17: 0000000000000277 x16:
> 0000000000000000 x15: 0000000000000000 [  529.094642] x14:
> 0000000000000003 x13: 00000000000fe400 x12: 0000000000000000 [
> 529.101814] x11: 0000000000000002 x10: 0000000000000aa0 x9 :
> ffff8000013cee80 [  529.108985] x8 : 0000000000000018 x7 :
> 000000007b1703f8 x6 : 0000000000000018 [  529.116157] x5 :
> 00000000d3497eb6 x4 : ffff000105604081 x3 : 000000008e979557 [
> 529.123329] x2 : 0000000000000000 x1 : ffff00010200de00 x0 :
> ffff000134ae3f80 [  529.130501] Call trace:
> [  529.132958]  __prestera_fi_is_direct+0x2c/0x68 [prestera] [  529.13839=
4]
> prestera_k_arb_fib_evt+0x6b8/0xd50 [prestera] [  529.143918]
> __prestera_router_fib_event_work+0x100/0x158 [prestera] [  529.150313]
> process_one_work+0x208/0x488 [  529.154348]  worker_thread+0x4c/0x430
> [  529.158030]  kthread+0x120/0x138 [  529.161274]
> ret_from_fork+0x10/0x20 [  529.164867] ---[ end trace 0000000000000000 ]-=
-
> -
>=20
> and results in a non offloaded route:
>=20
>     $ ip route
>     10.0.0.0/24 dev swp5 proto kernel scope link src 10.0.0.1 rt_trap
>     10.0.1.0/24 nhid 20 via 10.0.0.2 dev swp5 rt_trap
>=20
> When creating a route referencing a nexthop via its ID, the nexthop will =
be
> stored in a separate nh pointer instead of the array of nexthops in the
> fib_info struct. This causes issues since fib_info_nh() only handles the
> nexthops array, but not the separate nh pointer, and will loudly WARN abo=
ut
> it.
>=20
> In contrast fib_info_nhc() handles both, but returns a fib_nh_common
> pointer instead of a fib_nh pointer. Luckily we only ever access fields f=
rom
> the fib_nh_common parts, so we can just replace all instances of
> fib_info_nh() with fib_info_nhc() and access the fields via their
> fib_nh_common names.
>=20
> This allows handling IPv4 routes with an external nexthop, and they now g=
et
> offloaded as expected:
>=20
>     $ ip route
>     10.0.0.0/24 dev swp5 proto kernel scope link src 10.0.0.1 rt_trap
>     10.0.1.0/24 nhid 20 via 10.0.0.2 dev swp5 offload rt_offload
>=20
> Fixes: 396b80cb5cc8 ("net: marvell: prestera: Add neighbour cache
> accounting")
> Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
> ---
>  .../ethernet/marvell/prestera/prestera_router.c    | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_router.c
> b/drivers/net/ethernet/marvell/prestera/prestera_router.c
> index a9a1028cb17b..de317179a7dc 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_router.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_router.c
> @@ -166,11 +166,11 @@ prestera_util_neigh2nc_key(struct prestera_switch
> *sw, struct neighbour *n,
>=20
>  static bool __prestera_fi_is_direct(struct fib_info *fi)  {
> -	struct fib_nh *fib_nh;
> +	struct fib_nh_common *fib_nhc;
>=20
>  	if (fib_info_num_path(fi) =3D=3D 1) {
> -		fib_nh =3D fib_info_nh(fi, 0);
> -		if (fib_nh->fib_nh_gw_family =3D=3D AF_UNSPEC)
> +		fib_nhc =3D fib_info_nhc(fi, 0);
> +		if (fib_nhc->nhc_gw_family =3D=3D AF_UNSPEC)
>  			return true;
>  	}
>=20
> @@ -261,7 +261,7 @@ static bool
>  __prestera_util_kern_n_is_reachable_v4(u32 tb_id, __be32 *addr,
>  				       struct net_device *dev)
>  {
> -	struct fib_nh *fib_nh;
> +	struct fib_nh_common *fib_nhc;
>  	struct fib_result res;
>  	bool reachable;
>=20
> @@ -269,8 +269,8 @@ __prestera_util_kern_n_is_reachable_v4(u32 tb_id,
> __be32 *addr,
>=20
>  	if (!prestera_util_kern_get_route(&res, tb_id, addr))
>  		if (prestera_fi_is_direct(res.fi)) {
> -			fib_nh =3D fib_info_nh(res.fi, 0);
> -			if (dev =3D=3D fib_nh->fib_nh_dev)
> +			fib_nhc =3D fib_info_nhc(res.fi, 0);
> +			if (dev =3D=3D fib_nhc->nhc_dev)
>  				reachable =3D true;
>  		}
>=20
> @@ -324,7 +324,7 @@ prestera_kern_fib_info_nhc(struct fib_notifier_info
> *info, int n)
>  	if (info->family =3D=3D AF_INET) {
>  		fen4_info =3D container_of(info, struct fib_entry_notifier_info,
>  					 info);
> -		return &fib_info_nh(fen4_info->fi, n)->nh_common;
> +		return fib_info_nhc(fen4_info->fi, n);
>  	} else if (info->family =3D=3D AF_INET6) {
>  		fen6_info =3D container_of(info, struct
> fib6_entry_notifier_info,
>  					 info);
> --
> 2.41.0
>=20
>=20
> --
> BISDN GmbH
> K=F6rnerstra=DFe 7-10
> 10785 Berlin
> Germany
>=20
>=20
> Phone:
> +49-30-6108-1-6100
>=20
>=20
> Managing Directors:
> Dr.-Ing. Hagen Woesner, Andreas
> K=F6psel
>=20
>=20
> Commercial register:
> Amtsgericht Berlin-Charlottenburg HRB 141569
> B
> VAT ID No:=A0DE283257294

Acked-by: Elad Nachman <enachman@marvell.com>

