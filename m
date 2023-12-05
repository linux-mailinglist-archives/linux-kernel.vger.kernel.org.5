Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A62A80443E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376263AbjLEBrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 20:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjLEBq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:46:58 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A62C101;
        Mon,  4 Dec 2023 17:47:05 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B51ToDf018331;
        Mon, 4 Dec 2023 17:47:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=jY2I+JZIrbLjzodg+YkGa4qS6zjyMaAZjgn7f/4NQQk=;
 b=TdgegSeey5oUMsXPmi5Li9m3jrmvWciOmbq2NYBQCjMzxN7GROb55uHpobjCsSVgItao
 1sk0Xc+B7BSInHcCkzipLEkPa5Fub199CyZprRQHxM7Bdk1e7Vg8qZRGR9KRPPyI7QDl
 V8yPWZLgIk4O+LTLdhXMMRu/IRFvOIZYDxPGqjHuiMCIi8T1rCxwRxewz4X1uCTWlJAq
 aKkkIiNrMgqRIflEzfdDto4OWG0dbQltNLBKiG7BEFiydw8J2T4/YDuWp3j9AMMpHRdf
 IT2mfyRR5te531dNZOLFPlYbu+EptAO4d0YT3vmay23TelyXnvdz811yEsaV2AkBIcKu oA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ur4qbhd9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 17:47:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1701740822; bh=jY2I+JZIrbLjzodg+YkGa4qS6zjyMaAZjgn7f/4NQQk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Qt29kts0s1V3u7k2erP+3G5uVMzw8VUaOFsYoTa8Cg0Q/r5Tm4aiup3OJoztHwheK
         lEI+WQnYNJoOs28wQiFkapg2tCGiRZ3c87c5ZejVvCnFAC+Qs9/dbF9eFZWEpi8895
         Tk8gI6i5kV2cHFG3y9TBLBVGwxoDtH68nRvtjtBermqC7pGs4xKY3XVzf+nm9fFbVv
         fxPOAzXEAZ1aqUsf4adnyp78trIKk7qKFPbq+US5Xh7KYjqm5U44BVgr49WLFOomT7
         m0IwRs8CNB5QCeh4TeVa8nR6gk/e5p5r8ocfBNMG5e3NDlWCzF1tneDa5J5IFMX8CC
         51LOk59eUozGQ==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E53634041D;
        Tue,  5 Dec 2023 01:47:01 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id AE913A0085;
        Tue,  5 Dec 2023 01:47:01 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=JZ1OitLU;
        dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4D84240356;
        Tue,  5 Dec 2023 01:47:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mI0dO3gjsgbT98sj0SfSbHs7a/kgLVWmX4H5o3Sw9XWJJi9rq9CAvNt6nvnmBQwLDrdtkvQctMoUJze8opQjx+zc65CfkdF3MfMEve5HUsgMPVJBo9cDYvLJ/OFS+ZJZvgmzYS1sT9JXcgu7LDFnml67CYS/CJ/jTfZbm4tbHRCNv34tSru616gBRo77vVxPW0WDvvMSgtDuk5XBFx8f1zkQO1CBdPKfDnkbsVnmp3D1q6GgHf7OSb5pXZcTwMqP2slmW4hdLj5/ZrjlBR0wBM0snfrnAtyQun00dpQyY+o5HUBqk95ctei1bzwFXJ77lmnMkCA3I+XoZVF84dbbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jY2I+JZIrbLjzodg+YkGa4qS6zjyMaAZjgn7f/4NQQk=;
 b=llZax7HHXNQ4txpNEpZhBLoaqwJK2Mac6iFbPE5mgDr7RmupzHJ3ayocV94beoL7XXrmSU6YaWbhERYl64Sqm5Q6oFv0Ll2Q4xqXmKAV9zcpXCDBa6DkIEXXPEU1iFQopb7LcVd9XrEZlGsa8rxUTkHwA63sgD23MH1+Iiw7g9Gx8Wf4vJoqLcHAfPXyQi2lHzItbDZvixeCBndI+ou09GhL4J08Pe+DD5m8Ey+YnqcdY4csyvzAP4rHPt1FHjberu85we9oq459vD17pA8cLbxvGEJ+pgRVlxLCAmc+19Z22y24pfx4j188Lr03FOZv5xfu3ILmrLB8MRzWVa7UwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jY2I+JZIrbLjzodg+YkGa4qS6zjyMaAZjgn7f/4NQQk=;
 b=JZ1OitLUJrWwYitvRVUJUMSl2+roudwywhyMK7KfgOHZzDvI+AOfTP1CJ1/qs0XwrhXSMPAfqk2DI0OXbyJqkZ0/qLaE+533/ec82pp52HkNgcOcJOoLqySfkyqZsstaR3gD71yzM+Ncv5Qrj5ZM0DKkz6GXP7jcV7+SQSz1Q7A=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.33; Tue, 5 Dec 2023 01:46:57 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e%5]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 01:46:57 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Handle EP0 request dequeuing properly
Thread-Topic: [PATCH] usb: dwc3: gadget: Handle EP0 request dequeuing properly
Thread-Index: AQHaHNFOatcyPfMx1kGsRBV/Lsj3/rCaAC2A
Date:   Tue, 5 Dec 2023 01:46:57 +0000
Message-ID: <20231205014647.jvw5yscdn232nddk@synopsys.com>
References: <20231121232003.20249-1-quic_wcheng@quicinc.com>
In-Reply-To: <20231121232003.20249-1-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB6423:EE_
x-ms-office365-filtering-correlation-id: 6bbc856c-5afb-4853-c126-08dbf5341114
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NWhPoQy0V91sWyAWzI38/wGT3x9K5WIPjuDpUzyqtC553QP7vWsuIs7PepvYW6zFlTn2o3J8N3eyK7QJja37pRfJFAV5p2eVTPP2sSpQDHsmZ3gNWNI5CYjC2a6S5HC6ukHllDHCEeIWaGxT4e6a7f7F/sEE9lBWFMenm/uA5x4Dzi15FGKBiwN4iyS45hKRoArdPsEVJJ/p0Q7DFrRIqod3czjhKxkxxx4Jw65LPTNhF+TgtbbveFPyqWdaG0+IJVxy9CjQIIMb4N+y73ILnLjEtzl4t/VC+PUIQ2YSlb7g8oQOYC3au3/aEkYWp7f3icHn/pmKOSBM1Gw1Rnl2wBiAnjgyIwzn9ZqBuBiXKl+iz+tyjEaCWfRQB/UHd5Gd8b251ArnCykKyfbK3zHkNHUY394+jT8W1WtLRGKibITr8E47JAaqnn7+8ctKwHOXIwvM33iz0NhM1mOljIrhCvsbi1CRhR+JXwaGK0bswmlg4jBug/Xrol6lichnLWp+F5wLC31TgRPpvSYq8rfm44hGMWPbRO8R/WMXg3abACKv9z2uK1YOJu1CvT4w6gLFG6GTZK4n02PwmYwbo4KOxJyrVzrYeoByqwNc9HWLaolsE9K2sL9/qF+MQHcO+tKj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(36756003)(66899024)(86362001)(2906002)(5660300002)(41300700001)(38070700009)(122000001)(1076003)(71200400001)(6512007)(6506007)(2616005)(26005)(83380400001)(6486002)(478600001)(8936002)(8676002)(38100700002)(4326008)(6916009)(64756008)(54906003)(91956017)(66476007)(66946007)(76116006)(66446008)(66556008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE0wTW5KbjRhbExza3Q5UUJ5Z2g2dnlKZlVRREVYSjNiQ1crT2tOUXpyQnB6?=
 =?utf-8?B?eTRUSnE3K0pVWjJSVy9jckJzd0N4MlNnVDBLelRWRWh5eDRoSGV5TmVoMkVC?=
 =?utf-8?B?cW1VVERHRjlXTWdiUkkyaHR0SDJ2aDNaS2NxbjBkNTNObUpIR1BUSmZVLzVm?=
 =?utf-8?B?YVdlRDI0L3FMNUo1VW1ZNjViV29VdkdhMURxQ2htaTNsSFBIcDJzck1ENDZ3?=
 =?utf-8?B?VU5QUFREZEFuSC9NN0hmLzBMak1tNC9DWGV4RHlvL1NMOGl2MjhPU0JUM29Z?=
 =?utf-8?B?bUpZenV5dDFrQVQ0RkVTUFc5bC9iRS9FR1pEenZlLzlXRVJ2ZjBDUi9SRlgy?=
 =?utf-8?B?OUdTeGFNZTFkM2w1VFJaeWh0Qk5HaktWWnBVSHd6ZitkRlprd21PZUJjU0tP?=
 =?utf-8?B?REZvODJvNjF4MVRzUW9SVFNLYXl3WG9XdnQ3WE94SGZRWUIyaEthQnlmWjBS?=
 =?utf-8?B?cmtjN1lXSEJvRXdKUU9hUFNIemZ0TW05WENpMXJ0bFlCcXF1Sy8yNTJtVjZP?=
 =?utf-8?B?RkZUQ3dBY1BvK0lQdVYvL0hJNXJVWWl6dmwvVjJCeXhaeFVNcEJkVW9pbkNQ?=
 =?utf-8?B?amlpZWpFNTduVWlSRXB1NjIwOStTSVJEWnJsN1RjRy9ZVnBORVpHWjc0c3d4?=
 =?utf-8?B?RGNYK0VFeDJtTXRqcGNkQWJycTVUcEMyaVlCdURoa3F5NTVaMWdjSWNmTlZO?=
 =?utf-8?B?SnpxTDZ6aDY4aWIvK25QUXp0cTBVZHFFOFIwdzlJZ2h1a1NKVWpRaEdQVEhV?=
 =?utf-8?B?ZmgwTUFQUWl4dWxnUnY0MkVTWS9Yd2VQM0xqT2t3MHdhUGVBdStSYmpISlds?=
 =?utf-8?B?bWVTcGpiL1Z4K1FRaEpEakloTUwybDhQNGxHdTFrSUk2YjFCVTQvSzBnWW5N?=
 =?utf-8?B?aHI5N2hoQ1I5RXhnN2lmVTFHdmZoSGRocVY0eEFkanpFQytMcW1nT1JRbTRj?=
 =?utf-8?B?b05MY2NUaFN4Mmh2RGtlMlhhakxkVG04RlhCcG1yUXpFTjVGaHpTVnUyV0Qx?=
 =?utf-8?B?cmxmSVZ3RUZtVHZjd2ZNdnFHNGl3YnVJNGthU0FTdDdUcTNEYWtROFJwUWg0?=
 =?utf-8?B?TzRTa1pYdksycm5LWStPanViTjJTekdLcnE1S0ViRDBsL3VaOGRkZFFBblpn?=
 =?utf-8?B?OEpERGE1ZlBGUHBwdDlUaUlsam9lWVJzZm4wOTBMOFRrbUcwSVlOUEtLYmVp?=
 =?utf-8?B?VW5OVk83MXZJdWREck5nN0tVQkJVcHdXUXZ3MFZqZVJEaUhYTTJmdWVIZTdN?=
 =?utf-8?B?TzFkbkM2MG0renR6bElhVHI2bVh6WFdIVUE2YzRwbW5wWWxrTnQ2YXhnd0Iy?=
 =?utf-8?B?alZ3ekNLS3dydkNRdU5ON2E5cDZzUG01ZzVzVnJvak5zVGVtRFpRNE96SCtz?=
 =?utf-8?B?L1dTM0JxOU5HWGFCakJuS0d0ekFLZUNPL1Q2Y1RNWnlOc3VvR1BOT2EzaFJW?=
 =?utf-8?B?RElVZVB2U2xUUFAyNUg5WWJxOWpaalNxTkUyRnFWenVwMW54VWo2MlN3cHZI?=
 =?utf-8?B?Sk9nYlFoRkhPNStCeHhxSmxBcTdMbUdwd3dQWEpBSFJUM1RhUXFBQnRpd1py?=
 =?utf-8?B?NHRSYTJYbDUvUmcwY1QvQTN4UHRBNjg0YjFXM3ZjMlJtTndXdFVOZndrYWkv?=
 =?utf-8?B?WUpoVGNyUDVCRGRaWnhmUTVQbGtiNFJMbUIxMDhnOXREb1doTHdLc3hPZThj?=
 =?utf-8?B?UjZiN3pteEQvS1BlTWJHU2MzRytjOVd5NlcvOE9qcVd3SXpSNjFWTVB0RUdo?=
 =?utf-8?B?WGxOQ0xTditjL2poQTgwQk1XVXJMNDZqbW5oQW5HRXE3d2UvUTFIOXd5c2VQ?=
 =?utf-8?B?TFJRM2NKNExwYUJVZDdqUXhMUThDb0ZpVG5pU1BXZzBpbFR1RU16b2dHbC9j?=
 =?utf-8?B?U1dSVzBEK1A0ZTE2d0hKZFZRbHpYeldLZzhUNHNPSW85WElVWEs4YWpMdUtt?=
 =?utf-8?B?WG5yOVBHM3JRWTc4aW50YncvOVZKWDJoT3JUWFlpekdUdzJUVlVkTmovYytv?=
 =?utf-8?B?eE5SL3VOMDVBcis1dEtFcTFXckFGQVB1citXWmM0T2sybFFlbyszbnN5b2Vs?=
 =?utf-8?B?eG92YWFsQ0htazgxVmptTGRBZk1sRm9Ub0xsT3BicGVQY3dRYlFZc05CeEJN?=
 =?utf-8?B?VUZNRjh6VWpIYXBHWnUxNGg2dGhIcGpoVmtBY0U4cGJTRnllaGRxTmlSamV6?=
 =?utf-8?B?M2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17376A597B1B5E4ABBC4045033F6827C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tWT22txFb8JDUsCWFLaWC6XhPC3/xooYxOazAkyhC52HXkX5ljrDwQ5Fz9q+IZ56qCSGG5FIacbF2hKpiZO+gezIk43dOB6KWPTj5rPPu4zfjCU4hvbWT+QZEKP6sp7irUmmP1bRjUYWpuLoES30u0LZ5uz+gAmFqtmPQTC6TzWpEMxf9qYW0LwF/hyHSe7a5WY3SFVSrywREPxQgihFhCALdtLlRUbOctG6MIDqbfHDPbKZxlYsnddYtqZwp9TrgCQJlNV2F4KVMGJpnLB61T3O/NB8Lu6tb/0rYCEOXbNkkKCBp4C2R7dfCoIO9jhRej1xTHv5O0IkM4skjSszTxWvnIdFF+Th+Sh2QnCyyhyjXM/aznDPpRgyb+TOv66qOEUu3e+5wW++7EsDPVeS2reCvB3893mIn23s/tY4vDMNnh/mF3p5WgEgq/cimATZcYuKc6bwmpHOEQrbX2w2NC+uK8g1MSMnsaWPwFMDgOuddvAey1Gi+XMO6m+34JCPpsTotA5QhjZxxO1RyjRxayFDF1IAnQ0I/eTYfTkp3jrzkPhHPeo5vekkBbU2YVSxPEgni8kAHjtD5lU44nVCYmOEXRKTS/i/F09V6NbDIlLGN1npxLMLPZGmkuWeQKD1OwBv1fDKs8j6WHMM6D1jJYK/0NxZQ9jSz0TZUQtyEHkd9cZNPaAuWnCSurjGma4tN6QeJteuKFuJYlELoUOso7UTYXWdihjA7NHy10hjuQvHykjwfsOyn9nixuhptcwjsrwala7Y+NuftSECtsyc9LqBzhYYpJHLFokH3urxOtGDRRIoBtqVZBHFvoSY5JJ7y7iPvzpg8DgX8zLUlyLfhsjPohVW1VdKPjd+fyXZphw+D9LoqcXUric5cltuRDWNbdubaoCK2PlIowle0KXXYw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbc856c-5afb-4853-c126-08dbf5341114
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 01:46:57.6330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qgBXYEnMSKdfreFFv/rKHCQV2cpUx/W29yFp40rqy8w47JlyGmSgF3XKNPhHKoTH9PAK90bZVvj1eQPXlxdA2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
X-Proofpoint-GUID: yYzRTjmv4VTTVFMuVOSON6Cz1d-tSJmQ
X-Proofpoint-ORIG-GUID: yYzRTjmv4VTTVFMuVOSON6Cz1d-tSJmQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_24,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312050013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBOb3YgMjEsIDIwMjMsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gQ3VycmVudCBFUDAg
ZGVxdWV1ZSBwYXRoIHdpbGwgc2hhcmUgdGhlIHNhbWUgYXMgb3RoZXIgRVBzLiAgSG93ZXZlciwg
dGhlcmUNCj4gYXJlIHNvbWUgc3BlY2lhbCBjb25zaWRlcmF0aW9ucyB0aGF0IG5lZWQgdG8gYmUg
bWFkZSBmb3IgRVAwIHRyYW5zZmVyczoNCj4gDQo+ICAgLSBFUDAgdHJhbnNmZXJzIG5ldmVyIHRy
YW5zaXRpb24gaW50byB0aGUgc3RhcnRlZF9saXN0DQo+ICAgLSBFUDAgb25seSBoYXMgb25lIGFj
dGl2ZSByZXF1ZXN0IGF0IGEgdGltZQ0KPiANCj4gSW4gY2FzZSB0aGVyZSBpcyBhIHZlbmRvciBz
cGVjaWZpYyBjb250cm9sIG1lc3NhZ2UgZm9yIGEgZnVuY3Rpb24gb3ZlciBVU0INCj4gRkZTLCB0
aGVuIHRoZXJlIGlzIG5vIGd1YXJhbnRlZSBvbiB0aGUgdGltZWxpbmUgd2hpY2ggdGhlIERBVEEv
U1RBVFVTIHN0YWdlDQo+IGlzIHJlc3BvbmRlZCB0by4gIFdoaWxlIHRoaXMgb2NjdXJzLCBhbnkg
YXR0ZW1wdCB0byBlbmQgdHJhbnNmZXJzIG9uDQo+IG5vbi1jb250cm9sIEVQcyB3aWxsIGVuZCB1
cCBoYXZpbmcgdGhlIERXQzNfRVBfREVMQVlfU1RPUCBmbGFnIHNldCwgYW5kDQo+IGRlZmVyIGlz
c3Vpbmcgb2YgdGhlIGVuZCB0cmFuc2ZlciBjb21tYW5kLiAgSWYgdGhlIFVTQiBGRlMgYXBwbGlj
YXRpb24NCj4gZGVjaWRlcyB0byB0aW1lb3V0IHRoZSBjb250cm9sIHRyYW5zZmVyLCBvciBpZiBV
U0IgRkZTIEFJTyBwYXRoIGV4aXRzLCB0aGUNCj4gVVNCIEZGUyBkcml2ZXIgd2lsbCBpc3N1ZSBh
IGNhbGwgdG8gdXNiX2VwX2RlcXVldWUoKSBmb3IgdGhlIGVwMCByZXF1ZXN0Lg0KPiANCj4gSW4g
Y2FzZSBvZiB0aGUgQUlPIGV4aXQgcGF0aCwgdGhlIEFJTyBGUyBibG9ja3MgdW50aWwgYWxsIHBl
bmRpbmcgVVNCDQo+IHJlcXVlc3RzIHV0aWxpemluZyB0aGUgQUlPIHBhdGggaXMgY29tcGxldGVk
LiAgSG93ZXZlciwgc2luY2UgdGhlIGRlcXVldWUNCj4gb2YgZXAwIHJlcSBkb2VzIG5vdCBoYXBw
ZW4gcHJvcGVybHksIGFsbCBub24tY29udHJvbCBFUHMgd2l0aCB0aGUNCj4gRFdDM19FUF9ERUxB
WV9TVE9QIGZsYWcgc2V0IHdpbGwgbm90IGJlIGhhbmRsZWQsIGFuZCB0aGUgQUlPIGV4aXQgcGF0
aCB3aWxsDQo+IGJlIHN0dWNrIHdhaXRpbmcgZm9yIHRoZSBVU0IgRkZTIGRhdGEgZW5kcG9pbnRz
IHRvIHJlY2VpdmUgYSBjb21wbGV0aW9uDQo+IGNhbGxiYWNrLg0KPiANCj4gRml4IGlzIHRvIHV0
aWxpemUgZHdjM19lcDBfcmVzZXRfc3RhdGUoKSBpbiB0aGUgZGVxdWV1ZSBBUEkgdG8gZW5zdXJl
IEVQMA0KPiBpcyBicm91Z2h0IGJhY2sgdG8gdGhlIFNFVFVQIHN0YXRlLCBhbmQgZW5zdXJlcyB0
aGF0IGFueSBkZWZlcnJlZCBlbmQNCj4gdHJhbnNmZXIgY29tbWFuZHMgYXJlIGhhbmRsZWQuICBU
aGlzIGFsc28gd2lsbCBlbmQgYW55IGFjdGl2ZSB0cmFuc2ZlcnMNCj4gb24gRVAwLCBjb21wYXJl
ZCB0byB0aGUgcHJldmlvdXMgaW1wbGVtZW50YXRpb24gd2hpY2ggZGlyZWN0bHkgY2FsbGVkDQo+
IGdpdmViYWNrIG9ubHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBXZXNsZXkgQ2hlbmcgPHF1aWNf
d2NoZW5nQHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMg
fCAxMiArKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
YyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggODU4ZmU0YzI5OWI3Li44OGQ4
ZDU4OWYwMTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysr
IGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtMjEwMyw3ICsyMTAzLDE3IEBAIHN0
YXRpYyBpbnQgZHdjM19nYWRnZXRfZXBfZGVxdWV1ZShzdHJ1Y3QgdXNiX2VwICplcCwNCj4gIA0K
PiAgCWxpc3RfZm9yX2VhY2hfZW50cnkociwgJmRlcC0+cGVuZGluZ19saXN0LCBsaXN0KSB7DQo+
ICAJCWlmIChyID09IHJlcSkgew0KPiAtCQkJZHdjM19nYWRnZXRfZ2l2ZWJhY2soZGVwLCByZXEs
IC1FQ09OTlJFU0VUKTsNCj4gKwkJCS8qDQo+ICsJCQkgKiBFeHBsaWNpdGx5IGNoZWNrIGZvciBF
UDAvMSBhcyBkZXF1ZXVlIGZvciB0aG9zZQ0KPiArCQkJICogRVBzIG5lZWQgdG8gYmUgaGFuZGxl
ZCBkaWZmZXJlbnRseS4gIENvbnRyb2wgRVANCj4gKwkJCSAqIG9ubHkgZGVhbHMgd2l0aCBvbmUg
VVNCIHJlcSwgYW5kIGdpdmViYWNrIHdpbGwNCj4gKwkJCSAqIG9jY3VyIGR1cmluZyBkd2MzX2Vw
MF9zdGFsbF9hbmRfcmVzdGFydCgpLiAgRVAwDQo+ICsJCQkgKiByZXF1ZXN0cyBhcmUgbmV2ZXIg
YWRkZWQgdG8gc3RhcnRlZF9saXN0Lg0KPiArCQkJICovDQo+ICsJCQlpZiAoZGVwLT5udW1iZXIg
PiAxKQ0KPiArCQkJCWR3YzNfZ2FkZ2V0X2dpdmViYWNrKGRlcCwgcmVxLCAtRUNPTk5SRVNFVCk7
DQo+ICsJCQllbHNlDQo+ICsJCQkJZHdjM19lcDBfcmVzZXRfc3RhdGUoZHdjKTsNCj4gIAkJCWdv
dG8gb3V0Ow0KPiAgCQl9DQo+ICAJfQ0KDQpTaG91bGQgd2UgYWRkIEZpeGVzIHRhZz8NCg0KVGhh
bmtzLA0KVGhpbmg=
