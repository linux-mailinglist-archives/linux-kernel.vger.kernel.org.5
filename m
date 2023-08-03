Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6234576F607
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 01:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjHCXM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 19:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHCXMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 19:12:24 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F62E115;
        Thu,  3 Aug 2023 16:12:23 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373FWI3K020266;
        Thu, 3 Aug 2023 16:12:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=prp79/RH61Sj9HGzwM3NwNrg4WobEBogdTnwvZVbgWU=;
 b=tHWNcAwoDySR1YWiRl3MF5MJvVdySQPAtFq1j+7qVWZRtiyod/ZgVFGbseK5vcFncFf9
 8aG6tCmJ2R9yLS7KXLjm6Or06K+MQGz0w78DhwijzmjSddbScAncKV9qdcqWGwdAY2qM
 JTeUPx/pswNxmW4E7/HPFLE3jRi7l40oPngyl9qW9QO4ih0WRPqUQ2+y6+MH9G443Wiq
 wvwFR9eyJeiA/N0y9eqpxNGK2XJ+36a2Djxa4gC/WrGdAcXSz74XIF9IDXzWLj7Mv/Ax
 hwzue7u50Sd32Ubw3wej1rQpo/X07rwrmhbaFFvCrCfuTdwrkpNoRK6rEhWAtPUGUqkJ rw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3s51sq8v5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 16:12:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1691104326; bh=prp79/RH61Sj9HGzwM3NwNrg4WobEBogdTnwvZVbgWU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=BjV1npAvn9Rx9Dio8sYVTO2Aso88fabttRKZ0KH5SiYMhY6MfMJj1dANlPMC+SKO5
         EMimI2WiJG/dZhHBDHskgoGc5CQ4U2HdI31UuZ1we3BEgnpFA8l6WO7oH1esd/zob4
         SNmup1SsYOdKIebuYKKMjEBf0ML86zZlEIDxnWVrKgFwpDSGOgMe3zln4rU7OhB7Go
         +LE7dz6ubr/LsCI8DkrBlyeSTH/6v+XFHs37DEgfkpY3IgQPtcJ3rHQONjNSh2FFPr
         rZpTSY+RMMI9cqVNfheXGxgysEID85QmSZ1W+LNwdzi47dJ0a6kNd4KbzdvgBmJGoy
         VDU6QEaizuoiw==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7CADB40352;
        Thu,  3 Aug 2023 23:12:05 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 266A5A0078;
        Thu,  3 Aug 2023 23:12:03 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=XkkRAmJn;
        dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2054E40123;
        Thu,  3 Aug 2023 23:12:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwNhJNIOoIjnjcnMCMBKJa33+Y6ZjtBtAolG/k4K5g58CNhoqnDkjRD8DADhr+ZG7LSq+xlg+QDsfKs3QZ/aVj0A8pwjK6kwjSiq+oIMz+wEco7L7FkMzbBiCtlqccv0/w3z7qLaBSj+5K9C1Gcj7JTYcjgnxBUubSDkJ6wmZbanuhD8H+p6Ga0VXNV3D6PyOy4+hSOAyyZjliAUanDcDVCtrCnNzHPoCzQTCxHQ3ia7ALcDdjetqlUnUvuz1ZMywuEIpc/Ub8EeMMdoDf3i6e7m7DqKmTzNShhQjA9m47o9pGJzsrmWByeo68cX4nHa2hg4Yx5xVCoAxVYMM6S5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prp79/RH61Sj9HGzwM3NwNrg4WobEBogdTnwvZVbgWU=;
 b=dPO4TpIGMTkRqeOCUqB9ncFrm1Qjz2hmcOL0KrKcScGZJyd9NRJcKPYMBRzQt0fSpG4ScKpN1Duys22RhTRcydZCbluePs8tFmeNcmY2ywMkW4Bx4N1buBhoZAiZ3eVon9RB0kM1kRLtTL9v7ryjnLy7Pu0IyplWn0f9dayw79l8H8iyjbkqbbvLXrFXc4OwQv5tRo1aUMKFRD6Jbc8PM1mIrwab7lnBaQcy0GA6KzK+cl+/nXFp0+Qf1hMzvcFRJAaPFkRfZZ3b521sXOsTPI0X+OrIXh8EPBJ/F3aJWYv3aFBSrsqn4ptpLg0d6TWNvMCLg3V6zzy0PJM5CcLWKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prp79/RH61Sj9HGzwM3NwNrg4WobEBogdTnwvZVbgWU=;
 b=XkkRAmJnYshb+RVWPQDcVFDjDTkwql1ocEszoU9UCoflbq7WJJ8uJgwZwO9b8VHPTlUU05LXG+2tac9LDi+eU0FUWqkOyjnj39PkfvBMo8iOzNKh2FiXLtq8SbzSjKIza5DqQ2/6+bhBiCGhOVptg2tshfGO6Nw+ZaAnJSQ5/hs=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 23:11:59 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e68f:4d5:7a53:8a7c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e68f:4d5:7a53:8a7c%4]) with mapi id 15.20.6652.019; Thu, 3 Aug 2023
 23:11:59 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] usb: dwc3: add Realtek DHC RTD SoC dwc3 glue layer
 driver
Thread-Topic: [PATCH v2 1/2] usb: dwc3: add Realtek DHC RTD SoC dwc3 glue
 layer driver
Thread-Index: AQHZxFow++w3UXyhskGxvNTqsfGMb6/WNIgAgAB47gCAAQXsgIAAcwYAgAEQrgA=
Date:   Thu, 3 Aug 2023 23:11:59 +0000
Message-ID: <20230803231156.laggnj5bzuhugwfd@synopsys.com>
References: <20230801092541.25261-1-stanley_chang@realtek.com>
 <20230802011400.v4jim6ajsqc3tvei@synopsys.com>
 <ff9ca6f15936450696bff502c0047708@realtek.com>
 <20230803000417.qfuwsx5we5a7lfvd@synopsys.com>
 <7d47cbfdbc31436b89d3d92bf980c8fa@realtek.com>
In-Reply-To: <7d47cbfdbc31436b89d3d92bf980c8fa@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA0PR12MB4495:EE_
x-ms-office365-filtering-correlation-id: ede0449a-1230-446c-d1e3-08db94770a19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CWwQ6zSj+RD6K+HR4d+LPu5Ic3AypU4L3JmAhFaz1gPC7SN2U8Q4rPiv2vNQl3h1J+qwc/MkqBBGqHALYH5HDwUMWofuZmiMmBP0SeExehLjKmn5YlFG24sy0ELvVhmwnYvggSkE3cZJ3rDgCn/zfG/uoTLlgkBEozTKM51kZw6rngZXFnKHJnbwYv1jchZJNrkQXkof2O7yHZ8l5RQ9V5pUYy7bFO+0ZX7hXvGYWVtLN/MpWj6YnAvd4JrphGylsO66OQF7TtDZWgeb7up5TplOQWNK0W2i6+qk0ECcKJN+m/gxF+XNf9QgwRAsrg1XS818G5ArCQokxQcDqVE23Z7UpMtRAxtVLcEHMyTc/3+fJpuyCd4DrHl7O9qXXTNZaLw+wKKIBbc+C8QnlZKi+66JYdfh8QJh6LrcMyphPxp43TETduB33AEP0brAoKI76CM1vWjtl6HKkzyy6oKc44jUxKjffF43EeVj1accrMSWRQ5FzPAeOEz9WFmmkzuyrGMceokY9Ls/dSnXw52q6PIbLv7shddDZrFiRUbuZB7JKtURRyk4U+nkDYEWYp9Fqp5A7pEer4SnLRSgODxRfYnURGqxsJwVqihktxESAz4IaovqwcZXopDZbkikb0dZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199021)(186006)(41300700001)(8936002)(8676002)(83380400001)(26005)(6506007)(1076003)(2616005)(38100700002)(86362001)(122000001)(38070700005)(316002)(6916009)(71200400001)(478600001)(6486002)(6512007)(54906003)(66556008)(36756003)(66476007)(4326008)(64756008)(66446008)(2906002)(5660300002)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUgvcXlaSlBvc0kvK29abFIxeHorZDdaSnRIcXZTaWV4LzhUQmFXQUErQzBZ?=
 =?utf-8?B?Q21PVlFYV2FOSWpnSzc0Z25RY3hFeWpUbnlIcjFTL0sxWDl3dUp0TGxuWGVQ?=
 =?utf-8?B?OFFXOXBRSi9udzc2T0t4SEl6YlFVdThhbzlIemFiRWg5a1FTemx5Y2ZrYVJ3?=
 =?utf-8?B?czJQaGVnZmlmTnNwa1VlR1daTHlWQTJEcW5MZFNBZytvZFd3aVlPbEhLYXA0?=
 =?utf-8?B?SmtmdlpVLy9jc3JydnpydGh5NUo3aFovcmhIRUlkb0E4ZkxqZitTT2tRUi83?=
 =?utf-8?B?TlB5U1NtTlhhN1JmVTFHRjh6a3ZFR1AvMXl6dUhJOE95b2dISnNQU0xMN1RK?=
 =?utf-8?B?ckF4eGM0bW9OOFNMdG9pNlp4NXY1V2xjZHRXSDVmUExVZ0tMWFp1U0kzeDBQ?=
 =?utf-8?B?Y01tbTZ5ZDF6NmtsT2ErY3BVcEZwc2orQjRkamx1aER0NGhSa2ZMb0taaXg0?=
 =?utf-8?B?cWw3Z1BVWVZCMTRDdVVvTWVRTG5HSzQ1a2R5TUhiWmRJQmtWQ1E2TjQ3ZXNz?=
 =?utf-8?B?NzNCYUJrbWd6ZW1WUHhkaWFmbTFvTTdMVElvWW5rQis1cmoza2ozekFWeVFn?=
 =?utf-8?B?K3owQmNHZHFreGlFTCtNOE9YYkNlaWNNWjVNSFpGd1lBclZaZytlUHZ4RUE3?=
 =?utf-8?B?WGMzVWMweEFYZExLRWFVK1JFU2tMS0x1R0g0aW5CaDBmMHpHSWVVUG01MTJQ?=
 =?utf-8?B?WG1tUTNwVEZxM0pOYS9uYkZwaE85RGUrYnZMVGRmbXJybUp3YWlNeGlPUGtO?=
 =?utf-8?B?eUxWd0hpYlJoK0tHMlBsZXdqMjZlejQ4T1NyWDFUNWNVbUN2elVIY3ZsaHNm?=
 =?utf-8?B?bGJMTXYzcXZZbys5c21yLzN0dllJbHNIOWFPblZLSjRHcUQyQlJWUEFQeDQ0?=
 =?utf-8?B?ZlhBTmV5OUVFNDVZN0tIR3daRTUvdkNyVlZuUmw3MERPaGxYUFdBbEUxU3JD?=
 =?utf-8?B?SGNiempXSnFRdEdRSmFWQzlPdWoydncrbVhLaXFLZVRwaDdqbFJiZlBrZzdH?=
 =?utf-8?B?YjIvM0VLN3hzNGxTSEYrNnRyNEpmNzF1VlIrSVJURkRDUTdsbXdUMHFJbWVl?=
 =?utf-8?B?elpFejhsOTVqUzAzdkxSRk5tV05zRnUvNlpDN0FlUS9HOG1sSjg0TE5FUUFm?=
 =?utf-8?B?WGdyZG5FZWR1eVJ1QkthN3hqRE9WVVcvT1AyNHJ4VVlVMHlUNnpEUHVrdktC?=
 =?utf-8?B?eFhLZUpsMmMzZTFxQVZuWGJyUEREeVp1Q2k2d2hqb25wTHgxL1JxY2w3MVJw?=
 =?utf-8?B?V2twbnJHWUxpejVOaXdqd05OQ3VRWUlxMkZGSFFYNmZ6dUU4SUhFOC83WHNK?=
 =?utf-8?B?QWlMUmZkaHJWSHdEZmZzQjhSQWd0VTYrQ0pBM2tKVWFwR0NqVjZqQ1plUTVa?=
 =?utf-8?B?WHRRb2ZFcnRoWFpZeGdienVsUWE5b0l2bEk3cjlxemFjS2NMZFNVTlZ1MXVY?=
 =?utf-8?B?bGxuRHcxQjVFQ0YxYmIvTlV1VFZqdFBzanpWTGFZQjV2blJIbGxoeFYrQ0Nq?=
 =?utf-8?B?b01keVFyUmNQWldrd3hJVmZOTHdEclZ2UUFMMFFFb3UrMjZjRkdYT1crTUNE?=
 =?utf-8?B?K2lINjRtRm5DS0tJdm9DTGlyS0VQK3N4Nml0QXROL3dvQmhTVHl3K1VKY0Vh?=
 =?utf-8?B?VzM2SWVLVVlRVjh0bkxNUXJGaHZMaFdWYWU4a3E3RUNvNEUyTDc0YjZhbmNK?=
 =?utf-8?B?MUQxaCtUcjdvRkpzdWx5SWJublVMcXJFUENZa2pxWktDay91ck1EYjBuVFo2?=
 =?utf-8?B?akFrdlY2WGdWR21wdGplWENWMDAxeFQ3WmFwaFFNNTFZKzVXWnc0bnlaNC9p?=
 =?utf-8?B?NTN0cHZ5R01Fcnc3Y0tYdUxXUmEzeUNqcE1uaXZhYWZUWGxLWTJqTm0ya0hS?=
 =?utf-8?B?K2Y4Y0RPR0FOTVFiekJJSEw1SWp5cW5sTzBjUXV5ME9ZRCs5V0F0d0hJUUJH?=
 =?utf-8?B?UVZzcEhWNlM4a0NZdHgyeE0wVXpVY09hdlkrK2dnNlZ4TnB2V3ZhYXdqNlhE?=
 =?utf-8?B?cTRKL2hJZ0tORnNwL2VlVFFGTTB6bnQvK0dZWm1SVHQzbS94Uk4vMHJqckdo?=
 =?utf-8?B?aXRmdmdsYmR0ZndUbHpuRVRzam1TZzlVdWo4R0tGRFdvRmkxd0JMaU81TEtW?=
 =?utf-8?Q?0ki0E6M5qS+JwLnGjrVk1G5IW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED0E3DF7DCCD394882D0D04FF2F2219D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?T3dZMzMyVm5yd3h6UktETXR6cm84dnRBeVR2VUVWKytkeUs3SHJBT1o2YXQ0?=
 =?utf-8?B?T2xoK284c3JYdTgxOWhGMGhKMFRPZWlNN0trTCs2ckpkRlBFSkliSWdhRm1W?=
 =?utf-8?B?V3hlelhvakZnMmNQMzVhbHFkYjVvbWtLVmNCMlhjNDIrQThReHhXMkd2VnNO?=
 =?utf-8?B?RHdXUFp1cm0yNE1ERlhmS0RzY044WFNyVm4vVFE0cVJyK3FCZHdLYjlnYkV1?=
 =?utf-8?B?akR3a01JbzI4ZkhMOGlwY3d4NWgzZ0dYRngvcG03bGxJQlp2RnFtcnlDODkr?=
 =?utf-8?B?QThYalZEc0NsVWNuYXVVUDJoWkdxRXpXNjBNWHNYUUZZb2tPbEVaVlcwWkx0?=
 =?utf-8?B?LzFOa0pTeTJwc01WT1VzR3A0dUlNYmF5VnRFM1YyMzVSMjc2UVJnRWFubWhZ?=
 =?utf-8?B?UFNuZTdyZ3BaZ2c5S2JXL0JHSmw1aFdyZ0pwTmovK2JoRFYwMS9tWTNpVS96?=
 =?utf-8?B?a1ZpU2ZKS0JtK1pidldtMnd6UGVFbG9zSnZZZlkyVDgvdmE3cS9PM2lESDNp?=
 =?utf-8?B?WDZ2YUdiNnFYZXlBOXVMWDdKaGZoMlJpS2ttWXNuYkxpaEJZYUV0Qm9KcDEz?=
 =?utf-8?B?N2VtQ2JaeVM0OE5IelRTaVRvbFdZY3hyUlpqSW1KaGt3SmZINTRIQnlJWGI5?=
 =?utf-8?B?N1pGVE1oWU53dEh4RnBTcEdoUkFvZFQyOUV6a2p1OTBRTjQzSzV0NktnclVT?=
 =?utf-8?B?TmY2QmQyMkMyWHRmVStiQmZFc3pqZ0FjVFhiSmlTanFTYnNDZnBMWU5zYTFj?=
 =?utf-8?B?ekptTUpKckMxdjBIMkhDcGJManJIVEpHejdxbW1VSFVwQ3FpWjVkL3k3VzYx?=
 =?utf-8?B?NTVpb3hiVCtzTURCSWx2cThnN09lSFpEMjJmY2ZuaWZYZTlmUzUraGF1UTNa?=
 =?utf-8?B?d0NkajcvVE9CNUpNR3lkaWlhc0phcUJ0V1ZRb3Iya01vZ0NEQ3dxbSthR2Rv?=
 =?utf-8?B?Vzg2a0FyMktJWFR3WlNuUTlndE50d2R4ZW9oMzhBang3eGExSk8xZ1lOeHNF?=
 =?utf-8?B?cFRyS21VVFpaUnJ2R0dTMmlDZXlUTnFQS0dMOFplM1FvUk9HQVd1QnBrMDJn?=
 =?utf-8?B?dExrOFNqZnY0UWVMZW5NS2tDak9JTks1bjlWdUw4dm1CSVBTd1h4L20xTEhn?=
 =?utf-8?B?c2QxUW1qcWZuYU1weXQwOXZGRDRJRmdVcGlON2NOc2JqZUhlaUdSRXhWcVN0?=
 =?utf-8?B?NTNoNTFtZ241WUc4SUF0aklqcEh4WUI4Ym1uN2M5K2s1ZXp2eGZxSUhlcjJN?=
 =?utf-8?Q?+Y+ZC2jH56SRpvL?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede0449a-1230-446c-d1e3-08db94770a19
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 23:11:59.4079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 66m0W/a6o8kvRimcud8z2oriOgfzuI0MMxGKDQRC4QRIh0VdHJnQzRB8Ov+JsgE3VTZyeICKznJyt2qxV8C5vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495
X-Proofpoint-ORIG-GUID: zGUgbpzqrzrDQmS3Qj8Oof_H1MvIVOP7
X-Proofpoint-GUID: zGUgbpzqrzrDQmS3Qj8Oof_H1MvIVOP7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_22,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030209
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBdWcgMDMsIDIwMjMsIFN0YW5sZXkgQ2hhbmdb5piM6IKy5b63XSB3cm90ZToNCj4g
SGkgVGhpbmgsDQo+IA0KPiA+ID4gPiA+ICtzdGF0aWMgaW50IGR3YzNfcnRrX3NldHVwX3JvbGVf
c3dpdGNoKHN0cnVjdCBkd2MzX3J0ayAqcnRrKQ0KPiA+ID4gPg0KPiA+ID4gPiBBbnkgcmVhc29u
IHdoeSB3ZSdyZSBkb2luZyB0aGUgcm9sZSBzd2l0Y2ggaGVyZSBhbmQgbm90IHdoYXQncw0KPiA+
ID4gPiBpbXBsZW1lbnRlZCBmcm9tIHRoZSBjb3JlPw0KPiA+ID4gPg0KPiA+ID4gQmVjYXVzZSB3
ZSBoYXZlIHRvIHNldCB0aGUgdXNiIDIuMCBwaHkgbW9kZSB0aHJvdWdoIHN3aXRjaF91c2IyX2Ry
X21vZGUNCj4gPiBpbiB0aGUgZnVuY3Rpb24gZHdjM19ydGtfc2V0X2RyX21vZGUuDQo+ID4gPiBJ
biBmYWN0LCBzd2l0Y2hfZHdjM19kcl9tb2RlIHdpbGwgdXNlIHRoZSByb2xlIHN3aXRjaGluZyBp
bXBsZW1lbnRlZCBieQ0KPiA+IGNvcmUuDQo+ID4gPg0KPiA+IA0KPiA+IEkgZG9uJ3QgdGhpbmsg
dGhpcyBpcyBhIGdvb2Qgd2F5IHRvIGdvIGFib3V0IGl0LiBEbyB5b3UgKHRoZSBnbHVlDQo+ID4g
ZHJpdmVyKSBjcmVhdGUgYSByb2xlIHN3aXRjaCBzdHJ1Y3R1cmUgYW5kIHJlZ2lzdGVyIHRvIHRo
ZSBzYW1lIHJvbGUgc3dpdGNoDQo+ID4gZGV2aWNlIHRoYXQgdGhlIGR3YzMgY29yZSB3b3VsZCBy
ZWdpc3RlciBsYXRlcj8gSSBkaWQgbm90IGV4cGVjdCB0aGF0IHRvIHdvcmsgYXQNCj4gPiBhbGwu
DQo+ID4gDQo+IEluIG91ciBhcHBsaWNhdGlvbiwgdGhpcyByb2xlIHN3aXRjaCBpbiB0aGUgZ2x1
ZSBkcml2ZXIgd29ya3MgZmluZS4NCg0KSXMgdGhlIG9yZGVyIG9mIG9wZXJhdGlvbiBiZXR3ZWVu
IHRoZSBzd2l0Y2ggZnJvbSB0aGUgY29yZSB2cyB0aGUgZ2x1ZQ0KZGV0ZXJtaW5hdGU/IEFsc28s
IHdoaWNoIG9wZXJhdGlvbiBzaG91bGQgaGFwcGVuIGZpcnN0PyBJdCdzIG5vdCBjbGVhcg0KaG93
IHlvdSBoYW5kbGUgaXQgaGVyZS4NCg0KPiANCj4gPiBIb3cgYWJvdXQgd2UgY3JlYXRlIGEgY291
cGxlIG9wcyBjYWxsYmFja3MgdG8gZHdjMyBzdHJ1Y3R1cmUuIE9uZSB0bw0KPiA+IGluaXRpYWxp
emUgZ2FkZ2V0IGFuZCB0aGUgb3RoZXIgZm9yIGhvc3QuIFNob3VsZCBhbnkgcGxhdGZvcm0gc3Bl
Y2lmaWMgZGV2aWNlDQo+ID4gbmVlZCBzb21lIGludGlhbGl6YXRpb24gYmVmb3JlIGluaXRpYWxp
emluZyB0aGUgc3BlY2lmaWMgcm9sZSwgd2UgY2FuIGludm9rZQ0KPiA+IHRoZXNlIGNhbGxiYWNr
cy4NCj4gPiANCj4gPiBlLmcuOg0KPiA+IA0KPiA+IHN0cnVjdCBkd2MzX2dsdWVfb3BzIHsNCj4g
PiAgICAgICAgIGludCAoKmluaXRfZ2FkZ2V0KShzdHJ1Y3QgZHdjMyAqZHdjKTsNCj4gPiAgICAg
ICAgIGludCAoKmluaXRfaG9zdCkoc3RydWN0IGR3YzMgKmR3Yyk7IH0NCj4gPiANCj4gPiBzdHJ1
Y3QgZHdjMyB7DQo+ID4gICAgICAgICAuLg0KPiA+ICAgICAgICAgY29uc3Qgc3RydWN0IGR3YzNf
Z2x1ZV9vcHMgICAgICAqb3BzOw0KPiA+IH0NCj4gPiANCj4gPiANCj4gPiBzdGF0aWMgaW50IGR3
YzNfZ2x1ZV9pbml0X2dhZGdldChzdHJ1Y3QgZHdjMyAqZHdjKSB7DQo+ID4gICAgICAgICBpZiAo
IWR3Yy0+b3BzLT5pbml0X2dhZGdldCkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+
ID4gDQo+ID4gICAgICAgICByZXR1cm4gZHdjLT5vcHMtPmluaXRfZ2FkZ2V0KGR3Yyk7IH0NCj4g
PiANCj4gPiBzdGF0aWMgaW50IGR3YzNfZ2x1ZV9pbml0X2hvc3Qoc3RydWN0IGR3YzMgKmR3Yykg
ew0KPiA+ICAgICAgICAgaWYgKCFkd2MtPm9wcy0+aW5pdF9ob3N0KQ0KPiA+ICAgICAgICAgICAg
ICAgICByZXR1cm4gMDsNCj4gPiANCj4gPiAgICAgICAgIHJldHVybiBkd2MtPm9wcy0+aW5pdF9o
b3N0KGR3Yyk7IH0NCj4gPiANCj4gPiANCj4gPiBZb3VyIGdsdWUgZHJpdmVyIHdvdWxkIGltcGxl
bWVudCB0aGVzZSBjYWxsYmFja3MuIEluIGR3YzNfZ2FkZ2V0X2luaXQoKSBhbmQNCj4gPiBkd2Mz
X2hvc3RfaW5pdCgpLCB3ZSBjYW4gY2FsbCB0aGVzZSBjYWxsYmFja3MgYXQgc3RhcnQuIEkgYWRt
aXQgdGhhdCB0aGlzIG1heSBub3QNCj4gPiBiZSB0aGUgZ3JlYXRlc3Qgc29sdXRpb24gc2luY2Ug
aXQgd291bGQgcmVxdWlyZSB0aGUgZ2x1ZSBkcml2ZXIgdG8gYWxsb2MgYW5kDQo+ID4gcmVnaXN0
ZXIgYSBkd2MzIHBsYXRmb3JtIGRldmljZS4gQnV0IEkgdGhpbmsgc2hvdWxkIGJlIG9rLiBJZiBh
bnlvbmUgZWxzZSBjYW4NCj4gPiBjaGltZSBpbiBmb3IgbW9yZSBpZGVhLCBpdCdkIGJlIGdyZWF0
Lg0KPiANCj4gDQo+IFRoYW5rcyBmb3IgeW91ciBhZHZpY2UuDQo+IEhlcmUgaXMgYSBzb2x1dGlv
bi4gQXMgeW91J3JlIGNvbmNlcm5lZCwgaXQgbXVzdCByZWdpc3RlciBjYWxsYmFja3Mgd2l0aCB0
aGUgY29yZSBkcml2ZXIuIEl0IGxvb2tzIGEgYml0IGNvbXBsaWNhdGVkLg0KPiBJIG5vdGljZWQg
dGhlIHBoeV9zZXRfbW9kZSBhcGkuDQo+IE1heWJlIEkgY2FuIHRyeSB0byBtb3ZlIHN3aXRjaF91
c2IyX2RyX21vZGUgdG8gcGh5IGRyaXZlci4NCj4gDQo+IHBoeV9zZXRfbW9kZShkd2MtPnVzYjJf
Z2VuZXJpY19waHksIFBIWV9NT0RFX1VTQl9IT1NUKTsNCj4gcGh5X3NldF9tb2RlKGR3Yy0+dXNi
Ml9nZW5lcmljX3BoeSwgUEhZX01PREVfVVNCX0RFVklDRSk7DQo+IA0KDQpJJ20gY29uY2VybiBp
ZiB0aGVyZSBhcmUgb3RoZXIgdW53YW50ZWQgc2lkZSBlZmZlY3RzIHRoaXMgbWF5IGhhdmUgdG8N
Cm90aGVyIHBsYXRmb3Jtcy4NCg0KQlIsDQpUaGluaA==
