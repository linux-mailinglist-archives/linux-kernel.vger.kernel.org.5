Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92E4772DFD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjHGShS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjHGShP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:37:15 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DA0172A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 11:37:13 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6874d1c8610so3398663b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 11:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691433433; x=1692038233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgjhxKJWKdbdP1etScq14YDZrbEk8/V/FlBFjEvS2gg=;
        b=reo5oCdfSptUmO1B7wzCF0FA4zMFEeEZsH3KuBJfvOPooCpDEJtLDCT+yMEKhjCV31
         sVoER3vhlooJYYVw3LWWOhfog2L1tndsxfCQIVpbTd6jGdnuPptQUbd19fwngFRFnKYv
         dQJbElAqCaBx3xK45mVKaZP7LXSQZK3lGyrj0Alx3DqpgtjQhjO3738gX/2UElkRgS7U
         p/dmL9laIZqtDLUuW2FC8I6kYDmjdC2ZwE7xbCuAzq+E9J50MmLa75LBbrap6miYxVYM
         s/Aec9+bPGpQF6/w/rXQTuBXTXQACAMbtSaCLpWac1gj8LEQzjt8GaDAbELb0x7+Kj5A
         uKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691433433; x=1692038233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgjhxKJWKdbdP1etScq14YDZrbEk8/V/FlBFjEvS2gg=;
        b=b+6VQYGNsouwWCL6Z9RSPVtFo8P5N9gp8M3+nd0k4FmtwPlkHupGRIYLhuXMTaUHcf
         Z6F9/jKcKiTCvKYSRGNsf7nVxWLfxopY14hmxXIV7Mlfvesr9NeosIDn1wIl+4qLcigH
         2Rva7WU/6mJnLl50o/GHQh97AgPcjCTEpl2N0L4IF79hn+MGo4bQ8SYifKgPpX1lSZ8H
         MFzDwBysGDaPp/pulwS2jVXOI0QGNTnLK+tHlZLtztHG5KJBW8GDteDOwj08nbWV9mfk
         8X8gMw+k4MrwkjZ4LtjEZK7XR15K7OoUDmqRCUq5MFA3KYCVZT7nVA7W20DTpmKW/OUr
         tjXQ==
X-Gm-Message-State: AOJu0YyELlgb52RPpL8iN6Ezx219HDujTwCGs1cApPAFDdezhwyJnyph
        WWXVO532jRCgtVWl39j8XFA=
X-Google-Smtp-Source: AGHT+IE6JY1mDZQaHOAPz6WJhTTf0BqUaKKDil9eoYUeMHLQ7Da80jMdWQR963sonnj2TWONUnNuHg==
X-Received: by 2002:a05:6a00:2e23:b0:668:6eed:7c12 with SMTP id fc35-20020a056a002e2300b006686eed7c12mr9750444pfb.22.1691433432646;
        Mon, 07 Aug 2023 11:37:12 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d5d])
        by smtp.gmail.com with ESMTPSA id a18-20020aa780d2000000b006765cb3255asm6494181pfn.68.2023.08.07.11.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 11:37:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 7 Aug 2023 08:37:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     yangyingliang@huaweicloud.com
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        yangyingliang@huawei.com
Subject: Re: [PATCH -next resend] workqueue: use LIST_HEAD to initialize
 cull_list
Message-ID: <ZNE51vWFQ6i3wTdB@slm.duckdns.org>
References: <20230804032215.1168792-1-yangyingliang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804032215.1168792-1-yangyingliang@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 11:22:15AM +0800, yangyingliang@huaweicloud.com wrote:
> From: Yang Yingliang <yangyingliang@huawei.com>
> 
> Use LIST_HEAD() to initialize cull_list instead of open-coding it.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

Applied to wq/for-6.6.

Thanks.

-- 
tejun
