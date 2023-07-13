Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99F675284E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjGMQab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjGMQa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:30:27 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2142.outbound.protection.outlook.com [40.92.62.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E2B2D59
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:30:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSP/R7XFwiYF5+rnCVjcbVpBbJ/1ZtCCJRxvEN/emEAv08IukTruaUDwhtsEF/X3C9K99eevt2xifAAFzJihf/Lu1/xT9lvEn1IyrD4sMMB+hvDbo9KtrY2rAfd+TjcUghHo6L1KEfQC12hrBQeJYdVUlEmkGsCqVQw8IFWkhpMSPK7oollmxqbwsq8NOOjvLLQIB7qlr5+DW73zs1eiwj3B2nVJGZb3ZKr3mm8Z4O8erRz/EKZK7xd0PO/IETVNasFYvYXyURdPvLEEf0cOFK63o1/enJSZCIZDl716MK8v4QXdpM9VJ57Rus2lXBOM5czjHB4G+CeeBTw0YqL55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udnj4KGq0hvuoHFrJcjXcvzGpQ5sPs2WDhhoXmrsn6I=;
 b=YhaM2MCUgxaPLwI2N/NMpClTNGX8sjfxzeRhPgf+zbmTSiPajqBWOeSB31CM8uXmnp3ljV/mEBmAKjH/R1WCgKPjWVMMEcCN1vwe172fcze99kMI8s++hIpylrT2ghuHr33yJ5Lv4AqlLIHtZdiz4uZTj2VGlt9rj9Wzcwn5i+o3MhuCAqOj3fkXHBXEK2mi3QDXPqtapAkhID3JOtCVAXYdUQHYMYW+rXzv3XKytTwoKmg2P86nzURkKq+ftpqcpyI2jFdnQUrygp0ekGdc6sGDf1CLb4LgtrZcKXah0Xxq24iPVqKks93jvpPpfBfR380k+zTjcCBgjRKFjcaVmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udnj4KGq0hvuoHFrJcjXcvzGpQ5sPs2WDhhoXmrsn6I=;
 b=khjG2+dKNwIoHFzZqfxhCHBw3uEWrDMxtySpxy5SHlcm2gaIHyQ1PVoYwPSJm68SgJoqKgkCjfFEgCKK3cZHRxI3F8t96TWpm2BzkM/taJ4q/Wp0JQPIXgSdsgBC4sl9MY2PR+dwdFXcHI7MzU27caopJvA4DxSk6VUQurx+qf5Tk/EANyFTfDZ+LM/5KRdf9iSQpkSnhwbSQ2FRP00L1sSGf8q+21AHfH9bUnxbqpsw2feNkiUKF829Bd9+VeqlHpAWXfkhW5CU6IxaD6chVQ7iVRTG88PgslZUDgeOQBDczBSlZbsy5Rq4q6Fo5S8xKW29UI9O+7NS7dR8Nd/45A==
Received: from SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:c2::7) by
 SY6P282MB3254.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:165::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.26; Thu, 13 Jul 2023 16:30:15 +0000
Received: from SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8302:9e75:933d:b45]) by SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8302:9e75:933d:b45%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 16:30:15 +0000
From:   David Xu <xuwd1@hotmail.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Luke D. Jones" <luke@ljones.dev>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Andy Chi <andy.chi@canonical.com>,
        Tim Crawford <tcrawford@system76.com>,
        Philipp Jungkamp <p.jungkamp@gmx.net>,
        =?UTF-8?q?Kacper=20Michaj=C5=82ow?= <kasper93@gmail.com>,
        Matthew Anderson <ruinairas1992@gmail.com>,
        Yuchi Yang <yangyuchi66@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, David Xu <xuwd1@hotmail.com>
Subject: [PATCH 0/2] Fix CSC3551 speaker sound problem for machines without a valid ACPI _DSD
Date:   Fri, 14 Jul 2023 00:29:53 +0800
Message-ID: <SY4P282MB18352D4FD343A2E8290EA9BEE037A@SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [q04a7gUqcyIyKasYkzgD7JGXlTyUytGr]
X-ClientProxiedBy: TYCP286CA0125.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::7) To SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:c2::7)
X-Microsoft-Original-Message-ID: <20230713162955.34842-1-xuwd1@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB1835:EE_|SY6P282MB3254:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c5bba92-e046-4bae-49b8-08db83be7026
X-MS-Exchange-SLBlob-MailProps: mWtqiNqNgRvS2YkSb0IYGmo/igQ2hN6eB+cfQWuXQFt0NyZqyhGJWJQi4uNIOOq3QmSLl+f9rnYiQnF3yM860f7kjKsG38DdUzlQBnNiSmdOQYCR63+I1C2qglzp9vdPmHrunuowzpjJ7WrX+MnMs21LuYS7LfGt7TEWrWMqiKXp902xv0+xji4b8nD64u/3ZN9oP0r03u3Lsqla55X+D0F0JicALPTg/7hdlSBeF1lS9ZbGg7oGixZOltf8hP6ZDhBEgBTXWwMQKo7FDFxMsSrTeEIMya2eakXfM4DpCEeRYehr8L9zoRYS7XupKHi7N2Tq+kvqmWO00nyEa535A7nV80L5hSXWJ7XPkLybiQiUx9CRsUh6ZOI2T/QQxlAPFyJOUvP6Qu1YEllRxSEna5m2LCClM4A9LLbcsw9t1PJHUiShho0n1gIWNGZsmnVupPLD7SZIsO8A4h6p9tRYUh+yFl8a7TDoc4LuCy5ea6vUrdplhSq5NsViCV56NqNEcsBv4jcgaEGBganCb73v7ZGknAwOwiV1ASenLE8hKYI8ONqojz2YQr6gP/bIxoWGAdqD5Aik1I86HA/7vMPXuibVkh80J2rjcUyb3qyT/gDP7XkVknbbE4jgFoTcW3lVpYabHOViabE30TUyHLNekpO0CeG2zIJUAzWHiHly9kHTd25fEVrvO9z5gmYfnd7kOvJvwWyl3bRNMUdx9HvpWIXtt3uIbTSgG2q4aygyFBdh3eiekr82okoqRugqnbVT8lKp5WlaTGWO5weAW/GI8ZrtXvS7sul3uMkQe1aXse8=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GqNaPD23tdRZmnMqI3KpJthGfjYNWERM7ml5HfuR0YkJvFQh0mklfSNqwRU6Q4K4NxFYej+nvrz0aO3XIL/lCJSjXRzH+ba6a99qFjTiuqTElVZNb2T9+btYJNuR3SpGY5kN2Q2TGDPAzwYYujuRoiXjx2YEoRRDLuBeHZ0ntRGBv+8jmzAX06CZwjHqfZly6wYmQk865BI2TG7dhgVl9eRQHP4dcsR8N/lgMar1bzZekr0xOIK5DcEjoF/emD0al5PfezCHkDfI/Y20S3eieVICxYeKlhaEXXH8GbXTUF1Re+LS3l7cp9Dv4D0qZdDz/NRAM8uggpZbWHesSOoENTH6wiNrZJoukTn9I9HXOGmKkJq+atgIzFRTDHkKUFikVZYQDYpLvaofmmwd42R4KNFL8mSr7VitXGIlSXXlg3V2RzQ13a6SpENn/sV6vDe7GVaAEd6WqThi6tQfHiFh8AxBFkm/980TtkhPMdxZUDIEX4/2fBt13Qdi0W8sM1E5x9785Zf7fdBjKVdf5V3NGURQgKu7rvF+MYQ3HajWdgB31wEbr2ViN3VRIry/OI52MrIhbraw6kFCHYPabwNJCV0lNxUv3YpRUffCHJOoX5WGUtXACad1WkKPDpbmlL2k
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w809YmGUBTpWzVWepoFALs+wFH4jLD03FgRXA48PvYwqds7qj0x7fO8ubHXK?=
 =?us-ascii?Q?nO737TrEdSg2NktLNj97AafYgycBE2X3bPD76B05ZnBS4wwsKykDLVuvVvdJ?=
 =?us-ascii?Q?WiR8hQV3VXsw2Q6oUkJpSUCR7TH5uFsXuP+emBwGqhyGb9T+3P4f4AVrQdBn?=
 =?us-ascii?Q?l5GtNj7iAJpz7DS1z08LZK9ERsj7BUjOq0y3yoaqiRDb/Su14hTQCC6sAnhU?=
 =?us-ascii?Q?7LLn12GcgbZKfbY7nMW7D/HtDptLwYUerTA+h45W3HvYv3IfWVA4M5gnDmfV?=
 =?us-ascii?Q?081Uz+7kItNQAELFInuPXSN+XYQJ5q28J1UokdQoM5A/y95+CNJfnC158oox?=
 =?us-ascii?Q?ZFFreVTvKdbJ1WY2gwwapB5gJs8zU4QyxwiRwoVmMCrOXI0x5LLy2wPyrX/c?=
 =?us-ascii?Q?Yy49/of3ws1c+19CJhaxgPxxIo+3cAO8Vd5Ab4BCkT/oqAD2FzLQvpZnHOuO?=
 =?us-ascii?Q?AupZnQgJbH2W9KEZCxxhxdz27r6w/GXrTj6lqhCCoKTw4OkJlFkXo8HF6hg5?=
 =?us-ascii?Q?H7Z7RJEJ72zMc3ZJyTNx3UNg4EI/bU5pCYadGuGET0nSpLXtHHs4WrqAhsFZ?=
 =?us-ascii?Q?1WWdyEm8iaNz9ys0p8wjubA0EKuLDmCuAMOBTh5NMpgbGwOmEd1y5TdWr7Lx?=
 =?us-ascii?Q?vt+/IH5mrnUhc7nWOf4N/6Y9W4pBqioRSdqPSiLODxEf0EoCtCReYrTMRPq1?=
 =?us-ascii?Q?KMqtG76qOeDdQFh7xljLTHe/Cn650+l72SPi13brr18JfEzbgOCMgFIjwpIA?=
 =?us-ascii?Q?ySkZNEjS8yMaYS6qsWWMQdRN/J5ILxlnTnP3svlG2JtsCbHL4AXMBGyABYRk?=
 =?us-ascii?Q?AZtL429Dz2OjEgkUvTCPa7YFr+igEVPmCF4fzzXARKIVDZNmEGTcnoHWs6pD?=
 =?us-ascii?Q?nvkPYdPCbPpcCrv3IBfPbBPaV5h+yLD/IhzIk9SCxMji5Dxj0LHLPme5YWBK?=
 =?us-ascii?Q?OE0kcfCCn5yuWjAykN4rIb/4B2ZTxtwZ1D0pJlxsobm9xIBGbArTEtGWtioM?=
 =?us-ascii?Q?1irgXZpRrxvzYHnTcEXt0KAjGEA55t37vx0qkfMi0FsaO6M/AHbgHmAwUKF7?=
 =?us-ascii?Q?kDxqrqdpemCahh+UOjGBUUUhmyEHgLmxvnhAOIM1gLfK8wQ6FZtRCKDUo/mX?=
 =?us-ascii?Q?3YS7+zhVdDSsR6JOqfHqxuUbWa5JdXvH3bq0ju4Vg+sMUaSp8lAO6Uts5ypb?=
 =?us-ascii?Q?OHzYjSDcTJ7EWZBHuHKry/cb8zjbZgdofzpIaQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5bba92-e046-4bae-49b8-08db83be7026
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 16:30:15.4676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY6P282MB3254
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


As the comments added in commit 4d4c4bff4f8ed79d95e05 ("ALSA: hda:
cs35l41: Clarify support for CSC3551 without _DSD Properties"), CSC3551
requires a valid _DSD to work and the current implementation just
fails when no _DSD can be found for CSC3551. However it is a fact
that many OEMs hardcoded the configurations needed by CSC3551 into their
proprietary software for various 2022 and later laptop models,
and this makes the Linux installations on these models cannot make
any speaker sound. Meanwhile, at this point of time, we see no hope
that these OEMs would ever fix this problem via a BIOS update. 

To address the problem, this patch series contains two patches: 

Patch 1 for cs35l41 hda driver: a fixup mechanism is introduced that 
when the driver found there is no valid _DSD that contains the 
configurations, a fixup function would try to find a fixup entry that
contains a proper cs35l41 configuration from a pre-defined fixup table
by matching the CSC3551 ACPI _SUB id. If found, the fixup function
would apply the cs35l41 configurations retrived from the entry. 
In this patch the fixup table only contains some entries for three 
Lenovo laptop models: namely 16IAH7, 16IAX7 and 16ARHA7. However 
as is known, several other laptop models from ASUS and HP also suffer
from this no valid _DSD problem and could have it addressed with this 
fixup mechanism when proper fixup entries are inserted.


Patch 2 for realtek hda driver: add quirks for Lenovo 16IAH7, 16IAX7 
and 16ARHA7 so that cs35l41 playback hook could be registered. Please 
note that for these quirks to work patch 1 has to be applied.


David Xu (2):
  ALSA: hda: cs35l41: Add fixups for machines without a valid ACPI _DSD
  ALSA: hda/realtek: Add quirks for Lenovo 16IAH7, 16IAX7 and 16ARHA7

 sound/pci/hda/cs35l41_hda.c   | 160 ++++++++++++++++++++++++++++++++++
 sound/pci/hda/patch_realtek.c |   5 ++
 2 files changed, 165 insertions(+)

-- 
2.41.0

