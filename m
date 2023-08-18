Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B4078043B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357458AbjHRDLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357498AbjHRDLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:11:19 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EDA3A98;
        Thu, 17 Aug 2023 20:11:15 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HKUWV0030808;
        Thu, 17 Aug 2023 20:10:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=JdGOz7n+yH+Bixq3tTgB0EUM5kOevJnrikoLWRTH+cQ=;
 b=fHbB0HBEJMUjJ8+ioZsixkYvZZcojTE1ifIEvt0wspqr4t2t3bdWcyrObeR3doSyNY6p
 95scYLeDqgDZgdqcY5Era4xRUQKbfjMvgu4HXuei5mdWfxJ+zP7Ai0efAcVu/cbQnOSi
 IdeEjA+gC+lqaJP7V9o2b7jsptfWbDHd4tJVULKA2CCOEa2gg7941u15viKA2tcL8Cf9
 1n6OKuX+sc2sqJP/pEUVQ7s9NJ/SpSILuuXXezOBc5D/XlH2wFuRFbYLlQ2SLx1QSPqm
 RVYPJuRgnAv67NU/FMJivZrb/m1/j6uYeCQ8a9xeX6o9eoXulAi/7EUQ+29CMDyn/6+s rw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3se93kstr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 20:10:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1692328254; bh=JdGOz7n+yH+Bixq3tTgB0EUM5kOevJnrikoLWRTH+cQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=MxDacgIFPwFYCdxSGmgcgDCrE1pNRuasbzAuCRG513cMGc+Yad6UL0It7WuKyEacE
         YtScyVrm9gaQzQV8KGUiZOVIEjrUJOvgIOi/fbBQUr55lI1n5jjtITEQAuo+WxIm4F
         pPOROZ5tONYrDppWStD8mRCrXPnuv7Sq5vJllRG3Dl1JnOjmFkSsIrlXbwh9OZKXzl
         evzq4w7lnIiVXEVz0mbYvLbEbeyDlON6cVtGzHuQQOKpJnzS+j+iQogwAy2vwfFFqS
         e3Fh8TkvVrv+rO3ecqCvq3uz9GJdx+HuRybACS0JtKcDZU5MepJBQ9Vf/ceFSfXZ6R
         ry2qbTCaBMc/A==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2DFA440145;
        Fri, 18 Aug 2023 03:10:54 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 42937A006D;
        Fri, 18 Aug 2023 03:10:53 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=vfl1y04F;
        dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8BE7E40582;
        Fri, 18 Aug 2023 03:10:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7NLrA8hzCuSowvrhooow16b9iJENzGLN3LzQdaikENWbILAoldv30XAhMpxGO75Vkw7Z/yc7foV4A5ECDnEmjGvu/+k0bWRQBHwK8MGXCCwiHXLoEPqjLGQC+9sU3yI80Un6zk9fcGUi9TBWIQP/0VbmHvNRD9lnGnaf1jPw2heXFfkhrjGeQE5T+m6jWPhrrduUVg8QVr4rxbJbS1v9rohTSaCHQ9y1+OH9fzOO9fVXKoAYGCwKCxFGf6T8JlaelbcF1loHkjNpCDvvojV8f5evXonvPiv5igHtTL7NznBdYSzGYH99szRURTR8ahq4cfXrhr+5707t0PN1xwtdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdGOz7n+yH+Bixq3tTgB0EUM5kOevJnrikoLWRTH+cQ=;
 b=GILp5pH9yu+9MhBrLgOqNIvFURTfKsBbdJ+WXsm1PW43OAMZN/UN0MJ3uSvRRHlmYJdjoloWenK/s11Rg7Urxzt3dwzCLaQLsP01C3IFN+JOmApOqBo2Zq3p7vWTLkSPF33r8QCpFvfmI30ycTY2NLf/BQlPW8nYJo+GnnZtsPsb8Kgm2GwHoG2V/VQnwN1tx9XuZIdgmuIlUH07KOVDVOLbmEkTwqiKGim2PV6iqhmY2MhUqHrUaMonxfiGsKlw1JE+6EFw5/R+wcndm+9spbMWYBZ8S6p/8RckvXZGzfVBXD0Pmm9+teW26ZypjCtTioxZdLSByel58evYO16BYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdGOz7n+yH+Bixq3tTgB0EUM5kOevJnrikoLWRTH+cQ=;
 b=vfl1y04FHFL+7kvJPlkbKZvApIxXolD4187sRfZmVg5Jh8MhXTac2CqercjCFK31iyQ9PLv90jaLHzEbgj9j1tQkKcuCNQz0fjT0akpjnWHI9I+KRF8cvwofEjWljDhRWB2aLeC9IRYDLxsLZhYCUGdifR/8Rpah/IWJq/zdjBc=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 03:10:48 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b18d:912e:908a:5952]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b18d:912e:908a:5952%4]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 03:10:48 +0000
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
Thread-Index: AQHZ0WkxsEX2ZGMtZEmcF1gvP2WuTK/vPhuAgAAY0oCAAAlogA==
Date:   Fri, 18 Aug 2023 03:10:48 +0000
Message-ID: <20230818031045.wovf5tj2un7nwf72@synopsys.com>
References: <CA+fCnZcQSYy63ichdivAH5-fYvN2UMzTtZ--h=F6nK0jfVou3Q@mail.gmail.com>
 <20230818010815.4kcue67idma5yguf@synopsys.com>
 <bb470c47-c9dc-4dae-ae3f-c7d4736ee7e9@rowland.harvard.edu>
In-Reply-To: <bb470c47-c9dc-4dae-ae3f-c7d4736ee7e9@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MN2PR12MB4455:EE_
x-ms-office365-filtering-correlation-id: ab4e1dd5-4cef-4369-44df-08db9f98b87e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t4jIzYE+nLhOcmTAuJZ1V/Z1zUXT7KomN17lnTauzN3AsTgzdIh1P+IA4qZmnpF7EjGJKUxWCfuWrr6Q68Xl9yknc1OQRQ+ksZPccyd54VQfhBFfwORcsUGEJFYpmuOY48EYQZMCxWP2cwhjOEYowMnNGwfOPuoha5FGYg3LGxhQpsNo+9pmTm1d0UjwGRp6WCEgVkh8anYASIkjhLmCcFHVzSK3GtxTV3R9lkSFhEOKupLpompB8I5vQZpayfabAWfDGp8SCjVhKNF1wkt7c8BQVujJt6Sgc29aO3L9L7Oeg1oMzo2nGDzNh6OWhuE2/jYNyuQcNqfXujc+idCFolXpdR/QvfUas1VV0KAvzoC8G9Bx94Q0uOVSCN+J5LinrzACZiEqvPxwDwRzknidz6vTPtfm/ADPFb+O181NOMw0HMNrxnkHERouZUiv/CUC55beKZrs3Xlu8FljmDaQku01QmnBi2pSlpw2KTmJMisx3TqxKdNNrOsSohVf04eGmxXXEDsIQqNpVqu2I1vqHz2SzVNG6Tsui6DVXvR966cIerZ6Dzyk5AkyVh9W5jwgJmudWgYxEHQH3XbHgrf2Wi+wl1o8JteHO6OsB4QN90T+Ks+5pR6qCZ42YKQStwPG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(39860400002)(346002)(186009)(1800799009)(451199024)(66899024)(2906002)(83380400001)(478600001)(64756008)(66556008)(66476007)(76116006)(66946007)(66446008)(6916009)(6506007)(54906003)(71200400001)(316002)(6486002)(5660300002)(2616005)(1076003)(26005)(6512007)(8676002)(4326008)(8936002)(41300700001)(86362001)(36756003)(38100700002)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkkyMGxISFhsR2hrVEdXL0VhQkxxaVJyMEFncGcxYVFyK2NSUjhxeTltd3Fo?=
 =?utf-8?B?S3dMOWx6Y2NXM1pqbkFtSjVkZlE3UXczNnBCeHIrWFBvM0VSa0wzTzNxZUs0?=
 =?utf-8?B?ZW5BTVNacjh2YTlKSEtGZWNSUXd3bUF4b2kwbGpUZnMxaWRiYi9lSDNybjV2?=
 =?utf-8?B?ZUpyK05rUmJZV2dvTjk3ZUVqZEFSNnNUaU5DMkwxZmhvTDVzOGxOMy9ERVBW?=
 =?utf-8?B?MENFRmhyNEJheUJ3SzBsWDdibEJiYjBRNUhsVlBpdHZnTUJ2MEtiTEl3cGMr?=
 =?utf-8?B?ckdOL3hRalF2eC9mL2U0c3FmM1VZQ2ZZWkozVGVRdUZOT2xCQkRWdHp6bkVs?=
 =?utf-8?B?dXZIZ0Frd2NobDdlaXJweWNqQUIzK2pCV1BLbk1GSFAydEErMzBTdlJXQ0lW?=
 =?utf-8?B?K0pSS1B1NTh5RUNGSytxQXd5dXVwZkk5TGtKRUdqZkdiVGxMMXk1K3pEOCtW?=
 =?utf-8?B?cGtHMmVhMlJVemVSMWozZjJTV1YyN0FKNG91aEsraUFHcDdZcGc1Wi9EbnJQ?=
 =?utf-8?B?dXhGNzNPZkJPRGl5TUs0cDBIZEVFMFhrZDZXYVNnbmlZYW8vTEpqaFhuemVE?=
 =?utf-8?B?L1M5U1IwVFN2TFFtQmE0T2NFQ2RwSnRBRUs1c1RZQnNsRDhTTkpudmRSM0tT?=
 =?utf-8?B?NkMrYXdLN1BKWHJaUW82L0NUZzBQaXpXVWs1Y1V5b0RhYmszeGdEL1p5b043?=
 =?utf-8?B?N2Z6R0Zkbzh5TnA5UEp5bDBTV3J2UVlyMXk5QUJYUm1yZnc5Y09VNkdLYWxh?=
 =?utf-8?B?TmZJSXBIem9DdDFvMkx1QTBnUEZpMlNFQm5ybktZaWRTZUlqSHBBTFA3L0Rq?=
 =?utf-8?B?ckc1dmNBK25RNnh2Y2VyKzlZVEY5U28wQUJRQlNxZ1Z5ajNKaHZFYU54a1BR?=
 =?utf-8?B?cUZabFR5Q2NibVpIeFlDcHZ4Q0FJc1lCQ1RyZS9id3h6R2FZSU5IZ1pJU2o2?=
 =?utf-8?B?d05ZSnZ0VHRza0xKcHdSQmt2NTNsUnpmUWw0b2dxOFkyckJ3ZEJ1N2NkekZ1?=
 =?utf-8?B?S2NlUDhMd2Z4dWw4bHdRZ2hSTzFZcC9MQkEvc0xOeW1taTRJMXhZWDBQNnlL?=
 =?utf-8?B?bE81VWIwWnkzMEdtSHVTNlorUCtQVU5naXNnZTdwdElqY0I1Y1AzbU8yTC9o?=
 =?utf-8?B?ZzBiMi9lUjZpZlA1eEdrUXJ6REQ3NGFqeHp1VjRkQklwWUEvYlpxMmZYZUl3?=
 =?utf-8?B?OUFsZUlNVUJrbzJveW8vdHJiL20xSUVjLzU3alBDQjNqVUhWMzhEaE44YzBz?=
 =?utf-8?B?Tyt0SFg3UU1RUU5hOFAvZmlheEdHZXUzOHhjeE4xZG5adFpnMWtTUVFPUVpC?=
 =?utf-8?B?WWNJMXgvWVN3eXRWeEVIRWo0TEVWU29jK1FhM2k5d250M0JCbERDYllNQWVT?=
 =?utf-8?B?SnRQcmorVmtaTlFuQlJpd0JzM0xndENFeWZnZk1LMkxWdWdYdDVVUFZxN01Q?=
 =?utf-8?B?bkgvckw5RW45QzQ5cHNzSTFzcUo3MmorSEorQURkeTk1WFBKZ25RN2dOLzhR?=
 =?utf-8?B?eUhqY0ZEa3YyZ2NKbmNabThJUXlldVpIbzhuNjFpazluUmx0ZXBsUnFkK2V5?=
 =?utf-8?B?bzdmOUkwbkNFSkU4c01RalNlT2kxUkY0dStJeVBTZGM1UFFaYUhtY092dEVC?=
 =?utf-8?B?d055eW5DWkYvcVpoY2JvZkhITnVoTHhHaDBWZldnbENwUlBSWXVRTkpvc2dp?=
 =?utf-8?B?dW8zVERVdDVpWkhxZU40YU13QUdKMzEvcEtlQ2F6T2F4SVZlRFM1eGRqK0tY?=
 =?utf-8?B?Zld2OWVITnlVeXFTS3pzdTVBVFVxOU5uNWxDNTJPdUY0bVBMZnB5V2RCcHR6?=
 =?utf-8?B?WEhuUzNRWjBiRGoxaEpST1lTUnBnOEdpdjZOekRLeW9iRnVCYm1DQ0FBeWhH?=
 =?utf-8?B?SGNGb0UxK1VORUt6aGVYVnZRN2hVTTJMeG9aNXA0SHV4aWZhdEE4K3VXVDdG?=
 =?utf-8?B?RWtwdkZmcE4rNEFOamFaMm1FejBjaUxSb3hLS3cwUERLZVVrWEptOGJhZm45?=
 =?utf-8?B?d1BrWlRTZTJuVm1TWDJKSUE5VmVVVG1waEcxWnNPaHYwU3dmc3hCWFpidkxo?=
 =?utf-8?B?UGtpbnBOb0VZS3A0Ym8wMXg3ZmFzMHlmbXlueUhEWWRaUWZEN28rYzVyamdG?=
 =?utf-8?Q?0UPdy4BC0tP0CL9GQUQH/g+uL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5392BB07452B74EA060739BDC7428D2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a1RXOTRrdHBDRy9ocGdUMHJEZ2JVa3p0OWc0TnNiK3JjbHRaMHllS0RUTmhl?=
 =?utf-8?B?bE11YUNId0xsNmV1dUVyVys4VG02VTlVTkxrRUlVOUt5UTBvUzZBVXg1TEIx?=
 =?utf-8?B?Zkd0WUozY0xHUE1zbkVraFhtMTQyV1lEUEU4dGFtWExBV1kvczY0QXhHeHl3?=
 =?utf-8?B?L1RnM3BDYTdsVVptQ3RGSU8rcTJ0RUViMVBoVjMxblR0MnJwa2NZVFphUHdD?=
 =?utf-8?B?dHZQUE1xaUl2L1FnWW9SVkhNbk8wR1I2OGF4eGZndllOYVlmeXpkeksxTzQ5?=
 =?utf-8?B?N1ZrZ25HVU5ZcnVqOFgwTExLaHdCY1lzcDJnOUg0M3ZMd29ZZFRqblpsMk5a?=
 =?utf-8?B?YmhqUTgvT09nZkZOYTdYRmc4MXpEQ1NhOHRlSnJTcG4zMXFvT0g5bVpIWThp?=
 =?utf-8?B?NVBtMEEwcFVEbE9VQjk0UHhsd1pRS3IzSXJWZ1NROEdQeW4wU25qdkxzem5B?=
 =?utf-8?B?OS91dnRXbXJtTjVqZGdsaE1LRytYT2Nma2VVTGUramtpTXVwZHprZ20vUi96?=
 =?utf-8?B?cWJWK0w3VHU2YjN1ZGhzbnR2NkF0TklGUWZtbU1aNGdYSjlCT2tFclNCYTBm?=
 =?utf-8?B?L1U5dzYwS0Y4dnduekxxNVNPZDRDcHdVc29sQ3FXbkUxY3JFMndqZ0dQV3VG?=
 =?utf-8?B?WFBTelM1TTRWMGFpTWJnUjZEUUFqTzRQM1pJZVJraWRuMmp2R2N4ZVFONzhy?=
 =?utf-8?B?ZW0wK0JSUWsrWEtjeE9obmlXd0N5QWRjdXRwNVNBeFNUVGZzMjJtcFNiOEx5?=
 =?utf-8?B?UEZobXBnK3FwUCsxV2VSMElhWnErbmhJam80WU85RFRGc1kzM1pPSXFuODg2?=
 =?utf-8?B?MnpEQzNVczhheFBneTJXYUliSEFHWnB5VVF4SE5teVJUOUUxRndDaWRpbUdL?=
 =?utf-8?B?R1dHeXdZZDE2bFA0U0c5T3NTNE9OMWRkYURaMU5qS3BIeWpKVDEvcVNlWEt6?=
 =?utf-8?B?aGxIeGRhbHZTeElCaU54MVZCMmhacDJyekROc1AzODFwSkFINDhJdmdDUGht?=
 =?utf-8?B?ZmNzMkRyRFpRUDhlUlZzMnFQSWhNUE5vRnV4aFg2K2gvbU4zdGg1b05LMU5k?=
 =?utf-8?B?dGdLMG1nYXRQSnJXek5KNHFaNjlNbmlHaElRRnhadkhIM1dKZDIycEdmNWZy?=
 =?utf-8?B?K2xkVjdtOFhsZURwZzhnekcxbjNYbXVSRVB4WnBHVEYxUjRQVlVZQWRjcDls?=
 =?utf-8?B?NG9MT0FxZmV2QUhyR1hPK0JnNXRCY2FOU3ZjTTI1ajNQT1lGVkVPY1Y4UGtq?=
 =?utf-8?B?eTIzSkhON3p3cjd1UUZlSjllSjRDWmJOYWxmN0FDSk5FRkU4QT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4e1dd5-4cef-4369-44df-08db9f98b87e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 03:10:48.1989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I+IPmUCNV2PtnS5BCbdbuHNu7beFEFal0HyyshoXazsMbA5+cqlJdYyUBiKKOp+1ZmN1pry3UsDFT8gdfiT47g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455
X-Proofpoint-GUID: D7N-6RpyFJFpVN80KUNJHtj5t2t4GrvY
X-Proofpoint-ORIG-GUID: D7N-6RpyFJFpVN80KUNJHtj5t2t4GrvY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_02,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308180029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBdWcgMTcsIDIwMjMsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+IE9uIEZyaSwgQXVnIDE4
LCAyMDIzIGF0IDAxOjA4OjE5QU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBIaSwN
Cj4gPiANCj4gPiBPbiBGcmksIEF1ZyAxOCwgMjAyMywgQW5kcmV5IEtvbm92YWxvdiB3cm90ZToN
Cj4gPiA+IEhpIEFsYW4gYW5kIFRoaW5oLA0KPiA+ID4gDQo+ID4gPiBJIGhhdmUgYmVlbiB0ZXN0
aW5nIFJhdyBHYWRnZXQgd2l0aCB0aGUgZHdjMyBVREMgZHJpdmVyIGFuZCBzdHVtYmxlZA0KPiA+
ID4gdXBvbiBhbiBpc3N1ZSByZWxhdGVkIHRvIGhvdyBkd2MzIGhhbmRsZXMgc2V0dXAgcmVxdWVz
dHMgd2l0aCB3TGVuZ3RoDQo+ID4gPiA9PSAwLg0KPiA+ID4gDQo+ID4gPiBXaGVuIHJ1bm5pbmcg
YSBzaW1wbGUgUmF3IEdhZGdldC1iYXNlZCBrZXlib2FyZCBlbXVsYXRvciBbMV0sDQo+ID4gPiBl
dmVyeXRoaW5nIHdvcmtzIGFzIGV4cGVjdGVkIHVudGlsIHRoZSBwb2ludCB3aGVuIHRoZSBob3N0
IHNlbmRzIGENCj4gPiA+IFNFVF9DT05GSUdVUkFUSU9OIHJlcXVlc3QsIHdoaWNoIGhhcyB3TGVu
Z3RoID09IDAuDQo+ID4gPiANCj4gPiA+IEZvciBzZXR1cCByZXF1ZXN0cyB3aXRoIHdMZW5ndGgg
IT0gMCwganVzdCBsaWtlIHRoZSBvdGhlciBVREMgZHJpdmVycw0KPiA+ID4gSSB0ZXN0ZWQsIGR3
YzMgY2FsbHMgdGhlIGdhZGdldCBkcml2ZXIncyAtPnNldHVwKCkgY2FsbGJhY2sgYW5kIHRoZW4N
Cj4gPiA+IHdhaXRzIHVudGlsIHRoZSBnYWRnZXQgZHJpdmVyIHF1ZXVlcyBhbiBVUkIgdG8gRVAw
IGFzIGEgcmVzcG9uc2UuDQo+ID4gDQo+ID4gRm9yIHRoZSBsYWNrIG9mIGJldHRlciB0ZXJtLCBj
YW4gd2UgdXNlICJyZXF1ZXN0IiBvciAidXNiX3JlcXVlc3QiDQo+ID4gaW5zdGVhZCBvZiBVUkIg
Zm9yIGdhZGdldCBzaWRlLCBJIGdldCBjb25mdXNlZCB3aXRoIHRoZSBob3N0IHNpZGUNCj4gPiB3
aGVuZXZlciB3ZSBtZW50aW9uIFVSQi4NCj4gPiANCj4gPiA+IA0KPiA+ID4gSG93ZXZlciwgZm9y
IGEgc2V0dXAgcmVxdWVzdCB3aXRoIHdMZW5ndGggPT0gMCwgZHdjMyBkb2VzIG5vdCB3YWl0DQo+
ID4gPiB1bnRpbCB0aGUgZ2FkZ2V0IGRyaXZlciBxdWV1ZXMgYW4gVVJCIHRvIGFjayB0aGUgdHJh
bnNmZXIuIEl0IGFwcGVhcnMNCj4gPiA+IHRoYXQgZHdjMyBqdXN0IGFja3MgdGhlIHJlcXVlc3Qg
aW50ZXJuYWxseSBhbmQgdGhlbiBwcm9jZWVkcyB3aXRoDQo+ID4gPiBjYWxsaW5nIHRoZSAtPnNl
dHVwKCkgY2FsbGJhY2sgZm9yIHRoZSBuZXh0IHJlcXVlc3QgcmVjZWl2ZWQgZnJvbSB0aGUNCj4g
PiANCj4gPiBJdCBkZXBlbmRzIG9uIHRoZSBiUmVxdWVzdC4gSXQgc2hvdWxkIG5vdCBwcm9jZWVk
IHRvIC0+c2V0dXAoKSB1bmxlc3MNCj4gPiB0aGUgZ2FkZ2V0IGRyaXZlciBhbHJlYWR5IHNldHVw
cyB0aGUgcmVxdWVzdCBmb3IgaXQuDQo+IA0KPiBMZXQncyBzZWUgaWYgSSB1bmRlcnN0YW5kIHdo
YXQgeW91J3JlIHNheWluZy4gIFNvbWUgY29udHJvbCB0cmFuc2ZlcnMgDQo+IGFyZSBoYW5kbGVk
IGRpcmVjdGx5IGJ5IHRoZSBVREMgZHJpdmVyICh0aGluZ3MgbGlrZSBTRVRfQUREUkVTUyBvciAN
Cj4gQ0xFQVJfSEFMVCkuICBGb3IgdGhlc2UgdHJhbnNmZXJzLCB0aGUgLT5zZXR1cCgpIGNhbGxi
YWNrIGlzIG5vdCBpbnZva2VkIA0KPiBhbmQgdGhlIGdhZGdldCBkcml2ZXIgaXMgY29tcGxldGVs
eSB1bmF3YXJlIG9mIHRoZW0uICBCdXQgZm9yIGFsbCBvdGhlciANCj4gY29udHJvbCB0cmFuc2Zl
cnMsIHRoZSAtPnNldHVwKCkgY2FsbGJhY2sgX2lzXyBpbnZva2VkLg0KPiANCj4gSXMgdGhhdCB3
aGF0IHlvdSBtZWFudD8NCg0KVGhhdCdzIG5vdCB3aGF0IEkgbWVhbnQuDQoNCkkgd2FzIHJlZmVy
cmluZyB0byB0aGUgbmV4dCByZXF1ZXN0LiBJdCBzaG91bGQgbm90IGJlIHByb2Nlc3NlZCB1bnRp
bA0KdGhlIGZpcnN0IHJlcXVlc3QgaXMgY29tcGxldGVkLiBEZXBlbmRpbmcgb24gdGhlIHR5cGUg
b2YgcmVxdWVzdCwgaWYNCnRoZXJlJ3MgYSBkZWxheWVkX3N0YXR1cywgdGhlIGR3YzMgZHJpdmVy
IHdpbGwgbm90IHByZXBhcmUgZm9yIHRoZQ0KU3RhdHVzIHN0YWdlIGFuZCBTZXR1cCBzdGFnZSAo
YWZ0ZXIgc3RhdHVzIGNvbXBsZXRpb24pIHRvIHByb2NlZWQgdG8gdGhlDQpfbmV4dF8gLT5zZXR1
cCBjYWxsYmFjay4NCg0KTXkgdW5kZXJzdGFuZGluZyBmcm9tIHRoZSBkZXNjcmliZWQgcHJvYmxl
bSBpcyB0aGF0IHNvbWVob3cgZHdjMw0KcHJvY2Vzc2VzIHRoZSBuZXh0IHJlcXVlc3QgaW1tZWRp
YXRlbHkgd2l0aG91dCB3YWl0aW5nIGZvciB0aGUgcmF3DQpnYWRnZXQgcHJlcGFyaW5nIHRoZSBk
YXRhIHN0YWdlLg0KDQoNCj4gDQo+ID4gPiBob3N0LiBUaGlzIGNvbmZ1c2VzIFJhdyBHYWRnZXQs
IGFzIGl0IGRvZXMgbm90IGV4cGVjdCB0byBnZXQgYSBuZXcNCj4gPiA+IC0+c2V0dXAoKSBjYWxs
IGJlZm9yZSBpdCBleHBsaWNpdGx5IGFja3MgdGhlIHByZXZpb3VzIG9uZSBieSBxdWV1aW5nDQo+
ID4gPiBhbiBVUkIuIEFzIGEgcmVzdWx0LCB0aGUgZW11bGF0aW9uIGZhaWxzLg0KPiA+IA0KPiA+
IElmIHRoZSBob3N0IGludGVudCBpcyB0byBzZW5kIGEgMy1zdGFnZSBjb250cm9sIHJlcXVlc3Qg
d2l0aCBhIDAtbGVuZ3RoDQo+ID4gZGF0YSBwYWNrZXQsIHRoZSBnYWRnZXQgZHJpdmVyIG5lZWRz
IHRvIHJldHVybiBVU0JfR0FER0VUX0RFTEFZRURfU1RBVFVTDQo+ID4gdG8gcHJlcGFyZSBhIDAt
bGVuZ3RoIHJlcXVlc3QuIEZvciBTRVRfQ09ORklHVVJBVElPTiwgd2UgZG9uJ3QgZXhwZWN0DQo+
ID4gYSBkYXRhIHBoYXNlLCB3aHkgc2hvdWxkIHRoZSBnYWRnZXQgZHJpdmVyIHF1ZXVlIGEgMC1s
ZW5ndGggZGF0YT8NCj4gDQo+IFRoZSBVU0ItMiBzcGVjIHByb2hpYml0cyAzLXN0YWdlIGNvbnRy
b2wgcmVxdWVzdHMgd2l0aCB3TGVuZ3RoID09IDAgKHNlZSANCj4gc2VjdGlvbnMgOS4zLjEgYW5k
IDkuMy41KS4gIFRoZXJlZm9yZSB0aGUgaG9zdCdzIGludGVudCBjYW4gbmV2ZXIgYmUgdG8gDQo+
IHNlbmQgYSAzLXN0YWdlIGNvbnRyb2wgcmVxdWVzdCB3aXRoIGEgMC1sZW5ndGggRGF0YS1zdGFn
ZSBwYWNrZXQuDQoNClJpZ2h0LiBGb3Jnb3QgYWJvdXQgdGhhdCwgYnV0IG15IHBvaW50IHdhcyBh
Ym91dCB0aGUgc2VxdWVudGlhbCBmbG93IG9mDQp0aGUgY29udHJvbCB0cmFuc2Zlci4NCg0KPiAN
Cj4gPiA+IEkgc3VzcGVjdCB0aGlzIGlzc3VlIGhhcyBub3QgYmVlbiBvYnNlcnZlZCB3aXRoIG90
aGVyIGdhZGdldCBkcml2ZXJzLA0KPiA+ID4gYXMgdGhleSBxdWV1ZSBhbiBVUkIgaW1tZWRpYXRl
bHkgYWZ0ZXIgcmVjZWl2aW5nIGEgLT5zZXR1cCgpIGNhbGw6DQo+ID4gPiBkd2MzIGFwcGVhcnMg
dG8gc29tZWhvdyBjb3JyZWN0bHkgaGFuZGxlIHRoaXMgaW50ZXJuYWxseSBldmVuIHRob3VnaA0K
PiA+ID4gaXQgYWNrcyB0aGUgdHJhbnNmZXIgYnkgaXRzZWxmLiBCdXQgdGhlIHRpbWluZ3Mgd2l0
aCBSYXcgR2FkZ2V0IGFyZQ0KPiA+ID4gZGlmZmVyZW50LCBhcyBpdCByZXF1aXJlcyB1c2Vyc3Bh
Y2UgdG8gYWNrIHRoZSB0cmFuc2Zlci4gU29tZXRpbWVzDQo+ID4gPiB0aG91Z2gsIHRoZSBSYXcg
R2FkZ2V0LWJhc2VkIGVtdWxhdG9yIGFsc28gbWFuYWdlcyB0byBxdWV1ZSBhbiBVUkINCj4gPiA+
IGJlZm9yZSB0aGUgbmV4dCByZXF1ZXN0IGlzIHJlY2VpdmVkIGZyb20gdGhlIGhvc3QgYW5kIHRo
ZSBlbnVtZXJhdGlvbg0KPiA+ID4gY29udGludWVzIHByb3Blcmx5ICh1bnRpbCB0aGUgbmV4dCBy
ZXF1ZXN0IHdpdGggd0xlbmd0aCA9PSAwKS4NCj4gPiA+IA0KPiA+ID4gV2hhdCBkbyB5b3UgdGhp
bmsgd291bGQgYmUgdGhlIGJlc3QgYXBwcm9hY2ggdG8gZGVhbCB3aXRoIHRoaXM/DQo+ID4gDQo+
ID4gVGhlIGNvbW11bmljYXRpb24gc2hvdWxkIGJlIGNsZWFybHkgZGVmaW5lZC4gVGhhdCBpcywg
dGhlIGR3YzMgbmVlZHMgdG8NCj4gPiBrbm93IGlmIHRoaXMgaXMgYSAzLXN0YWdlIG9yIDItc3Rh
Z2UgY29udHJvbCB0cmFuc2Zlci4gSXQga25vd3MgYWJvdXQNCj4gPiB0aGUgc3RhbmRhcmQgcmVx
dWVzdHMsIGJ1dCBub3QgdGhlIHZlbmRvci9ub24tc3RhbmRhcmQgb25lcy4gSWYgdGhlIHJhdw0K
PiA+IGdhZGdldCBkZWZpbmVkIHNvbWUgdW5rbm93biBPVVQgcmVxdWVzdCwgaXQgbmVlZHMgdG8g
dGVsbCBkd2MzIHdoZXRoZXINCj4gPiBpdCBzaG91bGQgZXhwZWN0IHRoZSBkYXRhIHN0YWdlIG9y
IG5vdC4NCj4gDQo+IFRoZSBjb21tdW5pY2F0aW9uIF9pc18gY2xlYXJseSBkZWZpbmVkLiAgSGVy
ZSdzIGhvdyBpdCB3b3JrczoNCj4gDQo+IEZvciBjb250cm9sIHRyYW5zZmVycyB0aGF0IGFyZW4n
dCBoYW5kbGVkIGRpcmVjdGx5IGJ5IHRoZSBVREMsIHRoZSBVREMgDQo+IGRyaXZlciBpbnZva2Vz
IHRoZSAtPnNldHVwKCkgY2FsbGJhY2sgYW5kIHdhaXRzIGZvciB0aGUgZ2FkZ2V0IGRyaXZlciB0
byANCj4gcXVldWUgYSByZXF1ZXN0LiAgSWYgdGhlIFNFVFVQIHBhY2tldCdzIHdMZW5ndGggdmFs
dWUgaXMgPiAwIHRoZW4gdGhlIA0KPiBnYWRnZXQgZHJpdmVyIHF1ZXVlcyBhbiBJTiBvciBPVVQg
cmVxdWVzdCAoZGVwZW5kaW5nIG9uIHRoZSB0cmFuc2ZlcidzIA0KPiBkaXJlY3Rpb24pIGFuZCB0
aGUgVURDIHdhaXRzIGZvciB0aGUgaG9zdCB0byB0cmFuc2ZlciB0aGUgRGF0YSBzdGFnZSANCj4g
cGFja2V0cywgY29tcGxldGluZyB0aGUgcmVxdWVzdC4gIEFmdGVyIHRoaXMgaGFwcGVucywgdGhl
IFVEQyBkcml2ZXIgDQo+IGF1dG9tYXRpY2FsbHkgcXVldWVzIGFuIGludGVybmFsIDAtbGVuZ3Ro
IHJlcXVlc3QgaW4gdGhlIG9wcG9zaXRlIA0KPiBkaXJlY3Rpb24gZm9yIHRoZSBTdGF0dXMgc3Rh
Z2UuICBEYXRhLXN0YWdlIHRyYW5zZmVycyBhcmUgbm90IGFsbG93ZWQgdG8gDQo+IHNwYW4gbW9y
ZSB0aGFuIG9uZSB1c2JfcmVxdWVzdC4NCg0KSSB3YXMgdGFsa2luZyBpbiBjb250ZXh0IG9mIDAt
bGVuZ3RoIHRyYW5zZmVyIChhbGJlaXQgSSBmb3Jnb3QgYWJvdXQgdGhlDQpzcGVjaWFsIGNhc2Ug
b2YgY29udHJvbCBPVVQgZG9lc24ndCBoYXZlIDMtc3RhZ2UpLg0KDQpJZiBpdCdzIGEgdmVuZG9y
IHJlcXVlc3QgMC1sZW5ndGggdHJhbnNmZXIsIHdpdGhvdXQgcmVzcG9uZGluZyB3aXRoDQpVU0Jf
R0FER0VUX0RFTEFZRURfU1RBVFVTLCB0aGUgZHdjMyB3aWxsIHByb2NlZWQgd2l0aCBwcmVwYXJp
bmcgdGhlDQpzdGF0dXMgc3RhZ2UuDQoNCj4gDQo+IChJTU8gdGhhdCBhdXRvbWF0aWMgYWN0aW9u
IGlzIGEgZGVzaWduIGZsYXc7IHRoZSBVREMgZHJpdmVyIHNob3VsZCB3YWl0IA0KPiBmb3IgdGhl
IGdhZGdldCBkcml2ZXIgdG8gZXhwbGljdGx5IHF1ZXVlIGEgMC1sZW5ndGggcmVxdWVzdCBvciBh
IFNUQUxMIA0KPiBpbnN0ZWFkIG9mIGRvaW5nIGl0IGF1dG9tYXRpY2FsbHkuKQ0KDQpXb3VsZCBl
dmVyeSBVREMgaGFzIHRoaXMgY2FwYWJpbGl0eT8gSSByZWNhbGxlZCBzb21lIGFyZW4ndCBjYXBh
YmxlIG9mDQpkZWxheWVkX3N0YXR1cy4NCg0KPiANCj4gQnV0IGlmIHRoZSBTRVRVUCBwYWNrZXQn
cyB3TGVuZ3RoIHZhbHVlIGlzIDAgdGhlbiB3aGVuIHRoZSBnYWRnZXQgZHJpdmVyIA0KPiBpcyBy
ZWFkeSwgaXQgcXVldWVzIGEgMC1sZW5ndGggSU4gcmVxdWVzdCB3aGljaCB3aWxsIGFjdCBhcyB0
aGUgU3RhdHVzIA0KPiBzdGFnZS4gIEluIHRoaXMgc2l0dWF0aW9uIHRoZSBVREMgZG9lcyBub3Qg
YXV0b21hdGljYWxseSBjcmVhdGUgYSANCj4gU3RhdHVzLXN0YWdlIHJlcXVlc3QuDQo+IA0KPiBO
b3RlIHRoYXQgdGhlIGdhZGdldCBkcml2ZXIgaXMgYWxsb3dlZCB0byBxdWV1ZSBpdHMgdmFyaW91
cyByZXF1ZXN0cyANCj4gZWl0aGVyIHdoaWxlIHRoZSAtPnNldHVwKCkgY2FsbGJhY2sgaXMgcnVu
bmluZyBvciBhZnRlciBpdCBoYXMgcmV0dXJuZWQuDQo+IA0KPiAoQW5vdGhlciBkZXNpZ24gZmxh
dyBpcyB0aGF0IHRoaXMgZGVzaWduIGRvZXNuJ3Qgc3BlY2lmeSB3aGF0IHNob3VsZCANCj4gaGFw
cGVuIGlmIHRoZSBVREMgcmVjZWl2ZXMgYW5vdGhlciBTRVRVUCBwYWNrZXQgZnJvbSB0aGUgaG9z
dCBiZWZvcmUgdGhlIA0KPiBTdGF0dXMgc3RhZ2UgY29tcGxldGVzLiAgQnkgc2VuZGluZyBhbm90
aGVyIFNFVFVQIHBhY2tldCwgdGhlIGhvc3QgaXMgDQo+IGluZGljYXRpbmcgdGhhdCB0aGUgZWFy
bGllciBjb250cm9sIHRyYW5zZmVyIGhhcyBiZWVuIGFib3J0ZWQuICANCj4gUHJlc3VtYWJseSB0
aGUgVURDIGRyaXZlciB3aWxsIGNvbXBsZXRlIGFsbCB0aGUgb3V0c3RhbmRpbmcgcmVxdWVzdHMg
DQo+IHdpdGggYW4gZXJyb3Igc3RhdHVzLCBidXQgdGhlcmUncyBhIHBvdGVudGlhbCByYWNlIGlu
IHRoZSBnYWRnZXQgZHJpdmVyIA0KPiBiZXR3ZWVuIHF1ZXVpbmcgYSByZXF1ZXN0IGZvciB0aGUg
Zmlyc3QgdHJhbnNmZXIgYW5kIGV4ZWN1dGluZyB0aGUgDQo+IC0+c2V0dXAoKSBjYWxsYmFjayBm
b3IgdGhlIHNlY29uZCB0cmFuc2Zlci4pDQoNCklmIHRoZXJlJ3MgYW5vdGhlciBTRVRVUCBwYWNr
ZXQgY29taW5nIHdoaWxlIHRoZXJlJ3MgYSBwZW5kaW5nIGNvbnRyb2wNCnRyYW5zZmVyLCBmb3Ig
ZHdjMyBVREMsIHRoZSBwZW5kaW5nIGNvbnRyb2wgVFJCIHNob3VsZCBiZSBjb21wbGV0ZWQgd2l0
aA0KYSBTZXR1cF9wZW5kaW5nIHN0YXR1cyBpbmRpY2F0aW5nIGFib3J0ZWQgY29udHJvbCB0cmFu
c2ZlciBmb3IgZHdjMw0KZHJpdmVyIHRvIGhhbmRsZSB0aGF0Lg0KDQo+IA0KPiBJZiB0aGUgZHdj
MyBVREMgZHJpdmVyIGRvZXNuJ3QgYmVoYXZlIHRoaXMgd2F5IHRoZW4gaXQgbmVlZHMgdG8gYmUg
DQo+IGZpeGVkLg0KPiANCg0KQlIsDQpUaGluaA==
