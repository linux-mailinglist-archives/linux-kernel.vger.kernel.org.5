Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118B87E4C95
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbjKGXNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbjKGXMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:12:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD5A19AE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:10:57 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LK6M0026463;
        Tue, 7 Nov 2023 23:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=SWrIc5qkOrQC/kCCWcA3axDsd3JASb6UTB+1aGhysyU=;
 b=c9NS75+tcFO6kUB8nHnl0MU3NQyZ882Asa/K2y0yl8D4GfCjK5dx652QonYR5GwtnpSV
 /hc/v7kS8yaxE6oke2L+Khui/jgYKFJ4pVCIClWhB+psObYnL29pBP/8rTJ1L53X+g4f
 R4uU+0M2SHhA784C4sm66TLbnQydU1NF1SrTioHugVrZfCBG4efJR0lohUuGVYi2peFx
 aiF7QASfElHVeVz2acIppV9QAk6L5ICOHl83kcBWTJsjW6AVZaVT1pmbla7FOYmJUk1U
 qUvAk559Fy9MamWipMzymYpZLGMSEo2SODxrFNrGLbsCpeRZ6Ef4GelUiJJGSD8Ugfbx 7w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2106ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N40cc031940;
        Tue, 7 Nov 2023 23:09:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w2248q4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9K/obVfLKtgaHtTxuErP+t+/1aeNIAWC0WZkvq4yHl6qfMxUZm0toyvRn8VxouJlPI9KRUJFGUEq1o50mBZWHufmw4DKYwquogXbkEbSIA6fpc4PIHX0VQtpUAWbE8S2rsjPsUJ9hikZsJcpaqSfs7CU3AITATPclnJzRpmMFdRUMzfA+YoGmtgupqOtlP880l6tlk/Vk3X1ngauo8WhVeWylXVlLwsyNnYLwjxrOu/FqsDFUwd0YTiGVCZmXJn/eIgYsE4EhAKhA4z2KvKzBFTI67M8+pCPYazX3itusal2xAHIWVKlwrD+vZxKP3xiKm3m0VkwhuA6tMJeBeu8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWrIc5qkOrQC/kCCWcA3axDsd3JASb6UTB+1aGhysyU=;
 b=aaDC5rB4+BPT0TSvrmowBiQ8H1A658G1JlV474NpMbYY1Hqnex3um5emMI5uklajYWaNYWCYKOqxkwSlvwalOq5p0tCovjD0rU8oxiG9mx88Dc/iXxV1HHMiSjipaiFCxxW39Sxfgk2ed3tRVLEymqXu+QpgBc6bZPzwIgnoxz0msE5wKaTxBUBo1ql+y1Cjd0E30JolYP/Eel8pthytkSZFCr7Zahim8G9zXZkikhe96Zhm5SmeQO1nzBGcN5XbitORS3ruOTgDAMufnVRISWZnHBE/a8gYwgfpaqIIa0q3xtf7sZ/JIV327j/qilO8mLm1s5otnL1g6j8kedUOqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWrIc5qkOrQC/kCCWcA3axDsd3JASb6UTB+1aGhysyU=;
 b=P4kWfySGCs2i1g216EfMHJvEgn9XVcKgs86SPcuO4wbVanykvrh+n4cyeKv4CWtCsKWrOXliG9FrPEKtdK/KBRRrJK6mzFRik3WsCSzJwj9gP0l3jphkRqgJ38cLwtWTGKacV586i4y0p7N0Upf4MYJB+q98Z2WQHxYzXcS489M=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 23:09:42 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:09:42 +0000
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
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [RFC PATCH 80/86] treewide: sound: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:08:16 -0800
Message-Id: <20231107230822.371443-24-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0048.namprd16.prod.outlook.com
 (2603:10b6:907:1::25) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 3716c9f3-1e5b-4069-7bfa-08dbdfe69faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r54WqXo7qpQfC1ZU5ipUs6VIkeWNoOoL46n+x6PXQRcb/IcNe+i7IDzobLVTOmmxjHWMZUDzYnz39ZEhdnGZkQ/0lFTPMaqFUAg+0woZna4S5TagLhVjgsaZmzp4SX9gWYr3pp/mpg+CS3pTEUHYanF68QQUx9Y5RgTr84d8ynjM5H5Vcxo6snjfSWigRUTMfijnx84kktluegX1sJixMmF7lTDCQuXW/VLVVedVetB1bISxG38vt+kINNqY2AFWBWns3kHaQ5rN2LK+5oUgic5bfuSJjmJ6qR0nqbuvpsdiuMfKwtcLjpwR4tH8wrtUCG1XLwWavZK9C3wyzMA/P8XGYrmRseFD0RF4d7z9bbhsiYswnNXe7lsF9/VYLESa5oWGSGA4Efd862K2YafrqT2k8mmwYhukW8kYqs/lP94n180Otq7B12xVxSa61vbBKl8Dkiu5xu3uGt6Rm69YUwfFn6k3/FPAxGOYvo1pKUPulJ0eggiuhwV5fD2ZYDG1dfNI+CufuhLf7bGnDMfbOTk/AeEXjy5bOmgAS5D2iNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66899024)(6506007)(478600001)(6512007)(2616005)(6486002)(966005)(6666004)(7406005)(36756003)(103116003)(38100700002)(86362001)(1076003)(41300700001)(7416002)(5660300002)(316002)(66556008)(66476007)(83380400001)(2906002)(54906003)(26005)(66946007)(6916009)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F9lZ7WbEj7HxCeUuhux5K7fw+jooIZjB/jmsMl9KmxfV/Sr0eMgDXcxFrT+F?=
 =?us-ascii?Q?JYC5rlaMvbL3s5tRz8Ex4i9P8fdjD+n+s3+yDqQcXpwQAMgqjrTbAIphW4um?=
 =?us-ascii?Q?rSj45UuYimefwckH6ZlUonm8nz2l4V3Smgh1L8N+x7ybz6dhk2D4DhoO1KO5?=
 =?us-ascii?Q?ZydiT0/k71cfbDTLcpIWyFaJJsiTGorxOZXdMcV4mPpFyY0PiV3DnnWuiLaI?=
 =?us-ascii?Q?HZdjphkNhu+EBFtDF/cdgYWMnJH5Ro4sNaaY+cggE1ghgl0r2ciSGJJEMgcd?=
 =?us-ascii?Q?vIjOTr7aXp6rlWAM4AvSiQ4uqrfjbVa/wFlhZLWXjxgFDWkO3WIN9zfMS+FB?=
 =?us-ascii?Q?YLIpmLiu0tCq0E5Uexyh6beJZzLvzrQ2Vot/6Iuh7RPJ1qpn+rORE4bc85HO?=
 =?us-ascii?Q?sAL026NlCOsuHzM93Jrr6BTPajMxGU63fpNYE9q5GIqN4V4tv7dngbN5Tu1U?=
 =?us-ascii?Q?vT6BJEDOmnY9VzKF++c7j1GSB6WqlPEWFxumALXQBB2XcU6Ab6+QHIUlIOqH?=
 =?us-ascii?Q?ughXLc4cMH21RyzaYH5rfS477EU5cDzE+/PYj1FCaf6zFrRdT2f1E94COgI2?=
 =?us-ascii?Q?6RMdEKkSE08ATD5aN9MAWlAm4RUTD2cnSWIzgVW9K7zqCo/edA4va9/9fpH/?=
 =?us-ascii?Q?hXm3pRoJLggAIkJME2zyKJ/gUXhHM/qAXxebLYWb6Hi6F+klduJo0WeH1ZCX?=
 =?us-ascii?Q?gqXmGyJld4HG3vLD2AETfQsUQ8W/4aDQ8t2FRo0JEzeiLqjOfFkwukhLuN2E?=
 =?us-ascii?Q?HdH8pnC/af7sZQUkVwM4Pzur8nxT+Ph76yWS0M78Rk6ZsM2S14+bqBPaGzhb?=
 =?us-ascii?Q?qCaCgxYTLmBV0MPh2bPkBf8wx6UWV/krSEJvqxLW9gw2L4D3rt4X5M7YD1fK?=
 =?us-ascii?Q?b0lyqGOkExNYPHWClai3QF76nGx5l2Z1+3nMtnkl6ee/NZGyxBxnoH3cW/uQ?=
 =?us-ascii?Q?z+SdulAc9rhypkdWH+vv92ldf87sarsqINktds0MdShsSrqfzx6FFF7krCzq?=
 =?us-ascii?Q?CCx93qTrxqm3MKrwsAW8EAhE65/ab/80raHb5QFd0KhEnLcgyUCgQ7AjdYG0?=
 =?us-ascii?Q?AayyixrzBlHORu8VV/UsnrwwlHf6tqCqRi9GrEoiz2vaN6WdmBBDk4kRFHYf?=
 =?us-ascii?Q?edZBcUOwZDeQeFdk6iaEkceHwEaZg9LZ6kuL+lUq+QenSlUHQnSW/jqCsTey?=
 =?us-ascii?Q?VCcPB31bog5cn/hNCVR0ldApFftW5cymqVLFbCKcl18e8EXMTC69MCaeWdPw?=
 =?us-ascii?Q?K/nckB1iQGnuN8fqcXuutFWm/TpNGQABYaMjTL61hffslfO5NarJZL8s42EC?=
 =?us-ascii?Q?jQIXcO50eNmlLEKmkCHJM9D685oEffeOxFGqEo17wpGZGsDHWuIZGPr5Cnf6?=
 =?us-ascii?Q?4YnlHd5eFD81UPvXQYCv9sN/YT6QiPOegTH7a/x4J9fOMoK+snwsk2Hmb7xU?=
 =?us-ascii?Q?mCjEaY/s56bT230J/njr7GfckUbhgcUuuhhQ+6c1JcgWRvie+Vn5zagvumw1?=
 =?us-ascii?Q?uiZkcIeed7CikdN2Bmny+IRhYeqJM3YmrnNXAM/rarQfnGY0hmIM6NOc7EA9?=
 =?us-ascii?Q?0FPzjauoMDfwoKNNuqL4eo1+QzMIiU4MCm3YUyzkDOPK3jN+hOlQmadwEPIy?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?rJ8GzffImUr7rWkk6n6x6FyqQ4J7R1CKoywi+hFocLVbCPZiQMWPBu4z0h/h?=
 =?us-ascii?Q?z37KxCIhjKLCr8ArGynOh2+0ts/BDUR5OalgCGyd4/nKfQ4umA6teLmgzl1f?=
 =?us-ascii?Q?tExm+sb1XM0FprhcIoPvtMmmJBveN0GPLnvNIv5PdYtxApJ8sAjWKgnpbWpG?=
 =?us-ascii?Q?PaGL3yqhs2dvKhbvOhKhDifh732mUyqrBox8BD+g5d/43gUbEbwFiLgk5Ioa?=
 =?us-ascii?Q?gOSjhTtmFQQ5XuYN+FBfDjPmnEJ4qGUHS/otiIA45EgkX6lb74n1tmG/wKoO?=
 =?us-ascii?Q?haOwyOfc88riPjMe2bhihjUtM5w+IwrUGZfdODnxXHwMuvyB8at+EW61wbR9?=
 =?us-ascii?Q?Cr/KJBQ4Pjq7YWC1PtqkIpBWwyCI18Bdx5x7Tbng6h9WIVFZR70YcQnfAsLs?=
 =?us-ascii?Q?dh6GBN28PyeqYGZs7nt06nFoFviXPpHihrDuzgslM8TEnbzHTBhj/0/RA9NR?=
 =?us-ascii?Q?Jy5Qsw5MAo9wz5grNLoVCxOcJlZ0yh0kfaI+QFAmLF6r2l37J0ObstoQ0nio?=
 =?us-ascii?Q?D4zphX6OtjS036RRsED4Ka4c1Ue1hsZtleCo8Lj/Ln9J+n2KuIOSBL0rGMME?=
 =?us-ascii?Q?BhIgaqVjqA/Io6gK0ijq71FcoACgsTuILVHGd/A1MPsvy60Lw62JSG0BZRg3?=
 =?us-ascii?Q?Bb1CeM6ptqNSx+TrfS9HUw88X+T4D9hc56CM9BwIjDXHkZb+j86DiY0ZlbdN?=
 =?us-ascii?Q?X94CeRPJjQqVTXQwjKNsiNgRHXQokWMQgJSNOW23506xISPDzXiomCZJYFXK?=
 =?us-ascii?Q?xAT7TM6cykRudgQ04byrBKk4VgP/wQaT8SBIvpP65gYBHHWA76XbOYJGdWc4?=
 =?us-ascii?Q?XPMZGcgH42/ChED2smIN80LpNsIvjJiSHWxRyXe5uqV14nXfkgvExMSpWJnz?=
 =?us-ascii?Q?fPX6Aycb2Qq5Lit0BOoWeLMAGzJ/RjQQn8H7goHPA87UuCP0XiYmGpbFaKqO?=
 =?us-ascii?Q?O7kq/pLkQW+O2U30OK4kQ0NByaeiiDXrYUM730OwLfaGpbXCnvxWDIgxFbkD?=
 =?us-ascii?Q?SfUN0TGUxTcV5J1ij+RlG88vtAXfB+lJ2YWj5EpVGD9vE8ZZhl4fTRp2ahAf?=
 =?us-ascii?Q?IcOo0Xc4ggxUzB5UENSNXzuBWeSJ3RRkU5ozaPv+7ZG/cfeVYEm55FAac9X7?=
 =?us-ascii?Q?XAl+3SVPIXmghpXjlx1VAxjhT1pjAwjKcyrocNtdcqw4QI7epUZ+7ApLtNZd?=
 =?us-ascii?Q?wAxg+/oJh5X/qEiK+sESKoHZh7mkxnRq4b6/WzFlGXPcB9ptCHe63cQUbt5O?=
 =?us-ascii?Q?+3gntbsXA2XTTuVH95hQwRusyjErSaIWN3OjYWAgPn+z8kkSBPRe4G/cTTGQ?=
 =?us-ascii?Q?TKgO/ZvvX9thsMI0pfi2dWRu+eEEExOiBqELqehaMNNwY3Em3qduiTeelIFV?=
 =?us-ascii?Q?ppA6rf318iHKTWyNuJPQQw/ox6qz1OmY5zEndlFJzoZvNsjOWiEPRTN4RPya?=
 =?us-ascii?Q?Ahes6lT0ys6B7sQ0PsXCOOo4p7m0tH5njS68OJLG8iZDBvGx9FGtt7pzczcM?=
 =?us-ascii?Q?R+vN7TbhclkGcAfU7rzrJwa05a0FT1Vn1XOtrcbIp32v2kDHBwWeQgOQFvyZ?=
 =?us-ascii?Q?GfkUAmE2N0+ra08+qYo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3716c9f3-1e5b-4069-7bfa-08dbdfe69faf
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:09:42.0087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQJ5mgVXbePOtzD7HUOiU3xbvP72MbUzYVF6okip1z9RUZbvWQTh5V+KOqjZS9CF1dwA2Gq62O58XQ/q6ISe2TiNdmUZ3YhAyOKbmTky7KM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 mlxlogscore=944 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070189
X-Proofpoint-GUID: piiHRmYcU7l3D34LXQADxLl5dI9qXFwB
X-Proofpoint-ORIG-GUID: piiHRmYcU7l3D34LXQADxLl5dI9qXFwB
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

Most uses here are from set-1 when we are executing in extended
loops. Remove them.

In addition there are a few set-3 cases in the neighbourhood of
HW register access. Replace those instances with cond_resched_stall()

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 sound/arm/aaci.c                    | 2 +-
 sound/core/seq/seq_virmidi.c        | 2 --
 sound/hda/hdac_controller.c         | 1 -
 sound/isa/sb/emu8000_patch.c        | 5 -----
 sound/isa/sb/emu8000_pcm.c          | 2 +-
 sound/isa/wss/wss_lib.c             | 1 -
 sound/pci/echoaudio/echoaudio_dsp.c | 2 --
 sound/pci/ens1370.c                 | 1 -
 sound/pci/es1968.c                  | 2 +-
 sound/pci/lola/lola.c               | 1 -
 sound/pci/mixart/mixart_hwdep.c     | 2 +-
 sound/pci/pcxhr/pcxhr_core.c        | 5 -----
 sound/pci/vx222/vx222_ops.c         | 2 --
 sound/x86/intel_hdmi_audio.c        | 1 -
 14 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 0817ad21af74..d216f4859e61 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -145,7 +145,7 @@ static unsigned short aaci_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 	timeout = FRAME_PERIOD_US * 8;
 	do {
 		udelay(1);
-		cond_resched();
+		cond_resched_stall();
 		v = readl(aaci->base + AACI_SLFR) & (SLFR_1RXV|SLFR_2RXV);
 	} while ((v != (SLFR_1RXV|SLFR_2RXV)) && --timeout);
 
diff --git a/sound/core/seq/seq_virmidi.c b/sound/core/seq/seq_virmidi.c
index 1b9260108e48..99226da86d3c 100644
--- a/sound/core/seq/seq_virmidi.c
+++ b/sound/core/seq/seq_virmidi.c
@@ -154,8 +154,6 @@ static void snd_vmidi_output_work(struct work_struct *work)
 			if (ret < 0)
 				break;
 		}
-		/* rawmidi input might be huge, allow to have a break */
-		cond_resched();
 	}
 }
 
diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index 7f3a000fab0c..9b6df2f541ca 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -284,7 +284,6 @@ int snd_hdac_bus_get_response(struct hdac_bus *bus, unsigned int addr,
 			msleep(2); /* temporary workaround */
 		} else {
 			udelay(10);
-			cond_resched();
 		}
 	}
 
diff --git a/sound/isa/sb/emu8000_patch.c b/sound/isa/sb/emu8000_patch.c
index 8c1e7f2bfc34..d808c461be35 100644
--- a/sound/isa/sb/emu8000_patch.c
+++ b/sound/isa/sb/emu8000_patch.c
@@ -218,11 +218,6 @@ snd_emu8000_sample_new(struct snd_emux *rec, struct snd_sf_sample *sp,
 		offset++;
 		write_word(emu, &dram_offset, s);
 
-		/* we may take too long time in this loop.
-		 * so give controls back to kernel if needed.
-		 */
-		cond_resched();
-
 		if (i == sp->v.loopend &&
 		    (sp->v.mode_flags & (SNDRV_SFNT_SAMPLE_BIDIR_LOOP|SNDRV_SFNT_SAMPLE_REVERSE_LOOP)))
 		{
diff --git a/sound/isa/sb/emu8000_pcm.c b/sound/isa/sb/emu8000_pcm.c
index 9234d4fe8ada..fd18c7cf1812 100644
--- a/sound/isa/sb/emu8000_pcm.c
+++ b/sound/isa/sb/emu8000_pcm.c
@@ -404,7 +404,7 @@ static int emu8k_pcm_trigger(struct snd_pcm_substream *subs, int cmd)
  */
 #define CHECK_SCHEDULER() \
 do { \
-	cond_resched();\
+	cond_resched_stall();\
 	if (signal_pending(current))\
 		return -EAGAIN;\
 } while (0)
diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 026061b55ee9..97c74e8c26ee 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -1159,7 +1159,6 @@ static int snd_ad1848_probe(struct snd_wss *chip)
 	while (wss_inb(chip, CS4231P(REGSEL)) & CS4231_INIT) {
 		if (time_after(jiffies, timeout))
 			return -ENODEV;
-		cond_resched();
 	}
 	spin_lock_irqsave(&chip->reg_lock, flags);
 
diff --git a/sound/pci/echoaudio/echoaudio_dsp.c b/sound/pci/echoaudio/echoaudio_dsp.c
index 2a40091d472c..085b229c83b5 100644
--- a/sound/pci/echoaudio/echoaudio_dsp.c
+++ b/sound/pci/echoaudio/echoaudio_dsp.c
@@ -100,7 +100,6 @@ static int write_dsp(struct echoaudio *chip, u32 data)
 			return 0;
 		}
 		udelay(1);
-		cond_resched();
 	}
 
 	chip->bad_board = true;		/* Set true until DSP re-loaded */
@@ -123,7 +122,6 @@ static int read_dsp(struct echoaudio *chip, u32 *data)
 			return 0;
 		}
 		udelay(1);
-		cond_resched();
 	}
 
 	chip->bad_board = true;		/* Set true until DSP re-loaded */
diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 89210b2c7342..4948ae411a94 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -501,7 +501,6 @@ static unsigned int snd_es1371_wait_src_ready(struct ensoniq * ensoniq)
 		r = inl(ES_REG(ensoniq, 1371_SMPRATE));
 		if ((r & ES_1371_SRC_RAM_BUSY) == 0)
 			return r;
-		cond_resched();
 	}
 	dev_err(ensoniq->card->dev, "wait src ready timeout 0x%lx [0x%x]\n",
 		   ES_REG(ensoniq, 1371_SMPRATE), r);
diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index 4bc0f53c223b..1598880cfeea 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -612,7 +612,7 @@ static int snd_es1968_ac97_wait(struct es1968 *chip)
 	while (timeout-- > 0) {
 		if (!(inb(chip->io_port + ESM_AC97_INDEX) & 1))
 			return 0;
-		cond_resched();
+		cond_resched_stall();
 	}
 	dev_dbg(chip->card->dev, "ac97 timeout\n");
 	return 1; /* timeout */
diff --git a/sound/pci/lola/lola.c b/sound/pci/lola/lola.c
index 1aa30e90b86a..3c18b5543512 100644
--- a/sound/pci/lola/lola.c
+++ b/sound/pci/lola/lola.c
@@ -166,7 +166,6 @@ static int rirb_get_response(struct lola *chip, unsigned int *val,
 		if (time_after(jiffies, timeout))
 			break;
 		udelay(20);
-		cond_resched();
 	}
 	dev_warn(chip->card->dev, "RIRB response error\n");
 	if (!chip->polling_mode) {
diff --git a/sound/pci/mixart/mixart_hwdep.c b/sound/pci/mixart/mixart_hwdep.c
index 689c0f995a9c..1906cb861002 100644
--- a/sound/pci/mixart/mixart_hwdep.c
+++ b/sound/pci/mixart/mixart_hwdep.c
@@ -41,7 +41,7 @@ static int mixart_wait_nice_for_register_value(struct mixart_mgr *mgr,
 	do {	/* we may take too long time in this loop.
 		 * so give controls back to kernel if needed.
 		 */
-		cond_resched();
+		cond_resched_stall();
 
 		read = readl_be( MIXART_MEM( mgr, offset ));
 		if(is_egal) {
diff --git a/sound/pci/pcxhr/pcxhr_core.c b/sound/pci/pcxhr/pcxhr_core.c
index 23f253effb4f..221eb6570c5e 100644
--- a/sound/pci/pcxhr/pcxhr_core.c
+++ b/sound/pci/pcxhr/pcxhr_core.c
@@ -304,8 +304,6 @@ int pcxhr_load_xilinx_binary(struct pcxhr_mgr *mgr,
 			PCXHR_OUTPL(mgr, PCXHR_PLX_CHIPSC, chipsc);
 			mask >>= 1;
 		}
-		/* don't take too much time in this loop... */
-		cond_resched();
 	}
 	chipsc &= ~(PCXHR_CHIPSC_DATA_CLK | PCXHR_CHIPSC_DATA_IN);
 	PCXHR_OUTPL(mgr, PCXHR_PLX_CHIPSC, chipsc);
@@ -356,9 +354,6 @@ static int pcxhr_download_dsp(struct pcxhr_mgr *mgr, const struct firmware *dsp)
 		PCXHR_OUTPB(mgr, PCXHR_DSP_TXH, data[0]);
 		PCXHR_OUTPB(mgr, PCXHR_DSP_TXM, data[1]);
 		PCXHR_OUTPB(mgr, PCXHR_DSP_TXL, data[2]);
-
-		/* don't take too much time in this loop... */
-		cond_resched();
 	}
 	/* give some time to boot the DSP */
 	msleep(PCXHR_WAIT_DEFAULT);
diff --git a/sound/pci/vx222/vx222_ops.c b/sound/pci/vx222/vx222_ops.c
index 3e7e928b24f8..84a59566b036 100644
--- a/sound/pci/vx222/vx222_ops.c
+++ b/sound/pci/vx222/vx222_ops.c
@@ -376,8 +376,6 @@ static int vx2_load_xilinx_binary(struct vx_core *chip, const struct firmware *x
 	for (i = 0; i < xilinx->size; i++, image++) {
 		if (put_xilinx_data(chip, port, 8, *image) < 0)
 			return -EINVAL;
-		/* don't take too much time in this loop... */
-		cond_resched();
 	}
 	put_xilinx_data(chip, port, 4, 0xff); /* end signature */
 
diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index ab95fb34a635..e734d2f5f711 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1020,7 +1020,6 @@ static void wait_clear_underrun_bit(struct snd_intelhad *intelhaddata)
 		if (!(val & AUD_HDMI_STATUS_MASK_UNDERRUN))
 			return;
 		udelay(100);
-		cond_resched();
 		had_write_register(intelhaddata, AUD_HDMI_STATUS, val);
 	}
 	dev_err(intelhaddata->dev, "Unable to clear UNDERRUN bits\n");
-- 
2.31.1

