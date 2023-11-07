Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5C97E4C8E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbjKGXL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbjKGXLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:11:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DB410FC;
        Tue,  7 Nov 2023 15:10:21 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LKAVx026491;
        Tue, 7 Nov 2023 23:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ubSSabi1DkbNzk7JOVGv3+ttjgZ4hE49pYPgn/BH2nQ=;
 b=YZjjhSx8kkRvxB9s78H2tZHxAShvX/ZVJyaNjWdT873N8ifA4Yrp1yrNDKVy91F2nvl6
 XjEUQBiXjlcZkNzqx6qP2kYm5xyHwEe3lHeCYuuHeSM+IDRAMWQZKZGlJ/Pwb+Ltccld
 yiVnqaNgTpMRYjPffVbp7JC7TiwEzkZ2KqdVWE4DppHj9vvr4bYjzlnhYRQlnHh4jLcO
 8UvxSRmsjn7I509835LemL5HgNaCCL0pWRocFxPBtX62shQRr4uU5xO0Or8rlEcjIa3W
 m1X3sZFZU0BpL3a6R+zHtYjSwErMPsrL5UKaHf1ih8bsK4Ilz5My/2hw+XNlQuPFa1tE Qg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2106w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N2f9x000483;
        Tue, 7 Nov 2023 23:09:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vcbqc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2zdv+YFWtQCr/TRto4loLkbexHHc5IzGQRGnEtcDLSnKdnkuW3QYmY/hRjAHOCpGI55YU41yS0yADb1GdVEdCpY59tKkvEJy81NTinkxLMXvupvMwHj/2JHwVdOalDv5jTnz9VZIu0VFYk9hKqtZR2V1nvVpU1zd0yyVP3MwWoNGoA0AlI09uFWsHkBZcGKZZZR1y0ostyy3TJt+t7ONgknLk83I5fFtB1y06Gf0F7oCwJ+WHD8ZvGVI6Kr2bZRcvkxT4IzqUspwPM+ex1rzBIpKdeu4Utk3sx4PwZRHpZP22dV/nigvFOod27qmrQ8YjREr3A6jo/Tk5Vu6G3VRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubSSabi1DkbNzk7JOVGv3+ttjgZ4hE49pYPgn/BH2nQ=;
 b=XetBG/cUle5n9GjqczmVVV0OEJF0epfVWHb4Oz2wCHv5lhwPtcok9bA2QhzrlWn5Cw+NvpeQGp6qNlymSCa5WImcnQavnsxW7HJbwbsRdFFZNhWcajuBuY8SZ9j5pyfTsnF0Mi/Fjvki6mYRZMO3Y3e4RKTpQ9sCms3y03oxCP3HlVroKODwegr9ChYGQ+GnU2qr52sSHSHJBgXUA8c4XoP3ieuGUS3FQTgnszuqBbxDc4RaVNl8J0c7EQWg3AChPE9dOQi56dSccqUMrsZ6TnD4snnx6JSaotM5rKSeqB4C0n4C5ugJALhUtbdX1ke+6jvg+/murPiyekS9Fd2Qfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubSSabi1DkbNzk7JOVGv3+ttjgZ4hE49pYPgn/BH2nQ=;
 b=pxPQE8wEo4d/9INiPqiX194CoOLmCWRjKN/7lr21dfW14Rf897vbhI/1/0xr+0yxotBsz+b84lqMvpuOOXVUz00hQ1ohZh7uUowE1LGeYmUy1LHMjvgVCJjYTfJLPO1EIHB1h9FR8bV4AFdjjjhvk08+zxIuhy22e0pHUhVlnJs=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 23:09:15 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:09:15 +0000
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
        linux-crypto@vger.kernel.org
Subject: [RFC PATCH 72/86] treewide: crypto: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:08:08 -0800
Message-Id: <20231107230822.371443-16-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:303:2a::35) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: a0685657-119b-4024-0c99-08dbdfe68fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hibqIQmikvZLwNkxQY4XS+5+SO+jl4xJxbRXH4cFnkdaKgM5Q0t8V0b+US/7x9RV+5ZY8ZN17yN0FXS2waFxSwIa4dlcNy2z8bQPEwTKJC2Dy6tkpNNJNFoNiISAzqoGJuc7gJl79rozI3XtJAc+pA3MlDBPxnNTzOW+fbwnulTqHFpKfJUFuaKT5u44UcVz4I7XYsqM0xkRoe3QzdH/XgD+Y8CJ/JIw9lA1zGtrJs6vs+mmpewj9uXF4DjEk0FjyotZEIrT6U4sBo/chq2D+t//jc2Qi6Z0shWkD7O6bihx9QAnc2CYLYQ04Ej1Zc6YsrqX3GEv59GFMwPdPqMBHem6ixirHGNJVPzfkwN/T9YV+qiAUM185f5diqw2Nph5/M2Wa0GyX3S2x3muSx78ckeJ+wS+t/0DXa/rekv+zvj7ql8wtz8lJC0DUpo9MxQT6ntg+hJ+cy74Qpaf+ZPXSxLySHBwtwi8n9J52LlIxjVw99sdNI/8Qmw/J9W0Cdjxq8PX2b6TfWl2HGHO9ZOqofI9YDhl5GHUqFRjE8FUQys=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66899024)(6506007)(478600001)(6512007)(2616005)(6486002)(966005)(6666004)(7406005)(36756003)(103116003)(38100700002)(86362001)(1076003)(41300700001)(7416002)(5660300002)(316002)(66556008)(66476007)(83380400001)(2906002)(54906003)(26005)(66946007)(6916009)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QmFaoxhvLBr2vpNs+/NpvQkDp9gX+RETONYKJ+9C3SRAMCYDuqsJXdICA8Hu?=
 =?us-ascii?Q?jOSmNETNiODgZrnuDhpzhhT4H/0fkFWVteTOl8hEZDoAhNUZqjsWHOCI8KHd?=
 =?us-ascii?Q?TmlMvbBuo2Evf67viojuqS+fogHKFuHcjNBKvh44Q0L/9WgOyRUoeCsfjdq9?=
 =?us-ascii?Q?3Iz+gGIzhIwM7idlDSU3Ne6h4Pbx4va1gHF143X9dAY3Rb9fyi/4xQcpPmF1?=
 =?us-ascii?Q?FS6Jzzc6jEXVHKVxtSesSphhWvNHN9VD1n62HWufOqQjetIa1hRlLV+SfYdM?=
 =?us-ascii?Q?D88DJOt/C2kuLvJFs2rjwgshQd3JBmX29MtuyNDqAHP0LhdXHG3ENG41FuRT?=
 =?us-ascii?Q?aHS611xD2UDwVLEKnsDUqmFZp2kExFZIraQnO5S/b2OLrCpEVMVHl9CcUgRO?=
 =?us-ascii?Q?LH1N/E7T9YmL0ItpFiFL+7GMiA8IsGacxyPp3/owj46vrnHKzP/py/P5ycBF?=
 =?us-ascii?Q?Zvt+8qAWycxFm9+vs3Y4osHT7Eav0uZmpF0qvhbYMjH9g0em08PjHxl26kHS?=
 =?us-ascii?Q?x/io6WjjQC3lYCueAh4DE9tpfSPAx1v1U+P3fiX/ZJbpN7vvFBT7mewJw+wr?=
 =?us-ascii?Q?0RKi3UMIcX2tjn7Gfkgnuk9dhQ2+MWNQyB0KBkqQH8CwUoV2Zw7k5G2n6AgG?=
 =?us-ascii?Q?oIYOpRMsMDyAdkeFn1DylWIIbHtcE1OTWkkmbUSJf13h57pVa5BbAE/g/xHs?=
 =?us-ascii?Q?LYI0XRytkDFw9vAfWzjD674Z9SRd6fbo+MX3c45lhkWCoijLJ9/zrbS7c8AK?=
 =?us-ascii?Q?YrT2T74My+hOD44rRqIQEDkfe7QgP1kryFcMaArQXCgIE9jgHL1TNRmZACzF?=
 =?us-ascii?Q?hzx2DrPXJF3Szc/nVAA8aMag4IMqhQnoceDPBr8YU0mqbHbLsJXWKgA3S767?=
 =?us-ascii?Q?aRDu4u7qKZuHGx7VWe7+54BguwpSHNe/btoZesUcbjjZm+v2QApwNkjCYuwy?=
 =?us-ascii?Q?mrMXLanZqS1A2j067oLC49n0ktKJlMUa6AyZm1/G3/xPeZfcQAiQhMRCu5hN?=
 =?us-ascii?Q?1pIhw+YHmxHBFq6aSTPCklge0p5qwm5/C3I3lC/3vAL4P+ZCrWKY5W570niy?=
 =?us-ascii?Q?Jpw5SLG27/bcw7X58qRIBPMZhdDLtmlRH5mLVLHXAVfl02OzRC6gFpGNkkfC?=
 =?us-ascii?Q?GYY92KSvU4zXEsPB6uPl0mjwjqxxQbbtJYxfbL0108EGWz3B+Zpe222aDTcJ?=
 =?us-ascii?Q?6epR5HmfKbg6OGbX2uiXIoATJrMMf7oC3J1oDuuPzEvWKLnPnkPNhw1cqK0c?=
 =?us-ascii?Q?pQoPg0AqbavN1J4hmC98vjMUh8Hq8gCM1WdlnaDH9kTmWUF5DknWPPSURE6l?=
 =?us-ascii?Q?s1X1mutW0TZYvFrGwizwjkQ89tugd4uXWOfeBFYXCCJoQHhDCegcKT0NbBFc?=
 =?us-ascii?Q?gWhae4R0iSpdR+1fX/X6ZrE4/F0+ewdqjh9uZO8XdPfIYDR8GUvjjlNPBVJT?=
 =?us-ascii?Q?r1SziesYqt2auJ0yD+qG1ar4d2EFQ1i0KTZadJz2mWfR0SXZfw/UKPw9FQfH?=
 =?us-ascii?Q?M9XFmM4Inwhv0jxFvRRMGd8lcZJi3PpqBohicGvK6LiYI92DiAPlysiQUHCX?=
 =?us-ascii?Q?Y0fjaQhIAPAsaVbEE/LIrfYStSNdCl6+Lys9xz8ZFz41yBnh6XVFhW8yU51w?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?1LQROmxJrec2T0+0Y7BtTa1iRSXfE8GlQ+ZLuI7+vQvwgxXqlN8+MH46EOXV?=
 =?us-ascii?Q?1ixGnnzVeuqywOMh/BdR36+dXahmaGdRS8fR4Y5BKLUYbg99mOkR5mOpL2az?=
 =?us-ascii?Q?ZxQXshdGQxgjFP05yV3cwE3emWo/7McvxzpjMeeK3VYaNkW1bt68e16LgPbp?=
 =?us-ascii?Q?Jq80kHBaF/1GpWvoXpesVrFjcSW5CXZLxviTKruljeRdLrQ3pfKkI3jzoK57?=
 =?us-ascii?Q?nMgHz9JURSLxSIwVtNT+iXbs1f5GEmVHXkovNv/vti+C1+mRCU3MrEa9oeei?=
 =?us-ascii?Q?KlvIeVsrpwMaZwofpJAAwPGfmiH1GSSIEVfeVV7ZL4agG+U0AzKFTBIjcEDY?=
 =?us-ascii?Q?PJrL6+HtQrWx4QiyfDxpTty3xWMiJibZ3IrnK057oS5fdwuA7FXH1EwHeQ43?=
 =?us-ascii?Q?mrOvGevtS5Tw6d2ZUXG7i1nxEDPxLb8pMJV/6mrxUHdgGj3a3rBokjSmye4E?=
 =?us-ascii?Q?JnjBSf5A+LK4gWbaw+fgPypdhUzfug+q1dRPNQL/JMIq8PFGF8AOBmN/RLK3?=
 =?us-ascii?Q?0DcmoLhB9iSlndwLDgIGUkQh4VikEE1c1CADWV8MwhDZ+poW3VhUYlDRxp4X?=
 =?us-ascii?Q?rwjfB4wWV9LUehoMLHsLSyuwNJjpE3qvHoeKgsDaNDiFByyk+PH8NSFYtuLx?=
 =?us-ascii?Q?lctauhtnN1QrXkEItym13O4TfELusGV5pKtdWU+Gqp0c8CzG0tf/XD2zNww1?=
 =?us-ascii?Q?mFwNzCrln7oUGxduutAoXOxwax+pI3ed31z0zOQHRe1l0koXWNLawlVNJVgb?=
 =?us-ascii?Q?dprHLej1JZJBasHtYDn0uJIgTTd1h9jIreU+LfdmrZzncI0/wV9runhjCu00?=
 =?us-ascii?Q?lF0ALWAj385HfOlEAEWop939H6DG8z+N9pHvO23rBchQpgDVgOdo3UTELAta?=
 =?us-ascii?Q?RFB1yjnTmEPWHD3/fAE6TtICEJRUGNkx/8O5eFcOpvzIU010LHK6Zo48lLF9?=
 =?us-ascii?Q?DryW3wi/tHP6bgvpqNcX+VhjJ32b5DAnSWZANqCoKTk7WHpA9t8j/NeHVKhx?=
 =?us-ascii?Q?2OwzmHe4ANR7QU8f9vcMDGhdZAs9XL0QpKIH86rgT8UrnHpLcLYqJL1cYixg?=
 =?us-ascii?Q?xt2M42dG9ia6RGgvoCIzyLgpFW8hZa+i1lw2/ksapJTLhLAxsSbU/aQU/F2W?=
 =?us-ascii?Q?w4mYyrJ3f6EGSxGPn8tvtDfFH02tDIjVZkItab4yXTk7E9zCAl+unUNyHjFu?=
 =?us-ascii?Q?gf8H+gj/ogfpIhQkQEOBHsxZ59VUhcBEN1SYZOdcVCQeqvp2lJL3c78r1LPl?=
 =?us-ascii?Q?WnnjWWE8avhULPbwwNbOr3LA/PQQz6jqBSufMMKrdY5vSzVJd8ncT1281QuP?=
 =?us-ascii?Q?iMGFoXVgM7xXr+wiIzjg6tUDUSOizsCiFazCmRcMug+oSaBrEAiUjDGaZa1v?=
 =?us-ascii?Q?DjQgVqstnBngXoKzSKu39XA29ypDQW9Wdxrzla528wYgsQ4P8lO9iH+pIBR7?=
 =?us-ascii?Q?kxDY/W8WwNW52nJLW/1dFIRw0BLhGdcNHnrUPHpy+d9qfIrsOK1j4Yc0Jbk8?=
 =?us-ascii?Q?e7a7QL+P8dgpQ9E+Njw8D+rDtKSirMwOcK+8pxioei84zdnTTMZpOoqE1cEB?=
 =?us-ascii?Q?X7Gktvxj8JuYwMf4TsPwQsb3Kwjxi2tYfwBzNcj37/nAtbJEde2oTzPUquLa?=
 =?us-ascii?Q?AkgsxjGEY31XwtPXlEbqRcY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0685657-119b-4024-0c99-08dbdfe68fdf
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:09:15.4081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NtKdShpCoQXoEBFJxwexWGscaOH2LbU/az3HIrsmxnJiWIvK5khdqb6hfxzH6htdX231YkmrA1dhirZsquaXJQeJddPaHFOtKY67eCFKuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070189
X-Proofpoint-GUID: 9yKLveNn3SwzMjm7TqkA5NJ6G5vwuK7o
X-Proofpoint-ORIG-GUID: 9yKLveNn3SwzMjm7TqkA5NJ6G5vwuK7o
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

All the cond_resched() calls are from set-1. Remove them.

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 crypto/internal.h |  2 +-
 crypto/tcrypt.c   |  5 -----
 crypto/testmgr.c  | 10 ----------
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/crypto/internal.h b/crypto/internal.h
index 63e59240d5fb..930f8f5fad39 100644
--- a/crypto/internal.h
+++ b/crypto/internal.h
@@ -203,7 +203,7 @@ static inline void crypto_notify(unsigned long val, void *v)
 static inline void crypto_yield(u32 flags)
 {
 	if (flags & CRYPTO_TFM_REQ_MAY_SLEEP)
-		cond_resched();
+		cond_resched_stall();
 }
 
 static inline int crypto_is_test_larval(struct crypto_larval *larval)
diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index 202ca1a3105d..9f33b9724a2e 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -414,7 +414,6 @@ static void test_mb_aead_speed(const char *algo, int enc, int secs,
 			if (secs) {
 				ret = test_mb_aead_jiffies(data, enc, bs,
 							   secs, num_mb);
-				cond_resched();
 			} else {
 				ret = test_mb_aead_cycles(data, enc, bs,
 							  num_mb);
@@ -667,7 +666,6 @@ static void test_aead_speed(const char *algo, int enc, unsigned int secs,
 			if (secs) {
 				ret = test_aead_jiffies(req, enc, bs,
 							secs);
-				cond_resched();
 			} else {
 				ret = test_aead_cycles(req, enc, bs);
 			}
@@ -923,7 +921,6 @@ static void test_ahash_speed_common(const char *algo, unsigned int secs,
 		if (secs) {
 			ret = test_ahash_jiffies(req, speed[i].blen,
 						 speed[i].plen, output, secs);
-			cond_resched();
 		} else {
 			ret = test_ahash_cycles(req, speed[i].blen,
 						speed[i].plen, output);
@@ -1182,7 +1179,6 @@ static void test_mb_skcipher_speed(const char *algo, int enc, int secs,
 				ret = test_mb_acipher_jiffies(data, enc,
 							      bs, secs,
 							      num_mb);
-				cond_resched();
 			} else {
 				ret = test_mb_acipher_cycles(data, enc,
 							     bs, num_mb);
@@ -1397,7 +1393,6 @@ static void test_skcipher_speed(const char *algo, int enc, unsigned int secs,
 			if (secs) {
 				ret = test_acipher_jiffies(req, enc,
 							   bs, secs);
-				cond_resched();
 			} else {
 				ret = test_acipher_cycles(req, enc,
 							  bs);
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 216878c8bc3d..2909c5aa4b8b 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -1676,7 +1676,6 @@ static int test_hash_vec(const struct hash_testvec *vec, unsigned int vec_num,
 						req, desc, tsgl, hashstate);
 			if (err)
 				return err;
-			cond_resched();
 		}
 	}
 #endif
@@ -1837,7 +1836,6 @@ static int test_hash_vs_generic_impl(const char *generic_driver,
 					req, desc, tsgl, hashstate);
 		if (err)
 			goto out;
-		cond_resched();
 	}
 	err = 0;
 out:
@@ -1966,7 +1964,6 @@ static int __alg_test_hash(const struct hash_testvec *vecs,
 		err = test_hash_vec(&vecs[i], i, req, desc, tsgl, hashstate);
 		if (err)
 			goto out;
-		cond_resched();
 	}
 	err = test_hash_vs_generic_impl(generic_driver, maxkeysize, req,
 					desc, tsgl, hashstate);
@@ -2246,7 +2243,6 @@ static int test_aead_vec(int enc, const struct aead_testvec *vec,
 						&cfg, req, tsgls);
 			if (err)
 				return err;
-			cond_resched();
 		}
 	}
 #endif
@@ -2476,7 +2472,6 @@ static int test_aead_inauthentic_inputs(struct aead_extra_tests_ctx *ctx)
 			if (err)
 				return err;
 		}
-		cond_resched();
 	}
 	return 0;
 }
@@ -2580,7 +2575,6 @@ static int test_aead_vs_generic_impl(struct aead_extra_tests_ctx *ctx)
 			if (err)
 				goto out;
 		}
-		cond_resched();
 	}
 	err = 0;
 out:
@@ -2659,7 +2653,6 @@ static int test_aead(int enc, const struct aead_test_suite *suite,
 		err = test_aead_vec(enc, &suite->vecs[i], i, req, tsgls);
 		if (err)
 			return err;
-		cond_resched();
 	}
 	return 0;
 }
@@ -3006,7 +2999,6 @@ static int test_skcipher_vec(int enc, const struct cipher_testvec *vec,
 						    &cfg, req, tsgls);
 			if (err)
 				return err;
-			cond_resched();
 		}
 	}
 #endif
@@ -3203,7 +3195,6 @@ static int test_skcipher_vs_generic_impl(const char *generic_driver,
 					    cfg, req, tsgls);
 		if (err)
 			goto out;
-		cond_resched();
 	}
 	err = 0;
 out:
@@ -3236,7 +3227,6 @@ static int test_skcipher(int enc, const struct cipher_test_suite *suite,
 		err = test_skcipher_vec(enc, &suite->vecs[i], i, req, tsgls);
 		if (err)
 			return err;
-		cond_resched();
 	}
 	return 0;
 }
-- 
2.31.1

