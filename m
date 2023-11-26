Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC657F9330
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 15:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjKZOvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 09:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZOvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 09:51:32 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C72C92;
        Sun, 26 Nov 2023 06:51:39 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5aa481d53e5so2264856a12.1;
        Sun, 26 Nov 2023 06:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701010299; x=1701615099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VXhDuz/8Ck1SbDSn8m2Zz8T6Djo4LTnE5DIdLUDgM+I=;
        b=GRO67tQObqYTlMlr91bWIYHK3QclirjCGlIpGwnnyB0q4OoKdQ7ixXYyeYghDwgzNl
         /iSiA9vwQ+CZvTqaI6nh2XwCvHtgm9+Hm/mL8Y95f4m4YVqXOJiHwTc7yYMEwF0ZtWhD
         rbrBrguEJ+WKHGFRIj6WEiun0BdGKIdlgtV9Kqtz56fGEZgTew0LHKaOuZoDr7MZ362i
         EnOanD0DCqXaK/XU9b9kUYxgnN4VprbJAdrkxqABf4DSpt/7R1Dg3bxiViVo7hrZg+Zr
         UvsyQFpnKH/IaRz5sgwePdr6s/XGMYUqPcgEkGhxDxN4Zk7dCXU7q0WUSkO5sqSVlXMh
         gYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701010299; x=1701615099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXhDuz/8Ck1SbDSn8m2Zz8T6Djo4LTnE5DIdLUDgM+I=;
        b=novSK+We4grHn69z5CAwMq4Bb0cuhuqClm8Yd4Kr2ydoBjmC2sKnO76jkCOblVWKwj
         FkeCLAdSfMVCYZktbnrapmL7p2VVn9ymsj/Rw/4vgtAWxeNDrWmvOrrr8JWQcqeuaIK+
         LXToYmCReRHxTcp6TNGA2We/GyWTbb10OKnwO+33hSQ+Nj7Iwrodb9mgiH4Dso5cL5d/
         Lq/RVLHGJgBzXWRSg+cC2421aKpZjUhb75BAKskd29As6mfzKVrDA3Bd66DPzn0f9njR
         7v+t+VADY2ImxFfoLoO0ahHwPPLrGn1+EVq0bDpvHthm4wUdI3uRJQHc/TfF1Upo0BTh
         NNbA==
X-Gm-Message-State: AOJu0YxDHyhr66otmR+a7SguP2/IQN9oxlWbzhXs3tjI02hyAoXsjrpe
        1Dk0cGNKf3iu7LIDgNxU/7w=
X-Google-Smtp-Source: AGHT+IEpYvlmT5972piVTAR7DuqSKYsJ4nMGG01b+ZGp1T99G3j+XcRI2OEUOv7lb0JPSY386Jj/RA==
X-Received: by 2002:a17:90b:4c91:b0:285:bd52:32df with SMTP id my17-20020a17090b4c9100b00285bd5232dfmr658222pjb.30.1701010298508;
        Sun, 26 Nov 2023 06:51:38 -0800 (PST)
Received: from linux-8mug (1-162-45-22.dynamic-ip.hinet.net. [1.162.45.22])
        by smtp.gmail.com with ESMTPSA id hg18-20020a17090b301200b002836c720713sm5770319pjb.24.2023.11.26.06.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 06:51:38 -0800 (PST)
Date:   Sun, 26 Nov 2023 22:51:24 +0800
From:   Chester Lin <chester62515@gmail.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, NXP S32 Linux Team <s32@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: serial: fsl-linflexuart: change the
 maintainer email address
Message-ID: <ZWNbOPIs2DjFbipH@linux-8mug>
References: <20231115235732.13633-1-clin@suse.com>
 <b4342c49-e1c4-459e-bbd0-fd63108a6754@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4342c49-e1c4-459e-bbd0-fd63108a6754@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Mon, Nov 20, 2023 at 08:28:47AM +0100, Jiri Slaby wrote:
> On 16. 11. 23, 0:57, Chester Lin wrote:
> > I am leaving SUSE so the current email address <clin@suse.com> will be
> > disabled soon. <chester62515@gmail.com> will be my new address for handling
> > emails, patches and pull requests from upstream and communities.
> 
> Maybe add an entry to /.mailmap too?
> 

Yes, it has been updated as well.

Chester

> -- 
> js
> suse labs
> 
