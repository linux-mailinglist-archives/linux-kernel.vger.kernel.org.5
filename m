Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8E47662A8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 05:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjG1Dxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 23:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjG1Dxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 23:53:43 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB0E2D64
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 20:53:42 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686ed1d2594so1628284b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 20:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690516422; x=1691121222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=He4/7ZjAaJYV3oY1Q5qsfXRQN2c+aw/i3Z8upeCFxZY=;
        b=UJJSmsvKuA+7vHlEK5zqxwvD8B6Yt8XfXuAItoiHvAj3OoqGrALOYkCYQccCqOBd5Z
         tmtMhmnK6zN87HaVH9ygwQIQdC4SZMGydBwDwFW+ZmxwVd+Yinpn/4wGAvXFE++zJAos
         O2FXcKEu9fLVqrGMsoLKFn9LRJ/AlJZ69+Cpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690516422; x=1691121222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=He4/7ZjAaJYV3oY1Q5qsfXRQN2c+aw/i3Z8upeCFxZY=;
        b=S9bUCgh1DKwOStV1Zc4mTN/QRAqcrDfVMZy+T4/nJwMnVHQvB2kLNiUJcUqCDd+AS5
         8MMK5WC4ogL87/q7Ny9MC7XpXqtq/ucuXDnhC51RLbHWNnQGtv18FEtxkYRxBWsorKMB
         FPA05e5iaChuo/nya87vkMyQHKERRAOf7bRukoAZTGb0hIzxVZPRm8t/cUPTgQYEySp8
         b47kaENi5e6bMKmaN4/HtgGEwclsW3PD8z0tas6OUaWE7F8Xp64ZfHsYfyY5gisX0j1q
         rQMlNC2SS/WNgHgYlU3wjdTxhyb0KxfcLkaqb74akennZAJ7+BQknHyow19pCcAh0k2W
         ZomQ==
X-Gm-Message-State: ABy/qLbA0PljGYOcrlcYboCxkiNepAOGA9Wb06/0Et20RG9IBAVa3kvY
        H1TU3pieTAb6rgUPkQKlshehow==
X-Google-Smtp-Source: APBJJlGsTHxAEzSXpONNRDxyKgcp4KNYdrSE+s2zmuMCZXMTXa7hKLkFVzAtadS71u0jqoE5bCgxyA==
X-Received: by 2002:a05:6a00:194f:b0:680:2b80:8479 with SMTP id s15-20020a056a00194f00b006802b808479mr868615pfk.19.1690516421816;
        Thu, 27 Jul 2023 20:53:41 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:9314:7aae:8542:aa2d])
        by smtp.gmail.com with ESMTPSA id d26-20020aa78e5a000000b006870ff20242sm212301pfr.186.2023.07.27.20.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 20:53:41 -0700 (PDT)
Date:   Fri, 28 Jul 2023 12:53:36 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Yang <andrew.yang@mediatek.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        wsd_upstream@mediatek.com, casper.li@mediatek.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] zsmalloc: Fix races between modifications of fullness
 and isolated
Message-ID: <20230728035336.GL955071@google.com>
References: <20230727062910.6337-1-andrew.yang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727062910.6337-1-andrew.yang@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/07/27 14:29), Andrew Yang wrote:
> 
> Since fullness and isolated share the same unsigned int,
> modifications of them should be protected by the same lock.
> 
> Signed-off-by: Andrew Yang <andrew.yang@mediatek.com>
> Fixes: c4549b871102 ("zsmalloc: remove zspage isolation for migration")

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
