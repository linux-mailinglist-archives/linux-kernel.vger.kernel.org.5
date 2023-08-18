Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9054478146E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 22:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380068AbjHRUqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 16:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380100AbjHRUqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 16:46:38 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CF7128;
        Fri, 18 Aug 2023 13:46:36 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IKVXdw024673;
        Fri, 18 Aug 2023 13:46:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=3e4QSUGygB55p93Or6S7TgpmvguszN/QHoz42dwabe8=;
 b=nixJzKyt4qLaK6BkLPTAg/T4+f0jcPqeMpYQMi5pTrh3bMXwvUMG3FrlucHMvnlXyNhK
 +sSxvXlgfRWrOFiqxPi9QgZJOVbAyBP8M6XMRlyfi3hLBANHPU+HTjWPfVTJMfd0ayY/
 pYieC9zmS/F1V11Ksl+2hcvzwz19US+MyMG7sIXXARGxpFwH2L3369J2vwTVEWHzRPkQ
 CAOFJe7WKDRlfjR6UijQQTcjZiHAwVM3tf2VNYh7OIozESfcsYFPOgCP32642kYjtJ3G
 ou4uzhHyuvRwmxLtMbgOZXm828RRXvH5B0mJVmUellasZvCVlqggtgUDCShYcBeQOWQa Nw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3se93kwv42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 13:46:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1692391580; bh=3e4QSUGygB55p93Or6S7TgpmvguszN/QHoz42dwabe8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=DLZECbY0DBh3JvCKJN0tHgAl1zjI2uuPPC0y/WayjlL1e13dP4wW0Rd39TJNpoa+S
         615ZxniS1R6C0wpDS+ouEoUdZBsC6C93gW9xGoo1UmieUfcrDcOZlXfdZe3CQWHLXv
         ke1gzlRAyGNNF4mbG9oQdAR0mFxVC3bc/3vVJ1x1BrOBYs3RuUj1ol39cxrApBKyF8
         6x7R6SVzAuiHnn3Y2uVYO9KmAyQXa6g2H9TVwnufkPZplBVjrVAQm1N0PBRYQsjzZI
         AyHPlwFcSggVpuS1vCDElPVBLLQp2nxNex1HMAiqnw99jzqeHYLniJ8F/O3ArOr9d6
         75cANEYEo8jQw==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3D480404F3;
        Fri, 18 Aug 2023 20:46:19 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 843BBA00CE;
        Fri, 18 Aug 2023 20:46:18 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=gR7D1Lpg;
        dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D76054012B;
        Fri, 18 Aug 2023 20:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asgv7bMSARVGtj58jhZP0h7yWGP2k1iI4sosUs/NqGau4DL7y6DKkndGficwDhoakXc5WS7+TlRej7nkFcxpUxhxMH59FE93tAT7FExfoZag/jDeh6LMLoHc+HRLEQ0dvUIITgnneIhrKS7v7C0zbNr6qboqdKKOcfL09oTgAM5nSYbTMd3duyLuBx46QNa4y75mz0rtDmEtqV4d0PQL/328uccPuogq6Fw4Eblw+8DCUdGrxlpt0lxWuYeuglL0widASPlf8AUjg3omYolcynplDE/x5AL6DstxtxdADvCGtEne9pg4dWisgcDU69+fozSnZ+fBeI0yPKE6VlDZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3e4QSUGygB55p93Or6S7TgpmvguszN/QHoz42dwabe8=;
 b=BKaTtxq2iEaNduKNx/bkuNstpYHVBfmFWnvmSvbix1svi/gBEdb1PU3ocjVykZ/y3ZOSKwjr1nSs1W9m0xEzyQB3NKlI7Gz0y3uIz9K4+cRGZXlNEBgKTN51TQ/dF/FsvKMWRMddEM1NVwjMBcZ6BMnMln+c+ipe3kXSYbM4hq52W9m4vMe2PRthO9DkvqK3xUuYjK6b7nPSTDk97oBCA+TMnazEbbmhAR6AZovT/+0ALAZULqEWWYsDOHErADLj8Bzkd/hGOfV1g/2LG/h4abHLms0rJ4Ky8/3kuzK7ymNK7P1Xd8RSMUi4+9mzsneuaCeGMw81hZ/C4NbmaKHR7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3e4QSUGygB55p93Or6S7TgpmvguszN/QHoz42dwabe8=;
 b=gR7D1LpgfzkO19TA+QuPixUbRAyMTnHC4j/mUzSHS/8ZW+CBLSwRPfCzn4+z1+wMDT+VYPc8VlQFFDc3eHhH35UjYu0VG9k5RrYtZbtz32W2lBpdZ21N6Boe7pDChHyNsKZWsqHpbqZeFfNV36QQUzOQBy1y303HhVHKVf8g5/A=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SN7PR12MB6671.namprd12.prod.outlook.com (2603:10b6:806:26d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 20:46:15 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b18d:912e:908a:5952]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b18d:912e:908a:5952%4]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 20:46:14 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Thread-Topic: dwc3: unusual handling of setup requests with wLength == 0
Thread-Index: AQHZ0WkxsEX2ZGMtZEmcF1gvP2WuTK/vPhuAgAAY0oCAAAlogIAACMGAgAEOQgCAAA/fAA==
Date:   Fri, 18 Aug 2023 20:46:14 +0000
Message-ID: <20230818204610.byxapbhaqxxnvqvm@synopsys.com>
References: <CA+fCnZcQSYy63ichdivAH5-fYvN2UMzTtZ--h=F6nK0jfVou3Q@mail.gmail.com>
 <20230818010815.4kcue67idma5yguf@synopsys.com>
 <bb470c47-c9dc-4dae-ae3f-c7d4736ee7e9@rowland.harvard.edu>
 <20230818031045.wovf5tj2un7nwf72@synopsys.com>
 <cfc7ae18-140b-4223-9cc2-7ee4b9ddea28@rowland.harvard.edu>
 <20230818194922.ys26zrqc4pocqq7q@synopsys.com>
In-Reply-To: <20230818194922.ys26zrqc4pocqq7q@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SN7PR12MB6671:EE_
x-ms-office365-filtering-correlation-id: 86985d54-27d9-4a6a-9938-08dba02c2a25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E61oQ0ZWnUEvr6ISOKxh8yYTdApR2pmyM8eNusTswDRKSGrbkT4PhinXhzpY7jwyepdIm/wqVfTsOZTMnEELtRWAQHVZxrKmyHf0KCfLWdiOvVSZUS/VBbPl8yVt9SnFNroaK2Oe7NfD87bMLlrQeYVtyXyh6pisRtZq1VmvopFkbNdupBOAa0XybJeIRIu0/F8S9fl6nkWsPJzgXxnZ02PbO+2qn6hizFPT0JqEjZobUKKhjaF/aGowzpDnKlBceJc2tqQPjNZxBFWMgKzhuSlLg8eh88Uw1CyQq40+719BDqGDhnJHwxcm0KiEJJGFx1FlihwJ2UNv996tAPYYVI0xAreiqOt4YrDIH5lC4z3WiGj9JHIMRhTyDcOOQBIi8IOxCR9ld59Y9vJLqhjyRuByQkro5KBYPmy9/Fw/cUf3TQQgsoqbpz+E3/OWq+wfzaoewbzwe+VaoX9Dtw0Fqto/WuDqTM5FGEtdAlPnFtbV+zPlgFVA7SXKNkl8UKms7njrENdSoxvnRqnoYdOSO32BlN+kHl1pF8BGQQrzJ4VF4t+FB73G3Gh0KM19ExFNkH5ycR8jSaQSiUGGRCx/nFE83vDKfp8zO5FhJZJ/f38ddLgRBk3zPieu0tkXm+KS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39860400002)(1800799009)(186009)(451199024)(3716004)(2906002)(83380400001)(6916009)(66446008)(66946007)(66556008)(478600001)(76116006)(54906003)(71200400001)(64756008)(66476007)(6506007)(6486002)(316002)(6512007)(2616005)(91956017)(5660300002)(1076003)(8676002)(8936002)(4326008)(41300700001)(26005)(86362001)(36756003)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3V6L3ZIZy9NUmg0VTdUdFYyNitQRFhEN3FPa1dTbVB6QklkdWZEQk9iOERR?=
 =?utf-8?B?bm5DTjZRM0dOdzVFdjZ2cmxZS1NzdEpzMnMyWi94bkd5YzNhVXAyYi9jc1Rn?=
 =?utf-8?B?blVVMTEyYkNYT0o3SStQN01ZZWtVWnBSUEY4Nlo5U3IxR1BtQWdpb0ZyT09Q?=
 =?utf-8?B?MklDN0xTRTVJMnZFekxQSkw3YXBNSXFnaWhQQlgrYi8yM1FRSzZleTZ3cHlz?=
 =?utf-8?B?REt0dHltT1QzWXpFNnp0YjMwWXZGOHBEVHcrZFRkRnZHc0UyaDRrQjlrcEFG?=
 =?utf-8?B?b1VrejBqaEtEWDhnY0xWeHIvRnFoZWVSSFFxWE1NN0V0YUlUMFZLMVYvRkli?=
 =?utf-8?B?V2YyV2QxVlZXek5WRHppVkNnakVwQUN3d3UxZ1JhQnN4SmpjUmdOcVdmYlF4?=
 =?utf-8?B?M0xuTkw4bDlzT0c4bEZNUHdFK3ZMcFpQRkFKRVBrSklmc3AxNEpRM0dBdVpF?=
 =?utf-8?B?ajRUc1BYeWtLVTFKbk5mWWExb2prN0FwQkdkeDg0U04wWTcyZkVEcGtzM2kv?=
 =?utf-8?B?RVpobFpGRWpjVENsckp1eUtEQmxhUXR1K2RqWVZJUFAwYzBkTTB0R1BMT2Zp?=
 =?utf-8?B?YlYzZFpjOUZ2c09vdCtJWjkwQXQ1UXBDU3B6Ym9YTWxUQVJ1Z2lMa05FOCs5?=
 =?utf-8?B?WHMzRVFZcGwwNzAxZjY2WmlOaGlxbTVCMGFOWUxBUjNGYjFKTFlQKys3MGt3?=
 =?utf-8?B?anM5Sks2a0MyOHZOcU9hazBKK0ZuS1g5TXdlZmFFRnI2SEdrS2Fab0IzaE9w?=
 =?utf-8?B?cTJvaGk0NDBPVlBzZWp3SVRNM0xzYWV5dWJ4L1ZDNlkxZDBqc1A5S2VrV2FK?=
 =?utf-8?B?ajFCSllIQmt2NUROTXk5b3lSOVV2dTk4K0tCMkRiNGpiMWxGeGp1UWRWbXBC?=
 =?utf-8?B?UXQwT3h6YmpUZEhXYVMrWTRJanRIaCtZSGJwZ055U3VQVk1xd3F2OEw2dVJP?=
 =?utf-8?B?ZjZ5bmlEeFRiQk9kU20wUlZzeXpnM0JmTnI4UWp0U1REQ2FGWjBaN2pqcVVi?=
 =?utf-8?B?Z1pFVUIzTHl1TmgxS1hsdFArUDZCTEFjd1B0dEpuTWIwVFNsSnRmRkxkdzl2?=
 =?utf-8?B?SkhSbnlHSm9LNkVEWkhCUzdCNmY4a1hveFk1a0tFZldoaTF3b25ZNVg0aVBo?=
 =?utf-8?B?KzNtV1F6REdQdUpLLzc0VWozMm9EUnZiUlUwamhvdi8wc3JhN3ZvamRrcTJF?=
 =?utf-8?B?MHJ4Z3R5VW9CUkdLSVA4KytDMnJGeExweEp5OVFHVU90UHpnUmtjdURlMDkx?=
 =?utf-8?B?WVR5VzQ4RVpNR2tQNVhWbWZOWmlUcUJKRHJYeUtRZFQ3ZENXZ3J2b25tWVpR?=
 =?utf-8?B?aWt5bE1WaUNzcjVpeHN6NlNRUEp4aDRhNkdENEtFazZ4K2JHeGVMZDhQbmFu?=
 =?utf-8?B?c3JhdjdJSlZLUFQrWnVWMzBSU2xpUVhvUTlQVzl4c3FhY2pEbVlpSUQ5c2lN?=
 =?utf-8?B?cFVrQXh6WHg0UlBzcWl4YnlxTnExZVdtQzcxRGx4Nk1GKzJQdFVoWXhidFBj?=
 =?utf-8?B?ZjR5cTltTWNJZ2w4Nlp1MnM5OUxlL2hBZWhtWHhBUmRUNnZvZU1WNlhjSDdK?=
 =?utf-8?B?eWZnemx0WWVrcVlKSkxZcGt6NEo5TWl4azhZM0NPeVpKUDR3YS9TM0t5RkhB?=
 =?utf-8?B?enNnc3VMK3ZzODUyUkc5Y2hjSmMvTmVtUXkxT0h1MWx1dzlKMUJTTU9CM0J5?=
 =?utf-8?B?SkwrbGY2YjM4cmhCMEVaNHR1K3ZXV3NhRmJBc3MweE9HcUJ4UDN4K2NRZnlw?=
 =?utf-8?B?UkNwY3V5T3JUZnpKWkp5akljazhJUldXbXVBQlF2enJTRWhrKzNlMHFmRGM0?=
 =?utf-8?B?bHdYdk0xcFc4R2d2RWpHWFZWQWdpeTZPTlBkNVJkd1FzQ2ZUY1l4Wk9ZdXYx?=
 =?utf-8?B?akhUNkp2alNYaG83L0lsem1TRkNlNEtXVmREQU9RaUV2TGVLOUhoYTBUSkpi?=
 =?utf-8?B?N0dYVGxqMkJ0d3lvck1GYWl1SW82cklEamcwTnhqTk0zMGFZczA0bFgrMzRn?=
 =?utf-8?B?WjNKWWtxb0FXUmtPVUdNTlg5Y0QvK2RqRlk1eVpnalR4eWxBMzNSUlk4ejI5?=
 =?utf-8?B?TmVNTW1KWnU5YXE5ZTNZQldDaHhGY0lMTTVGaG9HajhQQjJHbFNOZ1g0Qkpz?=
 =?utf-8?B?YXNheDJyMWZUQnEyZ1FNY3R5dCtTeVFSV0VoeDlkWHUxTG03TktTU0wwaFdD?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27C74C4815FADB4EA55FF102D013DF2D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SnJLeGhNVFNHNlZSajlUYS8zY3Bmbm1KLzFtVThySTdkZmFjM1RkVGhYU1Nt?=
 =?utf-8?B?ck50ZzdySXJpdjJCaW1oWkNRbkxPdHZTWGUrUjBNVUtSc1dzcExCZ1hQbGxV?=
 =?utf-8?B?bDJ6QVFWYS9QQVh4UEt0Qm5jOGRPZmVpNDhRb2VYRWYwcTZMSUVJVG9hc0pp?=
 =?utf-8?B?SUdzRVNOUDYwWDZHeUo5eTlEendBbmN6eS82cTBDVWsyRVNWWXdlazUxc0p5?=
 =?utf-8?B?Wm5LRldZcHZGS1U2TExVZDgwcDZTZys3QUtRdm1Eb0h6Z0NhQVhlWWVzRHYv?=
 =?utf-8?B?RXVjYXNiWDh5UVJldlNhZTFYMEpYWWZIL1oySHozbmwzOHF6ZWVCd1FxRUxR?=
 =?utf-8?B?TWI0eHZVN2YzNnZvWVdwbEJ5WFk4U1dIWGF5YXBBZ0gySmlGQlM4WnNJTi9B?=
 =?utf-8?B?eTNhUytEMmVhLzR0ZFp2aFFjRFV2bFFiVzF4b0pRd0gwVnhERitRQmNZV3F3?=
 =?utf-8?B?cy9SZU8xWFhNejY1bXRwa2docVNBQ1RoZ2VZTDI2R0o4cnRTejN5SFh3WDdW?=
 =?utf-8?B?MWx5SEpYNjczUlY0emh0Q0FJUGJ0T3BMbTdjL3JJRlovRE15K1pSUnlJcmVw?=
 =?utf-8?B?RXp6cENDcldZZG5zMXRGNlI3K0NrOXBVUXJ4K0xJRGcvVi9oMllsSXd1N1Uy?=
 =?utf-8?B?aHY5SWJUazFZU1NiVDhuWFZRR0wwOGVvQXFOYTA2QWFNNFdTOU8vK2Y3eHJG?=
 =?utf-8?B?dWFUbWZHOEV5R1RsWVJSZGw4MW1rS3c5TjAwenBtQzk3NlE3UGQrSEVzc25Q?=
 =?utf-8?B?ZHFZMCtxSk9CY200Yk50c1ZFTGdndlhIWWR2NHhDWWNMU2JSaS9GSU1kbFBu?=
 =?utf-8?B?ckJtVDgyMndLYWJoamVwZlU5cjRMNmJTUjRnbHBZbGQ5RnRnMDJUckVlaFVk?=
 =?utf-8?B?cGY0allkc3g5ZTZmdVhkTTgrekt1a3kxcXlmUFFzTVFWQkg3T0oyWDlvNzFr?=
 =?utf-8?B?OHJaMmVCVVIvVEtOU1pSY2JLdDhHalhWUlp1TTVHYitreWxzNjArTG5CVzVh?=
 =?utf-8?B?YUNxdzNDVDJscEpPalBLYlFleEJUOGVHY0dGZXQyeCtOd0RRSThybFpoM0xW?=
 =?utf-8?B?WHZpYTFvUkNmYTVUSlJCSVZYUGJPb2dtZ2FSSUJTbG91UGlyUXhBMlUvNmxh?=
 =?utf-8?B?bGxEMUJlVEM0MVZXR2FsQlJTOXh3YVo3Wlh6WXBma0J1SWpObVhEd0dCTE9m?=
 =?utf-8?B?U2puTXBFWFVWMGJ0VVJwMlpJeXJrd2hzWi9MY2FGbGhSSERjOG1RWEhHMks3?=
 =?utf-8?B?RFc2eThmRUFFcVlxcTBsL0cyYUl3VDVSTTZ3MEtpcUEzUTJTUT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86985d54-27d9-4a6a-9938-08dba02c2a25
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 20:46:14.8596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WGgnB21rGJAV8/5va4TRljN3kEHWSCL4rqKwotoRjEI2Dewf60Dj9voCxQBAj9QrBA1jWbtEWICJDZnGnjrGnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6671
X-Proofpoint-GUID: 4wSSI4dArVfj7yxOQgcYFvnXhNpnVXHU
X-Proofpoint-ORIG-GUID: 4wSSI4dArVfj7yxOQgcYFvnXhNpnVXHU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_26,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 mlxlogscore=798 adultscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308180189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBdWcgMTgsIDIwMjMsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiANCj4gPiBSaWdo
dC4gIFRoZSBkaWZmaWN1bHR5IGRvZXNuJ3QgaW52b2x2ZSB0aGUgY29tbXVuaWNhdGlvbiBiZXR3
ZWVuIHRoZSBIQ0QgDQo+ID4gYW5kIHRoZSBVREMgaGFyZHdhcmU7IGl0IGludm9sdmVzIHRoZSBj
b21tdW5pY2F0aW9uIGJldHdlZW4gdGhlIFVEQyANCj4gPiBkcml2ZXIgYW5kIHRoZSBnYWRnZXQg
ZHJpdmVyLiAgU29tZWhvdyB0aGV5IG5lZWQgdG8gc3luY2hyb25pemUgc28gdGhhdCANCj4gPiB3
aGVuIHRoZSBnYWRnZXQgZHJpdmVyIHF1ZXVlcyBhIHVzYl9yZXF1ZXN0LCB0aGUgVURDIGRyaXZl
ciBjYW4gdGVsbCANCj4gPiB3aGV0aGVyIHRoZSByZXF1ZXN0IHdhcyBtZWFudCBmb3IgdGhlIGVh
cmxpZXIgYWJvcnRlZCBjb250cm9sIHRyYW5zZmVyIA0KPiA+IG9yIHRoZSBuZXcgYWN0aXZlIG9u
ZS4gIFRoaXMgY2FuIG1hdHRlciBpZiB0aGUgZ2FkZ2V0IGRyaXZlciBoYXMgYSANCj4gPiBzZXBh
cmF0ZSBjb250cm9sIHRocmVhZCAoYSB3b3JrIHJvdXRpbmUgb3IgYSBrdGhyZWFkLCBmb3IgZXhh
bXBsZSkgdGhhdCANCj4gPiBjb3VsZCBiZSBxdWV1aW5nIHJlcXVlc3RzIHdoaWxlIHRoZSAtPnNl
dHVwKCkgY2FsbGJhY2sgaXMgcnVubmluZy4NCj4gPiANCj4gDQo+IFBlcmhhcHMgdGhpcyBjYW4g
YmUgaW1wcm92ZWQgYW5kIGVuZm9yY2VkIGZyb20gdGhlIGNvcmUuIEF0IHRoZSBtb21lbnQsDQo+
IGl0IHNob3VsZCBub3QgYmUgYSBwcm9ibGVtIGZvciBnYWRnZXQgZHJpdmVyIHdpdGggZHdjMyBk
cml2ZXIgKHdpdGggYQ0KPiBtaW5vciBmaXggZHVlIHRvIG1pc3NpbmcgY2hlY2spLg0KPiANCg0K
UGVyaGFwcyBJJ20gdG9vIHF1aWNrIHRvIHJlc3BvbmQgdG8gb3Zlcmxvb2sgd2hhdCB5b3UndmUg
c2FpZC4gSSd2ZSBvbmx5DQp0aGlua2luZyBhYm91dCB0aGUgVURDIGRyaXZlciBzZXF1ZW5jZSBh
bmQgbm90IHRoZSBnYWRnZXQgZHJpdmVyDQpoYW5kbGluZyB0aGUgZ2l2ZWJhY2tzLiBZZXMgaWYg
dGhlIGdhZGdldCBkcml2ZXIgaGFzIGEgc2VwYXJhdGUgY29udHJvbA0KdGhyZWFkLCB0aGF0IG1h
eSBiZSBwcm9ibGVtYXRpYy4NCg0KQlIsDQpUaGluaA==
