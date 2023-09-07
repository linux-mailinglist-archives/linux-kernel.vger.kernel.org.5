Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB00A79746F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbjIGPiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345018AbjIGPeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:34:20 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FFF1BFA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:34:01 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76ef935abaeso62585185a.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694100813; x=1694705613; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlmQ0g0rcR8jIM0YGYnNYLZ2qWdNbYZUYP0dv1VJcEc=;
        b=aHCEjBJWJSQNChfwrTn4UWO8SdmfStA8/4kExuw2efaKTmYiVsg24/zEcVn4wz80x5
         Bn6F7MmjuGjY04WMjruwDapZYaZyMmB1PCBBj/Gx+sLqYwNrZtAsaFMrcl4sjsn45ZEf
         ZMEI0JBT2XnJZFWnI/huypHGZG3yW28LzyIELwDB6Xp5ggfVRfipCeq8FTytzYhNprXr
         WoGlV/KEV43WPCBaJ6j996DNTp6Y1K9KbrVyDFxG2LYngTIjVskuuWIQMl6mnFcCLxTq
         Q/cQNPnE3E8JdujInYM9grIl0inY4Nhw2+P6VcElMaopJM9SrBxyfCekclRWVVIGgxJ0
         Czzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100813; x=1694705613;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LlmQ0g0rcR8jIM0YGYnNYLZ2qWdNbYZUYP0dv1VJcEc=;
        b=JEZ+TSE8/SG0p3mux9H+etzE1+HK9R40N1gftUwjtyGgYcAYPiyBZ6dVsFCXGso3mE
         YzbAv0fvmgPStvGTH/9JRRTO44tALJ5Ln4R8vqBHdqhaPOylWPdmVdWORhkIxyHZui7l
         tkGgFvGt5QfwziaFnLA5oMEJi2F9PA9ls+mzfv4Krj35+k+7/DKqfxpF5sq04MduNyya
         Q+4XAyHd7de4YSZxDI/alCh9aUzCgG3EzyeaF02e21XxW3QytRDL7ltfrkO5g7jNPgVj
         1ns8/a3UtM179M2asUdz0IO5TDh9GQRazfPP+rzCCoo+o/0VtIm98NK6NxjX3D2OEu42
         kdog==
X-Gm-Message-State: AOJu0Yx260iePead3/yvnsiMNvge7EqRUa3hC7JQFoGmI41alH5vRWBX
        iCiLK6o1SJMyZwK7f866deKMctxVImo=
X-Google-Smtp-Source: AGHT+IErairZ9yBTSt2kN6hRRi4u5s+turR2d2XrvcJUpHHW7n53nfz3i2uJ5+X8D5O10AqLjMSI7Q==
X-Received: by 2002:a17:902:bd45:b0:1c0:c0af:ba59 with SMTP id b5-20020a170902bd4500b001c0c0afba59mr16388444plx.34.1694086628392;
        Thu, 07 Sep 2023 04:37:08 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902bc4b00b0019ee045a2b3sm12601833plz.308.2023.09.07.04.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 04:37:08 -0700 (PDT)
Message-ID: <9a28c2fc-d769-4802-a1f2-77ba2cb34d25@gmail.com>
Date:   Thu, 7 Sep 2023 18:37:00 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     Andres Salomon <dilinger@queued.net>,
        "Timur I. Davletshin" <timur.davletshin@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux AMD GEODE <linux-geode@lists.infradead.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: AMD Geode LX hardware RNG driver produces regular patterns
 (geode-rng.c)
Content-Type: text/plain; charset=UTF-8
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

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> System: Alix board 2d13 (AMD Geode LX800) running OpenWrt 23.05.0-rc3 (kernel 5.15.127)
> 
> Steps to reproduce:
> 
> cat /dev/hwrng and see output. Output in console shows regular pattern, rngd daemon (from rng-tools) refuses to run because of low entropy from /dev/hwrng. Pattern doesn't change until I reboot system.
> 
> Important notice: This problem started somewhere between 4.14.267 (kernel used in OpenWrt 19.07.9) and my current 5.15.127.
> 
> OpenWrt developers recommended addressing this problem upstream since they did not alter this driver in any way.

See Bugzilla for the full thread.

Anyway, I'm adding it to regzbot:

#regzbot ^introduced: v4.14.267..v5.15.127
#regzbot title: predictable urandom output on Alix 2d13

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217882

-- 
An old man doll... just what I always wanted! - Clara
