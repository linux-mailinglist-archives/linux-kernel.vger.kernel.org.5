Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665807E4C7B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344251AbjKGXKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbjKGXJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:09:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7278E1731
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:09:51 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LK6Lr026463;
        Tue, 7 Nov 2023 23:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=wuuI4Zq//eIf7z3jbSZj4GH7eL+Dj3jet/RMEv0kkmY=;
 b=EJDYxZ4UcH0lIjt++qvAuJmJDhqKmpCiiNyfbFkz8AF9KIpdYjVS1JpdC/eQZK4ybVM+
 TNAj6qQnNohnXckdRRrPviT4ehT3BntQun50dsJjsQ2UkYlp+QYRxc3X8vi+dP12nfeM
 4mJlgr05dLBVJu6wuQbBfH/o4E3uNlnc4Eo8PjvI9/kj5TWHkWQRseM6QMXAJI0pfOIi
 uistbvHTQbg586YYyY4Y4l2pO8Qs5LIHxftNkC0J/Bhuu1V64nXDttX7RZJ9Mb+3TX49
 OboxEYIb+90QuUtNidIsgdbF61F9pFUxcTSPuTEsXORyJzLBIn1sgi42o8db0NKbdrIR 9w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2106v6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:08:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N4iXv031877;
        Tue, 7 Nov 2023 23:08:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w2247up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:08:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0TcSGxd1NL42cDaYyIEeSBruW/zqSyB7bHOipTJhwMOju+ju0bALgnlVyfS8Tu4T8Y7K9vDdF6xmdof+N6nWWo1rjJLTnHjogjj7wcRGXojdrJd1p0ILuO1M6LWlle2qOzVPGNyG1T4GZUcnjIhp9tRtzhkh9mlSGjfOYk63U7nEmmbWK7k0NqnB4Ac2cJDqDyQ5G8cASXJ7HEllEgFWCRByrLy6MtnO44M3uymWK3O3JEpOLo4Z55pa11eegymjfdIvdXAQoDbmN3TFk7eiaYpBQeYPMlth0cn6Y6JXOAgG7aFOQM3LwSIhh9o4lR3B9aNbIQSG2c7cjrFLPSpUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuuI4Zq//eIf7z3jbSZj4GH7eL+Dj3jet/RMEv0kkmY=;
 b=QVhym4XZcf9a2trUtpbchXoRSrvp5ymdIUDkHn3lNiS/No+zs5wsBkyOuSJHBTljYKAq0ryjKWbf46BVsskCkaeJk/QED5p900vavJjQZXSPUt8GGN4KytCWMGR6UxgMLyKKvek2Aw/jp5YPuPRal2yv7Rt0vxPj6DEgAy0xmeU2bpjUiJuxg4G3dR93oiFQ+1tPTbtmbEc5zswI5nyrzHcHCc9OFb9ih7XSpOxPbmfiWX+NnrL8cQJeImuMFqsdLji2DaIQQBHCxfc1uGVLWGM2QqlN0FRd0tfitUu7k+YAF4rnCace6/VkEHSTugIKJmWUksWVBdCWGYlIl5T46A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuuI4Zq//eIf7z3jbSZj4GH7eL+Dj3jet/RMEv0kkmY=;
 b=CeuPZ4lGiiiywLjCnPoYJhPv3a5ge6OlLM7UBkVkdXOGg66jO4GrmfW2K/SBGt9H0vbhpb0LY/gGGukeEgr1ewlh39cobNnq/Dpu8APGOBYuJIetLpV/xfPeewE+wujuCbZ5IX7ckhRN0EP32stMs9LjWngscn0SK2nsVwg8Qvc=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 MW4PR10MB5704.namprd10.prod.outlook.com (2603:10b6:303:18e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.27; Tue, 7 Nov 2023 23:08:50 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:08:50 +0000
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
        Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: [RFC PATCH 65/86] treewide: task_work: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:08:01 -0800
Message-Id: <20231107230822.371443-9-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::32) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|MW4PR10MB5704:EE_
X-MS-Office365-Filtering-Correlation-Id: 98fee117-b9a6-405b-928b-08dbdfe68106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Q6Jb5LmgQBqesVOjSO1xVhkjAeYVzdc6fR82V705cE2PWXjGvKbibu9jAOT743i0+WpqpU4pLvxdV+ftQg8YoQH1pmOxbpKDqeLS4uq/sJd/sqPpbpTPrL0iLdFcBbn79n+5kB5fJdpyZ/yyEtTOIHFI24k5C4EkKZmwwRl0g91nbKXx10DjNoJOJSjUD3degSgmMhOzng3wiwkkHZ/2mICfqqArdx3YhFfn3uVIOkQCjccTvdvV8SdxCdXzPKFQfBN+kZzz9IPXhpKZzjaG0UK0wLO5on3qobSt2BLz4YVTGmJATM3UrDUk+tBi+5nkqkuzitOMvpFGislE4AuBwCA8lqXNQlBHpvMqC19oGxZ1mJfmDQIfHTUx0oBBmo7KFiylIiT32EtqxJXY2fZ5kaNZJyOG+mVSZCXEuseMfceLJYPFEBGOqbul2S/LvJEzuqd7WRLWGuJ8lhFeo0LV300hGqwvSf1nbg58xuAbdsgR07XikdPs/r3BK9By0PaY1Vz2l23YPK/lyRYBNnR1btofJGjir4QX57o8Y1oxmjPlYh3rHGmYzccKpILnTvP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(41300700001)(6506007)(2616005)(6486002)(6512007)(7416002)(6666004)(7406005)(8676002)(316002)(4326008)(8936002)(5660300002)(83380400001)(1076003)(26005)(66476007)(54906003)(66946007)(66556008)(6916009)(38100700002)(2906002)(86362001)(103116003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WDpum2pjR4GeWBzz7aey7jpEv1k6PyCA0Loo7FBglu0nzBU/D1txU+CrZCZm?=
 =?us-ascii?Q?kab/R2AHrYuG0Shc3bCPFcIo4dUSsu3tSJF92o7PmLKX4ctd1uVEAYlQDqCX?=
 =?us-ascii?Q?20ML0UXH/n8BeLgoH31naTfxlNQXywrt9La6bybqDK/dmuKYOg/1ufM00XDT?=
 =?us-ascii?Q?vflJEEcGz4Sahi9KdbrU5CqXTajGK7sX6aQh5l2uggbVsHrJva5OwNlTFcfx?=
 =?us-ascii?Q?b28T4U0vYJjJbIPl2/oyd8l+G7kr4QQYiTfZZbYaDoi8OKw54dsH+pe/KFuz?=
 =?us-ascii?Q?G7aJFZYnfN/ZTs0jirAxksvq0YIi9ikKoqhPdVYsojMSiJDdrFW1JMwkc566?=
 =?us-ascii?Q?vlJ+g6vnfOUDdK1/WFWLU3vmywmwsmgvLJrvT2pgLEaOEbS1JRtX4yWpya1B?=
 =?us-ascii?Q?zP5ASA40h7Ns9iG24rWabnrGORZONvpwCJE3FdNC+/6gxQrMfuldPZCaFRXG?=
 =?us-ascii?Q?94r4sAkR+GzvvMznJ4t/8nu9UI2fh7mkDT5FgBOIMzzUuUPKwaaOvVlb3zVW?=
 =?us-ascii?Q?UhVekr0AiwEQXMVkXoIEmXCG8ipdVBe9MEc+jS0KhQZkALHK5QxE7Y9lZKUm?=
 =?us-ascii?Q?OHZ5mZTImjvebKFq+sUcqwX109bP+FP/8xHwk12fx2njTCsUNQZiEpb4tISX?=
 =?us-ascii?Q?hXHo1UagN1C79c2vRB7G+P+Rc6ue7llkVKusoNlamf3uGPq0wBWH6998EEdJ?=
 =?us-ascii?Q?K7QYrWVrVtLi190i4vYEOG8+7b+WijhLXq/slvqfQWZIcWeK5zZgbDA1q4BZ?=
 =?us-ascii?Q?bctM4sup+36W8tydJo8y1v2W+WIU/gTbOA7fwXppE803ndELlo24wPguvtYp?=
 =?us-ascii?Q?UVS5kaQG2J/2edpmMjnvHNGOKYt7surNE57Kx9QA7b+GATlr1uMsfo3RvFDR?=
 =?us-ascii?Q?nqyYqy/wSWcH1SeEe3rlAGFwEl8TuMStexITmeXpA3B91kSBShu4Oh2rXliC?=
 =?us-ascii?Q?ZJBK3YkmQRg4+yO7RAaVSi5BXo05nnfKVjm5kOXUpXO6jV7+Dh3xx2A8ixAe?=
 =?us-ascii?Q?QmIA9hznFH1q3T0BKbmmtg3wxBm9Ps7D1QjWzSFKrUK87rWpCDCfKY2kdS1I?=
 =?us-ascii?Q?UkUX70yCaOy/3+iRdgLcMkV0jzLs1bBODmKh67PY2X0T5P7Fz/thjJgZpy1M?=
 =?us-ascii?Q?BpOx8Ix+p+pZ/HCZmVtX0wknTO+wfAkJptRNwATp/r/Du8yKofhoDsUhjLjb?=
 =?us-ascii?Q?00jtuFwqN7xeCj7Crx5h/jLA+VtOyG+R9BvP/BtgD8kFAMrS4dlhlGxtnA/G?=
 =?us-ascii?Q?M1P99RjVIT+VpGkcK4S85hwYiCMVTTfX06KU8Ax9ZAbi0VZE5pvNgHVSa06J?=
 =?us-ascii?Q?Has21ZkAgC9XwuFI+Y4nbojB9qMNX/ZwX6AEAAYrEfXcC3f3qdNHc3gjYyl+?=
 =?us-ascii?Q?Sjo53IWlcS+O1p1P96LlZGyMxEvo/bJqJe+RQmodbJY/7uqLtHcWFRd+omQ9?=
 =?us-ascii?Q?6MIry8uxoJRvE40P90mZ+IZzeCD316a22CDcTulnfqQHwowLt8zzDCW8YwRC?=
 =?us-ascii?Q?myUxYy/CR6tnoR79/unad0sdhpKfN4O0IV7bGmPy/mLQE80N4Bem2ijuMEno?=
 =?us-ascii?Q?+TjNeeQhN+I7El2l7X7B3rshPOTwlKR0rr9xxmkQtxiVOSmNfjhw9e1LBiDT?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vMciqJy/ZRJmyC2d/to6j48/tGrqukDRgI4Po9bhcDBqBzP5qjAJ0D9LiNhj?=
 =?us-ascii?Q?8t1+n4uCAx/sEGKDpNlN+Nx4ywD3eR6vuOco4AoQ+g9YPbfU53Tdf5CBpQA4?=
 =?us-ascii?Q?7Qq16ZJUICYZCsU3LS4gVmGK2RJ9r1r7AvW1eI5i2L106t8gXs9uVnzFKCb7?=
 =?us-ascii?Q?/wXlBfF3FQ1Epk7p3weNgE+5OBBbZwaOSlrruXYaVJ9NKKsoQw0VIubtadB7?=
 =?us-ascii?Q?2ZNMB28EVKxM2pYYvUiB6coRTS5ZAx3rsSqEyGLxXpIPISs6mjc+Ynsuulgx?=
 =?us-ascii?Q?havgx4cqNaJBAF1LzuskV8CnSndaCJ9E54EnWcgOZgFn7Qvvn0GW3TMHijcf?=
 =?us-ascii?Q?OiFIwrKGgBgdMvZ4dhJdWgNmH6cWdWgaewbHZoxSFjVaZvWv9blHsCSVBwqh?=
 =?us-ascii?Q?0V08poMVeSxTCLAP/92ghop/c9ACKwoBO0Mtx+29+95fGMoRSx/86RQm+1Bq?=
 =?us-ascii?Q?0Eha/Tv8AXK5ahtAokmabBgIZU2N6TqBo1NCjPGY0W1WLUC2dsvmU5YexAKm?=
 =?us-ascii?Q?sxaTtD+x8/dPO5dmywtnM0pV+QIGVwga866WOJUP3bQvVM9bzImjvoBiSPQt?=
 =?us-ascii?Q?LriTxDSGZJN2cNheSkBIfv63/dE9M3ZtrtGXl8l7KhhzwnIEBZ+kQXTW2duE?=
 =?us-ascii?Q?qJQbzKL6RvLEulvx4P2HtzyL9P/B9OIrx3KQdSAIBqOju/c8QVeokdC++l2J?=
 =?us-ascii?Q?mjmMb8F6BEuBkGpTJwtGH7hQUbh94l29OwWAyrPYW0an2JmraHVCQ4sAlqV9?=
 =?us-ascii?Q?BmtxXob+98KpEli+kvCm0Wg1pNI/FFwOicT2+1MlwizKc0dZgahlBcWLhSOA?=
 =?us-ascii?Q?b55OHg2FuqBS7bIpy64EHyOXKamLdaWjAv3s4dv+k9FSM9vSmH037Pq7//O5?=
 =?us-ascii?Q?Asca/4jV8XXXs9dzh7uHBYsrF9hrisP85HznHOhto0N/rxs30FvkKU8SN5mt?=
 =?us-ascii?Q?/YcOkIFjdpEYtXuu48FpDEB1UiTEwy1FaRSaly4GfKJZhekmQoEbkWXIxa99?=
 =?us-ascii?Q?JT3Z1Qcex3Rwrae4rvDzyufSKNAOrroycyzULHjIgyb9fNfJOaRVlANKHdCh?=
 =?us-ascii?Q?wGUrtkFet2ESZpjmoAnMUj1KkEQPpAdhRMiLQ6mXcCsGulYtc+TuB0g1UtfD?=
 =?us-ascii?Q?IRN5AF2snQvPSGYRKy4z2UROH5xTUuF7vvA//Vs4CoLLTOYoimxddzWLOiQD?=
 =?us-ascii?Q?FNqLqnuQIl3+yws9Q56rYPenjCZShuJb8xMEUY5ZXetmNvraYgR9q0JMQ3JV?=
 =?us-ascii?Q?fEenDNCs2tsA3EQO7kcxz7ukP7BhZISB+bqOcRi8pOWTBowJpVePHYHg/PyT?=
 =?us-ascii?Q?AOiYzZRID5LuAmhgfZzkyKyKlEC2a9LKUcnPuqUxb0rErm3DiMeoPH9+Mrtp?=
 =?us-ascii?Q?Orj3xRD9fL9Lg07kcP92w/x24M8CFaWdtwJXDVcO7r1uYf96xxK9UDeA2/3q?=
 =?us-ascii?Q?iTIa8x7t2aVnJzuBYjOdtRLG9Fpb+GUomZ14XRxrLGz8sn2FZb+Vr6ImNATv?=
 =?us-ascii?Q?2idiY2N9z8G4XgA/u4wFN7Gs1kV4PyYQiVejpHhnIH+EH2Y0+9ONN5R4JqzL?=
 =?us-ascii?Q?+M896YoOKb5ZbA4/DaU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fee117-b9a6-405b-928b-08dbdfe68106
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:08:50.4405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSgzrWUuZTRU3SiLAZFusncELudPg+LGpI6sQmCCY1FrhybJqkDLKGNxADeEH2IXZ5v4SvJjZcz9/FlQP7Ul4rLn7688uWPteI04/BjqtVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5704
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 mlxlogscore=892 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070189
X-Proofpoint-GUID: yoeV5auVAsON1BbVo38xeuAP2wWnzGxf
X-Proofpoint-ORIG-GUID: yoeV5auVAsON1BbVo38xeuAP2wWnzGxf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cond_resched() call was added in commit f341861fb0b7 ("task_work:
add a scheduling point in task_work_run()") because of softlockups
when processes with a large number of open sockets would exit.

Given the always-on PREEMPTION, we should be able to remove it
without much concern. However, task_work_run() does get called
from some "interesting" places: one of them being the
exit_to_user_loop() itself.

That means that if TIF_NEED_RESCHED (or TIF_NEED_RESCHED_LAZY) were
to be set once we were in a potentially long running task_work_run()
all, then we would ignore the need-resched flags and there would
be no call to schedule().

However, in that case, the next timer tick should cause rescheduling
in irqentry_exit_cond_resched(), since then the TIF_NEED_RESCHED flag
(even if the original flag were TIF_NEED_RESCHED_LAZY the tick would
upgrade that.)

Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/task_work.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/task_work.c b/kernel/task_work.c
index 95a7e1b7f1da..6a891465c8e1 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -179,7 +179,6 @@ void task_work_run(void)
 			next = work->next;
 			work->func(work);
 			work = next;
-			cond_resched();
 		} while (work);
 	}
 }
-- 
2.31.1

