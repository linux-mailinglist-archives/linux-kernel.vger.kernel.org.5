Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3418A774DF1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjHHWGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjHHWGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:06:37 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0A6E51;
        Tue,  8 Aug 2023 15:06:36 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bc8045e09dso9282575ad.0;
        Tue, 08 Aug 2023 15:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691532396; x=1692137196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HNl0ltQ6dr9JUY5+74YSyRsm+xqmxQcOylgIxeDZAvQ=;
        b=IT/M8A6laE0SAk1/avwizLHXTFcVHzJieSsNfnyHwmiwh17WZfJsLAh4MsERQ4xX5b
         +dRQIl0bnMSrF2h85yryo4lSmVOUtm2b9zYe51uGocKsRR0sO2KD4Zd3CzszRxDDJxGU
         qfZN+28cvutmcl+rv98W46xpZxfyWVNEwuYrDrHR4WQ5V3APWci/v2tz4duF3gRtHeX2
         YMiZPYlPrM/yrgRgiHH8a0B1pVrY+cd4214dkmnDffux9gzor3cM7sVDC28hx2/VMnNJ
         BuHHaDGg3Ze86yaI2vzmq2qR+WRIi8OJoxV+BWbwnb1JOv6nIPHCLMOMFvWvjUyUdNHR
         V0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691532396; x=1692137196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNl0ltQ6dr9JUY5+74YSyRsm+xqmxQcOylgIxeDZAvQ=;
        b=kbLxdR76LJGgXi9vmIwNgOZCqg2qFNXOG7z9T103WCRgP34GrTl353NEgZeblN+MnM
         v3Vy/hB6TDiIccPYhTA5KBEjw7feWwcEx5Ti3phDUOnAXRhTFel43LX5NqQeockEBYSL
         CgGZovH2YCMewjrZwutwV6EouEEEwIrkFdMWE/q3C9AacwMIrEn8bLbV/wJULTTBxKB3
         mVav8qUum06jhWeWG8Nzh8ldzC576pvE2S/BTk66dg89Mwse3n1weq/TY8lIjdKhtJEV
         ALndLdZDPL1JQum0sAhKoR8ssT3gZ6Ul7X5GHVUFh8TCsrKWX3PT70YQUYtfJCv1etfH
         JlsA==
X-Gm-Message-State: AOJu0YwKFLAgRSkdxu5cg8tq7checdxE7SUmK6Bmv/DTqyv7InmQec7O
        uBjshtuSf5re/Pg3YsNJGXA=
X-Google-Smtp-Source: AGHT+IFaqIoitGiqSoIrV6jhY+q8tWYzaouYAYn19xnV7zPvHlHfCofvpakfcgGo7e+y2PiyADhSJQ==
X-Received: by 2002:a17:903:2306:b0:1b8:89fd:6213 with SMTP id d6-20020a170903230600b001b889fd6213mr1044083plh.35.1691532396040;
        Tue, 08 Aug 2023 15:06:36 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:fa39:8c5:e5b:291b])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902a9ca00b001b9d88a4d1asm9463638plr.289.2023.08.08.15.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 15:06:35 -0700 (PDT)
Date:   Tue, 8 Aug 2023 15:06:32 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Sebastian Wick <sebastian.wick@redhat.com>,
        Aman Dhoot <amandhoot12@gmail.com>,
        Mark Pearson <markpearson@lenovo.com>,
        Raul Rangel <rrangel@chromium.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andrew Duggan <aduggan@synaptics.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "Input: synaptics - enable InterTouch for the
 ThinkPad P1 G3"
Message-ID: <ZNK8aG/y4ol7MXVp@google.com>
References: <20230808152817.304836-1-sebastian.wick@redhat.com>
 <f13f4ff7d46ecf887ca652b664860c4e07ec8b73.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f13f4ff7d46ecf887ca652b664860c4e07ec8b73.camel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 05:49:23PM -0400, Lyude Paul wrote:
> Hm, This looks fine to me (if not as a final fix, certainly as a workaround)
> 
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> 
> However, this is definitely something we probably should try to fix at some
> point - as I imagine this must be happening because something regarding how
> clicks are reported must have changed again. Andrew, do you have any idea?

I would like to understand more about this. Is this with newer/older
BIOS, or another hardware revision of the product, or something else?

Lyude, do you still have access to the unit you originally developed
the original change for? Is the behavior broken there as well?

Thanks.

-- 
Dmitry
