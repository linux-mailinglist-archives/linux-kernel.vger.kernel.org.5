Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DAD7678EB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 01:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbjG1XXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 19:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbjG1XXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 19:23:00 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DAC3AAC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 16:22:59 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bb893e6365so16893235ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 16:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690586579; x=1691191379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nE0WZhZhheFYU9mJRSGMx7UaIgqOMzODgIaUg2rFv5w=;
        b=VmfNhSdR5tpFf8OvIHnpoiIQqnPoDzdk7isCwfZoQAcyf1hE6J9kmcV831rIg1H+QG
         YdF/WFoJ6S/VAhKBzRnh9whnUi8Tu7+7qV7IdZNgHWCADz+2k2nEoCN8rGvehACPZAB2
         Ri/rYN6NoNKCQmYyW+hQcOPspJPehmqLpsVKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690586579; x=1691191379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nE0WZhZhheFYU9mJRSGMx7UaIgqOMzODgIaUg2rFv5w=;
        b=GNsHnTnzvHKqSk9utgKf3YljkpzkscryRpf2VODL/+0oMBARHYBNAqGlR+F7Ms2oEv
         XpPrlV3MHFiirix+tUSAcqwFGnoLNFOCCb9Bx6bSnNvJ2X1h6aK9PTcoO1v99V6I/PmD
         ddZtueDmNoapg1Q1uU/LQjCg/yGJZLdzqeWsy4YGOfZDn9DL8s9VGJCbbPG9VOMW+no9
         9IgZOZpDJcHvBPLVzBaR8r8GyULypEYROar9CtMuIbOlO8nQMoim2K8YfvM84pe7u+Lo
         hYQG+AXSsRyYa/HS73WJ3LpPYvftQA7BotmBZ1iuvrDr0vY8FMp+bAakOLNxmUDF+Z81
         ucXQ==
X-Gm-Message-State: ABy/qLZ3LORR2gri2BILSmYBNgEEiGJE3klUpKNq6QGQ+IklhMLYH1jn
        fAEBLcUWk8QCvIXVF9b9r0/ezg==
X-Google-Smtp-Source: APBJJlGm9NK/8H1lG9DTKsn3Eu3AACbf4oNnruLwRCzGza0X5gnd7xYi6R3Jy0FXKwSg0pl+z9z9KQ==
X-Received: by 2002:a17:902:e88c:b0:1bb:9357:8b76 with SMTP id w12-20020a170902e88c00b001bb93578b76mr3464822plg.50.1690586579361;
        Fri, 28 Jul 2023 16:22:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b11-20020a170903228b00b001bbb7af4963sm4109419plh.68.2023.07.28.16.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 16:22:58 -0700 (PDT)
Date:   Fri, 28 Jul 2023 16:22:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Docs/process/changes: Replace http:// with https://
Message-ID: <202307281622.21D30DEEF@keescook>
References: <20230728211616.59550-1-sj@kernel.org>
 <20230728211616.59550-2-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728211616.59550-2-sj@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 09:16:16PM +0000, SeongJae Park wrote:
> Some links are still using 'http://'.  Replace those with 'https://'.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
