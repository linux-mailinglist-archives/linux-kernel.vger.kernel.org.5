Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCFF805B99
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442466AbjLEPwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346359AbjLEPwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:52:43 -0500
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FADFC0;
        Tue,  5 Dec 2023 07:52:49 -0800 (PST)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B5CESYN023007;
        Tue, 5 Dec 2023 10:52:27 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3usf31w8ju-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 10:52:26 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PO/Fa+oVp8Oif5Atm9vgLynS0UJgChu6TLTT6JC+foFL+LyzBaCxROaJXSei8arpBxDmJk93fEZ+x33AqObD0FswXBm9ls/3Zq/3MT/kI/8Mr3iH1NTyOjLogke5NRoMml8EtpaUkrec2S07QBUUMoCsbgCmfToxXrsEtH+O+tUr1JuiEjLajB3YnKCiTYDu673lh+5QEWAVLcCNdPxFCe+TcCm0gQ3d0l6lGnvnw1WmWy9W12C92DRNZ2+8O2hR55jJFOxeL7r6PfqzL11D8q4RHHrwC7ZEwLfczhDu6ipNjFjn3EjgFQsq7GIn8R2FvRuzHqRK151TujIuBsB9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezwjGDMg2U2KdOFp8U1teNTmKYO8/8WIrE3K2+HjCOo=;
 b=Kdf9sJusp8sEQlzyLF8dEbyer5OF72UhXHjHmAWjNGBTUlG0oWWm7S4ZGwjctJWiAoyUklsM6vATJcJy7jH3Pf3QFuXI2mzmo76UXQl3toozXN2MKYlnPFkpRGML5r1yThkIvRDSBnYJLJGAKNbLAr9XfqB8HpKU+p/MYW2j2REpfTQAD7FUeFP576PChujlnbJtqT04QX8Pzb7wclX6d5nIdBnFdpxYajJar/A8v8HZsgSHQFqZCx64Up7Yy6zY9wv1moo7ug4NSOZrigDrpfUI6YgfbV+JGd4oPOHrgj8HNE6pe7Scji4M/yy7QmtTu/IsiluL5ic9Po5h2SdL1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezwjGDMg2U2KdOFp8U1teNTmKYO8/8WIrE3K2+HjCOo=;
 b=7dOflhlXoajis521PGHC/8DpBachz595hOeYjOlJg6v110/2N8r7NYoly8rmYp6wE7C0bKfoLOSLECkoMvk60QrbXUhyNF6yYEO7X3DnrXQSFRylaYm6z8PixBcAgJaXK6B1iwD4vqsypFKFD/hPV8YeL/5vIKzfKj/54BhpVOQ=
Received: from SN7PR03MB7132.namprd03.prod.outlook.com (2603:10b6:806:352::6)
 by PH0PR03MB5927.namprd03.prod.outlook.com (2603:10b6:510:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Tue, 5 Dec
 2023 15:52:23 +0000
Received: from SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::9d8b:27cd:e980:436d]) by SN7PR03MB7132.namprd03.prod.outlook.com
 ([fe80::9d8b:27cd:e980:436d%4]) with mapi id 15.20.7068.022; Tue, 5 Dec 2023
 15:52:23 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        David Lechner <dlechner@baylibre.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
CC:     Mark Brown <broonie@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH 0/9] spi: axi-spi-engine: improvements round 2
Thread-Topic: [PATCH 0/9] spi: axi-spi-engine: improvements round 2
Thread-Index: AQHaJtg8HjaBxjuI6UmEcM8C0ySmRbCazR2AgAALD0A=
Date:   Tue, 5 Dec 2023 15:52:23 +0000
Message-ID: <SN7PR03MB71326BC0EFF84E8D889599238E85A@SN7PR03MB7132.namprd03.prod.outlook.com>
References: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
 <c029f2e5d49d8640fed59639224296e3479682aa.camel@gmail.com>
In-Reply-To: <c029f2e5d49d8640fed59639224296e3479682aa.camel@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYldobGJtNWxjbWxjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTAwTlRJeFl6RmhaUzA1TXpnMkxURXhaV1V0WWpnMVpDMWlZMll4?=
 =?utf-8?B?TnpGak5EYzJNVGxjWVcxbExYUmxjM1JjTkRVeU1XTXhZakF0T1RNNE5pMHhN?=
 =?utf-8?B?V1ZsTFdJNE5XUXRZbU5tTVRjeFl6UTNOakU1WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STJNekl5SWlCMFBTSXhNek0wTmpJMk5URTBNRE0wTkRRM01UTWlJR2c5SW5s?=
 =?utf-8?B?WFkxZEhRM0Y2TDJSUmVHMXZUVlI1WlhSalNXTk5NR0pCUVQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUkhCSllUaElhM2xtWVVGa2FEWTVjWFJ0UVdSbVRE?=
 =?utf-8?B?Skljakp4TWxsQ01UaHpSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQmJFZFVSMVpuUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2FFRkhVVUZoVVVKbVFVaE5RVnBSUW1wQlNGVkJZMmRDYkVGR09F?=
 =?utf-8?B?RmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpFRkNla0ZHT0VGYVowSm9RVWQzUVdO?=
 =?utf-8?B?M1FteEJSamhCV21kQ2RrRklUVUZoVVVJd1FVZHJRV1JuUW14QlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMFZCV2tGQ2NFRkdPRUZqZDBKc1FVZE5RV1JS?=
 =?utf-8?B?UW5sQlIxVkJXSGRDZDBGSVNVRmlkMEp4UVVkVlFWbDNRakJCU0UxQldIZENN?=
 =?utf-8?B?RUZIYTBGYVVVSjVRVVJGUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZsUlFtdEJSMnRCV0hkQ2Vr?=
 =?utf-8?B?RkhWVUZaZDBJeFFVaEpRVnBSUW1aQlNFRkJZMmRDZGtGSGIwRmFVVUpxUVVo?=
 =?utf-8?B?UlFXTjNRbVpCU0ZGQllWRkNiRUZJU1VGTlowRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUFQwaUx6NDhMMjFs?=
 =?utf-8?Q?dGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR03MB7132:EE_|PH0PR03MB5927:EE_
x-ms-office365-filtering-correlation-id: 0fdb1436-9caf-4723-1478-08dbf5aa2c07
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LRvJ1SbpdcDGBeb7R/ZTFSqxQd2XAoS/V/X363dQXasMM7hYemP12KkhFfRlWAvvFzzzRZ72Lu3BhhHmjaHUGQJQUc7IlAD1YYDV8geYGOr75LV/nhBvd2HD/fn8vWLVQmE1yBYrgtz8b9MnaVzm6X61lnpig+c1/XehX32oXCReISwXX1KfY/PY+qJ3RdAZem9Z1XN/dDXnz7S6lNrFaWiUXkv0I0bl0RPjIvRp+veZHoRbxuDjUDgzZYz+nlU58kMPc9TmcZ2ZcgESdvxr3szDMzHfBtY+Ya3XfZgDPxQYVfEv8VitSKxzASFEcSDI+x8O6cu5UD22l6Nvee/OH6TDv0Qhe4zFD7s4Ie69Cpx2FMmA3+Z+UUpNVb6xUeUHQjwraWiD7T0Bm8dula+Z5zQ513Vc4H7VgqAyT2h9fNsF6UyIcyc04988vuNhTigK2iACZXmegkkPAC5qyKkQPwWcNzpA8MtsrgeGaJmZ1sGg14CrpaF/0pc0NCMgqVBVpwAa9Mq6K5PtQESFLkgCtzFR274gPCeFUjYFAFhfYZHSu4pDHObk8VdKDMvCOsuUOOswC0gxWWJxc2FB/DS8cJk0RgVvKFSarMNsYlVCTcvD9XLtz0Z05ho8qIXfL6WTGuD9cF0+NVyvBJgZ6H0Qow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR03MB7132.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66946007)(66556008)(64756008)(66476007)(316002)(4326008)(52536014)(54906003)(66446008)(8676002)(8936002)(86362001)(966005)(76116006)(110136005)(478600001)(38070700009)(5660300002)(2906002)(41300700001)(33656002)(122000001)(38100700002)(26005)(6506007)(9686003)(7696005)(71200400001)(53546011)(83380400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmRENFRNV0E0VHJUcDI1QzFLY2xrNGROdnVteU9JcnVoV1RKdml2MUYvOUdy?=
 =?utf-8?B?TG03cjFOd2lqcGdMQlN5Nmtmc21ZVzcvK25ScWxna21FZjNhRXRuem5wUXVY?=
 =?utf-8?B?ckNBd21ISnVmdmFQUDNJZEQ1cjJBUnJyQkd3b1hYNzJVSGVCa09ueERxM1pv?=
 =?utf-8?B?WjUxQTNBL1JEeit0YU9qbmI5NVRxMGpERUIvSG81SkkwcURiSG5NTFF0QzVM?=
 =?utf-8?B?K1Y2MmFVRElFTUxoTURMOTYyMDBBdUJiaDQvbzBVeDJTakRNclpHTWdzYm12?=
 =?utf-8?B?K01oQW9BRkpjakJGVlVtMHN3bUdIQWo1OTZuOGlqcm5GZTZ1RTBHU1lhOU1G?=
 =?utf-8?B?MStSaFhocHBNNmlpMkF5MXpIWlRXVyszTzBxbEdZS2xYWXhod1plUHU4THFX?=
 =?utf-8?B?SWlkUmwvUTV0VjhYWHpxWXlSNXFnQURCTURwSlhoWmJqZEF4SEM5bi8xL1BN?=
 =?utf-8?B?aDJCN1o0ZVJRTU12ZTEwOFdVbEJXdVdGak0zdDd2Y2JpaGxhalRjZ2pDWGlj?=
 =?utf-8?B?UGZTTldWMW4vSlhEdzRncjhGUE9aS09sY3hXM1N4TmMvUzI3eEdjbXh4SUdq?=
 =?utf-8?B?WTNlZGVsWVBFWWRDZVJGYW96bC9CZE5lRGZCUm1CQkxqMHJqRG9aQlRJWFlq?=
 =?utf-8?B?NFZURys5dkZDa01oWmdMbmFhbGJ5c2twVHo3TVJYTXBjNURtNWdOM25uK2FX?=
 =?utf-8?B?VWtVSVpDaENrWWFZVU15VnNDVGxRYURRTm83SUhka0ZDaHIycENVQ1ZHR2xs?=
 =?utf-8?B?VEdGT0l1b3dvY0E0a2kyeXZpSitNazMySzJoTHgyOGlTRnA2SVF2QjF1cnZU?=
 =?utf-8?B?eHBTYlVYL3E2cFgzNDhzMkEycC9ITXZ2YVgvYW9PWFRaSmV6YU1VYnpoT09K?=
 =?utf-8?B?MkhYNGg1UG0wN0tNZFB3eFFza1V1eGhacDRldHdqY1k1Y2VQTEhVR0xWak5E?=
 =?utf-8?B?SXlBYzF0ZlRwdXl6ZERiTXFYKzk5OU1XbFRiSkVycjdvTnRWTVFycUJ0WURi?=
 =?utf-8?B?VmZ3cWN4cGRxVlJUSlhLZHUyMU9TeVVtUjhpa0FEaThiZXkzbEpvSk93OHNr?=
 =?utf-8?B?Y29FSEg2emhhT1R0eTc4Vk9PWlVDZlhKUFozdC9QVzR1czJkdEN6RW5jVmpa?=
 =?utf-8?B?enNGYkhCeU9LcnliYUZCQmtJcXE0WjV3dk9wM0EwRU5MUWpxajZKUUtSSnRo?=
 =?utf-8?B?RlRFdlJzTTkyRkhYNS9qeGdEMGVIYjM4d0dmcmxIaFVuRUJsb2xSdzdCNkVx?=
 =?utf-8?B?a0V3dWpxbjVlTHBIOXJ2cGRLWHowUm91NWJKTVM2dE95ZWhjK0NzYUhFbWtK?=
 =?utf-8?B?TmVYZ2U5VzhCUThwakhUY0NtRGNRcmRlMmlRbmg5bHJCZkNXazNDZ2lvbCtK?=
 =?utf-8?B?emcwQjczTTNXM3FtampsSDVjVThvaVo5eHVTNHUvZ1UzTTdyVXFqZkV5eUhF?=
 =?utf-8?B?bXZHL1M0MjBwT2g2WHczWVJ0TTRYbGkxd0NiYzcxM3UyUUNvNEdwRkE0cWxp?=
 =?utf-8?B?d1dCMmhGaHZhczFNQXlLV2dXRE93SlZtVGRlQnBDa0g5bmJRSzgxLzNHQ1h2?=
 =?utf-8?B?NldINHRVbGlUelY4MXFzaHc1M1ZSSmVIOUhoZ3A3dVVCRUkzVnFVaG8wTFRK?=
 =?utf-8?B?Z1pXS3cxdjYrb3NMNXNUSG1ZNThEWFBXZEViNm5UTUFoMEpISE9ydUtBK1l5?=
 =?utf-8?B?a3hsV0QrcWlrM0Y3MVQ1WnJ6L1Z0Y3lRc3loV2tzM3JkYUd1Wm5qMklxeUJF?=
 =?utf-8?B?eUdpcWQrRVZyNUEzMnFBZ1RjOGwrb2RoUWRrT1A2OGNxTUdONnU3b0RBaDZi?=
 =?utf-8?B?RVM3OE15MjIyVkk5cTFJbVpjWDR3ckw1Z2p5YTBUTG9hNUhtMFJvdVFEbnB3?=
 =?utf-8?B?emJOMmFVMmpqamh2L1ptMHROWCtiNmZmNmQxTlU3OXZhSnk5TTNOUkdlYnB2?=
 =?utf-8?B?azM2UGVCSkl6WmFXaDVvL0NpcHFZQWdlQTF6SlpKVDNseFpZRk1jaUlIaTUw?=
 =?utf-8?B?ZUJ4cXI3cUJYbFlIZXpuUFM2cWpHaHNXYnhxT2g3emoweUVkVGxvcWE4aWxz?=
 =?utf-8?B?NU1TU3oxbk5hY2dmK0QzYTZ5VkVaYm02blFYQXJTMG9JT215N3RBb2IvQXlO?=
 =?utf-8?B?NmpEOUljT2ZIZ1FVd1JaeDBCRE0wb3owYWNCeDNPZWRqOXM3bDRDclFhVnpZ?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR03MB7132.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdb1436-9caf-4723-1478-08dbf5aa2c07
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 15:52:23.4412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRSHLELiLr44tpLTrO9kQBGLwveGtxp21uIp+U66zTswdxFyktEayTc1l9YHTJDUWBxtOM0UFyHw2IjjJqpNc3uy6k1kdzcjwrdwdEkz0hU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5927
X-Proofpoint-GUID: mHWx4zYHNYnwJE1Du0MyndJauMcfgnhJ
X-Proofpoint-ORIG-GUID: mHWx4zYHNYnwJE1Du0MyndJauMcfgnhJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2312050124
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTnVubyBTw6EgPG5vbmFt
ZS5udW5vQGdtYWlsLmNvbT4NCj4gU2VudDogRGllbnN0YWcsIDUuIERlemVtYmVyIDIwMjMgMTY6
MTINCj4gVG86IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT47IGxpbnV4LXNw
aUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47
IEhlbm5lcmljaCwgTWljaGFlbA0KPiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IFNh
LCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggMC85XSBzcGk6IGF4aS1zcGktZW5naW5lOiBpbXByb3ZlbWVudHMgcm91bmQgMg0K
PiANCj4gDQo+IE9uIE1vbiwgMjAyMy0xMi0wNCBhdCAxMTozMyAtMDYwMCwgRGF2aWQgTGVjaG5l
ciB3cm90ZToNCj4gPiBXZSBhcmUgd29ya2luZyB0b3dhcmRzIGFkZGluZyBzdXBwb3J0IGZvciB0
aGUgb2ZmbG9hZCBmZWF0dXJlIFsxXSBvZg0KPiA+IHRoZSBBWEkgU1BJIEVuZ2luZSBJUCBjb3Jl
LiBCZWZvcmUgd2UgY2FuIGRvIHRoYXQsIHdlIHdhbnQgdG8gbWFrZQ0KPiA+IHNvbWUgZ2VuZXJh
bCBmaXhlcyBhbmQgaW1wcm92ZW1lbnRzIHRvIHRoZSBkcml2ZXIuIEluIG9yZGVyIHRvIGF2b2lk
IGENCj4gPiBnaWFudCBzZXJpZXMgd2l0aCAzNSsgcGF0Y2hlcywgd2UgYXJlIHNwbGl0dGluZyB0
aGlzIHVwIGludG8gYSBmZXcNCj4gPiBzbWFsbGVyIHNlcmllcy4NCj4gPg0KPiA+IFRoaXMgaXMg
YSBjb250aW51YXRpb24gb2YgdGhlIHdvcmsgc3RhcnRlZCBpbiBbMl0gd2hpY2ggaGFzIGJlZW4N
Cj4gPiBhcHBsaWVkIHRvIHNwaS9mb3ItNi44IFszXS4gVGhpcyBzZXJpZXMgbXVzdCBiZSBhcHBs
aWVkIG9uIHRvcCBvZiB0aGF0DQo+ID4gc2VyaWVzIHRvIGFwcGx5IGNsZWFubHkuDQo+ID4NCj4g
PiBPbmNlIHRoaXMgc2VyaWVzIGlzIGFwcGxpZWQsIHdlIHdpbGwgZm9sbG93IHVwIHdpdGggdGhl
IDNyZCBzZXJpZXMNCj4gPiB0aGF0IGltcGxlbWVudHMgdGhlIG9mZmxvYWQgc3VwcG9ydC4gVGhl
IG9mZmxvYWQgc3VwcG9ydCB3aWxsIGFsc28NCj4gPiBpbnZvbHZlIHRoZSBJSU8gc3Vic3lzdGVt
IChhIG5ldyBJSU8gZHJpdmVyIHdpbGwgZGVwZW5kIG9uIHRoZSBuZXcgU1BJDQo+ID4gb2ZmbG9h
ZCBmZWF0dXJlKSwgc28gSSdtIG1lbnRpb25pbmcgdGhpcyBub3cgaW4gY2FzZSB3ZSB3YW50IHRv
IGRvDQo+ID4gYW55dGhpbmcgYWhlYWQgb2YgdGltZSB0byBwcmVwYXJlIGZvciB0aGF0IChlLmcu
IHB1dHRpbmcgYWxsIG9mIHRoZXNlDQo+ID4gY2hhbmdlcyBvbiBhIHNlcGFyYXRlIGJyYW5jaCku
DQo+ID4NCj4gPiBbMV06DQo+ID4gaHR0cHM6Ly93aWtpLmFuYWxvZy5jb20vcmVzb3VyY2VzL2Zw
Z2EvcGVyaXBoZXJhbHMvc3BpX2VuZ2luZS9vZmZsb2FkDQo+ID4gWzJdOg0KPiA+IGh0dHBzOi8v
dXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1zcGkvMjAy
MzExMTcNCj4gPiAtYXhpLXNwaS1lbmdpbmUtc2VyaWVzLTEtdjEtMC1jYzU5ZGI5OTliODdAYmF5
bGlicmUuY29tL19fOyEhQTNOaThDUzB5DQo+ID4NCj4gMlkhNFA4eDBQbFVhY2h5dmVvdEtuakRs
NzZsOWxjQm01SHZHZ1pWWEFmc2EyNmZIdlRYWjdDdm1xMmx0X1pQUDU4DQo+IG5QaEoNCj4gPiBL
X3NHTzU2ZzQ4ZGVVV2xjRFNzWThxZyQNCj4gPiBbM106DQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNl
LmNvbS92My9fX2h0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZQ0KPiA+
IGwvZ2l0L2Jyb29uaWUvc3BpLmdpdC9sb2cvP2g9Zm9yLTYuOF9fOyEhQTNOaThDUzB5MlkhNFA4
eDBQbFVhY2h5dmVvdEsNCj4gPg0KPiBuakRsNzZsOWxjQm01SHZHZ1pWWEFmc2EyNmZIdlRYWjdD
dm1xMmx0X1pQUDU4blBoSktfc0dPNTZnNDhkZVUNCj4gV2xmd3pzbg0KPiA+IFBKdyQNCj4gPg0K
PiA+IC0tLQ0KPiANCj4gQWNrZWQtYnk6IE51bm8gU2EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCkFj
a2VkLWJ5OiBNaWNoYWVsIEhlbm5lcmljaCA8bWljaGFlbC5oZW5uZXJpY2hAYW5hbG9nLmNvbT4N
Cg0KPiANCj4gPiBEYXZpZCBMZWNobmVyICg5KToNCj4gPiDCoMKgwqDCoMKgIHNwaTogYXhpLXNw
aS1lbmdpbmU6IHJldHVybiB2b2lkIGZyb20NCj4gPiBzcGlfZW5naW5lX2NvbXBpbGVfbWVzc2Fn
ZSgpDQo+ID4gwqDCoMKgwqDCoCBzcGk6IGF4aS1zcGktZW5naW5lOiBwb3B1bGF0ZSB4ZmVyLT5l
ZmZlY3RpdmVfc3BlZWRfaHoNCj4gPiDCoMKgwqDCoMKgIHNwaTogYXhpLXNwaS1lbmdpbmU6IHJl
bW92ZSBzcGlfZW5naW5lX2dldF9jbGtfZGl2KCkNCj4gPiDCoMKgwqDCoMKgIHNwaTogYXhpLXNw
aS1lbmdpbmU6IGZpeCBzbGVlcCB0aWNrcyBjYWxjdWxhdGlvbg0KPiA+IMKgwqDCoMKgwqAgc3Bp
OiBheGktc3BpLWVuZ2luZTogcmVtb3ZlIHhmZXIgYXJnIGZyb20gc3BpX2VuZ2luZV9nZW5fc2xl
ZXAoKQ0KPiA+IMKgwqDCoMKgwqAgc3BpOiBheGktc3BpLWVuZ2luZTogaW1wbGVtZW50IHhmZXIt
PmNzX2NoYW5nZV9kZWxheQ0KPiA+IMKgwqDCoMKgwqAgc3BpOiBheGktc3BpLWVuZ2luZTogcmVz
dG9yZSBjbGtkaXYgYXQgZW5kIG9mIG1lc3NhZ2UNCj4gPiDCoMKgwqDCoMKgIHNwaTogYXhpLXNw
aS1lbmdpbmU6IHJlbW92ZSBkZWxheSBmcm9tIENTIGFzc2VydGlvbg0KPiA+IMKgwqDCoMKgwqAg
c3BpOiBheGktc3BpLWVuZ2luZTogYWRkIHdhdGNoZG9nIHRpbWVyDQo+ID4NCj4gPiDCoGRyaXZl
cnMvc3BpL3NwaS1heGktc3BpLWVuZ2luZS5jIHwgMTE2DQo+ID4gKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNzcgaW5zZXJ0aW9u
cygrKSwgMzkgZGVsZXRpb25zKC0pDQo+ID4gLS0tDQo+ID4gYmFzZS1jb21taXQ6IDhlNmE0Mzk2
MWYyNGNmODQxZDNjMGQxOTk1MjFkMGIyODRkOTQ4YjkNCj4gPiBjaGFuZ2UtaWQ6IDIwMjMxMTI5
LWF4aS1zcGktZW5naW5lLXNlcmllcy0yLTVmMGE2MDUzZGVhMA0KDQo=
