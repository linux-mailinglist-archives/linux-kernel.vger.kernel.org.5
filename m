Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D342F7D0CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376764AbjJTKTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376596AbjJTKTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:19:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13496D45
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:19:47 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9be3b66f254so95297166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697797185; x=1698401985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iWVWVksSmm7aQ8JRN/GkgbGDZnVlaVxnvyhSePbu/vg=;
        b=iR3p7awj6KOWijEvSIw3AYnnbZxVNL8VeUmbCM5TfFAMzJSK2BO1HneSpBtSLl2DYD
         TL1wbfdgyLQNYjuFNRYb9CMXdxnAr9visVAezJehmjCUK1Ren7OxJZk833xa1YSL7wWA
         /OQqHb3+Rnk3W9ZylbaiUxYFZHOrkKkqHpBGFFCj1aVEHbojzN1PKcZvz5q1pYkBH+6p
         QtiqonZtYyGBfofYu84LyCHBSze72h17a4pT4xgKXMqOsXYQ4OiE/u064/SM0nb9RJVX
         VV5BTKZ0PWCpJxjzIn0a32cJO7FKUMc8HEorW29mFcdAyp/Kz/XosZwjbHzpxlP9IWqX
         m47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697797185; x=1698401985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWVWVksSmm7aQ8JRN/GkgbGDZnVlaVxnvyhSePbu/vg=;
        b=YHuT6/m7GrLCI3jG0HoVmnh5SeR1ZqF1pVZ5LipdCyQP8ioTjJRuL4P2IUlBpmYcF5
         +kNmjJSLKy7fqXT9CQEIYcmQLIoQar6toA1DrYH/1WQY9wzKrh93WMEGj1zPYlxphSpC
         QmcMCLzt+drpuIq9XIXILI3nFxKqoyRKZQZcmiKN7ZOAnYQla+TffseAD2muOSdqSvUw
         NxxKqeq2R+BdvtNboTmivGjM3vbXccZ3RkfaH1OWsVQcv+FBtWygOIu3pXRKQqtKZp31
         MrSh/urxdud1U/EX/SO/1+o1Xm11Ro7s38LsRGLdhQgA4qtikodEnSck3xDVO6DFAdpG
         cLrQ==
X-Gm-Message-State: AOJu0YyJdXklweXo/1aMBHf/mlGBIuPOSiZBsJpBJRZmJELTlOExzq4/
        mnyzxsF91QZ5reryT3C6dWKf1lsO8lQ=
X-Google-Smtp-Source: AGHT+IEYDM00ovAEg4QMqc90xhxNrwrKs2WgwkwKPDXq88HvEkyFavLOpnaV4/ZOSlMz8RWjiaA4CA==
X-Received: by 2002:a17:906:7956:b0:9be:e153:3b82 with SMTP id l22-20020a170906795600b009bee1533b82mr912336ejo.17.1697797185221;
        Fri, 20 Oct 2023 03:19:45 -0700 (PDT)
Received: from andrea ([109.54.114.151])
        by smtp.gmail.com with ESMTPSA id e27-20020a170906749b00b0097404f4a124sm1212696ejl.2.2023.10.20.03.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:19:44 -0700 (PDT)
Date:   Fri, 20 Oct 2023 12:19:38 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Christoph =?iso-8859-1?Q?M=FCllner?= <christoph.muellner@vrull.eu>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, David.Laight@aculab.com,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v3 0/2] Add Zawrs support and use it for spinlocks
Message-ID: <ZTJUOji+B+dDbMKh@andrea>
References: <20230521114715.955823-1-heiko.stuebner@vrull.eu>
 <ZTE7eUyrb8+J+ORB@andrea>
 <CAEg0e7jkTOn1pjO=+GaiCZJ9_Yd2NcB1GMG=Q6m3-r0+Q0OjGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEg0e7jkTOn1pjO=+GaiCZJ9_Yd2NcB1GMG=Q6m3-r0+Q0OjGQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Removing Heiko's @vrull address from Cc:, since it seemed to bounce, keeping
 his @sntech address.)

> I had a quick look at your changes, and they look good to me.

Great.  Thank you for looking them over.

> Did you agree with Palmer about testing requirements?
> I.e., do we need to run this on hardware that implements Zawrs in a
> non-trivial way?

I didn't quite discuss such specific requirements or hardware implementations,
but I agree that's a valid concern.  Not that I currently have access to such
hardware; any further inputs/data will be appreciated.

> I can try to raise the priority on this here, but can't promise anything.
> For me it is also ok if you take over this patchset.

Thanks.  Either way works for me.  No urgency from my side.  I'd say - let us
leave this up to the community/other reviewers.  (IIUC, Palmer was recovering
from a certain flu and might need more time than usual to get back here.)

  Andrea
