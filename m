Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7343A7E4C8B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjKGXLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbjKGXK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:10:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B701FE3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:10:17 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJmiC026251;
        Tue, 7 Nov 2023 23:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=R/hYm+6UpgYu2D4nwV1EzaFtgcD5UvZV9N+HgAKvyLg=;
 b=nJNbGz/cqGLOU2kfVKfE+weasjvj4t431B1oj2A6W+oxBG7M9GkQBArN6WnzlzYx6Ihe
 WvmhbqrMsRd0NbQy2vrJhgyX0bwhh6tXCskBmk8WzUek9DEgdtpQ74u+G10fFN67EbDC
 cuqwT/0kE9ZPNvOIjURu+p9GOZfLSuFctaonrLWVWQovsDMYOcQf6RDYku5nU1O+JTuT
 xqcPQJ8R77R1m/awnZGjJJsjVfu9wFOvDJJE8Ykuw+VefNOzsmYoPK3jxSvCGWTcaovI
 qz/oU9gCCIW1mADG/RHJiff6CMRmLYfhMRQo8iFi5FwZ5R/OnyXPqHsV7PkPyVYbLA8W Wg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2106w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N0wAE000486;
        Tue, 7 Nov 2023 23:09:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vcbu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ou4zTEkBUYqNcsJ10prmzGTYTufFLVa7RuqqepPKLE/SuCH+wdU4jUu/WA4fcDs6V4Am+ZhJaptdhsPzowimAkFim/YDWwwMDHYpj0M+5z0/lqJqPfLFv8qEou7eb4H3cogVvDhIeqxFopf336fqG23mDKLuleVRIaHk+UjSQ6lcLvMj1VQoh26F1NeiR5X+31Qrir+eBhFEgzntmuWHKIae1j83ILHCTHFmuWxWtpKW1nLZYFtg6Ep6P9WNIKUKVmXTzj0tzr2F+NKUcKmZLb1UvUL+5scd6jPRg7IsGgneVwqCDrdmVwZG2kea2h8ivmM9MbLodSZPVjrjjXvRmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/hYm+6UpgYu2D4nwV1EzaFtgcD5UvZV9N+HgAKvyLg=;
 b=gI1eAxv/0UaSkn8DpLta3AhLoev0bknHxvuoRSfmetLn52w6Jh1AQV+TxNHHAlndDAY7SuGVLC4v8dmXNhUWFjormp2GW4+dkaYhES0+fUdmPKZOXeOETX0ne8YBssU4VCMVtKEMEDA2fF/2xk1dMjTwRsatdXsPW2QlGvC1C1LbJZYnuRU9SYrTXzYuvDzaXF9HRARB2jjqol8Lkl24BP5Om0DjpDQtrN30twhdghtpY1DGrF8QASKpjc+Hc36b7+AgRJfk9SSvwcNpifHeCEtDSoChdGlxkGstK9M8/yOD9uBD5dSuLSo52kdynVNY4/Lk6vYu0mBbStW3uw9rNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/hYm+6UpgYu2D4nwV1EzaFtgcD5UvZV9N+HgAKvyLg=;
 b=ECFjFb+WiMoYuaB3bqn5C6b2+7HeWoM8cZclyJ1ieVC4ZCPiOrjOZ1JnTrQzOJXhJzFgGVK4WnvQpyNP8Rr0WWfXRbJOdY9MJIMuM1OGqvoawsVAUYfMbR3/WxlC/s7eJjkukqCxRrkZEQaMahK5I2+0xXF9UfVtbE0VMQBkAKw=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 23:09:17 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:09:17 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [RFC PATCH 73/86] treewide: security: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:08:09 -0800
Message-Id: <20231107230822.371443-17-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:303:b6::30) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: fc875e78-9314-4b48-fd66-08dbdfe69152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4WhzTLWPUetpvaKEHJrZq+FeoVKDic+D/DH0n+/ZOJXPKGpPC5rUemM6n6NPfbpI0MQFu7vtIvwbWsBpF9Qcz+N6qegBdtSLMZ7odQOI/ksnojpdSGhbHP3FCfZ4D9lXFG0X4WRkWxqJIEHdp2HpZhzAgrtlPYW29pVzUXP7MiMdEj+h/GhRMwembqIKmckKg4wdw5ftRBhaeGUuKHjcpebhV2x9NqguDiagpAvBdL9jrGEyeZE8KTGzaMvA4i0a6DD/6rKMmbZK+nWGq623VQ2ivcTNui5EHF9g0r/+l65RsrhoK1nIS3eiT4uCNwjyVA4G1Brp0uz110bEyciXf1+RAdYuk8YmzbVs/sI1JR09i/brPgYcQmQL7NRviqgE+SPnRfFgYQcRus/duP+x8z0D3riI22L7OH4HbyRZqB3IX+yycDEXzujjUlAUdP23brm4trNRmrLrn1suOVXqrO8Kxd5FQPHRdgEUS2UNEm/TMigM8lHdvFzfOmq+o/VDusstbFStQiJkNV79GlihwNeESWyN7ylpT4OXqLoDB0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66899024)(6506007)(478600001)(6512007)(2616005)(6486002)(966005)(6666004)(7406005)(36756003)(103116003)(38100700002)(86362001)(1076003)(41300700001)(7416002)(5660300002)(316002)(66556008)(66476007)(83380400001)(2906002)(54906003)(26005)(15650500001)(66946007)(6916009)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uiyCLqV2KF2iXVLezHeHzrLCaMu6cXcq27aWe93T+NoAMmlxOh40dFkViz1/?=
 =?us-ascii?Q?ycMUZSZHyeZve4M4mUKTwC+DFS79AhDv2R1JVLmdA54o/rgj8WCCOc800Ipk?=
 =?us-ascii?Q?GMHuGqVmj/ezsXq89EdCPlpQFG9Ynq495EyYtOoJ4gRfvqtq7aUUdICdIhWa?=
 =?us-ascii?Q?DGMLSDfaaABpTVH1ErClHJbf2XhMv1M0R9UaHdKmaZ1eT36kfRXtW3zho7t5?=
 =?us-ascii?Q?ZnQlTwSORLOCoR4tNJPKkkZ0cJq/X6OjkCtWTJg4wRuHq6C8hAX+4FpYuCce?=
 =?us-ascii?Q?SGfmbzhOW60SVIblaR9q7hN0IjwxLnJtVcIzI3rN2H2l33trqDtRVt6J1/hf?=
 =?us-ascii?Q?ejiWL6PhCXYuOKD38U0h/8YSMoLF+HJJNvTtS6bQRZ0IZFNqJIiFeItjUHX9?=
 =?us-ascii?Q?NCnV1Y0yioJuG2OZrikEY8l7BQextkA46PGGr6U4unmRjllg1tMeEg9oY3KA?=
 =?us-ascii?Q?ess7Z8Vjk+9vqXxTbOaKN/Ic6UcoKu+1tHKkTLfpbWCic71LpX3NO3+1/ONg?=
 =?us-ascii?Q?qmJBoXvO0J0wIezSwls495h+PmmAp8RFZsuz4vysJCzt8zOC1pmYFiCtDCqw?=
 =?us-ascii?Q?frfQE0xyCx+tEw7O1dY9Fw9E9NAVrV1hHmPN4h823MFvM8tcODQosxvbhVQU?=
 =?us-ascii?Q?Psm+LWIiInXdoRuahog4YZWOSpJA1Y0fsCtQPP9uC02ht88xyQM0Hk3qKFbB?=
 =?us-ascii?Q?8cYPnueXkNbuQxCNexpCanNfQHG3lfy07CyXy0fQTGD2T7lslxjfobcn1CxT?=
 =?us-ascii?Q?RUnRyw3GUoKpprWsQmlHEQmUcIWogYSLnWAd68n8IvAojnmFBoRHEuoyevIE?=
 =?us-ascii?Q?40pBhq6N+hoednMc3aewxhi57YuRGHBofuo9Ax3tfxvM5ZnwvmmyaORa5dwz?=
 =?us-ascii?Q?OCoEl8D8B8oiKy2ObLE+7QFwqSXAbitfxoy+Kcc+Yymd8gDCv8Mdps11Vzdj?=
 =?us-ascii?Q?FlTzYlJs3hSPAwpYdcPM1bCz+rKZY2VteANrLPzZ6f8am8uttU8MAS/yw2ha?=
 =?us-ascii?Q?hf6L4NEoIPlTbmvHmVS+KCWVhfQ1FGRtCQ6vLLj6s5hCThphLL6PAl0A2gCy?=
 =?us-ascii?Q?Lwmy5OAnZs/Ey+H6ZTzMcyIIMjN9jJrWTDsM8H13mLZzWqQiXJFSvKq8UPuF?=
 =?us-ascii?Q?Mo/k9lMK2Niw2nfVsQZC0BGYaERt4Lu6nUXwbNtPN15VaXKYEZHE7aR2rIvg?=
 =?us-ascii?Q?LTsu7qjHOWYZ8TXNTexQhb4ztjYMJRknwu6jUuy5ptE4hKYleB3GcKPfkG5i?=
 =?us-ascii?Q?4hMZuIL+dI47LBDVAsDu4QV+E8yWlUa/CiHuG54uGk4gMaKrZ7uygnxv27tJ?=
 =?us-ascii?Q?yXQvQRdYR+FG5tNbB3X66amk0VG0z96nKqJW4mT6CGI+dRlLy6TE4c1LGmsO?=
 =?us-ascii?Q?db9+2Z0omcypSh5sZMHi5cj7C7Oo27xC5Hz4NNAYouo1/lMrRCU13ofuTt8x?=
 =?us-ascii?Q?qumPwO715AMiKyp9Y1Tb424tqEafNa4goWXv10OU/senU/6i5d5rCu5redNU?=
 =?us-ascii?Q?r6S+wL8VqpM8xkppAYel4/dHs1fVZKi9KrB+HAC03r4nzUvJBAMF2pTOSXCx?=
 =?us-ascii?Q?zMjZqCziVcpyF/4EmbGRF8OT9W47++ureDjOwzOuUJ3XqhbtBDOsOTEkZpD+?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?E0kmZaXaD8RqNN2HYwnjv2Ax5xITzQz9Etg4A2pGV2yvNtZrL91DIgA/XcEG?=
 =?us-ascii?Q?Gq41Ma45eNK8y9BNC8Pcr4FIR1GjY+2/ynE1DJpzkXSbTJyiJy8D1qHCaYJK?=
 =?us-ascii?Q?BqPcnqeXSrdNkZoCoV2qV2Wp/y+5oREbmHFm0UUPwpFuN7NOiSnepkKWYKn6?=
 =?us-ascii?Q?pE7mkiU3t0LXQoPA4oZV/5LWta2tm6AaClNPRu2YjFMMArnWnxebgYVCLenE?=
 =?us-ascii?Q?+FbU6IodSHtran+EWIYH9uHKRvQYxAXkpDtVLZ4f3jvvILbR8NHSB3JlsF31?=
 =?us-ascii?Q?J0wkin/f99lv9RBK8AkAEjbNRwQUZolhhg27fMkH3AhuKXVqJjmSEQCucOxz?=
 =?us-ascii?Q?LRNmEFzqiKEz5WvOwG8eAJwNFzz9SEDR1t4xmrvyECERms8Elg0dVan5taBp?=
 =?us-ascii?Q?2Dnrf2WGFk8Hx5l99KpuXTDWVL+kRpCK572aUm/kP6OrjuLPCFhodSnZTtZS?=
 =?us-ascii?Q?2klku2K+Ue8STn1Dau9Zjgi33gTHO+qhjbrXudlLdP1DPpzO2LicygJNhA+R?=
 =?us-ascii?Q?f5aApm75odD0sMhNk7+4dqKP0j6UyUlM8Dit5pcKFVZLW1wFivT222KLIzfH?=
 =?us-ascii?Q?MgHVV9B7Y6xDAgQ0jWOjNzBaDeORBUCv4iiLJ6yr+mtQzsYuvs5tQUKpS+KE?=
 =?us-ascii?Q?CmJzYC88i7AocGioz9J34R52IeF13SsUdXWv91+JJ/eBZ5lDmDA+iL6BltM8?=
 =?us-ascii?Q?qNWuoCYCznZJgMo4cMCJF+fCu+XADAD1DQ+Ywpg8sqYZFdBIg8r7UrnA/BzR?=
 =?us-ascii?Q?0cj7xZeiGfX6/GkqWf4DG0FJ/qjLONaLsrst6OFXbpYAAlANUDmxEdt9LsTz?=
 =?us-ascii?Q?i1QtIlK3jHAxaGOah4gFUOyxz0a+7XOsuulF3XoAKVwl1qsIj4Knfua+Hnm1?=
 =?us-ascii?Q?7mtWjWalCQTZr1Um7dMh5iaNPH3YJRNnF26hWODX5CExDvbKA2Ob1FrUJWEv?=
 =?us-ascii?Q?Ws5k+EBtjRosOzFousrH4iGMLZAwLGBJX67ywHPw2C+hEequ7ixMHyrH68dx?=
 =?us-ascii?Q?VedIFQiFmiBETatdj0403qGMq/KwYd/rz26IXihQuytkMmkbdkJptmvgAJ7l?=
 =?us-ascii?Q?mTWz1Q+4Ka4xi3Ud3zDKrJs+Rq/UcoIIxIzxcKBp1BlzhpPUg8sPDawPkTB/?=
 =?us-ascii?Q?78z/zYVa12aDwRc/DNA3anirjXvakI8k7dZFvYWVv0HDhz+MToAVCY15KdMx?=
 =?us-ascii?Q?G8Y6rA5Uqbj7jYWAHZryLlZzSVo3YzppCtEtNw8lK49mKcLAmnVAHQr2+Sro?=
 =?us-ascii?Q?MO+tZHRJ6W6raAk0f27KLYYMtS+lBbNl7GIiBCGuHsfOfu2XyE+Mta8bK00V?=
 =?us-ascii?Q?zjvKAOWnZ8pYNzaL/A3Bb/VvFNCJEWt8g4gPsmipet6P7N+OGoo+gUMlbzRS?=
 =?us-ascii?Q?1gYnqTKsNu/dX3BjaHEMYL1cUs2NrIXw7oYoSrrgtOh9cmCwCTJIdzMgKVwM?=
 =?us-ascii?Q?oMBKd6lWhISQ7y6mvtrU2YZORyhfJFJpcol/xS3ERYUw9VK+ArYtMokIrAgm?=
 =?us-ascii?Q?zLqZopL2LBxBW6ZHGV0W37EMTdNIAwpcaPfHhHkHdYESg0xiplfbTiUgxw?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc875e78-9314-4b48-fd66-08dbdfe69152
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:09:17.8153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mj/rDjxBkssStkl6KSCsYLj9aeF0B6kiBWH5xX+gAxm3FdofYqmMP2zLe43iIhgNt5RnNKGSnhJCwpixsEBDBf+311u/aob5evRRycymMyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=979 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070189
X-Proofpoint-GUID: FwqekP0cdJ5Cd5MSapeXtZ_AVs2DNsHW
X-Proofpoint-ORIG-GUID: FwqekP0cdJ5Cd5MSapeXtZ_AVs2DNsHW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are broadly three sets of uses of cond_resched():

1.  Calls to cond_resched() out of the goodness of our heart,
    otherwise known as avoiding lockup splats.

2.  Open coded variants of cond_resched_lock() which call
    cond_resched().

3.  Retry or error handling loops, where cond_resched() is used as a
    quick alternative to spinning in a tight-loop.

When running under a full preemption model, the cond_resched() reduces
to a NOP (not even a barrier) so removing it obviously cannot matter.

But considering only voluntary preemption models (for say code that
has been mostly tested under those), for set-1 and set-2 the
scheduler can now preempt kernel tasks running beyond their time
quanta anywhere they are preemptible() [1]. Which removes any need
for these explicitly placed scheduling points.

The cond_resched() calls in set-3 are a little more difficult.
To start with, given it's NOP character under full preemption, it
never actually saved us from a tight loop.
With voluntary preemption, it's not a NOP, but it might as well be --
for most workloads the scheduler does not have an interminable supply
of runnable tasks on the runqueue.

So, cond_resched() is useful to not get softlockup splats, but not
terribly good for error handling. Ideally, these should be replaced
with some kind of timed or event wait.
For now we use cond_resched_stall(), which tries to schedule if
possible, and executes a cpu_relax() if not.

All the cond_resched() calls are to avoid monopolizing the CPU while
executing in long loops (set-1 or set-2).

Remove them.

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 security/keys/gc.c             | 1 -
 security/landlock/fs.c         | 1 -
 security/selinux/ss/hashtab.h  | 2 --
 security/selinux/ss/policydb.c | 6 ------
 security/selinux/ss/services.c | 1 -
 security/selinux/ss/sidtab.c   | 1 -
 6 files changed, 12 deletions(-)

diff --git a/security/keys/gc.c b/security/keys/gc.c
index 3c90807476eb..edb886df2d82 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -265,7 +265,6 @@ static void key_garbage_collector(struct work_struct *work)
 
 maybe_resched:
 	if (cursor) {
-		cond_resched();
 		spin_lock(&key_serial_lock);
 		goto continue_scanning;
 	}
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 1c0c198f6fdb..e7ecd8cca418 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1013,7 +1013,6 @@ static void hook_sb_delete(struct super_block *const sb)
 			 * previous loop walk, which is not needed anymore.
 			 */
 			iput(prev_inode);
-			cond_resched();
 			spin_lock(&sb->s_inode_list_lock);
 		}
 		prev_inode = inode;
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index f9713b56d3d0..1e297dd83b3e 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -64,8 +64,6 @@ static inline int hashtab_insert(struct hashtab *h, void *key, void *datum,
 	u32 hvalue;
 	struct hashtab_node *prev, *cur;
 
-	cond_resched();
-
 	if (!h->size || h->nel == HASHTAB_MAX_NODES)
 		return -EINVAL;
 
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 2d528f699a22..2737b753d9da 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -336,7 +336,6 @@ static int filenametr_destroy(void *key, void *datum, void *p)
 		kfree(d);
 		d = next;
 	} while (unlikely(d));
-	cond_resched();
 	return 0;
 }
 
@@ -348,7 +347,6 @@ static int range_tr_destroy(void *key, void *datum, void *p)
 	ebitmap_destroy(&rt->level[0].cat);
 	ebitmap_destroy(&rt->level[1].cat);
 	kfree(datum);
-	cond_resched();
 	return 0;
 }
 
@@ -786,7 +784,6 @@ void policydb_destroy(struct policydb *p)
 	struct role_allow *ra, *lra = NULL;
 
 	for (i = 0; i < SYM_NUM; i++) {
-		cond_resched();
 		hashtab_map(&p->symtab[i].table, destroy_f[i], NULL);
 		hashtab_destroy(&p->symtab[i].table);
 	}
@@ -802,7 +799,6 @@ void policydb_destroy(struct policydb *p)
 	avtab_destroy(&p->te_avtab);
 
 	for (i = 0; i < OCON_NUM; i++) {
-		cond_resched();
 		c = p->ocontexts[i];
 		while (c) {
 			ctmp = c;
@@ -814,7 +810,6 @@ void policydb_destroy(struct policydb *p)
 
 	g = p->genfs;
 	while (g) {
-		cond_resched();
 		kfree(g->fstype);
 		c = g->head;
 		while (c) {
@@ -834,7 +829,6 @@ void policydb_destroy(struct policydb *p)
 	hashtab_destroy(&p->role_tr);
 
 	for (ra = p->role_allow; ra; ra = ra->next) {
-		cond_resched();
 		kfree(lra);
 		lra = ra;
 	}
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 1eeffc66ea7d..0cb652456256 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2790,7 +2790,6 @@ int security_get_user_sids(u32 fromsid,
 					  &dummy_avd);
 		if (!rc)
 			mysids2[j++] = mysids[i];
-		cond_resched();
 	}
 	kfree(mysids);
 	*sids = mysids2;
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index d8ead463b8df..c5537cecb755 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -415,7 +415,6 @@ static int sidtab_convert_tree(union sidtab_entry_inner *edst,
 			(*pos)++;
 			i++;
 		}
-		cond_resched();
 	}
 	return 0;
 }
-- 
2.31.1

