Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2048D77F7AF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351440AbjHQN06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351430AbjHQN0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:26:32 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D073114
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:26:31 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37H9bY9s018333;
        Thu, 17 Aug 2023 06:26:18 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3shh34gktx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 06:26:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUD623UpwwP042UhJaLIcnTYXpNXjxaA1Ga68jajXhYzZRoavSNPolXR+erqHdp0YGS/e4dn9ezlED/3qtTzuyBJjoMN7yEMxSQNV+5f0b+5pb1brtHqqAa1wrkq+NI6wv9PIa34VTfqSLUm9Bxf0tw9EMsvkkzDMxl5ZLWC6XFqY52ZEBMgx8IWHvs1Jc3HeIINyGzHUgU9UxHB3H/xFt3gVXYsNKrBuHUbPl+DtVa26eMFqj5/eD8OUpiNtgpjFobnXbjcsV/1ANLZ0eFMFB0At3o4YigNxyPYDochwNyQWVFHyjAQQqeKYUB4UgMz/BgahpyWApXwAkzrerG6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biyRzsMQbP3iQEIuCN03qKmsRhVGuyC0pEs2sExL8MY=;
 b=N4RPNqHNySReEVJaM1rUkOdZbXDEDuRY2Dh3imbeQzNvxbhbgc/MjYWOoygrBHbqIpIoSbVTpSe//KitJhKZ9EPtg98iHhThfFzvWfatmJErfsSMSuOy9yarRMydn3aZjmZGk4X8br+6KD3wfUgg75V+BokBGDqZELnCjBe3kfNvfDYnkmsjoHmGPg832H5dejzYehCnzC5vXklj8YpUpuN7/TEW+WOJ5eIaBkfUzqAi5WP25w13B4YfcC6YZ07dkGD8q3ErmWE0UNxvTh/qa1gcbjZWJmb3RYu8GiI+XGGUNMYriN4fsOkLTgn2fShf9zzxfPksXy7oRpKhiTcL0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biyRzsMQbP3iQEIuCN03qKmsRhVGuyC0pEs2sExL8MY=;
 b=Y63zzR2M33Xxgy16XTbWdGZTIgv8J/u4os99w+civ/KOC5n3W1sYlKKWSFu145W29tqk7KZ4UWBOW6URzdmkBS9HXPC3sDFIIozIYKuv5oLjTpNtNBJWPwHWcyEDaM6JpUj44sy0mLJI4JIrTZOZEHIpQ++BTa7V0rqKxmDVu2U=
Received: from SN1PR18MB2126.namprd18.prod.outlook.com (2603:10b6:802:29::29)
 by SA0PR18MB3695.namprd18.prod.outlook.com (2603:10b6:806:92::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 13:26:14 +0000
Received: from SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::cb4d:3836:d818:9bae]) by SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::cb4d:3836:d818:9bae%5]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 13:26:14 +0000
From:   Gowthami Thiagarajan <gthiagarajan@marvell.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: RE: [EXT] Re: [PATCH 3/6] perf/marvell : Odyssey LLC-TAD performance
 monitor support
Thread-Topic: [EXT] Re: [PATCH 3/6] perf/marvell : Odyssey LLC-TAD performance
 monitor support
Thread-Index: AQHZzSQHepKdKzDa8EaGKWjytks74K/rXUqAgAMcUhA=
Date:   Thu, 17 Aug 2023 13:26:14 +0000
Message-ID: <SN1PR18MB2126C98535D07FA5E958B2ACDB1AA@SN1PR18MB2126.namprd18.prod.outlook.com>
References: <20230630120351.1143773-1-gthiagarajan@marvell.com>
 <20230630120351.1143773-4-gthiagarajan@marvell.com>
 <ZMPg8RNxEeHQNdqb@FVFF77S0Q05N>
 <SN1PR18MB21262B71F310B0AF33C2D2EFDB11A@SN1PR18MB2126.namprd18.prod.outlook.com>
 <ZNt8f1Ui13SoxOUT@FVFF77S0Q05N>
In-Reply-To: <ZNt8f1Ui13SoxOUT@FVFF77S0Q05N>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3RoaWFnYXJh?=
 =?us-ascii?Q?amFuXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02?=
 =?us-ascii?Q?Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYTE0M2Y2ZWMtM2QwMS0xMWVlLTljNGYt?=
 =?us-ascii?Q?ZWFmOGQ2YzU4YWYzXGFtZS10ZXN0XGExNDNmNmVkLTNkMDEtMTFlZS05YzRm?=
 =?us-ascii?Q?LWVhZjhkNmM1OGFmM2JvZHkudHh0IiBzej0iNDY2NSIgdD0iMTMzMzY3NTIz?=
 =?us-ascii?Q?NzE2Mzc5NTMyIiBoPSJzdHJ2Yk02MDg2WW1IVWlzVjdJVzIrM3I2cHc9IiBp?=
 =?us-ascii?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFH?=
 =?us-ascii?Q?SVdBQUNNTTdCakR0SFpBZjVydHVJNlYwMFIvbXUyNGpwWFRSRVpBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFCdUR3QUEzZzhBQUlRR0FBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBUUVCQUFBQTlSZW5Md0NBQVFBQUFBQUFBQUFBQUo0QUFBQmhB?=
 =?us-ascii?Q?R1FBWkFCeUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQWRRQnpBSFFBYndCdEFG?=
 =?us-ascii?Q?OEFjQUJsQUhJQWN3QnZBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
 =?us-ascii?Q?QUNBQUFBQUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBBWHdCd0FHZ0Fid0J1QUdV?=
 =?us-ascii?Q?QWJnQjFBRzBBWWdCbEFISUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?akFIVUFjd0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFaQUJoQUhNQWFBQmZBSFlB?=
 =?us-ascii?Q?TUFBeUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5n?=
 =?us-ascii?Q?QUFBR01BZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdCckFHVUFlUUIzQUc4?=
 =?us-ascii?Q?QWNnQmtBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVl3QjFBSE1BZEFC?=
 =?us-ascii?Q?dkFHMEFYd0J6QUhNQWJnQmZBRzRBYndCa0FHVUFiQUJwQUcwQWFRQjBBR1VB?=
 =?us-ascii?Q?Y2dCZkFIWUFNQUF5QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFB?=
 =?us-ascii?Q?QUFBQUFBQUlBQUFBQUFKNEFBQUJqQUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1?=
 =?us-ascii?Q?QUY4QWN3QndBR0VBWXdCbEFGOEFkZ0F3QURJQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFB?=
 =?us-ascii?Q?bmdBQUFHUUFiQUJ3QUY4QWN3QnJBSGtBY0FCbEFGOEFZd0JvQUdFQWRBQmZB?=
 =?us-ascii?Q?RzBBWlFCekFITUFZUUJuQUdVQVh3QjJBREFBTWdBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWkFCc0FIQUFY?=
 =?us-ascii?Q?d0J6QUd3QVlRQmpBR3NBWHdCakFHZ0FZUUIwQUY4QWJRQmxBSE1BY3dCaEFH?=
 =?us-ascii?Q?Y0FaUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmtBR3dB?=
 =?us-ascii?Q?Y0FCZkFIUUFaUUJoQUcwQWN3QmZBRzhBYmdCbEFHUUFjZ0JwQUhZQVpRQmZB?=
 =?us-ascii?Q?R1lBYVFCc0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdVQWJRQmhBR2tBYkFCZkFHRUFa?=
 =?us-ascii?Q?QUJrQUhJQVpRQnpBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUVnQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dBWHdCd0FISUFid0JxQUdVQVl3?=
 =?us-ascii?Q?QjBBRjhBYmdCaEFHMEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhR?=
 =?us-ascii?Q?QWFRQmhBR3dBWHdCaEFHd0Fid0J1QUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFH?=
 =?us-ascii?Q?RUFjZ0IyQUdVQWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFC?=
 =?us-ascii?Q?bEFITUFYd0J5QUdVQWN3QjBBSElBYVFCakFIUUFaUUJrQUY4QVlRQnNBRzhB?=
 =?us-ascii?Q?YmdCbEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUY4?=
 =?us-ascii?Q?QWNBQnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFISUFaUUJ6?=
 =?us-ascii?Q?QUhRQWNnQnBBR01BZEFCbEFHUUFYd0JvQUdVQWVBQmpBRzhBWkFCbEFITUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUdFQWNnQnRBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refthree: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFB?=
 =?us-ascii?Q?QUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFad0J2QUc4?=
 =?us-ascii?Q?QVp3QnNBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdB?=
 =?us-ascii?Q?QUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhB?=
 =?us-ascii?Q?WXdCdkFHUUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0Js?=
 =?us-ascii?Q?QUd3QWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QmpBRzhBWkFCbEFITUFY?=
 =?us-ascii?Q?d0JrQUdrQVl3QjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFB?=
 =?us-ascii?Q?QUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlB?=
 =?us-ascii?Q?RzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFR?=
 =?us-ascii?Q?QmtBR1VBYmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQU1BQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFu?=
 =?us-ascii?Q?Z0FBQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFG?=
 =?us-ascii?Q?OEFiZ0JoQUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFBYVFC?=
 =?us-ascii?Q?aEFHd0FYd0J0QUdFQWNnQjJBR1VBYkFCc0FGOEFid0J5QUY4QVlRQnlBRzBB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpB?=
 =?us-ascii?Q?SFFBWHdCdUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0QWRB?=
 =?us-ascii?Q?QnBBR0VBYkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0JuQUc4?=
 =?us-ascii?Q?QWJ3Qm5BR3dBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFj?=
 =?us-ascii?Q?Z0IyQUdVQWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFH?=
 =?us-ascii?Q?VUFjd0JmQUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VBY2dC?=
 =?us-ascii?Q?MkFHVUFiQUJzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3?=
 =?us-ascii?Q?QndBSElBYndCcUFHVUFZd0IwQUY4QWJnQmhBRzBBWlFCekFGOEFjZ0JsQUhN?=
 =?us-ascii?Q?QWRBQnlBR2tBWXdCMEFHVUFaQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2?=
 =?us-ascii?Q?QUhJQVh3QmhBSElBYlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhRQVpRQnlBRzBBYVFC?=
 =?us-ascii?Q?dUFIVUFjd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdF?=
 =?us-ascii?Q?QWNnQjJBR1VBYkFCc0FGOEFkd0J2QUhJQVpBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFVQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBaEFZQUFBQUFBQUFjQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFEN0R4eG9lMmkrUTZkdW9EYnF4d2R3SEFB?=
x-dg-reffive: =?us-ascii?Q?QUFBRUFBQUFBQUFBQUpnclJRazJlVEVLT3dCQWNBYXkxcGlvQUFBQUJBQUFB?=
 =?us-ascii?Q?SWdBQUFBQUFBQUJqQUc4QWJnQm1BR2tBWkFCbEFHNEFkQUJwQUdFQWJBQUFB?=
 =?us-ascii?Q?Qm9HQUFBWkFBQUFHQUFBQUFBQUFBQmhBR1FBWkFCeUFHVUFjd0J6QUFBQUpB?=
 =?us-ascii?Q?QUFBQVFBQUFCakFIVUFjd0IwQUc4QWJRQmZBSEFBWlFCeUFITUFid0J1QUFB?=
 =?us-ascii?Q?QUxnQUFBQUFBQUFCakFIVUFjd0IwQUc4QWJRQmZBSEFBYUFCdkFHNEFaUUJ1?=
 =?us-ascii?Q?QUhVQWJRQmlBR1VBY2dBQUFEQUFBQUFBQUFBQVl3QjFBSE1BZEFCdkFHMEFY?=
 =?us-ascii?Q?d0J6QUhNQWJnQmZBR1FBWVFCekFHZ0FYd0IyQURBQU1nQUFBREFBQUFBQUFB?=
 =?us-ascii?Q?QUFZd0IxQUhNQWRBQnZBRzBBWHdCekFITUFiZ0JmQUdzQVpRQjVBSGNBYndC?=
 =?us-ascii?Q?eUFHUUFjd0FBQUQ0QUFBQUFBQUFBWXdCMUFITUFkQUJ2QUcwQVh3QnpBSE1B?=
 =?us-ascii?Q?YmdCZkFHNEFid0JrQUdVQWJBQnBBRzBBYVFCMEFHVUFjZ0JmQUhZQU1BQXlB?=
 =?us-ascii?Q?QUFBTWdBQUFBQUFBQUJqQUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QWN3?=
 =?us-ascii?Q?QndBR0VBWXdCbEFGOEFkZ0F3QURJQUFBQStBQUFBQUFBQUFHUUFiQUJ3QUY4?=
 =?us-ascii?Q?QWN3QnJBSGtBY0FCbEFGOEFZd0JvQUdFQWRBQmZBRzBBWlFCekFITUFZUUJu?=
 =?us-ascii?Q?QUdVQVh3QjJBREFBTWdBQUFEWUFBQUFBQUFBQVpBQnNBSEFBWHdCekFHd0FZ?=
 =?us-ascii?Q?UUJqQUdzQVh3QmpBR2dBWVFCMEFGOEFiUUJsQUhNQWN3QmhBR2NBWlFBQUFE?=
 =?us-ascii?Q?Z0FBQUFBQUFBQVpBQnNBSEFBWHdCMEFHVUFZUUJ0QUhNQVh3QnZBRzRBWlFC?=
 =?us-ascii?Q?a0FISUFhUUIyQUdVQVh3Qm1BR2tBYkFCbEFBQUFKQUFBQUJJQUFBQmxBRzBB?=
 =?us-ascii?Q?WVFCcEFHd0FYd0JoQUdRQVpBQnlBR1VBY3dCekFBQUFXQUFBQUFBQUFBQnRB?=
 =?us-ascii?Q?R0VBY2dCMkFHVUFiQUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0J1QUdFQWJR?=
 =?us-ascii?Q?QmxBSE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRBZEFCcEFHRUFiQUJmQUdF?=
 =?us-ascii?Q?QWJBQnZBRzRBWlFBQUFGUUFBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FYd0J3?=
 =?us-ascii?Q?QUhJQWJ3QnFBR1VBWXdCMEFGOEFiZ0JoQUcwQVpRQnpBRjhBY2dCbEFITUFk?=
 =?us-ascii?Q?QUJ5QUdrQVl3QjBBR1VBWkFCZkFHRUFiQUJ2QUc0QVpRQUFBRm9BQUFBQUFB?=
 =?us-ascii?Q?QUFiUUJoQUhJQWRnQmxBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBYmdC?=
 =?us-ascii?Q?aEFHMEFaUUJ6QUY4QWNnQmxBSE1BZEFCeUFHa0FZd0IwQUdVQVpBQmZBR2dB?=
 =?us-ascii?Q?WlFCNEFHTUFid0JrQUdVQWN3QUFBQ0FBQUFB?=
x-dg-refsix: =?us-ascii?Q?QUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFHRUFjZ0J0QUFBQUpnQUFBQUFB?=
 =?us-ascii?Q?QUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBWndCdkFHOEFad0JzQUdVQUFBQTBB?=
 =?us-ascii?Q?QUFBQUFBQUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3?=
 =?us-ascii?Q?QjBBRjhBWXdCdkFHUUFaUUJ6QUFBQVBnQUFBQUFBQUFCdEFHRUFjZ0IyQUdV?=
 =?us-ascii?Q?QWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBR01BYndCa0FHVUFjd0Jm?=
 =?us-ascii?Q?QUdRQWFRQmpBSFFBQUFCZUFBQUFBd0FBQUcwQVlRQnlBSFlBWlFCc0FHd0FY?=
 =?us-ascii?Q?d0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFiZ0JoQUcwQVpRQnpBRjhBWXdCdkFH?=
 =?us-ascii?Q?NEFaZ0JwQUdRQVpRQnVBSFFBYVFCaEFHd0FYd0J0QUdFQWNnQjJBR1VBYkFC?=
 =?us-ascii?Q?c0FBQUFiQUFBQUFBQUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhB?=
 =?us-ascii?Q?YWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFRQmtB?=
 =?us-ascii?Q?R1VBYmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUJmQUc4QWNn?=
 =?us-ascii?Q?QmZBR0VBY2dCdEFBQUFjZ0FBQUFBQUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4?=
 =?us-ascii?Q?QWNBQnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1?=
 =?us-ascii?Q?QUdZQWFRQmtBR1VBYmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0Fi?=
 =?us-ascii?Q?QUJmQUc4QWNnQmZBR2NBYndCdkFHY0FiQUJsQUFBQVdnQUFBQUFBQUFCdEFH?=
 =?us-ascii?Q?RUFjZ0IyQUdVQWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFC?=
 =?us-ascii?Q?dEFHVUFjd0JmQUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VB?=
 =?us-ascii?Q?Y2dCMkFHVUFiQUJzQUFBQWFBQUFBQUFBQUFCdEFHRUFjZ0IyQUdVQWJBQnNB?=
 =?us-ascii?Q?RjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUhJQVpR?=
 =?us-ascii?Q?QnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VBY2dCMkFHVUFiQUJzQUY4?=
 =?us-ascii?Q?QWJ3QnlBRjhBWVFCeUFHMEFBQUFxQUFBQUFBQUFBRzBBWVFCeUFIWUFaUUJz?=
 =?us-ascii?Q?QUd3QVh3QjBBR1VBY2dCdEFHa0FiZ0IxQUhNQUFBQWlBQUFBQlFBQUFHMEFZ?=
 =?us-ascii?Q?UUJ5QUhZQVpRQnNBR3dBWHdCM0FHOEFjZ0JrQUFBQSIvPjwvbWV0YT4=3D?=
x-dg-tag-bcast: {BB38C8B4-BBDA-40C5-8168-0013E523D1A2}
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR18MB2126:EE_|SA0PR18MB3695:EE_
x-ms-office365-filtering-correlation-id: 61bac6f2-3275-4387-c3fc-08db9f2587f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sofuIRORZUAQETP7sRUIXZe4Kexe7ZHJQcHQ2MW/dWi7RY1Cpgk/qxycfmGYf1pnByZ3NZ+4hR2PAxdv79SY8dXjXeDZU2Sxc14AkjIDE0F6uTqL8x9Bm7CkImAT6D7cx3xmEuTBd78JJfvlMAk4EWGojI/W8GL2d/bFssE57GAqiKJV/myZ79af0dj5Q009BYW5N6D+wft1Q7jaujrx+kTxIwG9n61HFwMU38HqQbj0eQ1w9B5QBb3rHjCOsPsFI1V3dFjGdqej03O+0gKGZx8hHbQazgAkyg2UBb6ehkM/frUblEuCSDfr2cwe8t+9HArH6MjzxLRSHR3nICVHrPbJ0QEYmDjrFb3XeS7WSewdxTICiYFzJU7KrNU4Dwr73HYYtMXnY35RkUHqYO02qyCVRhMEMCAAk36CcStCCZTfyF9J1rsZlrPFUFOFCpWR6sVbBgP1RVsongKIrjug2Bx4cCeo6JfS+ZYihxrBZ/BTZWaRcn0lDJbFgLJv/mmEaTeoLP1Tgv9OTTk7womcRPF9+UcApTeoCtVupaeICyjpDwq7mWEc32kWEg7dneOMMihd0qKXsPrgKRl18pMx86eMKSGEzy4JqUA7Brn8IIgFwgV3A3nGbIRAMUclbkU5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR18MB2126.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199024)(186009)(1800799009)(316002)(54906003)(110136005)(66946007)(66476007)(76116006)(66556008)(64756008)(66446008)(122000001)(5660300002)(41300700001)(52536014)(38100700002)(38070700005)(8676002)(8936002)(4326008)(26005)(2906002)(83380400001)(55016003)(478600001)(86362001)(9686003)(53546011)(33656002)(7696005)(6506007)(107886003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?olUL7WJykXF2WIpxrtBPvYX+u5QJKtHSeaWAPydZMER+17JT45Qt4BsSzvSq?=
 =?us-ascii?Q?xNYnzb2WncPSeaH0FfRDEAkU6qpM0mK++VTNmUeur15br8vnrunFuRtQ1Jiz?=
 =?us-ascii?Q?iSTzX+vSc8l/R1PGosBFlUwQ34aZrnNJCCV75F6BeT1lE7j6ZEzal8kRGOPk?=
 =?us-ascii?Q?ZkFSk6wuSaJklJEEabUSOUsul52innLyyes1/4PnILszs2T1ENZeoHfxWB1W?=
 =?us-ascii?Q?IremRjAUdWMbbaR9ijHXG9ltjcx9cYuPIUGnrU6+5ugngem6pSw40APA34/O?=
 =?us-ascii?Q?3OxkeXj3o/xKZpQcwpwJ66UQi/hKlzGceY3gcPYJIhLO0saprA16weiE8Nds?=
 =?us-ascii?Q?s42MCUwFd1NUuyYD1F4tgnPBqNJZMGoTFU2YubO+UNRd4h+OIDpbWG7P+M5H?=
 =?us-ascii?Q?ezOkyQx7WPGFLRwbRR5R1kJWlOA8JAwamKco26onGiUsQN4TtPNYwrNL366D?=
 =?us-ascii?Q?Oy9TdGwJmtNwsAkiPXitq7VsXLrZcnhyFWCdYbnAjqp4CUywSbqkp+ZI3mn/?=
 =?us-ascii?Q?JJULtxtvJHK6uwcP9nv+BjzYd0j7btFX0u4XUIkLRSQj3Ax9SLVrnzFmIjrk?=
 =?us-ascii?Q?VaCvMXxG14cg6mrbU5lygEDB9GtzAGnZb0Vj6GCxSdXfe52M3bY790LSOjXR?=
 =?us-ascii?Q?v2vbZKeLHy6G8ygFnMLWzg/ISKduP8O+1y5yuSmVxw27U8p+1sYOsUtgkSCK?=
 =?us-ascii?Q?TfZZXvBDwZf2OBMcvAzaed+ddOy7oK8DofeiSZ/xo04uiuVI5+foFYVN0LiE?=
 =?us-ascii?Q?4qEmOLIw7WHw3OXOnd979a3JOyzDkE5SimWM1mu7W8SJxc0OgxKL8f0a8opc?=
 =?us-ascii?Q?iA1qAQdMbljMP4lwNA76LM6SdR/wV8GD+jCTjCoFky5jX6+t00nxBBFpWcd1?=
 =?us-ascii?Q?s52fNOVmd4cbB3FhXYx5bgBcc0PiMhysiFftOmc/QGLhXVXHigoih8I4JY4r?=
 =?us-ascii?Q?AxTe7tvVk44WoFls6sNj7pf1oBZ5Gyc7KgkBlu61uwE893I/Z/1N0f076Q5T?=
 =?us-ascii?Q?pnpzOLGYDYWfvYJZBpdCFYbmNNn+vTu0UaYBRCG4tHUjCwzH60GrSkx99e+U?=
 =?us-ascii?Q?vXCazHyUReCjTt8zpYXcsJZtnRu1IOZ2YeREuSnDQ0PJpN+81uG4zp3m3TqE?=
 =?us-ascii?Q?kq5TanqH0VyL7qyIWNs2POio5rUpNNFeibL4NUiZgKmrjPdkacJbRXU3gy/O?=
 =?us-ascii?Q?dpAje6JS+cjvEdDYRK8RZpdi3azgVVCsgemOv/Wzej5Ces/xPACqTNxH6Jsf?=
 =?us-ascii?Q?SBGivXZ19l6qtw4r0csMp/vxraAz9UO2rOnBJ2HaUDBZz8B7K2fERlvKfgZp?=
 =?us-ascii?Q?0Sl/xe1faoAlLoaWURVGHvZoCipTIG4Wb3PeMzgOf340xX5dROQwjRgm2Nj3?=
 =?us-ascii?Q?8I+Jlv5nhZtwh0R4ULswnv7NwwAexMqiU7RMG6/RvmoCBmQqgsxLFd887UmA?=
 =?us-ascii?Q?pxwMWLqz8r95lYh2DaEgFc/MtbZfuncVsILaCW1bj/J/9hCB+e0LsRuNDbTI?=
 =?us-ascii?Q?nsX1pAd05HEHdg8jVb0XWnB8hxiZevrMO5m0Jrf2FJx0ioNIXUFzx2jhlgix?=
 =?us-ascii?Q?v6ibnQ9broEmqGmwl77WhhMsvV84NB1XlYpkNayu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR18MB2126.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bac6f2-3275-4387-c3fc-08db9f2587f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 13:26:14.6419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U0vTK4L6xX14WcQKB+/+fSVBM2U8cPeaVGk7JvguJiqwYilqKinjykN+3gDaCKoS3B8gghit7Hate0I+35i6BElPYDQaLANmL8JGLuIByyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3695
X-Proofpoint-GUID: yKeEshyI2m2ONPmqZF2kCeTxqTL0LcKJ
X-Proofpoint-ORIG-GUID: yKeEshyI2m2ONPmqZF2kCeTxqTL0LcKJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_06,2023-08-17_02,2023-05-22_02
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark/Will,

> -----Original Message-----
> From: Mark Rutland <mark.rutland@arm.com>
> Sent: Tuesday, August 15, 2023 6:54 PM
> To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> Cc: will@kernel.org; linux-arm-kernel@lists.infradead.org; linux-kernel@v=
ger.kernel.org; Sunil Kovvuri
> Goutham <sgoutham@marvell.com>; Bharat Bhushan <bbhushan2@marvell.com>; G=
eorge Cherian
> <gcherian@marvell.com>; Linu Cherian <lcherian@marvell.com>
> Subject: [EXT] Re: [PATCH 3/6] perf/marvell : Odyssey LLC-TAD performance=
 monitor support
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Sat, Aug 12, 2023 at 01:51:00PM +0000, Gowthami Thiagarajan wrote:
> > > -----Original Message-----
> > > From: Mark Rutland <mark.rutland@arm.com>
> > > Sent: Friday, July 28, 2023 9:08 PM
> > > To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> > > Cc: will@kernel.org; linux-arm-kernel@lists.infradead.org; linux-kern=
el@vger.kernel.org; Sunil
> Kovvuri
> > > Goutham <sgoutham@marvell.com>; Bharat Bhushan <bbhushan2@marvell.com=
>; George Cherian
> > > <gcherian@marvell.com>; Linu Cherian <lcherian@marvell.com>
> > > Subject: [EXT] Re: [PATCH 3/6] perf/marvell : Odyssey LLC-TAD perform=
ance monitor support
> > >
> > > External Email
> > >
> > > ---------------------------------------------------------------------=
-
> > > On Fri, Jun 30, 2023 at 05:33:48PM +0530, Gowthami Thiagarajan wrote:
>=20
> > > > +static int tad_pmu_event_counter_add(struct perf_event *event, int=
 flags)
> > > > +{
>=20
> > > > +	if (!event->attr.disabled)
> > > > +		return -EINVAL;
> > >
> > > Why?
> > Just checks the default disabled attribute.
>=20
> Why does it matter?
>=20
> What's the problem with opening an event which is *not* disabled?
>=20
> [...]
Checked this. Don't find the significance of the validation. Can be removed=
.
>=20
> > > > +static int tad_pmu_probe(struct platform_device *pdev)
> > > > +{
> > > > +	struct device *dev =3D &pdev->dev;
> > > > +	struct tad_region *regions;
> > > > +	struct tad_pmu *tad_pmu;
> > > > +	struct resource *res;
> > > > +	u32 tad_pmu_page_size;
> > > > +	u32 tad_page_size;
> > > > +	u32 tad_cnt;
> > > > +	int i, ret;
> > > > +	char *name;
> > > > +
> > > > +	tad_pmu =3D devm_kzalloc(&pdev->dev, sizeof(*tad_pmu), GFP_KERNEL=
);
> > > > +	if (!tad_pmu)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	platform_set_drvdata(pdev, tad_pmu);
> > > > +
> > > > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > +	if (!res) {
> > > > +		dev_err(&pdev->dev, "Mem resource not found\n");
> > > > +		return -ENODEV;
> > > > +	}
> > > > +
> > > > +	ret =3D device_property_read_u32(dev, "marvell,tad-page-size", &t=
ad_page_size);
> > > > +	if (ret) {
> > > > +		dev_err(&pdev->dev, "Can't find tad-page-size property\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	ret =3D device_property_read_u32(dev, "marvell,tad-pmu-page-size"=
,
> > > > +				       &tad_pmu_page_size);
> > > > +	if (ret) {
> > > > +		dev_err(&pdev->dev, "Can't find tad-pmu-page-size property\n");
> > > > +		return ret;
> > > > +	}
> > >
> > > Why do you think these properties are necessary?
> > >
> > > These should almost certainly be provided by IO resources, and should=
n't need a
> > > custom property.
> >
> > IO resources don't provide all the information in this case. Need to va=
ry these values
> > at different boot times. So, kept these custom properties.
>=20
> I think the only rason the information is missing is that your DT binding=
 isn't quite right.
>=20
> Later on you do:
>=20
> +       for (i =3D 0; i < tad_cnt && res->start < res->end; i++) {
> +               regions[i].base =3D devm_ioremap(&pdev->dev,
> +                                              res->start,
> +                                              tad_pmu_page_size);
> +               if (IS_ERR(regions[i].base)) {
> +                       dev_err(&pdev->dev, "TAD%d ioremap fail\n", i);
> +                       return -ENOMEM;
> +               }
> +               res->start +=3D tad_page_size;
> +       }
>=20
> ... which means you're splitting one reg entry into multiple mappings, wh=
ereas
> you could have multiple reg entries, one per TAD page.

These properties are updated by the firmware at runtime. In order to avoid =
the firmware updating multiple nodes, a single node for the entire system h=
as been kept. So that the firmware can just update at a single place  .

Thanks,
Gowthami

>=20
> Thanks,
> Mark.
