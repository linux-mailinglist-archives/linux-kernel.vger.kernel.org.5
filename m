Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E9B7D190C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjJTW0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTW0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:26:53 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DD119E;
        Fri, 20 Oct 2023 15:26:48 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KHnoFD022734;
        Fri, 20 Oct 2023 15:26:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=9+sgZq1V6YPKg+LZfdj2oLt1aI4UbQHJLBeRwwxc7iw=;
 b=l+7jFwVW225eKGhzcVNu7EpJZ46FaAirYdp+uD2aIbpkxpgRh+Ph/il1MP/U3IgKwg6S
 YWBYCqKgtxi8LefvJ9DpoQG7GmatTjqtVXsO2MaQyJ6Hmf1JmFc1E5D8KZwNpqWkXl7P
 8EP/jxT0ZhqwDgor29YE91CxAzzGqmyS70Qu3urmQvQs3iByZkaOeIsg1KKFKED7SsY2
 I/g3YAL/G1cSXC1GjNZCuLtkahFgtxbXc7Ycl2kiIOP6PgO6UJEXVzfA8J4gNhWXNP1i
 xKXY1yLAxZDQcJ38nlnMKW9U9IgVLF720pCwUuMcWVcVxLrm91ObIaYoeoIsj1gm23jT QQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3tubyc6jh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 15:26:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1697840797; bh=9+sgZq1V6YPKg+LZfdj2oLt1aI4UbQHJLBeRwwxc7iw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=JAsS5pVHJ6yhsIw6TTBqiQbeAOLIxQwZ7xjwcWi9dR6zJTpghn6dKcQtJ1dn0YoQB
         lpc9lolnYJ+0g8rvX4xQxZcJmdXz5vo+UAH4wE8AEN+OQ2k1xUdw1IMf56J7fxmzyP
         vMCumDp9XP8E5u0HmVSDnSG2l3AZPoPayKvwapN0G7tzpOgVW6+QPsmXQ1PMiVKZ6d
         +E+w78f9oiG5wYx9EU5qPnBDyzCDuMheriDg7tQrAEFOx6qGRI0VLOpfJXyZXR4Y4H
         W5XTnPREI7TvO2YaUL1L7JDcb3LUlau4uKNmAjb4OacM1RtalIBhHHyMOYRc/oDioB
         PJtoxzV8uy+fQ==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 45A49404D0;
        Fri, 20 Oct 2023 22:26:37 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 69B20A0081;
        Fri, 20 Oct 2023 22:26:32 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=I/miPkmr;
        dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D85A14048F;
        Fri, 20 Oct 2023 22:26:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0hufgy9kGBvtU4cwySpwqMnvibb3eU7Nim5QHgyCMM/GOd7uFVMpjyaulSfNR9zn+CiKU50FBZH5y333Jcn0ne09GbarILbh2JHS2xbCmAL9jx38Ze+rz9ZBrtkWDR1IdTULOhAq6i3iiV9WtjNjshV2Isyp8sTWrRMJRmLru+kHiUZTTNuM7VfOyMcESpiSawkXVOv4H8LOnCoijMbDk0V75wlIJ4apY+x/DKH44i7KwM/x8ZctHJiFaXvJMkb9HrAwcgkY5MRyFx5breK1lVnPnt18irfktXln5sugtkZ1roWNSpwJ1jKFOvbYKpw7u3Pv1VAwcpNPp28Wh7ASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+sgZq1V6YPKg+LZfdj2oLt1aI4UbQHJLBeRwwxc7iw=;
 b=RDSETHmIU4bQgQbZrH1cZeJezW8GguLxf5L3xUTAZJXC8TmWxDh4g7TI4EXKbKl8Xp/eBPSD0PFdbBOAAn37DUn3zDWyp7/ruUB5+uKXuNj2CqaTFep10Gqmvd3Hvvt5IjYmD3KesQDRb6sir+0RQ/x3yXyeGch8NGTXP1IQSC3DI0HUeGjy87SYn97QAxa6puJhtTodU/XXiuPy7VAfP0oUKYc0zynw2TZ979rEfjeg5MY979EfxyxBo79GMBQBr9CzLocJCEXsec0+F4jLngQDTQSGaAJtttPzndJsAZvv8rRvxyskb7jP+F6v8lukM7RcPyAwnKEhCGbEqE5V7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+sgZq1V6YPKg+LZfdj2oLt1aI4UbQHJLBeRwwxc7iw=;
 b=I/miPkmrbPTqZBieAmZhIu47YtFuIXk1e3kz9E/PtjPC/mP1WCulloQI7BaBMifKhKLMXkXewsOQ5aUCGLn0lkSr6/zt/7pvsxmBhdvJEfgCX1smrvo/BZHRJtArmJr5TKQRo9sU0EmSYHllAEzn50I0sJKnfy/4m6xuf9eiy/Q=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 22:26:28 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b63e:67e6:b5fe:a8cb]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b63e:67e6:b5fe:a8cb%3]) with mapi id 15.20.6907.021; Fri, 20 Oct 2023
 22:26:28 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Roger Quadros <rogerq@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_kriskura@quicinc.com" <quic_kriskura@quicinc.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: usb: snps,dwc3: Add
 runtime-suspend-on-usb-suspend property
Thread-Topic: [PATCH v4 2/3] dt-bindings: usb: snps,dwc3: Add
 runtime-suspend-on-usb-suspend property
Thread-Index: AQHZzuBFIbiQId3K7UqIXmJcc9s6yK/sa62AgAQHiICAAPALAIAFqBsAgABumgCAABksgIAETzCAgABxe4CAA/1PgIAB1kOAgAAwoICAACr9gIABTioAgAA6OYCAIbObgIARZ3gAgBfW5ACABK3RgA==
Date:   Fri, 20 Oct 2023 22:26:28 +0000
Message-ID: <20231020222621.h26ft6ivu4sdckjm@synopsys.com>
References: <afd4843b-427a-8535-78e2-f81879378371@linaro.org>
 <969988f6-f01f-0e31-6a98-7d02c5a3a4ad@quicinc.com>
 <20230830013739.srnh2uyhly66yvu2@synopsys.com>
 <d30a8d6a-236a-b6eb-76d7-115cc9950ce1@quicinc.com>
 <6f70a710-c409-23c0-890b-370ccd23e088@linaro.org>
 <20230831030134.z46fjwyr6edl3t7x@synopsys.com>
 <cea3472a-e9f7-39cb-419c-d042b3bf0682@linaro.org>
 <63c9ced1-6204-88e9-1dae-2979388bbc67@quicinc.com>
 <20231002185606.eumc37ezthov7uge@synopsys.com>
 <e668ca8a-8842-4500-ac8d-ae3798238890@quicinc.com>
In-Reply-To: <e668ca8a-8842-4500-ac8d-ae3798238890@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DS0PR12MB6607:EE_
x-ms-office365-filtering-correlation-id: 39adeadf-2ea9-48f8-a978-08dbd1bb9a6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tCkLLklp98Q1i73C9H4hSVYTNbShDAlqc1HfQdQZPlz7CuYXu2WULyfucmCja066KizrB0gLGN+u9IlE/CMEuj7w7xNbq792lV/bJhmHIs96flstfkgSc03pwfKPwuinAa9kdDMCBLE3tozbZACUv4WFClp5UJXfXSriTmqDHkW3GP0muBWlydPTfDnNQcPqW1pIHyB5HC7FYUXrWplsAPK8wcEW3xrjEFFdfYeOM4KKencoqEPPmZY9UZPX7CkUYuZNJBf0qsZQOnCzPDUTsxvH1lm3t5fdEcJ6RuJEqw9GfKIPSmcXFwrW6++68a/AqfZat+dHMxRHLW/wlGUAr3ZSTVwQJN5NNECj54OQVuZ/XYCgvH2GAhsi4jMYVmaKGuGvR3tTGwPz4oDppZlarpw4b4yTIb1NuceCTriFuLbf/zYfcb1aOT5cR9nTGmQ+vA/7prI1N62c6kYk55fg1hEwLWJco8XfRj7zTZCRL1qIZA62efreKjFgQpcgX/e6VcjrzBnrl/KtBc6m1/+9mJxMaajJho3XAak6O5EWuWDQ6svNa/hsuJX/3LXgwcxw9ooCceFiX24kcsFs92mrn7qo+Vxzo0qSM+MNIxyQR7k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(86362001)(8936002)(83380400001)(5660300002)(66446008)(66476007)(6486002)(66556008)(966005)(66946007)(76116006)(38070700009)(38100700002)(8676002)(6512007)(4326008)(7416002)(36756003)(64756008)(2906002)(316002)(26005)(1076003)(2616005)(71200400001)(6916009)(54906003)(15650500001)(41300700001)(6506007)(478600001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UldVUmtOVHVGY3NaUTlzZjFuTW1jUUlGZTJ5RjltSGE4UWFId3A4MU1SRG9q?=
 =?utf-8?B?SUpHY0d5MDdMNG85dWkvdkt0TE0zeUZSVWt4YkNGdElDR284V1NPTVBqZnpX?=
 =?utf-8?B?OXRYUHhkRExjMkVKV2RCdkZWb1F5cEZXeUk4d3FEOVNxTGhsRUlqV243VDZM?=
 =?utf-8?B?UEt4V2MwOFh6NmZaODFGSVNzSC9mUVlmWng3NHNNOGg2Vk5KcVFqcklJNjdZ?=
 =?utf-8?B?NTl4YnM4cXZyK3ljLzdOWDRpSEo5MFZENS9iZW1XL01zOTZIbHRPQW1EcCtL?=
 =?utf-8?B?NDI0bFZaVStJcVNwL3d6UUFuTk9RUDgrSkVDb1JORytnUjk1WkxjMEFUdWF4?=
 =?utf-8?B?TVhKMU1EY3FkZzQwRkY1WnNMU0JrRDNVZkZlSWFnVHlFT2I2eXNaakExV0RG?=
 =?utf-8?B?dzZOUE8yZFZ2RFE4ajFtajI4L1hCKy9CcDdNOGNOVkwyRG9SOEJ3anN1L0hW?=
 =?utf-8?B?Y1R5RmJNZTNFdk1JTG1tZkN4aGpQNU91VjNGRlBYNDdUdFIrSTdudVI3MDRN?=
 =?utf-8?B?NWRoSWlsYTkzMER4QkdzYkllR00rcFBlc0pOOHpzRFA0aFhkalVXVUpoNkkv?=
 =?utf-8?B?bGFYRUxKVUJ3ZDlVT3VMNkNZVTNtZlltU2lWS0pqVkhkb1V5ZVBZK2YrTjNB?=
 =?utf-8?B?NmNFd0FDZDJpakRpbkpJVXJLcUsvWndNNjhtTzIvS0VzSmtvdDd0bm4ydXJq?=
 =?utf-8?B?SUh5bitqUnI2eGJkK0lzeUFZTUZPV2Fzam56Nk9hVDVTUFBwOTJOb1dSN094?=
 =?utf-8?B?bjhBYk05dVQ0QU9HUmswN2R2dnA3NUdXTkdUL0ljeVdFU28wQzBMYngxcnd2?=
 =?utf-8?B?OHd5YUtvZmNhTTRySzZYQjJOdjhrOWVsTGNqVUY5SjZHaFVHSEwxc1FPNU5l?=
 =?utf-8?B?VGEzUVY3cFdZZncxdDM3OTlmd3Q2T3BzeHpxWVNvWW50dkxKUzZFOEVMZWt0?=
 =?utf-8?B?dGdtb2dQYktwbzE5Z1RrRWhoYzhqbVpHc1lJTzM4N3B2Q1FlaHpzVmZvVGls?=
 =?utf-8?B?L3BpQVE0blhyWXBPaWtSalpxbHJCZ2tpWTRDTkpaM1NoQmxUaUc0ZFhBRXpK?=
 =?utf-8?B?dmhvbXpoam5qY3YweEd3dWRvVGpiYmJXSmZYVGp1aVNiR29UbnpST25BbDA5?=
 =?utf-8?B?NFhJR3pxVk1jdVQxaEFXQmlpQmhNcWxNT0l2NkJZb1ZXclR4cFBEcUNlV3F5?=
 =?utf-8?B?SS82MlpjTjYwMDJQMW11MXAwSXJwU1VHZU5JWWo1VTMxci9aZFBGenozTFlO?=
 =?utf-8?B?ZGh5UUxtTEZ4UUZENDNqZ1dkc1ZtRWxmQUlJaGRMRk4zeE1PRWE5dHdxL0du?=
 =?utf-8?B?RlBrMGxpZTlqc1hEV1FTMlBocXNHM3EwY1RaWFo4Q045YitsRGpPelAwU3dW?=
 =?utf-8?B?Rmp0b3VENDFTb05GVVBGK2FNWXB4OWMyV1BkMW5WR3MzWENhUHJydU54OVJQ?=
 =?utf-8?B?R3ZHNG44NWJaRHl3VDJnYVRYc1ducytSdGZsUDFVckJmdkJESjJxbGlwcDV4?=
 =?utf-8?B?QVRnbXVOM1k0dEkxMmhrNE5RY3BCRmhIbVRaclhnMFVkY1QyUU9mWFNqMUtK?=
 =?utf-8?B?bW9CbjVNVGsxQmpCSEx1eWtZYkcxR1RZL20vT0NINTBJZlE5b1JUS1BObVdP?=
 =?utf-8?B?cVNsSTEyODE0QmdrOCttWTIva0c2Um1Zb0lodEFRQUUwc2lvRUt5b0RVVDRl?=
 =?utf-8?B?cTJPRHppeW5tanNPUUZKVGUvZVRoTW5PR0YwUHZTcVJqdEhEcTNaQ2Y0di9Y?=
 =?utf-8?B?WHBQMjN3UmhRcHhNN29zTGJtVU5WTkl5cEFJYllvaVFTem4xMVZhTWdocFNJ?=
 =?utf-8?B?NzdmVjMrQll5aWhEaVBoOE9aaDZlUzQwOUExSUJIT3l5LzE3TkZnMXoxZVA3?=
 =?utf-8?B?RFh2WUNieEFmc1RvbEwvS1dBZ25kdWJlMTFqanZ3Zjg5V01qSlBlYXk0ZENh?=
 =?utf-8?B?K1lKT05GcjhBL3FWYzB2TDZBZjRVeDVmKy90Wkw5VHJ2bGFJMkZEMjNNTVA1?=
 =?utf-8?B?NGhwSTVXN05iZlFtaUhYMG1mT25WcWR3Y210ZUNzUllZVTdFenFqbGFqU3Zj?=
 =?utf-8?B?V2hsb0ZMbW50a3RzOHNJZHozaTdjSDVsOHJDMTFYdG56bWU0NllsYStBUTV2?=
 =?utf-8?B?dVZub2J1OTBmUU1qNFJpTHFSMHA3UUZYT2xiVzdER3krYTFrb09FcXpyWm92?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D91D154E9DCA44F87C8E689AF9373CA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?b2tzT2s1VTdraEdoMGlCZ2hhTUQ5NG14ZjErZ3RFVkFON01CNFcwSkd0WmNu?=
 =?utf-8?B?Y1YyVGJ5V3drOHNsSWo0TUtDY2RGMlJaclM0VW9ad0tpVWZ1UHRNZHU0MXli?=
 =?utf-8?B?VjFJbXhhaWM0N2RHVy9oVEFXemdOczVwSnhLaE5Ub1hiNXdveTQ3VjF0K1dD?=
 =?utf-8?B?ZG5vc2MxTVlGNUpYSzZBWFNqQVNwbW5pdnJNTGptRWZBRWVpc1AvUHE1TU1O?=
 =?utf-8?B?VGV4bElvS2tlb09aaUhUMG5Ndk8wUHhVZkEzQndxWEhTQXFYUVI2bExJWjJk?=
 =?utf-8?B?cEZNdjAxL1JySlFMSjM0cVpTZjNRanV1ajJibE5oVis0Y1RMSjB4N2RpVHNv?=
 =?utf-8?B?YVplbTZCRVBObTEzVnJabFVmNWpiMzREbjdEaDhiVDViNngzRVpIYW1YZ2x3?=
 =?utf-8?B?OHBVa3IyT2U4dDJxdjVKRkRGeDQrQnJPR016NHdxOWpUQmRtMkpITUVZUG5i?=
 =?utf-8?B?U2RydVB6ckpUOVovcUN2NmZFWFhtSGx3YUFLbmExa1p1ckdEQzFoZ0Q2OUpL?=
 =?utf-8?B?c2tQZUZBdHp2eG5RVWRpTUZwUWhKNVRrY08zVUlaZjdTWWZoWTJYdnNJdVFQ?=
 =?utf-8?B?b0FyczhIc2V6czdNVG1DZ0hncUFhbHdobDY2RUNsWG9XV0MwcVFNSnJueUtj?=
 =?utf-8?B?dFRPQ1huRUd1bTI0MXg1WWN5bzVxbnJXVlE0QmM3aWJvYm8zTmZLU0lkQ1BR?=
 =?utf-8?B?YUVDL2k3dDFlVEZZSi91TEhNWTZEWS91bHVmeE1VL1gwbzFDZDRkazVZTHM0?=
 =?utf-8?B?ZVh6dUxTY0pScENLc2gwY2c4aWUyT1Yvbmx5Ry9GV2VYRVR6UE4rdXB0cDVL?=
 =?utf-8?B?TS94bVpvYkQ0OUp2TGJNMTFiZU5CRjE2Z1hXQm1zSWZNdG9WUVRTZnp1THZK?=
 =?utf-8?B?RnU0SXdOVU1FWHY5WlRFcjlrSEltZ1hPNWxyRHo1bVQxWlJsOGNKcW9PVHo3?=
 =?utf-8?B?dTA2S29WL3d3OUdYNk5CbXk4NHQwckxWZEhNZ29yazF6dW9PZHhKQnBXNW1Q?=
 =?utf-8?B?ZUIyNFc3eTBhVWVPRWd2c1kyNXpHUDJEN0R0UkpKaXVWd216YkZkNXhKUFMv?=
 =?utf-8?B?azBkY20vWEJkUGhxSlUyeWRzU2JaRkNPQS9RZHpyNEtBa2FBOS9LcHlKUWpk?=
 =?utf-8?B?UTZubnJzcFVQSWI4OUhzQmtkREpvUW1uOUhFYjZVbDFkbERnVWtpd2FuVTc5?=
 =?utf-8?B?L1VpTHRCakdoUnpHL0pNZjBSeURrdm9BeUNxckJVYWRmWDR2dkwzcXdoWjZs?=
 =?utf-8?B?NklFRHlQU01WWHlZNFdvUjc3OVhWaUNadEU5M0pRejMvTy9YUT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39adeadf-2ea9-48f8-a978-08dbd1bb9a6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 22:26:28.2749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nZFyo3w53Ry6qUfuLGmakz1ZGF5f3Y96YhJvVaNblmH1aIunwCKHn8vL4g9cT/ojqt0EFJOJEbeTCDiDhbvAYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6607
X-Proofpoint-GUID: qL06HlQcrQ1hhZALvwcfjTpzUYZ71QSG
X-Proofpoint-ORIG-GUID: qL06HlQcrQ1hhZALvwcfjTpzUYZ71QSG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 mlxlogscore=974 spamscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310200191
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBPY3QgMTcsIDIwMjMsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gDQo+IA0KPiA+ID4g
SEkgVGhpbmgNCj4gPiA+IA0KPiA+ID4gQXBvbG9naWVzIGZvciB0aGUgZGVsYXllZCByZXNwb25z
ZS4NCj4gPiA+IFNlcmllcyBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXVzYi9jb3Zlci8xNjU1MDk0NjU0LTI0MDUy
LTEtZ2l0LXNlbmQtZW1haWwtcXVpY19rcmlza3VyYUBxdWljaW5jLmNvbS9fXzshIUE0RjJSOUdf
cGchWUdsVnk3Tm85OHpmRU0tWDVpV1JoSVVKLWdKRUpuX2diVFI0azEyYXZ6RU5WMVRYZjdjd0pM
WlVlell6QVUtcm5ISWJicUExVVdNMElFMFItdDVTTU1USkx3TFokDQo+ID4gPiBmcm9tIEtyaXNo
bmEgSywgaW50cm9kdWNlZCBhIGR0IHByb3BlcnR5ICd3YWtldXAtc291cmNlJyB3aGljaCBpbmRp
Y2F0ZXMgYQ0KPiA+ID4gcGxhdGZvcm1zIGNhcGFiaWxpdHkgdG8gaGFuZGxlIHdha2V1cCBpbnRl
cnJ1cHRzLiBCYXNlZCBvbiB0aGlzIHByb3BlcnR5LA0KPiA+ID4gZ2x1ZSBkcml2ZXJzIGNhbiBp
bmZvcm0gZHdjMyBjb3JlIHRoYXQgdGhlIGRldmljZSBpcyB3YWtldXAgY2FwYWJsZSB0aHJvdWdo
DQo+ID4gPiBkZXZpY2VfaW5pdF93YWtldXAoKS4gRm9yIGV4YW1wbGUgZHdjMy1xY29tIGRyaXZl
ciBpbmZvcm1zIGl0IGxpa2UgYmVsb3cgYXMNCj4gPiA+IHBlciB0aGUgaW1wbGVtZW50YXRpb24g
ZG9uZSBpbiB0aGUgYWJvdmUgc2VyaWVzDQo+ID4gPiANCj4gPiA+IAl3YWtldXBfc291cmNlID0g
b2ZfcHJvcGVydHlfcmVhZF9ib29sKGRldi0+b2Zfbm9kZSwgIndha2V1cC1zb3VyY2UiKTsNCj4g
PiA+IAlkZXZpY2VfaW5pdF93YWtldXAoJnBkZXYtPmRldiwgd2FrZXVwX3NvdXJjZSk7DQo+ID4g
PiAJZGV2aWNlX2luaXRfd2FrZXVwKCZxY29tLT5kd2MzLT5kZXYsIHdha2V1cF9zb3VyY2UpOw0K
PiA+ID4gDQo+ID4gPiBUaGUgZHdjMyBjb3JlIG5vdyBjYW4gYWNjZXNzIHRoaXMgaW5mbyB0aHJv
dWdoIGRldmljZV9tYXlfd2FrZXVwKGR3Yy0+ZGV2KQ0KPiA+ID4gd2hpbGUgY2hlY2tpbmcgZm9y
IGJ1cyBzdXNwZW5kIHNjZW5hcmlvIHRvIGtub3cgd2hldGhlciB0aGUgcGxhdGZvcm0gaXMNCj4g
PiA+IGNhcGFibGUgb2YgZGV0ZWN0aW5nIHdha2V1cC4NCj4gPiA+IA0KPiA+ID4gUGxlYXNlIGxl
dCBtZSBrbm93IHlvdXIgdGhvdWdodHMgb24gdGhpcyBhcHByb2FjaC4NCj4gPiA+IA0KPiA+IA0K
PiA+IEhpIEVsc29uLA0KPiA+IA0KPiA+IEkgdGhpbmsgdGhhdCBpdCBtYXkgbm90IHdvcmsgZm9y
IGV2ZXJ5b25lLiBTb21lIHBsYXRmb3JtcyBtYXkgaW5kaWNhdGUNCj4gPiB3YWtldXAtc291cmNl
IGJ1dCBzaG91bGQgb25seSBiZSBhcHBsaWNhYmxlIGluIHNlbGVjdGVkIHNjZW5hcmlvcy4NCj4g
PiAoZS5nLiBSb2dlcidzIHBsYXRmb3JtIHdhcyBvbmx5IGludGVuZGVkIHRvIGtlZXAgY29ubmVj
dCBvbiBzdXNwZW5kKQ0KPiA+IA0KPiA+IEFsc28sIGhvdyB3aWxsIHlvdSBkaXNhYmxlIGl0IGZv
ciBjZXJ0YWluIHBsYXRmb3Jtcz8gUHJvYmFibHkgd2lsbCBuZWVkDQo+ID4gdG8gdXNlIGNvbXBh
dGlibGUgc3RyaW5nIHRoZW4gdG9vLg0KPiA+IA0KPiANCj4gSGkgVGhpbmgNCj4gDQo+IFRoYW5r
IHlvdSBmb3IgeW91ciBmZWVkYmFjay4gQXMgYW4gYWx0ZXJuYXRpdmUgYXBwcm9hY2gsIGhvdyBh
Ym91dCBleHBvc2luZw0KPiBhbiBBUEkgZnJvbSBkd2MzIGNvcmUgdGhhdCBnbHVlIGRyaXZlcnMg
Y2FuIGNhbGwgdG8gZW5hYmxlIHJ1bnRpbWUgc3VzcGVuZA0KPiBkdXJpbmcgYnVzIHN1c3BlbmQg
ZmVhdHVyZSAoIGkuZSB0aGlzIEFQSSBzZXRzDQo+IGR3Yy0+cnVudGltZV9zdXNwZW5kX29uX3Vz
Yl9zdXNwZW5kIGZpZWxkKS4NCj4gDQo+IE9ubHkgdGhlIHBsYXRmb3JtcyB0aGF0IG5lZWQgdGhp
cyBmZWF0dXJlIHRvIGJlIGVuYWJsZWQsIGNhbiBjYWxsIHRoaXMgQVBJDQo+IGFmdGVyIHRoZSBj
aGlsZCAoZHdjMyBjb3JlKSBwcm9iZS4NCj4gDQoNCllvdSBtZWFuIGFmdGVyIEJqb3JuJ3MgdXBk
YXRlcz8gVGhhdCBzb3VuZHMgZ29vZCB0byBtZS4gUGxlYXNlIG1ha2UgaXQNCmdlbmVyaWMgc28g
dGhhdCB3ZSBjYW4gc2V0IG90aGVyIGRyaXZlciBwcm9wZXJ0aWVzIHRvby4NCg0KVGhhbmtzLA0K
VGhpbmg=
