Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969637D18ED
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjJTWIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjJTWIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:08:07 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA62ED69;
        Fri, 20 Oct 2023 15:08:02 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KHntmj007818;
        Fri, 20 Oct 2023 15:07:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=60v2/Slx4B2nS0nYbF9D1sv6Tu3TfpayrE6qKx9v0p8=;
 b=Dubl+IVR+zvL+VXpAJwmKpesfomxm8DPMRoUJ08durQnfMWyBvkNLcenEwD6IUkNVLUS
 cYlMoL+Lf2MTxw2fIL+hf4hplPfepNTc8yL1ZQ/VdROm9/kA4j0RsZB/RV4RGAvdedKn
 HQ1bRt6JY+y7tD1nUlMti/Amwui8SHSrcAcIyeVPNyRNt+EeX/g7WwQUhffbqgHUdLy1
 DglJ1L1E8IsdBQOimLVAL/4UQSKMsVTgGt9qAgkd6GU9244XiwLbE8VAaiqIJU20d10v
 Ncxsxvx3PryvA2Xv7Yoq/J+332siZTLudSgNaPSYyv5kuTme/XhYdQ4wDNNNU0sevdzt CQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3tubybpjx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 15:07:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1697839666; bh=60v2/Slx4B2nS0nYbF9D1sv6Tu3TfpayrE6qKx9v0p8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=iQ7mfMWGbjEOOs2j/WyAg8sp48zni8xJ5XnQPYBZ5lV45pZ/Bl7dGZHebCgsHl/6v
         UCNhq2jN88EmK9W2ZkwmqrkrzST0HIB4bnie1Qk7sr28eB0UjXRrU69wlpb9ENGLmn
         wWdR+fVy2P9sO8UHqkHoZhy7/RhLCgM3W2BeXMMmeAge+J9fGEOjScybiBLLEHTTNT
         mHeMdPBX3AueisytZZumO259F6pgDLjU48dJHn3CvF7oEotHnHc/sYjqaHyL9hnuVx
         S1rXdwU7va2iC/ICy+Su0WScCbCZnX58FzH2MCAwWgSv8e786VoAcTP239nt0CE9PH
         34RzkKGeNh9aQ==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4B54F404D0;
        Fri, 20 Oct 2023 22:07:46 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9574EA007B;
        Fri, 20 Oct 2023 22:07:44 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=G8G5O/DG;
        dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 92C5440582;
        Fri, 20 Oct 2023 22:07:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebV9qnRGCVvhd7w7DH29YbMjFJDPlJGi9zWcNG8mteW8fZoYSaOlzdfo+/Di2kEJwaL42uRt/SGsSOvXBauqcygyqydyRaXC7KVD7DuoqoqKJJxU+4S54PhwKWgkGq4xmMBMrgG7qzykNAD6JFIiYbIz1ByA101pk+G3i88Kf4aGYf9+u6gsZDwu1cYYCTvJOnJBMYW+D19LdJvx8M6MRARLy37TDirrBHUPuEC2SZSOBmDErOcGjow0ielwKqCHVhSqnB0ADmaQ/fG6lECJmV8mwo0rbAnsvAqJcK6WXbB6X1B01q8AeBeSdkxKESYwrjGlj0RNvmy+GT+ZX7ARuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60v2/Slx4B2nS0nYbF9D1sv6Tu3TfpayrE6qKx9v0p8=;
 b=SeakT7kDyGp/Wjca1mlvhn/vW2iXMq1MBWj9/toYEnJtMh+DWVUep+DiUis8VmFsvOX772iF++/Xhs/MyopKFEJ6Ei51iKGTvN2av/L5/WNz58Jo8HyGdTVDqk0Y7Z7ZTiOkguBFkExIKOINyQI1E5hY+Fs8H0OwBLISWey9Y/Jcncmi78mXNyX4J/hcvcAw/JDNtWJYWBVqCbTcYhKCxWVDIkr1gndZt2JXM86x9SxkivT+euGUnQc6urO4nlv1kuYiY6tkiDuX13jXQ7XvLpqFUJ0crfNS+IV4olmBuVixtVD1h4O8hTVBhoqnZAL3I625QR8bfzDy2tmdUS1vNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60v2/Slx4B2nS0nYbF9D1sv6Tu3TfpayrE6qKx9v0p8=;
 b=G8G5O/DG630YaS2EffDMF62PeUIn/5PViIV0SGL9zGOLFae9gC2UUrH48f4M7rbB11j1sUm30HT9yZ3EsGQPAOFUAIurczdeKjF8A7JvmVrHf/tZMvDnUmyKt4JlZXRCNAzsIaSwUUZqfPm7q32/nZtXQT3IyI2HK8fVzbzxVcE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 22:07:35 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b63e:67e6:b5fe:a8cb]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b63e:67e6:b5fe:a8cb%3]) with mapi id 15.20.6907.021; Fri, 20 Oct 2023
 22:07:34 +0000
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
Subject: Re: [PATCH 05/12] usb: dwc3: Override end of dwc3 memory resource
Thread-Topic: [PATCH 05/12] usb: dwc3: Override end of dwc3 memory resource
Thread-Index: AQHaAKen+on9Jqc/Rk+HDekTbWUkh7BTQlCA
Date:   Fri, 20 Oct 2023 22:07:34 +0000
Message-ID: <20231020220727.444o7ghclpyp4l4q@synopsys.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
 <20231016-dwc3-refactor-v1-5-ab4a84165470@quicinc.com>
In-Reply-To: <20231016-dwc3-refactor-v1-5-ab4a84165470@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB5181:EE_
x-ms-office365-filtering-correlation-id: 541f01c5-3c64-4e49-3742-08dbd1b8f6dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: amDDj9dkcBz2rY5QwhoIDDaeP6J4lHJGaVzNLWOshSXxapR2H3+rqP/29ZOxasV+Hyt8s7ubFMrPkZvwb0wppRYs5bi4NsSt45Fzb2BWaLBHoSRYY5adDfNzDz3i9KTfYU4+opTQKKDQDUZwpQ6PGaNwP5PhF5ioZjRwL7NdSvFJuWx7D1c1i5THxXt9bCgZbtxt6vRl2Kh9GsF44kIECd8mA9P8rAFY8dN69T57URyQAZmBiDUqUNjYqvRf0D+5ApDaetfZ2Khd3jaAi2VU+qk0XcEbnqD9+QbzZITLnDIGrhFB96UwVt2rRhcgslQYmpqnSkeT5+opHcj+fr5QX614xUsAJO/txeIkm0IYRoUweMzFCoBM68+3+h5T8NZJRE0jxHoZbuPUIMHJ+j/nhVng4TCJYNXlbtHjbyP0qKvr78EUt/kr2gIy7zyH8Myn71I4fBfHxY17o+n10JQXJUpfobdpIcFmA8gguWUa8iMLkVyN/gGC1II5mRy0IPhM4+X/Rnd4LKZq6v3tyRlWA12IK3IIqwgcRrTheLVdcfQIHMPVIjmYKUehDMYuen7jeCpPWqSkF932uCTsV6fnBJ/4TvmqHw15+qAlhMU2V7ETRsV6lQMsOszz/Vd5e+yr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(6916009)(316002)(122000001)(6486002)(86362001)(36756003)(4326008)(8936002)(7416002)(5660300002)(8676002)(41300700001)(2906002)(71200400001)(38100700002)(6512007)(2616005)(1076003)(6506007)(26005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0ZOUjhrNXRhcGlvTTZjclliY1BocXRIeXFCc0IvVit0ZXdPT3VmKzB6QVZJ?=
 =?utf-8?B?aUJXY2RzdEJPYTNsVTRJUk1EWlkyU0VORU13UFl6K2lzZjNzeEI3N21BamJi?=
 =?utf-8?B?RitkOG1yc2VLejNjZllJNVpCTmY2V2drOUZCRzZaZVlKWXc1eGdOUzBTQ09H?=
 =?utf-8?B?VTczU2N5QmVrdU5WdXgxWVJDdENSRzNiZ202TlhCRkE5eE1VdVljY2FlSE9J?=
 =?utf-8?B?ZlI2KzRKOGg2WGRCYkpOeC8ySmlJMUFmczk4RlZaWFRTSWVyRStKUnBLZy9r?=
 =?utf-8?B?NU84akdVSnlaTWk0QnhjYUtjbG5nMEFwZ0kwc3dxME1yS0RURW50TVprQUFR?=
 =?utf-8?B?a3hBQ0lYYjErQ1hxR0hsKzRaTE0rc1p4SHhFRXVObmI5YlA5QTA4QW9aQkdF?=
 =?utf-8?B?alNKTkcvYmliOXV4cWd0dUp0U1BIT1pmVGYrcGQ5Zk51S1MvUUp1YU14cngv?=
 =?utf-8?B?MUo2WmxBRW81QjhhTm1FL096UDhiWGNSZFkzRVh2VERDdGhBeDQrdjhQQkto?=
 =?utf-8?B?RE1zbVRVNWtFS1RKeDlOMTEvM1hjR0k4Sm5ELytMTk5KS1VzR0VhUDU4a2dG?=
 =?utf-8?B?em53eUVLWlpOSE9ZOG9GbW96ZW5zbnVodHhldkhZcjJsOEp6b3dYMmZ3dlhh?=
 =?utf-8?B?NEdQWmFFdG54Q0ZFUFRJVHJ5T3JKRWJTNDdGSlBNY00wQWRUc29ZYnZiaGI1?=
 =?utf-8?B?OVkrVm9iVXowWHJZbE44SVo4aFo4YVRCb1BFQ1VLSkJTbmFzQ3RNVnhGaXBH?=
 =?utf-8?B?QWFhM3BJTk40UzRZdWZUSm5XbXRtZC9kblFHRERvU2FMUU5CYWtjZTBwVytI?=
 =?utf-8?B?N3k0TnRBYklWaExBbjBUQm5QTWZ1MEtma3M5anNaQjlQK3ZFdHJlVGJVNTdr?=
 =?utf-8?B?M2JRMEduT0tWR2o1OU9oQktwQUdwdWFwdVFnalNjcmppMFlJbmU5NUlRbFpF?=
 =?utf-8?B?UWVESHB6VDJ2N3F2WWUrTm9rVGoybko0Y1hOcmcrdnhKdTYrMkFIRFRpYTMx?=
 =?utf-8?B?d0Jva3U1Nm9IY3haU0FrVjFlRk5wWXFIQkE0Um5qbUMyMWFBZ3hRRUlyRTla?=
 =?utf-8?B?T0ttN2xLNG1VdVFUOUlkRmtHejlKbUtyQ1gwWEZoWkpZR21ZdCtPZmo2WmJi?=
 =?utf-8?B?bGllcVJuNnNqRTFuTnNDOVd5NFZUUlZFNE1CU29hNThaSTBaUENHR3pKZGxn?=
 =?utf-8?B?V29nb2RJM2QxVkhzbjYwdnFrc3ZaY3Nmd3NVZjZhN3c2bVpXMm9ZTTM5Q0NZ?=
 =?utf-8?B?eGNPckhvMnNOVzhBeVplZ3QxZDJjUGV2cElOZDFGUGswbEdVMzJHbCtvNytW?=
 =?utf-8?B?bXAvcTE1WHNMaDNXMkR5K1B2UkZqaytQTExDaStrV21RVVNRYVRic2ZXVW9h?=
 =?utf-8?B?TXo2WVFza0wxblEyVm9FVVZ3N2xtenpmOHhkdkNJb1VVS2tHWjlOR2hBMC92?=
 =?utf-8?B?RENWcDZ3aFhrclptRjJyRkJRVVUyMXB2RGpMY0d2UW1CZFBvU3NxRXhHSWpS?=
 =?utf-8?B?QVlTVVFLMU5DUEw3QWZWakpVWGRCLzlieHY1YzdhbmtuSjVWN3BpWEMrai9U?=
 =?utf-8?B?cHRFeUxvbGxRM0tNZWV4RCtQRHl4VVFXRVFkeUVKU0FDSSszbkFFeXpUc2wx?=
 =?utf-8?B?NEJKc0VJdU5pdFB6c3VqOUwwOUZaeDJVRStqYXZENWE1ejl6ekd1TjN4Uzdj?=
 =?utf-8?B?T3Z4eFV1SjdVcUEzTE5vdWFOWitCM2V0ckhmSjlDOWRmNzRncjk0UzBiSUpm?=
 =?utf-8?B?Q0VIbmhHUG5iNnN2V1ZuVTFKaWg5ZWNKQXgzVTZMWi9zdGlCZFBiVUc2NC9q?=
 =?utf-8?B?UEpGRXVOTndWTG0ydmpxbGg0c3hWdTdKZXdTOWtZSk9xZWpUbk80VzhGL2dt?=
 =?utf-8?B?VHBWZ2lQUVBQV2R4S3JLNkpEQ1hDNDI2WWNrOGx5QUEwaEUrQWZLUTFYUGR0?=
 =?utf-8?B?djNuZTlCYlRCRjdDUEZxMUFmRkoxeFd4ZENVVUhsdHYxU1dxNHNBUnhWVExW?=
 =?utf-8?B?SHd2UWtuVE9SQzVzL0d5d0JDcjNaTDk0dVQ3cnFvcU5Gcm16U1A3V1Ixci9T?=
 =?utf-8?B?L01kRkVvK0JpSE8yVFFEUU5GQ3F2VFpoYTZtRVJnMGF4cHlON0E5UGdSMWc5?=
 =?utf-8?Q?juf5gSEmZcTHEG4B3X6JyYWg5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DA50FAE1B32E84BA73F8BE436471D3C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TW0wN21vRmlSM0xDVWw2elU3Y0pWMklhMEFTcUlDWXlCMlYzemJUeXpFTjBo?=
 =?utf-8?B?czdNYW9xZGJkY205WTJzRWJ6dnFvTk9RbnVDbmJwYmJsTmZRMEc2MUNSRDZi?=
 =?utf-8?B?dkV0QUdFdW1XdUdOQ2xsa3lLK25aSWgvbllYSDgzWHpROGZ4WkJqdUJRUHhM?=
 =?utf-8?B?MnYxaVFYUWtOVmxNeHhocjB3eGR1N0IwN0NxbnM0emwwSDZScW1EYUJ2WmNH?=
 =?utf-8?B?TW9KQ21mdWxNQm9JS2ZZN0ZqMnRGMUptL1lLUno1OXc1VTRXN2U5TmRTT1RY?=
 =?utf-8?B?anloNWNObFR4cDlKcUQ2cTVsbWF3K3VxWWpyWkl1cHVoRFhyVm5VZ3dTNitI?=
 =?utf-8?B?TnZYWWRuYWlYQ1hCV0lacHVsbktUbUhZSmIySFZYSFlyYWN4UVMzblZrYWFu?=
 =?utf-8?B?VGpFMS9CTjNZUWRJb0MySFU5RXJXNlp6ejRJQldkSkFOeHNZbm1PckR0MzF1?=
 =?utf-8?B?eFpERGlYM2F3VVBRcnVaamI4dFB0aENpd1lBRnNwV3FIU3hFVlYvSCtRMFBX?=
 =?utf-8?B?OVpROC9qdEM5OEhMWFh3anZUa043Y29Cd1JHVmFpWGNRaWc1UFVnM3pPWE45?=
 =?utf-8?B?MjU5cTBrSzZ2YUJvNkJ6d3daUUNrd1pvUUkwa1ViRC91bFdpcDFyWW9GdVVU?=
 =?utf-8?B?eFdhcUFvYUhVZXl1dkdNdXA3NU05MHhIek81YytmTk81d3hRU1lJcFhTVTJN?=
 =?utf-8?B?Q3RQZFJZWlZsMEdWWGsxT3NQYzV5ZmdXeVcyNndnR1JMbS9zR1NwZnc5djZU?=
 =?utf-8?B?WXRvTmRCRUpQREhHY3BsQXBMMDlzeHQwd3hRdnI0SHhETE5xMnNrY1A3ZFpZ?=
 =?utf-8?B?Y2l5Zk1GelFGdHh6UldvbVhhMStyemtIMW91U2UyWnhZRHNqUnNqdm80NTNn?=
 =?utf-8?B?ZmxLZDljZndWKzdxaG5OWFZvVHplNHMzT3IrWjRCQUYzbndhcWZMV0NzZS9V?=
 =?utf-8?B?ZnZrWURiMDUrdERIZWhiK3U3SlIrdm55eGpsWW8rdHhIb2FRbWo3dTlwWFFX?=
 =?utf-8?B?NzJBbUsva0RYMUkyVVZLM2wzRGVsK2U5Sm5oaW42NUx5R2NteCt6SzBuUFFr?=
 =?utf-8?B?a3VMU1k3UzlPS3Q2YjYzTjhQOVNtOU40THJidXpSOHZvV09ZUHB0WnZNZkpw?=
 =?utf-8?B?andRSVp6K0NPQTk3WTZhdUc0ZW9pc3pkaW5STTZSRXdobktEOXdlaVV4djBY?=
 =?utf-8?B?YTc1QXFUYzgrV2hYZ0NmSVk5Z3F4WGtUUklNR3k1V2pMRjUwaVRrSWU0Nm5I?=
 =?utf-8?B?cW1GS1ExM0txa0RXUTVPbElyOWo3TUp1eU5CMGZ1Z0ZLekw1SndVMmdRQWxW?=
 =?utf-8?Q?9D3Mqd262vDzFLFpjZyU1vyrP0Hh0pLxlX?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 541f01c5-3c64-4e49-3742-08dbd1b8f6dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 22:07:34.8295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DVhhUSDhqqsTCDXYAG8lBimIjyQoT4Mzd4jSy7cOuBmUwAiYHu8ohmqEIIMTQp5b6GRd6NmeuB3mp5GQZCRvZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5181
X-Proofpoint-ORIG-GUID: MZbBSJFx24yKIXjtlYO8doSSjnyMC2se
X-Proofpoint-GUID: MZbBSJFx24yKIXjtlYO8doSSjnyMC2se
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310200187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBPY3QgMTYsIDIwMjMsIEJqb3JuIEFuZGVyc3NvbiB3cm90ZToNCj4gSW4gdGhlIGNh
c2UgdGhhdCB0aGUgZHdjMyBjb3JlIGRyaXZlciBpcyBpbnN0YW50aWF0ZWQgZnJvbSB0aGUgc2Ft
ZQ0KPiBtZW1vcnkgcmVzb3VyY2UgaW5mb3JtYXRpb24gYXMgdGhlIGdsdWUgZHJpdmVyLCB0aGUg
ZHdjX3JlcyBtZW1vcnkNCj4gcmVnaW9uIHdpbGwgb3ZlcmxhcCB3aXRoIHRoZSBtZW1vcnkgcmVn
aW9uIGFscmVhZHkgbWFwcGVkIGJ5IHRoZSBnbHVlLg0KPiANCj4gQXMgdGhlIERXQzMgY29yZSBk
cml2ZXIgYWxyZWFkeSBkb2VzIG1hdGggb24gdGhlIHBhc3NlZCBtZW1vcnkgcmVnaW9uIHRvDQo+
IGV4Y2x1ZGUgdGhlIFhIQ0kgcmVnaW9uLCBhbHNvIGFkanVzdCB0aGUgZW5kIGFkZHJlc3MsIHRv
IGF2b2lkIGhhdmluZyB0bw0KPiBwYXNzIGFuIGFkanVzdGVkIHJlZ2lvbiBmcm9tIHRoZSBnbHVl
IGV4cGxpY2l0bHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCam9ybiBBbmRlcnNzb24gPHF1aWNf
YmpvcmFuZGVAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMg
fCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0K
PiBpbmRleCA3MWUzNzZiZWJiMTYuLjVkODZiODAzZmFiMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gQEAg
LTE5MDgsNiArMTkwOCw3IEBAIHN0cnVjdCBkd2MzICpkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ICAJICovDQo+ICAJZHdjX3JlcyA9ICpyZXM7DQo+ICAJZHdjX3Jl
cy5zdGFydCArPSBEV0MzX0dMT0JBTFNfUkVHU19TVEFSVDsNCj4gKwlkd2NfcmVzLmVuZCA9IHJl
cy0+c3RhcnQgKyBEV0MzX09UR19SRUdTX0VORDsNCg0KRFdDM19PVEdfUkVHU19FTkQgc2hvdWxk
bid0IHJlYWxseSBiZSB0aGUgZW5kLiBXaGF0IG9mZnNldCBkb2VzIHFjb20NCnN0YXJ0IG92ZXJs
YXBwaW5nPw0KDQpDYW4gdGhlIGVuZCBiZSAweGRhMDAgZm9yIG5vdz8gKFRoaXMgY2FuIGNoYW5n
ZSkNCg0KQlIsDQpUaGluaA0KDQo+ICANCj4gIAlpZiAoZGV2LT5vZl9ub2RlKSB7DQo+ICAJCXN0
cnVjdCBkZXZpY2Vfbm9kZSAqcGFyZW50ID0gb2ZfZ2V0X3BhcmVudChkZXYtPm9mX25vZGUpOw0K
PiBAQCAtMTkxNSw2ICsxOTE2LDcgQEAgc3RydWN0IGR3YzMgKmR3YzNfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJaWYgKG9mX2RldmljZV9pc19jb21wYXRpYmxlKHBh
cmVudCwgInJlYWx0ZWsscnRkLWR3YzMiKSkgew0KPiAgCQkJZHdjX3Jlcy5zdGFydCAtPSBEV0Mz
X0dMT0JBTFNfUkVHU19TVEFSVDsNCj4gIAkJCWR3Y19yZXMuc3RhcnQgKz0gRFdDM19SVEtfUlRE
X0dMT0JBTFNfUkVHU19TVEFSVDsNCj4gKwkJCWR3Y19yZXMuZW5kID0gZHdjX3Jlcy5zdGFydCAr
IERXQzNfT1RHX1JFR1NfRU5EOw0KPiAgCQl9DQo+ICANCj4gIAkJb2Zfbm9kZV9wdXQocGFyZW50
KTsNCj4gDQo+IC0tIA0KPiAyLjI1LjENCj4g
