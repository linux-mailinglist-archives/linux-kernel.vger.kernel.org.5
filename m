Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BC37FD2E0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjK2Jgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjK2Jgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:36:31 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF01C19A0;
        Wed, 29 Nov 2023 01:36:36 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c87acba73bso86204641fa.1;
        Wed, 29 Nov 2023 01:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701250595; x=1701855395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vm1kAQ0JMuQUe3cnBM9Rhh/BzmqAbhh8B02CHm4+jb0=;
        b=Bwvjkdm0WEuw3I/8evX6ZJnjQ+nCT1rLdo0WlX0FKe7+FCelZGgm7ieZd2msUhqTYE
         jwcDjBp/WifLTUr4RPddS4YVnApq5+tf6IHsrjBl9s0YZbi9ROARoPlMTG3lLQxsO+Iq
         UYJIGpJA1HfzkVUt02F9PPAFThjsqSMbDn7KZqBJkl2g2cteq+F1DpS2Ak7Xf+OlaiNA
         VnMrEVWeAflAs7tQ8le4YKA7K9c14grHbJrmZAy7ZIPgYriHyXf50+dUzL68/OIYMio1
         uM4Dt79D8WMauVD7UeblaNEeRQbmi2XHdHFNYPLng4FAof5Ft1SFkCuYpHkrr02ucTmt
         qsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701250595; x=1701855395;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vm1kAQ0JMuQUe3cnBM9Rhh/BzmqAbhh8B02CHm4+jb0=;
        b=OCbYhBn3307HKS3f9ncbXDsmtTllM3qv40mpPrfdVg76WlZ9TIioPVGUOfsmsaEZ+e
         oKwbqkS6CJRQD/nOHP5PNqLHFN74amqrCutgVuBOjfGOGcjDpjDOzHsikeSmlFPX4Er7
         6uBpzuPehZPHYoDa4vTRzOpuW634SvO7Tq9rVXzDyDkjVljl14wTedVJv1T381fg2Igh
         aquGIphtkyufrOyvHDCJh5koIDR/fLpFALDxO7ptNkq1Ib7pvNusg9zDg1NgEUatCCvC
         57PWm52z6u7qn78dFUNQtfc9Ye/zB8lOLJLYyW1JXeXlrSdl+2V50YHxxkAIS+sLzHOt
         zH7A==
X-Gm-Message-State: AOJu0YyV6lGJxcqXvDZzr8WkS6PSFRQIGg85dhHPENRDNiThblbFYXuB
        dh/MmR/TClsF7+BviwMfbSU=
X-Google-Smtp-Source: AGHT+IEr3Vmw/i5n3af/FbTqT8x+NPR9LcEYvctICJCvZ1Uzas6jUPr0h3huY0LYDt2mJnzqmXX7cA==
X-Received: by 2002:a2e:b707:0:b0:2c8:8b7c:c77a with SMTP id j7-20020a2eb707000000b002c88b7cc77amr11161552ljo.24.1701250594748;
        Wed, 29 Nov 2023 01:36:34 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id fm21-20020a05600c0c1500b0040b398f0585sm1557066wmb.9.2023.11.29.01.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:36:34 -0800 (PST)
Message-ID: <65670622.050a0220.4c0d0.3ee9@mx.google.com>
X-Google-Original-Message-ID: <ZWcGH1IWG8Gs4Gyc@Ansuel-xps.>
Date:   Wed, 29 Nov 2023 10:36:31 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH 02/14] net: phy: at803x: move disable WOL for
 8031 from probe to config
References: <20231129021219.20914-1-ansuelsmth@gmail.com>
 <20231129021219.20914-3-ansuelsmth@gmail.com>
 <ZWcDUJY8rM6uApO1@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWcDUJY8rM6uApO1@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 09:24:32AM +0000, Russell King (Oracle) wrote:
> On Wed, Nov 29, 2023 at 03:12:07AM +0100, Christian Marangi wrote:
> > Probe should be used only for DT parsing and allocate required priv, it
> > shouldn't touch regs, there is config_init for that.
> 
> I'm not sure where you get that idea from. PHY driver probe() functions
> are permitted to access registers to do any setup that they wish to.
> 
> config_init() is to configure the PHY for use with the network
> interface.
> 
> I think this patch is just noise rather than a cleanup.
>

I got it from here [1]

Also on every other driver probe was always used for allocation and
parsing so why deviates from this pattern here?

Also I think it was wrong from the start as on reset I think WoL is
not disabled again. (probe is not called)

[1] https://elixir.bootlin.com/linux/latest/source/include/linux/phy.h#L916

-- 
	Ansuel
