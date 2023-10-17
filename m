Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B65B7CCC6E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344010AbjJQTkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbjJQTkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:40:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECD098;
        Tue, 17 Oct 2023 12:40:09 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HIx7pd026469;
        Tue, 17 Oct 2023 19:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=PnhjC202Bv8NGJ9HRowMQFClUnZFnfO3IJr3Nra7Vvw=;
 b=SjXwHKA3lLp7CsR9dea02mDc807KVje3Pq7UK9DZ1Hmv8ASrBh0cgb2otCdYmtGYLotS
 ctu6xu84hPaXQAGM888WzKIjdk+INoy1BHI61flzcX2PTAsgU9Do4x8R8NTgIQO9ie13
 yAELjs6kkVuXtUGv0o2VLIHCTQk6DZwYnbJ3lWYD4wTIoNMZAoKwgyRRYLMkTDB7I5ID
 jOtzFdfRdTUF0Y6qhEQNex7X0F9QiniW9ZXmFovF6/VoEJwzV3faROdQF5xamPf8TG7A
 lYZA87lTnLS+9BPO/TpIlTLq4pPLGyahbscQ1lEWYXJhTyFmXwr8WDF4XHPfYfRypTxX tw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1bnya0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 19:34:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39HIqbJS015204;
        Tue, 17 Oct 2023 19:34:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg1fgqhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 19:34:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krnjwvB2o9Zj5YnDLn9dqhTuasv6Qf1Go8Pgi3EmA3F/u7afW+rw9LWkAqqAerN3ivRtFIBx20WbM0PDk0Q/c9F0ZXequR507ZqCqvrTbBF8B8LArQNltqVdy/qElUHVo0zQL8OBCCRgePKKXLKip1kHkoLrakrVmP41Lf+HxJQovtSsVdzgt03aleXG9d/QA5RVGuL1WhwFPQ9+Z5H7n+AovkFU/fAwx2kQoY46hWX5h/DLbCI/uaAGF6sX/G7htKafH4DRXQL1ybgtIQYrb4/WhIT9dV3xhYmwJF4NvaOhZDgr5iBG8LystXXHvAtZ0JftHd0WJd2++uIw+/zYeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnhjC202Bv8NGJ9HRowMQFClUnZFnfO3IJr3Nra7Vvw=;
 b=oEfkcFdml0u2VrX4VNBFLVcT8aH+uWbiuol4nRDHzyGU6eAh6P8TGasDFfTeujgH3K23xptg4AL/55VIZMdl8PO4syHUU+N0Jem9VwusYfrFQ1Z706Kj//5Big/cBtu+isdAiqajik/8kS9RAdw/vaP1mZc4HBxjDRKmZPHttMfr6tchNj8vfckTY0OSC/jpyBZzmeCn+sKfCc5TB+SKtfsYuY5QM/PPThqc/UK3qFRdvG/T9gAeJXxDlBv9/xHMi5s0/CH39gdDgY7LcwuglNNQZMRJArdZsDlPAIEdMiB/0mPJdXIYhWpkESxLvTVGLSu0m28Pgh1RBQD2Z066/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnhjC202Bv8NGJ9HRowMQFClUnZFnfO3IJr3Nra7Vvw=;
 b=oRM2ZMl0nhC/06TxSa9Zh6Hgi4l1GZFedJcdYQtMSkVT6OYymz/3snhDG9JVTk29C5JokdGeflwT3QcL9XcFdLTT+fYk8WHZOE2IrCr6tyibAmHsHOoQyYOoF95pvnLZ3MWbmBhH2s3sXhi4LbREo+2uRvQ2lCmKGUUGZkcVHvc=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SA1PR10MB6413.namprd10.prod.outlook.com (2603:10b6:806:258::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 19:34:25 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::134:c770:8cb6:70e]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::134:c770:8cb6:70e%4]) with mapi id 15.20.6863.032; Tue, 17 Oct 2023
 19:34:25 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>
CC:     =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: RFC: New LSM to control usage of x509 certificates
Thread-Topic: RFC: New LSM to control usage of x509 certificates
Thread-Index: AQHZ93c4gJX6SHkC80mNOExcrBTnXrBOD7yAgAAjSwCAABc5gIAABa6AgAAIMoCAAA68gIAADAcA
Date:   Tue, 17 Oct 2023 19:34:25 +0000
Message-ID: <2512D2AE-4ACA-41B9-B9FB-C2B4802B9A10@oracle.com>
References: <CEA476C1-4CE5-4FFC-91D7-6061C8605B18@oracle.com>
 <ba2f5560800608541e81fbdd28efa9875b35e491.camel@linux.ibm.com>
 <932231F5-8050-4436-84B8-D7708DC43845@oracle.com>
 <7335a4587233626a39ce9bc8a969957d7f43a34c.camel@linux.ibm.com>
 <FD6FB139-F901-4E55-9705-E7B0023BDBA8@oracle.com>
 <1149b6dbfdaabef3e48dc2852cc76aa11a6dd6b0.camel@linux.ibm.com>
 <4A0505D0-2933-43BD-BEEA-94350BB22AE7@oracle.com>
 <20230913.Ceifae7ievei@digikod.net>
 <D0F16BFD-72EB-4BE2-BA3D-BAE1BCCDCB6F@oracle.com>
 <20230914.shah5al9Kaib@digikod.net> <20231005.dajohf2peiBu@digikod.net>
 <d3b51f26c14fd273d41da3432895fdce9f4d047c.camel@linux.ibm.com>
 <CAHC9VhRdU1CZJpPSEdSmui-Xirr0j261K=+SM7KiDwiPG-JSrQ@mail.gmail.com>
 <a851227aaa75ab16b0d6dd93433e1ee1679715f9.camel@linux.ibm.com>
 <CAHC9VhS_Ttdy5ZB=jYdVfNyaJfn_7G1wztr5+g0g7uUDForXvA@mail.gmail.com>
 <5c795b4cf6d7460af205e85a36194fa188136c38.camel@linux.ibm.com>
 <CAHC9VhTug20M0ET=QojUPtjrGkeHfU=ADDNrKfXmLTQPG_i1vw@mail.gmail.com>
In-Reply-To: <CAHC9VhTug20M0ET=QojUPtjrGkeHfU=ADDNrKfXmLTQPG_i1vw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|SA1PR10MB6413:EE_
x-ms-office365-filtering-correlation-id: 7f4d7d7d-9e59-4b7e-5262-08dbcf48125d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AgXYRKPc1PXg41drOfDIMPdRSPr8Dr0OfdiDxJMGQ/0xA1b0SgGIEJOzm9ZrL1ZQ9ncjcaCiMHznu3OUlKwDlBMIAHSVIn5dVM1namhscnyYOwK/JTfnD+sVMc4++2AptWpFykRECE9R206aqAZBnfrAxIQiRi9LK8hgg+UCg7hc1yuF2RT4u2licYLLBQCF9ZTIkUaLof5W+F301GoRHclw3hnqy7gQimEkjl/teq/KtAKcdqGYlrj49lgDXIkGpUHcSmHOX9CLs3HHxVH4H7a0VmxNcXJamD+yHPTeylPKqvEnQMf/zJipk3uMkbX7PuPhvG3l0tQBct7H51d50EKzMh79H959vL9JPu7su9+oI7IaBdLilIj6OX2zxij5K25J65yI5M5uNpm1OW3Ske6SuifTWJ4TBRRDVNQXUxlodOjDvk3mWJvHnaoJBV3YMbm6EZxDTrttaAiK6GuGojaFHdeWNGfbq+Heol7xq6Sx/uBwbl+6Em1xP3/ohZjwEvGLNEFozk7jfGmg1v9qiW28ICIElTBhVIaJyxyQp8VSOqkRAH3R1QxYjKHgjUMMopffuXZyJQDS70P0UG/utr/30y3e5XKK93cZU4o+73kZUD3eQFXaJluW/9Px+VrUnr6DZewPGM5rbefNmUFVnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(53546011)(64756008)(66446008)(66476007)(478600001)(54906003)(6486002)(71200400001)(110136005)(76116006)(966005)(66556008)(91956017)(66946007)(41300700001)(83380400001)(86362001)(38100700002)(6512007)(2616005)(26005)(6506007)(316002)(66574015)(44832011)(4326008)(122000001)(36756003)(8676002)(8936002)(33656002)(7416002)(38070700005)(4001150100001)(5660300002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qmo4a21JY3BOS0Z5dUtHWkN2QnpQeTRIYkRuMHRRcDZjcFcvQ3Z3anFDZ3lK?=
 =?utf-8?B?bTFvdGlBcDNsVnhFRUxNdnFacEJHSzRZS2lqUEpDQVVoRllPT3pBdWU4b2pz?=
 =?utf-8?B?OEdLcG4rTmdmRXkvdHpVbW1hTDc0NHJCaUlrblB5bTRsZy8yMElpT2Q4Vk9F?=
 =?utf-8?B?blJ3cHlGNFF5NmFPejdablBJRXlLRXdjQXBNekM4TVA4Umw5RDJDaUt4ZVlh?=
 =?utf-8?B?TG9jTEQrU0VUdWd3MFlOQURZWVpwaXpCR1YxZ1hEa2xwZmJjcnNkRWJCQ2tP?=
 =?utf-8?B?Z3ZBUWNnaUNCYUgxT2N0Yk5xc3dlWFZlNFhUNndpTXA2SVE3Q1BtRDJ5b1VZ?=
 =?utf-8?B?dGZxRDc3cW5FRVhzT0JZYXBSS1Noemt4YzNrMTExVTJSQXRDZmZkT0tsSENE?=
 =?utf-8?B?Um5ETzNzMlIvRWlHbHBoRkdBV25RenkwRy96bE9qYXJxQkdveVlta21IbTZE?=
 =?utf-8?B?M20zamdHeXB3L3B6MDhISDV4aEJsSFhubHozMXUyN1laRUhmenJRNzFTd2ow?=
 =?utf-8?B?OTNXS2s3L3VSblFCRjhlRHpqRWJycWo1V1dxN0JLL1VkSHpnYlFtemwxS2ZI?=
 =?utf-8?B?M0todEhWUDBiQTFBeDhLdWF0a2tmUko5cCt6U0tlbEpFZmhZQ1pXLzhMYS9n?=
 =?utf-8?B?SFViS3dNdE9UWnE4NWdncGZFTHowK0luUnMrNjNxYXVLN3BqVFp2c0d1eDJu?=
 =?utf-8?B?QjczMDhTTGhMMzVHVzhLVHE5S3ZXNlFnMW9UQzBMM2R2R0MvWktNbE1JVDgx?=
 =?utf-8?B?cjNMOXB2NXRqUGxCRC8wQlJvdDRHeHF4S3pJUDBzRWh6ektPRndERE5CWlJJ?=
 =?utf-8?B?Vngwek12ck1xcTFtdi9ZdWZadlNWanZGcU1vYnRNRTN5NTUzWU1xUHlMaWkx?=
 =?utf-8?B?Snp1OENUakhRcDBwblJOdllvUWcxVzZTQW1LVk5rbE1qTXNuOGhjL1VEQzBI?=
 =?utf-8?B?OFV3dDJhUHlhSktNNzBoUmJWTEszaTRtM2VnT2E1VWJlaFVHZjdndW94a1dl?=
 =?utf-8?B?UjBtODJEeklEQlZJejI0VzAyc0xwRjIza0d5eFlKQ0MxTFNnY2QwUExtaEJ3?=
 =?utf-8?B?cHo3UjEzZG5SZlM1aklWTFVERVpQZm5NNmZZL2VJSEtQMnV5Y292U3U2U1Na?=
 =?utf-8?B?UUJMZm9GSm0wTlJ6V0lJSWJ5QzdxMTByK2VmZWk2ODZ6aGsrVFNFSmxZTDFa?=
 =?utf-8?B?TUdwK3VST0RvTmFNNGgwT202cDU4MGVkRVVNM3pmVG1IWlpwL2JEV3BvZ2pK?=
 =?utf-8?B?SVpzOU5HYVEwQWtnbHhqUURqN1JuRTM0YnZhTzRUWEhoTnYxWTNMaGpqQS9z?=
 =?utf-8?B?ZDlUU3hMeFoxVEh0K2R3RDh6QzQwR1o5anZ3cnZyc0VkODYxMzlWZTBWTlQ5?=
 =?utf-8?B?VU1wNTZpdGM0bEU0QndGK1hCZFVzVnBidVJXV1Zud0tySFUzdk5kR3N3bmFR?=
 =?utf-8?B?TnhOUWp0MFgxVWdGblpUd0Vic2ZBL3N4WVBsdnlUQ3VJUkdpempqeThBeWJR?=
 =?utf-8?B?UXRTVVZhU3ZrenRRNzZVY3FVdkJad3piUkt4dDFpRjhqdDFyS3NEN2Q3RjRi?=
 =?utf-8?B?MkVveFZiZC9vY1pNY2hEK3lWS2Y4eG53ZnVlQ2poT0gyamt6R2JpUjBLTmNR?=
 =?utf-8?B?Z2lJcjJmeXBPQnJRSUVEbzhiZDdsUHVGOHRmc2Y0ZjkwV3ZQVW1NSWZWYXIz?=
 =?utf-8?B?QVQwbHcybUVnNDNsY0FkUFowRXdBbThENS9ncFpKMDRGR3pZeGpmQkprTnlp?=
 =?utf-8?B?YmVEcGhQQ0FIQXhwS043eWJGZ3ZjcnA5NnpSVHFsUGZXNHpGdEVPdERkd1ly?=
 =?utf-8?B?OHZubTRWYm9HNy93MWNvNU82WGdNT2xCcEEyb0ZNQ2tEMXBkZi9JS3JNMHlk?=
 =?utf-8?B?c0VnRXNVcUxiNTRlbWJpalA1bkhaUGx0L1I1ZHEvMXFEMG5PQUt2QjJXd01p?=
 =?utf-8?B?aGNTMzgwUDZHdGd0WDBnMG9FVEd4ZXQwZUp1M3MrN2pNWFc1UzRMMDRIWW5a?=
 =?utf-8?B?ZXRaYUYvSnV0TUFzcWxpLzFNc285QjJPa21QMnEyeXRrSmhhZ3F6WUkySTh5?=
 =?utf-8?B?SCthTWVXZS9LeENLOEZpWXhwSlFtNk5nNzlEV1RwVy81VkNsbFU5dmZIM3ls?=
 =?utf-8?B?UWpCZ2ovZGtSU1JHcEdHU05iRmQyMGZYb2g0RURvVTM0ZjNzYmV4eGdmaTNr?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA5FC05A92184E4D9067398C3C2446FC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?L1Jua0FEeUdERmRiQ2ExNy9KR3hWUXp2QzJ0dGRuYkpENk56WEwyMmppWVFh?=
 =?utf-8?B?WGhDWEppaUJZTGJTeUluTjNXaTBSbHgxV3VtMHFQMkpua25kRGU2dTY1RmFn?=
 =?utf-8?B?N011NEY3OWxoS1dUYnJZTjB2R0NueGt4ekpsUFBPSW9McnA3QmVFUXk3dTFH?=
 =?utf-8?B?R2hRenViSlVUcVkrYmV2TDdDZFZmS0cxZUc0aHdoK0s3QjEwZ3pVUHlTbDVh?=
 =?utf-8?B?QU1KOXdxN2NtWmR6ZG52Z1J5MERTL21Mc1B2ZE14OGJodzZGMDJiMVpvR1hJ?=
 =?utf-8?B?Z1JZNFpFN1JYMWpDMjFrVEZ6TXIwNGJoSnZwTVVnU0t0VVNsNXJlblBzSm9u?=
 =?utf-8?B?SWY0Nm5JMGUzL0dsRWpBaHA4R2J4Rmg2WWVaMVVLNzR6R3VtVXV0T3lpRC91?=
 =?utf-8?B?SyswUC95WDhGZVcveTRKTllYcFdzTHE0YXBYbXBhYXIwdm9YYzh4Z1ZiOU9H?=
 =?utf-8?B?amZuaitaKy96STYyK1k5MnRtN3Jna3hDSUJJREN3UjE5MzRRaHNpcWNGMDJU?=
 =?utf-8?B?bEF6MEcyUXV1YWdWWTltMzdBQW5BVVJxWmtBMEFNQVl0U1BUckg2RG5taVJL?=
 =?utf-8?B?ZlJodkI4R0RXcDNrR0RWS3dnMzhTRVRXOThtSC9ucDRrL0g3MVNmbmxrOEVp?=
 =?utf-8?B?TjU0ZFVHRHRlTW82dE5WcjgwVW5ERVdjbEx6SW1qekZacjBCYUsrczJ6Vlhx?=
 =?utf-8?B?RmsxM2ptV2x3elpmcUxFK0pYWmVlWHpsa1g2K2hnWFdzbXpSdVUzQTF5YWVE?=
 =?utf-8?B?TzJNYkZYTUNUTk1XYzFobGUzZjZjVDd0Q2tLYzcwNXdrS0tVR0p6cVlJb3pH?=
 =?utf-8?B?eEt5Y3ZMU3lGdVY2RFdDNm40MlVCU3B2VFI2V2U2ZSt3d3VVYzhHdWc4Z0t2?=
 =?utf-8?B?RkloV3pKZkx5b0MvaDRUZlBUWmw4LytvdWMyeVVBVzcxZDZ5V0RCTTdHMzVj?=
 =?utf-8?B?MkJlL2lvY1BFUGpNQnJBQzRmN2c5UkllMlV0YkJLSld6ZzJjdmswZ2FIZ29j?=
 =?utf-8?B?R3Z3c2ZKYjRYNEg4L096MEhCWTVTaGFPbEs1dG5tNDhzT2VmQ08xQVdDWVdN?=
 =?utf-8?B?UGtYdHpZSTdmSWlYOU8yb3RBQXlDbkg4cEdKZFF2VzFHNkpWYiszckRXQVov?=
 =?utf-8?B?R1NkVFcyOERFa0M3SUZ2WlFtREpGSlFRRzF1SE42UHVCK2xOWXFVY21xT1FK?=
 =?utf-8?B?M0pMOGc5RjZQTVlJRTBqTFVmQ25WdnpIZnc0ZC90VDZLRzVVMGh0SWxxR0c4?=
 =?utf-8?B?ZHRoYnBFNjNEblY1Z2h1bGFKM3hIVkxhZEJJTzkxdkF2b2g5cnZRelZSdFhO?=
 =?utf-8?Q?5dduRaalCY5+wBQqGG5kkEjIPzgBWXZqkd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4d7d7d-9e59-4b7e-5262-08dbcf48125d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 19:34:25.5178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4gkAMngqdaHXb8NiXBMKg+DUjV9la/2zKOLzPNdUWwXkIqKkmO/8ULZu1OwwVkNsts59cVzivClDgisZgyjV9W1O/ZOpvVauVLKg6hvATAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6413
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170166
X-Proofpoint-GUID: VUHrVXQXIsrh28HOwZ1DOHawENvB-5CO
X-Proofpoint-ORIG-GUID: VUHrVXQXIsrh28HOwZ1DOHawENvB-5CO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDE3LCAyMDIzLCBhdCAxMjo1MSBQTSwgUGF1bCBNb29yZSA8cGF1bEBwYXVs
LW1vb3JlLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIE9jdCAxNywgMjAyMyBhdCAxOjU54oCv
UE0gTWltaSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4gd3JvdGU6DQo+PiBPbiBUdWUsIDIw
MjMtMTAtMTcgYXQgMTM6MjkgLTA0MDAsIFBhdWwgTW9vcmUgd3JvdGU6DQo+Pj4gT24gVHVlLCBP
Y3QgMTcsIDIwMjMgYXQgMTowOeKAr1BNIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+
IHdyb3RlOg0KPj4+PiBPbiBUdWUsIDIwMjMtMTAtMTcgYXQgMTE6NDUgLTA0MDAsIFBhdWwgTW9v
cmUgd3JvdGU6DQo+Pj4+PiBPbiBUdWUsIE9jdCAxNywgMjAyMyBhdCA5OjQ44oCvQU0gTWltaSBa
b2hhciA8em9oYXJAbGludXguaWJtLmNvbT4gd3JvdGU6DQo+Pj4+Pj4gT24gVGh1LCAyMDIzLTEw
LTA1IGF0IDEyOjMyICswMjAwLCBNaWNrYcOrbCBTYWxhw7xuIHdyb3RlOg0KPj4+Pj4+Pj4+PiBB
IGNvbXBsZW1lbnRhcnkgYXBwcm9hY2ggd291bGQgYmUgdG8gY3JlYXRlIGFuDQo+Pj4+Pj4+Pj4+
IExTTSAob3IgYSBkZWRpY2F0ZWQgaW50ZXJmYWNlKSB0byB0aWUgY2VydGlmaWNhdGUgcHJvcGVy
dGllcyB0byBhIHNldCBvZg0KPj4+Pj4+Pj4+PiBrZXJuZWwgdXNhZ2VzLCB3aGlsZSBzdGlsbCBs
ZXR0aW5nIHVzZXJzIGNvbmZpZ3VyZSB0aGVzZSBjb25zdHJhaW50cy4NCj4+Pj4+Pj4+PiANCj4+
Pj4+Pj4+PiBUaGF0IGlzIGFuIGludGVyZXN0aW5nIGlkZWEuICBXb3VsZCB0aGUgb3RoZXIgc2Vj
dXJpdHkgbWFpbnRhaW5lcnMgYmUgaW4NCj4+Pj4+Pj4+PiBzdXBwb3J0IG9mIHN1Y2ggYW4gYXBw
cm9hY2g/ICBXb3VsZCBhIExTTSBiZSB0aGUgY29ycmVjdCBpbnRlcmZhY2U/DQo+Pj4+Pj4+Pj4g
U29tZSBvZiB0aGUgcmVjZW50IHdvcmsgSSBoYXZlIGRvbmUgd2l0aCBpbnRyb2R1Y2luZyBrZXkg
dXNhZ2UgYW5kIENBDQo+Pj4+Pj4+Pj4gZW5mb3JjZW1lbnQgaXMgZGlmZmljdWx0IGZvciBhIGRp
c3RybyB0byBwaWNrIHVwLCBzaW5jZSB0aGVzZSBjaGFuZ2VzIGNhbiBiZQ0KPj4+Pj4+Pj4+IHZp
ZXdlZCBhcyBhIHJlZ3Jlc3Npb24uICBFYWNoIGVuZC11c2VyIGhhcyBkaWZmZXJlbnQgc2lnbmlu
ZyBwcm9jZWR1cmVzDQo+Pj4+Pj4+Pj4gYW5kIHBvbGljaWVzLCBzbyBtYWtpbmcgc29tZXRoaW5n
IHdvcmsgZm9yIGV2ZXJ5b25lIGlzIGRpZmZpY3VsdC4gIExldHRpbmcgdGhlDQo+Pj4+Pj4+Pj4g
dXNlciBjb25maWd1cmUgdGhlc2UgY29uc3RyYWludHMgd291bGQgc29sdmUgdGhpcyBwcm9ibGVt
Lg0KPj4+Pj4+IA0KPj4+Pj4+IFNvbWV0aGluZyBkZWZpbml0ZWx5IG5lZWRzIHRvIGJlIGRvbmUg
YWJvdXQgY29udHJvbGxpbmcgdGhlIHVzYWdlIG9mDQo+Pj4+Pj4geDUwOSBjZXJ0aWZpY2F0ZXMu
ICBNeSBjb25jZXJuIGlzIHRoZSBsZXZlbCBvZiBncmFudWxhcml0eS4gIFdvdWxkIHRoaXMNCj4+
Pj4+PiBiZSBhdCB0aGUgTFNNIGhvb2sgbGV2ZWwgb3IgZXZlbiBmaW5lciBncmFuYXVsYXJpdHk/
DQo+Pj4+PiANCj4+Pj4+IFlvdSBsb3N0IG1lLCB3aGF0IGRvIHlvdSBtZWFuIGJ5IGZpbmVyIGdy
YW51bGFyaXR5IHRoYW4gYSBMU00tYmFzZWQNCj4+Pj4+IGFjY2VzcyBjb250cm9sPyAgQ2FuIHlv
dSBnaXZlIGFuIGV4aXN0aW5nIGV4YW1wbGUgaW4gdGhlIExpbnV4IGtlcm5lbA0KPj4+Pj4gb2Yg
YWNjZXNzIGNvbnRyb2wgZ3JhbnVsYXJpdHkgdGhhdCBpcyBmaW5lciBncmFpbmVkIHRoYW4gd2hh
dCBpcw0KPj4+Pj4gcHJvdmlkZWQgYnkgdGhlIExTTXM/DQo+Pj4+IA0KPj4+PiBUaGUgY3VycmVu
dCB4NTA5IGNlcnRpZmljYXRlIGFjY2VzcyBjb250cm9sIGdyYW51bGFyaXR5IGlzIGF0IHRoZQ0K
Pj4+PiBrZXlyaW5nIGxldmVsLiAgQW55IGtleSBvbiB0aGUga2V5cmluZyBtYXkgYmUgdXNlZCB0
byB2ZXJpZnkgYQ0KPj4+PiBzaWduYXR1cmUuICBGaW5lciBncmFudWxhcml0eSBjb3VsZCBhc3Nv
Y2lhdGUgYSBzZXQgb2YgY2VydGlmaWNhdGVzIG9uDQo+Pj4+IGEgcGFydGljdWxhciBrZXlyaW5n
IHdpdGggYW4gTFNNIGhvb2sgLSBrZXJuZWwgbW9kdWxlcywgQlBSTSwga2V4ZWMsDQo+Pj4+IGZp
cm13YXJlLCBldGMuICBFdmVuIGZpbmVyIGdyYW51bGFyaXR5IGNvdWxkIHNvbWVob3cgbGltaXQg
YSBrZXkncw0KPj4+PiBzaWduYXR1cmUgdmVyaWZpY2F0aW9uIHRvIGZpbGVzIGluIHBhcnRpY3Vs
YXIgc29mdHdhcmUgcGFja2FnZShzKSBmb3INCj4+Pj4gZXhhbXBsZS4NCj4+Pj4gDQo+Pj4+IFBl
cmhhcHMgTWlja2HDq2wgYW5kIEVyaWMgd2VyZSB0aGlua2luZyBhYm91dCBhIG5ldyBMU00gdG8g
Y29udHJvbCB1c2FnZQ0KPj4+PiBvZiB4NTA5IGNlcnRpZmljYXRlcyBmcm9tIGEgdG90YWxseSBk
aWZmZXJlbnQgcGVyc3BlY3RpdmUuICBJJ2QgbGlrZSB0bw0KPj4+PiBoZWFyIHdoYXQgdGhleSdy
ZSB0aGlua2luZy4NCj4+Pj4gDQo+Pj4+IEkgaG9wZSB0aGlzIGFkZHJlc3NlZCB5b3VyIHF1ZXN0
aW9ucy4NCj4+PiANCj4+PiBPa2F5LCBzbyB5b3Ugd2VyZSB0YWxraW5nIGFib3V0IGZpbmVyIGdy
YW51bGFyaXR5IHdoZW4gY29tcGFyZWQgdG8gdGhlDQo+Pj4gKmN1cnJlbnQqIExTTSBrZXlyaW5n
IGhvb2tzLiAgR290Y2hhLg0KPj4+IA0KPj4+IElmIHdlIG5lZWQgYWRkaXRpb25hbCwgb3IgbW9k
aWZpZWQsIGhvb2tzIHRoYXQgc2hvdWxkbid0IGJlIGEgcHJvYmxlbS4NCj4+PiBBbHRob3VnaCBJ
J20gZ3Vlc3NpbmcgdGhlIGFuc3dlciBpcyBnb2luZyB0byBiZSBtb3ZpbmcgdG93YXJkcw0KPj4+
IHB1cnBvc2Uvb3BlcmF0aW9uIHNwZWNpZmljIGtleXJpbmdzIHdoaWNoIG1pZ2h0IGZpdCBpbiB3
ZWxsIHdpdGggdGhlDQo+Pj4gY3VycmVudCBrZXlyaW5nIGxldmVsIGNvbnRyb2xzLg0KPj4gDQo+
PiBJIGRvbid0IGJlbGlldmUgZGVmaW5pbmcgcGVyIHB1cnBvc2Uvb3BlcmF0aW9uIHNwZWNpZmlj
IGtleXJpbmdzIHdpbGwNCj4+IHJlc29sdmUgdGhlIHVuZGVybHlpbmcgcHJvYmxlbSBvZiBncmFu
dWxhcml0eS4NCj4gDQo+IFBlcmhhcHMgbm90IGNvbXBsZXRlbHksIGJ1dCBmb3IgaW4ta2VybmVs
IG9wZXJhdGlvbnMgSSBiZWxpZXZlIGl0IGlzDQo+IGFuIGF0dHJhY3RpdmUgaWRlYS4NCg0KQ291
bGQgdGhlIFguNTA5IEV4dGVuZGVkIEtleSBVc2FnZSAoRUtVKSBleHRlbnNpb24gWzFdLCBiZSB1
c2VkIGhlcmU/ICANClZhcmlvdXMgT0lEcyB3b3VsZCBuZWVkIHRvIGJlIGRlZmluZWQgb3IgYXNz
aWduZWQgZm9yIGVhY2ggcHVycG9zZS4gIA0KT25jZSBhc3NpZ25lZCwgdGhlIGtlcm5lbCBjb3Vs
ZCBwYXJzZSB0aGlzIGluZm9ybWF0aW9uIGFuZCBkbyB0aGUNCmVuZm9yY2VtZW50LiAgVGhlbiBh
bGwga2V5cyBjb3VsZCBjb250aW51ZSB0byByZW1haW4gaW4gdGhlIC5idWlsdGluLCANCi5zZWNv
bmRhcnksIGFuZCAubWFjaGluZSBrZXlyaW5ncy4gICBPbmx5IGEgc3Vic2V0IG9mIGVhY2gga2V5
cmluZyANCndvdWxkIGJlIHVzZWQgZm9yIHZlcmlmaWNhdGlvbiBiYXNlZCBvbiB3aGF0IGlzIGNv
bnRhaW5lZCBpbiB0aGUgRUtVLg0KDQoxLiBodHRwczovL3d3dy5yZmMtZWRpdG9yLm9yZy9yZmMv
cmZjNTI4MCNzZWN0aW9uLTQuMi4xLjEyDQoNCg==
