Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD1A7D18FD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjJTWTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJTWTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:19:13 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8505AD5B;
        Fri, 20 Oct 2023 15:19:08 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KLXk4p001073;
        Fri, 20 Oct 2023 15:18:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=pGqLMDXP6gAN4y325UOF4C4Zc7Cl7+6iWaEyek6aIhI=;
 b=WFL8Er/kdU1AYU64SqdYNlrR0eLWMGSWbNCaD52OsocRPzvJniuvQKmu3PvhvvvaYZ8Z
 O8sKCtLBn1tQYBLWdVxCFgvsv3rSBL8PWicZCmf2LRANuqchSJBjNJ0vCxR0Ewoe6NKZ
 Rbe8vN4/f8kOP7qdWJ+Urs6SiKlrLOITolb2sqfUxIDog90K+OhPXdYyuwV1TfVfeF2o
 jYNL19v5Ch9uyqwRy41RwRLZnjubTlTZf/VCDOM0sULRpRo46H7LHsIKVwq6yiyOVuKF
 E6MTldjiErNnlTgyZIBXkbc8jTTFlBpHuN392IDT/x4SSsk+h6lcrgJJ0IKWw6Gh5EIa 9Q== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3tubw3kssa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 15:18:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1697840324; bh=pGqLMDXP6gAN4y325UOF4C4Zc7Cl7+6iWaEyek6aIhI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=EMELR2M1r4T4a649kHERS16ZhzMRJC6TMzaOhJmiImTu4MyQ52nkhNWVagC+noJbH
         pyp9SjE3ERsNlqHvoqsYQ+aHHGKEAkvevMGSm4V0Xku2ZW0mR4qRicfrs7eDgjWfy5
         A6pTJqlT238uqR/Y33SUNpw1piyXb4l1Cffg1VRyiXseg/uF4yuZiQme/1r7f1uqnA
         iWfD9MgMZJa5UJQl1k6v0WepOVMi9Tdj8FXE/FSrO+gph0WP1IYeOOqW457WThvXyc
         2H3X2A7HTTkzH1Me8hDcoDutmf2Qv3TeM77/OqPZh0zGkUAZAMHMjByG1QkLL5crsU
         jJOhbnEap2Ybg==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B4A4F40354;
        Fri, 20 Oct 2023 22:18:44 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id E048FA0077;
        Fri, 20 Oct 2023 22:18:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Oz0CliGY;
        dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 387644045F;
        Fri, 20 Oct 2023 22:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0u9nq0Qcf6pqnhcc9QvKDWis4E4khTtMMwsRjGI+V2yHtf/y9vQY/9C0PVs1kJd0h+hPvggJ4G3ehyR6cibGX2uEIHXlt9M3bcfJ0gsgP/AOr9WUh250bBfxFxvIQnM57JjDlwGm67eRr7uNNxGw7I1nxu4HvoItIFBZu4GO0Fo+4wI/qcwnieZXL37TrTEvI8ihwEVz8BOLEGfl6zmNti4Zok2C4AAjLv0Z0ofid4ZcOsEr4iNKO0MIkDR92dhpWGQAWyPWRX73/WT2oeneADYEtPte0xaphh3SjcLUoUZngmCYy4lFmRxrGoSAcbvrv5mjg8gqx27sR0mkuBPdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGqLMDXP6gAN4y325UOF4C4Zc7Cl7+6iWaEyek6aIhI=;
 b=G0qxu8RMHwRnVqmRAXM+XbbbZnpIB7PfNBhjbIczJTEA8yp9pVDVj40OMyXI/hoRymkkFTJpkbLQNIIu2bWzULItIJvy1im7bUmwHepNiuYiaTc25X5dyWN3wYhMORv5EljVHejusg0i/LVxeMBYbsDNuZ9WSI995q4TbYg6GDx4POs4UqxvWYGRGfIsBJkLQOz05WX8r7p7lNN7OQr3JkYmNhIJLajc8sRHc3vqhHqgRkzo9t+sUYWPjvO8wxkUxc5ALNpgdYUThPli0e3mGxOTkC1ZLdMKGcn2876/WQi8A0yEdKUMR8OoiY5K/7luLncfJSstggw0i6k0ssr4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGqLMDXP6gAN4y325UOF4C4Zc7Cl7+6iWaEyek6aIhI=;
 b=Oz0CliGY/9v+fSgaVzpKUfR/fYBCLnhvkYlFcqbfnZirbxy/ilg54ppeFxGl6CyuP++wRGYz876KMuKLCIxhXC4xB22sTieDzkUXO0jv0jMwyC8Ts6Mphnady834fz29DmYLY8edLeVQZF6wHiNUWfe4rQ5o/4dQWinJMKU25jM=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by IA1PR12MB9029.namprd12.prod.outlook.com (2603:10b6:208:3f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 22:18:38 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b63e:67e6:b5fe:a8cb]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b63e:67e6:b5fe:a8cb%3]) with mapi id 15.20.6907.021; Fri, 20 Oct 2023
 22:18:38 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Subject: Re: [PATCH 04/12] usb: dwc3: Expose core driver as library
Thread-Topic: [PATCH 04/12] usb: dwc3: Expose core driver as library
Thread-Index: AQHaAKend6IYghdkMEu6jPk8ywZwX7BTRU+A
Date:   Fri, 20 Oct 2023 22:18:37 +0000
Message-ID: <20231020221811.pvm7m4ilntp4owvv@synopsys.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
 <20231016-dwc3-refactor-v1-4-ab4a84165470@quicinc.com>
In-Reply-To: <20231016-dwc3-refactor-v1-4-ab4a84165470@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|IA1PR12MB9029:EE_
x-ms-office365-filtering-correlation-id: 4d38efe8-061f-45b1-2188-08dbd1ba8216
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NlVPW/65M4VqBvpDxG4XApW6Tf/kYtAexAr7BS6DJVyEE1frPWISaSjpFrGmlhBA+ru+jNlY4aW+4D/w0DIn8gYeQnMBE6DWS2A/ccCO9YAq6TgT4RQRzBc0q7Q1/V0VBkA+iJx8VHmFMDtyWS9JNbAcS11y8SEL1idhlNiWvVlmHw361W9VuVt5+mL9jJ+5/5Z25XcNypOxIwdncZjNLdGHrxlsA5aC3GfJqHE/k7CfjFFNl70GiXzAQ6W1p49cAUmlgIWE8vf7Ix708S6R8Rg+qHJktvfL4Qw5hZNcJGYF4WC47+qMXzLutE8Xm1kWKciSUWGfKzNlp+9JUPN/11bEOzM8ZP/rSrQbL6YCufvjMKeusZ2bqvIULGn8nwtYVaDwEvXFkc9mQSJaIDvJwOLiex8XcPSAga41ALk1xiMk3rZvmUhSQzlUknwKwwpzFAiCdHYcedJO9xA/BKaQc+bsmwTgvHmEslyWPp5JeEQuvkQITkZKBV8AnBu5NQ1m1M0oIVXFN05i+puyPldLUhjDI3yBNKXnNV5ta210GFEZWcVtEYFTtoXive3kWP98Uf+kctxa3u9m+UxaAE3CoGibRxvMoTmZgyBqpJrUo0rXq33hZeBr/r/5+GvfD0tz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(38070700009)(4326008)(38100700002)(8676002)(478600001)(71200400001)(7416002)(316002)(76116006)(66946007)(6486002)(64756008)(6916009)(66476007)(30864003)(5660300002)(6506007)(54906003)(66556008)(41300700001)(8936002)(6512007)(66446008)(2906002)(86362001)(26005)(122000001)(36756003)(1076003)(83380400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXQ1c3N1RGxVMWhxNTdmSjFUTmJoa2tYc2k3MmpuWFNPTVFoYWJGc2drNmR5?=
 =?utf-8?B?cmQ2SEJldmZQZG1EWjFmYlN5UzJtMllZSi9IS0J5Z1ZhSWszVDZYZ3lueVhq?=
 =?utf-8?B?WmxWZWkrNlFITzUrQmlDc2FMdW95RjRsT1ZGcUxEbi9YK0pQZGdFWldwM0xJ?=
 =?utf-8?B?OVduMFQ0WXhMRG5zdSt1THNGZkZ5QkJlMjFVZ0F0eWNTSkFFak9PcVQyVm9L?=
 =?utf-8?B?Qnc1MTFNbFFIaS9jeWNqL1ZjQThzMWdCMDZFdFJSbW1oU1pnRHhPS3FSVmpr?=
 =?utf-8?B?bkxvWE5LczJxcVhkSW00blIxTDBjNlBNMUF6emNQUWZTTFhyZHpxK1BnVUhR?=
 =?utf-8?B?VjA5ajl5WWVKSXUvYTNTeHd3NFI4eXJqRVVDU0w3d3doaERTaE13eFJGZ0tl?=
 =?utf-8?B?Z1I5Z1VRajNsWVA1NldjRHVzUEF6SGtiNEhMNGpwL1Bzc1Jya1BIMTBWY1RM?=
 =?utf-8?B?SnVkTVovUkhCalF2Uk15dWtUbzNYTmJFdW1seEVUV3k5bjZEbzdHNU5GaWt6?=
 =?utf-8?B?YmdWYmZ3OURVVXpKRkhCdEdmSmNMNUJMeXNxM0JMMlkrOU1lR3k0RjhVWE15?=
 =?utf-8?B?bXBvdERRbTZ5SHdrRTRtSnlkQllhV0E2MkdjUFVoS3lVeFZxRzVtcFNZUjVI?=
 =?utf-8?B?Z1daM25QTWQ3L1dWeTJrVWNrZ1pLZk5ZSDNVZjI0RFFDQmU1MzRrUEwyT3Vy?=
 =?utf-8?B?czBMeHh3V2lTcnRDZ3MxSmxDWjlpWjhsei90RHRQM0JHbk1xdnVPMmdLdERk?=
 =?utf-8?B?KzhRejBmRTBzK3k1QThpdnNjWUkvOGQyQnJKWEkybWtVTzRxNG9PTGZrR0cr?=
 =?utf-8?B?VWQydlpHdlJzTW5CM0hudkx5RkJUZjhUWksvNDBnZE0vNTRHNWEwR011Nkg2?=
 =?utf-8?B?Z1ZEc3VnQnh1aGgzcUpEd25sMzZ4RERYUCtseUVFM2hPOXdzV0VOQXZBRk9K?=
 =?utf-8?B?TFhjT1Y4Y1c4UzV5NWdlbTdCT1c2cVo1QmZBRkd5ZjNnSEl0VWg5TTlyaXhh?=
 =?utf-8?B?NnNkdGJwM2htUkV2K1NCeXNJR3RZK2c1Qmt2ZGxkRzJuYjJWUXc4clh5bnNP?=
 =?utf-8?B?dkZWMHdEQk5tSHR2LzZEUjIrT0lLaFNnYlZ4Y09YeWViUWlRdmhXdnJjMEhI?=
 =?utf-8?B?UC95M21sWkdOMTZpUlcrYjd0ZGhIaW5UMFZpVFhKQXgzbEpidXRpNUgxQ09q?=
 =?utf-8?B?RFhCZk9wdFd6VXk2NHRCZE5NT2VNb0pQb3N5SmZxS3Nnd2VycERVaDNJRnBx?=
 =?utf-8?B?OTYrVE5HdS84WTBOMjF1cEdnUmFsa2xNWXl5Rk9RZmNlMWhIZ0QrdHdsVkpZ?=
 =?utf-8?B?ZFdGMVI0Q0lMOTNZdHdTRkE2K1FocXBCSjZudHlsUjJpVFdBbXZDM1hWeEVy?=
 =?utf-8?B?VktyaGNlTG1OcXV6aEVJVkZVSFNxU2JuTXZDM05TM2psSGcvYU5jSkNTejgr?=
 =?utf-8?B?dER6QkdGRjBSZ3dDQm9kSFNobS96bGZVbmx3ZUVweGJSMVJhNG9lV1JQUzNa?=
 =?utf-8?B?ak55elBaUUt0WHNpOU9tcWlOQlorRXltejREUk4ydmNobEp0KzBLRERqNFdh?=
 =?utf-8?B?QkpIa2xhUWxEQ1QwclZBZlozOG0rSFFqYzJ5L3Qydmo5d21mcGo4bHJ5c0ov?=
 =?utf-8?B?amNOVTJEUUp6NDBWRXNNQ2VaMUZPZWVuSkVTV2tuU1YxditUZTN0MEZBaGFl?=
 =?utf-8?B?ZVVNZk9QQ25zMHJFR3VFc3h1KzIyVE5BQlloVExyRFp2U0UyNHRwV0pzMWwz?=
 =?utf-8?B?OHF3dkdyTjRjN3JramE0R01nYWRDNEpYMkRXQkRFQ25NWmk5ZElrSnpmcjVi?=
 =?utf-8?B?YmFLY2hSeDd2djJWSlJubjFwVlpGREloZ0FtdUwyc3NlSDkyOUUrTnZIaHZD?=
 =?utf-8?B?N0kzeXRQWE40MG9uNlhyQVRJcmQ4WkRacEtoRU1PZTI5N1l3RG85eTIzUDZ5?=
 =?utf-8?B?Lzlnby9sL1drZG0yamxoK3JrRUxIQUNHY3F4cWpydkJiamlxbzIrMzYrbDRj?=
 =?utf-8?B?VGQ1VklMSnFuSnhxdHFPaEszMkZaQ25MS2NtUEJaR1czdDBUREFaV1FuTnZa?=
 =?utf-8?B?Mmhna2E5bTBJMmI1cFJQTEY5VzlXOTNMRHhlc0JrNTl2Q094TW45aSsrSWJM?=
 =?utf-8?Q?/jxpHJ86LHzX/Cc/fK8pa1UIr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F35A447964246D41B7920144C2BFB0DA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TmkxdE1aK0RCSnpxeEtsQkdGbythNFUveGZhdTZWMEp0MlpzenhTQXVRYnI2?=
 =?utf-8?B?a1AyRUlDaTk4eXE2Y2RxZ1lFNEUrcUsvSyt2SnoyR3RxQjF0ZDBLUmpONVVm?=
 =?utf-8?B?ZkRYbklvemU4N01VcjNtOTBNV05oVmxkUDdHWEpYWm5ua2tESnpxQVFGYkRp?=
 =?utf-8?B?emFZbVRQeHNEZC82UEpIMTBRTXZTQVlJVTZNM1dFNXRYZWxieEc0VFlHSXVF?=
 =?utf-8?B?ZW8zNjhVMDNxa1RYd2RwSGtselpwbDhMN1VrSXIyREFxVjdEc1RBV1c1ZENv?=
 =?utf-8?B?Qm43TlhFeFhjaUlPeTkyUmNsOStNd3pzMlQwZzlGaGk3NFdSekdYWUNXa2NQ?=
 =?utf-8?B?UzRuZW1VL0k2TENPTWNPS0cyTU96cXhuU2hmc2ZDc3FHUGhMYTZVNVBHTHg3?=
 =?utf-8?B?R0EzL2ZSQjhvNnZKRmduU0tpTDJHeG8wZWZPSE9VcCt6TENhSE1YRXNWa1Aw?=
 =?utf-8?B?UDcwTUVGeGx6RlIwM2taYmY1VnBiQnpGWU04SG9KVDZNTzFBRi9kUFA3bHdm?=
 =?utf-8?B?b3FkeUlMZkJZN1hLL2pSTDF0dHkxZHhsZnlDMjR6aUlXRjhYSjRQc1JudEta?=
 =?utf-8?B?dmZNMTZmQm1KQUxHL1JJY2QzbGtSUlM2cDNmdk81WnRCbVpZYUxvSzVRSW83?=
 =?utf-8?B?UGpXR1AwY3BzODZndDNiODY3VUhlNmRrdThZbjNoa3RzYWR1YldWQ1A2U3BQ?=
 =?utf-8?B?R1BlLzlCdFREY3o1WWJ0eS9DaFZNNHJzWEdnK25ka1ovSkxZbFNQWlpaTnpH?=
 =?utf-8?B?VmhqSDdqejdlYkUrWU9ZTG9MMUxvWldIbThzZDN3ZWc2MjRyS3R5TzVna3p5?=
 =?utf-8?B?QklZMUpaZHd6dVdYTy9hRko2WXp1UU9TWXFKd2V0clVZWU56cnJPY0FKTzBG?=
 =?utf-8?B?Q2tmTGN2TEgyZEUzeUdBbmZYajNLa2VvUzNXNndMYlJWOVNrVWFXYmFzQWl2?=
 =?utf-8?B?SmErYUhtRHgybTJJQW5WUjBnY2hqYUNTdUNFUXJyb3JUY0phQTExdjRodHZw?=
 =?utf-8?B?eDMvWDlSNW1WbkJkQzlDK0hBWHdDczhTQUtGZHJFbmFkblorU3dDWnhhVzlQ?=
 =?utf-8?B?MU1iUU1YV1pMT0N3ODA5Q3ErR2lqWnczaUtjQ2NtbUFLUEJPZG9RUWUwVXNU?=
 =?utf-8?B?am9nTVByY0Z4em9kM2t1SVlNVXE0dkc2RWZqdUlvQm1HcVdtc0Fuc0llOGx6?=
 =?utf-8?B?eW1FN1NWRGhVSkJhZUxnOTdhNGcva2dCa3FMVksvTTRKQ3I0eGNxYUtKMmhq?=
 =?utf-8?B?d0pPSjExRWt5UWM5S0QxSWtjeTlDcEZxSHh6K3lTak5QNHBNaHRWVzBza3BT?=
 =?utf-8?Q?QSnKw/+vEC7EK1966M4xbldUTc/euRSmOP?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d38efe8-061f-45b1-2188-08dbd1ba8216
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 22:18:37.9153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Egdt/mowZQcDCa86nJvVC6E1pYkanV1zecw5gJxFVfHuQvkedsCYiGJiuwTAxdrPQ8Il5l2HG/WS5Y4bOZ1dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9029
X-Proofpoint-GUID: 7xjTjrfwOlI6AAS3RLoFptryA1jBWkN-
X-Proofpoint-ORIG-GUID: 7xjTjrfwOlI6AAS3RLoFptryA1jBWkN-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=908 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310200190
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBPY3QgMTYsIDIwMjMsIEJqb3JuIEFuZGVyc3NvbiB3cm90ZToNCj4gVGhlIERXQzMg
SVAgYmxvY2sgaXMgaGFuZGxlZCBieSB0aHJlZSBkaXN0aW5jdCBkZXZpY2UgZHJpdmVyczogWEhD
SSwNCj4gRFdDMyBjb3JlIGFuZCBhIHBsYXRmb3JtIHNwZWNpZmljIChvcHRpb25hbCkgRFdDMyBn
bHVlIGRyaXZlci4NCj4gDQo+IFRoaXMgaGFzIHJlc3VsdGVkIGluLCBhdCBsZWFzdCBpbiB0aGUg
Y2FzZSBvZiB0aGUgUXVhbGNvbW0gZ2x1ZSwgdGhlDQo+IHByZXNlbmNlIG9mIGEgbnVtYmVyIG9m
IGxheWVyaW5nIHZpb2xhdGlvbnMsIHdoZXJlIHRoZSBnbHVlIGNvZGUgZWl0aGVyDQo+IGNhbid0
IGhhbmRsZSwgb3IgaGFzIHRvIHdvcmsgYXJvdW5kLCB0aGUgZmFjdCB0aGF0IGNvcmUgbWlnaHQg
bm90IHByb2JlDQo+IGRldGVybWluaXN0aWNhbGx5Lg0KPiANCj4gQW4gZXhhbXBsZSBvZiB0aGlz
IGlzIHRoYXQgdGhlIHN1c3BlbmQgcGF0aCBzaG91bGQgb3BlcmF0ZSBzbGlnaHRseQ0KPiBkaWZm
ZXJlbnQgZGVwZW5kaW5nIG9uIHRoZSBkZXZpY2Ugb3BlcmF0aW5nIGluIGhvc3Qgb3IgcGVyaXBo
ZXJhbCBtb2RlLA0KPiBhbmQgdGhlIG9ubHkgd2F5IHRvIGRldGVybWluZSB0aGUgb3BlcmF0aW5n
IHN0YXRlIGlzIHRvIHBlZWsgaW50byB0aGUNCj4gY29yZSdzIGRydmRhdGEuDQo+IA0KPiBUaGUg
UXVhbGNvbW0gZ2x1ZSBkcml2ZXIgaXMgZXhwZWN0ZWQgdG8gbWFrZSB1cGRhdGVzIGluIHRoZSBx
c2NyYXRjaA0KPiByZWdpc3RlciByZWdpb24gKHRoZSAiZ2x1ZSIgcmVnaW9uKSBkdXJpbmcgcm9s
ZSBzd2l0Y2ggZXZlbnRzLCBidXQgd2l0aA0KPiB0aGUgZ2x1ZSBhbmQgY29yZSBzcGxpdCB1c2lu
ZyB0aGUgZHJpdmVyIG1vZGVsLCB0aGVyZSBpcyBubyByZWFzb25hYmxlDQo+IHdheSB0byBpbnRy
b2R1Y2UgbGlzdGVuZXJzIGZvciBtb2RlIGNoYW5nZXMuDQo+IA0KPiBTcGxpdCB0aGUgZHdjMyBj
b3JlIHBsYXRmcm9tX2RyaXZlciBjYWxsYmFja3MgYW5kIHRoZWlyIGltcGxlbWVudGF0aW9uDQo+
IGFuZCBleHBvcnQgdGhlIGltcGxlbWVudGF0aW9uLCB0byBtYWtlIGl0IHBvc3NpYmxlIHRvIGRl
dGVybWluaXN0aWNhbGx5DQo+IGluc3RhbnRpYXRlIHRoZSBkd2MzIGNvcmUgYXMgcGFydCBvZiB0
aGUgZHdjMyBnbHVlIGRyaXZlcnMgYW5kIHRvDQo+IGFsbG93IGZsYXR0ZW5pbmcgb2YgdGhlIERl
dmljZVRyZWUgcmVwcmVzZW50YXRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCam9ybiBBbmRl
cnNzb24gPHF1aWNfYmpvcmFuZGVAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmMgfCAxMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCB8ICAxMCArKysrDQo+ICAyIGZp
bGVzIGNoYW5nZWQsIDEwMCBpbnNlcnRpb25zKCspLCA0NCBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5jDQo+IGluZGV4IGQyNTQ5MDk2NWIyNy4uNzFlMzc2YmViYjE2IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0K
PiBAQCAtMTg3Niw3ICsxODc2LDcgQEAgc3RhdGljIGludCBkd2MzX2dldF9jbG9ja3Moc3RydWN0
IGR3YzMgKmR3YykNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCBkd2Mz
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICtzdHJ1Y3QgZHdjMyAqZHdj
M19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgew0KPiAgCXN0cnVjdCBk
ZXZpY2UJCSpkZXYgPSAmcGRldi0+ZGV2Ow0KPiAgCXN0cnVjdCByZXNvdXJjZQkJKnJlcywgZHdj
X3JlczsNCj4gQEAgLTE4ODYsMTQgKzE4ODYsMTQgQEAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICANCj4gIAlkd2MgPSBkZXZtX2t6YWxsb2Mo
ZGV2LCBzaXplb2YoKmR3YyksIEdGUF9LRVJORUwpOw0KPiAgCWlmICghZHdjKQ0KPiAtCQlyZXR1
cm4gLUVOT01FTTsNCj4gKwkJcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7DQo+ICANCj4gIAlkd2Mt
PmRldiA9IGRldjsNCj4gIA0KPiAgCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJ
T1JFU09VUkNFX01FTSwgMCk7DQo+ICAJaWYgKCFyZXMpIHsNCj4gIAkJZGV2X2VycihkZXYsICJt
aXNzaW5nIG1lbW9yeSByZXNvdXJjZVxuIik7DQo+IC0JCXJldHVybiAtRU5PREVWOw0KPiArCQly
ZXR1cm4gRVJSX1BUUigtRU5PREVWKTsNCj4gIAl9DQo+ICANCj4gIAlkd2MtPnhoY2lfcmVzb3Vy
Y2VzWzBdLnN0YXJ0ID0gcmVzLT5zdGFydDsNCj4gQEAgLTE5MjIsNyArMTkyMiw3IEBAIHN0YXRp
YyBpbnQgZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgDQo+ICAJ
cmVncyA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsICZkd2NfcmVzKTsNCj4gIAlpZiAoSVNf
RVJSKHJlZ3MpKQ0KPiAtCQlyZXR1cm4gUFRSX0VSUihyZWdzKTsNCj4gKwkJcmV0dXJuIEVSUl9D
QVNUKHJlZ3MpOw0KPiAgDQo+ICAJZHdjLT5yZWdzCT0gcmVnczsNCj4gIAlkd2MtPnJlZ3Nfc2l6
ZQk9IHJlc291cmNlX3NpemUoJmR3Y19yZXMpOw0KPiBAQCAtMTk1Myw3ICsxOTUzLDYgQEAgc3Rh
dGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCWdv
dG8gZXJyX2Rpc2FibGVfY2xrczsNCj4gIAl9DQo+ICANCj4gLQlwbGF0Zm9ybV9zZXRfZHJ2ZGF0
YShwZGV2LCBkd2MpOw0KPiAgCWR3YzNfY2FjaGVfaHdwYXJhbXMoZHdjKTsNCj4gIA0KPiAgCWlm
ICghZHdjLT5zeXNkZXZfaXNfcGFyZW50ICYmDQo+IEBAIC0yMDA2LDcgKzIwMDUsNyBAQCBzdGF0
aWMgaW50IGR3YzNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIA0KPiAg
CXBtX3J1bnRpbWVfcHV0KGRldik7DQo+ICANCj4gLQlyZXR1cm4gMDsNCj4gKwlyZXR1cm4gZHdj
Ow0KPiAgDQo+ICBlcnJfZXhpdF9kZWJ1Z2ZzOg0KPiAgCWR3YzNfZGVidWdmc19leGl0KGR3Yyk7
DQo+IEBAIC0yMDMwLDE0ICsyMDI5LDI2IEBAIHN0YXRpYyBpbnQgZHdjM19wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCWlmIChkd2MtPnVzYl9wc3kpDQo+ICAJCXBvd2Vy
X3N1cHBseV9wdXQoZHdjLT51c2JfcHN5KTsNCj4gIA0KPiAtCXJldHVybiByZXQ7DQo+ICsJcmV0
dXJuIEVSUl9QVFIocmV0KTsNCj4gIH0NCj4gK0VYUE9SVF9TWU1CT0xfR1BMKGR3YzNfcHJvYmUp
Ow0KPiAgDQo+IC1zdGF0aWMgdm9pZCBkd2MzX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPiArc3RhdGljIGludCBkd2MzX3BsYXRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCj4gIHsNCj4gLQlzdHJ1Y3QgZHdjMwkqZHdjID0gcGxhdGZvcm1fZ2V0X2Ry
dmRhdGEocGRldik7DQo+ICsJc3RydWN0IGR3YzMgKmR3YzsNCj4gKw0KPiArCWR3YyA9IGR3YzNf
cHJvYmUocGRldik7DQo+ICsJaWYgKElTX0VSUihkd2MpKQ0KPiArCQlyZXR1cm4gUFRSX0VSUihk
d2MpOw0KPiArDQo+ICsJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgZHdjKTsNCj4gKw0KPiAr
CXJldHVybiAwOw0KPiArfQ0KPiAgDQo+IC0JcG1fcnVudGltZV9nZXRfc3luYygmcGRldi0+ZGV2
KTsNCj4gK3ZvaWQgZHdjM19yZW1vdmUoc3RydWN0IGR3YzMgKmR3YykNCj4gK3sNCj4gKwlwbV9y
dW50aW1lX2dldF9zeW5jKGR3Yy0+ZGV2KTsNCj4gIA0KPiAgCWR3YzNfY29yZV9leGl0X21vZGUo
ZHdjKTsNCj4gIAlkd2MzX2RlYnVnZnNfZXhpdChkd2MpOw0KPiBAQCAtMjA0NSwyMiArMjA1Niwy
OCBAQCBzdGF0aWMgdm9pZCBkd2MzX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiAgCWR3YzNfY29yZV9leGl0KGR3Yyk7DQo+ICAJZHdjM191bHBpX2V4aXQoZHdjKTsNCj4g
IA0KPiAtCXBtX3J1bnRpbWVfYWxsb3coJnBkZXYtPmRldik7DQo+IC0JcG1fcnVudGltZV9kaXNh
YmxlKCZwZGV2LT5kZXYpOw0KPiAtCXBtX3J1bnRpbWVfZG9udF91c2VfYXV0b3N1c3BlbmQoJnBk
ZXYtPmRldik7DQo+IC0JcG1fcnVudGltZV9wdXRfbm9pZGxlKCZwZGV2LT5kZXYpOw0KPiArCXBt
X3J1bnRpbWVfYWxsb3coZHdjLT5kZXYpOw0KPiArCXBtX3J1bnRpbWVfZGlzYWJsZShkd2MtPmRl
dik7DQo+ICsJcG1fcnVudGltZV9kb250X3VzZV9hdXRvc3VzcGVuZChkd2MtPmRldik7DQo+ICsJ
cG1fcnVudGltZV9wdXRfbm9pZGxlKGR3Yy0+ZGV2KTsNCj4gIAkvKg0KPiAgCSAqIEhBQ0s6IENs
ZWFyIHRoZSBkcml2ZXIgZGF0YSwgd2hpY2ggaXMgY3VycmVudGx5IGFjY2Vzc2VkIGJ5IHBhcmVu
dA0KPiAgCSAqIGdsdWUgZHJpdmVycywgYmVmb3JlIGFsbG93aW5nIHRoZSBwYXJlbnQgdG8gc3Vz
cGVuZC4NCj4gIAkgKi8NCj4gLQlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBOVUxMKTsNCj4g
LQlwbV9ydW50aW1lX3NldF9zdXNwZW5kZWQoJnBkZXYtPmRldik7DQo+ICsJZGV2X3NldF9kcnZk
YXRhKGR3Yy0+ZGV2LCBOVUxMKTsNCj4gKwlwbV9ydW50aW1lX3NldF9zdXNwZW5kZWQoZHdjLT5k
ZXYpOw0KPiAgDQo+ICAJZHdjM19mcmVlX2V2ZW50X2J1ZmZlcnMoZHdjKTsNCj4gIA0KPiAgCWlm
IChkd2MtPnVzYl9wc3kpDQo+ICAJCXBvd2VyX3N1cHBseV9wdXQoZHdjLT51c2JfcHN5KTsNCj4g
IH0NCj4gK0VYUE9SVF9TWU1CT0xfR1BMKGR3YzNfcmVtb3ZlKTsNCj4gKw0KPiArc3RhdGljIHZv
aWQgZHdjM19wbGF0X3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiArew0K
PiArCWR3YzNfcmVtb3ZlKHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpKTsNCj4gK30NCj4gIA0K
PiAgI2lmZGVmIENPTkZJR19QTQ0KPiAgc3RhdGljIGludCBkd2MzX2NvcmVfaW5pdF9mb3JfcmVz
dW1lKHN0cnVjdCBkd2MzICpkd2MpDQo+IEBAIC0yMjI3LDkgKzIyNDQsOCBAQCBzdGF0aWMgaW50
IGR3YzNfcnVudGltZV9jaGVja3Moc3RydWN0IGR3YzMgKmR3YykNCj4gIAlyZXR1cm4gMDsNCj4g
IH0NCj4gIA0KPiAtc3RhdGljIGludCBkd2MzX3J1bnRpbWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQo+ICtpbnQgZHdjM19ydW50aW1lX3N1c3BlbmQoc3RydWN0IGR3YzMgKmR3YykNCj4g
IHsNCj4gLQlzdHJ1Y3QgZHdjMyAgICAgKmR3YyA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAg
CWludAkJcmV0Ow0KPiAgDQo+ICAJaWYgKGR3YzNfcnVudGltZV9jaGVja3MoZHdjKSkNCj4gQEAg
LTIyNDEsMTAgKzIyNTcsMTAgQEAgc3RhdGljIGludCBkd2MzX3J1bnRpbWVfc3VzcGVuZChzdHJ1
Y3QgZGV2aWNlICpkZXYpDQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gK0VYUE9SVF9TWU1C
T0xfR1BMKGR3YzNfcnVudGltZV9zdXNwZW5kKTsNCj4gIA0KPiAtc3RhdGljIGludCBkd2MzX3J1
bnRpbWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK2ludCBkd2MzX3J1bnRpbWVfcmVz
dW1lKHN0cnVjdCBkd2MzICpkd2MpDQo+ICB7DQo+IC0Jc3RydWN0IGR3YzMgICAgICpkd2MgPSBk
ZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gIAlpbnQJCXJldDsNCj4gIA0KPiAgCXJldCA9IGR3YzNf
cmVzdW1lX2NvbW1vbihkd2MsIFBNU0dfQVVUT19SRVNVTUUpOw0KPiBAQCAtMjI2MSwxNSArMjI3
NywxNCBAQCBzdGF0aWMgaW50IGR3YzNfcnVudGltZV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2
KQ0KPiAgCQlicmVhazsNCj4gIAl9DQo+ICANCj4gLQlwbV9ydW50aW1lX21hcmtfbGFzdF9idXN5
KGRldik7DQo+ICsJcG1fcnVudGltZV9tYXJrX2xhc3RfYnVzeShkd2MtPmRldik7DQo+ICANCj4g
IAlyZXR1cm4gMDsNCj4gIH0NCj4gK0VYUE9SVF9TWU1CT0xfR1BMKGR3YzNfcnVudGltZV9yZXN1
bWUpOw0KPiAgDQo+IC1zdGF0aWMgaW50IGR3YzNfcnVudGltZV9pZGxlKHN0cnVjdCBkZXZpY2Ug
KmRldikNCj4gK2ludCBkd2MzX3J1bnRpbWVfaWRsZShzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgew0K
PiAtCXN0cnVjdCBkd2MzICAgICAqZHdjID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+IC0NCj4g
IAlzd2l0Y2ggKGR3Yy0+Y3VycmVudF9kcl9yb2xlKSB7DQo+ICAJY2FzZSBEV0MzX0dDVExfUFJU
Q0FQX0RFVklDRToNCj4gIAkJaWYgKGR3YzNfcnVudGltZV9jaGVja3MoZHdjKSkNCj4gQEAgLTIy
ODEsNDkgKzIyOTYsNjQgQEAgc3RhdGljIGludCBkd2MzX3J1bnRpbWVfaWRsZShzdHJ1Y3QgZGV2
aWNlICpkZXYpDQo+ICAJCWJyZWFrOw0KPiAgCX0NCj4gIA0KPiAtCXBtX3J1bnRpbWVfbWFya19s
YXN0X2J1c3koZGV2KTsNCj4gLQlwbV9ydW50aW1lX2F1dG9zdXNwZW5kKGRldik7DQo+ICsJcG1f
cnVudGltZV9tYXJrX2xhc3RfYnVzeShkd2MtPmRldik7DQo+ICsJcG1fcnVudGltZV9hdXRvc3Vz
cGVuZChkd2MtPmRldik7DQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gK0VYUE9SVF9TWU1C
T0xfR1BMKGR3YzNfcnVudGltZV9pZGxlKTsNCj4gKw0KPiArc3RhdGljIGludCBkd2MzX3BsYXRf
cnVudGltZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlyZXR1cm4gZHdj
M19ydW50aW1lX3N1c3BlbmQoZGV2X2dldF9kcnZkYXRhKGRldikpOw0KPiArfQ0KPiArDQo+ICtz
dGF0aWMgaW50IGR3YzNfcGxhdF9ydW50aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+
ICt7DQo+ICsJcmV0dXJuIGR3YzNfcnVudGltZV9yZXN1bWUoZGV2X2dldF9kcnZkYXRhKGRldikp
Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IGR3YzNfcGxhdF9ydW50aW1lX2lkbGUoc3RydWN0
IGRldmljZSAqZGV2KQ0KPiArew0KPiArCXJldHVybiBkd2MzX3J1bnRpbWVfaWRsZShkZXZfZ2V0
X2RydmRhdGEoZGV2KSk7DQo+ICt9DQo+ICAjZW5kaWYgLyogQ09ORklHX1BNICovDQo+ICANCj4g
ICNpZmRlZiBDT05GSUdfUE1fU0xFRVANCj4gLXN0YXRpYyBpbnQgZHdjM19zdXNwZW5kKHN0cnVj
dCBkZXZpY2UgKmRldikNCj4gK2ludCBkd2MzX3N1c3BlbmQoc3RydWN0IGR3YzMgKmR3YykNCj4g
IHsNCj4gLQlzdHJ1Y3QgZHdjMwkqZHdjID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICAJaW50
CQlyZXQ7DQo+ICANCj4gIAlyZXQgPSBkd2MzX3N1c3BlbmRfY29tbW9uKGR3YywgUE1TR19TVVNQ
RU5EKTsNCj4gIAlpZiAocmV0KQ0KPiAgCQlyZXR1cm4gcmV0Ow0KPiAgDQo+IC0JcGluY3RybF9w
bV9zZWxlY3Rfc2xlZXBfc3RhdGUoZGV2KTsNCj4gKwlwaW5jdHJsX3BtX3NlbGVjdF9zbGVlcF9z
dGF0ZShkd2MtPmRldik7DQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gK0VYUE9SVF9TWU1C
T0xfR1BMKGR3YzNfc3VzcGVuZCk7DQo+ICANCj4gLXN0YXRpYyBpbnQgZHdjM19yZXN1bWUoc3Ry
dWN0IGRldmljZSAqZGV2KQ0KPiAraW50IGR3YzNfcmVzdW1lKHN0cnVjdCBkd2MzICpkd2MpDQo+
ICB7DQo+IC0Jc3RydWN0IGR3YzMJKmR3YyA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAgCWlu
dAkJcmV0Ow0KPiAgDQo+IC0JcGluY3RybF9wbV9zZWxlY3RfZGVmYXVsdF9zdGF0ZShkZXYpOw0K
PiArCXBpbmN0cmxfcG1fc2VsZWN0X2RlZmF1bHRfc3RhdGUoZHdjLT5kZXYpOw0KPiAgDQo+ICAJ
cmV0ID0gZHdjM19yZXN1bWVfY29tbW9uKGR3YywgUE1TR19SRVNVTUUpOw0KPiAgCWlmIChyZXQp
DQo+ICAJCXJldHVybiByZXQ7DQo+ICANCj4gLQlwbV9ydW50aW1lX2Rpc2FibGUoZGV2KTsNCj4g
LQlwbV9ydW50aW1lX3NldF9hY3RpdmUoZGV2KTsNCj4gLQlwbV9ydW50aW1lX2VuYWJsZShkZXYp
Ow0KPiArCXBtX3J1bnRpbWVfZGlzYWJsZShkd2MtPmRldik7DQo+ICsJcG1fcnVudGltZV9zZXRf
YWN0aXZlKGR3Yy0+ZGV2KTsNCj4gKwlwbV9ydW50aW1lX2VuYWJsZShkd2MtPmRldik7DQo+ICAN
Cj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gK0VYUE9SVF9TWU1CT0xfR1BMKGR3YzNfcmVzdW1lKTsN
Cj4gIA0KPiAtc3RhdGljIHZvaWQgZHdjM19jb21wbGV0ZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+
ICt2b2lkIGR3YzNfY29tcGxldGUoc3RydWN0IGR3YzMgKmR3YykNCj4gIHsNCj4gLQlzdHJ1Y3Qg
ZHdjMwkqZHdjID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICAJdTMyCQlyZWc7DQo+ICANCj4g
IAlpZiAoZHdjLT5jdXJyZW50X2RyX3JvbGUgPT0gRFdDM19HQ1RMX1BSVENBUF9IT1NUICYmDQo+
IEBAIC0yMzMzLDE1ICsyMzYzLDMxIEBAIHN0YXRpYyB2b2lkIGR3YzNfY29tcGxldGUoc3RydWN0
IGRldmljZSAqZGV2KQ0KPiAgCQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1VDVEwzLCBy
ZWcpOw0KPiAgCX0NCj4gIH0NCj4gK0VYUE9SVF9TWU1CT0xfR1BMKGR3YzNfY29tcGxldGUpOw0K
PiArDQo+ICtzdGF0aWMgaW50IGR3YzNfcGxhdF9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikN
Cj4gK3sNCj4gKwlyZXR1cm4gZHdjM19zdXNwZW5kKGRldl9nZXRfZHJ2ZGF0YShkZXYpKTsNCj4g
K30NCj4gKw0KPiArc3RhdGljIGludCBkd2MzX3BsYXRfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRl
dikNCj4gK3sNCj4gKwlyZXR1cm4gZHdjM19yZXN1bWUoZGV2X2dldF9kcnZkYXRhKGRldikpOw0K
PiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBkd2MzX3BsYXRfY29tcGxldGUoc3RydWN0IGRldmlj
ZSAqZGV2KQ0KPiArew0KPiArCWR3YzNfY29tcGxldGUoZGV2X2dldF9kcnZkYXRhKGRldikpOw0K
PiArfQ0KPiAgI2Vsc2UNCj4gLSNkZWZpbmUgZHdjM19jb21wbGV0ZSBOVUxMDQo+ICsjZGVmaW5l
IGR3YzNfcGxhdF9jb21wbGV0ZSBOVUxMDQo+ICAjZW5kaWYgLyogQ09ORklHX1BNX1NMRUVQICov
DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBkd2MzX2Rldl9wbV9vcHMg
PSB7DQo+IC0JU0VUX1NZU1RFTV9TTEVFUF9QTV9PUFMoZHdjM19zdXNwZW5kLCBkd2MzX3Jlc3Vt
ZSkNCj4gLQkuY29tcGxldGUgPSBkd2MzX2NvbXBsZXRlLA0KPiAtCVNFVF9SVU5USU1FX1BNX09Q
Uyhkd2MzX3J1bnRpbWVfc3VzcGVuZCwgZHdjM19ydW50aW1lX3Jlc3VtZSwNCj4gLQkJCWR3YzNf
cnVudGltZV9pZGxlKQ0KPiArCVNFVF9TWVNURU1fU0xFRVBfUE1fT1BTKGR3YzNfcGxhdF9zdXNw
ZW5kLCBkd2MzX3BsYXRfcmVzdW1lKQ0KPiArCS5jb21wbGV0ZSA9IGR3YzNfcGxhdF9jb21wbGV0
ZSwNCj4gKwlTRVRfUlVOVElNRV9QTV9PUFMoZHdjM19wbGF0X3J1bnRpbWVfc3VzcGVuZCwgZHdj
M19wbGF0X3J1bnRpbWVfcmVzdW1lLA0KPiArCQkJICAgZHdjM19wbGF0X3J1bnRpbWVfaWRsZSkN
Cj4gIH07DQo+ICANCj4gICNpZmRlZiBDT05GSUdfT0YNCj4gQEAgLTIzNjksOCArMjQxNSw4IEBA
IE1PRFVMRV9ERVZJQ0VfVEFCTEUoYWNwaSwgZHdjM19hY3BpX21hdGNoKTsNCj4gICNlbmRpZg0K
PiAgDQo+ICBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBkd2MzX2RyaXZlciA9IHsNCj4g
LQkucHJvYmUJCT0gZHdjM19wcm9iZSwNCj4gLQkucmVtb3ZlX25ldwk9IGR3YzNfcmVtb3ZlLA0K
PiArCS5wcm9iZQkJPSBkd2MzX3BsYXRfcHJvYmUsDQo+ICsJLnJlbW92ZV9uZXcJPSBkd2MzX3Bs
YXRfcmVtb3ZlLA0KPiAgCS5kcml2ZXIJCT0gew0KPiAgCQkubmFtZQk9ICJkd2MzIiwNCj4gIAkJ
Lm9mX21hdGNoX3RhYmxlCT0gb2ZfbWF0Y2hfcHRyKG9mX2R3YzNfbWF0Y2gpLA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0K
PiBpbmRleCBjNmM4N2FjYmQzNzYuLmY1ZTIyNTU5YmI3MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy91c2IvZHdjMy9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gQEAg
LTE1NjgsNiArMTU2OCwxNiBAQCB2b2lkIGR3YzNfZXZlbnRfYnVmZmVyc19jbGVhbnVwKHN0cnVj
dCBkd2MzICpkd2MpOw0KPiAgDQo+ICBpbnQgZHdjM19jb3JlX3NvZnRfcmVzZXQoc3RydWN0IGR3
YzMgKmR3Yyk7DQo+ICANCj4gK3N0cnVjdCBkd2MzICpkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpOw0KPiArdm9pZCBkd2MzX3JlbW92ZShzdHJ1Y3QgZHdjMyAqZHdjKTsN
Cj4gKw0KPiAraW50IGR3YzNfcnVudGltZV9zdXNwZW5kKHN0cnVjdCBkd2MzICpkd2MpOw0KPiAr
aW50IGR3YzNfcnVudGltZV9yZXN1bWUoc3RydWN0IGR3YzMgKmR3Yyk7DQo+ICtpbnQgZHdjM19y
dW50aW1lX2lkbGUoc3RydWN0IGR3YzMgKmR3Yyk7DQo+ICtpbnQgZHdjM19zdXNwZW5kKHN0cnVj
dCBkd2MzICpkd2MpOw0KPiAraW50IGR3YzNfcmVzdW1lKHN0cnVjdCBkd2MzICpkd2MpOw0KPiAr
dm9pZCBkd2MzX2NvbXBsZXRlKHN0cnVjdCBkd2MzICpkd2MpOw0KPiArDQoNCkNhbiB3ZSBtYWtl
IHRoaXMgbmV3IGludGVyZmFjZSBjbGVhcj8gSXQncyBiZWluZyBidXJpZWQgdW5kZXIgY29yZS5o
DQp0aGlzIHdheS4gUGVyaGFwcyBhZGQgc29tZSBjb21tZW50cyBhbmQgZGl2aWRlciwgb3IgbW92
ZSB0byBhbm90aGVyDQpoZWFkZXIgZmlsZT8NCg0KVGhhbmtzLA0KVGhpbmgNCg0KPiAgI2lmIElT
X0VOQUJMRUQoQ09ORklHX1VTQl9EV0MzX0hPU1QpIHx8IElTX0VOQUJMRUQoQ09ORklHX1VTQl9E
V0MzX0RVQUxfUk9MRSkNCj4gIGludCBkd2MzX2hvc3RfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKTsN
Cj4gIHZvaWQgZHdjM19ob3N0X2V4aXQoc3RydWN0IGR3YzMgKmR3Yyk7DQo+IA0KPiAtLSANCj4g
Mi4yNS4xDQo+IA==
