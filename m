Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBFE7E4C87
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344341AbjKGXLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjKGXKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:10:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D5110E5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:10:05 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJjWV020343;
        Tue, 7 Nov 2023 23:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=CxtR35WfEHfVrunGElDiTM8LjPhoy1plhpoBCXyRgZk=;
 b=u7MBgR4UQvF+/g6JUw6+6ToTDQO9e//6BZrr5klVjb3xiszIhD02E9V/U/OkrilQo3Nm
 WZzm0PJVjuJ/GVadytw5IH/DN1DntY8/B8dkFwZSwMfsSburwcI8erQTKR+pbBIIhvsx
 N4D5bwtucQFureuONcP5L8mx3jtQF/R/t8+c22ZIB8bPAaJ3N7nLzkXx3eb2f+GQHH/K
 rO+mO/uwcl4WzkkUmh3RWRAtqiwydNGG1bkaSQMCPUtEaYRjkARSTTpCeBnB1k9bfRMe
 FowVHss+WK++nUPGNzvyFPGVzDakOnslIPoQ93+TcIvnH4TC69LNK220tAbCtogH5myl mQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w22079r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N2f9w000483;
        Tue, 7 Nov 2023 23:09:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vcbqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laL5aznsEvVmy8FlMXRx5wgpxaxzxQL5mtiLT/FmZ3aP+u5Gt74uQhu0HUlFsSW5Qd0S/VzToDOsFlgMThF+aHqoxOeLmCWCVSO7O8OEj5zeiUq5l3QTRvTt+22AmvrSEc9TJ0P4nu74yfMXz+tOYmcQj+Ye1m20zNiCPMhKssz/9GmeecWLrIjY6mVW8mqcTpHt46YW/Y9y5HBrYhLE3vCytWQUk8Ep8jjf0KDe79H/p47vJWRqsy2zdLplW8OcGmogVF0Rmi6r6jKVUedezeRlnWgeSrfHu1El0avMISIytECF8DJHPE7Yh6QZ63h072V5pNJ9RQNeTCda0dSk5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxtR35WfEHfVrunGElDiTM8LjPhoy1plhpoBCXyRgZk=;
 b=RxVvDoPLLcxQSdYYYi5NMH1uYSsz6uuEfXQ/hGz314bEMHbfI2b9NnP3QYChvG6An2Rh+1mch5gGKH14KnhPKA6q0RrlTVKeXGeLlveiK1jEJbGdPOA45DwvVtshgfVh6xJEkdF0B6ULs4QNgvP+3922XfY+wyapPXReEKoOvKWGChUiXld3k1J0XJLMbD+RdZIJhLr5a97ZzQWp6FVh2Unvd7nZUvH3fNJ/A3vUImqTESZtCtl6HEQpk+WMaQDRBY3hmueTD90Ek58p+TtCsbKN8ybSUtoi8fcIRf9H92o08X3vovC13r+jWQelXXmmrTET9ZwfT/iV48WBo3o9vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxtR35WfEHfVrunGElDiTM8LjPhoy1plhpoBCXyRgZk=;
 b=I56sJIulWLv3+R2HYBWCDMUoZAqJui/toFecbpvoZwixWQe42LpmRENxuo8hpg1gJrt8rJI3FouwL2DNsarICnG5j07m1aLzU+/V1MOF1Y0yf9+uyLywOgbKnzTAb1Y4b2xjGHyDihL7pIMsPhW5UAXdcQK2vyafvlNPKeTcI/E=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 23:09:09 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:09:09 +0000
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
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Thomas Graf <tgraf@suug.ch>
Subject: [RFC PATCH 71/86] treewide: lib: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:08:07 -0800
Message-Id: <20231107230822.371443-15-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0072.namprd07.prod.outlook.com
 (2603:10b6:a03:60::49) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 06eef8ff-3c42-4f22-f839-08dbdfe68c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5b6ndjvFNZ12a8FLLiTuTTeurMj+7agXLbCv9NZqrnpHP2apYak3ha+J1ktgxkUKUdFM8E0AO7lqU1XWemk8obU68G0aPtddrHXffrCfA3C8OP1LVtRrD4RDoOIvyXxfWIioOkYFAKMZf/llg1J6vweSlsKwtgShVYMzPgw0bSBLMNmBZhKzwjy4FNuHcw2SYhaOdGZe/ZEMMzJwQpf9IGAeYwnfRi2j0fPN2PlnXucuJ3upYcgK5nTYp6ZB7fNoKKU8vUe8EQIwdhSWKMfSHnDincEdlchqlYUT7rtUlWvd28a3aCU1Kh5qOGa7H7CZq4EqkcXBg3KbCMUdp3RcAbif2Pp1l7rZx4Rymehmj8sP1Z0TUV1QcGGawewMkcl2Bbxr9nGsBIf1Oqy5jAHw98amj1ThNmyG4et6ZMwfGeZKLA1aDcHcEBGwt2u3vOZlyTvUb+VkF64LhYldtWz0mD8DBxuF1vYNjmg6c+esQ2QRjMDzyYkD5Z8/F4BQ36GV6m23GWyMIytBG36i+963aPPjB9QjkiPAcS9K9v8U+bozXD2NgEJhzzVJhbl2oqM6QPN1P3gSrA9la6R3tI9ZQaIpthBH4fkPeTIUrDGtg93dH9oms4xTE3CK5BgF2KhS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(186009)(1800799009)(66899024)(6506007)(478600001)(6512007)(2616005)(6486002)(966005)(7406005)(36756003)(103116003)(38100700002)(86362001)(1076003)(41300700001)(7416002)(5660300002)(316002)(66556008)(66476007)(83380400001)(2906002)(54906003)(26005)(66946007)(6916009)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UbVIk3FFL8hR3V+fDBbKSeAWt+vl7deyfLAdKIcHrZ7A6k3H9dV+A/Tfjyg6?=
 =?us-ascii?Q?KPQgW6/boe0qUNRvsoh6K36GOF5s5Vq8fmhNsJKx5WN4WIHm/xBOu5RpfpCu?=
 =?us-ascii?Q?9oMwiDPp6pG6npEWFH9Xlzn0SaR5D6A2r2wjLbaCmADypTaXK6RXNSDrC4G3?=
 =?us-ascii?Q?iMkhbEaKKnKPXIwkVpN5GK0nbLyJy6KQMNnaxPKD+onX/ctSOpWQ9u8V4QSV?=
 =?us-ascii?Q?rJOap5pZhdS9jl8eam5xo22U16qZ0My8GYNXreQkvFHgV7bv6mCZPtyg0hyx?=
 =?us-ascii?Q?aUR2VBSVCzbGQL7gsZwfCG8dp7QifM40s99NSPZMBi0xqJ4UY1NQO8U+WHuk?=
 =?us-ascii?Q?OBmqottnPtEDAeW1fzo3jKN/OZzITrq55ztR8qpkTiKCzw5QXGPSesdMGvuo?=
 =?us-ascii?Q?wumAI3BuZR0kvCgeAGrmJIRizO8qocUje4sjCYFKpQx5/XzlZ9V01/U3I4y9?=
 =?us-ascii?Q?Bbm0PpGipeJdJP95DlQLUjwj1AQvzyCyO/kvp3RM5kRks+PCgYLJCPYAwGOI?=
 =?us-ascii?Q?q18zyUw8chi5C2qbSScFgx9qPtWdoSSRtzA5De0lpVLOZh/5k4RFLBi7y5hK?=
 =?us-ascii?Q?kk+l8Xjacx9WiTy2MuJsf7hVWnddEXBGh1wRttEcq+lppRFf64nntLrar/1z?=
 =?us-ascii?Q?JmhJDt/WCeOGrd4NBXbnZivS5HftZArMccl+ftASy7Ji0kKjDigZyVjMUyxU?=
 =?us-ascii?Q?uIb5m1YcVNy889hokNqaXbYpRrddmqWBe4zHHL2Glh/T+sRR9J+khzVigsE+?=
 =?us-ascii?Q?FC2AKcCnn2t9vKooP/edi5lKG5741z2lf1H9CYW2ljWfXIqjuB0KOUywGEmR?=
 =?us-ascii?Q?XaJu0/IJgBKXanVh7u9plDcDtTggpcVY2HiucVa7xy/x4rWvXFQO4dkJMGLp?=
 =?us-ascii?Q?9YahV6TBgDlYk1Q+oUGstkMvCUkzV03obbaKTvKC1Z66IXxft5k0kyxLH0zy?=
 =?us-ascii?Q?DQ5aPaTUXkBgLDKvDsYFIPLEIPfR82Djgz3j+zrMtkEBSfB10qSCjKTi2Q/L?=
 =?us-ascii?Q?eqrLP0UN2BM3apF5dSOnkpcRSGiLel7WzJvgbA3biJ1pzvG0r/qrodT/Ugtb?=
 =?us-ascii?Q?m/xey5H5yfCkMsxno/VBzYRmGqNGfI9EpKKvw6+TBY2ZeRxxis4Nw/mMZJGV?=
 =?us-ascii?Q?bzW/dOaS1Je07pFDB8tesMGBF4rYtQcoIinGZZqs4d0w+wEd1hRgV4zvIjt3?=
 =?us-ascii?Q?MBD9c0SyRT2t7uOLnOo8WbqQbOiXSOmNBLpOIuw0Ta7tfuNgHIOkcX5JqSB+?=
 =?us-ascii?Q?2Ko8lU0+7lgbRFJvtATHORkvpAzqbSMKQI0M2VmJP27LlSmrg4cW8n5DgFgP?=
 =?us-ascii?Q?rPlMhYeTtGkZYmCwWfOhfokJqbWB8nl9gFBkpSvel9vGsE6Z4JwUiA57SjPu?=
 =?us-ascii?Q?K85PvygqitGJdIywfTiSAkRJQxXN1F6+vLh9WcCw4NzT2aOMruNpU6HrxlWH?=
 =?us-ascii?Q?4Ca1JxjCAOkrIT8XiG8we7I6grnTNIioUYEvgATefmrRfWbumclgTdrvtBCo?=
 =?us-ascii?Q?UCqKKJFEG7gUz2bFbYTAresMnRI6R7PK80DyWkNNlE15n82urxkwfH6MeSc+?=
 =?us-ascii?Q?lJo9DHEhcfppBc+mP2mGjK17dULiY2PXLGYW0NiAtRQJz/CX6rt3SRlSlP9i?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nxLQtz5sARR+EG3w5c6jWTJk4iHjEW06eEGVZxC8uwQstuAkhj/I4A+oBa77?=
 =?us-ascii?Q?EKqHEXRXIJfJouT9NYvYV4udMvTn4LDmkp1snyvtDEky2y+x2rcQi5wy9TtB?=
 =?us-ascii?Q?1xLOz9L4tV0bEA8EF+FV9OjY06+K8uZWEqHFE6ouYHNcn7Kz2jy3+VcH+Aqy?=
 =?us-ascii?Q?PqpPO7+k0nW4fIoG1LgHqLJf9X93Z/YGSSNw3GrvuHZNLDnWAnmRSEE30ktx?=
 =?us-ascii?Q?pK8DnORAAK4m3e3S7DGggMd4xuZaEy3vXErNv/KMn59YrQ75NvrPogKCJoPR?=
 =?us-ascii?Q?cZ9LRFlENL1hCQLAgsQjRIjS6Sq2EkM5IQllPLSyRhRD/XGAxXmeIID/+TNL?=
 =?us-ascii?Q?vJznYEnF/Js2qMUEDT7zrMm0dePTp7NdfwUexT+7YmBoBOyTH+BVNzVhuOU6?=
 =?us-ascii?Q?qNTRxzjvxFAKg2rNvzKPbfdTZ9qNTJiTncQ0dRMREWU4Wl4+AB4elS+yzkgh?=
 =?us-ascii?Q?TmKNxdRmPs7w2xRTUSGeOO6y61Q4PTdJn5Hh2Km250ZV6M4EhlicftiW53OK?=
 =?us-ascii?Q?eYY3BYxCKTNlnToj1i/aZpftFIyzT2w7RLTkdtRzg1CB/lgcy4HtP23a7zY/?=
 =?us-ascii?Q?eS1rzGojkdBEMWVLSvTAu+Of1Z14+wTWmKAaFYlQlbDYa/55eKSVFdDJGGr3?=
 =?us-ascii?Q?G6/8fJDdPPi4xu3l40P/YQtLDe5U/+zvtIDXSM67cSCwhJ5EIE5b/O5B9jsc?=
 =?us-ascii?Q?lRBqnmMf8EzeZ7uqmdbmyG2YefE4aZDTCQqDGO7Cl7TuhfVGTX9YrfzjzGkk?=
 =?us-ascii?Q?IwnxgxiupSplyFVCanQBTj2Pvpvocx8TheHF8ViOZ8JN0XJSd+OgmkBvj7ch?=
 =?us-ascii?Q?PUu2r4Kw72qgFqtjKL0q0B+XN07+q2WTaBB+gRpUdEC4RoVsJb22APiqRbc+?=
 =?us-ascii?Q?263yJ0SCNWwXjYWYCI2m7JrLALBC+ObgMN18o8yO0dwtMVzjV+XMtKHYKf4X?=
 =?us-ascii?Q?aniM6U5sl6DGN65Fk2nwvvSl4sbpgxwGdqXF68KFWllMlDjFMUFFbIXi3822?=
 =?us-ascii?Q?zg7Dr0Lg63q9GrR/Yg55qydgG/KVO+QJmlXT6NabRZz36d38vrlTeVkFcZzx?=
 =?us-ascii?Q?V0ctI3VW3rrr74L2tmnh6r+sgGJ7KznPnHG+0j3SwUhRaON5SkjVjB5d2YFT?=
 =?us-ascii?Q?G7IfRQfu4yy0rUfXdXd4CWXrmlZ4TqlCzpcDSuiOh32dilLhSI1f7Cym27Lb?=
 =?us-ascii?Q?OibKiH8WeL7U8+yZc3daYNIHdp1zFNPaVIft6c6j7WmdsJTHRiaAEHrUuQlP?=
 =?us-ascii?Q?flnnzsc/ZOazf0iEM55l15D9w1oegoyqbs5UIxU6AnJY/OW2jcpORDnLirua?=
 =?us-ascii?Q?LvueP8dnYh6L8xbEKJ6qt8XeC6HUnDpJOmqJNMikY/p/Iqw5Rv+9BD/T7zg7?=
 =?us-ascii?Q?G2sxRqlHO65vVhOwLazc1K0aPbGpwEbayXlmRxLzJE3QTf/JBzMZl6p1DXzA?=
 =?us-ascii?Q?eDuBPoksexWw1K8q/pMFeaSjfp2nIcJ48tLzFjBzt6XbsSrYJDzLun/EzipO?=
 =?us-ascii?Q?sWRUm5M33qPGx22fcOqWU6QM2ekCXQiPcMvGmnZdSdVFJ34RRb2jjDb0vUK9?=
 =?us-ascii?Q?0eYfEIURII2NFRD1orq6aD2OrhhD7JaY5bZAvzj4VDkvjbTZMCrtgD98gYFR?=
 =?us-ascii?Q?IWrnb+Dy5FG/sTAguU2Woqhgfs8yjBbYSzW7yOXHWD/5dqxLohh13+bN4nsO?=
 =?us-ascii?Q?YeId1mFElzAHIZw6rNPl07qdK1L81wvQd0zwgcsEKw9QWj6w?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06eef8ff-3c42-4f22-f839-08dbdfe68c22
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:09:09.1725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qA10gzwCS5oTLgPqxHZ97iB4/H5sWmiHZdXJmUkE8W9xFzDE1rwssg248Fp14mEVlaxlnaf8jBhKpUXT1Nm34Huvzk7kBoNW94fpyX8/hMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070189
X-Proofpoint-GUID: RzcFPeLiSUCbGfj62VwIpN318D3a2pCv
X-Proofpoint-ORIG-GUID: RzcFPeLiSUCbGfj62VwIpN318D3a2pCv
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

Almost all the cond_resched() calls are from set-1. Remove them.

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net> 
Cc: Kees Cook <keescook@chromium.org> 
Cc: Eric Dumazet <edumazet@google.com> 
Cc: Jakub Kicinski <kuba@kernel.org> 
Cc: Paolo Abeni <pabeni@redhat.com> 
Cc: Thomas Graf <tgraf@suug.ch>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 lib/crc32test.c          |  2 --
 lib/crypto/mpi/mpi-pow.c |  1 -
 lib/memcpy_kunit.c       |  5 -----
 lib/random32.c           |  1 -
 lib/rhashtable.c         |  2 --
 lib/test_bpf.c           |  3 ---
 lib/test_lockup.c        |  2 +-
 lib/test_maple_tree.c    |  8 --------
 lib/test_rhashtable.c    | 10 ----------
 9 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/lib/crc32test.c b/lib/crc32test.c
index 9b4af79412c4..3eee90482e9a 100644
--- a/lib/crc32test.c
+++ b/lib/crc32test.c
@@ -729,7 +729,6 @@ static int __init crc32c_combine_test(void)
 			      crc_full == test[i].crc32c_le))
 				errors++;
 			runs++;
-			cond_resched();
 		}
 	}
 
@@ -817,7 +816,6 @@ static int __init crc32_combine_test(void)
 			      crc_full == test[i].crc_le))
 				errors++;
 			runs++;
-			cond_resched();
 		}
 	}
 
diff --git a/lib/crypto/mpi/mpi-pow.c b/lib/crypto/mpi/mpi-pow.c
index 2fd7a46d55ec..074534900b7e 100644
--- a/lib/crypto/mpi/mpi-pow.c
+++ b/lib/crypto/mpi/mpi-pow.c
@@ -242,7 +242,6 @@ int mpi_powm(MPI res, MPI base, MPI exp, MPI mod)
 				}
 				e <<= 1;
 				c--;
-				cond_resched();
 			}
 
 			i--;
diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
index 440aee705ccc..c2a6b09fe93a 100644
--- a/lib/memcpy_kunit.c
+++ b/lib/memcpy_kunit.c
@@ -361,8 +361,6 @@ static void copy_large_test(struct kunit *test, bool use_memmove)
 			/* Zero out what we copied for the next cycle. */
 			memset(large_dst + offset, 0, bytes);
 		}
-		/* Avoid stall warnings if this loop gets slow. */
-		cond_resched();
 	}
 }
 
@@ -489,9 +487,6 @@ static void memmove_overlap_test(struct kunit *test)
 			for (int s_off = s_start; s_off < s_end;
 			     s_off = next_step(s_off, s_start, s_end, window_step))
 				inner_loop(test, bytes, d_off, s_off);
-
-			/* Avoid stall warnings. */
-			cond_resched();
 		}
 	}
 }
diff --git a/lib/random32.c b/lib/random32.c
index 32060b852668..10bc804d99d6 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -287,7 +287,6 @@ static int __init prandom_state_selftest(void)
 			errors++;
 
 		runs++;
-		cond_resched();
 	}
 
 	if (errors)
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 6ae2ba8e06a2..5ff0f521bf29 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -328,7 +328,6 @@ static int rhashtable_rehash_table(struct rhashtable *ht)
 		err = rhashtable_rehash_chain(ht, old_hash);
 		if (err)
 			return err;
-		cond_resched();
 	}
 
 	/* Publish the new table pointer. */
@@ -1147,7 +1146,6 @@ void rhashtable_free_and_destroy(struct rhashtable *ht,
 		for (i = 0; i < tbl->size; i++) {
 			struct rhash_head *pos, *next;
 
-			cond_resched();
 			for (pos = rht_ptr_exclusive(rht_bucket(tbl, i)),
 			     next = !rht_is_a_nulls(pos) ?
 					rht_dereference(pos->next, ht) : NULL;
diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index ecde4216201e..15b4d32712d8 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -14758,7 +14758,6 @@ static __init int test_skb_segment(void)
 	for (i = 0; i < ARRAY_SIZE(skb_segment_tests); i++) {
 		const struct skb_segment_test *test = &skb_segment_tests[i];
 
-		cond_resched();
 		if (exclude_test(i))
 			continue;
 
@@ -14787,7 +14786,6 @@ static __init int test_bpf(void)
 		struct bpf_prog *fp;
 		int err;
 
-		cond_resched();
 		if (exclude_test(i))
 			continue;
 
@@ -15171,7 +15169,6 @@ static __init int test_tail_calls(struct bpf_array *progs)
 		u64 duration;
 		int ret;
 
-		cond_resched();
 		if (exclude_test(i))
 			continue;
 
diff --git a/lib/test_lockup.c b/lib/test_lockup.c
index c3fd87d6c2dd..9af5d34c98f6 100644
--- a/lib/test_lockup.c
+++ b/lib/test_lockup.c
@@ -381,7 +381,7 @@ static void test_lockup(bool master)
 			touch_nmi_watchdog();
 
 		if (call_cond_resched)
-			cond_resched();
+			cond_resched_stall();
 
 		test_wait(cooldown_secs, cooldown_nsecs);
 
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 464eeb90d5ad..321fd5d8aef3 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -2672,7 +2672,6 @@ static noinline void __init check_dup(struct maple_tree *mt)
 		rcu_barrier();
 	}
 
-	cond_resched();
 	mt_cache_shrink();
 	/* Check with a value at zero, no gap */
 	for (i = 1000; i < 2000; i++) {
@@ -2682,7 +2681,6 @@ static noinline void __init check_dup(struct maple_tree *mt)
 		rcu_barrier();
 	}
 
-	cond_resched();
 	mt_cache_shrink();
 	/* Check with a value at zero and unreasonably large */
 	for (i = big_start; i < big_start + 10; i++) {
@@ -2692,7 +2690,6 @@ static noinline void __init check_dup(struct maple_tree *mt)
 		rcu_barrier();
 	}
 
-	cond_resched();
 	mt_cache_shrink();
 	/* Small to medium size not starting at zero*/
 	for (i = 200; i < 1000; i++) {
@@ -2702,7 +2699,6 @@ static noinline void __init check_dup(struct maple_tree *mt)
 		rcu_barrier();
 	}
 
-	cond_resched();
 	mt_cache_shrink();
 	/* Unreasonably large not starting at zero*/
 	for (i = big_start; i < big_start + 10; i++) {
@@ -2710,7 +2706,6 @@ static noinline void __init check_dup(struct maple_tree *mt)
 		check_dup_gaps(mt, i, false, 5);
 		mtree_destroy(mt);
 		rcu_barrier();
-		cond_resched();
 		mt_cache_shrink();
 	}
 
@@ -2720,7 +2715,6 @@ static noinline void __init check_dup(struct maple_tree *mt)
 		check_dup_gaps(mt, i, false, 5);
 		mtree_destroy(mt);
 		rcu_barrier();
-		cond_resched();
 		if (i % 2 == 0)
 			mt_cache_shrink();
 	}
@@ -2732,7 +2726,6 @@ static noinline void __init check_dup(struct maple_tree *mt)
 		check_dup_gaps(mt, i, true, 5);
 		mtree_destroy(mt);
 		rcu_barrier();
-		cond_resched();
 	}
 
 	mt_cache_shrink();
@@ -2743,7 +2736,6 @@ static noinline void __init check_dup(struct maple_tree *mt)
 		mtree_destroy(mt);
 		rcu_barrier();
 		mt_cache_shrink();
-		cond_resched();
 	}
 }
 
diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index c20f6cb4bf55..e5d1f272f2c6 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -119,7 +119,6 @@ static int insert_retry(struct rhashtable *ht, struct test_obj *obj,
 
 	do {
 		retries++;
-		cond_resched();
 		err = rhashtable_insert_fast(ht, &obj->node, params);
 		if (err == -ENOMEM && enomem_retry) {
 			enomem_retries++;
@@ -253,8 +252,6 @@ static s64 __init test_rhashtable(struct rhashtable *ht, struct test_obj *array,
 
 			rhashtable_remove_fast(ht, &obj->node, test_rht_params);
 		}
-
-		cond_resched();
 	}
 
 	end = ktime_get_ns();
@@ -371,8 +368,6 @@ static int __init test_rhltable(unsigned int entries)
 		u32 i = get_random_u32_below(entries);
 		u32 prand = get_random_u32_below(4);
 
-		cond_resched();
-
 		err = rhltable_remove(&rhlt, &rhl_test_objects[i].list_node, test_rht_params);
 		if (test_bit(i, obj_in_table)) {
 			clear_bit(i, obj_in_table);
@@ -412,7 +407,6 @@ static int __init test_rhltable(unsigned int entries)
 	}
 
 	for (i = 0; i < entries; i++) {
-		cond_resched();
 		err = rhltable_remove(&rhlt, &rhl_test_objects[i].list_node, test_rht_params);
 		if (test_bit(i, obj_in_table)) {
 			if (WARN(err, "cannot remove element at slot %d", i))
@@ -607,8 +601,6 @@ static int thread_lookup_test(struct thread_data *tdata)
 			       obj->value.tid, obj->value.id, key.tid, key.id);
 			err++;
 		}
-
-		cond_resched();
 	}
 	return err;
 }
@@ -660,8 +652,6 @@ static int threadfunc(void *data)
 				goto out;
 			}
 			tdata->objs[i].value.id = TEST_INSERT_FAIL;
-
-			cond_resched();
 		}
 		err = thread_lookup_test(tdata);
 		if (err) {
-- 
2.31.1

