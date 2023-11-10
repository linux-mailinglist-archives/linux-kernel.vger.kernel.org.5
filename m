Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7254A7E7799
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345728AbjKJChn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjKJChk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:37:40 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771012715;
        Thu,  9 Nov 2023 18:37:38 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA2anKa024526;
        Thu, 9 Nov 2023 18:37:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Fv/N/d4Il7XSUbRrBAfwNo+prMhdWNA9dRJXMJAQZ7Y=;
 b=fj/urVrBvpQyorIIgJdS07pln9p2fDJI4JIKWMunaV640WszVVjFLhVp9g8IgBLIkMRi
 bxk7wBNx0tGmjObfGMYxze61uziZOt7XpJpdk51I0RM2Izox8J7GHFIZQTJH1SPnFE3L
 u6iBHDu4Y6xvP50t1eOa3WNdBGN1ld617qXl+Rkybu2oKe/xw1u1ntbmjYnslHAH71os
 n575Uw6BkjtzwaSWkcvnVsOaV3Ux2Ym7jB6Omy85rJXwuovSzGDLiPW1eVmqPjR4vZ4Q
 6USE6FDXWudx8mQUjt24K9i99AmRH7FZuD5tlpg/f6IKIodND1x6fX8U9jz/cU9ZGt7j Kw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3u7y3fddtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 18:37:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1699583853; bh=Fv/N/d4Il7XSUbRrBAfwNo+prMhdWNA9dRJXMJAQZ7Y=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Yl368qFbm/wAdhE/HnXiNa3OL4k8FUNeXxWmyQTPPeE3HM1DmLza2us0RmHeiJl9t
         8st1t80zrh7BaQhhFbFJ61R+x2wpCwfQ7t5dPNeCtxktZNo/QUzNUN2zdeqVNVWtS3
         eUoUVw4pqim9PgitkmTCrC6cW37S4k9/2k6W/GhtUG6Y03OZYSXz9vIv6+hei2RReU
         WXyKdAVEbgcLaotcvfJod7G4wpPm/G3jTo3/pa4oWFDQZaptdts56Te0Go51gkz7AX
         5pDGW2FgjVjioJssag24wmleLYYD0z9e4snR8myxvB3J6OhwoEY8Z60eLjJf+MUHE+
         fxlXc1f7H2Y5g==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9EDAD400A2;
        Fri, 10 Nov 2023 02:37:33 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2889DA0269;
        Fri, 10 Nov 2023 02:37:33 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=FKdBGHNg;
        dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6327E40467;
        Fri, 10 Nov 2023 02:37:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBUMaIlMNpgqycsBDGT+yqXPJ/MvM1dtQeiUDPIDViEO6xKDcmddMcpwxBhP4BTjeUiQXvhTQ/0fXwQJkGJZ+NDPVd/HZruG+Pd/rCzRXMLC2vcLFDAzIo9jo5bCpGF3Vrzs1Fa+i41PSQ9y2V1XrTsGIBcJiy8irnMDHejw3eZ6aBJ85vnApIFIw1M5qvWGwgoPzTjbkWzX35W6Indf7CFqSLVbAo94lfZuMz8eexi0fiy69PpqcRggeTzPY9sQMF9iDrL/QQ2g2gn26LonCBMwX4j5iYl5lyujIIPP9wZhkXTIlCdjQjPZ1840Qg75/W3kVvSyiyt01c/oZV88TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fv/N/d4Il7XSUbRrBAfwNo+prMhdWNA9dRJXMJAQZ7Y=;
 b=ZiQ0pgelgqEEwdnGNEp6vhljW8jBxesrvg/dAlJxVMYCNrBcIgCO1B5JpJ4r8/lAxNgidv5WzyAwrIsvexwsu3nS1PooP52bcDjvEIf1z4//PViJYnz67YyAt9oIWiiVWHhK51/DfX8OyTREoWujS6MFvPmk03+/MFnFg9VrwKSGAJoiW9g4Fou5BjNzP5GAz7zJ+Hx8TXOpqCj57zzm06RohXf+bIaLo/e8aL0zbdLpL7Qh3g0QeeuKxriLjkL44JwxkjfbhlX+6mcpLsALwu1otTaCpgA25RRxvUIx885T6emCB9wMyeS7EJ9uW0kkVnDx4LDMP/VwHQsR8wjb8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fv/N/d4Il7XSUbRrBAfwNo+prMhdWNA9dRJXMJAQZ7Y=;
 b=FKdBGHNgt6sgHnZzh9Lvm1roIS6DV4JXl4UwX9FW0Ca2l8ST//LY6VAUORiD38TQ1drOYEhi7unag3+dXJAQsapNU0OVFHzMkHoyAYUxu+vjPcGWEBQhd73a9PiNxw1lFcazray7sVgZWHlIzVP4NB3FS0yZcCOZJXlHlu0QIs4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 02:37:29 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 02:37:28 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     "Mehta, Piyush" <piyush.mehta@amd.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Subject: Re: [PATCH] usb: dwc3: core: enable CCI support
Thread-Topic: [PATCH] usb: dwc3: core: enable CCI support
Thread-Index: AQHZ/ZcFv/K9cjDJNkagq5mdTaNI2bBTW6qAgBoZHgCABY23gA==
Date:   Fri, 10 Nov 2023 02:37:28 +0000
Message-ID: <20231110023725.fotx3bkkei5jkzid@synopsys.com>
References: <20231013053448.11056-1-piyush.mehta@amd.com>
 <20231020231615.w5m2w5bknblpkhyt@synopsys.com>
 <MN2PR12MB43336B903F927A7120A7E09F88AAA@MN2PR12MB4333.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB43336B903F927A7120A7E09F88AAA@MN2PR12MB4333.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CH3PR12MB8583:EE_
x-ms-office365-filtering-correlation-id: 462fde22-e908-45c4-192e-08dbe195fb63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jNtAMYc59EqTs3clDrdtSyogyNTBl3eTh51cgdBw87VemUjABBzm5BX2kLhBeZIM2E0wTcRe0IVFhpj0FRXI0joTm9qvCY5yKr9PgtYutsOT0kkUiQTkDlaB7NVIqqSF0wUGdl0EuXkrD4Guh7Gh/5b7XY92tkEAjf/CJss52IQhuZ1rNGR+fyqR0Ixmu6+a0IUNk4HNRI8ImuPgLNxqsX1tN0cmfEhABfRcL87G5z7natZPshvOmarqBKxqNkl6txzDaVIMh9Nqg67Hp/ULBA1hLpX31pSubMwtdXCUR2Zzkpg0dNSGIzf1dp+Vl9KYe8x7OBOCEb+qBpJhTlJRPPIBxhQZviNa03LEBQDYrf7tfT8cj4lTsvPJZvbrfml8VzUkwjZX1f1VxSlxGN7rSD19GuplwETazMhRPmi8rlIL/RLEnuttTeXeWkaIt8NZM3hU1bqmOzw/s8NtpJsqBK+EMj63UNA/eUcnyvgRGTjwkdDLDmTihQ0D2xPU0ZK2yzUBflpb+UQgCUaIpbNbGLw9vbq3XWr3AcOqFs1keP//0qLEezO3dlNWnM8H3iuMK8Eo/8GF7IcootDhb+IuOwf15xOr+DMkNOF9M2EEais=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(38100700002)(2906002)(4326008)(8936002)(41300700001)(86362001)(5660300002)(8676002)(122000001)(76116006)(6512007)(2616005)(1076003)(66556008)(54906003)(38070700009)(66946007)(64756008)(66476007)(6916009)(66446008)(83380400001)(53546011)(71200400001)(316002)(6506007)(26005)(478600001)(966005)(36756003)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFhzcHBUQnJ2RHFTNUg1bldNcjNmZVY4aHpVbk1yTDFudkVvTjJ6QkZoVk9v?=
 =?utf-8?B?bExyS3NnTFJaTFNULzcvSGptbzJtc0QzUUpkMTdkNEV3YjExeXhoUGxXS05m?=
 =?utf-8?B?U2FUOXEzZzRXWjk4RzdHWUEwOFBIOFh2VDYvbmtxVWo4Tm5VR0xlWHRuQ1pt?=
 =?utf-8?B?NlZWWktwTXh4MVpmc0lVMjBEWHY2RFR5S3M0VmdCSVBXY250SUZ1WlpPUkc4?=
 =?utf-8?B?MzVycjAyMW13WUo0Z2U5YmNWaUd6Q2RKcnByWENxeEJWalNBWTZ3S1FHNnhG?=
 =?utf-8?B?anFJS0p2blJRMzdDOWM0L1J1eEVKN2p3OG0wNWNrdld3eW1yVG9kTzdZMkNi?=
 =?utf-8?B?ZEt6cEZtSjNrcXF0WTBFNlhUQ0VDcmdNWitNbExjUEtoc0dsUi84ZDZVQnZw?=
 =?utf-8?B?MEtzWHhjWTF3QVNmNkk5UCt1MFhpcDNoNGdlelREMk9ncU92QW1oRmJtUUdF?=
 =?utf-8?B?NDdMM3kzTi8wNUk0STVXVUs4K0pqbXNtTGFoaW0ra2htTlRzSkV1Y2M0T1RX?=
 =?utf-8?B?RVVmMWozeCtjdk1mTlhEWmR4UEdIYlEyT3FmTGo0ME55Tkd0YjRiUG9sd21z?=
 =?utf-8?B?R0lJZ3YrUzFMbVo1Q3VQVXNVM0JvSlB0OSswa1dDdG1CWUNBa2NjOUFZbUVk?=
 =?utf-8?B?N1NsT1UreTZ4b01RM0dxdGlNVlRPNWFYUUNSYUtkTmgvQzV2aFFWRzN0bUtK?=
 =?utf-8?B?dTJ6TllISzh3bjFQcjFmUCtRVlAxL0FwQWUwSDBzcjFGYlkybDVvYncvQ0Q3?=
 =?utf-8?B?Uk1ZQi9DTXJ2MmI1TXRaYnZUSFFNRFpKK0tjOG1nSFJIZDlQRk9zejZDQXJK?=
 =?utf-8?B?RHNhZGFENFE1YWx2S3dzS3hZd0kwMzRDZzBsRXBFR0xHMmF4U2ovZmVWVnJT?=
 =?utf-8?B?R1RPV3F6UWpGWkNTYVprUWlpVStNQ3hwbHhrT0tqMThrc1dUcUxZMmhqaHIz?=
 =?utf-8?B?UXdoUUlRZDRDV201NjhmTVl1TzJ0bEpZYjZtQU9KYStqbDRNVm9ub2xiK2pO?=
 =?utf-8?B?ajJXeGdSK0lUd2JpdnBvSmNOS2RjTmtMRWFIR1FuR2tGRVdKMU9KSnFkZW1Z?=
 =?utf-8?B?M3NkekpuNHVVR1k5UE0vQm12bytkbjY2dlBZeWJtS05VWEh1djhkYzgzUFcv?=
 =?utf-8?B?M2pXM1lYd3g3TTdZdExWeXQ1VlFZUTBEa0E1UG10Y0NaSEtHL1h4SnpmUUJN?=
 =?utf-8?B?bkFySGZYNlB5N0FKVVRyWmdkOHVjcnNydmZmdnB0V09idGFFWE1KWWlNMktj?=
 =?utf-8?B?eXBnU0FLOG5QRkRCdHFEaFNtVXVva1U2T0g1TjBGUlRrZWtMa2FKU05yQ21I?=
 =?utf-8?B?WDE4VHA1MjlyRVdzMG5vSXZLQ0tTdndDV0FWd3QyUW1NTGtMbTJjZWRwL3pR?=
 =?utf-8?B?L0E3L0VFVU52YnRYOU41V01ERHB0RHFwWFNkSGIrTlJGaTYycjI3cW42U2Q0?=
 =?utf-8?B?Y2h1UHVtN0ZYeGl4dFBtMDU5THNWSGkwRXZNV0VYSHdaZjAwZ0RRVDdzdDdF?=
 =?utf-8?B?bDF2d2V6S2VtYmR1b0hXRkpPcnQ5UHltM1VyYjRORFRwR2p4S21ub1YrdGND?=
 =?utf-8?B?d0oxSzBhalNJWVNqSXFlbFZtUERqY1ZnekRhSS9ubVMyN2hSZmJRSm92UDJz?=
 =?utf-8?B?SFFxZUJUMnVDVGR2eWpDb244ZWpFWHdHZE44RFJqZWYzUXBlMnNQVWFxQXdT?=
 =?utf-8?B?SWkxS0hQM0VrYVBDaHErUThiMEtmL3E2SkZPSmo5SU5kVC9hT1pxSmRsVjgy?=
 =?utf-8?B?UWZNQUw2cG5vNDZuM1RYamZ3cER6RUllRkJuNmlRaXlJZFZPdWgzYWJaaWJB?=
 =?utf-8?B?NXpwdGJ0WEgvbVgrZ2MvdzdSMTUxZTdZWVgydjBvUVhJTE1pVjZiM1FjUHVO?=
 =?utf-8?B?bit0cmtqb0svTmVCZFBmWW52UnNTamdZZXZzeW5OZGx3NzVMWXFucllaSWtW?=
 =?utf-8?B?NmtiT1RQVm9LUnlYM3J3UXpGRGdZWC83RlFBcjhnM3ZmMUNNSk9XTGZjQUVC?=
 =?utf-8?B?Z3g3ZEFpblBIb2ZicGp3dHR3Q3ZiU3NEa1ZlOXRmMG5UVlVJRlExb2ZGK2dR?=
 =?utf-8?B?MnpiQkYrRExxaDN2eXI0QmFSWnZvVG5yd2d1azVZNHc2SlZ0RzVkKzdScUx1?=
 =?utf-8?B?dGJka09ZMzVlWGoyUldFSVdXaGVrZmp5RTVPSCtwbWd0TmtDK2pEbWd1eFNF?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <906C5DAC7CE1F64F8D880A2DA3E56221@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iJ9MKAsDN/aYfUWriPoW106yRP+8XK8IdyUkzVLod0gNMea0b4AcCQ38ROdRLwmC8zYGOabQlVRYbEZPVWRNHyEtZOQd2YomL/Tfr3Nds6dXsNE8pm1ut1N356Xc+cIyXquZk+znCqM4EjNuE3jkfdFT2Lkbi10Z/b8OM6Kl6Daqnra45p/TtDzVwlbCTzA8XxAMEucFn0DFl/yZvge/5cOKV68lo4sT0aShKzpK4PDJG56o9ONUv2cAFrCtknJBb1M8qwyPe81L8XHQ2MEfk7k+InJQEzUdjFm5faJY7a8xEttG3CnC8POosSeyQkoz+Rn1sEGOmYxkUOH7NxCUUAv25PGm4fF4ordUQEBuRZNGJ0bCoAA0fbuQTFck2mlKkeKNYL4WPxmHDquTFrXXCuNLFYV8LH+2pje9S/nk0qJ/Zh6xNZar1kPeqi7Sg9paDznaAaWl2lIe6VGebXQK0CaP7YEFIbMJ4GUtKgxJTSDazXb5x8TerAy4pjfSdVzyX+imo0/W62/Bviv5kbmEErWKrd+DkT0Ib1CeEor+RQuac48+WSwUpzuxwISMgi9z+/enrEokYTqanIy8ADFcA0yXlpGodLEFbyx2nZfpfei+PuLByNE7NoyHFLP9tgWGe5nX4JJUZKkmMuWEFXvvEYHLQKzZhKd9xk+RlnKUD/Cwm5SY8gE4GB8g4Pf8yOCRLUmNOVM5YYVGr+NHnsK7IBOw9wv+blw428SAzBDvt/cU94Erb7GDXGjA+uU4eXpi/yaZeD8EDhOfij5g2n82RFbWCxvPGWUzZ9comi6LXGYUGDi1SRnzbyVwFsYNGpAkkJlPAvdHHUgjFcXvVfz3oMuke9EuH7KUnC0dlEW8IvylHCuV+4Zi/TjKXBaelNpE
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 462fde22-e908-45c4-192e-08dbe195fb63
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 02:37:28.6640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sEbaqO5792a6ZXkTNZM04nfBhiV1JLFss/dqZSrqsvcGz4txhO/FaJ8Y541cOKTQ4xbYPDXegVN3DoUpsVk/Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8583
X-Proofpoint-GUID: uHBb-Ryy3yDG3cppsTA81xhF3sA538jK
X-Proofpoint-ORIG-GUID: uHBb-Ryy3yDG3cppsTA81xhF3sA538jK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_17,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=999
 phishscore=0 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311100020
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBOb3YgMDYsIDIwMjMsIE1laHRhLCBQaXl1c2ggd3JvdGU6DQo+IEhpIFRoaW5oLA0K
PiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFRoaW5oIE5ndXll
biA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCj4gPiBTZW50OiBTYXR1cmRheSwgT2N0b2Jl
ciAyMSwgMjAyMyA0OjQ2IEFNDQo+ID4gVG86IE1laHRhLCBQaXl1c2ggPHBpeXVzaC5tZWh0YUBh
bWQuY29tPg0KPiA+IENjOiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgU2ltZWssIE1pY2hh
bCA8bWljaGFsLnNpbWVrQGFtZC5jb20+Ow0KPiA+IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVu
QHN5bm9wc3lzLmNvbT47IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgZ2l0IChBTUQtWGlsaW54KSA8Z2l0QGFtZC5jb20+DQo+ID4g
U3ViamVjdDogUmU6IFtQQVRDSF0gdXNiOiBkd2MzOiBjb3JlOiBlbmFibGUgQ0NJIHN1cHBvcnQN
Cj4gPiANCj4gPiBPbiBGcmksIE9jdCAxMywgMjAyMywgUGl5dXNoIE1laHRhIHdyb3RlOg0KPiA+
ID4gVGhlIEdTQlVTQ0ZHMCByZWdpc3RlciBiaXRzIFszMToxNl0gYXJlIHVzZWQgdG8gY29uZmln
dXJlIHRoZSBjYWNoZQ0KPiA+ID4gdHlwZSBzZXR0aW5ncyBvZiB0aGUgZGVzY3JpcHRvciBhbmQg
ZGF0YSB3cml0ZS9yZWFkIHRyYW5zZmVycw0KPiA+ID4gKENhY2hlYWJsZSwgQnVmZmVyYWJsZS8g
UG9zdGVkKS4gV2hlbiBDQ0kgaXMgZW5hYmxlZCBpbiB0aGUgZGVzaWduLA0KPiA+ID4gRFdDMyBj
b3JlIEdTQlVTQ0ZHMCBjYWNoZSBiaXRzIG11c3QgYmUgdXBkYXRlZCB0byBzdXBwb3J0IENDSSBl
bmFibGVkDQo+ID4gdHJhbnNmZXJzIGluIFVTQi4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBQaXl1c2ggTWVodGEgPHBpeXVzaC5tZWh0YUBhbWQuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiBE
V0MzIFJlZ2lzdGVyIE1hcCBMaW5rOg0KPiA+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9f
X2h0dHBzOi8vZG9jcy54aWxpbnguY29tL3IvZW4tVVMvdWcxMDg3LXp5bnEtDQo+ID4gdWx0cmFz
Y2FsZS1yZWdpc3RlcnMvR1NCVVNDRkcwLVVTQjNfWEhDSS0NCj4gPiBSZWdpc3Rlcl9fOyEhQTRG
MlI5R19wZyFjYkxiWUxrOXh1NTREWk1raVRRek1oZENhUEE0Z21JVkluZXM0WmVOYjI4DQo+ID4g
QUkycGdlc0V2SE5ZdGpvWmZXdkVfdDd3bFVkWnZZbi1QaW84V2pBNTVla2FsJA0KPiA+ID4gUmVn
aXN0ZXIgTmFtZQlHU0JVU0NGRzANCj4gPiA+IERlc2NyaXB0aW9uCUdsb2JhbCBTb0MgQnVzIENv
bmZpZ3VyYXRpb24gUmVnaXN0ZXIgMA0KPiA+ID4NCj4gPiA+IEdTQlVTQ0ZHMCAoVVNCM19YSENJ
KSBSZWdpc3RlciBCaXQtRmllbGQ6DQo+ID4gPiBEQVRSRFJFUUlORk8JMzE6MjgNCj4gPiA+IERF
U1JEUkVRSU5GTwkyNzoyNA0KPiA+ID4gREFUV1JSRVFJTkZPCTIzOjIwDQo+ID4gPiBERVNXUlJF
UUlORk8JMTk6MTYNCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwg
MTcgKysrKysrKysrKysrKysrKysNCj4gPiA+IGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oIHwgIDUg
KysrKysNCj4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykNCj4gPiA+DQo+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYyBpbmRleA0KPiA+ID4gOWM2YmYwNTRmMTVkLi5mYzY4OTJjNjNhYmYgMTAwNjQ0
DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+IEBAIC0yMyw2ICsyMyw3IEBADQo+ID4gPiAgI2luY2x1
ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+
DQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4gPiArI2luY2x1ZGUgPGxpbnV4L29m
X2FkZHJlc3MuaD4NCj4gPiA+ICAjaW5jbHVkZSA8bGludXgvb2ZfZ3JhcGguaD4NCj4gPiA+ICAj
aW5jbHVkZSA8bGludXgvYWNwaS5oPg0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9waW5jdHJsL2Nv
bnN1bWVyLmg+DQo+ID4gPiBAQCAtNTU5LDYgKzU2MCwyMCBAQCBzdGF0aWMgdm9pZCBkd2MzX2Nh
Y2hlX2h3cGFyYW1zKHN0cnVjdCBkd2MzDQo+ID4gKmR3YykNCj4gPiA+ICAJCXBhcm1zLT5od3Bh
cmFtczkgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywNCj4gPiBEV0MzX0dIV1BBUkFNUzkpOyAgfQ0K
PiA+ID4NCj4gPiA+ICtzdGF0aWMgdm9pZCBkd2MzX2NvbmZpZ19zb2NfYnVzKHN0cnVjdCBkd2Mz
ICpkd2MpIHsNCj4gPiA+ICsJaWYgKG9mX2RtYV9pc19jb2hlcmVudChkd2MtPmRldi0+b2Zfbm9k
ZSkpIHsNCj4gPiA+ICsJCXUzMiByZWc7DQo+ID4gPiArDQo+ID4gPiArCQlyZWcgPSBkd2MzX3Jl
YWRsKGR3Yy0+cmVncywgRFdDM19HU0JVU0NGRzApOw0KPiA+ID4gKwkJcmVnIHw9IERXQzNfR1NC
VVNDRkcwX0RBVFJEUkVRSU5GT19NQVNLIHwNCj4gPiA+ICsJCQlEV0MzX0dTQlVTQ0ZHMF9ERVNS
RFJFUUlORk9fTUFTSyB8DQo+ID4gPiArCQkJRFdDM19HU0JVU0NGRzBfREFUV1JSRVFJTkZPX01B
U0sgfA0KPiA+ID4gKwkJCURXQzNfR1NCVVNDRkcwX0RFU1dSUkVRSU5GT19NQVNLOw0KPiA+ID4g
KwkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dTQlVTQ0ZHMCwgcmVnKTsNCj4gPiA+ICsJ
fQ0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiANCj4gPiBZb3UncmUgb3ZlcndyaXRpbmcgZGVmYXVs
dCB2YWx1ZXMgZm9yIGFsbCBwbGF0Zm9ybXMuIERvbid0IGRvIHRoYXQuIE5vdCBldmVyeQ0KPiA+
IHBsYXRmb3JtIHN1cHBvcnRzIHRoaXMgc2V0dGluZy4gT25seSBhcHBseSB0aGVzZSBzcGVjaWZp
YyBzZXR0aW5ncyB0byB5b3VyDQo+ID4gcGxhdGZvcm0uDQo+IA0KPiBUaGlzIERXQzNfR1NCVVND
RkcwIHJlZ2lzdGVyIGlzIHBhcnQgb2YgdGhlIERXQzMvQ29yZSBzeXN0ZW0uIEluIGdsdWUvdmVu
ZG9yIGRyaXZlcnMsIEkgY291bGRuJ3QgZmluZCBhIHdheSB0byBhY2Nlc3MNCj4gdGhlIERXQzMv
Q29yZSBhY2Nlc3MgcmVnaXN0ZXIuICBDb3VsZCB5b3UgcGxlYXNlIHByb3ZpZGUgYSBzdWdnZXN0
aW9uIGZvciB0aGUgWGlsaW54IGdsdWUgZHJpdmVyIChkd2MzL2R3YzMteGlsaW54LmMpIHRvDQo+
IGFjY2VzcyBkd2MzIHJlZ2lzdGVycz8NCg0KV2UgbWF5IG5lZWQgdG8gcGFzcyB0aGUgaGFyZHdh
cmUgY29uZmlndXJhdGlvbiBmcm9tIHRoZSBkdCBiaW5kaW5nLg0KDQpUaGFua3MsDQpUaGluaA==
