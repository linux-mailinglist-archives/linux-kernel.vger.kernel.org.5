Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8727FAF1A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbjK1Aei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbjK1Aeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:34:36 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D039D62
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:34:41 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cbe5b6ec62so3841859b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701131680; x=1701736480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhnUEdFFWqGuqKk7HcQygs9znr/gnHSS65isK2aLNIQ=;
        b=AYy7QYf+oxjKLHl7ebER8TWBRE7sFj2W3Ya6tRqK/J4hi9ekwxJfIzRe805o0RyRri
         iYTOy3iuOqf9qcARwoQhMl2gwz4wO0t+nNiIrGGfVBvYhuxdsPAmoJd1fq99qwl5C3y1
         F82e49ZcFss0zdDxcrQWu+JX031MpUN6C3EZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701131680; x=1701736480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhnUEdFFWqGuqKk7HcQygs9znr/gnHSS65isK2aLNIQ=;
        b=MC8tOHtHm6yx4X7kf4kGPZCW7ympURnLZ2l0VSsuyZoFwvaQWC4C6TC3sQpnAZOarw
         +S+rc6ZDmT/tfWV72xJZBVFhRL0rbtkpZJW5pO0HdCLhbqfWKkrRKc7vROPmOVclIMyN
         /I7HW//ilZYOzgKEaEBGcy5eOUtQ9KjWRd7CitVLdgQ1hmKIci+Ih3gdZJzbrEPJ1ZJl
         S5w4ekE/+icvCmZIKm4/eoNFuon5Iu4PNdaZgksCYNdpg+4A8EeNLmh6un4UZz8HSZYw
         hf8ydRC9A16dVDnTVwG2ALTIV3thbLKWHPPDWJIxsNEAcZk39d+RsAZDgugRfpbhBWbP
         3Tgg==
X-Gm-Message-State: AOJu0Yx3NVZinpnD5x3/5EarxOFNPlkQXDq/L+HPe0Fnj3MdQfQe9qqj
        05Vhs0n8Vog/VXvDQ8+gsJ+Z+Oill9XCZ/ROxkw1TQ==
X-Google-Smtp-Source: AGHT+IH8yKr0KWQ8B1QkVC6xlixaU8xQM4arSGv8CqVXdwMbGLUcg+jOsXYMMokJ9vwGI04H0p1cVw==
X-Received: by 2002:a05:6a21:a5a0:b0:18a:e40c:682f with SMTP id gd32-20020a056a21a5a000b0018ae40c682fmr15260148pzc.41.1701131680675;
        Mon, 27 Nov 2023 16:34:40 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i23-20020aa787d7000000b006cb4b7ffe2bsm7647456pfo.195.2023.11.27.16.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 16:34:40 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] gcc-plugins: randstruct: Update code comment in relayout_struct()
Date:   Mon, 27 Nov 2023 16:34:36 -0800
Message-Id: <170113167459.1670911.15084763564199264156.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZWJr2MWDjXLHE8ap@work>
References: <ZWJr2MWDjXLHE8ap@work>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2023 15:49:12 -0600, Gustavo A. R. Silva wrote:
> Update code comment to clarify that the only element whose layout is
> not randomized is a proper C99 flexible-array member. This update is
> complementary to commit 1ee60356c2dc ("gcc-plugins: randstruct: Only
> warn about true flexible arrays")
> 
> 

Applied to for-linus/hardening, thanks!

[1/1] gcc-plugins: randstruct: Update code comment in relayout_struct()
      https://git.kernel.org/kees/c/d71f22365a9c

Take care,

-- 
Kees Cook

