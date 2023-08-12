Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F1377A035
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 15:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjHLNvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 09:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjHLNvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 09:51:15 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800C4198B
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 06:51:18 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37CCNm2K005232;
        Sat, 12 Aug 2023 06:51:03 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3se7en0guv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Aug 2023 06:51:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxb1QWrbrKz8ToPP4eO5Kqg8aYCcHzCSedBd/0P2kOxhlsKg4s5yik9m3wZCPKKlFdlQfRHXNkZLLCXTAXVfPHCCFeQ8LMdvrdOTnkc1lLKBSHNz3pnb+AYB7wmv+0tKR4cdurhOXDftrw5ihdRxmC6gNcqc26EOPrKxs1ZKNnxCsNAzvsLYFgzKMPYVg6d6oH1Va5IrLVZdFCRQ0PBOjoJN5SCd+5JfQSS3kmLe/L85+GLlBYkx72005jm6RX3wOuf3cncfJCM34c8uYZAi5dcBt+i+BEACR3mHcItLCShQFFgXv7JOcGhPaB5jyob9bjsk/MghF3xYBIeQWtXaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYCkL25OaAtuKzHd/3c1KWHT2cRGDP9pqxfEkAqFN5k=;
 b=YNkBUpU6DMunV7YG0vbvv15S0lulvQeUlAMCNDRh7FvxJsb2rW1M1Cyj9pq0922runAw1R56rqneYdp8Ese5wGo49OIi9DX7l2pvV7xDg3v6ApION/E/3nruKSiP7bmn8L0rMUkposu8X/oroG7WJ/Joh2OSukb/rSgdo9G83XQkLHgKjQJU0ZMKWlzQsKHrm5FIMeO4nXRoUVDzpf4hQphGJZmM5uWB1dHYgDdqXoUPJKnW1oTATfHBDbagB8eSpzRHhXmckVhCUclLWSPDFNsQIRqZn+aaoTDFGRzx83rYMpmp2K56goJIjUN2qB3UtSB5z4x54f+AgXsu/apFJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYCkL25OaAtuKzHd/3c1KWHT2cRGDP9pqxfEkAqFN5k=;
 b=j+XYwkj7GrCozpn9WD4NfKrM9RRSiKEU7D1IMDzYGrp2jcDnN7bL+Ax559ofKEXyWWWN87F6zlkt6nz5b+CwA8CrJTwhBtFpLKmmrolKNFBVudk1+nV2WRUr0ndcDrSSaQOb+Y7Uj4vNTaMhZt7/QvYlbSgb7ItwUPfwi/ZsNSQ=
Received: from SN1PR18MB2126.namprd18.prod.outlook.com (2603:10b6:802:29::29)
 by SA0PR18MB3645.namprd18.prod.outlook.com (2603:10b6:806:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.23; Sat, 12 Aug
 2023 13:51:01 +0000
Received: from SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::cb4d:3836:d818:9bae]) by SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::cb4d:3836:d818:9bae%5]) with mapi id 15.20.6678.023; Sat, 12 Aug 2023
 13:51:01 +0000
From:   Gowthami Thiagarajan <gthiagarajan@marvell.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: Re: [PATCH 3/6] perf/marvell : Odyssey LLC-TAD performance monitor
 support
Thread-Topic: [PATCH 3/6] perf/marvell : Odyssey LLC-TAD performance monitor
 support
Thread-Index: AQHZzSQHepKdKzDa8EaGKWjytks74A==
Date:   Sat, 12 Aug 2023 13:51:00 +0000
Message-ID: <SN1PR18MB21262B71F310B0AF33C2D2EFDB11A@SN1PR18MB2126.namprd18.prod.outlook.com>
References: <20230630120351.1143773-1-gthiagarajan@marvell.com>
 <20230630120351.1143773-4-gthiagarajan@marvell.com>
 <ZMPg8RNxEeHQNdqb@FVFF77S0Q05N>
In-Reply-To: <ZMPg8RNxEeHQNdqb@FVFF77S0Q05N>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3RoaWFnYXJh?=
 =?us-ascii?Q?amFuXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02?=
 =?us-ascii?Q?Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNDJlZDBhYjktMzkxNy0xMWVlLTljNGYt?=
 =?us-ascii?Q?ZWFmOGQ2YzU4YWYzXGFtZS10ZXN0XDQyZWQwYWJhLTM5MTctMTFlZS05YzRm?=
 =?us-ascii?Q?LWVhZjhkNmM1OGFmM2JvZHkudHh0IiBzej0iNTMyOCIgdD0iMTMzMzYzMjE4?=
 =?us-ascii?Q?NTc3Mjg1MzM4IiBoPSI4YTlna3FRUExrZ3BDVCtLU1ZmYStyRFNLZzg9IiBp?=
 =?us-ascii?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFH?=
 =?us-ascii?Q?SVdBQURhNEdZRkpNM1pBUTJaemgrSzgvL21EWm5PSDRyei8rWVpBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFCdUR3QUEzZzhBQUlRR0FBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBUUVCQUFBQUk3cVRwQUNBQVFBQUFBQUFBQUFBQUo0QUFBQmhB?=
 =?us-ascii?Q?R1FBWkFCeUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQWRRQnpBSFFBYndCdEFG?=
 =?us-ascii?Q?OEFjQUJsQUhJQWN3QnZBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFnQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUNnQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUlBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFu?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBaEFZQUFBQUFBQUFjQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFEN0R4eG9lMmkrUTZkdW9EYnF4d2R3SEFB?=
x-dg-reffive: =?us-ascii?Q?QUFBRUFBQUFBQUFBQTEwZ2ZjYjFMc2tlUE9yNUh2UEUxcXlvQUFBQUJBQUFB?=
 =?us-ascii?Q?SWdBQUFBQUFBQUJqQUc4QWJnQm1BR2tBWkFCbEFHNEFkQUJwQUdFQWJBQUFB?=
 =?us-ascii?Q?Qm9HQUFBWkFBQUFHQUFBQUFBQUFBQmhBR1FBWkFCeUFHVUFjd0J6QUFBQUpB?=
 =?us-ascii?Q?QUFBQUlBQUFCakFIVUFjd0IwQUc4QWJRQmZBSEFBWlFCeUFITUFid0J1QUFB?=
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
 =?us-ascii?Q?a0FISUFhUUIyQUdVQVh3Qm1BR2tBYkFCbEFBQUFKQUFBQUFvQUFBQmxBRzBB?=
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
 =?us-ascii?Q?QUdRQWFRQmpBSFFBQUFCZUFBQUFBZ0FBQUcwQVlRQnlBSFlBWlFCc0FHd0FY?=
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
 =?us-ascii?Q?QUd3QVh3QjBBR1VBY2dCdEFHa0FiZ0IxQUhNQUFBQWlBQUFBQkFBQUFHMEFZ?=
 =?us-ascii?Q?UUJ5QUhZQVpRQnNBR3dBWHdCM0FHOEFjZ0JrQUFBQSIvPjwvbWV0YT4=3D?=
x-dg-tag-bcast: {BB38C8B4-BBDA-40C5-8168-0013E523D1A2}
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR18MB2126:EE_|SA0PR18MB3645:EE_
x-ms-office365-filtering-correlation-id: b2dcc2b2-ceb1-42ea-0d58-08db9b3b29d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S+viRqZQbj3QoEhuOfoxefkc+3AAxacDmr6TJclofs4nlcDi+oP9anxD0eTuyG7pW2SoAz/M+phJMPKgRq/Yga4qB/FCyjPjwhnCCdAQQJF+KSrvw2KfNfobUIs7zJ+1g35HeAWuvWr2OdGDcwGYeRlhuJuTJFmhySXYfx/udVs4fetgj4Unqst8M3hR7DhyQYf3wZGltNQ4JyY+O2R2oGr7wY+3I5xCSOGwFoy7eAzNR9oTMimZthCrhJeZhafV5AztDmxnf9cf10EgKOlWWPFIxwvdJGVU51yyJqdZ6nZwZPWVWMjj4SKJEoe4Nob0m4aQg1T9FIJ4614op9FiGYah5dxMmvzFzobxeusKP49cdm6/NCuG7IzcZbDHxuB+FxWAInKPwk+OyDNXboxGwWiT/5KBTr4v5uYRHMThOp+JW6IoXekneuIspn6NeCs7wcEkq+MxNW1aqTKdnewxHFVyi4yLywaNcObQxgV5no4PAT8ScYMACkTLU3NzW8QMPI+ghzJopiWq5EN7Pd2UDQbziNUByGcAyH0UA8Vi/3VfM/oSRWYtAY0+ZB9XaYYuov6eI+GVtz7CEX4NpSgWhe4PyEwu2Ze1/tTAvoGEHgoWS82CG9J08FhyhsJ+T/9n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR18MB2126.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(346002)(39860400002)(376002)(186006)(451199021)(1800799006)(26005)(66946007)(66446008)(66476007)(66556008)(41300700001)(316002)(54906003)(76116006)(53546011)(7696005)(6916009)(6506007)(64756008)(478600001)(107886003)(5660300002)(8676002)(4326008)(52536014)(8936002)(9686003)(2906002)(83380400001)(71200400001)(38070700005)(38100700002)(122000001)(33656002)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WB12u9LQ47rPqtu5JweyibwAR7H1Wy55NXk/WCCX0zzwlN9qbOEKGvku9wIS?=
 =?us-ascii?Q?imH+J6SbB04tW6yv5d73GS0bZI99TqaTfTo/3HQP4HyQB7VsuiYweJlo20Po?=
 =?us-ascii?Q?Up5M+S0B4nXzV4OgpXrirCjpLZ0FXoOqQnSEFioxCR8sKijW84MucGkwOYa9?=
 =?us-ascii?Q?ju/TUxP494uLKOZKsWieXfapfjzRDuau3SrQyxr4ghwxiRbzclBGrG8siug/?=
 =?us-ascii?Q?GiN8lq/JFOBC+T1q5u3ez6b4cIXswPXfJ9NLFZJrSNACeS42tt7UMGhcMmgJ?=
 =?us-ascii?Q?xZ2bqtOeJ2+P/hitk/dnVxR06V2gAUkOCnbnOs/xAMkOZu+fvtv5AGe4SDWS?=
 =?us-ascii?Q?fnK/5N/LsvLWoy+4idMfETh9nHhjWegAr4xOFnQSGArYj0yMMdai43htGukL?=
 =?us-ascii?Q?jCDe2LfLliQ676H59XKt0GVRWEO8ZUq13UFpZlVmzhBGxbr2hydVfHY9ns/u?=
 =?us-ascii?Q?0sPsShSukOl3QnNIR7R41yrbMGSWf46fquFWuFT5anD1Vq6rNcWy45p6L7GR?=
 =?us-ascii?Q?/2ft/5CuzGmLMkjp89iayPVmwwc/6Pc4oZE2OUgI8b3A1tfbJyWX62n2bLRx?=
 =?us-ascii?Q?QEupMIjll4R9tGmRu3wfwQ/5D7ASTH/JpBAOLn7IO1gBvBkKNyrjKKiFnGcz?=
 =?us-ascii?Q?xIZbntEFvRPrXlCuIIBJPAQmGfOMzTLKdHOYOel2Bd78EJdlXP1ur7K8fLcu?=
 =?us-ascii?Q?adhl/cIGZgiE2tE2hVjnCXWA0krpWdkXSN24OZNLo9Z8JEw1TUonn7HINskA?=
 =?us-ascii?Q?VU5TBo/EI2t4tJ2RfRBN91/do4jRacH3q/hufqz2Cgfz5zIdgGBksitbo6sF?=
 =?us-ascii?Q?sd1kqviwP8+pAv1wMIbdIVFV0c1z7EkeYFChPLA/82hASydojOzrol9sTk0w?=
 =?us-ascii?Q?iFi8jR42K54y5ZtoQH54kKAmNE32J5H4MT68nYB0VUegL2700ruW/lrnkfc4?=
 =?us-ascii?Q?GKwSK/gKOMH7LvUJCec4pxSvhkwPLJnQyqiWAkvLKCqlNBPJ78wp1jBDpGPc?=
 =?us-ascii?Q?kadk76RDG/Coe0uopddtwh/V/V4kjzO5fayOLaKPIp0Ydi4Z7wU+934trLSb?=
 =?us-ascii?Q?LtRuY7AjglGSGf3fe1bh8MxLP0NNywtJAwKiCpWVJdiRId0t7iefspRmap/B?=
 =?us-ascii?Q?tI908QlnCwE4Kt552+sS7wrD1YrLZVVYFyDeKykPE7D2BL3Qvpsxx9XZxEBc?=
 =?us-ascii?Q?TOOjdnZGPg1FXRsKerCPaQgTrSr+K0J6ffD2TduKEIsXPMXdQKuv/koLWBr+?=
 =?us-ascii?Q?nllFQWYtA7SehUPfMV1ftTCaAu2cba3TpaZGmYr5lqEcta4NpgcHIxnOYZY3?=
 =?us-ascii?Q?dUAr09eItsBc9bSCtmxrshGW5JoB5Lvq1vuZsfVXih3EHga95cPDL4YoIHKH?=
 =?us-ascii?Q?lbUK5OVdS5bKPZB4Vs7DWd76tXsENF3giTRLWP9dezWHimQfByZf0d5+heMV?=
 =?us-ascii?Q?CZkEtA0UKbqFnk1cPj9R9yKkHRxi/CcCJrnY/cIN/kP606KVGDKR8poJLK5I?=
 =?us-ascii?Q?Vem86gfl2nmz1PrNGSBr+Eq0vWPl5rSCo6FJVq4kwlwagOPEu5BWhlxLsqdL?=
 =?us-ascii?Q?VV32g/5chR9nW/sxmDudAQgpGe9NRBoYSNnhIsQ7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR18MB2126.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2dcc2b2-ceb1-42ea-0d58-08db9b3b29d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2023 13:51:00.9928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v9vpcAzpUE2pKa5DL6rFFEVmr8xi+/47zZEZ/x7uvqiY1X6pM2VMqWd7CHb2t1WHXj8dSv3BF+VhWWsk7nDyatdpD4EzAeSQyTDF/hgbtFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3645
X-Proofpoint-GUID: gHwuZdF5AUpk2J6v91cmlTcBMlGFrFm4
X-Proofpoint-ORIG-GUID: gHwuZdF5AUpk2J6v91cmlTcBMlGFrFm4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-12_13,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Mark Rutland <mark.rutland@arm.com>
> Sent: Friday, July 28, 2023 9:08 PM
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
> On Fri, Jun 30, 2023 at 05:33:48PM +0530, Gowthami Thiagarajan wrote:
> > Each TAD provides eight 64-bit counters for monitoring
> > cache behavior.The driver always configures the same counter for
> > all the TADs. The user would end up effectively reserving one of
> > eight counters in every TAD to look across all TADs.
> > The occurrences of events are aggregated and presented to the user
> > at the end of running the workload. The driver does not provide a
> > way for the user to partition TADs so that different TADs are used for
> > different applications.
> >
> > The performance events reflect various internal or interface activities=
.
> > By combining the values from multiple performance counters, cache
> > performance can be measured in terms such as: cache miss rate, cache
> > allocations, interface retry rate, internal resource occupancy, etc.
> >
> > Each supported counter's event and formatting information is exposed
> > to sysfs at /sys/devices/tad/. Use perf tool stat command to measure
> > the pmu events. For instance:
> >
> > perf stat -e tad_hit_ltg,tad_hit_dtg <workload>
> >
> > Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
>=20
> This generally looks ok; I have a few comments below.
>=20
> [...]
>=20
> > +static void tad_pmu_event_counter_stop(struct perf_event *event, int f=
lags)
> > +{
> > +	struct tad_pmu *tad_pmu =3D to_tad_pmu(event->pmu);
> > +	struct hw_perf_event *hwc =3D &event->hw;
> > +	u32 counter_idx =3D hwc->idx;
> > +	int tad_region;
> > +
> > +	/* TAD()_PFC() stop counting on the write
> > +	 * which sets TAD()_PRF()[CNTSEL] =3D=3D 0
> > +	 */
>=20
> Please fix the comment style.
>=20
> Likewise for all other instances within this file.
>=20
> [...]
Ack.
>=20
> > +static int tad_pmu_event_counter_add(struct perf_event *event, int fla=
gs)
> > +{
> > +	struct tad_pmu *tad_pmu =3D to_tad_pmu(event->pmu);
> > +	struct hw_perf_event *hwc =3D &event->hw;
> > +	int idx;
> > +
> > +	/* Get a free counter for this event */
> > +	idx =3D find_first_zero_bit(tad_pmu->counters_map, TAD_MAX_COUNTERS);
> > +	if (idx =3D=3D TAD_MAX_COUNTERS)
> > +		return -EAGAIN;
> > +
> > +	set_bit(idx, tad_pmu->counters_map);
> > +
> > +	hwc->idx =3D idx;
> > +	hwc->state =3D PERF_HES_STOPPED;
> > +	tad_pmu->events[idx] =3D event;
> > +
> > +	if (flags & PERF_EF_START)
> > +		tad_pmu_event_counter_start(event, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static int tad_pmu_event_init(struct perf_event *event)
> > +{
> > +	struct tad_pmu *tad_pmu =3D to_tad_pmu(event->pmu);
> > +
> > +	if (event->attr.type !=3D event->pmu->type)
> > +		return -ENOENT;
>=20
> Why is this not rejecting smapling events, as patch 1 does?
This is missed here. Will add the check for rejecting sampling events.
>=20
> > +
> > +	if (!event->attr.disabled)
> > +		return -EINVAL;
>=20
> Why?
Just checks the default disabled attribute.
>=20
> > +
> > +	if (event->state !=3D PERF_EVENT_STATE_OFF)
> > +		return -EINVAL;
>=20
> Event groups need to be verified here too.
>=20
> [...]
Ack. Will add the missed checks in the next version.
>=20
> > +static int tad_pmu_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct tad_region *regions;
> > +	struct tad_pmu *tad_pmu;
> > +	struct resource *res;
> > +	u32 tad_pmu_page_size;
> > +	u32 tad_page_size;
> > +	u32 tad_cnt;
> > +	int i, ret;
> > +	char *name;
> > +
> > +	tad_pmu =3D devm_kzalloc(&pdev->dev, sizeof(*tad_pmu), GFP_KERNEL);
> > +	if (!tad_pmu)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, tad_pmu);
> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "Mem resource not found\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	ret =3D device_property_read_u32(dev, "marvell,tad-page-size", &tad_p=
age_size);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Can't find tad-page-size property\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D device_property_read_u32(dev, "marvell,tad-pmu-page-size",
> > +				       &tad_pmu_page_size);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Can't find tad-pmu-page-size property\n");
> > +		return ret;
> > +	}
>=20
> Why do you think these properties are necessary?
>=20
> These should almost certainly be provided by IO resources, and shouldn't =
need a
> custom property.

IO resources don't provide all the information in this case. Need to vary t=
hese values
at different boot times. So, kept these custom properties.

Thanks,
Gowthami
>=20
> Thanks,
> Mark.
