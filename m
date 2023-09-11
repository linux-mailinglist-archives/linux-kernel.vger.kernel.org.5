Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A4979BB18
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354882AbjIKVzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243610AbjIKRYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:24:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C444F5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:23:59 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BChXUL030265;
        Mon, 11 Sep 2023 17:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=+W6P+bAsLskUX092qNtS0WyFUj9cJyE7t+KivrSKlm4=;
 b=v7hZ6KqKzBqmf048fEm5lVYEWdfYKsCsnH1FWMZ3IBZGCVzcqhQ3VrCyUqkbwOH0Uujc
 C3XNHNytSXruVUf2zh7mE+Js3NUPmtV8foLhOqmipiZB4Cy7N5iqk1MCxWvuzg0eDSXv
 LxANWnPhT5IT6fKS/USkjILOb+euUQ+K85xPFYZ4i8PoczGE6ZX/u4k72/2ARXsPNWvI
 mBUuSw1JjzDwcE1pZZWvX8HLpkAwET1vkXNVU9vZtOiofpExd7kiN3df56vaHMOHL0su
 Lo1R/HKUzGV8xME5otUhfL7G1LnFMOVBQ5S4WCVjG4pK0W34zBlSjsMRklRfNiWEqf4r jQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jpat2xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 17:22:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38BH53vF004350;
        Mon, 11 Sep 2023 17:22:38 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5595ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 17:22:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X76afA+h2A0+6yrZY9a+SlXGakhbJT47ebtcu+YDoDOeOfa+U8MQTlYQu/WJpC9NhRyKH1jtm3BamWkB+m8SGMdGKhqXqnBkkx4/vkMelGibHR0NjY11DmIOn7jlGHy9ocuh1Dz016Ra64/L2NdFKRvIOv8dFgZc1YU2xwMgE9sVH9RTHsCcB/pWYZMbd9Unhv0b/YW7Rbs8Kk0VRCyb1qYO/jtCFzcL3mkl7e0yMpVQMGDXyWHcyHOGUyEBGS6G4jFu5c2aq2JeMGlIh5urAzpX3lCLfVxWTurLlbmRAaV8AZqrOWWqzygNJzTyjafFCnBrKLyTeXR/fZjb4jEypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+W6P+bAsLskUX092qNtS0WyFUj9cJyE7t+KivrSKlm4=;
 b=dsrr2JvyKVWc8X2EGHIezpD6Fs4Ln2OxNTXd6cugDDMQ7KDZIgwVf0NdOxQSR1FvAKnWjxt01scaiQAsBNVGr2mGYYkHT4UOyLw3+ToDQwbY/c07003vcsJQEFWDvtHkskU2rYu3jsqf75zkGUlqZfTdV/E31msPLhUDg3eVu2mN+gwNVkmbp5WFeT6Vw+x/43X2SS4gYjNGfktXMcZ+kUOQsCjwpzVa6bQ0q2kB6qp93QD1nffsoZpdYMu+p927hFg8SM1vdFaJUGq3cRFfYhyz9BsGkpV4awxy2mw7V6CDAMM9Y1nXYQrtrABGqCZ6TiRPNSjZUOpy6bbZdgiPuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+W6P+bAsLskUX092qNtS0WyFUj9cJyE7t+KivrSKlm4=;
 b=jmkhVtKdBg6dCJRsjaojV/4QEKw5TLRwIw6gtS9iKCxs6wZEqO2YhBP7eD0MkpHf9YXUblfnORI3hYLdq7z6c2rZ3g8iPqq17nJUCE9Uji4RzTKDmjp6IFBXHBoX8wmZpeGhK3S4XimAw+mPTxhK073haMJpKZj1i5F4aAHcCD0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DM4PR10MB7526.namprd10.prod.outlook.com (2603:10b6:8:17f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Mon, 11 Sep
 2023 17:22:35 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 17:22:35 +0000
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-4-ankur.a.arora@oracle.com>
 <ZPsdIJn1Ef/3uNpL@casper.infradead.org>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        peterz@infradead.org, rostedt@goodmis.org, tglx@linutronix.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v2 3/9] mm/huge_page: cleanup clear_/copy_subpage()
In-reply-to: <ZPsdIJn1Ef/3uNpL@casper.infradead.org>
Date:   Mon, 11 Sep 2023 10:22:33 -0700
Message-ID: <877cow1v6u.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0154.namprd04.prod.outlook.com
 (2603:10b6:303:85::9) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DM4PR10MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 25680709-875c-4abd-be47-08dbb2ebb08f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prdZx7Eyrb4O9FkRgbtasz6hWYV9SaiowRVO0Y7+Exf/RP5jJFWkNbjIsbz/iPc90t+YEyhm+AX2+hmKo/+4IZUGXKdM+v2LaUGKhIrNiotcvsjCt77fp0W/eGI0r4paYnWcbbXqCaAlMLduHHO/nSOLty3Xl/DaOrw69Tc/RjXlzppd7CkHG4XG3x7ihcg843a9yiZP40/oyFgLdZBxnIUh+M84rv3L0a0nmipJiBeGrOnKRVBD9A8I+YIG35HUqdATsE6YfYUVICGQm8OoG62aDxETskTQ5hMW7BjOJ5y+aa/jnPHA/d8qgU6WNUopoWMA+OiJ6QabJ4OXb6Rbwa2vwDvWsIH2gM+SzGVHu74Nj226XLWfDxGFbY7kfr+SsG9NOySVOeJ8LpwnvJ0EGf5AOm/kRoSXZBYd41t2xKIDHbIZKcWXNdliGZWEOTWPFM99QfUtQ5SwZXLB7NF8rwn/gB+K9hJLrkqf5E1umFGdkxK7nRwPf9w4AZ3oudCKl9SZ6b9fQ+Udt7Pkff9Vp9yUl8BQ3LyMYQdxovSeX8MPV1VoprgdyKwcqbwbi9WMRFHwjGgzdVwxntkbDPaXbsIZH+5GNcVhaDcZrF1ZcU8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199024)(186009)(1800799009)(6486002)(6506007)(6512007)(478600001)(2906002)(107886003)(26005)(2616005)(7416002)(66556008)(66476007)(6916009)(66946007)(41300700001)(5660300002)(8936002)(4326008)(8676002)(36756003)(86362001)(38100700002)(316002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TTt18jzEWuoKOdI99BBv01LBznA/XV/HdxtWcCuXqsHMjLy9M1tQmlM8riCr?=
 =?us-ascii?Q?yxKnd4xu5dx9qWJXDBE7EgC0d2bPGuUALKCU4KARXcn/gq1i8ALONzC3SneC?=
 =?us-ascii?Q?Jfr5udx0TS2YcNQ8Qo+dOLF3LAVbiuQTmYCOfTP1O4zpDlV3YqHYhtcHN2V1?=
 =?us-ascii?Q?EQV/rxzdTUZQsDuOSalsdcjSO5zoWDVGuEOHk1Pf+GA4d64eEJHljMjZ9TJd?=
 =?us-ascii?Q?S/F7OpKMSBv4fAgZ83GG/e2K09yp15s4cAriEdEJ6oSF3sZP1wG7VO5OCOPh?=
 =?us-ascii?Q?MDbByc2dMTig1CIb79Oli3rAB09FrhjoqZF6MRd8BLIgCCwdlzWdnEVfoz0V?=
 =?us-ascii?Q?CjpUEju4Ec3k+NpwVLpEayH+Jf1qeqZk4fUcpt9CDG3ZSQneQ302cz4nz13q?=
 =?us-ascii?Q?eu1aCDFJmeefVJv9LqRO2tEq7vdi/4rV6907EwPsQFtGBOuWL775y77IZlKY?=
 =?us-ascii?Q?WsHUo0daR0WtJpAvhIjzmSS8sV1+U6a1kAMKPKVsgiUxl+WWUDYrPPc5A0/x?=
 =?us-ascii?Q?d4IWFnbVMCcChQ+Yfp/+6o7rhNkElNN+xNAhBTYow8bpjWyiiLnfvvIeuaWi?=
 =?us-ascii?Q?2ftF7onWn8uCbhWx6VPFKVIFahj1yqU/5BQG+Cm6wxxtixTtHsD4egL9esrc?=
 =?us-ascii?Q?qZ1LMR7T8fmKpPimTt+JWz00CKiPDAFQjOdnNk3/R5XgvAtztTCcbFlAKbqZ?=
 =?us-ascii?Q?usq2vtI+cHDMu/ppOpjap44Iy16cz5GgVMTLlM0MmGtEbHBfTXwInXmMuGqB?=
 =?us-ascii?Q?x18fmRVMeV7NEEY3mU3Rb9ZvhWdeVWiD8WNmpAFzPvP3CQq0kU+OlB64XVxK?=
 =?us-ascii?Q?VEtpw/LiGntlZz/HbKMeEXpqtB5d3VK3LDi6y5TJICM1rpmEBaox80Z8uuVa?=
 =?us-ascii?Q?gPoUXQz1sa9SvbaQqreaJk53qnLKK94hojAm57GcIhPXAfUinhPQdDNoK+nq?=
 =?us-ascii?Q?KrwVqUs7eXa6QU1IVl3Zz6ewtoe/tucZGlhalvJjW+Ac0pmVIj1A4eQf0FC9?=
 =?us-ascii?Q?4u9hW0wwBuZIacQtSMjj1jttm0cjZNj25sSKzLmCTYSRJ1jj89G5+MuXLwjn?=
 =?us-ascii?Q?x5T4UWzHMzEzQUU/Ye1wlMQNcMlvQVlFjO4qDLI8+LraG4KqtKC2sJtZRWI8?=
 =?us-ascii?Q?FoSnwl6Q9bWsV2OBZ9jkPJf8vrTqqIIZLtxfoQJJQJBFy6FanCENzdtPAZew?=
 =?us-ascii?Q?94VL+3XpvwvYEV4EhGplRuygf6+XqnosF3VfsXsz/Gj14D0TcD630PSoWYj5?=
 =?us-ascii?Q?EmocnykrrEiO0YW0tk97Z+e8pwy48GiAcbA8HDtJl50wD8UT3jVo1K0lTT0u?=
 =?us-ascii?Q?Gvv3MV4EugdInZG/UUEe8ojUupD+aP0fb8xhaY0G4vEhO6jsB1nkKuHCKg+r?=
 =?us-ascii?Q?gw9Io/XW1xHMNG2JZyZQuJUGmnqNPAqCtyYMReO6GotC2ye8O8kakpQclvrC?=
 =?us-ascii?Q?nHcC8UT8ZgXw9CwEB+GoAiKODLs1a6rZpOEzcgXjZUaI9BsTsyAqsmCtYbo1?=
 =?us-ascii?Q?QCKP/XwLybJZ+TpdT85aU/aRG8xevdR+au90GNcusuCOlYjNAOLPGcIRnaLv?=
 =?us-ascii?Q?YUzF2wikAMnP8n594zxaISY7IZISENUMzqazSv+f7LLGKKG9HY2wUSMdIqVC?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Okis26dMk2+pfXMWh43CcM6x93R+St69q3BrQMBGXNOWWqw6LWXhH+jvHODA?=
 =?us-ascii?Q?Ji/AxZmqPRkkGdhNisZJbUO8qSdrH6Ug3yG10GPQ+pKoD3gCDfWl++NLVgGI?=
 =?us-ascii?Q?Cf0Qxg5QrMK5F7FHYUtfy3gDcC1XvYlBIu1YuiA/f6jbjN3xduXNrJIugyuG?=
 =?us-ascii?Q?KdIytWXF1FC/z+utzg++QsF2ilHROJdpODkbnSUwdoFAka9DZO0b4b4tqN5o?=
 =?us-ascii?Q?/mA0F0K5e/MCTvTccNXuTp9yOFvFvGijJhkeh4J0i3KTc9utJFm8rfcGk4Aw?=
 =?us-ascii?Q?py+Tut+1Ys2AKh3Kc9yujWyjE7zYiKGIBHsNCq8ywYEd24LLKwX0/6tms1/u?=
 =?us-ascii?Q?bBm9jdGquTgTl0uYPgILvgJvlsUnjCdVWwsJLEp1GSKP9xQtwMNrtqOoVOkN?=
 =?us-ascii?Q?2NI5X7lm2Q8Y+d6wRcHVgqyiWQQVgzHS0q8FX5dhxyd7VuMf/utDK5CACHZx?=
 =?us-ascii?Q?sykop2JFyfZyUif3Drt65uJ9vp8K3nsoibdPiP/hZk2CmMMeWob3rSKYHtyV?=
 =?us-ascii?Q?Tu35+XFkH0UeiM1pc4i7cgRj76lUJAKGafxsr9gTYg7q9o3o0+Sk8S1EBqXO?=
 =?us-ascii?Q?s8wjIIQGUIZuAG5iPo73Wkplwugk7eUj3PP0Yj3Xeo0NnwaWmPwae6pVAzdP?=
 =?us-ascii?Q?+Ck6g7ZrW1AxcyVV5ta4Z/7sqD3MUl8WjM844dBrfz6iopE9nWn8Toub+B94?=
 =?us-ascii?Q?9U/DyZI58Ag51re8q2G1HLAI7yf9bNmFq5BnfTP8v0PII0BpLpIJzqxxMSEj?=
 =?us-ascii?Q?yrMws7QZwHXVTEJpiPdFUvq9gpZv+RhXW4H2QZt3+y05RODcqOhCH/fMp1C+?=
 =?us-ascii?Q?SzkW39miZoY+awbt7i3+aK37rqHKRmE7FP06+9KuzSUgtqRsGr4UU7Cc1w7z?=
 =?us-ascii?Q?OK0ysiWpL4/kD56D3szuPD8FFp53DCDNSSc3li5MjSZ56A0qZGMlsMp2d37s?=
 =?us-ascii?Q?CDoCa5IpUzcuB1uEslryq/OwgVMxc1ENl7gaRin/Xl08tiqVR0X5lUH85XkV?=
 =?us-ascii?Q?yzi7uzQifthhGYCR4J0SGWN+6/pFLaIZtJIB9nQ8saL5/rVUfg7mPYZ+VeCS?=
 =?us-ascii?Q?gT8lJ6geZkS0WX0mLE6iCMv43BHWYRXESE7gSxvGwsqQcnNzhqshH52SKaCE?=
 =?us-ascii?Q?1NBOYWX1xkw4zIv7FsQbLcvrnR4h6yFy1qwAzE1WDyblwqZ0yVOPPoA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25680709-875c-4abd-be47-08dbb2ebb08f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 17:22:35.4687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6K2C7PPuTcOYlwRSnR52fty/5RPc7Ym4AlQobMhuU8uavyGaZ1mInVBhaxPJaIuQXRkDHhpU41igOYas6np9ZnOi1Wf6dIHVoSJvPOTj5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7526
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110158
X-Proofpoint-GUID: zGbaMngwIcUOAChws3OAvQMontOvnP7l
X-Proofpoint-ORIG-GUID: zGbaMngwIcUOAChws3OAvQMontOvnP7l
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Matthew Wilcox <willy@infradead.org> writes:

> On Wed, Aug 30, 2023 at 11:49:52AM -0700, Ankur Arora wrote:
>> @@ -5945,9 +5935,7 @@ static int __clear_huge_page(
>>  		/* Process subpages at the end of huge page */
>>  		for (i = pages_per_huge_page - 1; i >= 2 * n; i--) {
>>  			cond_resched();
>> -			ret = process_subpage(addr + i * PAGE_SIZE, i, arg);
>> -			if (ret)
>> -				return ret;
>> +			clear_user_highpage(page + i, addr + i * PAGE_SIZE);
>
> It's possible for a 1GB page to cross a memmap discontiguity.  This
> needs to be:
>
> 			clear_user_highpage(nth_page(page, i),
> 					addr + i * PAGE_SIZE);
>
> (similarly in other places)

Thanks, will fix.

I see that the pre-patch version of clear_gigantic_page() does the right thing:

        for (i = 0; i < pages_per_huge_page; i++) {
                p = nth_page(page, i);
                cond_resched();
                clear_user_highpage(p, addr + i * PAGE_SIZE);
        }

But, the clear_subpage() does not:
        clear_user_highpage(page + idx, addr);

I think that got missed in 14455eabd840 ("mm: use nth_page instead of
mem_map_offset mem_map_next").

Should I be sending a patch to stable?

Also, for my testing, what's the config option where you would see a
memmap discontiguity?

Thanks

--
ankur
