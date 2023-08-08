Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8F6774AC1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbjHHUet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjHHUef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:34:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F22A1F41C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 13:01:27 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378JiXmo023283;
        Tue, 8 Aug 2023 20:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=KH+BOwlkHhafFNvrg7GE+uUnGIdDGG7B7eTuNuw2cFk=;
 b=pM+2ALKcx4FYa1YU1RZlLVXozB3RzDGbrRBudbnioPlsdk91mIl12j9lLztGhZb2gUMQ
 bhAXmgj5W20Sq1IbLYFbT1VSj/zTrfc10c0tWwcECdBihW2nqRbV7tPezpzUrhwjHjPZ
 ZBnd+ebISUIxqTny69GqA9ILq3QDkbpsWLxDUBDnMam8EV8b9ShCrftY1x+Tf1w9zEnq
 XZchDQoSnOfhdlgTsaxIaL/ei/ffrcq6+60UzYVmK38TQOYlL2ibeg94o0NYx/WKUYjO
 xIPxDmaCpuHdJS6FuUJfsivOA4y9kzrK2rC6tRgUe4aHmc5f3H3BZ7mk9KlBt/hrJ9b+ 6A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9dbc6862-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 20:01:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 378IWwFY032731;
        Tue, 8 Aug 2023 20:01:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvchuu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 20:01:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByU72cmjIaWw+VWcGu4SyQDlLqmS1/e1DnJUaEW96MDqo5ltC6Z67nPZo6TT5OxXs7GDcj8SCWr8FDvMe+O6fWAaxlCOUbr0Ue7B+/TBQ1SITeJbt7Qx8bfGt0GjDWAsHj6Ol2xuv51J3nlUAzSLyur+Ntz3enPTyuuRnWvfK1XXoM1u6LQrK90mF5YdVooQrSJRS6A1tYKNBohB1bFnBgOSNQvogHTUjQXIwyVJZQDyw+lSuSSgSHCp+jnAnsdTyzsceM6NOmed6Jtl8JHljjiSTu6uKseGjfIOQUPJ1wik+UKCDeIRt0rrqJ0oj0HtdskTzqHZZex8cQoIicxWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KH+BOwlkHhafFNvrg7GE+uUnGIdDGG7B7eTuNuw2cFk=;
 b=jd1IHQ1ufFS8re0HECilxBRj12+60J82WCcUGM35rVdIUSqK6yxQG6cE6gM0FuRzy8yR0cypzv33l6qFPWsiDp2tYwofDujNuJCwt6qTaK+zolBhFREx7D3Lo62g1/hSx4RYocNaQjU61D3ebW9R3U/0+Wu9JHGzLpi0Qfek2OlaoZXAHbt1VBkXdo6xlVRRyr0j7lsviLrIXINZ8vYddARcGU7sqKI54y3XxQbM9ffnw3AbcBPvajjYX8rFvKKnmAIVprHkm7gd/UnJ7/nOJMc/kdiyevW9U8O/UCc+BWheeu5tzOoMw2fwz6KZHiaDIzZFE/fW8qiQWmdTg36hAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KH+BOwlkHhafFNvrg7GE+uUnGIdDGG7B7eTuNuw2cFk=;
 b=vpJTmaYXjWOGvsbK2eEVsBqX8/hWCVKLanXO2Eb5H6NaHekM33+46bHu4yt76tNV0UXcoB9+HE005s6WAtYN9t2PozxDnURRTMphuEraF3irpD9esxbTIjyxxzCvKWwwBUV+fXS0S3s6lXZ/C/MJCxzekMbcBImvhTC3tKs1FIc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB6348.namprd10.prod.outlook.com (2603:10b6:303:1ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 20:01:00 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 20:01:00 +0000
Date:   Tue, 8 Aug 2023 16:00:57 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     John Hsu =?utf-8?B?KOioseawuOe/sCk=?= <John.Hsu@mediatek.com>
Cc:     Andrew Yang =?utf-8?B?KOaliuaZuuW8tyk=?= 
        <Andrew.Yang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qun-wei Lin =?utf-8?B?KOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= 
        <chinwen.chang@mediatek.com>,
        Kuan-Ying Lee =?utf-8?B?KOadjuWGoOepjik=?= 
        <Kuan-Ying.Lee@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [BUG] trigger BUG_ON in mas_store_prealloc when low memory
Message-ID: <20230808200057.p3pqwkumghqbdvbi@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        John Hsu =?utf-8?B?KOioseawuOe/sCk=?= <John.Hsu@mediatek.com>,
        Andrew Yang =?utf-8?B?KOaliuaZuuW8tyk=?= <Andrew.Yang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qun-wei Lin =?utf-8?B?KOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= <chinwen.chang@mediatek.com>,
        Kuan-Ying Lee =?utf-8?B?KOadjuWGoOepjik=?= <Kuan-Ying.Lee@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
References: <20230613141114.bwbnqsdazqbmyj3u@revolver>
 <3b14df2fc2a7f18fe12f87a27574b7d40f2899ba.camel@mediatek.com>
 <20230614155826.cxcpv33hs763gyrg@revolver>
 <ed7899c7328aabfbe9bc9589f0776a75e6c9d1ee.camel@mediatek.com>
 <20230706185436.agobbv72o3hma43z@revolver>
 <3507fdacf001c49f4c73f2952257beabfe9e1a53.camel@mediatek.com>
 <20230710142425.t5vhrqkjd7ugbmad@revolver>
 <f7aec937af73798c5e42b7e37adb744df5562cca.camel@mediatek.com>
 <20230719185135.nyun5fvcuv3ydku4@revolver>
 <981aac92a51c4e2cfd2ca83d11742e5741e60285.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <981aac92a51c4e2cfd2ca83d11742e5741e60285.camel@mediatek.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT2PR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::11) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb71cea-8dd7-431c-f07b-08db984a300c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hI6iUIVrwr/aN6+006TM/YqCDSpQ0DK/l/0jSd3i3GXKM80VM8KDNhazm0FySPH6J7T6RIZ2pmZ1eXeWnIA7ekyLTBZjK7uAcpDdQmQYkGj0odRif/aKHyMT4KBja6Yuq82z0cvZolFZ6avy7UNU1rdNYPP/z9cVehdccz/DNyPZvNs2RPgA0CAc76mtN0bzDDk/r1hmq5/HmySF2VSsIjCqw8ggJ56OOksV6d844EE7LycEjOH3Fp+OqR5U2Z/gglcrNpm7FL7yY5Bq94GbHjb+QpbfOZ89wfgBRrLLQat2JvUvtSfCkkfphr94nGO4aptK6GdDwnkUzUHRAYVBCzzNVIX0UMrAl84vKU0zSJ6GW6y5lU9cmU2yWClBl2nFN4vO9H2DkFoot2NHlMzURIz2DkAe/zvfokO88FO5yGeNb+DOi7hryAUpA6F89BkwjfWK1VmSdynP9Avgitw6O7n5096+f+5+H/QDCnIfd9jyAOutkSobDR1El4adkt99Fhmal3FtZ6Gtb/ogOyVYbXioQjLZNuX3We3ARpUIYLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(136003)(396003)(366004)(39860400002)(1800799003)(186006)(451199021)(316002)(83380400001)(2906002)(8936002)(8676002)(26005)(38100700002)(5660300002)(6666004)(6486002)(7416002)(41300700001)(66476007)(33716001)(6916009)(66556008)(4326008)(66946007)(1076003)(6506007)(478600001)(54906003)(86362001)(9686003)(966005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVZHMVVEcEdCNVZod0c0SURrd0hmb1d6b1gydmRML0t5SVFTNWN3YlpZdDNZ?=
 =?utf-8?B?ZGNqeXRZWjBVWkhrOVVUTkpoMXJPZEFIVlNieDEwd3hnTDdJYmJmL1ZpKytD?=
 =?utf-8?B?ZitDZjVjbXdadlcveVFoQXQ1WmpUZmFlamRYQ215YmtqV2lCcHM3UEFIek9O?=
 =?utf-8?B?eHVZck1SMkFia3JQTEMyWmpvdmVqTU9wS0szNElVb0V0amFGUndhTkFxbzJa?=
 =?utf-8?B?SVNwQWxrVUU1bzRmYW5jYUczWVNyTlhocjhkbFRUd3dZSFJ1NkJCK3FGSUVF?=
 =?utf-8?B?amUrY0IwZW9PRmRwWXVNRkU1QUZSOU03R2pUVUswZkd2b0IrVEtWTVd3WTVl?=
 =?utf-8?B?UURERjYrZExVWlJ6Y2tKcnY2Ri9raDRnWkU0b1VXTU9kWjREWURtZklwWEc2?=
 =?utf-8?B?NFNUdkxvTDhXcW9MOXR5a3hCS3JCRWU5MWh3ZGRva1VNUVI3UjM3S2JHVEJS?=
 =?utf-8?B?SUs0R3h2RndTbTFpRDJmeEs0d051T1oyb0ZYaS96VXZISHB0RHhZZ0ZqTVJs?=
 =?utf-8?B?cWloUGJuOC9wVW5jUkROcFVIazFHVG85VklHQ1J1b1MyQnNoQ1lGU3N5QVZZ?=
 =?utf-8?B?Q3lTSkpTSkd3THNIYTFXbWs0MUpPYVBDU2lWU3ROMTR0cENBVkUrV0hOZjhH?=
 =?utf-8?B?Q01MRTNsSGFjdXpKQWhvQTc1aVhZOFl6aU1vTmd1YmFqU3B4MThMcW5iT2RB?=
 =?utf-8?B?TXZoa2JpR2NrUjE3UlJ5Y1lMcGdaOUdCVVJLSFBReG1WaVVMY3AwVHpKbTdo?=
 =?utf-8?B?TEVJcTU4RUhMV3dsS0NxMjRxYnRFMkZEeGxYa2tVU1RnV1hGT3ZlTnROemtM?=
 =?utf-8?B?Q083SmZHcnE3TkxFc1FpWHEwU3NBYVp2b3R3akx6RkdwZEtNbWZQeVBmTHI0?=
 =?utf-8?B?SEIzNEVuTWFBMlRLUHozdmREalRId0tHNTFHVHlXSTV1dG8xT2lMQnVvNEUw?=
 =?utf-8?B?azB0MkxvL1VjbDNXcDBmMzdtL2hqTHg5NENoZ2dwTkF2azBuQmhXMVpMeENp?=
 =?utf-8?B?VWdsRlI4V29mTUtsTXhBcHd5KzhIQVA1b1hGc1Z3VU9yY05yd3BJaWRmcDlh?=
 =?utf-8?B?Yy93dEJTZ0hSVDU4ZUdaVWZpc2hNN2xBV1ZOeXE5WXNYS0ZqdWFKQXlISGpw?=
 =?utf-8?B?Z1BDampOQXZIZG9nb1RLUkswVEcrY2lCbkh0ZmVSTDdwVXVjT0MzQ0NaTHho?=
 =?utf-8?B?aVpxd1YxN2xLbGh1Y0MyUWNIZ21QWm1lSzBibEQvSVRuTFh3MUUwRklNbElZ?=
 =?utf-8?B?cHhzNW5QWmZvTUlzSk9DdzN2clhGWGxzNEYrSEJWbm95U0dvOU9Dc0xXUitM?=
 =?utf-8?B?Nk44UVA3MmJJWkJTK1FFL1E0R0tmSDZZRGNrUWhNUXVRekhqS2xmb1prbFRD?=
 =?utf-8?B?cmtQQ3JpUSswblZ5Wjhqbkdyay9TZFo3NCtjOGZBM0ZlSURGNGxSb09YSnZ0?=
 =?utf-8?B?OGdmS3NqaVFMN0pMTUNpR0FhNW1HWjh1UCt5TkMwdDREMU5QTnp6NFlLaTFs?=
 =?utf-8?B?Vlp2c3lzaUtrSEYzRkJIeThxSWE5RzZ0cy9ZbXBGRHJuem5ZQXc5Ky9rRjlF?=
 =?utf-8?B?VHJDY3BhV3ZzWGlmU0VaTmVwZ3Z4Wi9meEJVa1owck5Gd2FzbElIaVpsdk5J?=
 =?utf-8?B?WjZuT3FwTDE1RTUyWDRnd3lWdDUvS1U3cW01UnlTWm1TeE5Jem0yeDFSdU9P?=
 =?utf-8?B?Ym9RUDhma0dmN3hJWXE3aFU3bm92bk8yR1dob3JwelljaFlEbDBYajZkUnBB?=
 =?utf-8?B?V21iOWpNakdyMjJGYllCcitPcnkramhFa0hmeFdoVExlK3ZwMU96YUc4K0k3?=
 =?utf-8?B?Vk5IazZrMExRc1FXbUpadG5rQnRZRFFyZ0dSdWRVWnpFdGF4Wi9SUEwzSnNI?=
 =?utf-8?B?M2FlVGh2UkNZZUpNdUhKQnYzUW85cE5rcTJJdVFlWGxMd01KVC81V3Avc0hw?=
 =?utf-8?B?OTZoOGxXNmZ2TWJpM0NkSDRJNjl4VVZMNEd0L2VWOENPV1lodnprOTJ5VDVm?=
 =?utf-8?B?M2NyK1J5RlU5UE1oOVBPcGlGSElnZDJkZEc2NmJRSHlHZitGbXhHRGtYenJ1?=
 =?utf-8?B?VTBjZlJwQmI5Q05CTi8xQ1pDek0xOVgyMzRJcFhQK2VNWnVabUEwT2tnL1I1?=
 =?utf-8?B?ZDQrRnFIS0JFOWpvblZqSzlqUTI1S2hRRzFWNnlVNE1QdDFZMTZueUFPWDAv?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SWlqR3U1cnNra1J4OTFtSlUvcUxoS1pueldrUmR6ejVlNnZMcnFtbHdlMklv?=
 =?utf-8?B?Slk3VVE1SUNCbExLaVFORU5PZ3JSK1d3K3VpWHNIYzNXeVlzNzZpaXpvRmxt?=
 =?utf-8?B?VFI0VjMyS3B6WWFKVFMyeU52RmtUNEhQcGhQQ2dNYTNLZERRY0N2aXAyQzFj?=
 =?utf-8?B?b1JPOFloUWFtNDdrb0EweG90VWZDZlhoMmlNZVhycm9EYUZXUjY3YVlZVFRu?=
 =?utf-8?B?M1Mwb1lkU3JoK3Q1N0k1S1FKZWF3eWwyamsxYWRzRFM0ZTgvMndJTld0Uzd0?=
 =?utf-8?B?Z1dBZlYwa2ZWZXliWWZ1Ni9HVjlTc2NManc1REZxbU5qUHNJUVFYVEFndlc4?=
 =?utf-8?B?UDNKUVNtV1l5RHE2bERxRTBaemZKV3QrU3lIbUE5Y2tRMzBoSFFQYzV5aXZ4?=
 =?utf-8?B?MnBOOFRDbUZOTTd3czk5TXNPbTV3QmNkbnpuQzVFQWlsMlRJSkJCUUoxNjln?=
 =?utf-8?B?b2M4aFQ1cVZJelFTUWVObzU1ZG5XRVFTck03UXRvNjRtOEZrczlTY2xHckx2?=
 =?utf-8?B?Ym1xSjlObnl6bzdsSlBqTjBxYURkZitDc05Yei9tSWUzSkFaSDB2L0hZNmpL?=
 =?utf-8?B?TExUa2tpN1F2Q25MYkhTcVJWVnJja0lZRXpsMmNIbzcremVCYlEyc3orTUxK?=
 =?utf-8?B?WnVUR3hmVE9RNTNiKzRLUHFyUXpDUE9Iem9RQ25KQXlEM2ExckJ3NHozRGxT?=
 =?utf-8?B?aGQvNUJZczJqb0lXY1NVT2d4SStJNWVuNWhIL0doUlNvbEF6L3pGSkRIbEpx?=
 =?utf-8?B?alQ3NHJhUC9CTmxKaER0ZmN4eGhWQlJ3SEFJRUlxR0VxVUJwWUlKRjFyREpG?=
 =?utf-8?B?RUVmL2ZYNlRpUEUwYWRUcnhCYWRvT3YxYmJpWWdSOHY5NEZKblR6b2R3R2Fi?=
 =?utf-8?B?V3pNcmdBZHNodHJSUDJlS1dLQWlxY2owSEcrREdIQUE4K2FRbVRKQUl6eXF4?=
 =?utf-8?B?aG1IVk15NzhqNnkzbjNtZlUraUkxN2lLeWZieG56NkNJeENQdWlPQkRLczE2?=
 =?utf-8?B?NVZwWElJbWdiVG91RnlHK29CNHRmWWFNMzVqUCs0bHRqS1pPeHEybzF0UUE0?=
 =?utf-8?B?V01oc25GanY2MnArRzh6SStIcWpUOGZ5cXc1OWpFQ2dSZ3JDMkJQSmNzQ0o5?=
 =?utf-8?B?YUg4TytzTWQ5bGlLT2RIbnAxcVBFRVpYTlByUjZVR0ovUUZySno2Y0doOXhL?=
 =?utf-8?B?TnhWRUVUWmtjRGFpaTBRdEg1SldLSWdKYW9aN3crL0JCTXNmL1ZlOWk0SzhY?=
 =?utf-8?B?MDhJT0VyVTB3WkM4MDFjWkdHb2JhK2tQZklJS0tmZWZQRjUyZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb71cea-8dd7-431c-f07b-08db984a300c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 20:01:00.5172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBQH2CCk0UK9/bFD8gLhIP05DAf2Ma4aIjpINYDr2ehPPgEjJIcYXAU9ButK0Gt18AWpeK5o1ZakCwJWjs5adw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_18,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080177
X-Proofpoint-ORIG-GUID: IzOflIOWKKPJIqi1YLqAx12hVN8ntf48
X-Proofpoint-GUID: IzOflIOWKKPJIqi1YLqAx12hVN8ntf48
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* John Hsu (=E8=A8=B1=E6=B0=B8=E7=BF=B0) <John.Hsu@mediatek.com> [230807 05=
:55]:
> On Wed, 2023-07-19 at 14:51 -0400, Liam R. Howlett wrote:

...

> > > As I know, following is rb_tree flow in 5.15.186:
> > >=20
> > > ...
> > > mmap_write_lock_killable(mm)
> > > ...
> > > do_mmap()
> > > ...
> > > mmap_region()
> > > ...
> > > vm_area_alloc(mm)
> > > ...
> > > mmap_write_unlock(mm)
> > >=20
> > > vm_area_alloc is in the mmap_lock hoding period.
> > > It seems that the flow would sleep here in rb_tree flow.
> > > If I miss anything, please tell me, thanks!
> >=20
> > Before the mmap_write_unlock(mm) in the above sequence,  the
> > i_mmap_lock_write(), anon_vma_lock_write(), and/or the
> > flush_dcache_mmap_lock() may be taken.  Check __vma_adjust().
> >=20
> > The insertion into the tree needs to hold some subset of these locks.
> > The rb-tree insert did not allocate within these locks, but the maple
> > tree would need to allocate within these locks to insert into the
> > tree.
> > This is why the preallocation exists and why it is necessary.
> >=20
>=20
> Yap, preallocation is necessary. anon_vma_lock_write() and
> flush_dcache_mmap_lock() hold the lock and manipulate rb_tree. I think
> that there is no maple tree manipulations during the lock holding
> period. Is there any future work in this section?

__vma_adjust() does modify the maple tree during the lock holding
section through vma_mas_store() in 6.1.  Prior to 6.1, there is no maple
tree.

...

> > There are also config options to debug the tree operations, but they
> > do
> > not detect the redundant write issues.  Perhaps I can look at adding
> > support for detecting redundant writes,  but that will not be
> > backported
> > to a stable kernel.
> >=20
>=20
> The sufficient test cases of maple tree ensure the function work well.
> But the redundant operations (alloc node, free node, tree
> manipulations) of maple_tree are not easy to detect (e.g. the case
> reported this time and mas_preallocate() allocates redundant nodes with
> the worst case).
>=20
> The detecting redundant writes mechanism may help the developers to
> find out the problems easier. Hope it can be establised successfully!!

When I went to add this, I had found I already added it here [1].

This operation was not caught by MA_STATE_PREALLOC because there are two
writes before a mas_destroy(), so there may be nodes left which avoid
the warning.  I'll look at improving this situation.

Thanks,
Liam


[1] https://lore.kernel.org/linux-mm/20220722160546.1478722-2-Liam.Howlett@=
oracle.com/
