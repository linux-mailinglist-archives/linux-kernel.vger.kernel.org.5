Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886358018E8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441953AbjLBA0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjLBA0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:26:51 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5C9129;
        Fri,  1 Dec 2023 16:26:56 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1MaKSQ011341;
        Fri, 1 Dec 2023 16:26:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Jb5uzTOkZleQ/zk0YjW25TmWy6t0if+qqz5XSQSHOLg=;
 b=oTSdUQQY6gEGS/cpJIxSwS5JKZP7gjpEvh78SLFduN8j0IfkjGdCZ6uFe5qIVSqcL7bm
 dm/iHlQ2bhWjd76Enjiuq7saqeiCecoczcQLU5Uyg8Dlj5t3QUm6Sw5CsoBp3YMZvaRO
 ICYtW44kaQoEfLFWSj5aSp+/QmqH23EB6D1xHKDXGpoGgNjnewCJWjLDLmJRg0R6OgNs
 OyEKTpBIRb8eGL8zKf+gq4slNyOWemSAXJgDLdFWB9tJQ2Uv12YjOHK+LJakYBPJk/zX
 1zlpngvhe21JyACAjiFg4zYUh+uPKjWzkNhVgVV9/aPoXJEHsvpJ1L/QctuI3CPqewE+ yA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3ukgempmmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 16:26:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1701476805; bh=Jb5uzTOkZleQ/zk0YjW25TmWy6t0if+qqz5XSQSHOLg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=h17F6tPAAUOGrGVC837ksBlnHOJ41eVFWbP8My5rEbFJJ0VzUCka2UH/sy0v9HkNE
         VZT/NUVgbm7IJPwkpkSJ/avAp8yN0SOCPSt08rPBJxyVxXWnjqD/IdSet/I3RvCrKI
         8mWCNMwPm9zqFvfN542O+N9lcX7fSDM6HQ14WsIrH+9PUamyzMlLWP03IheB84VqmG
         s8uW++FSsgPQ4AQKi1nJnO+npdmHWD7m3dvrApnxpcS5TFxto0zkdGcLPS0AIbYWX4
         tWWil0slGLaJU26OF2uDIhBiz9xseawfzBdAnFuMC2UM/HWTFlywFf/CI7NRqekocb
         TyoM2bL8ZwOcQ==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8EB9A40540;
        Sat,  2 Dec 2023 00:26:45 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0FF10A0084;
        Sat,  2 Dec 2023 00:26:44 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=IIaLMB1I;
        dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3C0D5401C4;
        Sat,  2 Dec 2023 00:26:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L19+72AVUC3Axj2XUVlUho2qqbbmfHB0NE6FQ6JNMnnno9HGbrAEUPynosCIQ718MVaSK/ZWAvMNF8QBJMSMU/GB9oZtAIzEZZALgUxKJuSNOGqfJxWpV494+E+GIxkE/6h7zFKp5KbT28R8Ig76/q03pEpLmMfHiiETG3E6zSHsn9Y/uElgK532jCXxQzYUAqcwoP1EcCK0ELwWHa+lCFhXcy1uQF5XVul8KBwESdUwz6FZGSVnm7Ipq81meopuUPtQRNkPX51GHiuhMVe2FkvpzFFga6CGKEgKv8dkOzHRTjVBllwrFm29qUUhxWOyrOzIl2GJcK6+anRW3BBO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jb5uzTOkZleQ/zk0YjW25TmWy6t0if+qqz5XSQSHOLg=;
 b=Ndd9GHwE1Cnlec02nN1kL98zw5ijmmOqofKIBy0NksPFC0Icfw0CgYCUhtPIc1uLW2SPZFeF2WEJXxGgNsbFzv9Hm0U20z4ein5KKxv5N5gIjF0SZYuXEwGHv46RdGtE4LBl1r7Otur1sWdom8ptIoZHdvKkGqjjv2hrBs50akszjEITmGuqioKqoaz8xoDq96KhnTQ5M72f+9a95ikFSxdlhLZyeVU71njzpxA0y9I+aTf5JeoLbX5Lh6YqzapNCq1xRpz2jibXcrrMDCOt8IosO8MSyF9tMoSqBinvSOP3qw2AceggswIFJtHXVVYM9tIRS57yd5wquSXcMcDwbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jb5uzTOkZleQ/zk0YjW25TmWy6t0if+qqz5XSQSHOLg=;
 b=IIaLMB1Ie1lc9kJ2wx6DcqAnczKbtwXe74OMCLzK3B+mPxVAG/C2YLIweX6lpPOvqEYSVj1Pf2ctfNWWXKMQta4hiE/BL+bqYAJ63YCGWtPqYlV6RirLU4e35lsCShnt941118P68giNazeVvzp6RaZKq3suUFR+WmBXRHMt7No=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Sat, 2 Dec
 2023 00:26:40 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e%5]) with mapi id 15.20.7046.025; Sat, 2 Dec 2023
 00:26:34 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     =?utf-8?B?S8O2cnkgTWFpbmNlbnQ=?= <kory.maincent@bootlin.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lu jicong <jiconglu58@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] usb: dwc3: don't reset device side if dwc3 was configured
 as host-only
Thread-Topic: [PATCH] usb: dwc3: don't reset device side if dwc3 was
 configured as host-only
Thread-Index: AQHaGKveCMbrfcJ+4k2eyt7FIy9Uo7B9K1KAgACReACAAAQjgIAGzbeAgA+sTwCAAQATgA==
Date:   Sat, 2 Dec 2023 00:26:34 +0000
Message-ID: <20231202002625.ujvqghwm42aabc2f@synopsys.com>
References: <20231116174206.1a823aa3@kmaincent-XPS-13-7390>
 <20231116175959.71f5d060@kmaincent-XPS-13-7390>
 <20231117014038.kbcfnpiefferqomk@synopsys.com>
 <20231117015527.jqoh6i3n4ywg7qui@synopsys.com>
 <20231121104917.0fd67952@kmaincent-XPS-13-7390>
 <20231201100954.597bb6de@kmaincent-XPS-13-7390>
In-Reply-To: <20231201100954.597bb6de@kmaincent-XPS-13-7390>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM6PR12MB4154:EE_
x-ms-office365-filtering-correlation-id: 46a2281d-f46d-4a4d-7929-08dbf2cd56d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ncMg9OvntYcKRd51AqpOMqv671/W0n4CApodqp4+jQPZz63BfLrFbnigXyo6+FFcpyyq7Ry2sBYVL/LR3n+u0jw/W8uEyyN4rvqahmLl92RgiRrYeDFg/ilh5qsZZVxtQ+/YPXuk8rtAb36KZ2l3ftsVjYZJoGUwF1TrU+qTMfmEVIcrTOUQVtp6ogU4DG4wOzss7KOGgryj217dunUFtWnSBp7xa0FRcdeA2h2aN0RDsE5qI6yaK5B0Fy9RGm39s2/L52NX+Z8zusJ4ECl0vXHwjox12Y9u3GcdRdN64kXOn3tlm1TFC0B0wcxk9uGQogBovSUM6LiDtNo6yH921iZwKwUoWYo9Y4lNpn8bqo3wu98YFJcNEfdScw+8p0XD/ovJVk7oo3gy3zaeq0JRWIEQt7eUgeIqsOu9VEInjQDJrwqEAtcaZ0VIWGfyAlavPyxXMEmovQaK/e9pXrknxybRhoKmNlK8WoFZy+xOLYnFCcS8M7vGW8lmxsVbqHPGMGET+gaowC0lE9teYMCoiGpYiGYsjdYB3OiY1+9c3ZupdzXjtrJlnJ9ag5RjxfvwbnTxTYbqCUYE93+9IkagcbzWFP6sYy+TFGG9zgdiBnzqU40DCojpPmY3+eYWjdyL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(136003)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66946007)(26005)(6486002)(83380400001)(6506007)(8676002)(8936002)(4326008)(71200400001)(2616005)(36756003)(1076003)(478600001)(41300700001)(6512007)(86362001)(2906002)(38070700009)(4744005)(122000001)(76116006)(316002)(64756008)(66476007)(54906003)(66446008)(66556008)(6916009)(38100700002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDJuTmd4UlJxV3NwNWM3NkJvREQyTTFZSlVDUGZYS29JQlUzWUd6Zmh6aVFn?=
 =?utf-8?B?RXBhRTF6eGg1UzRLM3F3WXZ4SGI4MzBwemFOcTBZSzRjVXZDb3ZHMWZvZ2lv?=
 =?utf-8?B?SDVUdnhDbGxpZFJFOVB4NWlHbXpQWmw1QzR4UFA5TEJMQkhScXV3SnZ3SXhE?=
 =?utf-8?B?YkNqV3VUZVY0aWZMcVVISEF4R0RGRHhYNGYwajlySFhER3I5enpieGJYM09B?=
 =?utf-8?B?OWpvOENVVE51Z0ZHV3RLZ3ZjNFJDUEZNSllxZzh4RjFjQWtSNjFDWWh1WDY3?=
 =?utf-8?B?eEh3ZVFEWXI0ZnppcXJpMUxWOW5hcUhLRkt3K3VHNVRxVEs4b1gyMnp2YjlM?=
 =?utf-8?B?Y2kxNVZ5cHgya3YrUDFCVVdTYml6MnhPSmRLSDFESDdxRXdxQUcwYlkvdlFu?=
 =?utf-8?B?cTA5d013d1dFNzhTSkdOWnZIS1ZqVDVRTTlYZVFxVjFDcGt1SWFFZDZvbjM4?=
 =?utf-8?B?MzNna3Yrd2FUUDhVMHFzSFcwMVNjTnFhaFF0bjNPd3NlWUN4aUtCV3lSUWFH?=
 =?utf-8?B?bXdjNWZkcEZ3Q3I3QzZQQnVkMjR4ZllJMzNBakhPbDlTRHlyMlE4Vm1mdHRZ?=
 =?utf-8?B?Mk5iRzBndHJqaXhtaVdQaEVjOTlSb0QxS0J3MjhnemtkNWhMNURaRTY5RUM2?=
 =?utf-8?B?MyszeU9VbHBJRFByNkRHNU95ZitWdklIeVZ5WHBFU2pzWjdhWExwVysrdjFn?=
 =?utf-8?B?b1B2SElON2xlelBlZjFFbFVRcFA5TjhhUm9uR2IzUTZEMGJFb3M3bURla1Av?=
 =?utf-8?B?TUpXTDAxblREM0dGS1d4M2lKTHhWa2YwSWVGeGdmM2Q4Q1k4ZGp5Zy8wOUYw?=
 =?utf-8?B?RHNyZSt2alN2QjFKVjZmLzk4bnRVRnU4cVVjR09icHVjYklIeTQ0cWgzSGw2?=
 =?utf-8?B?YlErUmt2K0F1WjFteFBheGRpUHpJRC9jcGZIY1lGa2F5NVBhRDVrZWdTTVdr?=
 =?utf-8?B?WFNWQmpQMGpxbkNHK2RWcyt5dE1ObnlzL0VVVFF3TkY1Ykd2T0dMUGlQZDBV?=
 =?utf-8?B?NU5hL2pLb3lMZHE2WDNoRVowNndCd1BZN2lFNFVlQlN6Z1V0Zk9qUlNoYVh3?=
 =?utf-8?B?WHNVblNVYVVyOW45VFFacnJlSHI0VW1TZmtxZG9vWmR0MlVRQUExTW90c1Y2?=
 =?utf-8?B?NlRGZGlvaWY3c0YxOVVsbFBCejFQSHJpUVhJakIweSt1QVRJaXY5cUZVQ1o2?=
 =?utf-8?B?dzZrK0lCSlZ3WHVhOGI3OTdIVmVxTHE5UEorTlMzU1k5TGtQNjRGbmNrMVBk?=
 =?utf-8?B?QzB5S1pPd3JyZnZPMnQ0ODdjbFU5Ri9KaGJOSTkwa0hzWngzeVRSZitEakls?=
 =?utf-8?B?Rjdkb1BVS3NTR2pUQmxOMGRlbzY2NjFuakZSN0VkRzY4aEdkZVh4aHhINURh?=
 =?utf-8?B?QmpMaDhubDdvWnl2dklsRDVWSm9QV01rTG9xTFJpeFhMb1ByZ3pWOFNRbXpM?=
 =?utf-8?B?cElsaDlodDFYcENEUWdwQW1zY0Z3VFU0YldDUVdMakZPU0ZzTi9YSklyd2Iz?=
 =?utf-8?B?czlIV3NjQVRyOXZodmlEdzZlWkkwS2VpY0c4Nks1REpZamxXdXFQdkxTcUcw?=
 =?utf-8?B?cjA2MEEyUC9tamw3QzE0K1FlTFhzSDhDcEVndTFONE1RbndEdHhKdG5NL3RE?=
 =?utf-8?B?KzBnMVovR2dwOXNpWWZhQUNtanRoSnM0R0JYMXcwSGRmS2RCWnRaancrZUs0?=
 =?utf-8?B?TmcwTVVlNXQ0Q21VcGYyUTZ4N1BqRGhsZjVubC80dlZaUlZ5L1JIVnByekRX?=
 =?utf-8?B?S0V6aW5qalR0Y2NuSlZ1dyt0azFVSVlPQ3NqdzZEdDNBaDY5eEwzK0Y5bVpZ?=
 =?utf-8?B?VU0vRTltZktiT3ZDQjRoWG1reUY0c3dqYUpMZkdGK0dLdmJXa1F0d3pqTW14?=
 =?utf-8?B?R1ZzTXg1alg4Rmc2bjhaNk1OUU80c1VEMUwzNzVhWVNXMFZiYVlaVWpCSTdk?=
 =?utf-8?B?bCsrWlFWSC9PVEl4aXh4bnVtb3ArcERvY09LcHYybUtKRjEweDhYcGgxdjZr?=
 =?utf-8?B?WmFybVYwaklvN3c4SmxXT2FRSTRnZVJqdGRIWERpRm45aml0eFJFN1lQcFc2?=
 =?utf-8?B?UnRYb1JuU21YVmJ2eWlDZXNiMVU4ME5sZjcyQXZ4dGM3OVFsU1R6dVg0dC9l?=
 =?utf-8?Q?4amExdS5eyV0XVQTYoOmTkgXE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04FE61E977859946BE2535B98DA5DB49@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a3NJWlVoNWIwZ0lTM01aRjdrTERkVERqMmFkR1l2SlpMVzQwajVEbXZHd1Ay?=
 =?utf-8?B?Y0tQTFlVRGhTVHRQSVUwSWNXb250MUt1V0pwZkQ4OGRwU2tPMzQxTFF1YkNJ?=
 =?utf-8?B?UFpGdk9YTHZPeUtMS3V2MTJzWnU4N3ZoZVl6dXI2TzFQNVcvRlJGaFhxb01L?=
 =?utf-8?B?L1g0SzRvdGN2VWhrUlFvQlMzOUh4eGM2a3BuRnFsVW9ZY2NjWm5LQU4zTm5a?=
 =?utf-8?B?bjJtd0VkTHB0UnVLZlh2QmVkRk5WK3VvSjEySEVETWloa1pMYUY3L0lTOXdN?=
 =?utf-8?B?K0s1VlBqL0lDVzN1UHFrd3hmWDA2RzRUcUxNaTRvUnEyeU5lalJQZ3NOd1gy?=
 =?utf-8?B?WHdzN0FVWjRYVlJkYnpZaDEzQkpqTzVJOTFzNkNlMHBRK2dqQ2NiNVNacVRk?=
 =?utf-8?B?aDFiMFBtbkhpMnFKYVM1ZEkvYzdUY3l5bFVweVBvbHFpbk95enZUaThwdEJO?=
 =?utf-8?B?YmpzZWNZU1N3SUdSZ0ZLKzJ0QmlGbzNPZkxnWTVRQlRjMXB1RTBSVE5LaHhQ?=
 =?utf-8?B?cUZka3M3eDkrOTdMck15d25MQkJFMnNhcksxMUxRUi9uZ2EwY1lPVk5CU1Nl?=
 =?utf-8?B?bG45ODZLVlh6cUk1ckQ5UXlrekVKZ1J4cDVzYm52YnFzbmtEU3VwekdhWUJx?=
 =?utf-8?B?ZklnbW42eEwrNmRTNHFxc1BOYkl2YzF2WTZSNmJtZkN4QTRjUUhZR1dmdkJx?=
 =?utf-8?B?QXpsa00rTkg3WHdVMUpZUUFlcExJamZqUXBTY0k5WDFVVUtjdnRmdkRnaS9B?=
 =?utf-8?B?K3ltczNWc3h2ME5SQzlaL1JibkZPc2djeWEvNjRPVE1EaHl4QXVBYW95OFRG?=
 =?utf-8?B?MmVNanEveDRscW54L0dZYllEOFJDd0QzUXkwS3piTVRqSE5odmNpUUR6SFA4?=
 =?utf-8?B?Y3BUbWMyZWNyeVY0U2Z2YWFJMjVQa29Fakt2a0x3c2J1NmRoSU9YYnJ4dktW?=
 =?utf-8?B?ZTFDWHFwTDAzVXU3cFNQRklYcHVrV3NkTEZzbTRUZzZYeXI1K2MyN0thQ0Ri?=
 =?utf-8?B?T1kreHRXdW82UlNETExKU1RRcHQ3Snhnakl1eUljMW9HeW11MzlTSHN6Und5?=
 =?utf-8?B?WDNzcC90SDRYYk1DTGlTOUtGSTJSRzE3Z25mUzJ1eW53SDkrbEtFZkhyV0x3?=
 =?utf-8?B?YW1tMVJxWDJxV0t0dEpNb0ozZFlVQzRjWk9tSVRSeS9McWswVWlnQTUxc0JV?=
 =?utf-8?B?bVF3VjVSWE1WTmtGV2VxUUgwdXkvMUMwWmdDOGlmN1lpTWRHZFVnc1p5MWtG?=
 =?utf-8?Q?NllGFkoxVzNQUVC?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a2281d-f46d-4a4d-7929-08dbf2cd56d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2023 00:26:34.2022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E2z6VXLCpzuzcKZKstfjdGXZe1KvlKUVBLurLOdwHqr3cpd6lMEssSWpCBYHk8znnkhZj7NM++hltNnZ4DI24g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
X-Proofpoint-ORIG-GUID: V1VJZq4C8iT9QsjNHgD8ID59e65MfLky
X-Proofpoint-GUID: V1VJZq4C8iT9QsjNHgD8ID59e65MfLky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_24,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=769 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312010149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIEZyaSwgRGVjIDAxLCAyMDIzLCBLw7ZyeSBNYWluY2VudCB3cm90ZToNCj4gT24g
VHVlLCAyMSBOb3YgMjAyMyAxMDo0OToxNyArMDEwMA0KPiBLw7ZyeSBNYWluY2VudCA8a29yeS5t
YWluY2VudEBib290bGluLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEhlbGxvIFRoaW5oLA0KPiA+IA0K
PiA+IE9uIEZyaSwgMTcgTm92IDIwMjMgMDE6NTU6MzAgKzAwMDANCj4gPiBUaGluaCBOZ3V5ZW4g
PFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+IHdyb3RlOg0KPiANCj4gPiBTdGlsbCBub3Qgd29y
a2luZyBvbiBteSBzaWRlLg0KPiANCj4gSGVsbG8sDQo+IA0KPiBKdXN0IHdvbmRlcmluZyBpZiB5
b3UgaGF2ZSByZWNlaXZlZCBteSBlbWFpbCBhcyB5b3Ugc2FpZCBoYXZpbmcgY2xpZW50IG1haWwN
Cj4gaXNzdWUuDQo+IA0KDQpTb3JyeSBmb3IgdGhlIGRlbGF5LiBUaGluZ3MgZ290IGJ1c3kgZm9y
IG1lIHJlY2VudGx5Lg0KDQpTbyB5b3VyIHBsYXRmb3JtIGhhcyBtdWx0aXBsZSBwb3J0cy4gRG8g
eW91IHVzZSBVVE1JIG9yIFVMUEkgcGh5Pw0KDQpJIGZvcmdvdCBhbm90aGVyIHRoaW5nLCB0aGUg
cGh5IHJlc2V0IHdlJ3JlIGRvaW5nIG5vdyBkb2Vzbid0IGFwcGx5IHRvDQpVTFBJIHBoeXMuIFdl
IG1heSBuZWVkIHRvIHRlYWNoIEhDUlNUIHRvIGR3YzMsIHRoaXMgbWF5IG5vdCBsb29rIGNsZWFu
Lg0KDQpIaSBMaXNoZW5nLA0KDQpEaWQgeW91IHNlZSBhbnkgcmVwb3J0ZWQgaXNzdWUgYmVmb3Jl
IHlvdXIgY2hhbmdlIHdlcmUgYXBwbGllZD8gSWYgbm90LA0KcGVyaGFwcyB3ZSBzaG91bGQgcmV2
ZXJ0IHRoZSBjaGFuZ2VzIHJlbGF0ZWQgdG8gc29mdC1yZXNldCBmb3IgdGhpcy4NCg0KVGhhbmtz
LA0KVGhpbmg=
