Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2799E77EA94
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346099AbjHPUSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346098AbjHPURn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:17:43 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CF81FE3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:17:42 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-589f986ab8aso4426597b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692217062; x=1692821862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yoA5WK/0uc1JA9NlQAR2O5bU2n5BQS7MIRaQAabqBoM=;
        b=mhpTjpDM1glOJHrEgE2eFtivXw3aC/5QA9pyayoKiN+CgEZxU0F73rwtlXlEHtX7QW
         33o8gOt0Ut5GQTug/OIUX+YsY23sQNb9Ub+Y5yP0wy1iHN+HzYtll1LScY/8Cy8cjEhu
         sgmDD+TtjFkev14pSkENjg64c1eNtcBoP9uN/v7ECZU9xXasC0dufCz/Rx+r9QtjB3wY
         q0+0F78dpbbZxwoRKPKTljN8WEzqT42aS24zOwzVxosa7LWJFtfffxlrmvDj6KT7dyPQ
         rZHHKY0m7nFm6avryDdkN3Lv6Bl5TwKXe5Dcs4oJbo/dHA1lZirAs5fFaQcwdCVVpx0u
         rbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692217062; x=1692821862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yoA5WK/0uc1JA9NlQAR2O5bU2n5BQS7MIRaQAabqBoM=;
        b=kZ1hGmkNkxLQIpbplQFnNrIzL0lgdtHeHwv4EeKkz2e2CZcrq+ErASfExctQwjX97s
         GKIO/ctfCTBUBhy6w003fL1yBL67pnMvOlJoCn1M7tYYdwclboNEHOfPgJIdkMPvA9gl
         LWIW+R0drVW/g85sR6Y9uCmcMBVoIkKZLFnI/YCmcxTeXXr98m5/9rL9Ulvg38Q5+0Lu
         yRYUulFDQQu593KDLa6vQn/KxmPMw/0lZZn37Xgb1wi2w6p+pqv2c7Ct9U1JXOWdaPSI
         +tyxn2AuRk+J2gURiELL1hOjUjK/+p1LpjW3tcD/eLk8J68Rk1cVpCK+t8MH3OFX9TWJ
         63FQ==
X-Gm-Message-State: AOJu0Yz5CUMfw7ydBxuFfolYOGOcm6uHn8s6R+0zNC1cT0kz6qSlJIO+
        3chYw4sCfbf7kKZt5U9KUzbBZFX1EYeSLw==
X-Google-Smtp-Source: AGHT+IFevQvGqpzjHfpQG8iwIogT/KEfB7t4szppLqZklUi8Wl+S9ndXZtYxYDagPedWUw7lwkYkQU9h3uR45w==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:29a])
 (user=jmattson job=sendgmr) by 2002:a05:690c:460a:b0:58c:bab1:cd23 with SMTP
 id gw10-20020a05690c460a00b0058cbab1cd23mr11723ywb.2.1692217062148; Wed, 16
 Aug 2023 13:17:42 -0700 (PDT)
Date:   Wed, 16 Aug 2023 13:17:00 -0700
In-Reply-To: <12a12721-239b-457e-1ff7-f98c02cb7abe@intel.com>
Mime-Version: 1.0
References: <12a12721-239b-457e-1ff7-f98c02cb7abe@intel.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230816201700.589822-1-jmattson@google.com>
Subject: Re: [PATCH 1/2] x86/microcode/AMD: Load late on both threads too
From:   Jim Mattson <jmattson@google.com>
To:     dave.hansen@intel.com
Cc:     bp@alien8.de, linux-kernel@vger.kernel.org, stable@kernel.org,
        x86@kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 13:15:42 -0700, Dave Hansen wrote:
>On 6/7/23 13:03, Borislav Petkov wrote:
>> On Wed, Jun 07, 2023 at 12:36:53PM -0700, Dave Hansen wrote:
>>> What's the benefit of doing the loading on both threads?  I would have
>>> naively thought it was just wasted work.
>> I have the perfect example for this, see:
>> 
>> e7ad18d1169c ("x86/microcode/AMD: Apply the patch early on every logical thread")
>> 
>> so it is for reasons like that.
>
>Yikes, so the second CMT thread reports a bumped version but not all the
>_effects_ of that version?  That's, uh ... fun???

That does seem like fun. :)

Borislav,

Is there any way to tell that a microcode patch has been loaded on only one
thread? And what does this mean for SEV-SNP attestation?
