Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E50E766545
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjG1H07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbjG1H0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:26:38 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C2A3C1D;
        Fri, 28 Jul 2023 00:26:33 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S2NHS1032033;
        Fri, 28 Jul 2023 00:26:30 -0700
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3s44uggptx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 00:26:29 -0700
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36S7Nrvt026757;
        Fri, 28 Jul 2023 00:26:29 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3s44uggptu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 00:26:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFA6oz1paiiK+xH0Akrzm6DH4/9D9+/XBRfGQduAg9sODSJtd2rJWW0GYjkf6wXKRq4+Gh9dnVoIpcg97Qyypy79AwXTta0NUSUoO9f1wQUhVsPIJO+wsHdlGGmVxlMjzit1y3b8ki66tcp5UXb5+0Qyv6O9iSNdASmpTYZKbmFEt6fJ6hxlMUuworpWW0QyIYIxtQQW9MudlpErw2UAv1lwJccL5FhRUMdhCsWKhYQPZIwbnO9zc5W9HXbWzW9Y/whWXcyIA2Gv+UFdwUVJCk90MCGBzC7iacExFihlV8vjgqoxQn+eVkDGFzHmMA9mCUIfbU/sND+eVKTsr3lh0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oqtLVSOtDzCx0D7pjK2CGdFQDn4AYd6imNMptPdr6E=;
 b=m3zUZi+xRDpvGoTT+Lp4HWkeUjNozI9t20lTJ0owEUkFskRKX+x0Mt+kSCqRyFCHu3tprgp12ZM6MRuVF+Cu5oe8a6oe/g+h3MVivf1FqbeEZ8AC6G5UmKsZJnpCK0rHl2WLwFMyIQ/kgodUql/Z2o64oBmvmvx9LDeUxAG3odoku1VvaGH8nzKsUu7rsa5f7aHzO5LXruli/6+v4m4HX89g9rAGCna3faNaJuXZ71MS7QyMA/2X0M+lnmlavZ/JqLDZL7SIf4A7fL86rpNrT/JNc9aXE/9F+Bozi1UDcGJ+i9PBsdeTumgE5fngHtQQz7DNxOXVSPnZQpNJ5E3diQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oqtLVSOtDzCx0D7pjK2CGdFQDn4AYd6imNMptPdr6E=;
 b=I7IXZ4Zp2voFd7CxM8dq3AC4HyKdThEjSUTETp6KcZ8IojxV7PUo4fYitnBdph8AZfxn82ejia6DwHWi9UnPbTmCxceMEOyLTnx0+yGL1bA0V38P46CdwzhBvegiHzsgLLk46rFdA/UnTErbxzjwEVHMue38IKvTjnhZswkLV+Q=
Received: from DM4PR18MB5220.namprd18.prod.outlook.com (2603:10b6:8:53::16) by
 PH7PR18MB5178.namprd18.prod.outlook.com (2603:10b6:510:158::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Fri, 28 Jul 2023 07:26:25 +0000
Received: from DM4PR18MB5220.namprd18.prod.outlook.com
 ([fe80::5bc6:1bcd:632:4db2]) by DM4PR18MB5220.namprd18.prod.outlook.com
 ([fe80::5bc6:1bcd:632:4db2%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 07:26:24 +0000
From:   Saurav Kashyap <skashyap@marvell.com>
To:     Oleksandr Natalenko <oleksandr@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jozef Bacik <jobacik@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Rob Evers <revers@redhat.com>
Subject: RE: [EXT] [PATCH 0/3] scsi: qedf: sanitise uaccess
Thread-Topic: [EXT] [PATCH 0/3] scsi: qedf: sanitise uaccess
Thread-Index: AQHZwSDpRRSk+cuWs0Ox5FI9qOsZ96/OxzMQ
Date:   Fri, 28 Jul 2023 07:26:24 +0000
Message-ID: <DM4PR18MB5220645416C02E2250D03B69D206A@DM4PR18MB5220.namprd18.prod.outlook.com>
References: <20230728065819.139694-1-oleksandr@redhat.com>
In-Reply-To: <20230728065819.139694-1-oleksandr@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2thc2h5YXBc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy0wYzFlNzRjNC0yZDE4LTExZWUtOTUyYi0wNGI5?=
 =?us-ascii?Q?ZTM5ZDMzNDRcYW1lLXRlc3RcMGMxZTc0YzYtMmQxOC0xMWVlLTk1MmItMDRi?=
 =?us-ascii?Q?OWUzOWQzMzQ0Ym9keS50eHQiIHN6PSIzMTY0IiB0PSIxMzMzNTAwMjc4MjI2?=
 =?us-ascii?Q?MDg3NzAiIGg9ImtjSWRYdzBOM3JmOTFtSlJLbWpNQTZ3MEY1QT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU40UEFB?=
 =?us-ascii?Q?Q0NzU2ZQSk1IWkFmeHdkT3NBd2tYWS9IQjA2d0RDUmRnWkFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUJ1RHdBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRRUJBQUFBSTdxVHBBQ0FBUUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFa?=
 =?us-ascii?Q?QUJ5QUdVQWN3QnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01BZFFCekFIUUFid0J0QUY4QWNB?=
 =?us-ascii?Q?QmxBSElBY3dCdkFHNEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFHMEFYd0J3QUdnQWJ3QnVBR1VBYmdC?=
 =?us-ascii?Q?MUFHMEFZZ0JsQUhJQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJqQUhV?=
 =?us-ascii?Q?QWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QVpBQmhBSE1BYUFCZkFIWUFNQUF5?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?TUFkUUJ6QUhRQWJ3QnRBRjhBY3dCekFHNEFYd0JyQUdVQWVRQjNBRzhBY2dC?=
 =?us-ascii?Q?a0FITUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWXdCMUFITUFkQUJ2QUcw?=
 =?us-ascii?Q?QVh3QnpBSE1BYmdCZkFHNEFid0JrQUdVQWJBQnBBRzBBYVFCMEFHVUFjZ0Jm?=
 =?us-ascii?Q?QUhZQU1BQXlBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFB?=
 =?us-ascii?Q?QUFBSUFBQUFBQUo0QUFBQmpBSFVBY3dCMEFHOEFiUUJmQUhNQWN3QnVBRjhB?=
 =?us-ascii?Q?Y3dCd0FHRUFZd0JsQUY4QWRnQXdBRElBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FB?=
 =?us-ascii?Q?QUdRQWJBQndBRjhBY3dCckFIa0FjQUJsQUY4QVl3Qm9BR0VBZEFCZkFHMEFa?=
 =?us-ascii?Q?UUJ6QUhNQVlRQm5BR1VBWHdCMkFEQUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFaQUJzQUhBQVh3QnpB?=
 =?us-ascii?Q?R3dBWVFCakFHc0FYd0JqQUdnQVlRQjBBRjhBYlFCbEFITUFjd0JoQUdjQVpR?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCa0FHd0FjQUJm?=
 =?us-ascii?Q?QUhRQVpRQmhBRzBBY3dCZkFHOEFiZ0JsQUdRQWNnQnBBSFlBWlFCZkFHWUFh?=
 =?us-ascii?Q?UUJzQUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1VBYlFCaEFHa0FiQUJmQUdFQVpBQmtB?=
 =?us-ascii?Q?SElBWlFCekFITUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQ2dBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFG?=
 =?us-ascii?Q?OEFiZ0JoQUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFBYVFC?=
 =?us-ascii?Q?aEFHd0FYd0JoQUd3QWJ3QnVBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNn?=
 =?us-ascii?Q?QjJBR1VBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdCdUFHRUFiUUJsQUhN?=
 =?us-ascii?Q?QVh3QnlBR1VBY3dCMEFISUFhUUJqQUhRQVpRQmtBRjhBWVFCc0FHOEFiZ0Js?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZUUJ5QUhZQVpRQnNBRjhBY0FC?=
 =?us-ascii?Q?eUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUhJQVpRQnpBSFFB?=
 =?us-ascii?Q?Y2dCcEFHTUFkQUJsQUdRQVh3Qm9BR1VBZUFCakFHOEFaQUJsQUhNQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBR0VBY2dCdEFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refthree: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFB?=
 =?us-ascii?Q?SUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QVp3QnZBRzhBWndC?=
 =?us-ascii?Q?c0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUcw?=
 =?us-ascii?Q?QVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFZd0J2?=
 =?us-ascii?Q?QUdRQVpRQnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dB?=
 =?us-ascii?Q?YkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdCakFHOEFaQUJsQUhNQVh3QmtB?=
 =?us-ascii?Q?R2tBWXdCMEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFB?=
 =?us-ascii?Q?QUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBY0FCeUFHOEFh?=
 =?us-ascii?Q?Z0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUdNQWJ3QnVBR1lBYVFCa0FH?=
 =?us-ascii?Q?VUFiZ0IwQUdrQVlRQnNBRjhBYlFCaEFISUFkZ0JsQUd3QWJBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFB?=
 =?us-ascii?Q?RzBBWVFCeUFIWUFaUUJzQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4QWJn?=
 =?us-ascii?Q?QmhBRzBBWlFCekFGOEFZd0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFhUUJoQUd3?=
 =?us-ascii?Q?QVh3QnRBR0VBY2dCMkFHVUFiQUJzQUY4QWJ3QnlBRjhBWVFCeUFHMEFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNl?=
 =?us-ascii?Q?QUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29BWlFCakFIUUFY?=
 =?us-ascii?Q?d0J1QUdFQWJRQmxBSE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRBZEFCcEFH?=
 =?us-ascii?Q?RUFiQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3Qm5BRzhBYndC?=
 =?us-ascii?Q?bkFHd0FaUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJB?=
 =?us-ascii?Q?R1VBYkFCc0FGOEFjQUJ5QUc4QWFnQmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3?=
 =?us-ascii?Q?QmZBSElBWlFCekFIUUFjZ0JwQUdNQWRBQmxBR1FBWHdCdEFHRUFjZ0IyQUdV?=
 =?us-ascii?Q?QWJBQnNBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FI?=
 =?us-ascii?Q?SUFid0JxQUdVQVl3QjBBRjhBYmdCaEFHMEFaUUJ6QUY4QWNnQmxBSE1BZEFC?=
 =?us-ascii?Q?eUFHa0FZd0IwQUdVQVpBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZBSElB?=
 =?us-ascii?Q?WHdCaEFISUFiUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
 =?us-ascii?Q?Q2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSFFBWlFCeUFHMEFhUUJ1QUhV?=
 =?us-ascii?Q?QWN3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dC?=
 =?us-ascii?Q?MkFHVUFiQUJzQUY4QWR3QnZBSElBWkFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUEiLz48L21ldGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR18MB5220:EE_|PH7PR18MB5178:EE_
x-ms-office365-filtering-correlation-id: 5c465b39-2242-4f05-8bd0-08db8f3bf30c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GuESSxgRDwUlJd6QY1qqVZe+jrcGWqtZLHtclPautGMrO6achOY5vJXnpD5JbpHKW2RnqD9DXVyAIwPo8I4pAcPac36zKU/aSovwlistkgwEUsC30X17F3XSBT7uMVFpKeaBpBWr/MJl/WHSp7siaJt+5mUvT/pRx1oz8DibkKafzH/uyZJgu5KuNb47aQlASZvKAmNnWNK74POe9zwyXGm/mLLAw5yIYU/3sVIatpir3PyN3VgLaAr8uJJDvb+nOXrdti3IOPoGkE/nhSZuuqYtxktgN7xhqxJHFcfwMkg/KUADMhQLyymrd+PXAExeqxph/DaSGdPF6T96VCFNVVGfic1a/WqFN6GuTAizO/d6KGEqBbyJl3SLr5UIN56BJdZaWQYSlwEqPoTlgp3FXK98RNLKeiycA7FsMXzIoRwq4/JApjUm6q5KA7uxx9ybNoip9zEPP20vz/lbciYSJqnc+RDQi+M0ls5OyMcgCxpwQQbNv3DpC3EhN9WE8v2JXzAZMV9WLO8AkQEEpJ2UsI3NLrRzDbYWsuj9/1+FqaFQlzlV3aVstRHMQQFJDtWghF/9W/IuYn3mawkqt5tHpqTRVkJzWO0uouGSYaXw3JE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB5220.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199021)(71200400001)(7696005)(478600001)(83380400001)(966005)(53546011)(9686003)(26005)(6506007)(66446008)(66946007)(66476007)(76116006)(66556008)(64756008)(38100700002)(122000001)(54906003)(110136005)(186003)(4326008)(5660300002)(52536014)(33656002)(41300700001)(38070700005)(316002)(2906002)(8676002)(8936002)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vu04hYMhK9/Tv+le77/6kumIS+ZSiexL8dcCTseYlRwJ5wprzes94Ta7GKWb?=
 =?us-ascii?Q?m2FfIObLKV8RIemsbylq2XWJb9aIbudrWOLM3NfJ0MK+eee627Qimtk7u/yI?=
 =?us-ascii?Q?IVSlXPvQNpdGiUTR+VeESOP7Y+V7socuCFytYKA+9wmtt001qmf2I3T9Es2R?=
 =?us-ascii?Q?Rd44KhvBq/tdQ6HFO+jeZ3CPp0SyZDao0LcRvRwpEcP4G0vuziJ4GbaFwLA/?=
 =?us-ascii?Q?XSmtdKCtxcOX23fo3gNlvCrjSC8XB+PMfFP0odWvJZz/HNE+t1ZmSQ7UoK5r?=
 =?us-ascii?Q?reFKC1Uxv3HNaPW1FepgkbvlQ7hrZss7R24BrF5PT4twWymN64MxeqU9BuRP?=
 =?us-ascii?Q?kHZi2cV14rj331y2UG0hoeXXPmDH66NVF2pjBiJ8/X2L2EsKZGmbUOve03Nn?=
 =?us-ascii?Q?cYKlE0i+N0eApxQoHhaxeYT4lcgd56c+D9uXjCgEt+yLNBdNd3uBy2mGgaHa?=
 =?us-ascii?Q?ykEPB9x/ox9ybQDlDkHPzXBHi7Nkz+12RlqyMIurLXoFX5NBOvho1G076zLw?=
 =?us-ascii?Q?eMUMFNRMvpanLmAFAnlI3vuirPaQbK9ezJMK9LUb2xIUfWriH3V+DNdFhIUl?=
 =?us-ascii?Q?L8Bwj9p49PwTnm+VSqk4WU3wxICnKFaogK6SXrm53Bwg3KDpaI4lkIH4otuA?=
 =?us-ascii?Q?+hRUH8KYO9aDlCsfsSi8gL3OXLukRDlioerXt/WA2WFChrJYBSr3dkxka9uU?=
 =?us-ascii?Q?n9NNUVywQRlh5FYvRAi63tIxaJ9+XRs0b4q+B3ygKqRePY20uJTnWyDI3K0R?=
 =?us-ascii?Q?h5lxfGWqCnolRX6r4Pqmg1kpbL2garCcXd30WbaOQNvGla4re8vxBY0sf0Cg?=
 =?us-ascii?Q?vaVHBeAQyYVW7exVDsQA7wtpJojEj2VxmRrgxiBnZL6rJGqPaF2vHX8Zn+zc?=
 =?us-ascii?Q?hHSALZDUAQ1R027ozm2gbxT45Nos2RA9fCq5t5MMe9uQoucw3brE6clqyK2F?=
 =?us-ascii?Q?B9Lry/HTJqBMrdjm2yEKCcwO6tr8HsvtC3IkGkyl8spk0yaRoZG+fq1ZiOll?=
 =?us-ascii?Q?Af+OfBmffgEH2d/p5Zee3iUUAQvRuVhvew9qKNCQpLQC/5mmIJvcNJhCBJ90?=
 =?us-ascii?Q?5TxJ6xbIMCimAtRDjxwGpC2uN8YHTYoH6LvzVwxzgR+Any5HNG9MBb2w5E33?=
 =?us-ascii?Q?b7eNCffMEFWW5OQgWV43ImQgnx0cGDwBPTMFLMybvR3aIci+z4iOpgx5xyTL?=
 =?us-ascii?Q?wMmYSXKkX3LjXst+cgkmL6fcgPV7s2TOL01H+9ew4gQNn4cVPpuI46AN2j17?=
 =?us-ascii?Q?o1M1BbQTOcU/yJtZUn5hZCsIs/nsRXY3deCcG8/wzwbAPM7C4pe9sE/u9fQI?=
 =?us-ascii?Q?/3MxwhdpW5EjEMVqY8AhS28ibFXU4ABsNESHJMUNsevL4IJV5CdQ5fJUY+Vz?=
 =?us-ascii?Q?QNq+bmQ40hkrV/DDEToZpAgR9OfSYtyVfZAfjw5ePxrH0UZZC7OVPEpTRirF?=
 =?us-ascii?Q?ojwK4fXirZ1Ebh80lwGIWdnXVARdWqlCDwS1FDzJq5yMakNGD8yxBvbZOv5F?=
 =?us-ascii?Q?ErGXGv4/1uFm2Gu3cZa0e7DqyL73JMS4xtnFbyZ3qNbuKITUM6hioDG8Rzxf?=
 =?us-ascii?Q?A4q9SpiKIKeSrL49bkc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB5220.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c465b39-2242-4f05-8bd0-08db8f3bf30c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 07:26:24.6373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xem/7vDgjw2P29HM2zw6b9aEiBGLbkAQmSaw3JiD9UZDBgcCHkYccXV5UbgDWguKQwh1f5wQpSimS57QGbd5Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5178
X-Proofpoint-GUID: HQ0CsRVInTwNRVSDfnAeODGaLwR5SEZs
X-Proofpoint-ORIG-GUID: 2aHNL1tIOmWE8AemNSQMQyHC_IFtys6_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Saurav Kashyap <skashyap@marvell.com> for full series.

> -----Original Message-----
> From: Oleksandr Natalenko <oleksandr@redhat.com>
> Sent: Friday, July 28, 2023 12:28 PM
> To: linux-kernel@vger.kernel.org
> Cc: linux-scsi@vger.kernel.org; Saurav Kashyap <skashyap@marvell.com>;
> Johannes Thumshirn <Johannes.Thumshirn@wdc.com>; GR-QLogic-Storage-
> Upstream <GR-QLogic-Storage-Upstream@marvell.com>; James E.J. Bottomley
> <jejb@linux.ibm.com>; Martin K. Petersen <martin.petersen@oracle.com>;
> Jozef Bacik <jobacik@redhat.com>; Laurence Oberman
> <loberman@redhat.com>; Rob Evers <revers@redhat.com>
> Subject: [EXT] [PATCH 0/3] scsi: qedf: sanitise uaccess
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> qedf driver, debugfs part of it specifically, touches __user pointers
> directly for printing out info to userspace via sprintf(), which may
> cause crash like this:
>=20
> BUG: unable to handle kernel paging request at 00007ffd1d6b43a0
> IP: [<ffffffffaa7a882a>] string.isra.7+0x6a/0xf0
> Oops: 0003 [#1] SMP
> Call Trace:
>  [<ffffffffaa7a9f31>] vsnprintf+0x201/0x6a0
>  [<ffffffffaa7aa556>] sprintf+0x56/0x80
>  [<ffffffffc04227ed>] qedf_dbg_stop_io_on_error_cmd_read+0x6d/0x90
> [qedf]
>  [<ffffffffaa65bb2f>] vfs_read+0x9f/0x170
>  [<ffffffffaa65cb82>] SyS_pread64+0x92/0xc0
>=20
> Avoid this by preparing the info in a kernel buffer first, either
> allocated on stack for small printouts, or via vmalloc() for big ones,
> and then copying it to the userspace properly.
>=20
> Previous submission is an RFC: [1]. There are no code changes since
> then. The RFC prefix is dropped. The Tested-by tag from Laurence is
> added.
>=20
> There's similar submission from Saurav [2], but we agreed I could nack
> it and proceed with my one.
>=20
> [1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__lore.kernel.org_linux-2Dscsi_20230724120241.40495-2D1-2Doleksandr-
> 40redhat.com_&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DZHZbmY_LbM3
> DUZK_BDO1OITP3ot_Vkb_5w-
> gas5TBMQ&m=3DI6CdYJNbvw1q9OWTYmMTCWzCcXFG7MelqlMZ_DmhEMDeW
> ViVj2b3_EadDZUUdzNT&s=3DjoHzWsadjq2HUMSxGvJZMkLQULriRotQk2RYPgDW
> pWc&e=3D
> [2] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__lore.kernel.org_linux-2Dscsi_20230726101236.11922-2D1-2Dskashyap-
> 40marvell.com_&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DZHZbmY_LbM
> 3DUZK_BDO1OITP3ot_Vkb_5w-
> gas5TBMQ&m=3DI6CdYJNbvw1q9OWTYmMTCWzCcXFG7MelqlMZ_DmhEMDeW
> ViVj2b3_EadDZUUdzNT&s=3Dq2LVoTVsEfj1rCnih48VaDUxOCOobRLhIaTatga1qm
> Q&e=3D
>=20
> Oleksandr Natalenko (3):
>   scsi: qedf: do not touch __user pointer in
>     qedf_dbg_stop_io_on_error_cmd_read() directly
>   scsi: qedf: do not touch __user pointer in qedf_dbg_debug_cmd_read()
>     directly
>   scsi: qedf: do not touch __user pointer in qedf_dbg_fp_int_cmd_read()
>     directly
>=20
>  drivers/scsi/qedf/qedf_dbg.h     |  2 ++
>  drivers/scsi/qedf/qedf_debugfs.c | 35 +++++++++++++++++++-------------
>  2 files changed, 23 insertions(+), 14 deletions(-)
>=20
> --
> 2.41.0

