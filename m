Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D73A7BFE92
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjJJN4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjJJN4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:56:42 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB42A9;
        Tue, 10 Oct 2023 06:56:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6910ea9cca1so4149861b3a.1;
        Tue, 10 Oct 2023 06:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696946199; x=1697550999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=One8tdSFLa+G5R3uW9c+lPYATRm9PNZP9LLd+yohDZc=;
        b=av6oPsFKBYOmJhfvOfm6lACOhEYhw6Nui2Jcz4dJMyiS7K5dMVHP8PwaNbkXbf0yoI
         Eh+Z1hcLG8uZsqVielqnlJ0Q5HRuZ9YTnx88y6zjVdIFJ5njaGIWzAFCnMXoJj2GuZqu
         tgqYXUtEAh2d1deqBv7xevbCC3bCfyNCIE1oWImJtNbRy+k0o/TOuO8vL/CpUaXPQSJS
         EEwjCdDOKgTa/7m2y2eC9C/rD3psRwPiDhjOkyNnur2ijgpOIlIx95LEM617vx+xhVhW
         rldTeahmEYIDgiRygneO5DxjiUdraDu0jx9EFquA2rIIYukWOcyBCNHSVn4N/HFUQHap
         0lQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696946199; x=1697550999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=One8tdSFLa+G5R3uW9c+lPYATRm9PNZP9LLd+yohDZc=;
        b=takzlhK5EYaZKVZQX2POmDyHZjr5uQ+dLhXEPASq9bTuOn+mxvrnkuEXgChiXFTLz6
         kIrAK4OII810n99rcEl8wa6ue5sLP7jhQBnqkKQohbZHW++nLxg4oX7GuoPt8y03btSp
         A9wrGg1G8uOqrFiRp6ueVKH6dgXpEgQugf3gbng/MB0a5rXdgQSxbkSMXXcKJD6PHUI4
         ATwryqpiC+RRF6klpLqOAgYJFNisNbXmDpTrJchtFePj0haS59XzUHp+icVGSADBsuph
         hF5jwTrkNC1gpUIBsD74NqXJfAUy3Z7Y9xNFo+Emx+uALP/1ZS8hfMIFbQdIYrfKIRS/
         2q5g==
X-Gm-Message-State: AOJu0YxrOTe/fHzhue2pyjYdoFnTFFBnf+qYAHJAPiHDvXESxAr0QUOT
        zZW7QAUXMznbu6ZhRvGOSiw=
X-Google-Smtp-Source: AGHT+IFAJe97RQBU9IrmP6CBGTTCTSbI/CNbpn+aJ6KoJybMQXZxThC0c70sbGshwgQQuXMu2dfxuQ==
X-Received: by 2002:a05:6a21:181:b0:15e:dca8:1224 with SMTP id le1-20020a056a21018100b0015edca81224mr18905408pzb.55.1696946199234;
        Tue, 10 Oct 2023 06:56:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v5-20020aa78505000000b00696ca62d5f5sm8280638pfn.8.2023.10.10.06.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 06:56:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 10 Oct 2023 06:56:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Nik Bune <n2h9z4@gmail.com>, wim@linux-watchdog.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        skhan@linuxfoundation.org, claudiu.beznea@microchip.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3] dt-bindings: watchdog: atmel,at91rm9200-wdt: convert
 txt to yaml
Message-ID: <0ec4f647-77b9-4b3f-9cbd-6fb122f09462@roeck-us.net>
References: <20230924181959.64264-1-n2h9z4@gmail.com>
 <20231010132921.GA628810-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010132921.GA628810-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 08:29:21AM -0500, Rob Herring wrote:
> On Sun, Sep 24, 2023 at 08:19:59PM +0200, Nik Bune wrote:
> > Convert txt file to yaml.
> > 
> > Signed-off-by: Nik Bune <n2h9z4@gmail.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > 
> > Changes in v3:
> > - Removed trailing whitespace in an element of the maintainers list.
> > 
> > v2 patch: https://lore.kernel.org/linux-devicetree/20230924172004.59208-1-n2h9z4@gmail.com/ 
> > 
> >  .../watchdog/atmel,at91rm9200-wdt.yaml        | 33 +++++++++++++++++++
> >  .../watchdog/atmel-at91rm9200-wdt.txt         |  9 -----
> >  2 files changed, 33 insertions(+), 9 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt
> 
> Are the watchdog maintainers going to pick up this and other watchdog 
> bindings?
> 

Tricky question. I am way behind with my reviews, and historically you have
picked up some of themm, so I really never know what to do with bindings.

Guenter
