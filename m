Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603F97EE6D4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345460AbjKPSgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345391AbjKPSgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:36:20 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D73D49
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:36:17 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77891f362cfso95132085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700159777; x=1700764577; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFS/mwZ3/EMPWQv8aFv2yBhjsP3bkWDq8nS9+OIYTm4=;
        b=ceoK0HoDSrGdd7Nfl/LT94wHU8u9n0WMujqUE4uMP1d5PnWECBfTyqDd/NfwNcxavx
         u5EEj02DGrRi+FYXYVbBhfYt9QtvUj3jR+vvW+dHoY5+KwRAe2IxHLsXc9zqW5+uYPRK
         ZyMnIhfgtrBT2RkFBl+AbjYeGUFnQmaMqAH0MUmrosIs34Pm4Aanq2xmkkGi2ho7Gpiq
         Oc8ncqO66qBnvvbBFOh7Pioa9b0U++4M+4Zb4D0eFyIRMd5+caDI45C/t0rhMFHFSqnS
         HCcyy3uynQwBr8HUbjPuoo5jy68XtH34o7zkA4+TcjdAwwZEKntKK2QnABSZtEUEj8S4
         yf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700159777; x=1700764577;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFS/mwZ3/EMPWQv8aFv2yBhjsP3bkWDq8nS9+OIYTm4=;
        b=ltRSrLbL3NEGSrL7hftpiVmV2ZKE64/oYx0AlW9Oe5vYmy9xFYUjkX1h61etJFWuC9
         sZ8HG0xLJKglfOb/OdHfnMVKyeNIMUc+/jdQSKCiC/G7X7DvJukrJXSn2ESY4KMbvof1
         eINehgGZmKtpPkW6TlxyxqssOfQlWTvgJHnBAa+2RV44uBA6JRnU069rLBOe4iskZw2D
         tV+m9N2c+hKwCD2WsrCEjbNBIRzz1zwl5dqaCrhDVaIZbix06qZLkTLKQ5tWwpapYxhZ
         nUcCRARubC2mqVYPLvXfkq1rCCWshN7GVRE3hUaOo3Y0XcGD/l4gbDYMVu4XIGSRlHtd
         PeEg==
X-Gm-Message-State: AOJu0YxVe1xnmKNxAfXbTmsBXYLtTiEldkE5r0ew3D4g4elyUAS4l0b6
        6301hO1lK/UYFukL9wPsKZujZzZHEC1xQig18w==
X-Google-Smtp-Source: AGHT+IGJoyomQm/pmBe6nkCyLo/F12BgpdpfzeHoSwE6LR04rQx4RUiHgfajMV/4nXhhyUdS8DVx/A==
X-Received: by 2002:a05:620a:254a:b0:778:969e:3a0c with SMTP id s10-20020a05620a254a00b00778969e3a0cmr3471880qko.27.1700159776751;
        Thu, 16 Nov 2023 10:36:16 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id pr13-20020a05620a86cd00b007770d47c621sm5830qkn.66.2023.11.16.10.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 10:36:16 -0800 (PST)
Date:   Thu, 16 Nov 2023 13:36:15 -0500
Message-ID: <b12021b40ddc40827782a4f55f7111e2.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20231116
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

One small audit patch to convert a WARN_ON_ONCE() into a normal
conditional to avoid scary looking console warnings when eBPF code
generates audit records from unexpected places.  Please merge.

Thanks,
-Paul

--
The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20231116

for you to fetch changes up to 969d90ec212bae4b45bf9d21d7daa30aa6cf055e:

  audit: don't WARN_ON_ONCE(!current->mm) in audit_exe_compare()
    (2023-11-14 17:34:27 -0500)

----------------------------------------------------------------
audit/stable-6.7 PR 20231116

----------------------------------------------------------------
Paul Moore (1):
      audit: don't WARN_ON_ONCE(!current->mm) in audit_exe_compare()

 kernel/audit_watch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
paul-moore.com
