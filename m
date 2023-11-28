Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692567FC34E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346068AbjK1SdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjK1Sct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:32:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491EE10E2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:32:54 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASI0rgs023952;
        Tue, 28 Nov 2023 18:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=1UOgIpp8eQ8gDWfNNLlf4zIWapFYj3qQT4hk82XG+Uc=;
 b=hcsOl2T86/avex983az/lzAiKdWn5Tfrx50fOuSlDN6aKEizwbrBgYsTI0xoYnzjbPw4
 oQVguldjUUhg+j7k4w/0NJUEKz0zqpIMwqAaSoIlzziex3DCpCnC1q1DQMcIH90UMKCj
 9Kll6771fbEfWSvuJTwP/78f5LeIl0MANNB4+znJFAN3UJ5Z75dPa3KLeADe3sMGaCIc
 3mkFKwKxzu4U/q0Vff8YkGJM7ROWilRFJBENddrQSOT0CvTZCz4qbl40oSKEcr/wNWJr
 wa/Evws6A0ANeA4OIB5gKJu/W0JfzQzmw+5R7W+UlilrfnIRiF8kAaTR1cUgqLpKdlG4 3A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7h2phbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 18:31:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASHH8T0013476;
        Tue, 28 Nov 2023 18:30:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cd3edn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 18:30:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jmo+8bq9el0aKj2IJTJBpLYjeoM0pV2RXwo8gX86g2jbnz1UXxlz80y0OSfu2WXlKwLLBuHmjNIlZJlqo77SnNw00pn4UGCqfjno1C/MgBOjPn3qUUNg2ql1R4x31+/8uqiQrpzXhTKXK/jnZJAe3Rj8B2TcGol2wR0YmlwsjPZ/pjpdAlDSy4ljtAG0y/RipUI6iXyam1tGSDZ2CLf6oxL4mwS/u+jwcKH3RRcbmOp+vBldPDj8vylwxUB2fbrNlkXOWTVnCtfu61iJmPqqXW0uo3v3nkYqyG+qT/8FOqYcHE0DK8dF583NfOLsw+s3lBqqsMaKHok1xeptdoJEcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UOgIpp8eQ8gDWfNNLlf4zIWapFYj3qQT4hk82XG+Uc=;
 b=WNoTOQFqKQuAXYWmLYQU5S5POMo4TD8TGUjXdZsdCYGAQnHDm3cJkQoGy19TJGll1BRQF97Z53i8aIBDmiA7G9ue3Sr0Ac3Eg3U08UrhNpfAK5JCb3ykulJ83lur0I0a+dNTA/61fui02Eu3r1c1RB2u0YgS25yqf7gvQqsci1SaiopH7CBoC8XZp6T2fNvZ0731b9kbP3mKp7RiTYPp5Ehugk1xyXTnKD+2/JReBoFpsXYUkdcA0S0dmGxPYD9rCKd4EP10AXjpZmatBQ2gDdDZSDdPjDxhjvArnjd3aHJXcZQF97yI7XB/hpq3q41Vu0bQ+McSyhVt5ntbXHxW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UOgIpp8eQ8gDWfNNLlf4zIWapFYj3qQT4hk82XG+Uc=;
 b=nD3bit4RLRoP+k0XNgACJg7dhU5Zxds9Ss2rY02HB1YVIm2RPTvZEfiybmq1FkoxNkN/fBamcVxo5/dySqXsm+aXxxpsm5PV+p3jnaHfzm/p+iRMrkPW0jT2gjqmSNNjXDAdOnYYKzt3WgG0FoI+KGHw4Na07UnP5BCv8Hk572Y=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB6224.namprd10.prod.outlook.com (2603:10b6:8:d2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.27; Tue, 28 Nov 2023 18:30:56 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 18:30:56 +0000
References: <e939c924-1dfa-4a6a-9309-2430f19467f5@paulmck-laptop>
 <87wmu2ywrk.ffs@tglx>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     paulmck@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com,
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RFC PATCH 47/86] rcu: select PREEMPT_RCU if PREEMPT
In-reply-to: <87wmu2ywrk.ffs@tglx>
Date:   Tue, 28 Nov 2023 10:30:53 -0800
Message-ID: <87plztvig2.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:303:b9::6) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a4ce1b7-d480-4dde-c884-08dbf04028f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76epBLJPI7Hh0KizkywJAhK6fY8U/zrpo2vQuW75CEaPRtCqi4/zUMu79Y4vrdKOfxKdAAsyHpHkmpV7m3RbDRThDAIZqyG5MRP/XfK31raLGPMSxA9Imqb1GgSlLQRK33M3+yzfqOoBAFqgXmPYLdfqvzGaL+mue6gdR4GCDTY6ZZM0bmznE5IeOczvt6Bm1kcRhkTMNjHyTOb4QfS1aUF5Cy4e8hnVbSmYpbXWVNzliEHOP4YUdHdQwBjaskk8GHJOXT21Zy4ebDaaw7WvAf7yfaBStvJwQ7WF3s6BBt4wN7rfBHIsrmXxXOj6iaAIP77iyddifsNzxBTWIaKZOmFEjxT5Yr4BBKRTs8yswaB/s7SnMgFxbzbvwesbOlhN2cASJI4RZ9iDoM6obrdrTlbcmHJwiDs+neiCvWhG+bH8RIPOWMDhzs1g/ainSfnM529P4s1yg2DChh/nQcdlh7vtezyKxEpJaiVbTtWi1epA703cyT7e3ypBbRGN4Y7BVFkjaD3IyD8hcMPmdt+W9AZWnICxBlXXWwdCis2aU5uOj1Ya7Wa+wK74hSfIpsNEXlNkGv93FEugYVWpdw3N6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38100700002)(8676002)(4326008)(8936002)(6486002)(6666004)(6506007)(6916009)(66946007)(66556008)(54906003)(66476007)(316002)(86362001)(7416002)(5660300002)(966005)(7406005)(478600001)(36756003)(41300700001)(2906002)(6512007)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qOuO/plPViPwQ0B+Ieqm/alrmWaqq1KSjxy2fwF50xOdtZBfjt48a1ORFCMQ?=
 =?us-ascii?Q?IfzyxiGfcdxR1bj1UxMjcmFK9hyK77K/IsSo2AajJcEd4cL0hhOJR2XkQVAe?=
 =?us-ascii?Q?PDATAvaYmKNbUXvVqvFyS1C0giihm3XQgBToV5IU1KdVG8m8Craj06hLDHUZ?=
 =?us-ascii?Q?iqSUxm5fqhTop02m+qzmshLpw2rdpcPzIsdYBlrFEwXSoQFCG9UCgjni8C0W?=
 =?us-ascii?Q?7/uIQ7mJSCnUp8bsqL27QGHQkqig//UOLxG8ocikqft+Vo7djWWdnrK+DEyG?=
 =?us-ascii?Q?qLmPsGhvHMBlNxfEsA/o1Fygl7i5G/Fq9VMJRXxRgaB5rjVjrVyvirARdCY3?=
 =?us-ascii?Q?MDSnfBZVi1sitasFmFKBEJ+pT/IKT71dlsx+ngeW4J1Q4yeSlKTrmOCuuR/V?=
 =?us-ascii?Q?ytYlpaLjcBmBPebhUP2hrzWZWsWsBr8UOa12I7UiMOx1k7I3Zs6gF8+CK8X2?=
 =?us-ascii?Q?8GM7BZjP6EJXdYTJUNX+Vl5XbLUbH5jE+Hd7m1Yd5vnDB3kYyq7XeJM/m05G?=
 =?us-ascii?Q?quO8HPWQtSkimr1yFhuzByrhtLegLWjaS3OloAlP6JwzzJQlD5/cvbJMk0qe?=
 =?us-ascii?Q?KCI07MgyuQm/1D64N7jOgviAUZruUhmOfGVsegMzuMRObGwraH0A/FCn1Zpu?=
 =?us-ascii?Q?T55u+nk+cNfVRy2goAOxfMHvg9vgbFM0HWFe7IJo7Dx2ff0b/xltWt3p+6kC?=
 =?us-ascii?Q?MS86RgawoKU1keULuqfyvOHhQGG9nBnjtF/iPQC9nUpzJ+ERPO4nMIv7Cfx6?=
 =?us-ascii?Q?BRRmOnyQ3Okx8yRMwxYj0j6Rg7tDg+v5qIlUW3Dg7O3gdWyEvvnBgbl4SRj4?=
 =?us-ascii?Q?t4mA2H8QI3rjqvKsB0ueDyMVL8jqWHip2BcVyJzEsoNL6AjT21WTuBhiM0r0?=
 =?us-ascii?Q?HB3TVMBazR1sTIYpxS8wkkDLh9avhUF7pGsxJdZsSj0TBTfIWEQM25r6tlV3?=
 =?us-ascii?Q?/krdKWR1SpKP+hjnK5+t4pcGKaoeLKanywNxhekcTamvWfYYCsfpZZpFqb52?=
 =?us-ascii?Q?TYZL5FI0kTjPt8ayAmufVQmQS/JtB6x2w1yCNSgen4iKU6OVxbnfeCLt6hGs?=
 =?us-ascii?Q?zZMtJt2+MvnyEc0AVbA7lVa7n1YKr+IU7qEVHec+ZBlZSs9o5LEfVaotVli8?=
 =?us-ascii?Q?yPx/oFLZQbq1h2poZLHtfGFO7/Z+9Ys/p3iMI3eLXYiKwW6i2eBS6KrSnzuE?=
 =?us-ascii?Q?yrCQKcUh+qJJ0jYeiqGor7/goM26Wg5owHRGpr58Oz9RYJha2GJXZFjypZXe?=
 =?us-ascii?Q?lXUMWjFL8p1LVGJwuT3+ki3aMq2g5XDKSr1swnISrInTYwO7vJO1WJb8LtTb?=
 =?us-ascii?Q?HqqF2i7XMARTBIeG9+x5al3GeAVe9UaU4+CKwmlxzJLCY2b8lClNmunOGH5V?=
 =?us-ascii?Q?f9lND/lC44Pl69VGLDpsKtvzo/XFA7osE+r+Wkm6gtN6jlzrAhYdZfvbiAsa?=
 =?us-ascii?Q?RmV7SODOMn3FJAhAOJEb9KC1LelOBqOlXqaqLGyY9S9WD5yNrKS/9AhLZ+Nr?=
 =?us-ascii?Q?edF2CNDmHdym+aMB2OCValqcrGSa5LvNZic9Mob1Zl5BMRC6EbeHxSW4M1k2?=
 =?us-ascii?Q?rNeA9nJe9zn2z2u/HqB1BEOPVQ434mfTVpeSU+2VikESYyAx9YgZsJ29SwV2?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PBaNtVubPq0OWM6Hb7yV1K/WW9HCpm7jVpNv1ZzUXqAqggGWBUMFbAPLD/nQ?=
 =?us-ascii?Q?m6bNPNj26suSx2xKieDqfXRcZzFN422PYr5nsYOLR9hkQ94JLnXKtK8A3GB3?=
 =?us-ascii?Q?ZP/3vftu2fjx7WlN9qiJ/AMQ1zyMJDR+eIXhEocJICoy9zFR8PGvWhky5rpS?=
 =?us-ascii?Q?YAKI3rlR2rKWPdlbxbuJ9n5Fmsg4524QCiuJ+cGqZPq3YRWp1hKzgOymWJuD?=
 =?us-ascii?Q?fWaQ9hKK/Cava8i32jRpnEszpQMGB9NfnVGIPzNcsgzedffKAfMBsbe0dkfk?=
 =?us-ascii?Q?iSjoBr7BdtI8DuBNlOseBvNeMdhG1X/CR9gQBvae2lN4VAL+PWpMHGWmdSbJ?=
 =?us-ascii?Q?X8nTzEUpJI8K1+SsTHP4yXNOl28+xMPxYgF+b+2SrxHInt8+XO84RGiMf+3j?=
 =?us-ascii?Q?wATV0EZ2jnarXKVGjMUy1fTe61pIdQ3BDp7588hfzL924vp+e0wfeYdEd9pr?=
 =?us-ascii?Q?9lCTiEBXpbenTvRm8rRGGu8/zaQ5dVAEsXDTJiIvclax+IoKUaEmuojEMNMD?=
 =?us-ascii?Q?HCN9tVB6Iz+Pv14Rkk7byOqFtyUNzYu7WsJ8TBnj6oyGMczb3gvRhHnqwO7G?=
 =?us-ascii?Q?WVSHpSELCgsrsH4ujMZ9yXU3djjQ/rdrteaWcJZ+5JyJ6rkxpj2Jr5trqYX4?=
 =?us-ascii?Q?s+RTUly0npEla2AHyxdS34pbaSkbz/DmP04pWCVG0a8TVBzL6a4BZY2H+1So?=
 =?us-ascii?Q?z57GqZRGR6wJm6QPMVRXPnu77OVD+L2WWPPwhWL2H1uGb4B/sWIyxusyoCj9?=
 =?us-ascii?Q?R1KtDaT6JmMcKJ9y5ROs2hnCyf7LoraPBR5HoNQioH/XjNK4zy+sQLNj7i9J?=
 =?us-ascii?Q?jANLraxMphwB7CwqL9rGwx13zkHg8vgPnoWMquiJqdMXsBIq0HXPqzz7H9ed?=
 =?us-ascii?Q?jVPewHKUWzUVdJO35dXPz+jmQqGajV6yTclXGOIkMA/adWGW9mPRDMp0UNxn?=
 =?us-ascii?Q?0YpJPFJqhlFHYJJaDH0Jb03qcJPFDslCpgP9c9KTS4bXIqWsTTLOaGHh/X83?=
 =?us-ascii?Q?cwYpl7XteBUOABqeT//lMwsN8EHAhF+n+kKkBF8M6nxNb7VQfhI2o1F8apfB?=
 =?us-ascii?Q?5iHhQap42m89ZsoKAmia6sOooxVLC/e5QfaAiNqYUWZXeteP9Kf5J434IMWe?=
 =?us-ascii?Q?Bvlx12h4EzUU7MWDL1vEQJj41VEmL5+SgVepUAFXLLQ4L+Pqp5YRCaR2iwzZ?=
 =?us-ascii?Q?JkdEsc+lac1Gl3NKsn+yh+Rmxwpd1T8wo/YwQV9ZxVJPMdnPHG91G8Z5dFEX?=
 =?us-ascii?Q?FBStfEtZEcK6b+nyfleeD7l/5SvgrYq4VnQmA1Z+xQnV1nFy7BUW+lUUMTG6?=
 =?us-ascii?Q?ce7BrTwfVO707Sh7MHuPiNlEFZJuN+obLKs/s6OVbYz4FKZZ+GRgCs1vGOeO?=
 =?us-ascii?Q?0jfvmElMZ2ZaZ662ou0ikcpz+2gxtjV1XKrC+JbAUUM6+TbOLcT2/mR6A+FW?=
 =?us-ascii?Q?oHp8UGFgn/L/Bq5VrAwpbhFABOsMYixwK/tJt4b8xYCea4KBRmgCt51NO8Nt?=
 =?us-ascii?Q?HnarEC1aylWFAQA6U7q5VMANs9Stit19iCbE7mHHCDH7O5n/jG8R5izdI8iO?=
 =?us-ascii?Q?CPsf07KC1JKHd4/BEc9T/fTxVziJMuNkKCPpnxmwKoxgYKrvqIZzoh0TalD2?=
 =?us-ascii?Q?VI9tWxEcOpHZrlIIOS3ZQ9g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4ce1b7-d480-4dde-c884-08dbf04028f6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 18:30:56.0400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JXLDBA4PLXcG1za6vgWYswBtFI1cYUiKVUTCqRbMucx0wqJgyxjOO1XgHcrFU3KikJYCD0lvyJ0DDuNSAYFRx3vklMNSIKTiAZcZ6oTjwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_21,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=728
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311280148
X-Proofpoint-GUID: QvSzIFae0VoYBC3lXGgyFo0--WNH65EN
X-Proofpoint-ORIG-GUID: QvSzIFae0VoYBC3lXGgyFo0--WNH65EN
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner <tglx@linutronix.de> writes:

> Paul!
>
> On Tue, Nov 21 2023 at 07:19, Paul E. McKenney wrote:
>> On Tue, Nov 21, 2023 at 10:00:59AM -0500, Steven Rostedt wrote:
>>> Right now, the use of cond_resched() is basically a whack-a-mole game where
>>> we need to whack all the mole loops with the cond_resched() hammer. As
>>> Thomas said, this is backwards. It makes more sense to just not preempt in
>>> areas that can cause pain (like holding a mutex or in an RCU critical
>>> section), but still have the general kernel be fully preemptable.
>>
>> Which is quite true, but that whack-a-mole game can be ended without
>> getting rid of build-time selection of the preemption model.  Also,
>> that whack-a-mole game can be ended without eliminating all calls to
>> cond_resched().
>
> Which calls to cond_resched() should not be eliminated?
>
> They all suck and keeping some of them is just counterproductive as
> again people will sprinkle them all over the place for the very wrong
> reasons.

And, as Thomas alludes to here, cond_resched() is not always cost free.
Needing to call cond_resched() forces us to restructure hot paths in
ways that results in worse performance/complex code.

One example is clear_huge_page(), where removing the need to call
cond_resched() every once in a while allows the processor to optimize
differently.

  *Milan*     mm/clear_huge_page   x86/clear_huge_page   change
                          (GB/s)                (GB/s)

  pg-sz=2MB                14.55                 19.29    +32.5%
  pg-sz=1GB                19.34                 49.60   +156.4%

(See https://lore.kernel.org/all/20230830184958.2333078-1-ankur.a.arora@oracle.com/)

And, that's one of the simpler examples from mm. We do this kind of arbitrary
batching all over the place.

Or see the filemap_read() example that Linus gives here:
 https://lore.kernel.org/lkml/CAHk-=whpYjm_AizQij6XEfTd7xvGjrVCx5gzHcHm=2Xijt+Kyg@mail.gmail.com/#t

Thanks
--
ankur
