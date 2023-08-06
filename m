Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F95771628
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 18:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjHFQyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 12:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFQyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 12:54:38 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083371722;
        Sun,  6 Aug 2023 09:54:34 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 376GsJjh017900;
        Sun, 6 Aug 2023 09:54:19 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3s9kssasav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Aug 2023 09:54:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccvaQsS+KpD2n/LE6P4vpUof8WTq1OVOzlNAoSDBSTRtbRh6mDm99DhX9x0vYi7Omi1hwXu2lxQbbFm4/JQUx00K2ldpQtBYUzBHuAEDolE79VjDrWpn1zO3AKINRXyF1CqXMeawO1uq2xDcVbcyT3OyBHa6iXkG1NQYa32H3LSbNrMIqx4hdgpyni6VkoahQx2KLY4DhB9Ljo2QGAjnouQrMu7T51l41Wpc8Z+Dc4nEEoeUjWuUQRJQb+bHFH/EofDF5XgMeiYs32if+UOVigSwCPSliowdyJ4By8NvFWa53lFQUZt/aurqkp2iaV+dTlSQtvZqrO+iF0YnLkC1VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3XZmxbVzCKfaZIGko9zUBjjdOyNP7UMUaSFVibUxAM=;
 b=Cwt7xt3d6/s5qYc02MmbPzmN6VV+Fws2Au7a3fo13NbwqIe41RiTBJH0QeK5clfZSjy+Fu14q9MutlBKhYDFJ68BlNFHLfsLTOoFtSpFbdwaRQHAiPFVEfziZ86M0vehw4C4lgib5Q5Owpy+rJfKf6MpuTVDK58OlgsoT/Eqwwz7zWVix9isZaWLq2Vq76UVp2eRqpSoQp6WOpnNoA2/KWJmrwKh8kOOaSDT0Pa2VYVTMHZ5y+mG39Lj92CfXAAfTIIHUK9th52puAIuiCI41jDUggBLjIwTFtxJN/r3MxW3HHA15xmQNRliFRHIFaBQnBhgTpak6TyWoE23LQkkNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3XZmxbVzCKfaZIGko9zUBjjdOyNP7UMUaSFVibUxAM=;
 b=G0MaSyElyFWij4uIPVyu2LmJ7Le+c1uEhhhOUQGr0E7hmACgkvcCE20oxISmA1pIvRAT+jfeNq3Mm23fOgWOq59N5GwDShyrPN0yZmgHi+x2K51TUG0u6oG9fooue9Gbmej+BioDnRuRZq/EQ5xiw9IkE5WBH7R1xOLjMGbSJ0w=
Received: from BN6PR1801MB1971.namprd18.prod.outlook.com
 (2603:10b6:405:65::21) by PH0PR18MB3799.namprd18.prod.outlook.com
 (2603:10b6:510:1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Sun, 6 Aug
 2023 16:54:15 +0000
Received: from BN6PR1801MB1971.namprd18.prod.outlook.com
 ([fe80::d4f4:32bd:110e:869f]) by BN6PR1801MB1971.namprd18.prod.outlook.com
 ([fe80::d4f4:32bd:110e:869f%4]) with mapi id 15.20.6631.046; Sun, 6 Aug 2023
 16:54:15 +0000
From:   Sathesh B Edara <sedara@marvell.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Satananda Burla <sburla@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Haseeb Gani <hgani@marvell.com>
Subject: Re: [net-next PATCH] octeon_ep: Add control plane host and firmware
 versions.
Thread-Topic: [net-next PATCH] octeon_ep: Add control plane host and firmware
 versions.
Thread-Index: AQHZyIahtdrq2jlOqEW3B0E+7cunMg==
Date:   Sun, 6 Aug 2023 16:54:14 +0000
Message-ID: <BN6PR1801MB1971FE9234B6EE4CF56555E4D80FA@BN6PR1801MB1971.namprd18.prod.outlook.com>
References: <20230629084227.98848-1-sedara@marvell.com>
 <9c470add-1a35-4f09-bba6-12b99f890a82@lunn.ch>
In-Reply-To: <9c470add-1a35-4f09-bba6-12b99f890a82@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2VkYXJhXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctZGQ3MTNjNWItMzQ3OS0xMWVlLWE4NzYtOWFlMGNh?=
 =?us-ascii?Q?N2E2ZWNiXGFtZS10ZXN0XGRkNzEzYzVjLTM0NzktMTFlZS1hODc2LTlhZTBj?=
 =?us-ascii?Q?YTdhNmVjYmJvZHkudHh0IiBzej0iMjA2OCIgdD0iMTMzMzU4MTQ0NTE4MDUx?=
 =?us-ascii?Q?ODUzIiBoPSJSYll1YzEwelBJZnVPNDNZY1pscUdMOUovSWs9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFONFBBQUFO?=
 =?us-ascii?Q?V09lZmhzalpBY1VOVy9WMU9ZQnZ4UTFiOVhVNWdHOFpBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFCdUR3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUVCQUFBQXpaMWphUUNBQVFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBWkFC?=
 =?us-ascii?Q?eUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQWRRQnpBSFFBYndCdEFGOEFjQUJs?=
 =?us-ascii?Q?QUhJQWN3QnZBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUN3QUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
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
x-dg-reffour: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBIi8+PC9tZXRhPg=3D=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR1801MB1971:EE_|PH0PR18MB3799:EE_
x-ms-office365-filtering-correlation-id: b7852c6a-1e47-4bd3-0fa6-08db969dc445
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K6L/Q86qntRppTFxn17Em/fnL1MaiAKWP5qpzVnmADC92SRaXN3EmnuiCvEY4/TcSRKt3tGqYU76Pi6HitycUpZqA6oMT3r0/fMXvgjdvTsAfs729r2dQezO8pWUTDnJkCxlliMkekxBnZK2WD1FBzOrHXDELwT2WWRqvX7TZuiXqS2HqoE6nUW38FmxyrN07c6LiZEo1hBAyJcG8SekHq8oNVCBomx/CWYN1CLJz0c+7bRAbi16Gw8112RkHluEH0Q75/TYIiVHrtuWe5RC0HOsMUF/I4SZ4XSxW6oVZ1zPAiLi6hP/f/3H7uK5w/cHpGbTOLbqHIa+j+wWdhG9PuI2ARYiGdmXfgtrHOE7kMfWt2ckHRTqC0sE6xIEWmLNPnNvzTBcqN7n0QDxLofFAD0C0aca2mxdPPxG0ESj13imJKWi123/Z+kO5ULzCBodAjFCxULUinczxgnN0LBo9tSXpWXFOl+0lfkF+9f3KnPhKrWPiFL+EWddscTwQHu5ETPbT2qZb5Xb9K0k4xgwP5nm71wcUHP1X77akdhjlOIlzfBlE2NgTjovxGT/RS/BUUiF5Z9XnroTmdAGoFPAIvUp8QMSuBHOkufESvIg+VqrJvdbdaaVnOzB3J7R02SA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1801MB1971.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(376002)(39850400004)(451199021)(186006)(1800799003)(55016003)(4326008)(9686003)(316002)(6916009)(86362001)(122000001)(478600001)(54906003)(38100700002)(76116006)(71200400001)(66946007)(66556008)(66476007)(66446008)(64756008)(7696005)(33656002)(53546011)(6506007)(41300700001)(26005)(107886003)(52536014)(38070700005)(8676002)(8936002)(66899021)(2906002)(83380400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2n6WHlIVdTeelsevRodoJwJVjfaAVY3V9aDOKaQN+Hj8XH2NOB9PBzWQk0il?=
 =?us-ascii?Q?ay+1CwA0FpCHkllWqcCfyKbVqBkpPFPqKkjHM88/j9hE+RxuBD8sv9aaoUJt?=
 =?us-ascii?Q?a6Bjr5CGU1V8vXUY+AFZoX1xXvlXoIFcXeaYTnawXicFOvMD8iFjDQ0nZ7+5?=
 =?us-ascii?Q?V6gdySDdcIotEkIjg4CERE4MiY5sU8tuioZx499fJBJqXvzzA3AjnxXDxYBb?=
 =?us-ascii?Q?8zgWcco+EsghaqRgKpU1tNxMi1sRtus8w6/iO8zQtwuPfIHUsqFDAx/hdNb9?=
 =?us-ascii?Q?yRzUrDMGZABeW6/ylvOSvMq3kLHzJga3v3rp+I9GLVEhcCfk+aCY+JONlIkK?=
 =?us-ascii?Q?Z2EEN4WPGOZFHub32HnCR0ewqbf8C2OGCG0BIM+AQd1vzXQL5TUNr7VVpHxf?=
 =?us-ascii?Q?e9hkohyZzkFjio+cSZQ3WwNi0gPgesJROh1zQdPgDncLYbXw1lA1XW6xEC5N?=
 =?us-ascii?Q?bpNmmRJnn4ICRRajDS0fxB3HR6tHF7E8Illr16MZBB+oTZpFW6VGOfbuvII7?=
 =?us-ascii?Q?0jDbI57VyUlS0ETluwnOR4g1r6zGUsYKkcomiUbuZ21H5/zYfxhEF9zwbhLC?=
 =?us-ascii?Q?u8YApjtxmWruWtlxzaERxGh0iC/mfs6e0XzSz5l++tlujXJGLH9FqS/upvSs?=
 =?us-ascii?Q?Cr7/GaJsJUgFV2zIg/ILfMnI2Xf6BePT1WpPqrNDvmr9txHZvjKQf0GcZzmk?=
 =?us-ascii?Q?OVpFbiOZd+iJKg16Lm4JluaaHoGq0R2c8euqjotDQEnfJ4DylfqZ43bLcPQl?=
 =?us-ascii?Q?CNI227vfDS0ab1O8kIcYt6xSltrW825FTmvEbAnPAg2Vi9ZyH3ijOGfIOHLo?=
 =?us-ascii?Q?aJ7cWeg6nO4S1JDhcXA3KLx9okttgX0Kd8yD7Wwn0Ouqn5aQb36/rB+C1/7j?=
 =?us-ascii?Q?ultZWamfuPtpqejqNV0I3Lr3hK9h/KSA6f4Gx++JniYijvW9CPeAg1pD6jGZ?=
 =?us-ascii?Q?cmz5hN1MEroq+eu7Rll6UmjZfr5tUvkpo6S1g+6wCLq4f/rHD+UxW81JjXsL?=
 =?us-ascii?Q?y7HgBmnGirD6rHHIcKKuP76oTEfnh71KPICPWI+8M32HG9Nn4+HaAfndbjAm?=
 =?us-ascii?Q?UVl8VSYcjWh3V3EnwwWBOorqzkZoTosSlPbmwuZnlamWoQNt1f6G05drTIV0?=
 =?us-ascii?Q?4LVZ7dzV1cI0/Fwe186PYxDvaMpaUeS6TeX0PBk0UAIOBmGCwO9h5DctQRUH?=
 =?us-ascii?Q?v1QsYEAMuRMlgkzVy1X4E6Kycl/7mRMl/PgzbMWRUTZQiWvuvWC63LSML1Q9?=
 =?us-ascii?Q?to0OmMp9EkVlFPB/vYF0XonE/MmqE+HKizJKuZZdEKcnWtDXUmKOJCbhLIhO?=
 =?us-ascii?Q?Qro95FceeaCsT6ROsWOgxqirmj6/EWB1upaThovye/Np5iH4le8dKTD+YSSJ?=
 =?us-ascii?Q?VFY25Tb2lsLqr6UOkKB5vuCTu1HGPbzuiJUguzwc1GRG1eekCs7V6tsz1pfb?=
 =?us-ascii?Q?9DSoclWBj7RdiAN8ceyR65FJBKDSMcafakduIKa1RZnmMofUo7CypeIB0nzM?=
 =?us-ascii?Q?u+e4rcW6B2rjEjImCKbCOpXBVwDc0XOupNoWpPKSnS7kUZm1qY10dx6Y3r2c?=
 =?us-ascii?Q?zUZwS8eUL7eLG7b5VeU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1801MB1971.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7852c6a-1e47-4bd3-0fa6-08db969dc445
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2023 16:54:14.9616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jeg/dbaz2LoIshbA3s+4Raayca79P8XExE640D5NV6/2fUo4cha1dOabOiQ8CSR+3NBXTAT0IeUgVRpvR0qoYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3799
X-Proofpoint-GUID: Jx3iSalcn7bzVsW7zRKV0h8stb2CsAD9
X-Proofpoint-ORIG-GUID: Jx3iSalcn7bzVsW7zRKV0h8stb2CsAD9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-06_14,2023-08-03_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
 Apologies for late response.

-----Original Message-----
From: Andrew Lunn <andrew@lunn.ch>=20
Sent: Thursday, June 29, 2023 7:10 PM
To: Sathesh B Edara <sedara@marvell.com>
Cc: linux-kernel@vger.kernel.org; Satananda Burla <sburla@marvell.com>; Vee=
rasenareddy Burru <vburru@marvell.com>; davem@davemloft.net; edumazet@googl=
e.com; kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org; Haseeb G=
ani <hgani@marvell.com>
Subject:  Re: [net-next PATCH] octeon_ep: Add control plane host and firmwa=
re versions.

>  int octep_ctrl_net_init(struct octep_device *oct)  {
>  	struct octep_ctrl_mbox *ctrl_mbox;
> @@ -84,12 +101,22 @@ int octep_ctrl_net_init(struct octep_device *oct)
> =20
>  	/* Initialize control mbox */
>  	ctrl_mbox =3D &oct->ctrl_mbox;
> +	ctrl_mbox->version =3D OCTEP_CP_VERSION_CURRENT;
>  	ctrl_mbox->barmem =3D CFG_GET_CTRL_MBOX_MEM_ADDR(oct->conf);
>  	ret =3D octep_ctrl_mbox_init(ctrl_mbox);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to initialize control mbox\n");
>  		return ret;
>  	}
> +	dev_info(&pdev->dev, "Control plane versions host: %llx, firmware: %x:%=
x\n",
> +		 ctrl_mbox->version, ctrl_mbox->min_fw_version,
> +		 ctrl_mbox->max_fw_version);

> Please consider exporting this information via devlink.

Sure I agree. This will be implemented as separate patch.

> +	ret =3D validate_fw_version(ctrl_mbox);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Control plane version mismatch\n");
> +		octep_ctrl_mbox_uninit(ctrl_mbox);
> +		return -EINVAL;
> +	}

> If i'm reading this correct, a mismatch is fatal, the driver probe will e=
rror out. That sort of thing is generally not liked. The driver worked so f=
ar with mismatched firmware. It should keep working, but not offer the feat=
ures which require matching firmware.

Yes. You are correct this check is not required and I will submit the V2 pa=
tch by excluding this firmware version check.=20

 >  Andrew
Thanks,
Sathesh

