Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C10F78511C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbjHWHGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjHWHGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:06:51 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC44B185;
        Wed, 23 Aug 2023 00:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1692774410; x=1724310410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NLMftlp1lRFuuFcH4LY13u2b2Fc7Rch0EP++GqpL9Xs=;
  b=cqtPAZS0E/Y9wCQcauVTux2H3tHQpC3fGu1PKmQN5HEuIM0I/K9/YEHz
   2GDAmBcwXc2l9Lpu9nKMG0nHT5Te9h7Q0hKt3qrV6y4Rz0E4F1EeyYMvP
   2YrcjtETGfqUP23OPni46qIRYGRII3AihbhOeqmFtZGlTgo7R0px8EKqO
   /oMenX0bT47nfSpZCYxRWrByjFtK8+lft1L0olagm+zU90YINvM2ZlkBm
   27oDyBnsRIGBQospsoTSw2rh0C6hAG/jdUcYdDbBPRgy8l5OE2WoqK1dD
   4BcH68YapV78/pVT2Ij1XHo/FnZZC3rbJC1UHvnbHi+XFaVKE0nV3xokc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="92945018"
X-IronPort-AV: E=Sophos;i="6.01,195,1684767600"; 
   d="scan'208";a="92945018"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 16:06:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkEuS+DuCQdAZCQtpsVGccPFim0pTOPh983WsiBZhdjmTC8DOmOhlap1BWixQUyxs6goKWpuI6LOUNxjWEaMkmhqGK64fO8k1ViItAQJgysqwsctihTknpyMzSQ32cHeCIgJ+sD1EhzlQ5excc2RN0qmFPxWqM3ati6L4ygIm+kQ7GQ/LP5n6pQDL6SyxNl3nVtYtcDDotGNYY2r6vmuzq7UPPrTIHe74Wlc7oCr+9tjNnmfqkKPQQWWSkCq+FtpF1UuJ9x8B+tuvf5OC5SJtfR5hp5WCsQ6Ig3rTuDW+ZGNIFvB+VorZWs0mL+M6nBImZfaK7U+G050pa/Vnxvftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLMftlp1lRFuuFcH4LY13u2b2Fc7Rch0EP++GqpL9Xs=;
 b=XEwK+6lRdZKrlQAstPv6DTcv53oa6W4Q8WKu3a+D205rvyclSe8ZQMmNiUlkciwyXYSfPf/1vFsAo1G1HsBbxmgBcTokVpJ9kwVoas8YPr//MvLPWm7JQ4PDp85rgqmIchn3RkgQ5p0br8d+80GNBfyMYOHsnWd5V7TMbB76XOnhblD5hQzK8t3MDIl6oMkL2bEGLumXkWIWw7Lxh1LoRJLMLU/Hea0yzl9WNk5SBw3sz/kE/Q/HiKj4StHywKuJzOyeILClUQJPyH1uto7tVKIpcLxbmbW6Zqi7v0leZhhkGERkmEB3oJmgnXRrvFHvBx5pri2rWr3CNbo5RLPR1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OS0PR01MB5427.jpnprd01.prod.outlook.com (2603:1096:604:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 07:06:33 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::59bd:366a:131b:3f26]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::59bd:366a:131b:3f26%3]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 07:06:33 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'Babu Moger' <babu.moger@amd.com>,
        "'corbet@lwn.net'" <corbet@lwn.net>,
        "'reinette.chatre@intel.com'" <reinette.chatre@intel.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'bp@alien8.de'" <bp@alien8.de>
CC:     "'fenghua.yu@intel.com'" <fenghua.yu@intel.com>,
        "'dave.hansen@linux.intel.com'" <dave.hansen@linux.intel.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'hpa@zytor.com'" <hpa@zytor.com>,
        "'paulmck@kernel.org'" <paulmck@kernel.org>,
        "'akpm@linux-foundation.org'" <akpm@linux-foundation.org>,
        "'quic_neeraju@quicinc.com'" <quic_neeraju@quicinc.com>,
        "'rdunlap@infradead.org'" <rdunlap@infradead.org>,
        "'damien.lemoal@opensource.wdc.com'" 
        <damien.lemoal@opensource.wdc.com>,
        "'songmuchun@bytedance.com'" <songmuchun@bytedance.com>,
        "'peterz@infradead.org'" <peterz@infradead.org>,
        "'jpoimboe@kernel.org'" <jpoimboe@kernel.org>,
        "'pbonzini@redhat.com'" <pbonzini@redhat.com>,
        "'babu.moger@amd.com'" <babu.moger@amd.com>,
        "'chang.seok.bae@intel.com'" <chang.seok.bae@intel.com>,
        "'pawan.kumar.gupta@linux.intel.com'" 
        <pawan.kumar.gupta@linux.intel.com>,
        "'jmattson@google.com'" <jmattson@google.com>,
        "'daniel.sneddon@linux.intel.com'" <daniel.sneddon@linux.intel.com>,
        "'sandipan.das@amd.com'" <sandipan.das@amd.com>,
        "'tony.luck@intel.com'" <tony.luck@intel.com>,
        "'james.morse@arm.com'" <james.morse@arm.com>,
        "'linux-doc@vger.kernel.org'" <linux-doc@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'bagasdotme@gmail.com'" <bagasdotme@gmail.com>,
        "'eranian@google.com'" <eranian@google.com>,
        "'christophe.leroy@csgroup.eu'" <christophe.leroy@csgroup.eu>,
        "'jarkko@kernel.org'" <jarkko@kernel.org>,
        "'adrian.hunter@intel.com'" <adrian.hunter@intel.com>,
        "'quic_jiles@quicinc.com'" <quic_jiles@quicinc.com>,
        "'peternewman@google.com'" <peternewman@google.com>
Subject: RE: [PATCH v8 0/8] x86/resctrl: Miscellaneous resctrl features
Thread-Topic: [PATCH v8 0/8] x86/resctrl: Miscellaneous resctrl features
Thread-Index: AQHZ1Y5iqs+VoucbdEiDH9fYjMbS9K/3dS0A
Date:   Wed, 23 Aug 2023 07:06:33 +0000
Message-ID: <TYAPR01MB63301926FB80440DB2BA1C058B1CA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230821233048.434531-1-babu.moger@amd.com>
In-Reply-To: <20230821233048.434531-1-babu.moger@amd.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9ZTFjMTJhMGQtYTNmMS00Y2FmLWE4MDMtODc4?=
 =?iso-2022-jp?B?ZjE4NThjOGMwO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjMtMDgtMjNUMDc6MDU6MDZaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 9a523b822d8b40ed99e8394141af7fb6
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|OS0PR01MB5427:EE_
x-ms-office365-filtering-correlation-id: fecb0add-dead-47a1-6000-08dba3a77bf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FN6kHRAEOurUPKuormTUz9AEzHY5gibAjWjQ5Fe9jx05m9l4hAlP4TmyCg7zeDJOcbUpy/049vgJwEKW+Lco9wgdjj2njPuBWwDYPVcfThqz0kGe3HP3XwaCCi+pJX5693kODACZUt7dKShm8wItrgUEScEhxGhvGOwAg6FgLI0sJ85+cLsa8k3Wryar4nSmygSAWAuyf13CRr4I9wg096naJ3zeMFkSFtBF4C1smPCTfQ1XRQeCAn+pPlNaM5sv+G2yt91lUrnpVlZqyl/8l93M/YJnyQITcxdfhn1DcvHDwezjFf9iqwCWi7WgfR2qpvc3xPP2Zxi3v6BcT+yYtcvuzfWlSMZodNBG1Gsw84jaHB2sJ9zDa/sNJBITxJmSho6uzt0Opce+zgNBBstC5Ygp5P7NFE5mXs5/srPVzXyOoQN/7vtTUNnD+w92gHH+uU+JdzFeWYb/27OhWYfGzlO6rAdUzSzFP9izOEwwlYq9Yi/P7FprCxVoDrU4kHOW0jCUjiUra6HFHDb+0QSjqOg74prO7D6nDluNSOhukXP6vBgWO26WwUhn70DsJwmSZh4htvIgemwL6uh3W4109u5HwrPo4b0DSptssncEKhFMqZHXKW1lWIv88wb6cpy/oZ2OMLerXiKpSpdO2/mtjUTG2g1F7Y1TDcvUYNW6VA8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199024)(1590799021)(1800799009)(186009)(478600001)(33656002)(85182001)(86362001)(558084003)(66446008)(66556008)(6506007)(66476007)(7696005)(316002)(71200400001)(64756008)(76116006)(110136005)(54906003)(66946007)(41300700001)(9686003)(82960400001)(38100700002)(8676002)(38070700005)(4326008)(8936002)(52536014)(122000001)(5660300002)(26005)(7406005)(7416002)(55016003)(2906002)(1580799018)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?amZxMmxOeE8xZmZxWVdjd2tZQThiK24xUHlUQmtSL3A0bW5kYnV5ajRC?=
 =?iso-2022-jp?B?a3pXY2ZsRnVjaGNpS0phdThLNWR6WWprL1Q4Y1NMeVBjeU1VZkFZQVc4?=
 =?iso-2022-jp?B?RXEya2E3bE9WU3Vwd2ltcVZpMFgyelNiUW5aclU5QkJhb0ZsNnNvWlY4?=
 =?iso-2022-jp?B?U2ZFdEp3em5HM0RTOVVkZ0hTL1ZaT0dtcUNkR0hqUFo0VGFPSzhHRjR4?=
 =?iso-2022-jp?B?V0xCYjRCR3kzbDVpa3M0Qm54c3NvdTZnWHB3NmZ5czMrQ0ErS3BLQkYw?=
 =?iso-2022-jp?B?MmttSmt4c3BQbTRITDNiOVUzUm5JbkxQYXJCVVFFYUZ2aFE0T0ZTNE1v?=
 =?iso-2022-jp?B?YVg5SXBLQ0RSQzFGTkwxQ2pDV3N2OUJnbE4xYkJhbHo3N2xUYUhhOSts?=
 =?iso-2022-jp?B?RnhsNkZISUgwdWtRODJZdDdkRGhyRitzRUpRWHRLWEVVQnR4TmVubWVW?=
 =?iso-2022-jp?B?OFBacHp4K1I2RmZlcy91MU9BellwNDlJQU5RNWRxbjJVZkM2SWxJYWhn?=
 =?iso-2022-jp?B?c0d1cVM5UGU2VFZ0eUw4Qi8wbjJ0TWdPTGoxWlZ0dGVLK3VLUXBIcWVF?=
 =?iso-2022-jp?B?WGtnS0t4a20ybE1pR280KytJeUZybFFUVmtDY2xJVENpNzcrU3MrdlIy?=
 =?iso-2022-jp?B?a3NuR3RXM3ZqWHJTcHlKZ01xSDZ0N1AyZ1dRdllKUjFIaFppdUpMR3RE?=
 =?iso-2022-jp?B?WGsxT2E3c1dKZ09CaUY3VUhsOUJWU1gyaXBWTXlER0tyalBmOGw4YXhi?=
 =?iso-2022-jp?B?ZGFQRlNTeG9sN0xsV1g5c3FEN1dtSXZjM1NMaFFaLzVuUy96dGNrQjMz?=
 =?iso-2022-jp?B?SFU0akk2SXB3b2g2bktJZWFWeXgrNXFLL3V4MWpmdGl0M1MyZzNpQkFs?=
 =?iso-2022-jp?B?dUtkM2o2SHNqMGpsZGFxWUhZaUo1cFNyVFpyYVZ3SHlrUThQQmI0OXhw?=
 =?iso-2022-jp?B?U2oxTFZ0K0xKcDhOSGNWOTVFbnZXU1FVNnBSbi9UUURoc1hsTlUyazZo?=
 =?iso-2022-jp?B?engyZTJHeWg5V1A1YldXd0dhWVgydVY2UUR3eGRsTEo3MlQ1VEhjVkY3?=
 =?iso-2022-jp?B?VzcrV01KcmE0Zi9jYjk1MFdWdk9BZmZQN09MZmNHT3ZPSi9IeVUvRW5l?=
 =?iso-2022-jp?B?b0U2VXgyNExmaWNkckRQeCtpQ1dzRTRjOW5hVnFqdGQ3MzBSbVRIM2lO?=
 =?iso-2022-jp?B?dTloc2trVHczcWNVQTM5QlJqcjVJemJ4UGtqZG9mRmxkdmltWGtVQjZF?=
 =?iso-2022-jp?B?RUR0N25aNDgwK3kyaWVnNUpOYlNzUGlkSDdjUWQ5YzRyL1MyM1ZqUmFr?=
 =?iso-2022-jp?B?aE93WHBVZEsvMkNacjA3bWlBMmxCUnIzNnhmUjg2bkFGSVA4d0psbG5F?=
 =?iso-2022-jp?B?YTZxK0F2VDVNWWtzNXM1dDJiczhJRmpNbDdDMEJVUzR2dnlTejNISTZx?=
 =?iso-2022-jp?B?MTdjMFUzS21ES3k0YytPdTQ1dG80VUhOcnNONzUxOFdYY2xCTTdpRnFC?=
 =?iso-2022-jp?B?NzhKbmU4RFBZNm9pSWdFWUVPRXQrWVFDTUhueG5USkJKWnhkVDB0djR0?=
 =?iso-2022-jp?B?V285YXk5c2RYWEVSaVpYMzFPZER1WERJcGprWFNoMTBnOE41TVVSZWNI?=
 =?iso-2022-jp?B?d2lpWlNLMHdVdTFkdDAvaDBUem92UVZqT3FqUzdHZWZGU0tMaXdpaTFt?=
 =?iso-2022-jp?B?L0xwWVczYVZseXY5TEw4UVhTeGJwYkpUSkxScWUvcDVIOVpmNHZjK3Js?=
 =?iso-2022-jp?B?bnVoSlg5SkFaSWhobUJ5UkNHOG9yRDR0Mjlxck9jSW43d0FOamg5QXhx?=
 =?iso-2022-jp?B?UHpLR0VkOCtvenVMK1JDSWhXRVlyd2lkK000b2cwTi91M2pSK0drR25W?=
 =?iso-2022-jp?B?aVI5U0ZDMVZMN3p1V2w5N2ZLRG9JRG1uWWFhelUzUzJqNmxaZmxYcXkr?=
 =?iso-2022-jp?B?Rm1lY0tGNG5Pc1BxVS80eGlwZ3NaaTVLNU4rdndqUGFGT2FyOVRhVDI0?=
 =?iso-2022-jp?B?dmQ1cDJIMm1Fb2VuSHZoMzAyRWpiRzFSRFBKcUQ2bDlQNkZ3MnlYbUR2?=
 =?iso-2022-jp?B?R3dOUE5DN1lWbzdQZFBya3lkSWhKYS9yTmN3ZHQ2QjYyNWZuNSs1dmFX?=
 =?iso-2022-jp?B?NHIwRDV5WkRQQUVzczA1MCtiZWZtQnNQRUVoNWdvb0YxQVJEN1ZmUWFQ?=
 =?iso-2022-jp?B?K09RekNndk4ySjc1L09uWldjNG5KUEN4MkZZdVBKTndPaVd2Wmt4ODh1?=
 =?iso-2022-jp?B?b0lRcjkwYUhVNk5YTEN6YWVIZUtJOFhiUnlwR0ZrMW43RkFTMStiWjZJ?=
 =?iso-2022-jp?B?UHdjSDFBVlBCSGlyMlVaUEVhRjA2RHpVV2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?R25ZeTh5MWQ5eHcwQ2gzcExBWE1GeWg0bkhnNXgyZnd2SkZtQ1lJR0wy?=
 =?iso-2022-jp?B?NmhNMmlnWUJCSlRmTVhCandUREZBOEc3bzlRQnB6VnpmQTYzOW0yY3Bl?=
 =?iso-2022-jp?B?eXRsNlF1QXovQnFMd2JYRktEN0Z6WFNKMlowalZDaTdHQ1VPU2MyNEFU?=
 =?iso-2022-jp?B?YUpjYUtJb0Q3RDhGMHpXQkVnM2JNOCtPUjVWVXlScXVuUjVDLytYK3Fy?=
 =?iso-2022-jp?B?NjloalloSGZGaG1Rd2xnMzRCdlZ2RzAwM29hMWE1Vms4QTIxekZCeWdo?=
 =?iso-2022-jp?B?ZTdYNkNOanZ2aUI0Q1FMWVM5UUlLQXpwOGUzaVNNaGpJY1l1RjhwVGtR?=
 =?iso-2022-jp?B?MC83UFRtTUFoTEtxWDl1bllhYUpZSFZUSkJlVGFvYyswd2s2SmdvYkw3?=
 =?iso-2022-jp?B?ZWUwbDNJQ3BCY0NkRHYvck5seTRWVkFFb09ZMlZnNGhKUE95Qk5Kcnp6?=
 =?iso-2022-jp?B?SzhLdWtETEFPYTdRWEdzMVd0UlFtbjFqYUMyS2pWVEtyWmgwblBQbSti?=
 =?iso-2022-jp?B?UzBrTmpvcE9MY1BmclpwdFFBM240YXUzSlErVGJCN2M5QzV0TVpZZG84?=
 =?iso-2022-jp?B?WjFCMFFWeDBONThxeDFjOGxmRTM4Y01vNmZSTC9xUmdkaWppNy9iM2xY?=
 =?iso-2022-jp?B?V1lyOExjV0toMXMyM2VPbjdwQkNJYzJ2cjVBU2VEMFFSUzlSYkJJSFNz?=
 =?iso-2022-jp?B?R1pTWEo5K3JLVkZKNURsdkNKb1ozNmdaa25HRHlpamtySGE5cWMrWGo0?=
 =?iso-2022-jp?B?NUlLNFZSbGhYMk5tMnpGN1VvKzZQQVNLREtleTdwbEhQTUVPbHNwZzA2?=
 =?iso-2022-jp?B?UEk4S1h6TmZaeEtzYXZ5TlpvVGRWN0FuYldMTG1vMUlZZWRxSlhPeURl?=
 =?iso-2022-jp?B?MXBSQVB4R1JleHgrOHkvSUZ5NndDM1JDbW1uclBzSlZpc3dUcGJ3NjdS?=
 =?iso-2022-jp?B?UGFiM1NrSEt3eXF4L2Q3eWp2d0ZRL0JDSnhnTjQyZTg0OUljejhoNU9B?=
 =?iso-2022-jp?B?WllWM1dIYnd5SVJzbUhVQm4xSTFJQkVCdEdDcEx6UzNWaFNKaXdZaXRX?=
 =?iso-2022-jp?B?TmhPdlhWd3BzQnJSd0ExNTFhcVhtY2tnbXZGc3kwWjl2YytycGE4M0pR?=
 =?iso-2022-jp?B?RWlFWUNkeU9OK1RZN3VxWi9QQ3JwTDlBSkd6K0ZpT0xGZDJESVlSV2lR?=
 =?iso-2022-jp?B?bnR0OEZhV081M0ZkbjRTalFVcmJDZ0ZvNmd4d0JZRC83VkhBZTIzaDZV?=
 =?iso-2022-jp?B?Q25ES2tseTRZUHAzVkVqVXdRbXZTR0lBeDdiMzBGSEp1MmJIZ2xMSlBD?=
 =?iso-2022-jp?B?NG9WNlZQcUE5b3NSUEM3ZmtzYUR0T0RuWEwyTnNEODVtbE8rVW03UkZu?=
 =?iso-2022-jp?B?dlkvcEFGRUhIQkNQYnZ0RGlYWWxDQjVkdFlTV0dnSlduQlJhQm1LOXlT?=
 =?iso-2022-jp?B?ZzRSMis0UHBCcm13VDUyclVhV2VWNVRrQzFMU05va2tWdFRyVWVBYlls?=
 =?iso-2022-jp?B?WjVSajA3czd5SUlNdGo3Snd0NnZBZm11OGpZalZSeS9nUmNCVFNqQlZ1?=
 =?iso-2022-jp?B?T3F2ZWVJcHZYYnpuODRuVEQ2aE4xanpnU2ExYzBEOEVGZkFUNXBFTTFn?=
 =?iso-2022-jp?B?bWZOTFJNR0xDQ2lQakhKOEtubEQzRU9iQ1JHSUlZZys3RUdBVDhqZ21j?=
 =?iso-2022-jp?B?OFQ2WUlZTDRLSjVDTFowQ2I5aGhpL2YyZHpFNTNFYWxkblo0VDhpRWdU?=
 =?iso-2022-jp?B?NmI4U1hDQXhGZFlaOFhGZzB1SUQ4dndWVDRwbnlxZHkyUkY2eE5qT0tZ?=
 =?iso-2022-jp?B?b1VRVWVGK2MwRGVzdjIzaUIvaUM4VHZGUFVaZFFiSElHSG5zYjNVUXdy?=
 =?iso-2022-jp?B?NTlRajJGK1RSSU9ndXBpWnpCL0Y5RlYwcWpMaHFuWDJPVXBkTE5qK21N?=
 =?iso-2022-jp?B?U2VyeXR3b3BBMUF3V1RqL0xibUVFdz09?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fecb0add-dead-47a1-6000-08dba3a77bf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 07:06:33.7286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gTPVgzTo1rfQrq06kfjuNHIiqsgepigmR1ri+2CCspp2DiqjpHnGVR+3rdWxVVkpDMP0hMhkLI7rLqDLE8XRezdU5X8+KZhwXD+zwl8rQoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5427
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

I tested these features and ran the selftests/resctrl test set,
and there is no problem.

<Reviewed-by:tan.shaopeng@jp.fujitsu.com>
<Tested-by:tan.shaopeng@jp.fujitsu.com>

Best regards,
Shaopeng TAN
