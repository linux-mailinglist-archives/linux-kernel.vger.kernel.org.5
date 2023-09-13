Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA2A79DE55
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 04:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbjIMCk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 22:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbjIMCk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 22:40:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCD21718;
        Tue, 12 Sep 2023 19:40:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CKeLpx020282;
        Wed, 13 Sep 2023 02:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=AZmgoPuY9WolXU6tCjsf25H6LTVpX5NP3lAKwdB3EoU=;
 b=mCuhJ8LAUikIh53Ybls1W1EzPyh51ASkak/8I5As06CP+vUEXhPNXfIL/9nORykGGBnC
 1yNkf9Qu0/FXb5UuZSmzch0LjP7/LEZJg7JTUqhJUhYc2S6KzO5/F3C9WdGF4IzbK25Q
 zN4MudYGbU5YRTXLSyXdDW7UYOi3rNhNY+U7esf8GQxh/kjaKtEGXgNYiDZQ9hcgUm16
 iDjc7puaqsjU6mUMwuztRl5DHrjhqv3/6ZqnUy2ehrVvDuriE4DH+BKrYIp3U8hCiBtd
 h6WZ9dT4P52OkxN0WP/9bzUbeL9jUi3tkndillDikECBQwlNyL40BCxjM/qDR4Rz9vb7 Eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7kgctu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 02:40:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38D1eB2O002682;
        Wed, 13 Sep 2023 02:40:19 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5cve0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 02:40:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9T52MueeEuObde7ZntlBHcPyVAYgQ8KamQJ1oRV3M2r9xZ4bp3fLXqisw0Rb9whiZWsrmWitAm2qSgc0frSbu8CXFHKSnNnraSMw5R7yraYtsulpqOwmloJyD3JVbU5Ijg2ESaTocgxAcaACuZSJrfIwjkDCvWPU2yg1u8xqQpS9dH9SL799YVG0aWhiBh9EiOaHF8XkzDFd+eNBQ54uD5R+8xdaipRQUVwsSJaHpbrJXyi9pZi09VXggnXiidMc14yUF8BQ7254vI2Y5T21KLjgsiPn4+T91OkuzRC/v10gysYozj3qK/tlbFyE5pQ1EfGOYjqsn1AVJ/R2c/oVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZmgoPuY9WolXU6tCjsf25H6LTVpX5NP3lAKwdB3EoU=;
 b=FzDQd1RK/x+EK98lZua1q+MYbjQoUN1yeJD5RvGiXUjxWiIQBpdPxSXoLTcYYzshg4EOZouB5tiJLENmnMhxPKBtE+fis21oSVG3heZAxHJ7hy9xiCl2Se/ZGVjVnGXCD0cW09RBLoJ34zqMByYvNuQAyHDCE7BGpEy5GC5s+MimCecM+hUFEem11EvMGO2n258xgpOudLv/ToZddmIlslm5JLlYniyTGErDAeRXBkLDTcbWYMoJ79phqhxSmz/zwSfhWMKyE+DLNb7A5NJU6HEbcilPIKTdub0nSNG1JVKWFMoCz+yyqbbYgdvqL0+Sg4NAFQQ9qfBWAEeZaZJsiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZmgoPuY9WolXU6tCjsf25H6LTVpX5NP3lAKwdB3EoU=;
 b=msgFrSYLfJnrawJag469TJGe79mOyJS0MI0noWwXuN7OBlHBK7wpAYwt0F+m4zKU5xyvVUUjwLRlAWMz+Yv79qu2w9Basx2daQaOary2HrzgXRWVi2cTAArcN2IhWaJ9ynMaV5h38e1lvOXqeJsdH6nO5hGEFmfjs453Ur0lIv0=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB4921.namprd10.prod.outlook.com (2603:10b6:610:c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 02:40:17 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::3f7b:855:6a95:8aed]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::3f7b:855:6a95:8aed%4]) with mapi id 15.20.6768.036; Wed, 13 Sep 2023
 02:40:17 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
CC:     Jarkko Sakkinen <jarkko@kernel.org>,
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
Thread-Index: AQHZ4p0BkG9ylPk27Eafo4TPmLwJdbAVoqeAgAA4j4CAAFsjgIAADhYAgAAwIgCAAKYcAIAAWEmAgABd5ACAAEEugA==
Date:   Wed, 13 Sep 2023 02:40:17 +0000
Message-ID: <4A0505D0-2933-43BD-BEEA-94350BB22AE7@oracle.com>
References: <20230908213428.731513-1-eric.snowberg@oracle.com>
 <097a0413b27ed9792dc598ff184730bcf6ae8fcf.camel@linux.ibm.com>
 <20230911.chaeghaeJ4ei@digikod.net>
 <CEA476C1-4CE5-4FFC-91D7-6061C8605B18@oracle.com>
 <ba2f5560800608541e81fbdd28efa9875b35e491.camel@linux.ibm.com>
 <932231F5-8050-4436-84B8-D7708DC43845@oracle.com>
 <7335a4587233626a39ce9bc8a969957d7f43a34c.camel@linux.ibm.com>
 <FD6FB139-F901-4E55-9705-E7B0023BDBA8@oracle.com>
 <1149b6dbfdaabef3e48dc2852cc76aa11a6dd6b0.camel@linux.ibm.com>
In-Reply-To: <1149b6dbfdaabef3e48dc2852cc76aa11a6dd6b0.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|CH0PR10MB4921:EE_
x-ms-office365-filtering-correlation-id: dcceb80e-50f7-4336-dded-08dbb402c411
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Lz2LtAQoz+VXdVXqsvEGJH3+Ps5R+qCcLZGD2CZEBFSRP8aoNd5ICmuIogH7NTihE4C6lsvkglLGbTv8PSXn0sPaumyRw2EuOHoT+Rx938XlllHVC56Li+pr6TOwcvilpY82N2okKROAweNE26zygheuIu5dGlrdwSbwl8IhcLL/UzA+nYbIbrf1PsqlJeYUJMr/bpIYc1W9qEOL4bfBScMZxevCgJtux6T4RT1sZ3Zp6zlVCJuO7L4CelV33fQ6RFHIt9VTX5mRReySj0NO4lu3BOemt8LUvIOuw4KXNMjI3dmotVDq6lIDgmpoFVIzAjGh+/uSaKrZ1sWVlUUjd2J9HiQnWHLkDAAoVG9SIc1J2Je4EEQFQGJdHGaZfYYxHbLZlHn3YIWSW4Mqena2rWbKs55+UBpQBtljPxO0MfvfqNhK3jW8VrpF1ivbMs+DBPvIbCNg//ze4J17p74/R+Fs6VqC4byYqeOGl/XWHpQ9bAR6j+RLQi36yXMAJ8MTLQahEzySReZoGv3bYYDVcDuFG/9IAmLv/ZcDwrLYlfB5yT/REmMbYaIkQsP3uoF54MhDhWDRXZZ9C6L/iHzQdS0iOJWqw/aCWvYQYnbz/mirXDG/TkQ5m51O8CVq+O34oiJGvp3PkSgK/Bu86lF0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199024)(186009)(1800799009)(33656002)(36756003)(26005)(41300700001)(5660300002)(83380400001)(15650500001)(86362001)(7416002)(8936002)(44832011)(4326008)(8676002)(6506007)(71200400001)(6486002)(66574015)(53546011)(6512007)(2616005)(122000001)(110136005)(91956017)(478600001)(76116006)(38070700005)(2906002)(38100700002)(66946007)(966005)(316002)(66446008)(66476007)(66556008)(54906003)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU84aHMraEZNbjRFamNac3djQWwvZytCZ3NNVkRUaW00TDVJK0JDRVRJMGVC?=
 =?utf-8?B?ckM3SEdPVEhYcHBhN0s3ejYxSk54U1VwcGxaQ2h5YjhkYWdVREhOODlJQkVE?=
 =?utf-8?B?SnIwa2ljQ0lFR1c1QUVFMHhQalgxR3dPRGlXOUcydi93STg1Yk9sdEpITXR6?=
 =?utf-8?B?TGttS25kR2xUZXBweVcyOVRyNmpyNmVITWxhNXRiZzI0RFpxRFNlUk9pUi9i?=
 =?utf-8?B?eTBwM0hiTC81Vm5GeWxuOWp6SEszb0U2WGQ2cFVxdGdZaW8zQ1RnUS93U0pN?=
 =?utf-8?B?WXdnUFdXT093U2Z1TTRsYlBkMFQrUDIwdmJYTUJNNWFuNVQ0elhkc3N0TnVH?=
 =?utf-8?B?TTlJVDg3VXBLZ05BcStnS25hRERvMkxKK3ZTSDBXVlpKYUNkT3dCWVRVa3Vp?=
 =?utf-8?B?QnJZTytTZlBGU0dpOFBaRWZ6N0VxQ0pudEdSaWxJTE9IcHplb0k5eFljYVkz?=
 =?utf-8?B?UGlsOVRCOFI5MnRQRVl3M2krNHhUeWs1L3JTanVMVEhGSlo4R1dMdzJ1cFdC?=
 =?utf-8?B?TWFEKzJyT3hySWVKc3Fpdy9LQWdNcnlmZ3JZQXBxMFlKSXVwejlEb3ArREd0?=
 =?utf-8?B?NXZIbTlheGVLN1hXUEl1Q002N20vaUpBWnFBa215ZFQwcjJTQ205dHY2ZlFo?=
 =?utf-8?B?aGF6OGpOUTI4Z1JnQ0Nwc3pPNWZ1aVdYVjJuSDBZSStWOGpsa01tVWpOdmsv?=
 =?utf-8?B?VGl0ejlsMEllNE5kWXErTnpXanlwL0dFd2dhckhzbXdYVld4SjBqQXZPLzVr?=
 =?utf-8?B?M0l1U0swNzR4a3JkZ1dmZDZqVCszQlN6Vms5ZmpkaStBY3lJKzZQeU0xd3JH?=
 =?utf-8?B?ZDdoRmNhaXpZWWVYYldraGozd2VPK3NMUmVjRG5pNlFLN09jVW8zR29tbGpI?=
 =?utf-8?B?WWlyR3l4M1NzZ3RoekFKR2RPUEw2Rk9uRzZ0T0hNQ3I1Z3kzaXMrMFhHMUtv?=
 =?utf-8?B?MDZYNUZ2ZExQcTVXZmVYOE5UaGY3MjhVamlVb1F0ZXU5UncvRmhzVW4weHlC?=
 =?utf-8?B?dkJwZmFrQ0lqWVNFNjB6U2RGSlpGL005cExyV2Z5SjV5cHpEMElxUlpGaW90?=
 =?utf-8?B?Uk81Y0pzSHRqV2RiQW1zNzRnV29XQU5yZ203TjYyMHJBUVZySlErM0RWejdL?=
 =?utf-8?B?bG9rVnViTjVNTUZiRlVwSGJ0aEZvc1ErUjJBdDVlMzNYVzdSaWRRbmx4ZGt5?=
 =?utf-8?B?T3RhSHNzcHNua3JYbzdDTksrcStVeFFCeFdZUjlLS01hbldzOFA2Y04xL1gr?=
 =?utf-8?B?SFBNMzNKNFBMbWZTRHNuSnloVWVwNHZqZ1E5d3RGRnBORG93b2dUQnBwVUZj?=
 =?utf-8?B?eXNjK0haMld4dnhqQWxVbEdNTUxFeUQ4a2xVWXZHU2xEQ0RFLzJOSmRiaVFM?=
 =?utf-8?B?MVR0VExHSldyaU5TWEZyWENsaHBvYXhLSUF6RTRSRGQxVFVOcTNQOHBTOUtn?=
 =?utf-8?B?NlBsTUNFN3BBbTVadXZpcEo0dVp3ckF3WXhiWk1MWXZjMG5aeFNqUjdJd1hM?=
 =?utf-8?B?Sk5PdnNsT1lTZ1ovd0RMZVFXUkNJeGovWVptbmlId0g4Z1l4dHBYNXZ2OEYr?=
 =?utf-8?B?N256RjA1TnNMQmRvT2FxTG1XU1luYUFOaUIyRGl3czNUQTRxZWMzNEQvRlhG?=
 =?utf-8?B?VmRLYWV0cG9FMHZTNHRLUEd3dXdtMWRydUlMWTVhUWM3V3B5T2daWDUxS212?=
 =?utf-8?B?TEN0cFBJdXY0dFpZeko0ZG9oeloxSG1jM3d0M2cySHpJUzl4QkdGNzlvNWZJ?=
 =?utf-8?B?cnpOelFmYTEzb25LQzlnREIycDY2NER4ZXFZbXBKOGh6N2hLcUQ3TUQvRFNL?=
 =?utf-8?B?VUdYZkNWU2NVbXlUSGZ1U2JwVTh1TnhUVWtManIvQTEzeXNETklzSW0raHlH?=
 =?utf-8?B?c1VCV2FLRTJwOEdSbnlSZjg1Q1owd3Q2ZDRudFR4SmpiZVhEejZjdmZpOVI3?=
 =?utf-8?B?WmU4VjcwekhueXU5enFCMzVtTWhNdnN4eHA1c2ptUzQ1akcrL2QyUDhrTEt1?=
 =?utf-8?B?LzlaRXJnY2l3Rmtmeld1N2cwK0hSbDJwWm55dGR4UGVsanZmWGpXY3pyaCtO?=
 =?utf-8?B?V3FkUGhBVjA0V3lPUndhVGxvcE13Z3huUzFsQzcvVEM1Nnhvc0dndy93NnFj?=
 =?utf-8?B?c25yV1hmQTZVdHJOSDJkUDBsK0ZEM3JxQlh1d3p3bTFUL2tSbEF1ZzcrOXcr?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C53FB34F690E045B2DF07125F112EE0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Zzk0UXppY0JxQXVqcTFZQzR6QnZKODZnYUJWaVF5ZTl0cHd3dzdIcTBJNDRl?=
 =?utf-8?B?Z1JDczRHbzZnUFRQdW4wWjEybmhkY01ERHo5T0xTZW9ydDAwRFNUZlQ1NWRh?=
 =?utf-8?B?Qm9oVDRwcWpvRkNOcjAvUFltSFNNUDNRaDdxak1ReGxvdnhIWXV4bVZUaXpu?=
 =?utf-8?B?VWJqZWNTNFFnOTF6TW9YKytjdEJnWnQvU3VtL0tCVE8wTXNuWFRIZUUwN3VS?=
 =?utf-8?B?ZEx3eDVhcEgyeUNON0FSV1QwU3RzY1Jpell2TFRNMm5aTDA3NSsyYXhHN3NG?=
 =?utf-8?B?RnVBL1lKaXdTOTdEckR0Qmxrb3FrSVd4eHU5cmUydlFRQmpNTnJxazVkYUUz?=
 =?utf-8?B?MitaVmlYZk9GY3BiRjdJM0FzU2hhWHZSbDRUUFZmSFYybXZtSm9vN202ZXFN?=
 =?utf-8?B?ZGpMMER1SVdXL2d5M0twUW9IUGNuazF3L01Cc0t2TjA4cmZkUmIzeitlOHhh?=
 =?utf-8?B?Qk5FcHBQa3hxWmhIZUFqaElzdkpQSTEycDBxOUFkTGtoTENlWnYyUDdoTU81?=
 =?utf-8?B?MUU2WkhqaHVWekxNOVdwOTBXN21OWVIxWEJQbFR6djVxenI3Q09CK0VKM05l?=
 =?utf-8?B?UjdiZDEwOW8rNm1ESk42OUtXT1dWWENuaEhGdTRSeU1RWG84amNXelVNQ2Zk?=
 =?utf-8?B?OXFtb04vWVRsdy9pRWYxRktZRDh3akdOYjQ1dGtWd25MN012ck9zUkUzUU5r?=
 =?utf-8?B?R1h6NHdoUGsreWZkdGJlWDhNdVBCNm9aVTBwSHh5TzBuRkVrTTRzM1g1Nmsz?=
 =?utf-8?B?ZkFoYy9mREJDY0dNSng3Mmg2eFptcE1xazlnb2xpTUg4N0s4UEhTdCszb1p6?=
 =?utf-8?B?L3YyRzJYR0owT1ZRYmJTTTVZOG4wN003b3VsWncveFBVRlVnd2dqMHpQRHFx?=
 =?utf-8?B?akZwcTV0ZWh2ZUt0SExZQ0d4c2FDelpiY2tOaG43NGhLT0RIZEhkMVFrOXR0?=
 =?utf-8?B?RElRb0Jrd2QvOFphV1AybWZZaWdxUlJLMnFNUS9ZcStzejNhK1BVclhtWEhK?=
 =?utf-8?B?aTZnZG5jZlhBQWVVRW9kVjRMR1l3U1BWNkMrWGtpbVBYYytjSllJNWRaL3Bu?=
 =?utf-8?B?bGhiMUJmbmhhNlB2eGhrZ3dmSE9meEpOUkNYRHVIbmNiQm1iSktVemVDUHBD?=
 =?utf-8?B?MElWK083aFN5WlBxcnZkL0libjBHSVMvbXFlNWs3dzZDMklkVHJhRVpyeHE2?=
 =?utf-8?B?MkdtT2I3alBnZnZvV0R0UkpzOEFvVXNjNk1QT2tWUXNLMXllNjJaOEd4dXNI?=
 =?utf-8?B?Yzd5TU5BU0pIdXhrRlUvY0JQak5QSitnNk1ZSzA1VW9OeGJQWjZtWGxoYmtO?=
 =?utf-8?B?RG56a1FldG1wV0Q2VjlicGUvRXNLUWhtRWVubUIyTExqcGZ3V2MwZHE4QjUz?=
 =?utf-8?B?SzcxV2o5TDE2U1E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcceb80e-50f7-4336-dded-08dbb402c411
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 02:40:17.5182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uVtmShExxmxBnRhPM5s+p8IwtxT1LXpZ61BjPFC58owHyeXoo7iL/NC2FV/HTg4u+Ft9wGdcck3uADJNnt3Ws1hrv8EbvIU+8ggptM2PFaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4921
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_24,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130019
X-Proofpoint-ORIG-GUID: X3fXuWzOF4JC6NYdeb_jguq67W7Zy9w8
X-Proofpoint-GUID: X3fXuWzOF4JC6NYdeb_jguq67W7Zy9w8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gU2VwIDEyLCAyMDIzLCBhdCA0OjQ3IFBNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51
eC5pYm0uY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgMjAyMy0wOS0xMiBhdCAxNzoxMSArMDAw
MCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IA0KPj4+IE9uIFNlcCAxMiwgMjAyMywgYXQgNTo1
NCBBTSwgTWltaSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4g
T24gVHVlLCAyMDIzLTA5LTEyIGF0IDAyOjAwICswMDAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0K
Pj4+PiANCj4+Pj4+IE9uIFNlcCAxMSwgMjAyMywgYXQgNTowOCBQTSwgTWltaSBab2hhciA8em9o
YXJAbGludXguaWJtLmNvbT4gd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IE9uIE1vbiwgMjAyMy0wOS0x
MSBhdCAyMjoxNyArMDAwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+Pj4+PiANCj4+Pj4+Pj4g
T24gU2VwIDExLCAyMDIzLCBhdCAxMDo1MSBBTSwgTWlja2HDq2wgU2FsYcO8biA8bWljQGRpZ2lr
b2QubmV0PiB3cm90ZToNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IE9uIE1vbiwgU2VwIDExLCAyMDIzIGF0
IDA5OjI5OjA3QU0gLTA0MDAsIE1pbWkgWm9oYXIgd3JvdGU6DQo+Pj4+Pj4+PiBIaSBFcmljLA0K
Pj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBPbiBGcmksIDIwMjMtMDktMDggYXQgMTc6MzQgLTA0MDAsIEVy
aWMgU25vd2Jlcmcgd3JvdGU6DQo+Pj4+Pj4+Pj4gQ3VycmVudGx5IHJvb3QgY2FuIGR5bmFtaWNh
bGx5IHVwZGF0ZSB0aGUgYmxhY2tsaXN0IGtleXJpbmcgaWYgdGhlIGhhc2gNCj4+Pj4+Pj4+PiBi
ZWluZyBhZGRlZCBpcyBzaWduZWQgYW5kIHZvdWNoZWQgZm9yIGJ5IHRoZSBidWlsdGluIHRydXN0
ZWQga2V5cmluZy4NCj4+Pj4+Pj4+PiBDdXJyZW50bHkga2V5cyBpbiB0aGUgc2Vjb25kYXJ5IHRy
dXN0ZWQga2V5cmluZyBjYW4gbm90IGJlIHVzZWQuDQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gS2V5
cyB3aXRoaW4gdGhlIHNlY29uZGFyeSB0cnVzdGVkIGtleXJpbmcgY2FycnkgdGhlIHNhbWUgY2Fw
YWJpbGl0aWVzIGFzDQo+Pj4+Pj4+Pj4gdGhlIGJ1aWx0aW4gdHJ1c3RlZCBrZXlyaW5nLiAgUmVs
YXggdGhlIGN1cnJlbnQgcmVzdHJpY3Rpb24gZm9yIHVwZGF0aW5nDQo+Pj4+Pj4+Pj4gdGhlIC5i
bGFja2xpc3Qga2V5cmluZyBhbmQgYWxsb3cgdGhlIHNlY29uZGFyeSB0byBhbHNvIGJlIHJlZmVy
ZW5jZWQgYXMNCj4+Pj4+Pj4+PiBhIHRydXN0IHNvdXJjZS4gIFNpbmNlIHRoZSBtYWNoaW5lIGtl
eXJpbmcgaXMgbGlua2VkIHRvIHRoZSBzZWNvbmRhcnkNCj4+Pj4+Pj4+PiB0cnVzdGVkIGtleXJp
bmcsIGFueSBrZXkgd2l0aGluIGl0IG1heSBhbHNvIGJlIHVzZWQuDQo+Pj4+Pj4+Pj4gDQo+Pj4+
Pj4+Pj4gQW4gZXhhbXBsZSB1c2UgY2FzZSBmb3IgdGhpcyBpcyBJTUEgYXBwcmFpc2FsLiAgTm93
IHRoYXQgSU1BIGJvdGgNCj4+Pj4+Pj4+PiByZWZlcmVuY2VzIHRoZSBibGFja2xpc3Qga2V5cmlu
ZyBhbmQgYWxsb3dzIHRoZSBtYWNoaW5lIG93bmVyIHRvIGFkZA0KPj4+Pj4+Pj4+IGN1c3RvbSBJ
TUEgQ0EgY2VydHMgdmlhIHRoZSBtYWNoaW5lIGtleXJpbmcsIHRoaXMgYWRkcyB0aGUgYWRkaXRp
b25hbA0KPj4+Pj4+Pj4+IGNhcGFiaWxpdHkgZm9yIHRoZSBtYWNoaW5lIG93bmVyIHRvIGFsc28g
ZG8gcmV2b2NhdGlvbnMgb24gYSBydW5uaW5nDQo+Pj4+Pj4+Pj4gc3lzdGVtLg0KPj4+Pj4+Pj4+
IA0KPj4+Pj4+Pj4+IElNQSBhcHByYWlzYWwgdXNhZ2UgZXhhbXBsZSB0byBhZGQgYSByZXZvY2F0
aW9uIGZvciAvdXNyL2ZvbzoNCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBzaGEyNTZzdW0gL2Jpbi9m
b28gfCBhd2sgJ3twcmludGYgImJpbjoiICQxfScgPiBoYXNoLnR4dA0KPj4+Pj4+Pj4+IA0KPj4+
Pj4+Pj4+IG9wZW5zc2wgc21pbWUgLXNpZ24gLWluIGhhc2gudHh0IC1pbmtleSBtYWNoaW5lLXBy
aXZhdGUta2V5LnBlbSBcDQo+Pj4+Pj4+Pj4gICAgLXNpZ25lciBtYWNoaW5lLWNlcnRpZmljYXRl
LnBlbSAtbm9hdHRyIC1iaW5hcnkgLW91dGZvcm0gREVSIFwNCj4+Pj4+Pj4+PiAgICAtb3V0IGhh
c2gucDdzDQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4ga2V5Y3RsIHBhZGQgYmxhY2tsaXN0ICIkKDwg
aGFzaC50eHQpIiAlOi5ibGFja2xpc3QgPCBoYXNoLnA3cw0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+
IFNpZ25lZC1vZmYtYnk6IEVyaWMgU25vd2JlcmcgPGVyaWMuc25vd2JlcmdAb3JhY2xlLmNvbT4N
Cj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gVGhlIHNlY29uZGFyeSBrZXlyaW5nIG1heSBpbmNsdWRlIGJv
dGggQ0EgYW5kIGNvZGUgc2lnbmluZyBrZXlzLiAgV2l0aA0KPj4+Pj4+Pj4gdGhpcyBjaGFuZ2Ug
YW55IGtleSBsb2FkZWQgb250byB0aGUgc2Vjb25kYXJ5IGtleXJpbmcgbWF5IGJsYWNrbGlzdCBh
DQo+Pj4+Pj4+PiBoYXNoLiAgV291bGRuJ3QgaXQgbWFrZSBtb3JlIHNlbnNlIHRvIGxpbWl0IGJs
YWNrbGlzdGluZw0KPj4+Pj4+Pj4gY2VydGlmaWNhdGVzL2hhc2hlcyB0byBhdCBsZWFzdCBDQSBr
ZXlzPyANCj4+Pj4+Pj4gDQo+Pj4+Pj4+IFNvbWUgb3BlcmF0aW9uYWwgY29uc3RyYWludHMgbWF5
IGxpbWl0IHdoYXQgYSBDQSBjYW4gc2lnbi4NCj4+Pj4+PiANCj4+Pj4+PiBBZ3JlZWQuICANCj4+
Pj4+PiANCj4+Pj4+PiBJcyB0aGVyZSBwcmVjZWRlbnRzIGZvciByZXF1aXJpbmcgdGhpcyBTL01J
TUUgdG8gYmUgc2lnbmVkIGJ5IGEgQ0E/IA0KPj4+Pj4+IA0KPj4+Pj4+PiBUaGlzIGNoYW5nZSBp
cyBjcml0aWNhbCBhbmQgc2hvdWxkIGJlIHRpZWQgdG8gYSBkZWRpY2F0ZWQga2VybmVsIGNvbmZp
Zw0KPj4+Pj4+PiAoZGlzYWJsZWQgYnkgZGVmYXVsdCksIG90aGVyd2lzZSBleGlzdGluZyBzeXN0
ZW1zIHVzaW5nIHRoaXMgZmVhdHVyZQ0KPj4+Pj4+PiB3aWxsIGhhdmUgdGhlaXIgdGhyZWF0IG1v
ZGVsIGF1dG9tYXRpY2FsbHkgY2hhbmdlZCB3aXRob3V0IG5vdGljZS4NCj4+Pj4+PiANCj4+Pj4+
PiBUb2RheSB3ZSBoYXZlIElOVEVHUklUWV9DQV9NQUNISU5FX0tFWVJJTkdfTUFYLiAgVGhpcyBj
YW4gDQo+Pj4+Pj4gYmUgZW5hYmxlZCB0byBlbmZvcmNlIENBIHJlc3RyaWN0aW9ucyBvbiB0aGUg
bWFjaGluZSBrZXlyaW5nLiAgTWltaSwgd291bGQgDQo+Pj4+Pj4gdGhpcyBiZSBhIHN1aXRhYmxl
IHNvbHV0aW9uIGZvciB3aGF0IHlvdSBhcmUgYWZ0ZXI/DQo+Pj4+PiANCj4+Pj4+IFRoZXJlIG5l
ZWRzIHRvIGJlIHNvbWUgY29ycmVsYXRpb24gYmV0d2VlbiB0aGUgZmlsZSBoYXNoZXMgYmVpbmcg
YWRkZWQNCj4+Pj4+IHRvIHRoZSBibGFja2xpc3QgYW5kIHRoZSBjZXJ0aWZpY2F0ZSB0aGF0IHNp
Z25lZCB0aGVtLiAgV2l0aG91dCB0aGF0DQo+Pj4+PiBjb3JyZWxhdGlvbiwgYW55IGtleSBvbiB0
aGUgc2Vjb25kYXJ5IHRydXN0ZWQga2V5cmluZyBjb3VsZCBhZGQgYW55DQo+Pj4+PiBmaWxlIGhh
c2hlcyBpdCB3YW50cyB0byB0aGUgYmxhY2tsaXN0Lg0KPj4+PiANCj4+Pj4gVG9kYXkgYW55IGtl
eSBpbiB0aGUgc2Vjb25kYXJ5IHRydXN0ZWQga2V5cmluZyBjYW4gYmUgdXNlZCB0byB2YWxpZGF0
ZSBhIA0KPj4+PiBzaWduZWQga2VybmVsIG1vZHVsZS4gIEF0IGEgbGF0ZXIgdGltZSwgaWYgYSBu
ZXcgaGFzaCBpcyBhZGRlZCB0byB0aGUgYmxhY2tsaXN0IA0KPj4+PiBrZXlyaW5nIHRvIHJldm9r
ZSBsb2FkaW5nIGEgc2lnbmVkIGtlcm5lbCBtb2R1bGUsICB0aGUgYWJpbGl0eSB0byBkbyB0aGUg
DQo+Pj4+IHJldm9jYXRpb24gd2l0aCB0aGlzIGFkZGl0aW9uYWwgY2hhbmdlIHdvdWxkIGJlIG1v
cmUgcmVzdHJpY3RpdmUgdGhhbiBsb2FkaW5nIA0KPj4+PiB0aGUgb3JpZ2luYWwgbW9kdWxlLg0K
Pj4+IA0KPj4+IEEgcHVibGljIGtleSBvbiB0aGUgc2Vjb25kYXJ5IGtleXJpbmcgaXMgdXNlZCB0
byB2ZXJpZnkgY29kZSB0aGF0IGl0DQo+Pj4gc2lnbmVkLCBidXQgZG9lcyBub3QgaW1wYWN0IGFu
eSBvdGhlciBjb2RlLiBBbGxvd2luZyBhbnkgcHVibGljIGtleSBvbg0KPj4+IHRoZSBzZWNvbmRh
cnkga2V5cmluZyB0byBibGFja2xpc3QgYW55IGZpbGUgaGFzaCBpcyBnaXZpbmcgaXQgbW9yZQ0K
Pj4+IHByaXZpbGVnZXMgdGhhbiBpdCBvcmlnaW5hbGx5IGhhZC4NCj4+PiANCj4+PiBUaGlzIHJl
cXVpcmVtZW50IGlzbid0IGRpZmZlcmVudCB0aGFuIGhvdyBDZXJ0aWZpY2F0ZSBSZXZvY2F0aW9u
IExpc3QNCj4+PiAoQ1JMKSB3b3JrLiAgTm90IGFueSBDQSBjYW4gcmV2b2tlIGEgY2VydGlmaWNh
dGUuDQo+PiANCj4+IEluIFVFRkkgU2VjdXJlIEJvb3Qgd2UgaGF2ZSB0aGUgRm9yYmlkZGVuIFNp
Z25hdHVyZSBEYXRhYmFzZSAoREJYKS4gIA0KPj4gUm9vdCBjYW4gdXBkYXRlIHRoZSBEQlggb24g
YSBob3N0LiAgVGhlIHJlcXVpcmVtZW50IHBsYWNlZCBvbiB1cGRhdGluZyANCj4+IGl0IGlzIHRo
ZSBuZXcgREJYIGVudHJ5IG11c3QgYmUgc2lnbmVkIGJ5IGFueSBrZXkgY29udGFpbmVkIHdpdGhp
biB0aGUgDQo+PiBLRUsuICBGb2xsb3dpbmcgYSByZWJvb3QsIGFsbCBEQlggZW50cmllcyBsb2Fk
IGludG8gdGhlIC5ibGFja2xpc3Qga2V5cmluZy4gIA0KPj4gVGhlcmUgaXMgbm90IGEgcmVxdWly
ZW1lbnQgc2ltaWxhciB0byBob3cgQ1JM4oCZcyB3b3JrIGhlcmUsIGFueSBLRUsga2V5IA0KPj4g
Y2FuIGJlIHVzZWQuDQo+PiANCj4+IFdpdGggYXJjaGl0ZWN0dXJlcyBib290ZWQgdGhyb3VnaCBh
IHNoaW0gdGhlcmUgaXMgdGhlIE1PS1guICBTaW1pbGFyIHRvIA0KPj4gREJYLCBNT0tYIGhhdmUg
dGhlIHNhbWUgY2FwYWJpbGl0aWVzLCBob3dldmVyIHRoZXkgZG8gbm90IG5lZWQgdG8gYmUgDQo+
PiBzaWduZWQgYnkgYW55IGtleSwgdGhlIG1hY2hpbmUgb3duZXIgbXVzdCBzaG93IHRoZXkgaGF2
ZSBwaHlzaWNhbCANCj4+IHByZXNlbmNlIChhbmQgcG90ZW50aWFsbHkgYSBNT0sgcGFzc3dvcmQp
IGZvciBpbmNsdXNpb24uICBBZ2FpbiB0aGVyZSANCj4+IGlzIG5vdCBhIHJlcXVpcmVtZW50IHNp
bWlsYXIgdG8gaG93IENSTOKAmXMgd29yayBoZXJlIGVpdGhlci4gIFRoZSBtYWNoaW5lIA0KPj4g
b3duZXIgY2FuIGRlY2lkZSB3aGF0IGlzIGluY2x1ZGVkLg0KPj4gDQo+PiBUb2RheSB3aGVuIGEg
a2VybmVsIGlzIGJ1aWx0LCBhbnkgbnVtYmVyIG9mIGtleXMgbWF5IGJlIGluY2x1ZGVkIHdpdGhp
biANCj4+IHRoZSBidWlsdGluIHRydXN0ZWQga2V5cmluZy4gIFRoZSBrZXlzIGluY2x1ZGVkIGlu
IHRoZSBrZXJuZWwgbWF5IG5vdCBoYXZlIA0KPj4gYSBzaW5nbGUgdXNhZ2UgZmllbGQgc2V0IG9y
IHRoZSBDQSBiaXQgc2V0LiAgVGhlcmUgYXJlIG5vIHJlcXVpcmVtZW50cyBvbiANCj4+IGhvdyB0
aGVzZSBrZXlzIGdldCB1c2VkIGxhdGVyIG9uLiAgQW55IGtleSBpbiB0aGUgYnVpbHRpbiB0cnVz
dGVkIGtleXJpbmcgDQo+PiBjYW4gYmUgdXNlZCB0byBzaWduIGEgcmV2b2NhdGlvbiB0aGF0IGNh
biBiZSBhZGRlZCB0byB0aGUgYmxhY2tsaXN0IGtleXJpbmcuICANCj4+IEFkZGl0aW9uYWxseSwg
YW55IGtleSBpbiB0aGUgTU9LIGNhbiBiZSB1c2VkIHRvIHNpZ24gdGhpcyBrZXJuZWwgYW5kIGl0
IHdpbGwgDQo+PiBib290LiAgQmVmb3JlIGJvb3RpbmcgdGhlIGtlcm5lbCwgTU9LIGtleXMgaGF2
ZSBtb3JlIHByaXZpbGVnZXMgdGhhbiANCj4+IGFmdGVyIHRoZSBrZXJuZWwgaXMgYm9vdGVkIGlu
IHNvbWUgaW5zdGFuY2VzLg0KPj4gDQo+PiBUb2RheSBNT0sga2V5cyBjYW4gYmUgbG9hZGVkIGlu
dG8gdGhlIG1hY2hpbmUga2V5cmluZy4gIFRoZXNlIGtleXMgZ2V0IA0KPj4gbGlua2VkIHRvIHRo
ZSBzZWNvbmRhcnkgdHJ1c3RlZCBrZXlyaW5nLiAgQ3VycmVudGx5IGtleSB1c2FnZSBlbmZvcmNl
bWVudA0KPj4gaXMgYmVpbmcgYXBwbGllZCB0byB0aGVzZSBrZXlzIGJlaGluZCBzb21lIEtjb25m
aWcgb3B0aW9ucy4gIEJ5IGRlZmF1bHQgDQo+PiBhbnl0aGluZyBpbiB0aGUgc2Vjb25kYXJ5IGhh
cyB0aGUgc2FtZSBjYXBhYmlsaXRpZXMgYXMgdGhlIGJ1aWx0aW4gdHJ1c3RlZCANCj4+IGtleXJp
bmcuICBXaGF0IGlzIGNoYWxsZW5naW5nIGhlcmUgd2l0aCB0aGlzIHJlcXVlc3QgaXMgdGhlIGlu
Y29uc2lzdGVuY3kgDQo+PiBiZXR3ZWVuIGhvdyBldmVyeXRoaW5nIGVsc2UgY3VycmVudGx5IHdv
cmtzLiANCj4+IA0KPj4gUm9vdCBjYW4gbm90IGFyYml0cmFyaWx5IGFkZCB0aGluZ3MgdG8gdGhl
IHNlY29uZGFyeSB0cnVzdGVkIGtleXJpbmcuICBUaGVzZSANCj4+IGtleXMgbXVzdCBiZSBzaWdu
ZWQgYnkgc29tZXRoaW5nIGluIGVpdGhlciB0aGUgbWFjaGluZSBvciB0aGUgYnVpbHRpbi4gIElu
IA0KPj4gdGhpcyB0aHJlYWQgWzFdLCBKYXJra28gaXMgc2F5aW5nIENBIGJhc2VkIGluZnJhc3Ry
dWN0dXJlIHNob3VsZCBiZSBhIHBvbGljeSANCj4+IGRlY2lzaW9uIG5vdCB0byBiZSBlbmZvcmNl
ZCBieSB0aGUga2VybmVsLiBXb3VsZG7igJl0IHRoaXMgYXBwbHkgaGVyZSBhcyB3ZWxsPw0KPj4g
DQo+PiAxLiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL0NWR1VGVUVRVkNIUy4zN09BMjBQ
Tkc5RVZCQHN1cHBpbG92YWh2ZXJvLw0KPiANCj4gTWlja2HDq2wgc2FpZCwgIlRoaXMgY2hhbmdl
IGlzIGNyaXRpY2FsIGFuZCBzaG91bGQgYmUgdGllZCB0byBhDQo+IGRlZGljYXRlZCBrZXJuZWwg
Y29uZmlnDQo+IChkaXNhYmxlZCBieSBkZWZhdWx0KSwgb3RoZXJ3aXNlIGV4aXN0aW5nIHN5c3Rl
bXMgdXNpbmcgdGhpcyBmZWF0dXJlDQo+IHdpbGwgaGF2ZSB0aGVpciB0aHJlYXQgbW9kZWwgYXV0
b21hdGljYWxseSBjaGFuZ2VkIHdpdGhvdXQgbm90aWNlLiINCg0KSSB3YXMgdGhpbmtpbmcgaGUg
bWVhbnQgaXQgaXMgY3JpdGljYWwgbm90IHRvIGNoYW5nZSB0aGUgY3VycmVudCBiZWhhdmlvcg0K
YnkgbGltaXRpbmcgYmxhY2tsaXN0aW5nIHRvIG9ubHkgQ0Ega2V5cy4gIE5vdCB0aGF0IGl0IHdh
cyBjcml0aWNhbCB0byBhZGQNCkNBIGVuZm9yY2VtZW50LiAgTWF5YmUgTWlja2HDq2wgY2FuIGNv
bW1lbnQ/DQoNCj4gQXMgYSBwb3NzaWJsZSBhbHRlcm5hdGl2ZSBJIHN1Z2dlc3RlZCBsaW1pdGlu
ZyB3aGljaCBmaWxlIGhhc2hlcyB0aGUNCj4gY2VydHMgb24gdGhlIHNlY29uZGFyeSAob3IgbWFj
aGluZSkga2V5cmluZyBjb3VsZCBibGFja2xpc3QuDQoNCknigJltIG5vdCBzdXJlIEkgY29tcGxl
dGVseSB1bmRlcnN0YW5kIHlvdXIgc3VnZ2VzdGlvbiBoZXJlLg0KRG8geW91IG1lYW4sIHZlcmlm
eSB0aGUgQ0EgYml0IGlzIHNldCBmb3Igc2Vjb25kYXJ5IGtleXMsIGJ1dA0KaWdub3JlIHRoZSBi
aXQgZm9yIGJ1aWx0aW4/ICBBbmQgdGhlbiBvbmx5IHVzZSB0aG9zZSBrZXlzIHRvIGFkZA0KaGFz
aGVzIHRvIHRoZSBibGFja2xpc3Qga2V5cmluZz8gIElmIEkgaGF2ZSB0aGF0IHJpZ2h0LCB3aGF0
IHdvdWxkIA0KYmUgdGhlIGp1c3RpZmljYXRpb24gZm9yIHRoZSBjaGFuZ2UgYmFzZWQgb24gaG93
IHRoaW5ncyBjdXJyZW50bHkNCmdldCBpbmNsdWRlZCBpbiB0aGUgYmxhY2tsaXN0IGtleXJpbmc/
ICBUaGFua3MuDQoNCg0K
