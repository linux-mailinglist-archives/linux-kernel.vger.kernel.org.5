Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57FB7D0F61
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377359AbjJTMIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377363AbjJTMIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:08:42 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB269F;
        Fri, 20 Oct 2023 05:08:39 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39KApQWC020042;
        Fri, 20 Oct 2023 08:08:23 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3tubwhkxye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 08:08:23 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3h2yTJVte1y/K+TOS9n/X7MMoZprVe3s1kTlCssp7Tucp7wOAEXoZ5yrD0v54hwbWeLNO7nZGxDpvyiJbj+JjhYt4bgzNJ2Zkmo71+MfeyZIxDkTuv9eJTfEOwDaTFmr8nO45+9vbe5DhO7yysWl0TSvIGwpvt6iWsyh90o/sDKhxb3rdE6qWeBiG5rdmJWId7gXMUMI1wOrzwcDRdbsQxBTQ5hyIP+zZwbT2vp2pzwxcuLUUvnEtyxFCP/b3BqPk3PPYDf3xPGIMY3C1Lfu/g/grIAfM/ue+AfhGQLyaxCp4DXnTtTXhYs3gI1zeTKyGmlTpTsNb1KKl2n8rhU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oCbVU58X8jxMNAky8//QQdc6pzrUfNwSO5uP9ZZapU=;
 b=dLqGOh3Jg6WhkM4fBvne/VkROQyIR9KLw+0b3XA6AFA3RbxnJ4FtgKZhrbzoqEmPGHOP4RbnVrKVAT4mGJchr0wW+tIRgyY2jtKMQZFAmAHGmG+MWrsLJwO/4VXr3fzPtvTf2OM/nK2jExBdGtPIMZSKWR2NzSFYeuG6Pagp6edDmRgD/lQebDujEO3+eFZ0wJZXhDa9DbpJv24UaBPiU73pLcArn2toiN3DLwQMDl2sR42abkDWgfl3iKGLrbmtsv7cqPvDwIkGlwuhoKqSlowy8MTkR9Aeat7/Vox3F9i2uhmyFdK+oQJ7OjVMjPXxKQ573zS+r+kTneIrC3nmJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oCbVU58X8jxMNAky8//QQdc6pzrUfNwSO5uP9ZZapU=;
 b=5kw1Nde0KNWejccLNPK0wnsu3OxnvwThVzGLRya7KI90/2pH5BX2LJHhc9kpKC1wUVTOycCGG1hBktyTDU3xpA+9bmM8jcdoMctEMd3hV6LDcQ1A+csKXoMCV8hbCTnMG/ClY/1Oj/oMYfyOSTQTEhLbt0qrxXolSZg5CDrmIJU=
Received: from BN7PR03MB4545.namprd03.prod.outlook.com (2603:10b6:408:e::31)
 by MW4PR03MB6867.namprd03.prod.outlook.com (2603:10b6:303:1b7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Fri, 20 Oct
 2023 12:08:21 +0000
Received: from BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::e2c3:4dcc:c87e:bbca]) by BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::e2c3:4dcc:c87e:bbca%5]) with mapi id 15.20.6886.034; Fri, 20 Oct 2023
 12:08:20 +0000
From:   "Balas, Eliza" <Eliza.Balas@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v3 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
Thread-Topic: [PATCH v3 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
Thread-Index: AQHaAow+3kwQRklh0USw0Mt3uyHh0rBRZjoAgAEeXwCAAAa7gIAAA27Q
Date:   Fri, 20 Oct 2023 12:08:20 +0000
Message-ID: <BN7PR03MB4545DF52967F994265E3D31197DBA@BN7PR03MB4545.namprd03.prod.outlook.com>
References: <20231019125646.14236-1-eliza.balas@analog.com>
 <20231019125646.14236-3-eliza.balas@analog.com>
 <2023101917-cork-numeric-dab8@gregkh>
 <BN7PR03MB4545E7EAB2D72B9098C30C6797DBA@BN7PR03MB4545.namprd03.prod.outlook.com>
 <bae6d751-1dbc-449d-b91f-aec0890caa7b@linaro.org>
In-Reply-To: <bae6d751-1dbc-449d-b91f-aec0890caa7b@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWldKaGJHRnpYR0Z3Y0dSaGRHRmNjbTloYldsdVoxd3dPV1E0TkRsaU5p?=
 =?utf-8?B?MHpNbVF6TFRSaE5EQXRPRFZsWlMwMllqZzBZbUV5T1dVek5XSmNiWE5uYzF4?=
 =?utf-8?B?dGMyY3ROV0V4TjJabFlqY3RObVkwTVMweE1XVmxMVGhrWWpndE56UXdOR1l4?=
 =?utf-8?B?TlRjd05XWTNYR0Z0WlMxMFpYTjBYRFZoTVRkbVpXSTRMVFptTkRFdE1URmxa?=
 =?utf-8?B?UzA0WkdJNExUYzBNRFJtTVRVM01EVm1OMkp2WkhrdWRIaDBJaUJ6ZWowaU1U?=
 =?utf-8?B?QXdPVGdpSUhROUlqRXpNelF5TWpjM01qazRNakF6TmpBeU1DSWdhRDBpUnpO?=
 =?utf-8?B?Q0syY3lSRXhRYVVVM1MyVlhlVUZLUm1aaFZEUjFjbUZSUFNJZ2FXUTlJaUln?=
 =?utf-8?B?WW13OUlqQWlJR0p2UFNJeElpQmphVDBpWTBGQlFVRkZVa2hWTVZKVFVsVkdU?=
 =?utf-8?B?a05uVlVGQlJXOURRVUZCTUhSdmIyTlVaMUJoUVZOMFdERkVZMlpJTTFSWVN6?=
 =?utf-8?B?Rm1WVTU0T0daa1RtTkVRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVaEJRVUZCUkdGQlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVWQlFWRkJRa0ZCUVVGc1IxUkhWbWRCUVVGQlFVRkJRVUZCUVVGQlFVRktO?=
 =?utf-8?B?RUZCUVVKb1FVZFJRV0ZSUW1aQlNFMUJXbEZDYWtGSVZVRmpaMEpzUVVZNFFX?=
 =?utf-8?B?TkJRbmxCUnpoQllXZENiRUZIVFVGa1FVSjZRVVk0UVZwblFtaEJSM2RCWTNk?=
 =?utf-8?B?Q2JFRkdPRUZhWjBKMlFVaE5RV0ZSUWpCQlIydEJaR2RDYkVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUlVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?blFVRkJRVUZCYm1kQlFVRkhSVUZhUVVKd1FVWTRRV04zUW14QlIwMUJaRkZD?=
 =?utf-8?B?ZVVGSFZVRllkMEozUVVoSlFXSjNRbkZCUjFWQldYZENNRUZJVFVGWWQwSXdR?=
 =?utf-8?B?VWRyUVZwUlFubEJSRVZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFWRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkRRVUZCUVVGQlEyVkJRVUZCV1ZGQ2EwRkhhMEZZZDBKNlFV?=
 =?utf-8?B?ZFZRVmwzUWpGQlNFbEJXbEZDWmtGSVFVRmpaMEoyUVVkdlFWcFJRbXBCU0ZG?=
 =?utf-8?B?QlkzZENaa0ZJVVVGaFVVSnNRVWhKUVUxblFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUpCUVVGQlFVRkJRVUZCU1VGQlFVRkJRVUU5UFNJdlBqd3ZiV1Yw?=
 =?utf-8?Q?YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR03MB4545:EE_|MW4PR03MB6867:EE_
x-ms-office365-filtering-correlation-id: 425fd226-268d-4bad-0f95-08dbd1654081
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: isAm01h0fuUY+oZhGQmrGUxyqdPB8nsvmaOU++xlbM7cpNLKSLcvmZt9Ut0gS5EiAz//mL02Q+DHn4/tjrv3QRoJnc0kNFSWxmrqEsFXCnFocuRvAxD4kw4cYFQiTx5fr78xgZt3OCDtgMRR0tsBMi/q+XVaVnWw8y22ZXQb8y1OFVocvA090qx5X54d/7r7C6xOJ+9BQqRmLOryVttJVB/pBr9orclAlgGxagRF/SzO0yNrNbRq3dlMGpOFF1Ia+OJHbQLzB++TSEd9FTfJuIHyfrQFJv/RI19mC929rEluKAkUHoa3BIdOrFYHElAKkZJ8xnSmFG7VZiwqPVFn1jNy2KchjQUqfB2J6tvi7IfXLsE70+fKXXssOJwTbxFR5mormzDl3a0urd3J2UYL3eCBIuTQh3lGAzmvj78n7bwFc8QmnymFloxcBBW2VhLHi9jrmc7xEub7lBPTiFfh/KlTnjIjaPXGG9mzwKBzRuonTDBFRY6Hfw32Ku1mfM2XrBFprdgaLXezpOKt0HY7nq8PrvCpe/e1TV3RHKirtnCP068bkG4JiHwHfW+d4380QeIePCNO+xXZ0fFF7zp8/rK+iJyaVQ06J2OHMdbPACXNib366OwBGy0c71eKuRR6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4545.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(76116006)(66946007)(55016003)(54906003)(7416002)(316002)(66476007)(110136005)(66556008)(2906002)(86362001)(66446008)(5660300002)(8936002)(8676002)(4326008)(52536014)(64756008)(41300700001)(33656002)(38100700002)(38070700009)(478600001)(122000001)(6506007)(7696005)(53546011)(71200400001)(9686003)(83380400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2NYOFpjUGtkOVRCMVdaZEZ6OG5KMkZhU21uUEpkL01sK05qR2hXWmJhRUw0?=
 =?utf-8?B?NE16bzlpNml5MVVtZWNEVjlPYWpiWit2b1FLeVNZZi9lbjVVZUg5RTRFR1I4?=
 =?utf-8?B?dGR6dUpKeXFaeG5WeFF0SHY5UGwwWCs3S0pvZEN3WllJRnNpbWN6VzhJeUZB?=
 =?utf-8?B?VnRyRThyWWRBYk01N0lVZ21nbHBtWTN4MHFTMnpTMjkwaFplM0hMUVAzazRG?=
 =?utf-8?B?MGZ4U2hOYW5EaHkxUFFGcDNad1dpQTJtRXJpS3N1QlFKcFdLaWYyYjJsOVYr?=
 =?utf-8?B?TTNpVWhwRlZzNmsyRE42MDk1bnMxVDI2T2VBanB4K3l1R1A2akM4TkpkcEVH?=
 =?utf-8?B?VW1LZVpEckZMeHhOdzZ0UVJCWE5reDJpNHZnR2czdHJQaHUyc0FJazdsVWRM?=
 =?utf-8?B?ejJRdW9ZQXVpRVlpVEQ3WENZNjFzKzE2bkxnUGp6Vkl2VVgrTkp1MDZ6V2tL?=
 =?utf-8?B?N0ZSQVJCcW9HNTFHbFlBdVJWVnFFUUNveENBRkdCOCt5Wm5xdXpIZXlqcmZB?=
 =?utf-8?B?NDdiK0JLRFRJTFBLaXdVZk1nVy92SWJIaUM0ZHhPWmJZR1dxRzNnUGN4Nm1j?=
 =?utf-8?B?OE9telppenpzTHljUGZ6RDd1d0QxczFRZjBnWklNNzlKbXJHc2k3Y2czTjl6?=
 =?utf-8?B?bUgvN3ZCa3pUVnVTb3RTbDhnL1NBeUJaZHdZSGo4Q3BtTFlmTkZzK0FvUUE3?=
 =?utf-8?B?aGhVZnhWZ1NvVWlYMURmc0Z4MElSYnQrbU9hcnhJSkFRY1p6OWNmQ0lDTTcv?=
 =?utf-8?B?UUhrRUFCZEJ0T2hycmptYjlXdE5JcFVkZVFVTkgzemF3RG4ya2JDZUVDclox?=
 =?utf-8?B?OGo3Smp2OFY1WW1tdzg1a2poL0FBZTBKRStFYVBSOGRTZXluV054bWFPaVZ2?=
 =?utf-8?B?SjZ6b2RHM1R5WTJ4YXhiaUZnRHpnZ2dsdDFRT3liQ3R3VWZ0N0ZQR0tsdVJR?=
 =?utf-8?B?d1g1blR1WGZxN2grbUFVcDIyT29hUVl4SEVWaW1kYkZ4T1lBRnI5OE1oZXV6?=
 =?utf-8?B?Mldya3FuazI1ZGdKemVzT2lNSDNZZG5rbUZ5M3VjTUNXV05UeVRzT1U4cGpZ?=
 =?utf-8?B?aElNY3hiVW9zYWlrYnprYS9QdWF0STB1dno0cGV3ZUM4OUhXaUJqaVEvUW45?=
 =?utf-8?B?V1JzZnloV2tjNlF2Q0VVR3o5L1RMTnFmUS9HTFNqbnJldlY4VWhlUnpiUU8w?=
 =?utf-8?B?QXNvYnNla2g2N0NtZFNyK0N3WjIwMUREc09JeHdFZFE1OS8vczR5eGFXcWY3?=
 =?utf-8?B?M0cvVmVRcGNERXNub09Pd0ZRcG5UcFgyZFNoK1c0eHluemFUVERRRy9QNTZR?=
 =?utf-8?B?cWF1WEQyaGxmdjNwY0c1UEdTZzBIR25PVWNmdGNMQUhZQzBSNVBZTVBVSlNq?=
 =?utf-8?B?ODYxSHNEYWpiQ0ZTV1RORnZISDFQSUg3UGJTRmxnNmg0ak05VXloS0hKcE1l?=
 =?utf-8?B?SG5USk9Sbk5nankvc05NRmowdFVGZnhVZFBPN1JMYzEycmVjVDVMRm1uVUhK?=
 =?utf-8?B?djNqbkU0S0xCQ3grbElMcEo0SE9BaGEyV082RlNnbzZRdUhNeUNTUWVabVkw?=
 =?utf-8?B?RXZjcFE3anVuWUswVDRwK1M1VzhwaGZqUlpFSmwrZzBQV0tGYXorVU9jQ3Ar?=
 =?utf-8?B?UVF1aWEvbDRsMmdDRE1sMktSMkwwUmVaYTRNMXFJMlhNYXNpcU5pK3NpZWlT?=
 =?utf-8?B?c2syL29odTN3dXBkenBkRTR2MitLSDdyeC9RS01pVlZWamlJSmpvK3NLTWlF?=
 =?utf-8?B?WThhelpBNTBVWnVTdk5PbjZIRERLVXpUdnpFbldiV0kvNE5YVjhLeldKU0Zh?=
 =?utf-8?B?ZWFNbzB4djI1M01ZWkd3cmNVV25ETElQeVJ5U0VadTV6dGpLSnhMdUo2YXlV?=
 =?utf-8?B?WU5iSXhLNTdnSmlxYjVJclhBSGxRYVdyMmVydzU1M3JiL2Y1YkYyV2hudUVQ?=
 =?utf-8?B?dGNqS2dTVmJJTkg1QlQzRG80Vm01d2J1T2ZVNC9xUXB3ZWNlN2JKVDBISEdH?=
 =?utf-8?B?amRPb3k2bkZOdEJrcVZ3QkJJQnNBS2VEakVtMnFmMFFPTG11R05HckFCVFZa?=
 =?utf-8?B?NHorNzI2ZlI2V2VVZDlKakgwQWh5QjI2cnVoUlU2Yy9BcEFNTExZdDAwMHVO?=
 =?utf-8?Q?+4fbSBIzVDO1cgxzqaVP9TBNi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4545.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425fd226-268d-4bad-0f95-08dbd1654081
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 12:08:20.7097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cCZrSGnryqAWXx7z7tulZyLv2sUK5bgVjsSosgZH43/kHQ3dGHWdbTWP3+LaLQcAt2rGn5+9jxKsYoGhh7xKLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6867
X-Proofpoint-GUID: XdbEGdFir1YaLqz-DTwREG6sJl-QusO-
X-Proofpoint-ORIG-GUID: XdbEGdFir1YaLqz-DTwREG6sJl-QusO-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310170000 definitions=main-2310200100
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIE9j
dG9iZXIgMjAsIDIwMjMgMTQ6MjYNCj4gVG86IEJhbGFzLCBFbGl6YSA8RWxpemEuQmFsYXNAYW5h
bG9nLmNvbT47IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+
DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3ps
b3dza2kNCj4gPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47IENvbm9yIERvb2xl
eSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IERlcmVrIEtpZXJuYW4gPGRlcmVrLmtpZXJuYW5AYW1k
LmNvbT47IERyYWdhbg0KPiBDdmV0aWMgPGRyYWdhbi5jdmV0aWNAYW1kLmNvbT47IEFybmQgQmVy
Z21hbm4gPGFybmRAYXJuZGIuZGU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMi8yXSBkcml2
ZXJzOiBtaXNjOiBhZGktYXhpLXRkZDogQWRkIFRERCBlbmdpbmUNCj4gDQo+IFtFeHRlcm5hbF0N
Cj4gDQo+IE9uIDIwLzEwLzIwMjMgMTM6MTgsIEJhbGFzLCBFbGl6YSB3cm90ZToNCj4gPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogR3JlZyBLcm9haC1IYXJ0bWFuIDxn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gPj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIg
MTksIDIwMjMgMjA6NTcNCj4gPj4gVG86IEJhbGFzLCBFbGl6YSA8RWxpemEuQmFsYXNAYW5hbG9n
LmNvbT4NCj4gPj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6
dG9mIEtvemxvd3NraQ0KPiA+PiA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsg
Q29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgRGVyZWsgS2llcm5hbiA8ZGVyZWsu
a2llcm5hbkBhbWQuY29tPjsgRHJhZ2FuDQo+ID4+IEN2ZXRpYyA8ZHJhZ2FuLmN2ZXRpY0BhbWQu
Y29tPjsgQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gPj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MyAyLzJdIGRyaXZlcnM6IG1pc2M6IGFkaS1heGktdGRkOiBBZGQgVEREIGVuZ2luZQ0K
PiA+Pg0KPiA+PiBbRXh0ZXJuYWxdDQo+ID4+DQo+ID4+IE9uIFRodSwgT2N0IDE5LCAyMDIzIGF0
IDAzOjU2OjQ2UE0gKzAzMDAsIEVsaXphIEJhbGFzIHdyb3RlOg0KPiA+Pj4gK2NvbmZpZyBBRElf
QVhJX1RERA0KPiA+Pj4gKwl0cmlzdGF0ZSAiQW5hbG9nIERldmljZXMgVEREIEVuZ2luZSBzdXBw
b3J0Ig0KPiA+Pj4gKwlkZXBlbmRzIG9uIEhBU19JT01FTQ0KPiA+Pj4gKwlzZWxlY3QgUkVHTUFQ
X01NSU8NCj4gPj4+ICsJaGVscA0KPiA+Pj4gKwkgIFRoZSBBREkgQVhJIFRERCBjb3JlIGlzIHRo
ZSByZXdvcmtlZCBhbmQgZ2VuZXJpYyBUREQgZW5naW5lIHdoaWNoDQo+ID4+PiArCSAgd2FzIGRl
dmVsb3BlZCBmb3IgZ2VuZXJhbCB1c2UgaW4gQW5hbG9nIERldmljZXMgSERMIHByb2plY3RzLiBV
bmxpa2UNCj4gPj4+ICsJICB0aGUgcHJldmlvdXMgVEREIGVuZ2luZSwgdGhpcyBjb3JlIGNhbiBv
bmx5IGJlIHVzZWQgc3RhbmRhbG9uZSBtb2RlLA0KPiA+Pj4gKwkgIGFuZCBpcyBub3QgZW1iZWRk
ZWQgaW50byBvdGhlciBkZXZpY2VzLg0KPiA+Pg0KPiA+PiBXaGF0IGRvZXMgInByZXZpb3VzIiBt
ZWFuIGhlcmU/ICBUaGF0J3Mgbm90IHJlbGV2YW50IGZvciBhIGtlcm5lbCBoZWxwDQo+ID4+IHRl
eHQsIGlzIGl0Pw0KPiA+Pg0KDQpJIHdpbGwgcmVkbyB0aGUgY29uZmlnIGhlbHAgdGV4dCB0byBt
YWtlIGl0IGNsZWFyZXIuDQoNCj4gPj4gQWxzbywgd2hhdCBpcyB0aGUgbW9kdWxlIG5hbWU/ICBX
aHkgd291bGQgc29tZW9uZSBlbmFibGUgdGhpcz8gIFdoYXQNCj4gPj4gdXNlcnNwYWNlIHRvb2xz
IHVzZSBpdD8NCg0KSSB3aWxsIGFkZCBhIGJldHRlciBkZXNjcmlwdGlvbi4gQ3VycmVudGx5IHRo
ZXJlIGFyZSBubyB1c2Vyc3BhY2UgdG9vbHMNCnRoYXQgdXNlIHRoZSBkZXZpY2UuIFRoaXMgcGxh
dGZvcm0gZHJpdmVyIGdpdmVzIHRoZSBwb3NzaWJpbGl0eSB0byBhY2Nlc3MNCmFuZCBjb25maWd1
cmUgdGhlIGRldmljZSB1c2luZyB0aGUgc3lzZnMgaW50ZXJmYWNlLg0KDQo+ID4+DQo+ID4+PiAr
DQo+ID4+PiAgY29uZmlnIERVTU1ZX0lSUQ0KPiA+Pj4gIAl0cmlzdGF0ZSAiRHVtbXkgSVJRIGhh
bmRsZXIiDQo+ID4+PiAgCWhlbHANCj4gPj4NCj4gPj4gV2h5IHB1dCB5b3VyIGVudHJ5IGluIHRo
aXMgc3BlY2lmaWMgbG9jYXRpb24gaW4gdGhlIGZpbGU/DQoNCkkgYWRkZWQgdGhlIGVudHJ5IGlu
IHRoZSBrY29uZmlnIGZpbGUgYmFzZWQgb24gdGhlIGFscGhhYmV0aWNhbCBvcmRlci4NCg0KPiA+
Pg0KPiA+Pj4gK3N0YXRpYyBpbnQgYWRpX2F4aV90ZGRfcGFyc2VfbXMoc3RydWN0IGFkaV9heGlf
dGRkX3N0YXRlICpzdCwNCj4gPj4+ICsJCQkJY29uc3QgY2hhciAqYnVmLA0KPiA+Pj4gKwkJCQl1
NjQgKnJlcykNCj4gPj4+ICt7DQo+ID4+PiArCXU2NCBjbGtfcmF0ZSA9IFJFQURfT05DRShzdC0+
Y2xrLnJhdGUpOw0KPiA+Pj4gKwljaGFyICpvcmlnX3N0ciwgKm1vZGZfc3RyLCAqaW50X3BhcnQs
IGZyYWNfcGFydFs3XTsNCj4gPj4+ICsJbG9uZyBpdmFsLCBmcmFjOw0KPiA+Pj4gKwlpbnQgcmV0
Ow0KPiA+Pj4gKw0KPiA+Pj4gKwlvcmlnX3N0ciA9IGtzdHJkdXAoYnVmLCBHRlBfS0VSTkVMKTsN
Cj4gPj4+ICsJaW50X3BhcnQgPSBzdHJzZXAoJm9yaWdfc3RyLCAiLiIpOw0KPiA+Pg0KPiA+PiBX
aHkgYXJlIHdlIHBhcnNpbmcgZmxvYXRpbmcgcG9pbnQgaW4gdGhlIGtlcm5lbD8gIFBsZWFzZSBq
dXN0IGtlZXAgdGhlDQo+ID4+IGFwaSBzaW1wbGUgc28gdGhhdCB3ZSBkb24ndCBoYXZlIHRvIHRy
eSB0byBkbyBhbnkgdHlwZSBvZiBwYXJzaW5nIG90aGVyDQo+ID4+IHRoYW4gdHVybmluZyBhIHNp
bmdsZSB0ZXh0IG51bWJlciBpbnRvIGEgdmFsdWUuDQo+ID4+DQo+ID4NCj4gPiBUaGUgYWRpX2F4
aV90ZGRfcGFyc2VfbXMgZnVuY3Rpb24gZG9lcyBhbG1vc3QgdGhlIHNhbWUgdGhpbmcgYXMgdGhl
DQo+ID4gaWlvX3N0cl90b19maXhwb2ludCgpIGZ1bmN0aW9uIHdoaWNoIGFscmVhZHkgZXhpc3Rz
IGluIGtlcm5lbC4NCj4gPiBJdCBwYXJzZXMgYSBmaXhlZC1wb2ludCBudW1iZXIgZnJvbSBhIHN0
cmluZy4NCj4gPiBUaGUgX19paW9fc3RyX3RvX2ZpeHBvaW50IGlzIHVzZWQgaW4gYSBzaW1pbGFy
IHdheSwgYXMgSSBpbnRlbmQgdG8gdXNlIGFkaV9heGlfdGRkX3BhcnNlX21zLg0KPiA+IEl0IHdy
aXRlcyB0byBhIGNoYW5uZWwgdGhlIGNvcnJlc3BvbmRpbmcgc2NhbGUgKG1pY3JvLG5hbm8pIGZv
ciBhIHZhbHVlLg0KPiA+DQo+ID4gU2luY2UgdGhlIGRldmljZSBpcyBub3QgYW4gaWlvIGRldmlj
ZSwgdXNpbmcgYW4gaWlvIGZ1bmN0aW9uIHdvdWxkIGJlIGNvbmZ1c2luZy4NCj4gPiBUaGF0IGlz
IHRoZSByZWFzb24gZm9yIGNyZWF0aW5nIHRoZSBhZGlfYXhpX3RkZF9wYXJzZV9tcyBmdW5jdGlv
biwgd2hpY2ggaXMgZWFzaWVyDQo+ID4gdG8gdW5kZXJzdGFuZCBzaW5jZSBJIGRvbid0IGhhdmUg
dG8gbWFrZSBhbGwgdGhlIG11bHRpcGxpY2F0aW9ucyB0aGF0IGFyZSBtYWRlDQo+ID4gaW4gdGhl
IF9faWlvX3N0cl90b19maXhwb2ludCBmdW5jdGlvbi4NCj4gDQo+IFdoeSBkaWQgeW91IHNraXAg
b3RoZXIgY29tbWVudHM/DQo+IA0KIA0KQnkgbWlzdGFrZSwgSSBoaXQgdGhlIHNlbmQgYnV0dG9u
LiBJIGFkZGVkIHRoZW0gbm93Lg0KDQo+ID4+PiArCXJldCA9IGtzdHJ0b2woaW50X3BhcnQsIDEw
LCAmaXZhbCk7DQo+ID4+PiArCWlmIChyZXQgfHwgaXZhbCA8IDApDQo+ID4+PiArCQlyZXR1cm4g
LUVJTlZBTDsNCj4gPj4NCj4gPj4gWW91IGxlYWtlZCBtZW1vcnkgOigNCj4gPj4NCj4gPj4gVXNl
IHRoZSBuZXcgbG9naWMgaW4gY29tcGxldGlvbi5oIHRvIG1ha2UgdGhpcyBzaW1wbGVyPw0KPiA+
Pg0KPiA+Pj4gKwltb2RmX3N0ciA9IHN0cnNlcCgmb3JpZ19zdHIsICIuIik7DQo+ID4+PisJaWYg
KG1vZGZfc3RyKSB7DQo+ID4+PisJCXNucHJpbnRmKGZyYWNfcGFydCwgNywgIiVzMDAwMDAiLCBt
b2RmX3N0cik7DQo+ID4+PisJCXJldCA9IGtzdHJ0b2woZnJhY19wYXJ0LCAxMCwgJmZyYWMpOw0K
PiA+Pj4rCQlpZiAocmV0KQ0KPiA+Pj4rCQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4+DQo+ID4+IFlv
dSBsZWFrZWQgbWVtb3J5IDooDQo+ID4+DQo+ID4+PisJfSBlbHNlIHsNCj4gPj4+KwkJZnJhYyA9
IDA7DQo+ID4+PisJfQ0KPiA+Pj4rDQo+ID4+PisJKnJlcyA9IERJVl9ST1VORF9DTE9TRVNUX1VM
TCgodTY0KWl2YWwgKiBjbGtfcmF0ZSwgMTAwMCkNCj4gPj4+KwkJKyBESVZfUk9VTkRfQ0xPU0VT
VF9VTEwoKHU2NClmcmFjICogY2xrX3JhdGUsIDEwMDAwMDAwMDApOw0KPiA+Pg0KPiA+PiBXaHkg
aXNuJ3QgdXNlcnNwYWNlIGRvaW5nIHRoaXMgY2FsY3VsYXRpb24/DQoNClRoZSBzdHJpbmcgY29u
dGFpbnMgYSBmaXhlZC1wb2ludCBudW1iZXIgZm9yIGEgdmFsdWUgaW4gbWlsbGlzZWNvbmRzLA0K
YnV0IHRoZSB2YWx1ZSBtdXN0IGJlIHdyaXR0ZW4gaW4gdGhlIHJlZ2lzdGVyIGluIGNsb2NrIGN5
Y2xlcy4gDQpUaGUgY2xvY2sgcmF0ZSBtYXkgY2hhbmdlLCBhbmQgd2UgbXVzdCB0cmFuc2Zvcm0g
dGhlIHZhbHVlIGluDQpjbG9jayBjeWNsZXMsIHNvIHRoaXMgaXMgdGhlIHJlYXNvbiBmb3IgdGhp
cyBjYWxjdWxhdGlvbiBoZXJlLg0KDQo+ID4+DQo+ID4+IEkgc3RvcHBlZCByZXZpZXdpbmcgaGVy
ZSwgc29ycnkuDQo+ID4+DQo+ID4+IGdyZWcgay1oDQoNClRoYW5rIHlvdSwNCkVsaXphDQo=
