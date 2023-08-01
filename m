Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5253C76A60A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjHABHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjHABHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:07:02 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FA92134;
        Mon, 31 Jul 2023 18:06:37 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VJppEk024101;
        Mon, 31 Jul 2023 18:06:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=M4v+OF2vqceBwF/fM/m/NtAy+kvzfb/MhAQOM56FTrY=;
 b=cn5MqWE1ZB12O5ZU7xTbiODjXSbzH1Aa/OIOuGCYdwbqL4EaYl3hZ8fCc4zOxcpL0DqH
 vSHoyK7DR4w+P0uuPFRuQTlqjWQg1N6g+EYvYoj+wuwCyP6ds4S7GNGJMRtY5HGo5TI2
 s8jmlTMcGicm7Y+06jcgNXH5lLqqVsuuCusb891GOJLbFExuVbdPaapnq1dRhPrN3xGJ
 UdfKeCUPxPK0kB8c1QeCYs9XkUf5BL2Vn1s6vkR4DWuBdsnuw61Rj3TXeWDUFHQQEyZK
 IcOCkUM36nPA6m77mOr21KQBE5Yi1jbTu/Orj+M0WIjeQx1lzx4OEvXlesN5PSl8f63W xw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3s51pssxf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 18:06:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1690851979; bh=M4v+OF2vqceBwF/fM/m/NtAy+kvzfb/MhAQOM56FTrY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=a55mqtgrX3MCTf850ZtGNB7yYyyd4QYIYOlxFborTXSti6eKxPL9DevhKNEkfyD0h
         O741jsN7TYhuA1NGU9C/I4YCH10U+Xx1q6J8FdWo/YUNThqpFVQCeQxrWPox4PF450
         pgOr22Q+eg58ehV+0uhwWPqUvgM/jZSOxqIvMHqFNx17BNXZZYNW7MI+bRhj0YWS8M
         60haMnISLZKiXVauc9jM1ovv7PWw+2XdXKUiMH8NkFwf1+tQz7jyYxbhwpm3TVK8G0
         blbPpmiU5AQf/x+AjvauRcWDeiWqtvLHGqJqkbw35jaN+KY4C5tHKdOI/xG2vOhy1G
         fWj9z/1zObpQA==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9E20440145;
        Tue,  1 Aug 2023 01:06:18 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 547C4A008A;
        Tue,  1 Aug 2023 01:06:17 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=aeM6jbJj;
        dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E27824059E;
        Tue,  1 Aug 2023 01:06:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxDPVgREFDqC43d5XCQ98fOObl1ALaJb1MT7bW6ldkxWlf+rQEdSdqR3fUBbYCN1qnTxf0e4FInvfvVMo3z7bWtK4qlkLsJOOzpr69F6AWk1J/Imj373WYMsZhpiTUqxz7wbckmDgQpphecB3wmi5+/vcZ0F8CITuxmnNnZPIYoJ8HdEwijqw6IIYI9hr6pUI1NF3+xc9RYZC88mtIKiBq/OnJo9LHW/JyKXLctmzk5wriSFP36EOXbAc8t6i+klBHJZ3uxLmZq+lyfGKxsWVla2M08djm20SpT2VExknNIAp1iK59DO+sdhp/sKk8OMYKoG7WdMPQxtR/IvwLt6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4v+OF2vqceBwF/fM/m/NtAy+kvzfb/MhAQOM56FTrY=;
 b=Q60UCxpoVPT6wgwxA6or9Gyx1x2zuZ9gjIBgJFO8BfJxG4+VNs1IpNBemkPNi/pIQiAtJfR5UKoWbHuFtuoP0SLhJrM+dADayKEDwoAzUbOdc9vZxXPleRPmDTr856ZplQtI31D8TqScw6QVABcM2dCuYrzQg6Yfzw+iZJBWGIwHRv/DGUYpd3jql3Nl2M2vF3S/aSZchfpCAs7GSvgsWTPLNbYG2JFby9boy7L75bxbOew2bb5OZqVJ+wTSfHpZVrE53hlpmoz3hd6rZS5ZVh2gjWUmDEQz90baPB9TNvs+XNOTjwcrbx3romOGoKHzid5+ywJnUaGjEPFfhCQviw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4v+OF2vqceBwF/fM/m/NtAy+kvzfb/MhAQOM56FTrY=;
 b=aeM6jbJjeW7XJGeTOY3xfYZtEBUC0NhvS2Xz3EQppoBP6nbZSw/RZnBhAl8+ULHeIb0nXIpwh7eo2KEJares/+s41ZLF91jF8LIaIE5J/Ehpz4hS/UCaIOWX44wGl0fJZ0DkgfH1d1kr5Yh0DeXr00Zc+T1w9y1xBGQ2aqI7kZA=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MW4PR12MB6683.namprd12.prod.outlook.com (2603:10b6:303:1e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Tue, 1 Aug
 2023 01:06:13 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::138d:ed63:a424:1f33]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::138d:ed63:a424:1f33%5]) with mapi id 15.20.6631.042; Tue, 1 Aug 2023
 01:06:12 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Surong Pang <surong.pang@unisoc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Orson.Zhai@unisoc.com" <Orson.Zhai@unisoc.com>,
        "Chunyan.Zhang@unisoc.com" <Chunyan.Zhang@unisoc.com>,
        "Zhiyong.liu@unisoc.com" <Zhiyong.liu@unisoc.com>,
        "Surong.Pang@gmail.com" <Surong.Pang@gmail.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Let pm runtime get/put paired
Thread-Topic: [PATCH] usb: dwc3: gadget: Let pm runtime get/put paired
Thread-Index: AQHZxBMrDgFKKyjowEKIIEWWt6cMAq/UoJKA
Date:   Tue, 1 Aug 2023 01:06:12 +0000
Message-ID: <20230801010611.33srb4fymisx6wch@synopsys.com>
References: <20230801005651.29863-1-surong.pang@unisoc.com>
In-Reply-To: <20230801005651.29863-1-surong.pang@unisoc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MW4PR12MB6683:EE_
x-ms-office365-filtering-correlation-id: 968c4a56-b808-497a-20d1-08db922b7fb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5DetXM2gZlcJx/SeLGMpkZiVCr3HhIk1SQEOyYJsKv/Lzt9dGG3Slq/fpjiZl/Z9x+CK6SNhToyIzlCoxTm7yq0ce1UY1tKS8en0B8LT+GghuLaVmDI+zWx9XLFYunYWqER0wiP7aTDNZfVRjK0yMbkMAJwv+477tR43gWwaoC3U7QhzhrTWjxlfYE6HbwXn99UGLdGZq6fyptr+y3hdlFz9YjtdJeNHG2ivldgWZX4eiaMuQfj9uTgn1KPeemIBNjA61oCSxMyfgw3iv64c8bS5yPTTzVoF+JsqRr0DBMHfSssil7Z78/NvylEnm6DCPuDt4HADvWc6FLOQ9yzV2YngJNo1f4dXCNOVr3DUgQRPvnp5/7LSSgNwTrj3uPhAzFQJuLiKJYNOfJW7Pwg5xqOpOl7lzZid+UopRvaiq4/QDY5QA3tS/rtU78Ipxcxy6e2QyJWz08PHRg5CC1EcbL4qUHtOBO6eRpdwPmJ1FuuaeSyyZO/ISOkwMzbp9XjZwqDVU5PnjnYCDPdkm1YlCLT0IHQFKaIRyyPT/NjBTIZhamME66R2ofRgHrj4eAvjTJsBYOCSClNSo/RHjYtbCxW6gMaQPBR0xX7XaQmnbOWntKL8XOK3Hn6W6AVXw2c/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199021)(5660300002)(2616005)(186003)(8936002)(1076003)(8676002)(6506007)(4326008)(26005)(316002)(478600001)(76116006)(66446008)(54906003)(66476007)(66556008)(66946007)(6916009)(64756008)(86362001)(6486002)(41300700001)(6512007)(71200400001)(38070700005)(4744005)(36756003)(2906002)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVhkMFdUczdPUWF6dFdRSS9PcFoydTNzRnBjNk16d0xvS1ZYamhhSXloSW1h?=
 =?utf-8?B?eG9EU0xJYmUrMXp2NkRuWUxOZEFwbWFXcnZJQ0k1SWVEYXVOYUJDeWdOYlYv?=
 =?utf-8?B?ZFByOUlWU1VYcHhucHRPcTIza3JmYTN6NEdoM285SmlUbVhUMmVBTE55Ni9T?=
 =?utf-8?B?QTZuNllpYWVZMDNGbFltL01PN3ZQVU1EeFFqQVZpWVV2WitMT3dnS0w4U3pW?=
 =?utf-8?B?S3Eybng5Um00Wm9qc2drYVhLS3ZTU2FQQ056VzlWWnp0NXB3aXlsbzhzalVs?=
 =?utf-8?B?MElRK2s3Ymw5UU8zNXA2VkRTUTd4TXphR3ptM0lPYjhXVGFybjEyUERMTlM1?=
 =?utf-8?B?ZTNvUDhmOFZSd0VtVHh1anZmRndFWHVQaGpZd0ZFV0Z1OFdINzVzMW0zM2xO?=
 =?utf-8?B?WS9EQ2dBYzNRNHdiRXdUWkZQOUIyUlN1RmF2aXJFbEhiL0tUYktGYWZpczNT?=
 =?utf-8?B?dlV2RC9mOFlEU3gydWtMNmFxSVdaelhvV3IySEZHMG16a0REQWNYWmlZalVN?=
 =?utf-8?B?WS9yVXNsUHVSeUVOSWNHNDRnYTBwZXMydUNITHNoODY4OWtmY205elpia0Yy?=
 =?utf-8?B?eWYrV2JtT0JBY3VrZXlMQW5jQXJrYXZaelV6Q010a1ZvMk5oTFkxdnZ3akMz?=
 =?utf-8?B?UXllSHFtSEtUdWV5UzdsdEd4RzV2TS9WT0VuaU9Sai9vUWZFQzZpQTJ4aDlG?=
 =?utf-8?B?WHg1cUU2MmRIdDlUeEFJQXFURUNUZFNQd0hIRFZEQkp1aUNZY0tiSitYNlhp?=
 =?utf-8?B?dmlCUHBvSFVTRS9CVUcvU204eWN2NTBtbERUL3VkU09tQXFJbzVqVjIrVFVj?=
 =?utf-8?B?Z3dYd3lVTGV5M1EzTUdPUFJRdGZSZ2FaSVpKNklwMXZTRUU5eUhBZm5oR3R3?=
 =?utf-8?B?aFZpektpZTQ3ZXkvY2VKR2FEYVdrRFBKWHVOUTF1c2xOQ09vOHM5eEFKRDl2?=
 =?utf-8?B?a2t2YUZ5NmJ6WkhLSWhLRlBqYytMdDlRdFROTytJS3p1eThKYmltOGRaWUZW?=
 =?utf-8?B?RWlxNXgvOGprcTMzQ1NTeHcxNjlGT1IrT0k4SVdvdSs1akNraEhrUXdMU1Y5?=
 =?utf-8?B?cHJRcXBWU2tURmlVcCtvYVM0N2lCM3JXcXBRT0M5WGl1MndEMlAyR3pQZFBw?=
 =?utf-8?B?R1JaWmhPUzdZYmR2cmtWeFVkUkxzby95d2ZsdzlUY1ZFSzMyWTFVSkhkZnFZ?=
 =?utf-8?B?Y2RNUCtYR09uVVB2c1luU1R5bGFaQzNzWGkrSzBrR01iOGl0ci9uYm55LzNR?=
 =?utf-8?B?aHorRDdyNG0rU1hPY21vMjNWYy9rRmFvdE9sdWJrQjNtNzdmU1VhTWlSTFJ0?=
 =?utf-8?B?V2cwMXVRYy9raVlkM3ZJZXNFOGhtTkg2SERweDgzc0NCTGhyMjdvN1dwSWs4?=
 =?utf-8?B?bzJMKzNjWE5SV3dxaUlnaUltTDd2dGdZY3kvdTJWZEllTEY1bzVjdmRaMmtP?=
 =?utf-8?B?MmlpaW9XRms4am9hUmhOV2gwSVkvdmNBZGIzaVRYRmsyVEVMOThjdWoyK0xh?=
 =?utf-8?B?b3RkWEtCL1RyajJoNjlQWWNlZHRsN3grbUVJR3A0RXMyTVFLYVdjU28wL2Jw?=
 =?utf-8?B?Yzg5eThMM0VRNEJmcnZjNmcva0xVZlM1Ym5qUktSU2tjaUVpdXNKYmM3VmZO?=
 =?utf-8?B?Qld2bUg4YzBmRlN4MVRVOGNBbGh1SElxTXZINHNEYngySXFVRnNsaTFFU0F0?=
 =?utf-8?B?bGg5c1dPa2E3dmlrb2ZSYnBFWU04TWQ5SURPcG84VjV0eldrdkdjUllPdVJt?=
 =?utf-8?B?Y2tJUU9ZUjdBUUtkZXFGMlI3TCtnYlhsNHUreWpCRkJ4TXIxcnVESDg3czAw?=
 =?utf-8?B?alROM1RxSlhqTnZGbHU1VUJLM3JUMUxWS1VJd0FzR3MyNlFDWXppNFJYcnJR?=
 =?utf-8?B?bWVUZmNHUTYzYWtEN29WMEEwSWpobkFTWU56ZWM3bXdldkloMWJ5djFHYzV0?=
 =?utf-8?B?V1Q2QzhmM3JMVUt1N3g3UFpDdVVwUXNoR3MrK1pQeWUyYldrbjZqZEwvVzVC?=
 =?utf-8?B?NytxV3NtOUtwNkV4ekpqaFBGc2V5dW9iQjZTZkdOOEx3TEFRVjUyMjZNeE1l?=
 =?utf-8?B?c3JWSzdQVG5mRkhJWUZlSk9UN2E4WGdLakRRQkZ4MWY4Y2xwT1VDaXhieGdr?=
 =?utf-8?B?TWZoM2RYZVdEOTBzRkxmMGlXMXRnOGxsQktCdWpRcGhoR2JtSFdJWUVOZHpv?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F637DF5DE56CBA48890676B6BBDC5E85@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WVNmNEZHT1FDaUFmVXlHZy9CLzJKVWI1cFU5VEVQcEd4SFdnQmhiTDZ4OFVZ?=
 =?utf-8?B?bllrQXRSNCtoRUtabEVpWFdPVTZZVGEzMm1KZWRISXB1YTBPZ0kxMnp2d2NZ?=
 =?utf-8?B?L21oUml5NUZqOGZ4dldnTitwdVVYMXBVNVdEUDAvVXd6ekx3V2RTWVJpQmRV?=
 =?utf-8?B?d25FLzlpclY2SWNDZ3VuVE9rN2RuM1REN3JTbzJubWNIOXNTUFY3T2RNNVds?=
 =?utf-8?B?dEVZL3dCYnBpTk1EUDN0N2N0VS9GQndCaE1hNWdhNHBQb1ZKL3Q3NTdIc1Jh?=
 =?utf-8?B?Ky85RWhWaVdmNmZoZFMwUno3MVU5SVFta1dVdVNuRVFNZXdXRFNCZzJlNHlX?=
 =?utf-8?B?Nmk0WnJBU2xSZ3VUZWNpYk5EdVNnMG9BTWduZXo4SytCamVhcEh1S05YeVps?=
 =?utf-8?B?ZVhtNmN2NEpYNjZPakVMN0tNUU1qYmlYRlh2cTNHMlE2TllJQ1dlVzBjcGQ4?=
 =?utf-8?B?WTlEaVQyTURRSnUzRUc1a0E0YnZPUnJMMG1MdVhidHNWM3U2d2JRMlV4QUNa?=
 =?utf-8?B?bjJ5YlJzWVV0WmNIZDJUWG93eTVOZjEwS0g2bnpobmU4NXM5L3NIMkw0K0g1?=
 =?utf-8?B?d2pWVmQrRFkwWGVNd2UrNHdpTG1ha2xPcXdUUXd0V3hQa01xMHJyZ1dOcncw?=
 =?utf-8?B?cXFTQ295OHFaYUlrSnRQT3Rvd2VpdVExa2VPNjFPMEJpUURxTGRuZ1c2aGUr?=
 =?utf-8?B?VnJTVTVJNEpqOE1FcmRRb0ZFbnU3THpITElwUHUwMk8zU3hEU052WTN0Ny9Q?=
 =?utf-8?B?Rk9CUUx3MVFLZTVRTzNFZFJId1E4SVFCRnBrei9UVDVzNktNTUZyQ0Nsckp1?=
 =?utf-8?B?RmVad3lxVTEybGlDWTI0Z3lVRXpuVHlPWlZqTklqcDdUaWRLSkNkM0Vjalhu?=
 =?utf-8?B?TnlQdys3cno3RGt6S0NOY3Y5aGNiSjhoV0doV25leGt1cXhDN08vdENOeFpq?=
 =?utf-8?B?ai9YTlEvNHlpbUVoSFVCeUJCeWVEMkh0SXZ5YWlhbzdKNzVXYTFDQ1czdUFk?=
 =?utf-8?B?RFR1YUZUWGhFelIzTW5ibVVOQWFaeG8zeGdueW5XSVY1NGZ0QmNNd0dSbHdu?=
 =?utf-8?B?ZUV1ZkZUYjUrdjVKVVdXMDJwMERiNzM3aFhjSlVZbnNFL3E1SmNtc3ptWDll?=
 =?utf-8?B?dUk3Q1pLbHpLS3kwU3IyQTZGR1E2aFV5MWErRnVKQ1c1R05FaFd0Yys1SGkw?=
 =?utf-8?B?SGtodFVNYisvbVFOWk9UekZWVWpNTk4zUlRHVC90cmdLWDc1WUlKMEt2Tkh2?=
 =?utf-8?B?SHBqa3NOY2dtQXFEeWtObngzWlEyZzFiZGRieWtGREgvYTl0Zz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968c4a56-b808-497a-20d1-08db922b7fb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 01:06:12.6278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pt3JNMXq3vK/rr94mGkqALfUAgOALcKbPUiJlNnbekfTULmqGNdKnJzpEGHlVY323b5QbWtixgTCGKYgwsQb/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6683
X-Proofpoint-ORIG-GUID: xVNhiMXFCa5PVyIsBDyyet00VsiOJUTy
X-Proofpoint-GUID: xVNhiMXFCa5PVyIsBDyyet00VsiOJUTy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_18,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=848 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308010008
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBdWcgMDEsIDIwMjMsIFN1cm9uZyBQYW5nIHdyb3RlOg0KPiBQbV9ydW50aW1lX2dl
dCBpcyBjYWxsZWQgd2hlbiBzZXR0aW5nIHBlbmRpbmdfZXZlbnRzIHRvIHRydWUuDQo+IFBtX3J1
bnRpbWVfcHV0IGlzIG5lZWRlZCBmb3IgcGFpcmluZyB3aXRoIHBtX3J1bnRpbWVfZ2V0Lg0KPiAN
Cj4gRml4ZXM6IGZjOGJiOTFiYzgzZSAoInVzYjogZHdjMzogaW1wbGVtZW50IHJ1bnRpbWUgUE0i
KQ0KPiBTaWduZWQtb2ZmLWJ5OiBTdXJvbmcgUGFuZyA8c3Vyb25nLnBhbmdAdW5pc29jLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgMSArDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCA1ZmQwNjcxNTFm
YmYuLjljODM1YzVmOTkyOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
Yw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC00NzIwLDUgKzQ3MjAs
NiBAQCB2b2lkIGR3YzNfZ2FkZ2V0X3Byb2Nlc3NfcGVuZGluZ19ldmVudHMoc3RydWN0IGR3YzMg
KmR3YykNCj4gIAkJZHdjM19pbnRlcnJ1cHQoZHdjLT5pcnFfZ2FkZ2V0LCBkd2MtPmV2X2J1Zik7
DQo+ICAJCWR3Yy0+cGVuZGluZ19ldmVudHMgPSBmYWxzZTsNCj4gIAkJZW5hYmxlX2lycShkd2Mt
PmlycV9nYWRnZXQpOw0KPiArCQlwbV9ydW50aW1lX3B1dChkd2MtPmRldik7DQo+ICAJfQ0KPiAg
fQ0KPiAtLSANCj4gMi4xNy4xDQo+IA0KDQpZb3UgbmVlZCB0byBwcm9wZXJseSBpbmNyZW1lbnQg
dGhlIHBhdGNoIHZlcnNpb24gZXZlcnkgbmV3IHN1Ym1pc3Npb24NCmFuZCBub3RlIHdoYXQgYXJl
IHRoZSBuZXcgY2hhbmdlcy4gT3RoZXJ3aXNlIEdyZWcgd29uJ3Qga25vdyB3aGljaCBwYXRjaA0K
dG8gcGljayB1cC4gUGxlYXNlIHJlc3VibWl0IGF0IGxlYXN0IHYyIHdpdGggbm90ZSBvZiB0aGUg
Y2hhbmdlcy4NCg0KVGhhbmtzLA0KVGhpbmg=
