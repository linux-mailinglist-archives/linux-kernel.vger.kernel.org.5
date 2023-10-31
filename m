Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEED57DC594
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 05:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjJaE7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 00:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJaE7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 00:59:08 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDABD8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 21:59:06 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40859dee28cso40635035e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 21:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698728344; x=1699333144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PljP2ZlMmz2gyqas2Dp8d470o4avl70xl7PawNITM9c=;
        b=OeqebChS4eewUvU5kM/EAEW2K5TdHp/emeoldnQnkYkpELl/b32jQ8gZl7nfAJF5PW
         xwxnum85pVlji99Iv+sdnxoDwwkQuz7yqcUtQLoJfGEWjD65eK48k9XeCPW8/YMMZ5CZ
         0f1dhTARkipBQLu0ieUPZzFEoC+MAwZtt2pI4ZeQ7jU5O2IEklZFuvmz3xWPBaAk/F+5
         txVRsxsVDbzR+U8GO6TOGPExruzjXdxJEvnTgCvWTuMbXYj/eyO4dv1MtiSwSPjrlw/b
         Ylpm880jYxkzw1gjEl0tBM1PiUbgA6a5VzcKGDzuulws4xxie6TWelaTGVnWk4sIWLzJ
         TrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698728344; x=1699333144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PljP2ZlMmz2gyqas2Dp8d470o4avl70xl7PawNITM9c=;
        b=rYIGSPBZNIHhzRCpK2iF82iv0vNx2qvs+c9OP+2mpKpLgNlCxlzJ6zQWRalClOAFl/
         ff5Ob2CEJIGoJ7efTt9DX1hbA33qbnzuL+B/823kjDCgAdH7PBcrCZv9PU+DqXloNsRb
         DdQL3F4PDz21YljQzOkuNbfw/BXnLlxAs6RVsH74KAh7P6h0W+9W96GZDuM4210wwTdC
         +nZn33giJdu8yhdzHCzxtmhN8KEUCpV3TqGUoGhVH2bOmVZkIrx4YZNctKj2La9ho7hl
         BVWOy4D2Fvdd3JsaU0OGERRYCwYxxxqhuPlB7XKvMJKOkaepyp8dXNL1YSt2sFMJTRT0
         LV0Q==
X-Gm-Message-State: AOJu0YyQBzJyRVuxwaxWM1gw4zvBYRDS2SjytJ9NBkH6vhiwBPZwcGci
        3KsoEezseS0b2JzZYsayvRoMUg==
X-Google-Smtp-Source: AGHT+IHl2RxQhcYli6doIjuXiHUCX9R4OS22iOsiqPg2Qm2jYD5SfrmNDoelI7hrqYtqna0ZPpIvIQ==
X-Received: by 2002:a5d:6142:0:b0:32d:b081:ff32 with SMTP id y2-20020a5d6142000000b0032db081ff32mr7305820wrt.38.1698728344664;
        Mon, 30 Oct 2023 21:59:04 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d6542000000b0032d09f7a713sm548908wrv.18.2023.10.30.21.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 21:59:03 -0700 (PDT)
Date:   Tue, 31 Oct 2023 07:59:01 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Nancy Nyambura <nicymimz@gmail.com>
Cc:     nicydaniels@gmail.com, outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Staging: rts5208: Replace strncpy() with strscpy()
Message-ID: <cd6b1b25-1c93-47ce-b15b-726cfe548a93@kadam.mountain>
References: <20231030142751.49913-1-nicymimz@gmail.com>
 <191cf6e2-6a46-4813-a0c4-c86bcf9bd0b2@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <191cf6e2-6a46-4813-a0c4-c86bcf9bd0b2@kadam.mountain>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have updated my blog with more comments and examples.

https://staticthinking.wordpress.com/2023/10/30/strcpy-strncpy-strlcpy-and-strscpy/

regards,
dan carpenter
