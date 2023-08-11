Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FF877896B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjHKJFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHKJFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:05:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9E02D5B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:05:43 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686bea20652so1597190b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691744743; x=1692349543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lHSv/YVXMKpspOcEGk2QclmqStPYbocP+X+PUc9NxxQ=;
        b=G283etGUt0OE1lwUnqMxEyCvWRSgiWIMtaR/HKnbDPmjRhnPWzTTMMi9h2zJ1IXno9
         8yzSzQRynCiUZYNklGWhaX5jYvw3x75XIfTWzwzaUI1d+sYFX04BKpR8v/JdXT5i0FT1
         Xzoe4EsLkHtlYC+8Sx+I5ibFxKBnKvEN+cntn34PtbFjE8TkVE5IC4y7LjJ4o5G1Pexw
         AVgzeZtyzH1Tgr/wVeExwoxVGIq4ZfI8KkroP47isWbGsyV+ZgzI8D3sFBBqX0VefWzB
         4/5qQufBpu9vzwSsMkcdn1vb8Si1eOixu9VRkCRe3ZDn02ePViYvyB6q6XZKevY6UZnJ
         fbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691744743; x=1692349543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHSv/YVXMKpspOcEGk2QclmqStPYbocP+X+PUc9NxxQ=;
        b=Vd4AlMCh0mvgoMGVvKRN0QlujZl7128w4UTPbD4ko8+ki6+NnMwj3ZrgQpps4wQJaz
         jb4rp4iDfbJODO12PnSXJui+oRJea7C84pJxus4B3fOK1P9M3UIgbV8I1LGXy2fn0skX
         kN45zcXiQ3+hXRBkSK1+VosqZjfiNA/ZLdx3C5dE6XFvqwtBib+sM9oaSXn7FsnDHxK6
         4GArQNItU/ylfWR3Crr0y6UNjGhunWIHSvUeL2LpFOpgMcL9xnWfyXBz6LRszfDN3kQE
         Ielm/QGhey5psXKXaLEJbj8HtaizGq925u4KbK/8ijnNshfNu+0DEGBf9iMsIGDH+8Ge
         Yo7w==
X-Gm-Message-State: AOJu0YwfMREnRAJ7LuAK9l0sBJpLd64CXpKW2W+0DzDYuFpFZzK/0p9e
        pqYr5++PL0QsrQPQrH89mO/r1THJ2DnPb0zwXuys5Q==
X-Google-Smtp-Source: AGHT+IEm6DIidm5roF+w0VAhjyyDNQSZPxT+h7dFVs7QEpy+4KVgGjI2Vh6DGfPLO3+reEdVRecS1vHi1vYaSJsjyww=
X-Received: by 2002:a17:90a:fee:b0:26b:e2b:6c8d with SMTP id
 101-20020a17090a0fee00b0026b0e2b6c8dmr893454pjz.41.1691744742843; Fri, 11 Aug
 2023 02:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230811034600.944386-1-anshuman.khandual@arm.com> <20230811034600.944386-4-anshuman.khandual@arm.com>
In-Reply-To: <20230811034600.944386-4-anshuman.khandual@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 11 Aug 2023 10:05:31 +0100
Message-ID: <CAJ9a7Vicj85s3kbL7110Vc9UZzSG8Rk_znCjcAn9LHF8EzqD-w@mail.gmail.com>
Subject: Re: [PATCH V3 3/3] Documentation: coresight: Add cc_threshold tunable
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 at 04:46, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> This updates config option to include 'cc_threshold' tunable value.
>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  Documentation/trace/coresight/coresight.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
> index 4a71ea6cb390..ce55adb80b82 100644
> --- a/Documentation/trace/coresight/coresight.rst
> +++ b/Documentation/trace/coresight/coresight.rst
> @@ -624,6 +624,10 @@ They are also listed in the folder /sys/bus/event_source/devices/cs_etm/format/
>     * - timestamp
>       - Session local version of the system wide setting: :ref:`ETMv4_MODE_TIMESTAMP
>         <coresight-timestamp>`
> +   * - cc_threshold
> +     - Cycle count threshold value. If nothing is provided here or the provided value is 0, then the
> +       default value i.e 0x100 will be used. If provided value is less than minimum cycles threshold
> +       value, as indicated via TRCIDR3.CCITMIN, then the minimum value will be used instead.
>
>  How to use the STM module
>  -------------------------
> --
> 2.25.1
>
Reviewed by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
