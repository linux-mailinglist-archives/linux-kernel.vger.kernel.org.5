Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5880279D7B8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbjILRjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjILRjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:39:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3A4B7;
        Tue, 12 Sep 2023 10:39:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CHBaxo028544;
        Tue, 12 Sep 2023 17:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=ZpqraFObbtq1onQwxjMSojjGEL8CXd9bSCmTbUzaEgo=;
 b=NsG5ZELi8aruZRUOB45QM0pib2kRb7gaXgfJOJ1r/ej8SawX2F7G8AZMOG9JEI8P7/Be
 pVJ8sAWgDqC4FigwVEwb8F8CS8iKa/7mz/rPsAPhNDtIn7LURE53ccAwPqTADpAle3T7
 MtXy1zcqmYaLkVYjcNFmi4g05WzvIBCpSiOMpMCczIVMQwJn62Drjr4aDC+kipmjwLXM
 o0j7Tdn8lejpAmKZ9SQq/uC4kU4cRgYzi+W3uQCeGMM2m6YEOvWhKoWof5ZoGdYLsgzf
 7Cx2wcm9pyaHt9ezX6MkXPx0J2yZelKFq9KNI/AA89wZz4doQQQdqBD6ublqtXi//adN uA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jp7cjx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 17:38:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38CHWC7V004476;
        Tue, 12 Sep 2023 17:38:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f56uj18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 17:38:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dkw2RmsouZdfKPOXVyjphUWkX01YQDObF8OJJ7sIz3jwrc3zVKW3CVYaN4aHUsMI0g4TsE/tgL8R4i4+PGfslVSVa9r2DZWU09G1KK9YRkFqlGBe17hVOVIeIpRI73329pVSjuq0WvDzvxabOlcw+efx5cz4Wh2fYGC9JYGNWA3J27QeJVyc9jFO437cLHtstSBspebh6hKi3JRg8DfLkYfu86JnoXGGq4i6QIyqnw6Ad8NaGIVqdQrEwJyBWDFktiRbCjZ8ZlPi2cs7doigMfpl6LfQEswDiJaWLClw/MfVupHl4xcCTAnNSjdSQnC7D6ef0Jpn/E4mGPX4UQjSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpqraFObbtq1onQwxjMSojjGEL8CXd9bSCmTbUzaEgo=;
 b=AUs0Babis//XLiX3WUgi3K4suzi/5CqczSrUR3XWGPwYvufemsH24ha+ka8vM1LhJGLe/RwxPP4lW2QJiJ3RN1lSGEM/nR33pRWduWEdANi0V/SLAi0/4NyaRCRy0ZF4kCA4uAp/31Vls6nMEg87rLOHBm5RaVbhPBru392+S/WLXFwcXai3Cw9fh81J+HDoSAqSMPnNnZIBMAtUnUnqc69tFOuixeYyVy0Tlc/VCUntIAJvQGPNB7o56elXwfbURWC7+wrf6GWit948Q0ssG/MGWUa0ZnX5HJs43JagMRQDbiec+kk6HsWPnOFB74Xm7/+IioQUJzN8VRQdE2FU1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpqraFObbtq1onQwxjMSojjGEL8CXd9bSCmTbUzaEgo=;
 b=WQZxdA59LDqUmEocuwcDFHXmvi2ZKIm/qFppnf/BcUJt2PevzCvzOVD55zYOvVn15adS3tOFkoS34scSNDvFuyUXk/yJd7XVukMDcpp7c1EuYSHcX5fGT6kgaqy++8Gy2DY1FrHhoCtfrbrIMzMkwjxa0/kSXdGUfwmFV7of13M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4454.namprd10.prod.outlook.com (2603:10b6:510:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 17:38:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 17:38:37 +0000
Date:   Tue, 12 Sep 2023 13:38:33 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
Message-ID: <20230912173833.rjrc7zpnvk6tcveb@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>
References: <20230911235452.xhtnt7ply7ayr53x@revolver>
 <33150b55-970c-4607-9015-af0e50e4112d@paulmck-laptop>
 <CAMuHMdWKwdxjRf031aD=Ko7vRdvFW-OR48QAc=ZFy=FP_LNAoA@mail.gmail.com>
 <f9b0a88c-8a64-439f-a488-85d500c9f2aa@paulmck-laptop>
 <CAMuHMdX89u6wL9W+8ZOn-OTT1FreYjEqYnvEip4Aq3k1gOP0EQ@mail.gmail.com>
 <62936d98-6353-486e-8535-86c9f90bc7f4@paulmck-laptop>
 <20230912135617.dnhyk4h5c555l2yg@revolver>
 <9e85adf9-2e1f-4bed-a58e-9ca629c03579@paulmck-laptop>
 <20230912154423.gcb5rzwzh4jbcaw7@revolver>
 <2a4ec37e-bd31-7863-ff8e-1720c62213a0@csgroup.eu>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2a4ec37e-bd31-7863-ff8e-1720c62213a0@csgroup.eu>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::20) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a743d6-2a74-4961-e75f-08dbb3b71855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: emuxISe9pGP8o+c0rBj4lWsR3H/K5qx4ifJO6UxuXpAyApdh7nc9mCp87UTH5+O8ZVzQq5ERZuRG+TEjqihM+tbvcmutR0ZLmax5R60GVrkkZF4tDCXe4N1ahyvBq/b9xpyjcXsDwxDrqJOwfKpbiI8ZhxZ7bH2Gel1UgKFmzfmRUSVyDNLzZw+h1tDrZWFAupaDkHo0IJiEffkUnqjlWSC65maFzD9j8dBz42JB2aD7PW0k/df73zbKkizIZ8nZgus/M0shIZxFW9nLOOT655qg4aXW915pnM8MkQGzWIfpCJNebHQOoNf4AAzPwSe2uKLOIVdq0JZPaHLRq10URlRYHDGL//H60cuQFHG6gA4H46VVR/lqK31TX6lBq0wkCKylkOunHM5hJIW7kGyx/52gaZT+/i7TzmCR+E+TArgOaosN+Rp/A1/zGNgaBZqMXIKjfEfep8D/osjwpN/3LwgV/el3/ZRpsIFAd0uFbLAH8lchzTlJk0eteTaOyaBeBfwOi0OGBGeivGgitfEA7ppQU7ECkxecQClOUJLefV7UwJ1W+NJCqVOKjD+3nbi8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(39860400002)(366004)(396003)(346002)(186009)(451199024)(1800799009)(66574015)(83380400001)(9686003)(6512007)(6506007)(6486002)(26005)(6666004)(478600001)(1076003)(86362001)(38100700002)(66476007)(6916009)(54906003)(316002)(7416002)(2906002)(66556008)(66946007)(33716001)(41300700001)(5660300002)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?po8WGDd47IbpIvrCLV75CIDzhxNCaFZgKLgVubP3EHfAwLxK/4uv9ZGKPB?=
 =?iso-8859-1?Q?pMBt+FUhk/HKT5Q5UFveoOSSJUtOfh7A10Pw0q1npKZSl6MVeDFNwI6jhd?=
 =?iso-8859-1?Q?/4xDa6Fy+Ybg2GD+WnbV+HOQni+6We4pBxskKjIrpmP4MyHvu6+prBo3VG?=
 =?iso-8859-1?Q?veV/Suv09/u/1mJsttJRoQHfX9AJrhkD9bwiW8vNuw/+nbrTKavA8tRpDw?=
 =?iso-8859-1?Q?txC2dTNWPZ7JtTjZXdEFhxZWbNAVDth8U3qiyVPwNujFQ3OCKIXbv66P65?=
 =?iso-8859-1?Q?WGtd1Zc+ZYdzN3bQXqPJV3bLgrLNs1RCIqmjBIXgiz8OrjFLoD8TJKpuiD?=
 =?iso-8859-1?Q?kF9Q4k4YK4JsnJe06shqpNo8Wju+u+Bb+3qYaxvYxYeJc44AXEDANNu49V?=
 =?iso-8859-1?Q?xph0RD6WS7F8MG+CH2r/GPI/w6wxXGCaAdjRItXTocQr52ddXlQRdvKsAh?=
 =?iso-8859-1?Q?lCyZg51m0Zx24vfEUsIZrsgnqRYOT8O9awJLyEjH3e6UIM43zAhNbRJOlm?=
 =?iso-8859-1?Q?k+8hB+kXDRb9uwCfBwX3/rUuEjdiDgabn2/sKXydNgh32FfeF+3g7TVui0?=
 =?iso-8859-1?Q?Ih2ssLxNOprAWWd6ueWqeMWmqRbexogC3eaIT3dba0iuHjAeyu8wc127et?=
 =?iso-8859-1?Q?K4cMsdJOwKOaT5h7SETY17szauzL+MnIulxjmPmILMTr3J9K5q7ugXK8Od?=
 =?iso-8859-1?Q?RNgy8sTkNvGF7mL8uIIFl4ZpfRybt/05tX6PK+pDvK89HqoxJqCC2ANzeS?=
 =?iso-8859-1?Q?Dc5qnicUT10xPnSRbOwEhQsTs6gJitNvrxnp3Wq6VpxvEoBGQra9SYTr2A?=
 =?iso-8859-1?Q?eZlSZ1AVIWkd//D98H47wAMeN0c0FBzeDt5L9z1wzMQ2q2zRgUdT81/osF?=
 =?iso-8859-1?Q?EXENniIEyzmPomPGR17AhOdQgBfmaQc0u0EazMAYeoN/PVF4KGwTiScjPI?=
 =?iso-8859-1?Q?kkVEQ0gIlFIINzjCZqxYu98EDTq6FLrodsbeVoLMn2mNDT/PODgYxSFJe+?=
 =?iso-8859-1?Q?O8Qg8tzc9FASg2ZjzY26m7yTubumbAPUm/pee5joa1WiH8dR4lhELpRsOg?=
 =?iso-8859-1?Q?a0Gvfn5hrNSPvbY9PhD0t1zI/gd4ExICFUZdOv1/eQWcG/91iBMcm7yfp4?=
 =?iso-8859-1?Q?VcregQRtoLz9sFvhFwRxTTaQBUzcoeuh6DJsD86r1hOvKbIteMhdesVI9A?=
 =?iso-8859-1?Q?R7V+rVAlDsOoo+7dFcL1zylYP2/G3IRki6ca0z+D69hz8dIfi4sxAexrht?=
 =?iso-8859-1?Q?HoPkVjqeDmxqR61SjQR9Bsi6rIanWOtb0RSuEZraouc6rVd5POiYg81g5d?=
 =?iso-8859-1?Q?Us0ZzokP3l2cK9vcLu9W5797zeEBcFUXce9GdXCKUMN4+lYsYIpvdzl86X?=
 =?iso-8859-1?Q?Quz55LLmQrSGarVA8yhB3f0hNh/Cxq0EvnM8KT9yyfb7A7nBGBLnYuLw2K?=
 =?iso-8859-1?Q?Q+NvcgeEFLzz7pvn4Es98A3056HD2zE2tadJpB5WoDsz1pXm3wDMUTCzCx?=
 =?iso-8859-1?Q?6VFE6HwbUNvnAnS/cxNbWD+PqLG4SGewjr86VdIrt5rYCIszOwWATRXAge?=
 =?iso-8859-1?Q?LXqCm2cvStV3MTzLObTVSVcFJo/56arOm0QZF588FTjWWC1GmXYNrCleWm?=
 =?iso-8859-1?Q?YiXaR6wtnrHgP2xUKfsZxDhJ+v4saMWFfkGln9eWrbY4SN19By/2djkA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?SC0Qwr5m19NpvnBh8wYTAnHy9CDWt4Cd1T4KUn/W6TjdOHNZo/nEPvcyDn?=
 =?iso-8859-1?Q?uZcDfw3mw+UQ0WeRD3Pav9kVKXPWWEMQo4wBuDC78Nu/xOw+Wfe3jdarDU?=
 =?iso-8859-1?Q?4o2FPv8lPxoZOsCIPhn+w3HrGDPsSgrFimtd3kS6GJFe55beaUO9lGN46e?=
 =?iso-8859-1?Q?HHxzsyGyy/oRDaW10fYqMChbswFAQM5N5TCPniIZ41T88A/GwA1YwfK/lQ?=
 =?iso-8859-1?Q?hm+BSZi/4VYPkIJ5UUPJhHjeS2Ng4rURLUsINmtDLp+vzRlyKKPn6rJNbz?=
 =?iso-8859-1?Q?4RvTeHRW0iCiFmaUhmBEZCyczzLMW3DN/2qpQ2LW5Q6rFmO3j5SjnLTJST?=
 =?iso-8859-1?Q?sU/s9l02JwLXwqzvSjtx7lBnIqzdydbmWmVIAP9So9UQOaPEonwHIW7Fgi?=
 =?iso-8859-1?Q?pm1L47NaCd5Xdn0isP82Vudyde2mIJgVuUWketb+XVEuhU6Q2/QSPhfYZV?=
 =?iso-8859-1?Q?nEIMfNHCLpU6EZG6j8KL+LTAjPEK/OOL9o1mY6GZcZqxH+pLFunTo4YoSf?=
 =?iso-8859-1?Q?ujcWSLBVylALxfCa6fuNvhUnMW0LWwV/zOG7xDlArtwAAFmYwCq1eEd6Vj?=
 =?iso-8859-1?Q?Swj6hkgXPY47SVFLitjOOb6PiT9UzNGd0Th7DBsHCUBdf2qc8fwOhh6q4D?=
 =?iso-8859-1?Q?ay0IslQooqmwI2zvMjg92vo3sSyJt/JayF6rrv1dA1aOWAIA2nbWa2cK/K?=
 =?iso-8859-1?Q?O4BzrXbTb9gLnhBq2XlMdO4k8XbQ9DWofjp6FeGiTC0Xq0SXfhzxpRyaFn?=
 =?iso-8859-1?Q?baOEJwd3jdd4WZA4dvvqZf0zzO7zwKXF0ojMa9ajQE6WVe3GsazhH1Pa80?=
 =?iso-8859-1?Q?bHC7YmbyeQ77wKSqQSqzPv/Ljuhrqf101elhGV3muRr5m2n6DkZTArk+Eu?=
 =?iso-8859-1?Q?IyZyJ16SOeq4i8c3ptb+3hcp8B2lv3NMlTQzUzsKHrnvkjBn71u4uv3vDI?=
 =?iso-8859-1?Q?BIFMTsdyAtSD+CC93LuuEp/FgIRyEtERK/IlpsNfbLKbSAR2fnUHnNtI1+?=
 =?iso-8859-1?Q?LIDwcBpMlk+Nuks3uR9WzldV9Tpgzk+5likZLsewUMKGTQx/jfUonbwYLI?=
 =?iso-8859-1?Q?jA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a743d6-2a74-4961-e75f-08dbb3b71855
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 17:38:37.3149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpi/gVENBrlt/o0bwmFQ4CdWczBIO0BYeXgBOY1BvjoNlQ4WlNTxMqqS+lVGLWvd6l6vZqVDoJ2JlwgEo+wtvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4454
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_16,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=681 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120149
X-Proofpoint-GUID: 3ms9ke8TOmglvG1iQh4-nemjXo_yTTCF
X-Proofpoint-ORIG-GUID: 3ms9ke8TOmglvG1iQh4-nemjXo_yTTCF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Christophe Leroy <christophe.leroy@csgroup.eu> [230912 13:09]:
>=20
>=20
> Le 12/09/2023 =E0 17:44, Liam R. Howlett a =E9crit=A0:
> > diff --git a/init/main.c b/init/main.c
> > index dbe1fe76be34..fd4739918a94 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -696,7 +696,7 @@ noinline void __ref __noreturn rest_init(void)
> >   	 */
> >   	rcu_read_lock();
> >   	tsk =3D find_task_by_pid_ns(pid, &init_pid_ns);
> > -	tsk->flags |=3D PF_NO_SETAFFINITY;
> > +	tsk->flags |=3D PF_NO_SETAFFINITY & PF_IDLE;
>=20
> Is it really what you want to do ?
>=20
> PF_NO_SETAFFINITY is 0x04000000 and PF_IDLE is 0x00000002 so
>=20
> PF_NO_SETAFFINITY & PF_IDLE is 0
>=20
>=20
> Didn't you mean to do PF_NO_SETAFFINITY | PF_IDLE  ?

Yes, certainly.

>=20
>=20
> Regardless, with either change I don't get the warning anymore.

I don't have it fully tested but we avoid getting the call_rcu() setting
the TIF_... flag by avoiding the task having PF_IDLE set in the flags.
I'm not entirely sure if I have added the set/clear in the best
locations either.

The largest concern I have is that this could potentially change arch or
platfrom code if anything depends on this being idle.

>=20
>=20
>=20
> >   	set_cpus_allowed_ptr(tsk, cpumask_of(smp_processor_id()));
> >   	rcu_read_unlock();
> >  =20
> > @@ -943,6 +943,7 @@ void start_kernel(void)
> >   	 * time - but meanwhile we still have a functioning scheduler.
> >   	 */
> >   	sched_init();
> > +	current->flags &=3D ~PF_IDLE;
> >  =20
> >   	if (WARN(!irqs_disabled(),
> >   		 "Interrupts were enabled *very* early, fixing it\n"))
> >=20
