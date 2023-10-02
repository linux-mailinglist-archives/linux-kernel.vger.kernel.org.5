Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861B57B5C89
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 23:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjJBVmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 17:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjJBVmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 17:42:01 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660C6AB;
        Mon,  2 Oct 2023 14:41:58 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 392HCt0g025122;
        Mon, 2 Oct 2023 14:41:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=43+w9iQp40wT7l9jUUyeM2WhorDCIjt0TK+rvso/Ffc=;
 b=mSaiXKMvtsr3zaeJHwq4915aFu3RvT2PNOjnsFudMz1gxtYhPz/uC8j9ioz/zItDJ0gG
 om0YTJdAC9dPATUGcGXVVXgjaAuQv+BPUYPYrsDFXOLLZ9XtlWGp2jNySuyyLVTJfXcu
 3uLRyi7Ftko6lLnOsNjuiqBRepVeKTtMJ0RvWMdVNgyu1IFeH2ybweEORWSuwbdg7J1b
 7ClCTYfPXu2hCXM5949ib2NoV6zEpFKlG58N3gidUIUB77FcM2hWDAxLxSiaXGLW2XNa
 zJWk8s45xS2N6PJJ1kUInUcmoQ0ABgcEcqUYb3fTHJAsg5802UxuUCxvb9C8WZLwbJVD bw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3tejpmwvwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 14:41:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1696282906; bh=43+w9iQp40wT7l9jUUyeM2WhorDCIjt0TK+rvso/Ffc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=YdT1xlZjMeN+MbtbP/tV5JOHgxp5iyTYS/hUl3uNKOH2M09gYIk0vltEiBfU/4Uv3
         LAqv2n7qXhABdjxpn0LSpwjrPuLawJe07ypQvF143Af+fB1IuVgfOwcCnPgYw637Fg
         cs8qRYjt8IF43xcEE5d7GT2c4PV+E/1EzvWRYwEyx1isHbFcfcJBWG7SgJ8n1/cUxg
         wOZXvev530dN7B8qO+R8InfsYteGf6EbjrH4Ig95u7DeQd5zUdAbiaz3GXavvvvxB4
         a7Osyt4aVASHu6G++A+9lNTfJrdtBYJzfOavZF8FtcuT0ITwD9H0qL+Iq7X5oDpCD4
         il0cLaVepa80w==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4591F401B8;
        Mon,  2 Oct 2023 21:41:46 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6E105A00B0;
        Mon,  2 Oct 2023 21:41:44 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=N/8W7KdP;
        dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1E93340169;
        Mon,  2 Oct 2023 21:41:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKkTyeoCGOZWjfg1gcZ4QVbnhiT3b7fU/V1TSCsT4Wcm8B3VhqH+aHfhixY8C6sl5ZsVbNzhr3ZStqQKUrQRskVESd2baoARmUIaDxa6euMfyyGcIwDbl903OLuMrp5UbU69Arpqryz8W7fLoUAu3U0/1t7ADBBCNPcLyFr5g4RXMDru38+l9eb+UgOh9AFNlbeQOTYJOeLF2pGAIIwXkQjCMAFUsMteWXzNbfCsbj/a3qAE2EnjG+GEOGKBV8iNY+NckPR42FAs1gDNIGDxLJ+Wd33nzADXQlWsoMwJnkyqjYwyW7fK+ovsG7iyvAK8+EUZuSeW5Ld4hR3faXi7LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43+w9iQp40wT7l9jUUyeM2WhorDCIjt0TK+rvso/Ffc=;
 b=ZtiCsg132cL7zVSnW3W7PuAB0u4fCbkSlcYlkOCAm/wfGw6kUdf7uG1Qei6U9hEGulV1aR3KH9tpdfasXE0OSoPUesTxxPjbrAbVi/07OF4Cix+9Ti7Vyy9JY9mjiN382kVWg1aeT0rfVJc/7fT26M8vCiHOHbtSU0rzdDo3apw/1/klf+9jZ3Hx91S2XwF4c0S2FrLWglcw9HFfmFAMwOB0FUtTC48k8r1nYN9QcWbE6gdgbpoN+OlhHsLjaCeyvVH5D66V6e7enPDtN39xrJLd1ddqRQagWP9MWGDVw65XlPmfGSu31as2j2/wxEU7Sp6rKi8pv4VZqb2z3cXLUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43+w9iQp40wT7l9jUUyeM2WhorDCIjt0TK+rvso/Ffc=;
 b=N/8W7KdP+cZHj7Di5G6OzR8asYRndAZW9inJbfU2YlFsNKmZTKs6L1RXp9vGwzjJghA72+9LNFllKnF5dV6LY+1pbykrPnjjh4pdGAjQAhh8VziOpJVjhm72IjACfWqTEvuEneFaLs2v5insiYDRll5aJpLoKRrIGc2ZHCXjlso=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 21:41:40 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f%5]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 21:41:39 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "usb@vger.kernel.org" <usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: Re: [PATCH v3] usb: dwc3: document gfladj_refclk_lpm_sel field
Thread-Topic: [PATCH v3] usb: dwc3: document gfladj_refclk_lpm_sel field
Thread-Index: AQHZ9XOtnLZBX32tdEuKWyhtKVXmILA3B4eA
Date:   Mon, 2 Oct 2023 21:41:39 +0000
Message-ID: <20231002214135.z7v7tj6lruxe5r5z@synopsys.com>
References: <20231002210137.209382-1-swarupkotikalapudi@gmail.com>
In-Reply-To: <20231002210137.209382-1-swarupkotikalapudi@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA0PR12MB7462:EE_
x-ms-office365-filtering-correlation-id: 03e8fce1-e624-4cfe-ecdd-08dbc3905c58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0IWHy2uJLG3Sjfd1Kn99dH9eK3FU3cMPO85hP95tsy6CGof6DCqEqatTun8cFvyDqoEiT9iS4U5/3Ca+5jouHjgek8znhUvNXQjOLaPvEORMAnfBRtLYN1DTvFle2Y9tc5pFRFCHmgxvzrYsztEGII45F/M02UpIcV3S4TKHpZ2XZhoqduXKqYFjilNOid8o6ZQ+fiFUMwiUARTKnqJowvDwXW4RfR9nL4UiCV8M2nchV8eCdwJNTcKZ9GFTznUfE8fz52HoU9nzOGXhSy0tM/iqksZHP/LuGvTFBuH8wn81LQRpigwLmUqCYEuVCLnV30SjSh39su+q9N1UklkMKcaRVc/SGAxqLpG3mqZrBWpKChxPcmcZ5ctdLbqBth0Byz/YbKR9m54bghOfZDgZpvUGdlmnOn8tLcbj9CoGmpfeYiwmcJgxyL3cYYO0JN8fry2ycc5Q9ft3Zx2ZtcDRGiQWoC+iQsrWIvmVlnJsTGTFEOY62tXu84VhH8w8YgRpQ6DjyUSrJ1VuOPpGpdAnAZoXDyNcEMsa+RVBFPXDNO9dGhXy9Zw9+IXW4qVl813XOfYbpsob3Gei2nnlbUwcPJS9hYvSVT3qpuD8BGGfwaB2bN+0jn16Y9Cl49ltmAJ1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6512007)(4326008)(6916009)(5660300002)(66946007)(66556008)(8676002)(8936002)(316002)(66476007)(66446008)(478600001)(64756008)(54906003)(2906002)(71200400001)(6506007)(76116006)(6486002)(41300700001)(26005)(1076003)(38100700002)(83380400001)(2616005)(36756003)(38070700005)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlNjMWY5clAyeDJiYkw2RGozRUlLVm92UEdvTzNWa3NIK05xcGlXZ1FHTko5?=
 =?utf-8?B?MnpacCs1UDJ0allsM0FZc0hPcGVQbFZVeHg2OURDRGFKQWsrdDhhVjVkbTcx?=
 =?utf-8?B?ZWRuU3QxU0c1RmwyUlFiRjcvMWl6UWxoblowVm1nS3lRTVVzVkdxL0JnTmRs?=
 =?utf-8?B?WDZhTTNZb2xtNFV6N05zYi9YempiYWpsb05tRjVLYjdEamFVbUoyN3B0K3dF?=
 =?utf-8?B?eGorM01WRVFGRW9PbVpnV0ZFM0NIdXIraC8rcUU1N0FReTFhQWwvNm1nSXdS?=
 =?utf-8?B?ckhuR1h5WjR3WERkdVFXM0pJR0lFeDBtaEl5Q3Rib05YVXVLNEpROEhlcnVz?=
 =?utf-8?B?VlRYVDBPTUFUVlFYZEhIR1kxdGxtSHJFcWtxYkpxT3BFbUJpUVo5VjJJNGRy?=
 =?utf-8?B?UVlPN1U4RVk3aUJmYjR4U1ZEdDd6MXZ1aHNEY0JLUnRRYUpRYURZWXUxWWVX?=
 =?utf-8?B?WVdVSXRrMTE1ZndSWk1VTGR4eEpOcTREdFJtWHZWRklEbXN6UGxVc0lWK25E?=
 =?utf-8?B?TTFnQUlvWnpza3hXU1hwN1A2cDdJczQ2Vm56ZVNvelVCMXVQWU5kL1lJS1BV?=
 =?utf-8?B?aDNYSWVGdXU1a0RzTjNvSXE2V0haQXhoT2Z4WkZGSTdJUzIxOW9ldmRKazBu?=
 =?utf-8?B?TS8rcnBaeUhrTTUvYlR5ODdDWEhYTzFkMWx1ODloWFZtVklIZythN0JjVzBn?=
 =?utf-8?B?MlVtMFE2T1Rmak81SEZHK01sVE5icWFmaTRLQWNFekxBOENwa056TzZGOER4?=
 =?utf-8?B?eEhFVVZmUTB3N0pzTFZXQUJXKzRYWklDd2Y5WU4zdEY5Rm43aThjazdpV1Ex?=
 =?utf-8?B?djlpWTlGMjZSUGJkYUN6T3dQSERMRndCN2srVzR2OUh4TlU0R2R3UmhHMFYx?=
 =?utf-8?B?Q2E1ZCtRbmhjaTBuaDcvWkRJWXRzOTVxTmVwbW1URXpKdzI5WnBSdkQ1dVgy?=
 =?utf-8?B?NnZMVDhWM3FiSGhwOXVGb2JrU29GUzBoNjJYcUVSSVk4dkU4YUliUGpxS0lj?=
 =?utf-8?B?dHRvRTV3WmU3YmxtZjlldnRyMERUSW5BNjNyem56dXVXd0w0UlJ4eU9mM0g2?=
 =?utf-8?B?YmVmYmVHa0ErclNaK1REWXB0eVBVTEloOWZFVThMN08zQlhCakRiZG42WU5Q?=
 =?utf-8?B?Qytiam5zTXNEaWZ3UHV1b0ZnandHT2EzeWxhNGI4WVJNTHYwMHlSUmk2S1VQ?=
 =?utf-8?B?MmJVSHhDTjJ0bHdsdDdMQlk5Y0VsNHVZdytiQU1SbC8wbFR6UElsQnAwemxV?=
 =?utf-8?B?eml4UWpzYnhFekxqODNtY2hyU3B2VmZURHZCcnJWODBwWkFkTi8vK3FDQ2dW?=
 =?utf-8?B?VWNvRnhmdzZlOHMrTVJkbEdlQ1FOZ3p6TmR5MjZXQjQ1RVF3YmYxQ3Yxdzgy?=
 =?utf-8?B?YjcvS2tvWld4WXVuM3crai9vcVd0a2w4bnBFWXFWWlZmV0VBZHpTZDM5TGJw?=
 =?utf-8?B?a2tiWnhBekF2OTJwK1VtSmFSR2RmU21jMy8xU1EwdVd5T3lGVE5BTzh6OExC?=
 =?utf-8?B?Z1doQ3NGdlNjd1F3ZEwrczkxMkZFcXArdTlqMWlRODEra3JpQkhqZ0xQNXJm?=
 =?utf-8?B?dndpK0FFSUpLSUVFMXRPWTNZclVHVWFqdnhoZ3UzVThDL2VVK1k3ZEI3UU5i?=
 =?utf-8?B?dWVrN0tkRkFLSTBwTWh0UG5ldnpzOXg4aWtUeDU4WkI2WDNhWFF0Y3VJeWJu?=
 =?utf-8?B?K1NEUnZaUjNYMXJJaFJIaDFtOFNUL1ZtQWlMQ2dnclYrMXNCSW8yYW9uUG02?=
 =?utf-8?B?TjFqQjdZSG9LQ1ZESmNESTBnS3pPYWYrdDB4b0Y0cklaN0J3aFNjSnRpNGow?=
 =?utf-8?B?d1pweEpKdjg2eVJzaGpVRG55enhiUERqZjVGR2lzTnY0c0NobHZzYnJCZDhN?=
 =?utf-8?B?U2hYN05uVWxtR0pvRUl5YjcwSkFsRklIdGp0bEZjenlrbzljY0FDV2w3VEgx?=
 =?utf-8?B?Y1dsbHZHRDdMTW1nQS9OWkVuT0YxRXh2cCtaMXBKY2JvSVRZR3NES0lpWnI4?=
 =?utf-8?B?NkV6M01VWFNpYzBwcXU0V0JQZFRDN2VualcyV1BFK1d5YTRSaUQ1UmFLZThQ?=
 =?utf-8?B?L1Rzb2xWTWw5NmNCaXE3aWlJamRmcVp0cHYyVEo4NStmd2tOSnEvSGVvcEpI?=
 =?utf-8?Q?OFR8kt9aNtSm6jY5doWpjGjUP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <029B909F786DC3478CF4C424A156F821@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YTB1dStHLy9OM3RhZzNrcUU4T0wxN3g2WGF0QThwb3lVRlM2Z0lhNktXZmR3?=
 =?utf-8?B?SUJod1pjZWkrTWV5WEN2RlhTbVBxZklpbUZSaUt3MzNKUzBOeFovRTg1YXdE?=
 =?utf-8?B?aWEzSEt1NmJtV3dnam0rUVIrbEgzLzEycmtvSEVIVUowNEhOYmg0YU5VbFM5?=
 =?utf-8?B?UXBBUng0TkZlNDAwdDg0aE5IUHRWcVlwOURzTjdBbDJGWEJTcWVHMWk1ZHhi?=
 =?utf-8?B?cjRCNEhDTWtVNDRYZXhYRVZHSWltQ1ozQXd1d3RTMUpOcWVUZ1ErRFpzT0l0?=
 =?utf-8?B?WDZxWjNwQTAxT0Iyb21DZHJvMmJEMmtqRWVGeXRieE1JMmoxa2JjNWlBekxZ?=
 =?utf-8?B?cWNrK1k3Q0xrWUxjSHFYbUYvK2w5TkhzN0JCVUpmZ3pBeHlXYkpQakpZNzFO?=
 =?utf-8?B?QUwzbU9CQ1hYaXU4TGxKZEpWZFhNVWRGSHJTYmRjTmdzUndBMElpdks5Kys1?=
 =?utf-8?B?TmNCbUZ2Y2dLTWo2OEswMVUwcmltY2EwR3FSMS9wbGlIMFhSeXcyRFZFcXVj?=
 =?utf-8?B?aFJzTTJzb0hQWmt6eVVQM0gwM21ZeXRBMUpxbFlLa1F2cGZIMXp1OVdJQVNq?=
 =?utf-8?B?eGtTVTFJZG1tVDd5dUJ2cDdwZ0JJcGxKMEJsT1Ercnc2WnljcURFNzNmdnlW?=
 =?utf-8?B?VmRNZmxCNllkMDNZL25xZENWR0EraGk1dkRveUJFSU4wdURyL2llRk1sWW9R?=
 =?utf-8?B?dHppL3ZaRWlkUld0cXRhTXBKSlZVZlA0MDNGYXhtUTI2Vi9VeTRWVGdZaHhG?=
 =?utf-8?B?WHZCZW16b2ZKUkl2cVVJZ1BVc1hicWtDbnEzcVNtZGphdEIzWmFJTE90V2xB?=
 =?utf-8?B?UWJnelh6Z0VSemE5YlNDcVVtSDVVbTJhUFlyQ2trMUwrSXY0c0MrUGE3MnFh?=
 =?utf-8?B?ZVljOTRpeDV1Sjh3am9BcFBrelc4MHVvQ2w2UWxVZHFxRHZESUJRRThrWjY0?=
 =?utf-8?B?KzBjNHFCalY2c0hIblh2S3ZoejZXc0VXSmhkblVSNytKT3NYRGYzU3NtUzN0?=
 =?utf-8?B?OVZSdXl2R1lHdHg3Z3drY05wcjNRUG9YTGg0dDZYV21YV0FSL01aVlgxajN6?=
 =?utf-8?B?dzJxWm9uNmF6THVnSXJ5RW5HS2ZBSGdTQ1FtMWt2RkdTWi9TbXhGbndPK2p1?=
 =?utf-8?B?T2ZtL0wzMzRaM1VieXBOa2ZKRUM3TEJNMkFETFFjb2g4aVVjQ254MzMrMGQ4?=
 =?utf-8?B?MnhpTG5Xd2tkb2NRK3I4bHRHQUZxeEYzY3NVam1tUmZYZitnYW5ZNE41RE1l?=
 =?utf-8?B?WGxZR3ZSYjhaU2VsN3NDYjRhYUluR1h6ZXc1WTVkblBJbVh2UT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e8fce1-e624-4cfe-ecdd-08dbc3905c58
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 21:41:39.4746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WdYfEwO/BuOSA6AmHlWRTV8fkM2ADbTiqBQi0mncl5nO7Q8L+LvVEajNXD2QMmFKcZ1KRQRCs9Lq//GFNmvkOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7462
X-Proofpoint-GUID: EEU57AqzBERXFw-oeXHRQU8dPQ2QNgeB
X-Proofpoint-ORIG-GUID: EEU57AqzBERXFw-oeXHRQU8dPQ2QNgeB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_15,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 phishscore=0 bulkscore=0
 mlxlogscore=798 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310020167
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBPY3QgMDMsIDIwMjMsIFN3YXJ1cCBMYXhtYW4gS290aWFrbGFwdWRpIHdyb3RlOg0K
PiBBdm9pZCBhIGtlcm5lbC1kb2Mgd2FybmluZyBieSBkb2N1bWVudGluZyBpdDoNCj4gCWRyaXZl
cnMvdXNiL2R3YzMvY29yZS5oOjEzNDM6IHdhcm5pbmc6DQo+IAkgIEZ1bmN0aW9uIHBhcmFtZXRl
ciBvciBtZW1iZXIgJ2dmbGFkal9yZWZjbGtfbHBtX3NlbCcNCj4gICAgICAgICAgIG5vdCBkZXNj
cmliZWQgaW4gJ2R3YzMnDQo+IA0KPiBGaXhlczogYTZmYzJmMWIwOTI3ICgidXNiOiBkd2MzOiBj
b3JlOiBhZGQgZ2ZsYWRqX3JlZmNsa19scG1fc2VsIHF1aXJrIikNCj4gU2lnbmVkLW9mZi1ieTog
U3dhcnVwIExheG1hbiBLb3RpYWtsYXB1ZGkgPHN3YXJ1cGtvdGlrYWxhcHVkaUBnbWFpbC5jb20+
DQo+IC0tLQ0KPiAgQ2hhbmdlcyBpbiBWMzoNCj4gIC0gSW5jbHVkZSBjb3JyZWN0IEZpeGVzIHRh
ZyBhcyBzdWdnZXN0ZWQgYnkgVGhpbmgNCj4gIC0gVXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZQ0K
PiAgLSBVcGRhdGUgdGhlIGNvbW1pdCBsb2cNCj4gIC0gQ2hhbmdlIHdvcmRpbmcgb2YgZG9jdW1l
bnQgd2FybmluZyBmaXgNCj4gIA0KPiAgQ2hhbmdlcyBpbiBWMjoNCj4gIC0gSW5jbHVkZSBGaXhl
cyB0YWcgYXMgc3VnZ2VzdGVkIGJ5IEdyZWcNCj4gDQo+ICBDaGFuZ2VzIGluIFYxOg0KPiAgLSBG
aXggZG9jdW1lbnQgd2FybmluZw0KPiANCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oIHwgMiAr
Kw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gaW5k
ZXggYTY5YWM2N2Q4OWZlLi45NjY4NTM5MTY5NmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNi
L2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IEBAIC0xMTA2
LDYgKzExMDYsOCBAQCBzdHJ1Y3QgZHdjM19zY3JhdGNocGFkX2FycmF5IHsNCj4gICAqCQkJaW5z
dGFuY2VzIGluIHBhcmsgbW9kZS4NCj4gICAqIEBwYXJrbW9kZV9kaXNhYmxlX2hzX3F1aXJrOiBz
ZXQgaWYgd2UgbmVlZCB0byBkaXNhYmxlIGFsbCBIaXNoU3BlZWQNCj4gICAqCQkJaW5zdGFuY2Vz
IGluIHBhcmsgbW9kZS4NCj4gKyAqIEBnZmxhZGpfcmVmY2xrX2xwbV9zZWw6IHNldCBpZiB3ZSBu
ZWVkIHRvIGVuYWJsZSBTT0YvSVRQIGNvdW50ZXINCj4gKyAqICAgICAgICAgICAgICAgICAgICAg
ICAgICBydW5uaW5nIGJhc2VkIG9uIHJlZl9jbGsNCj4gICAqIEB0eF9kZV9lbXBoYXNpc19xdWly
azogc2V0IGlmIHdlIGVuYWJsZSBUeCBkZS1lbXBoYXNpcyBxdWlyaw0KPiAgICogQHR4X2RlX2Vt
cGhhc2lzOiBUeCBkZS1lbXBoYXNpcyB2YWx1ZQ0KPiAgICoJMAktIC02ZEIgZGUtZW1waGFzaXMN
Cj4gLS0gDQo+IDIuMzQuMQ0KPiANCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1
eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=
