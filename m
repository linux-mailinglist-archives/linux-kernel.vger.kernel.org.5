Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8565A7D46FC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 07:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjJXFmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 01:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjJXFmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 01:42:00 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E2710D;
        Mon, 23 Oct 2023 22:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1698126118; x=1729662118;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ihn3skJkseV3IKYHa7PAJQ1dP2/lVNUAWR2Bf9N7N8Y=;
  b=gL68bUi68HSUyoFrbSmr3VqHqVUXLzb0MQBBcJMCu7XjKz2Usz/tOhoY
   vsdIUyXRyYdIGjo3JjfoHkgIyy+0F2E1D2Z4U4nO5WeJGiVVowu8F9Iq3
   pI3JYsdnvyVZK3J66vsrrX6j7K8WRdnHf/tmnaZTQ7wck+E7nDQvye9F7
   4Jwt3FeSUzNgnL+7uI8mXb8mTB2eYSQT7gm4fZNdKAz7qnLu4SeT5Rc1Q
   gMoo2rTiNaTOcM4tuJxV86zfz4LarcoJ1Fg53mVxw+ZmX22dIYL6qNA/h
   Q8kzjrkbtk7mDcBvf+wBfSPfX5LnXADzz0n8CzLCuSBeeVR8hXmoD1HT8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="13318188"
X-IronPort-AV: E=Sophos;i="6.03,246,1694703600"; 
   d="scan'208";a="13318188"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 14:41:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/PMjBP2vy+seZKTgC8p340JtgAuCGFlljzyl1k3hEZWwDk20tmQ889yR4FiPemIxa6H+047Xd1PsZsguWEIm2PdVUZSyeTP+TXMPwgjzlbRfCa6ak2PZVa9YWulw4xDe4U6WSaktKqoZaWaneWJOCmY8n6gKFz4gnd12dCuGa6iBb8KVIzD3KLQe1EZKx7rp3RqRwDdPZVRV2tMonT2l1aU7IO5eDfXKkEF3vwdDRIB4eYVKdR8lR5mBn4MU1daoL0nosgp+ttnaTzvpBguWr1DNdwI5j/YP3p/sq1ttXSDubHnlxoE6KCEyWIjqlNPfpc7ememmJvfabpfAO8CyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ihn3skJkseV3IKYHa7PAJQ1dP2/lVNUAWR2Bf9N7N8Y=;
 b=EORfzXHjYCx1tm0gKj3gGy1G8gACRdHOOhZVCbHysIRlYz61nVs39nzIjLiuuklCLtoDju0BEtbhjy4sBBjbmCCRcPAWAGYUcYVqFdgXeXhCuxVS4rQ+yAp4u1R/nhdaq8yTSDon/l28on8cEfxv98dMOuOpLg871CbF1NBvcMJFIjCZfkhAQcequCT5Z/C7Wm0Or4FbMmbx+pb3pCOZ9tK0YkLv+X4coYbmPOQNf50jB1oeA+RWI2RVshlEXKQXCCsouNRGjiHGIQlQhoMimvVAwsPXzZx5UI/BwycAQad0XlJbgsav2rZTLhsSUXo2g0CradiGR+q3bhw6Miy+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TY3PR01MB10598.jpnprd01.prod.outlook.com (2603:1096:400:313::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 05:41:49 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::4d18:59a0:6c05:cbf1]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::4d18:59a0:6c05:cbf1%3]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 05:41:48 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'Tony Luck' <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v9 0/8] Add support for Sub-NUMA cluster (SNC) systems
Thread-Topic: [PATCH v9 0/8] Add support for Sub-NUMA cluster (SNC) systems
Thread-Index: AQHaA5zS6r3gquenxEioSKDyVl26HLBYbf5A
Date:   Tue, 24 Oct 2023 05:41:48 +0000
Message-ID: <TYAPR01MB6330C183EEC67D29FB448E108BDFA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20231003213043.13565-1-tony.luck@intel.com>
 <20231020213100.123598-1-tony.luck@intel.com>
In-Reply-To: <20231020213100.123598-1-tony.luck@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9ZGRlNDYzOGYtMTkwYS00ZmM3LTg5YTQtYjZh?=
 =?iso-2022-jp?B?YjUwMTVmZTQ2O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjMtMTAtMjRUMDU6MjY6MTVaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 204c84f8542c4cc48efebc10864bb99c
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TY3PR01MB10598:EE_
x-ms-office365-filtering-correlation-id: 5f7a761b-53e5-4bb8-44a0-08dbd453ea67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Yound++iBoRJMEG9G9zg9vlzXSw69yLUF8AoYG1TLlfz6ScM7XSOODSTHK9ZLk7TqNCN9VLlaiTTObOahLXxljw1P2gD9ht9CtmQt8vCzjXBvwoTbKdkpo6waY9pGw6EA4qbe0eNy15wV5DCRUqeiBEHI+Pp8R1m6WwtXV7Wgu1MvkJCCgXRDzjWD4useKAEcur60MIJahKwoy//85S64T80LfVkKa04JIsZ19s5RlaaGNkM7zY6MSt/1HuJT5IThJO+gdFvBsjVBGqIWcbrIEAeEHqdc7PJDDSArnLa7RuoZ8INPH1SQwB0NOhDYHMu/DH7kbRAp4dF26kWXkUJAGW46tNLe77bXMF6v8MrNenOF2rTG3U0bf0A5GIEEPIb/5BEM/a7+SlquXlI9f8UG1UMEV5S48DYoi8sIELY5Egmtnqenltg5WIhKj8EHKHH/Sqh2EAkTdIv1Ke/B8o0WBZu8BWZ58YjfVfVx37W46g0OOq8bmWY8Gec+BBcKgM7uAoRIs8Hlv/NgooK3aI1YDxNoFdakoUernWvdIf+2CqbHtT9mQd8UJp1XNQcpY/RNpwtL0pdBNVmq7s5P2t8XrTcDazClIEdk+yMFqscqUUid9n3oEsiwfiLH0qzDT2idMoZ6/4Kr4Qe5E4tcGV2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(1590799021)(82960400001)(26005)(122000001)(38070700009)(38100700002)(83380400001)(55016003)(1580799018)(41300700001)(8676002)(52536014)(7416002)(66556008)(66476007)(66446008)(64756008)(110136005)(66946007)(76116006)(8936002)(54906003)(2906002)(86362001)(4744005)(316002)(33656002)(4326008)(71200400001)(478600001)(7696005)(6506007)(5660300002)(9686003)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?YnRwWDlVZ1FRWExCejdvVmNINHFON0MzRWJhU3hqUEdqaGVtVWlYMHBl?=
 =?iso-2022-jp?B?dGZldzVveHRsVkVGaXBaUE1XQTRQbjdEM0pMMmRSWWdKTVFQVEw5VTVr?=
 =?iso-2022-jp?B?RGN5RnMwRWpKVjB1Z1RLb0ROM3V1QUtmc3MxSXV6ZVgxU1NaaGtHYnJt?=
 =?iso-2022-jp?B?YS9vaTFsdlUwSEZyYXFCWlcwVzBXeUZrTzZXaUZHL0kyNk8wQ0NwVWE3?=
 =?iso-2022-jp?B?T1Fka1U4YUt5RDM1amlDSXRSZVJGc1NHWVJsT0w3SVVrdDQwa0N1bVRU?=
 =?iso-2022-jp?B?QjhFUTlOQVl5a013SG9sZHFlRGtUOEhZbWJrL1FtWHNNUnZYR1d4QktY?=
 =?iso-2022-jp?B?cDU3VjBoTTZkWGU4ZDl1eHphR1Q1UVlqNXZVRVd4akVTZ1RlSmh2c0dz?=
 =?iso-2022-jp?B?YmdaaENocXVWSTd1SHBLWEhKbGI0Q0FmblRHTEp5RHpuUVpNVFEyMDkr?=
 =?iso-2022-jp?B?RUFGRmJCY1BKcGgxRDY2U2I3bkRZNFNPWE9pMnhkNnFxL0tvVmVmazF1?=
 =?iso-2022-jp?B?aEcrbFRWeXhnYklGSUdvczlUTlUwQ1drSWNtMDQ0Y21qUjBTaDJ4c0dn?=
 =?iso-2022-jp?B?NUsxVlp6Ym9hVG5ibDVwZTBOOVdDZDdpTEJCanFLamExSXE2eVVZeWRJ?=
 =?iso-2022-jp?B?RWJWWEJvR1pnSFBoOEw3NXFlM0w2WFBqMjBHa0FieEs1Y2RWd0tqUFpV?=
 =?iso-2022-jp?B?YThiSFRKK2loYnpENWJxZ1BPNE90UXE1cWZLWGowc3RXc2t1K1RELy9V?=
 =?iso-2022-jp?B?VW5XSzcyWXRQOFRxdWE4eHRZSUdnMVlDaW5FMGxlcG5naVFTR2wzbURE?=
 =?iso-2022-jp?B?TGJ0L3NEZDlrNU52WlltUDlnamtTRExLRHUwVFN5cjlTNXhaRm84RFJn?=
 =?iso-2022-jp?B?SU1pK2ZpREc5WVdOM3JPcks0VVFwbU1kOGVhcVlsdmwxWERTWDhvbWI3?=
 =?iso-2022-jp?B?d2dubytEWURaTm9tMThLbUVmaW9yRTlCSHY5OW1HZVNIQXhFbVl3YWln?=
 =?iso-2022-jp?B?U0lHNDQ5cDJ0T0hLeExXTnZDMEtid2NBTy8yZWpEQ1U1T0FENVgyWDVG?=
 =?iso-2022-jp?B?ejYybGIyQVd6WS9VNzdEVXdIOG5SQmtnRTFXMlIvRnZtV29ub092OHZT?=
 =?iso-2022-jp?B?ZUJVUHZEQUt4dW55NFF4UXFPSlFSd1pGVUZtZGorb3Nhd1pwdklvVGI2?=
 =?iso-2022-jp?B?RmFMbStYZEtaeXFDeEJ2UzVYeHUzOXg5YnhHYlh3OXNHTjQxaDR4dkZr?=
 =?iso-2022-jp?B?MjVvSUlhZTd2RXp1bWNzWEptMGNuNFZXUmx3MzBoMDEvVnQ1VVloZllo?=
 =?iso-2022-jp?B?Yk5KdTNCeDVERGtaUGpueitrRytlOUhUOVlPblQweWdkVC9VZnR6aWpE?=
 =?iso-2022-jp?B?bTNndVdHbngyMk8xZlJWZ3JXYis2dWYrRSswKzdudjZaSzlRSURBbXRK?=
 =?iso-2022-jp?B?Sit5a1lPZDdPN0liTUQwUDUrQXhublVwNmdFTllOeko1cEdWNjhUMVNZ?=
 =?iso-2022-jp?B?QmNUTDdKMlI2SjV4QWlMQjE0Zi83Z2JOYjhIMzA5VjQrT2R1TFRKOFBl?=
 =?iso-2022-jp?B?NTlwSnJnMG5Rcy9RL0ZDVCsvbnltb0U0d29nbTg2dzA1QW9yMnZIQ2lQ?=
 =?iso-2022-jp?B?N3J1MW9xOXBoc2ZKUFlmbHZvaGd3WVl4aGM5WWFrVVljMEhnSG9SaUZE?=
 =?iso-2022-jp?B?U1lzaXp6ZmdaVXFUL1ZjUTNXYVNvWHFZbnpnQTNpTitOOGZ0SnI4emxR?=
 =?iso-2022-jp?B?UWxmNUEyL3U0dFpEUG40aEdLZmZBMXJGNjU3UWxxemtLTWEvbUJiQi9a?=
 =?iso-2022-jp?B?YlA2Zzk3dG1NbzZjSDk3M0IyamxNKytqdk14TTR3SlVVTTNFS0NqNEwz?=
 =?iso-2022-jp?B?LzJIQVFDa2t2dTFYMTBJSy83YldHSWlVdk5hRjZCeEdyTFNOZUJOSzRo?=
 =?iso-2022-jp?B?cHZIdHJlUVNXM2NuNklJRXd1OFIrcERKUm16czgzNXN1RFFYZlJXRW93?=
 =?iso-2022-jp?B?bVVFWmlua1dqdkJrM2VXdWh3cWtJVzE5dVlSbkJjbUxGSXl3TkN3NUkw?=
 =?iso-2022-jp?B?Z3hITlVaQ0UxWndTWmRJdDlLT3JsS1NUeVAva3lmNTlOTmxsYmhkVVRF?=
 =?iso-2022-jp?B?K05LZUlTQUtlUDRyelQydXZkYVRhazdTSllhRkZ5T3JuTTJHd1VnbHRJ?=
 =?iso-2022-jp?B?OHU1bGQ4eFI2Z1dlVGhlVzNHNTBNb09MR21KTk9KNWhYT0QxSGxQclZG?=
 =?iso-2022-jp?B?emxiVGdYcjVUVzFpekwzRUUrT3N0ZDk0a0loVW9ZY2gxSHVVTWZ6bWJI?=
 =?iso-2022-jp?B?amZyTmdtby95Y2RybFgzUTBkUkhLblBqQ1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?c0RIeWxGS0FpeElyWVhwUElpMXdYakxFTTJiajJxN2ZxaWlCNTB1MHJY?=
 =?iso-2022-jp?B?eW5NVHpBUnNBR2NlZ0ZtS1k3ZWc1NEJ4bUdBSWVKOTV4QWNsb0w4TVpn?=
 =?iso-2022-jp?B?aSs1TGlmYkd2VGlvZStwbFowa3NWcGZQdmlWUjUwRTg0SWFtek5obm9F?=
 =?iso-2022-jp?B?OWsycGNld3o0WEora3Jla3NTMlE3WGllV0xqc3VQdCtrL3ZmYXltT3BT?=
 =?iso-2022-jp?B?dkJPOGJoSWNDWlc2ajF6UkNvZW1neDY0VW5jbnVXa294amw2S3NsSWVh?=
 =?iso-2022-jp?B?REg1d2NwbHY4RFg5M2o1SGxadU9RUDFtUEtINGlxUERYWjFTdGJCUVpB?=
 =?iso-2022-jp?B?ZkxEcGMvUk1JTmJrbmJqREtIK054NXU1eFBFUmxQT3pUMnFaZlpPOE5P?=
 =?iso-2022-jp?B?dzRYbmdHR2J1VG1oSWhFcE83bUdHZ21vZlRsN3d3YnpUcTBCcndoWDdj?=
 =?iso-2022-jp?B?WmZTM2tXZm93cndmek1vOVQvN3N6VjRVcHkvdWlIS3NoN04zYVh0MmtL?=
 =?iso-2022-jp?B?Y1V6ODN3QmZ0TXRHZ3FhcGdjdWFSMU5VeUI0eXVIZjZGa3FoanZhdDVT?=
 =?iso-2022-jp?B?MmtQQ3JEN0pzMDUwWGM3T3Y5cERESDNFKzB1Z3JLdTlzZXVlS3A0K3Zh?=
 =?iso-2022-jp?B?NCs3L2JvTklPWGVKQjd2TlBLNTVDZ2ZzYUR6cXJnK3lGemx1OFVNaGE2?=
 =?iso-2022-jp?B?NjlWanJPcWtiSUk1dFVES0NMRklUb2xkMFovNStuU2xUM09jT2tHVUZK?=
 =?iso-2022-jp?B?OUQwcUZaZ0hzOWhqSWI0UnJ4amJhMld6emVHZExFM3NhM1dYdDhHMUJr?=
 =?iso-2022-jp?B?K2t4cCttNGpmWXE4TkpFNlZiTk1NbkhqcjNsWThoa3NQdFJBZzlVMjRJ?=
 =?iso-2022-jp?B?WHU0Z3BVTkJUeGxLbFdnVlBwWTExTXY4TkVvTUJuekhXWU9mRURpWDB3?=
 =?iso-2022-jp?B?OW5udHNpSjVxcHYzdHBwbERFMHhtcWpFUFUrL1A0YUNsMmZOMUFuTXhk?=
 =?iso-2022-jp?B?SW85RS9iS1FsbzU2R1VITmhJRnZnaGhzeTFGZFVRQVlkVmpHQk51Rmkr?=
 =?iso-2022-jp?B?ZGtSV1pld2hvYVh6NGlvSm1OblRybXNmV1JwVE5ncW9XRk1kN1FnZjQy?=
 =?iso-2022-jp?B?ZkZyR0FuaytKR2l2MEJ2L1NqWmhkalUzdE9yK1ZEK0UrZUxFR1l0TXBG?=
 =?iso-2022-jp?B?Y0s1bGVjWlZpdFVqMjBNeW5WYjZpZW5LK2JqemswSjN3c0xybGRTeXNF?=
 =?iso-2022-jp?B?RHpxRmxHbGpvQzFORFVGRnVudFY2L2xJSTNjT0EzVWVaTktPYXA1YWpC?=
 =?iso-2022-jp?B?NHhtUWRRWEVuMEUxZE1RbVZZQlVnbmFoMFpxUWQvYnpFMkNUQWRhOWQv?=
 =?iso-2022-jp?B?QVdkby9aVFFYcDR4NkNocFBmSzYyL3E1eVJ0MkJkcUUzN0JiK1c0U1ln?=
 =?iso-2022-jp?B?TXhQd2lUOXk5eFpQdUlYT3lmTkRKWkFEREFtVFYwMHpERUswOU1Bemhy?=
 =?iso-2022-jp?B?eE95U25VdXp0VGE3SHBLaEQwNU9KVjNFdEJSMWV0QjNlZ3M5dnQ1dm4v?=
 =?iso-2022-jp?B?WUIxRkJwNFNmK2xISXErSzZnPT0=?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7a761b-53e5-4bb8-44a0-08dbd453ea67
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 05:41:48.2595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UrMLtu3DdOcdWOCbbDQxfvKFEmEAFCUGaR9jw9VYc0M4xP2Lj0v3VyNsiarIIJ0pvz5BVeBT7TCwYQuiUCWa8SLCB+8AflI0yDry1oHrc6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10598
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi tony,

> base-commit: 3300447612b2adbc05cbb90e5d1cb288f19c40c6

$ git checkout 3300447612b2adbc05cbb90e5d1cb288f19c40c6 -b patch_test
fatal: reference is not a tree: 3300447612b2adbc05cbb90e5d1cb288f19c40c6

Then I tried apply this patch series to kernel v6.5 and v6.6-rc1~7,=20
but it failed with error message "Patch failed at 000x".

Could you tell me what kernel version this patch series is based on?

Best regards,
Shaopeng TAN
