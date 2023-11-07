Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F414A7E4B8C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjKGWLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbjKGWLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:11:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768F93872
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:01:24 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJODL032058;
        Tue, 7 Nov 2023 22:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=2NHODiUOiVcJ6jaf39wzOHNWkO2SbftqtZ8Ea9mPM74=;
 b=O09riWk4lGjWRPTY5sh/UcobntvG70Nx7X14C9zmYH0Kibw68zOm9ScV3yHnr28BLOQJ
 zPDXtrzQS14bYQqfN/eNy61Y44RmVP5bbgULNH16SJePia2RVaV/2sjl7Y9IXqi8lFSI
 zZxyFmSapFLHU/z9POOhZ5FoS31Ng79zl46l//nUrmb2+R6NqSH5HKZtcW4wp5t2V3qT
 EEBvzfOvxjG+6zL3YEXYbsWrSXUZuGmGCP/UXynA/bF4GRbG47UY7so1Z9rqOyNYPOGN
 8j3Rn6jQi7WuvGnM3K1z3nIvPmnXTnYELnGdcrH8zeVGjQFeXCZVQKSAP7SEiKrcCBgG lA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g2ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJBcY031969;
        Tue, 7 Nov 2023 22:00:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w221k5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Guy0TZvryUNgCRry2yDGl43hsTAc0OYQdZHY3qU731OgJOZ/N8jnhjGrBNPB0HMY99g8vtzrmbqmuosT3C/bMHvUUj4NNb/6WSXGTAY9aBJwRK44sCQ3pcoeCqPiWBD/XSN4RO1+8uIv2uckJVv/ujmApkm0W+F/+07n1qJdr6dTETymG/PAVyOqZ+IpNFQ3iBBeF+CgHj03BCkTafBc+BVQxSQ62IwIWkSaSKvCiU5/BUK0lVATzl/vThJcat0kwAGyDHtl8C1WaNMBZKM11yC/NOyAim6thACZ1YtQ2cJEoAKjSrEX6M6ORP9b29sEC1gFWq6ZFcP5r8Ue0SqznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NHODiUOiVcJ6jaf39wzOHNWkO2SbftqtZ8Ea9mPM74=;
 b=GrxVNkvbgHnSCnp7DB+kmgdasEcY2NXTmH4szPiIVOFesefb6I8CFcl4lo8Cw8qsqMVhE/lk4P86vA2vypXpSdk+gB+8V+WxBH2s5sEJwv05/+FD7UN3dZYpbjSIzXWo9mesi067wuj7V5dxM489JgUeA0JGj7+9h1qy9MnbiL1oDSxgNsnA9jYOaVcRQ99FLbYBm+BVOmTXkitmZK11H6J1ZCkZs9qlzoBXRduPU12uaUmWvtHpXB3iefXdP5TYoRVd863FI1Z3CEQhTufuE9bvgmEtWdfB1ioxiAiXeP1JvbcwSHbLVBjkAtWm6D5AYMojChCScNg8sptekcSohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NHODiUOiVcJ6jaf39wzOHNWkO2SbftqtZ8Ea9mPM74=;
 b=JaBAuW7gLbKiOGG+s92sNE9Syawlo+hU7l9iipkPoH7sx4axArXUahZ7gVU0dc9EXXjxu5hyreUaGJeucr0tjCu/vDU31ZitZ9ZxMbGQncuR8s1QQWW/c6h7pSRGnr/N9zd/ksSnlfAIxGE40x1WmvbmC6y+/LaMQYiq12twzA0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5318.namprd10.prod.outlook.com (2603:10b6:408:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 22:00:33 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 22:00:33 +0000
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
Subject: [RFC PATCH 56/86] xarray: use cond_resched_xas*()
Date:   Tue,  7 Nov 2023 13:57:42 -0800
Message-Id: <20231107215742.363031-57-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::6) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5318:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba5a61e-6ac2-48d7-3fe7-08dbdfdcf6f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e5w/tHIwmKV7+iAmFIBOsPCEC3SzRJZNAb6iHr5/XP/MHYXn/hO0973zTssW6b/FmiruTX9vtp1EFIDYboPYdyCPfvIeWRzDHS1Ai6LHaVJZzNGN3jZX3Fdu/GU8W4/DUGQWus6nAhFdfS+wGSfQHqJgO8acI4fExcUSuC05KjboDJluwUO7wbK+YXkmfUBg3SL1gpDbdefhgA5ttd7VitYuPBJdEUZ84j08AwFo7mLcl90gO4RpAFLJQVk9hdvutm+685vxqPHbVWaD7B2WDws8WMoDn5XS4ow+iYj2PKhwyqu0BJXX1mluyFLfuVCI6dXq30Va7IYL0KE/pBIisq6i8vSRY0XbuOu5YoY/0oO5/K7e3zD1ahcKn+uCn626g2B6cxaIhrYqGHVnlXivP024PzYnZtSGb1fOva/XH3DqUn8oTIoyJ8qp8oMOUaM/cczgs2dRtF1OJK95+ZPpNqu3aAVyUdx0IxZLm7pk4DcE7TFHOgMy2MBDOLI9S6y9nxIJymQT2Eeb2Sr50teFhB8ZXSoAYi6R6TkOg88PAtdpnyCaXemZsbKth+mwK6p5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(1076003)(26005)(38100700002)(83380400001)(5660300002)(107886003)(2616005)(6486002)(6506007)(478600001)(6666004)(6512007)(36756003)(316002)(6916009)(66946007)(66556008)(66476007)(8676002)(8936002)(4326008)(7416002)(86362001)(7406005)(2906002)(103116003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q54zyQ+KLI0EK/PfzOy20YbeFiIbJKAJWprQDiW/VJDPWwcVNiYqMJZj99xJ?=
 =?us-ascii?Q?fDb4ax2eP/8AHdZVPYe3BrYq2XK1Ih6KJkB3NPQkMwe8HSTQBVc74/bFv4vA?=
 =?us-ascii?Q?3moWFkvsBjS6zSWiR2pOfPQkKIJB0NjKqHpl9xmudnPO6pdXrpt+UYcDEKnU?=
 =?us-ascii?Q?dTylcBcQ/FbEDAxvQLBCGfXVq02o6soN/8BUx6OQpMOfhWCy8xqpQaYxReaU?=
 =?us-ascii?Q?SRU2wlYHZ8hC6vd3Ahc9KVc7Fo5dOGLh2mu+uhectwPhLXshFJNb3TejRvps?=
 =?us-ascii?Q?UaBz5aRJy+a5fhKcyu54uae+CHpvfaOcaagwnF8N0zMQNZ2S7v1QRH95s1lJ?=
 =?us-ascii?Q?jN2PdL1rexrK36RgZm36asiJ9DtNvXJApHdACWWHZMeKfos9zztbVpZ1nfOV?=
 =?us-ascii?Q?seLm9O8hVaYapA831ltS6AexT+PFycs0WmDy969XwQwdXVm2z9ufU2hLthak?=
 =?us-ascii?Q?rS9qDSgqoMpRU48KG+1wJQ7j8I862udJHTI2gsWFa03c6a421CADO+CoWjvU?=
 =?us-ascii?Q?Nd12KMzMdxeZj81Kqq/Yg5JtaUuW/LltALamcylxMSims1de06zy6HdbVtwc?=
 =?us-ascii?Q?cYIE9PF7Aq0mtTJTXtZbO67qeE1bKY6jc0K7sSMZiEloYwKVk0Igs65xzTHt?=
 =?us-ascii?Q?BfShBPTxfb/TNZbwhHfbwbj82q+KVPlGCZKVGX3xQ86IySY8Nhyo/rHnlPi5?=
 =?us-ascii?Q?Rdh3PWuPI79nH8rf12Hc3LaTybrLPL/LnAjHAJhxWFGzSkiI1amzGJuTU537?=
 =?us-ascii?Q?PjKnm75oZUMQMP252/N7O9YrGdPZ1Zvw9/xFZto2txIXzjB7fuxDW/h1Oygo?=
 =?us-ascii?Q?G4L4qtR7Hxx60IPyA/G+czy/yuAdYNeJ9XYUDJ2HqCYvuZZKRWCzl739uayO?=
 =?us-ascii?Q?hTjR4AmtsA8xsGDIRU5GqS0g1aee5AkE8IOC5SraTrsc48XczQfNjXii7fSe?=
 =?us-ascii?Q?AsX9Ch4VRp6meJM3zlXLnd0iv7mCYRM+sXK0Tvj+gJSDeSHm1aCHGVgFC22l?=
 =?us-ascii?Q?eEw44ct0MqN1sio0fG2oyTI8aYcqs2TdGW+dS715oG79S3N+EZ5gZGH8f+Ey?=
 =?us-ascii?Q?EUkPXGhQ5b0/xR0Zu295nVLzSwa3JuQoqJw0mvqi/IafHfEjJbZeInGN70o2?=
 =?us-ascii?Q?uYu0TEu9+30+o43ngh1b0S/nETUxgxMUmHqZ+eiMo9LX8lAaOAmTG/s2IkWV?=
 =?us-ascii?Q?7FsRbljOdy00UyZehAacnkVxjRuksWg1QbKKX3wY7fAHv6DqVoMC/xyN4bp3?=
 =?us-ascii?Q?/U7AZZsobfyRyZ7XuWsvU/zznrleutSeT+6jYGfSEd6QSui/dec/MQwAA999?=
 =?us-ascii?Q?kY3mFwVuM1ROuF9BCbpA1arbancuOkQtZ9AnwsCCeotJG6Myy/Wkp67MZfqL?=
 =?us-ascii?Q?fOSypYJLKQfSYw0A9OpKTLmmF6r06dIFqY6hy+6CrIKMByZDTkpAKmX7x6hO?=
 =?us-ascii?Q?Qu/qEQNjJvHy3GFNr74VhWKrdjrSTfwupVCA+ValMZzSKr8K4heL1VLFHixE?=
 =?us-ascii?Q?r1/2q5cQhbjQ7lTx99vtgpeyc0sHEKb/b6IS0nFodpmgz5hToIw/mWnUROvm?=
 =?us-ascii?Q?OQpGnCMmbv2iBK3xcC+w5+NvvpDMkMJiJjKqoQLep7MKLD1kEV7/y2S5mmPt?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?AnrkaQkub2u+0pFC/R6h4nYQWhe/z3UjwpTRo2C7EEuTiuHFxC1sh2sOzsJ/?=
 =?us-ascii?Q?I4yQr450IaUV7bYXbM9jFY0PU31J+ChWuTQGRJTmvA3CKgl9KrFmj4t9xslE?=
 =?us-ascii?Q?zLw43OaJgnxjde/VSNpxpxhpwdK8hPKPJRSot2L0gUV8MVqoofhiCzKU57xd?=
 =?us-ascii?Q?Zxog9ZxWqu8PDotY1umgO1dPkExu24rmY8/lBp+3pK3RRs6E55CQHaN2UGTa?=
 =?us-ascii?Q?PkqiagxHhIjIZtk3rio9EAtnmb5FkPrkWderTLon4+wMcz3pA67egbDa2XQg?=
 =?us-ascii?Q?GM5G0J5o9KFMuBZt2YhvpUSEEphkQF0b2/uLp0xK153aW2Nfmzq9KVXTU5zW?=
 =?us-ascii?Q?tZ6ftPa3IwbCkVCdvcTzBvalwP4iq6cZpVqU+Hx6CHxxmSPgsYCWwDf7rsf5?=
 =?us-ascii?Q?M8q1yp+EKbmkOJJA2JmXzGIEp+zaZ3xS8EWN+Daebbt10E12cnT3QPbQc3GW?=
 =?us-ascii?Q?IBbMjM4qYJbEdhSwnt58+zb3X4P2CKExvAMFvCu7Bb582OJBnd5t8nSf9yJJ?=
 =?us-ascii?Q?7HaGpI84CjyA1C+B5K/gGbWTCVw51aDALLblKuqHJoEW+It3x0q6lONdfB4Z?=
 =?us-ascii?Q?WfY3h89ZjcyQHoeIFTThvqzWWO95F7PIasA6ItftGpoMsGgC0blYIILZMOsd?=
 =?us-ascii?Q?j9rx0x/EbCviK5RVPIfxDJgRUpI66FZsKsFi/oZ+qvu/J4E/vFZqJbVxmBH+?=
 =?us-ascii?Q?AC9DZDBApRgIueHChN8zYk/y49v8vi9fAZN3hg4LWEQuL7JNU3ZKUBmeqgAD?=
 =?us-ascii?Q?bLNSIhprE5Bc6HJEHT/t04indXG/0BxqwFhhxxA+iluEYWp+60/lM3dP2tT5?=
 =?us-ascii?Q?ynsOHE4FqeSsUZTv7QsnS8uw5q4hvyi/DPF7LtQJxKiQms4rXd6gvJq8pT4d?=
 =?us-ascii?Q?uHRMMyr9N1rRy4/aJeRMykZAtdjifk+DoGLmOlFNoOY6XOKKrYDubzJ7QQw1?=
 =?us-ascii?Q?ORqjNcuve4mnq9+GY87/vTpFkQDsfNtOfFM3NFVQnrgacskOumw2Ek/R+T3/?=
 =?us-ascii?Q?aPHn4ueufv8kRKu8AbgGef32i9snvIYuBeyCmMow9EEeNwqLjPLXtYViK+jV?=
 =?us-ascii?Q?yhbomfepCCYiT2fCxCCCqFGQdKwSNQyPXMyl0Y1u9Ert2ql6YrXotwfYHIpB?=
 =?us-ascii?Q?zTthWpg+0CRFBzrO0WpSfuJaoWFSa3/5QH7X9LdKjz/405FemYpRLY80On8o?=
 =?us-ascii?Q?OTxGZSc12q7NSlbBrOxTmNcfn22rMqSULhY+/+hVnu6EUTnGShNtwk+oNWFj?=
 =?us-ascii?Q?fDhkw901GBj1jl+e5ngfaahueq7o7KHU4UOq+2vAzqSFwnDHwsO/mHuE7pvR?=
 =?us-ascii?Q?HmvU3VRkILEkXu2spEsluLlmorE/PlMX/g89WCIcmae35qkVgQLMUSmXZRTd?=
 =?us-ascii?Q?TeV3L+eWcPppAeOXyxV83kBetzhpfW6LiAg+UhH0bfhUNpvp+cbQbXzF2PCe?=
 =?us-ascii?Q?LJHc9gOaXbkLmLZHWTZ0EZV7KAQjxaUSgI0JskCfbQL2G1HES4RiOXBdYVmy?=
 =?us-ascii?Q?breUvdEkWHtlYQ7nX2hkbp2/UZ4SY7AzlHKR6xhLkMOnacQjrFpIVFO9vA?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba5a61e-6ac2-48d7-3fe7-08dbdfdcf6f7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 22:00:33.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4+JM818C1aYjYhflzhOSs1sknX4VD1NAvPBFkzT2dsGQ/8oSdXTK9ZaiP6yeGkuhZR0I9/xI8JkeBAggoyCTsuPxzz4ilyaFzAunMZMzls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-ORIG-GUID: 5Dvpu7IyVWpuSchGrAV4AjznlXTmpEyt
X-Proofpoint-GUID: 5Dvpu7IyVWpuSchGrAV4AjznlXTmpEyt
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the open coded xarray pattern, flush, release resource,
allowing rescheduling  to happen, reacquire by the appropriate
helper.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 fs/dax.c            | 15 +++------------
 mm/filemap.c        |  5 +----
 mm/khugepaged.c     |  5 +----
 mm/memfd.c          | 10 ++--------
 mm/page-writeback.c |  5 +----
 mm/shmem.c          | 10 ++--------
 6 files changed, 10 insertions(+), 40 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 8fafecbe42b1..93cf6e8d8990 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -726,10 +726,7 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
 		if (++scanned % XA_CHECK_SCHED)
 			continue;
 
-		xas_pause(&xas);
-		xas_unlock_irq(&xas);
-		cond_resched();
-		xas_lock_irq(&xas);
+		cond_resched_xas_lock_irq(&xas);
 	}
 	xas_unlock_irq(&xas);
 	return page;
@@ -784,10 +781,7 @@ static int __dax_clear_dirty_range(struct address_space *mapping,
 		if (++scanned % XA_CHECK_SCHED)
 			continue;
 
-		xas_pause(&xas);
-		xas_unlock_irq(&xas);
-		cond_resched();
-		xas_lock_irq(&xas);
+		cond_resched_xas_lock_irq(&xas);
 	}
 	xas_unlock_irq(&xas);
 
@@ -1052,10 +1046,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 		if (++scanned % XA_CHECK_SCHED)
 			continue;
 
-		xas_pause(&xas);
-		xas_unlock_irq(&xas);
-		cond_resched();
-		xas_lock_irq(&xas);
+		cond_resched_xas_lock_irq(&xas);
 	}
 	xas_unlock_irq(&xas);
 	trace_dax_writeback_range_done(inode, xas.xa_index, end_index);
diff --git a/mm/filemap.c b/mm/filemap.c
index f0a15ce1bd1b..dc4dcc5eaf5e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4210,10 +4210,7 @@ static void filemap_cachestat(struct address_space *mapping,
 			cs->nr_writeback += nr_pages;
 
 resched:
-		if (need_resched()) {
-			xas_pause(&xas);
-			cond_resched_rcu();
-		}
+		cond_resched_xas_rcu(&xas);
 	}
 	rcu_read_unlock();
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 88433cc25d8a..4025225ef434 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2290,10 +2290,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 
 		present++;
 
-		if (need_resched()) {
-			xas_pause(&xas);
-			cond_resched_rcu();
-		}
+		cond_resched_xas_rcu(&xas);
 	}
 	rcu_read_unlock();
 
diff --git a/mm/memfd.c b/mm/memfd.c
index 2dba2cb6f0d0..5c92f7317dbe 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -55,10 +55,7 @@ static void memfd_tag_pins(struct xa_state *xas)
 			continue;
 		latency = 0;
 
-		xas_pause(xas);
-		xas_unlock_irq(xas);
-		cond_resched();
-		xas_lock_irq(xas);
+		cond_resched_xas_lock_irq(xas);
 	}
 	xas_unlock_irq(xas);
 }
@@ -123,10 +120,7 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 				continue;
 			latency = 0;
 
-			xas_pause(&xas);
-			xas_unlock_irq(&xas);
-			cond_resched();
-			xas_lock_irq(&xas);
+			cond_resched_xas_lock_irq(&xas);
 		}
 		xas_unlock_irq(&xas);
 	}
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index b8d3d7040a50..61a190b9d83c 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2351,10 +2351,7 @@ void tag_pages_for_writeback(struct address_space *mapping,
 		if (++tagged % XA_CHECK_SCHED)
 			continue;
 
-		xas_pause(&xas);
-		xas_unlock_irq(&xas);
-		cond_resched();
-		xas_lock_irq(&xas);
+		cond_resched_xas_lock_irq(&xas);
 	}
 	xas_unlock_irq(&xas);
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index 69595d341882..112172031b2c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -882,10 +882,7 @@ unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 			swapped++;
 		if (xas.xa_index == max)
 			break;
-		if (need_resched()) {
-			xas_pause(&xas);
-			cond_resched_rcu();
-		}
+		cond_resched_xas_rcu(&xas);
 	}
 
 	rcu_read_unlock();
@@ -1299,10 +1296,7 @@ static int shmem_find_swap_entries(struct address_space *mapping,
 		if (!folio_batch_add(fbatch, folio))
 			break;
 
-		if (need_resched()) {
-			xas_pause(&xas);
-			cond_resched_rcu();
-		}
+		cond_resched_xas_rcu(&xas);
 	}
 	rcu_read_unlock();
 
-- 
2.31.1

