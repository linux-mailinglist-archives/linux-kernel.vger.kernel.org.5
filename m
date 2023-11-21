Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A14B7F3183
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbjKUOrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbjKUOrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:47:33 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7508490;
        Tue, 21 Nov 2023 06:47:29 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ALB5BUg027047;
        Tue, 21 Nov 2023 09:47:09 -0500
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3uer08ch38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 09:47:08 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4qS0VoPVyqPlWjbBlbGxd5ot6M7S4t6CsCYwoW6/egNqdOk2Xxq3iOb1bN9ftpBJlgQwGarMD7Crf2kICu9bPcoQhi3OqQflTpjj0CFGVBJpPbxWbt8dcsQszpSC/ByZrEn5VZd8aXbWlf0njy9rBHiOhxJ8ZZ+W5tBZOkC3/MN2Pu0skPGgrw96hmI64qntlc2Irh9Pv64/l2numh1A6nVFkEqttwF3MO/T93vniqL5UaTZ9yec3/9+Tq7Byj7UfZIQYpE+gMz7JRl00MBM8QTayNw/3Xd/B1hgmDOpgBE/Q8wyTvawFIvmCCOq6EWK9Ry9Is+3bItmwAEg6cNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqUGQo8gFeCUZCKHXYhr+6QKi36YOP+ZaIalBXA7r4Q=;
 b=gwXS6aZjnF9SZYw10nkyux2Ff/MuY9HrWdwlEkDmszvkU1FLqsc0+9khwgtj0CO5XrldnyZeyw6mZGreDY0AjEhMNTD8thBAhIq4AZT5v5lfMSXwPXGm2ggMS4TTkI37hrHc0AFwFteUUdfV+kvjuq0ldUUXNR1PclGDR4eKpQX8CmAasrycmo4Y0iM1JE9zIOWj+lT4us7iUmqAcRDiHVK4WQlRx1r2pjJedYU/Fhabrt0cVQUpPB8XtxDHDmRk6/nuHe3kG1ZLW1K5HiKmc/BfeYsf2Yscv1jfjrWs2Yw08XpBBEOi5EB0l+E0alq7aWmqqxamw0hTKxkGA9bS1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqUGQo8gFeCUZCKHXYhr+6QKi36YOP+ZaIalBXA7r4Q=;
 b=ZNABsIECnUJqQWV+2bRM5AaVCY3rGIE+6MsNds4nVIzP89GoLVUrntkq3sgy53xsxjNmYnfm+9pXoZxTJUFEBq/+EfdmUgEyTzYJl7InLmbzwmGmHuCNndwQWnfWPNLOTMmt/cBjb0qQ8fDl9NqoTIQhQ8jzFAz5WEulR4GaAa0=
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by SA3PR03MB7513.namprd03.prod.outlook.com (2603:10b6:806:39a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Tue, 21 Nov
 2023 14:47:06 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::f174:c671:b889:ef4d]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::f174:c671:b889:ef4d%4]) with mapi id 15.20.7025.014; Tue, 21 Nov 2023
 14:47:05 +0000
From:   "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: iio: frequency: add admfm2000
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: frequency: add admfm2000
Thread-Index: AQHaHGGTFzEQbq71v0Cv3FU0TcV+DLCEvdQAgAAaKRA=
Date:   Tue, 21 Nov 2023 14:47:05 +0000
Message-ID: <PH0PR03MB7141E0B29DFEEE16C4A5D27FF9BBA@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20231121100012.112861-1-kimseer.paller@analog.com>
 <c4f31613-8365-4d4d-a3ec-1b573f822968@linaro.org>
In-Reply-To: <c4f31613-8365-4d4d-a3ec-1b573f822968@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYTNCaGJHeGxjakpjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFrTlRJek9XWmpaUzA0T0RkakxURXhaV1V0WVdWaU1pMHhORGMx?=
 =?utf-8?B?TldJek5XUmtZemhjWVcxbExYUmxjM1JjWkRVeU16bG1aREF0T0RnM1l5MHhN?=
 =?utf-8?B?V1ZsTFdGbFlqSXRNVFEzTlRWaU16VmtaR000WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXpNVGM0SWlCMFBTSXhNek0wTlRBMU1UWXlNemcwTnpReE5qRWlJR2c5SWxa?=
 =?utf-8?B?TFVFWnJiMmxNWkRGUlp6RnRWWEJOTldOWFNuWnBiamQzV1QwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUTNodE0zbFlhVko2WVVGakswOTNjRXA1VVVWeFVu?=
 =?utf-8?B?bzBOME5yYmtwQlUzQkZSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|SA3PR03MB7513:EE_
x-ms-office365-filtering-correlation-id: 036ad8f7-7d6f-4744-3abc-08dbeaa0bb25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7pyr891MuC8Bqza7lKDtKX3NPsLbVaf4sJLGTnwLEnXOhYuikleJ0Nw1Wd7PR/rnb/3NFUJkDyVrQXi3i8FEDekRXeguejJnNf1bfWFmLGxVkeOv1Ju4r16mdsnBw4x0Z/BUjC55f0xQ+pmpCysu/eCV0w9gEfwpV1OQa8WTZW8jYnsY7g9Lg6gyPmxM+++7ElH2Ql1Pdj2ygiQIhoSVMJKpbq4bGauPcrrX5ZEYRhn4v+RRSlAv74+cb6haEWES4wnxtZAlRHhu4guNuCg77OxsoW8290OGtd70sR6mjhlShGD+zODZgQRF5pJdT94JcKM2kgdXZnci+aqOm6Cu2EKOnmcwLVOopUm3sMG2GZsDku1+uVrCN7MKp+RGrs1xYI4Qd0lsEiOTEE7hsWu5gjKUNgb89XDN6ZvSAZy+Vx80NUs6X3nGG+2asmRsOPkOwJFf8cAJbU3/23SP1cgpws9XEwE0obWiBQqXgl9FBelfz6H1FnC88a494AKcI2oa404r0mUa2S1swupAxqbGRT/H5mHGI1Sd4ofSjIIxBHRAMTiT2z7SEan6Q0t+8JGCUdloSkhT2llkrChadFkHM/B2aQJeCGWacmS6XpVEIdQ268dTvHGrERDge5gnAiHtKn3Y6PCcJO0jfwTT/dAi3Ds9ntAxSmSAP8EqR3k76Gg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230273577357003)(230922051799003)(230173577357003)(1800799012)(186009)(64100799003)(451199024)(38100700002)(83380400001)(55016003)(26005)(122000001)(9686003)(71200400001)(7696005)(6506007)(478600001)(53546011)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(316002)(6916009)(4326008)(8936002)(8676002)(52536014)(5660300002)(86362001)(2906002)(38070700009)(33656002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3RWNE4wUnluRU9od2FhTEw5aEgyZ2NVMGpLRHA4bnhSMVFWRGhoMmdubVBm?=
 =?utf-8?B?aWRtRnNqeVJaZFRoMU9GajErVmJDQkZ3YlBpK0FtQ1BYMlhtWUJYa0pmSHhz?=
 =?utf-8?B?UDdyTEo5d1ZubFhBOTkxdTgzWk5OQ2NqbVFHR0VWN0tidENWclo0Y1B6NUQ2?=
 =?utf-8?B?UTVMbUNnVElFanJpbURydUtlOHR6NUR2YWlCTlNhRDJmSGNVTjBJZjZDS2Z4?=
 =?utf-8?B?YmwzRUZlRFkyWFJ2UitvR1JtVTRFeHpoS3dIQk4wbFZnWTNnUTNpc08yTjZX?=
 =?utf-8?B?d0ZNOWNhZUhPekxmM3IwTTZkUldqZnoycjdmWDBMekhRTGxZMnB0ZGZTWTNv?=
 =?utf-8?B?L0Zwejh0RDlrR21ubG45R3RaczBUbDZDdFZGR2kvak0rRlhMclhhNkRHK1U5?=
 =?utf-8?B?R0V6QkZLMXRzYjQ5eWt1enAwakcvaEJ2bHhyaXBDdnA1VGplZUhFQkIwNUtC?=
 =?utf-8?B?bzRpY05sM1Q5bzhEUDJoam82czc3WHdGd0tMK1lteHRCUnZSZFlOR2o5MytH?=
 =?utf-8?B?STdpOWptUW1WZlVQRUdOMFVJN3IySFkzcW5IaGdPN1dRV1J2RW9WY0pkeDZa?=
 =?utf-8?B?Vy9lb0VUMXFoSXJoQmoyLzJnUC8za0tWeldDZmZvdk9zNW1PUWhvajd2Ny8x?=
 =?utf-8?B?c2k2U1dyRnBuOEQrZTl1L2pOWlcwYldVaktQWGNiYmlwRTlnWnlDbVU0TTd4?=
 =?utf-8?B?QWFtTmh6VUs4a0lKUTMvYVplcERENy85bFAvckdDaHM1NzVBcS9aaFNZV1Ax?=
 =?utf-8?B?OTUwVStUQURhRGRGSUwxWFFMbXpwb09nSWVZZlIvTkN0SjFDc1ZuMWpKa3Fn?=
 =?utf-8?B?RlU0N2VweWh6RzhBbG9iNW1oMm93cTRZTVhsL3ZJT3R5UVU2MEdzNTZvYUdS?=
 =?utf-8?B?UUUwd1VjUEdFUTAyWTVJak00QUlNOUhhdXY5Zm5XenJMdjJYMEZmNGlWbyth?=
 =?utf-8?B?ZUZETlVVL3pOSTFncHVYWHNEUklxT3VpWEdMVld4VHNWT2ZINngwK2ExVVY2?=
 =?utf-8?B?dTZ5S2xYR0VoajVBTjFGNFR1L2txTDIzNEZZVGh1SDdqeFhWYW1SL2txRlN6?=
 =?utf-8?B?RC8zTHprWnkyNHY1blFMTWtoUXNaaUd2TzA5VUx4dDQ3Tk5aY2NJTUpQekxs?=
 =?utf-8?B?bWV5dWcybnU5VkJKSCtPN05uaWw3Tk1OK2lzK2xZQkV3TGJieldoSVZPZEtO?=
 =?utf-8?B?ZC90a05QQTVRRmx0ZjM3dG5kQmhQWE42YURHTzE5ZkJwRFJqWVNEZ0hldkF6?=
 =?utf-8?B?RjV6QU1jRXRqNTRhR1FsaTJiTkg5TDdIZS94b2NaODE2WkNPLzdIUXlSeGJs?=
 =?utf-8?B?a3RHbXU5N1BiQjdOZ0lXQnIyK1Q0YU84NThZRHo5NExGblpiZ3ZvVlQwWTNr?=
 =?utf-8?B?OEdTMzJRZ0tXTExkeUxqUXpvQ2NIREtRUXYrdy8rSkQyOWxBa1RGbkJpM0JT?=
 =?utf-8?B?MW14OXZMUHJiV2FidHh4VytFZXlRbXQxZDJFV2RxOVp3S05XdmRWQUFmV21l?=
 =?utf-8?B?NFRwNmJhWEs3cEdpWTlBRFdsRGh6M1pmdHdJd0dLa0VrNC9MdGNXaGVxU2R4?=
 =?utf-8?B?MSsrNGJ3bHpEVXB4YXF3OVQ2dEVsMmkrWjZQM0t6UzhaWWEzU2JhTzNKcXBa?=
 =?utf-8?B?OSthY3hGRkhGWUNub3JFWTFaaUY3WGlSbzNGVjVobDVvTDZLZ09paHNNYjFa?=
 =?utf-8?B?bTNDZWNEQUNONDA1SDhsMms1TTY5clJYYzJsdzZ6S3NWdmpDNlA4blhoVUZw?=
 =?utf-8?B?eE1qaW1nMjVKQVQya08yd2JpMXRtQnNmYmpYY1kzZkFkUnhseFR6ZXpoWExJ?=
 =?utf-8?B?MjMzYTNqUm02TVVYa3FjU2Q1S1IrL3JnMWVMT29kYXBycWlOaUJRcGRsb0Iz?=
 =?utf-8?B?dS9HdzlxZlJUVHNBcEo4enh4Qk1XWWlZbytZdU1Fc1VoMXY3R2IzZ2RzNWxn?=
 =?utf-8?B?eUhreHQyTXBPOFIrSTBtZm11QU9Ydk5NazNvODhkSFczQkVzZTBReFllN0FR?=
 =?utf-8?B?SXJ0dXd3NllzZG9PeU1mV0l4T1pIUjl6enVrTTdxQ3ZPMnJxdEJ4MWIraUZU?=
 =?utf-8?B?YXl5RE5qUytYVWE4REhLcTNmMWg4OGJEbEk2OHNmWjdwdG5aZnhyZ2xlUWp2?=
 =?utf-8?B?OEFWYkkwTUZJcTI0OWs5MlNDNHZmRlNiWlU0UzVSK3dIZzRjVGM0ZUVNd2dy?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036ad8f7-7d6f-4744-3abc-08dbeaa0bb25
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 14:47:05.8077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hXoEHp9A3c+xZIiTUcUfpcX4W792bkqz1PaJ1skanJXuu4yA4D6QklTi5F7rN6fSmURuroqe5pOeVM4hxN+4n8knLoOetLSb8uoKnbI1CKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7513
X-Proofpoint-ORIG-GUID: 3pyZsf5SxtfY8dqytgmB6KRO60zm68XC
X-Proofpoint-GUID: 3pyZsf5SxtfY8dqytgmB6KRO60zm68XC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_08,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1011 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311060001 definitions=main-2311210115
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBO
b3ZlbWJlciAyMSwgMjAyMyA5OjA1IFBNDQo+IFRvOiBQYWxsZXIsIEtpbSBTZWVyIDxLaW1TZWVy
LlBhbGxlckBhbmFsb2cuY29tPg0KPiBDYzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVs
Lm9yZz47IExhcnMtUGV0ZXIgQ2xhdXNlbg0KPiA8bGFyc0BtZXRhZm9vLmRlPjsgSGVubmVyaWNo
LCBNaWNoYWVsIDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPjsNCj4gUm9iIEhlcnJpbmcg
PHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyenlzenRvZi5r
b3psb3dza2krZHRAbGluYXJvLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9y
Zz47DQo+IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYyIDEvMl0gZHQtYmluZGluZ3M6IGlpbzogZnJlcXVlbmN5OiBhZGQgYWRtZm0yMDAwDQo+
IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiAyMS8xMS8yMDIzIDExOjAwLCBLaW0gU2VlciBQYWxs
ZXIgd3JvdGU6DQo+ID4gRHVhbCBtaWNyb3dhdmUgZG93biBjb252ZXJ0ZXIgbW9kdWxlIHdpdGgg
aW5wdXQgUkYgYW5kIExPIGZyZXF1ZW5jeQ0KPiA+IHJhbmdlcyBmcm9tIDAuNSB0byAzMiBHSHog
YW5kIGFuIG91dHB1dCBJRiBmcmVxdWVuY3kgcmFuZ2UgZnJvbSAwLjEgdG8NCj4gPiA4IEdIei4g
SXQgY29uc2lzdHMgb2YgYSBMTkEsIG1peGVyLCBJRiBmaWx0ZXIsIERTQSwgYW5kIElGIGFtcGxp
Zmllcg0KPiA+IGZvciBlYWNoIGRvd24gY29udmVyc2lvbiBwYXRoLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogS2ltIFNlZXIgUGFsbGVyIDxraW1zZWVyLnBhbGxlckBhbmFsb2cuY29tPg0KPiA+
IC0tLQ0KPiA+IFYxIC0+IFYyOiBSZW1vdmVkICd8JyBhZnRlciBkZXNjcmlwdGlvbi4gU3BlY2lm
aWVkIHRoZSBwaW5zIGNvbm5lY3RlZCB0bw0KPiA+ICAgICAgICAgICB0aGUgR1BJT3MuIEFkZGVk
IGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZS4gQ2hhbmdlZCBub2RlIG5hbWUgdG8NCj4gZ3Bp
by4NCj4gDQo+IFdoeT8gSXMgdGhpcyBhIEdQSU8/IFlvdXIgYmluZGluZ3MgdGl0bGUgc2F5IHRo
aXMgaXMgYSBjb252ZXJ0ZXIsIG5vdCBhDQo+IEdQSU8uDQoNCkkgbWlnaHQgaGF2ZSB1c2VkIGFu
IGluY29ycmVjdCBnZW5lcmljIG5hbWUsIGNvbnNpZGVyaW5nIHRoYXQgaXQgdXRpbGl6ZXMgR1BJ
T3MgDQpmb3IgY29udHJvbGxpbmcgYm90aCBtb2RlIGFuZCBhdHRlbnVhdGlvbi4gV2hhdCB3b3Vs
ZCBiZSB0aGUgYXBwcm9wcmlhdGUNCm5hbWUgdG8gdXNlIGluIHRoaXMgY29udGV4dD8NCg0KVGhh
bmtzLA0KS2ltDQoNCg==
