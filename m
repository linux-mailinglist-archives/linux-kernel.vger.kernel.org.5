Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B32F7C795F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 00:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443006AbjJLWSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 18:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442974AbjJLWST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 18:18:19 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A9ABB;
        Thu, 12 Oct 2023 15:18:17 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CJinen027355;
        Thu, 12 Oct 2023 15:18:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=i7Uf1ItCgkQ4+SPpqs4oOtmReEN6L/JGo1JXmSsm65o=;
 b=jFRPsAbhLtbPYdQVfcCMLVNx5NXWZZcxE+y+EJEKuHEbl5XYDvX7D+r79IjxmI+5F+xD
 MVmrJd4O5ulY6PrzZeSJpfJkiyP285J31lkkbR45l85ZoYMbJmOPU8HLFfRL/SLStXmP
 eY8B3ON9FfsJ6wD/dxQ+creODCPxHfWxE3JS5vYyDROAgYs5XPQUpo1qNsrFJUxzo5oJ
 nfT6kduGCtfK0w9oUwiCp3/fZ2zfVyoo5G81dzNLpJxT4ADgxcxFWM7lhffn+Dzo5ygY
 8Lb55e8LZhKBQFRERZnLkF1LNI308zKKNSJbTZaWZ7l1mCKyvY6VoR8bZFMjuOQ2xa/u hg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3tkh042kx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 15:18:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1697149083; bh=i7Uf1ItCgkQ4+SPpqs4oOtmReEN6L/JGo1JXmSsm65o=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Qgu5gBspqdc//247ww+4fJ+AqFT2ipZdgfQsW/cG7g2VAXB6wNisSfjgVDYN1Rxih
         cLlafZd5v4fn8Zp6REqy0NT+5f+OHnrcjlFty0UzmdXad4BeBn7iiHEwPlXDGfgi/Z
         MTdP7cVGcf3H0C3gw/OF0aZExLDabAofSxlLCNz9UzQMo9b+fuEWcrABsCdpAAyiSW
         osCwzVPPSKGsKf/mE2SwXQj6RwzeRDpAk7ZpxjPQ7e8YTZS8ztsQkQoMG56Ss2Rkpp
         x0Zm9tmUNDlpJLnHfM3M9qwMJ4L+izRdNDYZSTN87pu45B9Lyrkd1hLJcFcgJa5Bdc
         kxB7kZYXCkSWQ==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 89B76404D0;
        Thu, 12 Oct 2023 22:18:03 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id EDE08A007F;
        Thu, 12 Oct 2023 22:18:02 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=kJigMz4x;
        dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 22C814013F;
        Thu, 12 Oct 2023 22:18:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3sMLhaApHSoJUbRud6DN7QpF/Owp9uXMKj9I2efeNx/rqDkcg/h06ZTfrZYgGuy/D4WtwuaqyHzTg7KDE9Csj3BDiBDGsgIjzQCgcZPZJAKw7sM2ebcix3JH/5FHDwsmO/lqZsdNNFQVX/dTz9tjsmn6jdT7/Bp3korGid4xgwmU3gHBH1E6a5opyU2CE0qVec0f1vo5GxUle6EaPFONrTnkbWJBg10jkEu0/ydfqKuwNOauzqs6egspXxfn84fR3KPYp8dD3PtMJTWeqoK4+n4Xbn3u8NQLC7ec2G4irb8vs0B9VyAOFgqWA3EF0fhYkYERT67puszmNkCYFR+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7Uf1ItCgkQ4+SPpqs4oOtmReEN6L/JGo1JXmSsm65o=;
 b=DLrpd6wnKQ0FH7kvBKFX69NiX5t8hk1hFttAV8UFDY1QfbB1wdfmHGy5BBVhfcZlZG3f/auq1lBDXqcjygoxmz1FoxIx0aI9ey9e0sUJN1eMtYtXidGxy/P7j8fceo9ymuKqgO8jO2OLTyFUdWVyUJ1v6z9mdT4BkePAK6Ut28ftji92EY8z8MWlJlGNF0ZjEvwRwG4Qt6x6gWYUaw4dTZGNjoghkycyRAZbwcPaJccxf/Y8WCd6EP+oCB8jUY1CcpHIdOpqCNyRxQRQqK8OMjziAjpfxDwQ9HIX8arNrkBnUIlJg8uvHKZsF09nHCSYdSS+ngZQTp/AOf6GlH2ERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7Uf1ItCgkQ4+SPpqs4oOtmReEN6L/JGo1JXmSsm65o=;
 b=kJigMz4xdI8u7gQClIVa+Vde+MbisdbL3J+oB0ZCEJHEydv9xuwgfbP5zUYbLpwDbtHDP7IndX7Hu9XfCpilYkYFCy0LHsTB3pBSvpCRkQhkBAKr3miJ+iTDxF9dmNPIjV9MHz9Jqnb/bCWq4g0YigmE9mdF1U194yGxJNQOUdk=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH0PR12MB7906.namprd12.prod.outlook.com (2603:10b6:510:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 22:17:55 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b398:9c9e:3818:b7a2]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b398:9c9e:3818:b7a2%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 22:17:54 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
Subject: Re: [RFC] usb: dwc3: core: Fix RAM interface getting stuck during
 enumeration
Thread-Topic: [RFC] usb: dwc3: core: Fix RAM interface getting stuck during
 enumeration
Thread-Index: AQHZ/CoP25al8cFBjkKV4rWMrsyj2bBGc0gAgAALIwCAAD0ZAA==
Date:   Thu, 12 Oct 2023 22:17:52 +0000
Message-ID: <20231012221744.ww2w6febhurvlqi6@synopsys.com>
References: <20231011100214.25720-1-quic_kriskura@quicinc.com>
 <20231012175912.umc3ugzk4iqwtcp3@synopsys.com>
 <bac414a7-aa2a-4b93-82e0-998002c455e0@quicinc.com>
In-Reply-To: <bac414a7-aa2a-4b93-82e0-998002c455e0@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH0PR12MB7906:EE_
x-ms-office365-filtering-correlation-id: 7ff2dc05-4702-4d04-1101-08dbcb7113ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KiTDRuxv5GE6i7qckyelnAnd5vuU4YYx9Roc6RnDZmc8uIf7gUy8sCHQ00Azi3W2GSUxWz1X+/bSBXfl2p9GFAP6DltnGOWdVcuzWB09QalkqDak/6iy9ZNrqCJTjSDpEYa2dbTREqqAsUBFU05GpWdfJFn48pcCL9jELzWCnZkb6zOc27gJSWQCqSbWQx7xiLZ+r4mjJ05S3RMX0eeUUPYFZkIzy+9pcBq2ihYTBXqGBlJar2WZiqWj2YKtYUGxIFr2jZqZL2DpJOlsCFLhF3lZlVnyzEtyxtp0KBX2N/+ei3xId7BfAFAJ9wtcouB9hkDDnjVTlIy2cMyBrJbeQFPJ9eJSaJsdLDoUql36HKANwAIud0Khdvjiu6DZo9RF8aFeawkHtOC2zxJe7wwYjqapFZqu3906QdKRvntOPbhoPmXt3pE30vnoxtP3wWqjy3xpKmFSmaH7LqT9zD4wYZnTBKRIl2AibDkDIs3tSm8+Sdu5iaiP6K+jpCJfjXg9L41ishzNpbhtepOAOMA+i888zlUx5+NpCalm4R9W5O8QdGeaN3hOzBKDtfTDPH5Fk1NPzWwjhSJdgtA8mfTX+N1MyyjUkLzKpi5HremYmhbwb99lnibeslQBeetyjeeg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(122000001)(5660300002)(38070700005)(41300700001)(4326008)(8676002)(8936002)(86362001)(2906002)(6506007)(6512007)(53546011)(71200400001)(64756008)(36756003)(83380400001)(478600001)(1076003)(2616005)(26005)(66946007)(66446008)(76116006)(91956017)(38100700002)(54906003)(66476007)(66556008)(316002)(6916009)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OS9DaUxJQVBzSkFXQ2QwY0ZZdW10VFJjTDVCeTQyWllwYUNlbktETWpQRGdk?=
 =?utf-8?B?eExoTGNWYXU5T3g1bytkaDA3ZVl2dXBpR1BjNGpZZEEyR0g2YzRnMFZJR2hC?=
 =?utf-8?B?OE43VExadUlYWC9kU2diMnoxc0FnQVhEV2xBb3ZHNllrTVFCT2x1ZGhIQ1NF?=
 =?utf-8?B?MWs5amlnQ0NDOCtseVJOVWY0UVRBczJucExIMG1KRzdIb2ROaU5KK3U4cEUw?=
 =?utf-8?B?SGJIMXJoNEhTZXV0dXIxdldQSi9aYkpvc0pjcHFEYXRxNjJhYlllNkhvTHNl?=
 =?utf-8?B?S2tCN2paeXpBZndSM1AvTVJONjRRRHJ1S1ZoY0JmaHR0dE92MXNSb2F0OWY5?=
 =?utf-8?B?M3Qvbi9qWmZucjhQajNZVkg4SEdZM1R0K0JBNEh2b09IM2c4OXpWQnUwa2kv?=
 =?utf-8?B?dlZDOFFwbmx1SHdkdXZTY3poNzZDbHN2dnZyUmllaURVVHhOR2RWSmhDVG9Z?=
 =?utf-8?B?VUJ3aXEvZTRLUmNFN0s5NE1PcGNlU2Zoc2VWeUlERU1ZdzlQRmZrcFJIZ3ZD?=
 =?utf-8?B?ZytCc2FuTFg0eExIZFUrMWN6ZHBleFBqL0dSVHRqckhFbTN5N01TblFyL0tr?=
 =?utf-8?B?dS9DZjJ3dU5YRlI2VE8yREN4cjF0YzFMaVhvVTg0N2UvYXliMkRlaWxMMUhX?=
 =?utf-8?B?NDJ1V2ZqM21qYStrZDlsWmJoNmFOdkU1U3pvV1NIcEJpS2JEeHlYYkhUQU13?=
 =?utf-8?B?WlZjNGNyT1pYNUwxeGRtNFhHNis4cjVxWDkzb0R2Y1ZnVy91K1BBcDVNYUQ4?=
 =?utf-8?B?RVFjRllIMjdWU0hVZzVhWHB5Tm1aZUI5emRad0N1SUwvcG13eVRXUFI3Yy9t?=
 =?utf-8?B?K2w3RTNtbXhGSmVwZjY3SkVFMzVCVytzdC8rcm1sYllHMGY4dkxxSVl1QVB5?=
 =?utf-8?B?cW1pRFFRanhVS0JnL1p2UThzakhGakZZSnFNYlpkU2liNFEwaFN6aVJ6WU5N?=
 =?utf-8?B?WjhML3IxSU16NVg3bHR0a243WnIrZFExMHBLTHpPMTF5bGlIbVJmNjQ4N3FL?=
 =?utf-8?B?TG1UUml3QVdJcXZRUnJLSzgyVmc2eVBXRytEYVVkVXU5KzFQQVZ0ZW4xejJx?=
 =?utf-8?B?UFpaOHhaays5bkNNQWs4UFFURGNDcVBjc3ZZRE9QcmdFeDk2Y0hyaUtUQ1hw?=
 =?utf-8?B?RVVyZnBheG9yWWRPNXYzMEJoRnpPc0tnSndrakkrVnBlbXhCbDhTYmRtbHV2?=
 =?utf-8?B?cU9IMEk0NDFCcDRrRjJpem80UDlieURlSzlYbERvSTREL1YzazA5VnprTmtN?=
 =?utf-8?B?MjZVNEh0cm1RaUpGelcxMzZpVHM2UWxDVXF0VEMyN1ozTHlkKzJvWE9FUVdF?=
 =?utf-8?B?Vlp5MHBHdWI0M1VVTk5XajVzR2VZajZTdTVBdUROTXgzOHF6MjkwajhSdXdS?=
 =?utf-8?B?OE9nVUhMbWwvK04xYnVobXpWRUZBK2xCY2o4c0I3WldIcU9WWUlhUFZZcHVG?=
 =?utf-8?B?cXU0c1VOQ2tEOVR5UmxJWThqank2MmgwMms0bmlvRHRRWUdEME1kWmZZakNY?=
 =?utf-8?B?N05sZHVib3l6d2g5UWlxeXJqVVF0NUZDQStKcXpPbFpYSE92aVhRZ1lhMUx3?=
 =?utf-8?B?SURTQ2NubGJpdVJzcGtUNUpHV203MmROZFhGT21HYVhTQ0RoTW5pSHRadGUw?=
 =?utf-8?B?dzFqU2Q4RE9LWXFMbG9KQTJyalh6VFYwb1IxbXJMN3NseVc5V2Qvdnd0TDJR?=
 =?utf-8?B?aDBsYWhMNWlXbVRFWEgrbGl2YWNsbDZ6WlczeEZZTU84S2Nnc3paYnQrOHlM?=
 =?utf-8?B?aWJvY1JwV05ISUhuY3VHZnYvc2hYQjFCYUtkb2ljcnpmQ3d2dXJ0cWRidFpG?=
 =?utf-8?B?MVczNHZKM2QreXBjeHA1SllFREIyY1dFWHkxT2dTRFBiZ3drcTlrbWlFNmZw?=
 =?utf-8?B?bUtOdnJLTEY2MmRmeXBtTEJ5N01JbmVJL0FDaG5TNldHOWY4bDViNmZJVmNJ?=
 =?utf-8?B?aVh0MzAxK0p2MS92SzBCQVBPWmtZanVOanVDbUMwcGQ0SWpHVjAyMVVNMWpk?=
 =?utf-8?B?K1Nob1oxZGlML2NmTUlpNmNSZUYzMVZhaStpbktNVzhCQWFKTzVCRzZLOGlw?=
 =?utf-8?B?UUJhdGhseUhmNHJ3WGtNMTdmNTc0Y0M4MmdvbXhVbTZGKytZR09SanZ1bStw?=
 =?utf-8?B?alFBVzlWdmg4cDcydHE0MEh4eU1tN0hiTTc1WVVtYmhUODI3ZkR2N1BVSDY2?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5025D3BDDEB17458CF93CA789A987ED@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sj9jqxO+CrajSpdzrryvh+nRpZQFaNpdQCgGk+Ms5a+8mE2zpS87RMfLnDo+4U6TgOHtwGLNfoQDIchA33LpyfOD3p2mg44+t8rULUwfu9BJL8XVQafjbWNgCRUs2QigsOiiPmN7rHUyEs5mPlQRf9o2AtvxPWaKyQNg+CLRMkLUjH4sZPYtnHlIe1mqqkkE7wdtBul/LvsMv+TRtrXqvoTDodui0AxoHtAlmfD1YdYt6tBGVvgx/A7ksLlzyWi4YY1UrrzrwQukWgC717qSuhU78ePuLZrDAoQV6M+RKWu2K2RTGldniEOE6jmg+H1K5jDZ4O0lD+YioO4wAK4W4z0WHsGHR7IP/W+WUXSiASn64JCZhTWvCN80gR/W8zNtsMJCONpHrqGmZ8GpRfrI/8H1Gu4pR2czGdyqVydYqjO+Cry0mtZj9+jXY5SIhNnGsY/QDiAdekiHgKKnPYTVTZ8Tbtb0Ym5vrO15RxVwINCvXo90dCguUc6f7Vag/U4egr516Yp+A+6j3zUNK1OhZ+zVfLhLUSRby5MUiYhyCo63Z8sL8fB6e04rQN6H+/WDiw/rjkPkBMi32zdt7y3CNfrNstjJeQoj406G6SuIIom/cOznrUC7pzgIrIqvBSS99o+RcWZfU5E5XicTuLYCoN1mkWXxeLr+FJZGmuqa89GHd6WzxO8Z7pc1APHq17HYIobqz4YBHwc35MccM35FyOb5yF4okIywAGrhCT3iRWwWIK+TZ48CCLyoqTwc+uACMPIwU0rV0A3iBNxTsMaF7xw37Tt5DqkWRtxIVWnfQqVcJQu9aVSBTtZayN6yusfuKoUDeY9jJEXuwb3r0VWmlGS3RlG5ekinTpcxSiS/tzu8Le29WehPgjfNmFpOkkSZ1gPSpvz1gSyfXKuUkNZ2AA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff2dc05-4702-4d04-1101-08dbcb7113ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 22:17:52.8726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RAHFCehnzl6zCjCr8uC638xjYrJwyENB2wtjWSvMS/vsb9Ub1LQu4NjAHTvpHER2YgHXxf//LXkekTA3vMFZ2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7906
X-Proofpoint-GUID: OlEe1uMp57pDu-qLMC3zb3hyQaVA2Fb6
X-Proofpoint-ORIG-GUID: OlEe1uMp57pDu-qLMC3zb3hyQaVA2Fb6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 mlxlogscore=857 adultscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120188
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBPY3QgMTMsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gMTAvMTIvMjAyMyAxMToyOSBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiANCj4g
PiA+IC1zdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3NvZnRfZGlzY29ubmVjdChzdHJ1Y3QgZHdjMyAq
ZHdjKQ0KPiA+ID4gK2ludCBkd2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3Qoc3RydWN0IGR3YzMg
KmR3YykNCj4gPiA+ICAgew0KPiA+ID4gICAJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiA+ICAg
CWludCByZXQ7DQo+ID4gPiBAQCAtMjcwMSw3ICsyNzAxLDcgQEAgc3RhdGljIGludCBkd2MzX2dh
ZGdldF9zb2Z0X2Rpc2Nvbm5lY3Qoc3RydWN0IGR3YzMgKmR3YykNCj4gPiA+ICAgCXJldHVybiBy
ZXQ7DQo+ID4gPiAgIH0NCj4gPiA+IC1zdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3NvZnRfY29ubmVj
dChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+ID4gK2ludCBkd2MzX2dhZGdldF9zb2Z0X2Nvbm5lY3Qo
c3RydWN0IGR3YzMgKmR3YykNCj4gPiA+ICAgew0KPiA+ID4gICAJaW50IHJldDsNCj4gPiA+IEBA
IC0zOTYzLDYgKzM5NjMsNyBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9kaXNjb25uZWN0X2lu
dGVycnVwdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+ID4gICAJZHdjM19nYWRnZXRfZGN0bF93cml0
ZV9zYWZlKGR3YywgcmVnKTsNCj4gPiA+ICAgCWR3Yy0+Y29ubmVjdGVkID0gZmFsc2U7DQo+ID4g
PiArCWR3Yy0+Y2FibGVfZGlzY29ubmVjdGVkID0gdHJ1ZTsNCj4gPiA+ICAgCWR3YzNfZGlzY29u
bmVjdF9nYWRnZXQoZHdjKTsNCj4gPiA+IEBAIC00MDM4LDYgKzQwMzksNyBAQCBzdGF0aWMgdm9p
ZCBkd2MzX2dhZGdldF9yZXNldF9pbnRlcnJ1cHQoc3RydWN0IGR3YzMgKmR3YykNCj4gPiA+ICAg
CSAqLw0KPiA+ID4gICAJZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcnMoZHdjKTsNCj4gPiA+ICAg
CWR3Yy0+Y29ubmVjdGVkID0gdHJ1ZTsNCj4gPiA+ICsJZHdjLT5jYWJsZV9kaXNjb25uZWN0ZWQg
PSBmYWxzZTsNCj4gPiA+ICAgCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0RDVEwp
Ow0KPiA+ID4gICAJcmVnICY9IH5EV0MzX0RDVExfVFNUQ1RSTF9NQVNLOw0KPiA+ID4gLS0gDQo+
ID4gPiAyLjQyLjANCj4gPiA+IA0KPiA+IA0KPiA+IFdlIGNhbiBqdXN0IHJlc2V0IHRoZSBjb250
cm9sbGVyIHdoZW4gdGhlcmUncyBFbmQgVHJhbnNmZXIgY29tbWFuZA0KPiA+IHRpbWVvdXQgYXMg
YSBmYWlsdXJlIHJlY292ZXJ5LiBObyBuZWVkIHRvIGRvIHdoYXQgeW91J3JlIGRvaW5nIGhlcmUu
DQo+ID4gDQo+IEhpIFRoaW5oLA0KPiANCj4gIFRoYXQgd2FzIHdoYXQgSSBpbml0aWFsbHkgd2Fu
dGVkIHRvIGRvLCBidXQgdGhlcmUgd2VyZSBjb3VwbGUgb2YgcmVhc29ucyBJDQo+IHdhbnRlZCB0
byB0YWtlIHRoaXMgYXBwcm9hY2g6DQo+IA0KPiAxLiBXZSBjYW4ndCBqdXN0IHJlc2V0IHRoZSBj
b250cm9sbGVyIGluIG1pZHN0IG9mIGdhZGdldF9pbnRlcnJ1cHQuIFdlIG5lZWQNCj4gdG8gcHJv
Y2VzcyBpdCBjb21wbGV0ZWx5IGFuZCB0aGVuIHRha2UgYWN0aW9uLg0KDQpZb3UgY2FuIGZsYWcg
dGhlIGRyaXZlciBzbyB5b3UgY2FuIGRvIHRoZSB0ZWFyZG93bi9zb2Z0LXJlc2V0IGF0IHRoZQ0K
YXBwcm9wcmlhdGUgdGltZS4NCg0KPiANCj4gMi4gVGhlIGFib3ZlIGxvZyB3YXMgc2VlbiBvbiBR
UkQgdmFyaWFudCBvZiBTTTg1NTAvU004NjUwIGVhc2lseS4gQnV0IG9uDQo+IG90aGVyIHBsYXRm
b3JtcyBvZiBzYW1lIHRhcmdldHMsIHRoZSBpc3N1ZSBjb21lcyB1cCBhdCBzb21lIG90aGVyIGlu
c3RhbmNlcw0KPiBvZiBjb2RlLCBhdCBhIHBvaW50IHdoZXJlIG5vIElSUSBpcyBydW5uaW5nLiBJ
biBzdWNoIGNhc2VzIGl0cyBub3QgcG9zc2libGUNCj4gdG8gYWNjdXJhdGVseSBmaW5kIG91dCBj
b2RlIHBvcnRpb25zIGFuZCByZXNldCB0aGUgY29udHJvbGxlci4gVGhlIHdheSBJDQo+IGNvbmZp
cm1lZCB0aGF0IGJvdGggcGxhdGZvcm1zIGFyZSBoYXZpbmcgdGhlIHNhbWUgaXNzdWUgaXM6DQo+
IA0KPiBhLiBEdXJpbmcgY2FibGUgZGlzY29ubmVjdCwgSSBhbSBub3QgcmVjZWl2aW5nIGRpc2Nv
bm5lY3QgaW50ZXJydXB0DQo+IGIuIFRoZSByZWcgZHVtcCBpcyBleGFjdGx5IHNhbWUgaW4gYm90
aCBjYXNlcyAoQk1VIGFzIHdlbGwpDQo+IA0KPiBTbyBJIGZlbHQgaXQgd2FzIGJldHRlciB0byBm
aXggaXQgZHVyaW5nIGNhYmxlIGRpc2Nvbm5lY3QgYmVjYXVzZSBldmVuIGlmIHdlDQo+IHJlbW92
ZSBjYWJsZSwgd2UgYXJlIHN0aWxsIGluIGRldmljZSBtb2RlIG9ubHkgYW5kIGluIHRoaXMgY2Fz
ZSB3ZSBjYW4NCj4gdW5ibG9jayBzdXNwZW5kIGFuZCBhbHNvIGJyaW5nIGJhY2sgY29udHJvbGxl
ciB0byBhIGtub3duIHN0YXRlLg0KPiANCj4gTGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cyBvbiB0
aGUgYWJvdmUuDQo+IA0KDQpUaGlzIGlzc3VlIGhhcHBlbnMgb3V0c2lkZSBvZiBkaXNjb25uZWN0
IHJpZ2h0PyBEaWQgeW91IGFjY291bnQgZm9yIHBvcnQNCnJlc2V0Pw0KDQpUaGUgc3ltcHRvbSBz
aG91bGQgYmUgdGhlIHNhbWUuIEF0IHNvbWUgcG9pbnQsIGEgY29tbWFuZCB3aWxsIGJlIGlzc3Vl
ZC4NCklmIGEgY29tbWFuZCB0aW1lZCBvdXQsIHRoZW4gc29tZXRoaW5nIGlzIHJlYWxseSB3cm9u
ZyAoZXNwZWNpYWxseSBFbmQNClRyYW5zZmVyIGNvbW1hbmQpLiBXZSBjYW4gYXR0ZW1wdCB0byBy
ZWNvdmVyIGJhc2Ugb24gdGhpcyBzeW1wdG9tIHRoZW4uDQoNCkFuZCB5b3UgZG9uJ3QgbmVlZCB0
byBwb2xsIGZvciB0aW1lb3V0IGZvciB0aGlzIHNwZWNpZmljIHR5cGUgb2YgZXJyb3IuDQpKdXN0
IHJlYWQgc29tZSBrbm93biByZWdpc3RlciBsaWtlIEdTTlBTSUQgdG8gc2VlIGlmIGl0J3MgaW52
YWxpZC4NCg0KQlIsDQpUaGluaA==
