Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02787E86A4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344798AbjKJXj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344777AbjKJXjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:39:25 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3EF125;
        Fri, 10 Nov 2023 15:39:21 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AALkuEP012457;
        Fri, 10 Nov 2023 15:39:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=HYFls1LmEQMJ46YBG5eqofgRekugyKgJ0hYwHBGWT/E=;
 b=mGOdZcomyWnMEbnqiN2oEFbg6iSDsdst9p9rO5oNWVsmIeAKDrsO9JvfFX7uU+oXkJFa
 zAbkDS7Gi6BCZCUrx+LYjEAQ4ecj+EFXt2FGql0zT/d/XuidY1kQsQQO4+EbF+G1cu8Y
 chYcYkPLorMKNYOfkw1O6W6BLMG9ENz4jXaqJXPG6jIVK+pBlbXwBHEGvW7eC8Lass8X
 z1N6yFMdSzvTtpZ03A5oFe3O9Iumt6JlhtLz0pf2LLzBv4q6OxcpgX2t1RHPSibotjy6
 I7erG5ub1oNheoOPVvlkHp/Mow2zCS8qVBO2vE40ATWoWMZErJoB9IEKoiFsScoMVNNr tQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3u7w1q2t8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 15:39:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1699659557; bh=HYFls1LmEQMJ46YBG5eqofgRekugyKgJ0hYwHBGWT/E=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=lZyhc7+uXKFdQNkvZXzyU4m9yDeUikDlxxoTCxFYH2UmCUqVU+ds2uEbyV18ks499
         HLkdD3oHvEH91iwKqdWbCEv4cSbJiq5/n5H8QWkdVfegN/sp6jojMEdx0Wa0WDe7zR
         4uc6ddMsbJzYUvVDlrKHnhdRwVf4NA1jUGK7h2RDOuH37FMGm4dG6QlMm8E4gBY1Ze
         q2j8dBdwJTGJkclDADNnvPmhcthJkY+MmOoTThvcT3G1kR8s+qQeE1zoohFetOlUY3
         25U7LKnDxV/0ho3Ol8dn/Djn7mrx5LzQ5rxIiOp0ZggPIr6W7OsautOK7tpIVHoHAw
         lioQ1UIoVLGOQ==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5047B404B0;
        Fri, 10 Nov 2023 23:39:17 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1E2B4A00AA;
        Fri, 10 Nov 2023 23:39:17 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ww3JumQ3;
        dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E47BA400A2;
        Fri, 10 Nov 2023 23:39:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CM4WeBUOtRLQAZTW1a7d1ml5ejbllF1Y1Mig7B54EcoN36QJQmCxcAkb9K/8B4+0t4BDc5apmTRkx7H0fcfjyl9Aqazkbi+gJS/gx1NAFb20GqrrFydwRWWTnFBmcrGz0Qeoi3h4Z2Sk7Q+uRWzDnC3O53RNpx/aL4vccWx5xxf7FQBPKKjr3JrZ/jIMUX3MZyhTb4Hm4BhWkSUzcjdggrJ/nj9XUpx7+tnBsp3X0IJdKRBj3cZbFfM3bMZI9MIezg38Xvs4eLE8V8trASmUrlKkPF9hYM68APBui/GTOWty7acGTrlbzRGSFgn7BYqlvXVVDFpZX1eVAuv+NEwYOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYFls1LmEQMJ46YBG5eqofgRekugyKgJ0hYwHBGWT/E=;
 b=KHxbZFVcFFyCBWyRHq+i5lqvS215Ub8QcOAAQHCkRve5NICr6EXGcf7A3a3cj6NmAcuLAFJzFvyHPckeDhS8PfbnIrZ7of/i+MLV4q5QwzWFlmS7qsmAyVzObHZOB3Dk3D2z+4YAdAo3ZhG3ZD9efp8Ktt1WiDyQzuS0dh4Df542eESudDcXdABxO8xskergCm49dyipnyUofRJNMe5jxY//6fi23wPUhkPfF8vstrA2xFVcu1iosYUTxf5MSmSnCm1R23TZ2drvfHnNMXT/x1dbLWk8ut7fEJzsa0u6MV2gtuJufhQlr2nBoeKYkWsXL7s9niWQR2IuMXpUYpDF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYFls1LmEQMJ46YBG5eqofgRekugyKgJ0hYwHBGWT/E=;
 b=ww3JumQ3co+7rT6gsQJ+jN5hSsLdqARSszoPSm7BMFQvsRZtoKLXFaskwEnzYxTM4tUQQW7Zim6sldLL4nUB2Ncfc4J+b5CdrtyhTgH6ZN8EyNUNX8VNuRhLh1ZspgpF2inVsj9PqA1TIdjbWwI4ZwYyyj1TuPP9rq2g9Matw8s=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 23:39:12 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 23:39:11 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Piyush Mehta <piyush.mehta@amd.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git@amd.com" <git@amd.com>
Subject: Re: [PATCH] usb: dwc3: xilinx: improve error handling for PM APIs
Thread-Topic: [PATCH] usb: dwc3: xilinx: improve error handling for PM APIs
Thread-Index: AQHaEfz2PCHK7ZBtXUSxW0d9mtOpUbB0OfMA
Date:   Fri, 10 Nov 2023 23:39:11 +0000
Message-ID: <20231110233810.ojsvcg3tqmim3lzg@synopsys.com>
References: <20231108043441.2103940-1-piyush.mehta@amd.com>
In-Reply-To: <20231108043441.2103940-1-piyush.mehta@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|IA1PR12MB9064:EE_
x-ms-office365-filtering-correlation-id: 9388548c-5d95-4f38-fe7f-08dbe2463db2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tDzRRTzLSuxjb2jSA8B8JwK2ICddkFIGGrxcX56xsPpejysvBP/eLP0jddPz6g+MCcb0WUQ8L4KM1f4/RX1SByYSMCXMDrrdgnlPbMQjlZfwiiSNRXOZBzpuyY78ptT9D6XbRBOvbu5yEYyNh1gJCaYqaVsm0+nnLOcOrS0noB2CszyTtmW+k6vsiC0ym5t4xCBWNR2wHXA8z+WVqZL9eCocc0UXQJCUHxwqxwXcS57goznf40ENye9A5NS3eVPg29XAYyJfH+SH6YDNXyWK+4LypXY43iOEIHw+fIxdEirkE05iNdnxa6uSJNG2wQvxThi2ucA8gT7WQ/vFF7n3P57KIygU45SKnnzEQ3kQVmsI/rqpsenKQXD3fvyP/GUBblC07Egqq+pHHX33zGF+uwOsYISexAiPuTObs9ItdPzsGmU31gdmm7E/zibRHAAHgqODev3wkKFtQ467ti9TegDIaUK99Lmtx3p6jsZy36iIU1SEZZFTzRs6Ki8ZVOweZrQwHJyM1+nI7idJ2tFwJNl9z/q3P+/04tWl+6mcT1NhMvW+UGsTpPDu7uLlyJ0unrKfyvRo+jDorEYhh/2L/QW0XOFOjB/jwYoK/9RBOQkGlNdX9Stay0xEiOa5VKf8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(346002)(366004)(136003)(376002)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(5660300002)(66476007)(86362001)(2906002)(6916009)(64756008)(66946007)(316002)(54906003)(76116006)(4326008)(36756003)(38070700009)(8936002)(66556008)(8676002)(41300700001)(1076003)(6506007)(26005)(122000001)(71200400001)(83380400001)(478600001)(66446008)(2616005)(6512007)(38100700002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2VZdG9hSjNMQmNDVVkyRzBxL2o2UldmSmM3YldsTHVoWG1ZNWhreVZHNWp3?=
 =?utf-8?B?MjdzeVBXTDUrRjI3cVhhRkc1QjAvNzcyNnRZT1hxaWM2K2lHZVJSZHl1Ky9q?=
 =?utf-8?B?UElTTmF5MlFtSjhJQVpxOEluOG03TGM3a0RjWEMrT01QZ2ZpeFRRNWM0QTJj?=
 =?utf-8?B?cDNocW12V3FKNE9seEtKL2dFMTE2VWo1SVd6L2JyRjJ3ck9Odk1HOFgxbUs2?=
 =?utf-8?B?bDZBdlltTGxQVStWZTZUZ0pIWFI1eStnM2tQTXhPeEc0U2haYmJ5WGxaVUZ2?=
 =?utf-8?B?LzYrVGIzbXMxNDg4ejhmR2RlSktOc0pJUGgvV2xFNlp6anZTQzdPbXB4c3Ba?=
 =?utf-8?B?eTZLaURpTXZLVTE3QTdoL21tb0UrYkdkcTlsdWNSZ2Nrd2xSM2tNdlZmTFVl?=
 =?utf-8?B?TFh6WUZ2TUkvYktGOE1CM2NUdGtOOFFTY284VzhjcFNXVkx2YjhlYitybzIw?=
 =?utf-8?B?d3ViSEd1V0c2UCtaVWtKcU9WcElMazNSRldtZTArZW9zZ0t5STBRckplVlJM?=
 =?utf-8?B?U2VEWFJFYVY1ajUyeDlaRWErQnNWYTlyQU5DTk9LZ1VXcEgxeEtDZVA5Y3lU?=
 =?utf-8?B?bE1YenQ1Z3AzN0VCY3l5T3hUZHBSdTlFWFl2OG9oWEZPMUw2ZUFFLzZrSTZF?=
 =?utf-8?B?TC9uZHhJalNUZktSbFpaSjBnT3dhMGpkNHBnT0lFaVhzandQVzFEaWN0YTcz?=
 =?utf-8?B?Sngxd1VNRkV4VWFSSWt5TEo4YW1Bc0dDa3lMNWYzd0NzL216SEV6MmQ0WHY0?=
 =?utf-8?B?NDhJR3U2VVZiSmNPTDd0OVVjRGI1V3RvWVFTQlBzM0dLelpkNHNXbFBxVEU2?=
 =?utf-8?B?UmVnU0RKOW1IZjl3UHlwTlc5RlhXZUZOODc3eXNIOXhaYk5zbVlmTEhEdG96?=
 =?utf-8?B?ZWxCcWYwcW0yTnNIYytYMWJXamMyUG9Gb1lUYnhMVVk5N3c0SjFjRHlUT2ZS?=
 =?utf-8?B?cnpGVVh4cDFkcmRpa1hxSTNLaDRDaDlzWHNiQ2hJdVhWVFVoTkJNcjh6YjNF?=
 =?utf-8?B?a1NMUkNqRnY5Yk1vazhzNkx1WWt1bVpGL2JsTFI0OFdpSUowSmNqM09zV09C?=
 =?utf-8?B?UXE1KzFLN3pVV3h4UlRuNlUzTkZiZkNhN1RlV0J6YVZIRnpGYlFyQnRYQkdU?=
 =?utf-8?B?bU8zVGI1WEc5SDErUjBOWUNWcEkrbjQ4d3FLQitKUWZjbXlOYlNWdE5lRHNy?=
 =?utf-8?B?N1UxamVpTnZObWwrU2UrckRQTnNYU3RGdTZtMUJRWWcwZUhqTVJ5dUtzUkta?=
 =?utf-8?B?eVIwL2JSU0lTM1pPbW9jajh5b3FVSnRVeVRrYzR0MDFSRWJvT1UzZXBYLzl6?=
 =?utf-8?B?aVNvT2VrdUxEU2tObCs4SDYydXRqeURXajRtWE5lOUhiTFBTdWNZbVVDSFBI?=
 =?utf-8?B?blFEVWdkVk93ckduM051bEh1TlExMlI1OVhFaUJmdEdwN1E3cmU3M0Z2cTJk?=
 =?utf-8?B?U3BRd3h5aFVHR3IvNU92cjM0Z0plZ3BjY3BwYW84clpYYjdvSVZkQlU1NjNB?=
 =?utf-8?B?NGRuTG5hOThIb0plclY1SnlXaWF5M0Q2TmYxL2dGRnRIQzJkYVVUZVp5bHZY?=
 =?utf-8?B?MEwrQmFwdS9FcnZMak9xNlNHeTJCeWJTSkxCU2ZGSXVVZGRSQ3o3N3hhWG84?=
 =?utf-8?B?azcya0IyZER4eExpZXpNam5uSWE3NUpxdFlMR0hjVjNwVXdyRk5QcXpweXB0?=
 =?utf-8?B?YmVPVzZxN20zNVBwTnd0MFJHNEdOYjgvQkVGV0dUMVJJZmhoVEJMV3AwdU4z?=
 =?utf-8?B?WG9aZUYwMDUrN0w3SFhsUjN1eURzNFFiQytBaHR1ZnpNczVhRWhFNkkxNVY1?=
 =?utf-8?B?d1BzNG9jRzlNa1l1YzVYZkxnVGVEVTg2Y0tpQWwrWXl3Q01yNnFWU0luTnY2?=
 =?utf-8?B?SzZ3MVBBWEJiaURUU1NqMGNOSWhNS2x2dW8wb2hzVU9MTGZrMkRyY21VUUtj?=
 =?utf-8?B?eGZDSis5YWovWnoySW1xWEhFTjBnNUlzRHVjK0dWVHJiUUhnb1FVVjFlUXhM?=
 =?utf-8?B?eVhZN0tkU2xpRXBkY2p6aEcwdVZCVzRVUUgzNEd1ZHprNklqeWpKQ1lGZ2J5?=
 =?utf-8?B?WkxUZnlIZXlRSm5zUUxLSDVKZnN2bWNRcmcrWDZnSDd2Tk15WlFzWHZERmMr?=
 =?utf-8?B?RDluY0ZKYkxIWkUwNFZHSVpxR3VhVm53eTFtZ2IxTEhLdFFoeHZMUzVPT1FI?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E2E8985BC9C50449183184FCE99F704@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AKVs1HEFBaESxoRPC57v+oc17sVkznnevMqUzNJwukNm00spMV/d7PB2ucKCC0sthd0jy7mlyp3yOsc9Cy6TkH4UDtpYB9lXveRfB4Ci464pQAOkqOsPNDFvFsIQMvxgTOzD7RhA+z9uaV8gI4D5+1CvtGi0NAPrk99SZHR9vsifyBMFnjXLFHJK8iq+za8WRSPnpihM5r+p+96/9wuRt1yd5csOLbYHYI36ce1RpMUW/lo6VXgB8CujtVN0Cdhnf1JGsrWLo7ywGLmQZMBHZCyY47fKQbd44yzEXAd/dWoqGWI3oCsHx66XB9Fv2lWC+15WEITC6Q48SbubFdBA/Fx3Vn61Dvtj+6fvxb4JtvH7cJgI5jHFWYNweLbqLepHbSF5Wp4hHs/0OU6Jr2NRxSRTSQyiGs5Ye+ey4/tvYpFuPfMEkMcv32YaUAKi0aPP3KxI+Kx5WDJqnCffgqO/8OQ8aha1CJKKhOiYszHfFoeyOHXnDV2uinzWOoVy32zViWr88L/NwmDaaeZYilBcXH0XclaLWg6YTQAYqm1o1K0FyIOu1xeY6htHXYR1f+kvdLHXGLxZjaJcHUUxARLhoGTNKR7Dp6UBbthu+n7ogn/5dhJIzJ1mXAAYOUPA9VTwyXKRHQ+gwQ2fazqhm1iQronWebr2EoXPtRHNRKefmnMUemRDUE5qZrqq4SFSTWxuKIGa6sPo/3sQEwDuIkYa+vXZR06K+xVg0FatI4Nc97Z6ODRS0vGUj0lTrElG8FF4scivdlhVAllUkwMyojkDMkrVWPqXnAYCKIslvNDM53vfFu4mby/Ybyzt11hgXqnl/y6QeGutXm6FvoWbs4wsldJ3nhq+4MSgcLLDIHxGk2qn3DsMYWwujPoJGvnM4QLq
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9388548c-5d95-4f38-fe7f-08dbe2463db2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 23:39:11.3409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E5m++VOJ1Ddzn3YuIRmfgMPxC4IMGi2ZOhI36v+6PzeUCM9odP3B5RL463kF/amcPYl1zLarWIMP2SIYZ+TiAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064
X-Proofpoint-ORIG-GUID: ZfrcQ_WQh2jKrFyKuM0sjCajf9fkKOyL
X-Proofpoint-GUID: ZfrcQ_WQh2jKrFyKuM0sjCajf9fkKOyL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_21,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=502 clxscore=1011 phishscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311100196
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBOb3YgMDgsIDIwMjMsIFBpeXVzaCBNZWh0YSB3cm90ZToNCj4gSW1wcm92ZSBlcnJv
ciBoYW5kbGluZyBmb3IgUE0gQVBJcyBpbiB0aGUgZHdjM194bG54X3Byb2JlIGZ1bmN0aW9uIGJ5
DQo+IGludHJvZHVjaW5nIGRldm1fcG1fcnVudGltZV9lbmFibGUgYW5kIGVycm9yIGxhYmVsLiBS
ZW1vdmVkIHVubmVjZXNzYXJ5DQo+IEFQSSBwbV9ydW50aW1lX2Rpc2FibGUgY2FsbCBpbiBkd2Mz
X3hsbnhfcmVtb3ZlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGl5dXNoIE1laHRhIDxwaXl1c2gu
bWVodGFAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2R3YzMteGlsaW54LmMg
fCAxMCArKysrKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy14aWxp
bnguYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYw0KPiBpbmRleCA1YjdlOTJmNDc2
ZGUuLjljZjI2ZTlhMWMzZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLXhp
bGlueC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYw0KPiBAQCAtMjk0
LDEwICsyOTQsMTUgQEAgc3RhdGljIGludCBkd2MzX3hsbnhfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCj4gIA0KPiAgCXBtX3J1bnRpbWVfc2V0X2FjdGl2ZShkZXYpOw0KPiAg
CXBtX3J1bnRpbWVfZW5hYmxlKGRldik7DQo+ICsJcmV0ID0gZGV2bV9wbV9ydW50aW1lX2VuYWJs
ZShkZXYpOw0KDQpZb3UganVzdCBkaWQgcG1fcnVudGltZV9lbmFibGUoKSByaWdodCBhYm92ZSwg
d2h5DQpkZXZtX3BtX3J1bnRpbWVfZW5hYmxlKCkgYWdhaW4/DQoNCj4gKwlpZiAocmV0IDwgMCkN
Cj4gKwkJZ290byBlcnJfcG1fc2V0X3N1c3BlbmRlZDsNCj4gKw0KPiAgCXBtX3N1c3BlbmRfaWdu
b3JlX2NoaWxkcmVuKGRldiwgZmFsc2UpOw0KPiAtCXBtX3J1bnRpbWVfZ2V0X3N5bmMoZGV2KTsN
Cj4gKwlyZXR1cm4gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldChkZXYpOw0KPiAgDQo+IC0JcmV0
dXJuIDA7DQo+ICtlcnJfcG1fc2V0X3N1c3BlbmRlZDoNCj4gKwlwbV9ydW50aW1lX3NldF9zdXNw
ZW5kZWQoZGV2KTsNCg0KVGhpcyBkb2Vzbid0IGxvb2sgcmlnaHQuIHdoeSBzZXQgc3RhdHVzIHN1
c3BlbmRlZCBoZXJlPw0KDQpCUiwNClRoaW5oDQoNCj4gIA0KPiAgZXJyX2Nsa19wdXQ6DQo+ICAJ
Y2xrX2J1bGtfZGlzYWJsZV91bnByZXBhcmUocHJpdl9kYXRhLT5udW1fY2xvY2tzLCBwcml2X2Rh
dGEtPmNsa3MpOw0KPiBAQCAtMzE1LDcgKzMyMCw2IEBAIHN0YXRpYyB2b2lkIGR3YzNfeGxueF9y
ZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAljbGtfYnVsa19kaXNhYmxl
X3VucHJlcGFyZShwcml2X2RhdGEtPm51bV9jbG9ja3MsIHByaXZfZGF0YS0+Y2xrcyk7DQo+ICAJ
cHJpdl9kYXRhLT5udW1fY2xvY2tzID0gMDsNCj4gIA0KPiAtCXBtX3J1bnRpbWVfZGlzYWJsZShk
ZXYpOw0KPiAgCXBtX3J1bnRpbWVfcHV0X25vaWRsZShkZXYpOw0KPiAgCXBtX3J1bnRpbWVfc2V0
X3N1c3BlbmRlZChkZXYpOw0KPiAgfQ0KPiAtLSANCj4gMi4yNS4xDQo+IA==
