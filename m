Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4263C7B3A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjI2TVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjI2TVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:21:22 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A511BE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:21:20 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c5db4925f9so7955615ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015280; x=1696620080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aEgZXilDM7YqBibwIo+3j857Ar2xHuwGZYUU0Ocu+c=;
        b=KBQFpB+xfDNFWIHHlTi8QcXz/jZ0iwk5l+DciKBf/dTkq9SlUE9risbenp90ibST3n
         Kbysj2xIXUkG1rlhFosXoOrkBv0hAuuhlKUdOt1d9oFxQjTPH2ZMuMOL29UA9Elip+KY
         xIWO8JdS8tlWRm6DNdbK1WttiRtIdY6AEV3Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015280; x=1696620080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aEgZXilDM7YqBibwIo+3j857Ar2xHuwGZYUU0Ocu+c=;
        b=jjrklaVttQoXeotpXDGUI2vKOI8FdjVsjpUEvbYRoej0frF2WgU4dxYhdrDYaEjIkz
         4/tFGBaZLxsM1CPHU/jjoFjm+UTgq46oZ7kIqjpsL9Kx4pbGrK+3/PLlRHNywQI4ISE/
         KC6xSwf+IlysyYxA1WYF6YcjjOBx/MdNBLPlmpBHB5kFVvxUzgAGgtOu8Gjd8hEQ+3S+
         qG4yy0lV+iEbQnSD8UI6bNILF+b664YcxJ2Sozasfwny7tnKUgirOJZuKK+LjeBildFf
         SwNcsCA9M1v7dE5a1WHhJFDhc6rmF/YHbHg+o0aM/NZll51qc3zv0N/gQwzDapYFGAP4
         gWGA==
X-Gm-Message-State: AOJu0Yy1B5mhz08r2qgZv3ftbgzk9xIO+PWAMQhS4fOlbSPM1irk5/+4
        BDZBPEunAf7gL2jHxWeDXKuGMQ==
X-Google-Smtp-Source: AGHT+IG2g06b1pAU8D9HLnGJFm+KvBiJ8WwyJ5eZb/HgchXrkfd9LQ+8XwPTFdERaFnnLTfsp/xOhg==
X-Received: by 2002:a17:902:a416:b0:1c6:362:3553 with SMTP id p22-20020a170902a41600b001c603623553mr6067189plq.31.1696015279776;
        Fri, 29 Sep 2023 12:21:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902cec200b001c5fc11c085sm13354610plg.264.2023.09.29.12.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:21:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Song Liu <song@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     linux-raid@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] md/md-linear: Annotate struct linear_conf with __counted_by
Date:   Fri, 29 Sep 2023 12:21:09 -0700
Message-Id: <169601526973.3013632.16756928162777602693.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915200328.never.064-kees@kernel.org>
References: <20230915200328.never.064-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 13:03:28 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct linear_conf.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] md/md-linear: Annotate struct linear_conf with __counted_by
      https://git.kernel.org/kees/c/9add7681e09b

Take care,

-- 
Kees Cook

