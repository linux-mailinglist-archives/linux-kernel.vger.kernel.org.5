Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83297D18CF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjJTWFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjJTWFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:05:30 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF26EA3;
        Fri, 20 Oct 2023 15:05:25 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KHnofi022737;
        Fri, 20 Oct 2023 15:05:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=9LIe3TnytkpJgV/+6Ig+kQlCAxNmTO7llP9BQdY3SJQ=;
 b=IdaX0F8EXQayZ6P9qXHdHO+ZGPLn15hHmLXxliOyNXItvMf0GpEGJudZyL855120GEAr
 /5vDyEg4t3TwhYQB5G47swSKHBHEjgPsuFNmsO04WRDYR3du9wZiHBZMF30GHJCm4AJM
 AhcxF/8iXlBKafYEqSyN6TLomf9nmEN37Kj+HOGUwUu6SE08Onka0V3QdW9Pdspjk/q4
 IOmwjgV8f0yukAiLjROQ5LYww3YeF9QyjPi+SmgEm0jiXwZ4SiTAMvjweBjqDH4+Gjr3
 NakpmrD4/kUQt1tsztwHNN7tB+uiRs5FvPhxEnoD9gTcMA1kSQ1T8vv2GFSOAPqvM/ot EA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3tubyc6gvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 15:05:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1697839499; bh=9LIe3TnytkpJgV/+6Ig+kQlCAxNmTO7llP9BQdY3SJQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=dhQBprQ4dmi2NOGr/DbF2V3lkVSMADIRoLxW14Kigq7JhqEOQTmZi8i/zO53RX10Z
         kwnAYQayJa+LUOyZpMIGqJ/9sUNMtQbywlDZbFK7S8GfZNRHrwBNsphoGXv/NVuQao
         yT8nFNckOkdynBxes2u9LtYNY79y9sC5mlYegRhiIX6JUDJHYb9XphI7y5wQi5oSZd
         o0UOCiDOTQwI2hUXBKCwT+pD+7pHZGkeg/qZHNnQoxtthifzJioIj6BHjvLmWI2EbY
         VA53z80fgfzxbF4d6JVhnKBREFrZ/PLYyTD1gbg7sLLHfk3xM5z5+l1Hqjk02mcxn5
         96VtshbPjzrow==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BEF9C40493;
        Fri, 20 Oct 2023 22:04:58 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 70CDAA006D;
        Fri, 20 Oct 2023 22:04:53 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=p0cL5l4+;
        dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3822E4013A;
        Fri, 20 Oct 2023 22:04:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvgEhxya2iJzjTqzEpsYdT8n1AlaiXyxx3r00oGc3j33McB2RXX5Wc7/EY8R23y+ILNPv93ilHIH0bI5KZYVMP4uHsH1uxLvXrsMmDBS6t2GjKIoXW8AW7HrLtYnK8EB8At1ykaugldPfJKcDRvcGF6/+FznUORnQXOGqykqxB5rP4cXB/6ejpCwQ39WLa98KJFarEWOnkj0HAcgn5mBkP47vAJO5OnRSHEnXNok619TkFfHqTy0MF10orfzEwC16wjbwBJizGwfS6TrLvFeeWYL6hQipSw8z4O9MI1zul2YA+HI0XnOh4QMiDonPtD+4YM53+u55/YesQctvlsTzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LIe3TnytkpJgV/+6Ig+kQlCAxNmTO7llP9BQdY3SJQ=;
 b=YdTlVtPCWqTcM10qHzxWVsE9otdZLyY6rE5ICvTDZmBcni+hICQZI5JKX1/0IpnMfUk5An5jAAdEEm+pTyvZK2HTPg804fJT9x0lUU2lPdVNDAZfWqGRxpyySiXpJOczMzRtyn9D0YNXYqURReU3KphOcF+M6VwSDUPNue02h/yJjko65exCJTWRjNxy5chV/c4cXtLGbuUX45chdxHjzCCc/OGtXs3QqYEVnjzqfUrz1dDOqWTJCg3fbc13S725xfKQRc4XnzllmNTzi7P8xEv49Ep0w4eHOXsBGHnhC0b2r7MBrjdzNyhih5pA7vICU8qzTC/JkvlKAramUqKxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LIe3TnytkpJgV/+6Ig+kQlCAxNmTO7llP9BQdY3SJQ=;
 b=p0cL5l4+3rkv9/XHPfubtfEIRnBp6D5tPNTIba8oTaapEtPKs4GxHXkyWPLkApC7i6xiVV/QoQkXwy2WNsfpSR3VmxEbXQ9y7aAFGsVHxj5OQR+mI7lD+EDIochCa4+K05lLY+xlQEK+HEB3+z2Nrl6c/k5EGaeydpTzWC3fCLQ=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 22:04:49 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b63e:67e6:b5fe:a8cb]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b63e:67e6:b5fe:a8cb%3]) with mapi id 15.20.6907.021; Fri, 20 Oct 2023
 22:04:48 +0000
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
Subject: Re: [PATCH 00/12] usb: dwc3: qcom: Flatten dwc3 structure
Thread-Topic: [PATCH 00/12] usb: dwc3: qcom: Flatten dwc3 structure
Thread-Index: AQHaAKenc81F8nNt+U2mmKy/VU09wLBTQX8A
Date:   Fri, 20 Oct 2023 22:04:48 +0000
Message-ID: <20231020220432.sutkinakkd6ncuej@synopsys.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
In-Reply-To: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB5181:EE_
x-ms-office365-filtering-correlation-id: b3f20c83-6658-4b2c-a814-08dbd1b89381
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lpUSSpNTJ9/8druCQgq1AHG3d1zLJsEdFGEbH0aZwyaSRwXtKge7Sv/CvAE2DCj6o0+SiK8/6uz71UL9KE0mrHO+YFi8yrs6ejR74qarkz96HBIJ9iw/jK18XrIPdiJbwOb8oq32VU0uqOgVrDmaXy5gisnZhQHY+8Yl+n/wiJ3ddz4GlLMseyp4XL/IcPSQewCZU1gDERghC7nZ8xRYf1jirjkxec9yhry1NTVeVZIfawrhirTweAxCqRIDFkMg2KMMMga3Vpuv/K627FRrHEFNCAcn+G/YQDd9O8Ykc3sFMVevIoTgH5OSmcpIS7RYxYZdBA5IzoAaEp9YjZy6t88Ufz9jw92hL7w8rKlLFqj01W9MwiEwrinokHKA33Ez4n/sus4zg1jfqi86JuIdZLoSFtEuG7HsL3E68K0dFXXW9phHnA/yxdSrfAl43NoYQebIl7s4ugAzc/SAz6FqO6nc3eKk3545Cm40CsitnTm8V0U3D4P72vLtT72iDIvFFHWVcDlId5kvJ+6EhZgz8i+Ws39lTpVKAG77ikof4IMsYri4LdOsEj459NeWxZ3GPY1vACu8hAkYtQKVtcN2xsZdCM+YxJq/BYMLrl4HcIQwJkB98lBzqfrpn086Heea
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(6916009)(316002)(122000001)(6486002)(86362001)(36756003)(4326008)(8936002)(7416002)(5660300002)(83380400001)(8676002)(41300700001)(2906002)(71200400001)(38100700002)(6512007)(2616005)(1076003)(6506007)(26005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFBLaDlUZmFRdmpxdEM2Vi92N1JwZER0a2dTVkRwYnFQR3lHc214S0FNSXJy?=
 =?utf-8?B?UVYzSmhMblhFZUkwU01pUWtvbXFFQWJDYVdHWmVyOUJxTFoyKzdnYzRpY2o2?=
 =?utf-8?B?cVhmcUJndjhzUVBqUG1rNkRqUnBwR042TlJUcS96ZzZua1UrR1RUQkNWNU83?=
 =?utf-8?B?bUc5V2dHNXF4M3E1YXp0MXdpQmgwVzhyeWFkM2NyajUwclEwdStHdzVRcnE0?=
 =?utf-8?B?bWdEdkQyb2ZtUkNtY2U1SkdzT2d4aGo3YlZvYm8rOW5HRzVXd0djZW5ycUcw?=
 =?utf-8?B?bjRsbDVId04wOURZRGdqSUZhZmVIRkpQYXJ6K1F3WVhYOXYzRSs3N3VjL1E0?=
 =?utf-8?B?UVExYmZENDR3R1Q0c1JTakQ3S1hhNFBROUcvZ0VEUzhwdEg5V1lONDVaRUlZ?=
 =?utf-8?B?eUFIbDVTUnRBUW83c1ZOblllaDM4bkNpdkpVeVlVRGc5RFAxaDR1aTltUGw1?=
 =?utf-8?B?MkExNllSeVNHMERtM3JJTmoxQ2xScVZQN29VUUNzZlV0RUZGQ29rcS8wbnV6?=
 =?utf-8?B?dnY4QVpmYzNNRG54c2tkRDVUcjFMbTlnV0prK2oyNTcyUlFyRC9nOTY2ZnF6?=
 =?utf-8?B?bmVVZDJ5N0ZIYUh3TkEvVGNVYjA1T245TGNqOGtJYjFTbjJIdXI3TTdXMjFR?=
 =?utf-8?B?ZHRybjBQdkltbEdFclJIbFdvSGp4ZU9JYTZZY0RPeVpHQXRUWWJma3FJTmFB?=
 =?utf-8?B?QWlIeWJNOU0zVTRBZ2lnUTBaZm9kT0RydXgyVnkrcU8rMG5wemZOWE12SW56?=
 =?utf-8?B?OXkyUVA3eTZWbVpXcHRLa0lUSk4zM2MvUlJMdG5tRkdIMnJjYVZieHZCRTRa?=
 =?utf-8?B?TGZ1bW9FYXdtODhmMlJMVVZMdHlPaUVpU1B5Z3RseHRIemxlUzRnaWJZOFBn?=
 =?utf-8?B?ODFucmhOcENEMllzNUN4a0E0TXk3TXRCUnNVajFxOG02Z1lWNnZldktPK0t1?=
 =?utf-8?B?MG9kczB6ZW1GaHU0aDROaEtuSnBHb1ZZRmsrVGNLY0h1bVdWR0k2c3crK3Zo?=
 =?utf-8?B?cUFuMXJXSEc1bXhpNnRxRmI2Rk9mcmVrTndjckdhbENXVURJTnlsb3crNzFO?=
 =?utf-8?B?Zm9FVFB2c1M4OHI4dDlqL1hSdXo5MFAxOHYwNVMxYXprMUxvaWNzZ0ZTdWgr?=
 =?utf-8?B?bXFPL1RlZmdnRit0MjE5N1hRQS9hTnU4ZVk5ejdDQ0dOOHJZRlNlNnpNQS9U?=
 =?utf-8?B?dVJMYm4xczlxREJCNXVPaHI2N0tmWkZ1RFQyL0FpZWtZcEZvQmpTRVN1ZEhH?=
 =?utf-8?B?OHFoVUlwaXlTb0RlazlsTWtEcE50V01lTUM2Yy8xR3haeFVPY0RIRXd1UHM2?=
 =?utf-8?B?dFg4S1dBaWh1MGxIbExsNFRPMVNnV2c4bFZSeWlkb0hqSDZjS2QwUTdCVUZa?=
 =?utf-8?B?bjVsYm5iRmY5aDJBU1NpYWV6VGlYQUo4S3pCQ3FDOWtiZ0t3QU5Lb1ZKY1Zu?=
 =?utf-8?B?cGpHOHBwdTZFOWxXQ0wvd0ZXY3UyTDZEZit4akIvaWJvVmo2N2FVazRKWk1X?=
 =?utf-8?B?SDhhRjVydGNOZ1AwU1cvVjNPZXNuUEJSY0lPWXcwT1dKZkcvd3Noa01uYWlV?=
 =?utf-8?B?T1lqVWVwSngyMVVjQ0xLdDdPWVpDVEtxRVdPWHlyMU42ZEJqVnpxVkJubTVK?=
 =?utf-8?B?R0pIa3NwU1gwWGJNQ1IvaFhya0VkYi9paXJOM0xqSmhQOHNFVmYrRFlDcitG?=
 =?utf-8?B?c3pOMkwyL1VnM1BybDVCZkp1ZTdsNFoxbzV3clg1cXRNRVpEd0ZHcTVJNHVh?=
 =?utf-8?B?c294SjVrbm5xMnU0NmZkeE1UL3NSMjIzOUxNN2tmNmJkWVNobFpYeVdLVlF5?=
 =?utf-8?B?b0pzT0I1YmNlMll3RjZXbGs3aVgxU3JoYmNrdWNYYWlnSUQ2UUYxeXp2N1c0?=
 =?utf-8?B?NXdWeHhMRlAzVlYyc0VLYy9qY291YWZ1ZXl5a3JrRmZPZlJoL21leUR6ZjVS?=
 =?utf-8?B?ZThXTCtkYVl1NlNEdktscDU2WVNFZDhFMTE1UTllS2tsd0xQRmtEbmhiSjMx?=
 =?utf-8?B?bmtNWFkzRm94USs0WEVwYURId28yRlFVQmowbWt0OHZrY1lPTG00SFBnT0VW?=
 =?utf-8?B?b3c3d2ZkNU5qSlBaMFJ3bnRKVW90TWZReHJhK1QxNHN5TjRGeGxOckRwak9n?=
 =?utf-8?Q?I65OTiSaVhVfROzXHUAL13NL+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ECC0FE7FE9B9B4FAB2767C87099FFBE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MTVpaUE1U2VHa0xZRHpjaGphRGg5V0gwNXdqQWM0Z1l0R1JoWDduQWtUVkpV?=
 =?utf-8?B?OHNVM2xYYlJJcmE2Q0s4d3kxN0ZlM0syTDFyWUh6eURVVERSRXF3U3VPakY5?=
 =?utf-8?B?QTNoVGYyZUpjVGhIbFB5eVdQVnV6b1dlMmEwbFZNOUF5NnJBQ1VHdHhocmV3?=
 =?utf-8?B?TWY5OXZKOEtKb0tNSWUzYzVlbjlEMW94Nm1peHlSMHNKMURwMkRRY0trSHF2?=
 =?utf-8?B?Y3hHYWhsdmRHZ2MwcXpYR2FMMGRZb1RzcnNUYVhHaEpaR0M0VEUyL3F3WVli?=
 =?utf-8?B?bFYrdUIvL0hkVzRRRENaWG5udUNhMUJWQVpWVEZvVkI4TkpJdDI4VlVkZnJD?=
 =?utf-8?B?UG0rRk8rVkVEa2pYMmRud29FWkFGTVBmRFZMWW9aTWRTMEovRzNudzFvZjJz?=
 =?utf-8?B?eC8wVm1XUERQSXlhZ2k1U3NPZXNDWURiTXdkNWZTekUya0l6Szh2aWk4NFRz?=
 =?utf-8?B?SjAzNTI0aS9MenBMKzdxZjlHRzlMUUd6WnExNVRQZVc4b0k1MXlrTm4yZm5E?=
 =?utf-8?B?cFdROERiTW9oOGl0RDQvZW1jdGNLbzJxRXhmbHE1Y05mdGwySHpaZndjNFdJ?=
 =?utf-8?B?cTJ3eHIxQ1I2RnhKMkxKNGJPd1UzUWl3RUYxR21QRHNDc3Q1Tm5tUXJPZTla?=
 =?utf-8?B?RXlZYTFJL1BoQmFrUWdqU3NIblFFSjBpR2xMakQ1TUliT2tFdG51L3hjLys5?=
 =?utf-8?B?UmltUThWWlJBeWtiNWxVY3ZjcnFZSThxRkpGVVFrQ0V1d0N4cEMvQ25IZ0pU?=
 =?utf-8?B?d2lrUzRsempLVDJScXR1YU1zNVBIaHVVOTRyL0RMSXh1cGlNUjc3bUk2eWZw?=
 =?utf-8?B?YlREUmtjR3UwNUZQVmQvV2tpWU5Gblc4QllDZkNqYkJtT2tWYkxLMzdYN1ZC?=
 =?utf-8?B?bWdJTXFZb3BrSkRrZldpRmxwbE1HRlM4VGxCNEtCNTNGR0tyZEhGWGZ5ZTNk?=
 =?utf-8?B?YmpSeGwyR3l6b3J5RHFpK1kzZ3dzcFRGbmlyanE5aUh5cXJ6KzNiNTRSbjNv?=
 =?utf-8?B?ZXBrRXdnL01NK25YMXNwcXZCMkMrb3Q5TXpNMnQ2OEZYMmZpTnBBL2d1K1ZZ?=
 =?utf-8?B?TGZTOVRyNVJKbnBFRTlQVkl0a0NuT1NyZi93ell0Y1VjK1lESlFHWitVQ0M5?=
 =?utf-8?B?RG11NlFKQmFrSjRnUzEyR1BiVWlVcUE3Qk1UdUovSU94aEJTMHozMEtPQTMv?=
 =?utf-8?B?ajB2UlBGZVVFZEtuRDFtc29GUFRZTTlPMGRJbXJkSlpmaWUyT0U4djhPWC9P?=
 =?utf-8?B?eUhiVXA0eUloZmF0K0xQNHplY1NGdURvOFZtR205T3lwYkduSXQzWGJmMTV0?=
 =?utf-8?Q?8zelC8ydmNs8GhWZmEjMXvQNPOz7bx/0II?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f20c83-6658-4b2c-a814-08dbd1b89381
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 22:04:48.1811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pLBlbBr8u6uHjvE0zTXwuney9hoaRn84PC2g5K7AaQsZ1jHXE9Kdq6K5oM0LrVg7vQ24Hf7PqHxm7NMqe6s9Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5181
X-Proofpoint-GUID: fkV-bknbQ3IpvFb7qCGp72LvVVZPIn25
X-Proofpoint-ORIG-GUID: fkV-bknbQ3IpvFb7qCGp72LvVVZPIn25
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 mlxlogscore=942 spamscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310200187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmpvcm4sDQoNCk9uIE1vbiwgT2N0IDE2LCAyMDIzLCBCam9ybiBBbmRlcnNzb24gd3JvdGU6
DQo+IFRoZSBVU0IgSVAtYmxvY2sgZm91bmQgaW4gbW9zdCBRdWFsY29tbSBwbGF0Zm9ybXMgaXMg
bW9kZWxsZWQgaW4gdGhlDQo+IExpbnV4IGtlcm5lbCBhcyAzIGRpZmZlcmVudCBpbmRlcGVuZGVu
dCBkZXZpY2UgZHJpdmVycywgYnV0IGFzIHNob3duIGJ5DQo+IHRoZSBhbHJlYWR5IGV4aXN0aW5n
IGxheWVyaW5nIHZpb2xhdGlvbnMgaW4gdGhlIFF1YWxjb21tIGdsdWUgZHJpdmVyDQo+IHRoZXkg
Y2FuIG5vdCBiZSBvcGVyYXRlZCBpbmRlcGVuZGVudGx5Lg0KPiANCj4gV2l0aCB0aGUgY3VycmVu
dCBpbXBsZW1lbnRhdGlvbiwgdGhlIGdsdWUgZHJpdmVyIHJlZ2lzdGVycyB0aGUgY29yZSBhbmQN
Cj4gaGFzIG5vIHdheSB0byBrbm93IHdoZW4gdGhpcyBpcyBkb25lLiBBcyBhIHJlc3VsdCwgZS5n
LiB0aGUgc3VzcGVuZA0KPiBjYWxsYmFja3MgbmVlZHMgdG8gZ3VhcmQgYWdhaW5zdCBOVUxMIHBv
aW50ZXIgZGVyZWZlcmVuY2VzIHdoZW4gdHJ5aW5nDQo+IHRvIHBlZWsgaW50byB0aGUgc3RydWN0
IGR3YzMgZm91bmQgaW4gdGhlIGRydmRhdGEgb2YgdGhlIGNoaWxkLg0KPiANCj4gTWlzc2luZyBm
cm9tIHRoZSB1cHN0cmVhbSBRdWFsY29tbSBVU0Igc3VwcG9ydCBpcyBoYW5kbGluZyBvZiByb2xl
DQo+IHN3aXRjaGluZywgaW4gd2hpY2ggdGhlIGdsdWUgbmVlZHMgdG8gYmUgbm90aWZpZWQgdXBv
biBEUkQgbW9kZSBjaGFuZ2VzLg0KPiBTZXZlcmFsIGF0dGVtcHRzIGhhcyBiZWVuIG1hZGUgdGhy
b3VnaCB0aGUgeWVhcnMgdG8gcmVnaXN0ZXIgY2FsbGJhY2tzDQo+IGV0YywgYnV0IHRoZXkgYWx3
YXlzIGZhbGwgc2hvcnQgd2hlbiBpdCBjb21lcyB0byBoYW5kbGluZyBvZiB0aGUgY29yZSdzDQo+
IHByb2JlIGRlZmVycmFsIG9uIHJlc291cmNlcyBldGMuDQo+IA0KPiBGdXJodGVybW9yZSwgdGhl
IERldmljZVRyZWUgYmluZGluZyBpcyBhIGRpcmVjdCByZXByZXNlbnRhdGlvbiBvZiB0aGUNCj4g
TGludXggZHJpdmVyIG1vZGVsLCBhbmQgZG9lc24ndCBuZWNlc3NhcmlseSBkZXNjcmliZSAidGhl
IFVTQiBJUC1ibG9jayIuDQo+IA0KPiBUaGlzIHNlcmllcyB0aGVyZWZvciBhdHRlbXB0cyB0byBm
bGF0dGVuIHRoZSBkcml2ZXIgc3BsaXQsIGFuZCBvcGVyYXRlDQo+IHRoZSBnbHVlIGFuZCBjb3Jl
IG91dCBvZiB0aGUgc2FtZSBwbGF0Zm9ybV9kZXZpY2UgaW5zdGFuY2UuIEFuZCBpbiBvcmRlcg0K
PiB0byBkbyB0aGlzLCB0aGUgRGV2aWNlVHJlZSByZXByZXNlbnRhdGlvbiBvZiB0aGUgSVAgYmxv
Y2sgaXMgZmxhdHRlbmVkLg0KPiANCj4gQXMgYSBzaWRlIGVmZmVjdCwgbXVjaCBvZiB0aGUgQUNQ
SSBpbnRlZ3JhdGlvbiBjb2RlIGlzIGRyb3BwZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCam9y
biBBbmRlcnNzb24gPHF1aWNfYmpvcmFuZGVAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiBCam9ybiBB
bmRlcnNzb24gKDEyKToNCj4gICAgICAgZHQtYmluZGluZ3M6IHVzYjogcWNvbSxkd2MzOiBBZGQg
cWNvbSxzYzgxODB4LWR3YzMNCj4gICAgICAgdXNiOiBkd2MzOiBxY29tOiBSZW5hbWUgZHdjMyBw
bGF0Zm9ybV9kZXZpY2UgcmVmZXJlbmNlDQo+ICAgICAgIHVzYjogZHdjMzogcWNvbTogTWVyZ2Ug
cmVzb3VyY2VzIGZyb20gdXJzX3VzYiBkZXZpY2UNCj4gICAgICAgdXNiOiBkd2MzOiBFeHBvc2Ug
Y29yZSBkcml2ZXIgYXMgbGlicmFyeQ0KPiAgICAgICB1c2I6IGR3YzM6IE92ZXJyaWRlIGVuZCBv
ZiBkd2MzIG1lbW9yeSByZXNvdXJjZQ0KPiAgICAgICB1c2I6IGR3YzM6IHFjb206IEFkZCBkd2Mz
IGNvcmUgcmVmZXJlbmNlIGluIGRyaXZlciBzdGF0ZQ0KPiAgICAgICB1c2I6IGR3YzM6IHFjb206
IEluc3RhbnRpYXRlIGR3YzMgY29yZSBkaXJlY3RseQ0KPiAgICAgICB1c2I6IGR3YzM6IHFjb206
IElubGluZSB0aGUgcXNjcmF0Y2ggY29uc3RhbnRzDQo+ICAgICAgIGR0LWJpbmRpbmdzOiB1c2I6
IHFjb20sZHdjMzogUmVuYW1lIHRvICJnbHVlIg0KPiAgICAgICBkdC1iaW5kaW5nczogdXNiOiBx
Y29tLGR3YzM6IEludHJvZHVjZSBmbGF0dGVuZWQgcWNvbSxkd2MzIGJpbmRpbmcNCj4gICAgICAg
dXNiOiBkd2MzOiBxY29tOiBGbGF0dGVuIHRoZSBRdWFsY29tbSBkd2MzIGJpbmRpbmcgYW5kIGlt
cGxlbWVudGF0aW9uDQo+ICAgICAgIGFybTY0OiBkdHM6IHFjb206IHNjODE4MHg6IGZsYXR0ZW4g
dXNiX3NlYyBub2RlDQo+IA0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3Fjb20sZHdj
My1nbHVlLnlhbWwgICAgfCA2MjYgKysrKysrKysrKysrKysrKysrKysrDQo+ICAuLi4vZGV2aWNl
dHJlZS9iaW5kaW5ncy91c2IvcWNvbSxkd2MzLnlhbWwgICAgICAgICB8IDMyMSArKysrLS0tLS0t
LQ0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3NucHMsZHdjMy55YW1sICAgICAgICAg
fCAgMTQgKy0NCj4gIC4uLi9hcm02NC9ib290L2R0cy9xY29tL3NjODE4MHgtbGVub3ZvLWZsZXgt
NWcuZHRzIHwgICA2ICstDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vc2M4MTgweC1wcmlt
dXMuZHRzICAgICAgICB8ICAgNiArLQ0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9xY29tL3NjODE4
MHguZHRzaSAgICAgICAgICAgICAgfCAgMzQgKy0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5j
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTM2ICsrKy0tDQo+ICBkcml2ZXJzL3VzYi9k
d2MzL2NvcmUuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMCArDQo+ICBkcml2ZXJz
L3VzYi9kd2MzL2R3YzMtcWNvbS5jICAgICAgICAgICAgICAgICAgICAgICB8IDMyOCArKysrKyst
LS0tLQ0KPiAgOSBmaWxlcyBjaGFuZ2VkLCAxMDU3IGluc2VydGlvbnMoKyksIDQyNCBkZWxldGlv
bnMoLSkNCj4gLS0tDQo+IGJhc2UtY29tbWl0OiA0ZDA1MTViMjM1ZGVjNzg5NTc4ZDEzNWE1ZGI1
ODZiMjVjNTg3MGNiDQo+IGNoYW5nZS1pZDogMjAyMzEwMTYtZHdjMy1yZWZhY3Rvci05MzFlM2Iw
OGE4YjkNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0gDQo+IEJqb3JuIEFuZGVyc3NvbiA8cXVp
Y19iam9yYW5kZUBxdWljaW5jLmNvbT4NCj4gDQoNCkZpcnN0IG9mIGFsbCwgdGhhbmtzIGZvciB0
aGUgd29yay4NCg0KSSBqdXN0IGRpZCBhIHF1aWNrIHJldmlldyB0aHJvdWdoIHRoZSBjaGFuZ2Vz
LCBhbmQgSSB0aGluayBpdCdzIGdyZWF0IQ0KKFRoaXMgd2lsbCBhZGRyZXNzIHNvbWUgaXNzdWVz
IEkgYWxzbyBoYXZlIHdpdGggZHdjMyBjdXJyZW50bHkgdG9vLikNCg0KQlIsDQpUaGluaA==
