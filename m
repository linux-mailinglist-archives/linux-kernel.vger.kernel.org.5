Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADF37E4C89
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344373AbjKGXLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbjKGXKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:10:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F14319B7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:10:09 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJw4Z004992;
        Tue, 7 Nov 2023 23:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=c5yhecXpPDSuI0GmvS2MfP/t3MkFkdYdazz4/Wa0kwY=;
 b=MfUi3IqBxui6sIP6wN4tJ399EWlkfEJW5L9jp4Ak2WF//zB23mMfuUW3Xg3TfSO8NGFt
 Bwm15k7koLp3vpFef98nv5DAfZBWHdaGBIkuNaKwKwtWOXeCzkS4s5rVB37lxjU4kEBG
 JzSHreLlehmTdR1gVNQURhBbcPEEwAFVZHB5IGNWHaRFZea9kHfbOj/SJbCBufjq0ano
 hU5ha6nbS4hMTSn+YiNExk7An/l782GTsMRbyaaBrcFzBqfiDD47IwVUd3CKN313+Kwr
 JtKXdX0nFTkfZqRFdoYsFUZVwznh0ZvV0JLmKA+uq3kqP0Vh0UKTLK3n0Nck+v6IMzhu lw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w22g6be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N2B2B000412;
        Tue, 7 Nov 2023 23:09:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vcbxd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuHz+tCZGY5QR5s1YdhEgdpxiVyskdiXCwKSvkKyZqrqGQT8t+wv9E5j6dXqD+wAxhKtKDzhKnfNz9nG9SF/VlkgD5zgmHRmOLfLYOFZwUlBIQyP6cvaHY3cQ/IVqrLe29FJigNfG3vYsb3kIytONERCbviAhLRfRxM5u3UpfDvrfWtQkZHCatJK22ovUXGS3Kp3fXbwIqeOH+ceRJFiqHbRNRrdZYOYGkVhVi6qazPb7Ad+bKl5U74rC8f+HZued6Ajebq94nY3fk/26+CS2cFBMIHe4vrCe3qJKdguDKlfdxHCMupT3Xe1X8Ukp/5eFQ+MToZ+nOIDtlrRH4K77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5yhecXpPDSuI0GmvS2MfP/t3MkFkdYdazz4/Wa0kwY=;
 b=EhGDwBMkkgOO6cA3Hi6RhZE6EDxw1Lwlb1PymkvILOOj0Bnlmu8LLRzLf69q65NxXh3qTbvlAjqmIK2vWBdgVC292jHZ7cdRjMmZ3yqzWuITqKgKDMsj4euFE1dkEqp6iHjTSNUWc8AcnExGECA8VqnBAIlZOiXzBAoY+esR6sqw0K6aDCw33F69ZsVcHjeog0il1lcAJYYWM4QvONDJrigXALXpb+OjqfrPJ9anv4Jp0ArBfdEMGAoLJEpLZXyGpztjiCtkCPTGQanmRxBzxIVGeo2lZkO17v8Tl+Df8Chu0NSUoMhycB0Q/VMLEqPiod7OaPCik3ll2olXb8vIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5yhecXpPDSuI0GmvS2MfP/t3MkFkdYdazz4/Wa0kwY=;
 b=sTK/dO8K1F6YSpxEGLNDxbNmpJbkDsBqM/EJjRbsNhp9IzOAWCfV0QXkmOOzqohkNtOVil9nmfErVQGp/FncUZFprTe/EgIt8MqZQyJaCsco/EBMgtYXQQyWXK91+rPsjQAIpdrRAg5yerETRcHDv+2R0e6zTkoD2AHmlJ754kY=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 23:09:26 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:09:26 +0000
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
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 75/86] treewide: virt: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:08:11 -0800
Message-Id: <20231107230822.371443-19-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0164.namprd03.prod.outlook.com
 (2603:10b6:303:8d::19) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: b0035c91-4d51-4495-c757-08dbdfe69687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Gp0USXX6rAwsANGV7f4z2LUsKTSCR7PkxiO8PHp3Y41gQ4IfSeXv6i23ihn4oc+jY8ysY4rtP041U8SdyEbTtyLis7uY5teUsap+1uDfhXH0VTjsKgxg4/mitIecv/ooqPapK2M+QtETu/Kr/PR+R6CG5JEb81EgGnIyci9VAYf5idCFyTQxxKDF0ELVoTuvVWjrHtkrina1H8F1HH5PkDIhdQ/Zq7y2MCFJk/IwaKYHa4exoSZ+MtbuMFMIRvxTv9PyQODeyPCfdFCQRpsjcgGX0jFxfYeAeDiNVMIaE13eLVRra0FuELQlHoVFGpITohkzgGuFO+8lk/EjZ6CE+M2o8t6XpYsQYKcbM8f92UBAToErh3yfqAjl7EPdZHkzc0yNhKpfjNyykKBIdSeEfAHXoKFkhsiJu9LCE1Ui66GtmUqxx0ClmhQQKmoFwz9YxzT/DLFh1YgZrQiVsyMt6C5gCftqeXTypV0s/BHg8y8hqihAfZvvTUtzZntSzLFgkCS/Pw2lryjWSCqBAzfVWPHZ518+7aWoY3aRMThhtU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66899024)(6506007)(478600001)(6512007)(2616005)(6486002)(966005)(6666004)(7406005)(36756003)(103116003)(38100700002)(86362001)(1076003)(41300700001)(7416002)(5660300002)(316002)(66556008)(66476007)(83380400001)(2906002)(54906003)(26005)(66946007)(6916009)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JpLVvgsv87KNLBxjAxcW7WucJ2Isc4d53YiKsBfXLcADM47ZU5SDeZVHvAvc?=
 =?us-ascii?Q?2CJx19Hsm1v8UupSENS7Ig34mycCL0ksScBfftZPTwM8+QtJ4UwuPGBYc9kU?=
 =?us-ascii?Q?6ZhixjeXRwnF59LHx2gc7GiZwkO3hniyM5UHiOhFyRWlUbw4DTRntYlUO+Ba?=
 =?us-ascii?Q?2pWoVyfh3yxaH4008nvPah1K9EJ/hyN23YdUiu7dIBjjClyOuzfi4zlri2ip?=
 =?us-ascii?Q?161i08N6S6kiscOgkdkptUqZudByuOngj22tY25hqXFzFzDi4Ra9RWnD+zd9?=
 =?us-ascii?Q?R1tiKJvf4eO8CddE0ISYb/Zf5R3okdAEHKAbnGX4vPbTCPF9Jruf9Ovc2lRL?=
 =?us-ascii?Q?tZWnwb2goUKkYJAU0k4iP2IvjN4GESleQ4cVTSsXraytZK/L3FKLW2bof8Oy?=
 =?us-ascii?Q?8ijKW8OYfJt3pjZemMyTiY7cWTJHUAt1CnBPq1qcS36Bd2M8XTIwHvVCp1tV?=
 =?us-ascii?Q?+y2O+V0X38kl9g3zrUHtlO/XQ1mlR/iIQ9vDKsQuSd+qzTwpRyU64mgWmJPX?=
 =?us-ascii?Q?kcHXgKy/5a8rEA8/eTdCeu0khz+AqH4ojsZZt/iZossl3hxW6ruxCnimIv+3?=
 =?us-ascii?Q?GXP3N+ly5HmuGeamvRIyh0Tc0pXDDooGqh5bxNx38dtvnK4TSIIfFgDzUkCi?=
 =?us-ascii?Q?5LVO+OkPRFDgXXbe8L4D+uuS1BEnedxLetf3Sa1SbiG/M+fKMHTFj21kBtHp?=
 =?us-ascii?Q?jjVYQ1c4LAobYS82A0+tu9+ouOgWulNcASlyoM/Z/7d62oi87L51erVQ6xv/?=
 =?us-ascii?Q?SYQsw6KTZrsjzxwnQ25L2flF5rA9HT5Tj4S7+H77R81qvzaWaNqV4I5yGXk5?=
 =?us-ascii?Q?GewPVPztTKIfsh2AkgQuBREruo9/UTe2wITxE1e64JoWsztUutntO0zX0ChK?=
 =?us-ascii?Q?7fBV8iAYqww1VEbrpb+U+AZyciAPFtuddoS2V5846Soo9kzD/WzzbZ0M1r66?=
 =?us-ascii?Q?9jsMMru/KrC6ET+IIxSi4WbNmWrXwGqaIgCr7kCtFKXOOsr6Q4HRO+n0M0WX?=
 =?us-ascii?Q?F1oSMtkfOzJKg7RF+uim2UmMsnlthTFh6IWKwDM8A2wKhYqRwkFnDOehBi26?=
 =?us-ascii?Q?BxB90+MpNg2xfgClNFrq5G78b/FNvji9bYA+FxJrYGhqozRT18p5K+cr4QzS?=
 =?us-ascii?Q?hXOqXbUInpg+7tN2HsCAk68dO6gWcDjAGwjAVNjoVfXNBQ18S3EeRQJtJYWn?=
 =?us-ascii?Q?2HO5GHOglZWHGkKwo6Xk5YEIA9rQFEiF7Wytjatwwkxe11xVre0bfHb1VqTc?=
 =?us-ascii?Q?7WTu+5Lk8tsZYi0YjW99ccQJpURs5pWY+gnX5WO1QMYwmLEIU2t5bz8V122Z?=
 =?us-ascii?Q?DWkgBQpHPwgKDxhLpc/wXCH93ZJZk26gwT0OfpDrsZt/PnO5CqPr7Uqcsidd?=
 =?us-ascii?Q?UK0bBcOlJ/AR0fngvOW8BJ6W8KepnAn76+N0hxGfpoEwPX0rVf7cVKsqaQgm?=
 =?us-ascii?Q?VcQUipwLk+zX5oZzfsnKpBxb5bkNPnTck2wEHf85f8npm9ZFFoxCBkl2EH+j?=
 =?us-ascii?Q?CFdZz+Dp9eHwRGbEuzahWQLR9ZTx5tRgFXmLFy4Q6y89nbA3QSUYnSF18FiH?=
 =?us-ascii?Q?xGyNY8od2ZWjl9T8eJVd9ch/M8mx7OumEf+bX7Ou7fn0/8y98z0HLs1TdMoS?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?uJDoScoed39OqTYC6IDD1N1p0T7b2iDBtv00YxN4sBkKxH8tUjVGhW/u4+B0?=
 =?us-ascii?Q?5SnIxCSHek81URCKRpDEmU0eNKbOC6gkIzAYbU1/n0F+bncchMgm232An8Uw?=
 =?us-ascii?Q?tjJukjdP0xMUyVn2t+U3FRj3hdq2aCM3mPtZq7zvFpFGi+WTAIhhR1tEJBXM?=
 =?us-ascii?Q?UHHAOJnQxcVYfFaeq6WS+r+LnEq/oac3bshufHRGclQRkP4mNHEUJnwyDegB?=
 =?us-ascii?Q?qaTjxRlA+Mf4+uiRUhuwbddBah1B3SUInHLhrn0ApgKafBwXn1njdAPDMIeP?=
 =?us-ascii?Q?lrVHq/4aUYbWjcvkckUkuAIQxBHqDXD9/gfwEQjdyy3l5A7SVcApRUFpSWSt?=
 =?us-ascii?Q?C2Lbzg6628eDNumgSxLx453hT6245hm06oNRQquggbMiFg5YxlsfAaZLR5KZ?=
 =?us-ascii?Q?6LKiWfnUWLsaklxEH3qkOO2LOwohy09zbBeX+V55eVCn6ghj6Yy1c53abCKw?=
 =?us-ascii?Q?b0GCcFndsvB/drgrG4ZodIMh/UVLfoZY99tC1QE7z3iWjGvGftnw6n+oPDr8?=
 =?us-ascii?Q?+NRhN7pm1410X+FIiuULN0FjAaPQ+aASktODnjo9blojbXcACK6kocCiISnX?=
 =?us-ascii?Q?pFQCJRDPGcEKqQZDMi675SoBWpdppcQJwjysAWawK8zbqtcytLy/7iE6PVwU?=
 =?us-ascii?Q?qverhZm+PrDRm6xzgKwkrsqFwYe9sE6gDc29dEOA8Qh2A/ao9/1Z4OKqFUmz?=
 =?us-ascii?Q?5M6ohN3wq1uZJgF8LRzJ/MAqP4qzSTlQJmFomm47jGDMu9KvwQl7vYuySMvt?=
 =?us-ascii?Q?SEIOFVakSFnmSJoGzjw09iE3Pl8Zwkb/yFjQH0eeTvXYQQkiEdkJngH6Mftd?=
 =?us-ascii?Q?wf2CdehPZdYKMNpMH8wzRz+NcWs+SRD57LLEmByOpctR+rr2ne9h6rSiczp3?=
 =?us-ascii?Q?Ywxmh/F6YeMnvAXl94A/mb+xEFXrc9JWOYuSUq/k4ov38M83o2bnStWy4Ex0?=
 =?us-ascii?Q?zSZgyS3/qwP9/6npMjw/wpHfRczOusdZ+nYgRA9SqT8V0RlZ2i1rWzCuWUzm?=
 =?us-ascii?Q?YxNMpeQhwROj6iXOJ8y/eiyxCy5DJNgU+6xt8UdQVy3DRl4wn4JQW3OW8st4?=
 =?us-ascii?Q?/jGPgwUkwvaDS4eXB2SJCpgtgEolTFsNFl69bCnlA6dU4wOjvo2OOMaOyT3K?=
 =?us-ascii?Q?1XFAYwqUOv6HaxXfeln3/38T/ZPou7yOZ4xlOHzxnDeDGG9EjVrrwNVORWqp?=
 =?us-ascii?Q?XyQ/1S1bC2fx1uG4aNOzxLYU1LkWe0U5kOcXUR6PtdmM6hMySjT4ipryYSd5?=
 =?us-ascii?Q?QmEMehrpX9T9WqHzHX2ndgMsw4arix8DjEgWnTsYI2+NNNRSjylRHXVsp/gn?=
 =?us-ascii?Q?Rs/GI/MjSGR1DprtEms5Fkj3z+lTPKWMnZLn9h9sEzTa5K/SNOdN35AvndRp?=
 =?us-ascii?Q?yNFEl1byYbERiUuio43MZsVtAU7Ph8MMrB+ybDL6JdPDe+Wkob4Cjija/6e8?=
 =?us-ascii?Q?5vGRIi7+U8iVd2CGwHbhMVRnyodP7YpNLTKuD25NDt2aJ7idye8YJQaC9htn?=
 =?us-ascii?Q?4aNyA1t+1dnmwqVS8i3rwCQVoMeStiC7lFi7jR6wJBj6c7vp1sq/Jye/9ka7?=
 =?us-ascii?Q?feA0jS/RCrBX/cj3Kpc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0035c91-4d51-4495-c757-08dbdfe69687
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:09:26.5940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGbLZ55H3FGzaF1wV6tX4nfe9V8uYEO9LCl3l/WjrBN/Rs7HqNx+eXpi2nk9HvJJaDylGsYIHPDphzL48JqvvgKPBuPVhFgmhYlDsNLfqEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070189
X-Proofpoint-ORIG-GUID: Ii4sVl0De7nOUzwkvOeXic92JPyFZVsO
X-Proofpoint-GUID: Ii4sVl0De7nOUzwkvOeXic92JPyFZVsO
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

All the cond_resched() calls here are from set-1. Remove them.

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/xen/balloon.c      | 2 --
 drivers/xen/gntdev.c       | 2 --
 drivers/xen/xen-scsiback.c | 9 +++++----
 virt/kvm/pfncache.c        | 2 --
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 586a1673459e..a57e516b36f5 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -550,8 +550,6 @@ static int balloon_thread(void *unused)
 		update_schedule();
 
 		mutex_unlock(&balloon_mutex);
-
-		cond_resched();
 	}
 }
 
diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 61faea1f0663..cbf74a2b6a06 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -974,8 +974,6 @@ static long gntdev_ioctl_grant_copy(struct gntdev_priv *priv, void __user *u)
 		ret = gntdev_grant_copy_seg(&batch, &seg, &copy.segments[i].status);
 		if (ret < 0)
 			goto out;
-
-		cond_resched();
 	}
 	if (batch.nr_ops)
 		ret = gntdev_copy(&batch);
diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index 8b77e4c06e43..1ab88ba93166 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -814,9 +814,6 @@ static int scsiback_do_cmd_fn(struct vscsibk_info *info,
 			transport_generic_free_cmd(&pending_req->se_cmd, 0);
 			break;
 		}
-
-		/* Yield point for this unbounded loop. */
-		cond_resched();
 	}
 
 	gnttab_page_cache_shrink(&info->free_pages, scsiback_max_buffer_pages);
@@ -831,8 +828,12 @@ static irqreturn_t scsiback_irq_fn(int irq, void *dev_id)
 	int rc;
 	unsigned int eoi_flags = XEN_EOI_FLAG_SPURIOUS;
 
+	/*
+	 * Process cmds in a tight loop.  The scheduler can preempt when
+	 * it needs to.
+	 */
 	while ((rc = scsiback_do_cmd_fn(info, &eoi_flags)) > 0)
-		cond_resched();
+		;
 
 	/* In case of a ring error we keep the event channel masked. */
 	if (!rc)
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 2d6aba677830..cc757d5b4acc 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -178,8 +178,6 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 				gpc_unmap_khva(new_pfn, new_khva);
 
 			kvm_release_pfn_clean(new_pfn);
-
-			cond_resched();
 		}
 
 		/* We always request a writeable mapping */
-- 
2.31.1

