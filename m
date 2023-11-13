Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9407EA3FC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjKMTva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMTv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:51:28 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A473B91;
        Mon, 13 Nov 2023 11:51:25 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5441ba3e53cso7249230a12.1;
        Mon, 13 Nov 2023 11:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699905084; x=1700509884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r5K4s3kBHT+Umu52J4mVmVZ4UNlUDCab7dl36PJZCrI=;
        b=CTDjIMMiTl1dTNBKTfA4DdNxpZ+RZvL/v68v6M1S/2B33OJtRAxwb5BiTr+eJDKvFi
         byD2bu1mPvAQSLRlcEiIsrpom9Bqf7euJJMCIvbuRJPvvtS3rBg5bbxiegHHeejB5zdK
         /DVXDNpK/AmdPp0dTmVNKGgtVyXWFFRxLtFG5JHeylXOg5RvgsC/ema1qbQ6udsnTON8
         BykvVm5PnlD4zwNbGVRxwraluACqoMIYc9P6w8jr2F0fdTpQOkm0ThROlb0AWvIrQJen
         RkGqMrfPP5+DlqAQVHj/QuWrdawoqQK72doGgFDejZmJK1HLye40Garpbw1cDT2pp5NM
         CZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699905084; x=1700509884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5K4s3kBHT+Umu52J4mVmVZ4UNlUDCab7dl36PJZCrI=;
        b=jcbxs45WiyUUZwiQH6dpoYHzA+OSI7AUaJHmjG/vUv+qryQHqh7dWRfQx2I0Uaghs4
         1raq8w4iFc0HkuaEeU+p36aFkIEZJT/Zgxo1SJ5LwTLAyZdQS8zmUM7LflucVMM8w64i
         rqzFcZopMTqM/fH9cPr/xjaIXZEYdDESQLqhsnrzB8AXc9iuusljsj7ll36TrjiH7yUp
         22mmRLUG2JZzPTU0NWGZvc9hK3/grgXlNA6HK8S9kzjguA3u4XP17OS+Ht4/djjzOmbw
         GOvEIZimm9IJYRHNh/Dvm6QV0A4QunrbXb8cDp0dEgou+aPYA0jL6JWzfhde7ChJ6Ovy
         mV0A==
X-Gm-Message-State: AOJu0YyvwkzjI+Doja2l15Cf8ncyHezgO0BRP5PL698huFptr6OYOtkb
        Yf2Qi6v/bh3gVJPPXLUrTcRnjOEL5Ts=
X-Google-Smtp-Source: AGHT+IHB5u/2nMKfIi/EDCbgY3RqIEspofPZTMCI445n8dO3DqB+mlK2iPqDy7z60h3BcrGtAqdZPg==
X-Received: by 2002:a17:906:4551:b0:9e3:277d:3233 with SMTP id s17-20020a170906455100b009e3277d3233mr5483490ejq.13.1699905083611;
        Mon, 13 Nov 2023 11:51:23 -0800 (PST)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id jx11-20020a170906ca4b00b009e62bb0439bsm4481417ejb.212.2023.11.13.11.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 11:51:23 -0800 (PST)
Date:   Mon, 13 Nov 2023 21:51:20 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Jie Luo <quic_luoj@quicinc.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] net: phy: at803x: add QCA8084 ethernet phy support
Message-ID: <20231113195120.44k6hhth7y53df53@skbuf>
References: <423a3ee3-bed5-02f9-f872-7b5dba64f994@quicinc.com>
 <20231109101618.009efb45@fedora>
 <0898312d-4796-c142-6401-c9d802d19ff4@quicinc.com>
 <46d61a29-96bf-868b-22b9-a31e48576803@quicinc.com>
 <20231110103328.0bc3d28f@fedora>
 <3dd470a9-257e-e2c7-c71a-0c216cf7db88@quicinc.com>
 <20231111225441.vpcosrowzcudb5jg@skbuf>
 <39a8341f-04df-4eba-9cc2-433e9e6a798e@quicinc.com>
 <20231112235852.k36lpxw66nt7wh2e@skbuf>
 <ZVInvOqh6QAvNJtw@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVInvOqh6QAvNJtw@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 01:42:20PM +0000, Russell King (Oracle) wrote:
> On Mon, Nov 13, 2023 at 01:58:52AM +0200, Vladimir Oltean wrote:
> > From 17fd68123d78f39a971f800de6da66522f71dc71 Mon Sep 17 00:00:00 2001
> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> > Date: Tue, 3 Oct 2023 22:16:25 +0300
> > Subject: [PATCH 1/2] net: phylink: move phylink_pcs_neg_mode() to phylink.c
> > 
> > Russell points out that there is no user of phylink_pcs_neg_mode()
> > outside of phylink.c, nor is there planned to be any, so we can just
> > move it there.
> 
> Looks familiar...
> 
> http://git.armlinux.org.uk/cgit/linux-arm.git/commit/?h=net-queue&id=c2aa9d3846c218d28a8a3457b0447998b0d84c5d

Well, yeah, I did mention that the patch was written at your suggestion,
and there aren't that many options in which that patch can be written.
I didn't look at your trees, and I made that change as part of a much
larger effort which involves phylink, which I will email you separately
about.

I will gladly drop my ownership on the first patch and ask Luo Jie to
pick your version instead, if this is what you're implying from the 2
word reply.
