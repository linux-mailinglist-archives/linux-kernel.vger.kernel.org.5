Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE12F7D0931
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376358AbjJTHIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376326AbjJTHH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:07:59 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CCE98
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:07:57 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3afc38cbdbcso289767b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697785677; x=1698390477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZ9uOsmItqlP8ZLKPIbsiuZsF/kvOeSSxkPvDynDyWE=;
        b=V4JhPmkwbGfM0/zzosWIBkPALNWDIGjvEQc5rGvY5U7oMsb9YmP3WSYJ+1FNHQVU0G
         tgZ5fV0ZBa0YaLUmvfr0EtMokKBqV8IraYhyyMzhpoBLF66oGBPSTINfIr0t4EDrCalV
         QHXYCFrcFbWC1UeEq9qAEOCx1j9iKCZ9vR3MHRh+FW+PnZhigbCExy3FmPxxcGTqiyzs
         zjL3CH4rzOmNilfv1ogGcX82lQd6gtyPuYWbVH8OnmD2VN0ZAGmXzMvYrMDYjq5GXvDQ
         qqdc7gO6MKl1GT8Z0RMlVMyYNP83CkVUuz1XCZkDcfusYdsA9oguDVnB34Jx1nkvqXol
         v4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697785677; x=1698390477;
        h=cc:to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZ9uOsmItqlP8ZLKPIbsiuZsF/kvOeSSxkPvDynDyWE=;
        b=mjN/eo1w3Ytpbf6ZjR4Ftvp8dEODaNuGVESszpbWLHT0bnt5iMZ5+L12TKicVUFJyN
         ZH4MRSCbOlBLwsEG0jGgshaWMqBgZMsSr1cQJBbdea1pOZl7i0YS+vXcQ3takbjcG5Ty
         yhP6tje5CLi/fwtgv4dYR6wG2ZTWcV/W1ZFlbRuqzHcdXV3raxTErB2gnda2EvqN05ra
         BggPpiiygFFEl/cieKO3TaW91NjM5Dg94Dc7lMRyppFVAVoKm3vSrgfYEixeHjTy2i2h
         mEOpbQahy6oHMl+MsXFxV69dWX4McR4jeyLhzvvV82ARh4OWx5K+DQI9kUx1/vRmvgm2
         JYVA==
X-Gm-Message-State: AOJu0YxgUKiqVCOTXy9s15mnoW3Or40OJRfYNFu3NvdwtSaZOWCJ8BRd
        e7VhN63y8LoQGdBaDNae6aj5Tj9YvwktZFJ9cWLfh2mY
X-Google-Smtp-Source: AGHT+IGepYAKJNBPADcJXr6D463Ekia/avoh3ep3AXavCg61avaB8F6zPh0NYqxn/iP1wukz9JKeHnCINLLa1Jj9Qns=
X-Received: by 2002:a05:6808:158e:b0:3b2:e557:2f1b with SMTP id
 t14-20020a056808158e00b003b2e5572f1bmr2194112oiw.14.1697785676980; Fri, 20
 Oct 2023 00:07:56 -0700 (PDT)
MIME-Version: 1.0
Sender: getarunks@gmail.com
X-Google-Sender-Delegation: getarunks@gmail.com
From:   Arun KS <arunks.linux@gmail.com>
Date:   Fri, 20 Oct 2023 12:37:45 +0530
X-Google-Sender-Auth: suC3uqbKUJXbCe1qRnbBECSXlu0
Message-ID: <CAKZGPAOurEwCs7B8RAinTEBwWKOEwW=8FLtAKSzLu9LjH9AHvg@mail.gmail.com>
Subject: Question on pre running clocks
To:     linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, mturquette@baylibre.com,
        Arun KS <getarunks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Lets say there is a clock which is enabled by bootloaders and is pre
running as linux boots.
Is it mandatory for the client drivers to call clk_prepare_enable() on
them to initialise the enable_count to 1?

Or is there a way we can specify to the kernel that this clock is
already enabled by bootloader and initialise the enable_count for this
clock to 1.

Because otherwise, clk_disable() prints a WARN() if a client driver
uses clock handle where clk_prepare_enable() is not called.

I grep through the code, but could find any details. Appreciate any pointers.

Regards,
Arun
