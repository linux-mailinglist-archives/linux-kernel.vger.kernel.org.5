Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4752D751279
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjGLVPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjGLVPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:15:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1082D62;
        Wed, 12 Jul 2023 14:13:49 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CLA2lt009046;
        Wed, 12 Jul 2023 21:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ExlKUGL2uzFNDxV7gkgiLqRqSu6VrYXaiwfQOmOgzBM=;
 b=BDfGk5NnkymBtWeb6egV1cK2nt5/tqABL/FIQOLvEqBvrCyJCbMjA0yJt+0wO0a3hGaW
 UZLjxryACo7WwLSRhw7qVt/zrLhfqROk5NfxDFiSMVPdG6DovDzDj2ZMECzSDZhn3M4j
 VNjuDJMRHXDNONMoaYyv0oBepbTNlAZxNW8IGuyR40XMq03iIICianbtHqhbq0xo9Zc4
 ycGdzfk54XBKwS4BQZNe4i/8lZFR1v31mB34V88YREaQnIYuwdSTEdZfC1zNmU9+Qesd
 foerGKB/I7F9ikzWV4Ks4SfaC+i2iRSVYcSWeu8xkbRJAmdNe+iUUdnkHb9L9ufB0jSO RQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpydu07bp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 21:12:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36CKLg7R007097;
        Wed, 12 Jul 2023 21:12:39 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx878dp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 21:12:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMtiLm3WvT8Qvi1tGh+cffYREiNLZMv2lsafzh4IxwtM1EruVhjL8J1UGEJwmPkRlgfbaIWPedIpQamKg5fmt5GL7SMHQG9eWpCIjKvRtmU0zOgWqnWO8bbadA+eOcPW6hBNqC0F/Hf3tOlpl01TT/vNoUMjhAEPR70pGMAmB+AJcBWpKNETeHHpKG17GJ79tj2OponnBHFGPQvelS4XIfd/3WlT8jHMCmlV7NnuNNVQCaWlqmI9/UAiDn1zoqXwQUkyj6XIJZKKWSfS/TPTkBQxYw9ijbAMY3U++ocVqhGjUyrH24MWuBvl/iSYfEL4CPqxslTEieZg7EsDFPfiJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExlKUGL2uzFNDxV7gkgiLqRqSu6VrYXaiwfQOmOgzBM=;
 b=bQCNxYhMS7jDML93Tmd2xbrODIIYQc46j8cMxqUKx4IcvXc2OvtrqGHay7JC4UxNoT6XYNfpO6dbdr+4Na17rj1z7Z+GMLeWj0Jb07h3VGeS2hzC7QqEZwnkByG79LE28nll6vXoI+Yn9hY8tsmAx2gZm9KwjYTedu+mMO2Y6z29Q2LwuAhTK08aZnI1Zx9LlBwe9cNu5gAr1NLchVuhXQ+gDsPjt3JclR78ET8R579QZPow2wSdXOhKg3a0wkKXgawLBt2/yUJC4CwfW6BjBa8ceQpEbTqnHA461KkeV2ytUtS9Zas5S+4AS5q8RIsebPKAq5Jd+hF2JcUE0hqK9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExlKUGL2uzFNDxV7gkgiLqRqSu6VrYXaiwfQOmOgzBM=;
 b=rvcInPUSmbzGcEGD7aeuFP6Q5hew4tXz8JJCkMZNFoWjPu56xGsgyropujZ4nyKEt8zZATjs63fwEE5yIAkLK6g2cDc/v0deHfMVP+vpJP1SEmFc5s8m4jv0VauV3qyAI5wp+EnXenENuScl0kr5oxWrlOPNU1YmZVqUXdPrdZc=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by PH7PR10MB7694.namprd10.prod.outlook.com (2603:10b6:510:2e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 21:12:36 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5a68:4817:cdec:ca0d]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5a68:4817:cdec:ca0d%4]) with mapi id 15.20.6588.022; Wed, 12 Jul 2023
 21:12:36 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2] integrity: Always reference the blacklist keyring with
 apprasial
Thread-Topic: [PATCH v2] integrity: Always reference the blacklist keyring
 with apprasial
Thread-Index: AQHZr5QIRPDFbi04j06G9JzJQhYIyq+2cMKAgAA7PoA=
Date:   Wed, 12 Jul 2023 21:12:36 +0000
Message-ID: <A9725ECB-0811-42BD-8586-7DF7A8BD7393@oracle.com>
References: <20230705225229.1435691-1-eric.snowberg@oracle.com>
 <6173db54e3d75481a6b1f1079c5b06e1c1caf564.camel@linux.ibm.com>
In-Reply-To: <6173db54e3d75481a6b1f1079c5b06e1c1caf564.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|PH7PR10MB7694:EE_
x-ms-office365-filtering-correlation-id: 7c2f7465-0a0e-494c-23e3-08db831cb752
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E0kA57bwdNkYK1rphOcXgYaKrEP4FTXQyO/n3cXtIqsoYtv0jtsP1snLBjfZCFQY/MdSin5TXclj29cUDGLbn1Zv4r6WR1vigXk2z0d7Gjay3UCL4fLAOp2TL9dSqvW9JLapbB9H3u9j+fWOyD6jlfX/6IiIZSQsdyQqP+EAoowUWsVv/PQFzXO6NcPmOo+yDVRWxpnjQUKXtWGOy38TY99X3SkGNjrQVDGxeybzYHdlNVF80KxMsWes5vzvsrLnZBdM4XlZ66jcbpIKDxv216OibqBoWlVv3pfCvO/F70K38JeofK8hiQXQgQ2eMjebAW2zwSdG5cmnFmfyW5pooo8YAP7sxLpaehwaOWLTQIeXon4JlSMzMvkmnCgyi/kr1EafsIvb0LOiJ4s+k6dHkZbIoZrVhg5E6HdYGuUsj1e/ieRVplNoei5PNhhCAVeHNc8g0YkFhFwUNTxJ0rCzRfQhLuHcZ8XjOBiyjiLcipEB72xh0ZXYx0jHeGwQZzGdiw+b/mP9ARD9BEZnWWWFyNVOBFiJHkj2V4e1nzoGu8j2eFlRLsTby++frDX8egmAtlMVixaacAvrxGD8RY8c3tWVpLIxFMPVd+VY4Wl/A2kHvG1i9P94yW3nW3BLe/4kcNamWMqh6+uPZHEy20/ufQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199021)(5660300002)(44832011)(66946007)(41300700001)(91956017)(66476007)(8936002)(66446008)(64756008)(2906002)(8676002)(76116006)(66556008)(54906003)(6486002)(6512007)(186003)(71200400001)(26005)(6506007)(53546011)(4326008)(6916009)(316002)(38100700002)(83380400001)(2616005)(478600001)(36756003)(33656002)(86362001)(122000001)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlNlb2U3YzgrbGZJM1gxWWpDY0ZObFVIODhjUWloTUpVNlkzSWtlaEZlaktL?=
 =?utf-8?B?RkQzNytXTEVIN2RwMzQ0amRFYWphQUE4UG9pSlBTOEkyc3FoajNIRklSZ29U?=
 =?utf-8?B?T3V2dC9YVzdNKy8rQWpvVVJ4YVdici9QQW12NnV1a1ZxUGw5NXUzRllwaEUz?=
 =?utf-8?B?K25WSFp6dEYwVHRYUGdGa1pTZEpzQTYrTTNMeHE0MEhhVVplaUZqSC9mTVJZ?=
 =?utf-8?B?Y1BzVDhmUGViajF3cm0rSHRGeWtKcG1iUEIwanhPaThxTEpjaUhmL3UvQlhO?=
 =?utf-8?B?bG1OMk5uL0E1alVFMUdXaFVpTlVVNUlkMGxTanZKU3NyNStFV2hjbm9rZjFa?=
 =?utf-8?B?N3RKV3k3M21MUFZVWEVnZWNvVWFCUllCcE40NUtMbW0wd1RjZ2ZxdlhadVRM?=
 =?utf-8?B?QXNUTGdqQnU4QjRjenA1RG9yY3pmN0hYNXpzdlM1N3huZkYvOXpIQm85bnJ0?=
 =?utf-8?B?MVZvcXNIYkw1c2pMMkFCTEgrQWw5eEtjUllYUlFqUnRxYWw2TUFHRmRoajUr?=
 =?utf-8?B?WmNYL2g0bjdEcTU4WGdXNUN3OHVjM1RaN0dMTFVENFFxc2liZHZCTGNUM2Rl?=
 =?utf-8?B?TFVGZG9tOWJUNUErMTBBTjRqbzZkU0piK0pvb0hMcVJGT3MzOE5aOWY5QjF3?=
 =?utf-8?B?NHRyOFFhWkNnQUVLU0ZBbks1MXBxM1Y2TjYwMXFOdGNHMUo2RERHeDVnZGFT?=
 =?utf-8?B?QUJibU1UNFVVUHZTVFFBQjUzdmEzMFhvUGlMemlCVjFwU0ZHRERRaVI3NU50?=
 =?utf-8?B?R1Z0SkRBVnBNam9OdHBkVW0yZE1JMTQ3Z2l0YjBrQ3M3c3h1cHdKSDdZNk9C?=
 =?utf-8?B?M0hycVprdHFRTjUyMHNqbndFQ0pWWjFxQ2VrS2RxZlh2KzNYVEJkOWFWTWtT?=
 =?utf-8?B?MDlGZGxFWTB6bEVWL1BZZ3l4c0tacWlSN2NLNHRNQ3BydkFLRUVJY0htZFgv?=
 =?utf-8?B?bm1ueUNEaUhyVE9XVjFPZFZKeVVjZUVEYUxNeGh5VVpkVGtFemx2cFpsTXlD?=
 =?utf-8?B?M2MxZ3UrRGl1ZjNRNEVIRW1YMWI0TFIvYmYzMkdOZCtMRzY1WXFyVFdxN05t?=
 =?utf-8?B?c2Z4Qkp2bkdvYkhsUUZFOFdvcXpPWno1SE1tL1R1Ump1R3ljNUltV0NPcXJs?=
 =?utf-8?B?MWdCUW9GUEp0RzR6U1lhbzgxSzdWWkhjRWFVVUwxZ09vN3ZlRTdXaUhuZUNz?=
 =?utf-8?B?YmIwQkhIMTJmbXFrWDdUM0o2eUg1OVUweDVBaHh6N0Zhc0JxL2VUV284bWN6?=
 =?utf-8?B?TVRsVTdhK1ViMVZyRkFhaFZ5MnVDSmJoVFJSdE9OVVFjcGNFYUtZOGFEOEpu?=
 =?utf-8?B?eFpEM1lYbVhOMURwaVhEUytYend2MlljSTdzd3lQVSs0Nmc3ZVN2VXhUWVpj?=
 =?utf-8?B?N0pibnRpcjJadnlPY2h4L3Vnd1J2TFZUaGkvQ2VLc1FvSlZWWGVIZ3V4ZFVo?=
 =?utf-8?B?Nm1LUWlrV2R0MFluQ211b09GU3VDS05sYjd4UjBjUW1Pd05ncUFKVmNLT0tn?=
 =?utf-8?B?a1JuS1JCY2VFVnlOaGlaN2QzYW81OU5CSEtJYTdscTFlMUdET3hjV1pWZ3h3?=
 =?utf-8?B?QXp3cS9peVMvNVBSd3NOY3pkcVRISzJNTmlLT3VnaFB5RFc3UjR2MXJxckxQ?=
 =?utf-8?B?RGR6VnMvOUFiWXRsckhhdWovdFQrRzhOZ0h3dTkvZHJ2SXovTVM4R1g0UXkw?=
 =?utf-8?B?WFJVY2x1MFRNNUlhV1NmQWdoU2VMVkF3WW9kMjVTdEFTZDlFNThUV0JOeGNV?=
 =?utf-8?B?TGQyUEdaOU5FREhnelNvMTF1bWZISW82WDJCUmx2aThFbTFLanhyb0RSNytY?=
 =?utf-8?B?aGtTOXdHT1MvTndtcU1Ha1g2SzJCcEVBbm1QMnREM3ppWUFPZTVncmtOZHNR?=
 =?utf-8?B?UmRia0JYWmRTODF1WGwyY0lKN3RlaDRQUWRrRmxRTzBNQzBNTXFOQzdJZW1t?=
 =?utf-8?B?QjNrMkoyem9QbFhZeWEyc1h5QkxPQWRqbHNBM01EQ0xXY0wwYVB5VkVxSGJx?=
 =?utf-8?B?RHQ5eDBVSVNaUS9NQjdJTDAxbWhXUkh5UEFSd05sTHZZSHVmNXQ0aVUvNmdT?=
 =?utf-8?B?dkZFc2ZSaGhlS2pTeUlPck15R3M0QUxXV1BydU93TTcwSmJMQlBpYUlGOFQw?=
 =?utf-8?B?T3dLcWdmSDlLTnBqVmpOYk5RNTJQMnAzUEVnSk9hYVMyQnJnM1M5QURhSGcw?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0890C3335D7EDA4E8E8E4CB067B3857B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Z3g1WkRiRlBmSWNab3VpOSswazZ3Q3FvVnN2MTVRRVJvNmpidTB6N1pCdDdN?=
 =?utf-8?B?TUtwWVpPczJPa2tibC9sTlNPVTZDZE90YnJmR1g4SGUvZnRGV2hEMnpvVkV5?=
 =?utf-8?B?VWprZTYwT1o2MnhYbXRNRW1pMTd5eVUxSW5lQVR2VkVXVS9EdE9SUTBVTXZU?=
 =?utf-8?B?YXRLcmdKcXd4Ky83NXZMUXZDQ29VR2F2RkhZcDlXd0hlV2pCL2J5a0dON0xm?=
 =?utf-8?B?eVo5NFNaSW5WOHNkWjNiTWlNRG5IbUpoNlQ3MEpqMFU1NFg5VTJLK1FoY0hw?=
 =?utf-8?B?SnI3OW1SaFFJZ2FYSkwzbDdvZ2l1Q29DVEdOcmFCVU5EWjdJQ0VlZmh2MnFG?=
 =?utf-8?B?eFFENDhlKzdqbjNUZExnNU9JeC9aYVo2NlJKWWNLRHlNeGRlVHhNek9CejFs?=
 =?utf-8?B?aGpYdUs1R0xHQ1BwYjIxcmEyTEFYYk9tUlRoZjJCRFZNRlRtU1RkMGVjWGlk?=
 =?utf-8?B?TGlsRFdBWjBOVUZDeEdVNTJ1amxRZVVPWlhDanVhVG9vNXp2Q2s0OCtWNE9x?=
 =?utf-8?B?bm4xTEVydlpEQXI2S254TU9yRVBTMWpEQ0hud2hiNnJmZmpqQ0ZvSnZIUjVV?=
 =?utf-8?B?Tk9LelZoek5JNkZ1M0s4ak1aZ3cyYTRPc3JtcVAwLys0QjZlRkFPRTByT0ZG?=
 =?utf-8?B?bmV0alhtbU84NWkreFRWeFpBQ3VFMENhbzZ5TE54YXo0SXBIWU96eC9HdENS?=
 =?utf-8?B?dGxiN2tZck9ocWQvMUVaUXc2ZVBqZGx5T2JPR3FzZWZjSldLWmljbWp0QU5S?=
 =?utf-8?B?dWhRQS82NXU2SVBFRXNHZXNMS3lobmJsdTVCN21zSjl6Z2pOSWhxVTBUcTc4?=
 =?utf-8?B?RGdISExDY3VlMDkwbkM2VDRKNjJKdHlXQUxLWmdma2Uyd0UzcXBCcFZhUVhw?=
 =?utf-8?B?MEZOV3FxRGNrWldXbENWTlg5bjJWN28vS1pRWlYraWM0WGJmWTc3ZHpLeExE?=
 =?utf-8?B?Yzc4a2QxUlIvVzVoVUh3MUdCOTF1cVV6VkpFcDhDRVJrRWZVeUVVb3MyVlJD?=
 =?utf-8?B?TlN0Y1A3VzFRY3l1cDUwYmU0SjFleVhLQmY1emFLK3pGWlg5S2M1TjdQdXlX?=
 =?utf-8?B?cFJFSkpBVzZMTmdCdzlXeE9QSkVFQTh4ajJGaERTaGlXUDZValRYZlNKa29p?=
 =?utf-8?B?V3NJcGFmZWR6Unh6cklYMnB0UjF5eHJ5dzVhdGdzL3RRckJ3ZGdXWFVhZlQ3?=
 =?utf-8?B?dVZrL25NVUJYWm1VK0NvRmNPWkhXSEhFMlNYdlhzblpOeVptYUE2ZHBOS015?=
 =?utf-8?Q?GsJK8MLKnO74VXT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2f7465-0a0e-494c-23e3-08db831cb752
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 21:12:36.0513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p3ZOF+Fsdp2tJuLWR2ixU4e2EehCjFxmWTPpv+kzPmVEa9eXUUnFgPjIXdIQBI2JHQcZ97vlEyoe340dbArPx4jSpdo7PVdkqtO4AM0Tg1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_15,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120188
X-Proofpoint-GUID: Vu6tjCeg5wdOWAUXJNfbA5rAzFXD6Y50
X-Proofpoint-ORIG-GUID: Vu6tjCeg5wdOWAUXJNfbA5rAzFXD6Y50
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gSnVsIDEyLCAyMDIzLCBhdCAxMTo0MCBBTSwgTWltaSBab2hhciA8em9oYXJAbGlu
dXguaWJtLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIDIwMjMtMDctMDUgYXQgMTg6NTIgLTA0
MDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+PiBDb21taXQgMjczZGY4NjRjZjc0NiAoImltYTog
Q2hlY2sgYWdhaW5zdCBibGFja2xpc3RlZCBoYXNoZXMgZm9yIGZpbGVzIHdpdGgNCj4+IG1vZHNp
ZyIpIGludHJvZHVjZWQgYW4gYXBwcmFpc2VfZmxhZyBvcHRpb24gZm9yIHJlZmVyZW5jaW5nIHRo
ZSBibGFja2xpc3QNCj4+IGtleXJpbmcuICBBbnkgbWF0Y2hpbmcgYmluYXJ5IGZvdW5kIG9uIHRo
aXMga2V5cmluZyBmYWlscyBzaWduYXR1cmUNCj4+IHZhbGlkYXRpb24uIFRoaXMgZmxhZyBvbmx5
IHdvcmtzIHdpdGggbW9kdWxlIGFwcGVuZGVkIHNpZ25hdHVyZXMuDQo+PiANCj4+IEFuIGltcG9y
dGFudCBwYXJ0IG9mIGEgUEtJIGluZnJhc3RydWN0dXJlIGlzIHRvIGhhdmUgdGhlIGFiaWxpdHkg
dG8gZG8NCj4+IHJldm9jYXRpb24gYXQgYSBsYXRlciB0aW1lIHNob3VsZCBhIHZ1bG5lcmFiaWxp
dHkgYmUgZm91bmQuICBFeHBhbmQgdGhlDQo+PiByZXZvY2F0aW9uIGZsYWcgdXNhZ2UgdG8gYWxs
IGFwcHJhaXNhbCBmdW5jdGlvbnMuIFRoZSBmbGFnIGlzIG5vdw0KPj4gZW5hYmxlZCBieSBkZWZh
dWx0LiBTZXR0aW5nIHRoZSBmbGFnIHdpdGggYW4gSU1BIHBvbGljeSBoYXMgYmVlbg0KPj4gZGVw
cmVjYXRlZC4gV2l0aG91dCBhIHJldm9jYXRpb24gY2FwYWJpbGl0eSBsaWtlIHRoaXMgaW4gcGxh
Y2UsIG9ubHkNCj4+IGF1dGhlbnRpY2l0eSBjYW4gYmUgbWFpbnRhaW5lZC4gV2l0aCB0aGlzIGNo
YW5nZSwgaW50ZWdyaXR5IGNhbiBub3cgYmUNCj4+IGFjaGlldmVkIHdpdGggZGlnaXRhbCBzaWdu
YXR1cmUgYmFzZWQgSU1BIGFwcHJhaXNhbC4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogRXJpYyBT
bm93YmVyZyA8ZXJpYy5zbm93YmVyZ0BvcmFjbGUuY29tPg0KPiANCj4gVGhhbmtzLCBFcmljLiAg
T3RoZXIgdGhhbiBpbmNsdWRpbmcgImFwcHJhaXNlX2ZsYWc9Y2hlY2tfYmxhY2tsaXN0Ig0KPiB3
aGVuIGRpc3BsYXlpbmcgdGhlIG1lYXN1cmVtZW50IGxpc3QsIGl0IGxvb2tzIGdvb2QuDQoNClRo
YW5rcyBmb3IgeW91ciByZXZpZXcuICANCg0KSSB3YW50IHRvIG1ha2Ugc3VyZSBJIHVuZGVyc3Rh
bmQgdGhlIHJlcXVlc3QgaGVyZS4gIERvIHlvdSBtZWFuIHlvdSANCmRvbuKAmXQgd2FudCB0byBz
ZWUgIOKAnGFwcHJhaXNlX2ZsYWc9Y2hlY2tfYmxhY2tsaXN04oCdICB3aGVuIHlvdSBjYXQgDQov
c3lzL2tlcm5lbC9zZWN1cml0eS9pbWEvcG9saWN5PyAgT3IgYXJlIHlvdSByZWZlcmVuY2luZyBh
IGNoYW5nZSBpbiB0aGUgDQovc3lzL2tlcm5lbC9zZWN1cml0eS9pbWEvYXNjaWlfcnVudGltZV9t
ZWFzdXJlbWVudHMgbGlzdD8gVGhhbmtzLg0KDQo=
