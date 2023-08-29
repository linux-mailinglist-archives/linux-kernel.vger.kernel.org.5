Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D15D78CB12
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjH2RVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238246AbjH2RUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:20:39 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7522129
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:20:13 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T9seZQ010727;
        Tue, 29 Aug 2023 10:18:56 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sqgwkj1py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 10:18:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjyB9WSCVd1DRw8iRTjE3Q4W8uEUq1qsUlL5QdLapCIeXHDxVjH8ViOdlDBZlBWzM+2a3aq6I7SzflFQFZGzqMLkAFPSyacgQe49dN4Y1sMAxqEIvMg88vmPoSPym4gbffYnBfB9TdeOIogf2lKs/2xd73kxwijhQ1lfNCWAGBne5NGdckP3P3xVP8drNIxSJU5qiBGpoJe2ulXqlrIlnfZ+4N/4Jw0zG8yixAXGHWfGy7PxY8TIJgC/XaCVF5LGtRX3gEMmRbbzsmzV+uPXIdaQUug+zWOsoegasfASMA3+5SI3hjdhh0pabBJ29DJ8givIQXACr2CYfwYZSupcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OV4JpHWO7mnsYcJWVZ4KAqThP4aCyQG64NpRGU7vSlE=;
 b=P/qrUPfh4NQnrVX8r2uxCrE0b7duCFXETmdQet/0qGoOPd1yvAdsGf+LKDQuNIzhzfjVtZZ4467xfRN0AfmSOMucmeRILkglquq3ifUb9VJ2EwmmcQ9issSYXxa3VCWEuBqSfyW6Zt8jiANN1Eivde4HXrqhSMpB1aqnPewCmnNeDpwj42Wb2rrEmLtpIC3bbljd8NsQFSEtXZCQ2F8BzOybEysHSnjiZW1EA6OcT2FwbTNI0nmSO12aWbz7OXN//hHbgxGrXE0kckAzy/bgGf72Hzo1DTvzMWYhCFvd1ybnrunA1xqUjwPYMkLMvcxtSXGGrgsuq6I72m9bV8sNWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OV4JpHWO7mnsYcJWVZ4KAqThP4aCyQG64NpRGU7vSlE=;
 b=A1sQMJJq7///dtNQw+S002QmG90JhoSM+zKF1qnXgXICVyApz15DJyMKvUVN1Ur0KKLWZ3xjiE+MOfYLPXujyX3VRqvnhBNw4/Qy9ywhHaR/crcZKK6z+AP7hdsOMU7Zr3ENq4wBSHY8wwxUlMOKmgyPuaq9scsX59k7/GhgYdg=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by PH7PR18MB5283.namprd18.prod.outlook.com (2603:10b6:510:243::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36; Tue, 29 Aug
 2023 17:18:53 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::3e51:51f3:34c:c6e8]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::3e51:51f3:34c:c6e8%5]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 17:18:53 +0000
From:   Amit Singh Tomar <amitsinght@marvell.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Reinette Chatre <reinette.chatre@intel.com>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "peternewman@google.com" <peternewman@google.com>,
        Drew Fustini <dfustini@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: resctrl2 - status
Thread-Topic: [EXT] Re: resctrl2 - status
Thread-Index: AQHZ14yt5T5uw+Je00O2uJV7ignXmK/7dAwAgAWihYCAAHEOYA==
Date:   Tue, 29 Aug 2023 17:18:53 +0000
Message-ID: <MW4PR18MB50847485155B226B07DABEAAC6E7A@MW4PR18MB5084.namprd18.prod.outlook.com>
References: <DS7PR11MB6077FE180B11A9138D8E7ED7FC1DA@DS7PR11MB6077.namprd11.prod.outlook.com>
        <35f05064-a412-ad29-5352-277fb147bbc4@intel.com>
        <SJ1PR11MB6083BC6B330FA7B7DFD3E76AFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
        <dc4cd365-2a02-32a3-da78-7ba745877e97@intel.com>
        <SJ1PR11MB6083C0ED50E9B644F4AF8E4BFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
        <fb9499b9-c445-01e8-8427-6b05256abdb5@intel.com>
 <20230829112321.00002b55@Huawei.com>
In-Reply-To: <20230829112321.00002b55@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pdHNpbmdo?=
 =?us-ascii?Q?dFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?us-ascii?Q?NGJhMjllMzViXG1zZ3NcbXNnLTFkNGY4MDUwLTQ2OTAtMTFlZS1iNzI4LTFj?=
 =?us-ascii?Q?YzEwYzQ3MmM3Y1xhbWUtdGVzdFwxZDRmODA1MS00NjkwLTExZWUtYjcyOC0x?=
 =?us-ascii?Q?Y2MxMGM0NzJjN2Nib2R5LnR4dCIgc3o9IjY0NDYiIHQ9IjEzMzM3ODAzMTI4?=
 =?us-ascii?Q?ODI5NjE5OSIgaD0iT2JPMnl3cHZrRWNidjhiYVFhMDNRbVEzV0hJPSIgaWQ9?=
 =?us-ascii?Q?IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBTjRQ?=
 =?us-ascii?Q?QUFBSG84ZmZuTnJaQWRkZktGeGNuWVlNMTE4b1hGeWRoZ3daQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUhBQUFBQnVEd0FBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQVFFQkFBQUE5UmVuTHdDQUFRQUFBQUFBQUFBQUFKNEFBQUJoQUdR?=
 =?us-ascii?Q?QVpBQnlBR1VBY3dCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHTUFkUUJ6QUhRQWJ3QnRBRjhB?=
 =?us-ascii?Q?Y0FCbEFISUFjd0J2QUc0QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBZ0FBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWXdCMUFITUFkQUJ2QUcwQVh3QndBR2dBYndCdUFHVUFi?=
 =?us-ascii?Q?Z0IxQUcwQVlnQmxBSElBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmpB?=
 =?us-ascii?Q?SFVBY3dCMEFHOEFiUUJmQUhNQWN3QnVBRjhBWkFCaEFITUFhQUJmQUhZQU1B?=
 =?us-ascii?Q?QXlBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFEUUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
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
x-dg-rorf: true
x-dg-refthree: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFDQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQSIvPjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5084:EE_|PH7PR18MB5283:EE_
x-ms-office365-filtering-correlation-id: 52c5c25d-d182-4684-ed95-08dba8b40511
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kq8red3yTyrZP2LMsY2hAFXl28Kfe+Fb+gFWV9tmnMdz35nMU/zYZVDAOSOz+CNzkmi7FIiWZ2oyLNZjnJSpvThqR5zv+akm4Bk/wJrHbmr9SJxd9JuUN4+3czdcuMQbmXqfqBjq/TH3gUOlfZYIm8RJUsYVgGL90wIBW3y2T+4qCAQnwTJzV2vGQ3/7KOwlg4k5DDI/G5UpZQU0GEj9bePUi65gFVdpqvGHbKemnRpWO1gJiA5P9VB3LBRYDD7jSxEBOMcFgp+rtI+A1iujMpmyXSoT1bi6bmLIX+4N267zFkS8nUsJzIm07118/S+eUXpRjCq0oXlm8toTfpLutl3XejXK3Z9JFvivTXlq/seMCdFypeFaYFDVl2neuJuoXiPB0IzLsL7e7RUYhnp7SvjRTh4UVebWv5t7H8JMBDR65ncRy9/ogurJjMHl+4qmU0xkw7w/CY9ZO1Lp+XcqDOLrDgRwK91jGzptz50O357YxBBxeSFuSarnZyFZHIurc8hSxCozWlyerjfeIAYUFdMkJ3jUvQkztEhE5Mm+cSwrU0mocyymDMF6Zxd89bM7ZOQR2A4FtRaBDDpmS9lyJWSCcVbAjSGz8FeTzQi8AjI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(1800799009)(186009)(451199024)(8936002)(122000001)(478600001)(110136005)(53546011)(76116006)(7696005)(6506007)(71200400001)(66556008)(66476007)(64756008)(66446008)(54906003)(66946007)(966005)(38070700005)(316002)(38100700002)(41300700001)(66899024)(9686003)(26005)(5660300002)(8676002)(83380400001)(2906002)(52536014)(86362001)(55016003)(7416002)(33656002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kf39nzaaYKt78gYX5A2yd+AHMB7RhHCVIEhjW9yMZGmrgEu8VQWeEq5zw7Fh?=
 =?us-ascii?Q?zmaL39jq5VERGgkk5TM/PjQ/mrN+ayu/eFBysfBsrXb3ZUxn9Hs2gA5Yc/hL?=
 =?us-ascii?Q?q9kqa4/C4x+xfhcFgavM2SNZeuoTLFAhSqsi0G35Di86KMzwDWvgQwfn/sVq?=
 =?us-ascii?Q?olR0zWHGRN9+qiMa8AA6/kQO1sVTYIgl9wRKNaJehZgEk7w5rQP60nBnVTuY?=
 =?us-ascii?Q?Plbqo7SivJNXbFm7LveeTK0oFVQD8TPqQnorCJeTWi1bI7FdmMawK2v8k6Fb?=
 =?us-ascii?Q?9WWcW4tHJ76uw6TMjHh/1yd6GE/gsdrB8RPgJ/s57t/QCP/v665tG1C/8hPE?=
 =?us-ascii?Q?oYKsH/i9CWl5DG+auNH9UYr/Y1t9GzCKqYYgW4+Z8Vmt0XGmL490gdpUWkbJ?=
 =?us-ascii?Q?SSSQ1pAVQ3tW2+byA0pY+S+udV1WsO8bj/EK47IWYRAu6robP0KS7eSzPEO1?=
 =?us-ascii?Q?/LYbH/pk4A16M3open3THn6852C+wHQ/TRsf9CpJY528tdDq5Z9ogrc6QOxm?=
 =?us-ascii?Q?fscCqao7A2Som/q+l9JsamAmVwX9PvoT68AdRTW2MxATSXyJ+FfQMbgOfGPt?=
 =?us-ascii?Q?66K6imuC4EVH1XE+ZExBx4onFw/5+OZai2BnCoH6Firbi67EDDf20OJGpzby?=
 =?us-ascii?Q?c3JrZpqXYNhKAcJXCdjGx/I2UlBKuSbQMVUrfXguMwJ/1qAmI+WixYFH2V/H?=
 =?us-ascii?Q?DV1aZ44yX+HPwa3SfpKBeSFeMgT8hW3XGhP0OzGEVelqY8ygOvINtr6zPOLP?=
 =?us-ascii?Q?iUS7g102WonK/IhkAxeVj/UDUOAHIPBIvyaHP+Ky9eYSndk+wzgMuxEKOqbT?=
 =?us-ascii?Q?dUGinR/ZD+8bxYJEOFNETVhxlFU0yj2+wbCUkRj9QppafNWYwliTA5zIoWIn?=
 =?us-ascii?Q?GtmlV6hvJXVcxVT4141b3N7yYmYTQzSF9a+hvPwRk/z75CcVCM1p7ygd4eiL?=
 =?us-ascii?Q?6KBZ/IG5/04tarnspKHQwihf+l7RSav2d6OP8JlFOritF63jXWbr2VYD5g9A?=
 =?us-ascii?Q?slTxgkuaqWKSYiYZNpCQzeIpJi0IGT4nAZAPB/Oo4i5EO+gXKf/0SvVOqoId?=
 =?us-ascii?Q?AXPQjyUxdkVH5PZ0ZzhhD3ANZU9m4gGy1X2y2sYRxMg0wMURw/CjPAucONL8?=
 =?us-ascii?Q?sZVsMccixS37MypxiXJHS/cNXiVm+rbMoay2AkW6i6bxaDFqHQyFDQCZ0E9/?=
 =?us-ascii?Q?qTNUeGrIsZxIkfiiapqmaqaRl39BMEwbpDEYFMtnelF0KZvxbo9guKVv5mSi?=
 =?us-ascii?Q?8fytdsteHQoFT3mGPAghGtsa7fT0Nv5oodwePIsiUalwB0PWYu2mH8ir7aQ+?=
 =?us-ascii?Q?KVZpEmzOjm/Qm1RvMtanVqwULAeJpSa+XIfiQ3aFHFtqAIkPe6PkxiY2c8H4?=
 =?us-ascii?Q?T3LC47610gyKOUUH006IDNcc/pBTCrWf+MMh+dQELvs8pCq+SFihCMLLQS6O?=
 =?us-ascii?Q?+sHPO5ESDaddPtwJ9FzuUcZWE/SAfR7A3ANWfKAHZpHpyJIaYKIR6fcae6Qe?=
 =?us-ascii?Q?oro8yQW19KPi/QNEegQ3VshB2X+QOKJ3EBdLYFLVfYxpthOnJnhaxQCS7PuG?=
 =?us-ascii?Q?SEDhY6Mn9HM8UDyrTRmthfPlBujQNasq7Dd7cBXP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c5c25d-d182-4684-ed95-08dba8b40511
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 17:18:53.5356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tgF8px92a44vYuZ3uC5nZZfBcEE8E2xlWKQAvh1PuX7S6NaE9wC/wEQENC3XUCdvAgb6VHo3sf2VLDSyaW8e2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5283
X-Proofpoint-GUID: YvmQ42V90VIKTPR6WEXU_8byoc00uS0w
X-Proofpoint-ORIG-GUID: YvmQ42V90VIKTPR6WEXU_8byoc00uS0w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=20
Sent: Tuesday, August 29, 2023 3:53 PM
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Luck, Tony <tony.luck@intel.com>; Amit Singh Tomar <amitsinght@marvell.=
com>; Yu, Fenghua <fenghua.yu@intel.com>; james.morse@arm.com; George Cheri=
an <gcherian@marvell.com>; robh@kernel.org; peternewman@google.com; Drew Fu=
stini <dfustini@baylibre.com>; linux-kernel@vger.kernel.org; linux-arm-kern=
el@lists.infradead.org
Subject: [EXT] Re: resctrl2 - status

External Email

----------------------------------------------------------------------
On Fri, 25 Aug 2023 13:20:22 -0700
Reinette Chatre <reinette.chatre@intel.com> wrote:

> Hi Tony,
>=20
> On 8/25/2023 12:44 PM, Luck, Tony wrote:
> >>>> Alternatively, can user space just take a "load all resctrl=20
> >>>> modules and see what sticks" (even modules of different=20
> >>>> architectures since a user space may want to be generic) approach?
> >>>
> >>> This mostly works. Except for the cases where different modules=20
> >>> access the same underlying hardware, so can't be loaded together.
> >>>
> >>> Examples:
> >>>
> >>> rdt_l3_cat vs. rdt_l3_cdp - user needs to decide whether they want CD=
P or not.
> >>> But this is already true ... they have to decide whether to pass=20
> >>> the "-o cdp" option to mount.
> >>>
> >>> rdt_l3_mba vs. rdt_l3_mba_MBps - does the user want to control=20
> >>> memory bandwidth with percentages, or with MB/sec values. Again=20
> >>> the user already has to make this decision when choosing mount option=
s.
> >>>
> >>>
> >>> Maybe the "What resctrl options does this machine support?"=20
> >>> question would be best answered with a small utility?
> >>
> >> A user space utility or a kernel provided utility? If it is a user=20
> >> space utility I think it would end up needing to duplicate what the=20
> >> kernel is required to do to know if a particular feature is=20
> >> supported. It seems appropriate that this could be a kernel utility=20
> >> that can share this existing information with user space. resctrl alre=
ady supports the interface for this via /sys/fs/resctrl/info.
> >=20
> > I was imagining a user space utility. Even though /proc/cpuinfo=20
> > doesn't show all features, a utility has access to all the CPUID=20
> > leaves that contain the details of each feature enumeration.
>=20
> For x86 that may work (in some scenarios, see later) for now but as I=20
> understand Arm would need a different solution where I believe the=20
> information is obtained via ACPI. I think it is unnecessary to require=20
> user space to have parsers for CPUID and ACPI if that same information=20
> needs to be parsed by the kernel and there already exists an interface=20
> with which the information is communicated from kernel to user space.=20
> Also, just because information CPUID shows a feature is supported by=20
> the hardware does not mean that the kernel has support for that=20
> feature. This could be because of a feature mismatch between user=20
> space and kernel, or even some features disabled for use via the, for exa=
mple "rdt=3D!l3cat", kernel parameter.

James probably also has views on this, but I wouldn't expect userspace to g=
o anywhere near ACPI parsing. If the description of what MPAM features are =
supported (before resctrl is running) is necessary, then we should add it t=
o the existing description of the various caches etc.  Maybe somewhere in /=
sys/bus/node/devices/nodeX/cpuY/cache/indexZ/
for the caches
and
/sys/bus/node/devices/nodeX for the DRAM controllers.
[>>] Or may be all the MPAM features list is unified at one place, somethin=
g like this ?
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=
=3Dmpam/snapshot/v6.5-rc1&id=3Dc32874cd1d68241c481a9d0c32c8c65d019c247e

I'm sure we can find somewhere sensible for other things covered by MPAM.
The MPAM table parsers and some early code to query features from the hardw=
are should be able to figure out what is needed.

Perhaps x86 systems could provide similar descriptions but originating from=
 CPUID etc.

Jonathan

>=20
> >> fyi ... as with previous attempts to discuss this work I find it=20
> >> difficult to discuss this work when you are selective about what=20
> >> you want to discuss/answer and just wipe the rest. Through this I=20
> >> understand that I am not your target audience.
> >=20
> > Not my intent. I value your input highly. I'm maybe too avid a=20
> > follower of the "trim your replies" school of e-mail etiquette. I=20
> > thought I'd covered the gist of your message.
> >=20
> > I'll try to be more thorough in responding in the future. =20
>=20
> Two items from my previous email remain open:
>=20
> First, why does making the code modular require everything to be=20
> loadable modules?
> I think that it is great that the code is modular. Ideally it will=20
> help to support the other architectures. As you explain this modular=20
> design also has the benefit that "modules" can be loaded and unloaded aft=
er resctrl mount.
> Considering your example of MBA and MBA_MBps support ... if I=20
> understand correctly with code being modular it enables changes from=20
> one to the other after resctrl mount. User can start with MBA and then=20
> switch to MBA_MBps without needing to unmount resctrl. What I do not=20
> understand is why does the code being modular require everything to be=20
> modules? Why, for example, could a user not interact with a resctrl=20
> file that enables the user to make this switch from, for example, MBA=20
> to MBA_MBps? With this the existing interfaces can remain to be=20
> respected, the existing mount parameters need to remain anyway, while ena=
bling future "more modular" usages.
>=20
> Second, copied from my previous email, what is the plan to deal with=20
> current users that just mount resctrl and expect to learn from it what=20
> features are supported?
>=20
> Reinette
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.infradead.or
> g_mailman_listinfo_linux-2Darm-2Dkernel&d=3DDwICAg&c=3DnKjWec2b6R0mOyPaz7=
x
> tfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dri5Ay9ia3NmwAS6P9=
4yjZ7rPIR1dIqrIAIjpslfwcd5ulIIs5BNEG9jmTlq6H6o8&s=3DKZMxmC8InOxAyxgrDig96R2=
aKf2hc1C_hk_1413pjCI&e=3D
>=20

