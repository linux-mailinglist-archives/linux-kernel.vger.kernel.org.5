Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD96576A5D4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 02:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjHAA6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 20:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHAA6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 20:58:19 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B743EEA;
        Mon, 31 Jul 2023 17:58:18 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VJpsHj024159;
        Mon, 31 Jul 2023 17:57:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=UhbC/39Dk7uQPcjMjz/n1v90u/ue3MVT9T5451D+dSw=;
 b=uKq3lOn+KU5SiAQc0Oufy+OLMiQbIQ0Aif0cxJE7ZDz48GOrjciKIZN57u2IXEZa6Ppd
 2deeiMnm59MEjsjYJbQCx8h2BPl4mt7iygRnRwjrELvC0VjSNggGgdqZ76Bj598X0bz0
 ugv/sak5KX5S7d4YC+oCSTNCxJR1yhMWk85wsK1OablIounWUtGgxX4lh59Q6j5ujOjL
 vcH+dFoVpYNge8wpTre7+gxF9TMJfVxePikjgY3lYCobcyO4l2Fmrhb0+6gdIsjNiwd0
 Fb6v4mqPK3dng8tYgGgUs7gDknK4q9tmTavzKJwK1nfRTdGTM8JcqbtPJM4fs+F9UNOc vA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3s51pssw1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 17:57:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1690851474; bh=UhbC/39Dk7uQPcjMjz/n1v90u/ue3MVT9T5451D+dSw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Nb5pdKwDS05OYOif6n+f1P49DKEuykihJ2wIaFvFfsBFVWibYMyCvVCrgw6+9Tf/o
         C1qs0+0w3/BuT1ls4MvHH99cBOuMr3YP8cUZ9vjYQCqHsyCPa3MWtdVoczoCAyo8Hh
         DMwCTK1CHgs2PVBvPvoNQ6nkQasBIw+sTT+ljLMAPuBqiM+vnHI38oKcaw0GT78qgV
         A3pRPcVSlHcsL2vh/WFZFk8IeYlqT/7ZiyuEbFJt6cV0bxSvOSX/23QpPphi/uOxK7
         y4sgy+0lsC0f7Zek3kocjE841owC2fW6LRsqhNBuE7pbXPSYLWhFKCQYsj7OfevV2p
         E5cOAcky20kZA==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6624A4024D;
        Tue,  1 Aug 2023 00:57:53 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id EBCE9A008F;
        Tue,  1 Aug 2023 00:57:50 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=CZN3O/M3;
        dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 036854059E;
        Tue,  1 Aug 2023 00:57:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3fnDGoU+9HDQRMAfQ8L1T8Z1fBaLArk8lZjKCz9c2g85zMxgmJMDLTdsm5sdYDD6GKzCrJTm/0A1ArwhDVwWtwQzhEKF4nsHFU8dK5ydfmpM8E36DMxcelcMPacf5rlwSWyYDhd3lVgd4eFMMzop1S2WcyjooHVJuSQaZLvJ/3ErWYPTYjf2LR0yjvWVNUGZ1Wn5BH9hbA9U6MS1TxYcXT11N6HtfJaql1Vm8tswrLq+4jAiBeiX7akoj2zqo9SGKeku+SJj6993BHcsYBmGxfv3W/EvTnR0Z0TN5k/KIa345tx3yKbKSu9r+wkg90ZRbETYStOiSTUTzBdn74qLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhbC/39Dk7uQPcjMjz/n1v90u/ue3MVT9T5451D+dSw=;
 b=LIcwRmjEjEY1Og5xjbuPZ6oWGSIdc4pVXEGXll6IJqdWPjLbHwGju/90A5qjRp65kvP7kDIxt4k5TqLz1JAWbP/lDxHAwZgGxTM1aUVAiAE4RxGxAgADTE8wftg00iy20FPEmw+RuSELVfL5AO+YIEA583PDA/OP1y/9g2w9uy6T5nRmZj97Z+uNA/OzhAGFOdnT/bYtbdvRcB2qCGex32haJ8kPi+JUaXfj4PgmEz4iDRvD/vBA1NYgoiq4aIqmhhJ9qJNQp4h3jbsPFPe/83mykT1SFK0HEONC+Mph6TriG1mXaobB3N86AKm4OTq7aDwhb7hQZlQFG+SzPfAGLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhbC/39Dk7uQPcjMjz/n1v90u/ue3MVT9T5451D+dSw=;
 b=CZN3O/M3CdALhKIccCFLuA8EKSQQh1f8LXsdnZoThtJclbjKV/EPqWWImiyNAunWmTA9UwnPKsOmJ70TRIKcMEFxc7VVftA5GUt3EYy/XnvjI7fK976k3k8LrYaB09hTLL/UsoNvrOb6iuZYHw3sYB5YaJEsRuXITigItLzT3KE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH0PR12MB5465.namprd12.prod.outlook.com (2603:10b6:510:ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Tue, 1 Aug
 2023 00:57:44 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::138d:ed63:a424:1f33]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::138d:ed63:a424:1f33%5]) with mapi id 15.20.6631.042; Tue, 1 Aug 2023
 00:57:43 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>,
        "quic_shazhuss@quicinc.com" <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v10 03/11] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Topic: [PATCH v10 03/11] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Index: AQHZwNpurllp9DpiiEuiCJK9RHeWKK/UpKQA
Date:   Tue, 1 Aug 2023 00:57:43 +0000
Message-ID: <20230801005742.6vogskhlwjgi67dc@synopsys.com>
References: <20230727223307.8096-1-quic_kriskura@quicinc.com>
 <20230727223307.8096-4-quic_kriskura@quicinc.com>
In-Reply-To: <20230727223307.8096-4-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH0PR12MB5465:EE_
x-ms-office365-filtering-correlation-id: e6e79106-20df-48d1-73f7-08db922a5070
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aTXrU7YITL6bSyNMt4/5suMZQrLolkEbZ9O1sXAW2PfMi3+ECLChN63xWUxiEZcWz9atUt8011DrwEpu3+ipdj8v75LwpmlN2YBYothfZSmuTXeM0k0XrhH5nRJuj3Fxk5fpeUEaOc97kDvOwucDH7TfsixRqna3UfNnmNxMSUyieGFEmA4OjHEpa0stSiIzthH/4/72kByA0v0h3K21oP7XAKenVHJqilABaQeS1PdxqmkVJ0TRyw3GCHYXnOaMbkEDI/jMSwmgVhHd4bN3oRIJWM+NCX/IxCTeE5MV627u4Eqqm1oYbHtIdS08Y/UMSk7zgMFzxzFmoauvcoWxHQtkF2iI1bQcybDOsqERmJwNYQDr9OEDl84l+CGaRPE1ctmxbMyXXQO/iCJujVzuHpTPAKPSogUmt8fZIC8btuT44WP2aeYkL+hTM9E3mjTva/grIosHVsL3CQhJOZY+tsdvSgCa6edxjUccxfHEhmGjhQ6ubuATbWWDASpdaIkdj7bBMqwEeA5EfDUvKncr7cdIgWFoFNbLg9gvxOCvdczRynPdKs6KPWEBLrbfXYdEScOZf1D0SpAH8w73PUfXeWJaDYfTXgggRY3JVBpdUrVpANe4w47nBp8IqiDlSeEy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199021)(6506007)(316002)(26005)(8936002)(1076003)(41300700001)(66446008)(8676002)(54906003)(6916009)(122000001)(6512007)(66556008)(64756008)(66476007)(4326008)(76116006)(478600001)(66946007)(71200400001)(6486002)(36756003)(38100700002)(2616005)(38070700005)(2906002)(83380400001)(86362001)(186003)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V040ZStNTTBaaFNKMzczb3lBNmVSZHhBd2hOVGYwanZ4dEZ0VVQ3eGI1UFZt?=
 =?utf-8?B?WUJLcU1NSTl5OUgvYm9aQ2xYSjNhWjgwbG1jVldOcC9XNU4wbzZMUVoyL0Jl?=
 =?utf-8?B?U2ZhNEZHejVRdTRNb0QrbkdnSk9IYmYxdDl3S0tONWNmc1M5VGREUm4rY0t4?=
 =?utf-8?B?dXBhVlk5MEFWbHdiL245dkJwQ1FMYU5yVUFPT2Jma2RDbUFGRWl4NmNoMGpw?=
 =?utf-8?B?MWZRN2cvUnNwR3RYYyt6aHhwRHhHWHN4cSs1THdtc0VwT3dOUGRsM2Z4V0g1?=
 =?utf-8?B?dUlCMW1PNVAzZUI3cDZyelF6Z3RnVWdJQlpDaTFNVlVXV3dXWXRzMHpiMVhQ?=
 =?utf-8?B?QmsrUmg0UW5MMWhNVHZsbTQ3MFlwdTA0bmtpTlJRZHhmdGcxQ3ZHbkllWkJh?=
 =?utf-8?B?RU4rN0J0V24vODNEd21PWGxZWXZ6bHVIN3gyejZWVVRnUnU2NkdEZUUveGNX?=
 =?utf-8?B?RzJYQkdRM21FbFpqKzVSL2R3STJSNDZ2a0Q4SFIvN0gvQlNnSG9oSC9zelRp?=
 =?utf-8?B?L0w1blNNRkRNY2RhMUcvazZyRllkSFJ5YXErWENTejEvNVdndEEvTGxiMUo0?=
 =?utf-8?B?N24zaUZnQk9oblVDOVNLdHBvRWtpY3NPWmx4Y3h3TmozK0RGVU1Nc1VWS0VK?=
 =?utf-8?B?eTZ2OWh0eDN4MFJFckhZSU41Q0s1QU5peURDcHF3Z1UvbUZONGgxYzZFQXBF?=
 =?utf-8?B?a1RzdFRKakpFM0FjcXArZGs5THF6dHVUMkpnRFVKU0pGTTEzSXgwYXdZZE9H?=
 =?utf-8?B?RXRRaUZneDJLMWxuZ2RUSUEyeGVPbTgraVJkcHcwbUZXSE9vN3NPcXl1Z0VX?=
 =?utf-8?B?Z01zaW9VRWo2VEFNYVV6bVdsc2FFVDdMc1VBRmc4bjhQb0hVdmx0TjBLczRK?=
 =?utf-8?B?VC84L0hPV0FyUTlwVVBYOHg2Ui9pR3c1L0ZnTERXUHV1WGFTVHpvemtIU01w?=
 =?utf-8?B?MUhCc2FKNXdmMHY1ckRDYWxoaGhEVGZUblJhNjJqTHFyL21VeGNVM0M2OXh2?=
 =?utf-8?B?R0ZteHljOXdsMmlka0R3YlErUU5LS0RRQzNQRkV6RUhjcm9GaW5zUG16N2Vm?=
 =?utf-8?B?dmZhNEdZbTk5Z01ncnV5dHNXa2xTVU9WQk5HRkNiVW80a2RpdTZnYmxCODMw?=
 =?utf-8?B?eWZkNC9zeU1CNXBwc3FDV1czalBualdNRzU5cnhRM2pTelBVY2FOL3NwdGV5?=
 =?utf-8?B?SGJjcDJpL3R1eXhvWitSZ0VDZU9vZy9DNDl2YnVRYytxRUEyaVNXYnd3OThp?=
 =?utf-8?B?Y2lrT0VVWjVNaUQ2WlhvOTRCY2ZZdk9TOTBoVFovLzk5aG5oaVdYWEo3TEIy?=
 =?utf-8?B?akdnQ01VQ2hnNlREMHhsTEE2Um5uS0xyU0FSazQyR0Vac3ZGWmphWHBNSWZI?=
 =?utf-8?B?ZUNYYnMreFNLUkFRRlkzUVZ0KzYvbGF2azd3RjRia3p6dk9ra3p3QThyVmJs?=
 =?utf-8?B?UENtMHVRY1RmTGJRQUlwS0RUTUY3OTNheTNZSWJoajdrcEpoR0IvdVovQlha?=
 =?utf-8?B?L2IxeDhodmpaUVFOVEdCQ0Y1M3N4ZHdycU9NYnRNck5KeVNFTTAxVWhIQUJG?=
 =?utf-8?B?aTFUZkVKcXlDNExLb1V5eGs4SkFwUHdaT1lRcFk2SEhrMURGMVE5TjdDRDJ3?=
 =?utf-8?B?eElMNUNoZmNMakpCbFRWeWV3SEhKQytIUEZ5NlFETjUvamxiU0hEZzR0VGxs?=
 =?utf-8?B?Mkw2b2VtS0V3blVSRVZGdGNGVWgwb1hCQ0ZiRjhlaVROS2hGV1NRYUF0d24r?=
 =?utf-8?B?NXdvVmt5b00zVUNiVVE0VUZERmE4OGh2WDNpT1lOSmlpVk1SUytldldxTHRv?=
 =?utf-8?B?c1E5MGV2aDEvSjF1STVkeGZZVDJJRFZQTTJ0Ym5OSEY2VEpFS2J6QjljdW5s?=
 =?utf-8?B?YnE0RTdJdkxFd2wrWWxjTmxBTTlJQkw1ekJiSGF3Z0t0Nkhra2E4VW1lMldz?=
 =?utf-8?B?MGRBVVNvRGpVOVN0NW5kSXA2UmpDQ2g5anpERjVPUWRMY3FJZVZnNFVnTS90?=
 =?utf-8?B?OXdSWExIa2JwczFnbnpkdzYzcXMvWGFHL2p2WHVHeDFPQU8rc0pkMnpFOE1S?=
 =?utf-8?B?NjZIQjZGVWg5eTdRS2JlZkNrMU5iVnRrYytUUkwrUDVEbktiNEEwUmkwYjIz?=
 =?utf-8?B?U2ttRVNzVFI0KzVwU2M2emFwUFdXV1dsVkttNU0xbTd1ZkFmVFFYdzgzc2tl?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3726010938E0DD4185F0730CA2D39E99@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NE5rS2JyWDlIMGdHQ3B3NlhjL1R1OE1adTNkSGJxUTlIRmg0ektuaXJxaUpy?=
 =?utf-8?B?WEtEYmExTE0vVHo1Y21IVG95cGVtV1QrN1lBS211M2dnUmUyK1B6ZTRwcHpC?=
 =?utf-8?B?SHdWMGFWQmh3RjFxNkVuejVYNXhNbUZ2U3FoRXVqY1lDaTZjNHVGT2FwUGky?=
 =?utf-8?B?a0RNNWRsU2FZa0FnUUFtYWE3MEs5clV3ekhLSTUxT0tVUDk1MjZPNU1aNlFq?=
 =?utf-8?B?ay84RXE0ZThGem4rNXpSNG9maUg0TUdYRXFvR1dvRmN1RXRpdUthYUdpdWVz?=
 =?utf-8?B?L0xYZDRPOTRzb1cyT2FkQnR2MTRjcElKc2xqZ1dvRnZVZVVFSGRwbUg5VnND?=
 =?utf-8?B?RC9QOGpTelVqcFFuME9ubi8yQzF4UDc1M2VERzdEUlM3VHF2YVRUOTRld0JT?=
 =?utf-8?B?bUJ3eHNUNFZQLzE5Z0tNQWhmTTBFdGZHWGhxb3Vhbzl6RGxLbG1HNWp5MFFl?=
 =?utf-8?B?RDdtYXhzelpBWmxVeVpnazlOeGRSWTFrMS9nVjBsZkNhTlJpYzNidzBqaXk3?=
 =?utf-8?B?dmVQc0RYVVh5YW0xOFQ4elRRYW5Md1hWWXBtTmU2NDZUdEVjYldCc1p1UUJN?=
 =?utf-8?B?a2l0M1RtdXJzU3JWd1NEYituZ1RiVUtPeGQ0aThOREZZcWZZMG9VWHc3ZUlK?=
 =?utf-8?B?WjE3UzBwUzNtNklhbDNiaDc2cE0wa3VyWGlUU3BUOVVkdFhlS3hBWkdOUWtz?=
 =?utf-8?B?cTlodGdZTncvck5RZnVzUVd3YlBPWUkzNDZoWmpNY0VZN2MvUHBuSWhJM0Ny?=
 =?utf-8?B?Y0NjeThKTVlKdzFHTUZFNWlZeUltQitBU1dYRXlwVWx4aDJFWmFPUmJNZ1FM?=
 =?utf-8?B?aGJvQTZ0bEY1WlpvbG81Z2NuTVduQUFiNC9YQ3R0czBIaXJsWDJlSUp5NXFC?=
 =?utf-8?B?eklUaDFKK3RpZFJkZGptUU1QSW16Z3p6enJ1VGpGdXpDa1dMWVcwU0txUEVs?=
 =?utf-8?B?ZEpsMU1uZ211Y3BCcklUemJqWWFuY0lMZmJqTVNQQ0xDTHhBT1lhT0NVdFlV?=
 =?utf-8?B?VWZ0cFlSZHEwWjFvZTZ6WlhWUTRLMlJZRVVCTTNFNE1DQ1hIZkFsOHhMenBT?=
 =?utf-8?B?ekFrSHBKcC9pMUExQzVodU53NTlmNnZ2S2E1cGtGbVVBV2MvVDVTTTJTb0JL?=
 =?utf-8?B?bkxOZzF4cE11SFoyaFJGN2NkcCs1a3JzYjd0aHRWMFNUUmdJdlh3WllDWi9s?=
 =?utf-8?B?d1J6SExsMlBhdUE5MVZQTVN3YksrMCttcHFzSi9KaFk1OUxrczhCR0hqTTc5?=
 =?utf-8?B?RDQvWXlZVFZWSFB1M2t5MGNPeUR4dzl1RldMdEFRcW1pdCt3eDltRDdxQWVW?=
 =?utf-8?B?KzlYY2JLUDM1c081S091OUNwbVMxUXBDVjFKK2dQTFJjd0prdmpDQ1NlbGFk?=
 =?utf-8?Q?NsAfDVQma0RIUU0ny5psXz1RMnqfG1so=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e79106-20df-48d1-73f7-08db922a5070
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 00:57:43.7603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jys5/O6vpQbUwDKHx+GSvFU9n9sXT6Jkaq4WwVmxGcRunE4gtHdhspLwX8WJjRC1cs9GAB2tWffkuq3BTnE5Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5465
X-Proofpoint-ORIG-GUID: cE31cXdW3aoif2Iwqmw5YUhKIndf64IM
X-Proofpoint-GUID: cE31cXdW3aoif2Iwqmw5YUhKIndf64IM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_17,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 clxscore=1011 suspectscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=922 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308010005
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBKdWwgMjgsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IEN1cnJlbnRs
eSBob3N0LW9ubHkgY2FwYWJsZSBEV0MzIGNvbnRyb2xsZXJzIHN1cHBvcnQgTXVsdGlwb3J0Lg0K
PiBUZW1wb3JhcmlseSBtYXAgWEhDSSBhZGRyZXNzIHNwYWNlIGZvciBob3N0LW9ubHkgY29udHJv
bGxlcnMgYW5kIHBhcnNlDQo+IFhIQ0kgRXh0ZW5kZWQgQ2FwYWJpbGl0aWVzIHJlZ2lzdGVycyB0
byByZWFkIG51bWJlciBvZiB1c2IyIHBvcnRzIGFuZA0KPiB1c2IzIHBvcnRzIHByZXNlbnQgb24g
bXVsdGlwb3J0IGNvbnRyb2xsZXIuIEVhY2ggVVNCIFBvcnQgaXMgYXQgbGVhc3QgSFMNCj4gY2Fw
YWJsZS4NCj4gDQo+IFNpbmNlIHRoZSBleHRjYXBzIGhlYWRlciBpcyBvbmx5IGJlaW5nIHVzZWQs
IG1vdmUgcG9ydF9jb3VudCByZWxhdGVkDQo+IG1hY3JvcyBhbmQgc3RydWN0dXJlIGZyb20geGhj
aS5oIHRvIHhoY2ktZXh0LWNhcHMuaC4NCj4gDQo+IFRoZSBwb3J0IGluZm8gZm9yIHVzYjIgYW5k
IHVzYjMgcGh5IGFyZSBpZGVudGlmaWVkIGFzIG51bV91c2IyX3BvcnRzDQo+IGFuZCBudW1fdXNi
M19wb3J0cy4gVGhlIGludGVudGlvbiBpcyBhcyBmb2xsb3dzOg0KPiANCj4gV2hlcmV2ZXIgd2Ug
bmVlZCB0byBwZXJmb3JtIHBoeSBvcGVyYXRpb25zIGxpa2U6DQo+IA0KPiBMT09QX09WRVJfTlVN
QkVSX09GX0FWQUlMQUJMRV9QT1JUUygpDQo+IHsNCj4gCXBoeV9zZXRfbW9kZShkd2MtPnVzYjJf
Z2VuZXJpY19waHlbaV0sIFBIWV9NT0RFX1VTQl9IT1NUKTsNCj4gCXBoeV9zZXRfbW9kZShkd2Mt
PnVzYjNfZ2VuZXJpY19waHlbaV0sIFBIWV9NT0RFX1VTQl9IT1NUKTsNCj4gfQ0KPiANCj4gSWYg
bnVtYmVyIG9mIHVzYjIgcG9ydHMgaXMgMywgbG9vcCBjYW4gZ28gZnJvbSBpbmRleCAwLTIgZm9y
DQo+IHVzYjJfZ2VuZXJpY19waHkuIElmIG51bWJlciBvZiB1c2IzLXBvcnRzIGlzIDIsIHdlIGRv
bid0IGtub3cgZm9yIHN1cmUsDQo+IGlmIHRoZSBmaXJzdCAyIHBvcnRzIGFyZSBTUyBjYXBhYmxl
IG9yIHNvbWUgb3RoZXIgcG9ydHMgbGlrZSAoMiBhbmQgMykNCj4gYXJlIFNTIGNhcGFibGUuIFNv
IGluc3RlYWQsIG51bV91c2IyX3BvcnRzIGlzIHVzZWQgdG8gbG9vcCBhcm91bmQgYWxsDQo+IHBo
eSdzIChib3RoIGhzIGFuZCBzcykgZm9yIHBlcmZvcm1pbmcgcGh5IG9wZXJhdGlvbnMuIElmIGFu
eQ0KPiB1c2IzX2dlbmVyaWNfcGh5IHR1cm5zIG91dCB0byBiZSBOVUxMLCBwaHkgb3BlcmF0aW9u
IGp1c3QgYmFpbHMgb3V0Lg0KPiANCj4gbnVtX3VzYjNfcG9ydHMgaXMgdXNlZCB0byBtb2RpZnkg
R1VTQjNQSVBFQ1RMIHJlZ2lzdGVycyB3aGlsZSBzZXR0aW5nIHVwDQo+IHBoeSdzIGFzIHdlIG5l
ZWQgdG8ga25vdyBob3cgbWFueSBTUyBjYXBhYmxlIHBvcnRzIGFyZSB0aGVyZSBmb3IgdGhpcy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtyaXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVp
Y2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgICAgICAgICAgfCA2
MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy91c2IvZHdjMy9j
b3JlLmggICAgICAgICAgfCAgNSArKysNCj4gIGRyaXZlcnMvdXNiL2hvc3QveGhjaS1leHQtY2Fw
cy5oIHwgMjcgKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvdXNiL2hvc3QveGhjaS5oICAgICAg
ICAgIHwgMjcgLS0tLS0tLS0tLS0tLS0NCj4gIDQgZmlsZXMgY2hhbmdlZCwgOTMgaW5zZXJ0aW9u
cygrKSwgMjcgZGVsZXRpb25zKC0pDQoNClBsZWFzZSBzcGxpdCB0aGUgbW92aW5nIG9mIGNvZGUg
Zm9yIHhoY2kgaW4gYSBzZXBhcmF0ZSBjb21taXQuDQoNClRoYW5rcywNClRoaW5oDQo=
