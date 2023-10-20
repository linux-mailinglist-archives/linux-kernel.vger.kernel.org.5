Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0537D1385
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377862AbjJTQEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377814AbjJTQEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:04:50 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2089.outbound.protection.outlook.com [40.92.58.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2472CD7;
        Fri, 20 Oct 2023 09:04:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpsltV757FGrqEJ4sw2IzRx4ky4j/V8YMcE/7W3EJRJHQPo0uvwizA/ZgePZUE+sszZ+Peg0b5hfRcK7Q1irT6sttY0m+fiAv4P8xfzXyqazlsS7okWUEIn3/dPZ711qObgHhb7JEnKlVB/HruXdVEr+cAZWOljGIu7I1X1aMQ9pZenXnEOslh7TJkg8KVIOga9bSe775PK/ZrWyY3CotYY9kd6Mpd9TRhv9pQW9U+xZfZoRryzjG+/3RK3qnkMEzdqIq43CwgqA2xtWYMp494A7wn4ExBiakes8K4Rqqxcn2Y1SZv/bqAs+2ATrIS08s9wV51SuRVH4YJFgrfBHZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KamqX0Q6NPXurZO/K0GqLjTTWdEMYnTddIw8LLYZnI=;
 b=H2k9tGwZ14V9AkvSMdF5vJIzUrG6/GTBmgCfjX8VayFENyjku4vuvhcZAZMx3H2At8X+zDtwyXUwud1OQllH16wGyK//8m/lIAmQwQOHVqXDyr76ErvF+HtnG1/5aHGlRhWN5YhiTcn7alPBKRmM6vdmSoik6sd/tvaP+DvZYaOzIJotLhN8ud72nGNCE1ifIm5fcexsWeBJE6Ov8K6c+sS+aoPKHGq4tPCbNWCFzXtqBh0cXoS6czfXwR7c+fP33GJlndS1iBGzThhq+qhF/7OFH1esp78flL1ipQGqlOyjxRpasUdO8KlRHULA8mSeh6d6+9zqOF5OQfzO1pZDag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by AM9PR02MB6930.eurprd02.prod.outlook.com (2603:10a6:20b:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 16:04:44 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6886.034; Fri, 20 Oct 2023
 16:04:43 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Cameron Williams <cang1@live.co.uk>, stable@vger.kernel.org
Subject: [PATCH v4 00/11] tty: 8250: Brainboxes card additions/fixes
Date:   Fri, 20 Oct 2023 17:03:06 +0100
Message-ID: <DU0PR02MB7899F384ACF9A7FFA643E123C4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <BBPatchesV4>
References: <BBPatchesV4>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [DbHNQE++dcEdnb+4WoVPKKEa6MIniq8d]
X-ClientProxiedBy: LO0P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::19) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <20231020160412.118550-1-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|AM9PR02MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bfe9efa-b2dc-4868-343b-08dbd18645d1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJoYwgJoyrcFNS8E9L4f6xyk5VSAQ92vQrN9iRWxSmPKKvH0nb9CK+TxkzaYuvEO+AKWmwewHR8USWxQ7zO9FkUdtfJYYku7qJBPwVO0MvknYrv2gOOMl84vkpT5KMgX041fccmH47waxwESmJcv+EtA9EQdOz73YjomzA2VKVUTcXa08mWHrN8jQy9T/UczEFNDh9GSO6IS5XytUCdp/fdM02+rntBZuurbodkCUM8D23R1fzFQ/dLx9I1XG3P5HxCcTCWn0va1H2TsYW+mzMd/Uh0zGvH0dJb9gzNCCPbor1TZyWcX3EkSD6j8HBQaRaAAfa52OQgguF88HDIIB5cPsGGtCRnAp6F89ErnatbTUMD+sp3CzxLkJpfdS2xYeZla6BgPTLXOLSizZCtCov0qAEE5GlbnXfG8VlQ4cXogJ0ODCgKlGeqB4yu3SQCamCX9tJmHaSueeM1QZ0nu29AsMv67EvuwRsCOuuEMQTsb5SfSz6JkUqRmaeLMseusjADPXEIbOBYXS/DFRxt5OL+H7n6MQkthJ8vV/ICpaWQp76tX9bPYk1bYGjM7EtHuectUoIMO3h6fpZjR6vv0by+m9/8OEJiBredy6uz7bQSz/Y5QSlAKBOSjweDILqaB4NMErtmZVXSSri9dmW740w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bl6g3ruv6lr1YSn4cRZipizPmAwLK8NgIam06PDT+Ud9cQ6obL2GnUQ10iso?=
 =?us-ascii?Q?eC+A9hfmR/7smIJdKXkbPdcimHVTceEn/Ry8hm9I2MAwHo1gD/nbNnI+yOl1?=
 =?us-ascii?Q?V4vSa+u+kkn8ng3O9O4EKcjrbhnJ2ANCOSit388PNxc95Bfj0l6VLiFdcaf9?=
 =?us-ascii?Q?6iEZycWAJJ0F2R4Qvf9hhKSgVbKo6StP5fKzsRDo/6do4SCurcCmGA+0Hj1F?=
 =?us-ascii?Q?nbmGglo7eQfMh/P7OZY5Ui8XuaNFKmkdfbkqzUS2QtCm0C4OGSNKj+9xYGSV?=
 =?us-ascii?Q?AGotw0INGDTtG960mVhfUxnpiFsIChO80jcvMnUZa12kutzqUY5LpRJ4ndnF?=
 =?us-ascii?Q?bWtHQyqDlLNqlH7ly3LO4B28PDFajzvTo5+H5Uhx8+LJrJ/fHlWFnqwoUy2r?=
 =?us-ascii?Q?r8b/XwZzZ5SWsU3iuf5f5eSFAXAWwVp1Bq3v5FVvE72wvmT9sdqxDJVjggzV?=
 =?us-ascii?Q?UBt7HVU3W1HlCVqoKKysxKLJRj+6xLFnu7Wr58a+rSngMIU6ojek/uKYGyCH?=
 =?us-ascii?Q?Y8U8rozFR0TkFgmiXbz/bhZcWzRqO36oxOk1PmJrZhafuqDzFPJnSGopWsGR?=
 =?us-ascii?Q?zAQgGoAX6npipCJOSrRMmfji2w7ZP700ikNgjiCzwdO+uIrb3ofIHBAugigk?=
 =?us-ascii?Q?ycnUKh9qyumcCOt+jBMlRIgVHQqX61qFCA6pj23Z1+OkeAHY7SlMnfzFGxzm?=
 =?us-ascii?Q?R541Ua7TNqkAcdevNpxUSHvnXb0R6FB1UYKDC5AHQgoHnJHjXK1EuaWkKYFl?=
 =?us-ascii?Q?FXS2dMn39fQLF8iR2mmPq6X09uUZFlrVt+Mk0yWgja5O4yAY5GMfLy13zjNN?=
 =?us-ascii?Q?4YZPoEztosJX5bAeAkwTAiDVHlAS7TDJgVSCWkHPyVgFWEcBzJ6q345vF4VK?=
 =?us-ascii?Q?noMW4gnWH1mD81EaqHE2nqfNVchdHk33M8EAHV3T2C2y7W+W6uUq2V9C4KgW?=
 =?us-ascii?Q?UIJ0mBRteglnC5SypX6Id90Wslb9UTeVmEo68aH5N+DSYfjass0TND8XhyhW?=
 =?us-ascii?Q?000lYTeIBaeUMa99cS4vkFz4pFErRo5j9R5sTk/2vqacrapACxyXHYofX2/2?=
 =?us-ascii?Q?96JW3dinX+GPzKvOfQexkWFTgiEunLiHcKN2P/vSp44a1wMgH9KYe0KOliPC?=
 =?us-ascii?Q?5xmMw5/0qpmcRrEZLCsOAPS5c03+yJQ4z+r/irl8DszF+6WoOaRNWJFPWWOt?=
 =?us-ascii?Q?LROEPWwFaRI7ttpkiXbE6IbvJXkoGzJn6HlYTA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfe9efa-b2dc-4868-343b-08dbd18645d1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 16:04:43.3580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6930
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes up various issues and adds additional support for
cards from the Brainboxes PCI/e serial range.

This series should be suitable for the stable kernels too, though some of
the patches are only applicable for 5.15 LTS and above. The patches where
this is the case have a note explaining why.

Thanks to the reviewers for the feedback thus far.

Change from v3 [1][2][3][4][5][6][7][8]:
- Split up patches to have Fixes and Additions separate
- Add Fixes: tags where neccesary
- Add Cc: for stable
[1] https://lore.kernel.org/all/DU0PR02MB789901A0FD8D0A16614B7B01C4D0A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[2] https://lore.kernel.org/all/DU0PR02MB78991BB41F77731BF0BDD777C4D0A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[3] https://lore.kernel.org/all/DU0PR02MB7899EF5899BB15DAF3DB580DC4D0A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[4] https://lore.kernel.org/all/DU0PR02MB7899E6443241E95DCF2D6535C4D0A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[5] https://lore.kernel.org/all/DU0PR02MB7899A8E98A24B0748FA74D59C4D0A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[6] https://lore.kernel.org/all/DU0PR02MB78996091ADEB6B3C952386D2C4D0A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[7] https://lore.kernel.org/all/DU0PR02MB789917A8AB71BE91225DB3F0C4D0A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[8] https://lore.kernel.org/all/DU0PR02MB78998961117757F4750A3AFFC4D0A@DU0PR02MB7899.eurprd02.prod.outlook.com/

Change from v2 [1][2][3][4][5][6][7]:
- No code changes
- Amend patch 1 and 5 commit comment to better clarify what has been
changed and why
- Send using git send-email instead of Mutt so (hopefully) the
threading works OK
[1] https://lore.kernel.org/all/DU0PR02MB7899233A57F6E714C0DD8FF2C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[2] https://lore.kernel.org/all/DU0PR02MB7899CE749DADBEEE38564F9DC4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[3] https://lore.kernel.org/all/DU0PR02MB789934AD01F657CD108E0999C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[4] https://lore.kernel.org/all/DU0PR02MB789954113A4F513D4CD65140C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[5] https://lore.kernel.org/all/DU0PR02MB78993B38B6D95DE0A84DA5E8C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[6] https://lore.kernel.org/all/DU0PR02MB789945AC3746E79AF2390C73C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[7] https://lore.kernel.org/all/DU0PR02MB789927949F9C84AACD694F48C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com/

Change from v1 [1][2][3][4]:
- Split the patch into multiple commits for one subsystem/maintainer
rather than a large series for multiple subsystems.
[1] https://lore.kernel.org/all/DU0PR02MB789950E64D808DB57E9D7312C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[2] https://lore.kernel.org/all/DU0PR02MB7899DE53DFC900EFB50E53F2C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[3] https://lore.kernel.org/all/DU0PR02MB7899033E7E81EAF3694BC20AC4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[4] https://lore.kernel.org/all/DU0PR02MB7899EABA8C3DCAC94DCC79D4C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/

Cameron Williams (11):
  tty: 8250: Fix IS-200 PCI ID comment
  tty: 8250: Remove UC-257 and UC-431
  tty: 8250: Add support for additional Brainboxes UC cards
  tty: 8250: Add support for Brainboxes UP cards
  tty: 8250: Add support for Intashield IS-100
  tty: 8250: Fix port count of PX-257
  tty: 8250: Fix up PX-803/PX-857
  tty: 8250: Add note for PX-835
  tty: 8250: Add support for additional Brainboxes PX cards
  tty: 8250: Add support for Intashield IX cards
  tty: 8250: Add Brainboxes Oxford Semiconductor-based quirks

Cc: stable@vger.kernel.org

 drivers/tty/serial/8250/8250_pci.c | 331 ++++++++++++++++++++++++++++-
 1 file changed, 322 insertions(+), 9 deletions(-)

-- 
2.42.0

