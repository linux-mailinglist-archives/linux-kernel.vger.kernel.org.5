Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395B276A5D9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 02:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjHAA7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 20:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHAA7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 20:59:47 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EBDE5D;
        Mon, 31 Jul 2023 17:59:46 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VJpveZ031536;
        Mon, 31 Jul 2023 17:59:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=UYElJROu4nJ8yAec1WixeQe5UW5gZpuJMvvIp0HTVxk=;
 b=nNMFW97G8/yyoY8v3WvKhp1rPr9K/+CwkH/If8PoIKBjrk0BKIlruGuGTyg6OsGEyIzw
 oPapVPEnfaiunk+5YslY88398g3+NTRr/fdREFQubFlMtPWMj7FCw9lwG334WgnyjAjw
 N0DEM1U6rQkdVEKBa/SHEp7PXnSMMFqwbR2nR2r21wT+wvwuxlGwiwBkjMgetgp2KpjS
 aLJLZGFpsqPemv5F14/6AyMutJ0eP7H5JgCj6lQvrsxc1jf95Ep1ewD+lkOhBYlnt/Vr
 HYfFVkJkHIO6iyUcoqLDARJhPNeZT6BtcVYAsYZ4Cc+hjEMtPzOpGWkD1sWPjxMQ7Irg mw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3s5213h2cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 17:59:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1690851563; bh=UYElJROu4nJ8yAec1WixeQe5UW5gZpuJMvvIp0HTVxk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=inWOYU7br9qJgpMPr0X7wJCWBkm3P/rNyXcQRxIPQsZgopBWN68gveAGl2XpLY1sN
         a/jkpMZrfXgQ9MjbCuK3eySIo0Ej7/uKyt6zYyZL3uJEmZ+jQASyCVDRRwSNnihmDb
         eYz129fIgnHWwxEzXvzUlpA5HwXbzKSpHqVygfnRgfy3G6LJ601j+PcFZHtuSwbFjW
         QPI8M12RaNtV7F8AkpOjubfbNQ3DLZw9A90Qx6Y9ylyHOLK9G2UePYo3cehPKZHd0Q
         WO+Dlts/naoZWA6cd3014Y3KGgP9zEWiVLx0YXbli1FN7WQVrlRzNneE4CkeD9NPHW
         zDPXe7M15veXw==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6A45240565;
        Tue,  1 Aug 2023 00:59:22 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 30E3FA00F7;
        Tue,  1 Aug 2023 00:59:21 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=hgWnlE/U;
        dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id DBB9D4013A;
        Tue,  1 Aug 2023 00:59:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fK3jrORX/7HR6qt+0umK+zcfyqsywR6jlwypeM+9Pm4mfi+wfIqvk3u2Ia7Gj2lXpW/PR3dmrlEKeNUnIWzLWBHS2b7uspyBe4NQCfPUYH4P9er9aLMDQGoRC/ZYNcdhkXoLXQz61TlMpdHne+1pSjP3Mr4CgnOWNcZcHitj4PvYhvInkPuOlPAxgFSaptkSaAX8FhxdwqT/FmXB2MjIDqXXhVBTMjVPGyaWNG8Wz7oYxC4jGVN4BYddS4qxJ3pQx+HDuFMlaLG5BshLonFlY+44fRu19S1RlwrwDShE+MT0Un1GMH8zx5eyyeVWnSDFr0ZiO1tDiTzlN6w6ZSHxXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYElJROu4nJ8yAec1WixeQe5UW5gZpuJMvvIp0HTVxk=;
 b=Q9mMzWJwucK5en6/qRxMCvsESx4dT8oAXpX0WYJ7uNvVcV34765rdVvXlR7XWy80GK/Hbr50Z2YHykthv8U39LRyvFdpHloIBOHMXeLIR8gBv7HK9t38QUJaq+qb2qpsE/iMHL9Fa+3ecqLz861bGRCet9rGmsBNbZ0PgSp8JaE1fRpS2OlCE3EDiG/s7EAJaKe8OiwU9VhISHLDSh5z0zn7IyPk5zwNfxKpp2b7xEU7ypaApwkOt3L//47906zQX66mk6WXDA2fydM8SB24Ls+waok85CRO8EoKG2eTnZtHAebntwdnkiDiMsSazIrlq9Mhs+HYgBiwedyKUhZ3hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYElJROu4nJ8yAec1WixeQe5UW5gZpuJMvvIp0HTVxk=;
 b=hgWnlE/UCsfgdc62wTgqIUXiQi4WJvF2pBxHClGBURUFF4xSXquf6uIz7hml9G7v4HasHVe74sXXU/hrJ5nU+FOPJQ7wFyEQ8dAjy+5S8/SU17L6h2ytPNHoJ0U1VffIGVeQxwu7grixFFsrNpTB0sJJzny6fWQYrGWIIonugTY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH0PR12MB5465.namprd12.prod.outlook.com (2603:10b6:510:ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Tue, 1 Aug
 2023 00:59:16 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::138d:ed63:a424:1f33]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::138d:ed63:a424:1f33%5]) with mapi id 15.20.6631.042; Tue, 1 Aug 2023
 00:59:16 +0000
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
Subject: Re: [PATCH v10 04/11] usb: dwc3: core: Skip setting event buffers for
 host only controllers
Thread-Topic: [PATCH v10 04/11] usb: dwc3: core: Skip setting event buffers
 for host only controllers
Thread-Index: AQHZwNpw1extA94sBkeEATAf60VG06/UpROA
Date:   Tue, 1 Aug 2023 00:59:16 +0000
Message-ID: <20230801005915.zjfzypf645pffozl@synopsys.com>
References: <20230727223307.8096-1-quic_kriskura@quicinc.com>
 <20230727223307.8096-5-quic_kriskura@quicinc.com>
In-Reply-To: <20230727223307.8096-5-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH0PR12MB5465:EE_
x-ms-office365-filtering-correlation-id: bcd70517-dc30-4295-09df-08db922a87b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q0VcZiCpFfLCZiVLMzXc6eEFmjl4PrRGRw++Gmw83hU/PesgOAZ7VJMWgRLefkJRvhdoJll3Oj4/r/jz/mu/3BcGTUhjTmWWz9CmOwmxISa9i+jhUartXUbupYilRhw3s3D7WZ6WMNx2wi1sl1jh4uabCTQ4rpT6XXcIkNpEB3ZV6V5vFY+PMa0SBLFo+fOOWQ7yq7+yA3/WA+7fpr0E+vLHFAj2FuaVVMDOxZc9/abcwW+1DVFR5Ov1xkqcvfGdsZeLAcXb+sZ0z45TkMfCymOt4wsNQV1vvsz28qo/3fmPM4yh+zwitbl2JkS5gQEPCKQQ8MlmpqLjnvz8GD61A0XJQ5uOPdp6NIb3p40BocYckZ6jP1KKHmwP6Qx+UrPPRDBRiNWwzqzm3DXJKK9dLRMLgNc4sbfChkFJI+TWEz5U+u0Q7rWR+f9ZE6me+F4UhPZvI0Kd+OnnBszbQ/lLbDI+4gShlb/X88ezPS4F4kDnChGLDwraSuao+VB5pcOhZVLp5wCdY1M5iuyqfVuPiy7m7BeyPIVDHV28bQaAHvGXpa9GMlMgXH/HoRfogAuy0wseloZdp76xTsIsB0bM3VhFrFmGT1IVQbjUxNybZxM8UIRUevSJKtPQsrK+TWu9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199021)(6506007)(316002)(26005)(8936002)(1076003)(41300700001)(66446008)(8676002)(54906003)(6916009)(122000001)(6512007)(66556008)(64756008)(66476007)(4326008)(76116006)(478600001)(66946007)(71200400001)(6486002)(36756003)(38100700002)(2616005)(38070700005)(2906002)(83380400001)(86362001)(186003)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW9XelhWc0ovbWVYa1NhOGFmV0lQQW9renVjVUFCL1pnUVVNZUxuTkhpNkVN?=
 =?utf-8?B?NkJUbElvYUI0T2hYSjhwSW1vTi80bDZZN2did3JuV1pMSDVqYTZSQUl6dGYv?=
 =?utf-8?B?VEZscVlGdVlDVjFNa1FLdzBFcHU4cWxXV1paZDB6eFBYekNMUHJhUm5hdHZn?=
 =?utf-8?B?ZDVwdURPbmtMRStXVXRwUWpJL0lKWE03VFZrQmVPOEwwZnByV0FvRDhINzU1?=
 =?utf-8?B?NTdkMi81eFhEdFM0cWhWRmEvWS8vQzY2ZjEvUzIwcXNsY3k3RlY5dWM3azF2?=
 =?utf-8?B?bE9tVWtTODVLQ0FDSU43NDlpRXgxQTI2Y1QwdTdDcnZ1bDBNTHJMUTQwRXdI?=
 =?utf-8?B?OTVIV09xN1Q4b3hydHBiZ3NRbzFMaUlBRXN2Mkt5RnpLTjkzNFpQckxpMmNJ?=
 =?utf-8?B?bTd0dUNPY1BWME54bEs3N2RVZ2EzMEZ6Mk81bHhyQWg5SXIzbDd6cTkyRjg3?=
 =?utf-8?B?ci9nQ0NyUFlCS0xIeWR4alplcHl5NkpROWIwMGQ4TWlKZFlBN3FwYzlUVmhx?=
 =?utf-8?B?d1pCcDJkWGF1MGdGd1JRdUs2YVcyM1MxMEZHcjRxbWFGMFFPZ0NBb1pDY0ty?=
 =?utf-8?B?a2tSeTFMTWJHY3dmT3I3YW1hNkx1c2RZQXFnMXppQURVMVoyaGZSdUVWMzQr?=
 =?utf-8?B?bHdMLysyaTVoY0gza1YzOHNzWlN3NkJsdVl2N1FNSkVDbEE1ZEpqV2ZXeGZz?=
 =?utf-8?B?QWRFb1pCRTljZXJWTUJOMUpwT1I0YXlhNjllZGpjdW1udldBUE04OE1odWRE?=
 =?utf-8?B?UzBoQUVpYVpYNTE4d0FxdTRoV3FaRFUxamRjdXU0SDQ1SXQ2N09Ec1YwcTdS?=
 =?utf-8?B?Vm1BaUZ0cG1uT3VoMlQ2T3E5RHJid3lXUWhaa09TUVMxL3Zmc1ZYWU5xTlE2?=
 =?utf-8?B?a3g4K25ObDVJOXUrN2g1bTVNa0t5ZzZtQVVMU3grV0Rkc3hJTDZ6dVh5Tmxh?=
 =?utf-8?B?bW1tWnhwR3krdmQ2WDFVT3VCR1l6ZlhqNG5kRUhSYVhqa2hVYlZoWkxFQXhl?=
 =?utf-8?B?dmZYR2t3RWtYdk9MU3lhRmFXYmRabEhSOFV0NEY3ckp2KzVuNFJDWDkwK0t2?=
 =?utf-8?B?QytyRXhMeGpwQTNtSXRxbUhmZVZVUnp2ZVY5enl2ak12SXJHb3Y0LzlLM3Mr?=
 =?utf-8?B?SEh4TUhSTVFWUlJmRTEzb0M2M2d2TUFNYVA2UnlNc3FuaEk4MUdFZWM2N1Vh?=
 =?utf-8?B?RFhNcWVtYTZqMXhPMDJVSzNydERMTlRIem0xSzRYaW9tbHU1bmtDRlVPTkpE?=
 =?utf-8?B?R2NGK3dZTUZObGxNbHNrNFllS3RiSnVTYmVwNDZDQzczdGtMYW1mK2RwNDIy?=
 =?utf-8?B?SUViWGxXVmhESWFrZVNOd3o3VWFKZURlMTZVT0ZVVUJITEo0Zll2NEs5bDdi?=
 =?utf-8?B?WkZIUUZMaW1OUWx4VWhRMHc0R3VPckgxSU9RR0w2dGdoU3RaMkwzQUVUZlRZ?=
 =?utf-8?B?UlM4eEhmSnNMdVI4QVV2UTkrUXdBaXR2RjhPT2VGSS9OTTZVN1NBM0NEVmlC?=
 =?utf-8?B?S09xZWtpa0ZXbFFVZVdiM1crYkdUZytERVNuK3d3eHgzakw5ZVBPODNrQnNH?=
 =?utf-8?B?RytYTU9Pc3FTbEYyS0N2MUtZWGdjSUtKR3NuemxscktSeEhNaVNPaFBuOTNW?=
 =?utf-8?B?VXptcnBvZXVGSStTUFNjVGlYMlpzblNRMWkwME54YmxpaW55TzdZN0psay9w?=
 =?utf-8?B?U3VHcWRMNkc2K3hidGJBUTlCNWVLYUR5UFR0SnBVdXZhcFRIZ2FoM1JEL0x3?=
 =?utf-8?B?ckxZSm1jREFZSEtoT0hsQmVYVWJaY0s1THAzRW1ramovNjNFSDNaWTFxMWR4?=
 =?utf-8?B?dE5kakNIZEdReFp3VlFYMTY4MzlqczhGdXFHOFFEekc0TlVPOWVBK2piTmtI?=
 =?utf-8?B?Znc0eXNUL0ZqOWNWNGxsYlN0b3g3S3gyZTBZTTMrd0tLZzllcGt2QUtJVWRi?=
 =?utf-8?B?Z3AwSnVvTWI4WHcwaVh5YWxqaEY1enA2SE55Z0lVWTc1bGtrWktEN0VsMFg3?=
 =?utf-8?B?R3VJa1dib1V3dlVJdnl3MnM1b1ZoeGpTNUJIY0hWc0pxV1BETy9sWTIzN2VZ?=
 =?utf-8?B?ZmQyWVp6aldYaXNKS0xGYW5mdFZ6a1ByM1F5WWMwd29QYWxCeTlYMzlZc1VW?=
 =?utf-8?B?Z1F4L3ZYTzZtdGJLQ282ZS9lQW9CRmFzeFk3V0czY3VxRlVjcXVzVDd4S1Uy?=
 =?utf-8?B?RGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5BDF685612A2C499ED2C729622EBA25@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SS9HNEF1MWwydHVnc1ZOcTdzYi9WTk1rQnJXRm9wZlRJZXRvak1NSWhxUGs4?=
 =?utf-8?B?QnU4NDdSdC9lN0pTcVFrbThyQWU4R0dhYXl4bFNKa05jajdPUzlmaDJ1ZlRh?=
 =?utf-8?B?N1pibG9td01zWkhXVGthYXJiZ3BMeDJiMXhoSmhIQUZJOGdnSFR1NFlDMWNk?=
 =?utf-8?B?SkM1Unc4NjVsd1A5Z3BBL3FtY2FTcWNpVFhwU3J4azVCZHYyV09Cc2ozSVlo?=
 =?utf-8?B?aklUcUZCWE1WY1RaN0E5MVkzeHp5RTkybUhYYlhDaEVRUFY1dnkxZXJ1YWls?=
 =?utf-8?B?QjI2bDhYR3d2dHgwYVJjM1Z4NmlVTjU3WFlVVm84OUQ5UitISm1YcSttckVH?=
 =?utf-8?B?WnV0NTRlM2pLRVljcENBOVVwK2RsN3k5bWRVK3U0MVRHU09NbThDRUJabTUy?=
 =?utf-8?B?cFdyS2k3OTBkUmt4eUp4ZVFhc1V0OVVRQ3c3TUV4MThRdWtWdmlwMzVZVndE?=
 =?utf-8?B?VHU3U0wrWlV3QURwMklveFVSRHhheUgrVGNUOVBEbWtYMlkxRXRLOXhEQ0ti?=
 =?utf-8?B?MVcxQUNJZDFiUmhicmlvS0phMGZTVEFVME5xc0RTaFZSaXRTYkdzOWNTNlR5?=
 =?utf-8?B?NXVHU28wT3FJUnZ5UWxrTjIzVUQrVlJzOTdPVEF3cllkOXhndWpSbU1tZ3Y3?=
 =?utf-8?B?bldSd1BZdmR5Smdka0N4SlUrVURmWDFiTHFQVFUzb2FtbHdubnQxdGQ1Ly9h?=
 =?utf-8?B?Z29PUWcvYmt4andWcDRKWGlBUHBnSGovOE5JOXpsOXJNVWVyTlo4TmJKc1BO?=
 =?utf-8?B?ZGUvSkRQcy8zelhzUkNUanc5NjZVNnZNNEIzVHhob3pRcW1JSHFCNklQcGFu?=
 =?utf-8?B?OSs5VEtGOEV6YS9XRnV0dDZJQ05leFBSejNaSzV5UnlVdTVBdFlnU0FJeFpJ?=
 =?utf-8?B?VFh5OWdQeEFyZlpsZTA5ZkFoTm1EOHZCWjRYVzFsZEREWmlkeXRtVHZpTkFp?=
 =?utf-8?B?VWNuOHVVSkNWcTBFd3RXTEtmejdVazREdklRVml5WW9PY284cjhOdTQ1RnJp?=
 =?utf-8?B?SGxpTzZicEV6aFI4RDJRSkJuY1kyaEo5dVo0R0x3S050b3NKbU9LSFp5UGdy?=
 =?utf-8?B?eXVieEVsa21EQ0V5clVhR0dvOGwvRTNlL2Vpa2dKWmp0MUViVjh1ODUrWVlD?=
 =?utf-8?B?YUxYNHdGVFNyb3NhRWF5QzFzVG9qQ01kQnpIaUFjTDV2cklSb1pTNTNKMGhW?=
 =?utf-8?B?ZEpaOTFiWlZueWhqdjNhd2pZYzVYUEdKYVdzcy9ia1pXVm1TaGN5V2NJZ2Rw?=
 =?utf-8?B?TDZXRXRNM2xNTmVPdXM4RExIZFprL05ZRTRQSDZOTW5KVWVIY28yTXlaVjI5?=
 =?utf-8?B?MFBCUGtWYWl6M0xRZ2VtbGVTVTBkWHc2WUVyODhUZ2x1QXIrMmhFcFEzWWhI?=
 =?utf-8?Q?hmjC39C/WC7VlXBHZsTRmzjYN5i83f80=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd70517-dc30-4295-09df-08db922a87b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 00:59:16.6234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R8cF3bdQ4P1Z1hw4ESOry6avB+ugUmur838YiEFKKfRAJA/FWXGLiasB6OvXCDhoR2OTRzoEIqRmUk9FjjKx8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5465
X-Proofpoint-GUID: WXXEKR7aZJ6ZghcXdoTkc7ooLLmxO8Ou
X-Proofpoint-ORIG-GUID: WXXEKR7aZJ6ZghcXdoTkc7ooLLmxO8Ou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_18,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010007
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBKdWwgMjgsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IE9uIHNvbWUg
U29DJ3MgbGlrZSBTQTgyOTVQIHdoZXJlIHRoZSB0ZXJ0aWFyeSBjb250cm9sbGVyIGlzIGhvc3Qt
b25seQ0KPiBjYXBhYmxlLCBHRVZUQUREUkhJL0xPLCBHRVZUU0laLCBHRVZUQ09VTlQgcmVnaXN0
ZXJzIGFyZSBub3QgYWNjZXNzaWJsZS4NCj4gVHJ5aW5nIHRvIGFjY2VzcyB0aGVtIGxlYWRzIHRv
IGEgY3Jhc2guDQo+IA0KPiBGb3IgRFJEL1BlcmlwaGVyYWwgc3VwcG9ydGVkIGNvbnRyb2xsZXJz
LCBldmVudCBidWZmZXIgc2V0dXAgaXMgZG9uZQ0KPiBhZ2FpbiBpbiBnYWRnZXRfcHVsbHVwLiBT
a2lwIHNldHVwIG9yIGNsZWFudXAgb2YgZXZlbnQgYnVmZmVycyBpZg0KPiBjb250cm9sbGVyIGlz
IGhvc3Qtb25seSBjYXBhYmxlLg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBKb2hhbiBIb3ZvbGQgPGpv
aGFuQGtlcm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IEtyaXNobmEgS3VyYXBhdGkgPHF1aWNf
a3Jpc2t1cmFAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMg
fCAxMyArKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmMNCj4gaW5kZXggZWRjNzljZTcwNTg4Li4wYWE1ODYwMGE1NjYgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jDQo+IEBAIC00ODYsNiArNDg2LDEzIEBAIHN0YXRpYyB2b2lkIGR3YzNfZnJlZV9ldmVu
dF9idWZmZXJzKHN0cnVjdCBkd2MzICpkd2MpDQo+ICBzdGF0aWMgaW50IGR3YzNfYWxsb2NfZXZl
bnRfYnVmZmVycyhzdHJ1Y3QgZHdjMyAqZHdjLCB1bnNpZ25lZCBpbnQgbGVuZ3RoKQ0KPiAgew0K
PiAgCXN0cnVjdCBkd2MzX2V2ZW50X2J1ZmZlciAqZXZ0Ow0KPiArCXVuc2lnbmVkIGludCBod19t
b2RlOw0KPiArDQo+ICsJaHdfbW9kZSA9IERXQzNfR0hXUEFSQU1TMF9NT0RFKGR3Yy0+aHdwYXJh
bXMuaHdwYXJhbXMwKTsNCj4gKwlpZiAoaHdfbW9kZSA9PSBEV0MzX0dIV1BBUkFNUzBfTU9ERV9I
T1NUKSB7DQo+ICsJCWR3Yy0+ZXZfYnVmID0gTlVMTDsNCj4gKwkJcmV0dXJuIDA7DQo+ICsJfQ0K
PiAgDQo+ICAJZXZ0ID0gZHdjM19hbGxvY19vbmVfZXZlbnRfYnVmZmVyKGR3YywgbGVuZ3RoKTsN
Cj4gIAlpZiAoSVNfRVJSKGV2dCkpIHsNCj4gQEAgLTUwNyw2ICs1MTQsOSBAQCBpbnQgZHdjM19l
dmVudF9idWZmZXJzX3NldHVwKHN0cnVjdCBkd2MzICpkd2MpDQo+ICB7DQo+ICAJc3RydWN0IGR3
YzNfZXZlbnRfYnVmZmVyCSpldnQ7DQo+ICANCj4gKwlpZiAoIWR3Yy0+ZXZfYnVmKQ0KPiArCQly
ZXR1cm4gMDsNCj4gKw0KPiAgCWV2dCA9IGR3Yy0+ZXZfYnVmOw0KPiAgCWV2dC0+bHBvcyA9IDA7
DQo+ICAJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UQURSTE8oMCksDQo+IEBAIC01
MjQsNiArNTM0LDkgQEAgdm9pZCBkd2MzX2V2ZW50X2J1ZmZlcnNfY2xlYW51cChzdHJ1Y3QgZHdj
MyAqZHdjKQ0KPiAgew0KPiAgCXN0cnVjdCBkd2MzX2V2ZW50X2J1ZmZlcgkqZXZ0Ow0KPiAgDQo+
ICsJaWYgKCFkd2MtPmV2X2J1ZikNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICAJZXZ0ID0gZHdjLT5l
dl9idWY7DQo+ICANCj4gIAlldnQtPmxwb3MgPSAwOw0KPiAtLSANCj4gMi40MC4wDQo+IA0KDQpB
Y2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFu
a3MsDQpUaGluaA==
