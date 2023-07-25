Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC63376099B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjGYFoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjGYFo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:44:26 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D28B1FC1;
        Mon, 24 Jul 2023 22:43:55 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3656726a12.3;
        Mon, 24 Jul 2023 22:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690263831; x=1690868631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sWpeQEXkxx6moDjPwLRjO33o1MVNetkxDTfjChMiebs=;
        b=EvoK59qtrucIfirbBPE8V2OhcYmt3T48AT1joPDN1D9Qu+qEE73r4/cc1daLi60Ydu
         W9OjfU6BEWgE9r5RajS4qZrLP5UQcsIxhFCeTxvvj0fepgYJ05eb82mpkxo5rssbsg9M
         O9LnhOGLbT6aHlqvHX3rkQ44kG3WCtwfmRzCiu7oGkCj07RQcLnNb+pzVNlsMY8zP+Ds
         mmmnbup8yyyj2xJCK7RK0HJ5nRTGUuSj/K4D4w045x0iMMuXZ7Mr3RMJyMpbV6609UYf
         pOMcY58xYhu9AUaZv+QAuzNr1EBwFmXyMcKCqbdXlcHjE3J5mOBlAS+i5o6bXO6qiebk
         Q4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690263831; x=1690868631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWpeQEXkxx6moDjPwLRjO33o1MVNetkxDTfjChMiebs=;
        b=bXoR9iGbXvbNXlHZIw1qHHFaPOISozdFew7yK2gWSLITzemJuDNj6VAqTTvCwee5U8
         KYShkQyUG9WsaAvCMw9/tmqVuCweJxb4CZzi9mnXj/nuDA/a6aFXxDeTwX2kw4XhIODB
         eSsJi2eoZFJiZ48kjNNk2KIiNQaaTuCtbMyvzqE2bDjTLDEZ8doRV9RZnFioeaCKOL10
         uZp81ZAzyZr5WhUL8ddoi8WOqIx+q1Mb3ZNlCp6UR1v2UjGV2iv09O7MY4wDpAmj6pBL
         KX58dkR2I6cF1oT+UwURDRA82ojts/xspO5UEK27fPve0E6lDiQlzSxva7Lpof9+zc70
         WCQw==
X-Gm-Message-State: ABy/qLbvjPh9Ts4RXTSeGe7Bp8jETSsQWhTe3LaTjFwI1VoGiQhLE566
        Gd5qEgJ2qopqh00qalcFX2g=
X-Google-Smtp-Source: APBJJlH1oBzcBGr7tDO/0eNp6ihGNRlQs70V0KM9UGizlqp6a736sZfqH/REEYad9RTEhLNxX62GsA==
X-Received: by 2002:a17:902:7893:b0:1b9:d961:69b7 with SMTP id q19-20020a170902789300b001b9d96169b7mr11745734pll.10.1690263830757;
        Mon, 24 Jul 2023 22:43:50 -0700 (PDT)
Received: from zephyrusG14 ([103.251.210.209])
        by smtp.gmail.com with ESMTPSA id jj22-20020a170903049600b001bb54b6c4e4sm9961732plb.147.2023.07.24.22.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 22:43:50 -0700 (PDT)
Date:   Tue, 25 Jul 2023 11:13:43 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-rockchip@lists.infradead.org, ivan.orlov0322@gmail.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Fix Wifi/Bluetooth on ROCK Pi 4
 boards
Message-ID: <ZL9hD2db5xbtpmLu@zephyrusG14>
References: <ZLbATQRjOl09aLAp@zephyrusG14>
 <169022470428.2905604.14514573882052237409.b4-ty@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169022470428.2905604.14514573882052237409.b4-ty@sntech.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,
On Mon, Jul 24, 2023 at 08:52:37PM +0200, Heiko Stuebner wrote:
> 
> Applied, thanks!
> 
> [1/1] arm64: dts: rockchip: Fix Wifi/Bluetooth on ROCK Pi 4 boards
>       commit: ebceec271e552a2b05e47d8ef0597052b1a39449
> 
> and added the "Cc: stable@vger.kernel.org"
> 
> Best regards,
> -- 
> Heiko Stuebner <heiko@sntech.de>
Thanks and my heartfelt gratitude to you for fixing and applying the patch. 
I am truly grateful for your support. 

Due to an increased workload and pressing commitments, there is a considerable 
delay in my responses and patch submissions.

Thanks and Regards 
-- Yogesh
