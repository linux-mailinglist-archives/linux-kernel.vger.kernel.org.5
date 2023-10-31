Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D6E7DD93B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 00:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376874AbjJaXWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 19:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjJaXWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 19:22:47 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4ACB9;
        Tue, 31 Oct 2023 16:22:45 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VM46oL002895;
        Tue, 31 Oct 2023 16:22:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=bQQYC6U9dCv4fWE0+r9bja9UrbYbK1xC+/XkfVlRu54=;
 b=LpByJ5zg12t+npqkyVaaUQfv04OMT9kPV9WJfOPWbArDvIjmyqSrunBrRjuO/RI6AUIX
 ThRDCTGiSQk7aMyHpIPmF2RchRGRdLapsW1UCBdJ55TJl+y9XZCp+Xr0j99GqELVvjnE
 DdP5erUr6B1OPf0roK3PLqu6bCiVp9Tj220uvscItJLwpaGuDZOKStqBkK72ox0a6DFl
 u6ntqm7bT7lH3hCTz6aalxohLkNs6HPcYp2GnzQXnLNn6gOAmmGiERP6H93bJoywFpjs
 bnVsEO3Mnu/k2S9qVjjQMn/o031VagjHCflcXbKhVsw5wTqLQa+GDDk7aXp+59Z2XiMz VQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3u11j610ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 16:22:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1698794562; bh=bQQYC6U9dCv4fWE0+r9bja9UrbYbK1xC+/XkfVlRu54=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=cC4WT+QTjOeOSHnyaLiVGas7rgd/g5xK15QxZw0GTAiEdPHWV5AayOoE8ItqRE6bI
         Kij5glTD7t1S4rGzg9cY1OBUA1PykCG6ahdj6QriJuEwaeADupsPEAs1c12hCMtpAQ
         fakN+uKClYYrik03/Q/lJCHdnonQKScs9XLLMvyvBRuBjqab39/vC8cOW/NJvn94Qs
         5jLMWzGzwBA2nTP//Ey2YDDIzfh422u/ONy3DfSDXrKufwLUeAQiTRw2yJfj85RkbH
         xdvBB8a3nPlGHaIiUCMBGn00G2h9MZRcaG+yg8vtIjLz5MfU4u3v9XR+i8JB64rgTf
         MRjnJ1g3XQk0w==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0B850404B0;
        Tue, 31 Oct 2023 23:22:41 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 47398A005F;
        Tue, 31 Oct 2023 23:22:40 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=TxzXxFrs;
        dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 79CE740586;
        Tue, 31 Oct 2023 23:22:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nup25iNhsAHeMSWCJK+DSNU/XB6YVFIsPLgKdc1aFak+oi6abpkzcMFxs3C/nnsuDPhjJLe9439u/BQ5MJb5UN6FPZ0Rf2m9ySEr6QGCjhm4YbEhJgAHCYOPMj8FGXs1JxcaN9SqQ6ZSYt8tvxScfsixlgL6X1Ett+fmD6AJLZ5hYw6Cv2JsjFStSNUJK6P29ZkTHToKY6qj+10EYUTpGo3d4F8f/NeBSi8MMvi7nacAaiEWwTPWmekIKmJT4sVsp8/07ebdkDHD6rqOdk5drkcWWwhbDHY/4lQ6nkJ6ts3yPUlgYgXk6/6Vy1n1InssykmyBO3NB4afL8TjdEsE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQQYC6U9dCv4fWE0+r9bja9UrbYbK1xC+/XkfVlRu54=;
 b=FDyuZlJg47S/JQYwQ3s+L6wpVJXOE9pZpBOolMbb5x1kvoM2hYvc4AG742zv8UbCAsSZ7mBEs8SP3RrADPSV69JRcLv+Y8LxMU15m328r60zfvLozbZUU7CBdoW37beyqskdzS13/Qcb+4lz8JbeSpyZNOUXnyf+sWAHUw59Cd+hr48ZLpr9ihkTIHSMnLAWMcRQyBZrEncz9hyQtgNR6v7TnrxPEgsiUqaRPSfmaaQ4YFACj3AsUAi3TnaHFQWQIGZDelmz7DUW0AW1KdD880x940sZ8gi4b7aEaExWhl0muuLfptuiZVJF32k4VCPYYO3FyqEuZH8FHFvNqdyaTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQQYC6U9dCv4fWE0+r9bja9UrbYbK1xC+/XkfVlRu54=;
 b=TxzXxFrsRFT3h3/XVK8VuA/Zn4DBSw1FIuK0NrLTlXfPk6yRx/tRgsWkSmFoieEBaplVSmGGB3xjNMJDeSslJRhN2qfqWDBmdxoFXpw5/tyB+eufwaWzaT8u0wT2uDIoh6C4L7YtVQ9kqzdADJjAlPAN0xJW0+S9T9vupNQ0OhI=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by IA1PR12MB7494.namprd12.prod.outlook.com (2603:10b6:208:41a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 23:22:37 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3fd1:e599:fe7b:e676]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3fd1:e599:fe7b:e676%6]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 23:22:36 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
CC:     Zubin Mithra <zsm@chromium.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: set the dma max_seg_size
Thread-Topic: [PATCH v2] usb: dwc3: set the dma max_seg_size
Thread-Index: AQHaCMi0LFnRXVHWjk+Pu6ZWajGyOLBkkKeA
Date:   Tue, 31 Oct 2023 23:22:35 +0000
Message-ID: <20231031232227.xkk4ju3hxifj3vee@synopsys.com>
References: <20231026-dwc3-v2-1-1d4fd5c3e067@chromium.org>
In-Reply-To: <20231026-dwc3-v2-1-1d4fd5c3e067@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|IA1PR12MB7494:EE_
x-ms-office365-filtering-correlation-id: 3594dca2-9f4b-42f4-b3ff-08dbda684448
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jdij8E4zKgACqJF2mg0LuXoDKkHwUZj4zR7x21QawXa/bfkMHGTSLqKgT3Qz6+XGMquao6Qx7x1ge6KDNVpmZ4ub7UHaNN/ZUbPQKadFaYSx8jBBAi4/GDZwEMQO05BHFZuAFIQ7JSTy5vjkc6G99l7fjH/F9xEwhHo42HnP4Va2yegHx1qzkE5R/4V2JhkxDveBkTeWn7ZEhHd8phACFvvzX0n3uCSVzkk8MygxXJUepZ5vVfGFhEJoZzUb6Ut2sr0EBpSkAA+wGZbw366nZfMFZz+e19mYufcxTIe0DkdHo8GaVRTExHUCChyWh0xZWrObKQP8vznOA2n/q6AhH+cjaQ/Z3uj9aSKzOd3SDqTv3fsI0rgWc6ym2fwEeVWUdQ/CT3MMZoZW7hTrYwLomjuoZpTEQbkuocKo5d0s8mImCYeLVgv2O+/aVTkCtAWiwmkHIBR6/37DA31fjJFl15irD97UlYCdIaLjh0eUlj9G0EwvZ1vUo8Lr/eUfLsJDfc3YaXXiXXrrmCemK/9gASkD5doeYqfjfSSG24+3593yJ8kq1U57WhIEn32sxbqVj7Z0VzQmCbW+JlU4YYUUkfKy7GJP2vXCRjZNZPOl6bXohAdRVADgJeOwn7ROJL9BChacND9BVA4NHzmiRyVKJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230173577357003)(230273577357003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(316002)(6916009)(66446008)(66556008)(66476007)(64756008)(41300700001)(54906003)(8936002)(8676002)(66946007)(76116006)(5660300002)(4326008)(122000001)(83380400001)(478600001)(2906002)(966005)(6486002)(2616005)(6506007)(36756003)(1076003)(6512007)(86362001)(26005)(38100700002)(38070700009)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0RNckZmeXUxRXBTdHdFb3RXeUhMUE9GcDJvUmh1eW10eDNoYTlqTDV5UEhp?=
 =?utf-8?B?Wnc4T0R2eklpZXB0WHZRRytRYnZaZFQwU2lwZHRkSUF1R1FYZWhsODliTGVP?=
 =?utf-8?B?ZXhLa0pRQjhHLzZzMGE1UnB0SjRlOHZhck4vV2NuQzNXK1BneEpCTFdMeVEy?=
 =?utf-8?B?L2dYV1pybXFvMWgrT0pJbVRrUFppM3ROVFMrNGwvV3JsRmxTZWVRaDMvbnJu?=
 =?utf-8?B?UGJkcnI0SWZTT1hwTlJXelk2Y1BhbkVqdUVPRUZ5aVJmR3VXYjRiQ05RcG1l?=
 =?utf-8?B?R0tkRlhrQjcvRUVabzI5eWU3aHNaa1R1RTZick5mUERoWmJ5dEFncWRPLzAx?=
 =?utf-8?B?d3J0TmFlT1YxM042U212QkJuaGp4dVVIRnJjQzlqRlRmaCtpQUtwK0EvNis1?=
 =?utf-8?B?VFJ1TUpNYTdWRm9DNzdFaDhJSlBlTXVWTjVPWDZsdFlqdWxUVE9WYjl5VWRh?=
 =?utf-8?B?aFRtT3BteFhHRm42SldORXJIVGxpQ3NkTGVpK0ZRQ1QxdFdiTk40WXJaSU1j?=
 =?utf-8?B?aHJ6d1JzSkk4VzJwSDVQQnVqM0xYVktRSERMdER1ODBlM2JpNUVNZGJ3a0V2?=
 =?utf-8?B?SDNXMFozRis4VXhEOFluN0t0SEI1a1U3NVQ1WWg3VnNTdWhjSGZ5b3hLT21T?=
 =?utf-8?B?b044bFpUOFErMi82dU1OOVk1Rm5wc1FHT0NURi9MMTU4U2NndUdrSWFYeW92?=
 =?utf-8?B?Rkl0ZURxMm96NWtGcTVqRE80eE9mVm5QQ2tBU0s0Nkl5cUVCR3h4dUZ6di9X?=
 =?utf-8?B?Mms3V3JpeTdDbDBpUjQwNU9ydVp3VmJ2Mi9PWmp1UEllQ0V5dFgxamRZZm9x?=
 =?utf-8?B?VGh3Tks5bjZCTW5UZVJyNzFmcC94ZStLQlBWWHBUeHlsNkZTTEtENjBHbFJn?=
 =?utf-8?B?M3FSL0ZkbHJscFFKTHdMRFVjWkU5ckQvMXVkcVF1TWwvUFlKc3pqWkNLZGhl?=
 =?utf-8?B?UzNDQ0xBQUNYZnp2VlpGOTQ3QUJCbDU2NDNweWo4UDhBREs3aXNZWFJJNE1l?=
 =?utf-8?B?citrbVpTcUt5eXFZdGFyN1JpZmpsQUoyblhTMzlRUTNuT2lkSVhtbEo4T0pX?=
 =?utf-8?B?WmlyNjF1NGJSVUhhNzdKQi9OM2xKNEhQYm40d3VlV1A2S0VnaUhvZHY3TWRy?=
 =?utf-8?B?TlU3MDdIcHRNK212NlhZM2ZVQTY5UmRWYzltZEhsamJDc054K2c2bDN0ZmR2?=
 =?utf-8?B?b1JqMDZmeUJKZVIwVWVDN0Y5WmJvZDJ0TzI5NGdRdUp4VG5jczNnUHpVUERk?=
 =?utf-8?B?UEtjZ1NOY3k0YTd2dEVwcFBjSkp5YnlnVThUQ0Iwby9rRW5RY3AwTzdmdzFT?=
 =?utf-8?B?TmRkRHhCT1pxbGdwb0h0U3BMMzV2ckU2bVlkTUdGd0ZmUDY3ZlNDdzlSeE1z?=
 =?utf-8?B?KzBxTDZLUGtDbktvaFkrTkl5OHgzZWVtViswWi9NNk9sOVhBMTlOb3VKdHNo?=
 =?utf-8?B?Q0hwV1VhVmtaTDNqUk0yNWxvTm51SDlRbzZLdVR3Q05MUTUweWJFL2x3Nnlw?=
 =?utf-8?B?YTJaSGhBOHNhM1dTY2dESy9oS3h2YnVKaDJIbGRqOGNNM0g4K25ZNEZZZ1dm?=
 =?utf-8?B?Vkgxd1FTOThDKzhGckExdWNpUWo5bTNuS0h3Y1BFUW1sM0hFTExHM2FSTVV0?=
 =?utf-8?B?TTR0Smo5Y0hYVzBkanhqVXMzRWs3cVlLWFpkT25NY1c1bTdXU2UvbE5KbzhV?=
 =?utf-8?B?aVE3T3lMOWk0VGErcitGYTJGdHk2TU9pUnN5ZVRoUEY2VGZCU2wzMFl2bjZL?=
 =?utf-8?B?UlZiV3ZpQUhSZnk3ZXNIeXQyRnJkT0R0YVpTNlNsTnhlQW5nVU54RkZxZHZD?=
 =?utf-8?B?ZHJmTndXV0Y4UXJJdXNHSUFkVUw1eUNZdFRNdE9hcE5kZGZZWEhrSkFIVC9D?=
 =?utf-8?B?TnN2Qzk3YWorMW0rUElTR2FBZk5IcldET3J4T3BEV1ZjT1RUeHhjc1NRSXdX?=
 =?utf-8?B?aVFlVVpXVGdISHhXcG5XRWJlQVJ5SnFKOVIvMjFPbFU2bFJDdThYa3k1eUta?=
 =?utf-8?B?MUVZVUlWZGlyUmxOVGloWGxXTDNYRjd3b1FEZHA4UmhZU2c3YStkNlB3TnJW?=
 =?utf-8?B?Q0o3Uk83czgrSm1XZ2FDazh4UkRRSEJvZ3lkTHJWWDhpTERSOHF2VHVRSG5S?=
 =?utf-8?Q?Nj8RlyXfxGmg+fsgKu2uBl31l?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F7E2646805731439BB4E27BDC7ED977@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dcdMcB7F2kBxs34XQT37msD2KHD4DqRSIoj1IHWEUhi5jRhwmOlekqHWEpiUvZqdVxR8vIojko5CtqAk9Z6mfThxxpx1gqb7BzsSBwo7czAiXifdQeQRE1lnbll8PtEd14+AhvSxBsk8kFsysHX+etNit9EkypepTcMnKiGVvXOU1hB//GRoZCcX+btKYUtsQa9gYG1/ZU9dt+99FTWcTJbNsUVVFc5SQ9Vf2rJi4Gtz7GR1KVXo44AQsTYWNO4lpvM5dD7QavLfj8s3J5a96MQlZsdrRXXlm1jWDLCBXrJfgKChvV0Za6VVl3uy2WS5CvVJhGFGfRZXbQlgUmYDDCRbyI3VsEH6050pGbnGW8NW4OzcdrXFBOKkLt72RCzyUj7DhRJUxfPAlCR/kFkI7tvoX1deRptIiWUHiulXaofYjY0A7Z6cvPMCuBkZ6iHbia+MomCyj/AFH2g3LJtZVJFKWskT00nLawEiVZc3IFejxKtbofIffYIHnyIbiVpA/3sI5GRFncBKGb3hpdrbXjnmQhXQ4yRD9CmtY4M++X17OG99wTlLBWf/owFzC23+ijA2tBe3WcP/ejYVmUfivBJQFye2RImj8mMZ8rl9jCmvCM4v+9jnFH/4DUDX/5Fs07YLRnwisUTa1csYgE783z+wdtIK++AsbrS8L3Wv1Z8kipBuoJLvKcNLXBXhjZwcMzI7j0me6zJWeHvdQZARWK5jmr+w306bnH9tDpc7jlOCxlr3i8j8sB70HBWFwtDBxZPjpXgBuGy17QhawOUzt4UR8CF+X4Vcr5ZxT75jqi215UQbLj3MbFfk7nCtQC7S5iXqTV3aQeoAC9fOYmHPFq6/ufDkJe6oHMcnwlIxj3gNsJczuuUmhvvMkRGeLvLyeFUtWK6skDhhkauel6BHgg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3594dca2-9f4b-42f4-b3ff-08dbda684448
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 23:22:35.9556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GIxogFbxQoU3+YvZEkBtswyjV91b4O1YVdRl4Wxg+UIKxepFjLISMptb1tVfFmq6waUAI0tOIeWH0BgcQKaIWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7494
X-Proofpoint-ORIG-GUID: h-2bKlylrPrxADLi8wNUUSntXvWktKj_
X-Proofpoint-GUID: h-2bKlylrPrxADLi8wNUUSntXvWktKj_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_10,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=925 clxscore=1011 bulkscore=0
 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2310310193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBPY3QgMjcsIDIwMjMsIFJpY2FyZG8gUmliYWxkYSB3cm90ZToNCj4gQWxsb3cgZGV2
aWNlcyB0byBoYXZlIGRtYSBvcGVyYXRpb25zIGJleW9uZCA0SywgYW5kIGF2b2lkIHdhcm5pbmdz
IHN1Y2gNCj4gYXM6DQo+IA0KPiBETUEtQVBJOiBkd2MzIGE2MDAwMDAudXNiOiBtYXBwaW5nIHNn
IHNlZ21lbnQgbG9uZ2VyIHRoYW4gZGV2aWNlIGNsYWltcyB0byBzdXBwb3J0IFtsZW49ODYwMTZd
IFttYXg9NjU1MzZdDQo+IA0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBGaXhlczog
NzIyNDZkYTQwZjM3ICgidXNiOiBJbnRyb2R1Y2UgRGVzaWduV2FyZSBVU0IzIERSRCBEcml2ZXIi
KQ0KPiBSZXBvcnRlZC1ieTogWnViaW4gTWl0aHJhIDx6c21AY2hyb21pdW0ub3JnPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBSaWNhcmRvIFJpYmFsZGEgPHJpYmFsZGFAY2hyb21pdW0ub3JnPg0KPiAtLS0N
Cj4gRm91bmQgd2hpbGUgcnVubmluZyANCj4geWF2dGEgLWYgWVVZViAtcyAxMjgweDcyMCAtYyAg
L2Rldi92aWRlbzANCj4gDQo+IHdpdGg6DQo+IA0KPiBDT05GSUdfRE1BX0FQSV9ERUJVRz15DQo+
IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIEFkZCBzdGFibGUgdGFnDQo+IC0gTGluayB0byB2
MTogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Iv
MjAyMzEwMjYtZHdjMy12MS0xLTY0M2M3NDc3MTU5OUBjaHJvbWl1bS5vcmdfXzshIUE0RjJSOUdf
cGchYjIyYjdXeDFRT3BuRnRNaTdySjBUUy1yaE9uTW15X3NPQ1gza2RmbG43ZXpOanNseU1oQndI
dldhWGJLOEQ1QmtLUGpqbjNIZElELTdMczVSM2VSXzRvJCANCj4gLS0tDQo+ICBkcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNi
L2R3YzMvY29yZS5jDQo+IGluZGV4IDM0M2QyNTcwMTg5Zi4uNjVmNzNkZDhlZjQ3IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYw0KPiBAQCAtMTkxOCw2ICsxOTE4LDggQEAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICANCj4gIAlwbV9ydW50aW1lX3B1dChkZXYp
Ow0KPiAgDQo+ICsJZG1hX3NldF9tYXhfc2VnX3NpemUoZGV2LCBVSU5UX01BWCk7DQo+ICsNCj4g
IAlyZXR1cm4gMDsNCj4gIA0KPiAgZXJyX2V4aXRfZGVidWdmczoNCj4gDQo+IC0tLQ0KPiBiYXNl
LWNvbW1pdDogNjExZGEwN2I4OWZkZDUzZjE0MGQ3YjMzMDEzZjI1NWJmMGVkOGYzNA0KPiBjaGFu
Z2UtaWQ6IDIwMjMxMDI2LWR3YzMtZmFjNzRmY2IzYjJhDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+
IC0tIA0KPiBSaWNhcmRvIFJpYmFsZGEgPHJpYmFsZGFAY2hyb21pdW0ub3JnPg0KPiANCg0KUHJv
YmFibHkgYmV0dGVyIHRvIGhhdmUgdGhlIENsb3NlczogdGFnIHdpdGggdGhlIGxpbmsgdG8gdGhl
IHJlcG9ydGVkDQppc3N1ZS4gUmVnYXJkbGVzcywNCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8
VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=
