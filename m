Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3013E76E1F9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjHCHi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjHCHgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:36:38 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Aug 2023 00:35:19 PDT
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA72273A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 00:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1691048119; x=1722584119;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O1ANCJa4DXAHhFl/6baYxh73xmmcUmXI4o5stonAL34=;
  b=Dtvc1ujrtyHYZm48t8x9TAcafWGO5OVABHNwMNH5p6iqO+kc68zU+DTg
   3eYrxpT527r3do40qRiO0xLD0LIW2AbDO+UsqfS+YtAWASWlVhFXJtOOG
   U/Mw8T++9iLYbJNR+i7KA/DDJQ9xo2Cy1na1lJ9hmV5HJ9M1kQo2nw+QH
   aX/XDdZBO18v21g0kNOMvTKEQOJ3/nmrF2o9e+qY6W/NyFpSNR+6BpMVA
   WvQdvnGKQN3TvBlcgu3tVQQsUywcwWL//gK9V7ZIceGeNIhhdWFB8F7OO
   gTRUrYF3tAfQjzeni/kjFixTS/djnpN8OSGxKh4hkEGYU/tYEPPEYu009
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="91305431"
X-IronPort-AV: E=Sophos;i="6.01,251,1684767600"; 
   d="scan'208";a="91305431"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 16:34:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9Qa5WIGiibuZn9PF6RMLqjaa/mgvXtR8MQiEyDdNYVTIFSmFWOox8N65fscDCU0P9FfUp976QbEcPKxSvVi804+CSZDCKzVjK6u7bNo98rreNZLKyqJ2wf0DzJLALULSAHPA0SdWExO60C+otNRnzdua7o2Hx3QlJxWnax03YQ+nie1z44PQPGZ6SHpeEUmXPb8Pmz4elGcc379Ca5dXTf8k2zVETnWiDZCt1DROmvkTJNv9JO9Gxj5uJcONys0CLHBhfPn2Q1HsMHAhlRpkTOsr39gOHywU3kdysKERJvJZAPu2ZnxsVk2QDwjZ7OFwBSBYnmApV39CGo2vnqjfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1ANCJa4DXAHhFl/6baYxh73xmmcUmXI4o5stonAL34=;
 b=CoBoGs/QyEHCfwhNyJbVDo1K/h8Rp5VybuRGvTL/HtA0HFLqdxwDK2GP3Bk4ohZTMs6B+3M2+6rUBb4HovvzMOJjVcdvkPqHd0GMaIxPtjzkF0/Z3m80FyvNOPzpXC7LYLCkkO6nPCnf2q0CbCO1DbiJKJ1s5kxUf4ZeWCu4Pk075E5VAFS8FnK89kiNjno0BRtwomp0Qz0W2jnuIJpQk21710bK/XRbYcHsJErfkzp3uJuWFyjsHwYmLUb761TR9dqPrmydaK+47BHejXXsPskuAtfT1+ECOfEroiNRGQWm6m9NPVZzP7HpHNZjHfV6iDxr+NkOtFJYteccNt27Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYCPR01MB11607.jpnprd01.prod.outlook.com (2603:1096:400:37f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 07:34:06 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::70a6:407f:e7cf:3231]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::70a6:407f:e7cf:3231%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 07:34:05 +0000
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
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "dfustini@baylibre.com" <dfustini@baylibre.com>
Subject: RE: [PATCH v5 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Thread-Topic: [PATCH v5 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Thread-Index: AQHZwXKewxvBEVil2EyCgYWlNMHBiK/YNNGg
Date:   Thu, 3 Aug 2023 07:34:05 +0000
Message-ID: <TYAPR01MB6330C26085C3D04329584D588B08A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230728164254.27562-1-james.morse@arm.com>
In-Reply-To: <20230728164254.27562-1-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ZWZjZWM1MTctMGNmOC00MTg0LWFkYzYtMTQ2MTRhY2Zl?=
 =?utf-8?B?ZDk2O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0wOC0wM1QwNzoyNjo0NVo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: ace225d1f92544558eb9233018acaa8a
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYCPR01MB11607:EE_
x-ms-office365-filtering-correlation-id: a7b49aab-054d-4b26-d2ea-08db93f4046e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LPccEYCiI1+qAWcHIyAb+T0UfcyWrWQQYTThGFvw6tpteiuOwPIZaeaK/y71kAGHmxz0dGLK9hYfxGuZ3xitSzr1qesWEggW2Y8JTVt9Zu8jhcSXRePRKwtCSjB2RPEEk7kB/63WpRVTKHLYCfXp5oUwOf1Ba3Nwcm3RZA2nwO7ThxP2a0hpxCLarBfDiWtJDiKU5GVuyyYUs3njKxvY1yNhlSqRJXHLru/acalNRlJJQnYpeCVQqYiFRYMYo5zqSAeHGIw+L3HXtau3xcG8nU6g65bU1P/8qdec4M2X3ZBT0FlLryHoBd0O8FO0Sv/0E9pRkGJovyFFXFfgqVCG8tYQWDcW/MCLEkoljPz1Fg0w+LeybVHsvyDdpJWNLmMyiHh1fOD7Z5kIirD2iNXouvdFI0rxBQdLJWrLdLbcyA3xv3UouLHltd+PsHTdWmTkLyU+x+L4ixcTDO8QAGI73gGuzor8DulovxA2hQKPXQoE3Pa4eMbNtQ14/UQOezZMJlED7Y91ilvwzQ6fKmDMd54ZzWLfmt9s31EMpEtprpVjBYamjX+hICFTMEvgA4otNaTQtYjwr0z8OKvk1FMb/2p3ima+01FJ0yXGyypK4/ol/Fnvb7IY7cP24kwZhXTkrgYS+Z0szo0olqTMlwaXQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199021)(1590799018)(38070700005)(86362001)(85182001)(558084003)(33656002)(1580799015)(54906003)(478600001)(110136005)(38100700002)(82960400001)(122000001)(55016003)(186003)(26005)(83380400001)(6506007)(41300700001)(8676002)(8936002)(7416002)(9686003)(52536014)(71200400001)(7696005)(316002)(64756008)(66446008)(66476007)(66556008)(5660300002)(4326008)(76116006)(2906002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3BObllybkF6bHhxMG1ZWUFscmZYdTIxaFh5cEdFQkNIVlJ4QTFvQllLcVBV?=
 =?utf-8?B?MDZVRDZKT2VWUjRiR0lycVNJM0dSakE1SU9OTlNqWEpydktJZkVKTHhkSWFW?=
 =?utf-8?B?ZER2TG1PZmdTZmdPcEdUVVN3S0JjeGthMGRWYjBKYWs4RUZwdVZtcFhGY21F?=
 =?utf-8?B?S0phTTJ2eUdvNnJKZWFmc0tnUDFHakg1VGNCQW45eFd1QTNvUVIxY2xCeGw1?=
 =?utf-8?B?ZEV0ZHp6TjJIN01mU3kxTnpLajZzUXJHRTJSd2JoTmc3ZHVjNG50M1I3VWlt?=
 =?utf-8?B?SllqeUxMYVZRYi9ZalJRV3dWTVgvcjcrUEJ3TVBLOFJNODErTVAzVjJrL3d4?=
 =?utf-8?B?QytkS2I5TGwvcnNrclZSUVQrWWRtMkF1ZXcxbTFkdmpidXBNRTRkdm5GSTN2?=
 =?utf-8?B?UU1FOGljN1lSTTh4bkFKVU9uRU9YM2g4cGdpbWhjVjRqZTNua2orYjl0MWVx?=
 =?utf-8?B?aS9xWEtNeFcyUHBTNDNKeHdyUU9LcmFFMXlaNUlsTzBtbzRWMmcxMTA4dXJG?=
 =?utf-8?B?V1N0cFFUdGlmWjdubC9VQU1JaDgveGcvbDFxc1E4OGowclg3cWtDOG9Kd1dS?=
 =?utf-8?B?VFZkWlBvS0FTNTM0alpJUTRxZENOV0Z1UFFoT2tZd2lqQ21MR25ZVVFhYk5P?=
 =?utf-8?B?d2xiRmh5SjhVUUxXd1hkWXNsTlpqTDBWRSs3SnVMRG90R2U0VEorNkJOS1VC?=
 =?utf-8?B?Q3p2NHk0ZFFvM0xUU2xFUlVIYm1zNkIwTWpadFV5NDd1ZTVodmRKaXVUSDVY?=
 =?utf-8?B?bU5pZloxWGk5c2JqaVhRRTBYYVNlZlQ0RkJJTytER0JORmZhL1o4QzNRUHpO?=
 =?utf-8?B?ckV1amo2cUN4K3BQM1hwVW90Y0oyNk1DSjNtMzdIRGRTK3pSREM2S28vNlN1?=
 =?utf-8?B?b3dmNU9QOUtCbWQ1cjd5MmZoQXltZXlnVUxabGV2NitoYW5JUjR2ODdXS2J0?=
 =?utf-8?B?MzRaM1pTOXQzUjNkc0FqTCs1bU4wWjlRRHdJUTRka1ZuYWRRTVBWY3BML0Vm?=
 =?utf-8?B?OVBWei8vN0NycWFjRGVBTnJmdW5wUTJHdjFxN2FqOHhnaGJJb2ZSWGZMUHVy?=
 =?utf-8?B?Vm8xcHNmOWovaFAwQ3ZEQkJCU25vMkhVNGc2RE9RZVRCVXg0YVB5Y0dsZTFt?=
 =?utf-8?B?cUVXd21OMWQ3bllkbCtwK2Ztcjh5Z1I3blVSbDB5QTQwZkNmZUsyWGdacWNt?=
 =?utf-8?B?Wm5tNHMrekU4bGxrd3ZCUElnK041WDZGelZZdXJiT0J3NU4wUm1jVVYyZ1VY?=
 =?utf-8?B?K3V1VWE0Nko3NzJCUjZRWkdUNHg3Q3RUKzFvZTFESnVQVVdMK095TUt0aStH?=
 =?utf-8?B?SVlMVDBvck01TW5ZSEF4a0hZdGJ1b3p1SkhzTGVzOHlOM21keWF5aTE0aHhE?=
 =?utf-8?B?RTBnRE9LNjJPbU1maEMyOXVJbUdyMXh5YWZlc0ZXdVVzbkZwY0dWYmdUMnpZ?=
 =?utf-8?B?c3c1WHFiQkRybUR0K2IzaTJQNllJM3pqZ1dKSzRWQnJaRzg3TUtiQnBsQXFH?=
 =?utf-8?B?NG5CYWtuaXJEazI3aCt6NDB3Q2NSYUZNeVpCV2tkTEh0eEFoeEdocXQyd2Z1?=
 =?utf-8?B?eENyS3h1Umh6MTZ5eElaRlgzbURsb0xDTlM1Q25DcnpyM3VLREVic0E3a1Vy?=
 =?utf-8?B?bWtvT0MrWXBmVitJRnEySHNpMkIzdFM2eEh4aUZGL0U2SS9HaU1uS0N2NjRu?=
 =?utf-8?B?dVZwZ2psWVgzWHlyWWNXOVpVeVFzcjNhdEhBZ0c4T1dUcW5zVkxBTEhFNDk1?=
 =?utf-8?B?cTZ1ajllbFp2b2NNVERoRVR0U0laR3VOK2FmUTlXdG84SUpVbmNSNXh5Rm9n?=
 =?utf-8?B?eXNadTd3SzNJbEs2L3paaDRSekl6Uk5BN25yOUd0cmJyaEVBNS9VakRpWmFR?=
 =?utf-8?B?SW85SWpzQ0E5TC83WE1IdjJBeVhHMnlDQVBYRDl3ZWVnbVlYWkVBZ2F6TnpU?=
 =?utf-8?B?MC9TZ2YwWWZONURZa2UyTExOUXlBQVJ6cE96b1pEZWsxWmVXZitUTDZIODZ4?=
 =?utf-8?B?RW5RY2FuN1F3cG8rcmhFZFc1RzFjUjhuZVA3QW5MZytBMzFEZmo4ekppYzBq?=
 =?utf-8?B?anplTjFOMGtsNk5WMU9UUFAvRGlGb3JPemxUdW5VT1ZNSWVkV1dGRzJ5R0tz?=
 =?utf-8?B?RDd2Z3JlWUltb1ZLLzA1d0tEK3huZWNZbWhRdlpmTm5TOG0rZ1piYmVxU20v?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MXh0a1hGdUNraWdURCtjb1diaGdCR1FmNjN5NXRFb3pFckRhZVB0dlZSVjFo?=
 =?utf-8?B?RHpUN3hBUTNuR3hpQk55eXZudFA2blJ1YnZHNWRYV3VhL0pxejBKN3RzRkZH?=
 =?utf-8?B?UnY5M1ljZ1l2bVRSYkNZbVE3QXRaMXV3UUxhOWlOcmF1SUlIZ3JsMFRrOXVr?=
 =?utf-8?B?UjlyWW9tbFlXQzNtQXcwQXpsbkY1eE4wVjl6QWhheTRkNmVTV2xPWG0vbnhM?=
 =?utf-8?B?NU43akV1SU92dS9pQXlvcGZPMHJhV09mNEVZaUxZZFp3eGRKMHhVRGRzUVRR?=
 =?utf-8?B?eUpvdEZ0MWV5TWtheVp0ZVB3Uis1bXBTaFZsZ1p0YStaTU1vMm8wUmpYMlE4?=
 =?utf-8?B?eEUzdDdYeFloZ29yMm9XQ0g4YUpGYklxdUxJOWVwc2ZMcWNIU1pqYjZpRFdz?=
 =?utf-8?B?ZlpOTGRhaC9XZ0l0OUlPOTZhV0ZrdzJvWEpFVi9ZaHc4UU1iMVdnRnkvZ1FE?=
 =?utf-8?B?Z0tyU0dJdkQ3YjRVMzltNGswVFpFL1FQci8yYW9pZWluUGdCQzBmK1RmeU5V?=
 =?utf-8?B?ZFdQN3pLdmRiWnVzVmM4aTN2alE5WGYyZWRINUhrOVRBVW91NjRtdFNGYzZR?=
 =?utf-8?B?TVhFYlZ3dXV0THJ1Z2F5T3VDbm94dUIxVTNqUmxpTStFa2p2WFRpWXZ3Wi9w?=
 =?utf-8?B?MndCMG1nT3I5VE12UDFnQlBqYThEd0NCcDhNR1AzbGl5L2pWNGZHOHdIS2RD?=
 =?utf-8?B?empFcWp5eVJDREZ2MkpsazRQei9vbm9rN2M0Ymx0enJvRnN1RmZVVUF3eDht?=
 =?utf-8?B?dmZNck5UdkRjaDNMd2xqVWkycithRTFCSDVHWTNYbVUyK1oyZk53WEJRd0pm?=
 =?utf-8?B?enlzTmFjVDNOekFhUUp5cHRLWXBPMnhUZlNOWWlUQm1BRWJBVmJDbjUva1Y1?=
 =?utf-8?B?d1ZuQWxiTzRQU1pWYk9YQS9aRDZqVHUzaGo1V2hRV3FBOVhFSW52M2JWQzV3?=
 =?utf-8?B?eW14dm1PbmhHUk0wRFNDbENxb1F6Rkt2VmxqOVFFWG5zaytKR3RDK3dXU0Vw?=
 =?utf-8?B?aXZkS1NwK3ZEc2NLYkF3TVRwYVpJM2FycEJOV1BCUmY4UkVpYnN0aVY4c0lR?=
 =?utf-8?B?R0tKSlVuQTBQclNjZ2pGNGZVL2xMUlBlSEt5QzVTTFY3dEE5Y2ZIa3c4RnNI?=
 =?utf-8?B?clpUQVNpMUxjcWx2bFp6MnVjTnd5SWtRY1gzOVdRZE1oczFERGdUMUgwNmtW?=
 =?utf-8?B?MTI0Sk1heHZnZHExT2NJNW1jTzBSSUVLWFZLcm5BR1h0MlFNa1JxQXg4UGNF?=
 =?utf-8?B?RGRqQ0wwOHhDN0l3NlNGeTBDdXM3Ni9xd2c4U3RJTkVKb2FkNzhJMlI0UFd2?=
 =?utf-8?B?VGZLUm5KZkFCNlZVQ0kzWTQ0eWVjdE13Z2RoNUFPTlZEbk4vZWF4SmlnVjNn?=
 =?utf-8?B?V3UvTzU5M29iMFFqeGZ1QVRGOE5kYTNFamNGY0swVi9WTUd3WDZkVFk2QkV6?=
 =?utf-8?B?QkFQVkV6aTdqUHlkb2lIbDFJbmM1eXl4MlY3M3loeGN2Mk9oWDVnQ1kzUzNi?=
 =?utf-8?B?Y0c4L25lL1NyUHU0NWVKVVd1ZzU4cExOSWROd3MwMXdLSGdESFk5RG0ra2Zm?=
 =?utf-8?B?UGsrU3BzYW4yMDBxOEROOFZBUmRDYjBWSzJCMnpmR0Fkcjh1R0xsVGU2VHYr?=
 =?utf-8?B?VkJPVkZJdzF6QW56NHN1SUtPc1R4NkwrYWhNc0R3emlqTld3aDhNOENqUEJY?=
 =?utf-8?B?MlplK1hqb2I0NHNOMFFINnMxWlJFOXZGRHRNZ0cybThiaC9YdmN2V0dZSlZF?=
 =?utf-8?Q?VKR6/9+k2ghy1mEipg=3D?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b49aab-054d-4b26-d2ea-08db93f4046e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 07:34:05.8711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FiKGnzMFdUto/X1pDyq1vAEfMJpIgCosvsvsMuiSk5oIaRs+6lX1K1yqjm/uoF8q+ImviAT8ZTr/Y6tjLrN+3q9nz94qpQ1bmDBHN3ior7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11607
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gSmFtZXMsDQoNCkkgcmV2aWV3ZWQgdGhpcyBwYXRjaCBzZXJpZXModjUpIGFuZCBpdCBs
b29rcyBmaW5lLg0KSSByYW4gcmVzY3RybCBzZWxmdGVzdCBvbiBJbnRlbChSKSBYZW9uKFIpIEdv
bGQgNjI1NCBDUFUgd2l0aCBub2h6X2Z1bGwgZW5hYmxlZC9kaXNhYmxlZCwgYW5kIHRoZXJlIGlz
IG5vIHByb2JsZW0uDQoNCjxyZXZpZXdlZC1ieTp0YW4uc2hhb3BlbmdAanAuZnVqaXRzdS5jb20+
DQo8dGVzdGVkLWJ5OnRhbi5zaGFvcGVuZ0BqcC5mdWppdHN1LmNvbT4NCg0K
