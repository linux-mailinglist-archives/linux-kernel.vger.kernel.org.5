Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE65803ED6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345197AbjLDTyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjLDTys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:54:48 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FC5120
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:54:54 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-67a8a745c43so35993106d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1701719693; x=1702324493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JGHpcniqj4N4OVIiCaIFNQVtHMVvgMth5+0aM+Fp7ss=;
        b=g8hKhZP0a7uwxMliF/GtyrDiywzEIRMn3by8xFgEk7Xpyk69ai9pPb7JuSRSyYsmcf
         Dtr/DtqmTAvCIZRflijKhlLW1nQ1NvY4dke1GasvOE87V7hYrfw7l+43k9yEtpX9zvMS
         DFzF8x2rKGlTz1H999X1gloUFTkpNoDqcF6+yjprBid5Q7+FV+R2JKkY/cK1v1igVeQj
         X6Xg4eKEdG5BdLEh9Kj7Ipw7NDuvThXBazt5mfQwGAfoxakT71kR6NGk/vONNVCTVgwZ
         scPOgwPKD34X2DFvWXkxVaF2yuv4hkEmoPljNCexsgwGUZXKqy2Hv5B8ohryeCOR7M8s
         4FUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701719693; x=1702324493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGHpcniqj4N4OVIiCaIFNQVtHMVvgMth5+0aM+Fp7ss=;
        b=U/n759LloCHApmuJKhVjHT6bg7xRj5xnfk5oRXhkdWPWKjzlSxEelv95Pm3mIOlyCe
         BaEJDrce4DY0MzmoU2fuG+8VBMs7XuFk400j2f1Jlbn62iPUZfreXxGwq7kZswyueIAE
         KofBAfWw0XXgVjy+HL8v6eXufsO30yUb6maV4crtWS9k3xQFR80pqrf0lW77Zlwzsta4
         ONV6kWa5OUAGdlrxVDGnTKhYHEZGb0ROYuRpt1DbD8eN2c3WnHARtqUNTYkqTDSXLRjS
         S0HxxODenUnyaEvv37ASJsuUmP7EC1l90c45KPWAMzuu69IVEF1k9Jw3HHcgl6rEWK9r
         bwjA==
X-Gm-Message-State: AOJu0Yyax7PbX5K/VsyWF+/rppskKaRCT9pFRzGnHpBMlx9V+Y1SDizP
        EgAJLeHBeYOe3ocKlwGj13XfqQ==
X-Google-Smtp-Source: AGHT+IGpQzkoEjzpqYLjRrG6QQOYQ6WgA8JZOQ7QLOJykpYca9iIy4BV9JC0iVY98WV8uaPFAB+4KA==
X-Received: by 2002:ad4:58e5:0:b0:67a:c4d9:dc15 with SMTP id di5-20020ad458e5000000b0067ac4d9dc15mr18233qvb.43.1701719693130;
        Mon, 04 Dec 2023 11:54:53 -0800 (PST)
Received: from dell-precision-5540 ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id v11-20020a0cdd8b000000b0067ac1c30e80sm1459715qvk.120.2023.12.04.11.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 11:54:52 -0800 (PST)
Date:   Mon, 4 Dec 2023 14:54:00 -0500
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>
Subject: Re: [PATCH] spi: stm32: enable controller before asserting CS
Message-ID: <ZW4uWBpEc2_4JR2b@dell-precision-5540>
References: <20231201214014.2539031-1-ben.wolsieffer@hefring.com>
 <b070eb2a-05d7-4e6a-8de9-15179045d192@sirena.org.uk>
 <ZWpoKEcM0ZeYAsBa@dell-precision-5540>
 <9aa5e049-bd1c-41a6-b9b8-037ebb4f54b8@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9aa5e049-bd1c-41a6-b9b8-037ebb4f54b8@sirena.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 12:43:42PM +0000, Mark Brown wrote:
> On Fri, Dec 01, 2023 at 06:11:36PM -0500, Ben Wolsieffer wrote:
> > On Fri, Dec 01, 2023 at 09:50:33PM +0000, Mark Brown wrote:
> > > On Fri, Dec 01, 2023 at 04:40:14PM -0500, Ben Wolsieffer wrote:
> 
> > > This feels like it'd be a good fit for moving to runtime PM - that way
> > > we avoid bouncing the controller on and off between messages which is
> > > probably better anyway.  The driver already does pinctrl management for
> > > the device there.
> 
> > Yes, that probably makes sense. There are a few bits that can only be
> > configured while the controller is disabled, but it doesn't look like
> > that applies to any of the ones set in stm32_spi_prepare_msg().
> 
> > I'm a little hesitant to make big changes to the driver since I can only
> > test them on an STM32F7 though.
> 
> It doesn't seem much more complex than what you're already proposing.

I'm working on a new patch that uses runtime PM and will submit it soon.

> > > It also occurs to me that this isn't going to work for devices which
> > > chip select inverted - for them we can't stop driving chip select at all
> > > since they need it held high when idle.  There aren't that many such
> > > devices and it'd loose us the PM which is rather awkward...  I guess
> > > that's an incremental issue with a more invasive fix though.
> 
> > The driver only supports GPIO chip select rather than native, so I don't
> > think this is a problem. Also, I don't think there's any difference
> 
> So mentioning the drive seems a bit confusing then?

Yes, I should have been more specific in the patch that only MOSI and
CLK float when the controller is disabled and that CS remains driven.

