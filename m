Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887C2765036
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjG0JrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjG0Jqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:46:49 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA110E0;
        Thu, 27 Jul 2023 02:46:44 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R9iXxx027205;
        Thu, 27 Jul 2023 05:46:34 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3s36ahwg7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 05:46:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNwtGbpqAyXsf6oAvqT7BNoSDtfGp8H6YtDSIhacebj67snNsGcFnxXSZHiX1Q15cEB0wYIxwZbSeDm+OtR8IMAScu/F3yZEiKetblyTB3RwFpfV8WJUMm95PRabPMiJtbBnzUzVWehZsQRtmO5BgOFEQJMVb5Aumuab2XKcHVFRe+g8krICCN9LGdFpXdVMwv8MtpNn5otVTPsl+0iThv6DUpJjKPUcykLVpkVpt8X6RWgcVJG1jllIUAbOQof6tU7YVvkJche49xheI0kaBqWHZ92Fr2CY8X/fAVXCGsBM09SYKFMuJXeAny89ZIV/fC6qusSs0BQCFW2UVxaKTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfgAugaYLf9xhZQwAisxi3z2w/Xc207Xyjjh1+UIotU=;
 b=FDFa3fiKw5PHP+MadQqCi63lOCQZfLIo1Bz46G1c+OizZ7wuFqE3FGtkX0PuElCf36cBKfjdz0Arj3j6RO6kNOpKH/jzrsiaypqNDHCEYAQ5CjjZIHx6ISBYoTFW4xlE3QVMcAYb7tWSzhTPKvhWictWzy4eXmTTgflYZXb62QqPfbaEhPGOQ8bWmPGRsKWa0E39sX0Mp1ac7O+KdwdSF2dVBGIBVrGptnd/ERPm7CJWmYxoQz/vk/sigcpfNZRw1M9+ofeBwAwEAfm8u3ExzCK0KL1cF2sDgBiYFsCuP+PfabCX8GPFQawMkYTjvvdZCzhHzVo8pk+RIRhcosyCNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfgAugaYLf9xhZQwAisxi3z2w/Xc207Xyjjh1+UIotU=;
 b=t4l8/E9CiWXNmXk+dFRnOnd/TMYH+2+vQ6G3QOhYsjWxWNvKoycakWEy+kzv5nY489ntuwnn8ztxdGEv5pFwBZfLCRmVhi0BoaxSYRDTZA0MQFb63I8eKM1riRoH9r/Sx90gImc4YH0sDE1RMMHwTrg5f46grRdbVX2iDMs4sCk=
Received: from BN7PR03MB4545.namprd03.prod.outlook.com (2603:10b6:408:e::31)
 by MW4PR03MB7009.namprd03.prod.outlook.com (2603:10b6:303:1a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 09:46:32 +0000
Received: from BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::9854:9bc0:ae2f:da]) by BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::9854:9bc0:ae2f:da%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 09:46:32 +0000
From:   "Balas, Eliza" <Eliza.Balas@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/2] Documentation: bindings: adi,axi-tdd.yaml: Add new
 TDD engine driver
Thread-Topic: [PATCH 1/2] Documentation: bindings: adi,axi-tdd.yaml: Add new
 TDD engine driver
Thread-Index: AQHZv5Bya5rUnb4ApEuNY3pox2mZkK/MYK6AgADm2UCAABJBgIAAAzFg
Date:   Thu, 27 Jul 2023 09:46:31 +0000
Message-ID: <BN7PR03MB454595EC3EABAEA5607BF1619701A@BN7PR03MB4545.namprd03.prod.outlook.com>
References: <20230726071103.12172-1-eliza.balas@analog.com>
 <61fce1da-c8dd-f911-e4bb-b2198612e7c6@linaro.org>
 <BN7PR03MB4545E574AB9886290115E5C89701A@BN7PR03MB4545.namprd03.prod.outlook.com>
 <ec964562-6ebb-e145-e850-0417a88077c2@linaro.org>
In-Reply-To: <ec964562-6ebb-e145-e850-0417a88077c2@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWldKaGJHRnpYR0Z3Y0dSaGRHRmNjbTloYldsdVoxd3dPV1E0TkRsaU5p?=
 =?utf-8?B?MHpNbVF6TFRSaE5EQXRPRFZsWlMwMllqZzBZbUV5T1dVek5XSmNiWE5uYzF4?=
 =?utf-8?B?dGMyY3ROelZqTURFM1ltVXRNbU0yTWkweE1XVmxMVGhrT1RRdE56UXdOR1l4?=
 =?utf-8?B?TlRjd05XWTNYR0Z0WlMxMFpYTjBYRGMxWXpBeE4ySm1MVEpqTmpJdE1URmxa?=
 =?utf-8?B?UzA0WkRrMExUYzBNRFJtTVRVM01EVm1OMkp2WkhrdWRIaDBJaUJ6ZWowaU9E?=
 =?utf-8?B?TTFPQ0lnZEQwaU1UTXpNelE1TWpRM09UQXdPVE0wTkRJMklpQm9QU0l5WlRS?=
 =?utf-8?B?bFlWVnFPVkJ0Y1ZCaWFETjNUVXQwWTFjeFprZ3daamc5SWlCcFpEMGlJaUJp?=
 =?utf-8?B?YkQwaU1DSWdZbTg5SWpFaUlHTnBQU0pqUVVGQlFVVlNTRlV4VWxOU1ZVWk9R?=
 =?utf-8?B?MmRWUVVGRmIwTkJRVUZoV1ZSTk5HSTRSRnBCVVM5aU5qWnlSRTEwVXpCRU9Y?=
 =?utf-8?B?WnljWE5OZVRGTVVVUkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlNFRkJRVUZFWVVGUlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UlVGQlVVRkNRVUZCUVhaa2FHdDRaMEZCUVVGQlFVRkJRVUZCUVVGQlFVbzBR?=
 =?utf-8?B?VUZCUW1oQlIxRkJZVkZDWmtGSVRVRmFVVUpxUVVoVlFXTm5RbXhCUmpoQlkw?=
 =?utf-8?B?RkNlVUZIT0VGaFowSnNRVWROUVdSQlFucEJSamhCV21kQ2FFRkhkMEZqZDBK?=
 =?utf-8?B?c1FVWTRRVnBuUW5aQlNFMUJZVkZDTUVGSGEwRmtaMEpzUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZGUVVGQlFVRkJRVUZCUVdk?=
 =?utf-8?B?QlFVRkJRVUZ1WjBGQlFVZEZRVnBCUW5CQlJqaEJZM2RDYkVGSFRVRmtVVUo1?=
 =?utf-8?B?UVVkVlFWaDNRbmRCU0VsQlluZENjVUZIVlVGWmQwSXdRVWhOUVZoM1FqQkJS?=
 =?utf-8?B?MnRCV2xGQ2VVRkVSVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlVVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVTkJRVUZCUVVGRFpVRkJRVUZaVVVKclFVZHJRVmgzUW5wQlIx?=
 =?utf-8?B?VkJXWGRDTVVGSVNVRmFVVUptUVVoQlFXTm5RblpCUjI5QldsRkNha0ZJVVVG?=
 =?utf-8?B?amQwSm1RVWhSUVdGUlFteEJTRWxCVFdkQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRa0ZCUVVGQlFVRkJRVUZKUVVGQlFVRkJRVDA5SWk4K1BDOXRaWFJo?=
 =?utf-8?B?UGc9PQ==?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR03MB4545:EE_|MW4PR03MB7009:EE_
x-ms-office365-filtering-correlation-id: f24a2050-7bfb-4988-a74a-08db8e865bca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KzJd4oi+CZ+20QhFqhdHEF1KBL/3bxvBKqfBHo/Z6Uuj9W8d5Vi7Q5fFh7lWx0B/V/Tg85uzyKMymA8ATgg1rLDRG6Ibr3O497SixNNMrJcRefAS1RNlbRWQ/V9sxEewIlwYg0XRD4t6oiO2iKUh2EBlV4er1TU1/IgP1XJRRauKMKvvM07D2QB6BZ3ktQfBKjw5+MSUK72aIV7+CZDORty1+OIjF9R2HQt2r+3OVfDBNX9d9CFM+RiOYGOBstFdYtMCWDIv5H6g/08gpnI8TYDFT3r8MbtIIYBX3+FG41Op8ATdA665k9P2clUvw5GhkiWE9hjtLAYVYDNQBurHt9GwZVQM6TOue7kPyMW+sqtc3Wwj5mABHbCqOZsZ0JjEKfOh50sXmk86ZeUw6S1WRBUmLifxPmS52CthmA6C2mbfg4/qx735jt3q7iribise1sscdo1qBhxvbM4t6HHwDNgS6N/LHBsoeF+NZ2q0DduTYOYFzRN977kadfFDTls3G7MF3Uz0RQGwDlh2se3MWYLDr9ThgoOmHZAzWv+XDNY4f94d2MUYwrnzxz2TGT19hoCE8v9nQMvHAYcp/5mtC9AvFD5FaxlOcWrGqBQwrL+OgiBl/ChwYYsqON2DV4gz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4545.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199021)(2906002)(66899021)(316002)(8936002)(8676002)(7416002)(52536014)(5660300002)(38070700005)(41300700001)(33656002)(55016003)(86362001)(7696005)(122000001)(71200400001)(54906003)(478600001)(26005)(6506007)(53546011)(186003)(9686003)(66946007)(76116006)(66556008)(83380400001)(38100700002)(66476007)(64756008)(66446008)(4326008)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmZlblBsemtUTkYzMmpFeldncmtuTUxGNXNqVTBPcUpNeU4vV1NKZ3p2bzNv?=
 =?utf-8?B?K2Zoa2dzTktVMHVvdHdPQzN6b28yZ3UwQ1l1S3pqS2l6NzQzVnplcER2eUxk?=
 =?utf-8?B?dVVlbkpVaEo4aGxhU2FoS09xMjB0akl5Zkl6UG5ZaEZBVGljNzhqYkd1UStC?=
 =?utf-8?B?MEhERStzQWtxWXJpdjJKNjFHdEh3d2RMT2RNWVUwNVJXY0w0aXBkZHRJc2hE?=
 =?utf-8?B?Rnl0SjF2TTlJQ1lJY2lZZkEwOUxpSVdPc3JJYUFXSE4vWmE1L0VUY2I0T1dv?=
 =?utf-8?B?bS8ydXNUYSs4akRtWlRibG5WajVUdWhmK1M1c3BGNi9Oei9uaHVoMHhwQWNZ?=
 =?utf-8?B?bnkrR3ZYSGM4TThWS1J2dEhHQzU2RHFINXl0UGw5UUJkZWF0dkNBZGs4bmY1?=
 =?utf-8?B?WFIrUGxQcXd0ZkRUaXAzY3FNdk9lR0l6R0NoRzNpNHhmMTh1NkZhb05JQmRx?=
 =?utf-8?B?VHVTUHdXSWR1VlcwQVlTSHlCalZVOWpCUXNCbUZZcm5leWFFQnY0UGNFdmpV?=
 =?utf-8?B?ZW5pTFVKdjFteTZYWHdBcVFVRVZyN0pLdENPaXZwWGx0T290OXVtQ0hGOFYw?=
 =?utf-8?B?K3NWWjlwNVBHdlN1MHZMRlg1TmlrQ0JUemhwcFptMGJZa2YxVXN5Sys1NTFo?=
 =?utf-8?B?cGovNG01U2o1bFBUY1Y3eHhCZWpSamw3amRLdHlaMzV6MXZmU1lzaS9HSTF5?=
 =?utf-8?B?NmpLQTJxVmNNN0NqeFJrQTNISXI5MjRRRkR1NUpCVTlkaWxtd1FJcnYzZXk3?=
 =?utf-8?B?QjZleENKNU9acjZWalNCUmdUZ3h3REFORzlVdGxzZTg3N0pIbmEwKzA2OWlR?=
 =?utf-8?B?SWJVN2tRalZyblN0MlFzS0hhcmFLYnpnWktTMmtmY1gvZDV5cDg2T0FQNSta?=
 =?utf-8?B?UGsrVjRISjBNb1RJRzZxMHI5N2hVZ1hrRi9USXVtRm00OXlra0RveGJmNVBl?=
 =?utf-8?B?TFdFMkxydGhnVDNNdjNSMXNURS94dTk4Tkc0NGtTTGhuKyszMnJqa2pYenVS?=
 =?utf-8?B?YjVMa0NweXZFZFdyWnBQbk9VeGVyQUoyU29PdCtxVzdIbXpicWRmQmZ4YTM5?=
 =?utf-8?B?NUhqNUVadkszSkRES3JuQ1haR1IwR2cybzhsSndZWUtUQVhTYzdQQVVjMS8w?=
 =?utf-8?B?SnVvTXdCcUxqdE5aaVpEUjk5NFl4Z290NW0vcExIenhEQUpGZDg5SURkeE9p?=
 =?utf-8?B?TDBIZ3kxMnZ4cWRudjdRSDUrU09kNWJoNjRqcHNRQTgrc2xIYnZ1YmtqR1B1?=
 =?utf-8?B?SXVDdFFyMmljUkFQdmppWFhUWisxSmdKb2h1OFI4Q3dGdjNOQ0RUaTAwTzVP?=
 =?utf-8?B?WURJbGNiVDA4cWE5akVVNVhHc0tEaXBML1pwY09LZmUrUk1uQTQ4VWF6akRU?=
 =?utf-8?B?Q3VjaFhKcmYvMVhsb1lKL2hIc1ZzL3UvR0F5bmZFb3JVdC9vV0NUTnRCWmhx?=
 =?utf-8?B?ZFdKeE0xNWJiWXREUHpTM2YzVFJzcmNWSzhEV05yTjR0SDYxV1VZZ05GQUJj?=
 =?utf-8?B?eXFmRm5rL0lia25OK2Q4b01VajJhWTR2VGdKejRUdUt4SXlDNTdGQlpSdEFx?=
 =?utf-8?B?eEpDL1E1K0paQkFiLzhxdE9oYWFBUUwwWlhzOFFSVyszc1ZwTlh0VEVmR0cy?=
 =?utf-8?B?RUZBNE41VS9yTHdyWWduQjkzWEhza01URW9ENmhjdytwUVJLN1lwZVphT0ZC?=
 =?utf-8?B?TlFQdjc5ejR0OC9xSnRuTytMaXIxN3FoclpSeVVpUzZFaGdhQmszdCt0S0Ew?=
 =?utf-8?B?OXpZS0tCQ2dJS0Z6RWhydHdLZ1RmVlZ2VGkvVDA0QTFEaUIyd3pOK2oyaHFK?=
 =?utf-8?B?L3ptandYdG9tUmFzNTZaSnlJanVsbW12ditIb3lqS2w5dVF5NDlGQS82UDE4?=
 =?utf-8?B?cUhhSS83TFpRREVLaWJudUtKejRzRmZVZS9tNTVxQ0NEQmNiMXo2ZGFlRE92?=
 =?utf-8?B?cXhzMEgvRmlxcnkyZHl6a3k2MU90KzBwWDU3R3h5TDQzOFFRRXRhbTFmbzlv?=
 =?utf-8?B?clFCYXNrSkt2elpJTEdBeXVBR1djbDRXeGc4cHFLQlhhZ1RKZVVPVU5WZFFw?=
 =?utf-8?B?RE1GVTVIVjFXVjAyK3VtSERaYW5tRHBhMyttTHp0Y3ozY2pUdUU4eXcyZlYz?=
 =?utf-8?Q?gSdq333Nhs6F6hF9EaVXkYq/R?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4545.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f24a2050-7bfb-4988-a74a-08db8e865bca
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 09:46:31.9318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: isrx48xWGTryab4YFozrkmAyR6u//emgvcNGVcCJXGqGaaTI/KDQJA3oig2sz0CDfULy+giF7Yqap9tYKeSExQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB7009
X-Proofpoint-ORIG-GUID: rDJVY1VxIHY4ae0rVYB0N6Pp5j1zy-be
X-Proofpoint-GUID: rDJVY1VxIHY4ae0rVYB0N6Pp5j1zy-be
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270086
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwg
SnVseSAyNywgMjAyMyAxMjoyNw0KPiBUbzogQmFsYXMsIEVsaXphIDxFbGl6YS5CYWxhc0BhbmFs
b2cuY29tPg0KPiBDYzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRv
ZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47IENvbm9yIERv
b2xleQ0KPiA8Y29ub3IrZHRAa2VybmVsLm9yZz47IERlcmVrIEtpZXJuYW4gPGRlcmVrLmtpZXJu
YW5AYW1kLmNvbT47IERyYWdhbiBDdmV0aWMgPGRyYWdhbi5jdmV0aWNAYW1kLmNvbT47IEFybmQg
QmVyZ21hbm4NCj4gPGFybmRAYXJuZGIuZGU+OyBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIERvY3VtZW50
YXRpb246IGJpbmRpbmdzOiBhZGksYXhpLXRkZC55YW1sOiBBZGQgbmV3IFRERCBlbmdpbmUgZHJp
dmVyDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiAyNy8wNy8yMDIzIDExOjA1LCBCYWxhcywg
RWxpemEgd3JvdGU6DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4g
RnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3Jn
Pg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMjYsIDIwMjMgMjE6MzUNCj4gPj4gVG86IEJh
bGFzLCBFbGl6YSA8RWxpemEuQmFsYXNAYW5hbG9nLmNvbT4NCj4gPj4gQ2M6IFJvYiBIZXJyaW5n
IDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296
bG93c2tpK2R0QGxpbmFyby5vcmc+OyBDb25vciBEb29sZXkNCj4gPj4gPGNvbm9yK2R0QGtlcm5l
bC5vcmc+OyBEZXJlayBLaWVybmFuIDxkZXJlay5raWVybmFuQGFtZC5jb20+OyBEcmFnYW4gQ3Zl
dGljIDxkcmFnYW4uY3ZldGljQGFtZC5jb20+OyBBcm5kIEJlcmdtYW5uDQo+ID4+IDxhcm5kQGFy
bmRiLmRlPjsgR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBEb2N1bWVudGF0aW9uOiBiaW5kaW5n
czogYWRpLGF4aS10ZGQueWFtbDogQWRkIG5ldyBUREQgZW5naW5lIGRyaXZlcg0KPiA+Pg0KPiA+
PiBbRXh0ZXJuYWxdDQo+ID4+DQo+ID4+IE9uIDI2LzA3LzIwMjMgMDk6MTEsIEVsaXphIEJhbGFz
IHdyb3RlOg0KPiA+Pj4gQWRkIGRldmljZSB0cmVlIGRvY3VtZW50YXRpb24gZm9yIHRoZSBBWEkg
VEREIENvcmUuDQo+ID4+PiBUaGUgZ2VuZXJpYyBUREQgY29udHJvbGxlciBpcyBpbiBlc3NlbmNl
IGEgd2F2ZWZvcm0gZ2VuZXJhdG9yIGNhcGFibGUNCj4gPj4+IG9mIGFkZHJlc3NpbmcgUkYgYXBw
bGljYXRpb25zIHdoaWNoIHJlcXVpcmUgVGltZSBEaXZpc2lvbiBEdXBsZXhpbmcsDQo+ID4+PiBh
cyB3ZWxsIGFzIGNvbnRyb2xsaW5nIG90aGVyIG1vZHVsZXMgb2YgZ2VuZXJhbCBhcHBsaWNhdGlv
bnMgdGhyb3VnaA0KPiA+Pj4gaXRzIGRlZGljYXRlZCAzMiBjaGFubmVsIG91dHB1dHMuDQo+ID4+
Pg0KPiA+Pj4gVGhlIHJlYXNvbiBvZiBjcmVhdGluZyB0aGUgZ2VuZXJpYyBUREQgY29udHJvbGxl
ciB3YXMgdG8gcmVkdWNlIHRoZQ0KPiA+Pj4gbmFtaW5nIGNvbmZ1c2lvbiBhcm91bmQgdGhlIGV4
aXN0aW5nIHJlcHVycG9zZWQgVEREIGNvcmUgYnVpbHQgZm9yDQo+ID4+PiBBRDkzNjEsIGFzIHdl
bGwgYXMgZXhwYW5kaW5nIGl0cyBudW1iZXIgb2Ygb3V0cHV0IGNoYW5uZWxzIGZvciBzeXN0ZW1z
DQo+ID4+PiB3aGljaCByZXF1aXJlIG1vcmUgdGhhbiBzaXggY29udHJvbGxpbmcgc2lnbmFscy4N
Cj4gPj4NCj4gPj4gUGxlYXNlIHVzZSBzdWJqZWN0IHByZWZpeGVzIG1hdGNoaW5nIHRoZSBzdWJz
eXN0ZW0uIFlvdSBjYW4gZ2V0IHRoZW0gZm9yIGV4YW1wbGUgd2l0aCBgZ2l0IGxvZyAtLW9uZWxp
bmUgLS0gRElSRUNUT1JZX09SX0ZJTEVgDQo+IG9uDQo+ID4+IHRoZSBkaXJlY3RvcnkgeW91ciBw
YXRjaCBpcyB0b3VjaGluZy4NCj4gPj4NCj4gPj4gU3ViamVjdDogZHJvcCBkcml2ZXIuIEJpbmRp
bmdzIGFyZSBmb3IgaGFyZHdhcmUsIG5vdCBkcml2ZXJzLi4uIHVubGVzcyBkcml2ZXIgaXMgaGVy
ZSBhIGhhcmR3YXJlIHRlcm0/DQo+ID4NCj4gPiBJdCBpcyBub3QgYSBoYXJkd2FyZSB0ZXJtIGlu
IHRoaXMgY2FzZSwgSSB3aWxsIG1ha2UgdGhlIGNoYW5nZXMuDQo+ID4NCj4gPj4+DQo+ID4+PiBT
aWduZWQtb2ZmLWJ5OiBFbGl6YSBCYWxhcyA8ZWxpemEuYmFsYXNAYW5hbG9nLmNvbT4NCj4gPj4+
IC0tLQ0KPiA+Pj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21pc2MvYWRpLGF4aS10ZGQueWFt
bCB8IDUxICsrKysrKysrKysrKysrKysrKysNCj4gPj4+ICBNQUlOVEFJTkVSUyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgNyArKysNCj4gPj4+ICAyIGZpbGVzIGNoYW5nZWQs
IDU4IGluc2VydGlvbnMoKykNCj4gPj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPj4+IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9taXNjL2FkaSxheGktdGRkLnlhbWwNCj4gPj4+
DQo+ID4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21p
c2MvYWRpLGF4aS10ZGQueWFtbA0KPiA+Pj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWlzYy9hZGksYXhpLXRkZC55YW1sDQo+ID4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiA+Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi4xODk0YzFjMzRkNGYNCj4gPj4+IC0tLSAvZGV2L251
bGwNCj4gPj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9taXNjL2Fk
aSxheGktdGRkLnlhbWwNCj4gPj4NCj4gPj4gV2h5IGlzIHRoaXMgaW4gbWlzYz8gTm8gc3VpdGFi
bGUgZGlyZWN0b3J5Pw0KPiA+DQo+ID4gSSBjaG9zZSBtaXNjIGJlY2F1c2UgSSBkb24ndCBrbm93
IHdoZXJlIGl0IHNob3VsZCBmaXQsIEkgZGlkIG5vdCBmaW5kIGEgc3VpdGFibGUNCj4gPiBzdWJz
eXN0ZW0gdG8gaW5jbHVkZSB0aGlzIGRyaXZlciBiZWNhdXNlIHRoaXMgaXMgYSBkcml2ZXIgZm9y
IGFuIEZQR0EgSVAgY29yZS4NCj4gPiBEbyB5b3UgaGF2ZSBhbiBpZGVhIHdoZXJlIEkgc2hvdWxk
IHB1dCBpdD8NCj4gDQo+IERpcmVjdG9yeSBiYXNlZCBvbiB3aGF0IHRoaXMgZGV2aWNlIGRvZXMu
IFdoZXRoZXIgc29tZSBkZXZpY2UgaXMNCj4gaW1wbGVtZW50ZWQgYXMgRlBHQSBjb3JlIG9yIGRl
ZGljYXRlZCBjaXJjdWl0cnksIGl0IGRvZXMgbm90IG1hdHRlci4gRmV3DQo+IFRpbWUgRGl2aXNp
b24gTXVsdGlwbGV4aW5nIGRldmljZXMgYXJlIHJlbGF0ZWQgdG8gYXVkaW8sIHNvIHRoZXkgYXJl
IGluDQo+IHNvdW5kLiBJIGRvbid0IGtub3cgaWYgVEREIGlzIHNvbWV0aGluZyBlbHNlIHRoYW4g
VERNLiBJZiBub3RoaW5nIGZpdHMsDQo+IGNhbiBiZSBtaXNjLCBidXQgYWdhaW4gLSBqdXN0IGJl
Y2F1c2UgZGV2aWNlIGRvZXMgbm8gZml0LCBub3QgdGhlIGRyaXZlcnMuDQoNClRoaXMgZGV2aWNl
IHJlc2VtYmxlcyBhIGJpdCB3aXRoIGFuIElJTyBkZXZpY2UgKHdlIGFyZSBkZWFsaW5nIHdpdGgg
Y2hhbm5lbHMgYW5kIHRoZQ0Kc3lzZnMgaW50ZXJmYWNlIGZvbGxvd3MgdGhlIElJTyBzcGVjaWZp
Y2F0aW9uKSwgYnV0IGlzIG5vdCByZWdpc3RlcmVkIGludG8gdGhlIElJTyBkZXZpY2UgdHJlZSwg
DQphbmQgZG9lcyBub3QgcmVseSBvbiBJSU8ga2VybmVsIEFQSXMuIA0KRG8geW91IHRoaW5rIHRo
aXMgZGV2aWNlIGlzIGEgYmV0dGVyIGZpdCBpbnRvIHRoZSBJSU8gc3Vic3lzdGVtPw0KDQpUaGFu
ayB5b3UsDQpFbGl6YQ0K
