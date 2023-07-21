Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6ED75BFFF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjGUHlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjGUHlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:41:50 -0400
Received: from mx-relay06-hz2.antispameurope.com (mx-relay06-hz2.antispameurope.com [83.246.65.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD53519AD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:41:47 -0700 (PDT)
Received: from mail-vi1eur02lp2047.outbound.protection.outlook.com ([104.47.11.47]) by mx-relay06-hz2.antispameurope.com;
 Fri, 21 Jul 2023 09:41:43 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwn3o2qdDen/iRUWXw1X2k41maIy2rBPlGOSkkD9Kh+9XWtbXHKhlUWfZ5Sp5OGR+TV68VM7nHbpkMD5BOejTHpJ9bX/pyKuyHy8NswT8yj1RqnfzNgqnCX/QjEOZWFlcbvRVJM1FibkQLAKEM5KSKdM1WFCGr0q+fdG4hU/ADofYu4xPoQri9nOAe8/gKjXzAuMGxEbK85uQvG8PE+y21IEnl8qRqSt04dz4gQHGJjg0aQ3xnqNDlgHt4ScIePPd6TeYDi+0RKh0D2mBO4XvHLUREjZLE1+gCpaecfjWf7eEVREHCRbj35fQC7AMWK4Aahn/P3e5+8bNq61TLCbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YF5/fWNdN9ZBQ/fKeM8ToqDjzzA42X8YZdWgP2wZcUQ=;
 b=VXpq6yHo8s3qntZDE4pgUcr2uAZrW/uivEwjiCDuG00mIoOmIatPt2hPBgtbEKWde4tWB/dc7i+Waa1+2b4FcrTE5GuTJpM/iKWFa+F32iL7n4RR8Bqkpue6fjqCOKUIZKQYu0yYQvGZddWd6MbFfpfu9YWRjAfASCqrSnKXnr6xFpRVwUtD2MHRBfuPoOueEQMrY3jzJ4nfclIODUx1sYoCAJ94y7Y63rpy6JsryGQTIvnkf3RIyBMsQHcfS5K+wMrbofpBmFz9mE09jRucWdA8gCbokZTJmwdQaBUF/3OCe9MHDIIt+VSRAucYGshQrHGuxZT+ZJzmHGCTb7tD6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YF5/fWNdN9ZBQ/fKeM8ToqDjzzA42X8YZdWgP2wZcUQ=;
 b=SxvFfNLtXUOusJzUxK6978auqWtfi7VUekaielmFzHw7aupEIFUKdH++yHU2RRTF3GYyyadZmFHdBNdvqt15E4ycYNhgN7YLwZNolMBr4Ehhzom9bUC1inqsad/6qDAKfaX+ItA+c9J+HZ0ybtNOfqO7V1+gVmtY4AFbUsWDDYw=
Received: from DU0PR10MB7436.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:424::5)
 by PAXPR10MB5326.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 07:41:36 +0000
Received: from DU0PR10MB7436.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8775:67dc:1840:d08d]) by DU0PR10MB7436.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8775:67dc:1840:d08d%7]) with mapi id 15.20.6609.022; Fri, 21 Jul 2023
 07:41:36 +0000
From:   "Wurm, Stephan" <Stephan.Wurm@a-eberle.de>
To:     Richard Weinberger <richard@nod.at>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Eigner, Johannes" <Johannes.Eigner@a-eberle.de>
Subject: Re: ubiblock: null pointer dereference using scatterlist in
 work_queue
Thread-Topic: ubiblock: null pointer dereference using scatterlist in
 work_queue
Thread-Index: Adm7pscvu2D2rn9ILU6HQJ01hwLDiQ==
Date:   Fri, 21 Jul 2023 07:41:36 +0000
Message-ID: <ZLo2rpBa+MiHaIR1@PC-LX-Wurm>
References: <ZLT2qEYjaWgSpRD6@PC-LX-Wurm>
 <736980270.3262.1689586950735.JavaMail.zimbra@nod.at>
 <ZLUXruUkYMrPK+GQ@PC-LX-Wurm>
 <260741266.3681.1689591789332.JavaMail.zimbra@nod.at>
 <ZLVWfrlEOWT1twpr@PC-LX-Wurm>
 <1006337471.13025.1689777115644.JavaMail.zimbra@nod.at>
 <ZLf1dqe1DUhfXQ4R@PC-LX-Wurm>
In-Reply-To: <ZLf1dqe1DUhfXQ4R@PC-LX-Wurm>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: FR0P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::17) To DU0PR10MB7436.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:424::5)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB7436:EE_|PAXPR10MB5326:EE_
x-ms-office365-filtering-correlation-id: 6021c27f-3f71-45a1-bc30-08db89bde9ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zU8tc7lXJuJFPkhqKoi3xIZNt0F828WhZ0BPgjp+UlQ3AHgSSClv+sn/NH/AYfdNGRblrE9jL6Th6CN+Q0CePGP47U6OU3JsTflndFX6Y/Vjj6QlbG51KmHBJIPQM4S9hmQZRY6rhUlWSEVikaghTPFaOeefaEkJD3LR7FD814VvEGnUAVpKmMWFryLl+x1ctDEqHMeAF06FFtobGBLa8a0/Ubv37E2k3uOzxqcQBKtPYE05LuxZeHwVOVqfa27fth9QRJvl70Je0woCuy8Lbqm3UUUKFfXSSRw0u1iEs2+JPr73ihI2WE8HiqtBIKE6KMy9P9nEZFBftoydN9ZdZUDsOG+KOxeI4CItykK09FSekfyNP4vfOXnzNm9cdtFr3DaIkjlyHb3IenLLet4wLuaIi802gpgBKSAYEGR9UzZjXdeA51EXNhfclJbPo18+MWPoeZLclGgCnUZZ/dEhblrgBTp9A+ybUrJ2+UCrlJKP+/SKiCMlYf5vY24gpaVoWZeoln9FZpvLuAP3iFv9NLeIUxe5mjJnCVnuIWn6F8mP2ZUr/Ju1AXoN9jF9YPv78aD6tAasX0o/y8mgaR0XlXBG/wcY7oewVWrpxOYjwVk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB7436.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39840400004)(346002)(376002)(396003)(366004)(451199021)(83380400001)(71200400001)(6512007)(9686003)(6486002)(66574015)(122000001)(6506007)(26005)(186003)(107886003)(54906003)(316002)(4326008)(478600001)(33716001)(6916009)(86362001)(2906002)(38100700002)(64756008)(66446008)(66476007)(66556008)(66946007)(8676002)(8936002)(41300700001)(5660300002)(67856001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHBjVHlPN0JqUTFyRFNVcmR0aFRmMWhEajNwa1ZTQW8xdk1hdDY0RW5rTU5j?=
 =?utf-8?B?cXZIOEk3enlLL0hpV3RpeFd3eXV3SkNKNUdDNWpmVU9KY0RXRnpTL09pdE1o?=
 =?utf-8?B?MXdFTnFXcjFvUXBqTmNrTWpaN2dQOURDMndhcXo5YzFQWlNrMWZuVEdtWklo?=
 =?utf-8?B?c0ZWenBEZEcwdlkvT1NzY25SNlQ1Nmc2aFJUOS9wMDlBQ1dZL1BjTzJxcnpk?=
 =?utf-8?B?K0NEOHp3OFd5Wk5WaDJkVGkyREZLVDFwZDVEWjVOdHJ2K09Bb29aRlY1ZFJE?=
 =?utf-8?B?eFNUQVFSdWJOUFY4dG9aSU82KzFJZnVnRnhwblR5ekZXdnpqdE91Q3dEdTc2?=
 =?utf-8?B?UzNwczVVbUt2OWxNOXpiSGtQS3JWbnREV25KWFo0WUNEM1R1QWIvVEFRUCt6?=
 =?utf-8?B?b0ZFaEs4WHRMbzdVY01HSldOWE9mZ3FXRit1R2gxYkttWEVGYldZRTJjNmJG?=
 =?utf-8?B?SGRkRTF1UGhZajF0VENGWTVJWjczazJ1QzdEVWhkelV2NTk5d3ZuaWZwS0Fl?=
 =?utf-8?B?MDRhZlc2T0RtUlRLWkVxRGN5UzhTbGZEU3lPaVVXalIrcnZ5bGl5NVk2dUlZ?=
 =?utf-8?B?aWlpNkdrQndOOVpOYVBWcVdGT1VZVUo5bVVENCt6QkMvOHEweVlHS0lLVGw2?=
 =?utf-8?B?bmVVTlZYbEVsaXhLc1pRU0FiQTROUmpQY2ZvdEVmMDlpZEJybkltNlV6MlVX?=
 =?utf-8?B?WlFQdnBqNFpzTDBnOGJLM1pXekxJUExwQ1hpMWdWNnVDNmlDcjR4Tm4xdnla?=
 =?utf-8?B?TURBTEo0U0tKUlVjNjJIMEhxU0c4eG5kZzREeDNrTVliZXJIQjZBYlJ3ekpH?=
 =?utf-8?B?QnJDNkFPbkd4Q0tmd1BiZCtrclZ3b2J5L2lldkszeTFid1BYOHFEYStMM2RX?=
 =?utf-8?B?MFNoOHZXSkkwVWg0dzBYNjlJUWJTUkh5eDcxZU5yVlM5MllrS3VXd1d2NHpX?=
 =?utf-8?B?MlhISzZKRVlWUmtFcjJ0UWcycGt0cVZnNFJwZzJZUHRQTCtNQWJYdTJsNzRJ?=
 =?utf-8?B?TkNnaHNvTi9OSHFiQ1VDc2pFUUhmMmJNK05RTUN5VUV3S0t3L0FsQ3JReEd0?=
 =?utf-8?B?U3FMVVZuOHhmUnFYemJuR1ZsSGo1RUFsZnJZamQweEJLUEpyd2FEYW1mMStr?=
 =?utf-8?B?M3JibnhIQm1jS0ZYSnAwV0VmbmpMa210bDBoMXVBZW15NEMxUEs1RG1PVTZk?=
 =?utf-8?B?ekFKSFJvZlFNZ3JKQm1McmdZTExLU3lkNlBpRkZEak45c0RlYmx0UTNSMGhZ?=
 =?utf-8?B?QXB0UmhIdDlna2M4WVBUQW0xS0FSWnZSelh0aFNkclB1Sko2Z1pSK29sMW1s?=
 =?utf-8?B?ZWVvaWdreUFnaTVicDF6OEtFYlJWS2tDTll0d3VFR09JMll3a3pTMTRWbkxR?=
 =?utf-8?B?b1BLQkQvWXVhZkU3N1NkSHFnMllQakx2SU4vQ0o3VEwwNW1FVExDQ2tUc2ly?=
 =?utf-8?B?SWVMNjdERXlXL3lRZnJUdWFhZkJFRVAybkkrbjZJRzIxcCs5cmtCZ3Fyelh0?=
 =?utf-8?B?QmpnaXdaSmk1dHNNQlhIc1pOUURpd0twaHZtaE14VVhGbnRROE1LRU9URDJM?=
 =?utf-8?B?M0loblhRWStLTXpuOXpLd2p3NWE3R25PWUM3cFhra1RnYzRiV21FaUhqU1hP?=
 =?utf-8?B?ZmRaTGlkNXpUYUN4K3RTalQ5VDJ5SWZxbmo2OE9JVXlFbGJ3N011eGgybEFE?=
 =?utf-8?B?STJDRlNVMFp1bTFXUXFhVDFseGpYRzBsb21keW4zRlJBOUVTOWZUR2p4QXFH?=
 =?utf-8?B?OThpcW84UWtJc1hTMVdYb2g1ck5KM0k3SUd0NkJuV0hQdTk1RCs2bHVWalZQ?=
 =?utf-8?B?MXFVdStTZjNQa1F6N1RKci9xcWNaNjRGd2pCU2RNN0F1bFVvWUxhOVVwZzk2?=
 =?utf-8?B?c2RnUTVHZnBhWk1UQzlQVk1nbjcvd2lxZmswWnNlRnl0Wjdid3Y2VXVPQjR1?=
 =?utf-8?B?TGk0cCt4eCtSbW9KSmhPdWp5U0xFeVhKMDcreG5CTnUwSWJWQUN3dlUzdyt2?=
 =?utf-8?B?dXFRY2tCWEtNZmdJbHV3UHdJWnpLaHJvN09BRnpUb3orOWtRNXFWUXVYZHEz?=
 =?utf-8?B?ZmJad2dhTFkvT2I5L3NkQkVCN2FCSGxXNzJmbFNYNlRCNDFFckN4RTZwM3Uy?=
 =?utf-8?B?SDMwaldWRVpIUG5RQVU4UnR4M2JVVER1YWU0a2hLanllV2prR083MmpiQnV3?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5937BAF18D4BCB438C6519A3F7008535@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB7436.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6021c27f-3f71-45a1-bc30-08db89bde9ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 07:41:36.5091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3QHbuoWHiC3PsDglcFdMbn/J0p/+zmsqIOD1l2xNANFUIV9RbuncQsHaJda+1pL9k0R0BlXiArUFaIEbDA2/hoaq+kMLRgq1+HlSz+qYCD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5326
X-cloud-security-sender: stephan.wurm@a-eberle.de
X-cloud-security-recipient: linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: stephan.wurm@a-eberle.de
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay06-hz2.antispameurope.com with 7524E540180
X-cloud-security-connect: mail-vi1eur02lp2047.outbound.protection.outlook.com[104.47.11.47], TLS=1, IP=104.47.11.47
X-cloud-security-Digest: 584f7d930d1c8af2781acd6daf9b782b
X-cloud-security: scantime:2.299
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMTkuMDcuMjAyMyB1bSAxNjozOCBoYXQgU3RlcGhhbiBXdXJtIGdlc2NocmllYmVuOg0KPiBB
bSAxOS4wNy4yMDIzIHVtIDE2OjMxIGhhdCBSaWNoYXJkIFdlaW5iZXJnZXIgZ2VzY2hyaWViZW46
DQo+ID4gLS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQ0KPiA+ID4gVm9uOiAiU3RlcGhh
biBXdXJtIiA8c3RlcGhhbi53dXJtQGEtZWJlcmxlLmRlPg0KPiA+ID4+ID4gV2UgZGlkIG5vdCBj
aGVjayBvdGhlciBzdGFja2VkIGRldmljZXMsIGJ1dCB3ZSdsbCBnaXZlIHRoaXMgYSB0cnkuDQo+
ID4NCj4gPiBEaWQgeW91IGZpbmQgdGhlIHRpbWUgdG8gY2hlY2sgd2l0aCBkbWNyeXB0Pw0KPiBV
bmZvcnR1bmF0ZWx5IG5vdC4gSSBhbSBzdGlsbCBwcmVwYXJpbmcgdGhpcyBhbmQgSSBkbyBub3Qg
aGF2ZSBhY2Nlc3Mgb24NCj4gdGhlIGhhcmR3YXJlIHVudGlsIEZyaWRheS4NClRvZGF5IEkgd2Fz
IGFibGUgdG8gYnVpbGQgdGhlIHN5c3RlbSB3aXRoIGRtLWNyeXB0ICh1c2luZyBMVUtTMiBhbmQN
ClBCS0RGMikgYW5kIHN1Y2Nlc3NmdWxseSBib290IGZyb20gc2RjYXJkLg0KDQpCdXQgd2hlbiBi
b290aW5nIGZyb20gdGhlIHViaWJsb2NrIGRldmljZSwgSSBnZXQgdGhlIHNhbWUgbnVsbCBwb2lu
dGVyDQpkZXJlZmVyZW5jZSBhcyBmb3IgZG0tdmVyaXR5Lg0KDQpUaGlzIHJlYWxseSBzZWVtcyB0
byBiZSByZWxhdGVkIHRvIGRldmljZW1hcHBlciBpbnRlcmZlcmluZyB3aXRoIHRoZQ0KdWJpYmxv
Y2sgZGV2aWNlLg0KDQoNClRvIGFkZCBzb21lIG1vcmUgZGV0YWlscyBvbiB0aGUgc2V0dXAsIGhl
cmUgaXMgdGhlIG91dHB1dCBvZiB1YmluZm86DQoNCiMgdWJpbmZvIC1hDQpVQkkgdmVyc2lvbjog
ICAgICAgICAgICAgICAgICAgIDENCkNvdW50IG9mIFVCSSBkZXZpY2VzOiAgICAgICAgICAgMQ0K
VUJJIGNvbnRyb2wgZGV2aWNlIG1ham9yL21pbm9yOiAxMDoxMjUNClByZXNlbnQgVUJJIGRldmlj
ZXM6ICAgICAgICAgICAgdWJpMA0KDQp1YmkwDQpWb2x1bWVzIGNvdW50OiAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDUNCkxvZ2ljYWwgZXJhc2VibG9jayBzaXplOiAgICAgICAgICAgICAgICAg
MjUzOTUyIGJ5dGVzLCAyNDguMCBLaUINClRvdGFsIGFtb3VudCBvZiBsb2dpY2FsIGVyYXNlYmxv
Y2tzOiAgICAgNDA5MiAoMTAzOTE3MTU4NCBieXRlcywgOTkxLjANCk1pQikNCkFtb3VudCBvZiBh
dmFpbGFibGUgbG9naWNhbCBlcmFzZWJsb2NrczogMTc3ICg0NDk0OTUwNCBieXRlcywgNDIuOCBN
aUIpDQpNYXhpbXVtIGNvdW50IG9mIHZvbHVtZXMgICAgICAgICAgICAgICAgIDEyOA0KQ291bnQg
b2YgYmFkIHBoeXNpY2FsIGVyYXNlYmxvY2tzOiAgICAgICA0DQpDb3VudCBvZiByZXNlcnZlZCBw
aHlzaWNhbCBlcmFzZWJsb2NrczogIDc2DQpDdXJyZW50IG1heGltdW0gZXJhc2UgY291bnRlciB2
YWx1ZTogICAgIDU2DQpNaW5pbXVtIGlucHV0L291dHB1dCB1bml0IHNpemU6ICAgICAgICAgIDQw
OTYgYnl0ZXMNCkNoYXJhY3RlciBkZXZpY2UgbWFqb3IvbWlub3I6ICAgICAgICAgICAgMjQyOjAN
ClByZXNlbnQgdm9sdW1lczogICAgICAgICAgICAgICAgICAgICAgICAgMCwgMSwgMiwgMywgNA0K
DQpWb2x1bWUgSUQ6ICAgMCAob24gdWJpMCkNClR5cGU6ICAgICAgICBkeW5hbWljDQpBbGlnbm1l
bnQ6ICAgMQ0KU2l6ZTogICAgICAgIDI0OCBMRUJzICg2Mjk4MDA5NiBieXRlcywgNjAuMCBNaUIp
DQpTdGF0ZTogICAgICAgT0sNCk5hbWU6ICAgICAgICBmaXQwDQpDaGFyYWN0ZXIgZGV2aWNlIG1h
am9yL21pbm9yOiAyNDI6MQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClZv
bHVtZSBJRDogICAxIChvbiB1YmkwKQ0KVHlwZTogICAgICAgIGR5bmFtaWMNCkFsaWdubWVudDog
ICAxDQpTaXplOiAgICAgICAgMjQ4IExFQnMgKDYyOTgwMDk2IGJ5dGVzLCA2MC4wIE1pQikNClN0
YXRlOiAgICAgICBPSw0KTmFtZTogICAgICAgIGZpdDENCkNoYXJhY3RlciBkZXZpY2UgbWFqb3Iv
bWlub3I6IDI0MjoyDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KVm9sdW1l
IElEOiAgIDIgKG9uIHViaTApDQpUeXBlOiAgICAgICAgc3RhdGljDQpBbGlnbm1lbnQ6ICAgMQ0K
U2l6ZTogICAgICAgIDE0MDQgTEVCcyAoMzU2NTQ4NjA4IGJ5dGVzLCAzNDAuMCBNaUIpDQpEYXRh
IGJ5dGVzOiAgMTM3MzU1MjY0IGJ5dGVzICgxMzAuOSBNaUIpDQpTdGF0ZTogICAgICAgT0sNCk5h
bWU6ICAgICAgICByb290MA0KQ2hhcmFjdGVyIGRldmljZSBtYWpvci9taW5vcjogMjQyOjMNCi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpWb2x1bWUgSUQ6ICAgMyAob24gdWJp
MCkNClR5cGU6ICAgICAgICBzdGF0aWMNCkFsaWdubWVudDogICAxDQpTaXplOiAgICAgICAgMTQw
NCBMRUJzICgzNTY1NDg2MDggYnl0ZXMsIDM0MC4wIE1pQikNCkRhdGEgYnl0ZXM6ICAxNjg0NjAy
ODggYnl0ZXMgKDE2MC42IE1pQikNClN0YXRlOiAgICAgICBPSw0KTmFtZTogICAgICAgIHJvb3Qx
DQpDaGFyYWN0ZXIgZGV2aWNlIG1ham9yL21pbm9yOiAyNDI6NA0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NClZvbHVtZSBJRDogICA0IChvbiB1YmkwKQ0KVHlwZTogICAgICAg
IGR5bmFtaWMNCkFsaWdubWVudDogICAxDQpTaXplOiAgICAgICAgNTI5IExFQnMgKDEzNDM0MDYw
OCBieXRlcywgMTI4LjEgTWlCKQ0KU3RhdGU6ICAgICAgIE9LDQpOYW1lOiAgICAgICAgZGF0YQ0K
Q2hhcmFjdGVyIGRldmljZSBtYWpvci9taW5vcjogMjQyOjUNCg0KDQpUaGFua3MNCi0tDQpTdGVw
aGFuIFd1cm0gPHN0ZXBoYW4ud3VybUBhLWViZXJsZS5kZT4NCg==
