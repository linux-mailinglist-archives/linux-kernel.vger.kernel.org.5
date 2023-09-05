Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDE7792DAB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbjIESsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbjIESsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:48:42 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2738913E;
        Tue,  5 Sep 2023 11:48:09 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bbbda48904so47407761fa.2;
        Tue, 05 Sep 2023 11:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693939618; x=1694544418; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x6Mhh8hSRcyvC8HGa8Xx0ZZh+uzo+1QHn9BTlHi4IfE=;
        b=BppkZJ1GVTovFH+n0YvLb4aZLTn3i90h0YLOjJTUYrOIMBjjan3VVjuTiWyIiBHaMU
         0iAMvaBhdDeNwyRFXHeyTD5fhf6kM5mTG4qo/Hrmea+iA0xSRyMlmBDC4wSrQUaWEYcK
         ux179vuh2WwdOR28K2CCpWt9zbI7VXrsL2aLFbNW+UR5lRkHmGPZph13h1ax3agYGhGM
         tKNStEXHz5yUqQVvpGBXQbNUhiU8g8R1eI3kG7HaS9mbulqEOyOvzd2joIjdtI8mGT0b
         0Uo2tA+i50KoyYBVKlDecze8bBCjpQZKw0f4JNUBmUlMUwLp9iNtnZhBfOXlvysMRsyJ
         Er6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693939618; x=1694544418;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6Mhh8hSRcyvC8HGa8Xx0ZZh+uzo+1QHn9BTlHi4IfE=;
        b=PWhFDhVQFBtbVmzMYyl5cXlC0LcmZbjDLsSHQAPlGT6hwtPw68+hPCgP+ODQf9das7
         m4JGDUBj+TARavo+sBrFRanp8FDE9EdF9dD3ScPMm+LfYZ/yzu7J5tTaFfjrDW8cKRi7
         Vyzzh7gxLq9+whpQUG5/6AgCA8YhxTa/FroI0qq5U8pTxRfuuAeGKNWPRqlu8z9iSvYp
         2p0HmrSPUeNlKJJJdF9PjUfPkPEb4oRwmYVHR9D96jk+wjasx0WLkydUMFn/3GlD0CSY
         5gJvRpZsq56n6vuMFRdYWYKD5v+tNg4JOoxg6qnVIrvKRJiBDfdWVc8WKgRjWIvbi3yg
         dUgw==
X-Gm-Message-State: AOJu0YyAaa6b5AYNLHeSl0G6HK3ZCFhBohLaFQrYsrk5WgTICUZZ395g
        5zOqoMyfL67HH7CdAXpZqBU=
X-Google-Smtp-Source: AGHT+IH0gYoMZir9EE4tY1YSxt9oalws1escL5AGRHbnzTJj1Qh+h9IZshAJ0sdXFtD4MsrRa5kymw==
X-Received: by 2002:a2e:96d9:0:b0:2bc:c3c0:a997 with SMTP id d25-20020a2e96d9000000b002bcc3c0a997mr498692ljj.38.1693939618420;
        Tue, 05 Sep 2023 11:46:58 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id j4-20020a2eb704000000b002ba053e1f9bsm3046704ljo.35.2023.09.05.11.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 11:46:58 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 5 Sep 2023 20:46:55 +0200
To:     Marcus Seyfarth <m.seyfarth@gmail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: Fwd: [6.5.1] Slow boot and opening files (RIP: kvfree_rcu_bulk)
Message-ID: <ZPd3n09wxHLMj2Bm@pc636>
References: <CA+FbhJPNZ-E3e7WBH_jAvi3Rn-2gV4TVk9S9qmheXkqXw+Sakg@mail.gmail.com>
 <ZPXyUTteVxXtqiEo@pc636>
 <CA+FbhJMr6LzmOpVNkYyiSERAsNEqqvQwQ7SwJK=CmwvV9d2Z-A@mail.gmail.com>
 <ZPYLmm3ih7u95l1a@pc636>
 <ZPYsY2HEjySkq/NR@pc636>
 <CA+FbhJPNK=4s8J5OqOBaDC8EDNQzevQMQ+fwZnfxG92ReabQOA@mail.gmail.com>
 <CA+FbhJMEqLycroz=J6VvC=4OBaJSwz8K+K6Zgki80M-5YdYp6A@mail.gmail.com>
 <ZPdbVO8ySCHLIEGu@pc636>
 <CA+FbhJOekDxBjQH6jUFXusgakRVx_Y0S3s5avko23c6XqCc2Mw@mail.gmail.com>
 <CA+FbhJNQfGW5RMJc-WaOmjqmYuTnqdvRPYO_40TP5=P4LFPDYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+FbhJNQfGW5RMJc-WaOmjqmYuTnqdvRPYO_40TP5=P4LFPDYQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 08:17:27PM +0200, Marcus Seyfarth wrote:
> Systemd-analyze shows also improvements. But still the firmware part looks
> suspicious:
> 
> ❯ systemd-analyze
> Startup finished in 2min 42.000s (firmware) + 4.201s (loader) + 6.895s (kernel)
> + 1.541s (userspace) = 2min 54.640s  
> graphical.target reached after 1.539s in userspace.
> 
> 
> Am Di., 5. Sept. 2023 um 20:12 Uhr schrieb Marcus Seyfarth <
> m.seyfarth@gmail.com>:
> 
>         3. Could you please remove that patch(revert it) and try one more time?
> 
> 
>     Okay, I've just removed that patch and indeed the warning is gone on my
>     self-compiled 6.5.1 Kernel. I've attached the journalctl output. The slow
>     boot remains though. But at least the performance in WebGL Aquarium is back
>     where I expected it to be.
> 
Good. Please do not include that patch on top of 6.5.1 and higher kernels. It just
breaks the things and is not considered as applicable, because the functionality
which improves reclaim process is in place.

As for slow boot up time, it is another issue and not related to RCU, IMHO.

--
Uladzislau Rezki
