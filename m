Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EEB780439
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357449AbjHRDLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357452AbjHRDKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:10:55 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6EE2D56
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 20:10:54 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bdf4752c3cso3547295ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 20:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692328254; x=1692933054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKpW3uMzKHMipz/jB1RiSd8Olvi+QB8PMIbMqnSLDAU=;
        b=jkSdfrawUtRZR63RxuLHuqppHYvkby9RDNZGLiEhnY4whd8qEb14oCt8G2bOBZcpB9
         VXTtxz1ifxs4zmBpNS/xSBbcywmCT/h0ZUUMjujMhfW0BjNC/umz8Cf0yn6tNarqO4li
         kJhGHNE92fqZNR9wTzfss5O55RHtA8UfxCte1NH3kVn358XA1gAjnEg2QxwSIhZ5sKQz
         wYIQSrqNaiPCLB4/zTpYFFIQKynWDgm2VOdt5i/VXWkHfJTTEOTQ88EwVpuxj4p/+fBt
         sZfdpIAMxdOvJXD1lmlDz1gO1CdFG9Z59gG0cBvZFdOpWDj0uCOxHTlibaz5WP7H4UyH
         6G+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692328254; x=1692933054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKpW3uMzKHMipz/jB1RiSd8Olvi+QB8PMIbMqnSLDAU=;
        b=g6IZHt8f/U8lcjc0NbgyGFEyObMbpP6M8zWOpeckHat8WSWj2+V5wwZ0ug/ncVI+0N
         DtC+AU8WlqmDsLOixlnUAvgFR4TDvGeK2QPZbvJDlsbtLOvAKo0Ci8fz2JUsbUNXiahu
         kAicpKOo7k5ccsfryYpdPOTE6bUF/PDBLg35AzZXToQwbyVOxaBvAS0Pv9eKyiz+LrdF
         iT1EtOM5gGX/6GFTGPZZAJdQ+8Zqp+oPIwC6sHFjAVhIah6WtieGIQ+GwlCkAbNBQ/0d
         Jf5lpuQCU9lwiXuhkKUEl6FZVqeNIptlUZtyJr7KsjjfHyLSTR/fcu4+mf/1QMUVbkuT
         hgtg==
X-Gm-Message-State: AOJu0YxE0GpgvxcrcYn22qWYZBfgb4E22tn5c5bYjvVWhSOhmtUvMKnT
        rYpT7cD1EdOEDpyYuRffeAVj1fVWkrg=
X-Google-Smtp-Source: AGHT+IGP1tCxPpyohn4+Hz+ynW1rLOTgpbqwPkZ/faeicKOrsuG0G3XHZ8eITEAPFUmxJyKR/R/FhA==
X-Received: by 2002:a17:903:11d0:b0:1b8:8b72:fa28 with SMTP id q16-20020a17090311d000b001b88b72fa28mr1494023plh.58.1692328253792;
        Thu, 17 Aug 2023 20:10:53 -0700 (PDT)
Received: from localhost ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902e80100b001b51b3e84cesm494367plg.166.2023.08.17.20.10.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Aug 2023 20:10:53 -0700 (PDT)
Date:   Fri, 18 Aug 2023 11:20:37 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] erofs: drop z_erofs_page_mark_eio()
Message-ID: <20230818112037.000027ef.zbestahu@gmail.com>
In-Reply-To: <20230817082813.81180-5-hsiangkao@linux.alibaba.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
        <20230817082813.81180-5-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 16:28:10 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> It can be folded into z_erofs_onlinepage_endio() to simplify the code.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
