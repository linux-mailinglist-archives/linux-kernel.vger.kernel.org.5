Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3B07E6E03
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbjKIPtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344186AbjKIPtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:49:00 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF6B5FC2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:47:16 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9dbb3d12aefso177553366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 07:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699544835; x=1700149635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V86YdR3Hfd873OI39zmWJwzhpNlFt7JR8odQ1dpLszY=;
        b=B3g/C+h5vqBuyoGLCXK0Wy5tg+XNZ/KEDzSCkHcpuwb8NOCS6Kmq4TMferlU4Lp7M9
         y814Aj+ykAKfqBlL1Og7mR3Gg2v35gExL4H6gKtiB6SxyjUWnYkcSgkA8kSj3u4IFErU
         L6n/GHC94dFTGW8i7DYzM8pKrTgbWPvXiQNlPMRm1NSPRzNShZRIO3dfXaZIdcO+W2lJ
         d+vQipqSPfe/IqufCft78Pmf920h6m26N7h4n/ZVRjaHxIArQJ2uZfmlWiPgYCWm75sH
         sv0CGEYCWdaCeDQCsiUZgOZuGPVESn7FeQ1MOjslwYmXuWjMPpo3CQzEsInUCizfjZrg
         ULgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699544835; x=1700149635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V86YdR3Hfd873OI39zmWJwzhpNlFt7JR8odQ1dpLszY=;
        b=SXq8xb2XUqc7V0qfrr5/rjrIb1xTGyucZn/kuUUP/0mcLx/hAQ7gAg/qQknFbOM/75
         BLN+FO01M5atrabS1nE+v8T9xOEdl0CVYAOjbBc8jgd57yXQjFuV92WxSGGcI2WsHDjA
         yh2e5UKfcxV11w4B3dekJmk5K/zNUEwK1MXmg7vCUkdyOBaP3Sk4mAa85wmgbI8ILbSC
         KDmca2WrGnjvJE7edY6zWVi2QfiIK8hgd9ftje/lwGRwC5ZnbpJxn/tLu1ILNErBQXOA
         UoumLXuO7xIZMMjOwiJw2Rwy3/Voci7EiaunaAKG9V1ih1BQcjxvvjLRlv3VoGNF4Iz+
         3C6w==
X-Gm-Message-State: AOJu0YyuXcf5/69XMZ3lgbIcHqXUWVL0B8D4/HTZi0Qfkg6E35CTvzPM
        wOlDD1xBKTngTmGattyTSnkILQ==
X-Google-Smtp-Source: AGHT+IF6F9GAAxLVxsMGP4dOKKwmzN2I5Tj8yfH0Uqd81zsaR0/UK0fOHyDdH21sTUAUD+0vYB4vaQ==
X-Received: by 2002:a17:907:94cf:b0:9be:2991:81fb with SMTP id dn15-20020a17090794cf00b009be299181fbmr5167814ejc.36.1699544834901;
        Thu, 09 Nov 2023 07:47:14 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id jt6-20020a170906dfc600b009dd7097ca22sm2705598ejc.194.2023.11.09.07.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 07:47:14 -0800 (PST)
Date:   Thu, 9 Nov 2023 16:47:12 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] boning: use a read-write lock in bonding_show_bonds()
Message-ID: <ZUz/AB/kdChj5QHE@nanopsycho>
References: <20231108064641.65209-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108064641.65209-1-haifeng.xu@shopee.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/boning/bonding/
?
