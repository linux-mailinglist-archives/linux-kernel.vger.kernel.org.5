Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCE17800E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355666AbjHQWL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355696AbjHQWLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:11:37 -0400
Received: from smtpcmd01-sus.aruba.it (smtpcmd01-sus.aruba.it [62.149.158.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02493580
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:11:01 -0700 (PDT)
Received: from localhost.localdomain ([95.47.160.93])
        by Aruba Outgoing Smtp  with ESMTPSA
        id WlBwquBOoN2T6WlBwqMz6O; Fri, 18 Aug 2023 00:10:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1692310209; bh=YW7OOee3ntlFh+GHPTYk5DoX31eiF4LJQ1/lOJukFeY=;
        h=From:To:Subject:Date:MIME-Version;
        b=csE6r/INTs2vmCMgvup7TkASYill7DSypJhq/JY0uluNwB2YngpwF82O3DUyjL9Mi
         ThGIC1+6UrWRq8rCwqXhlD9TJcYh/BEH2/6cmgu1yDFo46Z3HLLgDCJ49QrhwYS2RB
         JdZY0Zf1Vqbp+Ti0bGOK43V/MC8RbtPpue6LVND3YFQVabioIg+WXC6osJVK+/0R7b
         0Xx8et54o75px74GbgBVuQOznDQtHJbNbi6YOhG7FSQzWMUyKRx0jmy6+FRsyqIWrn
         MOQLEZuPQdFAfoJXgkfCbzdV9LSlf4VWuKNkTbF6hq4EB5DMkSi8FjoRZMWvp7datJ
         r/sVHGwJj//OA==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [RFC PATCH 0/1] Attempt to add Sponsored-by tag
Date:   Fri, 18 Aug 2023 00:09:56 +0200
Message-Id: <20230817220957.41582-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIjxsLaZGIR7DNFbha2F2Ri14pnsw6afb2YXf1VMxSJbADvnJRM4obQbbNq/bKrC8icvRTOUkB5JQgrsahFEetbH3tR0IAQeOuiaRs0mJXmW5ypf3CBH
 hgiXE0xCEsrMdEqoO6NC8vFd4ppgyVex9glFP7Q8Qzl/6p9M4EszS2oJ9taz8cAELZE3LETVwRrcNZKWE821k4w2YLKEhot1uLRYoSXvetd/nfhSqSWYTIxo
 Ht2fqPXVVddnLZKexam9OUQfKePd8IZtsL0qp73WApn3Qe3bkAb719suT3G7krc9w8kksZIbFB6TF/eGmyV3sWqBMY1MIhR8xqChR7m36eAHam7yKB2gLw7k
 94b9ggoHIGjbw+JZsmN0emlPhihpJwfVYLzQ/t9I4Pjz0Gfr3Zc=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

working as a consultant for some companies it happens to end up in having
patches that the final customer could be reluctant to send upstream for
many reasons. One of these reason is that at the moment he would not gain
visibility except being added in the commit log as Cc: as far as I know.

What I've been pointed to by someone is "Sponsored by:" that is not a real
tag and it's been used not that often, for example here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=73c289bac05919286f8c7e1660fcaf6ec0468363
And as you know better than me:
$ git log --grep="Sponsored by:"

As explained in the commit log of the patch this is an attempt to define a
standard Sponsored-by: tag including a method of acknowledge on sponsor's side.
The goal is to possibly increase upstreamed patches giving the chance to the
sponsors to gain visibility.

I hope someone likes the idea and that someone could help me to improve the
description in the patch because I'm not an English mother language.

Best regards
--
Giulio Benetti
CEO&CTO@Benetti Engineering sas

Giulio Benetti (1):
  docs: submitting-patches: Add Sponsored-by tag to give credits to who
    sponsored the patch

 Documentation/process/submitting-patches.rst | 38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)

-- 
2.34.1

