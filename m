Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478317A675B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjISOzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjISOzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:55:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C959C9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:55:32 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JE72KC021974;
        Tue, 19 Sep 2023 14:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7JWVE0SJB37EReFIl+91rrzRUh3KIFc0G5n2J6zxD3E=;
 b=Wmujnl122kk+gtc7Rn/uPh3e0XmAe09L9wLhU/Y19Sj7VxfdbzwU0MdqjV36iv+7P9wq
 t/WqK938EBj6Q/m9A+daILRzGQd4goa7jsQmG23/mC0lezweS02vsm6tBBW+L9ug43wF
 uGSe2W690hMSdlAfE21FYBp2MAvzKCBv9I5dyKjwXNaKyOMub59WFH4/zAFyLwuNkpjb
 OnzklsUYXCfke+lI1XA8noqxniN6Ea16JaJpV0qHx+gTQnEWbIsvWRItVdKBdF6vQ0yy
 B/npnXkfatdPoi3xET7pQNrWP4raHlVk2o8iSqgjev6FEe6i5KmX3swxJk7PFH9UTYZT gQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t52sdw3t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 14:55:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38JERVc4027079;
        Tue, 19 Sep 2023 14:55:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t60yu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 14:55:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHcgFmj9ILiiQThGBaR1Xo9nCAQ6fEUYFZe6HHNWioEbRkFQHtS+6SCBP3GTWDyOxY/kCiCqVI/2Pj+uR7AwPjw5NteYgpNYYYLtznsyHqWeWDUq4BuoROdBxbK+atL6lbIptGbN3KBsTxz/bQSxpsjw6JcUzdMXFT4j2tLt42pudOfcWnB5DSYrFXRPotuTkqCJsLiz/zuixsHAP52nzdVUshODelXgYjpYc3gioht2Hi9I1WvMIhodK9J84c96wbaUuhM0Xqwhr3rYrwy9iBQUIa0XX3lPS1PEZfvFsTSLm93cjJQ5aRQStthMCYbGwsWgDhP6QAi8wtHTicDaIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JWVE0SJB37EReFIl+91rrzRUh3KIFc0G5n2J6zxD3E=;
 b=TgbnSwUE2JujL4QAEbafuZMQLHOS82F4zObRR4BdKD5Hu69BanwT6a2Y9f/lbPCht0WryYRyw0gte96JLMnx8SxdpA+Pxl9znrf8I1+oKE23e1R0QP8S8OoTBI+vo5V1GJ9MRw0Xw6lgjUFY/9VtliQDED1TVqTcPMYTdbI1b1i+m3xMUVza6Lk8rFIPV9aYszot/KMqHiuz0f2WtJDVfNgXIsEQVspM6vCMY29RhLxaWSMMZ8vyt7ZmKfFuqb+b+idLA6/gZIqv0IWvokO0vt9CdECb1SYRDjk8/PgO8TjqsKFqUDf1FovAUkzdoNtTY0/onJQ6x+/HY8is2ucELA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JWVE0SJB37EReFIl+91rrzRUh3KIFc0G5n2J6zxD3E=;
 b=g4fHRqtL8GQF8tmUSEALr5eWQAh3QQtohaoCQugd8KDM3ANikDsT16xSYmvahMiQRRaScwBsyleM+dvWicxLiSzvzqrRSKb4oN8/41Xe56nNGL5wWxYEltrqwc44vnm+zL4Xr5YoLfCNgkfuII5s+QBUXYCABelaKiHG4JYNHYs=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH0PR10MB4406.namprd10.prod.outlook.com (2603:10b6:510:34::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 14:54:53 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::76c:cb31:2005:d10c]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::76c:cb31:2005:d10c%5]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 14:54:53 +0000
From:   Miguel Luis <miguel.luis@oracle.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>
Subject: Re: [PATCH 2/3] arm64/kvm: Fine grain _EL2 system registers list that
 affect nested virtualization
Thread-Topic: [PATCH 2/3] arm64/kvm: Fine grain _EL2 system registers list
 that affect nested virtualization
Thread-Index: AQHZ5nOKLkrRCNJH90mY1Gfr1krO1rAgW1yAgAHqLgA=
Date:   Tue, 19 Sep 2023 14:54:53 +0000
Message-ID: <00087AB1-3F94-4D3B-8498-3CE3AEDFE6FA@oracle.com>
References: <20230913185209.32282-1-miguel.luis@oracle.com>
 <20230913185209.32282-3-miguel.luis@oracle.com>
 <868r93es5a.wl-maz@kernel.org>
In-Reply-To: <868r93es5a.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|PH0PR10MB4406:EE_
x-ms-office365-filtering-correlation-id: 4451748e-85bc-4537-8fd9-08dbb92061b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G/7iRjppNF4KajcwutomSPvF2EtNIx8sHxH1w+fIOfKXqibXw/3wfPwcuBipaNuNCM/GrkbsbUw+e/YjhY/dgkFing+ZwUemVxPNUiczrUiu7ACLbxXobFlXgbW9HvBRMixxLPuQH9/7bLIbnLCN6V9992GLa34p2SwEWt0RocA6spBmoMoto+FwJizgzgE0T45EP5j5TGqvDSLCS6vLtd6xrMu+p+m1uXhER0UZi+inqLSIG58/93lQHnXfHPGqBYRhnENUMdtQnkHf8wJ/IaA7omK0TYE3jkdXm0DzaghE/DyGuZERUJnQcjn9gxUwiHeoKq7q/XZac1dPX4lfWlW3o85Sj1Yc8fU5QuNVctGoYIGhFt5pxlbXOUTzIXCWuFCj9dO4TObOZawYq5TNlAfkTI3TjNOj3tWOmAILMWhRynUodWTHmqGKioqpuxE+b1a8f6qbGeM3SepSNuWzZcCIk+DfcfxdnqOh3cLldSDI+kicyKc8qkHJtl98dBoMF+visd3wzPTukb+mglPM69YjKJUbDkGy+uFgJIEVU7+EgS2jmo2zcZZTjERw7G3ohRNp4gr3tbYoiaZ4RBJPbKVq/MFIYNQK3gJyJ8tZeQMMYWWpRSNkQIG6+5HvV9hT1a343JDH9nO5sIu1g5tZ/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199024)(1800799009)(186009)(7416002)(2906002)(5660300002)(44832011)(4326008)(8676002)(8936002)(41300700001)(316002)(6916009)(54906003)(76116006)(66446008)(66946007)(91956017)(66556008)(66476007)(64756008)(478600001)(53546011)(6486002)(71200400001)(6512007)(6506007)(2616005)(83380400001)(36756003)(122000001)(33656002)(86362001)(38070700005)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a01IemxtT2IyVk16anJVbkJkSWRESGM4WmlQOVpjYjkrTGllR2VNNW11cW50?=
 =?utf-8?B?bjgxREw1a2RpQ3JhMm9kMUhVZm04MDViajd2VWhhQk0wMzFkdGh0OG5EOWZ2?=
 =?utf-8?B?bm5Wd05qNUZ2dzFiK1JUY2pqWmpTbzJGOWRPRHFHV0E3UG1iRStwZ1ppd0JY?=
 =?utf-8?B?YU9oRTFxQ0JiMnBzTHo1NmpEbm4wK2ZpYkJpWE1nZ0QzQndoU3NZYUtDeFZH?=
 =?utf-8?B?dHZaVDZwSDVQK1RxQ25uN2lTR2hhSUxCbGpFQ2FOVm9HRDhGZTRjbkJtUHVL?=
 =?utf-8?B?anlIOTVBRlF5S3lJYjRGSUVxb2NQaml5WFFSNEdzNTdXY0ZtbUtGMjUvTTlK?=
 =?utf-8?B?QkxkMGNuaUFMVnhjVStoMHhNUjZYd0orWmZvcHZ6RHNFRXdjTCttQUdoTFVV?=
 =?utf-8?B?ZFNXTUU4QmFMUG02ZHZpUi90MVRoQk9lSnZna2pCclBFQzBOdWhlMjBOanZ6?=
 =?utf-8?B?ZXZHRHZkVzJsR1JZNzlOZitQNUxjZ1cwRWZjbjZGMmxqbDhmYUZId0JGRHlk?=
 =?utf-8?B?TGY3VUhlK1E2RmEydy9Ja0diRElxVHpEL2s4MFBoeDZCbXNoNWFTV0hnczcw?=
 =?utf-8?B?czJKenFtOElaRFl5UVA5MzVQRkd1L21rK2daenRRdnlpbHBYNEc4WEZxbXpY?=
 =?utf-8?B?eTQ1dGVoTmFCbWwwc054cXhmd0ovamdDZEJVeStPNm9yTjNSdEJZYlFlbFZ6?=
 =?utf-8?B?Wktpb002US9DL05lY3hrUk81WHJVcEVYSWM3WURVdG9xL2F5WkdhTnJ5ZUlI?=
 =?utf-8?B?NDZ6QThuVkUxKzY3TDUwbGpiM1F6MnpYYWdua1l2UEo4elp5ejFvWkw4b3VU?=
 =?utf-8?B?THRQSmk2bGxzbUdwdlF2d3l5K25ta1VBMGxTNFBaRXdiekl1NUQ0V05Jd1Uv?=
 =?utf-8?B?R2h4MVpzN0JaaElxWlpuN0Z6eUVNK0V3OE83cHlzQXhLQlRGeWlxWjFiVFZ6?=
 =?utf-8?B?MWRMbWtSdjU0TXBrc3BveU11Tm16Wkc5U2l5SUJqVjBvenNKeEVZY1g3a1FI?=
 =?utf-8?B?OGtqSVZXYUJVRGVkaVVNc3FVZWZDRTRoM1dTdmt2RWJaUW04emhkSGJvU0Jh?=
 =?utf-8?B?OTg5RFdkZ3ZwZnZLUHVxMVRJNlR6QTFEV2ZHWFkvdkx4WlNLQi9ONlJjTklP?=
 =?utf-8?B?MjEzckYrcjBuMG02YjExUTlPYW52Q1I2V1RYbU9HWUtseFNXTkdQSWpYN2Za?=
 =?utf-8?B?MXA3NjhBM0RNYVd3UzAvQkRUWG9EZnBrSGVTS055aGxhVzBCbWdrakJVVmRq?=
 =?utf-8?B?VFFmUi9wYUNlS1lLdWt6VlkyRkhpeFozOHY2bWMxZGVPdHpYcXY4QnRTME42?=
 =?utf-8?B?b0JkRVhFY1JlNWptbXA4MnlFTW1qcWtDSm84U2hnVjlyRTh3enlqWTFFeGdN?=
 =?utf-8?B?ZWZkb1liTFFWZHJibG8ydkw4TGJOck9oRkVGMXN2aEFCaDNiZDRmdXVESFIz?=
 =?utf-8?B?NW9LMzdQNkR2Q0ZCQlRZbjNTQ1BHU2kxSkowNDZLQlkxT3NwOTNzdzZrVlFY?=
 =?utf-8?B?eC9ickNycFIwT3ZFN0lOYkJJbDArQ3VtUHNEdDVyc29rY0ducENTRS9qblor?=
 =?utf-8?B?dGlSdWhrTU1nN3R3SWswRVVUYTdsN21Mb1VuVWVxTC84VFE1Qi9vRDVkZjF0?=
 =?utf-8?B?aWlXakVWbzd3cFVGbHpUWkZNVXZ0QUptK2FGZXZhNk9JRCtUMkw2Y1dhRVYr?=
 =?utf-8?B?dm0yZjM2alNzZXFiL1AyS09LOTNJL2tOOWwzNXhQbXJwcWxZaFF2N283ZUY3?=
 =?utf-8?B?UE5PZkFURVlwLzZBRE5hWGV2M3Ftd01lV2pWQm1wVGxkL0JDLzAvMUJtVjFQ?=
 =?utf-8?B?WjBYSFJqZUE2VFdsN0lLeFc0bStmdml5emFOdjNIWG9yOG5PYmNWRzI1YVFR?=
 =?utf-8?B?UCsvL0VWaHRkOWdqUFREdERIVnN0M1ZlWlBMZWgvK3EwaTl2a0NJQzg1OUE1?=
 =?utf-8?B?a0MwNU1haW9DV0RSWEVlVmJVVWJzWnlsZ0RyNWZuQUh0Y05JcXlTK3FYSVpp?=
 =?utf-8?B?eE54ZVJIbGdwVTVoekw0WFdaTkcyOFFFbVN1UWNNSmdaa2djdmFsSWc2T2lw?=
 =?utf-8?B?YW1NUlE4MXlWd0d2SGJjUkdua2lDQlpqQUp4cEFpazJGSjB4RnZDL1BoRU8z?=
 =?utf-8?B?STluVmJ2T05LMzdwd3J2Q3p2YUk2V0VVQVk0dng1ZkdYb3U3blN1dUJUQWR4?=
 =?utf-8?B?b2E2bWY4TjRLMEduMXpIU1c3TDFXaXdWbmJQRGlqbnE1Y2t1YWMzZE0vQmp6?=
 =?utf-8?B?bmZEdG51VitLNTlTSm14VHZqMXlnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4659C15FB75AE047BDA1A0B40C22F581@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NHY0dUJsK1JOUGtES0k0c2JUTGVTRlFzWGFLalBDaFJnWnpkZTBJTHc3aUMw?=
 =?utf-8?B?N0FNaTRBWTd1TTRDWDg2QVRGRyt2cW1wUDNTUlJCQmQ3NTAySmRsUHYyVHJE?=
 =?utf-8?B?RnpXRWErK05vVEorc0RpQ2dIZm9RTGhjU2tOUFl0NSt6S3NkWWdxeVc1cUlR?=
 =?utf-8?B?Q2pNaXRVWFlYZjczTWNtYjdRQkVqSGdLWjBCQzhiNmt4ay9aenBhazNQNVNL?=
 =?utf-8?B?Znl5NlR2VkRYT2oydk9NQXlIeG5WQUwyNjd3cWxqRHRXY0hjSEtjV1BMNTla?=
 =?utf-8?B?cnNSOWZSOEhvbE9NZExlTnNyMW9pT1NaU0RCZ05ScWJBODlGVGxyUnRwRDdR?=
 =?utf-8?B?dTlURVh0MFVJYXFQM2ljeVBBMStwVGVqNGJudVQ5bmg2SkpCRGNQTi9PZ0M0?=
 =?utf-8?B?a0hFV0h5UkNqQWJaVjl0bmg2OUVodlJUL0FFRENTdlh4R201dXpiSGJ2MXVE?=
 =?utf-8?B?a05IVjFScFVTUjVucTh0SUM4VHZtTjJJWnl1L3FhZXVRQm04REczUSt5Y0Fh?=
 =?utf-8?B?VUFWdjBJRDljNTVyWTc2UHd5TUxuaEVQRWFYMmJBdmcwNnAzNVB3YzF0RDlO?=
 =?utf-8?B?bmQ5emxFK1Y3TUxjY3FLTGk1NjE0YzcxaFY5dDVqQXBIWnFWNy9LRytXd0ZX?=
 =?utf-8?B?dVpQVmd2dlpJVHllQTNpUTRkWk1BNzhTdml6VXZPQjlNQzN5L2NtdG4zWE9I?=
 =?utf-8?B?OEt6bGNYakNOcEtNK2dGNjRxMVZCV1NXR1B2LzhBVUNYNFZET0h2Q093U2xv?=
 =?utf-8?B?R2VzNjVWRVBLblhxMkVXMWZyL0IwbENNRUZRanhML3FGakpBOG5walIrdDBY?=
 =?utf-8?B?emNRKzd6RmV0bzQ3UTBVbFIyY0tzVHg0TzQ4QS9jbDdqUjNHSFp3RHJlZVZn?=
 =?utf-8?B?bjZKc1A2aVBUclpFUEUwUXNacnJwK0ZsbHM0QUdRZ2xZUVVaNjNYcmVYN25m?=
 =?utf-8?B?cFhzR0MycWFGeGdPQlRmUWR6MVI0TytUM0VVTW5YN1c0N2d2d1FTbDFJUVFE?=
 =?utf-8?B?eTR3UGdNaVN6YnFCRXJQbmJTUVZWaDZPUmJIMHJOWTFPMVFMdmlFc3kvRUNR?=
 =?utf-8?B?QmZ1TGhtVE12K0NVTGdoMkptS1R0NVVwT1I5RW0rNTg1UVpSK0NLcWYzYStn?=
 =?utf-8?B?TVA2TVgvVkpZOU56dThyWjVnc0IzcXEwUGhpV0RCb2xLSG9aMU9IT0F6cnUw?=
 =?utf-8?B?RDZOM3lZTFBLMFM5S3MydzlQVlBmNmJsWmtQNk52ZWYxKzVsbDVYbHQyQmpI?=
 =?utf-8?B?dHBTeFZSeHFHd1UvT09SZXlvaGtFRUxBWmZJYWdpbnVkSzZpQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4451748e-85bc-4537-8fd9-08dbb92061b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 14:54:53.2226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XcBvNB3heEiqMijfq3XmaIeMoPTEnOw4mVW5cS1oWvOlJpVPI02E+t69ijEDGEz/eWDAew9H7KD9IPAiUbFIug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4406
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_06,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190128
X-Proofpoint-GUID: x3ZKN8PvvY4nzORmcA4ikCiSrntzHxQg
X-Proofpoint-ORIG-GUID: x3ZKN8PvvY4nzORmcA4ikCiSrntzHxQg
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYywNCg0KPiBPbiAxOCBTZXAgMjAyMywgYXQgMDk6NDAsIE1hcmMgWnluZ2llciA8bWF6
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gSGkgTWlndWVsLA0KPiANCj4gT24gV2VkLCAxMyBT
ZXAgMjAyMyAxOTo1MjowNyArMDEwMCwNCj4gTWlndWVsIEx1aXMgPG1pZ3VlbC5sdWlzQG9yYWNs
ZS5jb20+IHdyb3RlOg0KPj4gDQo+PiBTb21lIF9FTDEgcmVnaXN0ZXJzIGdvdCBpbmNsdWRlZCBp
biB0aGUgX0VMMiByYW5nZXMsIHdoaWNoIGFyZSBub3QNCj4+IGFmZmVjdGVkIGJ5IE5WLiBSZW1v
dmUgdGhlbSBhbmQgZmluZSBncmFpbiB0aGUgcmFuZ2VzIHRvIGV4Y2x1c2l2ZWx5DQo+PiBpbmNs
dWRlIHRoZSBfRUwyIG9uZXMuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IE1pZ3VlbCBMdWlzIDxt
aWd1ZWwubHVpc0BvcmFjbGUuY29tPg0KPj4gLS0tDQo+PiBhcmNoL2FybTY0L2t2bS9lbXVsYXRl
LW5lc3RlZC5jIHwgNDQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+PiAxIGZp
bGUgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQva3ZtL2VtdWxhdGUtbmVzdGVkLmMgYi9hcmNoL2FybTY0L2t2
bS9lbXVsYXRlLW5lc3RlZC5jDQo+PiBpbmRleCA5Y2VkMWJmMGMyYjcuLjlhYTFjMDZhYmRiNyAx
MDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtNjQva3ZtL2VtdWxhdGUtbmVzdGVkLmMNCj4+ICsrKyBi
L2FyY2gvYXJtNjQva3ZtL2VtdWxhdGUtbmVzdGVkLmMNCj4+IEBAIC02NDksMTQgKzY0OSw0NiBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGVuY29kaW5nX3RvX3RyYXBfY29uZmlnIGVuY29kaW5nX3Rv
X2NndFtdIF9faW5pdGNvbnN0ID0gew0KPj4gU1JfVFJBUChTWVNfQVBHQUtFWUhJX0VMMSwgQ0dU
X0hDUl9BUEspLA0KPj4gLyogQWxsIF9FTDIgcmVnaXN0ZXJzICovDQo+PiBTUl9SQU5HRV9UUkFQ
KHN5c19yZWcoMywgNCwgMCwgMCwgMCksDQo+PiAtICAgICAgIHN5c19yZWcoMywgNCwgMywgMTUs
IDcpLCBDR1RfSENSX05WKSwNCj4+ICsgc3lzX3JlZygzLCA0LCA0LCAwLCAxKSwgQ0dUX0hDUl9O
ViksDQo+IA0KPiBJdCB3b3VsZCBiZSBnb29kIGlmIHRoZSBjb21taXQgbWVzc2FnZSBleHBsYWlu
ZWQgdGhhdCB5b3UgYXJlIGZvbGRpbmcNCj4gU1BTUi9FTFIgaW50byB0aGUgZXhpc3RpbmcgcmFu
Z2UuIEFsc28sIHBsZWFzZSBrZWVwIHRoZSB0d28gZW5kcyBvZg0KPiB0aGUgcmFuZ2VzIHZlcnRp
Y2FsbHkgYWxpZ25lZC4NCj4gDQoNCk9LLg0KDQo+PiAvKiBTa2lwIHRoZSBTUF9FTDEgZW5jb2Rp
bmcuLi4gKi8NCj4+IC0gU1JfVFJBUChTWVNfU1BTUl9FTDIsIENHVF9IQ1JfTlYpLA0KPj4gLSBT
Ul9UUkFQKFNZU19FTFJfRUwyLCBDR1RfSENSX05WKSwNCj4+IC0gU1JfUkFOR0VfVFJBUChzeXNf
cmVnKDMsIDQsIDQsIDEsIDEpLA0KPj4gLSAgICAgICBzeXNfcmVnKDMsIDQsIDEwLCAxNSwgNyks
IENHVF9IQ1JfTlYpLA0KPj4gKyBTUl9SQU5HRV9UUkFQKHN5c19yZWcoMywgNCwgNCwgMywgMCks
DQo+PiArIHN5c19yZWcoMywgNCwgMTAsIDYsIDcpLCBDR1RfSENSX05WKSwNCj4+ICsgLyogc2tp
cCBNRUNJRF9BMF9FTDIsIE1FQ0lEX0ExX0VMMiwgTUVDSURfUDBfRUwyLA0KPj4gKyAgKiAgICAg
IE1FQ0lEX1AxX0VMMiwgTUVDSURSX0VMMiwgVk1FQ0lEX0FfRUwyLA0KPj4gKyAgKiAgICAgIFZN
RUNJRF9QX0VMMi4NCj4+ICsgICovDQo+IA0KPiBQbGVhc2UgZm9sbG93IHRoZSBrZXJuZWwgY29t
bWVudCBmb3JtYXQuIEFsc28sIHdoeSBhcmUgeW91IHNraXBwaW5nDQo+IHRoZSBNRUMgcmVnaXN0
ZXJzLCBidXQgbm90IHRoZSBNUEFNIG9uZXM/IEF0IGxlYXN0IGluZGljYXRlIGENCj4gcmF0aW9u
YWxlIGZvciB0aGlzLg0KPiANCg0KSeKAmW0gbm90IGF3YXJlIG9mIGFueSBleGNlcHRpb25zIGZv
ciBNUEFNIHJlZ2lzdGVycywgYWx0aG91Z2ggdGhlcmUgYXJlIGZvciBNRUMNCndoZW4gSENSX0VM
Mi5OVjIgaXMgMC4NCg0KPj4gU1JfUkFOR0VfVFJBUChzeXNfcmVnKDMsIDQsIDEyLCAwLCAwKSwN
Cj4+IC0gICAgICAgc3lzX3JlZygzLCA0LCAxNCwgMTUsIDcpLCBDR1RfSENSX05WKSwNCj4+ICsg
c3lzX3JlZygzLCA0LCAxMiwgMSwgMSksIENHVF9IQ1JfTlYpLA0KPj4gKyAvKiBJQ0hfQVAwUjxt
Pl9FTDIgKi8NCj4+ICsgU1JfUkFOR0VfVFJBUChTWVNfSUNIX0FQMFIwX0VMMiwNCj4+ICsgU1lT
X0lDSF9BUDBSM19FTDIsIENHVF9IQ1JfTlYpLA0KPj4gKyAvKiBJQ0hfQVAxUjxtPl9FTDIgKi8N
Cj4+ICsgU1JfUkFOR0VfVFJBUChTWVNfSUNIX0FQMVIwX0VMMiwNCj4+ICsgU1lTX0lDSF9BUDFS
M19FTDIsIENHVF9IQ1JfTlYpLA0KPj4gKyBTUl9SQU5HRV9UUkFQKHN5c19yZWcoMywgNCwgMTIs
IDksIDUpLA0KPj4gKyBzeXNfcmVnKDMsIDQsIDEyLCAxMSwgNyksIENHVF9IQ1JfTlYpLA0KPj4g
KyAvKiBJQ0hfTFI8bT5fRUwyICovDQo+PiArIFNSX1RSQVAoU1lTX0lDSF9MUjBfRUwyLCBDR1Rf
SENSX05WKSwNCj4+ICsgU1JfVFJBUChTWVNfSUNIX0xSMV9FTDIsIENHVF9IQ1JfTlYpLA0KPj4g
KyBTUl9UUkFQKFNZU19JQ0hfTFIyX0VMMiwgQ0dUX0hDUl9OViksDQo+PiArIFNSX1RSQVAoU1lT
X0lDSF9MUjNfRUwyLCBDR1RfSENSX05WKSwNCj4+ICsgU1JfVFJBUChTWVNfSUNIX0xSNF9FTDIs
IENHVF9IQ1JfTlYpLA0KPj4gKyBTUl9UUkFQKFNZU19JQ0hfTFI1X0VMMiwgQ0dUX0hDUl9OViks
DQo+PiArIFNSX1RSQVAoU1lTX0lDSF9MUjZfRUwyLCBDR1RfSENSX05WKSwNCj4+ICsgU1JfVFJB
UChTWVNfSUNIX0xSN19FTDIsIENHVF9IQ1JfTlYpLA0KPj4gKyBTUl9UUkFQKFNZU19JQ0hfTFI4
X0VMMiwgQ0dUX0hDUl9OViksDQo+PiArIFNSX1RSQVAoU1lTX0lDSF9MUjlfRUwyLCBDR1RfSENS
X05WKSwNCj4+ICsgU1JfVFJBUChTWVNfSUNIX0xSMTBfRUwyLCBDR1RfSENSX05WKSwNCj4+ICsg
U1JfVFJBUChTWVNfSUNIX0xSMTFfRUwyLCBDR1RfSENSX05WKSwNCj4+ICsgU1JfVFJBUChTWVNf
SUNIX0xSMTJfRUwyLCBDR1RfSENSX05WKSwNCj4+ICsgU1JfVFJBUChTWVNfSUNIX0xSMTNfRUwy
LCBDR1RfSENSX05WKSwNCj4+ICsgU1JfVFJBUChTWVNfSUNIX0xSMTRfRUwyLCBDR1RfSENSX05W
KSwNCj4+ICsgU1JfVFJBUChTWVNfSUNIX0xSMTVfRUwyLCBDR1RfSENSX05WKSwNCj4gDQo+IFlv
dSBjb3VsZCBkZXNjcmliZSBhbGwgdGhlIExScyBhIHNpbmdsZSByYW5nZS4NCj4gDQoNClNob3Vs
ZCB3ZSBza2lwIHRoZSBnYXAgYmV0d2VlbiBMUjcgLSBMUjggPw0KDQo+PiArIFNSX1JBTkdFX1RS
QVAoc3lzX3JlZygzLCA0LCAxMywgMCwgMSksDQo+PiArIHN5c19yZWcoMywgNCwgMTMsIDAsIDcp
LCBDR1RfSENSX05WKSwNCj4+ICsgLyogc2tpcCBBTUVWQ05UVk9GRjA8bj5fRUwyIGFuZCBBTUVW
Q05UVk9GRjE8bj5fRUwyICovDQo+IA0KPiBXaHk/DQoNCkkgZGlkbuKAmXQgZmluZCBpdHMgZGVm
aW5pdGlvbiBUQkggYWx0aG91Z2ggdGhlc2UgY291bGQgdXNlIGEgc2luZ2xlIHJhbmdlLg0KDQpU
aGFua3MsDQoNCk1pZ3VlbA0KDQo+IA0KPj4gKyBTUl9SQU5HRV9UUkFQKHN5c19yZWcoMywgNCwg
MTQsIDAsIDMpLA0KPj4gKyBzeXNfcmVnKDMsIDQsIDE0LCA1LCAyKSwgQ0dUX0hDUl9OViksDQo+
PiAvKiBBbGwgX0VMMDIsIF9FTDEyIHJlZ2lzdGVycyAqLw0KPj4gU1JfUkFOR0VfVFJBUChzeXNf
cmVnKDMsIDUsIDAsIDAsIDApLA0KPj4gICAgICAgc3lzX3JlZygzLCA1LCAxMCwgMTUsIDcpLCBD
R1RfSENSX05WKSwNCj4gDQo+IFRoYW5rcywNCj4gDQo+IE0uDQo+IA0KPiAtLSANCj4gV2l0aG91
dCBkZXZpYXRpb24gZnJvbSB0aGUgbm9ybSwgcHJvZ3Jlc3MgaXMgbm90IHBvc3NpYmxlLg0KDQoN
Cg==
