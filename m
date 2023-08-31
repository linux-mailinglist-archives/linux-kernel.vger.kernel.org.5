Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560BC78F450
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347465AbjHaU4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbjHaU4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:56:48 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D238ACFE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 13:56:45 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1c4d8eaa8ebso785736fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 13:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693515405; x=1694120205; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4KEw87/vvOhiR1QFpwjWnIxbs8bTupPtRnvmmCM2ldo=;
        b=FWCzeBdNFNPGwfbjV8C7/TVnvd+z/gc0prpBoNfVQYD3hPn2tB4LFYGA1ivAiFEwYS
         ChUGdI4d5P4s99WdMmgderk6L4s99XnsEX1TvsdtdTTj2k/tqWrqaHcaiTMcIZGVbPOB
         JRmV0rsHaorB9ctEd4GYXxcHR+2SZm22qhVZkRTVN9zJG8Pte1e1V1dxbdxpobr96qhX
         0uWPwGyHkuSttp5MOJ3t7Pqj0HUgS188oFGnxnMaP9VglDfdZq8Z5Q1SvLdp58NQYZN1
         dHBwT6r78vXHKavJtDdrgUOpSf0M++idfQoMJfVym1ix+JvSj/UGL8CvDWa9X6I5n1Kv
         AsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693515405; x=1694120205;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4KEw87/vvOhiR1QFpwjWnIxbs8bTupPtRnvmmCM2ldo=;
        b=LAcScHE59clTNpiERuVd1v/f6OMvk5Xg4JOvPxIS8KX5VCB7J24GnP8lJP3L3DxEue
         5tv+ObSRKV5n43ejME54o7yQaeaesH9/+2R+48dFMMrGy5HBJWJ44sXUUg1/bUvhBAMa
         lwMZhmAPK5GQJfqY+i5DWfqyI3+sELkJtWOM3xC7x62fgOtWcMCPtd7aC9Yw7LY/AVbo
         7MNlErRwMuXGYbTKhqhe2BaWAz1eTNCgvAo3ZqHt5ppy6tYkU2Q6fJZn9aXbNiJviZ/B
         HD8D2ClV1JwgoO0oI6ZHGpGvgBfk6QKqwfObHtfrhkrLug3fcqqI3Dl/2lTrWgzTxcmg
         dR1Q==
X-Gm-Message-State: AOJu0Yzy54N85ZM+wVNZuMkG5xcKh2+VzchbDDf6CK4Z8uBnxGVyOXmJ
        j7//g6eNoWhrzBQH3zE9VRa/BQDgqTk=
X-Google-Smtp-Source: AGHT+IFuPKGyV72OAOzy5Z2YacZYlY6BSjljcbGWZE6zH/4LnzXf8ctK1GJSz66ya9ZMUbALO0hSCw==
X-Received: by 2002:a05:6870:2189:b0:1d0:e371:e95c with SMTP id l9-20020a056870218900b001d0e371e95cmr542020oae.40.1693515405078;
        Thu, 31 Aug 2023 13:56:45 -0700 (PDT)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id l8-20020a9d7348000000b006b753685cc5sm1109039otk.79.2023.08.31.13.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 13:56:44 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <6738ca0d-ee66-7dde-3307-e8a55a115757@lwfinger.net>
Date:   Thu, 31 Aug 2023 15:56:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Comment on "memfd: improve userspace warnings for missing
 exec-related flags"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aleksa,

In commit 434ed3350f57 ("memfd: improve userspace warnings for missing 
exec-related flags"), your changing of pr_warn_once() to pr_info_ratelimited() 
was justified as it would "... incentivise userspace to switch to passing 
MFD_EXEC and MFD_NOEXEC_SEAL, we need to provide a warning on each attempt to 
call memfd_create() without the new flags."

It would be easier to get userspace to implement these flags if they were 
documented somewhere other than the kernel source. The man page for 
memfd_create() does not mention them at all.

Larry

