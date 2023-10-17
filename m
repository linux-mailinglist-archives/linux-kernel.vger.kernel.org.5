Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A6E7CBE61
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbjJQJEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbjJQJEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:04:49 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508BC93;
        Tue, 17 Oct 2023 02:04:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso8331933a12.1;
        Tue, 17 Oct 2023 02:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697533487; x=1698138287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B/Hk67Q+giYTh6qT9YmC2zwxxSpcK1axa1hb87I3ZOM=;
        b=fhrizzr/l/F//bbUH3EQVPH+VrLfunZ7wvPcX54Nc8XZ5JAibR5kY408/Jhxx7Bemr
         ClP5M3TcGuRW9I8VYfyCBIcFQep463YDtmOZKD5U/8WJkQCakPEV1bzmh2qgvPGbUbPD
         abn+Jlox0cUTDZSs6CBp+zcc6Y/BIZy8nTy8U/SRpoomgXIsFqU/gug7tXxfxxge2KrJ
         Xp1LZmnAhLWRZmh8PzHJFPmR9dKwOrEtg7rq4MwWXoWZIrxH7ui7crDScYsiWQQdR6mu
         V/8fpeYRysCSmpH4yOvzLbCNsTbCsphbFkn87XyMwvL61wotV2Kb/RKxU7t0B74EVDUN
         eYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697533487; x=1698138287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/Hk67Q+giYTh6qT9YmC2zwxxSpcK1axa1hb87I3ZOM=;
        b=A0iddpFVY+6dmk/5BdmjquXqXZ1sMLsaI+/djy4q/U7V0K8Z7fyBHEOkZnEF2AsqrV
         ry14U18XiwzK2TL4Q8erCQM/QhwgMkeVcL+OJfc8z/R3qnl22ndDSckzRAkuv1Y5y74u
         MJKBYFSjZ8i7bAI2uIKvLHsbeCtYh8ehuIYwaw+bZmhtBIS3F4aAcoC6s+da2k+PLfzv
         O//xS0MSNmPk2dUFS6q2wKxQeCn2AiTNz8WlNPSKvnmZ/lRmcE+ERBnLvofX4zHQ5jDK
         m/+2NY6HGFl58gNO/uEuxI7PDYB/NVfOh3uoOOif1TR5I+oC1iVVWTmqBREcM3bMvL/8
         EKAw==
X-Gm-Message-State: AOJu0YwofL9yLlmIUi6zEvNPlNcF5ZRlp6jCUYJqY6EQMS9B9QfN9Cj7
        mMWvC0D7JNBgd0Gb5qjJAw==
X-Google-Smtp-Source: AGHT+IE556fO87GyMGId4qv9PrxSAzYqqPSIlNZ9KTKHH19u1KQ7UVQmLIXEouDr2rZadRDRs7/wDA==
X-Received: by 2002:a17:907:98e:b0:9b3:308:d045 with SMTP id bf14-20020a170907098e00b009b30308d045mr1205146ejc.46.1697533486465;
        Tue, 17 Oct 2023 02:04:46 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine ([105.163.1.143])
        by smtp.gmail.com with ESMTPSA id eh15-20020a0564020f8f00b0053e775e428csm798353edb.83.2023.10.17.02.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 02:04:46 -0700 (PDT)
Date:   Tue, 17 Oct 2023 12:04:40 +0300
From:   Dorcas Litunya <anonolitunya@gmail.com>
To:     Andi Shyti <andi.shyti@linux.intel.com>
Cc:     anonolitunya@gmail.com, outreachy@lists.linux.dev,
        julia.lawall@inria.fr, dan.carpenter@linaro.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] Staging: sm750fb: Rename
 displayControlAdjust_SM750E
Message-ID: <ZS5OKMTY4BDX015/@dorcaslitunya-virtual-machine>
References: <20231016201434.7880-1-anonolitunya@gmail.com>
 <20231016201434.7880-2-anonolitunya@gmail.com>
 <ZS2sCEF/LsO8Fzk1@ashyti-mobl2.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS2sCEF/LsO8Fzk1@ashyti-mobl2.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:32:56PM +0200, Andi Shyti wrote:
> On Mon, Oct 16, 2023 at 11:14:08PM +0300, Dorcas AnonoLitunya wrote:
> > Rename function displayControlAdjust_SM750E to
> > display_control_adjust_SM750E. This follows snakecase naming convention
> 
> I'd go one step further and call it display_control_adjust_sm750e.
> 
Hi Andi,
Thanks for this, I will include this in the next patch I submit.

Dorcas
> Andi
