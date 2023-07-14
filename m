Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D74752E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 02:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbjGNAaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 20:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjGNAaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 20:30:52 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76D32D4B;
        Thu, 13 Jul 2023 17:30:50 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DLE4Yr028691;
        Thu, 13 Jul 2023 17:30:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=3rCoXkTlMHEeG60fYu17evXRze5K/b7KwW++9+lfVHU=;
 b=AdYm2zKynmo3t+VhhclWCzUaht0XUl1xrC4kI0CmsA4CD60u96RGUF0dcZPoJcXrScGo
 2m1kaG5W/8co1kXyvsBS+/QuOOJwCxsP0ORc1jRHN6S7GSY7k74Uj+DbXwYqFf/ec4qA
 ce5UIajmcrdVhw17XWKcl1bvR5sbDsEnuWt/p2hZXTaf6OJNst5CHof817ce+MCWrpPZ
 whPhHAsO1pfL6iRpB7bZjn1IsCQnB1OQMR0TggVxpx4IbdQpOmleRumndURKcjJicht9
 bCg2cprbIV/jOOUKVAvvDFMgf7fHeHcuzPyMc12W0OXiQ5vNRK178VYdHC0xmCPvSZD3 Bg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3rtqk010cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 17:30:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1689294645; bh=3rCoXkTlMHEeG60fYu17evXRze5K/b7KwW++9+lfVHU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=PWuAesX1tW89NpDBVIGPyS0VqMAa2A7Z+aeMroIODCehYNKQz6xILhSaHwgEQufN/
         BRGEQ0kzUMQjcYoLGkY3YNZlzyI3JIBFI8P4Ak5r4FvIYtI9y4l90YVI/dn4IW+mmd
         QH6Fv+BhdaVnjOHb9UexeErfmS0kkF7rTonfF0IXCFyvjvD0oBWqtmZ/7xLKzw41yh
         b8q+g3DmKyOo22pWGEEoCjh2Fnq9Ok84WSd+avafl9WbfaVoejTlRdlaYEV0R8Ojfv
         pmzCUjJonBr5G1g5Bc3FCtgAIRAiSi/DRE3sagsDPmJZLAC+MNWi1NZwDfjfy+OtR4
         +x/zw09XKCZ4A==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9E1804013F;
        Fri, 14 Jul 2023 00:30:44 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B7143A009C;
        Fri, 14 Jul 2023 00:30:43 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=kUZnICM2;
        dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 425CF40359;
        Fri, 14 Jul 2023 00:30:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ji5iZcjnt8qHkqQFdQ3a8MXwvXIWSjVPx/u25AK2Y2BMn9KxlnU00b+luyRl4jpY/NBSFMexhMuUE+KHGSMqt8Y+dSboyVScIyQYJLAEIdaZ+hTp8+xFRE3dsmcZ/1ZebmCCf/EMjMNUUP+8l5y2mBH2KV+FMr/I/aBJTtNFrS4nx5RQalbFcTbRpcex/3wF/7QuInsLe086QG4TUgPoUCAjdVwRCR4admgyJPMrm11pDNfc4nXBbCV/A03Pcur533QQOryrsogDkZoEwWVR/YGGFvllLpRiPO86yO5RVxB/IPh0atr64wF0niUOpsMTetElWB5v/Mn4bthFdq4WoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rCoXkTlMHEeG60fYu17evXRze5K/b7KwW++9+lfVHU=;
 b=lXF1Ywk6lig2M+vJnXThTF2FvFhbD9oke2INBwCr7LVQL45UVDpy8r4njGDMGPX6v/izranfWQ++Sg9uyeItCsoR9h1OBaug6Z+yaNJT2vmvdwtMWrPK/PYEnJCDJuGJuaJoD7scnoEnWKtAchjxllPboLH3P7Hx01+7ZJkwvhX1569HDR/95vbBIFwL1lbsUXWhm2T0G0KeZJbmv4Z/uAuaPIUzIL2ns+6UwXjQwPXsoSwZEYz++o8fBSHdYyLYunTT8IP5oH4Z5LcyjzrsWN6fxPpXw8jueNoglLG0doGHX0PwA2Gx+lIOrJVSK+Nc4jBruGNiaDbvpbQJIw40+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rCoXkTlMHEeG60fYu17evXRze5K/b7KwW++9+lfVHU=;
 b=kUZnICM2H7QJC99GMbHAWcTtpjkIQlasMAgi5hWC2tUwjA/Ud+LlM4tQISEI1fJOPkFdkTzunFBnMH2Pwuz9EyBshWc6mPJtXTtJSazQAYQQ2xXuc5VJz5RSdaY4U7FskDXiNgTbqFympzTf6bKnnhSWRSiMmGgvST6NMC+icB0=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 00:30:38 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::adba:1075:fd90:fe1d]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::adba:1075:fd90:fe1d%3]) with mapi id 15.20.6588.024; Fri, 14 Jul 2023
 00:30:38 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     =?utf-8?B?SmFrdWIgVmFuxJtr?= <linuxtardis@gmail.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Mauro Ribeiro <mauro.ribeiro@hardkernel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] Revert "usb: dwc3: core: Enable AutoRetry feature in
 the controller"
Thread-Topic: [PATCH v2] Revert "usb: dwc3: core: Enable AutoRetry feature in
 the controller"
Thread-Index: AQHZtRH48Sq/Tgk2QUi4aRRtTUa5ua+2vbcAgAGAEQCAACzfAA==
Date:   Fri, 14 Jul 2023 00:30:38 +0000
Message-ID: <20230714003032.qcl7jnnm2ou34ucy@synopsys.com>
References: <20230712224037.24948-1-linuxtardis@gmail.com>
 <20230712225518.2smu7wse6djc7l5o@synopsys.com>
 <aad3936c41c6520f6863a859eb4c4cdb5fdc0549.camel@gmail.com>
In-Reply-To: <aad3936c41c6520f6863a859eb4c4cdb5fdc0549.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA1PR12MB7270:EE_
x-ms-office365-filtering-correlation-id: 0edd3054-84ff-463f-7083-08db84018c4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gPdwjbYiL30ztqgIR3R0m36+nAXRfhKL+k5EbJu/j2IWeIzV9iQcBM0FrxGmQaMziz5DV9o8wZhF42cuZthhsKCcTbCoUm2HDyiK8W1hJBjkZ8ZDNSw616QUeEvm/Eev1oTFfBA0+n5AirAShrVLl4j5RrMzEblg9ETXhN1PWA/niiaSZivRD10tfmb0Hr1YGeqFcYoiUPl2oxhQyV9NuSPM8JxrwMzdxb/BnCKoiTJFJM8+Bzcco5s6qHChD3KIiynxnjKM83u84m1L4S6Hv0F4dBvUJpnEs4FA60G2zRKkser0lBouuIR9dQn11M0oaBY6O+3sguK77ZKLL9GK0OxhN9CKmJGmsxsl3+cej3uJeL9wIf/vq2PMuXADX7OiLEN8KQIEroPxRo1MK7os9fQvKt00BNkUf6uwTa8vSRPo2NSWOG+fk1iLMhvqTmzplgRrV6EEMA4IHVJanyndCjX5z+bUU7qHTMESwYewhGGU0MKKEmYNKghoxaWQPEHpeyl2KyAOjYVr1R56TWCYXwVe/tAsgVSb6L1f4907T26fMWiYpVIX/DqQXYJTvocKtPWqNVYyTTjum3UOl6fyzhuHhuF9ctRppSZDPAFhm37EKhze86vaFuVEHV234XUJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(54906003)(41300700001)(66476007)(66446008)(64756008)(4326008)(76116006)(66946007)(66556008)(6916009)(478600001)(5660300002)(2906002)(8676002)(8936002)(316002)(71200400001)(6486002)(6512007)(86362001)(26005)(1076003)(6506007)(186003)(38070700005)(2616005)(36756003)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3JVTTAyVVdxL1BROVp1S01ldW1mUWhzYXRxdUNSZnQ0ZjlvaC9Gb3ZobW9n?=
 =?utf-8?B?UUp1QUhpamZCalBZd2lkTXFvN3kva2E1TXg3dFJrcjhnNm5PR1NDbkd5dTRk?=
 =?utf-8?B?OG5tWXhwYURyOWE0ckpBOTRpQjViRXVqN2lmMnhTYTF0N1g3dGs5NmtZQTUv?=
 =?utf-8?B?VkgvNCtkMmRweEp3OHYyaDlQSEwwd1BlTzNoaHNWSFZEaGo1UC9EMzkrcjgr?=
 =?utf-8?B?S01xTzJqOE9RL0tJMWEvYlVraDdJSTROVWlwN2p0ak5aK1BMZGN5UjluNWVs?=
 =?utf-8?B?RGVSbk5UdmJlci9QL3JmSmttNGp1QWlJYmZwZWxza1ZJZU9LUVp4QWtSVlQ3?=
 =?utf-8?B?bm44eGtXanVHVWVFbVEyakdCT2JYeUhXMEhpVjVzODNjcWYxNXJDc3NtY2xz?=
 =?utf-8?B?aU13eVp5M1FaNEZacFdRbGtrUUF6Zm9rNStSMnhJWU1MRm9raXJ0a2tJNDUz?=
 =?utf-8?B?TWJzT1dlc1VMQXIzWGtoSVpqWFV6Mk4vVnRuOEN4enFVbXJsT0dwMjFCRzY5?=
 =?utf-8?B?dGFnYUJxY2tyUTlMK1d2NFNUVUpjT2s1V2tQd2dCZE1LanJFY0N5T2c0d0JF?=
 =?utf-8?B?dFF5R2ZSQkYzeXdxbWgwaWJnMFlSRkZoa0hQZ0dFWExpSzA0dUVFaXNsNFpL?=
 =?utf-8?B?eE13L3cyY2NUa3VPeHc4UEdoZ3JrMDd6cXc0dnM5bzg5YU9VdzlKQnVjYUE4?=
 =?utf-8?B?WEJQWHR0cnpKd0Q0dDlyR3F0aEdndFFnQXM2RTNyU2NqT0pzeUlpSVA2c1hB?=
 =?utf-8?B?ZEhtT29PeGhXL28vVWtjeGx5R3RsaitHcnhsMG5QNWZhQzAvVzlFa1I2aUFH?=
 =?utf-8?B?ZklXcHpEUGhPelFsTjN6QTlvTkNkT0pUcERiVk82TEgrTnZ2dUxMcms5Y0c0?=
 =?utf-8?B?MHVCRVpjZkduL1pmYyt5ZDNWVnByZjBTM200S2xIM2RDMU91QmkzZ1FYa3FV?=
 =?utf-8?B?bzNwS1hERlVCNTczN1hrRTBTYmVhcUNwMm4zSWFxSjVjVFQyUE5UdkdEc0c3?=
 =?utf-8?B?Z2xjd25wTHNlaUIyNFRXTDFlUlZuN01DL0pncnlVRDBFNHh6ay9PY0ZDRGlv?=
 =?utf-8?B?MUxOK0RVYnpuRE9SVXU5NHBNZWtVY0JZNzlOY1p3RmR2RnNRZEV3Tlg4QU1Q?=
 =?utf-8?B?VG8va2pPRzgwSnJXU3ZDcUphV2xDb3hrZDhRaHN4Q3RTWmRkVUM1YmZiL0Jo?=
 =?utf-8?B?NHFWdnZSUURRU0V0QnQ4TG04MnJEWThMdTMzeVNQL3duemFtcEFvVkVGdzc3?=
 =?utf-8?B?b25LYlJ4bExObzkrZytMczRDUG43TzNZVDdiN3d1QW5HeGZmZ0dFc3hwWnJ6?=
 =?utf-8?B?eXFFUEpKckMxR1RGN0ZDakN3RkFyWkxxcjF1SytSNFJ4OERZVWx4TXR5VE1Q?=
 =?utf-8?B?S3hFN21PMEswMlphNGVZdmVlRVMyR2EzOEpCbi94ZGF4Y2VBTE4ralVXK2k2?=
 =?utf-8?B?c3FZVlV0K0g4T3NCUjBXeTZQNFU0Sm41T0hhdC9wL1dtbHpoeFQvUjQ3WDBN?=
 =?utf-8?B?d0pna1NpU3h6OGVxWEIvU1BXZmxzclQzK2NiTjlNMlJqRE9IWnlzbDd3VFVn?=
 =?utf-8?B?Wnc0OHZKcXZaU3ZaV3Z2RHFHU1BvUk9VUVR6M2l2b1IvQXF0QlhxZWphSmQw?=
 =?utf-8?B?ZFkxeE83R09YK2htYkxUWnJaajhhZzJRZXlkVUJNZkp4bkN6MVNLWVhyWG9N?=
 =?utf-8?B?SUtTcFdwOW1XTkhQRUloU1hDV21tOUgrWk1ZRnU5YlZPNFFHUkZGdzBPTVVZ?=
 =?utf-8?B?RGYvQUpyajdwVEczR2pRSUhNemUvQmVGdzlOY0ZRR21jVWI0RGZJSy9Obk8r?=
 =?utf-8?B?RmJPbUt0NThqNHV0Z29sSTVWMDBjUURjOW1YdFJJMzl6dGozSkxpdXBnZUcy?=
 =?utf-8?B?a3QzcmdJTElYUGpzeWRSbXlVWHJaUUhTbUVhTi9OOXpZaEJrUG5paDV0VnhC?=
 =?utf-8?B?Y3pEQjZSZnVmVXpUQjgvLzQ3amVic25WOXloVXZIL25kdXBRT0ZmVjFYN3Ux?=
 =?utf-8?B?Mm9HSVF6RHRqeWlrUld1NTBQNFZ3L3lxeVR5dVFXQTJhcGtUVE5URnJBZjJT?=
 =?utf-8?B?SXZZajNFWXp5Z2oyajVuMjlXVTdJVUJ6SVduZXhkYUpFM3ArVi9ZQVZqbFY5?=
 =?utf-8?Q?OBva9l/7mHV24SBehkIxgvwQB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <792F57F6DA630B45900C26AF39FC412D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZlZJQkpaeXFkdkozdzN0c09RekVBMUVCNXNvYkJSTmlkcEwrWnN1eTNJTHE0?=
 =?utf-8?B?V3NEU0NOVVNBZElya1huYVN1MUFJcUdaRXdQOFdXZ1ljNjl6bEQ0NUlLYXdG?=
 =?utf-8?B?YmNVSW81N0VrZEdOblNiN1ZseTR4c0dTK3c2dUMwSkZvd1Bhalo4bFcrTEor?=
 =?utf-8?B?V1lLUFhGdGRTRHRXc3d1Smh6ZllUUWRtaTltbVhPdkdyWVRkS05GK2MraUtF?=
 =?utf-8?B?MHB6RUhuSUEzenVzeXl0cEpzaStraDc5ejBNcFlyQUJSSXdWMGpEa0ZCaWxN?=
 =?utf-8?B?ckJaYVc0VDdEZHVkYzlPVURZWFV2ci9JUE8zeXQ2RklUTDUxb2VDMDJmWDN5?=
 =?utf-8?B?NjAxUWszeWg3RFpaU2VodDIrNWxJb3hwVlVBb0VjU2tYN1hIaWpxTDcwc2ww?=
 =?utf-8?B?MUVIaWtEZnMwaUNvemVaTXI4YjV4Z1h4bFVwdVBnVmRqcEVRKzNsZGVZZWtX?=
 =?utf-8?B?Nm1uOTJnRDlzdHRBRkdiK2owNVcvelRzSUlGbWQyTmFMb2pLTHBCU2QxQWVE?=
 =?utf-8?B?Wmh0akhjVEhudWJHTUJ3b2cweHR3bGw3eU9waUdNWlhwSDBJWkdXYUtRZm12?=
 =?utf-8?B?WXF1TVRXODVkTm8vcThXZ1hLdDlYL2ZaWmtFeVhSMGZNNjBiSkt0LzVzSUdK?=
 =?utf-8?B?ZnBRRkZvQXpCMWtiTkw0T1RwVGh2MUdpMDV5ajF4MDZRRWVtbnJyR3dPRkNL?=
 =?utf-8?B?ckZYTTlaTGg3a3p3NkxsY2ltdEEwcU5LRjkweW5ITmJTVlNHRGVyeWI2QnlT?=
 =?utf-8?B?SFZlbmVIY284VVpuVTJZTVZOaERBSURCM1ZQaUhueTgrUXFRYVZuZ2x2TnVl?=
 =?utf-8?B?UzJtU09uV0pJSUc4K0drSGVFNWRYTjJDYnhSMkxjSExTU1Irekd3Q29jMitw?=
 =?utf-8?B?S3VJckQvMnFvN0JJeDRxclF6RzBmK0V1V2daUUsxTTJDK2tWcEZxRjg0WWtW?=
 =?utf-8?B?aHRSMEtEOHZSTndENnY2U2lmMGxwdnhXcnc3RHpycWlFV1pQclRkMW41OFVk?=
 =?utf-8?B?QVAyTkxQb3NpbCsyUU1mb3VxNkNSSVdRbGoxOGZDSm5Hc3YzL2xhaVYxZzZU?=
 =?utf-8?B?eW1vaGQrMTRpNWZYeGRSQUNIMDVDMnh0N3pmdVh0REVIeWFoMWVJb1E5Sk1M?=
 =?utf-8?B?V2NkTnlnNmR3M2VLeDhRR1JKQ0ZmQ1FmTjFUZmt3by95OFd1K0pLOVlucUVn?=
 =?utf-8?B?Y3BVMFdJV2dPYll5aHRQaktjRks4S1BDMU9BMHZPMXdqS3lsOUU3cVl3WFZm?=
 =?utf-8?B?bGUyUnRNa0phVW9VL1JNU1dFYkVTRlVBSVI0RDFOY0k4T1h2QT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edd3054-84ff-463f-7083-08db84018c4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 00:30:38.6554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lrYDD6CTqSHvlPjwv1xsLRMyJLnmGx3Jh/M2hoe7mkuVVKcEF9pfPVTD93yYowBM4tJ5U1dgyrGy4WR0PWkXxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270
X-Proofpoint-ORIG-GUID: 7RoCar4ncg0uc9ZaT-kQqaPKKUb3CabY
X-Proofpoint-GUID: 7RoCar4ncg0uc9ZaT-kQqaPKKUb3CabY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_12,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=430
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307140002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBKdWwgMTMsIDIwMjMsIEpha3ViIFZhbsSbayB3cm90ZToNCj4gSGkgVGhpbmgsDQo+
IA0KPiBPbiBXZWQsIDIwMjMtMDctMTIgYXQgMjI6NTUgKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90
ZToNCj4gPiBPbiBUaHUsIEp1bCAxMywgMjAyMywgSmFrdWIgVmFuZWsgd3JvdGU6DQo+ID4gPiBU
aGlzIHJldmVydHMgY29tbWl0IGIxMzhlMjNkM2RmZjkwYzA0OTQ5MjViNGMxODc0MjI3YjgxYmRk
ZjcuDQo+ID4gPiANCj4gPiA+IEF1dG9SZXRyeSBoYXMgYmVlbiBmb3VuZCB0byBjYXVzZSBzb21l
IGlzc3Vlcy4gVGhpcyBmZWF0dXJlIGFsbG93cw0KPiA+ID4gdGhlIGNvbnRyb2xsZXIgaW4gaG9z
dCBtb2RlIChmdXJ0aGVyIHJlZmVycmVkIHRvIGFzIHRoZSB4SEMpIHRvDQo+ID4gPiBzZW5kDQo+
ID4gPiBub24tdGVybWluYXRpbmcvYnVyc3QgcmV0cnkgQUNLcyAoUmV0cnk9MSBhbmQgTnVtcCE9
MCkgaW5zdGVhZCBvZg0KPiA+ID4gdGVybWluYXRpbmcgcmV0cnkgQUNLcyAoUmV0cnk9MSBhbmQg
TnVtcD0wKSB0byBkZXZpY2VzIHdoZW4NCj4gPiA+IGEgdHJhbnNhY3Rpb24gZXJyb3Igb2NjdXJz
Lg0KPiA+ID4gDQo+ID4gPiBVbmZvcnR1bmF0ZWx5LCBzb21lIFVTQiBkZXZpY2VzIGZhaWwgdG8g
cmV0cnkgdHJhbnNhY3Rpb25zIHdoZW4NCj4gPiA+IHRoZSB4SEMgc2VuZHMgdGhlbSBhIGJ1cnN0
IHJldHJ5IEFDSy4gV2hlbiB0aGlzIGhhcHBlbnMsIHRoZSB4SEMNCj4gPiANCj4gPiBGb3Igc29t
ZSBjbGFyaXR5OiBpZiB0aGUgZGV2aWNlIGNvbnRpbnVlcyB0byByZXNwb25kIHdpdGggQ1JDIGVy
cm9yLA0KPiA+IHRoZSB4SEMgd2lsbCBub3QgY29tcGxldGUgZW5kcG9pbnQgcmVsYXRlZCBjb21t
YW5kcyB3aGlsZSBpdCBrZWVwcw0KPiA+IGF1dG9yZXRyeS4NCj4gDQo+IEFja25vd2xlZGdlZC4g
RG8geW91IHRoaW5rIGl0IGl0IHdvdWxkIGJlIGJldHRlciB0byByZXNwaW4gdGhpcyBwYXRjaA0K
PiBvbmNlIG1vcmUgdG8gaW5jbHVkZSB0aGlzIGluIHRoZSBjaGFuZ2Vsb2c/DQo+IA0KDQpJdCds
bCBiZSBiZXR0ZXIgdG8gcHJvdmlkZSBtb3JlIGRldGFpbC4gSG93ZXZlciwgSSdtIGZpbmUgd2hl
dGhlciB5b3UNCndhbnQgdG8gc2VuZCB2MyB3aXRoIHRoaXMgb3Igbm90Lg0KDQpUaGFua3MsDQpU
aGluaA==
