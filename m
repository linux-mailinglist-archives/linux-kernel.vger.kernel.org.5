Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4F5773512
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 01:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjHGXgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 19:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjHGXgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 19:36:21 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF44172C;
        Mon,  7 Aug 2023 16:36:20 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377MTNe2014078;
        Mon, 7 Aug 2023 16:36:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=YOto2GBOtgsF6bv+5iWeLchfLLYwC0N012fu079rDco=;
 b=nQcyWOBHvyiKfkBBQCbWwHsNv/jFMZsVnpwV1Wyo9OWg/Ir+WyTi793iF9jHHAHaCKa0
 wmYg4EgR7cUec7KsENlmwYcY8hjDlkkmuSIzrrk9uM8Cv3m9H+GRf4482ACZbi13Eerg
 o+NHjWv2uqu9ZyKOy6LUuCL5Tni9HOc7lZPcm0LuKZD5QMZ0eLGLt8ecgzqIWO0GyzcN
 ODcXAsLJIBcBrVKNigp6Zvf6IbxFM+k5CZfgeVgAzaZHKrARdktUCrur5WRYmoNl7FLi
 qfhUh4fkx8ksfd7GiTX9LquZG3cIu71R0ppi5lHmg3CnihPUY4smNGLtm4UYnZVGwQ7N qQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3s9nemr7c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 16:36:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1691451371; bh=YOto2GBOtgsF6bv+5iWeLchfLLYwC0N012fu079rDco=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=bkPGlSICs1hlnM06smeHW+AyDAWIyYP/rlGhYqEyVdoF+tZTjp0lWUhhncTqCIVcm
         ghb1fC9foI7wnnc9eqi8hwYSuJ/sa9JXG/zEzQJ+64wpxY8aFMKdL1QvNZ8bhtLtKS
         pynqInq4yAM7Xbk9NOjlw1dPbiZh6acyGuPdX+xrkzS/rfhqq5fplFB21OtghXMGP1
         GuLizPQl+7r8OKlltlr4Wm8ZuBRMpfCanmo01G0GmzHKrgJIUWSPDbaKtOKIoNf4Pg
         lbuQXLEdqGYIyJ8I9BRdSTqftUSsPpOMhic4C9t9tqGsfX1Ephw5gb9wCdMh/R071Q
         IUqVYNd0bQrIQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 40B5E40136;
        Mon,  7 Aug 2023 23:36:11 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D00A2A0079;
        Mon,  7 Aug 2023 23:36:09 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=snhSGR80;
        dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9B33A40218;
        Mon,  7 Aug 2023 23:36:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJF+OzirJ6lbIGo3h69nh65wDHPZ1TNIsWi2HHrO0l66cmnmBioZaMcJQhbmKiBMgUU2TqvHwajpJ2Dcct5rualDdfGACzZExBC+Q1UZVeMvMgZ7Lv3r3HTvVe/BhvYKvMrNaj5RVaT2sUlKqZ7sOjgbXoGrFfJRrj1yJOJDJ7rqQGAsCY59GUJKpmY69uLRvDOoLopKsQTZtM+pY+bOQOA+FP85CzQUT+YCaUXzzPvX+YssjcYZklKSD+JzLxjnYOMQ62cc77HkCKzxL/o/69gxZspnGFGee9zy8vxQh/w8S46SHG6XY2ufxSf7eY7wtKmVB+2PPR6c2fU26GC/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOto2GBOtgsF6bv+5iWeLchfLLYwC0N012fu079rDco=;
 b=n00rVD2dG8HSiHu281TyWvSBTg9+G82MVnPyX6zZzDtrwDNLC+EsseLC5vIgfO/CBbnniIi7BAoSIvwOLCNM1/Cif1pzaQ1xYrs20JDvGXfOED86kwoy1PNJ8ALUsWqVFubh9doJET3Y0h9ONwEhfNVlREwsmp+ygh0uIX2novgZ0k1BQ6m+1rr+93b/eiPm62lNUv+Wb3T+2RfY6LsEzF4rfwtIdiKpNQsICSmFYJD6+McEewQiljbitNkgNtIWQQRpoHawGGn+16azLDhGYLC/xyI4NnnOE12dFgOG/xwUiiyv1FPOFvfKQpze4d+bYAgTZlRo7a/U6/dfNcjBEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOto2GBOtgsF6bv+5iWeLchfLLYwC0N012fu079rDco=;
 b=snhSGR80v+fJsX7F65Kxwkbn2/DaayUA/o468RCtjiK7wwLkhVhTA72AqVN6e2lbAHOapjNMKlQtXQAMsSW+76drE4qvPlGAQ5nvv0PaNRAVjJVWxCDYuUkoZ9b/+SdZdV6Bh/JMdRXoZfFfINvHCnZTnP0aH/Q/39pejCoH1FM=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA0PR12MB4560.namprd12.prod.outlook.com (2603:10b6:806:97::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 23:36:00 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::9bdb:ffe:c29f:432f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::9bdb:ffe:c29f:432f%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 23:36:00 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Stanley Chang <stanley_chang@realtek.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 RESEND] usb: dwc3: core: configure TX/RX threshold for
 DWC3_IP
Thread-Topic: [PATCH v1 RESEND] usb: dwc3: core: configure TX/RX threshold for
 DWC3_IP
Thread-Index: AQHZyQKZa3CYkr0OIU+8xyydJDRIHK/ffbgA
Date:   Mon, 7 Aug 2023 23:36:00 +0000
Message-ID: <20230807233538.4vnycx5dej3nw2ak@synopsys.com>
References: <20230807074131.27355-1-stanley_chang@realtek.com>
In-Reply-To: <20230807074131.27355-1-stanley_chang@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA0PR12MB4560:EE_
x-ms-office365-filtering-correlation-id: c10a7d49-2f10-4b7d-9b8f-08db979f0edc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B4lAbZIuBmUb5dfX33TlVZy0MtTi4svuH56Es7FiQrY4mQTbR2gozKLOqQW6WeW9oHYYEut/z/rBeYqUCEFBGJFeD94U6IZWhaprVcbT7rvNvflHTCqeka0h75JCyIrUiumpMGxtM6rbtuuts0YN3SVpkad7U/KLSFK3nsfjePFkk00D1r97++4Fv5g/L70EPJbvImM0GWy+hHgH3sYm2h6v1RCSlNIITiOLrWGLXpMA0Z9HPVoRdqI7xubwfjJkwdsov/3yMRl08oCZij+l6yURjXXs6ZL7JSP06CaE7mJNhoXv+5IxWgSI+i5M+IR5SdDWFMPDKuq7GPYxpqoJbhxIKc7HrB2fJuF80WiqHMMBgJ0VRd4Lzq2fMiyUBQfZxvSl9MYX7ID1Qi1fpSR1jPbseXaZAjSxjfApiRY3dekIVxoI2+JK3il6alYzYr+1OSaGDumYtTQMfcCZj0GSusOXCKvjW1xFnudi7Cm/mL+9c9SYjN4/j7NNe8b4RstGbFGBvir9eD5GGC/QCh9h0FGOgP2cziK3n15WYeNTV42TvOCvHabEh+igT5ZcWE6yTN+FUzjpifk38rIb9CIUTjtLWQqioxamD2fbqxXr88BZrYPNIedkqsaLb0Gx4M+oYD/Ug5wD2k8+YvVaGPB6orqoQYpDZ9CHJLe69aAQSjAg77+fdHNAO7FXe05Ngxgt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(39860400002)(366004)(346002)(90011799007)(90021799007)(451199021)(186006)(1800799003)(86362001)(41300700001)(478600001)(1076003)(6506007)(26005)(8936002)(8676002)(38100700002)(6486002)(2616005)(5660300002)(36756003)(2906002)(54906003)(71200400001)(38070700005)(316002)(66556008)(66446008)(122000001)(66476007)(64756008)(66946007)(76116006)(6916009)(4326008)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDhmQmxhQTU2WnM5WTBpQTBSRG80WU1XcC9oL0lReHd3WDRDTDZGQzhkTHFr?=
 =?utf-8?B?TnF3Y3dKL21tVXdzL3ZwS1JzemdJbGdkanJTQ3RhWlBkRDcxVm1DcURnRXZ6?=
 =?utf-8?B?SFpldHhXWTV1ZWhZVG8zTGVocngrUGhjRG41SFZiaWpRckdzT2VCQVdaV3Bj?=
 =?utf-8?B?ZFVpRnU0ZDJ0dWpOTXFzVzdwWG9IYTkzLzZ4Vmk3UHJHNXkwK0l5cUYvZWYx?=
 =?utf-8?B?ZVdIWVhwbjVhd3kxemFyY2RRVVpuWUtLY0lNdlBBVm5yNUtVRnJtMjJuRzlj?=
 =?utf-8?B?NkxlOUkvS2J0OUZoN0RDOFNrbVEwTjN1akdjWFFkRmRTYXM4TnllUyt3Tm5z?=
 =?utf-8?B?eVpZcnl2ZlZSMEpEVXpBbGJyMUMycFF2UEtYWjlvd1RQcGw2dS9PNGhaNkNW?=
 =?utf-8?B?dGFUd1JWU0ovbFNqb056c0NFYUx5Z3VpMkZ3S3J5c1p6cGppVWdyTUx2amky?=
 =?utf-8?B?UkI0TCtKaDNNQkc0V2lDcjBsVnh4U1VNUWphcnZvQ2dleWFHY2dMc2xGKzdQ?=
 =?utf-8?B?c2hnRXpQRE1HQmF2RHpMSjN5enIyNytOdnFpcEpKdGwyK25zVHFQNGJTamJ5?=
 =?utf-8?B?V3RCNzYvdmZWb040ZEJ2dVhuRUhtS2hkbXV2b2xwR3RJVXBEaWpmckUwNDNK?=
 =?utf-8?B?MmdtSjdnbnByb1pjakwwa1hjV1dtNWFFbTRwbk1OaGgwVmREcG5GbmxxNkFi?=
 =?utf-8?B?VTJyTkRJWlR1Q1MxVDl1NHNTc2lXOWdVT2tybjJ6QVRZOEw5ekNYcWU3N3hB?=
 =?utf-8?B?dWNYaDdWTU1iVCtnNmZveE9odzd1bWsvTlIwWi85dGxrdTFpclNlYnExcW9I?=
 =?utf-8?B?a0pyeXpJU1U2eFhJTVZrRDVQdEFRRFJDSTJMSklHL1ZXbVlReTF6Wm5rdlNG?=
 =?utf-8?B?YlBoVjh6VE1EQ0JkVUs1M1pvZFdTcTFGU3ozNjJIckVoRityQUNBTzFZZnlt?=
 =?utf-8?B?R2h1RjRvYTB1eko4NG9FTk1nU3Q2V2gvdEV6eEdQbTFyQUdnRmVlNElpVEtu?=
 =?utf-8?B?NjV1ZHhqRmFiaVQxYksrNTJCU04yWW9RYUxUdEtsUXNQRkxhSTVFTnFEeVNj?=
 =?utf-8?B?bWdHTkxSbmZnRmpPRUZEOGg1K0w2Tm5SdGdKcThjSU5heXdzWThNQmN4Vzd5?=
 =?utf-8?B?Ym5RRjR1SmFVcmZtQkttVmRSQ0RzWmU2RFF3N09iVW0vcEFwOVhjNHZtSzNG?=
 =?utf-8?B?K3ZvSVpTV3BxUjFDN0tTQnY1Z0k5czFUbllwQXVsZmgrVk12aVMrSUNnVVBu?=
 =?utf-8?B?UHZkdnRaQkpxc2d6RDZVLzJuS0NnbC9mMkJtM083MWJBWGdNS3ZhZHdvYVhI?=
 =?utf-8?B?RmFoc3c4UHlORnhhd25tUkQxOEdLUEU2cEo4cGhhWDNIMEdRTnNFTnZFelV1?=
 =?utf-8?B?RVV0QnljdHdCUEZkclFYbitwWnl4VmZpTjRKdFlNZDBkMGFIdTJpUFNDV0ZN?=
 =?utf-8?B?dzBFUHc2OXVrb3o4bFJWRDFWMVVsaS9ZQm1lSFBtQmtybi9BWnBTdUlDbDhP?=
 =?utf-8?B?SmJIMXJqd0xqUER5bWVVVTRJQmVDYkRiS3YxSFlDZFc0VjJGbDJQMG9DUDM1?=
 =?utf-8?B?eVpWdmJvdkRUb2xBelVxMXVFMmd6YURBaTc1UFpEYTVNbEFMMUQwVTJFQ1lQ?=
 =?utf-8?B?UjB0VkRUQ2JFYmNvdGJGbXFveXdoanFhNHJJQW9qbDRBcHJJaktDMWVUSU1j?=
 =?utf-8?B?U3BNcVlCa3AxNFNDS2FzQm80MmxWMGNUaEQrZkx3NWppcVVsS2RzL2FoRUo0?=
 =?utf-8?B?NlhHdlJOWHJLaS9xZVFqY0xUdHhzQ0hORnlmRGowK3BTcmZhSXpCYUM2Ynpp?=
 =?utf-8?B?Nk5SNmlLOGxmd1ZORVpSMEJyb0RmSE5od0dtdkpFaE03eHUxa3QxUlMyVjh3?=
 =?utf-8?B?OG1YUkc0K2N4cDRpYUI5eFBkTXBPamxGbGYyWU1mUUNNN2xlcUJQOVdSRC9C?=
 =?utf-8?B?c2gxZ3doQ09XL2h2eVJEZk5DMnRKYTF2ZTJRdUppS04zeGFPS0VldGI3VlNz?=
 =?utf-8?B?UC9CWHRzdXlKZVZJaDZrNGhsaGhmeEQybnlyb2Q0VXZERjFXbXBVZTIxQzRE?=
 =?utf-8?B?UTVnSSthQ290eUJHZ3kwSUt1d21QeEZMMWQ3U1RKMVlFck83YUNJd3lPeWlu?=
 =?utf-8?Q?4Yb12D7SoHyOI9WDAMB573TfW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <372B829272256D40AE6E5E750044575C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dcICUz/NADq6cJvr34C9yCAZXm/AavbU2kUs2jB0HkFscUDhCOv/s3hDSG5S+RXpdZfZ4qzrHJ5VsloCiAvFlJytxAnqJ8UW3os57JbD8Ckk/ptiYwXARbnBTLBL/02Qz2xbFp/SzUVyVRJP3+76536vXfOXWCqVXNWhBUc6LhDSe5wEsSxHkpXLWI9uM0vB0OypBkk2BPu5tgG4tCTmo/E4tKXE21JITNBsfa7PNL3BRK8/IR4twsFTSJDayReVANFhUKMBfQk6JnSUxNxLCll9dToCnqu7JRRaBHAcUTumi9nnBfcq/CGSFEAuyMpjap6yw30Vhq01+F86VjqKERlOAzSdR8gWct3na01TbhYP0x/i4d8jehZgKuKw5JW5/lyHwgdzkHofEFyk+/FmoZPH7gQzD62Z6kYXW9MmEZAAkvVnvVfbPaub8QoDk34cjnXtwhGVHtw2utguCo3Oa/J96rlXFFQg3Xou/ZxsigAVRO7s1OON2TEqC/yGRswJvT0AoXNbKq7DOn3Bx7T8J/n612pGg/xA0SNvlrbRqCoocqsiX8fGvoV0RWjcv1FuOSjnOZwOyrlRz19lhJRVSvX8moscC3RBs8WuiUN0ezB3tuaIhRePeiT27PSpny7WSWnyz93nBIlyJJ4IHAQixNw2xvooKnX6suF/ifvrnxw6ea2xRE81XRujh7OgnO3sYbx6cDW1TlyEGQeYe1lrtAoLx4b+WGlT8IzqKA6HYr/7ZM/bJH7fB2/s9LTOUTsvYKP7TCTXuBU3a4QO0JId+sHkYdP91BARkr2jvLok9zr6hz2qs6GI0zAILp9BDuk4YceIYbDDbsKkv7dc2gts3ijF5Ht3er+/ljWa53nByd9Sx3krLaWHywZZXMwpWZU6XYou+TOeukQRjmIDx7kOCA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10a7d49-2f10-4b7d-9b8f-08db979f0edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 23:36:00.7867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ovuegTNKERO7M6q/vng8veXzo33s86GoZ1BIKN6ioHMBydc25bWyJuhyY5I9VzEZK1VfUpc2/5oN2SUDoQM9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4560
X-Proofpoint-ORIG-GUID: S0-Td2aCBvYBXhFno1T58qi-KZyTBpm3
X-Proofpoint-GUID: S0-Td2aCBvYBXhFno1T58qi-KZyTBpm3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_26,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070212
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWcgMDcsIDIwMjMsIFN0YW5sZXkgQ2hhbmcgd3JvdGU6DQo+IEluIFN5bm9wc3lz
J3MgZHdjMyBkYXRhIGJvb2s6DQo+IFRvIGF2b2lkIHVuZGVycnVuIGFuZCBvdmVycnVuIGR1cmlu
ZyB0aGUgYnVyc3QsIGluIGEgaGlnaC1sYXRlbmN5IGJ1cw0KPiBzeXN0ZW0gKGxpa2UgVVNCKSwg
dGhyZXNob2xkIGFuZCBidXJzdCBzaXplIGNvbnRyb2wgaXMgcHJvdmlkZWQgdGhyb3VnaA0KPiBH
VFhUSFJDRkcgYW5kIEdSWFRIUkNGRyByZWdpc3RlcnMuDQo+IA0KPiBJbiBSZWFsdGVrIERIQyBT
b0MsIERXQzMgVVNCIDMuMCB1c2VzIEFIQiBzeXN0ZW0gYnVzLiBXaGVuIGR3YzMgaXMNCj4gY29u
bmVjdGVkIHdpdGggVVNCIDIuNUcgRXRoZXJuZXQsIHRoZXJlIHdpbGwgYmUgb3ZlcnJ1biBwcm9i
bGVtLg0KPiBUaGVyZWZvcmUsIHNldHRpbmcgVFgvUlggdGhyZXNob2xkcyBjYW4gYXZvaWQgdGhp
cyBpc3N1ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFN0YW5sZXkgQ2hhbmcgPHN0YW5sZXlfY2hh
bmdAcmVhbHRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCAzMyAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29y
ZS5oIHwgIDUgKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdj
My9jb3JlLmMNCj4gaW5kZXggZjY2ODliNzMxNzE4Li5hMGE1NGU1YzRhZDkgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5jDQo+IEBAIC0xMjYyLDYgKzEyNjIsMzkgQEAgc3RhdGljIGludCBkd2MzX2NvcmVfaW5pdChz
dHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCQl9DQo+ICAJfQ0KPiAgDQo+ICsJaWYgKERXQzNfSVBfSVMo
RFdDMykpIHsNCj4gKwkJdTggcnhfdGhyX251bSA9IGR3Yy0+cnhfdGhyX251bV9wa3RfcHJkOw0K
PiArCQl1OCByeF9tYXhidXJzdCA9IGR3Yy0+cnhfbWF4X2J1cnN0X3ByZDsNCj4gKwkJdTggdHhf
dGhyX251bSA9IGR3Yy0+dHhfdGhyX251bV9wa3RfcHJkOw0KPiArCQl1OCB0eF9tYXhidXJzdCA9
IGR3Yy0+dHhfbWF4X2J1cnN0X3ByZDsNCg0KVGhlc2UgYXJlIG1lYW50IGZvciBwZXJpb2RpYyBz
ZXR0aW5ncy4gWW91J3JlIG92ZXJsb2FkaW5nIHRoZW0gZm9yDQpub24tcGVyaW9kaWMgc2V0dGlu
Z3MuDQoNCkJSLA0KVGhpbmgNCg0KPiArDQo+ICsJCWlmIChyeF90aHJfbnVtICYmIHJ4X21heGJ1
cnN0KSB7DQo+ICsJCQlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HUlhUSFJDRkcp
Ow0KPiArCQkJcmVnIHw9IERXQzNfR1JYVEhSQ0ZHX1BLVENOVFNFTDsNCj4gKw0KPiArCQkJcmVn
ICY9IH5EV0MzX0dSWFRIUkNGR19SWFBLVENOVCh+MCk7DQo+ICsJCQlyZWcgfD0gRFdDM19HUlhU
SFJDRkdfUlhQS1RDTlQocnhfdGhyX251bSk7DQo+ICsNCj4gKwkJCXJlZyAmPSB+RFdDM19HUlhU
SFJDRkdfTUFYUlhCVVJTVFNJWkUofjApOw0KPiArCQkJcmVnIHw9IERXQzNfR1JYVEhSQ0ZHX01B
WFJYQlVSU1RTSVpFKHJ4X21heGJ1cnN0KTsNCj4gKw0KPiArCQkJZHdjM193cml0ZWwoZHdjLT5y
ZWdzLCBEV0MzX0dSWFRIUkNGRywgcmVnKTsNCj4gKwkJfQ0KPiArDQo+ICsJCWlmICh0eF90aHJf
bnVtICYmIHR4X21heGJ1cnN0KSB7DQo+ICsJCQlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywg
RFdDM19HVFhUSFJDRkcpOw0KPiArCQkJcmVnIHw9IERXQzNfR1RYVEhSQ0ZHX1BLVENOVFNFTDsN
Cj4gKw0KPiArCQkJcmVnICY9IH5EV0MzX0dUWFRIUkNGR19UWFBLVENOVCh+MCk7DQo+ICsJCQly
ZWcgfD0gRFdDM19HVFhUSFJDRkdfVFhQS1RDTlQodHhfdGhyX251bSk7DQo+ICsNCj4gKwkJCXJl
ZyAmPSB+RFdDM19HVFhUSFJDRkdfTUFYVFhCVVJTVFNJWkUofjApOw0KPiArCQkJcmVnIHw9IERX
QzNfR1RYVEhSQ0ZHX01BWFRYQlVSU1RTSVpFKHR4X21heGJ1cnN0KTsNCj4gKw0KPiArCQkJZHdj
M193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dUWFRIUkNGRywgcmVnKTsNCj4gKwkJfQ0KPiArCX0N
Cj4gKw0KPiAgCXJldHVybiAwOw0KPiAgDQo+ICBlcnJfcG93ZXJfb2ZmX3BoeToNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgN
Cj4gaW5kZXggOGIxMjk1ZTRkY2RkLi41NDgwZmNiNTliY2IgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IEBA
IC0yMTEsNiArMjExLDExIEBADQo+ICAjZGVmaW5lIERXQzNfR1JYVEhSQ0ZHX1JYUEtUQ05UKG4p
ICgoKG4pICYgMHhmKSA8PCAyNCkNCj4gICNkZWZpbmUgRFdDM19HUlhUSFJDRkdfUEtUQ05UU0VM
IEJJVCgyOSkNCj4gIA0KPiArLyogR2xvYmFsIFRYIFRocmVzaG9sZCBDb25maWd1cmF0aW9uIFJl
Z2lzdGVyICovDQo+ICsjZGVmaW5lIERXQzNfR1RYVEhSQ0ZHX01BWFRYQlVSU1RTSVpFKG4pICgo
KG4pICYgMHhmZikgPDwgMTYpDQo+ICsjZGVmaW5lIERXQzNfR1RYVEhSQ0ZHX1RYUEtUQ05UKG4p
ICgoKG4pICYgMHhmKSA8PCAyNCkNCj4gKyNkZWZpbmUgRFdDM19HVFhUSFJDRkdfUEtUQ05UU0VM
IEJJVCgyOSkNCj4gKw0KPiAgLyogR2xvYmFsIFJYIFRocmVzaG9sZCBDb25maWd1cmF0aW9uIFJl
Z2lzdGVyIGZvciBEV0NfdXNiMzEgb25seSAqLw0KPiAgI2RlZmluZSBEV0MzMV9HUlhUSFJDRkdf
TUFYUlhCVVJTVFNJWkUobikJKCgobikgJiAweDFmKSA8PCAxNikNCj4gICNkZWZpbmUgRFdDMzFf
R1JYVEhSQ0ZHX1JYUEtUQ05UKG4pCQkoKChuKSAmIDB4MWYpIDw8IDIxKQ0KPiAtLSANCj4gMi4z
NC4xDQo+IA==
