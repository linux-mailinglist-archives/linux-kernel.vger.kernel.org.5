Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981757E61B8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 02:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjKIBJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 20:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjKIBJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 20:09:07 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471A1211D;
        Wed,  8 Nov 2023 17:09:05 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8LP5LM024691;
        Wed, 8 Nov 2023 17:08:53 -0800
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3u8j7d0mkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 17:08:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvytYct1T4cl+tzd6arxRg6D5nUS+OscFjNcpUFD5GOzCihmR7l1BqWCPukwgpwAO90rF4LGY3QGUfdsyRZx7woLZNaakSrw8QaIxa4ohCj5i2479OBfQQRZgsPyA4JM1UXpBNzCG8auiEN59NLWE7nkT3NYMfBzpJwQU+e+zJMCsSA5WguC4XOA2XDXLOEGKujS6AHMedcg2CVORQPUKQ4Fettu9UxqTbLDwnIAJe5IIdFmF0spa0e6Lo/m6FhxWLdTTnZUEUp4k9ZvS5t+DSjj6lXBS3ZTNwBLyThkUWTB6I/iF65pfnup6WglpgfmOscHVUhQXSzD/C662RB1Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SNo3A979eQ7MXrDYKwR+1uSWDzNKe1tN4+MJ6rDP60=;
 b=LJvayXP8GLhcC9OAkDhvJ1eTqbv7eM3NNGUrDFtfxkYqwuXxTmfVRiXkYS1oHJtHQHHjNPrcD+Ge/C1FACQaXvekWUzzTxZ9Ify5XKvWfKVNZNbijNrpxS8Tb0bHX7FAsWG3TY0GE7/PmA9LjsyiX4NnUFBH3dAKhyq5adfpgsex3/H2elLc5eBAmdVPclT4SqlfDhFOWMsM55590jkPQ5fWkdwrkTHx5x3p07m7LXYJtw7pgmoSfZqTrju9GCMbZKC30C7CR55SBuxlN7h/HjVN9QUkdWF6f9aax09jrrhlX80kofUUiRJcP1LoJ5L1maDvMW8Mtzzb92ShJzDrig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SNo3A979eQ7MXrDYKwR+1uSWDzNKe1tN4+MJ6rDP60=;
 b=hY8PzTmq0QTTGIcVEVB4BfMgTgR7rFZLrU7iyk987kRFKvwEChRBHuu6oubpJ3Qog4D//jrQqH8ZqlOVCwMb9AyLyQF9rjQK/XsUlMoMg1nmB4uKOaCbw8jY/dOK+63+ABNKN4cjv32wqZnR1XdYmz8grqN9FQYG8QDWfIuTMvc=
Received: from CO3PR18MB5005.namprd18.prod.outlook.com (2603:10b6:303:17e::22)
 by SJ0PR18MB4043.namprd18.prod.outlook.com (2603:10b6:a03:2c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 01:08:50 +0000
Received: from CO3PR18MB5005.namprd18.prod.outlook.com
 ([fe80::65fa:7047:b98c:23aa]) by CO3PR18MB5005.namprd18.prod.outlook.com
 ([fe80::65fa:7047:b98c:23aa%6]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 01:08:50 +0000
From:   Linu Cherian <lcherian@marvell.com>
To:     Linu Cherian <lcherian@marvell.com>,
        James Clark <james.clark@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Anil Kumar Reddy H <areddy3@marvell.com>
Subject: RE: [EXT] Re: [PATCH 5/7] coresight: tmc: Add support for reading
 tracedata from previous boot
Thread-Topic: [EXT] Re: [PATCH 5/7] coresight: tmc: Add support for reading
 tracedata from previous boot
Thread-Index: AQHZ8tpAR7JgipBqF02ldDqyeJd4D7A4S8oAgAFhTACABxHZ8IAwrC1A
Date:   Thu, 9 Nov 2023 01:08:49 +0000
Message-ID: <CO3PR18MB500522338168207AA463A642CEAFA@CO3PR18MB5005.namprd18.prod.outlook.com>
References: <20230929133754.857678-1-lcherian@marvell.com>
 <20230929133754.857678-6-lcherian@marvell.com>
 <acc2a406-2cff-eb3b-7661-1a93d4749bf2@arm.com>
 <9b519a19-548c-dec0-ed69-52695ff12a69@arm.com>
 <PH0PR18MB50021A139FE779A51257C41BCECDA@PH0PR18MB5002.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB50021A139FE779A51257C41BCECDA@PH0PR18MB5002.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbGNoZXJpYW5c?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy04NzMyZmI1YS03ZTljLTExZWUtYjZmNC0wNGI5?=
 =?us-ascii?Q?ZTMzMzhlMTNcYW1lLXRlc3RcODczMmZiNWMtN2U5Yy0xMWVlLWI2ZjQtMDRi?=
 =?us-ascii?Q?OWUzMzM4ZTEzYm9keS50eHQiIHN6PSIxNjA1NCIgdD0iMTMzNDM5NjU3MjUz?=
 =?us-ascii?Q?NjQ0ODU5IiBoPSJES0xvOGlEVDlER0c1SXorNkR0M2lkc2dNcjA9IiBpZD0i?=
 =?us-ascii?Q?IiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFHSVdB?=
 =?us-ascii?Q?QUE3cW8xSnFSTGFBVmczWE5DVzRQS1lXRGRjMEpiZzhwZ1pBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBSEFBQUFCdUR3QUEzZzhBQUlRR0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBUUVCQUFBQTlSZW5Md0NBQVFBQUFBQUFBQUFBQUo0QUFBQmhBR1FB?=
 =?us-ascii?Q?WkFCeUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQWRRQnpBSFFBYndCdEFGOEFj?=
 =?us-ascii?Q?QUJsQUhJQWN3QnZBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJRQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBBWHdCd0FHZ0Fid0J1QUdVQWJn?=
 =?us-ascii?Q?QjFBRzBBWWdCbEFISUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCakFI?=
 =?us-ascii?Q?VUFjd0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFaQUJoQUhNQWFBQmZBSFlBTUFB?=
 =?us-ascii?Q?eUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFB?=
 =?us-ascii?Q?R01BZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdCckFHVUFlUUIzQUc4QWNn?=
 =?us-ascii?Q?QmtBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFH?=
 =?us-ascii?Q?MEFYd0J6QUhNQWJnQmZBRzRBYndCa0FHVUFiQUJwQUcwQWFRQjBBR1VBY2dC?=
 =?us-ascii?Q?ZkFIWUFNQUF5QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFB?=
 =?us-ascii?Q?QUFBQUlBQUFBQUFKNEFBQUJqQUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4?=
 =?us-ascii?Q?QWN3QndBR0VBWXdCbEFGOEFkZ0F3QURJQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdB?=
 =?us-ascii?Q?QUFHUUFiQUJ3QUY4QWN3QnJBSGtBY0FCbEFGOEFZd0JvQUdFQWRBQmZBRzBB?=
 =?us-ascii?Q?WlFCekFITUFZUUJuQUdVQVh3QjJBREFBTWdBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWkFCc0FIQUFYd0J6?=
 =?us-ascii?Q?QUd3QVlRQmpBR3NBWHdCakFHZ0FZUUIwQUY4QWJRQmxBSE1BY3dCaEFHY0Fa?=
 =?us-ascii?Q?UUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmtBR3dBY0FC?=
 =?us-ascii?Q?ZkFIUUFaUUJoQUcwQWN3QmZBRzhBYmdCbEFHUUFjZ0JwQUhZQVpRQmZBR1lB?=
 =?us-ascii?Q?YVFCc0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdVQWJRQmhBR2tBYkFCZkFHRUFaQUJr?=
 =?us-ascii?Q?QUhJQVpRQnpBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUpBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBB?=
 =?us-ascii?Q?RjhBYmdCaEFHMEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFR?=
 =?us-ascii?Q?QmhBR3dBWHdCaEFHd0Fid0J1QUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFM?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFj?=
 =?us-ascii?Q?Z0IyQUdVQWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFI?=
 =?us-ascii?Q?TUFYd0J5QUdVQWN3QjBBSElBYVFCakFIUUFaUUJrQUY4QVlRQnNBRzhBYmdC?=
 =?us-ascii?Q?bEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUY4QWNB?=
 =?us-ascii?Q?QnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFISUFaUUJ6QUhR?=
 =?us-ascii?Q?QWNnQnBBR01BZEFCbEFHUUFYd0JvQUdVQWVBQmpBRzhBWkFCbEFITUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUdFQWNnQnRBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refthree: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFad0J2QUc4QVp3?=
 =?us-ascii?Q?QnNBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?MEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBWXdC?=
 =?us-ascii?Q?dkFHUUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3?=
 =?us-ascii?Q?QWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QmpBRzhBWkFCbEFITUFYd0Jr?=
 =?us-ascii?Q?QUdrQVl3QjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFB?=
 =?us-ascii?Q?QUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhB?=
 =?us-ascii?Q?YWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFRQmtB?=
 =?us-ascii?Q?R1VBYmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FB?=
 =?us-ascii?Q?QUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFi?=
 =?us-ascii?Q?Z0JoQUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFBYVFCaEFH?=
 =?us-ascii?Q?d0FYd0J0QUdFQWNnQjJBR1VBYkFCc0FGOEFid0J5QUY4QVlRQnlBRzBBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFB?=
 =?us-ascii?Q?WHdCdUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0QWRBQnBB?=
 =?us-ascii?Q?R0VBYkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0JuQUc4QWJ3?=
 =?us-ascii?Q?Qm5BR3dBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFj?=
 =?us-ascii?Q?d0JmQUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VBY2dCMkFH?=
 =?us-ascii?Q?VUFiQUJzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QndB?=
 =?us-ascii?Q?SElBYndCcUFHVUFZd0IwQUY4QWJnQmhBRzBBWlFCekFGOEFjZ0JsQUhNQWRB?=
 =?us-ascii?Q?QnlBR2tBWXdCMEFHVUFaQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJ?=
 =?us-ascii?Q?QVh3QmhBSElBYlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhRQVpRQnlBRzBBYVFCdUFI?=
 =?us-ascii?Q?VUFjd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNn?=
 =?us-ascii?Q?QjJBR1VBYkFCc0FGOEFkd0J2QUhJQVpBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBaEFZQUFBQUFBQUFjQUFBQUFRQUFBQUFBQUFE?=
 =?us-ascii?Q?OFhOeUFuUlFtUW9MNnlDenJYRVlJSEFBQUFB?=
x-dg-reffive: =?us-ascii?Q?RUFBQUFBQUFBQUpnclJRazJlVEVLT3dCQWNBYXkxcGlvQUFBQUJBQUFBSWdB?=
 =?us-ascii?Q?QUFBQUFBQUJqQUc4QWJnQm1BR2tBWkFCbEFHNEFkQUJwQUdFQWJBQUFBQm9H?=
 =?us-ascii?Q?QUFBWkFBQUFHQUFBQUFBQUFBQmhBR1FBWkFCeUFHVUFjd0J6QUFBQUpBQUFB?=
 =?us-ascii?Q?QVVBQUFCakFIVUFjd0IwQUc4QWJRQmZBSEFBWlFCeUFITUFid0J1QUFBQUxn?=
 =?us-ascii?Q?QUFBQUFBQUFCakFIVUFjd0IwQUc4QWJRQmZBSEFBYUFCdkFHNEFaUUJ1QUhV?=
 =?us-ascii?Q?QWJRQmlBR1VBY2dBQUFEQUFBQUFBQUFBQVl3QjFBSE1BZEFCdkFHMEFYd0J6?=
 =?us-ascii?Q?QUhNQWJnQmZBR1FBWVFCekFHZ0FYd0IyQURBQU1nQUFBREFBQUFBQUFBQUFZ?=
 =?us-ascii?Q?d0IxQUhNQWRBQnZBRzBBWHdCekFITUFiZ0JmQUdzQVpRQjVBSGNBYndCeUFH?=
 =?us-ascii?Q?UUFjd0FBQUQ0QUFBQUFBQUFBWXdCMUFITUFkQUJ2QUcwQVh3QnpBSE1BYmdC?=
 =?us-ascii?Q?ZkFHNEFid0JrQUdVQWJBQnBBRzBBYVFCMEFHVUFjZ0JmQUhZQU1BQXlBQUFB?=
 =?us-ascii?Q?TWdBQUFBQUFBQUJqQUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QWN3QndB?=
 =?us-ascii?Q?R0VBWXdCbEFGOEFkZ0F3QURJQUFBQStBQUFBQUFBQUFHUUFiQUJ3QUY4QWN3?=
 =?us-ascii?Q?QnJBSGtBY0FCbEFGOEFZd0JvQUdFQWRBQmZBRzBBWlFCekFITUFZUUJuQUdV?=
 =?us-ascii?Q?QVh3QjJBREFBTWdBQUFEWUFBQUFBQUFBQVpBQnNBSEFBWHdCekFHd0FZUUJq?=
 =?us-ascii?Q?QUdzQVh3QmpBR2dBWVFCMEFGOEFiUUJsQUhNQWN3QmhBR2NBWlFBQUFEZ0FB?=
 =?us-ascii?Q?QUFBQUFBQVpBQnNBSEFBWHdCMEFHVUFZUUJ0QUhNQVh3QnZBRzRBWlFCa0FI?=
 =?us-ascii?Q?SUFhUUIyQUdVQVh3Qm1BR2tBYkFCbEFBQUFKQUFBQUNRQUFBQmxBRzBBWVFC?=
 =?us-ascii?Q?cEFHd0FYd0JoQUdRQVpBQnlBR1VBY3dCekFBQUFXQUFBQUFzQUFBQnRBR0VB?=
 =?us-ascii?Q?Y2dCMkFHVUFiQUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0J1QUdFQWJRQmxB?=
 =?us-ascii?Q?SE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRBZEFCcEFHRUFiQUJmQUdFQWJB?=
 =?us-ascii?Q?QnZBRzRBWlFBQUFGUUFBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FYd0J3QUhJ?=
 =?us-ascii?Q?QWJ3QnFBR1VBWXdCMEFGOEFiZ0JoQUcwQVpRQnpBRjhBY2dCbEFITUFkQUJ5?=
 =?us-ascii?Q?QUdrQVl3QjBBR1VBWkFCZkFHRUFiQUJ2QUc0QVpRQUFBRm9BQUFBQUFBQUFi?=
 =?us-ascii?Q?UUJoQUhJQWRnQmxBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBYmdCaEFH?=
 =?us-ascii?Q?MEFaUUJ6QUY4QWNnQmxBSE1BZEFCeUFHa0FZd0IwQUdVQVpBQmZBR2dBWlFC?=
 =?us-ascii?Q?NEFHTUFid0JrQUdVQWN3QUFBQ0FBQUFBQUFB?=
x-dg-tag-bcast: {BB38C8B4-BBDA-40C5-8168-0013E523D1A2}
x-dg-refsix: =?us-ascii?Q?QUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFHRUFjZ0J0QUFBQUpnQUFBQUFBQUFC?=
 =?us-ascii?Q?dEFHRUFjZ0IyQUdVQWJBQnNBRjhBWndCdkFHOEFad0JzQUdVQUFBQTBBQUFB?=
 =?us-ascii?Q?QUFBQUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBB?=
 =?us-ascii?Q?RjhBWXdCdkFHUUFaUUJ6QUFBQVBnQUFBQUFBQUFCdEFHRUFjZ0IyQUdVQWJB?=
 =?us-ascii?Q?QnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBR01BYndCa0FHVUFjd0JmQUdR?=
 =?us-ascii?Q?QWFRQmpBSFFBQUFCZUFBQUFBQUFBQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3?=
 =?us-ascii?Q?QUhJQWJ3QnFBR1VBWXdCMEFGOEFiZ0JoQUcwQVpRQnpBRjhBWXdCdkFHNEFa?=
 =?us-ascii?Q?Z0JwQUdRQVpRQnVBSFFBYVFCaEFHd0FYd0J0QUdFQWNnQjJBR1VBYkFCc0FB?=
 =?us-ascii?Q?QUFiQUFBQUFBQUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhBYWdC?=
 =?us-ascii?Q?bEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFRQmtBR1VB?=
 =?us-ascii?Q?YmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUJmQUc4QWNnQmZB?=
 =?us-ascii?Q?R0VBY2dCdEFBQUFjZ0FBQUFBQUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNB?=
 =?us-ascii?Q?QnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZ?=
 =?us-ascii?Q?QWFRQmtBR1VBYmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUJm?=
 =?us-ascii?Q?QUc4QWNnQmZBR2NBYndCdkFHY0FiQUJsQUFBQVdnQUFBQUFBQUFCdEFHRUFj?=
 =?us-ascii?Q?Z0IyQUdVQWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFH?=
 =?us-ascii?Q?VUFjd0JmQUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VBY2dC?=
 =?us-ascii?Q?MkFHVUFiQUJzQUFBQWFBQUFBQUFBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhB?=
 =?us-ascii?Q?Y0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUhJQVpRQnpB?=
 =?us-ascii?Q?SFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VBY2dCMkFHVUFiQUJzQUY4QWJ3?=
 =?us-ascii?Q?QnlBRjhBWVFCeUFHMEFBQUFxQUFBQUFBQUFBRzBBWVFCeUFIWUFaUUJzQUd3?=
 =?us-ascii?Q?QVh3QjBBR1VBY2dCdEFHa0FiZ0IxQUhNQUFBQWlBQUFBQUFBQUFHMEFZUUJ5?=
 =?us-ascii?Q?QUhZQVpRQnNBR3dBWHdCM0FHOEFjZ0JrQUFBQSIvPjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO3PR18MB5005:EE_|SJ0PR18MB4043:EE_
x-ms-office365-filtering-correlation-id: 6abc41a1-b8da-4d29-953d-08dbe0c06ea4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WgnnyKhuDKJxHPaZxSnv9B9f0PJTaAKtcC19ee6+93ewW8T7HmwXXjT4mFLQJ7FV+4G+nh8KjR/xXbwgFMFI7i/RjUZ2Gh+I127SdACKKRjSez6Q+NlAdiVGlgN7GN+hWc3GucVVFiGjD/zGeDfOMAH75mY29GuHr584+Yv60+fXjNWe8/jdiL43+qtgz3tK8afsgc7DjA/k5IhanKGiiqx1xYqEbaUf7cTmEMMir00YhmhKdYktnK/R3lH8Z4aYlGqmAdv7hfpRfHEZjlChp1i83pzgTxuOjOOoZTwZ9KjQ/HBS6KM58PRB3LhdePynFdShtHDQs8jyABPrzgi486iFPE4AFco7FA1XxFI4Kao2JnSEKDlHChiA9uZ7Vs4zYbiW+3WYFWcfhGOzaj3Z+5yCvkxxH/qu5aRlb3ZYOw+WZiMUT508ct3mWKBxgGWDRTLxus5NbaoBb8V0SHH4L2iEnNSv5QN4VKE2IhkksmzAIbjhYMWgeVN3zUIMKHCPzrTiFgeKIH31qwwisNvKtxzFp5mQNd1n2rDTG/X+XTz9RsVanYVk8Ye56nKkdH4x1m6r5ahkedDkofwd/NOvR/cKLH9fkTmdyblRmf5QE4rx/7O4WXr7Cf4XSC1+vOTYIAzsEYwonUQ3nU8mmEyk+go07yAArbQPnuFCYBqBhq4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO3PR18MB5005.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(346002)(396003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(5660300002)(71200400001)(7696005)(53546011)(7416002)(478600001)(52536014)(83380400001)(2906002)(41300700001)(8936002)(4326008)(8676002)(6506007)(86362001)(66556008)(66476007)(66946007)(64756008)(54906003)(9686003)(66446008)(26005)(316002)(107886003)(122000001)(76116006)(110136005)(38100700002)(33656002)(38070700009)(66899024)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZYJ3CY1tmXSWjcGagDjQIltJN5S/YlX2XIxTEKJoNKjuQpeU/6o85jnwM4BY?=
 =?us-ascii?Q?h0ZSqLMPbaANN4Dm4sHSgMwAEf4KQhv31hZCxO1Ovevs2VIGwk0HWd+LnVUn?=
 =?us-ascii?Q?m20NP6DAoPbcf2YEpcuncgtR6cGDQhZ8VIzQxaIUyihlgPcmi8nHAVRakxJk?=
 =?us-ascii?Q?tsAGplCsX7KNWqWWYQldEREHP890uAj/6z3Q/8nTaPtMAec94ERb2VcIfWRt?=
 =?us-ascii?Q?q2ntnvmW9nKAGtonKxeGZNFpexxSom0Ms/X0IhyIKWHX0eD9/iG5109LQiSm?=
 =?us-ascii?Q?xIUaX8NVCyN3HtkxUwpzCEaRX2H4IMCynzngTq06k1mr/ZfYZzRWC2p/IFyO?=
 =?us-ascii?Q?mWBXtt8IBijW2abh4eu+LSqXsEFjn/PKOcss7eOPHUFj3WowGdzV5vbtUUC9?=
 =?us-ascii?Q?gEtj+hLk2319s/BW5xOs51lmLEBDOVmppE5eyOufWC50J7j7bj8yDwCEdGHy?=
 =?us-ascii?Q?ZqSsoHR13rZpwsIZYhlRWtQXjfrMc3bnS5U0x8Jt/ffs48kDaTYiiQEAdpZX?=
 =?us-ascii?Q?dw6bqW5/BKzhH87tj+DOQa4rkg28ACNb8NMSjvQRyUkicpI1HUPVuNbN8cCO?=
 =?us-ascii?Q?t8GS4EH78hDKzgbTWux7zv8twW2Rg8P3C85UEO/0i2pMZeaKRMuA85cgpzYk?=
 =?us-ascii?Q?5WZf5dgk/Gz3HnX5CnBs6/FZ3mor/sfX2W5OWGboaNuj8/P1Auyxciicud4z?=
 =?us-ascii?Q?tH8AEKJ5HSPq7EQTgspMNBvPNttMLe2qhYm+hS992f1Y+wj7VQ7RKQ+v4wmr?=
 =?us-ascii?Q?lji3hLQ8uJ7rP6EzYF2ebeksXIsOPIVJKwUg4pkZANFvq3kMyoO0NIxPOj1K?=
 =?us-ascii?Q?q81bl8BFF8U6ID1JzoOv5JbP/whHsXVR5tUmdy1b/0zWme/rgZH4RTF2hN/7?=
 =?us-ascii?Q?VVFP1tnuFyUV2CWFYKyl/NP5aw/mwb/U8+cHNUaYul5emLzM8qh7WfcWcSnC?=
 =?us-ascii?Q?KAeprkGMJUZxUjbhyxUT+QoV9fwMs/MW+Wq51EjX3V3LAf+ZSHAnwbzCQK3l?=
 =?us-ascii?Q?tsHHoEMj0F6UyTrez21x87JPh8A584fHZ+6FUyBPwGSwkCzGP3pzZkunZ4Xd?=
 =?us-ascii?Q?PMhX7ossv5y6nfhRv8MGCPThtJ2K5tdfSVocRXbJEQYo2PJcmF0xheVUe27h?=
 =?us-ascii?Q?W9MX7I1gXsHz7qeM1H2NQyUDYbYh6iVyX7UQ2W6cm6k0y0AgI3qhWVNuxde8?=
 =?us-ascii?Q?Er8YxCSUvRk8XDJE66Gs8gh8wKXwA5MRBDLLe1SU1NJ+hph8xapdwdZXAecS?=
 =?us-ascii?Q?A7XcTKoy0wauweTlznPtNSObuA2WlaBKYDuU1nIt0su6dwU1OIzA++HloxDH?=
 =?us-ascii?Q?knqUz+K77+mv7/IqvVWNKhlterHbB4uAtkM/ieptGacIHF5cSmjobKtt6cDv?=
 =?us-ascii?Q?lKVvTC0GIAfD0aDSU5heqXeeQkWrZ0LgdrG+gwCjoEwgWMiMMNz/YhecZ464?=
 =?us-ascii?Q?ReCJbv4X5d/DQO466ap1s1gZBwAOEhFdVg3Nw4oA4MOt9zk2e0Mpsakt+59H?=
 =?us-ascii?Q?LuuG6oVyUvE7kgPniNNFWWrMbQ/yV8bdvm0FUjEVdFIlk7KMVHRIRsv5K2c1?=
 =?us-ascii?Q?30wPS1vscJEbFBJ2VWcDi1BYG9U3zDt0TtbhDIEe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO3PR18MB5005.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abc41a1-b8da-4d29-953d-08dbe0c06ea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 01:08:49.7506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAhwzQF1HiMDHLIu5BB3dN7fIwxXkAuIJkmbQ7OIBAe3LRGr+P3wJu8i+LXU2bveJ6Mp8BB8JFYt6HA4gLyi0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4043
X-Proofpoint-GUID: ovkx-1ZIKkITS8zIMpwxjkAtgJUgVGF1
X-Proofpoint-ORIG-GUID: ovkx-1ZIKkITS8zIMpwxjkAtgJUgVGF1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_01,2023-11-08_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> -----Original Message-----
> From: Linu Cherian <lcherian@marvell.com>
> Sent: Tuesday, October 10, 2023 6:53 PM
> To: James Clark <james.clark@arm.com>; suzuki.poulose@arm.com;
> mike.leach@linaro.org; leo.yan@linaro.org
> Cc: linux-arm-kernel@lists.infradead.org; coresight@lists.linaro.org; lin=
ux-
> kernel@vger.kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> devicetree@vger.kernel.org; Sunil Kovvuri Goutham
> <sgoutham@marvell.com>; George Cherian <gcherian@marvell.com>; Anil
> Kumar Reddy H <areddy3@marvell.com>
> Subject: RE: [EXT] Re: [PATCH 5/7] coresight: tmc: Add support for readin=
g
> tracedata from previous boot
>=20
> Hi James,
>=20
> > -----Original Message-----
> > From: James Clark <james.clark@arm.com>
> > Sent: Wednesday, October 4, 2023 7:18 PM
> > To: Linu Cherian <lcherian@marvell.com>; suzuki.poulose@arm.com;
> > mike.leach@linaro.org; leo.yan@linaro.org
> > Cc: linux-arm-kernel@lists.infradead.org; coresight@lists.linaro.org;
> > linux- kernel@vger.kernel.org; robh+dt@kernel.org;
> > krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> > devicetree@vger.kernel.org; Sunil Kovvuri Goutham
> > <sgoutham@marvell.com>; George Cherian <gcherian@marvell.com>; Anil
> > Kumar Reddy H <areddy3@marvell.com>; Tanmay Jagdale
> > <tanmay@marvell.com>
> > Subject: [EXT] Re: [PATCH 5/7] coresight: tmc: Add support for reading
> > tracedata from previous boot
> >
> > External Email
> >
> > ----------------------------------------------------------------------
> >
> >
> > On 03/10/2023 17:43, James Clark wrote:
> > >
> > >
> > > On 29/09/2023 14:37, Linu Cherian wrote:
> > >> * Introduce a new mode CS_MODE_READ_PREVBOOT for reading
> > tracedata
> > >>   captured in previous boot.
> > >>
> > >> * Add special handlers for preparing ETR/ETF for this special mode
> > >>
> > >> * User can read the trace data as below
> > >>
> > >>   For example, for reading trace data from tmc_etf sink
> > >>
> > >>   1. cd /sys/bus/coresight/devices/tmc_etfXX/
> > >>
> > >>   2. Change mode to READ_PREVBOOT
> > >>
> > >>      #echo 1 > read_prevboot
> > >>
> > >>   3. Dump trace buffer data to a file,
> > >>
> > >>      #dd if=3D/dev/tmc_etrXX of=3D~/cstrace.bin
> > >>
> > >>   4. Reset back to normal mode
> > >>
> > >>      #echo 0 > read_prevboot
> > >>
> > >> Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
> > >> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
> > >> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> > >> ---
> > >>  .../coresight/coresight-etm4x-core.c          |   1 +
> > >>  .../hwtracing/coresight/coresight-tmc-core.c  |  81 +++++++++-
> > >>  .../hwtracing/coresight/coresight-tmc-etf.c   |  62 ++++++++
> > >>  .../hwtracing/coresight/coresight-tmc-etr.c   | 145
> +++++++++++++++++-
> > >>  drivers/hwtracing/coresight/coresight-tmc.h   |   6 +
> > >>  include/linux/coresight.h                     |  13 ++
> > >>  6 files changed, 306 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > >> b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > >> index 77b0271ce6eb..513baf681280 100644
> > >> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > >> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > >> @@ -1010,6 +1010,7 @@ static void etm4_disable(struct
> > >> coresight_device *csdev,
> > >>
> > >>  	switch (mode) {
> > >>  	case CS_MODE_DISABLED:
> > >> +	case CS_MODE_READ_PREVBOOT:
> > >>  		break;
> > >>  	case CS_MODE_SYSFS:
> > >>  		etm4_disable_sysfs(csdev);
> > >> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c
> > >> b/drivers/hwtracing/coresight/coresight-tmc-core.c
> > >> index 6658ce76777b..65c15c9f821b 100644
> > >> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> > >> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> > >> @@ -103,6 +103,45 @@ u32 tmc_get_memwidth_mask(struct
> > tmc_drvdata *drvdata)
> > >>  	return mask;
> > >>  }
> > >>
> > >> +int tmc_read_prepare_prevboot(struct tmc_drvdata *drvdata) {
> > >> +	int ret =3D 0;
> > >> +	struct tmc_register_snapshot *reg_ptr;
> > >> +	struct coresight_device *csdev =3D drvdata->csdev;
> > >> +
> > >> +	if (!drvdata->metadata.vaddr) {
> > >> +		ret =3D -ENOMEM;
> > >> +		goto out;
> > >> +	}
> > >> +
> > >> +	reg_ptr =3D drvdata->metadata.vaddr;
> > >> +	if (!reg_ptr->valid) {
> > >> +		dev_err(&drvdata->csdev->dev,
> > >> +			"Invalid metadata captured from previous boot\n");
> > >> +		ret =3D -EINVAL;
> > >> +		goto out;
> > >> +	}
> > >
> > > I'm wondering if a more robust check is needed than the valid flag,
> > > like a checksum or something. I didn't debug it yet but I ended up
> > > with an invalid set of metadata after a panic reboot, see below. I'm
> > > not sure if it's just a logic bug or something got lost during the
> > > reboot, I didn't debug it yet. But I suppose unless you assume the
> > > panic didn't affect writing the metadata, then it could be partially
> > > written and shouldn't be trusted?
> > >
> > > [...]
> > >> +
> > >> +static int tmc_etr_sync_prevboot_buf(struct tmc_drvdata *drvdata) {
> > >> +	u32 status;
> > >> +	u64 rrp, rwp, dba;
> > >> +	struct tmc_register_snapshot *reg_ptr;
> > >> +	struct etr_buf *etr_buf =3D drvdata->prevboot_buf;
> > >> +
> > >> +	reg_ptr =3D drvdata->metadata.vaddr;
> > >> +
> > >> +	rrp =3D reg_ptr->rrp;
> > >> +	rwp =3D reg_ptr->rwp;
> > >> +	dba =3D reg_ptr->dba;
> > >> +	status =3D reg_ptr->sts;
> > >> +
> > >> +	etr_buf->full =3D !!(status & TMC_STS_FULL);
> > >> +
> > >> +	/* Sync the buffer pointers */
> > >> +	etr_buf->offset =3D rrp - dba;
> > >> +	if (etr_buf->full)
> > >> +		etr_buf->len =3D etr_buf->size;
> > >> +	else
> > >> +		etr_buf->len =3D rwp - rrp;
> > >> +
> > >> +	/* Sanity checks for validating metadata */
> > >> +	if ((etr_buf->offset > etr_buf->size) ||
> > >> +	    (etr_buf->len > etr_buf->size))
> > >> +		return -EINVAL;
> > >
> > > The values I got here are 0x781b67182aa346f9 0x8000000 0x8000000 for
> > > offset, size and len respectively. This fails the first check. It
> > > would also be nice to have a dev_dbg here as well, it's basically
> > > the same as the valid check above which does have one.
> > >
> >
> > So I debugged it and the issue is that after the panic I was doing a
> > cold boot rather than a warm boot and the memory was being randomised.
> >
> > The reason that 0x8000000 seemed to be initialised is because they are
> > based on the reserved region size, rather than anything from the
> > metadata. When I examined the metadata it was all randomised.
> >
> > That leads me to think that the single bit for 'valid' is insufficient.
> > There is a simple hashing function in include/linux/stringhash.h that
> > we could use on the whole metadata struct, but that specifically says:
> >
> >  * These hash functions are NOT GUARANTEED STABLE between kernel
> >  * versions, architectures, or even repeated boots of the same kernel.
> >  * (E.g. they may depend on boot-time hardware detection or be
> >  * deliberately randomized.)
> >
> > Although I'm not sure how true the repeated boots of the same kernel
> > part is.
> >
> > Maybe something in include/crypto/hash.h could be used instead, or
> > make our own simple hash.
>=20
> Thanks for the pointers. Will take a look at it.

Since the purpose is to identify any data corruption, crc32(using crc32_le =
API) looks okay to me. Any thoughts on this ?
May be we could add crc32 checks for trace data as well ?

Thanks.




>=20
>=20
>=20
>=20
>=20
>=20
>=20
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org To unsubscribe send =
an
> email to coresight-leave@lists.linaro.org
