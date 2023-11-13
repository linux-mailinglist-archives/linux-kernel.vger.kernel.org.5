Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5E67E944D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 02:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjKMBzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 20:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjKMBzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 20:55:12 -0500
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B06172B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 17:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1699840508; x=1731376508;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KWYCQRY92yfPKyAfgs4XMdkIU43E5vAPy7iDq3f8fWQ=;
  b=NS82PHdwXFpR3dIuRptxfybB1ZSFTuZpgv5KFZm/OZ4+wmiPaot9bD14
   7jonkeMnd3G0F67OCH9qXWXz8NO8dpNT1tfIjoRax3N9GJoca5J/FsPvn
   AENr4we/NhUxj9TLY4aA02cabvhDMUDOYELMU7vxjIz9IlHTyoPyLMoVr
   wCelNXstvxg4XvSwMbRwFW3PToaRwyJmdQX7Akf/AWPq8Z+RZ7rKMFJrT
   rLt0hXkkkHTMh614xygJzXq2pAFyYaI+5z9lYz+l6NBv3OMmqKfgZcOJS
   mB4/dd7jQxsNMv6/mXMQytmkOaeZ2cV4BeoZQ5Fxmet0Sxn3ekNKCvV55
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="13182932"
X-IronPort-AV: E=Sophos;i="6.03,298,1694703600"; 
   d="scan'208";a="13182932"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 10:55:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7l/yjzxFIndX3cf4uKxVNcshHzTQlYAGVLsxTmveoDA7uIecX2eZM8x0hGgBpN+YoeH6YS8BeMpQ/vGBcEPKsyV6Yxy3NfiIIy/7Tgn0lZYLg8fqJdB/GKmODErTg9RIS8Q0+8oUR5WAt05ulT0SucRt7wzy2hXE7zWwCdje360OgOKxWQfpEFaotNmqnDNb9xxTrlnzGQyAscWDmFDRQDGfqxqYEdnON3Rw1EEz8ouMc54qC4QPyAtw6LpDYWAXvyhXT4l5h5hUDZiXC8LzgmHPEQso1DRUIgklm+sdFqX+eYaFjYLCb+ghIOSfAyeMthc4o7+s563OiOu6ms20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWYCQRY92yfPKyAfgs4XMdkIU43E5vAPy7iDq3f8fWQ=;
 b=VQGv9KL8nT54v4hZ36a0ou122V1nyx0EEs14Nozn3xJdgU94EaqED9huDgQC/NfF00mu3k61PKkS1sxv3JJG6jV3cYIFoeIKOEzPEqWL8xa+gvsgkyo3TTeYuknJdnquIllyZVPtIa29lr1hKnxNZlnR7SRIsLyRlq7pcI8uRK9Hl42MJIfJavfY3x2pRvWZJWWo9d8icPqeX31NlmFfR4MP9hJD1jDi3OYr7EgmtgDr3/rIv0RNj7oUdHbzzDPHzkMzg6umXM9DM2NQjv2vKhOrYjOlOZsx8ZcGnECduQfi3CVZl3w8roYKM3G1iBPoEo3RarNLz9D5R57pLQZZ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OSZPR01MB8035.jpnprd01.prod.outlook.com (2603:1096:604:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Mon, 13 Nov
 2023 01:54:58 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::50b4:e09e:4f2c:a5e3]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::50b4:e09e:4f2c:a5e3%5]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 01:54:57 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'James Morse' <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "dfustini@baylibre.com" <dfustini@baylibre.com>,
        "amitsinght@marvell.com" <amitsinght@marvell.com>
Subject: RE: [PATCH v7 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Thread-Topic: [PATCH v7 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Thread-Index: AQHaB22l/vwrBBXjekG2/2VkQVQVXLB3mMQQ
Date:   Mon, 13 Nov 2023 01:54:57 +0000
Message-ID: <TYAPR01MB633011C4F451FA26949395DA8BB3A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20231025180345.28061-1-james.morse@arm.com>
In-Reply-To: <20231025180345.28061-1-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ZTI3Y2E4MTgtMTkyYS00NDljLThkNWMtMzk4M2QyZWU3?=
 =?utf-8?B?MDc3O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjMtMTEtMTNUMDE6NTA6NDJaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 843fe00bff7a4021b20345581d6feea3
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|OSZPR01MB8035:EE_
x-ms-office365-filtering-correlation-id: 4ed79a53-906c-4c96-9869-08dbe3eb89fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2oCJSm1lh5zOK9J1/0wQpROGgKGXbX2CCbkUamSg3siDZ1Nm+PR35eiWqLHdWLO9ZREGoBbP2c2REOYhFh8tIEq+mMF5EFYtbG7UBESuk4RrKLdlJSvfXWzIrwKC4y55j3LNcBBidV9fbYmr8ilHTpfk6JkAVe3+KK1c6xsD6O0WowPA7hHoF7Odsi/FVgzRS7npymv8qid829VwE0NRhqlXTe+iYG9y9CIqgMD8pJAYKh4FKV4VcKXruO4ZOD0cZdjwP1nFVM7YYJVtrPr3tEhko3Aaux4AIJ3T3bigv1/1A46rr9bp3pfgmrsHymIhVTl8ATpXAMa0Dkpv3YCWJmxdIJxf+/pCtd53QnPUPIjSWiPb0I57cUvfi/fNH35RUJ5sD2gwnojkpZ0yCf8ViKJtmYvqgQKOnfcQQFBgcmj5ViSWnlF4OOfrc0xJKe56vk45VEpuH6QR+iNm0vpX94NdZtlArg3EcCmAX2FatVFpWVPShTjNRN0eUiPSP8zmEvOggosA6lSfxLPL4gyTaiEZC/p2zlT1qUoteCqlw/ImU+LG+6RyimkykRJVpUrt6Dev72BEIdf0xhRer44BySMmcZrUAmrlXiJeLyZMitcgz4ZQVKu1naN2rLhyivYa1baMW+7/wO+3H7J/Ply4MQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(1590799021)(186009)(1580799018)(8676002)(8936002)(4326008)(85182001)(9686003)(7416002)(7696005)(558084003)(6506007)(5660300002)(38070700009)(33656002)(86362001)(2906002)(71200400001)(52536014)(26005)(76116006)(38100700002)(82960400001)(55016003)(66476007)(316002)(478600001)(110136005)(66556008)(66946007)(54906003)(41300700001)(66446008)(64756008)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OCszaVV0R1BJcldtTE1oc2hjUEdBanJHNEtqMVBWMXA1ZEM4aXFNSDM5dzNi?=
 =?utf-8?B?clBkNE1vZmpGOXFnYXdKQ0tuNFBtKzEzTlc4bGN5Zmd6TEhUZ2V5Z3h1bWty?=
 =?utf-8?B?eUVMWlhNaFVFVU1NWG9xSFRaS0VOV1JVb0VoVnJYTUhQYVV3eitvajgxcEFl?=
 =?utf-8?B?dlhjWHp0K0RQN21rSXhnUTR1UVpvWTZ4Y2NoallodVpZODl1Z1FTbEltUFFX?=
 =?utf-8?B?MXBieHhFTXNpL3lSc0JDVk0xTDE2YzZvWnR3akRTYk9wdXViczJsVjJ1cVZ6?=
 =?utf-8?B?WmlmUDRiNzl5NitmVzFUUHFVMVZ2amRqdSsyZzBqVGEwUkNVQ3lzTjEyQ1d6?=
 =?utf-8?B?UWM1MmszZXA1RkJ6K1pSUFk2aWlaaE1BUGVxVUU1Q3VhRlF1V1hPZEdkenBI?=
 =?utf-8?B?RVhpRjhleWEyVklmOHVsZ1RjL0h1cnVEVkkzSHY1a0RnMEpaUlFzQ0wvempi?=
 =?utf-8?B?QTFocTBVeFAza1lxUG9vUXpGdENzeWNNT2Z5L0tSQW05Zk1NcUZmSlpOMVZ3?=
 =?utf-8?B?T2xRSmJtYzBiTG1Gd09NelFSVTdHLzVnSVBaV1lVMlVaT29maUxEZGUxRWw1?=
 =?utf-8?B?QmQ0MXJtaStYRCtzQmF0d00xL3o3MDl2ajZKOUd4bk9vanJGSkZ2QU5XdS9l?=
 =?utf-8?B?NEtmemdzU3ZaVGFZUzVteGhzWTM5QmFSNE4vSDEzbHhGVGlEMitRYnlWNUlC?=
 =?utf-8?B?Z3JJUkpvL0tOV0RVRG1sR1prRjBUdzVzdWc5ZzRXYVRGSWVGVEFtNi9OZ3pE?=
 =?utf-8?B?aW5YYUNLa3N6bDd5eE1NSzRESFMzSmo0bHJRR1l5VDlhRlRFcVM3SW5KNzZR?=
 =?utf-8?B?SHV4ODI3U2VCSHErbG9EcWxGL0kzM3lmbXozbEk1dFU1VU9TUEtPSVlwVWtl?=
 =?utf-8?B?K2dkdm0yQmlpU1JFTlg2dGw1eHI1dHdobHFydGJacDRwY0VHeElmKzBSNzhY?=
 =?utf-8?B?MENEc09KV3R4SHF1dUovaUN2MEVMbExpMkhUQ01KdXRSbk9SNmtpTWliVkRR?=
 =?utf-8?B?bDFSdldEQm95WlYyVXZIc3ZmNUxmWDdTUGlsTE1qWXV0Z1lIdzBJbW9uZDdq?=
 =?utf-8?B?Yk93TjE2dHJXNjhaK0QwYkYvbVFKWkNZT1ZFaG4zSmpkLzhqRnkrLzJvZENi?=
 =?utf-8?B?SUIvODdBMHlYRUtWY0hQWTNuM2twZlc4dWlYWnU2SUgzUE1KdC9hTVN3alJI?=
 =?utf-8?B?dUhmWGl0WWpXejFWSnAxLzFxcnJoVDk5UnN6a2g3S3NXUXI3Y3FWL0ZnaVBU?=
 =?utf-8?B?STNrREZJMWYrSnZ2RlA0TjFkbnpkckFqUGpuUXFqMmlqamd3VTgzb3k0ZXRL?=
 =?utf-8?B?SWVpZjh0S0ViOXNBTnZBWFJaWENHc0RnZWhmR2tMR3JiUUZXOFlsWkl1R2ta?=
 =?utf-8?B?WWx5d2JqcDZQT04xMzRrQStENDRQUDlkeGY5cFd2R2VxaWVTcDBSMDgzL0ZK?=
 =?utf-8?B?WmZjd01idE15U0VkWXJLaWF2Y3NWbit3aWVicmpGck5ZZU81aHFvY2xURllv?=
 =?utf-8?B?MHRWMU53bGE4VW9HOTN3U2hTL0NkbzlGSTBjdUJ2M0gxRTdOdWY3ckNHZUxt?=
 =?utf-8?B?T2UyN0hmM2pKTy8wdTJjcWlzQUlyTFoyZGV5VDhsKzYrNWtOdXJtQndKbTdX?=
 =?utf-8?B?OFpmOVhNcm5rbXAyczhKK1pTc2Q4TldXRm80RGNLd3dadHdUSXk3aWZLV21D?=
 =?utf-8?B?OVMvdFlxS2NpZWU5Y0NnUUhEV1l4bmtIMGhaZmx0cjBBSnJuQzQzd3hJc2dH?=
 =?utf-8?B?WExoVHFYUWYrejR6S01yYzJseElYNXh0Qk56SDFmMjR3OGFjN3psbEQ1OTRl?=
 =?utf-8?B?amV1azMrNE1GckhpR25rQlJlMUVHQ1BmUVhGcTdxY3Y1WlYrN1Y3YmtJaVZN?=
 =?utf-8?B?ZGgzbjB6LzVVcGRwWXBUSTlzOG9WWmErZmwxK05zZUhkVUIrWnJlbkNTM0hu?=
 =?utf-8?B?MzRVRWhLTzBzUTAva0tzbzFiSHdaSU5nRzNOUjYvVkFUd1ZIc1lwQktZVTNk?=
 =?utf-8?B?SFNBUG1BNmJ6akxHMlY2YUR4NVhnMXkxaUgvaGo0MjZmU0hjcVJtcVA5eGxR?=
 =?utf-8?B?Z1V5MmVnT3B2b2RpaCt5V3JmNEZCVTR0R3JRYkxRc25VeUtxOC9hSkF0REZa?=
 =?utf-8?B?ZjZFNXFYckpkSXR1MTdhcW1UdjZMandRMHFJNWFLd0U2UGpEbUllQW1NVnJF?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?d2hkUlF4eDdxOFBUeXJOcStMRzZzSW5lZWRsazlQd1g0bmgrSEJNRFVDakxr?=
 =?utf-8?B?M2l0RkdtS0haMWdHRlIzNVQ5Z1JDRkcyYmc5SW9udUJBaUI3WVNlQWt2OWtz?=
 =?utf-8?B?eFVIaVUvTWdqTWJmWjJpV0RGSU1yWGN2S3M0U1NVbFlxb3JiZ0ZudmxrVHdC?=
 =?utf-8?B?NzJqZDd2UG5VVDNHNTUwSm9iNXVhYWlQM21TYXdlbVFSUEVlTnRqQVhGZXRx?=
 =?utf-8?B?a2JWdEw3TUpsZTFLQUVlRzZnQVVaaHZuT0FYU29OcGxEZ0MxL0xGQXNjamVT?=
 =?utf-8?B?MUg3VU1xWDNFazh5NXNKTTN2cmNheHcvOTNZZzlTcGVFSFN4TlVzUFAxdGpL?=
 =?utf-8?B?cEVsai9UeEFKVEZQZjVJUzlKNXJOcVpHeENZeng0ZW5YeEdYVlZtVUZ0RVM0?=
 =?utf-8?B?SmhOd2h3Mm9pWmx4ZzFFMUpZUFByVDdtTWV2b1VaVnA4eE9icnNOSEQrNndh?=
 =?utf-8?B?UmFYcEk3b1EydlF0N3NKMmlVRzJkWXFCK1JQWWtENXcyRGZrL3ZmdkhBRmp2?=
 =?utf-8?B?NkVYQjBuemxGUmNuUFlIaGRHWmlMNFpIYjRPRFFXNjR2SjFjc3RwSDAyNXJV?=
 =?utf-8?B?eVZ1WTVUWEFKNnY4RXNyUy9kR1BLNFBZTlFxNnRwcDQvSzR2YWhaaWM1NEEy?=
 =?utf-8?B?aXhlVmxTYnZicG0zODZWeGlzeTQ4a3pWTUhRTVNVYzFDeldkSnJOM2dSdUV6?=
 =?utf-8?B?aDlYTmdwVjZyaHRxWS9CVjl4bHROZE94WUpobzFSWVJYZzl6K29YZXFSOVBu?=
 =?utf-8?B?RGpLRys5YUhwdFoyQytGYVg3ajYwRUszdWhwNGQyUWxyNnpWek94bG5BUmpM?=
 =?utf-8?B?eUpPMGhiWmRqelNiTHU0WFY2M1F0ZlpuQkFxcW5xS3RSYWJnKzhMdVZ3c3BC?=
 =?utf-8?B?OExOQjBCRGo1Y0dGeXBkdkpIb0F5d2Y3a3hmd21HYUo3c2UyZzFmYlQ5L0dt?=
 =?utf-8?B?bDNqRjF0enRMcjBIc3hjTFgrWno3R1VyaEs5Wkh0ZEFMdEdYL2s4aElVZzJo?=
 =?utf-8?B?UEpXRjhuSkx3ZG5FbjFJN0ozMVl3S2VVWndEdTlpTjBFM0dsY2VvNHh0R3BD?=
 =?utf-8?B?YndCdlFlcXNUbzR2dHRLbGl5WmVyb3BXSkFneHFoZFNGVkJtKzhlZzBTSU5s?=
 =?utf-8?B?d1hpUE5uMzFhVGgzQWFvN0ZMY1o5S2EweFhnUnVZT1dRbHdEdmsyWWhtbjJy?=
 =?utf-8?B?M1YvaWljaFE2N0t6djB0YkVUbGpkVGo3bWZCM09qc0EzS20ra0prMHVCT25m?=
 =?utf-8?B?eDVpSjI2YWgwQWhTeHIzbWVBdVRVSVJibllid2l4MnZpUDllTDh3YS9hcjRn?=
 =?utf-8?B?ZWZwMlBkeHFSczEyMy8xQjFZQjZKNmlXaVc5dXNxVHpLWXcydkN3bkxOeGRQ?=
 =?utf-8?B?d2dveTVQeGZuc2RzWHRpS0dOcjFOZWpmS2RxV2ZNTkUyMERic1FLT1QvRVRZ?=
 =?utf-8?B?VVNYa2pHeUtWNjQ0RFlXSjlNUDVPdlR0Yy9JQXJ0ejZtWlVaTGhUL0pIRkgw?=
 =?utf-8?B?dWsvQzQ5TW1VNEJaN0lTTWNlMHUxUDZudHN4S290Sm1nbTRXdU5hUU1xTE15?=
 =?utf-8?B?MUFFRTV3UWNOTVM5eXpVUCs3cDREa3hhM2cvYURPV3ZoMjFlTEFqQ21nSFd4?=
 =?utf-8?B?cVZhc29uY3YwWjlVdjB2SnFwVXA5QXJZRXYxc3MyRUU4cHNvM2NuRElMRWlE?=
 =?utf-8?Q?H/zE5hkWgBrGgRusn3Ud?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed79a53-906c-4c96-9869-08dbe3eb89fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 01:54:57.4684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7V7SezLGAFWJakUrxo6L9d9KgDoyOStfz9oVH61XH1wYIL9LWbKVtn8JYYQbi7G+iyV4Z+QJ2mjITJbCVnPoaWwtEXMheQy0wJYcLPWCf+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8035
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gSmFtZXMsDQoNCkkgdGVzdGVkIHRoaXMgcGF0Y2ggc2VyaWVzKHBhdGNoIHY3KSBvbiBJ
bnRlbChSKSBYZW9uKFIpIEdvbGQgNjI1NCBDUFUgd2l0aCByZXNjdHJsIHNlbGZ0ZXN0Lg0KSXQg
aXMgbm8gcHJvYmxlbS4gVGhhbmtzLg0KDQpUZXN0ZWQtYnk6IFNoYW9wZW5nIFRhbiA8dGFuLnNo
YW9wZW5nQGZ1aml0c3UuY29tPg0KDQoNCg==
