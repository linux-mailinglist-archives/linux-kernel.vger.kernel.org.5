Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B2E80F51C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377037AbjLLSAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377057AbjLLSAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:00:36 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47657AD;
        Tue, 12 Dec 2023 10:00:42 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d9d29a2332so2796043a34.0;
        Tue, 12 Dec 2023 10:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702404041; x=1703008841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCcCZYfwecxquLlX9Qk4H1uh3FlXglU8cLcEqk1Tg0c=;
        b=ku12+XF9PILNcNWeB8voRm/7luTldInfD7zImBHinj373nb9vPjiAIjKPUzOQsuOsL
         jV6prRSa06hGWPmSd7jNVh3HUrbuZQGOECyYTXpPc2WIVFdIPS4oDDenu83acsSTfHIw
         31cP/fhR+FVBocPdHo0bGMkZvsS12OcbixQWXLBK4oxRV81K4NbKuvvo2ZHmkH3gRuJX
         XiLX4R5hlmfauJx3ZTv6JzVdPJoKS33uXvBfAtZxRFF6YdIgP2eZC0trIqtNC6GJrYg2
         cC7889pOr6ccb1O/BaIwgu5Hn234GHZHiWtMSyYZCaCYqvlfPVB9Wfd5RbnuzlFxxXpe
         nqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702404041; x=1703008841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCcCZYfwecxquLlX9Qk4H1uh3FlXglU8cLcEqk1Tg0c=;
        b=PzottFw2sTiLyzesb6rOqmAkaOOojrQYl0Y7Ft1Moo7/F+b+SpVui2hquTF/7X9F41
         jW4z/8f5x+3GSitPn+jI0PjtO1hiBNOmShini1uuuqXylLmG97Q7bsyg8Kx2vVjmuQs5
         qSvkmxJFCpoSZ4XREdqskxtdJFuS64Tuv808+2jcb1VBRz3GKcSs41gNOkcTO4STxxa7
         VLVJw5Pr2wBNOOXfeZPdNuACz/VvpLsmjFHFHCkqzjywBrX4EHem6FjbsZGljZu7iHeO
         zfxBkCNAzJR6Moz1YqKLUV2mkPkPfp0GDZlQRT+/E2TDb7+dkdm8dSprbWRAnBAC0geE
         f7Lw==
X-Gm-Message-State: AOJu0YxqlNpYTk8FxVhCUvyLT7e1pPpO0e633Ts1j9Od12cfMVzL/x5W
        i1QZaWFd8itcC+prjChsfWc=
X-Google-Smtp-Source: AGHT+IFkasojfWbcCsVLi+mdn01yWMQKc33PTZwYORTSQpbYEFfSP/VEH4VMucXy6fDJEiz7YllCGw==
X-Received: by 2002:a05:6830:26ef:b0:6d9:d132:7ff with SMTP id m47-20020a05683026ef00b006d9d13207ffmr3413281otu.15.1702404041554;
        Tue, 12 Dec 2023 10:00:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e7-20020a056830200700b006d8811cbc3csm2331250otp.29.2023.12.12.10.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 10:00:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 12 Dec 2023 10:00:39 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Conor Dooley <conor@kernel.org>
Cc:     Ninad Palsule <ninad@linux.ibm.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com,
        johannes.holland@infineon.com, broonie@kernel.org,
        patrick.rudolph@9elements.com, vincent@vtremblay.dev,
        peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
        bhelgaas@google.com, naresh.solanki@9elements.com,
        alexander.stein@ew.tq-group.com, festevam@denx.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        geissonator@yahoo.com
Subject: Re: [PATCH v1 7/8] tpm: tis-i2c: Add more compatible strings
Message-ID: <73381bb0-7fa7-4a9e-88df-ab0063058e26@roeck-us.net>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-8-ninad@linux.ibm.com>
 <20231212-avid-grill-dbead068fac8@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-avid-grill-dbead068fac8@spud>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 05:15:51PM +0000, Conor Dooley wrote:
> On Tue, Dec 12, 2023 at 10:40:03AM -0600, Ninad Palsule wrote:
> > From: Joel Stanley <joel@jms.id.au>
> > 
> > The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.
> > 
> > https://www.nuvoton.com/products/cloud-computing/security/trusted-platform-module-tpm/
> > 
> > Add a compatible string for it, and the generic compatible.
> > 
> > OpenBMC-Staging-Count: 3
> 
> Delete this from every patch that it appears from.
> 
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> > Link: https://lore.kernel.org/r/20220928043957.2636877-4-joel@jms.id.au
> > Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> > ---
> >  drivers/char/tpm/tpm_tis_i2c.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> > index a897402cc36a..9511c0d50185 100644
> > --- a/drivers/char/tpm/tpm_tis_i2c.c
> > +++ b/drivers/char/tpm/tpm_tis_i2c.c
> > @@ -383,6 +383,8 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
> >  #ifdef CONFIG_OF
> >  static const struct of_device_id of_tis_i2c_match[] = {
> >  	{ .compatible = "infineon,slb9673", },
> > +	{ .compatible = "nuvoton,npct75x", },
> > +	{ .compatible = "tcg,tpm-tis-i2c", },
> 
> What's the point of the generic compatible if you are adding the device
> specific ones to the driver anyway?
> 

$ git grep infineon,slb9673
Documentation/devicetree/bindings/trivial-devices.yaml:          - infineon,slb9673
drivers/char/tpm/tpm_tis_i2c.c: { .compatible = "infineon,slb9673", },
$ git grep nuvoton,npct75x
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:            compatible = "nuvoton,npct75x", "tcg,tpm-tis-i2c";
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts:            compatible = "nuvoton,npct75x", "tcg,tpm-tis-i2c";
$ git grep tcg,tpm-tis-i2c
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:            compatible = "nuvoton,npct75x", "tcg,tpm-tis-i2c";
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts:            compatible = "nuvoton,npct75x", "tcg,tpm-tis-i2c";
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts:             compatible = "tcg,tpm-tis-i2c";

It looks like at least the generic entry is needed, given that it is quite
likely that there is hardware out there using it. Other than that, this
makes me wonder: Is there some official guideline describing if and when
to use (only) generic devicetree compatible entries and when specific ones
may / should / have to be used ? I suspect the answer to your question might
simply be "because we did not know better", and it might be helpful to be
able to say "please see XXX for details".

Thanks,
Guenter
