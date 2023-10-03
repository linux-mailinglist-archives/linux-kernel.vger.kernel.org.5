Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5A27B62A3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjJCHke convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 03:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239205AbjJCHkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:40:31 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Oct 2023 00:40:28 PDT
Received: from esa.hc3777-42.iphmx.com (esa.hc3777-42.iphmx.com [216.71.141.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43419AD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 00:40:28 -0700 (PDT)
X-CSE-ConnectionGUID: ZpVt91IETGW0rUWKc3MhRA==
X-CSE-MsgGUID: pD1a42v1Toq8Jwiss/0bJw==
X-IronPort-RemoteIP: 40.93.10.14
X-IronPort-MID: 10732840
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: O365_Users_Outgoing_Mail
X-IronPort-MailFlowPolicy: $O365_Users_Outgoing_Mail
Received: from mail-westus2azlp17011014.outbound.protection.outlook.com (HELO CO1PR02CU001.outbound.protection.outlook.com) ([40.93.10.14])
  by ob1.hc3777-42.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Oct 2023 03:39:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrh+0eF5J4RlWMAOpyZaoVnLuIc9FzXiPiYzo0zWF0mpbNm9lO6sTt3ht1FDnKOvMxJHM3MR7WUrCbkaq5Zw7gvzAQRZa1VBznclXXutmSzAmXl3tQCXu5oVIleBa9HjmA5NaN4jVGqpBrG/Td7mhLJzaVRws7hh9LZBol70/1TxfWmS+TOCi3S/xVP1ujdng4/s7Mj6glRldbXOamUlaYcX69AXnH/R1BCmSdnOYNvT1EK7DjAwSDTCNrP6b8Rqb7ngvhbOVmapZFoE8zfR7URrSyMiewuQLSso9Nm/2P35JW8K9f9tQ7J4bhJSmLtXfeO0nyBJaxvDqdl0mySGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAaMSgjybMoCYsqoquI/UJLzJidoz9kcrlJo3w/5WKA=;
 b=av6HiB7ZP+tSVWsEu2MwU7jQPUIOl1BOxra//x4FuNlN4s02mowh0Ba2iJuh8ZVFcU7UBtZ4xP79tHy5y6gq+m+Y8G3PFY5Up+AvrJojbUbpGpfNGSlpM+l4B3Ydg176znisw+6H2KvYvWmJPv3t4jq8lIlLIcooXuZguRBXmJz12qnDkTneYBdaakD+JgbwcgpJKAo5eGhBY232jvykLqIPceLitbsq1mUyWhm5YokhqxoeB49eYvUbhb2iGmAVeGJfNkNaiYvnXrrZfWmkpOyNNlox2xDUCrL28tAAaoyTHWUx0roWmY3tdOazHLnFv+fbJlnfTotyF30MMh2MGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 146.91.48.123) smtp.rcpttodomain=xidtech.com smtp.mailfrom=xmails.me;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=xmails.me;
 dkim=none (message not signed); arc=none
Received: from MN2PR06CA0026.namprd06.prod.outlook.com (2603:10b6:208:23d::31)
 by IA1PR05MB10031.namprd05.prod.outlook.com (2603:10b6:208:3f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Tue, 3 Oct
 2023 07:39:18 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::4e) by MN2PR06CA0026.outlook.office365.com
 (2603:10b6:208:23d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.32 via Frontend
 Transport; Tue, 3 Oct 2023 07:39:18 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 146.91.48.123) smtp.mailfrom=XMAILS.ME; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=XMAILS.ME;
Received: from ACDCSWPAPP748.cummins.svcnet (146.91.48.123) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 07:39:17 +0000
Received: from [185.225.73.120] (185.225.73.120) by
 ACDCSWPAPP748.cummins.svcnet (10.208.14.101) with Microsoft SMTP Server id
 15.0.1497.42; Tue, 3 Oct 2023 02:39:01 -0500
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: Dear Respectfully,
To:     Recipients <SUPPORT@XMAILS.ME>
From:   Ahmad Mualla <SUPPORT@XMAILS.ME>
Date:   Tue, 3 Oct 2023 00:38:55 -0700
Reply-To: <engr.dr.ahmadmualla@yandex.com>
Message-ID: <45c043855b7d46cfbe3599b3e0757f00@ACDCSWPAPP748.cummins.svcnet>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|IA1PR05MB10031:EE_
X-MS-Office365-Filtering-Correlation-Id: a867f1c7-db63-421d-f839-08dbc3e3d996
AntiSpoofAllow: True
AllowCheck1: True
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?6olydMdRcAaKjxGpRLjA1FTIOQi3v9N1UDHiLgF0iUPFaLgpj9nC7Qgz/D?=
 =?iso-8859-1?Q?rphiubdmJWcb09wAOK4xquEFWZrgsCVlIdsnUfGlsTd53GYR4zRWhB1soy?=
 =?iso-8859-1?Q?PpelILAQN2TBsyXj5Fn/7bCm6jmKLXW3VA+io0yLmcEeJILOQxpYWvmIf+?=
 =?iso-8859-1?Q?qRoqJTqEaPMPFnMjW+SHhJ755kZJYvRvFiBWbpNWqzYIWlc/AQeR5jYh17?=
 =?iso-8859-1?Q?rsBy5+EU+QsrX+WKqx1BqELLXcG7+jqbne4F4q6mOEMUa6y3ecrDh6ytCF?=
 =?iso-8859-1?Q?RknLfCgMLu4a509v/YuxbUUuSZW1/cR4cnF0K3dqT4gTdjKJBAxYE+ZNmM?=
 =?iso-8859-1?Q?iQ2ME+bbLp1+At7QlR4ZOsLwldwqVC+HQXjFtfY7ZPU0Nf5OHqpLTObN4w?=
 =?iso-8859-1?Q?SNBtwGggL5+CvuzJ24lWDovO/gb0WSVtFgYNroZ2kca9cTypKgbAIVkyuC?=
 =?iso-8859-1?Q?1LSoNE/um/gqUg5flH7AOO0TeYYp9OYuWHm6/YkFuGxvl0qXgDlVLYgMMV?=
 =?iso-8859-1?Q?ydddJJwab8XgyEhtG2xVvYb7nF9D1aLCQ6eEZeq3EgU23u5g96+LEu7RAc?=
 =?iso-8859-1?Q?IIGPQakM2waAStfsLy94ICxcQLmjQrqfFiOQJFSnIjZt7UvPXEymNIp/qp?=
 =?iso-8859-1?Q?Y3plBC+pqqFjVPcHjQFHz2437/xnnbJQuvgwDSvvLq0PdoDM1R5rkq4FPR?=
 =?iso-8859-1?Q?ZCRnsKk7ducRczJ3UIHHNqlep1KpWU5J/RE6Hr6fAMZ0jPEXlQyzNbzaS+?=
 =?iso-8859-1?Q?HCFSqdFyIr2ofFxuIHrwS+D/EvBuXkBUIhl8HYYBVzJnIu9F3fnqFbblVC?=
 =?iso-8859-1?Q?515daVWf9xTSHy6HzgCz+9ybIpQnzEcnp+9czEZ7TXYfSiAh8NtPHW5gFg?=
 =?iso-8859-1?Q?5mhmGQwwY4oQI03V+ZjJJr+jJ3ObPP0poEtLp0UC6vkcrUoV16g8ASWB3U?=
 =?iso-8859-1?Q?X7drC2wXqvANh95ebiGyoxZuAcIWnV6Sy4ffTp8lvV3wBb70EY0Sop27Q/?=
 =?iso-8859-1?Q?EtHL1RapDVfacEmnISrJ017ococs9L6S9d5E+5UORFWbaZqtHxWZMMF3lK?=
 =?iso-8859-1?Q?hYKraxgoy1VnOV3963L8kcBEOZuODcEMaVVPYqeV911BtZNGFS3IVKvEu6?=
 =?iso-8859-1?Q?SSg7AepN/bRxXgEA4Tn1ddXdDW4FhSHm9gLwgOnwhmURff6lonI8UtyTOD?=
 =?iso-8859-1?Q?Yr2yTaoe5EUHKxcPMU4xXZL2MzFAlpPb5RrOM3tzH3mwNEPDRCEe2COlW0?=
 =?iso-8859-1?Q?zhl7Hh+gz/56qx5F+JrWKESo8k2WulPF1tHTN9Kpwv4TOV1WZ2w1tbhmNP?=
 =?iso-8859-1?Q?vZ/6?=
X-Forefront-Antispam-Report: CIP:146.91.48.123;CTRY:US;LANG:en;SCL:5;SRV:;IPV:CAL;SFV:SPM;H:ACDCSWPAPP748.cummins.svcnet;PTR:InfoDomainNonexistent;CAT:OSPM;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(61400799006)(48200799006)(46966006)(40470700004)(9686003)(24736004)(108616005)(956004)(508600001)(40460700003)(82740400003)(356005)(82960400001)(81166007)(86362001)(40480700001)(6706004)(3480700007)(35950700001)(7416002)(7366002)(26005)(4744005)(7406005)(83380400001)(2906002)(47076005)(6666004)(8676002)(336012)(316002)(169323002)(6862004)(8936002)(7116003)(41300700001)(2860700004)(6200100001)(16576012)(70586007)(70206006)(5660300002)(62346018);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?G1taAw9XLUlBpF1EdCFUoj0zNpUjeo0IuFIpd3muZ9dI3DwF3LOJE+gpPa?=
 =?iso-8859-1?Q?gTQHu7SFW/O85X1qkzmbH2KZHluyDncaGw4can0UYqMTly32L4R7UTzBaw?=
 =?iso-8859-1?Q?tRKhi767bAb3D4ANs7TYn3h3cCB64h58N8Ees6ZAgfrNG/Qj6A3U/6dbvU?=
 =?iso-8859-1?Q?LTBEQvqNxpTuLykb7D8QeghAHZu5d/eYEtzVBPWK+vJWz8YY5DGMtDEd0A?=
 =?iso-8859-1?Q?jtbvsf7ZoQsg9/xwICpKwL4zM3qlEDJeVYg70Mo3xLrhNtge2rSwOU7tpa?=
 =?iso-8859-1?Q?9i+GWVBzi57Fpyl56O7OcEi48PPoUGnWvy4GFLSsMfuRoEmgRlvoGQ+6mc?=
 =?iso-8859-1?Q?nZn1LyFZfr/ozrZdDmDQ2vykMTCeRYFbwqmpO7+ZTnnIHZl8irOg7ONNJ2?=
 =?iso-8859-1?Q?+BW63zfeQV+Mo6Ud+WDIL1v5jcUfN+R4bZR9rt7hr1YfxJJtWrDUyO2QbO?=
 =?iso-8859-1?Q?3i6ZD3KhZaZCm48SbZL1rPp6e6xkXrVx9EaKu5xLwwQMKKUjL77U/fVEN8?=
 =?iso-8859-1?Q?YhWZMInldV74sAGp3lj+Bq8lNZNLoD4PTzlSArB4g04u6RSYnkFzYvGEMH?=
 =?iso-8859-1?Q?uHIiFyrCM68NE0tFdn9CzCnsWltALC7PUP3UydzZD6hTZcoVF20Y6CDNMD?=
 =?iso-8859-1?Q?FXic3rsuTgXeTic3WAI+nFreABcL+3IjazYteYkN5vmyjgsQT7ILlLO0dV?=
 =?iso-8859-1?Q?6XOLRKqYD5oCafH37Bx96H//FE1a+o0jk1lWK0wu5JVx8c0YEEGHiKhRrG?=
 =?iso-8859-1?Q?zKaHwNTtV1hoZAzabVZIiXdV5gt8in3KNpUnuxddn59xWssowXdvnx9uuR?=
 =?iso-8859-1?Q?YDfbu0oRSRpyVVqReNzHKiZh8mnMKsUFrsVk+6JcynmGv+0hwf0jUPbnYj?=
 =?iso-8859-1?Q?B6tE3+n0g82nQZ6KtEsz1+cpqj2zr3U4tGB8ewwcuYYOOyvJj0KDvVndSg?=
 =?iso-8859-1?Q?Axv+EMucmukv50hX6k2aye4HcMHitggCu/Leg/rBFUtfEy8HZMIVrgkjvj?=
 =?iso-8859-1?Q?hT7O7T+Pu3wAD3/prac0kp2/6rJSezvAqAT9b0QzcqhTWVcn9EJAywF34X?=
 =?iso-8859-1?Q?aR9tYNFmowEh5d7GY6HY7FvIron6/uKmsOz8ZbusWHGkLuS4Rk4zPckXJc?=
 =?iso-8859-1?Q?vcUNNFxzSKfY0q7+oS+kl5QFopnptWwa9khXFpeFpE0wqMvHaLo23UJIhu?=
 =?iso-8859-1?Q?zoeT4i9dsXzSYuuP1Z/3ta1cA7pw0hdR1ou5vJOcX6cp1SVzKaT0Z3dk0y?=
 =?iso-8859-1?Q?8qA5MumW4effYy95qwo1yEiqyR3dHL8dUz20Y356/rwyMJAJ1pGo7cgILv?=
 =?iso-8859-1?Q?gCkdVBX8uBmK/gP40wKPdtieCgTlsXblnBQjwHb9NNkAVNu1AFuofLtQPn?=
 =?iso-8859-1?Q?Ce1xD+/5+3wssc3e8oJIsO51O+q+bZC2Mve7u2FfHogv7J3fMzM2OD/nnq?=
 =?iso-8859-1?Q?m4DdkfjfBXqWryBPFW5l75X6cM511/jOxDSzZVQYhBIuOVQzZKELZi5Jmk?=
 =?iso-8859-1?Q?VFwTLUVsvLijqUlm6uzpjslctT2efY0yaOqMoKmPsngniYxbM2cHAK8P4x?=
 =?iso-8859-1?Q?Ii182QjXYWLisqe/Cfipy+Xdnf7OH42YOpmWQWGmGmeu6Ao+W0ethe8lqT?=
 =?iso-8859-1?Q?b+SyWQ1J6V8mbAwsmjUsxbMcmAwR3fSputK1/pt36jh60q9wx9ZECunKMw?=
 =?iso-8859-1?Q?k9WzraA4e/iNaT/IlCd2rBS5ksNdXp32qBAgA+oT83wpOEqhEXqno5kIfd?=
 =?iso-8859-1?Q?dyr327ijjRf3i4K59Qd7Oy95JqtyY5sTXMgSwywuuylZkuZnqZjM0+/qI0?=
 =?iso-8859-1?Q?E7KgApbbH63d72IrJeFMzMqbTy9UTarBmQ4CjaDmKPXdB372QQ2e4EP+Ps?=
 =?iso-8859-1?Q?yI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: 0Ztq98pxr9niDWEJBvgZOxs7uAcGQmwPETuQQpy7407wlKrNxwfbOLyv9Q7D0mx7bwRgDamPOxNMA6kUp01ZIWieZhBNTPJzfxMSsNI0CV8t6ouaiM/M37cU/eQOgKxNELnSCyDlw5JyUHW+PmAk0yKJDmMYpD2OqCKrVjLJcwTs6GhZLZE+6A3lzJqybf1ZMjG2TzkdzmzrsTXDu1hZcqvlggWqGGQrZhMyio7vxwHkJT5oY/so8w0vifFMUNfLL9rBB2lvAX35TjIyZrifUKu1gi2kcAvNbnlROrGwUG7+YCKgarkEhbOKoCiY4ZmLMtpixXBFrSULcC+uKPFO7iNPdYxk9qFVqI4E25b3T9UFqQJtBpAT+18c+D8hX/TUGg/1QYup10/CK7n+1WtmYn1yo0sU93KIOU1gKdtRfH4kJP2JRH7SiSyJ+mc3yw3/WRXljwCCOxc5VQ==
X-OriginatorOrg: Cummins365.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 07:39:17.7036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a867f1c7-db63-421d-f839-08dbc3e3d996
X-MS-Exchange-CrossTenant-Id: b31a5d86-6dda-4457-85e5-c55bbc07923d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=b31a5d86-6dda-4457-85e5-c55bbc07923d;Ip=[146.91.48.123];Helo=[ACDCSWPAPP748.cummins.svcnet]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR05MB10031
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_REPLYTO,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,RCVD_IN_SBL,RCVD_IN_VALIDITY_RPBL,SPF_FAIL,
        SPF_HELO_PASS,TO_EQ_FM_DOM_SPF_FAIL,TO_EQ_FM_SPF_FAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [216.71.141.138 listed in list.dnswl.org]
        *  1.3 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in
        *      bl.spamcop.net
        *      [Blocked - see <https://www.spamcop.net/bl.shtml?216.71.141.138>]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [185.225.73.120 listed in zen.spamhaus.org]
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [216.71.141.138 listed in bl.score.senderscore.com]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 RCVD_IN_MSPIKE_L4 RBL: Bad reputation (-4)
        *      [216.71.141.138 listed in bl.mailspike.net]
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        *  0.0 SPF_FAIL SPF: sender does not match SPF record (fail)
        *      [SPF failed: Please see http://www.openspf.org/Why?s=mfrom;id=bounces%2Bsrs%3Dt2nez%3Dfr%40cummins365.onmicrosoft.com;ip=216.71.141.138;r=lindbergh.monkeyblade.net]
        *  0.0 RCVD_IN_MSPIKE_BL Mailspike blocklisted
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  0.0 TO_EQ_FM_SPF_FAIL To == From and external SPF failed
        *  0.0 TO_EQ_FM_DOM_SPF_FAIL To domain == From domain and external SPF
        *       failed
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Respectfully,

I have a client who has money to invest either in the form of a loan or equity basis.

A skilled and competent manager who have a secured and sustainable business plan that can generate good profits, is required.

Please respond with your thoughts so that we can discuss them.

Regards,
Ahmad Mualla
Email: engr.dr.ahmadmualla@yandex.com
