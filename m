Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6E27E4B6C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjKGWEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344234AbjKGWDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:03:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F650173C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:00:53 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJP6T004600;
        Tue, 7 Nov 2023 21:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=2ZY6L9oPxrPlWmZKgAmtx10Uzt7Oy++Nu7qtHb6Gu8I=;
 b=MZyguyW13tBDpL6bIvbuyHhlHOQMNOu4SA6O2pyfSrXZLk8wqlafyb/64NbsAwxEacbJ
 KEhZqa7ZxwwGagNDD4kxy9luiTbfjsAxjlqxSoIZWBrTsq+8mo0HUjVyNHhg9Tw4ZnMp
 1B0L0PsSVbjfwaTvCe2Beoz94o5PGgkU30sOu0dInBWvN4AoJ/1BniHQsE1qpmrSkl1N
 S/POgciMCDithDUSH1RTp38nOtOLpBFSfcCq4eU2RYq8HV1JcdD7/FTdow7lglEd0zYm
 qvigtTeqS2yRoz5SR4inU5NH+UWj1OIK1imH8Wf5MIzRXjGcb/FZtT1R4VriMN48itFv ZQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g2dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LItTo003981;
        Tue, 7 Nov 2023 21:59:48 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vsk1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiCEtZShEs0MffEv60cSkjoU5RjbfRq17TVizyEw+z0pIrG9wxJhlXvW/ctHRJRfJclpbE7ZogJuwOnZMleLyj8OUUzGxeaCItRLs4vzDjG/FwiuFUldbAO/4Wd7rbKvb1dB0f0oTy4zYqAdWFegiQF2U6awiZGgqGEubh1mOqDoydPVl63LKuYV/QDx1vDMWybryO3H+r78eJ5pLCRiPvXtxKK2Z5FXrTtqnkZvgQT3Vo2jOwACvrU60vvA1vnYow166xsdZGP2U4Dek5NlkBeph5YcHRjibZ9Al7nilntSBKOaGYaCQ0fsxMAMYtma9z3jpH9156y479yZEqGLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZY6L9oPxrPlWmZKgAmtx10Uzt7Oy++Nu7qtHb6Gu8I=;
 b=i6208VcHZN27A9JrVA+f+50gvE65HcrO6pvICsgr102D+tYrISfzsdukC7rmmM/DItqLV8eU7yeUJ1D6X9y8OyWG1KNcyUpQ+5U5CSjEeBmTW/pvz1Eccq30elgzXdkd/ChVg8pZCl2qVyMfVIyjFryVO7qd5w+NAJe/IPZti0aJOsEDVLsIlLhoUviY9VRcSk4efxzej+KyqtjibhSRdJmlxvMa9YeGPlD3jpg6MhgqM0sQptoLO50L+2rNhbb5wJBGQcd9EAQla3Z7X1UGISJizpARyxjz0E96CWj4AruPnmlKv89GIeAdKgOIUbalFhuKgZWGjOYC0yxTWr0qug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZY6L9oPxrPlWmZKgAmtx10Uzt7Oy++Nu7qtHb6Gu8I=;
 b=mqs1SxSiiXo7UEmFNDHiXZoLuwQoXiw/usW58F0aqUu/iiwEBXkVVGYMER3qAl5befiSnxEtbHKibsll7qvquuXIMe0Ce2iF31InKPbiNOxkOzX/rVq8CAI6VDwd7bNXtfbEeQ2MtKKhzyLyKPIagKRp+hSotv5+Bvgz+AnbWYk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6141.namprd10.prod.outlook.com (2603:10b6:930:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 21:59:43 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:59:43 +0000
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
Subject: [RFC PATCH 39/86] sched: handle lazy resched in set_nr_*_polling()
Date:   Tue,  7 Nov 2023 13:57:25 -0800
Message-Id: <20231107215742.363031-40-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: c09bc759-dae1-4d26-4eb9-08dbdfdcd929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Pj23+h+y26oGGWj302C9dY555Xj5Kf5fmfCodiWSLC8B4eseEc2pT3YmSRBh5SH7mcXJZ/2s5MEBs3PY/oDFLWq/w6viv+8GTjBRdm9EODO0hl4wGjIbACC7XG3lYwT5oGcS3j8MMXyF7xOqB3a6PTWTzhDfvH+NzyGzS5d07X+z3GMNo32onoMVLttKw2ZYCvTBHJFLIeNlTkpxQ7QMngo8IG9ZlNtcSLs2Sh990fG6oNnwrlibiTnyn4lKzUNg3cSun57fr4PceT14pfzBaoM2If+rzZ2U6e0PhuF+PaZY6vktbnte3pCEDQz8aZ/sP9a6AEi5/R5mZrezMN/MuWlvg5ZmYesNBWV93mFgqb/vrY7mBhrQPPG1qIJW43iOzqGKqkuDdGKhha+8SJ0iXhj/hrsxNEu2TbzO1tSfWmgVLR/SPJLXxbLbOKlmDMp6QA+HD0Zx4M8759PdEVQ+TQF3nnjYLzhlQW1ZhVIN22jQOzPE/n6tD81kszhjiFdVBC0o7Qxe2WlcnLlzizC5/AcbJg1+Xtk851FVbwFlSaXUQOQIEiM2r1YwaqlcRSu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(86362001)(103116003)(8676002)(478600001)(8936002)(6486002)(4326008)(6666004)(38100700002)(1076003)(5660300002)(36756003)(6512007)(66476007)(6916009)(66946007)(66556008)(316002)(2616005)(7416002)(107886003)(7406005)(2906002)(26005)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?roaUkf2m3pmWVQD1uhEAO9QW9nskEFMyNZjEzObRKeTG4tm1XpJaSa9mSq12?=
 =?us-ascii?Q?beUTfMoIIGHSErFzO0iOWEMlz+NXMGZM089QVme/aE2gN7GEdrP4yNoi24A2?=
 =?us-ascii?Q?XkZH86P+ur3YaVLCCrqYR6PVshywvASV7lQOL3xbmKzCog+9JScmbCXcyc7Q?=
 =?us-ascii?Q?Hwdl8Tz8TZjiatW8nqntb630JVT3m9KUtqTmk60Lo5VWvItl3ZCCEb3AKKTK?=
 =?us-ascii?Q?+DoeGqYnfRoU6A0t5IOFadFfy00HlFLeGRxxOsCyBC7+MkR6JJ6t3q2eXlEF?=
 =?us-ascii?Q?tR9kC4GBDzgd3s9YSFvDLJDly8VNBntFAjinJW+AhtIjukY6snJFySGSIQho?=
 =?us-ascii?Q?WB9PZnwcTEeM5hUYzb+37K1rdlSMD2SnKNj/t78lqZ+qB01gSzZHebyfDDjW?=
 =?us-ascii?Q?8VG4O8mXXrI7LrhI8HcM9KkmWpe8ZDIXO7SEkiIGlCFyrRnlXoK+90WN2H4M?=
 =?us-ascii?Q?8uo9wBUW1XhajSuWUUAukUOKNTqounsiCcFZyxN+KU/eCOlrH/ksr3FBLrHd?=
 =?us-ascii?Q?kuYghd0oqSUxHDiBfg4UsU2jyQlvpJsoXj8fBlUJ9kQxA086uWbqoIfEaALi?=
 =?us-ascii?Q?KOlQmPWITuA/yAhgKbhm8+9jQCKsQT+Rlx1eNkCsSIPrYgwvsF/G4Yf1V3lM?=
 =?us-ascii?Q?mZSPvZ1nAKCgs+3DvhKj4cKW3GP0YVx7J7JjuaTuzwzm+TWtjuaHWXgzFmkA?=
 =?us-ascii?Q?glMUJSLBC2QO7tCUWPls5Kc2DieVzCNCyN6Q4jPR7zyOO5LvZYzOP2GDqEq8?=
 =?us-ascii?Q?krR+OwJwjXL1fRxIYMRJJc3btYLhKJ6K0PsoNV5+mwrPwjIi3GABTTinkQoz?=
 =?us-ascii?Q?HKF2h1DN2RwLn3O6NJXbItuEQCYfSIuUZYDXQlqmM27VqvwrEtIR/lgDL8ZB?=
 =?us-ascii?Q?rp71fwsvlE+pjy22Ruj2WKfjMLzWVPOXbnXiVd6Lg36zgYfEmzkQAwfcgICD?=
 =?us-ascii?Q?C/XWZRLesfvelMmqZeBnSM7x5Mot1KVD+0guUrWXG5p5O57e2aDHzwjd4E7r?=
 =?us-ascii?Q?rgkJppuu4uABQRhT3QnVlJrUkN68bKV/FGaRrSgLJAtXWlQOwg/iYeuooZ0q?=
 =?us-ascii?Q?zqY2wm7w3gXglZQqHqaZHXiKsG+mSsFtNHfdKDQvkkXanbEfTN/P7PvdNjCe?=
 =?us-ascii?Q?gaW4uRIkp7L6UqG149777fp8jLlkICcs2hchgS+flIQNvRuxd9QMTQVbOphw?=
 =?us-ascii?Q?HxiSQ1U9Ke7N4Ykb46wxQgSBpfbZ12sqSJyVDAqexvKbcejn1TOIqWFm5djV?=
 =?us-ascii?Q?xIic88KmbVRJxHFKufTEkAeLxjLnL5whn1M9HGfOsgsuZWVxRI88uR1qo/rK?=
 =?us-ascii?Q?ZXhg+FbZrEaVcYjGZP/hwssoYjS6ZQDRPpQwTMjRaNj48ASts769YBO/Xnzu?=
 =?us-ascii?Q?0pdON/kJb+YH+CiuM/zWTLlDbVL1j8o2QqxkCSzL1nc+MZ5VTLSwpkzLAApb?=
 =?us-ascii?Q?lapjo7dd3yK95EvJDKvLPpmbb6wNiSaZ4oa3jFRdfWVGoO+qh+kgHzMoutl4?=
 =?us-ascii?Q?2jwwJLmmjG9WhUyG83R2GJusb/ILgC1KOsRhXx7NPvLBdDYkoTq659Lbabt0?=
 =?us-ascii?Q?4IX6awDnbPbtcZMGNPiK3zOhH52Zq6HEeMwkAhzlzv9ky678yaGr5fjhhYqz?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?SdyZxcgsbhSHsUgXh09qseJVVpJfwLuvJxlec9ku5WNhbNmCOFXtGqrJjBWb?=
 =?us-ascii?Q?fgYMUzwdwCOfRi2cmCobpVKjiBwTjsRQe9iUutXi/YeZmPaRmCDfQogIKGcs?=
 =?us-ascii?Q?jyZ8Yec+yLUbwLB+a7BWg+qoUq60LdeTHS98EKH727Fof/CX364uVzAm67uU?=
 =?us-ascii?Q?2MFOaNFYUr38QqfDqRVG8fBWAme0JOGCmup/6Cr9G6RkOtHptf5oq6qee66H?=
 =?us-ascii?Q?6UC+Lz7svtgqmXvLlHL5fshmED8AhSZaA9MsGKT8zgtfgBt9YUafjTyHSGZE?=
 =?us-ascii?Q?Dchr/1JNDdfBxeq8S5SWwTxPA3ZuUrYK/Q4FPTxrE+IdqSB25ggk2cpmP9pX?=
 =?us-ascii?Q?LM4nfFvG+dpQd0D0vkHjBhH5FIirvFsVfn/u+BFNlEuDW25B1e+wCndLfYgY?=
 =?us-ascii?Q?YTFU1lbMVGpUtmLn+6XqXWJpK7iBD0nFcPvkaULQIewLr59TtMwaXODd6JtB?=
 =?us-ascii?Q?/3l6/dnhCtPVZVC2oPbN9F2GGzpL2GU8/BgYrKcJhiKZhcptj/inEmYCRxtW?=
 =?us-ascii?Q?1dD1gn0s2WDAUzqAfSm5xljKY41ufwPF4WHX074R6pKyhBhsQT7bszyfBSZ6?=
 =?us-ascii?Q?qY5okj8Bl9K1QpjRDB7MfYGdS7nORHe2YtDbqCoS5EIuafJ3aau6Gk5xj3Cy?=
 =?us-ascii?Q?t8igqjhGj/CraedYNVtoxRPX89qYBGRMsNFVkUDx4mZrXGA+G8vacSFLXl93?=
 =?us-ascii?Q?HgCxbRw2nV4YVss+yVFLt0Z2DhfxXlLGv3lo2VMBgpEIKIOFLcjDsKBTlA8G?=
 =?us-ascii?Q?vNW1SlG/XhfM1gtYGvOahzJTQAztfz6qY+WFDriKru7WhEfjhiV/V1EHU41y?=
 =?us-ascii?Q?6kA+z1QR/KPvRlgXS0SSIBGTz7KmFbGjb7Wr4W5KCKoUJ4GUCidS7mtwdEVU?=
 =?us-ascii?Q?4ywtYXTJNEO33QYvMJ6rAkkiEI9euIUIEVQaYtZkjTV4v5RIRVUi+982/N/3?=
 =?us-ascii?Q?gHi9uppHKPXBU0jnAHHaX8CGI/LUVpTw3/e7/WVJsOe8M/xyKCD91Bvlu/OX?=
 =?us-ascii?Q?RfeAw2kTZSnWinbEs6Tg8SDePaGZ1jnkViBjBaXBFHg/6gSq15/9uSUzKzNc?=
 =?us-ascii?Q?UJM2xoibIVCn4hwJm7uyj8ikR/PK68SWcExGeqJE3JwT+5k/tZG6B9RArakm?=
 =?us-ascii?Q?JXoesjhVsjPSq7eua5fU7b+fN46BXHoslubr7Gx6gaNWlDCW3/1Px9n+gPHK?=
 =?us-ascii?Q?oD1G7z/8SMZlg0RyZnol948hAyRPJyobRtWM6AnTx5O/Enq/S52/9YejtKjm?=
 =?us-ascii?Q?3TzFvZvoP/f2x5fVZzOUJLko8K66cHRZDSUuBt/Fl94HZXjwbCQkQjGvpYMZ?=
 =?us-ascii?Q?nW3MYMnHcT9NtRna6azuyPbHhTT8xwqhUkdtgJw1lKgT8bdGmHFiV1JmWaM+?=
 =?us-ascii?Q?Lis5mEhDKL54tJ0tcFwr+mEb/jfkrlansNwONK8Pdvbyo8YOjxlRU2wvd5gU?=
 =?us-ascii?Q?Z8TSMDKJUu4Dtxkx4bdfQ6kvL29hPgu19U/nF4azRaKf1gABJsw7q9fCQ2aD?=
 =?us-ascii?Q?9nvU6Zcw4ixFBD8pBKIjEMnaDeVNtclfifzMt/aXjdNsE9Mk+bFi5JmgvQ?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c09bc759-dae1-4d26-4eb9-08dbdfdcd929
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:59:43.3736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Z0uWXWVsnEgWk/5dwKtwF/8FTnjONOvtLioY+LuteWR4rFbgq+X7oBNNCPCuCoEqSxplGjE+KMPBIscNv/VF5u3TCPitdIQcSXblhpRhZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=878 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: sp2nYV2JAZuCrmu3aqRNJ9yTKinzfDI-
X-Proofpoint-ORIG-GUID: sp2nYV2JAZuCrmu3aqRNJ9yTKinzfDI-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To trigger a reschedule on a target runqueue a few things need
to happen first:

  1. set_tsk_need_resched(target_rq->curr, RESCHED_eager)
  2. ensure that the target CPU sees the need-resched bit
  3. preempt_fold_need_resched()

Most of this is done via some combination of: resched_curr(),
set_nr_if_polling(), and set_nr_and_not_polling().

Update the last two to also handle TIF_NEED_RESCHED_LAZY.

One thing to note is that TIF_NEED_RESCHED_LAZY has run to completion
semantics, so unlike TIF_NEED_RESCHED, we don't need to ensure that
the caller sees it, and of course there is no preempt folding.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e2215c417323..01df5ac2982c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -892,14 +892,15 @@ static inline void hrtick_rq_init(struct rq *rq)
 
 #if defined(CONFIG_SMP) && defined(TIF_POLLING_NRFLAG)
 /*
- * Atomically set TIF_NEED_RESCHED and test for TIF_POLLING_NRFLAG,
+ * Atomically set TIF_NEED_RESCHED[_LAZY] and test for TIF_POLLING_NRFLAG,
  * this avoids any races wrt polling state changes and thereby avoids
  * spurious IPIs.
  */
-static inline bool set_nr_and_not_polling(struct task_struct *p)
+static inline bool set_nr_and_not_polling(struct task_struct *p, resched_t rs)
 {
 	struct thread_info *ti = task_thread_info(p);
-	return !(fetch_or(&ti->flags, _TIF_NEED_RESCHED) & _TIF_POLLING_NRFLAG);
+
+	return !(fetch_or(&ti->flags, _tif_resched(rs)) & _TIF_POLLING_NRFLAG);
 }
 
 /*
@@ -916,7 +917,7 @@ static bool set_nr_if_polling(struct task_struct *p)
 	for (;;) {
 		if (!(val & _TIF_POLLING_NRFLAG))
 			return false;
-		if (val & _TIF_NEED_RESCHED)
+		if (val & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
 			return true;
 		if (try_cmpxchg(&ti->flags, &val, val | _TIF_NEED_RESCHED))
 			break;
@@ -925,9 +926,9 @@ static bool set_nr_if_polling(struct task_struct *p)
 }
 
 #else
-static inline bool set_nr_and_not_polling(struct task_struct *p)
+static inline bool set_nr_and_not_polling(struct task_struct *p, resched_t rs)
 {
-	set_tsk_need_resched(p, RESCHED_eager);
+	set_tsk_need_resched(p, rs);
 	return true;
 }
 
@@ -1050,7 +1051,7 @@ void resched_curr(struct rq *rq)
 		return;
 	}
 
-	if (set_nr_and_not_polling(curr))
+	if (set_nr_and_not_polling(curr, RESCHED_eager))
 		smp_send_reschedule(cpu);
 	else
 		trace_sched_wake_idle_without_ipi(cpu);
@@ -1126,7 +1127,7 @@ static void wake_up_idle_cpu(int cpu)
 	if (cpu == smp_processor_id())
 		return;
 
-	if (set_nr_and_not_polling(rq->idle))
+	if (set_nr_and_not_polling(rq->idle, RESCHED_eager))
 		smp_send_reschedule(cpu);
 	else
 		trace_sched_wake_idle_without_ipi(cpu);
-- 
2.31.1

