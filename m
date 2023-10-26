Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641DB7D7B40
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 05:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjJZDba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 23:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZDb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 23:31:29 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A7C189
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 20:31:26 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-564af0ac494so410939a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 20:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698291085; x=1698895885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pG/yiI8lmu5ttHIV4nGpRPyvwtSsNLtKzIlMaESEX5U=;
        b=lw4pTdkACroPZGZnyxXKCKHS/ECSztVpHC2gjkl5uspOIp6n4pw5Xa1xj4m/ZURbAE
         bscFoXRJpCJy//pncIK/uehUwenBdz6fwzyWVIKWITrEGkexpHj4LACvpeNJphjW0J1p
         BCoctIt/umvTSlzN3ZyOAD30Zb1r6XgLTRnQI2yIt3vcO6uIj45L6TD0xSX5aZyignjg
         tXxateLQwa3bNDljwNVtr0FI+iEAO5GltOb9et3A/ldJY9US9Y6U0nJlPJGCbLdQuSSW
         FvyNQnXyDShOO6nXoWpHcHGKVc20By+HqQjcicCfW3VePZO+Gc/oZ5LEgJtbWm1B0tLX
         BfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698291085; x=1698895885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pG/yiI8lmu5ttHIV4nGpRPyvwtSsNLtKzIlMaESEX5U=;
        b=C4BWSmUztHp5+X4eWAuHjwqKIKY/IJsUjCpsLFGIu2sIjK88zS+D5v2ZnFX86sfGzS
         BylAR2/v3kzBjoLJcmz3Loa+E6zwnhGpg3loM8wgrmsyh9OwNSDJWLoPkzZbyyIxR5nl
         uNTh6q7LsVw/uoE70WVloVcnoZo31Q0+dWQTp/ATVXV0kekSgvUP19WzCe+wKzlPlzAF
         pzmhWfE7l7pp2ZYq5L3lUpH3F71blJZzlA+oH4ZMMPbfvfzHf791Tor8Jc5otkgYPCfi
         2yUT4u+sfjD2PRM9HvwE1H55HKVLjiusEEV8Wobrd5CfgSDQUtH3H0i2LFCkZvw3Ir6i
         HsZg==
X-Gm-Message-State: AOJu0YyDtlGcyaM0azwEhuN9dWWkxr9LNaowZW7ChqTTT4Oai8erZEX5
        GhnO4EBZ2JvaugRhhJZ9cXA=
X-Google-Smtp-Source: AGHT+IH07xI4RkBOZRAYoV+NutElQZaay70zLfrIOC9VM5ODzrbszTCv4XfDw4XRZvP+OMTX1QjdVQ==
X-Received: by 2002:a05:6a20:e115:b0:153:78c1:c40f with SMTP id kr21-20020a056a20e11500b0015378c1c40fmr9374574pzb.15.1698291085427;
        Wed, 25 Oct 2023 20:31:25 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id n14-20020a056a0007ce00b006c046a60580sm1385612pfu.21.2023.10.25.20.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 20:31:25 -0700 (PDT)
Date:   Thu, 26 Oct 2023 11:31:11 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Ferry Meng <mengferry@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] erofs: get rid of ROOT_NID()
Message-ID: <20231026113052.00004950.zbestahu@gmail.com>
In-Reply-To: <20231026021627.23284-1-mengferry@linux.alibaba.com>
References: <20231026021627.23284-1-mengferry@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 10:16:26 +0800
Ferry Meng <mengferry@linux.alibaba.com> wrote:

> Let's open code this helper for simplicity.
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
