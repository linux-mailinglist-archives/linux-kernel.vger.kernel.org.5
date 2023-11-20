Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56917F199E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjKTRTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjKTRTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:19:09 -0500
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34FBBA;
        Mon, 20 Nov 2023 09:19:06 -0800 (PST)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7afff3ea94dso169365239f.3;
        Mon, 20 Nov 2023 09:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700500746; x=1701105546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyclGiDya5ElTdlrbB14+3v/ARVDiHt2Ibniy8Hf1lw=;
        b=u5u6tlbYj7aNKLYfUgrny4MqASRHqt3fE965oZ7FgBQP/HUJNh8Cuqvh/k3lzUt36K
         LAB/gcvpYCjF+l2URRQrwpI84KpYrXQWiGpAV/fLntaHDJvDEv5Bwo4FtBqin/BXjeDB
         kWwZNVOdx7S1eNx02dnjBlyCOFijL3R45KUFJ4bM6i1HjS7FnU0mPoWi7935sxO20U4X
         43B/2QBwvYqrAb+HhO117uCIvUUWh0mBeXIxYKE4lXtkN6C62aVvmZKdOGUCI7vUyINg
         Jv4Rx/IQt2lpQsPCUf1Uo9n6WbUHBa0TJCu62VIhy040QrhmCt4+HcQKGZofXk6xgWTw
         2/gg==
X-Gm-Message-State: AOJu0YyTH7piZmYq9/xCqrDtAxyegjuLKGChBf2pOeB0kSMlXCYWbU4c
        D/L3UscPcdpsk3sRgExFCw==
X-Google-Smtp-Source: AGHT+IGNqd6Hys+K1K83ex6FyIigc5GrfZUb/ep+oTstiRwKRhxOw7OPOP+jex+P9qmBuMGob+wskQ==
X-Received: by 2002:a05:6602:3718:b0:7a9:4268:fc26 with SMTP id bh24-20020a056602371800b007a94268fc26mr10884199iob.10.1700500745982;
        Mon, 20 Nov 2023 09:19:05 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b17-20020a056638389100b0042b1061c6a8sm2141009jav.84.2023.11.20.09.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 09:19:05 -0800 (PST)
Received: (nullmailer pid 2370658 invoked by uid 1000);
        Mon, 20 Nov 2023 17:19:03 -0000
Date:   Mon, 20 Nov 2023 10:19:03 -0700
From:   Rob Herring <robh@kernel.org>
To:     Petre Rodan <petre.rodan@subdimension.ro>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Message-ID: <20231120171903.GA2318732-robh@kernel.org>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
 <20231117192305.17612-1-petre.rodan@subdimension.ro>
 <20231119134939.GA8784-robh@kernel.org>
 <ZVpswo3MSScT43Bo@sunspire>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVpswo3MSScT43Bo@sunspire>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2023 at 10:14:58PM +0200, Petre Rodan wrote:
> 
> Good morning!
> 
> On Sun, Nov 19, 2023 at 07:49:39AM -0600, Rob Herring wrote:
> > On Fri, Nov 17, 2023 at 09:22:57PM +0200, Petre Rodan wrote:
> > > Adds binding for digital Honeywell TruStability HSC and SSC series pressure 
> > > and temperature sensors.
> > > 
> [..]
> > > Changes for v2:
> > > - Removed redundant quotations reported by robh's bot
> > > - Fixed yamllint warnings
> > > 
> > > I'm failing to run 'make DT_CHECKER_FLAGS=-m dt_binding_check' due to
> > > python errors and exceptions
> > 
> > What exceptions?
> 
> thanks for asking.
> 
> first off, installed packages. the first 4 are not part of the 
> official Gentoo repo, so I might have prepared them with missing 
> options if any where not included by default.
> I know nothing about python.
> 
> $ equery l dtschema pylibfdt ruamel-yaml yamllint jsonschema python 
> [I-O] [  ] dev-python/dtschema-2023.9:0
> [I-O] [  ] dev-python/pylibfdt-1.7.0_p1:0
> [I-O] [  ] dev-python/ruamel-yaml-0.18.5:0
> [I-O] [  ] dev-python/yamllint-1.33.0:0
> [IP-] [  ] dev-python/jsonschema-4.19.1:0

4.18 and later are not supported.

Apparently behavior we relied on in pre-4.18 was "wrong" usage... 4.18 
also makes rust a hard dependency. That's a problem for any arch without 
LLVM support.

Installing via pip will check this dependency.

Rob
