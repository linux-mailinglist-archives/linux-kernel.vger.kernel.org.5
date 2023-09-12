Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720AF79C43D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbjILDeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237728AbjILDeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:34:02 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE67B3A8D;
        Mon, 11 Sep 2023 20:33:24 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C2rw4R028505;
        Mon, 11 Sep 2023 20:33:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=1a3dBSUl8DPfL1PXYOc1ROgUu7iqhgxTawhSWbihNp0=;
 b=iK7HREe9fs/vf/4scbR0p0zDtCg9XjxylLzHMjv6iXwxjX1+JRLatbuInY5pZx9XyUtG
 SAFaFeE9WF94C5dZStOkB8Xzi7ef7knrw6GXiK/VWltJbFoUCYuYmOlv+g7EykZP91i6
 lgUuiSoFSAYrH41jLUZ+TleJWFK9eJt9nY1MjRdnm7yxy06lYvktqOXNL3B8aB2U1qM/
 fVM8AwyqFAYQBx9aUxyiEFtneOZYaHgpHHwKehD7ie1oUZDgJ/Rbje2vFT+Ye5O4Z7UT
 uxi+q8DXEQVw0mx65/jq+9zyAZvNABz4qqwcRRFIVGTvZQkhX8iztIPMfUJiZNeLLd/U cw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3t0qqnj20c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 20:33:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1694489585; bh=1a3dBSUl8DPfL1PXYOc1ROgUu7iqhgxTawhSWbihNp0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=bH5B/vl8RQDvQurbf3ryWOabWrC6z1SMsO1QgWX2aK9zuy6DZ4k4tD65E+lvuRAUI
         ikFEdMHC+KqkW8eTB/YsSe5qB+H/sOXLQ6TQqoHw185yZ86eH6u34EBVBVP7gpDJLu
         3NO9HSA7hj+0dVKOhci75CY/WGULOqdX15qWTbXQ9L5HHeebyJducH6EP6u22faK/X
         H9weCCLXaJtCINEGOaV8I2Fn6FNDj5XAwu4LfzWQ5WWGHkiaH6ZMClAUFYhUN43shC
         K5o1rZK3dZWZ5f9A3BPnZ8zkObf7DWuLQ/sQ2FYnaHT+0u3aja8tF3qibZlyETt1RV
         G/dKL0/YhcmhA==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 899854035C;
        Tue, 12 Sep 2023 03:33:04 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 89DD8A0077;
        Tue, 12 Sep 2023 03:33:02 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=VGG6AoXa;
        dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3EBAA4068C;
        Tue, 12 Sep 2023 03:33:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFvu1TyYDLRxt8CXaBkd2dNjWqGwEQi57hw75ofVTWUMEw3rDmWPAjGiSMiq/Hfj6Ae+JtDFNdBnf4fYJOM6YkWKBoDnjg9l8L8gMuzlBadsyxXBJVP8TrvNomf+xqB7yVKIvXJfoJ4a7gsC3AYP9XNezdx9JVeIENv10Je8Da7PQsk0X2FsCzc9aEMJvPhKiXh3a31RFaUmVPPHLbwz4tT5YonT8WhfL3EAgudqbtAb+fj+hy4glN57vO+h7qEihzed/apAIvwGiBphY6+hwg/P3INESjJYLfHVDe2bPL6j/GbL7mOMGoTN9aFwbrj28znHeuJSCEFLSLjF8qrj0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1a3dBSUl8DPfL1PXYOc1ROgUu7iqhgxTawhSWbihNp0=;
 b=NGcqzhfmg1Nx/+OInfVJnz2i5CGXMtSCOLmJV2Y3Yo+4NJCg6YGbLZVNe0LphrLDc93Isu8a+/vv3aOk5YfKYLJXw4mCVnAyAAruQfuh6knEPhbrAHarYwtogT4Q2NjjKNjddA+do3VG6B6JMARJbw1YtpqNGuxTakEkt61+yZLHIM/J5AqTJmb68Py95VJPQmF2BsiduiHdpTt73rNj1vIOqrC7Qq4pRVcQ+j9iCHQVlgGUFlisuyS0fGf3iZDYmlKDeOopqWn3DT7YptCGbbMXarezadKn5j0BHWKISuaNzWtKg5Dxbz8MTDCmbk9ZZT7QGsPb93XGGWVmgLrl/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1a3dBSUl8DPfL1PXYOc1ROgUu7iqhgxTawhSWbihNp0=;
 b=VGG6AoXa5PDO/xKcaLqwfV9lpCFEgH84iltE3VewH/0V8IGfi93XXZd41F3DeESzu62o6D7PQ7rvZgInUcvhwEJGGVOfuUx2xI4hbDCSGzkR0esqyoJJQtgVifl9Gpkxb8fOCEE3HLs6RwG1nJVY9IFZS480CGFOSKFBQ6qdOzE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 03:32:58 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 03:32:58 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 RESEND 1/2] usb: dwc3: core: configure TX/RX threshold
 for DWC3_IP
Thread-Topic: [PATCH v2 RESEND 1/2] usb: dwc3: core: configure TX/RX threshold
 for DWC3_IP
Thread-Index: AQHZ2XPbT3nDD3HafUCfXa73QfjMT7AWYM4AgAAzcACAAAx9AA==
Date:   Tue, 12 Sep 2023 03:32:57 +0000
Message-ID: <20230912033256.g3ya63yg4duxe22h@synopsys.com>
References: <20230828055212.5600-1-stanley_chang@realtek.com>
 <20230911234408.xb5higafb6ssajyt@synopsys.com>
 <567f066c59de49e88dec4bae459d1dcc@realtek.com>
In-Reply-To: <567f066c59de49e88dec4bae459d1dcc@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA1PR12MB8859:EE_
x-ms-office365-filtering-correlation-id: 6cfa4f60-aa34-42ef-1911-08dbb340f56f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D/wLzY4Av3Eskb0JjmLkKP/yJfC4Zfe7x5muZmtFpX5HbHDEwNg3Uin4jJ70O6Q1S3t3L/894DLdCsBtVEdytp9YCgpyWc5GuXAmpahZoBUqpip2j5yDo8oBQii6CeitZRCKE43aOqxE8RyDQVSXiHnPDlMjDVjCkyQZBGNqlVbw1PzhpzMfN8RufdsFDVyD5xvQCcZSRX9rh7HsOVBWaeT2Nc5EMdAUZ1tdpBOwXMVe+xreLZimB/y5dueiedx1TMbv8Iq4/KW6yjz9BjWu5x7wPjgW8HdF3zVohmKJIVlg/hefyZoOIO8IpjVzfpykf9j690Ic94URryS6LRIGmphGh5fg9/KTdG4DrO1J6c/0QR7EunH3TzT6dMal5vo8giQj2TNsTpWkiRXXA4k/tvBWapScAbW4IUQ64H2oCybiUe8ji9+3fkx6+ofabHwERfuX4r+OgeO6zMqI78Gjp9zASlNbNNe9Fm9xJGrE6P18C7ndU2mQhBnas+gbB3wyvtSlc5tOdgD53qfY0HJGwNbfr5I/JWGfVU+0p4C/pFv65BP5TRWx/wBSPgcPGodiybALB/WQxhVTYSpVAPHGnc1yYCsbEz5wTW3/RjPL1+LDWhal760uKxSalacCdf1P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199024)(186009)(1800799009)(5660300002)(66946007)(41300700001)(66476007)(66556008)(8676002)(4326008)(8936002)(54906003)(64756008)(6916009)(66446008)(316002)(76116006)(122000001)(478600001)(36756003)(38070700005)(71200400001)(2616005)(6506007)(4744005)(26005)(1076003)(2906002)(86362001)(6486002)(38100700002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkNNWkZwajdEc3VzSU0vZ2N5SHRmbXlWd1l1UW9tS29sWmVUd0poSUhtU3NT?=
 =?utf-8?B?L0RZL0pYSUh1ZUYramRkUkM3cE9zRDlFcy9DUWp4WXJVMThRSEtzQW5ST1E0?=
 =?utf-8?B?dk9WVU5zaHVDVm9YelZ5ME95SlVIQmJnZXlvZkUzTDY1VHl6dWtvMDFMNW1F?=
 =?utf-8?B?UDlvVTAyeHRmb09RYmVOaFdDQ3hZMmVJK1ZBYkVUS1Rwc3drVGE5enRXc1Fv?=
 =?utf-8?B?SkxFcVJMRmRoYkhLa3dQWmpBWWtrb0ZxazBrVGw1UUJmMGgzOG84cE53T3dw?=
 =?utf-8?B?ZVpxNEEwZUt5RVo4dVlqOE1XeloyaXYwRG91V3VSaWhFekRxVjRleDRRUWpT?=
 =?utf-8?B?WmV6THJGbDFDM1g1TWZwTGxKeHRiUHo0bzdLNitReHZneXVpWE5XK0pDM2VX?=
 =?utf-8?B?RUdqUjNKRHUybGhHM01LdGlWQTBzRm16Z1ZrVWw0eWc3TWZ0a1ovVlVSUFZ5?=
 =?utf-8?B?YnVwb0ZpYVJMRitzNFdEMmVpcGxieDl3UTNDUkwxRnZyWHBMaUpSZkJWb1Mx?=
 =?utf-8?B?dldHZmFWREtEUlNLVkZKTVMvVUFrY0llWnJPOG10NW9nV2xxUFUxQnU5NmVJ?=
 =?utf-8?B?aWpuNzQrRE1BKytaOG9BRjIvM1J1RlcxajlyQjJ6eVJmaU1iUmsxSDlFN2ZK?=
 =?utf-8?B?cFNmVW5ySDlka0VMRjZUYis5SE9sTHljWWxPN2lzNTRxSFVGdEtHVlFOcTdS?=
 =?utf-8?B?SDZDYjlOOVVxcytoRWNWRVRqOG9VU2d0L3BLd0NkMldYRU1SMmRqdkswM2Rx?=
 =?utf-8?B?Y2lQK0xHUWowd0dQMmJIUnNnalZid3BsVGtxd0hJdytibURTVkFGUHdScUx6?=
 =?utf-8?B?bXVnT2FMKy9TRE1kOXYrTnkwTFF1bWVva2ozNDBGaS8yQzBHU1FiU0VxOVRN?=
 =?utf-8?B?cTJhZzBrUCtXenR3Q2QyYkFrTTUvb1RsdFdyTDkyWFhXS3duclYwSytyMFdm?=
 =?utf-8?B?RkVjNlpZcjNCSEZhYzlLVzJlaE13aHpnM1JGdW1RMzczZ1g0am9ERzk3RnQv?=
 =?utf-8?B?RFAra3FwajIyelFxdy9MNk9iNFJDRjNFZnc3QU5YTWVOZHIxanpkcnJkUlBG?=
 =?utf-8?B?WFhUbnE5WW4wUTBqaEZXTG1abFdDbVJ5WkZJU2lTRFJ4anRwLzFtYUl4YUdm?=
 =?utf-8?B?NmVJV3UvcDE0QkxjVmR6SmROREZwN2dmWXZCd3BIVWtzSGhCbE82bHhRaUIr?=
 =?utf-8?B?bCsxcHUxbm1sd2JKQVRsL2JPUFhwTVJsVW05Tzc5QlZIeXorcS9CeC9vM254?=
 =?utf-8?B?YW9kcnYrbS9lV1RkWERFeUsyUTZCcUNZSUt4NVBwbFVWd2x2R1oyUDBhOXgx?=
 =?utf-8?B?SEtCRDVjM0pBd2V4U1BHSnJuNnFlNW55MzhJYmNFQ2FQV0lWZzhEc2JUSHVl?=
 =?utf-8?B?VkxDckhVb2VrTGFZZnlmWnNDRmVhbWlXQnI1b1h1RXdXWjZFWUF5ZjFnYTFw?=
 =?utf-8?B?ZXdsVFpYQ2ZudHkxdjJ1WHg4WTl6d3ZXRUQ4dTc4eWFsc24ycUlPU1JobGlS?=
 =?utf-8?B?TVZBV21sQVFUczF0Y29pNnkrSER0b0FEbmpIbmpxZ0NiVWJoMk5wNkJNbGxp?=
 =?utf-8?B?a2Jua0RBYkdIeXZPSUN0dEpJaXVvcVpqRUZjcEJrNHdJVUdMOFJqVU9SQjZq?=
 =?utf-8?B?a3JzMFk2b0J2SkJGNWVtUnR6OGh0T3VBMXNIVC9iNFRhTkJIb2ZIQXB3eTBU?=
 =?utf-8?B?bHNmTXc1OFQ5QlNlYlZxWkdLZjcxRFNobmMzZmQ3ZlRDakxlT0NkVitUTlNP?=
 =?utf-8?B?UUhZVHg3UGVoSkhBR3lUQmxLMlMwaUlIYUMrWlRRLzVYZ1I3QWd6bU9VZU54?=
 =?utf-8?B?bVNiVnNScFNWM01PWUF3eUVmUE5kN0Jza2UrMGszVmJsbHc1eTkxOXF6d1hX?=
 =?utf-8?B?Sy9wUStrb0I2VGwrQWxQN3BaU2hFb2R3aGpTZ1kwOSs1OFhiUTYvbDJIaVM4?=
 =?utf-8?B?REd2YWRCNmNNZzNpcFJRWHZ3eFpUTC9JWnZzaGlxMXpKWGx3VU5TMGV0OEdY?=
 =?utf-8?B?Z1hVVG56dmJqSUg5ZDBRVnlQZzllazBJUm1KZmpBa1lmTXo3cFdCa3JjMzZz?=
 =?utf-8?B?OHg3bkZnNS9ubHduRHFZaWpaaXRXQWdOOFp2VmpieGNwSXVzcXc0RmN6MTFJ?=
 =?utf-8?B?RjlUZTd1R0diV3hKanZXNzg5NWF1M0VaMGJ3TVNMMXBSbHo2QmYzZ3pUY05J?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7D35AFA63209D47889F64B103F2856B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?djdFOUVGZVlYZWwzdk5OR01uOEhOUWlIZTA5aXZ3cWhKMVZJUklNaWVtQ1JR?=
 =?utf-8?B?Y2dMOGRMcGVPUGMvQTFxVzVyWEQrM3drcjlZdUR1OTJyeGoxaWNldmFLSnNK?=
 =?utf-8?B?alJqdVRzbTg0SHhtbFora0lKYmg0cWFLd2tnT2NCZHRYbEhxTURMREoxa2p4?=
 =?utf-8?B?Ly9OeWRKM21iNGQxS1pGc3BLN0I5K3lhTk4vWVRKVjRhRlJTT0drZmV0VWNT?=
 =?utf-8?B?TzIrTWQxVktxMUVwbDQwSk5ZcHNkUEphNWNrR2cwSHJ1ZEtQYjF1NmZtMzh4?=
 =?utf-8?B?Mit0VHRITVRMbmgrU2FLVmkxUEFHZmQ0dUw1TmZHL2VGcjdCckxNQmxKQ2Ja?=
 =?utf-8?B?NGlicUZGa0M5M3Z2Nzc3MGthY0pHankyYkQyYmhXSGVhaHpDWkxnUUNXdUtO?=
 =?utf-8?B?dTJIazNUdHlHN3pWMVl6cFJPNkd6N0xhMk9VdFhEVkQ2VHRhb25FbGFBZXoy?=
 =?utf-8?B?clFkZE1lZVRaU0NnQi9vNURoM2ZGUkVmdHRmOFk5djVYc1hMWklFWXRteFpL?=
 =?utf-8?B?enJpQmYyek5aT003T3FMSXlJVjAxcnFkb2IwYWppUDJlWUZaZUFnaVdZdVF5?=
 =?utf-8?B?N0hucDdZRnJNZnFNdEYxZzd3cVAxUU5NUlh0ZXIxekJ1R1E0dEd0MEdJTDdp?=
 =?utf-8?B?dHZkOHA1cyszd2JhVlYvS1duZWpSbHNYNlJYTjZadHp5UnJLWDZpMHcwMTh0?=
 =?utf-8?B?NXVVbkNSeUl3ZHNKTmFyM2xxdEwwQnk4NjBwNFhkRkhxUzJHLzdFMzBDeTRp?=
 =?utf-8?B?OGZ5a2s0QkR5YXVtRDJqdkk2SlE1TUg1Y1NQVlRzUThDekUvSmtTaHZjdGZW?=
 =?utf-8?B?bHRkbnNkZ2VPWEsxUk0yeHI3eTQ2QXBjdG8rUUtaZk1ybTBzbkREVFBHVnRJ?=
 =?utf-8?B?L0tzTFgyVzVyQkNmUTFEVTV2Y0tzNEN4ZzJtWjZKYXUzSC9HU2ZuRWMxdGFi?=
 =?utf-8?B?OGZMTjBNNk1nRUxURnVrLzN6SlVkUktTT3Z4bllzZnhVdklVRVJkUDJDVmtQ?=
 =?utf-8?B?cnJYQk5IUnhVY1FYb2JTR0hueFJrUjF6d0t2bTVTUkxGS1k0ODg0TENQZnNV?=
 =?utf-8?B?Zld5TGhTaHlvcUExV1o0Zk1veGNvRFFxeDFjd3VRejV6cDgvRmRLRlVuTUNy?=
 =?utf-8?B?RUErSmovekl0b3VMMC9vQXdYdUdIaEFaak8zY3lzdWFpYTRsRU5UMjRxUVdp?=
 =?utf-8?B?ODFETkJIaHg3RGtzNWZIY3ZlcnVzRXAxVW16cFR4ZFlEM2dqeWszV3ZWVXFo?=
 =?utf-8?Q?Y3yEvUUEVdasv3/?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfa4f60-aa34-42ef-1911-08dbb340f56f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 03:32:57.9645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dtVFxeOvC2iyBHZuXcCF89f86s9hyamU4gAkXI3yRpmL2+hjwNNlXcc/Vg9x2RJ+AcEzftoyL4yB1VtF0P+SIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859
X-Proofpoint-GUID: acCRI1Htqi1yEiWgmppwzkLUo4JaRcLA
X-Proofpoint-ORIG-GUID: acCRI1Htqi1yEiWgmppwzkLUo4JaRcLA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 phishscore=0 mlxlogscore=584 bulkscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309120027
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBTZXAgMTIsIDIwMjMsIFN0YW5sZXkgQ2hhbmdb5piM6IKy5b63XSB3cm90ZToNCj4g
SGkgVGhpbmgsDQo+IA0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGluZGV4DQo+ID4gPiA5YzZiZjA1NGYx
NWQuLjFmNzRhNTM4MTZjMyAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gQEAgLTEyNDYs
NiArMTI0NiwzOSBAQCBzdGF0aWMgaW50IGR3YzNfY29yZV9pbml0KHN0cnVjdCBkd2MzICpkd2Mp
DQo+ID4gPiAgICAgICAgICAgICAgIH0NCj4gPiA+ICAgICAgIH0NCj4gPiA+DQo+ID4gPiArICAg
ICBpZiAoRFdDM19JUF9JUyhEV0MzKSkgew0KPiA+IA0KPiA+IFdvdWxkIHlvdSBtaW5kIGFsc28g
YWRkIHRoZSBjaGVja3MgZm9yIERXQ191c2IzMSBhbmQgRFdDX3VzYjMyPyBCb3RoDQo+ID4gdGhl
DQo+ID4gRFdDX3VzYjMxIGFuZCBEV0NfdXNiMzIgc2hhcmUgdGhlIHNhbWUgZmllbGQgb2Zmc2V0
cyB3aXRoaW4NCj4gPiBHVFgvUlhUSFJDRkcgcmVnaXN0ZXJzLiBUaGUgbWFjcm9zIGFyZSBhbHJl
YWR5IGRlZmluZWQgZm9yIHRob3NlIElQcy4NCj4gDQo+IERXQzMgYW5kIERXQzMxLCBEV0MzMiBz
ZWVtIHRvIGhhdmUgZGlmZmVyZW50IHJlZ2lzdGVyIGRlZmluaXRpb24gYXMgZm9sbG93cy4NCg0K
WWVzLiBUaGF0J3Mgd2hhdCBJIG1lYW50LiBUaGV5IGFyZSBhbHJlYWR5IGRlZmluZSBpbiB0aGUg
Y29yZS5oIGZvcg0KRFdDX3VzYjMxLiBEV0NfdXNiMzIgYWxzbyBzaGFyZXMgdGhlIHNhbWUgb2Zm
c2V0cyBhcyBEV0NfdXNiMzEgZm9yIHRoaXMuDQpDYW4geW91IGFsc28gaW5jbHVkZSB0aGUgc2V0
dGluZyBvZiBHVFgvUlhUSFJDRkcgbG9naWMgZm9yIHRob3NlIDIgSVBzPw0KDQpUaGFua3MsDQpU
aGluaA0K
