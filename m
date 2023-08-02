Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4018876DB3A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 01:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjHBXDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 19:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHBXDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 19:03:39 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B46123;
        Wed,  2 Aug 2023 16:03:38 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372JkHKu023320;
        Wed, 2 Aug 2023 16:03:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=mH6KEaqECldlDEpPsGAfPRbyiMLwdkFKqJ7OVnCvVVc=;
 b=dk/or4ao5wsHhqDMEz2fD9oiU5Sw0wLhNMj1La683tbKsI0zMBol2l6fQnjjW9IdBrcU
 JFrWnUr3hNcuCxrOFZJhzUbMWFuMtYiRxu9g+HIo+D8RtKKArHSsdAa1nVLv+/ihkWeo
 vwCIo/hjGeARb1cx776dUcg7/L1nyJDZCmoKm490wmAaSLKZqRcuu2m68PZaxpCeqkUO
 6iQ8CpORlcnOouaDgE51+rmk4lLDwrS7H5cCMa8c12LKMf1uOeM0CpELCBnEIjmQeXS9
 EnzzNiY3f59ULZgRgHlRALNmDxj6XMnNqV5Bi1Kv+9pZLtEn0xR1uI1K2X7Ld4zvRAbq ew== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3s51dd5e60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 16:03:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1691017399; bh=mH6KEaqECldlDEpPsGAfPRbyiMLwdkFKqJ7OVnCvVVc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LTQAjsiY2++PICL/2b1Tac8mJPZyfbU6wRvhGC8X14vXqQ1e+HzoPSIIyDjEsrFYL
         XPbkUZIRsNeoiaitwaX9lfNl5g8gp4buwRD96knFROnjWfKy1PjtSU9xovn0RaVjzR
         Btbx3ACWkw5bhbSHfD5I/pA5gSza9l+DAZvzGWhe+HfmqYBaV3oMtmgzhCDC3TZfq1
         wIin2q7A9PxaLgFrxAITK3yb0NaGg2cXPHvMDmHFfZgeiI8BVnAoFwRyCiaYuWnaxI
         WFekx04xhsTTm41p7rwvoFMb0s1Xk7sxiJHr4L2SvhbVaSfS1jPs5U6Xsuu7wIuMK1
         HYnt5+p3KW1lQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 60AB3401DA;
        Wed,  2 Aug 2023 23:03:19 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 53475A0071;
        Wed,  2 Aug 2023 23:03:18 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Dsz64ltP;
        dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 66FDF40563;
        Wed,  2 Aug 2023 23:03:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E92CQrp97vyzzDMK73OrLiXeF3Zu2bJQU4IyEKhaSZd67AJSyx04rSDoCUN0WmtyXIDu81zvO+1JRMGBx0k88WNAos/PxotduvB0zhzQteJFn0awfLqCtfBVdBT9pbEVUlBUj+oZbaZmI8cokr/JH8xM6hpn/0Z4zJbOmpO+exjwFU5zMPvtc6kwfLgDzlAXAdLWciJQaWRVNutaNLCh+PWtX+a1egoOJlM3AKf2VY7+yAXi+mqoQuXMKnbe7Lzbc7WEfUZ90u2xBFbdYXrYgON+zLuZgyWF1VCdYxOjlMSM/pySikqP2jggThp/C4UEjYiKKJE8Pna6Cvrt35j5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mH6KEaqECldlDEpPsGAfPRbyiMLwdkFKqJ7OVnCvVVc=;
 b=A7kcUKoLG86XtN3jPyvTsp9BIcG6QVeyDP67UnfRB1g/vTf2tqiM7t7v6weaIkeo1jqA4vVhD4lf1Hv3i4zClySdtiOrkUZdOhmcqVsHdfyM/wL2lwL72heo8FEc68JupRYlcdf/zw6H0tlD77ey53Bx+7Ta6EjNSzj4Hu+oc+sKAIRqf9Jz3dphJuI6n3MWFRwsHvOahJcKJcmtuWGhYZzCWMHAOnWzUuu+5mMujEZdhITMVuU76LHRoIA03D7W69qft8/bcTE3jIDb1eDpGiCOCmPDexibqJ72Etmbk/iy/rdW1RzUnflWbCamEShMTYO00Z/VnExiqZUKqgQLAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mH6KEaqECldlDEpPsGAfPRbyiMLwdkFKqJ7OVnCvVVc=;
 b=Dsz64ltP5t9Ic+3/qrEN52qZQq/Azmrd8lyQ+SIBytdq3yHlsTzgvgLS5SYt6Px0HB+F6JKOBQZKLQDpilrnh9RzOsxxJJlILmBdKveTOzTIeQ6kZzUqwSwwD63t1mBCf5zgYl8NIm7GnbOuKD+YPCmmlod+1wpbiJYqIQwsTI8=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SJ0PR12MB5485.namprd12.prod.outlook.com (2603:10b6:a03:305::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 23:03:14 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e68f:4d5:7a53:8a7c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e68f:4d5:7a53:8a7c%4]) with mapi id 15.20.6652.019; Wed, 2 Aug 2023
 23:03:13 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Stanley Chang <stanley_chang@realtek.com>,
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
Thread-Index: AQHZxFow++w3UXyhskGxvNTqsfGMb6/WNIgAgABGwwCAASb7gA==
Date:   Wed, 2 Aug 2023 23:03:13 +0000
Message-ID: <20230802230303.kroizky6k5uq67l6@synopsys.com>
References: <20230801092541.25261-1-stanley_chang@realtek.com>
 <20230802011400.v4jim6ajsqc3tvei@synopsys.com>
 <2023080232-stowaway-resisting-fe39@gregkh>
In-Reply-To: <2023080232-stowaway-resisting-fe39@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SJ0PR12MB5485:EE_
x-ms-office365-filtering-correlation-id: 71cfb4a8-8fb9-42a8-4520-08db93aca678
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rag/R88Zt4e/2LdQCnHdA5tPk/GSKgODDxdP2+47GgYcbNhq39aAY6S5M3MjLwNPstkseqaL1zgBvancNDjrGoToa8dURnO14hcI8PQMA0JFfkCga2asNwo0pSI/74TexyQ/E7r34aLjSMDr/+zZnwI7j3Wz7aTGUpeKds/Dkc9+VGyhbuOUf14Yq6fvauuwrDPEDhigOQh+VUbm7lXPy+RnBc2udQM4dO1YoXNLeQQbOboK6YC5gHq10QgEDdIKzxewK5kT5DpvqWeoGTHTRBbFBvols6RTEMYo43fRD/2Pewcbv0t+K7CWyRQGT2E8nyAqG4vU6a0Q2fH9fFCGBaTPLjXXMZbQAtg8IcqRgWXzisui+aBiOWqi+fUXNMus6EMUBgLyhnek3zjXvfYPvs5Pvmz/0d5IQlOf898OQsH8v4kyrgEWOmLXRqbdXPNo66Cvic9XdI+UqSIXeXByWMXSHO8Xzrr9EVBSWWzWYFQG5z46w5G6RUx9WoZCUDotG1fVyXIqyks0bcfsYE3c4gXKKUPv9dIND7zLqbTt7hnAxo4t9DqIZNslbV98lnxzjUHU+9rCt5cBdXd8eddERluNZvCFrGGTc70gf6JeDDUzcPoraGFatC8RH9PB/bKS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199021)(2616005)(186003)(6512007)(316002)(86362001)(478600001)(54906003)(122000001)(38100700002)(66556008)(66476007)(66446008)(66946007)(6486002)(71200400001)(76116006)(4326008)(6916009)(64756008)(6506007)(36756003)(41300700001)(26005)(5660300002)(8676002)(8936002)(1076003)(4744005)(2906002)(38070700005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3pYTVNlOWkxd3pwdy94VjNDS0hOMllNL01DUzNZankxWjFhM1hOQm9SOG94?=
 =?utf-8?B?bzlYRzFZVmczN05HenFGMXU4UzI3Z3djYVpZUFg5TUpRNWF0Wnhkdnh2NkVM?=
 =?utf-8?B?WHBpZ1g1NllBN2Z0RXNEaFRzcTlUZm1LbzVwQWd6K0hkOXhJQjBRN1h6V2t6?=
 =?utf-8?B?dnZmckgrM0l0d1d6YXNuUnNvVXRxZmR4bUtyRzJPaXZNN3cyV1ZUY2dzWHFx?=
 =?utf-8?B?K1JqU2luak10MTBwdiszcm9KSmlPZzJ1K2FuUGZxNngydnFsaUZHY2xZU1BZ?=
 =?utf-8?B?K2ZsUGxkR1E3VmlQS1lFWmswTjVBNHY5U1diWTVhNFZQZnZRK2c2UE8vakUy?=
 =?utf-8?B?N2syOTE4SjJhZjJNd2xseFY0aDF1ZEtPY29xalljTnRibGV0QVhGNUs5S1J2?=
 =?utf-8?B?bGZudmpsLzBqMEpRQ3BNTnVES3kza0tLa2FMRDJkUWpHZStuL0dOUjBxVnFk?=
 =?utf-8?B?Yk5uOUJSWTBxa05TbEhOUUlyeUNwdVZGT0RGWEp0aCtxdDlVMlAyZFg1aS9r?=
 =?utf-8?B?L1RKdWtQb0ZLeW1wc0hVU3FTcFpNazdiRWZHS0M2K29zRkVKUnp6QnRYbjJJ?=
 =?utf-8?B?Y0NnZENqS290YlhQTmEyblBOMTdWOTNkamR1MHk2SWxBd1J0KzFtcXdhVE1R?=
 =?utf-8?B?eVUxWlhScWZhQ1UvTldieHNla3B2Z1VBckw3L3RvQlhDcWtnM3V6OU5OeWN0?=
 =?utf-8?B?RG1kc0Vwd2ZlbUR2UzBaZHhNdkRsZjRXWitGYlRuTkx6RmxEbVVwOXVwbVFV?=
 =?utf-8?B?U25EUmdnV2gwT3NxbkxKLzhDOTZJbGNQYkRsSDhCbzFHVjhqMzJwUm0vYUdP?=
 =?utf-8?B?Q3I0dmxtNkQ5UGJRSXhQL3dVZndZaktEZ2JXYmRGUmppT0VpOXo3dVBKbUQ1?=
 =?utf-8?B?TFd0WXRLa3FuL1BhNWMrUXJmOXIwTGVreDdhcTdpbVB3WnJ4ZWdJQ3JkeFVK?=
 =?utf-8?B?WEFLWWxHWWErRzJoWUZXazlSL0RBajBlTDhuSFhscnV5VzBreUlNTHJDUmlL?=
 =?utf-8?B?QzUxNktZUlVDQkZmUmNFcldRM3dsSERWM2tyUE15M0xSaDBkMHJFY0ZNTGJs?=
 =?utf-8?B?V05tbnhFWk10R2pLcXpvUm9OTTdxd2ozcUk4VmZkWHJXZW14MVZ3RmN0RWZV?=
 =?utf-8?B?K0lLc3haN3VHcXluYm9XWk9sNzNMelp1dTR4alZmQzR5VTJRSGxnZW4rRGVE?=
 =?utf-8?B?U2pkVVM2NEFwNjJYUXdnbjJQL3RjSzJUY0l0SWZDTjZPSVhKeVh4K1duRHBC?=
 =?utf-8?B?SkgxSy9OV0dheG01eGViRStFTDFYYU5GdDdFc0wvK3FEdVI1ZWg5SDdVcUtq?=
 =?utf-8?B?Yi9iYkVDMWNrcXdLbmFrV3hIMS9zN3FzOHgxN0NoSEY5TDhxaFJobXVudXlB?=
 =?utf-8?B?b1M4WVhtajJFdE95a1g0d1QvRXFoZDc3ZS9pOExlenhEVjMwK0o5NElYandG?=
 =?utf-8?B?ZUMyc1lTaGJIZ29UakRvWExqM3RUL1ZoSU5oZXdzajRPbVRDSk9rTGxuWGlj?=
 =?utf-8?B?T3JqOFNkTmtnRXYwVjhPVEhqQnVyamo1anRJSUNZaWM0QnlhSmZ6eldlVkJL?=
 =?utf-8?B?SzlwKzgrY1YzUk5YWmFkK3EvOStqUmNtWXY3MFViU0pjZjhnbXAyeERmOGEr?=
 =?utf-8?B?SEtCMXBUeVBEb1VOYzFOUlFoZ0VvKzRsV0FvUG9RMTJKZlp4T2NOaERIbWNV?=
 =?utf-8?B?b3lEeXpwelphbThoaml2UXlCV3p4RHJtenVHdVNhLy9Oc2E5aU9XNTRvMHJ3?=
 =?utf-8?B?UW1ka0ZXV2tPMmZrTy9vbnlnWmZ6anVtWnlsT2dvaStaNzNQRlJFbklaNWdN?=
 =?utf-8?B?dksyaXRvL0RhWkpoRGZzOU42aGZWRGQwaU45b0puaTRUNWhPWHZNdzFXc1hT?=
 =?utf-8?B?aUdraEx1NE54STBzdG14dU1iU0w1L3diMm1GcUpicExtNEFLYVZlOE1Zd1NW?=
 =?utf-8?B?VUJDU1Q4NUM4ZXVGNlRFRmEwc0lGVk10Vzl3QSs0akZaZGlDZitVaTEzbzBB?=
 =?utf-8?B?UDE2TmNMQTZZbndVOE1nT0lrM2d5ZDUxUENObjJHam1oU1R3TGs2MjV2OWhQ?=
 =?utf-8?B?c0NPMkdNUXRIQ2dzMnk0NEtDZWtFQlY2RVlyUW85Q01DcU0yTkhZRXN3NGNI?=
 =?utf-8?Q?OUyKNPlP9PSwWEA+8bk7/b8ch?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B93AEE0CFAD3A42A7BD2728F15BF46E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZGV1VXUvTnZOUm5DSjZHWU5qMFVOMk1EalZXV1psOGlkclRKVi8zNGM1MWZ4?=
 =?utf-8?B?R1ZwMTVHd0tDR24zeURkdC9KaWtNWjl1NFNjWUVqTGlaVVJXbURFLzdlSVNQ?=
 =?utf-8?B?WnI5RTRnL3hvZFZOTFlEVTR6ODNTYThMQU1rMDFMUFhrL2dCZEQzYUd1azNm?=
 =?utf-8?B?bGlzZXhlbVdUUzRiaTZEL2ZjdkVzQ09NQmRUeWdEVmlVMEl5bkYyNXBpK0kz?=
 =?utf-8?B?MTdneStRS2w5TGJIUmFSZFRlbVoxaWRKbjVteWdlUU9tOElrOHovVzZJL1JP?=
 =?utf-8?B?dms4b3Z4WnRSRlczckJ6YjB3RDhEWkI3dUxlR3ozaU9mUmpsUmR4VW1vTFB1?=
 =?utf-8?B?ZUJXeThiS01rUDg5amxEbUFJbnh2c01EMDlCdTdUaUhjY0FMTXVVdG9HWmNk?=
 =?utf-8?B?M2hUckJDWlFyVDcvMFpFWUpLL2h3eEh1WU5xWVAzemhTTGNSK3lWUHZZTUxP?=
 =?utf-8?B?MERpbytINWhmOWFRd1FUTDREWHlEU0t0bWtMNU45TFpPZzVRaitJSllqQllZ?=
 =?utf-8?B?bWxOQitzQXlVdTNkQUhPVThwOTd6b0cyS3A3R2FWZ3ZBcnN1Z3dJU0haZEZL?=
 =?utf-8?B?U1RhbzFDaHJubDZOQ3haN0Vpc3czNE1GblBMQnQwQzNQTHRONkZhOWE2cTZE?=
 =?utf-8?B?bGFJWWwzM2hoVWZ6YzE3ZSsxR1d0cjRSQVFFRllNSVZUeDJRd29QeGVyNVA3?=
 =?utf-8?B?bGdqRCttd1VBek9NUElYYUgxcjRya2twb28zMFZZVENDRnRWdlFZaU5oZnJO?=
 =?utf-8?B?OTF1T0FBVWZwMlJYeGJ1cmVkUDY3SmlaeHNMMSt5STZtekdFUSsveThDOGJO?=
 =?utf-8?B?RURDekUyTmYreHFuS1RSTkZkL0ZvWkYrZ1JMdHRCa1VDRk15SVR0SmdNSnlq?=
 =?utf-8?B?NXZSQUgrUmFCN3M3U1dYdmZMU2ZtRnVBKzBsVm04bm9MZ005SFNxK0xzSGdv?=
 =?utf-8?B?a0p2c0ZxMlRHLzFHRDU1OGxaTEIrRjFEWVAyNjBCcTUxMVk1cjZxZUlUZmtm?=
 =?utf-8?B?UEN3Wms0Z0pSSWlxc1FscE0xbEpaQk8yQzhjWkJkVHZ3N1JJVWovQlJBdkJN?=
 =?utf-8?B?UEdPSjVBQXlRamZEelN1S3c4RWZuTExnVWVXbkFhNC9CNG1iYlBQZzhWb1Rt?=
 =?utf-8?B?bVF3MHZoRjNPNk1xR0hSWEJZcTdqNmVwU1JCVnpLbDBVV0xkYTc0WStiV2ZG?=
 =?utf-8?B?dzlnZFRXeVF1KzJpSmpDWG1jdEROYm5iYkp4blVoWFZqajhaVFBKRVRHRnp3?=
 =?utf-8?Q?JwiEEe1R3JIcBw8?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71cfb4a8-8fb9-42a8-4520-08db93aca678
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 23:03:13.9423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tIIjyrquwka6IOu/sPGY718ArH7m5HyL8zaI+geKLD13+PxKih7MBllOdIlOq+ii7NP6RCuRa0qBn4GL8Z2I1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5485
X-Proofpoint-GUID: Ow27rzFh1BxpRlQtjevIFtYsVGQ4bO9G
X-Proofpoint-ORIG-GUID: Ow27rzFh1BxpRlQtjevIFtYsVGQ4bO9G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=700 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308020203
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

T24gV2VkLCBBdWcgMDIsIDIwMjMsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gT24gV2Vk
LCBBdWcgMDIsIDIwMjMgYXQgMDE6MTQ6MDlBTSArMDAwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0K
PiA+ID4gK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCj4gPiANCj4gPiBJJ20gbm90IGZhbWlsaWFy
IHdpdGggbGljZW5zaW5nIG11Y2gsIGJ1dCBjYW4gdGhlIFNQRFggaGVhZGVyIGluZGljYXRlcw0K
PiA+IGRpZmZlcmVudCB2ZXJzaW9uIHRoYW4gdGhlIG1vZHVsZSBsaWNlbnNlPw0KPiANCj4gVGhl
eSBtYXRjaCwgc28gSSBkbyBub3QgdW5kZXJzdGFuZCB0aGUgaXNzdWUuICBMb29rIGF0IG1vZHVs
ZS5oIGZvciBhDQo+IGxpc3Qgb2Ygd2hhdCB0aGUgZGlmZmVyZW50IHN0cmluZ3Mgb2YgTU9EVUxF
X0xJQ0VOU0UoKSBtZWFuIGZvciBkZXRhaWxzLg0KPiANCg0KVGhhbmtzIGZvciB0aGUgY29uZmly
bWF0aW9uIGFuZCBwb2ludGluZyB3aGVyZSB0byBsb29rLg0KDQpUaGluaA==
