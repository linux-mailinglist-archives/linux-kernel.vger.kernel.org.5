Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F125784E93
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 04:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjHWCO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 22:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjHWCOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 22:14:54 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DB3CEF;
        Tue, 22 Aug 2023 19:14:53 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37N14FZS012915;
        Tue, 22 Aug 2023 19:14:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=DflPkCvk/rM8Kjj8LBvhFvjO7S2q8zoOwHS+SSTRSNM=;
 b=i89WX9mWUQAqsMPzd1N6eNlJ+H0rZ3icG4ZoezYEyoqSFDrds9/ppC6aF7WdP8F1xTJX
 PuvNkndIvqo1OiJb9AnQD9v24GhIqJY3Mhv58WxsIK6eNcf6lZM15ALx9GsZDUK+ja0Z
 5eJCQof9gGkI1x6TTuR2BqVLWRflNb/QGlOmC0+FqpRRAe8diCgt0YgLun7OIvwLPfhe
 bX1nXgFNH0NcDcJz/fJK0nXkxxkO9dNV2aES6PsrjCS6Ft2+Sh3ReqPTOYZ3zOnToaTm
 Eprb8E9qrK7Lb6SPZL5GjLQwab2wLiPZjRHCbbuC02BpzFMsJppfaCsdiSwR6AGNRROU sA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3sn1ycspkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 19:14:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1692756879; bh=DflPkCvk/rM8Kjj8LBvhFvjO7S2q8zoOwHS+SSTRSNM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ewHDRiXlZJ6EvKd4XD7qT1eBd2yHAPzJKtw1K0F1VnjlIy6as6Gl/aF47d1xAST1T
         I3dOwRKOW2XOzpWndXlKm2+SAMbe1bJx1JY9t/btjO+unGATkSGY+miIAooUHCsx/s
         ysT51Giti5DkXci9Eq5n9s0TZe9hrQMzkvdFp1e1cFU03Y/hUQ9tx8YYdTIGS11pbh
         N/tWy1rdDW2WPC8HQkM0bi7DhvRyjp2ha+y2btL7IdlUQNMmfYX0WxR4b0h2g4FoQ1
         NyoNHv4hsIzzo6AlyiAujZZa/hrcI6+XXFOhM9iEQLuPpPzFl+BAfMI4/7mt97LKvN
         rTfiGwk2lOsUA==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B6C9940493;
        Wed, 23 Aug 2023 02:14:38 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id ADB56A00B4;
        Wed, 23 Aug 2023 02:14:37 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=vJYZNNrb;
        dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C8BBB4013F;
        Wed, 23 Aug 2023 02:14:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+lWDMK85MsWaePDzkk7f1Jr4fKsDkrnVyWjCpBs/kA/YTtNfKuCCQJY82PPLYyk2N+PxwAjMHL/ARPGz2iVrvw/AjCCJRIlqrnzzj+oIBi/L7pW5mWT0i4jqcSUSn9vUXblrVmZe+t31oMoR8IWpDcDpLHy1QOs5rL0k/Xxcmkzixpf4sLDSJFN/ONcVeLWbccwtp1Z/7pXdmgFkoov5v7CDtFcBx3qq0LpHrSvDA6Nftuc6tK1bbfOAajspeqoiv7LhQ211+3rfYs7rFtHS3KcSMSUTiNxHvdOW91D/8EgntlC/1WOzYF1cg/WVbJk4Lwv6r0k69SaDiku+B+K0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DflPkCvk/rM8Kjj8LBvhFvjO7S2q8zoOwHS+SSTRSNM=;
 b=N81Bcs12cZmYw4j9Ni1/FfS6goq3ZOyxxZ6wfBj5XK0Sfm4gnVqXkoZV+/UzvlobxeLabD2lrXxo66BEf8VqR3bqR6D0j4TrXL8EwSY2R75Y0+xvc4GPbXktkKF2PDicM+LX4OWtNC5HasQx1JbAcOhZnA5QMxMUsY5BVYx6xoymJ9Z9bAHNYGP4AwMJ33vDSOE17kYpo6bCUTELj38z3xWGNypD5FewwWJJ0yxZEILBpL1Jols47tT9wvOjTjcjdeM+pmMfaPdnEOxuVP+0KaMwNO/b4kO2vH7OA3pDF509KnVV/o4F1+OXnrGQOraBOHOLixrar3lTW1R6cNtKeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DflPkCvk/rM8Kjj8LBvhFvjO7S2q8zoOwHS+SSTRSNM=;
 b=vJYZNNrbQmNwYq3kqBj2OZm7H66NKqmGidR/1zPHfRO5gAetdr89gV9mPDAL1PKU6xUFBzS356SRuYt5dtLpO8JSBeaUIkwUz9xVOtzlmh4EhLiKIjLZHaxLvdfixUhRhlep/UtwIW2gW9Qa7TwcFfhzQc3n/9E9X+4/pEM/+uE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 02:14:33 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f%5]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 02:14:32 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Thread-Topic: dwc3: unusual handling of setup requests with wLength == 0
Thread-Index: AQHZ0WkxsEX2ZGMtZEmcF1gvP2WuTK/vPhuAgAAY0oCAAAlogIAACMGAgAEOQgCAADc1AIAAELKAgAKA6gCAA+wcgA==
Date:   Wed, 23 Aug 2023 02:14:32 +0000
Message-ID: <20230823021429.rlgixqehry4rsqmm@synopsys.com>
References: <CA+fCnZcQSYy63ichdivAH5-fYvN2UMzTtZ--h=F6nK0jfVou3Q@mail.gmail.com>
 <20230818010815.4kcue67idma5yguf@synopsys.com>
 <bb470c47-c9dc-4dae-ae3f-c7d4736ee7e9@rowland.harvard.edu>
 <20230818031045.wovf5tj2un7nwf72@synopsys.com>
 <cfc7ae18-140b-4223-9cc2-7ee4b9ddea28@rowland.harvard.edu>
 <20230818194922.ys26zrqc4pocqq7q@synopsys.com>
 <45d9ef53-e2be-4740-a93a-d36f18a49b39@rowland.harvard.edu>
 <20230819000643.7mddkitzr4aqjsms@synopsys.com>
 <e63ba783-f5a4-4442-8736-987a3b134e7f@rowland.harvard.edu>
In-Reply-To: <e63ba783-f5a4-4442-8736-987a3b134e7f@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH7PR12MB7306:EE_
x-ms-office365-filtering-correlation-id: 176a02a7-286f-4354-b532-08dba37eb0b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s3lt0w2idEWS+vwpKR6LY6bvUiDikzeS5JJ9TjGuliSDZLWGLVe5yIDS8E+Rkrqdi27bypQcEnRnTa4dt9XHA9XK5939Or5t9KTliCvGH91r1YAgIWUZSBQs2FK4+jy+Q+bygX3dkEzHscR8gjrCKA9zEhVvyu9QQgUUhaCbMxRLc5ZjmzYCimLGYBUlchCp7Z6Mqy5oaft/14dwaePZzvJGXmPxyWH4myR9H4A8KFS5FmZT0ixVoiIG61gJcsmWZ4FvPCrmz9XbE9HM6Dw0UQqBMRNJ2Sjjiz8by6wbM1mOY/vC95jhotLjZy5WGBnv6BN18g+iJrULUxe9IPszujggrSSmoCn2qMq1gzQRHjy1CF/fmWyVopn7o7aE+XcGEz7XwTQcdD90cGKZbslZTpkglIdJACgJ0Rj70ci1wbbcILG2R7zvziYqwPRNVUNmegSI+4jFtvGfvYiMng8kLp64vSfz4VzTo/J+I0s6GBPD+FiF7cBo/87Cn0uSUjXWWllvpDQlufbtJyb2KWBaIp+7ma/L/XKmje2/BKIwcAG8HUASrexyrTeGcaMdFXtxRa4ffdOOxSIy/UY5E/ro9fAcF0FaU4YhwOvP7Ru7FsbNVtIoG2EwZ72qCeJkgL0k
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(186009)(1800799009)(451199024)(66476007)(64756008)(54906003)(66556008)(76116006)(66446008)(6512007)(6916009)(316002)(8676002)(4326008)(2616005)(8936002)(1076003)(41300700001)(36756003)(122000001)(478600001)(71200400001)(66946007)(38100700002)(6486002)(6506007)(2906002)(83380400001)(86362001)(38070700005)(5660300002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEFZRmcvVkwyVkFOOHZ3U2xEL2hmeUFXU3FES1QzRFJmUXgzK2tDUkR1bVRT?=
 =?utf-8?B?d0FuQmFZQ3FQdVJGNzVzektBeXc4OTJZMnp2RXhLWEFyZ1Zuc2dsaHBWUmha?=
 =?utf-8?B?bThTVHFWc2JuMnBXSEFZekN4M1Y2NHQ0OFhqOURWS1puMzM5SlNibEtVTTZN?=
 =?utf-8?B?NmRvYkd0Z1MvYzVIMml3L29YWTNVTzBhMGZQMnRvaDQydTl1dkd4T2RjSWRk?=
 =?utf-8?B?WEY0dTVPWkdXRFZIWElnZU9VNXQ5VlR2WW5lZGZlLzU1YVd2ZnhlTmFnU21m?=
 =?utf-8?B?bkUzNko0YW1OYjZEOFF4akQzMHpyMkQrNWVIQTYzZjZQMCtDdnY0NW4vS296?=
 =?utf-8?B?cEN0YlZVNUJuZDZ1VnlqajlDKzZDNHl6bmZYUWN5Zm5BODh0S3RKSG50QWgv?=
 =?utf-8?B?Qi9ZTVpScmFiZ1NJTXh2Z1F4TkdpUEtNNityRnFaVjArQnphOFozMys4VWpr?=
 =?utf-8?B?UEc0cmVHSUdKenJyNEVRNXk5UlhWUEVLZW84TWtBcXlRYmNlQUxRYWZSdFRn?=
 =?utf-8?B?WnE2MU1OdUhNYk00YXMwd2xPQ2FQNDdlelpMOVNyTlR6aUR2QVVvbmdGNEVl?=
 =?utf-8?B?YUhqQWM1Qm1FT1V5SHVXdnRZVFhPeVlMbmZIU1JJWTNFQWZINXpQcCtnakpD?=
 =?utf-8?B?ZUZVRmhwN2tIdHNyeDFGMWZGdWRiT3N4RFd5c2VUcGxpS3ZET3QrcGoxWHRV?=
 =?utf-8?B?SExTdFpCdmFDM2VCb2FkZEgybE1nQ1JBNC9Fd21DbnpFUVZZclQ0QnUwRDRI?=
 =?utf-8?B?a0ZsTm14MTk3Um5id2dwdGpDTjlzYnM0SHRod2VXNTU2aERsYkN5aHFrTWFI?=
 =?utf-8?B?L2JCYkM4ZUhMdjV6MVozWjRtak42eFBodWFiMlNmY1kzalUxK0RSWWlrWGtv?=
 =?utf-8?B?YWVQak5obzhyQmI1R25Eb3IxYmVLQ3FZR3h5N2JiOWd6SjgvdmhqclBTUUYx?=
 =?utf-8?B?aG1xVGpoTUlWdjYxNnlRQk5pNlhQbkhGVnlFV0x0V0QyNGlPTHBRbDIyOEds?=
 =?utf-8?B?WXBmT09tU25oejU1Z3djcW9ZdjJuM0hqV2pzVWF0RFAvRHllRFB3Z2MvMTJk?=
 =?utf-8?B?Y3gxemtNR09MT3Q2VHp0QXl1RWJ6a2VyK1BtVlZoeUR4eVplUEllSjBJajBZ?=
 =?utf-8?B?TEg2MnF5ci9aMFBlUGxVK2ErYmh6bWc5V2UyN1Nxdnpsekc3aTNwNElkc29V?=
 =?utf-8?B?akpYMWp6TVFLc3liMVltUTY2L2lwTVRPdVlJMVNNTjE2TENnQ2wrMUkzUHFs?=
 =?utf-8?B?Y3BPOTRDVFBzalZ6Z2gxVEhYbVgvKytVWmNyVWdrWGpSSmZBQzNTcGQyZXY3?=
 =?utf-8?B?Sys3enlESUltSE5WY1p4UFNqVDc0NSszM1AvaXFjbFBXUWl2RTBud3M5NUFJ?=
 =?utf-8?B?b0FVWjExOXJmSk1vRWNYanJCTC8xQzR6d052TUpRcEVhQU90a1h6MUdxYTFt?=
 =?utf-8?B?cS83YUVvRm5lZGR0dzVmOElSbjk4dVZZS3pGWUkzK1dIZkJoYVV5NmJiTlNF?=
 =?utf-8?B?Z3ZaRkhuMnM3SEppQ3JCWkVvbkM4ZVc4RzAzMnUvTWhqdHQwUFE2MERUQ0NS?=
 =?utf-8?B?UjNoQW0yVE4vNzJXL1VidjVreDBvRDNRd1ErUHlJZTJxV1U2QnVlQ09KMGpL?=
 =?utf-8?B?NjZYOFZmNFl1aEJYUnhwV2RiUDVBMU1mNXoraTFwc1B3WU1GMlJRN3VwU3Ri?=
 =?utf-8?B?R1NZNzljTDlmcG5sSHV2WDkwd1UxQVNpTG1lMTN3Vlo1a2hBWTBydGFpME1h?=
 =?utf-8?B?NCtQVWR0Z1ltUnlkdzc2V3ZycWluYytOdEhWOHlhdVgyL2xUSFBTNnJWSC9u?=
 =?utf-8?B?MHRuR2QyK0tjMHdkK3Y2dExjazIwSGxVSm5iYWRrWllUOEJwb3JaTmlYZ2JH?=
 =?utf-8?B?TnJ1YXNBa29TU3dqWUdKTFBYK1dyR2hvYWIvcGNxWHc2VTFNcmlZa3FsUUxj?=
 =?utf-8?B?YXBVWCtwRTJnNnRLdFBTMHlUbWt1SWg0WTBLSGhWQUgvaXhrRGtCWXR3ZE9O?=
 =?utf-8?B?WXVCbldMK0RRRTlMcHNEOTdMYkU2K0tpdHU2TjB5TFg5OTJBRlpwN0RtS2Fq?=
 =?utf-8?B?Uk5FMmdhTmlzd0xhN3dlSmJWV1pleXQ3dnhMcTB0aE5selZzTjNyckJMSTkw?=
 =?utf-8?B?UmdjQ2k2WVJnME9CbTFZUm82SlQ4cFgyZFFPUzdIR2ZqMmduQmxjVUp5L2p1?=
 =?utf-8?B?aUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73EA7A1D94DA4D4CB1F8AA9816138CAA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?clR6MnFXVTJ3Q3VnM01rL3dCdWdzc3hMaTlidGhGWHU0WjhIb2hIMCtrOFBl?=
 =?utf-8?B?YkN1emFVaTAzRDNOZXlMN09lNTVFNkVGRU9OSjRnSGFNMmpXMExVNWtUc2Rp?=
 =?utf-8?B?WHgxMkhIV0FVRXI5QXJwVjlYSnMrVUNiWUEyZzZTNHd6VkVLeDZmY0tLWFJF?=
 =?utf-8?B?Z2dHZ251Umd5bFZJMVBrNzFHOGlFZG9UbVFQZ0NkM2dvNVJxZFlHdDkzcC9H?=
 =?utf-8?B?V05PNDdFQVhSdlZQVUZGcHlON3o5eHlYc3ovaGdBRHluSmQ1b1oyVis1MGJs?=
 =?utf-8?B?N3I5Rjc5YllxTlR0c2FHMzNQY3p2R2VTUXNCTDZrUFgxMkJTSUd3MWo4c1ZG?=
 =?utf-8?B?TmRyWU5mYTdiZzl0b1BvTzB5dDFYTjgxSUt6MmYxcTVSRVVsVkN0VE9mTHpu?=
 =?utf-8?B?TkNGY2ZjQklPZy9PK1FoSlJ5T0N5ZTBGZ0NXcmhUNDZmSTRSR1dJaHlBNVZC?=
 =?utf-8?B?bG0rdXNRR2hXUlRwR3FjUElyaWlnbHNvNEQwaVljZC9mUW9ENEFyYjBldWYz?=
 =?utf-8?B?OGpJelJlb2NMT1dUODlOMDl2aksydHhuWFl4bTNVSWFaREhaYUtzZm1lZ0d2?=
 =?utf-8?B?OWFWYUorMzNjTTV1WWloMG1OZms5V09yb2xOVFVXd2R2bEdtVHNGOFpmWTZu?=
 =?utf-8?B?Zk5NZHRiMy9rU2lDZ05VNnd3dktrUERPWUw4NzNXbFhPb29jbHZiMEdYKzNF?=
 =?utf-8?B?aEI1R2R6Vzh4RXh2V00yQURvc3c1emg1TzBSa1QyVkRPK05UMERwYkpIOWg5?=
 =?utf-8?B?WmxSYVBPYys1UmhTK2djTncyOE83Y1dJTVlQY0psR3N1TTF3djB4WUtka2g2?=
 =?utf-8?B?MGsxQWFNM1dUVVBPd1VEQ2EvcUU5Sk1YNHR0VWpBUWQweHBWQlYzVklRL2lZ?=
 =?utf-8?B?Y09YdHpWNnBiYXhmQ3loNGJHcWRnd3d2MzQ0ekF0Sm16azVKUWxQWDN2dVhi?=
 =?utf-8?B?Q2d3T1pCM2p5ZlJkZitsTU8xbEordlBFQk5MeUV2QXU5aTNYSEs0MGJDTTJZ?=
 =?utf-8?B?aU1JdTFvdnAxSW9IbkpaanVHd2REbTJpWHd4YTgraS95Vk9idkoreEltVWZx?=
 =?utf-8?B?UlA2eCtVT0FBN1EwRU85enB5QWhSV0RQeThZcDZyWlRlbE9ObUZBMmIvVW1n?=
 =?utf-8?B?ejYrV3k4clVMMXByTFBUbDZ0ZloyeTVLdlZWeHhpdWdWaE5uTGwwNUNVaXZD?=
 =?utf-8?B?RmNqV1laaHNwTDgyYnRVdUtiTW5saXR1ZlVhTlB2VjlOakduRDltQkpqMjE0?=
 =?utf-8?B?N1JBa3ppUVZYL2xsTXg3YWtIOWdqM0RGejV5VStITGRCNmptZz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 176a02a7-286f-4354-b532-08dba37eb0b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 02:14:32.8689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zf39x7LhCYtHlMH+t2I8nrGc97/3PasSrJe8biNYjf6od+XFCDCdSTGUAfGzq7jbv6/2A8kivxCN3GkS2aifrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306
X-Proofpoint-GUID: u59R6PTRksVc-C6e5kBLmmluhhy7OZ96
X-Proofpoint-ORIG-GUID: u59R6PTRksVc-C6e5kBLmmluhhy7OZ96
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_22,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 mlxlogscore=579 spamscore=0 adultscore=0
 mlxscore=0 impostorscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308230019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCBBdWcgMjAsIDIwMjMsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+IE9uIFNhdCwgQXVnIDE5
LCAyMDIzIGF0IDEyOjA2OjUzQU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBG
cmksIEF1ZyAxOCwgMjAyMywgQWxhbiBTdGVybiB3cm90ZToNCj4gPiA+IEFjdHVhbGx5IEkgYWdy
ZWUgd2l0aCB5b3UuICBXaGVuIGEgbmV3IFNFVFVQIHBhY2tldCBhcnJpdmVzIGJlZm9yZSB0aGUg
DQo+ID4gPiBvbGQgY29udHJvbCB0cmFuc2ZlciBoYXMgZmluaXNoZWQsIHRoZSBVREMgZHJpdmVy
IHNob3VsZCBjYW5jZWwgYWxsIA0KPiA+ID4gcGVuZGluZyByZXF1ZXN0cyBhbmQgdGhlbiBpbnZv
a2UgdGhlIC0+c2V0dXAoKSBjYWxsYmFjay4gIChJIGRvbid0IHRoaW5rIA0KPiA+ID4gdGhlcmUg
aXMgYSBzdGFuZGFyZCBlcnJvciBjb2RlIGZvciB0aGUgY2FuY2VsbGVkIHJlcXVlc3RzOyBuZXQy
MjgwIHNlZW1zIA0KPiA+ID4gdG8gdXNlIC1FUFJPVE8gd2hlcmVhcyBkdW1teS1oY2Qgc2VlbXMg
dG8gdXNlIC1FT1ZFUkZMT1cuKQ0KPiA+IA0KPiA+IFRob3NlIGFyZSB2ZXJ5IG9kZCBjaG9pY2Ug
b2YgZXJyb3IgY29kZXMgZm9yIGNhbmNlbGxlZCByZXF1ZXN0LiBFdmVuDQo+ID4gdGhvdWdoIHRo
ZSBnYWRnZXQgc2lkZSBkb2Vzbid0IGhhdmUgdmVyeSBkZWZpbmVkIGVycm9yIGNvZGVzLCBJIHRy
eSB0bw0KPiA+IGZvbGxvdyB0aGUgZXF1aXZhbGVudCBkb2MgZnJvbSB0aGUgaG9zdCBzaWRlDQo+
ID4gKGRyaXZlci1hcGkvdXNiL2Vycm9yLWNvZGVzLnJzdCksIHdoaWNoIGlzIC1FQ09OTlJFU0VU
Lg0KPiA+IA0KPiA+IFdoZW5ldmVyIEkgc2VlIC1FUFJPVE8sIEkgYXNzb2NpYXRlIHRoYXQgdG8g
YSBzcGVjaWZpYyBob3N0IGVycm9yOg0KPiA+IHRyYW5zYWN0aW9uIGVycm9yLiBGb3IgLUVPVkVS
RkxPVywgSSB0aGluayBvZiBiYWJibGUgZXJyb3JzLg0KPiANCj4gRG8geW91IGhhdmUgYSBzdWdn
ZXN0aW9uIGZvciBhbiBlcnJvciBjb2RlIHRoYXQgYWxsIHRoZSBVRENzIHNob3VsZCB1c2UgDQo+
IGluIHRoaXMgc2l0dWF0aW9uPyAgLUVDT05OUkVTRVQgaXMgY3VycmVudGx5IGJlaW5nIHVzZWQg
Zm9yIHJlcXVlc3RzIA0KPiB0aGF0IHdlcmUgY2FuY2VsbGVkIGJ5IHVzYl9lcF9kZXF1ZXVlKCku
ICBXb3VsZCAtRVJFTU9URUlPIGJlIG1vcmUgDQo+IHN1aXRhYmxlIGZvciByZXF1ZXN0cyBhdHRh
Y2hlZCB0byBhbiBhYm9ydGVkIGNvbnRyb2wgdHJhbnNmZXI/DQo+IA0KDQpUaGF0IHdvcmtzLiBJ
dCB3b3VsZCBiZSBncmVhdCBpZiB3ZSBjYW4gZG9jdW1lbnQgdGhlIHVzYiBlcnJvciBjb2RlcyBm
b3INCmdhZGdldCBzaWRlIGFuZCBrZWVwIHRoZW0gY29uc2lzdGVudCBhY3Jvc3MgVURDIGRyaXZl
cnMuIEkgdGhpbmsgdGhlcmUNCmFyZSBvbmx5IGEgZmV3IGNvbW1vbiBlcnJvcnM6DQoNCiogUmVx
dWVzdCBhYm9ydGVkDQoqIFJlcXVlc3QgZGVxdWV1ZWQNCiogU1RBTEwNCiogRGF0YSBkcm9wcGVk
IChpc29jIG9ubHkpDQoNCkFueSBvdGhlcj8NCg0KVGhhbmtzLA0KVGhpbmg=
