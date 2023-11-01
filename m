Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089F17DE325
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjKAPWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjKAPWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:22:45 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF43DA;
        Wed,  1 Nov 2023 08:22:39 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A1DRHan001057;
        Wed, 1 Nov 2023 11:21:58 -0400
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3u39sp5sfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 11:21:58 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtRd7dY90Fb+Wcx2LRy9rOSgLSYtTekOX1ZsXiI9kmV62BpYaBOBLmCCzBwYxm2msv0y0/GEG5IEExD0R6BhUGKfVATRO17bekflIty1ecKU7P46NoEt5ojkNrg2SoZFStkf9qLed9ZtNkJKxE7/RMBeXK4VbpyJ/PWEDyhViNfOFFUcK+m8iVgccV2nu1suT7woovYa03d8VtXy4VfXmIkMFHYdvXh/ChRJD4CVhzMM7FPPlVb1wf2+8eNeACx4xwGUAsTGAPzYyL4zjzrKFDQUwX77ZBHCK+X9nxBviIE7J8BXCJbKrlqSTIBr1uvN6/rnGrwlqSIZoxVOQKim9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4Peck0mGsI32ttvfOoZz5XlgE8hNudsC3r2Ysp4Tfw=;
 b=UWsgR6wfoNpc5vt0H0bjSUayFwmPl2MPElRQcOx4iofMm5271Su6f/ho0DwDm+IaGtb5rCFZMytNyP1/URTuuBose76E+/AdHPIBJ5ueB9lJAC+FrLXzFBUskFZzzj5NBCScbB49oVH6vbJ7lgR3ykag2QChHZPOLWUp86fGdjKOXHYqQxlNou8y8BQkyIl656Up9pqkLpuohLQ1WZaQsd4Q1M9442yAz7Qix+mk/ZWywlr7SO7nBIRrYaLvtbgSqHyChEMf+7MMTW8aXujB2lvHjXNmCAuSn6yKCV4MFKxVESYp0e/Paau/RW9UXuVn/XyITIDhbjLNpgsLPaA1Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4Peck0mGsI32ttvfOoZz5XlgE8hNudsC3r2Ysp4Tfw=;
 b=hgpzde2Y12NlGkO9FWSHB35Q5LCF8gYDkv0+WSj22cEcUbxqax0UDsxRnxu2GpN9GofU7C1GlCvFA2ETGbn9GmE8Y26dVDnYTVn/zeaUGbr6PJMLea3jh8wqFPoAm4zfnnCgMhaYHK+RkyUEDCjhElbtJSVd7ZW45ZMTlqc2wvI=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by MW4PR03MB6524.namprd03.prod.outlook.com (2603:10b6:303:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Wed, 1 Nov
 2023 15:21:56 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::26c3:a563:9b0a:3321]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::26c3:a563:9b0a:3321%3]) with mapi id 15.20.6954.014; Wed, 1 Nov 2023
 15:21:56 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] rtc: max31335: add driver support
Thread-Topic: [PATCH v4 2/2] rtc: max31335: add driver support
Thread-Index: AQHaDMEKHQ+RJtDWgkKJJS24k84zJrBlhACAgAALsYA=
Date:   Wed, 1 Nov 2023 15:21:56 +0000
Message-ID: <CY4PR03MB3399426A31899901EBADDECF9BA7A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20231101094835.51031-1-antoniu.miclaus@analog.com>
 <20231101094835.51031-2-antoniu.miclaus@analog.com>
 <81efcde1-8305-465a-85a2-cfe449e8a8da@roeck-us.net>
In-Reply-To: <81efcde1-8305-465a-85a2-cfe449e8a8da@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTAyTWpVNE1HRmhNaTAzT0dOaExURXhaV1V0WVdVM09TMWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjTmpJMU9EQmhZVE10TnpoallTMHhN?=
 =?utf-8?B?V1ZsTFdGbE56a3RaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXlOakk1SWlCMFBTSXhNek0wTXpNeU5UY3hNelk1TWpZMk1UVWlJR2c5SWxK?=
 =?utf-8?B?Qk1sRm9hMEppVTBabWVIUlBSV3RCY0dKeldXMTJVRzFaTUQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUTFoeU9UUnJNWGQ2WVVGbGJ6VkdkbGR0ZWk4eGRq?=
 =?utf-8?B?WnFhMWM1WVdKUUwxYzRSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQlJVOXdiRTluUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
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
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|MW4PR03MB6524:EE_
x-ms-office365-filtering-correlation-id: d536358b-4b2c-4ccb-e1b1-08dbdaee48c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HRb+hOMt7mTIBkgIq/skIB/pColL7R5q9dydFITytdHRN8kMacZWohSPWRWdpriilD+2msFrl8gmrRw91KgvmfEJVIsM5xlD0vUK9SKFncdR27EPvwgIghZM0+YqhNmbZAgQ5Yh53bYyyrJfn/ahY9WQUV0iX0bQ5eb7u8mcSjjavtzKoZHhFx1vIdp36I4jUGRRSF0xrk18ucdjNqG3/iGjnyk1fHXphU/ZCDEqJ9AcLBxjoe0kz/FLVdlNL4KUnboJ/Zmfbi4LSgJVD5kPt9BBUIRExA1kx9nIYp0a4gDnlwRhiKrDGCV79pj89LwQUNa7sbaLG/gZwjnoSGhD3bC83lK2eXr8efJv0umi3xlY7rkos4Z/dhnLzQ2clidBU/QFFbzr5rbsbDi0WEPTwwcawlnq0tTNvxt6rzk/0ZNCpB8COa4mVL8c/PdMbiOpzCx1XUyuXPS7F+na/ZXpsikttij/RsYnwqV8ANXZxd5YKMP+PteBne5b/Mb03nytpD/8Yc78HV2FFG1rrLGxp9hk42Fci77dsjk9Sn2fUofM2kXo18Ircj/Iy6cY+dikMwWsrYBjwu9U+C1eQRrd9EPQTX6bzLIunqCiXtyRWt0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(5660300002)(7416002)(41300700001)(2906002)(66556008)(54906003)(66446008)(66476007)(66946007)(76116006)(8676002)(4326008)(8936002)(966005)(52536014)(316002)(478600001)(6916009)(64756008)(38070700009)(83380400001)(33656002)(86362001)(38100700002)(122000001)(7696005)(9686003)(6506007)(55016003)(71200400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czdzZ2Q0dW5IWFMyZ2E4NWg3SjZjcDAydFNLcEp4Sm5pQjczVDNuL2JKd25s?=
 =?utf-8?B?N0IvcU1oRFRERGV0am10dmE5N3g2Z0dhM3paR2dEZVpLOWdvLytldnp3QjhO?=
 =?utf-8?B?VkNPbzNPZXVIZkRmRFNUUkUvNmtxK3o5YlZpbVJ5S2FtYyt4YSswTjl6VFNP?=
 =?utf-8?B?Y0ZXQnhtMVZHYm1mTnRYRjVvTHpTTGE5dVdRRlhzcjZJNFp1WVcyazlvNUl2?=
 =?utf-8?B?MW9TSzlZbHJrdDNSbndVelROZFRMejU1UEdreTJtb3hiV3piczJ5eXZRck8r?=
 =?utf-8?B?ajB2ZTRVbWlzVjRZRDBLRUQvK2Q5MGM1TE44TXBiMnl4eS9WcXJuK1dzYlYv?=
 =?utf-8?B?YVArMWh6YnZoRW9XdUh5ZWVjTDVQa0U1dVNJYmFBMVp2Y0k1cGZjejJ4UzBB?=
 =?utf-8?B?WGQ4RjROWGlSM2hYbXZ1UEJBTjJza3RwQlhKcTJCbGVpT3hGT2dCUG4yb0g0?=
 =?utf-8?B?YWJOWDdpWTFCRTh6YlN1YXZtYlRJQi9TVlNKNHdXMkJBRVZoRjNBVEh0ZjJC?=
 =?utf-8?B?bGh6SUhMaXlQTmdlYi9TY1B1Z1ZaRERsWjluemZNeHpwVzZHQ1FTYlV4bHhM?=
 =?utf-8?B?eDEyMWVhbmdXdEt3OGxKUmFPQU1CVW1JeEs1dXNzaGgwdmRwSElnSlcxcGU1?=
 =?utf-8?B?WFFyenhpbWh6Tk9HYmFJZFlEbkRjeXZyMkhRNnhVeGtHb2J0N0hrUWlEaGFY?=
 =?utf-8?B?WHNxdi9FZzRBMzYxODBaSUJjNWIrb3MwSlN0ZzVVc2pNa1BOSko0TGpPQWpG?=
 =?utf-8?B?bUNyMWQzV2VqYm1CWmJwc2wzSjZPcnh1dTFkb08yNzlxY0wwSk5jd2JEZVdQ?=
 =?utf-8?B?MTY1QXpxSXl4V2VDeVBQR0c3L3FvY2VUSldqeFZpNFJnZ2lrNWloRGgwVGhN?=
 =?utf-8?B?QlZDWEJPMDVHWEhCdEZhdXEyQVdqU0JLUzBKWGkyVnF2RXE1QjM4UTBpNGh2?=
 =?utf-8?B?bFhFR2ZLeHpvMzhvUXJzeWFaSlgwYVFWTmFsUlpsS3BCalhacjl3T3Z4NGQv?=
 =?utf-8?B?WVg4Nll3MlJlVWJJY0NrMUIraEhIRE0rSjlpK1JBSElxamViMGRuVEpFQ3hW?=
 =?utf-8?B?RzNWRjV0OGdhK1pNcTB5N2gyRExXemtGVCtuU0dkS1lEWWt4OTk2dmlZK1JO?=
 =?utf-8?B?NDQwNklFTWtRNVpXVlhmT3M1V0lHU3lTUUFJSEQzcFhObzF0MEFGRWJzbmtx?=
 =?utf-8?B?bEU2bSt0L1ZVV2FVZ3p5LzdOaXNRS0FiTk5hM3lyS3pNaWFxL1luYkVVOGpW?=
 =?utf-8?B?Vkd3TUZINXhwU3o4bDh5Y2xEMWYvVS9EVFFPVTdSZGhxY1cwZkZRd1lxVnFG?=
 =?utf-8?B?UnZRVEtKdDBvVXU3N25yZlh4aUcydTVzd0M0VnlOSWFTNnByQnhMeCs1WnlG?=
 =?utf-8?B?d1l3MU11M3Z6c3BuWnczbWJGK3kwQ2lQM1NJODZyL3YyVlNFcEltV1U2OTRr?=
 =?utf-8?B?cXhjcjlyZSsyUGlrMW9qM0NHMXgvSmpSeXdTUUwrNkhRc0RnOTNIRVhNWmty?=
 =?utf-8?B?aE81bjY0QU01ZFpsMHN4YlpocUxLZUpXMzA4RTMyVHJ1b0JrcW1pRUxQd1Fj?=
 =?utf-8?B?djlXR1JhOUFKMWZtbkllOGdrYnpHK1g0NUhibnFpVnZJeW16aGdHQlhXdXdz?=
 =?utf-8?B?S0YrejRURGovaGRva0pEbnlXWVJQaitGMUswWllkZzRJNUx1YVhLS3BzemhW?=
 =?utf-8?B?NFNsNXpqUXk2cSthQUVSOWc5YlAvSW9FcGxmUVVuNnZONCtuN1dqODJ1QWR0?=
 =?utf-8?B?UmNhYUkrV3FXV0R0YTZtVWpZc1NVODNuSTdvb1E2NlZqM2FYWGQvTzMxL3A0?=
 =?utf-8?B?WldXemlxNmlZZXdwdTZ2TFNJcEkydzh0OFRiU3BRMXYzTE43VHFBZlI2Z3J1?=
 =?utf-8?B?T3hma3l6aVB0cjhVeXg4dEtWZzVTWE9oQUdVWTB0SG90RUZja0RsQWNnbVU4?=
 =?utf-8?B?OWZtMEhvQ05nVTUyUDVrZmVKWTdXYjgyZTVHTGExdlFtZXRZaHo3dGR4Vkxs?=
 =?utf-8?B?RGJ2TjM0THQ5dDJpNGw4N0lBT0x3eFBtSllCU01qQVF2cHVxZXY0c3N6K0Rk?=
 =?utf-8?B?S01RQmpwQWNBMzJWVkdEUTVPNjdLc081NFMrV3R3RHVXOVFEUzNuUk9LM1NZ?=
 =?utf-8?B?OFNUdVVMQTBPSjB3bHBHSUhSb0ZHTjlUOGFjcklzK24yaU9nd3VVeE9EVEJw?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d536358b-4b2c-4ccb-e1b1-08dbdaee48c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 15:21:56.0754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Igqu9uE9Pi5S1kDiwx9s+WaNwNqzOswKpxO0hgCe4yjmHdHEjVyfQicnx1QLWb4bwdGNXuJd38RX0e/hsLzVhfDySyFhIDcSOedckUnn85I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6524
X-Proofpoint-ORIG-GUID: JvUn3V_hEwbPO-CFpK9-EQ30jR9Kxskp
X-Proofpoint-GUID: JvUn3V_hEwbPO-CFpK9-EQ30jR9Kxskp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_13,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 mlxlogscore=955 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310240000 definitions=main-2311010127
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBXZWQsIE5vdiAwMSwgMjAyMyBhdCAxMTo0ODoxNEFNICswMjAwLCBBbnRvbml1IE1pY2xh
dXMgd3JvdGU6DQo+ID4gUlRDIGRyaXZlciBmb3IgTUFYMzEzMzUgwrEycHBtIEF1dG9tb3RpdmUg
UmVhbC1UaW1lIENsb2NrIHdpdGgNCj4gPiBJbnRlZ3JhdGVkIE1FTVMgUmVzb25hdG9yLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogQW50b25pdSBNaWNsYXVzIDxhbnRvbml1Lm1pY2xhdXNAYW5h
bG9nLmNvbT4NCj4gPiAtLS0NCj4gPiBjaGFuZ2VzIGluIHY0Og0KPiA+ICAtIGFkZCBLY29uZmln
IGVudHJ5IGZvciBIV01PTiBkZXBlbmRlbmN5Lg0KPiA+ICBNQUlOVEFJTkVSUyAgICAgICAgICAg
ICAgICB8ICAgOCArDQo+ID4gIGRyaXZlcnMvcnRjL0tjb25maWcgICAgICAgIHwgIDIwICsNCj4g
PiAgZHJpdmVycy9ydGMvTWFrZWZpbGUgICAgICAgfCAgIDEgKw0KPiA+ICBkcml2ZXJzL3J0Yy9y
dGMtbWF4MzEzMzUuYyB8IDc2NQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgNzk0IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvcnRjL3J0Yy1tYXgzMTMzNS5jDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPiA+IGluZGV4IGRkNWRlNTQwZWMwYi4u
YmM0ODRjYjk5N2FiIDEwMDY0NA0KPiA+IC0tLSBhL01BSU5UQUlORVJTDQo+ID4gKysrIGIvTUFJ
TlRBSU5FUlMNCj4gPiBAQCAtMTI4MjMsNiArMTI4MjMsMTQgQEAgRjoNCj4gCURvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9od21vbi9hZGksbWF4MzE4MjcueWFtbA0KPiA+ICBGOglE
b2N1bWVudGF0aW9uL2h3bW9uL21heDMxODI3LnJzdA0KPiA+ICBGOglkcml2ZXJzL2h3bW9uL21h
eDMxODI3LmMNCj4gPg0KPiA+ICtNQVgzMTMzNSBSVEMgRFJJVkVSDQo+ID4gK006CUFudG9uaXUg
TWljbGF1cyA8YW50b25pdS5taWNsYXVzQGFuYWxvZy5jb20+DQo+ID4gK0w6CWxpbnV4LXJ0Y0B2
Z2VyLmtlcm5lbC5vcmcNCj4gPiArUzoJU3VwcG9ydGVkDQo+ID4gK1c6CWh0dHBzOi8vZXouYW5h
bG9nLmNvbS9saW51eC1zb2Z0d2FyZS1kcml2ZXJzDQo+ID4gK0Y6CURvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9ydGMvYWRpLG1heDMxMzM1LnlhbWwNCj4gPiArRjoJZHJpdmVycy9y
dGMvcnRjLW1heDMxMzM1LmMNCj4gPiArDQo+ID4gIE1BWDY2NTAgSEFSRFdBUkUgTU9OSVRPUiBB
TkQgRkFOIENPTlRST0xMRVIgRFJJVkVSDQo+ID4gIEw6CWxpbnV4LWh3bW9uQHZnZXIua2VybmVs
Lm9yZw0KPiA+ICBTOglPcnBoYW4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ydGMvS2NvbmZp
ZyBiL2RyaXZlcnMvcnRjL0tjb25maWcNCj4gPiBpbmRleCBkNzUwMjQzM2M3OGEuLjM2MGRhMTNm
ZTYxYiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3J0Yy9LY29uZmlnDQo+ID4gKysrIGIvZHJp
dmVycy9ydGMvS2NvbmZpZw0KPiA+IEBAIC0zNzMsNiArMzczLDI2IEBAIGNvbmZpZyBSVENfRFJW
X01BWDg5OTcNCj4gPiAgCSAgVGhpcyBkcml2ZXIgY2FuIGFsc28gYmUgYnVpbHQgYXMgYSBtb2R1
bGUuIElmIHNvLCB0aGUgbW9kdWxlDQo+ID4gIAkgIHdpbGwgYmUgY2FsbGVkIHJ0Yy1tYXg4OTk3
Lg0KPiA+DQo+ID4gK2NvbmZpZyBSVENfRFJWX01BWDMxMzM1DQo+ID4gKwl0cmlzdGF0ZSAiQW5h
bG9nIERldmljZXMgTUFYMzEzMzUiDQo+ID4gKwlkZXBlbmRzIG9uIEkyQw0KPiA+ICsJc2VsZWN0
IFJFR01BUF9JMkMNCj4gPiArCWhlbHANCj4gPiArCSAgSWYgeW91IHNheSB5ZXMgaGVyZSB5b3Ug
Z2V0IHN1cHBvcnQgZm9yIHRoZSBBbmFsb2cgRGV2aWNlcw0KPiA+ICsJICBNQVgzMTMzNS4NCj4g
PiArDQo+ID4gKwkgIFRoaXMgZHJpdmVyIGNhbiBhbHNvIGJlIGJ1aWx0IGFzIGEgbW9kdWxlLiBJ
ZiBzbywgdGhlIG1vZHVsZQ0KPiA+ICsJICB3aWxsIGJlIGNhbGxlZCBydGMtbWF4MzEzMzUuDQo+
ID4gKw0KPiA+ICtjb25maWcgUlRDX0RSVl9NQVgzMTMzNV9IV01PTg0KPiA+ICsJYm9vbCAiSFdN
T04gc3VwcG9ydCBmb3IgQW5hbG9nIERldmljZXMgTUFYMzEzMzUiDQo+ID4gKwlkZXBlbmRzIG9u
IFJUQ19EUlZfTUFYMzEzMzUgJiYgSFdNT04NCj4gPiArCWRlcGVuZHMgb24gIShSVENfRFJWX01B
WDMxMzM1PXkgJiYgSFdNT049bSkNCj4gPiArCWRlZmF1bHQgeQ0KPiA+ICsJaGVscA0KPiA+ICsJ
ICBTYXkgWSBoZXJlIGlmIHlvdSB3YW50IHRvIGV4cG9zZSB0ZW1wZXJhdHVyZSBzZW5zb3IgZGF0
YSBvbg0KPiA+ICsJICBydGMtbWF4MzEzMzUuDQo+ID4gKw0KPiANCj4gVGhpcyBpc24ndCB1c2Vk
IGluIHRoZSBkcml2ZXIuIERpZCB5b3UgdGVzdCB3aXRoIEhXTU9OPW4gPw0KPiANCg0KSSBuZWVk
IHRvIHN0YXJ0IHRoaW5raW5nIGEgYml0IG1vcmUgb3V0IG9mIHRoZSBib3ggaW5zdGVhZCBvZiAN
CnRha2luZyBvdGhlciBkcml2ZXIgYXBwcm9hY2hlcyBhcyBiZWluZyB0aGUgb25seSB3YXkgdG8g
Z28uIPCfmIoNCg0KV2lsbCBmaXggaW4gdjUuDQoNCj4gR3VlbnRlcg0K
