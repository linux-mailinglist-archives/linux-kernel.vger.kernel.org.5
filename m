Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F37D779D05
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 05:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbjHLDnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 23:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHLDnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 23:43:18 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B939BE53
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 20:43:17 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BLb6rW007988;
        Fri, 11 Aug 2023 20:43:10 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sdw2egwt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 20:43:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lp1zY6tnbiNejObJB5psvnD7fnruNwVdT2CvddR6RI4XaoSDb6tHjP3dXKfrAgdTSu2dMVt+t7KaDckw00r3DazIMbEDpByaduybYSgYN1CF9RBX3B6fE2dAf0r/0R2MEZGN65F1gAa5LD3a3mRUS6qNHJ9Kem2L7lJQmuFJcrUHy7OUg0P3pOMn8qJ0TtsZgx6LCUwRqwQMQx+qKi/2BjeVMT6X4MKB2CPg2mJH1UiCDM4lSRB/pB3YNxt15C5yMHAmKwrngpKm8j33oYukh3rDfYRD8qViURD/TpDe1EWWR/FJgmGDDGJbB0ATVAe20bAeenwgoZiiafiJa4XQkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zxdpddPDYnYCTYxqPDtMVLBNQl4Er9cd8cpkeWaVlg=;
 b=H0rdP4Yh9uNF/WvIkOEFsLtJ3w8otS0voaJv/WW53XEhHaz6lO8lAto1SYReOXNLE4VU9QV96sYy3nBCkxQ1pK+RWIkWfg/8+lX95TT4miT9Hm9kKdgVXBkK6edW727wtJXDgjBopIG2olsRn7HCgdk+AP2GKgwxF0SstyoayYYGChLimMRLr2pOjaYNUhaV6/3OLTiXSeUY0qUV3aIPn7mw+0sZKZiKOGm47SQnAwvVaQdaBtcFKCHHqPilljc9sXuPNEF8+j8yRwUAT0RFghVGCFXuHE1MdOixdJPp8GsbvgFmynla7dz4f7oro5apeNBzJqia/VtlnQ7GRiN44Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zxdpddPDYnYCTYxqPDtMVLBNQl4Er9cd8cpkeWaVlg=;
 b=Yt/WCu1ePxU0dQIr3sukpu63NgOKcuX9FCjQMeRfX+Ewj8So9jNDl/0oRMzHCKpbETlcJBh9oWd7/cct3Zy8fpvnZTXv4Abw9ioA+DEIFZFxXSvem7uwY3G71YkXoXRe719GvIQm4hSuVsFUfAWyNlF4G1PJ/OLaLBmJnQKvAFg=
Received: from SN1PR18MB2126.namprd18.prod.outlook.com (2603:10b6:802:29::29)
 by SA0PR18MB3616.namprd18.prod.outlook.com (2603:10b6:806:72::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sat, 12 Aug
 2023 03:43:07 +0000
Received: from SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::cb4d:3836:d818:9bae]) by SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::cb4d:3836:d818:9bae%4]) with mapi id 15.20.6652.029; Sat, 12 Aug 2023
 03:43:07 +0000
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
Subject: RE: [EXT] Re: [PATCH 1/6] perf/marvell: Marvell PEM performance
 monitor support
Thread-Topic: [EXT] Re: [PATCH 1/6] perf/marvell: Marvell PEM performance
 monitor support
Thread-Index: AQHZq0r5gOjLcxepVkO38KSbGmvNAq/Pck4AgBbTomA=
Date:   Sat, 12 Aug 2023 03:43:07 +0000
Message-ID: <SN1PR18MB2126DFE6FCC39375D9CE8944DB11A@SN1PR18MB2126.namprd18.prod.outlook.com>
References: <20230630120351.1143773-1-gthiagarajan@marvell.com>
 <20230630120351.1143773-2-gthiagarajan@marvell.com>
 <ZMPYYuwg7wHGXft4@FVFF77S0Q05N>
In-Reply-To: <ZMPYYuwg7wHGXft4@FVFF77S0Q05N>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3RoaWFnYXJh?=
 =?us-ascii?Q?amFuXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02?=
 =?us-ascii?Q?Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNTZkNzk4ZGUtMzhjMi0xMWVlLTljNGYt?=
 =?us-ascii?Q?ZWFmOGQ2YzU4YWYzXGFtZS10ZXN0XDU2ZDc5OGUwLTM4YzItMTFlZS05YzRm?=
 =?us-ascii?Q?LWVhZjhkNmM1OGFmM2JvZHkudHh0IiBzej0iNDYzMSIgdD0iMTMzMzYyODUz?=
 =?us-ascii?Q?ODM3MzAxMDkxIiBoPSIzY3diN1AyeW9mN1pxN3B5Y1lmMVFtcjR1LzQ9IiBp?=
 =?us-ascii?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFO?=
 =?us-ascii?Q?NFBBQUJqWlRRWno4elpBVHUrb08rWVpjaTFPNzZnNzVobHlMVVpBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFCdUR3QUFBQUFBQUFBQUFBQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUN3QUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFu?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFnQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBIi8+PC9tZXRhPg=3D=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR18MB2126:EE_|SA0PR18MB3616:EE_
x-ms-office365-filtering-correlation-id: 40d754c8-ef31-4138-4b0e-08db9ae63df1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eLEduSMvU+A+DZ4gsQr3rQ7fQPJ23z752D/mlSP8I6JSAK0kQYvemiOBHSZ/Lo1rmivpUCMYRIYd2PujRrGpCcXjUbRQNk33R8iSLMinsFePbFsmg/ZpBWXkFJgglAyRnUdbfit9VvdKwgbu3HFPu2EImBfUNXb3ZlXvoZhcjpPIX8uj9j2ejWREW6lqX8dZlYeQ7AN8GWjtBLl4hSD6pnHkXxauluJcOMAq1hd+9MkxIzbNMmAiDlOz70nf4vrEJqPGyHm4fCVDqzd3+zaYT/AAuo383PLW1X0PVEfIg2kUoqLFjX4ehXYqtKhcqulTQqpeG52lDV3PTB1wCrgEj0NDgMZ7+43SJGnA+nfKIlAqHfz4t513dg4qovo8EBpPNIIlfxfUK3GHcHBs2fyVh4mK4gPxlLJk9ltS2t7CbB6sL7ta8SuPWQ1xvE3RjpGFBTehwSO3CHIinAIyevsKbNzy9Q1/xEgTLMyZrfwU3coYRT839+PAAjcQTEgJuDep3Jy34P2Xy0HoiSgJmNfSdGitw6CcW4oAbGlaxnZEyp+6N/l5a2QT2XN6o1+bfnYecI3WZl6tJjoCenSy95V5aFDNTmHRb6sFAkZC9UxOgeleeY0qXNYXLf4mw4GFZ75s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR18MB2126.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199021)(1800799006)(186006)(64756008)(6916009)(66476007)(54906003)(66446008)(66556008)(55016003)(66946007)(41300700001)(8676002)(8936002)(316002)(33656002)(76116006)(86362001)(38100700002)(122000001)(83380400001)(26005)(38070700005)(7696005)(4326008)(107886003)(53546011)(6506007)(71200400001)(9686003)(478600001)(52536014)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+yDyDFlE0DzRjTNOn/r/vBOCTscyr1HHsqoRtGZKiKOX+hqtYydezbgK/d4M?=
 =?us-ascii?Q?JsO71FDg41AtYFmZb3wZm1+4gAOEEnbMcpuCFzn28FlNB1hM9NgWWIrRB8kn?=
 =?us-ascii?Q?Yr9MW1uX/0zlQqPEF9YgwQJpx5iZz6SKhJz4X8vRN+Jl600kTGG0j6Ts6M5B?=
 =?us-ascii?Q?oGJRxxSCrILoiZYVdfNY3d79oKbuK3uervSAhaJfEDJDe5iR1440EObH0wSO?=
 =?us-ascii?Q?l5InCcG15/00urprqmJa0ryh0DH/Lcp4yCyfBoP6fP4tpYvDrUnmLdV304lt?=
 =?us-ascii?Q?n9aGQ/de8tVVF4P3UBITY2sE/5CRh5irmHS7cGzuUjebN76as0rKed8X+drE?=
 =?us-ascii?Q?U4pLdj3aFqnom9kEntYNNsnlZE0LihWAqa7FDTe52ZwRWGZFGxLeNiiZytzY?=
 =?us-ascii?Q?q+vxrYPu2nECXi07WiHsxOajAxnb9mbGNBpTwbZYDWXytvvJ0pqz1UzuMxgU?=
 =?us-ascii?Q?+nsAkk2l9ofV7Ij9ULCFahndDzYjLd4Pa4ILAqzCLJ2B3VkMF3L1NNUuZS40?=
 =?us-ascii?Q?Biq+EwCRHMKLUn9JlOG+JbRabTIlbdfFDAR8lhn5dqiGdU2u2LwJ4hlG8tDO?=
 =?us-ascii?Q?0QRZ1ZIAl+S93ewzRE+a2oOE/AFqRFA74bIQ3t15JtdILBuQ5k12QFHrsspN?=
 =?us-ascii?Q?C2qTNG7L6cR1/KgqcWcx0ykHK4/GCDio9iBYCJyvDWs8q7MvmiFxSijVVc/X?=
 =?us-ascii?Q?X/na2se8SnkBegHiHqIz5bGi8P0A1EKX3eGYzEww4Y7L0Q0SvD3VyKelJJd/?=
 =?us-ascii?Q?kfGwZourE8LZx/N1pp/7/SKpgDeBmeaLi3IYZyHsLXQgaBxcnMqcqDAaUh2w?=
 =?us-ascii?Q?EDSJmhcBgG1WodeVQqAnutBPnHYMjmJt9cnZaKwXALuG0TTDlPPDRw1zr4xB?=
 =?us-ascii?Q?FUXRubuFKlK3/2ubv6JfU/qlflcfJGFRfN5dLAk+o7hemXXxhKZmpAWXST76?=
 =?us-ascii?Q?ZpCWCyFs1gxRyd0wUY4JRilXSeEkP/PLEMZIkz+8oVjQCgEIKYB6GszljYFW?=
 =?us-ascii?Q?70UZS0ixjp3AYHPuP1mv2g4jjCL5ClGGLPL+bVyMy7p4cGvSNHy58zBCVDE/?=
 =?us-ascii?Q?bC/KCb92oQv44Kbd3xhtNbvQNqE9w226X0Etu4/8IOswxTb8LNb5/YvDEqF8?=
 =?us-ascii?Q?lPGMScfQ7ddSQqn6UW0yHSCkLTQXk3Uef+Do1V3YK3xZnk8aUjWdMSFKHPOv?=
 =?us-ascii?Q?AoJbWB2SBAQwqwRF+RbiW/Ul8CPXFi3+aicds6DHnN9ZqLtK9BojfY/O10LZ?=
 =?us-ascii?Q?WyRrIfY7GeCoqQ9iqzAlOBIY/2+/MOieSp+QfN/xfOfCvATswJvQ5rs/ZnGr?=
 =?us-ascii?Q?7H9fDvo/QFEOb+EYo9/qnumoWG6DHar6VLBh59zPo3VO4c6RLn20jTGDrHiU?=
 =?us-ascii?Q?5RuJPwohpQHnay++28BTSKS/czbttDvnjZf6vH1XqrJGpNqLC2TA2kHzrtTr?=
 =?us-ascii?Q?iADwgd2f+gMy9DT+O8qYfUxl4VJTXbb3wTWuEJxzlftYLhBXfs2zY5Wf1o1A?=
 =?us-ascii?Q?C9bi4zIW1fiRAJPXhh5uOP1dyksaYWVncY+n5DPm5MWLdkvns2MsgFNj0KnX?=
 =?us-ascii?Q?0qQ11QY5PJSaRrWefezF30CJtnJXoLU/eu4fQfDG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR18MB2126.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d754c8-ef31-4138-4b0e-08db9ae63df1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2023 03:43:07.5034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RHeEc2FiA93T/pCqKWftrIh6XxPPWBQearyACULYvyW7X3j4Pf5PNoaS8tJftUO5NpLRFyx8/g8uBsxuYJfHL97bd6keu/lQnjJwLQyvh2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3616
X-Proofpoint-ORIG-GUID: VIKQdha-WeCNkEHO6IXfXeTifidOCNcW
X-Proofpoint-GUID: VIKQdha-WeCNkEHO6IXfXeTifidOCNcW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-12_01,2023-08-10_01,2023-05-22_02
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
> Sent: Friday, July 28, 2023 8:32 PM
> To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> Cc: will@kernel.org; linux-arm-kernel@lists.infradead.org; linux-kernel@v=
ger.kernel.org; Sunil Kovvuri
> Goutham <sgoutham@marvell.com>; Bharat Bhushan <bbhushan2@marvell.com>; G=
eorge Cherian
> <gcherian@marvell.com>; Linu Cherian <lcherian@marvell.com>
> Subject: [EXT] Re: [PATCH 1/6] perf/marvell: Marvell PEM performance moni=
tor support
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> Hi,
>=20
> On Fri, Jun 30, 2023 at 05:33:46PM +0530, Gowthami Thiagarajan wrote:
> > PCI Express Interface PMU includes various performance counters to moni=
tor
> > the data that is transmitted over the PCIe link. The counters track var=
ious
> > inbound and outbound transactions which includes separate counters for
> > posted/non-posted/completion TLPs. Also, inbound and outbound memory re=
ad
> > requests along with their latencies can also be monitored. Address
> > Translation Services(ATS)events such as ATS Translation, ATS Page Reque=
st,
> > ATS Invalidation along with their corresponding latencies are also
> > supported.
> >
> > The performance counters are 64 bits wide.
> >
> > For instance,
> > perf stat -e ib_tlp_pr <workload>
> > tracks the inbound posted TLPs for the workload.
> >
> > Signed-off-by: Linu Cherian <lcherian@marvell.com>
> > Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
>=20
> This generally looks fine; I have a few comments below.
>=20
> [...]
>=20
> > diff --git a/drivers/perf/marvell_pem_pmu.c b/drivers/perf/marvell_pem_=
pmu.c
> > new file mode 100644
> > index 000000000000..fb27112aa7d4
> > --- /dev/null
> > +++ b/drivers/perf/marvell_pem_pmu.c
> > @@ -0,0 +1,433 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Marvell PEM(PCIe RC) Performance Monitor Driver
> > + *
> > + * Copyright (C) 2023 Marvell.
> > + */
>=20
> Nit: please follow the preferred coding style for comments. This should h=
ave a
> newline immediately after the '/*', e.g.
>=20
> 	/*
> 	 * Marvell PEM(PCIe RC) Performance Monitor Driver
> 	 *
> 	 * Copyright (C) 2023 Marvell.
> 	 */
>=20
> Likewise for all other multi-line comments.

Ack.
>=20
> > +#include <linux/acpi.h>
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_device.h>
> > +#include <linux/perf_event.h>
> > +
> > +/* Each of these events maps to a free running 64 bit counter
> > + * with no event control, but can be reset.
> > + *
> > + */
> > +enum pem_events {
> > +	IB_TLP_NPR,
> > +	IB_TLP_PR,
> > +	IB_TLP_CPL,
>=20
> > +static u64 eventid_to_offset_table[] =3D {
> > +	0x0,
> > +	0x8,
> > +	0x10,
>=20
> I assume the event IDs are the values in the pem_events enum, so please u=
se
> array initalizers here to make that clear, e.g.
>=20
> 	static u64 eventid_to_offset_table[] =3D {
> 		[IB_TLP_NPR]	=3D 0x0,
> 		[IB_TLP_PR]	=3D 0x8,
> 		[IB_TLP_CPL]	 0x10,
> 		...
> 	};
>=20
> [...]

Ack. Yes. IDs refer to the pem_events.=20

>=20
> > +static int pem_perf_event_init(struct perf_event *event)
> > +{
> > +	struct pem_pmu *pmu =3D to_pem_pmu(event->pmu);
> > +	struct hw_perf_event *hwc =3D &event->hw;
> > +
> > +	if (event->attr.type !=3D event->pmu->type)
> > +		return -ENOENT;
> > +
> > +	if (is_sampling_event(event)) {
>=20
> Don't we also need to check for:
>=20
> 	event->attach_state & PERF_ATTACH_TASK

Ack. Will add this check.

>=20
> > +		dev_info(pmu->dev, "Sampling not supported!\n");
> > +		return -EOPNOTSUPP;
> > +	}
>=20
> Please delete this dev_info().

Ack.
>=20
> > +
> > +	if (event->cpu < 0) {
> > +		dev_warn(pmu->dev, "Can't provide per-task data!\n");
> > +		return -EOPNOTSUPP;
> > +	}
>=20
> Likewise, please delete this dev_warn().
Ack.
>=20
> > +
> > +	/*  We must NOT create groups containing mixed PMUs */
> > +	if (event->group_leader->pmu !=3D event->pmu &&
> > +	    !is_software_event(event->group_leader))
> > +		return -EINVAL;
> > +
> > +	/* Set ownership of event to one CPU, same event can not be observed
> > +	 * on multiple cpus at same time.
> > +	 */
>=20
> Please fix this comment style (or delete the comment).
Ack.

-Thanks,
Gowthami
>=20
> > +	event->cpu =3D pmu->cpu;
> > +	hwc->idx =3D -1;
> > +	return 0;
> > +}
>=20
> Thanks,
> Mark.
