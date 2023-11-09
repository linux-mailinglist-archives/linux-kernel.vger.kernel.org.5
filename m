Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F347E669B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbjKIJXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKIJX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:23:29 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8547C2590;
        Thu,  9 Nov 2023 01:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699521807; x=1731057807;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VxOFDI3RCvmqmQbxlZ/g2STTCgKKpUvOy73CUTzRYZQ=;
  b=KPp708rfXessUjFFGFPYRT4gLxpvtqrFKRHz3EcDNHrScHims8Gwi7f1
   uKJMyDesSGKUvR4GwMKazWASAHQgSePbutt3fj+OEKHldTR8/P7M7XQ14
   7HLUKTaD0J1O2IA7rE1IWPpNobJhYk5pQc2gdHRRlpmP2Uxs4oO29jjjK
   tjAcEFTBVjzwuwUDftYuJS97cBUnOGXGyjNY7/eMsxlGkKZhkkWVov4X/
   oDdfnXPNMFRDmllunOKfTlfk/kdcnuTGxWD32T6VD6BE8kYU29CwOIktR
   DUZbpUBaLuyRaWsGkB/UJfIeidnooRQIhnFdhlwNWcFNcJPXBk4G5u3vh
   w==;
X-CSE-ConnectionGUID: IQopS8AFSU2PLORTXlV2nQ==
X-CSE-MsgGUID: rpftuLjRSBqXcRB9P4n2hg==
X-IronPort-AV: E=Sophos;i="6.03,289,1694707200"; 
   d="scan'208";a="1804486"
Received: from mail-bn8nam04lp2040.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.40])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2023 17:23:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5/whUuDKvKWr4eLp5CrUNUo7bQOnUhE+tRAU7pjHmVmRx+h0z+jFTcTuELPHC3m268BH9K74plItuTeR26M9k4UYYHYDUVbBGrhHV/HSRBLGS7v3u1RP3v5iRTnnPkv0zgeWOOf6u9wesGexC1RUwRrMZbIhHYcv6vdcevabpORyJdQEKnP4RcuSLb024ZpeYzfZO4vY/w0ydL0P+ffOnW3BijPnTsbbDo10nIaxcG3a63e60uOwRDOZ1wJvxd2ljcer0Bljxyv8T/xvnkk8hRZe1jqjtZWes2I73b1/8ZPBTreCBOiUGFBiviQV/0uPQX9LAYS0pOtZnu0y/FcLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxOFDI3RCvmqmQbxlZ/g2STTCgKKpUvOy73CUTzRYZQ=;
 b=XnbxKm2ZpUjLZCujbApuuP5umoyx0IpupjxbkkB3Kg/EPlG7whqgKYKtQvd9GOUmHrSKeJoEeiiEB4lrbYAEz6pAybMk3qCNAd5m1cr6wDB4MPeZUKRd3k7hXw/0rt3NcliHS9aboNxJ3NiRGjxoop6ggNE3Rx1+SfGb4Dngze5VEvA/1NKCYIwSwgSyDAfFivQQWQnSlmHTcq5Xs2oJ2HYL/+9SFp5jwlp+OkzE67ipOako/SJOf2G2bKIcE7S405GbyItyzdnBfuBqsgrKFljhhNDEX3kn21qR5h158ySTs5Ln1xU99wvvJeg0jH2+Nlupdtdfc01VKseGQC8puA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxOFDI3RCvmqmQbxlZ/g2STTCgKKpUvOy73CUTzRYZQ=;
 b=KGLZzt4jr+DlSnzFF2T05PlyDTDL03Da1abfDPID8m/wGz8pKVz3a1zlFn5u+CocCkW5x2sDT4ETGAlu5/k+R5Rs0H/I1wXlct6VUyMG+GIbYTjhkS4q8hSDJkLLluaCNgGJu7COVUThIg0+/u/DKnE0Hf+8DuRUD1PNw4blPPA=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BY5PR04MB6341.namprd04.prod.outlook.com (2603:10b6:a03:1e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 09:23:21 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2975:deb1:a373:b88]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2975:deb1:a373:b88%3]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 09:23:21 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?utf-8?B?S29ybmVsIER1bMSZYmE=?= <korneld@chromium.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Bhavya Kapoor <b-kapoor@ti.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Thierry Reding <thierry.reding@gmail.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 6/6] mmc: cqhci: Fix task clearing in CQE error
 recovery
Thread-Topic: [PATCH V2 6/6] mmc: cqhci: Fix task clearing in CQE error
 recovery
Thread-Index: AQHaDjLbsPJaY0gql0ub23vpQExvTLBxv74A
Date:   Thu, 9 Nov 2023 09:23:21 +0000
Message-ID: <DM6PR04MB657552F7D128772D104E3780FCAFA@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231103084720.6886-1-adrian.hunter@intel.com>
 <20231103084720.6886-7-adrian.hunter@intel.com>
In-Reply-To: <20231103084720.6886-7-adrian.hunter@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BY5PR04MB6341:EE_
x-ms-office365-filtering-correlation-id: bb2781e3-b6e5-4596-35fa-08dbe105845c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LFL0nkoQPwkraQ2/lCTqbEEVOhzCJm7RiHR2BRwTwsjSg5c+8ysVO5Pet+iuuaVgdB2C2SYM34O5SU/tJjIvm+SwVVa3eWuFcLQfHwf3brsdiXZXOGW2nyzzpvacw9yVHsUTnewf4xYHk3FpEQAtC5HAxpxz29RlMQgtWB+7vHmN/zmBQw9TtDhSbNUPjpP+U33WvRYQo1dmj0Vk2/9GbgjdHbbVQmBJMNQ5tSLdrryMvYrZ+P9cKi3op5TEEPbrLibJpYMSo3lGdSqWmOqCBGUKYW6IGeP8TIf+jiZJibVRjYGiKSyNQcU1HJ4GFQdxRJ3vrqhyz8TfwmifLHc7fRr+9ddKszaAMw7rXIEZTBHQ8IlobBn4wPPPIw41881kYAG6iiIXvx3gT4eVN1NHs6+oeMMsELSxE2dhobGF70+ABiuGASXOB9A26nceHPkI+fMYDclNyLEb7KUD/gbiPLK1ipIOS6WAHW2R+CyIQOu2foa4BotEnQWO2z3YtwN8VJS4KOEDS9PkDIfexCFzvXJqUT2uyl0CXADzJhmGrNYoMf+eYU8rL5nG8SSGQms7LUELSUmmRqcNEm6BfkiQgUmxU5bRrZK0uBUHNgKiL3PHH7awrTlTCec/iN9fTY8yUPKW0oDb1y1e/rxannFgWkMNH73/lECzYfU6qVWrJJw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(7696005)(64756008)(66556008)(66946007)(76116006)(316002)(33656002)(478600001)(66476007)(66446008)(54906003)(110136005)(9686003)(26005)(52536014)(66574015)(38070700009)(8936002)(4326008)(83380400001)(8676002)(38100700002)(55016003)(5660300002)(86362001)(2906002)(41300700001)(7416002)(122000001)(71200400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHkrV2lOZFdYQmJpK2dZZ0lIbktwd0gvWnFuYnJZY0Q3dHQxb1FUQjZVeUsz?=
 =?utf-8?B?eE1kSTFHWjNyNEtEbHFoTkFwaVI4dDh5THV6MUxiTG1YdW11bGxLSlFMcEFU?=
 =?utf-8?B?YXh1L3ppYWZnaFFjV2szVSszcFRKTVgzbjlVckVSRTRVRjVsUjNvb0V2Q040?=
 =?utf-8?B?SnBLRHgxYnhMK2c2VU5Nb1J1a3U5QXJMNm12RTlsdFdjTFpQc0xHT0dWWWNi?=
 =?utf-8?B?U08xQkNXcm12NHB6UkV6KzFpY21ZYUh0NENtcEg1U2VLU0R3ZXh6anRxcm80?=
 =?utf-8?B?SzJqZkdCZHZnUmcyK2tUQm1sZTRiYmxHQ3BqdDFja0tmemNOUHZYTDJHNEdR?=
 =?utf-8?B?K2p1VTM3UC91bndrSHB6dWhra0lLREo3YkhjZ0lSaWVPSUpSY2d1SS9MQjJu?=
 =?utf-8?B?NFVvTEZyTldDdlg1bTEySzErNHd6cHl2ZHFnKzZIOGF2ZlV5RVBRNU9WU1ov?=
 =?utf-8?B?cGFmM0tteDFzVksyOUpyRHVackJYY24wVDNKUFVLbWZ3NWNadXljYVlYUVNx?=
 =?utf-8?B?QUtXNzRTYW5UMnc2WTV6M01TNHhaUWhoRmtDUjFDU2RpR3RDMk1XWnc2OGJu?=
 =?utf-8?B?Mk9UNnRHdy92dGMybU9BZmpsVDNPbjY0b0taWlZwWXl2bWl1NTQ3WmxJc0pW?=
 =?utf-8?B?eW9GakNMRXpFditsNHNtcFFNZUptRU5DdENqbmtDcWlVWFQvc3lCdEdseDJr?=
 =?utf-8?B?TE9qVEk0MkE2Zk9sdVRxWmZVd08wbklUaFJQeWwyRnVjamp5d0RFMnVvSjdD?=
 =?utf-8?B?ajZPQ1lkVmN0WW1icjRXNjRibjFNWG1UUXlkL2h6WVU3c3hOcW90RDdyeWdD?=
 =?utf-8?B?WXM2UEF0V3BRSFNKazRyNkJJa3k2bWhYYjd1NDZkVTZIb005V0djUkdCVEtV?=
 =?utf-8?B?eFVLMlVFWnNod0JMbmNSeG5mbldrbCtuOVFmVWdHQnZuY2ZtcDF3TEppcWx5?=
 =?utf-8?B?cWo3Y0hCR2lpZUZrTGNNQmtBK012MTIzejAxYjBqK3RLNUtSOU9OUmJtZ0dC?=
 =?utf-8?B?UW1BeXlWTWY3YnNSdXhtKzFGZ0g5RFFqbjVwZS9penBCOWJJNjZITGJNMk9P?=
 =?utf-8?B?eTYxS01kUDN0S3U5MVdvL1RLUUN6MzdMUEhYdkFjRVZPL2RWVjkzY1NpNkJQ?=
 =?utf-8?B?N05yV05vR25VSFR0Wi9lbEJEUVU1N0RHZnViL0txSlF1a2NVM1hYbkxYVWMz?=
 =?utf-8?B?MkI5YllOWnBld3J6SjFSbklTUERhdk1BdWZYZFJsekttL3F6bGdFZTg1aXdj?=
 =?utf-8?B?RmRPbGxtelBHQWw2b0tsRk45YW1pMkZmV3VKL1ArN2h5MFJzcy95enFoemFW?=
 =?utf-8?B?OXRzS2lNNERNNEFqd0V0bjRXWXhVSDM4MUowcGk1ZkhLSXVvait2L1kybldw?=
 =?utf-8?B?THVjMDZFSlphUW1GWmdsd1AwOVVDbkRKalhFTEpvb052T2ZrZnlQbWRuVHRm?=
 =?utf-8?B?V3FGdUlWbGdNTWtKaFUyMjg3RTcvajNVTUNvc3lyOUJVcGgzK1o1Mkh1UlFi?=
 =?utf-8?B?SG9lc0hTNmxNVjZGS09nd0szSklrUFg2TlJLdTkzWHA2ZUswbWdXVGdONUgw?=
 =?utf-8?B?cFNvMWllc3d5Mlh5MUJsMURJbXRrRkVuaWp3OE1NelBXYWxhbHY0b21Mbjho?=
 =?utf-8?B?RjhoNkJqNDR3ZXJVNmhpTStiU3NQcy9QRVdoTFRQU1FYK3dwMitReWtqNktz?=
 =?utf-8?B?THdYclNtdjF3ZUlRQUZ0VWFJb2tMR0VHYkt5MkNmd21SN1FxeGc2VitOUVQx?=
 =?utf-8?B?eGNhT3VsSURXTDloQ3VvU3kwYTRnU1FacjBTNWU0TS83YWNyL2RiN0NNVHpN?=
 =?utf-8?B?T3hMUDRHaVRtMmNKTmMzK0F5OGFkZkoxSVc2RFZOdkNwZCtnMzhuVDZoQklr?=
 =?utf-8?B?WEdXWGZpRVluQVM3b3lid2k5YmVjdUlobm5OZDFIeW84WnpZUE5sRDk0V0Vi?=
 =?utf-8?B?Q1poYzJwNDM2VzJlOGdOQ0prQlAzaDhSanRGSjlVYzBjVEkxQnl0ODBpL2h1?=
 =?utf-8?B?QlAzQ0RoVXpHWEprMEhkUGNSa09qZHJ2ZVFRNUZVbFNvNXppL3lCWm9YaGJz?=
 =?utf-8?B?aWtKakJQYkpNMnBoSjl0Q2NRQkJYNjd1OGFkQVZZeGRjRkE4QUlpUkxiUWFT?=
 =?utf-8?Q?c61wx4QCdM93c1iUvxl0dzOLf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cldqMnNuNG5iREsxRVNNZXk1aGJXTytjcE9oNzY0Y0d5MDNCdVRtZHF3WXVC?=
 =?utf-8?B?c3dvZ3kveFlYVThKZ1ZtQlRmSjVyckhqVDFlRnczL01lT2JYRHdFajRkU2d1?=
 =?utf-8?B?OE1kQkFwTkxoY0I5dDJ1VVcwYXRnbFJ6bTVoTG5aTHkrdjBuWTE2YXZMSmMx?=
 =?utf-8?B?aVdGcjlDM2RwSU1pSVIyeFFFN1I4Q2lUeHJTNmhRTXdDVVd6Y2o1ZU5lbUN0?=
 =?utf-8?B?Q0RiYXNLZDNzSEc0VDZ3Y29YSGw3Z08vaG1HOTl5eTBOUTZUakJhWk9yUVpW?=
 =?utf-8?B?OTJnT0daaUJtYjdEb2tkWnBFdnlmUTlKMlJlSjVETm9FZ1FZU2VwbU5wRTdP?=
 =?utf-8?B?aDcwREtOcnc1R2lBTHI4enZvc20rMVhQaFYxUWlVc0V4eC8zbnFJQlhCbDNI?=
 =?utf-8?B?SThBQUF0aXkvMkxUb05DSlJVRmxvNjJ1b0c2ZFloa1c2Q1ZQRldrWmRnY1Fq?=
 =?utf-8?B?Zkdpcmhjd0hiM2hwblhObjRQaEQzUjlVTkQ3eXp0WkpJemNva1UzZUFLdVlw?=
 =?utf-8?B?QzRyeXNtWnY2T1hZRFdIZGw5Rk5xUjQrWWFaWTVoZDVLL3lUc1Vid3IzZU1C?=
 =?utf-8?B?clVHWSs0TUFLd0t6a3I4ZXpZTTNYN25vQ3YwWHZjR1crcmtvOGMyelRYY3Zh?=
 =?utf-8?B?ZnJlOUhZcmpBeXQ2eGNTZENYTjNuMnZVY1RtSnI5MnNoUXYzdE92V1docEo0?=
 =?utf-8?B?bktuV21ielRJY0dDbWlZdE5aVkhLQ0h4N29hTG5PZTJWRnhQdlM4WmtxMmZL?=
 =?utf-8?B?U0xiaUhxL2wrOGE3eTlqTzBoWW11dVJKaEVRYnVQTGF6c0NFazF6UXgwRVRv?=
 =?utf-8?B?S0ExZTVYbjdXNTZzekNtUW5DR0FDbTVaeFlRZ1A2OEhNOFUvdUVZejhxSWVw?=
 =?utf-8?B?NlowOWZDMVFFeGZIT1I1MmZsMnFtajRoUGVOdVFVaW91N09SK0lRdGsvSUM2?=
 =?utf-8?B?d3NpMm9WWHJ0c2oxVHYyY3l4U2FvNEQzMExva3ZtSXNwM3UvVE8vSFh5QTJX?=
 =?utf-8?B?STkzUFpPY1J1UWx4THd1NlVHMWVzMWRRZW10UnVaOUtnZE9pQklLNlF5M2t0?=
 =?utf-8?B?S2NlWVJIbnR3ZHpja0NaQWFDWGdFUi9NRC8xbldTVG1kalVCOE5qbGkyY2wy?=
 =?utf-8?B?eWdDYzBYUG9aY0ZpYXRjSUpOaDl4WGRDL3RFT0x0ckQ0NEtPMzJLWVdVa2Jy?=
 =?utf-8?B?K3hJSGxIM0xpVk1KQkR6TjdVNVpXcWk3VWp2NFEzQWJ3NzBpNGwreGxLd2RH?=
 =?utf-8?B?ajdHdGU5NjlQMStwNEVEYVVkNDVKeFpMclhNUldXTy8yZ002YXdlQVJ4aVZ1?=
 =?utf-8?B?QXg3NSthQlN1M01SNWlFZVE1WmtTb1JzL09nRWxETGVaMmhUeGpicEREeXg1?=
 =?utf-8?B?cmxhMWREMFNjTFN0U0pJdmVtQ01vSXEwSHppSnhFdm10NmpkZFNnS2Z1K1Fl?=
 =?utf-8?B?NmZjaGk5NHZLTW9sWjZQdFQ0VGFxSWtxZ0NkZHdXVUZ4d0tSbStIbUxocDJF?=
 =?utf-8?B?K2JHKzV0Y09KN0NsaVhxSkV2bENVY2RIN1ZMMkRlMnBucTZBUGJrTEpNbVdP?=
 =?utf-8?Q?CDOhWKtzZoevd7Mc7RI+fouCo=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2781e3-b6e5-4596-35fa-08dbe105845c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 09:23:21.4724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j28knb6WSKDInDKxYB3885xh1CPslAohkXfHPk4VSeL3kVKrsVFTDBw3kK3Hl0E+hXtkxic9i5n+eXUz8TlbmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6341
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJZiBhIHRhc2sgY29tcGxldGlvbiBub3RpZmljYXRpb24gKFRDTikgaXMgcmVjZWl2ZWQgd2hl
biB0aGVyZSBpcyBubw0KPiBvdXRzdGFuZGluZyB0YXNrLCB0aGUgY3FoY2kgZHJpdmVyIGlzc3Vl
cyBhICJzcHVyaW91cyBUQ04iIHdhcm5pbmcuIFRoaXMgd2FzDQo+IG9ic2VydmVkIHRvIGhhcHBl
biByaWdodCBhZnRlciBDUUUgZXJyb3IgcmVjb3ZlcnkuDQo+IA0KPiBXaGVuIGFuIGVycm9yIGlu
dGVycnVwdCBpcyByZWNlaXZlZCB0aGUgZHJpdmVyIHJ1bnMgcmVjb3ZlcnkgbG9naWMuDQo+IEl0
IGhhbHRzIHRoZSBjb250cm9sbGVyLCBjbGVhcnMgYWxsIHBlbmRpbmcgdGFza3MsIGFuZCB0aGVu
IHJlLWVuYWJsZXMgaXQuIE9uDQo+IHNvbWUgcGxhdGZvcm1zLCBsaWtlIEludGVsIEphc3BlciBM
YWtlLCBhIHN0YWxlIHRhc2sgY29tcGxldGlvbiBldmVudCB3YXMNCj4gb2JzZXJ2ZWQsIHJlZ2Fy
ZGxlc3Mgb2YgdGhlIENRSENJX0NMRUFSX0FMTF9UQVNLUyBiaXQgYmVpbmcgc2V0Lg0KPiANCj4g
VGhpcyByZXN1bHRzIGluIGVpdGhlcjoNCj4gYSkgU3B1cmlvdXMgVEMgY29tcGxldGlvbiBldmVu
dCBmb3IgYW4gZW1wdHkgc2xvdC4NCj4gYikgQ29ycnVwdGVkIGRhdGEgYmVpbmcgcGFzc2VkIHVw
IHRoZSBzdGFjaywgYXMgYSByZXN1bHQgb2YgcHJlbWF0dXJlDQo+ICAgIGNvbXBsZXRpb24gZm9y
IGEgbmV3bHkgYWRkZWQgdGFzay4NCj4gDQo+IFJhdGhlciB0aGFuIGFkZCBhIHF1aXJrIGZvciBh
ZmZlY3RlZCBjb250cm9sbGVycywgZW5zdXJlIHRhc2tzIGFyZSBjbGVhcmVkIGJ5DQo+IHRvZ2ds
aW5nIENRSENJX0VOQUJMRSwgd2hpY2ggd291bGQgaGFwcGVuIGFueXdheSBpZg0KPiBjcWhjaV9j
bGVhcl9hbGxfdGFza3MoKSB0aW1lZCBvdXQuIFRoaXMgaXMgc2ltcGxlciBhbmQgc2hvdWxkIGJl
IHNhZmUgYW5kDQo+IGVmZmVjdGl2ZSBmb3IgYWxsIGNvbnRyb2xsZXJzLg0KPiANCj4gRml4ZXM6
IGE0MDgwMjI1ZjUxZCAoIm1tYzogY3FoY2k6IHN1cHBvcnQgZm9yIGNvbW1hbmQgcXVldWUgZW5h
YmxlZA0KPiBob3N0IikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gUmVwb3J0ZWQt
Ynk6IEtvcm5lbCBEdWzEmWJhIDxrb3JuZWxkQGNocm9taXVtLm9yZz4NCj4gVGVzdGVkLWJ5OiBL
b3JuZWwgRHVsxJliYSA8a29ybmVsZEBjaHJvbWl1bS5vcmc+DQo+IENvLWRldmVsb3BlZC1ieTog
S29ybmVsIER1bMSZYmEgPGtvcm5lbGRAY2hyb21pdW0ub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBL
b3JuZWwgRHVsxJliYSA8a29ybmVsZEBjaHJvbWl1bS5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IEFk
cmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPg0KUmV2aWV3ZWQtYnk6IEF2cmkg
QWx0bWFuIDxhdnJpLmFsdG1hbkB3ZGMuY29tPg0K
