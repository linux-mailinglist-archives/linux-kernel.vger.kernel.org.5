Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAF97526E6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjGMP10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjGMP05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:26:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22F42706;
        Thu, 13 Jul 2023 08:26:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DEJ6GY004822;
        Thu, 13 Jul 2023 15:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=49Nwm4jGJzo9r/9Xb3ipOWzas4CvSHJZD/FgGsCeORY=;
 b=v70uEcd8IjxTYNn54uqJMBwV381OT97Wak2qdGuwMLRDievZG9I4EMwmsnHii0B6F8lw
 lYnUG3o5taxjL++X2VP29dQ1bHh7qTxFWYEU021qkzOJz3tsDM1am0IxL6FgieN63xyQ
 9hFdaZeT2Eh7dxXuo9wnCCssC07YNbiEixq0A/BuYNSsVDhFrNJ7lUvqJ+KpXwYouZWm
 VtFin7va5SF5wMZudGKbBF+W1Jx8Op0llno8Kf/4LcLTEpfxciNqMwotYm5usni7sPUZ
 AOsFtztM8iijIG/ok7D5eZJwRN99agoa784OB2Vq/R8pPid5NNJb0gWww5jIybt/I/Q1 Qw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrea2yss8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jul 2023 15:26:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36DELfvu000530;
        Thu, 13 Jul 2023 15:26:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rqd2ct5xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jul 2023 15:26:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HI93CQHwJpx6ZEXUxWJhPwYgvlv318VbQH40FkQ+wJHUTCgcNFQrSS2o05SxzM0RJ8lUXbnOfjDYMs3k4YTiz6dLcSN3qvfL8HdBkkx1lrnoAQ4jbVtV5C/ttvNYjRiD0f24bI1CDQY3atPIG+iGIy+t4vAyuP/IeT54SydsfY7sFHCcVysz53+4WJ7N8sBceNAkzCzAnFNS5lYs9OGbtJ4R4VPK7eQDcm0OrWEk6R6IcYrAKw/LiypQtyrfbSAbD1MYzsXXWnDqTXvA8doODjsHHSDds49964I3U1uX9WmoQCR0KTBqpZjqyXcKjLe0FCY3OdwEnKLqQRhsN9HTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49Nwm4jGJzo9r/9Xb3ipOWzas4CvSHJZD/FgGsCeORY=;
 b=Wsy4xEcG2xFUWFxPIe99RVbCTSsBbobgE30if7iNepEObAEN13iZErRr90xZsut5G+5RA3XiwPNJUD6exmArgzQ2dF4/GIZI8oF0uWtmdvnXc4P1PZDfYwCmT/bQzOSgEoSkcsi8D1vqXYuYqpiwp0Xnbo5KRQCdCufFCoOpZhjk8rbQB+UNBeAer8asoU0yHFrAR7PPTIBB0s5KoLBGcwf3PXZhjYuP7JLGbH4pkXiNnIKJlW8lhR4SGCn+kVQlNfieTtvMeTZR7A2XpbpDfVsXHyBWUFAZ3ayOYVfybNiv5S0waf9B66lApEvhoc4c5UkSzp69+rCvTmdf0+r/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49Nwm4jGJzo9r/9Xb3ipOWzas4CvSHJZD/FgGsCeORY=;
 b=XmA0LFfDh8T9LtgepG7QbU71FQ9HGGEwqNwIsNXHJGgy568KkuJerB9ptue2oBUbl8TKrLo8K60OD7BYadO1G+54VbyrIH5aNFufIc83itkgj1Oc3y0OuZ4e5IDcPdzXvGDHqtciEPYzG2LtOjuYb14t4kF00eACgyW7wJ3ONc0=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CY5PR10MB5988.namprd10.prod.outlook.com (2603:10b6:930:28::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 15:26:14 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5a68:4817:cdec:ca0d]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5a68:4817:cdec:ca0d%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 15:26:13 +0000
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
Thread-Index: AQHZr5QIRPDFbi04j06G9JzJQhYIyq+2cMKAgAA7PoCAAAX2gIABK36A
Date:   Thu, 13 Jul 2023 15:25:53 +0000
Message-ID: <2E9CBB78-173E-4EA5-B43C-AE5CDA7581F8@oracle.com>
References: <20230705225229.1435691-1-eric.snowberg@oracle.com>
 <6173db54e3d75481a6b1f1079c5b06e1c1caf564.camel@linux.ibm.com>
 <A9725ECB-0811-42BD-8586-7DF7A8BD7393@oracle.com>
 <6ce8d8b5b6d4b59b113ee3d5224e9d3b4e1231d2.camel@linux.ibm.com>
In-Reply-To: <6ce8d8b5b6d4b59b113ee3d5224e9d3b4e1231d2.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|CY5PR10MB5988:EE_
x-ms-office365-filtering-correlation-id: c57bf59e-315d-4378-b6be-08db83b572a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JzNYwxvfWnxmHtySb44SsQZ/d/ZnQ8oVizIxxTo2ONUifX0bCpvf5OpdLrQ8KNdkPf4gyn7uQyUD0vj4vL7Vk7KFPsfQTBRQB+3T5Mc16rSSYcTPxJFofI08hp8S9UacKxy5lOC8zdEYNcYX5VwNRYbkqMu7poNsumccGd+/h6ms4AQZZlCZXnYoVfvH99kkFnHgx0x3JPaRWgeGw8dX0UJNTotXSMoFF8QrQjCA5uYnFedjALXoJ4Io31RLI/XhtKe8iawUW+gFkLv+5gQt1eG0QTpPOl2++J+2/QFsqmQi1pHOaLz+0UcoV80v4IwNw26r40R92V8bhaJTt0PNwpULH+j5K9SXRCc9ZWeMtUUYJyE6nPITMMJ9DyllQQXTpEECyLJ4fNbvySfHqmM7SdvoQfSdsg/HquHlyt/FZi7fRtibGBKh1b3aoHmYEiqWCV/QLz8YmA3/5ZCI+xmSGAKWwGOOZ5JbB3PIVR1PkmixDbLMnkAdEKnMxXkQuOTMGC1dDtiHrdqFYSSHSiZPxPuVTcjFmkLphFNEMA38ceGlQFvU63a7Laqx4C29CS+X6Armn+n89mTH7AIZiho9bSRLcqYeEabDpLGdmGpmNeQfPo01tEGz/YdpQOzs5C5x9EJ/eWs1UoQh4Dif0dKlNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(76116006)(66946007)(91956017)(478600001)(2616005)(83380400001)(316002)(64756008)(66556008)(66476007)(66446008)(6916009)(4326008)(54906003)(53546011)(41300700001)(5660300002)(6506007)(8936002)(8676002)(44832011)(6666004)(6486002)(6512007)(186003)(26005)(2906002)(122000001)(38070700005)(38100700002)(36756003)(86362001)(33656002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWZ6UjdPU1Vva2RiTk5JQi9OMjVLVlVNL1RFbldSL3lmeUtpUk80YVY0Vmhq?=
 =?utf-8?B?bXRtdmY2VVROejZXYm55T3dyeGFzOG50WEI4Y3hOcU9HN3M0d2JJWVNEUTE2?=
 =?utf-8?B?VlVGakFqTTZqWjJvMmZ2eTdoOE1uSDRTMy91ZHFLSXgvbWxrV2c2bldPWCsx?=
 =?utf-8?B?OGpwQW5pNjl4bWhnSGl5dHVHc2NlNm9RM2ozT2wrWU5KSUhOS2xBL0l0eVhu?=
 =?utf-8?B?MVlVR3FwSlVXaTBKNlYxVUEzdFpzcFhDa3lrYmpodVFBT3ZhS3gvRU9COTdh?=
 =?utf-8?B?VlVvQS80QUU2ZEFJYnQ1MmdzMXFqRnJpbHg1TkJrUTRWeUlUSzkvOC9CVkJx?=
 =?utf-8?B?bEg1a3IzUXpOOU4vZWhqcXJUTkVRRnFrT1IxS3VOeFlhalBtSVRvclUzN056?=
 =?utf-8?B?OFF5UHdSWXdMSFBpSDlYc2NERnlNUUxUTmpQVVdkdVZjRDJvQW84SmpJNWdI?=
 =?utf-8?B?dFBEc05rQWdjRklMSlZEazhPTjFSNHZSQkovT1E1Qko2TjNlZWc2NHVDbXF2?=
 =?utf-8?B?MnRVVzRaWjhCOTBPTnUwQlpTangvU2ttU3MzaU1ONVNyUURQT2NEVEJpdWk4?=
 =?utf-8?B?R0JvYXpqUDc3RENxTmxJeUMvTmJMZ2l6dHVIUzhiK3gwMVdyOGd4K0RJalVm?=
 =?utf-8?B?ck03RVdja2xhNnFnWUo3S0lRV2NRQmJrQitxZnFCNGZXWkJFb2EzcXJLdVZN?=
 =?utf-8?B?Y1hxUnA0MGFWUEptM1JvZ2w5aFBFY0x2MTIreVFiSU9aRmJuNVhLNW9VZ3FH?=
 =?utf-8?B?RnhZcFR4UTd5c2l1NjRpbHJuckxoTmxYUEdSeDdWb2dzaUcvUUN4Wk9zU0hS?=
 =?utf-8?B?aDM3cklhWXEyclphaHRqczVMVUNOOGVmcGxJR3VwQmMvMHZXam8vWmJ1eW1i?=
 =?utf-8?B?elhidCtzdjRpV0hhOXF1bFgweWh1RnpKdTdza1M3c0M2NUxFbUlteXdyWUcx?=
 =?utf-8?B?M2JwcldhUUVLYm9aZFpqaHpZWEc4eGZHclZyZnc0dEQvV0hmcmhqRGQ0V3k4?=
 =?utf-8?B?Z0pyZnZJNXgxejFkcGFOWFpJUUkyaHdOa1Q0bSszZ3lqMWFsREZNMGhlWml2?=
 =?utf-8?B?YmhDNGxwQ2xHZ0hQYkxvWWZydWxjdVZiZ2V2NllKZURwbHdJK1VqRGxCOUkv?=
 =?utf-8?B?MkcvTG16M3FsNkxIV1J6NU1BallvVnRYQ0NGdm1FUXlVTG1BdXc0MWVMd2xs?=
 =?utf-8?B?YjE4Q25rZVBXVnI5bmVsUnkyWUdzWGRpQ0YrUWJrdXNEYWJxNDJ3SUdwZmlD?=
 =?utf-8?B?d1JIMERHdEUzZG9wUTh2ZEh5bnRhQkJMbHR6VUVkNXQvQ3hDN28rN3A0WmM1?=
 =?utf-8?B?RXRKdmlrZEhoQ2s1a2grODRnNDBoTzVHRCtwblErUEtwOWFMd2J6M3N2UnJH?=
 =?utf-8?B?RmdkY2hLU1RGRWRpR3IxY2l6NlVvaGEydDVmSmI0VkFoRm01bTJrWVkxT0R3?=
 =?utf-8?B?c0tDc1V0ZDVoTyt5M2F0N0k4UUZVZzNvbDFEclJ6RFhTNXhZWEtwOTY3a3Uv?=
 =?utf-8?B?Nm5Ib2ZZS3EzNTNob1lvSFNtU08vT0orTXUyS1FJaUZQVmxjZ2lkeUU1Vmxh?=
 =?utf-8?B?VndMWmhiUkdUb1ROY0RJNXppVm41WFVKdGZUZExmSklhZzdlcjRPRVB4eHZD?=
 =?utf-8?B?d1V2Q1lESVl5U00xVTVsOFZRY1AzNmNCWTZTNGk5OC9iZE9RYmtkY1NETEMz?=
 =?utf-8?B?VG9oTm40STNtV2tlUVkrbFZXTExJNmh5QWxHYmYyQTk3UzluOUdPRHUzOCt6?=
 =?utf-8?B?ODFNRy91N1hXU28rQ083V1FySTFGWDlERUZXVHJYVEpUR25qNmtQYzREK3FC?=
 =?utf-8?B?TkZMeDRzTWRldjczRHpZbGpKcFI1ZU9pT0xHaXVtTkIwOWh1ZTF5MFpQck9u?=
 =?utf-8?B?L0VBZjVvQjVBaUZsWlF5dmZxVHBFS21xOFJaMDFqd0FCUklUV3M4NldrTlZQ?=
 =?utf-8?B?Qk5XbCtwUmlJWEJMTUFIVGdlQXZ3R1cyeFNBNk1rYzgzQ1NJZHlwWTQ0bEdv?=
 =?utf-8?B?Z3hMSkg2ZTA4UjhTS2xPeS9iaUhweTRhUEx1aEJHYWRPSFFCZnNVbXQwVzZC?=
 =?utf-8?B?OWRySlN3K2tkRlg0WjZuNnE4MTc1MW90ZW1HakdWK3JHeXF5VWZkRldNSUhr?=
 =?utf-8?B?MGtyZFVBbC84eGZMTkZDVFBaZ3IwQ1hJak5XM0poQXV5Wm5OS1FIK3E3ZE9C?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10CD4A76FF44C54EBF3294875E150DE0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eER6WGdRSkdSRFNnQXFORytDZEJHc2V4Wjd6WlZjQzdlaWJaRWFhRDJ6YkJz?=
 =?utf-8?B?ZHdOTU00Q1EzVWxLWFFyMzNHR09tTlJjaXJYbk9pYlRlRGFheHk5ZU5qWmlI?=
 =?utf-8?B?WmVYenMvbWk2NG9OTkRFbTk1OC9jZjFvaFpJanJkbWxFSkNFaW1OWXNjTXRU?=
 =?utf-8?B?UjIwMUhGbmoyVlMrWmJnL1VTM3JiRXY4UG5ZUzlONkhPK2EvMVgzeklGaW9Y?=
 =?utf-8?B?bEltcHJ2MU9kajFudGxWV1JqdFdTcHpYaDdnWnhPK0pHZE9CUHJmMVZMVlJv?=
 =?utf-8?B?Qk5xQ1REcU8wQVVDT2ltcmhUWklGZ0E1N255R05sZEx4ZENRVVVHSjFNYlcv?=
 =?utf-8?B?NzhGbEZnQ3pJRjNjYnVrOTNVZG9pSWxzSFJCSTJISnNoMXJHVERVSUhNczR4?=
 =?utf-8?B?ZzA4VTlvRnY4YTA4M3gvWkxqMEc0TGNuR1hHR2xUWWRHa1YyNXU0SXI1dTJo?=
 =?utf-8?B?dSsxTUJWUGpRSlRhcHF4aytYZFB3UkZxMFpWdlpjWXJLeGRST0psRU1MVk4r?=
 =?utf-8?B?NG5ITDh4ZWdFR1Bjcmk4b2tOOGt2cW51Z2RUTEJQTmkyLzlSTkowSlVSQ1BD?=
 =?utf-8?B?SkdjY1lOWHhYTGFUaFpZZDBmWXdWcDI1UGJQRXZOM2xFaWFQY3BJRXlBbGlq?=
 =?utf-8?B?Tng2emI5VU82ejZ3a045ejZyWGVkZHJ1L01rd1orelhmTlBaeGgvbWkwUWMr?=
 =?utf-8?B?a3hPZ1VVaEc0TmlNQzY2VFZHbE5YTUd0R3I2S1g4NTB0UkNTSDJXUkcrZytU?=
 =?utf-8?B?ZjFrNWdxMmxQSjVSeEdyeXIwRWxWNlhmYlpFS3czZWowcEpHOUgyMDB6NWpZ?=
 =?utf-8?B?ZElQR01PVGpCaVgydXFLR3JMRWR4Qmtjd2g3QWJwa3M5YWpmUjh5RmlaaEdP?=
 =?utf-8?B?YWs2blg5NFFiZzVESmJkSXVlc0lhMFMweklSaXVaZnpWRUE5bVlhWnBDUitD?=
 =?utf-8?B?YUN6OWYwQmo0UVB2U2NlWXNpMllqYWpWaS9ySzVSdk1pU1BKZDkzcitDU1gv?=
 =?utf-8?B?WnZ1enlqR25xSmJvNUZNUXhvOEhTUTh5SVpiaENOQlQra2xJRmJaWVdJYkY2?=
 =?utf-8?B?NEp1cDVmemJHUWc3OWpIWVRFbHdHMjIycFFmTDBCZHVqZWE1bUdUNlA0eEIr?=
 =?utf-8?B?bkRJMnhmY2Vta3E0UmczSWdNK21DeU5SSWIxYlZUcGN0OHloTXI1NzdQbzNp?=
 =?utf-8?B?bU9QTGMzTW5NWVdIQVdsbFA3OGc5L0VlRnhGcGg5ZGYxWGI0NWlINlJVMmU4?=
 =?utf-8?Q?ttKn6cOgs46+DKh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57bf59e-315d-4378-b6be-08db83b572a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 15:25:53.8943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jqCSpzNW8Q/A8q8TY8iIdhtCj2TN5u3EBPs3NtF/awf4lj3FgyrqsAKRb2TucB3HsoaKLyAR3AT3dSVroE2rqVn2aPeBlNkkwS65nrYxFLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5988
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_05,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130135
X-Proofpoint-GUID: jhuUh-XS8eW825O2A1pzT-JbQn2aCIRi
X-Proofpoint-ORIG-GUID: jhuUh-XS8eW825O2A1pzT-JbQn2aCIRi
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gSnVsIDEyLCAyMDIzLCBhdCAzOjMzIFBNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51
eC5pYm0uY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgMjAyMy0wNy0xMiBhdCAyMToxMiArMDAw
MCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IA0KPj4+IE9uIEp1bCAxMiwgMjAyMywgYXQgMTE6
NDAgQU0sIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+
IE9uIFdlZCwgMjAyMy0wNy0wNSBhdCAxODo1MiAtMDQwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToN
Cj4+Pj4gQ29tbWl0IDI3M2RmODY0Y2Y3NDYgKCJpbWE6IENoZWNrIGFnYWluc3QgYmxhY2tsaXN0
ZWQgaGFzaGVzIGZvciBmaWxlcyB3aXRoDQo+Pj4+IG1vZHNpZyIpIGludHJvZHVjZWQgYW4gYXBw
cmFpc2VfZmxhZyBvcHRpb24gZm9yIHJlZmVyZW5jaW5nIHRoZSBibGFja2xpc3QNCj4+Pj4ga2V5
cmluZy4gIEFueSBtYXRjaGluZyBiaW5hcnkgZm91bmQgb24gdGhpcyBrZXlyaW5nIGZhaWxzIHNp
Z25hdHVyZQ0KPj4+PiB2YWxpZGF0aW9uLiBUaGlzIGZsYWcgb25seSB3b3JrcyB3aXRoIG1vZHVs
ZSBhcHBlbmRlZCBzaWduYXR1cmVzLg0KPj4+PiANCj4+Pj4gQW4gaW1wb3J0YW50IHBhcnQgb2Yg
YSBQS0kgaW5mcmFzdHJ1Y3R1cmUgaXMgdG8gaGF2ZSB0aGUgYWJpbGl0eSB0byBkbw0KPj4+PiBy
ZXZvY2F0aW9uIGF0IGEgbGF0ZXIgdGltZSBzaG91bGQgYSB2dWxuZXJhYmlsaXR5IGJlIGZvdW5k
LiAgRXhwYW5kIHRoZQ0KPj4+PiByZXZvY2F0aW9uIGZsYWcgdXNhZ2UgdG8gYWxsIGFwcHJhaXNh
bCBmdW5jdGlvbnMuIFRoZSBmbGFnIGlzIG5vdw0KPj4+PiBlbmFibGVkIGJ5IGRlZmF1bHQuIFNl
dHRpbmcgdGhlIGZsYWcgd2l0aCBhbiBJTUEgcG9saWN5IGhhcyBiZWVuDQo+Pj4+IGRlcHJlY2F0
ZWQuIFdpdGhvdXQgYSByZXZvY2F0aW9uIGNhcGFiaWxpdHkgbGlrZSB0aGlzIGluIHBsYWNlLCBv
bmx5DQo+Pj4+IGF1dGhlbnRpY2l0eSBjYW4gYmUgbWFpbnRhaW5lZC4gV2l0aCB0aGlzIGNoYW5n
ZSwgaW50ZWdyaXR5IGNhbiBub3cgYmUNCj4+Pj4gYWNoaWV2ZWQgd2l0aCBkaWdpdGFsIHNpZ25h
dHVyZSBiYXNlZCBJTUEgYXBwcmFpc2FsLg0KPj4+PiANCj4+Pj4gU2lnbmVkLW9mZi1ieTogRXJp
YyBTbm93YmVyZyA8ZXJpYy5zbm93YmVyZ0BvcmFjbGUuY29tPg0KPj4+IA0KPj4+IFRoYW5rcywg
RXJpYy4gIE90aGVyIHRoYW4gaW5jbHVkaW5nICJhcHByYWlzZV9mbGFnPWNoZWNrX2JsYWNrbGlz
dCINCj4+PiB3aGVuIGRpc3BsYXlpbmcgdGhlIG1lYXN1cmVtZW50IGxpc3QsIGl0IGxvb2tzIGdv
b2QuDQo+PiANCj4+IFRoYW5rcyBmb3IgeW91ciByZXZpZXcuICANCj4+IA0KPj4gSSB3YW50IHRv
IG1ha2Ugc3VyZSBJIHVuZGVyc3RhbmQgdGhlIHJlcXVlc3QgaGVyZS4gIERvIHlvdSBtZWFuIHlv
dSANCj4+IGRvbuKAmXQgd2FudCB0byBzZWUgIOKAnGFwcHJhaXNlX2ZsYWc9Y2hlY2tfYmxhY2ts
aXN04oCdICB3aGVuIHlvdSBjYXQgDQo+PiAvc3lzL2tlcm5lbC9zZWN1cml0eS9pbWEvcG9saWN5
PyAgT3IgYXJlIHlvdSByZWZlcmVuY2luZyBhIGNoYW5nZSBpbiB0aGUgDQo+PiAvc3lzL2tlcm5l
bC9zZWN1cml0eS9pbWEvYXNjaWlfcnVudGltZV9tZWFzdXJlbWVudHMgbGlzdD8gVGhhbmtzLg0K
PiANCj4gVGhlIElNQSBwb2xpY3kgcnVsZXMgYXMgZGlzcGxheWVkIHZpYSA8c2VjdXJpdHlmcz4v
aW1hL3BvbGljeSBzaG91bGQNCj4gbm90IGNvbnRhaW4gIOKAnGFwcHJhaXNlX2ZsYWc9Y2hlY2tf
YmxhY2tsaXN0Ii4NCg0KT2ssIEkgd2lsbCBmaXggdGhpcyBpbiB2MywgdGhhbmtzLg0KDQo=
