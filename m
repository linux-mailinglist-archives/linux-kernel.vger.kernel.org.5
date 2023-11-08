Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33067E4FBE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 05:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjKHEew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 23:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKHEeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 23:34:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F2D10DA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 20:34:48 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJPcN004600;
        Wed, 8 Nov 2023 04:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=bU7trFAdt/VfFzZIY0spnLm/jqNLyHJTyS2/kgauIII=;
 b=hyNHaiZW8+hdk8smq1RnBZmzvVuW6OhwzMDKIftbcfhQSeL3VacMCpXvLZboe2evJO5h
 uzfXXmXu36cMB1IOhheSNoaveAFXzZSvyM3kYtuqbK+6SgW/vx6yLfbMNLIJ6hBc3oyy
 9EVzuN/CgJtHxsz52c4U0/aLx8RQX0ts9AlrJC1qGwVNghhXlOvvMndBiMFKM+63v2wz
 rycq9ep+QCfYDKbOg0/qN4PmLY8VPMX3W1YqAUUWDJ7h3r1yabtB3tX7iSNibicdYGm9
 TKSF3Zmihe9I1gNTuzBgdg2pwJxv05cHpRMzxbNyRxYgP67tXXIXsvMJq9JRKGbiDTrN 6g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23ghtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 04:33:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A840UbR003805;
        Wed, 8 Nov 2023 04:33:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1w57c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 04:33:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDbSoOpm/xH5EnLmWRufIsalskncdskpBFlTUUdhnm4cy5SUD71Ve63ua6aFaNR7VisT4eSYQCUHDP2Sv406siguKpX11VTmxwL1LyM9BvRG7MEpudeJUvxxuLqXbR/agrtH65FYc68uJm5Oo1T1j/VtQKxBQlTx+g7HgYEJufKVSGAAyrrCXpxvbQTr+9OXqbQIfjpndXA/huw+hORpJUGYsj3HIe6b3U1d9zKcUMWQElyrZ/EucrGknrY4OkPnsYlqrl51/1HLP7tPeak3v+gBlItkKTg1nj12Y+76Tg92Cf2gzBApOsOnyMcx9OAxnmuMTiVyeEGFzcFtZUce8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bU7trFAdt/VfFzZIY0spnLm/jqNLyHJTyS2/kgauIII=;
 b=Qh/NyuV8EMekFqv1rTucW2MF8LA4exYeMcFWV4DoHIGGolkgb0/jCM8R5kkYl0PcOX0CTTN+yJ/E8T4viwIuNta3orX/g+fwzlYK4Awa7Qz66qKnMToxOjeeJHK+Qv2T8pCuD+/k/5WoMbT7gg34tZA9o8G6LApdqn4TyHXDqocC7/3smVgCTDdJ89u1PgH68G/nvKngXBuXG5S0WnxvMw90WblaJ3VavHqTuImcX9M9LCdNlQNqHFD8Tce1p11m7X1ISaCIE1S840Q8MMK/VvJ0njSfMzPnxhRgsDawnR/4wI5m1NwUxyKv0OSzvWl56XdAT3K6XC1ZE3ZXcbwa8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bU7trFAdt/VfFzZIY0spnLm/jqNLyHJTyS2/kgauIII=;
 b=R1jqoJkC84/V6grtFRdWfD4poiQQDTxjCMrOKumvXiBn7zkvJT9AWXTWZtIy95m0TpfEpAcqw6LXsTb0SFRSiL6FUMFORm1qqaffrQLWAWigw8e9tDGqcmgNm6hWZcY/gk+kJNR0SIyktucpwWjTBTlVbDzzKnDV5g+00hMhd4U=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA1PR10MB7740.namprd10.prod.outlook.com (2603:10b6:806:3af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 04:33:12 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 04:33:12 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <549c1cba-5cad-7706-de85-d61376db25cc@linux.com>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
In-reply-to: <549c1cba-5cad-7706-de85-d61376db25cc@linux.com>
Date:   Tue, 07 Nov 2023 20:33:10 -0800
Message-ID: <87bkc4vp89.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::25) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA1PR10MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dca312c-127e-4609-17db-08dbe013d0fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZQW4SSU/jWZ1+cwfb1hL4I2Ao0QAQdnS2/4/5qSKgC0xm9g6co58lZuRIdDOs79JPw+BJ2ynDpSd5/1KoTkY2BZW06KwgudD19vCcoc26ZVlElUgUTw2bbo5i6QvITF83VCXrcJ2t/UiJg16OvxTD1JiN1OA6cWdAf4ezEpDsTXl+M6KqdKGrzcMIQ4kh4S2XapKkhmo0z0sDvzc9t5ydmGUQUtcWjmgykqWUd9HgHwCsseyI5pt1lRWquPogfXVi7tBkur6YQZ1thai2I2I49a6KmoBREIfzpBh5N3eORuyYWNhNbUi3WRcT9EJsqHcl3QEFJBWStolsC3TS6pBc1DXoOOncYKFzLHQh6lqdgkipOoWr+4+pMWKgjO52NCJ/JOhxmreme7vU2MWQyLK35mK+sUO/i/7SDM55xrwTXhPalvotN+ZRdK1G6osyXdul9zzDmdldnjRwGLkGDZae1STKmYAYvU4rvvkyqxBO6MZyDmpyzI3aLoXnao2q7tP/7nP70kXLqiiKHlKBO/Cexcc7uoZQvWYeMEGphG0hM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(346002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(66556008)(36756003)(86362001)(6512007)(66476007)(478600001)(966005)(66946007)(6506007)(38100700002)(2616005)(26005)(83380400001)(2906002)(6916009)(7416002)(8676002)(41300700001)(5660300002)(4326008)(316002)(7406005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Io8XjZ6EfhggOOD3Q5HaNtHKGSIRttRtP2vgIc3oPz7awYxq9rqT1vk+qWLs?=
 =?us-ascii?Q?0UsEg44Cktw4VpNCiY88chyomWYSpuF/8gxqcgnw/jZ4NsyNyRrr9uKvRg9X?=
 =?us-ascii?Q?Go36MVfzLyPJ8UR5FmEgkkywfd++Lu1Epuc3YJwYY5Ol1A3dUKCkud72bwLW?=
 =?us-ascii?Q?/FPo9QpQbxdyPa283L20dd42USvvl4Z5BEVufb5kgLaxvE8u2z3RyJpsTXoV?=
 =?us-ascii?Q?4Hx928DKjJK0F4zMZcZ9miMyUSD3Os9TraA5WAe5E4M2Z5P+8UlZ7so4hZox?=
 =?us-ascii?Q?DD8xtDJbOvVVM8Mm/GI5OR9D40UaAATiSFZW2xSpzOL89Q2pJ7z+JUP/BbI8?=
 =?us-ascii?Q?OCjYmdwOu1LCmmn+Cb3+x5jBcRu64yNx2NHB7Qo/WiojUarK8XBDdWJwaHfl?=
 =?us-ascii?Q?CdAmbvWuxSzjeu9mZXAR2Vkth1pAMFH2czORasTTil0Bl3XHHhZl3eAnsEpM?=
 =?us-ascii?Q?F56Qsu3HsGGbHjM/Kv98ES63xW6DUscUbDVZ+O/9QyXdBI/VIuzOgOfMhhoG?=
 =?us-ascii?Q?FVn79grdf1EEzfhgNp2idVMYoXrvy69FPRhAvpDcKfAo2j2VRkhxUwDPYYKj?=
 =?us-ascii?Q?SbP7COGrT2OBGhvZx4UouCJhBI8plLmgb+XeUtWUZt7Njj8FtM7uYavTAacv?=
 =?us-ascii?Q?EhdG6Q7OFg0axbsByEIV6Ew8zsJ8w7jtF0C/HfoMWxxeq634+0meVZw33YMM?=
 =?us-ascii?Q?+lQEVL7FlDEIr4so0tXy2DXUuaJzq5Rmi+L72+O6nB25rqhUX1XnaOgtcPHt?=
 =?us-ascii?Q?SVKCVtVIlTTfCjGekhHmFNBJxbe4epx+PBJOt8Ua3XQojHnuVgM0it+FIKJQ?=
 =?us-ascii?Q?ItxM+lwm9iy0Q8FB+2mkk3e/A6SRtUdPFh4WkyxOUSkh3gemhDDwe38mvM4d?=
 =?us-ascii?Q?+0f7lExk4902Q14w8xRL+I8gW9kAuhYCSn3HocKo97gzeA9l2269fYlMWL/v?=
 =?us-ascii?Q?Ll4f2RSDXyRmsSQI03N8cYynyv6qa/6RqLHQ37Y+NK3wZtVswjNoF7GzdqmX?=
 =?us-ascii?Q?6b7rte5ZbuJ0zIB9EopyK7ep4T5HraQtskNviVzyR982OYcY6MUC+EBaSdwa?=
 =?us-ascii?Q?7NegrlXG2M4fSauYl9yQpSjLtBpp12cWo0IiQRuF6yNvM4JvMsBgnWSgmsg2?=
 =?us-ascii?Q?IVI8TnBC3CDe1O/6usZUWwl+ir3coFVM3VUIf58IVfB8hUjMqI3suMW+d4Ku?=
 =?us-ascii?Q?9t/mPfvMQ9geh5GrfZixvYIil9ZN5epVHP3CYWy9NdCHolcQAoEDyiSad0HO?=
 =?us-ascii?Q?PY5VYOGiKlci7hfEQ2YQabIgiY33eZUceidCHqT4YzmjSzXdRE1HnF1KILtB?=
 =?us-ascii?Q?exgR7H7s79tVRxe2Lnhzr30p45a/oWni0c+AJifQ/se19JSam3BBxdz0pTzQ?=
 =?us-ascii?Q?g21T0dBOEZP6gyEamzsYOVmlzTy8egMb0X/DeqX0jgqeMU1vBSPYK8Mx/7yX?=
 =?us-ascii?Q?xMJIFnE8lPNCzb5WIFHu7t53D3oj/r1ieND/0KoAeu2Lt4ySp53TG0YySw/m?=
 =?us-ascii?Q?oZBgqi50ljA7QOSnCp7s2LqNMZpKY8zAYeZmlRD2Nvi6ji2D4pS2GPEaSupv?=
 =?us-ascii?Q?05YlwLerdPj7SENzxl/LPRQpo5k3nPfwInT2Wt1z3o3lffARjF+m//XG81Qv?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Ifo7zjZJOEi2CzuJX+4gC2B+HgmAwJtTPguSiCQq78/Yewbcg69HTAjV1d7d?=
 =?us-ascii?Q?N5jjqlBx8eiCYp9EK/55ghE6uLvCowVWTRtr1q0yeUIfsDdTCATk2OT5FRB/?=
 =?us-ascii?Q?Fmi79XGMSJLEPGkj16Kt9aRy0RADglu+QhyKRmuecGkCU4DIC57ZoI8qg17U?=
 =?us-ascii?Q?NgbpeZ/n37EJHP4vgdERnF3Y7xKjmSmkgIM1/sUwpAQ/6RUTL2Ystx5rfpCA?=
 =?us-ascii?Q?eVlF7ZAWG263WPs0sAqtLO/FWaKeu8w02cMradn6yBg3JkFMIKLbxFBjk8YM?=
 =?us-ascii?Q?7suH/bOw2z+UHOQEfELtRH0hXxDQCRPCRh/ugcK/r8Kj9hDM+sIQdcd2XCIN?=
 =?us-ascii?Q?vaIB9fWtyS+vOxmozO53WgdngSd9SAslwcKvIFBBEg64jkmUDEZcyLAy67/C?=
 =?us-ascii?Q?hUYE6GjE+vZFbQIs8KdJSWOHtIAq5vQ/HTCA8xpuLz9FxEXm7u6zNnrCfBVH?=
 =?us-ascii?Q?Jf1k6Evnmub+Q5zuoi0yJFEepM8ZspqsA5YVIwqyDPgBWKF8lOrxE1AY8Tze?=
 =?us-ascii?Q?te+SAz8KvJ7p/JuZZYwrgvyvq07rQJARuYdXg41vQuWbhyXup6tFWW/LV987?=
 =?us-ascii?Q?CzkUqO9Dg5DqMLCMLw5c+rPTp9CZpJtZwOHdE0rj1k3SIGP0Pe2bO+YLzA7c?=
 =?us-ascii?Q?Rq89Zzz1pFh6wlNo/qfXmvCs8eD0IoeGq2EPV4swNYkkc2hB3nD8fYBOcyLk?=
 =?us-ascii?Q?EURwnbt5UbIgiGpLoqeMGKP4aw3VAFyl7pcwRz7cLsjJ3nOqul1u8mOAsrXm?=
 =?us-ascii?Q?HoUpB4Vd6MjsJjujtDBryHj92o16ojcriFqRzMf3aUqJ245Y67DFuciUqZN0?=
 =?us-ascii?Q?tvbf4XLK3H1xpqJdp6rvU2oAL6Mcw39AUYbqK7dN+nhMzsm8Mb2GKScwOdy4?=
 =?us-ascii?Q?GNdNcjwX9Ivpzu5CWd55OlDILbuh9XkKJsXNBMdzd4vCzA5LwEA7c9RceDyZ?=
 =?us-ascii?Q?eFAnN0QQ99Qp3Yo6jxGGeXdMyJbcW0xHep5uMkis4TXhIJbzkE/pF3WjTAVb?=
 =?us-ascii?Q?Kj8axzNkGuS6PXR/KMJM6aej9DrogJfmbYyLXgE4aegeL3bPLkDP8Ln691mR?=
 =?us-ascii?Q?SWKlgwU7bJO8wJ895aIi0yT8wKa9pNlfmGCStdgOzAwJYgn5I0lC1IWGjBwd?=
 =?us-ascii?Q?VTPKMV+oWJxmqbuJT0KtHRkDgE9tsvhkqgtqhrQScAqh16YzJHlPNSK3qNAc?=
 =?us-ascii?Q?A9rj66rbjxSr+oj9GhnKDxBQiJvy9Lyr7N6kkUeY6pl4oiGrbL7PM7AIgrme?=
 =?us-ascii?Q?o7+OciiWst1o8w/jEhu3yB7MpWJqy3UHEusQtKKW60ISEKZGmxPuMPwjva+l?=
 =?us-ascii?Q?KIoMwgXPafTVwFIB4C7zpKKr1o0RUBI7QZP9Ge8N9UkdJ8p6WaXXU2LGGdEZ?=
 =?us-ascii?Q?YhM8AnjKkv8iFYNQoJHDVUSgYyhbUsUEdPPSQM63x5ZsCqUDPO+6CTRoI5Pq?=
 =?us-ascii?Q?NbJJ4wM4Ic7DAoGfUS2k4Cjh8Dq/q+523bWiZeA+tjxS3qN3sqdPnd1tjPK5?=
 =?us-ascii?Q?/kjMaGu7M5fbNsPL+XHKYmCPpr/lyuttkwjf3nyeuM8MfukYkB77Tsavzdl1?=
 =?us-ascii?Q?EitHAX6ZDrk5EatNgFE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dca312c-127e-4609-17db-08dbe013d0fa
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 04:33:12.0019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmZ6FcVX3VeY715LpyI3Lu3ad2xoTS/W/3BwpG3ZSx8dmc5Ibps2D/U/JSEFrPdXeuX8oYIe2upwseDAHHy3Tf4ajISGVppl9ktCXCPsJUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=616 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311080036
X-Proofpoint-GUID: iYSDOd7DiKSvGCnMaoryoS4juCpoD_8z
X-Proofpoint-ORIG-GUID: iYSDOd7DiKSvGCnMaoryoS4juCpoD_8z
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Lameter <cl@linux.com> writes:

> The kernel is not preemptible???? What are you smoking?

The title admittedly is a little tongue in check but the point was that
a kernel under a voluntary preemption model isn't preemptible. That's
what this series attempts to do. Essentially enable PREEMPT_COUNT and
PREEMPTION for all preemption models.

PREEMPT_COUNT is always enabled with PREEMPT_DYNAMIC as well. There the
approach is to toggle which preemption points are used dynamically.
Here the idea is to not have statically placed preemption points and let
the scheduler decide when preemption is warranted.
And the only way to safely do that is by having PREEMPT_COUNT=y.

>> In voluntary models, the scheduler's job is to match the demand
>> side of preemption points (a task that needs to be scheduled) with
>> the supply side (a task which calls cond_resched().)
>
> Voluntary preemption models are important for code optimization because the code
> can rely on the scheduler not changing the cpu we are running on. This allows
> removing code for preempt_enable/disable to be removed from the code and allows
> better code generation. The best performing code is generated with defined
> preemption points when we have a guarantee that the code is not being
> rescheduled on a different processor. This is f.e. important for consistent
> access to PER CPU areas.

Right. This necessitates preempt_enable/preempt_disable() so you get
consistent access to the CPU.

This came up in an earlier discussion (See
https://lore.kernel.org/lkml/87cyyfxd4k.ffs@tglx/) and Thomas mentioned
that preempt_enable/_disable() overhead was relatively minimal.

Is your point that always-on preempt_count is far too expensive?

>> To do this add a new flag, TIF_NEED_RESCHED_LAZY which allows the
>> scheduler to mark that a reschedule is needed, but is deferred until
>> the task finishes executing in the kernel -- voluntary preemption
>> as it were.
>
> That is different from the current no preemption model? Seems to be the same.
>> There's just one remaining issue: now that explicit preemption points are
>> gone, processes that spread a long time in the kernel have no way to give
>> up the CPU.
>
> These are needed to avoid adding preempt_enable/disable to a lot of primitives
> that are used for synchronization. You cannot remove those without changing a
> lot of synchronization primitives to always have to consider being preempted
> while operating.

I'm afraid I don't understand why you would need to change any
synchronization primitives. The code that does preempt_enable/_disable()
is compiled out because CONFIG_PREEMPT_NONE/_VOLUNTARY don't define
CONFIG_PREEMPT_COUNT.

The intent here is to always have CONFIG_PREEMPT_COUNT=y.

--
ankur
