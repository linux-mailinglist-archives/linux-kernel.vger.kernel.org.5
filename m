Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8637C7584
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441944AbjJLR7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347352AbjJLR7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:59:40 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F49CC;
        Thu, 12 Oct 2023 10:59:38 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CHMQ8F029533;
        Thu, 12 Oct 2023 10:59:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=okRWcYZKmvQzbVCdJnutn/kchsozX9BcLp6YIr3PVQM=;
 b=XIbuPmgmqrGFU5xgQAficfLDY+s6GHvwxqyhmfdoApIdz0pHkxuULHKbE3ocG+MMl9J0
 AwwfjV50j5lp/bl8f4CV2e4b2vi12bQZrAuiqGIIvpC5gd48oJsN7z+6mTy8WzOeQQPQ
 jHCBgs7SKAX2MyO1KA2613cgW21GhGTAcLMl0j9hKIDRCVdafFqB6IhXJl/uJswPuxs0
 m7rzbk9oSAq56ZOVmbUWXxiFjo8vDibu749zay8igtJH4oB2vDcmbCUuARkgPe/o7FFF
 4q6txGwOUPDKRLMqbIHTRl5HV5QkSZFq6W8o8+uAFtoKSndvVn7u+lwk3BiHt6GlFXPJ 1A== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3tkh0pjnan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 10:59:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1697133573; bh=okRWcYZKmvQzbVCdJnutn/kchsozX9BcLp6YIr3PVQM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=H0WUevIUIpSCTvgquQ/3pl1UdakDE2fHRl2NUVeLQ6nD2rHlhiiQuBIkcxcn44QQ6
         eQCNqAwSHU9J6iwIcXHBV8Xuf7zMWAf6y3xQ3pOHTpa6QYQYQik+I2wUUXDIMQ3mlu
         xWa2Re4+RQ7O0ZCLG0/mNhLPhM3RG6shSzIiVOJ83/3Zyi9QtPK/HYoqEFd2JPfgMN
         bUQ1JKERovSgUjOP8Bkkg+D59zfHoW9AR1Nb3yJmQJZalR1aGT+8l50m5K+OPgxUk3
         fQldBBNAuzhX8i/STY2z71I0Xbj6azKaeytEOkro774voq20uNroR/OLkWHFGgwCLQ
         kqOMvSE+uvqDQ==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8AE6840493;
        Thu, 12 Oct 2023 17:59:33 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1F904A0077;
        Thu, 12 Oct 2023 17:59:32 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=q5M+hzyU;
        dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2A3E84054D;
        Thu, 12 Oct 2023 17:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qvl73OfRSsq7sVNNdWkT6ZhHcvqBeU8IdtHxfHO81lhMkjL0cMBA2vII1Z7BVXhf5PZxKDgDE6apU7Ma12jeUH3zvamUroevcUWYdXOcoiBhuSMOLM8mnWtcO86FOowc8xfEnDtqzuLY8rR8zA1SPFbFpiIpmHnQYUBOxVrgGHItZAPK2GLXNuk2bCkzXIqyUE+YO1Ut5QAANJAqt4AhqR8sUUsqfXqHU6wBMV7Uhdct3gP2WmwnCKDY+/njp+NXY664SPdWY6OXk9DOR+wOwxx2ys5ucSOVs/hio0ooXeNKaxp54SYaKWCRuvHYWA7ETZSQsXy2Rn9UIlxSTwRHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okRWcYZKmvQzbVCdJnutn/kchsozX9BcLp6YIr3PVQM=;
 b=NkEPyNd8teTraCFOie/QDcSsz+HJUFbhtE/WXllBRKSMXtbkwAs7BMJSN5oQzkrSOtgB165BwKM1qtUIr2bqyzvT+MyGx/tK5+M7kqFFj0ewH70GrZmdyG9DB19dLW6LkLp6q5uUfsCXcS5sGS1EudLVtNywXmGZ+8JSvQjhgv6dZ32TkHREZB7ioQ0crPpD+YAv8/N+dSsNSw30NY+d/X6FJ2eGk7MnJmeR22x+8lH05EyQLMVW8/x5zh3YkXMwzYsjptEnWxK//7tdvps6Doi9rlfdnBBEUEPHBZoA15IJepTII3sfFY9gsojoEcOtIUZ1iHpw+vmt8hmDPY8Akg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okRWcYZKmvQzbVCdJnutn/kchsozX9BcLp6YIr3PVQM=;
 b=q5M+hzyUtomHbwkC6x3U5/GjqSuSsqCqxQ4Hx5T5AJf3z03aiRr5Gm8jDOrf1zEInoDBCNSfcoyuzzRh56y2LXE0ZukXWT+N+uR89j/WosNhrePF05gX1oe5GigGsrEDNHmwjVRpITbi0HfBAOKJYY4pJAenbvJ+0hVoC8gHsms=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 17:59:29 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b398:9c9e:3818:b7a2]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b398:9c9e:3818:b7a2%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 17:59:29 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
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
Thread-Index: AQHZ/CoP25al8cFBjkKV4rWMrsyj2bBGc0gA
Date:   Thu, 12 Oct 2023 17:59:29 +0000
Message-ID: <20231012175912.umc3ugzk4iqwtcp3@synopsys.com>
References: <20231011100214.25720-1-quic_kriskura@quicinc.com>
In-Reply-To: <20231011100214.25720-1-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB8572:EE_
x-ms-office365-filtering-correlation-id: 8953f28a-389a-4409-0f69-08dbcb4cfb0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tIBMo+3+DWGUwrNReaFmOrE/dE74uYif5l5JkWKH03XC63LCktT3YFxD9Ftj6amYdy5feZb6sYtd80j3oKeva5Xkr6HkJmfZWmhRwzhgFNXl5GhGFGi79fANGbkwZTewtVUDPuxN470V0N/lHQUF5z5cQzoQ/Dbq6ByjOix/YVpRNmu+ml1jYflIHAaWKQeCgUFkdP0XKxxvucuzrJXUoKH5ST2F0qUiFFkCyTymnpVO2SAesPwmdy/+VwVlEYQd8c9yxktVKYOUMIE50govQyPemwdSI06qPeunuqYZhu7imkRIQei+Z4aHXYy3fN8JVPyhVlMVy8csZv1/ufCIN54o8nvHjXvB2A0AAIZWIQEolqx8/2dbRQpkaQ/Fs4ZtFx2iB6w1wLHqbHDd33Rpi8yubvqonn4yEJHUhAr4mzosH60J6FCPzjzEwAksfKiNZtMjWtUdlslIPnP+8brC8CAyt8gvgwSDdAh06U1Q3MiJU321nmYzx1UtC2m93hP6HJ6tHNxYo/GBKC7UGVRPB5WGv60SyTRR5UxU1SD/u0W1BIhEbt9GxbjEe1SSgGErXlHi6eOXHzRcF5NM55VLLbxS5UNQZ9MxuGsoJNScEkxOMPKtKTYqz3/dlKvLozSx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(26005)(6916009)(66946007)(66476007)(66556008)(66446008)(64756008)(54906003)(76116006)(316002)(83380400001)(2616005)(1076003)(4326008)(5660300002)(478600001)(6506007)(86362001)(8676002)(122000001)(71200400001)(8936002)(6486002)(2906002)(38070700005)(38100700002)(36756003)(6512007)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGgxcEE4ZXZOaUhmV2xJQ0Q2M2MyOGRHdUg4bDM4bnF3M09wZGdUWWRacnBN?=
 =?utf-8?B?NyttL2pjYW91UUx0WC9tWitWc2hoWFY4OXpab0xuTGZDSXlMOUtQaXBvRkdw?=
 =?utf-8?B?TE5OcmxPOHdtdjBaN3dSbWRybHo4L2JUaDNnQ0VSOVNxK0RYYmYveVVsWFhJ?=
 =?utf-8?B?a2o1MFI2SkN1ZmhOQi9mcGhJRFNraUJFL3Q2aTVqLzBpRHVmb3duQkVaSEgr?=
 =?utf-8?B?Y3lnZkpKdGNKZWlHUmZqUjI2RmNvQlpIVndrM0dkSUxNNktGMHRDRkxIMGlW?=
 =?utf-8?B?eTRRYnh0VlZuR3FTNkp6TE52UFN5Z3hiblMwRU1uaDZkVm5tYjZSQWh2cTk2?=
 =?utf-8?B?blNtZWxrNVRCVitJdjZacjZOSFgxdUo4Z1poVVdEYVNQbUd4L09yMnhUTVpo?=
 =?utf-8?B?ZHM1b1FNRmxUY1VYMHVDYjd2bStCeHhNU2xqcDlreUNrYmJTOCtvZnExbGZn?=
 =?utf-8?B?eStmMU1rSi9hdTFmd1RaL01BVG1MRi9wbXR5T0k4UTdsVzllb0gxV3lZaGd4?=
 =?utf-8?B?TFQ4dy92R3R5bG5FaGxxVnZCQlVGRzdWUFB6SSsyYlo1MytzaVlBZmRheW1U?=
 =?utf-8?B?NWp4ejBkbWJIR2tNd2dzWGNnY1gzV05tM0p4OHZpTEFFV3BFL3M5czhodEZD?=
 =?utf-8?B?YjlHL0R1MEFFcjVNT0Z3UXpJY1RSZG9RVWZoYWMxL1p1WGJpQlB3ZzUyemZU?=
 =?utf-8?B?TDEzY0xBUi9IeUpUZEYwWENnT0EwWW9vSTVzVzlPYTEydFRrOTJPQlZPS3Zt?=
 =?utf-8?B?eStoQWRPdE1xbkZKaTcxdndDajg2eTlybmZscC9GZWRDd1gzdkR1bUJqUzJt?=
 =?utf-8?B?SkpVbjBnb24xUkxxU3paZ0pvMWpCVklOa3BQRFhXL1UyNzNjMDNDa2I2U2tM?=
 =?utf-8?B?eks3RkYrbTRqNFFmMmZzVFRMd3hjZ2xXYm9HMDhrRTRIREZmckVYaExkOUpy?=
 =?utf-8?B?RmR4dWpaVXdBR1N1SklGODF4eklQSFhvcjl3ZnQvUmNTcWpzZE9iTEFVMUZQ?=
 =?utf-8?B?ZXZiNGNsYXBaVDVMWVo2V3Y3UTZkNXNuWmFmblI3eUdnenVnY0p1T3lHTTlx?=
 =?utf-8?B?RmowLzdnNXBkRkZtOVNGd3Z1ajFrOGJHV0JYNVRvQnErV2JUWmxUSTF4MXJt?=
 =?utf-8?B?VEpZckZUV2t6d1NPa3g4TEROc2cwR3FhcGdjTWdOdTNYVCtnZDdNbW82T0Ro?=
 =?utf-8?B?cUl4SFUrenBDV29OSHdHNHlVZTVSYTJwc3hMWDZaT0ppdGtmc1R6UVp1Q1po?=
 =?utf-8?B?WDlrOUs2UFhFWDhtNHFVenM4R0MzVG9IL2UveEpnYkpHOENTbjJ4a2JSc2pu?=
 =?utf-8?B?VEZJWFdKL1FsaVZXTGt5c3dTNTA1UmNqSzNGWkd2b1NTS05kN1FHanFKbkln?=
 =?utf-8?B?eUxqM3FMdFVLVVFxeVZQZnY1OUdwNFNJazM1NDkrWWM2VVpXRndBTytReGNR?=
 =?utf-8?B?LzR2YXpURXF5aWR0Rlp2UjJrQy9XTGxMRnpuYVNuYUFXUDV4OHdCZzNRb1ZV?=
 =?utf-8?B?K21sTWMvb1hpWC92MUhsTWViZjB6c0x4VWErdUVNK0kwMlZxQW9aMEpTVFRW?=
 =?utf-8?B?eGh0STJIZEJYSTB5cnI2TVo4eU00Ym5ESFQrRlFaTFc3ckxzSGxHT0xOQjNK?=
 =?utf-8?B?YUdXQU1iS21hOVdGeENhM3N3RHZYNUMyNlZka0tiMjdvOUFnQnM1bitnNS9K?=
 =?utf-8?B?T3lvZSsxNVVrL3A0QVVIUU5pL0VxMGl6QjhoRUZEWStma0RZSEtvbTJXZzht?=
 =?utf-8?B?WmwxV3VSRFpKenloZnd4bWtoeWJBb1Z5Sitob28waHczTTdCdzZvbUx2VGky?=
 =?utf-8?B?T1FqUVlkQWpUNSt1L2wzWlhubktrQTRUOFppdnN0MHdVTG5sem8yYkZOU2dJ?=
 =?utf-8?B?UFpXMDJweW0ycjhFdExKdXF6dW94OWFEejJjSFNBcFZZdURwWkxNM0E2MHN0?=
 =?utf-8?B?MEpGSGh4UTZvQlJLNFBuWWg1VS9tZFcvSkUzampTMkZJVUFnQmRWeGt1dmE2?=
 =?utf-8?B?R21yUDRlQnB4NkIxRWJWUkpvMStzMi9tSHEzZWQ5d3NGR296OFE1Q1ozZXk3?=
 =?utf-8?B?emI4NzlPak43bUNFa2VsVkZ6czZvWVB4QlB2bmk3UjdveDIwVzBWZnFBUFJ4?=
 =?utf-8?B?R1R4N3g2MzNEZm54cHBSQm1DY1BUOFR5TXRaR1BlUVltNCtCOEZIaFVBZWxi?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0601EBFFFF14F94D9531A95C3E533C4E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OUPrjVlLcxHE1aosvkGSkszTygQGH6U5+mdBX1mCWF3L5y5HeJCqrMIcILrstNHwRoHOyyrw0pEPkp/9hwoIfXaeedAQN+4NA010yLSElnhRPCGACH7RcDBuNibrPJVTnnIDGMnQvspoPKxr4MMEx2oQGQjA3aHRDaNIBV9A2cZVfpxKEMJbO8w9LbZQHLiOhgMSNvTs1c+ZobnPF/jdAWeZdFe5tGJybF6jUnbFiypAGa3TJgZirAkarB/PMNiUrqbI28CLqYwlfdEtwCRymgn1Sp+3eRoYfKWbX2aokvG+Xfwcx7d9bFIiGZEY0jpIIkO1xTPIKTw1LUvJGpnGw7t11MtquqLOWvecbEP8rMuUU1/AZNTLYVCvii4SXFcmTZtJRjv1T5+3AGNGaUo6WIocX9jdwFzfkfK9/jx9WnM2YaaIcEpkMD2T64EOofcF5pqcyiPmQ56rAEEBtFBbQRAX4zMJX9vaQ2FQo+eY9kRPNZMaxOZf4SlD3LkKQ6EQuA/1GSbBFXvj7CbnK2/jtg1cpHLD07Mnq1EVe2/QcYtFEuc+R9g6moPsqoYzq3sOMPjKQNKxikA0fiklITd4Nse5nawy/SSsiADSIwVibOv0icJ2kbRALo9mNcJEFNcnqgheDqTnfRwEyFOM6cTZhLtT9PxZExnFp2F04njb58Z7egMAPL+d+vRWzyRek2q8TZ99Bxi9rqiZ2uVd3KCahHMWR+VN9lTDw4GIR2U6uGQ54fKsjptAhOWEYB5lYn1qb23zWLS5424pBPeDpTZJNZjVLZSMwW486T0mHdGnhN8/5n41Y0E6CVqKRw0+STlhCb/klQLzCiKFrPBvdtIxjLrlYvkd90TLEoX/wT1y1ADqIC4A9CwQ5SI7GSK9wxC+QABD7zrglMg4I1eBBeemKQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8953f28a-389a-4409-0f69-08dbcb4cfb0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 17:59:29.2430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8lwgyp050iqzq/qe3BLKCzEfPXPTNpE8MVaOi8zYKd9izlamZMPMNUHiFnMlH8wmKE+GKtjA9f1V3V5Igo5trg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572
X-Proofpoint-ORIG-GUID: xn3xCT831ymknBkvT0wQ4Q5ckBe9-EWV
X-Proofpoint-GUID: xn3xCT831ymknBkvT0wQ4Q5ckBe9-EWV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_09,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 clxscore=1011 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBPY3QgMTEsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IFRoaXMgaW1w
bGVtZW50YXRpb24gaXMgdG8gZml4IFJBTSBpbnRlcmZhY2UgZ2V0dGluZyBzdHVjayBkdXJpbmcN
Cj4gZW51bWVyYXRpb24gYW5kIGNvbnRyb2xsZXIgbm90IHJlc3BvbmRpbmcgdG8gYW55IGNvbW1h
bmQuDQo+IA0KPiBEdXJpbmcgcGx1Zy1vdXQgdGVzdCBjYXNlcywgaXQgaXMgc29tZXRpbWVzIHNl
ZW4gdGhhdCBubyBldmVudHMNCj4gYXJlIGdlbmVyYXRlZCBieSB0aGUgY29udHJvbGxlciBhbmQg
YWxsIENTUiByZWdpc3RlciByZWFkcyBnaXZlICIwIg0KPiBhbmQgQ1NSX1RpbWVvdXQgYml0IGdl
dHMgc2V0IGluZGljYXRpbmcgdGhhdCBDU1IgcmVhZHMvd3JpdGVzIGFyZQ0KPiB0aW1pbmcgb3V0
IG9yIHRpbWVkIG91dC4NCj4gDQo+IFRoZSBpc3N1ZSBjb21lcyB1cCBvbiBkaWZmZXJlbnQgaW5z
dG5hY2VzIG9mIGVudW1lcmF0aW9uIG9uIGRpZmZlcmVudA0KPiBwbGF0Zm9ybXMuIE9uIG9uZSBw
bGF0Zm9ybSwgdGhlIGRlYnVnIGxvZyBpcyBhcyBmb2xsb3dzOg0KPiANCj4gUHJlcGFyZWQgYSBU
UkIgb24gZXAwb3V0IGFuZCBkaWQgc3RhcnQgdHJhbnNmZXIgdG8gZ2V0IHNldA0KPiBhZGRyZXNz
IHJlcXVlc3QgZnJvbSBob3N0Og0KPiANCj4gPC4uLj4tNzE5MSAgICBbMDAwXSBELi4xLiAgICA2
Ni40MjEwMDY6IGR3YzNfZ2FkZ2V0X2VwX2NtZDogZXAwb3V0Og0KPiBjbWQgJ1N0YXJ0IFRyYW5z
ZmVyJyBbNDA2XSBwYXJhbXMgMDAwMDAwMDAgZWZmZmEwMDAgMDAwMDAwMDAgLS0+DQo+IHN0YXR1
czogU3VjY2Vzc2Z1bA0KPiANCj4gPC4uLj4tNzE5MSAgICBbMDAwXSBELi4xLiAgICA2Ni40MjEx
OTY6IGR3YzNfZXZlbnQ6IGV2ZW50ICgwMDAwYzA0MCk6DQo+IGVwMG91dDogVHJhbnNmZXIgQ29t
cGxldGUgKHNJTCkgW1NldHVwIFBoYXNlXQ0KPiANCj4gPC4uLj4tNzE5MSAgICBbMDAwXSBELi4x
LiAgICA2Ni40MjExOTc6IGR3YzNfY3RybF9yZXE6IFNldA0KPiBBZGRyZXNzKEFkZHIgPSAwMSkN
Cj4gDQo+IFRoZW4gWEZFUiBOUkRZIHJlY2VpdmVkIG9uIGVwMGluIGZvciB6ZXJvIGxlbmd0aCBz
dGF0dXMgcGhhc2UgYW5kDQo+IGEgU3RhcnQgVHJhbnNmZXIgd2FzIGRvbmUgb24gZXAwaW4gd2l0
aCAwLWxlbmd0aCBwYWNrZXQgaW4gMiBTdGFnZQ0KPiBzdGF0dXMgcGhhc2U6DQo+IA0KPiA8Li4u
Pi03MTkxICAgIFswMDBdIEQuLjEuICAgIDY2LjQyMTI0OTogZHdjM19ldmVudDogZXZlbnQgKDAw
MDAyMGMyKToNCj4gZXAwaW46IFRyYW5zZmVyIE5vdCBSZWFkeSBbMDAwMDAwMDBdIChOb3QgQWN0
aXZlKSBbU3RhdHVzIFBoYXNlXQ0KPiANCj4gPC4uLj4tNzE5MSAgICBbMDAwXSBELi4xLiAgICA2
Ni40MjEyNjY6IGR3YzNfcHJlcGFyZV90cmI6IGVwMGluOiB0cmINCj4gZmZmZmZmYzAwZmNmZDAw
MCAoRTA6RDApIGJ1ZiAwMDAwMDAwMGVmZmZhMDAwIHNpemUgMCBjdHJsIDAwMDAwYzMzDQo+IHNv
Zm4gMDAwMDAwMDAgKEhMY3M6U0M6c3RhdHVzMikNCj4gDQo+IDwuLi4+LTcxOTEgICAgWzAwMF0g
RC4uMS4gICAgNjYuNDIxMzg3OiBkd2MzX2dhZGdldF9lcF9jbWQ6IGVwMGluOiBjbWQNCj4gJ1N0
YXJ0IFRyYW5zZmVyJyBbNDA2XSBwYXJhbXMgMDAwMDAwMDAgZWZmZmEwMDAgMDAwMDAwMDAgLS0+
c3RhdHVzOg0KPiBTdWNjZXNzZnVsDQo+IA0KPiBUaGVuIGEgYnVzIHJlc2V0IHdhcyByZWNlaXZl
ZCBkaXJlY3RseSBhZnRlciA1MDAgbXNlYy4gU29mdHdhcmUgbmV2ZXINCj4gZ290IHRoZSBjbWQg
Y29tcGxldGUgZm9yIHRoZSBzdGFydCB0cmFuc2ZlciBkb25lIGluIHN0YXR1cyBwaGFzZS4gSGVy
ZQ0KPiB0aGUgUkFNIGludGVyZmFjZSBpcyBzdHVjay4gU28gaG9zdCBpc3N1ZXMgYSBidXMgcmVz
ZXQgYXMgbGluayBpcw0KPiBpZGxlIGZvciA1MDAgbXNlYzoNCj4gDQo+IDwuLi4+LTcxOTEgICAg
WzAwMF0gRC4uMS4gICAgNjYuOTM1NjAzOiBkd2MzX2V2ZW50OiBldmVudCAoMDAwMDAxMDEpOg0K
PiBSZXNldCBbVTBdDQo+IA0KPiBUaGVuIHNvZnR3YXJlIHNlZXMgdGhhdCBpdCBpcyBpbiBzdGF0
dXMgcGhhc2UgYW5kIHdlIGlzc3VlIGFuIEVORFhGRVINCj4gb24gZXAwaW4gYW5kIGl0IGdldHMg
dGltZWRvdXQgd2FpdGluZyBmb3IgdGhlIENNREFDVCB0byBnbyAnMCc6DQo+IA0KPiA8Li4uPi03
MTkxICAgIFswMDBdIEQuLjEuICAgIDY2Ljk1ODI0OTogZHdjM19nYWRnZXRfZXBfY21kOiBlcDBp
bjogY21kDQo+ICdFbmQgVHJhbnNmZXInIFsxMDUwOF0gcGFyYW1zIDAwMDAwMDAwIDAwMDAwMDAw
IDAwMDAwMDAwIC0tPiBzdGF0dXM6DQo+IFRpbWVkIE91dA0KPiANCj4gVXBvbiBkZWJ1ZyB3aXRo
IFN5bm9wc3lzLCBpdCB0dXJucyBvdXQgdGhhdCB0aGUgcm9vdCBjYXVzZSBpcyBhcw0KPiBmb2xs
b3dzOg0KPiANCj4gRHVyaW5nIGFueSB0cmFuc2ZlciwgaWYgdGhlIGRhdGEgaXMgbm90IHN1Y2Nl
c3NmdWxseSB0cmFuc21pdHRlZCwNCj4gdGhlbiBhIERvbmUgKHdpdGggZmFpbHVyZSkgaGFuZHNo
YWtlIGlzIHJldHVybmVkLCBzbyB0aGF0IHRoZSBCTVUNCj4gY2FuIHJlLWF0dGVtcHQgdGhlIHNh
bWUgZGF0YSBhZ2FpbiBieSByZXdpbmRpbmcgaXRzIGRhdGEgcG9pbnRlcnMuDQo+IA0KPiBCdXQs
IGlmIHRoZSBVU0IgSU4gaXMgYSAwLWxlbmd0aCBwYXlsb2FkICh3aGljaCBpcyB3aGF0IGlzIGhh
cHBlbmluZw0KPiBpbiB0aGlzIGNhc2UgLSAyIHN0YWdlIHN0YXR1cyBwaGFzZSBvZiBzZXRfYWRk
cmVzcyksIHRoZW4gdGhlcmUgaXMgbm8NCj4gbmVlZCB0byByZXdpbmQgdGhlIHBvaW50ZXJzIGFu
ZCB0aGUgRG9uZSAod2l0aCBmYWlsdXJlKSBoYW5kc2hha2UgaXMNCj4gbm90IHJldHVybmVkIGZv
ciBmYWlsdXJlIGNhc2UuIFRoaXMga2VlcHMgdGhlIFJlcXVlc3QtRG9uZSBpbnRlcmZhY2UNCj4g
YnVzeSB0aWxsIHRoZSBuZXh0IERvbmUgaGFuZHNoYWtlLiBUaGUgTUFDIHNlbmRzIHRoZSAwLWxl
bmd0aCBwYXlsb2FkDQo+IGFnYWluIHdoZW4gdGhlIGhvc3QgcmVxdWVzdHMuIElmIHRoZSB0cmFu
c21pc3Npb24gaXMgc3VjY2Vzc2Z1bCB0aGlzDQo+IHRpbWUsIHRoZSBEb25lICh3aXRoIHN1Y2Nl
c3MpIGhhbmRzaGFrZSBpcyBwcm92aWRlZCBiYWNrLiBPdGhlcndpc2UsDQo+IGl0IHJlcGVhdHMg
dGhlIHNhbWUgc3RlcHMgYWdhaW4uDQo+IA0KPiBJZiB0aGUgY2FibGUgaXMgZGlzY29ubmVjdGVk
IG9yIGlmIHRoZSBIb3N0IGFib3J0cyB0aGUgdHJhbnNmZXIgb24gMw0KPiBjb25zZWN1dGl2ZSBm
YWlsZWQgYXR0ZW1wdHMsIHRoZSBSZXF1ZXN0LURvbmUgaGFuZHNoYWtlIGlzIG5vdA0KPiBjb21w
bGV0ZS4gVGhpcyBrZWVwcyB0aGUgaW50ZXJmYWNlIGJ1c3kuDQo+IA0KPiBUaGUgc3Vic2VxdWVu
dCBSQU0gYWNjZXNzIGNhbm5vdCBwcm9jZWVkIHVudGlsIHRoZSBhYm92ZSBwZW5kaW5nDQo+IHRy
YW5zZmVyIGlzIGNvbXBsZXRlLiBUaGlzIHJlc3VsdHMgaW4gZmFpbHVyZSBvZiBhbnkgYWNjZXNz
IHRvIFJBTQ0KPiBhZGRyZXNzIGxvY2F0aW9ucy4gTWFueSBvZiB0aGUgRW5kUG9pbnQgY29tbWFu
ZHMgbmVlZCB0byBhY2Nlc3MgdGhlDQo+IFJBTSBhbmQgdGhleSB3b3VsZCBmYWlsIHRvIGNvbXBs
ZXRlIHN1Y2Nlc3NmdWxseS4NCj4gDQo+IEZ1cnRoZXJtb3JlIHdoZW4gY2FibGUgcmVtb3ZhbCBo
YXBwZW5zLCB0aGlzIHdvdWxkIG5vdCBnZW5lcmF0ZSBhDQo+IGRpc2Nvbm5lY3QgZXZlbnQgYW5k
IHRoZSAiY29ubmVjdGVkIiBmbGFnIHJlbWFpbnMgdHJ1ZSBhbHdheXMgYmxvY2tpbg0KPiBzdXNw
ZW5kLg0KPiANCj4gU3lub3BzeXMgY29uZmlybWVkIHRoYXQgdGhlIGlzc3VlIGlzIHByZXNlbnQg
b24gYWxsIFVTQjMgZGV2aWNlcyBhbmQNCj4gYXMgYSB3b3JrYXJvdW5kLCBzdWdnZXN0ZWQgdG8g
cmUtaW5pdGlhbGl6ZSBkZXZpY2UgbW9kZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtyaXNobmEg
S3VyYXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91
c2IvZHdjMy9jb3JlLmMgICB8IDIwICsrKysrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuaCAgIHwgIDQgKysrKw0KPiAgZHJpdmVycy91c2IvZHdjMy9kcmQuYyAgICB8
ICA1ICsrKysrDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgIDYgKysrKy0tDQo+ICA0
IGZpbGVzIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuYw0KPiBpbmRleCA0NGVlODUyNmRjMjguLmQxOGI4MWNjY2RjNSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMN
Cj4gQEAgLTEyMiw2ICsxMjIsNyBAQCBzdGF0aWMgdm9pZCBfX2R3YzNfc2V0X21vZGUoc3RydWN0
IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICAJaW50IHJl
dDsNCj4gIAl1MzIgcmVnOw0KPiArCXU4IHRpbWVvdXQgPSAxMDA7DQo+ICAJdTMyIGRlc2lyZWRf
ZHJfcm9sZTsNCj4gIA0KPiAgCW11dGV4X2xvY2soJmR3Yy0+bXV0ZXgpOw0KPiBAQCAtMTM3LDYg
KzEzOCwyNSBAQCBzdGF0aWMgdm9pZCBfX2R3YzNfc2V0X21vZGUoc3RydWN0IHdvcmtfc3RydWN0
ICp3b3JrKQ0KPiAgCWlmICghZGVzaXJlZF9kcl9yb2xlKQ0KPiAgCQlnb3RvIG91dDsNCj4gIA0K
PiArCS8qDQo+ICsJICogU1RBUiA1MDAxNTQ0IC0gSWYgY2FibGUgZGlzY29ubmVjdCBkb2Vzbid0
IGdlbmVyYXRlDQo+ICsJICogZGlzY29ubmVjdCBldmVudCBpbiBkZXZpY2UgbW9kZSwgdGhlbiBy
ZS1pbml0aWFsaXplIHRoZQ0KPiArCSAqIGNvbnRyb2xsZXIuDQo+ICsJICovDQo+ICsJaWYgKChk
d2MtPmNhYmxlX2Rpc2Nvbm5lY3RlZCA9PSB0cnVlKSAmJg0KPiArCQkoZHdjLT5jdXJyZW50X2Ry
X3JvbGUgPT0gRFdDM19HQ1RMX1BSVENBUF9ERVZJQ0UpKSB7DQo+ICsJCXdoaWxlIChkd2MtPmNv
bm5lY3RlZCA9PSB0cnVlICYmIHRpbWVvdXQgIT0gMCkgew0KPiArCQkJbWRlbGF5KDEwKTsNCj4g
KwkJCXRpbWVvdXQtLTsNCj4gKwkJfQ0KPiArDQo+ICsJCWlmICh0aW1lb3V0ID09IDApIHsNCj4g
KwkJCWR3YzNfZ2FkZ2V0X3NvZnRfZGlzY29ubmVjdChkd2MpOw0KPiArCQkJdWRlbGF5KDEwMCk7
DQo+ICsJCQlkd2MzX2dhZGdldF9zb2Z0X2Nvbm5lY3QoZHdjKTsNCj4gKwkJfQ0KPiArCX0NCj4g
Kw0KPiAgCWlmIChkZXNpcmVkX2RyX3JvbGUgPT0gZHdjLT5jdXJyZW50X2RyX3JvbGUpDQo+ICAJ
CWdvdG8gb3V0Ow0KPiAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBi
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IGluZGV4IGM2Yzg3YWNiZDM3Ni4uNzY0MjMzMGNm
NjA4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiArKysgYi9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBAQCAtMTM1NSw2ICsxMzU1LDcgQEAgc3RydWN0IGR3YzMg
ew0KPiAgCWludAkJCWxhc3RfZmlmb19kZXB0aDsNCj4gIAlpbnQJCQludW1fZXBfcmVzaXplZDsN
Cj4gIAlzdHJ1Y3QgZGVudHJ5CQkqZGVidWdfcm9vdDsNCj4gKwlib29sCQkJY2FibGVfZGlzY29u
bmVjdGVkOw0KPiAgfTsNCj4gIA0KPiAgI2RlZmluZSBJTkNSWF9CVVJTVF9NT0RFIDANCj4gQEAg
LTE1NjgsNiArMTU2OSw5IEBAIHZvaWQgZHdjM19ldmVudF9idWZmZXJzX2NsZWFudXAoc3RydWN0
IGR3YzMgKmR3Yyk7DQo+ICANCj4gIGludCBkd2MzX2NvcmVfc29mdF9yZXNldChzdHJ1Y3QgZHdj
MyAqZHdjKTsNCj4gIA0KPiAraW50IGR3YzNfZ2FkZ2V0X3NvZnRfZGlzY29ubmVjdChzdHJ1Y3Qg
ZHdjMyAqZHdjKTsNCj4gK2ludCBkd2MzX2dhZGdldF9zb2Z0X2Nvbm5lY3Qoc3RydWN0IGR3YzMg
KmR3Yyk7DQo+ICsNCj4gICNpZiBJU19FTkFCTEVEKENPTkZJR19VU0JfRFdDM19IT1NUKSB8fCBJ
U19FTkFCTEVEKENPTkZJR19VU0JfRFdDM19EVUFMX1JPTEUpDQo+ICBpbnQgZHdjM19ob3N0X2lu
aXQoc3RydWN0IGR3YzMgKmR3Yyk7DQo+ICB2b2lkIGR3YzNfaG9zdF9leGl0KHN0cnVjdCBkd2Mz
ICpkd2MpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9kcmQuYyBiL2RyaXZlcnMv
dXNiL2R3YzMvZHJkLmMNCj4gaW5kZXggMDM5YmYyNDE3NjlhLi41OTNjMDIzZmMzOWEgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZHJkLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdj
My9kcmQuYw0KPiBAQCAtNDQ2LDYgKzQ0Niw4IEBAIHN0YXRpYyBpbnQgZHdjM191c2Jfcm9sZV9z
d2l0Y2hfc2V0KHN0cnVjdCB1c2Jfcm9sZV9zd2l0Y2ggKnN3LA0KPiAgCXN0cnVjdCBkd2MzICpk
d2MgPSB1c2Jfcm9sZV9zd2l0Y2hfZ2V0X2RydmRhdGEoc3cpOw0KPiAgCXUzMiBtb2RlOw0KPiAg
DQo+ICsJZHdjLT5jYWJsZV9kaXNjb25uZWN0ZWQgPSBmYWxzZTsNCj4gKw0KPiAgCXN3aXRjaCAo
cm9sZSkgew0KPiAgCWNhc2UgVVNCX1JPTEVfSE9TVDoNCj4gIAkJbW9kZSA9IERXQzNfR0NUTF9Q
UlRDQVBfSE9TVDsNCj4gQEAgLTQ1NCw2ICs0NTYsOSBAQCBzdGF0aWMgaW50IGR3YzNfdXNiX3Jv
bGVfc3dpdGNoX3NldChzdHJ1Y3QgdXNiX3JvbGVfc3dpdGNoICpzdywNCj4gIAkJbW9kZSA9IERX
QzNfR0NUTF9QUlRDQVBfREVWSUNFOw0KPiAgCQlicmVhazsNCj4gIAlkZWZhdWx0Og0KPiArCQlp
ZiAocm9sZSA9PSBVU0JfUk9MRV9OT05FKQ0KPiArCQkJZHdjLT5jYWJsZV9kaXNjb25uZWN0ZWQg
PSB0cnVlOw0KPiArDQo+ICAJCWlmIChkd2MtPnJvbGVfc3dpdGNoX2RlZmF1bHRfbW9kZSA9PSBV
U0JfRFJfTU9ERV9IT1NUKQ0KPiAgCQkJbW9kZSA9IERXQzNfR0NUTF9QUlRDQVBfSE9TVDsNCj4g
IAkJZWxzZQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZl
cnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggODU4ZmU0YzI5OWI3Li5hOTJkZjJlMDRjY2Ug
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtMjYzNCw3ICsyNjM0LDcgQEAgc3RhdGljIHZvaWQg
ZHdjM19nYWRnZXRfZGlzYWJsZV9pcnEoc3RydWN0IGR3YzMgKmR3Yyk7DQo+ICBzdGF0aWMgdm9p
ZCBfX2R3YzNfZ2FkZ2V0X3N0b3Aoc3RydWN0IGR3YzMgKmR3Yyk7DQo+ICBzdGF0aWMgaW50IF9f
ZHdjM19nYWRnZXRfc3RhcnQoc3RydWN0IGR3YzMgKmR3Yyk7DQo+ICANCj4gLXN0YXRpYyBpbnQg
ZHdjM19nYWRnZXRfc29mdF9kaXNjb25uZWN0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICtpbnQgZHdj
M19nYWRnZXRfc29mdF9kaXNjb25uZWN0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICB7DQo+ICAJdW5z
aWduZWQgbG9uZyBmbGFnczsNCj4gIAlpbnQgcmV0Ow0KPiBAQCAtMjcwMSw3ICsyNzAxLDcgQEAg
c3RhdGljIGludCBkd2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3Qoc3RydWN0IGR3YzMgKmR3YykN
Cj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3Nv
ZnRfY29ubmVjdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAraW50IGR3YzNfZ2FkZ2V0X3NvZnRfY29u
bmVjdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgew0KPiAgCWludCByZXQ7DQo+ICANCj4gQEAgLTM5
NjMsNiArMzk2Myw3IEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0X2Rpc2Nvbm5lY3RfaW50ZXJy
dXB0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJZHdjM19nYWRnZXRfZGN0bF93cml0ZV9zYWZlKGR3
YywgcmVnKTsNCj4gIA0KPiAgCWR3Yy0+Y29ubmVjdGVkID0gZmFsc2U7DQo+ICsJZHdjLT5jYWJs
ZV9kaXNjb25uZWN0ZWQgPSB0cnVlOw0KPiAgDQo+ICAJZHdjM19kaXNjb25uZWN0X2dhZGdldChk
d2MpOw0KPiAgDQo+IEBAIC00MDM4LDYgKzQwMzksNyBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdl
dF9yZXNldF9pbnRlcnJ1cHQoc3RydWN0IGR3YzMgKmR3YykNCj4gIAkgKi8NCj4gIAlkd2MzX3N0
b3BfYWN0aXZlX3RyYW5zZmVycyhkd2MpOw0KPiAgCWR3Yy0+Y29ubmVjdGVkID0gdHJ1ZTsNCj4g
Kwlkd2MtPmNhYmxlX2Rpc2Nvbm5lY3RlZCA9IGZhbHNlOw0KPiAgDQo+ICAJcmVnID0gZHdjM19y
ZWFkbChkd2MtPnJlZ3MsIERXQzNfRENUTCk7DQo+ICAJcmVnICY9IH5EV0MzX0RDVExfVFNUQ1RS
TF9NQVNLOw0KPiAtLSANCj4gMi40Mi4wDQo+IA0KDQpXZSBjYW4ganVzdCByZXNldCB0aGUgY29u
dHJvbGxlciB3aGVuIHRoZXJlJ3MgRW5kIFRyYW5zZmVyIGNvbW1hbmQNCnRpbWVvdXQgYXMgYSBm
YWlsdXJlIHJlY292ZXJ5LiBObyBuZWVkIHRvIGRvIHdoYXQgeW91J3JlIGRvaW5nIGhlcmUuDQoN
CkJSLA0KVGhpbmg=
