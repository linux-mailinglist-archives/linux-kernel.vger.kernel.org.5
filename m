Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C0F76C250
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjHBBhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjHBBhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:37:31 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Aug 2023 18:37:29 PDT
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAF6269A;
        Tue,  1 Aug 2023 18:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1690940249; x=1722476249;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pjA6GgLLRXgEp03OWYAMIBBX+KlMo5SfINcMpss/Ozg=;
  b=Q+2r4NGYZSjXm+f5Zbj4tkrcYNLGlPmbJcruBU2kBH7p7uZHbqq1KU2y
   OuDqJ5hNSJpnwClQ/V8cXBxZEf5jXTFbQwxGg+2WU1IBFU5dhw21xraF9
   7QjmFoo5iPP94qSVu98K0oL5KyYo9FWv/h2kelB8WZHAG1tTm3Am9mrid
   h2JRQAuemTzDEY+jF/V2GHwDAqNzFYjcpgThmtl/xoUQDokgtlJwe/0qx
   IjhQexmKEwZvncKL5//BrdHd6yJXGp3GcFXN0FYSywp94RZjHOUwkSxRd
   UiR2PeXeehG2QGneC8cG5jpk1fitrSShTIecQgf2qymkmrlEKnryThB3q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="2340699"
X-IronPort-AV: E=Sophos;i="6.01,248,1684767600"; 
   d="scan'208";a="2340699"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 10:36:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLokD3UCcViK0ZTrrGzAAelF7R1hweqXkqR/b/89aI4PeaQUddITfSy0mFNuco0OqPc7WmiW10V53ZquY/APBxRYk5UW4NqVqr5juovFFuYaGtzoeWNIWdi1V262/uNu5S23zmSKguBZ0zoysosfdSm+IBQqmPYnAtZnqHRGKovSPx7l9w2qKpcGrkCPMJiSXys6IZQvj30QPB3mIvZJjxyJLc2sTzK3rEvOaIry60tBAed7NA0g3gWNI+pYlJhCGNjyJjcs62SKj9ysTatLpOw8QgdsGnd3MhG7Z7Odq6TZDzqeKMelAV1X70B4HxVU9D1ktkmrHNr5rjKYmK7yUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjA6GgLLRXgEp03OWYAMIBBX+KlMo5SfINcMpss/Ozg=;
 b=YB2X8dgItEFFOFvLd18GvegNQf22xxGFM0D75NI9PciGANXCzADq9f8XZIZ77n06YhBJgGqSjBVzUP9aouM+kvh4zbn4Oq8YhLcZbXhjJBbzQaJWxuEuQILRtyAPfp8NPUuVgp/4yNUhLTPkDSXHSSjWpmETSHHEcgQLoRtlIAZ2amsdMklmn1Bop8pVTvcKnOeRus7PrEtsa38xXiilFu9Z8NsLX+6rTDFDG9dTJnYDYHdxcEpiHzFsCMV1UY3elxStTJ2Z+5SEk0F/uBv3liww3tFIH675BBXgGJbz2Z39Q+H0wVRtRwk+V53GiBjSjnTNRnOPw++xuC+mHuiKxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OS3PR01MB6242.jpnprd01.prod.outlook.com (2603:1096:604:f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 01:36:11 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::70a6:407f:e7cf:3231]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::70a6:407f:e7cf:3231%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 01:36:10 +0000
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
Subject: RE: [PATCH v6 0/8] x86/resctrl: Miscellaneous resctrl features
Thread-Topic: [PATCH v6 0/8] x86/resctrl: Miscellaneous resctrl features
Thread-Index: Adm6l7HN62YKzlyg/UKqTbJByCkYlgKSgWTt
Date:   Wed, 2 Aug 2023 01:36:10 +0000
Message-ID: <TYAPR01MB633070C2DDE7BCE94F3128E38B0BA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <168980872063.1619861.420806535295905172.stgit@bmoger-ubuntu>
In-Reply-To: <168980872063.1619861.420806535295905172.stgit@bmoger-ubuntu>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9MDc5YTc0OTctZDJhYS00YjZjLTkwZDYtNTdlMDI4Mzli?=
 =?utf-8?B?MWEzO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0wOC0wMlQwMTozMzo0NFo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 008613985b014d1f99042311fcf8cfd9
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|OS3PR01MB6242:EE_
x-ms-office365-filtering-correlation-id: 6baab9d8-e725-4d0c-271b-08db92f8d9ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r1ogiJRIJ+0PKGf8kO0VfuVU2RBKdXnfMwfD+W+uLad8YM/c4phhBxYGdVp0tkoDt/sZOmsBJGMPMm2YFUlhqOWna8enAKWUE3DiAB2ps0T3R6vo1Cj+5KxdQCdrc/z5h+7lF8HvARM/DzyCbOYIa2DXuYKzAyYEwdJKAsNlzvfwpD8mdLHa79nNjI3Si773D4gLfv2qha9VvRcPiBctByQP8E0I1E9j9rup+/9z0Z67WyH3WOuP7kfjCV15phRNI7wRfqqORsjg3NeYNI6402MQSVmyQIei7aqEaNso8rENSZocu+dssv54aq2M25yWwqDpbu9LcMT0pEQMUOTJfFHu6/A12x6IPUY04Cv7hmE9i1tyxGhno95X6lAnLvBye3OZ36Xfbksd50RfD2Lh5DagLHFJLcI6EmePp7xW1RmUq3TnubQ06sQiCq3k8zBTwnvYQIa1coXeTebrqO+9Hzv9GKDlPnCDzFE4CIWM04l+PV4gxRv9zW+lXtP8dErV6uSRjeSYM2MzUjxBJ0t27qDECbojdahPsXH5lhs8sGijebXBAXIA1NqqkrTGDqPG8g5zU9N27GlP7dVOCFOjT3dN0uUb2e+BQ1GxFLOChpHByYAtILlq1Gj328RJbrsLOEqphVcw0PZW+MaYncj6nZQNt5PzdktwiZ+MQ6idCPw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(1590799018)(55016003)(1580799015)(9686003)(85182001)(316002)(86362001)(478600001)(558084003)(122000001)(54906003)(110136005)(38100700002)(76116006)(71200400001)(66946007)(66476007)(66556008)(33656002)(66446008)(7696005)(64756008)(4326008)(82960400001)(6506007)(41300700001)(26005)(186003)(8676002)(8936002)(38070700005)(7416002)(7406005)(5660300002)(52536014)(2906002)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVB2QStOSWRrNVdJMmg3TkRQbFFwUERXV2FVVVo5VjlYeVBsM2RjSStibC96?=
 =?utf-8?B?SGhvblhDMXlhUVppU0swQVFUTEdUenVhUlN4dng2eTlzb0U3LzNJTVlJOTd2?=
 =?utf-8?B?Sms3Wkd2QlM0NnkrSlEwcFgvMWg4cTlSOURFS05nbkxkMC9DVXRiVi92L1Z5?=
 =?utf-8?B?MldJTmtMWGhMMFZ5d29nd3JNeWtmdmlHQmZpY0pLd0xsK0Z5OXN3ZUdzN1pr?=
 =?utf-8?B?RUcyUWJIVlZGWFY3K2l0dFdHL3dud2FaaDV6MzluU1BVZ2NhOHErOXlsdGFw?=
 =?utf-8?B?TEo1ZUd4QXRJWllsczJ2bEFFTk1DL2FrVjFXajdlU2xWS2huRUxnaHFQWi9W?=
 =?utf-8?B?Qk4rYlBUZkdMUzdkUDc5VHFmWXd3aFdZWnEwSzY0VlRkcklRVHZ4K3hER2pz?=
 =?utf-8?B?SHp0bmpFM1NMWFBEajZTVXJBd1ErYU9iclNDUVNrY0p3N0ErRnAwZVhod0Rn?=
 =?utf-8?B?NHVOaU1nVngvelo2Z3Z1VXhFTWdybjhjWWlHUEFmanQ3Y2MrZFo3OENhZTg2?=
 =?utf-8?B?a0pwd0V2OEo3OWFwbmt6Zm5GbEdRMEdpNlY2Njl2OHpSbTdldWtvOGllZDZM?=
 =?utf-8?B?Qm1xclgwTkhaQ0hza1pSY0cxS1A0SThLZlhHZzY4cTl2MjVrSDRpZmlEcjFD?=
 =?utf-8?B?TFZET3M1T3FoWUtSN28zMWJIWUlHYTBsQm1QOTVhRk9Ed3J5a2pmTlMwclNT?=
 =?utf-8?B?c2FZWXBpeEc5dDhTN3dQTVlMaWFiUkNBYWsxNkxhVU1zbjdBRjFLTmtIVGl1?=
 =?utf-8?B?WjJNczJzRENNbDJHUnk2RUlHYWZKd1p4a3V6Z0E2c0g1STl2b1h3VDBLUktT?=
 =?utf-8?B?MDU0TVN5VFBvcFJNNkJ2V2R2SGZiZTBpVmhaVmQ5c3BjRHc1cXl5K1JiRXBM?=
 =?utf-8?B?cEdwblpVMFZwWkx5SnFBc1ZEbi9salhtVFVHL0M0TGFNWmlRRVRCZDVGZUJO?=
 =?utf-8?B?SHhQK2RORVVRTG1QcWdzUDh6NXY2V1dxQmlEUXB2RkJjRkJrdTU5TXRSQnpl?=
 =?utf-8?B?UTlGU3lPWFpNb3BoNVd3ZjNVQUZRYmk5T1BtZTVPaHFDTmNWelpPeWV2MUQ5?=
 =?utf-8?B?Ync0b1dRYVcvSUtpWEI5Y2l0Tlh1dTlYTk9hbmZvZncvUHpEUEU1SzZNeTZ3?=
 =?utf-8?B?Y0daSHBGU3hCRFM5b2IrR3Y3TzVSRlY5MGVyNWRYV2VoZ3hKc3RhWnpFeDh1?=
 =?utf-8?B?U0FJUDNsQkJUVE16Y0hwSTRDVE9NSDJxN2tpbVRxcjlRQitXVmp0c2I1eG1v?=
 =?utf-8?B?K1VobjdpNEVReWZqN2RnOE1neHppNjlnNGRUaG1DYWoybkR1NnhRS1QxM1Fa?=
 =?utf-8?B?S1hoWU9xanhXRTc2ZUgrRnJyZi8zc3lKc1VJcjJhNlFKYVRrUTFTQmRDQjZW?=
 =?utf-8?B?OUEzMmszVU5Wd21uM0NOa1JxYm1rTUJOb0FSMU1SYVRTVHhuekg3Y2hDaGU4?=
 =?utf-8?B?aUw0bGozZ1lIR21KeGh0NjlZRjVxaG4yR00xUnh1WmlRTG5JWUJzTEQ2ZXBN?=
 =?utf-8?B?VlRsVlJ6MElXeFowN1hIcXZqaE5aRVAvZndiK1ozb1ZKQmlJMEtCalA4MjFo?=
 =?utf-8?B?R1B3ejU2MXp4enpGSUg5bEFZd3RBVUxDMU1TbVBkSWRMQW1aMkZ4anpDZ2hm?=
 =?utf-8?B?dHk5K1QxS0ZrdmNZNEZWb1ZJZmFRd1ZRNjZiY05nVndNaVZTV1piYTVjZHhZ?=
 =?utf-8?B?ajZLNGNqS2hkMTU2eFIzVXNhYWppUkQxd0xVTEh1T1dyZ2FoYUpPdmkrZmlk?=
 =?utf-8?B?NkZKaU9WMmFJWE5XT1R4VGlpa0ljOTMyaHYvRENscnV5Q1YwNGFYMHc0M0Ni?=
 =?utf-8?B?Y3I2Z01JL2xESk1jU0F1QmlDZ29vSk40RHArRGN4R2xPQ1ZZVXVaeUhycXdD?=
 =?utf-8?B?OE01TmlLV2ZNSW1oUnBrdGtQZ2pNS1Q1QzhEbUpqeXJRWmVoTFFFdXZZSmVt?=
 =?utf-8?B?ekE0WFBpc0RhUHdRSDd1RnZPaDl2VEF4cTdINURJQVU1aE1LM1h0NVdqdE9i?=
 =?utf-8?B?OE02RUcwd2hKVHF1QjlpOS9GTDdpdko1SitEdFZLOXIrWlloWWY1QlZIOHRG?=
 =?utf-8?B?OUplQW5kcWhya1hTdDNQd1NhSXkzdndiUmV1dTBsbkk4MFl3ZGdSY2xwWCtY?=
 =?utf-8?B?RXdiVWwvbjRmVUtqWGdmTGNIc1lSaWRicHdrTHNIdnFtdjMxQTlzZ2lueDBq?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TThOU2l2T3BkeDhYKzRRdnF6bGZtRmxDQ1lDRXU2eUhZSVBjS3pPV1owMURN?=
 =?utf-8?B?b3ZzOTFhTjdkc2lZNXJDUCt4UEVheE5xVjRDVk91NkZQVWMvaWhpcThQTVpr?=
 =?utf-8?B?ZENvQzNCMDZITDE5UG40dmRmekJQdGlDNWpmMVpma1JwRWhKTnY4dUJpN2ZN?=
 =?utf-8?B?NGcvTDJMSllrejZuNk92VFJkSzZIN2Z2V2J4RlFIRmJIRmRXbXZna0Jnd1Ix?=
 =?utf-8?B?MEtKcHpUVFRhYkdzMmRHQ3NrK0dzS2hoalhiNUdmTE51N01BM0pwd3hua0My?=
 =?utf-8?B?TUJMMFRTNE5QSGZiQ3VURHE1Uy9sM1NJSDQ5MkZWZ3p1S0FyYXA5V2J3RE1m?=
 =?utf-8?B?YmpKOGJIT0lkUzBFN3lPZE05UjZrbWJIWDdNS3A3enZmRFVuVjdxNnJlYStO?=
 =?utf-8?B?Rk9kdWxCTkp6SXplM2dSNGx1UGJLd0FlL0FuNDdZSGhXQVVZNytYQWxSMlZm?=
 =?utf-8?B?RlJGdC9POFFNdXU4S3k4WVgvM0Y5YXBoSmJnOEZKZEJrVHlYQ0lRK2FVMFZF?=
 =?utf-8?B?SHpZY2dlNkVWMFIrUlZ3RjVNWHkwMHEzbkg3K1ZRY2ZrbVpkK0djME1Bd2Yr?=
 =?utf-8?B?UmVSTURodUVZZTlUbmNxN25aaUVWdy95QWkreEoxcnNvMXM1NlluclpQaGJa?=
 =?utf-8?B?a2VZR3NEUDJPQ3ZGckY5em92bm9EUXpJT2licG51Rjdhd0xCaEtCSi8zbFpW?=
 =?utf-8?B?M1d5SGZrZEFuM3BjamxiQ1RpdVp5RnZOUTBnVXV4QWwxejRvdHVoZVAvUjJJ?=
 =?utf-8?B?c2t0T3lXN2M2OHpSayt4NStqSDBncGpxSWJha1BqM2QzN0Z0Q0lwNllqNmpG?=
 =?utf-8?B?TW9CeFQyYWdoczlkOW9CY0hQcjdOaHNzWHdKT1Z5ZWtTRzVOWmNNRXc5VWtm?=
 =?utf-8?B?YUxySVVjbElXY0ZQWGgrY0VBTFZkOXF6RDJuTzdCRHcrRjhEb2phQ0QwQUlJ?=
 =?utf-8?B?Vno3eWNXZ21HQkJwVDlMWWV4Z2dhN0xRWFdNOHRseTdiakRyU1BVQnpicGk0?=
 =?utf-8?B?dkFGVmZua2tpWlZDZ0xZbzFCTzNwUjN0SWQyT3JVQmx0aVRaNGphZmlmbFU3?=
 =?utf-8?B?M2kyY29aVmh3cWFFd0g0Uk5BSGxFY2JGalhCMWQxMDdWNnl4WWNEZFN0NEU1?=
 =?utf-8?B?TXZwb3Ewd25aL21VMWhiZGhoL2VVQUNqOGYyYUZweWU3b2syWkNoRDBvM25P?=
 =?utf-8?B?OEpsRHNEK3BvUHlEUW5GcUg0UlFKR0lMVENramduYXN0SWhBaU9iYUVrcWh3?=
 =?utf-8?B?bDBQT3ljc25FemtYSlpmRTA5U1UwcWJUMDdramdtK0IzWmNvNm5zSkg0L2c5?=
 =?utf-8?B?SVBSVnhIYW1sWGk3SXI3cXJTTGVIRCtTMjYrSkJCbFRQdWlUR3BBdU9vUGFj?=
 =?utf-8?B?aEdFbWFXcVFNVy9zbUZuaTQ2bUc5RzR4S3FKY09nK21MaDczcVdpeE00UU84?=
 =?utf-8?B?cHVEMHkxT2tMc0Z5Uno5ZkRXeVhpOVRoOUpOVnNzd2ZWbVJQdHVhUWkyWWxV?=
 =?utf-8?B?cm1pT3h4VEFHQXcrUGcvbzcrTVVHQTkrbFo1aFNFN243MGhOWlI3MVdjVVlV?=
 =?utf-8?B?TmlDcy9CNUY2VW8xckJ1bGZhdXJaUGlnWTkwM3d6N3N4QTlDNkZPaDNSZGha?=
 =?utf-8?B?aDQrUnJVbC9odnJjVkdiSld6azE5OHB1SE16dkJpbmNSWHFmZVJTaDMybXgy?=
 =?utf-8?B?cEJxdUFIWk9RaXJXbDlFRTNaRVB6WXJ4amZxTlpFc05COWtzOEE0YWdPaWU2?=
 =?utf-8?B?U3VOOVo2dndOWXBYNCtKM0V0QmtSK09BQnNVdDB4a2VOUDMzWEVOL0RRbTVi?=
 =?utf-8?B?MXJJNFk0Ky9INit4RjlPdz09?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6baab9d8-e725-4d0c-271b-08db92f8d9ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 01:36:10.8121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wnFlPyblEdjODPYdb+e8thowvM78gnLpWUxJUH5dT0BIigusYO5NRwVqqHvJryHv9adQoFOOTFGuqpONSK+lJPGazoHs/DV4zSVUwEX3GQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6242
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmFidSwNCg0KSSByZXZpZXdlZCB0aGlzIHBhdGNoIHNlcmllcyh2NikgYW5kIGl0IGxvb2tz
IGZpbmUuDQpJIHRlc3RlZCB0aGVzZSBmZWF0dXJlcyBhbmQgcmFuIHRoZSBzZWxmdGVzdHMvcmVz
Y3RybCB0ZXN0IHNldCwNCmFuZCB0aGVyZSBpcyBubyBwcm9ibGVtLg0KDQo8UmV2aWV3ZWQtYnk6
dGFuLnNoYW9wZW5nQGpwLmZ1aml0c3UuY29tPg0KPFRlc3RlZC1ieTp0YW4uc2hhb3BlbmdAanAu
ZnVqaXRzdS5jb20+DQoNCkJlc3QgcmVnYXJkcywNClNoYW9wZW5nIFRBTg0K
