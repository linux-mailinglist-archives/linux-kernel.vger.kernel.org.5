Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158B87E4B48
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343633AbjKGWAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjKGV7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:59:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D609110E2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:29 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJXQX014855;
        Tue, 7 Nov 2023 21:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=joC/C/E1hOImk91NP4N/87VhyEsAn5lZdEANUfSUsjg=;
 b=GBbm/sj4hQOfu1Yy/5F8vnKDnTCuxUwEj5ekcrJvzpUsdPcIS4iv+fELxFCpvoiK0m7y
 f9O6ST/TZPrhvlIQRZ+7YVZjl1S0hSa1tin2oV4aUBvuNW1kThIZtu+QRq8XR3IQdKRe
 4efAFOuLv5jjuiO3eImrPcBI2LwE+HWinlwgpIZ1SszSy7m5iwDH/EzW8QKhZ9YiMdfo
 FSrOz5moetsNVr7ukqUBDnurdhhjl7nbq3R+OVz2BlC14N+yZwZ+AJWI5ves+Awv4l5I
 RKLgxnqzZyLHXC9jQVMh0ndUQaPaFxsZVkN4oenR+UTCIkTKqZXrAAiAf212lDG8C/Rw KA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w26r2ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:57:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJ1HX000739;
        Tue, 7 Nov 2023 21:57:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1wsjd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:57:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VP+TupINPVSDZp7sTBx1jwCd5YTI2PzTOtT9RYROqNgV+Q/B5W6nsk4asUropApk0w5h2kmWkpdxq7awdF9g2HOGmxYBkTiQCmdJMlWvLpvzB1M+y1M7lqeH8tk6ftseJf2SSUSawi7y4C7tx3Mk3Dzqy5606hm2G6gSqohc8lHsN1b3okt8+XtZPC0XdIZK9kTWHRmk5PrA9KWNPriQPQvEwoVJddeXJasTJlTV4N83a4g6iD4LsjGpUPuttaiXpkY7JnMaR1mpmO/FnG1wcgecXwcaHZBF08YV+/YA+7HmSoyLV1cXZL1mcXhyKQ/jDqhzN3X8OCWeZ78AH929Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joC/C/E1hOImk91NP4N/87VhyEsAn5lZdEANUfSUsjg=;
 b=FKJjyjedcIC9DVCl2v6qy61azkNcUbljzmM83NQ5V+iwtTNZrTsW1qq/2Woano8xibOjL07aYxu8H90bxL0gXjqK5UhJSaioecHnr7FAPuWCvuXFIlUhuHYs7dHetZLsWdIQhXrbsyLcOT1E0TS7gz5yb5qSexOgLJrMg4OCXy1BYIzPK3or9//PchR/DJ7fdKDMzIRniwstJe3Q8nE4kCaLfRUUv174XTfgx2SnOa/iiOABcI0NPM7fPk4wpKFu+sBTEm566vakO640FrrevxcEABg9F5ymAcqfSgF4sUy+yhTFkqHOB+UkRP2rMLy7afETFpFtYzOsdG2ANHwW6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joC/C/E1hOImk91NP4N/87VhyEsAn5lZdEANUfSUsjg=;
 b=H79ps9mnofMJ4zcl5PbFABGhCzpI0Uy7xZSzLvayxVqbeSd6YzTfHYpX4xyyZbR3CZqbwBozcZ+CzMMoRbxJ4MpFRlGcXQLksFd3yGhQ1e8Uals7/L3FijAclcTIR1BB/l5Erj4k3i3iOtkGrmU0rXAlMpnPUb85hNptWVpM/uI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYYPR10MB7651.namprd10.prod.outlook.com (2603:10b6:930:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 7 Nov
 2023 21:57:44 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:57:44 +0000
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
Subject: [RFC PATCH 00/86] Make the kernel preemptible
Date:   Tue,  7 Nov 2023 13:56:46 -0800
Message-Id: <20231107215742.363031-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYYPR10MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d433666-e640-4132-d1f6-08dbdfdc9200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iy6Mu2trmdX2jalyGq7W1+7o9Ls613b5yXQJGoShEdf4XZGf4v+TRvJv9+axBpP1mUzoqIvfVj+y7SEDe6lUfBsiuDMou9MqHpc8ruXJsRyB+IwLfoDXilnIZl3SkbANicpnwwxtEcggtid5tHeugACTWXiI2Ini5xnVBGWjhXpe7707FnoB0rdCfXfJbRnnM4CG9OILsNgTUqMkyKuMcmZbvjZ5yjhhTLG8tP7LydiZOUd9Y8QK5A5GYM1DXjoLKzzgjpxOrjSTNkc/1tMFH5hnBNwyEY/HIQ1JmjdP5LMVao7iyFsYz6kOyxt0Bqbm3KqsQt6VERh2ZWTq/qJUJJ3TMGSKbFYNIycRtEalWFI75XcB6RoWE0WV4hdWsNs6cQZcgkBCI4qhxl3YbAONxgW57PljVfhsTrEuF3v003xaxIc+rWH7+ngPMuQi6ML6DKzexl3abVHPe6UQ1pt7+/JUZUB86UDJ2kC+lEyt1r+h6y0IkiCpeU7nYa6PVRRwX3Cs2ap5U5PTQOVVXGL2L/UIeZI5lZvrgcjAc7e6ltR82hZ0mP+HeWYMQcDDUuY3STPT1UoI1OxM6dHxjz4CxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(30864003)(6916009)(41300700001)(66556008)(66946007)(83380400001)(7406005)(7416002)(66476007)(316002)(478600001)(8676002)(6486002)(2906002)(5660300002)(4326008)(966005)(8936002)(84970400001)(6506007)(66899024)(6512007)(26005)(1076003)(38100700002)(2616005)(107886003)(86362001)(103116003)(36756003)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yO8XDNZDTfbUQPd1G/s90yIpc2p3Re15Lm/VMqP9e+V7dAv8KsS7YZswOhlh?=
 =?us-ascii?Q?fs1yL/5uQPmH/0GIClQuljAAS6UIAXO8bP6ImYMGtqDlt0PClx3vUy13sRGj?=
 =?us-ascii?Q?nSAe0HOwVfk6+zDLC1Y/0ZdVZETaY+ZbQ3n25awWiTVV6yLUzrh0TCuvX6OB?=
 =?us-ascii?Q?dX6Xl9M6crZoUmMGaMVaIgTLN2ey4qCZEtxCk0T5kYtqoqoEwSlVyfIyrgdL?=
 =?us-ascii?Q?hX1pJx0x7OBKXTOFMXLSWQYv4jwGOnWv4fv4Iud0nCUyWgUX0C0OUJHnmiu/?=
 =?us-ascii?Q?7b9oSX8A/ZaAfpx6UhN/KqFg62R55v+5eowbfI9hyWQtusiObQ04qlgu38Yj?=
 =?us-ascii?Q?LnlahdFqjzmJCaZqIZ2LjUVUc/occ1xYhrIw21vkYLToOj2f6YnGQPRNqVL8?=
 =?us-ascii?Q?2lY7wK1W5N6B8SvGu0VU5J9pWksr0sQI4EAX8rX5xgnwMg8eZ0QfKuyyy/wE?=
 =?us-ascii?Q?fW/dK/gx5Ux36I2D8IlyaHEYak60mh7l2N/Sl6kw4q2Hv1eRSUlMi9zdSCUv?=
 =?us-ascii?Q?NvSkyJ6cMZcBpvjamMDji7OL+J0BvzTcrRmGeEai0oDqF2NaH41tbl0gGMv4?=
 =?us-ascii?Q?n0TIyYvlol214niC8+C4vti/xAmfKMdbSQqAofjruiU6MgQXDPMOxbdXHWIG?=
 =?us-ascii?Q?Hfw5/MdqCPDXcx6PiR9URJscRp4KooaGlYv7m7/CtTJxvZ+EeX2FK4tASo0e?=
 =?us-ascii?Q?oh+xQUVoADPSIrpfWv7vX40FigvtIMKb2UH/5eYHKG+39rK1lEbjrVciTX68?=
 =?us-ascii?Q?26bfl8ME4/ywN9yWENaIL1+VsKRm7TmaDdAjOx8tAh4LP3wownGbpYfbZ/Zb?=
 =?us-ascii?Q?+H0vKJtecYWbuQrgcGYRoN3LjlNZ6auk8zOGGa0QvhtxVr6MkMycsu2AN5T1?=
 =?us-ascii?Q?1gZrSZAMqqMpsm6uBmGy7wPb1GK0Z24yYEZEe3gln5wBcTL2DAt/dPDpP7Rg?=
 =?us-ascii?Q?4mfCBXQgxkoX6KPNE5g3PbfXI6Q2i5dvJGX7nPC7Jul+zlvMiMwc3JBxoUzD?=
 =?us-ascii?Q?kWszG+c3daSBINsgbojASzflLx5Tk1cTMfTQpGFf6SOXQremXb39VeN17Oal?=
 =?us-ascii?Q?ir+mkP+dHHo64R2REb/gkDXdHpXD95YZHq1yEcd9ed+X94DuUzp8qzbDLv6W?=
 =?us-ascii?Q?IpAW1xAAXIArSO/YlOKIlUHD3M3vtz5uM9B3g4rcpkBBNSD7PuPwf9Ccun12?=
 =?us-ascii?Q?eQFV6PBABFe3BVGTUUvg/MrRwOUhgS7Y447swC5xN+Nlt2bV6V6bGOClh410?=
 =?us-ascii?Q?q/4im+KKBMy+sulu1BTn1xKE5/4ihPbNZRe4laB4c9QA1wvF3qjChAdEsx6e?=
 =?us-ascii?Q?z8ZF9Au4+XXWAtcMN8+qJYfYV65NEMPrJ8Vec1Rp3npwYM7LynMOsRN5Gtrk?=
 =?us-ascii?Q?zg8SuSoOmQInWM002hMax2KvPlQjlwDBXzb0jiw5Ts3jHN/2L1vU3becjXDE?=
 =?us-ascii?Q?Ih8Bs4W1f6tKJ4j3+LO8kI0Pcv+FwuIzlY8uhZ0zKe4H3xSo9mKIJqtTeoOd?=
 =?us-ascii?Q?VV4xvYC4FIa7ZdbG4/QU9PpfrgtuaeY/BEPYqAPWbi0WvFzEvuwYsk6UB81P?=
 =?us-ascii?Q?N84JTK/OLtLVxDlSwXE2pNBn1kMxOVsLhqKM/ZT9s3w9V5SRlAF0/KRoy9uz?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PkcwExM1fz6LsNKEuHoYUrM8f3VirPC9rZphD0Dlb5u0stokVuwbNUuN8+6E?=
 =?us-ascii?Q?LXApVaO7s2B7td4herJ6n9E1P3avHOATl6DD9ZFBe3Di8LUT1a7QfgxDDXBu?=
 =?us-ascii?Q?LZ1CJmEQTNh0FmV63DmAu1S4GtEjqfPy1RDzu4BLJd8jV4X5xLnm8cyhaOdB?=
 =?us-ascii?Q?+K23d/xTvZsIc6GHyo4sGg7J1QJobC8iKCP+H7b5c2qDpHSMpngFFtI6/e5j?=
 =?us-ascii?Q?5lKdF90GpXXwOVLqHnRlC8YwZtgUwsmkDMYw5rMlfxtQ+9k+qC6kATo/PqMu?=
 =?us-ascii?Q?3s1BOhG2yLDVYATbry5IsGWf9rXYQJfaCAc8liEvJWqIhoRIU/mNiZHZnSkR?=
 =?us-ascii?Q?ZUIPNc3bVHQp/DlKnrxDR21lI6coPNSlyTYWSWjaBbm8kKM+ioCM7FcQUSbd?=
 =?us-ascii?Q?n0UoeWjuB2291tSOM+fuEeTDa3XZoSjxgrdgD7247ZV0e++clOirxxDF2Ljf?=
 =?us-ascii?Q?84lhePThTEqHrXvHdPtXIAE203E+u41HexpA05IugXsnm6unKOjZXcYikLod?=
 =?us-ascii?Q?0kAUpK0af+vo8nla+w/mVh5nSfv8fpTsFe3w1pRYZksPrdZgmX474Mp8Ffcu?=
 =?us-ascii?Q?6aLQGtP7nrHVEIj2Y1tcmt2ysuldWTb2vFsOwA8WeAK8KwASzEUNQ5uScsuk?=
 =?us-ascii?Q?MtBQdDYDka15ToVttcf6d1gNy5yiiXRo3Z+70MO+ntiWd+RP36JX4RBzpxVU?=
 =?us-ascii?Q?xL+8PwS6x5CBq5SYcuRbViZJ3CxZQOAmr9v5Au9CrlcHkUKQeEAeWA6OpVDz?=
 =?us-ascii?Q?bVEQYcPAxOYGUgsZFV57IlPBzFU0gVpe/IYc8LefRdtFtlNXdttvRmGQHZ3E?=
 =?us-ascii?Q?oPfBGhm2VgwoYZo3Ph2q+oaf51R3vXSzg7QOrZt/wQMi/vHoZcmi8MG7QI/h?=
 =?us-ascii?Q?qv1PKnb9P8HAwMEj/N8rfQjB0DqwjXGk0fqdcO+JP8N6R13IUXIAqzQKFE0N?=
 =?us-ascii?Q?FN1nVnGPisjelyy9YVIN2eBh+te8FsE60/rFlUv0NE3sjA1tBfMFiI6n5Kmr?=
 =?us-ascii?Q?jRwvNYFnzcmewD2yUDDoKuUX4QYOsMIWf027Dw5/7ke9r0IW4D/LXOlRuvt6?=
 =?us-ascii?Q?oGmeoMdfpnLCj92lb/GnnBNCcGS7PcWIIQtMrjmmB9tRyxsZrQP4kNP0gl2j?=
 =?us-ascii?Q?BifsirY1qXi7YQ3MvxrPbv5aOvfSDIVFqsku0mJOBfobdnqTFmG6+dE/PByS?=
 =?us-ascii?Q?jwkN+u/+m7dU+YuEbwXJ3twnLHYF3MFWlFG8lOT85QdsfmhV0k0nuQa1SWBP?=
 =?us-ascii?Q?WA5QGRXj0aktwa4Tb1MujH1+roEUl0ao5jNb/p9brVv5iY0wVGdG3JuxJVTU?=
 =?us-ascii?Q?3rntM+M+Q1DYVaSFLLLy+CiSzYNquMc26dZWSMKbN2cE8KRXFekKoNUxVpvr?=
 =?us-ascii?Q?U0190AoLi+LIGOUepo8Q/94pe9XgEGTBWhvX3oSd/E7fYME3Ohr0USab0RmW?=
 =?us-ascii?Q?BcmVv+PdzvFdUOa9V0FkkYSow2KxZsFbAV5yln0MD3EYE7oazEboE3s2QqdP?=
 =?us-ascii?Q?N6ygqa3TfLI28JUA+aQhBmgkN8s4TGErz1cBTLTqFeqqZp2LboRWfPUeyw?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d433666-e640-4132-d1f6-08dbdfdc9200
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:57:44.2205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/G7g7j3S+dMzA42fDo3mELqrQIuwmpHE8GqBtz5VKcWMGR/slBFKWe8L1ydUw1SF9xarJnKoBa7tJKyL8TibbmzNLDRNqJUkJRqeGecs20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070181
X-Proofpoint-GUID: XDKgvhhhoQaJ9nlCQbHkq1C5hmqlyVat
X-Proofpoint-ORIG-GUID: XDKgvhhhoQaJ9nlCQbHkq1C5hmqlyVat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have two models of preemption: voluntary and full (and RT which is
a fuller form of full preemption.) In this series -- which is based
on Thomas' PoC (see [1]), we try to unify the two by letting the
scheduler enforce policy for the voluntary preemption models as well.

(Note that this is about preemption when executing in the kernel.
Userspace is always preemptible.)

Background
==

Why?: both of these preemption mechanisms are almost entirely disjoint.
There are four main sets of preemption points in the kernel:

 1. return to user
 2. explicit preemption points (cond_resched() and its ilk)
 3. return to kernel (tick/IPI/irq at irqexit)
 4. end of non-preemptible sections at (preempt_count() == preempt_offset)

Voluntary preemption uses mechanisms 1 and 2. Full preemption
uses 1, 3 and 4. In addition both use cond_resched_{rcu,lock,rwlock*}
which can be all things to all people because they internally
contain 2, and 4.

Now since there's no ideal placement of explicit preemption points,
they tend to be randomly spread over code and accumulate over time,
as they are are added when latency problems are seen. Plus fear of
regressions makes them difficult to remove.
(Presumably, asymptotically they would spead out evenly across the
instruction stream!)

In voluntary models, the scheduler's job is to match the demand
side of preemption points (a task that needs to be scheduled) with
the supply side (a task which calls cond_resched().)

Full preemption models track preemption count so the scheduler can
always knows if it is safe to preempt and can drive preemption
itself (ex. via dynamic preemption points in 3.)

Design
==

As Thomas outlines in [1], to unify the preemption models we
want to: always have the preempt_count enabled and allow the scheduler
to drive preemption policy based on the model in effect.

Policies:

- preemption=none: run to completion
- preemption=voluntary: run to completion, unless a task of higher
  sched-class awaits
- preemption=full: optimized for low-latency. Preempt whenever a higher
  priority task awaits.

To do this add a new flag, TIF_NEED_RESCHED_LAZY which allows the
scheduler to mark that a reschedule is needed, but is deferred until
the task finishes executing in the kernel -- voluntary preemption
as it were.

The TIF_NEED_RESCHED flag is evaluated at all three of the preemption
points. TIF_NEED_RESCHED_LAZY only needs to be evaluated at ret-to-user.

         ret-to-user    ret-to-kernel    preempt_count()
none           Y              N                N
voluntary      Y              Y                Y
full           Y              Y                Y


There's just one remaining issue: now that explicit preemption points are
gone, processes that spread a long time in the kernel have no way to give
up the CPU.

For full preemption, that is a non-issue as we always use TIF_NEED_RESCHED.

For none/voluntary preemption, we handle that by upgrading to TIF_NEED_RESCHED
if a task marked TIF_NEED_RESCHED_LAZY hasn't preempted away by the next tick.
(This would cause preemption either at ret-to-kernel, or if the task is in
a non-preemptible section, when it exits that section.)

Arguably this provides for much more consistent maximum latency (~2 tick
lengths + length of non-preemptible section) as compared to the old model
where the maximum latency depended on the dynamic distribution of
cond_resched() points.

(As a bonus it handles code that is preemptible but cannot call cond_resched()
 completely trivially: ex. long running Xen hypercalls, or this series
 which started this discussion:
 https://lore.kernel.org/all/20230830184958.2333078-8-ankur.a.arora@oracle.com/)


Status
==

What works:
 - The system seems to keep ticking over with the normal scheduling policies
   (SCHED_OTHER). The support for the realtime policies is somewhat more
   half baked.)
 - The basic performance numbers seem pretty close to 6.6-rc7 baseline

What's broken:
 - ARCH_NO_PREEMPT (See patch-45 "preempt: ARCH_NO_PREEMPT only preempts
   lazily")
 - Non-x86 architectures. It's trivial to support other archs (only need
   to add TIF_NEED_RESCHED_LAZY) but wanted to hold off until I got some
   comments on the series.
   (From some testing on arm64, didn't find any surprises.)
 - livepatch: livepatch depends on using _cond_resched() to provide
   low-latency patching. That is obviously difficult with cond_resched()
   gone. We could get a similar effect by using a static_key in
   preempt_enable() but at least with inline locks, that might be end
   up bloating the kernel quite a bit.
 - Documentation/ and comments mention cond_resched()
 - ftrace support for need-resched-lazy is incomplete

What needs more discussion:
 - Should cond_resched_lock() etc be scheduling out for TIF_NEED_RESCHED
   only or both TIF_NEED_RESCHED_LAZY as well? (See patch 35 "thread_info:
   change to tif_need_resched(resched_t)")
 - Tracking whether a task in userspace or in the kernel (See patch-40
   "context_tracking: add ct_state_cpu()")
 - The right model for preempt=voluntary. (See patch 44 "sched: voluntary
   preemption")


Performance
==

Expectation:

* perf sched bench pipe

preemption               full           none

6.6-rc7              6.68 +- 0.10   6.69 +- 0.07
+series              6.69 +- 0.12   6.67 +- 0.10

This is rescheduling out of idle which should and does perform identically.

* schbench, preempt=none

  * 1 group, 16 threads each

                 6.6-rc7      +series  
                 (usecs)      (usecs)
     50.0th:         6            6  
     90.0th:         8            7  
     99.0th:        11           11  
     99.9th:        15           14  
  
  * 8 groups, 16 threads each

                6.6-rc7       +series  
                 (usecs)      (usecs)
     50.0th:         6            6  
     90.0th:         8            8  
     99.0th:        12           11  
     99.9th:        20           21  


* schbench, preempt=full

  * 1 group, 16 threads each

                6.6-rc7       +series  
                (usecs)       (usecs)
     50.0th:         6            6  
     90.0th:         8            7  
     99.0th:        11           11  
     99.9th:        14           14  


  * 8 groups, 16 threads each

                6.6-rc7       +series  
                (usecs)       (usecs)
     50.0th:         7            7  
     90.0th:         9            9  
     99.0th:        12           12  
     99.9th:        21           22  


  Not much in it either way.

* kernbench, preempt=full

  * half-load (-j 128)

           6.6-rc7                                    +series                     

  wall        149.2  +-     27.2             wall        132.8  +-     0.4
  utime      8097.1  +-     57.4             utime      8088.5  +-    14.1
  stime      1165.5  +-      9.4             stime      1159.2  +-     1.9
  %cpu       6337.6  +-   1072.8             %cpu       6959.6  +-    22.8
  csw      237618    +-   2190.6             %csw     240343    +-  1386.8


  * optimal-load (-j 1024)

           6.6-rc7                                    +series                     

  wall        137.8 +-       0.0             wall       137.7  +-       0.8
  utime     11115.0 +-    3306.1             utime    11041.7  +-    3235.0
  stime      1340.0 +-     191.3             stime     1323.1  +-     179.5
  %cpu       8846.3 +-    2830.6             %cpu      9101.3  +-    2346.7
  csw     2099910   +- 2040080.0             csw    2068210    +- 2002450.0


  The preempt=full path should effectively not see any change in
  behaviour. The optimal-loads are pretty much identical.
  For the half-load, however, the +series version does much better but that
  seems to be because of much higher run to run variability in the 6.6-rc7 load.

* kernbench, preempt=none

  * half-load (-j 128)

           6.6-rc7                                    +series                     

  wall        134.5  +-      4.2             wall        133.6  +-     2.7
  utime      8093.3  +-     39.3             utime      8099.0  +-    38.9
  stime      1175.7  +-     10.6             stime      1169.1  +-     8.4
  %cpu       6893.3  +-    233.2             %cpu       6936.3  +-   142.8
  csw      240723    +-    423.0             %csw     173152    +-  1126.8
                                             

  * optimal-load (-j 1024)

           6.6-rc7                                    +series                     

  wall        139.2 +-       0.3             wall       138.8  +-       0.2
  utime     11161.0 +-    3360.4             utime    11061.2  +-    3244.9
  stime      1357.6 +-     199.3             stime     1366.6  +-     216.3
  %cpu       9108.8 +-    2431.4             %cpu      9081.0  +-    2351.1
  csw     2078599   +- 2013320.0             csw    1970610    +- 1969030.0


  For both of these the wallclock, utime, stime etc are pretty much
  identical. The one interesting difference is that the number of
  context switches are fewer. This intuitively makes sense given that
  we reschedule threads lazily rather than rescheduling if we encounter
  a cond_resched() and there's a thread wanting to be scheduled.

  The max-load numbers (not posted here) also behave similarly.


Series
==

With that, this is how he series is laid out:

 - Patches 01-30: revert the PREEMPT_DYNAMIC code. Most of the infrastructure
   used by that is via static_calls() and this is a simpler approach which
   doesn't need any of that (and does away with cond_resched().)

   Some of the commits will be resurrected.
       089c02ae2771 ("ftrace: Use preemption model accessors for trace header printout")
       cfe43f478b79 ("preempt/dynamic: Introduce preemption model accessors")
       5693fa74f98a ("kcsan: Use preemption model accessors")

 - Patches 31-45: contain the scheduler changes to do this. Of these
   the critical ones are:
     patch 35 "thread_info: change to tif_need_resched(resched_t)"
     patch 41 "sched: handle resched policy in resched_curr()"
     patch 43 "sched: enable PREEMPT_COUNT, PREEMPTION for all preemption models"
     patch 44 "sched: voluntary preemption"
      (this needs more work to decide when a higher sched-policy task
       should preempt a lower sched-policy task)
     patch 45 "preempt: ARCH_NO_PREEMPT only preempts lazily"

 - Patches 47-50: contain RCU related changes. RCU now works in both
   PREEMPT_RCU=y and PREEMPT_RCU=n modes with CONFIG_PREEMPTION.
   (Until now PREEMPTION=y => PREEMPT_RCU)

 - Patches 51-56,86: contain cond_resched() related cleanups.
     patch 54 "sched: add cond_resched_stall()" adds a new cond_resched()
     interface. Pitchforks?

 - Patches 57-86: remove cond_resched() from the tree.


Also at: github.com/terminus/linux preemption-rfc


Please review.

Thanks
Ankur

[1] https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/


Ankur Arora (86):
  Revert "riscv: support PREEMPT_DYNAMIC with static keys"
  Revert "sched/core: Make sched_dynamic_mutex static"
  Revert "ftrace: Use preemption model accessors for trace header
    printout"
  Revert "preempt/dynamic: Introduce preemption model accessors"
  Revert "kcsan: Use preemption model accessors"
  Revert "entry: Fix compile error in
    dynamic_irqentry_exit_cond_resched()"
  Revert "livepatch,sched: Add livepatch task switching to
    cond_resched()"
  Revert "arm64: Support PREEMPT_DYNAMIC"
  Revert "sched/preempt: Add PREEMPT_DYNAMIC using static keys"
  Revert "sched/preempt: Decouple HAVE_PREEMPT_DYNAMIC from
    GENERIC_ENTRY"
  Revert "sched/preempt: Simplify irqentry_exit_cond_resched() callers"
  Revert "sched/preempt: Refactor sched_dynamic_update()"
  Revert "sched/preempt: Move PREEMPT_DYNAMIC logic later"
  Revert "preempt/dynamic: Fix setup_preempt_mode() return value"
  Revert "preempt: Restore preemption model selection configs"
  Revert "sched: Provide Kconfig support for default dynamic preempt
    mode"
  sched/preempt: remove PREEMPT_DYNAMIC from the build version
  Revert "preempt/dynamic: Fix typo in macro conditional statement"
  Revert "sched,preempt: Move preempt_dynamic to debug.c"
  Revert "static_call: Relax static_call_update() function argument
    type"
  Revert "sched/core: Use -EINVAL in sched_dynamic_mode()"
  Revert "sched/core: Stop using magic values in sched_dynamic_mode()"
  Revert "sched,x86: Allow !PREEMPT_DYNAMIC"
  Revert "sched: Harden PREEMPT_DYNAMIC"
  Revert "sched: Add /debug/sched_preempt"
  Revert "preempt/dynamic: Support dynamic preempt with preempt= boot
    option"
  Revert "preempt/dynamic: Provide irqentry_exit_cond_resched() static
    call"
  Revert "preempt/dynamic: Provide preempt_schedule[_notrace]() static
    calls"
  Revert "preempt/dynamic: Provide cond_resched() and might_resched()
    static calls"
  Revert "preempt: Introduce CONFIG_PREEMPT_DYNAMIC"
  x86/thread_info: add TIF_NEED_RESCHED_LAZY
  entry: handle TIF_NEED_RESCHED_LAZY
  entry/kvm: handle TIF_NEED_RESCHED_LAZY
  thread_info: accessors for TIF_NEED_RESCHED*
  thread_info: change to tif_need_resched(resched_t)
  entry: irqentry_exit only preempts TIF_NEED_RESCHED
  sched: make test_*_tsk_thread_flag() return bool
  sched: *_tsk_need_resched() now takes resched_t
  sched: handle lazy resched in set_nr_*_polling()
  context_tracking: add ct_state_cpu()
  sched: handle resched policy in resched_curr()
  sched: force preemption on tick expiration
  sched: enable PREEMPT_COUNT, PREEMPTION for all preemption models
  sched: voluntary preemption
  preempt: ARCH_NO_PREEMPT only preempts lazily
  tracing: handle lazy resched
  rcu: select PREEMPT_RCU if PREEMPT
  rcu: handle quiescent states for PREEMPT_RCU=n
  osnoise: handle quiescent states directly
  rcu: TASKS_RCU does not need to depend on PREEMPTION
  preempt: disallow !PREEMPT_COUNT or !PREEMPTION
  sched: remove CONFIG_PREEMPTION from *_needbreak()
  sched: fixup __cond_resched_*()
  sched: add cond_resched_stall()
  xarray: add cond_resched_xas_rcu() and cond_resched_xas_lock_irq()
  xarray: use cond_resched_xas*()
  coccinelle: script to remove cond_resched()
  treewide: x86: remove cond_resched()
  treewide: rcu: remove cond_resched()
  treewide: torture: remove cond_resched()
  treewide: bpf: remove cond_resched()
  treewide: trace: remove cond_resched()
  treewide: futex: remove cond_resched()
  treewide: printk: remove cond_resched()
  treewide: task_work: remove cond_resched()
  treewide: kernel: remove cond_resched()
  treewide: kernel: remove cond_reshed()
  treewide: mm: remove cond_resched()
  treewide: io_uring: remove cond_resched()
  treewide: ipc: remove cond_resched()
  treewide: lib: remove cond_resched()
  treewide: crypto: remove cond_resched()
  treewide: security: remove cond_resched()
  treewide: fs: remove cond_resched()
  treewide: virt: remove cond_resched()
  treewide: block: remove cond_resched()
  treewide: netfilter: remove cond_resched()
  treewide: net: remove cond_resched()
  treewide: net: remove cond_resched()
  treewide: sound: remove cond_resched()
  treewide: md: remove cond_resched()
  treewide: mtd: remove cond_resched()
  treewide: drm: remove cond_resched()
  treewide: net: remove cond_resched()
  treewide: drivers: remove cond_resched()
  sched: remove cond_resched()

 .../admin-guide/kernel-parameters.txt         |   7 -
 arch/Kconfig                                  |  42 +-
 arch/arm64/Kconfig                            |   1 -
 arch/arm64/include/asm/preempt.h              |  19 +-
 arch/arm64/kernel/entry-common.c              |  10 +-
 arch/riscv/Kconfig                            |   1 -
 arch/s390/include/asm/preempt.h               |   4 +-
 arch/x86/Kconfig                              |   1 -
 arch/x86/include/asm/preempt.h                |  50 +-
 arch/x86/include/asm/thread_info.h            |   6 +-
 arch/x86/kernel/alternative.c                 |  10 -
 arch/x86/kernel/cpu/sgx/encl.c                |  14 +-
 arch/x86/kernel/cpu/sgx/ioctl.c               |   3 -
 arch/x86/kernel/cpu/sgx/main.c                |   5 -
 arch/x86/kernel/cpu/sgx/virt.c                |   4 -
 arch/x86/kvm/lapic.c                          |   6 +-
 arch/x86/kvm/mmu/mmu.c                        |   2 +-
 arch/x86/kvm/svm/sev.c                        |   5 +-
 arch/x86/net/bpf_jit_comp.c                   |   1 -
 arch/x86/net/bpf_jit_comp32.c                 |   1 -
 arch/x86/xen/mmu_pv.c                         |   1 -
 block/blk-cgroup.c                            |   2 -
 block/blk-lib.c                               |  11 -
 block/blk-mq.c                                |   3 -
 block/blk-zoned.c                             |   6 -
 crypto/internal.h                             |   2 +-
 crypto/tcrypt.c                               |   5 -
 crypto/testmgr.c                              |  10 -
 drivers/accel/ivpu/ivpu_drv.c                 |   2 -
 drivers/accel/ivpu/ivpu_gem.c                 |   1 -
 drivers/accel/ivpu/ivpu_pm.c                  |   8 +-
 drivers/accel/qaic/qaic_data.c                |   2 -
 drivers/acpi/processor_idle.c                 |   2 +-
 drivers/auxdisplay/charlcd.c                  |  11 -
 drivers/base/power/domain.c                   |   1 -
 drivers/block/aoe/aoecmd.c                    |   3 +-
 drivers/block/brd.c                           |   1 -
 drivers/block/drbd/drbd_bitmap.c              |   4 -
 drivers/block/drbd/drbd_debugfs.c             |   1 -
 drivers/block/loop.c                          |   3 -
 drivers/block/xen-blkback/blkback.c           |   3 -
 drivers/block/zram/zram_drv.c                 |   2 -
 drivers/bluetooth/virtio_bt.c                 |   1 -
 drivers/char/hw_random/arm_smccc_trng.c       |   1 -
 drivers/char/lp.c                             |   2 -
 drivers/char/mem.c                            |   4 -
 drivers/char/mwave/3780i.c                    |   4 +-
 drivers/char/ppdev.c                          |   4 -
 drivers/char/random.c                         |   2 -
 drivers/char/virtio_console.c                 |   1 -
 drivers/crypto/virtio/virtio_crypto_core.c    |   1 -
 drivers/cxl/pci.c                             |   1 -
 drivers/dma-buf/selftest.c                    |   1 -
 drivers/dma-buf/st-dma-fence-chain.c          |   1 -
 drivers/fsi/fsi-sbefifo.c                     |  14 +-
 drivers/gpu/drm/bridge/samsung-dsim.c         |   2 +-
 drivers/gpu/drm/drm_buddy.c                   |   1 -
 drivers/gpu/drm/drm_gem.c                     |   1 -
 .../gpu/drm/i915/gem/i915_gem_execbuffer.c    |   2 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.c    |   1 -
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c     |   2 -
 .../gpu/drm/i915/gem/selftests/huge_pages.c   |   6 -
 .../drm/i915/gem/selftests/i915_gem_mman.c    |   5 -
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c   |   2 +-
 drivers/gpu/drm/i915/gt/intel_gt.c            |   2 +-
 drivers/gpu/drm/i915/gt/intel_migrate.c       |   4 -
 drivers/gpu/drm/i915/gt/selftest_execlists.c  |   4 -
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c  |   2 -
 drivers/gpu/drm/i915/gt/selftest_lrc.c        |   2 -
 drivers/gpu/drm/i915/gt/selftest_migrate.c    |   2 -
 drivers/gpu/drm/i915/gt/selftest_timeline.c   |   4 -
 drivers/gpu/drm/i915/i915_active.c            |   2 +-
 drivers/gpu/drm/i915/i915_gem_evict.c         |   2 -
 drivers/gpu/drm/i915/i915_gpu_error.c         |  18 +-
 drivers/gpu/drm/i915/intel_uncore.c           |   1 -
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c |   2 -
 drivers/gpu/drm/i915/selftests/i915_request.c |   2 -
 .../gpu/drm/i915/selftests/i915_selftest.c    |   3 -
 drivers/gpu/drm/i915/selftests/i915_vma.c     |   9 -
 .../gpu/drm/i915/selftests/igt_flush_test.c   |   2 -
 .../drm/i915/selftests/intel_memory_region.c  |   4 -
 drivers/gpu/drm/tests/drm_buddy_test.c        |   5 -
 drivers/gpu/drm/tests/drm_mm_test.c           |  29 -
 drivers/i2c/busses/i2c-bcm-iproc.c            |   9 +-
 drivers/i2c/busses/i2c-highlander.c           |   9 +-
 drivers/i2c/busses/i2c-ibm_iic.c              |  11 +-
 drivers/i2c/busses/i2c-mpc.c                  |   2 +-
 drivers/i2c/busses/i2c-mxs.c                  |   9 +-
 drivers/i2c/busses/scx200_acb.c               |   9 +-
 drivers/infiniband/core/umem.c                |   1 -
 drivers/infiniband/hw/hfi1/driver.c           |   1 -
 drivers/infiniband/hw/hfi1/firmware.c         |   2 +-
 drivers/infiniband/hw/hfi1/init.c             |   1 -
 drivers/infiniband/hw/hfi1/ruc.c              |   1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |   5 +-
 drivers/infiniband/hw/qib/qib_init.c          |   1 -
 drivers/infiniband/sw/rxe/rxe_qp.c            |   3 +-
 drivers/infiniband/sw/rxe/rxe_task.c          |   4 +-
 drivers/input/evdev.c                         |   1 -
 drivers/input/keyboard/clps711x-keypad.c      |   2 +-
 drivers/input/misc/uinput.c                   |   1 -
 drivers/input/mousedev.c                      |   1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   2 -
 drivers/md/bcache/btree.c                     |   5 -
 drivers/md/bcache/journal.c                   |   2 -
 drivers/md/bcache/sysfs.c                     |   1 -
 drivers/md/bcache/writeback.c                 |   2 -
 drivers/md/dm-bufio.c                         |  14 -
 drivers/md/dm-cache-target.c                  |   4 -
 drivers/md/dm-crypt.c                         |   3 -
 drivers/md/dm-integrity.c                     |   3 -
 drivers/md/dm-kcopyd.c                        |   2 -
 drivers/md/dm-snap.c                          |   1 -
 drivers/md/dm-stats.c                         |   8 -
 drivers/md/dm-thin.c                          |   2 -
 drivers/md/dm-writecache.c                    |  11 -
 drivers/md/dm.c                               |   4 -
 drivers/md/md.c                               |   1 -
 drivers/md/raid1.c                            |   2 -
 drivers/md/raid10.c                           |   3 -
 drivers/md/raid5.c                            |   2 -
 drivers/media/i2c/vpx3220.c                   |   3 -
 drivers/media/pci/cobalt/cobalt-i2c.c         |   4 +-
 drivers/misc/bcm-vk/bcm_vk_dev.c              |   3 +-
 drivers/misc/bcm-vk/bcm_vk_msg.c              |   3 +-
 drivers/misc/genwqe/card_base.c               |   3 +-
 drivers/misc/genwqe/card_ddcb.c               |   6 -
 drivers/misc/genwqe/card_dev.c                |   2 -
 drivers/misc/vmw_balloon.c                    |   4 -
 drivers/mmc/host/mmc_spi.c                    |   3 -
 drivers/mtd/chips/cfi_cmdset_0001.c           |   6 -
 drivers/mtd/chips/cfi_cmdset_0002.c           |   1 -
 drivers/mtd/chips/cfi_util.c                  |   2 +-
 drivers/mtd/devices/spear_smi.c               |   2 +-
 drivers/mtd/devices/sst25l.c                  |   3 +-
 drivers/mtd/devices/st_spi_fsm.c              |   4 -
 drivers/mtd/inftlcore.c                       |   5 -
 drivers/mtd/lpddr/lpddr_cmds.c                |   6 +-
 drivers/mtd/mtd_blkdevs.c                     |   1 -
 drivers/mtd/nand/onenand/onenand_base.c       |  18 +-
 drivers/mtd/nand/onenand/onenand_samsung.c    |   8 +-
 drivers/mtd/nand/raw/diskonchip.c             |   4 +-
 drivers/mtd/nand/raw/fsmc_nand.c              |   3 +-
 drivers/mtd/nand/raw/hisi504_nand.c           |   2 +-
 drivers/mtd/nand/raw/nand_base.c              |   3 +-
 drivers/mtd/nand/raw/nand_legacy.c            |  17 +-
 drivers/mtd/spi-nor/core.c                    |   8 +-
 drivers/mtd/tests/mtd_test.c                  |   2 -
 drivers/mtd/tests/mtd_test.h                  |   2 +-
 drivers/mtd/tests/pagetest.c                  |   1 -
 drivers/mtd/tests/readtest.c                  |   2 -
 drivers/mtd/tests/torturetest.c               |   1 -
 drivers/mtd/ubi/attach.c                      |  10 -
 drivers/mtd/ubi/build.c                       |   2 -
 drivers/mtd/ubi/cdev.c                        |   4 -
 drivers/mtd/ubi/eba.c                         |   8 -
 drivers/mtd/ubi/misc.c                        |   2 -
 drivers/mtd/ubi/vtbl.c                        |   6 -
 drivers/mtd/ubi/wl.c                          |  13 -
 drivers/net/dummy.c                           |   1 -
 drivers/net/ethernet/broadcom/tg3.c           |   2 +-
 drivers/net/ethernet/intel/e1000/e1000_hw.c   |   3 -
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx4/catas.c    |   2 +-
 drivers/net/ethernet/mellanox/mlx4/cmd.c      |  13 +-
 .../ethernet/mellanox/mlx4/resource_tracker.c |   9 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |   3 +-
 drivers/net/ethernet/mellanox/mlxsw/i2c.c     |   5 -
 drivers/net/ethernet/mellanox/mlxsw/pci.c     |   2 -
 drivers/net/ethernet/pasemi/pasemi_mac.c      |   3 -
 .../ethernet/qlogic/netxen/netxen_nic_init.c  |   2 -
 .../ethernet/qlogic/qlcnic/qlcnic_83xx_init.c |   1 -
 .../net/ethernet/qlogic/qlcnic/qlcnic_init.c  |   1 -
 .../ethernet/qlogic/qlcnic/qlcnic_minidump.c  |   2 -
 drivers/net/ethernet/sfc/falcon/falcon.c      |   6 -
 drivers/net/ifb.c                             |   1 -
 drivers/net/ipvlan/ipvlan_core.c              |   1 -
 drivers/net/macvlan.c                         |   2 -
 drivers/net/mhi_net.c                         |   4 +-
 drivers/net/netdevsim/fib.c                   |   1 -
 drivers/net/virtio_net.c                      |   2 -
 drivers/net/wireguard/ratelimiter.c           |   2 -
 drivers/net/wireguard/receive.c               |   3 -
 drivers/net/wireguard/send.c                  |   4 -
 drivers/net/wireless/broadcom/b43/lo.c        |   6 +-
 drivers/net/wireless/broadcom/b43/pio.c       |   1 -
 drivers/net/wireless/broadcom/b43legacy/phy.c |   5 -
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |   1 -
 drivers/net/wireless/cisco/airo.c             |   2 -
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   2 -
 drivers/net/wireless/marvell/mwl8k.c          |   2 -
 drivers/net/wireless/mediatek/mt76/util.c     |   1 -
 drivers/net/wwan/mhi_wwan_mbim.c              |   2 +-
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c    |   3 -
 drivers/net/xen-netback/netback.c             |   1 -
 drivers/net/xen-netback/rx.c                  |   2 -
 drivers/nvdimm/btt.c                          |   2 -
 drivers/nvme/target/zns.c                     |   2 -
 drivers/parport/parport_ip32.c                |   1 -
 drivers/parport/parport_pc.c                  |   4 -
 drivers/pci/pci-sysfs.c                       |   1 -
 drivers/pci/proc.c                            |   1 -
 .../intel/speed_select_if/isst_if_mbox_pci.c  |   4 +-
 drivers/s390/cio/css.c                        |   8 -
 drivers/scsi/NCR5380.c                        |   2 -
 drivers/scsi/megaraid.c                       |   1 -
 drivers/scsi/qedi/qedi_main.c                 |   1 -
 drivers/scsi/qla2xxx/qla_nx.c                 |   2 -
 drivers/scsi/qla2xxx/qla_sup.c                |   5 -
 drivers/scsi/qla4xxx/ql4_nx.c                 |   1 -
 drivers/scsi/xen-scsifront.c                  |   2 +-
 drivers/spi/spi-lantiq-ssc.c                  |   3 +-
 drivers/spi/spi-meson-spifc.c                 |   2 +-
 drivers/spi/spi.c                             |   2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |   2 +-
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  |   2 -
 drivers/tee/optee/ffa_abi.c                   |   1 -
 drivers/tee/optee/smc_abi.c                   |   1 -
 drivers/tty/hvc/hvc_console.c                 |   6 +-
 drivers/tty/tty_buffer.c                      |   3 -
 drivers/tty/tty_io.c                          |   1 -
 drivers/usb/gadget/udc/max3420_udc.c          |   1 -
 drivers/usb/host/max3421-hcd.c                |   2 +-
 drivers/usb/host/xen-hcd.c                    |   2 +-
 drivers/vfio/vfio_iommu_spapr_tce.c           |   2 -
 drivers/vfio/vfio_iommu_type1.c               |   7 -
 drivers/vhost/vhost.c                         |   1 -
 drivers/video/console/vgacon.c                |   4 -
 drivers/virtio/virtio_mem.c                   |   8 -
 drivers/xen/balloon.c                         |   2 -
 drivers/xen/gntdev.c                          |   2 -
 drivers/xen/xen-scsiback.c                    |   9 +-
 fs/afs/write.c                                |   2 -
 fs/btrfs/backref.c                            |   6 -
 fs/btrfs/block-group.c                        |   3 -
 fs/btrfs/ctree.c                              |   1 -
 fs/btrfs/defrag.c                             |   1 -
 fs/btrfs/disk-io.c                            |   3 -
 fs/btrfs/extent-io-tree.c                     |   5 -
 fs/btrfs/extent-tree.c                        |   8 -
 fs/btrfs/extent_io.c                          |   9 -
 fs/btrfs/file-item.c                          |   1 -
 fs/btrfs/file.c                               |   4 -
 fs/btrfs/free-space-cache.c                   |   4 -
 fs/btrfs/inode.c                              |   9 -
 fs/btrfs/ordered-data.c                       |   2 -
 fs/btrfs/qgroup.c                             |   1 -
 fs/btrfs/reflink.c                            |   2 -
 fs/btrfs/relocation.c                         |   9 -
 fs/btrfs/scrub.c                              |   3 -
 fs/btrfs/send.c                               |   1 -
 fs/btrfs/space-info.c                         |   1 -
 fs/btrfs/tests/extent-io-tests.c              |   1 -
 fs/btrfs/transaction.c                        |   3 -
 fs/btrfs/tree-log.c                           |  12 -
 fs/btrfs/uuid-tree.c                          |   1 -
 fs/btrfs/volumes.c                            |   2 -
 fs/buffer.c                                   |   1 -
 fs/cachefiles/cache.c                         |   4 +-
 fs/cachefiles/namei.c                         |   1 -
 fs/cachefiles/volume.c                        |   1 -
 fs/ceph/addr.c                                |   1 -
 fs/dax.c                                      |  16 +-
 fs/dcache.c                                   |   2 -
 fs/dlm/ast.c                                  |   1 -
 fs/dlm/dir.c                                  |   2 -
 fs/dlm/lock.c                                 |   3 -
 fs/dlm/lowcomms.c                             |   3 -
 fs/dlm/recover.c                              |   1 -
 fs/drop_caches.c                              |   1 -
 fs/erofs/utils.c                              |   1 -
 fs/erofs/zdata.c                              |   8 +-
 fs/eventpoll.c                                |   3 -
 fs/exec.c                                     |   4 -
 fs/ext4/block_validity.c                      |   2 -
 fs/ext4/dir.c                                 |   1 -
 fs/ext4/extents.c                             |   1 -
 fs/ext4/ialloc.c                              |   1 -
 fs/ext4/inode.c                               |   1 -
 fs/ext4/mballoc.c                             |  12 +-
 fs/ext4/namei.c                               |   3 -
 fs/ext4/orphan.c                              |   1 -
 fs/ext4/super.c                               |   2 -
 fs/f2fs/checkpoint.c                          |  16 +-
 fs/f2fs/compress.c                            |   1 -
 fs/f2fs/data.c                                |   3 -
 fs/f2fs/dir.c                                 |   1 -
 fs/f2fs/extent_cache.c                        |   1 -
 fs/f2fs/f2fs.h                                |   6 +-
 fs/f2fs/file.c                                |   3 -
 fs/f2fs/node.c                                |   4 -
 fs/f2fs/super.c                               |   1 -
 fs/fat/fatent.c                               |   2 -
 fs/file.c                                     |   7 +-
 fs/fs-writeback.c                             |   3 -
 fs/gfs2/aops.c                                |   1 -
 fs/gfs2/bmap.c                                |   2 -
 fs/gfs2/glock.c                               |   2 +-
 fs/gfs2/log.c                                 |   1 -
 fs/gfs2/ops_fstype.c                          |   1 -
 fs/hpfs/buffer.c                              |   8 -
 fs/hugetlbfs/inode.c                          |   3 -
 fs/inode.c                                    |   3 -
 fs/iomap/buffered-io.c                        |   7 +-
 fs/jbd2/checkpoint.c                          |   2 -
 fs/jbd2/commit.c                              |   3 -
 fs/jbd2/recovery.c                            |   2 -
 fs/jffs2/build.c                              |   6 +-
 fs/jffs2/erase.c                              |   3 -
 fs/jffs2/gc.c                                 |   2 -
 fs/jffs2/nodelist.c                           |   1 -
 fs/jffs2/nodemgmt.c                           |  11 +-
 fs/jffs2/readinode.c                          |   2 -
 fs/jffs2/scan.c                               |   4 -
 fs/jffs2/summary.c                            |   2 -
 fs/jfs/jfs_txnmgr.c                           |  14 +-
 fs/libfs.c                                    |   5 +-
 fs/mbcache.c                                  |   1 -
 fs/namei.c                                    |   1 -
 fs/netfs/io.c                                 |   1 -
 fs/nfs/delegation.c                           |   3 -
 fs/nfs/pnfs.c                                 |   2 -
 fs/nfs/write.c                                |   4 -
 fs/nilfs2/btree.c                             |   1 -
 fs/nilfs2/inode.c                             |   1 -
 fs/nilfs2/page.c                              |   4 -
 fs/nilfs2/segment.c                           |   4 -
 fs/notify/fanotify/fanotify_user.c            |   1 -
 fs/notify/fsnotify.c                          |   1 -
 fs/ntfs/attrib.c                              |   3 -
 fs/ntfs/file.c                                |   2 -
 fs/ntfs3/file.c                               |   9 -
 fs/ntfs3/frecord.c                            |   2 -
 fs/ocfs2/alloc.c                              |   4 +-
 fs/ocfs2/cluster/tcp.c                        |   8 +-
 fs/ocfs2/dlm/dlmthread.c                      |   7 +-
 fs/ocfs2/file.c                               |  10 +-
 fs/proc/base.c                                |   1 -
 fs/proc/fd.c                                  |   1 -
 fs/proc/kcore.c                               |   1 -
 fs/proc/page.c                                |   6 -
 fs/proc/task_mmu.c                            |   7 -
 fs/quota/dquot.c                              |   1 -
 fs/reiserfs/journal.c                         |   2 -
 fs/select.c                                   |   1 -
 fs/smb/client/file.c                          |   2 -
 fs/splice.c                                   |   1 -
 fs/ubifs/budget.c                             |   1 -
 fs/ubifs/commit.c                             |   1 -
 fs/ubifs/debug.c                              |   5 -
 fs/ubifs/dir.c                                |   1 -
 fs/ubifs/gc.c                                 |   5 -
 fs/ubifs/io.c                                 |   2 -
 fs/ubifs/lprops.c                             |   2 -
 fs/ubifs/lpt_commit.c                         |   3 -
 fs/ubifs/orphan.c                             |   1 -
 fs/ubifs/recovery.c                           |   4 -
 fs/ubifs/replay.c                             |   7 -
 fs/ubifs/scan.c                               |   2 -
 fs/ubifs/shrinker.c                           |   1 -
 fs/ubifs/super.c                              |   2 -
 fs/ubifs/tnc_commit.c                         |   2 -
 fs/ubifs/tnc_misc.c                           |   1 -
 fs/userfaultfd.c                              |   9 -
 fs/verity/enable.c                            |   1 -
 fs/verity/read_metadata.c                     |   1 -
 fs/xfs/scrub/common.h                         |   7 -
 fs/xfs/scrub/xfarray.c                        |   7 -
 fs/xfs/xfs_aops.c                             |   1 -
 fs/xfs/xfs_icache.c                           |   2 -
 fs/xfs/xfs_iwalk.c                            |   1 -
 include/asm-generic/preempt.h                 |  18 +-
 include/linux/console.h                       |   2 +-
 include/linux/context_tracking_state.h        |  21 +
 include/linux/entry-common.h                  |  19 +-
 include/linux/entry-kvm.h                     |   2 +-
 include/linux/kernel.h                        |  32 +-
 include/linux/livepatch.h                     |   1 -
 include/linux/livepatch_sched.h               |  29 -
 include/linux/preempt.h                       |  44 +-
 include/linux/rcupdate.h                      |  10 +-
 include/linux/rcutree.h                       |   2 +-
 include/linux/sched.h                         | 153 ++----
 include/linux/sched/cond_resched.h            |   1 -
 include/linux/sched/idle.h                    |   8 +-
 include/linux/thread_info.h                   |  29 +-
 include/linux/trace_events.h                  |   6 +-
 include/linux/vermagic.h                      |   2 +-
 include/linux/xarray.h                        |  14 +
 init/Makefile                                 |   3 +-
 io_uring/io-wq.c                              |   4 +-
 io_uring/io_uring.c                           |  21 +-
 io_uring/kbuf.c                               |   2 -
 io_uring/sqpoll.c                             |   6 +-
 io_uring/tctx.c                               |   4 +-
 ipc/msgutil.c                                 |   3 -
 ipc/sem.c                                     |   2 -
 kernel/Kconfig.preempt                        |  70 +--
 kernel/auditsc.c                              |   2 -
 kernel/bpf/Kconfig                            |   2 +-
 kernel/bpf/arraymap.c                         |   3 -
 kernel/bpf/bpf_iter.c                         |   7 +-
 kernel/bpf/btf.c                              |   9 -
 kernel/bpf/cpumap.c                           |   2 -
 kernel/bpf/hashtab.c                          |   7 -
 kernel/bpf/syscall.c                          |   3 -
 kernel/bpf/verifier.c                         |   5 -
 kernel/cgroup/rstat.c                         |   3 +-
 kernel/dma/debug.c                            |   2 -
 kernel/entry/common.c                         |  32 +-
 kernel/entry/kvm.c                            |   4 +-
 kernel/events/core.c                          |   2 +-
 kernel/futex/core.c                           |   6 +-
 kernel/futex/pi.c                             |   6 +-
 kernel/futex/requeue.c                        |   1 -
 kernel/futex/waitwake.c                       |   2 +-
 kernel/gcov/base.c                            |   1 -
 kernel/hung_task.c                            |   6 +-
 kernel/kallsyms.c                             |   4 +-
 kernel/kcsan/kcsan_test.c                     |   5 +-
 kernel/kexec_core.c                           |   6 -
 kernel/kthread.c                              |   1 -
 kernel/livepatch/core.c                       |   1 -
 kernel/livepatch/transition.c                 | 107 +---
 kernel/locking/test-ww_mutex.c                |   4 +-
 kernel/module/main.c                          |   1 -
 kernel/printk/printk.c                        |  65 +--
 kernel/ptrace.c                               |   2 -
 kernel/rcu/Kconfig                            |   4 +-
 kernel/rcu/rcuscale.c                         |   2 -
 kernel/rcu/rcutorture.c                       |   8 +-
 kernel/rcu/tasks.h                            |   5 +-
 kernel/rcu/tree.c                             |   4 +-
 kernel/rcu/tree_exp.h                         |   4 +-
 kernel/rcu/tree_plugin.h                      |   7 +-
 kernel/rcu/tree_stall.h                       |   2 +-
 kernel/scftorture.c                           |   1 -
 kernel/sched/core.c                           | 497 +++++-------------
 kernel/sched/core_sched.c                     |   2 +-
 kernel/sched/deadline.c                       |  26 +-
 kernel/sched/debug.c                          |  67 +--
 kernel/sched/fair.c                           |  54 +-
 kernel/sched/features.h                       |  18 +
 kernel/sched/idle.c                           |   6 +-
 kernel/sched/rt.c                             |  35 +-
 kernel/sched/sched.h                          |   9 +-
 kernel/softirq.c                              |   1 -
 kernel/stop_machine.c                         |   2 +-
 kernel/task_work.c                            |   1 -
 kernel/torture.c                              |   1 -
 kernel/trace/Kconfig                          |   4 +-
 kernel/trace/ftrace.c                         |   4 -
 kernel/trace/ring_buffer.c                    |   4 -
 kernel/trace/ring_buffer_benchmark.c          |  13 -
 kernel/trace/trace.c                          |  29 +-
 kernel/trace/trace_events.c                   |   1 -
 kernel/trace/trace_osnoise.c                  |  37 +-
 kernel/trace/trace_output.c                   |  16 +-
 kernel/trace/trace_selftest.c                 |   9 -
 kernel/workqueue.c                            |  10 -
 lib/crc32test.c                               |   2 -
 lib/crypto/mpi/mpi-pow.c                      |   1 -
 lib/memcpy_kunit.c                            |   5 -
 lib/random32.c                                |   1 -
 lib/rhashtable.c                              |   2 -
 lib/test_bpf.c                                |   3 -
 lib/test_lockup.c                             |   2 +-
 lib/test_maple_tree.c                         |   8 -
 lib/test_rhashtable.c                         |  10 -
 mm/backing-dev.c                              |   8 +-
 mm/compaction.c                               |  23 +-
 mm/damon/paddr.c                              |   1 -
 mm/dmapool_test.c                             |   2 -
 mm/filemap.c                                  |  11 +-
 mm/gup.c                                      |   1 -
 mm/huge_memory.c                              |   3 -
 mm/hugetlb.c                                  |  12 -
 mm/hugetlb_cgroup.c                           |   1 -
 mm/kasan/quarantine.c                         |   6 +-
 mm/kfence/kfence_test.c                       |  22 +-
 mm/khugepaged.c                               |  10 +-
 mm/kmemleak.c                                 |   8 -
 mm/ksm.c                                      |  21 +-
 mm/madvise.c                                  |   3 -
 mm/memcontrol.c                               |   4 -
 mm/memfd.c                                    |  10 +-
 mm/memory-failure.c                           |   1 -
 mm/memory.c                                   |  12 +-
 mm/memory_hotplug.c                           |   6 -
 mm/mempolicy.c                                |   1 -
 mm/migrate.c                                  |   6 -
 mm/mincore.c                                  |   1 -
 mm/mlock.c                                    |   2 -
 mm/mm_init.c                                  |  13 +-
 mm/mmap.c                                     |   1 -
 mm/mmu_gather.c                               |   2 -
 mm/mprotect.c                                 |   1 -
 mm/mremap.c                                   |   1 -
 mm/nommu.c                                    |   1 -
 mm/page-writeback.c                           |   6 +-
 mm/page_alloc.c                               |  13 +-
 mm/page_counter.c                             |   1 -
 mm/page_ext.c                                 |   1 -
 mm/page_idle.c                                |   2 -
 mm/page_io.c                                  |   2 -
 mm/page_owner.c                               |   1 -
 mm/percpu.c                                   |   5 -
 mm/rmap.c                                     |   2 -
 mm/shmem.c                                    |  19 +-
 mm/shuffle.c                                  |   6 +-
 mm/slab.c                                     |   3 -
 mm/swap_cgroup.c                              |   4 -
 mm/swapfile.c                                 |  14 -
 mm/truncate.c                                 |   4 -
 mm/userfaultfd.c                              |   3 -
 mm/util.c                                     |   1 -
 mm/vmalloc.c                                  |   5 -
 mm/vmscan.c                                   |  29 +-
 mm/vmstat.c                                   |   4 -
 mm/workingset.c                               |   1 -
 mm/z3fold.c                                   |  15 +-
 mm/zsmalloc.c                                 |   1 -
 mm/zswap.c                                    |   1 -
 net/batman-adv/tp_meter.c                     |   2 -
 net/bpf/test_run.c                            |   1 -
 net/bridge/br_netlink.c                       |   1 -
 net/core/dev.c                                |   4 -
 net/core/neighbour.c                          |   1 -
 net/core/net_namespace.c                      |   1 -
 net/core/netclassid_cgroup.c                  |   1 -
 net/core/rtnetlink.c                          |   1 -
 net/core/sock.c                               |   2 -
 net/ipv4/inet_connection_sock.c               |   3 -
 net/ipv4/inet_diag.c                          |   1 -
 net/ipv4/inet_hashtables.c                    |   1 -
 net/ipv4/inet_timewait_sock.c                 |   1 -
 net/ipv4/inetpeer.c                           |   1 -
 net/ipv4/netfilter/arp_tables.c               |   2 -
 net/ipv4/netfilter/ip_tables.c                |   3 -
 net/ipv4/nexthop.c                            |   1 -
 net/ipv4/tcp_ipv4.c                           |   2 -
 net/ipv4/udp.c                                |   2 -
 net/ipv6/fib6_rules.c                         |   1 -
 net/ipv6/netfilter/ip6_tables.c               |   2 -
 net/ipv6/udp.c                                |   2 -
 net/mptcp/mptcp_diag.c                        |   2 -
 net/mptcp/pm_netlink.c                        |   5 -
 net/mptcp/protocol.c                          |   1 -
 net/netfilter/ipset/ip_set_core.c             |   1 -
 net/netfilter/ipvs/ip_vs_est.c                |   3 -
 net/netfilter/nf_conncount.c                  |   2 -
 net/netfilter/nf_conntrack_core.c             |   3 -
 net/netfilter/nf_conntrack_ecache.c           |   3 -
 net/netfilter/nf_tables_api.c                 |   2 -
 net/netfilter/nft_set_rbtree.c                |   2 -
 net/netfilter/x_tables.c                      |   3 +-
 net/netfilter/xt_hashlimit.c                  |   1 -
 net/netlink/af_netlink.c                      |   1 -
 net/rds/ib_recv.c                             |   2 -
 net/rds/tcp.c                                 |   2 +-
 net/rds/threads.c                             |   1 -
 net/rxrpc/call_object.c                       |   2 +-
 net/sched/sch_api.c                           |   3 -
 net/sctp/socket.c                             |   1 -
 net/socket.c                                  |   2 -
 net/sunrpc/cache.c                            |  11 +-
 net/sunrpc/sched.c                            |   2 +-
 net/sunrpc/svc_xprt.c                         |   1 -
 net/sunrpc/xprtsock.c                         |   2 -
 net/tipc/core.c                               |   2 +-
 net/tipc/topsrv.c                             |   3 -
 net/unix/af_unix.c                            |   5 +-
 net/x25/af_x25.c                              |   1 -
 scripts/coccinelle/api/cond_resched.cocci     |  53 ++
 security/keys/gc.c                            |   1 -
 security/landlock/fs.c                        |   1 -
 security/selinux/ss/hashtab.h                 |   2 -
 security/selinux/ss/policydb.c                |   6 -
 security/selinux/ss/services.c                |   1 -
 security/selinux/ss/sidtab.c                  |   1 -
 sound/arm/aaci.c                              |   2 +-
 sound/core/seq/seq_virmidi.c                  |   2 -
 sound/hda/hdac_controller.c                   |   1 -
 sound/isa/sb/emu8000_patch.c                  |   5 -
 sound/isa/sb/emu8000_pcm.c                    |   2 +-
 sound/isa/wss/wss_lib.c                       |   1 -
 sound/pci/echoaudio/echoaudio_dsp.c           |   2 -
 sound/pci/ens1370.c                           |   1 -
 sound/pci/es1968.c                            |   2 +-
 sound/pci/lola/lola.c                         |   1 -
 sound/pci/mixart/mixart_hwdep.c               |   2 +-
 sound/pci/pcxhr/pcxhr_core.c                  |   5 -
 sound/pci/vx222/vx222_ops.c                   |   2 -
 sound/x86/intel_hdmi_audio.c                  |   1 -
 virt/kvm/pfncache.c                           |   2 -
 596 files changed, 881 insertions(+), 2813 deletions(-)
 delete mode 100644 include/linux/livepatch_sched.h
 delete mode 100644 include/linux/sched/cond_resched.h
 create mode 100644 scripts/coccinelle/api/cond_resched.cocci

-- 
2.31.1

