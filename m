Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52D579D4C2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbjILP1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbjILP1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:27:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F68F10D9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:27:13 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C9ncZw001833;
        Tue, 12 Sep 2023 15:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=sYnuSlA52x32z5Ob7z8ty3trOSKm5V2mjPB1S/maqPo=;
 b=LaQAz1eQY73H+xon+qrAQIsFlkgtlMG1V3pl0fObrMXDKhfuWzLfCAU/AHgQEbDkLE8P
 wO8EEyQi+C4IMZksoDfixNnyCMvdLGWWhmuuu67OdYYJdL3ZPLOyeJ4tTIWiUDREb0qm
 48Guz/5QtJRYzQ+Ts0yWXvoo1tr7lvSw6NoThOvpiYZ25zLaatznwEaNagf5MEmaMvdZ
 epOyBfC2fjCbWTH+z7/MPqli3p0UmUKgQ7hpPh1AKWDiWRCwY0D/YlV9ak/Tyxi07I1F
 nhI04lMW+/T2BhY2I0IyNoA7qGBVGfeubvuzDVNYXwk9mhCD2q9U4TFRuQKFoKOxRddN Lg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jpav996-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 15:27:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38CEHUOq007764;
        Tue, 12 Sep 2023 15:26:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f55x244-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 15:26:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hf5UDc6xVSpijwl79IY/DaJohGeoMAF5qbc+HtTs/6GQcRjbK4smiXzH59imexE6An1tAH36FSCuPD46BJp0aaE6QhGKmlxFGCCmTXvRM2C/Gf0Bq3Qz0dMF5sv60/nHZhlwtTgeY7yU/NFxqjH5gao0ngoRXO5gE14Qo7E5o6AvgvgbdMBqboSDFSu3RLmEUOjPxDLr3Be+YofqEkHSVNL/DZm3eUVKvTxe7MxcBzZRwWrDKpA530Xa3X0f4Oamr49PnqX8NXtezT6Ha+06lFOchwGLvaLlvCxvFONFs2YdC/aogYuLz6lo0nOZ0ShXKiPGIh6ZPzQrOAGtSvie0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYnuSlA52x32z5Ob7z8ty3trOSKm5V2mjPB1S/maqPo=;
 b=ffwO/1fFePHIFeaD+mR2WucI89i4i2q7IgUYB0dB0hvp9Se8IhRdxYR69Bz6JqWLHBzoNStzI/CTVikP1OKY1Aj9nVcRsL24T0AEuxRv7sjJv6P4Yti+Il5L8vS824GKeSEzGCGNm9db5nU08FGwGQk7LJXKdQVz+/qOHqfepDgYJYKFXq5yOfpOuUDxBbogaaH083nbaYIPSqxITQZIx8ieYcw7is5JWaUPReR5FI8hLr4jxnDRmBb1Db+yztBNy1J6Z2rtEQu8zBYQem+Z1SzoBtFdcS8X2URfRLCl90V2hPGyi1WzYlmtlPTh3pzsVjK2UjzIWmzdhLAAb9iOqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYnuSlA52x32z5Ob7z8ty3trOSKm5V2mjPB1S/maqPo=;
 b=CkcX/nbN1695UdsLaaj7To3o4WmBmg9thgD1vUgpZ6m1yy4QesvTAmnbVTNn47kXPQx9KxB2i3Qbl5DK6gLB7nnEIy0lYG7wRUs1aL29bIwqg0FzI9YtKadUA/JsbgGl2pqp9byglaDqOe8BMd5ekpmXlwL6XWa9MLbL3MfGq9k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5102.namprd10.prod.outlook.com (2603:10b6:5:38c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Tue, 12 Sep
 2023 15:26:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 15:26:57 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Feng Tang <feng.tang@intel.com>
CC:     "Sang, Oliver" <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [linus:master] [shmem]  a2e459555c:  aim9.disk_src.ops_per_sec
 -19.0% regression
Thread-Topic: [linus:master] [shmem]  a2e459555c:  aim9.disk_src.ops_per_sec
 -19.0% regression
Thread-Index: AQHZ4hUlovnTGopJRkWINRJx8jG2QrARAWsAgAVqhYCAAMJWAIAAJUUAgAADXwA=
Date:   Tue, 12 Sep 2023 15:26:57 +0000
Message-ID: <DF49B280-49BF-42CC-8F7F-5EE89522F996@oracle.com>
References: <202309081306.3ecb3734-oliver.sang@intel.com>
 <C85F44FD-BC7D-421B-9585-C5FDFAEA9400@oracle.com>
 <ZP++GV9WURg1GhoY@xsang-OptiPlex-9020>
 <84984801-F885-4739-B4B3-DE8DE4ABE378@oracle.com> <ZQCAYpqu+5iD0rhh@feng-clx>
In-Reply-To: <ZQCAYpqu+5iD0rhh@feng-clx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5102:EE_
x-ms-office365-filtering-correlation-id: 8c7ba184-a1ad-4ddc-92a1-08dbb3a4b38d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bGLkPVDEHmtAxkUncB2R7TlIUlTxTGS0LBYhNxIAmc96g70Fh4iN0FxRYZepFC4hr67THZKQki+X6lMK/gKMaY4CjZwF6bhVjkzCXGyru9I+IY8sgcSpiwFZuEH1eeeMV3kGv82UvwOVCjK5ERR7y82xnPc+EvahLvlY+UTub0tZDfXgObvuRuz03BxbzIH7MilxYRuG/wleopHhG8RhwiZOcSCK84TrSXHagX6gec0t34NWPFQCKuNM2iDvx2l1QTjsUADfIFODLN+2RT9ouYxsM+2ZEpkRjT7um9ydezrOOqA0fydAWsHA++bFugbRqJnIT6wPFPvxpWCraoePcBTjeeWfs4Ae0zIr9YVQUliv15j0YioDp8X85tePrnapMB47bZTz0LlTtsIrz2eqTrmtbbYcRwmewCR8mKjwkvHiMTGmEDXF6UacI2Evy59bqdsiQMs20/Ysz1Oa+cNu/OhdtT2NIdAnxmkTFzZm1uMMvEbnO2Ku/konnN44Ah7d8E4f90M1T3lQPk6BvAy49gPvheQEv3lNSpZo3Gp4WCMWZnXqCXBqkNCDSlU5xujNEZclAypRxR4uGOBYTLuceLF/33KLHlUxnHgscYfP9p3zNdArJd65OtN/yhSBIFAv/CXlfxj/9bjRp/JxIOP6dZqJg1B/3B9j+gPZlZBGNJ7oCXmLPak6pPzkp4ybwDux
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199024)(1800799009)(186009)(8676002)(8936002)(86362001)(4326008)(5660300002)(2906002)(33656002)(36756003)(38100700002)(83380400001)(38070700005)(53546011)(6506007)(6486002)(122000001)(6512007)(71200400001)(966005)(26005)(2616005)(478600001)(6916009)(316002)(76116006)(91956017)(66446008)(66556008)(64756008)(54906003)(66476007)(66946007)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWpMVnFmSlVSWkxsc0RRVnpOVHQ3SmthNjlqYVpKYlcrN3VZak9VS1VvdUhC?=
 =?utf-8?B?b1B1aWNGT041SlZwT0hYQnJrMnBGTm8rdWtXaXM1QURlVnl0LzNIYm5WWThk?=
 =?utf-8?B?QXNtMHFuTzNvR1B1R1ZGSFJSNkxxc05GUFVHcEVxT0NTN0VKNUlzNnBQKzBt?=
 =?utf-8?B?SEJYUUlMd1IzODY4Ni9UQ0RGR3VuOXBjTlFNaHgxYVZiVWdiUGxZWmtOQXhT?=
 =?utf-8?B?RTRKQm15OHNtcmlFcmhOSERmNi9wcWZIOVYwSXg2TE5PNWZ5K1V0SkxZS1JC?=
 =?utf-8?B?d2owbE1IbndvaDhXWGJUUTUrR255T2dFQWErZkFlUDhMNlNxRDhRQUgvRnFa?=
 =?utf-8?B?b2ZQNWpjcnR1RVpVNndNRHBIb2R1cXZhT0hNV2JPWE9SRHpXdDRDdmlyNUI2?=
 =?utf-8?B?U3JvTU1Db01DaWw5TnBHTjJ5VXlqdFdLK0lScVBheUxUTnFLR3ptVkdtZjRG?=
 =?utf-8?B?a0UzMk56enh6UUlNWFJ5OUlabzgxTjR1ZGRRSDd6Sm9SK3Bvc3ZmeWpMb09F?=
 =?utf-8?B?RnRmaGJ0dnhtbGpXU2NhOXVQSjhlU1FtS0s0cFFJNGtFRmpiSHltV2dUa2E4?=
 =?utf-8?B?NHl3cG1ieUNIUWtBbXA3bGJRUCtQTThiRWN4WHVpNm45QWQzWC85ZU1rbldw?=
 =?utf-8?B?QXhoejd1Ny9CTlkwcGNtTkd0bU5mUjRJZjBzcnBFTGlkckYwOUVjTFNVNUtX?=
 =?utf-8?B?VXE3QWUxeWo1bEV1aXhFeGRFQk8zMGNWQkk5N01BUTdJanNTWFJHRGxOekc1?=
 =?utf-8?B?UmhYeFpmQWlFMVRpQyt6dHRFZXBkL2hUMEVFRDJJSG43aFI2bnJqMGpFa3Js?=
 =?utf-8?B?ZjY4VkVyUnJ1SjB4d0V2MXd0VmZjRWxRNUpJN2RnSnFmOEs3S280bTJvY0cy?=
 =?utf-8?B?V1ZMSkdqbjZIaFdXOVhRUFJESGR5VWN3U21mNDdLQXdMQm5QSThFbmRoQ3Iw?=
 =?utf-8?B?WnhybE1DQ0toRHZaQWJtNTJzNms4a0t4UFNielA2ZmdXS3NIajhNZG1oQitC?=
 =?utf-8?B?aXRSM0ZqWGRmNW1CSTU0Z0JVQzhMckVkVzk0elZZaWMvWjZjcFplWHBXUzRj?=
 =?utf-8?B?WDNVZW5qdjJlZytLQkVFV3p0aDN0L2dDMlZyWmZBK0RtL1ZQR2xDMGhFQWtZ?=
 =?utf-8?B?N1RNRXg2Wk12c1BQbHJBVHVpejhHWUFVcENRSVZTNlJxeXpidERVbGF4UXJk?=
 =?utf-8?B?dWN4NE1FbmNDL0JKVm1tME0zMkcybFl4eWsrbzZpVkdVcFlhOU96TWNYa1hw?=
 =?utf-8?B?clBRT1lNdXYwdnA2L0pxNjltMjJvVnJpd0ozY2RmUVhWUzRmT3dZbjNoUFJT?=
 =?utf-8?B?U1A4dDBvNHRJY3RLdUpYK2krTll2SjF4WUhiNEVRRWRsSFZjemEwNnhUdXVw?=
 =?utf-8?B?NjZnYTlsaFlMaDNOZDBVZnh6K0RxTzVxbnJrME14cFJwM0wyRWpLaEdjbmxX?=
 =?utf-8?B?QllvWlJ3WS9XSkVIbHJEalhKUzZZRUVKcm8zM2FOSkNNeWVHWGpaTVlpSWlF?=
 =?utf-8?B?OXp3VE55V0NJN1JUelJNV0RGSVNPWEtrN3M1L0crNy9YYWYzRUZFcmVMNm84?=
 =?utf-8?B?Znp1K2lvbXBIMXl4TE5jYWNiZThBcUNyTEwxZFhpUGl5bDJSaFBGVUNPNEFj?=
 =?utf-8?B?SnJYc1BHMHVtVDV5amo4ZElwRjFCRjRqaG9lR0VMdHpCdHNsUDljUDJIQlJP?=
 =?utf-8?B?U2h5aVpHaG9vMHovOUtuTjljRDNaaUllQ1o3MFcyd1EwRndSUFpKR3gyb0Vu?=
 =?utf-8?B?SlFnOVVIWVp5dDBUQ1dBREMrNWVhK3Z5YnJjM3pNK2piYlRzbGxaSUxsbW5P?=
 =?utf-8?B?eUVuQzFKNXBxd2FJcS9hMlEwcFFNd2R0OEE1VUJNVVp1K3EvOU1EZXJkRjBB?=
 =?utf-8?B?T0FsY3VPWnhSWHdqRXptTmRJNUdERVU2UHp3V21UVmF3NDhLdUh3MEtRMVRt?=
 =?utf-8?B?TE5vMGh0YVV0Rlg4T0ZFS0dJRXMwT3JwN1B5aFFaTmNqQ3pNbVJBcDNPWG0z?=
 =?utf-8?B?UHlFdlVsdHNsVnYvYXVHTEUrU0NrSGNIZjBTWlY0MThMaXJrQU9YS2FVOGVq?=
 =?utf-8?B?UFYzdStYb3h1emxhaGRmNExBRlNTN0k1M1dVcWNmRnJnZXozcmJsSTFGRFRU?=
 =?utf-8?B?YWxlUSs1aFUxd1VRUHRlTVc0MGc3MjBCYlltWi9pUXdjMVd6TTBJakdPTFZx?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82ADBCB6F2646B449F7819D8D68C993A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: po2o7waWX2IA5YUBKW4sgKBHdylFJUK2r9R1sS7deDV/2ahSprteaP4N+F4rzM2OzDvjiezUZK2gXt7Wmq4T3h8oks2F1agBk51YOk0uO5i1CqQQ3xLIZHHiz/Ds82vCWKEqb8zaBCF5xYKATIxE3WTHqeB54u9ogW8Ozm52m3qWl73mms/5hvswJPg6+N5+NxBCQaTcXUhzvdaypxynFxa5bwM8wSNqLiqaVoXtYUz+dQx/roIt12qYhXpxGth+rsqPNk1SpEpwghJcwgLzCxGzHSWXv66Gsa+/SdTFVK56QeI/s7lRg+TXzNQEZdZiTwCHdVqxXqpAqkL0Rv8h5vkzMzAdnkRzdSmAXpT5WGH8mZpeE1jJNEr8QWFoeJ8wHlmoXlNxUF6hvmQr7g5Rov5EHTmyYvmewBWBpFgq2KiuKmhWseWLECIqZUxk+NbrQfMJe1x9iftbv8n60/PNXMj3wJp6gVQtN6aHeVegjjQvJEmz+LHhBc50q/zXOQZ74vfWqzz6HlpraZB1XIhSRefzxdfRY9AXEK+jM6WTp713/TnlxsENCq4LHOveYJZTk7cWS+K6HSf0SwnhQmuWnbgTriaClsB4aNN+DmiV4Z2LhWb+Ha+4vOkqmMC7/Dt39IwFzsnfQMmbPw5cJG3r9AqIhguNcvatWiGqalQSLiCYBbT1jIhQ79D49GK1w/CbKlPy/O/vJWTXSOSVyyUAcPD0qu+lVUOiSoHu4nqgcxyNwE0mld89IXny7IXPjiwTpxoCcoWHIcwTJDm/n2nRh1u1wmXnZWbeUI6LNaUli2GMhYovvxz7GcC80Ol1+Qb3ixMSKrsbg26iKNUKmC412m43KMn0XN68cnQE+9tIOHRHntAkP9fPk8C/l8W7fHxr
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7ba184-a1ad-4ddc-92a1-08dbb3a4b38d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 15:26:57.1052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hvizCZCtFHGGoqPi+DIcSjbIxv/pvZBysm0mx2NymOnppjK6y8HRd019SlggWxq1ejbmkqAFgdXP5eDW52EBRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5102
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_14,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120128
X-Proofpoint-GUID: e-03-McsaKoNl0lGS04V3RcghqUIuCy_
X-Proofpoint-ORIG-GUID: e-03-McsaKoNl0lGS04V3RcghqUIuCy_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gU2VwIDEyLCAyMDIzLCBhdCAxMToxNCBBTSwgRmVuZyBUYW5nIDxmZW5nLnRhbmdA
aW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IEhpIENodWNrIExldmVyLCANCj4gDQo+IE9uIFR1ZSwg
U2VwIDEyLCAyMDIzIGF0IDA5OjAxOjI5UE0gKzA4MDAsIENodWNrIExldmVyIElJSSB3cm90ZToN
Cj4+IA0KPj4gDQo+Pj4gT24gU2VwIDExLCAyMDIzLCBhdCA5OjI1IFBNLCBPbGl2ZXIgU2FuZyA8
b2xpdmVyLnNhbmdAaW50ZWwuY29tPiB3cm90ZToNCj4+PiANCj4+PiBoaSwgQ2h1Y2sgTGV2ZXIs
DQo+Pj4gDQo+Pj4gT24gRnJpLCBTZXAgMDgsIDIwMjMgYXQgMDI6NDM6MjJQTSArMDAwMCwgQ2h1
Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4+PiANCj4+Pj4gDQo+Pj4+PiBPbiBTZXAgOCwgMjAyMywg
YXQgMToyNiBBTSwga2VybmVsIHRlc3Qgcm9ib3QgPG9saXZlci5zYW5nQGludGVsLmNvbT4gd3Jv
dGU6DQo+Pj4+PiANCj4+Pj4+IA0KPj4+Pj4gDQo+Pj4+PiBIZWxsbywNCj4+Pj4+IA0KPj4+Pj4g
a2VybmVsIHRlc3Qgcm9ib3Qgbm90aWNlZCBhIC0xOS4wJSByZWdyZXNzaW9uIG9mIGFpbTkuZGlz
a19zcmMub3BzX3Blcl9zZWMgb246DQo+Pj4+PiANCj4+Pj4+IA0KPj4+Pj4gY29tbWl0OiBhMmU0
NTk1NTVjNWY5ZGEzZTYxOWI3ZTQ3YTYzZjk4NTc0ZGM3NWYxICgic2htZW06IHN0YWJsZSBkaXJl
Y3Rvcnkgb2Zmc2V0cyIpDQo+Pj4+PiBodHRwczovL2dpdC5rZXJuZWwub3JnL2NnaXQvbGludXgv
a2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQgbWFzdGVyDQo+Pj4+PiANCj4+Pj4+IHRlc3Rj
YXNlOiBhaW05DQo+Pj4+PiB0ZXN0IG1hY2hpbmU6IDQ4IHRocmVhZHMgMiBzb2NrZXRzIEludGVs
KFIpIFhlb24oUikgQ1BVIEU1LTI2OTcgdjIgQCAyLjcwR0h6IChJdnkgQnJpZGdlLUVQKSB3aXRo
IDExMkcgbWVtb3J5DQo+Pj4+PiBwYXJhbWV0ZXJzOg0KPj4+Pj4gDQo+Pj4+PiB0ZXN0dGltZTog
MzAwcw0KPj4+Pj4gdGVzdDogZGlza19zcmMNCj4+Pj4+IGNwdWZyZXFfZ292ZXJub3I6IHBlcmZv
cm1hbmNlDQo+Pj4+PiANCj4+Pj4+IA0KPj4+Pj4gSW4gYWRkaXRpb24gdG8gdGhhdCwgdGhlIGNv
bW1pdCBhbHNvIGhhcyBzaWduaWZpY2FudCBpbXBhY3Qgb24gdGhlIGZvbGxvd2luZyB0ZXN0czoN
Cj4+Pj4+IA0KPj4+Pj4gKy0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tKw0KPj4+Pj4gfCB0ZXN0Y2FzZTogY2hhbmdlIHwgYWltOTogYWlt
OS5kaXNrX3NyYy5vcHNfcGVyX3NlYyAtMTQuNiUgcmVncmVzc2lvbiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPj4+Pj4gfCB0ZXN0IG1hY2hpbmUgICAg
IHwgNDggdGhyZWFkcyAyIHNvY2tldHMgSW50ZWwoUikgWGVvbihSKSBDUFUgRTUtMjY5NyB2MiBA
IDIuNzBHSHogKEl2eSBCcmlkZ2UtRVApIHdpdGggMTEyRyBtZW1vcnkgfA0KPj4+Pj4gfCB0ZXN0
IHBhcmFtZXRlcnMgIHwgY3B1ZnJlcV9nb3Zlcm5vcj1wZXJmb3JtYW5jZSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0K
Pj4+Pj4gfCAgICAgICAgICAgICAgICAgIHwgdGVzdD1hbGwgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfA0KPj4+Pj4gfCAgICAgICAgICAgICAgICAgIHwgdGVzdHRpbWU9NXMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfA0KPj4+Pj4gKy0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KPj4+Pj4gDQo+Pj4+PiANCj4+Pj4+
IElmIHlvdSBmaXggdGhlIGlzc3VlIGluIGEgc2VwYXJhdGUgcGF0Y2gvY29tbWl0IChpLmUuIG5v
dCBqdXN0IGEgbmV3IHZlcnNpb24gb2YNCj4+Pj4+IHRoZSBzYW1lIHBhdGNoL2NvbW1pdCksIGtp
bmRseSBhZGQgZm9sbG93aW5nIHRhZ3MNCj4+Pj4+IHwgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0
IHJvYm90IDxvbGl2ZXIuc2FuZ0BpbnRlbC5jb20+DQo+Pj4+PiB8IENsb3NlczogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvb2UtbGtwLzIwMjMwOTA4MTMwNi4zZWNiMzczNC1vbGl2ZXIuc2FuZ0Bp
bnRlbC5jb20NCj4gDQo+Pj4+IEJ1dCwgSSdtIHN0aWxsIGluIGEgcG9zaXRpb24gd2hlcmUgSSBj
YW4ndCBydW4gdGhpcyB0ZXN0LA0KPj4+PiBhbmQgdGhlIHJlc3VsdHMgZG9uJ3QgcmVhbGx5IGlu
ZGljYXRlIHdoZXJlIHRoZSBwcm9ibGVtDQo+Pj4+IGlzLiBTbyBJIGNhbid0IHBvc3NpYmx5IGFk
ZHJlc3MgdGhpcyBpc3N1ZS4NCj4+Pj4gDQo+Pj4+IEFueSBzdWdnZXN0aW9ucywgYWR2aWNlLCBv
ciBoZWxwIHdvdWxkIGJlIGFwcHJlY2lhdGVkLg0KPj4+IA0KPj4+IGlmIHlvdSBoYXZlIGZ1cnRo
ZXIgZml4IHBhdGNoLCBjb3VsZCB5b3UgbGV0IHVzIGtub3c/IEkgd2lsbCB0ZXN0IGl0Lg0KPj4g
DQo+PiBXZWxsIHRoYXQncyB0aGUgcHJvYmxlbS4gU2luY2UgSSBjYW4ndCBydW4gdGhlIHJlcHJv
ZHVjZXIsIHRoZXJlJ3MNCj4+IG5vdGhpbmcgSSBjYW4gZG8gdG8gdHJvdWJsZXNob290IHRoZSBw
cm9ibGVtIG15c2VsZi4NCj4gDQo+IFdlIGR1ZyBtb3JlIGludG8gdGhlIHBlcmYgYW5kIG90aGVy
IHByb2ZpbGluZyBkYXRhIGZyb20gMERheSBzZXJ2ZXINCj4gcnVubmluZyB0aGlzIGNhc2UsIGFu
ZCBpdCBzZWVtcyB0aGF0IHRoZSBuZXcgc2ltcGxlX29mZnNldF9hZGQoKQ0KPiBjYWxsZWQgYnkg
c2htZW1fbWtub2QoKSBicmluZ3MgZXh0cmEgY29zdCByZWxhdGVkIHdpdGggc2xhYiwNCj4gc3Bl
Y2lmaWNhbGx5IHRoZSAncmFkaXhfdHJlZV9ub2RlJywgd2hpY2ggY2F1c2UgdGhlIHJlZ3Jlc3Np
b24uDQoNClRoYW5rIHlvdSEgV2lsbCBwb25kZXIuDQoNCg0KPiBIZXJlIGlzIHNvbWUgc2xhYmlu
Zm8gZGlmZiBmb3IgY29tbWl0IGEyZTQ1OTU1NWM1ZiBhbmQgaXRzIHBhcmVudDoNCj4gDQo+IDIz
YTMxZDg3NjQ1YzY1MjcgYTJlNDU5NTU1YzVmOWRhM2U2MTliN2U0N2E2IA0KPiAtLS0tLS0tLS0t
LS0tLS0tIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSANCj4gDQo+ICAgICAyNjM2MyAgICAg
ICAgICAgKzQwLjIlICAgICAgMzY5NTYgICAgICAgIHNsYWJpbmZvLnJhZGl4X3RyZWVfbm9kZS5h
Y3RpdmVfb2Jqcw0KPiAgICA5NDEuMDAgICAgICAgICAgICs0MC40JSAgICAgICAxMzIxICAgICAg
ICBzbGFiaW5mby5yYWRpeF90cmVlX25vZGUuYWN0aXZlX3NsYWJzDQo+ICAgICAyNjM2MyAgICAg
ICAgICAgKzQwLjMlICAgICAgMzcwMDEgICAgICAgIHNsYWJpbmZvLnJhZGl4X3RyZWVfbm9kZS5u
dW1fb2Jqcw0KPiAgICA5NDEuMDAgICAgICAgICAgICs0MC40JSAgICAgICAxMzIxICAgICAgICBz
bGFiaW5mby5yYWRpeF90cmVlX25vZGUubnVtX3NsYWJzDQo+IA0KPiBBbHNvIHRoZSBwZXJmIHBy
b2ZpbGUgc2hvdyBzb21lIGRpZmZlcmVuY2UNCj4gDQo+ICAgICAgMC4wMSDCsTIyMyUgICAgICAr
MC4xICAgICAgICAwLjEwIMKxIDI4JSAgcHAuc2VsZi5zaHVmZmxlX2ZyZWVsaXN0DQo+ICAgICAg
MC4wMCAgICAgICAgICAgICswLjEgICAgICAgIDAuMTEgwrEgNDAlICBwcC5zZWxmLnhhc19jcmVh
dGUNCj4gICAgICAwLjAwICAgICAgICAgICAgKzAuMSAgICAgICAgMC4xMiDCsSAyNyUgIHBwLnNl
bGYueGFzX2ZpbmRfbWFya2VkDQo+ICAgICAgMC4wMCAgICAgICAgICAgICswLjEgICAgICAgIDAu
MTQgwrEgMTglICBwcC5zZWxmLnhhc19hbGxvYw0KPiAgICAgIDAuMDMgwrExMDMlICAgICAgKzAu
MSAgICAgICAgMC4xNyDCsSAyOSUgIHBwLnNlbGYueGFzX2Rlc2NlbmQNCj4gICAgICAwLjAwICAg
ICAgICAgICAgKzAuMiAgICAgICAgMC4xNiDCsSAyMyUgIHBwLnNlbGYueGFzX2V4cGFuZA0KPiAg
ICAgIDAuMTAgwrEgMjIlICAgICAgKzAuMiAgICAgICAgMC4yNyDCsSAxNiUgIHBwLnNlbGYucmN1
X3NlZ2NibGlzdF9lbnF1ZXVlDQo+ICAgICAgMC45MiDCsSAzNSUgICAgICArMC4zICAgICAgICAx
LjIyIMKxIDExJSAgcHAuc2VsZi5rbWVtX2NhY2hlX2ZyZWUNCj4gICAgICAwLjAwICAgICAgICAg
ICAgKzAuNCAgICAgICAgMC4zNiDCsSAxNiUgIHBwLnNlbGYueGFzX3N0b3JlDQo+ICAgICAgMC4z
MiDCsSAzMCUgICAgICArMC40ICAgICAgICAwLjcxIMKxIDEyJSAgcHAuc2VsZi5fX2NhbGxfcmN1
X2NvbW1vbg0KPiAgICAgIDAuMTggwrEgMjclICAgICAgKzAuNSAgICAgICAgMC42NSDCsSAgOCUg
IHBwLnNlbGYua21lbV9jYWNoZV9hbGxvY19scnUNCj4gICAgICAwLjM2IMKxIDc5JSAgICAgICsw
LjYgICAgICAgIDAuOTYgwrEgMTUlICBwcC5zZWxmLl9fc2xhYl9mcmVlDQo+ICAgICAgMC4wMCAg
ICAgICAgICAgICswLjggICAgICAgIDAuODAgwrEgMTQlICBwcC5zZWxmLnJhZGl4X3RyZWVfbm9k
ZV9yY3VfZnJlZQ0KPiAgICAgIDAuMDAgICAgICAgICAgICArMS4wICAgICAgICAxLjAxIMKxIDE2
JSAgcHAuc2VsZi5yYWRpeF90cmVlX25vZGVfY3Rvcg0KPiANCj4gU29tZSBwZXJmIHByb2ZpbGUg
ZnJvbSBhMmU0NTk1NTVjNWYgaXM6IA0KPiANCj4gLSAgIDE3LjA5JSAgICAgMC4wOSUgIHNpbmds
ZXVzZXIgICAgICAgW2tlcm5lbC5rYWxsc3ltc10gICAgICAgICAgICBba10gcGF0aF9vcGVuYXQg
ICANCj4gICAtIDE2Ljk5JSBwYXRoX29wZW5hdCAgICAgICAgICAgICAgICANCj4gICAgICAtIDEy
LjIzJSBvcGVuX2xhc3RfbG9va3VwcyAgICAgIA0KPiAgICAgICAgIC0gMTEuMzMlIGxvb2t1cF9v
cGVuLmlzcmEuMA0KPiAgICAgICAgICAgIC0gOS4wNSUgc2htZW1fbWtub2QNCj4gICAgICAgICAg
ICAgICAtIDUuMTElIHNpbXBsZV9vZmZzZXRfYWRkDQo+ICAgICAgICAgICAgICAgICAgLSA0Ljk1
JSBfX3hhX2FsbG9jX2N5Y2xpYyANCj4gICAgICAgICAgICAgICAgICAgICAtIDQuODglIF9feGFf
YWxsb2MNCj4gICAgICAgICAgICAgICAgICAgICAgICAtIDQuNzYlIHhhc19zdG9yZSANCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAtIHhhc19jcmVhdGUNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAtIDIuNDAlIHhhc19leHBhbmQuY29uc3Rwcm9wLjANCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAtIDIuMDElIHhhc19hbGxvYw0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIC0ga21lbV9jYWNoZV9hbGxvY19scnUNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAtIDEuMjglIF9fX3NsYWJfYWxsb2MNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtIDEuMjIlIGFsbG9jYXRlX3NsYWIg
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLSAxLjE5JSBz
aHVmZmxlX2ZyZWVsaXN0IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIC0gMS4wNCUgc2V0dXBfb2JqZWN0DQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICByYWRpeF90cmVlX25vZGVfY3Rvcg0KPiANCj4g
UGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIG1vcmUgaW5mby4NCj4gDQo+PiANCj4+IElz
IHRoZXJlIGFueSBob3BlIGluIGdldHRpbmcgdGhpcyByZXByb2R1Y2VyIHRvIHJ1biBvbiBGZWRv
cmE/DQo+IA0KPiBNeXNlbGYgaGF2ZW4ndCBzdWNjZWVkZWQgdG8gcmVwcm9kdWNlIGl0IGxvY2Fs
bHksIHdpbGwga2VlcCB0cnlpbmcNCj4gaXQgdG9tb3Jyb3cuDQo+IA0KPiBUaGFua3MsDQo+IEZl
bmcNCj4gDQo+PiANCj4+IC0tDQo+PiBDaHVjayBMZXZlcg0KDQoNCi0tDQpDaHVjayBMZXZlcg0K
DQoNCg==
