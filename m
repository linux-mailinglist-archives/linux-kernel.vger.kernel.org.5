Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0A5754457
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 23:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjGNVjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 17:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjGNVjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 17:39:01 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9201935AE;
        Fri, 14 Jul 2023 14:38:56 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EGikX0011231;
        Fri, 14 Jul 2023 14:38:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=HZ3LXUWTQuLMHV6bbuSa89kOXgPtQy+T474hCvDnJLI=;
 b=J0vQA3BZrlY7e4owp1P1/xyDJvAEdbeyjeTKiVTBc4w3K3Bo38xHrJ0IAPDM4NBjhqcp
 jExb4VjqomHHoSx6dLQo7zx3r1ggXG/D748F94kjFRw4kaQLligr6O/EYhuee3DPgX0f
 uSAzbLVSQnrCfGPRpvnVbKM3rhmBxfSzaVCoIxwae+65wo5qbzm58O0woSF/LKUdg6Jc
 DlzucQhWDpHh+h5Y7thYa+gEDbLPJXQXcWeVuQNMmLAYu8XzCM61nsW6fbPj+aIeNPnd
 1vxG9I//ygR3LDzQvjPr8Qso9G9EzQJ7jDQl3axyB3KtnpPRDIGfvSnN2giqHw5KqoWC MQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3rtqq8dsba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 14:38:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1689370730; bh=HZ3LXUWTQuLMHV6bbuSa89kOXgPtQy+T474hCvDnJLI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=kNikA/xZ2E5T4BlHulAt1Md+pVCa1djM4NzRJUeCrytasrts2jhOGMqc4LH3wY4Q4
         glEvwRal9+cSFL1BSGvmlA7OFqfmhurBxon5JDhl78uivA2CNPWidNJ1GhHwErMLTR
         DIktZM7UgGAaXhi6g2Sw3zsb7W0OS8kAPoRYww21CQC3xHun4cR65u9Pn8PizzB+Mg
         9c8aGQP7jvT6ir2n3oO1I/dzbO7Rxb6obkf1dJubYqfSLkzeloM43QcaAiCInVKK5M
         KiNhQ41YQcCbPPCJCep639MSsDlgnprT1hD8SKqVgDQSJW3al2tulVVXBI9pBGqWMb
         IgxaRQFFPXUTw==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E387A40121;
        Fri, 14 Jul 2023 21:38:49 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4ABD4A008A;
        Fri, 14 Jul 2023 21:38:48 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=DitMYDVL;
        dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6B4E140566;
        Fri, 14 Jul 2023 21:38:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1YJ3fWN9VwMBsFFCVYR/k4XHcWUtH5JgHWZMRA4UtWzLhArAy2gaDI5gdT4YVw5AXrBjBdMnPcMWU5XajLhY0j/2FTuo/zlSktLxwGB6zOTvX6xiBHDtINQDWQyGfH+OuFCyPq0+z9laiyOePR8XKx9l1EgW9MTnUJ+lB6YDecvDguAY2I/19HA6GjOy8uv15lbVWWWTRIwLUK+d/RyffW7MpH8BaBlZ7+FTh0GKSMcr5PYUCAkPIEuxh7+wAQE5xz44d4AiXhefNQxlYuYTljKPqgNReoNcwQRnuez8vDVw4uqoiwDSunDQfwxbbzPclP7QBHn4QNcBTaV/K/fqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZ3LXUWTQuLMHV6bbuSa89kOXgPtQy+T474hCvDnJLI=;
 b=BPP29xdbiptbJAiMqJFGeyQ2RhK/54a5Gj2TqG9x+pWqPf8Bx3hUibsHek41Z2kDasf57oztmP9EQ+k2n0cJn+4zhYxBJ+Qoi4dFuC1hU0Kzx8h0oCzr/aRU+DeyXxoE7OwBHz3kZFhMvbJ3yV69Zpk0ww9LEs1YPhz+SS6KpVdsdtuqySC3u0S1NDwYgfdbukW5owGRJOLXoVEunle1DICjyTY2+c42lEzb+/wphjG0K+qIkITsTCYsL6i2WxXcD+fq4Mi4fZbY/CZfbhMxmxOkxN3cHjJQiXGvo+Wqxyu9435iFMZBooHq7V13tE3yzmseiwmloriwchwBE2sJBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZ3LXUWTQuLMHV6bbuSa89kOXgPtQy+T474hCvDnJLI=;
 b=DitMYDVLByDVSoF9C1XmAqlx630oZQXFUweXw23kcw/O+SkCOcXSdh9MmQSk/ZpKckyJmx5dhreJx07HeHjArHDeu2NLmzRHSTJwgJtRXqkW4T9RvN1wq6IBK4lVU2OgcIZqoMzY/Ox3xWl7B6lUDBxha2gBPtLjzx1iXPIcxf0=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Fri, 14 Jul
 2023 21:38:42 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::7a8:9367:70bf:2491]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::7a8:9367:70bf:2491%6]) with mapi id 15.20.6588.028; Fri, 14 Jul 2023
 21:38:41 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Jakub Vanek <linuxtardis@gmail.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Mauro Ribeiro <mauro.ribeiro@hardkernel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3] Revert "usb: dwc3: core: Enable AutoRetry feature in
 the controller"
Thread-Topic: [PATCH v3] Revert "usb: dwc3: core: Enable AutoRetry feature in
 the controller"
Thread-Index: AQHZtk42/UdzB/jx8E23dFx465oXGK+5ynwA
Date:   Fri, 14 Jul 2023 21:38:41 +0000
Message-ID: <20230714213838.zil4c4wt3spbedvi@synopsys.com>
References: <20230714122419.27741-1-linuxtardis@gmail.com>
In-Reply-To: <20230714122419.27741-1-linuxtardis@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|DM6PR12MB4385:EE_
x-ms-office365-filtering-correlation-id: 0fbe86e3-5ec7-4ed4-656a-08db84b2b13e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fdml3ALUugh9qTH2K69skmATe4IPKkF48JxtzvwHs0QCdeYoRXp14T0o7D9nEh/4cN2MTE9moczC0fHj0ePU/Ycz1iRr5TnS/d67SD83IhSz1EVS3w8VSUTP3gvw9iGGDlxSCq/0/WyRHGK2DcgswaYIttKXH+u2CUaVGhakyjR+Hncr7fLKo/Z/O8kIby+95kidfX52sb56GmXKivbawGqWL3rDiPRXc8NUvWY6VbdI00RMhjIrGIDCCB1HPSOxez+R4MeasdEJxTTDtIgVYonqSeuDkA+DDeod2TukCnk0WZwt2AIKOPNP7TH3NnhsF2P8X12U57C/u1l8DW751LnED06Egewrj2OeBkxYTYQU5pQiBT/2L6Nqf6kyWISLoK0vj5YsqPhPoLvZZNFKEetRIc48Uh3UHHym4TArmtEtpIoMnhGUjfbtYPAPeTZLIYyVhDHgRLcrxP+SH3sAaFmIwNf8QxKSReFL1nyBbwOpW7k5Tttj7B5ErJ3SC5nwZRvvXjCLwayeczSplAuKVGy75TLarxxdaOWFLplJueWkj/ftlKMMVBJAGFqGLsOc75tO7f17Zz315XJ7C1pyhQqMIQD0xPwOWdxReS0V/98=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(2616005)(6486002)(186003)(36756003)(83380400001)(6512007)(6506007)(1076003)(26005)(966005)(71200400001)(64756008)(66476007)(66446008)(66946007)(66556008)(6916009)(4326008)(91956017)(76116006)(478600001)(54906003)(122000001)(316002)(38070700005)(41300700001)(38100700002)(5660300002)(8936002)(8676002)(86362001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0FCWWFJTG9aWTlrZW5lT1VRblp2SnAvV0M3N3pjMFE2Z25meDYxMFVaVTl1?=
 =?utf-8?B?cEFMY0ZQRXZzaGdiNWtJRWxFTG9FUUdEc2lsK2QxcWZsTTRqcEUrcU9rcUJB?=
 =?utf-8?B?d2c2VVVLUmRmQmlDWHBHQ2s2U3VteE9wQnFZVU1qUVNLdmR6SkdlM2N2bnl4?=
 =?utf-8?B?NFBLeEkxWW9ocjE4WFlZS1U3a3NvVHY0Qk03aXRPbFBtZnIvRVZHcFhhc2ov?=
 =?utf-8?B?UU12aTNYbTBUTm5Dd2tXTjZhbmUva1VuL3FKWm1iMmFTSU02M3BvN1BWRG1x?=
 =?utf-8?B?anZFc2poQlRmMlpSNWE2cjJsZytjbUttSTNMT2p3N2RGdStWTkxpZTRuaVZr?=
 =?utf-8?B?UEZaRkFzbEhPdTF5MGhaMnhXdzNJZ2JLWHVJM1ppNWFYeHBiSktUTnhHcmRn?=
 =?utf-8?B?R0wyQjd1NmpaL3owZ2N1Q0F5ek8zWlEzMHU5eXFHcTJBemtENEhBYTRtTWZl?=
 =?utf-8?B?TmZRUTJTQTRKMUtxczFnTXZ6ZzNZbDVGUHQxS2I1amVxNDNYNVJhbDV6M1FB?=
 =?utf-8?B?TVQzMWNodVBONGZhT0hqOGowTDVQWWUyNlYwcldzSGFSemxzdC9zaGlPUUg1?=
 =?utf-8?B?QWU5ZGhacGFOOVRyeTk0d3FjS0FobElDZ21nbkRIbmxQVWNuVkJnT25DZUNE?=
 =?utf-8?B?YkgxdmdxVWZ5RVc5QnF3OEhyY05CaTIyNmg2LzkvZ1JGUVgxTXRKSFZCMjVh?=
 =?utf-8?B?c3NKeTE4SlZEK1JwaTJqYkkvQlRrR1E2cUlHSHV0cXBaWFRYNmp3TlBsLzA0?=
 =?utf-8?B?TEVJSUduNGJJbVdjMEJmQUttaGoxTUhmV2d2UGtNVzZEbjV6alNqZmRTY0V1?=
 =?utf-8?B?YlBsOEFudmE2ZFFIaDZKQUV2Z0VpRld0WkVaZXIwUHpnZkZvT2VWTTNoWmNC?=
 =?utf-8?B?QW55WGpzY0RZUnhZNGw2Nk5mWlJ6RUNXMi9tVm5ZRXVMK1dySjFKcTRydXlu?=
 =?utf-8?B?UDF0bjhHenBiZnBRbzFwczVlcmNpUVZsQkpyT1ozWkxmZWpSSmloTFN1Uk1D?=
 =?utf-8?B?K29VcXZSczYxcFJvWThVeG1mQjFmU3E0eTZUU2MzY0xKT2wwQXVFdEsxTDNj?=
 =?utf-8?B?bVpEL2ZQbHpUdWU5OUdtNGNNTEM3NWdKU2RIMUloYkVtekl2L1VkRWZkaFRG?=
 =?utf-8?B?aThmdGt3dC9rTnRUZW1iQjZVZWlqZy8wWVR4REtGVEFXemJRTFpzMWE4K3d6?=
 =?utf-8?B?ejA0UHVqL1ZJVHhyeEdmSlJTZjlBMGVPVGR4K1AyU0wrRVVpZFd3SmJlYnZZ?=
 =?utf-8?B?dTkvU2lDNWRZVnZZWFJJM3FNbGkwWW5peDFUd0U2WDlxbWNQaitMWVJidWkv?=
 =?utf-8?B?NFhXenFPeEt1WExzWFlNb1d3b2g5UGNKVGt6TThtcEd1dDk0U0U3TnBHdXRZ?=
 =?utf-8?B?RzluZFZNdDVkS1psRnI3eW8yWTRITWcyQ1pKWFdHdFhJTklJVWI3VmlUQVB3?=
 =?utf-8?B?MnZISnpvMGk1c28rSUR0dDljVEJ1MmxLTi8xL1Y2Z0grSVl5OHFSbEFlUFpt?=
 =?utf-8?B?TjB6QytHYW1rOWRYeTZvNkdCbkJsZmFXTlpuV0xZa3dlVzRKQ3RvZHcxWXhy?=
 =?utf-8?B?ZW5BZ2hCU0pVVWw2QVZndEF0SXZNZG5oK3BmNGUwUGhxSEpkbUZwNlRTUWIx?=
 =?utf-8?B?TlVjdXFQT0Q3RVRJbnNpNmROZEE2UnpiT3NMODNlczk4L3pUTVhRZTg2SFpo?=
 =?utf-8?B?QzRDaGthZXlJRlZOV2svYThTODZXdWtaU01CbDRHUVVHeTJiN0hueTU3MVZN?=
 =?utf-8?B?SUZySmxwcjVBV21XSGdkNCtMbFBqYy9VeTNsUVhvNVNXY29UUURzRDE1ZlVx?=
 =?utf-8?B?dkxJWDMxejRJQVd6dXppNmJmVk80c1lqZUpPRW9BbzZrdXpKaWp3QUdaQVVN?=
 =?utf-8?B?a1lKS041N2kya3Q3c2dlcnJRd0svMENhcEdhWkNkNGZtYjc1MFNwVkQyNHU2?=
 =?utf-8?B?aVcrMnA5Mm5odVEwTW5PZFBnZ0J5R2lZcE5mcTk2UjRHWXAzUUQwNkZhQ2xM?=
 =?utf-8?B?L0dINjJmTnNvbXFLQ2FxZi9mZ0FPeXlnWXFnSFFMNEFUS1B0bVd1dEhoQ3Ir?=
 =?utf-8?B?RWRWMHd1akRTSUkzQWVPKzkyUGE2RmJERVpSTEdDQ0hJMStqZmZ0T2ZRdDJ3?=
 =?utf-8?Q?875rNic78iaJ+OZ4oKSPR0kYK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F70FDEE665571C4A92BCC4202883CBC2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aDZXT0lmOU9WTW5EM20wekQwaEw2Ry91ZmxHM3o0RmxTNmp3VEtWaUNYejg1?=
 =?utf-8?B?ZGZIRDlSdHdGdkU5enVQd3d1TlBQWlRrWUpWQUNJaXlTZkExUndzV2tnL21R?=
 =?utf-8?B?VEo3Um1ZeEVKaUkrblFCOVo3aUxsQXRjcXRoMDBwQ1VjQ3RMcktxb0o4TmtQ?=
 =?utf-8?B?V2VQUmQ3RDJlaHJIRGMyME0wekdKbndueE9TeWpMRFY3OUltdWlLTmVLaEta?=
 =?utf-8?B?ZWVHSFdkMjdJeEZxcGZWd2JDQzdkSVlnUVNtU2wzSnhuQTFrNW5mT2xjeUNS?=
 =?utf-8?B?YTQxem1SL3VmN1Z1TzJUMVUxbnVlNWhGbjhMdEtIQ1FDc3RXM1BZbHZLMzR6?=
 =?utf-8?B?VzE1VUJTRjZGdUtUTTNjK3FtRm5OOFovb2JaeUNVMVc4NlIwcVUwUXlYWVF0?=
 =?utf-8?B?RDQ1emJWNFcySUoyVkN0OXZtTGhRdi9jUDZRM0N2Zks0M095R3dIRlRNTTE5?=
 =?utf-8?B?U3pvZ1ZHcU82MWtqb29CeEF5T09zWmxCMkFESGVSRkM2OG1EdE5wNDN2Y0V2?=
 =?utf-8?B?ZEtiOEdZNlRDM0puZXRQR2dxOEFvVkR2ZDRtMzR2bUdBWmRSb2tjLzd5YklQ?=
 =?utf-8?B?RVN1QmNZMWNDYmIzVmdvZnpmbDVlb2dxRS9xNmJqaVcycVl0YllwbXVVTTBq?=
 =?utf-8?B?SGtraHJ6RHl3aWs3b0Zxd0xpYXUyUFJhQy9mUVBzelNKeDN0MVIvRHUvOXU2?=
 =?utf-8?B?UERUQ2RHV3luWjhOY0Z6SlJYc095czE4TjJhL3lMOUk2MVhNdkxUZXUvc2xh?=
 =?utf-8?B?MFg2TDMwTlM2WkF3Q3UvbDUyNlpWd2FsRlMvZW9va0RVVkxiMnNyQk43K3N6?=
 =?utf-8?B?WWtJUHM4R2JUNGNmZHdDNEM2aTVoSXI5a05QYlhrUDByTG13ZVRLcldFaTgr?=
 =?utf-8?B?NUpTYlg2eVFaUElLdFR3Y2dTaXNBVndRejdHWHVCM1NVcnBWOXljb1FzSk9D?=
 =?utf-8?B?Q3hNbzV2cXBvK2tNRWV4T0gxOTVHQllEQUpOWVdkRjlvMjZiaU5TUFBtRWhw?=
 =?utf-8?B?Q0JJUzVkK3dMOHhxekZmV3ZJZE1IaHFJZ3djd253K2dYb2EyVlpxSnY1ZUdF?=
 =?utf-8?B?MjhoeGhtbVMraGJWdy9sb3VvVzMraXExS3JmenZvaE56UHp0aTdyMmlHOG5z?=
 =?utf-8?B?MGI3R1FTMEUvYmorTUNCZTU2eWhaZUkzZlF0c3VkVVV2dWozWVZaYXVPaklx?=
 =?utf-8?B?WVh1RitQUSt5SVIyMkUwL0w5WVd2UTZPTmZMK1pseFlXUjEyTXFIZm8xRHpl?=
 =?utf-8?B?WlkyWm9iU0M2NGxFQkFKTDBFdVJaUHBwWVJxWW1CMHkzWVpnUT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbe86e3-5ec7-4ed4-656a-08db84b2b13e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 21:38:41.5753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Usp0umFT246wPKmrHrkml/ZAGUFnvqiH2UTx9fb1RMY0bf0zZmsHtPzURaJlBcP8D8B+0VRn6DUoiJtgvT0fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385
X-Proofpoint-GUID: IqXF3fdZzaE4RG117y5JjH0esoNSUzpQ
X-Proofpoint-ORIG-GUID: IqXF3fdZzaE4RG117y5JjH0esoNSUzpQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_10,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307140198
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

T24gRnJpLCBKdWwgMTQsIDIwMjMsIEpha3ViIFZhbmVrIHdyb3RlOg0KPiBUaGlzIHJldmVydHMg
Y29tbWl0IGIxMzhlMjNkM2RmZjkwYzA0OTQ5MjViNGMxODc0MjI3YjgxYmRkZjcuDQo+IA0KPiBB
dXRvUmV0cnkgaGFzIGJlZW4gZm91bmQgdG8gc29tZXRpbWVzIGNhdXNlIGNvbnRyb2xsZXIgZnJl
ZXplcyB3aGVuDQo+IGNvbW11bmljYXRpbmcgd2l0aCBidWdneSBVU0IgZGV2aWNlcy4NCj4gDQo+
IFRoaXMgY29udHJvbGxlciBmZWF0dXJlIGFsbG93cyB0aGUgY29udHJvbGxlciBpbiBob3N0IG1v
ZGUgdG8gc2VuZA0KPiBub24tdGVybWluYXRpbmcvYnVyc3QgcmV0cnkgQUNLcyBpbnN0ZWFkIG9m
IHRlcm1pbmF0aW5nIHJldHJ5IEFDS3MNCj4gdG8gZGV2aWNlcyB3aGVuIGEgdHJhbnNhY3Rpb24g
ZXJyb3IgKENSQyBlcnJvciBvciBvdmVyZmxvdykgb2NjdXJzLg0KPiANCj4gVW5mb3J0dW5hdGVs
eSwgaWYgdGhlIFVTQiBkZXZpY2UgY29udGludWVzIHRvIHJlc3BvbmQgd2l0aCBhIENSQyBlcnJv
ciwNCj4gdGhlIGNvbnRyb2xsZXIgd2lsbCBub3QgY29tcGxldGUgZW5kcG9pbnQtcmVsYXRlZCBj
b21tYW5kcyB3aGlsZSBpdA0KPiBrZWVwcyB0cnlpbmcgdG8gYXV0by1yZXRyeS4gWzNdIFRoZSB4
SENJIGRyaXZlciB3aWxsIG5vdGljZSB0aGlzIG9uY2UNCj4gaXQgdHJpZXMgdG8gYWJvcnQgdGhl
IHRyYW5zZmVyIHVzaW5nIGEgU3RvcCBFbmRwb2ludCBjb21tYW5kIGFuZA0KPiBkb2VzIG5vdCBy
ZWNlaXZlIGEgY29tcGxldGlvbiBpbiB0aW1lLiBbMV0NCj4gVGhpcyBzaXR1YXRpb24gaXMgcmVw
b3J0ZWQgdG8gZG1lc2c6DQo+IA0KPiBbc2RhXSB0YWcjMjkgdWFzX2VoX2Fib3J0X2hhbmRsZXIg
MCB1YXMtdGFnIDEgaW5mbGlnaHQ6IENNRCBJTg0KPiBbc2RhXSB0YWcjMjkgQ0RCOiBvcGNvZGU9
MHgyOCAyOCAwMCAwMCA2OSA0MiA4MCAwMCAwMCA0OCAwMA0KPiB4aGNpLWhjZDogeEhDSSBob3N0
IG5vdCByZXNwb25kaW5nIHRvIHN0b3AgZW5kcG9pbnQgY29tbWFuZA0KPiB4aGNpLWhjZDogeEhD
SSBob3N0IGNvbnRyb2xsZXIgbm90IHJlc3BvbmRpbmcsIGFzc3VtZSBkZWFkDQo+IHhoY2ktaGNk
OiBIQyBkaWVkOyBjbGVhbmluZyB1cA0KPiANCj4gU29tZSB1c2VycyBvYnNlcnZlZCB0aGlzIHBy
b2JsZW0gb24gYW4gT2Ryb2lkIEhDMiB3aXRoIHRoZSBKTVM1NzgNCj4gVVNCMy10by1TQVRBIGJy
aWRnZS4gVGhlIGlzc3VlIGNhbiBiZSB0cmlnZ2VyZWQgYnkgc3RhcnRpbmcNCj4gYSByZWFkLWhl
YXZ5IHdvcmtsb2FkIG9uIGFuIGF0dGFjaGVkIFNTRC4gQWZ0ZXIgYSB3aGlsZSwgdGhlIGhvc3QN
Cj4gY29udHJvbGxlciB3b3VsZCBkaWUgYW5kIHRoZSBTU0Qgd291bGQgZGlzYXBwZWFyIGZyb20g
dGhlIHN5c3RlbS4gWzFdDQo+IA0KPiBGdXJ0aGVyIGFuYWx5c2lzIGJ5IFN5bm9wc3lzIGRldGVy
bWluZWQgdGhhdCBjb250cm9sbGVyIHJldmlzaW9ucw0KPiBvdGhlciB0aGFuIHRoZSBvbmUgaW4g
T2Ryb2lkIEhDMiBhcmUgYWxzbyBhZmZlY3RlZCBieSB0aGlzLg0KPiBUaGUgcmVjb21tZW5kZWQg
c29sdXRpb24gd2FzIHRvIGRpc2FibGUgQXV0b1JldHJ5IGFsdG9nZXRoZXIuDQo+IFRoaXMgY2hh
bmdlIGRvZXMgbm90IGhhdmUgYSBub3RpY2VhYmxlIHBlcmZvcm1hbmNlIGltcGFjdC4gWzJdDQo+
IA0KPiBSZXZlcnQgdGhlIGVuYWJsZW1lbnQgY29tbWl0LiBUaGlzIHdpbGwga2VlcCB0aGUgQXV0
b1JldHJ5IGJpdCBpbg0KPiB0aGUgZGVmYXVsdCBzdGF0ZSBjb25maWd1cmVkIGR1cmluZyBTb0Mg
ZGVzaWduIFsyXS4NCj4gDQo+IEZpeGVzOiBiMTM4ZTIzZDNkZmYgKCJ1c2I6IGR3YzM6IGNvcmU6
IEVuYWJsZSBBdXRvUmV0cnkgZmVhdHVyZSBpbiB0aGUgY29udHJvbGxlciIpDQo+IExpbms6IGh0
dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9yL2EyMWYz
NGMwNDYzMmQyNTBjZDBhNzhjN2M2ZjRhMWM5YzdhNDMxNDIuY2FtZWxAZ21haWwuY29tL19fOyEh
QTRGMlI5R19wZyFjUVptVW96U0NWcnk5d0VuNVRUVkdsakVvNkJfbktJZWwwa1dYc1VRYmFsZUpa
d2tPeXJ2YzRGeldUbGJmY1VKN2hHejlWNTBybjBBMldNRWNlVUxJUzl5OUEkICBbMV0NCj4gTGlu
azogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Iv
MjAyMzA3MTEyMTQ4MzQua3lyNnVseW5jMzJkNGt0a0BzeW5vcHN5cy5jb20vX187ISFBNEYyUjlH
X3BnIWNRWm1Vb3pTQ1ZyeTl3RW41VFRWR2xqRW82Ql9uS0llbDBrV1hzVVFiYWxlSlp3a095cnZj
NEZ6V1RsYmZjVUo3aEd6OVY1MHJuMEEyV01FY2VYcmJyRzlpQSQgIFsyXQ0KPiBMaW5rOiBodHRw
czovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIzMDcx
MjIyNTUxOC4yc211N3dzZTZkamM3bDVvQHN5bm9wc3lzLmNvbS9fXzshIUE0RjJSOUdfcGchY1Fa
bVVvelNDVnJ5OXdFbjVUVFZHbGpFbzZCX25LSWVsMGtXWHNVUWJhbGVKWndrT3lydmM0RnpXVGxi
ZmNVSjdoR3o5VjUwcm4wQTJXTUVjZVdWSno4bnVRJCAgWzNdDQo+IENjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnDQo+IENjOiBNYXVybyBSaWJlaXJvIDxtYXVyby5yaWJlaXJvQGhhcmRrZXJuZWwu
Y29tPg0KPiBDYzogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5h
cm8ub3JnPg0KPiBTdWdnZXN0ZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9w
c3lzLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSmFrdWIgVmFuZWsgPGxpbnV4dGFyZGlzQGdtYWls
LmNvbT4NCj4gLS0tDQo+IFYyIC0+IFYzOiBJbmNsdWRlIG1vcmUgZmluZGluZ3MgaW4gY2hhbmdl
bG9nDQo+IFYxIC0+IFYyOiBVcGRhdGVkIHRvIGRpc2FibGUgQXV0b1JldHJ5IGV2ZXJ5d2hlcmUg
YmFzZWQgb24gU3lub3BzeXMgZmVlZGJhY2sNCj4gICAgICAgICAgIFJld29yZGVkIHRoZSBjaGFu
Z2Vsb2cgYSBiaXQgdG8gbWFrZSBpdCBjbGVhcmVyDQo+IA0KPiAgZHJpdmVycy91c2IvZHdjMy9j
b3JlLmMgfCAxNiAtLS0tLS0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCB8
ICAzIC0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5j
DQo+IGluZGV4IGY2Njg5YjczMTcxOC4uYTRlMDc5ZDM3NTY2IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBA
QCAtMTIwOSwyMiArMTIwOSw2IEBAIHN0YXRpYyBpbnQgZHdjM19jb3JlX2luaXQoc3RydWN0IGR3
YzMgKmR3YykNCj4gIAkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dVQ1RMMSwgcmVnKTsN
Cj4gIAl9DQo+ICANCj4gLQlpZiAoZHdjLT5kcl9tb2RlID09IFVTQl9EUl9NT0RFX0hPU1QgfHwN
Cj4gLQkgICAgZHdjLT5kcl9tb2RlID09IFVTQl9EUl9NT0RFX09URykgew0KPiAtCQlyZWcgPSBk
d2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HVUNUTCk7DQo+IC0NCj4gLQkJLyoNCj4gLQkJICog
RW5hYmxlIEF1dG8gcmV0cnkgRmVhdHVyZSB0byBtYWtlIHRoZSBjb250cm9sbGVyIG9wZXJhdGlu
ZyBpbg0KPiAtCQkgKiBIb3N0IG1vZGUgb24gc2VlaW5nIHRyYW5zYWN0aW9uIGVycm9ycyhDUkMg
ZXJyb3JzIG9yIGludGVybmFsDQo+IC0JCSAqIG92ZXJydW4gc2NlbmVyaW9zKSBvbiBJTiB0cmFu
c2ZlcnMgdG8gcmVwbHkgdG8gdGhlIGRldmljZQ0KPiAtCQkgKiB3aXRoIGEgbm9uLXRlcm1pbmF0
aW5nIHJldHJ5IEFDSyAoaS5lLCBhbiBBQ0sgdHJhbnNjYXRpb24NCj4gLQkJICogcGFja2V0IHdp
dGggUmV0cnk9MSAmIE51bXAgIT0gMCkNCj4gLQkJICovDQo+IC0JCXJlZyB8PSBEV0MzX0dVQ1RM
X0hTVElOQVVUT1JFVFJZOw0KPiAtDQo+IC0JCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19H
VUNUTCwgcmVnKTsNCj4gLQl9DQo+IC0NCj4gIAkvKg0KPiAgCSAqIE11c3QgY29uZmlnIGJvdGgg
bnVtYmVyIG9mIHBhY2tldHMgYW5kIG1heCBidXJzdCBzZXR0aW5ncyB0byBlbmFibGUNCj4gIAkg
KiBSWCBhbmQvb3IgVFggdGhyZXNob2xkLg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdj
My9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCA4YjEyOTVlNGRjZGQu
LmE2OWFjNjdkODlmZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4g
KysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gQEAgLTI1Niw5ICsyNTYsNiBAQA0KPiAg
I2RlZmluZSBEV0MzX0dDVExfR0JMSElCRVJOQVRJT05FTglCSVQoMSkNCj4gICNkZWZpbmUgRFdD
M19HQ1RMX0RTQkxDTEtHVE5HCQlCSVQoMCkNCj4gIA0KPiAtLyogR2xvYmFsIFVzZXIgQ29udHJv
bCBSZWdpc3RlciAqLw0KPiAtI2RlZmluZSBEV0MzX0dVQ1RMX0hTVElOQVVUT1JFVFJZCUJJVCgx
NCkNCj4gLQ0KPiAgLyogR2xvYmFsIFVzZXIgQ29udHJvbCAxIFJlZ2lzdGVyICovDQo+ICAjZGVm
aW5lIERXQzNfR1VDVEwxX0RFVl9ERUNPVVBMRV9MMUwyX0VWVAlCSVQoMzEpDQo+ICAjZGVmaW5l
IERXQzNfR1VDVEwxX1RYX0lQR0FQX0xJTkVDSEVDS19ESVMJQklUKDI4KQ0KPiAtLSANCj4gMi4y
NS4xDQo+IA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMu
Y29tPg0KDQpUaGFua3MsDQpUaGluaA==
