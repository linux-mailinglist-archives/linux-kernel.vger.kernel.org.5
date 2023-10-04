Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B997B75F9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 02:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjJDAuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 20:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjJDAuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 20:50:13 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3E2A9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 17:50:10 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-564af0ac494so1011179a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 17:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696380610; x=1696985410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HkObdmx0XqrL9iRYXBWgzfnzoTu3OH9oUH6D5cDUZRU=;
        b=L3R9K9XDB8Q1+pK9k1izQMuZS0heWehXxJbRSfLg91HQf0lWXgnrCNWbADKGf6zz7Y
         EATGrkFp2v8rG8kjHuzGaE5fcDjSckLg3xS+Opy4KadewzbW5ACyYO33K2BqZ0tzYd2I
         SvqK/W6CCCkdLY7WQqTdhH6DlQBXjL3sESvDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696380610; x=1696985410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HkObdmx0XqrL9iRYXBWgzfnzoTu3OH9oUH6D5cDUZRU=;
        b=Hcn6Gb8O2ci21ucM1nKjKQFcyZzoPG190ApQkmoJrFNeQd+XpgaiJJ0RRVy4EWE/LD
         fQqrsEljNIPwC9dAaFoHGamvcySfKt/B4n5Sb3K6BdPGh12uHPwWzC4uwfG4OEsRQjka
         3uub7mZUZ/HIFVyyZFS8D9o4hduvQ/UoOvphQllMIpyESnDKf2Wch8Avw/JbK8E93kGF
         QzX7MnwMqgt91jQDXiDhxjb0RSQUE+2yAzb0JZgzbKb0H64fi3wkQpuUhYE+oJMGnP3I
         ByxGK82NFdTpHDaMoJU0THB2OiWFa+soGxIdE2jmU+IbrGAKHBtERfreIb9r7I2lvxh6
         mdqg==
X-Gm-Message-State: AOJu0Yzbbx40njq4/CpWe7nEHOTuQ0PZCo0YMBkPWgeW+3M/zKYkBqJP
        izOV52baWkGHtRXLmr5M8Yc41Q==
X-Google-Smtp-Source: AGHT+IGI/mx9BNPA/mhtet3yk8HW5ozun3RdTR2B5hPC+jgDlXDoFcfxl39ptXhO0jTLDSEXJUdJkg==
X-Received: by 2002:a05:6300:8002:b0:140:324c:124c with SMTP id an2-20020a056300800200b00140324c124cmr860380pzc.62.1696380609805;
        Tue, 03 Oct 2023 17:50:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r2-20020a62e402000000b0068aca503b9fsm1983321pfh.114.2023.10.03.17.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 17:50:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] Documentation: embargoed-hardware-issues.rst: Clarify prenotifaction
Date:   Tue,  3 Oct 2023 17:50:03 -0700
Message-Id: <20231004004959.work.258-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3829; i=keescook@chromium.org;
 h=from:subject:message-id; bh=hLygWwZ4r2oWqCkWiQIJpJX1Eb6KLVK7aDJIYb6pK8s=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHLa7vXH9VlCVJ865fzbKZj5zAyA99QKxgRs1S
 F1Ihht6Yz2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRy2uwAKCRCJcvTf3G3A
 JlDxEACjkpEV7WilYLPNOhCZGPsuvAEqxdIw+03oEcYlN3xdvQS90hiYX2Z8JV+vVca97hUrUu1
 ZGYsPZyTwkzxdqedvxOXZ1PJRDWT+x5PYZTiKAcvLyVvYj7yP/WZRG9DFtZHHhHo/dmoXLTYC9W
 d/zVRHEJr9FlejKIWLIiAwCQih2sS8yHNNEswmVr1rI8c5KjnhjpD7SSW7WuPiVAK9cF+LGxCet
 aZOXiuNgLvCSgLK4s5ahSpRkyQ27i1YzM/WLP8AflzGl+Fe348ftZ/TL6SIXOLK21G4oKnCuU/9
 QGWsMhIA5AzOdXK1WeDRV0XJVXy8ZCCZJ1LXo7Qf74qR8lOOinFGzBRQe47wcN70uveRDjGIy8k
 xge/pegM2EgeX4P0/leLUL9I41wsE+68hjG1DMd/s+N7p8/dkKMiiVx4tscFruXYFpJx9OK5w+Z
 QQZu7NLK0gWB4XmmhhkE6oxU8wR3raG8lRzAz5PYEXlxg/iEsgsGsuXgmtg7o5PR4w4crDbidZR
 h70wBYUNAhMILeo71lMdk8Lo/wLJHrwgW35AZ3PTM6XUlm6r8K8Q3BMAAF/Tpbnd0hHDhtV9Lgl
 ayiQ7IC6ncAsCCx7i0nqycM5czn4z9I73RbNlNYf/s3aE9Wb8pJcjqTT75mA+AORXwSNleRxHWA
 2I/bpr6 JS68W72g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There has been a repeated misunderstanding about what the hardware embargo
list is for. Clarify the language in the process so that it is clear
that only fixes are coordinated. There is explicitly no prenotification
process. The list members are also expected to keep total radio silence
during embargoes.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: workflows@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../process/embargoed-hardware-issues.rst     | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index ac7c52f130c9..31000f075707 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -25,15 +25,15 @@ Contact
 The Linux kernel hardware security team is separate from the regular Linux
 kernel security team.
 
-The team only handles the coordination of embargoed hardware security
-issues.  Reports of pure software security bugs in the Linux kernel are not
+The team only handles developing fixes for embargoed hardware security
+issues. Reports of pure software security bugs in the Linux kernel are not
 handled by this team and the reporter will be guided to contact the regular
 Linux kernel security team (:ref:`Documentation/admin-guide/
 <securitybugs>`) instead.
 
 The team can be contacted by email at <hardware-security@kernel.org>. This
-is a private list of security officers who will help you to coordinate an
-issue according to our documented process.
+is a private list of security officers who will help you to coordinate a
+fix according to our documented process.
 
 The list is encrypted and email to the list can be sent by either PGP or
 S/MIME encrypted and must be signed with the reporter's PGP key or S/MIME
@@ -132,11 +132,11 @@ other hardware could be affected.
 
 The hardware security team will provide an incident-specific encrypted
 mailing-list which will be used for initial discussion with the reporter,
-further disclosure and coordination.
+further disclosure, and coordination of fixes.
 
 The hardware security team will provide the disclosing party a list of
 developers (domain experts) who should be informed initially about the
-issue after confirming with the developers  that they will adhere to this
+issue after confirming with the developers that they will adhere to this
 Memorandum of Understanding and the documented process. These developers
 form the initial response team and will be responsible for handling the
 issue after initial contact. The hardware security team is supporting the
@@ -209,13 +209,18 @@ five work days this is taken as silent acknowledgement.
 After acknowledgement or resolution of an objection the expert is disclosed
 by the incident team and brought into the development process.
 
+List participants may not communicate about the issue outside of the
+private mailing list. List participants may not use any shared resources
+(e.g. employer build farms, CI systems, etc) when working on patches.
+
 
 Coordinated release
 """""""""""""""""""
 
 The involved parties will negotiate the date and time where the embargo
 ends. At that point the prepared mitigations are integrated into the
-relevant kernel trees and published.
+relevant kernel trees and published. There is no pre-notification process:
+fixes are published in public and available to everyone at the same time.
 
 While we understand that hardware security issues need coordinated embargo
 time, the embargo time should be constrained to the minimum time which is
-- 
2.34.1

