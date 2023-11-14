Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2390A7EA7C8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 01:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjKNAnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 19:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjKNAni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 19:43:38 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2049.outbound.protection.outlook.com [40.92.15.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0733D59;
        Mon, 13 Nov 2023 16:43:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yj4CIjnfQoB0UQtmACEj62SaO9kgilhLjjC0XOJxxJCntlSuVvPRPtpiWyVYfhZU6I6CoTWR9fNYiNJY1YzWDOoHwQaI2XqlS0MAWOhNcTC6uk4UwqkzOr10GEZi1c/Z00wGiTHNl4u7fp3wNaMAPxBEO1JnSjnvzEm6uuwYaD/Gggq165XQFj9JM7pHzyCD0JqGlDCyoyxqPUab8XoBE7IzZeeXIMo8Pwi5eF/iil4RTmGHP2ay2xPq5AwfjRn3gJwnqC5VUPC8AI+PYOvc3SJeanLvsBOe8Q7syyq6uomkXvZ9vFPf1XbS0mxSTPJoh0FNpv1kUiybs60n4Io6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivocTI/7YH4iGVyE4mb196wtAQ5uCn/rdimbYwN06aA=;
 b=MUkH8+wlbk6JNSqwv7qb62sYa4/blHXX1JsGYqoQtMuE5ZnlMz5BupoAYTdqiFjdhMQ+zLciFi9Orz1s+d0S8WXuQa1dUtcQqHcO6cWiaVrkvZFKWK5l32a9aQs8yEdQwcPvWNTUYSz8yQ9biuQGg5GG6JWCtMEThk490NHERxD229Rj0jdfRt0UfEOj/M37vwQc6TYC0J7/NMLvZ9Ezr7tJRJoAfqbBFq2puVketiZOm4/wPrZMJH+MgXsLcquNLrGqN3fK8bFy2fSaXxyRqm5bdirKG1Mp9faX5uYkxevFhR+yhjkC3XoVAleBkUmy7b5x3ZB8fmXbKJBdhJad3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivocTI/7YH4iGVyE4mb196wtAQ5uCn/rdimbYwN06aA=;
 b=DzJN/Gn2CUZ63SZZ9PinyCQUG0NvAfwg/CruxnJDu2nutSKA4siEjVhCWCvHquoqEq/JvP8vVj8D1uS5yctDwXKXjtuMWD92UftvAkNfFePOtWvZFhpOhxRfmU+ht7JEWQ4rjHSkLeoeZ2zwPR+ZTp4uSJEdLqtd2uz15Sidcq/GKeCuQXWH++V3xq7w3pS9JV/9NnA9np1jVcTajchJqSidGdsFTFeyZsvGwXvu7iT3ZX/zejaHBL6UJcj0Kg+Cf0kKkhV5mQoDj3q5wzq/BQeI9lmhgrWGnYZrHsG94CKdkk+Dcq7WCGOap2cu1kr68CVx9qUQh1hX7unJszUwMw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ2PR20MB6989.namprd20.prod.outlook.com (2603:10b6:a03:56d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 00:43:30 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 00:43:30 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Inochi Amaoto <inochiama@outlook.com>,
        Xiaoguang Xing <xiaoguang.xing@sophgo.com>,
        Guo Ren <guoren@kernel.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/2] Change the sg2042 timer layout to fit aclint format
Date:   Tue, 14 Nov 2023 08:44:02 +0800
Message-ID: <IA1PR20MB4953BB0ABD29F5AE938A54ECBBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [2usgG/fFPdEbk+oJGl0auZP1VYkZFmOWqCoUR5qERbQ=]
X-ClientProxiedBy: SJ0PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::26) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231114004403.42766-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ2PR20MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 875b32e6-7d91-4170-f210-08dbe4aab905
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qPmpahOXxtjopNeaWxM8UZdvQ+KzJYjrnncKcJrZaLHv6kJw641tOnPYL2ZHvwu8zXGQzksThOWSwj8e66KgVy3R2oxLawPJUy7Zh/wZvYrq0arsvM/dTHHVkBABUrfpmhn1AhshNN22mqjp/eMB467tdgqkUtWqt4rKa0s6nKV1qsLUU13lCAfnYWHY9SG7MX7o2hEPN7gS/AMwe18Rnl71QAIwfulAupJdsI5LbIY10ovi6KeM3EJ7W9p60UUby74LpieOpVRJDIv22OdvD2zPLLGnd9jJBy36whvD+Rkn1HjCNoZYRs/i561KLV8rUQ7TEV6EEPb/PSxdAgriVdPbLi7kM9SEyPeJc8QwGVzsLHC/YbBPT7PltMC8VBasfgfZ7jp+3/Hw8hx+cF5P54tMZ7XfrYJgyxRPTyWulFZkbBIL9UaE8yamMHzHevJbfuqJ6sO9Mr1Lsxcb88DHG33htELXLiqSBlvHXGo7d+2n/2cW8ShTr6aJp07BCC3pGHZ94LDqsoVoVJIQg7VuVxtAmGelQOc95N2SxQMoL6twQQyrRc3r3uUku2sWKaS+bMbz4erUehcSUlYh1VZYVqsP4ZTE8n7SEkp0SJ8w5iW4qIQo9ndqqLCBSuJOWB92
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y6ZWXklhwQYLcf2ir65q0yDJV88BqZ267YiE2ncW/zdTJc4m3/FicApafztU?=
 =?us-ascii?Q?F1yq7pq+62HvV524NYtC+GsSV6VZLyz0+elWfHqagavRdrVTJRr1xofVVg3M?=
 =?us-ascii?Q?Kb6mJOBzxoEsXhKhAfnXD9GBobWp/rMfFukkIEsB4eTg6jGJ/9kUXHK9hT3q?=
 =?us-ascii?Q?K/wADMfXqgwg0SeN4UTTgO8oSQcvHEz6KD5oItuOkVWtApm0t1L6x+uyNCYv?=
 =?us-ascii?Q?9VhR6jR84xt9uft6PTfS50hi3Yf1CWTRm2tOUwsxmtS41VYz9cbQdKefjXzF?=
 =?us-ascii?Q?BUbItS8vXwn+Fl6SO9TroavAOmC7vn0PqZigjxKDwtD85T+7NT0rXecuGH+0?=
 =?us-ascii?Q?3WXDVekY+eLn5W2vDBwyZBIt1KrWcGKqoXLa6DIExDt0uHgaXYeNihq+qptY?=
 =?us-ascii?Q?mx4sepMvaYpKMyZHPV5MM6Aujf6HjZORa27C1X4mX2lLfS86Y1LIHJK5frTC?=
 =?us-ascii?Q?Uh5WUF7jdUoM8SwqNQxK3V/xobOW1iqYypYEID9TJEkjOK/wLIJZXNqrrMXt?=
 =?us-ascii?Q?POfqKYCjzAppqkFXgfpOUifSVQKYfjGPpD5+67uJN877vc628XsL1ywXBMlj?=
 =?us-ascii?Q?qE8of6h1O0AH23dUIbf4K10D+VL1akcYKmNoB0hpGpUHe/52Gd8tbJ6ntswH?=
 =?us-ascii?Q?xvYv/+PRO86R6cQsR0bKzyXOHkT6PNx2ptvt9joBIv79XfPD2joFHhA36C7I?=
 =?us-ascii?Q?8TzHd8sKynknunkUNQ14THQdoVqRrSY1pZmvQG9emlroiZx6u6NGlonlj3NM?=
 =?us-ascii?Q?4+uxMCtA8p7Yw/oRm9KL0CGf/JOa0br11rUmRh6qzM2EITGPDzJGTaBSPrMq?=
 =?us-ascii?Q?BQlOgfhUNrOFymC85ONz5dbntMGb+ChreF8FUl2xrgxjG2efR51tzlgqq/vn?=
 =?us-ascii?Q?WuijjaxyzueMWqVgZhWKb/lDQqYu1Y7xyKh6hHhleKQRPH5145h2IB8tgRxK?=
 =?us-ascii?Q?cb2O5w8Iz6o7EF0asUOcrWWI9V9eMGu2i2G8M3YGHacklXh37kUMt6xnb2AU?=
 =?us-ascii?Q?kW3+PknztKdy1za9x1QhoX/OWKY43XxafmpDkFWguXig/WxHHaH3myXp7/2I?=
 =?us-ascii?Q?OdVSloCvC764UaLeOOOrqGTJjmj9xCgxuuoKVvnhQu8DR/kSxenzbSdWsJaM?=
 =?us-ascii?Q?sfNwNz2mJIuL43u6AxQ0QG2YwHFod1A6cAdY9vamPI8OP+7VkJerg6y2W2qg?=
 =?us-ascii?Q?w7AZNLfVJStOxr3f0ny/nL6vMb73z6rIpH4/mkI+RGSHkOdlJfgeruD+UAw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 875b32e6-7d91-4170-f210-08dbe4aab905
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 00:43:30.4851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR20MB6989
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the sg2042 uses different address for timer and mswi of its clint
device, it should follow the aclint format. For the previous patchs,
it only use only one address for both mtime and mtimer, this is can
not be parsed by OpenSBI. To resolve this, separate these two registers
in the dtb.

Link: https://lists.infradead.org/pipermail/opensbi/2023-October/005693.html
Link: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc

Changed from v1:
1. change the commit to address the reason for ABI change.
2. remove unnecessary link in the commit.

Inochi Amaoto (2):
  dt-bindings: timer: thead,c900-aclint-mtimer: separate mtime and
    mtimecmp regs
  riscv: dts: sophgo: separate sg2042 mtime and mtimecmp to fit aclint
    format

 .../timer/thead,c900-aclint-mtimer.yaml       |  5 +-
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 80 +++++++++++--------
 2 files changed, 51 insertions(+), 34 deletions(-)

--
2.42.1

