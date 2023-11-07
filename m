Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C00D7E4B4F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbjKGWBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbjKGWAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:00:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B491994
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:41 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJoBc000910;
        Tue, 7 Nov 2023 21:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=VmP+ZWs+YonczYedN3nVn9It2wcp8EZ7uEC8aRAf/IE=;
 b=QYkWYwP3sr0bdXStKqMP0FazAJu8gR5NkebLt9m3kjJwwWMOxfk9AyA4hNITWF0joS78
 30eEEXZ8b0Lnina7yCMYZUtHC0b3ROPgEprER8gbmVvmo25GSWuw0pglwzPr9wOXxvI7
 +ehX1w+XsDzpd/Bj83t+QgvnDt251TxyTrvl1YcYXSgieGe0j3a+AtxDvG24rthUExmp
 ve0H1KVVGI0HZzg6oJuTw/GnOFIikD6h8LSCeVQJUwcDPmYM5Bv8pgtGIJyu4s8EIFeD
 xH46J9sdwn0y738nyF60cY/WyFGpKygZz7jDXDsi1Hbp8pjaQJWDoSVjwEzJC+Bx+aE0 eA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g2as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJPRq023854;
        Tue, 7 Nov 2023 21:58:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w241f6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKBdrk2K6FEczQ2InT0jEI8bBHFF+T/0MkPbe3TzzDDIJgo+312qtNJoVIbyCEljzIcwhbua4v8of29nCljGHGldwPeT+bkWF4Cr06LaZOxOseLj3Zj01/Hu3CRmNmIBTDupAYVn4JlegW0Z03nbKH3DxB1iZhOk1YvsoR4o5sVNw+7y/WIOCXEhHeCLvtT6hftTJhug1bR/4tIdwNCh7g1d+6xRk2/B23yZXofMBCQajl5/ZxsHwO3btee4/RKr6Hs0oEnQUPT8jDKimmtkTN2bHCE5eSuJ4bUQULiFGQm0FNTvMbgnMcKEZwKb3d1D+sCBm5G30Aek3v4s2u4itQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmP+ZWs+YonczYedN3nVn9It2wcp8EZ7uEC8aRAf/IE=;
 b=N1ZjqLfwuyz4g7Q4ZgscsxNnwAUTr7eGHhgYJdMXSdrVbXIzeEHYOb7k8hwp/FL994xe2jDR9VwN2W25LfZxcevrn8uo8qisHj1viugIvYkF2wHU2nipxHEGierhh8TQW+3afLZLzysZnepTAV2CGfQjZGBqm8zyxknrLdJGit539Rb0ETE+FlboIeR8PIE5Ka8053VRCW4FA/8lWTnAPlA9wSKJU9fO4OTOWaTLyuYYn9tUwyv2iiVgaZiU6g6AmMTeO4kI3FxbawOa6CRHgznH51yAIuCeUJhj1Eq5wBh1rRDTVHjFPGQDFKCmgjLKk7v5cXUH+tyxmYx1oEcD4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmP+ZWs+YonczYedN3nVn9It2wcp8EZ7uEC8aRAf/IE=;
 b=qszcH+Hq5Qj6WwlyOy6Q2/hspFV0uNQxbhKc+d06hRCDr90JkXWkC61u0nbkWZGU4Gd0ie23b8mPI/jDMT+/1UIhDWGSZCWRQQP7YenHfPBWoAmJVZlOrOMYbY4Ex3mcWStpVvXyAlGBpu+Ezk44mBgESSo+1/gbdd3M6tSNcWk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5048.namprd10.prod.outlook.com (2603:10b6:408:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 21:58:24 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:58:24 +0000
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
Subject: [RFC PATCH 14/86] Revert "preempt/dynamic: Fix setup_preempt_mode() return value"
Date:   Tue,  7 Nov 2023 13:57:00 -0800
Message-Id: <20231107215742.363031-15-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0370.namprd04.prod.outlook.com
 (2603:10b6:303:81::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e612ba-f21a-4375-9bca-08dbdfdcaa4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PFmT2rSQal8IW+hUXgGIqtSI6riFlY0Qt5hGEM2KqvM7qtGHcwipu6PPezpycqyzeVaOqNeOZ9uPwse/czp979ennxZqCCHPPrw7fIPiuXwnRrlrUQR9dGtsDO5y0VpgXNmWY0laiwDOYG2NyHOR6iGE/wqZ9OWbypQ+tMX0rXvrQNaNkO4874/pOyrpZQgy1+CAdTFQ/g5pChY71hMa6VsUZcH7BX35l1u7A6BEiVuDdTcgn//Ydemvfx4HUsBtuvnCbHL68tPCTbvpADsO/RoCLppLG1eTAU+yJhJhY5wiX9EXL982kPAN5q2cpeBx8Aj9FpUoaQZOjgf4pBTwjUlfT1uskYGQXT/iqG9l0MQAB0zcBnJTxLTzzr8ubrhdGcFySGSSn1XuPTcXLanL3zdz39o91o1rKFU3IfBWGXJB9wXwrVk6ndWpriVARsbnUnJadrHm0wHukj2CI2Ril6IHGQjTAvFZteZwPPjGKXz/kQ/kNFEHFNY93WJt/RPCRR2saswC7xCVHl8GnKPoYx6bomOyx/RNcR2jCCrGgo4zM+XgJ3+PXWDV838je6zI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8936002)(4326008)(8676002)(66476007)(66556008)(316002)(6916009)(66946007)(41300700001)(103116003)(2906002)(86362001)(7406005)(4744005)(7416002)(5660300002)(83380400001)(107886003)(2616005)(26005)(1076003)(38100700002)(36756003)(478600001)(6512007)(6486002)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m9naqQ7Au/7KYWjJdG+Sl4A/X3h1KAKyrQz6UC1r6b9Ch12a+xOYTLXQ1sse?=
 =?us-ascii?Q?KJ5Evrw5YHvDoRVaWfVdIw9DQlK9/rSO3qyXIhp1SVnzMgLR9mucESZ4bicm?=
 =?us-ascii?Q?cIcAjTh9TB3yet/tBsGklhJmOaYhoFcpH+pX4dUfbjE5ms0O6h3+USbXDMI+?=
 =?us-ascii?Q?IbR5dQJPvq+zht5QQLdhMX4dWT15hh/NRt+XSr/ZM7TY0+BCq8mxsWD+I6FP?=
 =?us-ascii?Q?7v1ORiS8xXdNPiUUnJoDwLXKdXS0o1XRJaD6zBv4K5InF/j238eT93HQ9RIV?=
 =?us-ascii?Q?1ih1vR6OG91hcWAGHHrymWrCP1Tyn73Rf27XmxMOlvbHEezgCR+C72OFuXNU?=
 =?us-ascii?Q?N8b2f9pYGsygxdgUv/gzieJKXxvVVkRrl8BHKxRQ9i3rK6TjqHiM9aQhzgaF?=
 =?us-ascii?Q?M1OVKQebmOtxEAslI4O3uk+YhoE84EbnJkm+nwYaLCfZiUraSMiyxlpsW+w2?=
 =?us-ascii?Q?K9f4xEKwt2hikXyjKCQi+CigRimeWxIk6dM1DbAa1eznHNZRoR68nEaLTQ6Z?=
 =?us-ascii?Q?e5dfUWP0WU8Ogj68cRL12XimuuoXYF4PyM6NChKcj8d1jLF85l8LCd+9whDB?=
 =?us-ascii?Q?aHb0EMUlKrsuIrWLEv54itoyKZqC7lvTP6HG26RuPOKWqTAn6EVlgBbcAi8G?=
 =?us-ascii?Q?ZSF1QWePPxQvgaimqw9wopaPrzKt8NKDJOWcEB2DZzGCXnuc8kvHE9pFxIU4?=
 =?us-ascii?Q?mEWDzWDfDuBVH7Is2P8S60Ys1adS0WdTJU9XHEYNHKrg+hhqQslofA5j9aB9?=
 =?us-ascii?Q?9j0fb5yWINnwBOtggGoiqMFT0UnDE/TGQUCKSeQ5eC9TudPSmMkXbfl7IMo6?=
 =?us-ascii?Q?GxdgFywxADq0yQKmIMB8EP68DY8zDF5VV3gwTgzywNgSjyaAa889tu9z+cDk?=
 =?us-ascii?Q?+Ks3ERT1pbAZl8aHSVdYnspgiJVgy3Pgx9VWYRO8jCUP31pvN0Xq29qvBliW?=
 =?us-ascii?Q?Ali5Ge0TJ7ehrQFWpsydGrc7ltY3mRGzSzFX22cxnHGeGzDdEa3lImslnREt?=
 =?us-ascii?Q?dF2cvsO2IUvaq1mnI/34vDrmDSIM/G+AR79vv/Iq27Oz2fr1cE5t1MNC8mhn?=
 =?us-ascii?Q?905AO5r3M6G2G0CKIWCKRBzqZVNba0JVER9Z/ZSmpfG+2Q6RGWdp3kkJUY4h?=
 =?us-ascii?Q?Xu1cTi4j4c34DRe6AvH19spDU9lHZk6YXi5e7yxl4DKO8Ml8RB8Y1tFgr2Gu?=
 =?us-ascii?Q?HwNlSq56x1Kx3DodXM0clSVMzsEp1AY9Qx5NMvgEsbXYr8vjNC2Q+g0zY09S?=
 =?us-ascii?Q?95G5tqpC2gZPlecntwZ+bKsAEdSC6RMbqMjquyALSf1ZCa5V1YjgH6t3+YFD?=
 =?us-ascii?Q?cuKT1KNVuqwRvKUoQ0EqRJ3HmgDlqdQO8dasTYZ7pMW7BwwL5Pfro4+3LDWT?=
 =?us-ascii?Q?PdfHARmHZU+ZlvMqLvNx1VAcP1XkbBnJkxKVZFjP2FUxlttmEDk1GxvHzHdv?=
 =?us-ascii?Q?dvEvKPeXwciMH5b1rwWeNnje0j1E2zsFfrIICDif+a9K3QxPReGxYS1uQEkB?=
 =?us-ascii?Q?vYUfe1AhOaHXbHuHHzrEELgKh/I4IZMqZ/t6WmhTR0jzyzapMwD2Oh/azfew?=
 =?us-ascii?Q?2HyDeB5UbQLanPyhlBGRLcKIyyPz4t0AXVfWrcPDFbDu0AXFig6DGCRDjzFc?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?z3jXlK4UbyOm6b4P+/WElCdfFvaDsRp8q5uEQxUTdxYf73hcAi2/UCWVax62?=
 =?us-ascii?Q?hbd6p8tHWsRqoaqTfr4FheLsrfzI3VnSFnjxtZyMvElqa3HrHWZF9KZublVX?=
 =?us-ascii?Q?xFhuIwpHtKSocqFS29yq12Yn8P6CGKTfr8uCasSCT7mLG94MFM9OIr+OoDTt?=
 =?us-ascii?Q?s/0fyWTk1w5ZQwD/FFLB73F4NAx9hSzWwkNRtat3ogdlc8m0MKOF4N5JKceO?=
 =?us-ascii?Q?QUUn8KU15FiT+P0s7CqZMETvZfQPoVJ5hiK0HaZ7E3X/0TERKyRfZnKRx9gi?=
 =?us-ascii?Q?jpDNjBtpXCaBbloB84w/pMb2hRhYM1k6mQn0dw1jdmEfrvHCkWhKJ40Sh2ts?=
 =?us-ascii?Q?RGU3GpULp6fEXuCkxVp7dWvX86WNlimXoEfIzqDt/GCMG6xamm2TMKptIUEx?=
 =?us-ascii?Q?Gsu/9faIAqxTJPP9ne3/c+gfBQcK4kx7RN5330Mq9jcSM7Nv5TEQ8nNgHctz?=
 =?us-ascii?Q?dt69S/UpEwLcHWziFzruUK+BJcD6u3udR/eF8BUbHODMvrgDR9ZqAQ5DO4tR?=
 =?us-ascii?Q?iBvnOUtRSWsU+YkpN5yRv0ulSVaZoXzz6yHgw1cR4Bj7OpP4D4v3kyIn5w3k?=
 =?us-ascii?Q?6aVXaWBxRk3ljiqp/Maj8qa8ufzcW9n+eksukjcAuVvxVkoKBKWkzIYQnxxO?=
 =?us-ascii?Q?7naIyeZMdYq6W+L9AFgIr1Qen4hO5EHdfOlRHX7jvYKJQiyfDDWwx3nUo6Rd?=
 =?us-ascii?Q?w2NyOtL+jEfDCDUDjZd4wP/t5GnuVZPyqpdgRdD2PvFXIMtU5Gy6gzcMUugO?=
 =?us-ascii?Q?RXis6A9MTTu70ei0yFIO7SifyYlBrie14CTr61SZFhA/Ur4TMXCX1A1WCkFW?=
 =?us-ascii?Q?hYK0tT1UaT4uL9HvZJcVhLzSBKTpWJuH7W4wH8tGBpOgoTWPvU+zqWLCadBh?=
 =?us-ascii?Q?NvkmXMQe2GUl1wO68243P7o66MP3b0xDv/QvdgnPoM2ZOvgY38xnkSoAcYNg?=
 =?us-ascii?Q?NlkkhmvlHIW5AHl+P2qJM45XeLDXpql5VYmSK+nAEaf0WISGhIN5jvvBL+f1?=
 =?us-ascii?Q?wGap4cxehKqJUHBQeOY+l/11FCiKXJlCdXKqK9oYIvuZjmr6fYaO1Lo/Q4hA?=
 =?us-ascii?Q?DfKVctRswmWVczwK60mOaVr+RNJBWksIlwBfUPRvcTJ4/gbtOUJnmKfzwVpS?=
 =?us-ascii?Q?U7AZZKEiExuPJb9/JnMI1cpjEcEzTGcJg6za78zLd11N0Yxt+XHBCl1ERHr8?=
 =?us-ascii?Q?eq4khIb1zE0XLhwpedxkEBY41y35TGiuS1Dow834kjSeUtP20co5AbYSF/CO?=
 =?us-ascii?Q?cdWQbTrtK7q+EIzBb0omo3QzAKbzDzfWZXfLCrRvHNN9Wy2j6/G/GVrLl3/D?=
 =?us-ascii?Q?Ql9ztF1t0DmbuBj5n8oh/RzVGRWnlSCSnAHhFIDlaTa648Bm/v7SrcoQp9Y1?=
 =?us-ascii?Q?TyEjDXunSLxx4m81EHQ0hKX3H/eVcAOzhFjveyc9of/gMJaDsYDy1aXPxWTu?=
 =?us-ascii?Q?lZtcjZsuGWcGnQzgsCMiQGYCkXJDZ5tGDcw+66OK6r2NQR6kXzgcH3WKvan/?=
 =?us-ascii?Q?l+oLIT+XLONArGlLuFoctXulTl7xrMUuQdbFZk+ZVPK+479PpxHH/tQOyg?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e612ba-f21a-4375-9bca-08dbdfdcaa4d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:58:24.7484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFPpV2hG2X/Wg4ImLZjqCQ3UdygvEPE+reIxZe29utAU1tlXGAy3vxgmM94L/MiDzvwUIYPNH7ve9MDgbnfAcmAdJLy3zRedU/DLV0zaCXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=955 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070182
X-Proofpoint-ORIG-GUID: 3ITykoKS-g5GdNFIEjQEJ328xqm7QPj5
X-Proofpoint-GUID: 3ITykoKS-g5GdNFIEjQEJ328xqm7QPj5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9ed20bafc85806ca6c97c9128cec46c3ef80ae86.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f8bbddd729db..50e1133cacc9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7062,11 +7062,11 @@ static int __init setup_preempt_mode(char *str)
 	int mode = sched_dynamic_mode(str);
 	if (mode < 0) {
 		pr_warn("Dynamic Preempt: unsupported mode: %s\n", str);
-		return 0;
+		return 1;
 	}
 
 	sched_dynamic_update(mode);
-	return 1;
+	return 0;
 }
 __setup("preempt=", setup_preempt_mode);
 
-- 
2.31.1

