Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF21775B76A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjGTTGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGTTGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:06:47 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBBCE43
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:06:46 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-403a3df88a8so10230191cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689880005; x=1690484805;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B81lxhSSxJfeg3Zx00h9FlyCTOeh4jFpxk+LKRa9GBI=;
        b=MNCntd85m1MM0LW07BRxJhiU2rluyJHiH+JAN7XjwlUbakqvU0pxtHb4sRHJCMmdqQ
         poAN6Y5Uimqk9Kb6erxFXdq2RF3BjsYzKgUGXM9UAnOdtmnsJ3TGoJK+6g8+NTLvw1mF
         TCkqzgVGp218P2WInv9IfgHGLdD4OScu/lIzMokCL6MDGUz0DUK8fhom+t52V7mlKXjC
         Oc6l9dDAzJOZswshoPML6QKBr6BlNwdBKtIKukvDSBFjt0sYaq7iHe+aeHgjRnsJkxdv
         RHV5071vX148nzWhTynH3IPo8k89l4xRKE3t6p8Egvlgf2d0/To8OFVnGJqcvkWiAwtC
         OC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689880005; x=1690484805;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B81lxhSSxJfeg3Zx00h9FlyCTOeh4jFpxk+LKRa9GBI=;
        b=WxDUFu+TMGVkte9zfS/Uxiw11+gBT2KEA/fZbaKvXuR7R/QDYh70zrB453+aDhxCps
         +6+7uIoXLdwBk5JA4Pu0m0/z8+Si7kmPnMG+5MDyqurTlcasb/mW5PAhKlGy8pvguQxj
         B/u5oplrIaoPKFldf7HiHySlXS+CUyGSK4kNPQAJC7COTS7o0hYN8F42cAOaJQxzlK2n
         KXc4OCuch41xdEmWMze8THj0nrpmEGNC9wf+Y0crFExbnhfEa2kzKPfg+7eCaFMYn02T
         qusz/SDwA5kzcCPCvNenOTqpVXoWXkCrZUPJ+QEvAo1Hakn987hnp+HoY7JwWVY3k8T2
         jnVQ==
X-Gm-Message-State: ABy/qLanA2hwp9/q4+QXK+iXd6SSoTk/BEotB27gp+JGWtawYDgiO8OL
        Hv9FISAKObfF0sThxlVtRjRT
X-Google-Smtp-Source: APBJJlF/fMjSKgm1f94N3y698IWtQxQI9hQtOC4upXLymQWnmYZfCL4lqoKB5A9jkm+5OU5jxRFzpQ==
X-Received: by 2002:a05:622a:3c6:b0:403:acd3:e90e with SMTP id k6-20020a05622a03c600b00403acd3e90emr28993085qtx.48.1689880005438;
        Thu, 20 Jul 2023 12:06:45 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ff20-20020a05622a4d9400b00403f1a7be90sm633051qtb.88.2023.07.20.12.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 12:06:44 -0700 (PDT)
Date:   Thu, 20 Jul 2023 15:06:44 -0400
Message-ID: <ee7d7edfda6279ee404ff1287625bd11.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, <eparis@redhat.com>
Cc:     <audit@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] audit: Include securiry.h unconditionally
References: <20230720015032.45960-1-xiujianfeng@huawei.com>
In-Reply-To: <20230720015032.45960-1-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 19, 2023 Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
> 
> The ifdef-else logic is already in the header file, so include it
> unconditionally, no functional changes here.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  kernel/audit.c | 2 --
>  1 file changed, 2 deletions(-)

Merged with the spelling error in the subject line fixed, thanks.

--
paul-moore.com
