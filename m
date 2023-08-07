Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A1F7723BF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjHGMVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjHGMVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:21:16 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A0610FD;
        Mon,  7 Aug 2023 05:20:53 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3777m8Fp003904;
        Mon, 7 Aug 2023 05:20:39 -0700
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3s9nxkvjht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 05:20:38 -0700
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 377CET4W027873;
        Mon, 7 Aug 2023 05:20:38 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3s9nxkvjhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 05:20:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Af2of/0Se1+b4lNmo7I7i8vguxy5zjTYpUni3SvMyMJ+/6SoJ0YI4KeHwKHyaR14k0Ecc+vuW7v7iUr1r2/xDQrwxZsNznPScNT04tSjaI0PuC9UtZBGb2uZ8SilX+kXq22n+nhRjxxlz7gDsIPTPhvb+CK2DZ8xU940z0ocT+T7Fj4CpSmLeFHJnwG+xRDANP/uXK65kX/nE6kyJovPuYA/x5c3fIJr+R3D3FS/FG4nFNMyG4tYN0dOhUaQdDFiXQdEZ0yps3uXJO8vBd4lk7TvWn81WIQj14e8+BcqNmvfjIveURYxTrulx+U0iaLGtU1fEisQn/1GOPkBrfFwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujSXIdpPiaMDuus+zJhgcl8M3+ippQ3kEpZTxu/uUyo=;
 b=PxY09WVQG6JotYOQjalwuV/1LIfOu6POzWnaosbNFJXwkzsyfrMDH1vnB+07p7thUDyS8KV8BET3vhU55/i3joxoquopSCelF2O18eE2b2FrFqOJEfvCXpfRK3gVJeiB1rpLTZQPbA4zA1I5y5nAb0LANNGylI0sGoo2qI7fAH7pB00bPkEeFWiaQAH8DfxJVMKtqgxCTnvwubClDbEuimjq50Nfh/WNEMPx+9W3w/VXwNe8EI1ocmZ329GjYN5WcqKMFTP5vSK4FIEQoJXjxHr+r0giRwNWBQ4WuXooM2d0FkA1IX82ZMjU75SzRyjO77gXy3lp9Mud4kqFdyjFRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujSXIdpPiaMDuus+zJhgcl8M3+ippQ3kEpZTxu/uUyo=;
 b=eWaTabb+30GhHQGJtSibdc7BW6sYXPAFyXEc5Z6GDFjgiotu2xIVAFn288OQGUFMB/olrNBVdRncWV/VNsve3RfH0hEeMcRRYjImrgG1pcV5eFx3J+FdW6maX4f6FJFaN9nuCcW1ankEhub86QXfco/H2DEiWrNm2gE41JyeA5Q=
Received: from CO6PR18MB4419.namprd18.prod.outlook.com (2603:10b6:5:35a::11)
 by PH0PR18MB4460.namprd18.prod.outlook.com (2603:10b6:510:e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 12:20:36 +0000
Received: from CO6PR18MB4419.namprd18.prod.outlook.com
 ([fe80::9787:a9aa:bd9e:11e]) by CO6PR18MB4419.namprd18.prod.outlook.com
 ([fe80::9787:a9aa:bd9e:11e%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 12:20:36 +0000
From:   Manish Rangankar <mrangankar@marvell.com>
To:     Chengfeng Ye <dg573847474@gmail.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] scsi: qedi: Fix potential deadlock on
 &qedi_percpu->p_work_lock
Thread-Topic: [EXT] [PATCH] scsi: qedi: Fix potential deadlock on
 &qedi_percpu->p_work_lock
Thread-Index: AQHZv8CvXtqFAcAlF02PG4Hr7B2ow6/e01zA
Date:   Mon, 7 Aug 2023 12:20:35 +0000
Message-ID: <CO6PR18MB4419302FE56A3EE7605DF871D80CA@CO6PR18MB4419.namprd18.prod.outlook.com>
References: <20230726125655.4197-1-dg573847474@gmail.com>
In-Reply-To: <20230726125655.4197-1-dg573847474@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXJhbmdhbmth?=
 =?us-ascii?Q?clxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?us-ascii?Q?NGJhMjllMzViXG1zZ3NcbXNnLWNjOGY3MTA4LTM1MWMtMTFlZS04NjI2LWEw?=
 =?us-ascii?Q?ZDA1YmFjNzBkOVxhbWUtdGVzdFxjYzhmNzEwYS0zNTFjLTExZWUtODYyNi1h?=
 =?us-ascii?Q?MGQwNWJhYzcwZDlib2R5LnR4dCIgc3o9IjI2NjAiIHQ9IjEzMzM1ODg0NDMz?=
 =?us-ascii?Q?MTM3NjMyMyIgaD0iNWFIOXErVTRaaStOZXg0NUFQYy9GNmRVSnRnPSIgaWQ9?=
 =?us-ascii?Q?IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBTjRQ?=
 =?us-ascii?Q?QUFERFBnZVFLY25aQVE5L01vQ2hEaHBERDM4eWdLRU9Ha01aQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUhBQUFBQnVEd0FBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQVFFQkFBQUFJN3FUcEFDQUFRQUFBQUFBQUFBQUFKNEFBQUJoQUdR?=
 =?us-ascii?Q?QVpBQnlBR1VBY3dCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHTUFkUUJ6QUhRQWJ3QnRBRjhB?=
 =?us-ascii?Q?Y0FCbEFISUFjd0J2QUc0QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWXdCMUFITUFkQUJ2QUcwQVh3QndBR2dBYndCdUFHVUFi?=
 =?us-ascii?Q?Z0IxQUcwQVlnQmxBSElBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmpB?=
 =?us-ascii?Q?SFVBY3dCMEFHOEFiUUJmQUhNQWN3QnVBRjhBWkFCaEFITUFhQUJmQUhZQU1B?=
 =?us-ascii?Q?QXlBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FB?=
 =?us-ascii?Q?QUdNQWRRQnpBSFFBYndCdEFGOEFjd0J6QUc0QVh3QnJBR1VBZVFCM0FHOEFj?=
 =?us-ascii?Q?Z0JrQUhNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZd0IxQUhNQWRBQnZB?=
 =?us-ascii?Q?RzBBWHdCekFITUFiZ0JmQUc0QWJ3QmtBR1VBYkFCcEFHMEFhUUIwQUdVQWNn?=
 =?us-ascii?Q?QmZBSFlBTUFBeUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFB?=
 =?us-ascii?Q?QUFBQUFJQUFBQUFBSjRBQUFCakFIVUFjd0IwQUc4QWJRQmZBSE1BY3dCdUFG?=
 =?us-ascii?Q?OEFjd0J3QUdFQVl3QmxBRjhBZGdBd0FESUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5n?=
 =?us-ascii?Q?QUFBR1FBYkFCd0FGOEFjd0JyQUhrQWNBQmxBRjhBWXdCb0FHRUFkQUJmQUcw?=
 =?us-ascii?Q?QVpRQnpBSE1BWVFCbkFHVUFYd0IyQURBQU1nQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVpBQnNBSEFBWHdC?=
 =?us-ascii?Q?ekFHd0FZUUJqQUdzQVh3QmpBR2dBWVFCMEFGOEFiUUJsQUhNQWN3QmhBR2NB?=
 =?us-ascii?Q?WlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJrQUd3QWNB?=
 =?us-ascii?Q?QmZBSFFBWlFCaEFHMEFjd0JmQUc4QWJnQmxBR1FBY2dCcEFIWUFaUUJmQUdZ?=
 =?us-ascii?Q?QWFRQnNBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHVUFiUUJoQUdrQWJBQmZBR0VBWkFC?=
 =?us-ascii?Q?a0FISUFaUUJ6QUhNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFDZ0FBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?us-ascii?Q?QUY4QWJnQmhBRzBBWlFCekFGOEFZd0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFh?=
 =?us-ascii?Q?UUJoQUd3QVh3QmhBR3dBYndCdUFHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VB?=
 =?us-ascii?Q?Y2dCMkFHVUFiQUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0J1QUdFQWJRQmxB?=
 =?us-ascii?Q?SE1BWHdCeUFHVUFjd0IwQUhJQWFRQmpBSFFBWlFCa0FGOEFZUUJzQUc4QWJn?=
 =?us-ascii?Q?QmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUcwQVlRQnlBSFlBWlFCc0FGOEFj?=
 =?us-ascii?Q?QUJ5QUc4QWFnQmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZBSElBWlFCekFI?=
 =?us-ascii?Q?UUFjZ0JwQUdNQWRBQmxBR1FBWHdCb0FHVUFlQUJqQUc4QVpBQmxBSE1BQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFHRUFjZ0J0QUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refthree: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFB?=
 =?us-ascii?Q?QUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBWndCdkFHOEFa?=
 =?us-ascii?Q?d0JzQUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFB?=
 =?us-ascii?Q?RzBBWVFCeUFIWUFaUUJzQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4QVl3?=
 =?us-ascii?Q?QnZBR1FBWlFCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQWJRQmhBSElBZGdCbEFH?=
 =?us-ascii?Q?d0FiQUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0JqQUc4QVpBQmxBSE1BWHdC?=
 =?us-ascii?Q?a0FHa0FZd0IwQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFB?=
 =?us-ascii?Q?QUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFjQUJ5QUc4?=
 =?us-ascii?Q?QWFnQmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZBR01BYndCdUFHWUFhUUJr?=
 =?us-ascii?Q?QUdVQWJnQjBBR2tBWVFCc0FGOEFiUUJoQUhJQWRnQmxBR3dBYkFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdB?=
 =?us-ascii?Q?QUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhB?=
 =?us-ascii?Q?YmdCaEFHMEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFRQmhB?=
 =?us-ascii?Q?R3dBWHdCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBYndCeUFGOEFZUUJ5QUcwQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
 =?us-ascii?Q?Q2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhR?=
 =?us-ascii?Q?QVh3QnVBR0VBYlFCbEFITUFYd0JqQUc4QWJnQm1BR2tBWkFCbEFHNEFkQUJw?=
 =?us-ascii?Q?QUdFQWJBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZBSElBWHdCbkFHOEFi?=
 =?us-ascii?Q?d0JuQUd3QVpRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dC?=
 =?us-ascii?Q?MkFHVUFiQUJzQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VB?=
 =?us-ascii?Q?Y3dCZkFISUFaUUJ6QUhRQWNnQnBBR01BZEFCbEFHUUFYd0J0QUdFQWNnQjJB?=
 =?us-ascii?Q?R1VBYkFCc0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3?=
 =?us-ascii?Q?QUhJQWJ3QnFBR1VBWXdCMEFGOEFiZ0JoQUcwQVpRQnpBRjhBY2dCbEFITUFk?=
 =?us-ascii?Q?QUJ5QUdrQVl3QjBBR1VBWkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFI?=
 =?us-ascii?Q?SUFYd0JoQUhJQWJRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIUUFaUUJ5QUcwQWFRQnVB?=
 =?us-ascii?Q?SFVBY3dBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFj?=
 =?us-ascii?Q?Z0IyQUdVQWJBQnNBRjhBZHdCdkFISUFaQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQSIvPjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4419:EE_|PH0PR18MB4460:EE_
x-ms-office365-filtering-correlation-id: 56e7ceb5-69f8-48c3-7be2-08db9740b431
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YV/wvbRjgWP0qR77GoE41FwPlTN21qfYrHt3N1tmp2ObZcLfomahG+cWu1m6bR5Q6+tZZSaCTx5kJRdk0aowpvoqg3HdGT+H7nz03Op1K1XNoE0ZtcYQdKO/4JOphduaPa0XwjXWXcdowOH0Lc3Z8vI0DeNn5sMB+0k8nUE6RcJYqQdxo8cBo+4RxAxA9YUFseRHRacpojf4gU8GQkg5Q2JNG0MambKn/hsN6HTpJsY/BG1ndgMZdqOK/+38HjG8sO8gRCFJfTBps12Uypn6jsDImzU2uUKtXHQaxf5eNetuOWHWM1pC0QFRVS/ZHnBMwmuIvgBmR84Dgh5CY2MOlyAth7NicsBNqgk2GlYZdADxeID41lJ614OTCwKM7D4qIODEhre5YlHofVQACnO3AboyWtXEZFRxZwp+nH+ZgfvEnFJyyP25VEI1/CMBelnX5Q7S2phcfF/oocJ/u4eCedl0VQoCLaNKrF6thLTJihCm5DxaR7aJdHhk4NLPNlqYOZUfvESFlx884asQmxLhkVaImaT9Ica0WNluA6Wm9K5C1Ue/epaesibpwYVrhZAeK7eoSA0EH/vljJRG+l5L5SeYBUwgw2kSPS0dpVf+TDIInIqYflRtyqPEeMmlZc1d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4419.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(366004)(376002)(346002)(136003)(396003)(1800799003)(186006)(451199021)(52536014)(38070700005)(41300700001)(26005)(2906002)(5660300002)(83380400001)(8676002)(8936002)(55016003)(122000001)(86362001)(316002)(33656002)(6506007)(53546011)(7696005)(76116006)(54906003)(110136005)(38100700002)(66556008)(64756008)(66446008)(66476007)(71200400001)(66946007)(478600001)(9686003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JpcVMsf3qqwdqrGWqHR/jVE4+SSnwU2CKlLZzoTTu/E6pyVES4KOLKbs9V4Q?=
 =?us-ascii?Q?ShSUfq5k3JT+jxYA2MrbFaqAoJpSdC0uvzS7EHVsNNSvlFb6nKFaleLfXgfH?=
 =?us-ascii?Q?zaC/QjvpDPSK+gDKKeYjawJGDTMkxm+pJh3aHtSU/kl1j3Gk+p0G1kLUX+wG?=
 =?us-ascii?Q?cs/UgpJPKTFNamC867MT9LGHpP5KWT9ofUSz7m1e/K8PN/q8cw+KgIuwYaUb?=
 =?us-ascii?Q?vfPl8O30VCAGHO+nnHmJdoKx3Q4+JjEx/luqsbHHfn8c7SD+/erBGJKrDokQ?=
 =?us-ascii?Q?cnLWqt4Ay+TlpLOvdIKcCuf+3VyW3t4Qykjn+B/ZPbr+V8CWZez2jIb0jTmT?=
 =?us-ascii?Q?+Eemu7DxMjOuL9jVGOffqdXTvx/+3gICbZ7/ymB+oSuUYuxls/4gqNArnsg3?=
 =?us-ascii?Q?zzhBP/uFTJ1zwgbd03z3yWR0O9Dj9HjX041ntVpOveNZEs7XgDCI6d3rbdvU?=
 =?us-ascii?Q?dkat9XKM0IwJukOeRdn6GqJXy4xxBIIQOJu543HAyqbs5die0agh0cI0SNnP?=
 =?us-ascii?Q?/tI8qlnmdRXQcTzBr5hHdD3Dqx/j/WrHUyO9/8g5TODx/AtZ8zMynESmnpJA?=
 =?us-ascii?Q?yU5XNd5GwUInJyb54yCKnf9sNVUfRcxOmKlEqO9r0XwoWS5//gydgYPPRP3B?=
 =?us-ascii?Q?PD0bQCzWWhtysO8jHwEGiRp+TVRW+NKh3MRohEmaGxbSyDz1IaUercTce3Pq?=
 =?us-ascii?Q?EZvyZZbpEP0AAcxtWo03mr7YuFWyWZGE1IhC2CGGAAOGOrz3enk67v/g/YWv?=
 =?us-ascii?Q?ij8tpowHhJKQkv6K11fo18ytHjtObGsBe2asKxlpRQWHUuFvD4tefs1AWS+O?=
 =?us-ascii?Q?fi1ZVoZE1ORHLR8oQmrdj5WpgfCpfdHKU9CSnDQwU/C/dnKhmggbi8m6MSSf?=
 =?us-ascii?Q?ffNziaFFnlkQTXsaQCSV/Z3+PniHVZdaPNkdb58KZfaebsEsPSHqAkLCeuDF?=
 =?us-ascii?Q?0SGQaCZuWzgnjEt1W708M/pUmCz9ZV4dEfi1APie+am6OWiLu3T2zZ9Khy/2?=
 =?us-ascii?Q?UbfQVuIuijHC4LDhZGqukkegTiU6Hflo2ZROmmGl14xsKw2Q2XfKqQcFArGc?=
 =?us-ascii?Q?6bO6GT7tWIIr5v26l0/kZ8qk6abDf6ODjlVUcZ/p0TNjk73OwOmd1iKlgDaU?=
 =?us-ascii?Q?sNCYVCs1sjHDfmgP6Iue12dqFLGU3FkfABRdWAGWY2CGFMAArflkElv1/9pc?=
 =?us-ascii?Q?XDni1KhsG1Zoy3E9zljYHWjMlRFN1CcMOvETXPp1cPrEDnfl/oLUFpzGX0YW?=
 =?us-ascii?Q?abgX2CdKbHIIqzopOYyE9zz31ZOSnwyl6mqMV8M2OX07dsDDBq4fE8qNHeYd?=
 =?us-ascii?Q?6tt5KDxtm8tHcX9sPfUWegMv7iI/RoNPszSEAUDOkq0AC+2jtybpe5omTFUc?=
 =?us-ascii?Q?eao9ZvuY/DexfQamxkVlxPwf3+DGIUJxvPio71OTQJ1y4aTDqGu4UgQVpFSx?=
 =?us-ascii?Q?SiA5EpFUR433cDtJ4+Lg1DU15GmKVa97/Vv0/H5J0KkoU8j+TY95odag0Mj0?=
 =?us-ascii?Q?8ZD9BtJxmbhPUpCei8S/74mCsi9+3uC5crm49GhudNCtgwjrdV2sBii83/4D?=
 =?us-ascii?Q?Bt84n0GdcKN6L2DQwd40JX4OJZonfCzXdJ55Gn21?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4419.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e7ceb5-69f8-48c3-7be2-08db9740b431
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 12:20:35.9590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7aiqzZqVTqbxZx9GUxJAKZfL8Hk4w8TRqiNXffxtIT67hxt/Dlfz3nXGsFf9J4mUR/S/rvqAsAeMPzDNHwaTwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4460
X-Proofpoint-GUID: _pvc2BOqQDTuRVA6h9q-eut8UfXzlwui
X-Proofpoint-ORIG-GUID: ASTGHuagPeRGi6EBETMreaOkMGVpnEng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_12,2023-08-03_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Chengfeng Ye <dg573847474@gmail.com>
> Sent: Wednesday, July 26, 2023 6:27 PM
> To: Nilesh Javali <njavali@marvell.com>; Manish Rangankar
> <mrangankar@marvell.com>; GR-QLogic-Storage-Upstream <GR-QLogic-
> Storage-Upstream@marvell.com>; jejb@linux.ibm.com;
> martin.petersen@oracle.com
> Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org; Chengfeng Y=
e
> <dg573847474@gmail.com>
> Subject: [EXT] [PATCH] scsi: qedi: Fix potential deadlock on &qedi_percpu=
-
> >p_work_lock
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> As &qedi_percpu->p_work_lock is acquired by hard irq qedi_msix_handler(),
> other acquisition of the same lock under process context should disable i=
rq,
> otherwise deadlock could happen if the irq preempt the execution while th=
e
> lock is held in process context on the same CPU.
>=20
> qedi_cpu_offline() is one such function acquires the lock on process cont=
ext.
>=20
> [Deadlock Scenario]
> qedi_cpu_offline()
>     ->spin_lock(&p->p_work_lock)
>         <irq>
>         ->qedi_msix_handler()
>         ->edi_process_completions()
>         ->spin_lock_irqsave(&p->p_work_lock, flags); (deadlock here)
>=20
> This flaw was found by an experimental static analysis tool I am developi=
ng
> for irq-related deadlock.
>=20
> The tentative patch fix the potential deadlock by spin_lock_irqsave() und=
er
> process context.
>=20
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> ---
>  drivers/scsi/qedi/qedi_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.=
c
> index 450522b204d6..77a56a136678 100644
> --- a/drivers/scsi/qedi/qedi_main.c
> +++ b/drivers/scsi/qedi/qedi_main.c
> @@ -1976,8 +1976,9 @@ static int qedi_cpu_offline(unsigned int cpu)
>  	struct qedi_percpu_s *p =3D this_cpu_ptr(&qedi_percpu);
>  	struct qedi_work *work, *tmp;
>  	struct task_struct *thread;
> +	unsigned long flags;
>=20
> -	spin_lock_bh(&p->p_work_lock);
> +	spin_lock_irqsave(&p->p_work_lock, flags);
>  	thread =3D p->iothread;
>  	p->iothread =3D NULL;
>=20
> @@ -1988,7 +1989,7 @@ static int qedi_cpu_offline(unsigned int cpu)
>  			kfree(work);
>  	}
>=20
> -	spin_unlock_bh(&p->p_work_lock);
> +	spin_unlock_irqrestore(&p->p_work_lock, flags);
>  	if (thread)
>  		kthread_stop(thread);
>  	return 0;
> --
> 2.17.1


Thanks for the patch,

Acked-by: Manish Rangankar <mrangankar@marvell.com>
