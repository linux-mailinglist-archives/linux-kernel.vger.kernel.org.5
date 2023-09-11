Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC79579C22E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbjILCHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241742AbjILCEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:04:40 -0400
Received: from abi149hd125.arn1.oracleemaildelivery.com (abi149hd125.arn1.oracleemaildelivery.com [129.149.84.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B0224854
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=H8VUP4moo1XVYiRBDWgPNjnI1wJ8sH7VT2dNJjvItbc=;
 b=Ui1++Qndmy2QHhaV+7pzDFIxdz19lDQ0nF7u5P6pgSLjeCeOtMSqM5zkmDVx+nGlDeF+npYf/EDo
   xgYGFzn6QLN9Uq1Wq4tq3lTs2kEq+Mx+/FQbYVQf2dfTNp+YIHzEkRVetZYzd2C45mJShkP64aHZ
   m+nXLmrw32PM87K7zAMGTevje5ToT3Le5K0IsROXVJ3cIRaWduucnjS1HFVbdwONUO8KQ+/SgKBF
   3GMI3jq+fQMmcqusgZ8+9M36tASH19foDu9O9FaM/EKh0BJ6GyB7cYp7/+Lf0Ump+yCMNd3+Km4l
   QpKknvb60SIngLeqJNN+sitEX6ljptF9VjSOOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=H8VUP4moo1XVYiRBDWgPNjnI1wJ8sH7VT2dNJjvItbc=;
 b=JSopP8Ez2n2cBaDICKbnGcBItDOAOI+phWUeuAV0HdXGhhtiUckXkRMBX8+Tp742pFsMlPFs0a6X
   KCRYseziCIFozk1feU7wnNam+wtVNkp0uohT8J/HTzx0vHn3jmh+yVqLITNyCiKrzbhnwaAw0SYl
   Q8+LbOEp6XhNtvmgr1ZUyeXC/wH0WCGjK0wCO/yW7TNz5TRfPkFRE0dUuV9ivVFsA1gVCy0w1h7Q
   Izvye0882rP14tePg/LIFYNTnLKTpW1F7PQWZ9mmknwvUPMJLf6p82ZjLjYL7nQsE1b6TgS7uN8/
   9nOrVLuLO9hCvnWz/+9bOJ7Gf36foUXrqEFWgA==
Received: by omta-ad1-fd1-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230808 64bit (built Aug  8
 2023))
 with ESMTPS id <0S0U005OABY4GX50@omta-ad1-fd1-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-kernel@vger.kernel.org; Mon, 11 Sep 2023 21:34:52 +0000 (GMT)
From:   August Wikerfors <git@augustwikerfors.se>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev,
        August Wikerfors <git@augustwikerfors.se>
Subject: [PATCH] ASoC: amd: yc: Fix non-functional mic on Lenovo 82QF and 82UG
Date:   Mon, 11 Sep 2023 23:34:09 +0200
Message-id: <20230911213409.6106-1-git@augustwikerfors.se>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta: AAFMhxbHdTEVooZy00RNFw7yNWnRQQsRpdo9xMUMs12GakU/CcQg5lXkTxfeIA1j
 UFC2bx3C9ai1vUeHgw7IlDUTwUvNnakXPNvwpL3UE58m4KcFRUYpn1W4Tle0cSEv
 agPVEEbWRoh2nvxmASr82sKMXWL7Oed7IQtKIkVPVyzNrBtBVY6wSsxUs4Q/uWmp
 DFnzz1LRQ745NtmwZJXpAPViGlpFf+wr0OaskmbuCQa+3XRM7pV/kY9gmc0oLFNf
 hkhtzxkQ4YTso0uVOCe4TZWUwL4f4FcCbUiA6+gOxx4XS7HHvD+nhyd7ZgWjels1
 k4E/oe90BaQil/sGfJlHjyFoeCVNIEUfN0Ju677DPspDf3igStE25wR9KXv3+jOY
 NtLEukU8iYcq8VfFNzM/kuxRNYXg+R6ZCzp/h54m/taP4qQkHYEJ8Gbd8D2Og/p7 QQMAigA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the Lenovo 82TL and 82V2, the Lenovo 82QF (Yoga 7 14ARB7) and 82UG
(Legion S7 16ARHA7) both need a quirk entry for the internal microphone to
function. Commit c008323fe361 ("ASoC: amd: yc: Fix a non-functional mic on
Lenovo 82SJ") restricted the quirk that previously matched "82" to "82V2",
breaking microphone functionality on these devices. Fix this by adding
specific quirks for these models, as was done for the Lenovo 82TL.

Fixes: c008323fe361 ("ASoC: amd: yc: Fix a non-functional mic on Lenovo 82SJ")
Closes: https://github.com/tomsom/yoga-linux/issues/51
Link: https://bugzilla.kernel.org/show_bug.cgi?id=208555#c780
Cc: stable@vger.kernel.org
Signed-off-by: August Wikerfors <git@augustwikerfors.se>
---
 sound/soc/amd/yc/acp6x-mach.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 59aa2e9d3a79..94e9eb8e73f2 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -213,6 +213,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21J6"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82QF"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
@@ -220,6 +227,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "82TL"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82UG"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.42.0

