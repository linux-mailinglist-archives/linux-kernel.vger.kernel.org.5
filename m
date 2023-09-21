Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929347AA5A1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 01:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjIUX3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 19:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjIUX3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 19:29:38 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77F8F4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 16:29:31 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c0179f9043so24194351fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 16:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1695338970; x=1695943770; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aMggTAfGNFGXjxKJt1wg6jNgFr8aapVARuQaiT0jkvA=;
        b=K/Qg2EdX/ZIv2tGiQ7iXg0HkOsYdf2PdzedRozFVDC/vyxX2/smEscNz/Yf7kdijad
         yn9eJTC/5TuFv3ZN5pplXvjc5416hmCkt7Ue3VqNmqq97wnByRK6rlaMKHQSGNxQoWET
         g7AS9ClUnmO1qUXV/k/gvswz5IFh2ZAeiTTOXVWVtJ/a2+B/n302+bQfe0G6M37a6OjZ
         3ERE570WzY0TO1YjKYWYWWVrDG4q/akToRtP4Xsql+DHt11lhJ4uWNjT5HwVnWCpgT27
         BujMa5nhpGWpORyKYijUIVSPGPPTf2kEEfg2nJWtJ4vFChVnN2vZbq6qyqlvLETjmXi6
         B0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695338970; x=1695943770;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aMggTAfGNFGXjxKJt1wg6jNgFr8aapVARuQaiT0jkvA=;
        b=vHyfiVdSVJxbIBjijlZgQSqKzTg1PtBbFz8/OGL0kV1SYcIqU/FG55G5dvlKlD1lEb
         pl9VgpqwI63uuzdDm+zrM6ABEl6dpyqOxtvKqDj+xJ3tBsD7qY+8uRblSLResY3st9Ce
         H6o0ALJOdUkY8+6E5fnh1132TWBKvI+TmQTJcdKURlTBzHCd7kfZkTbDRQHjFk4SZ3LZ
         3oTX//VzkEuHVMGyvUNX0IcIZUaJANGWvKPSAtsPUQmU8yHx2JHsIcEPcE16e8hAbMCO
         4gRFKq83y68DZ0K7OjNcVFYJBjlpf+fXxlIccTp7GnmcuE9CuYAyc9ohbi0Qb5xflIJ3
         62oA==
X-Gm-Message-State: AOJu0YzH4t6MWij7b/zzCGwvOtdNmnuT41ltgoQF0N/aA5TClS/12onV
        dU1F0rKJkkhdyDHjP0QzdwYU
X-Google-Smtp-Source: AGHT+IF+ugMQqBNBA0uxr5vgjIORPC3Xv0X6MthEzVBv5udxLHG+sgk55eID+CKfPRXt2nu+mHXsjQ==
X-Received: by 2002:a2e:3511:0:b0:2b9:f13b:6139 with SMTP id z17-20020a2e3511000000b002b9f13b6139mr5875357ljz.20.1695338969895;
        Thu, 21 Sep 2023 16:29:29 -0700 (PDT)
Received: from localhost (60.red-80-35-249.staticip.rima-tde.net. [80.35.249.60])
        by smtp.gmail.com with ESMTPSA id p8-20020a170906614800b009828e26e519sm1701009ejl.122.2023.09.21.16.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 16:29:29 -0700 (PDT)
Date:   Thu, 21 Sep 2023 19:29:28 -0400
Message-ID: <d96d63446c1548ea284eed7d383ccedd.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Mateusz Guzik <mjguzik@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cred: add get_cred_many and put_cred_many
References: <20230909191932.3187633-1-mjguzik@gmail.com>
In-Reply-To: <20230909191932.3187633-1-mjguzik@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep  9, 2023 Mateusz Guzik <mjguzik@gmail.com> wrote:
> 
> Some of the frequent consumers of get_cred and put_cred operate on 2
> references on the same creds back-to-back.
> 
> Switch them to doing the work in one go instead.
> 
> v2:
> - add kdoc entries
> - hoist validate_cred call in exit_creds
> - reword commit message
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  include/linux/cred.h | 59 +++++++++++++++++++++++++++++++++++++-------
>  kernel/cred.c        | 26 ++++++++++---------
>  2 files changed, 65 insertions(+), 20 deletions(-)

Merged into lsm/next, thanks for your patience Mateusz.

--
paul-moore.com
