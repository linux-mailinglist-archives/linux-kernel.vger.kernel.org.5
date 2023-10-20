Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDED7D132F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377812AbjJTPyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377676AbjJTPx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:53:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DB6D8;
        Fri, 20 Oct 2023 08:53:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KD8IXD020893;
        Fri, 20 Oct 2023 15:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=lBaz75cqRHMkLhbaAOgL/ODFFjmr2sGPbP556h1M/7I=;
 b=xaIQDOd+m1gIz7VGbooCNOOD6TzV/dpCoSWcK3AcxgQogCRv39AXAhKtT1qQDswmABmZ
 ytk9i/ltq0sLYm1Xx7fvTI/oVFnPY1B+EA0MGPHGsm4rD9NPWAiA+xKks5k9ExmNHlDR
 IWi4uE49IMQKLThR+Pk+9N1HvtbPrYXH0VnAuo7m1X1BhGiC9J1kUh1QzN2586ig4te/
 yFdvnnz4I8A7dwWAmRJleVGIx1uuGMXQrQh5EVT1/xqn559z3ygkz51aUKgAqs51BKiC
 byucsf/OtGczy9JkODO+ECH9D8zb2x+dHJwKmtjw08WC+yZW7Li9TTspx/CpAFQyqS7B +Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tubwc257n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 15:53:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39KE01I9038498;
        Fri, 20 Oct 2023 15:53:25 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tubw4yda9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 15:53:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InpmyD6U2/W/+0+wzloMPu1HATxfTp3T+EklQ6WbfXrKpqbNtLjnMsuI/u4HSdK6K/vjFbpZUZGoV5Dk64BQbYeSMlz2H30805yd+vbHQX9nkqrnMqU7mXpDcZ0z9mjfE86eFvamizxyu3gin0+vO5OTrqyy4zRJkvml5mcvezd+DA2NRksuDUjzeqFd7MfraMFcN8c538/4l9RQxUkj1yJU0MOJUwl3Gc6qg57lcLMyBszbdUwbQUuIOMYHpWev5GgOwkB8ub4uxbmX067nOIutOuvJ/YGcukw+GbwYZPC7/NPFlMLTwJQgPgzTGcWImNBV/LT3dV/A7rrz6EgWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBaz75cqRHMkLhbaAOgL/ODFFjmr2sGPbP556h1M/7I=;
 b=czm/d+cbrvDDBeSpzvzYs5Q5xDXVDeSjmJL1/vhzCGFT3RdyFBY2jEa5Zc4aHZ+mB+qxKFmASZu7sqpH2puGTVPjEeoBJEXf/2TSUnT33Jem0ov1P4SZsV8urEFIGkZ7enwJC1T7YOSMmjaZKQq1VVFLFFyENqVJfL2yKz0pOGo+jT1+wVzLIHnpjwYqnO6wnxAb1vv7Nz4k+dfblFjjvEBP1Hb2/eZXvyUEBviqGQolmkZbDGVgiDw5ccnH+aal9S02bsH18XnPfAvIjNhobKbvWCE8J1DjH/XQcuFAl/RX243jYZz2ZBub8oYTdUq1NS/jMWNYEbnCe8JT0o2kcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBaz75cqRHMkLhbaAOgL/ODFFjmr2sGPbP556h1M/7I=;
 b=hh85qTZSvj7+lzNgksEDxwzlpWT3vTPo7YUoh0sPZ2Nu1hpjItlfy8vsb1ODayqeWSmCAeII29PlkL/O/42zQ4lYIYjiyGs2mIRW3/8ep3XZI3q9s5TMjZsjMVkt8Bj/FuF2kZTdRJX7/76cPzXq+Ws+Cijgv1Whap8mIztUc0o=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CY8PR10MB7170.namprd10.prod.outlook.com (2603:10b6:930:74::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 15:53:22 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::134:c770:8cb6:70e]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::134:c770:8cb6:70e%4]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 15:53:22 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
CC:     Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: Re: RFC: New LSM to control usage of x509 certificates
Thread-Topic: RFC: New LSM to control usage of x509 certificates
Thread-Index: AQHZ93c4gJX6SHkC80mNOExcrBTnXrBOD7yAgAAjSwCAABc5gIAABa6AgAAIMoCAAA68gIAADAcAgAE44ICAAJZxAIAAp5UAgADpnACAAQtrgIAADU4A
Date:   Fri, 20 Oct 2023 15:53:22 +0000
Message-ID: <8096FB15-1766-4C0B-BCE0-BB520BAAC0B7@oracle.com>
References: <CAHC9VhRdU1CZJpPSEdSmui-Xirr0j261K=+SM7KiDwiPG-JSrQ@mail.gmail.com>
 <a851227aaa75ab16b0d6dd93433e1ee1679715f9.camel@linux.ibm.com>
 <CAHC9VhS_Ttdy5ZB=jYdVfNyaJfn_7G1wztr5+g0g7uUDForXvA@mail.gmail.com>
 <5c795b4cf6d7460af205e85a36194fa188136c38.camel@linux.ibm.com>
 <CAHC9VhTug20M0ET=QojUPtjrGkeHfU=ADDNrKfXmLTQPG_i1vw@mail.gmail.com>
 <2512D2AE-4ACA-41B9-B9FB-C2B4802B9A10@oracle.com>
 <20231018.heiju2Shexai@digikod.net>
 <18FC67B7-7966-49B7-8C27-F815F1568781@oracle.com>
 <20231019.vair7OoRie7w@digikod.net>
 <0296DA27-7CAF-4605-AF67-3645F82BEE4D@oracle.com>
 <20231020.wae7johZae2i@digikod.net>
In-Reply-To: <20231020.wae7johZae2i@digikod.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|CY8PR10MB7170:EE_
x-ms-office365-filtering-correlation-id: 7d10dc6c-e226-4766-cd5b-08dbd184b05b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fYz36mfG6MC4UBc3uCcU2M3Vn4PM88uU6lJZ/WekPFV1DP/9sSJhrDyfN+ERemhaqL8AfokrYkyU/KAIcwi2GWKmVaZKzfvIMa5jPzkMxcSdUs8bi0hUc4BE9mKdHKudkB17DeHwW1oV4O2gOniUDxbgUZ1Zv5MF3D5LGeP58dWgJZaQ/C7DrMgQpdJubfDBiHprc4yVoTe6D10vp7bRgIS/68/yid/qtUt2O4n5gJO/+sPrUujfPkoQDtztRpmNNHsyUBRGjPSxo0LKej8cdOJ3xIxA1tSdsanTCNavMEZnlotJ9FWWSCh8PqngW3JXsieUwVLM5+ZF6kaGLDSXFP6coRrkPFXZkF4J614BI7czQZ8/ivm4R6sm5FqXy73wbSGE0M3dNSEQdC+eKe8Wmw+KuzEIag5USA6tOhMBU47cppOZ5gho5duqQtWouAScIsFDpSh8FGF58XoWUO+709dkhSqkq9+0NMtHHQIRR8V51V0pGrVMaHgi2seWkhdYncXHwEM5kxZgnwOqubIjMKmZWnU1nipPJLwi4P1PVhAFrFY+PCd2jB1mWFQesoatRxHB3ZCrR+V4Gu8sEwJoWxIMrbI+vgT3ZOzrUXcUUoAlJwPp/OP8FHw4KeQL9rC+c8fwEQbvgc6PrWmo4j9+fQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(38070700009)(122000001)(38100700002)(478600001)(6512007)(6506007)(6916009)(76116006)(53546011)(6486002)(91956017)(41300700001)(316002)(64756008)(66946007)(54906003)(66446008)(66476007)(66556008)(8676002)(4326008)(44832011)(2906002)(7416002)(66899024)(83380400001)(71200400001)(26005)(2616005)(66574015)(8936002)(5660300002)(36756003)(86362001)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1BHcUo1TFV0bW1rNUxDYVhiZ0d6czA0ZGw0c0RpQ0RkWmhVejdOb0JJQVUr?=
 =?utf-8?B?TjZJTDdmcnhBaTZIelVjNXY2MWJtRTMrMEVvV21GSUNJVy9Samx5cGRjNjV3?=
 =?utf-8?B?a1BlKzFsTkdHb2ZURGdkNXlDenN1Z2VNTkhJWkNoaTR6RnEvWGs4dUl5dHcw?=
 =?utf-8?B?c2RPQW9EakdKYXFMbGo2ZjYwN0I1aUdUYUJhVmFHUlpNeFhtL0FOUHBUN09j?=
 =?utf-8?B?SVBQVXR6UE1HcWk0UGNzY3oyM3A5TG50aWhBaVdtcGwxZWkvY3JmQmhGRjgv?=
 =?utf-8?B?N3ZkWTl6MG5BaTIxNzB4c3hCVjBOQ09uTU9CRWVFYnFqVXk4Ums0cnlvenFG?=
 =?utf-8?B?Mk9DWi93cnBZKzZxWXl2dlV3SnBjejFuSnhHbTJTWENkWkFCbUV3Z2FDcktx?=
 =?utf-8?B?NUdiYXRHV0JFc1hNMHRaSEhVMk5UaDRMMVdkdGlzSUZBRXE4RGZ4R0owNXNL?=
 =?utf-8?B?by8vU0h1ZUd3RXc5MC9TK253MUhPZ3lqMWtCMTZPS2pWcGp5Qys4OExjbTdE?=
 =?utf-8?B?dWhYRkNhTjNhT0NJT3RoSCtmTk9ma1N6Z3BnaCtRWVROR1d3K2lMUDNTNGRM?=
 =?utf-8?B?S2JTSWt5TWg0am41bSsrbURlWU5aVmwzM2RlcVA3SnRXSWJ4a2s1cis0VktY?=
 =?utf-8?B?Q01BK25Fd3J1dTMwTzIzaHprT3VSVHorNzR1NW9UQzBSQzNGVHdFb1RXRnpN?=
 =?utf-8?B?SkExVmhTc2hUMllEMm5vd3NCUmpJdXEzN3VUSGN3NE5RQjNNcFVNRHA0WlZP?=
 =?utf-8?B?ZXJkeUd3eHdSeEJVc2U1c1BPTStHK3FUREFielZucUNEd0VyM0cxUkUvLzhu?=
 =?utf-8?B?L0U2c1k3YkxyVHluV1puTWJqanVXSDQvd2tHYkM2T3NkbkRZZ3pnUkNiTmJy?=
 =?utf-8?B?N094UXVtdDV0YmtqS2VuZy9NZmdyeTMrSHh5RzdnTVgrV1d6dlBFZWY3WUxM?=
 =?utf-8?B?dXloM0F4STdHdlYyOGhydzgyQ2VJbEk2aDdPNU9HdWJhaUwyME55Vy9qOU9O?=
 =?utf-8?B?bzUrS05wTE9PMEcxQmxpWUYxNHV6L1I4Nmg2aktqYXdtNzNaZkhCanEveHRt?=
 =?utf-8?B?RkZZT29mc0tTYzRIdktjVXlVdjZaRnl6WGtjVzNZM3Bib0dCaEF0b3NPS3V6?=
 =?utf-8?B?R0pOdVBLcHEvblJPeHk1WUg3UkM1QW0xWlJSeFUyUUN1ajRhTlhZOFBSc3gx?=
 =?utf-8?B?RmM5RDh5bDk0a1FJMWlkU1hTaGt5TDhjQVZoYjV6VEU0RnBmL3FkM1o3R085?=
 =?utf-8?B?cHYrVi9GakFySHNoUkFudEl4SDhJS0NhMmJsNFVYd2ZRT3g3U0RrSWJVMkM2?=
 =?utf-8?B?SVVxY0RzNHhFWElxY2FrajhCN3Y4ZmxjMy9lcGRkcE1rUUxBZ2hOS0tUQjRp?=
 =?utf-8?B?blZ6d1M2UjBUbFcrZE95T2diZ3lnNSsyd3RxRDNJeXhBT3I0aW55RlU3WUtu?=
 =?utf-8?B?Nnh5K1p2VUtuWHg0MUlmLzBhU0xEVmRBL0gxNzM1S3hZNERXdGhaQXp4bmZK?=
 =?utf-8?B?WXdoanRIMHZVNHVRM3d2OFFQbDRrNEFFUHZiZExHQlovaXAwcFQ4N01jZDNC?=
 =?utf-8?B?RitweGhoa3pnSUZJV0JwU0RrMUErdDR3YlNHSnpXN2ZOS1VhcmJoT1pqNkw2?=
 =?utf-8?B?ZngzNHR5S1JqdzFKdFl2SEJFTm1YWVN0VkhMMjZQeFdUSW9vZm90Zll2ZkpJ?=
 =?utf-8?B?cHdQbVQwWjl5Y0pSNTZFVGhvbkhYZlRaRGJiMUxoT2c3ckNRaVJmS1QrRTVN?=
 =?utf-8?B?dkFEYkdjT0p3TDhWZWU4cFZnZmRPMmUxb1NnWUh4bUs4WjFDTFNrZkQxcGUx?=
 =?utf-8?B?c29Ja2dyYmlSK05rUW02Yzl1TkVPQlY1c0dISDlNRmptakUzYUxHRzVTRkR6?=
 =?utf-8?B?eVRuenBJR05iYTZZeU5UejIwREFzSThIbU95OTVoejV6NXl5dHkwcHcyRWpx?=
 =?utf-8?B?SHBpNDVqYkVtTFBzOUMyZVFXMHQ0TitBZURhTzJmU2hHaGp5cVpiSW1ZRWR4?=
 =?utf-8?B?M2IvVktxMmVKc3k4c0hwVzhLd1JPNEh5cldycUR1OVdwU3c3LzM3L2ZZUjJO?=
 =?utf-8?B?MThycW13emt5VEl6VDErQWEra2FHNUVKb2x3aGUvaHlyS3g3TkhyUG1oOGI2?=
 =?utf-8?B?RXFVUlpQV0N4cHZDSUdMb3lhK2ZNbHdpVFQ2dGlXaWwxRFJZQzJzandqcHNC?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <345D73A9AE68D243A47AA8AB9D148D65@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QnBHZ205SDZ6Z2hNYm81OVpvRlo1WEhSRW03SEgvNU5PY2ZQNWNydGlVVWsw?=
 =?utf-8?B?ZlRpWkpNMW0wOWxsTUxPU3JmTk9EeDEwbnZwNzkzd0sxcS92LzVxL2F4VHda?=
 =?utf-8?B?WlV2M1JHK3NtUnNJNWZBYUdxT3Z2YTUvTktwQjlPZ3I3YStCS2Rub0VtMTdO?=
 =?utf-8?B?dU5qUVZUMkRxV1ZFUlJPcXVldTN0MXhDZFd1MFN4K29lbTloY3V3YXlzMG9O?=
 =?utf-8?B?Tms5ZmZDMW0yb0sycFIrVExXWXJEeFFVdDk4N2J4R1d1TnErTDFmanBHcEJZ?=
 =?utf-8?B?RGNNMU1iVk83LzdWZGs2b0I0UlYxYytGOU9CQUpRTnFYY0JFUkNVSlVtWVFo?=
 =?utf-8?B?TktyQ0NESFovazFETnBNM1piZUV6eHlXbUJHS1ZKTG5hUERwclBTWlhTYjZ1?=
 =?utf-8?B?bUd1ZWp2akFFMjVNaGF6V25vNUorUWJWTHhLL1BlY3lXMGFCOFg1QmpnUEFQ?=
 =?utf-8?B?RERBVnF6SjNpWUVoKzYzVzRZL2ZqVkM1YVVrT1RlTDFVbWl4K2E5MXZ3Ujlj?=
 =?utf-8?B?VERZRTNIUTRWVUp2bkxPZlkzZUtRbkQvZzJoQ05aVkZUY0xLRG0zb2NnN0tH?=
 =?utf-8?B?UzVPc3JKTUJKeU9kTDFPcWZ4UUozR05lQ0tsdGVJdHlKNTZHeFVEN2FhNXJP?=
 =?utf-8?B?TVRCcGZnNE9NOE1yYzVHa3QrWVpYWDhjdENIbkNTRkR1L3haNnNJUWhqT1R6?=
 =?utf-8?B?U29qU25paXJYaFA5ODUrcEdFd2NJcDl0YTlISmRKYmRNZ084a2tOb056b0lL?=
 =?utf-8?B?S0liZldxTkpkdFZrREYvRVRzMS9WUXUyUml2SUZ6NnFxRW81a2MzKytoQjZ2?=
 =?utf-8?B?eSthYmFPNFhBbGg5Rnl1S0JFRE5MdEJGOUVpbFdSS3NTR3JCbllidTdwS1lZ?=
 =?utf-8?B?VXJ0TUp6QW1uWkE3K2RqbjFhVTZSZ2JuR0RoSis1WHZYZUUxSDQyT3J3dWlI?=
 =?utf-8?B?WjdlQVNubWFJVUIydTBscHovR3dlMUtNbnY5MFFWU0tEcHliZ0tqZVl4SzB2?=
 =?utf-8?B?bFlESGJ3ZmduQUpXbGRkNUpzYUZSL29PYS9tczZYTStNNDJiTXR1OUhZc21m?=
 =?utf-8?B?c1p3S25MT1lCMzIzL0h0akxtRURFYnZ2eSt2ZUpGWllXTURiR2cwWUd0Sjhw?=
 =?utf-8?B?NWhMQkk0am1nZWRGbFFTckk2b0ZNemVHZ0lQclh5SHlySWtlaUdmNjJhVTdG?=
 =?utf-8?B?dzhHY3BUSlE1ZXAzeGw0a2VFelRzbGo0bWhmRXR5emw3WWZCQm5zOTU2UVUy?=
 =?utf-8?B?a2ZQMEJCU09MR0RZSm5QU1JHVXhGcVBEdFlIRDZoSWNsd0szSERYdFJBazkr?=
 =?utf-8?Q?GpS750C2I7m/YM6GuXVXnup2V0xMQD+TAX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d10dc6c-e226-4766-cd5b-08dbd184b05b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 15:53:22.7297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DJMQcY9ARffKgJb66NnNSSdUzvdZMKKi7XSN3TVRcNbuXtmI8PM/5M2YuC60D3hm7VFo5m71S13s9Uy3D2jd5IV+079E2YD6NcmbNyyhZTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310200133
X-Proofpoint-GUID: XnlftzJgf6sU2Hy-RpWKJMXCX4nPdf_v
X-Proofpoint-ORIG-GUID: XnlftzJgf6sU2Hy-RpWKJMXCX4nPdf_v
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDIwLCAyMDIzLCBhdCA5OjA1IEFNLCBNaWNrYcOrbCBTYWxhw7xuIDxtaWNA
ZGlnaWtvZC5uZXQ+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBPY3QgMTksIDIwMjMgYXQgMTE6MDg6
MzhQTSArMDAwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gT2N0IDE5
LCAyMDIzLCBhdCAzOjEyIEFNLCBNaWNrYcOrbCBTYWxhw7xuIDxtaWNAZGlnaWtvZC5uZXQ+IHdy
b3RlOg0KPj4+IA0KPj4+IFRoZSBtb3JlIGZsZXhpYmxlIGFwcHJvYWNoIHdvdWxkIGJlIHRvIG5v
dCBoYXJkY29kZSBhbnkgcG9saWN5IGluIHRoZQ0KPj4+IGtlcm5lbCBidXQgbGV0IHN5c2FkbWlu
cyBkZWZpbmUgdGhlaXIgb3duLCBpbmNsdWRpbmcgT0lEcy4gV2UgImp1c3QiDQo+Pj4gbmVlZCB0
byBmaW5kIGFuIGFkZXF1YXRlIGNvbmZpZ3VyYXRpb24gc2NoZW1lIHRvIGRlZmluZSB0aGVzZQ0K
Pj4+IGNvbnN0cmFpbnRzLg0KPj4gDQo+PiBBbHNvLCB3aXRoIHRoZSBmbGV4aWJsZSBhcHByb2Fj
aCwgdGhlIHBvbGljeSB3b3VsZCBuZWVkIHRvIGJlIGdpdmVuIHRvIHRoZSANCj4+IGtlcm5lbCBi
ZWZvcmUgYW55IGtlcm5lbCBtb2R1bGUgbG9hZHMsIGZzLXZlcml0eSBzdGFydHMsIG9yIGFueXRo
aW5nIGRlYWxpbmcgDQo+PiB3aXRoIGRpZ2l0YWwgc2lnbmF0dXJlIGJhc2VkIElNQSBydW5zLCBl
dGMuICBXaXRoIGhhcmRjb2RlZCBwb2xpY2llcyB0aGlzIA0KPj4gY291bGQgYmUgc2V0dXAgZnJv
bSB0aGUga2VybmVsIGNvbW1hbmQgbGluZSBvciBiZSBzZXQgZnJvbSBhIEtjb25maWcuICANCj4+
IEkgYXNzdW1lIHdpdGggYSBmbGV4aWJsZSBhcHByb2FjaCwgdGhpcyB3b3VsZCBuZWVkIHRvIGNv
bWUgaW4gZWFybHkgd2l0aGluIA0KPj4gdGhlIGluaXRyYW0/DQo+IA0KPiBZZXMsIGVpdGhlciB0
aGUgY21kbGluZSBhbmQvb3IgdGhlIGluaXRyYW1mcy4NCj4gDQo+PiANCj4+PiBXZSBhbHJlYWR5
IGhhdmUgYW4gQVNOLjEgcGFyc2VyIGluIHRoZSBrZXJuZWwsIHNvIHdlIG1pZ2h0DQo+Pj4gd2Fu
dCB0byBsZXZlcmFnZSB0aGF0IHRvIG1hdGNoIGEgY2VydGlmaWNhdGUuDQo+PiANCj4+IFdlIGhh
dmUgdGhlIHBhcnNlciwgaG93ZXZlciBhZnRlciBwYXJzaW5nIHRoZSBjZXJ0aWZpY2F0ZSB3ZSBk
byBub3QgDQo+PiByZXRhaW4gYWxsIHRoZSBpbmZvcm1hdGlvbiB3aXRoaW4gaXQuICBTb21lIG9m
IHRoZSByZWNlbnQgY2hhbmdlcyBJIGhhdmUgDQo+PiBkb25lIHJlcXVpcmVkIG1vZGlmaWNhdGlv
bnMgdG8gdGhlIHB1YmxpY19rZXkgc3RydWN0LiAgSWYgdGhlcmUgaXNu4oCZdCBhbnkgDQo+PiB0
eXBlIG9mIGhhcmQgY29kZWQgcG9saWN5LCB3aGF0IHdvdWxkIGJlIHRoZSByZWNlcHRpb24gb2Yg
cmV0YWluaW5nIHRoZSANCj4+IGVudGlyZSBjZXJ0IHdpdGhpbiB0aGUga2VybmVsPyANCj4gDQo+
IEkgdGhpbmsgaXQgd291bGQgbWFrZSBzZW5zZSB0byBoYXZlIGEgZGVmYXVsdCBwb2xpY3kgbG9h
ZGVkIGF0IGJvb3QNCj4gdGltZSwgdGhlbiBsb2FkIGFuZCB0YWtlIGludG8gYWNjb3VudCBuZXcg
cGllY2VzIG9mIHBvbGljaWVzIGF0IHJ1bg0KPiB0aW1lLCBidXQgb25seSBwYXJzZS90YWcvYXNz
aWduIGEgcm9sZSB0byBjZXJ0aWZpY2F0ZXMva2V5cyB3aGVuIHRoZXkNCj4gYXJlIGxvYWRlZC4N
Cg0KTWFueSBrZXlzIGFyZSBsb2FkZWQgaW50byB0aGUga2VybmVsIGJlZm9yZSB0aGUgaW5pdHJh
bSBpcyB1c2VkLiAgVGhpcyANCmluY2x1ZGVzOiAgYnVpbHRpbiwgcGxhdGZvcm0gKFVFRkkgREIp
LCBhbmQgbWFjaGluZSAoTU9LKS4gIEkgYmVsaWV2ZSANCnRoZXNlIGFyZSB0aGUga2V5cyBvZiBt
b3N0IGludGVyZXN0IGZvciBjb250cm9sbGluZyB1c2FnZS4gIEJ5IG5vdCByZXRhaW5pbmcgDQph
bGwgdGhlIGF0dHJpYnV0ZXMsIEnigJltIG5vdCBzdXJlIGhvdyBhIHVzZWZ1bCBmaWx0ZXJpbmcg
cG9saWN5IGNvdWxkIGJlIA0KaW1wbGVtZW50ZWQgYWZ0ZXJ3YXJkcy4gIERvIHlvdSBoYXZlIGFu
eSBpZGVhcz8NCg0KQWxzbywgZm9yIHJldm9jYXRpb24sIHRvZGF5IHdlIGFsbG93IGFueSBzeXN0
ZW0ga2V5IHRvIHZvdWNoIGZvciBpbmNsdXNpb24gDQppbnRvIHRoZSBibGFja2xpc3Qga2V5cmlu
Zy4gIFNob3VsZG7igJl0IG9ubHkgdGhlIENBIHdpdGggdGhlIGNvcnJlY3QgYXR0cmlidXRlcw0K
dGhhdCBvcmlnaW5hbGx5IHNpZ25lZCB0aGUga2V5IGJlIGFibGUgdG8gZG8gdGhpcz8gIElmIGFs
bCBhdHRyaWJ1dGVzIHdlcmUgcmV0YWluZWQgDQp0aGlzIGNvdWxkIGFsc28gYmUgcG9zc2libGUu
ICBUaGVyZSBpcyBhIHNpbWlsYXIgaXNzdWUgd2l0aCBrZXlzIGFkZGVkIHRvIHRoZSANCnNlY29u
ZGFyeSBrZXlyaW5nLiAgQW55IGtleSBsaW5rZWQgdG8gdGhlIHNlY29uZGFyeSBjYW4gZG8gdGhl
IHZvdWNoaW5nIA0KZm9yIGluY2x1c2lvbiBhbmQgdXNhZ2UgaXMgaWdub3JlZC4gIElmIGEgcG9s
aWN5IGlzIGFkZGVkIGFmdGVyd2FyZHMgdG8gZW5mb3JjZSANCnRoaXMsIHdlIGRvbuKAmXQgaGF2
ZSBhbGwgdGhlIGluZm9ybWF0aW9uIG5lY2Vzc2FyeSB0byBkbyB0aGUgZW5mb3JjZW1lbnQuDQoN
Cg==
