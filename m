Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E11785114
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjHWHEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbjHWHD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:03:59 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51648CE3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1692774237; x=1724310237;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fKi5YGQZ05pj5WxUNaSNrUQ8Uw4KHNgxQcfVDiX9rUs=;
  b=qs23Px5D2FQZXRTJoQOnP1dIZ4/et2cLvvfIwsUcuvF9mqXWmEVmPc6F
   l5gr8gmguyJTDQJVH5Dsel/oTOfMPUiWjYCIM9u8CdTROJtSFrb2ywVIM
   oyDo2NvZ1f2c8oVJQLlNszOfk8EcN9V0MJjl3Asy7F+a6dxEa6xa+aWWm
   7ru74AuS4AYkEYT9Z1OacQrr5Wxd3IKrDk/47Kn35R52C2pMy/HOIPhw6
   yTJSYq6y5EyvFCTXrkHZT2LMOD5xkAFeA/q7tNcmeR91jClCnhOLQ3bj/
   mU/vggPrqAs5nyVufe4aIxgWL0fQcjXlXyQaINhVtA9VXHJHhyPId3Ldl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="92846664"
X-IronPort-AV: E=Sophos;i="6.01,195,1684767600"; 
   d="scan'208";a="92846664"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 16:03:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpf64+sQRYE/ywzwdIASxEhBJNaZOzoqslaCJvpRroR/K97zALO6SxziLPTBv2c0BuHVadJZ7ApoLfWnCQ0KvnyCu1d7N5ikdDjGUDkEbYhJToBoY702zAjpkAZ7MJKEbI+ZsiQrZoyadFtFwfTD0U9LdZSUb8Ne+1R6DcAgty6wufRpfdYL35ftD8Ohuhaboj4IwiDYaARw/9KCo4tCOdVfnqTZ8LREmzS1i8C+otaX+aYlFsGDwON3o6rKhLBrISK082oL5UqQu5KGU7huyxO4Vyu/FyXyzHcQ3/hDzbwCgkUCTqjkFshFUMyfNfmr50gLamjVdnaR1ptrg7vvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZjx7WHKEcj9j3phRrkznCSGtME4ioVFnaauoKifv1I=;
 b=kfUUaA9Rc7BsLH+MtrSBaMEE18uqAsCtxAISVMAT4S+KSv1duEijGW4ZotKJ3akChrDCGSucbhfg9r0cpd4+jh29EndKX3XXpUNy7okUkqY4lRtq3M9sFEgGGM2rxw3yxqqCwPGC9l6YuL7AMvWp4/MBnC6sNNLnp0xvzc6+E8e8OLlpyGgwQDKTYHBVuhk3SwZ3Y4LMZFJ+VHTr/Pqh6VI7viAs5ZZJUoqOaCeFg0cGl/eLvEHurRQKRWuICUGtUuQBeP6hl0W01Ay3zkRldGdxEZY2EHOREMQ8U1twjGr7KGmDmDdPG1hcBfDMz5BRR+ue8oQVQGwXDXV1F9jSpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OSZPR01MB8596.jpnprd01.prod.outlook.com (2603:1096:604:182::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 07:03:42 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::59bd:366a:131b:3f26]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::59bd:366a:131b:3f26%3]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 07:03:42 +0000
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
Subject: RE: [PATCH v8 4/8] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Thread-Topic: [PATCH v8 4/8] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Thread-Index: AQHZ1Y5jbzrWHpg6cEOlixDJoeGRfK/3cfIw
Date:   Wed, 23 Aug 2023 07:03:42 +0000
Message-ID: <TYAPR01MB6330B653E1F66310E57ED38F8B1CA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230821233048.434531-5-babu.moger@amd.com>
In-Reply-To: <20230821233048.434531-5-babu.moger@amd.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9NzUyMmExMmMtMzJjZC00OTQyLTk5YzctMDY0?=
 =?iso-2022-jp?B?ZDdkZjI1OTE3O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjMtMDgtMjNUMDY6NTM6MzJaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 3c46ba06e35441c9bb0850160435f22d
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|OSZPR01MB8596:EE_
x-ms-office365-filtering-correlation-id: a1d14daa-67dc-42ef-c78a-08dba3a715e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rnAV0OLFm+jkhqX6/F1+iGOGIN98LRPLBE8tPhYJG0fd3cEvOd5BxvSppUKq6N/cCJt/9L95ZGyIpKskiOeZfH//r6ykjSXUSApPPxbspi5fW3JpLKn9+66osmfJrLPsgLI/qdhPA5Y1ABbOiMTwXIkxsPvzWxEds4Ba0qbGifEaAVthA8L9MxFtc/SR6b3mp9uZRCrzqjCRy2KicN3V6UXk2LhlnTZkGMBFhJlZ9ejHSYWilczA2H8T5UNtms/MnlGvvbTrC21MSxCkmrQDFGEanbUXu0ASpixAhskRYKXT5Vg6bIwxP+5jxxW2vQLQTPGVjCI8FYCys3x4yorGWFyxis/mqgMi0YGtThaKcWIQzTosWoPFgQMjimACfouSUHcF+R5kX0sWHQSQJYP1RgAYhPQ4Bx22SPYnBTFGP7BIZZ08KrZgk4y/v66dp5PvhhEXVtb163k4gIw4RgQSabEhRQJ38+6rTnQjN0wSOphNEuw8Sq7VspBmZmDMg7LNIX8qUoI4WHzsAZ5w6om97qnGKHuYylNQ5V8kpy+kxGiroy99i2f3p0EKR1mGn5VdX7LKkqq4c5CDW8blk73Ulwonwbd5zCcKnbrRVUPPwOIWEJ8kt02ET/r8AwhawmrxQvp5N/Y+iGHaM2JNxyCRyq4jINq8a3DnD5cE96DjnPc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199024)(1590799021)(186009)(1800799009)(52536014)(2906002)(64756008)(66476007)(110136005)(33656002)(76116006)(316002)(66446008)(66556008)(54906003)(85182001)(66946007)(8936002)(5660300002)(8676002)(4326008)(7416002)(7406005)(1580799018)(6506007)(7696005)(9686003)(26005)(55016003)(41300700001)(71200400001)(38100700002)(122000001)(38070700005)(82960400001)(86362001)(478600001)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?dzRweE1jL1gzcWZBM1cwaHhsa0Y3a01MUVNzbmlGV25FRWtiOHdHdktX?=
 =?iso-2022-jp?B?SGh4UitqY1VOMTBFRko0V2huSlYxRldRRWYzZFUrY2tRdkxyOUVQaGtI?=
 =?iso-2022-jp?B?YkxOL1JEQm1Fc2Z6N2NBMjZDRVYxU1ZnMWttTmNWYnhwWHQ5NUllaEMr?=
 =?iso-2022-jp?B?S2lVbFJXeGJUSTdiRm5pRWFwd1Y0eDg4aXlzN0RoWTlLY0hYNEozb2F4?=
 =?iso-2022-jp?B?Uzl5MHo5S0NjQStIYXBkWCthenViQ1FxQzNkdVVhUEtVRVB5YlpoRUxt?=
 =?iso-2022-jp?B?QUQ5ZWpxNXI1UzFjQS9rR0MreHVxS0I1ZHVBU1NOa2RSV1BYTWRBVy94?=
 =?iso-2022-jp?B?ZjhMMEtsRnJxV21vV25SbFNOWTdkNzM2R2ZDVU0wdk8wVFQ1cUtRSkpx?=
 =?iso-2022-jp?B?TlltMkcyK3RwK0tjTENxOHFVUUQ0MFpqMHRFUmxCS3dLZ0N6RjhxQjBO?=
 =?iso-2022-jp?B?UGJsODNncDYrMmRDUW9SL2NUVmpGbCtIVUdXN2t4L0ovNTRFa1FoTU51?=
 =?iso-2022-jp?B?SE5CeVdkTUt2clc5aGdsQ3FhV0x1TUpZcHlWTWpSa3crdk5xYk9oVXFP?=
 =?iso-2022-jp?B?ZzA5K2dwdkRkN1d2emF1OHY4WVZnNFRIb1ZpUm84bkFnNldHVkdZOHVH?=
 =?iso-2022-jp?B?MkFUSndWbmZBNElhZGtiMlBCZlV4TDdUUERnd3NLdlpHT0ZtRDNFbXVv?=
 =?iso-2022-jp?B?RWpFNkN4TkpSMkFUdVVlV21CSjlLZTBqNlQ2Yk5nTEZ6RDBTaXlMUmwv?=
 =?iso-2022-jp?B?OHkxY0NrdldUdDN5Y1lsQkdqcG14Ym5raUNZOCtJNnpXbVZFdEpjMytY?=
 =?iso-2022-jp?B?QjhVWWp1dmNMRFdPZGdkSGl6Z1R2MzlpdDBqN292MGY1OHhuWDFhemg1?=
 =?iso-2022-jp?B?UkFaVDJNWkxKbjJkeUlXUjduQjcrV0ZRR1NxZUVVQXZBMDA5NTFUNWZH?=
 =?iso-2022-jp?B?MGdubmViak1LU24rbk9jWmFTaGlIakNLRFFneDBaVUlVMmtkRUlCM09H?=
 =?iso-2022-jp?B?UXI4elAvS0FUdjcwZlU4Uis1Qlh0NGJ6SHE3TkJUcUFwanhBZy9oQWtH?=
 =?iso-2022-jp?B?L3EvYnhVbTlidEU5U2l5Rko0bGFMU3dxeTFrR3FnZzkxM25tN2NLUkov?=
 =?iso-2022-jp?B?NnZ4UllRdW5HdEdGc2twK3V3bEFJTkVSbmRjMUFuY3RIVXFsNlhrMG83?=
 =?iso-2022-jp?B?RUMxaUtXd3lLZnk0SmVseHpkTlFmWEVHaysrZURXUFkzNFVwd0pjQ1pz?=
 =?iso-2022-jp?B?dGxQcGRIUm5nTno4RFhNSmpPNGFQTUt0eEg1WWVNN1dPNzgwdkFGRWVP?=
 =?iso-2022-jp?B?T2ZRRytiTm1iRGUxQTBPR3JqMTgzZ0xWMy9Ccmo3ek1EdWtTby95UENZ?=
 =?iso-2022-jp?B?aDJSY00vMG5qRjYzVFAwdjVvZFhPNG41YmZiVVpTa3prRVdoUDRNSW9S?=
 =?iso-2022-jp?B?WkpSVk16RmUxRGozUmJrUkM5blhGajRRRWJwZ3ErYlZHRGx1YWVpbC94?=
 =?iso-2022-jp?B?VjcyV1JvclJSTk54cTBxWmM5RW9iWncrVzNsSWpIQjRHeEQyTGVsanNw?=
 =?iso-2022-jp?B?WXZGemh1V2NMdzdlRTFESUtVNEZLMGIxalYvK2lwNlM4YnJVRHEzcXVD?=
 =?iso-2022-jp?B?R1RncWhyT1QwZG1KejEvWUVZZTB4Z0ZnaDBTOU9RUkpDNFFLelg0OGRZ?=
 =?iso-2022-jp?B?dVlnYUxjdGlTYWF6QW9NTk9XbThSeU84MnRtczZSVmhDeDhBSTlCSHRJ?=
 =?iso-2022-jp?B?YXcwcTRkakEvYzNCL0ZuOUd0MlRrMXlOQkpWL0xtOXJrS054Vnl3b3Zx?=
 =?iso-2022-jp?B?czVsZSt6MHdHSGJvUGxGcDVQdkU3cjM2R0dqVUFvYXBmSVBMb0dmd3VB?=
 =?iso-2022-jp?B?NzNzM055ZjVMKy9JTkEvcHB2aGk5bmw5VDM0cGh4Rk5xSmJ4YUZqSUFL?=
 =?iso-2022-jp?B?Z3h1N1o0S0kwdnJybGUyQVdUQlZ4VUtEbGo5emlOVWw3WHhNcXp0ejR3?=
 =?iso-2022-jp?B?VS96blpLMWQzcUZzTGI5MlpJUzJCcXZIckVFUUpmWEduN1czc3ZFZ3Ju?=
 =?iso-2022-jp?B?L0ZWMmZwdHM1Y3krVXViNDNxZ3FGUkh6bStML3dXdTJJQStvM0dZOGlS?=
 =?iso-2022-jp?B?WTRKWDBnUWEwZDZQbkNpTFcyS2RuNHVycTMzTVpkY0MyeGYyUFdZbUM3?=
 =?iso-2022-jp?B?OGdZWE11T3F6QW1BUkdDTUc2Z2lzWUxsQ3NVV1h4eHFMakY3cHc4QURM?=
 =?iso-2022-jp?B?V3FMc1h6M1pzamdIQnBaS2xBVHlJZGpic094M1g5ZEFiZjZjK1B3Wjl4?=
 =?iso-2022-jp?B?cGlvYng4cDVqM1dxTVp6czBnWFBIVmRxNFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?bTQzejJWbFdaMmQ5K25uQmNpMmtSVUlkazN3YldZa2c1YmwxRnJRTTkr?=
 =?iso-2022-jp?B?cXFQVHRNeVNuSGhZbzU2UUUycGxNNE45bzIyZTdKeWYzWDVrOGR4bVQx?=
 =?iso-2022-jp?B?WnVpQmRSa3JFbTh4eVo2NmNtSmdaS0sxd3ZXcDMzZTRZSS9CQysyVmV6?=
 =?iso-2022-jp?B?SHF3cTQrbDM2cmREVloxNEROMGNOcUMzNDJrbndacklzM21Ga1BvQXNK?=
 =?iso-2022-jp?B?YTRRblZlVUFmaURYVEczS2RSU1p6OG1HajEzVE91OWRJWE9JUU5PZmRX?=
 =?iso-2022-jp?B?MmdpdXJrSDA3VzY5NFN3cEoyVmhqNytXbUh4K1B1QnF1bzJpOWFnMC9W?=
 =?iso-2022-jp?B?SmlZemRDYXFJSGVpd1FMSEZ1bWVyUHkzaGE3RE1JcU1vRk82a0QvRUNM?=
 =?iso-2022-jp?B?QmJ0YnNkcmNSdUdINE1GYTd3dUxqVElwdGRidk50aHN6UnNFRlJTRFhp?=
 =?iso-2022-jp?B?S1AxQzcxRUZNeG9HKzRMa2xGbVYxTVhzaUtCOWF2U1RvRmZSQW9Jeis4?=
 =?iso-2022-jp?B?LzdHNmMzRzErMVVSaklndWNVUTdOUWJ5NGNnMmZQRGQwME9CQkhWWXhJ?=
 =?iso-2022-jp?B?WlZzVDdKYUJHaFRyeDBqT041OGc0SG5JS0xCbkpJcE8vRlIzZ05BR3hH?=
 =?iso-2022-jp?B?N3N6M1pEdHV1OHdFNmRLVjhFWjYzdndrV05hS3JFanpQZmt1ek9IQktz?=
 =?iso-2022-jp?B?WDJHTStYampSMmsyaUZVQmJ6bXZNRFhGc1FrbzJiQmdqN2l2V3ByQnZP?=
 =?iso-2022-jp?B?cjN2M3FncWlXR0FwcFAyb1pzM2NxSjFvY3ZzRzBFMGxEQ08xbXI4czNP?=
 =?iso-2022-jp?B?ODRpTDczMVpUVENJeURHTE9uSTd3aWFYNEFQeUVodnY3RkNNM3J3cXY3?=
 =?iso-2022-jp?B?ZXFtb1htZ1dhNHRPVlN1QWpVYW9UNUJQV3VJYkpCcFpRUGxyc2p1RFI5?=
 =?iso-2022-jp?B?azhQMlVVZjEwT2JUbFA4RDhiUUJsVUcxL05NN0JUMkNmL1VJSG5hV1J6?=
 =?iso-2022-jp?B?cjZ2SDQxa21tMUFvVGYrYTJ3cHRyUWh0SzF3VGJyeFBPUXk2ZGJ2YldX?=
 =?iso-2022-jp?B?UVMrajVRaUlMOVdzLzBlWWxlN1J5NENEK0NrTmlIb1ozUWZVVmprOGc5?=
 =?iso-2022-jp?B?ZVJEeGR6Tk4zR3d6UFhzQXkzTms4MVJiSzNZZXNZWjJqMzA3ejh6aG1V?=
 =?iso-2022-jp?B?MEc5bGJlMkpvNEp4b2k0TkxFdkFVUkE0a3FqTWlJVUwxeUFYWXZVa2hX?=
 =?iso-2022-jp?B?ZnJacmxzV21HN0kxZTdKMGdBTVlHMEs2a1N0d3U5ZlhiaFVFU0YyeWpz?=
 =?iso-2022-jp?B?M0xyRDN6TzV3VWEyQk5MTGlqTDczT3VqVC9IbkhZVU9FWFVxd0J4QTJG?=
 =?iso-2022-jp?B?WTltN3ZpMGdxQThncEJiTnVZV3ltazFNRWl3NlViQ3VkbXp2K3VnbXpZ?=
 =?iso-2022-jp?B?WFJNZWpuZXZad3d4UlFpN2NxSTVxejQ0S3R0UHBpblBGUUlWSmpOTkJN?=
 =?iso-2022-jp?B?blRXM1RiVnFYR00yVnFWck11TE9wck0zMW1uSHdjNW8vV01CVVhjaVFv?=
 =?iso-2022-jp?B?VVdTQlI5OFRrc01Qbk1XcDhDa0NmUjh1aDlOK2UvVFVQMGhhZ1JvYWVi?=
 =?iso-2022-jp?B?bzJpVDREWVlCcUdhYjhNMTBiL0t4ZE40MTdqQ25MQnpVUkpMelZZeGdn?=
 =?iso-2022-jp?B?QXgxUmt3WDNUZmljSUdJVGNCK3d6RjdBcFZWbEdydXpaVjRuamVPSllm?=
 =?iso-2022-jp?B?M253SFJTc2wvNkFjcmlVbjJkQi9qVkJKa0lZZXAwazQzRXlsUUV5M1BM?=
 =?iso-2022-jp?B?OWpFT3VCdFJMbHB1dTk5dWFNdW9aZUtTN3JkNUVlNXc4QlNValA5TEdz?=
 =?iso-2022-jp?B?VENsRldTRFVWQ0NoWnRHdzJBRlBFeVFUWSt2ZzJqdC8xRGp1UjZuRzZt?=
 =?iso-2022-jp?B?V1lleFN0ZXk4U05YNTViT1NGS0t6UT09?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d14daa-67dc-42ef-c78a-08dba3a715e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 07:03:42.4673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 47hSON4cg/qKL+2uszHJJTkX9+02hkMQf9KNNMpQw1MjU6A6kVGSp2zkJVoOJVKEfp02I9qFIBUuRWqepOijsX7OQVmdPhFkmn5iPo5jw6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8596
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


> resctrl uses RFTYPE flags for creating resctrl directory structure.
>=20
> Definitions and directory structures are not documented. Add comments to
> improve the readability and help future additions.
>=20
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h | 58
> ++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index 2051179a3b91..b09e7abd1299 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -240,6 +240,64 @@ struct rdtgroup {
>=20
>  /*
>   * Define the file type flags for base and info directories.
> + *
> + * RESCTRL filesystem has two main components
> + *	a. info
> + *	b. base
> + *
> + * /sys/fs/resctrl/
> + *	|
> + *	--> info (Top level directory named "info". Contains files that
> + *	|	  provide details on control and monitoring resources.)
> + *	|
> + *	--> base (Root directory associated with default resource group
> + *		  as well as directories created by user for MON and CTRL
> + *		  groups. Contains files to interact with MON and CTRL
> + *		  groups.)
> + *
> + *	Note: resctrl uses flags for files, not for directories.
> + *	      Directories are created based on the resource type. Added
> + *	      directories below for better understanding.
> + *
> + *	info directory structure
> + *	------------------------------------------------------------------
> + *	--> RFTYPE_INFO
> + *	    directory: info
"directory" ->"Directory"

> + *		--> RFTYPE_TOP (Files in top level of info directory)
> + *		    File: last_cmd_status
> + *
> + *		--> RFTYPE_MON (Files for all monitoring resources)
> + *		    Directory: L3_MON
> + *		        Files: mon_features, num_rmids
> + *
> + *			--> RFTYPE_RES_CACHE (Files for cache monitoring
> resources)
> + *			    Directory: L3_MON
> + *			        Files: max_threshold_occupancy,
> + *			               mbm_total_bytes_config,
> + *			               mbm_local_bytes_config
> + *
> + *		--> RFTYPE_CTRL (Files for all control resources)
> + *		    Directories: L2, L3, MB, SMBA
> + *		           File: num_closids
> + *
> + *			--> RFTYPE_RES_CACHE (Files for cache control
> resources)
> + *			    Directories: L2, L3
> + *			          Files: bit_usage, cbm_mask,
> min_cbm_bits,
> + *			                 shareable_bits
> + *
> + *			--> RFTYPE_RES_MB (Files for memory control
> resources)
> + *			    Directories: MB, SMBA
> + *			          Files: bandwidth_gran, delay_linear,
> + *			                 min_bandwidth,
> thread_throttle_mode
> + *
> + *	base directory structure
> + *	------------------------------------------------------------------
> + *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
> + *	    Files: cpus, cpus_list, tasks
> + *
> + *		--> RFTYPE_CTRL (Files only for CTRL group)
> + *		    Files: mode, schemata, size
I think this is reinette's advice,
but "		--> RFTYPE_CTRL (Files only for CTRL group)" looks like a subdirecto=
ry.
Is this expected?

Best regards,
Shaopeng TAN

