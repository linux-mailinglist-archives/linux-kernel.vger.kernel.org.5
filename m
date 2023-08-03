Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5524A76F402
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjHCUXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjHCUXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:23:04 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EFE10CA;
        Thu,  3 Aug 2023 13:23:03 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C071F31A;
        Thu,  3 Aug 2023 20:23:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C071F31A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1691094182; bh=Z6H7ra75b1GD73w6Q6OpzWHRmyhXKkKOs8nQ5RLXIVQ=;
        h=From:To:Cc:Subject:Date:From;
        b=hjFHyuy6wYcVB18RivK5h6DV5/Y7YbgjJMZcXEPNRJRS+4ayf3uIKYX9d833oI401
         jBtZUXp7witT83riwS7a0wgq1eaxfPMObzH/nYeq7RRj6gzTVMRj1W5Qa76XLr3zg/
         TeW26vvx/HofPouEtLJY/8QBRLSyM2gGEOQK1x42jsFyvH/PhwzHR0IqBEqQS6KVaS
         cYFYN77NWHUvtBP6x/v9SZZiZMXboW+2b8bfTmMb8aaocFV4tGdO77/Neid2Zn1es3
         gSJ4CCjnYGCFVEFwX/lu5GO32flW8u5V9R38z6rHfNIhizQ5WQmhjBC3i/lw3RJPD/
         OHPS/qk607c1w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-kernel@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-doc@vger.kernel.org,
        tech-board@lists.linuxfoundation.org
Subject: [PATCH] docs: Add a section on surveys to the researcher guidelines
Date:   Thu, 03 Aug 2023 14:23:02 -0600
Message-ID: <87il9v7u55.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is common for university researchers to want to poll the community with
online surveys, but that approach distracts developers while yielding
little in the way of useful data.  Encourage alternatives instead.

Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 .../process/researcher-guidelines.rst         | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/process/researcher-guidelines.rst b/Documentation/process/researcher-guidelines.rst
index 9fcfed3c350b..d159cd4f5e5b 100644
--- a/Documentation/process/researcher-guidelines.rst
+++ b/Documentation/process/researcher-guidelines.rst
@@ -44,6 +44,33 @@ explicit agreement of, and full disclosure to, the individual developers
 involved. Developers cannot be interacted with/experimented on without
 consent; this, too, is standard research ethics.
 
+Surveys
+=======
+
+Research often takes the form of surveys sent to maintainers or
+contributors.  As a general rule, though, the kernel community derives
+little value from these surveys.  The kernel development process works
+because every developer benefits from their participation, even working
+with others who have different goals.  Responding to a survey, though, is a
+one-way demand placed on busy developers with no corresponding benefit to
+themselves or to the kernel community as a whole.  For this reason, this
+method of research is discouraged.
+
+Kernel community members already receive far too much email and are likely
+to perceive survey requests as just another demand on their time.  Sending
+such requests deprives the community of valuable contributor time and is
+unlikely to yield a statistically useful response.
+
+As an alternative, researchers should consider attending developer events,
+hosting sessions where the research project and its benefits to the
+participants can be explained, and interacting directly with the community
+there.  The information received will be far richer than that obtained from
+an email survey, and the community will gain from the ability to learn from
+your insights as well.
+
+Patches
+=======
+
 To help clarify: sending patches to developers *is* interacting
 with them, but they have already consented to receiving *good faith
 contributions*. Sending intentionally flawed/vulnerable patches or
-- 
2.41.0

