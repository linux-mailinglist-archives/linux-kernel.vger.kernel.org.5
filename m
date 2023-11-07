Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21B87E4C90
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344335AbjKGXMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbjKGXMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:12:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF7925A3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:10:51 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LK5ho026459;
        Tue, 7 Nov 2023 23:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=SMBfGn0Ei8IWZqD0rXzWkj3bRftjV4DQ10GWnqBubr8=;
 b=QcA6qssRLtfVKvOzFWHskTeYlpxHxxwIqA9BJMqAmy3sGTb20MO5zxNdJNtcDJr/hPbc
 osx5duK9uozV8/bCo5n/zbNxBQNshNgw+53urHkRB5qV2X0RmzKb7q7ndjb1zADQZ0SV
 fkKmPxVSl5tvVhd7FHZfu5HUU6Jdn1zMjO5C2oGaSootOUJ2TA1uPTth3H8melnR+gEp
 9q2YAvqFv7/x7EvsBr7GQHhrS0dvt2OyyqqXJdHgShWDx61CpRYuHJ4GOSlxk+ZcHeKd
 x6d3a125oWqxKF2iwSSwPaUtXFK9vs/f/qlLAatmIa79iYh7P/UTnfxSbz0nvYjKja4K ig== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2106wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N40ca031940;
        Tue, 7 Nov 2023 23:09:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w2248q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGyCbjwkD8KtSuVtvNfLDRfST+Ae73Ac0sYoacPAtDNLf0lZRahKbSbOYb7OR7s/FJvqDRHUq46nT9shqLlct6nr5hpRPN2QdX9tJ4eyWRQIWDdbqANVSv2IiTqs3WpqtxDnuVwWjc1YrlPoaklsl+AEkcjp0BDILXkxlPpaF3yLomT4bpW3t08QFIpylYZ+p9RcyFZZApqW/LPjP+B7jiLjCYY1zW0MWpAyCRKMxHLj6qvWjWyyNu0Oz5SrHjjV6PphWzgWqa8PaidegMCi0fAQf6JsgCmtgV/Rsoyjb4us+0bK8GBzydvD/42WdxbjR1Rqdhw9L6/4T/3VX3WOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMBfGn0Ei8IWZqD0rXzWkj3bRftjV4DQ10GWnqBubr8=;
 b=RWFWqnqrBH8PpvJ/x/PKjgUlg56Nk/4naRe+uWtYoriNjfMAGXk0Ozq9IDHCqA16sDaA+4j9YmdeBlV/3JMzELKbSO7NRcvhn936HvYGYfI6VijX/+6UGLRcYfa75mPjm8tG+k/HrsvL5/c+9WSxOe2v84wIFoyHlzLjIbqBoxZyRnNtr6zEfG1myzdG1ShbkHQcfbqGJE+hjlPuOOmRuedCccMW0teZdj2yLSZuF9AdqigrJ0V9WZjYYB3AyYiAZ1HuGEAuKe0FAXibHgaAHAZiH1tR1461Act3R9YZJN7MtranDQAldaai+DnyAN5dk8jnqMBd+0/Xpom6r9yfDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMBfGn0Ei8IWZqD0rXzWkj3bRftjV4DQ10GWnqBubr8=;
 b=0P22qCW2FGxdZ7XRjDTJBvaP/nKpPnMEgX1FBzSxGfgNAKXdrSnvpJifw2AmnndDvFgl1jop5elWLuQtPk0RtLql1z6wQEZ9Kbso9OTHlHsDu/jx9EAJGjO2F3fGkIgx2ZgUnlqnNVL4q/7z6DlELZIB/TDyImEiARClpwq05jU=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 23:09:39 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:09:39 +0000
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
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        Sven Eckelmann <sven@narfation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        David Ahern <dsahern@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Matthieu Baerts <matttbe@kernel.org>,
        Mat Martineau <martineau@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Jon Maloy <jmaloy@redhat.com>,
        Ying Xue <ying.xue@windriver.com>,
        Martin Schiller <ms@dev.tdt.de>
Subject: [RFC PATCH 79/86] treewide: net: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:08:15 -0800
Message-Id: <20231107230822.371443-23-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0049.namprd16.prod.outlook.com
 (2603:10b6:907:1::26) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: bc51f8ee-62ac-4c3e-75a3-08dbdfe69e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZOZ58Rua+MDPAMIB79Sz1kWSVhcA+DAEHJvxfZwdA4AUp1X7aBsJubOqKDxKid+1ruXPPDfdOLBmPRN2TIej6pUbuv4/8spSRoTX0101BbLSlzSI2i+PXOZUKBQdgkjxzdEYmqqrwxztfTx1kzF8Y6FX4zKluU7DfIne0SLNF64AJukxtKwaio6frBWw1YwwfPrlmZ1qxRLGTscbvrDhuXHW9TyhHYNKylbc9jYfVQtgtYwTI/srG2ubprEQwiotIWvjHj9ilyJVaPb/5qTnb4vOQi2y1YzD7xNtWOlPD5p7VH/BXUdrt+UbdOW61UJKgdjyiYtEEfSRgxslpAVlobnztXtT5WAy+W6HrAue5VDyEHAF29xmNMt4P5KJmQJzIIbrNA49luLbkEaa5c27LEg9gkVzWQarBZo6wGfTNvb7b20ePvY3jTD2SZGY91YH1Xmk7xIoUD/79a8p8+yPD+ov/68WpzmvQTNOY++5ALv+SHOEkY3BabpYQ7FYJ+RvenTtD6tPqNvgdrzO+TD/t4E5C4ZOqP5ZI9K1p2suVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66899024)(30864003)(6506007)(478600001)(6512007)(2616005)(6486002)(966005)(6666004)(7406005)(36756003)(103116003)(38100700002)(86362001)(1076003)(41300700001)(7366002)(7416002)(5660300002)(316002)(66556008)(66476007)(83380400001)(2906002)(54906003)(26005)(66946007)(6916009)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SSXFJDob3taW+LnnFUPw5zleGJR8eRi4ni3SOaD0lyBpLT1+XkIIbCdBKOI1?=
 =?us-ascii?Q?WTww2uXqNMVtR1OMJEQSd40YE8aKIHoqetaSx1AFWitcCiZYOM7rH/0uAV4p?=
 =?us-ascii?Q?Da4NFhwMz9pYdu8TmxibDGX2hhpRwH/JhW1r/NkG8ig3QsPqHCLVTP2xR9UQ?=
 =?us-ascii?Q?h9I1MuogRxFdVqkkyN9LFDWnYtIREvun8AinSbiUU/jZ0l96nXZA+k5tW2XF?=
 =?us-ascii?Q?5d0kxltL2dOX1t/TuuFb68QDdZAznZSl9MOgDLuZNUILkYUA0gPrtvjX+w4V?=
 =?us-ascii?Q?KGBMvf1uc66ptYwrWPB5ktoJW7DLgUoiVX/9dIadmFgOEiX4os0SW9s7ibdh?=
 =?us-ascii?Q?399TzJuA5kWktFJ1sd8IriJfEpEAuaEjkVEFg6iRnvntlLIsNsLiaU+sqOTX?=
 =?us-ascii?Q?yP0oy+d5jBx9+KOQmlnmT/PuGuI0rIoMUZm7BPA1enC2v/n10h/1LoR7ITnR?=
 =?us-ascii?Q?z3vAtOVTymWL4EwDxRWYqhUOv1NgE3G9xWoc+BzrntEzlfvIhr5RlQzKBHKr?=
 =?us-ascii?Q?GylqUy4eiLbGgi6WFS/47fKpq2aADrUVPKqqv5l+vGI+NVQATA+hAZwdcqVa?=
 =?us-ascii?Q?W57iwOtswaqopgiwF1/BaWnVc18QhbfBltMcnQzfpjRRbDjAy0gQVbT3QWbd?=
 =?us-ascii?Q?HU2L3qNxaET9nF+BHw34JmI6rIHVW6K5B7XZ2t+A/uNSR8SD+Y3JjKxBd2cJ?=
 =?us-ascii?Q?A7sLEcrSQ4xNPj0oKa2EjWQeYX+pqjeFe0B9X/b4FZuW4/S4BDhUO+kfoHRz?=
 =?us-ascii?Q?cxSRs7e+G1CzEprxtGrLVtisfXDs27nVDE8nzrEXxSjjRJsdum5SmZ6Suwzb?=
 =?us-ascii?Q?fZOcKVxqvgrzIWtee1YF77ypz4j3+wyyoHgKh5OeByaqPy+NFHx7/XJsIOkK?=
 =?us-ascii?Q?5u+RbhsLYHKrMS3kHJQx0CfoXqbmSOSiOmDs7h9vU/LRrhKDKK0KNqSuSV9n?=
 =?us-ascii?Q?9Ih03OhWeZ9vNa/Iyh8Psu1DhUgJoGAyBX7cKSHjw9wbDsaCxgvGKmaHBd5z?=
 =?us-ascii?Q?mY6OYuTjfpHU825G3cAbfoFeQtvoxlFk0rhdPgLYzeWAgh4dLIqRP159ltzW?=
 =?us-ascii?Q?dSoKMcYTIabGsoIhagqZ8YqhAXcgbDp9reUnKKznXz+N+neHtP2wceFQpWbQ?=
 =?us-ascii?Q?f1slsZO5t3BsImLpEqDAvRechBI9Ndi6m5uYrQYIfSDy8vlUiBVidq8B9h72?=
 =?us-ascii?Q?CC4kSQCgvJl3HVr5HBZPeKqXhGpVZPnDnVpQGtNURKavB7u9JAXLN3IV5Q8n?=
 =?us-ascii?Q?bLOslkDGEdDxFeIcvK1u0nhCFgMi9sKClWN3L/s0rqvGxvWlgL+No0Dr3GSG?=
 =?us-ascii?Q?kUnZbZfAkD0LRD0fdl0a1gx9ztzU14Dme2qCPJ3oh2RVyNpqn4B0ihwTsujE?=
 =?us-ascii?Q?SVaTV1mAGuR4T1f2h5SqNUI2kKdvTQ5KfQQDj/ykxhxakBUqTQzIWDAxV/EI?=
 =?us-ascii?Q?AlCK26OvO2a3g0gB5il9e9rNvjqdfjukbxVRoTFbqytACfFNOeHzxj1rObSJ?=
 =?us-ascii?Q?1deDro5O7MBtnBTRm+hRzLgv2Y8ajVxg56boQkBJ/6Oq+W4vcpwgcyjgrdP8?=
 =?us-ascii?Q?bgZRqnFg10pdueIqtBLWio6cT7tv40Z2nfNlEYkSJMS3FlsbHWGZ8VOCcGr3?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lZHB7Tc+qPTeyF4OQ12SiK4BJea5Ad5g7V/TU6gQ0gGRcCFFQMs7RAk05wMw?=
 =?us-ascii?Q?EuaKZ8UFji8Fer3RaX/5HZ67zts4z6/dfpmi2IbIPBmFbmz971VHgvqqwmfS?=
 =?us-ascii?Q?XhloJXxhtTcq66cYEuIAwQcOrz2s1lVTJu2QABHdEXljdettvzrJNw22CDRd?=
 =?us-ascii?Q?Gfy+qzhOk1niNwplvR/+Wy3Eh3qYXCWjTNHYrDqEfMME+BWaD5lgkf8k/JiG?=
 =?us-ascii?Q?KK7ufhfevC9dJvZMMgkEwrELV4yywdTxZT+ogyUqx/6p8xqmH+W9A1lvn9E9?=
 =?us-ascii?Q?q0LyAhIoVDc5FNCxBmOVKngw9yxAr7LQeWiTPt083ILEMk2oqjJrq7r14moY?=
 =?us-ascii?Q?MF3Nf27O2fGQEjafqUgU93ADq6NjZ2Ckmsp1Pe8OhCt/wQXR7qRbbJyXWmUS?=
 =?us-ascii?Q?n1RuUJ8+KKyfjNUZSGAbVcKOM66A1SYI67obY2t+ODaaCPeeSwDjcV6dqwG+?=
 =?us-ascii?Q?VLcpnWRAVv/hflF0wf+ypTLaQx70iMh1KuHZRv/8ujxp8v3GNzjT/hRdPW/6?=
 =?us-ascii?Q?mNmiB+24PLpWcE+4SIYePFzTd4eFc/C3s9va2UvR5lYi0np7r1NB9gbDUek/?=
 =?us-ascii?Q?PpgjX0TNvNG+PRadQ9U13rdixeurVHhp/dQJE4YLUxgsFXofnnhDN3Hv23oj?=
 =?us-ascii?Q?0+0WPIQTUrs+4G2qRRZiiy7WuHtxG8M2ryWmEZips14KNZFbv8HLO+2Ee5GF?=
 =?us-ascii?Q?BLxn/1RbrHyPW+xAAilDVIA2En7UW+O/xIHujbkLtW0reelLubfMyyOOME2r?=
 =?us-ascii?Q?5aMnlgdmMr9uoLzfcxINuvhhpnfe2ZZJGySI7ZRkn/wJ5f1HYWM7KqnBpSBy?=
 =?us-ascii?Q?7oObDY33v0/CH4zCwJY1m2rrXpB8drHRqyRc8J2o3CLjivv9IB/S3Jdc8YZ5?=
 =?us-ascii?Q?v8VuO8muZHkf/0NqbeUO/qrjO/sPjCZdlfQZwKA1Oo66QKnWKaEmPp376kEi?=
 =?us-ascii?Q?NNuo4gcubR2gQU2hWBva5kwcWFFSt7CnDAFVnEnTnJNfTTbIE2+JrWvdEFSm?=
 =?us-ascii?Q?Go17kI4eSZ3Yz9ayYriHP+6RK7sxHpj2EjRMOfoDV+ubeWhVvZGI5LaXknMA?=
 =?us-ascii?Q?e0Q2QIBjtxuaYbs1DFqkyzVoF6iVScxj/p2LzUFuTS/qCnOsFS/32ykKfEf+?=
 =?us-ascii?Q?hSA2Zp5Y23qLtr8vxUPq8ih810jjXncFucC97kFKeGvllrYCH8jcaRL7o9jj?=
 =?us-ascii?Q?URG7z0eDPFp5dShN6E2s+tVxHrP7TcurqfIr4tv/C/Tt44fILZ9S/UJnUhr6?=
 =?us-ascii?Q?U69evetwD6Dq1IOKUb4Qt9sDoKWD630gQP9rtcvqdLfwhl7BZeyY9Br/5NsF?=
 =?us-ascii?Q?QYrP7y2jvgbZaQoTlKfIALoe35WeQIpCCRq3PpyAJ4ZnqjFGg5Fg+iaOK0/d?=
 =?us-ascii?Q?XTPa1KkQBtCmZ7R1hUy/OtP97dgzv2vq9ZRBJoXRhvj3qN5n2paZx+VFlMF8?=
 =?us-ascii?Q?8rk/gT6rtGSCxgF23s/PK2QXSvJ/6l/grwHIQaNXsbAaYUVq6VEt5jCZdL0d?=
 =?us-ascii?Q?8XpxJq/O36kPOK5QHD7Lb5AO7n0LTl6yxRdr1yUfichqs6WHBeNPFAqiECZn?=
 =?us-ascii?Q?LbRGfXdwYZKS6f0WpcgBwIfzK9jjiqACNZBEN61QEVZGKvf2yPfnbK5JBzfn?=
 =?us-ascii?Q?57rahBK9C4kEeT3iLRd57ABIN1pshehhKYAFsPLJsAB4NN0Dj/F2xhS/JF9l?=
 =?us-ascii?Q?XW8tWfjP5QFl0A4gz8but+6THAMA4kXrCR8OLm/hHceP4EL0NUudny1vdVzl?=
 =?us-ascii?Q?wx7sY6jJ77r1aFVUzJlGX4VZGD2fnti2tCd0ak8w40AjIBECzU/uiPpnCTRX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: tVqUpB5f8847Os23bTMuXymucZYpSRCHpt/oiVddWwD9ILWRtOJT2L+skMRuFZGZyMp3BW9ymVafnDmpJPG7sPuugqnLHe2DUqVOvjAqzuviboxjrPu8AwEmu5SpnK1/2tth3slmnUOsXIuJjQgS6nT0p8D9Czspgvd+IJY9IyXzpxeAzDRXlTkhZ1I4kLwuAEbOmwlwhbw8GW5mTiGMZcKgNw0GfdWyqgY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc51f8ee-62ac-4c3e-75a3-08dbdfe69e66
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:09:39.8023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpvmKQ8tUAeTfpJpb3xk7DCJtPV1+2KSk5FkGVEQu3hONLquUa4eWojy5v9TXT/k0i5d2/txyBPNqhxEa5+Uu2TJoT5d0dqKhREADMYAaXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070189
X-Proofpoint-GUID: tEbquswOHUX23dBsm0nEutDMMl4LwZaf
X-Proofpoint-ORIG-GUID: tEbquswOHUX23dBsm0nEutDMMl4LwZaf
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

Most of the uses here are in set-1 (some right after we give up a
lock or enable bottom-halves, causing an explicit preemption check.)

We can remove all of them.

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: Marek Lindner <mareklindner@neomailbox.ch> 
Cc: Simon Wunderlich <sw@simonwunderlich.de> 
Cc: Antonio Quartulli <a@unstable.cc> 
Cc: Sven Eckelmann <sven@narfation.org> 
Cc: "David S. Miller" <davem@davemloft.net> 
Cc: Eric Dumazet <edumazet@google.com> 
Cc: Jakub Kicinski <kuba@kernel.org> 
Cc: Paolo Abeni <pabeni@redhat.com> 
Cc: Roopa Prabhu <roopa@nvidia.com> 
Cc: Nikolay Aleksandrov <razor@blackwall.org> 
Cc: David Ahern <dsahern@kernel.org> 
Cc: Pablo Neira Ayuso <pablo@netfilter.org> 
Cc: Jozsef Kadlecsik <kadlec@netfilter.org> 
Cc: Florian Westphal <fw@strlen.de> 
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com> 
Cc: Matthieu Baerts <matttbe@kernel.org> 
Cc: Mat Martineau <martineau@kernel.org> 
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> 
Cc: Xin Long <lucien.xin@gmail.com> 
Cc: Trond Myklebust <trond.myklebust@hammerspace.com> 
Cc: Anna Schumaker <anna@kernel.org> 
Cc: Jon Maloy <jmaloy@redhat.com> 
Cc: Ying Xue <ying.xue@windriver.com> 
Cc: Martin Schiller <ms@dev.tdt.de> 
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 net/batman-adv/tp_meter.c       |  2 --
 net/bpf/test_run.c              |  1 -
 net/bridge/br_netlink.c         |  1 -
 net/ipv6/fib6_rules.c           |  1 -
 net/ipv6/netfilter/ip6_tables.c |  2 --
 net/ipv6/udp.c                  |  2 --
 net/mptcp/mptcp_diag.c          |  2 --
 net/mptcp/pm_netlink.c          |  5 -----
 net/mptcp/protocol.c            |  1 -
 net/rds/ib_recv.c               |  2 --
 net/rds/tcp.c                   |  2 +-
 net/rds/threads.c               |  1 -
 net/rxrpc/call_object.c         |  2 +-
 net/sctp/socket.c               |  1 -
 net/sunrpc/cache.c              | 11 +++++++++--
 net/sunrpc/sched.c              |  2 +-
 net/sunrpc/svc_xprt.c           |  1 -
 net/sunrpc/xprtsock.c           |  2 --
 net/tipc/core.c                 |  2 +-
 net/tipc/topsrv.c               |  3 ---
 net/unix/af_unix.c              |  5 ++---
 net/x25/af_x25.c                |  1 -
 22 files changed, 15 insertions(+), 37 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 7f3dd3c393e0..a0b160088c33 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -877,8 +877,6 @@ static int batadv_tp_send(void *arg)
 		/* right-shift the TWND */
 		if (!err)
 			tp_vars->last_sent += payload_len;
-
-		cond_resched();
 	}
 
 out:
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 0841f8d82419..f4558fdfdf74 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -81,7 +81,6 @@ static bool bpf_test_timer_continue(struct bpf_test_timer *t, int iterations,
 		/* During iteration: we need to reschedule between runs. */
 		t->time_spent += ktime_get_ns() - t->time_start;
 		bpf_test_timer_leave(t);
-		cond_resched();
 		bpf_test_timer_enter(t);
 	}
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 10f0d33d8ccf..f326b034245f 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -780,7 +780,6 @@ int br_process_vlan_info(struct net_bridge *br,
 					       v - 1, rtm_cmd);
 				v_change_start = 0;
 			}
-			cond_resched();
 		}
 		/* v_change_start is set only if the last/whole range changed */
 		if (v_change_start)
diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index 7c2003833010..528e6a582c21 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -500,7 +500,6 @@ static void __net_exit fib6_rules_net_exit_batch(struct list_head *net_list)
 	rtnl_lock();
 	list_for_each_entry(net, net_list, exit_list) {
 		fib_rules_unregister(net->ipv6.fib6_rules_ops);
-		cond_resched();
 	}
 	rtnl_unlock();
 }
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index fd9f049d6d41..704f14c4146f 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -778,7 +778,6 @@ get_counters(const struct xt_table_info *t,
 
 			ADD_COUNTER(counters[i], bcnt, pcnt);
 			++i;
-			cond_resched();
 		}
 	}
 }
@@ -798,7 +797,6 @@ static void get_old_counters(const struct xt_table_info *t,
 			ADD_COUNTER(counters[i], tmp->bcnt, tmp->pcnt);
 			++i;
 		}
-		cond_resched();
 	}
 }
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 86b5d509a468..032d4f7e6ed3 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -443,8 +443,6 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	}
 	kfree_skb(skb);
 
-	/* starting over for a new packet, but check if we need to yield */
-	cond_resched();
 	msg->msg_flags &= ~MSG_TRUNC;
 	goto try_again;
 }
diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index 8df1bdb647e2..82bf16511476 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -141,7 +141,6 @@ static void mptcp_diag_dump_listeners(struct sk_buff *skb, struct netlink_callba
 		spin_unlock(&ilb->lock);
 		rcu_read_unlock();
 
-		cond_resched();
 		diag_ctx->l_num = 0;
 	}
 
@@ -190,7 +189,6 @@ static void mptcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 			diag_ctx->s_num--;
 			break;
 		}
-		cond_resched();
 	}
 
 	if ((r->idiag_states & TCPF_LISTEN) && r->id.idiag_dport == 0)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9661f3812682..b48d2636ce8d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1297,7 +1297,6 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
 
 next:
 		sock_put(sk);
-		cond_resched();
 	}
 
 	return 0;
@@ -1443,7 +1442,6 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 
 next:
 		sock_put(sk);
-		cond_resched();
 	}
 
 	return 0;
@@ -1478,7 +1476,6 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 
 next:
 		sock_put(sk);
-		cond_resched();
 	}
 
 	return 0;
@@ -1594,7 +1591,6 @@ static void mptcp_nl_remove_addrs_list(struct net *net,
 		}
 
 		sock_put(sk);
-		cond_resched();
 	}
 }
 
@@ -1878,7 +1874,6 @@ static int mptcp_nl_set_flags(struct net *net,
 
 next:
 		sock_put(sk);
-		cond_resched();
 	}
 
 	return ret;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 886ab689a8ae..8c4a51903b23 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3383,7 +3383,6 @@ static void mptcp_release_cb(struct sock *sk)
 		if (flags & BIT(MPTCP_RETRANSMIT))
 			__mptcp_retrans(sk);
 
-		cond_resched();
 		spin_lock_bh(&sk->sk_lock.slock);
 	}
 
diff --git a/net/rds/ib_recv.c b/net/rds/ib_recv.c
index e53b7f266bd7..d2111e895a10 100644
--- a/net/rds/ib_recv.c
+++ b/net/rds/ib_recv.c
@@ -459,8 +459,6 @@ void rds_ib_recv_refill(struct rds_connection *conn, int prefill, gfp_t gfp)
 	    rds_ib_ring_empty(&ic->i_recv_ring))) {
 		queue_delayed_work(rds_wq, &conn->c_recv_w, 1);
 	}
-	if (can_wait)
-		cond_resched();
 }
 
 /*
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 2dba7505b414..9b4d07235904 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -530,7 +530,7 @@ static void rds_tcp_accept_worker(struct work_struct *work)
 					       rds_tcp_accept_w);
 
 	while (rds_tcp_accept_one(rtn->rds_tcp_listen_sock) == 0)
-		cond_resched();
+		cond_resched_stall();
 }
 
 void rds_tcp_accept_work(struct sock *sk)
diff --git a/net/rds/threads.c b/net/rds/threads.c
index 1f424cbfcbb4..2a75b48769e8 100644
--- a/net/rds/threads.c
+++ b/net/rds/threads.c
@@ -198,7 +198,6 @@ void rds_send_worker(struct work_struct *work)
 	if (rds_conn_path_state(cp) == RDS_CONN_UP) {
 		clear_bit(RDS_LL_SEND_FULL, &cp->cp_flags);
 		ret = rds_send_xmit(cp);
-		cond_resched();
 		rdsdebug("conn %p ret %d\n", cp->cp_conn, ret);
 		switch (ret) {
 		case -EAGAIN:
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 773eecd1e979..d2704a492a3c 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -755,7 +755,7 @@ void rxrpc_destroy_all_calls(struct rxrpc_net *rxnet)
 			       call->flags, call->events);
 
 			spin_unlock(&rxnet->call_lock);
-			cond_resched();
+			cpu_relax();
 			spin_lock(&rxnet->call_lock);
 		}
 
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 7f89e43154c0..448112919848 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -8364,7 +8364,6 @@ static int sctp_get_port_local(struct sock *sk, union sctp_addr *addr)
 			break;
 		next:
 			spin_unlock_bh(&head->lock);
-			cond_resched();
 		} while (--remaining > 0);
 
 		/* Exhausted local port range during search? */
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 95ff74706104..3bcacfbbf35f 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -521,10 +521,17 @@ static void do_cache_clean(struct work_struct *work)
  */
 void cache_flush(void)
 {
+	/*
+	 * We call cache_clean() in what is seemingly a tight loop. But,
+	 * the scheduler can always preempt us when we give up the spinlock
+	 * in cache_clean().
+	 */
+
 	while (cache_clean() != -1)
-		cond_resched();
+		;
+
 	while (cache_clean() != -1)
-		cond_resched();
+		;
 }
 EXPORT_SYMBOL_GPL(cache_flush);
 
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 6debf4fd42d4..5b7a3c8a271f 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -950,7 +950,7 @@ static void __rpc_execute(struct rpc_task *task)
 		 * Lockless check for whether task is sleeping or not.
 		 */
 		if (!RPC_IS_QUEUED(task)) {
-			cond_resched();
+			cond_resched_stall();
 			continue;
 		}
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 4cfe9640df48..d2486645d725 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -851,7 +851,6 @@ void svc_recv(struct svc_rqst *rqstp)
 		goto out;
 
 	try_to_freeze();
-	cond_resched();
 	if (kthread_should_stop())
 		goto out;
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index a15bf2ede89b..50c1f2556b3e 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -776,7 +776,6 @@ static void xs_stream_data_receive(struct sock_xprt *transport)
 		if (ret < 0)
 			break;
 		read += ret;
-		cond_resched();
 	}
 	if (ret == -ESHUTDOWN)
 		kernel_sock_shutdown(transport->sock, SHUT_RDWR);
@@ -1412,7 +1411,6 @@ static void xs_udp_data_receive(struct sock_xprt *transport)
 			break;
 		xs_udp_data_read_skb(&transport->xprt, sk, skb);
 		consume_skb(skb);
-		cond_resched();
 	}
 	xs_poll_check_readable(transport);
 out:
diff --git a/net/tipc/core.c b/net/tipc/core.c
index 434e70eabe08..ed4cd5faa387 100644
--- a/net/tipc/core.c
+++ b/net/tipc/core.c
@@ -119,7 +119,7 @@ static void __net_exit tipc_exit_net(struct net *net)
 	tipc_crypto_stop(&tipc_net(net)->crypto_tx);
 #endif
 	while (atomic_read(&tn->wq_count))
-		cond_resched();
+		cond_resched_stall();
 }
 
 static void __net_exit tipc_pernet_pre_exit(struct net *net)
diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index 8ee0c07d00e9..13cd3816fb52 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -277,7 +277,6 @@ static void tipc_conn_send_to_sock(struct tipc_conn *con)
 			ret = kernel_sendmsg(con->sock, &msg, &iov,
 					     1, sizeof(*evt));
 			if (ret == -EWOULDBLOCK || ret == 0) {
-				cond_resched();
 				return;
 			} else if (ret < 0) {
 				return tipc_conn_close(con);
@@ -288,7 +287,6 @@ static void tipc_conn_send_to_sock(struct tipc_conn *con)
 
 		/* Don't starve users filling buffers */
 		if (++count >= MAX_SEND_MSG_COUNT) {
-			cond_resched();
 			count = 0;
 		}
 		spin_lock_bh(&con->outqueue_lock);
@@ -426,7 +424,6 @@ static void tipc_conn_recv_work(struct work_struct *work)
 
 		/* Don't flood Rx machine */
 		if (++count >= MAX_RECV_MSG_COUNT) {
-			cond_resched();
 			count = 0;
 		}
 	}
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3e8a04a13668..bb1367f93db2 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1184,10 +1184,9 @@ static int unix_autobind(struct sock *sk)
 		unix_table_double_unlock(net, old_hash, new_hash);
 
 		/* __unix_find_socket_byname() may take long time if many names
-		 * are already in use.
+		 * are already in use. The unlock above would have allowed the
+		 * scheduler to preempt if preemption was needed.
 		 */
-		cond_resched();
-
 		if (ordernum == lastnum) {
 			/* Give up if all names seems to be in use. */
 			err = -ENOSPC;
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 0fb5143bec7a..2a6b05bcb53d 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -343,7 +343,6 @@ static unsigned int x25_new_lci(struct x25_neigh *nb)
 			lci = 0;
 			break;
 		}
-		cond_resched();
 	}
 
 	return lci;
-- 
2.31.1

