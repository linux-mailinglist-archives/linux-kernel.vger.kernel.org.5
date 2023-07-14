Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9C2753F56
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbjGNPvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbjGNPvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:51:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D73530F8;
        Fri, 14 Jul 2023 08:51:11 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EDQUVF013533;
        Fri, 14 Jul 2023 15:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1lfIdGLteK3x3HJbDQrDZkZ+esEEhSmOqryS07RVPks=;
 b=Sw2X9/e3p+1MuzMkaQE2xj9ZHGxEHSxKnvWYT24oVux2tH4OCjnoNxKk8LC8cF8+uKX0
 zerY6C1kqsCj/dwE3WILPS325jlS+VwMHjSqpX5tdmZmPRjRBu63Oq9GKDCp8ypalZNh
 QRGx6UjvTN4klikRAWuxlIRQAmtz6q1kqaCJjxLxlC49WI63fYNLEq+wSaxslgk8IgEa
 2t5gHZzD5dQv8IEfXetN+KvW+N4EQeFMe64ZEMDiGv/uLdOsHLCP5pouA90Chy8gj0Zr
 w2v8PO9mz0W4uKtVDvBxemhVjN0pq2S4EKoLuq8ijvRdTgg8oCXZ7j+ZXMZjAEyyjvBY Sg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rtqgr1r0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 15:51:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36EEEN3q027142;
        Fri, 14 Jul 2023 15:51:02 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rtpvy3hd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 15:51:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZep3AmrhC1IQ2uQpVPwSp22hO2vNBXOcO9zhH599sMwtvNB4fhvIJ+Vt2VkZVI/QwW8bGUj3+gojp58YlPVai/NyUhr0THNLm+Xn0z2gzY38J4Rj0/icvAR3MUghHyg4UpwJOkLtRsgs0MLgUv58zpbaxJ2I1anG5X8BG4JAeFff5xi10aGkJxIDGHOzU32NoXnOMigcSrZTZbKv3Qo6+cyXXe0itLb0XpNZ6/4DxxeMyl5htGSvSoHvruvmjvFi3cqJ8kEXD9QkN9iM6GaH7HZxqDSsNaKZSMqRdg6OAS+8W81QZF6PMu62Eb9r72g4WX06XK29+PFcYkZgEY4Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lfIdGLteK3x3HJbDQrDZkZ+esEEhSmOqryS07RVPks=;
 b=IKjA/r94os+wCJKN9qbJVawds6fRnwCK5avg2hq/GJltclKuvNB/OOd6W8gk1s+Z3LD1kx3oRagP/hcPgA4jvl8+noc/ppJ2G4YiU5QZJSpQlM138TELFexjyG5yPfxwirh3RDTrZucJDcJiwsRm1yWxH46QM1HLoUPVAThZcl9Vp4ufkEuxhEt67XLrve1hzL60n4HlZoW2Hf9e/O4Is/bLxnquX7VvU4x5WEuCEXq+p6yfXpFoU9cd6HPeLMh6tgm58D/caoV2IR9TTTHes46vs9tGJZbSQzW3ypjXDkbdhYIGkCKNq5bavG9d7J7MkQeZoU6wgDRXWfQMbWTZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lfIdGLteK3x3HJbDQrDZkZ+esEEhSmOqryS07RVPks=;
 b=RK4/ILfQw4lk2sLIhCLecZ3BO30oorImd0ABdZfxL17f7XEtyXGFRfjL7A5r+2bBhT0NqnMCo9lroJK0Yy0hmch4m5+SxTZ5S1VlaB53mZrySqPlvi1o5JA8iZ5Q+lqCejpZMEHT6gBbNS2cvTeyJDr4hjrKXXi8n5HZddbUbJk=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB7497.namprd10.prod.outlook.com (2603:10b6:610:18b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.33; Fri, 14 Jul
 2023 15:50:55 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5a68:4817:cdec:ca0d]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5a68:4817:cdec:ca0d%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 15:50:55 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Coiby Xu <coxu@redhat.com>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        "open list:KEXEC" <kexec@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kexec_file: ima: allow loading a kernel with its IMA
 signature verified
Thread-Topic: [PATCH] kexec_file: ima: allow loading a kernel with its IMA
 signature verified
Thread-Index: AQHZs6Yx8QVGvV/d1EGz/VbT3miE2K+2dumAgAGJXYCAAI6VAIAA38iA
Date:   Fri, 14 Jul 2023 15:50:55 +0000
Message-ID: <3A8832F0-B1A7-43C4-B6B3-30A6B90A07B4@oracle.com>
References: <20230711031604.717124-1-coxu@redhat.com>
 <eaa1f1901abbceb2edc0aadaa94d9d959413c984.camel@linux.ibm.com>
 <6879D379-926E-4684-8CB2-B84D81E697D4@oracle.com>
 <4d6t456sswt66tnpzysxuu2wmlgkmlww3elhdsf4fxzejbroza@qig3hahn5paq>
In-Reply-To: <4d6t456sswt66tnpzysxuu2wmlgkmlww3elhdsf4fxzejbroza@qig3hahn5paq>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|CH0PR10MB7497:EE_
x-ms-office365-filtering-correlation-id: ede3d497-89e6-46af-8c77-08db84821bf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nf9io2/TIFTxCRPNT3HQ5fX9a/2CLUQIhhVFSYivthRrxq7bXA6VULH4EKUVHn8iubRfwQXW2af3pcIkAyGeGxZjkiigT/2sOTAqoebvKp7E3TS1J/jzeXkPSUnkSrqMRAThMM1rRK5Gi66bf+q/GTfGP0BcmxfJS7neKLbMQjquiEEy91IoKwr8IshSTsum7NDmFbhStb1HiHUQFDiKbniUmuk3SK9f/jHJDOnUuek9TC+A3r6yNAeYd3NTwhVkcRtWngJS2QNx6MSmmkhb98CkhCEQq/b5FtDxxWte3UEgTvoRcFqe7RnFh4lo+2CF5wPfc0hqBC58Wq+Zd20AOUD2fe6uAE9pd+aYUJxmOA8OWwHXQc7PT2rFT7Kb0/ZDmKqNQLMg6svkC0s63PSilt6vES8XqEU6sBB3sjBpQOMc2zM3ojI64YLoOxjdpUprM7MkejKsuqYlnGS6e+5o1EbBX2zfxu3GjkMbYARDHy8K0GPNgVD/fM8b9j2xHVbjLR5tDvTygHOMJdR25CJQeIDEGtsnkk7jw4Y7qNVd/x2FuMDXbjWUjDbNmS09w7xZTO6d7Pa+cg0vgRZUsFJCuVAQKC3FDQdvMbJn1C/vLkuxRCkEs7G4LVkRvdNkwDnM5zEvaCpPn1DKji2/O8Reiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199021)(8936002)(8676002)(478600001)(5660300002)(186003)(83380400001)(6506007)(86362001)(26005)(33656002)(41300700001)(53546011)(2616005)(15650500001)(6486002)(44832011)(316002)(71200400001)(6512007)(66446008)(64756008)(66556008)(66946007)(36756003)(6916009)(2906002)(76116006)(54906003)(66476007)(122000001)(91956017)(4326008)(38100700002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0JkR2s1cDNDQTdJNnRPRGZ0TEo4V3hSRVFBUitmdmtrZmlFQlFhK2J2TDJS?=
 =?utf-8?B?SmdBSVAweklNUUVmZmZIdjZqSmMvSWhpbFQ1bG9MOXNsb3A3Uksvc3RuYS91?=
 =?utf-8?B?eU9nQ05JNGpUTERNc2JjL2pydkorelVUeThPdDhLb290TDZvODR4QUJzYjdp?=
 =?utf-8?B?Y0syNWJpNTgrZ2VVbDY1QlpCTjk4NXRIVW9jWjlsdUkwcmN4cDRFak5rTHhR?=
 =?utf-8?B?VlhXNDN6UUsxRXM3TWVqb3ppQVRGZ0NBNjNrenliL1d6NzNWbzh6aWZsN0Zk?=
 =?utf-8?B?TnZOTEVPRjBITjJTVlFOdVh6Z1htaUZiK3M3ZXNEcG9tUXlseWdCTk1FNjZX?=
 =?utf-8?B?bE1JdngxLzUxZWlOTzdXVkx3MmJnMHRGbmR5bHRyUXZYRDZOT1o0YmRXemY2?=
 =?utf-8?B?M0kvNG5tMzIzVmZKSW5OT1dVako0bVRaeTZlTDA3WjJ0UGVEbjQxR2tlbGVo?=
 =?utf-8?B?czhTckxiTW5vVGtyYnZFazNjZm5qd3doV01GVTB2UHowYU5pSkxQc0lxQmZF?=
 =?utf-8?B?N2Zkd3NoYXJwY0c5SkNFVDU1eGl4WmdCRUlkakRkaGJzQWhMNG9pWWd1UkhL?=
 =?utf-8?B?L2V0VHczUDhRMHZaM1ZsRld3cWsrSDdlZzNGZUR3cllMblFkUnBWNTAvL3hH?=
 =?utf-8?B?bWpKMDN6eXFiSjFsUmRZdmlUQVBvWkZ0MTVLc20raUxqR2tndy9VNzJqK1hl?=
 =?utf-8?B?UmlPdldpWmtkWm9DOXVsOC9mbUdUMWJxVkd1Yk5nLzNncElsZTZsTXJ2Tm9q?=
 =?utf-8?B?d002UjY0eEdybmMxWk9iVE9IYXYvK2d2WS9JU0VmR0RGNlB0UzhNejB6WUFH?=
 =?utf-8?B?bUtmMWFHelgxdkcxZXdlMldVM1Q5U2M3NTZweG01R3JaTks5dStKb1RlUnVZ?=
 =?utf-8?B?TVRISllMZlFVZ2hxd3graVZkMXB6Y3czdGxHWHZrMVRuTERnamlwVUp6cXNk?=
 =?utf-8?B?dFZVMzdMQ29nWjQvKzd4NnpqaWtVM293V3dzOGsrZEc5TjdRb1NCY25rdDdv?=
 =?utf-8?B?ZU5lakNVeDBiVTJpYnFPcitpSk5CWGV4ZGdjT3c5RjR2WHlrNXVVK05zTGd4?=
 =?utf-8?B?QnV3Z21LTGZBVHhKTi83Y2FaS0Q5a3ZHb3lKS1ZRbDZmdlRHSFBNRmhXQUFH?=
 =?utf-8?B?eElQNDVGZmgvV3c2ZnUvd01sRjNMeWlQSkpBSHY3c2Z0dDhmaFF5bmMvTmZl?=
 =?utf-8?B?SWl4N09rZmNuN0F4YVI1N042M3AxWEdVcGh3WGFwb0w4NTlVc09vbERzcENY?=
 =?utf-8?B?UklQKy9iSVdUaTZkV1czQkdPQ3VjM1hlTms5VU9wVnVWUkpzKytPZVRDY01i?=
 =?utf-8?B?SEVXaE8ybDhPOGh1K3VhK1VNaEU0L2V5ZmlNRTBJSys1ekFXbldjYUhQZXQ5?=
 =?utf-8?B?UnB4NWNzeHl5R3VlYVhXdFlYSWp0RjRtVFE1QnhWZDBxRXFLMCtGcDE5TElz?=
 =?utf-8?B?MVkrclExODZhREhqY01PQ1dDUmNwSzhXcSsrdHQvN3BoWE1qRG5KVXlhVjBP?=
 =?utf-8?B?ZWJ2aFJzellkdnJOLzdwUnI2bU5wZStnVTgwRXlzWmZ0RWpyakp1cGs4NDA0?=
 =?utf-8?B?TElzVTc3LzNFZmtUVkxLU1RQL1VwTUNpaDMweEluTjJ1MUk3Y09EbjRrUFY0?=
 =?utf-8?B?RnlMUms1aXdDMkUrVFRYREdSQnVMM1RtSXhNVDN1WW5tTy9xZjhzb3FzZlA0?=
 =?utf-8?B?cEVCVkFHQ2gwd016VnEvNm1Ba0pmNkkyQ2dzcUJjNXdMd3ZraFVWWno4RjBS?=
 =?utf-8?B?czhQWGZKK25OWFdGWEJVYkh4TTRSNkN6WnlCOENscU5YNlI3Mmp6NmphOXM2?=
 =?utf-8?B?ZHFGbVFlZTVZYk9NcHJmWDVtQWhsY3U5WE92djBLQldoQUc4NmhpWWF4RU1k?=
 =?utf-8?B?R0ZsSytzRG5HeTBVY3d6Mk44V3NkdmlQaE81WDJPeXA4eE5vVWdXWW1TUTJZ?=
 =?utf-8?B?MHJrWERndTU1WUVwRWUzaFltS3pVZkdJT0FvUWZjcEZETUI1MnhadlhnQ1JU?=
 =?utf-8?B?cFphaWY0MkZUbVRRZVN2bFdJSGhlZHlmWjE2bFZ1Q28rNG1tUUlua0prdmdF?=
 =?utf-8?B?dXRGSkgwM3dYNS9LMlRkUHYydzVveGR4V2t1UnlqSGpScTRQMVNGRTdpYTNj?=
 =?utf-8?B?Uyt6TmVPTjhQS0MwM3hrMEpPdjNNQWlKOEVCeExRTi9HV0hHSjVnY3U5VTRS?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15FEEA71156C084A910FC2E3845439D7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fRfka0YrpjHgxNo02tPPoHNlUZd9/4Atd2YjSrnn0PlQJPl9XzcRttaMiayVfbTbyXKq0b7eNj5QiQhK8AmRaVel17Fo1gy1BfWbuGWP1EqB/t1dEwzy7vWIOi6XIOq2dnuxC8Y413IJgwUviQ8tPdyl3Vqi3oI26wtiyFJuS47Qi4MUY89OmmGZqrmjC4Fj8GTkf2dh2YJlORo6V9IjC/m+ojfAwEf2oBMLQTIDrEUnLEzQ4szlW7E/LKZCMA41z8CJ7cs1V+AJkECUPJigNpAgY2SJ2sS7APHmwccERjn4NbHp/ILlgn4cu8d2/jBfLBnBMv75BCPe3+R0PsxJu5Sjrq74eCH2eyM+eAyd1PiTIpait35Tq01+RWzuxGtDWwio0rps/47W6EaZ/aEuFqybuTRKZeGH+RQpLmxnRaa+3D7aNSQeCDEfy9J2vXXWyxo0QvkLrdwrZOZ6e9sXD0F4whGOpgagkgEsuOxItwQa+FFG6jTgMpTnQmwXePcEp5SnCU0dSk9qNvQdacHlSvuyXS45b5/z6MqUH8odFLlWFnyWiYlfRvngzyFEwO4A+LjIeBpKN/zy0ZXmqSdGgRKBS4xUblYRr7AzMCfopfcZxITPFZEsycYjun2876MxTxKLIy07bflMKvquKard7qSuVwINcaWPjYVehxO/3UtdcPAus6ECixnrGZwLgUz42glPIuYiwETtLTw3CbLaUskuNAm+uRK7WsuGcxeCE+85kFRJ7QwaRXqXc4m0i8FXosD0JrgoUoiDGHnpoJJo61Bed7dnza/qhqP+k3cOBWYADnp6Ebm63Hb3jbCWlF/7mSBaJQNOBo7OIE9/2kOuAWQ4ktmrzHT9pwLfEOGrTZvU8fvYRoyt3+WxdmYV/KEOrdc2gqQ7UQlHGW10t91JiGkHcciqyNr6hq8pi80GBa0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede3d497-89e6-46af-8c77-08db84821bf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 15:50:55.2602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xxd/nLFk24qO4aMrgctxjwEBS3bg2Ti2J80B5+8E7+fqe61lNfmdycxXm+PEZzu5UH+E5a2GxjBmKxRxHU9inVQLIrP2+0Zg2odpbRkCHAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7497
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_07,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140144
X-Proofpoint-ORIG-GUID: BRqRu3z7eebBy9cgff1fap8LIUhfS6Nk
X-Proofpoint-GUID: BRqRu3z7eebBy9cgff1fap8LIUhfS6Nk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gSnVsIDEzLCAyMDIzLCBhdCA4OjI5IFBNLCBDb2lieSBYdSA8Y294dUByZWRoYXQu
Y29tPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgSnVsIDEzLCAyMDIzIGF0IDA1OjU5OjM4UE0gKzAw
MDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIEp1bCAxMiwgMjAyMywg
YXQgMTI6MzEgUE0sIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPj4+
IA0KPj4+IFtDYydpbmcgdGhlIExTTSBtYWlsaW5nIGxpc3QuXQ0KPj4+IA0KPj4+IE9uIFR1ZSwg
MjAyMy0wNy0xMSBhdCAxMToxNiArMDgwMCwgQ29pYnkgWHUgd3JvdGU6DQo+Pj4+IFdoZW4gSU1B
IGhhcyB2ZXJpZmllZCB0aGUgc2lnbmF0dXJlIG9mIHRoZSBrZXJuZWwgaW1hZ2UsIGtleGVjJ2lu
ZyB0aGlzDQo+Pj4+IGtlcm5lbCBzaG91bGQgYmUgYWxsb3dlZC4NCj4+Pj4gDQo+Pj4+IEZpeGVz
OiBhZjE2ZGY1NGI4OWQgKCJpbWE6IGZvcmNlIHNpZ25hdHVyZSB2ZXJpZmljYXRpb24gd2hlbiBD
T05GSUdfS0VYRUNfU0lHIGlzIGNvbmZpZ3VyZWQiKQ0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBDb2li
eSBYdSA8Y294dUByZWRoYXQuY29tPg0KPj4+IA0KPj4+IFRoZSBvcmlnaW5hbCBjb21taXQgIDI5
ZDNjMWM4ZGZlNyAoImtleGVjOiBBbGxvdyBrZXhlY19maWxlKCkgd2l0aA0KPj4+IGFwcHJvcHJp
YXRlIElNQSBwb2xpY3kgd2hlbiBsb2NrZWQgZG93biIpIHdhcyBub3QgaW4gbGlldSBvZiB0aGUg
UEUtDQo+Pj4gQ09GRiBzaWduYXR1cmUsIGJ1dCBhbGxvd2VkIHVzaW5nIHRoZSBJTUEgc2lnbmF0
dXJlIG9uIG90aGVyDQo+Pj4gYXJjaGl0ZWN0dXJlcy4NCj4+PiANCj4+PiBDdXJyZW50bHkgb24g
c3lzdGVtcyB3aXRoIGJvdGggUEUtQ09GRiBhbmQgSU1BIHNpZ25hdHVyZXMsIGJvdGgNCj4+PiBz
aWduYXR1cmVzIGFyZSB2ZXJpZmllZCwgYXNzdW1pbmcgdGhlIGZpbGUgaXMgaW4gdGhlIElNQSBw
b2xpY3kuICBJZg0KPj4+IGVpdGhlciBzaWduYXR1cmUgdmVyaWZpY2F0aW9uIGZhaWxzLCB0aGUg
a2V4ZWMgZmFpbHMuDQo+Pj4gDQo+Pj4gV2l0aCB0aGlzIHBhdGNoLCBvbmx5IHRoZSBJTUEgc2ln
bmF0dXJlIHdvdWxkIGJlIHZlcmlmaWVkLg0KPj4+IA0KPj4+PiAtLS0NCj4+Pj4ga2VybmVsL2tl
eGVjX2ZpbGUuYyB8IDE0ICsrKysrKysrKy0tLS0tDQo+Pj4+IDEgZmlsZSBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+Pj4+IA0KPj4+PiBkaWZmIC0tZ2l0IGEva2Vy
bmVsL2tleGVjX2ZpbGUuYyBiL2tlcm5lbC9rZXhlY19maWxlLmMNCj4+Pj4gaW5kZXggODgxYmEw
ZDE3MTRjLi45NmZjZTAwMWZiYzAgMTAwNjQ0DQo+Pj4+IC0tLSBhL2tlcm5lbC9rZXhlY19maWxl
LmMNCj4+Pj4gKysrIGIva2VybmVsL2tleGVjX2ZpbGUuYw0KPj4+PiBAQCAtMTYyLDYgKzE2Miwx
MyBAQCBraW1hZ2VfdmFsaWRhdGVfc2lnbmF0dXJlKHN0cnVjdCBraW1hZ2UgKmltYWdlKQ0KPj4+
PiAJcmV0ID0ga2V4ZWNfaW1hZ2VfdmVyaWZ5X3NpZyhpbWFnZSwgaW1hZ2UtPmtlcm5lbF9idWYs
DQo+Pj4+IAkJCQkgICAgIGltYWdlLT5rZXJuZWxfYnVmX2xlbik7DQo+Pj4+IAlpZiAocmV0KSB7
DQo+Pj4+ICsJCS8qDQo+Pj4+ICsJCSAqIElmIHRoZSBrZXJuZWwgaW1hZ2UgYWxyZWFkeSBoYXMg
aXRzIElNQSBzaWduYXR1cmUgdmVyaWZpZWQsIHBlcm1pdCBpdC4NCj4+Pj4gKwkJICovDQo+Pj4+
ICsJCWlmIChpbWFfYXBwcmFpc2Vfc2lnbmF0dXJlKFJFQURJTkdfS0VYRUNfSU1BR0UpKSB7DQo+
Pj4+ICsJCQlwcl9ub3RpY2UoIlRoZSBrZXJuZWwgaW1hZ2UgYWxyZWFkeSBoYXMgaXRzIElNQSBz
aWduYXR1cmUgdmVyaWZpZWQuXG4iKTsNCj4+Pj4gKwkJCXJldHVybiAwOw0KPj4+PiArCQl9DQo+
PiANCj4+IFRoZSBpc3N1ZSBJIHNlZSBoZXJlIGlzIHJldCBjb3VsZCBiZSBtYW55IHRoaW5ncywg
Zm9yIGV4YW1wbGUgaXQgY291bGQgYmUNCj4+IC1FS0VZUkVKRUNURUQsIG1lYW5pbmcgaXQgd2Fz
IGNvbnRhaW5lZCBvbiBhIHJldm9jYXRpb24gbGlzdC4gIFdpdGggdGhpcyBwYXRjaA0KPj4gdGhl
IHJldm9jYXRpb24gY291bGQgYmUgb3ZlcnJ1bGVkIGlmIHRoZSBpbWFnZSB3YXMgSU1BIHNpZ25l
ZCB3aXRoIGEgZGlmZmVyZW50DQo+PiBrZXkuICBEbyB3ZSByZWFsbHkgd2FudCB0byBhZGQgdGhl
IGFiaWxpdHkgdG8gb3ZlcnJ1bGUgYSByZXZvY2F0aW9uPw0KPiANCj4gVGhhbmtzIGZvciByYWlz
aW5nIHRoZSBjb25jZXJuISBJIGhhdmVuJ3QgdGhvdWdodCBhYm91dCB0aGlzIGNhc2Ugb2YgdGhl
DQo+IGtleSBiZWluZyBpbiBhIHJldm9jYXRpb24gbGlzdC4gSWYgdGhlIElNQSBzaWduYXR1cmUg
Y29tZXMgZnJvbSBhDQo+IGRpc3RyaWJ1dGlvbiwgdGhlIGRpc3RyaWJ1dGlvbiBzaG91bGQgYWxz
byBibG9ja2xpc3QgdGhlIElNQSBrZXkgd2hlbg0KPiB0aGUgUEUtQ09GRiBzaWduYXR1cmUga2V5
IGlzIGFkZGVkIHRvIHRoZSByZXZvY2F0aW9uIGxpc3QuIElmIHRoZSBJTUENCj4gc2lnbmF0dXJl
IGlzIGZyb20gYW4gZW5kLXVzZXIsIEkgdGhpbmsgdGhlIHVzZXIgd2FudHMgdG8gcGFzcyB0aGUN
Cj4gdmVyaWZpY2F0aW9uIGluIHRoaXMgY2FzZS4NCg0KQ29ycmVjdCwgdGhlIElNQSBzaWduYXR1
cmUgc2hvdWxkIGJlIG9uIHRoZSByZXZvY2F0aW9uIGxpc3QgaW4gdGhpcyBjYXNlLiAgDQpIb3dl
dmVyLCB0aGUgZW1iZWRkZWQgc2lnbmF0dXJlIGluIHRoZSBrZXJuZWwgZG9lc27igJl0IGhhdmUg
dG8gYmUgdGhlIA0Kc2FtZSBhcyB0aGUgSU1BIHNpZ25hdHVyZSBpbiB0aGUgZXh0ZW5kZWQgYXR0
cmlidXRlLiAgSWYgdGhleSBkb27igJl0IG1hdGNoIA0KdXAsIElNQSBjb3VsZCBiZSB1c2VkIGFz
IGEgYnlwYXNzIG1lY2hhbmlzbSB0byBrZXhlYyBhIGtlcm5lbCB0aGF0IA0Kc2hvdWxkbuKAmXQg
bG9hZC4NCg0KPiBPciBob3cgYWJvdXQgb25seSBhbGxvd2luZyBJTUEgc2lnbmF0dXJlIHdoZW4g
RUZJIHJ1bnRpbWUgc2VydmljZXMgYXJlDQo+IGRpc2FibGVkPyAgQW5vdGhlciByZWFzb24gSSBh
bSB5ZXQgdG8gYWRkIHRvIHRoZSBjb21taXQgbWVzc2FnZSBpcyBhDQo+IHJlYWwtdGltZSBrZXJu
ZWwgY3VycmVudGx5IGRpc2FibGVzIEVGSSBydW50aW1lIHNlcnZpY2VzIGZvciBsYXRlbmN5DQo+
IGlzc3VlcyBzbyBpdCBjYW4ndCBhY2Nlc3MgdGhlIE1PSyBrZXlzIHRvIHZlcmlmeSB0aGUgUEVD
T0ZGIHNpZ25hdHVyZS4NCg0KUG9zc2libHk/IE9uIGEgVUVGSSBzeXN0ZW0sIHRoZSBJTUEgc2ln
bmF0dXJlIG9uIGEga2VybmVsIGlzIGlnbm9yZWQgZHVyaW5nIA0KYm9vdCwgR1JVQjIgZG9lc27i
gJl0IGhhdmUgYSB3YXkgdG8gdmFsaWRhdGUgaXQuICBJZiBHUlVCMiBpcyBib290aW5nIGEga2Vy
bmVsIA0Kb24gYSBzeXN0ZW0gd2l0aCBFRkkgcnVudGltZSBzZXJ2aWNlcyBkaXNhYmxlZCwgbm90
IG9ubHkgd2lsbCB5b3UgYmUgbWlzc2luZyANCnRoZSBNT0sga2V5cywgYnV0IHlvdSB3aWxsIGJl
IG1pc3NpbmcgdGhlIE1PS1ggYW5kIERCWCB0b28uICANCg0K
