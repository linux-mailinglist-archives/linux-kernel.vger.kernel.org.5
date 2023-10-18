Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1227CEBA2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjJRXNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjJRXNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:13:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8FF111;
        Wed, 18 Oct 2023 16:13:14 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIp3t0022429;
        Wed, 18 Oct 2023 23:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=BNlYj0LLkiZQKj2P/kaUS5k0hDQhhRfuNoLzfXD7nJw=;
 b=N7BVgZfdmAZSwi1pPaE9HExRRR1QgR6bxo6MmEAe7dOqJQL95bqq9NliKME2U6LnFYTM
 bL6dk4pJmILMIuYyFu5ETXbu9d13SlfTyn6zlOrmw1yC+A+3JLwB6zT/r5BxojJuSzo6
 aNgIbiYvmy8qX9Hq6puq1DukzZwyG8kVtj7VdeuEwv//QLpLxRxygi+UT9mQCWJElUWE
 DGdddiCwiu7TmHrrVHEhJFvBCfelJB42VQ6UcT/mtBTUyUxVWIbfhG+up9zVuwA3OGpQ
 /ci6MDVmoKMkI9FWIdEL7xAjm0KxDR5U/tqkC9A9J+gNOTiKOxQP1KHbwKYOxocCZODV tg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk28rv9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 23:12:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39ILxFHr027211;
        Wed, 18 Oct 2023 23:12:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg55y6t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 23:12:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4RXoGhcvZ2/USYC+oK/V1+l4neGK0rmCwRZDy7YtJ+BEIQ9d9HyWiCVRuHGMAx/hJg2FwnCk9viOE3QHr7T1+nrQ9CzGgkkjsgW1CUEw24wdos3tSwOShwPGB8H1ExXdOu4iSLMtftQgR9E+uR0zhhDYOoynLsIFeW3nWbz1vxV8sj8MbSRDIwk0zOpviWVI2dO5OZbWxICKJaIZKAiDQSLjXGXlj8SfpDYhDfZZwRzuNQmIntl69zX5PplqYnYJBouJOJMNCCNLtGq1mXBrvXWtdOmi1CGP4c8hbjhYfQ76xl2iP0du/mP5A3oAT5pcRC3Jeqs8ARcxhB3aas+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNlYj0LLkiZQKj2P/kaUS5k0hDQhhRfuNoLzfXD7nJw=;
 b=XEEmnTcy5jweCeNqfbbMXwQ8C8XHGL8VN9PT/eZ9q8MA4cEk3AI+B09JGOx0COawE7/67JBJ8Ks0q57dF8gpBPU4IxzzO2eJKSy0j7tep5k6Kgvif0H84XgojLQjPikSDt+obfTuOxCXTZ7Y2WSfaGHJEYABjq7KbuEcABYorifXoJ2cHo4uvI1FZinCHlpAgoYvB+gdRzFyve5tlEhZgVwg4DmGbzAa4amW1VNyy5zrPvQQ5Ltrplgg7HDi21Ija5eKOSqPXlj3zVEq1fwCRIRw8vcWFTT8T7/N9369Ez1sQN8n5bDp4yXBNiEL+MJAMPfvrXQ+kUoJioxJLT/Z1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNlYj0LLkiZQKj2P/kaUS5k0hDQhhRfuNoLzfXD7nJw=;
 b=l907SUUAXzUf1SfSOMgAGz46AwT8iwz+z6hDTUe7g6ERnMtX6O751ikOqFxX90jGlLTZcpoyHMHE/CEGkAWrf0ickhd0BeDqUbkNSj9HicYAAFdhPzyJLYxpuTUZTBGS+6S2h9LBEWYVopyR+PWAkERrycQXd2idU39SPa9LofM=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SJ1PR10MB5953.namprd10.prod.outlook.com (2603:10b6:a03:48c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Wed, 18 Oct
 2023 23:12:45 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::134:c770:8cb6:70e]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::134:c770:8cb6:70e%4]) with mapi id 15.20.6863.032; Wed, 18 Oct 2023
 23:12:45 +0000
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
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: RFC: New LSM to control usage of x509 certificates
Thread-Topic: RFC: New LSM to control usage of x509 certificates
Thread-Index: AQHZ93c4gJX6SHkC80mNOExcrBTnXrBOD7yAgAAjSwCAABc5gIAABa6AgAAIMoCAAA68gIAADAcAgAE44ICAAJZxAA==
Date:   Wed, 18 Oct 2023 23:12:45 +0000
Message-ID: <18FC67B7-7966-49B7-8C27-F815F1568781@oracle.com>
References: <D0F16BFD-72EB-4BE2-BA3D-BAE1BCCDCB6F@oracle.com>
 <20230914.shah5al9Kaib@digikod.net> <20231005.dajohf2peiBu@digikod.net>
 <d3b51f26c14fd273d41da3432895fdce9f4d047c.camel@linux.ibm.com>
 <CAHC9VhRdU1CZJpPSEdSmui-Xirr0j261K=+SM7KiDwiPG-JSrQ@mail.gmail.com>
 <a851227aaa75ab16b0d6dd93433e1ee1679715f9.camel@linux.ibm.com>
 <CAHC9VhS_Ttdy5ZB=jYdVfNyaJfn_7G1wztr5+g0g7uUDForXvA@mail.gmail.com>
 <5c795b4cf6d7460af205e85a36194fa188136c38.camel@linux.ibm.com>
 <CAHC9VhTug20M0ET=QojUPtjrGkeHfU=ADDNrKfXmLTQPG_i1vw@mail.gmail.com>
 <2512D2AE-4ACA-41B9-B9FB-C2B4802B9A10@oracle.com>
 <20231018.heiju2Shexai@digikod.net>
In-Reply-To: <20231018.heiju2Shexai@digikod.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|SJ1PR10MB5953:EE_
x-ms-office365-filtering-correlation-id: 477db33c-9d80-4c42-3c0a-08dbd02fbcbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gc44Uazh/+NPE7f6VFBvk/J1H61MEth3sx828PLAOkGgZ35cJ8nUqnA0RC2jCoDp9mQpLO3bKZO5j6QkqvSxdPyGvoUb0SaJCEOs/WdY/lVA4Y8PY+m9Y3QZUmmEDhpPIcfYf0e4+d1U+vnyCs5N0iecMCspTRhY8ueTHf7JbXJ9jYbcRgWVqlNJFTCQeM97yipKW2s/yH73d5796KqzQcSBnff0KxMaJosiL/+3G8ZIhylUSfg6qmSn/nV5c5PiZ3AJgYwKyf1/i9Ia7v3eMBu0xm3BTWsBAdj3KmOnmqnLrWrbLq/AA8yct8ws0p7yelUusJ3D7OZzIiuLttHwnunCfGvLSLFT3f7RZQ8y3d2YtdtxfJZ/Qppd+EJRwMO14aaiftUdWG8wFUuKXM6vo9pDcglQamlzTD957rwiXSsFqSMzeZi9/WFvM+q6uzaEPasMTFK5YM9bsfLfgFp8gk8JFYKoaX0DNqSiiolKEn0Yjc20Oj8q91eBiXvTP0Ni/jHWsyW95RFTjj+/moIZZUgGLFTBcQT7BYB2mgY78lhlWGkmxIEyHBjFV0O0NORNtaALhe6h9VuCI99lNR4Geg5o1HvYyyKXU92co97q063xVwv56wlkRoVEm7qivhOJ8mbbsLFvi4pNbHLmg+Luhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(966005)(6486002)(316002)(2616005)(76116006)(33656002)(91956017)(6916009)(44832011)(478600001)(2906002)(66574015)(54906003)(6506007)(66476007)(66556008)(66946007)(64756008)(66446008)(5660300002)(4326008)(8676002)(26005)(4001150100001)(7416002)(71200400001)(41300700001)(8936002)(86362001)(6512007)(36756003)(38100700002)(83380400001)(38070700005)(122000001)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YU42ZUw2UDdNUVRzeUhkVDFGakp5Uk9LZmRNdXRYVDE0Z1hSTG1kTmw3MUEv?=
 =?utf-8?B?N2E3MzlGbi9TZXYxT3d6SlQwTURGU0tmNlJ0dW9yY3FCVmhjWU1yVUd3UEhN?=
 =?utf-8?B?Y3BJdDdQajZtZzlET1pySXdmYlBvOU1kbWdPejJpT3g3ZXpFVHhZQ21SbjNY?=
 =?utf-8?B?WTYyL1IyWjZXYmtveFpKODJiekptK3BKYXZBSkUwRlZUeHplbmVxQnVLd3hT?=
 =?utf-8?B?ZjRvRFVUUHpWOGdWZlphRERzdXlYZVdJZU14UjhxcWZabVJSbjhDMUJ6akMw?=
 =?utf-8?B?VkZvci9yVnYxVzlxazF0UkJ5a051QUN4MkE5Z1pTTk5uM2RIWVd4SjdZb1kr?=
 =?utf-8?B?cExBT3JhREQvbXFld2x5WEtScUxrcjlSb0JmLzRldCtFSk1ERFhJaElBTnM3?=
 =?utf-8?B?L0NkN3Qva1V3dU1HUE0yb0c4T1hSMU9yS3RlbmwyaDVMdzFrTVNzeHI4SjBq?=
 =?utf-8?B?eDBYR0ZzRDJnR2V5QmlybzlzcEMwNXFmTElUU3oyeWJrSlhvQzhtVUdGVzlw?=
 =?utf-8?B?aXlTNEFaaDVta2tuRForQjFoMWNCeVd6by8xYjVjKzhRWWhDc3FSZ2RreWNj?=
 =?utf-8?B?RnZHUkh1UThMTytpYmVnM29RTDlTWUJGcXR6aGdiMlFqN2ROSzJTbDRWS1Nh?=
 =?utf-8?B?TmpkdFVrL1Z3NW04bU0wb1dMYlNTbzBBUjRGM2ljNmZaSXdmOXJmSndNUVhR?=
 =?utf-8?B?MTI5VTdRUm1wNlVmSGFjK2M4bFQzRDJOZVVrVDNCWmFQMFh3M1dlNDhUV1VC?=
 =?utf-8?B?L1U2RGUraWlGazVHc3hGZk9QNS9SL1JXMVd4Z3FiaHVLT3p5R25Ec21DZFJJ?=
 =?utf-8?B?Ni9yQitsU1RpbklTUmtKUDdZOVpwT2prTUc2WWtYRyszVXVRZERVZlVWenhF?=
 =?utf-8?B?NFVHZ09CSlNCQkpDeGFZaHFCL2o3ZFoxY1dubmpFNVUraGp1TStTTStvV3Ro?=
 =?utf-8?B?cHprdWFic3ZkblYzdEZJd29lUm5CSVlWeWtOajcvbFloSE9pK1MrTHRubHg5?=
 =?utf-8?B?bFBNZ1VqYzkza0xlQjkrVEUvbGNIdEg2bThraGU3dm5SSFlKZ3ZpckpFUHIw?=
 =?utf-8?B?L3RkcjJIbkU5ZlF0NmdxZlZpWGVDQ1FZdC91UWlaQXNKZkR3bkpsRlE0RlN5?=
 =?utf-8?B?dm5VWjJxS2IvVFlndWRqTmVNcGdEUEZFWlF4UHVxcVNkSVNoMDF0a01MNWhP?=
 =?utf-8?B?QXBkSmRnSW5CMS9lZFYwbnFhMlFiSzRaZ21zZ3RPM2dqSXhmeG8yc2d6VFZm?=
 =?utf-8?B?YWlua3ZGWXEyWFhGUFFLSG9vQm9NRFJjb05iWVhvMlBmWG1ubXo2ZmdUSXJa?=
 =?utf-8?B?QkdHelljNUM0Y041aTRLSU9mQ0NBZ25qakdNUFVtQjk2eFlFTEFWZnVPeTVY?=
 =?utf-8?B?Y21LRi91TVJodERtcW9NaVJtMyt1emV2cnpJUmk2U0RDZWN4VjVBYzQxTTdT?=
 =?utf-8?B?VCtlZ0xURm14N3ZKU1VkbjArN0lKMjNKWWFTc1AyWXo3SUc5UE5rQmt5T0tv?=
 =?utf-8?B?UHV5V3QyWXVRYUZvUWszNzg3ZTFRaHJnakU2YkpkS2hVbWtUdTBZdUZBUDh1?=
 =?utf-8?B?OFp6NlNrYjlNaDNnMWtpSEpsRlF0UnpiUGcwM1dZc1UxUFRjMVVGcVFBNTZz?=
 =?utf-8?B?cmNIQXFhNXZvWlorVmJOQWpLOWVwb3VaYkgwSXRlQXVtOGoySmkxclk3cHBo?=
 =?utf-8?B?b21yUWZVTUxKbWNML202cnVVWWtTK2lwTTUveGxXdlF5RFowNjM4bkVZbnNo?=
 =?utf-8?B?Z09mdjRxdlorVzlVanc3RUdjdVc0Uzl5TkVlWEttV2dsaHpDdkRSaGJJazV0?=
 =?utf-8?B?R3lTUGI0aWZGVkszM0Z5Q0JLdDljejRBR3ZBam45V0g3WGU2R1Z3cFBqRWhN?=
 =?utf-8?B?V3VWRkFyYVRkNDZncU4wLzczYS9kZWVMcnhKcGtoQ20yWlZUQlZYRWhWUU5m?=
 =?utf-8?B?bndNM29iUzVlVW1QamU4UU9oQW5BK1BsWGVEZTgyYlBQWkdtTVFJSitpeEh0?=
 =?utf-8?B?SzJZNldkc0FSRHdzQm5lK2FoOFQyamhBSDlyazVWc2swY1JvbVZKT0xCRElW?=
 =?utf-8?B?ZEdvajRnMUMzMEJTMEpYWmY1Rzl6TGdaOFMrUENJWDkzSEN3bnFtcHNTUUND?=
 =?utf-8?B?UWxtWVlDcGIzWnVNSTJRV2hCQzUyeTF3M2tPaWFiYkN5cjZwWG9Eam9BWXRy?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05B27854D35627438E9017331491CF70@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WlF3dlYwR3IrQzE3VjFIN2ZOMGVyQmJIWlIwMHV5ZUdVVUNxVUZ2QzBHU2Vs?=
 =?utf-8?B?ZHIySmJ1ZWpZNTFVMzhndzVsVDc2QkJINjc2Y09CNHBFbXJWS0ZRaU9EN05I?=
 =?utf-8?B?SGRXNStOdXpSQ1pGSzhwNDllWW5TL3lON3VTREVsMy94STV0WXZ6NXMvdWE1?=
 =?utf-8?B?ZldpZ1RmcXJjbVlIN0pCRDRrOEhHSDFVR3hJRmpOdnE1dHZ5aWc4QVdtNkhv?=
 =?utf-8?B?cFh0VDVBdk5va1RHYVppNkNqQ0lFWk5PYXRyQ2tNcUIzUm9oN2JrZWdJRGxy?=
 =?utf-8?B?ckIzbVVCMHFIUUxVdUdLUnZQSG5RMGlpWHdVblZVcU5USWtVd1JqSEtTRkt2?=
 =?utf-8?B?UDIxa25iR3RFYWtIR1Z6N3hkVkFTQVdOT1RpSHl2UitJZ2I1SnBCR3FPNmxj?=
 =?utf-8?B?TzNSMnVuNlVlN1R2NURWdy9XaVhmOW1VM1lRdGVkWnJXM2JlR0V3QWFFbDhJ?=
 =?utf-8?B?c1FJU3l6d3laTTlNaVhLeEI0VExvbmc4dFE0aVY2cXVtbzNjc21veThkOU9r?=
 =?utf-8?B?cldsZlQ3WnhnelBLSnBUVVdVdU81WE8rUGtxK3JaMTRJQ2hBeitYdHV6VTZR?=
 =?utf-8?B?N0NCSFEzM21rNmhkYkkzZEYyRVA3dk0weUtOSTR5SE54TldCelgxanZNQWNi?=
 =?utf-8?B?NjhzeWhHUFNPeU9KT1M0YWxieDB0VzZBR3VaTHpua2dOZjlsU3B4RkFCT2oz?=
 =?utf-8?B?UGIxT2ExUjArQW5xRzROazZKZkJjcUpFbHRoUGxLN1hQOWJzWVhUMFIyL0lP?=
 =?utf-8?B?RmFDVGhlQjJOTGZiYXI4S2JwRnJzTmNmdmE4c090OHpXZW5vNWt5NG1SWkdw?=
 =?utf-8?B?K29sT2M4Y2IyOUI3d3RHajRZVG1RUUFuTlRtNXZQWFI5T0dVQkFuK0VvTkFH?=
 =?utf-8?B?MVcvcTVOZXZzcWRQaUhFRnhwd0huaUJxMVhyOUhORWtrWFB6c0xXNHc2Rm1R?=
 =?utf-8?B?MFZBWVFRRTgrQytPYlVpQy81S3FmOEZzM3RxSVFZdHRXSWZoRy9KYTZ6VHBG?=
 =?utf-8?B?dXFmZmlCMnlnWnFNUTQxcGpSU0ljcmQxR1BkTDVhdllUK2pRbkNSVWtNMWsw?=
 =?utf-8?B?dGhWU3I4djFzeHlpV2ZFZGtQWUtmYjRBcW1ZWjV4QkNiWU56UzE3Y2tQQTNw?=
 =?utf-8?B?ODdoV1dLMHY5N3QxSUd5dE15ZjVkNGtjY3FqYXNMK2xqa0RJNHAzRWpVbUNV?=
 =?utf-8?B?NGNDZ0w4b1duNjVOQng2QmNuMUVOY0l4M0tDZXZvcEp6UUs4RW1VUXlGcnFS?=
 =?utf-8?B?aDRiMVBmZ2YwRGVDOEtmTVFKbU5uRFRSUkFJNVdaT0JBcEVvMkR3MmNybkNm?=
 =?utf-8?Q?vcQJtCa76IhnKNn/2hCQUWHSiGxPLSC2Ta?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477db33c-9d80-4c42-3c0a-08dbd02fbcbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 23:12:45.1086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yBq6XGNdkshzQuZrFLuj6Q8Mw94eeWtrhnOAUhWqgnXUK1LAgPR08BolelEXCVFzNq461e5RYHRM3TSMH1BNEe1niVGaQ+tTqnFJPBjpuKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5953
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180191
X-Proofpoint-ORIG-GUID: mK-r85_iWtB_fuJve4Ps7gbiFH0TvV-8
X-Proofpoint-GUID: mK-r85_iWtB_fuJve4Ps7gbiFH0TvV-8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDE4LCAyMDIzLCBhdCA4OjE0IEFNLCBNaWNrYcOrbCBTYWxhw7xuIDxtaWNA
ZGlnaWtvZC5uZXQ+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBPY3QgMTcsIDIwMjMgYXQgMDc6MzQ6
MjVQTSArMDAwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gT2N0IDE3
LCAyMDIzLCBhdCAxMjo1MSBQTSwgUGF1bCBNb29yZSA8cGF1bEBwYXVsLW1vb3JlLmNvbT4gd3Jv
dGU6DQo+Pj4gDQo+Pj4gT24gVHVlLCBPY3QgMTcsIDIwMjMgYXQgMTo1OeKAr1BNIE1pbWkgWm9o
YXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPj4+PiBPbiBUdWUsIDIwMjMtMTAtMTcg
YXQgMTM6MjkgLTA0MDAsIFBhdWwgTW9vcmUgd3JvdGU6DQo+Pj4+PiBPbiBUdWUsIE9jdCAxNywg
MjAyMyBhdCAxOjA54oCvUE0gTWltaSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4gd3JvdGU6
DQo+Pj4+Pj4gT24gVHVlLCAyMDIzLTEwLTE3IGF0IDExOjQ1IC0wNDAwLCBQYXVsIE1vb3JlIHdy
b3RlOg0KPj4+Pj4+PiBPbiBUdWUsIE9jdCAxNywgMjAyMyBhdCA5OjQ44oCvQU0gTWltaSBab2hh
ciA8em9oYXJAbGludXguaWJtLmNvbT4gd3JvdGU6DQo+Pj4+Pj4+PiBPbiBUaHUsIDIwMjMtMTAt
MDUgYXQgMTI6MzIgKzAyMDAsIE1pY2thw6tsIFNhbGHDvG4gd3JvdGU6DQo+Pj4+Pj4+Pj4+Pj4g
QSBjb21wbGVtZW50YXJ5IGFwcHJvYWNoIHdvdWxkIGJlIHRvIGNyZWF0ZSBhbg0KPj4+Pj4+Pj4+
Pj4+IExTTSAob3IgYSBkZWRpY2F0ZWQgaW50ZXJmYWNlKSB0byB0aWUgY2VydGlmaWNhdGUgcHJv
cGVydGllcyB0byBhIHNldCBvZg0KPj4+Pj4+Pj4+Pj4+IGtlcm5lbCB1c2FnZXMsIHdoaWxlIHN0
aWxsIGxldHRpbmcgdXNlcnMgY29uZmlndXJlIHRoZXNlIGNvbnN0cmFpbnRzLg0KPj4+Pj4+Pj4+
Pj4gDQo+Pj4+Pj4+Pj4+PiBUaGF0IGlzIGFuIGludGVyZXN0aW5nIGlkZWEuICBXb3VsZCB0aGUg
b3RoZXIgc2VjdXJpdHkgbWFpbnRhaW5lcnMgYmUgaW4NCj4+Pj4+Pj4+Pj4+IHN1cHBvcnQgb2Yg
c3VjaCBhbiBhcHByb2FjaD8gIFdvdWxkIGEgTFNNIGJlIHRoZSBjb3JyZWN0IGludGVyZmFjZT8N
Cj4+Pj4+Pj4+Pj4+IFNvbWUgb2YgdGhlIHJlY2VudCB3b3JrIEkgaGF2ZSBkb25lIHdpdGggaW50
cm9kdWNpbmcga2V5IHVzYWdlIGFuZCBDQQ0KPj4+Pj4+Pj4+Pj4gZW5mb3JjZW1lbnQgaXMgZGlm
ZmljdWx0IGZvciBhIGRpc3RybyB0byBwaWNrIHVwLCBzaW5jZSB0aGVzZSBjaGFuZ2VzIGNhbiBi
ZQ0KPj4+Pj4+Pj4+Pj4gdmlld2VkIGFzIGEgcmVncmVzc2lvbi4gIEVhY2ggZW5kLXVzZXIgaGFz
IGRpZmZlcmVudCBzaWduaW5nIHByb2NlZHVyZXMNCj4+Pj4+Pj4+Pj4+IGFuZCBwb2xpY2llcywg
c28gbWFraW5nIHNvbWV0aGluZyB3b3JrIGZvciBldmVyeW9uZSBpcyBkaWZmaWN1bHQuICBMZXR0
aW5nIHRoZQ0KPj4+Pj4+Pj4+Pj4gdXNlciBjb25maWd1cmUgdGhlc2UgY29uc3RyYWludHMgd291
bGQgc29sdmUgdGhpcyBwcm9ibGVtLg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBTb21ldGhpbmcgZGVm
aW5pdGVseSBuZWVkcyB0byBiZSBkb25lIGFib3V0IGNvbnRyb2xsaW5nIHRoZSB1c2FnZSBvZg0K
Pj4+Pj4+Pj4geDUwOSBjZXJ0aWZpY2F0ZXMuICBNeSBjb25jZXJuIGlzIHRoZSBsZXZlbCBvZiBn
cmFudWxhcml0eS4gIFdvdWxkIHRoaXMNCj4+Pj4+Pj4+IGJlIGF0IHRoZSBMU00gaG9vayBsZXZl
bCBvciBldmVuIGZpbmVyIGdyYW5hdWxhcml0eT8NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IFlvdSBsb3N0
IG1lLCB3aGF0IGRvIHlvdSBtZWFuIGJ5IGZpbmVyIGdyYW51bGFyaXR5IHRoYW4gYSBMU00tYmFz
ZWQNCj4+Pj4+Pj4gYWNjZXNzIGNvbnRyb2w/ICBDYW4geW91IGdpdmUgYW4gZXhpc3RpbmcgZXhh
bXBsZSBpbiB0aGUgTGludXgga2VybmVsDQo+Pj4+Pj4+IG9mIGFjY2VzcyBjb250cm9sIGdyYW51
bGFyaXR5IHRoYXQgaXMgZmluZXIgZ3JhaW5lZCB0aGFuIHdoYXQgaXMNCj4+Pj4+Pj4gcHJvdmlk
ZWQgYnkgdGhlIExTTXM/DQo+Pj4+Pj4gDQo+Pj4+Pj4gVGhlIGN1cnJlbnQgeDUwOSBjZXJ0aWZp
Y2F0ZSBhY2Nlc3MgY29udHJvbCBncmFudWxhcml0eSBpcyBhdCB0aGUNCj4+Pj4+PiBrZXlyaW5n
IGxldmVsLiAgQW55IGtleSBvbiB0aGUga2V5cmluZyBtYXkgYmUgdXNlZCB0byB2ZXJpZnkgYQ0K
Pj4+Pj4+IHNpZ25hdHVyZS4gIEZpbmVyIGdyYW51bGFyaXR5IGNvdWxkIGFzc29jaWF0ZSBhIHNl
dCBvZiBjZXJ0aWZpY2F0ZXMgb24NCj4+Pj4+PiBhIHBhcnRpY3VsYXIga2V5cmluZyB3aXRoIGFu
IExTTSBob29rIC0ga2VybmVsIG1vZHVsZXMsIEJQUk0sIGtleGVjLA0KPj4+Pj4+IGZpcm13YXJl
LCBldGMuICBFdmVuIGZpbmVyIGdyYW51bGFyaXR5IGNvdWxkIHNvbWVob3cgbGltaXQgYSBrZXkn
cw0KPj4+Pj4+IHNpZ25hdHVyZSB2ZXJpZmljYXRpb24gdG8gZmlsZXMgaW4gcGFydGljdWxhciBz
b2Z0d2FyZSBwYWNrYWdlKHMpIGZvcg0KPj4+Pj4+IGV4YW1wbGUuDQo+Pj4+Pj4gDQo+Pj4+Pj4g
UGVyaGFwcyBNaWNrYcOrbCBhbmQgRXJpYyB3ZXJlIHRoaW5raW5nIGFib3V0IGEgbmV3IExTTSB0
byBjb250cm9sIHVzYWdlDQo+Pj4+Pj4gb2YgeDUwOSBjZXJ0aWZpY2F0ZXMgZnJvbSBhIHRvdGFs
bHkgZGlmZmVyZW50IHBlcnNwZWN0aXZlLiAgSSdkIGxpa2UgdG8NCj4+Pj4+PiBoZWFyIHdoYXQg
dGhleSdyZSB0aGlua2luZy4NCj4+Pj4+PiANCj4+Pj4+PiBJIGhvcGUgdGhpcyBhZGRyZXNzZWQg
eW91ciBxdWVzdGlvbnMuDQo+Pj4+PiANCj4+Pj4+IE9rYXksIHNvIHlvdSB3ZXJlIHRhbGtpbmcg
YWJvdXQgZmluZXIgZ3JhbnVsYXJpdHkgd2hlbiBjb21wYXJlZCB0byB0aGUNCj4+Pj4+ICpjdXJy
ZW50KiBMU00ga2V5cmluZyBob29rcy4gIEdvdGNoYS4NCj4+Pj4+IA0KPj4+Pj4gSWYgd2UgbmVl
ZCBhZGRpdGlvbmFsLCBvciBtb2RpZmllZCwgaG9va3MgdGhhdCBzaG91bGRuJ3QgYmUgYSBwcm9i
bGVtLg0KPj4+Pj4gQWx0aG91Z2ggSSdtIGd1ZXNzaW5nIHRoZSBhbnN3ZXIgaXMgZ29pbmcgdG8g
YmUgbW92aW5nIHRvd2FyZHMNCj4+Pj4+IHB1cnBvc2Uvb3BlcmF0aW9uIHNwZWNpZmljIGtleXJp
bmdzIHdoaWNoIG1pZ2h0IGZpdCBpbiB3ZWxsIHdpdGggdGhlDQo+Pj4+PiBjdXJyZW50IGtleXJp
bmcgbGV2ZWwgY29udHJvbHMuDQo+Pj4+IA0KPj4+PiBJIGRvbid0IGJlbGlldmUgZGVmaW5pbmcg
cGVyIHB1cnBvc2Uvb3BlcmF0aW9uIHNwZWNpZmljIGtleXJpbmdzIHdpbGwNCj4+Pj4gcmVzb2x2
ZSB0aGUgdW5kZXJseWluZyBwcm9ibGVtIG9mIGdyYW51bGFyaXR5Lg0KPj4+IA0KPj4+IFBlcmhh
cHMgbm90IGNvbXBsZXRlbHksIGJ1dCBmb3IgaW4ta2VybmVsIG9wZXJhdGlvbnMgSSBiZWxpZXZl
IGl0IGlzDQo+Pj4gYW4gYXR0cmFjdGl2ZSBpZGVhLg0KPj4gDQo+PiBDb3VsZCB0aGUgWC41MDkg
RXh0ZW5kZWQgS2V5IFVzYWdlIChFS1UpIGV4dGVuc2lvbiBbMV0sIGJlIHVzZWQgaGVyZT8gIA0K
Pj4gVmFyaW91cyBPSURzIHdvdWxkIG5lZWQgdG8gYmUgZGVmaW5lZCBvciBhc3NpZ25lZCBmb3Ig
ZWFjaCBwdXJwb3NlLiAgDQo+PiBPbmNlIGFzc2lnbmVkLCB0aGUga2VybmVsIGNvdWxkIHBhcnNl
IHRoaXMgaW5mb3JtYXRpb24gYW5kIGRvIHRoZQ0KPj4gZW5mb3JjZW1lbnQuICBUaGVuIGFsbCBr
ZXlzIGNvdWxkIGNvbnRpbnVlIHRvIHJlbWFpbiBpbiB0aGUgLmJ1aWx0aW4sIA0KPj4gLnNlY29u
ZGFyeSwgYW5kIC5tYWNoaW5lIGtleXJpbmdzLiAgIE9ubHkgYSBzdWJzZXQgb2YgZWFjaCBrZXly
aW5nIA0KPj4gd291bGQgYmUgdXNlZCBmb3IgdmVyaWZpY2F0aW9uIGJhc2VkIG9uIHdoYXQgaXMg
Y29udGFpbmVkIGluIHRoZSBFS1UuDQo+PiANCj4+IDEuIGh0dHBzOi8vd3d3LnJmYy1lZGl0b3Iu
b3JnL3JmYy9yZmM1MjgwI3NlY3Rpb24tNC4yLjEuMTINCj4gDQo+IEkgd2FzIGFsc28gdGhpbmtp
bmcgYWJvdXQgdGhpcyBraW5kIG9mIHVzZSBjYXNlcy4gQmVjYXVzZSBpdCBtaWdodCBiZQ0KPiBk
aWZmaWN1bHQgaW4gcHJhY3RpY2UgdG8gY29udHJvbCBhbGwgY2VydGlmaWNhdGUgcHJvcGVydGll
cywgd2UgbWlnaHQNCj4gd2FudCB0byBsZXQgc3lzYWRtaW5zIGNvbmZpZ3VyZSB0aGVzZSBzdWJz
ZXQgb2Yga2V5cmluZyBhY2NvcmRpbmcgdG8NCj4gdmFyaW91cyBjZXJ0aWZpY2F0ZSBwcm9wZXJ0
aWVzLg0KDQpJIGFncmVlLCBhIGNvbmZpZ3VyYXRpb24gY29tcG9uZW50IGZvciBhIHN5c2FkbWlu
IHdvdWxkIGJlIG5lZWRlZC4NCg0KPiBUaGVyZSBhcmUgY3VycmVudGx5IExTTSBob29rcyB0byBj
b250cm9sDQo+IGludGVyYWN0aW9ucyB3aXRoIGtlcm5lbCBrZXlzIGJ5IHVzZXIgc3BhY2UsIGFu
ZCBrZXlzIGFyZSBhbHJlYWR5IHRpZWQNCj4gdG8gTFNNIGJsb2JzLiBOZXcgTFNNIGhvb2tzIGNv
dWxkIGJlIGFkZGVkIHRvIGR5bmFtaWNhbGx5IGZpbHRlcg0KPiBrZXlyaW5ncyBhY2NvcmRpbmcg
dG8ga2VybmVsIHVzYWdlcyAoZS5nLiBrZXJuZWwgbW9kdWxlIHZlcmlmaWNhdGlvbiwgYQ0KPiBz
dWJzZXQgb2YgYW4gYXV0aGVudGljYXRpb24gbWVjaGFuaXNtIGFjY29yZGluZyB0byB0aGUgY2hl
Y2tlZCBvYmplY3QpLg0KDQpJZiBhbiBMU00gaG9vayBjb3VsZCBkeW5hbWljYWxseSBmaWx0ZXIg
a2V5cmluZ3MsIGFuZCB0aGUgRUtVIHdhcyB1c2VkLCANCmlzIHRoZXJlIGFuIG9waW5pb24gb24g
aG93IGZsZXhpYmxlIHRoaXMgc2hvdWxkIGJlPyAgTWVhbmluZywgc2hvdWxkIHRoZXJlIA0KYmUg
T0lEcyBkZWZpbmVkIGFuZCBjYXJyaWVkIGluIG1haW5saW5lIGNvZGU/ICBUaGlzIHdvdWxkIG1h
a2UgaXQgZWFzaWVyIA0KdG8gc2V0dXAgYW5kIHVzZS4gIEhvd2V2ZXIgd2hvIHdvdWxkIGJlIHRo
ZSBpbml0aWFsIE9JRCBvd25lcj8gIE9yIHdvdWxkIA0KcHJlZGVmaW5lZCBPSURzIG5vdCBiZSBj
b250YWluZWQgd2l0aGluIG1haW5saW5lIGNvZGUsIGxlYXZpbmcgaXQgdG8gdGhlIA0Kc3lzYWRt
aW4gdG8gY3JlYXRlIGEgcG9saWN5IHRoYXQgd291bGQgYmUgZmVkIHRvIHRoZSBMU00gdG8gZG8g
dGhlIGZpbHRlcmluZy4NCg0K
