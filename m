Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5407C75B3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441868AbjJLSLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344076AbjJLSLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:11:18 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF93A9;
        Thu, 12 Oct 2023 11:11:15 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CHTEBq002432;
        Thu, 12 Oct 2023 11:11:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=hZDIsPzfxhPCOSDUbiukLLRnMBm0M5Ri+mj31+b+TXU=;
 b=DoJj7zMVpKrrSEkFRzJFct2xTxGZJRhW62LBzt1nTkYkp1WsccXE+7FKe12NWJOAqvcf
 1ItsNDfeNCxE7gZj04DNBDLr4B6/g0Pg8NTGAY8M8raH9bmp9RACb792HfrPbToxqeMz
 y/fhCQXhJ3nNFc8NQCMrT2UIK4GIdLmiGNFH3DAp/8/wA2HTzPK3d38UPA+7U/V4mJ78
 awGT9/eLGUeq/m8tLkM2atICDefcawRPR52rZb7PVS2k8sxB/9eHC5fokm8IZaNMJ0Tt
 iR33Xm76jAd71Q9n6iYPnNTKb0FODqQSzC5FS1DpQ5zgR26u4z5C5Mqi7pPbiSsGQq8l 1Q== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3tkh4j2sre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 11:10:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1697134258; bh=hZDIsPzfxhPCOSDUbiukLLRnMBm0M5Ri+mj31+b+TXU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=MIKL9p0hQ2aF/QMczLM0ATYZzGvrgdbN4yfz0sw+rOB0mxUmFMdFO/iqYLtS3OtP/
         UW+txrTjGKFJBrqZBqGrCciVixch3dTa4PsZpZYK+cli/eznoIsL1KEmE1hzohsogj
         5Hg5XQhcpAC9Vd39YUhcaBKOkg73xcoAmNyDawfOp+cNOP6mXGfv1sCk3lb+kHW865
         1lBo2cN4Gk6Kg+WoKQamvUUeYmTY8aMYsfRmJaW1V7uYtY/g/hKZTPVRpfWlUBfRWd
         keBS8JeAg+4N2HrhNQzAuoLBvUt990vM9rUDZ56gsOxCYIKDPWv04tmd+84cldJNvd
         agsnHIV/N7OmQ==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B5B4E4012B;
        Thu, 12 Oct 2023 18:10:56 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1B3B8A0081;
        Thu, 12 Oct 2023 18:10:53 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Zcr0VgsS;
        dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 38BA24013C;
        Thu, 12 Oct 2023 18:10:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8HbXMg5jUOJ6BjUkzvVeSAUCd2L6cT8yrtQd8dj14LvYNB2BAI5BHr+Rd738lkgXQBf2tnAjUt2rUJAAloUuTMujVRxYW+d0AZbaPnnIRIwydkaf3/IfvaABm5AcDO2989jYj/bAony5tDSAavpykPKmQGWv44YzG9vcrxfy26QGnvuJ7EjLenWqRTVEyuyw0mzpLo9vjRS3yGceq+ByfXxwcNsHJwAHXA7Lk89GNWUlqrRd+f8UVYM36S4eEFE0cDNyR0+GAgfEpIJGDQpgFkKjOOiU1PqsPmcao1/cUhW6PVieUQIQbO+0WQ+9ULLDj8uH/2KJjJnAqqhgpocYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZDIsPzfxhPCOSDUbiukLLRnMBm0M5Ri+mj31+b+TXU=;
 b=R+hFLDM2lFE1mKjye5lyH5DH2VEL7zhwazrmiIBu80i2urM3dJJR+H+7p/TgiK4KiexMSdZbOtU4w3Ug5cSrIgX3kt2CBLeRZQMo9tYOqFFnwEoHIIxTjfES45xx4MrE6sDeRAENqyhkBivMlLDi4dYDojTKj8Tp7vOR+MCePYjmd3CnCPbpza7w/k0t1gxfPDL3hRtqaa0XPVPfS/kdDjZxYqyPtHka6xwDmBUBRxMrR6HV6orltgunktZ55XmnrCvGyQwNBiJJkOPRSk6A6oErUNSqDY3aP0u9QYFdnuL9Vkt70/xCZznVpcRMoajrGo3tlnNL39a0DIymRsEGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZDIsPzfxhPCOSDUbiukLLRnMBm0M5Ri+mj31+b+TXU=;
 b=Zcr0VgsSc5uEv5VQPKRItJkEGYEWvBLr0aVAD+Skzy4uCHJHyr9CAhlkhkkiiIKbzncAAulJ+Yj+8q88zC4llZLRLeoTHcvggEklkQokhFQtrjzt0I+pqV67xrNDw7AH9/GGE/iZAjPkFvq9N1tvvlE+ynmm5juzj1CHcQKpjc0=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 18:10:47 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b398:9c9e:3818:b7a2]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b398:9c9e:3818:b7a2%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 18:10:47 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
CC:     Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v3 2/3] usb: dwc3: add optional PHY interface clocks
Thread-Topic: [PATCH v3 2/3] usb: dwc3: add optional PHY interface clocks
Thread-Index: AQHZ+tURSQ/eZrHBq0yCDf8KWRJ8wrBGeR8A
Date:   Thu, 12 Oct 2023 18:10:47 +0000
Message-ID: <20231012181034.sz356qwuxb223ri2@synopsys.com>
References: <20231009172129.43568-1-sebastian.reichel@collabora.com>
 <20231009172129.43568-3-sebastian.reichel@collabora.com>
In-Reply-To: <20231009172129.43568-3-sebastian.reichel@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DS0PR12MB8341:EE_
x-ms-office365-filtering-correlation-id: 9f4a1da2-e098-41f9-eaea-08dbcb4e8f44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SpPjkArLo7N7hrHLrMA6zhLu/16ZwM1Je4xN4JFHje/JU+caV/pkGPcsy+QfWjLutINmxge8V6ICkimcYFNCLhR/vIhZmcA3ZEOxryGO+5vhrtqaoF4yYID/iA/2J9TNu5CXCsCrU7blQpVvkvbXt7lm4W2MP/2JD1MyNCT7qa1GQUtHAHj8ffwIcERxshxQAaN4BFG1HHKKE2oovq3mlrEDVIRq+ZsmF8Rv0JTcNEzconewg9LeHBmWYzoo7PfrmEtD159K65sNz6n0016sJiYgaTAO1CWr9456gtylryKTeiHpRe98PLLbfPjfsQYNpkIr3wJYA4gEYnzshXnUzEb/hOu0beMOdFACoJBTi8a0QKdcbhoCbX/Y3q/MXkgARPP1KX0lI89AW7rEQSfDJAnqB952EjaEjwGMwkW6PVSvGc0mSiVoE2sTzd8ropSvQ10dh1opAV9HzJoB6yy6XMd4+1CB30+tiVpwioB8LnW6Qf+zHruXcGwPbJh2c92YoUqSLqy+kgf/FXK6HCqFhlGKsvlLtxBgrpSYxNFmVdwMzxI+utNh0IDM5QhePCr2tECmh5yqcpsQtp4nwVoEINAL2nl2tfYSFogC+otIA1uo+qbUZqUwc0a35LPgAX8s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6486002)(5660300002)(83380400001)(2616005)(41300700001)(71200400001)(478600001)(66446008)(64756008)(54906003)(66476007)(76116006)(66556008)(36756003)(66946007)(6506007)(38070700005)(38100700002)(122000001)(86362001)(2906002)(6512007)(316002)(6916009)(7416002)(1076003)(4326008)(8676002)(8936002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTNUQ2tHVkdKQjlOQXYyYmkyMXEyQXNSVmJRSUNRZGY2UnRkVGFIOEh1Vlhl?=
 =?utf-8?B?cGhEaHBvM3Bzd1pGTC85VTdPMHY0ZW5wbnNBUGNDYk0rdStCRnNJajlWUVRl?=
 =?utf-8?B?aUVuTHdDeDZqWGRDVnEyNTNHallyTnM3M3hTcHRJYkJOTjBjTWNORVJ4akRx?=
 =?utf-8?B?OWdmb0Z1YTRuRjF3T2Z4Z2hZZFl3dXhSYkNsVkFtSmpTNEdBbEVSWVRGWk5R?=
 =?utf-8?B?V0FnWnhtemplMUJ5d1Y3S1QwL0o0V1p3TTluSFBPdjdUaGxLR2VWL2pyb1ZG?=
 =?utf-8?B?alAzKzdBUnJacWF1WnZ0L3RDQU9FNTcxblRZcGh6U1UzRVB2Zm1LQjVsSndD?=
 =?utf-8?B?ZFM1REZLZVpFelR6ZVRnRkZLdldNdS94Y3AwcmxOS1J0cGNCYXM2dXplWGxu?=
 =?utf-8?B?aWtrTzdJZnI1d0drMUNWUEsva1R6VzZLUE9WOS8ySndGZWRLQ3NSbitMa1pw?=
 =?utf-8?B?bW9nOGtBK0lNb2FNV3lWNW1meHppcnY0VEtwZWMvaDVsRFkrQy9lemF0MTR5?=
 =?utf-8?B?ODB1MXYrbUtqRVBGMjNWZXFzTUF2QXoxZGxLVWtKNjhsLy9KWVU1cTFPcGlX?=
 =?utf-8?B?bkc1YnZyWkVLbVE2RHVCYVc2ZndaLzl6WktoeTZDdkVWMGRZWWN1RHJ1V3lM?=
 =?utf-8?B?cGpaOEdzWndvN1g2UmxZVGIxaUR1bVZMb2RmUjFMZndWem5PN01LTlF6Ukwz?=
 =?utf-8?B?bjdRUThOWWVRRDlST3Z6ZWk2M09ibnNvYyt5NmFUR2JHdHpKU2ZQcER3dDNO?=
 =?utf-8?B?akgzaktrSTJGbllCZ3k1RDBpSHdJYUdUSitiR0NNdTROdlJjSlVzOUcrcHFz?=
 =?utf-8?B?VkxEdk1hQ1FoZE43MStTY09wRk5SOXkyV25GTFdrUnhqN25PbDZrZXpnZGk0?=
 =?utf-8?B?M2pRY01vRzRZS3IxTitvajBEcG5UZ2V3dE44S3NEUEl0OTRKMllBeU5YWFlo?=
 =?utf-8?B?VmFYeTQva2V0L2Fub3p0eVRWTWpCU3lEK1dZWUtmZkIwVG9IY0tTU0NtOTFy?=
 =?utf-8?B?d2YzRlJEd3BLV28zK2Y5YlVtU09TQlVmQ0laYjhld1BHcXlqWnFSU0c3TmR2?=
 =?utf-8?B?NitRM0hGUWZ2cy85VWgzRzBJcGhvQ2dHcW9JYVFNQ1BlK2lHVmxEZHR2dkt6?=
 =?utf-8?B?YkVsNlY1TXdIdFhWdzYxdHZwTVZTdHhuaWx1L3Q1U2xCVFFkbFF5K2J6bWpj?=
 =?utf-8?B?VTBvTm5HNmJOVG1NMFl6YjF4QS9OWXMzQU4zQXF4SUpZZExlL2RHVnVJSTRW?=
 =?utf-8?B?alpDRUxBZ3l1STNmNUdzMHRZT2c2UnZhYmNVNVBVR0VrZ3hTZ1BoK2QzMFJx?=
 =?utf-8?B?bUhsckR1aWxPUFVHY1M5Q3NmZ01PRWtFNnB0ZTZxSmx5elVNOVV6cEl5UnVG?=
 =?utf-8?B?NG5Rb2VjNEZmRjIza29JbmMvWng4MXlGSCtQWStsRnB6aDZCZDN2SjBoUkNB?=
 =?utf-8?B?VGNtQ0crQkFpQWVpMERjbGpvbVZVNnlhYWpLWGVNRDZoWE55SjFsdndmRmx0?=
 =?utf-8?B?OWdidERNbXp6SHhueHZ6dGRWTXR1MzYzRk8vbTNYZHZVQjRXWkZ1L0I3UlZl?=
 =?utf-8?B?Uy8rUHdEVitxR2pWdE0vRFpya2h2QXRaYS9wQ0ppcGpqL2NOOU9wU04yc0JG?=
 =?utf-8?B?c1IzZW5CemRQT0o3bTZrTmlqUHFuRWpUbXJPUXhaQmVYUzFNQ3lUTDdyWklS?=
 =?utf-8?B?SFNCcjZWTndQcE5mTjlWTno1bjUvSytNMWU1b3ZhUFVQNVBYR0JLWWFLdDFi?=
 =?utf-8?B?TEM0ZlZSS3hlMnpoRThKNkNFRWZYZWx3cVpRYXdhT290aVZHd244MmpYWFgx?=
 =?utf-8?B?czJlMkJMMFFSWEt2RWhEd2FkdTYxOGo4MzhIQnpFSUxtdWlpZkJpWGd4d1VZ?=
 =?utf-8?B?OCtPVVk3M2NSdDhvU3orbEZzUGNkbmVLa2dYRUUxSlljc245M3lCU1ZLRjU2?=
 =?utf-8?B?clJZcERKV1ZkeTZ5K0RIOVlScVZ1alk3WGRrUWNZZjM3elREYlIyMVF5K1Y0?=
 =?utf-8?B?QmJIOXNBdlBvQ2U5dU1Hb2wyb3NjMndiZnNTM29oREZqU3hxVkdMU0I5elVh?=
 =?utf-8?B?K0ZzQzJpV2RoazVEWFJhL0lEWWcxcG5sZGZ5NDd2MmsvRVlyb3liSU85Y1JG?=
 =?utf-8?B?OFB6cXRIY0FKaGlGYlpDUkthSnUwZ01lVHhBR0NIZGVqRERvK1M2WFYzY2V4?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4861A63555C82D4A9E86D77FC495F072@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UjVpOWcvTVVzRlRDbXQ2RkoxYWNaTmtWakJhWGFKT2FPUXdlNTZFd2JPMWU0?=
 =?utf-8?B?OVNqSWRlMFhLZjQrRmdyZ0VkaXBncmlxeE9OdU13SEUyQlIyUndhd2haRGVt?=
 =?utf-8?B?THpWZmlFUG1HdWttTjBwOExTVDdFUUdHVi9GaTVmRGdIYzRYV0tkTVQ2blNX?=
 =?utf-8?B?d1lnWEZWbFMvYlErVTc2V0NyTVVoVHIvL1lOTE82SlBjRndOYjR6ZzhUVEdz?=
 =?utf-8?B?ZDZ4bWkwWkRnU25yUEIycFRXMXhEMjI1WlhZSGFZQkxhK1plcDkvcUxxNVov?=
 =?utf-8?B?d1VBYUF2UUZVaThUbkxMcGlyT3BzMGlKbldkSDJnditDc3phZEJlT1FPU2Ja?=
 =?utf-8?B?c3dnYmFtY1ZhN1pIWUcxaUFVNWJxSGRDNnVJUUhkY29YT3NDZ09wWEJ5eUZW?=
 =?utf-8?B?MjUxNmZ4VGRYM0ptSnNHekNwdC9oa29xaGJnRndqNFFSVG9wdDNyZ3VXdFpJ?=
 =?utf-8?B?YWs0Tzh3dTVMVTg2dHdROFNqM1NxdzZmSmJOTjhnV2tQdzN2ZytURGdGOU5N?=
 =?utf-8?B?SVlxWFZqcGUvd0o0SkxSVGVOdkZpYU9Qci9ybWdvMCtXclhpNCtWV0gyelpS?=
 =?utf-8?B?VEtPWWR5UVhRSW42ajRqVUxSbUxmYUhlc2dBdXhnQTF5dk5EQmdIZ3o0aldF?=
 =?utf-8?B?YysybEYxMDF1K3BCS29RRHdiNUZCR2k1SzBIelZJTnB1QjcycHRlWXQ2YVRJ?=
 =?utf-8?B?SnhDMlpOd0FBYlFLeUd6ZndURkxoODFVVHhuQUs5Y2JQVHpGdG5hUlJmaDhw?=
 =?utf-8?B?RFRVQ2xVU2syZTFHTkRwbUhGblJCblJxVGljN2QyR2RCVUpIMzFhcmJQRzhi?=
 =?utf-8?B?RHdaWHNIQjNwSTEwOHNZWURyY0dzR0V1bnZuOWlKdHFMN3h6M0hOWUlIR09x?=
 =?utf-8?B?ZTk0dzluMkdxK1JlMWNncWVCbDVWcnRicHVtcHIycjR3SGtLVnQxSTBhY1RH?=
 =?utf-8?B?V3lPMUo2a2ZrazhHbW9KM2dScjRPWGtsRExuZ3UwZkk1WFZ1V0FlTlIxRGwy?=
 =?utf-8?B?TE5Xa0VhUHh1dzJUc2h0OXpESlNIemJudFhDckRvR0hDems5czdxa2xnc3Nr?=
 =?utf-8?B?R0phVXh3UXdLNFBlUk9wU2IxOFY5NjJTZHByQnVIbHZuZGRYb1hhRlVzNHZw?=
 =?utf-8?B?UTVWT1lMZmJBcWd6cWIwVGgvMWtMcjh3VDFNVHk4MnNyVzQrRW9taGJmcDJO?=
 =?utf-8?B?MXlPSWZyeGpMRDVtbTE1aldzQWxlZ2EzblQ1SnhNdXg1Q2c2YUpkTmdTVFZh?=
 =?utf-8?B?cVBMYkE4MVI2c3A0MWZVbVVBdzF3bS9TaUx2ZDIxSklQWm03RVdjK2k5ZzAx?=
 =?utf-8?B?WEg4c2E4VXBaQUJmMy8zSzBDay9PQWc4Mzk4S3NzNm9JRTJicm5QTUFQOUtz?=
 =?utf-8?Q?E6Qzroap+fyIeCshPHWw0c6HUuLXjWn4=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4a1da2-e098-41f9-eaea-08dbcb4e8f44
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 18:10:47.4276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hbxdzkFpRANutB3PY/0ykgBBgiAjmYLa9nZBMYKKM90vRZhJJoGxLTynQxfYUXqjLS5bMi8M3Gkwb/QfD0v5lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341
X-Proofpoint-GUID: P-2dam2IQ1U1-AHJVKGso39qxb1PW2Ii
X-Proofpoint-ORIG-GUID: P-2dam2IQ1U1-AHJVKGso39qxb1PW2Ii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_10,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 bulkscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 mlxlogscore=714 mlxscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBPY3QgMDksIDIwMjMsIFNlYmFzdGlhbiBSZWljaGVsIHdyb3RlOg0KPiBPbiBSb2Nr
Y2hpcCBSSzM1ODggb25lIG9mIHRoZSBEV0MzIGNvcmVzIGlzIGludGVncmF0ZWQgd2VpcmRseSBh
bmQNCj4gcmVxdWlyZXMgdHdvIGV4dHJhIGNsb2NrcyB0byBiZSBlbmFibGVkLiBXaXRob3V0IHRo
ZXNlIGV4dHJhIGNsb2Nrcw0KPiBob3QtcGx1Z2dpbmcgVVNCIGRldmljZXMgaXMgYnJva2VuLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogU2ViYXN0aWFuIFJlaWNoZWwgPHNlYmFzdGlhbi5yZWljaGVs
QGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCAyNiAr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggfCAg
NCArKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5j
DQo+IGluZGV4IDljNmJmMDU0ZjE1ZC4uZmM2MGQ1ZjU2NGRkIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBA
QCAtODE3LDggKzgxNywyMCBAQCBzdGF0aWMgaW50IGR3YzNfY2xrX2VuYWJsZShzdHJ1Y3QgZHdj
MyAqZHdjKQ0KPiAgCWlmIChyZXQpDQo+ICAJCWdvdG8gZGlzYWJsZV9yZWZfY2xrOw0KPiAgDQo+
ICsJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGR3Yy0+dXRtaV9jbGspOw0KPiArCWlmIChyZXQp
DQo+ICsJCWdvdG8gZGlzYWJsZV9zdXNwX2NsazsNCj4gKw0KPiArCXJldCA9IGNsa19wcmVwYXJl
X2VuYWJsZShkd2MtPnBpcGVfY2xrKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlnb3RvIGRpc2FibGVf
dXRtaV9jbGs7DQo+ICsNCj4gIAlyZXR1cm4gMDsNCj4gIA0KPiArZGlzYWJsZV91dG1pX2NsazoN
Cj4gKwljbGtfZGlzYWJsZV91bnByZXBhcmUoZHdjLT51dG1pX2Nsayk7DQo+ICtkaXNhYmxlX3N1
c3BfY2xrOg0KPiArCWNsa19kaXNhYmxlX3VucHJlcGFyZShkd2MtPnN1c3BfY2xrKTsNCj4gIGRp
c2FibGVfcmVmX2NsazoNCj4gIAljbGtfZGlzYWJsZV91bnByZXBhcmUoZHdjLT5yZWZfY2xrKTsN
Cj4gIGRpc2FibGVfYnVzX2NsazoNCj4gQEAgLTgyOCw2ICs4NDAsOCBAQCBzdGF0aWMgaW50IGR3
YzNfY2xrX2VuYWJsZShzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBkd2Mz
X2Nsa19kaXNhYmxlKHN0cnVjdCBkd2MzICpkd2MpDQo+ICB7DQo+ICsJY2xrX2Rpc2FibGVfdW5w
cmVwYXJlKGR3Yy0+cGlwZV9jbGspOw0KPiArCWNsa19kaXNhYmxlX3VucHJlcGFyZShkd2MtPnV0
bWlfY2xrKTsNCj4gIAljbGtfZGlzYWJsZV91bnByZXBhcmUoZHdjLT5zdXNwX2Nsayk7DQo+ICAJ
Y2xrX2Rpc2FibGVfdW5wcmVwYXJlKGR3Yy0+cmVmX2Nsayk7DQo+ICAJY2xrX2Rpc2FibGVfdW5w
cmVwYXJlKGR3Yy0+YnVzX2Nsayk7DQo+IEBAIC0xNzQ4LDYgKzE3NjIsMTggQEAgc3RhdGljIGlu
dCBkd2MzX2dldF9jbG9ja3Moc3RydWN0IGR3YzMgKmR3YykNCj4gIAkJfQ0KPiAgCX0NCj4gIA0K
DQpDYW4gd2UgYWRkIGFuIGlubGluZSBjb21tZW50IGhlcmUgdG8gbm90ZSB0aGF0IHRoZXNlIGNs
b2NrcyBhcmUgUkt4eHh4DQpzcGVjaWZpY3MuDQoNClRoYW5rcywNClRoaW5oDQoNCj4gKwlkd2Mt
PnV0bWlfY2xrID0gZGV2bV9jbGtfZ2V0X29wdGlvbmFsKGRldiwgInV0bWkiKTsNCj4gKwlpZiAo
SVNfRVJSKGR3Yy0+dXRtaV9jbGspKSB7DQo+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwg
UFRSX0VSUihkd2MtPnV0bWlfY2xrKSwNCj4gKwkJCQkiY291bGQgbm90IGdldCB1dG1pIGNsb2Nr
XG4iKTsNCj4gKwl9DQo+ICsNCj4gKwlkd2MtPnBpcGVfY2xrID0gZGV2bV9jbGtfZ2V0X29wdGlv
bmFsKGRldiwgInBpcGUiKTsNCj4gKwlpZiAoSVNfRVJSKGR3Yy0+cGlwZV9jbGspKSB7DQo+ICsJ
CXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihkd2MtPnBpcGVfY2xrKSwNCj4gKwkJ
CQkiY291bGQgbm90IGdldCBwaXBlIGNsb2NrXG4iKTsNCj4gKwl9DQo+ICsNCj4gIAlyZXR1cm4g
MDsNCj4gIH0NCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCBhNjlhYzY3ZDg5ZmUuLmY1ZTZhZTZlMzk0
ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMy9jb3JlLmgNCj4gQEAgLTk5MSw2ICs5OTEsOCBAQCBzdHJ1Y3QgZHdjM19zY3Jh
dGNocGFkX2FycmF5IHsNCj4gICAqIEBidXNfY2xrOiBjbG9jayBmb3IgYWNjZXNzaW5nIHRoZSBy
ZWdpc3RlcnMNCj4gICAqIEByZWZfY2xrOiByZWZlcmVuY2UgY2xvY2sNCj4gICAqIEBzdXNwX2Ns
azogY2xvY2sgdXNlZCB3aGVuIHRoZSBTUyBwaHkgaXMgaW4gbG93IHBvd2VyIChTMykgc3RhdGUN
Cj4gKyAqIEB1dG1pX2NsazogY2xvY2sgdXNlZCBmb3IgVVNCMiBQSFkgY29tbXVuaWNhdGlvbg0K
PiArICogQHBpcGVfY2xrOiBjbG9jayB1c2VkIGZvciBVU0IzIFBIWSBjb21tdW5pY2F0aW9uDQo+
ICAgKiBAcmVzZXQ6IHJlc2V0IGNvbnRyb2wNCj4gICAqIEByZWdzOiBiYXNlIGFkZHJlc3MgZm9y
IG91ciByZWdpc3RlcnMNCj4gICAqIEByZWdzX3NpemU6IGFkZHJlc3Mgc3BhY2Ugc2l6ZQ0KPiBA
QCAtMTE1Niw2ICsxMTU4LDggQEAgc3RydWN0IGR3YzMgew0KPiAgCXN0cnVjdCBjbGsJCSpidXNf
Y2xrOw0KPiAgCXN0cnVjdCBjbGsJCSpyZWZfY2xrOw0KPiAgCXN0cnVjdCBjbGsJCSpzdXNwX2Ns
azsNCj4gKwlzdHJ1Y3QgY2xrCQkqdXRtaV9jbGs7DQo+ICsJc3RydWN0IGNsawkJKnBpcGVfY2xr
Ow0KPiAgDQo+ICAJc3RydWN0IHJlc2V0X2NvbnRyb2wJKnJlc2V0Ow0KPiAgDQo+IC0tIA0KPiAy
LjQyLjANCj4g
