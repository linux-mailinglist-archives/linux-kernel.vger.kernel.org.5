Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE37F7D79D7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 02:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjJZAxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 20:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjJZAxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 20:53:02 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D6D133;
        Wed, 25 Oct 2023 17:53:00 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b512dd7d5bso206138b6e.1;
        Wed, 25 Oct 2023 17:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698281580; x=1698886380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aiA0G+RcJh/B2NSPmfmRCBdOdOC8eCI9QohAQfa1giY=;
        b=St6vpWMD4XRacetK7N8I00BJOCAV2LCoW5gxavt+OoJEfNU0J1rRJ4qA8knh1uwpax
         p+0yEpt/K64BTwT1U0wefUC9+A8OuNY/Q1EsqTMZG1DBAhFPCuEtnh41f/Wxko6rxS7+
         X6WyGXqd5v+kB4yWERGPBkwRKJwE58AhhrRgODuQ/I5H7nME0MKrR575CtH0EwfxR1aI
         gqrVCfdH6CeshL7C1oSd9OdaumkneVKbh5g8B2Bp3HiRvCCMU7pDKbZaDbnwb6RJmDgq
         jdVWcfZEcNApSXgW2Iu8S+03HkxQ4G0VLuNTJPI7jAjOimCjDZll9GA04CHg30mdFdi3
         sktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698281580; x=1698886380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiA0G+RcJh/B2NSPmfmRCBdOdOC8eCI9QohAQfa1giY=;
        b=jbJRDSVSPv4kYtXTWmtuUD23sA2GtCwUYb+wlHr0GJgJ1LpELg9qJcSx/St95mUG07
         Ka/TApkkDfGzX1mehRYcTAOf6OJ74JiRcJpDELZPOJosf9aYh7wL3lYmrOQkSaRuMMWU
         6fqTkQnukPSpUIHdOXGvXbZ/dOhFktwabTkn79Mz4pNAj27D7jCMip8HBvJ6gkd+Ex5s
         t0VuI3GmWi1Hn0rzHgQL0TbGmm7ZvVqa/DQVCXqRBUhIxd6t3z6g5nszUrykWHhD1bkm
         lnhC+cRgfu0O5ruEeVNhEs2cHKOauN4cokocjOATTJTlEJJLx4D3kX0tB5p0us6xlnny
         TL1Q==
X-Gm-Message-State: AOJu0YyK5VZxaPfFFqwqIh7cKf48r9AKyrUo9JIANb7GWSKNg4D9wYO6
        N4ByL0KtfhHS4+kBI9UlmAY=
X-Google-Smtp-Source: AGHT+IGjeGekXqPJwksk9Z0X2bVnmD2BBR6R+8m1inSFCCSLtmq0nfiILJHwoX2GP251gEgV8gcJMA==
X-Received: by 2002:aca:100c:0:b0:3ae:5a09:9eb9 with SMTP id 12-20020aca100c000000b003ae5a099eb9mr17568550oiq.32.1698281579969;
        Wed, 25 Oct 2023 17:52:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y134-20020a25dc8c000000b00c64533e4e20sm4904560ybe.33.2023.10.25.17.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 17:52:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 25 Oct 2023 17:52:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Saravanan Sekar <saravanan@linumiz.com>
Cc:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v4 4/4] hwmon: (pmbus/mpq2286) Add a support for mpq2286
 Power Management IC
Message-ID: <806ecf60-3f77-4baf-b289-de4a56b30d1e@roeck-us.net>
References: <20231011164754.449399-1-saravanan@linumiz.com>
 <20231011164754.449399-5-saravanan@linumiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011164754.449399-5-saravanan@linumiz.com>
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

On Wed, Oct 11, 2023 at 10:17:54PM +0530, Saravanan Sekar wrote:
> The MPQ2286 is a programmable, high frequency synchronous buck regulator
> designed to power a variety of Automotive system peripherals. Single buck
> converters with hardware monitoring capability is configurable over PMBus
> interface.
> 
> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>

Applied, after fixing the subject. Its tag needs to reference
the driver, not the added chip.

Guenter
