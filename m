Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A712B7E4B65
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbjKGWDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbjKGWC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:02:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C5F3244
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:00:25 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJpqh020714;
        Tue, 7 Nov 2023 21:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=7gwOtmpFNcOX3GHmuR+gkwTDS4oyS5CLF3RfFTaRkeA=;
 b=RSF4q7dL+sSiBGp8RCV4HseQ1NAaAaisPU4uzW9DgbcrnwclLfxDtSxnKrWEmVSsNYSY
 JXxJcVDuFqGZfyNYMOIkzXbdzL6Gm50FXvE934n3TM2XAb4IBawQfMZ1kB+8aOlun9mI
 Y//BAg+6KjwbKSmSYNd+cT3MYezavJkDkPvsY3y2vZCxrxpZWXcX1gpPJ0X+MFuHQUA6
 Ix7kA4pOUNZUDVzbeCv3PxOBC3mgYF6qfU3MtdhyyHtTRn7WxYj+oFmuuoqv11wl8d7E
 sPi31iLpjuJDn1JznRGqtiUhcFPetWucO1XdEtYt/L60OITKVc1uYZ1Bz92mKUz0jM71 /w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2202rx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJ6dH031876;
        Tue, 7 Nov 2023 21:59:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w221gs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juPLl9JebQFwr63TdhgZC/oZN4D9KVDbOTgZ0lr7HX2qzxVbfKrXtpewblwfVKayAuE68Xx1uv8SUUZe3kHXAZLy/STF3y4M+xVXuGTmUQ3PQqlzL+jFcgZmmYBRo7jtBowmliSAURGrEoxFotcNdR5GeaCm89XGySz573x8p8wB/iauVf5k0uvC8mH16vSCEjvaSXanEFSH0LVViExtCNnBszy+BTJt1eWzfhdqVgZqX8wP+jwOtzNrpkPte/FlyibKbGC1EPsbwDvvF7BWVPtnQnDLVU/q+Y32H7VqDkJzVkiEF9kwSdwlysmIrkXm9w7uXE2r1ZuJt7CtRLb/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gwOtmpFNcOX3GHmuR+gkwTDS4oyS5CLF3RfFTaRkeA=;
 b=CVfL2APtGEiyXYxefjrwDQEEa2LsiLWoWXqz+iHmqAsJPOFMr5oZMgk9pn+EqZ+qUn57yHacGoKDcNY13iO7CknQZWuk1efukEIa9nSlm1HVtIOJ3wnkaFOBVDVngn8ZnVCwwhUp//CUqNRA8cJjs3V+FqRBRFZeslRjchH90bUFkkHNtIxKbJzoVSpiXHIxfLm+OS15/Ep1314fPMxwPPHOiuAufz4fxor2UaNyq6Ny2/If03liXQxpnPSiTKSRuVm5T+SXN0ooWJ0HpLeSv5dMlJ0+l1/qMeitsUnruuwnEMEVhz3VqocmxbOd4pj7VLL/40BGRliYxkp6c+NQ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gwOtmpFNcOX3GHmuR+gkwTDS4oyS5CLF3RfFTaRkeA=;
 b=Bjr70j2H7S6b0tulyA+R4CrKqn+OomFQGtOHXw/W5DjXAvzjrwxtUUDQI1Zir51A/5eZMUIHgr5N/JWXHeazN/b0hvcEGd17gFCSGJyuRa5iNqyV5SnSfH8tjX4vXADVTSkd5Ae38XmInz6n8kwiJGeQrMktNpa4RQAkrpbti+A=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6141.namprd10.prod.outlook.com (2603:10b6:930:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 21:59:29 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:59:29 +0000
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
Subject: [RFC PATCH 35/86] thread_info: change to tif_need_resched(resched_t)
Date:   Tue,  7 Nov 2023 13:57:21 -0800
Message-Id: <20231107215742.363031-36-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR2101CA0010.namprd21.prod.outlook.com
 (2603:10b6:302:1::23) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa26d15-263c-44ee-ffb6-08dbdfdcd0e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CpR5+w4tAIaxbJzZP2f3z9YDc6zHEh/QBh1RIbJ55kD4SpIIoxYsl6mylXQw72mQEdcm/uN6mkF357MBk8IxWhWfBZGzBg29GmYkSrEHeHhZc1O/wMOLB6LzF+uKtM5iDRoB49zonc/dTGoFjO40dBXJmCcKgPh97mhzGeZTPAia4B2P+YWwjRNSv8Fj21ozhN1iVRMzibblGRATleWn24FsKWfkjSieJmBLSoU/FPrquuH0mQj0FIUZDjthG8XghBQmo0dGbzCHXPMYsM9ndg778HJZBznBcub2NRXWGFETeVoeBf7kcNuWfQ9uR9Crj9nSq7eMoYhK8owmLzsCe792ZOXBaTK7NPZA+f4hGNChm6LUcaPLtnsCTaMJxXsoog7yq5jqWmmGFf+tY+9W5w2E12IezFS06IzCb2ll1XN2qY8Eq7/Kjjxyq30qICkcWXm1KvGgnsyBgpGh5xeLRgnkog34uwQ7fhjYiD49RY7eGlMmjfoB9nq9Y/W/+k5+xSFRzUIcfQG6nqu/ZDXbeZnrVgB87cPvPB2vbFgXWQSG3XfLv0UdkSJL28Z1Y0f8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(86362001)(103116003)(8676002)(478600001)(8936002)(6486002)(4326008)(6666004)(38100700002)(1076003)(5660300002)(36756003)(6512007)(66476007)(6916009)(66946007)(66556008)(316002)(2616005)(7416002)(107886003)(7406005)(2906002)(26005)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bbuCzGxq1q7LjT14re3x1l9lPtuPx1IBOSm9q+1E66HKzGyEzFYmL4XccSVr?=
 =?us-ascii?Q?i79eZcFkJTt1tx02WF2Ffw15/oNttp8NFbdM2EcOgNHIPv5eiF+tJ61enhPk?=
 =?us-ascii?Q?kQ0pVxQK6JUxachYkcOOmA4Yzn9SvPWCdxmd+4JEVHBR0KjN1lU8JEuE90Iv?=
 =?us-ascii?Q?hP9KzYIrXYj8CmlonlDpXCnez12jibqx+bQNhinewb9WRdgOa1lTJ+2P+K+M?=
 =?us-ascii?Q?tNCjD1CtRDqZ7grVRe0zrgR5PyDrw0hPNGXrSUNiHkDMO5Oq/3KbIfQGSDZX?=
 =?us-ascii?Q?tFHZ7p3tk62Rm7zFReUkCLjOH/edfUD3rzZ0wfx2Nk/xyhWFL8E8knIHKTRt?=
 =?us-ascii?Q?p5H4UhFgmU+/uZI5yAQONIz03J20z6ad2hmA8Qz/O5p9IgNSiwotsGtOeKEZ?=
 =?us-ascii?Q?bbUrGvAuDrDarFpbCEr1dEPyiBeUNcIYPCml/xc95UEsF6o4T1TrKbd0CGQ0?=
 =?us-ascii?Q?Rf8r/Qx1Eh/I0g/EMYC0UWfqcDQcbFZt+yF6OYW5GB3TIbpt7fOzpPjovEOj?=
 =?us-ascii?Q?bJhn9YeS+CPgs1woIiDK/A//5IqaQOaTgckn9DUBrWCVTjD/96EsIUsi3dr2?=
 =?us-ascii?Q?cR2YbW1nHZ4lByXeNXcbfxFJbNMkTh7IV6N5bJcUnGYSKr6DdFdcPec1sORA?=
 =?us-ascii?Q?ZLENaffUT/zhrcZWfqPuywZyiYROb8qwi7QcDHM/kAX+dZxV1aMkSG9Sftiy?=
 =?us-ascii?Q?SX/Uf23/JBYGUcrNNzIFgHfmanv6f4pyzIhiVdbm1LlGfbqURn19LSUOo1Kc?=
 =?us-ascii?Q?e6srR2/tawsXEbeiwXAy1ZpHdwekzv/PCIgSAm0hSXF0DNgA/dbHzR0xWDE0?=
 =?us-ascii?Q?QFo3oqoOHpxshE+Ze563o0LzIc5LfbWcA0rMrKp8hzIThrgzaFn9G4gzmYn1?=
 =?us-ascii?Q?mon6JT3wzfKhapDPyl2a3kSEUxE3KNzCjVzs4zbYlsJ/ZBmTXeQ3o5Em4Zwi?=
 =?us-ascii?Q?IGGQ1zdkRl5hYciGZoocgOSLaKEew+YQaTpslsEJbhzPBascRhBfgOMlOR/w?=
 =?us-ascii?Q?vnhswRCj9/x2JmbD5X9oHAc+iciEd79L3RJYns98t9MU1dToPD9D5h6tjmfV?=
 =?us-ascii?Q?fnnU9MfjYTuDLsT8a3MfMIKFRP65UHAFfK03gkDoF41HmNuge7BD+I92xCQ6?=
 =?us-ascii?Q?belsuB/Ytvtzc349eEYyMUg32qOP9+RjiApUX5qhu5LkDEGPMMmI15WPJHKP?=
 =?us-ascii?Q?Vp7DO2VVAF19rcafXXUL8l7mnYRTu9EPn+GD30c0ylodkVK4lgZOwlsIdbQy?=
 =?us-ascii?Q?hM0p3jLaD9vErY7KZ47Bml8exAfK7lX/CbiiYJvEJVQhZDE6RsO5ITsk7wXv?=
 =?us-ascii?Q?n0yggiYzagQ++ry7Kp9JR5Fzyt3wlT1fdxVRslf8WJytpUZ5D5rO80qrKbaT?=
 =?us-ascii?Q?eqpan72EdlysQE/xz3CxatliYqfeTdz/naA67Oj06Tts6Sz+3wzaRGt4pK5A?=
 =?us-ascii?Q?hPnXdWNF6qoBfGTOVnebTrq8ZnGXS+up0ae5AEeFymrRWUsv2Zrz3b7gymr1?=
 =?us-ascii?Q?RDvJEQg8H9BBj7QMPEMJqOmDmU8ht/POriMiP4Oftx6F2kYc/r7vLlc2G7T6?=
 =?us-ascii?Q?K7Fd2i8lJ3nVebYHrccRIw7tEXWjuwDcXNUdVQSrQzM7Vl6phGaujn9q3jsx?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?iS76vISTixVSPwUEU/zXqFpaaCG0N7SQFuW8fflI55XJY6FXNTWfayOZHodE?=
 =?us-ascii?Q?KT8mxGapyRmm9CiU6cAP+4qm5nQDa8m8t92vva0rVnlVh7fkth6PfLBDnoJF?=
 =?us-ascii?Q?viPRuit76cgnwqDqSZFFyOrpEQXQCdJGuoQjr+L7pkwgbCEvTt6eDlsXfr7e?=
 =?us-ascii?Q?IRVKKQZCb463u6Nu6sU69FHWmBOH6hqFnoR3UXyKQaRNN+XOHCAAR45hHGnm?=
 =?us-ascii?Q?ETskctydtQD405hPrNjzVDVEBivzmMz7Unr40K5lFlO27J77CKjGw9s2q9cl?=
 =?us-ascii?Q?C0uwjce50/M8LGqkgdeTS7+eiCmZzDwtxaLKQFetx0zQygWhpAs03AMv2ZOX?=
 =?us-ascii?Q?SIKZFOEa06xirYGGwmuTBlmt2o3GckDbECHTDUvdBXiE8UXI58MHXnniKzu/?=
 =?us-ascii?Q?sOrXjdUIC754MwewTCj2wz1/15GG0a/L7/wB/KiBhd/kmnOftbsI44N3X4wO?=
 =?us-ascii?Q?549WNKRDBXjHpUrG+lrCiKkhiYSooj9YDMKJeviH+9ZDTaTVP8yokLMU8XLU?=
 =?us-ascii?Q?pq05yYJ642ug2zOM+wJM1FzdINwtflrzbG5j+bKGbRBokdmd6Zi5cqEueIiX?=
 =?us-ascii?Q?SVdz1ymiw2+CSKYRLVi7PEcL/uWnQcq+DHA6p5BNliUBZWFLL9aBmzG8MKrc?=
 =?us-ascii?Q?oBDkrEMiwmSJwD8Ja7JWLWXXJzat0pvgEydk8x6sTadSikQy3TMuBdADbxi6?=
 =?us-ascii?Q?ZUkIV6AvemZER9iTG8Mi2MqGGre2XKeiCB24u1olI8j5UUhI4dJIky6FlKW6?=
 =?us-ascii?Q?vhX6Fq4MEmALoF+oWOkVAfrlrj7R5b5HHEYRkCN/2egf4GeMxdGxBVmYtWw7?=
 =?us-ascii?Q?GXvrcmyIUrT6TkDUfoA+IbaRJOFcuWZkh+g5w9ylKEfGu87gDhl7k2/n3qVK?=
 =?us-ascii?Q?3PoHOSN5GP6OuWr5i3xGR8AvvvNDlMsY2PGagKa9ppYZxTeCAqGIM9+iiBKt?=
 =?us-ascii?Q?J3d88qynSHoyzEr54bXVHlOjr9CxR50wChGv/7Aq46QGss7Hi3IbUoC+JhK6?=
 =?us-ascii?Q?YrJrarnLt0PiVhZeaKe42LqwoWZWKQ7kpzCEOfu6SMj7k8O2NLgZezI9DMxZ?=
 =?us-ascii?Q?oDKuB2TGcTJk60m0PpWxsiozFissEQJqq+2l+u+IpUpQPmr8jBo67Hic4+6o?=
 =?us-ascii?Q?CBhW2E5PkbiURllN7rVujgpsGkqhRXQ5nWSqnDCPTe7MBdRAKMXhMDdj136s?=
 =?us-ascii?Q?oGhW47Jx2vIXiiQWzFMFlFRZ/3ZTb4hGE1utV4IAny0LFzPLodJqSc/b6Xe0?=
 =?us-ascii?Q?LecIs0Wr/gKg1hW7MlzYM9qoKQPD1LV3pK2CdoAX7bfWzpFBuprOBcALp+Jz?=
 =?us-ascii?Q?KW8lCZ0ZQBt0d2mpehpJi8ngD1ikPhqlOysmrRqP6edswoo13lMl+u7cIYJF?=
 =?us-ascii?Q?w6V91ksrnM99nKNkhvJMs0GXIiiHi0GBIT11pJllpnyDmcacGYcn3Ss9N6o+?=
 =?us-ascii?Q?QUS57w3bByPUxw0x4ddjh7AFCuMYxEAH2gDvsgfsXbcqISgmrLf0nClqKAT1?=
 =?us-ascii?Q?r+qRX0zYExD1PQ1Us6WawlVeOADolKHE+QP/j6LIr3S3tGv65M08D+sSEw?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa26d15-263c-44ee-ffb6-08dbdfdcd0e3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:59:29.5043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcNgRK19veW389LePbnKODT/nLtKsYMAuAaRxlRKMGaZZJ8EXLM0Svg1nKDa0WmJUfeFvtFedtVp/F2i0Q/qlYxMWuHnjLTXSoF3DtFnJfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: J0HiGEFMSfRss9c2W97Xe5NHKryfqegn
X-Proofpoint-ORIG-GUID: J0HiGEFMSfRss9c2W97Xe5NHKryfqegn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tif_need_resched() now takes a parameter specifying the resched
type: RESCHED_lazy for when we allow the running task to run to
completion before eventually scheduling at a userspace boundary
and, RESCHED_eager for the next safe preemption point.

need_resched(), which is used by non-core code now checks for
presence of either of the need-resched bits. Also given that
need_resched() (and tif_need_resched() to a lesser extent), is
used extensively in the kernel so it is worth noting the common
uses and how they will change:

 - idle: we always want to schedule out of idle whenever there is
   any work. So the appropriate check is for both the conditions.
   (Currently we use need_resched() most places and the interfaces
   defined in sched/idle.h use tif_need_resched().)

   However, as discussed in later commits it is critical that
   when scheduling out of idle, we always reschedule with
   RESCHED_eager (which maps to TIF_NEED_RESCHED.) This suggests
   that idle code everywhere should instead just do:

        while (!tif_need_resched(RESCHED_eager) { ... }

   or similar. That is true, but we have a lot of idle code and it
   does not seem to make sense to expose scheduler implementation
   details all over.

 - uses in conjunction with preempt_count(): we only ever want to
   fold or make preemption decisions based on TIF_NEED_RESCHED, not
   TIF_NEED_RESCHED_LAZY.  So, related logic needs to use
   tif_need_resched(RESCHED_eager).

 - code that relinquishes resources temporarily (locks, irq, etc)
   checks for should_resched() and would preempt if TIF_NEED_RESCHED
   were set due to the (preempt_count() == offset) check.
   The hand-rolled versions, typically check for need_resched()
   which is a wider check.

   In either case the final arbiter is preempt_schedule() which
   checks via preemptible() does the more narrow check.

   Would it make sense to schedule out for both the need-resched
   flags?

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/s390/include/asm/preempt.h | 4 ++--
 drivers/acpi/processor_idle.c   | 2 +-
 include/asm-generic/preempt.h   | 4 ++--
 include/linux/preempt.h         | 2 +-
 include/linux/sched.h           | 4 +++-
 include/linux/sched/idle.h      | 8 ++++----
 include/linux/thread_info.h     | 8 ++++----
 kernel/sched/idle.c             | 2 +-
 kernel/trace/trace.c            | 2 +-
 9 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preempt.h
index bf15da0fedbc..4dddefae1387 100644
--- a/arch/s390/include/asm/preempt.h
+++ b/arch/s390/include/asm/preempt.h
@@ -114,13 +114,13 @@ static inline void __preempt_count_sub(int val)
 
 static inline bool __preempt_count_dec_and_test(void)
 {
-	return !--S390_lowcore.preempt_count && tif_need_resched();
+	return !--S390_lowcore.preempt_count && tif_need_resched(RESCHED_eager);
 }
 
 static inline bool should_resched(int preempt_offset)
 {
 	return unlikely(preempt_count() == preempt_offset &&
-			tif_need_resched());
+			tif_need_resched(RESCHED_eager));
 }
 
 #endif /* CONFIG_HAVE_MARCH_Z196_FEATURES */
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 3a34a8c425fe..1a69f082833e 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -108,7 +108,7 @@ static const struct dmi_system_id processor_power_dmi_table[] = {
  */
 static void __cpuidle acpi_safe_halt(void)
 {
-	if (!tif_need_resched()) {
+	if (!need_resched()) {
 		raw_safe_halt();
 		raw_local_irq_disable();
 	}
diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index b4d43a4af5f7..4f4abcc5981d 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -66,7 +66,7 @@ static __always_inline bool __preempt_count_dec_and_test(void)
 	 * operations; we cannot use PREEMPT_NEED_RESCHED because it might get
 	 * lost.
 	 */
-	return !--*preempt_count_ptr() && tif_need_resched();
+	return !--*preempt_count_ptr() && tif_need_resched(RESCHED_eager);
 }
 
 /*
@@ -75,7 +75,7 @@ static __always_inline bool __preempt_count_dec_and_test(void)
 static __always_inline bool should_resched(int preempt_offset)
 {
 	return unlikely(preempt_count() == preempt_offset &&
-			tif_need_resched());
+			tif_need_resched(RESCHED_eager));
 }
 
 #ifdef CONFIG_PREEMPTION
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 1424670df161..0abc6a673c41 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -301,7 +301,7 @@ do { \
 } while (0)
 #define preempt_fold_need_resched() \
 do { \
-	if (tif_need_resched()) \
+	if (tif_need_resched(RESCHED_eager)) \
 		set_preempt_need_resched(); \
 } while (0)
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 95d47783ff6e..5f0d7341cb88 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2172,9 +2172,11 @@ static inline int rwlock_needbreak(rwlock_t *lock)
 
 static __always_inline bool need_resched(void)
 {
-	return unlikely(tif_need_resched());
+	return unlikely(tif_need_resched(RESCHED_eager) ||
+			tif_need_resched(RESCHED_lazy));
 }
 
+
 /*
  * Wrappers for p->thread_info->cpu access. No-op on UP.
  */
diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index 478084f9105e..719416fe8ddc 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -63,7 +63,7 @@ static __always_inline bool __must_check current_set_polling_and_test(void)
 	 */
 	smp_mb__after_atomic();
 
-	return unlikely(tif_need_resched());
+	return unlikely(need_resched());
 }
 
 static __always_inline bool __must_check current_clr_polling_and_test(void)
@@ -76,7 +76,7 @@ static __always_inline bool __must_check current_clr_polling_and_test(void)
 	 */
 	smp_mb__after_atomic();
 
-	return unlikely(tif_need_resched());
+	return unlikely(need_resched());
 }
 
 #else
@@ -85,11 +85,11 @@ static inline void __current_clr_polling(void) { }
 
 static inline bool __must_check current_set_polling_and_test(void)
 {
-	return unlikely(tif_need_resched());
+	return unlikely(need_resched());
 }
 static inline bool __must_check current_clr_polling_and_test(void)
 {
-	return unlikely(tif_need_resched());
+	return unlikely(need_resched());
 }
 #endif
 
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 4eb22b13bf64..be5333a2c832 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -200,17 +200,17 @@ static __always_inline unsigned long read_ti_thread_flags(struct thread_info *ti
 
 #ifdef _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
 
-static __always_inline bool tif_need_resched(void)
+static __always_inline bool tif_need_resched(resched_t r)
 {
-	return arch_test_bit(TIF_NEED_RESCHED,
+	return arch_test_bit(tif_resched(r),
 			     (unsigned long *)(&current_thread_info()->flags));
 }
 
 #else
 
-static __always_inline bool tif_need_resched(void)
+static __always_inline bool tif_need_resched(resched_t r)
 {
-	return test_bit(TIF_NEED_RESCHED,
+	return test_bit(tif_resched(r),
 			(unsigned long *)(&current_thread_info()->flags));
 }
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 5007b25c5bc6..d4a55448e459 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -57,7 +57,7 @@ static noinline int __cpuidle cpu_idle_poll(void)
 	ct_cpuidle_enter();
 
 	raw_local_irq_enable();
-	while (!tif_need_resched() &&
+	while (!need_resched() &&
 	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
 		cpu_relax();
 	raw_local_irq_disable();
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7f565f0a00da..7f067ad9cf50 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2720,7 +2720,7 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
 	if (softirq_count() >> (SOFTIRQ_SHIFT + 1))
 		trace_flags |= TRACE_FLAG_BH_OFF;
 
-	if (tif_need_resched())
+	if (tif_need_resched(RESCHED_eager))
 		trace_flags |= TRACE_FLAG_NEED_RESCHED;
 	if (test_preempt_need_resched())
 		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
-- 
2.31.1

