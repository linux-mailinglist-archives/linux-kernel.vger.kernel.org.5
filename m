Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4881A785969
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbjHWNdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbjHWNde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:33:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876E3E4A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:33:08 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a3f0a7092so3108054b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692797565; x=1693402365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xv5eVKePCA5KFSpA2pd5w6RyWeOWdv6lLQse6vIRw0g=;
        b=d0rgYS8Y+6I1+6cozNjw+GCbqT2zjh8JbBLG+5cUq6a7l8pa16P7H7MhNGEeYzzkOm
         l4owq0Keli6qT4oZNQX5IDcU/SrmoNm85FbK+7kl2MSMZJczgQC0MOS6NOElJ4Vligka
         LQ5XQKtSN07khtSl7L+wx0+27mqT6nH0NCIiKh7OfyDFr7A+whwjzWmXU1QzfmrLIVL1
         tdvZdaamBtkdSXIMRjB4ubOddSASK1EU5lhzV9T6Ko0MhnWtaiEgwiKD5WcA6hDeOt47
         oC2jHxemd/cNAi+BqwrNVD8MNZp4CQtXwamK3h5qSyx8e8X1RFTiGjapTB/ACvAmoBLZ
         HEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797565; x=1693402365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xv5eVKePCA5KFSpA2pd5w6RyWeOWdv6lLQse6vIRw0g=;
        b=TdhlnPMdZb+huUTPVWWEhMwWD5UcF2JvKolXnLmzZMwoie6+A/eumVN3/9p/O/tgna
         rJ64ZpzdqdyJ06LMAcDTKEExf8zKuCNxLcyScEN0vGf4QtQXRMdhCZ03v3zQdO8uV4mM
         umQ/dUpC84HqxYOjGUaKLgs49NjiRdjJo2LhNhuYLkLR58szPnGN3AbuDPyjlZhsjOdB
         hElRV6ePFhAvxx2XJTvh2n3isDjY1L2S5VAKnmv2WDPGUdFbd3ADTJsyX2iJvbzyOh+U
         C7iHtyOiF1dMById9+ff9BMZOQY2ph9j3uxzjYdxsPdAL9yju20cs/0umdreW01AbZdE
         0M0Q==
X-Gm-Message-State: AOJu0YylwGw8/mhDpROSrjF0yFyl3oQvcY+DOeiDp9YA/B1gltp1nPJw
        ky8c//cOBB9mA38BhpnputU=
X-Google-Smtp-Source: AGHT+IE81MW+dSvaXdO6AZ/Q5CDuianMLXm+d6NIWse2tOCvqLNqSdjiZ2QP2U/ORRuxCdQJXu3NOA==
X-Received: by 2002:a05:6a00:2d08:b0:688:45a0:eb22 with SMTP id fa8-20020a056a002d0800b0068845a0eb22mr13346538pfb.1.1692797565242;
        Wed, 23 Aug 2023 06:32:45 -0700 (PDT)
Received: from ubuntu.myguest.virtualbox.org ([122.162.51.13])
        by smtp.gmail.com with ESMTPSA id a21-20020aa780d5000000b00689f10adef9sm9569926pfn.67.2023.08.23.06.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:32:44 -0700 (PDT)
Date:   Wed, 23 Aug 2023 19:02:40 +0530
From:   Pavan Bobba <opensource206@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6655: replace camel case by snake case
Message-ID: <ZOYKePdysbxp8lDy@ubuntu.myguest.virtualbox.org>
References: <ZOYBM9t0agzTKWwz@ubuntu.myguest.virtualbox.org>
 <alpine.DEB.2.22.394.2308231457310.3210@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2308231457310.3210@hadrien>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 02:58:38PM +0200, Julia Lawall wrote:
> 
> >  		}
> > -		if ((wDelay < W_MAX_TIMEOUT) &&
> > -		    (!(byWait & I2MCSR_NACK))) {
> > +		if ((delay < W_MAX_TIMEOUT) &&
> 
> Maybe the W_ should also be dropped?
even non staging driver have this
https://elixir.bootlin.com/linux/v6.5-rc7/source/drivers/net/ethernet/via/via-velocity.h#L959

> >   *  Out:
> > - *      pbyEepromRegs   - EEPROM content Buffer
> > + *      eepromregs   - EEPROM content Buffer
> 
> Here you could add some spaces to get the - EEPROM to line up with the
> rest.  Likewise later.
> 
> julia

ok 

> >   *
> >   * Return Value: none
> >   *
> >   */
> > -void SROMvReadAllContents(void __iomem *iobase, unsigned char *pbyEepromRegs)
> > +void SROMvReadAllContents(void __iomem *iobase, unsigned char *eepromregs)
> >  {
> >  	int     ii;
> >
> >  	/* ii = Rom Address */
> >  	for (ii = 0; ii < EEP_MAX_CONTEXT_SIZE; ii++) {
> > -		*pbyEepromRegs = SROMbyReadEmbedded(iobase,
> > +		*eepromregs = SROMbyReadEmbedded(iobase,
> >  						    (unsigned char)ii);
> > -		pbyEepromRegs++;
> > +		eepromregs++;
> >  	}
> >  }
> >
> > @@ -122,19 +122,19 @@ void SROMvReadAllContents(void __iomem *iobase, unsigned char *pbyEepromRegs)
> >   *  In:
> >   *      iobase          - I/O base address
> >   *  Out:
> > - *      pbyEtherAddress - Ethernet Address buffer
> > + *      etheraddress - Ethernet Address buffer
> >   *
> >   * Return Value: none
> >   *
> >   */
> >  	}
> >  }
> > --
> > 2.34.1
> >
> >
> >
