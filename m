Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4957575A4D6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 05:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjGTDkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 23:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGTDkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:40:52 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2131.outbound.protection.outlook.com [40.107.255.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490B2F0;
        Wed, 19 Jul 2023 20:40:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcLwTEA+pmyyEXqgLkHxSTRz2a6ZdmYhFWaiC3nCKQJXBtq/4YJl5IqPRSM2psyvWsD1nNoqpUyheM0DluluwEpml10KRaV1RvYINZq476sD5oG5Bp2LTH7SoPchPUgL7/W6qmMpOvsccX++r6an9m2+dXmIaB1zYJyg4g9IKKTTp+uAk86+Ta19rtPzSQD48KWkzQ1v7+cAieOpeTAyJfi1roqKNh9rSbU7ExuU7V5xgzDd9+JSL6psKUVJO5CDeHNK7YNSjmtooRoAdQY16Lbuvwcgn7rSQQCRkorBBSI8ycDexBiKk7wQSDrAfwjXjLNtGfr0AdyOD0Jik0d/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W275XnuqkOoCTXbZQsp9ltPUoZPYVgo+/C1IXol+dhw=;
 b=PnHiuCIBMgzDCrx6DlvZ2XFdh7/ScCZBjkfVxLQ55iqTTAeSgTzWIj0kpZOxsdh3MzDRnFa3LDV4vu9H7v/g8yNF1KBZbHFXiPnyYJ6qZFzGUvCdSArQtU1CE3rWbtQL4loT/8tUqsslTW+mSseHNujFnJBAPcIpTlNwLfmd2a3sjLlvTWYSrvWcIAxWdF/69GGSvPxFG6rckFCTq2WVpwDRCvq4zk9NCW1NdO+vGJffEb+60O/HzQYjXBgF+qLkjKYYav0XNEgjgaBNCfhWcsvpjgjU0tz7VhMqJKbyIk9Vg45ZsmijMSC7oTT5I5rSlJ7FzvGlAI4K9qHd2+isKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W275XnuqkOoCTXbZQsp9ltPUoZPYVgo+/C1IXol+dhw=;
 b=kHTrnPp7PZw7cZx97TzvxP9vHcjEz+fiMRgSbKJmda3B8R1IwOLXvD3gdACDQJ4cMRFr25clBZCr54AJDVfELpb/461UlDCP5ULMjXp0rvlHueMEA//T8mZ++kJcUjVdaZQDvGHgKHgtREwCw+1lUqXSfMkRcSmve8u0Ea126BXsdPE0tUqY+cVoq9KQu1oInXnQiFxN53kLxHWALUwcfF3x8e7aoh0gLYPnU4UNVU15A1ZgaH2ggsmSmK3EhJMrFVgKxdb6Z0WG1T6WLKHVgWxu/78Rp/y6Xd1fZBXwHqBVwxU20eNwUQdx9F8PX3AkgrAbzwYo3KhM39QwjoZPlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB5859.apcprd06.prod.outlook.com (2603:1096:101:c0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.24; Thu, 20 Jul 2023 03:40:41 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::c1bf:c09e:7639:75f8]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::c1bf:c09e:7639:75f8%4]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 03:40:41 +0000
From:   Rong Qianfeng <rongqianfeng@vivo.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, rongqianfeng@vivo.com
Subject: [PATCH] tools: perf: Two typos have been corrected
Date:   Thu, 20 Jul 2023 11:40:22 +0800
Message-Id: <20230720034022.31937-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be01951-9fbf-41e5-1283-08db88d31714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6jde2bVKZGm3q8cJRdw5gwElrlAZt8s3JsQv8FE8eG1FIHY3yHZk8UZ/YUIwFNAsGuyqgYsXw9+0IFuxLgcA6dyOleClYL7HEuHzQhYyO2QoRc3cNjS5fZ+KMy9NslXS71DQrRe5d2LYcfijpdW5b131L6rkh3yErMBWQiFQBA7yoeJijBIhsihnSLySn7bNxrjaSGUuoH1qPRMKXel6bacf4LDzm9A0mdI64eOzVFUfELIMFz8zszQWW0blc1q5ztZ2AlMEs3evBP67KABauOq0mhJRQc84mw+a7OA03bpht/32CgwgvTTHiNm7pG3gv/q/5ndWe1q2d5N6Rr+M6wCkjCLkw5Dx7TI5EPkHqa2FnBJ1hDZ2UbuC0RhVTM5JJ5/YTT1HU4wXjx8qoTgYZnlmiJnOc/bbAIOJd09vRVFwzzjmZeMd3GQFWUbyv+WFQqI0m/4hL+X6mMv47nS08wzA/LsE4UTb1LKBQaukltV4fAGYIX+uHfiDuIfpMVerjjKcuGH2DoqO3ed+tGYfKl7sVkNyhVNyUGHXV9XFb/at1Uvj5kSZpRYp3AdyQYNBZYfoxhkeR5x993kXecsQgWQYav8StpgYSY+jaJuGjoHXtJq8scL6KuOp/IEeumYSEwItjSBNMNbCtCxZGK5RAE7/oEMS871+KuD4nBeKY4EHK7r5HrhqQ1nwSf+u6Bva
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(2906002)(4744005)(478600001)(110136005)(41300700001)(7416002)(8936002)(8676002)(5660300002)(66556008)(66476007)(66946007)(4326008)(316002)(107886003)(52116002)(38350700002)(2616005)(86362001)(36756003)(26005)(1076003)(186003)(6506007)(921005)(6486002)(83380400001)(6512007)(38100700002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PWpM4jvetf2f/IZCVWp7ocY5erKJLkrhVgxZs7iqDKofSPb8FgmDB5J9Fo8P?=
 =?us-ascii?Q?FBM+EJThkKG4zcyG3q2twBjlPKAU+UkUFZXayfKFyfrGkGTV+8UD9oTcHpDc?=
 =?us-ascii?Q?pvv/3KkrPdbTOmj9zUcchoIoYa+Qyb3yH0Mn2bOWkatxAfjTrV81zw7GmB77?=
 =?us-ascii?Q?PnjMS8xtI0kCVyWaSZFMjetoMem0xiFGRCxI7PDVNMX1owDqwjt2ThBW916s?=
 =?us-ascii?Q?/xmlSIbbMoMIqm9UdzxRCJ7/KYLRj491Yf5oYNx6yzkKjHhKCtorq3OdCnEQ?=
 =?us-ascii?Q?0fSJvz3G9lrKAihwT822YrQtFCDlFJGUZORshZN+0Z29gcT+6oza/Q8fiznE?=
 =?us-ascii?Q?UXo2n/DFsJYYCcEBq4NiviQd8gw0hv17az53Eh+6G5pP34Vhgd2A+4F8BTRM?=
 =?us-ascii?Q?oKiSyAKwcRcOEYQFtlkPZn39kZRBgIHcBUiN803e0ZW8O/TUoY0LfGDFW81K?=
 =?us-ascii?Q?g0t17IeQoXilfuQbpcgoKuLhjH9UXMozWseqbQQN4caZ6Y1VXwfikqMHi0td?=
 =?us-ascii?Q?06J4yKrrjPHtJ6cMFQsGnhg7Z25grYVjgURA1PhjUMdEKDZvWmUaeBjGlNz6?=
 =?us-ascii?Q?PBL82OpWspHBFMzLWLjitgdDlMif3ZHV4/+u0i2IYJwUyFuHZG2Dk7dVbg5g?=
 =?us-ascii?Q?b9bkkfAZZ0Tw3PgyZPdeFeE5IxeG0YE41A1xuEuQ0vfXmOv1SpG/Z9ZoNu1h?=
 =?us-ascii?Q?oa97RWul3Rsxm3fsU/FnlJjwle1u1yspyt3gxxwt1wO7jrpBv+mq5mHB6lCq?=
 =?us-ascii?Q?Rpw1sgKSsNREGzUvfVrpkE8OWXwEgVNDCAqwkQCeqmX+c3RVfiH+PKOTNMNe?=
 =?us-ascii?Q?zKNRaIoxtrwmmYpncAv9w8MwZ7LW/Ia22xvpQL4mKdw+lUUpWbmQGepgAVuI?=
 =?us-ascii?Q?mL1MAwOEVJ9avZK0ejXqAMZ4Yl0pebVXNAsqCFSuzNbPX9B/0XRqS4Si4aSB?=
 =?us-ascii?Q?L569Mj5C4lPOt0qtmLUxWEhHHMX7Ln0zdkpZZF4bSvHprdOqhDmBcV5d34Z7?=
 =?us-ascii?Q?GM47Jb65apR7rBJ6MLhUP5OTLK+aS3iXnZnG8SUgUKSr60zcA7sUgy+ZQgJ3?=
 =?us-ascii?Q?YQdg4rt0aH+tT3aTT7YxvPh51Vc6Md7HmJCbgPIwHDh1EU9OabKAKpXQk9K7?=
 =?us-ascii?Q?XoQODuofNyg6Plju+GbK2BuXhrI3camfSpe5cPZS9zEAZvLsnt0PgvGWffxT?=
 =?us-ascii?Q?qTaX4Jig+bgCigPWKEklPlwMt8GxFLFgzrjDg6noAATE3tFKLDza/bqtDuDa?=
 =?us-ascii?Q?ZQSl0OyCvyoyU8pT2bn4xnjtaurzkA3OV0i4gY6ewDsgRpSUPa7ZL4d1H0Af?=
 =?us-ascii?Q?ybfdFkaKeXacAPFjoVHJpED/Adl6pyl9DZGkUbS7SeTDLEUleLTTktskj7RO?=
 =?us-ascii?Q?Lcuyg+0Te1o64wfLyKW4TpeiMeQGwXd9ffSeE73/f0Plr0G4Jfy9Z1+O89H9?=
 =?us-ascii?Q?9vVEKTMpnYX3CI3et+d2vOncCIxpSkkhVR/LYITTWjftns+UkKCOmfyeomEj?=
 =?us-ascii?Q?x2pXo+aD6qM4oe2pzXjDv0KURGT52FnN10xTa3xu5hFmsXxz8lz0WSRlxAvu?=
 =?us-ascii?Q?7RHsSu0/NzA/pfN84QCVphqa3F7XE43BrF/5JVUH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be01951-9fbf-41e5-1283-08db88d31714
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 03:40:41.1595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MoUd/OmbUeUdTvdzCOoqehmpnwVvaBusEpH+Wq1zH/xTJ+Qnt5G8JJBIfh4r0Pn3NiVayIt+8LkyXcdygdi6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5859
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When wrapping code, use ';' better than using ',' which is more
in line with the coding habits of most engineers.

Signed-off-by: Rong Qianfeng <rongqianfeng@vivo.com>
---
 tools/perf/builtin-diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index e8a1b16aa5f8..57d300d8e570
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1915,8 +1915,8 @@ static int data_init(int argc, const char **argv)
 		struct perf_data *data = &d->data;
 
 		data->path  = use_default ? defaults[i] : argv[i];
-		data->mode  = PERF_DATA_MODE_READ,
-		data->force = force,
+		data->mode  = PERF_DATA_MODE_READ;
+		data->force = force;
 
 		d->idx  = i;
 	}
-- 
2.39.0

