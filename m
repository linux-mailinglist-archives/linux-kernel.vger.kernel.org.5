Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9427A356A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 13:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjIQLwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 07:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjIQLvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 07:51:33 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0993BF4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 04:51:28 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c00a32cbb1so1427991fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 04:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694951486; x=1695556286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O9xrQyEDDPF4pjN0t8fjnGLWFJ3LWmcH4FpyIlSZVAc=;
        b=S07b+Hn6IFR+3nPPr5Km8AWLhysv5NQc016F16LO+cJ3+Fvc+hpKv35xj1HlifEU4S
         A4OpfXAFLrUKSlvqkaBSzRNfj946sUFGzycpWPIle8w4PdY4gWTvCt6qbl6SqA8VUByr
         EctYM5jWhkJUO1CFyrFFef//Ap/EExWT6pO9mzQErnJearn2LN5UIcgamIXopb2UeRFe
         /JnwLcPPiD88hOvU2xNT9feRPoSvBwaGgR+SLIICPR4OfBoKmHZ8bFwN0XFexXYkmy3b
         h4BwH3DLZF4vJG3lfMs/ej0CTYQpt5OHl6GVURNeiawTTZyQOJqG8T1MhzgSjB2PnIJ2
         hFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694951486; x=1695556286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9xrQyEDDPF4pjN0t8fjnGLWFJ3LWmcH4FpyIlSZVAc=;
        b=tWOf/cklT4L15Gbugi2AoAnjyGWrHMjeIPwP9SiHiw8DgOuHLDnp0xXsTjbjW0CU07
         MpXchndT3Q/+Xdj22JVYGIU8bVezQ06a0TQCqnYAqTWF6kfWoRmuT+hk3n/dquo1P/9K
         tN3xzxPy6r1qKSL1q/WPfubY7SGkdyNaoZid7SEb5hJIatafpIthKMb9Sjv1zGaLQoAR
         1MGp7l4CoEABDmq1rl5mfY52gT/wYYSTJBlAbGuPVqfO5ouuZKu4Sfn35JY0lxRmshG2
         E5S2/aYCcIL4Iqz5qCRRiHcl8HXnDNEHptYFEvfu532GSZO/m1/TXLoevMSyka3fuy8W
         9Jog==
X-Gm-Message-State: AOJu0YzT9wkGM07AM+yvbW+BjE9d4hgM8zZgpraJRdGGdn9TBBx6hdkc
        +VmEhANSfrFnBafRY33U6CIx9w3FV5hgyZu+
X-Google-Smtp-Source: AGHT+IH+qthPxv7+ASG27RAKsvysI0ixA/sFrrbszqVZbp5k3YQF1KyKecUXdsvDwO5fw4kcw5a17g==
X-Received: by 2002:a2e:8e91:0:b0:2c0:7d6:570b with SMTP id z17-20020a2e8e91000000b002c007d6570bmr210492ljk.26.1694951485710;
        Sun, 17 Sep 2023 04:51:25 -0700 (PDT)
Received: from HP-ENVY-Notebook (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.gmail.com with ESMTPSA id l16-20020a2ea310000000b002bcbae4c21fsm1581454lje.50.2023.09.17.04.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 04:51:25 -0700 (PDT)
Date:   Sun, 17 Sep 2023 13:51:23 +0200
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: vme_user: Fix block comments where '*' on
 each line should be aligned
Message-ID: <ZQboO4KSoDuANDYe@HP-ENVY-Notebook>
References: <20230909184818.699987-1-bergh.jonathan@gmail.com>
 <2023091339-mountain-asleep-9439@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023091339-mountain-asleep-9439@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 10:33:24AM +0200, Greg KH wrote:
> On Sat, Sep 09, 2023 at 08:48:18PM +0200, Jonathan Bergh wrote:
> > Fixed checkpatch warnings where lines with '*' in block comments should
> > be aligned and were not as well as incorrect tab spacings at the start of
> > comment lines.
> > 
> > Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> > ---
> >  drivers/staging/vme_user/vme_tsi148.h | 140 +++++++++++++-------------
> >  1 file changed, 70 insertions(+), 70 deletions(-)
> > 
> > diff --git a/drivers/staging/vme_user/vme_tsi148.h b/drivers/staging/vme_user/vme_tsi148.h
> > index dbdf5dabaf90..9748b7897527 100644
> > --- a/drivers/staging/vme_user/vme_tsi148.h
> > +++ b/drivers/staging/vme_user/vme_tsi148.h
> > @@ -251,28 +251,28 @@ static const int TSI148_LCSR_VIACK[8] = { 0, TSI148_LCSR_VIACK1,
> >   */
> >  #define TSI148_LCSR_VMEFL	0x250
> >  
> > -	/*
> > -	 * VME exception.
> > -	 * offset  260
> > +/*
> > + * VME exception.
> > + * offset  0x260
> 
> This change is not documented :(
> 
> Also I have two 2/2 patches, yet they are both different :(
> 
> Please fix this up and send a whole new series, properly versioned,
> as-is, I have no idea what to do here.

Great, thanks for your help with these. 
