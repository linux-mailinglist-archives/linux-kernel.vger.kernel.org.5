Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034BD7E4B93
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjKGWP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbjKGWD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:03:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D021719
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:00:45 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJlqW020689;
        Tue, 7 Nov 2023 22:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=TL9Y5NXwSCMqi0BI//p47SGdWVHhaQ0lKLdpboL8OGw=;
 b=mNUEa5TAVzY0bj5EOAiWB249Dou783hnE+xe6Zxz3PG7UShwgi6WN3y7l7X6yIsY27nn
 rk8hqkHNINip4Pgtphez8y6Ttt3F9Dmrt94fnejtYrQhNYx0d3bclcSAtdpY+yONfflT
 S2DX/A9KDIHcr93SvSXVwkSWl4yDE9x3DRAsepMPGthZBlwPWED9O3IyeKyuDwHNo66t
 eeqYndZiezWoLzLWjFKB66KBobKF67a/MUvwz0qvtWZfoFuU4d2V7QLj5W+6vblmxIlX
 oT3HDL0LuPKj4wxCSYvHk86FbiUb4KwmQjlWXwyArwsbM1GWC/iFwSezbx3q/ihqPx1s zA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2202te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJPCQ023844;
        Tue, 7 Nov 2023 22:00:06 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w241h5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXMfU0ZagE4G9WOkLHFJmd1zK02ubqIRrkwwNdC0RvftyMHQ8RMTwZjSbyGYvA8hpV0Ur/efuqWhJZUWWwzPzh/muwP4CyJcHnz12UY2uXfaT6VBpjQ78TWwKAq/bMG0MPssEJII2kGU3SWtlw/lVsaOXzdg+dcxbK0VWf5sqhHxlCiQyph/8Q+/gUyHw+oU9XxIpq35wWy02TXfRZ0uG9vTDzH7IAgFS3hbzwvUghX5XDbX+ShwfW9fQGEmJjY/8gUvuz84Q05BAvWIvG9MfdEzr5iDnpPzr9ks5gQTwHfOVMYjDT5hTMG5Lf0EYCAx2wLO81kCoNrfs/D51a8JNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TL9Y5NXwSCMqi0BI//p47SGdWVHhaQ0lKLdpboL8OGw=;
 b=Taf4cwtO5jIImO5NsIpIY7RRnVc2Y6bYhHyT+BpEOGeEfrBT4mN6BKnsm4/xqCDC994oAQuJ/Meo7DWNx5+rc68K0y9Diud49yMaZIXXoL0wqAO11nQjiT7Sc3Px9TQAsGJwEbHKUZxpBgD64vy4JD5VrsD/9g5M11rnxfhYNI46G9lQVqK9QCx2C09s7hIHi05h0XDk8eQonXtxZbmaXCfNZyxtzOP8IjQBqDOQwEAf1RefPYYzFjMG/+g149R6Rk7LpqHuL/HnqbIvh7c+5YHsfk46q22a2VpUoEzWkzd4Acie357p28i9SzUo3+Eog6TVt2okWf8DivGgTrWYIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TL9Y5NXwSCMqi0BI//p47SGdWVHhaQ0lKLdpboL8OGw=;
 b=VSjkTLWl5qdacBTDVSYXqqNWOAucE9qtYtdrsgkdYR0hRoFAytrZeTZF2jqjuVyiOShE8QAVGiSWFD73DVR6oftcB+utM8pyja/2FpRhG2uKVlnIWrsyXSWCU7Dw6kCcFAOZWoV4O/paCBeeFHroxuF7aprvIBQ5QOEtWGf0Jj0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6275.namprd10.prod.outlook.com (2603:10b6:510:211::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 22:00:03 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 22:00:03 +0000
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
Subject: [RFC PATCH 46/86] tracing: handle lazy resched
Date:   Tue,  7 Nov 2023 13:57:32 -0800
Message-Id: <20231107215742.363031-47-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0166.namprd04.prod.outlook.com
 (2603:10b6:303:85::21) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ed8a25-892e-4e5b-4775-08dbdfdce553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+qTY7CEvksFhXIfZLZky7YuaZ6TziQ5lT0AFZpQJS/XzVkvuONKNfX6IYJS6jXqRkzSLVIeeP2ZZmHZaLwEs3fEXJKYlCCwQcWdk7VPzmUPzM9Im9CK47+aCIgb4RSMl7pchzflK/I/OzXXfhWFgVjSVpmii2CgS7c3DM45GmMmyHgBC0BI2BOEVrnVr8wOyJdJynQbnxXD7iDaSQJmxPTlq92AszaucFqfOm6dx91iXpAb+JHTGFx1r3j5o79U7sty9UtDJ1xWTpMNEdLHsoCDaoCObcjvYI9uTvH4E0O4veIQBDDTT6xVvxGxe80EIZgXrVLt0lp5bU40qJ2V7CQgBzijGcMHyM71AHvm+ZwuLfA/4xLNZHxC4/DkFz0YSKo5XdZOcOY2gO2re86lHWht1qks+aoJh5HiOvwYQNKG1cDheTVabH+sY/AGueFEBLXCjHO8nHDLUZ2rWyTQrEEVObxOz2wMd6ciyt/CL9YdGvoVumCdDWiyXk/I2DXApTUE9QcQgOORJMMVPRZjxDHf9udwIeTZ84K4a5ZLLO2r6n8MP+wFXo7NhI3RG7Mp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66476007)(6666004)(38100700002)(6916009)(6506007)(316002)(66556008)(36756003)(5660300002)(7416002)(7406005)(41300700001)(66946007)(6512007)(103116003)(1076003)(8936002)(8676002)(4326008)(26005)(6486002)(107886003)(2616005)(2906002)(83380400001)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uT9LT8XwLzIIDFJsATxV1SF1/urYoJVmWGzaAs5FTmjD/Zz2gOXTAcyFI5oB?=
 =?us-ascii?Q?AWnRs7zAMcShiMmGIiJyyOb12VpQkyWIcmavGkJrx4wH6Gl29wUXaexFeH+8?=
 =?us-ascii?Q?0G5fXbDBxIrIUSODQ9WlS1cCXCVcCqnSxttPHmRMUh4Li/DZ4BIx49rc4JdI?=
 =?us-ascii?Q?AbD6PSclX6cQBNHlYHpEytCkHuqxR4P8lpSvQ48Qvz2oq5Luc98BuzZd55OT?=
 =?us-ascii?Q?R6FedCyi4zqlUDGHXwFm0eMCJlCWvESFR0+/ra/vznpeQs/1MupO5ic0v08n?=
 =?us-ascii?Q?7w27EEAL2HpftVq+P4asPLhVm52t2dd/XwHHONdE1GHq0dbLo2CaASrXfe2C?=
 =?us-ascii?Q?tk4zMszKBNr9Yld70cpMEgNvq1k0qrGhYk3u324OGCHkXrh8SFfyZgOuM70G?=
 =?us-ascii?Q?6KtVbU2c7TDFR++qJ9YMhzNI0puoPLBmbb9WfVKvFy7JePI7mijIX0lmGm7e?=
 =?us-ascii?Q?5d1eewBa4E47K5rvWQradepHcDAOkvjCANYeus1kLX5pxQbKESBLaRlzM/69?=
 =?us-ascii?Q?xNI7NqKi7nn6AGonCde5NajcvsnII+ZnPiTslOpWV2oMfP5mzC0s/1cODpGr?=
 =?us-ascii?Q?xrE6sBNXLpRNNp0ThKevORptCT9P058uAEW6RQxQAjU4cWpQUHop1Be3xX8R?=
 =?us-ascii?Q?oF0ZAKzyVFELjdg0T6KfMrjyxG2wgFJ+v4qyEVUGh8jjrTgcExOVfXPzEAUP?=
 =?us-ascii?Q?mt7uQMrcWdeA5GGEDmqciYJ0ZCEAvCcqyFzxPI8sooWKGjlUGRE1j5cDsFGW?=
 =?us-ascii?Q?nocdhFp4s8ov9kUMKnbLKXGIib70Xl7D8jcUD4jU2yB6JP4AzXaZe2aplnAA?=
 =?us-ascii?Q?imz2N9VRzUvDGXaj6oWAgYUEgM3/g4xZ+TzSV3PuVs72AdE2Y5dNnpWcwEoC?=
 =?us-ascii?Q?QxpCswrzaPb8XHu2Zsq+pdYYaj6BNtdeybmFpZZ8BXyQ+iqDeOWa9FKSZoZN?=
 =?us-ascii?Q?RH7VBQbhVM9jTlBvbzR5Sk3QVPATP31pbAqgV/q+gaUZheegzcj0k8akVE1V?=
 =?us-ascii?Q?WcSs3qw2UZ09iS/pQUQaXSrjphDFkYGmRODZrncHCmZpAY6WN6/IPxDOeZQm?=
 =?us-ascii?Q?iqLC2L9s9pqDBQkyYq4UM1AwoapZMoojil++/m4WMQKlET3rwWOFHe18zM3V?=
 =?us-ascii?Q?T4ehiUVbPcvBoLwUTtlOOLoH9O0DvI+eF/9IJOAd3H8hxNJkFvXeSJI5+t59?=
 =?us-ascii?Q?cLEW6gmBwXOMGZpiWCUw8kJ/tuBt3cDSua1X2L0KdKau2d/kANSBkAQH1rxa?=
 =?us-ascii?Q?wiXgu0rB0pyGMUbJgr0990wmWqNPr7kE5iWkrX3Y/Woc0iht27NoZHavRuLT?=
 =?us-ascii?Q?lYwU8Utfqkl+Dw8bG49f9bxE89yCe9aV7qw797H31/8xwviKLa3GsllE2+zU?=
 =?us-ascii?Q?xquI2y8XMyLZ68HL++wwYqMkPIukCiyuAnUugosNEOPD+wx2+cYTerpH+/5P?=
 =?us-ascii?Q?Lv4at9bQsJ7Rw2jnNmpteIM0TPcyTy3eu2q5YxLwtmMQnXRFcOwjNQaDQ1cl?=
 =?us-ascii?Q?CeLJxoPusm1jMk1ug8ZQbUNxU22YK53RaJGqjGJj8mDlldvX3n9vhMvU0+2j?=
 =?us-ascii?Q?/OXBPT0eRBVbyZiOAaAmvXH1FwETNQ+/QV28SuCDgh6nSOU5JFxFG1TErrvZ?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JzyWbvwGIhHPtAfMHtIwj9bFpmhp50qBCad1svkRfpz4Ksx5VQ+ValjoJzDb?=
 =?us-ascii?Q?qeso/cbW+OU0SfXO+rI5TTBBkROPOc8PrC/0NoCw9JXG2h6hyrnzvPO4if8o?=
 =?us-ascii?Q?Y+af6UDt71sR8yYRIc4u17OMVHeUs0h+y4U6J6qwoxYT2oIp8aIv6xBhW1XW?=
 =?us-ascii?Q?bn2b0u3ERcFelrZyB/duBLS3U1y+VDzkiFEZqQJ2N/aHDX82ZBlGLEKGNgBO?=
 =?us-ascii?Q?G6bZfzQfQqh3BYSx55WtGvJvCz6VvDD30n9J4m/7YkkvnL3FLASNalahRivX?=
 =?us-ascii?Q?KzeyvtmoIKfRa45tvqmnB3dAQYNayf9mYXrKzXkLIxPysajNTXejCjAzG+cE?=
 =?us-ascii?Q?kRfKvwrJSSPAvR/sh9GY5GtdSc63Va6WdMJia4dxZwNSggkTv3QC/eWy+4M1?=
 =?us-ascii?Q?ymD8DQBACW9XrVUvVmoSR89j5O2FRZ6n38drjhpXcp2XlwPzswODGWRqNZbJ?=
 =?us-ascii?Q?9enRsbSoUMv7W+Br2RdGd28JxL+rFixhcoAqoKaSpJ6KdcmPaQvpzhBrKbxb?=
 =?us-ascii?Q?xcXBk5TgPpgDM2DTyIepzK48F8FrwcfZ1lmHqXRJwnu1OMGzsOpijUqypLP2?=
 =?us-ascii?Q?GsQIHiZZUJQHUxwc/mBBshqw9+skOlLkvxW/39ZtQkAEImo3cloSRrr2kKfh?=
 =?us-ascii?Q?eRvCNByfy0SVTO2DIEwPYSpXvcd+wYkFp57EgYvOZ+UxW34qTJb32Z+6Cq9B?=
 =?us-ascii?Q?PVnUQi6+K9TtMl1vOEJt50vRzssVwQ1yBouHOqvF25/NlRMQtHqbullKkIj5?=
 =?us-ascii?Q?H3JjxlzMnL3V6sHpPr0Ty2kg4y05Fc+FGyVT2Gdk4s/Dt0cqob7jdF94tzdt?=
 =?us-ascii?Q?t8iMmCPOPRzHUDnitfdTXhiR87fV3dK96HcunSKwYUWO6khXPZwnLaaf0imc?=
 =?us-ascii?Q?N1Tfn3xCHjof3zWu8pQ0gs+EgB/5XXWrOz9oMD9LwojpfEgQP9BqZHDxb6qA?=
 =?us-ascii?Q?+FF1AVx4AvzCX9+R3gVvSbkhqXpHXe2bvqZGHL+51iO+zyVHDP+r3BRIajun?=
 =?us-ascii?Q?r/6U8Dffk2XtyV02rJn2ysefxWGxG/b7pqKyqy94lJlhdGmw6MASXaOQlbuc?=
 =?us-ascii?Q?ALRaMxJrwoZtQ1zl64TF0e1TUatw4R8nby8qe4x8UkcYT1O+B1xaeAc8s4ql?=
 =?us-ascii?Q?/zzgaS25GQySKpfvFIK7r4R37mrFeINES1+YyhQPBkKDLbuU77+KGLQIncz4?=
 =?us-ascii?Q?V2EViFugQxIKNxmvdbCU678qFSa0qZb28JRaAYrQrFAlbgL0bkRufBHMBti6?=
 =?us-ascii?Q?cOvIwveluPXMVbhD8Mh70T6IxoM9aRjDssRpzLw14h/NJfrLZwbQl0a3YLnG?=
 =?us-ascii?Q?Se7gGDm46Kb+ZiBgCKQ+K21fcCs01sgdwqLALrFm4qYJIF2M73JBpbG9xznL?=
 =?us-ascii?Q?mdQfgdpJyOKnvnwUVFF0GG2dproCkO/Xfjd0CmDPe82us8ZCTYy9eECQ4kjB?=
 =?us-ascii?Q?DqXF0JaDT360sTDcLfXKEb+x88o2NRBgrwQPfGeGqMik9A9yzYXUYgJHzoHk?=
 =?us-ascii?Q?Ha7x1dnOx6TYMrjBP/fyxmtd3+JzRDw7IZzTlfYPAI7HOC9gNzZU2khclg?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ed8a25-892e-4e5b-4775-08dbdfdce553
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 22:00:03.7480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CuafOF+VBNOf8GeBvpXBOw6jiPMQAWUf8otUirFvHF4LZgh1EDTArsLNpEsOxMkpre/pBj6Yu6Jyqnr8YskFqO3vIl65BWfvzzKmVGvOY94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6275
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=917 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070182
X-Proofpoint-GUID: h7Iw9HUP9j2GXRr1hlT9Nq8L98UxWFWY
X-Proofpoint-ORIG-GUID: h7Iw9HUP9j2GXRr1hlT9Nq8L98UxWFWY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tracing support.

Note: this is quite incomplete.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/trace_events.h |  6 +++---
 kernel/trace/trace.c         |  2 ++
 kernel/trace/trace_output.c  | 16 ++++++++++++++--
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 21ae37e49319..355d25d5e398 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -178,7 +178,7 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status);
 
 enum trace_flag_type {
 	TRACE_FLAG_IRQS_OFF		= 0x01,
-	TRACE_FLAG_IRQS_NOSUPPORT	= 0x02,
+	TRACE_FLAG_NEED_RESCHED_LAZY    = 0x02,
 	TRACE_FLAG_NEED_RESCHED		= 0x04,
 	TRACE_FLAG_HARDIRQ		= 0x08,
 	TRACE_FLAG_SOFTIRQ		= 0x10,
@@ -205,11 +205,11 @@ static inline unsigned int tracing_gen_ctx(void)
 
 static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
 {
-	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
+	return tracing_gen_ctx_irq_test(0);
 }
 static inline unsigned int tracing_gen_ctx(void)
 {
-	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
+	return tracing_gen_ctx_irq_test(0);
 }
 #endif
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7f067ad9cf50..0776dba32c2d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2722,6 +2722,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
 
 	if (tif_need_resched(RESCHED_eager))
 		trace_flags |= TRACE_FLAG_NEED_RESCHED;
+	if (tif_need_resched(RESCHED_lazy))
+		trace_flags |= TRACE_FLAG_NEED_RESCHED_LAZY;
 	if (test_preempt_need_resched())
 		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
 	return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index db575094c498..c251a44ad8ac 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -460,17 +460,29 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
 		(entry->flags & TRACE_FLAG_IRQS_OFF && bh_off) ? 'D' :
 		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
 		bh_off ? 'b' :
-		(entry->flags & TRACE_FLAG_IRQS_NOSUPPORT) ? 'X' :
+		!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_SUPPORT) ? 'X' :
 		'.';
 
-	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED |
+	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY |
 				TRACE_FLAG_PREEMPT_RESCHED)) {
+	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
+		need_resched = 'B';
+		break;
 	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_PREEMPT_RESCHED:
 		need_resched = 'N';
 		break;
+	case TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
+		need_resched = 'L';
+		break;
+	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY:
+		need_resched = 'b';
+		break;
 	case TRACE_FLAG_NEED_RESCHED:
 		need_resched = 'n';
 		break;
+	case TRACE_FLAG_NEED_RESCHED_LAZY:
+		need_resched = 'l';
+		break;
 	case TRACE_FLAG_PREEMPT_RESCHED:
 		need_resched = 'p';
 		break;
-- 
2.31.1

