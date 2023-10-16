Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812A17CAE5D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjJPP47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJPP45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:56:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1E4B4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:56:53 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53e84912038so3126335a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1697471812; x=1698076612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VGY4iUYXs38vKInv6stEXBoZrjfQgBYDxOYntL25BeY=;
        b=CcOZi+rO4F6Oqw+qk/00mPZFU4MVzW2RBlz8/g9sY5tmuxO58jR9WijGLxq2e7Gdt2
         LB8qpYNPO6snhMjDLyvBeGPzbXdOS1+HLwMnSHiS/+iBW7AMGAHD23ARY9fd2Xbp7EmW
         gTfLYha7POOo1DL7+iebw7c+bh2AVBCjAL10yH8xOJzLrrqWkTwRiFlEqad8TGs5gOgB
         Sr4FIV/40hr+EB/vj4kaOZIkGGEF48wPwxFz4EBzJ6jxNF4OTLd/4ZSS8WnKcqTTfnHA
         86SJII2K8lKEqFO/odorovlRepXMthBnxALxI/rxZoATDg4mOOBMwpmZ7BM1zLEKMQT4
         coOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697471812; x=1698076612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGY4iUYXs38vKInv6stEXBoZrjfQgBYDxOYntL25BeY=;
        b=Tuw/DSOx02jRxHNgp0yilHX/SIQ84jFxGGHjPGcNYz9ShiQmtqo+koQk3Z/+i9buRA
         qUCLT7aTfv0LMvHxPP0jwTAFI1jQr5NouuXCdFk0WMrGLMa94bakCCnCdrK05LuBpxqJ
         cDwtyH/x8/eyWB/M1gZAWm8AjRchZH7zrn7yF84OBRmpCHXla64MOm5/vEETb++TIspC
         YrV27K1adtHvaZN/eT9ohPaXTT+0x/X4WwTXe6JB9RvfBrJH7/PoxfnDAJUfkIPGUk68
         leYhzo4FOnbwbBQS8D191IWWmabbQD2OQP9la7BjR4JzE6yjJr7HeAGE5771h8SxzwoQ
         3FXQ==
X-Gm-Message-State: AOJu0YyaeBHNmyFSD0STGF3oN7o1xRTk6Fkio1x+CQqJq7iYzx9jIhfR
        51mZQ6aUnBqpwUrmHm3qlj/T7WgZb58jFyqdJ0sbONtT3DhtYlfl
X-Google-Smtp-Source: AGHT+IHUEsjycs9dbMrXuyqCnE8HpCJWNAe+pjVda+kU2hdt/jursQeLhAalvG8FD0NyLmFXapbgBpE2W6sW/Uc3HH4=
X-Received: by 2002:a05:6402:288f:b0:53d:d7e5:a9b9 with SMTP id
 eg15-20020a056402288f00b0053dd7e5a9b9mr13451412edb.0.1697471811981; Mon, 16
 Oct 2023 08:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <ZShUmLU3X5QMiWQH@google.com> <20231013211129.72592-1-sconnor@purestorage.com>
 <20231016060722.GA26408@lst.de>
In-Reply-To: <20231016060722.GA26408@lst.de>
From:   Seamus Connor <sconnor@purestorage.com>
Date:   Mon, 16 Oct 2023 08:56:40 -0700
Message-ID: <CAB5MrP4uvBVj+DE2kjMZD0FkQ0OEaqWBsTs6pbniN3TxbcSqFg@mail.gmail.com>
Subject: Re: [PATCH v2] configfs: improve item creation performance
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to you both!

-Seamus
