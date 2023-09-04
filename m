Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC654791BEF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 19:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349713AbjIDRTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 13:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjIDRTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 13:19:20 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92709CF6;
        Mon,  4 Sep 2023 10:19:17 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-56e280cc606so291533eaf.1;
        Mon, 04 Sep 2023 10:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693847957; x=1694452757;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=24pYO6KCUTITZlOhkZXcimEpdDIN9QLHkCC8dT6sds0=;
        b=PFEx5iFdfYZextQsXqk274SS4fQJHVOU/+g2QW4+F579twItYGQ1ASdpyc418BJIvT
         U+Pgnf9DojcZbJVYhTx6/r2qSVZG/DAgwsvbU6RjWTKqKvGsnFxQeVYTfSkwy3V6Lr08
         NkNCBvr645hsYD5LtD9HMFbC0cd47Ql8UgbtbGuFlI9aX5HLMjskgUPVSF9u+aPfRWaE
         2b6euL2Kt4gNVQSp/+eLDz1PI6Ej1tU21g+Jq5zMV+SYAWVxHdkEAmVIQC72cnU/4atm
         OrrZ1fwNhgkKXKYOj1bFWMP1IrCgKqmI+ml19HMTccpGaP+kmZcQy5qDJAX12jx9/n/h
         Lniw==
X-Gm-Message-State: AOJu0YyoyOtPjReHvIY6xJf6W4hSqC9xIyM9LZSR7QEld2VOtTnspNBg
        aMEmTk/CaYbN2mgnTWjAs0Jn9hmR8FfhWQgdMlIlT2+UgpQ=
X-Google-Smtp-Source: AGHT+IEUKgxekH7MUxvV0cDre0uaeqK3LTCcjRT2xFhtfeNjwOBg2+IiU85t1MzRADtxRbacBA9mzDij+xUIQ0iq6OU=
X-Received: by 2002:a4a:db89:0:b0:573:764b:3b8d with SMTP id
 s9-20020a4adb89000000b00573764b3b8dmr8723990oou.0.1693847956804; Mon, 04 Sep
 2023 10:19:16 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Sep 2023 19:19:06 +0200
Message-ID: <CAJZ5v0jd9Htp-6duGjtZUsBDFkm26ndmTD9cSG6s_fcF22sP=g@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v6.6-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.6-rc1-2

with top-most commit 19a56a6b747716118539398739b021535eaa8cbe

 Merge branch 'pm-cpufreq'

on top of commit ccc5e9817719f59b3dea7b7a168861b4bf0b4ff4

 Merge tag 'pm-6.6-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 6.6-rc1.

These fix cpufreq core and the pcc cpufreq driver, add per-policy
boost support to cpufreq and add Georgian translation Makefile
LANGUAGES in cpupower.

Specifics:

 - Add Georgian translation to Makefile LANGUAGES in cpupower (Shuah
   Khan).

 - Add support for per-policy performance boost to cpufreq (Jie Zhan).

 - Fix assorted issues in the cpufreq core, common governor code and in
   the pcc cpufreq driver (Liao Chang).

Thanks!


---------------

Jie Zhan (1):
      cpufreq: Support per-policy performance boost

Liao Chang (4):
      cpufreq: Avoid printing kernel addresses in cpufreq_resume()
      cpufreq: Fix the race condition while updating the
transition_task of policy
      cpufreq: governor: Free dbs_data directly when gov->init() fails
      cpufreq: pcc: Fix the potentinal scheduling delays in target_index()

Shuah Khan (1):
      cpupower: Add Georgian translation to Makefile LANGUAGES

---------------

 drivers/cpufreq/cpufreq.c          | 53 +++++++++++++++++++++++++++++++++++---
 drivers/cpufreq/cpufreq_governor.c |  4 ++-
 drivers/cpufreq/pcc-cpufreq.c      |  2 +-
 include/linux/cpufreq.h            |  3 +++
 tools/power/cpupower/Makefile      |  2 +-
 5 files changed, 57 insertions(+), 7 deletions(-)
