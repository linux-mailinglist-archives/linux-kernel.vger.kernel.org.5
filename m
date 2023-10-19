Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F927CF959
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345708AbjJSMuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345529AbjJSMuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:50:17 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A774FF7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:50:15 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso573379b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697719815; x=1698324615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uk0/b8RCb9t8YizAgnysUB+RfVSGoPGfH28jBwJsP5Y=;
        b=bsDSSOAHfJt3OuawQzrvKtn6LfsXeTgDzqY9Vw6BrkrRBt9TZ1fLvHR8wOd0d2OzsC
         Lw6TDkiLWUjAAEoHhonwCEgEMneSK3ifIPBdSwgMS0uy6fIL3mwZd4ZcmLq8nTua6qpe
         hzSj6ypcn0drZm2JFCDK6kWj427N738mBlPTS3yTlx5wVTtzdZPJxj/PXjz3jkebtIlV
         Hz5n0UCMkkRvNjxayx7kKtT2IzpjG+Z//JRPx728GHNdM7KMu+ukj1qWMhNsUZdIJ7yr
         kfk/6p31yAsdnzILAREfniS1HsWXAkUg4bmNRqqhdPtps1izTD/XlnJVLZ5vJ9YIkU1J
         NO6g==
X-Gm-Message-State: AOJu0YwBIlQ6icTmDueDSBrlPcvl7dOyyk1msSDO1L5621jH/idcbxSc
        Hej4GtPI+VzNuQCYouVNpog=
X-Google-Smtp-Source: AGHT+IHkw2FRDzftzIk2H/6P8awG+DX3axjSPibulNSbuum11AybLo+/c3WoYwr+lMiaeGA7fWiw6w==
X-Received: by 2002:a05:6a00:80f7:b0:68a:48e7:9deb with SMTP id ei55-20020a056a0080f700b0068a48e79debmr2549696pfb.2.1697719814935;
        Thu, 19 Oct 2023 05:50:14 -0700 (PDT)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id s4-20020aa78bc4000000b006bddd1ee5f0sm5052125pfd.5.2023.10.19.05.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 05:50:14 -0700 (PDT)
Date:   Thu, 19 Oct 2023 09:50:07 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1697719809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uk0/b8RCb9t8YizAgnysUB+RfVSGoPGfH28jBwJsP5Y=;
        b=QJEQ0mHMTeEEnWqg/DgQRUFkVw94gIa7EeioSfPXhTULC/sgfH2jeYlCpqGc+NqBuPSsnM
        hEpYISv4c+lwEsTxM9LHVrZ3JO7xLudnfqVXqwEqOXZLIt7XzQNk8Vn2Bz0Z/j7enXwgeX
        vHjSs2/O3HXLYO4FHMYANN0tREs9iBUzc/oln12DH+r3CbI8Ogz4uAF7KT95YGBRrxMKRW
        2EUrAQTqdZHJ2tYgSF6LvNo1ooMZvwKVwQ3B07LHIdXR7z4jgYgJNP+2iwx9CewR/aL7MT
        b+mq3O/wsJIdRgX9Nb1joQ0dVrbZWoJifatQwwemhJiNuvpO0j2rdhDx0XHyOA==
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     gustavo@embeddedor.com, outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vc04_services: remove empty functions
Message-ID: <qqvbqinun7wbhaz47i6sk2awplknwbrfutrwfpvj6wq4wgdie6@smhzxank6val>
References: <ZTD677iqMkRPxT27@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTD677iqMkRPxT27@lab-ubuntu>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there,

just as a heads up, the vc04_services staging drivers seem to be
actively developed elsewhere [1]. I'm not sure how they plan to upstream
their code later.

            Ricardo

---
[1]: https://github.com/raspberrypi/linux/tree/rpi-6.1.y/drivers/staging/vc04_services
