Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51F9766D54
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbjG1MgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjG1MgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:36:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0797187
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:36:05 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe110de46dso3363085e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theentrepreneurhub-com.20221208.gappssmtp.com; s=20221208; t=1690547764; x=1691152564;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6TO6avvHDJamgdpoj57S2aPvkVsdalubgYk8UEwddwY=;
        b=MtOZe6q3Dc59VF5lDIcRywch33fSKtoP/lfULo8SuVuuMDRS8ZrcmpT2UWeNYtDUhM
         gsHQ0BQHL/U6GznyowFxspHFRZkf25K/PXnzpCHr9+MEi3Z7W8rsUv6yTVQ3gFsVHYJD
         c2wQtX6AjgUIf+gPFa4+eZxEESl+IlXgbDlD2Xk4AzqdIow4jYfxBBTqa5NMfl41loWk
         1sz1dR1VriAkeQDnr8Cf9NEpk2mlwDEwQttmOxXdQYx+wyqE3oupUOT6HeloToJISI/9
         YGGGLcxG7HG5aeOhC+IiuLJwqqqfWpPBf9fdyWKCjlP59IlVysRIKBIUf/s7P9PeyUXS
         kGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690547764; x=1691152564;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TO6avvHDJamgdpoj57S2aPvkVsdalubgYk8UEwddwY=;
        b=R13K91cnU9srgbzfh5juw5R93C+Pl+z99rImO4GJc0KpTrNajPrNVU8qMuIi60e5iV
         ppzO7gklYGlb9g8kQwgIoUcIK9FJ0RI4DDnIvMaDCO1aBfxScBCrjukJRW2f9bEZf3wz
         MN0Bs3Qa2bkj7scA0jkauTqRO+u17SFwb3/mZA8nwvwp1aeTyAi+qajs9q/MOWnHOMsE
         9ryOkjPekEFskS4pRXurMWtLdkC2OyLTjZnvF2v2eWACVfefYWiwLoqGeZoHJIqWoew3
         jDkzlBfDQKcH7dhXpRfEhe6DBLWdo6enAHZ5qLenCoiRE2KSOspJ6TGXqoO/oTAFrN4O
         fEAw==
X-Gm-Message-State: ABy/qLaxtN+K4w/uWlqb8KoHLv4cSDihqFhLxy+PuwvK7ZwkxlUX1Pe/
        QmblraUm1YFRk5mIcnKkkwpYTN8z4n6FOoZ86XYgqrGNfqwaqi2m
X-Google-Smtp-Source: APBJJlGoG/ge9WRAaeboTb/VdO/XCmoE5VDcWtEuJvi9jALOIkwvzeZ+Zf/356YwoXjuS2KTJvhSDAFE4iftapkXJ4A=
X-Received: by 2002:a7b:cd86:0:b0:3fb:a506:5656 with SMTP id
 y6-20020a7bcd86000000b003fba5065656mr1605595wmj.32.1690547763952; Fri, 28 Jul
 2023 05:36:03 -0700 (PDT)
Received: from 1060064454459 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Jul 2023 07:36:03 -0500
MIME-Version: 1.0
From:   Michael Stephenson <information@theentrepreneurhub.com>
Date:   Fri, 28 Jul 2023 07:36:03 -0500
Message-ID: <CAAbNKKBeMwBoVvxX8sSBZ6c7HnCRXk-D8KfjpYZXwkivVzAQTQ@mail.gmail.com>
Subject: Can you help me with something?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to write a guest article for your website about how to
achieve a sense of fulfillment in life that includes both a successful
career and a fulfilling personal life. Wouldn't it be wonderful to
feel that way instead of merely going through the motions each day and
checking off chores as they are completed?

My suggested material is free. Anyone seeking advice on how to
actually start living will find insights in this unique and helpful
piece.

If you're interested, let me know. I'm eager to begin writing on this
important topic.

Thank you,
Michael Stephenson of theentrepreneurhub.com


P.S. If you don=E2=80=99t like my proposed topic, please send over a couple=
 of
topic options that work better for your website. If you'd prefer not
to hear from me again, please let me know.
