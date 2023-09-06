Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BC17933BF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 04:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjIFC1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 22:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjIFC1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:27:13 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FD6CDE;
        Tue,  5 Sep 2023 19:27:09 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68becf931bfso2105979b3a.0;
        Tue, 05 Sep 2023 19:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693967229; x=1694572029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YDixPpX0g5WZRo9H4Hc1n4iO7NG7GMD3/mGn+bU5KE=;
        b=UnhrDoFTjwb3vbPDdbV0ZrFDiSqpBnf4tuVSBnK+hKX9K0xI8dq2p4gI3dk29pL/+l
         nbQFOu11IUSuIV4XNeFbVC21ZxYYsT36RFb9HY5UJ7r7uT4OnHOn4ZziDa7nisSoHx1O
         i7Q9CtQJUVot6Z/MIuY8QxVr3h6ZEShF2IO9Oi5pmuH2DBi94DcD4iebcEcv0Pi642Hr
         8wleCXHW+BD/frOYAbTgB92PIjAvcaH6LvhQU9cPzdUvyrEjfzIqV+9RFWC36f19705h
         LtdUCnjBouZFFjf7J8Mt/agEf3H8milfZOPEnR2pEAKngnSfAwuUmdWMwzZZDpzSpgly
         Vtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693967229; x=1694572029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YDixPpX0g5WZRo9H4Hc1n4iO7NG7GMD3/mGn+bU5KE=;
        b=gSZhtWP2w8moghM250WzCMTSoLWzgHUsmNAnv8zVeorA18zlLYsIw4sTYLtnkUwP1B
         TyI9KhHp5pl8oOsTdz2hCjFgtwS/fzXPwhbvDsjU5dy/sPESCLrJ7Eb4vWbM7vY9U55D
         G4e649FCTsPIH6IjRogk0CsA8wT8Hzxl1bJ1q8P4NXDjdgL3/7UZxWmEW16pviP24J58
         OS5uq0zlc6wp+2c6C6I8kba1835jnfnwL7VltOyyvhA8lBBAlnkHa/t/gvL2ZyCi4T04
         UH6rk0rORj3VxbVB+WzEZ9Y1tWhC+YFOT1oYw5e6aUi3J0Sjk2p7652jLPFQqmNq9J8G
         mlwA==
X-Gm-Message-State: AOJu0Yzv/fvfVE5rHnT99XtLB0zSTcOVNrySpYVGke3EnQcoqDo1w2t4
        kJNplba+bU69liMIvxl3Des=
X-Google-Smtp-Source: AGHT+IH1nbG1WLw7E24n9u6IgDMUHEMu0LSImK1dD9wt+SGz6ObchDBJoLAm5m9A2JsQmMTLuJqYMw==
X-Received: by 2002:a05:6a20:158e:b0:13e:9dba:ea52 with SMTP id h14-20020a056a20158e00b0013e9dbaea52mr15170663pzj.13.1693967229274;
        Tue, 05 Sep 2023 19:27:09 -0700 (PDT)
Received: from arch-pc.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id c10-20020a62e80a000000b0064fde7ae1ffsm9683967pfi.38.2023.09.05.19.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 19:27:08 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     svenva@chromium.org
Cc:     linux-mmc@vger.kernel.org, SeanHY.chen@genesyslogic.com.tw,
        adrian.hunter@intel.com, ben.chuang@genesyslogic.com.tw,
        benchuanggli@gmail.com, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, jasonlai.genesyslogic@gmail.com,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        reniuschengl@gmail.com, skardach@google.com,
        stable@vger.kernel.org, ulf.hansson@linaro.org,
        victor.shih@genesyslogic.com.tw
Subject: Re: [PATCH v3] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix SoCs can suspend
Date:   Wed,  6 Sep 2023 10:25:30 +0800
Message-ID: <20230906022530.825734-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <CAG-rBig796Yc9iyTiLOLt2R9PW9SoOFtuks3a1usu4XwvkzAOQ@mail.gmail.com>
References: <CAG-rBig796Yc9iyTiLOLt2R9PW9SoOFtuks3a1usu4XwvkzAOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: benchuanggli@gmail.com

On Tue, Sep 5, 2023 at 11:15 AM Sven van Ashbrook <svenva@chromium.org>
> What do we need for Ulf to add this to the maintainer git? There are
> released devices waiting for this fix, but picking from list generates
> lots of paperwork, so I'd prefer to pick from git.
>
> We have a LGTM from Jason Lai, do we need one from Ben Chuang as well?

LGTM, too.

Best regards,
Ben Chuang

>
>On Mon, Sep 4, 2023 at 3:42 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>

