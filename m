Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FCD7D1958
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjJTWyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjJTWyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:54:18 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B88CD6C;
        Fri, 20 Oct 2023 15:54:13 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KHnoom022748;
        Fri, 20 Oct 2023 15:54:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=o5i2jSj+xF8jEqkM/sn9jEBDfDhBgoQ35epEa8o6NvQ=;
 b=CQklfuD43qHpHgXTxt32U+exbvtYguXHDD6RmvF03r+QH9aOuolhmppYUZYFi9YQniKc
 lr3VbrOAgH7xaNjK+hAD0tJpe7IB6oDXQIqOjNQH7BZSi9dZ/eHjnQ/cszdbTEROxL7R
 ZmmeAosQ5cXC7QuT3Ft7b+vvvwFFWBA7UTZLGZF4dynswDbQzhTj17AQSHm9UEKUs4wX
 8xh/iONPPq+VqbUD3UrmkseRggWzZqT158DSnbb+JszOM4wtk8O8SecATy5dyfSKK/ri
 hiyCbgaRpWchbWr5fZpEHg/uZZbvNmwr9PGK/LXoaUJC955doIs8Ev+gEY/9zUBSW+XL rA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3tubyc6mp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 15:54:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1697842449; bh=o5i2jSj+xF8jEqkM/sn9jEBDfDhBgoQ35epEa8o6NvQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=by3+zhWJv6SOKM4ec5zCjLUP/iRGVVDHjhUqpSZn33epWKAMLQxpnY80WKfcyEtOC
         u6gHrb0nOZ7gCFi/yvgNOly7Idft1nVo4cxwOqmM3a9e2aVFUhbbXVyDBxN0xf+DG5
         G5hLGPGs0x+sNuaEqkjVrgRJhzHS7wos0czjU7VF/Dy8jtM/s5CpUob+J0x1LOlxIL
         b2tZzrqr2kH/P+JNgEj1+VY1tGaa8TyNRrxk/klhHyO/QuhEcbQV/0fQrdFk+uaS2w
         MHeTYUMUx21yvRMdDCkeZdAoWeNfcp8EXG9tvy5npQfgsOSS70qTptn2ap9lwOLc1J
         3ELe2h9pf6Mmg==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 21FE44012B;
        Fri, 20 Oct 2023 22:54:09 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5D2BAA0085;
        Fri, 20 Oct 2023 22:54:07 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=bfb0+SqX;
        dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 834244035A;
        Fri, 20 Oct 2023 22:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/ZQronM1SRWkNY847lqkYyDWQ6Q/1mGjmnCLGbS9THHNW3lNHELl4PjirCgPAJmL2h+wC1NNqzb0Rj3+r6vA3VwJ5/j+0KktnhyEDfbjcwLvadM3LWNCsLk1CLy6idjHw6r3055LU8jpJeGu7Sf1kZJ00qyU4+euFIIuM0R8ha+ZcMdUhV/LG5LIrZ/HCJ8JYcETDOuWyA6HAzlk6EQGCNSju8+68MGMGJBBnS70K5gR3e0bozkaYRpBfKWfhDAMQtoktCdYcbpcHvYZ5D6J85Em/yor50ZRUR/vqvufOg49hJoXQE4/qXyUXTnVLG2t8Zox8wS6Ffw2lx1lSx6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5i2jSj+xF8jEqkM/sn9jEBDfDhBgoQ35epEa8o6NvQ=;
 b=n0hh6hDids6iomZYSVyRIbOo7rbcjQSc/B15DHnRm4frCqrazEZtqinQv9KMb5pGsnqQIBmLuJfYvdrRIGL/lTXnYHJGHevMHU3RS/jamiPnO3C6e64tJhzVA1is4WsZJQnQk+wBJnC7v0ylus/BvdAww80P3YRZ1dQmvmkbOrQsiexyJJpgEoJrEO5IqZSdXyuyrqktnnoCJpl365TjQN1oFmlmVzD77W4rTrqDnjCl81pa+K8r2s2RHjGXdSUe/dHcgY/HYXxh2unPCpxZXO5HR25wUu0BsCRLXEkUFQLeKXZk2VkkM4rypIqJkEucz+7Ma9n5XuhwQAMFB61zeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5i2jSj+xF8jEqkM/sn9jEBDfDhBgoQ35epEa8o6NvQ=;
 b=bfb0+SqX8aCFeqwaIXQBPVFG56CiZ194jVNuDWQ+PKz21rnlSQ5skprygWE4yQWzI8crvghencNQfS43QNURmmMKQstk+KvnRP6g+niJw+cKx0fvsRYaH4CnNCBZNfzrMO8qYAIDfh4uAQ3otsY2+CWcow/2jEYC9G5ZaXIhdHc=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY8PR12MB7338.namprd12.prod.outlook.com (2603:10b6:930:52::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 22:54:02 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b63e:67e6:b5fe:a8cb]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b63e:67e6:b5fe:a8cb%3]) with mapi id 15.20.6907.021; Fri, 20 Oct 2023
 22:54:02 +0000
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
Thread-Index: AQHZ/CoP25al8cFBjkKV4rWMrsyj2bBGc0gAgAALIwCAAD0ZAIAAXycAgAP7vYCACEHXgA==
Date:   Fri, 20 Oct 2023 22:54:02 +0000
Message-ID: <20231020225349.ocvyxt5opw4y5bl6@synopsys.com>
References: <20231011100214.25720-1-quic_kriskura@quicinc.com>
 <20231012175912.umc3ugzk4iqwtcp3@synopsys.com>
 <bac414a7-aa2a-4b93-82e0-998002c455e0@quicinc.com>
 <20231012221744.ww2w6febhurvlqi6@synopsys.com>
 <cabf2de7-bde2-4cec-9f99-2cb8c92875a5@quicinc.com>
 <6b2115c2-ddd1-401e-81ef-e998264bfd89@quicinc.com>
In-Reply-To: <6b2115c2-ddd1-401e-81ef-e998264bfd89@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CY8PR12MB7338:EE_
x-ms-office365-filtering-correlation-id: acfc8841-c115-4793-c84e-08dbd1bf74a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KSWO9lyiySGnkwgfsWwUrKHDD3oEyFJ2z/rg/fvnPc/QhxxS6Tz68ZdpT7luxMvyH4uq/LaEqqjSxTSZLZW6e+7kmLLqIgDIHGGvk21TM+a+lDrBOzzFGRGyZaaaOTiXXgk90pqfcngCd90GOAQsLKMhcHJEwHXgs2gXOysO5mm1c6cXe2iB/jU8Ix+R1G3TVN9s+8EYHRB6q9YAwPlseZmhXV2fTVklD631OPmAeGZB2bABM72d0PCIucU/ZsuX7yasASQslMQ0HZGehn5RsMqyHORan//gch8RqqPfG5el0FRSifbjktgkgxfRk4MFx3Yy9FoKPL2/Tym6mP6tkBloeoHolXXiRuN2Yp9oyeQ2jNskL6isjlwcry7+Y84rlV5zVgUtAosoHjK0l8AYd0gfhjscu5R7lFsn2aBMpW4dP3QvdyNHTEIFSkIe7p71ecf2zvWwfqepOznWjPq3fdw6Vat8RlaNDIBeSVeWTLogEUwcHEvb4Q4vwvC+JdBPiQ0tiPLCXqsK1nymOtsTCiVgYQ2mBOuTHJ9sWVesrqPP58EtI1bmgdbps/o0LQ5le3DhdIVqesLMuWLMGTYPM31hAgBlmjdn1iDkIxtc/dvdyHwz4C+txl4Us42C3Jbl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(41300700001)(38070700009)(2906002)(83380400001)(2616005)(8676002)(26005)(1076003)(4326008)(8936002)(36756003)(122000001)(66946007)(64756008)(54906003)(66446008)(66556008)(66476007)(76116006)(478600001)(71200400001)(316002)(6916009)(38100700002)(53546011)(5660300002)(6506007)(6512007)(6486002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SktPUWpHcEY2czFkV2lKVmRNa2dhVDY1azJIM09NTVp1QzEwMXZlbHRJK3d1?=
 =?utf-8?B?NVYrOEYzeFZBNDg2SjhCMXdWdk5JemYvZGpqaXFJQk5ZSmhRdm1qK1RWbUs3?=
 =?utf-8?B?M1ROakwwN3dUTVZTQXNvYmlXa2xJMmhGME5ZUlRQUHR6REZjK0Jka04yNU1Z?=
 =?utf-8?B?OVVoWTkycUdCQ3lVTzBxZlBQYXcyY2tSQlJMejZ2NjdOcFhwR09Ob3lFUW5X?=
 =?utf-8?B?RmY2ZktxemZudFViWWRXK2pwcW5ST1dGNWRuYzYxcjZJcG80UnJmL0dMdk43?=
 =?utf-8?B?eFlSODlZUlowUUFTWFpBZjZna29ydnpDbWsrTXdSYVdkRDFOcGJPU1JKRElY?=
 =?utf-8?B?RnZmaExlbWZCbUVVeG9SOE9CaG9RbEVyN2s4Zy96UG9abDhKT0VTQzZLcS92?=
 =?utf-8?B?RDhXbmREUlhGWW5WOGhuZ2xHUGR0MENoWGpJSndJV3llMEY2RGlQTHpSdlhm?=
 =?utf-8?B?L3FaWER2bmUvNnNPNFluRitXMW5rS0djcG00eW5kazVLUU5PWEFiQVFaTXJR?=
 =?utf-8?B?VDVlMnRucG56RllDTzNGTXhmTGhodFNsNXFyTVphRVBGK1dxTXJ0UFlqbFgw?=
 =?utf-8?B?eDJ6RU53c09ZTGI4UThkZ1V3Mk1KcGVpYWpQamlhdG1VWm9YRi9ERHJKTnB1?=
 =?utf-8?B?VWtlZWcyOHp0RXE0anh1NFVCTnU1eUd2R25Fb0ZTbE1UWS8xTnc1YkhwbzBR?=
 =?utf-8?B?TEw0ekpRZldVdkRUdGo1N1o2YUdSekxZS3Y2V005ZWxFeWpXV1FJdWMvL0tX?=
 =?utf-8?B?cWl6ckZseEVrcFNuMHBxSUhZeG1CWG1OT3RyT3FGYTVHeHRGQzg1TFVvYVFU?=
 =?utf-8?B?cmFscTZ4T2JmS3V2cDU0TWhSdXA2UGxKVkgvZDN5aWpQOHJJRk14L21HMGww?=
 =?utf-8?B?SGtRd2poK1lWTlpNYXdkU0hvczhiaVlYTTNIZkhnM3YwZWEyUXZlZTB6NjdQ?=
 =?utf-8?B?ZENNcE9IVlBleGc5ZWdJMExyQ0FJK3dkOXFOaElpZUkvcDdDTHdycTZxZEtr?=
 =?utf-8?B?Y2FMcEcrcU8zN0lpeHlTaUdzZ3dBMCtEMHQzZ1d5T2pCY0xrVmtHYktTUE9s?=
 =?utf-8?B?NENpSHVGVTk1QUVEZWFrcFJTTzlsVjA0OEc3SDdoTSsrK1ZBdmxaU2VwNnlF?=
 =?utf-8?B?ekdtcjh5SDF0NUVlT3VXN0ZrMDZjNE14blpUNWZ1MnNEWkxKUWw1MGpySXYr?=
 =?utf-8?B?Qm1uV3BDYjR2WURTMUM3VzBSb3dvWkM0ZTFDRDQxbUFDSGgrQkUzZ2dxWFBQ?=
 =?utf-8?B?Y1lzam5XeVVDZmVHc05LcGozQXVncE94R0Y5blZ5MGlvek1tb216L09hcGN4?=
 =?utf-8?B?NjlBaXRJQ29lQm41R1lJR1NxelVlVHVhdzVqMUxvM05obStHVkF6Y3V2bmRy?=
 =?utf-8?B?WXBZYnJZZlBrc0pIZmNPV3ZkelJpanEwdDByWlYvMElzQXFack1SZkY3Y1hr?=
 =?utf-8?B?YWpIVE96Tlh1L3hnTXIwZ0hqSmRyZnpZM1RpZ2VwL3k3Ykc4a1RtSjBzeUZo?=
 =?utf-8?B?WVMzaGlRYTFLZTRXUUJsZUVrSzZVYk5uM0ZDMXdRRUJYMnBDVEg5MTZteXpl?=
 =?utf-8?B?YnZGelNvOUZacVh6T2RiZzZTZHdSOTdaQ1R3cDJ5SmdDcnV1UFFVNDBQUnAv?=
 =?utf-8?B?aTNSVHd5VmpQTHZhTDZ0UU9hT2FiSTg1ZnI2VUplTkd0ZnlsVmxlbTY2TFB4?=
 =?utf-8?B?SXRiNk9laWFNNStOUHRQTDNYQ0puVVpIbVJWb2FLN1p1eU5IWUFXMUIxWHVs?=
 =?utf-8?B?VUJZMVBsRDZEbktMUEVFRTlWQWF6SXBQOTMzQTBDTWNpcnJlTEdobEFTNDFw?=
 =?utf-8?B?L015elRJT1hxbXk3bDcwM2FObThKT2haNFdlQ2pOL3ZQZ3c4VlBXTEVEelha?=
 =?utf-8?B?RlVaMERwK1F3eDBoVFpYQjhhZGhyVXFJYTY5SFQwbE1oSm9zYnBWcTlHUzdT?=
 =?utf-8?B?U2JtaGxVZ1czY3Zibi9lR210czdNWjJ5QTdFak1jcTh6aDBQaHVhT3FXK3JX?=
 =?utf-8?B?QmFrVG9mYjdhZ2x1VFRqS2k4eTZTcWQyNVRmS0pWRnJDRm9ZRllhcHhIMDQ4?=
 =?utf-8?B?aGpEYlB4RmpvWXVwbmIySjVYczA2WjFxOWhLMkxXdVRpZXhXMll4N2VCQTJ5?=
 =?utf-8?B?K1FkVGlzTkd4NTFQMU1HWkxuN2tzRFg1K1c4anhNMHE4SVd3NDRDejY4aWVu?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8832F1D872029143BB76A8547B5B8629@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yJGMBWk6g/9CmVIEVarsUjFuahy8M+cKcVkytVqu/VDyBal7RMiVf2q4fRpqV2BAB0b1EgupI1tj+L1bWmZBvAUo2UKEb31QaCMQi+ecSLEedVJqZ15w2RckQm88QvBuobflR0HM7rVIDAvbGaa8ggHXMR2N2Kt8Xgk0nmiRwwdbolpCwKc0AqlisJ2CJiNqIGWn6mm6yW9eT2qMNOrU0hsoov0j872lJRS7mH3/Ib+y/hL+S2i17aLHQ1lYDSjcrPUjpxP1RI72nflaBkgKzSSS4nIhME27m6PBDXdHWxwsMRA/MQdMexrujGPpWqo8+VNHyriW1IZNZve5jdJFGohKpCpIyIVGiyTqC7mJCbOs9XIvxCK5mxU2SD7a0xAb+lsgHEz6OSPMGdm9zpJfT8nKhDqqW/+7f/bPRUbFF6Pr600LvNX1K2uYynXAnA8V6fgz7SSZu5OJCVdLHTW4axdDO4Y3lCZ3ZZqSAn7OJp+wiwK2PR8ogzxUOtIzcn/bJ3LZhefdShc0YNiBhPhdvIl/WOedo5VGSTcboTuFxwZZg7H9zGD+i2Rs521Cln+SgBXJ2EAthVr4umsPb27k7113EzJzOyZuyEkpe520mYBVyGYrGke5hD5mNXvTU0g1StZ/SMUbRhzvAATQxjaYV6XmhiLR8bxQIpWmmY70GncCC7iDelVbQ4oCMoEUNj+hfH8nbGP9mkfgXaNWP7afLupzu+1JEwuzDVTdcHngdro7Dq4ZkHLFNHCE+K5oVGKHzqvVspTGVcbcucuB4UqzzLtyi3nZ82SMqHSeEwv/rCHr90pRiRDDwVpw0DFucq+3tF4zySiwra3jUZsVqW9aLi3I1snncGGRgUo7UN0qvUFPmmQPTnu9Iq/5rzdPPaAEuMWecUpaVCc3vJFXJWLTwg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acfc8841-c115-4793-c84e-08dbd1bf74a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 22:54:02.8660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TNnjwC9/liaD2z13u3vQwuUWRBz2lIu6RwpHTG5GkBxyzQw2ga15sdbJWOCQURPDEaPmeakEpQfHD38vJ58dJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7338
X-Proofpoint-GUID: BSHJQiNgtX5-SpmrZV0w1K5otCW4QGP8
X-Proofpoint-ORIG-GUID: BSHJQiNgtX5-SpmrZV0w1K5otCW4QGP8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 mlxlogscore=992 spamscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310200194
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCBPY3QgMTUsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gMTAvMTMvMjAyMyA5OjI4IEFNLCBLcmlzaG5hIEt1cmFwYXRpIFBTU05WIHdyb3Rl
Og0KPiA+IA0KPiA+IA0KPiA+IE9uIDEwLzEzLzIwMjMgMzo0NyBBTSwgVGhpbmggTmd1eWVuIHdy
b3RlOg0KPiA+ID4gT24gRnJpLCBPY3QgMTMsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYg
d3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gT24gMTAvMTIvMjAyMyAxMToyOSBQ
TSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gPiA+IC1zdGF0aWMgaW50
IGR3YzNfZ2FkZ2V0X3NvZnRfZGlzY29ubmVjdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+ID4gPiA+
ID4gK2ludCBkd2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3Qoc3RydWN0IGR3YzMgKmR3YykNCj4g
PiA+ID4gPiA+IMKgwqAgew0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcg
ZmxhZ3M7DQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqAgaW50IHJldDsNCj4gPiA+ID4gPiA+IEBA
IC0yNzAxLDcgKzI3MDEsNyBAQCBzdGF0aWMgaW50DQo+ID4gPiA+ID4gPiBkd2MzX2dhZGdldF9z
b2Z0X2Rpc2Nvbm5lY3Qoc3RydWN0IGR3YzMgKmR3YykNCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDC
oCByZXR1cm4gcmV0Ow0KPiA+ID4gPiA+ID4gwqDCoCB9DQo+ID4gPiA+ID4gPiAtc3RhdGljIGlu
dCBkd2MzX2dhZGdldF9zb2Z0X2Nvbm5lY3Qoc3RydWN0IGR3YzMgKmR3YykNCj4gPiA+ID4gPiA+
ICtpbnQgZHdjM19nYWRnZXRfc29mdF9jb25uZWN0KHN0cnVjdCBkd2MzICpkd2MpDQo+ID4gPiA+
ID4gPiDCoMKgIHsNCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoCBpbnQgcmV0Ow0KPiA+ID4gPiA+
ID4gQEAgLTM5NjMsNiArMzk2Myw3IEBAIHN0YXRpYyB2b2lkDQo+ID4gPiA+ID4gPiBkd2MzX2dh
ZGdldF9kaXNjb25uZWN0X2ludGVycnVwdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+ID4gPiA+ID4g
wqDCoMKgwqDCoMKgIGR3YzNfZ2FkZ2V0X2RjdGxfd3JpdGVfc2FmZShkd2MsIHJlZyk7DQo+ID4g
PiA+ID4gPiDCoMKgwqDCoMKgwqAgZHdjLT5jb25uZWN0ZWQgPSBmYWxzZTsNCj4gPiA+ID4gPiA+
ICvCoMKgwqAgZHdjLT5jYWJsZV9kaXNjb25uZWN0ZWQgPSB0cnVlOw0KPiA+ID4gPiA+ID4gwqDC
oMKgwqDCoMKgIGR3YzNfZGlzY29ubmVjdF9nYWRnZXQoZHdjKTsNCj4gPiA+ID4gPiA+IEBAIC00
MDM4LDYgKzQwMzksNyBAQCBzdGF0aWMgdm9pZA0KPiA+ID4gPiA+ID4gZHdjM19nYWRnZXRfcmVz
ZXRfaW50ZXJydXB0KHN0cnVjdCBkd2MzICpkd2MpDQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDC
oCAqLw0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgIGR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXJz
KGR3Yyk7DQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqAgZHdjLT5jb25uZWN0ZWQgPSB0cnVlOw0K
PiA+ID4gPiA+ID4gK8KgwqDCoCBkd2MtPmNhYmxlX2Rpc2Nvbm5lY3RlZCA9IGZhbHNlOw0KPiA+
ID4gPiA+ID4gwqDCoMKgwqDCoMKgIHJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0RD
VEwpOw0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgIHJlZyAmPSB+RFdDM19EQ1RMX1RTVENUUkxf
TUFTSzsNCj4gPiA+ID4gPiA+IC0tIA0KPiA+ID4gPiA+ID4gMi40Mi4wDQo+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBXZSBjYW4ganVzdCByZXNldCB0aGUgY29udHJvbGxlciB3
aGVuIHRoZXJlJ3MgRW5kIFRyYW5zZmVyIGNvbW1hbmQNCj4gPiA+ID4gPiB0aW1lb3V0IGFzIGEg
ZmFpbHVyZSByZWNvdmVyeS4gTm8gbmVlZCB0byBkbyB3aGF0IHlvdSdyZSBkb2luZyBoZXJlLg0K
PiA+ID4gPiA+IA0KPiA+ID4gPiBIaSBUaGluaCwNCj4gPiA+ID4gDQo+ID4gPiA+IMKgIFRoYXQg
d2FzIHdoYXQgSSBpbml0aWFsbHkgd2FudGVkIHRvIGRvLCBidXQgdGhlcmUgd2VyZSBjb3VwbGUN
Cj4gPiA+ID4gb2YgcmVhc29ucyBJDQo+ID4gPiA+IHdhbnRlZCB0byB0YWtlIHRoaXMgYXBwcm9h
Y2g6DQo+ID4gPiA+IA0KPiA+ID4gPiAxLiBXZSBjYW4ndCBqdXN0IHJlc2V0IHRoZSBjb250cm9s
bGVyIGluIG1pZHN0IG9mDQo+ID4gPiA+IGdhZGdldF9pbnRlcnJ1cHQuIFdlIG5lZWQNCj4gPiA+
ID4gdG8gcHJvY2VzcyBpdCBjb21wbGV0ZWx5IGFuZCB0aGVuIHRha2UgYWN0aW9uLg0KPiA+ID4g
DQo+ID4gPiBZb3UgY2FuIGZsYWcgdGhlIGRyaXZlciBzbyB5b3UgY2FuIGRvIHRoZSB0ZWFyZG93
bi9zb2Z0LXJlc2V0IGF0IHRoZQ0KPiA+ID4gYXBwcm9wcmlhdGUgdGltZS4NCj4gPiA+IA0KPiA+
ID4gPiANCj4gPiA+ID4gMi4gVGhlIGFib3ZlIGxvZyB3YXMgc2VlbiBvbiBRUkQgdmFyaWFudCBv
ZiBTTTg1NTAvU004NjUwIGVhc2lseS4gQnV0IG9uDQo+ID4gPiA+IG90aGVyIHBsYXRmb3JtcyBv
ZiBzYW1lIHRhcmdldHMsIHRoZSBpc3N1ZSBjb21lcyB1cCBhdCBzb21lDQo+ID4gPiA+IG90aGVy
IGluc3RhbmNlcw0KPiA+ID4gPiBvZiBjb2RlLCBhdCBhIHBvaW50IHdoZXJlIG5vIElSUSBpcyBy
dW5uaW5nLiBJbiBzdWNoIGNhc2VzIGl0cw0KPiA+ID4gPiBub3QgcG9zc2libGUNCj4gPiA+ID4g
dG8gYWNjdXJhdGVseSBmaW5kIG91dCBjb2RlIHBvcnRpb25zIGFuZCByZXNldCB0aGUgY29udHJv
bGxlci4gVGhlIHdheSBJDQo+ID4gPiA+IGNvbmZpcm1lZCB0aGF0IGJvdGggcGxhdGZvcm1zIGFy
ZSBoYXZpbmcgdGhlIHNhbWUgaXNzdWUgaXM6DQo+ID4gPiA+IA0KPiA+ID4gPiBhLiBEdXJpbmcg
Y2FibGUgZGlzY29ubmVjdCwgSSBhbSBub3QgcmVjZWl2aW5nIGRpc2Nvbm5lY3QgaW50ZXJydXB0
DQo+ID4gPiA+IGIuIFRoZSByZWcgZHVtcCBpcyBleGFjdGx5IHNhbWUgaW4gYm90aCBjYXNlcyAo
Qk1VIGFzIHdlbGwpDQo+ID4gPiA+IA0KPiA+ID4gPiBTbyBJIGZlbHQgaXQgd2FzIGJldHRlciB0
byBmaXggaXQgZHVyaW5nIGNhYmxlIGRpc2Nvbm5lY3QNCj4gPiA+ID4gYmVjYXVzZSBldmVuIGlm
IHdlDQo+ID4gPiA+IHJlbW92ZSBjYWJsZSwgd2UgYXJlIHN0aWxsIGluIGRldmljZSBtb2RlIG9u
bHkgYW5kIGluIHRoaXMgY2FzZSB3ZSBjYW4NCj4gPiA+ID4gdW5ibG9jayBzdXNwZW5kIGFuZCBh
bHNvIGJyaW5nIGJhY2sgY29udHJvbGxlciB0byBhIGtub3duIHN0YXRlLg0KPiA+ID4gPiANCj4g
PiA+ID4gTGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cyBvbiB0aGUgYWJvdmUuDQo+ID4gPiA+IA0K
PiA+ID4gDQo+ID4gPiBUaGlzIGlzc3VlIGhhcHBlbnMgb3V0c2lkZSBvZiBkaXNjb25uZWN0IHJp
Z2h0PyBEaWQgeW91IGFjY291bnQgZm9yIHBvcnQNCj4gPiA+IHJlc2V0Pw0KPiA+ID4gDQo+ID4g
PiBUaGUgc3ltcHRvbSBzaG91bGQgYmUgdGhlIHNhbWUuIEF0IHNvbWUgcG9pbnQsIGEgY29tbWFu
ZCB3aWxsIGJlIGlzc3VlZC4NCj4gPiA+IElmIGEgY29tbWFuZCB0aW1lZCBvdXQsIHRoZW4gc29t
ZXRoaW5nIGlzIHJlYWxseSB3cm9uZyAoZXNwZWNpYWxseSBFbmQNCj4gPiA+IFRyYW5zZmVyIGNv
bW1hbmQpLiBXZSBjYW4gYXR0ZW1wdCB0byByZWNvdmVyIGJhc2Ugb24gdGhpcyBzeW1wdG9tIHRo
ZW4uDQo+ID4gPiANCj4gPiA+IEFuZCB5b3UgZG9uJ3QgbmVlZCB0byBwb2xsIGZvciB0aW1lb3V0
IGZvciB0aGlzIHNwZWNpZmljIHR5cGUgb2YgZXJyb3IuDQo+ID4gPiBKdXN0IHJlYWQgc29tZSBr
bm93biByZWdpc3RlciBsaWtlIEdTTlBTSUQgdG8gc2VlIGlmIGl0J3MgaW52YWxpZC4NCj4gPiAN
Cj4gPiBIaSBUaGluaCwNCj4gPiANCj4gPiAgwqBZZXMuIEl0IGFjdHVhbGx5IGhhcHBlbnMgYmVm
b3JlIGRpc2Nvbm5lY3QsIGJ1dCBJIHdhcyB0cnlpbmcgdG8gaGFuZGxlDQo+ID4gaXQgZHVyaW5n
IGRpc2Nvbm5lY3QuIEhvdyBhYm91dCBJIGFkZCBhIGNoZWNrIGluIGdhZGdldF9lcF9jbWQgc2F5
aW5nDQo+ID4gdGhhdCBpZiBjbWQgdGltZW91dCBoYXBwZW5zLCB0aGVuIHJlYWQgdGhlIHNucHNp
ZCBhbmQgaWYgaXQgcmVhZHMgYW4NCj4gPiBpbnZhbGlkIHZhbHVlLCB0aGVuIEkgd2lsbCBjYWxs
IHNvZnRfZGlzY29ubmVjdCBmb2xsb3dlZCBieQ0KPiA+IHNvZnRfY29ubmVjdC4gVGhhdCBtdXN0
IGNvdmVyIGFsbCBjYXNlcyA/DQo+ID4gDQo+IEhpIFRoaW5oLA0KPiANCj4gT25lIG1vcmUgZGF0
YXBvaW50IGZvciBwdXR0aW5nIGZvcndhcmQgdGhlIGFib3ZlIG9waW5pb24uIFRoZXJlIGFyZSB0
d28NCj4gdHlwZXMgb2Ygc2l0dWF0aW9ucyBvYnNlcnZlZCBkdXJpbmcgYnVzIHJlc2V0IHdoZW4g
d2UgdHJ5IHRvIGRvIGVuZHhmZXIgb24NCj4gZXAwaW4gZm9sbG93ZWQgYnkgc2V0X3N0YWxsIG9u
IGVwMG91dDoNCj4gDQo+IDEuIElmIHdlIGlzc3VlIGVuZHhmZXIgZm9yIGVwMGluLCBhbmQgaXQg
dGltZXMgb3V0LCB0aGVuIHRoZSBuZXh0IGNvbW1hbmQNCj4gc2V0X3N0YWxsIGlzIHN1Y2Nlc3Nm
dWwgKG9ubHkgYmVjYXVzZSBhbGwgcmVhZHMgZ2l2ZSB6ZXJvIGFuZCBzaW5jZSB3ZSBjaGVjaw0K
PiBmb3IgQ01EQUNUIGJpdCBmb3IgZXAwb3V0IGFmdGVyIHNldHRpbmcgaXQsIGFuZCBzaW5jZSB0
aGUgcmVhZCBvZiBERVBDTUQNCj4gcmVnaXN0ZXIgZ2l2ZXMgIjAiIHdoaWxlIHBvbGxpbmcgZm9y
IGl0LCBzdyBpbmRpY2F0ZWQgdGhhdCBzZXQgc3RhbGwgaXMNCj4gc3VjY2Vzc2Z1bC4gQnV0IHdo
ZW4gd2UgY2hlY2sgR0VWVEFERFIgYXQgdGhpcyBwb2ludCwgYm90aCBBRERSTE8gYW5kIEFERFJI
SQ0KPiByZWFkIHplcm8uDQo+IA0KPiAyLiBJZiByYW0gYWNjZXNzIHRpbWVvdXQgb2NjdXJzIHdo
aWxlIHBvbGxpbmcgZm9yIENNREFDVCBiaXQgYWZ0ZXIgaXNzdWluZw0KPiBlbmR4ZmVyIG9uIGVw
MGluLCB0aGVuIGF0IHRoYXQgaW5zdGFudCwgcG9sbGluZyByZXR1cm5zIHRydWUsIHN3IGluZGlj
YXRlcw0KPiB0aGF0IGVuZHhmZXIgaXMgc3VjY2Vzc2Z1bCBidXQgaW5yZWFsaXR5IHdoZW4gY2hl
Y2tlZCwgR0VWVEFERFIgTE8vSEkgcmVhZA0KPiB6ZXJvLg0KPiANCj4gU28gSSB0aGluayBpdCB3
b3VsZCBiZSBiZXR0ZXIgdG8gY2hlY2sgZm9yIHZhbGlkaXR5IG9mIEdFVkFERFIgcmVnaXN0ZXJz
IGF0DQo+IGVuZCBvZiBnYWRnZXRfZXBfY21kIHRvIGlkZW50aWZ5IGlkIFJBTSBhY2Nlc3MgdGlt
ZW91dCBoYXBwZW5lZCBhbmQgY2FsbA0KPiBzb2Z0X2Rpc2Nvbm5lY3QgZm9sbG93ZWQgYnkgc29m
dF9jb25uZWN0Lg0KPiANCj4gTGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cyBvbiB0aGlzDQo+IA0K
DQpJbiB0aGlzIGNhc2UsIHRoZSBjaGVjayBjYW4gYmUgc2ltcGxlci4gWW91IGNhbiBqdXN0IHJl
YWQgYmFjayBhbmQgY2hlY2sNCmZvciB0aGUgY29tbWFuZCB0eXBlIG9mIERFUENNRCBvciBER0NN
RCB3aGVuIHBvbGxpbmcgZm9yIENNREFDVCB0byBzZWUNCmlmIGl0IG1hdGNoZXMgdGhlIGNvbW1h
bmQgeW91IGluaXRpYXRlZC4gSWYgbm90LCBzb21ldGhpbmcgaXMgd3JvbmcgYW5kDQp5b3UgY2Fu
IHBlcmZvcm0gdGhlIHNvZnQgZGlzY29ubmVjdCBjb25uZWN0IHRvIHJlY292ZXIuDQoNClRoYW5r
cywNClRoaW5o
