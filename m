Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132557E4B7A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjKGWFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbjKGWFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:05:02 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20EE3C00
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:01:31 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJLaC028111;
        Tue, 7 Nov 2023 22:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=yWPCiZxYn64BBGU9hVy0zBTR2Q9Cw9JMNreM2MaUTDs=;
 b=uZ1ERk38/99URZZ5LYv10DESAlQ23yaO2R8ecq7LvbQtQk5K2GLNznjwRdIh18mSlckK
 nvtH11r5DDJZW8iHD5/ZfN5GHV1IEXvRj/YFVQJ7iSntAnif516CaTq4cwx8ZdnTJX5f
 BBf5FYW5UxEJUM33yrm8R6vrYei2ltdWGTsQlY8Ug7VVvC4DVtLHHy4MYiUDNG2O2VIu
 X6YL9rcEbO2Bs7Tnvq4N+O6PPItgF3mL1NK9k4UrQlV1QLPIlRhgz4TEWVGH8YVHJXaM
 DjxnHLIRbL3pOyDs+AmvWOqNAbUzf5Ktgn6bAY4cbeLXUzHhrJ7xQSKNmZ0gJhE+77Ua 0Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2302da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIgdM011085;
        Tue, 7 Nov 2023 22:00:23 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1tskeh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKQ3q33yP9U+zqfaYVizMqdEYtYdlWsOFTwhytGWrtcQvqLH/pFI8IwlDgGGqicgO33xJoK5R7y4MgWjTU1Ezp/E/IDHG4Ui5rcHmDRHHFW7GAqu1lRYq55JrQzG8IMo75eHrxe/9q76mMg7HUJSENgoY9iygiq7vvAr/fa0XJ3xS7I2XtSrFtLXU73Zt5ev9O5zSRw8Nc3dN5r/1ssuy2G/RD8li17U2YYY85dfSI4cwe7UWHotmgdH4S6+OwltTIGb9P2H7mhOUl+Wk38Vs1XZWi14sVdORnL8BHu1ATqByzD0zFa5MxYZXxf5fVqZujWzlyasAlYPfdWejbZL6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWPCiZxYn64BBGU9hVy0zBTR2Q9Cw9JMNreM2MaUTDs=;
 b=g1XoODtMWKXxLz7hHAPl/MlVteMx8Lhqfgf6LEMVsyZ2te/R1+p5lWGzyRszXBs934z/VvgA/GqdmgucsaH0VNjD6e3cMC1nVdDZrPXwcoyGtCQl1oBEkdUR6aML6yTrIm/4/wTIPt1aiJrm/uAgBBv+GbI/TD6TJJ33Bl2XSJ7UyUgXVOJgiNEo8VQdiKO6lbr8wKKbNXQHd8gKq5fJiQtRa+VygfPhJDM2NcT/r0YuRyG/vfsV9DYyVLNQ54xeDWEkV4C9QaIip1G1H4m6mcSTFyKYUMF37SSCdi+z/aPPOl89sMbBW3X/N1gIzbP1yefAfZAdLNcwhyJDnGv3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWPCiZxYn64BBGU9hVy0zBTR2Q9Cw9JMNreM2MaUTDs=;
 b=Xd5gTbJdXrjIoxcE55BCItx/P/1FmTCTymG2z3l4Y9GK1UlKb/V7gR4KtiW99lXYQPA3z7IsLbyqGi5NetFaCRWDGhz6jRzkQHTekFPlCX2cpNOznLMOKN3uT+JZrDt0OXbETHdEcHsSS5+k8w1zUYnXKDGgqRWPlrSo0GJiTvk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6275.namprd10.prod.outlook.com (2603:10b6:510:211::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 22:00:10 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 22:00:10 +0000
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
Subject: [RFC PATCH 48/86] rcu: handle quiescent states for PREEMPT_RCU=n
Date:   Tue,  7 Nov 2023 13:57:34 -0800
Message-Id: <20231107215742.363031-49-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:303:dd::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b8597a-d11e-4e11-a035-08dbdfdce967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pE+vNLVbtC+hhLa2LbqKbkDTmGtgLzkN0Y4OHg0UQEG6pFYnyEyGNG6JCIGv+X13VvX6aG4M/rROZt7ueE3GXP1rq43zu31nFHNELQwVgwY8finHUrb7/diVLbsEHAfpXoJmU0UFhO/np9RinRyJi4sw04H+nK05M5ASFbJ8DBH7D9voGQ24d9W/WFdorVnyHXV2B9s3lwyuHuzv9LcSJ+PzYxSuSajl4Iuo/zfLe7SvSMLkDkMs9I4p1dsegBehGOGCTJwbpnNCd7LJOHOZq4QElywvV77e8rO66SwYpfFDCYcPVvRQcypbFpxmgdym2KPxOTHWq7EmtmjmEgXOt/qr8aS/sDEMmlw9njfKrvU/6RCUBz0Yv5I7+BhWUmzNK4eyHt3dl0tlR/EstKHlrMwK9M7oRa1uqEvHoN0EwmKDEvKwJE0nfZ+sOwWGDoKzLX20I9C2bfX23cWCK0FQbhJJR4MQIRaZalsaMUkZINcE1yQ4qC02ZiqCRg1bgwnitAeP0OYXUUp83EPZHU0vsHQqi1CR30Iw+mA/x0meMI7GTgIrMxY2Ppx512UEMdz+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66476007)(6666004)(38100700002)(6916009)(6506007)(316002)(66556008)(36756003)(5660300002)(7416002)(7406005)(41300700001)(66946007)(6512007)(103116003)(1076003)(8936002)(8676002)(4326008)(26005)(6486002)(107886003)(2616005)(2906002)(83380400001)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vqpclBl4VsapYuC3eD2uatxqeYPpHELfP62WR2qcANQwT1rE2QF2VICHSS8R?=
 =?us-ascii?Q?GOzJDseBAEp4WIZtnmXCGOa8pzj6ysEkDg/i4Ag53OmcIKZ2Ql4bU5reyDba?=
 =?us-ascii?Q?ae40qktgSqp9ssenL6m5a3m5NO1TC1kqpvJFdTfWt6vw3CfQ6tpi/6yLwo31?=
 =?us-ascii?Q?SL5FVgIiimNlkbT60Rn8/4rhZnfHPD/UX8Lc0W87mSXScNmK6Jz32oWobluL?=
 =?us-ascii?Q?By4/f+09CkNFPAt+wWnecPUDgj0YhhMGPNMYe4fH5RcZz7c+NA0p2fYwZMeL?=
 =?us-ascii?Q?4ioDyqCQaJ37URuFlvhjiDjlhLDiWgwiQPG+Gcm2kt9/vrU4Dr6axL5UyGNh?=
 =?us-ascii?Q?TUKP5/KitqQ4jTG0YxiWafkBRkOIbBr68MNjiVnZ/OKjCFvvyDEtM1ySBuGk?=
 =?us-ascii?Q?g0+XmnfZeED/8wtkMn4A5SiOLP27Ag0UIxAY9VlkdWZqA01xZ+yscJWcm84p?=
 =?us-ascii?Q?X1bUB8jxRn5Aow7PFNqBtjBCrcCDnbDvEYQznlaXsBXsm5MvtULOdgm/LvcK?=
 =?us-ascii?Q?X9qXT9GWSAElEmKkT+4IcAezz7dpX3ZuxKBSzBzrmbD8B68US2BwI6fTYwLi?=
 =?us-ascii?Q?Ha3UMNB4flaoMVMieKtiwfRqzPtE+iSBcRsEEQDZVXcoPAj3x+KsmLpdTcPR?=
 =?us-ascii?Q?NcdSHud6BOmPvFQV+Taiowzyzg5qAz9cvjzoPAacAR/vhm0RSgIfoMAPkBMK?=
 =?us-ascii?Q?dJu/N/GUf1/6CpxdNcfMBkuvYvRKT30nXxf4/biB/Mz8QIxt+T0YULIOffEt?=
 =?us-ascii?Q?krcRxAuvHshaAZJkMKjWBkiYBC8wC5Uuasx9LhrmqDlKrkplYdY74tBZSQX4?=
 =?us-ascii?Q?hJnT3D+bltvPho8aeYkgJ8z3o5/VLWFC5qp0CYMBNSNrpXIHO58+cURhC/ou?=
 =?us-ascii?Q?S8+wHQ2Hdf/qI2sY6sFq9LdM+jehPbYdFqvqY/WQ4dQhOevAgZR2wnOaumd6?=
 =?us-ascii?Q?c+RFOty07k4gIOlIBIsiGW79zUYOeyz7hlfubIA7MIMgdqYWdmJc7F1l5lED?=
 =?us-ascii?Q?cX6eTUhRPeMtLlzC662cpWwmQ9PNx+bmfABoQkDsFbFXcpu35NMCj7KIosnS?=
 =?us-ascii?Q?Cgk7pljvJvfIv3qngTrcm6PSozngK8Ag25NkEW8nzaKPg/WtJ5KAH3eeDuhK?=
 =?us-ascii?Q?I8ykbBhBXeyflqu+Qpk9Uavcty+YwWmr5Tt/q8j6f8/JDWmROIOFa6BoTGk2?=
 =?us-ascii?Q?vOs/4ig2ojSR+dlPeJk4TaJDiaB6XzmQpN0ezlclQva+lDJidJ9aus8JumCP?=
 =?us-ascii?Q?EoN6IeZ/Q0fKv21RmQ7FhiNR0iqod3viGtJc+1gC+sQVL1S5lVLDmCDU9ApR?=
 =?us-ascii?Q?beJfScvBBDFg1hQ3OOedNTa7f0akL3GzYdllNJtUVeYJDsJDlwUlccVxR+Sn?=
 =?us-ascii?Q?kVrxAYFNv5YUTa/m97kSTAMIaOlQxtveosx5z0GWUXBZtP48ClBf+rVmZ3/j?=
 =?us-ascii?Q?8pSbMDOccWxbnccxz0fNQlDp5LjcTGLnUpc+1S5iCC9nPplXazrPV1fzWTyj?=
 =?us-ascii?Q?YTOOuSp1qTtur91xZn5wZ5bM2MOu1sPe8MrIrDvhgS1ibodb0eiRGQ1gnxzV?=
 =?us-ascii?Q?B5gZuCHgFzy/Pua1zT0BBnfJNRbYCq0qoQZfoMabw2FC41NO/6DgAUnyL5/l?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2vqFns1/PVGXvJJ4569bbgzzLMQkDAV3n3v+Bxh7gsmWLc8GGfBBg9kuX2Pb?=
 =?us-ascii?Q?I9A+bPIUFL1Fz/7Pk8b/NPCvsYLlC1PAs8hmwzRsj+czIEUJaA9XJdmlTbLy?=
 =?us-ascii?Q?dvicC76bTsOJas60/6cPui7O4nV5omQ7UxvP9fRxJgEXF3Mhq6maP1BsAMmj?=
 =?us-ascii?Q?6zXL/2Mg2imr+UyOistbpSDQ42c8c1PQEW1rQF72QX6O34XEOH+YE7G/6oB4?=
 =?us-ascii?Q?AMLc2ld/x5NC715Cgs0xrxSGGf/3+yITEc5jOrjASoW8FPbp//gN9uRaFNxw?=
 =?us-ascii?Q?tbV4L4/HEvx+7oe5I0M0yyjj1tp5V9hrj0/oBGZ8wlno+0GT2YSqV13LBtME?=
 =?us-ascii?Q?iaaXXNoNNyIk7R2yI+lt9qEwjThOawPFpxYwEtpogkn48zGJwhEiXQO/wEIQ?=
 =?us-ascii?Q?alXuZ/YUrFVr3cGtJLmn5OgoQKbLL9ldAJqeXyfQavgzaBXtPjOQZ1bgl3Vi?=
 =?us-ascii?Q?UyR90+W7Oky2S7F/axSjSxebMsm5QLBy2podLMM540EjFRU0M73kce6rLyTR?=
 =?us-ascii?Q?CeeIjnnx5O8uiUxPZ3sZXYvSFYWMtnGyTKCQLXTY/Q40fDjQJyvKgqPQiTDe?=
 =?us-ascii?Q?Ufg4o2y3sUYLLgYzCUgqbJjbPCRCsn/NjFFJGUs3R2I8bz6qROOEZNnAc6fX?=
 =?us-ascii?Q?v6nYcROFkkCXTmprJMx3H8r9OY8Okq8H4NC0n20L2KxfR1gjWfOtzAFuQ7P+?=
 =?us-ascii?Q?Vb772hnvEOXGmZQTclfiuaHM1KxIBGKN+9NVoTNXyYkhRS0wEVZYqzLXU2QN?=
 =?us-ascii?Q?7nMXR1tWSOZ+LdHdwGbSGA8PH7CvQdPSyEWbBIlYWQxpNNPkYomnfySbUt25?=
 =?us-ascii?Q?XPaALyK5JHfA0sxj5XNfk7+I8IXQfFBZQ9UlyfjpzJd2YGDEk7mY+TkwtDHA?=
 =?us-ascii?Q?SggdVPP4wY0MjOOWhw0WS01RpDq2G6jlPVYLwBrWxENviHsF2jnmzE62zc3c?=
 =?us-ascii?Q?KzIvUMM1zyz758gsd8Z70lPefeRTG5XMieXU7E2dPDL3rvEblrEWUtKH36K0?=
 =?us-ascii?Q?N/Fmd5W/pX9DNWYvCoP0w/suJW7+O/nGAIy72FATy7Dpdu14Li16RXAoGkLV?=
 =?us-ascii?Q?p/k5gOoEcRC4gqx6GVHT7EHhx3qgP+HssLzqdJGr8w+3Pxcm3rZiEoqXK2Qk?=
 =?us-ascii?Q?E5/3vBZpGnDAh1EqK//nnxlMRN6I2Eo83QxTN3djdnJMpWe7De2nv6v0PDyg?=
 =?us-ascii?Q?BMZXIN/LVokNzTsmpaAPDZQjyV1mdbexRB6eh90hLu//bPTpU39s5Gg9fc2V?=
 =?us-ascii?Q?p0JA/u7sXrnquxgL3uxMKP/lbZdJjmZ/Vwop0L9h8AxtSDGRtWuAU40IGYFN?=
 =?us-ascii?Q?DxiHgEpRQWUlcFxPa3CeVRZ92yVW7u/u+ebX9b0DiMfHVlq5WuAjpnv6gU2Z?=
 =?us-ascii?Q?84yrQqJhjTSk84vqHxpvbFngdC6bwSQbXewTj3qlSh/aQq21NW4MXRSQ42BM?=
 =?us-ascii?Q?N1fI7u4j2fJOAwNwwdYDqfTzhJPrk9MSwwBZym4CSJ5J5vN3HeLXdA7mk/Tf?=
 =?us-ascii?Q?O/HY1k/ZQBGJHAenn6F3eq/2RcNEkEjLg+rNEMd1ArfHZMFLOa0c1dFjig?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b8597a-d11e-4e11-a035-08dbdfdce967
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 22:00:10.6261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: soL3MN/jDK6mPZQ9dciYTHAzOtsz300cRhBbkXd+UJele+63v3Nm60qBh61AzXZWYLDr+EROaU+sHxJQnBn9PQxrV8w/Ux8EKvzG9Uoy+F4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6275
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=817 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: OjjEIw7rfFh7J34Km8p3BEoymEXglLjZ
X-Proofpoint-ORIG-GUID: OjjEIw7rfFh7J34Km8p3BEoymEXglLjZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cond_resched() is used to provide urgent quiescent states for
read-side critical sections on PREEMPT_RCU=n configurations.
This was necessary because lacking preempt_count, there was no
way for the tick handler to know if we were executing in RCU
read-side critical section or not.

An always-on CONFIG_PREEMPT_COUNT, however, allows the tick to
reliably report quiescent states.

Accordingly, evaluate preempt_count() based quiescence in
rcu_flavor_sched_clock_irq().

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/rcu/tree_plugin.h |  3 ++-
 kernel/sched/core.c      | 15 +--------------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index f87191e008ff..618f055f8028 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -963,7 +963,8 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
  */
 static void rcu_flavor_sched_clock_irq(int user)
 {
-	if (user || rcu_is_cpu_rrupt_from_idle()) {
+	if (user || rcu_is_cpu_rrupt_from_idle() ||
+	    !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
 
 		/*
 		 * Get here if this CPU took its interrupt from user
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bf5df2b866df..15db5fb7acc7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8588,20 +8588,7 @@ int __sched _cond_resched(void)
 		preempt_schedule_common();
 		return 1;
 	}
-	/*
-	 * In preemptible kernels, ->rcu_read_lock_nesting tells the tick
-	 * whether the current CPU is in an RCU read-side critical section,
-	 * so the tick can report quiescent states even for CPUs looping
-	 * in kernel context.  In contrast, in non-preemptible kernels,
-	 * RCU readers leave no in-memory hints, which means that CPU-bound
-	 * processes executing in kernel context might never report an
-	 * RCU quiescent state.  Therefore, the following code causes
-	 * cond_resched() to report a quiescent state, but only when RCU
-	 * is in urgent need of one.
-	 */
-#ifndef CONFIG_PREEMPT_RCU
-	rcu_all_qs();
-#endif
+
 	return 0;
 }
 EXPORT_SYMBOL(_cond_resched);
-- 
2.31.1

