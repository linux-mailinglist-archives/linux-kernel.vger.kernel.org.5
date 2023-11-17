Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0EB7EEAD5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 02:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbjKQBwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 20:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345625AbjKQBv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 20:51:59 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06581A1;
        Thu, 16 Nov 2023 17:51:55 -0800 (PST)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH10Mdm012494;
        Thu, 16 Nov 2023 17:51:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Or7b2ubdweX3LnbyuILbOJackrKk2mn9WA47j8x9LWA=;
 b=i2PC7k+D044cvmVSWHBqHMeS0bHag6hXApIS1MSQG1nXsN8yIb8iX5+v5LpQgjQyRWh7
 FYh1ZLb5+LYQfeMWkMxCbOTferEzid42h60M8aTDZk8wBBvRK9isrxsR0xJGB3qk9gxr
 WnG/ymNcxqkAhZDqQqZR9CjDeGFf0UKpThB5eM6EcD+SK9lAeoU+YeZpAdgX5lasyLwd
 XLVyycerk9xSD+YntEJGJFKHiYOFHq6J1K66IzahKG4+fjrM7Zhyp/pTP21Jx0puLgfy
 y1PmUjTYNDdA2OAiR9Yl+qu4gwYEEhYKLsyQHfmu0ARBjXzaaRmVSRFsnT05idnl/6Mb bw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ua9e19y9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 17:51:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1700185911; bh=Or7b2ubdweX3LnbyuILbOJackrKk2mn9WA47j8x9LWA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=O8MCLcjRZT2exYQOJniI4YkIAjwwlN9qni9tvYgJBTHf6SaM+9bn31zPjxV1KJPtS
         Di6DI83RFGurUCoxUG3u0IiSBSmjgWDpskTnxvGM5eXGXmAgji+dm03O9AAbousABv
         II9tZxsCqRR9eg+wuREvVAsN2b2TkWh4enfMg1xtRt3gGUW9fmjgSK+35w6bDuifHj
         R4k/m/jY2joIw+mQhrU1Y2fjATlYna2bHPaSS4p3lsRTdvHuvbD4CzyDJ22BfiKDCs
         HiXpV5tSv9Ko3e4yuZmBstxNsvfBe/albkUvlUYsaGGp0NsiTGL+FLXsDOb8e8G4Af
         II17caxxde99w==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A34D1401F2;
        Fri, 17 Nov 2023 01:51:51 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2FA82A010C;
        Fri, 17 Nov 2023 01:51:51 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=cc3IV7jj;
        dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 27B374048F;
        Fri, 17 Nov 2023 01:51:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kf2R2DmDliWTkSb5DY44J9eICDKcxr2hNWKqsYXOgQk2ql08ADyw6UJwaOSnXxrdwAFH5u4MpyLkghMKmjO2+q5ege0gqByy6bFbf5dUI7qCud2cJYJ3XHldtTWmggQicLTlLvXc2bqjrA4n/liFanlwLsUqUyZEqLl0CZuds/ODxxH0QCgoFZ4VFXCAR8E2/8i/kHTqXF7R7Xmp9qcPzXEcuS5qchkxE01HovG7Kp7bl8hC//5IHgMhXv/m3Q1yg1cfXj9Oh7Odzg12+Fh52y9Qiww97xsq4Y5CdzIyKX78KUoZSU/fqbVSE0xK6dd/xp9MFcqbX+Yd/dEyAdvNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Or7b2ubdweX3LnbyuILbOJackrKk2mn9WA47j8x9LWA=;
 b=fDIf1IjjCCyfA7xfifoHuPeEKeBZZlK+Yw25mUqF/clQDjoqc1eTGfEB49eiJ40i0kdMrbDcHf3AQAv/FUu9kkuCKDm79O10MaP1tktWNuN6pbD8EJLfrFEfRSxOlxzIdJw301j9j+5+8nAtC8Xv4O3Jlp84U0be20xwx3p+g3CUolheTpntSlxhwdquMVUjgWnL6TsvWXs2uZ2S8c9zwADGYv/VDl3amGHE3HhLDwcFxnAr9RQWNpr4MRcUp6h2UkodDWEjpPTJwvnfF3R5iMrPwUUBECLGaMVEJvGfaepFUb7bCRKWnBkfiSBWEEKKYtaf51n9cvnCcfHNW9pGqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or7b2ubdweX3LnbyuILbOJackrKk2mn9WA47j8x9LWA=;
 b=cc3IV7jj/tBJDXKZirMcvz3QB/yegtzFpIhpo0DSjWgjtl/KICoqEan+Vqq+b+0NQaFPvFY13CScdcJuFZ++4F+x9vj3q4yhYWVZU12EuhlKIBJTlpahbSzvyKSqwUjgRiOempwjWi8zmINA6Xnf06wIvFjJS7JLsIY5ByzaAKA=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Fri, 17 Nov 2023 01:51:46 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e%5]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 01:51:46 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Manan Aurora <maurora@google.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "manugautam@google.com" <manugautam@google.com>,
        "badhri@google.com" <badhri@google.com>
Subject: Re: [PATCH] usb: dwc3: Support EBC feature of DWC_usb31
Thread-Topic: [PATCH] usb: dwc3: Support EBC feature of DWC_usb31
Thread-Index: AQHaDV+hQYu1qIk1pk2bzrpJF26+HrB0OuyAgAhDWACAAVg3gA==
Date:   Fri, 17 Nov 2023 01:51:46 +0000
Message-ID: <20231117015143.nzgqaes256lnz5ht@synopsys.com>
References: <20231102073840.1579540-1-maurora@google.com>
 <20231110230837.b5q5dsvsqlxfz5xu@synopsys.com>
 <CAJnM4-wew9b=Ge8QHLRiReNJAqgA0ngOW8WTVk4frta+y+9jYw@mail.gmail.com>
In-Reply-To: <CAJnM4-wew9b=Ge8QHLRiReNJAqgA0ngOW8WTVk4frta+y+9jYw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM8PR12MB5413:EE_
x-ms-office365-filtering-correlation-id: 18e3c2e0-9acc-42bd-5093-08dbe70fc1aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XENoMyTlt4eyaXShPccotr1PgeM7Jl0d8ltMyMPiZH4522guAigY9Oea/0qg08//dFL2K2utzsNZsgBuoarOmykfw3rVrAHbSF5srvdo9gQ/GbNfXhksvU8c8YgOF54mnPh1vD3TYU5l3aytzdjG+AwqC244KauSjjOMXvKEIwiftTuD7FqMouhrqT9LKiIm2YPE8yFUlW31v77LGJtaUbX6SgBg+Il4mQgiVJQvbTfzeO0Gmz5Wj4BoLW7eKi/kS4imqQM2bm4QKFwXIlEXr5WTjiJnkoWO2Z93y8R6yNSsM0Wcpbe3G9oQhWMq/s2+jRtjRA+UOp0swreQwEzesx06HcTuHMezphGmIf85xpJwvTPAm9rYQaSsKwzOSfDNkfL9vnr/Fe8zVrEolBGHbmtza0DHwi/sWg/vciyJeWfwF6YRwyYnLraC6hvhur7rJXrgg2SdJWAVilaCN1iN5MFO81z3FUMIwWBb5bVan2uo6N9UQPuJispcEaCPh3a/3siJFQWrJwOHp5s50CDwK+LFKuj/W+3om8aaxJzoUeswDMSQD211rZzJT/Jvsw82givuHosboL6lzX0s5kffk1nasEhPbepRVApkBHvNGkDzr61r5I/TswVGpTtuWIuj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(39860400002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(4326008)(8936002)(8676002)(66446008)(66946007)(66556008)(64756008)(86362001)(6916009)(54906003)(122000001)(316002)(66476007)(38100700002)(41300700001)(36756003)(5660300002)(83380400001)(6486002)(76116006)(26005)(38070700009)(1076003)(66899024)(2906002)(478600001)(71200400001)(6506007)(53546011)(6512007)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzJTbGFlYlhSbURLeU1YWms3eWdTTTRMZ0swVmxzcEdGU0Zua21IKytkbmRx?=
 =?utf-8?B?d0pwa2diRGFFZGhZWXZ1aXM0WDMwSG9zZ2RkNHYxdTZqcWpndUtRaXpRV3Az?=
 =?utf-8?B?T2ZtOVViL1F5S3gvVkpiTVBsczhlZE8vaitkV0FYYUxDaTJ3d21FcWZlRllZ?=
 =?utf-8?B?akhGSTZPenowTlJjMzR1TjllVUY4RDZBeEdocXd1ZFpVY2xSV0NUaUpiRVJC?=
 =?utf-8?B?bWk2RjhSLzRKTHh1QWFob0FkbjNiZ2FqUG1CcW95WHhmU3BsMVlpU2kwSmpk?=
 =?utf-8?B?c0ZTTE05aGNZZFppSW0vZWQ3QjFPcjRYa2J1MWlmZ3VycjhnNTdsZHpKSmNY?=
 =?utf-8?B?Si95TW1rL2tDa2JQVkl1WWJaVGxvZWJCODF2c05HWGQ5WEVrcEIyelU5bUtP?=
 =?utf-8?B?WUI1NUIvTGNKYmd5YmxuSE1UTUhOemRNR2l3NmdMZWgraGVwLytMZDZUVWEr?=
 =?utf-8?B?UXFMNHQ1ZzRyekRIeXA3eG5HY3R2dVg2d01xRXZRelc3M3NRVFBRZkNXbm5N?=
 =?utf-8?B?Zno4NGNPV0QvNHhtWUR5VzhtcFpYQStJWlllR0dYK2NJWG5CUE9DRFJISERs?=
 =?utf-8?B?ZWhmazc4VlVsWnpNSVUxWXU1V1RPemxwMUljQ05CRjFseDF6QmJ5YzdIc2xQ?=
 =?utf-8?B?Q0pVOC9wamJtWTBIK3VSRjg5SlMvKzZpODFraDNEb2JRbjczMTc2b2g3K0dL?=
 =?utf-8?B?ejRqNUxMV0JsbUJ4MGNrWktSVzg5aG1paHNjb2lheG44dUlZcjRhY0daUUs1?=
 =?utf-8?B?RU5rZUtJNkRkT3crakE5NHNnN2Vic3JNV25JNVVWS3l0d2tscXEwaTVjNnN3?=
 =?utf-8?B?TDAzUkp4NmY0N3ZqcUlXSGtFeXJrWnQxS09XT3E1YUQxMFhRbVZYOUFTMzBB?=
 =?utf-8?B?Zi9DM011K3dvTVVtZS9WZWQxb1RnNTFLMVZPeGRnaW81amVuRHdKUm9RYkZV?=
 =?utf-8?B?S0Y4THNPU0RPR1grSlFoeFJ1VHlvWHlFbHU0WU1Sd2dxTUM5dHpuUUhsdGpL?=
 =?utf-8?B?ZUUrRFVQZ2Q5NXNNZlAwcy95Vld2ZW1veW53MU53UWMxLzhBSjYvYmh4RWhs?=
 =?utf-8?B?djhWUUR3RmlLSnlnYWJwclhIZzFnWDNDMGE1NGZvc0pwN3d4Z3lwZ2JsSk1C?=
 =?utf-8?B?K2RieHNlcFZnZ0k4clNzMW0rVm11eEU0VnZJZmJwenVOYmRxREZDaVVjQjN2?=
 =?utf-8?B?MllqMHpQTHFuU2dpWFEvOEtNKzZRTHNmeXlwU3FwbTJrakdpalhRR1hrTFpW?=
 =?utf-8?B?elBFK1laYzYvR2lNNVRETHprVE1EV1V3VW1kdHFtRk54aXBEeFZGeFMvV3N4?=
 =?utf-8?B?dy9JUmplY3hHaThXdjBoeDJvZHpKckF3Z3JlbzZwL09JM2xSUUR3bHZNKzRa?=
 =?utf-8?B?RzlSNWZoUEMwclpSRUJnZkk5d2xTOWpsbFBjYUlldDV1YXYwZUsveDgxdWZQ?=
 =?utf-8?B?eUVNS1B1TUxwSXprS1JFLzVrdXhuVmtwMzYyYmxlWFA0SUNjMjIvdG5rS002?=
 =?utf-8?B?QUozMDEvLzJOYjNzNlUrbURxTVk4Q3JhcHZPV216VzZZWjZMZ1Z1N0tJRm80?=
 =?utf-8?B?NFhaZ1QydUV2UWZFUVdaV3hWREVGcWRzU04wd1VYQm1NOUZybkNRMHZEaWkw?=
 =?utf-8?B?RkRLVVB1czVmblp1azhKNXJWaGlOV0I2K1ZRV0RIMlE2ZCs0ZFY2dkI4c3J2?=
 =?utf-8?B?bDN0ajdZdVhFWjNENHVSV3pYUFhVNVBhR0NmMUZkcU1VdGFJeDVFeTZMMzYv?=
 =?utf-8?B?MEFiUTlVMURKeEJ1Y2Z0eVkwQWxpcjhKVHdLVUdzajNpdDltRkQ0Qld4TnVp?=
 =?utf-8?B?ZmpjRytmOTVxVCs0M1FDQlh2TlNtWURaTXB3czliN3R0eWhpUytCZTRvTTVI?=
 =?utf-8?B?U2NWQnloTTRPUTNIUkpFd0c3RllxbGRMT1RqV2syaWQ5WG9DYnVtV2lOL1hv?=
 =?utf-8?B?UzdxR1M4Q3NKZTU3VVl0c2NtRXd5S2ExOE8xWTdIWHNUTExDY1dKazhKOXA0?=
 =?utf-8?B?RUVvbUZIN09McHFJQ09qWHFGNDJyYUhLK0dxUGVyVHlsSlA5VjU4byt4VTlY?=
 =?utf-8?B?cGVDbmNPWjdLWmJ5RE9BZE80cUdXMmVTTjZINU5heW81VG5JWHZiMVllKzFq?=
 =?utf-8?Q?lCa0jlY34qlkCmjAlzha0Ckq1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E217E50CB22DD489E382749986ED554@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Cq31zI05jazzcDCff0YxMCEi9PQukzYf4q8f93MpiIPU9kiRYya3FT+L3sV1mdzvM023i7dIW9bR0kl4Ib0kAh5dP23y5txEJbmo4u6q48vRz+meEbFEa98Oje1s/oXFlJFUR4XbpkFYyZDtmbpKMq1oIumUDzwuXt0uy32nHKWRUfzSm843DN9+FvS+46rtgE71MBg8W9cuz5MdI9/SEr/ISxdNtm0PQBEq68BnyBXXmDOnOMxVzJAWvHiyu3kAJbL0bs0XF2vvhMtRXfjVQ/9DB/Hu22eRI08drgQNbiuQTIM9jCq0Sa/hidf/UIxQce+FQTea3pUwIVj0pbPmr8h9wX4FvrfCJP2ChNijwitz01kOcsnzwvTJUNOo6fnS2fX/xBF+Z4WXmOXtetLSYU4BXCa+UYki32l//VycOgfcNmk8UkY+ujNYoEsdR9Z0hOfiKzeoYCRMMwwbrG2VPtd+SfLOtODhVmCQtoaTOYrkILJDT1/4CNX8TLLfvemVj9ynO3sBKjxk1RGg6yhHBD6el1Cy47m3WMqNSfabWwafP+Be/2Xl36XMPXWBDly1gziskQ6ZJFR0ko5JIeRdqYQ1QbbFpV34Oj/0U2xiqdsRWpCoxfr3rq3m3zswoOYmm9E7TVdzbrtRl5n+fbWNb9EeapFtuuRjV8TJrZHrJWYTvn2aWPVFA2FcZlWNaH8DkqZhxdG3UYCOqmITu/+J2haQFcyoCwbLVzQ/Ess9aL1jFxEe/Awj69y1+S+a1BWKJOGoN52VKpc1YJGZdUf1X2cpLnGNjb3jmxUEws7Bbc083dyjwzjh9w6yXQxrpfn6aHJHPQkonPV1VVC7/xMQ6w==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e3c2e0-9acc-42bd-5093-08dbe70fc1aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 01:51:46.2288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vq4SCg0e0lvsQsQEJLtXRIWWfZE6iFrPi5daQ4HwD3ZTRJ60t3hb3LZANZhHvaMFxZwwVahjoTok54I1zj+u/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5413
X-Proofpoint-ORIG-GUID: Y_NcF6Wohi9rGUyMi7g9_ytGDc6nixsx
X-Proofpoint-GUID: Y_NcF6Wohi9rGUyMi7g9_ytGDc6nixsx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=645 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311170012
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBOb3YgMTYsIDIwMjMsIE1hbmFuIEF1cm9yYSB3cm90ZToNCj4gT24gU2F0LCBOb3Yg
MTEsIDIwMjMgYXQgNDozOeKAr0FNIFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lz
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBUaHUsIE5vdiAwMiwgMjAyMywgTWFuYW4gQXVyb3Jh
IHdyb3RlOg0KPiA+ID4gU3VwcG9ydCBjb25maWd1cmF0aW9uIGFuZCB1c2Ugb2YgYnVsayBlbmRw
b2ludHMgaW4gdGhlIHNvLWNhbGxlZCBFQkMNCj4gPiA+IG1vZGUgZGVzY3JpYmVkIGluIHRoZSBE
QkNfdXNiMzEgZGF0YWJvb2sgKGFwcGVuZGl4IEUpDQo+ID4gPg0KPiA+ID4gQWRkZWQgYSBiaXQg
Zmlmb19tb2RlIHRvIHVzYl9lcCB0byBpbmRpY2F0ZSB0byB0aGUgVURDIGRyaXZlciB0aGF0IGEN
Cj4gPiA+IHNwZWNpZmljIGVuZHBvaW50IGlzIHRvIG9wZXJhdGUgaW4gdGhlIEVCQyAob3IgZXF1
aXZhbGVudCkgbW9kZSB3aGVuDQo+ID4gPiBlbmFibGVkDQo+ID4NCj4gPiBUaGlzIHNob3VsZCBi
ZSB1bmlxdWUgdG8gZHdjMywgYW5kIGl0J3Mgb25seSBmb3IgYnVsay4gSSBkb24ndCB0aGluaw0K
PiA+IHVzYl9lcCBvciB0aGUgdXNlciBvZiB1c2JfZXAgc2hvdWxkIGtub3cgdGhpcy4NCj4gDQo+
IEluIG91ciB1c2UgY2FzZSB3ZSBoYXZlIGEgZnVuY3Rpb24gZHJpdmVyIHRoYXQgY29uZmlndXJl
cyBhbiBhbGxvY2F0ZWQgYnVsaw0KPiBlbmRwb2ludCB0byBvcGVyYXRlIGFzIGFuIEVCQyBFUC4g
U28gdGhlIGZ1bmN0aW9uIGRyaXZlciBhbHJlYWR5IGRlcGVuZHMgb24gdGhlDQo+IGZlYXR1cmUu
DQoNClRoaXMgc2hvdWxkIGJlIGFic3RyYWN0ZWQgZnJvbSB0aGUgZnVuY3Rpb24gZHJpdmVyLiBU
aGUgZnVuY3Rpb24gZHJpdmVyDQpzaG91bGQgbm90IG5lZWQgdG8ga25vdyBhYm91dCB0aGlzIGZl
YXR1cmUuDQoNCj4gDQo+IGR3YzNfZXAgc2VlbXMgbGlrZSB0aGUgY29ycmVjdCBwbGFjZSB0byBw
dXQgdGhpcyBmaWVsZCBidXQgYSBmdW5jdGlvbg0KPiBkcml2ZXIgdGhhdCBhbGxvY2F0ZXMNCj4g
RVBzIGFuZCBjb25maWd1cmVzIHRoZW0gZm9yIHRoaXMgdXNlIGNhc2Ugd291bGQgbmVlZCB0byBp
bmNsdWRlIGR3YzMgaGVhZGVycy4NCj4gSWYgb3RoZXIgdmVuZG9ycyBvZmZlciBhbiBlcXVpdmFs
ZW50IGZlYXR1cmUgdGhpcyBkZXBlbmRlbmN5IHdvdWxkDQo+IGJlY29tZSBhbiBpc3N1ZS4NCj4g
DQo+IEV4cG9ydGluZyBhIHN5bWJvbCBmcm9tIGR3YzMgaXMgYW4gZWFzeSBvcHRpb24gYnV0IGR3
YzMgZG9lc24ndA0KPiBjdXJyZW50bHkgZXhwb3J0IHN5bWJvbHMNCj4gaGVuY2UgSSB0cmllZCB0
byBhdm9pZCB0aGF0DQo+IA0KPiA+IEFsc28gc2luY2UgRFdDM19ERVBDRkdfRUJDX0hXT19OT1dC
IG11c3QgYmUgc2V0LCB0aGUgY29udHJvbGxlciBkb2VzIG5vdA0KPiA+IHdyaXRlIGJhY2sgdG8g
dGhlIFRSQi4gRGlkIHlvdSBoYW5kbGUgaG93IHRoZSBkcml2ZXIgd291bGQgdXBkYXRlIHRoZQ0K
PiA+IHVzYiByZXF1ZXN0IG9uIGNvbXBsZXRpb24/IChlLmcuIGhvdyBtdWNoIHdhcyB0cmFuc2Zl
cnJlZCkuDQo+IA0KPiBJbiBvdXIgdXNlIGNhc2UsIHdlIGludGVuZCB0byBoYXZlIGEgbGluayBU
UkIgYW5kIGlzc3VlIGEgc3RhcnRYZmVyDQo+IGNvbW1hbmQuIENvbXBsZXRpb24NCj4gaGFuZGxp
bmcgYW5kIGNvbnRpbnVpbmcgdGhlIHRyYW5zZmVyIHdpbGwgYmUgb2ZmbG9hZGVkIHRvIGRlZGlj
YXRlZA0KPiBGSUZPIGhhcmR3YXJlLg0KPiBCdXQgd2UgY2FuIGRlZmluaXRlbHkgcmV3b3JrIHRo
aXMgdG8gZGlzYWJsZSBuby13cml0ZWJhY2sgbW9kZSBieQ0KPiBkZWZhdWx0IGFuZCBhbGxvdyB0
aGlzIHRvDQo+IGJlIHNlcGFyYXRlbHkgZW5hYmxlZA0KPiANCg0KT2suDQoNClRoYW5rcywNClRo
aW5o
