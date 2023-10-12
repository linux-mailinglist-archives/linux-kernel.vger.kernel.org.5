Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1357C69CF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjJLJhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbjJLJhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:37:50 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0630D9D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:37:49 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690d2441b95so558340b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697103468; x=1697708268; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdZgfymsyd7ehqcxRdjpYNBTpQVaXLUbV7TLN4E1/DA=;
        b=TatYyoXwwzMBbNs0kzOMQUFfhhimCMw3FM6rUQ04coq+PNfEsrNB//fl2aeq+VEGYl
         isek97stIDYSw6iIhbNjBtzwzji3P6m24jo4p8lOJunja/JYaWizuHRIIkEVeZ0Od0LQ
         +xQ9URyEIC3CCndQHExSJdzUwNVYHrSISMdZUcWu6w3wJ+wZqPwJGnI4YH8EevAuaIyj
         Fv3RgsXvcOF0Swq6veDzPEgKUn8KWqxREyzAtN3ua47JuY1dRubHgHxSaxvX0Z6I+XG0
         NYB5TCYoOR2gwXTMZnfL+YaH1WEoUsaDifmTbQyuYlDpTTTETEyL+NLLARxYMc1OmuJN
         6TdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697103468; x=1697708268;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fdZgfymsyd7ehqcxRdjpYNBTpQVaXLUbV7TLN4E1/DA=;
        b=KPg062EyyeiyuYck756CD5apZ70TTKTwDyPYJB2ZuKlA6yKZLhi0CpqNurbxEQKZYp
         w5nKK0MPHS6Jz4JG+/pwXI3sHSQ+bK9pQ8gJwWjIjGIzSEeohTBmwfy9oXKI+2eFtz9P
         +fQeWJfL5Nw2hrz9j2AD+iYsrQG+KYAGSAcpJLqEP6n9u4ILPYwA42H/BwjPI9zmqUEb
         yQVlZPz0h37dPEaKzDguH+/ZqNe6uFthxg7p4YhnsNJLnQUATy+VOM+87yh56U+NqLHV
         7nugeCQoIQGhrueVOxyK1NKsG9YTmOcGNnVi2+tp2ixVsTIhXc978ClvFsK6F1Ts4yDm
         6CDQ==
X-Gm-Message-State: AOJu0YwA/8TOe3rOzSrl345pTGncku0qY8KErOAnlFOlfbMhFVcEl4kx
        zo6Q5wV81ZvbKe0yYq0VNR+Fp2nJ67A=
X-Google-Smtp-Source: AGHT+IFtx9yabPtRA17h06vlo13OrJKoThnA6kM+dAvk+E82XxXruxxbs4KeGiTVxMXiCnkNk0pDTQ==
X-Received: by 2002:a05:6a00:1595:b0:68f:cb69:8e66 with SMTP id u21-20020a056a00159500b0068fcb698e66mr31525387pfk.15.1697103468109;
        Thu, 12 Oct 2023 02:37:48 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id x15-20020aa7918f000000b00690dbab1623sm11371659pfa.81.2023.10.12.02.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 02:37:47 -0700 (PDT)
Message-ID: <e6d1dae8-e28a-455a-a851-661c825fbdcf@gmail.com>
Date:   Thu, 12 Oct 2023 16:37:42 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yanjun Yang <yangyj.ee@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Kernel 6.5 hangs on shutdown
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

> I use Dell OptiPlex 7050, and kernel hangs when shutting down the computer. 
> Similar symptom has been reported on some forums, and all of them are using
> Dell computers:
> https://bbs.archlinux.org/viewtopic.php?pid=2124429
> https://www.reddit.com/r/openSUSE/comments/16qq99b/tumbleweed_shutdown_did_not_finish_completely/
> https://forum.artixlinux.org/index.php/topic,5997.0.html
> 
> Tested with various kernel and this bug seems to be caused by commit: 88afbb21d4b36fee6acaa167641f9f0fc122f01b.

See Bugzilla for the full thread.

Anyway, I'm adding this regression to be tracked by regzbot:

#regzbot introduced: 88afbb21d4b36f https://bugzilla.kernel.org/show_bug.cgi?id=217995
#regzbot title: x86 core fix pull causes shutdown hang on Dell OptiPlex 7050
#regzbot link: https://bbs.archlinux.org/viewtopic.php?pid=2124429
#regzbot link: https://www.reddit.com/r/openSUSE/comments/16qq99b/tumbleweed_shutdown_did_not_finish_completely/
#regzbot link: https://forum.artixlinux.org/index.php/topic,5997.0.html

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217995

-- 
An old man doll... just what I always wanted! - Clara
