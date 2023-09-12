Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A1979D74A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbjILRLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjILRLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:11:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B74110;
        Tue, 12 Sep 2023 10:11:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CH4jY0026203;
        Tue, 12 Sep 2023 17:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=GazmCyxiMQQPzRVz1CFRy6xOVzOkMzV2ctbNLk+UqjU=;
 b=SbO1w+MvKjBjv3ayQYw3K0WIMOeRdd+hsTOqbmHSTFbVoUg2b1IbC9bK9R15p4XCMZYQ
 YPhhhKjGlzjB9DP2xtWe2B6iSxzhi/11N47OMQhE/fcR3OK4SJ08p+NLEbV7k/i+0K3E
 Vvy0Lh5q+fmXAyeif+zi+tgPAEi0BzDdiLv+FaKgHjbqpaWj2/mQRGocjh2v68YudLyw
 dSq0AaL93vDs7SeJXCD0ADpo9Bljx/yUX6b1cRywnvIxYfJNM7tH67/aS3M+R7ThwwK3
 eOYT2iDoAvzxoMba/zioaG/BXVjrtkGyTIPthR+KMSU32cfnkduvw/iBTpBaYF6eBWAm zA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jhqcj2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 17:11:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38CG7KUT002283;
        Tue, 12 Sep 2023 17:11:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5cav6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 17:11:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTKR/5b9PBF3M7cl3Wjs1RK2tZgP2DvQRIqPtl6A+lRk/lGNCBaF6Mnh/sX1r+/zGq9mHeuzGWJ42NhNnVyleewih8Lp482cAx/HqS01Mdol+aP/a1fyj7NvtN5f6pM1VP5dke1AIUVTSePYaL9PdhReJSYF8S6lQPIcjShMGpbepjqNL6hYe4DwEa10VlHElwnU9eHhLAYyMUUjRNWbbEQmDXRbG5l6UKApXe+6IooyEYO3m67Vtnx+vxVA25h191rUdWOmOC8Joe0WXyDGthefCjADfhB4s/R54xOtg9wvotumZAoqSVK6KNCr16u5YMWjib0+S20vvSz9icUd8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GazmCyxiMQQPzRVz1CFRy6xOVzOkMzV2ctbNLk+UqjU=;
 b=Kr6AIKrC8ex2dIwmyM2nvVS9PN/CjruQ3j1Fh5HwIxjhBJ+5TRnMqMsFi5YyoLFg4oZqjAcdOg5KJf6dcs1vLcEoSmbLJO7vLqgYC8DZlTIGrkHXhwfixKjehFk2/xLD2Jo9qD8tVVBKr44lrJxZm5qjw4wuJHEhTwJUj/cFqSB+w6M7gbm0mY051BwBFd2fPwx8IMX+lIesup2mw7Z4wvjjbb2OFLvMTzO8pqjybhVEFKyZmEaFkDBAlvlP2R0XGEHdtlwhrGpTJzn47Z8cCIdagWFQmYBOtReuJddS6A9heej2dSWht5kdMdkNGvhcLhdKAQyJZ3GT1Z6oemmIMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GazmCyxiMQQPzRVz1CFRy6xOVzOkMzV2ctbNLk+UqjU=;
 b=wNZ1DUKWOh779gch8gPxc9W2dFAS0JNSRaHX6De7YM98mQfIB3Y16RuETkHR5oHu/6osmpYMIk0BdB6wf1ibPZe0sZQmzWq0KvGjvf0FowvFxNuc2fLaQYibuqHiP4eZ8jNhkOHinsT5QKvto84LMRr3ZYc62C1hPMCTyLd45Cg=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SJ0PR10MB5836.namprd10.prod.outlook.com (2603:10b6:a03:3ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 17:11:00 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::3f7b:855:6a95:8aed]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::3f7b:855:6a95:8aed%4]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 17:11:00 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "mic@linux.microsoft.com" <mic@linux.microsoft.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH] certs: Restrict blacklist updates to the secondary
 trusted keyring
Thread-Topic: [PATCH] certs: Restrict blacklist updates to the secondary
 trusted keyring
Thread-Index: AQHZ4p0BkG9ylPk27Eafo4TPmLwJdbAVoqeAgAA4j4CAAFsjgIAADhYAgAAwIgCAAKYcAIAAWEmA
Date:   Tue, 12 Sep 2023 17:11:00 +0000
Message-ID: <FD6FB139-F901-4E55-9705-E7B0023BDBA8@oracle.com>
References: <20230908213428.731513-1-eric.snowberg@oracle.com>
 <097a0413b27ed9792dc598ff184730bcf6ae8fcf.camel@linux.ibm.com>
 <20230911.chaeghaeJ4ei@digikod.net>
 <CEA476C1-4CE5-4FFC-91D7-6061C8605B18@oracle.com>
 <ba2f5560800608541e81fbdd28efa9875b35e491.camel@linux.ibm.com>
 <932231F5-8050-4436-84B8-D7708DC43845@oracle.com>
 <7335a4587233626a39ce9bc8a969957d7f43a34c.camel@linux.ibm.com>
In-Reply-To: <7335a4587233626a39ce9bc8a969957d7f43a34c.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|SJ0PR10MB5836:EE_
x-ms-office365-filtering-correlation-id: ee540172-23d2-42e7-036c-08dbb3b33ccc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YodDlUjUdPvRYkiq7a5NzSnuDn/Do0xkvYC8g88pJzrmGylQBGWzKxvhK197bMioZvo/d6xQNGbRjvAWKQKZu4Rs25ErpukJ3s28X9bv0VSdxwRoqBS14YCIssILzRUtkCpf+KgHf2ae0unopwdxqQkNW+GyZlndCELsnpGJ5L7zkT9b51Lj4UJ3c0EsTDcSgqzncdZHrOUkrKoIZBm8TouO4wEx5iFyW1oQflXQ+WnAFp7i41qnZ2Fdon+WzV6Gh4eet/nV3k8UJXtAmEplHupcDV3L8zAfaZoN4jhsSctzMayPpExYi11IYFrjJpoB0DmUUa0BWELPJXP/WiJySD17MeMf5N2+eD0Ja5JbJ0ywTefhBEHrHnmUVsyXzFvO3Slw0Mt7njzCFmbf1Ggx6FYyaWHt6akXU3Ea4BCvfwrjqcja/jgSw9pTVb1KAPtXgkqbZQbBy6gSBFGWmwOdbKtJf+Wt49HtMFBOnSXGGNbZlH/fCqDAe4i3Xo1yCihVWVMHZRoj/Zk9b2iZLRf6IGi+dmonAxLkgbi25yYi0RGWY8kd+54eE7hqGmaaLQQn/uA5FraqfWzgwgfg+IokOG9qrHPRDbilGjIOUnIWWRX8m2VbGblRab0udInloBBX+wALtQDSVZ9psWfDg8a1vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39860400002)(1800799009)(451199024)(186009)(15650500001)(66574015)(2906002)(38100700002)(38070700005)(36756003)(33656002)(86362001)(122000001)(4326008)(6506007)(26005)(2616005)(8676002)(8936002)(66946007)(44832011)(66476007)(66556008)(66446008)(64756008)(41300700001)(53546011)(6512007)(316002)(76116006)(110136005)(54906003)(91956017)(5660300002)(71200400001)(966005)(7416002)(6486002)(83380400001)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2w1WERodHRETFhaSmYyR05rZU1Jb1FydzNSTE5ncnl1NUVKY2RWT2ZhT1FE?=
 =?utf-8?B?ZkQvbUZSalVYQTFkQWwvbytVT1pTdDU1THdFL2RENTVkNEZucGUyTzBudGxW?=
 =?utf-8?B?OW5Ybm5vQ3lEejNLUWZtRlRnSkZrcEFzT1FVc1pMWnhDVDVJbzg1QlRVelp1?=
 =?utf-8?B?UWxxV0tXM2Z0TUIxc1FtcFpERmZUOEpFRHZ4Qmd6ZXJiZkxPOERRNXZEQXdn?=
 =?utf-8?B?aHU3OFUrandmVllTUHljMGtDT3RldkcwYkxuRHVKWUpHTFFacExkUmJaMEdP?=
 =?utf-8?B?cjFjdDZqNGtsNjVkbXFCYW1oMjRIUllqNmRzWGJZN3dON0pDT2pka2ZmM0Za?=
 =?utf-8?B?WEliVmEwd3ZpZEN1RVdzcTE5bmVmdGYvaDM3OFJCYUpGOFVJT3ZPSzA4VUhT?=
 =?utf-8?B?RVJKMno2cjhkTnA2N25hUEd1Uzl5UFZiOThqWFFjaUFxamZ1VkdXSDEzQTRC?=
 =?utf-8?B?WVIya1lNVWV4MkpGK0RYR0VRN2RFaXorMzZYdHRRNGdtZmxXTk9pc3crZWJO?=
 =?utf-8?B?OG1WWXo3Yi9oUjF1czEvQ1Y0eDlsMzJnVWFyRk9CTEVvM3V6bmxFaG9IYjFC?=
 =?utf-8?B?Z010VkVCeVU2YmZyZkZ5WC9zOUp0bHdQdEgwa3lDNTVtcUc2L1hrd3AwR0Ra?=
 =?utf-8?B?aW8zdGorMkNYYjhUYnZaakRUWGZrUGh3NWRrcUdBRmRDZ0NFNzFpTjFUZTY0?=
 =?utf-8?B?MW1lSEg1Qko3YmducGF1MkVmNnBXVnk3SGlLM2ViOXBoakpIZEFBSjZrTjJC?=
 =?utf-8?B?QklpVE5Xc0t3aUxvSlhPQlVSRzFYb1FGS2F6R29HcWdBYjBvYlVCa0tUdlRD?=
 =?utf-8?B?RmV5aWIwU3pkSmdOUC9jZmRMUEk3YjFRaVRKMllaRlVuenBYcTZOQTdiblIv?=
 =?utf-8?B?eUN6UGpzOFkvSGFIdmpuQ2lSME50Wm1sWW1ZWGs3MDFzS3pNaWRVeDkwNzIy?=
 =?utf-8?B?ZGJUNTNnbTVpWXlEM0Voc1BqaFZNUDdnb25pc0syZCtyMVE0Q0x5RWlzaGs2?=
 =?utf-8?B?ZlllVGJMOVU4VTJ1bTAwNFFaejNJbXdOVm5YcW5vTXZwMzQySVVXL2ZJR3cv?=
 =?utf-8?B?QkdrM0lDZ2lwU3RJQWtrSUM3aGRiMU80aUpHdlhqQlpsWFRBSlVldUR4SEl6?=
 =?utf-8?B?S0hBd0tZcFJvcGF2OFVpZUFrRHNZeUpxNzNzaHVOaXVCTzZZMGpwYnlVR2dm?=
 =?utf-8?B?SXJDUStScDJUMnpFTlNTbjhyTVVMZ2VBQzd5TXBWVXJGczRBSC9ydkluQTJj?=
 =?utf-8?B?VG9Va0FTNEZjSEdPeWU0UkJuZW9hdFZESkY1bUZqUVR3K0VVYTJFL3RiRE93?=
 =?utf-8?B?QlAxNFREbGFNOFNLZlA2VDVwZlNBbHBCSFZoMFhnMTFWNm1vYnRBQ011aXBy?=
 =?utf-8?B?emZRSitBamI1bzREUkdUbUhoa25sVVUzMkhyWm5JUURuNVNSZlJyL3A2Mkc5?=
 =?utf-8?B?UmdUNnFXT2RlL3hyMnRDUnVoM3Q0MUJZUzFJMlJKaFNJcTFyUW9vaDRIcUFQ?=
 =?utf-8?B?OGViakEwc1V0Vkd2Ni9GZ1NMVzFuTmFZWVBOUzI4VlplaGtScXZJSnkydmJi?=
 =?utf-8?B?cktidVh4R1E0ZVIydzZ2dmNHaTcyWWRzVG5SYjFxdzNvY0M0WnVEcmlUYWFv?=
 =?utf-8?B?RHJVYkFxMjRILzRBSFBDNkxBWXhQSExzdWhIcTIrQkEzVWxCZmRpWFZtNVp4?=
 =?utf-8?B?eGVtUkJwN3hCaGVrNjZZeGFYY1NVTVdzUGdVYlkwclNTdTJ0VjRFckR0RHNT?=
 =?utf-8?B?YnhJd1o5T0tLcHdBQ2FjZWZWTzlkQld1RlpXU2tuYVIyWDI1NEgwNXV0NDNB?=
 =?utf-8?B?a2RLbGxzdjh5c3NkT0hyZlFKaGcwUUJ3ZHVhVVJ3YkZqR3h1a2g1LzBwRnBR?=
 =?utf-8?B?MlB1Vjd1UThvejlUUG5HVEpOaitsS0hGTFJGNGQxVmgvTFp0T0FackxIRVg4?=
 =?utf-8?B?SWpJcmZFajJoaW1oMmxhdUVZNEZoSWgxT2ZBWVJKU2hNZ1lMMkFLYktoQTZa?=
 =?utf-8?B?eXBzQnViMkV0WUZjazVCbUhVNnhVUC9FcXhYbjhIKzJWRkh3Z1BoVEYwK3pp?=
 =?utf-8?B?SzliVzd6R1c0cFA2a2lZVnhNMDV5MTJsbE9GQzJJRXhDQ0VoNVJ4V3crUDcr?=
 =?utf-8?B?NlRiY2QzY0lOS0hSMjd5WEdxZk10U0hxUjFWWm1uQTFTNjZMMWw4Q2hZckpC?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6487EDFC0317647B7CE7A0A77FEF8D9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a0xGa1lReVZ6RTNFUVJkdkhSdi9RRnNGTENlU1VuRmtNcGNqb0NUeGZXYUk1?=
 =?utf-8?B?VzgzczMxVDdCd203WU5laC9VMnBzQkxuWWd5R1VlaWUyWGRzeDNYc0w4Sk8z?=
 =?utf-8?B?QVRDdm96M1c2ZE5yemk4U3paZVRZc0pCTVNlNnpiSG1nNWhvVmJOQWxjL0Q1?=
 =?utf-8?B?Y3lpbnNaZmFmcXlkV0hWM0o4dFlmSU4xVWpIbHBuRkNGYU1JR2hXOEMyakdo?=
 =?utf-8?B?L2tSdFY4aWErSUFyenRJNUhpL0RibDMrUmZYTDVUYTBxb0dCUDV5RGJidnVk?=
 =?utf-8?B?Vmc0c3RNNHRzVG5tUnpGWkV2bWRvRFdsblZsOXhaK0hXMHgrYk1TZFpkUkwv?=
 =?utf-8?B?ankzMnZtNDkxZjVEZnlRamNPQ1hJVjc1dlpnM3BLTnhmUld6S3NSOHNSS2lk?=
 =?utf-8?B?QWloZ3ZmK3dia3N5d1RMRXBZYVgwNXpneHFiZzRVTkdNSGJtUGRTcld0aG1B?=
 =?utf-8?B?YSt3ZXRZRDQzdFBPNFZXMTEwV1ZSekttS3V3NE1rb2NEL2hnWVIyM3RJaEN4?=
 =?utf-8?B?RFA2VCswcWhZY3FHRjVEakRUMWFjMmdVQ2tON0I0UjdORXVWTGFtejNRNThF?=
 =?utf-8?B?bUVqYXdjYUIvVjlaMzl0QklRamZLWkpkeXMwRFkyOEpxbWhDaXkvckV2Y2xB?=
 =?utf-8?B?TEswMitMQW1wVk1oUVVNeDdDempBUkd4MGNpZEVaY2MvNFFzaTgxaU4yaG1z?=
 =?utf-8?B?RjBvWk5HWmhlbGt4cXlkdUhKWDZvSUhJOTVKMlV0R0U0RDlqYVdncWZ4N0dx?=
 =?utf-8?B?SlpEcUs4YVdrV053RDVKa05ROWVZZlBiUnlWdXptVEJxYVpCMWd5YU4ramdm?=
 =?utf-8?B?R1pUZ09GejJnY1AvNFI5R0QwSEFsdTUyNWNkZFlZWnFoaUMzV0t0VDFMVHZY?=
 =?utf-8?B?bGMvcnJ2b1lxVHNMamY2ZWxidmwyVlVuOTlpRVpTdmJPOEpicSt6b1lzdUdT?=
 =?utf-8?B?bllVYkhCWGtVaWttQlVDVW1CbXRzUk5ZZFlTOHlqMXNGNWhqQjZYTGZMcjJ4?=
 =?utf-8?B?Zko1NnVoREpoRld5Z2NKYVdaVUt0bGpMZzlBc25UcjV0VU9tM2d2MkdocjlL?=
 =?utf-8?B?VEVRNWxJVE5mRmZUai95ZVE5REpCUnZNbi9XTW1TUDlRK3h6V0JOWVIrYWQy?=
 =?utf-8?B?TlZrdnBNVC9tcEpNbG1VQnNLenAxSjV5a0pTdGVNYXVTWWxUZDJacUJhMnJy?=
 =?utf-8?B?MVByU2JHTDNBQlp5alZJUkFkM2lDMGhQZ2M3bjROb21VZUwwRkhLY1ZueCsx?=
 =?utf-8?B?eUhSMkRramJ3d1huVEI2T24rYkVmQVd6VGNFdzRvMEdsVXA2WHZ0MTN2dmk5?=
 =?utf-8?B?MzYxUkhMekwrNDBWOTNzeWhZS05oV2NTUXlleTF1QU4yUjdRaXQxVU9PLzB1?=
 =?utf-8?B?UW9MRTIwaHhvQ3c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee540172-23d2-42e7-036c-08dbb3b33ccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 17:11:00.2960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +D/ws+eIAE5hH9q9RVpo6NGV6irI+bPQluQFBPeKycMr++xQdb9su+lzC4cMKOGc6d9l6DT+Y0td9wq9skDmDxlQvaG8JfL4GiUaAMe/aFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5836
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_16,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120144
X-Proofpoint-ORIG-GUID: GFuxv7VtLCGWHUdc6OGDIpViXNcBNHZj
X-Proofpoint-GUID: GFuxv7VtLCGWHUdc6OGDIpViXNcBNHZj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gU2VwIDEyLCAyMDIzLCBhdCA1OjU0IEFNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51
eC5pYm0uY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgMjAyMy0wOS0xMiBhdCAwMjowMCArMDAw
MCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IA0KPj4+IE9uIFNlcCAxMSwgMjAyMywgYXQgNTow
OCBQTSwgTWltaSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4g
T24gTW9uLCAyMDIzLTA5LTExIGF0IDIyOjE3ICswMDAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0K
Pj4+PiANCj4+Pj4+IE9uIFNlcCAxMSwgMjAyMywgYXQgMTA6NTEgQU0sIE1pY2thw6tsIFNhbGHD
vG4gPG1pY0BkaWdpa29kLm5ldD4gd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IE9uIE1vbiwgU2VwIDEx
LCAyMDIzIGF0IDA5OjI5OjA3QU0gLTA0MDAsIE1pbWkgWm9oYXIgd3JvdGU6DQo+Pj4+Pj4gSGkg
RXJpYywNCj4+Pj4+PiANCj4+Pj4+PiBPbiBGcmksIDIwMjMtMDktMDggYXQgMTc6MzQgLTA0MDAs
IEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+Pj4+Pj4+IEN1cnJlbnRseSByb290IGNhbiBkeW5hbWlj
YWxseSB1cGRhdGUgdGhlIGJsYWNrbGlzdCBrZXlyaW5nIGlmIHRoZSBoYXNoDQo+Pj4+Pj4+IGJl
aW5nIGFkZGVkIGlzIHNpZ25lZCBhbmQgdm91Y2hlZCBmb3IgYnkgdGhlIGJ1aWx0aW4gdHJ1c3Rl
ZCBrZXlyaW5nLg0KPj4+Pj4+PiBDdXJyZW50bHkga2V5cyBpbiB0aGUgc2Vjb25kYXJ5IHRydXN0
ZWQga2V5cmluZyBjYW4gbm90IGJlIHVzZWQuDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBLZXlzIHdpdGhp
biB0aGUgc2Vjb25kYXJ5IHRydXN0ZWQga2V5cmluZyBjYXJyeSB0aGUgc2FtZSBjYXBhYmlsaXRp
ZXMgYXMNCj4+Pj4+Pj4gdGhlIGJ1aWx0aW4gdHJ1c3RlZCBrZXlyaW5nLiAgUmVsYXggdGhlIGN1
cnJlbnQgcmVzdHJpY3Rpb24gZm9yIHVwZGF0aW5nDQo+Pj4+Pj4+IHRoZSAuYmxhY2tsaXN0IGtl
eXJpbmcgYW5kIGFsbG93IHRoZSBzZWNvbmRhcnkgdG8gYWxzbyBiZSByZWZlcmVuY2VkIGFzDQo+
Pj4+Pj4+IGEgdHJ1c3Qgc291cmNlLiAgU2luY2UgdGhlIG1hY2hpbmUga2V5cmluZyBpcyBsaW5r
ZWQgdG8gdGhlIHNlY29uZGFyeQ0KPj4+Pj4+PiB0cnVzdGVkIGtleXJpbmcsIGFueSBrZXkgd2l0
aGluIGl0IG1heSBhbHNvIGJlIHVzZWQuDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBBbiBleGFtcGxlIHVz
ZSBjYXNlIGZvciB0aGlzIGlzIElNQSBhcHByYWlzYWwuICBOb3cgdGhhdCBJTUEgYm90aA0KPj4+
Pj4+PiByZWZlcmVuY2VzIHRoZSBibGFja2xpc3Qga2V5cmluZyBhbmQgYWxsb3dzIHRoZSBtYWNo
aW5lIG93bmVyIHRvIGFkZA0KPj4+Pj4+PiBjdXN0b20gSU1BIENBIGNlcnRzIHZpYSB0aGUgbWFj
aGluZSBrZXlyaW5nLCB0aGlzIGFkZHMgdGhlIGFkZGl0aW9uYWwNCj4+Pj4+Pj4gY2FwYWJpbGl0
eSBmb3IgdGhlIG1hY2hpbmUgb3duZXIgdG8gYWxzbyBkbyByZXZvY2F0aW9ucyBvbiBhIHJ1bm5p
bmcNCj4+Pj4+Pj4gc3lzdGVtLg0KPj4+Pj4+PiANCj4+Pj4+Pj4gSU1BIGFwcHJhaXNhbCB1c2Fn
ZSBleGFtcGxlIHRvIGFkZCBhIHJldm9jYXRpb24gZm9yIC91c3IvZm9vOg0KPj4+Pj4+PiANCj4+
Pj4+Pj4gc2hhMjU2c3VtIC9iaW4vZm9vIHwgYXdrICd7cHJpbnRmICJiaW46IiAkMX0nID4gaGFz
aC50eHQNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IG9wZW5zc2wgc21pbWUgLXNpZ24gLWluIGhhc2gudHh0
IC1pbmtleSBtYWNoaW5lLXByaXZhdGUta2V5LnBlbSBcDQo+Pj4+Pj4+ICAgICAtc2lnbmVyIG1h
Y2hpbmUtY2VydGlmaWNhdGUucGVtIC1ub2F0dHIgLWJpbmFyeSAtb3V0Zm9ybSBERVIgXA0KPj4+
Pj4+PiAgICAgLW91dCBoYXNoLnA3cw0KPj4+Pj4+PiANCj4+Pj4+Pj4ga2V5Y3RsIHBhZGQgYmxh
Y2tsaXN0ICIkKDwgaGFzaC50eHQpIiAlOi5ibGFja2xpc3QgPCBoYXNoLnA3cw0KPj4+Pj4+PiAN
Cj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogRXJpYyBTbm93YmVyZyA8ZXJpYy5zbm93YmVyZ0BvcmFj
bGUuY29tPg0KPj4+Pj4+IA0KPj4+Pj4+IFRoZSBzZWNvbmRhcnkga2V5cmluZyBtYXkgaW5jbHVk
ZSBib3RoIENBIGFuZCBjb2RlIHNpZ25pbmcga2V5cy4gIFdpdGgNCj4+Pj4+PiB0aGlzIGNoYW5n
ZSBhbnkga2V5IGxvYWRlZCBvbnRvIHRoZSBzZWNvbmRhcnkga2V5cmluZyBtYXkgYmxhY2tsaXN0
IGENCj4+Pj4+PiBoYXNoLiAgV291bGRuJ3QgaXQgbWFrZSBtb3JlIHNlbnNlIHRvIGxpbWl0IGJs
YWNrbGlzdGluZw0KPj4+Pj4+IGNlcnRpZmljYXRlcy9oYXNoZXMgdG8gYXQgbGVhc3QgQ0Ega2V5
cz8gDQo+Pj4+PiANCj4+Pj4+IFNvbWUgb3BlcmF0aW9uYWwgY29uc3RyYWludHMgbWF5IGxpbWl0
IHdoYXQgYSBDQSBjYW4gc2lnbi4NCj4+Pj4gDQo+Pj4+IEFncmVlZC4gIA0KPj4+PiANCj4+Pj4g
SXMgdGhlcmUgcHJlY2VkZW50cyBmb3IgcmVxdWlyaW5nIHRoaXMgUy9NSU1FIHRvIGJlIHNpZ25l
ZCBieSBhIENBPyANCj4+Pj4gDQo+Pj4+PiBUaGlzIGNoYW5nZSBpcyBjcml0aWNhbCBhbmQgc2hv
dWxkIGJlIHRpZWQgdG8gYSBkZWRpY2F0ZWQga2VybmVsIGNvbmZpZw0KPj4+Pj4gKGRpc2FibGVk
IGJ5IGRlZmF1bHQpLCBvdGhlcndpc2UgZXhpc3Rpbmcgc3lzdGVtcyB1c2luZyB0aGlzIGZlYXR1
cmUNCj4+Pj4+IHdpbGwgaGF2ZSB0aGVpciB0aHJlYXQgbW9kZWwgYXV0b21hdGljYWxseSBjaGFu
Z2VkIHdpdGhvdXQgbm90aWNlLg0KPj4+PiANCj4+Pj4gVG9kYXkgd2UgaGF2ZSBJTlRFR1JJVFlf
Q0FfTUFDSElORV9LRVlSSU5HX01BWC4gIFRoaXMgY2FuIA0KPj4+PiBiZSBlbmFibGVkIHRvIGVu
Zm9yY2UgQ0EgcmVzdHJpY3Rpb25zIG9uIHRoZSBtYWNoaW5lIGtleXJpbmcuICBNaW1pLCB3b3Vs
ZCANCj4+Pj4gdGhpcyBiZSBhIHN1aXRhYmxlIHNvbHV0aW9uIGZvciB3aGF0IHlvdSBhcmUgYWZ0
ZXI/DQo+Pj4gDQo+Pj4gVGhlcmUgbmVlZHMgdG8gYmUgc29tZSBjb3JyZWxhdGlvbiBiZXR3ZWVu
IHRoZSBmaWxlIGhhc2hlcyBiZWluZyBhZGRlZA0KPj4+IHRvIHRoZSBibGFja2xpc3QgYW5kIHRo
ZSBjZXJ0aWZpY2F0ZSB0aGF0IHNpZ25lZCB0aGVtLiAgV2l0aG91dCB0aGF0DQo+Pj4gY29ycmVs
YXRpb24sIGFueSBrZXkgb24gdGhlIHNlY29uZGFyeSB0cnVzdGVkIGtleXJpbmcgY291bGQgYWRk
IGFueQ0KPj4+IGZpbGUgaGFzaGVzIGl0IHdhbnRzIHRvIHRoZSBibGFja2xpc3QuDQo+PiANCj4+
IFRvZGF5IGFueSBrZXkgaW4gdGhlIHNlY29uZGFyeSB0cnVzdGVkIGtleXJpbmcgY2FuIGJlIHVz
ZWQgdG8gdmFsaWRhdGUgYSANCj4+IHNpZ25lZCBrZXJuZWwgbW9kdWxlLiAgQXQgYSBsYXRlciB0
aW1lLCBpZiBhIG5ldyBoYXNoIGlzIGFkZGVkIHRvIHRoZSBibGFja2xpc3QgDQo+PiBrZXlyaW5n
IHRvIHJldm9rZSBsb2FkaW5nIGEgc2lnbmVkIGtlcm5lbCBtb2R1bGUsICB0aGUgYWJpbGl0eSB0
byBkbyB0aGUgDQo+PiByZXZvY2F0aW9uIHdpdGggdGhpcyBhZGRpdGlvbmFsIGNoYW5nZSB3b3Vs
ZCBiZSBtb3JlIHJlc3RyaWN0aXZlIHRoYW4gbG9hZGluZyANCj4+IHRoZSBvcmlnaW5hbCBtb2R1
bGUuDQo+IA0KPiBBIHB1YmxpYyBrZXkgb24gdGhlIHNlY29uZGFyeSBrZXlyaW5nIGlzIHVzZWQg
dG8gdmVyaWZ5IGNvZGUgdGhhdCBpdA0KPiBzaWduZWQsIGJ1dCBkb2VzIG5vdCBpbXBhY3QgYW55
IG90aGVyIGNvZGUuIEFsbG93aW5nIGFueSBwdWJsaWMga2V5IG9uDQo+IHRoZSBzZWNvbmRhcnkg
a2V5cmluZyB0byBibGFja2xpc3QgYW55IGZpbGUgaGFzaCBpcyBnaXZpbmcgaXQgbW9yZQ0KPiBw
cml2aWxlZ2VzIHRoYW4gaXQgb3JpZ2luYWxseSBoYWQuDQo+IA0KPiBUaGlzIHJlcXVpcmVtZW50
IGlzbid0IGRpZmZlcmVudCB0aGFuIGhvdyBDZXJ0aWZpY2F0ZSBSZXZvY2F0aW9uIExpc3QNCj4g
KENSTCkgd29yay4gIE5vdCBhbnkgQ0EgY2FuIHJldm9rZSBhIGNlcnRpZmljYXRlLg0KDQpJbiBV
RUZJIFNlY3VyZSBCb290IHdlIGhhdmUgdGhlIEZvcmJpZGRlbiBTaWduYXR1cmUgRGF0YWJhc2Ug
KERCWCkuICANClJvb3QgY2FuIHVwZGF0ZSB0aGUgREJYIG9uIGEgaG9zdC4gIFRoZSByZXF1aXJl
bWVudCBwbGFjZWQgb24gdXBkYXRpbmcgDQppdCBpcyB0aGUgbmV3IERCWCBlbnRyeSBtdXN0IGJl
IHNpZ25lZCBieSBhbnkga2V5IGNvbnRhaW5lZCB3aXRoaW4gdGhlIA0KS0VLLiAgRm9sbG93aW5n
IGEgcmVib290LCBhbGwgREJYIGVudHJpZXMgbG9hZCBpbnRvIHRoZSAuYmxhY2tsaXN0IGtleXJp
bmcuICANClRoZXJlIGlzIG5vdCBhIHJlcXVpcmVtZW50IHNpbWlsYXIgdG8gaG93IENSTOKAmXMg
d29yayBoZXJlLCBhbnkgS0VLIGtleSANCmNhbiBiZSB1c2VkLg0KDQpXaXRoIGFyY2hpdGVjdHVy
ZXMgYm9vdGVkIHRocm91Z2ggYSBzaGltIHRoZXJlIGlzIHRoZSBNT0tYLiAgU2ltaWxhciB0byAN
CkRCWCwgTU9LWCBoYXZlIHRoZSBzYW1lIGNhcGFiaWxpdGllcywgaG93ZXZlciB0aGV5IGRvIG5v
dCBuZWVkIHRvIGJlIA0Kc2lnbmVkIGJ5IGFueSBrZXksIHRoZSBtYWNoaW5lIG93bmVyIG11c3Qg
c2hvdyB0aGV5IGhhdmUgcGh5c2ljYWwgDQpwcmVzZW5jZSAoYW5kIHBvdGVudGlhbGx5IGEgTU9L
IHBhc3N3b3JkKSBmb3IgaW5jbHVzaW9uLiAgQWdhaW4gdGhlcmUgDQppcyBub3QgYSByZXF1aXJl
bWVudCBzaW1pbGFyIHRvIGhvdyBDUkzigJlzIHdvcmsgaGVyZSBlaXRoZXIuICBUaGUgbWFjaGlu
ZSANCm93bmVyIGNhbiBkZWNpZGUgd2hhdCBpcyBpbmNsdWRlZC4NCg0KVG9kYXkgd2hlbiBhIGtl
cm5lbCBpcyBidWlsdCwgYW55IG51bWJlciBvZiBrZXlzIG1heSBiZSBpbmNsdWRlZCB3aXRoaW4g
DQp0aGUgYnVpbHRpbiB0cnVzdGVkIGtleXJpbmcuICBUaGUga2V5cyBpbmNsdWRlZCBpbiB0aGUg
a2VybmVsIG1heSBub3QgaGF2ZSANCmEgc2luZ2xlIHVzYWdlIGZpZWxkIHNldCBvciB0aGUgQ0Eg
Yml0IHNldC4gIFRoZXJlIGFyZSBubyByZXF1aXJlbWVudHMgb24gDQpob3cgdGhlc2Uga2V5cyBn
ZXQgdXNlZCBsYXRlciBvbi4gIEFueSBrZXkgaW4gdGhlIGJ1aWx0aW4gdHJ1c3RlZCBrZXlyaW5n
IA0KY2FuIGJlIHVzZWQgdG8gc2lnbiBhIHJldm9jYXRpb24gdGhhdCBjYW4gYmUgYWRkZWQgdG8g
dGhlIGJsYWNrbGlzdCBrZXlyaW5nLiAgDQpBZGRpdGlvbmFsbHksIGFueSBrZXkgaW4gdGhlIE1P
SyBjYW4gYmUgdXNlZCB0byBzaWduIHRoaXMga2VybmVsIGFuZCBpdCB3aWxsIA0KYm9vdC4gIEJl
Zm9yZSBib290aW5nIHRoZSBrZXJuZWwsIE1PSyBrZXlzIGhhdmUgbW9yZSBwcml2aWxlZ2VzIHRo
YW4gDQphZnRlciB0aGUga2VybmVsIGlzIGJvb3RlZCBpbiBzb21lIGluc3RhbmNlcy4NCg0KVG9k
YXkgTU9LIGtleXMgY2FuIGJlIGxvYWRlZCBpbnRvIHRoZSBtYWNoaW5lIGtleXJpbmcuICBUaGVz
ZSBrZXlzIGdldCANCmxpbmtlZCB0byB0aGUgc2Vjb25kYXJ5IHRydXN0ZWQga2V5cmluZy4gIEN1
cnJlbnRseSBrZXkgdXNhZ2UgZW5mb3JjZW1lbnQNCmlzIGJlaW5nIGFwcGxpZWQgdG8gdGhlc2Ug
a2V5cyBiZWhpbmQgc29tZSBLY29uZmlnIG9wdGlvbnMuICBCeSBkZWZhdWx0IA0KYW55dGhpbmcg
aW4gdGhlIHNlY29uZGFyeSBoYXMgdGhlIHNhbWUgY2FwYWJpbGl0aWVzIGFzIHRoZSBidWlsdGlu
IHRydXN0ZWQgDQprZXlyaW5nLiAgV2hhdCBpcyBjaGFsbGVuZ2luZyBoZXJlIHdpdGggdGhpcyBy
ZXF1ZXN0IGlzIHRoZSBpbmNvbnNpc3RlbmN5IA0KYmV0d2VlbiBob3cgZXZlcnl0aGluZyBlbHNl
IGN1cnJlbnRseSB3b3Jrcy4gDQoNClJvb3QgY2FuIG5vdCBhcmJpdHJhcmlseSBhZGQgdGhpbmdz
IHRvIHRoZSBzZWNvbmRhcnkgdHJ1c3RlZCBrZXlyaW5nLiAgVGhlc2UgDQprZXlzIG11c3QgYmUg
c2lnbmVkIGJ5IHNvbWV0aGluZyBpbiBlaXRoZXIgdGhlIG1hY2hpbmUgb3IgdGhlIGJ1aWx0aW4u
ICBJbiANCnRoaXMgdGhyZWFkIFsxXSwgSmFya2tvIGlzIHNheWluZyBDQSBiYXNlZCBpbmZyYXN0
cnVjdHVyZSBzaG91bGQgYmUgYSBwb2xpY3kgDQpkZWNpc2lvbiBub3QgdG8gYmUgZW5mb3JjZWQg
YnkgdGhlIGtlcm5lbC4gV291bGRu4oCZdCB0aGlzIGFwcGx5IGhlcmUgYXMgd2VsbD8NCg0KMS4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9DVkdVRlVFUVZDSFMuMzdPQTIwUE5HOUVWQkBz
dXBwaWxvdmFodmVyby8NCg0K
