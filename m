Return-Path: <linux-kernel+bounces-62968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30368852871
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92DF91F24BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDE920B02;
	Tue, 13 Feb 2024 05:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N00DEEaO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dPhkO/nt"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B1C18044
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803826; cv=fail; b=SKqYwWVdkQX8nrHdCm21iGef6xxwPqReft7RCJDjGl6sHS9zejjE+zDXPyjm+sPqcmAoGMU+qizYcUE3xxxQU7PZCOUq7E3v1xbR5EgOsu4a/SvvJIHY1avQNptSjPPGWAXbFPKq6rOQ/JcJWo4eCy3aZtoU+j2Uc3KUs9EvzGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803826; c=relaxed/simple;
	bh=L84gfAYQ81E+gA8uIm1JdV7lY8twisDRcCpKSLCIelw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ItwuuVpMCJiKXFpXGlu6IpKVWTIpdfQ3eC/1vv6bGGZ3cYBLD7v9HHTuhpDhB9/s6QnkBhM8C9grulIoMwp4j+uBfT6VMFJYb8gcdPotOPeGY1UK/6lLBH6b46T7mGbKdDnc+vA2KWNmTJbauJyp8x1zW53xZWA+1oJb/xm1FCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N00DEEaO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dPhkO/nt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D4xtFE000302;
	Tue, 13 Feb 2024 05:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=e6EiB3lC+Ersv7Mw7KyxtkiBTvGLpqTJLPo7B7DSKZk=;
 b=N00DEEaORZARhZWb8JM+U9EtA1LnSbGmNoY2cuMd4n09LchHfBrAYYVrUcGbe0nCeARH
 11ZeKBIDkIhY7S2bM6kJoNP7jJ3o9XbO9vzVd1TH3WB+ru5aN2jJYKd73iQRpMIIidsc
 6+6IqeifSi19E5L6+9pkAkMaNL1Byc9P9kwDHgYDwm9RScHNF/NZzsHJxs0d8jA6m1MO
 ode4bB/cPdD7lL0gr/0EC/baSJjRh5boi/rhA05DGqXER4aV9vfCaXxyEvp0o3g1yx9U
 Gj2ooqaFbsx/Q7ntc74FSFhuRvY3RMF7GJqInXd0HZlTjrNIk+L5vsxOIvATgXIwASYY YA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w81vm8360-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:55:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5VHF8000527;
	Tue, 13 Feb 2024 05:55:57 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6ufx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:55:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8ZgWgyh8RyGZ7UxTANXS9eolursCa92nkNIiXmLSG9gu9UC4GkQCSaq22UY+LS357XYDoCYp4pyeGzSyECabC93Rn6sGwsg/JpNTAwycDdVPGDPW5b3xPUllrZHpZLviA5M5p4GsTfg/xQtr8w47nayklNWCo2Wh5rCHuN2J0yDzKddviqB3MMLnpZK0fJ6WGYW7FaQ6ZpidRChacscDWDPtp+ZqIS2WsyEiM4sve6KiQhLf0pfyBmsxGqZR9WmyOgBt+uGbZxlHvpYk4tE2KA6Alxux2WAHu8eWU1EB0sWrV+Flr2vpecbzyBnCpQhDye/VYm1aJS6DnVq0Zvneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6EiB3lC+Ersv7Mw7KyxtkiBTvGLpqTJLPo7B7DSKZk=;
 b=Gm9FE8FLyTs2tfwKuAqTH3smL+TnAjjDOZBixLMHDbUHFAOFIfuQI7YEJGi3vPCdUGCV2F9dhycGeQt+KNTo9K6GOVXcOedwvLy1jYibNh9iS9sFPHve2jw0YlNQ8KawX9pxWKthD1OBrtBUmTNARpNobvwOB3zarnYJA0pzpDOxkdqFKxACagPLrWG5wJlbx43ieon/28GGwqdxCj5elGAfHZ0sMMImpVWsS2YmOlPzRPY0CYptRi9JDCtAQTPnRpgOjD9lVfWm6xHtC3UJZ5me83eRowT+qhWbdA1KrmlMoOMEfFuUZmE0CrHC/PlHow/wEEk9n68vYbl8tclUsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6EiB3lC+Ersv7Mw7KyxtkiBTvGLpqTJLPo7B7DSKZk=;
 b=dPhkO/ntAvbDnvKTwAtqUshsjCJy8vtEeI5L5kSemEGLZ2QTpEboXytbRr4C/zjRPA/VRjux/0kI2JBKHFMpNHvC7i6S5s/5XpRvBwcKYEzS8k3X6K6q0PF15Y6DNN1qWpSzQJ58R/q6ZoWzGsVqm9eYFYHO5VBQwarYvEU0cPU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CO1PR10MB4642.namprd10.prod.outlook.com (2603:10b6:303:6f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:55:55 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:55:55 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
        mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 07/30] entry/kvm: handle lazy rescheduling at guest-entry
Date: Mon, 12 Feb 2024 21:55:31 -0800
Message-Id: <20240213055554.1802415-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:303:2b::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CO1PR10MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e8c939-38f2-4950-f0c8-08dc2c58719d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fW7s31Iyo3hzAU7ycaasZORpDNrwnjntV0wj+a/xhHonXGGd8zmiYn3l0ioPkC6WLBngKGgsS3s7CYQqrGZZeVN/zQLyKozBjPHeT+t3ED7OLbnh+RBYCdDRtay56T/ecu6PlUIBIInoLwM8b01w1FuXoIoni01GVfTDzvu2Hspy7DqQqBKMLSvrKITGumKfVyNfVlEIzVSZax5azsd6dQlFJQNt75VGluqqvOVpCv4LWFvO6LtDgoWJN5E+08TS7+vjgKI7vEv0grCyNL9HGxOaO4GUyrUhi0DlEkUmOiKwbr4TLV2uNb634UUPc/lytwoy6Vv2VLeAlFxMCntCZXketFf+c7MKhaDiex/xdh6tXztcI6waeP66UvmvX/RQUw1ofsk401cngUdivbvYRfSPLLpDZD8Pt60xs/GxJfS6L9LRGmsHzK/KR5mNpcjn5l9mhhzx7Y6pRT2RcrSCzB9wIHvMHlDj6nLFCOEYffMPjfM5iBUIbQU9Axc03jeNxqyhk7MlLP0zvJcJnjoqe7Dv7WhUs13/mD0MpPfcnoo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6916009)(2616005)(41300700001)(83380400001)(26005)(1076003)(4326008)(8936002)(8676002)(66946007)(66476007)(66556008)(6506007)(6512007)(6486002)(316002)(54906003)(6666004)(103116003)(966005)(36756003)(38100700002)(478600001)(86362001)(2906002)(7416002)(5660300002)(7406005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uXjjGIct/j1Z6QBj7gEpfjAO8+p2Xzc/wEDMaEHwNyV+dpYxXbqdFMsyoZro?=
 =?us-ascii?Q?wjf3i4gRZ2vx+4DTzYX3mMgRGmI2F+h49DtpZI72e39jNa/igKD1k3Q1FamH?=
 =?us-ascii?Q?B2owSRQi/caCieb12YAYdVKLtRjDx+vfW2y5+ubE05zGNCGwibZ+GfOXGyQ2?=
 =?us-ascii?Q?O7ohvYAE0hDQD9cbG8Ua9avnobXzI9ynAbZY7J2qYh6H5Sx23YLKgO5i+E0+?=
 =?us-ascii?Q?riWBe6oUj1yRMFO3R6hw7xyPw8lix6FGi9YpUl+ONPA4EY1KlFQXeidLbzUt?=
 =?us-ascii?Q?1vuQtesvtky+YJbDKVMbkre4QL9xl/0EdQpNYY+m5lPTNNnKTz3ex37rH5Vk?=
 =?us-ascii?Q?15475R7Z+aQrVtiXQL+7kTeAtULp0drtCmcbYjjeVHiYlj7Lg+tqZpUv2sdK?=
 =?us-ascii?Q?XcQuwFz+7JbrLvvsVHPezfnHI70zm3pEOzpVxoExYtSfppMA3nJc3CWQOcwq?=
 =?us-ascii?Q?WshXiqeFDbcIDIrZkAxbDwLIL9MHyEEwB5XqCHc2p/W7spTaHLSdlESTDAGd?=
 =?us-ascii?Q?cjiXUsEifdYmWM9f7Y2LmFCHMzZq+XQJYNvrWQyKJUX/0vtZoz4fd4lROdlY?=
 =?us-ascii?Q?HH5OTkb2W6S0IgJG60HvpCZPDiJyCE609f30rf7tv8JU6e5y+90RGkJiDyVd?=
 =?us-ascii?Q?iwfTszF42IY0gx4RX0jramW1JtYI67DdrquAxZrruAyIGWBpagGPHxDXEYKw?=
 =?us-ascii?Q?TgPXdy6kbaWGsdzwEEiFhucjfban+JcbGuHoOzm0kocrDPR8Jeup02pCkoAe?=
 =?us-ascii?Q?8HaXtW4OvgU7CWM30NYrIQlKj7wrA0q6mbWpg3HbW7Op58qM0GKPaYChqw+x?=
 =?us-ascii?Q?r/GEbL9TSEItrQ6kj7YmXUk6JEHoQoDF7D1bTpYQ44+r54GbtXiDDWJnjvdN?=
 =?us-ascii?Q?0C1gFrlnxHFS7sY5GorcJPD5I+FErhPQbKt3P8BM00OLlJ5+glSEIq0oYf9d?=
 =?us-ascii?Q?y5dMyZZol0WtmMSJLU9Iz4AOyaG3Qi4ALUCuDtPYJdAzwWDO5Yq+nw69JRO/?=
 =?us-ascii?Q?mMv0j1HL1UmRehAVPaFfvbvfaX/Z/Vh4xBlZt4QC5vDGEpiQXs0FCtSUIqOx?=
 =?us-ascii?Q?OzvCZ+JHzJoOSv8gZ2ZR+CsttKK+Ej/uH2laU7lmQuRIt2ncc8Hf6LDXa//z?=
 =?us-ascii?Q?WJ90tSk/c/FgB/2wHP3UHOVLBHuAprAgwlM56LfT21l9D8Xtg091PknyhyYZ?=
 =?us-ascii?Q?J9nVvr82JywKvnMAZr+/ezMNU3q7vQl9Qqy0os2RsDJrcau5fDqoGxWVlSAc?=
 =?us-ascii?Q?fjsABRjKRXWHXlx5qXN2OSlHzk60NJ11N0pMgWZMSqjEhDltOvgJ/Ci0vzJ2?=
 =?us-ascii?Q?dIVC5eZIKDzIahrl7dh0LcsChCzhTNDeuFxvxAJl1u+kjf8GuK9hxyVf34iU?=
 =?us-ascii?Q?y5gmN+1Nn8mw522sjnjWAfhwASbioYQai9cfD6i0rRkLFvyvKnwWf2i8eQQX?=
 =?us-ascii?Q?bkqosT+fH8tWC0h7vl3NYqDUDKcRLfL/wEyiNi5iaaUAn7eN5nKaCZ09aKZG?=
 =?us-ascii?Q?OCkqXJ0lzW9JUAUGuQDB5m88ZuUzU/rytBitBZ8UTgAxs9rD59Ry8QW4Rtz8?=
 =?us-ascii?Q?zEikb7CZL2U8MMp0olNsF/UI7v6hnz6KONnvasR2Z0msJozjW6Yp8ODdLs1h?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	A1OCSDJWHJPUzHM3SL1fRFGKl0gxD9Faqk6T9/lDrZvbm44VpD958Kb9+Tr6xgq/HAEVcCwHFInmRuvUGb7FRFvMvIWu7vNMWw76Fj8wR9h8OfVJbXabFj2HsTVIWEI6eSNrmxZM97TZdKF/SGrIGRAMifWSTaMo+GcHstB5fW6yfpZsnU05WAeIm2oWfLTeAG4y7h3Lx+tROsoCm7CKThnPzc/RcybZFnrXh9+KGsQmpuyt1MBp5e7ymMb2m9SnNLCmh74Yx3zY4qDtwzNwXwrB3FAs4LlCrtFFSpl2cH7WCFx8gwS1OOe25ZFKjouBITTZ0c5tmPUUQ/+VxlNc0OslY/Ubb+JdiNX+IXwKFH+m6WZ6BbKXE2FxilvylbShk6xYEkkbnxFoGtmDVwr7lsOCWAVqObx7fvOqFGWaxG3vJI/rR1uO0b65g2KMnrbG+AjlXEiN6IybmL9tzoUJDIhxNzvbV/73Eu8jTdLAMhGU5HsUOQeBbPZh62ojg9quPVCcazyb2cABr1OZtKshCXHZpJm9WkbCoiZCg9OHZWKAp/LVw4pqAJGECHvwJ4r/8K6/LrUO671CX0I5SE7Yg7TTGn76UKZ0t7L6pipcKgg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e8c939-38f2-4950-f0c8-08dc2c58719d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:55:55.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYRjJ5vvaA2PLH4R1G18TbBEXmRCNnH+CH4vImvfUghwYg+ti4UDfO3shLlP0iU3omBtmNOPTt3Ud8d+efBOgdm5qWeWLcpfwWT39IQJHqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=718 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130043
X-Proofpoint-GUID: DHA3pgLUIH21BP735zBhJ29t70HzAB8d
X-Proofpoint-ORIG-GUID: DHA3pgLUIH21BP735zBhJ29t70HzAB8d

Archs defining CONFIG_KVM_XFER_TO_GUEST_WORK call
xfer_to_guest_mode_handle_work() from various KVM vcpu-run
loops to check for any task work including rescheduling.

Handle TIF_NEED_RESCHED_LAZY alongside TIF_NEED_RESCHED.

Also, while at it, remove the explicit check for need_resched() in
the exit condition as that is already covered in the loop condition.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/entry-kvm.h | 2 +-
 kernel/entry/kvm.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 6813171afccb..674a622c91be 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -18,7 +18,7 @@
 
 #define XFER_TO_GUEST_MODE_WORK						\
 	(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL |	\
-	 _TIF_NOTIFY_RESUME | ARCH_XFER_TO_GUEST_MODE_WORK)
+	 _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED_LAZY | ARCH_XFER_TO_GUEST_MODE_WORK)
 
 struct kvm_vcpu;
 
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 2e0f75bcb7fd..8485f63863af 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -13,7 +13,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 			return -EINTR;
 		}
 
-		if (ti_work & _TIF_NEED_RESCHED)
+		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
 			schedule();
 
 		if (ti_work & _TIF_NOTIFY_RESUME)
@@ -24,7 +24,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 			return ret;
 
 		ti_work = read_thread_flags();
-	} while (ti_work & XFER_TO_GUEST_MODE_WORK || need_resched());
+	} while (ti_work & XFER_TO_GUEST_MODE_WORK);
 	return 0;
 }
 
-- 
2.31.1


