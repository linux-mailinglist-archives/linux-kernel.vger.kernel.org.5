Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4577D895F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344785AbjJZUCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjJZUCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:02:43 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743C2D44
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:02:40 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c59a4dcdacso22027161fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698350559; x=1698955359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ONjs2cH5CApPBAHPgpSMiUb1ljLRxVKfmwTZ42RwfII=;
        b=QEJ6WV7uTqZV5vR2s0xPDqgwEeRz615MlMdrldaKsTEGD3GXhcOeTIJisBtIjOHToh
         1jNDrifG3WGST2IwjucL8MwCKhr9j2NMVkoS5Ox7XVMC5S7yRaRQYGGtkwDI8obfWZ/e
         zMwPJgsfTykqDTwdervJUhOPkP8gYeof/EoH2BhpcrijQg+GCDkKVO/Er2MD4JJyFMae
         UPHZpL4pczT+Qx2H3DDisnmZ58d86+4iN6Z28vCbbroU/gjQGz5ay6cEUZl4ly5bCLkA
         vtDCEr9OButaQC7o3YcMLoOAYSEMLa0cPSi1JgF5bcv2oGWbcXq6aKwGy02IfZ5oIzT+
         cY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698350559; x=1698955359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONjs2cH5CApPBAHPgpSMiUb1ljLRxVKfmwTZ42RwfII=;
        b=KYJlTHgaUoVoECzoruqTq/RUF1DYyDvpH0PEph5/OS/8ib4550DjN2Darsws6Ymklh
         npMAOzql9CbMEue7iNJzAUHZ0Rz186A19eH6ZTOqIGQtBQJ6c91vbz256wrtjQyjTSZk
         oeBgsMavS+uAx8BKcV8cUytpLhsw5XdrnErlbii21K0A6UxOX57n1nPQua97d/qXEDY2
         tHwGhyDS6s8i+xbwxk5Fl9cVTRKG1xi3S3omM4uy2c0ERZJyFFUUlLc/qFfbvCrmC1KU
         4/WJNWAP60D4tBkIEj+NpB3BCD8Doh86CPnqQAXAtsQzN9I7dARTlLMof11dPA0hqqjC
         INZg==
X-Gm-Message-State: AOJu0YzdqT+5W2SfpFddvHIjllI6Z0ARcqGB83Z7T3m3PDjuhjhJcUYz
        rgga5nLmbWnnV4LVBnHNV4gIMGo9531ZFW20
X-Google-Smtp-Source: AGHT+IHoY3Ca81vomgs9IcEqPDy/cXtcgXAgDKSZri5WJ8oEhDFDyj8CO2/eru4bqdr3tSuWfRBtlg==
X-Received: by 2002:a2e:bc81:0:b0:2bf:f32a:1f68 with SMTP id h1-20020a2ebc81000000b002bff32a1f68mr492841ljf.19.1698350558295;
        Thu, 26 Oct 2023 13:02:38 -0700 (PDT)
Received: from HP-ENVY-Notebook (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.gmail.com with ESMTPSA id a26-20020a2eb17a000000b002c02cf6cac5sm2971096ljm.83.2023.10.26.13.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 13:02:37 -0700 (PDT)
Date:   Thu, 26 Oct 2023 22:02:35 +0200
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] staging: octeon: Fix warnings due to introduction
 of new typedefs
Message-ID: <ZTrF27Wm3v0Nn4IA@HP-ENVY-Notebook>
References: <20231021101238.81466-1-bergh.jonathan@gmail.com>
 <7e866f48-840a-4b9e-a28d-2016075abb4b@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e866f48-840a-4b9e-a28d-2016075abb4b@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 05:41:38PM +0300, Dan Carpenter wrote:
> On Sat, Oct 21, 2023 at 12:12:31PM +0200, Jonathan Bergh wrote:
> > This patch series fixes (removes) the introduction of several new typedefs
> > for enums and structs in the octeon driver. First the declarations are
> > fixed and then implementations are updated to remove references to the 
> > old typedefs.
> > 
> > Changelog:
> >  * v1 -> v2: Fix breaking change spread across multiple patches
> >  * v2 -> v3: Break changes up into individual patches for each removed
> >    typedef
> > 
> > Jonathan Bergh (7):
> >   staging: octeon: Fix introduction of new enum typedef cvmx_spi_mode_t
> >     in octeon
> >   staging: octeon: Fix up introduction of new typedef
> >     cvmx_helper_interface_mode_t  in octeon
> >   staging: octeon: Fix introduction of following new typedef
> >     cvmx_pow_wait_t in octeon
> >   staging: octeon: Fix up introduction of new typedef cvmx_pko_lock_t in
> >     octeon
> >   staging: octeon: Fix introduction of new typedef cvmx_pko_status_t in
> >     octeon
> >   staging: octeon: Fix introduction of new typedef
> >     cvmx_pip_port_status_t in octeon
> >   staging: octeon: Fix introduction of new typedef
> >     cvmx_pko_port_status_t in octeon driver
> > 
> >  drivers/staging/octeon/ethernet.c     |  6 ++--
> >  drivers/staging/octeon/octeon-stubs.h | 48 +++++++++++++--------------

Hi
 
> Please don't change the stubs without change the arch/ code.

My tree was out of date, so these changes had already actually been applied
by basically the same patches (ie removing these typedefs) around 17/09 
(Sep).
 
> regards,
> dan carpenter
> 
