Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C290B7E4B6E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344213AbjKGWEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjKGWDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:03:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6861996
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:00:56 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJpwG026315;
        Tue, 7 Nov 2023 21:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=rR1rkZaAcUjbJhVUuuHUsBP4wRC0wqW6GVBbfHb15x8=;
 b=AwsiFAMDdloUNUPeyvfyMO+aMi0EkQXiEasxSzq735RWh0hj65kJw3RdfSFOhYfKeDcI
 NZCBfHXLWBs9BRKzhpHfZPxM2uURobrmETAhR947ypcB/+DDyJt5zF7RMZIB7pZhwph/
 j/+hAQYbqel40grJYu+pTi4kd3lNjDNIFoqXYkAagofRMbLAzD6T/i4Vm7k1SxK5wsSD
 0CuCCFyEg+Z/9xb/ftlJ7yBu8dI6k6rCxewAVwd+0GILv2y5S/aa/4MlD+OgTGnlckb6
 FDKrhRN2fhL3f1rGd0FA413vuVsAcLoyhNW2oVYKvigyAYb1bo+4FKN0xvJZVVYr5V/x eA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2102q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJOlK023824;
        Tue, 7 Nov 2023 21:59:57 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w241gvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgOJ/mz5lOcv+9EY5ImUX1gsmXMkKYy+S/FeJA2HWTa/nGgj4KDo1dxEFP+uZpJKIquP318avQvTvXP9NRvFD9rVKsEFKL4VRVm9tnacW7XXsuNauwA1nfzR3+kv6nQLdOnBamoTQzzkx4ksDz3fH7nj3ik2XebLpjRzu2DSM01iBnvNDJpfxRpH1qXJH3dsb3w7oL0Qj+vx95E4E1ARckuLjdGy2xOYyfkaDuTgRTGIyT5kJAjt8ygsm+4StarTS/oMXq7ulJk6gKFHq9kz4sFKKUoM8Ucigz8vMVSPhq5MqOh0IQQ1evYrbNbs4oqt7/Eg32YNQaG8zD6pY/czug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rR1rkZaAcUjbJhVUuuHUsBP4wRC0wqW6GVBbfHb15x8=;
 b=fD8qjFp29z2dFsmKcW9qRFcHbp+mnbwqhY0T5D2ltxokSwS4NVS0zKiepLWdajKSvs6xlBURIBeoIbLP2UfcPOFDbRWlxfWo7gX0cz8s/RMEa5JPIZ966KKZvz3ZdR+qekYC4m1X7tAXLkUNMzHqL7+xJykzNozH1r8EkS7TqGuAys+qP0H77oi9pj9Z8sCJg+3Duymo4lbB7KP7RL5UY8o1QuWfD3+n2AHnMm5Or95thDY95419F/lg/A+l4z3DqYloEc0/mV+Po6G6MgTN+Goxzlgz+XnSadZcPKFNpXu99w8aPd7fcEuUvMYs+vDIh9CKdHCAOqEGJkFKEeSJ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rR1rkZaAcUjbJhVUuuHUsBP4wRC0wqW6GVBbfHb15x8=;
 b=prbTUcMA3tI9tKkKd8/zkGWi0pIGVmhSAuZf2HCEYNFzhYwtqz2rlQqDz1UVLXVpuy/8KVZLTlJLHtjZz7AsYT1PKtq5HNS3aP58ypdWl13N5e7pbjTD6LINZumT3nDybQx+ehk12cdLSd15W8JqWJRRfY36YhUyvsjiVOuMycA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6141.namprd10.prod.outlook.com (2603:10b6:930:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 21:59:54 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:59:54 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 43/86] sched: enable PREEMPT_COUNT, PREEMPTION for all preemption models
Date:   Tue,  7 Nov 2023 13:57:29 -0800
Message-Id: <20231107215742.363031-44-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:303:b4::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: e23fc83e-3569-4276-4692-08dbdfdcdfd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4i1r8YnG08dLkmb/W3ggCv8d4f+0sRTbVy8b/3F5xsy7FBmrawbE7NtK1MUGNqkdR0AtB/h3WrCpQU3uDsV2y6KePXIeJ9No3f6HCTtHYm6SEdJu7Vom33RsJadq07TeOWtqGFXbBVhKZ85R7lZzaMaPDoplflD3ImHkB6cQcBX1PHcdD7WxihAaLA9YpBdI/54ZleQfh1azSAbxoDxndMQ/DFn6BUJ39jTXj2JuS3t42ROq+gYGfMbd4DhxFZJaR2j47742WlbnsOeCtACxhUozyotgudi2yF/2v6bISGo+mcUe7IBzEG8xcXoL9QLm6LgqoFkMP46LSyrPsBwrNVNX7mq+d4SP2ir+37ibkroNSder2g0YgUO3/KRT210DyOKWc1wbvOIyef/yaymY/bAcO4lKg5gI3JMsbwUdD6PPU58/RNOI3H5QpjEofTSq9zCDLEwpZJsO8JRZlPNzUmhM4K2BZyizNNLr0gawYICK9GDiBf8ggQ032nLZIr7AiCY+Qyy02tA11JzlHN7eiLCYsKvLsMIiu9xQX7l9y4zDdl5g2eUCC2kc4kRV2vlu6oAGByjf8ZNgxOsL14cXI0UG1PoJ4oiicLwCquPek+ZsiLqGYioas+tb/D8PaVCo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(86362001)(103116003)(8676002)(478600001)(8936002)(6486002)(4326008)(6666004)(38100700002)(1076003)(5660300002)(36756003)(6512007)(66476007)(6916009)(66946007)(66556008)(316002)(2616005)(7416002)(107886003)(7406005)(2906002)(26005)(83380400001)(41300700001)(170073001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GA0RiWnl/1dkrogtczrnNsfMGkIUWj61x5yAfnBKwG9t3oLwMx50leppf8/A?=
 =?us-ascii?Q?A+WJ+hAJZ0Noa06h5GZeW0TNFvL+QaEEkD0dnHyKMKAldxG6nBf+0ZO6Vajw?=
 =?us-ascii?Q?FvaMyNMGFTRtWQn1a54ol0lPkr+9/K28wPNZhVuRiXR+LNL7QlALpNAsSC6B?=
 =?us-ascii?Q?WGq+XH9C6I6Ryaw1/YQZWvjzopIQfl0vNZ3OmX+fdvRt/78VOWiZuH485uMG?=
 =?us-ascii?Q?834l//D4cAXfcBAT3d7VSZpvKiZ+tJN0/EnVhe6a7F6dh+6Wzw6p9DhtVknN?=
 =?us-ascii?Q?iQFcaEfSONysmXixpk+COiL1DTnzJLCcLdl4kicKJhEBMtfh8q+veJnBOMCv?=
 =?us-ascii?Q?fkvifPWoWGyhYSjmLH/SgPzszjUmDeU0JzckUH3GbXxYsCR6FuBGWgMsbKaH?=
 =?us-ascii?Q?sSTWz6IGkmpnLIRAh9r32E1DQdgM7rxLWstoOxdkTewyNGGA8E7SILQeb2ig?=
 =?us-ascii?Q?kRXUjCJopy97gGKI37uTO6br5jOVSkA3Fy5Z3vVlwH0LyOcaO1UIp5OuCr8z?=
 =?us-ascii?Q?YSlUtg4QVA6T1yc3CgvOc4nGY8ZdcSLDEwmS6BOUwzEUEJLzgnYgKtAPQQMz?=
 =?us-ascii?Q?mj56SoZJs9QTXB6ePVFi6RzULjYo5WZsRGVTbbVQrmyg2Q6MeYEUWPD2TZdv?=
 =?us-ascii?Q?CYGUoCavQssKQjE9uReC5OsQPewmFKuXmXMQIbgpf5w1oPk2CoFLZwFNcJ6l?=
 =?us-ascii?Q?P4uVkiq94mgaUr/B0n/kpNOwSOreOtmyKAsXYbmCJJqniB0VE0R9yTTPIBao?=
 =?us-ascii?Q?vCqYnUWN1mayaOEQDB+iI1KLtgKcjn/P6ppFy+fvemmVT3uXxwkY46j1nlVx?=
 =?us-ascii?Q?FyFWCWB8HNSOBVQ3ZErBKAT7tAn2rlFYEnDbdnTtO6wwSRVezQL3ZWuRrlB4?=
 =?us-ascii?Q?Jjar1w8P+uZI+BiuqIlQUVU+B+MC/FnrlTBHMIYTulfEepoviNKNPU4Smlfc?=
 =?us-ascii?Q?YWMtT1rzPL9BQdE7T3sVuX1tevqKOOAmO7slyb5SOBoki6s/zLGaH+Gxr5F9?=
 =?us-ascii?Q?sKTEOOBp9Q8AQ14WwhvH781mlRegxgsFsKrBwjzgAbj6z1ipXuiHLP98c/1/?=
 =?us-ascii?Q?4Nrn1dMiFex+ifeNJ/kTm2GE3dft/aM4QEENsWQEBfLBGQNtH5NNEEAngVSX?=
 =?us-ascii?Q?Cufu3erkcLPl0n34uiV2yM+v6EDrKj3ia9pj9cFIpNL2IvnNz0X353i7uda9?=
 =?us-ascii?Q?ZMJJtfMuiGZd1l/kMbBpgbSCQb6kcAmWZMDqJ1NHfxdCPBu0/LYMJmo4/k27?=
 =?us-ascii?Q?u+lOTOqSTs67WJFm6d/7+fR8hlQKr0jmugS/22eghqAiRaD8f/NtmHBZZm8A?=
 =?us-ascii?Q?40MC5nKwukhoge/C9ykcGdZ2UyR7VocO7jbG8708IKKtG/EOTASU4YCDpKub?=
 =?us-ascii?Q?P30RJTNM/AqIBrcPLjEjPAb+XSsihPiOxjJYSwiC8KJRXAycxK6BOpEmq0yE?=
 =?us-ascii?Q?gdZBFfU1Hxzr0C69hUx5EJxb5PS9IUYxThw58N9yKgN+2Ff5urs50O2HLGGC?=
 =?us-ascii?Q?kABb+d8aoCI54dJznM5jppvSXG3gtKhojdQ6tH72tdxOqcIEHax+pTpPrXfL?=
 =?us-ascii?Q?G1qtlHss0xZY5eOc0y46MfYt9gXbYbsbMOMKIPDMIHgB1LkHOOUAMwcSxyF+?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2KVr+PpYU0fcvinW84F0KkuRNktyirBuSwdahfWlxTo8NxW07ixmCSUZZkZ8?=
 =?us-ascii?Q?wytEtl9OjMd1arPqEmgFLkYDgSHucLQFMjKqWwdyDQwhRZx7vOQ9dY4A4BTC?=
 =?us-ascii?Q?Giv8Ewgv1dHkPtdqUd56TAqzmvZyyL+8JnaF0KUawzTQLnc2y6BFg8ZRIJvz?=
 =?us-ascii?Q?cdIHUuULK8DkBSXUIdgFATjaUBvz9mz9hXVW3HeVROe9DENFkZVCknLMtJa6?=
 =?us-ascii?Q?/H4pWykbHI2GOwk3WidrPO1t7o/lhs0e/d0EIXYFziL4kWCwfkhV/jxb1w9x?=
 =?us-ascii?Q?98I98W5cQ6wgl3m9YfXZRlUNpwqxQve6y+e3YLY2vcVRFvA7csYkUZEU9W6H?=
 =?us-ascii?Q?zxB1Um+2iP7r+aPM5iSHBR2CrWSjO8a/K1uwUy2dsSZTRjalm7P5BIftdZcu?=
 =?us-ascii?Q?syau3+68n+YX+ved5nvqlxL74TYVOCdxT+W6R42r09QvQn4H0OVxP01JWM67?=
 =?us-ascii?Q?J09dYo3rPwORTKNG7ur8lE9ZmYtv50h8jr73XJh5GAnIYscAtMeWkBN4Y2/M?=
 =?us-ascii?Q?iJ//Z7P0cUFZe4nMxvBjhgif0I6qOjgdxUt1+hyR3vkKeAOIFUQ5fkmf7YVo?=
 =?us-ascii?Q?4lW5WbBo4S9ReC/V5sx1Sxp7Pib/nDcNA1HFfj6n/BLJKtSPhqpIFNlvSUei?=
 =?us-ascii?Q?/b5w+w5xaWk/ldjQhQipkR+e/OwZFCSSMQ0N6aSuCtiZzZke9BXkEzg9EgRj?=
 =?us-ascii?Q?IU0oRUrzEQ8GPJP/6I1B3+SVop1nz1FwsWTfKDvBhzsgtnd3uL+NGz65wLep?=
 =?us-ascii?Q?bPhLbtdtrAnPPg2v/yNYiLSyjOwVJ2rfVnDLwDmr0j4qpRm90cbb7xdtgiX9?=
 =?us-ascii?Q?n1gMSzZlhJtZ3gFRySy7AhEsiqhsPZ2BHP5wNZ+55MLmJUjJlWsu0KjVXucl?=
 =?us-ascii?Q?Bvyv1NSMtCWzcT9OevTyJ+6nBxQV8gd4OsKIjvghvtfglRxK2paeUiq7b7kA?=
 =?us-ascii?Q?NWg8twT8qV0+fsXn3F6t1cLRuEQIfl8FVZs1ovLQMPKnB9l/+qPeCBGksrbm?=
 =?us-ascii?Q?dtn7cTntf6opXldiuPR6G4M/jWOxOjTTCNY1U7Jp5Bg5k0oEGOA5fl7yuJBZ?=
 =?us-ascii?Q?tGSgagLU1wkWRI8vjc7HOTpDysDdfXx/XGxxkZw4Wn6+D+u+kitLJ3CanXuv?=
 =?us-ascii?Q?3xW1aBVlvaqDgjn0PYCkBoBTPPa35SagzReKeKURvQAUoh9XRmhdQov1DaJZ?=
 =?us-ascii?Q?Zsm505bNXlrQ0Imdm57bTkKJ4UYdsBLxHIQSYechSnCTFFTY+1bV8r7GYORM?=
 =?us-ascii?Q?dafYktYausdEo1etI/AHR0GteopARaU75Jc8bRbtrGSoQLPwsseka5M5GBTL?=
 =?us-ascii?Q?3hBsDUS7LAFFCRkQH3TLXUGv8nCZjJTqOhLinm0biMlvM5eIG41xca+K+o7w?=
 =?us-ascii?Q?zj3v/2lDqMr92KF6kRnrxvla+NLi1H6QT/wX9BWpypnsQz/m2JCEprFXcXAa?=
 =?us-ascii?Q?eHP4Ak0CItZQHMB+GdCMB/BUCvNHLs2tp2cyEWzGLu9+xSX2XK37Xa7QqOOQ?=
 =?us-ascii?Q?oKp+n/QBkZwLFFdyh/Yxybh54taQLBKn5AkQsVnFK0g/eGXzzRD+AYArfg?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23fc83e-3569-4276-4692-08dbdfdcdfd9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:59:54.5899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ov0nHQuUC80qS7AsA/au1oN20mO3i1UajO67O7HTy7M3+ukgONY0I2B7bLJDLBE+jyMztb/7m+wz6fxvCdOsE36pkQ/tw+Ia0+H/yaxPpow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=829 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070182
X-Proofpoint-GUID: HUXlBx9Ae2D8bU10bNXdXpUFrxiOPGJz
X-Proofpoint-ORIG-GUID: HUXlBx9Ae2D8bU10bNXdXpUFrxiOPGJz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scheduler uses PREEMPT_COUNT and PREEMPTION to drive
preemption: the first to demarcate non-preemptible sections and
the second for the actual mechanics of preemption.

Enable both for voluntary preemption models.

In addition, define a new scheduler feature FORCE_PREEMPT which
can now be used to distinguish between voluntary and full
preemption models at runtime.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 init/Makefile           |  2 +-
 kernel/Kconfig.preempt  | 12 ++++++++----
 kernel/entry/common.c   |  3 +--
 kernel/sched/core.c     | 26 +++++++++++---------------
 kernel/sched/features.h |  6 ++++++
 5 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/init/Makefile b/init/Makefile
index 385fd80fa2ef..99e480f24cf3 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -24,7 +24,7 @@ mounts-$(CONFIG_BLK_DEV_INITRD)	+= do_mounts_initrd.o
 #
 
 smp-flag-$(CONFIG_SMP)			:= SMP
-preempt-flag-$(CONFIG_PREEMPT)          := PREEMPT
+preempt-flag-$(CONFIG_PREEMPTION)       := PREEMPT_DYNAMIC
 preempt-flag-$(CONFIG_PREEMPT_RT)	:= PREEMPT_RT
 
 build-version = $(or $(KBUILD_BUILD_VERSION), $(build-version-auto))
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index aa87b5cd3ecc..074fe5e253b5 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -6,20 +6,23 @@ choice
 
 config PREEMPT_NONE
 	bool "No Forced Preemption (Server)"
+	select PREEMPTION
 	help
 	  This is the traditional Linux preemption model, geared towards
 	  throughput. It will still provide good latencies most of the
-	  time, but there are no guarantees and occasional longer delays
-	  are possible.
+	  time, but occasional delays are possible.
 
 	  Select this option if you are building a kernel for a server or
 	  scientific/computation system, or if you want to maximize the
 	  raw processing power of the kernel, irrespective of scheduling
-	  latencies.
+	  latencies. Unless your architecture actively disables preemption,
+	  you can always switch to one of the other preemption models
+	  at runtime.
 
 config PREEMPT_VOLUNTARY
 	bool "Voluntary Kernel Preemption (Desktop)"
 	depends on !ARCH_NO_PREEMPT
+	select PREEMPTION
 	help
 	  This option reduces the latency of the kernel by adding more
 	  "explicit preemption points" to the kernel code. These new
@@ -53,7 +56,8 @@ config PREEMPT
 
 	  Select this if you are building a kernel for a desktop or
 	  embedded system with latency requirements in the milliseconds
-	  range.
+	  range. You can always switch to one of lower preemption options
+	  at runtime.
 
 config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 6433e6c77185..f7f2efabb5b5 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -422,8 +422,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		}
 
 		instrumentation_begin();
-		if (IS_ENABLED(CONFIG_PREEMPTION))
-			irqentry_exit_cond_resched();
+		irqentry_exit_cond_resched();
 		/* Covers both tracing and lockdep */
 		trace_hardirqs_on();
 		instrumentation_end();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f65bf3ce0e9d..2a50a64255c6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1065,7 +1065,7 @@ void __resched_curr(struct rq *rq, resched_t rs)
  *
  * Always schedule eagerly, if:
  *
- *  - running under full preemption
+ *  - running under full preemption (sched_feat(FORCE_PREEMPT))
  *
  *  - idle: when not polling (or if we don't have TIF_POLLING_NRFLAG)
  *    force TIF_NEED_RESCHED to be set and send a resched IPI.
@@ -1081,7 +1081,7 @@ void resched_curr(struct rq *rq)
 	resched_t rs = RESCHED_lazy;
 	int context;
 
-	if (IS_ENABLED(CONFIG_PREEMPT) ||
+	if (sched_feat(FORCE_PREEMPT) ||
 	    (rq->curr->sched_class == &idle_sched_class)) {
 		rs = RESCHED_eager;
 		goto resched;
@@ -1108,7 +1108,6 @@ void resched_curr(struct rq *rq)
 	context = ct_state_cpu(cpu_of(rq));
 	if ((context == CONTEXT_USER) ||
 	    (context == CONTEXT_GUEST)) {
-
 		rs = RESCHED_eager;
 		goto resched;
 	}
@@ -6597,20 +6596,18 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  *
  *   1. Explicit blocking: mutex, semaphore, waitqueue, etc.
  *
- *   2. TIF_NEED_RESCHED flag is checked on interrupt and userspace return
- *      paths. For example, see arch/x86/entry_64.S.
+ *   2. TIF_NEED_RESCHED flag is checked on interrupt and TIF_NEED_RESCHED[_LAZY]
+ *      flags on userspace return paths. For example, see arch/x86/entry_64.S.
  *
- *      To drive preemption between tasks, the scheduler sets the flag in timer
- *      interrupt handler scheduler_tick().
+ *      To drive preemption between tasks, the scheduler sets one of these
+ *      flags in timer interrupt handler scheduler_tick().
  *
  *   3. Wakeups don't really cause entry into schedule(). They add a
  *      task to the run-queue and that's it.
  *
- *      Now, if the new task added to the run-queue preempts the current
- *      task, then the wakeup sets TIF_NEED_RESCHED and schedule() gets
- *      called on the nearest possible occasion:
- *
- *       - If the kernel is preemptible (CONFIG_PREEMPTION=y):
+ *      - Now, if the new task added to the run-queue preempts the current
+ *        task, then the wakeup sets TIF_NEED_RESCHED and schedule() gets
+ *        called on the nearest possible occasion:
  *
  *         - in syscall or exception context, at the next outmost
  *           preempt_enable(). (this might be as soon as the wake_up()'s
@@ -6619,10 +6616,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  *         - in IRQ context, return from interrupt-handler to
  *           preemptible context
  *
- *       - If the kernel is not preemptible (CONFIG_PREEMPTION is not set)
- *         then at the next:
+ *      - If the new task preempts the current task, but the scheduling
+ *        policy is only preempt voluntarily, then at the next:
  *
- *          - cond_resched() call
  *          - explicit schedule() call
  *          - return from syscall or exception to user-space
  *          - return from interrupt-handler to user-space
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index f770168230ae..9b4c2967b2b7 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -89,3 +89,9 @@ SCHED_FEAT(UTIL_EST_FASTUP, true)
 SCHED_FEAT(LATENCY_WARN, false)
 
 SCHED_FEAT(HZ_BW, true)
+
+#if defined(CONFIG_PREEMPT)
+SCHED_FEAT(FORCE_PREEMPT, true)
+#else
+SCHED_FEAT(FORCE_PREEMPT, false)
+#endif
-- 
2.31.1

