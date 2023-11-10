Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B1E7E8641
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345064AbjKJXJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbjKJXJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:09:52 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3A01BFB;
        Fri, 10 Nov 2023 15:09:47 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AALksKg030001;
        Fri, 10 Nov 2023 15:09:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=R8niEyA6mK6RXa25BKE3uxcrWoGS6P5toqCKPiiiCIs=;
 b=Cc31yiKwpqEwS8RG63e2/KtwxS/rDxWSZhzLBLuYxnfvwCR9dT2YiOjDtquAaFctWaw/
 n/s3EJ4YGPXAhNesMy1uUD2vybwgIx4ImDZ+oBOAv192C3zPXMxhdARWFvntdN1dExUP
 Bsb0oc+vuFifcgxhVnMMPHxonjp4X1tq62uJrP6VaJJzxnKlsAFLsMwxOBpnH9wvHs/z
 rGjKvR+wGbbPZLBAmCexeVseTHExzFnhwuIP/YQ13ATFOrT9TMaP6iwtjNkOGO62Hoih
 5etBccOhUr+fwG7oRxIFLoPd3pSuVJxJKGoV2fKQswMdcvnF11Y76E4m0060WxTfnrpT wg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3u7y3fj9xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 15:09:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1699657785; bh=R8niEyA6mK6RXa25BKE3uxcrWoGS6P5toqCKPiiiCIs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WGuUebaewC2lECAGlJO64qcIbXuztEP0flws+thFDDK78Ga2vcCKZkWNgfKwj78/t
         wQTm20AkYbBbkjPO0PIUbpXQlIGc3jJv9tq750QODtf0HlIgZ7CoXBnlaZG0UPG4Nm
         SHJNIWi+DdgBoPa3nAJjItwWViVw5dcVkIPSRp34ioVC+xy7QwZLK4Q0XazQxAvprB
         kZtwEmvYGJaaiXAEbazXltH8+MkU7NyFmSI6GNgHi0bopd0IxqFphFmM4X7n2QaQ5w
         C5EKbEeU3YSZxQ/m5q+suN1P/gt0YgOnzheX65cL581pIgeur4FPoAL+BrHzwjC9VI
         544ZRKMizr3FA==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3AF9C401CC;
        Fri, 10 Nov 2023 23:09:45 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id DE6C1A00B4;
        Fri, 10 Nov 2023 23:09:44 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=KNwa1I+0;
        dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2781A401C4;
        Fri, 10 Nov 2023 23:09:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6z+6kMg+Zo01hJvlsciLT926CHs32SQFj1hlEXqk7A7HcwiGDsPLBB8xeUDvpSgCgQl4r3s2DepbqlNaYm0d8FExZ3LK9Zhejk3tyKwbQunH40RwGdz7HCKWPlF4X7741zp+stu3SlM1B5Ay3xZItCsE55sFazEucNEOq3D11fru7WFt0OAoQv68cx0B8wrKLE/Jn4+VqlQuHG727714cc9FuERMJ9tU5uVLKDfK23z26fGMsOkX/ZNQ30WKY+eZTFQHx54y/+nh+oumy5jgl52smxcRvSVREF6nCW2hNlVrVW+EKk24iPEoQJASqbyFlL3kZgmZ6cSlvDnJ+BI0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8niEyA6mK6RXa25BKE3uxcrWoGS6P5toqCKPiiiCIs=;
 b=FCj9gx/V84v9B/BkjwREcDoLz7mN4Bpv4ZgQDb4tdUu7qCYahbagmx3ekqBsAh1Q92u6jJS/TZPEAjdKYCE8vtE957SPo65a2sSWNOI4fHx+/M0AMGPnAbm7hhuUw9egLsC2RDSKptX6Sx9d28bKuAB8ikzv2/tKh+MSmN0Ra446LQF1oRkeXLJ5R0ZsN4PpKGop0zlBALBuL0B7qhXRUbP1+fGc6GtiJXtvN7V713yRS7/X6DCKKX5CoBn0kxJvxDQubkbQhgLxY7XA75BqiIJUQXetwoeYkT1p+Mq+nb2aH2accLRRZtFotJwFUkQ4LPIUDc6rLevD1iE3P+vhTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8niEyA6mK6RXa25BKE3uxcrWoGS6P5toqCKPiiiCIs=;
 b=KNwa1I+0hOWbp/sOvimLxpjJyT9iqO0QQ3F/ZxBUOo0L8uygdV7v6kxyo+Gk89bXd6eTTpUF3iVffWI9skcTUHD5ry4S00Rat5Gllapsywf3aoEA++LpbVsvPTpC9UAer+hm685GRP3EhxVaRrj8NwIcLfeeCoztp0QYhGlSdO0=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.21; Fri, 10 Nov
 2023 23:09:39 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 23:09:39 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Manan Aurora <maurora@google.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "manugautam@google.com" <manugautam@google.com>,
        "badhri@google.com" <badhri@google.com>
Subject: Re: [PATCH] usb: dwc3: Support EBC feature of DWC_usb31
Thread-Topic: [PATCH] usb: dwc3: Support EBC feature of DWC_usb31
Thread-Index: AQHaDV+hQYu1qIk1pk2bzrpJF26+HrB0OuyA
Date:   Fri, 10 Nov 2023 23:09:38 +0000
Message-ID: <20231110230837.b5q5dsvsqlxfz5xu@synopsys.com>
References: <20231102073840.1579540-1-maurora@google.com>
In-Reply-To: <20231102073840.1579540-1-maurora@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM6PR12MB4268:EE_
x-ms-office365-filtering-correlation-id: 04731c1b-7300-4e2e-b59e-08dbe2421d2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Nw9rXfOIPTJct7WerUNWbXJkUqhYv5xQDudB2ckJktM4nM4D6MBxRCnOVc5guhYJu5T1l+ywGgNghFHS/ct4jq/Gw6i1y9ye8sJm7i4mNp3/TWlprRyZBnDnK4VdTyPSg2LeCAY1q7b4RS27Rl778FxTUyJCJsR96Ml5PARRtx7g5d7mwCtMH7tbeKfZU+vCDGN3a2v8dNVqlcaRhtKsnT2Lsxch5U5WwBpZgw2T4jEo4Qs17Z9JiO9AE7dTeiuAayGLEf9NbhAriAciMxtLN5ZoG0YfHCLN+bfIgC2BdZ+w1FuO/LxvJL+5d8i8c/U2attBU4QkUg2wNzpCqG7nBH6E+DZj2wP9dKZzmirIpWQFY/la9XvU0BDhLEXOB35LpmxOSC8YamYCXOjQzzpsxqvxF29o6nQdmnx/UXUmdWj7vW+ojPITzFTHCr52UEAABl4Ng02DHH3cT9nYuUrNKFkBLmkP25Kgxhlw1VWgYRW3yKAMTng2/DnZefUVsIkoW0JTpgGssRjMJtONWdIfWOLL9gG1XDK5t4uRHqbsoFbGpBTX3uHwrbyMK9Tn2CQeDpTyaS5HjkVlwaWKJ+2A5v4w/CDIqv60R/ezmuCwgTGejEkOd7xrvPzF204WH3k
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(26005)(122000001)(2616005)(1076003)(38100700002)(38070700009)(76116006)(66946007)(64756008)(6916009)(2906002)(66476007)(66446008)(66556008)(478600001)(6486002)(86362001)(8936002)(8676002)(4326008)(5660300002)(54906003)(316002)(71200400001)(36756003)(41300700001)(6506007)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eW9VR3dPc0s5NlJ1NzQzQ2lKdTljUFJ1amN0UWJwb1lUMjFaMGtTZXQxRUNv?=
 =?utf-8?B?WDd1VUVaSGlocTB4VVEzdFR3Z3B0R2IxVnQ0WjRFd29DRXY2eWZxMXcwZGdM?=
 =?utf-8?B?UVRuUmpycnpNdm9IMTJsWGp4TkxJaUI1ZHZGcWs0SzFYS0NBeWdvOHIxK1Zp?=
 =?utf-8?B?Ui9tNHcrZmloTWtmUVptLzV6Wm5kWnloODQ4akFCdVdmbGJJQ0FwemVJSFR0?=
 =?utf-8?B?MDhYSzlnRUVNeS9YYXVKZ1hpSnpST3lqeXovdXBteHZMdy9UdlRXSElFbDBy?=
 =?utf-8?B?U3R4VlU0V0ZUZHV4WUdGZ1k4ZnNzSW1ENWQ3RG1tWnVhVWJjZnpDRXpOTURm?=
 =?utf-8?B?aEM4ZWdob1MxaEROb1lNVGdKYzIxdzdrWXNpZytFbTlxalgwVTlVNGd2Qnll?=
 =?utf-8?B?bXVGRUlKYW9EaElGVEVjR3d2Rm5iRW84VkM2YldNWDd3Wi9WS1ErNngxbHdy?=
 =?utf-8?B?MXpEbDM5TFd0bEdickhCRDhtY1NPK0VSYUtCNEVaUXFlTkFGM0Q1R2ZiR25T?=
 =?utf-8?B?T3Z5d3JUTjU5SVhDUDR3VDFBZ0w4YVN5MHM0WVFkMXM1NFdsNHZiNEw1TW1i?=
 =?utf-8?B?WCt0SmJZRldwVGlsdlNhZnVrdXNWVUl3cUlvRFdnNG5ENlBReGpyNGd6K1B5?=
 =?utf-8?B?ZFg4V0svekY5ZmQ5QWtDeXlKUzhSYzR6WFgrY3JVZExZZ1ZsWGRYckU0REJq?=
 =?utf-8?B?YXl0cmZDQjhyVFY2am12dnpGZjJ0T01GT2orRFZDc0FKN1VGakVjczU1VDZI?=
 =?utf-8?B?SGJyeU9SbURXdmx1NThtNjZ4Vnlad3VYQW1NVnJhczl5c2xVRVFuVGFGMGsz?=
 =?utf-8?B?YVRFcjN3SUt5eERPMlhhd1dxNUg4ejJoWXJualdpRHJYWGhMSlpHQjZkdnVE?=
 =?utf-8?B?K3JId2V4QTZSbUxDSVpnQW5mNlJnVlJKaVNxTkxNaE5QZHpTbFlGVWRKMG45?=
 =?utf-8?B?OWxqVE45MEhndUdNaXFLRGJzekFiVFhyL2s4RjYvSnZ1SDMzYW9CU0NNeUtr?=
 =?utf-8?B?Um5JU0pMMUY2TjJmMC9wZ3F0SEtITUJGS0RJT3Rlb2MxWFpBNU84amo3NDJX?=
 =?utf-8?B?bDhkcXVEWjJiR2RsTk1UbHQxRzFwNE5Ha29aN0dZa2FjMk44T1VHcktJWjdM?=
 =?utf-8?B?ajZDRUt0TDZtTjhHY1FMV2pvQVRPdldlVDQyRE56WGJhTC85eXRsRTRRYjM4?=
 =?utf-8?B?Q1ZaaEt6Vk1aUWpNN2taaWlUTDAyV0dJeXpFSlN6Q290eHkweVZmcGlHVkdY?=
 =?utf-8?B?S0t3YmI4MGZCRlViak5KbllPQ2NERW4zWmdBWVo2Wkt6R2lHeTRtODlrVW9w?=
 =?utf-8?B?WUZRQkkzR3lqekUvWUdBSUhIdktrbkF0OUNyUll4cFhiWkc0dWV4akJEQ3NY?=
 =?utf-8?B?ZjBWYnRCTWxoY0U2QldEekxjSDB3TlF5dVVaVGszYjgrS1VELytGOXdDMFV3?=
 =?utf-8?B?V1NaK3AxQ0NvTUZhcENOMlFkdDZwdFRBQlRBai9TOW92ZHFPSDNqcFRzcFcx?=
 =?utf-8?B?aGpUZFhoaWxidkRuZVlnQnhtVk5TUHJjeEdYT1FEQWxuM0g1eGtaYzRPc2hm?=
 =?utf-8?B?UFIwdDVwTHU4SFVLT2JIaGZYaUhKUTNhclArQ2JvRVVFS2xqUWN0ZDhPc0RG?=
 =?utf-8?B?TmVUMy9weDUxOUIzaC91ZGg2LzNjajRSQ3Fva3dCdmdFV3lENllIQUUrT1Y5?=
 =?utf-8?B?ODBZMnpiWTl4NEFlelVnVlRHalNUSEowZ1RuaGtLRkpNVlpReENaRmxWUkRm?=
 =?utf-8?B?U0E2bW83MXFpMlg5M05zdEE4SlNLOE45NTgzTDRKRkJXSlBPekRxd0lNend2?=
 =?utf-8?B?R1hZN1JVZ01EdWZHMGM4WXJZRVlBMU5tdHFDai9rb2dVcHlJMXFBY2ZpMkVv?=
 =?utf-8?B?OEwrbzRpV0lFOVhlVlBZM3RXN0Z0WWlldUZIS1ZxZnB5RDA4NmQwSzNqcy9Q?=
 =?utf-8?B?Yk5HS3ZIZkFpaVRtdi9OUUJ5SENOeGJpWUFPVThlWmtuRmV5ZVEva1BjMjJ5?=
 =?utf-8?B?WmpERVNOSXhmUVhYYURmZTdac1QxajQ5NHVobGtJQWZ6bkNrNkpxSmtCSXpp?=
 =?utf-8?B?eFQrZFd0cEwwZ3pNWnI1SjRROE5uNEEycTF5WjJVVW0zdnhvTUNWZng2VzVZ?=
 =?utf-8?B?Tzd2c01rUTh2ZUhiKzA2d1JoNmpFV2hLOVo3OTJRUHZ2QVQxbGUzUldpN0Fz?=
 =?utf-8?B?L3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC4E3BF05DD64E4FB09CDC61B140E057@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4eI0vXYgrKFqE2KDchpeqnkBIJp/3FFlQD2R/a5iDK8Otcu86HXknQUY3XkPnhpQ8IbTpdxrhLwhCATpN33KyetYONM7tSERHFuedMap+CHh+ZkagrnYmH805KV9PHO1xWDXFais2Zj484rlJ1O6q/InQ+b3PR9unkKalJ/0ICJhfVWwUbUXiZaPc8SNLlXpXkqCLq0KpwdXk9O4jyzGKsqiJov9To4WcI2c7FJ0a2u7Xyj7gvjN7UfRKv7eI4fardvGS9ONmVLz8Orl6qbztUqtZUpBGivq9D9X3v2ZZltsMSb+4u0aHjEJyei8D/mhX6z+3mhMcB9/T+qv4ItvCU+rxgNn1gdi2oY+TA1LhIdl0RNF4qu6NR1UCFd1BI/m8sobgnAHB2vCFXm64ZN03MWTl+hx+nYNb/10JbWeCHl11SxXTK8KVanee5proTmnPqi40omrmWnIGKdPwtn6nhqXTJ6S4q16Zq/7SXsJSYpJ4sh5o3HzwJSLdGSjzddLPrll3wOMPbu9M3oq2uiLZG57htft1pS+P5e/YPe09W+FnGxhqIQDO1PZH1QPgdAot0vCKAPZhXMPVrO3buxiii+xgMQ3NPr5siSXujLwq6m0gBoT6q1yHKojVI8OwllR4W7H0xtqWMnunBlu5oRXvFQVtDswm80dt5jnTYaDX8NhxOsUVBYO3eebQG6L2ROhNdZPgIWbzQLESTjXITv0lZbiVuvjJCG79gIzPzQrdbOB0A8Ao2/RpdE8+JLKO9dDHtNQ7OVyUzhFVj23JuKGXUZgFc8I8Oo7ogSk82LXINrDlvWsfCZuv+IrQUb+xC/odMjnzCSzlvumHPrQUKykGA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04731c1b-7300-4e2e-b59e-08dbe2421d2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 23:09:38.7992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFVE1ORjziWoYmJj6L9zMmzQYSa5KE7goKWv95Wi3+lwBLzU+tdDecFNgEiI2Tx9+Uol7zM0rUY34xzCNCGuCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
X-Proofpoint-GUID: VR7kCxgPZXs3vI73A8rkOeL03fu567GY
X-Proofpoint-ORIG-GUID: VR7kCxgPZXs3vI73A8rkOeL03fu567GY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_21,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=840
 phishscore=0 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311100192
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBOb3YgMDIsIDIwMjMsIE1hbmFuIEF1cm9yYSB3cm90ZToNCj4gU3VwcG9ydCBjb25m
aWd1cmF0aW9uIGFuZCB1c2Ugb2YgYnVsayBlbmRwb2ludHMgaW4gdGhlIHNvLWNhbGxlZCBFQkMN
Cj4gbW9kZSBkZXNjcmliZWQgaW4gdGhlIERCQ191c2IzMSBkYXRhYm9vayAoYXBwZW5kaXggRSkN
Cj4gDQo+IEFkZGVkIGEgYml0IGZpZm9fbW9kZSB0byB1c2JfZXAgdG8gaW5kaWNhdGUgdG8gdGhl
IFVEQyBkcml2ZXIgdGhhdCBhDQo+IHNwZWNpZmljIGVuZHBvaW50IGlzIHRvIG9wZXJhdGUgaW4g
dGhlIEVCQyAob3IgZXF1aXZhbGVudCkgbW9kZSB3aGVuDQo+IGVuYWJsZWQNCg0KVGhpcyBzaG91
bGQgYmUgdW5pcXVlIHRvIGR3YzMsIGFuZCBpdCdzIG9ubHkgZm9yIGJ1bGsuIEkgZG9uJ3QgdGhp
bmsNCnVzYl9lcCBvciB0aGUgdXNlciBvZiB1c2JfZXAgc2hvdWxkIGtub3cgdGhpcy4NCg0KQWxz
byBzaW5jZSBEV0MzX0RFUENGR19FQkNfSFdPX05PV0IgbXVzdCBiZSBzZXQsIHRoZSBjb250cm9s
bGVyIGRvZXMgbm90DQp3cml0ZSBiYWNrIHRvIHRoZSBUUkIuIERpZCB5b3UgaGFuZGxlIGhvdyB0
aGUgZHJpdmVyIHdvdWxkIHVwZGF0ZSB0aGUNCnVzYiByZXF1ZXN0IG9uIGNvbXBsZXRpb24/IChl
LmcuIGhvdyBtdWNoIHdhcyB0cmFuc2ZlcnJlZCkuDQoNCkJSLA0KVGhpbmgNCg0KPiANCj4gQWRk
ZWQgbWFjcm9zIGZvciBiaXRzIDE1IGFuZCAxNCBvZiBERVBDRkcgcGFyYW1ldGVyIDEgdG8gaW5k
aWNhdGUgRUJDDQo+IG1vZGUgYW5kIHdyaXRlIGJhY2sgYmVoYXZpb3VyLiBUaGVzZSBiaXRzIHdp
bGwgYmUgc2V0IHRvIDEgd2hlbg0KPiBjb25maWd1cmluZyBhbiBFQkMgZW5kcG9pbnQgYXMgZGVz
Y3JpYmVkIGluIHRoZSBwcm9ncmFtbWluZyBndWlkZQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFu
YW4gQXVyb3JhIDxtYXVyb3JhQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdj
My9jb3JlLmggICAgfCAxICsNCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgIHwgNiArKysr
KysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmggIHwgMiArKw0KPiAgaW5jbHVkZS9saW51
eC91c2IvZ2FkZ2V0LmggfCA0ICsrKysNCj4gIDQgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9u
cygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVy
cy91c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXggZWZlNmNhZjRkMGU4Li5jNWI1NzgxODhjZDMgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNi
L2R3YzMvY29yZS5oDQo+IEBAIC0zNzQsNiArMzc0LDcgQEANCj4gIC8qIEdsb2JhbCBIV1BBUkFN
UzQgUmVnaXN0ZXIgKi8NCj4gICNkZWZpbmUgRFdDM19HSFdQQVJBTVM0X0hJQkVSX1NDUkFUQ0hC
VUZTKG4pCSgoKG4pICYgKDB4MGYgPDwgMTMpKSA+PiAxMykNCj4gICNkZWZpbmUgRFdDM19NQVhf
SElCRVJfU0NSQVRDSEJVRlMJCTE1DQo+ICsjZGVmaW5lIERXQzNfRVhUX0JVRkZfQ09OVFJPTAkJ
QklUKDIxKQ0KPiAgDQo+ICAvKiBHbG9iYWwgSFdQQVJBTVM2IFJlZ2lzdGVyICovDQo+ICAjZGVm
aW5lIERXQzNfR0hXUEFSQU1TNl9CQ1NVUFBPUlQJCUJJVCgxNCkNCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGlu
ZGV4IDg1OGZlNGMyOTliNy4uNDdkMjczN2Q1MjhiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAg
LTY3Myw2ICs2NzMsMTIgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9zZXRfZXBfY29uZmlnKHN0
cnVjdCBkd2MzX2VwICpkZXAsIHVuc2lnbmVkIGludCBhY3Rpb24pDQo+ICAJCXBhcmFtcy5wYXJh
bTEgfD0gRFdDM19ERVBDRkdfQklOVEVSVkFMX00xKGJJbnRlcnZhbF9tMSk7DQo+ICAJfQ0KPiAg
DQo+ICsJaWYgKGRlcC0+ZW5kcG9pbnQuZmlmb19tb2RlKSB7DQo+ICsJCWlmICghKGR3Yy0+aHdw
YXJhbXMuaHdwYXJhbXM0ICYgRFdDM19FWFRfQlVGRl9DT05UUk9MKSkNCj4gKwkJCXJldHVybiAt
RUlOVkFMOw0KPiArCQlwYXJhbXMucGFyYW0xIHw9IERXQzNfREVQQ0ZHX0VCQ19IV09fTk9XQiB8
IERXQzNfREVQQ0ZHX1VTRV9FQkM7DQo+ICsJfQ0KPiArDQo+ICAJcmV0dXJuIGR3YzNfc2VuZF9n
YWRnZXRfZXBfY21kKGRlcCwgRFdDM19ERVBDTURfU0VURVBDT05GSUcsICZwYXJhbXMpOw0KPiAg
fQ0KPiAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5oIGIvZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuaA0KPiBpbmRleCA1NWE1NmNmNjdkNzMuLmZkN2E0ZTk0Mzk3ZSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuaA0KPiArKysgYi9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5oDQo+IEBAIC0yNiw2ICsyNiw4IEBAIHN0cnVjdCBkd2MzOw0KPiAg
I2RlZmluZSBEV0MzX0RFUENGR19YRkVSX05PVF9SRUFEWV9FTglCSVQoMTApDQo+ICAjZGVmaW5l
IERXQzNfREVQQ0ZHX0ZJRk9fRVJST1JfRU4JQklUKDExKQ0KPiAgI2RlZmluZSBEV0MzX0RFUENG
R19TVFJFQU1fRVZFTlRfRU4JQklUKDEzKQ0KPiArI2RlZmluZSBEV0MzX0RFUENGR19FQkNfSFdP
X05PV0IJQklUKDE0KQ0KPiArI2RlZmluZSBEV0MzX0RFUENGR19VU0VfRUJDCQlCSVQoMTUpDQo+
ICAjZGVmaW5lIERXQzNfREVQQ0ZHX0JJTlRFUlZBTF9NMShuKQkoKChuKSAmIDB4ZmYpIDw8IDE2
KQ0KPiAgI2RlZmluZSBEV0MzX0RFUENGR19TVFJFQU1fQ0FQQUJMRQlCSVQoMjQpDQo+ICAjZGVm
aW5lIERXQzNfREVQQ0ZHX0VQX05VTUJFUihuKQkoKChuKSAmIDB4MWYpIDw8IDI1KQ0KPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC91c2IvZ2FkZ2V0LmggYi9pbmNsdWRlL2xpbnV4L3VzYi9n
YWRnZXQuaA0KPiBpbmRleCA2NTMyYmViNTg3YjEuLmM1MjZhZTA5YmNlZSAxMDA2NDQNCj4gLS0t
IGEvaW5jbHVkZS9saW51eC91c2IvZ2FkZ2V0LmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC91c2Iv
Z2FkZ2V0LmgNCj4gQEAgLTIwOSw2ICsyMDksOSBAQCBzdHJ1Y3QgdXNiX2VwX2NhcHMgew0KPiAg
ICoJYnkgdGhpcyBFUCAoMCAtIDE2LCBhY3R1YWwgbnVtYmVyIGlzIDJebikNCj4gICAqIEBtdWx0
OiBtdWx0aXBsaWVyLCAnbXVsdCcgdmFsdWUgZm9yIFNTIElzb2MgRVBzDQo+ICAgKiBAbWF4YnVy
c3Q6IHRoZSBtYXhpbXVtIG51bWJlciBvZiBidXJzdHMgc3VwcG9ydGVkIGJ5IHRoaXMgRVAgKGZv
ciB1c2IzKQ0KPiArICogQGZpZm9fbW9kZTogaW5kaWNhdGVzIHRoYXQgdGhlIGNvbnRyb2wgb2Yg
dGhpcyBFUCBpcyBoYW5kZWQgb2ZmIHRvIGFuDQo+ICsgKgloYXJkd2FyZSBmaWZvIGRldmljZS4g
RGVwZW5kcyBvbiBoYXJkd2FyZSBzdXBwb3J0IGVnLiBFQkMgZmVhdHVyZQ0KPiArICoJb2YgRFdD
IHVzYjMuMSBkZXZpY2Ugb3IgZXF1aXZhbGVudC4gU2V0IGJlZm9yZSBlbmFibGluZyB0aGUgRVAN
Cj4gICAqIEBkcml2ZXJfZGF0YTpmb3IgdXNlIGJ5IHRoZSBnYWRnZXQgZHJpdmVyLg0KPiAgICog
QGFkZHJlc3M6IHVzZWQgdG8gaWRlbnRpZnkgdGhlIGVuZHBvaW50IHdoZW4gZmluZGluZyBkZXNj
cmlwdG9yIHRoYXQNCj4gICAqCW1hdGNoZXMgY29ubmVjdGlvbiBzcGVlZA0KPiBAQCAtMjM2LDYg
KzIzOSw3IEBAIHN0cnVjdCB1c2JfZXAgew0KPiAgCXVuc2lnbmVkCQltYXhfc3RyZWFtczoxNjsN
Cj4gIAl1bnNpZ25lZAkJbXVsdDoyOw0KPiAgCXVuc2lnbmVkCQltYXhidXJzdDo1Ow0KPiArCXVu
c2lnbmVkCQlmaWZvX21vZGU6MTsNCj4gIAl1OAkJCWFkZHJlc3M7DQo+ICAJY29uc3Qgc3RydWN0
IHVzYl9lbmRwb2ludF9kZXNjcmlwdG9yCSpkZXNjOw0KPiAgCWNvbnN0IHN0cnVjdCB1c2Jfc3Nf
ZXBfY29tcF9kZXNjcmlwdG9yCSpjb21wX2Rlc2M7DQo+IC0tIA0KPiAyLjQyLjAuODIwLmc4M2E3
MjFhMTM3LWdvb2cNCj4g
