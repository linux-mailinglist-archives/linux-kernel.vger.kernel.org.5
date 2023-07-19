Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA60759E73
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjGSTW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGSTW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:22:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2AA199A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:22:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JFOpPN008967;
        Wed, 19 Jul 2023 19:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=ScJb8wvAjCXl91Lp3HDfKNS0NTAQMNgZ+6D1JmQwReI=;
 b=v6GXOs+9dNQYaLweXeH0WfAE8bDM0LNEaZ4DW3qOkRh94hZlIaXLlSpKBitMqFakVCRt
 C4x4VodhxELVRsmx4sNKBoXVYM7a4YUQjyg5JK6GU0baoHGykgFNvx5CXdIVYiwrn/yK
 CIZnX1VzVI0D1Za+TDl39smoSE7nkCB6TNbvOJ2VfdWmPSNmgm9lsgzk7oMQSyvRQd1J
 bDCqOT9Ld5lX1DefZkh8FODbvC4QTW7kz5D9jPTBszdIfF+bl6MZRfQLcz9bv7C1q1kA
 63geMbW8UNlvUTdWYXWnLR5GIQn42u9/pdQ3uYFcxNg+ZiWxiRH/aghM+UNbnmfJdysq QA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run7808w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 19:22:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36JJ6oIs008009;
        Wed, 19 Jul 2023 19:22:10 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw74s36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 19:22:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOL1wrXbZEUjX7o3yZATcEmyIT4DmR2pzt2ksWG7VqYxPyKRql14hi//rwuFJlto00Y2Hs05R36/xhx3PcsY/8NicS3azfHjJwQ2rIHsemck/2yA+hLim6ardbn5SZlbTlfVd6tLY74VGsuPIGYgMz6POf2wmCUEF7AMxMtVvcNtNluHZjI1c0CAtDHMj0/fT1Lt/2gIxTJyuoKNakwbcTMBjsTAIwP8NKIl8K0TT/uTefrRaTqx6hQ1w0Of4mYDVJ6EZ/5w3bRcgrvdkPvJnh+yQt5M/v3yQj6XJ3JrCDXQOlXnEkFWMh49JTZFRjq9NU0OSGjBXxMFLxT9o2SdwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScJb8wvAjCXl91Lp3HDfKNS0NTAQMNgZ+6D1JmQwReI=;
 b=mufQ8nNBcGNqeXR88weWEtxMt1+JB36qZXp6fi8Uw7S5+v4AMthTQA93tN8Q4zBaE+8L4E4RhuCfFUcKs0TwZM0qKrTUVsux8U5W4jlO0s8BpAMo4sJX1bf/ZqUOgPND467hq8D8oCN1IvG2WIvgk04CkEEoK9u+tBGxDzwBcuJ7v+ZgpC4g3CBSSd/92njyZQANqB/B8ToAWEOAAagqEakhB9zgx1SorDctI03qrB9yDdlBCqCU86wHKbfSwoqz5lXmB+kFzXNGcVE7vt0CSBoQPza1HnzeIBJzVJeBThTJwwuHwV/+sXvlPLawQHDwy8GbsHesMFi+C6A+CmEKaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScJb8wvAjCXl91Lp3HDfKNS0NTAQMNgZ+6D1JmQwReI=;
 b=KeVFkmjKxxCy+V4EdhcSyL54sCd3QUZ6dEIIvD+9JIr/o7ktVqTzYF8/2uCCAyGQuRNYvOX+JupFTNGOy9Nl+Jgdv6seEntnnZ8YtV6E+j2G+Msc4bp0rVPsG2jVcxRyWVMshuekD7eE4+Yal4HFuVXOldcMGvfbkGa5P6DBpV0=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by SJ0PR10MB4605.namprd10.prod.outlook.com (2603:10b6:a03:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 19:22:07 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::567b:a4ec:2f3:619f]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::567b:a4ec:2f3:619f%2]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 19:22:07 +0000
Date:   Wed, 19 Jul 2023 15:22:04 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     John Hsu =?utf-8?B?KOioseawuOe/sCk=?= <John.Hsu@mediatek.com>,
        Andrew Yang =?utf-8?B?KOaliuaZuuW8tyk=?= 
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
Message-ID: <20230719192204.klnhzsk5iuf2yxt5@revolver>
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
References: <9cb8c599b1d7f9c1c300d1a334d5eb70ec4d7357.camel@mediatek.com>
 <20230613141114.bwbnqsdazqbmyj3u@revolver>
 <3b14df2fc2a7f18fe12f87a27574b7d40f2899ba.camel@mediatek.com>
 <20230614155826.cxcpv33hs763gyrg@revolver>
 <ed7899c7328aabfbe9bc9589f0776a75e6c9d1ee.camel@mediatek.com>
 <20230706185436.agobbv72o3hma43z@revolver>
 <3507fdacf001c49f4c73f2952257beabfe9e1a53.camel@mediatek.com>
 <20230710142425.t5vhrqkjd7ugbmad@revolver>
 <f7aec937af73798c5e42b7e37adb744df5562cca.camel@mediatek.com>
 <20230719185135.nyun5fvcuv3ydku4@revolver>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230719185135.nyun5fvcuv3ydku4@revolver>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0273.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::21) To BL0PR10MB3011.namprd10.prod.outlook.com
 (2603:10b6:208:7e::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR10MB3011:EE_|SJ0PR10MB4605:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c3c1aea-6e43-4d64-a658-08db888d70fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nyMTNb24eHHgoxY2opWO+eUdjVXF1YeCkdlg+Ji1isyrB11hjLOJO2dtK8a2ZnTkACoQjykkaHvz9lEb8YutlRBoTqDm9QHH1c9BhZLS9i39HQI0QLi4/NB3eYpMC2XsNK18K9kgQdfX9Tt0GvWEXr9957NEAxOu4Hw24XQZd2iHS69TP79wHxjyycSRuyN9637Axda9ku4F+t6KhTNthy9x9FK1/bkh2QwhbodtGecEC+TCUxvafUsXY+iXmNRAcOEGKEKQbdlKp1DlJIzJRNfbGuiT1U4YcA1UJvq761Ji8VozRNKc5gSuZ769CVeVbOjcAl+xvjaTOTwrh2Cz90tZ27yP0b0lXJk3OC8kkQimrx09stjksZt+Aw6lyUNrqdhF1ooiC3uCstLGK47esVriX+4LdIZDp6aLnvJdAzwaW1BHZbVDroPcoekHLZg0Lw5vrX+9Jht/hEawwROkR0QiBDT85H63sODjSXPLlwT/0jZlsVlwFD+1IMM+ocKPd+fNxw2dV7+djbF5HEMNnXhqlfRRY9zTxFa4+rT/0XVl20cCef+CLAGTy5kPq4VXhNN8pviF2KvuUHn1eB7fsRrurdJ3KE7bfUs2XIMBODI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(83380400001)(2906002)(38100700002)(921005)(66556008)(66946007)(66476007)(316002)(41300700001)(33716001)(6506007)(186003)(26005)(1076003)(478600001)(6666004)(6486002)(9686003)(6512007)(110136005)(5660300002)(8676002)(8936002)(86362001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0s1Y3VPT1cvbTJuVjRmUVJGZU95UnB6WlNIYWVWZUl0SHJYeDFaZGJUM0tS?=
 =?utf-8?B?bkJSRlcrNFpucThrRXR6NHpBakNETkN6cmVuTERqVjdNY2xXNFZ6K05MQ2o2?=
 =?utf-8?B?aXk1THkrWVdZWW5MVlVGWnRlRnJXUVFlL09nNW5KeC9kQjRCRlVnbytCTXZJ?=
 =?utf-8?B?WE4yRS9BZjV3STI1Sm9tZzdMdWJCUC90Zk9sdmo0cXpDVnE1WFdxVXZPeEM4?=
 =?utf-8?B?c0hRZFFiWE52UFY0N2ZRckFTSngyNUpYc2VvaVRTRnlLMEd3NWVad0J0U2p4?=
 =?utf-8?B?WnZyanBjVWlMelJGNkV6T292NzRVdllhb0dPNXFJSDBUbjJXeHFQNThDd2Y0?=
 =?utf-8?B?QTlsb0FmY2xOa29yWnU5eFdsZG5nQm9QdGwzYnc1U1BqK2tMb3ZISldsczJP?=
 =?utf-8?B?dkdHMS8xeVpoa0FwTEplRUY0TG5vOThWN21JbWxkdlRFbDdQQkFqYWVnbk1S?=
 =?utf-8?B?YXVaYjVhSklpZTF5K3BXdGY4STZCbm1IeTdjbmdBbVB0eDBYNmhGTTBoZjJJ?=
 =?utf-8?B?NzFMd2doOGw0Q2NOcG1XN2tadFZjN2ZoYmxqdEtUVEhqcWUyYkNGL0hrMjda?=
 =?utf-8?B?clloMi9iQit6cDkvZWlML0pzS3RGZkkzZEtFUFNXcDl6Z1pBOEdWWDBjUUdy?=
 =?utf-8?B?bHJDbG9hd2NwVnFyV013TzFlY0JUT0sxV1ppNDc4NU51OStEUEpQNXpRSWl0?=
 =?utf-8?B?RlN3R0J1UFdPT1Z6dVEyVXd6NDhtS3ZvQ2JwbitmZFhjOUlvclFOcHpoYmRE?=
 =?utf-8?B?cmc1QkQ1Z1d1alNNU2ZOY054WVBZeWtRR0RaNVozbHgzYnYvdTVSOU5CVEo0?=
 =?utf-8?B?c1Q0THpkNllyQ0ZzNDZGRkhSUFE1N0taZ2dKaWZqdnZTMWRhV085SUFwNHNE?=
 =?utf-8?B?Y0lRdWVBb2xmU25QMU5kRWZtZ0hPbEpqK2FrOVpFZUovUk84ellNbVF0UFpk?=
 =?utf-8?B?ZTcvN0tUQk9RdEw5UkR3ZWlUbWgrZTRERnZjeVBSejdsK0dsQ1d0YURmVlZw?=
 =?utf-8?B?WVc1S1Zuazh0SUVhOFNQUjZ3eGNYSHJRRUhKQzRvTWlVeDBIUDlrOUFSRUlG?=
 =?utf-8?B?S1QwTXhMczFXVlJ2WmJPM0dMa0JTOVJxdUM0SktWQ1kzYjU0cXVxMDI4UjVo?=
 =?utf-8?B?VnVSVTF2ckFSbnlkVXhUVGJZT01jbDMvZ2l1OEJKOVdQc3ptdzgzM3EwSnBH?=
 =?utf-8?B?RHBNTmRqeFJVYzZ4NWQrTXYzWmowNFZRQ0Fpd1BKL0xMb0VyQ0h1bThNbUl3?=
 =?utf-8?B?amRLeHJVcGsrOHdwUVVtTHhTam5oejR0d2UzRDQybm9FYjFidmsvZ3hvemsz?=
 =?utf-8?B?OEhrRDQxSEV0Nm9HaXY0cnR2M0w5Q0VRWE9RRWZFTnRublptK1NKT29BYnVM?=
 =?utf-8?B?eUNuRFRGRkRZMU9PQ3ZremNjbzhFZTM0TC9sdXVEN0pRZ3VPbm9vcTY1UjFP?=
 =?utf-8?B?cEluVnFGNG4vS0RGWTM4VlpoOWJBZW9rcnVISTNYRHZSRlJuQlhhTUFYcEhr?=
 =?utf-8?B?MjlPQU5pMG4xY2xkMEJRNDNRaStDUURlUVltelowMWYrWGRpdGkzbDFhRnNn?=
 =?utf-8?B?N0dZd0Q5L1RGVVA1a29USVhjRDVtbDdaTXU0VjRQbitUK0JTc2g1bDMxQ1Er?=
 =?utf-8?B?am5CcEVOOG0xR29GZFFub2Z0V0I5MVdFaWVBSGM0WXpjaWxmZXNuTnhrbVNQ?=
 =?utf-8?B?OFUrc3RyNDVJaUU5ZTBIVXVQYUtnNGQ4QjNMZEFJTFdpdWlMU1NhSTZhZnlt?=
 =?utf-8?B?THIyYVFORlFKZ0hqS1dpYTRIUkxXQ05mSWdNWGRUZ1MwOXVsUDQ4Z0NkV1Nz?=
 =?utf-8?B?OGxRRWZxbEhnamZaRk9nQldGcXp5WUg4ZDdjV1dHTnlDcjdQckttdzhia0Z5?=
 =?utf-8?B?VHBVR0Zwd2RlUmdBOFgvdHUzWGMrTG50dEJqZjNOR3M5bG1ldEJETTNjTCtX?=
 =?utf-8?B?MldpdWlON2hKSHpDc2xMNWJ0UUoxUTA3SEpyWmRYcjExM0pOaVNBUEFIQVJl?=
 =?utf-8?B?NWZSYnRvZjRvVktXSC9mVUlPSnNzaVVGTm5zNEdUT2dzRkYwMmo4SFJ1WHk3?=
 =?utf-8?B?U0htOVdVTWNXQ0pkbk1EeFhudHEwVlpCaXZiblVOb2NrOE9jTVBzNEx1R0Jx?=
 =?utf-8?B?RmhMMGw2NytJNWlGd01HVjNNQmVmYzVNSWdpdmlQOTE0bnRDR2t1RCs3VlZj?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WlBqVDhoV2lYaVdJa1drdlcwbEdTMjh5NEJNanJMWGZrWHRmdlVQMVNObW91?=
 =?utf-8?B?TjhSdzdxc0tZQThoM1ZqYUVxZXlQbVVkTHIrblpac095bjYxd01TazZzeEQ0?=
 =?utf-8?B?K3Jiam5YSzk2RDhtMXBuWjNyUDEwSWhjN2pQVEF5cUpUcERaSmRXdUsvOG9p?=
 =?utf-8?B?Y3gyUDJGTlRNcS9aR1NqcGd2aU9oeGtEZXlEelAwUmRkbE9HZlp0ZWVnWFFI?=
 =?utf-8?B?T1NLWGdYcUZlRTJPUng0VklFanJ3Sm9IRjExMkpHZldKTWtlU0d2OHJtUElJ?=
 =?utf-8?B?eGNNTWVIcDE0L2xhZnNxTTRiazNDRkVkSjRZd0dLSGRQK09XN3hhZFlYRHA4?=
 =?utf-8?B?RGpFcUg1NnhTb0VkMWxqTzJSTVA3UkNVaVJrM3pyNlZHM0lxTXZOZCtzSkVi?=
 =?utf-8?B?bjZKVWt6a3JaenBKczRKUEdhQURKdnhPRHRJVnp6bUY5UUR4KzdPdUJoVlZp?=
 =?utf-8?B?STRlQjFnRVBKdk04NzdSTHhnb2JKcEVhL2lzbmlpMVJCUWk2cU93NnJEK3gy?=
 =?utf-8?B?d2JJMFlWbnd2ci95Q3h4YVRGNHB0Ui9xQ3czYWN5S1hkN0lBdVpSMnJZQ2Fw?=
 =?utf-8?B?c0gxU0tSNkk4YWs0K0tsbHMwUlJRcEpaRWlXSjNUWEZMWXpkQ2lxbEFlOVBR?=
 =?utf-8?B?ODRHc0NNT29TR2lqMnJKcXhicjR6TXhQRnhWc3l5STNrd0h6WG9oMmFYWE9s?=
 =?utf-8?B?MzFLb0EzZEo4aktua1hZNjQ3cXZHdEZRQTh4NytOdDlVdzN0cG5sOEZ5d2U3?=
 =?utf-8?B?N2VZajRXVzNDdzBiNHJBSXNhb1RqVGkzM0p4VXFPa0VCdWp1QkJydkR5Rnla?=
 =?utf-8?B?dG1TQmNhN2pvMGdTQjZCbnBYaUxJb3N2ZDJBTHZzYlBsU2JldnRmby9UTXpZ?=
 =?utf-8?B?c1kybUxMZzJWa2R2NXJSU01XendNSDJkeTdhaXhLSzBtaklyU285b28yRWpJ?=
 =?utf-8?B?a0hHK3BlWmVTUGdEYXd5VFFkTFNhVUJJRldEY0M5QlhQcmdrZTQvZXJkMHZG?=
 =?utf-8?B?Q3ZONGhzKzdmWTN4Y1FQQkl0WDdqRXIvdFhRcHBRRUIvdklaRE1VWnc2RGJr?=
 =?utf-8?B?V294Y2U5OTJCODN4bmVDTXcveEluV2tWN1JLUFd6ZjVjaStlN1p3WWgzYVFs?=
 =?utf-8?B?cTZPMm4rcXJaMW9jTzZISHhrY0VWOWRBNklaMFc2YThmT3JXUU1UdnIyL2Mw?=
 =?utf-8?B?ZGlkZnh3OGorcXo3Rk9MdzdBaVNncEJOTkt3cVNFMURzd0VXd0JRbWFZbkZC?=
 =?utf-8?B?WW1pKzhLd29DZnJ5ckxXR2tqcys5d2dSUFZxVXlTTmVCdUdOUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3c1aea-6e43-4d64-a658-08db888d70fe
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 19:22:07.2582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDl1h85Z7pYVSxPWVJoIva3KYRfH/6NlB2mtGjmYyw4x7nGcLcDqlW0lPLg/R5kLNeH0N5wdZFsS0o+lSaj6fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4605
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_14,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190175
X-Proofpoint-GUID: lhjO0Poh48ol-ttS-SINXW2uRcWNCM9F
X-Proofpoint-ORIG-GUID: lhjO0Poh48ol-ttS-SINXW2uRcWNCM9F
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [230719 14:51]:
> * John Hsu (=E8=A8=B1=E6=B0=B8=E7=BF=B0) <John.Hsu@mediatek.com> [230712 =
23:26]:
> > On Mon, 2023-07-10 at 10:24 -0400, Liam R. Howlett wrote:
>=20
> ...
>=20
> > > > > > > > As you mentioned, mas_preallocate() should allocate enough
> > > > > node,
> > > > > > > but there is such functions mas_node_count() in
> > > > > mas_store_prealloc().
> > > > > > > > In mas_node_count() checks whether the *mas* has enough
> > > nodes,
> > > > > and
> > > > > > > allocate memory for node if there was no enough nodes in mas.
> > > > > > >=20
> > > > > > > Right, we call mas_node_count() so that both code paths are
> > > used
> > > > > for
> > > > > > > preallocations and regular mas_store()/mas_store_gfp().  It
> > > > > shouldn't
> > > > > > > take a significant amount of time to verify there is enough
> > > > > nodes.
> > > > > >=20
> > > > > > Yap..., it didn't take a significant amount of time to verify
> > > > > whether
> > > > > > there is enough nodes. The problem is why the flow in
> > > > > mas_node_count
> > > > > > will alloc nodes if there was no enough nodes in mas?
> > > > >=20
> > > > > What I meant is that both methods use the same call path because
> > > > > there
> > > > > is not a reason to duplicate the path.  After mas_preallocate()
> > > has
> > > > > allocated the nodes needed, the call to check if there is enough
> > > > > nodes
> > > > > will be quick.
> > > >=20
> > > > So whether the purpose of mas_preallocate() is decreasing the lock
> > > > retention time?
> > >=20
> > > It could be, but in this case it's the locking order.  We have to
> > > pre-allocate and fail early if we are out of memory, because we
> > > _cannot_
> > > use GFP_KERNEL where we call mas_store_prealloc().  mas_preallocate()
> > > will use GFP_KERENL though.  We cannot use GFP_KERNEL during the
> > > store
> > > because reclaim may sleep and we cannot sleep holding the locks we
> > > need
> > > to hold at the time of the store operation in __vma_adjust().
> > >=20
> > Yap, if the type of lock is spinlock, the flow shouldn't sleep in the
> > critical sections. mmap_lock is implmented by rw_semaphore(mutex). Is
> > there any other lock in this section?
>=20
> Yes, the i_mmap_lock_write(), the anon_vma_lock_write(),
> flush_dcache_mmap_lock().
>=20
> > > >=20
> > > > > >=20
> > > > > > > > I think that if mas_preallocate() allocate enough node, why
> > > we
> > > > > > > check the node count and allocate nodes if there was no
> > > enough
> > > > > nodes
> > > > > > > in mas in mas_node_count()?
> > > > > > >=20
> > > > > > > We check for the above reason.
> > > > > > >=20
> > > > > >=20
> > > > > > OK..., this is one of the root cause of this BUG.
> > > > >=20
> > > > > The root cause is that there was not enough memory for a store
> > > > > operation.  Regardless of if we check the allocations in the
> > > > > mas_store_prealloc() path or not, this would fail.  If we remove
> > > the
> > > > > check for nodes within this path, then we would have to BUG_ON()
> > > when
> > > > > we
> > > > > run out of nodes to use or have a null pointer dereference BUG
> > > > > anyways.
> > > > >=20
> > > > Yap, the root cause is oom. The BUG_ON() for the situations that
> > > the
> > > > maple tree struct cannot be maintained because of the lack of
> > > memory is
> > > > necessary. But the the buddy system in linux kernel can reclaim
> > > memory
> > > > when the system is under the low memory status. If we use
> > > GFP_KERNEL
> > > > after trying GFP_NOWAIT to allocate node, maybe we can get enough
> > > > memory when the second try with GFP_KERNEL.=20
> > >=20
> > > Right, but the GFP_KERNEL cannot be used when holding certain locks
> > > because it may sleep.
> > >=20
> > > > > >=20
> > > > > > > >=20
> > > > > > > > We have seen that there may be some maple_tree operations
> > > in
> > > > > > > merge_vma...
> > > > > > >=20
> > > > > > > If merge_vma() does anything, then there was an operation to
> > > the
> > > > > > > maple
> > > > > > > tree.
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > Moreover, would maple_tree provides an API for assigning
> > > user's
> > > > > gfp
> > > > > > > flag for allocating node?
> > > > > > >=20
> > > > > > > mas_preallocate() and mas_store_gfp() has gfp flags as an
> > > > > > > argument.  In
> > > > > > > your call stack, it will be called in __vma_adjust() as such:
> > > > > > >=20
> > > > > > > if (mas_preallocate(&mas, vma, GFP_KERNEL))
> > > > > > > return -ENOMEM;
> > > > > > >=20
> > > > > > > line 715 in v6.1.25
> > > > > > >=20
> > > > > > > > In rb_tree, we allocate vma_area_struct (rb_node is in this
> > > > > > > struct.) with GFP_KERNEL, and maple_tree allocate node with
> > > > > > > GFP_NOWAIT and __GFP_NOWARN.
> > > > > > >=20
> > > > > > > We use GFP_KERNEL as I explained above for the VMA tree.
> > > > > >=20
> > > > > > Got it! But the mas_node_count() always use GFP_NOWAIT and
> > > > > __GFP_NOWARN
> > > > > > in inserting tree flow. Do you consider the performance of
> > > > > maintaining
> > > > > > the structure of maple_tree?
> > > > >=20
> > > > > Sorry, I don't understand what you mean by 'consider the
> > > performance
> > > > > of
> > > > > maintaining the structure of maple_tree'.
> > > > >=20
> > > > As I mentioned above, GFP_NOWAIT will not allow buddy system for
> > > > reclaiming memory, so "Do you consider the performance of
> > > maintaining
> > > > the structure of maple_tree" means that: whether the
> > > mas_node_count()
> > > > path is not allowed to reclaim or compact memory for the
> > > performance.
> > >=20
> > > Ah, no.  This is not for performance.  It was initially on the road
> > > map
> > > for performance, but it was needed for the complicated locking in the
> > > MM
> > > code.
> > >=20
> > > rb tree embedded the nodes in the VMA which is allocated outside this
> > > critical section and so it could use GFP_KERNEL.
> > >=20
> > As I know, following is rb_tree flow in 5.15.186:
> >=20
> > ...
> > mmap_write_lock_killable(mm)
> > ...
> > do_mmap()
> > ...
> > mmap_region()
> > ...
> > vm_area_alloc(mm)
> > ...
> > mmap_write_unlock(mm)
> >=20
> > vm_area_alloc is in the mmap_lock hoding period.
> > It seems that the flow would sleep here in rb_tree flow.
> > If I miss anything, please tell me, thanks!
>=20
> Before the mmap_write_unlock(mm) in the above sequence,  the
> i_mmap_lock_write(), anon_vma_lock_write(), and/or the
> flush_dcache_mmap_lock() may be taken.  Check __vma_adjust().
>=20
> The insertion into the tree needs to hold some subset of these locks.
> The rb-tree insert did not allocate within these locks, but the maple
> tree would need to allocate within these locks to insert into the tree.
> This is why the preallocation exists and why it is necessary.
>=20
> >=20
> >=20
> > > > > >=20
> > > > > > > It also will drop the lock and retry with GFP_KERNEL on
> > > failure
> > > > > > > when not using the external lock.  The mmap_lock is
> > > configured as
> > > > > an
> > > > > > > external lock.
> > > > > > >=20
> > > > > > > > Allocation will not wait for reclaiming and compacting when
> > > > > there
> > > > > > > is no enough available memory.
> > > > > > > > Is there any concern for this design?
> > > > > > >=20
> > > > > > > This has been addressed above, but let me know if I missed
> > > > > anything
> > > > > > > here.
> > > > > > >=20
> > > > > >=20
> > > > > > I think that the mas_node_count() has higher rate of triggering
> > > > > > BUG_ON() when allocating nodes with GFP_NOWAIT and
> > > __GFP_NOWARN. If
> > > > > > mas_node_count() use GFP_KERNEL as mas_preallocate() in the
> > > mmap.c,
> > > > > the
> > > > > > allocation fail rate may be lower than use GFP_NOWAIT.
> > > > >=20
> > > > > Which BUG_ON() are you referring to?
> > > > >=20
> > > > > If I was to separate the code path for mas_store_prealloc() and
> > > > > mas_store_gfp(), then a BUG_ON() would still need to exist and
> > > still
> > > > > would have been triggered..  We are in a place in the code where
> > > we
> > > > > should never sleep and we don't have enough memory allocated to
> > > do
> > > > > what
> > > > > was necessary.
> > > > >=20
> > > > Yap. There is no reason to seprate mas_store_prealloc() and
> > > > mas_store_gfp. Is it possible to retry to allocate mas_node with
> > > > GFP_KERNEL (wait for system reclaim and compact) instead of
> > > triggering
> > > > BUG_ON once the GFP_NOWAIT allocation failed?
> > >=20
> > > Unfortunately not, no.  In some cases it may actually work out that
> > > the
> > > VMA may not need the locks in question, but it cannot be generalized
> > > for
> > > __vma_adjust().  Where I am able, I use the mas_store_gfp() calls so
> > > we
> > > can let reclaim and compact run, but it's not possible here.
> > >=20
> > We have used GFP_KERNEL as alloc flag in mas_node_count flow about 2
> > months. The mentioned problem we mentioned in the first mail didn't
> > reproduce under high stress stability test.
> >=20
> > I have seen the patch provided by you. I will verify this patch in our
> > stability test. But there is a problem, if maple_tree behavior is
> > unexpected (e.g. redundant write bug this time). We can only review the
> > whole mm flow to find out the wrong behavior. Do we have an efficient
> > debug method for maple tree?
>=20
> There is a test suite for the maple tree found in
> tools/testing/radix-tree, but it does not test the mm code and
> integration.
>=20
> There are other mm tests, but they will not test the OOM scenario you
> hit - to the best of my knowledge.
>=20
> There are also config options to debug the tree operations, but they do
> not detect the redundant write issues.  Perhaps I can look at adding
> support for detecting redundant writes,  but that will not be backported
> to a stable kernel.

I just wanted to clarify what I said here:

I'm looking at adding this detection within CONFIG_DEBUG_MAPLE_TREE.
This is how I narrowed down the issue in this particular case, but it's
far from production quality.  Even if or when it is production quality,
it won't be sent for inclusion into the stable kernel release.

Thanks,
Liam

