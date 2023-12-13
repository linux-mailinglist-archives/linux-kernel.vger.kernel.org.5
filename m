Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BBA811FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjLMUP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjLMUP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:15:26 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D389C;
        Wed, 13 Dec 2023 12:15:31 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c317723a8so64072355e9.3;
        Wed, 13 Dec 2023 12:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702498530; x=1703103330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb5B6Yi9sghxkDMCL6Vt09IrQB+8r0DuYMikKdRw/lc=;
        b=PCDS5xsTMRP1UYxJG/5a1yKY6dKnAyHRqCMvt8XW3lvhMXGpeqqmqOE93QguPxDIcl
         3rE6UgdBtJjp7/esPc7CTkjoDlYRg01+0gfeCg0OlugBY4g5yoEV7hLzxXiWByTNyBt8
         I0Wz3GW0WV/Z404rv0J+omFyL+j2tCNz87wSSLfoSRH8FBuiXS1nFZzjWiBhK4FCzwpI
         S4vR7SXFEgePdy4p2HckmBD1hCmGIU1DEGI0KHqTUTm6Cmrf3ID9ZYi/j0S7CjxMRnZx
         xDC2oqmd95eHZu6Kw1xIzdP0hDdb64RyplZEqQEkZMxYD6bAO6riI/+euOkaZd/tYX6V
         uHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702498530; x=1703103330;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vb5B6Yi9sghxkDMCL6Vt09IrQB+8r0DuYMikKdRw/lc=;
        b=guCsNrE9X32jd9XJK/ZjOK5ZAmbNl6noE+i95SMT0Wc8aO71g2KMJegt3deDsuR+5c
         YCEueWp2gLb9X7r4iQfHEcx6vbx/P8jCGc2gSxdvghvIky3jBEEEJMSz80DMjD7E8NZN
         c8gyjMJRjwF86GcXmpHq1/yBQXpx/8oIigXiCu0oBJYULTS+vrKEKsCucZUcc5S8+lqH
         17LZBWuKWw9kO9vBBcBw+ErFX6jj7xWGtGrNrJ1+gNoxYcLrg+wuzVI3eH913E8/cnJc
         cAbYmDwzrjMJA3NOZxT6Eu6qW291WgmUJfNC0JGT9rNeVnVz/qJTZ+N1aWuuuDKEEiJ7
         0c9A==
X-Gm-Message-State: AOJu0Yy1n7ilZ+mg+pOXZcpQff+CMXqhy/xSGg+ADAoNrnM92q9WQWO8
        9j/bQ39mbP+TxOS72lr+hdg=
X-Google-Smtp-Source: AGHT+IGt77bq+tJdZfS3kvtLEs7hLVZ3XtfobDRpKoGENDqN+bvJEfNqHY62OfsG1FJFgLUqwJdA1w==
X-Received: by 2002:a05:600c:2a41:b0:40b:5e21:d344 with SMTP id x1-20020a05600c2a4100b0040b5e21d344mr4754263wme.77.1702498530206;
        Wed, 13 Dec 2023 12:15:30 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id az27-20020a05600c601b00b0040c34e763ecsm20923276wmb.44.2023.12.13.12.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 12:15:29 -0800 (PST)
Message-ID: <657a10e1.050a0220.22d18.b3cb@mx.google.com>
X-Google-Original-Message-ID: <ZXoQ3wofRFV3XVfc@Ansuel-xps.>
Date:   Wed, 13 Dec 2023 21:15:27 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Kees Cook <keescook@chromium.org>,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] net: ethtool: add define for link speed
 mode number
References: <20231213181554.4741-1-ansuelsmth@gmail.com>
 <20231213181554.4741-2-ansuelsmth@gmail.com>
 <ZXoPwmDsy7geZe6N@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXoPwmDsy7geZe6N@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 08:10:42PM +0000, Russell King (Oracle) wrote:
> NAK.
> 
> You *clearly* didn't look before you leaped.
> 
> On Wed, Dec 13, 2023 at 07:15:53PM +0100, Christian Marangi wrote:
> > +enum ethtool_link_speeds {
> > +	SPEED_10 = 0,
> > +	SPEED_100,
> > +	SPEED_1000,
> ...
> 
> and from the context immediately below, included in your patch:
> >  #define SPEED_10		10
>            ^^^^^^^^
> >  #define SPEED_100		100
>            ^^^^^^^^^
> >  #define SPEED_1000		1000
>            ^^^^^^^^^^
> 
> Your enumerated values will be overridden by the preprocessor
> definitions.
> 
> Moreover, SPEED_xxx is an already taken namespace and part of the UAPI,
> and thus can _not_ be changed. Convention is that SPEED_x will be
> defined as the numeric speed.
>

Well yes that is the idea of having the enum to count them and then redefining
them to the correct value. (wasn't trying to introduce new define for
the speed and trying to assign incremental values)

Any idea how to handle this without the enum - redefine thing?

Was trying to find a more automated way than defining the raw number of
the current modes. (but maybe this is not that bad? since on adding more
modes, other values has to be changed so it would be just another value
to document in the comment)

-- 
	Ansuel
