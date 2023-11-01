Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1231B7DDE92
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjKAJih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKAJig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:38:36 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6E410A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 02:38:30 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6b36e1fcea0so5843728b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 02:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698831510; x=1699436310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nJ32eWzELmCR7Jg/2DMz4aLwcV9MkrO2EVOaqydkHlQ=;
        b=p3YvZgm7vuZ2FwtU4YNuKVC23V2NiYoPlvvQPAp4Rz7yXNSXNOuK5GIixEEfoV4Pyc
         3NOYslmsYPSzy8xnrWQWm3pIbNRRAsWAGQx1CMfN/h57idRe8vKCdahJSJHJeU+aYGAa
         Ko9++Xn5Qd31DEdbFOoUz1v9EWzj71zJaiY1+v6nNAuhzVSkZuW4UirURaBaztroZPpT
         QlvF8sb3GHq2GCSkFV5gT+sQQX1ziNyqXHlVyThnL+YC8QiK497YcSmQhMBsedxUZaQR
         Gm5bf8wdkPkEJ2ptpKdZB+TYdpcp4FdPNm3e5RoHkqc5nDv6cCdt7m/g8dVL4i7L8U33
         W9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698831510; x=1699436310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nJ32eWzELmCR7Jg/2DMz4aLwcV9MkrO2EVOaqydkHlQ=;
        b=e2rovlwD0S8WBKosOQhQniT0BCAShWi3bz7ziFGVfokHXqaOu93earMGh/1oyQJUDY
         zcfqOvVDgOE6tJK+jWKdouaeUlWU1I71r28MH5zvWoQm2JvrU+M6/M8fU3gldje8r06E
         xBnkk2F6a03J/2ULWwMChJM7drvnpUHCO/bYgleaVz5CqLaY6h/1dKgB7QOclDUKy62n
         AavRawQfEXjF8hm+C6sYdChTLv/t5+Z9/0Lgsaip9hNHeyTa5Ld5jKFnzmws3u5smbkK
         PpThuB9f3JuPSub6cdZ6abvJRiVJhgErZHeQKSoUVrgU5tMcj4ZdpfaeCvMK00arMEty
         FZvA==
X-Gm-Message-State: AOJu0YwplXJ4FKEBghNLyqarZ13r7qNY3KMUv2g7CxEAJXZwaHpH/f/0
        zKfXuMD+mbim/gVIo0qQFDn66EOmnIgzHC/Z5JAeIg==
X-Google-Smtp-Source: AGHT+IFB8R43K9C30Duyzyhy43i26qsXyJYP/9VJqiEiyBMwGtMelTKfbKg0qAsKG4g4uNOWnYnx7J/9C+/gzH88lK0=
X-Received: by 2002:a05:6a20:8f03:b0:12f:c0c1:d70 with SMTP id
 b3-20020a056a208f0300b0012fc0c10d70mr15818067pzk.40.1698831509795; Wed, 01
 Nov 2023 02:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231030102940.115078-1-james.clark@arm.com>
In-Reply-To: <20231030102940.115078-1-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 1 Nov 2023 09:38:17 +0000
Message-ID: <CAJ9a7VgJAN_mPrFZ7vQLqp-GJRKrNfKirNiJYocS6ce7GfgPcw@mail.gmail.com>
Subject: Re: [PATCH] coresight: etm4x: Fix width of CCITMIN field
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 at 10:29, James Clark <james.clark@arm.com> wrote:
>
> CCITMIN is a 12 bit field and doesn't fit in a u8, so extend it to u16.
> This probably wasn't an issue previously because values higher than 255
> never occurred.
>
> But since commit 0f55b43dedcd ("coresight: etm: Override TRCIDR3.CCITMIN
> on errata affected cpus"), a comparison with 256 was done to enable the
> errata, generating the following W=1 build error:
>
>   coresight-etm4x-core.c:1188:24: error: result of comparison of
>   constant 256 with expression of type 'u8' (aka 'unsigned char') is
>   always false [-Werror,-Wtautological-constant-out-of-range-compare]
>
>    if (drvdata->ccitmin == 256)
>
> Cc: stable@vger.kernel.org
> Fixes: 54ff892b76c6 ("coresight: etm4x: splitting struct etmv4_drvdata")
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 20e2e4cb7614..da17b6c49b0f 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -1036,7 +1036,7 @@ struct etmv4_drvdata {
>         u8                              ctxid_size;
>         u8                              vmid_size;
>         u8                              ccsize;
> -       u8                              ccitmin;
> +       u16                             ccitmin;
>         u8                              s_ex_level;
>         u8                              ns_ex_level;
>         u8                              q_support;
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
