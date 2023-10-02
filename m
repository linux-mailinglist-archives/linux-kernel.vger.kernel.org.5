Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25467B5AC3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbjJBS4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjJBS43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:56:29 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC62B0;
        Mon,  2 Oct 2023 11:56:24 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 392HD5Xf004023;
        Mon, 2 Oct 2023 11:56:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=3ayweUwsanfCzjdxhkm9At5M457gbx53+Nu5zigbpug=;
 b=RYHs52G9pgRwn+LfhftwXaR3GqV7nT7HtHve/FHoh0lxqY5IeFnS4OpsWoZkW0zztNh8
 G1k6Vuil4nGJBWZlzdm/rA0KQWjap8ozCWvALb7PEDPPstQxcPC4mXaYg+CKKRiGkgSD
 exAGkmwXVMsLPghoqDp5rSR8ghmwtcswEhMunqi1KmPdM+mlIYcGaVV3BFYOFFJqQF53
 Z9xvQjurSj07rGk1PfF6wDY2+8GTpOwvsxAI17J/zSf76obcRhAozwk347B8DpW67py+
 JsQOhlwtChrCEvuJx5joS8KaH6fswfHsBgM6pFGDm+5vKhjD8sVpKnf51DxdE6HXYDIV UQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3tejaejfrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 11:56:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1696272975; bh=3ayweUwsanfCzjdxhkm9At5M457gbx53+Nu5zigbpug=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=G20zLGC03Oy5GGEjGI2oyCFXeMhxepDG7nI3wDKjQTOjy+jOUK7HpeWuaMEObCRJU
         crOSZ609KpAMSPtwenfkkuCmifoACCrTyb8N3Q3CU7dBmu0Bmqk3OOprZjY0Y4TMqH
         s86AjFmLhA9OqqSW5cok4X1j0PuhjeRBROsPDhYtzWcK2j7G1hBPKv5QmscA2rnU0h
         vd6Ngrf7MNbvLbwtop2ZRmwVGP/asVeHmhs8ENR04l8kPkPhVFe9dePziGBtO+yg1O
         v7BWrcp3yvdc9BieXPh15YNb6NOgSRnOM92cdyxJ/dTcwTooC/av/Vr3HPit4XbVVX
         ZXNAQHv8NvTaw==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EE0F9401B8;
        Mon,  2 Oct 2023 18:56:14 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 237DDA0077;
        Mon,  2 Oct 2023 18:56:14 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=LRv9qSwi;
        dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7250F40132;
        Mon,  2 Oct 2023 18:56:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZjYgucm8aWaSCIKqFzKzuFl6O98sx1r+P3l/FGsqIm/aT3U1pwxHGGm0Yl4cQRMFp9OgAnmuuKjJJdHzS4UeCU7xgTJLu35tzzkzSs6JGT5aiR83J0t1txcFsjyUuH6WfuN69D3vE5/oYoJmjiiR4TKIic4LFix1dXYBrOFUEfFkAPETJPq6ceUc+2+0VmozOLD1jk+xZb44EqhhCIGmc+zXXlp5xY9kUwfh/F4+gFYJV677NGlsDYvPm+GT10dwO2zGAwYr6Q7pRmOzgt1rCvnzIC7WRG3nKQWd8JQmN0LH57LT1mm+frNmwulQA8TajlBtp7o/qd3zu+u9mcfsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ayweUwsanfCzjdxhkm9At5M457gbx53+Nu5zigbpug=;
 b=WxhwhpD0T5TgtvhOd0/7a3CH9Y16aVMOoYaCI6F2uLhOK8uyqppULkLiSxA95LyQt6NYZ7FkkS+A6CStGswSlE0NJu9vdLS+jpro+zAD7ZANYD5vbdnWcw3tOseXce7HkNz6eEJlttqyXUAXRorUzIm1qOD/O0O6Sw+nV36nbHhyootZK297Wknv+qz03xLxqkAN2CWVXvDwapQcFVrJ8emdmYtfZx42CG9PdMBtAhFQlyZA9s82EUahgiM01EP12o5KJbOYR3PnokXA6SQylym+hDvRkFGmyWonro3cACbD+R4MJ0hAAxdkcjvHfV+Rg+k505IpLdKrakOpAKhA/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ayweUwsanfCzjdxhkm9At5M457gbx53+Nu5zigbpug=;
 b=LRv9qSwiK5oFc57GLVDnJYEOOhmAtfXDeDdl4+IyTXlrQDbg002hVlZfY/gdgrkY53JG6aSSs90OYnq/cGiIS2F4Ma4lErODs1gEJRZllWK0o699yhXdqNTVwm/eGnvseyu7fuFlq3KWonTPKG5D8h8aHrvjIirHbEyyg9z0EA8=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB5891.namprd12.prod.outlook.com (2603:10b6:8:67::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 2 Oct
 2023 18:56:05 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f%5]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 18:56:05 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
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
Thread-Index: AQHZzuBFIbiQId3K7UqIXmJcc9s6yK/sa62AgAQHiICAAPALAIAFqBsAgABumgCAABksgIAETzCAgABxe4CAA/1PgIAB1kOAgAAwoICAACr9gIABTioAgAA6OYCAIbObgIARZ3gA
Date:   Mon, 2 Oct 2023 18:56:04 +0000
Message-ID: <20231002185606.eumc37ezthov7uge@synopsys.com>
References: <cf0227c8-cd02-81b6-9e13-2e7fe6f505f2@kernel.org>
 <20230826015257.mbogiefsbz5474ft@synopsys.com>
 <afd4843b-427a-8535-78e2-f81879378371@linaro.org>
 <969988f6-f01f-0e31-6a98-7d02c5a3a4ad@quicinc.com>
 <20230830013739.srnh2uyhly66yvu2@synopsys.com>
 <d30a8d6a-236a-b6eb-76d7-115cc9950ce1@quicinc.com>
 <6f70a710-c409-23c0-890b-370ccd23e088@linaro.org>
 <20230831030134.z46fjwyr6edl3t7x@synopsys.com>
 <cea3472a-e9f7-39cb-419c-d042b3bf0682@linaro.org>
 <63c9ced1-6204-88e9-1dae-2979388bbc67@quicinc.com>
In-Reply-To: <63c9ced1-6204-88e9-1dae-2979388bbc67@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB5891:EE_
x-ms-office365-filtering-correlation-id: f4bd7899-b758-4e2d-159a-08dbc3793aef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ge/aXc8AOapV7AkIqYYrJvxpwsSquZDZGW9gkasAY25+kzp6XbGJwgHCDOZdmuBnOqar4LFa9JXNO79IbcK43T7JE9dCj8BwJU7SCz4tDbideFr0YXfbvaGzulcj+6ab+B5X7GqIGQUhA2ZH9kNU4zTJcKYm9jM82hkweLWvzzcx/9R6BxtwroNTIYxv4MAyVVu3WMz8cDdUSn9QOGcd03NSN7L5/Mafff4mfNKNxRytGMaZcPlC3cL7N5IQ30kJ8G4NnM4Wj4eKZnTYP0wRle3Wkb0aOM6E2T3pze11FZNP6P8GqjuhtpiZIMZhoSX0iYZv/NMXISRuEOJUEOLctl7iU6+TbecwqhPcy+/JgK+KK6226HNlrHOrKiRCr41UoqBFXeCwVJ8RXSK+t1y3ErRqHRn59oLKC25bIJl4b5LiIEH2Ux1+c3cn6ceifrIDB41ctYFSeg7OFoXkTSGAilwnuf7kFg/F/I9hjLzebykVE8uHva1XZ4ofnxrdZ32GChx2hLQul9pjLEFFCU+ia6oRKP+fVxaAY5KhmAYXG+luoep8lcYPGOY+A3YW8e1TT2wcBQ5CUvvQCwimbaL6l6W4VzMvopInnmuAyqTjU6U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(86362001)(1076003)(66556008)(6486002)(53546011)(6506007)(2616005)(122000001)(71200400001)(38100700002)(15650500001)(26005)(7416002)(83380400001)(2906002)(8936002)(4326008)(8676002)(41300700001)(478600001)(5660300002)(36756003)(54906003)(66946007)(66476007)(6512007)(66446008)(966005)(64756008)(38070700005)(6916009)(76116006)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDNnNHRGTVVyYnVUK3l0Rms2UlNsUTltS2Zibkl3eG01aVRJamtaazdMRzFx?=
 =?utf-8?B?WE5zNjYzR0JrV1ZnVXdnTGttbEJCM3lSaTgrZklralBpNGhDQU40cG9FS1pS?=
 =?utf-8?B?b1h3bmRyREtlRU5ZOHZUemxMaWE1aWg3N0RTSDArNFZWSGYyK0N3dUNVUlh4?=
 =?utf-8?B?bk5wYmZINFAycnRiQzNhWkJMYUlIT1RYVldhK2VEdGRvY1BUSVkwaEFTN2g1?=
 =?utf-8?B?LytJTUNhVC84ckgyZjE0N0pNV1RWNzhvMGErdWZ5UjRlWmpZMUowL2V1ZFJJ?=
 =?utf-8?B?Nkl3V2U2SG41Y2dmRmlJVE41TW8zWFZtbjhqV1NJRHVWSEhVVEFCZTNHWUdo?=
 =?utf-8?B?NGxEZ3JFN3hXeFVZQVQ1bjdGUS9mQUhBU2RpYkF5K0RJVW9lRnhNUThVS2R2?=
 =?utf-8?B?bG1TSXdxdDRhS2s4bTJxeTBKUlhLd0Zya3dWNm9neW9NNGU5eU9tbjZDbHQr?=
 =?utf-8?B?cjBtV0tVL2RjYjdpelZhNDZyUDRCb0VoeVllOGo5NmxSYmIyN25yTmw2TGpI?=
 =?utf-8?B?NFBFR00weFdPV0VvNkovMEptYkdrckJhMDgxdEF5VThqaTJTRzB5YmR3elhO?=
 =?utf-8?B?QnV2TDlUSXo5RmdVVUxMeC91c1lKeGdQd295UWNiaU5sUU5iNjM2ampmNitq?=
 =?utf-8?B?NlI3QkY0QnNtcTFwTWxDUUJNaGhHSmhQK05QOXZhb2pkcjJzMktTaFJabUY2?=
 =?utf-8?B?SjNJNW1UWGF0VkJYZkNlY25FT05Na3A0cVVBL29UaUxLdmFxZ2R1VnoySWtS?=
 =?utf-8?B?VXhySnRZRGZSRFNtemtpd05KUjlHUmFxd051ekhXc216dDRucmRWVnpieU9o?=
 =?utf-8?B?aXg3Z09hbkcyaHFUUlBBbHFwMFd2RUdROW9Yb0VWTzV1OHdMaTNaWnd4R2N5?=
 =?utf-8?B?c2pzbjBqTFlCSkxLVzF4THVQTWxpY1M2RkxqeTMwR1Z0WFZlNTRaRkU3cE51?=
 =?utf-8?B?cWN0MjV0ejU5ZHd5NzB4K1pHQXRvS01BNkI2TVNodjFNU1JycGpNa3BKcUVy?=
 =?utf-8?B?VS8xcEJOSjJwNm52VStNa2RFSnpPd1EvSncrdjZZN2ptV2pNdS9DTnlHZENO?=
 =?utf-8?B?VjQwTzk0blMwRStYaVZuV2VQRno4VmFNVTdRU1VjaHBpcUEvcHFIejdTN3hG?=
 =?utf-8?B?U2w5MlljUGFPU2ZieEFSYWhCdVlzV0Z5RXVOSDNmdUZOU0pwZTFSQS8xd29m?=
 =?utf-8?B?czZrNjlHMmlaWGh4aTJvZ283YWFEY0J5cDhBcXRNU0tjRVZlRHBQdERuMktN?=
 =?utf-8?B?RGUvUldjTXFRNFBWMGtjTjUyWTR5bzg2L21hVkl3UUZJTWtmOU0zWTcrMFdO?=
 =?utf-8?B?Q3JCVUV0QzFZdU14b0xWQlB1MWpzNXlxd1VNTGpST2RoSGd6bXYxZVFhd0pE?=
 =?utf-8?B?SkZGbmtYeVlCZHF1allZL0RXelRFU0hoV01zcWJvREJsRkRmb2pKYit3a0ZY?=
 =?utf-8?B?ZUpXandnR2VsNGVjeEVNdDc5WTJxeTNRSHpyWnc4WnNPK2U1NXI4OUN2TEVo?=
 =?utf-8?B?cjVYU0JZNnpreXhlVFVxMkRYU2d2RU9VaUl6bHI1c3RocE8xK0tYWElvNndI?=
 =?utf-8?B?T09lSnNlaktpUUxRaTE3NnFOVmpSWUZOUDAxcVZzMDZrMVVHM0dEY0Q0Qnlq?=
 =?utf-8?B?cVc4aWhOd3Z1dEN6UUFNSTkyVlZENnNpQVlzYVpqdi9PMm5lQ29UODBybHRH?=
 =?utf-8?B?NFo5Q1RlVXdvM3R0RW9mNk1ac3AxWUlkbGN5SUo3RjIvaGFBdG15RVFLMXA4?=
 =?utf-8?B?U2lReTBXRGg1VHVmM2FRTEdLZ1ZLbnVWa2pCT1VHOWhPdHBFQldFT1NrQkdk?=
 =?utf-8?B?emtPOWtHSjRKQTZMT3dpZHFVQmVMVVFDWjlUMHNmbW9RTnRRTHYxUVJFK3J0?=
 =?utf-8?B?bk5xQ09KOEdvR3hEaGFxdG9rdkdrMHRnSlFUTnAxYzYrRC9LWXJhVDc4azFW?=
 =?utf-8?B?NGlIZ1BENTZ4S0d6azJHS3pYdFFuYktkR0FFdlF6R3BaSzRDcVFPZ3lpK3Nl?=
 =?utf-8?B?THlFeGRGaU1sc0VZUmp2bzNJT0RzQjlLUmFXRXpmSnpDUzM1VHdtNGlma1Qr?=
 =?utf-8?B?UnFMNGVBZUtsOU43T0RudkhySitOUW1Ram4wMVJhaDdkd0V4UlkzZC9EclNY?=
 =?utf-8?B?eHo2eTFXS3U3YkRpTlVaVjNSY0JCaW1ZNW1xNnpZODJWQzh1M0JSZFh0NkJT?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DC9BFE18EFAA64BACCA2EA5524165AF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SGU0TlVTM1YrbTdmMlFyLzdkYzI4NCtPYjcwL0NaYTNMb0xEOGM5Q2M5aEo4?=
 =?utf-8?B?WlF2VjNQZVhOVlpNK3RjMGdsS3NIbzMwUDRLTERQbHJsL1pqOE5SNFZPN05y?=
 =?utf-8?B?M1RBWi9uYnVIY3R5TXRWODM0K1lWemF2Nlo2VEZ4bVE5eG5TcFNqTUFaTktC?=
 =?utf-8?B?NWNDQzlzVm1BU2wwYXpQSTZSVFZxSHhXZVk2eDZwV2pOSGZpZXNYV2Zpd2h5?=
 =?utf-8?B?STR6bk4xc09ldzZjSVk0L09XakI1QStxUnRMMExLK3BENHRZaUlJc2tKL3A0?=
 =?utf-8?B?MGdNcnZDRncxVmRtN1lUUUVjZlFXbk16ekFSMkdkdFZjQThJSnIwS2phcXVO?=
 =?utf-8?B?djl6bXVDUGxSS0Q1ajNvV0l4YmlKVHF0UGE2YVd2QUY4aUI2T3JkRTNSbkhh?=
 =?utf-8?B?eGxSczFzRHFaTVNCK3VjOC81WWx5R3hwNGZxWi9RT0c3cVUwSEpEQno2dEtO?=
 =?utf-8?B?YytzcmZxampMelhMMkhyTGd0dENCb1hWWnNsZm1xSmxCNHgzdWd4TjhpU0g0?=
 =?utf-8?B?WnErUzBVOHZTb2tmRnNKMzlOaGhTSkFMZFdtbEtEYmhlbG13TTJWOGh5N1Zx?=
 =?utf-8?B?anVGVkRzODdVMFVCWGVtQ0NkcUdmOHhiQVJhV0lsRE9mVUhLdWZiNWRiUTVm?=
 =?utf-8?B?SFNlczNVS0FTRmlqYU95U09SWHlnUnVybUxTYXVEZmxlWExzOUpvNjdkU21l?=
 =?utf-8?B?T1BnNGpOcVMvSW5MMWJzbHJYRG8vTjJpamZlYVJkSFdyRHk2YlRxcnJ3dU5E?=
 =?utf-8?B?SnM3U1ZBZ05hME1nTVgxT3l4Q1BEbGRTa0c0MURYRFpIQk9JZ3NRYmRrSjlM?=
 =?utf-8?B?MnRpeStuamNyVzczN1ZvV2F6cFpUbGt2djU1cWxUWDdBdDZiOVNBVEw5UnFi?=
 =?utf-8?B?R3QrYkJpYVd5OGVhUm00cC9Wa2dNVExRNmFudVBSOVViTS9JTElza2dzV0JX?=
 =?utf-8?B?NnNvallUVEF2VHpkbUxFc0xva2xPRXVnNVdhdzhDUkwrNmJsWklkenNYZkZx?=
 =?utf-8?B?ZGN6TGtaTGMvL2NTa1p2Mi80K2pkcm9KNUxXTmNXZWNOQ2pNb2ZGNGFKTHlH?=
 =?utf-8?B?bnBNSmNlQjUzeXkzMFQzWjdHQ2daYURqcjRHNy8wenpLYkk0UE9TV0dYVTdV?=
 =?utf-8?B?K1lHa0x5aWRyUlFZbkFkRGNvRWd5dXJXMUVaeWlQWERXQitkVFkrRzBqUEMw?=
 =?utf-8?B?bm90ZHd0cU0xT0Nna09xRVN1Q0p3MGMwMjJWVng1VWZKSE1hcjR0Zm5sK0Qz?=
 =?utf-8?Q?Lyo3W3oSAP/PAfG?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bd7899-b758-4e2d-159a-08dbc3793aef
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 18:56:04.9884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3z7c9ozBI384wpW1FqsaUprYE3eUgtn0TFbKPboSFCWuHjd6r7UzLd9+wztIP9rNaiadBnjh6trKfbvQfbV4ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5891
X-Proofpoint-GUID: C5xVDoJhzFXli0bqUSqmufI9Ixi1Yn0U
X-Proofpoint-ORIG-GUID: C5xVDoJhzFXli0bqUSqmufI9Ixi1Yn0U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_13,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310020145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBTZXAgMjEsIDIwMjMsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gDQo+IA0KPiBPbiA4
LzMwLzIwMjMgMTE6MjkgUE0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4gT24gMzEv
MDgvMjAyMyAwNTowMSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBBdWcgMzAs
IDIwMjMsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4gPiA+IE9uIDMwLzA4LzIwMjMg
MDY6MzEsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBPbiA4LzI5LzIwMjMgNjozNyBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gPiA+
ID4gSnVzdCB3YW50IHRvIGNsYXJpZnksIHRoZXJlIGFyZSBkd2MzIHByb3BlcnRpZXMgYW5kIHRo
ZXJlIGFyZSBkdCBiaW5kaW5nDQo+ID4gPiA+ID4gPiBwcm9wZXJ0aWVzLiBPZnRlbiB0aGUgY2Fz
ZSB0aGF0IGR0IGJpbmRpbmcgbWF0Y2hlcyAxLXRvLTEgd2l0aCBkd2MzDQo+ID4gPiA+ID4gPiBk
cml2ZXIgcHJvcGVydHkuIE5vdywgd2UgbmVlZCB0byBlbmhhbmNlIHRoZSBjaGVja2VycyBzbyB0
aGF0IHRoZSBkd2MzDQo+ID4gPiA+ID4gPiBkcml2ZXIgcHJvcGVydHkgdG8gbWF0Y2ggY2FzZXMg
d2hlcmUgaXQgaXMgcGxhdGZvcm0gc3BlY2lmaWMgYW5kIHRocm91Z2gNCj4gPiA+ID4gPiA+IGNv
bXBhdGlibGUgc3RyaW5nLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhh
bmsgeW91IGZvciB0aGUgY2xhcmlmaWNhdGlvbiBUaGluaC4NCj4gPiA+ID4gPiBUbyBjb25maXJt
LCB3ZSB3b3VsZCBuZWVkIHRvIG1vZGlmeSB0aGUgZHJpdmVyIHRvIHBhcnNlIGEgbmV3IGNvbXBh
dGlibGUNCj4gPiA+ID4gPiBzdHJpbmcgKHNheSAic25wcyxkd2MzLWV4dC13YWtldXAiKSBhbmQg
YWRkIC5kYXRhIGZpZWxkIHNvIHRoYXQgdGhlDQo+ID4gPiA+ID4gZHJpdmVyIGlzIGF3YXJlIHRo
YXQgdGhpcyBwYXJ0aWN1bGFyIHBsYXRmb3JtIHN1cHBvcnRzIGV4dGVybmFsIHdha2V1cA0KPiA+
ID4gPiA+IGRldGVjdGlvbi5SaWdodCA/DQo+ID4gPiA+IA0KPiA+ID4gPiBObywgaXQncyBub3Qg
dGhlbiBwbGF0Zm9ybSBzcGVjaWZpYy4gWW91IHNhaWQgaXQgZGVwZW5kcyBvbiBlYWNoDQo+ID4g
PiA+IHBsYXRmb3JtLiBQbGF0Zm9ybSBpcyBRdWFsY29tbSBTTTg0NTAgZm9yIGV4YW1wbGUuDQo+
ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBIaSBFbHNvbiwNCj4gPiA+IA0KPiA+ID4gVXNlIHRoZSBj
b21wYXRpYmxlIHN0cmluZyBvZiB5b3VyIHBsYXRmb3JtLg0KPiA+ID4gDQo+ID4gPiBlLmcuDQo+
ID4gPiBpZiAoZGV2LT5vZl9ub2RlKSB7DQo+ID4gPiAJc3RydWN0IGRldmljZV9ub2RlICpwYXJl
bnQgPSBvZl9nZXRfcGFyZW50KGRldi0+b2Zfbm9kZSk7DQo+ID4gPiANCj4gPiA+IAlkd2MtPm5v
X2Rpc2Nvbm5lY3Rfb25fdXNiX3N1c3BlbmQgPQ0KPiA+ID4gCQlvZl9kZXZpY2VfaXNfY29tcGF0
aWJsZShwYXJlbnQsICJxY29tLHlvdXItY29tcGF0aWJsZS1zdHJpbmciKSB8fA0KPiA+ID4gCQlv
Zl9kZXZpY2VfaXNfY29tcGF0aWJsZShwYXJlbnQsICJzb21lLW90aGVyLXBsYXRmb3JtIik7DQo+
ID4gPiB9DQo+ID4gPiANCj4gPiA+IFlvdSBuZWVkIHRvIGVuaGFuY2UgZHdjM19nZXRfcHJvcGVy
dGllcygpLiBUaGlzIG1heSBnZXQgYmlnIGFzIGR3YzMgYWRkcw0KPiA+ID4gbW9yZSBwcm9wZXJ0
aWVzLiBQZXJoYXBzIHlvdSBjYW4gaGVscCBjb21lIHVwIHdpdGggaWRlYXMgdG8ga2VlcCB0aGlz
DQo+ID4gPiBjbGVhbi4gUGVyaGFwcyB3ZSBjYW4gc2VwYXJhdGUgdGhpcyBvdXQgb2YgZHdjMyBj
b3JlLmM/DQo+IA0KPiBISSBUaGluaA0KPiANCj4gQXBvbG9naWVzIGZvciB0aGUgZGVsYXllZCBy
ZXNwb25zZS4NCj4gU2VyaWVzIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3Bh
dGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtdXNiL2NvdmVyLzE2NTUwOTQ2NTQtMjQw
NTItMS1naXQtc2VuZC1lbWFpbC1xdWljX2tyaXNrdXJhQHF1aWNpbmMuY29tL19fOyEhQTRGMlI5
R19wZyFZR2xWeTdObzk4emZFTS1YNWlXUmhJVUotZ0pFSm5fZ2JUUjRrMTJhdnpFTlYxVFhmN2N3
SkxaVWV6WXpBVS1ybkhJYmJxQTFVV00wSUUwUi10NVNNTVRKTHdMWiQNCj4gZnJvbSBLcmlzaG5h
IEssIGludHJvZHVjZWQgYSBkdCBwcm9wZXJ0eSAnd2FrZXVwLXNvdXJjZScgd2hpY2ggaW5kaWNh
dGVzIGENCj4gcGxhdGZvcm1zIGNhcGFiaWxpdHkgdG8gaGFuZGxlIHdha2V1cCBpbnRlcnJ1cHRz
LiBCYXNlZCBvbiB0aGlzIHByb3BlcnR5LA0KPiBnbHVlIGRyaXZlcnMgY2FuIGluZm9ybSBkd2Mz
IGNvcmUgdGhhdCB0aGUgZGV2aWNlIGlzIHdha2V1cCBjYXBhYmxlIHRocm91Z2gNCj4gZGV2aWNl
X2luaXRfd2FrZXVwKCkuIEZvciBleGFtcGxlIGR3YzMtcWNvbSBkcml2ZXIgaW5mb3JtcyBpdCBs
aWtlIGJlbG93IGFzDQo+IHBlciB0aGUgaW1wbGVtZW50YXRpb24gZG9uZSBpbiB0aGUgYWJvdmUg
c2VyaWVzDQo+IA0KPiAJd2FrZXVwX3NvdXJjZSA9IG9mX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYt
Pm9mX25vZGUsICJ3YWtldXAtc291cmNlIik7DQo+IAlkZXZpY2VfaW5pdF93YWtldXAoJnBkZXYt
PmRldiwgd2FrZXVwX3NvdXJjZSk7DQo+IAlkZXZpY2VfaW5pdF93YWtldXAoJnFjb20tPmR3YzMt
PmRldiwgd2FrZXVwX3NvdXJjZSk7DQo+IA0KPiBUaGUgZHdjMyBjb3JlIG5vdyBjYW4gYWNjZXNz
IHRoaXMgaW5mbyB0aHJvdWdoIGRldmljZV9tYXlfd2FrZXVwKGR3Yy0+ZGV2KQ0KPiB3aGlsZSBj
aGVja2luZyBmb3IgYnVzIHN1c3BlbmQgc2NlbmFyaW8gdG8ga25vdyB3aGV0aGVyIHRoZSBwbGF0
Zm9ybSBpcw0KPiBjYXBhYmxlIG9mIGRldGVjdGluZyB3YWtldXAuDQo+IA0KPiBQbGVhc2UgbGV0
IG1lIGtub3cgeW91ciB0aG91Z2h0cyBvbiB0aGlzIGFwcHJvYWNoLg0KPiANCg0KSGkgRWxzb24s
DQoNCkkgdGhpbmsgdGhhdCBpdCBtYXkgbm90IHdvcmsgZm9yIGV2ZXJ5b25lLiBTb21lIHBsYXRm
b3JtcyBtYXkgaW5kaWNhdGUNCndha2V1cC1zb3VyY2UgYnV0IHNob3VsZCBvbmx5IGJlIGFwcGxp
Y2FibGUgaW4gc2VsZWN0ZWQgc2NlbmFyaW9zLg0KKGUuZy4gUm9nZXIncyBwbGF0Zm9ybSB3YXMg
b25seSBpbnRlbmRlZCB0byBrZWVwIGNvbm5lY3Qgb24gc3VzcGVuZCkNCg0KQWxzbywgaG93IHdp
bGwgeW91IGRpc2FibGUgaXQgZm9yIGNlcnRhaW4gcGxhdGZvcm1zPyBQcm9iYWJseSB3aWxsIG5l
ZWQNCnRvIHVzZSBjb21wYXRpYmxlIHN0cmluZyB0aGVuIHRvby4NCg0KVGhhbmtzLA0KVGhpbmg=
