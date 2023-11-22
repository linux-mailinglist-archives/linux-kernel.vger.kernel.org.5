Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EB57F3CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 05:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjKVEm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 23:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVEmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 23:42:53 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827FF18D;
        Tue, 21 Nov 2023 20:42:49 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM2dvNR000718;
        Tue, 21 Nov 2023 20:42:42 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uewnw3ru5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 20:42:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwzWVqoTV4RWzV8v4SPCnNrfGmjM5Mxj+29p9YCZ3zxQZhPazMFd15wfXXKn9YrddglpW1b4exhrTp+EZK2frFIu3vMmyQeVXXo0pSbAK8OrMtg3JV7S0NjPaw66h6N0suUrtngTb5kPCzgUqIjdrRJov5KLh3HA07ae3d9F/YGMLBjD72W0up14UrXyBHm5zoFvKSWkxpu4CYuRBDhPrtfWFCuX1nG4s90DwHivreIAxuKAdNMetpsb72pOkVQZkkzpge8hgytilrLH7MwZo9qNtml+8SZngwuLYD73CKomLi+NFWM8FJ5ApXdWa9LF9iRdDEa2CRXfw8+XUl91pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbCVQ7WHAKqCQF9oExUXTN7zaK0N6rkvTPSAtHrtjrk=;
 b=KhbC2NJFRk39711gwZ0PaYcDea9rg1HWTNvBE2BnZlUcL15kc/B4CcoeD4FA8IJ76Q6KL+rWlOArwajAmRtRS0CvuEFMDGc4WLD8lRMs2dVb2k90/g01LAXDMqT7a1Nq+esd8/vrcDAU7lNfgHjUaEsdjWiEa2vnFtd3hn/1eeI3bJUnCotHb8e1qBqNbiDEVRYSvSl9G0LwuVUVSQgHzbyVJk/kT9jXu/K689UNehF9BZo9xcFbmWcWd+TK6DEe3JNGy639XI3EFY4qZJWe2NrTH+k6WCVyEVuG8n4s8MwHVNEHxbi+nE3uZtbmVlR7VPMoavyHk6r/QNU0Yzbkvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbCVQ7WHAKqCQF9oExUXTN7zaK0N6rkvTPSAtHrtjrk=;
 b=FNEmdOMYvGpP1gpSiJX5fi5h3tnzs4YtF94T6sYHE84Za+ZfNUdw8HI7LQ1+flN3r7sQrHq0ST+r1bITeSfMyTkzP9QZyyjX6yow5phR9NihsK870rHpRAGXzeVnQBgnCL4EPU5WrmqN8GInruhrgQffmPw9S3dUJCcqeJ0bqpM=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by PH0PR18MB4426.namprd18.prod.outlook.com (2603:10b6:510:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 04:42:37 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::6a4f:cb8d:70fd:ef2]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::6a4f:cb8d:70fd:ef2%4]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 04:42:36 +0000
From:   Suman Ghosh <sumang@marvell.com>
To:     Shinas Rasheed <srasheed@marvell.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Haseeb Gani <hgani@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh B Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: RE: [EXT] [PATCH net-next v1] octeon_ep: get max rx packet length
 from firmware
Thread-Topic: [EXT] [PATCH net-next v1] octeon_ep: get max rx packet length
 from firmware
Thread-Index: AQHaHK7LJGEoyOhokkOFzuxUo8XF0LCFwmwA
Date:   Wed, 22 Nov 2023 04:42:36 +0000
Message-ID: <SJ0PR18MB5216EA9C653D155E3F4A5D89DBBAA@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20231121191224.2489474-1-srasheed@marvell.com>
In-Reply-To: <20231121191224.2489474-1-srasheed@marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3VtYW5nXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctOGNlNDFhZTgtODhmMS0xMWVlLWI2ZmItODQxNDRk?=
 =?us-ascii?Q?ZWVhNTRjXGFtZS10ZXN0XDhjZTQxYWVhLTg4ZjEtMTFlZS1iNmZiLTg0MTQ0?=
 =?us-ascii?Q?ZGVlYTU0Y2JvZHkudHh0IiBzej0iNzU3NiIgdD0iMTMzNDUxMDE3NTM3NTEx?=
 =?us-ascii?Q?NTUwIiBoPSJQbmV0ei9LNjdPempadWFlNm9DbnBrbGltWnc9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCZ1dBQUIr?=
 =?us-ascii?Q?NER4UC9oemFBZjd4ak16KzB4algvdkdNelA3VEdOY1pBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFCdUR3QUEzZzhBQURvR0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUVCQUFBQTlSZW5Md0NBQVFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBWkFC?=
 =?us-ascii?Q?eUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQWRRQnpBSFFBYndCdEFGOEFjQUJs?=
 =?us-ascii?Q?QUhJQWN3QnZBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBBWHdCd0FHZ0Fid0J1QUdVQWJnQjFB?=
 =?us-ascii?Q?RzBBWWdCbEFISUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCakFIVUFj?=
 =?us-ascii?Q?d0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFaQUJoQUhNQWFBQmZBSFlBTUFBeUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01B?=
 =?us-ascii?Q?ZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdCckFHVUFlUUIzQUc4QWNnQmtB?=
 =?us-ascii?Q?SE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFHMEFY?=
 =?us-ascii?Q?d0J6QUhNQWJnQmZBRzRBYndCa0FHVUFiQUJwQUcwQWFRQjBBR1VBY2dCZkFI?=
 =?us-ascii?Q?WUFNQUF5QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJqQUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QWN3?=
 =?us-ascii?Q?QndBR0VBWXdCbEFGOEFkZ0F3QURJQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?UUFiQUJ3QUY4QWN3QnJBSGtBY0FCbEFGOEFZd0JvQUdFQWRBQmZBRzBBWlFC?=
 =?us-ascii?Q?ekFITUFZUUJuQUdVQVh3QjJBREFBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWkFCc0FIQUFYd0J6QUd3?=
 =?us-ascii?Q?QVlRQmpBR3NBWHdCakFHZ0FZUUIwQUY4QWJRQmxBSE1BY3dCaEFHY0FaUUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmtBR3dBY0FCZkFI?=
 =?us-ascii?Q?UUFaUUJoQUcwQWN3QmZBRzhBYmdCbEFHUUFjZ0JwQUhZQVpRQmZBR1lBYVFC?=
 =?us-ascii?Q?c0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUdVQWJRQmhBR2tBYkFCZkFHRUFaQUJrQUhJ?=
 =?us-ascii?Q?QVpRQnpBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFRQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFiUUJoQUhJQWRnQmxBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhB?=
 =?us-ascii?Q?YmdCaEFHMEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFRQmhB?=
 =?us-ascii?Q?R3dBWHdCaEFHd0Fid0J1QUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFITUFY?=
 =?us-ascii?Q?d0J5QUdVQWN3QjBBSElBYVFCakFIUUFaUUJrQUY4QVlRQnNBRzhBYmdCbEFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUY4QWNBQnlB?=
 =?us-ascii?Q?RzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFISUFaUUJ6QUhRQWNn?=
 =?us-ascii?Q?QnBBR01BZEFCbEFHUUFYd0JvQUdVQWVBQmpBRzhBWkFCbEFITUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUdFQWNnQnRBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-refthree: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlB?=
 =?us-ascii?Q?QUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFad0J2QUc4QVp3QnNB?=
 =?us-ascii?Q?R1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZ?=
 =?us-ascii?Q?UUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBWXdCdkFH?=
 =?us-ascii?Q?UUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJB?=
 =?us-ascii?Q?QmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QmpBRzhBWkFCbEFITUFYd0JrQUdr?=
 =?us-ascii?Q?QVl3QjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFB?=
 =?us-ascii?Q?SUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhBYWdC?=
 =?us-ascii?Q?bEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFRQmtBR1VB?=
 =?us-ascii?Q?YmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUcw?=
 =?us-ascii?Q?QVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFiZ0Jo?=
 =?us-ascii?Q?QUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFBYVFCaEFHd0FY?=
 =?us-ascii?Q?d0J0QUdFQWNnQjJBR1VBYkFCc0FGOEFid0J5QUY4QVlRQnlBRzBBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: =?us-ascii?Q?QUFBQUFBQUFRQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFB?=
 =?us-ascii?Q?QUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdC?=
 =?us-ascii?Q?dUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0QWRBQnBBR0VB?=
 =?us-ascii?Q?YkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0JuQUc4QWJ3Qm5B?=
 =?us-ascii?Q?R3dBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdV?=
 =?us-ascii?Q?QWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0Jm?=
 =?us-ascii?Q?QUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VBY2dCMkFHVUFi?=
 =?us-ascii?Q?QUJzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFB?=
 =?us-ascii?Q?QUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QndBSElB?=
 =?us-ascii?Q?YndCcUFHVUFZd0IwQUY4QWJnQmhBRzBBWlFCekFGOEFjZ0JsQUhNQWRBQnlB?=
 =?us-ascii?Q?R2tBWXdCMEFHVUFaQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3?=
 =?us-ascii?Q?QmhBSElBYlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNl?=
 =?us-ascii?Q?QUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhRQVpRQnlBRzBBYVFCdUFIVUFj?=
 =?us-ascii?Q?d0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJB?=
 =?us-ascii?Q?R1VBYkFCc0FGOEFkd0J2QUhJQVpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUE4QUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBT2dZQUFBQUFBQUFJQUFBQUFBQUFBQWdBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQUFBQWFCZ0FBR1FBQUFCZ0FB?=
x-dg-reffive: =?us-ascii?Q?QUFBQUFBQVlRQmtBR1FBY2dCbEFITUFjd0FBQUNRQUFBQUFBQUFBWXdCMUFI?=
 =?us-ascii?Q?TUFkQUJ2QUcwQVh3QndBR1VBY2dCekFHOEFiZ0FBQUM0QUFBQUFBQUFBWXdC?=
 =?us-ascii?Q?MUFITUFkQUJ2QUcwQVh3QndBR2dBYndCdUFHVUFiZ0IxQUcwQVlnQmxBSElB?=
 =?us-ascii?Q?QUFBd0FBQUFBQUFBQUdNQWRRQnpBSFFBYndCdEFGOEFjd0J6QUc0QVh3QmtB?=
 =?us-ascii?Q?R0VBY3dCb0FGOEFkZ0F3QURJQUFBQXdBQUFBQUFBQUFHTUFkUUJ6QUhRQWJ3?=
 =?us-ascii?Q?QnRBRjhBY3dCekFHNEFYd0JyQUdVQWVRQjNBRzhBY2dCa0FITUFBQUErQUFB?=
 =?us-ascii?Q?QUFBQUFBR01BZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdCdUFHOEFaQUJs?=
 =?us-ascii?Q?QUd3QWFRQnRBR2tBZEFCbEFISUFYd0IyQURBQU1nQUFBRElBQUFBQUFBQUFZ?=
 =?us-ascii?Q?d0IxQUhNQWRBQnZBRzBBWHdCekFITUFiZ0JmQUhNQWNBQmhBR01BWlFCZkFI?=
 =?us-ascii?Q?WUFNQUF5QUFBQVBnQUFBQUFBQUFCa0FHd0FjQUJmQUhNQWF3QjVBSEFBWlFC?=
 =?us-ascii?Q?ZkFHTUFhQUJoQUhRQVh3QnRBR1VBY3dCekFHRUFad0JsQUY4QWRnQXdBRElB?=
 =?us-ascii?Q?QUFBMkFBQUFBQUFBQUdRQWJBQndBRjhBY3dCc0FHRUFZd0JyQUY4QVl3Qm9B?=
 =?us-ascii?Q?R0VBZEFCZkFHMEFaUUJ6QUhNQVlRQm5BR1VBQUFBNEFBQUFBQUFBQUdRQWJB?=
 =?us-ascii?Q?QndBRjhBZEFCbEFHRUFiUUJ6QUY4QWJ3QnVBR1VBWkFCeUFHa0FkZ0JsQUY4?=
 =?us-ascii?Q?QVpnQnBBR3dBWlFBQUFDUUFBQUFCQUFBQVpRQnRBR0VBYVFCc0FGOEFZUUJr?=
 =?us-ascii?Q?QUdRQWNnQmxBSE1BY3dBQUFGZ0FBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FY?=
 =?us-ascii?Q?d0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFiZ0JoQUcwQVpRQnpBRjhBWXdCdkFH?=
 =?us-ascii?Q?NEFaZ0JwQUdRQVpRQnVBSFFBYVFCaEFHd0FYd0JoQUd3QWJ3QnVBR1VBQUFC?=
 =?us-ascii?Q?VUFBQUFBQUFBQUcwQVlRQnlBSFlBWlFCc0FGOEFjQUJ5QUc4QWFnQmxBR01B?=
 =?us-ascii?Q?ZEFCZkFHNEFZUUJ0QUdVQWN3QmZBSElBWlFCekFIUUFjZ0JwQUdNQWRBQmxB?=
 =?us-ascii?Q?R1FBWHdCaEFHd0Fid0J1QUdVQUFBQmFBQUFBQUFBQUFHMEFZUUJ5QUhZQVpR?=
 =?us-ascii?Q?QnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUhJ?=
 =?us-ascii?Q?QVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3Qm9BR1VBZUFCakFHOEFaQUJs?=
 =?us-ascii?Q?QUhNQUFBQWdBQUFBQUFBQUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCaEFISUFi?=
 =?us-ascii?Q?UUFBQUNZQUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBR2NBYndCdkFH?=
 =?us-ascii?Q?Y0FiQUJsQUFBQU5BQUFBQUFBQUFCdEFHRUFj?=
x-dg-refsix: =?us-ascii?Q?Z0IyQUdVQWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBR01BYndCa0FH?=
 =?us-ascii?Q?VUFjd0FBQUQ0QUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQVh3QmpBRzhBWkFCbEFITUFYd0JrQUdrQVl3QjBBQUFB?=
 =?us-ascii?Q?WGdBQUFBQUFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFjQUJ5QUc4QWFnQmxB?=
 =?us-ascii?Q?R01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZBR01BYndCdUFHWUFhUUJrQUdVQWJn?=
 =?us-ascii?Q?QjBBR2tBWVFCc0FGOEFiUUJoQUhJQWRnQmxBR3dBYkFBQUFHd0FBQUFCQUFB?=
 =?us-ascii?Q?QWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0J1?=
 =?us-ascii?Q?QUdFQWJRQmxBSE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRBZEFCcEFHRUFi?=
 =?us-ascii?Q?QUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3QmhBSElBYlFBQUFI?=
 =?us-ascii?Q?SUFBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29BWlFC?=
 =?us-ascii?Q?akFIUUFYd0J1QUdFQWJRQmxBSE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRB?=
 =?us-ascii?Q?ZEFCcEFHRUFiQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3Qm5B?=
 =?us-ascii?Q?RzhBYndCbkFHd0FaUUFBQUZvQUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJB?=
 =?us-ascii?Q?QmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFITUFYd0J5QUdV?=
 =?us-ascii?Q?QWN3QjBBSElBYVFCakFIUUFaUUJrQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFB?=
 =?us-ascii?Q?QUdnQUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dCdkFHb0Fa?=
 =?us-ascii?Q?UUJqQUhRQVh3QnVBR0VBYlFCbEFITUFYd0J5QUdVQWN3QjBBSElBYVFCakFI?=
 =?us-ascii?Q?UUFaUUJrQUY4QWJRQmhBSElBZGdCbEFHd0FiQUJmQUc4QWNnQmZBR0VBY2dC?=
 =?us-ascii?Q?dEFBQUFLZ0FBQUFBQUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWRBQmxBSElB?=
 =?us-ascii?Q?YlFCcEFHNEFkUUJ6QUFBQUlnQUFBQThBQUFCdEFHRUFjZ0IyQUdVQWJBQnNB?=
 =?us-ascii?Q?RjhBZHdCdkFISUFaQUFBQUE9PSIvPjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|PH0PR18MB4426:EE_
x-ms-office365-filtering-correlation-id: 9f1b0618-f243-408a-5f58-08dbeb15737c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mcghTj19lA80W0DoLVUAiRDnwN1wOnU3Z7yOZJIXHz/K12Tzzz+4NHx7IXhUcbs3izskvV4WcAskrKt+lsT7jScqxOWbTivkdpzV7Q9lvEFwxhM5QeJRQJyxe0TMPgb9C0T5v/sJkor214Uthru+2xgEvYilIWzGNYhdGn4hGAxFSZOXu33+WG0j8BmMOLC8FxS+PnUPnFwcJAZLAxkfRl4HxD3TIOPZH0NkhuzO+sntmC+UsDEW95nVfnSo6AEezkg/yZ7gJZwaOt3LmnhOzpWVXD/s9JN1Kz5E3dAuJkIJ44I1r4a/zNBuKpa1tj1HyKoLXYDYJd9ZboVrat53ZLuulenXsfYEdMXlHdjE+7FjoCaDISBsz1drz5Nx4ldsZQrsew0MwaEY3fZ52dKleQhGO3cIKEgB1+qHVn5TrgVCV08f1OnVBvCN2biehngDLmAkU575NnUxh4nmptZ3+LgUopqHnzM4rdee0WnAZalb23d1irvXlR39zfLld4hsRt21joQuxsNnsC2FRLejxeFSFPatwSHtbw5hprMTrQV85uNDfbj93LaCbDRNJVZqxJnYIeLySzS7khQgGcTQOhgbHDEVWxtjz4PDTs7c9c/iXTUBfoyCTZbIdDL6/ahE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(366004)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(86362001)(5660300002)(33656002)(7416002)(2906002)(38070700009)(52536014)(9686003)(478600001)(122000001)(6506007)(71200400001)(7696005)(83380400001)(26005)(4326008)(8676002)(38100700002)(55016003)(316002)(8936002)(64756008)(110136005)(66946007)(76116006)(54906003)(66446008)(66556008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OdEWTsPOcsjW98poRxLZFV5TGt5KA3aiUFqYGeh/+IRJvRsyFJXK0jOTokh7?=
 =?us-ascii?Q?dJ7N2qgnTr4h0kdkG/INopC5+lF7neZWolyVXHq0JW47ZYk/K9rWXMHeJUjG?=
 =?us-ascii?Q?Zg3yeio1p56zNWLGoj4dT6nk2jsVdlM8MVBvmhA2+6uajP0B7C0a4q8saJyo?=
 =?us-ascii?Q?yfHy4MjAcvmWwfgM0Pna+G6B7hf46HRz/kcc8F5CWmO/Ss+ZtfSCSL2pWp2r?=
 =?us-ascii?Q?lGh0ITPyJ0oZqdiB+rBj/Ovf7LqgZG5YhZA8nV4xKa0cFrSPw4LAgWtxHXL4?=
 =?us-ascii?Q?SHTsswiWuGy7fcX7xYcM3b2Flr+3SGXczHji4Y7jDjgsDzEDlKNVDX8hLmvD?=
 =?us-ascii?Q?k2OuaWM3BEdMHVkwUb/e+WApQ6ebSgsH/9pFrxviIT+MV3tqLclj7JyxTqdd?=
 =?us-ascii?Q?5CkGsTRYYgQfpM5lAuJ9JPklq0GnjzO49yzUc8bv0Y35c+BZbUX5FNOjGKeT?=
 =?us-ascii?Q?XKnUpiJnDZArK09a2DooaGJqXl7UC8sHG9sGLafYtzx6DDBCRT4tYGAn32YC?=
 =?us-ascii?Q?VpStCuw3A/Hv9Ag/ZW5Ec5aqZScOIE8nsgIa8+/iqhk+xB4j/0vN696+/1qM?=
 =?us-ascii?Q?X/X+2IxMh1EIH4GRyY3FdpV1YszvrVFrzmqhn0TGL4rjtGu79lYMAMSM7xKD?=
 =?us-ascii?Q?nOlFNYHzPdDS5G4B++hyYe3Hd5l+o3YFd21cX09VYS8nyTqE5U/IWq10Pxyy?=
 =?us-ascii?Q?W4HFigvohqe/NfuNqTdZenUwtEabX1DnHKcW+4laocpy+8kn0YHsbmCDLQOr?=
 =?us-ascii?Q?GzW1voDIYjAZTSct9+1aOBfp2XM3D5QtK5eBChYzSCe3FlSYShHh45Unj7s3?=
 =?us-ascii?Q?PImvaCNLzkWG+fwUtRbq75xApg5bZIWEkIrv0M9ahBWsYnKIt2pSrYoRaxuS?=
 =?us-ascii?Q?PNt5p7Ye+eEdr6e7XGwzfpzEZ3vhBYmxzVToP/tN7NnIISJO34yYq47AiVd6?=
 =?us-ascii?Q?bsKLgTXZyMgi+i475p7HvxxU+6QYkGOoyybUoOoqPobpFtX3NTrpuwaqxMme?=
 =?us-ascii?Q?98oDcKqZxGovJ2MfbliF5+dvm/bN8249aT4Uu/MRF5Q0AKFT2eSJsFLJqDoq?=
 =?us-ascii?Q?95LrMFos24ZHZNRT6JG5YOtxU0ApoHyztHw+P5ryPe2TK3WVO8MsVJmC1kEr?=
 =?us-ascii?Q?ZDjVASU2l31sYreIwBzmZ4jZe+P1VVzmgt0ZSu17N8dScy8GUn58mnVeGEIJ?=
 =?us-ascii?Q?yF+NvbQ21TMRvzA0lc0pveCC9LFt8KUNNPsmJp7DHFR4TOMyf6HBY4bBBJ9S?=
 =?us-ascii?Q?yAPeL3Ad01jsfiglL05ePf3myPCYDAFOhvUVtTaGsYGnlOV/EKX8GDFAwS8r?=
 =?us-ascii?Q?VsvEqG+nU1FoZJ4UZz7B36qDvHCY+RKupDvBdSN5TkpsE72xULRyEgT6qbEt?=
 =?us-ascii?Q?1JYfrcHghlmD4lZ5kstGo6h09g94Ydw8dbbhRdLBflhaiOcXpofKzcb1SC8c?=
 =?us-ascii?Q?wqq5ssOE5jl7gcs0XyEQ1GBDlQe2QrBEhxUMTCkslNez7xekr7UtMftPUAkF?=
 =?us-ascii?Q?+5NnV4HcGHcPDPIsytNCEYqnPOTtfPK4NaU0Bx+iFYdQc+LkXP3gf5uTBhKJ?=
 =?us-ascii?Q?+xSuOtHH16iWKGEjjnV0LRedVeLebfOq9b510LfN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1b0618-f243-408a-5f58-08dbeb15737c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 04:42:36.6834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BOBldzHt/8sJAtNs1fLQv+mDG3FEdhVZEZLSDwV56HlOG+ZjY4fcCQ1k6SXNTBpi1HejKx4fjJrQoJIq/IysdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4426
X-Proofpoint-GUID: 2W_DajeVpTOEtT3PtG48yenvMOmf9ywS
X-Proofpoint-ORIG-GUID: 2W_DajeVpTOEtT3PtG48yenvMOmf9ywS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_02,2023-11-21_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
>---
> .../marvell/octeon_ep/octep_ctrl_net.c         | 18 ++++++++++++++++++
> .../marvell/octeon_ep/octep_ctrl_net.h         |  9 +++++++++
> .../ethernet/marvell/octeon_ep/octep_main.c    | 10 +++++++++-
> 3 files changed, 36 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
>b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
>index 6dd3d03c1c0f..c9fcebb9bd9b 100644
>--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
>+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
>@@ -198,6 +198,24 @@ int octep_ctrl_net_set_mac_addr(struct octep_device
>*oct, int vfid, u8 *addr,
> 	return octep_send_mbox_req(oct, &d, wait_for_response);  }
>
>+int octep_ctrl_net_get_mtu(struct octep_device *oct, int vfid) {
>+	struct octep_ctrl_net_wait_data d =3D {0};
>+	struct octep_ctrl_net_h2f_req *req;
>+	int err;
>+
>+	req =3D &d.data.req;
>+	init_send_req(&d.msg, req, mtu_sz, vfid);
>+	req->hdr.s.cmd =3D OCTEP_CTRL_NET_H2F_CMD_MTU;
>+	req->mtu.cmd =3D OCTEP_CTRL_NET_CMD_GET;
>+
>+	err =3D octep_send_mbox_req(oct, &d, true);
>+	if (err < 0)
>+		return err;
>+
>+	return d.data.resp.mtu.val;
>+}
>+
> int octep_ctrl_net_set_mtu(struct octep_device *oct, int vfid, int mtu,
> 			   bool wait_for_response)
> {
>diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
>b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
>index 4bb97ad1f1c6..46ddaa5c64d1 100644
>--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
>+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
>@@ -282,6 +282,15 @@ int octep_ctrl_net_get_mac_addr(struct octep_device
>*oct, int vfid, u8 *addr);  int octep_ctrl_net_set_mac_addr(struct
>octep_device *oct, int vfid, u8 *addr,
> 				bool wait_for_response);
>
>+/** Get max MTU from firmware.
>+ *
>+ * @param oct: non-null pointer to struct octep_device.
>+ * @param vfid: Index of virtual function.
>+ *
>+ * return value: mtu on success, -errno on failure.
>+ */
>+int octep_ctrl_net_get_mtu(struct octep_device *oct, int vfid);
>+
> /** Set mtu in firmware.
>  *
>  * @param oct: non-null pointer to struct octep_device.
>diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
>b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
>index 3cee69b3ac38..f9c539178114 100644
>--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
>+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
>@@ -1276,6 +1276,7 @@ static int octep_probe(struct pci_dev *pdev, const
>struct pci_device_id *ent)  {
> 	struct octep_device *octep_dev =3D NULL;
> 	struct net_device *netdev;
>+	int max_rx_pktlen;
> 	int err;
>
> 	err =3D pci_enable_device(pdev);
>@@ -1346,8 +1347,15 @@ static int octep_probe(struct pci_dev *pdev,
>const struct pci_device_id *ent)
>
> 	netdev->hw_features =3D NETIF_F_SG;
> 	netdev->features |=3D netdev->hw_features;
>+
>+	max_rx_pktlen =3D octep_ctrl_net_get_mtu(octep_dev,
>OCTEP_CTRL_NET_INVALID_VFID);
>+	if (max_rx_pktlen < 0) {
>+		dev_err(&octep_dev->pdev->dev,
>+			"Failed to get max receive packet size; err =3D %d\n",
>max_rx_pktlen);
>+		goto register_dev_err;
>+	}
[Suman] Do we need to check if max_rx_pktlen <=3D OCTEP_MAX_MTU as well? If=
 not, then this macro is not required further after the change?

> 	netdev->min_mtu =3D OCTEP_MIN_MTU;
>-	netdev->max_mtu =3D OCTEP_MAX_MTU;
>+	netdev->max_mtu =3D max_rx_pktlen - (ETH_HLEN + ETH_FCS_LEN);
> 	netdev->mtu =3D OCTEP_DEFAULT_MTU;
>
> 	err =3D octep_ctrl_net_get_mac_addr(octep_dev,
>OCTEP_CTRL_NET_INVALID_VFID,
>--
>2.25.1
>

