Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1B17DEF6B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346266AbjKBKFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346256AbjKBKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:05:02 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA47B13D;
        Thu,  2 Nov 2023 03:04:58 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507a5f2193bso812629e87.1;
        Thu, 02 Nov 2023 03:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698919497; x=1699524297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4hq29oAXI+WQ+QRQYNg3arnm1bj+T+CctuX6ztlKDPc=;
        b=gvSg6j3fAJitFBAJbvpr7szGe+8zZp68PxvSMHpRuesFuTyyv0ebNUcteYXrj5JPIm
         X6Y27E5vzpDkP1JZYcBJ2fKcqBz3CF8B7ehvvfb7Z8H44qKxl1t72ULcdj6/MJ/oj9hb
         9H3XqMOw17KDJ4oZp4yopelgEycwMd7KRYQTk57R5amAymPgBTUUkb7Ox9KsrhhKSWwM
         tt9YjN/KdlnBpedzfr8nhKVhAV0RUwzUjtafw0wtnuOC6R2KpuBYErrPNj3QDDRnhuTv
         /ch+IZvB8Kf4fAJ2Xg927J0je9AWdy/U75QDqOXPyTqLsYu7LP/gSgkqeJbPLLPiYZGo
         VfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698919497; x=1699524297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hq29oAXI+WQ+QRQYNg3arnm1bj+T+CctuX6ztlKDPc=;
        b=UzhgA5+O1FwpzOkA0o5V2fCDPwPiVofAMIAkUIVH9eS365pB7XIu4m3z9grgyTmYxe
         kpormWhOBoR8PdEhgk9JiB5/NgG9+edX4qZALY+djBkfTmGjH6sSf278oHJGmQhdWWnC
         wV8+Pdwb8sCKETqCX36HnUmIsUA4XXn85fy5Gs5HOw/vbu3aiBJHW/bUZtg3aGJwJlsm
         W50nquqxGB9KUgUzCtj68O65YQtOqofuXR5H+nCaVKCmhOTRXKBZ+JnDANMRKJf4qAb1
         CLVeFGYBaZzKW3w0/4ullil44luartR9rwPPmcT567ULdlDfArcqhZuGoK1DRz14Da2B
         iEBA==
X-Gm-Message-State: AOJu0YxDoed309NLwIJrHGJbExRtra/HJnh8P6rNILwdIsKwHuhWav8w
        UayEFVl/2SNADbjnzC2cvZo=
X-Google-Smtp-Source: AGHT+IEAzlrHwjbigmWLpJgHUlqixx1zUogak6aqGsXbWh6+UF5WMA818E2+f44HfoyPhESpjAIcmw==
X-Received: by 2002:ac2:4e0d:0:b0:4ff:839b:5355 with SMTP id e13-20020ac24e0d000000b004ff839b5355mr1652747lfr.18.1698919496681;
        Thu, 02 Nov 2023 03:04:56 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id k17-20020a0565123d9100b0050089b26ea1sm442247lfv.276.2023.11.02.03.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 03:04:56 -0700 (PDT)
Date:   Thu, 2 Nov 2023 12:04:53 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
Message-ID: <20231102100453.dwnaxbdzf3j3ifrv@skbuf>
References: <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
 <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf>
 <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030233334.jcd5dnojruo57hfk@skbuf>
 <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
 <CAJq09z4+3g7-h5asYPs_3g4e9NbPnxZQK+NxggYXGGxO+oHU1g@mail.gmail.com>
 <CACRpkdZ-M5mSUeVNhdahQRpm+oA1zfFkq6kZEbpp=3sKjdV9jA@mail.gmail.com>
 <CAJq09z6QwLNEc5rEGvE3jujZ-vb+vtUQLS-fkOnrdnYqk5KvxA@mail.gmail.com>
 <CACRpkdaoBo0S0RgLhacObd3pbjtWAfr6s3oizQAHqdB76gaG5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaoBo0S0RgLhacObd3pbjtWAfr6s3oizQAHqdB76gaG5A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 09:26:50PM +0100, Linus Walleij wrote:
> > [    3.967086] realtek-smi switch: set MAC: 42:E4:F5:XX:XX:XX
> 
> Unrelated: I have seen other DSA switches "inherit" the MAC of the
> conduit interface (BRCM). I wonder if we could do that too instead
> of this random MAC number. Usually the conduit interface has a
> properly configured MAC.

We need to know what is the MAC address from the RTL8366RB_SMAR
registers used for.

What you know about is that DSA user interfaces have their own MAC
address for packet termination (send/receive to/from the CPU). MAC
addresses for switch ports are an abstract concept, of course (switches
normally just forward packets, nothing is addressed *to* them), and so,
these addresses are not programmed per se to hardware unless the
prerequisites of dsa_switch_supports_uc_filtering() are implemented.
If they are, the MAC addresses of user ports are programmed as host FDB
entries (FDB entries towards the CPU port).

The rule for establishing the MAC address of each user port is as
follows: if of_get_mac_address() finds something valid for that port's
OF node - provided by the bootloader - ("address", "mac-address",
"local-mac-address", a nvmem provider etc), then that value is used.
Otherwise, the MAC address is inherited from the conduit interface.

Some switches also have a global MAC address register (used for all
ports) of their own, but it is switch-specific what this does. We look
at the functionality it offers when deciding what to program it to,
since it's of course not possible to sync a single hardware register to
the value of the MAC addresses of multiple user ports.

For KSZ switches - see ksz_switch_macaddr_get() - the global MAC address
register is used for HSR self-address filtering and for Wake on LAN.
We sync the value of this hardware register with the MAC address of the
first user port on which these optional features are enabled. Then, we
allow these optional features only on the other user ports which have
the same MAC address as the original one which enabled that feature.
On KSZ, the same switch MAC address is also used as MAC SA in generated
pause frames, but to our knowledge, that MAC address could be any
address (even 00:00:00:00:00:00), so we don't really care too much about
that and we let it fall to whatever value it may.
